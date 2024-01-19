Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB72C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ADF587C7E;
	Fri, 19 Jan 2024 14:50:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tj4ebpMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E3F587CA1; Fri, 19 Jan 2024 14:50:47 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C09B87B7F
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e884de7b9so10047765e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705672243; x=1706277043; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UOPM+0tTriCD4tjE/yFXIK3ZJL0BFKcpbrm1xOJkES4=;
 b=tj4ebpMeGVytOI6kuX+i+4iC+Df7jF/PnerBBAxGwOUAZbBwG+y+s4BT3XUvTG6kow
 LYj41m4cyGgFUdbTujkxO4FSHnmA2CdhdfQmdxDrWMjljZgtjd8beCsYJfn3flvru++E
 tabmiEcn3M4/z0RiEJqW8JmZt6gBoOCDYyp2+zLJmbxEcRF5cQqgVZRjUgJVhgLJjyr5
 3x6jGhll93asXghbha+6Eo7lnaQgR728ydNG/uViffrjSaLjbNZxzo59f7TcQSe36SLz
 vnbJgcXPTa8WoHDj0tls3FqzJMO3KuUbxSM1kpMS8wQYjKVCg0uvu6sM0r7mISWglRdJ
 NmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705672243; x=1706277043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UOPM+0tTriCD4tjE/yFXIK3ZJL0BFKcpbrm1xOJkES4=;
 b=JmQq/EMk3VZPmc9R8WrDm6C/E/ZWFghecoDWKf21xT3D1XBP9rIlF4Qx8kohAALJSN
 Xkz8YtT6/r5nnTD/P1fvPR7udtVfbJyx5rFlMYbjpZWkXloGxXGVQ8AriQ1KNqYeQtp9
 a2ksZFKIk5iv1UBXHM9CdUfF2cJOBj/Bo/XTZBqSlCzfG9AwNZiF4Etsr6xfRuMLNeS6
 +TmeYXHYCLzrxkJlK/0R+c6aU4HTMjGyU3Z9KdoMxTJHlTklBO3G5TNxnoiSTwFK3qV8
 M5sRJw61n8oepVsxs2x+blNrr9yD8ueGOJnoTE4LV9QDkebM5F+XCPn68SjFsop0GGUS
 IKSw==
X-Gm-Message-State: AOJu0YyU4iP4j8Px6RXGExCI97Qv2qjeOuAplUBUpgZAyxj0UJ/DKM9I
 6YQB7t78S2chcbfzD9J4J/1WFiGnnGRx7Y7gismi0K0QFMSQ3sNuzmjdboDF8U0=
X-Google-Smtp-Source: AGHT+IGjHHxk3k5lpvW7rDXUiPgeZaQNsX1TVsuQVTnR2akGyXF2TCVNNo1GULfIqltsvPVtocF7NA==
X-Received: by 2002:a05:600c:ac9:b0:40e:5200:c52d with SMTP id
 c9-20020a05600c0ac900b0040e5200c52dmr1458228wmr.155.1705672243436; 
 Fri, 19 Jan 2024 05:50:43 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 ay41-20020a05600c1e2900b0040e9e03160bsm2076097wmb.16.2024.01.19.05.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 05:50:43 -0800 (PST)
Message-ID: <a5bca7f6-0043-41ab-9c16-d370e506188b@linaro.org>
Date: Fri, 19 Jan 2024 13:50:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/32] serial: msm: add debug UART
Content-Language: en-US
To: Ramon Fried <rfried.dev@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Dzmitry Sankouski
 <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-6-b6dd9704219e@linaro.org>
 <CAGi-RULTVVdmgw9SCz1PXPeCoHVTSxd4agth9FRCGJrvJhqy_Q@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAGi-RULTVVdmgw9SCz1PXPeCoHVTSxd4agth9FRCGJrvJhqy_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 18/01/2024 21:54, Ramon Fried wrote:
> On Tue, Dec 19, 2023 at 6:04 PM Caleb Connolly
> <caleb.connolly@linaro.org> wrote:
>>
>> Introduce support for early debugging.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  drivers/serial/Kconfig      |  8 ++++++++
>>  drivers/serial/serial_msm.c | 32 ++++++++++++++++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index 81fdac047824..20713812c839 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -304,6 +304,14 @@ config DEBUG_UART_S5P
>>           will need to provide parameters to make this work. The driver will
>>           be available until the real driver-model serial is running.
>>
>> +config DEBUG_UART_MSM
>> +       bool "Qualcomm QUP UART debug"
> What is QUP ?

It's "Qualcomm Universal Peripheral".
>> +       depends on ARCH_SNAPDRAGON
>> +       help
>> +         Select this to enable a debug UART using the serial_msm driver. You
>> +         will need to provide parameters to make this work. The driver will
>> +         be available until the real driver-model serial is running.
>> +
>>  config DEBUG_UART_MSM_GENI
>>         bool "Qualcomm snapdragon"
>>         depends on ARCH_SNAPDRAGON
>> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
>> index a22623c316ed..19a5a3a788f7 100644
>> --- a/drivers/serial/serial_msm.c
>> +++ b/drivers/serial/serial_msm.c
>> @@ -253,3 +253,35 @@ U_BOOT_DRIVER(serial_msm) = {
>>         .probe = msm_serial_probe,
>>         .ops    = &msm_serial_ops,
>>  };
>> +
>> +#ifdef CONFIG_DEBUG_UART_MSM
>> +
>> +static struct msm_serial_data init_serial_data = {
>> +       .base = CONFIG_VAL(DEBUG_UART_BASE),
>> +       .clk_bit_rate = UART_DM_CLK_RX_TX_BIT_RATE,
>> +};
>> +
>> +#include <debug_uart.h>
>> +
>> +static inline void _debug_uart_init(void)
>> +{
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
>> 2.42.1
>>

-- 
// Caleb (they/them)
