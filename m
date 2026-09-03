Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99763C624A4
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 11:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32ED180FB2;
	Thu,  3 Sep 2026 11:37:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zNXUNcEhojs9; Thu,  3 Sep 2026 11:37:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5093880F9F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788435474;
	b=mxU+NGpW7WfsoFzM/QVcSzNZhyYXoSAqVsHKA+++B1gAnVq2qIME3dr7NZSMYdChKAbS
	 PwXb4iC31i361MC8YYh7JatRhHsjHWa6iZJp6VYmrgPtU/RclK2RMlNRxk+EyvBEI1K+8
	 jYeJe3MjcwkuKV3y6fBwcJluVGeaUxo0E6EUOgYW8AWFlQpLPbnPC9rpQiSK9wFni9iEh
	 9h7yOwKO8ihhtDSX8fyJWBc5Ps5nns23LjsZbZDScZMAWxiGeGSPlaMOnnwIQXuEhua1C
	 AVvOCtI7Q1wy9d+0WuJhNNzt/LhXX/r27SQzSZi9qemzcti6H7yOQQwMpLoTTltao0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788435474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mDggzeDv1l/0y+ovE5ICcCCZ9mYa2oZpYQWZKe3lwNo=;
	b=Vx3sCNx2KqX6EngRLl472scFtaVbYn01ckJIO6QOBKPu74jnRHbX4a/5mSd/D17aMKdY
	 WkQt/kS3lQIAtcd1MAfHMQfAkI0jcH5/wPWEuBNSQ0He33CaqK+/xgFBrIx2s4GZiIlqD
	 WUgKuOOfoaHJDCOBP9K2EfDOXQYv02QWoni0K8QWHwSrzI91QlxmLncjIvMRo6gRgNP6f
	 krir6UL/yhR1gnXW1PNnXXJRNHGLCXxILMdeBzkjfPzDV/ngJJVgJCjo4J/3GtkxEekCd
	 iG5jQOiDJg95OoqjFbG6549tq6Yb2AcyeuHvs7uRv6PGcILbWoVEKjny4+faVYRCd9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788435474;
	bh=mDggzeDv1l/0y+ovE5ICcCCZ9mYa2oZpYQWZKe3lwNo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PUX/tEPIanLokgAhnl+K3zoAJZSOOjZzXK/u+Uh/L7mRxoUuKuMAFDrQrP7/SeJk/
	 PW+91nbacpH8AQvXim8Lqkiwiv+GMsp0tcUpPqw7bgKwgVLLrbYaUiZf0AVXd8i3mC
	 X7V9qtTIIrq0/S33SmpaQfqnRuJO6wVm58+3gXmkGynVBklUAUWe1Ny1PAMHRMWzi5
	 cIqUC8tnMK2mW4NrtuhZCljaWhqTOagF4eZtTx7Kp1B4DRyiI/88AY57+8s6PCAnqu
	 E8Y/FutNssgtwV7E3U0eCaUhkbmFnFjMdOR31/6ROtE4aK+JPxyKaA/Cs4BAQ2e9XT
	 2UusVOxKmPI8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5093880F9F;
	Thu,  3 Sep 2026 11:37:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B844422
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 11:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D25A4043E
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 11:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aAR3gXO-0UY3 for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 11:37:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0D4934042D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788435471;
 b=OzLucOC2sl5wnD2XZhnv8sOVpCEyL3z3AVQBiWEgcrQyNd1T0K2qpiAiWWG08WgGwACK
 4xT1wZ8JEMXNMbFiz8WawxLfn0A++JiogNmsZPi8kBnum3L4UQN8yGwS7BmfGJYAnWGDd
 9IDUa1D2L87LzaXL0cXo9C7hZ4MtSeI3oBjZ+QH6LoGlEIXR2KXzIiFbR5DsSmfVwXXNc
 fqSyVe2KskyGu0tXuECylfXzkFha3MJZNIqiTZoUx5EH4tgYYd3V5aj9B7vsRY+IPoNC3
 otem7QHmS/EuMG8s7QIC7RH2AMNNDjvWzEsKJTxlDH+Bu9rQYNIbTkrsVtI/puLIveQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788435471;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=mDggzeDv1l/0y+ovE5ICcCCZ9mYa2oZpYQWZKe3lwNo=;
 b=Lq2e9dFpBx54ba8vArdGIDN5M2PfRNCIEvyks3Sr+fujjqQa8GJYRhSW1JcS6PUXeP1C
 LqpdNg2yxklPa50BoVmJ02BesmJztEIddsxZKUqlvR2KiuaCgJpk/1ujTX5969BhrUyS+
 aG3ywL7azxOeev5Pvl5s3LD9qUc/64doZW1uAbNOuMjIHxzgGYpVIjJ68jNPmkL0fh2UA
 gqIXEhFg+bqqE5rQvrO5don1wMEkBts5PPB8O8RQEjAVwyo2Ty/uM3AbyJAQJJKZO6zeo
 TgoxCm2eAQUqCSpv3mm8PH893EYQZjKpr8fRwjKSD7RVcEnn4F5x5Iz41anvdBq53Dg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qHox+PG1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=qHox+PG1
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D4934042D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 11:37:48 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48436216a98so1423383f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788435466; x=1789040266;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mDggzeDv1l/0y+ovE5ICcCCZ9mYa2oZpYQWZKe3lwNo=;
 b=qHox+PG1KfXUNs3ygEzv55yDTN+f0IDURU4FlyUV0lZxrxip6v3WnCpzYtXsmCiaB9
 ZJdeeOntxvqqRU0JiUfVAk5TPsJ3BjtFhZsIImu6GOoasCItpNIQwuQCT7r0MtKmG1Km
 FfFA4JUjWvz8m1RM4C1PJIcfZxnEmoYmVviAgQFyyao5Tbf/w48XUNoNCu2RNRoHE1/M
 Qj7RjdMYWAugUY6eGv2eIPYJ6AasuCmSnd/bpBmMbDp66nekimDx+pyNjcfFguVvvX/9
 lkYMRH5o0fPHJwBXyguNYRw7q9Xa7WhnwoVkua8lEtsknEOrpaCMvX3ZkfmAF4PzQ0KE
 6EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788435466; x=1789040266;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mDggzeDv1l/0y+ovE5ICcCCZ9mYa2oZpYQWZKe3lwNo=;
 b=eviY4buihlbBVYu+/15XiwXZFDnSAXAMMi1zJ13JubimiDGZaS44go6qVQr7OUkw8Y
 pb4pgcZmsI4Ypg/QdtQn073vI+ocmjIKA7JxZIXBw+GVhfIvl7OayMwEc8jaErwKj4Ti
 zlP5hywFFFOCtG7SIDaEZ6G+BZvpMg146YMOJAF6zN6r8B+698Idok4s7kCqN+IDcRBk
 2pK6/JYwn1Zlhl2XiHPnYIaIErlEE1ZE6bwPsNN/Rbd6XbumqcRUeas38+NpdzoGuUL+
 fn5Wp828xzLnh0ddW38ulED8b/IwX809FQ435dATO2FCH7R/Uw9dCP6p28Q1RHx7jFq6
 kySw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMqY+chsHDwDrDJsJ2izOsN+7xrqDLZwmZkc1/IoyprHkoRM29ZUGylIkWwLb3uWFEq5yZ3Yw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kQGETN+WnFndfzxyCXK/lNKjI+vaAejD/ejr7tUrpaS57Bs/oq
 Iac2uHO1vj6O3Wv/axe0zIsCVkTaHU3hnSjC3Nvx8RHFeundX40Hzghh3k9WK0igzo4=
X-Gm-Gg: AYBFou2gukV/1iPzwd8YI54uwns+o8sZzZAGlk05h7N3Dz3enQp4PLpidKJB5J6lCLz
 FTAxGMuC8DGfrZroOFTNbkBBiMSU0z3YIa0cwhmlXdNPwyOVyJrOxL6RG0naHXdqgvWNl/ic/dt
 Fhf2JDXNCXCylwuSn0F9/NFPwJU7me7ijSSuF2+n8cAO8CsWN+BopME6kk9ByIrgkBmim2LpXdr
 gxh+fCKRq2V37D/DEEOd6ScXeiTjndHd/c9VbrPqp5KD15qvlR/H6CDbkLxbhypMpA1hCSD9utd
 eMlwZr/GIEkDOCcTFIkrVArT58wjoWvRiHzUcBYt0kueccMt6BddTwM8tu+g7yJFBAWRuXFxL8m
 9zYLlqWBN6S6Qa+CQvygfulIXit54H4kKfhIhA7ONW8okO7sMHQ2MscT2Ui+5CADhJjL+BOAXf6
 BT9ZeCCY9G/qunboF0PAhrn7n8HYYjcRrypet8bQmQ0Wjrm7bC4Imfl46DB9rgQIBdsAf2MwG62
 IQBMmSaXQtQbrVDIEft3LaElA==
X-Received: by 2002:a05:600c:3495:b0:49c:ee36:10fc with SMTP id
 5b1f17b1804b1-49cee361162mr122574795e9.8.1788435466117; 
 Thu, 03 Sep 2026 04:37:46 -0700 (PDT)
Received: from [192.168.1.37] (p549d4d01.dip0.t-ipconnect.de. [84.157.77.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm122078095e9.1.2026.09.03.04.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 04:37:45 -0700 (PDT)
Message-ID: <9665575e-f7aa-4870-a88b-7412643dc571@linaro.org>
Date: Thu, 3 Sep 2026 13:37:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] sysreset: qcom-pshold: Configure PON reset type
Content-Language: en-US
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
References: <20260901195748.1192630-1-sumit.dhami@oss.qualcomm.com>
 <20260901195748.1192630-2-sumit.dhami@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260901195748.1192630-2-sumit.dhami@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Sumit,

On 01/09/2026 21:57, Sumit Singh Dhami wrote:
> Configure the PMIC PON PBS reset type before deasserting MPM PS_HOLD.
> 
> The PON PBS reset sequence requires PS_HOLD_RESET_CTL2 to be cleared,
> the requested reset type to be written to PS_HOLD_SW_CTL, and
> PS_HOLD_RESET_CTL2 to be enabled again before deasserting MPM_PS_HOLD.

why? what does this fix? what do these registers encode? what platforms
need this? Please include this context in v2 and in your cover letter. I
shouldn't feel the need to look at PMIC register maps to understand what
this is for.

> 
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>  drivers/sysreset/sysreset_qcom-pshold.c | 137 ++++++++++++++++++++++--
>  1 file changed, 130 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/sysreset/sysreset_qcom-pshold.c b/drivers/sysreset/sysreset_qcom-pshold.c
> index 45290478536..de7c0b388aa 100644
> --- a/drivers/sysreset/sysreset_qcom-pshold.c
> +++ b/drivers/sysreset/sysreset_qcom-pshold.c
> @@ -13,15 +13,94 @@
>  #include <sysreset.h>
>  #include <asm/io.h>
>  #include <linux/delay.h>
> +#include <power/pmic.h>
> +
> +#define PON_PBS_RESET_TYPE_WARM		0x01
> +#define PON_PBS_RESET_TYPE_HARD		0x07
> +
> +/*
> + * Reset State of PON_PBS_PS_HOLD_RESET_CTL2 register
> + */
> +#define PON_PBS_PS_HOLD_RESET_CTL2_S2_RESET_EN_BMSK	0x80
>  
>  struct qcom_pshold_priv {
>  	phys_addr_t base;
> +
> +	struct udevice *pmic;
> +	u32 pbs_base;
> +	bool have_pon;
> +
> +	u32 pon_pbs_pshold_sw_ctl_offset;
> +	u32 pon_pbs_pshold_reset_ctl2_offset;
>  };
>  
> +static int qcom_pshold_pon_cfg(struct qcom_pshold_priv *priv, u8 reset_type)
> +{
> +	int ret;
> +
> +	ret = pmic_reg_write(priv->pmic,
> +			     priv->pbs_base +
> +			     priv->pon_pbs_pshold_reset_ctl2_offset,
> +			     0x00);
> +	if (ret)
> +		return ret;
> +
> +	udelay(100);
> +
> +	ret = pmic_reg_write(priv->pmic,
> +			     priv->pbs_base + priv->pon_pbs_pshold_sw_ctl_offset,
> +			     reset_type);
> +	if (ret)
> +		return ret;
> +
> +	udelay(300);
> +
> +	ret = pmic_reg_write(priv->pmic,
> +			     priv->pbs_base + priv->pon_pbs_pshold_reset_ctl2_offset,
> +			     PON_PBS_PS_HOLD_RESET_CTL2_S2_RESET_EN_BMSK);
> +	if (ret)
> +		return ret;
> +
> +	udelay(100);
> +
> +	return 0;
> +}
> +
> +static int qcom_pshold_read_pon_offset(struct udevice *dev, struct qcom_pshold_priv *priv)
> +{
> +	int ret;
> +
> +	ret = dev_read_u32(dev,
> +			   "qcom,pbs-pshold-sw-ctl",
> +			   &priv->pon_pbs_pshold_sw_ctl_offset);
> +	if (ret)
> +		return ret;
> +
> +	ret = dev_read_u32(dev,
> +			   "qcom,pbs-pshold-reset-ctl2",
> +			   &priv->pon_pbs_pshold_reset_ctl2_offset);

Where are the bindings for this?

why are this offsets read from DT anyway? Do they really vary so much?
Can't we just match the pmics ID registers and pick the correct offset
per-pmic?

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int qcom_pshold_request(struct udevice *dev, enum sysreset_t type)
>  {
>  	struct qcom_pshold_priv *priv = dev_get_priv(dev);
>  
> +	if (priv->have_pon) {
> +		u8 reset_type = (type == SYSRESET_WARM) ?
> +				 PON_PBS_RESET_TYPE_WARM :
> +				 PON_PBS_RESET_TYPE_HARD;
> +		int ret;
> +
> +		ret = qcom_pshold_pon_cfg(priv, reset_type);
> +		if (ret)
> +			debug("%s: failed to configure PON reset type: %d\n",
> +			      dev->name, ret);
> +	}
> +
>  	writel(0, priv->base);
>  	mdelay(10000);
>  
> @@ -35,9 +114,53 @@ static struct sysreset_ops qcom_pshold_ops = {
>  static int qcom_pshold_probe(struct udevice *dev)
>  {
>  	struct qcom_pshold_priv *priv = dev_get_priv(dev);
> +	struct ofnode_phandle_args args;
> +	ofnode pmic_node;
> +	int index, ret;
> +
> +	priv->have_pon = false;
>  
>  	priv->base = dev_read_addr(dev);
> -	return priv->base == FDT_ADDR_T_NONE ? -EINVAL : 0;
> +	if (priv->base == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	ret = dev_read_phandle_with_args(dev, "qcom,pon", NULL, 0, 0, &args);
> +	if (ret)
> +		return 0;
> +
> +	index = ofnode_stringlist_search(args.node, "reg-names", "pbs");
> +	if (index < 0) {
> +		debug("%s: referenced PON node has no 'pbs' reg\n", dev->name);
> +		return 0;
> +	}
> +
> +	ret = ofnode_read_u32_index(args.node, "reg", index, &priv->pbs_base);
> +	if (ret) {
> +		debug("%s: failed to read PON 'pbs' reg: %d\n", dev->name, ret);
> +		return 0;
> +	}
> +
> +	ret = qcom_pshold_read_pon_offset(dev, priv);
> +	if (ret) {
> +		debug("%s: failed to read PON offset configs: %d\n", dev->name, ret);
> +		return 0;
> +	}
> +
> +	pmic_node = ofnode_get_parent(args.node);
> +	if (!ofnode_valid(pmic_node)) {
> +		debug("%s: failed to get PON's parent PMIC node\n", dev->name);
> +		return 0;
> +	}
> +
> +	ret = uclass_get_device_by_ofnode(UCLASS_PMIC, pmic_node, &priv->pmic);
> +	if (ret) {
> +		debug("%s: failed to get PMIC device: %d\n", dev->name, ret);
> +		return 0;
> +	}
> +
> +	priv->have_pon = true;
> +
> +	return 0;
>  }
>  
>  static const struct udevice_id qcom_pshold_ids[] = {
> @@ -46,10 +169,10 @@ static const struct udevice_id qcom_pshold_ids[] = {
>  };
>  
>  U_BOOT_DRIVER(qcom_pshold) = {
> -	.name 		= "qcom_pshold",
> -	.id 		= UCLASS_SYSRESET,
> -	.of_match 	= qcom_pshold_ids,
> -	.probe 		= qcom_pshold_probe,
> -	.priv_auto	= sizeof(struct qcom_pshold_priv),
> -	.ops 		= &qcom_pshold_ops,
> +	.name       = "qcom_pshold",
> +	.id         = UCLASS_SYSRESET,
> +	.of_match   = qcom_pshold_ids,
> +	.probe      = qcom_pshold_probe,
> +	.priv_auto  = sizeof(struct qcom_pshold_priv),
> +	.ops        = &qcom_pshold_ops,

Please don't spuriously reformat blocks like this.

>  };

-- 
// Casey (she/her)

