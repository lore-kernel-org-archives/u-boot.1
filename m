Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3B8EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 11:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 242B4808E6;
	Wed, 23 Aug 2023 13:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eBv/wGyn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDDD864B3; Wed, 23 Aug 2023 13:38:55 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8AF807C4
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 13:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99c0290f0a8so698974366b.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 04:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692790730; x=1693395530;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=M8VYYfUeNKBbLJXfwp8IRWdrtgSFqkigRC/xngQpQ+g=;
 b=eBv/wGynY9jla7y5c9MmFo0kMkRwCsdv5JCStwYXVKMYZrhCDbrDA2Cxo2K1ePYIC5
 VlhmQVvIntmg9zT5Jz+vWZRCSNEtIf3GhCM3koCqPEwWQsTA26DOnP82AykZwNqPftMW
 G4Nj48oCtmo+BgT29SyES0mcG70WWBO/S312fk+3ffBbPf8+FE7RKnab5X7R9OwYJxDP
 OXWY9GyfA8zXGWJjPvNaF+ocKJbCwpSCofkdD/yo/cfxl1FruogJBq6rT7xhjceAHvTN
 blb7iUY8i9IzmV9WoaQo15glgtar/bKB9Uo19YIeS695fDZ94YWaC6OBDTz/s8vonVOj
 gWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692790730; x=1693395530;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M8VYYfUeNKBbLJXfwp8IRWdrtgSFqkigRC/xngQpQ+g=;
 b=FK5/CL0bC5+IK3qlSLH2J+bgOwHZRUdOAhtLlCpyaGvZXW+UBd0vhABoMd0P9sFlim
 zH97xI03lELGWqzfOt5porudbiALI7PtszR/irkW0Phxhuhn6w+uZbXyz6YpEimduO0B
 Lm0XkOJruAgeFSvaij6XN9S2fPBX9xUYzCqCEro2IEmQWtXhYAuXRpDMhU4SxibIorS0
 sgeTi6drnsnDoSLtqRr7ASQZbXwljIIyKUepG3o8EyCn2SFbsvgKdmLop4NxtMwY2qQr
 ViukH5xlFVKmCIVgmHiuZb/9mwGxOsxRPwDGtzfKz56QqKqJVc5Maegjb6f3Egfv3KfM
 UHEg==
X-Gm-Message-State: AOJu0YzKX515t8kXU71H1wVKkYq3a7w27zUjzekjMW5Sdu8vE4lQkEcK
 gMMoq6hRx28gYY3zKUfwFQ2bG8QjzesCKQ==
X-Google-Smtp-Source: AGHT+IF3TyVNXhVWcxPTi+R/mPCTdWHR/L+CPLoHpa/7loXI1I+qmNcdLMhfLelVn1y9lGeYS3JKRA==
X-Received: by 2002:a17:906:200a:b0:99c:5056:4e2e with SMTP id
 10-20020a170906200a00b0099c50564e2emr8590934ejo.31.1692790729764; 
 Wed, 23 Aug 2023 04:38:49 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.10.167]) by smtp.gmail.com with ESMTPSA id
 g4-20020a1709064e4400b009a1be9c29d7sm2278937ejw.179.2023.08.23.04.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 04:38:49 -0700 (PDT)
Date: Wed, 23 Aug 2023 14:38:48 +0300
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
Message-ID: <B2FF6549-4F01-4010-968E-D790E72AE2EE@gmail.com>
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

Tegra 3 uses 0x0F on all my devices which is not 0=2E

>Alternatively if you really only want to program these when they've been
>specified, use an extra variable (or something like -1 as a default
>value) to discriminate=2E

Why 0 value cannot be used as "flag" to skip tap and trim setup if values =
are not set? Using any value but 0 will cause additional comparation in con=
dition and will definitely not improve readability=2E

>
>The former is superior, in my opinion, because it also allows to avoid
>to regression=2E

Regression can be avoided if merge "General tegra and board improvements" =
first=2E

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
