Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C17EE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 12:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604508640E;
	Wed, 23 Aug 2023 14:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qxGUC8gc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 471FC863E9; Wed, 23 Aug 2023 14:02:46 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FCC88640E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so7068383a12.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692792163; x=1693396963;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5BecjCPmZ8B1MqBUqyG/8FEgjYAw9SQchsAznI7Fo+E=;
 b=qxGUC8gcZ/wPf7blifSf1/+xWqO/fHXHQqcwfEd76siZt6vn0k/csUrdg1vvorlpSI
 FvzQu0pgEz3g+euza/GDniBcVpl6W3CJp1d6xCZezR0byh6DB1eqDnLvmYLWsF2U+k1a
 h2VLXjI1SDPir5wudnny+8n+AoxzNyPy4fOVtN7QMfn8x4/eRcNp5txtRr48OgvT0DTK
 ApQfIzk5F2tEk6kqjRsNuzen6vw9TFwwFnwEKslPAc5f/wxFMlJwMlcqpf7pxjgTQAXK
 g9uKnrcBfTr51P/QaAI2qiIMF8lsJnKWhtbcRLvCsUXYDI8F1qReDyN/Qe2d84JKiVrX
 cTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692792163; x=1693396963;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5BecjCPmZ8B1MqBUqyG/8FEgjYAw9SQchsAznI7Fo+E=;
 b=gGhEdtMEYrqsoRSSQEnyw++Qj30/6Q6sAVTz/RZ+uGS+3kv7idN46j/fhDYkyZU07l
 xc6OuSg0voHN6v0yvbXxHYhb+sAqBOZo2euRjUo+iiuEBJXO4xN/LWrIpQ1h50cqG9Er
 m3QfLxlR1sK359dYBkwV/leNkXW7BXgjwrSa0l1QwTCGuzVaDPzWvfU9pRbdcsnF+nQ+
 Yr7hFCMK5GwnjfnOpXmmWVy4NnQvvp9qSqS5MpiNZdKYJ3XbjhiXJcX9kyjLQHT2cDjD
 YkrWZmvkf+meFTcs7BXQmKF2EPvtBx83jEpOsQcal1DOWJ0/VX905NFb0aMWa6u+PkV4
 GARA==
X-Gm-Message-State: AOJu0Yx4vWjwlfYjZY06feXLa1egra0Q0eQhwfdrWR/bhDsVo4F2DNQi
 Wa3MslTpsBIsmvrTAzGwjTYdqpThDsRmog==
X-Google-Smtp-Source: AGHT+IHOQCMrGw3Nfrhy6b0L51NoYzZZ0u1H/Se3b5B28oXQ/FB6Ndzk+yQt4vupZnWSvPCZh11nJQ==
X-Received: by 2002:a17:906:9be8:b0:99d:6ca6:7a8c with SMTP id
 de40-20020a1709069be800b0099d6ca67a8cmr9822431ejc.63.1692792163433; 
 Wed, 23 Aug 2023 05:02:43 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.10.167]) by smtp.gmail.com with ESMTPSA id
 d16-20020a17090648d000b0098d2d219649sm9792039ejt.174.2023.08.23.05.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 05:02:43 -0700 (PDT)
Date: Wed, 23 Aug 2023 15:02:42 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_mmc=3A_tegra=3A_get_defau?=
 =?US-ASCII?Q?lt-tap_and_default-trim_from_device_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZOXnfY5hKrhSpOlY@orome>
References: <20230819153501.77245-1-clamor95@gmail.com>
 <20230819153501.77245-2-clamor95@gmail.com> <ZOXnfY5hKrhSpOlY@orome>
Message-ID: <E8D9B66C-E23C-4359-928F-D510C8D4AF22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 14:03:25 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Sat, Aug 19, 2023 at 06:35:01PM +0300, Svyatoslav Ryhel wrote:
>> Default-tap and default-trim values are used for eMMC setup
>> mostly on T114+ devices=2E As for now, those values are hardcoded
>> for T210 and ignored for all other Tegra generations=2E Fix this
>> by passing tap and trim values from dts=2E
>>=20
>> Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # ASUS TF701T
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  arch/arm/include/asm/arch-tegra/tegra_mmc=2Eh | 17 ++++----
>>  drivers/mmc/tegra_mmc=2Ec                     | 46 ++++++++++---------=
--
>>  2 files changed, 30 insertions(+), 33 deletions(-)
>>=20
>> diff --git a/arch/arm/include/asm/arch-tegra/tegra_mmc=2Eh b/arch/arm/i=
nclude/asm/arch-tegra/tegra_mmc=2Eh
>> index d6a55764ba=2E=2E750c7d809e 100644
>> --- a/arch/arm/include/asm/arch-tegra/tegra_mmc=2Eh
>> +++ b/arch/arm/include/asm/arch-tegra/tegra_mmc=2Eh
>> @@ -128,21 +128,22 @@ struct tegra_mmc {
>> =20
>>  /* SDMMC1/3 settings from SDMMCx Initialization Sequence of TRM */
>>  #define MEMCOMP_PADCTRL_VREF	7
>> -#define AUTO_CAL_ENABLE		(1 << 29)
>> -#define AUTO_CAL_ACTIVE		(1 << 31)
>> -#define AUTO_CAL_START		(1 << 31)
>> +#define AUTO_CAL_ENABLE		BIT(29)
>> +#define AUTO_CAL_ACTIVE		BIT(31)
>> +#define AUTO_CAL_START		BIT(31)
>> +
>>  #if defined(CONFIG_TEGRA210)
>>  #define AUTO_CAL_PD_OFFSET	(0x7D << 8)
>>  #define AUTO_CAL_PU_OFFSET	(0 << 0)
>> -#define IO_TRIM_BYPASS_MASK	(1 << 2)
>> -#define TRIM_VAL_SHIFT		24
>> -#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
>> -#define TAP_VAL_SHIFT		16
>> -#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
>>  #else
>>  #define AUTO_CAL_PD_OFFSET	(0x70 << 8)
>>  #define AUTO_CAL_PU_OFFSET	(0x62 << 0)
>>  #endif
>> =20
>> +#define TRIM_VAL_SHIFT		24
>> +#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
>> +#define TAP_VAL_SHIFT		16
>> +#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
>> +
>>  #endif	/* __ASSEMBLY__ */
>>  #endif	/* __TEGRA_MMC_H_ */
>> diff --git a/drivers/mmc/tegra_mmc=2Ec b/drivers/mmc/tegra_mmc=2Ec
>> index f76fee3ea0=2E=2E7627800261 100644
>> --- a/drivers/mmc/tegra_mmc=2Ec
>> +++ b/drivers/mmc/tegra_mmc=2Ec
>> @@ -37,6 +37,9 @@ struct tegra_mmc_priv {
>>  	unsigned int version;	/* SDHCI spec=2E version */
>>  	unsigned int clock;	/* Current clock (MHz) */
>>  	int mmc_id;		/* peripheral id */
>> +
>> +	u32 tap_value;
>> +	u32 trim_value;
>>  };
>> =20
>>  static void tegra_mmc_set_power(struct tegra_mmc_priv *priv,
>> @@ -526,31 +529,6 @@ static void tegra_mmc_pad_init(struct tegra_mmc_pr=
iv *priv)
>>  		printf("%s: Warning: Autocal timed out!\n", __func__);
>>  		/* TBD: Set CFG2TMC_SDMMC1_PAD_CAL_DRV* regs here */
>>  	}
>> -
>> -#if defined(CONFIG_TEGRA210)
>> -	u32 tap_value, trim_value;
>> -
>> -	/* Set tap/trim values for SDMMC1/3 @ <48MHz here */
>> -	val =3D readl(&priv->reg->venspictl);	/* aka VENDOR_SYS_SW_CNTL */
>> -	val &=3D IO_TRIM_BYPASS_MASK;
>> -	if (id =3D=3D PERIPH_ID_SDMMC1) {
>> -		tap_value =3D 4;			/* default */
>> -		if (val)
>> -			tap_value =3D 3;
>> -		trim_value =3D 2;
>> -	} else {				/* SDMMC3 */
>> -		tap_value =3D 3;
>> -		trim_value =3D 3;
>> -	}
>> -
>> -	val =3D readl(&priv->reg->venclkctl);
>> -	val &=3D ~TRIM_VAL_MASK;
>> -	val |=3D (trim_value << TRIM_VAL_SHIFT);
>> -	val &=3D ~TAP_VAL_MASK;
>> -	val |=3D (tap_value << TAP_VAL_SHIFT);
>> -	writel(val, &priv->reg->venclkctl);
>> -	debug("%s: VENDOR_CLOCK_CNTRL =3D 0x%08X\n", __func__, val);
>> -#endif	/* T210 */
>>  #endif	/* T30/T210 */
>>  }
>> =20
>> @@ -588,6 +566,21 @@ static void tegra_mmc_reset(struct tegra_mmc_priv =
*priv, struct mmc *mmc)
>> =20
>>  	/* Make sure SDIO pads are set up */
>>  	tegra_mmc_pad_init(priv);
>> +
>> +	if (priv->tap_value || priv->trim_value) {
>
>I think 0 is a valid value for both tap and trim, so you want to be able
>to write that=2E I suggest getting rid of the conditional and always
>writing these values and rely on defaults to make sure that a good value
>is always programmed=2E
>
>Alternatively if you really only want to program these when they've been
>specified, use an extra variable (or something like -1 as a default
>value) to discriminate=2E

I may propose a compromise=2E Do not set default value at all and when tim=
e comes just check if tap or trim is not error=2E

>The former is superior, in my opinion, because it also allows to avoid
>to regression=2E
>
>Thierry
>
>> +		u32 val;
>> +
>> +		val =3D readl(&priv->reg->venclkctl);
>> +
>> +		val &=3D ~TRIM_VAL_MASK;
>> +		val |=3D (priv->trim_value << TRIM_VAL_SHIFT);
>> +
>> +		val &=3D ~TAP_VAL_MASK;
>> +		val |=3D (priv->tap_value << TAP_VAL_SHIFT);
>> +
>> +		writel(val, &priv->reg->venclkctl);
>> +		debug("%s: VENDOR_CLOCK_CNTRL =3D 0x%08X\n", __func__, val);
>> +	}
>>  }
>> =20
>>  static int tegra_mmc_init(struct udevice *dev)
>> @@ -742,6 +735,9 @@ static int tegra_mmc_probe(struct udevice *dev)
>>  	if (dm_gpio_is_valid(&priv->pwr_gpio))
>>  		dm_gpio_set_value(&priv->pwr_gpio, 1);
>> =20
>> +	priv->tap_value =3D dev_read_u32_default(dev, "nvidia,default-tap", 0=
);
>> +	priv->trim_value =3D dev_read_u32_default(dev, "nvidia,default-trim",=
 0);
>> +
>>  	upriv->mmc =3D &plat->mmc;
>> =20
>>  	return tegra_mmc_init(dev);
>> --=20
>> 2=2E39=2E2
>>=20
