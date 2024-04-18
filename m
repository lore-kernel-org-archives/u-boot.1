Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D461CC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 00:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A8288511;
	Thu, 18 Apr 2024 02:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="OdT5NQEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65698882C4; Thu, 18 Apr 2024 02:23:25 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B6D588527
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240418002319epoutp01a1b8eada7f16290d8b7e741d95fddb63~HOAoUyeR31450314503epoutp01x
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 00:23:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240418002319epoutp01a1b8eada7f16290d8b7e741d95fddb63~HOAoUyeR31450314503epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713399799;
 bh=rUz3lHNmyWmvD7fE8B/Pi5cOwlr2iLwmjjufKjmu99c=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=OdT5NQEnazB38wgW5VNM+Ezo9PLzt7NElr79eaMXfqkUSebs/W1hi39zRS3RgJytn
 q/DTZeqdX4UjcRYGi+9Yt4crIzX1nDt6o4Jt9/9HCh70jA6o+9qnCZHUQC+2WQLOzz
 rgcOGBCjTVGelPlAEhYbntzTs314fqpe1g7GHZFI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240418002318epcas1p41a2c6f5c1b5206b8ed4518bdaa5eaaac~HOAoCAWFO1209512095epcas1p4L;
 Thu, 18 Apr 2024 00:23:18 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.234]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4VKdm5603lz4x9Q8; Thu, 18 Apr
 2024 00:23:17 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 6D.C9.09662.5F760266; Thu, 18 Apr 2024 09:23:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240418002317epcas1p48d1838062c9f37da35967f5b05418300~HOAmoZKCz1209512095epcas1p4_;
 Thu, 18 Apr 2024 00:23:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240418002317epsmtrp12c4fb40764cf892bb422bfd1ec0e05c4~HOAmnqe7x1252512525epsmtrp1P;
 Thu, 18 Apr 2024 00:23:17 +0000 (GMT)
X-AuditID: b6c32a35-2b3fa700000025be-4a-662067f5548f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 F3.7E.19234.5F760266; Thu, 18 Apr 2024 09:23:17 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240418002317epsmtip2dd5cc1e86888129de2f51d35acb8714c~HOAmW7HQC3162931629epsmtip2R;
 Thu, 18 Apr 2024 00:23:17 +0000 (GMT)
Message-ID: <ed1ea0f0-d46d-4377-b122-eddc346f57bf@samsung.com>
Date: Thu, 18 Apr 2024 09:23:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 3/5] power: regulator: tps65941: Added macros
 for BUCK ID
To: Bhargav Raviprakash <bhargav.r@ltts.com>, u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, m.nirmaladevi@ltts.com,
 sjg@chromium.org, trini@konsulko.com
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240318094925.374959-4-bhargav.r@ltts.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmvu7XdIU0g73P9Sw2zz/IbNGy1sPi
 w7xWdouP29+zW3zbso3RYuqkzewWb/d2sjuwe8xuuMji8erAKnaPO9f2sHmcvbOD0ePrpk2s
 HsdvbGcKYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
 y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVo
 YGBkClSYkJ0xefcs9oIrEhU3pz9jbmBsF+5i5OCQEDCR+HNKsouRk0NIYAejxJQlil2MXED2
 J0aJ1Y33GeGc2T2XWUGqQBpur93ACpHYySix5/RzFgjnPaPErn9T2EGqeAXsJJa1LAOzWQRU
 JS6uvMsCEReUODnzCZgtKiAvcf/WDLAaYYFIiVvX3oBtEBFwkvh6shUsziyQLTFx/m0mCFtc
 4taT+WA2m4COxPZvx8FsTgFLiT07dzJD1MhLbH87hxnkIAmBXg6Jj30foM52kTh+cgcThC0s
 8er4FnYIW0riZX8bO0RDM6PE0iUHWSGcHkaJfw3X2SCqjCX2L53MBAoxZgFNifW79CG28Um8
 +9rDCglIXomONiGIahWJS69fMsHMv/vkP9QNHhKrvnVAg243o8TDaUcYJzAqzEIKmFlIHp2F
 5KFZCJsXMLKsYhRLLSjOTU8tNiwwhEd3cn7uJkZwQtUy3cE48e0HvUOMTByMhxglOJiVRHhb
 hGXThHhTEiurUovy44tKc1KLDzGaAqNnIrOUaHI+MKXnlcQbmlgamJgZGZtYGJoZKonznrlS
 liokkJ5YkpqdmlqQWgTTx8TBKdXA1Pn82ql/JfOWhf1ZUX3wU/4a9VUnk+y212dlM73ykG71
 0FaeYcAUfP/AZ6b2mKv7TshsPtKw//7/XvbdnyeF2zF/0GXRODzRTe615zqJNVL33afoBn2s
 r/UJWMaRLRlqvSFYoCfrlpfUfeEFk5rXvu7PLey3aWbKc+PawxiyYeoZY8bKI++D18e0m84o
 3f6nvknbQnxeRNZus6bMw16qpnKzrq3jq+5jY7/eXxfbaH/qXnCFWML0NLbKOY6Rd93/hZj7
 KEi77fuhrW921Pyg89xpQRG2Fgy8kywm3n9093nxISfpRvnK+QteGcU1BCQ8jJJWm9b44dOE
 vFRz9ak+k6tjXT+f5mXrXnvLZ48SS3FGoqEWc1FxIgBrAi18MQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvO7XdIU0gwW9vBab5x9ktmhZ62Hx
 YV4ru8XH7e/ZLb5t2cZoMXXSZnaLt3s72R3YPWY3XGTxeHVgFbvHnWt72DzO3tnB6PF10yZW
 j+M3tjMFsEVx2aSk5mSWpRbp2yVwZUzePYu94IpExc3pz5gbGNuFuxg5OSQETCRur93A2sXI
 xSEksJ1RouXmKlaIhJTE56dT2boYOYBsYYnDh4shat4ySizc/4cFpIZXwE5iWcsydhCbRUBV
 4uLKu1BxQYmTM5+A2aIC8hL3b80AqxEWiJS4de0N2HwRASeJrydb2UHmMwtkS1xqTgQJCwmk
 Sxx7vYMNxGYWEJe49WQ+E4jNJqAjsf3bcTCbU8BSYs/OncwQreoS6+cJQZTLS2x/O4d5AqPQ
 LCRHzEIyaRZCxywkHQsYWVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBEeMVtAOxmXr/+od
 YmTiYDzEKMHBrCTC2yIsmybEm5JYWZValB9fVJqTWnyIUZqDRUmcVzmnMwXolcSS1OzU1ILU
 IpgsEwenVANT6U4zwetqx604Ha+8t7WO2d+jFzztrEr0obbLVYdenDu+0DTx2z0mX40VS1+U
 Lj1Qt+OQiI1htvgD0d1Xk7z4JCU3ROQa7hdQ1bpwn5lPafvGOHGlh9uVfbkXxrBM2FIVymW/
 JC7f5zBz87+LcpqN9qH787Mqnv37/snpi5P5BZm9s5QZp5oe6Dy9Y5GTytuJvXv3+dRGsu5j
 5Ft5c8W15nU+83oiXY8mvGVLy9zoajW3c0qgi+Lq5T8u79kxJcnc/f8O93rx3NOqm+/U621/
 /c+McfnqLTFvq4vM5kq9ixR41tK1ccdOq7zN7SeEOZ9cWbV7T9aNSS08phwbDsuohCfmsrHq
 1c9K4di8tuujEktxRqKhFnNRcSIAxcUHWgcDAAA=
X-CMS-MailID: 20240418002317epcas1p48d1838062c9f37da35967f5b05418300
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240418002317epcas1p48d1838062c9f37da35967f5b05418300
References: <20240318094925.374959-1-bhargav.r@ltts.com>
 <20240318094925.374959-4-bhargav.r@ltts.com>
 <CGME20240418002317epcas1p48d1838062c9f37da35967f5b05418300@epcas1p4.samsung.com>
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
> Adds macros for buck and ldo ids and switched to using switch
> case instead of if else in probe functions. Helps in adding
> support for TPS65224 PMIC.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/regulator/tps65941_regulator.c | 54 +++++++++++++++-----
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
> index b041126775..cf54e30df5 100644
> --- a/drivers/power/regulator/tps65941_regulator.c
> +++ b/drivers/power/regulator/tps65941_regulator.c
> @@ -16,6 +16,25 @@
>  #include <power/regulator.h>
>  #include <power/tps65941.h>
>  
> +/* Single Phase Buck IDs */
> +#define TPS65941_BUCK_ID_1        1
> +#define TPS65941_BUCK_ID_2        2
> +#define TPS65941_BUCK_ID_3        3
> +#define TPS65941_BUCK_ID_4        4
> +#define TPS65941_BUCK_ID_5        5
> +
> +/* Multi Phase Buck IDs */
> +#define TPS65941_BUCK_ID_12      12
> +#define TPS65941_BUCK_ID_34      34
> +#define TPS65941_BUCK_ID_123    123
> +#define TPS65941_BUCK_ID_1234  1234
> +
> +/* LDO IDs */
> +#define TPS65941_LDO_ID_1         1
> +#define TPS65941_LDO_ID_2         2
> +#define TPS65941_LDO_ID_3         3
> +#define TPS65941_LDO_ID_4         4
> +
>  static const char tps65941_buck_ctrl[TPS65941_BUCK_NUM] = {0x4, 0x6, 0x8, 0xA,
>  								0xC};
>  static const char tps65941_buck_vout[TPS65941_BUCK_NUM] = {0xE, 0x10, 0x12,
> @@ -270,10 +289,15 @@ static int tps65941_ldo_probe(struct udevice *dev)
>  	uc_pdata->type = REGULATOR_TYPE_LDO;
>  
>  	idx = dev->driver_data;
> -	if (idx == 1 || idx == 2 || idx == 3 || idx == 4) {
> +	switch (idx) {
> +	case TPS65941_LDO_ID_1:
> +	case TPS65941_LDO_ID_2:
> +	case TPS65941_LDO_ID_3:
> +	case TPS65941_LDO_ID_4:
>  		debug("Single phase regulator\n");
> -	} else {
> -		printf("Wrong ID for regulator\n");
> +		break;
> +	default:
> +		pr_err("Wrong ID for regulator\n");
>  		return -EINVAL;
>  	}
>  
> @@ -292,18 +316,24 @@ static int tps65941_buck_probe(struct udevice *dev)
>  	uc_pdata->type = REGULATOR_TYPE_BUCK;
>  
>  	idx = dev->driver_data;
> -	if (idx == 1 || idx == 2 || idx == 3 || idx == 4 || idx == 5) {
> +	switch (idx) {
> +	case TPS65941_BUCK_ID_1:
> +	case TPS65941_BUCK_ID_2:
> +	case TPS65941_BUCK_ID_3:
> +	case TPS65941_BUCK_ID_4:
> +	case TPS65941_BUCK_ID_5:
>  		debug("Single phase regulator\n");
> -	} else if (idx == 12) {
> +		break;
> +	case TPS65941_BUCK_ID_12:
> +	case TPS65941_BUCK_ID_123:
> +	case TPS65941_BUCK_ID_1234:
>  		idx = 1;
> -	} else if (idx == 34) {
> +		break;
> +	case TPS65941_BUCK_ID_34:
>  		idx = 3;
> -	} else if (idx == 123) {
> -		idx = 1;
> -	} else if (idx == 1234) {
> -		idx = 1;
> -	} else {
> -		printf("Wrong ID for regulator\n");
> +		break;
> +	default:
> +		pr_err("Wrong ID for regulator\n");
>  		return -EINVAL;
>  	}
>  

