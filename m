Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FD2C46CD3
	for <u-boot@archiver.kernel.org>; Sun, 24 Dec 2023 19:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C80ED8747A;
	Sun, 24 Dec 2023 20:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="g3iqbirc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADEF876D3; Sun, 24 Dec 2023 20:49:55 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8DE86F28
 for <u-boot@lists.denx.de>; Sun, 24 Dec 2023 20:49:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 8e18fa47-a295-11ee-90ec-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 8e18fa47-a295-11ee-90ec-00505699b430;
 Sun, 24 Dec 2023 20:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=O2pW5yB6pFUJxcfXq/VNcEbb8AT+/89bhEC+IuQesT0=;
 b=g3iqbircEatiNESYaC8A5mOekzrWWYFkcooAyB7Cjccnsy6/D9Hx77iS7kJNq/wAcUptWItm8QkH1
 ucafHeh5+c3xebvPNUJB/bQfcRwr5ExinqpsBfAxu09WT18Pu81H9QK5LPu3DhdGnCXLkwIitESUsM
 DVr0+JgJd1d8uwiretrVkXZHa9xKr5oas/PWltxGj5qgG4ydYYcIAPMqUbcbfJfUXT+aiqDJwDhYPx
 MTU4xQO+BVjxcSPbWOgfouar1X/C+w06HYbf/j5RBbrPmfurezdZVvuajXT8wxm3MtBnWODIdsix96
 y5w8SkqCATyQiJ/xSl/CaKr1fiCZOAw==
X-KPN-MID: 33|sX8WWPjf1AW1Uo3cmtlM6sh3+RDAqT36TvAeBWdwGPCElINl9aT5LSrBz0ETJnT
 5q8K1oRQndJ92VHZJRKsTxSDEwHApmMmzmxhPRdmrC+o=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ExL4Y6AwjDud6wiENRIosexMEYryCbtP3VwTT0sG3yE5PWFLYSlAneR6NqE1mXl
 hBFbOoFPvmyGYtAcwIMfraQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 9a4f8266-a295-11ee-ad2d-005056998788;
 Sun, 24 Dec 2023 20:49:52 +0100 (CET)
Date: Sun, 24 Dec 2023 20:49:51 +0100
Message-Id: <8734vrnzxc.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: kettenis@openbsd.org, sjg@chromium.org, bmeng.cn@gmail.com,
 trini@konsulko.com, u-boot@lists.denx.de
In-Reply-To: <7a95fe4c-1155-4c47-9dfd-9efe8b2365c2@gmx.de> (message from
 Heinrich Schuchardt on Sun, 24 Dec 2023 20:37:47 +0100)
Subject: Re: [PATCH] arm: apple: Disable SMBIOS again
References: <20231224181255.4954-1-kettenis@openbsd.org>
 <7a95fe4c-1155-4c47-9dfd-9efe8b2365c2@gmx.de>
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

> Date: Sun, 24 Dec 2023 20:37:47 +0100
> From: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> On 12/24/23 19:12, Mark Kettenis wrote:
> > Apple machines do not have memory below 4G.  Since U-Boot does
> > not support the SMBIOS 3 header structures this means we can't
> > support SMBIOS on these machines.  Unfortunately the refactoring
> > of the SMBIOS code this cycle accidentally enabled it again.
> >
> > Fixes: 53fab13a7b1 ("efi: Use the installed SMBIOS tables")
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> 
> My understanding this is for origin/master. For next we have pending
> patches from Simon to move to SMBIOS 3.

Right.  Without this fix EFI boot will fail on U-Boot 2024.01.  And
that is 99% of the users.

When the SMBIOS 3 patches land, I intend to turn this back on again
(after making sure the tables are populated with the appropriate
information).

> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> > ---
> >   configs/apple_m1_defconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/configs/apple_m1_defconfig b/configs/apple_m1_defconfig
> > index d58a9030db..b868d0e319 100644
> > --- a/configs/apple_m1_defconfig
> > +++ b/configs/apple_m1_defconfig
> > @@ -21,5 +21,5 @@ CONFIG_USB_KEYBOARD=y
> >   CONFIG_SYS_WHITE_ON_BLACK=y
> >   CONFIG_NO_FB_CLEAR=y
> >   CONFIG_VIDEO_SIMPLE=y
> > -# CONFIG_GENERATE_SMBIOS_TABLE is not set
> > +# CONFIG_SMBIOS is not set
> >   CONFIG_LMB_MAX_REGIONS=64
> 
> 
