Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349DBC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D948658A;
	Thu, 24 Aug 2023 15:33:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P0Qkr3nV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A6D8658C; Thu, 24 Aug 2023 15:33:24 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D928653B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:33:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99d937b83efso878811566b.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692884001; x=1693488801;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zBs0UUkMPcCJFRdy62HZCQzRPlIZUqbTmyw7dK4t2pg=;
 b=P0Qkr3nVxbHp0LMF7dxi5MRPP4QoaWDnmo8ex8ca7rFKCeoPTTt5ggP/Yz4PRrCeLG
 dHYBTA+LNAdS0mkLxOZveDGHQeLa4nKljrLaAm7XvPh58tEx8R/t5kmDKSecjLAiPe/Q
 c/mSQ9iKiefDy8tCjmxgGIhv1VujmRDiT7TMVXtQZLU+ynTLCTgyzPhYjWOVSU8Xz3Xf
 tR6QUWdP2Dqcn2K3zxTLFtYwl3jMq7690nHld4JeKtEchydfU5KMHYtLR4l12Ff05TfQ
 TRd0ahIz3TUA3nsvVfweLTosabZIBnlGGepHNn1vBEOz9jbLw+l088b89ugDR/p6F5y9
 +V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692884001; x=1693488801;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zBs0UUkMPcCJFRdy62HZCQzRPlIZUqbTmyw7dK4t2pg=;
 b=WBr2N8DREeHOnsSosKsQX3nNmd8+wR9MdYQG3aa6LbBBqYWnpOPt9Bh0X0rCcD1B+x
 fa4svm4QKN3ZtDaZFnsZw+3M6C2BuQDtwoAKUpEiKVqrhz5HnH2o0mhB/Mn4phl53Dm/
 ExZwgnZMHftQVrMaAR/mKidwBdM1ph138IW6Wxwv5mcv8KufhFexY+BfoENlPnefQ6IM
 rLVUQkH6AhOwyrpeEV0v8bejiqFln7VyYO0zMOPRD1YIHxJ5WK8P2NJhl165nvnuaI2+
 eIbq1uLOwzmNjd2LF/uUPCEBLbW5EOeAJ71kvikUCkR5XUkGpYzQihdvPoLmXfRR/Axp
 MBTw==
X-Gm-Message-State: AOJu0YwUUPPN/9oL0+ef7JAoNc9GRhyvaezuhKLHllbDocEJvjkXiLTX
 MtD8fX2YvBQruc5kZai2mfvBmbTXUGvOug==
X-Google-Smtp-Source: AGHT+IEKGLHG0E0ymcemQyKsh3n6Zk+rCTpxn/iyPw1qUVY076YNreNDzq8eNRwC9nz3nIu2Uez0dA==
X-Received: by 2002:a17:907:2c62:b0:99c:c6b7:65e4 with SMTP id
 ib2-20020a1709072c6200b0099cc6b765e4mr10671748ejc.77.1692884001314; 
 Thu, 24 Aug 2023 06:33:21 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.238.14]) by smtp.gmail.com with ESMTPSA id
 xa5-20020a170907b9c500b009a219ecbaf1sm663878ejc.85.2023.08.24.06.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 06:33:20 -0700 (PDT)
Date: Thu, 24 Aug 2023 16:33:20 +0300
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1_1/1=5D_mmc=3A_tegra=3A_get_defau?=
 =?US-ASCII?Q?lt-tap_and_default-trim_from_device_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZOdbMq68QtVbrGVM@orome>
References: <20230819153501.77245-1-clamor95@gmail.com>
 <20230819153501.77245-2-clamor95@gmail.com> <ZOXnfY5hKrhSpOlY@orome>
 <B2FF6549-4F01-4010-968E-D790E72AE2EE@gmail.com> <ZOdbMq68QtVbrGVM@orome>
Message-ID: <D8556B98-DE33-4A79-B409-2269A5F1CF5D@gmail.com>
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



24 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 16:29:22 GMT+03:00,=
 Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Wed, Aug 23, 2023 at 02:38:48PM +0300, Svyatoslav Ryhel wrote:
>>=20
>>=20
>> 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80=2E 14:03:25 GMT+03:=
00, Thierry Reding <thierry=2Ereding@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>> >On Sat, Aug 19, 2023 at 06:35:01PM +0300, Svyatoslav Ryhel wrote:
>> >> Default-tap and default-trim values are used for eMMC setup
>> >> mostly on T114+ devices=2E As for now, those values are hardcoded
>> >> for T210 and ignored for all other Tegra generations=2E Fix this
>> >> by passing tap and trim values from dts=2E
>> >>=20
>> >> Tested-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom> # ASUS TF701T
>> >> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> >> ---
>> >>  arch/arm/include/asm/arch-tegra/tegra_mmc=2Eh | 17 ++++----
>> >>  drivers/mmc/tegra_mmc=2Ec                     | 46 ++++++++++------=
-----
>> >>  2 files changed, 30 insertions(+), 33 deletions(-)
>> >>=20
>> >> diff --git a/arch/arm/include/asm/arch-tegra/tegra_mmc=2Eh b/arch/ar=
m/include/asm/arch-tegra/tegra_mmc=2Eh
>> >> index d6a55764ba=2E=2E750c7d809e 100644
>> >> --- a/arch/arm/include/asm/arch-tegra/tegra_mmc=2Eh
>> >> +++ b/arch/arm/include/asm/arch-tegra/tegra_mmc=2Eh
>> >> @@ -128,21 +128,22 @@ struct tegra_mmc {
>> >> =20
>> >>  /* SDMMC1/3 settings from SDMMCx Initialization Sequence of TRM */
>> >>  #define MEMCOMP_PADCTRL_VREF	7
>> >> -#define AUTO_CAL_ENABLE		(1 << 29)
>> >> -#define AUTO_CAL_ACTIVE		(1 << 31)
>> >> -#define AUTO_CAL_START		(1 << 31)
>> >> +#define AUTO_CAL_ENABLE		BIT(29)
>> >> +#define AUTO_CAL_ACTIVE		BIT(31)
>> >> +#define AUTO_CAL_START		BIT(31)
>> >> +
>> >>  #if defined(CONFIG_TEGRA210)
>> >>  #define AUTO_CAL_PD_OFFSET	(0x7D << 8)
>> >>  #define AUTO_CAL_PU_OFFSET	(0 << 0)
>> >> -#define IO_TRIM_BYPASS_MASK	(1 << 2)
>> >> -#define TRIM_VAL_SHIFT		24
>> >> -#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
>> >> -#define TAP_VAL_SHIFT		16
>> >> -#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
>> >>  #else
>> >>  #define AUTO_CAL_PD_OFFSET	(0x70 << 8)
>> >>  #define AUTO_CAL_PU_OFFSET	(0x62 << 0)
>> >>  #endif
>> >> =20
>> >> +#define TRIM_VAL_SHIFT		24
>> >> +#define TRIM_VAL_MASK		(0x1F << TRIM_VAL_SHIFT)
>> >> +#define TAP_VAL_SHIFT		16
>> >> +#define TAP_VAL_MASK		(0xFF << TAP_VAL_SHIFT)
>> >> +
>> >>  #endif	/* __ASSEMBLY__ */
>> >>  #endif	/* __TEGRA_MMC_H_ */
>> >> diff --git a/drivers/mmc/tegra_mmc=2Ec b/drivers/mmc/tegra_mmc=2Ec
>> >> index f76fee3ea0=2E=2E7627800261 100644
>> >> --- a/drivers/mmc/tegra_mmc=2Ec
>> >> +++ b/drivers/mmc/tegra_mmc=2Ec
>> >> @@ -37,6 +37,9 @@ struct tegra_mmc_priv {
>> >>  	unsigned int version;	/* SDHCI spec=2E version */
>> >>  	unsigned int clock;	/* Current clock (MHz) */
>> >>  	int mmc_id;		/* peripheral id */
>> >> +
>> >> +	u32 tap_value;
>> >> +	u32 trim_value;
>> >>  };
>> >> =20
>> >>  static void tegra_mmc_set_power(struct tegra_mmc_priv *priv,
>> >> @@ -526,31 +529,6 @@ static void tegra_mmc_pad_init(struct tegra_mmc=
_priv *priv)
>> >>  		printf("%s: Warning: Autocal timed out!\n", __func__);
>> >>  		/* TBD: Set CFG2TMC_SDMMC1_PAD_CAL_DRV* regs here */
>> >>  	}
>> >> -
>> >> -#if defined(CONFIG_TEGRA210)
>> >> -	u32 tap_value, trim_value;
>> >> -
>> >> -	/* Set tap/trim values for SDMMC1/3 @ <48MHz here */
>> >> -	val =3D readl(&priv->reg->venspictl);	/* aka VENDOR_SYS_SW_CNTL */
>> >> -	val &=3D IO_TRIM_BYPASS_MASK;
>> >> -	if (id =3D=3D PERIPH_ID_SDMMC1) {
>> >> -		tap_value =3D 4;			/* default */
>> >> -		if (val)
>> >> -			tap_value =3D 3;
>> >> -		trim_value =3D 2;
>> >> -	} else {				/* SDMMC3 */
>> >> -		tap_value =3D 3;
>> >> -		trim_value =3D 3;
>> >> -	}
>> >> -
>> >> -	val =3D readl(&priv->reg->venclkctl);
>> >> -	val &=3D ~TRIM_VAL_MASK;
>> >> -	val |=3D (trim_value << TRIM_VAL_SHIFT);
>> >> -	val &=3D ~TAP_VAL_MASK;
>> >> -	val |=3D (tap_value << TAP_VAL_SHIFT);
>> >> -	writel(val, &priv->reg->venclkctl);
>> >> -	debug("%s: VENDOR_CLOCK_CNTRL =3D 0x%08X\n", __func__, val);
>> >> -#endif	/* T210 */
>> >>  #endif	/* T30/T210 */
>> >>  }
>> >> =20
>> >> @@ -588,6 +566,21 @@ static void tegra_mmc_reset(struct tegra_mmc_pr=
iv *priv, struct mmc *mmc)
>> >> =20
>> >>  	/* Make sure SDIO pads are set up */
>> >>  	tegra_mmc_pad_init(priv);
>> >> +
>> >> +	if (priv->tap_value || priv->trim_value) {
>> >
>> >I think 0 is a valid value for both tap and trim, so you want to be ab=
le
>> >to write that=2E I suggest getting rid of the conditional and always
>> >writing these values and rely on defaults to make sure that a good val=
ue
>> >is always programmed=2E
>>=20
>> Tegra 3 uses 0x0F on all my devices which is not 0=2E
>>=20
>> >Alternatively if you really only want to program these when they've be=
en
>> >specified, use an extra variable (or something like -1 as a default
>> >value) to discriminate=2E
>>=20
>> Why 0 value cannot be used as "flag" to skip tap and trim setup if valu=
es are not set? Using any value but 0 will cause additional comparation in =
condition and will definitely not improve readability=2E
>
>If you use 0 as a flag it implies that you can never set 0 as a value
>explicitly=2E So if some SoC or board ever needs to set that exact value
>it can't=2E

I got this same thought after I sent this answer=2E It is valid point and =
use of extra variable seems valid=2E Thanks=2E

>Thierry
