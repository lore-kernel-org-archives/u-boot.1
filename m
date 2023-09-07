Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE59EE14D4
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 09:58:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 016288660B;
	Thu,  7 Sep 2023 11:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yy24Jqlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFA5866D4; Thu,  7 Sep 2023 11:58:47 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53FEF863ED
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 11:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf095e1becso1112195ad.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 02:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694080722; x=1694685522; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cCZeDFOQ2d0GiSlvACzDVegEUGP3RPFwC8A9g+uJpR8=;
 b=Yy24JqlfuWXp4iZ83PqCL/Zs0qlAYEM+RnMkhtv9L0lrVhOTTrLddCijXaKcqVV4bu
 sk+fjmUxDx9EpkOJBHW4W9ubZAH5tGSPXihnVoCuWSCB0PfOG1R65YDvYJi6vlVxzAgC
 ZUiGS/mkG6b0k6xRI4m+KkV6YpjbOO6VIgBFONsyNOcA53dXcJQRdC+2NQ54NJ6xZ+9U
 ooCh/2ZtZp6eBdCe5mPtxsWcpi800JkTeZ9EvMhlGT1p1wsvW8oSYYodyxcJsxzCrna1
 eSuFa7TqngdTkOHaxoIFNlgAcII3vDOInn76QQ2RJanlkAI3ftYvWf6dENE0bSCacQeS
 oiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694080722; x=1694685522;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cCZeDFOQ2d0GiSlvACzDVegEUGP3RPFwC8A9g+uJpR8=;
 b=kKrc9jpSB2azxXwKBVeTy4FP2BxYLlwWWdwomYon21KxSQm8ul9DuiT0fKaje5qj8e
 2Gu9yGog12ZIUn0W45AlwyCUgQnLZBut8L17dmR0fI7jiU+LTl5jvqArM/D6HJj86iU6
 sy/DVEBwX0U+vrCvDRDTM/NUrodAcUcLcekHeMZiSFZsj6PwJg+yrTri8FvKZ8Nm6HPd
 4ijuuZVsgPhQAuwOGhugjWaY5Su7sBf2MeVFJ7KtcyyhlrStoSIDDo/yQL6jRGUGEwCr
 Hqpf07+v5BgFqateAGIlwRX9ZnX0AP6phUZFRcn3JiKEYls5Azcdgi6awi39tuYAOA2P
 xb0g==
X-Gm-Message-State: AOJu0YxR13vHCEtjAYO8zgcdPtvk8ZMDBcULy+I9M8/8r+XX2yvE1AaC
 YEFDk33Bc/DHsuewc85H2uby0w==
X-Google-Smtp-Source: AGHT+IEDVipmYU5+UHl0wPpLfvDOXrRaD0tj0gjcDK4WhZ4PW3JYkgWt6T5WtcoIURdiy3mdLlWCTg==
X-Received: by 2002:a17:902:dacb:b0:1b8:2ba0:c9a8 with SMTP id
 q11-20020a170902dacb00b001b82ba0c9a8mr21586158plx.2.1694080722548; 
 Thu, 07 Sep 2023 02:58:42 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:90bf:a1fa:8da1:9b9d])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a1709029f8f00b001bba3a4888bsm12461369plq.102.2023.09.07.02.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 02:58:42 -0700 (PDT)
Date: Thu, 7 Sep 2023 18:58:38 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de,
 etienne.carriere@st.com, michal.simek@amd.com, sjg@chromium.org,
 linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
Subject: Re: [RFC 0/6] firmware: scmi: add SCMI pinctrl protocol support
Message-ID: <ZPmezjoqEwCtJ7qd@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com,
 sjg@chromium.org, linus.walleij@linaro.org,
 Oleksii_Moisieiev@epam.com
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <CAOMZO5BNpWM0a1UwJmYE+cvd5NDtxXSULb-Tr7qhucGC3i16QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BNpWM0a1UwJmYE+cvd5NDtxXSULb-Tr7qhucGC3i16QA@mail.gmail.com>
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

Hi Peng,

On Wed, Sep 06, 2023 at 12:09:45AM -0300, Fabio Estevam wrote:
> Adding Peng Fan, who is working on scmi/pinctrl support for i.MX9:
> 
> https://lore.kernel.org/all/ZO9GLG5tQynYyAvR@pluto/T/

I made a comment there.

BTW, do you already have your own implementation of SCMI pin control
protocol at SCMI firmware(server)?
Is it public available?

-Takahiro Akashi


> On Tue, Sep 5, 2023 at 11:41 PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > This is an RFC and meant to get feedback from other developers as
> > - the specification (pinctrl part) is still in a draft
> > - the upstream patch for linux, including dt bindings, is still WIP
> > - I'm not confident the drivers are generic enough to cover most HWs
> > - The tests ("ut") doesn't cover all the features yet
> >
> >
> > This patch series allows users to access SCMI pin control protocol provided
> > by SCMI server (platform). See SCMI specification document v3.2 beta 2[1]
> > for more details about SCMI pin control protocol.
> >
> > The implementation consists of two layers:
> > - basic helper functions for SCMI pin control protocol
> >   in drivers/firmware/scmi/pinctrl.c (patch#2)
> > - DM-compliant pinctrl/gpio drivers, which utilizes the helper functions,
> >   in drivers/pinctrl/pinctrl-scmi.c (patch#3,#4)
> >
> > [1] https://developer.arm.com/documentation/den0056/e/?lang=en
> >
> > DT bindings
> > ===========
> > Upstream pinctrl patch for linux defines the bindings in [2] though
> > it doesn't say much.
> > I expect that my implementation basically complies with U-Boot's generic
> > bindings described in [3], but not all the features are verified.
> >
> > As for gpio, unless you hard-code pin assignments directly in a device
> > driver, my implementation allows the following alternatives in DT.
> > Either way, we may need an additional binding description for gpio.
> >
> > (A)
> >     scmi {
> >         ... // other protocols
> >         scmi_pinctrl: protocol@19 { // Pin control protocol
> >             ...
> >             {pinmux definitions}... // if any, including GPIO?
> >         }
> >     }
> >     scmi_gpio: scmi_gpio {
> >         compatible = "arm,scmi-gpio-generic";
> >         gpio-controller;
> >         #gpio-cells = <2>;
> >         gpio-ranges = <&scmi_pinctrl 0 5 4>,
> >                       <&scmi_pinctrl 4 0 0>;
> >         gpio-ranges-group-names = "",
> >                                   "ANOTHER_GPIO_GROUP";
> >     }
> >     some_device {
> >         ...
> >         reset-gpios = <&scmi_gpio 0 GPIO_ACTIVE_HIGH>;
> >     }
> > (B)
> >     scmi {
> >         ... // other protocols
> >         scmi_pinctrl: protocol@19 { // Pin control protocol
> >             ...
> >             {pinmux definitions}... // if any, including GPIO?
> >
> >             scmi_gpio: scmi_gpio {
> >                 // no need for "compatible"
> >                 gpio-controller;
> >                 #gpio-cells = <2>;
> >                 gpio-ranges = <&scmi_pinctrl 0 5 4>,
> >                               <&scmi_pinctrl 4 0 0>;
> >                 gpio-ranges-group-names = "",
> >                                           "ANOTHER_GPIO_GROUP";
> >             }
> >         }
> >     }
> >     some_device {
> >         ...
> >         reset-gpios = <&scmi_gpio 0 GPIO_ACTIVE_HIGH>;
> >     }
> > (C)
> >     if "gpio-ranges" is missing in gpio definition, assume 1:1 mapping,
> >     i.e. use a native pinctrl pin number (5).
> >     some_device {
> >         ...
> >         reset-gpios = <&scmi_gpio 5 GPIO_ACTIVE_HIGH>;
> >     }
> >
> >
> > [2] https://lkml.iu.edu/hypermail/linux/kernel/2308.1/01084.html
> > [3] <u-boot>/doc/device-tree-bindings/pinctrl/pinctrl-bindings.txt
> >     <u-boot>/doc/device-tree-bindings/gpio/gpio.txt
> >
> > Test
> > ====
> > The patch series was tested on the following platforms:
> > * sandbox ("ut dm pinmux" and manually using gpio command)
> >
> >
> > Prerequisite:
> > =============
> > * This patch series is based on my WIP "Base protocol support" patches
> >   on v2023.10-rc3. You can fetch the whole code from [4].
> >
> > [4] https://git.linaro.org/people/takahiro.akashi/u-boot.git
> >     branch:scmi/pinctrl
> >
> >
> > Patches:
> > ========
> > Patch#1: Add SCMI base protocol driver
> > Patch#2-#4: Add drivers
> > Patch#5-#6: Test related
> >
> >
> > Change history:
> > ===============
> > RFC (Sep 6, 2023)
> > * initial release as RFC
> >
> > AKASHI Takahiro (6):
> >   firmware: scmi: fix protocol enumeration logic
> >   firmware: scmi: add pinctrl protocol support
> >   pinctrl: add scmi driver
> >   gpio: add scmi driver based on pinctrl
> >   firmware: scmi: add pseudo pinctrl protocol support on sandbox
> >   test: dm: add SCMI pinctrl test
> >
> >  arch/sandbox/dts/test.dts                  |  115 +++
> >  cmd/scmi.c                                 |    1 +
> >  drivers/firmware/scmi/Kconfig              |    3 +
> >  drivers/firmware/scmi/Makefile             |    1 +
> >  drivers/firmware/scmi/pinctrl.c            |  412 ++++++++
> >  drivers/firmware/scmi/sandbox-scmi_agent.c |  722 +++++++++++++
> >  drivers/firmware/scmi/scmi_agent-uclass.c  |   18 +-
> >  drivers/pinctrl/Kconfig                    |   11 +
> >  drivers/pinctrl/Makefile                   |    1 +
> >  drivers/pinctrl/pinctrl-scmi.c             | 1071 ++++++++++++++++++++
> >  include/scmi_agent-uclass.h                |    2 +
> >  include/scmi_protocols.h                   |  435 ++++++++
> >  test/dm/scmi.c                             |   62 ++
> >  13 files changed, 2852 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/firmware/scmi/pinctrl.c
> >  create mode 100644 drivers/pinctrl/pinctrl-scmi.c
> >
> > --
> > 2.34.1
> >
