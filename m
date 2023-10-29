Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4EEC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 08:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D101887C7A;
	Sun, 29 Oct 2023 09:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="s9P+k76a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD5A087C61; Sun, 29 Oct 2023 09:46:03 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D233D87776
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 09:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 48D2F42D4B; 
 Sun, 29 Oct 2023 08:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1698569159;
 bh=JYASbmzFoYWc/mfWrL4v10Qal18tDHvTuKV9tIUg02Y=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=s9P+k76ahSeb+DDx91gMRhSe6wbb/YbGor9SIW/NJMfUKUdBpHp25vxpNKJTO/4FD
 9s3mvkhhCwv0hxGRqXVl1GTj7lHxHdaAY6YGPUtUmJgtzJZaCd5hZ2QwLFXsArAr8U
 usw0RkeW983vtYJDs/cSxn/AcAooTWwXsXs5Pwj3twPQK1xFe1cxw6dG52HypljpAR
 9NjiAELM7M3nVOzMN/VTQTzfTi7vbjn99d9EgsuGg+C1qujAtdBAuNjYFKGlN9HuHn
 XzNN2Lmf/KdoPloW7MoDfzHRa1d3IAotRrejm4v5BzhgSMPWa7gMSliLj+vaLm2102
 2GYHX/G8YGVWw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Anup Patel <apatel@ventanamicro.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC v2 2/2] rng: Provide a RNG based on the RISC-V Zkr ISA extension
Date: Sun, 29 Oct 2023 09:45:33 +0100
Message-Id: <20231029084533.44607-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
References: <20231029084533.44607-1-heinrich.schuchardt@canonical.com>
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
v2:
	Resume after exception if seed CSR cannot be read.
---
 drivers/rng/Kconfig         |   8 +++
 drivers/rng/Makefile        |   1 +
 drivers/rng/riscv_zkr_rng.c | 116 ++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/rng/riscv_zkr_rng.c

diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index 994cc35b27..4f6e367169 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -48,6 +48,14 @@ config RNG_OPTEE
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
index 0000000000..8c9e111e2e
--- /dev/null
+++ b/drivers/rng/riscv_zkr_rng.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The RISC-V Zkr extension provides CSR seed which provides access to a
+ * random number generator.
+ */
+
+#define LOG_CATEGORY UCLASS_RNG
+
+#include <dm.h>
+#include <interrupt.h>
+#include <log.h>
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
+	struct resume_data resume;
+	int ret;
+	u32 val;
+
+	/* Check if reading seed leads to interrupt */
+	set_resume(&resume);
+	ret = setjmp(resume.jump);
+	if (ret)
+		log_debug("Exception %ld reading seed CSR\n", resume.code);
+	else
+		val = read_seed();
+	set_resume(NULL);
+	if (ret)
+		return -ENODEV;
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

