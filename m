Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF197C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 00:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AC588503;
	Thu, 18 Apr 2024 02:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="D0HB6+lV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326AE88527; Thu, 18 Apr 2024 02:33:41 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4C5884E3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 02:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240418003332epoutp0103f2a53d51b2b904120e30cb30127ea4~HOJj6kmRi2584925849epoutp018
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 00:33:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240418003332epoutp0103f2a53d51b2b904120e30cb30127ea4~HOJj6kmRi2584925849epoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713400412;
 bh=cXNo1SsaoRMh4c6ZNqDr0UwY/k05aWRCW1GTzHZL9pY=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=D0HB6+lV8cXlCwgh4ab04x1g7hFTVldjQ/fYkOuuoo6aiWo+bBFvf6CaCHDOFrbLg
 S8opca+tyhhAfJg5iAT48H7pA4SjPH7ebT76HF6KBxC63jglS6spFW7xOYfdQBHDsz
 Z6ONyOBfYt9rXyQGSHAu4095UBs5fAuFC4m1iuRQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240418003332epcas1p361114204a2685284bff4029d31c36ad3~HOJjowY1T2598825988epcas1p3W;
 Thu, 18 Apr 2024 00:33:32 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.134]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VKdzv21nLz4x9Pw; Thu, 18 Apr
 2024 00:33:31 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 01.0A.10158.B5A60266; Thu, 18 Apr 2024 09:33:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240418003330epcas1p47c268f53710e6341e7540847a9d08f90~HOJiCYbin0518505185epcas1p4P;
 Thu, 18 Apr 2024 00:33:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240418003330epsmtrp1f85e2b6b9228efb9f47867daa11d562a~HOJiBpofs1898418984epsmtrp1d;
 Thu, 18 Apr 2024 00:33:30 +0000 (GMT)
X-AuditID: b6c32a38-b41fa700000027ae-73-66206a5b3211
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 28.75.08924.A5A60266; Thu, 18 Apr 2024 09:33:30 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240418003330epsmtip10ade08bf7161abcce6f3f1e7bbfc189f~HOJhyrGUa0572505725epsmtip1e;
 Thu, 18 Apr 2024 00:33:30 +0000 (GMT)
Message-ID: <1ce0fb3e-1b8f-4495-a281-30182e258ae8@samsung.com>
Date: Thu, 18 Apr 2024 09:33:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 5/5] power: regulator: tps65941: Add TPS65224
 PMIC regulator support
To: Bhargav Raviprakash <bhargav.r@ltts.com>, u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, m.nirmaladevi@ltts.com,
 sjg@chromium.org, trini@konsulko.com
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240318094925.374959-6-bhargav.r@ltts.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmgW50lkKawfcrHBab5x9ktmhZ62Hx
 YV4ru8XH7e/ZLb5t2cZoMXXSZnaLt3s72R3YPWY3XGTxeHVgFbvHnWt72DzO3tnB6PF10yZW
 j+M3tjMFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
 ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAt0CtOzC0uzUvXy0stsTI0
 MDAyBSpMyM7Y/uwxa8GvlIq/t9qZGxiX+nQxcnJICJhInG7YwQRiCwnsYJQ4ON+yi5ELyP7E
 KPHj2DkmCOcbo8S+tg1sMB1XJp5mhEjsZZT4vqCVBcJ5zyhxfso+ZpAqXgE7ibaPR8Hmsgio
 Smye9J0NIi4ocXLmExYQW1RAXuL+rRnsILawQIrElgtPwWwRASeJrydbwWxmgWyJifNvM0HY
 4hK3nswHs9kEdCS2fzsOZnMKWErsOveAFaJGXmL72znMEJdO5JDYMDUEwnaR+LtlBVRcWOLV
 8S3sELaUxMv+NnaQByQEmhklli45yArh9DBK/Gu4DvWzscT+pZOBtnEAbdCUWL9LH2IZn8S7
 rz2sIGEJAV6JjjYhiGoViUuvXzLBzL/75D8rhO0hsfrAUmiQ7maUeL+nk2kCo8IspHCZheTP
 WUj+mYWweQEjyypGsdSC4tz01GLDAhN4dCfn525iBCdULYsdjHPfftA7xMjEwXiIUYKDWUmE
 t0VYNk2INyWxsiq1KD++qDQntfgQoykwdiYyS4km5wNTel5JvKGJpYGJmZGxiYWhmaGSOO+Z
 K2WpQgLpiSWp2ampBalFMH1MHJxSDUxGC6VtWnQlfmtfNVb69mVnHmva8Us/k1guttudOTWp
 f6ffxZPzOXqeCbWVlMUbzXzHee+q3jmd998yk+3Z7l1pOl9bEaLKHvTc70rlyoUTNvox+Cv8
 MlFLV2JbJLPE9sz2mZ3zhOzsZvtXVbkI37jclH/hlYC1gTeTz3ufVw/51vzaIaf1fdI9dq5N
 8x/XyLC2dwZsmzb3/9W5MUeSGxnOXZ7zpeakRtMz58Q9919+Fy5xdf5yTN2acZPxLrm1LAwP
 nSTf1bSe3KjesXNzZjnf9VV/GyYtYLFzvNxdovz+Z7fA+RltpYJfFs+4e2Pf+7as3BqPnu3+
 FiZP78n93BmnqK2lUnWRJfGiZE5ucoESS3FGoqEWc1FxIgCCLrJXMQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWy7bCSnG5UlkKaQddefYvN8w8yW7Ss9bD4
 MK+V3eLj9vfsFt+2bGO0mDppM7vF272d7A7sHrMbLrJ4vDqwit3jzrU9bB5n7+xg9Pi6aROr
 x/Eb25kC2KK4bFJSczLLUov07RK4MrY/e8xa8Cul4u+tduYGxqU+XYycHBICJhJXJp5mBLGF
 BHYzShybrgcRl5L4/HQqWxcjB5AtLHH4cHEXIxdQyVtGiVVbXrGC1PAK2Em0fTzKBGKzCKhK
 bJ70nQ0iLihxcuYTFhBbVEBe4v6tGewgtrBAisSWC0/BbBEBJ4mvJ1vZQeYzC2RLXGpOhDgh
 XWLxrHdgJcwC4hK3nswHG88moCOx/dtxMJtTwFJi17kHrBCt6hLr5wlBlMtLbH87h3kCo9As
 JEfMQjJpFkLHLCQdCxhZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBMeNluYOxu2r
 PugdYmTiYDzEKMHBrCTC2yIsmybEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFbwrQO4klqdmp
 qQWpRTBZJg5OqQamvUfVJWIz95vGlq51PmgYOGEyY7NUwwNX2fbkyacOKb+NCmScJC7Qqjz/
 9vsZO1vSqkuUKo4ULrtzc9fSz4+Wh27X0/pSVjexM8Xwx4E9IcErrLkqP+qGXA2b9WOXnVzV
 tu/9Lx9f4pkhrtfRW2wnkXBReMtM9ePXBDe5h2zTvXDuy+yzlh9uJj5geZm71k924x/j0DN/
 b81vOfKre4qTaOVUMw27vT+kN/qwdD3MSNl08h23urPIrF/SIVyl1pOnbI5jU7y5uPt95Grd
 rNOPVfVXWBSkve644FOS+nB9fcj87NUySquni8QpOQbPVuW5/UFFeemi3lzhP3GtTa9L3lfe
 e/UoOnPH5cXtph/LlFiKMxINtZiLihMB4MfMHQoDAAA=
X-CMS-MailID: 20240418003330epcas1p47c268f53710e6341e7540847a9d08f90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240418003330epcas1p47c268f53710e6341e7540847a9d08f90
References: <20240318094925.374959-1-bhargav.r@ltts.com>
 <20240318094925.374959-6-bhargav.r@ltts.com>
 <CGME20240418003330epcas1p47c268f53710e6341e7540847a9d08f90@epcas1p4.samsung.com>
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
> Reuse TPS65941 regulator driver to adds support for
> TPS65224 PMIC's regulators. 4 BUCKs and 3 LDOs, where
> BUCK1 and BUCK2 can be configured in dual phase mode.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---
>  drivers/power/regulator/tps65941_regulator.c | 283 ++++++++++++++++++-
>  1 file changed, 270 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
> index d879c2301b..b1b9462fd3 100644
> --- a/drivers/power/regulator/tps65941_regulator.c
> +++ b/drivers/power/regulator/tps65941_regulator.c
> @@ -37,6 +37,8 @@
>  
>  #define TPS65941_BUCK_CONV_OPS_IDX  0
>  #define TPS65941_LDO_CONV_OPS_IDX   0
> +#define TPS65224_LDO_CONV_OPS_IDX   1
> +#define TPS65224_BUCK_CONV_OPS_IDX  1
>  
>  struct tps65941_reg_conv_ops {
>  	int volt_mask;
> @@ -55,6 +57,11 @@ static const char tps65941_ldo_ctrl[TPS65941_BUCK_NUM] = {0x1D, 0x1E, 0x1F,
>  static const char tps65941_ldo_vout[TPS65941_BUCK_NUM] = {0x23, 0x24, 0x25,
>  								0x26};
>  
> +static inline int tps65941_get_chip_id(struct udevice *dev)
> +{
> +	return dev->parent->driver_data;
> +}
> +
>  static int tps65941_buck_enable(struct udevice *dev, int op, bool *enable)
>  {
>  	int ret;
> @@ -146,6 +153,112 @@ int tps65941_lookup_slew(int id)
>  	}
>  }
>  
> +static int tps65224_buck_volt2val(int idx, int uV)
> +{
> +	/* This functions maps a value which is in micro Volts to the VSET value.
> +	 * The mapping is as per the datasheet of TPS65224.
> +	 */
> +
> +	if (uV > TPS65224_BUCK_VOLT_MAX)
> +		return -EINVAL;
> +
> +	if (idx > 0) {
> +		/* Buck2, Buck3 and Buck4 of TPS65224 has a different schema in
> +		 * converting b/w micro_volt and VSET hex values
> +		 *
> +		 * VSET value starts from 0x00 for 0.5V, and for every increment
> +		 * in VSET value the output voltage increases by 25mV. This is upto
> +		 * 1.15V where VSET is 0x1A.
> +		 *
> +		 * For 0x1B the output voltage is 1.2V, and for every increment of
> +		 * VSET the output voltage increases by 50mV upto the max voltage of
> +		 * 3.3V
> +		 *
> +		 * | Voltage Ranges  | VSET Ranges  | Voltage Step |
> +		 * +-----------------+--------------+--------------+
> +		 * | 0.5V to 1.50V   | 0x00 to 0x1A |  25mV        |
> +		 * | 1.2V to 3.3V    | 0x1B to 0x45 |  50mV        |
> +		 */
> +		if (uV >= 1200000)
> +			return (uV - 1200000) / 50000 + 0x1B;
> +		else if (uV >= 500000)
> +			return (uV - 500000) / 25000;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	/* Buck1 and Buck12(dual phase) has a different mapping b/w output
> +	 * voltage and VSET value.
> +	 *
> +	 * | Voltage Ranges  | VSET Ranges  | Voltage Step |
> +	 * +-----------------+--------------+--------------+
> +	 * | 0.5V to 0.58V   | 0xA to 0xE   |  20mV        |
> +	 * | 0.6V to 1.095V  | 0xF to 0x72  |  5mV         |
> +	 * | 1.1V to 1.65V   | 0x73 to 0xAA |  10mV        |
> +	 * | 1.6V to 3.3V    | 0xAB to 0xFD |  20mV        |
> +	 *
> +	 */
> +	if (uV >= 1660000)
> +		return (uV - 1660000) / 20000 + 0xAB;
> +	else if (uV >= 1100000)
> +		return (uV - 1100000) / 10000 + 0x73;
> +	else if (uV >= 600000)
> +		return (uV - 600000) / 5000 + 0x0F;
> +	else if (uV >= 500000)
> +		return (uV - 500000) / 20000 + 0x0A;
> +	else
> +		return -EINVAL;
> +}
> +
> +static int tps65224_buck_val2volt(int idx, int val)
> +{
> +	/* This function does the opposite to the tps65224_buck_volt2val function
> +	 * described above.
> +	 * This maps the VSET value to micro volts. Please refer to the ranges
> +	 * mentioned the comments of tps65224_buck_volt2val.
> +	 */
> +
> +	if (idx > 0) {
> +		if (val > TPS65224_BUCK234_VOLT_MAX_HEX)
> +			return -EINVAL;
> +		else if (val >= 0x1B)
> +			return 1200000 + (val - 0x1B) * 50000;
> +		else if (val >= 0x00)
> +			return 500000 + (val - 0x00) * 25000;
> +		else
> +			return -EINVAL;
> +	}
> +
> +	if (val > TPS65224_BUCK1_VOLT_MAX_HEX)
> +		return -EINVAL;
> +	else if (val >= 0xAB)
> +		return 1660000 + (val - 0xAB) * 20000;
> +	else if (val >= 0x73)
> +		return 1100000 + (val - 0x73) * 10000;
> +	else if (val >= 0xF)
> +		return 600000 + (val - 0xF) * 5000;
> +	else if (val >= 0xA)
> +		return 500000 + (val - 0xA) * 20000;
> +	else
> +		return -EINVAL;
> +}
> +
> +int tps65224_lookup_slew(int id)
> +{
> +	switch (id) {
> +	case 0:
> +		return 10000;
> +	case 1:
> +		return 5000;
> +	case 2:
> +		return 2500;
> +	case 3:
> +		return 1250;
> +	default:
> +		return -1;
> +	}
> +}
> +
>  static const struct tps65941_reg_conv_ops buck_conv_ops[] = {
>  	[TPS65941_BUCK_CONV_OPS_IDX] = {
>  		.volt_mask = TPS65941_BUCK_VOLT_MASK,
> @@ -154,6 +267,13 @@ static const struct tps65941_reg_conv_ops buck_conv_ops[] = {
>  		.slew_mask = TP65941_BUCK_CONF_SLEW_MASK,
>  		.lookup_slew = tps65941_lookup_slew,
>  	},
> +	[TPS65224_BUCK_CONV_OPS_IDX] = {
> +		.volt_mask = TPS65941_BUCK_VOLT_MASK,
> +		.volt2val = tps65224_buck_volt2val,
> +		.val2volt = tps65224_buck_val2volt,
> +		.slew_mask = TPS65224_BUCK_CONF_SLEW_MASK,
> +		.lookup_slew = tps65224_lookup_slew,
> +	},
>  };
>  
>  static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
> @@ -162,9 +282,23 @@ static int tps65941_buck_val(struct udevice *dev, int op, int *uV)
>  	int ret, delta, uwait, slew, idx;
>  	struct dm_regulator_uclass_plat *uc_pdata;
>  	const struct tps65941_reg_conv_ops *conv_ops;
> +	ulong chip_id;
>  
>  	idx = dev->driver_data;
> -	conv_ops = &buck_conv_ops[TPS65941_BUCK_CONV_OPS_IDX];
> +	chip_id = tps65941_get_chip_id(dev);
> +	if (chip_id == TPS65224) {
> +		/* idx is the buck id number as per devicetree node which will be same
> +		 * as the regulator name in the datasheet.
> +		 * The idx for buck1. buck2, buck3, buck4, buck12 will be 1, 2, 3, 4
> +		 * and 12 respectively.
> +		 * In the driver the numbering is from 0. Hence the -1.
> +		 */
> +		idx = (idx == TPS65941_BUCK_ID_12) ? 0 : (idx - 1);
> +		conv_ops = &buck_conv_ops[TPS65224_BUCK_CONV_OPS_IDX];
> +	} else {
> +		conv_ops = &buck_conv_ops[TPS65941_BUCK_CONV_OPS_IDX];
> +	}
> +
>  	uc_pdata = dev_get_uclass_plat(dev);
>  
>  	if (op == PMIC_OP_GET)
> @@ -265,23 +399,99 @@ static int tps65941_ldo_val2volt(__maybe_unused int idx, int val)
>  		return -EINVAL;
>  }
>  
> +static int tps65224_ldo_volt2val(int idx, int uV)
> +{
> +	int base = TPS65224_LDO1_VOLT_MIN;
> +	int max = TPS65224_LDO1_VOLT_MAX;
> +	int offset = TPS65224_LDO1_VOLT_MIN_HEX;
> +	int step = TPS65224_LDO_STEP;
> +
> +	if (idx > 0) {
> +		base = TPS65224_LDO23_VOLT_MIN;
> +		max = TPS65224_LDO23_VOLT_MAX;
> +		offset = TPS65224_LDO23_VOLT_MIN_HEX;
> +	}
> +
> +	if (uV > max)
> +		return -EINVAL;
> +	else if (uV >= base)
> +		return (uV - base) / step + offset;
> +	else
> +		return -EINVAL;
> +}
> +
> +static int tps65224_ldo_val2volt(int idx, int val)
> +{
> +	int reg_base = TPS65224_LDO1_VOLT_MIN_HEX;
> +	int reg_max = TPS65224_LDO1_VOLT_MAX_HEX;
> +	int base = TPS65224_LDO1_VOLT_MIN;
> +	int max = TPS65224_LDO1_VOLT_MAX;
> +	int step = TPS65224_LDO_STEP;
> +	/* In LDOx_VOUT reg the BIT0 is reserved and the
> +	 * vout value is stored from BIT1 to BIT7.
> +	 * Hence the below bit shit is done.
> +	 */
> +	int mask = TPS65224_LDO_VOLT_MASK >> 1;
> +
> +	if (idx > 0) {
> +		base = TPS65224_LDO23_VOLT_MIN;
> +		max = TPS65224_LDO23_VOLT_MAX;
> +		reg_base = TPS65224_LDO23_VOLT_MIN_HEX;
> +		reg_max = TPS65224_LDO23_VOLT_MAX_HEX;
> +	}
> +
> +	/* The VSET register of LDO has its 0th bit as reserved
> +	 * hence shifting the value to right by 1 bit.
> +	 */
> +	val = val >> 1;
> +
> +	if (val < 0 || val > mask)
> +		return -EINVAL;
> +
> +	if (val <= reg_base)
> +		return base;
> +
> +	if (val >= reg_max)
> +		return max;
> +
> +	return base + (step * (val - reg_base));
> +}
> +
>  static const struct tps65941_reg_conv_ops ldo_conv_ops[] = {
>  	[TPS65941_LDO_CONV_OPS_IDX] = {
>  		.volt_mask = TPS65941_LDO_VOLT_MASK,
>  		.volt2val = tps65941_buck_volt2val,
>  		.val2volt = tps65941_ldo_val2volt,
>  	},
> +	[TPS65224_LDO_CONV_OPS_IDX] = {
> +		.volt_mask = TPS65224_LDO_VOLT_MASK,
> +		.volt2val = tps65224_ldo_volt2val,
> +		.val2volt = tps65224_ldo_val2volt,
> +	},
>  };
>  
>  static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
>  {
>  	unsigned int hex, adr;
> -	int ret, idx;
> +	int ret, ret_volt, idx;
>  	struct dm_regulator_uclass_plat *uc_pdata;
>  	const struct tps65941_reg_conv_ops *conv_ops;
> +	ulong chip_id;
>  
> +	chip_id = tps65941_get_chip_id(dev);
>  	idx = dev->driver_data;
> -	conv_ops = &ldo_conv_ops[TPS65941_LDO_CONV_OPS_IDX];
> +	if (chip_id == TPS65224) {
> +		/* idx is the ldo id number as per devicetree node which will be same
> +		 * as the regulator name in the datasheet.
> +		 * The idx for ldo1, ldo2, ldo3 will be 1, 2 & 3 respectively.
> +		 * In the driver the numbering is from 0. Hence the -1.
> +		 */
> +		idx = idx - 1;
> +		conv_ops = &ldo_conv_ops[TPS65224_LDO_CONV_OPS_IDX];
> +	} else {
> +		conv_ops = &ldo_conv_ops[TPS65941_LDO_CONV_OPS_IDX];
> +	}
> +
>  	uc_pdata = dev_get_uclass_plat(dev);
>  
>  	if (op == PMIC_OP_GET)
> @@ -294,21 +504,36 @@ static int tps65941_ldo_val(struct udevice *dev, int op, int *uV)
>  		return ret;
>  
>  	ret &= conv_ops->volt_mask;
> -	ret = conv_ops->val2volt(idx, ret);
> -	if (ret < 0)
> -		return ret;
> +	ret_volt = conv_ops->val2volt(idx, ret);
> +	if (ret_volt < 0)
> +		return ret_volt;
>  
>  	if (op == PMIC_OP_GET) {
> -		*uV = ret;
> +		*uV = ret_volt;
>  		return 0;
>  	}
>  
> +	/* TPS65224 LDO1 in BYPASS mode only supports 2.2V min to 3.6V max */
> +	if (chip_id == TPS65224 && idx == 0 && (ret & BIT(TPS65224_LDO_BYP_CONFIG)) &&
> +	    *uV < TPS65224_LDO1_VOLT_BYP_MIN)
> +		return -EINVAL;
> +
> +	/* TPS65224 LDO2 & LDO3 in BYPASS mode supports 1.5V min to 5.5V max */
> +	if (chip_id == TPS65224 && idx > 0 && (ret & BIT(TPS65224_LDO_BYP_CONFIG)) &&
> +	    *uV < TPS65224_LDO23_VOLT_BYP_MIN)
> +		return -EINVAL;
> +
>  	hex = conv_ops->volt2val(idx, *uV);
>  	if (hex < 0)
>  		return hex;
>  
> -	ret &= 0x0;
> -	ret = hex;
> +	if (chip_id == TPS65224) {
> +		hex = hex << TPS65941_LDO_MODE_MASK;
> +		ret &= ~TPS65224_LDO_VOLT_MASK;
> +		ret |= hex;
> +	} else {
> +		ret = hex;
> +	}
>  
>  	ret = pmic_reg_write(dev->parent, adr, ret);
>  
> @@ -319,6 +544,9 @@ static int tps65941_ldo_probe(struct udevice *dev)
>  {
>  	struct dm_regulator_uclass_plat *uc_pdata;
>  	int idx;
> +	ulong chip_id;
> +
> +	chip_id = tps65941_get_chip_id(dev);
>  
>  	uc_pdata = dev_get_uclass_plat(dev);
>  	uc_pdata->type = REGULATOR_TYPE_LDO;
> @@ -328,9 +556,16 @@ static int tps65941_ldo_probe(struct udevice *dev)
>  	case TPS65941_LDO_ID_1:
>  	case TPS65941_LDO_ID_2:
>  	case TPS65941_LDO_ID_3:
> -	case TPS65941_LDO_ID_4:
>  		debug("Single phase regulator\n");
>  		break;
> +	case TPS65941_LDO_ID_4:
> +		if (chip_id != TPS65224) {
> +			debug("Single phase regulator\n");
> +		} else {
> +			pr_err("Wrong ID for regulator\n");
> +			return -EINVAL;
> +		}
> +		break;

Is it possible to use the below?

if (chip_id != TPS65224) {
	debug("Single phase regulator\n");
	break;
}

/* fallthrough */

Best Regards,
Jaehoon Chung

>  	default:
>  		pr_err("Wrong ID for regulator\n");
>  		return -EINVAL;
> @@ -346,6 +581,9 @@ static int tps65941_buck_probe(struct udevice *dev)
>  {
>  	struct dm_regulator_uclass_plat *uc_pdata;
>  	int idx;
> +	ulong chip_id;
> +
> +	chip_id = tps65941_get_chip_id(dev);
>  
>  	uc_pdata = dev_get_uclass_plat(dev);
>  	uc_pdata->type = REGULATOR_TYPE_BUCK;
> @@ -356,16 +594,35 @@ static int tps65941_buck_probe(struct udevice *dev)
>  	case TPS65941_BUCK_ID_2:
>  	case TPS65941_BUCK_ID_3:
>  	case TPS65941_BUCK_ID_4:
> -	case TPS65941_BUCK_ID_5:
>  		debug("Single phase regulator\n");
>  		break;
> +	case TPS65941_BUCK_ID_5:
> +		if (chip_id != TPS65224) {
> +			debug("Single phase regulator\n");
> +		} else {
> +			pr_err("Wrong ID for regulator\n");
> +			return -EINVAL;
> +		}
> +		break;
>  	case TPS65941_BUCK_ID_12:
> +		idx = 1;
> +		break;
>  	case TPS65941_BUCK_ID_123:
>  	case TPS65941_BUCK_ID_1234:
> -		idx = 1;
> +		if (chip_id != TPS65224) {
> +			idx = 1;
> +		} else {
> +			pr_err("Wrong ID for regulator\n");
> +			return -EINVAL;
> +		}
>  		break;
>  	case TPS65941_BUCK_ID_34:
> -		idx = 3;
> +		if (chip_id != TPS65224) {
> +			idx = 3;
> +		} else {
> +			pr_err("Wrong ID for regulator\n");
> +			return -EINVAL;
> +		}
>  		break;
>  	default:
>  		pr_err("Wrong ID for regulator\n");

