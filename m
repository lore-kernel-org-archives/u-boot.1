Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71545C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 10:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97348856E;
	Fri, 31 May 2024 12:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b0EdsJn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22462885FE; Fri, 31 May 2024 12:00:13 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7E1880DB
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 12:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7023df18408so961529b3a.2
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 03:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717149609; x=1717754409; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NGD5IYbzoW0ieWajw9USuTDh+EaW4abRmJRvJ+o716s=;
 b=b0EdsJn+mbOVYmT6UR+SXXGTbHMCNp+dTwwt6T3ef0lLxLCuqufdmM2XAXNE94S0Y0
 k8gz07y2edkOvNTwqF5oOzFyg0Ltl80a11T9+yqLJ8OL9CujJxu3CiRAsUfs0Xj7snUW
 ZLJ/fMOcphs2KwJFrlPQJefezAMIbsC+EpnWVF4Ey+XOmmIXAoWClDuTkkVHylGiBj30
 nexsnKruwx/1sBQvVsdvcMTT756EKdbND460uVHDnlqjixqK+ZzKRPN8a8gyCuBEXU9+
 O92uK6U8V2j3ivjQr++M5CiEIOhKdoolYs7GGqov8pLcPzeylQkpR0GbrsylsZ5VuVLw
 GVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717149609; x=1717754409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGD5IYbzoW0ieWajw9USuTDh+EaW4abRmJRvJ+o716s=;
 b=A8J110J34iNfReNsq2+LYStW1cDnWW+ZpenYjmpSnONA5b8D9+rdDZHr972ECkK3Zy
 p/wqdZ3kzcQF/gbSHwPXrNMB3TryuJBE/vbt+kaGNGeMfNXRXVACR9WuAAU3UdTTuo+s
 z1s4knGwSmPjYEXqrkKRWh2rBFo3hbDR1GnhlzYZn6q7jWidOfO19GnVK33ee13e+PBs
 M8KudF75OczR3CzoYgebIYxJgIM2gdh3PRx6rw1rS3ImvXd9rmACj0g+HKw42EfUAR+t
 BLDyOe4jvfY27XD1fQZ6QDz1SxrWKMfXzgWJMIm4fC98nLKXX6a6cizOtE1AkbYNrYuv
 SG8Q==
X-Gm-Message-State: AOJu0YzXSrYt31LZYl2OW1Vwzlbr64EkZ5NwDeoV0M21GMyb47Pf20Js
 8tx6czowVEaPTTFMhcsr/nQ7meWoZCURT29IPvhJqkWgSC1bV9iJWFFVMCFNDsXHk1ZqOK/Pb+i
 Cx4DcXzyz1Tu3xuuMwQNViHfQxM/fYoKOC66ADg==
X-Google-Smtp-Source: AGHT+IEjQ0hHwgSQjIdYnGUZ3mXL9/J8smVaAPbjNuKVJOKiVEFMpKi81VoALLDIu/y55XaRWN2F7NRsRpWefyCOjH4=
X-Received: by 2002:a05:6a20:1581:b0:1a9:dd82:a42a with SMTP id
 adf61e73a8af0-1b26f18576fmr1650694637.31.1717149608685; Fri, 31 May 2024
 03:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-22-raymond.mao@linaro.org>
In-Reply-To: <20240528140955.1960172-22-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 31 May 2024 12:59:32 +0300
Message-ID: <CAC_iWj+16ytziB5tT+hRF5gkyh+Mm_U9fWEdo6r4w72rzVmghg@mail.gmail.com>
Subject: Re: [PATCH v3 21/25] mbedtls: add RSA helper layer on MbedTLS
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Michal Simek <michal.simek@amd.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 Manorit Chawdhry <m-chawdhry@ti.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Raymond,

[...]

> +
> +/**
> + * rsa_parse_pub_key() - decodes the BER encoded buffer and stores in the
> + *                       provided struct rsa_key, pointers to the raw key as is,
> + *                       so that the caller can copy it or MPI parse it, etc.
> + *
> + * @rsa_key:   struct rsa_key key representation
> + * @key:       key in BER format
> + * @key_len:   length of key
> + *
> + * Return:     0 on success or error code in case of error
> + */
> +int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
> +                     unsigned int key_len)
> +{
> +       int ret = 0;
> +       mbedtls_pk_context pk;
> +       mbedtls_rsa_context *rsa;
> +
> +       mbedtls_pk_init(&pk);
> +
> +       ret = mbedtls_pk_parse_public_key(&pk, (const unsigned char *)key,
> +                                         key_len);
> +       if (ret) {
> +               pr_err("Failed to parse public key, ret:-0x%04x\n",
> +                      (unsigned int)-ret);
> +               ret = -EINVAL;
> +               goto clean_pubkey;
> +       }
> +
> +       /* Ensure that it is a RSA key */
> +       if (mbedtls_pk_get_type(&pk) != MBEDTLS_PK_RSA) {
> +               pr_err("Non-RSA keys are not supported\n");
> +               ret = -EKEYREJECTED;
> +               goto clean_pubkey;
> +       }
> +
> +       /* Get RSA key context */
> +       rsa = mbedtls_pk_rsa(pk);
> +       if (!rsa) {
> +               pr_err("Failed to get RSA key context, ret:-0x%04x\n",
> +                      (unsigned int)-ret);

Why do we need to cast the result here? Just print ret
Also, would it make sense to create a mapping between mbedTLS API
errors and internal error codes?
instead of doing ret -EINVAL etc  we could have something like
ret = mbedtls_to_errno(ret);

> +               ret = -EINVAL;
> +               goto clean_pubkey;
> +       }
> +
> +       /* Parse modulus (n) */
> +       rsa_key->n_sz = mbedtls_mpi_size(&rsa->N);
> +       rsa_key->n = kzalloc(rsa_key->n_sz, GFP_KERNEL);
> +       if (!rsa_key->n) {
> +               ret = -ENOMEM;
> +               goto clean_pubkey;
> +       }
> +       ret = mbedtls_mpi_write_binary(&rsa->N, (unsigned char *)rsa_key->n,
> +                                      rsa_key->n_sz);
> +       if (ret) {
> +               pr_err("Failed to parse modulus (n), ret:-0x%04x\n",
> +                      (unsigned int)-ret);

Same here

> +               ret = -EINVAL;
> +               goto clean_modulus;
> +       }
> +
> +       /* Parse public exponent (e) */
> +       rsa_key->e_sz = mbedtls_mpi_size(&rsa->E);
> +       rsa_key->e = kzalloc(rsa_key->e_sz, GFP_KERNEL);
> +       if (!rsa_key->e) {
> +               ret = -ENOMEM;
> +               goto clean_modulus;
> +       }
> +       ret = mbedtls_mpi_write_binary(&rsa->E, (unsigned char *)rsa_key->e,
> +                                      rsa_key->e_sz);
> +       if (!ret)
> +               return 0;
> +
> +       pr_err("Failed to parse public exponent (e), ret:-0x%04x\n",
> +              (unsigned int)-ret);

 and here

> +       ret = -EINVAL;
> +
> +       kfree(rsa_key->e);
> +clean_modulus:
> +       kfree(rsa_key->n);
> +clean_pubkey:
> +       mbedtls_pk_free(&pk);
> +       return ret;
> +}
> --
> 2.25.1
>
Thanks
/Ilias
