Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FF8C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B6E84AE8;
	Fri, 10 Jul 2026 14:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fBAB7zMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731CD84BF6; Thu,  9 Jul 2026 20:37:47 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B20584A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6976b0c5adbso219803a12.2
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622265; cv=none;
 d=google.com; s=arc-20260327;
 b=gEXAVMm039VNpJmlvwY9ijRYPlXSueHz1t52jeEPtGDAdFW4sApVWc0DcOv3Zs0RbB
 xqj2Yo5Z8DeozCL43y4An/AjvwXYZZGudJcWRcm9gShwPNnNEdZpsSVB330tgbHwcm9L
 VmeM4rOU3QejFSzWXcHzcHYvueywxAM7mU4GJaSqn+cDi7CpjF4Y4nYgWuQ8uGAzIrj/
 w0c6OlIu4i/76DP8grxipqYyJ9oizly5s6mYZ/7O98i9gBV31YmX6hxfDy+OK29Cyqt3
 IffvB54wZoFjCwHAQ/TlD3kReeSknQVBc9MmwsjLMqLcPvuEWA0osa6aFC4PjgWphXSc
 yGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Qa9jHu5+Ml0KIWP0OTo3cpq98Y2jOx2Mx6Jb9OrZEEo=;
 fh=syXcLE83OFDraqGbuQhMyZ13Rvk/iT7U0hwLRfOyT4s=;
 b=ql8DOTNNsitvON1qeM1FHDVC+Pa5fc+2Ojb5L4M0n6NpU3xAfFD45KPhaF4tWv3DSD
 ThYGYC8qKNLrvkTGS4B7NJtIWMuS/l+RFJrF4ks9bZtJpzbgEY3CjmyfotpBhhkLa6Tp
 NHkuCwH2asfh7UsmudD6AJvmXsZyeDX/xk29EK8zAjPHUyLYbKxjo8Qx+ldPVdqnBjcK
 VA449nKk1z3ON8B2sX+tnK7m0WjQXxUYNxg3I97CrRm6c0s4ied+DP6gea8bENR3mPvS
 eOmEyv8FyKZ+k+aIiHnDThWCsclo3jg9aCEEPyI3ZilxBdYNSyi5HsOOHojEaO2TikE7
 bBdQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783622265; x=1784227065; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qa9jHu5+Ml0KIWP0OTo3cpq98Y2jOx2Mx6Jb9OrZEEo=;
 b=fBAB7zMGvMxomqP0nE39uLYOiWXObem25KfGM4UlSgueE3wtq/fG8e4X9Kp87OhyL/
 y0bfqHXLf5rlKw4J+zDU5Kp7RIXtV4UWxZcMOc8ndB0jceYZFjpqlA+cJ0Awot50V/L2
 r0LuKgVRWJwpLs8hSYkgVmaP9AqLGKfRHc/Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622265; x=1784227065;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Qa9jHu5+Ml0KIWP0OTo3cpq98Y2jOx2Mx6Jb9OrZEEo=;
 b=APeTZkIi88icmn7wKR/qq49nv+HzUw//eQfANNsCmaNCp/OCiX7yO4CkqYUkA5nRns
 ndtbWANiGsxZM/XCYIpggRsm0jiA8AMuGHlLcMH6B98A1MRP6bwW1TCUUs35WvB0ZFxC
 zQUxgZPugcGbk6hCAWrlTmvXkEwTDoLdqQL35Ttc+wSQgDN0sDVT9CnDJpJCrP7TyRSc
 vfQsltSFGp9VcS9FOnc7XYtViEtSNBRh5qyyKMUZd8MRnsqMa5Az8VwtcgTos14hu/uv
 655L6KlMJt8PBn97YeP8GlWElb5JUJ6ZNwNmgdTz/2LOB924GP0w5bJN+f+FBZzhryzy
 1IBQ==
X-Gm-Message-State: AOJu0YzeVUa2+eLmsMf5FDqOddjMymf5Fb2ooMOuTnasjQREPTM1j1gr
 9q5W4oX0WnJxwTnoiH9xSNvMm9VUIoktOOXuYMTNuqRsZ7uuovD426nKeie5H2wdbsHFgcXqhVo
 b+3ZcHCREG7Mn2kKwToa6Zx0IAsNsdkgwHT3kXk9I
X-Gm-Gg: AfdE7cmVw/w+fGUaq7Z3Q/nTVxRdISK7ZumC0K1elFveKTFdtvQbUuXjpPFCOXYJxkV
 16Lc9l9GYF2x4yFGEPpvvI/KwUGediDzX4BHWE2ftf7AonYALCc+P6VRBOlOFwFjyWCsEbkulVe
 ecdltjoCpRvoExUlQQrXFNqHTclNIpacpZsZb6iJjJyYO9Gzf+FFQtLLXf+QLvClG5lAMU/kAx9
 U3WJ2skLvm7t21IPo2CmT3XcnnDvPWWUtzKxBVp/7Dj7Hxo+r/8eCy0C5333D47HVlD0ESpzX0G
 P0SdAQ==
X-Received: by 2002:a05:6402:4345:b0:698:3b7c:7e48 with SMTP id
 4fb4d7f45d1cf-69ab44d218fmr3497896a12.40.1783622265037; Thu, 09 Jul 2026
 11:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
 <20260702-submit-ce-series-v2-v2-6-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-6-ffda5bed58af@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:37:28 -0600
X-Gm-Features: AUfX_mzazuUupWz8HRw_cy4Xf7QPaHDGcp9bXAELBBPOFBJtikoTsoRE1z0-mzo
Message-ID: <CAFLszTjzEfuXRrvwurE4+_XgoeAd-KLhuJ5toZg9TmNYX8oH8w@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] lib: ecdsa: support additional curve sizes
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

On 2026-07-03T01:49:45, James Hilliard <james.hilliard1@gmail.com> wrote:
> lib: ecdsa: support additional curve sizes
>
> U-Boot's ECDSA FIT code is tied closely to prime256v1 and secp384r1.
> Hardware verifiers may support a wider set of curves, and FIT public key
> properties need to preserve the fixed coordinate width of those curves.
>
> Add common curve-size handling for secp224r1, prime256v1, secp384r1 and
> secp521r1. Use fixed-width big-endian byte arrays when writing libcrypto
> BIGNUM values into the control FDT so non-32-bit-aligned coordinates such
> as secp521r1 are encoded correctly. RSA key sizes are already multiples
> of 32 bits, so their generated byte encoding is unchanged.
>
> Register the corresponding host and target ECDSA algorithm names and
> clean up the libcrypto signing context so raw signatures are owned and
> freed consistently on error paths.
>
> SPL ECDSA verification uses UCLASS_ECDSA, so make SPL_ECDSA_VERIFY
> depend on SPL_DM. Keep fdt_add_bignum() in the libfdt error namespace so
> RSA and ECDSA callers continue to handle FDT growth and other errors
> consistently.
> [...]
>
> doc/mkimage.1                  |   3 +
>  doc/usage/fit/signature.rst    |   9 ++-
>  include/u-boot/ecdsa.h         |  22 +++++++
>  include/u-boot/fdt-libcrypto.h |   6 +-
>  lib/ecdsa/Kconfig              |   2 +-
>  lib/ecdsa/ecdsa-libcrypto.c    | 141 ++++++++++++++++++++++++++---------------
>  lib/ecdsa/ecdsa-verify.c       |  39 ++++++------
>  lib/fdt-libcrypto.c            |  60 ++++--------------
>  tools/image-sig-host.c         |   7 ++
>  9 files changed, 162 insertions(+), 127 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
