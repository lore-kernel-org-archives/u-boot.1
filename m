Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4CEC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 16:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2303C8751B;
	Tue,  4 Jun 2024 18:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ebclVvGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280168751B; Tue,  4 Jun 2024 18:44:09 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B510386F6E
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 18:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6c8c880f526so2237674a12.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 09:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717519445; x=1718124245; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ign5DC3nVF+TeTlaDlcbLkxdAbHjoA0OxfpEpZ67up0=;
 b=ebclVvGqgywflcgz+Dud0hWQaDLKi3oeW3z3Q79TKMm5EpmYRV1NmsiEEw5l6gU32s
 O9DGgGmTnWtMSJXN17OZbZxMok9tIA73TD42AYT9UwxkNl/xXAkVri3RSo+YTup8owym
 MF+8Ai8FRl4emSJGtu1OEWWZCLealo0Tyfo8wib2afUJcENFdyOu7fsgxq0+fJyXg5nf
 +kKj5RJK5N66IeHPB41dfzdCoAmphi5IjLnXeJMGLGN5KwU/mNecW8Sh8Kk6PdQQE8M3
 oOSikOc77oW6o00cgKK4Skt0gQob0UFxsyhDA6m1pVqQ2i/pSoMG4Rs6qD4WVVwwz6yC
 2b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717519445; x=1718124245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ign5DC3nVF+TeTlaDlcbLkxdAbHjoA0OxfpEpZ67up0=;
 b=H1QRw0V/oewqvWqofggSeGiG5WjjDa9q+a7amCxwMbwyI4YIXRAEpUek38rGHqv7mH
 QdECA3XrITb/kt63SIpYkAGoc4w/jRYbhmsENMtMZkdvCyFTl7VhBWRD9fp70CqLESx0
 jjXZ3AIh5qn79y4fJuHHI0gTsdpMhVq1ENL66yIZiZcWO+zgAYCIfnTFQSI9LPVkBzR2
 JpPUOUuM1+aB5GTnXLz7FSbWQTI+ukA2NnGXnLuvmb1r77bOUYLfZo2V8p1Hy1lSqM8n
 ++ZxvMXIZZ5D4KXNaWSbwAsC0t7zejGaoPmMpAE77ShWm8Z4omhX8NIX/H39ofOOm1N2
 ySPA==
X-Gm-Message-State: AOJu0YwaWBZM+BRKgBByHfg/m7G1vSqCIhJSfhtqUnRONiKXMxHojCQa
 eIrXHjt+5Lg+r8yV30J/MreazJaC0vwwxgMOvyKLB4P1zWsIS6hA521YrcoDkCmkOQBDwWhePaQ
 TtqLRDGrNgOZdgVGbEeuPm3YF362yZSE1jKkQfQ==
X-Google-Smtp-Source: AGHT+IE5R9OcefrzY2dPA1Rh/64R2YQ7wUSU989bnerXSwNy3IW09Xg1rFtNTH6YEn27soZ2VgSD4/50EtIOiUNpCCE=
X-Received: by 2002:a05:6a20:f39e:b0:1af:ac6c:367f with SMTP id
 adf61e73a8af0-1b2b713e000mr150879637.44.1717519445160; Tue, 04 Jun 2024
 09:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-22-raymond.mao@linaro.org>
 <CAC_iWj+16ytziB5tT+hRF5gkyh+Mm_U9fWEdo6r4w72rzVmghg@mail.gmail.com>
In-Reply-To: <CAC_iWj+16ytziB5tT+hRF5gkyh+Mm_U9fWEdo6r4w72rzVmghg@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 4 Jun 2024 12:43:52 -0400
Message-ID: <CAEfUkUJ2cq7-OWu-AqmoRq0WRriPvuBGvvFX=q8GMjOfZ8H=Dw@mail.gmail.com>
Subject: Re: [PATCH v3 21/25] mbedtls: add RSA helper layer on MbedTLS
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias,

On Fri, 31 May 2024 at 06:00, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> [...]
>
> > +
> > +/**
> > + * rsa_parse_pub_key() - decodes the BER encoded buffer and stores in
> the
> > + *                       provided struct rsa_key, pointers to the raw
> key as is,
> > + *                       so that the caller can copy it or MPI parse
> it, etc.
> > + *
> > + * @rsa_key:   struct rsa_key key representation
> > + * @key:       key in BER format
> > + * @key_len:   length of key
> > + *
> > + * Return:     0 on success or error code in case of error
> > + */
> > +int rsa_parse_pub_key(struct rsa_key *rsa_key, const void *key,
> > +                     unsigned int key_len)
> > +{
> > +       int ret = 0;
> > +       mbedtls_pk_context pk;
> > +       mbedtls_rsa_context *rsa;
> > +
> > +       mbedtls_pk_init(&pk);
> > +
> > +       ret = mbedtls_pk_parse_public_key(&pk, (const unsigned char
> *)key,
> > +                                         key_len);
> > +       if (ret) {
> > +               pr_err("Failed to parse public key, ret:-0x%04x\n",
> > +                      (unsigned int)-ret);
> > +               ret = -EINVAL;
> > +               goto clean_pubkey;
> > +       }
> > +
> > +       /* Ensure that it is a RSA key */
> > +       if (mbedtls_pk_get_type(&pk) != MBEDTLS_PK_RSA) {
> > +               pr_err("Non-RSA keys are not supported\n");
> > +               ret = -EKEYREJECTED;
> > +               goto clean_pubkey;
> > +       }
> > +
> > +       /* Get RSA key context */
> > +       rsa = mbedtls_pk_rsa(pk);
> > +       if (!rsa) {
> > +               pr_err("Failed to get RSA key context, ret:-0x%04x\n",
> > +                      (unsigned int)-ret);
>
> Why do we need to cast the result here? Just print ret
> Also, would it make sense to create a mapping between mbedTLS API
> errors and internal error codes?
> instead of doing ret -EINVAL etc  we could have something like
> ret = mbedtls_to_errno(ret);
>
> I can remove all the cast.
But it is not able to 1/1 map the mbedtls errors to general ones via a
helper
function since the error code should reflect the current scenario of the
operation.
Even with the same MbedTLS API and same error code, the purpose of
caller is different, it is hard to get them mapped in a common
interpretation.

[...]

Regards,
Raymond
