Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B542FC3600B
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 02:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481A881E06;
	Fri, 28 Mar 2025 03:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="lP2GnU7Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1C4806FC; Thu, 27 Mar 2025 18:08:35 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45345805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 18:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=nicolas.frattaroli@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1743095307; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Jt41UppwR8uWc2YJjCNAw5dUqrdOd6rTCk5IgBxJSZilS9YlahOwQRoPr3DmRssjOyFSfp12ZdEnDSR/5Wnrfnvl5jqJ7iyuDqKvvR92yX1XiHAOqtWEG36USs2r9dfv6kxP0MfEdScBTJwoZ7egrRJNLEtk/41m+Rjj/Bddt3M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1743095307;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lWGgzm3fUwyMCf03ElkuQQACQVIutsvC0g3ceZVrQ+A=; 
 b=Rr1Hjg6oxYKzIdS7VfHJmmlkxN0kwisDfnLIyV3P1RpWT6fPPzhJq4tt6/QNb3jcQDx9Lnl+Q9F0A31TwdYDVwGH5Q1cUy4HcXGmQ0l1dLmLqHyql3mtAJVyTmlanjfFOf/zKBRpHzGugY/QhHZIgSj4zwsSUFwLrZJ7OjpKuwQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743095306; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=lWGgzm3fUwyMCf03ElkuQQACQVIutsvC0g3ceZVrQ+A=;
 b=lP2GnU7Q5UDAtvYx850Nzna6j7kcVvh4VDOQkhqXS045QlZzkk3ijxj7VxBHmnOE
 bDbVN1cywnZeSuHVYzjsWnPTMvEQECkW5cnQYdpFxHpouOfdDli7BkO4HRpb+QQVaFd
 3I6KzKBVrClAWrVMw3uBRqhKdKpqceQeYJGSRFxI=
Received: by mx.zohomail.com with SMTPS id 1743095304831295.29546845665504;
 Thu, 27 Mar 2025 10:08:24 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
Date: Thu, 27 Mar 2025 18:08:20 +0100
Message-ID: <13345767.O9o76ZdvQC@workhorse>
In-Reply-To: <20250226184506.64114-1-sebastian.reichel@collabora.com>
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Fri, 28 Mar 2025 03:20:27 +0100
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

On Wednesday, 26 February 2025 19:44:43 Central European Standard Time 
Sebastian Reichel wrote:
> Hi,
> 
> I have a couple of fixes/improvements for the TCPM code. Three are fixing
> actual problems I noticed on the Rock 5B, which prevented booting up the
> system. One of them simply adds an error print before potentially committing
> hara-kiri by triggering a hard reset, which helps people understanding why
> their boards reset themself in case there are more problems. I've recently
> added the same print to the kernel TCPM code.
> 
> Changes since PATCHv1:
>  *
> https://lore.kernel.org/u-boot/20241031175404.114773-5-sebastian.reichel@co
> llabora.com/ * rebased to v2025.04-rc3 (no changes needed)
> 
> Greetings,
> 
> -- Sebastian
> 
> Sebastian Reichel (4):
>   usb: tcpm: improve handling of some power-supplies
>   usb: tcpm: avoid resets for missing source capability messages
>   usb: tcpm: print error on hard reset
>   usb: tcpm: improve data role mismatch error recovery
> 
>  drivers/usb/tcpm/tcpm-internal.h |  1 +
>  drivers/usb/tcpm/tcpm.c          | 95 ++++++++++++++++++++++++++++----
>  2 files changed, 85 insertions(+), 11 deletions(-)

Tested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Used this series on our 2025.04-rc2-based Sige5 tree. Resolves a problem I've 
observed with PD supplies where the board may bootloop within u-boot. Tested 
with various USB-C PD sources and cables, all of which worked.

Thanks,
Nicolas Frattaroli


