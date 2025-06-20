Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2188C7115D
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 10:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA6482CF4;
	Fri, 20 Jun 2025 12:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="KDLsrcmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04B6A82D7C; Fri, 20 Jun 2025 11:07:38 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C8782D39
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 11:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ade76b8356cso276212466b.2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750410455; x=1751015255; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIaDmj17uCezT4FfANFV1uNKGfQMJHyz+Mdrkn6xcWo=;
 b=KDLsrcmOeEMZd0oSJZzF9OB4DqpXC7Ns3jnOrjU8PwN4VG91+JJyTKZGkfvy32IjMk
 Yxu+noCLGwRx151TQRGqnuDdQ9wCG+3MB1DyDe1L4CrH95fXzes6NfX3IlRse+yF2lno
 x322Z+doMSQ8PmW11ZznKtQ5uZJAGvj0XKGQcac7K7HTIveRp96FlrUOvllRC4eYItNH
 p4gdRGwESq2qxSno4wlavf1juLQVaTF06V63pm+e6AkyCJ9pWhugEs+I+N6mWGF9mhDN
 Cu3tkCjPzVhPmEuyB/ST5w2CeDM2zoftihHE+Nn2wFJ1EghasY+84QdZ95mHR8MECXUM
 JT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750410455; x=1751015255;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mIaDmj17uCezT4FfANFV1uNKGfQMJHyz+Mdrkn6xcWo=;
 b=jLebUShhsOi+tsX6IgQnQs1Uh0FHcOXk7/Z4FOL2tluO5szZ3vXTXqQ61zENkCdAKf
 y8D1h5SqBsFe+SPVuvepj6iqUUJDxkRae5ntshVoXgHSSCEAFYSj52csZw+gUO+6eQMW
 F7oo4v16BszlQSN+R6mXtDPqUBMlm50Wh73lYYa551lgXX22lxMHjqHDXS02Ys/3BUBW
 eJEOLU9fWSyfSX3+PAFg/YgsVGSopdipo4NqChKloPusauh9Rns+Gl2857E7yhIBGeLB
 rYt3KEK30N+qIKoDytknELLygbACSydN5OoUq8npaRgzCJHZa8BGM5JcskFK3VZtTR+x
 L9Ag==
X-Gm-Message-State: AOJu0YxBHneokVN4MdXVObnKREdY9EiRMOtMvkacmpjC7o+OkMz33jox
 a0EIlw8dbf80y5gejKkTpVEhVvqTgfctXE9EfInNvuP4i0SdFniNkkwVFWaqFuyAwVE=
X-Gm-Gg: ASbGnctNOul7SBENf8FCk3VvkRqahQLcoF/R7Qtsw/155CERboK40XOeg2do+hAtQWS
 +d08tHwjE5LUzZKUrteatsCs68FvTORgLZkakBgceZcY2fTsIAbda8CaxBMhS03ylwnJM5WV0Y8
 XAF8CrtE32n/BTwbXJUiZvLvaiXummQIfjzn+Cf3LIbNsY6Vm7Q6Ie0vLKyIfByTH/FDOlPQ/AZ
 lFm3gqN7DyO5UyUOpPRcTuu4cXXOUAuLqPvUZmK7pAt5GiF5Rne48qzn5nZkLRWhJUMgq6GyB0V
 8HdoEzSBiiPKOBM8XeEscW0FT8pN82mR5x759AiG+aDDMIXmDkqpf3VBHGL/Seh/IEw0XxKOZri
 dh6JAuvYoy9TTOadPj65sRbeCDoAlLqk=
X-Google-Smtp-Source: AGHT+IGOFLok6A34tBJi/+51XibrhW49MUG97hnV2zuObA5rDC7qEo56f2b8v1ZFPWdAghB0MEe2WQ==
X-Received: by 2002:a17:907:6095:b0:ade:cdec:7085 with SMTP id
 a640c23a62f3a-ae057d87d58mr189107866b.26.1750410455348; 
 Fri, 20 Jun 2025 02:07:35 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053e7f53fsm129827766b.28.2025.06.20.02.07.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 02:07:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 11:07:34 +0200
Message-Id: <DAR8PXSLCOFN.GNOSXEGBFEX3@fairphone.com>
Cc: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: Re: [PATCH 1/8] clk/qcom: Add SM6350 clock driver
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Tom Rini"
 <trini@konsulko.com>, "Lukasz Majewski" <lukma@denx.de>, "Sean Anderson"
 <seanga2@gmail.com>, "Casey Connolly" <casey.connolly@linaro.org>, "Sumit
 Garg" <sumit.garg@kernel.org>, "Jaehoon Chung" <jh80.chung@samsung.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-1-3cc22aab7a7a@fairphone.com>
 <7ba396a4-d248-41bd-ace2-6d8f5c4c3bda@linaro.org>
In-Reply-To: <7ba396a4-d248-41bd-ace2-6d8f5c4c3bda@linaro.org>
X-Mailman-Approved-At: Fri, 20 Jun 2025 12:07:41 +0200
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

On Fri Jun 20, 2025 at 10:54 AM CEST, Neil Armstrong wrote:
> On 18/06/2025 16:25, Luca Weiss wrote:
>> Add Clock driver for the GCC block found in the SM6350 SoC.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---

<snip>

>> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] =3D {
>> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
>> +	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
>> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>> +	F(25000000, CFG_CLK_SRC_GPLL0_ODD, 8, 0, 0),
>> +	F(50000000, CFG_CLK_SRC_GPLL0_ODD, 4, 0, 0),
>> +	F(100000000, CFG_CLK_SRC_GPLL0_ODD, 2, 0, 0),
>> +	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
>> +	{}
>> +};
>> +
>> +static struct pll_vote_clk gpll7_vote_clk =3D {
>> +	.status =3D APCS_GPLL7_STATUS,
>> +	.status_bit =3D BIT(31),
>> +	.ena_vote =3D APCS_GPLLX_ENA_REG,
>> +	.vote_bit =3D BIT(7),
>> +};
>> +
>> +static ulong sm6350_set_rate(struct clk *clk, ulong rate)
>> +{
>> +	struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
>> +	const struct freq_tbl *freq;
>> +
>> +	if (clk->id < priv->data->num_clks)
>> +		debug("%s: %s, requested rate=3D%ld\n", __func__,
>> +		      priv->data->clks[clk->id].name, rate);
>> +
>> +	switch (clk->id) {
>> +	case GCC_QUPV3_WRAP1_S3_CLK: /*UART9*/
>> +		freq =3D qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
>> +		clk_rcg_set_rate_mnd(priv->base, GCC_SE12_UART_RCG_REG,
>> +				     freq->pre_div, freq->m, freq->n, freq->src,
>> +				     16);
>> +
>> +		return freq->freq;
>> +	case GCC_SDCC2_APPS_CLK:
>> +		/* Enable GPLL7 so that we can point SDCC2_APPS_CLK_SRC at it */
>> +		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
>> +		freq =3D qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
>> +		printf("%s: got freq %u\n", __func__, freq->freq);
>> +		WARN(freq->src !=3D CFG_CLK_SRC_GPLL7,
>> +		     "SDCC2_APPS_CLK_SRC not set to GPLL7, requested rate %lu\n",
>> +		     rate);
>
> Why not enabling GPLL7 only if freq->src =3D=3D CFG_CLK_SRC_GPLL7 ??

I honestly just copy-pasted this part, I didn't think too much about
this code. But also doesn't the code do the wrong thing when pointing to
any freq apart from 202 MHz? The warn and the clk_rcg_set_rate_mnd call
below will complain about/set the wrong parent?

Seems that construct is in clock drivers for qcm2290, sm6115 and sm8250.

Also other clk drivers like clock-sc7280.c don't have any set_rate
handling for this clock either and SD card supposedly works fine on the
Shiftphone 8.
=20
>
> Apart that, looks good :-)
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks!

Regards
Luca
