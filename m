Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AC4D78321
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 14:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70AFF8919F;
	Mon,  2 Dec 2024 15:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KHGKrm0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E97F88BFB; Mon,  2 Dec 2024 15:09:27 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516BA8914C
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 15:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id EA2A5A40DA3;
 Mon,  2 Dec 2024 14:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70666C4CED1;
 Mon,  2 Dec 2024 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733148562;
 bh=QHSeCb8w02Zu+XfB76CIckqpiN3P69pGa88IA4W4Qps=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KHGKrm0xUJiRN7Z5U+YnOCYnAJwWK3vW+9kpdsr6u/PXFzWuVv88qiCvKlITaHQXf
 r9pbSka38LtKIXDA6Ax4JOMNRKVHPmygNO5h/VsgUbZLFeYViPWKgsxlKuhniXzFZA
 WvWvZWWZrDCJiPMVHYct6yNImHIG+Y1lexv5aw6P8v9W1aHdDPzPFaSAVUN2A/jGAo
 FONOzkutXZVxmvuyA9etbbHkazfSJzFP2+RyY2gEFYlwDXF0pz9UKOzC/WhuOicpMC
 eER676mejfN6vd9ZzHN712NX80lvlA98HW3rSzVBQsibmAzCYt38MDzl/VLkwZQC2U
 cUEC2fcUBIycg==
Message-ID: <2b705d26-2ff0-47a2-8db6-d8561a24b567@kernel.org>
Date: Mon, 2 Dec 2024 16:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, trini@konsulko.com, marex@denx.de,
 hnagalla@ti.com, mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, jonas@kwiboo.se,
 j-humphreys@ti.com, nm@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de, srk@ti.com
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
 <20241126120322.1760862-2-s-vadapalli@ti.com>
 <f4c4cb82-0e8c-49a1-aff0-2c539f15047d@kernel.org>
 <252751ec-2000-43bd-a9e3-fc0b53362baf@ti.com>
 <84c24040-5311-469f-8ba7-470280604245@kernel.org>
 <i7kcsazysfv5brn5bzgh5yypgr7hl2qndd5aqdrgbkb6ztmvxo@qwuxqa7vm2nt>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <i7kcsazysfv5brn5bzgh5yypgr7hl2qndd5aqdrgbkb6ztmvxo@qwuxqa7vm2nt>
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



On 02/12/2024 07:42, Siddharth Vadapalli wrote:
> On Fri, Nov 29, 2024 at 02:28:36PM +0200, Roger Quadros wrote:
>>
>>
>> On 28/11/2024 19:20, Siddharth Vadapalli wrote:
> 
> [...]
> 
>>> USB DFU boot utilizes this driver when the "dr_mode" is set to "otg" in
>>> the device-tree for AM62A. This driver is invoked both for the host and
>>> device commands corresponding to USB. I came up with this patch while
>>> trying to enable USB DFU boot on AM62A with "dr_mode" as "otg" in the
>>> device-tree. Additionally, USB DFU boot works on AM62A with the change
>>> made by this patch and it doesn't work without this change. I have
>>> traced the call sequence to see that the driver is probed and have come
>>> up with the change performed in this patch on the basis of this observation.
>>>
>>
>> Although the glue driver portion of the dwc3-generic driver is not used by AM62
>> it still uses the generic_probe() portion via
>> U_BOOT_DRIVER(dwc3_generic_host) and U_BOOT_DRIVER(dwc3_generic_peripheral)
>>
>> here is the dm tree output on am62-sk after executing "usb start" command.
>>
>>
>>  simple_bus    5  [ + ]   dwc3-am62             |   |-- dwc3-usb@f900000
>>  usb_gadget    0  [   ]   dwc3-generic-periphe  |   |   |-- usb@31000000
>>  usb           0  [ + ]   xhci-dwc3             |   |   `-- usb@31000000
>>  usb_hub       0  [ + ]   usb_hub               |   |       `-- usb_hub
>>  simple_bus    6  [ + ]   dwc3-am62             |   |-- dwc3-usb@f910000
>>  usb           1  [   ]   dwc3-generic-host     |   |   |-- usb@31100000
>>  usb           1  [ + ]   xhci-dwc3             |   |   `-- usb@31100000
>>  usb_hub       1  [ + ]   usb_hub               |   |       `-- usb_hub
>>
>> what is strange is that even though usb@31000000 is configured as
>> "peripheral" (in k3-am625-sk-u-boot.dtsi), xhci-dwc3 and usb_hub drivers
>> are still initialized for it.
> 
> CONFIG_OF_UPSTREAM is enabled in am62x_evm_a53_defconfig. So dr_mode
> might be "otg" as specified in:
> dts/upstream/src/arm64/ti/k3-am62-main.dtsi

Not it is not "otg". it is "peripheral". I verified from the generated 
u-boot.dtb

Isn't k3-am625-sk-u-boot.dtsi still used even if it is CONFIG_OF_UPSTREAM?

> I'm not sure about this however. Additionally, this series isn't required
> for AM62. DFU Boot works on AM62 without this series as well. This series
> is required for AM62A.

It works on am62-sk because USB mode is forced to "peripheral" in
k3-am625-sk-u-boot.dtsi.

That hack can be removed once your series fixes it the right way.

> 
> [...]
> 
>>> I didn't test the case where both are used. I validated that peripheral
>>> mode works across various stages of boot with "otg" mode via USB DFU
>>> boot. This isn't the case without this patch.
>>>
>>> If we forget the reason that this patch is introduced and take a moment
>>> to analyze the existing code prior to this patch, we see that:
>>> 1. Both dwc3_generic_peripheral_probe() and dwc3_generic_host_probe()
>>> invoke dwc3_generic_probe().
>>> 2. dwc3_generic_probe() sets the role based on the role specified in the/
>>> device-tree and not what the caller wants the role to be.
>>> This seems to be strange to me considering that dwc3_generic_probe()
>>> simply proceeds to configure without comparing the role supported by the
>>> platform with the role requested by the caller.
>>>
>>> So even if we entirely forget the "otg" fix being attempted by this
>>> patch, the same patch is fixing something else i.e. ensuring that
>>> dwc3_generic_probe() does what the caller wants it to do by using the
>>> role that the caller expects. Isn't it incorrect that the existing code
>>> might end up with:
>>> a) Caller being dwc3_generic_host_probe() with dr_mode being set to
>>> "peripheral" within dwc3_generic_probe() based on the device-tree and
>>> proceeding to configure the controller
>>
>> Maye this is the reason why host controller is initialized for peripheral
>> only port in the dm tree output I listed above. This needs to be fixed.
> 
> Sure, I will post a patch to do the following:
> If dr_mode specified in device-tree is "host" then return -EINVAL within
> dwc3_generic_probe() if the caller is "dwc3_generic_peripheral_probe()".
> Similarly, if dr_mode specified in the device-tree is "peripheral" then
> return -EINVAL within dwc3_generic_probe() if the caller is
> "dwc3_generic_host_probe()". When dr_mode is specified as "otg" in the
> device-tree, then configure the mode based on the caller of
> dwc3_generic_probe().
> 
> Please let me know if the above implementation is acceptable.

Looks OK to me.
> 
>>> b) Caller being dwc3_generic_peripheral_probe() with dr_mode being set
>>> to "host" within dwc3_generic_probe() based on the device-tree and
>>> proceeding to configure the controller.
>>
>> This too needs to be fixed.
>>
>>> Shouldn't this inconsistency be fixed? This patch fixes that by setting
>>> dr_mode to what the caller expects. However, based on your suggestion, I
>>> agree that there should have been a check within dwc3_generic_probe() to
>>> ensure that the platform supports what the caller is requesting. I will
>>> update this patch by adding the check.
>>
>> Apart from the platform supported mode check when not "otg", if platform
>> supports "otg" we need to check and prevent role setting if hardware is
>> not in the correct state based on connected USB cable.
>> i.e. if host mode cable is used then prevent it from running as a peripheral.
>> if peripheral mode cable is used then prevent it from running as a host.
>> (based on ID status?)
> 
> Yes, I agree that using the ID status to determine the role is accurate.
> At the same time, I think that in addition to this, if the user runs a
> command corresponding to "peripheral" mode of operation with the ID
> status indicating "host", then it will be better to take this
> inconsistency into account and error out rather than simply proceeding
> to configure on the basis of the ID status. If you have any feedback,
> kindly let me know.

The approach looks OK to me.

-- 
cheers,
-roger

