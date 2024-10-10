Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F72CF11E9
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 12:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64A448905E;
	Thu, 10 Oct 2024 14:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="gndTrNGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 474D788FB5; Thu, 10 Oct 2024 13:25:50 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA7188E14
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 13:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brian.ruley@gehealthcare.com
Received: from pps.filterd (m0047963.ppops.net [127.0.0.1])
 by m0047963.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id
 49A8H3A5046124
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 outbound; bh=pR8aggk1hLNM0Z0cYwA/YUu5Zve9/L65xvBIWH5+PRs=; b=gnd
 TrNGH6x1U8LKlx7pkiGcRKvkCHhOvhY1HUVvbrANL5TB7+RD2bL5inAFxH1M5aEI
 fE0ZB7IgCE/Px1DoucW+Y87R0WNrjBorKh6l5HM/KBdXrggt57S/JYfBITOtA9LO
 Ocqbc0u8UsLlIaVPYw0MWhe6tWmgsRsL2+2ZM+YaBHPk+QijbwdcbkCYPgjjxt+e
 SUIPDkwrG91gqyTaZv5QVlh6WC/1ADJxQRlUWGQbtxDK8iRAO2cs8gJIWOMWfQp3
 1jD0vmHuJAzOjgiThN4CrArSyTFFZ1MVM1YbqYwAQO92S15vJqBDBr7YpzqJou6w
 udXWKsBVTwzaJzHoRjw==
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: ian.ray@gehealthcare.com, Brian Ruley <brian.ruley@gehealthcare.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/2] binman: expand test coverage to nxp_imx8mcst
Date: Thu, 10 Oct 2024 14:24:50 +0300
Message-Id: <20241010112451.27242-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241010112451.27242-1-brian.ruley@gehealthcare.com>
References: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
 <20241010112451.27242-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Dc3c6LyBgvSkip47UNvvs97PsGVDpLAI
X-Proofpoint-GUID: Dc3c6LyBgvSkip47UNvvs97PsGVDpLAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_08,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100076
X-Mailman-Approved-At: Thu, 10 Oct 2024 14:50:10 +0200
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

Add coverage for IMX8M code siging. Create PKI tree and other assets
required by `cst' using `hab4_pki_tree.sh' script and `srktool' in
`cst_3.4.1' [1].

[1] https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
Changes for v2:
- Added missing *.pem files
- Rebased on top of "[PATCH v4 2/2] binman: add fast authentication
  method for i.MX8M signing" 
- Included a test for fast authentication

 tools/binman/ftest.py                         |  11 ++
 tools/binman/test/340_nxp_imx8mcst.dts        |  58 +++++++++
 .../test/341_nxp_imx8mcst_fast_auth.dts       |  18 +++
 .../CSF1_1_sha256_4096_65537_v3_usr_crt.pem   | 121 ++++++++++++++++++
 .../IMG1_1_sha256_4096_65537_v3_usr_crt.pem   | 121 ++++++++++++++++++
 .../SRK1_sha256_4096_65537_v3_usr_crt.pem     | 121 ++++++++++++++++++
 tools/binman/test/cst/crts/SRK_table.bin      | Bin 0 -> 531 bytes
 .../test/cst/crts/SRK_table_fast_auth.bin     | Bin 0 -> 531 bytes
 .../CSF1_1_sha256_4096_65537_v3_usr_key.pem   |  54 ++++++++
 .../IMG1_1_sha256_4096_65537_v3_usr_key.pem   |  54 ++++++++
 .../SRK1_sha256_4096_65537_v3_usr_key.pem     |  54 ++++++++
 tools/binman/test/cst/keys/key_pass.txt       |   2 +
 12 files changed, 614 insertions(+)
 create mode 100644 tools/binman/test/340_nxp_imx8mcst.dts
 create mode 100644 tools/binman/test/341_nxp_imx8mcst_fast_auth.dts
 create mode 100644 tools/binman/test/cst/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
 create mode 100644 tools/binman/test/cst/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
 create mode 100644 tools/binman/test/cst/crts/SRK1_sha256_4096_65537_v3_usr_crt.pem
 create mode 100644 tools/binman/test/cst/crts/SRK_table.bin
 create mode 100644 tools/binman/test/cst/crts/SRK_table_fast_auth.bin
 create mode 100644 tools/binman/test/cst/keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem
 create mode 100644 tools/binman/test/cst/keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem
 create mode 100644 tools/binman/test/cst/keys/SRK1_sha256_4096_65537_v3_usr_key.pem
 create mode 100644 tools/binman/test/cst/keys/key_pass.txt

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index e3f231e4bc..add3b9318d 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -219,6 +219,10 @@ class TestFunctional(unittest.TestCase):
         shutil.copytree(cls.TestFile('yaml'),
                         os.path.join(cls._indir, 'yaml'))
 
+        # NXP Code Signing tool
+        shutil.copytree(cls.TestFile('cst'),
+                        os.path.join(cls._indir, 'cst'))
+
         TestFunctional._MakeInputFile('compress', COMPRESS_DATA)
         TestFunctional._MakeInputFile('compress_big', COMPRESS_DATA_BIG)
         TestFunctional._MakeInputFile('bl31.bin', ATF_BL31_DATA)
@@ -7804,6 +7808,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpImx8mCst(self):
+        """Test that binman can sign an iMX8M image"""
+        self._DoTestFile('340_nxp_imx8mcst.dts')
+
+    def testNxpImx8mCstFastAuth(self):
+        """Test that binman can sign an iMX8M image using fast authentication"""
+        self._DoTestFile('341_nxp_imx8mcst_fast_auth.dts')
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/340_nxp_imx8mcst.dts b/tools/binman/test/340_nxp_imx8mcst.dts
new file mode 100644
index 0000000000..49ab943ff7
--- /dev/null
+++ b/tools/binman/test/340_nxp_imx8mcst.dts
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mcst {
+			args;	/* Needed by mkimage etype superclass */
+			filename = "test-fit.signed.bin";
+			nxp,loader-address = <0x10>;
+			nxp,srk-table = "SRK_table.bin";
+			nxp,img-crt = "IMG1_1_sha256_4096_65537_v3_usr_crt.pem";
+			nxp,csf-crt = "CSF1_1_sha256_4096_65537_v3_usr_crt.pem";
+
+			fit {
+				description = "test desc";
+				filename = "test-fit.itb";
+				#address-cells = <1>;
+
+				images {
+					u-boot {
+						description = "test u-boot";
+						type = "standalone";
+						arch = "arm64";
+						os = "u-boot";
+						compression = "none";
+						load = <00000000>;
+						entry = <00000000>;
+
+						u-boot-nodtb {
+						};
+					};
+
+					fdt-1 {
+						description = "test fdt";
+						type = "flat_dt";
+						compression = "none";
+
+						u-boot-dtb {
+						};
+					};
+				};
+
+				configurations {
+					default = "config-1";
+					config-1 {
+						description = "test config";
+						fdt = "fdt-1";
+						firmware = "u-boot";
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/tools/binman/test/341_nxp_imx8mcst_fast_auth.dts b/tools/binman/test/341_nxp_imx8mcst_fast_auth.dts
new file mode 100644
index 0000000000..c1b01d8780
--- /dev/null
+++ b/tools/binman/test/341_nxp_imx8mcst_fast_auth.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+#include "340_nxp_imx8mcst.dts"
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		nxp-imx8mcst {
+			nxp,fast-auth;
+			nxp,srk-table = "cst/crts/SRK_table_fast_auth.bin";
+			nxp,srk-crt = "cst/crts/SRK1_sha256_4096_65537_v3_usr_crt.pem";
+		};
+	};
+};
diff --git a/tools/binman/test/cst/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem b/tools/binman/test/cst/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
new file mode 100644
index 0000000000..bcf7748035
--- /dev/null
+++ b/tools/binman/test/cst/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem
@@ -0,0 +1,121 @@
+Certificate:
+    Data:
+        Version: 3 (0x2)
+        Serial Number: 305419897 (0x12345679)
+        Signature Algorithm: sha256WithRSAEncryption
+        Issuer: CN=SRK1_sha256_4096_65537_v3_ca
+        Validity
+            Not Before: Oct 10 09:06:13 2024 GMT
+            Not After : Oct  4 09:06:13 2049 GMT
+        Subject: CN=CSF1_1_sha256_4096_65537_v3_usr
+        Subject Public Key Info:
+            Public Key Algorithm: rsaEncryption
+                Public-Key: (4096 bit)
+                Modulus:
+                    00:a2:10:7d:42:03:21:4f:44:59:27:30:8f:2d:58:
+                    ff:7a:d7:7f:e3:f7:bd:54:4d:d2:02:3d:29:68:6c:
+                    d7:b8:64:e7:7a:69:42:83:e6:c7:97:1d:80:1b:21:
+                    db:c5:c5:4f:38:b8:94:e3:4e:1b:d2:77:76:d4:24:
+                    4b:e6:3c:5d:7b:5b:ca:f7:b7:c8:ab:11:22:3d:e4:
+                    50:97:2b:39:bd:3a:83:6b:6f:62:e9:b5:81:25:8a:
+                    6a:3c:02:d2:87:ea:87:cb:4e:26:13:23:3a:3d:e6:
+                    87:d7:5e:5e:db:13:94:b2:04:f0:7a:e8:e5:0e:86:
+                    e0:53:7f:fd:ad:62:5e:4e:af:e5:96:2a:65:ba:cc:
+                    07:e7:2c:da:a3:bb:e4:02:d6:35:bb:c3:bf:f7:86:
+                    22:a6:01:4b:5c:48:b9:09:de:b3:51:89:ce:a9:f2:
+                    7c:b3:41:06:4e:e0:45:90:ac:1f:66:41:0e:7f:64:
+                    5d:5b:76:06:9a:6f:4d:50:50:30:27:93:48:c8:fa:
+                    07:cb:0c:65:b5:c3:c8:fb:08:f4:8f:6b:a2:9d:be:
+                    f8:43:75:62:da:87:45:96:70:4f:d0:75:1a:30:e9:
+                    69:12:95:43:c7:7a:0e:86:81:5c:c2:52:51:b6:97:
+                    94:8c:5c:ad:0d:a8:9c:47:15:c1:98:c7:ea:16:a9:
+                    2a:86:7d:8a:2f:fa:b4:e1:f0:02:aa:3d:c8:78:65:
+                    aa:6c:bb:5a:59:5a:ca:37:6e:43:87:a2:31:af:5d:
+                    e1:a0:d5:48:5a:8e:b3:d1:06:27:08:d0:c7:17:89:
+                    7c:9b:e1:0c:83:da:37:54:5c:1a:52:1e:1e:ad:52:
+                    09:60:7a:a7:e9:3f:79:98:76:d5:be:2c:ce:f9:f9:
+                    34:24:9b:03:6c:dd:21:71:63:b6:7c:ab:78:32:f2:
+                    cb:b6:bb:31:e6:6c:86:46:4d:61:98:0c:24:9e:5d:
+                    cf:7f:27:da:00:2d:f6:d3:4e:e1:7e:aa:c8:02:e0:
+                    12:24:5e:ca:da:6d:05:65:e6:4f:69:f4:00:be:1b:
+                    f4:38:96:95:26:59:40:47:a9:2f:b3:20:f4:1c:f4:
+                    5a:fd:c1:5e:d9:84:c3:60:ed:4b:f6:20:50:28:8a:
+                    92:76:25:a9:67:d6:2c:69:0b:34:69:3b:2a:7d:95:
+                    7f:05:ee:7b:6c:dd:b1:d1:f3:9a:70:41:e3:bc:15:
+                    be:dd:94:80:5d:68:62:06:b3:ef:f0:ba:43:aa:e4:
+                    f5:1d:d9:e2:81:17:8f:20:1e:b6:cb:ef:a6:d4:e5:
+                    c0:a8:18:24:93:de:9c:87:94:9c:2f:53:5f:1a:ee:
+                    f5:48:32:73:94:ac:5e:95:22:fb:c4:88:4a:01:b9:
+                    84:77:19
+                Exponent: 65537 (0x10001)
+        X509v3 extensions:
+            X509v3 Basic Constraints: 
+                CA:FALSE
+            Netscape Comment: 
+                OpenSSL Generated Certificate
+            X509v3 Subject Key Identifier: 
+                12:27:B4:37:71:97:BD:29:01:41:56:E6:09:4E:E8:34:69:0A:48:C7
+            X509v3 Authority Key Identifier: 
+                C3:28:CB:E3:D9:35:AB:F9:39:04:2A:3A:52:B2:B6:49:20:D0:C3:3B
+    Signature Algorithm: sha256WithRSAEncryption
+    Signature Value:
+        96:1d:02:b1:8b:b5:1f:f0:a5:c0:5b:0a:3f:70:54:31:58:c9:
+        0e:0f:3d:ea:99:f6:45:c2:c2:84:78:08:62:ba:59:69:34:61:
+        09:78:bf:68:ac:fe:3a:a2:39:5e:71:ca:b0:f0:a6:93:b0:4b:
+        b8:be:d1:9f:46:85:18:fa:ea:a1:92:39:37:b5:61:a5:71:ed:
+        7e:40:50:a3:d4:3f:81:94:b8:55:fd:13:1a:e4:97:e6:d7:ca:
+        65:a4:cb:cb:3f:41:e5:d1:2d:ca:8a:c3:5e:29:a6:e2:0b:f4:
+        28:4b:9b:53:e7:f5:6c:1f:10:2e:86:aa:f5:15:76:bc:93:94:
+        c4:6e:05:ad:87:d2:eb:0e:16:cf:2b:ff:bc:a5:53:d0:e0:12:
+        65:86:ba:29:98:a1:28:4a:62:f9:22:40:8b:fd:34:a6:27:0c:
+        99:d4:ee:bf:46:07:35:ae:ba:7d:b7:d2:f2:34:d8:90:c3:b2:
+        1e:31:78:b5:f3:df:fc:44:8a:3a:83:2a:cf:d4:50:5a:1b:95:
+        1e:6f:61:6a:33:9e:44:29:54:54:72:9c:15:fa:54:9f:4e:a4:
+        ef:8a:9f:42:a2:02:99:26:b5:53:6b:f0:05:68:8b:a5:28:60:
+        52:0f:52:c0:06:ca:eb:84:0e:99:ff:36:6d:7f:83:f8:a7:2c:
+        d3:b4:fb:dd:98:4e:e7:f7:99:c1:ea:7e:3b:46:0b:19:43:f3:
+        2f:9d:ad:4a:e5:0b:d9:2f:29:0b:47:be:3c:7c:82:5a:e6:0a:
+        3f:9f:3e:09:cb:bc:4a:47:c2:a0:d0:2f:c5:95:a4:da:11:e4:
+        08:f3:f6:43:52:08:fc:6b:66:9c:ec:75:89:59:ba:e4:ac:cf:
+        0a:96:86:65:cc:77:c7:0a:68:7e:ab:9e:58:78:a8:e7:d1:5f:
+        b4:92:4a:93:76:2b:6b:82:0c:87:ad:45:27:30:26:10:ff:3d:
+        df:ff:87:f9:86:60:3c:15:3f:25:a7:6a:e0:cd:20:f2:e1:aa:
+        5e:20:6b:f6:11:43:28:fc:2d:87:c9:29:3b:d5:d7:c3:42:30:
+        be:5a:45:6e:6a:d9:c8:d1:ae:a3:3f:84:89:7a:ba:c2:7e:6f:
+        2f:f3:32:78:05:fe:bf:c2:dc:44:b0:b2:7c:bb:c3:b3:cf:8a:
+        15:47:c4:f8:72:a9:96:c8:7c:82:fc:4d:82:d0:9c:2a:1d:6b:
+        87:c2:74:a4:33:fd:0e:31:f0:e6:43:8d:23:c7:5b:fd:dd:ac:
+        c0:c2:99:da:19:07:58:d7:90:06:9a:e8:11:84:68:3c:60:12:
+        7d:7e:26:9d:fb:cc:e5:60:2f:2f:39:14:cb:95:20:a1:88:90:
+        8e:c4:36:8b:89:3e:21:32
+-----BEGIN CERTIFICATE-----
+MIIFSjCCAzKgAwIBAgIEEjRWeTANBgkqhkiG9w0BAQsFADAnMSUwIwYDVQQDDBxT
+UksxX3NoYTI1Nl80MDk2XzY1NTM3X3YzX2NhMB4XDTI0MTAxMDA5MDYxM1oXDTQ5
+MTAwNDA5MDYxM1owKjEoMCYGA1UEAwwfQ1NGMV8xX3NoYTI1Nl80MDk2XzY1NTM3
+X3YzX3VzcjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAKIQfUIDIU9E
+WScwjy1Y/3rXf+P3vVRN0gI9KWhs17hk53ppQoPmx5cdgBsh28XFTzi4lONOG9J3
+dtQkS+Y8XXtbyve3yKsRIj3kUJcrOb06g2tvYum1gSWKajwC0ofqh8tOJhMjOj3m
+h9deXtsTlLIE8Hro5Q6G4FN//a1iXk6v5ZYqZbrMB+cs2qO75ALWNbvDv/eGIqYB
+S1xIuQnes1GJzqnyfLNBBk7gRZCsH2ZBDn9kXVt2BppvTVBQMCeTSMj6B8sMZbXD
+yPsI9I9rop2++EN1YtqHRZZwT9B1GjDpaRKVQ8d6DoaBXMJSUbaXlIxcrQ2onEcV
+wZjH6hapKoZ9ii/6tOHwAqo9yHhlqmy7WllayjduQ4eiMa9d4aDVSFqOs9EGJwjQ
+xxeJfJvhDIPaN1RcGlIeHq1SCWB6p+k/eZh21b4szvn5NCSbA2zdIXFjtnyreDLy
+y7a7MeZshkZNYZgMJJ5dz38n2gAt9tNO4X6qyALgEiReytptBWXmT2n0AL4b9DiW
+lSZZQEepL7Mg9Bz0Wv3BXtmEw2DtS/YgUCiKknYlqWfWLGkLNGk7Kn2VfwXue2zd
+sdHzmnBB47wVvt2UgF1oYgaz7/C6Q6rk9R3Z4oEXjyAetsvvptTlwKgYJJPenIeU
+nC9TXxru9Ugyc5SsXpUi+8SISgG5hHcZAgMBAAGjezB5MAkGA1UdEwQCMAAwLAYJ
+YIZIAYb4QgENBB8WHU9wZW5TU0wgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1Ud
+DgQWBBQSJ7Q3cZe9KQFBVuYJTug0aQpIxzAfBgNVHSMEGDAWgBTDKMvj2TWr+TkE
+KjpSsrZJINDDOzANBgkqhkiG9w0BAQsFAAOCAgEAlh0CsYu1H/ClwFsKP3BUMVjJ
+Dg896pn2RcLChHgIYrpZaTRhCXi/aKz+OqI5XnHKsPCmk7BLuL7Rn0aFGPrqoZI5
+N7VhpXHtfkBQo9Q/gZS4Vf0TGuSX5tfKZaTLyz9B5dEtyorDXimm4gv0KEubU+f1
+bB8QLoaq9RV2vJOUxG4FrYfS6w4Wzyv/vKVT0OASZYa6KZihKEpi+SJAi/00picM
+mdTuv0YHNa66fbfS8jTYkMOyHjF4tfPf/ESKOoMqz9RQWhuVHm9hajOeRClUVHKc
+FfpUn06k74qfQqICmSa1U2vwBWiLpShgUg9SwAbK64QOmf82bX+D+Kcs07T73ZhO
+5/eZwep+O0YLGUPzL52tSuUL2S8pC0e+PHyCWuYKP58+Ccu8SkfCoNAvxZWk2hHk
+CPP2Q1II/GtmnOx1iVm65KzPCpaGZcx3xwpofqueWHio59FftJJKk3Yra4IMh61F
+JzAmEP893/+H+YZgPBU/Jadq4M0g8uGqXiBr9hFDKPwth8kpO9XXw0IwvlpFbmrZ
+yNGuoz+EiXq6wn5vL/MyeAX+v8LcRLCyfLvDs8+KFUfE+HKplsh8gvxNgtCcKh1r
+h8J0pDP9DjHw5kONI8db/d2swMKZ2hkHWNeQBproEYRoPGASfX4mnfvM5WAvLzkU
+y5UgoYiQjsQ2i4k+ITI=
+-----END CERTIFICATE-----
diff --git a/tools/binman/test/cst/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem b/tools/binman/test/cst/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
new file mode 100644
index 0000000000..c46a56dad5
--- /dev/null
+++ b/tools/binman/test/cst/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem
@@ -0,0 +1,121 @@
+Certificate:
+    Data:
+        Version: 3 (0x2)
+        Serial Number: 305419898 (0x1234567a)
+        Signature Algorithm: sha256WithRSAEncryption
+        Issuer: CN=SRK1_sha256_4096_65537_v3_ca
+        Validity
+            Not Before: Oct 10 09:06:14 2024 GMT
+            Not After : Oct  4 09:06:14 2049 GMT
+        Subject: CN=IMG1_1_sha256_4096_65537_v3_usr
+        Subject Public Key Info:
+            Public Key Algorithm: rsaEncryption
+                Public-Key: (4096 bit)
+                Modulus:
+                    00:e1:6e:2e:3d:5d:aa:21:7b:e8:3d:10:90:f0:08:
+                    45:32:6b:4d:40:02:da:b7:8e:da:ad:0a:d9:58:91:
+                    03:25:6e:f9:60:93:b6:0a:39:e9:bf:bf:80:d8:78:
+                    f4:a5:e9:34:d6:96:c9:e5:5d:b8:40:75:53:bd:90:
+                    86:90:a6:d1:ba:a0:42:13:29:b3:2c:30:70:58:51:
+                    ee:0e:0c:53:9a:e8:3f:33:65:2f:a1:dd:5c:46:30:
+                    fe:89:fd:31:5c:11:f4:82:fd:1b:da:b1:ec:86:e7:
+                    32:bb:eb:33:a7:2d:ca:19:1d:19:71:9c:ad:d4:e1:
+                    d8:c8:22:5e:bb:78:6b:c4:95:38:83:e7:7d:dd:76:
+                    da:a8:1e:fd:c5:6f:de:2f:9f:63:0e:bb:a0:25:bb:
+                    fd:93:32:55:5c:16:49:09:c8:fa:dc:dc:03:5d:7d:
+                    4d:3e:dc:4f:ac:11:56:05:9b:97:b8:06:06:d9:65:
+                    a8:85:e1:56:86:55:a0:ce:39:b2:cb:32:0a:30:39:
+                    cd:4a:eb:9d:be:bc:09:25:84:dc:35:d6:e0:9d:bf:
+                    fc:61:4a:c1:c0:1a:ac:10:e3:6c:77:0e:04:1d:f2:
+                    83:02:53:21:69:08:a8:1b:11:1d:fd:8a:7a:ec:d9:
+                    d6:14:7b:cd:da:82:89:41:d6:fd:fd:6c:c1:54:eb:
+                    d1:15:7a:ec:f3:e2:18:d8:1f:08:4e:c5:de:61:93:
+                    ab:d1:a3:cc:52:62:e6:ad:35:13:05:f8:9b:54:9e:
+                    6c:6f:b7:d4:fb:95:b4:d9:db:95:33:44:bd:a5:29:
+                    c8:02:64:7e:a1:03:f7:f1:a9:05:b9:13:1b:97:f0:
+                    f3:0c:f5:6e:72:fa:14:67:9f:c6:76:1c:00:c7:e8:
+                    e0:15:05:3c:c2:94:fc:3d:43:65:ae:ea:44:09:8c:
+                    b6:ba:55:c7:5a:55:ae:a9:84:bc:f3:f2:c0:59:34:
+                    1d:96:81:75:9e:e6:d1:6d:ee:93:c7:e7:b9:08:6c:
+                    69:82:1e:87:4d:13:11:4c:a9:b1:0a:ca:37:41:43:
+                    8c:1f:90:a5:00:39:d9:05:c2:50:55:c0:04:d9:17:
+                    bc:67:0b:84:10:9d:d1:1d:e1:a3:c9:d0:e0:7f:ac:
+                    90:9c:b8:1f:c9:ac:6c:91:74:4e:54:ab:0b:b8:46:
+                    dc:1d:5e:a1:58:8f:bd:4a:df:51:8a:0a:56:2a:e1:
+                    57:6b:35:b8:38:b8:31:84:96:65:ec:e2:98:58:b2:
+                    54:ba:ff:2c:cc:8a:8b:95:78:fc:c1:d1:87:31:3b:
+                    ed:ec:e1:39:df:19:02:c2:d7:03:57:01:5e:45:bf:
+                    a3:29:b8:fd:64:93:c1:50:2a:ca:f9:ad:9c:e8:b3:
+                    2c:82:1d
+                Exponent: 65537 (0x10001)
+        X509v3 extensions:
+            X509v3 Basic Constraints: 
+                CA:FALSE
+            Netscape Comment: 
+                OpenSSL Generated Certificate
+            X509v3 Subject Key Identifier: 
+                41:85:D4:2A:78:1D:22:7A:84:F3:3E:C5:6D:B6:AE:B7:3D:B2:DD:0B
+            X509v3 Authority Key Identifier: 
+                C3:28:CB:E3:D9:35:AB:F9:39:04:2A:3A:52:B2:B6:49:20:D0:C3:3B
+    Signature Algorithm: sha256WithRSAEncryption
+    Signature Value:
+        9c:47:8f:6b:df:42:4f:79:c2:8e:6f:42:16:54:ab:11:fb:06:
+        94:f9:05:e2:31:bb:11:bd:f1:65:0a:f1:07:75:d1:ae:20:fc:
+        cc:53:3e:61:15:63:1a:5b:63:29:3d:3f:a6:6a:73:86:66:95:
+        02:82:71:70:89:7d:b7:aa:92:fa:db:cf:21:80:51:3b:43:49:
+        9d:0f:8b:52:ca:8d:d7:2a:98:37:e0:9c:5d:8b:c2:70:f2:63:
+        3c:15:ff:84:b9:41:5d:0d:80:06:6e:26:fe:6f:2a:a2:c4:25:
+        a1:32:ef:58:a9:fa:62:5c:8d:27:2e:c5:0e:f3:fb:b2:26:97:
+        ce:55:de:08:b0:77:45:4d:18:58:99:5b:f4:a1:2f:cd:ea:d1:
+        18:5a:7b:d0:12:a4:bb:a4:9c:c6:3c:86:e7:9f:1a:8b:b1:73:
+        f5:17:92:93:3c:eb:76:47:53:16:06:cd:96:e7:01:11:52:08:
+        ae:fd:02:eb:26:2a:c2:8f:0b:64:2a:23:10:87:31:ba:0c:60:
+        38:57:e6:e1:13:b6:cc:32:fe:7e:46:09:11:40:0f:f5:e1:96:
+        1c:19:b0:58:9e:5b:5c:ab:42:da:6a:c0:4c:33:26:29:f4:f0:
+        8e:62:fb:ac:3d:96:c5:74:b8:36:d2:df:32:8d:db:dd:dc:b8:
+        53:56:5c:c3:f7:9c:40:3e:8d:2f:52:ca:17:89:85:60:ad:7f:
+        e3:a7:c7:31:e8:d4:56:63:8c:df:10:d5:6e:42:50:fb:32:4d:
+        2a:2e:75:3a:17:9d:ca:f0:24:19:78:3d:85:01:66:41:e6:2c:
+        9c:db:73:ec:30:a7:6b:a0:45:84:ca:82:fe:8d:af:31:27:c0:
+        94:c7:3b:15:38:cf:98:c7:78:33:b6:7a:e1:d9:9d:83:ae:c6:
+        9f:6c:c5:a5:ff:e6:ce:5e:f6:50:9f:57:6a:65:6f:10:c5:06:
+        f1:1c:bd:84:8e:7c:a8:68:8b:b0:68:78:14:1a:a0:78:34:d5:
+        1c:1c:30:1d:64:f4:7d:67:45:49:ba:40:6d:e3:82:08:86:67:
+        48:2d:09:a6:65:58:69:36:34:7a:ad:e9:f9:ff:de:3d:25:3e:
+        c3:8b:7b:b7:6d:99:34:1a:b1:68:de:c9:12:34:ce:a7:2a:f2:
+        21:a6:69:88:fd:e5:5f:c4:b6:ce:57:13:40:96:89:77:56:32:
+        08:28:1f:84:10:5c:66:48:7e:41:49:6e:7d:84:5c:1b:e8:bc:
+        32:f9:1d:5a:e9:c5:28:3c:2b:33:b9:c0:37:c6:b6:23:11:b1:
+        d6:7a:b4:6e:9e:64:3c:17:e3:32:b5:9e:a5:bf:56:fb:83:54:
+        a9:58:98:4b:22:ac:8f:65
+-----BEGIN CERTIFICATE-----
+MIIFSjCCAzKgAwIBAgIEEjRWejANBgkqhkiG9w0BAQsFADAnMSUwIwYDVQQDDBxT
+UksxX3NoYTI1Nl80MDk2XzY1NTM3X3YzX2NhMB4XDTI0MTAxMDA5MDYxNFoXDTQ5
+MTAwNDA5MDYxNFowKjEoMCYGA1UEAwwfSU1HMV8xX3NoYTI1Nl80MDk2XzY1NTM3
+X3YzX3VzcjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOFuLj1dqiF7
+6D0QkPAIRTJrTUAC2reO2q0K2ViRAyVu+WCTtgo56b+/gNh49KXpNNaWyeVduEB1
+U72QhpCm0bqgQhMpsywwcFhR7g4MU5roPzNlL6HdXEYw/on9MVwR9IL9G9qx7Ibn
+MrvrM6ctyhkdGXGcrdTh2MgiXrt4a8SVOIPnfd122qge/cVv3i+fYw67oCW7/ZMy
+VVwWSQnI+tzcA119TT7cT6wRVgWbl7gGBtllqIXhVoZVoM45sssyCjA5zUrrnb68
+CSWE3DXW4J2//GFKwcAarBDjbHcOBB3ygwJTIWkIqBsRHf2KeuzZ1hR7zdqCiUHW
+/f1swVTr0RV67PPiGNgfCE7F3mGTq9GjzFJi5q01EwX4m1SebG+31PuVtNnblTNE
+vaUpyAJkfqED9/GpBbkTG5fw8wz1bnL6FGefxnYcAMfo4BUFPMKU/D1DZa7qRAmM
+trpVx1pVrqmEvPPywFk0HZaBdZ7m0W3uk8fnuQhsaYIeh00TEUypsQrKN0FDjB+Q
+pQA52QXCUFXABNkXvGcLhBCd0R3ho8nQ4H+skJy4H8msbJF0TlSrC7hG3B1eoViP
+vUrfUYoKVirhV2s1uDi4MYSWZezimFiyVLr/LMyKi5V4/MHRhzE77ezhOd8ZAsLX
+A1cBXkW/oym4/WSTwVAqyvmtnOizLIIdAgMBAAGjezB5MAkGA1UdEwQCMAAwLAYJ
+YIZIAYb4QgENBB8WHU9wZW5TU0wgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1Ud
+DgQWBBRBhdQqeB0ieoTzPsVttq63PbLdCzAfBgNVHSMEGDAWgBTDKMvj2TWr+TkE
+KjpSsrZJINDDOzANBgkqhkiG9w0BAQsFAAOCAgEAnEePa99CT3nCjm9CFlSrEfsG
+lPkF4jG7Eb3xZQrxB3XRriD8zFM+YRVjGltjKT0/pmpzhmaVAoJxcIl9t6qS+tvP
+IYBRO0NJnQ+LUsqN1yqYN+CcXYvCcPJjPBX/hLlBXQ2ABm4m/m8qosQloTLvWKn6
+YlyNJy7FDvP7siaXzlXeCLB3RU0YWJlb9KEvzerRGFp70BKku6ScxjyG558ai7Fz
+9ReSkzzrdkdTFgbNlucBEVIIrv0C6yYqwo8LZCojEIcxugxgOFfm4RO2zDL+fkYJ
+EUAP9eGWHBmwWJ5bXKtC2mrATDMmKfTwjmL7rD2WxXS4NtLfMo3b3dy4U1Zcw/ec
+QD6NL1LKF4mFYK1/46fHMejUVmOM3xDVbkJQ+zJNKi51OhedyvAkGXg9hQFmQeYs
+nNtz7DCna6BFhMqC/o2vMSfAlMc7FTjPmMd4M7Z64dmdg67Gn2zFpf/mzl72UJ9X
+amVvEMUG8Ry9hI58qGiLsGh4FBqgeDTVHBwwHWT0fWdFSbpAbeOCCIZnSC0JpmVY
+aTY0eq3p+f/ePSU+w4t7t22ZNBqxaN7JEjTOpyryIaZpiP3lX8S2zlcTQJaJd1Yy
+CCgfhBBcZkh+QUlufYRcG+i8MvkdWunFKDwrM7nAN8a2IxGx1nq0bp5kPBfjMrWe
+pb9W+4NUqViYSyKsj2U=
+-----END CERTIFICATE-----
diff --git a/tools/binman/test/cst/crts/SRK1_sha256_4096_65537_v3_usr_crt.pem b/tools/binman/test/cst/crts/SRK1_sha256_4096_65537_v3_usr_crt.pem
new file mode 100644
index 0000000000..f2292063ba
--- /dev/null
+++ b/tools/binman/test/cst/crts/SRK1_sha256_4096_65537_v3_usr_crt.pem
@@ -0,0 +1,121 @@
+Certificate:
+    Data:
+        Version: 3 (0x2)
+        Serial Number: 305419899 (0x1234567b)
+        Signature Algorithm: sha256WithRSAEncryption
+        Issuer: CN=CA1_sha256_4096_65537_v3_ca
+        Validity
+            Not Before: Oct 10 09:08:59 2024 GMT
+            Not After : Oct  4 09:08:59 2049 GMT
+        Subject: CN=SRK1_sha256_4096_65537_v3_usr
+        Subject Public Key Info:
+            Public Key Algorithm: rsaEncryption
+                Public-Key: (4096 bit)
+                Modulus:
+                    00:b6:47:1a:d9:a1:07:01:17:7d:2e:97:08:91:1a:
+                    e0:27:c1:c0:06:8e:25:e8:2c:e7:65:1b:1f:4c:96:
+                    ea:fa:52:5a:41:4d:80:16:85:ee:a5:71:3b:3a:d8:
+                    3b:4a:08:c6:cf:c0:cd:3b:7b:4a:5c:0a:bf:e1:b4:
+                    9d:2a:df:46:94:db:72:84:ba:d8:c4:24:a7:21:57:
+                    bc:8d:d4:f5:d2:5b:44:c9:c4:43:fa:d1:26:7a:59:
+                    0e:ba:97:e8:aa:68:51:05:6a:b4:88:13:6e:e2:ec:
+                    d1:b8:2d:c9:dd:79:c6:a9:b2:a9:2a:15:6c:de:13:
+                    b4:9f:76:35:64:08:a0:ef:ca:5c:09:c3:d8:ff:a6:
+                    f2:d0:f4:ce:4b:0a:e9:29:ca:01:e5:41:4b:d3:18:
+                    56:64:e0:f7:79:3b:34:e2:57:28:c1:9b:41:78:5c:
+                    09:43:62:97:ab:07:c1:05:67:fa:d6:d6:1d:fe:92:
+                    73:06:89:eb:19:7b:d2:e9:15:de:17:30:7f:57:48:
+                    71:d7:d3:1f:10:6d:da:e3:38:1a:cf:90:dd:02:98:
+                    b4:7a:eb:4d:ca:94:f7:97:49:4d:6e:cd:a6:2e:cd:
+                    ed:9d:ab:b7:cb:a6:7a:15:c5:d3:dd:ea:2f:e1:17:
+                    7d:a0:b0:8d:96:32:7b:2b:e7:9a:66:67:81:ae:2c:
+                    29:7f:50:2f:fc:db:e4:92:4f:cd:70:69:4c:02:ba:
+                    00:70:d1:a1:1e:2c:ab:f6:80:94:0e:1c:4f:3a:8c:
+                    ea:ca:1b:54:f0:40:fe:16:50:8b:7e:fc:aa:10:a4:
+                    a6:f8:d5:c8:a8:13:a5:00:d6:a2:93:8a:6f:11:32:
+                    70:d8:34:9d:75:29:01:b4:89:d1:96:5c:14:8e:81:
+                    f2:98:77:01:a7:7d:21:de:7a:92:19:07:e0:45:64:
+                    0e:76:b3:5c:06:b7:6e:b1:ed:52:78:86:18:06:73:
+                    77:26:fe:0b:52:cb:0b:da:36:d6:35:38:0a:b0:72:
+                    b7:9d:17:3f:5d:9c:9b:40:d3:d2:19:2f:d8:a3:6c:
+                    b4:13:80:65:80:3f:d9:b6:86:30:c2:b3:67:05:88:
+                    d5:54:ff:85:45:36:71:71:db:3d:19:d0:74:23:9d:
+                    7f:b6:23:6d:31:66:ed:a5:5e:7c:18:1a:4d:06:84:
+                    f0:f6:2e:c6:82:e2:f1:9c:54:b9:ad:08:87:3c:f7:
+                    92:11:9e:82:1e:73:22:22:ba:41:11:75:3c:a9:3a:
+                    1b:b8:46:85:65:e0:a4:cf:74:93:1b:08:dc:db:8b:
+                    6c:a2:cc:d1:78:e1:b1:4d:1b:8e:34:94:92:1e:83:
+                    4d:31:83:4b:29:24:13:6b:d6:c8:01:9b:a5:86:06:
+                    6f:78:27
+                Exponent: 65537 (0x10001)
+        X509v3 extensions:
+            X509v3 Basic Constraints: 
+                CA:FALSE
+            Netscape Comment: 
+                OpenSSL Generated Certificate
+            X509v3 Subject Key Identifier: 
+                3F:AD:DF:F8:61:77:1C:25:B9:39:E0:E3:58:8A:1E:33:41:6F:69:47
+            X509v3 Authority Key Identifier: 
+                9C:69:40:48:C8:0D:7B:BD:9F:7E:1E:F2:24:B4:B4:8A:43:D2:67:C9
+    Signature Algorithm: sha256WithRSAEncryption
+    Signature Value:
+        4e:1f:52:04:ba:b0:32:45:61:eb:97:f7:4c:c2:10:38:00:b9:
+        1f:a1:f5:04:2e:f6:85:9b:6e:c2:d6:47:62:1e:b8:82:ea:5e:
+        a0:ae:1d:71:5b:18:95:17:8e:78:88:39:15:dd:15:c3:47:b9:
+        35:b2:20:5a:f0:fa:5c:06:b1:0c:1f:85:29:be:ca:1d:08:6d:
+        57:07:5e:e6:fc:0d:2a:55:ea:b9:44:e8:69:c1:c0:6c:0d:e5:
+        af:af:7a:85:11:34:9e:dd:93:31:1a:ae:7f:a7:2c:60:56:f9:
+        b9:19:7f:c1:3a:16:54:b2:cb:d3:89:54:36:d8:1a:4d:1e:61:
+        89:8b:fe:5f:99:e3:a2:c2:d6:87:d7:e9:ac:05:06:e0:8a:ae:
+        51:28:f5:4b:97:6f:85:a5:47:f6:5d:93:43:0a:af:62:e1:58:
+        70:af:e3:f0:35:71:17:ae:03:19:b2:cd:cf:8d:a7:ae:2e:b2:
+        4d:f7:eb:0e:b7:f2:d8:92:e2:50:15:7a:5b:1e:3b:56:f9:32:
+        5c:85:12:00:de:02:c6:18:0f:34:44:71:47:62:5c:73:b9:ac:
+        6a:85:86:91:ed:9d:98:06:db:9a:3c:d6:79:55:61:ce:4c:4f:
+        41:5d:42:be:be:35:69:50:42:3f:6c:32:78:f3:64:2a:5c:7d:
+        c8:7c:9e:39:94:0b:ba:13:05:c4:0d:fe:2f:15:10:86:ec:af:
+        51:be:3a:6d:da:86:31:16:5f:07:86:e9:32:c6:32:33:73:37:
+        a4:f8:11:69:04:b8:8d:89:c7:1d:ca:16:c6:c2:2d:09:22:6c:
+        b3:b1:7f:de:44:16:83:87:d3:ba:a3:65:57:23:89:72:03:3c:
+        47:11:37:c3:07:3f:b4:12:c4:d1:81:bd:57:0e:2b:4d:22:c0:
+        7f:24:46:c2:ba:15:5a:f6:31:d6:7c:9a:f7:60:6c:cd:1d:38:
+        af:00:d4:93:ac:5b:62:92:6e:38:7e:ce:5d:18:7e:5e:ff:82:
+        d9:22:68:fa:ba:e8:e0:34:85:24:14:5b:9f:63:49:7e:9d:f9:
+        5a:a9:ba:37:08:86:34:b0:0b:60:2d:e4:bc:d7:52:ad:20:58:
+        44:08:f2:e9:29:32:05:68:cc:d7:6c:25:1b:f8:1e:99:c1:ed:
+        46:91:cf:8e:fa:91:9c:3f:4b:33:19:0b:96:97:1d:9b:53:d1:
+        17:8a:b8:d7:13:a7:ea:00:09:dd:09:c7:37:48:8a:47:5c:1d:
+        28:1e:35:41:57:13:99:22:67:b8:8c:09:c6:25:6d:37:d3:59:
+        b7:b7:34:76:94:bd:9c:52:81:01:bb:f9:21:67:75:5c:0f:4c:
+        5d:10:02:3b:8a:84:02:e8
+-----BEGIN CERTIFICATE-----
+MIIFRzCCAy+gAwIBAgIEEjRWezANBgkqhkiG9w0BAQsFADAmMSQwIgYDVQQDFBtD
+QTFfc2hhMjU2XzQwOTZfNjU1MzdfdjNfY2EwHhcNMjQxMDEwMDkwODU5WhcNNDkx
+MDA0MDkwODU5WjAoMSYwJAYDVQQDDB1TUksxX3NoYTI1Nl80MDk2XzY1NTM3X3Yz
+X3VzcjCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALZHGtmhBwEXfS6X
+CJEa4CfBwAaOJegs52UbH0yW6vpSWkFNgBaF7qVxOzrYO0oIxs/AzTt7SlwKv+G0
+nSrfRpTbcoS62MQkpyFXvI3U9dJbRMnEQ/rRJnpZDrqX6KpoUQVqtIgTbuLs0bgt
+yd15xqmyqSoVbN4TtJ92NWQIoO/KXAnD2P+m8tD0zksK6SnKAeVBS9MYVmTg93k7
+NOJXKMGbQXhcCUNil6sHwQVn+tbWHf6ScwaJ6xl70ukV3hcwf1dIcdfTHxBt2uM4
+Gs+Q3QKYtHrrTcqU95dJTW7Npi7N7Z2rt8umehXF093qL+EXfaCwjZYyeyvnmmZn
+ga4sKX9QL/zb5JJPzXBpTAK6AHDRoR4sq/aAlA4cTzqM6sobVPBA/hZQi378qhCk
+pvjVyKgTpQDWopOKbxEycNg0nXUpAbSJ0ZZcFI6B8ph3Aad9Id56khkH4EVkDnaz
+XAa3brHtUniGGAZzdyb+C1LLC9o21jU4CrByt50XP12cm0DT0hkv2KNstBOAZYA/
+2baGMMKzZwWI1VT/hUU2cXHbPRnQdCOdf7YjbTFm7aVefBgaTQaE8PYuxoLi8ZxU
+ua0Ihzz3khGegh5zIiK6QRF1PKk6G7hGhWXgpM90kxsI3NuLbKLM0XjhsU0bjjSU
+kh6DTTGDSykkE2vWyAGbpYYGb3gnAgMBAAGjezB5MAkGA1UdEwQCMAAwLAYJYIZI
+AYb4QgENBB8WHU9wZW5TU0wgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1UdDgQW
+BBQ/rd/4YXccJbk54ONYih4zQW9pRzAfBgNVHSMEGDAWgBScaUBIyA17vZ9+HvIk
+tLSKQ9JnyTANBgkqhkiG9w0BAQsFAAOCAgEATh9SBLqwMkVh65f3TMIQOAC5H6H1
+BC72hZtuwtZHYh64gupeoK4dcVsYlReOeIg5Fd0Vw0e5NbIgWvD6XAaxDB+FKb7K
+HQhtVwde5vwNKlXquUToacHAbA3lr696hRE0nt2TMRquf6csYFb5uRl/wToWVLLL
+04lUNtgaTR5hiYv+X5njosLWh9fprAUG4IquUSj1S5dvhaVH9l2TQwqvYuFYcK/j
+8DVxF64DGbLNz42nri6yTffrDrfy2JLiUBV6Wx47VvkyXIUSAN4CxhgPNERxR2Jc
+c7msaoWGke2dmAbbmjzWeVVhzkxPQV1Cvr41aVBCP2wyePNkKlx9yHyeOZQLuhMF
+xA3+LxUQhuyvUb46bdqGMRZfB4bpMsYyM3M3pPgRaQS4jYnHHcoWxsItCSJss7F/
+3kQWg4fTuqNlVyOJcgM8RxE3wwc/tBLE0YG9Vw4rTSLAfyRGwroVWvYx1nya92Bs
+zR04rwDUk6xbYpJuOH7OXRh+Xv+C2SJo+rro4DSFJBRbn2NJfp35Wqm6NwiGNLAL
+YC3kvNdSrSBYRAjy6SkyBWjM12wlG/gemcHtRpHPjvqRnD9LMxkLlpcdm1PRF4q4
+1xOn6gAJ3QnHN0iKR1wdKB41QVcTmSJnuIwJxiVtN9NZt7c0dpS9nFKBAbv5IWd1
+XA9MXRACO4qEAug=
+-----END CERTIFICATE-----
diff --git a/tools/binman/test/cst/crts/SRK_table.bin b/tools/binman/test/cst/crts/SRK_table.bin
new file mode 100644
index 0000000000000000000000000000000000000000..c0273b20acd8092f20b424cfee35ffbb6b5cf655
GIT binary patch
literal 531
zcmV+u0_^?Q0uw;t0uLbo004jj000A|-F=DX5Ue1o2G-roSuw;<gjb0kIVbn=G%Q&Z
ztq3T%mqxbz+rH|D-bztmQUkp#(Jyo5(GOaMh-;p-!r;S9wgav4XwGo8^QS0(xWG}>
z2!Kh_jRfaG_j$&(l~6{aRzUkqtXLZa$*^g}=Qi%Flkf+4BF1E0$?)y~kHYqY^_Cao
z85BZ`WHWiE6`GHc0SCAv_^)?EdXS#FTK)O}YX8MCt@r>))5mwD+HC=SEazDmXH5UP
z(H&<)IB=4rbpBf`p}60t_R3Gr%a1*A+MXjl@4$ZT|EBJyBPT?r2%g3u9S3^YaXVrP
zP)_t~FczoqSqTR)@M*{AK1^xu(nygJt~M6#X7fh!AVWfea`?6lF{M0+18}Rq<X@As
zpycn>qEEZYqQCI^S<ij(<rHu-V3%p50x4fy)xKr?COyS2)F?chvLtGR)6hQ}L%~P7
z@mJOApXMj^fXT-;Gcxg<nhIJ(tRhS5??Zw^hk+@COrpmnc9?8La-==Y<bN}>i@(BZ
z*TCGc)r)5WYldg3uo6T=rz;pWm>-u1RKx5IkC9y|YE_Fjk22oFb6$ls9NsCZ%3i>e
z@v>$UF;0-K)8pkI6rTZ9mtW#bJhtEV;`g?@C$SEueXCl3laxAoN!<HA;&zmQDZ<tu
VmgdsJeb5qaXUlp+0YG^H00G7K2>t*7

literal 0
HcmV?d00001

diff --git a/tools/binman/test/cst/crts/SRK_table_fast_auth.bin b/tools/binman/test/cst/crts/SRK_table_fast_auth.bin
new file mode 100644
index 0000000000000000000000000000000000000000..0f3a8700da3ad3d9e876c8f768dcc4be4dc588f1
GIT binary patch
literal 531
zcmV+u0_^?Q0uw;t0uLbo00002000BFM;h6o2LTs-E|&<A8sI0vzy^*b=q%@D8y`%T
z>iSYzK}~=bh3=(sJ381qN(jc!z|A{*N?Z!R;k2D9-$s<%a)i3r#3ZL7SG<kX_0n5J
z$;3nY(I$FX4!W1<s%TLKYP5(GZsP3GxGl-udB&--sVWt0-V?N+b~R)Opzq3D3B%a`
zrt;AA&PxjEDarxmK}*vZR%GD!c{?=XS17@oL3msVLt>Y!2f+nr`qtJR{*rSBiR&4A
z(&-i67chTUNO9NG9}sQY<2V}6klg~9w0i4J%9Qt)Nlk9erY_CxovXLYrg{~{)7|PX
z;TL_Nu#J{7dn@OfW@mw}EGd6bFZ|o&l26TWX-opT0C3Tv9xSW&fRqj#Pdbe1${SSh
zK>ij`i+=p75TvH~)ySw5r2y8VlZtN<GH}>5opmVzw29G{TojIh@|br4r+p#bdXgCj
z;6-E(cC%atw{EfRQh0_K26J~N{tHse3)(i;H8={ea<`oqKV6)gK-1D0FW94Ov=e}3
zfIr!`hA_gjX9bAWRR4uVHgR#=JsHq+Bb|S?BW*Ee?WJCP7#d9mgz)w*#)9JUoK(53
z2!}lPk`bPQ9&;ihx<L_jJgGVxxJHF#;H1xVlN$)!+ly?X%+Yw^u}vF}G?bDagH17m
VODQB1Yu3mCo27;ZZ+IsG00Dh{{7nD=

literal 0
HcmV?d00001

diff --git a/tools/binman/test/cst/keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem b/tools/binman/test/cst/keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem
new file mode 100644
index 0000000000..7c524bf16b
--- /dev/null
+++ b/tools/binman/test/cst/keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem
@@ -0,0 +1,54 @@
+-----BEGIN ENCRYPTED PRIVATE KEY-----
+MIIJpDBWBgkqhkiG9w0BBQ0wSTAxBgkqhkiG9w0BBQwwJAQQaLq1MHCGxiR/S2Iy
+7qTpPQICCAAwDAYIKoZIhvcNAgkFADAUBggqhkiG9w0DBwQIw5SoWpCMp8kEgglI
+wRWjzKzuFDRHWvI60tnFUcYaXfkkMUyPhpnHQHGYIxB5uNbkecwxx4Aj91zE1WVQ
+TL8NUps/829fVLLOMkbkC3cgMPaNsBiiVDQSHCPyRztCM/+lBiWT+vfuMgmT07gS
+MGOZgQx+gLu6oA2zyJq16XmOWc3XGp8gue2B/Se5dai8FULb8g9lJD+FF+9mMv2A
+KDj9W9l1Z//BNYx7WvHCC6pHDUtmPtBKAGCyGcanDDb0LqV2U4HBHtvorZHEnDuE
+dbp12qy1ZIGGi3SedgTBv2V+h10+y+y6wX+rtfxxndl0p1f5L7VXEWBbE9sB/Kn1
+7DNcFSTP+sFe3fEVAwVaUnomeYPgNbbguNXi15RUl2lhcmx2WdV3Wh7Igi05CgWb
+1rw8O8EAybz7yHuQfvHrFw3Bs6+hx8r2v6jnWn/jnhDNmadKHbXiZLfHeGfCEXe9
+fcnHTuqehdvqRVrFUYXlWgQahcbKgDQvjBDU9G6lxyRVvSPhCTUh6VB9maWEMmHM
+AfsT4lQxtPhoAIFarqS/IOYvHq9z8AXnogylWeB+NCRx2K5Z+AfbsEEB47fJNcIn
+vEBKX0LB1dRyTl2tfKqfhsiKBWtoxvBmJG4b5UulLQSzxMi10YMZ760+ouQhNM2X
+Yil9rk/waOr3FH/a+YqaHGRhnRNmr5v5GkzVVAzlT9GD6RIzdzVOsGdWUwbFI2ct
+0ne8ZZmN+dzItWu3+QXGuWWzhU66nOK8BeN8kVzbyzjC0cLFoTyovcrZwB60WTC9
+DRbkvuYbDCfbtMUz9DtSWFbMBNyz5AYzsPpeVIgX7dQgi2nFZZAMHRTT0w/GzoJ4
+6HEssDpKPuq2L6GkdIXew+B6mraIkoHLSBJ58yX7rZzeH+YmHeaqBOlE2l9eCNQz
+4XtGqvWQ+7Rp4sxm6zxuvV3b0cQVxFhDrxm5qFWdBC5aKxbcTVvm/bZFYFNlOhqq
+YfvitqlNH/R/Ae7uqSX/9gPo3r709qBW2k4ab2NaxrSQUz0MfkasPA1+GiDgX8Nx
+CbotCsqUlTP6l6jv69ZM47jl3X08NlzmDqRS94kEl7j6itsNeIHC7JwWyUkb1MY4
+hUvyb7DsvBeGduwnBZyh1phbN9kXMsHY4C8Up1/K8a6kzziKOS3zsv4XVp5Oq0iR
+Kleoff7+u1GijBCVb+5rBWDPmKbbyITAjD4fdSTxrftlzqRGQ5xLN3vHGJ0hh0Er
+uRCHc12pLyE2bfac9Rn4EBzyzCR3Ms8Cyy6iHrc7oixziYzcvJS9czMCrToHJavE
+gTrHBrQmhPBaZYFJOLH3X5R/WG7JT2/yXHEB7hq4ttGT3WKn7HiC7fM5fvWKiwH8
+MJUN8ouTLFawWcVIXrKJlF60ahVcX2PuiE/okCzUiUVMwbdtOqKgydMe6vSOh0LD
+v1exCV3+/QRRyGpyr/3uY+43DgdGzVc4LgcpH3VM+uj6AVXTYdNO/OT4QVPidTmZ
+cTFWjfGCZId8yxuc5Oz9Zj5fRLFysxHMt7fEHRkGBu9uSXIajiPPosYMeuYk1vX5
+asC5S7bfN305MKjSAgyHNODPyGB0/f8HhsyY47wwAaxkDMxY/RqjxjyEpN/tOGxk
+yxqtQ4LSkCIdudTkTQjyqExNU88GstN+j5M9oIl5N4Af2cZK6E0UcEFlqlkqV0OS
+QTiDZ/Gdmu8XU291+RZAOmanoYCP262rcwdHWXZxuEtirLPjxMThsMUFda0NRiuY
+aG6cHI2rb65GbmtiWlAe42iyaxomKyhKV22sqrrkocxN+67Mo29OVjSn0m0k3u/3
+M4tMDTA3dtn0SzXuyHTE2pt2KnRthlYMOZfOBjg9BL+HEXBZUPyiZgwPUtViLS9K
+F3fmbcAfgNlRQlxN2SO28fHFrduc8PM7Z8YizpfD+4U4EWwQGL2HIGDCU9Ip0fTu
+LaNpAXUFd/E/wZ+CoeJUa9KZAI5Rk6P4X5Bb5MUADvdm52DnULylRtfzOb/a4Ok/
+E+ZdAOa7lBUZPC8Go2ieryfGEnVR4S0AeKoCFOhNFhghhz3ZVKwvRjMhnejsCSwr
+7B1kTXZjGcqS0OOaBigLXUx7LZPgn9ubAqTl6oKFgJ942cj6VutAoQErCpG55xUm
+0RXcX2btUeLXgFOw2NUoA4EWR1B94na6LfRFoKHOrlL9aFdMKVIQmPMgoglrHBsE
+BuajHLHXkjErxz8q4fqCTGh58c+Ug9VU1V4fmKUVE/X/aWg/2n7UiY2JKxoJxqoZ
+Vbu8ffNtMYQWuUKXo9dtjZZLx/xiV0JRyrxSrl7DqGRc+Uyxv0UCI+U3wQy0u6bm
+gp3ptRbvPg/YaTEBnknXDvZTrcfDHcBNYoyIJCozc1v+MFZ+Apj18nSyVruLGn+d
+lW221MJ9o6kYlCIYCqT5R9/kVd9VUa73BnqOlOtjt/LNX3O9eZvJUMssN2F01Gtb
+u6tqRKFQKWkmhz9KHdHHlpsz2SJuE5HoJlar9y0/seL0qEGUdUEAXzsQOoHuocKV
+0+drGNSmv88DGMawj5Czm8HHD3Bx11OSVvOUKf5/WMOt5juflWr75y+BxPcytzPv
+FxLyupXmPtzupn7MK/3ETyT+Z7UhOJW9R3rjswm4UscspHyznZ4yN5mipiNym929
+lDnU+Oxyo7vcebrhDt5yFsnWyrfDvXCm1ViMnviGVMQWL9tT0UC18hdt3p8BBHWM
+lH8rIg3tu6k1SQ0OtFl/PLQ3KERwq00fVHoE6jyvrAyeAnqBH7wLnLP4G8mDr8uH
+RqcyUGeJuGot9KbcBBLtvuDHqHwel5vn/4CBNyH5R/w8BsGHGPV2TbH7siDC1Lm0
+U6SH3ixfKCd+QfyagUOI9dSl+DUJklxjMOpmmiNNYTM8nlDwtREEJ/21r1fuDlfL
+aYFNnxaOr5vbXyfP260hmzSv9YSAn+Nqfi1c1Edy/bsXo2YibkGMbRx9e7PEqZPu
+kUNLr8uUEfU4HBvR/ef0oz9P3L8mMz74HT1TW/6NdEmqy5bCn0FfVHa3aVKIAlcq
+J93vjZh3KWVsoNaqnoj5oCY9ng3qrmh1UtaLqihzsLF9r+oKHkpI48wXQm4z7jMO
+wMmRhboFMedKqBExmbwy/axdcqpwrzHQP6Ww0N0Qc/uIqeVtYfpD2EJ3H6797OQV
+d4vfi0vZxOC4RpiXL3BYzFEfaEK1kUkw
+-----END ENCRYPTED PRIVATE KEY-----
diff --git a/tools/binman/test/cst/keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem b/tools/binman/test/cst/keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem
new file mode 100644
index 0000000000..d36b545a02
--- /dev/null
+++ b/tools/binman/test/cst/keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem
@@ -0,0 +1,54 @@
+-----BEGIN ENCRYPTED PRIVATE KEY-----
+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
+3cM4oFn7nW++W5MYuvMFP7ImRVyCy103
+-----END ENCRYPTED PRIVATE KEY-----
diff --git a/tools/binman/test/cst/keys/SRK1_sha256_4096_65537_v3_usr_key.pem b/tools/binman/test/cst/keys/SRK1_sha256_4096_65537_v3_usr_key.pem
new file mode 100644
index 0000000000..8360162066
--- /dev/null
+++ b/tools/binman/test/cst/keys/SRK1_sha256_4096_65537_v3_usr_key.pem
@@ -0,0 +1,54 @@
+-----BEGIN ENCRYPTED PRIVATE KEY-----
+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
+c2/VpirvEB3h8m3uYmstqTD5q8055dts
+-----END ENCRYPTED PRIVATE KEY-----
diff --git a/tools/binman/test/cst/keys/key_pass.txt b/tools/binman/test/cst/keys/key_pass.txt
new file mode 100644
index 0000000000..dec2cbe1fa
--- /dev/null
+++ b/tools/binman/test/cst/keys/key_pass.txt
@@ -0,0 +1,2 @@
+test
+test
-- 
2.39.5

