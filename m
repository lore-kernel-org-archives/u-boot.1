Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA46DC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 10:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C0788120;
	Fri,  1 Mar 2024 11:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pE430DZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1125187BAE; Fri,  1 Mar 2024 11:07:30 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B14488129
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 11:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-51326436876so1739531e87.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 02:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709287645; x=1709892445; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oQSahxREKPADjvWFCxdp/6ul9irC+FBMqDHf3TYyI9s=;
 b=pE430DZoDrtJxDtQz6IlQIi5nhP/lypBAnq3BI02/IQaifCl0UgQGcuMZOeKKV+Mqq
 4Ovo2o3Gwv8wVpu7XjVLrt94DIKR4nIeRW5BPsp4EzqvczAF6kYVm6MYTQK5EaJxVS6P
 0hrvqw21jMiTeaTA7OqGKbZtmj8iHDKsdUAM1LEVo7NQJpdt9lgrm1qxwauUt016oeyh
 swO4ChzkRS6doByvuONCl3r3/CppzQmPWJrx57wofqaMacr0MeH2DVAqtKlwlqlV1Rz2
 ZA1hTk7Wly2/NDQdfewpRLcDJBsAx/behLRufFUZ9iRrvReU+Q1hRjUGvNeFSPBzsZD3
 OfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709287645; x=1709892445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oQSahxREKPADjvWFCxdp/6ul9irC+FBMqDHf3TYyI9s=;
 b=pYok735GiRQA467oPD/PuEwAGjX1Q/UTDKkIMw3UurHBKxAXXgwrtR6Arh+Zrsncoe
 wgTOTC0vpQjJCGa7vav1CYiFAPq61dXjGF4PmZ88KjYhWm3k6gxaAY7LvksVl8WhHfuZ
 OkgzPLKoMibIryEvkv4aQEIz1BJBkyrWx995Szn+Ks0ZaigiyHSH8x/rHvcDE0I6Gz/g
 wHZjUdC1kAhAyLLeF1btfRBAvSXqm00JwNwGB+MYLuxWuNsV7WHN3VGUvSyQQmwTo8Xe
 WncBb9V+hbWPDqaEq+ARBpfoEtK9g+tDgZmyNshkstz1MDPHp/6y1JUnePGAMENtBgkE
 207w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8KvAUVV2AdNBIznpJXJDX0lMDVFh7rmowDSeOR8sO0+y4pefvVxoGSbpIp01/fUIoipg519CprPGtrIvf6b9MRATohg==
X-Gm-Message-State: AOJu0Yy0kvaAtownHCkNtaFYPAZHJT6KbKDT5Lft5ICRXJ2a4Hk9ILAk
 yADoq588ZwPbESi8rFGGuASKiFwYmwvHzdsvC6VoI7a+7GImhBQ+3i+I0tS9A1B1ThO2tkE2rT6
 fEYtUWgC/ispa4wuLjo9D9eSu5QmzmHGof9LleQ==
X-Google-Smtp-Source: AGHT+IHxwa/+/ZQZ8Iuop3u0hlheT5bY53l8ffa2M3AJWimKYPiEz8YLTzEBwiMqqZYPwA+zmP7mRlFsjPPyVczyYFA=
X-Received: by 2002:a05:6512:238f:b0:513:3309:cc62 with SMTP id
 c15-20020a056512238f00b005133309cc62mr936964lfv.47.1709287645281; Fri, 01 Mar
 2024 02:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-2-quic_varada@quicinc.com>
 <4fa5cede-def3-4ad0-8433-72495e4c8e3b@kernel.org>
In-Reply-To: <4fa5cede-def3-4ad0-8433-72495e4c8e3b@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Mar 2024 12:06:49 +0200
Message-ID: <CAC_iWjJXyo1KGWFeimMSqi4zVTcBWZ_VGCjbtiRJWVf1mA383w@mail.gmail.com>
Subject: Re: [PATCH 01/10] mach-snapdragon: Add support for IPQ9574
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>, FUKAUMI Naoki <naoki@radxa.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <othacehe@gnu.org>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Krzysztof,

On Thu, 29 Feb 2024 at 22:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 26/02/2024 11:07, Varadarajan Narayanan wrote:
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >
> >  arch/arm/dts/Makefile                         |    2 +
> >  arch/arm/dts/ipq9574-default.dts              |  167 +++
> >  arch/arm/dts/ipq9574-rdp433-mht-phy.dts       |  208 +++
> >  arch/arm/dts/ipq9574.dtsi                     |  771 ++++++++++
> >  .../include/mach/sysmap-ipq9574.h             |  252 ++++
> >  arch/arm/mach-snapdragon/init_ipq9574.c       |   81 +
> >  board/qualcomm/ipq9574/Kconfig                |   15 +
> >  board/qualcomm/ipq9574/Makefile               |    4 +
> >  board/qualcomm/ipq9574/board_init.c           |  326 ++++
> >  board/qualcomm/ipq9574/ipq9574.c              |  170 +++
> >  board/qualcomm/ipq9574/ipq9574.h              |   75 +
> >  board/qualcomm/ipq9574/u-boot-x32.lds         |  250 ++++
> >  board/qualcomm/ipq9574/u-boot-x64.lds         |  188 +++
> >  drivers/clk/qcom/clock-ipq9574.c              | 1320 +++++++++++++++++
> >  drivers/pinctrl/qcom/pinctrl-ipq9574.c        |   77 +
> >  include/configs/ipq9574.h                     |  111 ++
> >  include/dt-bindings/clock/gcc-ipq9574.h       |  156 ++
> >  include/dt-bindings/net/qti-ipqsoc.h          |   20 +
> >  include/dt-bindings/pinctrl/pinctrl-ipqsoc.h  |   19 +
> >  include/dt-bindings/reset/ipq9574-reset.h     |   54 +
> >  20 files changed, 4266 insertions(+)
> >  create mode 100644 arch/arm/dts/ipq9574-default.dts
> >  create mode 100644 arch/arm/dts/ipq9574-rdp433-mht-phy.dts
> >  create mode 100644 arch/arm/dts/ipq9574.dtsi
> >  create mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-ipq9574.h
> >  create mode 100644 arch/arm/mach-snapdragon/init_ipq9574.c
> >  create mode 100644 board/qualcomm/ipq9574/Kconfig
> >  create mode 100644 board/qualcomm/ipq9574/Makefile
> >  create mode 100644 board/qualcomm/ipq9574/board_init.c
> >  create mode 100644 board/qualcomm/ipq9574/ipq9574.c
> >  create mode 100644 board/qualcomm/ipq9574/ipq9574.h
> >  create mode 100644 board/qualcomm/ipq9574/u-boot-x32.lds
> >  create mode 100644 board/qualcomm/ipq9574/u-boot-x64.lds
> >  create mode 100644 drivers/clk/qcom/clock-ipq9574.c
> >  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
> >  create mode 100644 include/configs/ipq9574.h
> >  create mode 100644 include/dt-bindings/clock/gcc-ipq9574.h
> >  create mode 100644 include/dt-bindings/net/qti-ipqsoc.h
> >  create mode 100644 include/dt-bindings/pinctrl/pinctrl-ipqsoc.h
> >  create mode 100644 include/dt-bindings/reset/ipq9574-reset.h
> >
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index d9725030d5..8931dfa2aa 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -1523,6 +1523,8 @@ dtb-$(CONFIG_ARCH_QEMU) += qemu-arm.dtb qemu-arm64.dtb
> >  dtb-$(CONFIG_TARGET_CORSTONE1000) += corstone1000-mps3.dtb \
> >                               corstone1000-fvp.dtb
> >
> > +dtb-$(CONFIG_TARGET_IPQ9574) += ipq9574-rdp433-mht-phy.dtb
> > +
> >  include $(srctree)/scripts/Makefile.dts
> >
> >  targets += $(dtb-y)
> > diff --git a/arch/arm/dts/ipq9574-default.dts b/arch/arm/dts/ipq9574-default.dts
> > new file mode 100644
> > index 0000000000..501c9492df
> > --- /dev/null
> > +++ b/arch/arm/dts/ipq9574-default.dts
> > @@ -0,0 +1,167 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "ipq9574.dtsi"
> > +
> > +/ {
> > +     config_name = "config-default";
> > +
> > +     aliases {
> > +             console = &blsp1_uart2_console;
> > +             uart2 = &blsp1_uart3_additional;
> > +             sdhci = &mmc;
> > +     };
> > +
> > +     soc: soc {
> > +             tlmm: pinctrl@1000000 {
> > +
> > +                     sdhci_pinmux: mmc {
> > +                             pinconfig;
> > +                             emmc_data {
>
> No, please use upstream DTS.
>
> You imported here a lot of vendor junk. There is no way this will pass
> any System Ready tests if you hand over this DTB to Linux. Plus really,
> that's ugly DTS to look at.
>
> I am not a maintainer of DTS in U-Boot, so up to the folks here, but I
> really recommend to NAK such DTS. It just re-adds all the issues we
> fixed in upstream kernel!
>
> I suggest using dts/upstream/qcom, but if you cannot then please import
> kernel DTS.

Yes, please. There's a lot of effort updating the dts file in u-boot
and using as much as we can verbatim from the upstream repos. Let's
not take any steps backwards

>
> Best regards,
> Krzysztof
>
