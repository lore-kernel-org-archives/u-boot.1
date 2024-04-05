Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F16C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 15:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12A288845A;
	Fri,  5 Apr 2024 17:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712329976;
	bh=Wbuo586ODIJCc9HyklYmgrdunJ8yNUkGojLIMtPBjjE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oHsQd3fvA3hiM2zmiZkPPOjSGJte5qp5selhnQqo2XUsmAHTEitEya6CHrcj3VvTz
	 cvD80gUhQaP0oqSyb6QI7PgHNbOrBtHUQ45LlYPhhPRVuw+bHTjXtS56/2Y9jkr8sS
	 W+g6Hvpb1kr40ukjjs9Yod5Y1j5TNilye6y1zCKEiHEloHO1JITmI2N0xG4pFvk3Ct
	 BrR31SvATyMWl3pU9BC2stG3DsKOn/f8rBJqcvBB99Tg1gUrKejDffhHCPqt1ZalZH
	 dgAIyMe2gTWyvkSVxCONGb0+V/txoPG4PaIrb8GvwaHzewhrRhqh+cH476DN+Hi1+y
	 FsRdo8LzOU2Jw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 16AF588456;
 Fri,  5 Apr 2024 17:12:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1712329975;
 bh=Wbuo586ODIJCc9HyklYmgrdunJ8yNUkGojLIMtPBjjE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=GnQ7mFvTW6Bt7lXO0I7FR+iNYyaIDhhEv7mEIwQUZ+LQTNbRodclz9IpWfWSKzk3D
 jF+F+Hy5LoKry3xVm2m9MTGh3qh3GTWMqV77wikQFecM2Ielv6/sjYUvyCosRpsRiC
 I8vHwTR10Kfq9gmAuPSS9zySdMvHI4uHh7CcCQOb2Nt7Gj0ILoJlpr7G1EbSJstIwJ
 2FXey1vrFlFzSLZhtg1g/l862iAY/6DQ2ykj1zAd5JyYjD+KK0J2Aw1RyhAAj1mJUd
 9breb6bea5I3+Hv5CaFR2uYAnghlUHwIEYkMioFPbqCzUTjR0Mp1v4vSfEuKGqablM
 e4xeG+ihutBhA==
Message-ID: <fb5e342b-7aed-40f4-ad62-83d0c775000b@denx.de>
Date: Fri, 5 Apr 2024 17:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] net: dwc_eth_qos: Add support of STM32MP13xx
 platform
To: Christophe ROULLIER <christophe.roullier@foss.st.com>, u-boot@lists.denx.de
Cc: "Cc: Patrice Chotard" <patrice.chotard@foss.st.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240309021831.264018-1-marex@denx.de>
 <20240309021831.264018-12-marex@denx.de>
 <515d659f-8096-41aa-8749-553fcb8021fe@foss.st.com>
 <DU2PR10MB77870EA1FBA37E465D592EEB8F2A2@DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM>
 <aa1ef1a0-9c2c-40ab-96a9-b4de713ed134@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <aa1ef1a0-9c2c-40ab-96a9-b4de713ed134@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/5/24 4:56 PM, Christophe ROULLIER wrote:
>> On 3/9/24 03:11, Marek Vasut wrote:
>>> From: Christophe Roullier <christophe.roullier@st.com>
>>>
>>> Add compatible "st,stm32mp13-dwmac" to manage STM32MP13 boards.
>>>
>>> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
>>> Signed-off-by: Marek Vasut <marex@denx.de> # Rebase, reshuffle, squash
>>> code
>>> ---
>>> Cc: Christophe Roullier <christophe.roullier@st.com>
>>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Cc: Ramon Fried <rfried.dev@gmail.com>
>>> Cc: u-boot@dh-electronics.com
>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>> ---
>>>   drivers/net/dwc_eth_qos.c       |  4 ++++
>>>   drivers/net/dwc_eth_qos.h       |  1 +
>>>   drivers/net/dwc_eth_qos_stm32.c | 11 +++++++++++
>>>   3 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
>>> index 203bfc0848c..e02317905e5 100644
>>> --- a/drivers/net/dwc_eth_qos.c
>>> +++ b/drivers/net/dwc_eth_qos.c
>>> @@ -1505,6 +1505,10 @@ static const struct udevice_id eqos_ids[] = {
>>>        },
>>>   #endif
>>>   #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STM32)
>>> +     {
>>> +             .compatible = "st,stm32mp13-dwmac",
>>> +             .data = (ulong)&eqos_stm32mp13_config
>>> +     },
>>>        {
>>>                .compatible = "st,stm32mp1-dwmac",
>>>                .data = (ulong)&eqos_stm32mp15_config diff --git
>>> a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h index
>>> bafd0d339fb..8b3d0d464d3 100644
>>> --- a/drivers/net/dwc_eth_qos.h
>>> +++ b/drivers/net/dwc_eth_qos.h
>>> @@ -290,5 +290,6 @@ int eqos_null_ops(struct udevice *dev);  extern
>>> struct eqos_config eqos_imx_config;  extern struct eqos_config
>>> eqos_rockchip_config;  extern struct eqos_config eqos_qcom_config;
>>> +extern struct eqos_config eqos_stm32mp13_config;
>>>   extern struct eqos_config eqos_stm32mp15_config;  extern struct
>>> eqos_config eqos_jh7110_config; diff --git
>>> a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
>>> index 00bf6d45568..e167a7ba901 100644
>>> --- a/drivers/net/dwc_eth_qos_stm32.c
>>> +++ b/drivers/net/dwc_eth_qos_stm32.c
>>> @@ -314,6 +314,17 @@ static struct eqos_ops eqos_stm32_ops = {
>>>        .eqos_get_tick_clk_rate = eqos_get_tick_clk_rate_stm32  };
>>>
>>> +struct eqos_config __maybe_unused eqos_stm32mp13_config = {
>>> +     .reg_access_always_ok = false,
>>> +     .mdio_wait = 10000,
>>> +     .swr_wait = 50,
>>> +     .config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
>>> +     .config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
>>> +     .axi_bus_width = EQOS_AXI_WIDTH_32,
>>> +     .interface = dev_read_phy_mode,
>>> +     .ops = &eqos_stm32_ops
>>> +};
>>> +
>>>   struct eqos_config __maybe_unused eqos_stm32mp15_config = {
>>>        .reg_access_always_ok = false,
>>>        .mdio_wait = 10000,
> 
> Reviewed-by: Christophe ROULLIER <christophe.roullier@foss.st.com>

Thank you. There is a V2 series submitted, can you add those tags there 
too ?
