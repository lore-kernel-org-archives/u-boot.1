Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB3CC001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 04:21:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91ED686C7C;
	Fri, 18 Aug 2023 06:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GogiXFKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E6086AB9; Fri, 18 Aug 2023 06:21:45 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C565886C78
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ashok.reddy.soma@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giG1z2vPxoGMHdQSfA2Dc6H41LCL1AsY4t1LBGfHHtgYpDlDX+Kef2d0WdfoB5fKwdNT7/u5V+/SQ4SMCdZ5hZm2HY3F2Rh1I0BFZw89C4gpJiVwHfxddqyUvT+vfMu0RzHa4GwrADIfGJjOz2RmpGKMTgbnYxDjJaweZJAAfKeuvuPYHBPWXfjGTwHjRTCCcQDB99K+iDD2Mj4vJyu3jhxUzNecqi18KMomdou8v+Jh1AxZIH1alZ1gxXygk19AWEOV1tU9LXjyrCqSS6lZn7iqV42Nc+6Drr7O+GxEFjj6M8TXPe4bL3L/OoJb3sH4e1bYbP93LLS9J1+JhNjVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B1T33RkwEPKJmReH6z8eS3yZ8JkqpvvXL475ZznekA=;
 b=CVdS2fCRO2iVaCpM1dB83Dg/Z6idLFiftrtvkW5ct4mG3bIiwz94kahiX8eICZyiU0lB9gDGXTnJkIVV1mc9CBOzwweF+/3/ADUxtklUjHeR0zaOi+/dTnrTTIkXC6LrZ+T1i2JuzQbnt65EEx+TzKoUUQkRLz12jZ+gbzRgQQD+VnHfgn687x4CytiJM5UKP1/RYFIRmi3nMwbezwmoF4aRQ7kLAqvN7F0HGVWBMjzgGl3FY/nhVBVqWRivxKjCMI7/rW9q2tweQfTvVLZHlODB0Y55Q1drBeSNj1X3fWCNNxoklIfHxCf+ZfNJW9znzGiUDopJc+1ncZmb3f+WEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B1T33RkwEPKJmReH6z8eS3yZ8JkqpvvXL475ZznekA=;
 b=GogiXFKMS/KPceOEI3nw21CM714T2PK7dV1mq0+EFi6Yq7T6fXEsPx+ItN57SwpQIDWh893YjoRM7LBnQr1XhpWs5T+EwgFXFR2Vxv9c2iQgYsuo/JHTTOLNqRjqLK8FXGv8gmlYKsupUVehAnx+FcaNqXMnMjW2dRI0QRv5Gqo=
Received: from SA9PR03CA0009.namprd03.prod.outlook.com (2603:10b6:806:20::14)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 04:21:38 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::62) by SA9PR03CA0009.outlook.office365.com
 (2603:10b6:806:20::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 04:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 04:21:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:21:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:21:36 -0500
Received: from xhdashokred41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 23:21:34 -0500
From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <michal.simek@amd.com>,
 <sjg@chromium.org>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 1/7] dm: core: support reading a single indexed u64 value
Date: Thu, 17 Aug 2023 22:21:13 -0600
Message-ID: <20230818042119.25722-2-ashok.reddy.soma@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: 6901d282-10d1-4a4f-cda3-08db9fa29d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iyIrCd/okbAcslUabzMxJbGhGMhXbxkdFwfIDE2/kv35cNy6gZvVuoK1pHY41BphY63j8zQwGyM4bVvRIF8tp1xX6PZSiY5AZSEasJ1wLoH4smyhBsc7YL0g+vfdjWQxtYjqz+oI/CM5GxB0x5pH8mA1jVfGknuIZ7nR/btUjqnCmad0mPH83BNR2chtFTmE9juMfbXO7kJGLBba3JPf23Ua0odmBtKQuDOQI5WPKtyewwwMP/nPJ17k1EVx906c85fsJ3743Gnq0p0tfdzvLjAkKjUsdenUpz8nGIqw5dDTlm4qmZpAYHDapAHzKtFCvR49Blis1xoGY1CPvgitfGjX4ybEg8vZbtfGH5dW8nNwO/1nVwjVw0hNYu5SYddIjTCt3E5SAUuWaei0oBAr1tF2xpTlDTzzclHgyJNoIlcpvbh/0Y12cJMxVNzbiCpYqyxH0PbG6bj/sp88UWzAibGhbmfRKhX+a+qZ8btgGs1HMqySc3joPC3MWQo2VdMIDPlIdSSqn7lgziRWTiGh+d5iQ7mu8iNAvvxdjYKcRJ8SEJqfbzJg5+sgnlTVjVzSIRGplzWwGFIFqOZBp1lHIUeo578TrwNLBcO6O/iUwD9ea5ADF+BGDuC2bRMvWWxZDHjQFVzWwT7NiIG+vhb2OAQayGxLa2lGhaHgfpzbrSRo+7yZBQWd3xyXMfAPABPGQsBL3U3WCNaW95NxV3bWFzuojnaaZXk2lDMXIXtn8nVCrMrnSjnCeJOmMm9fSfDrReaiGwsJEsMk2+PVA2fTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(2616005)(36860700001)(426003)(1076003)(336012)(26005)(6666004)(47076005)(83380400001)(5660300002)(8936002)(8676002)(4326008)(2906002)(478600001)(41300700001)(70586007)(70206006)(6916009)(54906003)(316002)(82740400003)(356005)(81166007)(40480700001)(103116003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 04:21:37.2516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6901d282-10d1-4a4f-cda3-08db9fa29d26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
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

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
---

 drivers/core/of_access.c | 22 ++++++++++++++++++++++
 drivers/core/ofnode.c    | 30 ++++++++++++++++++++++++++++++
 include/dm/of_access.h   | 19 +++++++++++++++++++
 include/dm/ofnode.h      | 12 ++++++++++++
 4 files changed, 83 insertions(+)

diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index 57f10445b1..b5c315ac3a 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -570,6 +570,28 @@ int of_read_u32_index(const struct device_node *np, const char *propname,
 	return 0;
 }
 
+int of_read_u64_index(const struct device_node *np, const char *propname,
+		      int index, u64 *outp)
+{
+	const __be64 *val;
+
+	debug("%s: %s: ", __func__, propname);
+	if (!np)
+		return -EINVAL;
+
+	val = of_find_property_value_of_size(np, propname,
+					     sizeof(*outp) * (index + 1));
+	if (IS_ERR(val)) {
+		debug("(not found)\n");
+		return PTR_ERR(val);
+	}
+
+	*outp = be64_to_cpup(val + index);
+	debug("%#x (%d)\n", *outp, *outp);
+
+	return 0;
+}
+
 int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
 {
 	const __be64 *val;
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 8df16e56af..9a43343ed3 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -344,6 +344,36 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
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
+	if (len < (sizeof(int) * (index + 1))) {
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
index c556a18f7d..9e027c9293 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -333,6 +333,25 @@ int of_read_u32(const struct device_node *np, const char *propname, u32 *outp);
 int of_read_u32_index(const struct device_node *np, const char *propname,
 		      int index, u32 *outp);
 
+/**
+ * of_read_u64_index() - Find and read a 64-bit value from a multi-value
+ *                       property
+ *
+ * Search for a property in a device node and read a 64-bit value from
+ * it.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @index:	index of the u32 in the list of values
+ * @outp:	pointer to return value, modified only if return value is 0.
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
index 0f38b3e736..0a85db31f3 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -434,6 +434,18 @@ int ofnode_read_u32(ofnode node, const char *propname, u32 *outp);
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
-- 
2.17.1

