Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91438C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273A787F1F;
	Tue, 20 Feb 2024 12:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uxjIRppQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32DB987F78; Tue, 20 Feb 2024 12:39:13 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A76387F1F
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 12:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-512bb2ed1f7so2177034e87.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 03:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708429142; x=1709033942; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bqf2mroSkf9VWPFsUFdiCQ/iYP0FzYaUvFHHCfF0lRM=;
 b=uxjIRppQ7Nx0sIt1+LdJBDbz5GV/3RSdG62wpRR8UUft5ZqQ1Yejta5giI51Nv8o03
 fawQXjsp311ZO5cYZLtnMep0gWJZCJeCYg/xj+ZvZhEJUQHugA3f9aMN3fvv0GIWTd/M
 sv1gnRauKa7HhUrj3E8UhbbV+N91skRBGzSVdaHoOiq4uv5Daqcg2NAW/S/bIwWsQj0s
 YWOmpCRFzcm3S9YwSPbKGsK9j5PA173x31vmbqjeEnUBXG5aZjMRuql08F/+7ap+pJ23
 OCUNyOaFKswjqZjgKfqFj/x/AErv2WnwrkLuxiDdg+srXK/apZu6EvdmyR5+AlnBHaZC
 F+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708429142; x=1709033942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bqf2mroSkf9VWPFsUFdiCQ/iYP0FzYaUvFHHCfF0lRM=;
 b=nTMxwqushmowQuCLjtXrL6WYwgN+2ye0d9WYxu+HYOwy0djuy5koIi66WX2a/sPdlI
 X23YzeiuwP5FKtWjLAEaChq6tSbG+Q2Cl9iZoOjsvSIVLxlvrVy6YOGXtUsbUXG9F4+e
 ueWVgGukhkx7cc9VvF82PjKl4h72Kg6il+XT4ke5G4esc0FMOKmzb1/jc/febGI7Ws2c
 UroN236v7qn7DFtVmLh5XT6nGQ21XhW0JjAYjDLY2Rc2HRKJEV9PcaAmsruQoXtoG7h6
 UfP7qZg1NfvMyE45Ck2lSq857yNmEPNmhlrNwzwoP+BMP3ehGRVaA74cL433bCAmjPcV
 wjKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJY/3ZX62fLPNcEOlyucRSx6XtSjQEmAD3blffK9fqTbjYvD6TgGQS0aJU/ElQE+aq0oQ1peegsYikf3Rzn1qDajpnLQ==
X-Gm-Message-State: AOJu0YwQlB1iqoYmPSDPzGVWGDw4Ih9ZpTJs0fcpNvrnNXedhXaZC4Zw
 yfjF49vxjjmPvV4whkoAQQGnFjZp8wOHr6kYetYRS8ZN58GUvBlVQC0k4aWiNsA=
X-Google-Smtp-Source: AGHT+IG2SGYNStsJTvmhWr6WQQdk59S5ZtTkFgYpJiBQC9xPjtR8XB/hkppbEGfVQ1/E3+gT9Kxoyg==
X-Received: by 2002:a05:6512:1321:b0:512:bf09:9313 with SMTP id
 x33-20020a056512132100b00512bf099313mr2009310lfu.50.1708429141881; 
 Tue, 20 Feb 2024 03:39:01 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 23-20020a05600c231700b00410b0ce91b1sm13973751wmo.25.2024.02.20.03.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 03:39:01 -0800 (PST)
Message-ID: <f9c81d80-0733-4b84-97ff-32143bfe585e@linaro.org>
Date: Tue, 20 Feb 2024 11:39:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/39] serial: msm: add debug UART
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-7-ed06355c634a@linaro.org>
 <CAFA6WYOUVRNf1hMMty6uTk_cNckrHQ6QNBkPsPiGuw=P+0OV4A@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYOUVRNf1hMMty6uTk_cNckrHQ6QNBkPsPiGuw=P+0OV4A@mail.gmail.com>
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



On 20/02/2024 06:08, Sumit Garg wrote:
> On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Introduce support for early debugging. This relies on the previous stage
>> bootloader to initialise the UART clocks, when running with U-Boot as
>> the primary bootloader this feature doesn't work. It will require a way
>> to configure the clocks before the driver model is available.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  drivers/serial/Kconfig      |  8 ++++++++
>>  drivers/serial/serial_msm.c | 37 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index 26460c4e0cab..fbd351a47859 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -319,6 +319,14 @@ config DEBUG_UART_S5P
>>           will need to provide parameters to make this work. The driver will
>>           be available until the real driver-model serial is running.
>>
>> +config DEBUG_UART_MSM
>> +       bool "Qualcomm QUP UART debug"
>> +       depends on ARCH_SNAPDRAGON
> 
> Since this debug UART only works for chainloaded configuration, can we
> somehow add explicit dependency here? Something like !REMAKE_ELF?

With a small patch (which didn't make it into v4 apparently) the
apq8016_clk_init_uart() function from clock-apq8016 can be adjusted to
just take a base address rather than "struct msm_clk_priv". It can then
be called from debug_uart_init() and allows for debug UART to be used
when U-Boot is running as the first stage.

This is definitely not ideal (although fwiw if the GPLLs were configured
right then this same function could maybe work on QCS404 as well - the
RCGs are at the same physical addresses), but I don't think gating it
behind REMAKE_ELF or something is a great solution here.
> 
> -Sumit
> 
>> +       help
>> +         Select this to enable a debug UART using the serial_msm driver. You
>> +         will need to provide parameters to make this work. The driver will
>> +         be available until the real driver-model serial is running.
>> +
>>  config DEBUG_UART_MSM_GENI
>>         bool "Qualcomm snapdragon"
>>         depends on ARCH_SNAPDRAGON
>> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
>> index f4d96313b931..44b93bd7ff21 100644
>> --- a/drivers/serial/serial_msm.c
>> +++ b/drivers/serial/serial_msm.c
>> @@ -252,3 +252,40 @@ U_BOOT_DRIVER(serial_msm) = {
>>         .probe = msm_serial_probe,
>>         .ops    = &msm_serial_ops,
>>  };
>> +
>> +#ifdef CONFIG_DEBUG_UART_MSM
>> +
>> +static struct msm_serial_data init_serial_data = {
>> +       .base = CONFIG_VAL(DEBUG_UART_BASE),
>> +       .clk_rate = 7372800,
>> +};
>> +
>> +#include <debug_uart.h>
>> +
>> +/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
>> +//int apq8016_clk_init_uart(phys_addr_t gcc_base);
>> +
>> +static inline void _debug_uart_init(void)
>> +{
>> +       /* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
>> +       //apq8016_clk_init_uart(0x1800000);
>> +       uart_dm_init(&init_serial_data);
>> +}
>> +
>> +static inline void _debug_uart_putc(int ch)
>> +{
>> +       struct msm_serial_data *priv = &init_serial_data;
>> +
>> +       while (!(readl(priv->base + UARTDM_SR) & UARTDM_SR_TX_EMPTY) &&
>> +              !(readl(priv->base + UARTDM_ISR) & UARTDM_ISR_TX_READY))
>> +               ;
>> +
>> +       writel(UARTDM_CR_CMD_RESET_TX_READY, priv->base + UARTDM_CR);
>> +
>> +       writel(1, priv->base + UARTDM_NCF_TX);
>> +       writel(ch, priv->base + UARTDM_TF);
>> +}
>> +
>> +DEBUG_UART_FUNCS
>> +
>> +#endif
>>
>> --
>> 2.43.1
>>

-- 
// Caleb (they/them)
