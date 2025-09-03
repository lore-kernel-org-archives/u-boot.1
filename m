Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8116CCA1007
	for <u-boot@archiver.kernel.org>; Wed,  3 Sep 2025 04:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1ED983420;
	Wed,  3 Sep 2025 06:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mFpPZ5Gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6122783AB2; Wed,  3 Sep 2025 06:34:35 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 275F683403
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 06:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 77C703F284
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 04:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756874072;
 bh=h4WMGu2VPb7retWkUV48e/gOa0qGcoWPwLuhS5jw9S8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=mFpPZ5Gk60zMreAGaZLxirgK/5YTOVZypLdMFYm8APkfF456tahkVNV9j9di3tmvw
 +DeymkWnMO/+Qg9jgvCOgwaI0h0c0B7JlSeLpDWf2+PS5jDzkBPDsi6ar90Ztrsftl
 nVigPSiXUzm1rGlzsMC7moLm112LtNAIW9F5WzT+GS0haZqYNz5IKLgCotOXwuNv8e
 3lzSUwZjvNZbTN6rTbWACdRjWB9vVQW6OQ2aBzQrO5cyYEWg3MHB83NWOx+AOpuMyu
 Pm3JKDlCoJfW+XsL87sTpJYHPPS8Q8010tieQa3avD6xU4zjANkfOaa0WeuD73WbLk
 +3LJ8jCSObO8w==
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24ae30bd2d0so24959805ad.3
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 21:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756874071; x=1757478871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h4WMGu2VPb7retWkUV48e/gOa0qGcoWPwLuhS5jw9S8=;
 b=eub77z5mGjmuzaH0NjiHbDUoHuhgF5Lkyw1+7MsAq8kNa8NEOWEqvzxdeHThT85QkU
 SICVkpJkzMwvbDC5jNH46zVDjiIMfeN7axByqr6H6VOMGrjS0ydn8CBdIBIAAiv34LFs
 lf4aYC4uFQd1oBwX7tEMhjBiVSfF8nx1yBSXP3X01+28q3lV8HlM5tiaG+WVhevPGpN/
 KQH7R9ibEHAV4UrzAHDGBDJHCGXeok+HOV6n5eVnc37HWWTHF+TFwMyOYwXWVaF6FlHE
 WyH+LT4P1wvaprlSJzKSCtvjYXRgq7NKY55pcOzhDOAbNUp3oR9bxVtMgL67TslOJDLi
 WnYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpOjiaK/cO/ytsENv0f7VtVbm2EytQpK7o2RS6uPFI25P9K+u4nC58iCjPHz2BVJTXGEMTEqg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6+oCLUVziObMuGysl7vGpvpe2K5mCzT/OI0Wt6dO3iWXTcymE
 rESm1wTjvVSP8BaNxslK+eA3isDP3B2IEKRCjaR2stfbUfgRHM6tmCfnmTiQi3xj+XBmSdpkIiD
 oSUOXbY87SmFdsw1nXOEEEMf5jzmUmssQQqTyrykau5IYg9Hd6FUvNgxlfl0OJ2UkEQ2CLuP4VJ
 xilJ6rxyPUZMDrAYTrt4JA3/hC5AcROGRRlMIN/XZ8jkN4ow==
X-Gm-Gg: ASbGnctOudxpBtA2YsrwAj7/i8/OOVdMUmMJaZwxFHdDgE2s1hpCb/HwUOT/iZGMrlc
 p/gut5bxqhBNFvMsgbnzLPV5K4eHmPCvaKJh/zSrwsrAUd51TVbTxd0yE5NyC0jbjm6OgKF0yS9
 iv7muw3y+lEUQ86jm2ug==
X-Received: by 2002:a17:903:2450:b0:24c:786a:d7ac with SMTP id
 d9443c01a7336-24c786adf5cmr34814725ad.47.1756874071026; 
 Tue, 02 Sep 2025 21:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB5bntVmWTeh/oD+j6g1+imjc6Io+xOdLbQEpaYVhtcDHOEELDfIch0qwW5gVx4VeVOrJ9DWcJJSEbG+eRIzU=
X-Received: by 2002:a17:903:2450:b0:24c:786a:d7ac with SMTP id
 d9443c01a7336-24c786adf5cmr34814375ad.47.1756874070517; Tue, 02 Sep 2025
 21:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-11-hal.feng@starfivetech.com>
 <52aad19a-0188-4bba-9f06-a0d7d6ff0c38@freeshell.de>
In-Reply-To: <52aad19a-0188-4bba-9f06-a0d7d6ff0c38@freeshell.de>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Wed, 3 Sep 2025 06:34:19 +0200
X-Gm-Features: Ac12FXyO3ApZLtwZOKmtVXbAiR46-eaX5CTJuqevdt4Au46X-nb4XE1nYfJciMo
Message-ID: <CAM=mAOkhWah9S95FdWjkD416gMp=5R5RsMK44ViPU4ebs6Wrxg@mail.gmail.com>
Subject: Re: [RFC 10/10] board: starfive: visionfive2: Add VisionFive 2 Lite
 fdt selection
To: E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

E Shattow <e@freeshell.de> schrieb am Mi., 3. Sept. 2025, 02:26:

>
>
> On 8/28/25 23:09, Hal Feng wrote:
> > Set $fdtfile to the VisionFive 2 Lite DTB if the board is matched.
> >
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  board/starfive/visionfive2/starfive_visionfive2.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/board/starfive/visionfive2/starfive_visionfive2.c
> b/board/starfive/visionfive2/starfive_visionfive2.c
> > index f38433e94ac..912e8cb967a 100644
> > --- a/board/starfive/visionfive2/starfive_visionfive2.c
> > +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> > @@ -65,6 +65,8 @@ static void set_fdtfile(void)
> >       } else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
> >                  !strncmp(get_product_id_from_eeprom(), "VF7110b", 7)) {
> >               fdtfile =
> "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
> > +     } else if (!strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
> > +             fdtfile =
> "starfive/jh7110s-starfive-visionfive-2-lite.dtb";
> >       } else {
> >               log_err("Unknown product\n");
> >               return;
>
> I continue to think it is silly we are setting $fdtfile env variable
> past the moment since adopting OF_UPSTREAM. That is a discussion for
> somewhere else, however.
>

Do not expect an old kernel to boot with a newer dtb. Linux broke such
expectations repeatedly.

Do not assume that users upgrade U-Boot to keep it in sync with the kernel
they use.

Debian/Ubuntu packages flash-kernel and u-boot-menu rely on $fdtfile being
present.

Best regards

Heinrich


> Anyhow the sorting is correct and new code follows the existing code
> pattern.
>
> Reviewed-by: E Shattow <e@freeshell.de>
>
