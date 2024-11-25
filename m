Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54A1D58060
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 11:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687B98965D;
	Mon, 25 Nov 2024 12:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="SoxFYFVE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 327A1899EA; Mon, 25 Nov 2024 12:04:45 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B26FF89656
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APALGGt016629;
 Mon, 25 Nov 2024 11:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=QayI5qDVewt3QYBn4Gz2q/
 ZK8rjtV8bjEJdR/NOAPuE=; b=SoxFYFVEAt4vCyFaMV/QF3EkEdSUZPUSg6ViFs
 cgB67HJhXnCcvtSZKV21al80bDTn5pZFdlWa4cesunmEXbgW/+1tf7yRP4oPGIoh
 xBSTAgGYx9cTo8amalyedWUL39KJb56a22fb2ZybgfgQjadl7tWDx8o6be+g/MR/
 sSDhMFw/axdsJCUxo9eUKxAU0wYdIvAZh8/Mq8Eff+z3eDUo33iALN3EwR6QL3JV
 N8oNIVuAnmgHec3uN6kau6Q0ra5aC/BALj+0vJEK274TX8cXOILEaPpS0QKYLBI8
 Ek7dWgSwjTQOn16UH1dLjqhZ6bbNABoXKh86SaeLJEiQaOMw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43374svc9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 11:04:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4APB4Itx027433
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 11:04:18 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 25 Nov 2024 03:04:14 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <mkorpershoek@baylibre.com>, <trini@konsulko.com>,
 <jerome.forissier@linaro.org>, <avromanov@salutedevices.com>,
 <quic_varada@quicinc.com>, <sjg@chromium.org>, <ion@agorria.com>,
 <clamor95@gmail.com>, <quentin.schulz@cherry.de>,
 <u-boot@lists.denx.de>, <caleb.connolly@linaro.org>
Subject: [PATCH] drivers: fastboot: Enable flashing support for UFS
Date: Mon, 25 Nov 2024 16:33:54 +0530
Message-ID: <20241125110354.602124-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 6qqZdtbdJh2d6oqYQUQuodhWHixJvt8J
X-Proofpoint-ORIG-GUID: 6qqZdtbdJh2d6oqYQUQuodhWHixJvt8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250094
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

MMC and UFS seem to execute very similar steps to identify the
partition and write to it. Hence try to enable fastboot flashing
support in UFS leveraging the MMC functions.

Tested on rb3gen2 platform.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/fastboot/Kconfig      | 19 +++++++++++++++---
 drivers/fastboot/Makefile     |  1 +
 drivers/fastboot/fb_command.c |  6 ++++--
 drivers/fastboot/fb_mmc.c     | 36 ++++++++++++++++++++++++-----------
 4 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 1eb460f5a0..5c41fc4684 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -92,7 +92,7 @@ config FASTBOOT_USB_DEV
 config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
 	default y if ARCH_SUNXI || ARCH_ROCKCHIP
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
+	depends on MMC || UFS || (MTD_RAW_NAND && CMD_MTDPARTS)
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -120,6 +120,10 @@ config FASTBOOT_FLASH_NAND
 	bool "FASTBOOT on NAND"
 	depends on MTD_RAW_NAND && CMD_MTDPARTS
 
+config FASTBOOT_FLASH_UFS
+	bool "FASTBOOT on UFS"
+	depends on UFS && EFI_PARTITION
+
 endchoice
 
 config FASTBOOT_FLASH_MMC_DEV
@@ -133,6 +137,15 @@ config FASTBOOT_FLASH_MMC_DEV
 	  regarding the non-volatile storage device. Define this to
 	  the eMMC device that fastboot should use to store the image.
 
+config FASTBOOT_FLASH_UFS_DEV
+	int "Define FASTBOOT UFS FLASH default device"
+	depends on FASTBOOT_FLASH_UFS
+	default 0 if CONFIG_ARCH_SNAPDRAGON
+	help
+	  The fastboot "flash" command requires additional information
+	  regarding the non-volatile storage device. Define this to
+	  the UFS device that fastboot should use to store the image.
+
 config FASTBOOT_FLASH_NAND_TRIMFFS
 	bool "Skip empty pages when flashing NAND"
 	depends on FASTBOOT_FLASH_NAND
@@ -196,7 +209,7 @@ config FASTBOOT_MMC_USER_NAME
 
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
-	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
+	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_UFS) && EFI_PARTITION
 	default "gpt"
 	help
 	  The fastboot "flash" command supports writing the downloaded
@@ -209,7 +222,7 @@ config FASTBOOT_GPT_NAME
 
 config FASTBOOT_MBR_NAME
 	string "Target name for updating MBR"
-	depends on FASTBOOT_FLASH_MMC && DOS_PARTITION
+	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_UFS) && DOS_PARTITION
 	default "mbr"
 	help
 	  The fastboot "flash" command allows to write the downloaded image
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index 048af5aa82..772276cb6c 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -4,4 +4,5 @@ obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_mmc.o
+obj-$(CONFIG_FASTBOOT_FLASH_UFS) += fb_mmc.o
 obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index e4484d65ac..a6fa8299b8 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -336,7 +336,8 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC) ||
+	    IS_ENABLED(CONFIG_FASTBOOT_FLASH_UFS))
 		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
 
@@ -356,7 +357,8 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  */
 static void __maybe_unused erase(char *cmd_parameter, char *response)
 {
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC) ||
+	    IS_ENABLED(CONFIG_FASTBOOT_FLASH_UFS))
 		fastboot_mmc_erase(cmd_parameter, response);
 
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index f11eb66761..bf242e4b2a 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -20,6 +20,16 @@
 
 #define BOOT_PARTITION_NAME "boot"
 
+#if defined(CONFIG_FASTBOOT_FLASH_MMC)
+#define fb_flash_str	"mmc"
+#define fb_flash_dev	CONFIG_FASTBOOT_FLASH_MMC_DEV
+#elif defined(CONFIG_FASTBOOT_FLASH_UFS)
+#define fb_flash_str	"scsi"
+#define fb_flash_dev	CONFIG_FASTBOOT_FLASH_UFS_DEV
+#else
+#error "Incorrect flash type"
+#endif
+
 struct fb_mmc_sparse {
 	struct blk_desc	*dev_desc;
 };
@@ -78,7 +88,7 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
 	int ret;
 
 	/* First try partition names on the default device */
-	*dev_desc = blk_get_dev("mmc", CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	*dev_desc = blk_get_dev(fb_flash_str, fb_flash_dev);
 	if (*dev_desc) {
 		ret = part_get_info_by_name(*dev_desc, name, info);
 		if (ret >= 0)
@@ -91,8 +101,8 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
 	}
 
 	/* Then try dev.hwpart:part */
-	ret = part_get_info_by_dev_and_name_or_num("mmc", name, dev_desc,
-						   info, true);
+	ret = part_get_info_by_dev_and_name_or_num(fb_flash_str, name,
+						   dev_desc, info, true);
 	return ret;
 }
 
@@ -202,17 +212,20 @@ static int fb_mmc_erase_mmc_hwpart(struct blk_desc *dev_desc)
 {
 	lbaint_t blks;
 
-	debug("Start Erasing mmc hwpart[%u]...\n", dev_desc->hwpart);
+	debug("Start Erasing %s hwpart[%u]...\n",
+	      fb_flash_str, dev_desc->hwpart);
 
 	blks = fb_mmc_blk_write(dev_desc, 0, dev_desc->lba, NULL);
 
 	if (blks != dev_desc->lba) {
-		pr_err("Failed to erase mmc hwpart[%u]\n", dev_desc->hwpart);
+		pr_err("Failed to erase %s hwpart[%u]\n",
+		       fb_flash_str, dev_desc->hwpart);
 		return 1;
 	}
 
-	printf("........ erased %lu bytes from mmc hwpart[%u]\n",
-	       dev_desc->lba * dev_desc->blksz, dev_desc->hwpart);
+	printf("........ erased %lu bytes from %s hwpart[%u]\n",
+	       dev_desc->lba * dev_desc->blksz, fb_flash_str,
+	       dev_desc->hwpart);
 
 	return 0;
 }
@@ -487,11 +500,10 @@ int fastboot_mmc_get_part_info(const char *part_name,
 
 static struct blk_desc *fastboot_mmc_get_dev(char *response)
 {
-	struct blk_desc *ret = blk_get_dev("mmc",
-					   CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	struct blk_desc *ret = blk_get_dev(fb_flash_str, fb_flash_dev);
 
 	if (!ret || ret->type == DEV_TYPE_UNKNOWN) {
-		pr_err("invalid mmc device\n");
+		pr_err("invalid %s device\n", fb_flash_str);
 		fastboot_fail("invalid mmc device", response);
 		return NULL;
 	}
@@ -644,10 +656,11 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
  */
 void fastboot_mmc_erase(const char *cmd, char *response)
 {
+#ifdef CONFIG_FASTBOOT_FLASH_MMC
 	struct blk_desc *dev_desc;
 	struct disk_partition info;
 	lbaint_t blks, blks_start, blks_size, grp_size;
-	struct mmc *mmc = find_mmc_device(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	struct mmc *mmc = find_mmc_device(fb_flash_dev);
 
 #ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
 	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
@@ -706,5 +719,6 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 
 	printf("........ erased " LBAFU " bytes from '%s'\n",
 	       blks_size * info.blksz, cmd);
+#endif
 	fastboot_okay(NULL, response);
 }
-- 
2.34.1

