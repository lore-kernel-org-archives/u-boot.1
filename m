Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8670AD12663
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 18:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A8E83EEF;
	Tue,  2 Dec 2025 19:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="izLODM8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B09C683F15; Tue,  2 Dec 2025 19:49:13 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEC083C64
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 19:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 1c14e97b-cfb0-11f0-9e68-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 1c14e97b-cfb0-11f0-9e68-005056994fde;
 Tue, 02 Dec 2025 19:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=TxI5+lbNgtAeehlOE8aSpcF7UIzVgn/atCbv2A2+YQ4=;
 b=izLODM8Akpq4C/fj45K4msjmJmLfj7f3Tl/VCWTyiWD6zDzYqXG60cXor8hqZoEI2t5pYr+ET3aI4
 obV1u8JD7bOaE6DZyqfwyXAzkKRqcGCl079mXxUTRN+u6uUF3Re8sU7BmzQlgn2X24Wdv1CmboyzIL
 Zpkb+LV6uufYwupnBf5mB1mxnZhenBTYWmfuT/HM9tDs7a2XBKQooaJpmd9sqvnzHeXupTqO5klSW8
 Y90waN4AuU+ZBQN1t7njzwuHO4gxfFU2IIANtLg80z5OvRQVRkIXnWYdZ5JPi/slISH/XYEsEds0mE
 AAiCVIzDGeOYt9J32M6kGL/YZCBUT8g==
X-KPN-MID: 33|csYN40zTHNFcAPoAXaFy8FSMEpw7Nz0GBsLpnjoH9jorMeNPY4sghakUQVjBBko
 QsjDSre2u0vwnQRCZW7lmKw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|tB4Zie01os8uoQodafRU+VSUEg6Rev4uFe+vdsVaMiFUcf0ZiFLUKCCMVQnql1r
 05/fBqiZz0fmvMRmM/nGMyA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 95510d22-cfaf-11f0-86c7-005056998788;
 Tue, 02 Dec 2025 19:49:08 +0100 (CET)
Date: Tue, 02 Dec 2025 19:49:07 +0100
Message-Id: <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
In-Reply-To: <20251202182403.GF303283@bill-the-cat> (message from Tom Rini on
 Tue, 2 Dec 2025 12:24:03 -0600)
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
References: <20251202182403.GF303283@bill-the-cat>
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

> Date: Tue, 2 Dec 2025 12:24:03 -0600
> From: Tom Rini <trini@konsulko.com>

Hi Tom,

> Hey all,
> 
> I am wondering if at this point in time, anyone still builds our host
> tools (fw_printenv / fw_getenv, a few others) to run on macOS or
> Windows, natively.
> 
> I ask for two reasons. The first of which is that a reason we still have
> to support Azure (despite its slowness) for CI is it's where we have
> macOS and Windows hosts. But at this point in time there's so many ways
> to have Linux userspace running on Windows or macOS that I don't know
> that there's any value to these builds.
> 
> The second reason is more macOS specific and is that with:
> 
> commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
> Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Date:   Thu Nov 13 12:54:51 2025 +0100
> 
>     boot: Assure FDT is always at 8-byte aligned address
>     
>     The fitImage may contain FDT at 4-byte aligned address, because alignment
>     of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
>     8-byte aligned address. Make sure that the DTs embedded in fitImages are
>     always used from 8-byte aligned addresses. In case the DT is decompressed,
>     make sure the target buffer is 8-byte aligned. In case the DT is only
>     loaded, make sure the target buffer is 8-byte aligned too.
>     
>     Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Which does things we must do, we now don't build on macOS. Why? As best
> I can tell (and for a general purpose OS, is a good call), memalign(..)
> doesn't exist and you need to use posix_memalign, a not drop-in
> replacement. We could spend some time reworking the code here for that,
> but for now I've instead gone with this workaround so that CI can
> continue:
> https://lore.kernel.org/u-boot/20251202162250.2613085-1-trini@konsulko.com/

Are you sure about this?

The code in boot/image-fdt.c is part of U-Boot itself, not the host
tools.  As such it should be irrelevant whether the host OS provides
memalign() or not; U-Boot provides its own implementation.

OpenBSD doesn't have memalign() either.  But I can still build the
targets I care about on OpenBSD.

Or is this about sandbox?  Did sandbox ever work on macOS?

> But longer term, unless people say they need and use these tools, I'm
> inclined to remove them from CI and remove this workaround, for the
> v2026.04 release.
> 
> -- 
> Tom
> 
> [2:application/pgp-signature Show Save:signature.asc (228B)]
> 
