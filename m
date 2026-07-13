Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6340C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E3CA84B2B;
	Mon, 13 Jul 2026 15:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sGBwUnci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0DBE84A4C; Mon, 13 Jul 2026 08:43:37 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443F184A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a31b9a492aso1839527eaf.1
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925014; x=1784529814; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=goh/hB4GZGRnjSCnzWJa5R3TgOjLyQgSqoyllG2qoqU=;
 b=sGBwUncijBCBLtSVwGG5O/GXrVwy0iZ86RJjbZspQZ9MzXI0O1O3wHwMDIf4yRyEyf
 Mud7Ig3xliz5SPOtOQ/PTi2yRz391SWkCYabncmMyAZYY80JebChftsbVoeGgIIZ2Jr6
 edEZynjTTTIs8Mz3RE5cmEZwJYCLf7bflqHBBA4zLjyNrjp9VA0p3wV4luOE+edZ6fdb
 feGJqq9VZ+GkPnIhdFqj9d+7E+TbMfc4yXEq1T8vkm4H0bjEt3RASZnYEdcwOKrrKqlA
 ilADPuy78SCCJ6Jkf55zk6yB4gYFHgd+bILdbQg1djrBfqt+UdMZTCXLThLJjracX2nP
 HGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925014; x=1784529814;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=goh/hB4GZGRnjSCnzWJa5R3TgOjLyQgSqoyllG2qoqU=;
 b=gfBgFjPAhIXwF0S+Og9urggbBecZtymPSYOTil1EhcTIy9P+B7E9gpRVIVZr2UBoSH
 TcWTT3wypU8+wOjpEzcBriiwSfKXC19ynh0z+oGG2WE93+3XttpJc3x7avmZuDYcUpdt
 kSlvoHy5dMMB052EXiejMEFaZ82zTfKecFr6lQVDJAohCIR7Q8C0aVjsEyckZD79XPDy
 y62H7MDK2Z3HRgYqRy6hHAbBTY52kk5GTQI1WRRFXJmWJipLhW8HxiorY3mOB4vc0hDm
 cSinSreFcoj/aVB498x1Ylpa4FWayDRASGKyYZavL/oKv67nW2O5Vy8OYJHP6gl0V3v3
 9d8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+v/cEvqM6yj9l+HBidW0JDCF+TwU5cMK99y6UakN74bNDdRf948taovncLXG+zbWryM65Ws4=@lists.denx.de
X-Gm-Message-State: AOJu0YzHROscaKIvqIHgCaVqF02PKDw94hGZAWomIWJTN/n3+btThdrb
 1CAYbSICMMhkU22sjA0I8eA2HhO4El/nWVOTOkIhcd25Y2v2WUDTU8Co
X-Gm-Gg: AfdE7cmCIAEz0Hfd0FG3mVDxrZMIGJ2LfUbEjI/aNUtCfGcr6b35/w63aRXxak7b8It
 45+FKx6dqWsOG/jpcTjDsFMxmgmydnj66VT5TrAEeqffmX6GnhpEgpiATkpY6LwFZZUadT4PRoa
 p8LLT6AOGTAeXUvyVtDsauJ3LtG2q9ON5/mukzfnxEJna4lvfc6wGojeyX4bplqnFDxcAhszqDr
 iNqV1zIiY1o7kxUHaRlkOhh+wdviNCczRXeVDJZlw2QXkNxCqAv9SUkHVMiSb/TD10xpzuuBE6Q
 j7kXtvPwaftBw8D/yjfBwszqhKEISuaa4yJzO4ynSHv9+GgQiBFr7gj8+r4M6Y9VYhwztE8CKLe
 05/XBpcVWWhGQMkpIfdIP6lLm8NpwGtZVWFxZK+taRev6MSkHx0HrOedjlY3tELSyqLVLIWfs1C
 PIhbGga6mD88mW/K/bAXSKG9GPoN1PsWAGecpl3EXHuzr9jwrQe2Oc/PeCO0ylHYQZv+JAfCcSF
 7D5bC1bSQHbNUEY7pDMgmBTnwKNiHD75BxI65DN6qplZYz4kbIcRj64xPxORqeE
X-Received: by 2002:a4a:ee17:0:b0:6a3:10fc:766d with SMTP id
 006d021491bc7-6a39a6cee76mr4025305eaf.47.1783925013804; 
 Sun, 12 Jul 2026 23:43:33 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v4 00/14] crypto: allwinner: enable sun8i-ce FIT crypto
Date: Mon, 13 Jul 2026 00:42:57 -0600
Message-Id: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NywrCMBREf6VkbSSmj7Su/A9xkcdNe8W2ktSgl
 P67SbtREGE2A3POzMSDQ/DkmM3EQUCP4xBLscuI7uTQAkUTO+GMV0wwTv1D9ThRDXQjaeC0kEK
 og2C6qjWJ5N2BxedqPV+2HrEr6Cmp0qJDP43utd4Gnnb/H2IYtdbIUoEpa2lPbS/xttdjT9JDy
 D8dzW9HHh0lOwgja90o+HIsy/IGJ1KIXAwBAAA=
X-Change-ID: 20260702-submit-ce-series-v2-4a77b170c68c
To: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>
Cc: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>, 
 Jonas Karlman <jonas@kwiboo.se>, 
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
 Heiko Stuebner <heiko@sntech.de>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Mon, 13 Jul 2026 15:20:59 +0200
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
instead of relying only on software crypto paths. CBC decrypts of at
least 256 KiB use both the AES and RAES engines in SPL and U-Boot proper.
Descriptor chains let software prepare and retire one chain while hardware
processes another.

On the H616 test board with the CE at 300 MHz, target-timed and fully
compared 64 MiB AES-256-CBC decrypts completed in 0.114 seconds both out of
place and in place, about 561 MiB/s. Five target-timed 64 MiB SHA-256 runs
completed in 0.333 seconds, about 192 MiB/s.

At a high level this adds:

  - SPL driver-model crypto plumbing for AES and hash providers.
  - FIT decrypt-to-buffer support and SPL FIT cipher support, so SPL can
    decrypt an encrypted U-Boot proper FIT without allocating another full
    payload buffer.
  - A shared sun8i-ce parent driver with per-channel task sessions and AES
    and hash children for H6/H616.
  - Parallel AES/RAES CBC decrypt in SPL and U-Boot proper for operations
    of at least 256 KiB, using two banks of ten task descriptors per engine
    and requesting completion only from each chain tail.
  - An H6/H616 ECDSA child for CE-backed FIT signature validation, plus common
    ECDSA curve-size and key-encoding fixes for secp224r1, prime256v1,
    secp384r1 and secp521r1.
  - Driver-model AES and hash provider dispatch with software fallback for
    unsupported operations and hard-error propagation.

The AES child supports software-provided AES-128/192/256 keys in ECB and
CBC modes, including exact in-place CBC decrypt. The hash child supports
the CE one-shot MD5/SHA1/SHA256/SHA384/SHA512 methods used by FIT
verification. The ECDSA child exposes the H6/H616 CE ECC verifier through
UCLASS_ECDSA.

Tested flows include:

  - SPL loading an encrypted and signed U-Boot proper FIT with CE-backed
    AES decryption, hash verification and ECDSA verification.
  - U-Boot proper loading an encrypted and signed FIT with CE-backed AES
    decryption, hash verification and ECDSA signature verification.
  - U-Boot proper AES command paths using the DM AES provider.
  - Target-timed 64 MiB AES-256-CBC decrypt both out of place and in place,
    with repeated full-buffer comparisons.
  - Target-timed 64 MiB SHA-256 hashing with repeated digest comparisons.
  - Sandbox provider fallback, hard-error propagation, AES decrypt input
    validation and all supported ECDSA curve sizes.
  - U-Boot proper CE-backed FIT signature checks with secp224r1,
    prime256v1, secp384r1 and secp521r1.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v4:
- Enable CE ECDSA in SPL and U-Boot proper on both H6 and H616.
- Validate FIT cipher metadata before accessing key parameters.
- Rebase on U-Boot master.
- Try all registered AES and hash providers, preserving hard provider errors
  and using software fallback only when no provider supports the operation.
- Treat -EINVAL as a hard provider error and reserve fallback for explicitly
  unsupported operations.
- Require SPL_OF_CONTROL for SPL FIT decryption and fix disabled AES stubs.
- Correct AES-192/256 handling in the software DM provider and add provider,
  decrypt-input and in-place-decrypt sandbox tests.
- Map SPL FIT destinations after post-processing determines the final size
  and size decompression mappings for the maximum output.
- Exercise all supported ECDSA curve sizes in the host FIT signing test.
- Fold per-channel task sessions and engine ownership into the CE parent.
- Trim redundant CE scheduler state and checks, and derive each NIST curve's
  a = p - 3 parameter instead of storing duplicate constants.
- Run CBC decrypts of at least 256 KiB across AES and RAES in SPL and
  U-Boot proper with double-buffered ten-descriptor chains and tail-only
  completion.
- Support exact in-place and aligned-offset dual-engine CBC decrypt.
- Submit ECDSA and hash work on their dedicated completion channels.
- Add target-timed 64 MiB AES-256-CBC and SHA-256 hardware results.
- Link to v3: https://patch.msgid.link/20260709-submit-ce-series-v2-v3-0-5017da8c9bef@gmail.com

Changes in v3:
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
 boot/Kconfig                                       |   9 +
 boot/image-cipher.c                                |  45 +-
 boot/image-fit.c                                   |  83 +-
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
 drivers/crypto/allwinner/sun8i-ce/Kconfig          | 159 ++++
 drivers/crypto/allwinner/sun8i-ce/Makefile         |   6 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c   | 864 +++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  | 736 ++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 362 +++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  | 238 ++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |  98 +++
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
 include/uboot_aes.h                                |  86 +-
 lib/Makefile                                       |   2 +-
 lib/aes/aes-decrypt.c                              |  91 ++-
 lib/ecdsa/Kconfig                                  |   2 +-
 lib/ecdsa/ecdsa-libcrypto.c                        | 141 ++--
 lib/ecdsa/ecdsa-verify.c                           |  39 +-
 lib/fdt-libcrypto.c                                |  60 +-
 test/dm/Makefile                                   |   1 +
 test/dm/aes.c                                      | 256 ++++++
 test/dm/hash.c                                     | 143 ++++
 test/lib/Makefile                                  |   3 +
 test/lib/test_aes_decrypt.c                        |  89 +++
 test/py/tests/test_fit_ecdsa.py                    |  18 +-
 tools/image-sig-host.c                             |   7 +
 50 files changed, 3756 insertions(+), 245 deletions(-)
---
base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
change-id: 20260702-submit-ce-series-v2-4a77b170c68c

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

