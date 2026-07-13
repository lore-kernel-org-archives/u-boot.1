Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97D1C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C163E84BB9;
	Mon, 13 Jul 2026 15:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cPLMMNVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C48584A52; Mon, 13 Jul 2026 08:44:04 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A75584A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 08:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a378f187bbso1377295eaf.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 23:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783925039; x=1784529839; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PReVplUpEvjjiSlb5q3BRWlbM6DWk1d7/fewO2yjsY0=;
 b=cPLMMNVtCizeJChPNXRmKeDP9vSen3J5e0D6zYAbh0GJvMIlu0OFMpIQHD7Afe6YD9
 frHPBm/9043k357njpshTYkhbg6prPioPdRDXYcL4pionOeFb2a69h2/40rdl/m8fM6I
 WBV76yKaipQsI2TjoUQ/wILgc5znt2JIfo31R8HR/fbznMfEFUxts+iWA3QWSxE2/zGG
 WpaHP9m5qD92umr3EHVer5lg8zHlq7I5BrTGPYchYJug8vjZw2lFMJoMrhaw2iUaOZ3U
 xcMiSZ6eF97d4CN2OBi3C9syZ2bUojM56JBrnwGswlxrLA6PGC7gIAOim6FscD1ShuUD
 tVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783925039; x=1784529839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PReVplUpEvjjiSlb5q3BRWlbM6DWk1d7/fewO2yjsY0=;
 b=N5+zOMdfdonzgLJFi/8BBrDPhdj6fmna9Mu7a20mZju9TeJnTagP77nnN/3x+lbewn
 qcdelEjAD3iohDBOLApTJguxXpmCVuN6E5cQ/X9gSXhTxdYmHjLkvBSRBLOy1vWj8job
 EAJOkiUCTdlyQD2f7Gz2tYn7WAqbDdryXwxyhPA+k/mqsHOaTYYGX/4xCyFn4lS2W1qr
 zzH3lLvJXgCtQG0pu2iotx1wtYszw+VzaKIAhMsBdhxJO5gsuevcURmO/rPmsEJ6b/dx
 91nDm0GLiuElDxCmCVKu8CFUN9DGDAfkp9ZK+A1Cf+49goDMzfiequ4HVoxdWDYTsWfa
 9TDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OGK2FRo4nUmFfBZMebR/XLRGOO+kOdU8v2HGRrj30tfAtYBFBLrxyCgCPF2qbXaj+Yau0tlw=@lists.denx.de
X-Gm-Message-State: AOJu0YyrixNt3w+h6M5jI/2G2gxNtZG4ef6nsCapcrL6Y/z/X8BB0VoW
 ZHEjU93iG06cphXGlgoGXhDQBGjstolEBzZoUk3SGISAKPL9lj0N1vD2
X-Gm-Gg: AfdE7ckrwGIUZPIWdB2ep+bD8pZ+PeEzHhj29Ss1TvFnBLC4M6jtLJysP4q4OpNs9AE
 Xpzt2T5pTC45OxlAaMEbeyEz4utyekdtfpAGVSfvDnGqmN4UtJh1LAFWpzsefqY7/FAzqnmiJCo
 TwBByBJZs2HdbInjUdSqL5sMnXR9wiuM/SVWQypV2em/1LPxiimu7Y8WjC9MkJj+jv7dk558fvL
 lotam8JDccpwcV0T8PlUDI0CVCSFyOtpDDArGp80fb9sDE7T3qyBk5DfGA//EnSEg2V0gF2quT0
 jMA+ch0bSsCW17qKitcpMnJr8X2m3GoyNUgFWqX2EZWYrwMP3VTDdiI/VphYiffyz90NzQw4qcd
 YXSvn5SZtCd1TuDtdOPoWmsR7N1iTg9gOe2N2ODdW4XOBaU25/TgLuK33Hov9auUZlidhn942tr
 1owEbsz5nUSAy6eixoQqCc2JL41XDEbXZ+gPkHmXvXcdmXgWhpCfPf9xTv5Cgo3Z3kd3FzT/PJH
 sUYjK6WmR3EuoejFMD+X5d9holgrMuZyMvPrceB1TF36djkMSQyCvAnWlHjVHBiznevrSC2EDI=
X-Received: by 2002:a05:6820:80c5:b0:6a1:524b:1f1 with SMTP id
 006d021491bc7-6a39a602aa8mr4370341eaf.4.1783925038762; 
 Sun, 12 Jul 2026 23:43:58 -0700 (PDT)
Received: from [127.0.1.1] (174-29-11-8.hlrn.qwest.net. [174.29.11.8])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm12538126fac.13.2026.07.12.23.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 23:43:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 13 Jul 2026 00:43:09 -0600
Subject: [PATCH v4 12/14] crypto: allwinner: add sun8i-ce AES driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-submit-ce-series-v2-v4-12-ff7edc705b8a@gmail.com>
References: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
In-Reply-To: <20260713-submit-ce-series-v2-v4-0-ff7edc705b8a@gmail.com>
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

Add an Allwinner sun8i Crypto Engine driver using the same directory and
driver naming style as the Linux sun8i-ce driver. The parent device owns
the shared CE registers, clocks and resets. It also provides task sessions
which claim completion channels and engines and centralize descriptor
submission, completion, DMA-idle synchronization, error handling and reset.
An AES child exposes the standard UCLASS_AES interface.

Support AES-128, AES-192 and AES-256 in ECB and CBC modes with
software-provided keys. Process direct DMA-capable buffers in 128 KiB
chunks and use cache-aligned bounce buffers for unaligned heads and tails.
CBC keeps the IV chain in software between chunks so each CE task can run
on a larger contiguous range without losing chaining state.

For CBC decrypt operations of at least 256 KiB, run the AES and RAES
engines in parallel in SPL and U-Boot proper. Each engine alternates
between two banks of ten task descriptors, with completion requested only
by each chain tail. Snapshot the CBC IV for each task before submission so
chains are independent and exact in-place decryption remains valid.
Restart a prepared bank before unmapping and refilling the completed one.
Keep the single-task path for encryption, requests below the threshold and
incompatible alignments. The two scheduler indices map directly to the
AES/RAES channels and engine ownership bits.

Model the H6 and H616 compatibles after the Linux sun8i-ce variant data.
Both variants use byte-sized cipher task lengths and provide the second
RAES engine; H616 additionally needs word-addressed descriptors. Program
the H616 module clock to 300 MHz from PLL_PERI0(2X). In SPL, enable the
shared H6-family CE clock, bus gate, reset and MBUS gate directly because
the full clock/reset uclasses are not always available there.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v3 -> v4:
  - Drop invariant variant fields and redundant chain mapping state
  - Add per-channel task sessions and engine ownership
  - Use AES and RAES in parallel for CBC decrypts of at least 256 KiB
    in SPL and U-Boot proper
  - Double-buffer ten-descriptor chains with tail-only completion
  - Support exact in-place decrypt and aligned-offset input buffers
  - Map scheduler indices directly to AES/RAES channels and engine bits
  - Drop redundant internal bounds checks and session initialization
  - Reuse the scheduled CE register-wait helper and return status separately
    from the processed block count

Changes v2 -> v3:
  - Run the H616 CE module clock at 300 MHz

Changes v1 -> v2:
  - Expose slot 0 as the software-provided AES key slot
---
 MAINTAINERS                                       |   1 +
 drivers/crypto/Kconfig                            |   2 +
 drivers/crypto/Makefile                           |   1 +
 drivers/crypto/allwinner/Kconfig                  |   3 +
 drivers/crypto/allwinner/Makefile                 |   3 +
 drivers/crypto/allwinner/sun8i-ce/Kconfig         |  39 +
 drivers/crypto/allwinner/sun8i-ce/Makefile        |   4 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c  | 864 ++++++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 712 ++++++++++++++++++
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      |  86 +++
 10 files changed, 1715 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e53cb0a485c..24dceaa9f1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -752,6 +752,7 @@ F:	arch/arm/include/asm/arch-sunxi/
 F:	arch/arm/mach-sunxi/
 F:	board/sunxi/
 F:	drivers/clk/sunxi/
+F:	drivers/crypto/allwinner/
 F:	drivers/phy/allwinner/
 F:	drivers/pinctrl/sunxi/
 F:	drivers/video/sunxi/
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0d58e3910fe..d15a59f87ee 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -6,6 +6,8 @@ source "drivers/crypto/aes/Kconfig"
 
 source "drivers/crypto/fsl/Kconfig"
 
+source "drivers/crypto/allwinner/Kconfig"
+
 source "drivers/crypto/aspeed/Kconfig"
 
 source "drivers/crypto/nuvoton/Kconfig"
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index e4a4482b7f3..cbbd5dc1dbe 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -8,6 +8,7 @@ obj-y += aes/
 obj-y += rsa_mod_exp/
 obj-y += fsl/
 obj-y += hash/
+obj-y += allwinner/
 obj-y += aspeed/
 obj-y += nuvoton/
 obj-y += tegra/
diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
new file mode 100644
index 00000000000..9765b089e25
--- /dev/null
+++ b/drivers/crypto/allwinner/Kconfig
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+source "drivers/crypto/allwinner/sun8i-ce/Kconfig"
diff --git a/drivers/crypto/allwinner/Makefile b/drivers/crypto/allwinner/Makefile
new file mode 100644
index 00000000000..2dcae98bac9
--- /dev/null
+++ b/drivers/crypto/allwinner/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += sun8i-ce/
diff --git a/drivers/crypto/allwinner/sun8i-ce/Kconfig b/drivers/crypto/allwinner/sun8i-ce/Kconfig
new file mode 100644
index 00000000000..f72cf3498fe
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/Kconfig
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+config SUNXI_CE
+	bool
+	depends on ARCH_SUNXI
+	depends on CLK && DM_RESET
+
+config SPL_SUNXI_CE
+	bool
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM
+	depends on SPL_OF_CONTROL
+	select SPL_CRYPTO
+
+config SUNXI_CE_AES
+	bool "Allwinner sunxi CE AES"
+	depends on ARCH_SUNXI
+	depends on DM_AES
+	depends on CLK && DM_RESET
+	select AES
+	select SUNXI_CE
+	help
+	  Select this option to enable AES encryption and decryption using
+	  the Crypto Engine found in Allwinner sunxi SoCs. The driver
+	  supports software-provided AES-128, AES-192 and AES-256 keys.
+
+config SPL_SUNXI_CE_AES
+	bool "Allwinner sunxi CE AES in SPL"
+	depends on ARCH_SUNXI
+	depends on MACH_SUN50I_H6 || MACH_SUN50I_H616
+	depends on SPL_DM_AES
+	depends on SPL_OF_CONTROL
+	select SPL_CRYPTO
+	select SPL_SUNXI_CE
+	help
+	  Select this option to enable AES decryption in SPL using the Crypto
+	  Engine found in Allwinner H6 and H616 compatible SoCs. This can be
+	  used to decrypt FIT images before loading U-Boot proper.
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
new file mode 100644
index 00000000000..2a8778065b1
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_$(PHASE_)SUNXI_CE) += sun8i-ce-core.o
+obj-$(CONFIG_$(PHASE_)SUNXI_CE_AES) += sun8i-ce-aes.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c
new file mode 100644
index 00000000000..754da32d2e3
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c
@@ -0,0 +1,864 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#define LOG_CATEGORY UCLASS_AES
+
+#include <dm.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <time.h>
+#include <uboot_aes.h>
+#include <asm/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_ENCRYPTION		0
+#define SUNXI_CE_DECRYPTION		BIT(8)
+
+#define SUNXI_CE_OP_ECB			0
+#define SUNXI_CE_OP_CBC			BIT(8)
+
+#define SUNXI_CE_AES_KEY_128BIT		0
+#define SUNXI_CE_AES_KEY_192BIT		1
+#define SUNXI_CE_AES_KEY_256BIT		2
+
+#define SUNXI_CE_AES_DIRECT_CHUNK_SIZE	(128 * 1024)
+#define SUNXI_CE_AES_DIRECT_CHUNK_BLOCKS \
+	(SUNXI_CE_AES_DIRECT_CHUNK_SIZE / AES_BLOCK_LENGTH)
+#define SUNXI_CE_AES_CHAIN_DEPTH		10
+#define SUNXI_CE_AES_ENGINE_COUNT	2
+#define SUNXI_CE_AES_BANK_COUNT		2
+#define SUNXI_CE_AES_DUAL_TASK_COUNT	\
+	(SUNXI_CE_AES_ENGINE_COUNT * SUNXI_CE_AES_BANK_COUNT * \
+	 SUNXI_CE_AES_CHAIN_DEPTH)
+#define SUNXI_CE_AES_DUAL_MIN_BLOCKS	\
+	(SUNXI_CE_AES_ENGINE_COUNT * \
+	 SUNXI_CE_AES_DIRECT_CHUNK_BLOCKS)
+#define SUNXI_CE_AES_CHAIN_TIMEOUT_US	3000000
+#define SUNXI_CE_AES_BOUNCE_CHUNK_SIZE	(64 * 1024)
+#define SUNXI_CE_AES_BOUNCE_CHUNK_BLOCKS \
+	(SUNXI_CE_AES_BOUNCE_CHUNK_SIZE / AES_BLOCK_LENGTH)
+
+struct sunxi_aes_priv {
+	u8 key[AES256_KEY_LENGTH];
+	u8 key_len;
+	u8 ce_key_size;
+};
+
+struct sunxi_aes_chain_bank {
+	u8 ivs[SUNXI_CE_AES_CHAIN_DEPTH][ARCH_DMA_MINALIGN]
+		__aligned(ARCH_DMA_MINALIGN);
+	dma_addr_t iv_dma;
+	dma_addr_t src_dma;
+	dma_addr_t dst_dma;
+	u32 len;
+	u32 count;
+};
+
+struct sunxi_aes_chain_scheduler {
+	struct sunxi_aes_chain_bank banks[SUNXI_CE_AES_ENGINE_COUNT]
+					 [SUNXI_CE_AES_BANK_COUNT];
+	int active_bank[SUNXI_CE_AES_ENGINE_COUNT];
+	struct sunxi_ce_priv *ce;
+	struct sunxi_ce_session *session;
+	struct sunxi_ce_task *tasks;
+	dma_addr_t key_dma;
+	u8 *iv;
+	u8 *src;
+	u8 *dst;
+	u32 remaining;
+	u32 comm_ctl;
+	u32 sym_ctl;
+	bool in_place;
+};
+
+static int sunxi_ce_key_size(u32 key_bits)
+{
+	switch (key_bits) {
+	case AES128_KEY_LENGTH * 8:
+		return SUNXI_CE_AES_KEY_128BIT;
+	case AES192_KEY_LENGTH * 8:
+		return SUNXI_CE_AES_KEY_192BIT;
+	case AES256_KEY_LENGTH * 8:
+		return SUNXI_CE_AES_KEY_256BIT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool sunxi_aes_ranges_overlap(const u8 *src, const u8 *dst, size_t len)
+{
+	uintptr_t src_start = (uintptr_t)src;
+	uintptr_t dst_start = (uintptr_t)dst;
+	uintptr_t src_end = src_start + len;
+	uintptr_t dst_end = dst_start + len;
+
+	return src_start < dst_end && dst_start < src_end;
+}
+
+static u32 sunxi_aes_direct_blocks(const u8 *src, const u8 *dst,
+				   u32 num_blocks)
+{
+	u32 len = min_t(u32, num_blocks * AES_BLOCK_LENGTH,
+			SUNXI_CE_AES_DIRECT_CHUNK_SIZE);
+
+	if (!IS_ALIGNED((uintptr_t)src, ARCH_DMA_MINALIGN) ||
+	    !IS_ALIGNED((uintptr_t)dst, ARCH_DMA_MINALIGN))
+		return 0;
+
+	return ALIGN_DOWN(len, ARCH_DMA_MINALIGN) / AES_BLOCK_LENGTH;
+}
+
+static u32 sunxi_aes_bounce_blocks(const u8 *dst, u32 num_blocks)
+{
+	uintptr_t dst_addr = (uintptr_t)dst;
+	u32 blocks = min_t(u32, num_blocks, SUNXI_CE_AES_BOUNCE_CHUNK_BLOCKS);
+	u32 head;
+
+	if (!IS_ALIGNED(dst_addr, AES_BLOCK_LENGTH))
+		return blocks;
+
+	head = ALIGN(dst_addr, ARCH_DMA_MINALIGN) - dst_addr;
+	if (head)
+		blocks = min_t(u32, blocks, head / AES_BLOCK_LENGTH);
+
+	return blocks;
+}
+
+static int sunxi_aes_dual_head_blocks(bool cbc, bool decrypt, const u8 *src,
+				      const u8 *dst, u32 num_blocks)
+{
+	uintptr_t src_addr = (uintptr_t)src;
+	uintptr_t dst_addr = (uintptr_t)dst;
+	u32 head_blocks;
+
+	if (!cbc || !decrypt ||
+	    !IS_ALIGNED(src_addr, AES_BLOCK_LENGTH) ||
+	    !IS_ALIGNED(dst_addr, AES_BLOCK_LENGTH) ||
+	    (src_addr & (ARCH_DMA_MINALIGN - 1)) !=
+	    (dst_addr & (ARCH_DMA_MINALIGN - 1)))
+		return -1;
+
+	head_blocks = (ALIGN(src_addr, ARCH_DMA_MINALIGN) - src_addr) /
+		      AES_BLOCK_LENGTH;
+	if (num_blocks < SUNXI_CE_AES_DUAL_MIN_BLOCKS ||
+	    head_blocks > num_blocks - SUNXI_CE_AES_DUAL_MIN_BLOCKS)
+		return -1;
+
+	return head_blocks;
+}
+
+static void sunxi_aes_fill_task(struct sunxi_ce_priv *ce,
+				struct sunxi_ce_task *task,
+				u32 channel,
+				dma_addr_t key, dma_addr_t iv,
+				dma_addr_t src, dma_addr_t dst,
+				u32 len, u32 comm_ctl, u32 sym_ctl)
+{
+	u32 task_len = len / sizeof(u32);
+
+	memset(task, 0, sizeof(*task));
+
+	task->t_id = channel;
+	task->t_common_ctl = comm_ctl;
+	task->t_sym_ctl = sym_ctl;
+	task->t_key = sunxi_ce_desc_dma_addr(ce, key);
+	if (iv)
+		task->t_iv = sunxi_ce_desc_dma_addr(ce, iv);
+	task->t_dlen = len;
+	task->t_src[0].addr = sunxi_ce_desc_dma_addr(ce, src);
+	task->t_src[0].len = task_len;
+	task->t_dst[0].addr = sunxi_ce_desc_dma_addr(ce, dst);
+	task->t_dst[0].len = task_len;
+}
+
+static void sunxi_aes_unmap_bank(struct sunxi_aes_chain_bank *bank,
+				 bool in_place)
+{
+	if (!bank->count)
+		return;
+
+	if (!in_place)
+		dma_unmap_single(bank->dst_dma, bank->len, DMA_FROM_DEVICE);
+	dma_unmap_single(bank->src_dma, bank->len,
+			 in_place ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE);
+	dma_unmap_single(bank->iv_dma, bank->count * ARCH_DMA_MINALIGN,
+			 DMA_TO_DEVICE);
+
+	bank->len = 0;
+	bank->count = 0;
+}
+
+static void sunxi_aes_unmap_chains(struct sunxi_aes_chain_scheduler *sched)
+{
+	u32 bank_index, engine_index;
+
+	for (engine_index = 0; engine_index < SUNXI_CE_AES_ENGINE_COUNT;
+	     engine_index++) {
+		for (bank_index = 0; bank_index < SUNXI_CE_AES_BANK_COUNT;
+		     bank_index++)
+			sunxi_aes_unmap_bank(&sched->banks[engine_index][bank_index],
+					     sched->in_place);
+	}
+}
+
+static struct sunxi_ce_task *
+sunxi_aes_bank_tasks(struct sunxi_aes_chain_scheduler *sched,
+		     u32 engine_index, u32 bank_index)
+{
+	u32 bank = engine_index * SUNXI_CE_AES_BANK_COUNT + bank_index;
+
+	return &sched->tasks[bank * SUNXI_CE_AES_CHAIN_DEPTH];
+}
+
+static int sunxi_aes_prepare_chain(struct sunxi_aes_chain_scheduler *sched,
+				   u32 engine_index, u32 bank_index,
+				   u32 max_blocks)
+{
+	struct sunxi_aes_chain_bank *bank;
+	struct sunxi_ce_task *tasks;
+	enum dma_data_direction src_dir = sched->in_place ? DMA_BIDIRECTIONAL :
+							      DMA_TO_DEVICE;
+	u8 *src = sched->src;
+	u8 *dst = sched->dst;
+	u32 blocks, blocks_left, offset = 0;
+	u32 iv_len;
+	u32 slot_index;
+	int ret;
+
+	bank = &sched->banks[engine_index][bank_index];
+	tasks = sunxi_aes_bank_tasks(sched, engine_index, bank_index);
+	if (!sched->remaining)
+		return 0;
+
+	blocks = min_t(u32, sched->remaining, max_blocks);
+	blocks = min_t(u32, blocks, SUNXI_CE_AES_CHAIN_DEPTH *
+		       SUNXI_CE_AES_DIRECT_CHUNK_BLOCKS);
+	blocks_left = blocks;
+	bank->len = blocks * AES_BLOCK_LENGTH;
+
+	for (slot_index = 0; blocks_left; slot_index++) {
+		u32 task_blocks = min_t(u32, blocks_left,
+					    SUNXI_CE_AES_DIRECT_CHUNK_BLOCKS);
+		u32 task_len = task_blocks * AES_BLOCK_LENGTH;
+
+		/* Snapshot dependencies before in-place DMA can overwrite them. */
+		memcpy(bank->ivs[slot_index], sched->iv, AES_BLOCK_LENGTH);
+		memcpy(sched->iv, src + offset + task_len - AES_BLOCK_LENGTH,
+		       AES_BLOCK_LENGTH);
+		blocks_left -= task_blocks;
+		offset += task_len;
+	}
+	bank->count = slot_index;
+	iv_len = bank->count * ARCH_DMA_MINALIGN;
+	bank->iv_dma = dma_map_single(bank->ivs, iv_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(NULL, bank->iv_dma)) {
+		ret = -EIO;
+		goto out_reset;
+	}
+
+	bank->src_dma = dma_map_single(src, bank->len, src_dir);
+	if (dma_mapping_error(NULL, bank->src_dma)) {
+		ret = -EIO;
+		goto out_unmap_iv;
+	}
+
+	if (sched->in_place) {
+		bank->dst_dma = bank->src_dma;
+	} else {
+		bank->dst_dma = dma_map_single(dst, bank->len,
+					       DMA_FROM_DEVICE);
+		if (dma_mapping_error(NULL, bank->dst_dma)) {
+			ret = -EIO;
+			goto out_unmap_src;
+		}
+	}
+	for (slot_index = 0, offset = 0; slot_index < bank->count;
+	     slot_index++) {
+		u32 task_len = min_t(u32, bank->len - offset,
+					     SUNXI_CE_AES_DIRECT_CHUNK_SIZE);
+
+		sunxi_aes_fill_task(sched->ce, &tasks[slot_index], engine_index,
+				    sched->key_dma,
+				    bank->iv_dma +
+				    slot_index * ARCH_DMA_MINALIGN,
+				    bank->src_dma + offset,
+				    bank->dst_dma + offset, task_len,
+				    sched->comm_ctl |
+				    (engine_index ? SUNXI_CE_METHOD_RAES :
+				     SUNXI_CE_METHOD_AES),
+				    sched->sym_ctl);
+		offset += task_len;
+	}
+	tasks[bank->count - 1].t_common_ctl |= SUNXI_CE_COMM_INT;
+
+	sched->src += bank->len;
+	sched->dst += bank->len;
+	sched->remaining -= blocks;
+
+	return 0;
+
+out_unmap_src:
+	dma_unmap_single(bank->src_dma, bank->len, src_dir);
+out_unmap_iv:
+	dma_unmap_single(bank->iv_dma, iv_len, DMA_TO_DEVICE);
+out_reset:
+	bank->len = 0;
+	bank->count = 0;
+
+	return ret;
+}
+
+static int sunxi_aes_submit_chain(struct sunxi_aes_chain_scheduler *sched,
+				  u32 engine_index, u32 bank_index)
+{
+	struct sunxi_aes_chain_bank *bank;
+	struct sunxi_ce_task *tasks;
+	int ret;
+
+	bank = &sched->banks[engine_index][bank_index];
+	tasks = sunxi_aes_bank_tasks(sched, engine_index, bank_index);
+
+	ret = sunxi_ce_session_submit_chain(sched->session, tasks,
+					    bank->count);
+	if (!ret)
+		sched->active_bank[engine_index] = bank_index;
+
+	return ret;
+}
+
+static u32 sunxi_aes_fair_blocks(struct sunxi_aes_chain_scheduler *sched,
+				 u32 engines_left)
+{
+	u32 align_blocks = ARCH_DMA_MINALIGN / AES_BLOCK_LENGTH;
+	u32 blocks = DIV_ROUND_UP(sched->remaining, engines_left);
+
+	return min_t(u32, sched->remaining, ALIGN(blocks, align_blocks));
+}
+
+static u32 sunxi_aes_active_channels(struct sunxi_aes_chain_scheduler *sched)
+{
+	u32 channel_mask = 0;
+	u32 engine_index;
+
+	for (engine_index = 0; engine_index < SUNXI_CE_AES_ENGINE_COUNT;
+	     engine_index++) {
+		if (sched->active_bank[engine_index] >= 0)
+			channel_mask |= SUNXI_CE_CHAN_MASK(engine_index);
+	}
+
+	return channel_mask;
+}
+
+static int
+sunxi_aes_restart(struct sunxi_aes_chain_scheduler *sched, u32 pending,
+		  int *retired_bank)
+{
+	u32 engine_index;
+	int ret;
+
+	for (engine_index = 0; engine_index < SUNXI_CE_AES_ENGINE_COUNT;
+	     engine_index++) {
+		int bank_index, next_bank;
+
+		if (!(pending & SUNXI_CE_CHAN_MASK(engine_index)))
+			continue;
+		bank_index = sched->active_bank[engine_index];
+		ret = sunxi_ce_session_complete(sched->session, engine_index);
+		if (ret)
+			return ret;
+		ret = sunxi_ce_session_sync(sched->session, BIT(engine_index));
+		if (ret)
+			return ret;
+
+		/* A chain-tail completion orders all preceding output DMA. */
+		rmb();
+		sched->active_bank[engine_index] = -1;
+		retired_bank[engine_index] = bank_index;
+
+		next_bank = bank_index ^ 1;
+		if (sched->banks[engine_index][next_bank].count) {
+			ret = sunxi_aes_submit_chain(sched, engine_index,
+						     next_bank);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int sunxi_aes_run_chains(struct sunxi_aes_chain_scheduler *sched)
+{
+	int retired_bank[SUNXI_CE_AES_ENGINE_COUNT];
+	unsigned long timeout;
+	u32 active, bank_index, engine_index, pending;
+	int ret;
+
+	for (engine_index = 0; engine_index < SUNXI_CE_AES_ENGINE_COUNT;
+	     engine_index++)
+		sched->active_bank[engine_index] = -1;
+
+	for (bank_index = 0; bank_index < SUNXI_CE_AES_BANK_COUNT;
+	     bank_index++) {
+		for (engine_index = 0;
+		     engine_index < SUNXI_CE_AES_ENGINE_COUNT; engine_index++) {
+			u32 engines_left = SUNXI_CE_AES_ENGINE_COUNT - engine_index;
+			u32 max_blocks = sunxi_aes_fair_blocks(sched, engines_left);
+
+			ret = sunxi_aes_prepare_chain(sched, engine_index,
+						      bank_index, max_blocks);
+			if (ret)
+				return ret;
+		}
+	}
+
+	for (engine_index = 0; engine_index < SUNXI_CE_AES_ENGINE_COUNT;
+	     engine_index++) {
+		ret = sunxi_aes_submit_chain(sched, engine_index, 0);
+		if (ret)
+			return ret;
+	}
+
+	timeout = timer_get_us() + SUNXI_CE_AES_CHAIN_TIMEOUT_US;
+	while ((active = sunxi_aes_active_channels(sched))) {
+		u32 prepared_mask = 0;
+		u32 retired_mask = 0;
+		u32 unmapped_mask = 0;
+
+		pending = sunxi_ce_session_pending(sched->session) & active;
+		if (!pending) {
+			if (time_after(timer_get_us(), timeout)) {
+				printf("%s: DMA timeout\n", __func__);
+				return -ETIMEDOUT;
+			}
+			schedule();
+			continue;
+		}
+
+		for (engine_index = 0;
+		     engine_index < SUNXI_CE_AES_ENGINE_COUNT; engine_index++)
+			retired_bank[engine_index] = -1;
+
+		for (;;) {
+			/* Always restart a newly completed peer before cache work. */
+			active = sunxi_aes_active_channels(sched);
+			pending = sunxi_ce_session_pending(sched->session) & active &
+				  ~retired_mask;
+			if (pending) {
+				ret = sunxi_aes_restart(sched, pending, retired_bank);
+				if (ret)
+					return ret;
+				retired_mask |= pending;
+				continue;
+			}
+
+			for (engine_index = 0;
+			     engine_index < SUNXI_CE_AES_ENGINE_COUNT;
+			     engine_index++) {
+				struct sunxi_aes_chain_bank *bank;
+				u32 engine_mask = BIT(engine_index);
+
+				if (!(retired_mask & ~unmapped_mask & engine_mask))
+					continue;
+				bank = &sched->banks[engine_index]
+						    [retired_bank[engine_index]];
+				sunxi_aes_unmap_bank(bank, sched->in_place);
+				unmapped_mask |= engine_mask;
+				break;
+			}
+			if (engine_index < SUNXI_CE_AES_ENGINE_COUNT)
+				continue;
+
+			for (engine_index = 0;
+			     engine_index < SUNXI_CE_AES_ENGINE_COUNT;
+			     engine_index++) {
+				int bank_index = retired_bank[engine_index];
+				u32 engine_mask = BIT(engine_index);
+
+				if (!(unmapped_mask & ~prepared_mask & engine_mask))
+					continue;
+				if (sched->remaining) {
+					ret = sunxi_aes_prepare_chain(sched,
+								      engine_index,
+								      bank_index,
+								      sched->remaining);
+					if (ret)
+						return ret;
+				}
+				prepared_mask |= engine_mask;
+				break;
+			}
+			if (engine_index == SUNXI_CE_AES_ENGINE_COUNT)
+				break;
+		}
+
+		timeout = timer_get_us() + SUNXI_CE_AES_CHAIN_TIMEOUT_US;
+	}
+
+	return 0;
+}
+
+static int sunxi_aes_run_direct_dual(struct sunxi_ce_priv *ce,
+				     struct sunxi_ce_task *tasks,
+				     dma_addr_t key_dma, u8 *iv,
+				     u8 *src, u8 *dst, u32 num_blocks,
+				     u32 comm_ctl, u32 sym_ctl)
+{
+	struct sunxi_ce_session session;
+	struct sunxi_aes_chain_scheduler sched;
+	u32 channel_mask = SUNXI_CE_CHAN_MASK(SUNXI_CE_CHANNEL_AES) |
+			   SUNXI_CE_CHAN_MASK(SUNXI_CE_CHANNEL_RAES);
+	u32 engine_mask = SUNXI_CE_ENGINE_AES | SUNXI_CE_ENGINE_RAES;
+	u32 bank_index, engine_index;
+	int ret;
+
+	for (engine_index = 0; engine_index < SUNXI_CE_AES_ENGINE_COUNT;
+	     engine_index++) {
+		for (bank_index = 0; bank_index < SUNXI_CE_AES_BANK_COUNT;
+		     bank_index++)
+			sched.banks[engine_index][bank_index].count = 0;
+	}
+	sched.ce = ce;
+	sched.session = &session;
+	sched.tasks = tasks;
+	sched.key_dma = key_dma;
+	sched.iv = iv;
+	sched.src = src;
+	sched.dst = dst;
+	sched.remaining = num_blocks;
+	sched.comm_ctl = comm_ctl;
+	sched.sym_ctl = sym_ctl;
+	sched.in_place = src == dst;
+
+	ret = sunxi_ce_session_begin(ce, channel_mask, engine_mask, &session);
+	if (ret)
+		return ret;
+
+	ret = sunxi_aes_run_chains(&sched);
+	if (ret)
+		goto out_abort;
+
+	return sunxi_ce_session_end(&session);
+
+out_abort:
+	/* Stop all DMA before releasing mappings owned by queued tasks. */
+	sunxi_ce_session_abort(&session);
+	sunxi_aes_unmap_chains(&sched);
+
+	return ret;
+}
+
+static void sunxi_aes_update_iv(u8 *iv_work, u8 *src, u8 *dst, u32 len,
+				bool decrypt)
+{
+	u8 *last = decrypt ? src : dst;
+
+	memcpy(iv_work, last + len - AES_BLOCK_LENGTH, AES_BLOCK_LENGTH);
+}
+
+static int sunxi_aes_run_hw(struct sunxi_ce_priv *ce,
+			    struct sunxi_ce_task *tasks, void *key,
+			    u8 *iv, u8 *src, u8 *dst, u32 num_blocks,
+			    u32 comm_ctl, u32 sym_ctl)
+{
+	u8 iv_work[AES_BLOCK_LENGTH];
+	u8 iv_next[AES_BLOCK_LENGTH];
+	u8 *iv_buf = NULL, *src_buf = NULL, *dst_buf = NULL;
+	dma_addr_t key_dma;
+	bool cbc = iv;
+	bool decrypt = comm_ctl & SUNXI_CE_DECRYPTION;
+	int dual_head_blocks;
+	int ret;
+
+	if (cbc)
+		memcpy(iv_work, iv, AES_BLOCK_LENGTH);
+
+	key_dma = dma_map_single(key, ARCH_DMA_MINALIGN, DMA_TO_DEVICE);
+	if (dma_mapping_error(NULL, key_dma)) {
+		ret = -EIO;
+		goto out_free;
+	}
+
+	while (num_blocks) {
+		dual_head_blocks =
+			sunxi_aes_dual_head_blocks(cbc, decrypt, src, dst,
+						   num_blocks);
+		if (!dual_head_blocks) {
+			u32 blocks = num_blocks &
+				~(ARCH_DMA_MINALIGN / AES_BLOCK_LENGTH - 1);
+			u32 len = blocks * AES_BLOCK_LENGTH;
+
+			ret = sunxi_aes_run_direct_dual(ce, tasks, key_dma,
+							iv_work, src, dst,
+							blocks, comm_ctl,
+							sym_ctl);
+			if (ret)
+				goto out_unmap_key;
+
+			num_blocks -= blocks;
+			src += len;
+			dst += len;
+			continue;
+		}
+
+		u32 blocks = sunxi_aes_direct_blocks(src, dst, num_blocks);
+		bool direct = blocks > 0;
+		bool in_place = direct && src == dst;
+		enum dma_data_direction src_dir = in_place ? DMA_BIDIRECTIONAL :
+							  DMA_TO_DEVICE;
+		u32 len = blocks * AES_BLOCK_LENGTH;
+		u8 *src_dma_buf = direct ? src : src_buf;
+		u8 *dst_dma_buf = direct ? dst : dst_buf;
+		dma_addr_t iv_dma = 0, src_dma, dst_dma;
+
+		if (!direct) {
+			if (!src_buf) {
+				src_buf = memalign(ARCH_DMA_MINALIGN,
+						   2 * SUNXI_CE_AES_BOUNCE_CHUNK_SIZE);
+				if (!src_buf) {
+					ret = -ENOMEM;
+					goto out_unmap_key;
+				}
+				dst_buf = src_buf + SUNXI_CE_AES_BOUNCE_CHUNK_SIZE;
+			}
+			blocks = sunxi_aes_bounce_blocks(dst, num_blocks);
+			len = blocks * AES_BLOCK_LENGTH;
+			src_dma_buf = src_buf;
+			dst_dma_buf = dst_buf;
+			memcpy(src_buf, src, len);
+		}
+		if (cbc && decrypt && in_place)
+			memcpy(iv_next, src_dma_buf + len - AES_BLOCK_LENGTH,
+			       AES_BLOCK_LENGTH);
+		if (cbc) {
+			if (!iv_buf) {
+				iv_buf = memalign(ARCH_DMA_MINALIGN,
+						  ARCH_DMA_MINALIGN);
+				if (!iv_buf) {
+					ret = -ENOMEM;
+					goto out_unmap_key;
+				}
+			}
+			memset(iv_buf, 0, ARCH_DMA_MINALIGN);
+			memcpy(iv_buf, iv_work, AES_BLOCK_LENGTH);
+			iv_dma = dma_map_single(iv_buf, ARCH_DMA_MINALIGN,
+						DMA_TO_DEVICE);
+			if (dma_mapping_error(NULL, iv_dma)) {
+				ret = -EIO;
+				goto out_unmap_key;
+			}
+		}
+
+		src_dma = dma_map_single(src_dma_buf, len, src_dir);
+		if (dma_mapping_error(NULL, src_dma)) {
+			ret = -EIO;
+			goto out_unmap_iv;
+		}
+
+		if (in_place) {
+			dst_dma = src_dma;
+		} else {
+			dst_dma = dma_map_single(dst_dma_buf, len,
+						 DMA_FROM_DEVICE);
+			if (dma_mapping_error(NULL, dst_dma)) {
+				ret = -EIO;
+				goto out_unmap_src;
+			}
+		}
+
+		sunxi_aes_fill_task(ce, tasks, SUNXI_CE_CHANNEL_AES,
+				    key_dma, iv_dma,
+				    src_dma,
+				    dst_dma, len,
+				    comm_ctl | SUNXI_CE_COMM_INT, sym_ctl);
+
+		ret = sunxi_ce_run_task(ce, tasks);
+
+		if (!in_place)
+			dma_unmap_single(dst_dma, len, DMA_FROM_DEVICE);
+out_unmap_src:
+		dma_unmap_single(src_dma, len, src_dir);
+out_unmap_iv:
+		if (cbc)
+			dma_unmap_single(iv_dma, ARCH_DMA_MINALIGN,
+					 DMA_TO_DEVICE);
+		if (ret)
+			goto out_unmap_key;
+
+		if (cbc) {
+			if (decrypt && in_place)
+				memcpy(iv_work, iv_next, AES_BLOCK_LENGTH);
+			else
+				sunxi_aes_update_iv(iv_work, src_dma_buf,
+						    dst_dma_buf, len, decrypt);
+		}
+		if (!direct)
+			memcpy(dst, dst_buf, len);
+		num_blocks -= blocks;
+		src += len;
+		dst += len;
+	}
+
+	ret = 0;
+
+out_unmap_key:
+	dma_unmap_single(key_dma, ARCH_DMA_MINALIGN, DMA_TO_DEVICE);
+out_free:
+	free(iv_buf);
+	free(src_buf);
+
+	return ret;
+}
+
+static int sunxi_aes_run(struct udevice *dev, u8 *iv, u8 *src, u8 *dst,
+			 u32 num_blocks, u32 aes_mode, bool decrypt)
+{
+	struct sunxi_aes_priv *priv = dev_get_priv(dev);
+	struct sunxi_ce_priv *ce = dev_get_priv(dev_get_parent(dev));
+	struct sunxi_ce_task *tasks;
+	u8 *key_buf;
+	u32 comm_ctl, sym_ctl;
+	bool cbc = aes_mode == SUNXI_CE_OP_CBC;
+	bool dual_chain;
+	size_t task_count, tasks_size;
+	size_t total_len;
+	int ret;
+
+	if (!priv->key_len)
+		return -EINVAL;
+	if (!num_blocks)
+		return 0;
+	if (!src || !dst)
+		return -EINVAL;
+	if (cbc && !iv)
+		return -EINVAL;
+	total_len = (size_t)num_blocks * AES_BLOCK_LENGTH;
+
+	/*
+	 * Exact in-place operation is supported, but chunked bounce processing
+	 * does not provide memmove-style semantics for partial overlaps.
+	 */
+	if (src != dst && sunxi_aes_ranges_overlap(src, dst, total_len))
+		return -EINVAL;
+
+	dual_chain = sunxi_aes_dual_head_blocks(cbc, decrypt, src, dst, num_blocks) >= 0;
+	task_count = dual_chain ? SUNXI_CE_AES_DUAL_TASK_COUNT : 1;
+	tasks_size = ALIGN(task_count * sizeof(*tasks), ARCH_DMA_MINALIGN);
+	tasks = memalign(ARCH_DMA_MINALIGN,
+			 tasks_size + ARCH_DMA_MINALIGN);
+	if (!tasks)
+		return -ENOMEM;
+	key_buf = (u8 *)tasks + tasks_size;
+
+	memset(key_buf, 0, ARCH_DMA_MINALIGN);
+	memcpy(key_buf, priv->key, priv->key_len);
+
+	comm_ctl = decrypt ? SUNXI_CE_DECRYPTION : SUNXI_CE_ENCRYPTION;
+	sym_ctl = priv->ce_key_size | aes_mode;
+
+	ret = sunxi_aes_run_hw(ce, tasks, key_buf, iv, src, dst, num_blocks,
+			       comm_ctl, sym_ctl);
+
+	free(tasks);
+
+	return ret;
+}
+
+static int sunxi_aes_available_key_slots(struct udevice *dev)
+{
+	return 1;
+}
+
+static int sunxi_aes_get_software_key_slot(struct udevice *dev)
+{
+	return 0;
+}
+
+static int sunxi_aes_select_key_slot(struct udevice *dev, u32 key_size,
+				     u8 slot)
+{
+	struct sunxi_aes_priv *priv = dev_get_priv(dev);
+	int ce_key_size;
+
+	if (slot)
+		return -EINVAL;
+
+	ce_key_size = sunxi_ce_key_size(key_size);
+	if (ce_key_size < 0)
+		return ce_key_size;
+
+	priv->key_len = key_size / 8;
+	priv->ce_key_size = ce_key_size;
+
+	return 0;
+}
+
+static int sunxi_aes_set_key_for_key_slot(struct udevice *dev, u32 key_size,
+					  u8 *key, u8 slot)
+{
+	struct sunxi_aes_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!key)
+		return -EINVAL;
+
+	ret = sunxi_aes_select_key_slot(dev, key_size, slot);
+	if (ret)
+		return ret;
+
+	memcpy(priv->key, key, key_size / 8);
+
+	return 0;
+}
+
+static int sunxi_aes_ecb_encrypt(struct udevice *dev, u8 *src, u8 *dst,
+				 u32 num_blocks)
+{
+	return sunxi_aes_run(dev, NULL, src, dst, num_blocks,
+			     SUNXI_CE_OP_ECB, false);
+}
+
+static int sunxi_aes_ecb_decrypt(struct udevice *dev, u8 *src, u8 *dst,
+				 u32 num_blocks)
+{
+	return sunxi_aes_run(dev, NULL, src, dst, num_blocks,
+			     SUNXI_CE_OP_ECB, true);
+}
+
+static int sunxi_aes_cbc_encrypt(struct udevice *dev, u8 *iv, u8 *src,
+				 u8 *dst, u32 num_blocks)
+{
+	return sunxi_aes_run(dev, iv, src, dst, num_blocks,
+			     SUNXI_CE_OP_CBC, false);
+}
+
+static int sunxi_aes_cbc_decrypt(struct udevice *dev, u8 *iv, u8 *src,
+				 u8 *dst, u32 num_blocks)
+{
+	return sunxi_aes_run(dev, iv, src, dst, num_blocks,
+			     SUNXI_CE_OP_CBC, true);
+}
+
+static const struct aes_ops sunxi_aes_ops = {
+	.available_key_slots = sunxi_aes_available_key_slots,
+	.get_software_key_slot = sunxi_aes_get_software_key_slot,
+	.select_key_slot = sunxi_aes_select_key_slot,
+	.set_key_for_key_slot = sunxi_aes_set_key_for_key_slot,
+	.aes_ecb_encrypt = sunxi_aes_ecb_encrypt,
+	.aes_ecb_decrypt = sunxi_aes_ecb_decrypt,
+	.aes_cbc_encrypt = sunxi_aes_cbc_encrypt,
+	.aes_cbc_decrypt = sunxi_aes_cbc_decrypt,
+};
+
+U_BOOT_DRIVER(sun8i_ce_aes) = {
+	.name = "sun8i-ce-aes",
+	.id = UCLASS_AES,
+	.ops = &sunxi_aes_ops,
+	.priv_auto = sizeof(struct sunxi_aes_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
new file mode 100644
index 00000000000..618fd4546b5
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -0,0 +1,712 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#include <cpu_func.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/lists.h>
+#include <errno.h>
+#include <time.h>
+#include <u-boot/schedule.h>
+#include <asm/arch/cpu.h>
+#include <asm/cache.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include "sun8i-ce.h"
+
+#define SUNXI_CE_TDQ			0x00
+#define SUNXI_CE_ICR			0x08
+#define SUNXI_CE_ISR			0x0c
+#define SUNXI_CE_TLR			0x10
+#define SUNXI_CE_ESR			0x18
+#define SUNXI_CE_SCSA			0x24
+#define SUNXI_CE_SCDA			0x28
+#define SUNXI_CE_XCSA			0x54
+#define SUNXI_CE_XCDA			0x58
+
+#define SUNXI_CE_ERR_ALGO_NOTSUP	BIT(0)
+#define SUNXI_CE_ERR_DATALEN		BIT(1)
+#define SUNXI_CE_ERR_KEYSRAM		BIT(2)
+#define SUNXI_CE_ERR_ADDR_INVALID	BIT(5)
+#define SUNXI_CE_ERR_KEYLADDER		BIT(6)
+#define SUNXI_CE_TASK_START		BIT(0)
+#define SUNXI_CE_METHOD_MASK		GENMASK(6, 0)
+#define SUNXI_CE_TLR_METHOD_SHIFT	8
+#define SUNXI_CE_WORD_SHIFT		2
+#define SUNXI_CE_SYM_ENGINE_COUNT	2
+#define SUNXI_CE_TIMEOUT_US		3000000
+
+#define SUN50I_H6_CCU_CE_CLK		0x680
+#define SUN50I_H6_CCU_CE_BGR		0x68c
+#define SUN50I_H6_CCU_MBUS_GATE		0x804
+#define SUN50I_H6_CCU_CE_CLK_SRC_MASK	BIT(24)
+#define SUN50I_H6_CCU_CE_CLK_N_MASK	GENMASK(9, 8)
+#define SUN50I_H6_CCU_CE_CLK_M_MASK	GENMASK(3, 0)
+#define SUN50I_H6_CCU_CE_CLK_GATE	BIT(31)
+#define SUN50I_H6_CCU_CE_BUS_GATE	BIT(0)
+#define SUN50I_H6_CCU_CE_BUS_RST	BIT(16)
+#define SUN50I_H6_CCU_MBUS_GATE_CE	BIT(2)
+/* PLL_PERI0(2X) / 4 = 300 MHz */
+#define SUN50I_H616_CCU_CE_CLK_M	3
+
+static void sun50i_h6_ce_spl_reset(void);
+
+u32 sunxi_ce_desc_dma_addr(struct sunxi_ce_priv *priv, dma_addr_t addr)
+{
+	if (priv->variant->needs_word_addresses)
+		addr >>= SUNXI_CE_WORD_SHIFT;
+
+	return (u32)addr;
+}
+
+static void sunxi_ce_flush(void *buf, size_t len)
+{
+	ulong start = ALIGN_DOWN((ulong)buf, ARCH_DMA_MINALIGN);
+	ulong end = ALIGN((ulong)buf + len, ARCH_DMA_MINALIGN);
+
+	flush_dcache_range(start, end);
+}
+
+static void sunxi_ce_print_error(u32 err)
+{
+	printf("CE ERROR: %#x\n", err);
+	if (err & SUNXI_CE_ERR_ALGO_NOTSUP)
+		printf("CE ERROR: algorithm not supported\n");
+	if (err & SUNXI_CE_ERR_DATALEN)
+		printf("CE ERROR: data length error\n");
+	if (err & SUNXI_CE_ERR_KEYSRAM)
+		printf("CE ERROR: keysram access error for AES\n");
+	if (err & SUNXI_CE_ERR_ADDR_INVALID)
+		printf("CE ERROR: address invalid\n");
+	if (err & SUNXI_CE_ERR_KEYLADDER)
+		printf("CE ERROR: key ladder configuration error\n");
+}
+
+static int sunxi_ce_wait(void __iomem *addr, u32 mask, u32 expect)
+{
+	unsigned long timeout = timer_get_us() + SUNXI_CE_TIMEOUT_US;
+	u32 val;
+
+	do {
+		val = readl(addr);
+		if ((val & mask) == expect)
+			return 0;
+		schedule();
+	} while (!time_after(timer_get_us(), timeout));
+
+	val = readl(addr);
+	if ((val & mask) == expect)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static u32 sunxi_ce_error_mask(u32 channel_mask)
+{
+	u32 error_mask = 0;
+	u32 chan;
+
+	for (chan = 0; chan < SUNXI_CE_MAX_CHANS; chan++) {
+		if (channel_mask & SUNXI_CE_CHAN_MASK(chan))
+			error_mask |= SUNXI_CE_CHAN_ERR_MASK(chan);
+	}
+
+	return error_mask;
+}
+
+static u32 sunxi_ce_method_engine(u32 method)
+{
+	switch (method) {
+	case SUNXI_CE_METHOD_AES:
+		return SUNXI_CE_ENGINE_AES;
+	case SUNXI_CE_METHOD_RAES:
+		return SUNXI_CE_ENGINE_RAES;
+	default:
+		return 0;
+	}
+}
+
+static int sunxi_ce_prepare_channels(struct sunxi_ce_priv *priv,
+				     u32 channel_mask)
+{
+	u32 error_mask, val;
+	int ret;
+
+	error_mask = sunxi_ce_error_mask(channel_mask);
+
+	val = readl(priv->base + SUNXI_CE_ICR);
+	writel(val | channel_mask, priv->base + SUNXI_CE_ICR);
+	writel(channel_mask, priv->base + SUNXI_CE_ISR);
+	writel(error_mask, priv->base + SUNXI_CE_ESR);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_ISR, channel_mask, 0);
+	if (ret) {
+		printf("%s: timeout waiting for stale interrupt\n", __func__);
+		clrbits_le32(priv->base + SUNXI_CE_ICR, channel_mask);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sunxi_ce_submit_task(struct sunxi_ce_priv *priv,
+				struct sunxi_ce_task *task)
+{
+	u32 method = task->t_common_ctl & SUNXI_CE_METHOD_MASK;
+	u32 load = (method << SUNXI_CE_TLR_METHOD_SHIFT) |
+		   SUNXI_CE_TASK_START;
+	int ret;
+
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_TLR,
+			    SUNXI_CE_TASK_START, 0);
+	if (ret) {
+		printf("%s: timeout waiting for task launcher\n", __func__);
+		return ret;
+	}
+
+	writel(sunxi_ce_desc_dma_addr(priv, virt_to_phys(task)),
+	       priv->base + SUNXI_CE_TDQ);
+	/* Be sure all data is written before enabling the task. */
+	wmb();
+	writel(load, priv->base + SUNXI_CE_TLR);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_TLR,
+			    SUNXI_CE_TASK_START, 0);
+	if (ret)
+		printf("%s: timeout registering task\n", __func__);
+
+	return ret;
+}
+
+static int sunxi_ce_complete_channel(struct sunxi_ce_priv *priv, u32 chan)
+{
+	u32 channel_mask, error_mask, err;
+
+	channel_mask = SUNXI_CE_CHAN_MASK(chan);
+	if (!(readl(priv->base + SUNXI_CE_ISR) & channel_mask))
+		return -EAGAIN;
+
+	writel(channel_mask, priv->base + SUNXI_CE_ISR);
+	error_mask = SUNXI_CE_CHAN_ERR_MASK(chan);
+	err = readl(priv->base + SUNXI_CE_ESR) & error_mask;
+	writel(error_mask, priv->base + SUNXI_CE_ESR);
+	if (err) {
+		sunxi_ce_print_error(err >> (chan * 8));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sunxi_ce_wait_channel(struct sunxi_ce_priv *priv, u32 chan)
+{
+	u32 channel_mask;
+	int ret;
+
+	channel_mask = SUNXI_CE_CHAN_MASK(chan);
+	ret = sunxi_ce_wait(priv->base + SUNXI_CE_ISR, channel_mask,
+			    channel_mask);
+	if (ret) {
+		printf("%s: DMA timeout\n", __func__);
+		return ret;
+	}
+
+	return sunxi_ce_complete_channel(priv, chan);
+}
+
+static int sunxi_ce_wait_engine_idle(struct sunxi_ce_priv *priv,
+				     u32 engine_mask)
+{
+	u32 engine, reg;
+	int cleanup_ret, ret = 0;
+
+	for (engine = 0; engine < SUNXI_CE_SYM_ENGINE_COUNT; engine++) {
+		if (!(engine_mask & BIT(engine)))
+			continue;
+
+		reg = SUNXI_CE_SCSA + engine * (SUNXI_CE_XCSA - SUNXI_CE_SCSA);
+		for (; reg <= SUNXI_CE_SCDA +
+				 engine * (SUNXI_CE_XCDA - SUNXI_CE_SCDA);
+		     reg += sizeof(u32)) {
+			cleanup_ret = sunxi_ce_wait(priv->base + reg, ~0U, 0);
+			if (cleanup_ret) {
+				printf("%s: timeout waiting for DMA %#x idle\n",
+				       __func__, reg);
+				if (!ret)
+					ret = cleanup_ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int sunxi_ce_clear_errors(struct sunxi_ce_priv *priv, u32 channel_mask)
+{
+	u32 error_mask, err;
+
+	error_mask = sunxi_ce_error_mask(channel_mask);
+	err = readl(priv->base + SUNXI_CE_ESR) & error_mask;
+	writel(error_mask, priv->base + SUNXI_CE_ESR);
+
+	if (err) {
+		u32 chan;
+
+		for (chan = 0; chan < SUNXI_CE_MAX_CHANS; chan++) {
+			u32 chan_err = (err >> (chan * 8)) & 0xff;
+
+			if (chan_err)
+				sunxi_ce_print_error(chan_err);
+		}
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sunxi_ce_session_check(struct sunxi_ce_session *session)
+{
+	if (!session || !session->active || !session->ce)
+		return -EINVAL;
+	if (session->generation != session->ce->generation)
+		return -ECANCELED;
+
+	return 0;
+}
+
+int sunxi_ce_session_begin(struct sunxi_ce_priv *priv, u32 channel_mask,
+			   u32 engine_mask, struct sunxi_ce_session *session)
+{
+	u32 valid_channels = GENMASK(SUNXI_CE_MAX_CHANS - 1, 0);
+	int ret;
+
+	if (!priv || !session || !channel_mask ||
+	    channel_mask & ~valid_channels || !engine_mask ||
+	    engine_mask & ~SUNXI_CE_ENGINE_MASK)
+		return -EINVAL;
+	if (priv->claimed_channels & channel_mask ||
+	    priv->claimed_engines & engine_mask)
+		return -EBUSY;
+
+	session->ce = priv;
+	session->channel_mask = channel_mask;
+	session->engine_mask = engine_mask;
+	session->generation = priv->generation;
+	session->active = true;
+	priv->claimed_channels |= channel_mask;
+	priv->claimed_engines |= engine_mask;
+
+	ret = sunxi_ce_prepare_channels(priv, channel_mask);
+	if (ret) {
+		priv->claimed_channels &= ~channel_mask;
+		priv->claimed_engines &= ~engine_mask;
+		session->active = false;
+	}
+
+	return ret;
+}
+
+static int sunxi_ce_session_validate_task(struct sunxi_ce_session *session,
+					  struct sunxi_ce_task *task,
+					  u32 *task_engine)
+{
+	u32 engine, method;
+
+	if (!task || task->t_id >= SUNXI_CE_MAX_CHANS ||
+	    !(session->channel_mask & SUNXI_CE_CHAN_MASK(task->t_id)))
+		return -EINVAL;
+
+	method = task->t_common_ctl & SUNXI_CE_METHOD_MASK;
+	engine = sunxi_ce_method_engine(method);
+	if (!engine || !(session->engine_mask & engine))
+		return -EINVAL;
+	*task_engine = engine;
+
+	return 0;
+}
+
+int sunxi_ce_session_submit_chain(struct sunxi_ce_session *session,
+				  struct sunxi_ce_task *tasks, u32 task_count)
+{
+	u32 chain_engine = 0;
+	u32 i;
+	int ret;
+
+	ret = sunxi_ce_session_check(session);
+	if (ret)
+		return ret;
+	if (!tasks || !task_count)
+		return -EINVAL;
+
+	for (i = 0; i < task_count; i++) {
+		u32 task_engine;
+
+		ret = sunxi_ce_session_validate_task(session, &tasks[i],
+						     &task_engine);
+		if (ret)
+			return ret;
+		if (chain_engine && task_engine != chain_engine)
+			return -EINVAL;
+		chain_engine = task_engine;
+		tasks[i].next = i + 1 < task_count ?
+			sunxi_ce_desc_dma_addr(session->ce,
+					       virt_to_phys(&tasks[i + 1])) : 0;
+	}
+
+	sunxi_ce_flush(tasks, task_count * sizeof(*tasks));
+
+	return sunxi_ce_submit_task(session->ce, tasks);
+}
+
+u32 sunxi_ce_session_pending(struct sunxi_ce_session *session)
+{
+	if (sunxi_ce_session_check(session))
+		return 0;
+
+	return readl(session->ce->base + SUNXI_CE_ISR) & session->channel_mask;
+}
+
+int sunxi_ce_session_complete(struct sunxi_ce_session *session, u32 chan)
+{
+	int ret;
+
+	ret = sunxi_ce_session_check(session);
+	if (ret)
+		return ret;
+	if (chan >= SUNXI_CE_MAX_CHANS ||
+	    !(session->channel_mask & SUNXI_CE_CHAN_MASK(chan)))
+		return -EINVAL;
+
+	return sunxi_ce_complete_channel(session->ce, chan);
+}
+
+int sunxi_ce_session_sync(struct sunxi_ce_session *session, u32 engine_mask)
+{
+	int ret;
+
+	ret = sunxi_ce_session_check(session);
+	if (ret)
+		return ret;
+	if (!engine_mask || engine_mask & ~session->engine_mask)
+		return -EINVAL;
+
+	return sunxi_ce_wait_engine_idle(session->ce, engine_mask);
+}
+
+int sunxi_ce_session_end(struct sunxi_ce_session *session)
+{
+	struct sunxi_ce_priv *priv;
+	u32 channel_mask, engine_mask;
+	int cleanup_ret, ret;
+
+	ret = sunxi_ce_session_check(session);
+	if (ret) {
+		if (session)
+			session->active = false;
+		return ret;
+	}
+
+	priv = session->ce;
+	channel_mask = session->channel_mask;
+	engine_mask = session->engine_mask;
+	ret = sunxi_ce_wait_engine_idle(priv, engine_mask);
+	if (ret) {
+		sunxi_ce_session_abort(session);
+		return ret;
+	}
+
+	clrbits_le32(priv->base + SUNXI_CE_ICR, channel_mask);
+	writel(channel_mask, priv->base + SUNXI_CE_ISR);
+	ret = sunxi_ce_clear_errors(priv, channel_mask);
+
+	priv->claimed_channels &= ~channel_mask;
+	priv->claimed_engines &= ~engine_mask;
+	session->active = false;
+
+	if (!priv->claimed_channels) {
+		writel(0, priv->base + SUNXI_CE_TLR);
+		writel(0, priv->base + SUNXI_CE_TDQ);
+		cleanup_ret = sunxi_ce_wait(priv->base + SUNXI_CE_TLR,
+					    SUNXI_CE_TASK_START, 0);
+		if (cleanup_ret) {
+			printf("%s: timeout clearing task launcher\n", __func__);
+			if (!ret)
+				ret = cleanup_ret;
+		}
+		readl(priv->base + SUNXI_CE_TDQ);
+	}
+
+	return ret;
+}
+
+int sunxi_ce_session_abort(struct sunxi_ce_session *session)
+{
+	struct sunxi_ce_priv *priv;
+	u32 valid_channels = GENMASK(SUNXI_CE_MAX_CHANS - 1, 0);
+	int ret;
+
+	ret = sunxi_ce_session_check(session);
+	if (ret) {
+		if (session)
+			session->active = false;
+		return ret;
+	}
+
+	priv = session->ce;
+	ret = sunxi_ce_reset(priv);
+	clrbits_le32(priv->base + SUNXI_CE_ICR, valid_channels);
+	writel(valid_channels, priv->base + SUNXI_CE_ISR);
+	writel(sunxi_ce_error_mask(valid_channels), priv->base + SUNXI_CE_ESR);
+	writel(0, priv->base + SUNXI_CE_TLR);
+	writel(0, priv->base + SUNXI_CE_TDQ);
+	priv->claimed_channels = 0;
+	priv->claimed_engines = 0;
+	priv->generation++;
+	session->active = false;
+
+	return ret;
+}
+
+int sunxi_ce_run_task(struct sunxi_ce_priv *priv, struct sunxi_ce_task *task)
+{
+	struct sunxi_ce_session session;
+	u32 channel_mask, engine;
+	int ret;
+
+	if (!task || task->t_id >= SUNXI_CE_MAX_CHANS)
+		return -EINVAL;
+
+	channel_mask = SUNXI_CE_CHAN_MASK(task->t_id);
+	engine = sunxi_ce_method_engine(task->t_common_ctl &
+					SUNXI_CE_METHOD_MASK);
+	if (!engine)
+		return -EINVAL;
+
+	ret = sunxi_ce_session_begin(priv, channel_mask, engine, &session);
+	if (ret)
+		return ret;
+
+	ret = sunxi_ce_session_submit_chain(&session, task, 1);
+	if (ret)
+		goto out_abort;
+
+	ret = sunxi_ce_wait_channel(priv, task->t_id);
+	if (ret)
+		goto out_abort;
+
+	return sunxi_ce_session_end(&session);
+
+out_abort:
+	sunxi_ce_session_abort(&session);
+
+	return ret;
+}
+
+int sunxi_ce_reset(struct sunxi_ce_priv *priv)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
+		sun50i_h6_ce_spl_reset();
+		return 0;
+	}
+
+	ret = reset_assert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	udelay(1);
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	udelay(10);
+
+	return 0;
+}
+
+static void sun50i_h6_ce_spl_reset(void)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	clrbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_RST);
+	udelay(1);
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_RST);
+	udelay(10);
+}
+
+static void sun50i_h6_ce_spl_enable_clocks(void)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	clrsetbits_le32(ccu + SUN50I_H6_CCU_CE_CLK,
+			SUN50I_H6_CCU_CE_CLK_SRC_MASK |
+			SUN50I_H6_CCU_CE_CLK_N_MASK |
+			SUN50I_H6_CCU_CE_CLK_M_MASK,
+			SUN50I_H6_CCU_CE_CLK_GATE);
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_GATE |
+		     SUN50I_H6_CCU_CE_BUS_RST);
+	setbits_le32(ccu + SUN50I_H6_CCU_MBUS_GATE,
+		     SUN50I_H6_CCU_MBUS_GATE_CE);
+	sun50i_h6_ce_spl_reset();
+}
+
+static void sun50i_h616_ce_setup_mod_clock(void)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	clrsetbits_le32(ccu + SUN50I_H6_CCU_CE_CLK,
+			SUN50I_H6_CCU_CE_CLK_GATE |
+			SUN50I_H6_CCU_CE_CLK_SRC_MASK |
+			SUN50I_H6_CCU_CE_CLK_N_MASK |
+			SUN50I_H6_CCU_CE_CLK_M_MASK,
+			SUN50I_H6_CCU_CE_CLK_SRC_MASK |
+			SUN50I_H616_CCU_CE_CLK_M);
+}
+
+static void sun50i_h616_ce_spl_enable_clocks(void)
+{
+	void __iomem *ccu = (void __iomem *)SUNXI_CCM_BASE;
+
+	sun50i_h616_ce_setup_mod_clock();
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_RST);
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_BGR,
+		     SUN50I_H6_CCU_CE_BUS_GATE);
+	setbits_le32(ccu + SUN50I_H6_CCU_CE_CLK,
+		     SUN50I_H6_CCU_CE_CLK_GATE);
+	setbits_le32(ccu + SUN50I_H6_CCU_MBUS_GATE,
+		     SUN50I_H6_CCU_MBUS_GATE_CE);
+	sun50i_h6_ce_spl_reset();
+}
+
+static int sunxi_ce_bind(struct udevice *dev)
+{
+	int ret;
+
+	if (CONFIG_IS_ENABLED(SUNXI_CE_AES)) {
+		ret = device_bind_driver(dev, "sun8i-ce-aes",
+					 "sun8i-ce-aes", NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int sunxi_ce_probe(struct udevice *dev)
+{
+	struct sunxi_ce_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->variant = (const struct sunxi_ce_variant *)
+			dev_get_driver_data(dev);
+	priv->base = dev_read_addr_ptr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD)) {
+		if (!priv->variant->spl_enable_clocks)
+			return -ENOSYS;
+
+		priv->variant->spl_enable_clocks();
+		return 0;
+	}
+
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret) {
+		dev_err(dev, "failed to get resets: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_get_bulk(dev, &priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to get clocks: %d\n", ret);
+		goto err_release_resets;
+	}
+
+	if (priv->variant->setup_mod_clock)
+		priv->variant->setup_mod_clock();
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret) {
+		dev_err(dev, "failed to deassert resets: %d\n", ret);
+		goto err_release_clks;
+	}
+
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks: %d\n", ret);
+		goto err_assert_resets;
+	}
+
+	ret = sunxi_ce_reset(priv);
+	if (ret) {
+		dev_err(dev, "failed to reset CE: %d\n", ret);
+		goto err_disable_clks;
+	}
+
+	return 0;
+
+err_disable_clks:
+	clk_disable_bulk(&priv->clks);
+err_assert_resets:
+	reset_assert_bulk(&priv->resets);
+err_release_clks:
+	clk_release_bulk(&priv->clks);
+err_release_resets:
+	reset_release_bulk(&priv->resets);
+
+	return ret;
+}
+
+static int sunxi_ce_remove(struct udevice *dev)
+{
+	struct sunxi_ce_priv *priv = dev_get_priv(dev);
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		return 0;
+
+	clk_disable_bulk(&priv->clks);
+	clk_release_bulk(&priv->clks);
+	reset_assert_bulk(&priv->resets);
+	reset_release_bulk(&priv->resets);
+
+	return 0;
+}
+
+static const struct sunxi_ce_variant sun50i_h6_variant = {
+	.spl_enable_clocks = sun50i_h6_ce_spl_enable_clocks,
+};
+
+static const struct sunxi_ce_variant sun50i_h616_variant = {
+	.needs_word_addresses = true,
+	.setup_mod_clock = sun50i_h616_ce_setup_mod_clock,
+	.spl_enable_clocks = sun50i_h616_ce_spl_enable_clocks,
+};
+
+static const struct udevice_id sunxi_ce_ids[] = {
+	{
+		.compatible = "allwinner,sun50i-h6-crypto",
+		.data = (ulong)&sun50i_h6_variant,
+	}, {
+		.compatible = "allwinner,sun50i-h616-crypto",
+		.data = (ulong)&sun50i_h616_variant,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(sun8i_ce) = {
+	.name = "sun8i-ce",
+	.id = UCLASS_NOP,
+	.of_match = sunxi_ce_ids,
+	.bind = sunxi_ce_bind,
+	.probe = sunxi_ce_probe,
+	.remove = sunxi_ce_remove,
+	.priv_auto = sizeof(struct sunxi_ce_priv),
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
new file mode 100644
index 00000000000..f4e2500d62f
--- /dev/null
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 James Hilliard
+ */
+
+#ifndef __SUN8I_CE_H
+#define __SUN8I_CE_H
+
+#include <clk.h>
+#include <reset.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+
+#define SUNXI_CE_CHANNEL_AES		0
+#define SUNXI_CE_CHANNEL_RAES		1
+#define SUNXI_CE_CHAN_MASK(x)		BIT(x)
+#define SUNXI_CE_COMM_INT		BIT(31)
+#define SUNXI_CE_METHOD_AES		0
+#define SUNXI_CE_METHOD_RAES		0x30
+#define SUNXI_CE_MAX_SG			8
+#define SUNXI_CE_MAX_CHANS		4
+#define SUNXI_CE_CHAN_ERR_MASK(x)	(0xffU << ((x) * 8))
+
+#define SUNXI_CE_ENGINE_AES		BIT(0)
+#define SUNXI_CE_ENGINE_RAES		BIT(1)
+#define SUNXI_CE_ENGINE_MASK		GENMASK(1, 0)
+
+struct sunxi_ce_sginfo {
+	u32 addr;
+	u32 len;
+};
+
+struct sunxi_ce_task {
+	u32 t_id;
+	u32 t_common_ctl;
+	u32 t_sym_ctl;
+	u32 t_asym_ctl;
+	u32 t_key;
+	u32 t_iv;
+	u32 t_ctr;
+	u32 t_dlen;
+	struct sunxi_ce_sginfo t_src[SUNXI_CE_MAX_SG];
+	struct sunxi_ce_sginfo t_dst[SUNXI_CE_MAX_SG];
+	u32 next;
+	u32 reserved[3];
+};
+
+struct sunxi_ce_variant {
+	bool needs_word_addresses;
+	void (*setup_mod_clock)(void);
+	void (*spl_enable_clocks)(void);
+};
+
+struct sunxi_ce_priv {
+	void __iomem *base;
+	const struct sunxi_ce_variant *variant;
+	struct clk_bulk clks;
+	struct reset_ctl_bulk resets;
+	u32 claimed_channels;
+	u32 claimed_engines;
+	u32 generation;
+};
+
+struct sunxi_ce_session {
+	struct sunxi_ce_priv *ce;
+	u32 channel_mask;
+	u32 engine_mask;
+	u32 generation;
+	bool active;
+};
+
+u32 sunxi_ce_desc_dma_addr(struct sunxi_ce_priv *priv, dma_addr_t addr);
+int sunxi_ce_session_begin(struct sunxi_ce_priv *priv, u32 channel_mask,
+			   u32 engine_mask, struct sunxi_ce_session *session);
+int sunxi_ce_session_submit_chain(struct sunxi_ce_session *session,
+				  struct sunxi_ce_task *tasks,
+				  u32 task_count);
+u32 sunxi_ce_session_pending(struct sunxi_ce_session *session);
+int sunxi_ce_session_complete(struct sunxi_ce_session *session, u32 chan);
+int sunxi_ce_session_sync(struct sunxi_ce_session *session, u32 engine_mask);
+int sunxi_ce_session_end(struct sunxi_ce_session *session);
+int sunxi_ce_session_abort(struct sunxi_ce_session *session);
+int sunxi_ce_run_task(struct sunxi_ce_priv *priv, struct sunxi_ce_task *task);
+int sunxi_ce_reset(struct sunxi_ce_priv *priv);
+
+#endif

-- 
2.53.0

