Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A3CCCD18D
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 13:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6382283936;
	Mon, 13 Oct 2025 15:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KBRLI2q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C6183993; Mon, 13 Oct 2025 15:41:41 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B328383E
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 15:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63994113841so7929797a12.3
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 06:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760362899; x=1760967699; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FOlTfnG8prg/boPamWZt60NmPr9zPEJMelcKqY7k4GA=;
 b=KBRLI2q9F0TM0zeQJy9Po1u4lhnk/A8l2Z8xE509BAT41he0idwWFDQsXO9VsiuWNf
 2Kb3hvr/Dr7IA5T9oUxQqGvskCjrvSVOJaSUcG49sTWiJHGdDVNqEHmrUOkvO+ukYZaG
 kMVP+DdHWnpOlfzJGFKaVPqxov7OkefNRLiDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362899; x=1760967699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOlTfnG8prg/boPamWZt60NmPr9zPEJMelcKqY7k4GA=;
 b=f4jc8cMDUAIkmgYb7IMN9jvZvFAEWrIXqClZPNQoLG0Nd0bMEcD6GvdrUhmNGevoDa
 rcqhWxQBNxRUYhgzt31awVQIcRXwZbZfL++qxw4xdet4xOOTCxGPiyknbz6rO4uoqkTW
 gOyQmE7JyXyOc8nmfmc/bj5Y2z7+NnUbkJ4fxPR8gPjVSk+8F+W3RlaNMTZeFy/HFVrQ
 e7qqRa1o5sUOeaiDm7RrrxE7UgWALE/en3RxbI5B6tCbg7pV/95vlzdw6j3bUPGpm8Wx
 MngiuLc3xoAKlj4GY1aaioSs2Yq4FLObMvAapwLGUDhNU/WDiN8g1xX82iaLlzB271r2
 ZMpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmYX8gPzuKKE6sCnCrmK5psBGAsyamXztDfkMo0nS+Yxf+s5HEkTnNeQPgi2Xbfoj23C7cMs4=@lists.denx.de
X-Gm-Message-State: AOJu0YwvNefN0vlEkGbkh8hJCiYQvXcMgExzyz2HiWLbmPu7KRS/IQtB
 zaQHHmsgv1cY0qc9876O+RwPGwsG9KL3uzmWcViB1kl7VQvcvxc6WF9gJHOKIHSMjVx33iOy6+v
 +rQiOPgrDibmgjNf67yC2UuyBMti6YbQ/PN1YfKaR
X-Gm-Gg: ASbGnculkZ7l+y1qFK6uBl5+eNAebBQPVHsvVOknzO3t0pEMWzDi233/uTezFkfy62S
 MXI+l0ZgKve+9gh96IQ/t7ysbsCk16jtTfNA9Npb5k/r5RAZd5V5tP3YEx2dc6QYLW0dih9dJvs
 UWTobxBOS32NM/309yXpMJKSzuds3/i7qZdhZSDNsB6noS5+SKXtHC93Vtov3rERsNw761gA58w
 3X2KotV/5A9CHmlpXwndTtBZytx/mV2DgcIFjuJ7uK2/YaDeu9FuU7qiG7TUqmVuYri4w==
X-Google-Smtp-Source: AGHT+IHaa3V9+QrT2EQ6JhP/4xMH+RZU/8APOYbgt65djq4KCNFDxd2LQxzInEvhIY77uIaEno61R94M0kV36jzTCH4=
X-Received: by 2002:a05:6402:40c8:b0:62b:63f8:cdbb with SMTP id
 4fb4d7f45d1cf-639d5c4c1e1mr18401688a12.25.1760362898723; Mon, 13 Oct 2025
 06:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251012064412.2892979-1-sjg@chromium.org>
 <20251012064412.2892979-4-sjg@chromium.org>
 <476e7a6a-1371-43de-9c23-7a70e70619c4@gmx.de>
In-Reply-To: <476e7a6a-1371-43de-9c23-7a70e70619c4@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Oct 2025 14:41:24 +0100
X-Gm-Features: AS18NWBV-1AGD0HW0gbagbxedbRewnO-vUDsVsj6eeHCv_EB_A1kaunpyysA0aE
Message-ID: <CAFLszTiPoFVwBUbMBSBRr336WTU7qtoaOUT46Dt3uKWkoWGSww@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] boot: Rename usb to ums
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
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

On Mon, 13 Oct 2025 at 11:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10/12/25 08:43, Simon Glass wrote:
> > The name 'usb' is quite generic and could apply to any USB device.
> > Rename it 'ums', for USB Mass Storage.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Suggested-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > (no changes since v1)
> >
> >   boot/bootflow.c      | 5 ++++-
> >   include/bootflow.h   | 2 +-
> >   test/boot/bootflow.c | 2 +-
> >   3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > index 6485d473d69..13f086167ab 100644
> > --- a/boot/bootflow.c
> > +++ b/boot/bootflow.c
> > @@ -1019,7 +1019,10 @@ const char *bootflow_guess_label(const struct bootflow *bflow)
> >       if (bflow->dev) {
> >               struct udevice *media = dev_get_parent(bflow->dev);
> >
> > -             name = dev_get_uclass_name(media);
> > +             if (device_get_uclass_id(media) == UCLASS_MASS_STORAGE)
> > +                     name = "ums";
>
> Using a different label ('ums') here than we use for the load command
> ('usb') just leads to confusing users.
>
> We should use the same label for USB mass storage devices everywhere. Or
> use a long label like 'USB block device'.

OK, well we can just drop this patch. It was a suggestion from a few
people, but I'm not a huge fan of it either. We only have room for 8
characters here at present.

Regards,
Simon


>
> Best regards
>
> Heinrich
>
> > +             else
> > +                     name = dev_get_uclass_name(media);
> >       }
> >       if (!name)
> >               name = "(none)";
> > diff --git a/include/bootflow.h b/include/bootflow.h
> > index 657e3731f11..2aa00a9b1db 100644
> > --- a/include/bootflow.h
> > +++ b/include/bootflow.h
> > @@ -696,7 +696,7 @@ int bootflow_menu_poll(struct expo *exp, int *seqp);
> >    * bootflow_guess_label() - Produce a plausible label for a bootflow
> >    *
> >    * This uses the uclass name or EFI device-path to come up with a useful label
> > - * for display to the user. Ideally it will say "mmc", "usb", nvme", etc.
> > + * for display to the user. Ideally it will say "mmc", "ums", nvme", etc.
> >    */
> >   const char *bootflow_guess_label(const struct bootflow *bflow);
> >
> > diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> > index 7cd83dc7443..b777708f5d6 100644
> > --- a/test/boot/bootflow.c
> > +++ b/test/boot/bootflow.c
> > @@ -1301,7 +1301,7 @@ static int bootflow_efi(struct unit_test_state *uts)
> >       ut_assert_nextlinen("---");
> >       ut_assert_nextlinen("  0  extlinux");
> >       ut_assert_nextlinen(
> > -             "  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
> > +             "  1  efi          ready   ums          1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
> >       ut_assert_nextlinen("---");
> >       ut_assert_skip_to_line("(2 bootflows, 2 valid)");
> >       ut_assert_console_end();
>
