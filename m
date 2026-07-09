Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320EFC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBE784AF1;
	Fri, 10 Jul 2026 14:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i4zNMSva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480CD84BF6; Thu,  9 Jul 2026 20:37:51 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56C9A84A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso181649a12.1
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622269; cv=none;
 d=google.com; s=arc-20260327;
 b=Svh37VsD4obCNBEMiib3Axq0IyIlMNc2Iqhcll3D+d0JOyiWuEN+MC/qVSvfd3nw+0
 LR6nor/GY1viOZHo5pCPdBqLFdxtDrJhb58kMkka1R67AaK7l6NSz3akbiFx4e6MOXYA
 5hS2yjkhX1ngY36zB6PErOYPfGxapH5zRKMfTZgAyR+QVCjfbjcmjgBmLiHrbeGTYDF4
 k9xaBNqeQbDUCudxG3ojaoxuGQAV1D57icbGr2p6M2UxKmHHltu33ZHBmKhRhFTn0Dvi
 24jy+eFtetINXCf87RNftzqtgLAmkfAuY5qj4DxnPXBxasKgMBlciSPO6JgSJt1pxCof
 MOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6yNalqxvIevq4+QhlUbhXvg+TrZtl7yX2bP73r9aKrc=;
 fh=syXcLE83OFDraqGbuQhMyZ13Rvk/iT7U0hwLRfOyT4s=;
 b=ALopI1+AFh0/Ke0x9oNgr1XZw4wJ0k8rZeEgA5kNv656iV1sWM6p4nFYwFqQN4r5G2
 8aX09Vs8qMWrlmhX7KvOhxmuzoB+C9B+QSSDGPuWJhFWksXSPtn575aMLs9KcBaw92Q2
 vb5PEiBSL9tXK6fHDhNimyeIRZZXRqk1ZlWWy0+acySsbn6ineuBchaWdlOeYdG0jOG7
 iomzy8h3F7eFzZQf0N10ZMS8rERr1uSR+gI0njckfAtlbpUMPtYydcYX44VBL721KZJT
 auybZoAxhSmXOiY0NTGwxKlXNuzo6NBIzrH7eE2p2mAng7dWVdztqGC9YG1fXpWVezF6
 cOyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783622269; x=1784227069; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6yNalqxvIevq4+QhlUbhXvg+TrZtl7yX2bP73r9aKrc=;
 b=i4zNMSvakEZHHg4PPksoJZyetRC8vUgyfKSBEUeDPkLHbwMUZHI3qrCNCd7Maro30o
 Eqj/frI+OsLP3mNOueZQgws0yEeHbgnSHHVWe40mGhAyhyjAvD0M36Feu69TmpFxDz6X
 VnBTfbks/xlghK+CSCN4wFBKY/L5usLR4n1+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622269; x=1784227069;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6yNalqxvIevq4+QhlUbhXvg+TrZtl7yX2bP73r9aKrc=;
 b=lStp3bu0FDW2/XyJlK4RPmhTzZ5Wsik1Z0yr87lC/GJftEccalKaIYdGpXACsjV51l
 kfZFnnhTWb+K+yjTnTBtnMocDbT2t78vm3H521qX/yE8aNoUKwmOJYUv0RyUX9GgKTTr
 GW/HAr7GdOfHuzyaz2yH3vK908sm09EOuCP+2BchoCh0vcX4rQ8oatJfdiuUiPgN2Mak
 C5Pjyk8SnQMJnlV1I7pFHxiLP8ZkLrhGI+Gf2yJiXuaNOD/ykOADk+qIavjGzgjbAzac
 rKC651ytRDoqlvgS5JQytgGp/g5mhd5MVHYtQSg7UKSktmJXdYAj0w6eKpyqinafsDHt
 6MBw==
X-Gm-Message-State: AOJu0YwCNRqWKURCdhR/aertA4oF1KW30MiwWWNQhIP6TcrKBSRHKG7Y
 W7SFPcI4wuuKt9tX9ooAykgPPClX4+sdToPJu1o5IKscYqlCdgqHFpoSDpFv0A2sFEKdETBzNk2
 gqxY2HEHy8SOik5a+Yqc5Bkp5cUxMnFsKWhRyRhcO
X-Gm-Gg: AfdE7ckOuuREZVsHer29GX0vTaL5R+NdSuDCQ+SnO3Fy2fyOOMHp/r79v07AkWl5t9A
 9SSdWl8JLd4iICiOP8xmoIEgB2gceaxnGe/b/crG45nCKFryjo4Qqjgv63WcX30q8rcdSJOrfaI
 LlPtb0ZFBpcnJA6QAgeRfEzmsrTuP2xpxWmxm2YDNV98DgGzndHuhT2LVmEGGhKlGtQRICrPRrF
 jFqLjHF+54gdI3s60Ws6xhIdkksuZvOfarKZ1TZqqUDZ1NtYxql4k/727bVbEn4+KNAxxA=
X-Received: by 2002:a05:6402:2b8a:b0:698:351c:97a4 with SMTP id
 4fb4d7f45d1cf-69ab44614b6mr3502288a12.14.1783622268733; Thu, 09 Jul 2026
 11:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
 <20260702-submit-ce-series-v2-v2-9-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-9-ffda5bed58af@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:37:35 -0600
X-Gm-Features: AUfX_mzfm4SmMqE2Bb382NJICg-2gWR5_8HyRYLU_sQPw6MY7Umo31JGqRFNMzE
Message-ID: <CAFLszTjAStcnjPmQcZ972PkJAw6MKxZqesykxg4fa=NReOUFag@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] crypto: hash: allow DM hash in SPL
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
> crypto: hash: allow DM hash in SPL
>
> The hash uclass is currently keyed only by CONFIG_DM_HASH, so SPL cannot
> enable UCLASS_HASH independently. Any SPL code using hash_digest*() has to
> rely on U-Boot proper also enabling DM_HASH, and the FIT hash path selects
> the driver-model implementation with a non-phase-aware preprocessor check.
>
> Add SPL_DM_HASH, build the hash uclass from CONFIG_$(PHASE_)DM_HASH and use
> CONFIG_IS_ENABLED(DM_HASH) when selecting the FIT hash implementation. This
> lets SPL FIT verification use a UCLASS_HASH provider without requiring the
> U-Boot proper hash uclass.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> boot/image-fit.c             | 62 +++++++++++++++++++++++---------------------
>  drivers/crypto/hash/Kconfig  | 10 +++++++
>  drivers/crypto/hash/Makefile |  2 +-
>  3 files changed, 44 insertions(+), 30 deletions(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1321,43 +1319,49 @@ int fit_set_timestamp(void *fit, int noffset, time_t timestamp)
> +     {
> +             struct hash_algo *algo;
> +             int ret;
>
> -     ret = hash_lookup_algo(name, &algo);
> -     if (ret < 0) {
> -             debug("Unsupported hash alogrithm\n");
> -             return -1;
> +             ret = hash_lookup_algo(name, &algo);
> +             if (ret < 0) {
> +                     debug("Unsupported hash algorithm\n");
> +                     return -1;
> +             }
>
> -     algo->hash_func_ws(data, data_len, value, algo->chunk_size);
> -     *value_len = algo->digest_size;
> -#endif
> +             algo->hash_func_ws(data, data_len, value, algo->chunk_size);
> +             *value_len = algo->digest_size;
> +     }

The bare '{ ... }' scope reads oddly. Since the DM branch always
returns, please move the declarations up with the others (or use an
else after the DM if) and lose the extra indent level.

> diff --git a/drivers/crypto/hash/Kconfig b/drivers/crypto/hash/Kconfig
> @@ -4,6 +4,16 @@ config DM_HASH
> +config SPL_DM_HASH
> +     bool "Enable Driver Model for Hash in SPL"
> +     depends on SPL_DM
> +     select SPL_CRYPTO
> +     help
> +       Enable the hash uclass in SPL so SPL code can bind and use
> +       UCLASS_HASH providers through the driver model. This is useful for
> +       FIT verification paths that want to calculate image hashes through a
> +       hardware hash accelerator before U-Boot proper is loaded.

HASH_SOFTWARE still depends on DM_HASH (not the phase-keyed form), so
enabling SPL_DM_HASH alone gives SPL a hash uclass with no software
provider - only hardware drivers such as the sun8i-ce hash child in
patch 10 will work. Please say so in the help text, so users don't try
SPL_DM_HASH without a hardware provider and wonder why hash_digest()
has no device.

Regards,
Simon
