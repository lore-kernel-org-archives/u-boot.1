Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728F2CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 10:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F1C884B56;
	Fri,  8 May 2026 12:55:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g5j+QUqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE32084C6E; Fri,  8 May 2026 12:55:26 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 194C984AE9
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 12:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so1177531f8f.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 03:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778237724; x=1778842524; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=of6yfKGGr3gZyxeIT+WLEt3LdynOI2Evj/UIpkcIjVw=;
 b=g5j+QUqpUE8MGpErrOUC017ZPGQRlQ7c33Tje13vWzrVUxAIAMKK5d8nsL7c4gY7Cc
 fzrG2D0TMvaaUGYlFtEdLWc8wnnXpB+EHox3OqIcdvvgTAj7yq44axsEjtAuHTHD+xlR
 0nxtogva3Bg+RYE5b0wNHQtGpaIpps+Q+EcZRryyol8Z0QNOV1HooCXmCKDKjlZ6+/Rp
 YcheqrDgEv7mzR6DRSLQf+hlpKpnUeQkQUnGzB24SGLZ4jahhS0Pwi0qg6N8Sv23KMi7
 gzkBlq2+xG9D984LrT7OHx5Dzb9lDGk8gLRKu+7+8vctSkYW2sU05QdfMV3rFtFZRxPh
 ypCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778237724; x=1778842524;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=of6yfKGGr3gZyxeIT+WLEt3LdynOI2Evj/UIpkcIjVw=;
 b=dEtsbAOLk72lvmfVi3t74NLyt5V3ZH0shTxcDmC9qpJ/rkhxlUuD7NHaJNOfK12/qD
 qYxsumipmPGcjFLBzx2dcmFi114G5CoBRCN2gK92E0b+X6zvoo2/PtQdHBMKylebT6nq
 GUuRapUnoP8uPwiQtPqkYx7PemYpFmMYZ/0C6M0Ci/3uhx0TndB1E6WcdW2C4dCHiO+C
 VXJpHgl/O2Sd6YIOGtwJI8IycOLksXZJtTgPPpyUYq/kM3fdnrX2qCKrqxLY7gkD3KpO
 yZevdhhb1lcsXRdGuJZeQTjZS3bCxTTZUAPWylm9qMThZdOwKqfc7nKHwZwG9AcwV+OF
 YQEw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MwiST+zxr0yk/j1oxgYpUFP07Vj2BKjHQius4GaMpTJ3LcuwfIR4kKDtMQjMMR0Q6i6cMIH8=@lists.denx.de
X-Gm-Message-State: AOJu0YyziKGniKI+amEbHG2xipOaPffqsx+YohqwWAhAtbamkamKIG+c
 8fcduA8glf7dR2GRVhey8gXaYQ3R4xzqOBNwbt57ShfC3YnCiS3eCckMoo7q10qHKEE=
X-Gm-Gg: Acq92OG/kPhf3Hn3kRbQ3CVUBchdTHQlrDPyaKmhXyiXZoaxDo9Xs014DrxYXtn+LX8
 J4Ad7qxWeP9G2/INSwAcXpPJHWShhtYvxLz2eTNW/Qo6nR3ynPThFt5YoaFtojG8GSmT0Z/Nz25
 KM8LmLeA1GE0Qen8hjK18OYhh+509LJfQzqoL45lxxe18eeiIjKjwq+YjcWy1Bjam0ZV28xI65Y
 b1FwD1Az5gfFreCVSQbpeC50Nk2UEL2g80Q913vDJEVsVBWFlIPS510ZxWOVcPn/q4SQEhHrUEe
 DylfBSbatBYASLLCcH7eHHXS6nrdC4todIGJJcNunk1T7gLjErNqqKUyx1r7DjfLkQrKfSfTjWB
 quu7ch5Jk4L5iLoF6wvr6uTK/iELI1MRbGLOaswDBGd7E7UZhXKVgCqW/iVkEyMq03zGKlCkXJm
 vDWmri3WXHCgsGLKFzA/1iOhAFGzZ/ZKkClpMEN/plE3Hhk5j+ZmdEScm1iU7nd/gQT3mpj+g9U
 9TrSCHonOtr46kq6lsHdhU27LI1ivW440B1MHtq5AwCyM/GghSg7to6z4f0S/0HbzDl1L0RjUlJ
 eeVZzSOd7SkFJCw678gbwZ3/0PE5tv87GTIGa53BbpqN/Ylw+TfpxObKVmWDh0HWq6kv4f7bd03
 WZqCPPrYsrTsFhqP2ETLL4tsT7bePNzkOplkiARmQFSQOY7ToBXhx9/+PzMvJTCJBNWVyfopzWz
 VEsSQQdwFavOC8z5xpnLaCl9iyqvAY6XWKtU2f7BL8FHe9PVW4k1j8yaP6QoW4qbWdtmJMV2mC6
 o/aKd7PltCDBuvKhdPtfiSaomq4zdw1l7un3W5Hbxg=
X-Received: by 2002:a5d:5d87:0:b0:43c:fa96:d939 with SMTP id
 ffacd0b85a97d-4515c575359mr18884215f8f.22.1778237724509; 
 Fri, 08 May 2026 03:55:24 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549120eb95sm3383888f8f.20.2026.05.08.03.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 03:55:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 May 2026 13:55:23 +0300
Message-Id: <DID8NWGMKT0I.114JR5DH88JQ1@linaro.org>
Cc: "Aidan" <aidan@wolfssl.com>
Subject: Re: [[PATCH v2] tpm: Add wolfTPM library support for TPM 2.0 02/12]
 include: add byteorder macro guards and SHA384 hash wrapper
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "David Garske" <david@wolfssl.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260316181447.2986278-1-david@wolfssl.com>
 <20260316181447.2986278-3-david@wolfssl.com>
In-Reply-To: <20260316181447.2986278-3-david@wolfssl.com>
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

> + */

[...]

> +int wc_Sha384Hash(const unsigned char *data, unsigned int len,
> +		  unsigned char *hash);
> +#endif /* WOLFTPM2_NO_WOLFCRYPT */
> +
>  #endif
> diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/=
generic.h
> index bee0ff60336..def601eed2b 100644
> --- a/include/linux/byteorder/generic.h
> +++ b/include/linux/byteorder/generic.h
> @@ -89,12 +89,6 @@
>  #define le32_to_cpu __le32_to_cpu
>  #define cpu_to_le16 __cpu_to_le16
>  #define le16_to_cpu __le16_to_cpu
> -#define cpu_to_be64 __cpu_to_be64
> -#define be64_to_cpu __be64_to_cpu
> -#define cpu_to_be32 __cpu_to_be32
> -#define be32_to_cpu __be32_to_cpu
> -#define cpu_to_be16 __cpu_to_be16
> -#define be16_to_cpu __be16_to_cpu

I'd prefer leaving this as is and add any required ifndefs to the wolfTPM p=
art

Cheers
/Ilias
>  #define cpu_to_le64p __cpu_to_le64p
>  #define le64_to_cpup __le64_to_cpup
>  #define cpu_to_le32p __cpu_to_le32p
> @@ -120,6 +114,31 @@
>  #define cpu_to_be16s __cpu_to_be16s
>  #define be16_to_cpus __be16_to_cpus
>
> +/*
> + * Check if byte-order functions are already defined by the system:
> + * wolfTPM, wolfCrypt, and U-boot all define these functions, so
> + * we need to check if they are already defined before defining
> + * them again.
> + */
> +#ifndef cpu_to_be16
> +#define cpu_to_be16 __cpu_to_be16
> +#endif
> +#ifndef cpu_to_be32
> +#define cpu_to_be32 __cpu_to_be32
> +#endif
> +#ifndef cpu_to_be64
> +#define cpu_to_be64 __cpu_to_be64
> +#endif
> +#ifndef be16_to_cpu
> +#define be16_to_cpu __be16_to_cpu
> +#endif
> +#ifndef be32_to_cpu
> +#define be32_to_cpu __be32_to_cpu
> +#endif
> +#ifndef be64_to_cpu
> +#define be64_to_cpu __be64_to_cpu
> +#endif
> +
>  /*
>   * They have to be macros in order to do the constant folding
>   * correctly - if the argument passed into a inline function

