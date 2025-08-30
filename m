Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB67CA0EFF
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 05:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5815283930;
	Sun, 31 Aug 2025 07:09:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="VUmahcIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7706F836B2; Sun, 31 Aug 2025 01:13:11 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969518366F
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 01:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3d1bf79d7acso538679f8f.0
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1756595588; x=1757200388; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoBsov8k2qC9m6uWCZIQBET9jrK1vzO6vPawHeNUCRc=;
 b=VUmahcIRoYAmZLOyjsH038c9eBrkAKFRE6OJOAhcyTuX/8I+ax24p06sHlOzzzy1TQ
 DmrCYooLvedeuC9xvxu/ESDvbdfDguhg1LCZCwgGkveTYLXtgMsWyJh2K3UtRBEo3nCd
 ja3+1BeSmR2PLukKv4dte4m6EFNF/igyhFe8zWDi3vr/zjiQjGF8zQNlLepYR1WEB6CK
 J8zaldbGxy6DyEmDVYp2RI+Jk7semvVkyrzRrrxCRJPvfZZKwnXLfB5vW9EmYeKCtpWE
 1NdYipJHBnDyAmFlurpZbFiqN6nWoyIsk0TDgAtMuux0h6UMkyzvLM1plLmZS8y4bzXd
 XoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756595588; x=1757200388;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hoBsov8k2qC9m6uWCZIQBET9jrK1vzO6vPawHeNUCRc=;
 b=g00IpXnTD0GPJE13gv7HkPem/9jH1T5bo6a9pd3Rc0vdiLz9cTaXwu1ilYbiFsjXbw
 naYZwjvAV7qz0fvAk8lsI1OtQXFS98PAgS1jeBPsOX+kQRhD5Lf2n7MovU8vtcmG++Yk
 ygI8buJJUxPf8oOGnKZiyXrWXFP3c7bSOFt7MjLVM+xAIT4J6JrYhoQ2RBnd3x35nRbC
 OUEjonQI3fRAnWztFAFJ1bF1HxLxHZsFOLd1JnUNEmIQCs/jnGsVqCaXTu3YwgOeFLuJ
 s88qAOW43ps/8HVbyeefYVguQX0gzOVq6Brl8E4+i0L+diGtvHJrbYZS0V6tKKXLUO9I
 S2UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9U2jEMXwVGzBy4Rn5ncQNlh3PUMXyy1PwkNdEvpT3NTVszrdTHk+47CoySWQ2L3YQe2Db9yQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxXEi4iLjKP5hwELgbN1kcLQ/UNrKp8BMLiWbN4Oy09KQ+J5WOj
 5hpRHZwag+cL2gyyLZGJohnl9qSgjNDjrDy6S4m5XhrsE/fEoylHTrE6mimECQd+10A=
X-Gm-Gg: ASbGnctXan73Fq2N4W+j5ZkBFUfq7QM8vHtQ31rTx6Mxyi0ko+mNGmmaSxY7GfHpzhD
 pGiDzgBSlNbAjwLQ6r/Xt5oysUHfyU/jT+Ks1WGy8fIgUBtKXf+xdw14pQNTqrouqT26RHq9Q2+
 H2tNwyBCaNl8T8Z6BZz6X2bAjefdLmEIszzwIYgh65SapQKtpQt5Qv9TD1vGUu2ywEQCmdhyGnR
 fLTNPd0rFT/l5KrRzssO5nom2Tg6c8UI0jTM1Lnh1N3y/5EiVXP9rQNoeri+jeSrKrTKgsKFf1d
 aXwEUW9s2Bt94xOM+kK2qEnkPKLrK2+LyfVLcCvGrBlKtQd6qvwr5AALftgaW8QwEJzbPbH3f0/
 9HMlmwUG8PSZ8eDisI/3vSpdWrteJ+CWZdJgtwT6491LfaTz7mitUSfWF+PPMuSOEHwVe5sceNB
 g75kukPQ++f/jIIENzRXrySUan51kf5OTL5jA0922wRn2QfhitsIyjtDikFy4bcw==
X-Google-Smtp-Source: AGHT+IHPRsq3Hg6tjQWGzQMDg1ycEE+m+PWFEyfWc3icR49BbIqJ1BabLXgSrU4GttGJel+l6xVs3w==
X-Received: by 2002:a05:6000:26d1:b0:3c9:9ec0:2055 with SMTP id
 ffacd0b85a97d-3d1dfb114f1mr2627669f8f.39.1756595587973; 
 Sat, 30 Aug 2025 16:13:07 -0700 (PDT)
Received: from localhost
 (2001-4dd4-b50d-1-6cbc-9785-2dbe-b2b6.ipv6dyn.netcologne.de.
 [2001:4dd4:b50d:1:6cbc:9785:2dbe:b2b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fc34esm8882777f8f.10.2025.08.30.16.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 16:13:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Aug 2025 01:13:06 +0200
Message-Id: <DCG56025MZGT.61FADN1C4FZT@fairphone.com>
Cc: <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>, "U-Boot"
 <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH] power: qcom-rpmh-regulator: add support for pm6150l
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jens Reidel" <adrian@mainlining.org>, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Casey Connolly" <casey.connolly@linaro.org>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Tom Rini" <trini@konsulko.com>, "Varadarajan
 Narayanan" <quic_varada@quicinc.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250826233339.64077-1-adrian@mainlining.org>
In-Reply-To: <20250826233339.64077-1-adrian@mainlining.org>
X-Mailman-Approved-At: Sun, 31 Aug 2025 07:09:36 +0200
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

Hi Jens,

On Wed Aug 27, 2025 at 1:33 AM CEST, Jens Reidel wrote:
> Provides the supplies for SD card on SM7150.

I've already sent a patch for this, which has gotten a review, but
hasn't been picked up yet:
https://lore.kernel.org/u-boot/20250618-sm6350-bringup-v1-6-3cc22aab7a7a@fa=
irphone.com/

Regards
Luca

>
> Signed-off-by: Jens Reidel <adrian@mainlining.org>
> ---
>  drivers/power/regulator/qcom-rpmh-regulator.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/powe=
r/regulator/qcom-rpmh-regulator.c
> index 954deca5ed7..ac63c50e1d4 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -493,6 +493,19 @@ static const struct rpmh_vreg_hw_data pmic5_pldo515_=
mv =3D {
>  	.supply_name	=3D _supply_name, \
>  }
> =20
> +static const struct rpmh_vreg_init_data pm6150l_vreg_data[] =3D {
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo_lv,   "vdd-l1-l8"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l4-l5-l6"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo,      "vdd-l7-l11"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo,      "vdd-l1-l8"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,      "vdd-l9-l10"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l9-l10"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_pldo,      "vdd-l7-l11"),
> +	{}
> +};
> +
>  static const struct rpmh_vreg_init_data pm8150_vreg_data[] =3D {
>  	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
>  	{}
> @@ -705,6 +718,10 @@ static int rpmh_regulators_bind(struct udevice *dev)
>  }
> =20
>  static const struct udevice_id rpmh_regulator_ids[] =3D {
> +	{
> +		.compatible =3D "qcom,pm6150l-rpmh-regulators",
> +		.data =3D (ulong)pm6150l_vreg_data,
> +	},
>  	{
>  		.compatible =3D "qcom,pm8150-rpmh-regulators",
>  		.data =3D (ulong)pm8150_vreg_data,

