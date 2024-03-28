Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39E9C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 07:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CDD787D70;
	Thu, 28 Mar 2024 08:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B5x5wtAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D64868808A; Thu, 28 Mar 2024 08:37:04 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE4083346
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d29aad15a5so7056771fa.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711611422; x=1712216222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bSx/xGGusUfNhrHTP2NwCGypD2D2dm5vNsW2fOvONFw=;
 b=B5x5wtAiSACLFUgpxq8Fa9M+JQFe5pBqen8taJq+wplkgDVh2eafX1lLZF9CAQ44Op
 te+DO1E5R2XH6YpqijGmXM2Ibc/zd0SpCcg8Taip1ncstuKqB8XBSZMPJx2XoQ1AsOqY
 P6fCkFhrneFmbcB5zRRIf7gcSMDIxBwMwMDo5ivt7Nf0DtQUOdzG5nAz3wM6V2RIeQ/B
 y2CwsM1L88pna3+DsFuYdN61CaiShIhILZu3VJs/UpFel9pA0fmBQLZOcutaS7feywyq
 wf1GpEQvcchrqAiY76BkRuhzFxYWESomIJ61pIBcGKpdvTarFb/9UKJxnP6jv27YW2PS
 lz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711611422; x=1712216222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSx/xGGusUfNhrHTP2NwCGypD2D2dm5vNsW2fOvONFw=;
 b=kmPXL4rZKNDxraQRtRkgirdE5TqzCUSEK5kjAru+SxQxt7chMWDp8DLTh0Mpb40w6i
 om8xiAuIgF07oAqOpmcmOzqy1uwdhkAnL9K7E+i7RVnPzJwzY5C7AOdoiCprnQGOC0IO
 yEzf2DP0JFUCuPBiCPdiMJMXkyofikfnNxGHSKLOXQ1Sjhpl7BQa2Ccc7RvcIBwI4/g3
 8ITPElrxasewIYZ5K/R1+tR+AFmKvkTc9lz3dEQQ9dqdIKe4L2xdvWLmSP/rI/icfW9B
 65IZYvd2qFs52iCpzEsXYaA623jbc14RdT2dNJ47GItLOZ0opXD2JfpEcywVKQ0Pw/TC
 v1og==
X-Gm-Message-State: AOJu0YzI/BFCjbGsZI+PhY8XcoQFfaPQGI+3wd8LcW0k0ZesUnfSydu5
 taZOxJ6qq63aPXWIGTS/c+Ef9LEiXxzXkLPRKx99Fmr8NrXQ2hfh3w18lWOTKM5K/GV7bBDWSck
 x384N1+mQHRFTpbT7bDn3pVhIyt0IH+MGQE0orQ==
X-Google-Smtp-Source: AGHT+IGZ4+Xex2eLRAVuvp5PrXVeskt+1IM5RcLx4zxtepmXAqa1myVuSj8r/Q2eZSSN/FYo4c/X4IFV11tUzMp/ZJY=
X-Received: by 2002:a2e:7316:0:b0:2d6:c29c:a4e9 with SMTP id
 o22-20020a2e7316000000b002d6c29ca4e9mr1544428ljc.22.1711611422109; Thu, 28
 Mar 2024 00:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240327223704.1883824-1-tharvey@gateworks.com>
In-Reply-To: <20240327223704.1883824-1-tharvey@gateworks.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Mar 2024 09:36:25 +0200
Message-ID: <CAC_iWjL+oK9FQGGc-ZOGK8Ai0nZTeVWEz0HWa8Wsa2=_gpkuhQ@mail.gmail.com>
Subject: Re: [PATCH] tpm-v2: allow algo name to be conigured for pcr_read and
 pcr_extend
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tim,

[...]

>
> +/**
> + * tpm2_algo_len() - Return an algo value and length given a algorithm name
> + *
> + * @name: algorithm name
> + * @rwlen: pointer to integer to populate with algorithm length if non-null
> + * Return: algorithm value
> + */
> +int tpm2_algo_len(const char *name, int *rwlen);
> +
> +/**
> + * tpm2_algo_len() - Return an algoithm name string
> + *
> + * @algo: algorithm value
> + * Return: algorithm string
> + */
> +const char *tpm2_algo_name(int algo);
> +
>  #endif /* __TPM_V2_H */
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 68eaaa639f89..6a090ce5810c 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -1555,3 +1555,49 @@ u32 tpm2_enable_nvcommits(struct udevice *dev, uint vendor_cmd,
>
>         return 0;
>  }
> +
> +int tpm2_algo_len(const char *name, int *rwlen)
> +{
> +       int algo = -EINVAL;
> +       int len = 0;
> +
> +       if (!strcasecmp("sha1", name)) {
> +               algo = TPM2_ALG_SHA1;
> +               len = TPM2_SHA1_DIGEST_SIZE;
> +       } else if (!strcasecmp("sha256", name)) {
> +               algo = TPM2_ALG_SHA256;
> +               len = TPM2_SHA256_DIGEST_SIZE;
> +       } else if (!strcasecmp("sha384", name)) {
> +               algo = TPM2_ALG_SHA384;
> +               len = TPM2_SHA384_DIGEST_SIZE;
> +       } else if (!strcasecmp("sha512", name)) {
> +               algo = TPM2_ALG_SHA512;
> +               len = TPM2_SHA512_DIGEST_SIZE;
> +       } else if (!strcasecmp("sm3_256", name)) {
> +               algo = TPM2_ALG_SM3_256;
> +               len = TPM2_SM3_256_DIGEST_SIZE;
> +       }
> +
> +       if (*rwlen)
> +               *rwlen = len;
> +
> +       return algo;
> +}
> +

We already have tpm2_algorithm_to_len(). Instead of defining a new
function, can we convert strings to 'enum tpm2_algorithms'? We can
then reuse the existing function.

> +const char *tpm2_algo_name(int algo)
> +{
> +       switch (algo) {
> +       case TPM2_ALG_SHA1:
> +               return "sha1";
> +       case TPM2_ALG_SHA256:
> +               return "sha256";
> +       case TPM2_ALG_SHA384:
> +               return "sha384";
> +       case TPM2_ALG_SHA512:
> +               return "sha512";
> +       case TPM2_ALG_SM3_256:
> +               return "sm3_256";
> +       }
> +
> +       return "";
> +}
> --
> 2.25.1
>

Thanks
/Ilias
