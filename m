Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB63C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:04:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58EF284A6B;
	Thu,  2 Jul 2026 22:04:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D2hVg3Yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 673F084A6B; Thu,  2 Jul 2026 22:04:26 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCA584857
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3804e42ad5fso2540637a91.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022662; cv=none;
 d=google.com; s=arc-20260327;
 b=pQzW/KB3os+i+iNRVwpwdeiadmZikHsWjzQcC8HHPl4KQ06kUC8Lh8V1mMfU22yi0D
 buLLKzt7rpjctjmRPp6fSzfhxijk4wi6bCaWVunB9TJfaxffVyGsWytB2Vx/MLI14q3D
 mf7Ld4a46smcKtqILMdy8VKr0I/wgopkW7daI37CrMgXt8aZ/zrHliY4VAxLnn5JSiEg
 2cTAo1JqZ5QoZzS+Id6vHvznkVSMJ2XXfipaWblQhvt/0eITjzl36wP0KNwcIGglcnEk
 zLOSnCyodko+ZCUJYuR1Fn8nuPi9UGCjMy0QyPoABK9/lDqaeJkZHItaRU+0+9i7lD0q
 nv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d6ATEHqswls1V+Fl+bVL/DhPP3ju64z15cHFuXMMfEw=;
 fh=6vrd56uqUSvkH8lVFDnxOtCC8M+lXhrqtHH7qSgvXpA=;
 b=Op9b6d58QuUlUQSF2o9mFdiVaRxn/pzPyZoMBXFBh59+zzdiX5C6yPykFEiRZInaSJ
 sPpoF41vVnnOHjwiBqV8gaqWkesveGKIBLQCJJtHCerOCCRIGe8dlbHHwTQ4mG0gxB88
 DNWzj7Kb1uIUgJ5c8maW6ToOb4+87LAn2fA71LylwTCORF3cBXhK7Pa3uOD8cIcME3/6
 4kfkMw3DOJI6qpVnJzYnfe5VVSAhAC3b8S6GmiJJ+r8AwOYyUm/KT7jNzlL+lfh2PQZz
 MUkK3KolXVTsZyIwvkI2LLdykiDmRfpETe4nMiI6O4m7zs9uf8nisRoqVEO8HES8zhni
 buwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022662; x=1783627462; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d6ATEHqswls1V+Fl+bVL/DhPP3ju64z15cHFuXMMfEw=;
 b=D2hVg3YruPkP8QHYVXuk4AAmZkpO9wDnQ2nAfztrYIDxmvqCz5lhV1J2OhJXzXi4gF
 SqQo6JarWgFPfiS9HV45JltZwqbpWzkWNyj1yxXMlZESa9h28w2Ij6whWkhsIelBhIrD
 aTfRKY4TzW7WoJWq1XyoYDR/TYPAcm0T/Ud24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022662; x=1783627462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d6ATEHqswls1V+Fl+bVL/DhPP3ju64z15cHFuXMMfEw=;
 b=nTu8bwETS/36C/IXzi4lqZhVb/YFXTsmb63orD0PQj0HU9AyLpdb67QaTwnQrpMWdg
 tAt/vTALJZ6lL4V+OAudVBD63XVl85loj7FNuTWqKyRrUEtn0FpUhwm0KZifM/sGX9+q
 bLj6vOMV2yaZKla0pZefrHguhYk5/n+B3eBiLvORrQdem8ePNjhdgVCOa8bg50m6bxhR
 huOcLEEf5n2opSGg1QiJfEeC/Duz5UfEUT12VyXbCeslRtvvbUeJO6NkxWAoMVAl9TE3
 526ho7NXzZPlsihuDO9j+QmYaVrew7r+4gm+uIf6iaYz1GJCdsW6D7dvCup36Aj6YyHw
 nciQ==
X-Gm-Message-State: AOJu0YzkOVvuLSD/2Ghf+IXBHs107KhuzWqQRdorfHEUQRG6MsZ3Gt/1
 B97nGuohX+5U7DSFeDsH4JGYNjoxliBopuYzJixPv8RKVe89ZNY1ArKVpNChuK0xkmn+XgwYFFd
 RF1qjCKjXwDBIII/Nlosa8YHKxg5fAdxuZzMKcZpd
X-Gm-Gg: AfdE7cnRuBfunXMYMfZL8wy8CU8n8Ce415Yt1FNQBWY/+p/0dAjVPk75UEknvTh4Txs
 6b250+Wq9YMiRDi4R/d9F4h9+1tMYIMs5AOZaWF5Pv9ErGVaInNR6CYGlXEAADWx5lBMPpuZm6c
 1gjsbbMjpGcxMWqqKfNNJoht3uCzMHZSFfLW0mUpkDKsWGZMk2kUoxPuI+vC64GR431K2badOHI
 t3VjXoyNXC4M93y8gVDm/C2b5VmjO5R77HK2k3+9oqJZpvf1ZqkRx3Kb+d2qvzfmBlZloh9GA==
X-Received: by 2002:a17:90b:4a:b0:37f:9ce1:cda8 with SMTP id
 98e67ed59e1d1-380baa88b4amr6909049a91.30.1783022662564; Thu, 02 Jul 2026
 13:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
 <20260702014724.1534351-8-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-8-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:04:04 +0100
X-Gm-Features: AVVi8Ce5ppV4cIRDp7jbl2X_GA38o8-qTUNw23GzyPfo-3HriWV2F5K83jVEwqs
Message-ID: <CAFLszTgXKTB06k8=OoZ28i3pRDZ5aSfjWQgmTL9MPzpAwBn+OQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] crypto: allwinner: add sun8i-ce ECDSA verifier
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>
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

Hi James,

On 2026-07-02T01:46:51, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: allwinner: add sun8i-ce ECDSA verifier
>
> The H616 Crypto Engine includes an ECC engine which can verify ECDSA
> signatures. Add a UCLASS_ECDSA child for the sun8i-ce parent so FIT
> signature verification can use the hardware block from U-Boot proper and
> SPL.
>
> The CE takes explicit curve parameters for each operation. Provide tables
> for the curves accepted by U-Boot's FIT ECDSA parser: secp224r1,
> prime256v1, secp384r1 and secp521r1.
>
> The CE input buffer uses fixed-width curve fields. Reuse the parameter
> packing logic for the message digest as well, so wider digests are
> truncated to the leftmost curve-width bytes according to ECDSA rules.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/allwinner/sun8i-ce/Kconfig          |  29 ++
>  drivers/crypto/allwinner/sun8i-ce/Makefile         |   1 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |   8 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 413 +++++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |   4 +
>  5 files changed, 455 insertions(+)

> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c
> @@ -0,0 +1,413 @@
> +static const struct sunxi_ecdsa_curve sunxi_ecdsa_curves[] = {

These tables add around 1.5K of const data and all four curves are
always built in, even though a verified-boot setup typically uses a
single curve. The SPL SRAM budget on these SoCs is quite tight, so it
may be worth guarding each curve with its own Kconfig option (or at
least the two larger ones). What do you think?

> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c
> @@ -0,0 +1,413 @@
> +     sunxi_ecdsa_copy_le_param(&dst, curve, curve->n, curve->bytes);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, s, curve->bytes);
> +     /* ECDSA uses the leftmost bits when the digest is wider than the key. */
> +     sunxi_ecdsa_copy_le_param(&dst, curve, hash, hash_len);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, r, curve->bytes);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, curve->p, curve->bytes);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, curve->a, curve->bytes);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, curve->gx, curve->bytes);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, curve->gy, curve->bytes);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, pubkey->x, curve->bytes);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, pubkey->y, curve->bytes);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, curve->n, curve->bytes);
> +     sunxi_ecdsa_copy_le_param(&dst, curve, r, curve->bytes);

Please can you add a comment documenting the CE input-buffer layout?
The ordering is non-obvious and the repeated n and r entries look like
a mistake to anyone without the Allwinner documentation. A short list
of the twelve fields, with a reference to the manual or BSP source,
would help future maintainers.

> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c
> @@ -0,0 +1,413 @@
> +     task->t_dlen = SUNXI_ECDSA_PARAMS * bytes;
> +     task->t_src[0].addr = sunxi_ce_desc_dma_addr(priv, src);
> +     task->t_src[0].len = task->t_dlen / sizeof(u32);
> +     task->t_dst[0].addr = sunxi_ce_desc_dma_addr(priv, dst);
> +     task->t_dst[0].len = curve->words;

Just to check, is t_dlen really in bytes for the ECC method? The
scatter-gather lengths here are in words, and for the cipher path the
AES driver switches t_dlen between bytes and words based on the
cipher_t_dlen_in_bytes variant flag. If the ECC unit is always
byte-sized on H616 then this is fine, but a comment saying so would
avoid confusion - and if a future variant differs, this should
probably use a variant flag too. Also, which of the four curves have
you been able to test on hardware? Please mention that in the commit
message or cover letter.

Regards,
Simon
