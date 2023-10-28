Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77C0C4332F
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 23:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234BF87809;
	Sun, 29 Oct 2023 01:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="iWxfPSRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0325087817; Sun, 29 Oct 2023 01:26:24 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C278773E
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 01:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 67C393F20A; 
 Sat, 28 Oct 2023 23:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698535579;
 bh=ewOkuBVkAuf299FY2Ud0o/MbmOAu+/kNUbDvDwl5KZg=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=iWxfPSRi9y7NpdVPxVDDUSrQ2VqvdulBM0duVC/CwYt8pCd7hntYWXhLeep34vljG
 lDP8boW7wR5tnSogmdFf0SPZ5Tgw5lK8ZxFzhHgYk1erJOKG36sgk9IF7rJedw2sl5
 IB9Dd72Ddqn/qI8JJNlaZsmVXFF4bgQsV4yVIKk5kmjPe7DafYpkdKGanAUwsE6+6i
 ol4CyAzPL+EvFvwi2DZ2UV8cX9hTQPhN/yOqjTcEvWV7ozIz53V3NhH1rmudFvqV0f
 pi4592b6QbPuY4y7yYPq90N/hft5b44gHJPFGZXo0vGH5YAZgvLCsPT8lcBjtx7Dk+
 Hc87HH43sDIsQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 1/1] rng: Provide a RNG based on the RISC-V Zkr ISA extension
Date: Sun, 29 Oct 2023 01:26:12 +0200
Message-Id: <20231028232612.109832-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
provides an interface to a physical entropy source.

A RNG driver based on the seed CSR is provided. It depends on
mseccfg.sseed being set in the SBI firmware.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/rng/Kconfig         |  11 ++++
 drivers/rng/Makefile        |   1 +
 drivers/rng/riscv_zkr_rng.c | 102 ++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/rng/riscv_zkr_rng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index 994cc35b27..f8f1d91ed2 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -48,6 +48,17 @@ config RNG_OPTEE
 	  accessible to normal world but reserved and used by the OP-TEE
 	  to avoid the weakness of a software PRNG.
 
+config RNG_RISCV_ZKR
+	bool "RISC-V Zkr random number generator"
+	depends on RISCV_SMODE
+	help
+	  This driver provides a Random Number Generator based on the
+	  Zkr RISC-V ISA extension which provides an interface to an
+	  NIST SP 800-90B or BSI AIS-31 compliant physical entropy source.
+
+	  Using this driver will lead to an exception if the M-mode firmware
+	  has not set mseccfg.sseed=1.
+
 config RNG_STM32
 	bool "Enable random number generator for STM32"
 	depends on ARCH_STM32 || ARCH_STM32MP
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index 47b323e61e..a5d3ca4130 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_RNG_MSM) += msm_rng.o
 obj-$(CONFIG_RNG_NPCM) += npcm_rng.o
 obj-$(CONFIG_RNG_OPTEE) += optee_rng.o
 obj-$(CONFIG_RNG_STM32) += stm32_rng.o
+obj-$(CONFIG_RNG_RISCV_ZKR) += riscv_zkr_rng.o
 obj-$(CONFIG_RNG_ROCKCHIP) += rockchip_rng.o
 obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
 obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
diff --git a/drivers/rng/riscv_zkr_rng.c b/drivers/rng/riscv_zkr_rng.c
new file mode 100644
index 0000000000..f48ae35410
--- /dev/null
+++ b/drivers/rng/riscv_zkr_rng.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The RISC-V Zkr extension provides CSR seed which provides access to a
+ * random number generator.
+ */
+
+#define LOG_CATEGORY UCLASS_RNG
+
+#include <common.h>
+#include <dm.h>
+#include <rng.h>
+
+#define DRIVER_NAME "riscv_zkr"
+
+enum opst {
+	/** @BIST: built in self test running */
+	BIST = 0b00,
+	/** @WAIT: sufficient amount of entropy is not yet available */
+	WAIT = 0b01,
+	/** @ES16: 16bits of entropy available */
+	ES16 = 0b10,
+	/** @DEAD: unrecoverable self-test error */
+	DEAD = 0b11,
+};
+
+static unsigned long read_seed(void)
+{
+	unsigned long ret;
+
+	__asm__ __volatile__("csrrw %0, seed, x0" : "=r" (ret) : : "memory");
+
+	return ret;
+}
+
+static int riscv_zkr_read(struct udevice *dev, void *data, size_t len)
+{
+	u8 *ptr = data;
+
+	while (len) {
+		u32 val;
+
+		val = read_seed();
+
+		switch (val >> 30) {
+		case BIST:
+			continue;
+		case WAIT:
+			continue;
+		case ES16:
+			*ptr++ = val & 0xff;
+			if (--len) {
+				*ptr++ = val >> 8;
+				--len;
+			}
+			break;
+		case DEAD:
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * riscv_zkr_probe() - check if the seed register is available
+ *
+ * If the SBI software has not set mseccfg.sseed=1 or the Zkr
+ * extension is not available this probe function will result
+ * in an exception. Currently we cannot recover from this.
+ *
+ * @dev:	RNG device
+ * Return:	0 if successfully probed
+ */
+static int riscv_zkr_probe(struct udevice *dev)
+{
+	u32 val;
+
+	do {
+		val = read_seed();
+		val >>= 30;
+	} while (val == BIST || val == WAIT);
+
+	if (val == DEAD)
+		return -ENODEV;
+
+	return 0;
+}
+
+static const struct dm_rng_ops riscv_zkr_ops = {
+	.read = riscv_zkr_read,
+};
+
+U_BOOT_DRIVER(riscv_zkr) = {
+	.name = DRIVER_NAME,
+	.id = UCLASS_RNG,
+	.ops = &riscv_zkr_ops,
+	.probe = riscv_zkr_probe,
+};
+
+U_BOOT_DRVINFO(cpu_riscv_zkr) = {
+	.name = DRIVER_NAME,
+};
-- 
2.40.1

