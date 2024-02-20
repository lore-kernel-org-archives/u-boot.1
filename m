Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25305C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 15:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44BC587FB9;
	Tue, 20 Feb 2024 16:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708443141;
	bh=yJ2EAv7NnzAt32fe2tQU0PeR5u4AY19aBlYABNz5zFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TlBs+0pcd2MeH75VTD0T/FaZi2UDoYvMyKHROcsjz/Bu8lOedE6AjvA0auvErrFK3
	 Rw2xb8vluxYhe0Ii5XhrhXH8QTFF7pmrGjdtxXvPae57i97MIGzXXH22ObNIx7nwzr
	 NoFGCQSxUHANMA+H8wt84xctDrUkokUIMNn9axYMjJ9nJdDNbfvjMepaxTVp6AS0r5
	 psgJYDu3a5F+D4jtaZZzQymYbojWpnvu3HcCw4znUbCMcLGwDSOc94Oup8DMgTcXLV
	 0w1687LSGL/Qq+j+hLB0iGG5os50KJyphWbgo0qnKOCkN+a+3XQK+0AcucPMwX6dMx
	 Pgkmb5FjTMpkw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0441987ED6;
 Tue, 20 Feb 2024 16:32:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708443140;
 bh=yJ2EAv7NnzAt32fe2tQU0PeR5u4AY19aBlYABNz5zFs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mH8Xm6Caj9wlfHf56Hq/dfdPKXGFLgaWfHdvAQgGOVMmTOL1vP2UPFHca51qjbPK5
 rqdr6rg1NeJiD5WErVViNXFe7673DFMHWSD3vGrh3Bk21vUz+jEEl1P3vkmM+ZqdNf
 MHuRXN9khaXWy4DWZqHug8iMRe7c94YuuPFGTLy0V0co8NA2GxUsv8iGBh7/0/Gqp+
 WElpbbVbiRDdTpi7eR8j+R7yVz3D7FxtgmZ14u3WhTvxwgzYmMWgLSGxXUWDpwMORQ
 zBwB4Glw3hFpTw8Ri/obxUI20HY3LUibg+PiPynkK+R8/ajehI0ydPM3RtNojsATxg
 V9wkxJZnVXefw==
Message-ID: <6111dab9-62e2-4ef6-9007-448bf0f4fc0b@denx.de>
Date: Tue, 20 Feb 2024 16:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] imx8mp: Enable PCIe/NVMe support
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240220131056.2962331-1-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/20/24 14:10, Sumit Garg wrote:
> pcie_imx doesn't seem to share any useful code for iMX8MP SoC and it is
> rather tied to quite old port of pcie_designware driver from Linux which
> suffices only iMX6 specific needs.
> 
> But currently we have the common DWC specific bits which alligns pretty
> well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> add support for other iMX8 variants to this driver.
> 
> iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> can reuse the generic PHY infrastructure to power on PCIe PHY.
> 
> Patch #1: Adds PCIe clocks support.
> Patch #2: Adds i.MX8MP reset controller support.
> Patch #3: Extend i.MX8MP power domain driver with PCIe support
> Patch #4: Expose high performance PLL clock required for PCIe PHY
>            on verdin board.
> Patch #5: Adds standalone PCIe PHY support for i.MX8MP SoC.
> Patch #6: Adds DW PCIe controller support for iMX8MP SoC.
> Patch #7: Enable PCIe/NVMe support for verdin board.
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
>              Type: Hard Disk
>              Capacity: 122104.3 MB = 119.2 GB (250069680 x 512)
> Verdin iMX8MP #
> Verdin iMX8MP # load nvme 0 $loadaddr <file-name>
> 
> Sumit Garg (7):
>    clk: imx8mp: Add support for PCIe clocks
>    reset: imx: Add support for i.MX8MP reset controller
>    imx8mp: power-domain: Add PCIe support
>    imx8mp: power-domain: Expose high performance PLL clock
>    phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe PHY
>    pci: Add DW PCIe controller support for iMX8MP SoC
>    verdin-imx8mp_defconfig: Enable PCIe/NVMe support
> 
>   configs/verdin-imx8mp_defconfig       |   9 +
>   drivers/clk/imx/clk-imx8mp.c          |   6 +
>   drivers/pci/Kconfig                   |   8 +
>   drivers/pci/Makefile                  |   1 +
>   drivers/pci/pcie_dw_imx8.c            | 348 ++++++++++++++++++++++++++

You can call this pcie_dw_imx.c , the imx6 support can be converted over 
to that driver too I guess ?
