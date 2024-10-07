Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB022CFB448
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 16:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DB5788CD9;
	Mon,  7 Oct 2024 18:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728317188;
	bh=63xurK2ZWcMFP0pG/ZE1lWWdsIcNF8LS8hK+NwdcpRc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DnZm94Sv4yhgFw8sDHYoWGj/lXx9G3E1MN084jlvz+09+bqkqAkbC9l0+SYIOUt2j
	 TAuPK6mLIt0fuhFb9bTRPAa9yENFn4W68heL4jJco0AtgcTmsjjmBtpaFYamhQ7UTD
	 b8hiZAkWiPXyidgvQHW3ytaMyUurYMPUSffS0wbCpslk37G2FI6yxS8bQX4a4GiZr3
	 kX2nZgALVRBEdNe7fw3OUXvyd2rGGk0F/OqcPWLi5bULwmUB+Vp5qQKvCPNhxjg7nm
	 khG19qEynNe182KCq6mxmNa1ceo2YbyXB5yLrvKpWZygI643ZJHVFZFPQ5c5K1XR4v
	 JmYabzdzvgWeA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B091E87E30;
 Mon,  7 Oct 2024 18:06:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728317186;
 bh=63xurK2ZWcMFP0pG/ZE1lWWdsIcNF8LS8hK+NwdcpRc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=H++W6CbQ8UbcVMk9wjlzKec2yoQVpphChN6A9eIWlgvKfdtstVmz6OSw8/9zcc8am
 pHsQwXSz0gyrUvIO1/M4MXYEA1KS3V2KBNEr9Nzq+jswOhQUMg/OIckLfPBqet1ho6
 y2xoJJeVXeZ3nog8OioHvssHlamMr1X1LC8Kqoq3ARo7rXUc5SY5HOMEkCWSF5ds2C
 NjI3Na8l2PjmM4jAobv4S4GKcf6LbpoqgNSgDLu06LL7rJ2ypwhvfUvDhPAGWEdlOa
 t2/fwysyAdNUmduLfflGyoiZYAdI5eQ77IMAuPrla6zWOIACCb6bmF4UMdZGa/PYdS
 Uq678Yc7ZPWTA==
Message-ID: <06ff501e-ebf2-402a-a058-5bbffd00f545@denx.de>
Date: Mon, 7 Oct 2024 17:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] usb: onboard-hub: Add reset-gpio support
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "Simek, Michal" <michal.simek@amd.com>,
 "fabrice.gasnier@foss.st.com" <fabrice.gasnier@foss.st.com>,
 "git (AMD-Xilinx)" <git@amd.com>
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
 <20241007044547.23896-2-venkatesh.abbarapu@amd.com>
 <eb74b41b-9546-4c68-a724-00c2e33c9deb@denx.de>
 <SA1PR12MB8697CE2214E5DD0A5A764833987D2@SA1PR12MB8697.namprd12.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <SA1PR12MB8697CE2214E5DD0A5A764833987D2@SA1PR12MB8697.namprd12.prod.outlook.com>
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

On 10/7/24 5:03 PM, Abbarapu, Venkatesh wrote:

[...]

>>>    static int usb_onboard_hub_probe(struct udevice *dev)
>>>    {
>>>    	struct onboard_hub *hub = dev_get_priv(dev); @@ -30,7 +67,11 @@
>>> static int usb_onboard_hub_probe(struct udevice *dev)
>>>    	if (ret)
>>>    		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
>>>
>>> -	return ret;
>>> +	ret = usb_onboard_hub_reset(dev);
>>
>> return usb_onboard_hub_reset(dev);
> <Venkatesh> By adding the "return usb_onboard_hub_reset(dev);" we miss the code which  does i2c initialization sequence which is part of [PATCH v4 4/7] usb: onboard-hub: Add i2c  initialization for usb5744 hub of the series.
Surely this can be solved in 4/7 ?
