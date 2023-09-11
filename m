Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58591EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 05:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C618286582;
	Mon, 11 Sep 2023 07:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XWd4cpBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD1A86579; Mon, 11 Sep 2023 07:38:31 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6701386579
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 07:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c0efe0c4acso6711905ad.0
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 22:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694410706; x=1695015506; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVhlFGUK5LEgRx8qisGAfCLuK5DsF5OvsljG2ziyEA8=;
 b=XWd4cpBnamjhQBee/K/VNKnCUBv9gp396WjGkC2xnKoVMWleRCiNKHpxnwqEo4Wi6Z
 Gyo//z8bc7Xbk92/YG0zn2ncLoBk9fO+nBg3aU5ZTexb95CJyyfZKe3XKRDrttlZ5vrx
 SSnqesYqmMzaxuA49GjlwtQYOknmkaxaTPK08s4pajJ6pJ5YsaN38Rgi7Ya8V05Ajnrp
 fPUKGmPVhFNQckS/Qn/u4tgbFGpWyK3QctHqfDOBUmLos+45wOtPWX2YGUu9RY9TwEx/
 8JZsAFs29/1fHw9JZVeyY+BQpIhG7D/NuvFiqsTxfBXmQ4NVJfsRr+YBa38mTGgs+IkE
 X8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694410706; x=1695015506;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wVhlFGUK5LEgRx8qisGAfCLuK5DsF5OvsljG2ziyEA8=;
 b=QBWAxlfHEU88mjv2+pookd4+qiULiQNWyNSNFQDxZPWkqHSh7htqdcn9nPFn4Ztqnc
 yYJIMHm66w2BuEmX4RcAm9bpWMdbTX9XuPEDavaEK85MHMC1RzjV5abLybDrb9ro/Xy7
 IW59yhGx+CnIot/li5fsqTDxGQvfsRoadu2GwDih997VPtdyV6WJPueicGBf6g6b1Tfi
 EfYFT9sUMqB8VSbZur288JxH7QrCMR+ijsW5Z1DC0UM5hcwqPc7LwgDN4mvkokDJfIRK
 b6EgzvrL1A/lURie5gI1E7UDKQ4zORt/5Warqv9WhVTf750u4Gb9wdwLI/u3uo0MknoM
 oxhA==
X-Gm-Message-State: AOJu0YylZ0CRBLXVC7uk0k2eJh5LadC97LNvWDIbXAlklZ7prg/HTXu3
 W366ywlJRHGAbISwWglPvDJVDQ==
X-Google-Smtp-Source: AGHT+IFTq7tqznCCxrqT3F2aL+mHu8/5PHOKZNiem0xLdEu/ob383HvhgmetD6Nq3ZxkaXMDSGb2dQ==
X-Received: by 2002:a17:902:ec8b:b0:1c0:cbaf:6939 with SMTP id
 x11-20020a170902ec8b00b001c0cbaf6939mr11230450plg.3.1694410706532; 
 Sun, 10 Sep 2023 22:38:26 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:91f5:5d19:aad:686c])
 by smtp.gmail.com with ESMTPSA id
 x18-20020a170902821200b001b89b7e208fsm5461957pln.88.2023.09.10.22.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 22:38:26 -0700 (PDT)
Date: Mon, 11 Sep 2023 14:38:23 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
Subject: Re: [RFC 4/6] gpio: add scmi driver based on pinctrl
Message-ID: <ZP6nz+sZkNiB+7+v@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 etienne.carriere@st.com, michal.simek@amd.com,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <20230906024011.17488-5-takahiro.akashi@linaro.org>
 <CAPnjgZ3z1srw_ZxfV2aRz1FAzTR=M==_rRPMFFrd7BdrGsu4AQ@mail.gmail.com>
 <ZPqjz3+Mlla8zxDS@octopus>
 <CAPnjgZ3Va35FLk6xF8iyoKtSe5_F_o8Ym7o8jdgXtGMUS6MJ3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3Va35FLk6xF8iyoKtSe5_F_o8Ym7o8jdgXtGMUS6MJ3w@mail.gmail.com>
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

On Sun, Sep 10, 2023 at 01:13:24PM -0600, Simon Glass wrote:
> Hi,
> 
> On Thu, 7 Sept 2023 at 22:32, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, Sep 07, 2023 at 06:23:05AM -0600, Simon Glass wrote:
> > > Hi AKASHI,
> > >
> > > On Tue, 5 Sept 2023 at 20:41, AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > >
> > > > This DM-compliant driver deals with SCMI pinctrl protocol and presents
> > > > gpio devices exposed by SCMI firmware (server).
> > > >
> > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > ---
> > > >  drivers/pinctrl/pinctrl-scmi.c | 544 ++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 539 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> > > > index 3ebdad57b86c..73d385bdbfcc 100644
> > > > --- a/drivers/pinctrl/pinctrl-scmi.c
> > > > +++ b/drivers/pinctrl/pinctrl-scmi.c
> > > > @@ -11,21 +11,20 @@
> > > >  #include <malloc.h>
> > > >  #include <scmi_agent.h>
> > > >  #include <scmi_protocols.h>
> > > > +#include <asm-generic/gpio.h>
> > > >  #include <dm/device_compat.h>
> > > > +#include <dm/device-internal.h>
> > > > +#include <dm/lists.h>
> > > >  #include <dm/pinctrl.h>
> > > >
> > > [..]
> > >
> > > > +
> > > > +U_BOOT_DRIVER(scmi_gpio) = {
> > > > +       .name = "scmi_gpio",
> > > > +       .id = UCLASS_GPIO,
> > > > +       .of_match = scmi_gpio_ids,
> > > > +       .of_to_plat = scmi_gpio_probe,
> > > > +       .ops = &scmi_gpio_ops,
> > > > +       .plat_auto = sizeof(struct scmi_pinctrl_gpio_plat),
> > > > +};
> > > > +
> > > > +/**
> > > > + * scmi_gpiochip_register - Create a pinctrl-controlled gpio device
> > > > + * @parent:    SCMI pinctrl device
> > > > + *
> > > > + * Create a pinctrl-controlled gpio device
> > > > + *
> > > > + * Return:     0 on success, error code on failure
> > > > + */
> > > > +static int scmi_gpiochip_register(struct udevice *parent)
> > > > +{
> > > > +       ofnode node;
> > > > +       struct driver *drv;
> > > > +       struct udevice *gpio_dev;
> > > > +       int ret;
> > > > +
> > > > +       /* TODO: recovery if failed */
> > > > +       dev_for_each_subnode(node, parent) {
> > > > +               if (!ofnode_is_enabled(node))
> > > > +                       continue;
> > >
> > > Can we not rely on the normal driver model binding to bind these
> > > devices? Why does it need to be done manually here?
> >
> > First, please take a look at the cover letter.
> > In this RFC, I basically assume two patterns of DT bindings,
> > (A) and (B) in the cover letter (or sandbox's test.dts in patch#5).
> >
> > In (B), a DT node as a gpio device, which is essentially a child
> > of pinctrl device, is located *under* a pinctrl device. It need
> > to be probed manually as there is no implicit method to enumerate
> > it as a DM device automatically.
> 
> You could add a post_bind() method to the pinctrl uclass to call
> dm_scan_fdt_dev() as we do with TPM.

Okay, but in that case, defining "compatible" property will become
mandatory, while I invented (B) so that we don't need extra bindings.

Please note that no discussion started about the binding of gpio devices.

-Takahiro Akashi

> >
> > On the other hand, in (A), the same node can be put anywhere in a DT
> > as it contains a "compatible" property to identify itself.
> > So if we want to only support (A), scmi_gpiochip_register() and
> > scmi_pinctrl_bind() are not necessary.
> >
> > Since there is no discussion about bindings for GPIO managed by SCMI
> > pinctrl device yet on the kernel side, I have left two solutions
> > in this RFC.
> 
> 
> OK.
> 
> [..]
> 
> Regards,
> Simon
