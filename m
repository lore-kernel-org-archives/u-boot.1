Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F269BC0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5287E80079;
	Tue, 11 Feb 2025 09:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rorS8BUH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22C85809D0; Tue, 11 Feb 2025 09:29:12 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFADF8033D
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51B8SlqO289541
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 11 Feb 2025 02:28:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739262527;
 bh=EjED/vy8A7SaW2Iv5UmwlwBoJ21VpLlXMrXaLkqyL+c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rorS8BUHj8yHteGKbt0cd4Lx8amhVTPbTuFgAo+7QPSYoPo2T9ZUhf39GAsWzAU1V
 QS0o63l9KzuHuwqHuXXJsaqjdYWe515kn7MfP3i5agtG3SO0W1zi0S5f35S9hSQxcC
 Xq94v28UtnpFY7huxCrrp3eEAeSy6DGCFAVXvBBI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51B8SlWC102072;
 Tue, 11 Feb 2025 02:28:47 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Feb 2025 02:28:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Feb 2025 02:28:46 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51B8Sc9a109021;
 Tue, 11 Feb 2025 02:28:44 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <mkorpershoek@baylibre.com>, <ddrokosov@salutedevices.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
 <a-dutta@ti.com>
Subject: [uU PATCH 2/3] configs: omap5: Enable custom mmc boot to distroboot
 for AM57x
Date: Tue, 11 Feb 2025 13:58:37 +0530
Message-ID: <20250211082838.18766-3-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211082838.18766-1-a-dutta@ti.com>
References: <20250211082838.18766-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Sinthu Raja <sinthu.raja@ti.com>

TI AM57x boards use a custom (though family common to TI boards) mechanism
for booting Linux. Add support to enable custom MMC boot as a default
option along with the distroboot approach.

Also, add supporting mmc boot environment variables which shall be used for
custom MMC boot

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 include/configs/ti_omap5_common.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/configs/ti_omap5_common.h b/include/configs/ti_omap5_common.h
index d315a52f36f..ef97711e644 100644
--- a/include/configs/ti_omap5_common.h
+++ b/include/configs/ti_omap5_common.h
@@ -240,16 +240,31 @@
 			"echo WARNING: Could not determine device tree to use; fi; \0"
 
 #define BOOT_TARGET_DEVICES(func) \
+	func(TI_MMC, ti_mmc, na) \
 	func(MMC, mmc, 0) \
 	func(MMC, mmc, 1) \
 	func(PXE, pxe, na) \
 	func(DHCP, dhcp, na)
 
+#define BOOTENV_DEV_TI_MMC(devtypeu, devtypel, instance)	\
+	"bootcmd_ti_mmc= run get_name_kern; run mmcboot\0"
+
+#define BOOTENV_DEV_NAME_TI_MMC(devtyeu, devtypel, instance)            \
+	"ti_mmc "
+
 #include <config_distro_bootcmd.h>
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	DEFAULT_LINUX_BOOT_ENV \
 	DEFAULT_MMC_TI_ARGS \
+	"bootpart=0:2\0" \
+	"bootdir=/boot\0" \
+	"get_name_kern=" \
+	"if test $boot_fit -eq 1; then " \
+		"setenv bootfile fitImage; " \
+	"else " \
+		"setenv bootfile zImage; " \
+	"fi\0" \
 	DEFAULT_FIT_TI_ARGS \
 	"get_fit_config=setenv name_fit_config ${fdtfile}\0" \
 	DEFAULT_COMMON_BOOT_TI_ARGS \
-- 
2.34.1

