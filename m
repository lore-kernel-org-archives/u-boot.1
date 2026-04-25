Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CE1FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ADC48420C;
	Sat, 25 Apr 2026 18:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nMmgCoJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248CF841DF; Sat, 25 Apr 2026 18:06:02 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E3584099
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9)
 by DS4PPF80E5E852F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.24; Sat, 25 Apr
 2026 14:41:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtbq5snMuUCKvgBo3iybdB1J7lsCxf/Y8+NjW+r8LdYygAB91+MrN9T8ZWRseUJmnzFzAOYnS5HJtLaQdY/BwbYurgAC477ROyx1bdXQr1Uq8tBPsawN2GRA+phL87C59Fq6BtAu7y62mrAOkTtUrmfaYdJGWmktL1YC6IeqBqSnJqho2BFXhW5GolnndEvu8QLPLVVwQkp3RlQBjJt1nkVIKVQ1jAf9HuZ2XdRKrv2rEXnd7+uNpRk2+uemkyNE8xDa2lklePFfk2Puu/i2vraS2Y85+QK1F5lOLTuJEFBEhd1ckm0Iuo2wdLDVb5dwIYnOuWKmwFKnmin8Loi1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJHhbaqBhmFUldgEUGaZP/mPVyAMAOmZedLoC62fl6E=;
 b=YeyYVp48WjbA6uivqW2W4DntMnhebXA9dCDR0yXtA2HxaQsWmZj3DdqVSBan+GnI2j26/FYWJIVWpkKM3SH5QIAQDm2PyYzREqJ4Blsp/39O4I6+tWqrJJAfO/apxU4QKsMb3x4BJEltwQDHSzoUYv5q3tfe2vaJ+c+gx2VGoKrwR3M5ohl2avR3x2NuqFxxt0T32qp2eqcb8OeLMGNUxeDsL9ATIDlk0lkBJI62lov5kweN5S80xC+TpmqQHYTiYgjNKqQf7DnKVg/7LElflb+eZ9rSLIoUAGCI7WM6AaBdaB3SVyoQI2jDAvYnmpU/NG3cdzeiX5BoI7qhQ/q6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJHhbaqBhmFUldgEUGaZP/mPVyAMAOmZedLoC62fl6E=;
 b=nMmgCoJl1JYVZImvOASDHUIW5XQtEhXN1VQFHPMyrJQf3/V4UlUr3Z2fTKTFlq58BG8QolInSzB9Oek8naYm5dbNqDNuBw/sdN4mlwHmraKjPJ7Gl2jsOur/BAOFFdUWGjvzeV74MaZLVkHs3543h61ur9JY7X0nteeNsIB8tL0=
Received: from BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::17)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Sat, 25 Apr
 2026 03:38:27 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:10a::4) by BN9P221CA0009.outlook.office365.com
 (2603:10b6:408:10a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 03:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:38:22 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:21 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:38:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:38:21 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk872903263; Fri, 24 Apr 2026 22:38:18 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 08/11] tools: binman: Add a test for boot and load
 extensions
Date: Sat, 25 Apr 2026 09:07:39 +0530
Message-ID: <20260425033742.1519298-9-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425033742.1519298-1-b-padhi@ti.com>
References: <20260425033742.1519298-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|PH7PR10MB6602:EE_|DS4PPF80E5E852F:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9ff400-352f-4367-6f13-08dea27c19e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: axHMdN+BEFp2FfBSvcqOOxe6GNoDpbln0BdHGTWyHhFzuOzqsOJGVNJkakPCQc8gN44tazp0egJ5drAObNUdsHtwFLGTncB8rpqH8GbkeUr8xoCL3Mm/qST9NYcbyvd4MbpR7tBkjB/9yL/ed/F0OFz8CGuz0iEByQJLF9cC8nxX+PjpvB69hIDMSFU/lv1fx9uBfkFrRiDeT0tUkQRl6rSf9ql3PnVzUV496FLBwBE31KmilRAU2NQekpBiS/41rsn7iNozOfOIXRneZriwAOt8on/cW9JzAjZg+mAWWGgw3ycEESakMOU2evWyyxqTCKCqsk0RNTbvPgHcd7AFdmHY5ejgdx7kVL1EiXv9DYFpSrHEDux2Sx3TALO3J9OKs42Rqu2O2cuid+DtntX4od9w3QEfxUXWNm7kj6fJwQ1cWBcbE7fJJaBkT+0yMV2p//QVOEuspBcSVp3zcduXL/auXTthaYfoRcVfPOQTuVTWJWYgyJFnqSbSQRJFWozFTYiXQTccBzrmtVQbruz13+7z5ZHtCLniYjqFjEZIuM0P2CU+QLJ7dgm/S5KcjoBqLU5nHMvHPXAH8SXvtIWk/99e9/vcuwmlYh6jnC3jc3gk0dQw7EI0ChYK8XGSlscIgfbupmStTKV0zYXqxhjJB7aGn/n1sezP8NIaioFXXhMC9rhABaYwkljch7h0CjggwyWE/3+NgOUEk6UH4wR7QhDFS4GxEgIDjlOAf4JSe6O5L7V8mie2BjvH4B8gFkU04Me24IL8I1zBTKbc4jGBeg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YfQfwjcoAkN+XGV40Is0fDiuQ/cJ45Ior3teA88dAoMFYpHyEk9pVSa+uk9167A9UnvXRiZkan7YsgC/hdDzYBpEV7rHuHvpRYhD+PhJClJPmzXXhqma5jHiYk0FtPvEluWYuf85t7NfJbQU4I/5QzDvgKTm+FLcFC3ME+c7bZ5QT5FRDVts7WFl21jHqg2DncM7dnD+lhj6ekcuv/sViDmhgPjuUxRqO6w3IpXWC44edFgas88EIeI+rLcXMUQ3W+vAjp2gQ0f7uCMvDTm08LSQvkEaeMLaWaVBHVQa6E/XdnkNiRq9tybi+YLwfLxkHFqBzUwMHY47xRhwXvRG5Sa8JPTa19qs3TwDQvQ4v33xONOjf/nsEsRIDVQfoMko0kaNzq7Li7KMRCtZzVjrjpp0Lo4z+k8b9vSMwfJ9HAYYY6kh+x+mwcA20IfHZ63U
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:38:22.5886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9ff400-352f-4367-6f13-08dea27c19e2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-OriginatorOrg: ti.com
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

Add test coverage for the boot and load extension functionality in
ti-secure certificates. This verifies that a certificate can be
generated having boot and load extensions.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Simon Glass <sjg@chromium.org>

v4: Changelog:
1. New patch. Added binman test for load & boot extensions in
   certificate.

 tools/binman/ftest.py                         | 10 ++++++++
 .../test/vendor/ti_secure_boot_load_ext.dts   | 23 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ca5149ee654..f36d760375d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7270,6 +7270,16 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                                 entry_args=entry_args)[0]
         self.assertGreater(len(data), len(TI_UNSECURE_DATA))
 
+    def testPackTiSecureBootLoadExt(self):
+        """Test that an image with TI secured binary having boot & load extensions can be created"""
+        keyfile = self.TestFile('security/key.key')
+        entry_args = {
+            'keyfile': keyfile,
+        }
+        data = self._DoReadFileDtb('vendor/ti_secure_boot_load_ext.dts',
+                                   entry_args=entry_args)[0]
+        self.assertGreater(len(data), len(TI_UNSECURE_DATA))
+
     def testEncryptedNoAlgo(self):
         """Test encrypted node with missing required properties"""
         with self.assertRaises(ValueError) as e:
diff --git a/tools/binman/test/vendor/ti_secure_boot_load_ext.dts b/tools/binman/test/vendor/ti_secure_boot_load_ext.dts
new file mode 100644
index 00000000000..5c29d18e627
--- /dev/null
+++ b/tools/binman/test/vendor/ti_secure_boot_load_ext.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		ti-secure {
+			content = <&unsecure_binary>;
+			proc_id = <0x20>;
+			flags_set = <0x00000001>;
+			flags_clr = <0x00000002>;
+			reset_vector = <0x70000000>;
+			dest_addr = <0x80000000>;
+			auth_type = <0x02>;
+		};
+		unsecure_binary: blob-ext {
+			filename = "ti_unsecure.bin";
+		};
+	};
+};
-- 
2.34.1

