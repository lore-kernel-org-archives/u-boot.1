Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C053EE498B
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26EFF89223;
	Wed, 11 Sep 2024 12:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GElW262U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C43C18921A; Wed, 11 Sep 2024 12:06:09 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA2B89223
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 12:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2da55ea8163so4495644a91.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 03:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726049166; x=1726653966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9h7VAwXr4x/UAk0/0TlLYz845dyWGSCav0pheZ855pQ=;
 b=GElW262Ut9Up6NnTJ5QFAc/M/q6+xB/ppv+AjiNjVw2MqTvttFaMi/hKNufpcv/YL+
 1A/couYRHw3gLkho/3nwSf1PFF3Bt4nsgNMB5gZohnOczSv3I3tQLn0A8tC70k+02FGP
 00eU/4MP1J4B1d7ZBkD7jepzpSyDWLqy7RBiShKdcJqLMAY+ObpEv6pWxkxdf1J0ABYK
 iB8I0w1/1r8w5BKNt/2t1brhZBR119TceQQNtiwHHWip1zT9AYj1EPJD94mi8g9aAfKT
 L1KhU//CiRSQ1bb0/KxC8Fc9ExYJqGJdA7Lt+Yp2s86KxfihfyPUMPY9YPYJFXjsTsFk
 8V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726049166; x=1726653966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9h7VAwXr4x/UAk0/0TlLYz845dyWGSCav0pheZ855pQ=;
 b=XBNMYNCV3fNQxxcQ6Uv6gc1M7OvroBU1HxTAQbteNS8J86Dni4/7zHWXxwbDsgDD5T
 IGmHriIoUBrUYyus/0m4H3+jIgKT0gqjGclYurYyqSZUyPqGdM0IdGexj4y9qnK4hON0
 uATu3uVOuZT0U+Yc/lXVhWMg0dzpMJJa5VijZa9mtBAP+9L8MzkQJbbtGPd2kaxzxPrC
 uJy3hbg+wbjmWOEQW1CzwHleB0m4x5GDfZaVL8Mc5x2UBccH/4orWJ2Lo2ov1RmA+vrP
 anc2y9LaT8MsW24p2nywFzjUFmVJs/IpzqwAU7eafXPM/HhDKC+8fx/l44yutJE5DOtq
 Pj+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmJFmV44eWizwl959MGjdHvlYC3okDAKryy59S/nbE77o5XTZyCThmd1Xs4Pn0aoKBr95/uoU=@lists.denx.de
X-Gm-Message-State: AOJu0YzDLJlbWH6Dntgc4f/YbZNrOvBPT8LdMRLD4CqedTCPhcXh0lW3
 rZBoMapLjrawbk5luydgyZIFtjEa9UMZ6Kqi9/h3cZc68dBmbxs8isyB42YWGPnsdouoxQ7TRaR
 l3iKtaeZ8oNYL2iO/JsBLhloUOve1l+MiiEGezQ==
X-Google-Smtp-Source: AGHT+IH0OU8o3GcW+q6uRm+Bt2Md5Ui0nvGFXjezg02eZsn4FI13ShaRG0C7W2GW81ekpU4pRRI3zp0ESP3O3GU87mE=
X-Received: by 2002:a17:90b:383:b0:2d6:1c0f:fea6 with SMTP id
 98e67ed59e1d1-2dad50d1bf2mr18414096a91.11.1726049165728; Wed, 11 Sep 2024
 03:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
 <CADg8p94ZnxVCc0VJ9hkAQ1Ka2Y9=Yt995KisJpFDXboMMfT3Yw@mail.gmail.com>
 <CALeDE9OyUBQFmrwqfrM+A7K+pcvS0Bd6GzzvEFpxh8w2Qms2TQ@mail.gmail.com>
In-Reply-To: <CALeDE9OyUBQFmrwqfrM+A7K+pcvS0Bd6GzzvEFpxh8w2Qms2TQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 11 Sep 2024 13:05:29 +0300
Message-ID: <CAC_iWjKVxSf-RX+4msP=SE+LO6zD++CBu25VQy0o=fiB9CvPug@mail.gmail.com>
Subject: Re: [PATCH] board: rpi: Enable capsule updates
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, mbrugger@suse.com, 
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

On Wed, 11 Sept 2024 at 12:50, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Tue, 10 Sept 2024 at 08:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Tue, 10 Sept 2024 at 12:09, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Since RPI works well using EFI and has no size limitations with regards
> > > to U-Boot, add the needed structures and Kconfig options needed to
> > > enable capsule updates
> > > ---
> > >  board/raspberrypi/rpi/rpi.c | 22 ++++++++++++++++++++++
> > >  configs/rpi_4_defconfig     |  2 ++
> > >  2 files changed, 24 insertions(+)
> >
> > Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >
> > A couple of nits below.
> >
> > >
> > > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > > index ab5ea85cf9f8..1f342eee12b2 100644
> > > --- a/board/raspberrypi/rpi/rpi.c
> > > +++ b/board/raspberrypi/rpi/rpi.c
> > > @@ -63,6 +63,28 @@ struct msg_get_clock_rate {
> > >         u32 end_tag;
> > >  };
> > >
> > > +struct efi_fw_image fw_images[] = {
> > > +       {
> > > +               .fw_name = u"RPI_UBOOT",
> > > +               .image_index = 1,
> > > +       },
> > > +};
> > > +
> > > +struct efi_capsule_update_info update_info = {
> > > +       .dfu_string = "mmc 0=u-boot.bin fat 0 1",
> > > +       .num_images = ARRAY_SIZE(fw_images),
> > > +       .images = fw_images,
> > > +};
> > > +
> > > +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> > > +void set_dfu_alt_info(char *interface, char *devstr)
> > > +{
> > > +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> > > +               env_set("dfu_alt_info", update_info.dfu_string);
> > > +}
> > > +#endif
> >
> > Is this really needed? We have a weak function in efi_firrmware.c
> > which is doing exactly this.
> >
> > > +
> > > +
> > >  #ifdef CONFIG_ARM64
> > >  #define DTB_DIR "broadcom/"
> > >  #else
> > > diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> > > index f5fb322aa8fc..c70414e6fcaf 100644
> > > --- a/configs/rpi_4_defconfig
> > > +++ b/configs/rpi_4_defconfig
> > > @@ -65,3 +65,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
> > >  CONFIG_VIDEO_BCM2835=y
> > >  CONFIG_CONSOLE_SCROLL_LINES=10
> > >  CONFIG_PHYS_TO_BUS=y
> > > +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> > > +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> >
> > Can we also add the efidebug and efi nvedit commands here. They are
> > pretty handy especially when it comes to capsule updates. Thanks.
>
> Are they pretty handy for capsule updates for general users when
> things should "just work", as a user applies them from Linux with
> fwupdmgr and reboots, or for firmwre developers trying to debug
> things? If it's the later I don't think we should be enabling them by
> default :)

nvedit lets you print and see EFI variables, which is pretty basic if
you want to boot with efi.
efidebug is supposed to be a debug tool mostly, but unfortunately, we
havent plugged in EFI HTTP boot into the 'eficonfig' command yet. So
the only way you can add a boot option for HTTP is via efidebug

Cheers
/Ilias
