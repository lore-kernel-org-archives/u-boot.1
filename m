Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4635C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 11:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8013871CF;
	Mon, 15 Jan 2024 12:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fnl3U1Wd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3814E86FF9; Mon, 15 Jan 2024 12:40:14 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32DE0871CF
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 12:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 7987ECE0A1D;
 Mon, 15 Jan 2024 11:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3F2C433F1;
 Mon, 15 Jan 2024 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705318805;
 bh=4grwlrNENwsSa/FcXPkqPWtyuk25goyJrHMkpAv+3aI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Fnl3U1WdQRHr56x1fXcDfPxdTx5YptkTc7VF3C7buJ6hD7CzgEoqgke2KCTeCqanV
 raDpzAJu65ZDAl6Te2tnHF3CXZC5HdhfkfLDsTnfDCvrSpJR7sAamr5oBpzE2XOx06
 JtsiG5m19ZUBuB+MHF4IPtc1fMQTjjZ4ifnmc2uIGZdlvbRV28fpd9PkovtEa8rmfp
 flHm3d3mAjC0Ot4v8Sj8G0ZdfR+JBo1CFXowqC4tpr7dVVe56XRkkk+DgTsZa2nhDA
 N1QPAyq4SLo7yvSPAPeU1TmpEjMfD23hy3JrRvQ5Fc47ct2Co5rhHZLjyXOFx4iNff
 j++x3vDowS9Hg==
Message-ID: <1f4ceaf6-0387-4010-bbcd-0f6970428e8c@kernel.org>
Date: Mon, 15 Jan 2024 13:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm: dts: k3-j721e-beagleboneai64: Fix USB operation
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>
Cc: robertcnelson@gmail.com, marex@denx.de, n-francis@ti.com,
 praneeth@ti.com, s-vadapalli@ti.com, r-gunasekaran@ti.com, srk@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de
References: <20240112124951.238098-1-rogerq@kernel.org>
 <20240112124951.238098-5-rogerq@kernel.org>
 <20240112130233.bflterluncjoyrhy@treadmill>
 <8f5d151c-aebb-41d9-b638-83c60e740d15@kernel.org>
 <20240112131450.tpn454pfzlqlteed@urology>
 <20240112132131.GN1610741@bill-the-cat>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240112132131.GN1610741@bill-the-cat>
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



On 12/01/2024 15:21, Tom Rini wrote:
> On Fri, Jan 12, 2024 at 07:14:50AM -0600, Nishanth Menon wrote:
>> On 15:06-20240112, Roger Quadros wrote:
>>>
>>>
>>> On 12/01/2024 15:02, Nishanth Menon wrote:
>>>> On 14:49-20240112, Roger Quadros wrote:
>>>>> Without correct SERDES MUX and Lane control settings
>>>>> USB0 will be broken. Set the MUX and Lane control devices
>>>>> to be auto probed so they are configured correctly.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>> ---
>>>>>  arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>>>>> index f83caf7998..017a5a722e 100644
>>>>> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>>>>> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
>>>>> @@ -165,6 +165,7 @@
>>>>>  
>>>>>  &serdes_ln_ctrl {
>>>>>  	bootph-all;
>>>>> +	u-boot,mux-autoprobe;
>>>>>  };
>>>>>  
>>>>>  &serdes2_usb_link {
>>>>> @@ -173,6 +174,7 @@
>>>>>  
>>>>>  &usb_serdes_mux {
>>>>>  	bootph-all;
>>>>> +	u-boot,mux-autoprobe;
>>>>>  };
>>>>>  
>>>>>  &serdes_wiz2 {
> 
> OK, so both of these are compatible = "mmio-mux", is the problem they
> aren't probed in time or something else?
> 

That's correct. They aren't probed ever. But that is because there are no
explicit consumers for them. Since this is a platform wide configuration,
we have been relying on the "idle-states" property and that they are auto-probed.

>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>>
>>>> Is this a u-boot thing? or a driver limitation?
>>>>
>>>
>>> u-boot specific. We just want the mux driver to probe
>>> and apply the settings.
>>>
>>> from drivers/mux/mux-uclass.c
>>>
>>> int dm_mux_init(void)
>>> {
>>>         struct uclass *uc;
>>>         struct udevice *dev;
>>>         int ret;
>>>
>>>         ret = uclass_get(UCLASS_MUX, &uc);
>>>         if (ret < 0) {
>>>                 log_debug("unable to get MUX uclass\n");
>>>                 return ret;
>>>         }
>>>         uclass_foreach_dev(dev, uc) {
>>>                 if (dev_read_bool(dev, "u-boot,mux-autoprobe")) {
>>>                         ret = device_probe(dev);
>>>                         if (ret)
>>>                                 log_debug("unable to probe device %s\n",
>>>                                           dev->name);
>>>                 }
>>>         }
>>>
>>>         return 0;
>>> }
>>>
>>>
>>
>> Uggh.. We need to see eventually how to get rid of this.
>> This makes
>> https://lore.kernel.org/u-boot/20240110103547.719757-1-sumit.garg@linaro.org/#t
>> harder now?
> 
> No, it should be fine, Sumit's series handles -u-boot.dtsi files.
> 

-- 
cheers,
-roger
