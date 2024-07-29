Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ED6C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 13:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36249887CD;
	Mon, 29 Jul 2024 15:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YgfwStSq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB403887D1; Mon, 29 Jul 2024 15:55:19 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5AF5887BE
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 15:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc34677so5582924a12.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722261317; x=1722866117; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2z1mEECFm6Y4Uk03e9PLRbekzo/REKqqvP3oteOk1qk=;
 b=YgfwStSq6HvnPhjDP2fVm5emyfnyeASPLQu9hqQnjkrCntgKvtoWxScnD3CNeGzHZ7
 Hx3i/5dM2KHOycSVEjPd1wj9htmUjrCKNM7W+icjdrXhsce9+B2M92PPbC/acHFr1INT
 YJh5aJDiPk75gzKxyco7LM8SiARON7WQdhvLv3eUoU8ZFgMV8CoZiNM8/oo114XwRsZE
 2974Lfeq/rAkuODe7Ko/3a332UcAUMmcZZpVXxRV0x5YzVOQOFiavePrKhdTQRaSFDt7
 6VtKXO+g/QsxSqlB7U7MeXYRXbKIVBuCfBWfEP1rfcvTNhv4xTMs/XrGz5ZDfa7qIOK6
 dHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722261317; x=1722866117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z1mEECFm6Y4Uk03e9PLRbekzo/REKqqvP3oteOk1qk=;
 b=raFTRcsEfYtA6jkIP+UFN8NYcOKCW0QwhNvoQzxfn7s5rn6z6BfN/DboEbwL6LeswF
 DLN1Nt0OdrlypVExRi52Id8u4Lvco9k2mvYEV3qwHB5XXxpO2nkfTXeuNDEjahFjlmCP
 KZOxc66nY0dQknHSxWiIwKvltuZgAxUWuLfMAjiTwzIwSpSnr95olO9/Fax3JnDLGsQO
 dv63OZNqh/GIWzKX7t180Wp9DUqpyQHoeLlDjVngKph4EOHSt8On+TQiJgfrEgRVjNAo
 xj3QtjWxnGTybFzXnwAmlR4gs14EsDnxGGLOUcnxasUnfg2KeCg9XVDxaZ5I67nAAhP0
 NraQ==
X-Gm-Message-State: AOJu0Ywd3a4wy/8ZGxAtvYyP5uiQ5KjmV0OUF+VBb8RLUktnt3VHw6kC
 mvU5oxZbOaiaLmw+9za15p5srifUV70zRsmnQ5R5ly6CFqX6k9y7vxbCi0bkBA0=
X-Google-Smtp-Source: AGHT+IEKF8pzIosiDnUB2Pqu3+ZUQ670LG17/OaFFj4lmJ/KEYI4YlrATSfSILv4er4aBjKBtf1xWw==
X-Received: by 2002:a17:907:3fa8:b0:a77:dd1c:627a with SMTP id
 a640c23a62f3a-a7d3ff5622emr616131166b.8.1722261316960; 
 Mon, 29 Jul 2024 06:55:16 -0700 (PDT)
Received: from hades (ppp046103060252.access.hol.gr. [46.103.60.252])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadb98dbsm509166866b.216.2024.07.29.06.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 06:55:16 -0700 (PDT)
Date: Mon, 29 Jul 2024 16:55:13 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Benjamin BARATTE <benjamin.baratte@st.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH 1/3] tpm: update tpm hash algorithm according to tpm2.0
 spec 1.59
Message-ID: <ZqefQTOIwKSl1YzC@hades>
References: <DU0PR10MB52445073A01A8668C66ADAA0E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR10MB52445073A01A8668C66ADAA0E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
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

Hi Benjamin, 

Apologies for the late reply, but I wasn't cc'ed in the series. Did you use
get_maintainer.pl for the recipients?

On Mon, Jul 15, 2024 at 01:33:16PM +0000, Benjamin BARATTE wrote:
> The hash algorithm structure shall reflect the TCG specification for
> TPM2.0
> With vesion 1.59, the SHA3 algorithm has been added and shall be
> reflected in this structure.
> The fact that U-Boot does or does not support SHA3 algo yet is not
> relevant for this structure.

It's not, but I don't see why we should add more algorithms if we don't
plan to support them. Any plans of adding actual support for the SHA3
family?

Thanks
/Ilias
> It's up to the end user to configure the active PCR bank to supported
> hash algorithm by all boot chain component.
> Also, by default, TPM2.0 shall support at least SHA256 and SHA384, in
> practice dTPM support 2 actives banks with this 2 hash algorithms
> 
> Signed-off-by: Benjamin BARATTE mailto:benjamin.baratte@st.com
> ---
> 
>  include/tpm-v2.h | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index 4fd19c52fd..9848e1fd10 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -253,6 +253,9 @@ enum tpm2_algorithms {
>         TPM2_ALG_SHA512         = 0x0D,
>         TPM2_ALG_NULL           = 0x10,
>         TPM2_ALG_SM3_256        = 0x12,
> +       TPM2_ALG_SHA3_256       = 0x27,
> +       TPM2_ALG_SHA3_384       = 0x28,
> +       TPM2_ALG_SHA3_512       = 0x29,
>  };
> 
>  /**
> @@ -271,11 +274,15 @@ struct digest_info {
>  };
> 
>  /* Algorithm Registry */
> -#define TCG2_BOOT_HASH_ALG_SHA1    0x00000001
> -#define TCG2_BOOT_HASH_ALG_SHA256  0x00000002
> -#define TCG2_BOOT_HASH_ALG_SHA384  0x00000004
> -#define TCG2_BOOT_HASH_ALG_SHA512  0x00000008
> -#define TCG2_BOOT_HASH_ALG_SM3_256 0x00000010
> +#define TCG2_BOOT_HASH_ALG_SHA1     0x00000001
> +#define TCG2_BOOT_HASH_ALG_SHA256   0x00000002
> +#define TCG2_BOOT_HASH_ALG_SHA384   0x00000004
> +#define TCG2_BOOT_HASH_ALG_SHA512   0x00000008
> +#define TCG2_BOOT_HASH_ALG_SM3_256  0x00000010
> +#define TCG2_BOOT_HASH_ALG_SHA3_256 0x00000020
> +#define TCG2_BOOT_HASH_ALG_SHA3_384 0x00000040
> +#define TCG2_BOOT_HASH_ALG_SHA3_512 0x00000080
> +
> 
>  static const struct digest_info hash_algo_list[] = {
>  #if IS_ENABLED(CONFIG_SHA1)
> @@ -310,6 +317,24 @@ static const struct digest_info hash_algo_list[] = {
>                 TPM2_SHA512_DIGEST_SIZE,
>         },
>  #endif
> +       {
> +               "sha3_256",
> +               TPM2_ALG_SHA3_256,
> +               TCG2_BOOT_HASH_ALG_SHA3_256,
> +               TPM2_SHA256_DIGEST_SIZE,
> +       },
> +       {
> +               "sha3_384",
> +               TPM2_ALG_SHA3_384,
> +               TCG2_BOOT_HASH_ALG_SHA3_384,
> +               TPM2_SHA384_DIGEST_SIZE,
> +       },
> +       {
> +               "sha3_512",
> +               TPM2_ALG_SHA3_512,
> +               TCG2_BOOT_HASH_ALG_SHA3_512,
> +               TPM2_SHA512_DIGEST_SIZE,
`> +       },
>  };
> 
>  /* NV index attributes */
> --
> 2.34.1
> 
> ST Restricted
