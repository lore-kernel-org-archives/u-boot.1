Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BD8EA7942
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 19:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1234083015;
	Wed,  4 Feb 2026 20:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BBdyiUgw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6AD838FA; Wed,  4 Feb 2026 20:29:07 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702C58063E
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 20:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-948a076d6ecso38859241.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 11:29:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770233344; cv=none;
 d=google.com; s=arc-20240605;
 b=EZmwjzvyq5U9PUmKi7DXJhzJMvQ1MJgvFEc2iERy1X7jlhYEOwywb9m0ObVY9GWuNX
 XfROzJiOZO/mrMJAt2KTpnpW7elQ8M9L5erlBZc9GdaScI8qn8m0RWyae31eXeglAYuc
 rjOZlGxQbwnP2WZkViqlo0Ugv3XN7VlkKhOiFsE1dHUtzFgDqDYYtLtHMEPfQxAYvawU
 2t3XTpIl5zfGS0Ijp79Q6hogpmDPvJOfPCpc2qjdN2ZEhnsfdgHMpaRkLL9iGWykAoU0
 LnvG5WuhTiJdgbppEWdIl/FHOzH4D8f5t4jvomyidBQarB3A1JGkRrEm7xYzVMdYh3NP
 pHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZtBRGGqSKmePViezkl+fiMyAQ15xPUTmnryZ4eEW+f8=;
 fh=jAjkNvvmmS1CYKe5bUQ2T47FaFs+SuONDyPmGuCZHWc=;
 b=JfvA7cFJ8/7kkTxYIpov+Gtf2eBAsb4sz51kZjEUx+CkkOtinsSwyoc7lfg57/+p+o
 Hw798vtZyLa+TbZ4vxVBpaXs3WirsTTJR+pcWyXh3KKeGHIvO03i0QDfJBl/Vos9/qq5
 19NHNO23BzlmMIUr02QZPaZ5onTr3jmQhLZ5B32PNDEr/ndowECI3L2e+Gq4ChQNZZph
 RK2wEVKHbaIsTVywpLK3smYXL+MHK5gF5iY6uvQ+7E/UC37/GqBs3tCMWdDWNK+QUYk3
 cUqojDn1KO5Iklx6kk56216lkBrs9aySD6p693oS4kIrRWF1nhZTd+2Yzf66UjRxyyar
 NV5w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770233344; x=1770838144; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtBRGGqSKmePViezkl+fiMyAQ15xPUTmnryZ4eEW+f8=;
 b=BBdyiUgwXSLUy6KoyqIExUdLDTQob4NZiMeHnjd1JcXjEuC5JOfDVuKKHrZE3hgdLO
 cN0wtu7dJuQnegLQBaAYUUL4B1ewwKLZZnQhM90phNAQjAZVL8xFTJLLvGE8CbPfQ9DA
 88O084M8U6uOkChybb1S/EiPvB3hGAnpg0vuAcczMWDhKCSbtGMQaQRe8V8R+81IsIMu
 1yzRB9LQifCHEFI+mMNOM/h2sbp0LPPUH7OaSClxg3y35FaDzNjBydVgkXG7tOuqYsjP
 9SyGZAaRSig1eALORIKUYPCGkeS5Gg+93BzUplfaJpVYRmCoSq1rDZUU3rzQeJXDjOma
 tGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770233344; x=1770838144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZtBRGGqSKmePViezkl+fiMyAQ15xPUTmnryZ4eEW+f8=;
 b=iuvNqGn3qLzUbzRlMog0R68aFGfGLWt89POWbGax1RxCcXboaB75saom81aLDYjzmq
 hdIpxjoNUdXnN46dnRXrx2RH2kcz1iiyb3e2LF4iQVId+Y0RnldCNCxFN79izYPU39zk
 LmOEGWald6injTCkZ2rfUIYkCsIwVNt7lDTRZThb5bKYd5Gxn22ld4F+X/xC8gPRYwKk
 /EdNbEtqTFTgFCT/IdUwVkbG1NEZ4a5JWeMMvW04KXXQXRnCpc/2owokbNt7h9U/s4QD
 JzIdbithWuhN/NZE/922itMgwifia3Vwa6srrTlbl13ldfTvz10jg5cak9mSIjQTx9Pl
 bdcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlMGl/Ns4658I+YChPy+M4Gr6MgAaPR5KVYAf5kSc0RCqMxymNGtEt0YWU5aXJ7uks2TCKJVE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1mngZkXdnlRXcaN9QAj3NthDZKhG5QRoUSqTJWAHDUEa5y+zR
 urjTXA/mwS1AUcE4fuNKUYkYI29hNMB4sv9NM00jF8Bc9qYRj8lqB0vJUl2+RjzQ/trSCqaRzGp
 /Wo0qemid0kFZpWogVIcLo6yYyrQFpDM=
X-Gm-Gg: AZuq6aLoznNcWZqzQE7QJIkGJ7jbgfIkOHYiXBXqv17My7b6IY33y8pvHAtq2jeUBVD
 0R/W9Nv3ue/uY/K3WagdCqBKU8ZhxSzYvwQKP3J9M4OsjXicBbyvOUGBblUdlu3HAxM5XzjK1ev
 PtPyRSKvGwfJODJnuFNTvvDcqHNaTHXXYNq92kGOBgwcG9lBGlAKYMGuhutVtbnjWhU6qh+JoOg
 Dq3mp5wsIuSDtlinqjuRPm2yKwtu/sL246TyMRpWmhEsIDaiWGPjZAux67rwZo5ZqY775Dh
X-Received: by 2002:a05:6102:2906:b0:5f1:5786:219c with SMTP id
 ada2fe7eead31-5f939618dbfmr1000336137.40.1770233344106; Wed, 04 Feb 2026
 11:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
 <aYOXxN-DBm_6LrSE@kehys.lan>
In-Reply-To: <aYOXxN-DBm_6LrSE@kehys.lan>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 4 Feb 2026 14:28:53 -0500
X-Gm-Features: AZwV_QjPmRQlGmj6ZlRmwjByZ8VdKGqmIxg_Z4OB_tB2cd-NN7PyDbkeOCtkKnE
Message-ID: <CAMDkj5y-GgnwgnuQKnDY5AJAL8XWmCXWsFdKtj93VjEyR=b0oA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 jonny.green@keytechinc.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Marko,

On Wed, Feb 4, 2026 at 2:02=E2=80=AFPM Marko M=C3=A4kel=C3=A4 <marko.makela=
@iki.fi> wrote:
>
> Mon, Feb 02, 2026 at 06:03:03PM +0100, Philippe Reynes wrote:
> >This serie adds the support of ecdsa with software
> >using mbedtls. So boards without ecdsa hardware may
> >also use signature with ecdsa.
> >
> >To add the support of ecdsa with mbedtls, I have:
> >- enabled ecdsa in mbedtls
> >- add a function sw_ecdsa_verify that uses mbedtls
> >- add a driver sw_ecdsa that call sw_ecdsa_verify
> >
> >I have tested this code with sandbox, and I have
> >followed those steps:
> >
> >0) build u-boot using sandbox_defconfig and adding those options:
> >CONFIG_ECDSA_SW=3Dy
> >CONFIG_ECDSA_MBEDTLS=3Dy
> >CONFIG_ECDSA=3Dy
> >CONFIG_ECDSA_VERIFY=3Dy
>
> I did "git am" on top of the master branch as of the current
> eb1562cc3e4c5130c76db1c1ea57156322362a7c and tried to build it as
> follows:
>
> make rpi_4_defconfig
> scripts/config -e FIT_SIGNATURE -e ECDSA -e SHA256 -e ECDSA_VERIFY \
> -d BOOTSTD \
> -e MBEDTLS_LIB -e MBEDTLS_LIB_CRYPTO -e ECDSA_MBEDTLS -e ECDSA_SW \
> -e SHA256_MBEDTLS -e SHA256_SMALLER -e MBEDTLS_LIB_X509 -d HKDF_MBEDTLS \
> -e ASN1_DECODER -e ASN1_DECODER_MBEDTLS \
> -d LEGACY_HASHING_AND_CRYPTO &&
> make -j$(nproc) CROSS_COMPILE=3Daarch64-linux-gnu-
>
> No matter which variations of this I try (starting with -e
> HDKF_MBEDTLS), the build would fail with an #error in
> lib/mbedtls/external/mbedtls/include/mbedtls/check_config.h because
> MBEDTLS_ECDSA_C is defined but neither MBEDTLS_ASN1_PARSE_C nor
> MBEDTLS_ASN1_WRITE_C are defined.
>
> By disabling that check I found out that the functions
> ecdsa_signature_to_asn1() and mbedtls_ecdsa_read_signature_restartable()
> really depend on these.
>
> I diagnosed this by executing
> make V=3D1 CROSS_COMPILE=3Daarch64-linux-gnu-
>
> Then, I edited the compiler command line by replacing "-o *.o -c" with
> "-E -dD", and redirected the standard output into a file. In that file I
> found that lib/mbedtls/mbedtls_def_config.h is defining MBEDTLS_ECDSA_C
> and would also define the ASN1 symbols if CONFIG_ASN1_DECODER were
> enabled:
>
> #if CONFIG_IS_ENABLED(ASN1_DECODER)
> #define MBEDTLS_OID_C
> #define MBEDTLS_ASN1_PARSE_C
> #define MBEDTLS_ASN1_WRITE_C
> #endif
>
> Something is wiping that out from my .config, also when I execute "make
> syncconfig" after the scripts/config. When I search for ASN1_DECODER in
> "make menuconfig", it mentions a large number of other configuration
> options.
>
> Can someone help me to enable CONFIG_ASN1_DECODER in this configuration?
>

When EFI_SECURE_BOOT is enabled, all these dependent Kconfigs will be
selected automatically.

Raymond

> With best regards,
>
>         Marko
