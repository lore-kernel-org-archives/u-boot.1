Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D930ACD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E739E84874;
	Mon, 25 May 2026 15:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="d+YUq5NC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF791847C4; Mon, 25 May 2026 15:52:55 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B2C847C8
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiol7oOl1ufOHMb37Y0X1TywBywBm43zyTeJLnbBCGQJ0Mu8gCo8xOZOUXlhiJspepzrM8Wp/5MSyf0qkZXBVaW8vIMv4jdww2nXXauCuZXiCj5FoITFOKzB4hV7DV/Uz8hZX5OZvcoArRmGEWG0lHnW1TuBPgbUSzgmGAmYH4V2kvUoIZeziUXXd8MZVGCgEz+h5Gh33PrTaohKJIGIUbsbFYgEXm3eN+tcXPdk/+eJ20PGRGNSOGhrus/nHxaE8Sj+Ks/UHUzrTTfdyaAoQy7KBSRswlzafrMSNwSAIJgeQcRsb9+OAA3ncEh2AOAycXqetziBxV0wEOH6EdqREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vyM0erR3F651kjECUtmNrAtGal897dtvL1JPw7kFtE=;
 b=LFRArEsa4XXYpzRDSwg9aQVw0VCZFaabeIgF+TmAUcE9D8ArXve7d9NhIgh9Py117XWOGYDXaz3cXjjzbDs+2T7PHeVfqIhCJ7eqDvQXHBbidgXZ6/Ohgb+MhVOAGktNdR87MSZ3Iew6H73om454Kv8daZsXgzDmxsqeFCjDuQDJLy4C6lfeTQfiLTIvMZoVfMX8kc3TrKFyimFrQrISuXbg566mPqcTEb5DCvpdPkhqOHg5yr8LfXMigBidcPYEosikl9EMi3whesGDdpQoNr4lBSJkRn8pzKb/I5HFG4dxr85fD1KqJKkRTF4jnWSYhqhgvnwPauwahNXppxjwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vyM0erR3F651kjECUtmNrAtGal897dtvL1JPw7kFtE=;
 b=d+YUq5NCHoo/T2bJ7dLhJqaTiLJRdbGKAKCymtGPvNTUApa1x0OqHjTnJsbClkPpnAWAcanaLwdmKBWYWbPvFxbv6UbOGKMv3W43NHuAEeZUmjjCoENQFjY05yidA7jty6yTnJGdvFAPluOxxe4YHh9J8cwKPP0RC/bdPt1EBKlk3qKtX5FB8zPhinpCXCkiEPuBgyoskhBtbXx+ItowoU9y7acJgt2OzvHM/fxBhnyOVNTMdf9Zx1+yhfzw6DutmBdSQ13hVomxLuKOLVuUfkpGhiaZX6eHPbEKALPJ/PaiJxZWHI5Wh5htPqzM/G3TCrbNPrMYpI3OiYhTCxTMfA==
Received: from MR1P264CA0193.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:57::11)
 by PA0P264MB7300.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:575::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:52:46 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57:cafe::8c) by MR1P264CA0193.outlook.office365.com
 (2603:10a6:501:57::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 13:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Mon, 25 May 2026 13:52:45 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 89BB620E34;
 Mon, 25 May 2026 15:52:45 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de, Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 08/15] test: vboot: add test for ecdsa
Date: Mon, 25 May 2026 15:52:34 +0200
Message-ID: <20260525135241.88348-9-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525135241.88348-1-philippe.reynes@softathome.com>
References: <20260525135241.88348-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PA0P264MB7300:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c63a18fa-e39a-4b9f-85da-08deba64e67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: VuXHHP1xNL6qjMbF54xMJI/oeFWjtubID4qEaZVaLYQXDuR/738QUMzUZA5EBe7LKJk9304rIN+6tArU3T51dEzKmPMAC+4U0ebT5Gphyt3GDVSg66t+6SzyhV7vM8hWp3LXcAMLfMI6VxqU6eHNe1y1wyVOPRGPQDeC+05moBh5qy6JXi2xYj8i4Ev6XT4Be+Y7VtCVtWuMIex5WqzPLCiayJSEziEDnDPqSKGCFw9rTtram1DjVeU7k6w6BSvnzmim4DyZxxQUXPWS74owaQoh657+tS7JLFEwK6A9w/AX9cSH/My3p0b13ikskt35ivojCwV3NExXduRHF+8NDtzCXU1hYJ5HmlM8//0nI1GlrswQFAscLnhTQZT8wiK04w9r7HXVvg7KhW/qfq/8vPCQqylc8hgJkjT08nHn+gfv1OzxPVykm+JKPVGDZEDRW4//r8Rtrf0BqK+11ek6w52xia8QQ6owLWLqdsB36VsWBc+aP1V96h3WEnzWI0d6wc1Qk9ZQendmNWtbBOSvpYGfhSNCX+CjXp5uiBNUaOcMAOk1kutu3haNu5AqSNu4qWmhMlgxHH0hWiXYiz5v2vOXFStkqpfxBytr4WLfELuDNJFTMoc7qEjwC8WQFcmAcwNoLnVBjSFs0cFRRMtM+y1Rx8vU9FwXKcSg970RRvZd2NG5PlJ3XkvgNw2DKh02lUM1VU46VQ9+cSEZ3ZBT9LQkGHnewIQ3osIrtnINi2M=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zMyCZLDoPU+VVkFp0BEqzuBAmUQ1Imzz5a9BdzNeal+cyWoh6tDaNeTkzWXfmv5b9QmAF54eIW8FkeTfXu6NF4AVFzdgPKMsHSLFozRWJM7OFGbxGtXwp8+cIN2HWmDtDBz5imvq/1F9d42xXs2icqBI2iVJ8R7AxP3PiDCdNJpAQa/rbIqcKClPuOmknX88eScFPsS3GXMcYrQLR3h+oH7jZexqz03JB/SUDrnBINlgT1WCo2DIZMGshczj9E/RcyaEGMHNfbA2uqELXwunrYkV1NoC804U+c9RX4Zylr7kTo4xTBd46xJxxAGI+YPZZiHU2gR772Qta1vIaV5q2EH2dl8A9QEStvZCQP1Oqa8Suz8ieESfXnvQk6kBFpf9/kiawSZgNPOYB54nFrRMqD6l/OQUwzWN9m1my2Z+o/V4/9I+gYjc49z4Ne4anI9x
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:52:45.8816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63a18fa-e39a-4b9f-85da-08deba64e67b
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB7300
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

