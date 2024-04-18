Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5C1C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 00:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C42CA884F0;
	Thu, 18 Apr 2024 02:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="sX2EOvxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ABA2884F3; Thu, 18 Apr 2024 02:22:54 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A783882C4
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240418002243epoutp02f080bb9a49225b31aaa9a289cd93481b~HOAHMbrcF1991019910epoutp02S
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 00:22:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240418002243epoutp02f080bb9a49225b31aaa9a289cd93481b~HOAHMbrcF1991019910epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713399763;
 bh=VfNRnbvCpDL1Jj3oyi588vt8LZHuPDLmCRYqBQtjHLo=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=sX2EOvxvA286zA65mJN0wGX3Anic0KbvmJHEJKutEIHd3rW30dwDJFucPqiKBhoCJ
 e9nHVV+MPrkfK6/DVdIzcDyTh/XL+bvAId6kZv0+ZFOGd6vOAtdSAPuZpFSMvBv04i
 7fpwT3ZAuo5V655SGm4NP4WtwR0r5bgclZ4IDGMc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240418002243epcas1p1abc14a83e2750636490c6800f0adb19a~HOAG0DSY51558915589epcas1p1t;
 Thu, 18 Apr 2024 00:22:43 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.145]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VKdlP67kNz4x9QK; Thu, 18 Apr
 2024 00:22:41 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 BD.98.19431.1D760266; Thu, 18 Apr 2024 09:22:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20240418002241epcas1p385b0c21d9c462dc487c4fe60d62fe6ae~HOAFKZyMj3066430664epcas1p3-;
 Thu, 18 Apr 2024 00:22:41 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240418002241epsmtrp110b09fbab394977332b709bcc4961cb4~HOAFJvU3l1254412544epsmtrp1P;
 Thu, 18 Apr 2024 00:22:41 +0000 (GMT)
X-AuditID: b6c32a4c-1d1ff70000004be7-88-662067d1c2b4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A8.6E.19234.1D760266; Thu, 18 Apr 2024 09:22:41 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240418002241epsmtip19060a98c20982b3c927168817f6ed8b5~HOAE3fVys3104631046epsmtip1O;
 Thu, 18 Apr 2024 00:22:41 +0000 (GMT)
Message-ID: <d25ff430-522b-4ddb-92b9-1d7dd5298acc@samsung.com>
Date: Thu, 18 Apr 2024 09:22:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 4/5] power: regulator: tps65941: use function
 callbacks for conversion ops
To: Bhargav Raviprakash <bhargav.r@ltts.com>, u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, m.nirmaladevi@ltts.com,
 sjg@chromium.org, trini@konsulko.com
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240318094925.374959-5-bhargav.r@ltts.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmge7FdIU0g30bdS02zz/IbNGy1sPi
 w7xWdouP29+zW3zbso3RYuqkzewWb/d2sjuwe8xuuMji8erAKnaPO9f2sHmcvbOD0ePrpk2s
 HsdvbGcKYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
 y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVo
 YGBkClSYkJ3R3dfBWPBBo2Llo6AGxnUKXYycHBICJhIfVvxj7mLk4hAS2MMo8eTaEkYI5xOj
 RF/ffTY458Pl1yxdjBxgLbt/WkDEdzJKHD0wjQnCec8ocXbxYTaQubwCdhI7nzWC2SwCqhLP
 t9yDigtKnJz5hAXEFhWQl7h/awY7yFBhgSyJm/+KQcIiAk4SX0+2soPYzALZEhPn32aCsMUl
 bj2ZD2azCehIbP92HMzmFLCUWHtqERtEjbzE9rdzwN6REOjlkLjW9JIJ4k8XiSk/D0DZwhKv
 jm9hh7ClJF72t7FDNDQzSixdcpAVwulhlPjXcJ0NospYYv/SyUwglzILaEqs36UPsY1P4t3X
 HlZIqPBKdLQJQVSrSFx6DbNXSuLuk/+sELaHxPT2BayQwNrNKHFk4n32CYwKs5DCZRaSR2ch
 eWgWwuYFjCyrGKVSC4pz01OTDQsMdfNSy+Exnpyfu4kRnFa1fHYwfl//V+8QIxMH4yFGCQ5m
 JRHeFmHZNCHelMTKqtSi/Pii0pzU4kOMpsAYmsgsJZqcD0zseSXxhiaWBiZmRsYmFoZmhkri
 vGeulKUKCaQnlqRmp6YWpBbB9DFxcEo1MPW/S0lKWi/eaavww4B7O3e6lXPb7Xfc8sHPVh8K
 vcvA3LG0pdlg5wMR/hOSzI4p66XuKku9m3BJoOZXgW+1H29dFdPWaeu+di1L+x04KfL5zK+z
 Oq+fygsRLp8mtOba/be7RcqTjK9OOuFyp/twQ9J1seVRl9Y+2PjvqMKMKUb7+R497e/p/WC8
 dO3mR/w8ct/jJgbO9lwpuO3BpY4dG47Y+Wqlvd0+saV24e0Ap6JFvdrp//yEKtd/f+z/iHHP
 qjive7vObdlgbxGVdtDtkm5y1GrFb2b+JQysVyYvX2oSWG5+9f5TVuOGE/PuTNcwevvd6Yga
 n1m4MFfDZ+aWlZeqJ2QHBJ53fHr43/xnArxKLMUZiYZazEXFiQA/nakONAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSnO7FdIU0g0XtYhab5x9ktmhZ62Hx
 YV4ru8XH7e/ZLb5t2cZoMXXSZnaLt3s72R3YPWY3XGTxeHVgFbvHnWt72DzO3tnB6PF10yZW
 j+M3tjMFsEVx2aSk5mSWpRbp2yVwZXT3dTAWfNCoWPkoqIFxnUIXIweHhICJxO6fFl2MXBxC
 AtsZJY4dfMHSxcgJFJeS+Px0KhtEjbDE4cPFEDVvGSUmz5zHClLDK2AnsfNZIxuIzSKgKvF8
 yz02iLigxMmZT8DmiArIS9y/NYMdZI6wQJbEzX/FIGERASeJrydbwcLMAtkSl5oTQcJCAukS
 t9e3MYLYzALiEreezGcCsdkEdCS2fzsOZnMKWEqsPbWIDaJVXWL9PCGIcnmJ7W/nME9gFJqF
 5IZZSCbNQuiYhaRjASPLKkbR1ILi3PTc5AJDveLE3OLSvHS95PzcTYzgWNEK2sG4bP1fvUOM
 TByMhxglOJiVRHhbhGXThHhTEiurUovy44tKc1KLDzFKc7AoifMq53SmAL2SWJKanZpakFoE
 k2Xi4JRqYFJ+VSMZ+uRLlpqB//kTk/sdg7vLumQ+PNiVJJT+b+m6q4c6PklWK3hMuvu8zCRV
 /1TzcU/jVGeX/f73Xs/n5Py2cE/kvImKt2ff3PHoy5btbPI+LQfE531fd8sl+oBtSdmilWIu
 SvF1bw99Spz1rE4hsVL/xYyipbfZjz1laOMsuOi45su/0OV3jmhdPec/sVJfx2tP61GZYsmT
 PrfOzTEIYdvbkfHB/ornmheV1zeduPh+8h09vv7VQY6+v1VSAnR1lu9PLnA3362t8SOE40vt
 9WfJbdtUFQvZ57Yeb+xOe9f8umNpediLuNdaV1XZDdz1F764qLjojG/d5lUhHzI31k14IiR4
 4NWkKfYyDE1KLMUZiYZazEXFiQB/H7XjBAMAAA==
X-CMS-MailID: 20240418002241epcas1p385b0c21d9c462dc487c4fe60d62fe6ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240418002241epcas1p385b0c21d9c462dc487c4fe60d62fe6ae
References: <20240318094925.374959-1-bhargav.r@ltts.com>
 <20240318094925.374959-5-bhargav.r@ltts.com>
 <CGME20240418002241epcas1p385b0c21d9c462dc487c4fe60d62fe6ae@epcas1p3.samsung.com>
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

On 3/18/24 18:49, Bhargav Raviprakash wrote:
> Use function callbacks for volt2val, val2volt and slewrate lookups.
> This makes it easier to add support for TPS65224 PMIC regulators.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/regulator/tps65941_regulator.c | 61 +++++++++++++++-----
>  1 file changed, 48 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
> index cf54e30df5..d879c2301b 100644
> --- a/drivers/power/regulator/tps65941_regulator.c
> +++ b/drivers/power/regulator/tps65941_regulator.c
> @@ -35,6 +35,17 @@
>  #define TPS65941_LDO_ID_3         3
>  #define TPS65941_LDO_ID_4         4
>  
> +#define TPS65941_BUCK_CONV_OPS_IDX  0
> +#define TPS65941_LDO_CONV_OPS_IDX   0
> +
> +struct tps65941_reg_conv_ops {
> +	int volt_mask;
> +	int (*volt2val)(int idx, int uV);
> +	int (*val2volt)(int idx, int volt);
> +	int slew_mask;
> +	int (*lookup_slew)(int id);
> +};
> +
>  static const char tps65941_buck_ctrl[TPS65941_BUCK_NUM] = {0x4, 0x6, 0x8, 0xA,
>  								0xC};
>  static const char tps65941_buck_vout[TPS65941_BUCK_NUM] = {0xE, 0x10, 0x12,
> @@ -79,7 +90,7 @@ static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
>  	return 0;
>  }
>  
> -static int tps65941_buck_volt2val(int uV)
> +static int tps65941_buck_volt2val(__maybe_unused int idx, int uV)
>  {
>  	if (uV > TPS65941_BUCK_VOLT_MAX)
>  		return -EINVAL;
> @@ -95,7 +106,7 @@ static int tps65941_buck_volt2val(int uV)
>  		return -EINVAL;
>  }
>  
> -static int tps65941_buck_val2volt(int val)
> +static int tps65941_buck_val2volt(__maybe_unused int idx, int val)
>  {
>  	if (val > TPS65941_BUCK_VOLT_MAX_HEX)
>  		return -EINVAL;
> @@ -135,12 +146,25 @@ int tps65941_lookup_slew(int id)
>  	}
>  }
>  
> +static const struct tps65941_reg_conv_ops buck_conv_ops[] = {
> +	[TPS65941_BUCK_CONV_OPS_IDX] = {
> +		.volt_mask = TPS65941_BUCK_VOLT_MASK,
> +		.volt2val = tps65941_buck_volt2val,
> +		.val2volt = tps65941_buck_val2volt,
> +		.slew_mask = TP65941_BUCK_CONF_SLEW_MASK,
> +		.lookup_slew = tps65941_lookup_slew,
> +	},
> +};
> +
>  static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
>  {
>  	unsigned int hex, adr;
> -	int ret, delta, uwait, slew;
> +	int ret, delta, uwait, slew, idx;
>  	struct dm_regulator_uclass_plat *uc_pdata;
> +	const struct tps65941_reg_conv_ops *conv_ops;
>  
> +	idx = dev->driver_data;
> +	conv_ops = &buck_conv_ops[TPS65941_BUCK_CONV_OPS_IDX];
>  	uc_pdata = dev_get_uclass_plat(dev);
>  
>  	if (op == PMIC_OP_GET)
> @@ -152,8 +176,8 @@ static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret &= TPS65941_BUCK_VOLT_MASK;
> -	ret = tps65941_buck_val2volt(ret);
> +	ret &= conv_ops->volt_mask;
> +	ret = conv_ops->val2volt(idx, ret);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -175,14 +199,14 @@ static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
>  	if (slew < 0)
>  		return ret;
>  
> -	slew &= TP65941_BUCK_CONF_SLEW_MASK;
> -	slew = tps65941_lookup_slew(slew);
> +	slew &= conv_ops->slew_mask;
> +	slew = conv_ops->lookup_slew(slew);
>  	if (slew <= 0)
>  		return ret;
>  
>  	uwait = delta / slew;
>  
> -	hex = tps65941_buck_volt2val(*uV);
> +	hex = conv_ops->volt2val(idx, *uV);
>  	if (hex < 0)
>  		return hex;
>  
> @@ -231,7 +255,7 @@ static int tps65941_ldo_enable(struct udevice *dev, int op, bool *enable)
>  	return 0;
>  }
>  
> -static int tps65941_ldo_val2volt(int val)
> +static int tps65941_ldo_val2volt(__maybe_unused int idx, int val)
>  {
>  	if (val > TPS65941_LDO_VOLT_MAX_HEX || val < TPS65941_LDO_VOLT_MIN_HEX)
>  		return -EINVAL;
> @@ -241,12 +265,23 @@ static int tps65941_ldo_val2volt(int val)
>  		return -EINVAL;
>  }
>  
> +static const struct tps65941_reg_conv_ops ldo_conv_ops[] = {
> +	[TPS65941_LDO_CONV_OPS_IDX] = {
> +		.volt_mask = TPS65941_LDO_VOLT_MASK,
> +		.volt2val = tps65941_buck_volt2val,
> +		.val2volt = tps65941_ldo_val2volt,
> +	},
> +};
> +
>  static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
>  {
>  	unsigned int hex, adr;
> -	int ret;
> +	int ret, idx;
>  	struct dm_regulator_uclass_plat *uc_pdata;
> +	const struct tps65941_reg_conv_ops *conv_ops;
>  
> +	idx = dev->driver_data;
> +	conv_ops = &ldo_conv_ops[TPS65941_LDO_CONV_OPS_IDX];
>  	uc_pdata = dev_get_uclass_plat(dev);
>  
>  	if (op == PMIC_OP_GET)
> @@ -258,8 +293,8 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret &= TPS65941_LDO_VOLT_MASK;
> -	ret = tps65941_ldo_val2volt(ret);
> +	ret &= conv_ops->volt_mask;
> +	ret = conv_ops->val2volt(idx, ret);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -268,7 +303,7 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
>  		return 0;
>  	}
>  
> -	hex = tps65941_buck_volt2val(*uV);
> +	hex = conv_ops->volt2val(idx, *uV);
>  	if (hex < 0)
>  		return hex;
>  

