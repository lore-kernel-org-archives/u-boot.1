Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AA2EA71B3
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 962B5842D2;
	Mon, 20 Apr 2026 04:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nwMFSmL4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55C7A842E0; Mon, 20 Apr 2026 04:12:58 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E700842CD
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so329516966b.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651176; cv=none;
 d=google.com; s=arc-20240605;
 b=fa1XH6NkX2MjC8mzVLxsENSd3qEeTysiJRFReMy/p1HFSJn1utvn1k568T/dSf6Atv
 LxntrbDGNm47ic5vnjBooiYssT7rmJMakFuodqFBPgaZEUzMfWUFfcntP/DOKkzQNIuQ
 /TRc5aq9Tw2mCNQidO30tQlAzktEtMyVImtGadcsBfJoLef01K3i2n06i2fC3CkyG5/P
 w5JyaAl/n51ouIzU4D81n75Shdny3OIcf2KFWj0EPGOVfO+h43EyJRaTklZCHG2sZw37
 QmjH0J+YJkYBkyVqHckNivsJ/Kr5cKHE5EOH0iKfgy+9MWoKX/oyo4NHYYg5rnxr1ojF
 dpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fp9SO0vKvUXZSO9DYWDG+v6onI45//FrPNbH6KQVKes=;
 fh=xWxtB0DwqTFpqqP3MO1e2qb9SRLKs49A/2aBCeif3yQ=;
 b=LYckRVwCZ5s4C/CwDnwG1ZWfIhrcbnwmBHG32BO6E9plFts1bi4xKc80wBezXpj7+J
 bWNIA7LkYfA5AhXvEJLNCHl5/zX6KH2QlxxqOkckp7iN0UedwX8mGjvgWYAU03sRg5Gp
 nrruOdhrmHftcvkj3yxEudbXi7GiqQFDeV9rh/qjbtvUud2yMPk9JAZbsP1amUa/lJew
 ck71vrzFG7xqUcWTqsGlVc4icZMF2hLH1Lpi11i+ZvwdkGVbWEv7tU7hYefe+OTpKovf
 W4Qu0fpJveAG7VuaFMr0yYFA8EQ/1fp97Iw9IgHoGX5by54PI4cmnINHqmezEEvyciZd
 6SXA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776651176; x=1777255976; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fp9SO0vKvUXZSO9DYWDG+v6onI45//FrPNbH6KQVKes=;
 b=nwMFSmL4bxnKfDdthWQCpD9sl2ddlSlFcEfgVa4eeG2xmf0nLk8eMPRMy4U+spkUd+
 7pmg6RC3CkXkdSahdcJjOfmK48cE3J/QBmF2m2itvLoeDugUXgDPJu+07kXvUz4vKzJ5
 7caVXqjd8gMbwSS0IEBzPPKJ0B2RIBTBTO9Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776651176; x=1777255976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fp9SO0vKvUXZSO9DYWDG+v6onI45//FrPNbH6KQVKes=;
 b=phYZIlUJ6Z9VH7U0wYUv8o28rqwLEwwjMOk/KIER8pUodVniQtETeqNNbVKFeoysZy
 HuVYmhGwYUz6HakVPgP81ZhPSqo6vQ3OaXoC4hGt8tbJ+Xk08aoB5obnKBStSdZ6dd6k
 rJI8QaUg/XxXNu9tFHnoXi/dzAjYNYwKvxcdE4hy33T8OaX4DU2AqbrSRdN0+77v26tA
 jA4M5IlJtR+if530xon2n0xxW7NS+LzqZGOb+s91UVE7QNekwoN9xROCGEfhkFxs2JJf
 v1lprX3QAgPty70+h67nFA72G0TSwkTuG1jflusMdmypTXpnqca5kOFdQaFyGJYle+WH
 3ZnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wYPIx05Mp+tG35o1R1CEgzo43kyYnEb7ML0+6UinpO+N+kWUJBe+aHbSfv7Fp47VpG0XQVpU=@lists.denx.de
X-Gm-Message-State: AOJu0YwbambkH06YWZIDegX3mu1TNESH8uNlW4BqOS3zqAUFzWbWLehD
 U5G8pXzKzSLiUMaGTP7D4VTp1rgLxwZE5fd6Fb30yOXKmltvaMP7aFxvjyNVXbGK2Fe0fBnXgvj
 yZ+sz0qLSk1NvJ/AlJmYgNJyUSszNoFBHPBMwutonZGQ43EnPYHZA+B7f
X-Gm-Gg: AeBDieum32/2ichIVM2aV1ngR9I1IghXD+fv6sO6wMtVZMLf69YRbQpPaRop4uvlWt3
 pGdKHm/QxkjbdLUPizjXkNJRIk4NIFkPAlHLkGQ9mfYAT1NXLD6UPB+x646yXeyeqUdhANQjDa5
 PHx5FP7gXu3SP0/SvMkiEuKdeteXed9X2/sHW81dDmpTwWp77mHJag7STJ9U3lG88TG8mBESGw/
 prOagHuM261pf5SandSRarCNpLM7Ge4UM+sxsxzGb4CmEmLqc5IrTulhLuDD+CQFU0SWcHuyVqt
 tD+hH4Hs2pXLvxqcDbmksFuZP2HG7Ts=
X-Received: by 2002:a17:907:2d8f:b0:ba5:f23e:70e2 with SMTP id
 a640c23a62f3a-ba5f24dcdb0mr241600166b.44.1776651175818; Sun, 19 Apr 2026
 19:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260417130204.49896-1-philippe.reynes@softathome.com>
 <20260417130204.49896-12-philippe.reynes@softathome.com>
In-Reply-To: <20260417130204.49896-12-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:12:36 +1200
X-Gm-Features: AQROBzCh4CjIeYLL7ZEk6NU6cFqgP4G-xgucYAIoqOZ4rTgY4Ed_viOlnwKueB8
Message-ID: <CAFLszTj06sqGhx9xkmtQ6atMQaKnFhJTkgSLq518jgmJHzb2MA@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] boot: pre-load: add support of ecdsa
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-04-17T13:02:04, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> boot: pre-load: add support of ecdsa
>
> Right now, u-boot can only boot image with a
> pre-load header with rsa. We add the support
> of ecdsa.
>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> boot/image-pre-load.c | 56 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 11 deletions(-)

> diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
> @@ -70,6 +70,17 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
> +static int is_ecdsa(struct crypto_algo *crypto)
> +{
> +     int ret = 0;
> +
> +     if (crypto && !strncmp(crypto->name, "ecdsa", strlen("ecdsa")))
> +             ret = 1;
> +
> +     return ret;
> +}

This could be simplified to:

    static bool is_ecdsa(struct crypto_algo *crypto)
    {
        return crypto && !strncmp(crypto->name, "ecdsa", 5);
    }

> diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
> @@ -155,6 +185,10 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
> +     info->sig_info.crypto   = image_get_crypto_algo(info->sig_info.name);
> +     info->sig_info.key      = info->key;
> +     info->sig_info.keylen   = info->key_len;
> +     if (is_ecdsa(crypto)) {

You already have the crypto pointer from the earlier
image_get_crypto_algo() call. Please can you reuse it here instead of
calling image_get_crypto_algo() again:

    info->sig_info.crypto = crypto;

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
