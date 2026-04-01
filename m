Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CDF10FCAEA
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E291E83CE3;
	Thu,  2 Apr 2026 00:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cKxogq6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DE783F7D; Thu,  2 Apr 2026 00:01:12 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B73680517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9c01854477so38919666b.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775080870; cv=none;
 d=google.com; s=arc-20240605;
 b=bj7jpGkqRML2AbjD6YuFwJLDHUCz1bZZTwIQKeqBVjgUQovmlLhhNNZgLq5WBLjXYK
 lX7Njsqs9rwIX5ElxwguByCgs9wqgDmDLfnq+qnPwwwjHRx0VuNDzQllMTEB1Rw52o18
 Kej4bMbFUZNlUpv3MvvRHXCCoR0VPYVjVcvGFdWgcSYCLlIoYTN2g8yTmBKn5Q+/afml
 bXYEg4svus6wg/NQ9eEiul8Tl3Xwja+d4eMZbv6UbZ3W4skYKYyXBy2P2p6AynmmBbUd
 9CAMPEEuy9HtWtdHYEYnrSUMue/17MS03flJcKzXA+WJ9VTLxOX/0nVcr4dpvuWi6lsb
 B7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5Kdh0WEnA4LErDbm0kQ+RBreT9madYvRRfOtgq46aD8=;
 fh=7vb1Rnwu2xoEU8xMWaLBwrI7xj8fQIGvqUE/BKD9OP8=;
 b=cRVRzzAlbKQ4Uxp8JHVSh8Gn5KE7pL493qvhDlOKsWyfz2Y2EQEujPdPc5cAjB8goD
 YkHD1Ckvb2j8F/jwHFQ3Mk1AlTZ2Tm/kwsvfNoGqV6ydPfxIQqIEvdZjGHGn3ZPDTsxb
 nzfeVz4FSgyZyGpt2hILsz2cPraV3DitJEH9oZNp7m2eD0ko7Ra0++Xbp44a/8kYEr5N
 DrlCz26ai9IIc7VudgULXplOGYaHDBMJ4bNY3TndCuT3jHzuq37jg0gcUGe49a6SfeGB
 HJPEYRgV70M2g3BJz3bsjnUExpVq0K4tDXHJQ4FAGiGv0Pk8c/v7HEpxAj0MrexLhykG
 Lvww==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775080870; x=1775685670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Kdh0WEnA4LErDbm0kQ+RBreT9madYvRRfOtgq46aD8=;
 b=cKxogq6MUbo17sO1KXbnqAWMIO0vssVh3uHGdJ1zqI4unDEjvjOc4KPG6fKoAtuHtr
 VY3K8vjuCNNrAZm8GV0faV6bUJ6UpIUg8vw6BxHjz0pUKlsRuJR/DooLfazKNX0ywV4q
 eqxTjQztT2Y16ZZhg/HOSO34a2jTjoQFwaKr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775080870; x=1775685670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Kdh0WEnA4LErDbm0kQ+RBreT9madYvRRfOtgq46aD8=;
 b=XutlGvRbeqVCYHPOH44c7wQWO1YoagOStHC0Ir07UiDdIlvsFm9P90JyPObjvN4hTS
 j75quOx34pumXhrF2PtMVkui5At/iqQQQ7KUeQdyStBq/cglosXBxIHwVVdEwLzcKzmZ
 Bn9zK3phE58HBbf3uaWH5TdC4Srw7a7Sz8+E+n31J8lSrZLRhKxSDbx5meY5zI9StGms
 RIQOWLSLSQ8lf3RU356sJQG9BE0bem2zpxV6bwnAOPuMPkpfx7P/MsAQDcTZ7pSu2xd9
 VIECU3hzzxOVEd9OYdA0LDK7fRXLAus5W8To8zfmrqTJn1nrRUXAGaGWbq+FAeDX4U4O
 a0Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO8EwK/s7P19oJ7fOCHSI2HecUUYfXZsvkLqjKDdyLCjAtOsYsOYjFg9LGus8IW+m3FBcTbYk=@lists.denx.de
X-Gm-Message-State: AOJu0YzsbMn2CaW/SJwFKpLwj2FlZjZKmejvXNaosVO/E6p1l5QV79Sf
 8+juogTCwSfHf76gxcZOJl1IU7NpkKUfXDoxegkZd6oLk7DXjqdT1t94C2Ns0xNCn9siyIrfYEh
 EphJZXNeXthcfkKkDksqpgAkw8p1oY+hI4f5O5cxk
X-Gm-Gg: ATEYQzxJovShn+RNbb4HTt1RI5HILX8jES82SqxEljAR0FHd+OUZIICMwMAWefIAUFW
 LpseWOGrB/dlzzuI5PJzQuPhB8Ttll8X97mUGz4GtiPBySKyHxwxFHGZ4R3pd2SnsJNZpH0eXBW
 WbmYWsDLP68BNJsDbTI7ORTjyc0N71a6oZrX0Luq9iHHOnqsTeIFtIFsbyWlasbNCW/+d1ebPnz
 374lAaiDKUIBhSR9r1PyLGT+iKX9WNG/8UjbxN39b3vSMcAo4fnH6HCwrdibUWLdAyLvo3AQ92g
 QeJNJA==
X-Received: by 2002:a17:907:84d1:b0:b97:d30f:cce8 with SMTP id
 a640c23a62f3a-b9c13b0444cmr283888766b.27.1775080869705; Wed, 01 Apr 2026
 15:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-3-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-3-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:00:54 -0400
X-Gm-Features: AQROBzCAI12014FQUo6OrMzr-zz8KP72iJXpNVMxcuxugiWu7ZahwQd6Q7PB9g0
Message-ID: <CAFLszThvj2EOLOq019k791MKJtN0rCits6ZUsuVHi8Mi+c7BNw@mail.gmail.com>
Subject: Re: [v3,02/15] ecdsa: initial support of ecdsa using mbedtls
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

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,141 @@
> +int ecdsa_hash_verify(const struct ecdsa_public_key *pubkey,
> +                   const void *hash, size_t hash_len,
> +                   const void *signature, size_t sig_len)
> +{
> +     mbedtls_ecp_group_id grp_id;
> +     mbedtls_ecp_group grp;
> +     const unsigned char *buf = hash;
> +     size_t blen = hash_len;

The buf and blen variables are not needed - you can pass hash and
hash_len directly to mbedtls_ecdsa_verify()

> diff --git a/lib/mbedtls/ecdsa.c b/lib/mbedtls/ecdsa.c
> @@ -0,0 +1,141 @@
> +     /* check the signature len */
> +     if (sig_len != 2 * key_len) {
> +             debug("%s: sig len should be twice the key len (sig len = %ld, key len = %d)\n",
> +                   __func__, sig_len, key_len);

The format specifier %ld is not portable for size_t, please use %zu instead.

You can use log_debug() and then don't need __func__

Regards,
Simon
