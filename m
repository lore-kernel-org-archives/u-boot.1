Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29C0C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 08:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E5D809D0;
	Tue, 11 Feb 2025 09:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J1A1ULaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB7380BAA; Tue, 11 Feb 2025 09:29:14 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E37BC80842
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 09:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51B8Snob203390
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Feb 2025 02:28:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739262529;
 bh=BVAUCIGvrVIWSOEgZV6jccw7zxHJf69QJa6OJwPoDEg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=J1A1ULaH9828XVXz+4RkQLI29D+2FNX2rNjV1WtadSEb3UqJeYUpFu5GLfRmvSMxH
 N6lIHz/YpNBrDYWkynkvCn+P1n4YO61Wnm2GRV9VdEG6a6HItt11YLuEPyU6EcrJnM
 zibwaMb278Z1fsx4TAW+i/mmd67zMbn6lCYCktUk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51B8SnCq003558
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 11 Feb 2025 02:28:49 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Feb 2025 02:28:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Feb 2025 02:28:49 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51B8Sc9b109021;
 Tue, 11 Feb 2025 02:28:47 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <mkorpershoek@baylibre.com>, <ddrokosov@salutedevices.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
 <a-dutta@ti.com>
Subject: [uU PATCH 3/3] include: configs: omap5: Add support for FDT overlay
Date: Tue, 11 Feb 2025 13:58:38 +0530
Message-ID: <20250211082838.18766-4-a-dutta@ti.com>
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

As AM57x uses overlays for display and camera interfaces, add support to
load DT overlay files to MMC boot.

Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 include/configs/ti_omap5_common.h | 11 +++++++++++
 include/env/ti/mmc.h              |  1 +
 2 files changed, 12 insertions(+)

diff --git a/include/configs/ti_omap5_common.h b/include/configs/ti_omap5_common.h
index ef97711e644..39102f15eb9 100644
--- a/include/configs/ti_omap5_common.h
+++ b/include/configs/ti_omap5_common.h
@@ -239,6 +239,16 @@
 		"if test $fdtfile = undefined; then " \
 			"echo WARNING: Could not determine device tree to use; fi; \0"
 
+#define GET_OVERLAY_MMC_TI_ARGS \
+	"get_overlay_mmc=" \
+		"fdt address ${fdtaddr};" \
+		"fdt resize 0x100000;" \
+		"for overlay in $name_overlays;" \
+		"do;" \
+			"load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/${overlay} &&" \
+			"fdt apply ${dtboaddr};" \
+		"done;\0" \
+
 #define BOOT_TARGET_DEVICES(func) \
 	func(TI_MMC, ti_mmc, na) \
 	func(MMC, mmc, 0) \
@@ -269,6 +279,7 @@
 	"get_fit_config=setenv name_fit_config ${fdtfile}\0" \
 	DEFAULT_COMMON_BOOT_TI_ARGS \
 	DEFAULT_FDT_TI_ARGS \
+	GET_OVERLAY_MMC_TI_ARGS \
 	DFUARGS \
 	NETARGS \
 	NANDARGS \
diff --git a/include/env/ti/mmc.h b/include/env/ti/mmc.h
index d07189baaf4..dbb0e3559ea 100644
--- a/include/env/ti/mmc.h
+++ b/include/env/ti/mmc.h
@@ -44,6 +44,7 @@
 	"mmcloados=" \
 		"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
 			"if run loadfdt; then " \
+				"run get_overlay_mmc;" \
 				"bootz ${loadaddr} - ${fdtaddr}; " \
 			"else " \
 				"if test ${boot_fdt} = try; then " \
-- 
2.34.1

