Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12425C52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307F488D33;
	Wed,  7 Aug 2024 16:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UWD9VUfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D503788D2D; Wed,  7 Aug 2024 16:37:07 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8F388D40
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b78c980981so9570856d6.2
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 07:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723041424; x=1723646224; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=16S5qyg3UfvvU+iDWygF7NGUwl5DLuJ8xSCVW1Xs/68=;
 b=UWD9VUfmvWK72G3qO5f3mgxiM4hyLl0UHIUS7Iq1HYci8lHO9OrL2ws0kbtwsLLZ9R
 4HZOPWaDFelwSzC7DXA2e/xMEWOR91IlEiK8WofyP6OwgBCjleMfvU9BmyAmGPGVaLaw
 OiZLHbiscad9TexOYQy6LEGVx4IJUDsYBm9J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723041424; x=1723646224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=16S5qyg3UfvvU+iDWygF7NGUwl5DLuJ8xSCVW1Xs/68=;
 b=u7C/51Gud42PqjKVD8AvdN6NnA8HLKpI54dlTTfnTE4LbYH9lrzm7cymHRUoTgnQ8d
 oj9P2reqXNiCyZJ3A9AZFllJmF7IrcAXUNiTZahzRoe4C2X+56lHPedsXB0uTzqbQsey
 cyxs8gM9MDC4fdZmxiFSIrRnufxvQTuKiSo7RXikILRtbqR5vmn/85Dwj1+QvslEv0Q8
 Dp9nP2Ny38VbbkcdVSkNPY6fg6DSEVUerYFjDx56zpFgdW3x2JS2Cs7EywVzXFcVgmAk
 m0SpJK8yWxn0vIOU/dVso4OivaLHZbNyi6PFQHDAZaWMB+oOlTzrqM/WVSBVY04X28Ns
 SCbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWknKWL3R+0X40WIJP4EMFrtUxDuWODrlhb7fT3FAE986H3omnIHAG3XJ/Fbb0L6vJ/YKaB3qbtLnMnfRGmHprGLhqiLQ==
X-Gm-Message-State: AOJu0YzaLdYCIwJbSptDPty0oFTs0D/VkB1Hyz0HOvPjN7ncN5Xu/AlS
 LvHTXogNnkUmRcfHZ+LCiP+vXGxHeYRDjf8M2FlXPCFe4u0VCe0+qSlC/hXco2T6sM5O1TCHmi+
 Eek4UHdtR2pD0xr6O2CBvgI+2jffgaOnjvpgr
X-Google-Smtp-Source: AGHT+IHlukbPKge4foWJS6uzjs6uWdTinfRqRGYicKb0zRtIwXwUM25z1ozlKQAJFfKatXpd8ZzpG69zEDntCKqxTG8=
X-Received: by 2002:a05:6214:5b07:b0:6b7:abe7:566f with SMTP id
 6a1803df08f44-6bb984541famr183540456d6.43.1723041423695; Wed, 07 Aug 2024
 07:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-7-sjg@chromium.org>
 <eb48b869-a130-46a0-b35b-22bdb30daa7f@gmx.de>
In-Reply-To: <eb48b869-a130-46a0-b35b-22bdb30daa7f@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 08:36:53 -0600
Message-ID: <CAFLszTgngCiS-Ajws3z8gXZAZM771iBLvT5Zn9oAaoqM_0B=jQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/39] bootstd: Create a function to reset USB
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 6 Aug 2024 at 19:56, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 06.08.24 14:58, Simon Glass wrote:
> > Set up a function for this, since it needs to be used from multiple test
> > files.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   test/boot/bootdev.c        | 19 ++++++-------------
> >   test/boot/bootstd_common.c | 12 ++++++++++++
> >   test/boot/bootstd_common.h |  8 ++++++++
> >   3 files changed, 26 insertions(+), 13 deletions(-)
> >
> > diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> > index 1bf5929c396..de16a51956d 100644
> > --- a/test/boot/bootdev.c
> > +++ b/test/boot/bootdev.c
> > @@ -16,13 +16,6 @@
> >   #include <test/ut.h>
> >   #include "bootstd_common.h"
> >
> > -/* Allow reseting the USB-started flag */
> > -#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
> > -extern bool usb_started;
> > -#else
> > -#include <usb.h>
> > -#endif
> > -
> >   /* Check 'bootdev list' command */
> >   static int bootdev_test_cmd_list(struct unit_test_state *uts)
> >   {
> > @@ -201,7 +194,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
> >       test_set_skip_delays(true);
> >
> >       /* Start up USB which gives us three additional bootdevs */
> > -     usb_started = false;
> > +     bootstd_reset_usb();
> >       ut_assertok(run_command("usb start", 0));
> >
> >       /*
> > @@ -317,7 +310,7 @@ static int bootdev_test_prio(struct unit_test_state *uts)
> >       test_set_eth_enable(false);
> >
> >       /* Start up USB which gives us three additional bootdevs */
> > -     usb_started = false;
> > +     bootstd_reset_usb();
> >       ut_assertok(run_command("usb start", 0));
> >
> >       ut_assertok(bootstd_test_drop_bootdev_order(uts));
> > @@ -357,7 +350,7 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
> >   {
> >       struct bootstd_priv *std;
> >
> > -     usb_started = false;
> > +     bootstd_reset_usb();
> >       test_set_skip_delays(true);
> >
> >       /* get access to the used hunters */
> > @@ -398,7 +391,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
> >       struct bootstd_priv *std;
> >
> >       test_set_skip_delays(true);
> > -     usb_started = false;
> > +     bootstd_reset_usb();
> >
> >       /* get access to the used hunters */
> >       ut_assertok(bootstd_get_priv(&std));
> > @@ -527,7 +520,7 @@ BOOTSTD_TEST(bootdev_test_bootable, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
> >   /* Check hunting for bootdev of a particular priority */
> >   static int bootdev_test_hunt_prio(struct unit_test_state *uts)
> >   {
> > -     usb_started = false;
> > +     bootstd_reset_usb();
> >       test_set_skip_delays(true);
> >
> >       console_record_reset_enable();
> > @@ -556,7 +549,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
> >       struct bootstd_priv *std;
> >       int mflags;
> >
> > -     usb_started = false;
> > +     bootstd_reset_usb();
> >
> >       /* get access to the used hunters */
> >       ut_assertok(bootstd_get_priv(&std));
> > diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
> > index e50539500a0..ff0aff4bbe7 100644
> > --- a/test/boot/bootstd_common.c
> > +++ b/test/boot/bootstd_common.c
> > @@ -20,6 +20,13 @@
> >   /* tracks whether bootstd_setup_for_tests() has been run yet */
> >   bool vbe_setup_done;
> >
> > +/* Allow resetting the USB-started flag */
> > +#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
> > +extern bool usb_started;
> > +#else
> > +#include <usb.h>
> > +#endif
>
> Why can't you always include usb.h which defines usb_started?
> Is there a bug in usb.h?

I can, but even in tests it is not great to access globals. Having it
in a function lets us call out these particular settings better, which
has aided debugging, at least for me. These tests are special in that
they are not DM tests, but do stop USB.

Regards,
Simon
