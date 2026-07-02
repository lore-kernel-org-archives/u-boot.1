Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E39C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17E684A20;
	Thu,  2 Jul 2026 22:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DeNfpvTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FBF784A49; Thu,  2 Jul 2026 22:03:59 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4001C84857
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84347ad88edso2710127b3a.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022636; cv=none;
 d=google.com; s=arc-20260327;
 b=Q9LQYtPjinbLCobw8f1YNVCS8ZHdoBbQoKbOP8wv992RujIIh6SJaZ8gs2xkH7YdJk
 0eUEaTuGvsiniVIDMZbzJBxA1xiXA5f3xvEerctz+jyvmQgz3lip2XqpeyXmucuk75Yb
 DeJoxK9nncuX3O+I8iXNWUJzUg8mbCQgWFYze24KBgmfwoFTA2RRxQlY+fQMa++x9PlU
 /kx/muzAx7LkFZ/2N1J0ncGYjOPDKB7HH4Y138CfGbSZ2NrkvlGzljnFmT43CU9e0n0n
 LdxP57XEACn/rqLfzxIjUxgsGqHJ5KKYoG1QYqoESwmiudsgd9PsOs5ttaFo89Iu8cJ0
 w19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ViNagXrucYQ9ALKpvw4d+UQtu4feO/ZvjgmlZgHDmPs=;
 fh=DK+fhZAjxk4Bj+Oxnkexj7mAnIfWFJ8oiB1vRcOWfgA=;
 b=YZ673Yf8WdmU0DFRebolefgonoHBx2hfyuiqF0B5aUjRRgTVu15Idn/5HyOUjv2UYc
 Cp+3C7Xqlf2gbpKysUjWTAgcdIpegJuN8P3cS1JFmIzZx6shUEswJjnk4M8AmAlBdEFR
 9tcsR33ghtpNOHtkzl9fbMlIdXSQh8PQPVBqtLSDLH1UQXj+IbpIuNVX7kPS9rMypfaN
 rSZ6/XiCgw9tK+ZTGhTYdxyRIKIVMBT+9kRehae+xtrj94ThpiH9EEZeSm7xcGzNbS3C
 fPjqVv5ld70qlPmVZ9ZT0Oi5CjhZsI5Tu74qSa2N5k1t8JLTR+VKtkCggmuHCX3y7h6t
 mEig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022636; x=1783627436; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ViNagXrucYQ9ALKpvw4d+UQtu4feO/ZvjgmlZgHDmPs=;
 b=DeNfpvTXFYv559o5pK1g7QV1X/TEWFA3MGsCRIxSf+rR6EI4fbtoKufKgYXlqzpIHy
 lOkdt336ToJScqzKpH6+wNBOSLgfR6w+RXOStymIS9f46/VrIWdt8MEt+XHD7TLwMeVy
 dXlyes4PEggmKA6wiOx8AowMvizShuOcM/PkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022636; x=1783627436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViNagXrucYQ9ALKpvw4d+UQtu4feO/ZvjgmlZgHDmPs=;
 b=gGEZN7bfua7yL1oBYbc7M7pKMNZP2X6E6gDn9Pw0Bve3AN2uT2l8/fxau5tNmvM/X0
 e7l4Ut36z6hd/4A/FTskSsfD5pHwBd4Ms5dM/dVcduwfHZiNDZ0TA9UjEciHklxWXbfO
 3iMkum+WL8EOAqmZWSrzl0BmHc3IbK7zv2pHyu9J4qn5MpJgygF7U5zs3tbGkwnDj55M
 hFdjQ86kLbkkUniMgBhCmZT3lYwC272pXf+ekr+CF0lFh6Ra62B+ywL7DHRmMazimhwf
 FfZ6ey6/qutZF37ozF/z2dQsj0EkbjK4SlYLLyEIvcMFdjIZtG0jSI+WFRWhTWDZm9Kw
 QJkg==
X-Gm-Message-State: AOJu0YwrZ4G7MebpjTiANRPYvXhSiZcGYM99xdGUi/IwbOpJ1t+lWoqA
 Xap+6X61BRGpLT3SImuepguMrOWdxowsjJgclXLK0o58HWvf6JbMWCXrrtylYIEf6qj0jAOQHr+
 ljVrr8yoICFx9ZH4zngpIe0yA+fuwg8ozUkNlhcIN
X-Gm-Gg: AfdE7cl31KB0C4tk56v/EdiSbRbFR3WhxRgW8o1NQ9+a7t/YbuKp0bPa57VVCnPlXBf
 mG6KWqxoddXs2/dr3VBs8fNh9T9etDmK6HQJq8WsYQO3eVaZQIujU7AdmueoLZYuXwATX6WZanJ
 tymlOH51tIwOi+6RZsML1c/XqnfTys90089pJHbqt4lUoQCr7da5KBdpX7Gv1sSyWYS746bHqS0
 XspCu0avoEfC/L/0Aqc5n472PgOXhKzZfUw0YaXDy438uFraLs9eUMuWv5Z6f6hGPxL6t1uPg==
X-Received: by 2002:a05:6a00:995:b0:847:8650:69cd with SMTP id
 d2e1a72fcca58-847c5106a0cmr6759117b3a.33.1783022635512; Thu, 02 Jul 2026
 13:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
 <20260702014724.1534351-6-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-6-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:03:33 +0100
X-Gm-Features: AVVi8CdWyrluvnSo7LctwWUps99MOJxW2OfFxgJbxfPCj8CiSXBBa7dnn6kDzc4
Message-ID: <CAFLszTh4QdwNdmEH5TWZw0J+SALCXgiaCCUxC8P8djjJ+hOpEg@mail.gmail.com>
Subject: Re: [PATCH 6/9] lib: ecdsa: support additional curve sizes
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Lucas Dietrich <ld.adecy@gmail.com>
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
> lib: ecdsa: support additional curve sizes
>
> U-Boot's ECDSA FIT code is tied closely to prime256v1 and secp384r1.
> Hardware verifiers may support a wider set of curves, and FIT public key
> properties need to preserve the fixed coordinate width of those curves.
>
> Add common curve-size handling for secp224r1, prime256v1, secp384r1 and
> secp521r1. Use fixed-width big-endian byte arrays when writing libcrypto
> BIGNUM values into the control FDT so non-32-bit-aligned coordinates such
> as secp521r1 are encoded correctly.
>
> Register the corresponding host and target ECDSA algorithm names and clean
> up the libcrypto signing context so raw signatures are owned and freed
> consistently on error paths.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> doc/mkimage.1                  |   3 +
>  doc/usage/fit/signature.rst    |   3 +-
>  include/u-boot/ecdsa.h         |  16 +++++
>  include/u-boot/fdt-libcrypto.h |   6 +-
>  lib/ecdsa/Kconfig              |   2 +-
>  lib/ecdsa/ecdsa-libcrypto.c    | 141 ++++++++++++++++++++++++++---------------
>  lib/ecdsa/ecdsa-verify.c       |  39 ++++++------
>  lib/fdt-libcrypto.c            |  59 ++++-------------
>  tools/image-sig-host.c         |   7 ++
>  9 files changed, 152 insertions(+), 124 deletions(-)

> Add common curve-size handling for secp224r1, prime256v1, secp384r1 and
> secp521r1. Use fixed-width big-endian byte arrays when writing libcrypto
> BIGNUM values into the control FDT so non-32-bit-aligned coordinates such
> as secp521r1 are encoded correctly.

The fdt_add_bignum() rewrite also changes shared code used by
lib/rsa/rsa-sign.c for 'rsa,modulus' and 'rsa,r-squared', but neither
the subject nor the message mentions RSA. Please can you note that the
encoding is unchanged for RSA (key sizes are a multiple of 32 bits, so
the byte array is identical to the old word array)? Better still,
split the fdt_add_bignum() change into its own patch, since it stands
alone and affects both signature schemes.

This patch also bundles the new curves with quite a lot of unrelated
error-path and memory-ownership cleanup in ecdsa-libcrypto.c, which
would be easier to review as a separate patch.

> diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
> @@ -17,7 +17,7 @@ config ECDSA_VERIFY
>  config SPL_ECDSA_VERIFY
>       bool "Enable ECDSA verification support in SPL"
> -     depends on SPL
> +     depends on SPL && SPL_DM

This has nothing to do with curve sizes and is not mentioned in the
commit message. I suspect it is a build fix, since ecdsa-verify.c uses
the uclass API, but please can you either explain it in the message or
move it to a separate patch?

> diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
> @@ -132,7 +132,8 @@ rsa,n0-inverse
>  ecdsa,x-point
>      Public key X coordinate as a big-endian multi-word integer

Since fdt_add_bignum() now writes a fixed-width byte array, the
'multi-word integer' wording for 'ecdsa,x-point' and 'ecdsa,y-point'
is no longer accurate for secp521r1 (66 bytes). Please can you update
these to say the width is the curve size rounded up to whole bytes?

> diff --git a/include/u-boot/ecdsa.h b/include/u-boot/ecdsa.h
> @@ -64,8 +65,23 @@ int ecdsa_verify(struct image_sign_info *info,
> +static inline unsigned int ecdsa_curve_size(const char *curve_name)

Please can you add a function comment in the style of the other
declarations in this file, mentioning the parameter and that 0 is
returned for an unknown curve?

> diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
> @@ -5,68 +5,35 @@
> -     return ret ? -FDT_ERR_NOSPACE : 0;
> +     return ret;

This mixes error namespaces: the function can return -EINVAL and
-ENOMEM as well as raw libfdt codes from fdt_setprop(). Some values
collide (-ENOMEM is -12, the same as -FDT_ERR_BADLAYOUT), so a caller
cannot reliably interpret the result. It works today because callers
only check for -FDT_ERR_NOSPACE, but it would be cleaner to normalise
here, e.g. map -FDT_ERR_NOSPACE to -ENOSPC and other libfdt errors to
-EIO, adjusting the callers to match. What do you think?

Regards,
Simon
