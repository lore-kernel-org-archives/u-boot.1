Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6629CC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 18:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD08E8798B;
	Thu,  4 Jan 2024 19:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="IvT4Y1dR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D7487989; Thu,  4 Jan 2024 19:53:24 +0100 (CET)
Received: from mx0b-00105401.pphosted.com (mx0b-00105401.pphosted.com
 [67.231.152.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BA4B87966
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 19:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346902.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 404HZise012318; Thu, 4 Jan 2024 18:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=POD051818;
 bh=JqkHZvDZrmtTvlF/atK/d/HbNYYeilSic2d5Zf9nfN8=;
 b=IvT4Y1dR2TmkeaAx84b446f0f0Ut+LsNlTvfcTT7yZ2997VJlHRR9CSVwpZ3UQ1JXuTv
 sSfjzzUOQJ3VCRaunW14l3Jty6KnmSu1nUJBKf10KRPabssBXd9uoaFpHjoF8+AEQsDk
 1MgMymFEvO6ZGYWKmp6gcJHbJWF9fllOcUpw/uyzA9f37l4zL1Bm7UqkPzXe6ybyiu0k
 xhuDc0yI6nbb/hvmhmGAhzfpGtxUEWYEMFn+dczfQDeLTgLOMY96EzQQ/6HB3fBOy5G4
 cL1PlEssqk6l3zt4fVaUyHTExQ9boBklN4Cc2YYTtTNHzIE61FbV7VM6cFjm0erMARaV pg== 
Received: from xusxph004rp050.rtx.com (xusxph004rp050.rtx.com [128.13.120.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3ve179hbx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 04 Jan 2024 18:53:19 +0000
Received: from xusxph005rp020.corp.ray.com ([128.13.121.224])
 by xusxph004rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 404IrI5v006936
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jan 2024 18:53:18 GMT
Received: from dtulimr01.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph005rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 404IrHLP013712
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Jan 2024 18:53:17 GMT
X-Received: from bspbox.kirk (kirk.rockwellcollins.lab [10.148.204.208])
 by dtulimr01.rockwellcollins.com (Postfix) with ESMTP id 3B7E7600C1;
 Thu,  4 Jan 2024 12:53:17 -0600 (CST)
From: Brandon Maier <brandon.maier@collins.com>
To: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Cc: Brandon Maier <brandon.maier@collins.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 u-boot@lists.denx.de
Subject: [PATCH 4/4] tools: zynqmpimage: print partition names
Date: Thu,  4 Jan 2024 18:50:09 +0000
Message-ID: <20240104185258.39465-4-brandon.maier@collins.com>
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
 mlxlogscore=958 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040147
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 malwarescore=0 mlxlogscore=884 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040147
X-Proofpoint-ORIG-GUID: GX_JqvzKL6v0xNlTyq6TL7jF7yli67Az
X-Proofpoint-GUID: GX_JqvzKL6v0xNlTyq6TL7jF7yli67Az
X-Proofpoint-Spam-Details: rule=outbound_default_notspam
 policy=outbound_default score=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
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

Each partition may belong to an image, which has a name. That name can
be useful for debugging as it helps identify where the partition came
from.

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
---

 tools/zynqmpimage.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
 tools/zynqmpimage.h | 49 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
index 307edd63ebb..4db9877127e 100644
--- a/tools/zynqmpimage.c
+++ b/tools/zynqmpimage.c
@@ -135,6 +135,53 @@ static int zynqmpimage_verify_header(unsigned char *ptr, int image_size,
 	return 0;
 }
 
+static struct image_header *
+find_partition_image(const struct zynqmp_header *zynqhdr,
+		     const struct partition_header *ph)
+{
+	struct partition_header *ph_walk;
+	struct image_header *ih;
+	int i;
+
+	for_each_zynqmp_image(zynqhdr, ih) {
+		for_each_zynqmp_part_in_image(zynqhdr, i, ph_walk, ih) {
+			if (ph == ph_walk)
+				return ih;
+		}
+	}
+
+	return NULL;
+}
+
+static void print_partition_name(const struct zynqmp_header *zynqhdr,
+				 const struct partition_header *ph)
+{
+	const struct image_header *ih;
+	size_t word_len;
+	char *name;
+	int i;
+
+	ih = find_partition_image(zynqhdr, ph);
+	if (!ih)
+		return;
+
+	/* Name is stored in big-endian words, find the terminating word and
+	 * byte-swap into a new buffer
+	 */
+	word_len = strlen((char *)ih->image_name);
+	word_len = ALIGN(word_len + 1, 4);
+
+	name = calloc(1, word_len);
+	if (!name)
+		return;
+
+	for (i = 0; i < word_len / 4; i++)
+		((uint32_t *)name)[i] = uswap_32(ih->image_name[i]);
+
+	printf("    Image name : %s\n", name);
+	free(name);
+}
+
 static void print_partition(const void *ptr, const struct partition_header *ph)
 {
 	uint32_t attr = le32_to_cpu(ph->attributes);
@@ -163,6 +210,7 @@ static void print_partition(const void *ptr, const struct partition_header *ph)
 	       dest_cpus[(attr & PART_ATTR_DEST_CPU_MASK) >> 8],
 	       dest_devs[(attr & PART_ATTR_DEST_DEVICE_MASK) >> 4]);
 
+	print_partition_name(ptr, ph);
 	printf("    Offset     : 0x%08x\n", le32_to_cpu(ph->offset) * 4);
 	printf("    Size       : %lu (0x%lx) bytes\n", len, len);
 	if (len != len_unenc)
diff --git a/tools/zynqmpimage.h b/tools/zynqmpimage.h
index 32be0d125fd..7c47dc0763b 100644
--- a/tools/zynqmpimage.h
+++ b/tools/zynqmpimage.h
@@ -51,6 +51,14 @@ struct image_header_table {
 	uint32_t checksum;		  /* 0x3c */
 };
 
+struct image_header {
+	uint32_t next_image_header_offset;		/* 0x00 */
+	uint32_t corresponding_partition_header;	/* 0x04 */
+	uint32_t __reserved1;				/* 0x08 */
+	uint32_t partition_count;			/* 0x0c */
+	uint32_t image_name[];				/* 0x10 */
+};
+
 #define PART_ATTR_VEC_LOCATION		0x800000
 #define PART_ATTR_BS_BLOCK_SIZE_MASK	0x700000
 #define     PART_ATTR_BS_BLOCK_SIZE_DEFAULT	0x000000
@@ -193,4 +201,45 @@ static inline size_t zynqmp_part_count(const struct zynqmp_header *zynqhdr)
 			zynqmp_part_first(_zynqhdr), \
 			zynqmp_part_count(_zynqhdr))
 
+static inline struct partition_header *
+zynqmp_part_in_image_first(const struct zynqmp_header *zynqhdr,
+			   const struct image_header *ih)
+{
+	return zynqmp_get_offset(zynqhdr, ih->corresponding_partition_header);
+}
+
+static inline size_t zynqmp_part_in_image_count(const struct image_header *ih)
+{
+	return le32_to_cpu(ih->partition_count);
+}
+
+#define for_each_zynqmp_part_in_image(_zynqhdr, _iter, _ph, _ih) \
+	_for_each_zynqmp_part(_zynqhdr, _iter, _ph, \
+			zynqmp_part_in_image_first(_zynqhdr, _ih), \
+			zynqmp_part_in_image_count(_ih))
+
+static inline struct image_header *
+zynqmp_image_first(const struct zynqmp_header *zynqhdr)
+{
+	struct image_header_table *iht;
+
+	iht = zynqmp_get_iht(zynqhdr);
+	if (!iht)
+		return NULL;
+
+	return zynqmp_get_offset(zynqhdr, iht->image_header_offset);
+}
+
+static inline struct image_header *
+zynqmp_image_next(const struct zynqmp_header *zynqhdr,
+		  const struct image_header *ih)
+{
+	return zynqmp_get_offset(zynqhdr, ih->next_image_header_offset);
+}
+
+#define for_each_zynqmp_image(_zynqhdr, _ih) \
+	for (_ih = zynqmp_image_first(_zynqhdr); \
+	     _ih; \
+	     _ih = zynqmp_image_next(_zynqhdr, _ih))
+
 #endif /* _ZYNQMPIMAGE_H_ */
-- 
2.43.0

