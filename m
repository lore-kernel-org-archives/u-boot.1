Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A57C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 14:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BD49887D1;
	Mon, 29 Jul 2024 16:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wzBhA5ZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F067D887D3; Mon, 29 Jul 2024 16:05:45 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8479887CD
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 16:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7a9a369055so395429766b.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722261943; x=1722866743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cWx0WyxApH5hgjiPYwgP9riQrYcsbgfZM9ltQ2cm6qw=;
 b=wzBhA5ZY3xLCevQgqrmakZPlWoE7BEviqGxqw9nPrbWm4/P2g2PWDOzwdZwq2nCOuh
 xZxvW7go4X2152OUlCMcQXTMGgV2gGZA3nL2VA13i6MH03pF82th+/y9idQAFt2oqFRt
 RRoxN9a3YQ+qsOmPXVNjqtHgu4hM3Mu9IDjL7erbrpzp0dy9mzS3XZJd5/kzuoCMGW5+
 h422sd3aJUqo0GZatT6As6uJw1PhX/XkLraTVMcb9WQKd+AoA+HMs82hQj7bN5TV5Am7
 tD1+0ZbYXJJOA6paytN10nJPqvPmbDgDNtHSWUKc6IoEoymAwPHfI7phZo1CtuxsSNIb
 j+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722261943; x=1722866743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWx0WyxApH5hgjiPYwgP9riQrYcsbgfZM9ltQ2cm6qw=;
 b=Kfvwttgp0PoivDsy9UNSp6Njc7S4LhBAxn4Bs7l3XqR+ztuQpvN+1G58hcPBqGrwZ9
 p5AgT3zCQ1wrcctV8+D52gc1NtQED3tZJijczYvK9jRvaQYJSYgrZsGLtZyvYI6n6xS3
 Hd9VClL63odL8bYPig0DxhAS3Gm5/fGmNA23A0w4VOjq6Rpttrrs8NnSUjjem673SjLD
 xb+dFhHI9LspSKQyKR7l89zt3ZqVOLsMIE/Jjl75X4mFyIczM+kAVki6XF8chSaXxHvP
 ypyQ3NH1Z0i78ESkjHZ6VLE/4uvdKclBZ3efOem8T7DV+uF0EqGEioMG1HGfX/KgrzZU
 aJaA==
X-Gm-Message-State: AOJu0Yyg3+6F02xzHcA0BCn0eOZXguPe9dw8MdGYCOOj1K87zIxSnlLu
 DJWfp8Glv17uEfinjs2Iy/kLyS/BVFEO8Mu33CjGWl7GusHL5mE84xcKWHAWYtM=
X-Google-Smtp-Source: AGHT+IEXKwLlw3FiqdJ6sw4Tu9MvKumt/LGzACXXOyI7BgZu4CPC5JdR+LJ9jfY9yvV38ZxbjEQbBw==
X-Received: by 2002:a17:907:998a:b0:a7a:8cb9:7491 with SMTP id
 a640c23a62f3a-a7d4014a685mr463068566b.54.1722261942790; 
 Mon, 29 Jul 2024 07:05:42 -0700 (PDT)
Received: from hera (ppp046103060252.access.hol.gr. [46.103.60.252])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7aca51eea0sm513906266b.0.2024.07.29.07.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:05:42 -0700 (PDT)
Date: Mon, 29 Jul 2024 17:05:39 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Benjamin BARATTE <benjamin.baratte@st.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH 2/3] tpm: remove check on pcr bank count
Message-ID: <Zqehs3kedwXDeCU7@hera>
References: <DU0PR10MB52447C746D35B2C948CD2003E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR10MB52447C746D35B2C948CD2003E1A12@DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM>
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

On Mon, Jul 15, 2024 at 01:33:18PM +0000, Benjamin BARATTE wrote:
> The number of PCR banks return by the tpm2_get_pcr_info() is related to
> TPM supported list of hash algorithm that could be greater than thus
> supported by U-Boot. This is not an issue as long as the PCR active bank
> hash an hash algorithm supported by U-Boot.
> Therefore, checking the number of PCR bank supported by the dTPM and
> thus supported by U-Boot doesn't make sense.
> This test shall be removed or shall reflect the maximum hash algorithm
> defined by the TPM2.0 spec 1.59 which is 8 hash algorithms.
>
> Signed-off-by: Benjamin BARATTE <benjamin.baratte@st.com>
> ---
>
>  lib/tpm-v2.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 59e6cbafaf..64a2f15fee 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -413,14 +413,6 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
>                 return ret;
>
>         pcrs->count = get_unaligned_be32(response);
> -       /*
> -        * We only support 4 algorithms for now so check against that
> -        * instead of TPM2_NUM_PCR_BANKS
> -        */
> -       if (pcrs->count > 4 || pcrs->count < 1) {
> -               printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
> -               return -EMSGSIZE;
> -       }
>
>         ret = tpm2_get_num_pcr(dev, &num_pcr);
>         if (ret)
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ST Restricted
