Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF30E7718A
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 22:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A17480304;
	Wed, 18 Dec 2024 23:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="WHWp3otD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 396F08021D; Wed, 18 Dec 2024 23:44:50 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1608022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 23:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20241218224444epoutp04d663cae0e029c97244a93e1509a1f9d3~SZtf0yJfs1950019500epoutp04t
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 22:44:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20241218224444epoutp04d663cae0e029c97244a93e1509a1f9d3~SZtf0yJfs1950019500epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1734561884;
 bh=ZXeD63SqrKuaFqzFIBpFrXI6JhpO6khUNqYJa6Hoh6Q=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=WHWp3otDlQYBR1VSDTr1NNlAH3wz2SJYwvsf6xnh2Cvf5UUWFO4opIIlwJxZ93rfc
 C83j9t8Y95iG+TogkKSinyow/j7+nWQJnt09z1hpVTD/t2K4k+Us6E3wJti0sFpvnz
 r4UC/IY3E4WGK8zmvjaTHdeLIA5lEOi6OmokuybM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20241218224443epcas1p2cca3b575a62f221433056916fcd121dd~SZtffvQK91857518575epcas1p2b;
 Wed, 18 Dec 2024 22:44:43 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.145]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4YD7zG6hLjz4x9Px; Wed, 18 Dec
 2024 22:44:42 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A0.3B.21650.A5053676; Thu, 19 Dec 2024 07:44:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20241218224441epcas1p1bbae21289af09be67221e080b92b7504~SZtdfnH3d2006520065epcas1p1c;
 Wed, 18 Dec 2024 22:44:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241218224441epsmtrp195dd49d2c7e9452be524346890db2d39~SZtde9Jr-0409604096epsmtrp1H;
 Wed, 18 Dec 2024 22:44:41 +0000 (GMT)
X-AuditID: b6c32a35-093de70000005492-dd-6763505a0f12
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BC.58.18949.95053676; Thu, 19 Dec 2024 07:44:41 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241218224441epsmtip2b0d006e70dfc9fb8d03ef967b9b34e7c~SZtdT8xzv2194921949epsmtip2W;
 Wed, 18 Dec 2024 22:44:41 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Shree Ramamoorthy'" <s-ramamoorthy@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
Cc: <m-leonard@ti.com>, <praneeth@ti.com>
In-Reply-To: <20241218171236.1022565-3-s-ramamoorthy@ti.com>
Subject: RE: [PATCH v1 2/2] power: replace magic numbers with macros
Date: Thu, 19 Dec 2024 07:44:41 +0900
Message-ID: <01e401db519e$6d116220$47342660$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQDJjZr8Ya4lM0w/UNXlTz8OpdnKCAFA/cSAAi20pJa09Knc4A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmgW5UQHK6wb/nBhYPt89jsfjz6CWb
 xa9D65ktpk7azG7xdm8nuwOrx6sDq9g9zt7Zwehx/MZ2pgDmqGybjNTElNQihdS85PyUzLx0
 WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCdSgpliTmlQKGAxOJiJX07m6L80pJU
 hYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjFnzOQoOylXsOvSbsYHxhEQX
 IyeHhICJxP7+DvYuRi4OIYEdjBIbN6xghXA+MUpsPXCdEcL5xijR/HMXM0zLhRv/mCESexkl
 Njz7CNX/klGiZ8VtdpAqNgE9if+LFoJ1iAgkSPzZdJsJxGYW0JTYs30jC4jNKWAj8WnlB6B6
 Dg5hAReJR5sCQMIsAqoSfV3zWUFsXgFLiZuPtjBCLFaQ+Pl0GSvEGBGJ2Z1tUOOdJM5cfc0C
 coOEwCl2iU8n+1ghGlwkjh3cwg5hC0u8Og5jS0m87G9jh2hoZpRYuuQgK4TTwyjxr+E6G0SV
 scT+pZOZQK4DuXr9Ln2IzXwS7772sIKEJQR4JTrahCCqVSQuvX7JBDP/7pP/UDd4SJztXM0C
 CaCDjBLvmncyTWCUn4XkiVkIGxYwMq1iFEstKM5NTy02LDCER2Vyfu4mRnBi0zLdwTjx7Qe9
 Q4xMHIyHGCU4mJVEeN00E9OFeFMSK6tSi/Lji0pzUosPMZoCg3Iis5Rocj4wteaVxBuaWBqY
 mBkZm1gYmhkqifOeuVKWKiSQnliSmp2aWpBaBNPHxMEp1cDkVnj9Zmz6dl39M+s3xNxiX3ru
 XkGuzdzFd2/oryuu+DDb42zgNw6D3+ZMBaXOJ1W11m8/cmLyQcsv68+tEtXINZp9ybk1KzzK
 SXbGebkpHPU/jfvq+w8YfmDft3nv1D35550NGP+GPy95zFcvK30tfSM3T0vWhU1bttv93+G5
 OdB1/2bG+KUbi1oLitkFBS/wffgkW/M47dOUwnm1N4u4giRusNc8uT3l3Z+nfyrZmTYs+KIr
 HnV0bbS4zKRuxmS53gNN8uvLGu8c2/dYp3K/i4fLMqmTR88fF/70Q2H7s47J63/0fxPJCL4x
 i91/puhZ9iSGzyc1lK/lTy12mzCtZdOf9z/vazOyJ+2W/632TYmlOCPRUIu5qDgRAETl9Br1
 AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSvG5kQHK6wbZZqhYPt89jsfjz6CWb
 xa9D65ktpk7azG7xdm8nuwOrx6sDq9g9zt7Zwehx/MZ2pgDmKC6blNSczLLUIn27BK6MWfM5
 Cg7KVew69JuxgfGERBcjJ4eEgInEhRv/mLsYuTiEBHYzSmyYd5oNIiEl8fnpVCCbA8gWljh8
 uBii5jmjxJWVu5lAatgE9CT+L1rIDFIjIpAkcWJzLUiYWUBbontRByNE/V5GiUNXT7OCJDgF
 bCQ+rfzADlIvLOAi8WhTAEiYRUBVoq9rPlgJr4ClxM1HWxghTlCQ+Pl0GSvETBGJ2Z1tzCC2
 iICTxJmrr1kmMArMQpJawMi4ilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOCS1tHYw
 7ln1Qe8QIxMH4yFGCQ5mJRFeN83EdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK83173pggJpCeW
 pGanphakFsFkmTg4pRqYDgirTshXNze1cmKY/m+R5u3Q1yl7Slkks3XETgn59q4t2iHFEPBN
 2y4r90l0Y/zdmCqdKMlird6shzML1gh+uqRwdW7y57MSMb2iqy2LT7wNv6ghs6ZHT2ve3VP+
 22872BsnTr71sOLyyoXNUbe+xlfNnWp3RGfHlCOPNQ4EPD/qsWUi+14m7Q6f5V9q1qt+4O7d
 klHd1/nxVIe23DIW1dAJNyOajcOnPQx18Fqu6p16P+nLHtXoZzrzfU5IrS9xPHDnVsaKBvX+
 A0WVAV3pW6OW9EQGzY5s/e1V33VgZkame0bq3HsVrx9N4pBfdj971a+UdVMD1DgdYg3iFYUP
 HNCQvMjv6VoqnfFaSlqJpTgj0VCLuag4EQBMKrQ7uAIAAA==
X-CMS-MailID: 20241218224441epcas1p1bbae21289af09be67221e080b92b7504
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241218171243epcas1p1071f30015793a4317dfb47c70b99dacf
References: <20241218171236.1022565-1-s-ramamoorthy@ti.com>
 <CGME20241218171243epcas1p1071f30015793a4317dfb47c70b99dacf@epcas1p1.samsung.com>
 <20241218171236.1022565-3-s-ramamoorthy@ti.com>
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

Hi,

> -----Original Message-----
> From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> Sent: Thursday, December 19, 2024 2:13 AM
>
> Replace magic numbers in buckval2votl() & buckvolt2val() with macros to
> help with clarity and correlate what the numbers correspond to in the
> TPS65219 datasheet.
>
> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> ---
>  drivers/power/regulator/tps65219_regulator.c | 26 ++++++++++----------
>  include/power/tps65219.h                     | 14 +++++++++--
>  2 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/power/regulator/tps65219_regulator.c
> b/drivers/power/regulator/tps65219_regulator.c
> index 4b0fb205909a..88abc896b3a2 100644
> --- a/drivers/power/regulator/tps65219_regulator.c
> +++ b/drivers/power/regulator/tps65219_regulator.c
> @@ -72,12 +72,12 @@ static int tps65219_buck_enable(struct udevice *dev, int op, bool *enable)
>
>  static int tps65219_buck_volt2val(int uV)
>  {
> -	if (uV > TPS65219_BUCK_VOLT_MAX)
> +	if (uV > TPS65219_BUCK_3V4)
>  		return -EINVAL;
> -	else if (uV >= 1400000)
> -		return (uV - 1400000) / 100000 + 0x20;
> -	else if (uV >= 600000)
> -		return (uV - 600000) / 25000 + 0x00;
> +	else if (uV >= TPS65219_BUCK_1V4)
> +		return (uV - TPS65219_BUCK_1V4) / TPS65219_VOLT_STEP_100MV + TPS65219_BUCK_REG_1V4;

Even though Not relevant to this subject. If uV is 340000, the return value is correct?

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> +	else if (uV >= TPS65219_BUCK_0V6)
> +		return (uV - TPS65219_BUCK_0V6) / TPS65219_VOLT_STEP_25MV + TPS65219_BUCK_REG_0V6;
>  	else
>  		return -EINVAL;
>  }
> @@ -86,12 +86,12 @@ static int tps65219_buck_val2volt(int val)
>  {
>  	if (val > TPS65219_VOLT_MASK)
>  		return -EINVAL;
> -	else if (val > 0x34)
> -		return TPS65219_BUCK_VOLT_MAX;
> -	else if (val > 0x20)
> -		return 1400000 + (val - 0x20) * 100000;
> -	else if (val >= 0)
> -		return 600000 + val * 25000;
> +	else if (val > TPS65219_BUCK_REG_3V4)
> +		return TPS65219_BUCK_3V4;
> +	else if (val > TPS65219_BUCK_REG_1V4)
> +		return TPS65219_BUCK_1V4 + (val - TPS65219_BUCK_REG_1V4) * TPS65219_VOLT_STEP_100MV;
> +	else if (val >= TPS65219_BUCK_REG_0V6)
> +		return TPS65219_BUCK_0V6 + val * TPS65219_VOLT_STEP_25MV;
>  	else
>  		return -EINVAL;
>  }
> @@ -161,7 +161,7 @@ static int tps65219_ldo_volt2val(int idx, int uV)
>  	if (uV > max)
>  		return -EINVAL;
>  	else if (uV >= base)
> -		return (uV - TPS65219_LDO12_VOLT_MIN) / 50000;
> +		return (uV - TPS65219_LDO12_VOLT_MIN) / TPS65219_VOLT_STEP_50MV;
>  	else
>  		return -EINVAL;
>  }
> @@ -187,7 +187,7 @@ static int tps65219_ldo_val2volt(int idx, int val)
>  	else if (val <= reg_base)
>  		return base;
>  	else if (val >= 0)
> -		return TPS65219_LDO12_VOLT_MIN + (50000 * val);
> +		return TPS65219_LDO12_VOLT_MIN + (TPS65219_VOLT_STEP_50MV * val);
>  	else
>  		return -EINVAL;
>  }
> diff --git a/include/power/tps65219.h b/include/power/tps65219.h
> index aa81b92266fd..e8780af2d811 100644
> --- a/include/power/tps65219.h
> +++ b/include/power/tps65219.h
> @@ -17,10 +17,20 @@
>  #define TPS65219_BUCK_DRIVER		"tps65219_buck"
>
>  #define TPS65219_VOLT_MASK		0x3F
> -#define TPS65219_BUCK_VOLT_MAX		3400000
> -
>  #define TPS65219_ENABLE_CTRL_REG	0x2
>
> +#define TPS65219_VOLT_STEP_25MV		25000
> +#define TPS65219_VOLT_STEP_50MV		50000
> +#define TPS65219_VOLT_STEP_100MV	100000
> +
> +#define TPS65219_BUCK_0V6		600000
> +#define TPS65219_BUCK_1V4		1400000
> +#define TPS65219_BUCK_3V4		3400000
> +
> +#define TPS65219_BUCK_REG_0V6		0x00
> +#define TPS65219_BUCK_REG_1V4		0x20
> +#define TPS65219_BUCK_REG_3V4		0x34
> +
>  #define TPS65219_BUCK1_VOUT_REG		0xa
>  #define TPS65219_BUCK2_VOUT_REG		0x9
>  #define TPS65219_BUCK3_VOUT_REG		0x8
> --
> 2.34.1



