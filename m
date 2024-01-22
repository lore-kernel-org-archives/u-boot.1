Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED95C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A69528796E;
	Mon, 22 Jan 2024 12:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PVR3vDMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67ECC879A0; Mon, 22 Jan 2024 12:39:24 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B2D8796E
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B591B611E2;
 Mon, 22 Jan 2024 11:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC711C43390;
 Mon, 22 Jan 2024 11:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705923552;
 bh=piYu3aWUGwa7L8ZJgJcNkdLNxTOLcTmLx0KxLqZVznk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PVR3vDMXLF0pDlmR0kXcBA8gb0XP7L2yl+PhOoFQ+nPUvh/9P3bqGhHR6X/PabOUP
 c4zn9bSVaRpnsVd7b4VoqqK6XYkypqw01OMZJgY5h5OvEhMQM6Ie5lpeTXYJGNoYzJ
 vRwnreCcNqR8yddMn7yDFnpJdZQAeymfBU1yBZcA4P5hmOwPIaPabliod1XvDaiyi3
 W+hoJacH9TXiAUJkNFgL+N0gMPrWBQH2EVuPJxvpgQK5ifpGjccuX6mT85LU5JI9kj
 SC/Y/aG+jqrxZXNCqV115/c6AI0L8EXW3Yu3oamkroj9DdN6Jts/1aXAovNK3w2dNG
 lnEEp3qTsApAg==
Message-ID: <a9214eef-c398-434b-88c5-6de41df508bc@kernel.org>
Date: Mon, 22 Jan 2024 13:39:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm: dts: k3-j721e-beagleboneai64: Fix USB operation
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, robertcnelson@gmail.com, marex@denx.de,
 n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
 srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de
References: <20240112124951.238098-1-rogerq@kernel.org>
 <20240112124951.238098-5-rogerq@kernel.org>
 <20240112130233.bflterluncjoyrhy@treadmill>
 <8f5d151c-aebb-41d9-b638-83c60e740d15@kernel.org>
 <20240112131450.tpn454pfzlqlteed@urology>
 <20240112132131.GN1610741@bill-the-cat>
 <1f4ceaf6-0387-4010-bbcd-0f6970428e8c@kernel.org>
 <20240120165052.GB3652023@bill-the-cat>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240120165052.GB3652023@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
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



On 20/01/2024 18:50, Tom Rini wrote:
> On Mon, Jan 15, 2024 at 01:40:00PM +0200, Roger Quadros wrote:
>>
>>
>> On 12/01/2024 15:21, Tom Rini wrote:
>>> On Fri, Jan 12, 2024 at 07:14:50AM -0600, Nishanth Menon wrote:
>>>> On 15:06-20240112, Roger Quadros wrote:
>>>>>
>>>>>
>>>>> On 12/01/2024 15:02, Nishanth Menon wrote:
>>>>>> On 14:49-20240112, Roger Quadros wrote:
>>>>>>> Without correct SERDES MUX and Lane control settings
>>>>>>> USB0 will be broken. Set the MUX and Lane control devices
>>>>>>> to be auto probed so they are configured correctly.
>>>>>>>
>>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>>>> ---
>>>>>>>  arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 2 ++
>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>>>>>>> index f83caf7998..017a5a722e 100644
>>>>>>> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>>>>>>> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>>>>>>> @@ -165,6 +165,7 @@
>>>>>>>  
>>>>>>>  &serdes_ln_ctrl {
>>>>>>>  	bootph-all;
>>>>>>> +	u-boot,mux-autoprobe;
>>>>>>>  };
>>>>>>>  
>>>>>>>  &serdes2_usb_link {
>>>>>>> @@ -173,6 +174,7 @@
>>>>>>>  
>>>>>>>  &usb_serdes_mux {
>>>>>>>  	bootph-all;
>>>>>>> +	u-boot,mux-autoprobe;
>>>>>>>  };
>>>>>>>  
>>>>>>>  &serdes_wiz2 {
>>>
>>> OK, so both of these are compatible = "mmio-mux", is the problem they
>>> aren't probed in time or something else?
>>>
>>
>> That's correct. They aren't probed ever. But that is because there are no
>> explicit consumers for them. Since this is a platform wide configuration,
>> we have been relying on the "idle-states" property and that they are auto-probed.
> 
> OK.  Could we borrow the "wrap" logic that drivers/led/led_gpio.c for
> example does to get the probe to happen inside drivers/mux/mmio.c
> instead? I feel like there might have been assumptions about grander
> needs back when the framework for muxers was done that has not panned
> out since.
> 

We only need the MUX driver to probe if the MUX node contains the "idle-states"
property.

So maybe the MUX UCLASS code should be checking for that instead of/along with
the custom u-boot,mux-autoprobe property?

How does this look?

diff --git a/drivers/mux/mux-uclass.c b/drivers/mux/mux-uclass.c
index c98576ceb8..8833888ded 100644
--- a/drivers/mux/mux-uclass.c
+++ b/drivers/mux/mux-uclass.c
@@ -318,7 +318,8 @@ int dm_mux_init(void)
 		return ret;
 	}
 	uclass_foreach_dev(dev, uc) {
-		if (dev_read_bool(dev, "u-boot,mux-autoprobe")) {
+		if (dev_read_bool(dev, "u-boot,mux-autoprobe") ||
+		    dev_read_bool(dev, "idle-states")) {
 			ret = device_probe(dev);
 			if (ret)
 				log_debug("unable to probe device %s\n",

-- 
cheers,
-roger
