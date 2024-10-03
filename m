Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C3BCF856F
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 09:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1F2C88DE9;
	Thu,  3 Oct 2024 11:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=martyn.welch@collabora.com header.b="GAY2rkBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FDC788C24; Thu,  3 Oct 2024 11:00:44 +0200 (CEST)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53C48913A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 11:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727946038; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=d348+46b/zBWaAlF2J97m5Ydgdo5lrO8tMSJtr+55T7leugrkxVKCwcNE/fOLZDzlFLGcSZs1wzRIN15Djk4paHHQxohlQqWwvr1GBxabGQPsejKrbnnfv1/+1KH/FsXfzO9fzzHAgcUPSldB0xHdQpk+rnyL8HN8HtNSVObCK8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1727946038;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RGrTrwomjTiA4Y2yZjWUt2iiFXVrxY3USqiWNZZJJLs=; 
 b=P2vQxBTze/xFu3fjsK+QANI7CrgjfBlelcg5uXiNEdShsvQ7rXnN0gysGontMbgryrBaQWms9oyqOvcpNj8LHcEuipvUdlsE+hvR+lvVjFldwtUn5L+iGLdr6biAAvABMFQ/Cc/Jt+6qej/Sn/sWbmuPEjydQ4CXBL5PM4vQijg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=martyn.welch@collabora.com;
 dmarc=pass header.from=<martyn.welch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727946038; 
 s=zohomail; d=collabora.com; i=martyn.welch@collabora.com;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=RGrTrwomjTiA4Y2yZjWUt2iiFXVrxY3USqiWNZZJJLs=;
 b=GAY2rkBzf49kI2MqVzssT/ozGP/4tYwCehqvTwUX2r+iAN4LxfssLLwJ92Knk0ga
 fDpX0Ga3Qw50TISZKSlhnkp1m4kBiecFciFHDpixwBnm0Ns+a/yxxDBcw85mTETQK1i
 NU3gVZUfX9KP1n4zc/GST8WSZfxw66VHEgGHvkVQ=
Received: by mx.zohomail.com with SMTPS id 1727946036414323.6711960714299;
 Thu, 3 Oct 2024 02:00:36 -0700 (PDT)
Message-ID: <1024259d3b2e3ed5d6828c12bac32630e2361c04.camel@collabora.com>
Subject: Re: [PATCH 1/4] boot: pxe_utils: Add fallback support
From: Martyn Welch <martyn.welch@collabora.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Date: Thu, 03 Oct 2024 10:00:33 +0100
In-Reply-To: <20241002191638.GQ4737@bill-the-cat>
References: <20241002132633.246942-1-martyn.welch@collabora.com>
 <20241002191638.GQ4737@bill-the-cat>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1+b1 
MIME-Version: 1.0
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, 2024-10-02 at 13:16 -0600, Tom Rini wrote:
> On Wed, Oct 02, 2024 at 02:26:30PM +0100, Martyn Welch wrote:
> > When configured correctly, we can detect when boot fails after the
> > boot
> > process has been handed over to the kernel through the use of U-
> > Boot's
> > bootcount support. In some instances, such as when we are
> > performing
> > atomic updates via a system such as OSTree, it is desirable to
> > provide a
> > fallback option so that we can return to a previous (hopefully
> > working)
> > state.
> >=20
> > Add a "fallback" option to the supported extlinux configuration
> > options
> > that points to a label like "default" so that we can utilise this
> > in
> > later commits.
> >=20
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>=20
> Is "fallback" part of the nominal extlinux specification?
>=20

When looking at options to implement this functionality, I did spend
some time looking for an extlinux specification. The best I could find
was:

https://wiki.syslinux.org/wiki/index.php

Putting aside the difference in syntax from that used by the syslinux
project, of the 22 keywords currently supported by U-Boot, only 13 of
them are mentioned there (surprisingly the syslinux documentation
doesn't include "title" as an option).

I'd come to the conclusion that U-Boot already provides a greatly
extended version of the syntax, made suitable for booting in a wider
variety of instances than catered for by the syslinux project.

Though I admit, I could have missed another better source to
documentation. Is that the one you're thinking of or is there a better
one?

Martyn
