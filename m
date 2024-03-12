Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531E4C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B850787E3D;
	Tue, 12 Mar 2024 10:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bKF5hNTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F2D87D9D; Tue, 12 Mar 2024 10:43:43 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB50687F17
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5682360e095so6352457a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 02:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710236620; x=1710841420; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/A4VSZ0N293ZhMHdxCFAMZSAPC3Ev2eVZF+8UnTM5G8=;
 b=bKF5hNTK9ZLrXGytrKQa+TUKCyahUAq8yCVSPT8TzgR2hIF4opCwONpaY4nvHej9Bz
 3qWDd2xmuqnVh3TPGlwYCHGYzMYcQROKuW7yAfkOwbuhZjpGjlmLosbP7i9KCoQ7/WVz
 F7kLcEE9mqcF5y+dZHFMPRHejx2mPBk/DFzDS55iKRQKqrOaqe6OV0V/lYxnqDaTrykY
 dOdnvGPEAXKFT3oEHTNYIQTHgDgTGR1UXjW8TPg21aonLn3tN/a791aHIYNe8VGLjYEh
 SbJFudbKMhiMwXvGosvyf5vSMFjXO4PV5mLQXSL+o3HIiIPqQosO6C6smkL4D0qPb0UZ
 UHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710236620; x=1710841420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/A4VSZ0N293ZhMHdxCFAMZSAPC3Ev2eVZF+8UnTM5G8=;
 b=amqp5goocIUA5j586aKdf7OtkqR1QnzYbnE84eOGFVz8MvCgoMrB8N2Hc3xFxPXf/g
 Zk2V96VsUNkQpf28jXnkdp+ZvxJoqXocEpk5fCPshZUICUjkmd4PmBO+xM2c1AiJhBdf
 LVQKoYe0wrQ09CDuC3E3Qh9B/351EUy1BqlYh2qRV7lkfoS6wQO+F788xD4CLYnkDF2P
 K2uF9GTtPEnCAxtg34n/jeXwCzlhV+C0pDilUf26j+z/m3CaJdu+ZTMapq1Wv8Q+q3cF
 47ftIAGjehVP7DZKU0vG46JwPXpdLt5oKlih8PsEDik4/sX852MQFiiXudRkpeRq1BK9
 m6MA==
X-Gm-Message-State: AOJu0YwS4EOxD0z3jHz9W0cm8AxkKyt+iN0TcT3iJh3+DSLf60mEb8PZ
 O+45Q3xSXC6y5QXBxuAKBXoXI2h7hYxcCjXPze5SbJZxAfrEUCMMovH/1+pJxELSYnMa903CoFc
 eviPnLqtzetKacmx+X2xQkPTsqkk=
X-Google-Smtp-Source: AGHT+IHjT5Nalv3v6Jqe7MWMi9FAMKRnoRnyonyfTD1gRVA+KJmgPOf0tGY/MsIAqh9q6aG8Uojc4nnaTrJkX+j5Bd0=
X-Received: by 2002:a50:a415:0:b0:565:7b88:1cff with SMTP id
 u21-20020a50a415000000b005657b881cffmr6346747edb.11.1710236620065; Tue, 12
 Mar 2024 02:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240312070338.86127-1-sumit.garg@linaro.org>
In-Reply-To: <20240312070338.86127-1-sumit.garg@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 12 Mar 2024 09:43:28 +0000
Message-ID: <CALeDE9MkbeTOBgArDH-+VxdO7D2iAAb1Mh+gCb6tnm2vg6LOFw@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] imx8mp: Enable PCIe/NVMe support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, tharvey@gateworks.com, 
 marcel.ziswiler@toradex.com, francesco@dolcini.it, lukma@denx.de, 
 seanga2@gmail.com, jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com, 
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
 fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
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

Hi Sumit,

> pcie_imx doesn't seem to share any useful code for iMX8MP SoC and it is
> rather tied to quite old port of pcie_designware driver from Linux which
> suffices only iMX6 specific needs.
>
> But currently we have the common DWC specific bits which alligns pretty
> well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> add support for other iMX8 variants to this driver.

The upstream Linux driver is moving towards a single driver [1] for
imx6 -> imx9, would it be possible to add support for all generations
to this driver and then remove the old driver? That would allow this
single modern driver and removing the old imx6 specific driver.

Peter

[1] https://www.spinics.net/lists/linux-pci/msg150359.html

> iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> can reuse the generic PHY infrastructure to power on PCIe PHY.
>
> Testing with this patch-set included:
>
> Verdin iMX8MP # pci enum
> PCIE-0: Link up (Gen1-x1, Bus0)
> Verdin iMX8MP #
> Verdin iMX8MP # nvme scan
> Verdin iMX8MP #
> Verdin iMX8MP # nvme info
> Device 0: Vendor: 0x126f Rev: T0828A0  Prod: AA000000000000000720
>             Type: Hard Disk
>             Capacity: 122104.3 MB = 119.2 GB (250069680 x 512)
> Verdin iMX8MP #
> Verdin iMX8MP # load nvme 0 $loadaddr <file-name>
>
> Changes in v3:
> - Rebased on top of U-Boot next.
> - Incorporated misc. updates to commit messages.
> - New patch#2 to refactor reset driver function names.
> - Patch#3: Refactored further for better code reuse.
> - New patch#4 to fix refcount issue with power domain bus.
> - Patch#5: Refactored further for better code reuse.
> - Patch#7 & #8: Added dependency on REGMAP and SYSCON. Also, added
>   support for vpcie-supply regulator.
> - Patch#7 & #8: Added error paths and .remove callback.
> - New patch#10 to enable PCIe/NVMe for imx8mp_venice*.
>
> Changes in v2:
> - Renamed PCIe IMX driver pcie_dw_imx8.c -> pcie_dw_imx.c.
> - Added myself as maintainer for PCIe DWC IMX driver support.
> - Incorporated various code and commit message improvement suggestions
>   from Marek, thanks.
> - Patch#3: Gate PCIe and USB clocks behind corresponding power domain
>   IDs.
> - Patch#4: Expose HSIO PLL clocks as a regular clock driver instead
>   similar to what Linux kernel does.
> - Patch#7: Picked up tags.
>
> Sumit Garg (10):
>   clk: imx8mp: Add support for PCIe clocks
>   reset: imx: Refactor driver to simplify function names
>   reset: imx: Add support for i.MX8MP reset controller
>   imx8mp: power-domain: Don't power off pd_bus
>   imx8mp: power-domain: Add PCIe support
>   imx8mp: power-domain: Expose high performance PLL clock
>   phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe PHY
>   pci: Add DW PCIe controller support for iMX8MP SoC
>   verdin-imx8mp_defconfig: Enable PCIe/NVMe support
>   MAINTAINERS: Add entry for PCIe DWC IMX driver
>
> Tim Harvey (1):
>   imx8mp_venice_defconfig: Enable PCIe/NVMe support
>
>  MAINTAINERS                           |   6 +
>  configs/imx8mp_venice_defconfig       |   8 +
>  configs/verdin-imx8mp_defconfig       |   6 +
>  drivers/clk/imx/clk-imx8mp.c          |   6 +
>  drivers/pci/Kconfig                   |  11 +
>  drivers/pci/Makefile                  |   1 +
>  drivers/pci/pcie_dw_imx.c             | 338 ++++++++++++++++++++++++++
>  drivers/phy/Kconfig                   |  11 +
>  drivers/phy/Makefile                  |   1 +
>  drivers/phy/phy-imx8m-pcie.c          | 283 +++++++++++++++++++++
>  drivers/power/domain/imx8mp-hsiomix.c | 191 ++++++++++++---
>  drivers/reset/reset-imx7.c            | 125 +++++++++-
>  12 files changed, 937 insertions(+), 50 deletions(-)
>  create mode 100644 drivers/pci/pcie_dw_imx.c
>  create mode 100644 drivers/phy/phy-imx8m-pcie.c
>
> --
> 2.34.1
>
