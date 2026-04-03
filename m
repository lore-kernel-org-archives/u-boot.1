Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D86CD730B1
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 07:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656DF8407E;
	Fri,  3 Apr 2026 09:33:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="nbaju0Qd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17AA8382A; Fri,  3 Apr 2026 09:33:39 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6AA8382A
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 09:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNozeYs3lzwbkj5MJqaen65jwq0Rst3F4tHVk/fMxLT91mGe0lyGSOCoNs1ZsI28YkY4UvG6vSjjowvJDAsDPVlBJJJBoDIRvsxdzePP7CJ0u4Nzh7G/zK2HaIfNfQH2KMnrFwuPVn1Dv4SLL1cOzRYEMWs+csmmUDwyh9z6GxDLSKvxP2d8E+e0mvU0mn3nSkRfPj4a8R1jHJpGLKjt+OZ5qztRoOeqfABf3qeSZBqzo+ho+2u9et5lk5oPaHfzA8l59Z4WiV9q138dnT0chfLNrgwKR+P9lwe/6zxT7+idWPuoU9Edw8X+OaQQv0E52+kYdwFBJl8idbZpaUeLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjKHR9fWn8V8LabvbbqGetYQDv/vA3oaKK/vfkFQsEU=;
 b=UuHnwLITdJ15SKA1bjNWn4Z26XzReqs2foo6/fAma5u4YQz/tPDyCBvT85UzzeyDo94kUjDew2+G9fTofV/auAxA/047mixTnCJus5+ZXcbSSuC4sKjL0tnqfbL3vWCF3zK6E3rDxRiZY0+hqbhRDH8CIA1Z/S2P8ET7lg6FqBK5cODH0Kd+e87a+VYLFfoi27KiRWSdmDUfwFYt9hPfnXpFQ1JexM1GUnfTQOjlAWeu+I/xtjXOnfh8ZyMaK7m/C08NL9u/kxlEn/NfxZuOUDHZtEByOsq8y+I7YpL9gFnZu3WSMwCyjwgTd841jw8i1d9xbHN8fTpYdWJiz7wbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjKHR9fWn8V8LabvbbqGetYQDv/vA3oaKK/vfkFQsEU=;
 b=nbaju0QdbJeyDHyaQ2BsJK4jEr67IbS8zgrjnTRl550thAdoZKbfo2wfV84XpleMwAuDMpd9MluqWRnHaxT+Qc+iChJuIOchjq4VXxs0vcWa8G7Fa0XH3CTv4CKQexy/GpjkyPXkmGjIisZHcnX75owETPeqMtVsXnXUTC2g66zyXua7FF8jBlEof67XAoPT+X1nBvihe1448dkzsqddodNvxkHkiAO6DKFGuW0ptyjEecBRXjUFuqspmXX0K4oZJAYfQ7NYDNb0x8+ek1nrOijoI3mWW/llomWdURRx6r6ac7UJQ/hYtaOVAW1w5XX8HkCy1Jwpi49hhw0+Q+MSiQ==
Received: from PA7P264CA0007.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2d3::11)
 by PARP264MB4529.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 07:33:35 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3:cafe::2) by PA7P264CA0007.outlook.office365.com
 (2603:10a6:102:2d3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 07:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 3 Apr 2026 07:33:35 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 95A282018F;
 Fri,  3 Apr 2026 09:33:34 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v3 1/3] tools: binman: Test signing an encrypted FIT with a
 preload header
Date: Fri,  3 Apr 2026 09:32:49 +0200
Message-ID: <20260403073251.1051533-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402192431.2421155-1-yan.wang@softathome.com>
References: <20260402192431.2421155-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|PARP264MB4529:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c4d6a841-e8e9-443e-c12d-08de9153506c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|17002099007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: z46loZRJn1AjNkTuY3FyT2V3L5rqfQMtdP/b4Jogyv3FJZKVQhUqyTxqf/uYqXIhxiVQW3idOvOht2W6kSJXMRCu8cP4lC2+fj/I8nmjFnoxKw0a7FIgwl4v6NO/Z15gxuJ75dIjhtZUeJMyt3LLeuHiGQRPSLO8bmpmJoRclDC1D3gfAlhlzXJyQNRlduT0hItQonxrWrmQ7OGnPYTTEGq16OEE3PL6K/SRdFfVBJlNk1uhTz3RqwdY3bh2P6VivrGHKpHL4KuO90N0A5GejjvrrYjiLPf1cx/UoF9XbaXMB51kK+c+oVs+1tbTzeb2IGgyw4XvoLYoMqE3VFcUvVB3RDjY/EmmU9JGXb+S4Ugl9nvVfrmUKqASZ/Ogcw6Vr6JvucFFl3MPNeyrTT/k73zkMe3jwH8bnm61NQQkPUWnRbC18zg/gsSEZEx6LkTt9qIyZ3UpljV5+DbaRE9tuD8Ua7lbiff5hxtoffE/l45/rcACoayIvW3f+CuBVbiiQzm8iq4uobsIWyQxQ0Dv7KBgCswo+XFr5w7Z2evWY+5r/GWxSJgFmdBylQiwdGKmbz4WINl7TVWEyBmady13SUQhg8DWkG3R8o3bi8BTcujCqgcnMfQqV7qK0Y9a864qJvH/ezrYOnFyA6nwDt4QqH5K6r6xwwdv8fg10iVVkLTtCwF76b0DQdwGFAWuv2kAz/yO/qDAJ5tK3VmLagcXqjaDzCqFrXkn6mg+pxlzE7hi/lXgRoynyLMqe5XKcI1/zc41u/EBcEK6fbbrW/Ovbg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(17002099007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HOt1PVmIHWGW2ayD7nz78TbT65CCNhK8s1mvVqku79pMorWe8jxwf+4bPjYhPDyrOPUfcg8tqRdzKvIFxpE2AHIrEnJlt6ptYx9abWBhFMZlP5rz1Mu1yXIDiWNSAYjV4g3F7KKrFfsu7OAseySsD64ZZ8gmEU5lLRE7wpaIvE8X3m97FAXYuv3MrDQI1/2D7bu/lJvQB/opD0GhlWU5t/XyU3CXEOjoF0PcaNKiTWNsKolSAkphnhWdc9KwmmwM8HpYkvhci0nt7uNgKUlEfjv+Lv5mAxiLDhHJqIRLelprgx1Fhf3gl874p4TU2dbYdBuMbR+4tfL09FF6AjW/vJVEVZFkx8Wixz9ruMT7DnrqY+/VDAtyPyjJl8diGAoDT1oB2wQgB2lVBSiOQiGQiHk+D/zQvLvO+NPTO7aLMham5LEcPq87MqKWxJd8TRFU
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 07:33:35.0332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d6a841-e8e9-443e-c12d-08de9153506c
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4529
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

Add a test to verify the preload header correctly signs an encrypted
FIT. This test exercises the case where encryption uses random IVs that
would change between mkimage calls.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
Changes for v3:
- Rebase against 'next' branch
- Move test in tools/binman/test/fit without a numeric prefix
- Update encryption key path passed to _DoReadFileDtb()

 tools/binman/ftest.py                         | 21 +++++++
 .../test/fit/pre_load_fit_encrypted.dts       | 63 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tools/binman/test/fit/pre_load_fit_encrypted.dts

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index ca5149ee654..301c7705837 100644
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
+            'fit/pre_load_fit_encrypted.dts', entry_args=entry_args,
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
diff --git a/tools/binman/test/fit/pre_load_fit_encrypted.dts b/tools/binman/test/fit/pre_load_fit_encrypted.dts
new file mode 100644
index 00000000000..f5e9bf9426c
--- /dev/null
+++ b/tools/binman/test/fit/pre_load_fit_encrypted.dts
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
2.43.0

