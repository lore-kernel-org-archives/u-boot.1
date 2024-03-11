Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC98CC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 14:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E54D87DD3;
	Mon, 11 Mar 2024 15:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wWZfyvtu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0BEF87D3C; Mon, 11 Mar 2024 15:50:55 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC0F87DD3
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 15:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56845954ffeso2289844a12.2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 07:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710168652; x=1710773452; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xt3LrVkUkdPi357E5RTp7x0NtYxvUel5j89Nn13+Zsw=;
 b=wWZfyvtu7vW8QnzZzyKTb4f3XcemH3QraxQIkvjvvOUr464Qqc1HrLR0Ma+R14C0qF
 TvaRSYNCsV8+8r7YoHbM/NKP2cI3X9pS+vQdt2E+24x9shFMTJSS9diozWKbg5EkgQLf
 fYudN4T04I0tjQTYXFScUVzKjjmmYytWfiZY4b+c+7q5jxW5MWFraoiKNK9ovGknh6nM
 A1d2PRKBPnR0yqzH6b+RV8poWRjCJQzIIgf11/xScwASxsbsie4yF+bmhqHQWErJSNWQ
 bkUk0zbSAibLtxxXBU90ydg0AHnY52pu/4+Dc4bMkSoQ6lQFxqe10m3g0M4BA2lL/f64
 7HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710168652; x=1710773452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xt3LrVkUkdPi357E5RTp7x0NtYxvUel5j89Nn13+Zsw=;
 b=jUfCHBzdfPINctVo9Xi/8iWFds2u2Vcv513orgSPE4j61DCEyLWZcHAlR0KSBikro3
 UZe7M6rstKGEShYr5AMOO+b7af5ETt/UELy+nNzlLBn4FbSRNTZbYgjuK0EUB84xsE65
 OrQ5HjMuN/GCEq76iuwOLO2vMuwdTuj/thr0xLJMH6+MePCRXeCfkUE3UXGYaJT26BrP
 ASS6xw01x0GDnSmKCGzCPBsxriOd/OwSAE/X2Dxfufaddx5Mml6UIj4aqqJGjjx+lFkz
 thtaVz0Kc9OoHpicw6dbSijVKw4UqSR8IX52FxRLUHINErPHDhz+bbuMK2gwUhe8t1lX
 bwaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi1QUwNW0vloVQjWRXd0swRRCdfhfxh9x4mqoTrFRdnQ8HNWIfbLG2ebTO8pwriN/DQmXKYWJJE9kxCZtM3LHpNRg9iw==
X-Gm-Message-State: AOJu0YwsyD2QwrzddIZK5qKZZJghZQVrCgQ5P+awtqtqgxMXm1W6VoIh
 Xqjfb/Lvk7qdWrZPfN4qteyG1jr0lNvho1xjTGtaCLYNjD/9qe+Se6S3MtdT6qs=
X-Google-Smtp-Source: AGHT+IFbEPDYHWJ3E1piTT0pPrIs0WslqvZKGUv0JimMiV2gHrNIT0ov5hZK5eL9Ov9guOSUG/XQ2Q==
X-Received: by 2002:a17:907:86a7:b0:a46:2226:295a with SMTP id
 qa39-20020a17090786a700b00a462226295amr3319459ejc.69.1710168652321; 
 Mon, 11 Mar 2024 07:50:52 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a170906280900b00a45cd2f2939sm2931840ejc.25.2024.03.11.07.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 07:50:51 -0700 (PDT)
Message-ID: <66ebb408-ec94-4fb9-9479-a4fc6465ceab@linaro.org>
Date: Mon, 11 Mar 2024 14:50:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] apq8016: Add support for UART1 clocks and pinmux
Content-Language: en-US
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-3-sumit.garg@linaro.org>
 <0867ce89-b6db-482c-a0f6-e2d2535dad30@linaro.org>
 <Ze8H8CyriUP2qjsD@gerhold.net>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <Ze8H8CyriUP2qjsD@gerhold.net>
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



On 11/03/2024 13:32, Stephan Gerhold wrote:
> On Mon, Mar 11, 2024 at 12:27:11PM +0000, Caleb Connolly wrote:
>> On 11/03/2024 11:10, Sumit Garg wrote:
>>> SE HMIBSC board uses UART1 as the main debug console, so add
>>> corresponding clocks and pinmux support. Along with that update
>>> instructions to enable clocks for debug UART support.
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>> ---
>>>  drivers/clk/qcom/clock-apq8016.c       | 50 +++++++++++++++++++++-----
>>>  drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
>>>  drivers/serial/serial_msm.c            |  6 ++--
>>>  3 files changed, 47 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
>>> index e6647f7c41d..a620a10a520 100644
>>> --- a/drivers/clk/qcom/clock-apq8016.c
>>> +++ b/drivers/clk/qcom/clock-apq8016.c
>>> @@ -43,6 +43,14 @@
>>>  #define BLSP1_UART2_APPS_N		(0x3040)
>>>  #define BLSP1_UART2_APPS_D		(0x3044)
>>>  
>>> +#define BLSP1_UART1_BCR			(0x2038)
>>> +#define BLSP1_UART1_APPS_CBCR		(0x203C)
>>> +#define BLSP1_UART1_APPS_CMD_RCGR	(0x2044)
>>> +#define BLSP1_UART1_APPS_CFG_RCGR	(0x2048)
>>> +#define BLSP1_UART1_APPS_M		(0x204C)
>>> +#define BLSP1_UART1_APPS_N		(0x2050)
>>> +#define BLSP1_UART1_APPS_D		(0x2054)
>>> +
>>>  /* GPLL0 clock control registers */
>>>  #define GPLL0_STATUS_ACTIVE BIT(17)
>>>  
>>> [...]
>>> @@ -94,6 +102,33 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
>>>  	return rate;
>>>  }
>>>  
>>> +static const struct bcr_regs uart1_regs = {
>>> +	.cfg_rcgr = BLSP1_UART1_APPS_CFG_RCGR,
>>> +	.cmd_rcgr = BLSP1_UART1_APPS_CMD_RCGR,
>>> +	.M = BLSP1_UART1_APPS_M,
>>> +	.N = BLSP1_UART1_APPS_N,
>>> +	.D = BLSP1_UART1_APPS_D,
>>> +};
>>> +
>>> +/* UART: 115200 */
>>> +static int apq8016_clk_init_uart1(phys_addr_t base)
>>
>> I know we're still dealing with some tech debt here, but I'm not a big
>> fan of this approach. I notice that the RCG and CBCR registers are all
>> offset by exactly 0xff0 between UART1 and UART2, what about adding a
>> second "index" parameter to apq8016_clk_init_uart() and then offsetting
>> the addresses by (0xff0 * index)?
>>
> 
> This would work for MSM8916 where you have just two UARTs, but it might
> be misleading since the UART blocks are actually separated in 4 KiB
> (0x1000) blocks and not offset by 0xff0. UART2 is a special case that
> has different offsets within the 4 KiB block, for some weird reason.
> 
> If you want to calculate the register offsets properly you would need
> special handling for UART2, e.g. I have the following (admittedly rather
> ugly) define in the TF-A port for MSM8916 and similar [1]:
> 
> #define GCC_BLSP1_UART_APPS_CBCR(n)	(GCC_BASE + \
> 	(((n) == 2) ? (0x0302c) : (0x0203c + (((n) - 1) * 0x1000))))
> 
> where n is the UART number (here 1 or 2). As a different example,
> MDM9607 has 5 UARTs (1 to 5) and there only UART2 is special-cased,
> while all others follow the standard offset with 0x1000 offset.

fwiw I would also be fine with just treating it like a binary switch and
only allowing UART1 or UART2 to be selected if that's simpler.
> 
> Thanks,
> Stephan
> 
> [1]: https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/plat/qti/msm8916/msm8916_setup.c?h=v2.10#n40

-- 
// Caleb (they/them)
