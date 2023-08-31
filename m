Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05311C83F29
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 07:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B8698654A;
	Thu, 31 Aug 2023 09:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="guyIST4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B478655C; Thu, 31 Aug 2023 09:04:39 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1279381FA8
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsvCDA1R6ZLdhXXdvugJWEmumuj5/ldd1Xyw6PvHajy/SxQIE73XlMih85UGDrbBo8teQnG8am8wYdok0coKZbbDjvXbgo07oB0kHk5Ti8/Hs40FL6wK6P6qBy6fpJcE5BUdTfOB409Zl612BVkY2IYvIVzf43tXP8+8jvA9u5dDFBN7kQqzSblMHRZgi0A3epFyFZpC7lsA9ACQm2WwdDS2qdvDAEszEPNnervoFRG1VLWnwQwoXSSSpCOI1F0PgX0lFth7bXbNr5AY0oqVkqubt/SOow2nqxnm1+gM0YwS2ZSfyyCpOHHdk5NuvI9KAM9+UQuA8tSX58FqGlgaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUtgbi0mB+hXORUYjMA8bWHrvy+9ADIXhESzZtTqtDw=;
 b=c+oF6d0ztGJrkXVgfEV2AxECuZpQ+YOYlInB6tJlQfEHGEzgUhHYSfmgyqTbImez9BNWH89YDEFOn5eAHIIjGAhhkpzLt0jD15/ATBqMu9Dwkp4p3LPQE9UoF/yyNxq/EBfi1evILuSZ1x6K8l3BXMqXRcQ4cyp2IFW5eRFBQpLoj3pWfE6J+vkGkIxrb2p/ijDgKruTFsOu66Uk07jeChr0kKDoGjpx2n3N9o0oghgUu+pFaH4f1sijWPufnWklYH0W5dIK6RBXNzB92ygbJqa78huNKDEYer8J5L10V1NqtQK2j3O+1U/LtN41manI9ROYAOopQODv8+H3MHM3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUtgbi0mB+hXORUYjMA8bWHrvy+9ADIXhESzZtTqtDw=;
 b=guyIST4BXjHEQFpfAKenoEHkqcurWjaHmliPUQAp/DcA0fLm0MANWze8oqnZemgR18fBIJf/Lvi5Lfloan2AQ/pRoBlmH20MsuMMVHvWAE3tXFd+xsjyTnwusFyVEWEmdPqrySGD1rBq2XUmZ4mDqjdVAXYMQMcl08AaJ5uzBjI=
Received: from PH8PR07CA0010.namprd07.prod.outlook.com (2603:10b6:510:2cd::22)
 by DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 07:04:32 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::c6) by PH8PR07CA0010.outlook.office365.com
 (2603:10b6:510:2cd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 07:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 07:04:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 02:04:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nikhil M Jain
 <n-jain1@ti.com>
Subject: [PATCH v2 1/2] dm: core: ofnode: Add ofnode_read_bootscript_flash()
Date: Thu, 31 Aug 2023 09:04:27 +0200
Message-ID: <08a3e6c09cce13287c69ad370e409e7f1766b406.1693465465.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4843; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Jtf+x0PHB02SwWhNnaTjkp6sNwrepP+sq/kMh6x05GY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQP1lXh/Qs2OTydmPMhpYd3cvbn5zEb9kso6znvenOWc
 X9RkYV5RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjI3GkM88yVWQ0VYifpTpj3
 YbJ3xaLX5RuPcjPMd1uzwfPr68lih1t9N9Zcrb7Bo/ekGQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e59fda1-bccf-468f-c6da-08dba9f08625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/vDUV2YZ20mlOn4tOv8oefMQBVVy2kqNZ+7Ry/TvmT1pE+WiE4sCG0xabYM9nPpmVmBpsXR9Zzjmoe4fSvzRN8DNyGkX+ompU00j6fyZ5nTgPfCf1yasG+ZX8ubcWgnczA8z8invSo+7/at/J5iHbMLAJ0tOEMGQx4VJZThFCjPnnHUm3XWYZwbK8l8MuK9JUrx8HVbAZU/RIYcNf1k97wgNbaLd8zGJECNc2/e9mzgOC0+wsRSYPBh/CvgdvGX6PoNtWL2L8QLS+58FkGnbTA04wVF+5rExlE6XyNneRreWuCohAIsWKAFuBWOdoCu7mqp7muE4n3POm5HLIA1OUrZmB0u9utBocu31u9hEir5qY5oesB6JfTTwQULfrWmKqVG5nzuJge7UtM6KNmEcaFN6Bs8TkG/Ujd48FJXp133VI2RtYavT2PjyfxEF3LqdiJ7bsi0cgYozz7Awi7VrTN4aXbqv2YCe7H53KbF1NgMnb7wCJPI/TtQILKhXsZQgn+aFuH+1dO3WgFD++aDMt/Of618Hy57WZV8I1RABmBBVGdkbBAeKByLxtwGzSFZjAqx1NT3nHl0OrFXmXHvuna6wGNwhirN9ZggYKWTQENx1GDUypgiFASP58FI2VMNEKJS/L3gq2b/NzdoVbBtOrl/rfEK4P56uPVW8FbGaCYB+cKXnBSIT56yCAAt4jTY2CwkD+WNtrxLSzDWT4P7N7WFj/tojqd0jHqWgAn4kv92Pi4IhbejRvLOxJbX9kJmtcBJwptWqxjqyeeKTYKkjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(478600001)(83380400001)(2616005)(336012)(426003)(26005)(16526019)(2906002)(44832011)(316002)(54906003)(41300700001)(70206006)(70586007)(110136005)(5660300002)(4326008)(8676002)(8936002)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 07:04:31.0299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e59fda1-bccf-468f-c6da-08dba9f08625
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780
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

ofnode_read_bootscript_flash() reads bootscript address from
/options/u-boot DT node. bootscr-flash-offset and bootscr-flash-size
properties are read and values are filled. When bootscr-flash-size is not
defined, bootscr-flash-offset property is unusable that's why cleaned.
Both of these properties should be defined to function properly.

Also add test to cover this new function.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Add missing static inline for !DM case (found by CI loop)

 arch/sandbox/dts/test.dts |  2 ++
 drivers/core/ofnode.c     | 34 ++++++++++++++++++++++++++++++++++
 include/dm/ofnode.h       | 27 +++++++++++++++++++++++++++
 test/dm/ofnode.c          |  9 +++++++--
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 84879cc31ac0..cedb66af09e7 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -83,6 +83,8 @@
 		u-boot {
 			compatible = "u-boot,config";
 			bootscr-ram-offset = /bits/ 64 <0x12345678>;
+			bootscr-flash-offset = /bits/ 64 <0>;
+			bootscr-flash-size = /bits/ 64 <0x2000>;
 		};
 	};
 
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index d94f0300c30a..023aad06ddc3 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1588,6 +1588,40 @@ int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
 	return 0;
 }
 
+int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
+				 u64 *bootscr_flash_size)
+{
+	int ret;
+	ofnode uboot;
+
+	*bootscr_flash_offset = 0;
+	*bootscr_flash_size = 0;
+
+	uboot = ofnode_path("/options/u-boot");
+	if (!ofnode_valid(uboot)) {
+		printf("%s: Missing /u-boot node\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = ofnode_read_u64(uboot, "bootscr-flash-offset",
+			      bootscr_flash_offset);
+	if (ret)
+		return -EINVAL;
+
+	ret = ofnode_read_u64(uboot, "bootscr-flash-size",
+			      bootscr_flash_size);
+	if (ret)
+		return -EINVAL;
+
+	if (!bootscr_flash_size) {
+		debug("bootscr-flash-size is zero. Ignoring properties!\n");
+		*bootscr_flash_offset = 0;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 ofnode ofnode_get_phy_node(ofnode node)
 {
 	/* DT node properties that reference a PHY node */
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index c1afa69e1c56..6f8dc4fb4551 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1521,6 +1521,27 @@ const char *ofnode_conf_read_str(const char *prop_name);
  */
 int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset);
 
+/**
+ * ofnode_read_bootscript_flash() - Read bootscr-flash-offset/size
+ *
+ * @bootscr_flash_offset: pointer to 64bit offset where bootscr-flash-offset
+ * property value is stored
+ * @bootscr_flash_size: pointer to 64bit size where bootscr-flash-size property
+ * value is stored
+ *
+ * This reads a bootscr-flash-offset and bootscr-flash-size properties from
+ * the /options/u-boot/ node of the devicetree. bootscr-flash-offset holds
+ * the offset of the boot script file from start of flash. bootscr-flash-size
+ * holds the boot script size in flash. When bootscr-flash-size is not defined,
+ * bootscr-flash-offset property is cleaned.
+ *
+ * This only works with the control FDT.
+ *
+ * Return: 0 if OK, -EINVAL if property is not found or incorrect.
+ */
+int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
+				 u64 *bootscr_flash_size);
+
 #else /* CONFIG_DM */
 static inline bool ofnode_conf_read_bool(const char *prop_name)
 {
@@ -1542,6 +1563,12 @@ static inline int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *boot
 	return -EINVAL;
 }
 
+static inline int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
+					       u64 *bootscr_flash_size)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_DM */
 
 /**
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index a4e04f23784f..d84b738ed7c4 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -585,14 +585,19 @@ DM_TEST(dm_test_ofnode_conf, 0);
 
 static int dm_test_ofnode_options(struct unit_test_state *uts)
 {
-	u64 bootscr_address;
-	u64 bootscr_offset;
+	u64 bootscr_address, bootscr_offset;
+	u64 bootscr_flash_offset, bootscr_flash_size;
 
 	ut_assertok(ofnode_read_bootscript_address(&bootscr_address,
 						   &bootscr_offset));
 	ut_asserteq_64(0, bootscr_address);
 	ut_asserteq_64(0x12345678, bootscr_offset);
 
+	ut_assertok(ofnode_read_bootscript_flash(&bootscr_flash_offset,
+						 &bootscr_flash_size));
+	ut_asserteq_64(0, bootscr_flash_offset);
+	ut_asserteq_64(0x2000, bootscr_flash_size);
+
 	return 0;
 }
 DM_TEST(dm_test_ofnode_options, 0);
-- 
2.36.1

