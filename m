Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6910C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23ABE86FB6;
	Mon,  6 Nov 2023 13:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D9gNSXK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EB086CF2; Mon,  6 Nov 2023 13:39:34 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 630CC86E05
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 13:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so38953525e9.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 04:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699274371; x=1699879171; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mrHSQ5FMQTy70uC42fj5/LTU6mF1+Ifo5v41SjvdhvU=;
 b=D9gNSXK/79DI6YctmVwMUIangDrRJk6NR0LIIUoDPj22SRJRlx+2D0pB00axgYDiv3
 W/xwzSaJYcgGpsn0a4nXZJVmihvGnxsOH29fC1Ec/7mD6bpSlJ3vwUVP8hfV1bKJncq9
 djTrml0WHKkFdphplgeqb3wOkay7UfC/v+aVqTlhI/flUVpD2Ek280yxV1cCoy2A+QqJ
 Nki705ZHCbNoFBaSG7kTb16v6nrR5ulTsXLoCc7iuzNt/Kl9UjrC9Wm7LVZrsL23wQMD
 ECRnnhXVLj+Z+6/N4zW62EKxPJfPeuQ4sZISuuXc/Ho0qrB8pzHf43TCDjSXCLjv8rAN
 2AAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699274371; x=1699879171;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mrHSQ5FMQTy70uC42fj5/LTU6mF1+Ifo5v41SjvdhvU=;
 b=dft65S4zw6X0AKsavm6hH99OhYpltr6nqmIb5I4ec8+KnhgesVQjY8CAeW53DNIKL1
 KYN/sly8WsBXW10eYchjXd9xGdT1wn0f11ToOJxAQFG1UIMOKe88IVAe9UDajA5u45jm
 4KVyI+5fXAaQplVSvpXldZB0Yj4Vk0YbPgPUtKBl9/uM2F3FTmd5baupNAQ2xEloCZKu
 StPl9MBlsmQCAO+PHpQFHVRVNSe/z8okRfLM46+6Rnqtb2Pl3GE4WevWNVFk+H2I2ZWi
 GzQK/Nie8zP8YUkl3/Dhlt8iY9+/huNreS7/xGxaarHcCshlVcAfMIceQe8b5Cdz8BWg
 3KXA==
X-Gm-Message-State: AOJu0YyZ1l6s46p4oTi3Uin94+U45AM7MhUSnlFpK9PuNz0gV2LeIyMm
 v+4F30OF0rgJN0MXzqHSo5ndMA==
X-Google-Smtp-Source: AGHT+IFDdgyR3c0MS3SAnfMUvdpN5XZWDoVR2XNZOU91VG7kHG/PDg3A+guQR/yCQwzPIwI/6ZwIwA==
X-Received: by 2002:a05:6000:4020:b0:32f:acb1:ba9b with SMTP id
 cp32-20020a056000402000b0032facb1ba9bmr10031759wrb.22.1699274370745; 
 Mon, 06 Nov 2023 04:39:30 -0800 (PST)
Received: from [192.168.1.7] (host-92-25-138-185.as13285.net. [92.25.138.185])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a5d688f000000b0032f9688ea48sm9331448wru.10.2023.11.06.04.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 04:39:30 -0800 (PST)
Message-ID: <9333910c-68a3-490e-87d9-9f875cfb354a@linaro.org>
Date: Mon, 6 Nov 2023 12:39:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
References: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
 <20231103-b4-qcom-clk-v3-6-8d2d460ece84@linaro.org>
 <CAFA6WYMNPVNUM3pKWtrUwrDxxp077_neRe=2zTua1AB1zVdGSg@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYMNPVNUM3pKWtrUwrDxxp077_neRe=2zTua1AB1zVdGSg@mail.gmail.com>
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



On 06/11/2023 07:06, Sumit Garg wrote:
> On Fri, 3 Nov 2023 at 21:09, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> This property is needed on some platforms to ensure that only the
>> relevant bits are set in the M/N/D registers.
> 
> This commit broke qcs404 platform which is fixed by following add-on change:
> 
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index 429ff35e1d..f5b3528039 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -195,7 +195,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk,
> ulong rate)
>         case GCC_BLSP1_UART2_APPS_CLK:
>                 /* UART: 115200 */
>                 clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
> -                                    CFG_CLK_SRC_CXO, 8);
> +                                    CFG_CLK_SRC_CXO, 16);
>                 clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
>                 break;
>         case GCC_BLSP1_AHB_CLK:
> 
> This is needed as per Linux qcs404 clock driver too. I would suggest
> you double check if you have imported correct values from
> corresponding Linux clock drivers for other platforms too.

Ah, you're right - I think all platforms use 16 bits for the UART RCG,
Thanks a lot for testing this.

> 
> BTW, after this fix feel free to add:
> 
> Tested-by: Sumit Garg <sumit.garg@linaro.org> (QCS404)
> 
> -Sumit
> 
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
>> ---
>>  drivers/clk/qcom/clock-apq8016.c |  4 ++--
>>  drivers/clk/qcom/clock-apq8096.c |  4 ++--
>>  drivers/clk/qcom/clock-qcom.c    | 11 +++++++----
>>  drivers/clk/qcom/clock-qcom.h    |  2 +-
>>  drivers/clk/qcom/clock-qcs404.c  | 18 +++++++++---------
>>  drivers/clk/qcom/clock-sdm845.c  |  3 +--
>>  6 files changed, 22 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
>> index 3f44252c453e..630619c83454 100644
>> --- a/drivers/clk/qcom/clock-apq8016.c
>> +++ b/drivers/clk/qcom/clock-apq8016.c
>> @@ -86,7 +86,7 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
>>         clk_enable_cbc(priv->base + SDCC_AHB_CBCR(slot));
>>         /* 800Mhz/div, gpll0 */
>>         clk_rcg_set_rate_mnd(priv->base, &sdc_regs[slot], div, 0, 0,
>> -                            CFG_CLK_SRC_GPLL0);
>> +                            CFG_CLK_SRC_GPLL0, 8);
>>         clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>>         clk_enable_cbc(priv->base + SDCC_APPS_CBCR(slot));
>>
>> @@ -109,7 +109,7 @@ static int clk_init_uart(struct msm_clk_priv *priv)
>>
>>         /* 7372800 uart block clock @ GPLL0 */
>>         clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 144, 15625,
>> -                            CFG_CLK_SRC_GPLL0);
>> +                            CFG_CLK_SRC_GPLL0, 8);
>>
>>         /* Vote for gpll0 clock */
>>         clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
>> index 75633a7c2af8..095c1b431245 100644
>> --- a/drivers/clk/qcom/clock-apq8096.c
>> +++ b/drivers/clk/qcom/clock-apq8096.c
>> @@ -69,7 +69,7 @@ static int clk_init_sdc(struct msm_clk_priv *priv, uint rate)
>>
>>         clk_enable_cbc(priv->base + SDCC2_AHB_CBCR);
>>         clk_rcg_set_rate_mnd(priv->base, &sdc_regs, div, 0, 0,
>> -                            CFG_CLK_SRC_GPLL0);
>> +                            CFG_CLK_SRC_GPLL0, 8);
>>         clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>>         clk_enable_cbc(priv->base + SDCC2_APPS_CBCR);
>>
>> @@ -91,7 +91,7 @@ static int clk_init_uart(struct msm_clk_priv *priv)
>>
>>         /* 7372800 uart block clock @ GPLL0 */
>>         clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 192, 15625,
>> -                            CFG_CLK_SRC_GPLL0);
>> +                            CFG_CLK_SRC_GPLL0, 8);
>>
>>         /* Vote for gpll0 clock */
>>         clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
>> index 77bcaacd1583..fc478554f982 100644
>> --- a/drivers/clk/qcom/clock-qcom.c
>> +++ b/drivers/clk/qcom/clock-qcom.c
>> @@ -83,7 +83,7 @@ void clk_bcr_update(phys_addr_t apps_cmd_rcgr)
>>
>>  /* root set rate for clocks with half integer and MND divider */
>>  void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>> -                         int div, int m, int n, int source)
>> +                         int div, int m, int n, int source, u8 mnd_width)
>>  {
>>         u32 cfg;
>>         /* M value for MND divider. */
>> @@ -92,11 +92,14 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>>         u32 n_val = ~((n) - (m)) * !!(n);
>>         /* NOT 2D value for MND divider. */
>>         u32 d_val = ~(n);
>> +       u32 mask = BIT(mnd_width) - 1;
>> +
>> +       debug("m %#x n %#x d %#x div %#x mask %#x\n", m_val, n_val, d_val, div, mask);
>>
>>         /* Program MND values */
>> -       writel(m_val, base + regs->M);
>> -       writel(n_val, base + regs->N);
>> -       writel(d_val, base + regs->D);
>> +       writel(m_val & mask, base + regs->M);
>> +       writel(n_val & mask, base + regs->N);
>> +       writel(d_val & mask, base + regs->D);
>>
>>         /* setup src select and divider */
>>         cfg  = readl(base + regs->cfg_rcgr);
>> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
>> index 86f9ff6eb2f6..24a32cb9666d 100644
>> --- a/drivers/clk/qcom/clock-qcom.h
>> +++ b/drivers/clk/qcom/clock-qcom.h
>> @@ -72,7 +72,7 @@ void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
>>  void clk_enable_cbc(phys_addr_t cbcr);
>>  void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
>>  void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>> -                         int div, int m, int n, int source);
>> +                         int div, int m, int n, int source, u8 mnd_width);
>>  void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>>                       int source);
>>
>> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
>> index 9ad580b50fc8..921abf1f699b 100644
>> --- a/drivers/clk/qcom/clock-qcs404.c
>> +++ b/drivers/clk/qcom/clock-qcs404.c
>> @@ -195,7 +195,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>>         case GCC_BLSP1_UART2_APPS_CLK:
>>                 /* UART: 115200 */
>>                 clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
>> -                                    CFG_CLK_SRC_CXO);
>> +                                    CFG_CLK_SRC_CXO, 8);
>>                 clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
>>                 break;
>>         case GCC_BLSP1_AHB_CLK:
>> @@ -204,7 +204,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>>         case GCC_SDCC1_APPS_CLK:
>>                 /* SDCC1: 200MHz */
>>                 clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 4, 0, 0,
>> -                                    CFG_CLK_SRC_GPLL0);
>> +                                    CFG_CLK_SRC_GPLL0, 8);
>>                 clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>>                 clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
>>                 break;
>> @@ -214,16 +214,16 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>>         case GCC_ETH_RGMII_CLK:
>>                 if (rate == 250000000)
>>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
>> -                                            CFG_CLK_SRC_GPLL1);
>> +                                            CFG_CLK_SRC_GPLL1, 8);
>>                 else if (rate == 125000000)
>>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 4, 0, 0,
>> -                                            CFG_CLK_SRC_GPLL1);
>> +                                            CFG_CLK_SRC_GPLL1, 8);
>>                 else if (rate == 50000000)
>>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 10, 0, 0,
>> -                                            CFG_CLK_SRC_GPLL1);
>> +                                            CFG_CLK_SRC_GPLL1, 8);
>>                 else if (rate == 5000000)
>>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 1, 50,
>> -                                            CFG_CLK_SRC_GPLL1);
>> +                                            CFG_CLK_SRC_GPLL1, 8);
>>                 break;
>>         default:
>>                 return 0;
>> @@ -240,7 +240,7 @@ static int qcs404_clk_enable(struct clk *clk)
>>         case GCC_USB30_MASTER_CLK:
>>                 clk_enable_cbc(priv->base + USB30_MASTER_CBCR);
>>                 clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 4, 0, 0,
>> -                                    CFG_CLK_SRC_GPLL0);
>> +                                    CFG_CLK_SRC_GPLL0, 8);
>>                 break;
>>         case GCC_SYS_NOC_USB3_CLK:
>>                 clk_enable_cbc(priv->base + SYS_NOC_USB3_CBCR);
>> @@ -262,14 +262,14 @@ static int qcs404_clk_enable(struct clk *clk)
>>                 clk_enable_cbc(priv->base + ETH_PTP_CBCR);
>>                 clk_enable_gpll0(priv->base, &gpll1_vote_clk);
>>                 clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 2, 0, 0,
>> -                                    CFG_CLK_SRC_GPLL1);
>> +                                    CFG_CLK_SRC_GPLL1, 8);
>>                 break;
>>         case GCC_ETH_RGMII_CLK:
>>                 /* SPEED_1000: freq -> 250MHz */
>>                 clk_enable_cbc(priv->base + ETH_RGMII_CBCR);
>>                 clk_enable_gpll0(priv->base, &gpll1_vote_clk);
>>                 clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
>> -                                    CFG_CLK_SRC_GPLL1);
>> +                                    CFG_CLK_SRC_GPLL1, 8);
>>                 break;
>>         case GCC_ETH_SLAVE_AHB_CLK:
>>                 clk_enable_cbc(priv->base + ETH_SLAVE_AHB_CBCR);
>> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
>> index fc9a783f7354..6af1f38302d2 100644
>> --- a/drivers/clk/qcom/clock-sdm845.c
>> +++ b/drivers/clk/qcom/clock-sdm845.c
>> @@ -89,8 +89,7 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
>>         case GCC_QUPV3_WRAP1_S1_CLK: /* UART9 */
>>                 freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
>>                 clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
>> -                                    freq->pre_div, freq->m, freq->n, freq->src);
>> -
>> +                                    freq->pre_div, freq->m, freq->n, freq->src, 16);
>>                 return freq->freq;
>>         default:
>>                 return 0;
>>
>> --
>> 2.42.0
>>

-- 
// Caleb (they/them)
