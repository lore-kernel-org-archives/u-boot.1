Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B343D2E9D0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 09:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E628931A;
	Mon, 11 Nov 2024 10:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hHAIQdho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E618934F; Mon, 11 Nov 2024 10:56:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCED28930E
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 10:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731318991; x=1731923791; i=xypron.glpk@gmx.de;
 bh=aPLoAqA3JZYG1NW55aR9J2pgrWBk2jAcGz0zTq9UsKs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hHAIQdho+IvHuztmKVGOcCIHPuF9Ts+JTUff7D5oEx9gbOQbk0QutLlGNcbEkoQz
 MB//XhgT8Gln1EAIFMzwemSB9uys/nDsKDyW05L/7o5cNxKAmwmrIZrUABoGd0CuL
 stibh1AwVFlqkkLCCVrol6kR8EwQXspCFIKPCZblJy5njEzM4KLBRYKuZpdHn+uOM
 1wVGcnVAAgUE99PmpZGyFLxSIruivN2Mtt/eHNzasMcmHlyEeT6Ihq5xZSy6U8Dyt
 bGcKgFqHHM0IrgPLoxPPztgMJCXlFIdSrHH/843af5dQSbihoXcNNw/iWzIlnd1RS
 Ni8FVbPluIOQ8sH+og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1t2Dxl110c-00Bs6g; Mon, 11
 Nov 2024 10:56:31 +0100
Message-ID: <75aab841-5e11-46b1-b747-59059a7fc4cd@gmx.de>
Date: Mon, 11 Nov 2024 10:56:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] dts: starfive: Switch to using upstream DT
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
 <20241111020808.38974-2-hal.feng@starfivetech.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241111020808.38974-2-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:npLqEKPj2HZnToo7QGNdO5jn/9MAh0Fkv2KK3mnm8SXpuDbPJ2o
 d3q7M8zEGvKRoqzmK3dRQEnEu7NnY6r9TjSffJkQ+5wnlxVRLe2n/62fjHBg0gitrOLklEF
 msuiBBtPAvYOT3XX6u7syHL8MOMsKP0s3cyYuz8RPa2eDI8SOD/iPPBjXUVo23JhYtj9DKU
 PYZ/hA6gVCJn86aacUXAA==
UI-OutboundReport: notjunk:1;M01:P0:BT2blKjgOYA=;ZIjN5riItERJLA33AY8cg4SNSRo
 SqeBSQxJZRZFdw09RzOD5+kCgP+r7L+zmMlQ8X9a/id0lToDuISAz3QE33TJDv/O5re/RNV/c
 mu7aj/m45BYPTKNbs03Cq2TDc7TK4174kOf4alFyU4SN7lVS1Tu8jLmX+lIwA2x0Yf0e5peiz
 jCAhOhB/kBjFrLexEVizfFXJeOt7XwQsMrngL6/nrY+ndKjHG+FE4LaoAnsy5L2aAbeF0XmOu
 f4mkBO1gj6HSweGrsnRVo627jOVZhpzUvBU9ExStlZcuOU/N2F4OfSzcVG5NIeytd0UWkwopk
 jlNcIAAicci9tukZYhqjE7sAPVi7yiZ49xThHzyxGDwSD2ZEyBcJdL/kVXMW7rMJINUUSqxXc
 wACAgPFdVmslZu40OTNSFGwzjqLjNeh/qMY1A/MvvnnssMsVsOXS2R8F5k3rjxpA2B+GbrELA
 4lbqiOiQwzRrujxbk7ut1qH286sS1UQT+npX5zzm+Y+aE23IphuTjoz02YpBRKbJQLVWblVWd
 fd9k7eGioEeRlXMASbYXjtSaForgmcH8kQKX3oRPhEC9NmHfimNYh1PjoArotyRxelb27qCRV
 iKuLrsNhGBdeqakJbin0KMwmNSpfJoekY2DwMCcioaNLuAnFM94gH0okZQd0f9FsoZ98aR7kF
 r5XZL+iU8v2nYQMZd8r8736eT/qmWz/KyA4ic2Z0eGMu3yyRUtg4JzIZTnJBFwQ+2Nkj22gKU
 o78ZOyMFTMsuqrA6t5/skKDVfbda+Kp5cUvTwQSB06cW0FjJ1kWo0y14MkAsBbJYITVJ/RCID
 oJQbGavgkJY5MpE5asHB3ujthv85LrISXyQ89HXbmHcKj6bsHbfgkBruGhKrcHnpiLWNd8Jou
 5qsgjnagVlYQ6YqM9pfuf2oHTwuKhwxVmMhCXUZMIoljlZOsoNWUFtIv8
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

On 11/11/24 03:07, Hal Feng wrote:
> Enable OF_UPSTREAM to use upstream DT and add starfive/ prefix to
> the DEFAULT_DEVICE_TREE. Rename jh7110-starfive-visionfive-2-u-boot.dtsi
> to jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi and set
> the v1.3b device tree as the default device tree.
>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>   arch/riscv/cpu/jh7110/Kconfig                                   | 1 +
>   ...boot.dtsi =3D> jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} | 0
>   configs/starfive_visionfive2_defconfig                          | 2 +-
>   3 files changed, 2 insertions(+), 1 deletion(-)
>   rename arch/riscv/dts/{jh7110-starfive-visionfive-2-u-boot.dtsi =3D> j=
h7110-starfive-visionfive-2-v1.3b-u-boot.dtsi} (100%)
>
> diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconf=
ig
> index e5549a01b8..9904a60ddd 100644
> --- a/arch/riscv/cpu/jh7110/Kconfig
> +++ b/arch/riscv/cpu/jh7110/Kconfig
> @@ -19,6 +19,7 @@ config STARFIVE_JH7110
>   	imply MMC
>   	imply MMC_BROKEN_CD
>   	imply MMC_SPI
> +	imply OF_UPSTREAM

IIRC the imply statement should be sorted in the sequence of appearance
in .config to avoid dependency issues. In a follow up patch to this
series you might want to sort the whole list of imply statements
accordingly.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>   	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
>   	imply SIFIVE_CACHE
>   	imply SIFIVE_CCACHE
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi b/a=
rch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> similarity index 100%
> rename from arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
> rename to arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_v=
isionfive2_defconfig
> index 11e1332f87..40f553816e 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -9,7 +9,7 @@ CONFIG_SF_DEFAULT_SPEED=3D100000000
>   CONFIG_ENV_SIZE=3D0x10000
>   CONFIG_ENV_OFFSET=3D0xf0000
>   CONFIG_SPL_DM_SPI=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"jh7110-starfive-visionfive-2"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"starfive/jh7110-starfive-visionfive-2-v1.=
3b"
>   CONFIG_SPL_TEXT_BASE=3D0x8000000
>   CONFIG_OF_LIBFDT_OVERLAY=3Dy
>   CONFIG_DM_RESET=3Dy

