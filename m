Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793F7C27C79
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382D0889F5;
	Fri, 14 Jun 2024 14:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="boSYhU5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FFD6889E3; Fri, 14 Jun 2024 14:44:54 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C99C4889DC
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ECilIG070900;
 Fri, 14 Jun 2024 07:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718369087;
 bh=foEOf0djZzOx+B+mLAekIe/NJDao4J3Y201M8FyN8Xo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=boSYhU5ux1S+QArInfBmsA/7y5/ODhGhHId/IKhEWRDUmmz46892uqiIlJzL5gMDb
 ACv4IZeJvKwQCO3Yqr+p3mTCnfb5SzH/C12uMKAzzRh0QZdV/5VNPIY+0L0NXsWPTE
 ZA2Kglf9E0W76x9lx5Hix7phsObXMLVv8nd9ymkg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ECilZL047008
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 07:44:47 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 07:44:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 07:44:47 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.55])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ECikZR047283;
 Fri, 14 Jun 2024 07:44:46 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <a-bhatia1@ti.com>, <afd@ti.com>, <j-choudhary@ti.com>
CC: <n-francis@ti.com>, <nm@ti.com>, <joao.goncalves@toradex.com>,
 <j-humphreys@ti.com>, <d.haller@phytec.de>, <hnagalla@ti.com>,
 <bb@ti.com>, <seanga2@gmail.com>, <sjg@chromium.org>,
 <clamor95@gmail.com>, <martyn.welch@collabora.com>,
 <m-chawdhry@ti.com>, <a-limaye@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 2/8] arm: mach-k3: am62a: Simplify the logic for QOS reg
 and val propagation
Date: Fri, 14 Jun 2024 18:14:36 +0530
Message-ID: <20240614124442.178280-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614124442.178280-1-j-choudhary@ti.com>
References: <20240614124442.178280-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

For the QOS registers, instead of using the raw values for calculation
for each reg field, use a defined macro which takes in argument for all
the reg fields to get the desired value.
Do the similar simplification for QOS register and group registers and
make the corresponding changes for am62a_qos_uboot file.

Suggested-by: Andrew Davis <afd@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 arch/arm/mach-k3/include/mach/k3-qos.h       | 86 ++++----------------
 arch/arm/mach-k3/r5/am62ax/am62a_qos_uboot.c | 24 +++---
 2 files changed, 28 insertions(+), 82 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/k3-qos.h b/arch/arm/mach-k3/include/mach/k3-qos.h
index 6ed5704803..eb0f2a0448 100644
--- a/arch/arm/mach-k3/include/mach/k3-qos.h
+++ b/arch/arm/mach-k3/include/mach/k3-qos.h
@@ -9,80 +9,26 @@
 
 #include <linux/kernel.h>
 
-#define QOS_0	(0 << 0)
-#define QOS_1	(1 << 0)
-#define QOS_2	(2 << 0)
-#define QOS_3	(3 << 0)
-#define QOS_4	(4 << 0)
-#define QOS_5	(5 << 0)
-#define QOS_6	(6 << 0)
-#define QOS_7	(7 << 0)
+/* K3_QOS_REG: Registers to configure the channel for a given endpoint */
 
-#define ORDERID_0	(0 << 4)
-#define ORDERID_1	(1 << 4)
-#define ORDERID_2	(2 << 4)
-#define ORDERID_3	(3 << 4)
-#define ORDERID_4	(4 << 4)
-#define ORDERID_5	(5 << 4)
-#define ORDERID_6	(6 << 4)
-#define ORDERID_7	(7 << 4)
-#define ORDERID_8	(8 << 4)
-#define ORDERID_9	(9 << 4)
-#define ORDERID_10	(10 << 4)
-#define ORDERID_11	(11 << 4)
-#define ORDERID_12	(12 << 4)
-#define ORDERID_13	(13 << 4)
-#define ORDERID_14	(14 << 4)
-#define ORDERID_15	(15 << 4)
+#define K3_QOS_REG(base_reg, i)		(base_reg + 0x100 + (i) * 4)
 
-#define ASEL_0	(0 << 8)
-#define ASEL_1	(1 << 8)
-#define ASEL_2	(2 << 8)
-#define ASEL_3	(3 << 8)
-#define ASEL_4	(4 << 8)
-#define ASEL_5	(5 << 8)
-#define ASEL_6	(6 << 8)
-#define ASEL_7	(7 << 8)
-#define ASEL_8	(8 << 8)
-#define ASEL_9	(9 << 8)
-#define ASEL_10	(10 << 8)
-#define ASEL_11	(11 << 8)
-#define ASEL_12	(12 << 8)
-#define ASEL_13	(13 << 8)
-#define ASEL_14	(14 << 8)
-#define ASEL_15	(15 << 8)
+#define K3_QOS_VAL(qos, orderid, asel, epriority, virtid, atype) \
+	(qos		<< 0  | \
+	 orderid	<< 4  | \
+	 asel		<< 8  | \
+	 epriority	<< 12 | \
+	 virtid		<< 16 | \
+	 atype		<< 28)
 
-#define EPRIORITY_0	(0 << 12)
-#define EPRIORITY_1	(1 << 12)
-#define EPRIORITY_2	(2 << 12)
-#define EPRIORITY_3	(3 << 12)
-#define EPRIORITY_4	(4 << 12)
-#define EPRIORITY_5	(5 << 12)
-#define EPRIORITY_6	(6 << 12)
-#define EPRIORITY_7	(7 << 12)
-
-#define VIRTID_0	(0 << 16)
-#define VIRTID_1	(1 << 16)
-#define VIRTID_2	(2 << 16)
-#define VIRTID_3	(3 << 16)
-#define VIRTID_4	(4 << 16)
-#define VIRTID_5	(5 << 16)
-#define VIRTID_6	(6 << 16)
-#define VIRTID_7	(7 << 16)
-#define VIRTID_8	(8 << 16)
-#define VIRTID_9	(9 << 16)
-#define VIRTID_10	(10 << 16)
-#define VIRTID_11	(11 << 16)
-#define VIRTID_12	(12 << 16)
-#define VIRTID_13	(13 << 16)
-#define VIRTID_14	(14 << 16)
-#define VIRTID_15	(15 << 16)
-
-#define ATYPE_0	(0 << 28)
-#define ATYPE_1	(1 << 28)
-#define ATYPE_2	(2 << 28)
-#define ATYPE_3	(3 << 28)
+/*
+ * K3_QOS_GROUP_REG: Registers to set 1:1 mapping for orderID MAP1/MAP2
+ * remap registers.
+ */
+#define K3_QOS_GROUP_REG(base_reg, i)	(base_reg + (i) * 4)
 
+#define K3_QOS_GROUP_DEFAULT_VAL_LOW	0x76543210
+#define K3_QOS_GROUP_DEFAULT_VAL_HIGH	0xfedcba98
 struct k3_qos_data {
 	u32 reg;
 	u32 val;
diff --git a/arch/arm/mach-k3/r5/am62ax/am62a_qos_uboot.c b/arch/arm/mach-k3/r5/am62ax/am62a_qos_uboot.c
index 9a82944d5f..1d588acea4 100644
--- a/arch/arm/mach-k3/r5/am62ax/am62a_qos_uboot.c
+++ b/arch/arm/mach-k3/r5/am62ax/am62a_qos_uboot.c
@@ -12,20 +12,20 @@
 struct k3_qos_data qos_data[] = {
 	/* modules_qosConfig0 - 1 endpoints, 4 channels */
 	{
-		.reg = K3_DSS_UL_MAIN_0_VBUSM_DMA + 0x100 + 0x4 * 0,
-		.val = ORDERID_8,
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 0),
+		.val = K3_QOS_VAL(0, 8, 0, 0, 0, 0),
 	},
 	{
-		.reg = K3_DSS_UL_MAIN_0_VBUSM_DMA + 0x100 + 0x4 * 1,
-		.val = ORDERID_8,
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 1),
+		.val = K3_QOS_VAL(0, 8, 0, 0, 0, 0),
 	},
 	{
-		.reg = K3_DSS_UL_MAIN_0_VBUSM_DMA + 0x100 + 0x4 * 2,
-		.val = ORDERID_8,
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 2),
+		.val = K3_QOS_VAL(0, 8, 0, 0, 0, 0),
 	},
 	{
-		.reg = K3_DSS_UL_MAIN_0_VBUSM_DMA + 0x100 + 0x4 * 3,
-		.val = ORDERID_8,
+		.reg = K3_QOS_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 3),
+		.val = K3_QOS_VAL(0, 8, 0, 0, 0, 0),
 	},
 
 	/* Following registers set 1:1 mapping for orderID MAP1/MAP2
@@ -35,12 +35,12 @@ struct k3_qos_data qos_data[] = {
 
 	/* K3_DSS_UL_MAIN_0_VBUSM_DMA - 1 groups */
 	{
-		.reg = K3_DSS_UL_MAIN_0_VBUSM_DMA + 0,
-		.val = 0x76543210,
+		.reg = K3_QOS_GROUP_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 0),
+		.val = K3_QOS_GROUP_DEFAULT_VAL_LOW,
 	},
 	{
-		.reg = K3_DSS_UL_MAIN_0_VBUSM_DMA + 4,
-		.val = 0xfedcba98,
+		.reg = K3_QOS_GROUP_REG(K3_DSS_UL_MAIN_0_VBUSM_DMA, 1),
+		.val = K3_QOS_GROUP_DEFAULT_VAL_HIGH,
 	},
 };
 
-- 
2.25.1

