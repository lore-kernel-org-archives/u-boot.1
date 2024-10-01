Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BC5CEACEC
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 17:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2479C89232;
	Tue,  1 Oct 2024 19:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="IA37Q6d0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39362891F0; Tue,  1 Oct 2024 15:58:44 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com
 [67.231.157.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA68688D8D
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 15:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brian.ruley@gehealthcare.com
Received: from pps.filterd (m0048299.ppops.net [127.0.0.1])
 by m0048299.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id
 491BnQZP019749
 for <u-boot@lists.denx.de>; Tue, 1 Oct 2024 09:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 outbound; bh=ISOnfkHy6fSM88CoAmzjHw8M9TsV1Y/ZzLFHczXo6Ps=; b=IA3
 7Q6d0PElaQ/aFUXqn/Nv1rvIeT9gi4JBwETDObhf5rkWXXn4fU0ELba+nhHps7qc
 823pGaMSR1X34Co1EYne63pC79kGUpAFCl02Abd9CIwKXa1AuBVsq9PWTF7yi0u1
 TsrRY1wvCMY0vBruvQkUWzg/4zlGAm5XQtACmoxetq8Oy2akBUkSGzkuRvLYGnHF
 E8x92tpdBbBt15TtcAx56CKzixBB6zPmcSwFcIEZxFCBOKxSCgXIEgOgapHRs77C
 cxCsUdyRF37OEGKRq7s25x8dJC0X6G9eqhhvQYxkJZkmHNGgCFXMgYaYdkR7Zq+n
 6eUFvLiPxa+Rv+NPL6Q==
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: ian.ray@gehealthcare.com, Brian Ruley <brian.ruley@gehealthcare.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: [PATCH v4 1/2] binman: cosmetic: refactor `nxp_imx8mcst' etype code
Date: Tue,  1 Oct 2024 16:58:08 +0300
Message-Id: <20241001135810.96-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240930161006.41052-1-brian.ruley@gehealthcare.com>
References: <20240930161006.41052-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7d__C5HQ6nghSoxZaJS-fQ62uvk7CuZY
X-Proofpoint-GUID: 7d__C5HQ6nghSoxZaJS-fQ62uvk7CuZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0
 mlxlogscore=982 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010090
X-Mailman-Approved-At: Tue, 01 Oct 2024 19:17:42 +0200
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

Simplify code and conform to the style guide used in the project by
making the following changes:
* Capitalize global constants
* Use single quotes for multiline strings (except docstrings)
* Fix line width to 79 cols
* Use f-string instead of formatting a regular string or using a
  complicated concatenation
* Move common suffix used in keys to a global variable "KEY_NAME"
  to reduce the likelihood of typos and making future changes
  easier

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Marek Vasut <marex@denx.de>
---
Changes for v4:
- expand f-string usage, add common information to variable, capitalize
  constants

 tools/binman/etype/nxp_imx8mcst.py | 36 +++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index 8221517b0c..bd5a5d805f 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -23,7 +23,9 @@ from u_boot_pylib import tools
 MAGIC_NXP_IMX_IVT = 0x412000d1
 MAGIC_FITIMAGE    = 0xedfe0dd0
 
-csf_config_template = """
+KEY_NAME = 'sha256_4096_65537_v3_usr_crt'
+
+CSF_CONFIG_TEMPLATE = f'''
 [Header]
   Version = 4.3
   Hash Algorithm = sha256
@@ -37,7 +39,7 @@ csf_config_template = """
   Source index = 0
 
 [Install CSFK]
-  File = "CSF1_1_sha256_4096_65537_v3_usr_crt.pem"
+  File = "CSF1_1_{KEY_NAME}.pem"
 
 [Authenticate CSF]
 
@@ -48,12 +50,12 @@ csf_config_template = """
 [Install Key]
   Verification index = 0
   Target Index = 2
-  File = "IMG1_1_sha256_4096_65537_v3_usr_crt.pem"
+  File = "IMG1_1_{KEY_NAME}.pem"
 
 [Authenticate Data]
   Verification index = 2
   Blocks = 0x1234 0x78 0xabcd "data.bin"
-"""
+'''
 
 class Entry_nxp_imx8mcst(Entry_mkimage):
     """NXP i.MX8M CST .cfg file generator and cst invoker
@@ -69,9 +71,15 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
     def ReadNode(self):
         super().ReadNode()
         self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
-        self.srk_table = os.getenv('SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4_table.bin'))
-        self.csf_crt = os.getenv('CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt', 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
-        self.img_crt = os.getenv('IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt', 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
+        self.srk_table = os.getenv(
+            'SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table',
+                                            'SRK_1_2_3_4_table.bin'))
+        self.csf_crt = os.getenv(
+            'CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt',
+                                          f'CSF1_1_{KEY_NAME}.pem'))
+        self.img_crt = os.getenv(
+            'IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt',
+                                          f'IMG1_1_{KEY_NAME}.pem'))
         self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
         self.ReadEntries()
 
@@ -118,16 +126,18 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         tools.write_file(output_dname, data)
 
         # Generate CST configuration file used to sign payload
-        cfg_fname = tools.get_output_filename('nxp.csf-config-txt.%s' % uniq)
+        cfg_fname = tools.get_output_filename(f'nxp.csf-config-txt.{uniq}')
         config = configparser.ConfigParser()
         # Do not make key names lowercase
         config.optionxform = str
         # Load configuration template and modify keys of interest
-        config.read_string(csf_config_template)
-        config['Install SRK']['File'] = '"' + self.srk_table + '"'
-        config['Install CSFK']['File'] = '"' + self.csf_crt + '"'
-        config['Install Key']['File'] = '"' + self.img_crt + '"'
-        config['Authenticate Data']['Blocks'] = hex(signbase) + ' 0 ' + hex(len(data)) + ' "' + str(output_dname) + '"'
+        config.read_string(CSF_CONFIG_TEMPLATE)
+        config['Install SRK']['File']  = f'"{self.srk_table}"'
+        config['Install CSFK']['File'] = f'"{self.csf_crt}"'
+        config['Install Key']['File']  = f'"{self.img_crt}"'
+        config['Authenticate Data']['Blocks'] = \
+            f'{signbase:#x} 0 {len(data):#x} "{output_dname}"'
+
         if not self.unlock:
             config.remove_section('Unlock')
         with open(cfg_fname, 'w') as cfgf:
-- 
2.39.5

