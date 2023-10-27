Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10BFC25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:21:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4712D871A5;
	Fri, 27 Oct 2023 02:21:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qJvN60Kr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E0E487634; Fri, 27 Oct 2023 02:21:34 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7317D8071F
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27d3ede72f6so1267881a91.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698366089; x=1698970889; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UdVIdSrs28T71Wm//kzSnw4twN9ZL5+ggwqRBNL1Bns=;
 b=qJvN60KrGZAmKtlFH/fmz7ZUSiDo73cAT2AQZF5PmuZSCpRSTWuqfVbdwHOOtj/L9R
 vTFA10h5j7HUYYmHkV0cXnQ5AG8ilkh6K0TPhOUJMmg4vwaj1h0bshSVIzhawh4VmE8H
 geeGVv9zzlufSsA9mlzLIvPoIy46bigsC1Plw2GcdaPh5aJM53NwTt0bUSFKDu+YU4nP
 2rKkLIahQtan04PGI2Jqa+NzqFvU+7ykH/KfwMbrHqqQLmADRQQ2UlW8g8hfYJIRG3al
 wvwipUKs0eAbfwbeqJiP9WjjIPmO0OTgaTFs/FP8C2wiiedqcCTNTnrMNTr5B59sK3Dc
 1Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698366089; x=1698970889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UdVIdSrs28T71Wm//kzSnw4twN9ZL5+ggwqRBNL1Bns=;
 b=OnMAXtTnub6/ztkpOVazLAqfPXDA+1bQWRkbgTib+uZYjNJW9vTYpAvIKiY5mUH2n4
 fHGuy8l8C6djuuGX9uiEU4FlnICf86IUjxHx8EsEzYrOgyXnU4Cu666MENhabN5nwIjY
 dSHEtWOqrXnBelYNhxPjc2VXQtPBdaWfc1xFjeQbroyvuywYOe1qffoSzhnsMxaBQDR5
 1YGyf4EatJ+RYoyBXoaugngUDwaR/iN8dEwWlbGP0wk/bn+dlHjwEwVQJAuPGdLTp4KM
 n4pC7asm7B+WLdgl7IEOuyy6imU4ciVR3WMsd3sOeXyXd2MSz9nASdmNNPbUElYoBPAW
 0UfA==
X-Gm-Message-State: AOJu0Yz1yqcAxA+tXAE2ztdXnrLRlm5j4dbJw7etV6a8qRfl8nsbWE2n
 aDeZ15ct2Z5PU2ftBsNiu/uy3xrRyGkQtNDjpffp3A==
X-Google-Smtp-Source: AGHT+IGh9Vnzyw89qBThWB/yJ/zAGrI98+Lf85/12ixyPsdfvIxfXJakvkpmX9ykeGS1SkeS6xg3erP+cWPGA6cFZuc=
X-Received: by 2002:a17:90a:5d:b0:27d:10ab:2329 with SMTP id
 29-20020a17090a005d00b0027d10ab2329mr1157604pjb.14.1698366089384; Thu, 26 Oct
 2023 17:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
 <20231025065103.3101666-2-masahisa.kojima@linaro.org>
 <CAC_iWjJ2nNjLeJe201Nx1Uay2xqMgesZdzzsUOO8bpUe3_VXvw@mail.gmail.com>
In-Reply-To: <CAC_iWjJ2nNjLeJe201Nx1Uay2xqMgesZdzzsUOO8bpUe3_VXvw@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 27 Oct 2023 09:21:18 +0900
Message-ID: <CADQ0-X94TOt4xTaGPz7Bir2RWzMr8e_SB-cSAX0=PHvCp8Zceg@mail.gmail.com>
Subject: Re: [PATCH 1/3] board: developerbox: remove obsolete NOR flash layout
 definition
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, jaswinder.singh@linaro.org, ryosuke.saito@linaro.org,
 sugimoto.yoshio@socionext.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Fri, 27 Oct 2023 at 03:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 25 Oct 2023 at 09:52, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > There are two kinds of NOR flash layout for the Developerbox.
> > Capsule update for the old layout is no longer available since
> > it has small capacity for secure world images and can not
> > house the TA such as fTPM.
> > This commit removes the definition related to the obsolete
> > NOR flash layout for the UEFI capsule update.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> >  include/configs/synquacer.h | 19 -------------------
> >  1 file changed, 19 deletions(-)
> >
> > diff --git a/include/configs/synquacer.h b/include/configs/synquacer.h
> > index cd7359c2f8..e36e63e81e 100644
> > --- a/include/configs/synquacer.h
> > +++ b/include/configs/synquacer.h
> > @@ -40,20 +40,6 @@
> >
> >  /* Since U-Boot 64bit PCIe support is limited, disable 64bit MMIO support */
> >
> > -#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
> > -#define DEFAULT_DFU_ALT_INFO
> > -#else
> > -#define DEFAULT_DFU_ALT_INFO "dfu_alt_info="                           \
> > -                       "mtd nor1=u-boot.bin raw 200000 100000;"        \
> > -                       "fip.bin raw 180000 78000;"                     \
> > -                       "optee.bin raw 500000 100000\0"
> > -#endif
>
> We don't need any of these because we use the .dfu_alt_string to
> generate those right?

You are correct. We can generate dfu_alt_info from .dfu_string.

Thanks,
Masahisa Kojima

>
> > -
> > -/* GUIDs for capsule updatable firmware images */
> > -#define DEVELOPERBOX_UBOOT_IMAGE_GUID \
> > -       EFI_GUID(0x53a92e83, 0x4ef4, 0x473a, 0x8b, 0x0d, \
> > -                0xb5, 0xd8, 0xc7, 0xb2, 0xd6, 0x00)
> > -
> >  #ifdef CONFIG_FWU_MULTI_BANK_UPDATE
> >  #define DEVELOPERBOX_FIP_IMAGE_GUID \
> >         EFI_GUID(0x7d6dc310, 0x52ca, 0x43b8, 0xb7, 0xb9, \
> > @@ -64,10 +50,6 @@
> >                  0x33, 0xe0, 0xb9, 0x16, 0xf3, 0x98)
> >  #endif
> >
> > -#define DEVELOPERBOX_OPTEE_IMAGE_GUID \
> > -       EFI_GUID(0xc1b629f1, 0xce0e, 0x4894, 0x82, 0xbf, \
> > -                0xf0, 0xa3, 0x83, 0x87, 0xe6, 0x30)
> > -
> >  /* Distro boot settings */
> >  #ifdef CONFIG_CMD_USB
> >  #define BOOT_TARGET_DEVICE_USB(func)   func(USB, usb, 0)
> > @@ -107,7 +89,6 @@
> >         "ramdisk_addr_r=0xa0000000\0"           \
> >         "scriptaddr=0x88000000\0"               \
> >         "pxefile_addr_r=0x88100000\0"           \
> > -       DEFAULT_DFU_ALT_INFO                    \
> >         BOOTENV
> >
> >  #endif /* __CONFIG_H */
> > --
> > 2.34.1
> >
> Thanks
> /Ilias
