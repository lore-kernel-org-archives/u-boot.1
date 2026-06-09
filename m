Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51177CD8C92
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D87884704;
	Tue,  9 Jun 2026 14:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vzO2tJZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F27A984851; Tue,  9 Jun 2026 14:29:29 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A496846D3
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bebac79fff8so568691366b.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781008165; x=1781612965; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rm4atJ1jkO81PEbm6lSDBNV6266OTlQqxv1gO98/g+c=;
 b=vzO2tJZtbUaq9aM5ugu8TGZJJJ9rh3LIxPK2VHfFKVONBEpTm7G8QS4N5Uu6QE3ES6
 6ooXrOfzi/z3CUnoquRAoENCW0CHmT0ps0EmvDlgk3HXG13OBtRLmcAwfDsTUjPKxk9L
 kSyjwBIEmMiXgHhg8TrasUobdI3ViNjLedc0tYg9sAoixvwDXyurIoJxIGrT0OWQAdw+
 zcXoNJO4duM78XyQ2Jy+ox57dmiTThoiX4kAB5YGNW76lPEaaZSoUa1OXe5+k5g4H6V6
 PJULFDU01eggpIQEHImVXalBZt0qL1RbMi6yXXo+81RObE4pbr1p39oPyGgyd3O0PFFE
 HGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781008165; x=1781612965;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rm4atJ1jkO81PEbm6lSDBNV6266OTlQqxv1gO98/g+c=;
 b=TcUyj3MZkUNvypg+WozdP8rrHYetMWquDynORT4+pOSVT6BW7xeN8W5qS6NPfdQmod
 iPMA2dt22KnhO63bNlcceuzqB/WK9/MyGUptsaXgmoMAouGhYn7eeVKcrTB3xbFeo94c
 Wg6hAAtoJ2CXFNJM4PPfofskR2Hl2e2W1TDLvhBS1f1zRz5V+9eh0psRb5yuDd7jv2gq
 LAQ3xXFojkcsCLqwd6PXxc0/qJK6n9w4RC36XiiocE9d9YLITXywI067F825Y5VIwZFE
 2D3a+7/U5H/KGdW0eiot6hq4skXwmXpE/Jy8ddmIF6YjD+Y9lIW8ubJD1FDyVMugj80U
 q3aA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jYlbi36fxKfbHPvooMKqUdBXDWvVX4e1cb7/0Vb6hRzC8j7obqlQGJNJltubrZnVklBXg8Tg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzi155Vz1YlAIpttEGiflPTs/zFd3gzHyQ4xjlADT6oKJt8RgWt
 6FuCNxN8KNYiklJIGYMao2dWjoF7C16GUQej5mK7Qe2I7VimvPIoX1hunw7ckqtpX3Y=
X-Gm-Gg: Acq92OFcS0njVfu5nS/iGMZrvZ8zQj+HoTKho2rzM8QcTe4Hd58jPU3cabIGx3Fe+h6
 KqWwJpOdfZIs8O8aFo/RQign9wvKWwSKog+dqAgJERzKS5qAIthyXmP861I0NL0h+FyriubLtrn
 0RkSmeqbnceSw2PE7tvtOgHVhV53qfKDymLWrZoVzA4XNgt9jZNbQ6odq+aytBnCZXPzHeoW1Cl
 3BBPn8U22/ymU0q+vprNXImwbLJqWK1bOHaZXuo8jjov1DFsy2pLuf+8ygO2vGhQDEj0aQTgkiN
 wsWM84S1kGSnASSMHU7mgSAc56qPZZ2fXOzfvjpX5WV6083IR6cxZwo0gvHDZkkFDX5cWlEDtZH
 aYGruawWba36zzEBOW2YokgXNWEEn1OfW5DJBDHa2Vw745WQG5BEZz3qfGCz/9yZTJTWYoM+nA0
 OrC95ulfe9E8CwAMAh5V9FaRCnBvqwwogBZXePhLiRdJUGT/64F5GR/LSCAazwJUpHFTslYtaA8
 w==
X-Received: by 2002:a17:907:7f90:b0:beb:70d3:9a5b with SMTP id
 a640c23a62f3a-bf373cf0aafmr1060993166b.36.1781008165475; 
 Tue, 09 Jun 2026 05:29:25 -0700 (PDT)
Received: from [192.168.1.36] (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf0559eee00sm1047095666b.56.2026.06.09.05.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 05:29:24 -0700 (PDT)
Message-ID: <693606c8-975e-460a-9771-089a15af58e1@linaro.org>
Date: Tue, 9 Jun 2026 14:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: sa8775p: Add SDCC1 clock support with
 frequency table
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>
References: <20260526-mmc-v1-1-5a76de90e792@oss.qualcomm.com>
 <45e7f64d-5ea3-444e-9756-739577fd5421@linaro.org>
In-Reply-To: <45e7f64d-5ea3-444e-9756-739577fd5421@linaro.org>
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



On 26/05/2026 16:03, Casey Connolly wrote:
> 
> 
> On 26/05/2026 10:58, Balaji Selvanathan wrote:
>> Add support for SDCC1 (eMMC) clock on SA8775P platform.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

nevermind, NAK, please test your patches on U-Boot master before sending
them

> 
>> ---
>>  drivers/clk/qcom/clock-sa8775p.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
>> index 4957abf6f58..0ec4ad041c6 100644
>> --- a/drivers/clk/qcom/clock-sa8775p.c
>> +++ b/drivers/clk/qcom/clock-sa8775p.c
>> @@ -44,6 +44,22 @@
>>  
>>  #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
>>  
>> +#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
>> +
>> +/* SDCC1 APPS clock frequency table */
>> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
>> +	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
>> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
>> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>> +	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
>> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
>> +	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
>> +	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
>> +	F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
>> +	F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
>> +	{ }
>> +};
>> +
>>  static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>>  {
>>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>> @@ -63,6 +79,11 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>>  				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
>>  		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>>  		return rate;
>> +	case GCC_SDCC1_APPS_CLK:
>> +		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
>> +		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
>> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
>> +		return freq->freq;
>>  	default:
>>  		return 0;
>>  	}
>> @@ -106,6 +127,10 @@ static const struct gate_clk sa8775p_clks[] = {
>>  
>>  	/* QUP Wrapper 3 clocks */
>>  	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
>> +
>> +	/* SDCC1 clocks */
>> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x2000c, 1),
>> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x20004, 1),
>>  };
>>  
>>  static int sa8775p_enable(struct clk *clk)
>>
>> ---
>> base-commit: 76d62273bc8a5dc126ed79ed0fb65e5a97359577
>> change-id: 20260526-mmc-328c4d2c9055
>>
>> Best regards,
> 

-- 
// Casey (she/her)

