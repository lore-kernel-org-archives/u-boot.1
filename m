Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44387CD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 07:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6387C844CF;
	Fri, 29 May 2026 09:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLFbyBVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E753683FF5; Fri, 29 May 2026 09:17:12 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5D0846B4
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-be4344dde59so306539366b.3
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 00:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780039029; cv=none;
 d=google.com; s=arc-20240605;
 b=YkZS6r8zuRN+Lm0Jv5AKljRljPJ1xhuOJfzetNwJ99CTIV3vUjbAfImCPUGSyWt3sE
 TSxNWdJUk6nyM75WMehAhMoHKzUjD/ziIgtaopJqF54l6hau4rbvXS991EJk0EvVN7CE
 axkSq52/w3mhwxH36gQMGjHkdiyQYXPp5st9RetyzPuayFqdCxQQ6QYAtaL3PhBV/o4K
 NaGhWbnlny7W6sY0x30ENtao2s5biQW49AplyEGUPhYZ4Ms8YpsYXllTt49aBXepbbpP
 sG2KxW16icsbJzvvC9d1zvo1fYJegkB5FTidOgbLZBUR9uROr2m3eeg/9UV55Qsdlqgm
 wpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KbGFusVcj0tprh3+uXLMfeXRLjyy6Nl7EPqKvkt844M=;
 fh=wSNk3njf6XJwENMim3zUyHivj0XKS2Jtwnh6ltO1rIw=;
 b=djShPxB69bGW1Do3WPK0J6CmOQVBVO69nw8I9KHT9SWUErAEQb1hac9EEpWAOt+ZSS
 Q1+lc2q2IdgZ/Hpd12mFCIRO/hfGH3rVfFjb73TsUtVOm0HqdZjnfQi3t8XF/oj6rTG1
 cIXiGOYwEfWZOsTeTtFuZ9fgFuUs6ku4nAc6BYsv1THWooQ5eVgo1M5TSxxGwCm9k9Gy
 svZaArxP96qFo7wrMCBcRQ2waNXxTtDB+7eR4rGNWHCLbAc8OdXfolgdml9eg+TCiogS
 EzCxKy5W8ZEI4DNTb++P5HRp1iq+IYLoUfMUUfETfxVuxCgPDCtwt4sz54Y2JU7rI+bG
 pUnA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780039029; x=1780643829; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KbGFusVcj0tprh3+uXLMfeXRLjyy6Nl7EPqKvkt844M=;
 b=QLFbyBVfK6EnRp2XQJwBZxjPjPgPZ9cyYyL+BN++VeOXstZo3XxH6KmRPchr3tYYRX
 oDsHJorKB54JXpgfozMAbQwkpQMSQfCYiUqNrgWtja44on2ZDVoVKu2lfjQ0img0Bp0d
 bxMWhIR1e0pAbe9ZVtnXE95Pyxtrc+28dXhBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780039029; x=1780643829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbGFusVcj0tprh3+uXLMfeXRLjyy6Nl7EPqKvkt844M=;
 b=NN9t3Y7mmGxZovY+nt/9QiBSgY9vHPIho6pojYHc7sigTWfW+rH5V9j7fMrL1cx+9m
 oGbXKJQBtTaXuqU4MT/gbwWGgwPCx+/XiMWoRfRDzcD6YEvwUZY2VUpQc+19ZRNRmsRh
 xiDaZQDDR+FDuRBKT1Zs+IxZ6LltRtqrDJQBE9ew3CbYA4Wlurrms2VfLK2VTndoOEfP
 GTCx8XfDwMVytv6QTm49Hc5fl73BjK22hTSUcGKS6GTCKe1DeQxKr6AhtYIC+EU6egEO
 2zqQECEKWWS+qrPg1X7RUd4lo2rD0mQzHCGeXjr1AG1DhXmL5EMgOnYi7Jp4RbZIgVDq
 6lPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/F7cgxo1MdOatfn80Si6xx59Gnj3zkmq2QWNZHTJO0id3eSYX+bUoNpzJYTB8FLTAu5LHBLCU=@lists.denx.de
X-Gm-Message-State: AOJu0YyEchvulmgDYrZUx6h/HpiFBZcEhaCFh83F0A15vHp7YGWbMPNb
 xQOxs9ODmAhs/24O5s0xJGAh0IthC0I7ZqDXmrj+HzAHSpzayklNe/5VqXAkLYTd8oLhgJ+SUib
 j1PbEtizpdJucxkdQmLsx81o9p6TTibx0UGMH52Fp
X-Gm-Gg: Acq92OFniXM5BW9mXPjLhgpUdzcy4yzwylbUbACMoDpuTzYlA4W1TMnboGGUeMOaX92
 UUI2hGxIqhHPmVvFOAUxZzIdUsfie6PQcN4nFZcVAaTA6eg8CUYv0q+wsYPXnzhdswS+vXMZICp
 p0R0kbhlJ0xsfVcpQv1xG2jdsWB8AbVwZ6vt7iQmwDvgcsKxzZS7Blfmx4QWTH6HffFvyK2+GUY
 5/r7qpycfrepED0u7HKrPvW5mgoofcshK+ODAncop2GfJyia1vGLG14VI5VMGpfy5K6JLBSN/un
 qdlKNMOkNdKLRkDR3Uo=
X-Received: by 2002:a17:907:c09:b0:bcd:695d:2845 with SMTP id
 a640c23a62f3a-be9cf0b8e76mr64901866b.38.1780039029138; Fri, 29 May 2026
 00:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
 <20260528081916.11355-2-philippe.reynes@softathome.com>
In-Reply-To: <20260528081916.11355-2-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 29 May 2026 02:16:55 -0500
X-Gm-Features: AVHnY4Ly1OwxwKp3vApJomdSHR5v206rJJUrTmrSwDma7PrqfZNNp-wReAhf-BY
Message-ID: <CAFLszTi6bciTi6AU-k6EU0LXEpJ+n4qbM-zdSQrHow4KNcD2-w@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] ecdsa: fix support of secp521r1
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

On 2026-05-28T08:19:01, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> ecdsa: fix support of secp521r1
>
> Current implementation of ecdsa only supports key len aligned on
> 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> aligned on 8 bits. In this commit, we update the keys management
> for ecdsa to support keys that are not aligned on 8 bits.
>
> Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>
> lib/ecdsa/ecdsa-libcrypto.c | 65 +++++++++++++++++++++++++++++++++++++++++++--
>  lib/ecdsa/ecdsa-verify.c    | 65 ++++++++++++++++++++++++++++++++++++++++++---
>  lib/fdt-libcrypto.c         |  2 +-
>  tools/image-sig-host.c      |  7 +++++
>  4 files changed, 132 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

questions / nits below

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -41,10 +43,26 @@ struct ecdsa_public_key {
> +static char *memdup(char *buf, size_t size)
> +{
> +     char *dup;
> +
> +     dup = malloc(size);
> +     if (dup)
> +             memcpy(dup, buf, size);
> +
> +     return dup;
> +}

Please match the U-Boot signature: void *memdup(const void *src,
size_t len) (see include/linux/string.h). Making buf const lets the
call sites lose the (char *) casts. Also note that fdt_get_key() now
hands back malloc'd buffers - please spell out the caller's free
responsibility in a function comment.

> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> @@ -135,6 +180,18 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
>       .verify = ecdsa_verify,
>  };
>
> +U_BOOT_CRYPTO_ALGO(ecdsa521) = {
> +     .name = 'ecdsa521',
> +     .key_len = ECDSA521_BYTES,
> +     .verify = ecdsa_verify,
> +};
> +
> +U_BOOT_CRYPTO_ALGO(secp521r1) = {
> +     .name = 'secp521r1',
> +     .key_len = ECDSA521_BYTES,
> +     .verify = ecdsa_verify,
> +};

I'm not entirely clear why there are two entries here?

> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> @@ -50,15 +57,48 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
> +     x = memdup((char *)key->x + (x_len - expected_len), expected_len);
> +     if (!x) {
> +             debug("Cannot allocate memory for point X");
> +             return -ENOMEM;
> +     }
> +     key->x = (const uint8_t *)x;
> +
> +     y = memdup((char *)key->y + (y_len - expected_len), expected_len);
> +     if (!y) {
> +             debug("Cannot allocate memory for point Y");
> +             free((char *)x);
> +             return -ENOMEM;
> +     }
> +     key->y = (const uint8_t *)y;

A few things:

1. You should be able to drop the char * casts for memdup()
2. When the y allocation fails you free x but leave key->x pointing at
the freed buffer, so a later fdt_free_key() will double-free. Please
set key->x = NULL after the free.
3. The debug() messages are missing a trailing newline.

> diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
> @@ -50,15 +57,48 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
> -     if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
> +     /*
> +      * The public key is stored as an array of u32, so if the key size is
> +      * not a multiple of 32 (for example 521), we may have extra bytes.
> +      * To avoid any issue later, we shift the x and y pointer to the first
> +      * useful byte.
> +      */
> +     expected_len = DIV_ROUND_UP(key->size_bits, 8);
> +
> +     if (x_len < expected_len || y_len < expected_len) {

The previous check was !=; you have loosened it to <

The padded length is known exactly, I think - isn't it
DIV_ROUND_UP(key->size_bits, 32) * 4. ? So could we check the exact
value to avoid silently accepting (and truncating) over-sized
properties for prime256v1/secp384r1 ?

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -130,11 +189,13 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
>               fprintf(stderr, "Failed to set EC_POINT as public key\n");
>               EC_POINT_free(point);
>               EC_KEY_free(ec_key);
> +             fdt_free_key(&pubkey);
>               return -EINVAL;
>       }

The repeated EC_POINT_free(point); EC_KEY_free(ec_key);
fdt_free_key(&pubkey); return -EINVAL; across five exit paths is
begging for a goto-style cleanup at some point in the future :-)

Regards,
Simon
