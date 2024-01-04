Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5BBC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 18:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 662648795E;
	Thu,  4 Jan 2024 19:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="eqWoDRv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78FFC8793E; Thu,  4 Jan 2024 19:53:23 +0100 (CET)
Received: from mx0b-00105401.pphosted.com (mx0b-00105401.pphosted.com
 [67.231.152.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 568DC8795E
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 19:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346901.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 404HUN9Q015064; Thu, 4 Jan 2024 18:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=POD051818;
 bh=sGOJ9pzkgWYSPddaI2RPFiqGoJZZIWynkZjGcUAZnF4=;
 b=eqWoDRv4rvyliFOSsf/C72YqIZsR3F6FiSKQO/rISV7JAWanbALz+BVeYY+H15qGNGhE
 2RpfhgTWJLJceBqv+2Tknc7EzDznicihQ920nwcrPtiqMw+XAdgly5zSnvnfwjXYcxT7
 HvEw9Cm1W7tRGPfJJYJu/qiieml6PFanhnoMKSJkKpxawkQ8fTMN+sWcn1f0On1sTaxb
 2cElVaCvN7p6DHJEH5ib8mvlt9NYLtfF+NWEUNlxLBgo6zkW+dFy2u0kDBQt+wBs54wS
 71UtWPXbwZjcLEdjH8Z4HXB2uNCW1LHWHMJCpLfFaSZHGDHTQOTPHt/5HEEjOukVSDH8 aA== 
Received: from xusxph004rp050.rtx.com (xusxph004rp050.rtx.com [128.13.120.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3ve14a9eec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 04 Jan 2024 18:53:18 +0000
Received: from xusxph008rp020.corp.ray.com ([128.13.124.224])
 by xusxph004rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 404IrHQ6006925
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jan 2024 18:53:17 GMT
Received: from dtulimr01.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph008rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 404IrG1C004868
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Jan 2024 18:53:16 GMT
X-Received: from bspbox.kirk (kirk.rockwellcollins.lab [10.148.204.208])
 by dtulimr01.rockwellcollins.com (Postfix) with ESMTP id 121E8600C1;
 Thu,  4 Jan 2024 12:53:16 -0600 (CST)
From: Brandon Maier <brandon.maier@collins.com>
To: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Cc: Brandon Maier <brandon.maier@collins.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 u-boot@lists.denx.de
Subject: [PATCH 3/4] tools: zynqmpimage: add partition extracting
Date: Thu,  4 Jan 2024 18:50:08 +0000
Message-ID: <20240104185258.39465-3-brandon.maier@collins.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104185258.39465-1-brandon.maier@collins.com>
References: <20240104185258.39465-1-brandon.maier@collins.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 spamscore=0
 mlxlogscore=547 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040147
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=494 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040147
X-Proofpoint-GUID: M7ClqdtPpgsvIJ1BhuN1N7BLejh-tAhT
X-Proofpoint-ORIG-GUID: M7ClqdtPpgsvIJ1BhuN1N7BLejh-tAhT
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0 clxscore=1015
 bulkscore=0 mlxlogscore=647 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401040147
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

Extract partitions from a Xilinx Boot Image using dumpimage.

Add helper for_each_zynqmp_part() to reuse the partition walking code
between the printing and extracting functions.

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
---

 tools/zynqmpimage.c | 57 +++++++++++++++++++++++++++++---------------
 tools/zynqmpimage.h | 58 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 19 deletions(-)

diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
index 2795a2b9a77..307edd63ebb 100644
--- a/tools/zynqmpimage.c
+++ b/tools/zynqmpimage.c
@@ -218,6 +218,7 @@ static void print_partition(const void *ptr, const struct partition_header *ph)
 void zynqmpimage_print_header(const void *ptr, struct image_tool_params *params)
 {
 	struct zynqmp_header *zynqhdr = (struct zynqmp_header *)ptr;
+	struct partition_header *ph;
 	int i;
 
 	printf("Image Type   : Xilinx ZynqMP Boot Image support\n");
@@ -255,23 +256,8 @@ void zynqmpimage_print_header(const void *ptr, struct image_tool_params *params)
 		       le32_to_cpu(zynqhdr->register_init[i].data));
 	}
 
-	if (zynqhdr->image_header_table_offset) {
-		struct image_header_table *iht = (void *)ptr +
-			zynqhdr->image_header_table_offset;
-		struct partition_header *ph;
-		uint32_t ph_offset;
-		uint32_t next;
-		int i;
-
-		ph_offset = le32_to_cpu(iht->partition_header_offset) * 4;
-		ph = (void *)ptr + ph_offset;
-		for (i = 0; i < le32_to_cpu(iht->nr_parts); i++) {
-			next = le32_to_cpu(ph->next_partition_offset) * 4;
-
-			print_partition(ptr, ph);
-
-			ph = (void *)ptr + next;
-		}
+	for_each_zynqmp_part(zynqhdr, i, ph) {
+		print_partition(ptr, ph);
 	}
 
 	free(dynamic_header);
@@ -296,7 +282,7 @@ static int zynqmpimage_check_params(struct image_tool_params *params)
 		return -1;
 	}
 
-	return !(params->lflag || params->dflag);
+	return !(params->lflag || params->dflag || params->outfile);
 }
 
 static int zynqmpimage_check_image_types(uint8_t type)
@@ -431,6 +417,39 @@ static void zynqmpimage_set_header(void *ptr, struct stat *sbuf, int ifd,
 	zynqhdr->checksum = zynqmpimage_checksum(zynqhdr);
 }
 
+static int zynqmpimage_partition_extract(struct zynqmp_header *zynqhdr,
+					 const struct partition_header *ph,
+					 const char *filename)
+{
+	ulong data = (ulong)zynqmp_get_offset(zynqhdr, ph->offset);
+	unsigned long len = le32_to_cpu(ph->len_enc) * 4;
+
+	return imagetool_save_subimage(filename, data, len);
+}
+
+/**
+ * zynqmpimage_extract_contents - retrieve a sub-image component from the image
+ * @ptr: pointer to the image header
+ * @params: command line parameters
+ *
+ * returns:
+ *     zero in case of success or a negative value if fail.
+ */
+static int zynqmpimage_extract_contents(void *ptr, struct image_tool_params *params)
+{
+	struct zynqmp_header *zynqhdr = (struct zynqmp_header *)ptr;
+	struct partition_header *ph;
+	int i;
+
+	for_each_zynqmp_part(zynqhdr, i, ph) {
+		if (i == params->pflag)
+			return zynqmpimage_partition_extract(ptr, ph, params->outfile);
+	}
+
+	printf("No partition found\n");
+	return -1;
+}
+
 static int zynqmpimage_vrec_header(struct image_tool_params *params,
 				   struct image_type_params *tparams)
 {
@@ -484,7 +503,7 @@ U_BOOT_IMAGE_TYPE(
 	zynqmpimage_verify_header,
 	zynqmpimage_print_header,
 	zynqmpimage_set_header,
-	NULL,
+	zynqmpimage_extract_contents,
 	zynqmpimage_check_image_types,
 	NULL,
 	zynqmpimage_vrec_header
diff --git a/tools/zynqmpimage.h b/tools/zynqmpimage.h
index ca7489835a8..32be0d125fd 100644
--- a/tools/zynqmpimage.h
+++ b/tools/zynqmpimage.h
@@ -135,4 +135,62 @@ struct zynqmp_header {
 void zynqmpimage_default_header(struct zynqmp_header *ptr);
 void zynqmpimage_print_header(const void *ptr, struct image_tool_params *params);
 
+static inline struct image_header_table *
+zynqmp_get_iht(const struct zynqmp_header *zynqhdr)
+{
+	if (!zynqhdr->image_header_table_offset)
+		return NULL;
+	return (struct image_header_table *)((void *)zynqhdr + zynqhdr->image_header_table_offset);
+}
+
+static inline void *zynqmp_get_offset(const struct zynqmp_header *zynqhdr,
+				      uint32_t offset)
+{
+	uint32_t offset_cpu = le32_to_cpu(offset);
+
+	if (!offset_cpu)
+		return NULL;
+	return (void *)zynqhdr + offset_cpu * 4;
+}
+
+static inline struct partition_header *
+zynqmp_part_first(const struct zynqmp_header *zynqhdr)
+{
+	struct image_header_table *iht;
+
+	iht = zynqmp_get_iht(zynqhdr);
+	if (!iht)
+		return NULL;
+
+	return zynqmp_get_offset(zynqhdr, iht->partition_header_offset);
+}
+
+static inline struct partition_header *
+zynqmp_part_next(const struct zynqmp_header *zynqhdr,
+		 const struct partition_header *ph)
+{
+	return zynqmp_get_offset(zynqhdr, ph->next_partition_offset);
+}
+
+static inline size_t zynqmp_part_count(const struct zynqmp_header *zynqhdr)
+{
+	struct image_header_table *iht;
+
+	iht = zynqmp_get_iht(zynqhdr);
+	if (!iht)
+		return 0;
+
+	return le32_to_cpu(iht->nr_parts);
+}
+
+#define _for_each_zynqmp_part(_zynqhdr, _iter, _ph, _start, _count) \
+	for (_iter = 0, _ph = _start; \
+	     _iter < (_count) && _ph; \
+	     _iter++, _ph = zynqmp_part_next(_zynqhdr, _ph))
+
+#define for_each_zynqmp_part(_zynqhdr, _iter, _ph) \
+	_for_each_zynqmp_part(_zynqhdr, _iter, _ph, \
+			zynqmp_part_first(_zynqhdr), \
+			zynqmp_part_count(_zynqhdr))
+
 #endif /* _ZYNQMPIMAGE_H_ */
-- 
2.43.0

