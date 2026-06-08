Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54842CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:34:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3FB8495E;
	Mon,  8 Jun 2026 15:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="apL62HVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E33C5841C2; Mon,  8 Jun 2026 15:14:26 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D4683EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.fardjoume@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so571371466b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780924464; cv=none;
 d=google.com; s=arc-20240605;
 b=Xg6W7wP2gSChoZeXW+AWlwTR4USQrbjQtdV7SOOHEu363YYBv/T8wiPuDGWTjM/mha
 Wmg5pAT5clwaTzNedk1hoBTAzLoaL8nvs+etT/3ECDWb+r/mK4tvV+cR94uV8Qne/y2I
 WpWSjApJBQu4L3+qnOrQBsMWB0DTfAqt0G90sO3SNIpISmraO5F/lCSjjQqjwxsZTAAp
 miVHycyCHF6UbjhsUjlUdIla7Oo63Ic8uyeYcrUjaaUpycwt6sFYNe9e3sluTFpRSReR
 WRMx5r6ZTSSIZCvyMIt/juQOSSKRPspZwFOv3cNUXSyww9xXldCmIxofyjO19Ff5fxjX
 wVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qNyxLOZNUqaGsrGngV80n8JuMLjZVruQGtnB6zvgUkc=;
 fh=NhY5U+NOsRkTUZLlwWNZWxvelxXTVQbxlX52uWlYwlY=;
 b=cc+lj9DydP94IyAX/gj2RcX8nBf30zdMbffIoxvs+PJRzCbhQ09ywwWsmc0twzV92M
 sMok6VF0dSAWS3fsQuernrch+jnlrxf3hkwrmVZTmTGdjx9EYS0h6e/Eedd+7RLmQNrN
 cY8WJYreNYj+k/eNTJdvaFMpDt9qo/SaGNR201Xw3vqWJgS1zB6lxruEyArpDBJDEYla
 GsUaZyZj5ORhkon4vWjy7rQ8ZtN9W7CFVc8WpmCxvgzxFePINwpKKm8P7aVIfd7aDBbx
 4Q/sCWxwUO1AbpCFPOeNkt76shxRy7g0i+MQ768MhWY4GXlq0jbjmi2xLXEAXEV8//zr
 tCVg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780924464; x=1781529264; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qNyxLOZNUqaGsrGngV80n8JuMLjZVruQGtnB6zvgUkc=;
 b=apL62HVeD9ooZjhmz4fzh7Oijk+9+FQR7vXYEATjAWiwm2tN6ZaCnTF+hxTMYOO/QH
 eTnaLHlpNVkAmwQS8asiRES7WOYW7DiALmiYNYDmcTcgrivZiEGP/HMxkZf5NF/+XnfK
 tD5p/sKzWTPLK2DVBAlYNP03ohY/waCknSC5z1dYJlhhtuptLVu8xWRh1tuP8abyQHcz
 OAOVvLmVy39PFJRbI8bHs6AOHPSNrnA0ahWIUeVGj8N+84SVX7bcmXPyIjQjVeLm+0C2
 5lFM0NSm3qkHxZ6RSp8vAuYsMcu09vD6V/k0QlCgTqZqMHH2FAn1C+cwVPXvhHoTXf1j
 flEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780924464; x=1781529264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNyxLOZNUqaGsrGngV80n8JuMLjZVruQGtnB6zvgUkc=;
 b=iFWbhbE5yqNXw+xldAuCBmjol5IJIqjG12Qy0NzWZyF3YGmH6rPBfzwj1omOKyG1V4
 R2KSSPQBqCqx1ZsyU3R79yCspX2PLBfhtUpVYFxjViSViuyxYLZWk7u0bWOYZv7J8Nlc
 5ROdRouP/NDn2XRcLVEXII2WLuCyjdoEYIynhS+fy6V6vGu2tzEsMEbLDwWBvxxGGH1M
 YTPb95pDynPFxg3ubunNC0+CrKv4U89NHVhQMT9MZGkoTkqtIgJ60bM+TA5/E9Y9Xoey
 O7HEbcJflUGlQGJEuHJmu6cfAHeLuhRJli511gO1DET191vOTJY9P0XZkpnV/obj/CYf
 nRBw==
X-Gm-Message-State: AOJu0Yw/AdrYDmpYHAMOjbh7SCux5NjG+ZR5R1s6I47pCRiDwv5ZmZE2
 z/Qk87uycJh6w6P/YD9vmtRH3goMVokKuSfR9UFo5SEIhkM2OaT+GHb3fTpF/Iit8WeK5tL7qTG
 6GklE0IQnqOmC6ReRcC9LudDwuD5K2JE=
X-Gm-Gg: Acq92OEG4vWdgPOSPPQT987ct07Q5JZDV6c5A+wPmd9iCp+xanN1B/dk+qh6C0O2unp
 tRQvqhqlV9ucBsXYgdn1eEEZzbzs57KFxgrQUv43IG7KGZp0wN1W3lC2eFyp/Zm72HzRV/ZNaET
 2C5LAy5jbWABE/Ginga8z+IrGt/t3GQt8eiisV85GM+o1J+efCdv96G8O4+pIopS+IsYbhW2PFB
 DDPHZ/S03/m7opK0y6dtCfhrxRiqotjxH3ZT0Pvwglk+svzJbrvcE0yH9l8c/PNYsGXCtNI6KeP
 sXVWuOximzjba0K2Rps=
X-Received: by 2002:a17:907:d093:b0:bdb:4cf3:7035 with SMTP id
 a640c23a62f3a-bf36fd9e51dmr724386166b.4.1780924463952; Mon, 08 Jun 2026
 06:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAM+fx6Ny0ncWr=6nxTWpy_VpaRj-R4pkU_fNcVEdK-B35O4GSg@mail.gmail.com>
 <325826f8-659c-4237-a55a-6027d2297aa2@arm.com>
In-Reply-To: <325826f8-659c-4237-a55a-6027d2297aa2@arm.com>
From: Omar Ivan Fardjoume <ivan.fardjoume@gmail.com>
Date: Mon, 8 Jun 2026 10:14:39 -0300
X-Gm-Features: AVVi8CdbbJ7Cu4kTVhGbGDUALQBrVgWy8U2tTIWezIkU2Zaru7_QuIZfzP5mD1k
Message-ID: <CAM+fx6PSzgE51YrUVghgfcE2Tv9hWDLROY7+3a472BQJS=TPtg@mail.gmail.com>
Subject: Re: PATCH mmc: sunxi: fix MACH_SUN9I typo in get_mclk_offset()
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:33:31 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

>
> Hi Andre,
>
> Thanks for the review and for offering to fix up the patch formatting =E2=
=80=94
> much appreciated. And also thanks for working on Ethernet for the A80
> boards =E2=80=94 I'd be happy to test those patches once you post them.
>
> Regarding the 8-bit bus width condition, I agree that an exclusion-based
> approach (!SUN4I && !SUN5I && !SUN6I && !SUN7I) seems cleaner long-term
> than having to add every newer SoC to an allow-list.
>
> For the get_mclk_offset() issue, I also grep'ed the tree and confirmed
> that CONFIG_MACH_SUN9I_A80 only appears in that location, which was
> actually what caught my attention while investigating why my eMMC was not
> working.
>
> Regarding eMMC boot partitions, I haven't tested them. My setup currently
> boots from the regular eMMC user area. I'm not building a complete
> distribution from scratch; I'm using JohanG's Debian Bookworm images and
> U-Boot as a base while working on restoring functionality on the
> Cubieboard4 A80. Debian Bookworm is currently running reliably on my boar=
d
> after applying several device tree (DTS) fixes and additions.
>
> So far I have:
>
>    -
>
>    eMMC boot without any SD card present.
>    -
>
>    all four USB Type-A ports.
>    -
>
>    AP6330 WiFi.
>    -
>
>    Ethernet (already working from JohanG's images).
>
> The two fixes I posted were required to get reliable eMMC boot on my
> board. Before fixing them, MMC2 was effectively unusable during boot. Aft=
er
> applying both changes, SPL successfully loads U-Boot proper from eMMC and
> Debian 12 boots normally without an SD card installed. At least until you
> run apt upgrade, the kernel changes, and it refuses to boot again =E2=80=
=94 which
> I suppose is the next mystery waiting to be solved.
>
> For my convenience, I use a script that clones the running Debian
> installation from SD to eMMC and installs U-Boot there. Since this setup
> uses the normal eMMC user area and I am currently using JohanG's pre-buil=
t
> U-Boot binaries, I have not had a need for CONFIG_SUPPORT_EMMC_BOOT in my
> workflow. However, if support for the dedicated eMMC boot partitions is
> considered useful for future users, enabling it in the defconfig sounds
> reasonable to me.
>
> I have documented the process and supporting scripts in a public
> repository in case it is useful for anyone else trying to keep A80 boards
> alive.
>
> If useful, I'd also be happy to test future A80-related patches on real
> hardware. There do not seem to be many active A80 users left, so I'm glad
> to help with testing whenever needed.
>
> Thanks again for taking the time to review and test the fixes.
>
> Best regards,
>
> Omar Ivan Fardjoume
>
