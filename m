Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114EDCD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 12:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08ED78470E;
	Wed, 20 May 2026 14:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EyGfSl0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BACC2847AF; Wed, 20 May 2026 14:25:50 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D560846E6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 14:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gL9k22WTwz9v73;
 Wed, 20 May 2026 14:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779279946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NwgR0cWoSJQJk3CT3CLhPHSy8I9xsP3OJTaEqDziwDo=;
 b=EyGfSl0DaDaSgDFS71mlkB9m6uSapGjQjB7IEGVRXIcfLvcGvnvPwhXsCqUhg6k/1RgmMP
 9R7rwE3ILxHKTNvAihNEg9TeARaTU1UU1jjI/S9jQzoL0j/j58g+KAfvPl/D9sz8lNCkZd
 q/23kbVlCDoEjchk9/oR8jTIWoRyyZ1vOqdufBQm6R5LBUzKSkPhNStdQDctZQRQL8zU+/
 +rq0W2RljotehdJMlLP2I95jzje1oxxbtU3kD+cnb3YEZBaHEfm1tcrBpMN4WITdVtkfiH
 pDZyVQYayGXWi0IcTKMqJK76NFwxFrUwRdZe+GOBx7gWuEG3nJGUiXl5auajOQ==
Message-ID: <0d3b1038-f90e-44e5-9b1e-bf9035f32784@mailbox.org>
Date: Wed, 20 May 2026 14:25:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] configs: stm32mp13: activate watchdog
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260519163145.221668-1-yann.gautier@foss.st.com>
 <20260519163145.221668-3-yann.gautier@foss.st.com>
 <f420eff8-6524-4797-93b7-0f9a1149e860@mailbox.org>
 <1aec25d4-3135-433d-8fcd-4ead7a065d40@foss.st.com>
 <9b59c08a-ea36-44b3-9c30-d1bd555f661e@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <9b59c08a-ea36-44b3-9c30-d1bd555f661e@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kbkstnfykssu531rxu19wucd7ddosohe
X-MBO-RS-ID: cd028aaf74393daf796
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

On 5/20/26 11:04 AM, Patrick DELAUNAY wrote:
> Hi,
> 
> On 5/20/26 09:05, Yann Gautier wrote:
>> On 5/19/26 18:58, Marek Vasut wrote:
>>> On 5/19/26 6:31 PM, Yann Gautier wrote:
>>>> No watchdog was enabled for STM32MP13 platform. Add the required 
>>>> flags to
>>>> support it. As done for STM32MP15 (in SCMI config) and STM32MP2x, we 
>>>> use
>>>> the Arm SMC watchdog. The required nodes were already present in Linux
>>>> imported DT files (stm32mp13.dtsi & stm32mp135f-dk.dts).
>>>>
>>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - update commit message
>>>>
>>>>   configs/stm32mp13_defconfig | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
>>>> index 620a6da2efe3..cc41585097c7 100644
>>>> --- a/configs/stm32mp13_defconfig
>>>> +++ b/configs/stm32mp13_defconfig
>>>> @@ -113,4 +113,7 @@ CONFIG_USB_GADGET_MANUFACTURER="STMicroelectronics"
>>>>   CONFIG_USB_GADGET_VENDOR_NUM=0x0483
>>>>   CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
>>>>   CONFIG_USB_GADGET_DWC2_OTG=y
>>>> +CONFIG_WDT=y
>>>> +CONFIG_WDT_STM32MP=y
>>> Why is CONFIG_WDT_STM32MP enabled here , is this the ARM SMC watchdog 
>>> driver ?
>> This is aligned with stm32mp15 config, and no, this one is the STM32 
>> IWDG driver.
>> I'll check that with Patrick (who originally wrote the patch), as it 
>> seems that this flag could be removed.
>>
> 
> I agree with Marek.
> 
> Today CONFIG_WDT_STM32MP is not really needed as only arm_wdt is 
> activated in STM32MP13 device tree for ST boards

Make sure you double-check the stm32mp13xx dhcor too.

If the WDT is supposed to be activated here, it has to be documented in 
commit message too .
