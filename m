Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322F4CF64B1
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 13:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 285F488F04;
	Mon, 30 Sep 2024 15:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="EMyddt/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1300488E07; Mon, 30 Sep 2024 12:22:01 +0200 (CEST)
Received: from mx0a-00176a03.pphosted.com (mx0a-00176a03.pphosted.com
 [67.231.149.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 709CC88DE8
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 12:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brian.ruley@gehealthcare.com
Received: from pps.filterd (m0047961.ppops.net [127.0.0.1])
 by m0047961.ppops.net-00176a03. (8.18.1.2/8.18.1.2) with ESMTP id
 48U6UNQ8002420
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 06:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 gehealthcare.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 outbound; bh=05eK4B5xnasFn6di928A5HoSQIQP28wJ8AL6HIiaZqY=; b=EMy
 ddt/C359FsZeZ/n+Uui/sHZWzh+6ppKLsgP7OuPd/Ff5vI0KMPgI15DwHS1r/Ar8
 9q1HaGA0yMNJTcNjFCF+HCMC4ZyJKg32T43Q+B0kBrWsKsL9euS7RvLf/DmLxrJc
 +5xS0Tb9fbxHraeOlsqg05l1rwBHlhKWtaU8LTS8Z7b0B9WxfvN6rlTlaXR9TG9t
 1QHOn3M2Rj6rcRZx5COw/381M0aiTXAtQipYKFggFsRMPXeOs8wFwofH7yDH3Gn3
 Kfl8hb2AkY65lmdHNOSqsChaW80EI4X90y2z8NnytXTAgNsHOtPrd7ZrVlxHa0LM
 vkW76RIxEgpKiBKVQ5A==
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: ian.ray@gehealthcare.com, Brian Ruley <brian.ruley@gehealthcare.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: [PATCH v2] binman: add fast authentication method for i.MX8M signing
Date: Mon, 30 Sep 2024 13:21:48 +0300
Message-Id: <20240930102148.854-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240927124237.47-1-brian.ruley@gehealthcare.com>
References: <20240927124237.47-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: g3vOSssK0nKwjlsPxc-yIl1zFuIIET2i
X-Proofpoint-ORIG-GUID: g3vOSssK0nKwjlsPxc-yIl1zFuIIET2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_09,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300073
X-Mailman-Approved-At: Mon, 30 Sep 2024 15:00:33 +0200
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
desirable in some situations (boot time, for example). Add the possbility
to use the "fast authentication" method where the image and CSF are both
signed using the SRK [1, p.63].

[1] https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/202591/1/CST_UG.pdf

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Marek Vasut <marex@denx.de>
---
Changes for v2:
- fixed default key length (s/2048/4096) for srk-crt node 

 tools/binman/etype/nxp_imx8mcst.py | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)
---
 tools/binman/etype/nxp_imx8mcst.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
index 8221517b0c..93fec1a914 100644
--- a/tools/binman/etype/nxp_imx8mcst.py
+++ b/tools/binman/etype/nxp_imx8mcst.py
@@ -36,6 +36,9 @@ csf_config_template = """
   File = "SRK_1_2_3_4_table.bin"
   Source index = 0
 
+[Install NOCAK]
+  File = "SRK1_sha256_4096_65537_v3_usr_crt.pem"
+
 [Install CSFK]
   File = "CSF1_1_sha256_4096_65537_v3_usr_crt.pem"
 
@@ -70,8 +73,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         super().ReadNode()
         self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
         self.srk_table = os.getenv('SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4_table.bin'))
-        self.csf_crt = os.getenv('CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt', 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
-        self.img_crt = os.getenv('IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt', 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
+        self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
+        if not self.fast_auth:
+            self.csf_crt = os.getenv('CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt', 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
+            self.img_crt = os.getenv('IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt', 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
+        else:
+            self.srk_crt = os.getenv('SRK_KEY', fdt_util.GetString(self._node, 'nxp,srk-crt', 'SRK1_sha256_4096_65537_v3_usr_crt.pem'))
+
         self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
         self.ReadEntries()
 
@@ -125,8 +133,16 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
         # Load configuration template and modify keys of interest
         config.read_string(csf_config_template)
         config['Install SRK']['File'] = '"' + self.srk_table + '"'
-        config['Install CSFK']['File'] = '"' + self.csf_crt + '"'
-        config['Install Key']['File'] = '"' + self.img_crt + '"'
+        if not self.fast_auth:
+            config.remove_section('Install NOCAK')
+            config['Install CSFK']['File'] = '"' + self.csf_crt + '"'
+            config['Install Key']['File'] = '"' + self.img_crt + '"'
+        else:
+            config.remove_section('Install CSFK')
+            config.remove_section('Install Key')
+            config['Install NOCAK']['File'] = '"' + self.srk_crt + '"'
+            config['Authenticate Data']['Verification index'] = '0'
+
         config['Authenticate Data']['Blocks'] = hex(signbase) + ' 0 ' + hex(len(data)) + ' "' + str(output_dname) + '"'
         if not self.unlock:
             config.remove_section('Unlock')
-- 
2.39.5

