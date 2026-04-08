Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82A910F9949
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 15:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46869840AB;
	Wed,  8 Apr 2026 17:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="t43wsovn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2DC838BB; Wed,  8 Apr 2026 17:02:18 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22686838BB
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  8 Apr 2026 17:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Blynj630W1iVjphAfoEC9X0tJyqcdGJiQ1pCyQR83Fo8pKFNddMGCtu5PWWVoniwXfGE8qOWjeayQFId9xErvb7fwlgpinOVE3DRg0mbLUhtuceAlR2+6sETNaliq7TZP174Q6A+Fx1U+6I2UVjIYil6IZQBTeDQUACby7C3vajYGyr60+oHzPcQK0BiP6IivSErBU2rwbCiU0C7t9Dz05GWepjQ45h9tMPb/cuj007CQ1GpVtr4XDnMjExxvsacoIKnk25fQ2jnR6OTfcCLrveWzhoSPZARfYfIhl65G8/UoB8qGWH+G+uWW9OnNfMmP6CS8kZAxzpog/tMvOyjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+XGNEs4XhoUCrBu7LKXt85dpcC9ALXOlQSDrK+56U0=;
 b=P3g99casYxf4BE9r+VnT9cky/30wzlYZdP7afG4MXJCzxDgDvhdAYBfqVBiS1+CO0nZyQALMeOM2YR2IK0jTCKacsZpuBl2kckhUsGfTJtyvfPB9pHzNyCcAdSbCkUusGclBty1xe+2JSLjHQJ2HxtUaqqVl+7fJoHnz6/ZynUu4DxUDcQDoTtZMRZZrnavi0ue/vdUGGzeioEVrlMAL+cB6U6CXJVTPydgebF7+Q+O/Hb6Ut+TqQWOI9Y+FQ4WTCGrpDP8SOx0/p2vZp2cRfeEGPjqjfJCXyaQOx7bKDqWb2OEoMu7widDtTvZA/ReCsqHGecPkj/HGlIuWZeczfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+XGNEs4XhoUCrBu7LKXt85dpcC9ALXOlQSDrK+56U0=;
 b=t43wsovnW7DRCpINOLDDiUlkocjPwhvG1xTtVETUuFz9rjYey0ohg6/4L9UN9dMEZEXoN/sEd8OBKoMsklJiiIXrCBE7L4X6qyjOleJ+/va1r1Se5Cz9ST6GE1ka72KoKykgvpfWz+vWUNABpynFEriKUnASaRFf72Ie+KZZUoiLotOmKa7HklMQ3rvz6bjdj1VGpAlVpwScHMiuvugpa2YsM0kU4RzC+ThFZ9xfVmv9vX+V2FqanlPjbdSw+ZQxygXYyqoWjIf88sPBVIBM6dzXJ9FVhWaPrZmMcweNWQjTNJ65nu4qxXWIE0MsNdnPqfOhF/K4Ew2aMeZlwHaUFQ==
Received: from PA7P264CA0321.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::24)
 by PR0P264MB2600.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 15:02:14 +0000
Received: from PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395:cafe::2) by PA7P264CA0321.outlook.office365.com
 (2603:10a6:102:395::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 15:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019230.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Wed, 8 Apr 2026 15:02:13 +0000
Received: from sah2lpt245.. (unknown [192.168.72.183])
 by proxy.softathome.com (Postfix) with ESMTPSA id EDF01209C3;
 Wed,  8 Apr 2026 17:02:09 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, trini+nodisclaimer@konsulko.com,
 alpernebiyasak+nodisclaimer@gmail.com,
 philippe.reynes+nodisclaimer@softathome.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v5 3/3] tools: binman: Test signing an encrypted FIT with a
 preload header
Date: Wed,  8 Apr 2026 17:02:01 +0200
Message-ID: <20260408150201.217942-4-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408150201.217942-1-paul.henrys_ext@softathome.com>
References: <20260403075528.1150196-3-paul.henrys_ext@softathome.com>
 <20260408150201.217942-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019230:EE_|PR0P264MB2600:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4b323b71-d7f4-4c10-4eef-08de957fd15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|22082099003|17002099007|56012099003;
X-Microsoft-Antispam-Message-Info: C6UwUyc158MdVETUre3k/4/udEaXkcUaz7cOiugon+2qh+IeuNIC5nerhhWZ3bC02S909z2qgcU5h4zFLnr6iLND95ccpgdvhpcCJ/NoI81euJJDu5YrSrtTEMbytY24Vx/4mihHIcI5Sb85906J9+NvAL8F+/4+ncrWCt8jSMqYqEFLoXlWz3xuZTECHk8g3NDfbwSEVakdA0Ar5abE34a0VSdO5xa4jCuHb5uQja5afjY1sA7dhzOhLaSPUKABAFIGgeiE3BCJpOyHg6MlWFpfsEHRPd27nbYC/Lsz53Z0nBfw2fgVjFiY2XqfiSg99VQxMtuemfr1NvLCmnRUSqb/i8ZCf8UuIIXnBmWFybVavlQTyp4gb0K2i6qKAEjPH5rtyvcQG+IziNlJ8ZRRmOEhmV5kT9G8ZsEgjDuM6m2rwdjPyhq5UPtJn80HvifCjROaSqeDe09819aRfMAZNvty0yabQ0wiacT41zH7c/jOLnLZ3drHUgRF0fCtT8BYgDjiQyzPL+DlnSxg1e5s1rKX8InkwDubnm/eYw7mwC2WCqyYk46zTydkR9kjL2uvM5x/ICt4Cxo+/6XfzSVdoo414/wpm9a+tcJKyL7T1BIslrvoymQVVMNEGlkgGWKLjugODryDKepiildvKKHGfdKmuKi/WL3mXeJAabXgpjdDbqP/VAMFAvOdws8h7kxk5tkgutLX8FHIIJFLKyNSST8zzveOoKzA6SfIBlmYcZ/O/1wacd+osiTWe6xl5ktRLO6PfYnRG/rGVY4v4As7YA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(17002099007)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +dHaxyVjeHJxAnR7WEtMBpNbY5MirTmSq8AY5+c+ltukfpXV+gok++HL9tO0aiO29/TVFB9V97tRlY5rqtNJSFhciIiwaz6eE7UtE5ay6L1bLEmgZEgd/15cxhZQC0rWSkyuhwoH1YePGWQWrDCUBqI37II0fnfjFQyTB5xd8rnMQVvtQvxJeANQ33zPdyHgQmTfzkaRhVt8/R7kb5yCIVqTZunOxPYN2UguL0PUy8wQm/r1GeOKIDxLG+In+WXloo8IvVkXc57uz5CorWw/9mpGee6hGWsI6HTKy+zsqC6S0zxbltweJhVqgpi8MEd2Aw0AzdDvR6Fqgoaa/qAjlM9eFDFmh9zPlbTfeASiv6mtyqDUpk6mhX9zVpAe+gC5wvL3Y66womt+FaPViUhXsOt06oXcaZY7Wt5u6A6xasNrT9Z3uIOET+0PIhl07qqp
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 15:02:13.6258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b323b71-d7f4-4c10-4eef-08de957fd15b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019230.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2600
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

Changes in v5:
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
2.43.0

