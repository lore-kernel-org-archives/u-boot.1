Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C322F483D7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0E8183FDC;
	Mon, 23 Mar 2026 20:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VL69pAkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23545840B5; Mon, 23 Mar 2026 20:46:55 +0100 (CET)
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862968366F
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:46:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-127380532eeso821220c88.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774295211; cv=none;
 d=google.com; s=arc-20240605;
 b=bdmblwMk2CzQpjhZtA8fdgjkh5rP77usqJDT2oYe2k2ZQRVvD+JNHL/m5cyhl8Zr6s
 nVbc4IJHjKlznaLy1Eu0qIZdvFk71qdcqIkIIPom7/SYtLfWVOD9yFGrnz758kXyRLck
 xbvkY5cxwQppDbiN+NidCwilzt0f7UpaBzdttYOuLYo7btLsJV9IQJw6cdHB3v7R5++r
 Cn1jKf5cehsfRqLWNb1hhv+f+VXA/VX/M1okiR+/lQhOh62d74C+GAI4orul1gSoEAS2
 pykx8wos+rmQo5NdL+2jWFt9nNyfr1Lcy1n4AKFOE6rcaX1zcf6W731QPa6B78SitXP9
 xnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j5XfsyVD+dPicK8p0Z4b3pizev7FDrtXHjNf0bT3S00=;
 fh=JoXfqjs+Dm4oq32Q7AOqYgnE3Sa0jNFF+6nYghQhqMY=;
 b=TY+U14VtKKASOLHHRhocGK7no5Spy5bh98Kb889S2CcN7Ml/UnvMoJFjahnfc3ktGr
 D7CFYo6WGSTxizI0YVE9XwpPwqJKNETxQjvX9HMQLgqEmToNHwY0Gw7S6evMiYAwOlF5
 l1So75Nv+gOk1/Bfs0mB/y11mf3LBSx2ihBQUYQO3/84dLjBjXT0kwOqPerWlC08x8va
 JCMr2Nc1LEdBbKEBMEToIt8krrlw8DC4U7kAY/dyZ8v8GhjrG/oz6PWB5Id0GkcUpdqs
 khRbU9Jb1MSLyOU3/Vg4ooRFLh3SXiVtq550i3UDfUCbu0qUmLVb1PujCvxMF813Ilwo
 AN+g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774295211; x=1774900011; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5XfsyVD+dPicK8p0Z4b3pizev7FDrtXHjNf0bT3S00=;
 b=VL69pAkdtyWInMmVelWvlfQVhjpI3ia+TGrGMoh+cdZ893TfMQrYZoXmN0mEGpGRp2
 Lr95VOh/p5YIZeB3qzTOONfe/kRkwI2tAkuhHSjiF6taqTvMdFL0bGzBSbmPueawdPJF
 9ILB/baThb3/lOK/8cVnvrFqh5xX93T87dtXLzHlC9kMBt+ZNy+tI54WLq3+93tbOCU+
 IIfFiwPlYuoxp+ADOQPhpbcYtVpGlPpC4Kjc3la/yghzS64wfS2kVFFM0lelhETVv8RA
 0IFMz/e6sFUWizCeDRpyJ8Zd4bPZ1pqoXSTmYVxWyq+3Vda9bAqSLx2n8qOvigKuQp55
 38Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295211; x=1774900011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j5XfsyVD+dPicK8p0Z4b3pizev7FDrtXHjNf0bT3S00=;
 b=ogfAuLtz9pNDH3E0/fkeOZxhQHgXjPogD+8PkzHDjV5WWC3ljsaqa07PxOWi43BJsp
 epU7D/B9WFyU/uzO2yrCweS3zMZzLFktlSFccI6bxY6KNBGAzhXyL1HQZFTYWCGV4kGd
 P31dHU4m2yOvAHUYnzCRk4a635FFyH1wpftp8dB4rE+pGxr1hKEHLXNnJBjn9EAh2H9w
 29/jjuhVR+AjYkJnRLMHeQ3KovA3MdnU+szA0LuUzgpGEYACSF7LTKA4yAlqPRGZUJG+
 du4YPi8C9xJZWZ4y751z31keptg4mjmpK279jaSgqaIstktQxtwfQWcfQC2XMal0kRkn
 vMKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwA1jY+U8rfLPZYPUDknyQzq4FWkFIGVP2bvDmX9GC9jNDXZgQTheTdVfswatjn75+vIEHVlQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxx6BZsvYmrBR2mV7h0/1/NXhndDGtoqvAnE5WKS1s0H9TplKwv
 sETTDtjlqV0fgMWIyS1mre76USVbW9UUYuwqcIY8msvqBjspOIPcnpLTDfwG8tV/ynVl1GPw+dH
 NXLezUwxum/0IvsPl078GFlOwcUh+BI8=
X-Gm-Gg: ATEYQzzQ2cttR6+1HEz3uwthh/CII4o5ycTnRkEiNtIZLdAsfIz5vySD8EqaJssCV8N
 SaUPZi/xk4XaRqY6xFXG+2G+6n5nAOz8o3O+fs0Wultz+Et8GE9IaxbvZayuxSmLwllmWE2xQ1R
 Jy1SeJbBXXpuy8iIxENY3D3oH50TCDABRmFV9VqLsypLBw8GwAIiOism92a2JJmeVJWC5WAlK2I
 1JM0xGN/XS/ZPn4YTYCod8MmdFC9xjYcbchXgb/wt56iB0Dm5OzVTQ2NPfxkw+ZJNXRqAN/iEaS
 +DVRNCKRsqzBy1b+Knlz9euY9b+5ROlU6uq9JRtB9Mkfu/1CQMS+Y2ObabdnZj2Ctq5BxPaQBjN
 GvTtVv+Yf7Gz3ajF/KO+zaqQVXbc=
X-Received: by 2002:a05:7022:459f:b0:12a:6fbb:3353 with SMTP id
 a92af1059eb24-12a72657171mr6389862c88.3.1774295210859; Mon, 23 Mar 2026
 12:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260317223800.776581-1-rs@ti.com>
 <20260317223800.776581-3-rs@ti.com>
 <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
In-Reply-To: <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Mon, 23 Mar 2026 14:46:23 -0500
X-Gm-Features: AaiRm52zJk5-IELSZx9Ou99ZXzVE2PTegR900stTQv-v0XsWxq8PjRjXN0g4c7Y
Message-ID: <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
To: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>
Cc: Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com, trini@konsulko.com,
 afd@ti.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 23, 2026 at 2:37=E2=80=AFPM Randolph Sapp <rs@ti.com> wrote:
>
> On Fri Mar 20, 2026 at 10:32 AM CDT, Robert Nelson wrote:
> >> > +++ b/configs/am62_pocketbeagle2_a53_defconfig
> >> > @@ -6,11 +6,11 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=3Dy
> >> >  CONFIG_SPL_LIBGENERIC_SUPPORT=3Dy
> >> >  CONFIG_NR_DRAM_BANKS=3D1
> >> >  CONFIG_SOC_K3_AM625=3Dy
> >> > -CONFIG_TARGET_AM625_A53_BEAGLEPLAY=3Dy
> >> > +CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2=3Dy
> >> >  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> >> >  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80b80000
> >> >  CONFIG_DM_GPIO=3Dy
> >> > -CONFIG_DEFAULT_DEVICE_TREE=3D"ti/k3-am625-beagleplay"
> >> > +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/k3-am62-pocketbeagle2"
> >> >  CONFIG_OF_LIBFDT_OVERLAY=3Dy
> >> >  CONFIG_DM_RESET=3Dy
> >> >  CONFIG_SPL_MMC=3Dy
> >> > @@ -44,8 +44,6 @@ CONFIG_SPL_I2C=3Dy
> >> >  CONFIG_SPL_DM_MAILBOX=3Dy
> >> >  CONFIG_SPL_POWER_DOMAIN=3Dy
> >> >  CONFIG_SPL_YMODEM_SUPPORT=3Dy
> >> > -CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
> >> > -CONFIG_CMD_NVEDIT_EFI=3Dy
> >> >  CONFIG_CMD_GPIO=3Dy
> >> >  CONFIG_CMD_GPIO_READ=3Dy
> >> >  CONFIG_CMD_I2C=3Dy
> >> > @@ -53,6 +51,7 @@ CONFIG_CMD_MMC=3Dy
> >> >  CONFIG_CMD_EFIDEBUG=3Dy
> >> >  CONFIG_CMD_PMIC=3Dy
> >> >  CONFIG_CMD_REGULATOR=3Dy
> >> > +CONFIG_CMD_CACHE=3Dy
> >> >  CONFIG_OF_CONTROL=3Dy
> >> >  CONFIG_SPL_OF_CONTROL=3Dy
> >> >  CONFIG_OF_UPSTREAM=3Dy
> >> > @@ -90,10 +89,6 @@ CONFIG_MMC_SDHCI=3Dy
> >> >  CONFIG_MMC_SDHCI_ADMA=3Dy
> >> >  CONFIG_SPL_MMC_SDHCI_ADMA=3Dy
> >> >  CONFIG_MMC_SDHCI_AM654=3Dy
> >> > -CONFIG_PHY_REALTEK=3Dy
> >> > -CONFIG_PHY_TI=3Dy
> >> > -CONFIG_DM_ETH_PHY=3Dy
> >> > -CONFIG_TI_AM65_CPSW_NUSS=3Dy
> >> >  CONFIG_PHY=3Dy
> >> >  CONFIG_PINCTRL=3Dy
> >> >  CONFIG_SPL_PINCTRL=3Dy
> >> > @@ -120,7 +115,8 @@ CONFIG_SYSRESET_TI_SCI=3Dy
> >> >  CONFIG_EXT4_WRITE=3Dy
> >> >  CONFIG_FS_FAT_MAX_CLUSTSIZE=3D16384
> >> >  CONFIG_LZO=3Dy
> >> > -CONFIG_EFI_SET_TIME=3Dy
> >> > +CONFIG_SYS_MEM_TOP_HIDE=3D0x4000000
> >>
> >> Any reason why we are using TOP_HIDE here instead of just moving OPTEE
> >> lower in DDR like we do on the 512MiB AM6254atl EVM?
> >
> > Sorry, that is now a legacy setting before OPTEE finally got moved in
> > v2026.01, as this had been developed thru v2025 u-boot releases..
> >
>
> Well, it's worth noting that this change was not done in the usual way, a=
nd
> involves user interaction during the build beyond selecting a defconfig.
>
> https://texasinstruments.github.io/processor-sdk-doc/processor-sdk-linux-=
AM62X/esd/docs/master/linux/Foundational_Components_ATF.html
> https://git.ti.com/cgit/arago-project/meta-ti/tree/meta-ti-bsp/conf/machi=
ne/am62xxsip-evm.conf
>
> Robert, are you alright with me making the requested changes?

I guess as long as we document it. I know the Octavo OSD62-sip @Erik
Welsh  will also be building on both am62xxsip and pocketbeagle2 based
on the 512MB and then larger memory sizes (1G, 2G, etc.).

Regards,

--=20
Robert Nelson
https://rcn-ee.com/
