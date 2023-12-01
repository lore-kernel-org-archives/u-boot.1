Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A1CC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 14:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1297B876AA;
	Fri,  1 Dec 2023 15:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NJvTiOsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF827876A7; Fri,  1 Dec 2023 15:52:51 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E19C58764D
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 15:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a0029289b1bso298527366b.1
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701442368; x=1702047168; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3sd7wZ3Y3r3zbl4/X5PAdSa2a1gfrbxofFzOR/zZyPY=;
 b=NJvTiOshprlmSjJ2SDFDvkVcDeC57aHDMV0EXPDuRqOLIhp5/Uyh1t+OpJdZKgc3CW
 J3QaX+tyXZUIFFwzaFFepKoky5nkXBeHHtUR9hZxafWVFFEjyLBigZ3avs7uOMwffcS/
 fQfkoYbWO39HU15RxXM27IyNagpd/hXauhCKmJauh6Kz8F3vVZ6FspMFhbv3eyM+NWWw
 aaZFDkZPjU5wz+ed/kmJJlu2jOtxkSoNdwUjmy9rFhUq/LqTX35TrL+msPYNkqQgPeVm
 TyxfcYz5vlThuCzQGYCtp71pAwMD29l3mtvJowqNVest6yswgPA92ERoE5xg20BuMXb9
 oYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701442368; x=1702047168;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3sd7wZ3Y3r3zbl4/X5PAdSa2a1gfrbxofFzOR/zZyPY=;
 b=f1cEcGlT+cmoGePp23AeZN/anEp/DEz82z6p7vuNVqkq56dUAp/cK0IeC19ism6m2h
 2lF54ASEMXj+vVUI0RSELe3htnKrW06TWBdiWMSqXD7ne7rtC6j5zcv3DmqLYr5CN45i
 jTkfuspWZiQ23hSP0rWxdI4ih+EF9SK1lurCOgGXxw+Bjt+TWISM/xxEsDLX0/CYHAEX
 wwLFYOTdAgp2375I8j09K/WQS+VzQ0n8jwV0YxHU1p0NtLhQOGFgIAxbP4eE99qwwjeq
 5g+rj3QooLBbAVpZVhGxWSvSfogzGqL3vTs2+ogp4PswJxZqRnvz+uL13DqsE26Nf3ya
 tf4Q==
X-Gm-Message-State: AOJu0YyzJZb8W9zu+9m81vkDHvUyNA8VUOcRA86zkPEQUip8EXGVVspS
 gmd6WJae+XMPdBQvoYCl1r8GUCKiVdrfiLFgLts=
X-Google-Smtp-Source: AGHT+IHs2ryyhsbGJWExdFpniN6NiR2SFvHSgDVL2UlQDfeNnnFA9U0XDy0Wt/D8BoM5aEOPzyIRhw==
X-Received: by 2002:a17:907:76d7:b0:a19:a1ba:8ce9 with SMTP id
 kf23-20020a17090776d700b00a19a1ba8ce9mr764987ejc.135.1701442368335; 
 Fri, 01 Dec 2023 06:52:48 -0800 (PST)
Received: from hades (ppp046103111243.access.hol.gr. [46.103.111.243])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a1709062acc00b009a193a5acffsm1969660eje.121.2023.12.01.06.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 06:52:47 -0800 (PST)
Date: Fri, 1 Dec 2023 16:52:45 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, stcarlso@linux.microsoft.com
Subject: Re: [PATCH 2/8] drivers: rollback: Add TPM2 implementation of
 rollback devices
Message-ID: <ZWnzPUVAPjk4heAM@hades>
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
 <20230912094731.51413-3-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912094731.51413-3-seanedmond@linux.microsoft.com>
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

Hi Sean,

On Tue, Sep 12, 2023 at 02:47:25AM -0700, seanedmond@linux.microsoft.com wrote:
> From: Stephen Carlson <stcarlso@linux.microsoft.com>
> 
> This implementation of the rollback uclass driver allows existing TPM2
> devices declared in the device tree to be referenced for storing the OS
> anti-rollback counter, using the TPM2 non-volatile storage API.  The
> rollback device must be a child of the TPM device.  For example:
> 
> 	tpm2 {
> 		compatible = "sandbox,tpm2";
> 
> 		rollback@1 {
> 			compatible = "tpm,rollback";
> 			rollback-nv-index = <0x1001007>;
> 		};
> 	};
> 
This node is part of the DT specification right? If we accept this, we
should figure out if we can add that to the specification.

[...]

> +/*
> + * Copyright (c) 2021 Microsoft, Inc
> + * Written by Stephen Carlson <stcarlso@microsoft.com>
> + */
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <fdtdec.h>
> +#include <rollback.h>
> +#include <tpm_api.h>
> +
> +struct rollback_state {
> +	u32 nv_index;
> +	struct udevice *tpm_dev;
> +};
> +
> +static int tpm_rollback_idx_get(struct udevice *dev, u64 *rollback_idx)
> +{
> +	struct rollback_state *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	if (!rollback_idx)
> +		return -EINVAL;
> +
> +	ret = tpm2_nv_read_value(priv->tpm_dev, priv->nv_index, rollback_idx, sizeof(u64));
> +	if (ret) {
> +		log(UCLASS_ROLLBACK, LOGL_ERR,

Wouldn't the init function below make sure the index is created? IOW
shouldn't this be a log_err()?

> +		    "Unable to read rollback number from TPM (ret=%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int tpm_rollback_idx_set(struct udevice *dev, u64 rollback_idx)
> +{
> +	int ret;
> +	struct rollback_state *priv = dev_get_priv(dev);
> +
> +	ret = tpm2_nv_write_value(priv->tpm_dev, priv->nv_index, &rollback_idx, sizeof(u64));
> +	if (ret) {
> +		log(UCLASS_ROLLBACK, LOGL_ERR,
> +		    "Unable to write anti-rollback version to TPM (ret=%d)\n", ret);

log_err()

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rollback_ops tpm_rollback_ops = {
> +	.rollback_idx_get		= tpm_rollback_idx_get,
> +	.rollback_idx_set		= tpm_rollback_idx_set,
> +};
> +
> +static int tpm_rollback_probe(struct udevice *dev)
> +{
> +	struct rollback_state *priv = dev_get_priv(dev);
> +	int ret;
> +
> +	/* initialize the TPM rollback counter NV index
> +	 * and initial to 0.  Note, this driver provides
> +	 * a NULL policy.
> +	 */
> +	ret = tpm_rollback_counter_init(priv->tpm_dev, priv->nv_index,
> +					NULL, 0);
> +	if (ret) {
> +		log(UCLASS_ROLLBACK, LOGL_ERR,
> +		    "TPM rollback init failed (ret=%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tpm_rollback_remove(struct udevice *dev)
> +{
> +	struct rollback_state *priv = dev_get_priv(dev);
> +
> +	return tpm_close(priv->tpm_dev);

I am not sure what this function is supposed to be doing. Why is it called
remove but only closes the tpm?

[...]

> +int tpm_rollback_counter_init(struct udevice *dev, u32 nv_index,
> +			      const u8 *nv_policy, size_t nv_policy_size)
> +{
> +	int ret;
> +	u64 data;
> +	u64 data0 = 0;
> +
> +	ret = tpm_open(dev);
> +	if (ret == -EBUSY) {
> +		log(UCLASS_ROLLBACK, LOGL_DEBUG,
> +		    "Existing TPM session found, reusing\n");
> +	} else {
> +		if (ret) {
> +			log(UCLASS_ROLLBACK, LOGL_ERR,
> +			    "TPM initialization failed (ret=%d)\n", ret);
> +			return ret;
> +		}
> +
> +		ret = tpm2_auto_start(dev);
> +		if (ret) {
> +			log(UCLASS_ROLLBACK, LOGL_ERR,
> +			    "TPM startup failed (ret=%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (ret) {
> +		log_err("TPM startup failed\n");
> +		return ret;
> +	}
> +
> +	/* test reading NV index from TPM */
> +	ret = tpm2_nv_read_value(dev, nv_index, &data, sizeof(u64));
> +
> +	if (ret) {
> +		/*read failed.  Assume the NV index hasn't been defined yet */
> +		ret = tpm2_nv_define_space(dev, nv_index, sizeof(u64), TPMA_NV_PPREAD |
> +					   TPMA_NV_PPWRITE | TPMA_NV_PLATFORMCREATE,
> +					   nv_policy, nv_policy_size);
> +

Since the policy is NULL and no password is provided how do we trust this counter? 

The TPMs allow the creation of an 'NV Counter Index' which would be better
for what you are trying to do here.

> +		/* initialize the rollback counter to 0 */
> +		if (ret == TPM2_RC_NV_DEFINED || !ret)
> +			ret = tpm2_nv_write_value(dev, nv_index, &data0, sizeof(u64));
> +	}
> +
> +	return ret;
> +}
> -- 
> 2.40.0
> 

Thanks
/Ilias
