Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBE7C54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45868800F;
	Sat, 23 Mar 2024 19:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dLGjG6f7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA6B887D8D; Sat, 23 Mar 2024 19:07:47 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5A687DC7
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 779D2CE03F6;
 Sat, 23 Mar 2024 18:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BB8C43390;
 Sat, 23 Mar 2024 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217257;
 bh=UlLI/x1+0662tqrPJDuwgjzpJQBcCnQrbViSqVOrOi0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dLGjG6f7uTUmJ0KL+B5E+iq2FDqmRKYmIBo5RXS6QVf20i8I+UoCVdFBNAKgS+0dy
 uMPGZS9XDVfHEUwJsYdyfvxKk/O4YtU3WluApOi09cqpTBni8+DlPXg68JUk7dsDMB
 kwEameqf+gT9DzbmOnAU94upl4okEID6iLisM7mGvklBB17Tia+WsJBCkCArrlKpAG
 5PlQ4oWaRMDe2PEX0d6hTClIGZxXymhY58fl/sReOIK7/RCGGjAisO1dByyI+6QmR4
 sQGxt11yhJLA3Xs4Oun5xY4pnL6ERxnivv2rHXQOOA6uWkWuPoCgdRtDTkA7HEE+FR
 EZ5QUmKl9Kk/Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 17/18] misc: turris_omnia_mcu: Add support for
 rng provided by MCU
Date: Sat, 23 Mar 2024 19:07:10 +0100
Message-ID: <20240323180711.5498-18-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323180711.5498-1-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for true random number generator provided by the MCU on
Turris Omnia. The MCU firmware supports TRNG if the FEAT_TRNG bit is set
in features. In that case we bind the rng driver.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 configs/turris_omnia_defconfig  |  1 +
 drivers/misc/Kconfig            |  1 +
 drivers/misc/turris_omnia_mcu.c | 57 +++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index 0df0f3c90b..4c21635ec9 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -107,6 +107,7 @@ CONFIG_NVME_PCI=y
 CONFIG_PCI_MVEBU=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_ARMADA_38X=y
+CONFIG_DM_RNG=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_ARMADA38X=y
 CONFIG_SERIAL_PROBE_ALL=y
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 844a21be47..a08f02196f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -509,6 +509,7 @@ config TURRIS_OMNIA_MCU
 	bool "Enable Turris Omnia MCU driver"
 	depends on DM_I2C
 	depends on DM_GPIO
+	depends on DM_RNG
 	depends on SYSRESET
 	default y if TARGET_TURRIS_OMNIA
 	help
diff --git a/drivers/misc/turris_omnia_mcu.c b/drivers/misc/turris_omnia_mcu.c
index 77a0424d61..6b2f17c000 100644
--- a/drivers/misc/turris_omnia_mcu.c
+++ b/drivers/misc/turris_omnia_mcu.c
@@ -5,15 +5,20 @@
  */
 
 #include <common.h>
+#include <console.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <i2c.h>
+#include <rng.h>
 #include <sysreset.h>
 #include <turris-omnia-mcu-interface.h>
 #include <asm/byteorder.h>
 #include <asm/gpio.h>
+#include <linux/delay.h>
 #include <linux/log2.h>
 
+#define CMD_TRNG_MAX_ENTROPY_LEN	64
+
 struct turris_omnia_mcu_info {
 	u32 features;
 };
@@ -282,6 +287,49 @@ U_BOOT_DRIVER(turris_omnia_mcu_sysreset) = {
 	.ops		= &omnia_sysreset_ops,
 };
 
+static int omnia_rng_read(struct udevice *dev, void *data, size_t count)
+{
+	u8 buf[1 + CMD_TRNG_MAX_ENTROPY_LEN];
+	size_t len;
+	int ret;
+
+	while (count) {
+		ret = dm_i2c_read(dev->parent, CMD_TRNG_COLLECT_ENTROPY, buf,
+				  sizeof(buf));
+		if (ret)
+			return ret;
+
+		len = min_t(size_t, buf[0],
+			    min_t(size_t, CMD_TRNG_MAX_ENTROPY_LEN, count));
+
+		if (!len) {
+			/* wait 500ms (fail if interrupted), then try again */
+			for (int i = 0; i < 5; ++i) {
+				mdelay(100);
+				if (ctrlc())
+					return -EINTR;
+			}
+			continue;
+		}
+
+		memcpy(data, &buf[1], len);
+		data += len;
+		count -= len;
+	}
+
+	return 0;
+}
+
+static const struct dm_rng_ops omnia_rng_ops = {
+	.read		= omnia_rng_read,
+};
+
+U_BOOT_DRIVER(turris_omnia_mcu_trng) = {
+	.name		= "turris-omnia-mcu-trng",
+	.id		= UCLASS_RNG,
+	.ops		= &omnia_rng_ops,
+};
+
 static int turris_omnia_mcu_bind(struct udevice *dev)
 {
 	/* bind MCU GPIOs as a child device */
@@ -336,6 +384,15 @@ static int turris_omnia_mcu_probe(struct udevice *dev)
 			return ret;
 	}
 
+	/* bind rng if trng is supported */
+	if (info->features & FEAT_TRNG) {
+		ret = device_bind_driver_to_node(dev, "turris-omnia-mcu-trng",
+						 "turris-omnia-mcu-trng",
+						 dev_ofnode(dev), NULL);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.2

