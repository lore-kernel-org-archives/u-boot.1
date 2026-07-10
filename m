Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76B2C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C15284B67;
	Fri, 10 Jul 2026 14:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="FG6jJ9gZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5A4984659; Fri, 10 Jul 2026 12:05:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B6C808341A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F5F61D15;
 Fri, 10 Jul 2026 03:05:18 -0700 (PDT)
Received: from [10.41.150.148] (e142021.arm.com [10.41.150.148])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1CD53F66F;
 Fri, 10 Jul 2026 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783677922; bh=Fvd8eq951k/8NeEDLSVePURxeCJ00fS0Ru7St2QwTTU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FG6jJ9gZ4kAdeepA2MxkQgmpeGaW+6YcVOLhRZSSERQ9Ub5ySG8pG2vF6G+BZlhnI
 /VV5edKK0lbJ2ulgLAlC2rBWVsKSg3DUnvtwUIPbKMM+Qxr5QqoRDv7AHq0iKC/OqF
 78ADc9ZT7X4/lfqeplmUgAnU6uoUE1b7wuwxNugw=
Message-ID: <eefb2d2b-1f2e-451e-a20a-093964e9e138@arm.com>
Date: Fri, 10 Jul 2026 12:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] crypto: allwinner: enable sun8i-ce FIT crypto
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Daniel Golle <daniel@makrotopia.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Randolph Sapp <rs@ti.com>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 Michael Walle <mwalle@kernel.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukasz Majewski <lukma@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, E Shattow <e@freeshell.de>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Thierry Reding
 <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>,
 Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier
 <jerome.forissier@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/10/26 00:46, James Hilliard wrote:
> This series enables Allwinner Crypto Engine backed FIT decryption and
> FIT signature/hash validation for secure-boot flows on H6/H616-class
> boards, covering both SPL and U-Boot proper.
> 
> The purpose is to use CE-backed AES for encrypted FIT payloads on H6/H616
> and CE-backed ECDSA validation where the CE ECC engine is available,
> currently H616, instead of relying only on software crypto paths.

May I ask: why? In general those proprietary vendor crypto offload 
engines are somewhat frowned upon, and especially in the Allwinner case 
I am not even sure if someone has tried to validate the hardware.
So what is wrong with using a reviewable (and reviewed) and tested 
software implementation? Do you have data that shows any advantage here? 
Just from a high level point of view: the CE uses uncached DMA 
operations, and runs at 24 MHz, if I see this correctly. I am pretty 
sure the AES instructions in the Cortex-A53 beat this easily, I guess 
even a NEON-optimised pure software implementation would be faster.

So what I see here is just a lot of code added, but with little (read: 
no) improvement.
In the BROM the rationale is a bit different, so I see why it uses the 
CE there, but IIRC there is even a chicken bit in the fuses to not use 
the CE, so they might even have a software fallback?

Thoughts?

Cheers,
Andre


> At a high level this adds:
> 
>    - SPL driver-model crypto plumbing for AES and hash providers.
>    - FIT decrypt-to-buffer support and SPL FIT cipher support, so SPL can
>      decrypt an encrypted U-Boot proper FIT without allocating another full
>      payload buffer.
>    - A shared sun8i-ce parent driver with AES and hash children for H6/H616.
>    - An H616 ECDSA child for CE-backed FIT signature validation, plus common
>      ECDSA curve-size and key-encoding fixes for secp224r1, prime256v1,
>      secp384r1 and secp521r1.
> 
> The AES child supports software-provided AES-128/192/256 keys in ECB and
> CBC modes. The hash child supports the CE one-shot MD5/SHA1/SHA256/SHA384/
> SHA512 methods used by FIT verification. The ECDSA child exposes the H616
> CE ECC verifier through UCLASS_ECDSA.
> 
> Tested flows include:
> 
>    - SPL loading an encrypted and signed U-Boot proper FIT with CE-backed
>      AES decryption, hash verification and ECDSA signature verification.
>    - U-Boot proper loading an encrypted and signed FIT with CE-backed AES
>      decryption, hash verification and ECDSA signature verification.
>    - U-Boot proper AES command paths using the DM AES provider.
>    - CE ECDSA verification with secp224r1, prime256v1, secp384r1 and
>      secp521r1 FIT signatures.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
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
> Changes in v3:
> - Rebase on U-Boot master.
> - Add review tags from Svyatoslav Ryhel and Simon Glass.
> - Simplify the AES decrypt helper guard and validation flow.
> - Document the AES provider in-place CBC decrypt contract.
> - Tighten SPL encrypted-FIT buffer handling and error reporting.
> - Clean up the SPL DM hash fallback and Kconfig help text.
> - Link to v2: https://patch.msgid.link/20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com
> 
> To: Svyatoslav Ryhel <clamor95@gmail.com>
> To: Ion Agorria <ion@agorria.com>
> To: u-boot@lists.denx.de
> Cc: Tom Rini <trini@konsulko.com>
> Cc: James Hilliard <james.hilliard1@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
> Cc: Aristo Chen <aristo.chen@canonical.com>
> Cc: Anton Ivanov <anton@binarly.io>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: Francois Berder <fberder@outlook.fr>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Randolph Sapp <rs@ti.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
> Cc: Alexey Charkov <alchark@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Francesco Valla <francesco@valla.it>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Richard Genoud <richard.genoud@bootlin.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> Cc: E Shattow <e@freeshell.de>
> Cc: Enric Balletbo i Serra <eballetbo@kernel.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Lucas Dietrich <ld.adecy@gmail.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
> Cc: Raymond Mao <raymond.mao@riscstar.com>
> 
> ---
> James Hilliard (10):
>        cmd: aes: fix DM operation handling
>        crypto: aes: allow DM AES in SPL
>        boot: image: add FIT decrypt-to-buffer helper
>        spl: fit: support encrypted payloads
>        clk: sunxi: add H6/H616 CE gates and reset
>        lib: ecdsa: support additional curve sizes
>        crypto: allwinner: add sun8i-ce AES driver
>        crypto: allwinner: add sun8i-ce ECDSA verifier
>        crypto: hash: allow DM hash in SPL
>        crypto: allwinner: add sun8i-ce hash driver
> 
>   MAINTAINERS                                        |   1 +
>   boot/Kconfig                                       |   8 +
>   boot/image-cipher.c                                |  38 +-
>   boot/image-fit.c                                   |  85 ++--
>   cmd/aes.c                                          |   8 +-
>   common/spl/spl_fit.c                               |  75 +++-
>   doc/mkimage.1                                      |   3 +
>   doc/usage/fit/signature.rst                        |   9 +-
>   drivers/clk/sunxi/clk_h6.c                         |   5 +
>   drivers/clk/sunxi/clk_h616.c                       |   5 +
>   drivers/crypto/Kconfig                             |   2 +
>   drivers/crypto/Makefile                            |   1 +
>   drivers/crypto/aes/Kconfig                         |   8 +
>   drivers/crypto/aes/aes-sw.c                        |   6 +
>   drivers/crypto/aes/aes-uclass.c                    |  15 +
>   drivers/crypto/allwinner/Kconfig                   |   3 +
>   drivers/crypto/allwinner/Makefile                  |   3 +
>   drivers/crypto/allwinner/sun8i-ce/Kconfig          | 158 ++++++++
>   drivers/crypto/allwinner/sun8i-ce/Makefile         |   6 +
>   drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c   | 413 ++++++++++++++++++++
>   drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  | 408 +++++++++++++++++++
>   drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 434 +++++++++++++++++++++
>   drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  | 298 ++++++++++++++
>   drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |  72 ++++
>   drivers/crypto/hash/Kconfig                        |  13 +
>   drivers/crypto/hash/Makefile                       |   2 +-
>   drivers/crypto/tegra/tegra_aes.c                   |   7 +
>   include/image.h                                    |  39 +-
>   include/u-boot/aes.h                               |  10 +
>   include/u-boot/ecdsa.h                             |  22 ++
>   include/u-boot/fdt-libcrypto.h                     |   6 +-
>   include/uboot_aes.h                                |  40 +-
>   lib/Makefile                                       |   2 +-
>   lib/aes/aes-decrypt.c                              | 104 ++++-
>   lib/ecdsa/Kconfig                                  |   2 +-
>   lib/ecdsa/ecdsa-libcrypto.c                        | 141 ++++---
>   lib/ecdsa/ecdsa-verify.c                           |  39 +-
>   lib/fdt-libcrypto.c                                |  60 +--
>   tools/image-sig-host.c                             |   7 +
>   39 files changed, 2364 insertions(+), 194 deletions(-)
> ---
> base-commit: 913fedc816570c07bfc7f9c4046dc2a3a55e4099
> change-id: 20260702-submit-ce-series-v2-4a77b170c68c
> 
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>
> 

