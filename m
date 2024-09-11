Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2711CEE4989
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA0089133;
	Wed, 11 Sep 2024 11:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iK4KdsZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5699D89125; Wed, 11 Sep 2024 11:50:27 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBDE89205
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so168580a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726048225; x=1726653025; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AMKYFdFdc4/zbUayNZitro5pZkZilI+M3skGj0vEp6E=;
 b=iK4KdsZ04zN9nHrHZjrAiNawglZXhzd3r2BPyuthQ7XxvOODkHW3Be2LuNH36L+X2E
 fmIJyJ9P5/8zbew4ouOpQjJgTP19w7M3sR5UEBkn9m7YklQBVgYPWKgu9VRFALJY2m83
 shmPqAgyhiF6cn0SM7Swl58yHMhuIWxBTKOGdohrUVaXniu4qH8hHDQeWdZhKy9jj+PM
 I5HVReYrt8jrlQ/TnlrkSGAb7z002RXA7IqduUcZRr2Jivn510zzgbKXBMUgbYYPbSWN
 Qbk1kgX8mcOmt6meYn0+9u6pMYt6ldEaLbdQgMoxQKV4qxdlcr/6WHJPYdRifbVz9qYS
 V+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048225; x=1726653025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AMKYFdFdc4/zbUayNZitro5pZkZilI+M3skGj0vEp6E=;
 b=Kb443q3/qjD9HH5gC8QtIHzqja3HjsujQB/Cj7pMamhGgK1WFenegzcpNQxjYGsyYc
 BDlnvO9msx++PPpkaUfw7DDYDaOrHBMf7yflXv4nL6zOy/8XVbW3nLvrGF58ZE05+5K+
 H/rNaUsLqqznMKvYXmR0tScsGQA5D2hI+XnWa6UAhDVso6ZhA95UcUlvPid7l99hh4y4
 Indnei00XVfE58YlD+o0gSsi/StNgqRkU8XvREk4JMDWVzE5oKY1MUSa8L7ecOUWcljw
 6Z+/c8CNF1+P8rF+FJpljRL/79kOc6I3i4J3IP6+M62eKirTxnVb0EAMBzm8LvPw5+1N
 eKeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWadHLERhWyzZZ927lWw+SIoj/znA/Q/9GJqi10EgjUrDH5sK5xAYfcyKIhB98R3v438v+fhkM=@lists.denx.de
X-Gm-Message-State: AOJu0YystaVWIfcdE9ASFzR6LgDRRWL5P4zEk9LVWdeqLFS2sUbEqbuS
 bMtnx4EJ2E1y8FlXVPGRRbmfEIeNHppw1qApC/YftACEdrxi7l9b4Dzs1DHLjQPeMfLVrR7vNOq
 cn81qX3bZJbl+5nB///ajkbeH9P8=
X-Google-Smtp-Source: AGHT+IGxXKFNZexPcpMwJlMBsfNt6nfCDdlHAcaYQH9j8XaUsgpXA7tghlDv/isfKluGxNKUhu8Y8LMuKCOs0zxN894=
X-Received: by 2002:a05:6402:1f0c:b0:5be:f5b0:fc38 with SMTP id
 4fb4d7f45d1cf-5c4015e5da3mr7561649a12.10.1726048224804; Wed, 11 Sep 2024
 02:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
 <CADg8p94ZnxVCc0VJ9hkAQ1Ka2Y9=Yt995KisJpFDXboMMfT3Yw@mail.gmail.com>
In-Reply-To: <CADg8p94ZnxVCc0VJ9hkAQ1Ka2Y9=Yt995KisJpFDXboMMfT3Yw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 11 Sep 2024 10:49:50 +0100
Message-ID: <CALeDE9OyUBQFmrwqfrM+A7K+pcvS0Bd6GzzvEFpxh8w2Qms2TQ@mail.gmail.com>
Subject: Re: [PATCH] board: rpi: Enable capsule updates
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, mbrugger@suse.com, 
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

On Tue, 10 Sept 2024 at 08:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 10 Sept 2024 at 12:09, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Since RPI works well using EFI and has no size limitations with regards
> > to U-Boot, add the needed structures and Kconfig options needed to
> > enable capsule updates
> > ---
> >  board/raspberrypi/rpi/rpi.c | 22 ++++++++++++++++++++++
> >  configs/rpi_4_defconfig     |  2 ++
> >  2 files changed, 24 insertions(+)
>
> Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>
> A couple of nits below.
>
> >
> > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > index ab5ea85cf9f8..1f342eee12b2 100644
> > --- a/board/raspberrypi/rpi/rpi.c
> > +++ b/board/raspberrypi/rpi/rpi.c
> > @@ -63,6 +63,28 @@ struct msg_get_clock_rate {
> >         u32 end_tag;
> >  };
> >
> > +struct efi_fw_image fw_images[] = {
> > +       {
> > +               .fw_name = u"RPI_UBOOT",
> > +               .image_index = 1,
> > +       },
> > +};
> > +
> > +struct efi_capsule_update_info update_info = {
> > +       .dfu_string = "mmc 0=u-boot.bin fat 0 1",
> > +       .num_images = ARRAY_SIZE(fw_images),
> > +       .images = fw_images,
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> > +void set_dfu_alt_info(char *interface, char *devstr)
> > +{
> > +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> > +               env_set("dfu_alt_info", update_info.dfu_string);
> > +}
> > +#endif
>
> Is this really needed? We have a weak function in efi_firrmware.c
> which is doing exactly this.
>
> > +
> > +
> >  #ifdef CONFIG_ARM64
> >  #define DTB_DIR "broadcom/"
> >  #else
> > diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> > index f5fb322aa8fc..c70414e6fcaf 100644
> > --- a/configs/rpi_4_defconfig
> > +++ b/configs/rpi_4_defconfig
> > @@ -65,3 +65,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
> >  CONFIG_VIDEO_BCM2835=y
> >  CONFIG_CONSOLE_SCROLL_LINES=10
> >  CONFIG_PHYS_TO_BUS=y
> > +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> > +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>
> Can we also add the efidebug and efi nvedit commands here. They are
> pretty handy especially when it comes to capsule updates. Thanks.

Are they pretty handy for capsule updates for general users when
things should "just work", as a user applies them from Linux with
fwupdmgr and reboots, or for firmwre developers trying to debug
things? If it's the later I don't think we should be enabling them by
default :)
