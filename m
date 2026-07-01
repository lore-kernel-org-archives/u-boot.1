Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABC3C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 19:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D6A84C39;
	Wed,  1 Jul 2026 21:57:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TkOE4PV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C085784C3A; Wed,  1 Jul 2026 21:57:20 +0200 (CEST)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com
 [IPv6:2607:f8b0:4864:20::b12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B188407E
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 21:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-6626b5ace23so2343818d50.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 12:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935836; cv=none;
 d=google.com; s=arc-20260327;
 b=adpNYOeKpAowkqBHL5tExu3FpgTHmiS+Ge48aD9kK3Nf8BmCukGOmBI3FEwC/uF5PO
 +r7pfubw0bDhkeFFzSTtZUUWMUr5k0GxATlLFY4QGm5y01jnKXevZkZwIZbcvsHt2pRV
 FSr0gDPZRti+TQcW4hilkvqE4YRB0VuVRa4FsAO9aNlciC2Se75hTGnxEcuykWfNRmPi
 fxSpXs8+qkjuJ0PgZuHuuHZpDq+cXbityz+H3ChqgFBBQFwy2xLA+yUxLMVjIrY2aA0y
 XB5Jii/xZoD2IjJjdkN4oF+wu7rlx2f7Z9XfpVhGM+4YJtzeio5uFz10kCmYNFLayVCP
 qYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/RN7MTc7A0rVkrwuywBfYAXcmU18vrzKNF4P1fY4Wlg=;
 fh=WE1LX1bimigcIadjHfT8o2Jf52ynXw4k3oU0ZbYyLLs=;
 b=rGPs5cy+s9+nsv5FF3ChcRPRnDgUc01Ww44A7J7o7hFtabER/Y+X1zlsAiA4k0AwD7
 ES7d6hR+nuDe7Rkv2jfNiiwqMykK7gQc/TCvg/zi9NTC6UJm+kGs5pULJYBfIgIYKO6V
 MLQqHuX52wN8PCL/v9WzThJs4t/cxnSTYNY++u8/84ZlCanGBhx5lGRTkp6u0vz/fVWL
 UnJ7LkSqTIo3KZd59IL/5JBaIt6jnuNfLbyh+TzeL0ZK252MKvs8MC0zmOYTe0HZ91k1
 8WpgQ5YXF5p4nFrN4B6Q4ZgdkN0pWyfqYuegEtlrCzKycshVT2NeKf/MegLvmQ15iE4E
 f/CA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782935836; x=1783540636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/RN7MTc7A0rVkrwuywBfYAXcmU18vrzKNF4P1fY4Wlg=;
 b=TkOE4PV4gzdqurJXk/h+4N8ZliHakJ1JCtsDtp7lX9IGRwkXMsWba6m6eFtqJaJB9J
 58YLC/n5mn/aCg4EblT3QC87FSgX0eepd0h+Ww6S9eUDomoI20Sd0rEDWV13CP3DBsf1
 sfUTqje6I85HrzorTFUI0RdM2gU1v7VkcT6TN9vNUBH6BGdu2P1iNkx2+kSS6DR0718D
 hk+RePdEsmM9MkQ32xAgccQCNp8cvWQs8YyPdv3XW2kRoSO1VOD39EC6oeEZbVb43TSu
 bpdee6HcltSRjq1X6zmCgetsmgZVWfZasKpzOPD0skvaPQ7L6D/6BkABj6jypqJ8a1yR
 OyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782935836; x=1783540636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/RN7MTc7A0rVkrwuywBfYAXcmU18vrzKNF4P1fY4Wlg=;
 b=hIfbt/jGRIRbK1JTNSnpuvjIaYnlMKpGEu3LVc9JN1tHO/hy6joVG+8nJ56oKDhZy8
 5wMKnwcbAE667NMQaPlLb2qthaU9Tz9XPgYS8K9CHoxINu3risauxiWFR83hq2gHD8Xi
 K6L2w8q0QMR91vvYJx2zsOE0Ni1nBVXR+7MDyemBOvSBJ8UxKemt/W0PFvrXuX/mNO7e
 8B9UjRxvK8ya6Z/69FpQ5n3HKdhCtZypwtADiFyyfJP5qYNjWh3AAJ6fVsh6yLqeXBRq
 gPwt46KJ02ogAREh1+Zsllj563QjMWtBlUPmR/PzlwjUGSlgQuiZ9GNPRX725B6CG/AS
 AI1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrUaMeZiJlp3ZaYGyLTio5AvNXFKN7UK9hLW2oMP8ktB/h2iMNkeQ7cZb/0tax1HLtQmlXSQiw=@lists.denx.de
X-Gm-Message-State: AOJu0YxxldyqKIadyGEmHdbX2k12m51kH5MGE1Azj+c/2Fgh34HBixUe
 0ekClsXSoLar7m3K59PRPMJKfLoFkDCeyvnRjit0Ee+2Qhv8dFHASWgEvA8CnkohqzYR89CW8jp
 FpvoXpYPt17HCp7Kdni+HdgG6O36iQzSJuB9gIh/5jQ==
X-Gm-Gg: AfdE7ckBQ3hHofO1JI78xDO09iG0nXcsXK5x4kKCyw3MWutcpGmvWHqoRvSBrSVKbcp
 y+dj1m8IdvWmNjFs9r38UeDzxXJ/5cZdC/t1dqk5kPuoyRsnjduyr4f38t0x/AomHVg+ACFb52V
 BJHeOyKOV141UQ5eYbt0H1/ffWHfTXjVpCYJg7q6vnS6yE5+XgY80bO0yLgeAL+UApUvb2qxuOq
 RJ19RisfTdbDOaUlWJWUWqihNjgt1E4rObAxiGZeaVR4+MPXLSCVI1w6lTbT5VtLIhNczLEd4Lb
 BCj/Ts4UURVwKXdJolFNggmbKTx6mqy5oEGpVlo86ZQS8a3R7NPZtCq8zJAgBFiuYYIMuOqp7jE
 ngx5Rwp2HdKKPHo8rvxr55MJaZKBigfdf11c0gwbcnYw3XcgDsWQpaSwtjt2UtSzfRiwzBp2ANk
 GIhP66JnLuOBa+zi7NrzW592DaNwcMx1l+625VH+r0XCjBLq2vbXTznt9tRC21lo/Mi8BqFikQx
 JXZmzpLsKIpNNBMz7Ijj3HNi3bH1GK+ro+knLKo3YcdvYQL+6OWcaNNqpwXovzUoLb+KOu7sa/g
 xP7lFZAYrw3I2GPV2BptgEFGEGAxSXSGt85Tuf6NWRm2jiRAPrV/gKHDWHTygl4C9YCBm88C
X-Received: by 2002:a05:690e:4093:b0:664:de4f:7a95 with SMTP id
 956f58d0204a3-665077510d8mr6155289d50.0.1782935836221; Wed, 01 Jul 2026
 12:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <8733y48j44.fsf@kernel.org> <87zf0c6td8.fsf@kernel.org>
 <87v7az6l03.fsf@kernel.org>
In-Reply-To: <87v7az6l03.fsf@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 22:56:40 +0300
X-Gm-Features: AVVi8Cfp2hi4sOgBMaBHaZLK5bL9C5qLmrGtNGeO54ZvgrpfIB7mEnoZzLKfKYU
Message-ID: <CAC_iWjJnFVq-nW+EoB-svBZuXf5kjOiwXHcMV9BHfujpMVg+Gw@mail.gmail.com>
Subject: Re: [PATCH v4 00/64] drivers: usb: dwc3: sync code with Linux v6.16
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>, Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
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

Thanks Mattijs,

This helps a lot

Cheers
/Ilias


On Wed, 1 Jul 2026 at 13:51, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Jens,
>
> On Tue, Jun 30, 2026 at 15:38, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
>
> > On Tue, Jun 30, 2026 at 11:36, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> >
> >>
> >> I've tried this out on the Khadas VIM3 board using
> >> khadas-vim3_android_defconfig and usb gadget (with fastboot) seems to
> >> misbehave.
> >>
> >> With the series applied, I see:
> >> """
> >> U-Boot 2026.07-rc3-00064-g511db6941796 (Jun 30 2026 - 11:20:08 +0200) khadas-vim3
> >>
> >> Model: Khadas VIM3
> >> SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
> >> DRAM:  2 GiB (total 3.8 GiB)
> >> Core:  408 devices, 37 uclasses, devicetree: separate
> >> MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
> >> Loading Environment from MMC... MMC Device -1 not found
> >> *** Warning - No MMC card found, using default environment
> >>
> >> In:    usbkbd,serial
> >> Out:   vidconsole,serial
> >> Err:   vidconsole,serial
> >> Net:   eth0: ethernet@ff3f0000
> >>
> >> Hit any key to stop autoboot: 0
> >> => fastboot usb 0
> >> failed to start <NULL>: -12
> >> g_dnl_register: failed!, error: -12
> >> exit not allowed from main input shell.
> >> """
> >>
> >> With v2026.07-rc3, I see:
> >> """
> >> U-Boot 2026.07-rc3 (Jun 30 2026 - 11:24:04 +0200) khadas-vim3
> >>
> >> Model: Khadas VIM3
> >> SoC:   Amlogic Meson G12B (A311D) Revision 29:b (10:2)
> >> DRAM:  2 GiB (total 3.8 GiB)
> >> Core:  408 devices, 37 uclasses, devicetree: separate
> >> MMC:   mmc@ffe03000: 0, mmc@ffe05000: 1, mmc@ffe07000: 2
> >> Loading Environment from MMC... MMC Device -1 not found
> >> *** Warning - No MMC card found, using default environment
> >>
> >> In:    usbkbd,serial
> >> Out:   vidconsole,serial
> >> Err:   vidconsole,serial
> >> Net:   eth0: ethernet@ff3f0000
> >>
> >> Hit any key to stop autoboot: 0
> >> => fastboot usb 0
> >> crq->brequest:0x0
> >> """
> >>
> >> The failure code path seems to go through:
> >> g_dnl_register("usb_dnl_fastboot");
> >>   usb_composite_register(&g_dnl_driver);
> >>     usb_gadget_register_driver(&composite_driver);
> >>       usb_gadget_probe_driver(driver);
> >>         udc_bind_to_driver(udc, driver);
> >>           driver->bind(udc->gadget);
> >>
> >>
> >> I don't know why it's happening but I wanted to give some feedback early
> >> on.
> >> I'll have a closer look.
> >
> > I spend a bit more time on this.
> >
> > driver->bind() calls fastboot_bind() which fails to configure the input
> > endpoint with the following code:
> >
> >       f_fb->in_ep = usb_ep_autoconfig(gadget, &fs_ep_in);
> >
> > Looking more closely at usb_ep_autoconfig():
> > * in v2026.07-rc3 we have an ep_matches() that finds the relevant
> >   endpoint
> > * with this series, we now have usb_gadget_ep_match_desc() which does
> >   not behave the same way.
> >
> > If i put back the original ep_matches() implementation (from
> > v2026.07-rc3) and call that instead of usb_gadget_ep_match_desc() in
> > usb_ep_autoconfig_ss(), I can use fastboot again.
> >
> > I have not studied how different ep_matches() and
> > usb_gadget_ep_match_desc() are.
>
> usb_gadget_ep_match_desc() uses the endpoint's capabilities (the cap
> member of that struct) to find matching endpoints.
> This is significantly different from ep_matches(), which relied on
> endpoint names.
>
> Because of this change, I had to add the following diff to
> drivers/usb/gadget/dwc2_udc_otg.c:
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
> index 9f037d1e8016..01c9a938bd79 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -741,6 +741,7 @@ static const struct usb_gadget_ops dwc2_udc_ops = {
>  #endif
>  };
>
>  static struct dwc2_udc memory = {
>         .usb_address = 0,
>         .gadget = {
> @@ -755,6 +756,11 @@ static struct dwc2_udc memory = {
>                         .name = ep0name,
>                         .ops = &dwc2_ep_ops,
>                         .maxpacket = EP0_FIFO_SIZE,
> +                       .caps = {
> +                               .type_control = 1,
> +                               .dir_in = 1,
> +                               .dir_out = 1,
> +                       },
>                 },
>                 .dev = &memory,
>
> @@ -770,6 +776,10 @@ static struct dwc2_udc memory = {
>                         .name = "ep1in-bulk",
>                         .ops = &dwc2_ep_ops,
>                         .maxpacket = EP_FIFO_SIZE,
> +                       .caps = {
> +                               .type_bulk = 1,
> +                               .dir_in = 1,
> +                       },
>                 },
>                 .dev = &memory,
>
> @@ -785,6 +795,10 @@ static struct dwc2_udc memory = {
>                         .name = "ep2out-bulk",
>                         .ops = &dwc2_ep_ops,
>                         .maxpacket = EP_FIFO_SIZE,
> +                       .caps = {
> +                               .type_bulk = 1,
> +                               .dir_out = 1,
> +                       },
>                 },
>                 .dev = &memory,
>
> @@ -800,6 +814,10 @@ static struct dwc2_udc memory = {
>                         .name = "ep3in-int",
>                         .ops = &dwc2_ep_ops,
>                         .maxpacket = EP_FIFO_SIZE,
> +                       .caps = {
> +                               .type_int = 1,
> +                               .dir_in = 1,
> +                       },
>                 },
>
> This was not sufficient. I also had to update the .maxpacket fields to
> .maxpacket_limit as following:
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
> index 01c9a938bd79..4a62cd60cb7d 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -755,7 +755,7 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = ep0name,
>                         .ops = &dwc2_ep_ops,
> -                       .maxpacket = EP0_FIFO_SIZE,
> +                       .maxpacket_limit = EP0_FIFO_SIZE,
>                         .caps = {
>                                 .type_control = 1,
>                                 .dir_in = 1,
> @@ -775,7 +775,7 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = "ep1in-bulk",
>                         .ops = &dwc2_ep_ops,
> -                       .maxpacket = EP_FIFO_SIZE,
> +                       .maxpacket_limit = EP_FIFO_SIZE,
>                         .caps = {
>                                 .type_bulk = 1,
>                                 .dir_in = 1,
> @@ -794,7 +794,7 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = "ep2out-bulk",
>                         .ops = &dwc2_ep_ops,
> -                       .maxpacket = EP_FIFO_SIZE,
> +                       .maxpacket_limit = EP_FIFO_SIZE,
>                         .caps = {
>                                 .type_bulk = 1,
>                                 .dir_out = 1,
> @@ -813,7 +813,7 @@ static struct dwc2_udc memory = {
>                 .ep = {
>                         .name = "ep3in-int",
>                         .ops = &dwc2_ep_ops,
> -                       .maxpacket = EP_FIFO_SIZE,
> +                       .maxpacket_limit = EP_FIFO_SIZE,
>                         .caps = {
>                                 .type_int = 1,
>                                 .dir_in = 1,
>
> Because this series introduces usb_gadget_ep_match_desc(), we should
> make sure that all the in-tree udc drivers have these capabilities set.
>
> In my opinion, we should do this as part of this series, otherwise we
> are breaking all the UDC drivers.
>
> Note that all drivers might not require this update, since drivers can
> also implement the usb_gadget_ops.match_ep() function instead.
>
> >
> >>
> >> Thanks,
> >> Mattijs
> >>
