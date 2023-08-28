Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EF7C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA4E86541;
	Mon, 28 Aug 2023 19:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ja7pFHSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499828653E; Mon, 28 Aug 2023 19:56:05 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 981F186522
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d77c5414433so3448309276.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k65GKdOUWnHm1qwafUMtkx7bRQfSH7S8e1jZYL5V+vU=;
 b=Ja7pFHSAHOedn+KoQlCsSvMsk/T5V/2KPPvNnlSHoN2c/03lKKuCMUfCIOHssqYRBs
 rpHWnw6hi5TAuCm7thaZPAlYPG1SboLILv8pt8dL9l/vtzuo0E7RQQdh7agRJ75LnPee
 3c5z/mup9/ZzFABUJjPgcSU0RFV4F991yvk3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245356; x=1693850156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k65GKdOUWnHm1qwafUMtkx7bRQfSH7S8e1jZYL5V+vU=;
 b=mClbK1qVYzqv9vCBAF6iC1UGne4yAFew7zhdXx/lo/kShUGETPfp0hkR7vOloKqKOO
 HRxnQOwT/QjPxO5qMZVTE9GfQWytG5Ez6zB2P+9COdaqps1aL3RCWmW2bGpIhbxYOe/V
 fKERlzQLx7tB0qqRaI+zZI0G02SfCPqPanGY8zbv7C7vFhDl8mvSfRRCdK2D8o//24Ez
 KzfJBKUFxctB/B6F6JW/oCBjIgSiXL+Qsk7IgS6JtOtS1eTKzuagKk5s+669ukJ0sMAk
 IJVUQluYgjgqLHilaAlDOMXzratiB2uchEl02slTrjXHRKaTeqS67V5y1mebutMAXAYY
 1/ug==
X-Gm-Message-State: AOJu0Yy58hB69o80HPuewcHrrMUQU4CbwvvK53FRjZh9bGFRMZadKo13
 svax5N+ZUJDAr3tay0U1PoT0KDLCHm2neYQ0lvkkf9VsX53kiBo6c2Q=
X-Google-Smtp-Source: AGHT+IEvVeF06BPxPCqR+V5nwOp5UCW4I43Leqhupd1OmE6f9iFPbR5/xf2HQzA/dmB5wkB6dKBUX0rQkuYnvj2sfMA=
X-Received: by 2002:a25:ce01:0:b0:d78:1b61:8149 with SMTP id
 x1-20020a25ce01000000b00d781b618149mr11955354ybe.61.1693245356084; Mon, 28
 Aug 2023 10:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230828152226.73466-1-heinrich.schuchardt@canonical.com>
 <20230828152226.73466-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230828152226.73466-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 11:54:51 -0600
Message-ID: <CAPnjgZ07g7gmEw6XPs+-tHvFhXvyBQUwKGw9PGi-qcfrsDk6Bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dm: event: document all events
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

Hi Heinrich,

On Mon, 28 Aug 2023 at 09:22, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide Sphinx documentation for all events.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/event.h | 84 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 2 deletions(-)
>

Great to see this, thank you

> diff --git a/include/event.h b/include/event.h
> index bb38ba98e7..6dee4adef2 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -19,29 +19,109 @@
>   * @EVT_DM_PRE_PROBE: Device is about to be probed
>   */
>  enum event_t {
> -       EVT_NONE,
> +       /**
> +        * @EVT_NONE: This zero value is not used for events.
> +        */
> +       EVT_NONE = 0,
> +
> +       /**
> +        * @EVT_TEST: This event is used in unit tests.
> +        */
>         EVT_TEST,
>
>         /* Events related to driver model */
> +       /**
> +        * @EVT_DM_POST_INIT_F:
> +        * This event is triggered after initialization of the driver model
> +        * before relocation. Its parameter is NULL.

Perhaps better is 'triggered after pre-relocation init of driver
model'. It seems a bit odd to have before and after in the same
sentence.

> +        * A non-zero return code from the event handler let's the boot process
> +        * fail.
> +        */
>         EVT_DM_POST_INIT_F,
> +       /**
> +        * @EVT_DM_POST_INIT_R:
> +        * This event is triggered after initialization of the driver model
> +        * after relocation. Its parameter is NULL.

same here

> +        * A non-zero return code from the event handler let's the boot process
> +        * fail.
> +        */
>         EVT_DM_POST_INIT_R,
> +       /**
> +        * @EVT_DM_PRE_PROBE:
> +        * This event is triggered before probing a device. Its parameter is the
> +        * udevice to be probed.

device

> +        * A non-zero return code lets the device not being probed.
> +        */
>         EVT_DM_PRE_PROBE,
> +       /**
> +        * @EVT_DM_POST_PROBE:
> +        * This event is triggered after probing a device. Its parameter is the
> +        * udevice to be probed.

device that was probed

> +        * A non-zero return code leaves the device in the unprobed state and
> +        * therefore not usable.
> +        */
>         EVT_DM_POST_PROBE,
> +       /**
> +        * @EVT_DM_PRE_REMOVE:
> +        * This event is triggered before removing a device. Its parameter is
> +        * the udevice to be removed.
> +        * A non-zero return code stops the removal of the device before any
> +        * changes.
> +        */
>         EVT_DM_PRE_REMOVE,
> +       /**
> +        * @EVT_DM_POST_REMOVE:
> +        * This event is triggered before removing a device. Its parameter is

after

> +        * the udevice to be removed.

that was removed

> +        * A non-zero return code stops the removal of the device after all
> +        * removal changes. The previous state is not restored. All children
> +        * will be gone and the device may not be functional.

Great!

> +        */
>         EVT_DM_POST_REMOVE,
>
>         /* Init hooks */
> +       /**
> +        * @EVT_MISC_INIT_F:
> +        * This event is triggered during the initialization sequence bofore

before

> +        * relocation. Its parameter is NULL.
> +        * A non-zero return code from the event handler let's the boot process
> +        * fail.
> +        */
>         EVT_MISC_INIT_F,
>
> -       /* Fpga load hook */
> +       /**
> +        * @EVT_FPGA_LOAD:
> +        * The FPGA load hook is called after loading an FPGA with a new binary.
> +        * Its parameter is of type struct event_fpga_load and contains
> +        * information about the loaded image.
> +        */
>         EVT_FPGA_LOAD,
>
>         /* Device tree fixups before booting */
> +       /**
> +        * @EVT_FT_FIXUP:
> +        * This event is triggered during device-tree fix up after all
> +        * other device-tree fixups have been executed.
> +        * Its parameter is of type struct event_ft_fixup which contains
> +        * the address of the device-tree to fix up and the list of images to be
> +        * booted.

A non-zero return causes the boot to fail

> +        */
>         EVT_FT_FIXUP,
>
>         /* To be called once, before calling main_loop() */
> +       /**
> +        * @EVT_MAIN_LOOP:
> +        * This event is triggered immediately before calling main_loop() which
> +        * is the entry point of the command line.
> +        * Its parameter is NULL.
> +        */
>         EVT_MAIN_LOOP,
>
> +       /**
> +        * @EVT_COUNT:
> +        * This constants holds the maximum event number + 1 and is used when
> +        * looping over all event classes.
> +        */
>         EVT_COUNT
>  };
>
> --
> 2.40.1
>

Regards,
Simon
