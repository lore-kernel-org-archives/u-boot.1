Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2125AC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 10:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3747781FC0;
	Mon, 24 Mar 2025 11:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="kN/nRSBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0185C81FC0; Mon, 24 Mar 2025 11:01:53 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AEA081FAA
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PLN8025897;
 Mon, 24 Mar 2025 10:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gdSstsF7xCr0Ba0A3SYX9QKRapx1tFvIiaevmaOe9OE=; b=kN/nRSBgZ+mRjq5y
 zULKmBTtTP/qHXxWxpURDEm8iLmJKOE68w9rxOyx3O70iGRDEBDORqwT34PkX6l+
 0vKyDFTlMAz/+FosU1zUMqymhdJxkuv60OlBP+ZBwipNjRYAd1AYF28ECYq2bq2a
 /9lbL4AsDS3XBEVsf6IFwSFJJigJGGfYBEgcSvNHMqTaU5z43KO/2BbeWtkQZ1W6
 OWk7Qd9oO/pVQkXY6hkAuiM8oSSA9vRT6XWGnSZpupyPEY24C5JssGTZYxgCGrQT
 vyyrwTH7JbGq60zCL3e2SnoYdqDEniP1qXVZoYKZ33vsSo2Jf0R0h1lt8N6cP09c
 Wht0YQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hjjnm5k9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Mar 2025 10:01:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52OA1h8s006576
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Mar 2025 10:01:43 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Mar 2025 03:01:41 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <caleb.connolly@linaro.org>, <trini@konsulko.com>,
 <quic_varada@quicinc.com>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <lehmanju@devpi.de>, <u-boot@lists.denx.de>
Subject: [PATCH v1 2/2] drivers: scsi: Add 'erase' support
Date: Mon, 24 Mar 2025 15:31:21 +0530
Message-ID: <20250324100121.2490314-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324100121.2490314-1-quic_varada@quicinc.com>
References: <20250324100121.2490314-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=fNc53Yae c=1 sm=1 tr=0 ts=67e12d88 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=SvCO5ObyoP72JHIIDYoA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: DcKiWB4Kws1dim3IjYzZXN0yRePfwOD2
X-Proofpoint-GUID: DcKiWB4Kws1dim3IjYzZXN0yRePfwOD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240073
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

UFS devices uses the block and scsi frameworks. Enable UFS erase
support by adding erase support to SCSI.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 cmd/scsi.c          |  3 +-
 drivers/scsi/scsi.c | 92 +++++++++++++++++++++++++++++++++++++++++++++
 include/scsi.h      | 13 +++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/cmd/scsi.c b/cmd/scsi.c
index c286bdc0726..9f7613424e5 100644
--- a/cmd/scsi.c
+++ b/cmd/scsi.c
@@ -60,7 +60,8 @@ U_BOOT_CMD(
 	"scsi read addr blk# cnt - read `cnt' blocks starting at block `blk#'\n"
 	"     to memory address `addr'\n"
 	"scsi write addr blk# cnt - write `cnt' blocks starting at block\n"
-	"     `blk#' from memory address `addr'"
+	"     `blk#' from memory address `addr'\n"
+	"scsi erase blk# cnt - erase `cnt' blocks starting at block `blk#'"
 );
 
 U_BOOT_CMD(
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index cd0b84c0622..dc93392642d 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -28,6 +28,10 @@ DEFINE_CACHE_ALIGN_BUFFER(u8, tempbuff, 512);	/* temporary data buffer */
 #define SCSI_MAX_BLK 0xFFFF
 #define SCSI_LBA48_READ	0xFFFFFFF
 
+#define SCSI_UNMAP_PARAM_RESERVED 0
+#define SCSI_UNMAP_PARAM_LEN 22
+#define SCSI_UNMAP_PARAM_DATA_LEN 16
+
 static void scsi_print_error(struct scsi_cmd *pccb)
 {
 	/* Dummy function that could print an error for debugging */
@@ -121,6 +125,51 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
 	      pccb->cmd[7], pccb->cmd[8]);
 }
 
+static void scsi_setup_erase_ext(struct scsi_cmd *pccb, lbaint_t start,
+				 unsigned short blocks)
+{
+	u8 *param = tempbuff;
+	const u8 param_size = 24;
+
+	memset(param, 0, param_size);
+	param[0] = SCSI_UNMAP_PARAM_RESERVED;
+	param[1] = SCSI_UNMAP_PARAM_LEN;
+	param[2] = SCSI_UNMAP_PARAM_RESERVED;
+	param[3] = SCSI_UNMAP_PARAM_DATA_LEN;
+
+	param[8]  = 0x0;
+	param[9]  = 0x0;
+	param[10] = 0x0;
+	param[11] = 0x0;
+	param[12] = (start >> 24) & 0xff;
+	param[13] = (start >> 16) & 0xff;
+	param[14] = (start >> 8) & 0xff;
+	param[15] = (start) & 0xff;
+	param[16] = (blocks >> 24) & 0xff;
+	param[17] = (blocks >> 16) & 0xff;
+	param[18] = (blocks >> 8) & 0xff;
+	param[19] = (blocks) & 0xff;
+
+	memset(pccb->cmd, 0, sizeof(pccb->cmd));
+	pccb->cmd[0] = SCSI_UNMAP;
+	pccb->cmd[1] = 0;
+	pccb->cmd[6] = 0;
+	pccb->cmd[7] = 0;
+	pccb->cmd[8] = param_size;
+	pccb->cmd[9] = 0;
+	pccb->cmdlen = 10;
+
+	pccb->pdata = param;
+	pccb->datalen = param_size;
+	pccb->dma_dir = DMA_TO_DEVICE;
+
+	debug("%s: cmd: %02X %02X startblk %02X%02X%02X%02X blccnt %02X%02X\n",
+	      __func__,
+	      pccb->cmd[0], pccb->cmd[1],
+	      pccb->cmd[2], pccb->cmd[3], pccb->cmd[4], pccb->cmd[5],
+	      pccb->cmd[7], pccb->cmd[8]);
+}
+
 static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		       void *buffer)
 {
@@ -245,6 +294,48 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 	return blkcnt;
 }
 
+/*******************************************************************************
+ * scsi_erase
+ */
+static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
+{
+	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
+	struct udevice *bdev = dev->parent;
+	struct scsi_plat *uc_plat = dev_get_uclass_plat(bdev);
+	lbaint_t start, blks, max_blks;
+	struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
+
+	/* Setup device */
+	pccb->target = block_dev->target;
+	pccb->lun = block_dev->lun;
+	start = blknr;
+	blks = blkcnt;
+	if (uc_plat->max_bytes_per_req)
+		max_blks = uc_plat->max_bytes_per_req / block_dev->blksz;
+	else
+		max_blks = SCSI_MAX_BLK;
+
+	debug("\n%s: dev %d startblk " LBAF ", blccnt " LBAF "\n",
+	      __func__, block_dev->devnum, start, blks);
+	do {
+		if (blks > max_blks) {
+			scsi_setup_erase_ext(pccb, start, max_blks);
+			start += max_blks;
+			blks -= max_blks;
+		} else {
+			scsi_setup_erase_ext(pccb, start, blks);
+			start += blks;
+			blks = 0;
+		}
+		if (scsi_exec(bdev, pccb)) {
+			scsi_print_error(pccb);
+			blkcnt -= blks;
+			break;
+		}
+	} while (blks != 0);
+	return blkcnt;
+}
+
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 static int scsi_buffer_aligned(struct udevice *dev, struct bounce_buffer *state)
 {
@@ -592,6 +683,7 @@ int scsi_scan(bool verbose)
 static const struct blk_ops scsi_blk_ops = {
 	.read	= scsi_read,
 	.write	= scsi_write,
+	.erase  = scsi_erase,
 #if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
 	.buffer_aligned	= scsi_buffer_aligned,
 #endif	/* CONFIG_BOUNCE_BUFFER */
diff --git a/include/scsi.h b/include/scsi.h
index b18ae37b861..d6b6e6b665f 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -9,6 +9,7 @@
 #include <asm/cache.h>
 #include <bouncebuf.h>
 #include <linux/dma-direction.h>
+#include <part.h>
 
 struct udevice;
 
@@ -181,6 +182,7 @@ struct scsi_cmd {
 #define SCSI_WRT_VERIFY	0x2E		/* Write and Verify (O) */
 #define SCSI_WRITE_LONG	0x3F		/* Write Long (O) */
 #define SCSI_WRITE_SAME	0x41		/* Write Same (O) */
+#define SCSI_UNMAP	0x42		/* Write 10-Byte (MANDATORY) */
 
 /**
  * enum scsi_cmd_phase - current phase of the SCSI protocol
@@ -349,6 +351,17 @@ int scsi_scan(bool verbose);
  */
 int scsi_scan_dev(struct udevice *dev, bool verbose);
 
+/**
+ * scsi_get_blk() - Provides SCSI partition information.
+ *
+ * @partition_name: Partition name for fetching its info
+ * @blk_desc_ptr:   Provides the blk descriptor
+ * @part_info_ptr:  Provides partition info
+ */
+int scsi_get_blk(const char *partition_name,
+		 struct blk_desc **blk_desc_ptr,
+		 struct disk_partition *part_info_ptr);
+
 #define SCSI_IDENTIFY					0xC0  /* not used */
 
 /* Hardware errors  */
-- 
2.34.1

