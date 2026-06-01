Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2358CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492DD84976;
	Mon,  1 Jun 2026 15:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="Fp9iq+Pz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FFF848E2; Mon,  1 Jun 2026 15:43:23 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A55984912
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOGB+N8S2V3UnhwPZNEsSD6P5iDpGPyIWQixM/Z9cAK5fKpOC2cpjUqT/acQbd6zoFbmGcyG7Q+1oof34hHxPHprVAiULPe5wFEdoPP2BLJQyO1IdHuQ3fJNshGmtWgy8IlGW7XP/ylI+qDr8/dNfI7HKE6QEP4qqMosmnX92tuQIBtm2mfpwgvJn91oq6NNmqECovk6q8EpbLA25TSmIqdF8CwkUGCUErfyehkTnJwcaypoW9l61CFKZ5JsHbNisRW5qVvj26c4lu5ZqLjmIj1G5DD8W0NRjVAsY1+Dk1q4Uw+wqa1wFjf/x8ouqwDKe26wDp66CJHEO0i2Lm8QRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ovx/CXyNU6TC/6AmVIEAV16hVtEAibo1XZQWhQPaGos=;
 b=sysFDMGGqAWDP3u+47NusERJc7xCwFErKhwQC7f36A6WWZ/m3TbU1kGCVSij5AHvJsFFLdwqir7cvgcM2AKLK+LfnToC1Lf4C5CeR4W9xqv93XsaTkjZBwxoFpw+k39KZHy2JxhVpPgVM7ARhAk5q000o1raf+LF+L2lU0KBEyJ1chl21X/6mcVDlEIgQPkz6Gs1Y/PUCt/pSbu48raaA84OpPjTkR20WKohZ32QyLPcXnVTIvEmh3+7OiNz27gFstw9DmC0uOjO0EVMMy4AC2cV2Y9IT9jA3wqdGaELcy8nrJ6ToYpqdfgBP1lA0wreIbfdG+UA/etRVb4iTrlheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovx/CXyNU6TC/6AmVIEAV16hVtEAibo1XZQWhQPaGos=;
 b=Fp9iq+Pz1JJkygYnSmALl/q4xB3JAHPXUC3TtsFmn7c4AqP3sKd77Cg6RQkC9TUBPA/iW2mky6SEWhbssK/3MRvUbf4IYxQ6kh748gxCzAU74czZRfCxqqkYRWWl9zyMPSh1802kmow/STiDnuBUWG7/po3cnnT5gRY3PZSUNbROdDUyu96B+gh9GEkZTKJneYIgn/jJdPKgI21SnMY1J4JJatuDMzzi/l1CuXjNX9aJQUT1F/5rZwR/2IR4Trja1zuPt83dy7v5WRB82G1Fzv2OTJiWMXdiNLzvTGdBqaAw6Js7wnxOctDJG8f9EhL+ov+NsLbrcw4ZO/SVg/AEJQ==
Received: from MR1P264CA0006.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2e::11)
 by PR0P264MB1900.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:43:16 +0000
Received: from MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e:cafe::99) by MR1P264CA0006.outlook.office365.com
 (2603:10a6:501:2e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 13:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D5A.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Mon, 1 Jun 2026 13:43:16 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 86D3B2141B;
 Mon,  1 Jun 2026 15:43:15 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v8 08/15] test: vboot: add test for ecdsa
Date: Mon,  1 Jun 2026 15:43:03 +0200
Message-ID: <20260601134310.2452454-9-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601134310.2452454-1-philippe.reynes@softathome.com>
References: <20260601134310.2452454-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D5A:EE_|PR0P264MB1900:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3b6e3c5a-c1b0-4072-fe3e-08debfe3bbc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: jQVakopUi++d9xdm+RMGy+bAkkHpENtKTwYu30OJV9uxFJ80K4FzXxwYUUCCFgN/H02ht1gHfhmdGwQxtX2WMRj7E5VSCgz9Pz5knaHXcwlJx197GrXZ6HQfYOpFNarsPhLGB8ICBa32mq7jNiutuoTNEX5wPXb/mzBjW2wMCb7EqcAvnGkel9uQuLzAcIZPjxB1tQxZEsnUOJeQ2GidI9IoIc2heCXPG+5aUonxGSlVAHPCyhtqHhB5MSGvZKYX02enDY8jBZuD5Zz3ar1TS9TfTYJps6yqVrj8r4tSJuF12GlfSjNC2xyUqD8nV4X/n9DW5RY5OKFvS3Uqjplz0Z4QP+yb2mfmf0s4l2xlq5xWCRms8szGNvBEDXro4mXwlqSb8A5VDnGDaosEquuPGSauXQGqPBaN/v8bfh1zYaKpuR+JILzYRoRZhy1E9Ps1bkNU00AGbDaDmxFoRBk2f/4ZM+Yw4QfGLrGggbXjY13BfTZVMymgI9E2JZWlOBy2XopwYotsB4K7dccnDyIo7LIXQG30ozi8v+ne8UFz5SjsVrSn08OtZXCKXlaL7TXCUQi1qrjqpnTDxQdnmrj9t2ZlvM6IwVqD35FLjnVbeZ+p44igNsCIFvtopvp7l2RlCS/2o4KyQWnCnL2Af/eHt6U9hq6T1Av2UducOgZ/vAbJmra3kJ3YZWh4Kxh5n0G9dZ7reS/Sqda2/oVdw1nimQHtCrxgL7n4Fxf7PtDNy34=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LmrFt7nczfDMjT+pPvav4OPgksEj6WnsjAJfFUbP/JvaxILj3A9UcM6ItOsZz+t2YFOfri5ib85pKrhEXEc1wx1Q/+hiRdCUtd+Ski5gSx3OAp7Xtt2lvFce4IFOWd9NH+TxaJlkMNkhkFPtLaKXWp1N0NwRo78K/jjcQdHVUPM1yF491rOox5o1gXWOVEU6v4F2fTphzhn9XThyo4j4Is/eco314JC1VLGp6ZVFYAQ2C3Sh7EF7AXVZc+f5TNOCHzXG7WqMjgbi0qiu29dfCZYd6UUOUR8H6Wijnp0TDdpxQzGW++GPgGQItOZD6fglBV8D//GlOgGQ4cRiay1tyOR9o/SY4OQajxSG8zxS2P8/tdszvqqswggkkSoKDBBa00psDEGlqFjhsNolJxJN/wzHDcjJgiRIL11H8KiqHPPnezeQ1lQZjLExUCZj7Nu2
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:43:16.1484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6e3c5a-c1b0-4072-fe3e-08debfe3bbc8
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D5A.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1900
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

This commit adds test case for ecdsa on fit, but not (yet) for
the global image signature (preload).

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version
v3:
- no change
v4:
- no change
v5:
- no change
v6:
- no change
v7:
- no change
v8:
- no change

 test/py/tests/test_vboot.py                   | 29 ++++++++++++
 .../vboot/sign-configs-sha256-ecdsa256.its    | 45 +++++++++++++++++++
 .../vboot/sign-configs-sha256-ecdsa384.its    | 45 +++++++++++++++++++
 .../vboot/sign-configs-sha256-ecdsa521.its    | 45 +++++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa256.its     | 42 +++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa384.its     | 42 +++++++++++++++++
 .../vboot/sign-images-sha256-ecdsa521.its     | 42 +++++++++++++++++
 7 files changed, 290 insertions(+)
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its

diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 496d314c649..4e4d9529031 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -94,6 +94,9 @@ TESTDATA_IN = [
     ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
     ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False],
     ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False],
+    ['sha256-basic-ecdsa256', 'sha256', '-ecdsa256', '', None, False, False, False, False],
+    ['sha256-basic-ecdsa384', 'sha256', '-ecdsa384', '', None, False, False, False, False],
+    ['sha256-basic-ecdsa521', 'sha256', '-ecdsa521', '', None, False, False, False, False],
     ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False],
     ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False],
     ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
@@ -287,6 +290,29 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
                           '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
+    def create_ecdsa_pair(name):
+        """Generate a new ECDSA key pair
+
+        Args:
+            name: Name of the key (e.g. 'dev')
+        """
+
+        if sig_algo == "-ecdsa256":
+            curve_name = "secp256r1"
+        elif sig_algo == "-ecdsa384":
+            curve_name = "secp384r1"
+        elif sig_algo == "-ecdsa521":
+            curve_name = "secp521r1"
+        else:
+            curve_name = "unknownCurve"
+
+        utils.run_and_log(ubman, 'openssl ecparam -name %s -genkey -noout -out %s%s.pem' %
+                     (curve_name, tmpdir, name))
+
+        # Create a certificate containing the public key
+        utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.pem '
+                          '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
+
     def test_with_algo(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
@@ -537,6 +563,9 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
     if sig_algo == "-rsa2048" or sig_algo == "-rsa3072" or sig_algo == "":
         create_rsa_pair('dev')
         create_rsa_pair('prod')
+    elif sig_algo == "-ecdsa256" or sig_algo == "-ecdsa384" or sig_algo == "-ecdsa521":
+        create_ecdsa_pair('dev')
+        create_ecdsa_pair('prod')
 
     # Create a number kernel image with zeroes
     with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
new file mode 100644
index 00000000000..4d0ef903a78
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
@@ -0,0 +1,45 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+				sign-images = "fdt", "kernel";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
new file mode 100644
index 00000000000..10427b43659
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
@@ -0,0 +1,45 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+				sign-images = "fdt", "kernel";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
new file mode 100644
index 00000000000..a65593ec64b
--- /dev/null
+++ b/test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
@@ -0,0 +1,45 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+				sign-images = "fdt", "kernel";
+			};
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa256.its b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
new file mode 100644
index 00000000000..009003bb601
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa256.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa256";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa384.its b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
new file mode 100644
index 00000000000..567de687a06
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa384.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa384";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
diff --git a/test/py/tests/vboot/sign-images-sha256-ecdsa521.its b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
new file mode 100644
index 00000000000..74ed45b21b8
--- /dev/null
+++ b/test/py/tests/vboot/sign-images-sha256-ecdsa521.its
@@ -0,0 +1,42 @@
+/dts-v1/;
+
+/ {
+	description = "Chrome OS kernel image with one or more FDT blobs";
+	#address-cells = <1>;
+
+	images {
+		kernel {
+			data = /incbin/("test-kernel.bin");
+			type = "kernel_noload";
+			arch = "sandbox";
+			os = "linux";
+			compression = "none";
+			load = <0x4>;
+			entry = <0x8>;
+			kernel-version = <1>;
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+		fdt-1 {
+			description = "snow";
+			data = /incbin/("sandbox-kernel.dtb");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "none";
+			fdt-version = <1>;
+			signature {
+				algo = "sha256,ecdsa521";
+				key-name-hint = "dev";
+			};
+		};
+	};
+	configurations {
+		default = "conf-1";
+		conf-1 {
+			kernel = "kernel";
+			fdt = "fdt-1";
+		};
+	};
+};
-- 
2.43.0

