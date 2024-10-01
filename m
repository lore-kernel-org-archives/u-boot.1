Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C31CEACEA
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 17:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB6789243;
	Tue,  1 Oct 2024 19:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="quElwvKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEEC88D8D; Tue,  1 Oct 2024 15:58:44 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com
 [67.231.157.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 459DE891E3
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 15:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brian.ruley@gehealthcare.com
Received: from pps.filterd (m0048206.ppops.net [127.0.0.1])
 by m0048206.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id
 491Dbf0b034082
 for <u-boot@lists.denx.de>; Tue, 1 Oct 2024 09:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 outbound; bh=iA+/KjX3hCZ66i96Ts8Fx0fSEec7pNZTDR48mMUUAUY=; b=quE
 lwvKEhASBJ17DRn7qLzy9+LWN0Hz6zGwLFlJtTK74O/aCWpUJU/6amfOFUOEn8XA
 HvNuwoWk8/E447ZW/6Vdz1tgAaLzCu3mLN2DB7SOZLYFvd3C02jmsVCZSjEwsq2e
 EuZrHefYf9VHc43QUWmaAYVSqSStFV1B41VW87Zu//SecgHa32WpWrzFuodEaZUz
 mz2BSgUGGt7F9y2tyiWLsAiRV0JLRoCHNfsA8FuOR0FOaLE7sdCNzD05N3sumhwG
 wbD+RVZACs+Zary2efYokKTQoX+IfV8m9BcqovRjI7yUFJ2OFqIaj3arxcTQuCkR
 lmlwsmw7OTOV2kaTNFQ==
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: ian.ray@gehealthcare.com, Brian Ruley <brian.ruley@gehealthcare.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: [PATCH v4 2/2] binman: add fast authentication method for i.MX8M
 signing
Date: Tue,  1 Oct 2024 16:58:09 +0300
Message-Id: <20241001135810.96-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001135810.96-1-brian.ruley@gehealthcare.com>
References: <20240930161006.41052-1-brian.ruley@gehealthcare.com>
 <20241001135810.96-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: h1nrvV6zrSzuH-zGZebvACy1Yn8G5BS3
X-Proofpoint-ORIG-GUID: h1nrvV6zrSzuH-zGZebvACy1Yn8G5BS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_10,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010090
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

Using the PKI tree with SRKs as intermediate CA isn't necessary or even
desirable in some situations (boot time, for example). Add the possibility
to use the "fast authentication" method where the image and CSF are both
signed using the SRK [1, p.63].

[1] https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/202591/1/CST_UG.pdf

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Marek Vasut <marex@denx.de>
---
Changes for v2:
- fixed default key length (s/2048/4096) for srk-crt node
Changes for v3:
- code formatting
Changes for v4:
- fix spelling in commit message
- code formatting

 tools/binman/etype/nxp_imx8mcst.py | 34 +++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index bd5a5d805f..a7d8db4eec 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -38,6 +38,9 @@ CSF_CONFIG_TEMPLATE = f'''
   File = "SRK_1_2_3_4_table.bin"
   Source index = 0
 
+[Install NOCAK]
+  File = "SRK1_{KEY_NAME}.pem"
+
 [Install CSFK]
   File = "CSF1_1_{KEY_NAME}.pem"
 
@@ -74,12 +77,19 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         self.srk_table = os.getenv(
             'SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table',
                                             'SRK_1_2_3_4_table.bin'))
-        self.csf_crt = os.getenv(
-            'CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt',
-                                          f'CSF1_1_{KEY_NAME}.pem'))
-        self.img_crt = os.getenv(
-            'IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt',
-                                          f'IMG1_1_{KEY_NAME}.pem'))
+        self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
+        if not self.fast_auth:
+            self.csf_crt = os.getenv(
+                'CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt',
+                                              f'CSF1_1_{KEY_NAME}.pem'))
+            self.img_crt = os.getenv(
+                'IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt',
+                                              f'IMG1_1_{KEY_NAME}.pem'))
+        else:
+            self.srk_crt = os.getenv(
+                'SRK_KEY', fdt_util.GetString(self._node, 'nxp,srk-crt',
+                                              f'SRK1_{KEY_NAME}.pem'))
+
         self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
         self.ReadEntries()
 
@@ -133,8 +143,16 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         # Load configuration template and modify keys of interest
         config.read_string(CSF_CONFIG_TEMPLATE)
         config['Install SRK']['File']  = f'"{self.srk_table}"'
-        config['Install CSFK']['File'] = f'"{self.csf_crt}"'
-        config['Install Key']['File']  = f'"{self.img_crt}"'
+        if not self.fast_auth:
+            config.remove_section('Install NOCAK')
+            config['Install CSFK']['File'] = f'"{self.csf_crt}"'
+            config['Install Key']['File']  = f'"{self.img_crt}"'
+        else:
+            config.remove_section('Install CSFK')
+            config.remove_section('Install Key')
+            config['Install NOCAK']['File'] = f'"{self.srk_crt}"'
+            config['Authenticate Data']['Verification index'] = '0'
+
         config['Authenticate Data']['Blocks'] = \
             f'{signbase:#x} 0 {len(data):#x} "{output_dname}"'
 
-- 
2.39.5

