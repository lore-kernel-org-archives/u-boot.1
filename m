Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7CDC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 04:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DDE84105;
	Mon, 20 Jul 2026 06:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eSgBFSSm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E9FF83FF5; Mon, 20 Jul 2026 06:14:11 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DEF80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7eb4d532e65so3644895a34.0
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 21:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784520847; x=1785125647; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sJEVKBtqNQD+zqwWmpk2KgCO8YYX+6fhe6R9F5kCPNg=;
 b=eSgBFSSmMroRohC8uz0U+HKgnU8eo8z/3fjPZ/OX32N5KEFPEe+D2rWuyY1460FP2l
 R/WkeP1c5XxphbnDwBHLdss0V1/R/5MEHR8h2f1cMuyuKUyoTx8tg9zyByHXc6J3MrIx
 drRMJKL++lDE7q/N5Vy1nqL6yQYGsQjUxHxY5gMiDXAjT3efAYR5csbHfmRkWlgf6cGV
 VVVGR2eVbXATl3IWHt7wMJmDWx5l+L9fvp5d2WUSfc4Wa5g9FQvki0m4EHE+zwHHrj1z
 BLz2XbO7HcZG1b1u3HScX9IWn6SU+r2CjlkLyTI6zfUxMg2QiM1D8cBc7Lf1Nbeay9Ve
 OR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784520847; x=1785125647;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sJEVKBtqNQD+zqwWmpk2KgCO8YYX+6fhe6R9F5kCPNg=;
 b=h/LtVbTZZgGCxMvTvribJ06JasYryVgSKq6GU8UbciUM1TNSKjm8neXzrnIS0d7QtW
 sFjEUWdMagTSj0tsY7E/w6L6h4jvUHlhafWdZfg8PnuZhfSACDy3v+9eZMBv4EB0Zv0o
 uYN4YcOIyAk+vVw/bqTu22K7wt3GBOkdPTTZSGI+YMVCWSCxat0DVELP4bXKWlP85ECX
 uaNI5G53o4I4G4DvijS28/UkoUiBMvlnuB0accxpkkBxX8sX/350J3jO/sbF02usHsn7
 7/YLjJSUtAWbm/ufLOZjXDLZzONmAT74YPcO0FfITYSUgL+Qf0kwwp1L55gCKnsbyNrw
 9nHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtDgkKjphajZdYJ7HQ/O0Na5AK9oQcTk+39brWQXYEb/JlS4qELpUgKhIwxLzYlvoqUdOsIEM=@lists.denx.de
X-Gm-Message-State: AOJu0YzuWeGnR0ULnfUvCYO97lpL+U0m2IDmWlxcFTx4hpZV6cIaGBjc
 bkgbad0epJnOwaqcmyLfothFkg2xL6z0l8C1+Ux1n9W/U4ouy4hIQI/o
X-Gm-Gg: AfdE7ckPQ48j6MK9EjkfsLClQ6Q1ggcEdlhas3mZVoPPpzPM7PTWwmxUtK0h9pCJkRF
 JvIyTsd5AZ4oNjMzwqKZk74ZmkJy5AqhNIoWaKjDf+XQ3cNKLFKW54VHJAMvTfMSl5F7aA0hEtB
 7tGzDnoXZI0anMcsc+eHiuD3M2TgAI29g9JNI+9lVQBAZo26hj+DXbVZHRzcWZLz+7bi7RBQO+/
 AL2EvtmLm3zn1HA6fZrzMxjyhsA+jUAgDrdHev91g8x1fZEZvS7IxP/vY/sYxdZR3QONKSXPuP+
 woHwtDFgfO5b7kc0G+wvtjFhtSFTJSfgJQYWFWhDSOuxUwo9orMZqrS6OzQZHz5S6MhbA/ikeyn
 B6iY8tssoXyxXDPk3XgQ63F2fYCimgxGpJwSDHcFcQQvPsgNNJS4+cS/WQhuSvT6Nv/p425kYPi
 b8YqqmrrSKuZhP8sQ7CUeUU3Jf+ddw56AwLFp51fyQ3iLGeSridsnBgQ5/y7YbWny7T6TXcEJTb
 4DmiqlPBTn68a6TMgIZyzsj9bvobNf077ZG50JHLisugetDGVvFrg==
X-Received: by 2002:a05:6820:2218:b0:6a3:8f0:4554 with SMTP id
 006d021491bc7-6a5366ae92fmr6177216eaf.15.1784520846791; 
 Sun, 19 Jul 2026 21:14:06 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7edaf94a737sm7159191a34.15.2026.07.19.21.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 21:14:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v5 00/14] crypto: allwinner: enable sun8i-ce FIT crypto
Date: Sun, 19 Jul 2026 22:13:44 -0600
Message-Id: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33O3w6CIBgF8FdxXEdDFKGueo/WBX8+lZbawFjN+
 e6B3rjl2rg523d+hwl5cBY8OmcTchCst0MfAztkSLeybwBbEzOihFaEE4r9S3V2xBrw2sSB4lJ
 yrnJOdCU0is2ng9q+F/V6W3Os3UGPiUoXrfXj4D7LbKDp7v9CfATXtZFMgWFC1pemk/Zx1EOH0
 kIotsZp3yiiwUjOjRT6pODHKDdGXuwb5fIPDkZzwpSQW2Oe5y+8EUCdUAEAAA==
X-Change-ID: 20260702-submit-ce-series-v2-4a77b170c68c
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Daniel Golle <daniel@makrotopia.org>, Francois Berder <fberder@outlook.fr>, 
 Peng Fan <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Randolph Sapp <rs@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Stuebner <heiko@sntech.de>, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 20 Jul 2026 06:33:25 +0200
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

This series enables Allwinner Crypto Engine backed FIT decryption and FIT
signature/hash validation for secure-boot flows on H6/H616-class boards,
covering both SPL and U-Boot proper.

The purpose is to use CE-backed AES, hash and ECDSA operations on H6/H616
instead of relying only on software crypto paths. Word-aligned ECB and CBC
decryption requests of at least 256 KiB use both the AES and RAES engines
in SPL and U-Boot proper. The AES child uses the same fixed-memory
scheduler for one or two engines. Each engine has two bounded descriptor
banks, so software can refill a retired bank while its peer remains in
flight. One fixed transfer object owns all scheduler state, and the parent
polls and retires each completion snapshot as one operation.

On the H616 test board with the CE at 300 MHz, target-timed and fully
compared 64 MiB AES-256 decrypts reached 561.4 to 566.4 MiB/s for ECB
and CBC with aligned and word-offset buffers. SHA-256 over a 64 MiB
word-offset buffer reached 190.4 MiB/s. P-256 verification took 0.015 to
0.016 seconds.

At a high level this adds:

  - SPL driver-model crypto plumbing for AES and hash providers.
  - FIT decrypt-to-buffer support and SPL FIT cipher support, so SPL can
    decrypt an encrypted U-Boot proper FIT without allocating another full
    payload buffer.
  - A shared sun8i-ce parent driver with one exclusive task-session
    lifecycle, a cacheline-safe DMA mapping API, and one completion
    poll/retire path, plus AES, hash and ECDSA children for H6/H616.
  - Parallel AES/RAES processing for word-aligned ECB and CBC decryption
    requests of at least 256 KiB, using two fixed banks of ten task
    descriptors per engine and requesting completion only from each chain
    tail.
  - An H6/H616 ECDSA child for CE-backed FIT signature validation, plus
    common ECDSA curve-size and key-encoding fixes for secp224r1,
    prime256v1, secp384r1 and secp521r1.
  - Driver-model AES and hash provider dispatch with software fallback for
    unsupported operations and hard-error propagation.

The AES child supports software-provided AES-128/192/256 keys in ECB and
CBC modes, including exact in-place operation. Word-aligned payload
middles use direct DMA regardless of cacheline alignment, while fixed
per-bank edge buffers isolate partial cachelines. Byte-unaligned payloads
use a fixed 64 KiB repack buffer. The hash child supports the CE one-shot
MD5/SHA1/SHA256/SHA384/SHA512 methods used by FIT verification and uses a
fixed 128 KiB repack buffer when needed. No allocation scales with payload
size. The ECDSA child exposes the H6/H616 CE ECC verifier through
UCLASS_ECDSA.

Tested flows include:

  - SPL loading an encrypted and signed U-Boot proper FIT with CE-backed
    AES decryption, hash verification and ECDSA verification.
  - U-Boot proper loading an encrypted and signed FIT with CE-backed AES
    decryption, hash verification and ECDSA signature verification.
  - U-Boot proper AES command paths using the DM AES provider.
  - Target-timed 64 MiB AES-256-ECB encrypt and decrypt at aligned and
    word-offset addresses with full-buffer and edge-sentinel comparisons.
  - Target-timed 64 MiB AES-256-CBC decrypt out of place and in place at
    aligned and word-offset addresses, with repeated full-buffer
    comparisons.
  - Target-timed 8 MiB AES-128/192/256 ECB and CBC operations with
    full-buffer comparisons.
  - AES-256 boundary and tail cases at aligned, word-offset and byte-offset
    addresses, with cacheline sentinels, exact in-place operation and
    partial-overlap rejection.
  - Target-timed 64 MiB SHA-256 hashing at aligned, word-offset and
    byte-offset addresses with repeated digest comparisons.
  - Sandbox provider fallback, hard-error propagation, AES decrypt input
    validation and all supported ECDSA curve sizes.
  - U-Boot proper CE-backed FIT signature checks with secp224r1,
    prime256v1, secp384r1 and secp521r1.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v4 -> v5:
  - Rebase on U-Boot main
  - Replace independently claimed channel and engine sessions with one
    exclusive parent session that tracks per-channel in-flight state,
    deadlines, completion and abort cleanup
  - Add one cacheline-safe DMA mapping API for AES, hash and ECDSA, with
    descriptor-address validation and complete-cacheline output ownership
  - Replace the separate one-shot, bounce and dual-CBC AES paths with one
    fixed-memory one/two-lane scheduler using two ten-task banks per lane
  - Use AES and RAES in parallel for word-aligned ECB and CBC decryption
    requests of at least 256 KiB, with fair refill from a shared cursor
  - Direct-map word-aligned cacheline-offset AES buffers using private
    per-bank edge cachelines, and use a fixed 64 KiB repack only for
    byte-unaligned buffers
  - Replace the payload-sized word-unaligned hash bounce with one
    continuation stream using 64 MiB direct chunks or a fixed 128 KiB
    repack buffer
  - Use the normal DM clock and reset lifecycle in SPL and U-Boot proper,
    select the required SPL dependencies and retain the pre-RAM DT nodes
  - Harden ECDSA input validation and use a cacheline-rounded
    private result mapping
  - Validate secure boot, every AES key size, AES-256 alignment and overlap
    cases, bounded hash streaming and every supported ECDSA curve on H616
  - Link to v4: https://patch.msgid.link/20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com

Changes v3 -> v4:
  - Enable CE ECDSA in SPL and U-Boot proper on both H6 and H616.
  - Validate FIT cipher metadata before accessing key parameters.
  - Rebase on U-Boot master.
  - Try all registered AES and hash providers, preserving hard provider
    errors and using software fallback only when no provider supports the
    operation.
  - Treat -EINVAL as a hard provider error and reserve fallback for
    explicitly unsupported operations.
  - Require SPL_OF_CONTROL for SPL FIT decryption and fix disabled AES
    stubs.
  - Correct AES-192/256 handling in the software DM provider and add
    provider, decrypt-input and in-place-decrypt sandbox tests.
  - Map SPL FIT destinations after post-processing determines the final
    size and size decompression mappings for the maximum output.
  - Exercise all supported ECDSA curve sizes in the host FIT signing test.
  - Fold per-channel task sessions and engine ownership into the CE parent.
  - Trim redundant CE scheduler state and checks, and derive each NIST
    curve's a = p - 3 parameter instead of storing duplicate constants.
  - Run CBC decrypts of at least 256 KiB across AES and RAES in SPL and
    U-Boot proper with double-buffered ten-descriptor chains and tail-only
    completion.
  - Support exact in-place and aligned-offset dual-engine CBC decrypt.
  - Submit ECDSA and hash work on their dedicated completion channels.
  - Add target-timed 64 MiB AES-256-CBC and SHA-256 hardware results.
  - Link to v3: https://patch.msgid.link/20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com

Changes v2 -> v3:
  - Rebase on U-Boot master.
  - Add review tags from Svyatoslav Ryhel and Simon Glass.
  - Simplify the AES decrypt helper guard and validation flow.
  - Document the AES provider in-place CBC decrypt contract.
  - Tighten SPL encrypted-FIT buffer handling and error reporting.
  - Clean up the SPL DM hash fallback and Kconfig help text.
  - Link to v2: https://patch.msgid.link/20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com

---
James Hilliard (14):
      cmd: aes: fix DM operation handling
      crypto: hash: use DM providers from hash command
      crypto: aes: allow DM AES in SPL
      crypto: hash: allow DM hash in SPL
      boot: image: try all DM hash providers
      crypto: aes: fix software key-size handling
      crypto: aes: add software-key provider dispatch
      boot: image: add FIT decrypt-to-buffer helper
      spl: fit: support encrypted payloads
      clk: sunxi: add H6/H616 CE gates and reset
      lib: ecdsa: support additional curve sizes
      crypto: allwinner: add sun8i-ce AES driver
      crypto: allwinner: add sun8i-ce ECDSA verifier
      crypto: allwinner: add sun8i-ce hash driver

 MAINTAINERS                                        |   1 +
 arch/arm/dts/sunxi-u-boot.dtsi                     |  15 +
 boot/Kconfig                                       |   9 +
 boot/image-cipher.c                                |  45 +-
 boot/image-fit.c                                   |  83 ++-
 cmd/aes.c                                          |   8 +-
 common/hash.c                                      |  21 +
 common/spl/spl_fit.c                               |  89 ++-
 doc/mkimage.1                                      |   3 +
 doc/usage/fit/signature.rst                        |   9 +-
 drivers/clk/sunxi/clk_h6.c                         |   5 +
 drivers/clk/sunxi/clk_h616.c                       |   5 +
 drivers/crypto/Kconfig                             |   2 +
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/aes/Kconfig                         |   8 +
 drivers/crypto/aes/aes-sw.c                        |  49 +-
 drivers/crypto/aes/aes-uclass.c                    |  73 ++
 drivers/crypto/allwinner/Kconfig                   |   3 +
 drivers/crypto/allwinner/Makefile                  |   3 +
 drivers/crypto/allwinner/sun8i-ce/Kconfig          | 161 ++++
 drivers/crypto/allwinner/sun8i-ce/Makefile         |   6 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c   | 809 +++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  | 791 ++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 382 ++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  | 343 +++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       | 128 ++++
 drivers/crypto/aspeed/aspeed_hace.c                |   2 +-
 drivers/crypto/aspeed/cptra_sha.c                  |   2 +-
 drivers/crypto/hash/Kconfig                        |  13 +
 drivers/crypto/hash/Makefile                       |   2 +-
 drivers/crypto/hash/hash-uclass.c                  |  39 +-
 drivers/crypto/tegra/tegra_aes.c                   |   7 +
 include/image.h                                    |  39 +-
 include/u-boot/aes.h                               |  27 +-
 include/u-boot/ecdsa.h                             |  22 +
 include/u-boot/fdt-libcrypto.h                     |   6 +-
 include/u-boot/hash.h                              |  24 +-
 include/uboot_aes.h                                |  86 ++-
 lib/Makefile                                       |   2 +-
 lib/aes/aes-decrypt.c                              |  91 ++-
 lib/ecdsa/Kconfig                                  |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c                        | 141 ++--
 lib/ecdsa/ecdsa-verify.c                           |  39 +-
 lib/fdt-libcrypto.c                                |  60 +-
 test/dm/Makefile                                   |   1 +
 test/dm/aes.c                                      | 256 +++++++
 test/dm/hash.c                                     | 143 ++++
 test/lib/Makefile                                  |   3 +
 test/lib/test_aes_decrypt.c                        |  89 +++
 test/py/tests/test_fit_ecdsa.py                    |  18 +-
 tools/image-sig-host.c                             |   7 +
 51 files changed, 3928 insertions(+), 245 deletions(-)
---
base-commit: fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1
change-id: 20260702-submit-ce-series-v2-4a77b170c68c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

