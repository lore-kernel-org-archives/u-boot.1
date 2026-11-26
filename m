Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E4606A329
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WeCsAlC9;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fM1zUFvr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 713FA811A7;
	Thu, 26 Nov 2026 13:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8u74P4ZyiqJt; Thu, 26 Nov 2026 13:50:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 94CF4811A3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795701016;
	b=EiKQhYL6ndOCYqnxVG5oVs+2eyqXI+x70giWAKgnHY+DxvNQOgPoAYSqJn9ny3XovfuT
	 BRyuVUYVSj2vfjKH27ocIz80ff9XgMG6K37QIrarotEdk8zxee5hs3fhDDAfkKajYPrGy
	 zUn2HSOk1DVRK0PdcP5+hp0rGa9k7uEGNwso8RS7HAJyQu3NPh9GUFLRG3NjvOjgy8rVr
	 0wLxCDxgNigvUW9nFOsBX9TRR0NEFnMRVishpG3H8KbYoUNuuTYMQS6rXV3BjIVOwqA4i
	 uafolvH6Eg48e4BazdV8lkc3O+ynb3v11h59MNxvijpCHLCw0cdfmIwcPhMKd1eB6dQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795701016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NRgTFDa8NmUGiEaaXagLEvQggo//rD+SzH20sHtuCf0=;
	b=sJ4GmZZaK76PzyEa7PEnwFfj6QaXnw6WzsECUvpXXNthULybloQiL8TD/xp7OesS6BDA
	 JZ/80IJ/S6V58VjIAfUuK/yhMT6djD98YLDXcVpmzlpk0Ih02CFYzioYsUgpPSjN4WZp3
	 F+mBBPQGSYCaq9piVPf/sXGCs+H16TpQERb74cgPncu7/+qqJtI52lCuxWDIUOU5wWH/c
	 ksRacpjH96kbePhqjl4g+zjobHkvjr5D9s9XbglUJwHBBE+/JX4FHBV4aha4p4ysHS5yk
	 /24voJApf3fzyyof3lIFU4IhIs+jMV+zBbKudh60p6RNglQ3e3c/jgAVbQTgML8iajg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795701016;
	bh=NRgTFDa8NmUGiEaaXagLEvQggo//rD+SzH20sHtuCf0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WeCsAlC9tgUE3b8EMyR3ApBpvz6PQ/0MPCnKw53t+wMP7Cnx5ua8TSt2Ns3RNj8jr
	 mvFQew6nq7LOpx01Ep6/tK/p2dCRJcccjKqh3/t4xbnpqB1u3VI3AeTLqcJT9Qc03w
	 uBa8DWb05w7upR/BVIwOS0LdFJs1Swo6bSHpJjRLRdinM9EDTEEXbFWHDDk+vMKZY0
	 vn8Q7RAIH3mh68IszLAQ2/W3fJjQtr9s/MdD1sum6u3EWEabZru1i+84YfO9R7HnNk
	 RtlFzjWIimuv4bVSvgkKxLz1S9q+vqfTTbFZMEBAR98TdEdQMcnUbOqYOgSMORX/mr
	 7YRgWb/leEGHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94CF4811A3;
	Thu, 26 Nov 2026 13:50:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9404B22B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79B67404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id he9cZFa9qgHH for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:50:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AEA2640111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=fM1zUFvr
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AEA2640111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:50:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A891E40341;
 Thu, 26 Nov 2026 13:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67A61F000D1;
 Thu, 26 Nov 2026 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795701013;
 bh=NRgTFDa8NmUGiEaaXagLEvQggo//rD+SzH20sHtuCf0=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=fM1zUFvraCQv6QIt+3s/LYFk9Tk6AEcIRooCjnahNtF8LzpLY50RjQcvkBG5ZYiV1
 LsxS5t6A8tQAEFEl1Lb1CvfSuIuT0wtlYNotLh+tnDQOPeJntNDhU0hF1mvy3BMvzi
 VgYF/LFEyEboSwBd3NwD4vfMdn5R0KrO/aaBtoOJleaQXQTYD/vvow+ovM/ePbUBAQ
 ISHdqcYU4xhVAnXv54Uk95UTm97fMmU59K9Jgvi+iBZr/rHp+7CQhSmQDB3LWEIKP4
 rboovlzG2CbRe9sdXqjUPwlJBO30a4DbRpIJui24khcuFZ5OZQnPqBTIf5AfoWyrQa
 nuNaNeQDkhp3w==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] regulator: qcom_usb_vbus: add support for
 qcom,pm4125-vbus-reg
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261116-pm4125-vbus-regulator-v1-1-a582ae58962a@oss.qualcomm.com>
References: <20261116-pm4125-vbus-regulator-v1-1-a582ae58962a@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 19:20:06 +0530
Message-Id: <179570100675.130558.4504158408296270405.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-16 22:22 +0530, Balaji Selvanathan wrote:
> PM4125 uses a VBOOST block instead of the OTG one. Add the register
> layout, get/set value ops, and pick the highest supported voltage
> within the regulator-min/max-microvolt range from the DT at probe.

Please focus on "why" in commit messages. Which SoC requires this
regulator support?

-Sumit

> 
> Taken from Linux commit d37664f99ef9 ("regulator: qcom_usb_vbus: add
> support for qcom,pm4125-vbus-reg")
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/power/regulator/qcom_usb_vbus_regulator.c | 82 ++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/regulator/qcom_usb_vbus_regulator.c b/drivers/power/regulator/qcom_usb_vbus_regulator.c
> index 07f118d4797..adba3376119 100644
> --- a/drivers/power/regulator/qcom_usb_vbus_regulator.c
> +++ b/drivers/power/regulator/qcom_usb_vbus_regulator.c
> @@ -18,15 +18,24 @@
>  enum pm8x50b_vbus {
>  	PM8150B,
>  	PM8550B,
> +	PM4125,
>  };
>  
>  #define OTG_EN				BIT(0)
>  
>  #define OTG_EN_SRC_CFG			BIT(1)
>  
> +/* PM4125 uses a "VBOOST" block instead of the OTG block */
> +#define PM4125_VBOOST_EN_SRC_CFG	BIT(0)
> +#define PM4125_VBOOST_SEL_MASK		GENMASK(1, 0)
> +
> +static const int pm4125_vboost_uV[] = { 4250000, 4500000, 4750000, 5000000 };
> +
>  struct qcom_otg_regs {
>  	u32 otg_cmd;
>  	u32 otg_cfg;
> +	u32 en_src_cfg;
> +	u32 vsel_reg;	/* 0 if the voltage is not selectable */
>  };
>  struct qcom_usb_vbus_priv {
>  	phys_addr_t base;
> @@ -37,10 +46,18 @@ static const struct qcom_otg_regs qcom_otg[] = {
>  	[PM8150B] = {
>  		.otg_cmd = 0x40,
>  		.otg_cfg = 0x53,
> +		.en_src_cfg = OTG_EN_SRC_CFG,
>  	},
>  	[PM8550B] = {
>  		.otg_cmd = 0x50,
>  		.otg_cfg = 0x56,
> +		.en_src_cfg = OTG_EN_SRC_CFG,
> +	},
> +	[PM4125] = {
> +		.otg_cmd = 0x50,
> +		.otg_cfg = 0x56,
> +		.en_src_cfg = PM4125_VBOOST_EN_SRC_CFG,
> +		.vsel_reg = 0x52,
>  	},
>  };
>  
> @@ -95,6 +112,41 @@ static int qcom_usb_vbus_regulator_set_enable(struct udevice *dev, bool enable)
>  	return 0;
>  }
>  
> +static int qcom_usb_vbus_regulator_get_value(struct udevice *dev)
> +{
> +	const struct qcom_otg_regs *regs = &qcom_otg[dev_get_driver_data(dev)];
> +	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	if (!regs->vsel_reg)
> +		return -ENOSYS;
> +
> +	ret = pmic_reg_read(dev->parent, priv->base + regs->vsel_reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return pm4125_vboost_uV[ret & PM4125_VBOOST_SEL_MASK];
> +}
> +
> +static int qcom_usb_vbus_regulator_set_value(struct udevice *dev, int uV)
> +{
> +	const struct qcom_otg_regs *regs = &qcom_otg[dev_get_driver_data(dev)];
> +	struct qcom_usb_vbus_priv *priv = dev_get_priv(dev);
> +	int i;
> +
> +	if (!regs->vsel_reg)
> +		return -ENOSYS;
> +
> +	for (i = 0; i < ARRAY_SIZE(pm4125_vboost_uV); i++) {
> +		if (pm4125_vboost_uV[i] == uV)
> +			return pmic_clrsetbits(dev->parent,
> +					       priv->base + regs->vsel_reg,
> +					       PM4125_VBOOST_SEL_MASK, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int qcom_usb_vbus_regulator_probe(struct udevice *dev)
>  {
>  	const struct qcom_otg_regs *regs = &qcom_otg[dev_get_driver_data(dev)];
> @@ -103,21 +155,49 @@ static int qcom_usb_vbus_regulator_probe(struct udevice *dev)
>  	int ret;
>  
>  	/* Disable HW logic for VBUS enable */
> -	ret = pmic_clrsetbits(dev->parent, otg_cfg_reg, OTG_EN_SRC_CFG, 0);
> +	ret = pmic_clrsetbits(dev->parent, otg_cfg_reg, regs->en_src_cfg, 0);
>  	if (ret < 0) {
>  		log_err("error setting EN_SRC_CFG: %d\n", ret);
>  		return ret;
>  	}
>  
> +	if (regs->vsel_reg) {
> +		struct dm_regulator_uclass_plat *uc_pdata =
> +			dev_get_uclass_plat(dev);
> +		int i;
> +
> +		/* Highest supported voltage inside the DT constraints */
> +		for (i = ARRAY_SIZE(pm4125_vboost_uV) - 1; i >= 0; i--) {
> +			if (pm4125_vboost_uV[i] >= uc_pdata->min_uV &&
> +			    pm4125_vboost_uV[i] <= uc_pdata->max_uV)
> +				break;
> +		}
> +		if (i < 0) {
> +			log_err("no voltage in %d-%d uV range\n",
> +				uc_pdata->min_uV, uc_pdata->max_uV);
> +			return -EINVAL;
> +		}
> +
> +		ret = qcom_usb_vbus_regulator_set_value(dev, pm4125_vboost_uV[i]);
> +		if (ret < 0) {
> +			log_err("error setting %d uV: %d\n",
> +				pm4125_vboost_uV[i], ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
>  static const struct dm_regulator_ops qcom_usb_vbus_regulator_ops = {
>  	.get_enable = qcom_usb_vbus_regulator_get_enable,
>  	.set_enable = qcom_usb_vbus_regulator_set_enable,
> +	.get_value = qcom_usb_vbus_regulator_get_value,
> +	.set_value = qcom_usb_vbus_regulator_set_value,
>  };
>  
>  static const struct udevice_id qcom_usb_vbus_regulator_ids[] = {
> +	{ .compatible = "qcom,pm4125-vbus-reg", .data = PM4125 },
>  	{ .compatible = "qcom,pm8150b-vbus-reg", .data = PM8150B },
>  	{ .compatible = "qcom,pm8550b-vbus-reg", .data = PM8550B },
>  	{ },
> 
> ---
> base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
> change-id: 20261116-pm4125-vbus-regulator-e8c0f37b6a05
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> 
> 


