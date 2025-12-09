Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA1ED3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 02:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E675B83B91;
	Tue,  9 Dec 2025 03:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ktzo9dd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3053483BBE; Tue,  9 Dec 2025 03:57:32 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0A283B81
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 03:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-786a822e73aso49962317b3.3
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 18:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765249048; x=1765853848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ymxhjtm18qn6YcNLrEejZMtSSfIc2wu2L8XqVOaOTks=;
 b=Ktzo9dd+1Z9ypAewIZ2h9RBQuyGKrj8EhIZHVim6bpp3KzHIrKaOleE1l1ssZCNX4B
 JNDBLc7XkrnKMRijDvysFTWCbfKjkwfbrESG64UDD6hffiX3bPL/qq8LR1fhuCRk8ZR5
 wlH8kD0ymJ9bXW9eHb8BOU5iCbikfH+7onMBq8WkYvQDY3Su9BJf+3nnD7Bb1HEGhJuG
 lEWvRdqpNIfY+CCiFcbmCaEN/unhzr1RVfDigufjRV7n+SX8CaeC3N4Ag8+WAmkPGgsR
 cROVhDZGds0tkkZSY0l9Oufhzy9Eb4d88En+EFzwT7krV0G0vfGxt0HV9EDJwm9MberB
 8bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765249048; x=1765853848;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ymxhjtm18qn6YcNLrEejZMtSSfIc2wu2L8XqVOaOTks=;
 b=ZZTSgkG1KkTjGYasRelJAiUNTf1W4xxyKdwqtagVjXvRkdU8UWLJl3W8+yh8JRw/Yj
 ZQd+CjnS/N20PdO6McGF3fgnpphB6I7mmAZNZ1EfZPr3C3Ix3iMGEsgbyH7bfgxeX6eX
 9ueDCOCSZMyDTb63JmdAFY9CzlljKjchj5FQsSh0bDDIvIUWWsHLdleaZUdoJZOF6tPK
 YrO9DA10eR3ct5bpwbqLMTqzgM5IIpK/M/qTqH492PsgZNyaeus3d53/kIuYVYgQ7Jns
 Usr3UlNhEciD1+GP3A4Oa9KJxwMXry0JOXWzY5t6R7LC2iaIocmKSA/HckypQRlfhU9g
 JKFw==
X-Gm-Message-State: AOJu0YxFBEfs0AHNXIazQ++CYsmjcRll+FwKwAPdTEjzFJ1uqydUIAbu
 eHTOgRw3qvnCnk8Pm9DzOSnxiU+rY8BY61QDtL4P/uNMy7o4bb79M4YL
X-Gm-Gg: ASbGncspWiwbgPwjcPa/9hlkmIdADqrjEtkPyKmyKkKmVvudOlFQaN+bvt+4KxaTfKG
 9mVa0PvlWEyBP4sG0yo43US4VowdGQVZxLcOLhNWMk3Woi3GymT+ZjmQb0982z0JYBnwZTWglOF
 fekkp81LfdeDmCzxvoAqkHxZ7HPCvZJxcv5U92PHELMn+MzQSMqAXFKX4J331eylyJbZ6/ylNkN
 AhtZaFeF5n6Do/ozA/PBxoiKs6BFxeQL3c1v0BXvXKYx3DC9sdnWwORjH2NzbKbLss/mjfrghMm
 KQDsp9uwPwMvGoTF/H4FF+lch5BrICA9mSb44z1nXJJ+TwC6YyMkX58QutuPw0Pq5salHtdMOhf
 eBPLpFADi3GNgU2esx1SvcG9d/KIbuJZYddoztWWyZ2PKUWeDObl7Zp/oOj3tOcwEyL7BUIriVK
 iuv4hG5OlRwFuykLABtQnVJLIg4x6Matl768263R3Lzd8TCqlVQ2qtc6yVyPUk1yzASrPMP/z1O
 A==
X-Google-Smtp-Source: AGHT+IH6tw39PVX8+LPkKIbNEIRNt5P21WNSfl6RLkKo7eP6+JigjCUMvTtEh3nD+jc5MriaovWL8g==
X-Received: by 2002:a05:690c:6aca:b0:784:aec5:7042 with SMTP id
 00721157ae682-78c33c14aa4mr86873117b3.38.1765249048378; 
 Mon, 08 Dec 2025 18:57:28 -0800 (PST)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78c1b77942bsm54418787b3.27.2025.12.08.18.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 18:57:27 -0800 (PST)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH] Revert "drivers: scsi: fix inaccurate block count reporting
 in scsi operations"
Date: Mon,  8 Dec 2025 18:53:52 -0800
Message-ID: <20251209025634.14466-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

This reverts commit b32dda34506b4f486bc803d0c7251f987edd2455.

Currently, scsi is broken and causes data abort. I did a bisect and found
that this commit was the cause. Reverting it and scsi is working again.

=== Error Log with data abort

U-Boot 2026.01-rc4-tld-1-g0e0a198a68be (Dec 08 2025 - 17:42:05 -0800)
Synology DS116

DS116> scsi reset

Reset SCSI
scanning bus for devices...
Target spinup took 0 ms.
SATA link 1 timeout.
AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
flags: 64bit ncq led only pmp fbss pio slum part sxs
  Device 0: (0:0) Vendor: ATA Prod.: FUJITSU MHY2250B Rev: 890B
            Type: Hard Disk
            Capacity: 238475.1 MB = 232.8 GB (488397169 x 512)

DS116> ext2ls scsi 0:1 /boot
data abort
pc : [<3ffa5d3e>]	   lr : [<3ffc1515>]
sp : 3fb65ad8  ip : 0000000c	 fp : 3fb7f220
r10: 00002710  r9 : 3fb6aed0	 r8 : 3fb85e40
r7 : f10a8100  r6 : 000003e8	 r5 : 000003e8  r4 : 3fb65ae0
r3 : e38e39c1  r2 : 00000000	 r1 : 3fb65ae0  r0 : 00931767
Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
Code: 3ffd b510 6803 460c (6bdb) 681b

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---

 drivers/scsi/scsi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index b414d022f3f..715271b1d69 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -228,11 +228,13 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			blocks = max_blks;
 			scsi_setup_read_ext(pccb, start, blocks);
 			start += max_blks;
+			blks -= max_blks;
 		} else {
 			pccb->datalen = block_dev->blksz * blks;
 			blocks = blks;
 			scsi_setup_read_ext(pccb, start, blocks);
 			start += blks;
+			blks = 0;
 		}
 		debug("scsi_read_ext: startblk " LBAF
 		      ", blccnt " LBAF " buffer %lX\n",
@@ -242,7 +244,6 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			blkcnt -= blks;
 			break;
 		}
-		blks -= blocks;
 		buf_addr += pccb->datalen;
 	} while (blks != 0);
 	debug("scsi_read_ext: end startblk " LBAF
@@ -285,11 +286,13 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			blocks = max_blks;
 			scsi_setup_write_ext(pccb, start, blocks);
 			start += max_blks;
+			blks -= max_blks;
 		} else {
 			pccb->datalen = block_dev->blksz * blks;
 			blocks = blks;
 			scsi_setup_write_ext(pccb, start, blocks);
 			start += blks;
+			blks = 0;
 		}
 		debug("%s: startblk " LBAF ", blccnt " LBAF " buffer %lx\n",
 		      __func__, start, blocks, buf_addr);
@@ -298,7 +301,6 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			blkcnt -= blks;
 			break;
 		}
-		blks -= blocks;
 		buf_addr += pccb->datalen;
 	} while (blks != 0);
 
@@ -320,7 +322,7 @@ static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
 	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
 	struct udevice *bdev = dev->parent;
 	struct scsi_plat *uc_plat = dev_get_uclass_plat(bdev);
-	lbaint_t start, blks, max_blks, blocks;
+	lbaint_t start, blks, max_blks;
 	struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
 
 	/* Setup device */
@@ -337,20 +339,19 @@ static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
 	      __func__, block_dev->devnum, start, blks);
 	do {
 		if (blks > max_blks) {
-			blocks = max_blks;
 			scsi_setup_erase_ext(pccb, start, max_blks);
 			start += max_blks;
+			blks -= max_blks;
 		} else {
-			blocks = blks;
 			scsi_setup_erase_ext(pccb, start, blks);
 			start += blks;
+			blks = 0;
 		}
 		if (scsi_exec(bdev, pccb)) {
 			scsi_print_error(pccb);
 			blkcnt -= blks;
 			break;
 		}
-		blks -= blocks;
 	} while (blks != 0);
 	return blkcnt;
 }
-- 
2.47.3

base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
branch: master
