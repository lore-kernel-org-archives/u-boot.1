Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2DACD8C85
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 08:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3922F849E8;
	Sat,  6 Jun 2026 10:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dQfy25VN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028598495C; Sat,  6 Jun 2026 10:48:08 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FE984962
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 10:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 87199445EF;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68E9EC2BCF5;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780735671;
 bh=Kp0KWpjZjrCotobvq0UAkrdX9EFDdbDcAl9xI9e41lM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=dQfy25VN3lT55ecyXhw5hxSOHIWI7sr9VIJ5o3XPQDezQOtaZMJTai3mDsUmJkXL7
 YZf4uOWZHPz6V4dgHWSGIqVXDJSk4B267aeqI3NqPKh+Fus2XWmLEFX089EJ0yRqd9
 0a6NtqVjKGv+iJ6hruK7oxV9mq89pdTmt2WZJztMcvOB9wnqSXCvCSLy5C9STKtnWg
 e0gqJ198v7PtX90tpu+MocxwA/dCNk4MwzctIem2tiWTyaPmBDOwsFsjYoiX1Tc46F
 Q6u7UBUAVLrjMYZbHGkcbZ4cPMArz3nUoxmrSxjKFec3hCR/rdpvSBBm3wy46GB1mm
 sGTGIugLJ7ZyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 62854CD8C97;
 Sat,  6 Jun 2026 08:47:51 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 18:47:41 +1000
Subject: [PATCH 10/11] fastboot: DM_REBOOT_MODE reset support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-pm8916-pon-v1-10-170c9cbe5099@samcday.com>
References: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
In-Reply-To: <20260606-pm8916-pon-v1-0-170c9cbe5099@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 George Chan <gchan9527@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780735669; l=3077;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=l4a8r26X7bxSHHthrqIXTMNrSQXi82TGfBtJiFdzyYY=;
 b=5wy8T/FI3oWO8iNQn+rTqq0VRW2r/9YYBEkVDwE+6HHsqjw7qKVZ+japFG1MPQlSFinnhKVAV
 hArVey8A5cmDOi+yfff539roa3Hdxqk94dZgtAdtQUfWaa8QF8/9CEg
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

The weak symbol currently implements `fastboot reboot` support using the
BCB. Nowadays, there's robust reboot-mode driver support which is ideal
for this use-case.

Signed-off-by: Sam Day <me@samcday.com>
---
 drivers/fastboot/Kconfig          |  7 ++++++
 drivers/fastboot/Makefile         |  1 +
 drivers/fastboot/fb_reboot_mode.c | 51 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 90212fcf9ef..a1586e79c7e 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -108,6 +108,13 @@ config FASTBOOT_UUU_SUPPORT
 	  feature if you are using verified boot, as it will allow an attacker
 	  to bypass any restrictions you have in place.
 
+config FASTBOOT_REBOOT_MODE
+	bool "Use reboot-mode for fastboot reboot commands"
+	depends on DM_REBOOT_MODE
+	help
+	  Use a reboot-mode driver to implement fastboot reboot target flags
+	  such as reboot-bootloader, reboot-fastboot and reboot-recovery.
+
 choice
 	prompt "Flash provider for FASTBOOT"
 	depends on FASTBOOT_FLASH
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index a341af076d1..531e694f393 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
 obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
 obj-$(CONFIG_FASTBOOT_FLASH_SPI) += fb_spi_flash.o
+obj-$(CONFIG_FASTBOOT_REBOOT_MODE) += fb_reboot_mode.o
diff --git a/drivers/fastboot/fb_reboot_mode.c b/drivers/fastboot/fb_reboot_mode.c
new file mode 100644
index 00000000000..abf4066f1f5
--- /dev/null
+++ b/drivers/fastboot/fb_reboot_mode.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dm.h>
+#include <dm/uclass.h>
+#include <errno.h>
+#include <fastboot.h>
+#include <reboot-mode/reboot-mode.h>
+#include <linux/kernel.h>
+
+static int fastboot_set_reboot_mode(const char *mode)
+{
+	struct udevice *dev;
+	int ret = -ENOENT;
+
+	uclass_foreach_dev_probe(UCLASS_REBOOT_MODE, dev)
+	{
+		ret = dm_reboot_mode_activate(dev, mode);
+		if (!ret || (ret != -ENOENT && ret != -ENOSYS))
+			return ret;
+	}
+
+	return ret;
+}
+
+int fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
+{
+	static const char *const
+		reboot_modes[FASTBOOT_REBOOT_REASONS_COUNT][2] = {
+			[FASTBOOT_REBOOT_REASON_BOOTLOADER] = { "bootloader",
+								NULL },
+			[FASTBOOT_REBOOT_REASON_FASTBOOTD] = { "fastboot",
+							       "bootloader" },
+			[FASTBOOT_REBOOT_REASON_RECOVERY] = { "recovery",
+							      NULL },
+		};
+	int i, ret;
+
+	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(reboot_modes[reason]); i++) {
+		if (!reboot_modes[reason][i])
+			continue;
+
+		ret = fastboot_set_reboot_mode(reboot_modes[reason][i]);
+		if (!ret || (ret != -ENOENT && ret != -ENOSYS))
+			return ret;
+	}
+
+	return -ENOENT;
+}

-- 
2.54.0


