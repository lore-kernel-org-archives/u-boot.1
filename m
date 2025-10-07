Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614D1CCA476
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73DAC838C8;
	Tue,  7 Oct 2025 10:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="xSjbVNIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B339838EE; Tue,  7 Oct 2025 10:18:22 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBF4838C7
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3E836C9A4D; Tue,  7 Oct 2025 10:18:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1759825100; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=k2eIr12dX5Epx2rhwOdRf5ZqWR/vZkTnVZiGLrq93rM=;
 b=xSjbVNIay6poh7fGwYDqILcmB/w4dLzX7yuAF/lw+k8tp1CQ9clcsKMzMMBvFCIWRAhbEx
 xDEcbSKE4sraEaSuAhwEbYO7mw98/tAmsgMoWwhu6s79+cy3uFKaMTPr1YjdNvMunpli71
 yD6JcChD50eMHjctzwul8arxS+4U+k1Tiw+4zVjPJpTXAh2N6oOifQ9NP2jVVGm1d4e4tw
 TX57sn5bhpqQkqesO/x1s9qEGEpimyVCdKyRVGlQXvVjrEj00r2ch2CEMJb0Oe5A0wXHwy
 UWyzMPGxF/MwjnXZyDW8oo/DyAcpL2pKgNvE9UUrjGR49CaodATrfvKp2iIgxQ==
From: Frieder Schrempf <frieder@fris.de>
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH 07/13] imx: kontron-sl-mx8mm: Export current env config to
 devicetree
Date: Tue,  7 Oct 2025 10:16:04 +0200
Message-ID: <20251007081640.61772-8-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
References: <20251007081640.61772-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This allows userspace tools like libubootenv to determine the
location of the currently used environment and select a
matching config.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/sl-mx8mm/sl-mx8mm.c | 36 +++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/board/kontron/sl-mx8mm/sl-mx8mm.c b/board/kontron/sl-mx8mm/sl-mx8mm.c
index 405ac0fb03f..cb0b3acdd62 100644
--- a/board/kontron/sl-mx8mm/sl-mx8mm.c
+++ b/board/kontron/sl-mx8mm/sl-mx8mm.c
@@ -14,6 +14,7 @@
 #include <fdt_support.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <mmc.h>
 #include <net.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -108,12 +109,43 @@ int fdt_set_usb_eth_addr(void *blob)
 
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
-	int ret = fdt_set_usb_eth_addr(blob);
+	enum env_location env_loc;
+	enum boot_device boot_dev;
+	char env_str_sd[] = "sd-card";
+	char env_str_nor[] = "spi-nor";
+	char env_str_emmc[] = "emmc";
+	char *env_config_str;
+	int ret;
+
+	ret = fdt_set_usb_eth_addr(blob);
+	if (ret)
+		return ret;
 
+	ret = fdt_fixup_memory(blob, PHYS_SDRAM, gd->ram_size);
 	if (ret)
 		return ret;
 
-	return fdt_fixup_memory(blob, PHYS_SDRAM, gd->ram_size);
+	env_loc = env_get_location(0, 0);
+	if (env_loc == ENVL_MMC) {
+		boot_dev = get_boot_device();
+		if (boot_dev == SD2_BOOT)
+			env_config_str = env_str_sd;
+		else if (boot_dev == MMC1_BOOT)
+			env_config_str = env_str_emmc;
+		else
+			return 0;
+	} else if (env_loc == ENVL_SPI_FLASH) {
+		env_config_str = env_str_nor;
+	} else {
+		return 0;
+	}
+
+	/*
+	 * Export a string to the devicetree that tells userspace tools like
+	 * libubootenv where the environment is currently coming from.
+	 */
+	return fdt_find_and_setprop(blob, "/chosen", "u-boot,env-config",
+				    env_config_str, strlen(env_config_str) + 1, 1);
 }
 
 int board_late_init(void)
-- 
2.51.0

