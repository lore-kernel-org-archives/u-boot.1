Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6230C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 22:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F6C1846F8;
	Sun,  5 Jul 2026 00:28:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ko6ApQmK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBDAB84119; Sat,  4 Jul 2026 12:38:06 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4032480398
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 12:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8ee6912d86dso9045146d6.1
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 03:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783161483; cv=none;
 d=google.com; s=arc-20260327;
 b=Y0zHxnv7yA7u29J7ooYdHzySVJCwbasylQ7HGr/EDHHXCQxabiqpfxN3gBDGMysWix
 /GQpLQtAq5x7k0iv3jD3+qzLETfSbrrPWaZJBiZEPnNrR3Ids5D5mlwv5AxYMgm+SajX
 C7SDyeTKLnrn7815i/mRLg5qD7of+Mf4NhZP6rtWKwmtRkJGT7LFuhvbVI3oc5raNshS
 M97TDD8157ZOIDdBgOfYPXDk2k4cP0ThtWZnEfWdlbWEaKxWpp1NkCBvh/wuDoa5mcUb
 upXSsUsAQtWZShx+bXMHMAJn9tunBakH5ro5Im7bsSqYIUM4XQMDLKu54KmMhghEbiF5
 Kyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XGc8QC4BSLp3V28u4I3gDF6DIW6w8LtITzQiQzRHWJM=;
 fh=Tw3ibjhyn/VJWN2pCiq+vCe3sbZzBviZhQV9R3XIrtU=;
 b=GlJnFqQqPwKWF+sLD8/h93/BXcqKe2kGbtXopW6aXwurMpZ4pUNVhIH9gTFejo+Qmh
 H8BeJhuNn6A7mywz9IUlUpo3F7Q9Z0TFy5P9bKv2LfkVXJPYydmjmckRjBO0AEr6ghlp
 E590371RojW68iJ3nm9Y5Gex+4cWZWhWYM4lxcDzzuKM2hBHj6L+nPsGFgy+tMkg/fyQ
 nqz/HRJ3I0UpO3W5yEv1/r8VoT9XRO97U6RxkQp6rEgu4n1ILzfmPpjpLk/YKz87zNEa
 Nzfx8ZQ6OoC0vTHigLeCI87MrRRHBObhWxZvHLoHIP4p6C26Ar6BcUGqHGPYuHBaso2k
 +q0A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783161483; x=1783766283; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XGc8QC4BSLp3V28u4I3gDF6DIW6w8LtITzQiQzRHWJM=;
 b=Ko6ApQmKNsLbkuuawd99O2HsU/CsjFzeDd+xUAP+tjzfZLyGl7MxLqdp/I5GCaP5Ug
 VPr54lvnM+h7q00aIAZlFtarINYQS3QAyxzE8zOGkfr2nr46YwBynLitWy39oo5am/1/
 46iREGk6lOcn4C9Pbhyux8sKGR2B2zgAzv+qpoOz8w68ybv3GqrwxD5KljKJWGjSvaHv
 ZLD5tfvdDIuaD30J2Tbnwt+65Vr4piSlqELc3gjWuz1iCQjPbvOOU6irPbRJ0fEtRwk3
 Yu3a+fnbp9+oI4jtUmoq7H0mnoA4VNER/oNofYyigAeQTXHgEosw0XSXuH1HrHyV837l
 wLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783161483; x=1783766283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGc8QC4BSLp3V28u4I3gDF6DIW6w8LtITzQiQzRHWJM=;
 b=iwTP9ACmYjueVMJtIIZ9flt0b4+QDUOrC0ZP/Shw6VV5TlhcdpY7miiExGuQp35tj1
 cQZqEReZMWf6Sk+c1BP3dRr3WF1PIOUQzPyOlSCH0osqOQLzjGEXAQZI2DRwM/mzpAY6
 nkMJ2+5tCxxSv6qlA7uEWmdPGtsgDMVlAxXhmY8UESFFJrB3SoT12qxmaAEWrFk3zVFq
 3sLaHU8COGX24VoTfWmsoFiB94xx3Tj7z1+hfRLQJnBdUPizhIIttuKkZ1Acv54SQBkw
 Sz2Tlf2IylFYwGwAORQRGLJoQn8vd8IV1Wb4NHPLq0+mfSzuCzsqRpag5ZRt2N+VudE7
 7pBA==
X-Gm-Message-State: AOJu0Yztat38CfgTBIE37XxKokzMyHhIWNMXN5il2A7sKliDS2GD/jQD
 2uswV8XxHRtrll4aiFamd8oyN8+wXqzgFJ1HlzXAg9TFZW5nlaC3ZV0HjY9RZI4NbHHOAtcTufd
 kXPf4ZUCX+WCJJvhrO38J36EEehc+A1M=
X-Gm-Gg: AfdE7cmjVArIJiX0rZi/nKOk5vpY1Er/QVjQPeoaBKrLzj5hIb4iOD8lgERUOOvb71K
 4Tsbt4dCz3CJfySQmVlRb6Eda4iut2aDZbL/MwmO/pBVh92hb+SM0rp7mWr5VWGTquQMi3AvE4H
 BZdBP2gPY7V89huHr6ETuggqs8y8IT8eiIaHgPiw/X2rmb2JeEWqTWBProR/wMc0htwBX0kLfiF
 KZn5xtE13+djFuTd7JG7ExJpl2Lf02ozp83+DSeGiZpCv4kh4ICp1u3P87lRNyRIO9WX5cf30UQ
 T13VlOlwj85gIPxD+N1Roopq73u5RmBXlGjtnax2jaAmCTjKgobHv0mZxFXJfUmsnSS9GW0UTTI
 y9q/kXSY5CPGYHYc0ykhlFDDCLQHOditQpni2bZBNfnrUxQPWf9MbCYvc+E2OSJXK38k=
X-Received: by 2002:a05:6214:ca4:b0:8cc:dfa6:3333 with SMTP id
 6a1803df08f44-8f74c5a2e7fmr45512516d6.32.1783161482962; Sat, 04 Jul 2026
 03:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 4 Jul 2026 11:37:51 +0100
X-Gm-Features: AVVi8CdFKBj4I-M-1fgMVCTFApNvLiiZDLwxeNlM5Sv6XQ1AHXjme6bTQE7SQL4
Message-ID: <CALeDE9O-_Qj0-WE+ig2F=oRc6s9kLji+GYzZE5sfY96Rd+tUXw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] crypto: allwinner: enable sun8i-ce FIT crypto
To: James Hilliard <james.hilliard1@gmail.com>
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
X-Mailman-Approved-At: Sun, 05 Jul 2026 00:28:48 +0200
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

Hey James,

> This series enables Allwinner Crypto Engine backed FIT decryption and
> FIT signature/hash validation for secure-boot flows on H6/H616-class
> boards, covering both SPL and U-Boot proper.
>
> The purpose is to use CE-backed AES for encrypted FIT payloads on H6/H616
> and CE-backed ECDSA validation where the CE ECC engine is available,
> currently H616, instead of relying only on software crypto paths.

Out of interest do you have details of the speed up?

> At a high level this adds:
>
>   - SPL driver-model crypto plumbing for AES and hash providers.
>   - FIT decrypt-to-buffer support and SPL FIT cipher support, so SPL can
>     decrypt an encrypted U-Boot proper FIT without allocating another full
>     payload buffer.
>   - A shared sun8i-ce parent driver with AES and hash children for H6/H616.
>   - An H616 ECDSA child for CE-backed FIT signature validation, plus common
>     ECDSA curve-size and key-encoding fixes for secp224r1, prime256v1,
>     secp384r1 and secp521r1.
>
> The AES child supports software-provided AES-128/192/256 keys in ECB and
> CBC modes. The hash child supports the CE one-shot MD5/SHA1/SHA256/SHA384/
> SHA512 methods used by FIT verification. The ECDSA child exposes the H616
> CE ECC verifier through UCLASS_ECDSA.

This is me purely thinking out loud. I did some very basic testing on
a Allwinner A64 device of the HW crypto engine and the arm native
crypto extensions and while there was some difference I wonder whether
it makes more sense to looks at implementing the later, upstream Linux
seems to be going more in that route rather than device specific
engines as the performance is compatible and it's more widely deployed
and hence we'd have one code path that can benefit the majority of
devices rather that a bunch of specific drivers that need maintenance.
Had you considered that option?

> Tested flows include:
>
>   - SPL loading an encrypted and signed U-Boot proper FIT with CE-backed
>     AES decryption, hash verification and ECDSA signature verification.
>   - U-Boot proper loading an encrypted and signed FIT with CE-backed AES
>     decryption, hash verification and ECDSA signature verification.
>   - U-Boot proper AES command paths using the DM AES provider.
>   - CE ECDSA verification with secp224r1, prime256v1, secp384r1 and
>     secp521r1 FIT signatures.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>   - Add a cover letter for the series  (suggested by Peter Robinson)
>   - Describe the purpose and supported devices  (suggested by Peter Robinson)
>   - Limit AES command patch to argv fix  (suggested by Simon Glass)
>   - Add Fixes tag for the AES command bug  (suggested by Simon Glass)
>   - Select SPL_CRYPTO from SPL_DM_AES  (suggested by Simon Glass)
>   - Add SPL_DM_HASH for SPL FIT verification through UCLASS_HASH
>   - Let AES providers choose the software-provided key slot
>   - Return -ENOSYS without an SPL decrypt provider  (suggested by Simon Glass)
>   - Explain FIT cipher validation  (suggested by Simon Glass)
>   - Explain host-tool decrypt handling  (suggested by Simon Glass)
>   - Explain phase-keyed lib/aes builds  (suggested by Simon Glass)
>   - Decrypt external SPL FIT payloads in place  (suggested by Simon Glass)
>   - Skip self-memmove after direct decrypt  (suggested by Simon Glass)
>   - Add Simon's Reviewed-by tag to the sunxi CE clock/reset patch
>   - Explain the RSA impact of fdt_add_bignum()  (suggested by Simon Glass)
>   - Document ECDSA public key byte-array widths  (suggested by Simon Glass)
>   - Document ecdsa_curve_size()  (suggested by Simon Glass)
>   - Keep fdt_add_bignum() errors in libfdt space  (suggested by Simon Glass)
>   - Explain the SPL_DM dependency for SPL_ECDSA_VERIFY
>   - Document the ECDSA input-buffer layout  (suggested by Simon Glass)
>   - Document ECC byte-sized task length  (suggested by Simon Glass)
>   - Make CE ECDSA curves individually selectable  (suggested by Simon Glass)
>   - Use neutral wording for the CE ECDSA buffer-layout comments
>   - Reject oversized bit-length hash tasks  (suggested by Simon Glass)
>   - Feed the watchdog while polling CE completion  (suggested by Simon Glass)
>   - Drop the post-operation schedule() call  (suggested by Simon Glass)
>   - Bounce only word-unaligned hash input
>
> To: Svyatoslav Ryhel <clamor95@gmail.com>
> To: Ion Agorria <ion@agorria.com>
> To: u-boot@lists.denx.de
> Cc: Chen-Yu Tsai <wens@kernel.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: James Hilliard <james.hilliard1@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Aristo Chen <aristo.chen@canonical.com>
> Cc: Anton Ivanov <anton@binarly.io>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
> Cc: Randolph Sapp <rs@ti.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Alexey Charkov <alchark@gmail.com>
> Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Francesco Valla <francesco@valla.it>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Richard Genoud <richard.genoud@bootlin.com>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> Cc: E Shattow <e@freeshell.de>
> Cc: Enric Balletbo i Serra <eballetbo@kernel.org>
> Cc: Lucas Dietrich <ld.adecy@gmail.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Raymond Mao <raymond.mao@riscstar.com>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Francois Berder <fberder@outlook.fr>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
>
> ---
> James Hilliard (10):
>       cmd: aes: fix DM operation handling
>       crypto: aes: allow DM AES in SPL
>       boot: image: add FIT decrypt-to-buffer helper
>       spl: fit: support encrypted payloads
>       clk: sunxi: add H6/H616 CE gates and reset
>       lib: ecdsa: support additional curve sizes
>       crypto: allwinner: add sun8i-ce AES driver
>       crypto: allwinner: add sun8i-ce ECDSA verifier
>       crypto: hash: allow DM hash in SPL
>       crypto: allwinner: add sun8i-ce hash driver
>
>  MAINTAINERS                                        |   1 +
>  boot/Kconfig                                       |   8 +
>  boot/image-cipher.c                                |  38 +-
>  boot/image-fit.c                                   |  97 +++--
>  cmd/aes.c                                          |   8 +-
>  common/spl/spl_fit.c                               |  68 +++-
>  doc/mkimage.1                                      |   3 +
>  doc/usage/fit/signature.rst                        |   9 +-
>  drivers/clk/sunxi/clk_h6.c                         |   5 +
>  drivers/clk/sunxi/clk_h616.c                       |   5 +
>  drivers/crypto/Kconfig                             |   2 +
>  drivers/crypto/Makefile                            |   1 +
>  drivers/crypto/aes/Kconfig                         |   8 +
>  drivers/crypto/aes/aes-sw.c                        |   6 +
>  drivers/crypto/aes/aes-uclass.c                    |  15 +
>  drivers/crypto/allwinner/Kconfig                   |   3 +
>  drivers/crypto/allwinner/Makefile                  |   3 +
>  drivers/crypto/allwinner/sun8i-ce/Kconfig          | 158 ++++++++
>  drivers/crypto/allwinner/sun8i-ce/Makefile         |   6 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c   | 413 ++++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  | 408 +++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 434 +++++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  | 298 ++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |  72 ++++
>  drivers/crypto/hash/Kconfig                        |  10 +
>  drivers/crypto/hash/Makefile                       |   2 +-
>  drivers/crypto/tegra/tegra_aes.c                   |   7 +
>  include/image.h                                    |  39 +-
>  include/u-boot/aes.h                               |  10 +
>  include/u-boot/ecdsa.h                             |  22 ++
>  include/u-boot/fdt-libcrypto.h                     |   6 +-
>  include/uboot_aes.h                                |  38 +-
>  lib/Makefile                                       |   2 +-
>  lib/aes/aes-decrypt.c                              | 108 ++++-
>  lib/ecdsa/Kconfig                                  |   2 +-
>  lib/ecdsa/ecdsa-libcrypto.c                        | 141 ++++---
>  lib/ecdsa/ecdsa-verify.c                           |  39 +-
>  lib/fdt-libcrypto.c                                |  60 +--
>  tools/image-sig-host.c                             |   7 +
>  39 files changed, 2363 insertions(+), 199 deletions(-)
> ---
> base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
> change-id: 20260702-submit-ce-series-v2-4a77b170c68c
>
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>
>
