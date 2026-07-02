Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E2AC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378FB84A49;
	Thu,  2 Jul 2026 22:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pp7TIVGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E1384A4B; Thu,  2 Jul 2026 22:03:21 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E8284857
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38005a36edbso1698538a91.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022597; cv=none;
 d=google.com; s=arc-20260327;
 b=qzPUmjAB8EGlku4yhHqiu8S7IyYAWF8m2jx34dAVtKdDH75KPtmFS4J8m1/sg1FBiB
 PDc/JkVbNUwqRM70pP8MTVN+WZ12bjQoa7NWxYGKlTiPXMlSUR0ENQvNl6esSn0gJ8Cj
 JVgm97l97V6YdS3uJbQ84LnslRyHDWLRXBBvUv8VResUpCrydHykmzn68bTL6mtu+QTA
 O0zdgAq+Bpr4JuKQcWg72ePfwYo4tg6cGaI9oLyj1nCJ0WvlyoBgy+BAlT01BCTKJ2uE
 JtYUqnTQofo3FhuDCreAxEGzRhbVc0BcazYIeZvDF5yPWKZQb144asMQ6eIj8Vtc8H/D
 q1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lyDVZc4orW2uE7aDGyHh57m7BjhoraYHHHAcHJXU8zw=;
 fh=7Z9WKNQvzYoaWzCWsFemk8+xB7xRtXJ3d5ZF3Zb4p1o=;
 b=DmaDnaOwRop4k9uqbfNI07WZUMTEbNeHgXklFpaok1mjpyt3tjaVcxbJRsBr3MSIHl
 Wkj0lTKmU3zlBPXSHFOnBU/ILkKf3xptGMvHNFm7H0rsEkFj0GA7S4Wot/yYrX2iXDk9
 LTeWLzxek4Gx0Tq+BLqifuW8KxK5nF4KlR57usIUiAhqb10+9+C0l92KASQ4avDemPJ/
 lFlupq5rgKeADpnZXjHGTVprdczHJF3iCDWaPJyMofWMtpaRpx0p6RzEcO22cP3F6dHP
 bE6itpU4G902s5bUSC3jqDxKomL5JHTke7NwfQP2TRyBjYyJy0sZgr8O1ZMJs3fmlNEP
 c/nQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022597; x=1783627397; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lyDVZc4orW2uE7aDGyHh57m7BjhoraYHHHAcHJXU8zw=;
 b=Pp7TIVGQ2oTU5NFIeXfxNNtTgWuIrX2U1hJXgxsZSty+1M1jH7WboTBGRX99VyRVZ1
 zmR3u4KO05I+ZBZEEnFt5EJ3jzPtAVsVS5gqWbUc+lhM/zj+5bl9U+NEQereeMal9DZO
 ETfvJKj6G/yNBvSeNwUr00D8XWaUUKag8Bayo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022597; x=1783627397;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lyDVZc4orW2uE7aDGyHh57m7BjhoraYHHHAcHJXU8zw=;
 b=bKG4FG4Q6xt28CjrNr7wGqM1uSTo5ESD3dte4QCR2amZtOiSQur0N3uqbheFOOcWZy
 cjZbFNw6/KWGjnOgibjXyHCBBGDA5bePcrFXmvRw6V+VWCuyPX4Yh08kPmgiCjC3Vo31
 SC0pb3ZmC0TGEmmzRrb9L78SOtpvocKbJ+CVGfxgnYBntJ6KhSCtmJRltR4kaD+Bg1Q/
 nftTGCeeBxXWx6x6tGd8GjXJhZIl2KfY4rDIcQD4TUwBr1IIjwWuvg6oVeCGi6m5Fuwk
 +IreL/C+QrHlMix3S4Hd0X2rydVyIFSty3y+rsymsz7vddQyJsMbt5wrnmzn+gweKH8W
 vN1A==
X-Gm-Message-State: AOJu0YxvvTXvB9A6sIZRKOXryCQV1eUEpIqsV8ZV4XrIfEWq9u45F27a
 IPWuHKfujdr5NKiCz86nCbXMavPNZvAk/DuBTnaMxsyGOOAbWMqh5HEr5hqKoLSK38GUxq91ZpN
 FfA/XSzENn7XfRVBg2qxkTghEbBhokN9G2PH2DQcu
X-Gm-Gg: AfdE7ck96CjNqfiWijQEHfTOQ8F7kgkjNcPpbidHpdOo8HD4LqfbpPGHOonv8QPMrVA
 IgJhVHr3XMCd29yz8gvjLW9AgFa2pC5VFSDTBKihxJqull+a0LpF5W9UBOEOCBVdRP8A+m9d8ES
 k/323jtCvmzSqT92nT88fcCU+hXLQ+22H2fSNZalk7rhfJ3JmhkVyf1LLslnY50Sfr2ubI2Tae9
 E6FX6eCEAM8BsaaSWJ7ZIVFL4Z7W91nmRD3LgiZwPTKVrsYGgtBm2uKWkdZ1fWMC/WT7yitgA==
X-Received: by 2002:a17:90b:2249:b0:37f:b16a:cc23 with SMTP id
 98e67ed59e1d1-380aa1f4d36mr7702321a91.23.1783022597347; Thu, 02 Jul 2026
 13:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
 <20260702014724.1534351-4-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-4-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:02:59 +0100
X-Gm-Features: AVVi8CepaEVDXd0ONjkxj206zBk34shamuBHVeEP76jt8QJ4sEdYY_e7CQ1_YVs
Message-ID: <CAFLszTigHb9UvJCbH=B-wT3fHsPHQAFzYx5Q8ST6pK8GZcDpgQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] spl: fit: support encrypted payloads
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Johan Jonker <jbx6244@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michael Walle <mwalle@kernel.org>
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
> spl: fit: support encrypted payloads
>
> Add SPL_FIT_CIPHER and decrypt FIT image data before post-processing,
> decompression or moving it to the final load address.
>
> SPL cannot always allocate a new output buffer while loading FIT images, so
> use the caller-provided decrypt-to-buffer helper. External encrypted images
> are read into scratch memory first, then decrypted either in-place for
> compressed payloads or into a non-overlapping buffer for direct loads.
> Embedded encrypted images decrypt into the final load buffer or a scratch
> buffer when decompression is still required.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/Kconfig         |  9 +++++
>  boot/image-fit.c     |  2 +-
>  common/spl/spl_fit.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 96 insertions(+), 7 deletions(-)

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -155,6 +155,15 @@ config FIT_CIPHER
> +config SPL_FIT_CIPHER
> +     bool "Enable ciphering data in SPL FIT images"
> +     depends on SPL_LOAD_FIT
> +     depends on SPL_DM_AES
> +     select SPL_FIT

The 'select SPL_FIT' looks redundant, since SPL_LOAD_FIT already selects it.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2290,7 +2290,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
> -     if (IS_ENABLED(CONFIG_FIT_CIPHER) && IMAGE_ENABLE_DECRYPT) {
> +     if (!tools_build() && IMAGE_ENABLE_DECRYPT) {

This bit is not mentioned in the commit message and does two things:
it makes the check phase-aware (IMAGE_ENABLE_DECRYPT is
CONFIG_IS_ENABLED(FIT_CIPHER), so SPL now uses SPL_FIT_CIPHER here)
and it disables the path for tools builds, where the old condition was
true with CONFIG_FIT_CIPHER but image_aes_decrypt() is a no-op that
leaves buf unset. Please can you explain both in the commit message,
particularly the tools-build behaviour change? Normally we want the tools
to have all available functionality.

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -331,10 +383,38 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
> +             } else if (external_data) {
> +                     if (spl_fit_ranges_overlap((ulong)load_ptr, length,
> +                                                (ulong)src, length))
> +                             decrypt_ptr = map_sysmem(ALIGN((ulong)src + length,
> +                                                            ARCH_DMA_MINALIGN),
> +                                                      length);

This writes the decrypted image just past the buffer that was read,
with no check on what lives there - it could be the FIT itself or
another image, depending on the memory layout. Since the compressed
path already relies on in-place decryption (decrypt_ptr = src), you
could decrypt in place here too and let the existing memmove() handle
the overlapping copy, avoiding the out-of-buffer write and letting you
drop spl_fit_ranges_overlap() entirely. If decrypting directly to
load_ptr matters for DMA performance, please at least add a comment
explaining the assumption that the memory after the buffer is free.
What do you think?

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -331,10 +383,38 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
> +             } else {
> +                     decrypt_ptr = load_ptr;
> +             }
> +
> +             ret = spl_fit_image_decrypt(fit, node, cipher_node, &src, &length,
> +                                         decrypt_ptr);

When the image is decrypted straight into load_ptr (this branch and
the non-overlapping external case), src becomes load_ptr, so the
memmove() at the end copies the image onto itself - U-Boot's memmove()
does not short-circuit dest == src. That is an extra full-image copy
on every encrypted uncompressed load, the main use case here. Perhaps
skip the memmove() when src == load_ptr ?

Regards,
Simon
