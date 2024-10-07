Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFF3CFB441
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 13:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A8688D47;
	Mon,  7 Oct 2024 15:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="EgjT6haP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751D6888EB; Mon,  7 Oct 2024 15:02:13 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDD7889E1
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 15:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brian.ruley@gehealthcare.com
Received: from pps.filterd (m0047961.ppops.net [127.0.0.1])
 by m0047961.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id
 497AtguS000766
 for <u-boot@lists.denx.de>; Mon, 7 Oct 2024 09:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=outbound; bh=5doGfiLmzBZj
 FILQuH56clmBSB2lyRKQfUt4cagUoxM=; b=EgjT6haPYF+2hP80WHqw265pJAC2
 uNnSPodUGQ2R9CakZ2VUdQ7lEpe1cD0Tf+VhltgHCQzG7J+FBYRPpV97fEONZ1WO
 L6jWvMRpLhuRi1j2ojq8UWIk3NgGgrcfnvMoRoXkOJNztnKauNXLClvVEF/HMRZQ
 CP3T5ttbsv1WSsRf19GmEY7CXjBTbmXlhay0QDeghzn2PK+i3q9U0erhPgUkCBpS
 brS1R8FAo6IJD5nuznGUKppkyPgXYqGEk4c3LZ1bx4kRo4ftkB81kvNrwBj+qv6f
 BE20+Xt2GEh8xb++TB6o8tGjJHM6dWNlnOvM23vlpN09yzMI8xO7n3jSNg==
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: ian.ray@gehealthcare.com, Brian Ruley <brian.ruley@gehealthcare.com>,
 u-boot@lists.denx.de
Subject: [PATCH] WIP: binman: expand test coverage to nxpimx8mcst
Date: Mon,  7 Oct 2024 16:01:09 +0300
Message-Id: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6sK6m5w6qPjPAf2pEvRuLYYozM46YR59
X-Proofpoint-ORIG-GUID: 6sK6m5w6qPjPAf2pEvRuLYYozM46YR59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_03,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=932 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410070092
X-Mailman-Approved-At: Mon, 07 Oct 2024 15:25:58 +0200
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
required by `cst' using `hab4_pki_tree.sh' script in `cst_3.4.1' [1].

[1] https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
 tools/binman/ftest.py                   |  4 ++
 tools/binman/test/336_nxp_imx8mcst.dts  | 58 +++++++++++++++++++++++++
 tools/binman/test/cst/keys/key_pass.txt |  2 +
 3 files changed, 64 insertions(+)
 create mode 100644 tools/binman/test/336_nxp_imx8mcst.dts
 create mode 100644 tools/binman/test/cst/keys/key_pass.txt

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 93f3d22cf5..f1c052a7f8 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7690,6 +7690,10 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             # Make sure the other node is gone
             self.assertIsNone(dtb.GetNode('/node/other-node'))
 
+    def testNxpImx8mCst(self):
+        """Test that binman can sign an iMX8M image"""
+        self._DoTestFile('336_nxp_imx8mcst.dts')
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/336_nxp_imx8mcst.dts b/tools/binman/test/336_nxp_imx8mcst.dts
new file mode 100644
index 0000000000..6cfefdae2a
--- /dev/null
+++ b/tools/binman/test/336_nxp_imx8mcst.dts
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
+            nxp,srk-table = "tools/binman/test/cst/crts/SRK_table.bin";
+            nxp,img-crt = "tools/binman/test/cst/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem";
+            nxp,csf-crt = "tools/binman/test/cst/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem";
+
+            fit {
+                description = "test desc";
+			    filename = "test-fit.itb";
+                #address-cells = <1>;
+
+                images {
+                    u-boot {
+                        description = "test u-boot";
+                        type = "standalone";
+                        arch = "arm64";
+                        os = "u-boot";
+                        compression = "none";
+                        load = <00000000>;
+                        entry = <00000000>;
+
+                        u-boot-nodtb {
+                        };
+                    };
+
+                    fdt-1 {
+                        description = "test fdt";
+                        type = "flat_dt";
+                        compression = "none";
+
+                        u-boot-dtb {
+                        };
+                    };
+                };
+
+                configurations {
+                    default = "config-1";
+                    config-1 {
+                        description = "test config";
+                        fdt = "fdt-1";
+                        firmware = "u-boot";
+                    };
+                };
+            };
+        };
+	};
+};
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

