Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C447AC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2124087C97;
	Sat, 16 Dec 2023 19:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AbTknBLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C06A87C4D; Sat, 16 Dec 2023 19:48:40 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC47287C73
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5e2bd289172so15797837b3.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TD4MEqf1Y6X2vIddKMvM0hsqXzrqeHFvL3nyQvH/Nns=;
 b=AbTknBLPcRnPmllbibPmj2CrWt6ZDgqZuPJAQrqVbI7j0nRFdNWoLpPodzq/paueKP
 wGYyf4Or1W0Te19mhkFf1KyfxrXkw0vYewcu8uKnY0MCS+/AQH4w/PqQFKHK9/LMqgep
 KdcPQta8Iv1KqNr5Ytr4Aaoa3PLYn+zIwNICM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TD4MEqf1Y6X2vIddKMvM0hsqXzrqeHFvL3nyQvH/Nns=;
 b=iRWEvCwhir5O3x4BxklryW8gRaGy2W19xWEg5/9cnBxv7kjb8JSNui2/eiUhnjX8gF
 rYv6RWATbvkqZvjWgxM+Cef3BnQN6dkGjoW149MsAlAcpIrwGyhSUaVVYHtw8ghgRF4r
 dTt9Xu2OvVrUia3w8QEl0M4BU+7+PNmnjWARZ6Y9chGc4lok2oxKDYFj6DVbOZGEDtQb
 /yTBuxAs3AdXdFF57fU674/G6otGHLT5b6SsB/81bhLTSY9+D6Bn4JIMpBNkhYf9KWak
 GCvEyWQ5u/mkx9R/oH/F08/1ejaYAV+g1yVyrBkgCuasfO+pMjt1iJDBSwYX6s4oNaIG
 DU+A==
X-Gm-Message-State: AOJu0YwyIk/XKN6TXS5Zo2Piudvt3Ca8DIyk764kvueZhDMemyBZlkns
 W0EEMvITKXjnV9yCylsxs/0YuWqnX19GxWIJAo3lHg==
X-Google-Smtp-Source: AGHT+IGiJmvlFpYZ00w+OPRPUg2sLsh+7++P2TVoavJxjM6vmNRyfNAq4KWz6tEATQvTMFlVTmEMNFNum8LE9WWKLMA=
X-Received: by 2002:a0d:d4ce:0:b0:5e5:3a3b:4b2b with SMTP id
 w197-20020a0dd4ce000000b005e53a3b4b2bmr1023378ywd.55.1702752514137; Sat, 16
 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231216031446.2222362-1-sjg@chromium.org>
 <20231216031446.2222362-17-sjg@chromium.org>
 <20231216171227.GS2513409@bill-the-cat>
In-Reply-To: <20231216171227.GS2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:36 -0700
Message-ID: <CAPnjgZ3Wnzn3TG-biOh0O=5kXV6qQZOgip5H+AC4nenBrgg-Zg@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] bootm: Create a new boot_run() function to
 handle booting
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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

Hi Tom,

On Sat, 16 Dec 2023 at 10:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 15, 2023 at 08:14:26PM -0700, Simon Glass wrote:
> > Create a common function used by the three existing bootz/i/m_run()
> > functions, to reduce duplicated code.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > Changes in v3:
> > - Add new boot_run() function
> >
> >  boot/bootm.c    | 40 ++++++++++++++--------------------------
> >  include/bootm.h | 18 ++++++++++++++++++
> >  2 files changed, 32 insertions(+), 26 deletions(-)
> >
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index 53236136f489..6a4cebcf7a08 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -1123,47 +1123,35 @@ err:
> >       return ret;
> >  }
> >
> > -int bootm_run(struct bootm_info *bmi)
> > +int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states)
> >  {
> >       int states;
> >
> > -     bmi->cmd_name = "bootm";
> > -     states = BOOTM_STATE_START | BOOTM_STATE_FINDOS | BOOTM_STATE_PRE_LOAD |
> > -             BOOTM_STATE_FINDOTHER | BOOTM_STATE_LOADOS |
> > -             BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
> > -             BOOTM_STATE_OS_GO | BOOTM_STATE_MEASURE;
> > +     bmi->cmd_name = cmd;
> > +     states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
> > +             BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
> >       if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
> >               states |= BOOTM_STATE_RAMDISK;
> > -     if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
> > -             states |= BOOTM_STATE_OS_CMDLINE;
> > +     states |= extra_states;
> >
> >       return bootm_run_states(bmi, states);
> >  }
> >
> > -int bootz_run(struct bootm_info *bmi)
> > +int bootm_run(struct bootm_info *bmi)
> >  {
> > -     int states;
> > -
> > -     bmi->cmd_name = "bootz";
> > -     states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
> > -             BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
> > -     if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
> > -             states |= BOOTM_STATE_RAMDISK;
> > +     return boot_run(bmi, "bootm", BOOTM_STATE_START | BOOTM_STATE_FINDOS |
> > +                     BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOTHER |
> > +                     BOOTM_STATE_LOADOS);
> > +}
> >
> > -     return bootm_run_states(bmi, states);
> > +int bootz_run(struct bootm_info *bmi)
> > +{
> > +     return boot_run(bmi, "bootz", 0);
> >  }
> >
> >  int booti_run(struct bootm_info *bmi)
> >  {
> > -     int states;
> > -
> > -     bmi->cmd_name = "booti";
> > -     states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
> > -             BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
> > -     if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
> > -             states |= BOOTM_STATE_RAMDISK;
> > -
> > -     return bootm_run_states(bmi, states);
> > +     return boot_run(bmi, "booti", 0);
> >  }
> >
> >  int bootm_boot_start(ulong addr, const char *cmdline)
> > diff --git a/include/bootm.h b/include/bootm.h
> > index eba35b33b4e5..9e0f8d60de0a 100644
> > --- a/include/bootm.h
> > +++ b/include/bootm.h
> > @@ -150,6 +150,24 @@ int bootm_measure(struct bootm_headers *images);
> >   */
> >  int bootm_run_states(struct bootm_info *bmi, int states);
> >
> > +/**
> > + * boot_run() - Run the entire bootm/booti/bootz process
> > + *
> > + * This runs through the boot process from start to finish, with a base set of
> > + * states, along with the extra ones supplied.
> > + *
> > + * This uses bootm_run_states().
> > + *
> > + * Note that it is normally easier to use bootm_run(), etc. since they handle
> > + * the extra states correctly.
> > + *
> > + * @bmi: bootm information
> > + * @cmd: command being run, NULL if none
> > + * @extra_states: Mask of extra states to use for the boot
> > + * Return: 0 if ok, something else on error
> > + */
> > +int boot_run(struct bootm_info *bmi, const char *cmd, int extra_states);
> > +
> >  /**
> >   * bootm_run() - Run the entire bootm process
> >   *
>
> Overall good, thanks. My question is, should we mark the others as
> static, or is this new helper static and not to be called externally?

The others are used externally.

For bootm_run() I toyed with the idea of it being static, but then
wondered if we might use that programmatically instead of the
bootz/i/m(_run) versions. It is quite nice that the differences are
now pretty minor between them.

I don't mind either way, though.

Regards,
Simon
