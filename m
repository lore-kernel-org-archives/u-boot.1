Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F34ACF11E9
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 12:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E43EA89026;
	Thu, 10 Oct 2024 14:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="Ht2BIXOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7435E88FB5; Thu, 10 Oct 2024 13:25:47 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F40988E9F
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 13:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brian.ruley@gehealthcare.com
Received: from pps.filterd (m0047962.ppops.net [127.0.0.1])
 by m0047962.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id
 49ABLstb003794
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 outbound; bh=5vk6sFLYosbqNJFV9oglLRAth26yxpkLzq6dH/Z4Kq0=; b=Ht2
 BIXOjBRiXpKMw5nWcP88JH7UwBeoWF0SVsXoTEvOiH9rl9zNMlIcgbkd6yKUYLt2
 nEaXnlNv/EMoWZfueMRkgQyjNZzn5xV9wNvqZ5+hdGrDAlParqMYjLAN3aQeZ7j4
 roEq93tzTzheqF+T18PeHRXR47uDq2KSklBQ7KPSvwOcSYGPpRc4d3ePmodOhldf
 i9LhVktbfoDbkjpZYCQGiaQ5S/IvjwNQokVuQMxHyoUn+YMXNpEp3dbpgeSLjNLg
 whiSwzOiUuq0oGHvUHSUl1ZZ63xQlvigj5E/aI/oHiUsxxf2otCThsx9gNiHGCTB
 xJ/btEKTHhLDVBUiKjw==
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: ian.ray@gehealthcare.com, Brian Ruley <brian.ruley@gehealthcare.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/2] binman: nxp_imx8mcst: read certificates from input path
Date: Thu, 10 Oct 2024 14:24:49 +0300
Message-Id: <20241010112451.27242-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
References: <20241007130109.227305-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AxNaI4_B6fOffcTRlOl4vwkiO8M2p6SJ
X-Proofpoint-GUID: AxNaI4_B6fOffcTRlOl4vwkiO8M2p6SJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_08,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=925 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100075
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

Right now, it is unclear where the certificates (and private keys) are
read from if environment variables are unset, and providing complete
paths in the device tree is not ideal. Naturally, it makes sense
to be able to decide where binman should look for the files, regardless
whether the keys are specified in the device tree or not.

Therefore, expand the etype to look for the necessary files from the
input path. Introduce a new variable to provide users the ability to
specify a custom path.

As a consequence of this change, the environment variables used to
specify the keys, e.g., `IMG_KEY', will be searched *relative* to the
input directories.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
 tools/binman/etype/nxp_imx8mcst.py | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index a7d8db4eec..8e544807bb 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -70,23 +70,26 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
     def __init__(self, section, etype, node):
         super().__init__(section, etype, node)
         self.required_props = ['nxp,loader-address']
+        self._cst_key_path = os.getenv('CST_KEY_PATH', None)
+        if self._cst_key_path:
+            tools.set_input_dirs([self._cst_key_path] + tools.indir)
 
     def ReadNode(self):
         super().ReadNode()
         self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
-        self.srk_table = os.getenv(
+        self._srk_table = os.getenv(
             'SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table',
                                             'SRK_1_2_3_4_table.bin'))
         self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
         if not self.fast_auth:
-            self.csf_crt = os.getenv(
+            self._csf_crt = os.getenv(
                 'CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt',
                                               f'CSF1_1_{KEY_NAME}.pem'))
-            self.img_crt = os.getenv(
+            self._img_crt = os.getenv(
                 'IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt',
                                               f'IMG1_1_{KEY_NAME}.pem'))
         else:
-            self.srk_crt = os.getenv(
+            self._srk_crt = os.getenv(
                 'SRK_KEY', fdt_util.GetString(self._node, 'nxp,srk-crt',
                                               f'SRK1_{KEY_NAME}.pem'))
 
@@ -142,15 +145,19 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         config.optionxform = str
         # Load configuration template and modify keys of interest
         config.read_string(CSF_CONFIG_TEMPLATE)
-        config['Install SRK']['File']  = f'"{self.srk_table}"'
+        srk_table = tools.get_input_filename(self._srk_table)
+        config['Install SRK']['File']  = f'"{srk_table}"'
         if not self.fast_auth:
+            csf_crt = tools.get_input_filename(self._csf_crt)
+            img_crt = tools.get_input_filename(self._img_crt)
             config.remove_section('Install NOCAK')
-            config['Install CSFK']['File'] = f'"{self.csf_crt}"'
-            config['Install Key']['File']  = f'"{self.img_crt}"'
+            config['Install CSFK']['File'] = f'"{csf_crt}"'
+            config['Install Key']['File']  = f'"{img_crt}"'
         else:
+            srk_crt = tools.get_input_filename(self._srk_crt)
             config.remove_section('Install CSFK')
             config.remove_section('Install Key')
-            config['Install NOCAK']['File'] = f'"{self.srk_crt}"'
+            config['Install NOCAK']['File'] = f'"{srk_crt}"'
             config['Authenticate Data']['Verification index'] = '0'
 
         config['Authenticate Data']['Blocks'] = \
-- 
2.39.5

