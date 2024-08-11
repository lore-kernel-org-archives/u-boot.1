Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56469C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39CA8888B7;
	Sun, 11 Aug 2024 16:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KYw42Vw3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86EBE888A7; Sun, 11 Aug 2024 16:50:34 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 002FC87E9D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-8205ceff95cso1172942241.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387831; x=1723992631; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5WLgr1ZMkYRUpojjm7lrChDJnV7edvKOO8FPdAGLUw0=;
 b=KYw42Vw3iIa6gCelFnR6qdCDNoC2TWeaXM+a64xfiGur90P58EdQLlm54eRwpGo1sI
 ZE8ORKP7bHI4l8ZKbmQWSr9PkJSC5v97aqe2/tW81LRYp0NzLzAhsdEimi7RvBgnXkKP
 S5/TIpGz7RYDdab+K0PPCV9BFpo+g6SL94yvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387831; x=1723992631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5WLgr1ZMkYRUpojjm7lrChDJnV7edvKOO8FPdAGLUw0=;
 b=qvkOHYdiWpEOGMFRyDSzznciecZUGk0AoDMslHBXPBuifZmKzin9P5rRSvdl1GNZqg
 9CPMSjcVaOKdJ1V/+Isytc3y+HY/mKbgkQyLIaXoDRBzvHAdPEbTtDAqUo1iMYF4tJay
 g0Y/rGL95o2kEHp+f+0WsDtNV8G+hwnoB4L1hn5qXNEhrZQS1dqMsb0W9yImP+P2SyvU
 HGQiSdkmQeRcL2ICqn84Ppc4Gr23+R6PJlivvny7/m8MhKTggcFzhEZHt9eLFPCXQGPk
 aHDeVbBEh2HTxaDv5Uee16IIII0FhEMVHsf+U5o0I4yGZbQfkQspOGwsj8UVaXeVrGQs
 ArEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA4DUE1SlLc9WogDkHL63QY1l6otCJQCVoEYcmfE8zlBsiQbBTcGNY2wKhm6rDYbTRtumQ7jYNMhx8bbZ+CxxDOKT/rA==
X-Gm-Message-State: AOJu0Yw0oMZb3VEnIzeQ8qlAO0d768zEMtS4+spclaRj3d7J5SjWo2hf
 xBg4fxFj15P4TeMQwJzymYUr1Do4C8eUM5uwkPO5wOBluEvoDGe/EZAu6s9QQic4ijFElByx36P
 bjAGD5Imt21BFrdvJubMnBkLOHmX1iDlHs5Rf
X-Google-Smtp-Source: AGHT+IFn47WcVeffH+2SUfXirViByWOvREGb1B9HE6HvESP7Eloa+hqNT6pUUhTDWODU3BcnS5+/aoH1s74KFIyEUuY=
X-Received: by 2002:a05:6102:cd1:b0:494:829:835b with SMTP id
 ada2fe7eead31-495d8404772mr7947817137.9.1723387830776; Sun, 11 Aug 2024
 07:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-7-sjg@chromium.org>
 <eb48b869-a130-46a0-b35b-22bdb30daa7f@gmx.de>
 <CAFLszTgngCiS-Ajws3z8gXZAZM771iBLvT5Zn9oAaoqM_0B=jQ@mail.gmail.com>
 <ecbf0aab-0632-4848-8c68-b612c907ec23@gmx.de>
In-Reply-To: <ecbf0aab-0632-4848-8c68-b612c907ec23@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:20 -0600
Message-ID: <CAFLszThkZXD_0NF9nBOFgKj9F58TXZwS2rrOs-VoBQyonfHQag@mail.gmail.com>
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

On Thu, 8 Aug 2024 at 15:12, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.08.24 16:36, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 6 Aug 2024 at 19:56, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 06.08.24 14:58, Simon Glass wrote:
> >>> Set up a function for this, since it needs to be used from multiple test
> >>> files.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> (no changes since v1)
> >>>
> >>>    test/boot/bootdev.c        | 19 ++++++-------------
> >>>    test/boot/bootstd_common.c | 12 ++++++++++++
> >>>    test/boot/bootstd_common.h |  8 ++++++++
> >>>    3 files changed, 26 insertions(+), 13 deletions(-)
> >>>
> >>> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> >>> index 1bf5929c396..de16a51956d 100644
> >>> --- a/test/boot/bootdev.c
> >>> +++ b/test/boot/bootdev.c
> >>> @@ -16,13 +16,6 @@
> >>>    #include <test/ut.h>
> >>>    #include "bootstd_common.h"
> >>>
> >>> -/* Allow reseting the USB-started flag */
> >>> -#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
> >>> -extern bool usb_started;
> >>> -#else
> >>> -#include <usb.h>
> >>> -#endif
> >>> -
> >>>    /* Check 'bootdev list' command */
> >>>    static int bootdev_test_cmd_list(struct unit_test_state *uts)
> >>>    {
> >>> @@ -201,7 +194,7 @@ static int bootdev_test_order(struct unit_test_state *uts)
> >>>        test_set_skip_delays(true);
> >>>
> >>>        /* Start up USB which gives us three additional bootdevs */
> >>> -     usb_started = false;
> >>> +     bootstd_reset_usb();
> >>>        ut_assertok(run_command("usb start", 0));
> >>>
> >>>        /*
> >>> @@ -317,7 +310,7 @@ static int bootdev_test_prio(struct unit_test_state *uts)
> >>>        test_set_eth_enable(false);
> >>>
> >>>        /* Start up USB which gives us three additional bootdevs */
> >>> -     usb_started = false;
> >>> +     bootstd_reset_usb();
> >>>        ut_assertok(run_command("usb start", 0));
> >>>
> >>>        ut_assertok(bootstd_test_drop_bootdev_order(uts));
> >>> @@ -357,7 +350,7 @@ static int bootdev_test_hunter(struct unit_test_state *uts)
> >>>    {
> >>>        struct bootstd_priv *std;
> >>>
> >>> -     usb_started = false;
> >>> +     bootstd_reset_usb();
> >>>        test_set_skip_delays(true);
> >>>
> >>>        /* get access to the used hunters */
> >>> @@ -398,7 +391,7 @@ static int bootdev_test_cmd_hunt(struct unit_test_state *uts)
> >>>        struct bootstd_priv *std;
> >>>
> >>>        test_set_skip_delays(true);
> >>> -     usb_started = false;
> >>> +     bootstd_reset_usb();
> >>>
> >>>        /* get access to the used hunters */
> >>>        ut_assertok(bootstd_get_priv(&std));
> >>> @@ -527,7 +520,7 @@ BOOTSTD_TEST(bootdev_test_bootable, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
> >>>    /* Check hunting for bootdev of a particular priority */
> >>>    static int bootdev_test_hunt_prio(struct unit_test_state *uts)
> >>>    {
> >>> -     usb_started = false;
> >>> +     bootstd_reset_usb();
> >>>        test_set_skip_delays(true);
> >>>
> >>>        console_record_reset_enable();
> >>> @@ -556,7 +549,7 @@ static int bootdev_test_hunt_label(struct unit_test_state *uts)
> >>>        struct bootstd_priv *std;
> >>>        int mflags;
> >>>
> >>> -     usb_started = false;
> >>> +     bootstd_reset_usb();
> >>>
> >>>        /* get access to the used hunters */
> >>>        ut_assertok(bootstd_get_priv(&std));
> >>> diff --git a/test/boot/bootstd_common.c b/test/boot/bootstd_common.c
> >>> index e50539500a0..ff0aff4bbe7 100644
> >>> --- a/test/boot/bootstd_common.c
> >>> +++ b/test/boot/bootstd_common.c
> >>> @@ -20,6 +20,13 @@
> >>>    /* tracks whether bootstd_setup_for_tests() has been run yet */
> >>>    bool vbe_setup_done;
> >>>
> >>> +/* Allow resetting the USB-started flag */
> >>> +#if defined(CONFIG_USB_HOST) || defined(CONFIG_USB_GADGET)
> >>> +extern bool usb_started;
> >>> +#else
> >>> +#include <usb.h>
> >>> +#endif
> >>
> >> Why can't you always include usb.h which defines usb_started?
> >> Is there a bug in usb.h?
> >
> > I can, but even in tests it is not great to access globals. Having it
> > in a function lets us call out these particular settings better, which
> > has aided debugging, at least for me. These tests are special in that
> > they are not DM tests, but do stop USB.
>
> I was just wondering if we can can rid of the #if here. That should not
> stop you from creating a function to access the variable.

Ah, I see. Yes, it is an artifact of it being built for boards without
USB, but now we only build for sandbox, so I can drop that.

Regards,
Simon
