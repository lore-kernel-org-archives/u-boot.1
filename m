Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E613C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34BCC87D45;
	Wed,  1 Nov 2023 18:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lnyuZEdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63BE086E24; Wed,  1 Nov 2023 18:13:10 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695FC87D50
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7781b176131so417757185a.1
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698858782; x=1699463582; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K6mZeX8wThXSKzQLFfVKrPw5jJXpapDF3Aae2h/JWGo=;
 b=lnyuZEdHmjAON4aOBwpbMJ5o9BghJiPLjl6zFsNUOdtlkaSzSCP86zaetHnGujXzUm
 k2arh40s9u2pNIu3iWrPEXkoIkokEu13u+xkAH1iuMgMJCnBEkWGbCTZdvVyh7ST2THf
 MCiVbh086MG249WsS00wV9V03pff8O6DZoLVcreQpj+kvlFz+zBYSsczUOUWEDSeWHvR
 e6Si/1tv2BiZMs0WKukPtbNyKB/h191E6484onMTNx+znvWRClzLz+q/n1taj7YLsN5Z
 C7QnA4pAhC9jUdeuj6Ozzm7Oul7bZ/QQMiIUBzT8Vqx4+xsQ7/6bLCmEbo4Oj//hEmm4
 YNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698858782; x=1699463582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K6mZeX8wThXSKzQLFfVKrPw5jJXpapDF3Aae2h/JWGo=;
 b=mlm+w3HFsxH0WdnljLCb65i5pCj0VPQCvv8K1S8LjCbsc8SnWeI2mXEl4VyW++hvbv
 ZPVER752exzu/h2SHNEpdZ3An2siyxiu2BJKHUX3e7a9kA78QPnGuUNsoQDKGN9WepKx
 HgZsUYRdXxS5ydL4uxGVOZxQpJ2DFLL+8vPlO3PnYugcgaoKPR51UV8axuDolPLVLBxp
 Zo7Pf17FM2LUpx5xflvQl1LciS0OdTslm2kOFwn97OrdyE4YJBo2asPA+g6dmDqxtWYQ
 1Au7IKCy0jnMwuhzSxobHD80dNqkFaLKMeHLB5Nhpg99GKjJTrka6uVCUswyxSqgmeII
 S9aw==
X-Gm-Message-State: AOJu0YxNkzCyDGiX1v/DRYbpQxcJXc0PFN2wHlq/QrbYxZv41My94q/i
 Tw6MAoJxUa4BT6jvGnT3XqE=
X-Google-Smtp-Source: AGHT+IGtADypI52mdOkch27+dRr+xJyHEUFlqA7jr+Lf1i4QHYEXTMQcRajBUmGXVzzIHPyoEjZuRQ==
X-Received: by 2002:a05:620a:6844:b0:778:8b91:2c88 with SMTP id
 ru4-20020a05620a684400b007788b912c88mr15684357qkn.66.1698858782013; 
 Wed, 01 Nov 2023 10:13:02 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ay44-20020a05620a17ac00b007778503ebf4sm1598996qkb.16.2023.11.01.10.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 10:13:01 -0700 (PDT)
Message-ID: <76e8d762-18d2-12de-cdd6-3b30ff3360ab@gmail.com>
Date: Wed, 1 Nov 2023 13:13:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 7/8] clk: treewide: switch to clock dump from clk_ops
Content-Language: en-US
To: Igor Prusov <ivprusov@sberdevices.ru>, Michal Simek
 <michal.simek@amd.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20231017165649.1492-1-ivprusov@sberdevices.ru>
 <20231017165649.1492-8-ivprusov@sberdevices.ru>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20231017165649.1492-8-ivprusov@sberdevices.ru>
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

On 10/17/23 12:56, Igor Prusov wrote:
> Switch to using new dump operation in clock provider drivers instead of
> overriding soc_clk_dump.
> 
> Signed-off-by: Igor Prusov <ivprusov@sberdevices.ru>
> Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/mips/mach-pic32/cpu.c             | 23 ---------------
>   drivers/clk/aspeed/clk_ast2600.c       | 13 ++++-----
>   drivers/clk/clk_k210.c                 | 11 +++-----
>   drivers/clk/clk_pic32.c                | 39 ++++++++++++++++++++++++++
>   drivers/clk/clk_versal.c               |  7 ++++-
>   drivers/clk/clk_zynq.c                 | 19 ++++---------
>   drivers/clk/clk_zynqmp.c               | 13 ++++-----
>   drivers/clk/imx/clk-imx8.c             | 11 +++-----
>   drivers/clk/meson/a1.c                 | 24 ++++------------
>   drivers/clk/mvebu/armada-37xx-periph.c |  5 +++-
>   drivers/clk/stm32/clk-stm32mp1.c       | 29 ++++++-------------
>   11 files changed, 89 insertions(+), 105 deletions(-)
> 
> diff --git a/arch/mips/mach-pic32/cpu.c b/arch/mips/mach-pic32/cpu.c
> index 7ed306e045..68099dd02f 100644
> --- a/arch/mips/mach-pic32/cpu.c
> +++ b/arch/mips/mach-pic32/cpu.c
> @@ -144,26 +144,3 @@ const char *get_core_name(void)
>   	return str;
>   }
>   #endif
> -#ifdef CONFIG_CMD_CLK
> -
> -int soc_clk_dump(void)
> -{
> -	int i;
> -
> -	printf("PLL Speed: %lu MHz\n",
> -	       CLK_MHZ(rate(PLLCLK)));
> -
> -	printf("CPU Speed: %lu MHz\n", CLK_MHZ(rate(PB7CLK)));
> -
> -	printf("MPLL Speed: %lu MHz\n", CLK_MHZ(rate(MPLL)));
> -
> -	for (i = PB1CLK; i <= PB7CLK; i++)
> -		printf("PB%d Clock Speed: %lu MHz\n", i - PB1CLK + 1,
> -		       CLK_MHZ(rate(i)));
> -
> -	for (i = REF1CLK; i <= REF5CLK; i++)
> -		printf("REFO%d Clock Speed: %lu MHz\n", i - REF1CLK + 1,
> -		       CLK_MHZ(rate(i)));
> -	return 0;
> -}
> -#endif
> diff --git a/drivers/clk/aspeed/clk_ast2600.c b/drivers/clk/aspeed/clk_ast2600.c
> index b3cc8392fa..e1365d3f81 100644
> --- a/drivers/clk/aspeed/clk_ast2600.c
> +++ b/drivers/clk/aspeed/clk_ast2600.c
> @@ -1109,6 +1109,7 @@ struct aspeed_clks {
>   	const char *name;
>   };
>   
> +#if IS_ENABLED(CONFIG_CMD_CLK)
>   static struct aspeed_clks aspeed_clk_names[] = {
>   	{ ASPEED_CLK_HPLL, "hpll" },
>   	{ ASPEED_CLK_MPLL, "mpll" },
> @@ -1123,18 +1124,12 @@ static struct aspeed_clks aspeed_clk_names[] = {
>   	{ ASPEED_CLK_HUARTX, "huxclk" },
>   };
>   
> -int soc_clk_dump(void)
> +static int ast2600_clk_dump(struct udevice *dev)
>   {
> -	struct udevice *dev;
>   	struct clk clk;
>   	unsigned long rate;
>   	int i, ret;
>   
> -	ret = uclass_get_device_by_driver(UCLASS_CLK, DM_DRIVER_GET(aspeed_scu),
> -					  &dev);
> -	if (ret)
> -		return ret;
> -
>   	printf("Clk\t\tHz\n");
>   
>   	for (i = 0; i < ARRAY_SIZE(aspeed_clk_names); i++) {
> @@ -1167,11 +1162,15 @@ int soc_clk_dump(void)
>   
>   	return 0;
>   }
> +#endif
>   
>   struct clk_ops ast2600_clk_ops = {
>   	.get_rate = ast2600_clk_get_rate,
>   	.set_rate = ast2600_clk_set_rate,
>   	.enable = ast2600_clk_enable,
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	.dump = ast2600_clk_dump,
> +#endif
>   };
>   
>   static int ast2600_clk_probe(struct udevice *dev)
> diff --git a/drivers/clk/clk_k210.c b/drivers/clk/clk_k210.c
> index 2f17152021..058940b828 100644
> --- a/drivers/clk/clk_k210.c
> +++ b/drivers/clk/clk_k210.c
> @@ -1276,16 +1276,10 @@ static void show_clks(struct k210_clk_priv *priv, int id, int depth)
>   	}
>   }
>   
> -int soc_clk_dump(void)
> +static int k210_clk_dump(struct udevice *dev)
>   {
> -	int ret;
> -	struct udevice *dev;
>   	struct k210_clk_priv *priv;
>   
> -	ret = uclass_get_device_by_driver(UCLASS_CLK, DM_DRIVER_GET(k210_clk),
> -					  &dev);
> -	if (ret)
> -		return ret;
>   	priv = dev_get_priv(dev);
>   
>   	puts(" Rate      Enabled Name\n");
> @@ -1304,6 +1298,9 @@ static const struct clk_ops k210_clk_ops = {
>   	.set_parent = k210_clk_set_parent,
>   	.enable = k210_clk_enable,
>   	.disable = k210_clk_disable,
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	.dump = k210_clk_dump,
> +#endif
>   };
>   
>   static int k210_clk_probe(struct udevice *dev)
> diff --git a/drivers/clk/clk_pic32.c b/drivers/clk/clk_pic32.c
> index ef06a7fb9f..f756fc88f0 100644
> --- a/drivers/clk/clk_pic32.c
> +++ b/drivers/clk/clk_pic32.c
> @@ -20,6 +20,8 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +#define CLK_MHZ(x)	((x) / 1000000)
> +
>   /* Primary oscillator */
>   #define SYS_POSC_CLK_HZ	24000000
>   
> @@ -385,9 +387,46 @@ static ulong pic32_set_rate(struct clk *clk, ulong rate)
>   	return rate;
>   }
>   
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +static int pic32_dump(struct udevice *dev)
> +{
> +	int i;
> +	struct clk clk;
> +
> +	clk.dev = dev;
> +
> +	clk.id = PLLCLK;
> +	printf("PLL Speed: %lu MHz\n",
> +	       CLK_MHZ(pic32_get_rate(&clk)));
> +
> +	clk.id = PB7CLK;
> +	printf("CPU Speed: %lu MHz\n", CLK_MHZ(pic32_get_rate(&clk)));
> +
> +	clk.id = MPLL;
> +	printf("MPLL Speed: %lu MHz\n", CLK_MHZ(pic32_get_rate(&clk)));
> +
> +	for (i = PB1CLK; i <= PB7CLK; i++) {
> +		clk.id = i;
> +		printf("PB%d Clock Speed: %lu MHz\n", i - PB1CLK + 1,
> +		       CLK_MHZ(pic32_get_rate(&clk)));
> +	}
> +
> +	for (i = REF1CLK; i <= REF5CLK; i++) {
> +		clk.id = i;
> +		printf("REFO%d Clock Speed: %lu MHz\n", i - REF1CLK + 1,
> +		       CLK_MHZ(pic32_get_rate(&clk)));
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>   static struct clk_ops pic32_pic32_clk_ops = {
>   	.set_rate = pic32_set_rate,
>   	.get_rate = pic32_get_rate,
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	.dump = pic32_dump,
> +#endif
>   };
>   
>   static int pic32_clk_probe(struct udevice *dev)
> diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
> index c473643603..f3fafec7f7 100644
> --- a/drivers/clk/clk_versal.c
> +++ b/drivers/clk/clk_versal.c
> @@ -555,7 +555,8 @@ static int versal_clock_get_rate(u32 clk_id, u64 *clk_rate)
>   	return 0;
>   }
>   
> -int soc_clk_dump(void)
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +static int versal_clk_dump(struct udevice __always_unused *dev)
>   {
>   	u64 clk_rate = 0;
>   	u32 type, ret, i = 0;
> @@ -578,6 +579,7 @@ int soc_clk_dump(void)
>   
>   	return 0;
>   }
> +#endif
>   
>   static void versal_get_clock_info(void)
>   {
> @@ -769,6 +771,9 @@ static struct clk_ops versal_clk_ops = {
>   	.set_rate = versal_clk_set_rate,
>   	.get_rate = versal_clk_get_rate,
>   	.enable = versal_clk_enable,
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	.dump = versal_clk_dump,
> +#endif
>   };
>   
>   static const struct udevice_id versal_clk_ids[] = {
> diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
> index be5226175f..d492eea3b0 100644
> --- a/drivers/clk/clk_zynq.c
> +++ b/drivers/clk/clk_zynq.c
> @@ -454,6 +454,7 @@ static int dummy_enable(struct clk *clk)
>   	return 0;
>   }
>   
> +#if IS_ENABLED(CONFIG_CMD_CLK)
>   static const char * const clk_names[clk_max] = {
>   	"armpll", "ddrpll", "iopll",
>   	"cpu_6or4x", "cpu_3or2x", "cpu_2x", "cpu_1x",
> @@ -468,22 +469,10 @@ static const char * const clk_names[clk_max] = {
>   	"smc_aper", "swdt", "dbg_trc", "dbg_apb"
>   };
>   
> -/**
> - * soc_clk_dump() - Print clock frequencies
> - * Returns zero on success
> - *
> - * Implementation for the clk dump command.
> - */
> -int soc_clk_dump(void)
> +static int zynq_clk_dump(struct udevice *dev)
>   {
> -	struct udevice *dev;
>   	int i, ret;
>   
> -	ret = uclass_get_device_by_driver(UCLASS_CLK,
> -					  DM_DRIVER_GET(zynq_clk), &dev);
> -	if (ret)
> -		return ret;
> -
>   	printf("clk\t\tfrequency\n");
>   	for (i = 0; i < clk_max; i++) {
>   		const char *name = clk_names[i];
> @@ -511,6 +500,7 @@ int soc_clk_dump(void)
>   
>   	return 0;
>   }
> +#endif
>   
>   static struct clk_ops zynq_clk_ops = {
>   	.get_rate = zynq_clk_get_rate,
> @@ -518,6 +508,9 @@ static struct clk_ops zynq_clk_ops = {
>   	.set_rate = zynq_clk_set_rate,
>   #endif
>   	.enable = dummy_enable,
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	.dump = zynq_clk_dump,
> +#endif
>   };
>   
>   static int zynq_clk_probe(struct udevice *dev)
> diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
> index 1cfe0e25b1..dfcda429c7 100644
> --- a/drivers/clk/clk_zynqmp.c
> +++ b/drivers/clk/clk_zynqmp.c
> @@ -735,16 +735,11 @@ static ulong zynqmp_clk_set_rate(struct clk *clk, ulong rate)
>   	}
>   }
>   
> -int soc_clk_dump(void)
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +static int zynqmp_clk_dump(struct udevice *dev)
>   {
> -	struct udevice *dev;
>   	int i, ret;
>   
> -	ret = uclass_get_device_by_driver(UCLASS_CLK,
> -		DM_DRIVER_GET(zynqmp_clk), &dev);
> -	if (ret)
> -		return ret;
> -
>   	printf("clk\t\tfrequency\n");
>   	for (i = 0; i < clk_max; i++) {
>   		const char *name = clk_names[i];
> @@ -772,6 +767,7 @@ int soc_clk_dump(void)
>   
>   	return 0;
>   }
> +#endif
>   
>   static int zynqmp_get_freq_by_name(char *name, struct udevice *dev, ulong *freq)
>   {
> @@ -871,6 +867,9 @@ static struct clk_ops zynqmp_clk_ops = {
>   	.set_rate = zynqmp_clk_set_rate,
>   	.get_rate = zynqmp_clk_get_rate,
>   	.enable = zynqmp_clk_enable,
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	.dump = zynqmp_clk_dump,
> +#endif
>   };
>   
>   static const struct udevice_id zynqmp_clk_ids[] = {
> diff --git a/drivers/clk/imx/clk-imx8.c b/drivers/clk/imx/clk-imx8.c
> index ceeead3434..6cd55f4369 100644
> --- a/drivers/clk/imx/clk-imx8.c
> +++ b/drivers/clk/imx/clk-imx8.c
> @@ -43,18 +43,12 @@ static int imx8_clk_enable(struct clk *clk)
>   }
>   
>   #if IS_ENABLED(CONFIG_CMD_CLK)
> -int soc_clk_dump(void)
> +static int imx8_clk_dump(struct udevice *dev)
>   {
> -	struct udevice *dev;
>   	struct clk clk;
>   	unsigned long rate;
>   	int i, ret;
>   
> -	ret = uclass_get_device_by_driver(UCLASS_CLK,
> -					  DM_DRIVER_GET(imx8_clk), &dev);
> -	if (ret)
> -		return ret;
> -
>   	printf("Clk\t\tHz\n");
>   
>   	for (i = 0; i < num_clks; i++) {
> @@ -94,6 +88,9 @@ static struct clk_ops imx8_clk_ops = {
>   	.get_rate = imx8_clk_get_rate,
>   	.enable = imx8_clk_enable,
>   	.disable = imx8_clk_disable,
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	.dump = imx8_clk_dump,
> +#endif
>   };
>   
>   static int imx8_clk_probe(struct udevice *dev)
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index e3fa9db7d0..1820b31ff7 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -639,7 +639,7 @@ static const char *meson_clk_get_name(struct clk *clk, int id)
>   	return IS_ERR(info) ? "unknown" : info->name;
>   }
>   
> -static int meson_clk_dump(struct clk *clk)
> +static int meson_clk_dump_single(struct clk *clk)
>   {
>   	const struct meson_clk_info *info;
>   	struct meson_clk *priv;
> @@ -674,7 +674,7 @@ static int meson_clk_dump(struct clk *clk)
>   	return 0;
>   }
>   
> -static int meson_clk_dump_dev(struct udevice *dev)
> +static int meson_clk_dump(struct udevice *dev)
>   {
>   	int i;
>   	struct meson_clk_data *data;
> @@ -687,7 +687,7 @@ static int meson_clk_dump_dev(struct udevice *dev)
>   
>   	data = (struct meson_clk_data *)dev_get_driver_data(dev);
>   	for (i = 0; i < data->num_clocks; i++) {
> -		meson_clk_dump(&(struct clk){
> +		meson_clk_dump_single(&(struct clk){
>   			.dev = dev,
>   			.id = i
>   		});
> @@ -696,27 +696,15 @@ static int meson_clk_dump_dev(struct udevice *dev)
>   	return 0;
>   }
>   
> -int soc_clk_dump(void)
> -{
> -	struct udevice *dev;
> -	int i = 0;
> -
> -	while (!uclass_get_device(UCLASS_CLK, i++, &dev)) {
> -		if (dev->driver == DM_DRIVER_GET(meson_clk)) {
> -			meson_clk_dump_dev(dev);
> -			printf("\n");
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>   static struct clk_ops meson_clk_ops = {
>   	.disable	= meson_clk_disable,
>   	.enable		= meson_clk_enable,
>   	.get_rate	= meson_clk_get_rate,
>   	.set_rate	= meson_clk_set_rate,
>   	.set_parent	= meson_clk_set_parent,
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	.dump		= meson_clk_dump,
> +#endif
>   };
>   
>   U_BOOT_DRIVER(meson_clk) = {
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index e75052f383..faf75c8792 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -499,7 +499,7 @@ static int clk_dump(const char *name, int (*func)(struct udevice *))
>   
>   int armada_37xx_tbg_clk_dump(struct udevice *);
>   
> -int soc_clk_dump(void)
> +static int armada37xx_clk_dump(struct udevice __always_unused *dev)
>   {
>   	printf("  xtal at %u000000 Hz\n\n", get_ref_clk());
>   
> @@ -605,6 +605,9 @@ static const struct clk_ops armada_37xx_periph_clk_ops = {
>   	.set_parent = armada_37xx_periph_clk_set_parent,
>   	.enable = armada_37xx_periph_clk_enable,
>   	.disable = armada_37xx_periph_clk_disable,
> +#if IS_ENABLED(CONFIG_CMD_CLK)
> +	.dump = armada37xx_clk_dump,
> +#endif
>   };
>   
>   static const struct udevice_id armada_37xx_periph_clk_ids[] = {
> diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
> index f3ac8c7583..f78540ad1d 100644
> --- a/drivers/clk/stm32/clk-stm32mp1.c
> +++ b/drivers/clk/stm32/clk-stm32mp1.c
> @@ -2225,10 +2225,13 @@ static void stm32mp1_osc_init(struct udevice *dev)
>   	}
>   }
>   
> -static void  __maybe_unused stm32mp1_clk_dump(struct stm32mp1_clk_priv *priv)
> +static int __maybe_unused stm32mp1_clk_dump(struct udevice *dev)
>   {
>   	char buf[32];
>   	int i, s, p;
> +	struct stm32mp1_clk_priv *priv;
> +
> +	priv = dev_get_priv(dev);
>   
>   	printf("Clocks:\n");
>   	for (i = 0; i < _PARENT_NB; i++) {
> @@ -2250,28 +2253,9 @@ static void  __maybe_unused stm32mp1_clk_dump(struct stm32mp1_clk_priv *priv)
>   			       stm32mp1_clk_parent_sel_name[i], i, p);
>   		}
>   	}
> -}
> -
> -#ifdef CONFIG_CMD_CLK
> -int soc_clk_dump(void)
> -{
> -	struct udevice *dev;
> -	struct stm32mp1_clk_priv *priv;
> -	int ret;
> -
> -	ret = uclass_get_device_by_driver(UCLASS_CLK,
> -					  DM_DRIVER_GET(stm32mp1_clock),
> -					  &dev);
> -	if (ret)
> -		return ret;
> -
> -	priv = dev_get_priv(dev);
> -
> -	stm32mp1_clk_dump(priv);
>   
>   	return 0;
>   }
> -#endif
>   
>   static int stm32mp1_clk_probe(struct udevice *dev)
>   {
> @@ -2302,7 +2286,7 @@ static int stm32mp1_clk_probe(struct udevice *dev)
>   #if defined(VERBOSE_DEBUG)
>   	/* display debug information for probe after relocation */
>   	if (gd->flags & GD_FLG_RELOC)
> -		stm32mp1_clk_dump(priv);
> +		stm32mp1_clk_dump(dev);
>   #endif
>   
>   	gd->cpu_clk = stm32mp1_clk_get(priv, _CK_MPU);
> @@ -2333,6 +2317,9 @@ static const struct clk_ops stm32mp1_clk_ops = {
>   	.disable = stm32mp1_clk_disable,
>   	.get_rate = stm32mp1_clk_get_rate,
>   	.set_rate = stm32mp1_clk_set_rate,
> +#if IS_ENABLED(CONFIG_CMD_CLK) && !IS_ENABLED(CONFIG_SPL_BUILD)
> +	.dump = stm32mp1_clk_dump,
> +#endif
>   };
>   
>   U_BOOT_DRIVER(stm32mp1_clock) = {

Reviewed-by: Sean Anderson <seanga2@gmail.com>
