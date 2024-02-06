Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2485C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 22:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BAB87CBC;
	Tue,  6 Feb 2024 23:32:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFFA187CB8; Tue,  6 Feb 2024 23:32:06 +0100 (CET)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFE3887CA6
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 23:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-50e4e36c09cso1969874e87.1
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 14:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258724; x=1707863524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qoSGL2pMz2Mc9B6FrkXwxNRp9HPJjTOxLJGCotd54yM=;
 b=QNrrNCjpmThkSBvun7NpuJCosiShYXmTJD2GZGEcmUMC2TvQd3vV+qBBVfGuRDgx66
 Y84B5jq2rfGsySK959Amot4n8GuPGKDBU3orVIsQudm06K1K9Uu7cjUKmhAI7coHj+rh
 7xb2BV12xQ+3Lpt+o52r/LK/ZVq4vkC1cgw1bZg71oDKztT7a37/SgHAPs98xrt6+Hbt
 7pss+eXAlzH0KdLsyEsdw+bY5tR0tIOzap0nmk+vL4HPiYskgzeUsIXTFTF8v0viwfTQ
 ltGnRp/by/x4CfloD3lEpiKrWHvIBRrZCzOJHI6Ljp0NXCJE8qD9l92XyvQqKUW2EEks
 tGQw==
X-Gm-Message-State: AOJu0Yy6uMkZPcah9adxPRQC2tQDw3TSqSPggEfmAeatXZSa6IwZO6xg
 vTA1qbntfnRTdSAAfn361psd8RMF/xVY6Z87F2fVzvign9/GBTjTT+x4sESdK+5mGg==
X-Google-Smtp-Source: AGHT+IFJirdchpjCZdQKaDWCFRt5pnv5IzUnNZtVtFjSV1SUaCyoTUFeLwETPXcCJekA/ziftS6/NQ==
X-Received: by 2002:a19:5f12:0:b0:511:4881:1b78 with SMTP id
 t18-20020a195f12000000b0051148811b78mr2403384lfb.4.1707258723388; 
 Tue, 06 Feb 2024 14:32:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVB8KScDnjlIXAwlEBjt7VskdSEVgPQSvIoC/3kLs8qkZV3y5Xh3/DYIKpSW283arAanbbqmFN93iw54Y5Dn0ag6CV/WnOqwB5j7cbGS3vRsviBjySB5exOCb+m7fDGzagjJYXvJXQ14Wh7ga+LlSHP+Lnpd6eZSW8bCv5bT7REa0ooOnQpl+2GDfnuF65wsqY=
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 m2-20020a056512014200b0051145ebd75asm355331lfo.39.2024.02.06.14.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 14:32:02 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 3/7] common: avb_verify: rework error/debug prints
Date: Tue,  6 Feb 2024 23:31:49 +0100
Message-Id: <20240206223153.3060433-4-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Make error prints more verbose with additional context.
Also s/print/debug/g for prints, which might be relevant only
for debugging purposes.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 common/avb_verify.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index 938a5383b5d..ed58239cf8a 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -279,9 +279,9 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 	 * Reading fails on unaligned buffers, so we have to
 	 * use aligned temporary buffer and then copy to destination
 	 */
-
 	if (unaligned) {
-		printf("Handling unaligned read buffer..\n");
+		debug("%s: handling unaligned read buffer, addr = 0x%p\n",
+		      __func__, buffer);
 		tmp_buf = get_sector_buf();
 		buf_size = get_sector_buf_size();
 		if (sectors > buf_size / part->info.blksz)
@@ -320,7 +320,8 @@ static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
 	if (unaligned) {
 		tmp_buf = get_sector_buf();
 		buf_size = get_sector_buf_size();
-		printf("Handling unaligned wrire buffer..\n");
+		debug("%s: handling unaligned read buffer, addr = 0x%p\n",
+		      __func__, buffer);
 		if (sectors > buf_size / part->info.blksz)
 			sectors = buf_size / part->info.blksz;
 
@@ -348,30 +349,35 @@ static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
 	dev_num = get_boot_device(ops);
 	part->mmc = find_mmc_device(dev_num);
 	if (!part->mmc) {
-		printf("No MMC device at slot %x\n", dev_num);
+		printf("%s: no MMC device at slot %x\n", __func__, dev_num);
 		goto err;
 	}
 
-	if (mmc_init(part->mmc)) {
-		printf("MMC initialization failed\n");
+	ret = mmc_init(part->mmc);
+	if (ret) {
+		printf("%s: MMC initialization failed, err = %d\n",
+		       __func__, ret);
 		goto err;
 	}
 
 	if (IS_MMC(part->mmc)) {
 		ret = mmc_switch_part(part->mmc, part_num);
-		if (ret)
+		if (ret) {
+			printf("%s: MMC part switch failed, err = %d\n",
+			       __func__, ret);
 			goto err;
+		}
 	}
 
 	mmc_blk = mmc_get_blk_desc(part->mmc);
 	if (!mmc_blk) {
-		printf("Error - failed to obtain block descriptor\n");
+		printf("%s: failed to obtain block descriptor\n", __func__);
 		goto err;
 	}
 
 	ret = part_get_info_by_name(mmc_blk, partition, &part->info);
 	if (ret < 0) {
-		printf("Can't find partition '%s'\n", partition);
+		printf("%s: can't find partition '%s'\n", __func__, partition);
 		goto err;
 	}
 
@@ -684,7 +690,7 @@ static AvbIOResult read_rollback_index(AvbOps *ops,
 {
 #ifndef CONFIG_OPTEE_TA_AVB
 	/* For now we always return 0 as the stored rollback index. */
-	printf("%s not supported yet\n", __func__);
+	debug("%s: rollback protection is not implemented\n", __func__);
 
 	if (out_rollback_index)
 		*out_rollback_index = 0;
@@ -730,7 +736,7 @@ static AvbIOResult write_rollback_index(AvbOps *ops,
 {
 #ifndef CONFIG_OPTEE_TA_AVB
 	/* For now this is a no-op. */
-	printf("%s not supported yet\n", __func__);
+	debug("%s: rollback protection is not implemented\n", __func__);
 
 	return AVB_IO_RESULT_OK;
 #else
@@ -766,8 +772,7 @@ static AvbIOResult read_is_device_unlocked(AvbOps *ops, bool *out_is_unlocked)
 {
 #ifndef CONFIG_OPTEE_TA_AVB
 	/* For now we always return that the device is unlocked. */
-
-	printf("%s not supported yet\n", __func__);
+	debug("%s: device locking is not implemented\n", __func__);
 
 	*out_is_unlocked = true;
 
-- 
2.34.1

