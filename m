Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34129FA3748
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 11:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A9788A1C;
	Fri, 13 Sep 2024 13:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="krbc0Qs0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DEC688CCF; Fri, 13 Sep 2024 13:55:28 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ACA6889B3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 13:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7d4f8a1626cso612820a12.3
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 04:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726228524; x=1726833324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2yp2L3x328u6f0Zsa2JYnkvmpCXXhnafO8K5ZSZLudY=;
 b=krbc0Qs0sE5uEQTVIWg8vsnheVzsTrVlfUwiiqFkKWnSTCBbbhXOqCY1JRKf8gxifp
 dKxT443H1C3RE/Qs1mYzi1cBLIOYoH2h9hC273D/3QXJXaXsmIAJxhGKAvF6EYcwnsK4
 0EJsqcXl/C7qbxJyj7jB8Rk5sS/dWTCr6bQDcFEPKnncDk7jXSBHnBrrHtETI1xoX7WJ
 FTNoKyHCubJbHVbkqZu3jXqeShNAF466boCP2yi5rpNCTZzzFKot9jKG5qdo2mSCPwPQ
 LNl9q27ce2wlsR+aQmZY/ngVmoTYeVhMmDlm38ntpaIp1K1FEixdCjiayyFB8pKRgvcK
 PXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726228524; x=1726833324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yp2L3x328u6f0Zsa2JYnkvmpCXXhnafO8K5ZSZLudY=;
 b=esStRjfVt9caKgrz3N6eMhfu7tCilcrSJc8eBU9hbxvuob0hoSqRIjYInlPn2dvEJq
 vhM72j39acyUlKEmqaU0CFm+JUa0wlmSMT3vnLC7AYV1ZChQtEGlmcGs42gs/DeWgXFR
 6l91xp/put/T2IPtzqrgj7wCJt3aICOjyD4J5GUFnPcVVUa1mJzMNyGhNegCI2HcFuq+
 oJOFZVBBDDA/gy835php+AuFUhOSWYjvFv6J16nAgS5sjRvheL07Qw3tZGwUFVOcWeFN
 an1sko2IS6mlZjKPZOIy+OjayCgE8Vi/yKK/kaA4v02Qym6V4Q0FnfcDg3nBLnMewzcP
 8H2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMeJU7ChhJ2i1YJkc7C34BvvRD8DyvUi32z1sBJZfa3I1ipMdwneBWBAp/ixspi5pLYK4kmww=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5cGNAhQgJZojsKepQhnsqd9fD2avlt6CMJ06csgbD8S7DU1No
 NjGx7h1lRfZvCpUCdyFFJwlaDwPrTGyrQeRq6mUM7+zwMz9KWWC7y/6C/DBxxrlHRgFE2GNyjFZ
 gmjOOngLk51VM0OH72sEWKSf36AzdgBmVUMrmHg==
X-Google-Smtp-Source: AGHT+IGj24B64l4wDsrPy7d6bONivMNj8o+34gsPHCfmqlc0d16C8nxPceuLE/XTM5SlKUz55xT99nxrzWP1W+WfdQk=
X-Received: by 2002:a05:6a20:7b26:b0:1d1:17c6:7a38 with SMTP id
 adf61e73a8af0-1d117c67a9emr1742719637.9.1726228523722; Fri, 13 Sep 2024
 04:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240910063933.141283-1-ilias.apalodimas@linaro.org>
 <CADg8p94ZnxVCc0VJ9hkAQ1Ka2Y9=Yt995KisJpFDXboMMfT3Yw@mail.gmail.com>
 <CALeDE9OyUBQFmrwqfrM+A7K+pcvS0Bd6GzzvEFpxh8w2Qms2TQ@mail.gmail.com>
 <CAC_iWjKVxSf-RX+4msP=SE+LO6zD++CBu25VQy0o=fiB9CvPug@mail.gmail.com>
 <71204d13-164c-4b5c-805f-436fcc66d456@suse.com>
 <CAC_iWjKcmCixF5ZbYajerJyHeV82u5e0nHdBg-ruCqb76YR2Rw@mail.gmail.com>
In-Reply-To: <CAC_iWjKcmCixF5ZbYajerJyHeV82u5e0nHdBg-ruCqb76YR2Rw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 14:54:47 +0300
Message-ID: <CAC_iWjJspjWFamv1iH5JaT6xDkWYZZ5ybxX9VsTrZejSxf7U1w@mail.gmail.com>
Subject: Re: [PATCH] board: rpi: Enable capsule updates
To: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

Apologies for responding to myself here, but clarifying things a bit more...

On Fri, 13 Sept 2024 at 14:15, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Matthias
>
> On Fri, 13 Sept 2024 at 13:40, Matthias Brugger <mbrugger@suse.com> wrote:
> >
> >
> >
> > On 11/09/2024 12:05, Ilias Apalodimas wrote:
> > > On Wed, 11 Sept 2024 at 12:50, Peter Robinson <pbrobinson@gmail.com> wrote:
> > >>
> > >> On Tue, 10 Sept 2024 at 08:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >>>
> > >>> On Tue, 10 Sept 2024 at 12:09, Ilias Apalodimas
> > >>> <ilias.apalodimas@linaro.org> wrote:
> > >>>>
> > >>>> Since RPI works well using EFI and has no size limitations with regards
> > >>>> to U-Boot, add the needed structures and Kconfig options needed to
> > >>>> enable capsule updates
> > >>>> ---
> > >>>>   board/raspberrypi/rpi/rpi.c | 22 ++++++++++++++++++++++
> > >>>>   configs/rpi_4_defconfig     |  2 ++
> > >>>>   2 files changed, 24 insertions(+)
> > >>>
> > >>> Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > >>>
> > >>> A couple of nits below.
> > >>>
> > >>>>
> > >>>> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > >>>> index ab5ea85cf9f8..1f342eee12b2 100644
> > >>>> --- a/board/raspberrypi/rpi/rpi.c
> > >>>> +++ b/board/raspberrypi/rpi/rpi.c
> > >>>> @@ -63,6 +63,28 @@ struct msg_get_clock_rate {
> > >>>>          u32 end_tag;
> > >>>>   };
> > >>>>
> > >>>> +struct efi_fw_image fw_images[] = {
> > >>>> +       {
> > >>>> +               .fw_name = u"RPI_UBOOT",
> > >>>> +               .image_index = 1,
> > >>>> +       },
> > >>>> +};
> > >>>> +
> > >>>> +struct efi_capsule_update_info update_info = {
> > >>>> +       .dfu_string = "mmc 0=u-boot.bin fat 0 1",
> > >>>> +       .num_images = ARRAY_SIZE(fw_images),
> > >>>> +       .images = fw_images,
> > >>>> +};
> > >>>> +
> > >>>> +#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> > >>>> +void set_dfu_alt_info(char *interface, char *devstr)
> > >>>> +{
> > >>>> +       if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> > >>>> +               env_set("dfu_alt_info", update_info.dfu_string);
> > >>>> +}
> > >>>> +#endif
> > >>>
> > >>> Is this really needed? We have a weak function in efi_firrmware.c
> > >>> which is doing exactly this.
> > >>>
> > >>>> +
> > >>>> +
> > >>>>   #ifdef CONFIG_ARM64
> > >>>>   #define DTB_DIR "broadcom/"
> > >>>>   #else
> > >>>> diff --git a/configs/rpi_4_defconfig b/configs/rpi_4_defconfig
> > >>>> index f5fb322aa8fc..c70414e6fcaf 100644
> > >>>> --- a/configs/rpi_4_defconfig
> > >>>> +++ b/configs/rpi_4_defconfig
> > >>>> @@ -65,3 +65,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
> > >>>>   CONFIG_VIDEO_BCM2835=y
> > >>>>   CONFIG_CONSOLE_SCROLL_LINES=10
> > >>>>   CONFIG_PHYS_TO_BUS=y
> > >>>> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> > >>>> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> > >>>
> > >>> Can we also add the efidebug and efi nvedit commands here. They are
> > >>> pretty handy especially when it comes to capsule updates. Thanks.
> > >>
> > >> Are they pretty handy for capsule updates for general users when
> > >> things should "just work", as a user applies them from Linux with
> > >> fwupdmgr and reboots, or for firmwre developers trying to debug
> > >> things? If it's the later I don't think we should be enabling them by
> > >> default :)
> > >
> > > nvedit lets you print and see EFI variables, which is pretty basic if
> > > you want to boot with efi.
> > > efidebug is supposed to be a debug tool mostly, but unfortunately, we
> > > havent plugged in EFI HTTP boot into the 'eficonfig' command yet. So
> > > the only way you can add a boot option for HTTP is via efidebug
> > >
> >
> > I don't really understand why you are mentioning EFI HTTP. >
>
> Because I misread Peters's question and assumed he was asking if it
> was for capsules only or useful overall as a tool.
>
> > From what I can see
> > we need efidebug to be able to do capsule updates from U-Boot command line.
>
> Updating via the command line is for debugging only. The capsule
> updates execute automatically after a reboot if a variable
> (OsIndications) is set properly or you enable
> CONFIG_EFI_IGNORE_OSINDICATIONS and have a boot entry pointing to the
> same ESP where the capsule is located. But that's a bit complicated
> atm, look below.

The above is only true if CONFIG_EFI_CAPSULE_ON_DISK, which I've
intentionally left out. Only runtime capsule update is selected, which
requires efidebug or an EFI app.

>
> > It is also needed for EFI HTTP boot but this needs CONFIG_EFI_HTTP_BOOT which we
> > don't enable (and I think is out-of-scope for capsule update).
> >
> > /me is puzzled :)
>
> Fair enough. We could make it default tbh. It depends on how much
> 'efi' you prefer in the defconfig. But that belongs on a different
> patchset.
>
> Something completely irrelevant to efidebug, but related to capsule updates.
> Capsule updates,  in order to work with tools like fwupd etc, either
> need commits 00da8d65a3ba and bc3dd2493ef8 and c28d32f946f0 and
> https://github.com/rhboot/efivar/pull/267 or enable
> CONFIG_EFI_IGNORE_OSINDICATIONS. Since the latter is a hack I was
> going to enable SetVariable at Runtime once the userspace patches get
> merged and sorted. Keep in mind there's a v3 out which I managed to
> test with rpi5. FWIW still think efidebug is useful and needs to be
> around regardless of capsules or not.
> What we could do in v4 is enable CONFIG_EFI_IGNORE_OSINDICATIONS, but
> I would prefer to wait for the efivar pathes to merge and just enable
> setvariable at runtime.
>

Also, all these apply to CONFIG_EFI_CAPSULE_ON_DISK only, which I will
enable once the efivar are merged

Sorry for the confusion!
/Ilias

> Thanks
> /Ilias
>
> >
> > Regards,
> > Matthias
