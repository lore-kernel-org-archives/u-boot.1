Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BDCC7EE2C
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 09:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE0A864BC;
	Fri, 25 Aug 2023 11:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CxYTlpcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3621886532; Fri, 25 Aug 2023 11:37:59 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E84F86481
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STnRPhKUTg07rwimMBEX6xgBgE2z9w25AtII2gIkf0oREpNsb0/VQdmjMwFdRhDRRD54WBxQX090tHpXIQhwVibwBVd13DMPcKG+J42JHqTw3H/RE8yy112IpcX+oMzmFA9teqMMszwLTAyjXCtEWk8A96T9o/1OXXDfcxXYP93SAWRI1Qphe9ojMl82i6mx0Ts5h0BcdXcSZSvtfskLFQ+lD+D0H6LuD9OyuswmD3UOaaoyF1nGh/KTpoE7F74r28//gfHgRY4e4dJ4rX/OQoJrSkJKEzRcFBVARLga6swn7AtmXhfp40YpevWdtfgREQvBTP3XDYiqlIiwUDdlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkR/vMK1jAChnhZG9ZeecGJmAISppKVjE05vkulKagQ=;
 b=ChDUvNvAus/OAKerT6jEOGrY27tP9L6vUOaFQZGZATe0p1t2mBPuAhhhOMTf93mJwR8DGU9URUA3lHw5pu2hLUVOv5sH6PCyGFmUBco9+Mas4sHDXUWKb0vSAL5I+YHL6Kf1G02QZhYjGF9RuvHrb56rlgZieAvYQCnWYkMhL55Tdi05Rac6jb/sf1nCWzxRMT3vsEDK15TjzpzJtPGPjUgQLCaxDGZdmEp7GYyjJn0kLGCmmfJIhtqqLpi3fO9glVhmsvIeJ6rhhgPT8q1VFLYVFIqj+ugXFZiMvoU4HZvsZSn2XkY6WFSA2U3pYVMjEXIEwDAN5SLMZc88X1QV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkR/vMK1jAChnhZG9ZeecGJmAISppKVjE05vkulKagQ=;
 b=CxYTlpcR96KIVV9uLH1SCIgwprO3YX9rdoUkvSu5LvuLJCaNzh+C2L7BqWzRvc8Vx5gPKKouDpz6SKgbZlwyKD0lLoi/o7zwb4nCiQag0fBMDLFLXJ1Iv68ECg2s06GhANGU32r5jlODCjvGMA1CHXv0a8oAIdI+7MvHlDRmKgc=
Received: from DM6PR02CA0121.namprd02.prod.outlook.com (2603:10b6:5:1b4::23)
 by PH7PR12MB7162.namprd12.prod.outlook.com (2603:10b6:510:201::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 09:37:51 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::12) by DM6PR02CA0121.outlook.office365.com
 (2603:10b6:5:1b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 09:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 09:37:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 04:37:48 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nikhil M Jain
 <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] dm: core: support reading a single indexed u64 value
Date: Fri, 25 Aug 2023 11:37:46 +0200
Message-ID: <08043c8d204d0068f04c27de86afe78c75c50b69.1692956263.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6818; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=7a9UcVS6j6a0/y958Nhi1/lHnUQSDu07ggkwAh4XQvo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQXZRmndrxKW/3mz4PTHRer2Ta5RfuIHu9Q5k7hXBR9K
 8NmQvPRjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARmdMM82OZJk0L2WiaO4+7
 e61b8vfsK0oPfRjm2VRfajU3uf82S9uVT/9z+u5r17y7AQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH7PR12MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd65f43-78ef-4afb-c51d-08dba54ef2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VLJq/J3wFYqMWj5AT9pjPtTvagLReOFTMhEVvD41VwKC+pQXs088oqm3BwSS98xgARHf+iGLqTcgp24mBt3M28P0Y6EuGsLyxIBSafcu2X5a0IJ2mARcDuX4pzyWnAc4UEeEcTT106sWtqFHhVCSXXZHjhlXkMofQBSCEAutFByFRbCt619jPBx0hvclwxr40k3oT37SxSmlHBE+A0Y4jUPLy7hpYQdpE34v+TKVt7ykJQPxyB4dUrxP5rEgexpbjGXjX3YgM+QA+fV1gcf7cpJ3VapA5uJjlV3Zc+cAI4GfHFqLGIWVOZDve1lgHnyJZC1FAqqRz/3eR4oaJYJas2OezyffK98lPWJ3IidsjgcG6qzZ0dCuv3pXh/TPPmETvkMRDECbFt5iokpNtOKh47o8BcHw/JQr+quYGc/+1zsuc5kNx19ujAMjxC6UBlxS59HoWROBcYUNPZBfyUYqLK+vmROTReEC8Cjq+aZFu1H4xixAJFmMmpf2ZwAhFXZ6eO/ubF7mkMbt2wevMMeBGwvhNLfQd29y3bhBhZqvQn2sGNG1RklW83d/qCHkthBBKGTsm1YjcZRuyCGbjsTM820w8F/2X0P0ToUE1LqJHlieC9Y+7IsX+tdELFGrGiW7zGKaWeLv5oS5lxNcfWGaolSrfc41FRHRCD0jTk45Jf7pBJlKudIL9t/mz+VyoB/OXUXagbFn/jbH75vti5JZ/IhWXHE8d5IfU2K+1G5rQ/GPV7FRGzcF5zXBGKWHbiBAQto1K8JAQIAkAqXhemgQfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(426003)(47076005)(36756003)(83380400001)(44832011)(36860700001)(26005)(40480700001)(16526019)(82740400003)(356005)(81166007)(70586007)(54906003)(70206006)(316002)(110136005)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:37:50.0291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd65f43-78ef-4afb-c51d-08dba54ef2b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7162
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

Add helper function to allow reading a single indexed u64 value from a
device-tree property containing multiple u64 values, that is an array of
u64's.

Co-developed-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>

---

Changes in v2:
- fix kernel-doc for of_read_u64_index()
- add missing test reported by Simon
- fix debug print to print 64bit value
- convert of_read_u64 to use of_read_u64_index() as is done also for u32 version
- fix overflow size calculation

Tested on sandbox:
make defconfig && make -j8 && ./u-boot --fdt arch/sandbox/dts/test.dtb --command "ut dm ofnode_u64" -v

Test: dm_test_ofnode_u64: ofnode.c
Test: dm_test_ofnode_u64: ofnode.c (flat tree)
Failures: 0

Based on v2023.07 tag.

---
 arch/sandbox/dts/test.dts |  1 +
 drivers/core/of_access.c  | 16 ++++++++++++----
 drivers/core/ofnode.c     | 30 ++++++++++++++++++++++++++++++
 include/dm/of_access.h    | 19 +++++++++++++++++++
 include/dm/ofnode.h       | 12 ++++++++++++
 test/dm/ofnode.c          |  8 ++++++++
 6 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index ff9f9222e6f9..a3c12bb09874 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -288,6 +288,7 @@
 		uint-value = <(-1234)>;
 		int64-value = /bits/ 64 <0x1111222233334444>;
 		int-array = <5678 9123 4567>;
+		int64-array = /bits/ 64 <0x1111222233334444 0x4444333322221111>;
 		str-value = "test string";
 		interrupts-extended = <&irq 3 0>;
 		acpi,name = "GHIJ";
diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index 81a307992c01..1d5348bf2f50 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -570,26 +570,34 @@ int of_read_u32_index(const struct device_node *np, const char *propname,
 	return 0;
 }
 
-int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
+int of_read_u64_index(const struct device_node *np, const char *propname,
+		      int index, u64 *outp)
 {
 	const __be64 *val;
 
 	debug("%s: %s: ", __func__, propname);
 	if (!np)
 		return -EINVAL;
-	val = of_find_property_value_of_size(np, propname, sizeof(*outp));
+
+	val = of_find_property_value_of_size(np, propname,
+					     sizeof(*outp) * (index + 1));
 	if (IS_ERR(val)) {
 		debug("(not found)\n");
 		return PTR_ERR(val);
 	}
 
-	*outp = be64_to_cpup(val);
+	*outp = be64_to_cpup(val + index);
 	debug("%#llx (%lld)\n", (unsigned long long)*outp,
-              (unsigned long long)*outp);
+	      (unsigned long long)*outp);
 
 	return 0;
 }
 
+int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
+{
+	return of_read_u64_index(np, propname, 0, outp);
+}
+
 int of_property_match_string(const struct device_node *np, const char *propname,
 			     const char *string)
 {
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index ec574c446079..e973c74af4cf 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -319,6 +319,36 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
 	return 0;
 }
 
+int ofnode_read_u64_index(ofnode node, const char *propname, int index,
+			  u64 *outp)
+{
+	const fdt64_t *cell;
+	int len;
+
+	assert(ofnode_valid(node));
+
+	if (ofnode_is_np(node))
+		return of_read_u64_index(ofnode_to_np(node), propname, index,
+					 outp);
+
+	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
+			   propname, &len);
+	if (!cell) {
+		debug("(not found)\n");
+		return -EINVAL;
+	}
+
+	if (len < (sizeof(u64) * (index + 1))) {
+		debug("(not large enough)\n");
+		return -EOVERFLOW;
+	}
+
+	*outp = fdt64_to_cpu(cell[index]);
+	debug("%#llx (%lld)\n", *outp, *outp);
+
+	return 0;
+}
+
 u32 ofnode_read_u32_index_default(ofnode node, const char *propname, int index,
 				  u32 def)
 {
diff --git a/include/dm/of_access.h b/include/dm/of_access.h
index c556a18f7d9c..9361d0a87bfb 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -333,6 +333,25 @@ int of_read_u32(const struct device_node *np, const char *propname, u32 *outp);
 int of_read_u32_index(const struct device_node *np, const char *propname,
 		      int index, u32 *outp);
 
+/**
+ * of_read_u64_index() - Find and read a 64-bit value from a multi-value
+ *                       property
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @index:	index of the u32 in the list of values
+ * @outp:	pointer to return value, modified only if return value is 0.
+ *
+ * Search for a property in a device node and read a 64-bit value from
+ * it.
+ *
+ * Return:
+ *   0 on success, -EINVAL if the property does not exist, or -EOVERFLOW if the
+ *   property data isn't large enough.
+ */
+int of_read_u64_index(const struct device_node *np, const char *propname,
+		      int index, u64 *outp);
+
 /**
  * of_read_u64() - Find and read a 64-bit integer from a property
  *
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 443db6252ddc..c5c244c6a476 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -424,6 +424,18 @@ int ofnode_read_u32(ofnode node, const char *propname, u32 *outp);
 int ofnode_read_u32_index(ofnode node, const char *propname, int index,
 			  u32 *outp);
 
+/**
+ * ofnode_read_u64_index() - Read a 64-bit integer from a multi-value property
+ *
+ * @node:	valid node reference to read property from
+ * @propname:	name of the property to read from
+ * @index:	index of the integer to return
+ * @outp:	place to put value (if found)
+ * Return: 0 if OK, -ve on error
+ */
+int ofnode_read_u64_index(ofnode node, const char *propname, int index,
+			  u64 *outp);
+
 /**
  * ofnode_read_s32() - Read a 32-bit integer from a property
  *
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 473a8cef5780..08b6721e926b 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -967,6 +967,14 @@ static int dm_test_ofnode_u64(struct unit_test_state *uts)
 	ut_asserteq_64(0x1111222233334444, val);
 	ut_asserteq(-EINVAL, ofnode_read_u64(node, "missing", &val));
 
+	ut_assertok(ofnode_read_u64_index(node, "int64-array", 0, &val));
+	ut_asserteq_64(0x1111222233334444, val);
+	ut_assertok(ofnode_read_u64_index(node, "int64-array", 1, &val));
+	ut_asserteq_64(0x4444333322221111, val);
+	ut_asserteq(-EOVERFLOW,
+		    ofnode_read_u64_index(node, "int64-array", 2, &val));
+	ut_asserteq(-EINVAL, ofnode_read_u64_index(node, "missing", 0, &val));
+
 	return 0;
 }
 DM_TEST(dm_test_ofnode_u64, UT_TESTF_SCAN_FDT);
-- 
2.36.1

