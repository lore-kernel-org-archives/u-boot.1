Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CB2C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 14:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75F1688270;
	Mon, 15 Apr 2024 16:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZtBXJZuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ACB1881EA; Mon, 15 Apr 2024 16:18:13 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3008F88177
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 16:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3476dcd9c46so1685229f8f.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713190688; x=1713795488; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QCWJ4+BOUBVsqkQq7wqiWcON2X3lyGNbdxGVeLq9/hs=;
 b=ZtBXJZuCCVPzuStBZ0CH1RMoZVNti3D7xU2Qq7bajjDFO57PX7R3kH/tClZBrgJnz5
 9t0pUGSX17DY8Vrr730mFOI6c7XbQxXM7wLtBIX7NYPgZ6mZ2aCDkS3YrATTzsyeuyEy
 Wt4S1QOqzyH3t584g3Uof6yE2SNIumdUz+weCtzJu7nRGB1F5TMHBW4GrruauDiWspgK
 +0R/sY3rGAzXK/aY9OA2aAP56AMqkkELcffNKqLUA74UD0RWUTKz59cyzt9+ovalUhow
 BJdY4sdeJ7sV/YTrjUsn6Vebk6LudmIgsP7zL+ndmLYgDxDKIPhBMv8Krq8fMEcseUeP
 SBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713190688; x=1713795488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QCWJ4+BOUBVsqkQq7wqiWcON2X3lyGNbdxGVeLq9/hs=;
 b=UDyRiCZ5tjrkH62h89YnOGGSJKrhmCHJumPQikbHxuMWBlAKgZf+pizC5H5ayjfJGJ
 0GEGH7PCAiw0I5hFREA/TaVtH1oCpzMO07C12PTXJSV1GQlETdgHO9/v/9g1/DAoc3CI
 Q49tuzHfolzr6Jm7nn+MgKSR3QlNoI9vJll0wVwCNvmSfjWUD2Hld7R9s/2W7Axtixrv
 gQV903zPjjdKYEO4nzFA9BRUPg6VUPs+zm23OdeLyM0uRA9pbX+NTEAmpkbasuslykvv
 7fqSpf4iZuKWZN28o9r/FTEg0i0CUIt29Ti2GeJlj3pAmDFZqkt0hFPd8l8i82FG5YCs
 0CyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZkbASBZZEX20o/3E/gG2jeT6qRp/tkyRiN+K1mPWkbWbKpX5fz4RdQEw5Vl0DpKR7JqnWPleOnDJHi8sJiBZL6RSTJw==
X-Gm-Message-State: AOJu0Yz9RMR2Cviso4jUVHpxKo7VzVyx2rQfnsMNm+AypDZp57jQQu0B
 xf6kuzkOOn46S+dovctcy3XWvVf22UhxdT01LKd/xxW0WNtzRcLbaNRa+xLd/9Q=
X-Google-Smtp-Source: AGHT+IG8iwIR9SAJeE2tM4evahqXaHESyi7z2zwjYGuUZSIU2hYjl5suHfT+DDEZmXdgnAQ/XPnTFQ==
X-Received: by 2002:adf:e610:0:b0:33e:c389:69ff with SMTP id
 p16-20020adfe610000000b0033ec38969ffmr5606539wrm.68.1713190688518; 
 Mon, 15 Apr 2024 07:18:08 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 cs5-20020a056000088500b00343a0e2375esm12283183wrb.27.2024.04.15.07.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 07:18:08 -0700 (PDT)
Message-ID: <0ef8c9ad-2344-4de9-9dd8-ff8f6b17e192@linaro.org>
Date: Mon, 15 Apr 2024 15:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] serial: msm: calculate bit clock divider
Content-Language: en-US
To: Robert Marko <robert.marko@sartura.hr>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org>
 <20240415-b4-msm-serial-bitrate-v1-3-5a89f84fd9e7@linaro.org>
 <CA+HBbNH_mGrFPDt+74r+TOveWmE_wQx4CYy-BGtJa76T6TUJ=A@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CA+HBbNH_mGrFPDt+74r+TOveWmE_wQx4CYy-BGtJa76T6TUJ=A@mail.gmail.com>
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



On 15/04/2024 14:05, Robert Marko wrote:
> On Mon, Apr 15, 2024 at 2:44 PM Caleb Connolly
> <caleb.connolly@linaro.org> wrote:
>>
>> The driver currently requires the bit clock divider be hardcoded in
>> devicetree (or use the hardcoded default from apq8016).
>>
>> The bit clock divider is used to derive the baud rate from the core
>> clock:
>>
>>   baudrate = clk_rate / csr_div
>>
>> clk_rate is the actual programmed core clock rate which is returned by
>> clk_set_rate(), and this UART driver only supports a baudrate of 115200.
>> We can therefore determine the appropriate value for UARTDM_CSR by
>> iterating over the possible values and finding the one where the
>> equation above holds true for a baudrate of 115200.
>>
>> Implement this logic and drop the non-standard DT bindings for this
>> driver.
>>
>> Tested on dragonboard410c.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Works on Alfa AP120C (IPQ4018) with full DM UART, but debug UART
> prints junk since .clk_rate = 7372800 is not correct for IPQ40xx.
> I would suggest using .clk_rate = CONFIG_VAL(DEBUG_UART_CLOCK) instead
> to populate the value per board, this also avoids per ARCH ifdefs.

Ok awesome, thanks for trying this out. I'll send a v2 with your suggestion.

Can I add your Tested-by?
> 
> Regards,
> Robert
>> ---
>> Cc: Robert Marko <robert.marko@sartura.hr>
>> ---
>>  doc/device-tree-bindings/serial/msm-serial.txt | 10 ---
>>  drivers/serial/serial_msm.c                    | 87 +++++++++++++++++++++-----
>>  2 files changed, 70 insertions(+), 27 deletions(-)
>>
>> diff --git a/doc/device-tree-bindings/serial/msm-serial.txt b/doc/device-tree-bindings/serial/msm-serial.txt
>> deleted file mode 100644
>> index dca995798a90..000000000000
>> --- a/doc/device-tree-bindings/serial/msm-serial.txt
>> +++ /dev/null
>> @@ -1,10 +0,0 @@
>> -Qualcomm UART (Data Mover mode)
>> -
>> -Required properties:
>> -- compatible: must be "qcom,msm-uartdm-v1.4"
>> -- reg: start address and size of the registers
>> -- clock: interface clock (must accept baudrate as a frequency)
>> -
>> -Optional properties:
>> -- bit-rate: Data Mover bit rate register value
>> -                       (If not defined then 0xCC is used as default)
>> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
>> index 8044d38518db..e461929b4338 100644
>> --- a/drivers/serial/serial_msm.c
>> +++ b/drivers/serial/serial_msm.c
>> @@ -31,8 +31,18 @@
>>  #define UARTDM_RXFS_BUF_SHIFT   0x7  /* Number of bytes in the packing buffer */
>>  #define UARTDM_RXFS_BUF_MASK    0x7
>>  #define UARTDM_MR1                              0x00
>>  #define UARTDM_MR2                              0x04
>> +/*
>> + * This is documented on page 1817 of the apq8016e technical reference manual.
>> + * section 6.2.5.3.26
>> + *
>> + * The upper nybble contains the bit clock divider for the RX pin, the lower
>> + * nybble defines the TX pin. In almost all cases these should be the same value.
>> + *
>> + * The baud rate is the core clock frequency divided by the fixed divider value
>> + * programmed into this register (defined in calc_csr_bitrate()).
>> + */
>>  #define UARTDM_CSR                              0xA0
>>
>>  #define UARTDM_SR                0xA4 /* Status register */
>>  #define UARTDM_SR_RX_READY       (1 << 0) /* Word is the receiver FIFO */
>> @@ -52,9 +62,8 @@
>>
>>  #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
>>  #define UARTDM_RF               0x140 /* UART Receive FIFO register */
>>
>> -#define UART_DM_CLK_RX_TX_BIT_RATE 0xCC
>>  #define MSM_BOOT_UART_DM_8_N_1_MODE 0x34
>>  #define MSM_BOOT_UART_DM_CMD_RESET_RX 0x10
>>  #define MSM_BOOT_UART_DM_CMD_RESET_TX 0x20
>>
>> @@ -63,9 +72,9 @@ DECLARE_GLOBAL_DATA_PTR;
>>  struct msm_serial_data {
>>         phys_addr_t base;
>>         unsigned chars_cnt; /* number of buffered chars */
>>         uint32_t chars_buf; /* buffered chars */
>> -       uint32_t clk_bit_rate; /* data mover mode bit rate register value */
>> +       uint32_t clk_rate; /* core clock rate */
>>  };
>>
>>  static int msm_serial_fetch(struct udevice *dev)
>>  {
>> @@ -155,34 +164,63 @@ static const struct dm_serial_ops msm_serial_ops = {
>>         .pending = msm_serial_pending,
>>         .getc = msm_serial_getc,
>>  };
>>
>> -static int msm_uart_clk_init(struct udevice *dev)
>> +static long msm_uart_clk_init(struct udevice *dev)
>>  {
>> -       uint clk_rate = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
>> -                                       "clock-frequency", 115200);
>> +       struct msm_serial_data *priv = dev_get_priv(dev);
>>         struct clk clk;
>>         int ret;
>> +       long rate;
>>
>>         ret = clk_get_by_name(dev, "core", &clk);
>>         if (ret < 0) {
>>                 pr_warn("%s: Failed to get clock: %d\n", __func__, ret);
>> -               return ret;
>> +               return 0;
>>         }
>>
>> -       ret = clk_set_rate(&clk, clk_rate);
>> -       if (ret < 0)
>> -               return ret;
>> +       rate = clk_set_rate(&clk, priv->clk_rate);
>>
>> -       return 0;
>> +       return rate;
>> +}
>> +
>> +static int calc_csr_bitrate(struct msm_serial_data *priv)
>> +{
>> +       /* This table is from the TRE. See the definition of UARTDM_CSR */
>> +       unsigned int csr_div_table[] = {24576, 12288, 6144, 3072, 1536, 768, 512, 384,
>> +                                       256,   192,   128,  96,   64,   48,  32,  16};
>> +       int i = ARRAY_SIZE(csr_div_table) - 1;
>> +       /* Currently we only support one baudrate */
>> +       int baud = 115200;
>> +
>> +       for (; i >= 0; i--) {
>> +               int x = priv->clk_rate / csr_div_table[i];
>> +
>> +               if (x == baud)
>> +                       /* Duplicate the configuration for RX
>> +                        * as the lower nybble only configures TX
>> +                        */
>> +                       return i + (i << 4);
>> +       }
>> +
>> +       return -EINVAL;
>>  }
>>
>>  static void uart_dm_init(struct msm_serial_data *priv)
>>  {
>>         /* Delay initialization for a bit to let pins stabilize if necessary */
>>         mdelay(5);
>> +       int bitrate = calc_csr_bitrate(priv);
>> +       if (bitrate < 0) {
>> +               log_warning("Couldn't calculate bit clock divider! Using default\n");
>> +               /* This happens to be the value used on MSM8916 for the hardcoded clockrate
>> +                * in clock-apq8016. It's at least a better guess than a value we *know*
>> +                * is wrong...
>> +                */
>> +               bitrate = 0xCC;
>> +       }
>>
>> -       writel(priv->clk_bit_rate, priv->base + UARTDM_CSR);
>> +       writel(bitrate, priv->base + UARTDM_CSR);
>>         writel(0x0, priv->base + UARTDM_MR1);
>>         writel(MSM_BOOT_UART_DM_8_N_1_MODE, priv->base + UARTDM_MR2);
>>         writel(MSM_BOOT_UART_DM_CMD_RESET_RX, priv->base + UARTDM_CR);
>>         writel(MSM_BOOT_UART_DM_CMD_RESET_TX, priv->base + UARTDM_CR);
>> @@ -191,18 +229,27 @@ static void uart_dm_init(struct msm_serial_data *priv)
>>         writel(0x0, priv->base + UARTDM_DMEN);
>>  }
>>  static int msm_serial_probe(struct udevice *dev)
>>  {
>> -       int ret;
>>         struct msm_serial_data *priv = dev_get_priv(dev);
>> +       long rate;
>>
>>         /* No need to reinitialize the UART after relocation */
>>         if (gd->flags & GD_FLG_RELOC)
>>                 return 0;
>>
>> -       ret = msm_uart_clk_init(dev);
>> -       if (ret)
>> -               return ret;
>> +       rate = msm_uart_clk_init(dev);
>> +       if (rate < 0)
>> +               return rate;
>> +       if (!rate) {
>> +               log_err("Got core clock rate of 0... Please fix your clock driver\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* Update the clock rate to the actual programmed rate returned by the
>> +        * clock driver
>> +        */
>> +       priv->clk_rate = rate;
>>
>>         uart_dm_init(priv);
>>
>>         return 0;
>> @@ -210,15 +257,20 @@ static int msm_serial_probe(struct udevice *dev)
>>
>>  static int msm_serial_of_to_plat(struct udevice *dev)
>>  {
>>         struct msm_serial_data *priv = dev_get_priv(dev);
>> +       int ret;
>>
>>         priv->base = dev_read_addr(dev);
>>         if (priv->base == FDT_ADDR_T_NONE)
>>                 return -EINVAL;
>>
>> -       priv->clk_bit_rate = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
>> -                                                       "bit-rate", UART_DM_CLK_RX_TX_BIT_RATE);
>> +       ret = dev_read_u32(dev, "clock-frequency", &priv->clk_rate);
>> +       if (ret < 0) {
>> +               log_debug("No clock frequency specified, using default rate\n");
>> +               /* Default for APQ8016 */
>> +               priv->clk_rate = 7372800;
>> +       }
>>
>>         return 0;
>>  }
>>
>> @@ -241,8 +293,9 @@ U_BOOT_DRIVER(serial_msm) = {
>>  #ifdef CONFIG_DEBUG_UART_MSM
>>
>>  static struct msm_serial_data init_serial_data = {
>>         .base = CONFIG_VAL(DEBUG_UART_BASE),
>> +       .clk_rate = 7372800,
>>  };
>>
>>  #include <debug_uart.h>
>>
>>
>> --
>> 2.44.0
>>
> 
> 

-- 
// Caleb (they/them)
