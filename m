Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB89AEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 19:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D74286D3C;
	Sun, 10 Sep 2023 21:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sr/Hbxll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D4C86D14; Sun, 10 Sep 2023 21:14:58 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8567E86D0E
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ab244f2c89so2891243b6e.3
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694373287; x=1694978087; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7R2cukMRb2zFm6hs1Acgf/c+GUvZlDBfejwWXzV9WMk=;
 b=Sr/HbxllpUosaH6t5HrDwb9hkYWopU7RDUfeR9edmOZORFHEi3FrqW6My7yS7pkGdU
 I8egz3pUzd8I43oscFFpcR4CxLFdwH9XLWOQe+GVuF3QMqx3gOFfeOi78fIMGtnuGTkw
 zjaP9VlzXrDTMmDk5wJ5rLanj2H8eopJxpMBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694373287; x=1694978087;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7R2cukMRb2zFm6hs1Acgf/c+GUvZlDBfejwWXzV9WMk=;
 b=O6ez/Y5H8col+jcQmC1j/3nZd2iS6B07mUrx7k/glEgIu8kLpJZLsgxa0wnAQcHR/x
 OtSZ4iYxDYXrp2781YVWlFULaAVes9g07p9iea406vVHECjCxXeEEO9zrqcgUZuHaFfi
 BAcGpKNDFrDoqhaJZhzr7/JfSxl3l5N8kRbfjdJgRA9VrPEi6rhEcgtElFbJM4f7mhF9
 0CBrkeorQf8+TOTebaxuw/tvUQeWu4BB3eH0t5+ZVaMRrLogw4VanTfedeCXbfbK2WVg
 QrYNYiANVf+Uw1i3cCDrMfl78qvOO41xEjFwHJSTPCZF2kOMmxQg61Xv6Xc5pLAiFToR
 GsSg==
X-Gm-Message-State: AOJu0YzdvqJXXSiZZ5mvp87RAHs3OSMZAaK0XP050QbfHJEH1AyY5Y8y
 GVq73AowWauCF8UWfV97ZqyBdviYsGN9oTOR8h9uFw==
X-Google-Smtp-Source: AGHT+IGr5c6Gsw2REYpuF54RFI6QjsTWHTCwGXq361UvNwzInlTS6vhXLYEGxBoKwaBJs33IlIyl2CeNK6sstHwh7f4=
X-Received: by 2002:a05:6808:1b1f:b0:3a8:50ba:fb1 with SMTP id
 bx31-20020a0568081b1f00b003a850ba0fb1mr11106276oib.18.1694373286991; Sun, 10
 Sep 2023 12:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-5-takahiro.akashi@linaro.org>
 <CAPnjgZ3z1srw_ZxfV2aRz1FAzTR=M==_rRPMFFrd7BdrGsu4AQ@mail.gmail.com>
 <ZPqjz3+Mlla8zxDS@octopus>
In-Reply-To: <ZPqjz3+Mlla8zxDS@octopus>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 13:13:24 -0600
Message-ID: <CAPnjgZ3Va35FLk6xF8iyoKtSe5_F_o8Ym7o8jdgXtGMUS6MJ3w@mail.gmail.com>
Subject: Re: [RFC 4/6] gpio: add scmi driver based on pinctrl
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 etienne.carriere@st.com, michal.simek@amd.com, linus.walleij@linaro.org, 
 Oleksii_Moisieiev@epam.com
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

Hi,

On Thu, 7 Sept 2023 at 22:32, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, Sep 07, 2023 at 06:23:05AM -0600, Simon Glass wrote:
> > Hi AKASHI,
> >
> > On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
> > <takahiro.akashi@linaro.org> wrote:
> > >
> > > This DM-compliant driver deals with SCMI pinctrl protocol and presents
> > > gpio devices exposed by SCMI firmware (server).
> > >
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > >  drivers/pinctrl/pinctrl-scmi.c | 544 ++++++++++++++++++++++++++++++++-
> > >  1 file changed, 539 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> > > index 3ebdad57b86c..73d385bdbfcc 100644
> > > --- a/drivers/pinctrl/pinctrl-scmi.c
> > > +++ b/drivers/pinctrl/pinctrl-scmi.c
> > > @@ -11,21 +11,20 @@
> > >  #include <malloc.h>
> > >  #include <scmi_agent.h>
> > >  #include <scmi_protocols.h>
> > > +#include <asm-generic/gpio.h>
> > >  #include <dm/device_compat.h>
> > > +#include <dm/device-internal.h>
> > > +#include <dm/lists.h>
> > >  #include <dm/pinctrl.h>
> > >
> > [..]
> >
> > > +
> > > +U_BOOT_DRIVER(scmi_gpio) = {
> > > +       .name = "scmi_gpio",
> > > +       .id = UCLASS_GPIO,
> > > +       .of_match = scmi_gpio_ids,
> > > +       .of_to_plat = scmi_gpio_probe,
> > > +       .ops = &scmi_gpio_ops,
> > > +       .plat_auto = sizeof(struct scmi_pinctrl_gpio_plat),
> > > +};
> > > +
> > > +/**
> > > + * scmi_gpiochip_register - Create a pinctrl-controlled gpio device
> > > + * @parent:    SCMI pinctrl device
> > > + *
> > > + * Create a pinctrl-controlled gpio device
> > > + *
> > > + * Return:     0 on success, error code on failure
> > > + */
> > > +static int scmi_gpiochip_register(struct udevice *parent)
> > > +{
> > > +       ofnode node;
> > > +       struct driver *drv;
> > > +       struct udevice *gpio_dev;
> > > +       int ret;
> > > +
> > > +       /* TODO: recovery if failed */
> > > +       dev_for_each_subnode(node, parent) {
> > > +               if (!ofnode_is_enabled(node))
> > > +                       continue;
> >
> > Can we not rely on the normal driver model binding to bind these
> > devices? Why does it need to be done manually here?
>
> First, please take a look at the cover letter.
> In this RFC, I basically assume two patterns of DT bindings,
> (A) and (B) in the cover letter (or sandbox's test.dts in patch#5).
>
> In (B), a DT node as a gpio device, which is essentially a child
> of pinctrl device, is located *under* a pinctrl device. It need
> to be probed manually as there is no implicit method to enumerate
> it as a DM device automatically.

You could add a post_bind() method to the pinctrl uclass to call
dm_scan_fdt_dev() as we do with TPM.

>
> On the other hand, in (A), the same node can be put anywhere in a DT
> as it contains a "compatible" property to identify itself.
> So if we want to only support (A), scmi_gpiochip_register() and
> scmi_pinctrl_bind() are not necessary.
>
> Since there is no discussion about bindings for GPIO managed by SCMI
> pinctrl device yet on the kernel side, I have left two solutions
> in this RFC.


OK.

[..]

Regards,
Simon
