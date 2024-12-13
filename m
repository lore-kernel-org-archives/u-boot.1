Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F40E77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 16:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4E47800C8;
	Fri, 13 Dec 2024 17:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WWfBz34b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAFCB800D7; Fri, 13 Dec 2024 17:49:33 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 547118006C
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 17:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso1168242a12.0
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 13 Dec 2024 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734108570; x=1734713370; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/bwB4is3CSA9NxKY/D8gqh9BeiseqBcTYx1gdouSLpk=;
 b=WWfBz34b00dEMAtolMjPmu6An3DZupY8U3ydJ2aIKt5GGHCCJrelq3FrOEHwq8XT2X
 q8I65eFIRjuAYiNOgIAnsMRTmnWWUWbo9yXBB4gkWQ/OfUuU1Stg9C1m0WkHnxGWWJSQ
 eUORjzY5brfCLLfR2A2eZkimyRQky9OaXPQgxLnIkz5yHeg76Hk8/nPlblrtZpXSGm+a
 UISUOBWTx5oQu8damQ6W2JOWUNtn9aZCDNr11ZTT3BpkMjBtVCZgchcNT19i7285xXgv
 fjcdzNbsJXuGVEPf3eo2yeHMWXC+xGz4FAhNp4Q1hvHpBAj6VhaIuUNVdr4kQp/pGtvi
 D1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734108570; x=1734713370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/bwB4is3CSA9NxKY/D8gqh9BeiseqBcTYx1gdouSLpk=;
 b=QEI07DSKL8b9RHiIGOSohJowEz5uwQChEju+fN5u99pNPhEH/rXwQqOdxbZ4a6ATw1
 mdreOUiF6dq1CDUcM50eObiA+uGrUvkmlUIxryMeUhCggsclL8Qh/cUBSNNJT/P5PuQZ
 5bDoHqPX/e/5zwPf60L2tfhAJGM9I/Xtjg7CPc5iYFDv2ZTNHd2kvFQG0CNwIaNjthV4
 3GMqjQK8qgg/TRWNK39YdGqZQcwltWLsw5bbxZ/nfA33uE+uMSMivic7BlveJCCmJxTs
 jacLWsm6bkRkMrIWywFu7kdoMLJAdCJxK4aqETBKiGtJsEqcd1AzpOGIn3dQMIjVngns
 07hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgemK9+ZleN4P1ruDRvKVDNRdXqWRb9ynWUyJdIAmi907PNw0MBJetOkxDr42brFOCzr5uoHI=@lists.denx.de
X-Gm-Message-State: AOJu0YyCYIXMEAuAQdCW7RfCtL9VIQyMt4au6U/6CaZYYfU9vbGP+ObU
 zwiw1xFHPM09S7ibGOVHx1Y1LzOSerJ/Q8YUA1o/I6UcTUqxIrMO8CdQmO6iCKbi3FnCeUjqjJT
 y9ZSnFHxIhYTEjlAjgHCowfB8/XQ7NozriSEGhoFEYU8w0Kec0Xo=
X-Gm-Gg: ASbGnctmuYKDYPikwL68b4MdsF4M5inHOEHwrWVp/PSRBn2PPCVxohM/3CirQeVjMFh
 m1YqhmYNMuCAkP6Lhjkdn+YNLAsYR6azKMtRo2GYWITd/vtRtq/NUv1PeNON1UsgEksP+iVU=
X-Google-Smtp-Source: AGHT+IGrBG0MmN2mdw1xe8JGziSWmoawhjHmyQERG6MzK+G+7G56BJpd9nirF8mwvfdML3utM22r4zeFnE0feFRC8wo=
X-Received: by 2002:a17:90a:e184:b0:2ee:c6c8:d8a2 with SMTP id
 98e67ed59e1d1-2f28fb6f08amr5383922a91.14.1734108569668; Fri, 13 Dec 2024
 08:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-6-philippe.reynes@softathome.com>
In-Reply-To: <20241212133710.172404-6-philippe.reynes@softathome.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 13 Dec 2024 11:49:17 -0500
Message-ID: <CAEfUkUKiV1dy4iOjmo_46Wg=Dg0Pt93XYJJNB4UFD-08__zxbA@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] lib: sha256: add feature sha256_hmac
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: sjg+nodisclaimer@chromium.org, raymond.mao+nodisclaimer@linaro.org, 
 u-boot+nodisclaimer@lists.denx.de
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

Hi Philippe,

On Thu, 12 Dec 2024 at 08:37, Philippe Reynes <
philippe.reynes@softathome.com> wrote:

> Adds the support of the hmac based on sha256.
> This implementation is based on rfc2104.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> ---
>  include/u-boot/sha256.h |  4 ++++
>  lib/sha256_common.c     | 48 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
> index 44a9b528b48..2f12275b703 100644
> --- a/include/u-boot/sha256.h
> +++ b/include/u-boot/sha256.h
> @@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
> digest[SHA256_SUM_LEN]);
>  void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                 unsigned char *output, unsigned int chunk_sz);
>
> +void sha256_hmac(const unsigned char *key, int keylen,
> +                const unsigned char *input, unsigned int ilen,
> +                unsigned char *output);
> +
>  #endif /* _SHA256_H */
> diff --git a/lib/sha256_common.c b/lib/sha256_common.c
> index 7041abd26d9..46262ea99a2 100644
> --- a/lib/sha256_common.c
> +++ b/lib/sha256_common.c
> @@ -48,3 +48,51 @@ void sha256_csum_wd(const unsigned char *input,
> unsigned int ilen,
>
>         sha256_finish(&ctx, output);
>  }
> +
> +void sha256_hmac(const unsigned char *key, int keylen,
> +                const unsigned char *input, unsigned int ilen,
> +                unsigned char *output)
> +{
> +       int i;
> +       sha256_context ctx;
> +       unsigned char keybuf[64];
> +       unsigned char k_ipad[64];
> +       unsigned char k_opad[64];
> +       unsigned char tmpbuf[32];
> +       int keybuf_len;
> +
> +       if (keylen > 64) {
> +               sha256_starts(&ctx);
> +               sha256_update(&ctx, key, keylen);
> +               sha256_finish(&ctx, keybuf);
> +
> +               keybuf_len = 32;
> +       } else {
> +               memcpy(keybuf, key, keylen);
> +               keybuf_len = keylen;
> +       }
> +
> +       memset(k_ipad, 0x36, 64);
> +       memset(k_opad, 0x5C, 64);
> +
> +       for (i = 0; i < keybuf_len; i++) {
> +               k_ipad[i] ^= keybuf[i];
> +               k_opad[i] ^= keybuf[i];
> +       }
> +
> +       sha256_starts(&ctx);
> +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
> +       sha256_update(&ctx, input, ilen);
> +       sha256_finish(&ctx, tmpbuf);
> +
> +       sha256_starts(&ctx);
> +       sha256_update(&ctx, k_opad, sizeof(k_opad));
> +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
> +       sha256_finish(&ctx, output);
> +
> +       memset(k_ipad, 0, sizeof(k_ipad));
> +       memset(k_opad, 0, sizeof(k_opad));
> +       memset(tmpbuf, 0, sizeof(tmpbuf));
> +       memset(keybuf, 0, sizeof(keybuf));
> +       memset(&ctx, 0, sizeof(sha256_context));
> +}
> --
> 2.25.1
>
> The sha256 hmac common implementation now sounds good.
Do you have a comparison of performance with the MbedTLS high-level API
mbedtls_md_hmac()?
I am wondering if it is worth using this API specially when MbedTLS is
enabled,
since it significantly simplifies the implementation.

Regards,
Raymond
