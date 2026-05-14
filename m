Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03305CD4F25
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293858466F;
	Thu, 14 May 2026 19:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="J8GQ2H9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC6938469A; Thu, 14 May 2026 17:37:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3EA5084690
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 17:37:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA7C7165C;
 Thu, 14 May 2026 08:37:24 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 119823F836;
 Thu, 14 May 2026 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778773049; bh=sCKgsjBGhHWgEBoK/vpF31bYTTgispDUZ0UTeEyIfHA=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
 b=J8GQ2H9DfBqSTCRO6xHBrTbqQdZKOpBSr5pQk95rYEz52+MYyk4LvG80EBBrrd6Py
 cDQnFinoUfL382MiDti7dmcHQTz3xmV1C+0QFFeYO2mQCKGVT9jtpr58itj38qJP4I
 kSsxB6RUt1x4YUoZ5X0pk/649WG/0ZpJ0BW9f078=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [00/12] arm64: FF-A runtime transport for EFI variables
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: harsimransingh.tungal@arm.com, u-boot@lists.denx.de
In-Reply-To: <CAFLszTiY1HHER7fbGz+0BwDBGcfG7Kkp29641rvWOv7DyD_scg@mail.gmail.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <CAFLszTiY1HHER7fbGz+0BwDBGcfG7Kkp29641rvWOv7DyD_scg@mail.gmail.com>
Date: Thu, 14 May 2026 16:37:23 +0100
Message-Id: <177877304327.2444524.10919676649935386355.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 14 May 2026 19:13:12 +0200
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

On 2026-04-28 12:16 -0600, Simon Glass wrote:
> Hi Harsimran,
> 
> On 2026-04-24T17:31:50, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
> 
> > efi_loader: align FF-A cache maintenance with runtime path
> 
> Patch 12 changes the boot-time path to match the runtime path, but
> sits at the end of the series. Between patch 3 (which introduces the
> runtime cache pattern) and patch 12 the two paths are deliberately
> inconsistent. I'd prefer this alignment before patch 3, so patch 3
> simply adopts the established pattern. It would also make the
> rationale in patch 12's commit message read more naturally. What do
> you think?
> 
> Regards,
> Simon
> 

In v2, patch 12 is no longer required as ffa_mm_communicate() handles
both boot time and runtime capabilities. Patch 12 is eventually dropped
from v2. Patch 3 of v2 is now taking care of cache related changes.
Link to v2: https://lore.kernel.org/u-boot/20260514124924.1804332-1-harsimransingh.tungal@arm.com/

Regards
Harsimran Singh Tungal

