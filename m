Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA804C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 18:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FFF788CD0;
	Sat,  3 Aug 2024 20:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kiz0wC4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560C588BF5; Sat,  3 Aug 2024 14:29:24 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1771B88719
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 14:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=iuncuim@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52f04b4abdcso13695134e87.2
 for <u-boot@lists.denx.de>; Sat, 03 Aug 2024 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722688161; x=1723292961; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=khC9UbQdLia4aDV9nGtQ1fCD+jzZGuPe7TF9MRgUOew=;
 b=kiz0wC4I1g2YPXBFkCW26IdWwU2wTp8gAWwBSMdEOPNwNB6k/+p2O6sy5qKyC0hqIJ
 UKj0T44ajPs3BwU35UoHO2oMauqAEcd9ECw7IlfI9IzMMqV/x8K9ADqAfftRJ99D6LD1
 gankP0DyFqvpWpH1QCEmVsY169fMVb8XsfLjUkavcl7Bt16ldwKDYFi5YSQ8y2tcxO96
 SfsBrfeWmbC/pF95MR2JfEcbViEWGo21QjlrDOCvfZUeztintfkFR+Bk5lvdq5U/Rogf
 2Y673nLeMtOBarQa6SNgySM3gOGU3MV6IFztvue+E5FBXTHLnr9ofyOWGdqbivNglKTP
 E/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722688161; x=1723292961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=khC9UbQdLia4aDV9nGtQ1fCD+jzZGuPe7TF9MRgUOew=;
 b=O8b8crUosSqc07QbGFnZFUuU4op8NIIrsVvCxsVFxUYdFmO00FNwLoli5pk53GVvIv
 KgfqwOZY/qobHGbD+zWZdnRa5GdUlvHjnH4lkbjHXGj8sxryo96HFz5xGQuhysbgkuDS
 h+LbPYl93Ww8D8eoXiyQa7HchHFtNZlf3DKTdv66hUYfOwn68CsNnvVp2BFGglnHI/4g
 G4sDghJQebf+qvWxy6nb/TTs4qRgs0FwXyuPoB9auE2EOnEE9JTyzhnu+1MlU+OsvFQp
 1OcgtCjMgckJLWHPL3W9miL6gakIgkYrrSRKKkhNYrgZ5UTacKkjdGqa0pxAwtLhtxK7
 yFTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNJxRbJiZXIk9WelDivOIFUf7nsnP8YAr0ik8FwOvKKKB5KuT2wJpb2Nnp24kn7BKhMrRF7JFkXmJJDbS8DqoxQZX1/Q==
X-Gm-Message-State: AOJu0YzVbgRGzN8RozTQxLeReuZCQtEUcCdr6vYyX17LRb8BVxDXOqpw
 3a7GJJUJHYzkBFJXWzhcGbkKYjXEBmQGOnzUZhQyJ8GHjS7mVrVTNjbSQQ==
X-Google-Smtp-Source: AGHT+IGj3Leba9r5J9YBvDB22tvRdxHs/asFq4zQ3ym2Rupd3bt1XCKNngP2GTBlDbGJT+BynK5hJA==
X-Received: by 2002:a05:6512:696:b0:52c:e07d:229c with SMTP id
 2adb3069b0e04-530bb36e5e7mr3954353e87.22.1722688160931; 
 Sat, 03 Aug 2024 05:29:20 -0700 (PDT)
Received: from [192.168.99.248] ([94.143.198.76])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-530bba29fc2sm486291e87.167.2024.08.03.05.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Aug 2024 05:29:20 -0700 (PDT)
Message-ID: <9b7db179-1e08-4690-97f8-b040f1c19f37@gmail.com>
Date: Sat, 3 Aug 2024 15:29:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] sunxi: H616: dram: LPDDR4: adjust settings
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, andre.przywara@arm.com, jagan@amarulasolutions.com,
 trini@konsulko.com, ryan@testtoast.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240801225519.336667-1-macroalpha82@gmail.com>
 <20240801225519.336667-4-macroalpha82@gmail.com>
Content-Language: en-US
From: Mikhail Kalashnikov <iuncuim@gmail.com>
In-Reply-To: <20240801225519.336667-4-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 03 Aug 2024 20:55:08 +0200
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


On 02.08.2024 01:55, Chris Morgan wrote:
> From: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> Adjust H616 LPDDR4 DRAM settings to be in line with vendor driver.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Tested-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   arch/arm/mach-sunxi/dram_sun50i_h616.c        | 35 +++++++++++++------
>   .../dram_timings/h616_lpddr4_2133.c           |  2 +-
>   2 files changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index a20264d8b4..b6638c519e 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -293,14 +293,22 @@ static void mctl_phy_configure_odt(const struct dram_para *para)
>   	dmb();
>   }
>   
> -static bool mctl_phy_write_leveling(const struct dram_config *config)
> +static bool mctl_phy_write_leveling(const struct dram_para *para,
> +				    const struct dram_config *config)
>   {
>   	bool result = true;
>   	u32 val;
>   
>   	clrsetbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 0xc0, 0x80);
> -	writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
> -	writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
> +
> +	if (para->type == SUNXI_DRAM_TYPE_LPDDR4) {
> +		/* MR2 value */
> +		writel(0x1b, SUNXI_DRAM_PHY0_BASE + 0xc);
> +		writel(0, SUNXI_DRAM_PHY0_BASE + 0x10);
> +	} else {
> +		writel(4, SUNXI_DRAM_PHY0_BASE + 0xc);
> +		writel(0x40, SUNXI_DRAM_PHY0_BASE + 0x10);
> +	}
>   
>   	setbits_le32(SUNXI_DRAM_PHY0_BASE + 8, 4);
>   
> @@ -859,9 +867,9 @@ static void mctl_phy_ca_bit_delay_compensation(const struct dram_para *para,
>   		}
>   		break;
>   	case SUNXI_DRAM_TYPE_LPDDR4:
> -		if (para->tpr2 & 1) {
> -			writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
> -		} else {
> +		writel(val, SUNXI_DRAM_PHY0_BASE + 0x788);
> +		if (config->ranks == 2) {
> +			val = (para->tpr10 >> 11) & 0x1e;
>   			writel(val, SUNXI_DRAM_PHY0_BASE + 0x794);
>   		};
>   		break;
> @@ -949,6 +957,8 @@ static bool mctl_phy_init(const struct dram_para *para,
>   		break;
>   	case SUNXI_DRAM_TYPE_LPDDR4:
>   		val = para->tpr6 >> 24 & 0xff;
> +		if (!val)
> +			val = 0x33;

We don't need this as the default value from 
arch/arm/mach-sunxi/Kconfigcovers
this case:

config DRAM_SUN50I_H616_TPR6
hex "H616 DRAM TPR6 parameter"
default 0x3300c080

>   		break;
>   	case SUNXI_DRAM_TYPE_DDR4:
>   	default:
> @@ -1080,19 +1090,27 @@ static bool mctl_phy_init(const struct dram_para *para,
>   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>   
>   		writel(0xb04, &mctl_ctl->mrctrl1);
> +		udelay(10);
>   		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		udelay(10);
>   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>   
>   		writel(0xc72, &mctl_ctl->mrctrl1);
> +		udelay(10);
>   		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		udelay(10);
>   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>   
>   		writel(0xe09, &mctl_ctl->mrctrl1);
> +		udelay(10);
>   		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		udelay(10);
>   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>   
>   		writel(0x1624, &mctl_ctl->mrctrl1);
> +		udelay(10);
>   		writel(0x80000030, &mctl_ctl->mrctrl0);
> +		udelay(10);
Looks like something experimental.
>   		mctl_await_completion(&mctl_ctl->mrctrl0, BIT(31), 0);
>   		break;
>   	case SUNXI_DRAM_TYPE_DDR4:
> @@ -1108,7 +1126,7 @@ static bool mctl_phy_init(const struct dram_para *para,
>   
>   	if (para->tpr10 & TPR10_WRITE_LEVELING) {
>   		for (i = 0; i < 5; i++)
> -			if (mctl_phy_write_leveling(config))
> +			if (mctl_phy_write_leveling(para, config))
>   				break;
>   		if (i == 5) {
>   			debug("write leveling failed!\n");
> @@ -1234,9 +1252,6 @@ static bool mctl_ctrl_init(const struct dram_para *para,
>   	setbits_le32(&mctl_ctl->unk_0x3180, BIT(31) | BIT(30));
>   	setbits_le32(&mctl_ctl->unk_0x4180, BIT(31) | BIT(30));
>   
> -	if (para->type == SUNXI_DRAM_TYPE_LPDDR4)
> -		setbits_le32(&mctl_ctl->dbictl, 0x1);
> -

I have this piece of code in the opizero3 mtd dump. This condition depends
on tpr13. Judging by the dram_para parameters, it should be performed for
lpddr4 (and maybe ddr4) memory. According to the opizero3 dump it should
clear all values and set BIT(2). Don't know, why I only set BIT(0) here. 
This
may be a bug or another spl from t507 and the first version of the driver.

>   	setbits_le32(&mctl_ctl->rfshctl3, BIT(0));
>   	clrbits_le32(&mctl_ctl->dfimisc, BIT(0));
>   
> diff --git a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> index e6446b9180..6f5c4acbd6 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h616_lpddr4_2133.c
> @@ -23,7 +23,7 @@ void mctl_set_timing_params(const struct dram_para *para)
>   	u8 trcd		= max(ns_to_t(18), 2);
>   	u8 trc		= ns_to_t(65);
>   	u8 txp		= max(ns_to_t(8), 2);
> -	u8 trtp		= max(ns_to_t(8), 4);
> +	u8 trtp		= 4;
>   	u8 trp		= ns_to_t(21);
>   	u8 tras		= ns_to_t(42);
>   	u16 trefi	= ns_to_t(3904) / 32;
