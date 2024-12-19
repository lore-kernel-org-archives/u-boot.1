Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B06FE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 09:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D18380283;
	Thu, 19 Dec 2024 10:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fxGdJ1Me";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E6DC80291; Thu, 19 Dec 2024 10:41:20 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092218021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7B8DBA41C8D;
 Thu, 19 Dec 2024 09:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E7DC4CECE;
 Thu, 19 Dec 2024 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734601276;
 bh=gf3j6gDkQg5XQiptCF6enLOQ57uWHOhhOguPgh/Xzyk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fxGdJ1MegAmAmCAY6ZeufT+vEVyzD9L3gdLJuqzBrJ1VDMa8vAO6kJzcrjEseu1iQ
 wL61zHrwvO6smR5rCurDIJ0r3u9yaasdH0uNlM7CVfmKmd+DvVMoJEvUNYsbp9zNTS
 TCXAyInorQTLqjJrIgBggKXIy4DbBXJAxyqZ/ZWW4G00KKW9fZ6snUdXqi5SgdJGgh
 gmVBrLFih5aAwQzXAyraS2So7nsmdUQhn/v3fgFEK7QLeh5LaF0UJtR/T/Zb9I8RxV
 WgTnjt9aX/DkzuambhxiT1yM7R91MjrHJzzZBIuByoQ2kagC097wh7Z3nA1aq7usx3
 RXAFqdpBLTdeA==
Message-ID: <a0dd6878-5f26-47a0-8025-ba9d9d320a31@kernel.org>
Date: Thu, 19 Dec 2024 11:41:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm: dts: k3-am62p5-sk-u-boot: enable USB0 for USB
 DFU boot
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Cc: vigneshr@ti.com, bb@ti.com, lukma@denx.de, n-francis@ti.com,
 mkorpershoek@baylibre.com, afd@ti.com, glaroque@baylibre.com,
 sjoerd@collabora.com, martyn.welch@collabora.com,
 rasmus.villemoes@prevas.dk, caleb.connolly@linaro.org, j-humphreys@ti.com,
 nm@ti.com, u-boot@lists.denx.de, srk@ti.com
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-5-s-vadapalli@ti.com>
 <e4b23017-375e-4430-aef2-001c1b6402ca@kernel.org>
 <noztdv7z4cwzjwc5sgqvzli36ppm2tlgrpqjgxbkbtojs34jnp@3lhnfx6ol4in>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <noztdv7z4cwzjwc5sgqvzli36ppm2tlgrpqjgxbkbtojs34jnp@3lhnfx6ol4in>
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



On 19/12/2024 07:50, Siddharth Vadapalli wrote:
> On Wed, Dec 18, 2024 at 04:05:47PM +0200, Roger Quadros wrote:
> 
> Hello Roger,
> 
>> Hi Siddharth,
>>
>> On 18/12/2024 14:45, Siddharth Vadapalli wrote:
>>> Enable USB0 instance of the USB controller for USB DFU boot functionality
>>> which requires the "bootph-all" property in order to have USB enabled at
>>> all stages of the USB DFU boot.
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>> ---
>>> v1:
>>> https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-5-s-vadapalli@ti.com/
>>> Changes since v1:
>>> - Collected Reviewed-by tag.
>>>
>>>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
>>> index cf087c6e343..c2091fc1a51 100644
>>> --- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
>>> +++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
>>> @@ -16,3 +16,13 @@
>>>  &dmsc {
>>>  	bootph-pre-ram;
>>>  };
>>> +
>>> +/* Required for USB DFU boot */
>>> +&usbss0 {
>>> +	status = "okay";
>>> +};
>>
>> This should come via upstream DT sync?
>>
>>> +
>>> +/* Required for USB DFU boot */
>>> +&usb0 {
>>> +	bootph-all;
>>> +};
>>
>> This as well? But I don't see it upstream. Do you have a patch for upstream DT?
> 
> I haven't posted the patch for Linux device-tree yet. I will post it and
> it can be synced with U-Boot later. In order to avoid blocking USB DFU
> support on the Linux device-tree sync, I have posted this patch for this
> series to be complete in terms of functionality. If Linux device-tree
> based sync is the only way to enable this, then the following patch in
> this series for documentation should also be dropped since the feature
> will not be functional without the changes made by this patch.
> 
> Please let me know if this patch can be merged on the condition that I
> post the patch for making the same set of changes in the Linux
> device-tree as well.

Tom, what do you suggest?

-- 
cheers,
-roger

