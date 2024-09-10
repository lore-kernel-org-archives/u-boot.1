Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB26ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 07:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A489F888A7;
	Tue, 10 Sep 2024 09:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dx7WDNxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E2B988EFD; Tue, 10 Sep 2024 09:32:23 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B218B888A7
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 09:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-206e614953aso41969425ad.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725953535; x=1726558335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5bTz5JWiI86/6jkNTxkStyWi8R+B9sw6zyPKFGlv4C8=;
 b=dx7WDNxnMB8fRWMNi7VfoIX4jVFmyDBZfmJ5XO1Pbp3WA0yYUez28BvjOGP3/M7JV/
 uPa8LoAenIhWmFDNc/d3zbd1tKiOTweLHwNpdqcajEdFEYAB5yrTIG/mMbydp2B6CaYX
 liKt9BM3uPwyNs6VGVDZKFJSc7z0UyXxB2q/UMuXT4pzG7+gYXxvqwcmhkiYiwWkZsuO
 scRViw4BVYt5LCtHEGfhi6nYV41N9QoMtsnmoOR0C8mng3NWtFKnQ16OaXp5neUCx86m
 EWe2iMADGEYZkJylzaJlwafZ448o0tsvOoXXhNgJzXrryakbYADgiy3RWE3YCTNjMAfN
 2rMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725953535; x=1726558335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5bTz5JWiI86/6jkNTxkStyWi8R+B9sw6zyPKFGlv4C8=;
 b=ZTc+xNNWajWU8u0DsBx5oHC7SVGpaq//lMtl6AWGGjwRi6pk8F0lXy3W3utztOsjZX
 j1S6wSnaihX1DlAXHgw0r9iubz1S8lP28q7EX26wqrInIRcLbZlh6npr61pTKkFhXR3m
 2MXclqWNfh0TTS6VTJ3nY5WEA4nPxeVs/UEtOutnai/W6tqbNhPm7hYSzSUnf32mPsKV
 1TstQ2US4eoL3c6hLV5BKjcyFR6mvpiAlqUk/7iAlmk1RgszzSYj5fn/xt8qvIj5OMbs
 Dl7F1eqvOhwAme1NVLJFKhmdjGEGYPP4+alpP6Rpk/480umjCUzNbtanZr1QUR5620Vt
 YcVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXuhONUxEAapXVPeRjhCYgWpxX58HUAKBnZmCNh8wef4SUrD7MxzwHHxLOGHcY6RTJn5DHw/M=@lists.denx.de
X-Gm-Message-State: AOJu0Yxotn8tRt+1xZZaOav6pdMzOeUXdO7Gqdqu9YFybnVPj91uNI+w
 J2S5lyYglrCk2OOs56vEbATHVO9+PBEn2Zalmm6rixxjTd015omN91YYSG7p5Y5kwP/jZpOiJ7G
 ze/hmH/b3phAqd3c/JGUSFJnELZNRW/beNtcCxA==
X-Google-Smtp-Source: AGHT+IFjErOQCCUF0/2GQZ4an+/k+e0liPNicJ3mdYM5utvEZak071yxPEVUt4inLTl7/YgyK0EanH1lHZHJELEs7ek=
X-Received: by 2002:a17:903:946:b0:207:20fa:83a7 with SMTP id
 d9443c01a7336-20720fa83c4mr141671735ad.47.1725953534469; Tue, 10 Sep 2024
 00:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
 <CADg8p94ZnxVCc0VJ9hkAQ1Ka2Y9=Yt995KisJpFDXboMMfT3Yw@mail.gmail.com>
In-Reply-To: <CADg8p94ZnxVCc0VJ9hkAQ1Ka2Y9=Yt995KisJpFDXboMMfT3Yw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Sep 2024 10:31:38 +0300
Message-ID: <CAC_iWjL2ufC9RwDmdyjLq-Oxy0_Zjr3AkLqfyf=LbcQhgskUBQ@mail.gmail.com>
Subject: Re: [PATCH] board: rpi: Enable capsule updates
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: pbrobinson@gmail.com, mbrugger@suse.com, Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>, "Ivan T. Ivanov" <iivanov@suse.de>, 
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

Thanks for testing

On Tue, 10 Sept 2024 at 10:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
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

Good point, I'll get rid of this

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

Sure, I'll add those


/Ilias
>
> -sughosh
