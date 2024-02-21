Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB92C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 05:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B782B87DA7;
	Wed, 21 Feb 2024 06:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pSfjC7y2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6791A87D7E; Wed, 21 Feb 2024 06:26:13 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D351187DA7
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 06:26:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-47079f43a37so246766137.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 21:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708493159; x=1709097959; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CUtobcJh/Du6WHxiL4mG738lH+FZ3WEbv0t2844PYtI=;
 b=pSfjC7y2rL1bhT+H0HnEOO4gqnTdoAPKd1rd4/TVVLawcEFgbuFVbCClDuYDrlnqD9
 PdbFZYa2wwO1IflmXnUhvUVzaPgBXoG/5pIlb8aNPBPk9v6cdaYbXqyyIo49KuZXpp2V
 5X1acithOCCi+/3xQ1xnW4IlBhCW9XZC4UVL74ktpJX6L1JSzndntwRdi2RV4y4yDLC8
 qRUMX4Jf00OdSxbZBEcFsYAKRq/KQLVvS9nnis9eLNo4/fVkmrMaJKf8GAVFw2uY3la1
 SKbddaEjLmC6TC4FXxmMMTgZ78kELukhfeGLBwZSYHPVLSnP4LMJrMEU+2Y2xtdzfhO+
 LQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708493159; x=1709097959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CUtobcJh/Du6WHxiL4mG738lH+FZ3WEbv0t2844PYtI=;
 b=RHQKXB5W3sODHntWQZ0oFNkHqqghiC/aMQ3QpGW8j60A+TS7QWMSvFObNwVPoUBGS+
 CYwL8rwdkSWAcyq7gsyD0xeTPd7+w0n57BQY8mes25tvn/NNkAhq78RVhr3zwhjp0Z29
 Vc7fHLM5yHYb0JG+wkK+icmD6dz/n8WFjq2nnsGVMRioH7PSW85eoI3Foj8EihMLgSQL
 7yJWfCbgrcQXEA75EOif8UrLa8dGpJFhz68UXoto41GFuXCdUpAkQHpFySXekPGDtmms
 QoZFp0njBbfygdgAUOUw6y/VquOzNDRPIOsLX9DZT0HZcpIsOR9lUIEiV0PKTi2jU3qS
 8cqg==
X-Gm-Message-State: AOJu0YwcPunITkefPIj0Fw7seLzgwfVlJapcMDynoQ6mFNAh19vMZlwW
 GMlx9DjBJSBAYDKbABVK5qxRG/jKW6q47sx6lYuApKl7QQJPrgqm53f50AVrk3YuWWPCDhzMpUO
 Zr9JDalSMy1MDOontu1THJu359aTJr+weMuFumg==
X-Google-Smtp-Source: AGHT+IH2b+KDPaMIM4yqg5ow84MJN2VSl+1bORwq7WGxk5s7thFZa+A+M3N03dTL4zEcM6oxVRB8Z6KpZVhei/39HvI=
X-Received: by 2002:a67:cd92:0:b0:470:5546:3d0c with SMTP id
 r18-20020a67cd92000000b0047055463d0cmr7036889vsl.7.1708493159293; Tue, 20 Feb
 2024 21:25:59 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <6111dab9-62e2-4ef6-9007-448bf0f4fc0b@denx.de>
In-Reply-To: <6111dab9-62e2-4ef6-9007-448bf0f4fc0b@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 10:55:48 +0530
Message-ID: <CAFA6WYO3hyZkqvoTBsVTbROH1-csWQ1q3Wmd2LYcjD2iPAsTYQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] imx8mp: Enable PCIe/NVMe support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com, 
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de, 
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com, 
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org, 
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

On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>
> On 2/20/24 14:10, Sumit Garg wrote:
> > pcie_imx doesn't seem to share any useful code for iMX8MP SoC and it is
> > rather tied to quite old port of pcie_designware driver from Linux which
> > suffices only iMX6 specific needs.
> >
> > But currently we have the common DWC specific bits which alligns pretty
> > well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> > bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> > add support for other iMX8 variants to this driver.
> >
> > iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> > can reuse the generic PHY infrastructure to power on PCIe PHY.
> >
> > Patch #1: Adds PCIe clocks support.
> > Patch #2: Adds i.MX8MP reset controller support.
> > Patch #3: Extend i.MX8MP power domain driver with PCIe support
> > Patch #4: Expose high performance PLL clock required for PCIe PHY
> >            on verdin board.
> > Patch #5: Adds standalone PCIe PHY support for i.MX8MP SoC.
> > Patch #6: Adds DW PCIe controller support for iMX8MP SoC.
> > Patch #7: Enable PCIe/NVMe support for verdin board.
> >
> > Testing with this patch-set included:
> >
> > Verdin iMX8MP # pci enum
> > PCIE-0: Link up (Gen1-x1, Bus0)
> > Verdin iMX8MP #
> > Verdin iMX8MP # nvme scan
> > Verdin iMX8MP #
> > Verdin iMX8MP # nvme info
> > Device 0: Vendor: 0x126f Rev: T0828A0  Prod: AA000000000000000720
> >              Type: Hard Disk
> >              Capacity: 122104.3 MB = 119.2 GB (250069680 x 512)
> > Verdin iMX8MP #
> > Verdin iMX8MP # load nvme 0 $loadaddr <file-name>
> >
> > Sumit Garg (7):
> >    clk: imx8mp: Add support for PCIe clocks
> >    reset: imx: Add support for i.MX8MP reset controller
> >    imx8mp: power-domain: Add PCIe support
> >    imx8mp: power-domain: Expose high performance PLL clock
> >    phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe PHY
> >    pci: Add DW PCIe controller support for iMX8MP SoC
> >    verdin-imx8mp_defconfig: Enable PCIe/NVMe support
> >
> >   configs/verdin-imx8mp_defconfig       |   9 +
> >   drivers/clk/imx/clk-imx8mp.c          |   6 +
> >   drivers/pci/Kconfig                   |   8 +
> >   drivers/pci/Makefile                  |   1 +
> >   drivers/pci/pcie_dw_imx8.c            | 348 ++++++++++++++++++++++++++
>
> You can call this pcie_dw_imx.c , the imx6 support can be converted over
> to that driver too I guess ?

Yeah I suppose that should be possible, let me rename it as pcie_dw_imx.c.

-Sumit
