Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D165C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2ED38803E;
	Tue, 19 Mar 2024 13:14:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c+RfnrSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E4A187F30; Tue, 19 Mar 2024 13:14:50 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C01288018
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-413f4cb646dso35822445e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850485; x=1711455285; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xuAod5oKulT4ri3qSNk0l+V6KszpmJJYg/GTS2WSqrc=;
 b=c+RfnrSK9q6IsCKLXMskyEmD6cslV8xEnvjrqPPY2ufgQPtZJMsHvk849K2865mfyI
 0hA8EbqC+gNGHQFhH/bznT3N0yBO/94HC46baKx5LhRT8isRJM3E8zxukw/XH13ULeGV
 OEVm87sbbrm6BwdlrI3GGUCEIL/qTyUMVGK0CHcdjzhKy1mwRHAiSDW2pora0DoawFA0
 cAqzHLtTYYuRVPSaqxWATdaJfRoqaRNuKKDpzyj8KSaF8shPg+AinF8FgdwDK5bU/ygz
 597ur2IVrL0HBkm016XtgPklEm5Tzl2J2hqKkcE7JaROip1KtbQ+dTqC4xVUQYOPzl+3
 gTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850485; x=1711455285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xuAod5oKulT4ri3qSNk0l+V6KszpmJJYg/GTS2WSqrc=;
 b=JpBnokPNx+d7W5MVREmgHzDhtIcojmRD4Jkx0cviIYp4ymY3Eavon9NCbOJkuSoKts
 Bd/N2AgZOhGhzmrsfiwYVKC+QFv1uYfJMa42iaq5RH5+iTAPePNC8n+n3bzQaZukpu/V
 p86BpjsiIa2qf8t7A2vvmfT56qhi6P1ffcYkq7fEACEevMS7rq2VBG8xWvjGlW7h4Fwb
 1yoaiSFyNRxNk7uBrtTTImAqLs9cpZ91ncsh2KAuhQf3vTDuJmG/93Og5FKh4MU+iAmZ
 8/T+M5XYGgvNmidSqXwrx3LaatVxC6nFA7MffetnEQd8jWwHqr3sQWGsdGuean33t4sY
 exOg==
X-Gm-Message-State: AOJu0Yz9EDtolZEbp5CmZGLu/18glKJHLohJ0Z81tz0mZW2V3Dxj2Nhf
 XYrv1WB3Qg6IJr0+bKZzWaBaXuzwucLdfA0P1UGJ05PLIi5w4tGr6nKmPk8Ycd0=
X-Google-Smtp-Source: AGHT+IHMR4BhDAhfDu/QX3tiVnsSbmE2R+wK3dwPZQ3S4HsjvWusbdfL3lVKUCLSPGsj7cVNpK04cw==
X-Received: by 2002:a05:6000:225:b0:341:9055:49b1 with SMTP id
 l5-20020a056000022500b00341905549b1mr75296wrz.46.1710850484930; 
 Tue, 19 Mar 2024 05:14:44 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d4688000000b0033e3c4e600asm12345792wrq.7.2024.03.19.05.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:14:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:14:27 +0000
Subject: [PATCH v3 4/5] usb: gadget: UMS: support multiple sector sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-usb-v3-4-09ba1f86d259@linaro.org>
References: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
In-Reply-To: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13012;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ohYgFS9Eq6pC+NVNcS+t4STsablSVa63T0Q9OSlPpvo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfjes3nkv5OimndNs141CVXXv3xPOdmLBMwES75uvq6
 ATxZddCO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEfvAw/NPf8ZqhpdP4eH3q
 wcbzLHkv361hilM6pp5Q1FLU9utqaw7DP7u5BjUHw3NbjNtz2Ay+bBA7u0T9kNMjcRED3XlrVaY
 oSgMA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

UFS storage often uses a 4096-byte sector size, add support for dynamic
sector sizes based loosely on the Linux implementation.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 cmd/usb_mass_storage.c              |   4 --
 drivers/usb/gadget/f_mass_storage.c | 101 ++++++++++++++++++++----------------
 drivers/usb/gadget/storage_common.c |  12 +++--
 include/usb_mass_storage.h          |   1 -
 4 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/cmd/usb_mass_storage.c b/cmd/usb_mass_storage.c
index a8ddeb494628..751701fe73af 100644
--- a/cmd/usb_mass_storage.c
+++ b/cmd/usb_mass_storage.c
@@ -87,12 +87,8 @@ static int ums_init(const char *devtype, const char *devnums_part_str)
 		 */
 		if (!strchr(devnum_part_str, ':'))
 			partnum = 0;
 
-		/* f_mass_storage.c assumes SECTOR_SIZE sectors */
-		if (block_dev->blksz != SECTOR_SIZE)
-			goto cleanup;
-
 		ums_new = realloc(ums, (ums_count + 1) * sizeof(*ums));
 		if (!ums_new)
 			goto cleanup;
 		ums = ums_new;
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index c725aed3f626..d880928044f4 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -723,14 +723,15 @@ static int do_read(struct fsg_common *common)
 	if (lba >= curlun->num_sectors) {
 		curlun->sense_data = SS_LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE;
 		return -EINVAL;
 	}
-	file_offset = ((loff_t) lba) << 9;
+	file_offset = ((loff_t)lba) << curlun->blkbits;
 
 	/* Carry out the file reads */
 	amount_left = common->data_size_from_cmnd;
-	if (unlikely(amount_left == 0))
+	if (unlikely(amount_left == 0)) {
 		return -EIO;		/* No default reply */
+	}
 
 	for (;;) {
 
 		/* Figure out how much we need to read:
@@ -767,15 +768,15 @@ static int do_read(struct fsg_common *common)
 		}
 
 		/* Perform the read */
 		rc = ums[common->lun].read_sector(&ums[common->lun],
-				      file_offset / SECTOR_SIZE,
-				      amount / SECTOR_SIZE,
+				      file_offset / curlun->blksize,
+				      amount / curlun->blksize,
 				      (char __user *)bh->buf);
 		if (!rc)
 			return -EIO;
 
-		nread = rc * SECTOR_SIZE;
+		nread = rc * curlun->blksize;
 
 		VLDBG(curlun, "file read %u @ %llu -> %d\n", amount,
 				(unsigned long long) file_offset,
 				(int) nread);
@@ -786,9 +787,9 @@ static int do_read(struct fsg_common *common)
 			nread = 0;
 		} else if (nread < amount) {
 			LDBG(curlun, "partial file read: %d/%u\n",
 					(int) nread, amount);
-			nread -= (nread & 511);	/* Round down to a block */
+			nread -= (nread & (curlun->blksize - 1));	/* Round down to a block */
 		}
 		file_offset  += nread;
 		amount_left  -= nread;
 		common->residue -= nread;
@@ -860,9 +861,9 @@ static int do_write(struct fsg_common *common)
 	}
 
 	/* Carry out the file writes */
 	get_some_more = 1;
-	file_offset = usb_offset = ((loff_t) lba) << 9;
+	file_offset = usb_offset = ((loff_t)lba) << curlun->blkbits;
 	amount_left_to_req = common->data_size_from_cmnd;
 	amount_left_to_write = common->data_size_from_cmnd;
 
 	while (amount_left_to_write > 0) {
@@ -892,9 +893,9 @@ static int do_write(struct fsg_common *common)
 					SS_LOGICAL_BLOCK_ADDRESS_OUT_OF_RANGE;
 				curlun->info_valid = 1;
 				continue;
 			}
-			amount -= (amount & 511);
+			amount -= (amount & (curlun->blksize - 1));
 			if (amount == 0) {
 
 				/* Why were we were asked to transfer a
 				 * partial block? */
@@ -941,14 +942,14 @@ static int do_write(struct fsg_common *common)
 			amount = bh->outreq->actual;
 
 			/* Perform the write */
 			rc = ums[common->lun].write_sector(&ums[common->lun],
-					       file_offset / SECTOR_SIZE,
-					       amount / SECTOR_SIZE,
+					       file_offset / curlun->blksize,
+					       amount / curlun->blksize,
 					       (char __user *)bh->buf);
 			if (!rc)
 				return -EIO;
-			nwritten = rc * SECTOR_SIZE;
+			nwritten = rc * curlun->blksize;
 
 			VLDBG(curlun, "file write %u @ %llu -> %d\n", amount,
 					(unsigned long long) file_offset,
 					(int) nwritten);
@@ -959,9 +960,9 @@ static int do_write(struct fsg_common *common)
 				nwritten = 0;
 			} else if (nwritten < amount) {
 				LDBG(curlun, "partial file write: %d/%u\n",
 						(int) nwritten, amount);
-				nwritten -= (nwritten & 511);
+				nwritten -= (nwritten & (curlun->blksize - 1));
 				/* Round down to a block */
 			}
 			file_offset += nwritten;
 			amount_left_to_write -= nwritten;
@@ -1033,10 +1034,10 @@ static int do_verify(struct fsg_common *common)
 	if (unlikely(verification_length == 0))
 		return -EIO;		/* No default reply */
 
 	/* Prepare to carry out the file verify */
-	amount_left = verification_length << 9;
-	file_offset = ((loff_t) lba) << 9;
+	amount_left = verification_length << curlun->blkbits;
+	file_offset = ((loff_t) lba) << curlun->blkbits;
 
 	/* Write out all the dirty buffers before invalidating them */
 
 	/* Just try to read the requested blocks */
@@ -1057,14 +1058,14 @@ static int do_verify(struct fsg_common *common)
 		}
 
 		/* Perform the read */
 		rc = ums[common->lun].read_sector(&ums[common->lun],
-				      file_offset / SECTOR_SIZE,
-				      amount / SECTOR_SIZE,
+				      file_offset / curlun->blksize,
+				      amount / curlun->blksize,
 				      (char __user *)bh->buf);
 		if (!rc)
 			return -EIO;
-		nread = rc * SECTOR_SIZE;
+		nread = rc * curlun->blksize;
 
 		VLDBG(curlun, "file read %u @ %llu -> %d\n", amount,
 				(unsigned long long) file_offset,
 				(int) nread);
@@ -1074,9 +1075,9 @@ static int do_verify(struct fsg_common *common)
 			nread = 0;
 		} else if (nread < amount) {
 			LDBG(curlun, "partial file verify: %d/%u\n",
 					(int) nread, amount);
-			nread -= (nread & 511);	/* Round down to a sector */
+			nread -= (nread & (curlun->blksize - 1));	/* Round down to a sector */
 		}
 		if (nread == 0) {
 			curlun->sense_data = SS_UNRECOVERED_READ_ERROR;
 			curlun->info_valid = 1;
@@ -1182,9 +1183,9 @@ static int do_read_capacity(struct fsg_common *common, struct fsg_buffhd *bh)
 	}
 
 	put_unaligned_be32(curlun->num_sectors - 1, &buf[0]);
 						/* Max logical block */
-	put_unaligned_be32(512, &buf[4]);	/* Block length */
+	put_unaligned_be32(curlun->blksize, &buf[4]);	/* Block length */
 	return 8;
 }
 
 static int do_read_header(struct fsg_common *common, struct fsg_buffhd *bh)
@@ -1369,9 +1370,9 @@ static int do_read_format_capacities(struct fsg_common *common,
 	buf += 4;
 
 	put_unaligned_be32(curlun->num_sectors, &buf[0]);
 						/* Number of blocks */
-	put_unaligned_be32(512, &buf[4]);	/* Block length */
+	put_unaligned_be32(curlun->blksize, &buf[4]);	/* Block length */
 	buf[4] = 0x02;				/* Current capacity */
 	return 12;
 }
 
@@ -1780,8 +1781,18 @@ static int check_command(struct fsg_common *common, int cmnd_size,
 
 	return 0;
 }
 
+/* wrapper of check_command for data size in blocks handling */
+static int check_command_size_in_blocks(struct fsg_common *common,
+		int cmnd_size, enum data_direction data_dir,
+		unsigned int mask, int needs_medium, const char *name)
+{
+	common->data_size_from_cmnd <<= common->luns[common->lun].blkbits;
+	return check_command(common, cmnd_size, data_dir,
+			mask, needs_medium, name);
+}
+
 
 static int do_scsi_command(struct fsg_common *common)
 {
 	struct fsg_buffhd	*bh;
@@ -1864,32 +1875,32 @@ static int do_scsi_command(struct fsg_common *common)
 		break;
 
 	case SC_READ_6:
 		i = common->cmnd[4];
-		common->data_size_from_cmnd = (i == 0 ? 256 : i) << 9;
-		reply = check_command(common, 6, DATA_DIR_TO_HOST,
-				      (7<<1) | (1<<4), 1,
-				      "READ(6)");
+		common->data_size_from_cmnd = (i == 0 ? 256 : i);
+		reply = check_command_size_in_blocks(common, 6, DATA_DIR_TO_HOST,
+						     (7<<1) | (1<<4), 1,
+						     "READ(6)");
 		if (reply == 0)
 			reply = do_read(common);
 		break;
 
 	case SC_READ_10:
 		common->data_size_from_cmnd =
-				get_unaligned_be16(&common->cmnd[7]) << 9;
-		reply = check_command(common, 10, DATA_DIR_TO_HOST,
-				      (1<<1) | (0xf<<2) | (3<<7), 1,
-				      "READ(10)");
+				get_unaligned_be16(&common->cmnd[7]);
+		reply = check_command_size_in_blocks(common, 10, DATA_DIR_TO_HOST,
+						     (1<<1) | (0xf<<2) | (3<<7), 1,
+						     "READ(10)");
 		if (reply == 0)
 			reply = do_read(common);
 		break;
 
 	case SC_READ_12:
 		common->data_size_from_cmnd =
-				get_unaligned_be32(&common->cmnd[6]) << 9;
-		reply = check_command(common, 12, DATA_DIR_TO_HOST,
-				      (1<<1) | (0xf<<2) | (0xf<<6), 1,
-				      "READ(12)");
+				get_unaligned_be32(&common->cmnd[6]);
+		reply = check_command_size_in_blocks(common, 12, DATA_DIR_TO_HOST,
+						     (1<<1) | (0xf<<2) | (0xf<<6), 1,
+						     "READ(12)");
 		if (reply == 0)
 			reply = do_read(common);
 		break;
 
@@ -1982,32 +1993,32 @@ static int do_scsi_command(struct fsg_common *common)
 		break;
 
 	case SC_WRITE_6:
 		i = common->cmnd[4];
-		common->data_size_from_cmnd = (i == 0 ? 256 : i) << 9;
-		reply = check_command(common, 6, DATA_DIR_FROM_HOST,
-				      (7<<1) | (1<<4), 1,
-				      "WRITE(6)");
+		common->data_size_from_cmnd = (i == 0 ? 256 : i);
+		reply = check_command_size_in_blocks(common, 6, DATA_DIR_FROM_HOST,
+						     (7<<1) | (1<<4), 1,
+						     "WRITE(6)");
 		if (reply == 0)
 			reply = do_write(common);
 		break;
 
 	case SC_WRITE_10:
 		common->data_size_from_cmnd =
-				get_unaligned_be16(&common->cmnd[7]) << 9;
-		reply = check_command(common, 10, DATA_DIR_FROM_HOST,
-				      (1<<1) | (0xf<<2) | (3<<7), 1,
-				      "WRITE(10)");
+				get_unaligned_be16(&common->cmnd[7]);
+		reply = check_command_size_in_blocks(common, 10, DATA_DIR_FROM_HOST,
+						     (1<<1) | (0xf<<2) | (3<<7), 1,
+						     "WRITE(10)");
 		if (reply == 0)
 			reply = do_write(common);
 		break;
 
 	case SC_WRITE_12:
 		common->data_size_from_cmnd =
-				get_unaligned_be32(&common->cmnd[6]) << 9;
-		reply = check_command(common, 12, DATA_DIR_FROM_HOST,
-				      (1<<1) | (0xf<<2) | (0xf<<6), 1,
-				      "WRITE(12)");
+				get_unaligned_be32(&common->cmnd[6]);
+		reply = check_command_size_in_blocks(common, 12, DATA_DIR_FROM_HOST,
+						     (1<<1) | (0xf<<2) | (0xf<<6), 1,
+						     "WRITE(12)");
 		if (reply == 0)
 			reply = do_write(common);
 		break;
 
@@ -2496,9 +2507,9 @@ static struct fsg_common *fsg_common_init(struct fsg_common *common,
 
 	for (i = 0; i < nluns; i++) {
 		common->luns[i].removable = 1;
 
-		rc = fsg_lun_open(&common->luns[i], ums[i].num_sectors, "");
+		rc = fsg_lun_open(&common->luns[i], ums[i].num_sectors, ums->block_dev.blksz, "");
 		if (rc)
 			goto error_luns;
 	}
 	common->lun = 0;
diff --git a/drivers/usb/gadget/storage_common.c b/drivers/usb/gadget/storage_common.c
index 5674e8fe4940..97dc6b6f729c 100644
--- a/drivers/usb/gadget/storage_common.c
+++ b/drivers/usb/gadget/storage_common.c
@@ -268,8 +268,9 @@ struct interrupt_data {
 struct device_attribute { int i; };
 #define ETOOSMALL	525
 
 #include <log.h>
+#include <linux/log2.h>
 #include <usb_mass_storage.h>
 #include <dm/device_compat.h>
 
 /*-------------------------------------------------------------------------*/
@@ -289,8 +290,10 @@ struct fsg_lun {
 
 	u32		sense_data;
 	u32		sense_data_info;
 	u32		unit_attention_data;
+	unsigned int	blkbits;
+	unsigned int	blksize; /* logical block size of bound block device */
 
 	struct device	dev;
 };
 
@@ -565,19 +568,22 @@ static struct usb_gadget_strings	fsg_stringtab = {
  * the caller must own fsg->filesem for writing.
  */
 
 static int fsg_lun_open(struct fsg_lun *curlun, unsigned int num_sectors,
-			const char *filename)
+			unsigned int sector_size, const char *filename)
 {
 	int				ro;
 
 	/* R/W if we can, R/O if we must */
 	ro = curlun->initially_ro;
 
 	curlun->ro = ro;
-	curlun->file_length = num_sectors << 9;
+	curlun->file_length = num_sectors * sector_size;
 	curlun->num_sectors = num_sectors;
-	debug("open backing file: %s\n", filename);
+	curlun->blksize = sector_size;
+	curlun->blkbits = order_base_2(sector_size >> 9) + 9;
+	debug("blksize: %u\n", sector_size);
+	debug("open backing file: '%s'\n", filename);
 
 	return 0;
 }
 
diff --git a/include/usb_mass_storage.h b/include/usb_mass_storage.h
index 83ab93b530d7..6d83d93cad7f 100644
--- a/include/usb_mass_storage.h
+++ b/include/usb_mass_storage.h
@@ -6,9 +6,8 @@
 
 #ifndef __USB_MASS_STORAGE_H__
 #define __USB_MASS_STORAGE_H__
 
-#define SECTOR_SIZE		0x200
 #include <part.h>
 #include <linux/usb/composite.h>
 
 /* Wait at maximum 60 seconds for cable connection */

-- 
2.44.0

