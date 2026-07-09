Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EECBC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C91284AE6;
	Fri, 10 Jul 2026 14:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KtlZ6m8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B16284B73; Thu,  9 Jul 2026 20:37:38 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13A5484A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba3e6so229765a12.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622255; cv=none;
 d=google.com; s=arc-20260327;
 b=di2aLS61Sc5uMurNA/gvd57Doa4XKKFMDF6XPsdS0+6JqGx3QUQoZuHTqLS8SxPV+f
 BfJluwUTFWOvd5sIGaE0MK1mwDfrGdTx+Gdp1HpgvgG3EgrA8i58ctIprSqfHCt7lyVw
 nZoHeKQNGPtv2N/WewYOC9pUdLe89WWwVmcJ4Abmm5RBf36p0ZwuRYn4dYZarVtyaOpy
 2rmGtRUtNZGIYGxMWafcCrzqwOolyjvqoND8eJpLxSYPDMO+Jkt0JID2/ANOt+HiHKdP
 TIvPNU3HnXSqSf7nuipQqws2v6F5jIrxhJK/ewvSagDaAFMssCIQu2KaMr6nkmMd3T4T
 OGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QQcA8sJwsqJ5xO1SJF4Q+3ZBEGVVX7AJ+Th1L7MNWNM=;
 fh=syXcLE83OFDraqGbuQhMyZ13Rvk/iT7U0hwLRfOyT4s=;
 b=ovqWrB1oc0OjPvicKWoruJcFYQzDJ1it6KNCB1FUQvlo5JZdZFSgmm12eP8pFv7me+
 GPQcjgyVEMVCbvLIuJcTtPSxtRUKnXY06S7BEnRt6V4UedpN0PPEPLF/LarflzmizYIt
 JAWUCjTDJQ6aPjUxvHNNKYcfxgRGC3TeiA1mj2H/WuHk9NXsmAe8YIRGqNrr3lWpUvoA
 phSPVrQSXB7MnsDAxvuXES9ix9v2jHMn/hxyD5PQdX5imf7ezFZHp5sAYeq/P+t0bPUD
 RYmEwaLW7ns0p8Q41Y8zrPlvSQtOZ1CNNVT5bpz3fFD1M5r+LjQDQY5MqQFy4jU7ixnP
 cfsA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783622255; x=1784227055; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QQcA8sJwsqJ5xO1SJF4Q+3ZBEGVVX7AJ+Th1L7MNWNM=;
 b=KtlZ6m8x+d85fuDe/AiOLry/hPyg+TSwAHtlh/czSzp/3gQ0B9qRo48kJwyd8tmEc9
 yyhbkb7u4795oGxQP4TaWDvZ4u+MaCwQUuwR2bjy7H4ZwS0LUUSg+tE3C0Eds6GNsDhI
 K/fhZdC4Kidfbl7yoYVBRq8jQzl8Cd/gi6Z+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622255; x=1784227055;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QQcA8sJwsqJ5xO1SJF4Q+3ZBEGVVX7AJ+Th1L7MNWNM=;
 b=fGn6bIVB5DmJWQoXmOjeOBkgc+nEorSIsN79Uhid8kHySVgh/qTxdz/ZmwugCrQzhK
 vLWsyMcdOeQcx2n69HFvMOvMqFvD9joXT7ohSE8jIbU7Piuaj1X9BLQMxAm1hY0q+/Zd
 Rj0pUZ31Maj7earI/Y+jldu/W1KAZm2veV5CERCrtE+28yww5j6YjTDHef8GAafennlj
 Rbncydk/jbBKLzDcjSkP4+tgcjzn0tm7kWvEv4DBo5MTL1+AE8a40f1sd49QftAXIVhI
 pD6KQYFa9Xuq/RFaRVU3VtyCVeLL5sHdkmZe+vlPMV2Wa+bqEUpydwxKLCUmkWxWLHOG
 qBAw==
X-Gm-Message-State: AOJu0YwJoVXYV/OCPfckMJx8HkWzoBAcgRrZ1QfK+ysO+ch9CSifP9s3
 tGciQKEBru7fcKY7h3MNX6Y1lSYou74c56JBWWQpoeXWqasUPIy2uhEt6nL1dR7/fGvWjXMfNyc
 nee2Qc+/IagtRBZPtA/S6B2BEhrNCDCheze5bbhVb
X-Gm-Gg: AfdE7ck5w+qOwI2clxVqx8ETNbgaZIC8GgbAl0i9uI4MBpBdiS0pLdKOnKkwERJKBhZ
 9GLFTEQ0MRiNk230+085gKPg7OIJyxfZQ9kdRQgVCiEKTOinJLfcybXBwf/gXgkYcvJhD0C7ypB
 fQVlii9NAQ51zpCdLF6Z6/c+z6DXPRMLlntcKOGqj8aQCK6nghKFthuiyW/YlqixcUS+Sx4nn6z
 BEv/eSPuVrHIZQvrqD2Qb8MiGDbZdGdIwDBXK8pP5JtA3CT8iBeIYh2etRYNadk3ANNSNk=
X-Received: by 2002:a05:6402:371a:b0:69a:928:9407 with SMTP id
 4fb4d7f45d1cf-69ab44b5648mr3434701a12.36.1783622255560; Thu, 09 Jul 2026
 11:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
 <20260702-submit-ce-series-v2-v2-4-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-4-ffda5bed58af@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:37:22 -0600
X-Gm-Features: AUfX_mxCutOE0pwPjPj0YNIMmst5O5Mhgp9lx3r1Z2I6NW8xuD90RdSsg6GzbWo
Message-ID: <CAFLszThtO25OjJDHd8tb7D5uP00_UBXJLinGmSeH4LxE5hMm1A@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] spl: fit: support encrypted payloads
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Michael Walle <mwalle@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

On 2026-07-03T01:49:45, James Hilliard <james.hilliard1@gmail.com> wrote:
> spl: fit: support encrypted payloads
>
> Add SPL_FIT_CIPHER and decrypt FIT image data before post-processing,
> decompression or moving it to the final load address.
>
> SPL cannot always allocate a new output buffer while loading FIT images,
> so use the caller-provided decrypt-to-buffer helper. External encrypted
> images are read into scratch memory first, then decrypted in place before
> the existing copy or decompression path consumes them. Embedded encrypted
> images decrypt into the final load buffer, or into scratch memory when
> decompression is still required.
>
> Use IMAGE_ENABLE_DECRYPT in the common FIT image-load path so FIT cipher
> support is selected by phase. Keep that path disabled for host tools,
> since the target-side decrypt helper depends on the U-Boot control FDT
> and runtime crypto providers.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/Kconfig         |  8 +++++++
>  boot/image-fit.c     |  2 +-
>  common/spl/spl_fit.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 70 insertions(+), 8 deletions(-)

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -256,6 +281,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>       if (spl_decompression_enabled()) {
>               fit_image_get_comp(fit, node, &image_comp);
>               debug("%s ", genimg_get_comp_name(image_comp));
> +             needs_decomp = image_comp == IH_COMP_GZIP ||
> +                            image_comp == IH_COMP_LZMA;
>       }

This also drives buffer selection for the encrypted path. If someone
later adds a new compression type here (say IH_COMP_LZ4) they will
have to remember to update this test too, otherwise decrypt lands in
the load buffer and decomp then overwrites it. Please extract a small
helper like spl_image_needs_decomp(image_comp) so both sites stay in
sync.

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -267,6 +294,10 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>               load_addr = image_info->load_addr;
>       }
>
> +     if (CONFIG_IS_ENABLED(FIT_CIPHER))
> +             cipher_node = fdt_subnode_offset(fit, node, FIT_CIPHER_NODENAME);
> +     encrypted = cipher_node >= 0;

If SPL_FIT_CIPHER is not enabled but the FIT actually carries a cipher
subnode, this silently treats the ciphertext as plaintext and hands it
to the copy/decompress path - the hash check passes (FIT hashes are
over the ciphertext) and SPL then hands garbage to U-Boot proper.
Should we have a message in that case, or can we assume that
SPL_FIT_CIPHER must be enabled whenever we encounter a FIT that might
have ciphertext?

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -331,10 +363,32 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
> +     load_ptr = map_sysmem(load_addr, length);
> +     if (encrypted) {
> +             void *decrypt_ptr;
> +
> +             if (needs_decomp) {
> +                     if (external_data)
> +                             decrypt_ptr = src;
> +                     else
> +                             decrypt_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR,
> +                                                            ARCH_DMA_MINALIGN),
> +                                                      length);
> +             } else if (external_data) {
> +                     decrypt_ptr = src;
> +             } else {
> +                     decrypt_ptr = load_ptr;
> +             }

For external_data the answer is always 'decrypt_ptr = src' regardless
of needs_decomp, so this can flatten to:

    if (external_data)
        decrypt_ptr = src;
    else if (needs_decomp)
        decrypt_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR,
                                       ARCH_DMA_MINALIGN), length);
    else
        decrypt_ptr = load_ptr;

That also makes the intent easier to match against the "read into
scratch, decrypt in place" wording in the commit message.

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -352,7 +406,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
>                       return -EIO;
>               }
>               length = loadEnd - CONFIG_SYS_LOAD_ADDR;
> -     } else {
> +     } else if (src != load_ptr) {
>               memmove(load_ptr, src, length);
>       }

Please add a one-line comment noting that 'src == load_ptr' only
happens when we decrypted straight into the load buffer, so the next
reader doesn't start 'fixing' the else-branch.

Regards,
Simon
