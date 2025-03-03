Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4ACC282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 21:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140D481280;
	Mon,  3 Mar 2025 22:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741039042;
	bh=K/bZmLI280+ELbapI+/Z06ggEPFLqnntlD1r0SJwtjQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGOtYhrxzZsjNtemVNVRl7/lTNk6ErgA/UzXJGg2MYjq7NFy36C0Ba/k/bKVwIIYt
	 RjIffF0Wk1HQ2tNXJMDqNDzbA02uShWWFTPdXTSM8amLWrUaXo/bD0poy7waPYUfmj
	 5UJOm3ks2QcOxcJQLW8/orwBMGD7pzeSqo3YWZ1KHciuwtb77w4sYfK6l4GSm8v4YZ
	 +cC9ZqjxzNEioDxhaFNtpUAzNauClX/SR5JQqmGvEip6XuuqOfPzcB+hrTaACvi96q
	 LCn071rgSwsgwcsajk7DmSZ9ZxyVPjPkQwP9s4LJw6LYHYofsYY8bEiOFobc8WWvAG
	 yHiK0epXsZ6tg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2CC3812BC; Mon,  3 Mar 2025 22:57:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C534E811B3
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 22:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BRHOh8kX"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7408810381917; Mon,  3 Mar 2025 22:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741039039; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=K/bZmLI280+ELbapI+/Z06ggEPFLqnntlD1r0SJwtjQ=;
 b=BRHOh8kXfem0Zgt/6JQqaE0JuWE1n61BHgBotiY9qHg8POvC810UKn+FSGsymfWl5rJGP0
 Kr4R4tO3uzvHO29EH2uYlQM5DzgeOw4KG8vcP1LyTnlvuWqRqWnPaNYnDJEN6kxs9vO8mD
 tAWeTi0SJTyHnKVX2ig8cgSVm3od9dusiM6rR3Fc1fo0fWXdLBQ2MmNCwleHIhgeg+kAEc
 9z9U6dQqqRp9jHAtNkwgkoYus/amQFu3hr0MnJxE4kiAr2dXQphs+Bm4OUev17TAcmEjPB
 fY+t7hc+P2MaLEmFIeP/B4+jJgLeCTO9ZcCu/bpvGjgTVntzPplehn1EUN7r/A==
Message-ID: <3b232bda-000e-4f6b-8661-eeb72fc78b67@denx.de>
Date: Mon, 3 Mar 2025 21:52:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2NCAwNC8y?=
 =?UTF-8?Q?0=5D_firmware=3A_scmi=3A_add_pin_control_protocol_support_to_SCMI?=
 =?UTF-8?Q?_agent?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
 <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
 <PAXPR04MB96446C0606C01C6CC5B3622FE2FA2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1eb93e8b-0355-4274-a680-f6481e398e5a@denx.de>
 <PAXPR04MB9644F7D41AE5AB9EF61FC5DBE2C72@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <5bb207d9-0ad0-4409-9c3d-bdf676cc7698@denx.de>
 <20250224022831.GA9876@nxa18884-linux>
 <c1654174-8473-46a9-9b0b-925b65ab4413@denx.de>
 <PAXPR04MB9644FE1F92AFF132649A7EA5E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB9644FE1F92AFF132649A7EA5E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/3/25 9:04 AM, Alice Guo (OSS) wrote:

[...]

>>> In Linux Kernel, there are two drivers, pinctrl-scmi.c and pinctrl-imx-scmi.c.
>>> Both follows ARM SCMI 3.2, but pinctrl-imx-scmi has some special
>>> settings to align with i.mx iomuxc array based settings, mux,input,pad and etc.
>>>
>>> In gerneral, imx part could be merged with pinctrl-scmi.c but that
>>> will make code not clean.
>> In that case, why does U-Boot not have pinctrl-imx-scmi.c to contain the iMX
>> customization too ? If this protocol is IMX specific, it shouldn't be ifdeffed in
>> common code.
> 
> Is it acceptable to rename " drivers/pinctrl/nxp/pinctrl-scmi.c" to "drivers/pinctrl/nxp/ pinctrl-imx-scmi.c"? SCMI_PROTOCOL_ID_PINCTRL = 0x19 is not i.MX specific.

Look at this commit, which allows drivers placed in some driver.c file 
insert their driver entry into a linker list, and then some common code 
can iterate over this linker list and match drivers against some properties.

In this case, it is a PHY driver which does list supported PHY IDs in 
each U_BOOT_PHY_DRIVER, and the common code checks whether the PHY IDs 
match when a new PHY gets registered:

7940a93eb977 ("net: phy: Iterate over both registered PHYs and struct 
phy_driver linker list")

This is the driver side conversion example:

20bd8e4fcbb5 ("net: phy: gen10g: Convert to U_BOOT_PHY_DRIVER()")

What you could do is the same:

- Basically duplicate the mechanism in 7940a93eb977 ("net: phy: Iterate 
over both registered PHYs and struct phy_driver linker list"), call it 
e.g. U_BOOT_SCMI_DRIVER()
- Switch SCMI drivers to use U_BOOT_SCMI_DRIVER , have each one list a 
protocol ID (instead of the PHY IDs), and then use the 
scmi_agent-uclass.c to iterate over all the linker lists

About the MX95 specifics and handling those, it is possible to have two 
drivers which support the same hardware compiled into U-Boot and have 
them decide at bind time which driver should bind and which not, look at 
drivers/mtd/renesas_rpc_hf.c rpc_hf_probe() and 
drivers/spi/renesas_rpc_spi.c rpc_spi_bind() for example of doing this.

I hope this helps untangle the SCMI implementation.
