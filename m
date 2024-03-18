Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A726C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 09:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B6B87DE5;
	Mon, 18 Mar 2024 10:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0ED287D8D; Mon, 18 Mar 2024 10:49:43 +0100 (CET)
Received: from esa2.ltts.com (unknown [14.140.155.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8866887DAF
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 10:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhargav.r@ltts.com
IronPort-SDR: 9dm/lZr0F/JFEt2ho1wZ3zjgcKTFLHBnCW8w0uu0jwWrMUrNKOyQZWrnPP1OJcM4ZvW438r6G3
 3oun/6jwQ8Og==
Received: from unknown (HELO localhost.localdomain) ([192.168.34.55])
 by esa2.ltts.com with ESMTP; 18 Mar 2024 15:19:39 +0530
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, jh80.chung@samsung.com,
 m.nirmaladevi@ltts.com, sjg@chromium.org, trini@konsulko.com,
 Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [RESEND PATCH v3 1/5] power: tps65941: Add macros of TPS65224 PMIC
Date: Mon, 18 Mar 2024 15:19:21 +0530
Message-Id: <20240318094925.374959-2-bhargav.r@ltts.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240318094925.374959-1-bhargav.r@ltts.com>
References: <20240318094925.374959-1-bhargav.r@ltts.com>
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

Re-use the TPS65941 PMIC driver for TPS65224 PMIC.
Add additional macros of TPS65224 to aid in the driver
re-use.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
 include/power/tps65941.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/power/tps65941.h b/include/power/tps65941.h
index a2bc6814ba..cec85333f0 100644
--- a/include/power/tps65941.h
+++ b/include/power/tps65941.h
@@ -3,11 +3,14 @@
 #define TPS659413		0x2
 #define TPS659414		0x3
 #define  LP876441		0x4
+#define  TPS65224		0x5
 
 /* I2C device address for pmic tps65941 */
 #define TPS65941_I2C_ADDR	(0x12 >> 1)
 #define TPS65941_LDO_NUM		4
 #define TPS65941_BUCK_NUM		5
+#define TPS65224_LDO_NUM		3
+#define TPS65224_BUCK_NUM		4
 
 /* Drivers name */
 #define TPS65941_LDO_DRIVER		"tps65941_ldo"
@@ -25,3 +28,30 @@
 #define TPS65941_LDO_MODE_MASK		0x1
 #define TPS65941_LDO_BYPASS_EN		0x80
 #define TP65941_BUCK_CONF_SLEW_MASK	0x7
+
+#define TPS65224_BUCK_VOLT_MAX		3300000
+#define TPS65224_BUCK1_VOLT_MAX_HEX      0xFD
+#define TPS65224_BUCK234_VOLT_MAX_HEX    0x45
+
+#define TPS65224_BUCK_CONF_SLEW_MASK     0x3
+#define TPS65224_LDO_VOLT_MASK    (0x3F << 1)
+
+#define TPS65224_LDO1_VOLT_MIN_HEX       0x0C
+#define TPS65224_LDO23_VOLT_MIN_HEX      0x00
+#define TPS65224_LDO1_VOLT_MAX_HEX       0x36
+#define TPS65224_LDO23_VOLT_MAX_HEX      0x38
+
+#define TPS65224_LDO1_VOLT_MAX        3300000
+#define TPS65224_LDO23_VOLT_MAX       3400000
+#define TPS65224_LDO1_VOLT_MIN        1200000
+#define TPS65224_LDO23_VOLT_MIN        600000
+
+#define TPS65224_LDO_STEP               50000
+
+#define TPS65224_LDO_BYP_CONFIG             7
+
+#define TPS65224_LDO1_VOLT_BYP_MIN    2200000
+#define TPS65224_LDO1_VOLT_BYP_MAX    3600000
+
+#define TPS65224_LDO23_VOLT_BYP_MIN   1500000
+#define TPS65224_LDO23_VOLT_BYP_MAX   5500000
-- 
2.25.1

