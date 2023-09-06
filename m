Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46F5EB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 03:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 279FE86590;
	Wed,  6 Sep 2023 05:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KLItiMQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42CA086583; Wed,  6 Sep 2023 05:10:03 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D3D86591
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 05:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-27197b0b733so660051a91.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 20:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693969798; x=1694574598; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NufyuwJGhMsxesOwGhttp58xScl085OEldmb3DzJwg0=;
 b=KLItiMQssS217WFopN8bohCnN8blqEuiSHxrjiC8LjjLfg8qLLhINnyS3R5mdKiDtD
 vZM23Ka+gAFw0+SQGEhEpAUUeOuK0NJd7wOyTvozOcKKLhqsmC4e1HyGE2amUzbJIgu3
 qcJV4UDZGuX0o5mg5sQC8ZKB9QQOSDVmtD5YhsunUrNMT6pqq3bUpATkVcTR8FH+9jnp
 fLCNTrNAsRl2CSd4xmQ4btHX0Bc/hDUJxHID15+/ln9yiWmfWbUEcpStHG2dfrf6RUol
 acGjQeJyEwcm6n/jjVO32Jo0ZX3ITVO2iVzSE7bnd++tVnGe2qNT5E0N8wOxXrKmO+co
 xVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693969798; x=1694574598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NufyuwJGhMsxesOwGhttp58xScl085OEldmb3DzJwg0=;
 b=MnwTIUTgJWHKqyAQ+9SLWu6HY8KGXNWh55978Y7er0ruYSv+2bc9+UYWHV7vDRp8hR
 Ssi3MbTfUVQVoAr8zMRGJZ+1aUpSfdgBc5348ehb6W6pnU7jmqW+osLIrZeMFbxWj7q2
 FBOwSuXUJfWjD1M6n8Tz4yW7P2w9MrsX0gbXSQPAB5oaIOK+MRJBn45WBBusPQQmjWHX
 xzyTiTIeoorAuRbjkWpr8+BH7ezMoLQT8+WbC4HXsTLQ4Db5NQoFzbKADxXRZNxekX7r
 EyxC4kQmLSUeMPTIIzKhQRQ4E8dtUO90qVfjkFPjRaGzIS3MGbSCUCLLenBlKw2FgnWh
 RY2g==
X-Gm-Message-State: AOJu0YyDL31OqXbANqJJwkeknAIGHtU7Aj/Qwnc55c4KrZAB40oGUW6k
 M1ikpLb11f+mza+Cyb1K+BOHRVttgUuYGnm2agw=
X-Google-Smtp-Source: AGHT+IFDSk6xST0tY4qUydyEcLBEqf/3s7vB4qMd2RTQHOv17gF7WstgU8iOssZtlZygbut766JoWoaCYZJC9opcnuc=
X-Received: by 2002:a17:90a:4dc7:b0:263:2312:60c2 with SMTP id
 r7-20020a17090a4dc700b00263231260c2mr13267783pjl.3.1693969798158; Tue, 05 Sep
 2023 20:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
In-Reply-To: <20230906024011.17488-1-takahiro.akashi@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 6 Sep 2023 00:09:45 -0300
Message-ID: <CAOMZO5BNpWM0a1UwJmYE+cvd5NDtxXSULb-Tr7qhucGC3i16QA@mail.gmail.com>
Subject: Re: [RFC 0/6] firmware: scmi: add SCMI pinctrl protocol support
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com, 
 sjg@chromium.org, linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Adding Peng Fan, who is working on scmi/pinctrl support for i.MX9:

https://lore.kernel.org/all/ZO9GLG5tQynYyAvR@pluto/T/

On Tue, Sep 5, 2023 at 11:41=E2=80=AFPM AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> This is an RFC and meant to get feedback from other developers as
> - the specification (pinctrl part) is still in a draft
> - the upstream patch for linux, including dt bindings, is still WIP
> - I'm not confident the drivers are generic enough to cover most HWs
> - The tests ("ut") doesn't cover all the features yet
>
>
> This patch series allows users to access SCMI pin control protocol provid=
ed
> by SCMI server (platform). See SCMI specification document v3.2 beta 2[1]
> for more details about SCMI pin control protocol.
>
> The implementation consists of two layers:
> - basic helper functions for SCMI pin control protocol
>   in drivers/firmware/scmi/pinctrl.c (patch#2)
> - DM-compliant pinctrl/gpio drivers, which utilizes the helper functions,
>   in drivers/pinctrl/pinctrl-scmi.c (patch#3,#4)
>
> [1] https://developer.arm.com/documentation/den0056/e/?lang=3Den
>
> DT bindings
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Upstream pinctrl patch for linux defines the bindings in [2] though
> it doesn't say much.
> I expect that my implementation basically complies with U-Boot's generic
> bindings described in [3], but not all the features are verified.
>
> As for gpio, unless you hard-code pin assignments directly in a device
> driver, my implementation allows the following alternatives in DT.
> Either way, we may need an additional binding description for gpio.
>
> (A)
>     scmi {
>         ... // other protocols
>         scmi_pinctrl: protocol@19 { // Pin control protocol
>             ...
>             {pinmux definitions}... // if any, including GPIO?
>         }
>     }
>     scmi_gpio: scmi_gpio {
>         compatible =3D "arm,scmi-gpio-generic";
>         gpio-controller;
>         #gpio-cells =3D <2>;
>         gpio-ranges =3D <&scmi_pinctrl 0 5 4>,
>                       <&scmi_pinctrl 4 0 0>;
>         gpio-ranges-group-names =3D "",
>                                   "ANOTHER_GPIO_GROUP";
>     }
>     some_device {
>         ...
>         reset-gpios =3D <&scmi_gpio 0 GPIO_ACTIVE_HIGH>;
>     }
> (B)
>     scmi {
>         ... // other protocols
>         scmi_pinctrl: protocol@19 { // Pin control protocol
>             ...
>             {pinmux definitions}... // if any, including GPIO?
>
>             scmi_gpio: scmi_gpio {
>                 // no need for "compatible"
>                 gpio-controller;
>                 #gpio-cells =3D <2>;
>                 gpio-ranges =3D <&scmi_pinctrl 0 5 4>,
>                               <&scmi_pinctrl 4 0 0>;
>                 gpio-ranges-group-names =3D "",
>                                           "ANOTHER_GPIO_GROUP";
>             }
>         }
>     }
>     some_device {
>         ...
>         reset-gpios =3D <&scmi_gpio 0 GPIO_ACTIVE_HIGH>;
>     }
> (C)
>     if "gpio-ranges" is missing in gpio definition, assume 1:1 mapping,
>     i.e. use a native pinctrl pin number (5).
>     some_device {
>         ...
>         reset-gpios =3D <&scmi_gpio 5 GPIO_ACTIVE_HIGH>;
>     }
>
>
> [2] https://lkml.iu.edu/hypermail/linux/kernel/2308.1/01084.html
> [3] <u-boot>/doc/device-tree-bindings/pinctrl/pinctrl-bindings.txt
>     <u-boot>/doc/device-tree-bindings/gpio/gpio.txt
>
> Test
> =3D=3D=3D=3D
> The patch series was tested on the following platforms:
> * sandbox ("ut dm pinmux" and manually using gpio command)
>
>
> Prerequisite:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> * This patch series is based on my WIP "Base protocol support" patches
>   on v2023.10-rc3. You can fetch the whole code from [4].
>
> [4] https://git.linaro.org/people/takahiro.akashi/u-boot.git
>     branch:scmi/pinctrl
>
>
> Patches:
> =3D=3D=3D=3D=3D=3D=3D=3D
> Patch#1: Add SCMI base protocol driver
> Patch#2-#4: Add drivers
> Patch#5-#6: Test related
>
>
> Change history:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RFC (Sep 6, 2023)
> * initial release as RFC
>
> AKASHI Takahiro (6):
>   firmware: scmi: fix protocol enumeration logic
>   firmware: scmi: add pinctrl protocol support
>   pinctrl: add scmi driver
>   gpio: add scmi driver based on pinctrl
>   firmware: scmi: add pseudo pinctrl protocol support on sandbox
>   test: dm: add SCMI pinctrl test
>
>  arch/sandbox/dts/test.dts                  |  115 +++
>  cmd/scmi.c                                 |    1 +
>  drivers/firmware/scmi/Kconfig              |    3 +
>  drivers/firmware/scmi/Makefile             |    1 +
>  drivers/firmware/scmi/pinctrl.c            |  412 ++++++++
>  drivers/firmware/scmi/sandbox-scmi_agent.c |  722 +++++++++++++
>  drivers/firmware/scmi/scmi_agent-uclass.c  |   18 +-
>  drivers/pinctrl/Kconfig                    |   11 +
>  drivers/pinctrl/Makefile                   |    1 +
>  drivers/pinctrl/pinctrl-scmi.c             | 1071 ++++++++++++++++++++
>  include/scmi_agent-uclass.h                |    2 +
>  include/scmi_protocols.h                   |  435 ++++++++
>  test/dm/scmi.c                             |   62 ++
>  13 files changed, 2852 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/firmware/scmi/pinctrl.c
>  create mode 100644 drivers/pinctrl/pinctrl-scmi.c
>
> --
> 2.34.1
>
