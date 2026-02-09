Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDACDE7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:53:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D45A83C54;
	Mon,  9 Feb 2026 19:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bwFug0EK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF3E83C67; Mon,  9 Feb 2026 19:53:55 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EAA58397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so41777065e9.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770663232; x=1771268032; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jeofYbKiymANG8idygkid5nl3BwZlzlbV7Rz29jhivk=;
 b=bwFug0EKHt2ZsfTQHRIK+LFhxcO7HUHn38hjfJOtCGYkpfy8OPKO6WjOTFRHLTgHnO
 YFLimCx5CwYDBccWZMpPIicWj3DdYk8jAv+WV66iWZ30tQ3XrUO3RA6W4HY1bhRxtq5/
 5MzlXlJ5Hgj5FaFirVx6DmULupR+/sfksQh3lV/2P3gMZjJHj5JxmYelRpT9xQ6uJVqH
 sQ+qg8Zw1Yc/GOlwe5TF4X7vnTOw8Kl1E0Zp4k9GyG0xur4zY32twQCiXNhxRKvEE+I3
 armqhvUakPfO1W3hztP4H5x7ZiVZkxQ+c89YiEmwqRXfi76Oa82cMCrF67tzSMlvbR/D
 Wilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770663232; x=1771268032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jeofYbKiymANG8idygkid5nl3BwZlzlbV7Rz29jhivk=;
 b=Xh4bL8JGEI0w3LqNed0Li9SWEFK+f2ziZCK8eH5NTvMKzyi5JcjT2eIrGHreqb/mxm
 Kppa7oo6R+qWp6GyPZhuD6Y78uuxQopWjj8Q6EW753UVdGOO3q6dzL06UpS5xA9f/ult
 2dYjvijHJ1Y3oSzoe0Vn85DdiEz5kOuEWa19FMaZkHerrOUz2d/OLYynPGdVvl68ApnS
 ahYWlGnM+PwTNz7+nR4TpGBU05z0OWZdFV27pOFIHsgCUld30E2vb7zBU6FK5x6cIlRi
 wDUV4NwFhpw35vzvtA07tulvX4v2rKsEBQM9maamD29An4iN6TfLiMBBJBcKjnET0Tfc
 YIXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoEU82ksTxlLzcZkh2V5+aZdZBbaaohoHfYAlrwUgxJO87wbJcgsQwNvT2HEKa5Wu6mVM/Cjs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7ovaeF1s2CTFGMU6xgosFts2TYCFnjgwIjLB7p2VUz+p97yEn
 6zH4P+5ReU00wxjsSsA1ubL7aVAL3s8XyJsXSn+gA0baULY9DAoh2u86yJwP5S/60EA=
X-Gm-Gg: AZuq6aIEHxXQv0c1gNAguzTz9jZqrNuHdAPZ2hWkZx5xqxM23GL1eBMlTl9ozQvCuj/
 C+bJrGdYQ6wsvafz6Yf9Hwoj6ZnwqSWhXzIZKtdNRjtgS0tORNzIASk9kFAt7sfO1bb0DTMsvnm
 mbi0i8L1iv6R9YtUE6x7hlKukzj2hu/V+bFJl9T1wc1RZvM7TEispZ0g3+3xyB1/3Js6w312xs/
 fsd56CnzXKbykzbFbFtKXbJfzYJ2bkhZOUFDP0z4SkANOFrn7JepoPQrBpIOABDxWnBBcRgAgit
 WnYBlNz4jwP00tgooBbtEEaTzDoUMfippn1m+HgT+BcmushCLBWlMgw9BnBQVeu82WzAEmvOdeY
 zAzcFb2n/UvwyBdL5pkqpgmT6o7BQF+HC2ZC5h8AaVNiYmBFEUE88dsL9mlwT7LrDvRRW3nmz0t
 ztciG1En8m5NU+NR4GwM21Uzb1ZShzTIqY1Sb8JsQaxMQNp6QZbA==
X-Received: by 2002:a05:600c:a08c:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-483201da29fmr175953065e9.8.1770663231866; 
 Mon, 09 Feb 2026 10:53:51 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d7e63b9sm6105145e9.10.2026.02.09.10.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 10:53:51 -0800 (PST)
Message-ID: <ebb9186d-61dc-41a3-98af-5d055ab1175e@linaro.org>
Date: Mon, 9 Feb 2026 19:53:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] tee: optee: Export OP-TEE message UID check API
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: trini@konsulko.com, neil.armstrong@linaro.org, jens.wiklander@linaro.org, 
 ilias.apalodimas@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
 <20260127062341.723966-2-sumit.garg@kernel.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260127062341.723966-2-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 27/01/2026 07:23, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> OP-TEE message UID check API can be useful to know whether OP-TEE
> is enabled on not assuming the corresponding SMC call is properly
> handled if OP-TEE is not supported.
> 
> This API can be used by platform code to know OP-TEE presence and
> on that basis OP-TEE DT node can be added as part of DT fixups for
> the OP-TEE driver probe to happen for both U-Boot and Linux.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/tee/optee/core.c | 5 +++++
>  include/tee/optee.h      | 9 +++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 5fc0505c788..4d67c948ec1 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -795,6 +795,11 @@ static optee_invoke_fn *get_invoke_func(struct udevice *dev)
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +bool is_optee_smc_api(void)
> +{
> +	return is_optee_api(optee_smccc_smc);
> +}
> +
>  static int optee_of_to_plat(struct udevice *dev)
>  {
>  	struct optee_pdata *pdata = dev_get_plat(dev);
> diff --git a/include/tee/optee.h b/include/tee/optee.h
> index 77729450bb6..d1194493780 100644
> --- a/include/tee/optee.h
> +++ b/include/tee/optee.h
> @@ -65,4 +65,13 @@ static inline int optee_copy_fdt_nodes(void *new_blob)
>  }
>  #endif
>  
> +#if defined(CONFIG_OPTEE)
> +bool is_optee_smc_api(void);
> +#else
> +static inline bool is_optee_smc_api(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #endif /* _OPTEE_H */

-- 
// Casey (she/her)

