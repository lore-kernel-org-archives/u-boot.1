Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EB8C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 06:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FC98654A;
	Thu, 31 Aug 2023 08:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tMVWcmif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DAF681FA8; Thu, 31 Aug 2023 08:59:16 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356A98654A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 08:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUOS3Qd3oYqwWMrDrUdd7JooTEaxFOdNtq/02GjusVkC4bSeb9fOIOV9qJBgNJJqQI334LpZTAVH5na/eax20F9OfO2qZVBEKUZ/ReiQRPPamm6qnkGgQpWYGWJCeoPcbvDLB1YRmcLyWhIoLl8sp99jidx/zVn4wi59VypSI65sVzTIoulXEAsdFVUFmq/dGNG21kLqK3n2S/NrgFGzd6q8zQOHRq+x+jzc6iAGINl98CKwGjvq+Ze0pFIE0DKYGXSaBNHVQyQFQqfeD1rJX8MYaWu2gB57TjosrNrV/fyMA7Va/hvxaCxSety+rFYRuvJ9MpQjGHN0VoufC8QwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj8XclQB2fhvoLRxxB846HL9HrxukXFX/yUlWOz7H4o=;
 b=Y8/G9edoeQmp+cCSeWekstDK/2U0yg7bRfoF9p55Chy4PQ+TH81u9K8/2VZGl/9uzBWhS6IC0YXIvsRK2btP22X+fpI2eWi3y4RFYgPcpIlbi5kigxiaD8x+5ynX2dJ1jKLr1UPGjoE+rWsqa8cd/bb+bxrXwZZnGgpUnzIkOLL2KfHshykB7g9YkhPh9WB23/fKwGWhrYePg2EHJ+QBmgRB/6zHY5E3q3wyz8cSxqqg82xgBFI3wpV5SpydVFpggmUSycXHwlzJoOx8dgeILiFyZGQqh3Y8RNWc1w0K7PgQ70mBCC+I5R600NtPBfqSbonbJ39Vb4W8JlT9utHWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj8XclQB2fhvoLRxxB846HL9HrxukXFX/yUlWOz7H4o=;
 b=tMVWcmif92GAv5kwGrhmyiupxMqW3o5AxiKbG9TlwJjpjgVpqJLK1dHq5KbieitqnLH5fkMTSEBNPAYQvT5IFxfFc1fLdG7rp5PVx6Ke4LlkZ1xGL9UF2X1MF5VOjfvGrqCv8ivzS3oeSq1y0nT8tuJWrwVTOxqe9bzizEnAIDM=
Received: from SA1P222CA0089.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::19)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 06:59:10 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::65) by SA1P222CA0089.outlook.office365.com
 (2603:10b6:806:35e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Thu, 31 Aug 2023 06:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 06:59:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 31 Aug
 2023 01:59:07 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nikhil M Jain
 <n-jain1@ti.com>
Subject: [PATCH v5 1/2] dm: core: ofnode: Add ofnode_read_bootscript_address()
Date: Thu, 31 Aug 2023 08:59:05 +0200
Message-ID: <23be3838502efef61803c90ef6e8b32bbd6ede41.1693465140.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4771; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Yxk9VNhnzB3aWlrhkhBzkQB769FTWbgaKtIHvs3+0vs=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQPVqbOonXl07qVOoXKfFqMio5c0np4vkWceVmNWZJS6
 2O9564dsSwMgkwMsmKKLNI2V87srZwxRfjiYTmYOaxMIEMYuDgFYCLNrAzzEwJe95aHlSjNFIuc
 mHLz7JKmFzcvMczPjTZ2M6tYuSJ8zrbAwLtNP6tm3moFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: ee1e7cb5-c252-4314-bd68-08dba9efc62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3O6nsXzXNo1rW8sqXViSq9bs2TAAz7IOai8tfzBF/Go66YnUiP3Bb2c3WaeDbvrWSAnb7ppDCW+YMJliikwzJCphI8W/4Pi5gMlEqG/DCtb3GBu2mtd0f8EV3inDwaBs8XnROIVMnC3xzvFUi8luittz4buoFW/Skq5VA1jHVFmXSzve1ksnXnOHH+f8cB61GvE36g5ZYkJ4nkns9wdi+uEr0mx87OEd2zF5OVsWihG70LDAACjGaJHtShJ9CUXEdvDkdyc7aIzj1XYRc4M76DTcKGPtj43dApUaMYDO2JivOsN6e99eZc5k0hkLhLBsHdc/PliHo9XjMG3ZpYpxJPl15/b/cl2t46FOIWHrTkCLKlkHXn00nrj+aC4QhNGsetBzstdR21kGPDQQQ7F/6rtaYBk8f/fv2lnAPiWPIOnc3IegsHoa1SJG6DZ/l+4CURhfldkloyrjpZ62rlTtvASi2SVYjfB9oFOFrOdRLBTGHbLaETBxWA+SjMa6K4n8eptGHozrvm6qcZZZwSOKyjDDapTpI45oqJMCDWs4JaiU+dhxVmxXwuPQUWeE43/+PhClDJXzUoIyPwfMvk6HrdigmU5XcKEQeGKznlRycZbwTjE1RT8vNiBx9Z5enxED8rqOGfc5oVLdPmeHhBLteD/qvbLenJWh55f3i+Pk/K8T6zoRe8EC5DXwMkoB2SWgy92tMUODDd8GNsI1PKfJbSK+pB7NCNdK1nAOqeGlNoEW6v9ntLTuxNjGxiIrUqJPlb5mlGpoBgL58nOoBPGkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(478600001)(83380400001)(2616005)(336012)(426003)(26005)(16526019)(2906002)(44832011)(316002)(54906003)(41300700001)(70206006)(70586007)(110136005)(5660300002)(4326008)(8676002)(8936002)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 06:59:08.9727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1e7cb5-c252-4314-bd68-08dba9efc62f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444
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

ofnode_read_bootscript_address() reads bootscript address from
/options/u-boot DT node. bootscr-address or bootscr-ram-offset properties
are read and values are filled. bootscr-address has higher priority than
bootscr-ram-offset and the only one should be described in DT.

Also add test to cover this new function.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v5:
- CI loop found some issues. Missing errno.h, multiple
  ofnode_read_bootscript_address() because of missing static inline for !DM
  cases

Changes in v4:
- Update ofnode test based on review from Simon

Changes in v3:
- new patch in this series

 arch/sandbox/dts/test.dts |  7 +++++++
 drivers/core/ofnode.c     | 25 +++++++++++++++++++++++++
 include/dm/ofnode.h       | 26 ++++++++++++++++++++++++++
 test/dm/ofnode.c          | 14 ++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index f351d5cb84b0..84879cc31ac0 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -79,6 +79,13 @@
 		};
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			bootscr-ram-offset = /bits/ 64 <0x12345678>;
+		};
+	};
+
 	bootstd {
 		bootph-verify;
 		compatible = "u-boot,boot-std";
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 8df16e56af5c..d94f0300c30a 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -1563,6 +1563,31 @@ const char *ofnode_conf_read_str(const char *prop_name)
 	return ofnode_read_string(node, prop_name);
 }
 
+int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
+{
+	int ret;
+	ofnode uboot;
+
+	*bootscr_address = 0;
+	*bootscr_offset = 0;
+
+	uboot = ofnode_path("/options/u-boot");
+	if (!ofnode_valid(uboot)) {
+		printf("%s: Missing /u-boot node\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = ofnode_read_u64(uboot, "bootscr-address", bootscr_address);
+	if (ret) {
+		ret = ofnode_read_u64(uboot, "bootscr-ram-offset",
+				      bootscr_offset);
+		if (ret)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 ofnode ofnode_get_phy_node(ofnode node)
 {
 	/* DT node properties that reference a PHY node */
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 0f38b3e736de..c1afa69e1c56 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -20,6 +20,7 @@
 struct resource;
 
 #include <dm/ofnode_decl.h>
+#include <linux/errno.h>
 
 struct ofnode_phandle_args {
 	ofnode node;
@@ -1500,6 +1501,26 @@ int ofnode_conf_read_int(const char *prop_name, int default_val);
  */
 const char *ofnode_conf_read_str(const char *prop_name);
 
+/**
+ * ofnode_read_bootscript_address() - Read bootscr-address or bootscr-ram-offset
+ *
+ * @bootscr_address: pointer to 64bit address where bootscr-address property value
+ * is stored
+ * @bootscr_offset:  pointer to 64bit offset address where bootscr-ram-offset
+ * property value is stored
+ *
+ * This reads a bootscr-address or bootscr-ram-offset property from
+ * the /options/u-boot/ node of the devicetree. bootscr-address holds the full
+ * address of the boot script file. bootscr-ram-offset holds the boot script
+ * file offset from the start of the ram base address. When bootscr-address is
+ * defined, bootscr-ram-offset property is ignored.
+ *
+ * This only works with the control FDT.
+ *
+ * Return: 0 if OK, -EINVAL if property is not found.
+ */
+int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset);
+
 #else /* CONFIG_DM */
 static inline bool ofnode_conf_read_bool(const char *prop_name)
 {
@@ -1516,6 +1537,11 @@ static inline const char *ofnode_conf_read_str(const char *prop_name)
 	return NULL;
 }
 
+static inline int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_DM */
 
 /**
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 6fbebc7da085..a4e04f23784f 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -583,6 +583,20 @@ static int dm_test_ofnode_conf(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_conf, 0);
 
+static int dm_test_ofnode_options(struct unit_test_state *uts)
+{
+	u64 bootscr_address;
+	u64 bootscr_offset;
+
+	ut_assertok(ofnode_read_bootscript_address(&bootscr_address,
+						   &bootscr_offset));
+	ut_asserteq_64(0, bootscr_address);
+	ut_asserteq_64(0x12345678, bootscr_offset);
+
+	return 0;
+}
+DM_TEST(dm_test_ofnode_options, 0);
+
 static int dm_test_ofnode_for_each_compatible_node(struct unit_test_state *uts)
 {
 	const char compatible[] = "denx,u-boot-fdt-test";
-- 
2.36.1

