Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F227C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 18:53:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08BF8797D;
	Thu,  4 Jan 2024 19:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collins.com header.i=@collins.com header.b="tzqspJvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5338E8799E; Thu,  4 Jan 2024 19:53:21 +0100 (CET)
Received: from mx0b-00105401.pphosted.com (mx0b-00105401.pphosted.com
 [67.231.152.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D548E8795E
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 19:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=collins.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brandon.maier@collins.com
Received: from pps.filterd (m0346902.ppops.net [127.0.0.1])
 by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 404HZjPZ012388; Thu, 4 Jan 2024 18:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=POD051818;
 bh=WXaeJ1IyrH5Wwdah9MLbKbJLouIXe7Q0SqoGi/QoWMY=;
 b=tzqspJvXSqEWZFzeqKx0wYxdYuLGUFXWigLtbNxx0NOTZgaRd8gkv07htOfkFiwUr2sc
 IBs1uuWCQR5RUl+sVvqvdrGZSIH81B98XPOcva2Ks8nkuGlcZwQUw9lcPg4b3ZqiNOJM
 /HyfUKyUx7t9nkV2d6o4FgdXLuxD3Mp1gTD2TRpusbTf35KAzQ8aqNGuKVC5XFs+2yBQ
 ANDO1FF3gr/DjtylsuJTp7bXZZSMyMkObEaKJO7FHGXeZdkwMt9cy8ffnp+hYy8jHfiA
 7qBAsro9lg1BLRL9MggyCuhh8xx7g4goLoM7US2ls4kyvklayBZfXLRCXAxPP8g+0TSu Cg== 
Received: from xusxph005rp050.rtx.com (xusxph005rp050.rtx.com [128.13.121.147])
 by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3ve179hbw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 04 Jan 2024 18:53:15 +0000
Received: from xusxph005rp020.corp.ray.com ([128.13.121.224])
 by xusxph005rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 404IrEW5017555
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jan 2024 18:53:14 GMT
Received: from dtulimr01.rockwellcollins.com
 (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
 by xusxph005rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id
 404IrEx6013688
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Jan 2024 18:53:14 GMT
X-Received: from bspbox.kirk (kirk.rockwellcollins.lab [10.148.204.208])
 by dtulimr01.rockwellcollins.com (Postfix) with ESMTP id CCCDB600C1;
 Thu,  4 Jan 2024 12:53:13 -0600 (CST)
From: Brandon Maier <brandon.maier@collins.com>
To: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Cc: Brandon Maier <brandon.maier@collins.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/4] tools: zynqmpimage: print all partition sizes
Date: Thu,  4 Jan 2024 18:50:07 +0000
Message-ID: <20240104185258.39465-2-brandon.maier@collins.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040147
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040147
X-Proofpoint-ORIG-GUID: Jm79dRo_iedTcoQq0Ebe6djhDMjwr6V9
X-Proofpoint-GUID: Jm79dRo_iedTcoQq0Ebe6djhDMjwr6V9
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

Two of the partition size fields are not printed. Currently only the
"total" size is displayed, which is the size of the image data
(encrypted), padding, expansion, and authentication data. Add the
"unencrypted data" size, which is the original size of the data before
being encrypted. And "encrypted data" size, which is just the encrypted
data.

To avoid printing useless information, only print the encrypted and
unencrypted sizes if they are different from the total.

Signed-off-by: Brandon Maier <brandon.maier@collins.com>
---

 tools/zynqmpimage.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/zynqmpimage.c b/tools/zynqmpimage.c
index 05af1e81a24..2795a2b9a77 100644
--- a/tools/zynqmpimage.c
+++ b/tools/zynqmpimage.c
@@ -139,6 +139,8 @@ static void print_partition(const void *ptr, const struct partition_header *ph)
 {
 	uint32_t attr = le32_to_cpu(ph->attributes);
 	unsigned long len = le32_to_cpu(ph->len) * 4;
+	unsigned long len_enc = le32_to_cpu(ph->len_enc) * 4;
+	unsigned long len_unenc = le32_to_cpu(ph->len_unenc) * 4;
 	const char *part_owner;
 	const char *dest_devs[0x8] = {
 		"none", "PS", "PL", "PMU", "unknown", "unknown", "unknown",
@@ -163,6 +165,10 @@ static void print_partition(const void *ptr, const struct partition_header *ph)
 
 	printf("    Offset     : 0x%08x\n", le32_to_cpu(ph->offset) * 4);
 	printf("    Size       : %lu (0x%lx) bytes\n", len, len);
+	if (len != len_unenc)
+		printf("    Size Data  : %lu (0x%lx) bytes\n", len_unenc, len_unenc);
+	if (len_unenc != len_enc)
+		printf("    Size Enc   : %lu (0x%lx) bytes\n", len_unenc, len_unenc);
 	printf("    Load       : 0x%08llx",
 	       (unsigned long long)le64_to_cpu(ph->load_address));
 	if (ph->load_address != ph->entry_point)
-- 
2.43.0

