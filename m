Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87450D58060
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 11:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C3F89A37;
	Mon, 25 Nov 2024 12:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="KaRF1bcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA9A89A39; Mon, 25 Nov 2024 12:00:37 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97E889441
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20241125110029epoutp0140b18689c4a3fe0f2d5c6a29c20d8d54~LMRCcwiGZ1014910149epoutp01u
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:00:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20241125110029epoutp0140b18689c4a3fe0f2d5c6a29c20d8d54~LMRCcwiGZ1014910149epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1732532429;
 bh=JV8TCGVhhrLHbTcJjRWNWg0ovtjnIgqgAuxe20wEsoc=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=KaRF1bcBORK6PAcEOiM7ZhlziOquIjYn5sL0fVC0mgY7CV7YGRpubdi43msoLSYC1
 l7Uqr8OD72To19bJj64ja1fSP6eIZBL5eAVKRD+bnSsPuZy8AcS5bQgl1ZCBBdJMK5
 3SLoUyztJCxBDfuqvCtvzMnUApPfEwYSoBoawOMI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20241125110028epcas1p3645d67a2a29fbaf71e0a38b5056e85ac~LMRCE8ytw1377013770epcas1p3I;
 Mon, 25 Nov 2024 11:00:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.236]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4XxjRH5Dykz4x9Pr; Mon, 25 Nov
 2024 11:00:27 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 4D.86.09398.BC854476; Mon, 25 Nov 2024 20:00:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20241125110027epcas1p30a877c25191eb173a02106be4c2c9059~LMRA4wsMe1152211522epcas1p3A;
 Mon, 25 Nov 2024 11:00:27 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241125110027epsmtrp22ecfa26392be402e642320d221556786~LMRA4EVBh0562405624epsmtrp2i;
 Mon, 25 Nov 2024 11:00:27 +0000 (GMT)
X-AuditID: b6c32a39-c3139a80000024b6-be-674458cbc3c4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 4A.C2.18937.BC854476; Mon, 25 Nov 2024 20:00:27 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241125110027epsmtip248e91f759958b127f61b83db9144cea3~LMRAsIl_13136331363epsmtip2t;
 Mon, 25 Nov 2024 11:00:27 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Neil Armstrong'" <neil.armstrong@linaro.org>, "'Caleb Connolly'"
 <caleb.connolly@linaro.org>, "'Sumit Garg'" <sumit.garg@linaro.org>, "'Tom
 Rini'" <trini@konsulko.com>
Cc: <u-boot-qcom@groups.io>, <u-boot@lists.denx.de>
In-Reply-To: <20241125-topic-hamoa-pmc8380-rpmh-regulators-v1-1-695c44ea8586@linaro.org>
Subject: RE: [PATCH] regulator: qcom-rpmh-regulator: add support for pmc8380
 regulators
Date: Mon, 25 Nov 2024 20:00:26 +0900
Message-ID: <03b101db3f29$3c0f3440$b42d9cc0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQLWmNFehZQWC3ro8rWFz6HJ5nCtlAJKLcw4sL7OZYA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmru7pCJd0g817VSxOtWxjsni/8xaj
 xbp9fWwWUydtZrdo2jKL1eLt3k52BzaP+Z3fmTxeHVjF7nHn2h42j7N3djAGsERl22SkJqak
 Fimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAbVdSKEvMKQUKBSQW
 Fyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX5qXr5aWWWBkaGBiZAhUmZGd0v/3KWLBf
 tGLPox2sDYxrhboYOTkkBEwkFjX+YAaxhQR2MEoc/KXZxcgFZH9ilLh1/wornDPj+2MmmI7m
 nzOZIBI7GSX+fPrNDtH+klHi4mx9EJtNQE/i/6KFzCBFIgIbGSUe7/oEVsQsYCzx++Utli5G
 Dg5OgQiJzl0SIGFhgUiJli/TwUpYBFQlDt88BbaMV8BS4nd3OxvEYgWJn0+XsUKMEZGY3dkG
 draIgJXE4QkLwS6VELjGLnH25ymoBheJb+e6oa4Wlnh1fAs7hC0l8fndXjaIhmZGiaVLDkJ1
 9zBK/Gu4DtVtLLF/6WQmkEuZBTQl1u/Sh9jMJ/Huaw8rSFhCgFeiow0ajioSl16/ZIKZf/fJ
 f1YI20PiZd9eRkhorWaUePj+BtsERvlZSJ6YhbBhASPTKkax1ILi3PTUYsMCU3hUJufnbmIE
 Jzstyx2M099+0DvEyMTBeIhRgoNZSYSXT9w5XYg3JbGyKrUoP76oNCe1+BCjKTAoJzJLiSbn
 A9NtXkm8oYmlgYmZkbGJhaGZoZI475krZalCAumJJanZqakFqUUwfUwcnFINTCllBcaTlq9J
 4Zuq2qWe9+3AhMJJU4P6i5a+ZHuoIPmGt/nLfAPznrt9c9R4Fusv35I96evLmbN9PyTb7FH2
 a1P+HGvnE+YidmlnhLxC6uN3zxX+BTrNvNsoMcvO9s7/M1frsyZdtd6lYHV9+aYbMTuPBGj9
 3DejvEDa7ujch6fSDsfU7whfN0NqxfTYhWtWr2XpDDs+RW5lpZf9o9S5K48wbrSYe32716He
 G9lZoXEXGCV/xv2+5BW3cdrXKzGeAhlbfpZY2wSsa/AqrfyZfmtfIo/PrP933C7xaPfs6aoI
 6z+nNYEzWIVRIGCCrBDnw/dCG7e9mLNv63IBY8Xcplf98u/tmboOKzHucdgbelaJpTgj0VCL
 uag4EQDL6A5W/wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSvO7pCJd0g0szhS1OtWxjsni/8xaj
 xbp9fWwWUydtZrdo2jKL1eLt3k52BzaP+Z3fmTxeHVjF7nHn2h42j7N3djAGsERx2aSk5mSW
 pRbp2yVwZXS//cpYsF+0Ys+jHawNjGuFuhg5OSQETCSaf85k6mLk4hAS2M4o8fncDDaIhJTE
 56dTgWwOIFtY4vDhYoia54wSR14eYQSpYRPQk/i/aCEzSEJEYDOjRNvDLrBmZgFTiZn/t7FC
 dKxklHhz+Dg7yCROgQiJzl0SIDXCAuESpy98ZQWxWQRUJQ7fPMUEYvMKWEr87m6HOkJB4ufT
 ZawQM0UkZne2MYPYIgJWEocnLGSdwCgwC0lqASPjKkbR1ILi3PTc5AJDveLE3OLSvHS95Pzc
 TYzgINUK2sG4bP1fvUOMTByMhxglOJiVRHj5xJ3ThXhTEiurUovy44tKc1KLDzFKc7AoifMq
 53SmCAmkJ5akZqemFqQWwWSZODilGpgqXf8uYhB4K3d7trjyzyiN/Vc5mn8FRrFpuD0LVg92
 US4y5gu8fUB1yV2b8vrL5VK+Oe/W9Xj3rP0Sstm0//p5x7p85SCZWdF8s38muwo5nHFnm39G
 YfGUDl2uye4/RVeyxZ+uuHfv08OFD6+em9R49F+fx04Fk1xTpq8617Pbk74d37HP4Vun37Mz
 WmXJ94I7X/mvDZuSMTPg1Pd3P7sP886+scYvuOLyhsKJ3bqHHvxjTujI+/V534TwjAOcU9SX
 fJy71GrF/lm3Zvu/CtnN4FkhuLHm4sMlp7fOdrjt05jE1X5BcoKR69NVdf5fdFumaPlH3Am0
 fLC42NJZabOJem7WpXn9ErdcUnhXVu5VYinOSDTUYi4qTgQAbn34QcECAAA=
X-CMS-MailID: 20241125110027epcas1p30a877c25191eb173a02106be4c2c9059
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241125082454epcas1p34e985704b3a152b589a57954976db4ed
References: <CGME20241125082454epcas1p34e985704b3a152b589a57954976db4ed@epcas1p3.samsung.com>
 <20241125-topic-hamoa-pmc8380-rpmh-regulators-v1-1-695c44ea8586@linaro.org>
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



> -----Original Message-----
> From: Neil Armstrong <neil.armstrong@linaro.org>
> Sent: Monday, November 25, 2024 5:25 PM
> To: Jaehoon Chung <jh80.chung@samsung.com>; Caleb Connolly <caleb.connolly@linaro.org>; Sumit Garg
> <sumit.garg@linaro.org>; Tom Rini <trini@konsulko.com>
> Cc: u-boot-qcom@groups.io; u-boot@lists.denx.de; Neil Armstrong <neil.armstrong@linaro.org>
> Subject: [PATCH] regulator: qcom-rpmh-regulator: add support for pmc8380 regulators
>
> Add the PMC8380 regulator data found on the Snapdragon X Elite platforms.
> The tables are imported from the Linux driver.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/regulator/qcom-rpmh-regulator.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-
> regulator.c
> index 2dc261d83e3727a5b2f72a5d13c1ef17a9677a8c..70df51b5fa4ee4001b7eff6facc80957ada84391 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -536,6 +536,21 @@ static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
>  	{}
>  };
>
> +static const struct rpmh_vreg_init_data pmc8380_vreg_data[] = {
> +	RPMH_VREG("smps1", "smp%s1", &pmic5_ftsmps525_lv, "vdd-s1"),
> +	RPMH_VREG("smps2", "smp%s2", &pmic5_ftsmps525_lv, "vdd-s2"),
> +	RPMH_VREG("smps3", "smp%s3", &pmic5_ftsmps525_lv, "vdd-s3"),
> +	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_mv, "vdd-s4"),
> +	RPMH_VREG("smps5", "smp%s5", &pmic5_ftsmps525_lv, "vdd-s5"),
> +	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
> +	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
> +	RPMH_VREG("smps8", "smp%s8", &pmic5_ftsmps525_lv, "vdd-s8"),
> +	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo515,   "vdd-l1"),
> +	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo515,   "vdd-l2"),
> +	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo515,   "vdd-l3"),
> +	{}
> +};
> +
>  /* probe an individual regulator */
>  static int rpmh_regulator_probe(struct udevice *dev)
>  {
> @@ -662,6 +677,10 @@ static const struct udevice_id rpmh_regulator_ids[] = {
>  		.compatible = "qcom,pm8550vs-rpmh-regulators",
>  		.data = (ulong)pm8550vs_vreg_data,
>  	},
> +	{
> +		.compatible = "qcom,pmc8380-rpmh-regulators",
> +		.data = (ulong)pmc8380_vreg_data,
> +	},
>  	{ /* sentinal */ },
>  };
>
>
> ---
> base-commit: 7fe55182d9263a62e18b450c97bdf0b8031e5667
> change-id: 20241125-topic-hamoa-pmc8380-rpmh-regulators-2b9460fcd7bd
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>



