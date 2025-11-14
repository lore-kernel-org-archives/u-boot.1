Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C02CE7A9A
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 09:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3757C83EE3;
	Fri, 14 Nov 2025 10:16:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OanU7ELu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B416583EFC; Fri, 14 Nov 2025 10:16:31 +0100 (CET)
Received: from mail-m19731120.qiye.163.com (mail-m19731120.qiye.163.com
 [220.197.31.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CD8583EDF
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 10:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=shawn.lin@rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 29992e5be;
 Fri, 14 Nov 2025 17:16:22 +0800 (GMT+08:00)
Message-ID: <e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com>
Date: Fri, 14 Nov 2025 17:16:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 linux-pci <linux-pci@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>, krzk+dt <krzk+dt@kernel.org>,
 conor+dt <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>,
 linux-rockchip <linux-rockchip@lists.infradead.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, =?UTF-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
To: Geraldo Nascimento <geraldogabriel@gmail.com>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
 <aRQ_R90S8T82th45@geday> <aRUvr0UggTYkkCZ_@geday> <aRazCssWVdAOmy7D@geday>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aRazCssWVdAOmy7D@geday>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a81a6c7ff09cckunm83f5efda44ea74
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhgYQlZCQx9JSU5DSkNPSh9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=OanU7ELuu0i6QxNwaBwYgLpQCUE6kBkXnosBpB5xJa+/1c8gaH9JjY3Crn4xM7igJavW9mLTplYkYMO2WXlXr40/yHnKDOGRpyQQRywI3wvtfothQLLLSpusqui0Vwx57upf1ejVQaFOQ/Bxnq8U70SFQxa91P3HMX8M5OD1UuE=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=pAiVqyQ+kiQN8Phi43cHK6Tl1rhV/2RbqIHqDBjVGzk=;
 h=date:mime-version:subject:message-id:from;
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

在 2025/11/14 星期五 12:41, Geraldo Nascimento 写道:
> On Wed, Nov 12, 2025 at 10:09:15PM -0300, Geraldo Nascimento wrote:
>> Hi Ye, Shawn,
>>
>> Here's more contained workaround without resorting to clearing DDR to
>> INPUT for every GPIO:
>>
>> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
>> index ee1822ca01db..1d89131ec6ac 100644
>> --- a/drivers/pci/controller/pcie-rockchip-host.c
>> +++ b/drivers/pci/controller/pcie-rockchip-host.c
>> @@ -315,7 +315,8 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>>   			    PCIE_CLIENT_CONFIG);
>>   
>>   	msleep(PCIE_T_PVPERL_MS);
>> -	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
>> +	gpiod_direction_input(rockchip->perst_gpio);
>> +	gpiod_direction_output(rockchip->perst_gpio, 1);
>>   
>>   	msleep(PCIE_RESET_CONFIG_WAIT_MS);
>>   
>> This results in working PCIe for me, pass initial link training.
> 
> Sorry for the inconvenience of more mail, but I'm providing as much
> detail as I can.
> 

Don't worry, it's helpful, so I think Ye could have a look.
May I ask if the failure only happened to one specific board?

Another thing I noticed is about one commit:
114b06ee108c ("PCI: rockchip: Set Target Link Speed to 5.0 GT/s before 
retraining")

It said: "Rockchip controllers can support up to 5.0 GT/s link speed."
But we issued an errata long time ago to announced it doesn't, you could
also check the PCIe part of RK3399 datasheet:
https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf

Also we set max-link-speed to ONE in rk3399-base.dtsi but seems another
patch slip in: 755fff528b1b ("arm64: dts: rockchip: add variables for 
pcie completion to helios64")

> This hack has been confirmed to work in U-boot also.
> 
> diff --git a/drivers/pci/pcie_rockchip.c b/drivers/pci/pcie_rockchip.c
> index 19f9e58a640..5702b607ee6 100644
> --- a/drivers/pci/pcie_rockchip.c
> +++ b/drivers/pci/pcie_rockchip.c
> @@ -329,8 +329,10 @@ static int rockchip_pcie_init_port(struct udevice *dev)
>   	writel(PCIE_CLIENT_LINK_TRAIN_ENABLE,
>   	       priv->apb_base + PCIE_CLIENT_CONFIG);
>   
> -	if (dm_gpio_is_valid(&priv->ep_gpio))
> -		dm_gpio_set_value(&priv->ep_gpio, 1);
> +	if (dm_gpio_is_valid(&priv->ep_gpio)) {
> +		dm_gpio_set_dir_flags(&priv->ep_gpio, (priv->ep_gpio.flags & ~GPIOD_IS_OUT) | GPIOD_IS_IN);
> +		dm_gpio_set_dir_flags(&priv->ep_gpio, (priv->ep_gpio.flags & ~GPIOD_IS_IN) | GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> +	}
>   
>   	ret = readl_poll_sleep_timeout
>   			(priv->apb_base + PCIE_CLIENT_BASIC_STATUS1,
> 
> So my report suggests this is not specific to Linux and because same
> workaround works in U-boot simplified driver model I suggest you check
> from your side.
> 
> Previously PCIe link training timeout, not working. Now I'm very happy
> with working PCIe in Linux and U-boot.
> 
> Thanks,
> Geraldo Nascimento
> 

