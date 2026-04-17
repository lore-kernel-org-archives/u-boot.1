Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC183F8DFE3
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB97D8428C;
	Fri, 17 Apr 2026 10:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="lnyBc/zY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C950F83FC0; Fri, 17 Apr 2026 10:31:25 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA5F8423F
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4FtSd+4rGezsn4yBMY0eI84LCf0D5ByyAbTwu48VphCIb0P+HJrAK3IISlgDvIJvHoVC8RuPn0Oa2qQtuZNMxrb+2RdLEVNBNMbM6XD0q4xoeZJ+ANCo9uPceEsBXoixIYmf5i6uwO3P5wS7rAEPMGJ1tbmmKpJKXQXCHmD0kpwvl46uXwu8e+jxwJNSnSbHIfo1uc+zsSMOnbBXqpFq7cNJ+dO/1X29ajQtZ4WK0tnCOYNyIE8RW1edw4Qt72OYeUXW9C0uTck2orZ7L7AABy/3SQF3duXuBUHgOzkr0xxmpbYullTm5YaW28f81Y2kVhTIvNNWl7f0RiP3XxtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4kFXQ8mHAccY2wtC/sbuwvyhnlyIPaMYbDDl7xnrNg=;
 b=lghRo22NZmh4JeA9OUw7iq9IrPtcMe271f4v5MW/R9la12hmqarQMWPVmtkwzOdnMCZYhqbfIgSzHUQhDk3nmfiOl/+doTUXzvUmo2AnPiciP+pfzwqQIJfDSH7rQxJjsaS5pqIgLjFcfG3FLa/VaGVxfzrumulW4JRB6E1i3c4H+vvnhtAbg1ZNccZlwc0aZ9NZH88tq8r0nMwDvXVaUQrodcb9ik7qnYaYyWrTvX6OXrRwoTz2XIDz4bVcBxNsb69XLjuK1yrJFFBc7Os8lt39ChIkJOeK1V9yOPYK4r6W2oxzhs88ke/hXl0pOUnIoekh59VBvLkfL7jYY5v/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4kFXQ8mHAccY2wtC/sbuwvyhnlyIPaMYbDDl7xnrNg=;
 b=lnyBc/zYjlzYT75gZGUMEZDo0k0URflDDdNXAiAqy8GVV+pYzhfo2VSWzS8GdGRCUepsdAS13WXViRv0D5c1RiCr9Us3+2TDjMq/BjoyTdxDLJjL8oxVrskzvf281Igr+w5BXASm4TJLy+gxlY8LmMWkU6JAYRkg9h7/VxWAMvu5ak5Zx9TJUohZPM3btCQOORONGTdtLZ8tHJwhvozNtcPjEEBap8I37KE6hmK4in5EeSVzF3Ahaji8sJDTMr9xf31IMi3rLVdGHN7Do+XAUBnf+da/0RGXtw48xVP7w54Zrb+tmx+FYavBp8PEArRwMg9yDVpTS0NDs1hlSfvjIw==
Received: from PA7P264CA0269.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::19)
 by PASP264MB5787.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:49c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.38; Fri, 17 Apr
 2026 08:31:17 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:375:cafe::36) by PA7P264CA0269.outlook.office365.com
 (2603:10a6:102:375::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 08:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 17 Apr 2026 08:31:17 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id A9B011FFF1;
 Fri, 17 Apr 2026 10:31:17 +0200 (CEST)
From: Yan WANG <yan.wang@softathome.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	alpernebiyasak@gmail.com
Cc: paul.henrys_ext@softathome.com,
	u-boot@lists.denx.de
Subject: [PATCH v7 3/3] tools: binman: Test signing an encrypted FIT with a
 preload header
Date: Fri, 17 Apr 2026 10:30:50 +0200
Message-Id: <20260417083050.499955-4-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260417083050.499955-1-yan.wang@softathome.com>
References: <20260414131558.538656-3-yan.wang@softathome.com>
 <20260417083050.499955-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PASP264MB5787:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ec781d61-415e-4f23-98b3-08de9c5bb23b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|17002099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vl76as4gQ6ejWMohLSMwKJxKtbZopKT3sq9DeqsDXMfdypnJ1SMQOM0Mzy2yltIuo2CW/yBpKoS0KlVbOIqtS4eMui8HSt6watLNHD/dAUKIPZLVS1B/RU23I0rozvsHCCKpUcjzwfslHOcM4VgEEp9edkiBsMs2bIFBX+Uvi7CiCO+8yBEsz579E30NLCi3pVSmYe1gza9BR3NIuAyu6kvz3h4JyAtdC7gMk49lSK8NeehUakMJN5vuq/pT09DvAPqd6Qtrb+yzJGsdcUVbrzzRmXUFIrqlYQX2Fv6A1UjX8XAfVhS0O9NRqIFZrxSBeVFqHopHmlaT7OWphr7V+0rh2h3xBYGGAO/y/XdV2rOvQWjCBc5b+945iamVCXX8NcImKJRPtY9tFwLBqm8VzUEzG1eogU8oq9wJhx5svNDGK2B+NyNeB4agBkeqwYzLbdIFSQpty57YKDbW5baCb/Thfb3Q1M8PRCBPPErQgMCOwbaFnhEnczvHNhSjsZ+rqAC3r7KbZ06T/nKMW8lcvu+ZKcl+5qrynVEPHOysvHoGtlNPjHzNIe9mz/kEguSMux38iTFRk+S4qTlxTsQYa+sCdWr6vaBFBXmu5eMsNrpIDbdrLsnpBINxxcmJOpSrD1e3q15DlB+N1vj97GVoOK9lEeFaGmrOefb7lgH5a9ctij+N0lfxYK8+1LZoBAXCeN/E4gWMh15f6a3BGniRvFL6ao11snT3xBjf8xDc5gEls4uVsjIhJCkMgTIwXpP7NdEqtyrlqrC8PhjAiYEF+w==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(17002099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: px7uSDdEdCIby9U1xtOgLcZ6c78ZXAr0Zsb6ODvMh4t4khZu6+UyCmpIFRIy8tuKQLzpH4T/pxC0TgGhSNJuar5XsrnA8yhOJX+IB8be9SGPV3YEMtOt0BnOcdvYTgXrO7uFG2dBdpE6yHsFq2dyvcy3nbI0XzcDO3QphSebZf4iDTt6u4ZCgk4EVYk0g0QyhdB63IwEheAYFJ5dRZK9Kb+omegGkTJg08C+kIhmtD/SQh2RDLe+Tm5VnKl+mp/DySp1ZhRM/gX4hQZu10/RF/SEFZBXprJrla3qR4LS5MnT7NuwDznWMpy+Sd3FLep2mWGxAJ6nwwi8VQP1hc0QC8QTtgnRtW61w5JpdkzjfTJ9mhrc8hzLI+khjYfz7SOGglS7xdC2s3Vzwo/lxI6BP8F1uwC8ldmvyJDmzKu333Iu1fu47aFhweci34v4TwPg
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 08:31:17.8656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec781d61-415e-4f23-98b3-08de9c5bb23b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5787
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

From: Paul HENRYS <paul.henrys_ext@softathome.com>

Add a test to verify the preload header correctly signs an encrypted
FIT. This test exercises the case where encryption uses random IVs that
would change between mkimage calls.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---

Changes in v7:
- No changes

 tools/binman/ftest.py                         | 21 +++++++
 .../test/security/pre_load_fit_encrypted.dts  | 63 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tools/binman/test/security/pre_load_fit_encrypted.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ca5149ee654..da8325f820a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -5895,6 +5895,27 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             data = self._DoReadFileDtb('security/pre_load_invalid_key.dts',
                                        entry_args=entry_args)
 
+    def testPreLoadEncryptedFit(self):
+        """Test an encrypted FIT image with a pre-load header"""
+        entry_args = {
+            'pre-load-key-path': os.path.join(self._binman_dir, 'test'),
+        }
+        data = tools.read_file(self.TestFile("fit/aes256.bin"))
+        self._MakeInputFile("keys/aes256.bin", data)
+
+        keys_subdir = os.path.join(self._indir, "keys")
+        data = self._DoReadFileDtb(
+            'security/pre_load_fit_encrypted.dts', entry_args=entry_args,
+            extra_indirs=[keys_subdir])[0]
+
+        image_fname = tools.get_output_filename('image.bin')
+        is_signed = self._CheckPreload(image_fname, self.TestFile("dev.key"))
+
+        self.assertEqual(PRE_LOAD_MAGIC, data[:len(PRE_LOAD_MAGIC)])
+        self.assertEqual(PRE_LOAD_VERSION, data[4:4 + len(PRE_LOAD_VERSION)])
+        self.assertEqual(PRE_LOAD_HDR_SIZE, data[8:8 + len(PRE_LOAD_HDR_SIZE)])
+        self.assertEqual(is_signed, True)
+
     def _CheckSafeUniqueNames(self, *images):
         """Check all entries of given images for unsafe unique names"""
         for image in images:
diff --git a/tools/binman/test/security/pre_load_fit_encrypted.dts b/tools/binman/test/security/pre_load_fit_encrypted.dts
new file mode 100644
index 00000000000..f5e9bf9426c
--- /dev/null
+++ b/tools/binman/test/security/pre_load_fit_encrypted.dts
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		pre-load {
+			content = <&image>;
+			algo-name = "sha256,rsa2048";
+			key-name = "dev.key";
+			header-size = <4096>;
+			version = <0x11223344>;
+		};
+
+		image: fit {
+			fit,encrypt;
+			description = "Test a FIT with encrypted data and signed with a preload";
+			#address-cells = <1>;
+
+			images {
+				u-boot {
+					description = "U-Boot";
+					type = "firmware";
+					arch = "arm64";
+					os = "U-Boot";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+					cipher {
+						algo = "aes256";
+						key-name-hint = "aes256";
+					};
+					u-boot-nodtb {
+					};
+				};
+				fdt-1 {
+					description = "Flattened Device Tree blob";
+					type = "flat_dt";
+					arch = "arm64";
+					compression = "none";
+					cipher {
+						algo = "aes256";
+						key-name-hint = "aes256";
+					};
+					u-boot-dtb {
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-1";
+				conf-1 {
+					description = "Boot U-Boot with FDT blob";
+					firmware = "u-boot";
+					fdt = "fdt-1";
+				};
+			};
+		};
+	};
+};
-- 
2.25.1

