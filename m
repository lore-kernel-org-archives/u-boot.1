Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A36C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 06:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F348911C;
	Fri, 26 Apr 2024 08:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="GG2HDHfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC34089121; Fri, 26 Apr 2024 08:34:40 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0BA8910D
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240426063429epoutp03a9dbe0cf60020724d60c0467581c5c2f~JwO-Fl7FU3186131861epoutp03v
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 06:34:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240426063429epoutp03a9dbe0cf60020724d60c0467581c5c2f~JwO-Fl7FU3186131861epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1714113269;
 bh=Hg8Ct0NXUt4LyarpX/mJkb/AqBxqmDCigOJ9oZ2F+LE=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=GG2HDHflVZlyz9xOkY6fhPn0qwqI62Hdrtf50A8xJQFNz2iXF8X6cRlZ9NdnrDtum
 pEo5okVbY/ht3+uIxp31dDRiG7XmHaNrjZWFI3ymwL3KEJmOM31rnxWzbiOvUIQrS8
 cOq/ZpEK53s6Ah5XE7z28b498wt4oUgyGZQzYuXU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240426063429epcas1p49bf99fe7a5bf09f627ceb076617ed88c~JwO_5tSkJ1617316173epcas1p4A;
 Fri, 26 Apr 2024 06:34:29 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.236]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4VQjcg3Mwdz4x9Pw; Fri, 26 Apr
 2024 06:34:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 34.80.10158.3FA4B266; Fri, 26 Apr 2024 15:34:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240426063427epcas1p249956fd332cf3341d014abc1ec43d286~JwO9JU3YX1199311993epcas1p2V;
 Fri, 26 Apr 2024 06:34:27 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240426063427epsmtrp2b7d7ec0a8e6dc0cf997967e0967523a1~JwO9HUNhL1639216392epsmtrp2j;
 Fri, 26 Apr 2024 06:34:27 +0000 (GMT)
X-AuditID: b6c32a38-b41fa700000027ae-89-662b4af3e4db
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1D.10.07541.2FA4B266; Fri, 26 Apr 2024 15:34:27 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240426063426epsmtip11ce11baec73f4fef3485e58abd4c7de9~JwO87UwRi3181131811epsmtip1J;
 Fri, 26 Apr 2024 06:34:26 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Bhargav Raviprakash'" <bhargav.r@ltts.com>, <u-boot@lists.denx.de>
Cc: <d-gole@ti.com>, <dan.carpenter@linaro.org>, <sjg@chromium.org>,
 <trini@konsulko.com>, <m.nirmaladevi@ltts.com>
In-Reply-To: <0109018f05359741-62286139-e55d-4816-bcca-ce0c4cbcafb3-000000@ap-south-1.amazonses.com>
Subject: RE: [PATCH v4 5/5] power: regulator: tps65941: Add TPS65224 PMIC
 regulator support
Date: Fri, 26 Apr 2024 15:34:26 +0900
Message-ID: <000101da97a3$c90fa4c0$5b2eee40$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLQ/sDcokl/HYj1ix2UhpfuNjIAtQJv5o00Aktb+vavZ2/YcA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmnu5nL+00g+NvJCw2zz/IbNGy1sPi
 w7xWdouP29+zW3zbso3RYuqkzewWb/d2sjuwe8xuuMji8erAKnaPO9f2sHmcvbOD0ePrpk2s
 HsdvbGcKYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1
 y8wBukVJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVo
 YGBkClSYkJ2x/9t91oJ9aRXv54o1MHb4dTFyckgImEjcedvM1sXIxSEksINRouffeiYI5xOj
 xJ8Pn6Ay3xglpsyYzwTT8rRtLjtEYi+jxNJbx6CqXjJKHGs5wwhSxSagJ/F/0UJmEFtEwEPi
 3PzTbCA2s0CpxKwD21hBbE6BFIltuy+AxYUFYiUuLtgDVs8ioCpx9TxEDa+ApUR3Yy8zxGYF
 iZ9Pl7FCzHSS+LbyIiPETBGJ2Z1tzCBHSAh8ZJfY9PIr1KkuEre39bNB2MISr45vYYewpSQ+
 v9vLBtHQDPTCkoOsEE4Po8S/hutQHcYS+5dOBprEAbRCU2L9Ln2IbXwS7772sIKEJQR4JTra
 hCCqVSQuvX7JBDP/7pP/rBC2h0TD6g8skBCayCTxcsFplgmM8rOQHD4LYcMCRqZVjGKpBcW5
 6anFhgUm8LhMzs/dxAhOhVoWOxjnvv2gd4iRiYPxEKMEB7OSCO/NjxppQrwpiZVVqUX58UWl
 OanFhxhNgUE5kVlKNDkfmIzzSuINTSwNTMyMjE0sDM0MlcR5z1wpSxUSSE8sSc1OTS1ILYLp
 Y+LglGpg4mC53XhkdabeZaPU/v+/Fql8ur7SVvOBnduR69y8q7cecdg0YV8YY1O0tpDEKY+u
 dS2cp2ZP2HZC2n5rrf5CT841EXPnHC4X3XP9wAqzkyvW2jYd4j694ZPO9KnZO5dF6gcH5GzW
 /Kb0KH5/w+HTS6QWGpxKkO3hsLh291Ld7u9flqtP336sNFPIsSdjou1X3kXzziyvCTPreVcc
 eujZ4TdSS7Y9ZHDct1/jxzlXixOXv06aZ/QydU585Mt71/4WHl1xYvGtd6aduy80vFvx7O2x
 M7y+51TShKxMqwz/hu0q59e9YHlNvt+n9GGgzMrw1/bCNUsn/zxxaa9LTIrsk06lPwafN+nI
 H9ItYfk54fFlJZbijERDLeai4kQARQPF6A4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnO5nL+00g7cNzBab5x9ktmhZ62Hx
 YV4ru8XH7e/ZLb5t2cZoMXXSZnaLt3s72R3YPWY3XGTxeHVgFbvHnWt72DzO3tnB6PF10yZW
 j+M3tjMFsEVx2aSk5mSWpRbp2yVwZez/dp+1YF9axfu5Yg2MHX5djJwcEgImEk/b5rJ3MXJx
 CAnsZpQ4O2M5G0RCSuLz06lANgeQLSxx+HAxRM1zRonPe6YwgtSwCehJ/F+0kBnEFhHwkvh0
 sg+sl1mgWmL7yQVsEA29TBLrT8wGK+IUSJHYtvsCWJGwQLTE51lvmEBsFgFViavnt7GC2LwC
 lhLdjb3MEEcoSPx8uowVYoGTxLeVFxkhFohIzO5sY57AKDALibuAkXEVo2RqQXFuem6yYYFh
 Xmq5XnFibnFpXrpecn7uJkZwGGtp7GC8N/+f3iFGJg7GQ4wSHMxKIrw3P2qkCfGmJFZWpRbl
 xxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbLxMEp1cDkv0ciJWS5tKxGZPmMw24r
 NsjeKF534s4/tbNqc98Wsc34/S3zjFxs8+E7587eN27YO4WH79REPgF9//tGJ7j/C6tfkbwp
 wlb98477E7+TH38FdX390/x8TVjc9JybhyMlF7xftfN19iTP/R/SFj3/d65+7v+az3dlDyX5
 LuKSClk1WdIip8DzF2ter/fOi1w795/NPrOrMdNn97J0JT/uSX+uT9A6d/hl9Vx592jrWS5B
 3zadm954dZ+CySaRber8CrdrXu9ovHdnre7iUtdpW43+Pr+8yVTsotD1xdP5m3sEljwT9V3r
 Nmty6TTb89/mF4ks1ukWuvdjx4S3qz5N4Y52a+oWU7kjtcPrS0fmq/9KLMUZiYZazEXFiQDB
 rTlS0gIAAA==
X-CMS-MailID: 20240426063427epcas1p249956fd332cf3341d014abc1ec43d286
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240422094912epcas1p1aa89127f11df8079559a1390c1e1f9e4
References: <0109018f05328901-68599362-7b54-47e2-b54f-aa081ca231b9-000000@ap-south-1.amazonses.com>
 <CGME20240422094912epcas1p1aa89127f11df8079559a1390c1e1f9e4@epcas1p1.samsung.com>
 <0109018f05359741-62286139-e55d-4816-bcca-ce0c4cbcafb3-000000@ap-south-1.amazonses.com>
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
> From: Bhargav Raviprakash <bhargav.r@ltts.com>
> Sent: Monday, April 22, 2024 6:49 PM
> To: u-boot@lists.denx.de
> Cc: d-gole@ti.com; dan.carpenter@linaro.org; jh80.chung@samsung.com; sjg@chromium.org;
> trini@konsulko.com; m.nirmaladevi@ltts.com; Bhargav Raviprakash <bhargav.r@ltts.com>
> Subject: [PATCH v4 5/5] power: regulator: tps65941: Add TPS65224 PMIC regulator support
>
> Reuse TPS65941 regulator driver to adds support for
> TPS65224 PMIC's regulators. 4 BUCKs and 3 LDOs, where
> BUCK1 and BUCK2 can be configured in dual phase mode.
>
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/regulator/tps65941_regulator.c | 280 ++++++++++++++++++-
>  1 file changed, 267 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/power/regulator/tps65941_regulator.c
> b/drivers/power/regulator/tps65941_regulator.c
> index d879c2301b..5809a53fa2 100644
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
> @@ -328,9 +556,13 @@ static int tps65941_ldo_probe(struct udevice *dev)
>  	case TPS65941_LDO_ID_1:
>  	case TPS65941_LDO_ID_2:
>  	case TPS65941_LDO_ID_3:
> -	case TPS65941_LDO_ID_4:
>  		debug("Single phase regulator\n");
>  		break;
> +	case TPS65941_LDO_ID_4:
> +		if (chip_id != TPS65224) {
> +			debug("Single phase regulator\n");
> +			break;
> +		}
>  	default:
>  		pr_err("Wrong ID for regulator\n");
>  		return -EINVAL;
> @@ -346,6 +578,9 @@ static int tps65941_buck_probe(struct udevice *dev)
>  {
>  	struct dm_regulator_uclass_plat *uc_pdata;
>  	int idx;
> +	ulong chip_id;
> +
> +	chip_id = tps65941_get_chip_id(dev);
>
>  	uc_pdata = dev_get_uclass_plat(dev);
>  	uc_pdata->type = REGULATOR_TYPE_BUCK;
> @@ -356,16 +591,35 @@ static int tps65941_buck_probe(struct udevice *dev)
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
> --
> 2.25.1



