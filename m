Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4068CD129C
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578F887F70;
	Thu, 11 Apr 2024 05:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fuso2qrc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719B187B71; Thu, 11 Apr 2024 05:18:19 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C1BE881C9
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-434a76386feso28694971cf.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712805496; x=1713410296; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UjBjI6ucSQp1DNOkpjK0Ur65ciQY7jvjZutvfHUAfX8=;
 b=Fuso2qrcosLuuAMBr88gnjMP55fWkONztQgQEWs3K2jCnXhKA4j7AnZ1At7JgsdoGF
 aLnO/iU2/desg58SEzoVEriL/Jg1sD+S8ib/gIKXZewsk7b/hGymT+ZRrCcIgfINejeW
 5GE5kWNYm6qULLOZl+gOFyZ+HegjPSIe6jvhql7kpPPsdItEH+12hkABWJVRkc7uy+hD
 34h7ZC6StDPpzksIc/MvnzHw4Rk5KcqVQ5+/VKJWPk1FWHHgZosVs5gEue4QWJuMSrvJ
 igagOwf9U5lj3okGP5O6+3hMAJJe6duFUOp5bexaTOVa+4F2jiIUVyOvRHIBo5piXt6X
 o7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712805496; x=1713410296;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UjBjI6ucSQp1DNOkpjK0Ur65ciQY7jvjZutvfHUAfX8=;
 b=VKor6m3fjg9kwmLCe6LLPTNrMl/592fOXb6oWSOj+Bm9LBEdVcb+P0AMMQvEzYGHz0
 oFgjiGTx3N3j5ss9GV4+4ZVEaC5wZgekizI4919u5AWQJZ/ba+9PQzSHP/atfjexKlhF
 /NgCy2bgwmfGwpVIlzRPNxzzXnlHndpS/EqrcyAvLnb9rJgFJMWd1OPEHKFJ1M6wqLZ5
 NTM0NX8oY8aADHs3eRjOR3OMRhiVaZWvUwScvnAlpqlxB53y9ZvWm3+4lewwDmrxm4x8
 t0Cla3lsczZkVGT4JFc2IlYQQHbkOLdJXxKeCFRtZlcj88cstyUNRGp/kxbrHnY4P7U9
 gR6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsuH7/ytnWdw2jjWiiLT0X7pSePWnUt+JFifayXpYjE0xGC5KL6WR/T4eQlp8DOpHHQdc4uaHpsH8QNdVSy8MmS2CLqw==
X-Gm-Message-State: AOJu0Yzc6xbJfDE2gYUpfnr6+aA4aFYhDHHr7uIWGrMO/e7oJ4FqxkPm
 eq5PhntncE+Cc4giY3fQ0/GY9I6fRoSMCxFlHDCn2qPyYHtqHPTs
X-Google-Smtp-Source: AGHT+IEfl9MDTmbCbuMF2GnqSEourBqnk6fVK1jGAtvc0thPaIRB9PgbZ8D33buiUQklqJKk1rV5TA==
X-Received: by 2002:a05:622a:15cd:b0:435:ecc5:847f with SMTP id
 d13-20020a05622a15cd00b00435ecc5847fmr3798513qty.10.1712805496119; 
 Wed, 10 Apr 2024 20:18:16 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 k3-20020ac86043000000b004347627f12esm361086qtm.11.2024.04.10.20.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 20:18:15 -0700 (PDT)
Message-ID: <e3bebfc1-685f-6439-d7e2-d3b0ec3b09b6@gmail.com>
Date: Wed, 10 Apr 2024 23:18:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: imx8mp: add pwm clocks support
Content-Language: en-US
To: Tommaso Merciai <tomm.merciai@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linuxfancy@googlegroups.com, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20230310151544.1111042-1-tomm.merciai@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230310151544.1111042-1-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/10/23 10:15, Tommaso Merciai wrote:
> Add clocks support for the PWM controllers. This is ported from
> Linux v6.3.0-rc1
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>   drivers/clk/imx/clk-imx8mp.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index ffbc1d1ba9..fac87ff505 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -122,6 +122,22 @@ static const char *imx8mp_gic_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_p
>   					"sys_pll2_100m", "sys_pll1_800m",
>   					"sys_pll2_500m", "clk_ext4", "audio_pll2_out" };
>   
> +static const char * const imx8mp_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
> +					"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
> +					"sys_pll1_80m", "video_pll1_out", };
> +
> +static const char * const imx8mp_pwm2_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
> +					"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
> +					"sys_pll1_80m", "video_pll1_out", };
> +
> +static const char * const imx8mp_pwm3_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
> +					"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
> +					"sys_pll1_80m", "video_pll1_out", };
> +
> +static const char * const imx8mp_pwm4_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m",
> +					"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
> +					"sys_pll1_80m", "video_pll1_out", };
> +
>   static const char *imx8mp_ecspi1_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll1_40m",
>   						  "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
>   						  "sys_pll2_250m", "audio_pll2_out", };
> @@ -270,6 +286,10 @@ static int imx8mp_clk_probe(struct udevice *dev)
>   	clk_dm(IMX8MP_CLK_GIC, imx8m_clk_composite_critical("gic", imx8mp_gic_sels, base + 0xb200));
>   	clk_dm(IMX8MP_CLK_ECSPI1, imx8m_clk_composite("ecspi1", imx8mp_ecspi1_sels, base + 0xb280));
>   	clk_dm(IMX8MP_CLK_ECSPI2, imx8m_clk_composite("ecspi2", imx8mp_ecspi2_sels, base + 0xb300));
> +	clk_dm(IMX8MP_CLK_PWM1, imx8m_clk_composite_critical("pwm1", imx8mp_pwm1_sels, base + 0xb380));
> +	clk_dm(IMX8MP_CLK_PWM2, imx8m_clk_composite_critical("pwm2", imx8mp_pwm2_sels, base + 0xb400));
> +	clk_dm(IMX8MP_CLK_PWM3, imx8m_clk_composite_critical("pwm3", imx8mp_pwm3_sels, base + 0xb480));
> +	clk_dm(IMX8MP_CLK_PWM4, imx8m_clk_composite_critical("pwm4", imx8mp_pwm4_sels, base + 0xb500));
>   	clk_dm(IMX8MP_CLK_ECSPI3, imx8m_clk_composite("ecspi3", imx8mp_ecspi3_sels, base + 0xc180));
>   
>   	clk_dm(IMX8MP_CLK_WDOG, imx8m_clk_composite("wdog", imx8mp_wdog_sels, base + 0xb900));
> @@ -292,6 +312,10 @@ static int imx8mp_clk_probe(struct udevice *dev)
>   	clk_dm(IMX8MP_CLK_I2C2_ROOT, imx_clk_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0));
>   	clk_dm(IMX8MP_CLK_I2C3_ROOT, imx_clk_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0));
>   	clk_dm(IMX8MP_CLK_I2C4_ROOT, imx_clk_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0));
> +	clk_dm(IMX8MP_CLK_PWM1_ROOT, imx_clk_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0));
> +	clk_dm(IMX8MP_CLK_PWM2_ROOT, imx_clk_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0));
> +	clk_dm(IMX8MP_CLK_PWM3_ROOT, imx_clk_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0));
> +	clk_dm(IMX8MP_CLK_PWM4_ROOT, imx_clk_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0));
>   	clk_dm(IMX8MP_CLK_QSPI_ROOT, imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
>   	clk_dm(IMX8MP_CLK_I2C5_ROOT, imx_clk_gate2("i2c5_root_clk", "i2c5", base + 0x4330, 0));
>   	clk_dm(IMX8MP_CLK_I2C6_ROOT, imx_clk_gate2("i2c6_root_clk", "i2c6", base + 0x4340, 0));

Acked-by: Sean Anderson <seanga2@gmail.com>

But I would like to see a RB from one of the i.MX maintainers (CC'd).
