Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE18ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 13:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019CF89060;
	Tue, 10 Sep 2024 15:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IV6uesgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E0E289060; Tue, 10 Sep 2024 15:55:06 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90E688FFB
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-206e614953aso45974585ad.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725976501; x=1726581301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nsTSgWuw65UUcIPVxMCexE2aNp1Q86S1FFpGGixSdpY=;
 b=IV6uesgdJI5Z70KbRKaPitGXYXESfvIoJscnYWcE8UYyuHnqihHNG+DR1KwtVyC6do
 AtIJpkPIzx0EIDc/yiArJafAjkJCh7yGN18IszSpXbbdx9g8mtyJzDTxcdZZI3tTEE71
 hB4al8DwzUSgQKYjy+6PBLFV7GyUznEGh95RYTIctTUt3gF8/gubyL6ryX5lF4cVRuxj
 BEAyB1DYat7RPskREk/GD8yv/vrGo8Nog5taOkTFpEQoCQcO/lvHUDpT9p3OYadK9XlS
 VsLD1IdfW3Ct1KgHgcJMn/JTSyrgcBWWwBK9EiPQarInIBA1i427qZlrPJMyYot05Mmw
 GxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725976501; x=1726581301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nsTSgWuw65UUcIPVxMCexE2aNp1Q86S1FFpGGixSdpY=;
 b=JMda2nPz+NS6sGtItHs5Ow2uNiHOBObc8OiaCSUJ9enoBp/CZMa6/5pgnrbShx0cRl
 7GW6D1ZCLjBbJ+utCF15Ov7KPKxaA8nfIFIfvIhpGm8rB8WUVDYXyT63TQHVSRljobuN
 TBOmMV1yS82WfR3njFSIdqh6KBjg0qc0bNBWAHqFdsTwoJMegXh54QJ5DdIxQUxZcZVy
 DtiYHoHzRaLV2bLy3zT/lmZ9L8mTDwsHkjmMsoFH3/XTSWOKSR7iF/7bQheJ/OO49Q69
 5T2Ac9gnUl97Z8ShraLzCoHPBpX0nbf8mDJ+kTPbDckFpyOEoeN0KwTSfW8LnITistMb
 eD0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdv2wdFG54tlhFOHkIyR71lxjmRwVLmocWGlS0IrgZzob6eapuepkWr2NpTV02YNGCQGZIde8=@lists.denx.de
X-Gm-Message-State: AOJu0YyOcNcW0ZZaYRXmsflWfGC7RQx14LDkET6qTxetN2IaLAgQvDeu
 XvTfvDwTK2Bv6sHcv+pl4QnO4qfbNLJf21xIE2jvDmK4QIJVLipQzfZwqIdCpH/gBtEzleX0mH+
 hv10LJ3+VPrgx2sq9kIft/1D07OYdHT/DssMdjA==
X-Google-Smtp-Source: AGHT+IHw5M9qJHboAPhBmSUwar3thUmp2P1UJDzKCX9xUvEcc/MyoK2NWYncsJw3X7ySyiGWILDWZ8q+TKv6gzHsluQ=
X-Received: by 2002:a17:902:ec84:b0:205:7829:9d83 with SMTP id
 d9443c01a7336-2074c6ed13bmr9009685ad.38.1725976500561; Tue, 10 Sep 2024
 06:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
 <11d30053-5c17-47d9-9f68-a23ce828d8b4@suse.com>
In-Reply-To: <11d30053-5c17-47d9-9f68-a23ce828d8b4@suse.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Sep 2024 16:54:24 +0300
Message-ID: <CAC_iWj+moyMs0ibKmEfkg6toPYpTfPue2Er6tfJ6SJOjg0DAyw@mail.gmail.com>
Subject: Re: [PATCH] board: rpi: Enable capsule updates
To: Matthias Brugger <mbrugger@suse.com>
Cc: pbrobinson@gmail.com, sughosh.ganu@linaro.org, 
 Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
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

Hi Matthias,

On Tue, 10 Sept 2024 at 16:50, Matthias Brugger <mbrugger@suse.com> wrote:
>
>
>
> On 10/09/2024 08:39, Ilias Apalodimas wrote:
> > Since RPI works well using EFI and has no size limitations with regards
> > to U-Boot, add the needed structures and Kconfig options needed to
> > enable capsule updates
> > ---
> >   board/raspberrypi/rpi/rpi.c | 22 ++++++++++++++++++++++
> >   configs/rpi_4_defconfig     |  2 ++
> >   2 files changed, 24 insertions(+)
> >
> > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > index ab5ea85cf9f8..1f342eee12b2 100644
> > --- a/board/raspberrypi/rpi/rpi.c
> > +++ b/board/raspberrypi/rpi/rpi.c
> > @@ -63,6 +63,28 @@ struct msg_get_clock_rate {
> >       u32 end_tag;
> >   };
> >
> > +struct efi_fw_image fw_images[] = {
> > +     {
> > +             .fw_name = u"RPI_UBOOT",
> > +             .image_index = 1,
> > +     },
> > +};
> > +
> > +struct efi_capsule_update_info update_info = {
> > +     .dfu_string = "mmc 0=u-boot.bin fat 0 1",
> > +     .num_images = ARRAY_SIZE(fw_images),
> > +     .images = fw_images,
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> > +void set_dfu_alt_info(char *interface, char *devstr)
> > +{
> > +     if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> > +             env_set("dfu_alt_info", update_info.dfu_string);
> > +}
> > +#endif
> > +
> > +
> >   #ifdef CONFIG_ARM64
> >   #define DTB_DIR "broadcom/"
> >   #else
> > diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> > index f5fb322aa8fc..c70414e6fcaf 100644
> > --- a/configs/rpi_4_defconfig
> > +++ b/configs/rpi_4_defconfig
> > @@ -65,3 +65,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
> >   CONFIG_VIDEO_BCM2835=y
> >   CONFIG_CONSOLE_SCROLL_LINES=10
> >   CONFIG_PHYS_TO_BUS=y
> > +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> > +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>
> Would you mind to enable this in all corresponding configs.
>
> That would be at least: rpi_3_b_plus_defconfig, rpi_3_defconfig,
> rpi_arm64_defconfig.

No I don't, I just didn't have the hardware to test it. In practice
different boards should have different GUIDS -- so you dont end up
updating and RPI4 with an RPI3 firmware. I am about to send a PR that
enables a dynamic GUID generation (which this patch depends on). That
patch reads the root compatible node and uses it to derive unique
UUIDs. I assume that all those boards have a different compatible node
and we wont have clashes?

Thanks
/Ilias
>
> Thanks,
> Matthias
