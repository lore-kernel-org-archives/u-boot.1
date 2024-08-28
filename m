Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2B9C54FA6
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58FC588892;
	Wed, 28 Aug 2024 14:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kvwe7PzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D295688847; Wed, 28 Aug 2024 10:33:42 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CAE88A76
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 10:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7cd9e634ea9so4031792a12.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724834017; x=1725438817; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8BQwHT4RjToGHUerjj9oHIj+hCnfZvKJ9nwy09tvWqo=;
 b=Kvwe7PzZSR0za2LI0VxIXoc/qxJ+BwSd4b3Gl8TUlkUPbuvyXDpGez8G5E54Q6IqPh
 7mNQTXe030YJVmRDmU8kRJadtILPNn76RCiVujINT7U5Lc/iKrHRkKQmvHtyAINmx4DI
 6sZteEuBsrMKmorVED/+gG8DMO+SUgFQLuYxs0XeNZ4j2ypjSghlDJShs7fTuU91VKPc
 rc4FHfSB343v9iTJJykfHdWvMppkpsd0XK6bI266qY7jMKQX1mCYLcFIP+Pti0oDhk2m
 g4w8nNQChg8GWmatYRY+BOBwsaW6JUMuwTKonjSTn0H3VwZQJiYxAt+f35nr7Bx0wnjx
 E8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724834017; x=1725438817;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8BQwHT4RjToGHUerjj9oHIj+hCnfZvKJ9nwy09tvWqo=;
 b=HkTknkJMOjgtVvvFomu4emmhtCct3vMNL/Ry5rx/AQXhtB2fV6/3i9nlK60liR4FUp
 tqBPOX5ip1d5R1PG6GroQuBmhGgOzRSClKilVEGJugmLlQK0m7xsodMndVVFet9qHdJp
 dexgumGRzZWjpXH4iwvlnzOiiPY2cxHwntdiAZQJix7v6dGavT2+hYWNJfuSCuEJ/JQq
 gSmc2BQB9rFXWPVOZAbdGfasKKt+Kdg/EsRazJzWL23CB7Jv2IaWbxjXZOhPQxEnGG2j
 4ieCD20oL2pZ8/TSfqU0i5tDmcSuvWcaZhaHeoT5iJnXbM4kDpnJIHzsDFm5ijM0B5gG
 soIw==
X-Gm-Message-State: AOJu0YyrjzOl6cLYnLKUru6B0bxetlqtyyW8TYSMhB9BTWs2yC753eRy
 bILSNXWFFKweCGCAvBEjjq6dsjgh4NZxZgwOXQC9F+lC8ktdJ1fWeFpvEWk14jLNsMfqJ6+RB6C
 W08ELWQPHAEsnhUUNUsqVYlCYYinXiDR4w9JuXw==
X-Google-Smtp-Source: AGHT+IEFpsEbpKkAQn2dWxPDBYjUYfwQouTp1J0XjlQeHuYdUAIhRAMVaQSdII5PbOaZm6o1TNhKdYq8nQianJmQ4pE=
X-Received: by 2002:a05:6a20:e188:b0:1c0:bd9c:adf with SMTP id
 adf61e73a8af0-1ccd28e12f6mr935851637.50.1724834017037; Wed, 28 Aug 2024
 01:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-13-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-13-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 11:33:00 +0300
Message-ID: <CAC_iWj+Hu6_A4J55ewkv_6t9BpeQDsYzDZxBXRm3ONqz6mnTAg@mail.gmail.com>
Subject: Re: [PATCH v6 12/28] mbedtls/external: update MbedTLS PKCS7 test
 suites
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Anand Moon <linux.amoon@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 28 Aug 2024 14:49:25 +0200
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

On Sat, 17 Aug 2024 at 00:49, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Update the PKCS7 test suites for multiple certs.
>
> The PR for this patch is at:
> https://github.com/Mbed-TLS/mbedtls/pull/9001
>
> For enabling EFI loader PKCS7 features with MbedTLS build,
> we need this patch on top of MbedTLS v3.6.0 before it is merged into
> the next MbedTLS LTS release.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
> Changes in v3
> - Update commit message.
> Changes in v4
> - None.
> Changes in v5
> - None.
> Changes in v6
> - None.
>
>  .../external/mbedtls/tests/suites/test_suite_pkcs7.data       | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> index d3b83cdf0aa..2dd1c56109f 100644
> --- a/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> +++ b/lib/mbedtls/external/mbedtls/tests/suites/test_suite_pkcs7.data
> @@ -14,9 +14,9 @@ PKCS7 Signed Data Parse with zero signers
>  depends_on:MBEDTLS_MD_CAN_SHA256
>  pkcs7_parse:"data_files/pkcs7_data_no_signers.der":MBEDTLS_PKCS7_SIGNED_DATA
>
> -PKCS7 Signed Data Parse Fail with multiple certs #4
> +PKCS7 Signed Data Parse Pass with multiple certs #4
>  depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
> -pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_ERR_PKCS7_FEATURE_UNAVAILABLE
> +pkcs7_parse:"data_files/pkcs7_data_multiple_certs_signed.der":MBEDTLS_PKCS7_SIGNED_DATA
>
>  PKCS7 Signed Data Parse Fail with corrupted cert #5.0
>  depends_on:MBEDTLS_MD_CAN_SHA256:MBEDTLS_RSA_C
> --
> 2.25.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
