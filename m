Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A85DC44500
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 21:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2229839DF;
	Wed, 21 Jan 2026 22:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="HMoUj3Kf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 093F783A1E; Wed, 21 Jan 2026 22:19:59 +0100 (CET)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865958341A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 22:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
Message-ID: <6f6ae8c9-939b-4dfe-b713-ec05b5d0e5e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1769030396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mg8JuzvqdguhyUiAaFJowqYuCm5r+9lu/Tr9sk3K2i8=;
 b=HMoUj3Kfb1NSQBK6Q15N5aPzrdnml9KBiSOYSfjRJiWxG+f5ksFDW9Sjqcv7Pv8YsYU9lJ
 S1HZkXWl8CVrefQpxR4/xHq7+BRxVTXPucqAvc8TPANgGU7ZEmxWD9dIqMBYVpXPoBBJKc
 wtJL08FhCwkAYrF6dUY/X0EpSOz1p7c=
Date: Wed, 21 Jan 2026 16:19:50 -0500
MIME-Version: 1.0
Subject: Re: [PATCH] pinctrl: zynqmp: Add SPL support
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20260106224202.754923-1-sean.anderson@linux.dev>
 <960bd4b8-3643-4e78-ae70-b29453ae083d@amd.com>
 <9377f5ad-4118-481b-adc8-49048691c9f6@linux.dev>
 <aac874ec-a52d-4197-b7cc-d75f748b2451@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aac874ec-a52d-4197-b7cc-d75f748b2451@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

On 1/19/26 03:08, Michal Simek wrote:
> 
> 
> On 1/16/26 16:59, Sean Anderson wrote:
>> On 1/16/26 03:17, Michal Simek wrote:
>>>
>>>
>>> On 1/6/26 23:42, Sean Anderson wrote:
>>>> Although the pinctrl pm requests are implemented in the PMU firmware,
>>>> PM_QUERY_DATA is actually implemented in ATF. In SPL (or when running in
>>>> EL3), ATF is not yet running, so we need to implement this API
>>>> ourselves. Do the bare minimum, allowing SPL to enumerate functions, but
>>>> don't bother with groups. Groups take up a lot of space, and can be
>>>> emulated with pins. For example, a node like
>>>>
>>>>      display-port {
>>>>          mux {
>>>>              groups = "dpaux0_1";
>>>>              function = "dpaux0";
>>>>          };
>>>>      };
>>>>
>>>> can be replaced by
>>>>
>>>>      display-port {
>>>>          mux {
>>>>              pins = "MIO34", "MIO35", "MIO36", "MIO37";
>>>>              function = "dpaux0";
>>>>          };
>>>>      };
>>>>
>>>> While this isn't backwards-compatible with existing devicetrees, it's
>>>> more than enough for SPL where we may only need to mux one or two pins.
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>> ---
>>>>
>>>>    drivers/firmware/firmware-zynqmp.c | 100 +++++++++++++++++++++++++++++
>>>>    1 file changed, 100 insertions(+)
>>>>
>>>> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
>>>> index f8a9945c1da..77911757177 100644
>>>> --- a/drivers/firmware/firmware-zynqmp.c
>>>> +++ b/drivers/firmware/firmware-zynqmp.c
>>>> @@ -427,6 +427,102 @@ U_BOOT_DRIVER(zynqmp_power) = {
>>>>    };
>>>>    #endif
>>>>    +static const char *const pinctrl_functions[] = {
>>>> +    "can0",
>>>> +    "can1",
>>>> +    "ethernet0",
>>>> +    "ethernet1",
>>>> +    "ethernet2",
>>>> +    "ethernet3",
>>>> +    "gemtsu0",
>>>> +    "gpio0",
>>>> +    "i2c0",
>>>> +    "i2c1",
>>>> +    "mdio0",
>>>> +    "mdio1",
>>>> +    "mdio2",
>>>> +    "mdio3",
>>>> +    "qspi0",
>>>> +    "qspi_fbclk",
>>>> +    "qspi_ss",
>>>> +    "spi0",
>>>> +    "spi1",
>>>> +    "spi0_ss",
>>>> +    "spi1_ss",
>>>> +    "sdio0",
>>>> +    "sdio0_pc",
>>>> +    "sdio0_cd",
>>>> +    "sdio0_wp",
>>>> +    "sdio1",
>>>> +    "sdio1_pc",
>>>> +    "sdio1_cd",
>>>> +    "sdio1_wp",
>>>> +    "nand0",
>>>> +    "nand0_ce",
>>>> +    "nand0_rb",
>>>> +    "nand0_dqs",
>>>> +    "ttc0_clk",
>>>> +    "ttc0_wav",
>>>> +    "ttc1_clk",
>>>> +    "ttc1_wav",
>>>> +    "ttc2_clk",
>>>> +    "ttc2_wav",
>>>> +    "ttc3_clk",
>>>> +    "ttc3_wav",
>>>> +    "uart0",
>>>> +    "uart1",
>>>> +    "usb0",
>>>> +    "usb1",
>>>> +    "swdt0_clk",
>>>> +    "swdt0_rst",
>>>> +    "swdt1_clk",
>>>> +    "swdt1_rst",
>>>> +    "pmu0",
>>>> +    "pcie0",
>>>> +    "csu0",
>>>> +    "dpaux0",
>>>> +    "pjtag0",
>>>> +    "trace0",
>>>> +    "trace0_clk",
>>>> +    "testscan0",
>>>> +};
>>>> +
>>>> +/*
>>>> + * PM_QUERY_DATA is implemented by ATF and not the PMU firmware, so we have to
>>>> + * emulate it in SPL. Just implement functions/pins since the groups take up a
>>>> + * lot of rodata and are mostly superfluous.
>>>> + */
>>>> +static int zynqmp_pm_query_data(enum pm_query_id qid, u32 arg1, u32 arg2,
>>>> +                u32 *ret_payload)
>>>> +{
>>>> +    switch (qid) {
>>>> +    case PM_QID_PINCTRL_GET_NUM_PINS:
>>>> +        ret_payload[1] = 78;
>>>
>>> Macro for this value please.
>>
>> Why? This value is used exactly once, and its semantics can be
>> directly inferred from the previous line.
> 
> But it is not clear what this is referring to. I expect it is amount of MIO PINs but macro name would make it clear that it is not random number.

ret_payload[1] = 78; /* NUM_PINS */

>>
>>>> +        ret_payload[0] = 0;
>>>> +        return 0;
>>>> +    case PM_QID_PINCTRL_GET_NUM_FUNCTIONS:
>>>> +        ret_payload[1] = ARRAY_SIZE(pinctrl_functions);
>>>> +        ret_payload[0] = 0;
>>>> +        return 0;
>>>> +    case PM_QID_PINCTRL_GET_NUM_FUNCTION_GROUPS:
>>>> +        ret_payload[1] = 0;
>>>> +        ret_payload[0] = 0;
>>>> +        return 0;
>>>> +    case PM_QID_PINCTRL_GET_FUNCTION_NAME:
>>>> +        memset(ret_payload, 0, 16);
>>>
>>> Where is this 16 coming from? I expect this is max number of chars of function.
>>
>> Yes. It comes from ATF. I can move MAX_FUNC_NAME_LEN to
>> include/zynqmp_firmware.h so we can use it here.
>>
>>>> +        strcpy((char *)ret_payload, pinctrl_functions[arg1]);
>>>
>>> you should check that arg1 is between 0 and array size not to read value behind.
>>
>> This is guaranteed by the loop condition in zynqmp_pinctrl_probe. I can
>> add an assert, but we have one internal user so we don't really need
>> validation beyond what would be necessary for something like
> 
> But you never know who use/call this code in future.

I don't think there will ever be any new users outside of the pinctrl driver.

>>
>>     for (i = 0; i < ARRAY_SIZE(pinctrl_functions); i++)
>>         pinctrl_functions[i];
>>
>>>> +        return 0;
>>>> +    case PM_QID_PINCTRL_GET_FUNCTION_GROUPS:
>>>> +    case PM_QID_PINCTRL_GET_PIN_GROUPS:
>>>> +        memset(ret_payload + 1, 0xff, 12);
>>>
>>> Where is this 12 coming from? Macro for it.
>>
>> NUM_GROUPS_PER_RESP * sizeof(u16)
> 
> much better.
> 
>>
>>>> +        ret_payload[0] = 0;
>>>> +        return 0;
>>>> +    default:
>>>> +        ret_payload[0] = 1;
>>>> +        return 1;
>>>> +    }
>>>> +}
>>>> +
>>>>    smc_call_handler_t __data smc_call_handler;
>>>>      static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>>>> @@ -493,6 +589,10 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>>>>              __func__, current_el(), api_id, arg0, arg1, arg2, arg3, arg4, arg5);
>>>>          if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
>>>> +        if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) &&
>>>> +            IS_ENABLED(CONFIG_PINCTRL_ZYNQMP) &&
>>>
>>> This logic have to change a little bit.
>>> There is also CONFIG_SPL_PINCTRL symbol which likely needs to be enabled. But if it is not still this code ends in SPL and just extend binary.
>>
>> PINCTRL_ZYNQMP is not enabled in any defconfig for U-Boot proper, so it
>> will not normally be enabled in SPL either.
> 
> It is in xilinx_zynqmp_kria_defconfig

Ah, interesting. That is new since the U-Boot I've been working on.

I'll add a CONFIG_PINCTRL_ZYNQMP_SPL to test for.

--Sean

