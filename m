Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B78C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79DB583B80;
	Thu,  7 Aug 2025 00:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TYODNJ/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D554983AED; Thu,  7 Aug 2025 00:27:39 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D6183B0B
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-741a5e8fa94so140191a34.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519237; x=1755124037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlDzzDK/ZfUIMGIckFszpoD6uhHq9oGWs4WyNX20UxM=;
 b=TYODNJ/RzWahARQSxGhEUuUH/275wFDvzFcadRJ+m3GWxiLGa0xsrmylwNzjNlOWSz
 C5gsqMCxukFkgCnygOnnB4e6C70OIeadUPyxexJvtc0D122TDHR4EDxQ1MfLfMvAkMwW
 J14fXzHOaoDBowZMAKB0aDS62tjPsF9Zs0dmPLCCjnXETyaFm0r4o4/6hkN0PDG6sa4u
 6awz3/Uc/Jom26iZE3IT/yLki7dIw2fa6vzYHNJ1k2er01noI2tfovWmqjrMTlkL6QBL
 2qysYW9GfB0wYHbwDkjOti2PxmNal/2+48A7e1jI59PsKIjB6Mf1LOVAyakGXLHLVt25
 BUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519237; x=1755124037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlDzzDK/ZfUIMGIckFszpoD6uhHq9oGWs4WyNX20UxM=;
 b=Ky59nggFMD2XtDYjXmw4hIkj4z56qmAjTBlMo3vsrxioLW+xVTy9h4F039bUaDLEt2
 xaa6sZeX05iqcsSBZCAj6jobIHXedpMnSzC1FAGOb81AkavTW/MIortE1FE+PSjShUCk
 7l/Tq1iQbXEn1yN4MrHPQKdwUohAyfmSGgDjbfEIM4Ql9eY4k4cfrjXZfj+rgaXBSBOE
 T+yWrTfDSHBns4FEf+QG3/BNRRR/fr9lUf68AfL1uu4KRkCG0L1rRHaD8wChnvx4FP2d
 Y19mT6EA15LPKHDiZSh5ocInpgKoEYAHhAvNrKM092CNf5eLWMVjO1mLr7ZD6UMOV+QB
 LiFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1gHZ021dt5QA6PUVZEBtvtx382feAUvI6KCAVjq4sUut05fynIAakdJfO0q9lmd5QNa0y2+M=@lists.denx.de
X-Gm-Message-State: AOJu0YxaFlIZdU2i5QsSZpJPA7zRGuJAshHWiQnAZB0fvCk/2k3h28s+
 VbwgVx0XYVI6MhhTutC+DdPZG0KPbIKnpdSmHHcg0e9N6//aycLB361yB5ICXsyCKm4=
X-Gm-Gg: ASbGnctC+CiFdPRgfLwkDDw9qCGaaP+fpHYWwyGRq5QixRqqHTZiUNd8D8ROqmqkIG4
 9SukvcW67UVzve3N9TeM+HHgmFNBKxjRrBGnv3AjkntFyhWjjh++Xp3GehWu231JCQZxd4UMC1q
 ZI4at6xtmMn7L2rVPMP2GK/mMjQYEFaKrku45JofMbeL705M6F5RcJMgR/fyOGz3vLRSwUeeDOC
 V4UgOTXJpknJmQkBVO82uuFSprNL32u/Jza19JR0Qb7eO2jiL0ydG+iluEYGsUYpUCTf+s/u0dR
 dHJXH4BNtp6aHHIdJg2EIbdMv47JIW4hCTS/Xt1Pdn7jaGOJhfweVqt+rLrkGTzOCLy5cgzNAHw
 Ewo3DvghstIEu50BJOT5h8PCdA4/80l/ey76I
X-Google-Smtp-Source: AGHT+IHMZSoMBjS7rERKqtrUCEP6hP7td73udlcOuyZpBwsPCpu1cAojagIVhBpNEkf2VVJVpkKrJQ==
X-Received: by 2002:a05:6830:7188:b0:73e:7f48:e6bc with SMTP id
 46e09a7af769-74308d4b7a0mr3458621a34.2.1754519236856; 
 Wed, 06 Aug 2025 15:27:16 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-742f418579esm1491090a34.28.2025.08.06.15.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:16 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 06/10] board: samsung: e850-96: Extract device info from fw
 loading code
Date: Wed,  6 Aug 2025 17:27:06 -0500
Message-Id: <20250806222710.23773-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Make it possible to provide the information about storage device where
LDFW firmware resides to the firmware loading routine. The firmware
loader code shouldn't have that data hard-coded anyway, and it also
allows for implementing more dynamic behavior later, like choosing the
storage device containing LDFW via some environment variables.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c |  9 ++++++-
 board/samsung/e850-96/fw.c      | 45 ++++++++++++++++++++-------------
 board/samsung/e850-96/fw.h      |  4 ++-
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index 2cf874fcf7a5..b5f6ba23432e 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -24,6 +24,12 @@
 #define EXYNOS850_APM_SHMEM_OFFSET	0x3200
 #define EXYNOS850_IPC_AP_I3C		10
 
+/* LDFW firmware definitions */
+#define LDFW_NWD_ADDR			0x88000000
+#define EMMC_IFNAME			"mmc"
+#define EMMC_DEV_NUM			0
+#define EMMC_ESP_PART			1
+
 struct efi_fw_image fw_images[] = {
 	{
 		.image_type_id = E850_96_FWBL1_IMAGE_GUID,
@@ -141,7 +147,8 @@ int board_late_init(void)
 	 * Do this in board_late_init() to make sure MMC is not probed before
 	 * efi_init_early().
 	 */
-	err = load_ldfw();
+	err = load_ldfw(EMMC_IFNAME, EMMC_DEV_NUM, EMMC_ESP_PART,
+			LDFW_NWD_ADDR);
 	if (err)
 		printf("ERROR: LDFW loading failed (%d)\n", err);
 
diff --git a/board/samsung/e850-96/fw.c b/board/samsung/e850-96/fw.c
index 8f64e759b431..64235c01a254 100644
--- a/board/samsung/e850-96/fw.c
+++ b/board/samsung/e850-96/fw.c
@@ -11,13 +11,9 @@
 #include <linux/arm-smccc.h>
 #include "fw.h"
 
-#define EMMC_IFACE		"mmc"
-#define EMMC_DEV_NUM		0
 #define LDFW_RAW_PART		"ldfw"
-#define LDFW_FAT_PART		"esp"
 #define LDFW_FAT_PATH		"/EFI/firmware/ldfw.bin"
 
-#define LDFW_NWD_ADDR		0x88000000
 #define LDFW_MAGIC		0x10adab1e
 #define SMC_CMD_LOAD_LDFW	-0x500
 #define SDM_HW_RESET_STATUS	0x1230
@@ -39,19 +35,23 @@ struct ldfw_header {
 };
 
 /* Load LDFW binary as a file from FAT partition */
-static int read_fw_from_fat(const char *part_name, const char *path, void *buf)
+static int read_fw_from_fat(const char *ifname, int dev, int part,
+			    const char *path, void *buf)
 {
-	char dev_part_str[8];
+	struct blk_desc *blk_desc;
 	loff_t len_read;
 	int err;
 
-	snprintf(dev_part_str, sizeof(dev_part_str), "%d#%s", EMMC_DEV_NUM,
-		 LDFW_FAT_PART);
+	blk_desc = blk_get_dev(ifname, dev);
+	if (!blk_desc) {
+		debug("%s: Can't get block device\n", __func__);
+		return -ENODEV;
+	}
 
-	err = fs_set_blk_dev(EMMC_IFACE, dev_part_str, FS_TYPE_FAT);
+	err = fs_set_blk_dev_with_part(blk_desc, part);
 	if (err) {
-		debug("%s: Can't set block device\n", __func__);
-		return -ENODEV;
+		debug("%s: Can't set partition\n", __func__);
+		return -ENOENT;
 	}
 
 	err = fs_read(path, (ulong)buf, 0, 0, &len_read);
@@ -64,16 +64,17 @@ static int read_fw_from_fat(const char *part_name, const char *path, void *buf)
 }
 
 /* Load LDFW binary from raw partition on block device into RAM buffer */
-static int read_fw_from_raw(const char *part_name, void *buf)
+static int read_fw_from_raw(const char *ifname, int dev, const char *part_name,
+			    void *buf)
 {
 	struct blk_desc *blk_desc;
 	struct disk_partition part;
 	unsigned long cnt;
 	int part_num;
 
-	blk_desc = blk_get_dev(EMMC_IFACE, EMMC_DEV_NUM);
+	blk_desc = blk_get_dev(ifname, dev);
 	if (!blk_desc) {
-		debug("%s: Can't get eMMC device\n", __func__);
+		debug("%s: Can't get block device\n", __func__);
 		return -ENODEV;
 	}
 
@@ -92,9 +93,17 @@ static int read_fw_from_raw(const char *part_name, void *buf)
 	return 0;
 }
 
-int load_ldfw(void)
+/**
+ * load_ldfw - Load the loadable firmware (LDFW)
+ * @ifname: Interface name of the block device to load the firmware from
+ * @dev: Device number
+ * @part: Partition number
+ * @addr: Temporary memory (Normal World) to use for loading the firmware
+ *
+ * Return: 0 on success or a negative value on error.
+ */
+int load_ldfw(const char *ifname, int dev, int part, phys_addr_t addr)
 {
-	const phys_addr_t addr = (phys_addr_t)LDFW_NWD_ADDR;
 	struct ldfw_header *hdr;
 	struct arm_smccc_res res;
 	void *buf = (void *)addr;
@@ -102,9 +111,9 @@ int load_ldfw(void)
 	int err, i;
 
 	/* First try to read LDFW from EFI partition, then from the raw one */
-	err = read_fw_from_fat(LDFW_FAT_PART, LDFW_FAT_PATH, buf);
+	err = read_fw_from_fat(ifname, dev, part, LDFW_FAT_PATH, buf);
 	if (err) {
-		err = read_fw_from_raw(LDFW_RAW_PART, buf);
+		err = read_fw_from_raw(ifname, dev, LDFW_RAW_PART, buf);
 		if (err)
 			return err;
 	}
diff --git a/board/samsung/e850-96/fw.h b/board/samsung/e850-96/fw.h
index 472664e4ed21..73d9615d4a9c 100644
--- a/board/samsung/e850-96/fw.h
+++ b/board/samsung/e850-96/fw.h
@@ -7,6 +7,8 @@
 #ifndef __E850_96_FW_H
 #define __E850_96_FW_H
 
-int load_ldfw(void);
+#include <asm/types.h>
+
+int load_ldfw(const char *ifname, int dev, int part, phys_addr_t addr);
 
 #endif /* __E850_96_FW_H */
-- 
2.39.5

