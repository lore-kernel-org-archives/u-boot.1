Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1047EE57C1
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 04:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 925E186467;
	Fri,  8 Sep 2023 06:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yl1IRYR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FECB86564; Fri,  8 Sep 2023 06:32:23 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BEBA86456
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 06:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1a2dd615ddcso501380fac.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 21:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694147538; x=1694752338; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P2Vx4lkKLAIiF9Rr0YRH40RpkQKb3l5GJXytrYan60Y=;
 b=Yl1IRYR5ccn5H5Zj00So3gVqsxocu8bNRadX7TW/1vboU0ec/QqkhEnnRSOXlobdy3
 PTtMXkZbdOes7QoseSA/SWR1jM+eiqAQ6Lwba37JDEt86CXAozAbethId9/bZvawpkDZ
 ogKwTyQgent8Q4cCdBy9rsCMeGSeP2OSp16EDbYwRiET6h/oaCh70hK6iShcK1ED4Mg0
 eyjkAyVkwoBp356VdgbqEnNFEkYrsNmBL3BI0lL2vU7ioS399R5q+pNbx/F8Bvf25TrH
 1jchActFtD15wm+HMGfj/YcWZtjUj14NYmgOGcTs3+CdoJolnBTVrSCKrYRnC0wPTDNo
 4NFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694147539; x=1694752339;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P2Vx4lkKLAIiF9Rr0YRH40RpkQKb3l5GJXytrYan60Y=;
 b=Ab/X2tUaKaXFMlfiTHUX82BHYL/0sfcZjIdU1sJKwjOy/deV9876y7NYUypvymtLEn
 iGA7wRU+n41Bqno3dpjCJIffx15uKJMO46jc7j5wA5AyYBYaI31rkN+Z/90OBbK2EuWa
 5uRvjeCwHLZAeUoiu/WCiNeX5Mc04YR2dSPXxlbd1k8p444wbKYiC/M4Yhd+VdTMGIEa
 NWOqlXuqGdgyPXCsn7preaOAmSV1RFexEBZY+PL0TRA2GlWn1/k4Xl7nK4g9kdSmfexg
 YUOVBaNuD6cuA8uqsfVfIXA1gojITuonCaVzo9E82TkWUsxjzUI5IU8w7R7TLxkGRTU7
 vpbg==
X-Gm-Message-State: AOJu0Ywv0MlOvwVVmmGpekYODnwA4k7GOoVmuk+DpWVZMWmsaA0nALqS
 GL4bogY07cq5K9tWd1Zw4zfJQA==
X-Google-Smtp-Source: AGHT+IE3o9BN7l13ncbi3n0Gnl3pxB3Lk7WV6jSHVtGwODiCD670MuYpXfG4yuqDLVBa7KquoKeAng==
X-Received: by 2002:a05:6870:ecac:b0:1d0:e371:e20a with SMTP id
 eo44-20020a056870ecac00b001d0e371e20amr1760841oab.2.1694147538654; 
 Thu, 07 Sep 2023 21:32:18 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:2d89:7669:ac2d:f09e])
 by smtp.gmail.com with ESMTPSA id
 q22-20020a637516000000b005741b5eee47sm34496pgc.10.2023.09.07.21.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 21:32:18 -0700 (PDT)
Date: Fri, 8 Sep 2023 13:32:15 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
Subject: Re: [RFC 4/6] gpio: add scmi driver based on pinctrl
Message-ID: <ZPqjz3+Mlla8zxDS@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-5-takahiro.akashi@linaro.org>
 <CAPnjgZ3z1srw_ZxfV2aRz1FAzTR=M==_rRPMFFrd7BdrGsu4AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3z1srw_ZxfV2aRz1FAzTR=M==_rRPMFFrd7BdrGsu4AQ@mail.gmail.com>
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

Hi Simon,

On Thu, Sep 07, 2023 at 06:23:05AM -0600, Simon Glass wrote:
> Hi AKASHI,
> 
> On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > This DM-compliant driver deals with SCMI pinctrl protocol and presents
> > gpio devices exposed by SCMI firmware (server).
> >
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  drivers/pinctrl/pinctrl-scmi.c | 544 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 539 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> > index 3ebdad57b86c..73d385bdbfcc 100644
> > --- a/drivers/pinctrl/pinctrl-scmi.c
> > +++ b/drivers/pinctrl/pinctrl-scmi.c
> > @@ -11,21 +11,20 @@
> >  #include <malloc.h>
> >  #include <scmi_agent.h>
> >  #include <scmi_protocols.h>
> > +#include <asm-generic/gpio.h>
> >  #include <dm/device_compat.h>
> > +#include <dm/device-internal.h>
> > +#include <dm/lists.h>
> >  #include <dm/pinctrl.h>
> >
> [..]
> 
> > +
> > +U_BOOT_DRIVER(scmi_gpio) = {
> > +       .name = "scmi_gpio",
> > +       .id = UCLASS_GPIO,
> > +       .of_match = scmi_gpio_ids,
> > +       .of_to_plat = scmi_gpio_probe,
> > +       .ops = &scmi_gpio_ops,
> > +       .plat_auto = sizeof(struct scmi_pinctrl_gpio_plat),
> > +};
> > +
> > +/**
> > + * scmi_gpiochip_register - Create a pinctrl-controlled gpio device
> > + * @parent:    SCMI pinctrl device
> > + *
> > + * Create a pinctrl-controlled gpio device
> > + *
> > + * Return:     0 on success, error code on failure
> > + */
> > +static int scmi_gpiochip_register(struct udevice *parent)
> > +{
> > +       ofnode node;
> > +       struct driver *drv;
> > +       struct udevice *gpio_dev;
> > +       int ret;
> > +
> > +       /* TODO: recovery if failed */
> > +       dev_for_each_subnode(node, parent) {
> > +               if (!ofnode_is_enabled(node))
> > +                       continue;
> 
> Can we not rely on the normal driver model binding to bind these
> devices? Why does it need to be done manually here?

First, please take a look at the cover letter.
In this RFC, I basically assume two patterns of DT bindings,
(A) and (B) in the cover letter (or sandbox's test.dts in patch#5).

In (B), a DT node as a gpio device, which is essentially a child
of pinctrl device, is located *under* a pinctrl device. It need
to be probed manually as there is no implicit method to enumerate
it as a DM device automatically.

On the other hand, in (A), the same node can be put anywhere in a DT
as it contains a "compatible" property to identify itself.
So if we want to only support (A), scmi_gpiochip_register() and
scmi_pinctrl_bind() are not necessary.

Since there is no discussion about bindings for GPIO managed by SCMI
pinctrl device yet on the kernel side, I have left two solutions
in this RFC.

Thanks,
-Takakahiro Akashi


> > +
> > +               if (!ofnode_read_prop(node, "gpio-controller", NULL))
> > +                       /* not a GPIO node */
> > +                       continue;
> > +
> > +               drv = DM_DRIVER_GET(scmi_gpio);
> > +               if (!drv) {
> > +                       dev_err(parent, "No gpio driver?\n");
> > +                       return -ENODEV;
> > +               }
> > +
> > +               ret = device_bind(parent, drv, ofnode_get_name(node), NULL,
> > +                                 node, &gpio_dev);
> > +               if (ret) {
> > +                       dev_err(parent, "failed to bind %s to gpio (%d)\n",
> > +                               ofnode_get_name(node), ret);
> > +                       return -ENODEV;
> > +               }
> > +
> > +               return 0;
> > +       }
> > +
> > +       return -ENODEV;
> > +}
> > +
> 
> Regards,
> Simon
