Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C25CE92FCE
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 23:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F2A686BFA;
	Fri,  6 Oct 2023 01:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FxuIzusA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E4A86D28; Fri,  6 Oct 2023 01:08:48 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C85D686C0C
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 01:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-351367c8fcdso6225385ab.3
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696547322; x=1697152122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z9xVsPdWH0H95bkDMT585tTHq2Ow72A8On4zXyiplM=;
 b=FxuIzusAJwUdwK9Zf7Ub8xCfb+h4Qqka1ucDaSAZC1As+60jPCFaA5zeaXXZM1mbyI
 ofJukHf7Du+VIlQ2GUuKsz+A4OnM8AzaBck96FtT+eNGsq1XNltk1Ut48tfAvo/XU4II
 yq77IHM5OgWo1DCAs0AzeOfBt5YCYF7ZkT5t/h/u+cW833EKDQnCxfe5tk5xWeoQA1tD
 THwZ0qCvPC8kmTVmkCjIFjXMINwXqoI/dQJDqZaoqvW3N8F3zUYRvHs9uZaH1wUHbSId
 KlWg5dOGVxOftSLY6vBvQ+69IRo+4U3ku6skEbqrM1LW10knfVMQ+1j3ACzZZSDYWVZI
 ALtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696547322; x=1697152122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2z9xVsPdWH0H95bkDMT585tTHq2Ow72A8On4zXyiplM=;
 b=IwS9K7yaOf6M1RsMknxLorJfiooSChpWCM6uaN8ZN0qDaQn5JNMxz28iJmg3El6rSm
 V3Ursb4pz30Esri1w/X2WexF9tqJZSXkzXPCD8Q57VMx551jz7e77URtSYTWbquqi94d
 fZgqgox1wEaUxRg12ry7zwNh11g+FJ9oTx6Ode5WSEtihjzfEhxmu/CSBstErsyQ8/FL
 oLygKIFkCXfRTPgmIQyIq2ujvxqQl153AtOV9xlWewABs7opQ8w2nS19U+GeKqeEjxun
 tqSUOvF6MJT7awaOffi16exzW5cG+dNMyp5SxYPZVR02x2d4wIjwZIpfNeTjjBYM4Uc2
 mxJw==
X-Gm-Message-State: AOJu0YyZQ6pIhd53D58vKT7EcRCLKt5cwIK7GNrzlmcepw8VNry+4Zsu
 jYtwern9npKIZfxb35jjd7pNdZ4//ePcsA==
X-Google-Smtp-Source: AGHT+IHJAHmthY0UxEI2MNapnkFsPLZQWbBXXAhuuA/t66dJMpckTSDGahHoBt5iMER0wpfMkmqnvQ==
X-Received: by 2002:a05:6e02:1d11:b0:352:a306:9ad1 with SMTP id
 i17-20020a056e021d1100b00352a3069ad1mr8080547ila.0.1696547322427; 
 Thu, 05 Oct 2023 16:08:42 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:9b88:f219:40c8:60fc])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a922811000000b003513b7613f3sm709974ilf.3.2023.10.05.16.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 16:08:41 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Schocher <hs@denx.de>,
	Simon Glass <sjg@chromium.org>
Cc: Kyungmin Park <kmpark@infradead.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [RFC PATCH v2 2/4] mtd: ubi: bind block device driver for static
 volumes
Date: Thu,  5 Oct 2023 17:08:29 -0600
Message-ID: <20231005230831.4032070-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005230831.4032070-1-CFSworks@gmail.com>
References: <20231005230831.4032070-1-CFSworks@gmail.com>
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

This makes static UBI volumes readable as block devices, however
no mechanism for selecting these volume devices yet exists.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/mtd/ubi/ubi-uclass.c | 111 +++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/mtd/ubi/ubi-uclass.c b/drivers/mtd/ubi/ubi-uclass.c
index f8971e793e..b2c47bfe0c 100644
--- a/drivers/mtd/ubi/ubi-uclass.c
+++ b/drivers/mtd/ubi/ubi-uclass.c
@@ -8,10 +8,120 @@
 #define LOG_CATEGORY UCLASS_UBI
 
 #include <common.h>
+#include <blk.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <ubi_uboot.h>
 
+static ulong ubi_bread(struct udevice *dev, lbaint_t lba, lbaint_t blkcnt,
+		       void *dst)
+{
+	int err, lnum;
+	struct blk_desc *blk = dev_get_uclass_plat(dev);
+	struct ubi_device *ubi = dev_get_plat(dev->parent);
+	struct ubi_volume *vol = ubi->volumes[blk->devnum];
+	lbaint_t lba_per_peb = vol->usable_leb_size / blk->blksz;
+	lbaint_t lba_off, lba_len, total = 0;
+
+	while (blkcnt) {
+		lnum = lba / lba_per_peb;
+		lba_off = lba % lba_per_peb;
+		lba_len = lba_per_peb - lba_off;
+		if (lba_len > blkcnt)
+			lba_len = blkcnt;
+
+		err = ubi_eba_read_leb(ubi, vol, lnum, dst,
+				       lba_off << blk->log2blksz,
+				       lba_len << blk->log2blksz, 0);
+		if (err) {
+			pr_err("UBI read error %x\n", err);
+			break;
+		}
+
+		lba += lba_len;
+		blkcnt -= lba_len;
+		dst += lba_len << blk->log2blksz;
+		total += lba_len;
+	}
+
+	return total;
+}
+
+static const struct blk_ops ubi_block_ops = {
+	.read 	= ubi_bread,
+};
+
+U_BOOT_DRIVER(ubi_block) = {
+	.name	= "ubi_block",
+	.id	= UCLASS_BLK,
+	.ops	= &ubi_block_ops,
+};
+
+static bool is_power_of_two(unsigned int x)
+{
+	return (x & -x) == x;
+}
+
+static unsigned int choose_blksz_for_volume(const struct ubi_volume *vol)
+{
+	/*
+	 * U-Boot assumes a power-of-two blksz; however, UBI LEBs are
+	 * very often not suitably sized. To solve this, we divide the
+	 * LEBs into a whole number of LBAs per LEB, such that each LBA
+	 * addresses a power-of-two-sized block. To choose the blksz,
+	 * we either:
+	 * 1) Use the volume alignment, if it's a non-unity power of
+	 *    two. The LEB size is a multiple of this alignment, and it
+	 *    allows the user to force a particular blksz if needed for
+	 *    their use case.
+	 * 2) Otherwise, find the greatest power-of-two factor of the
+	 *    LEB size.
+	 */
+	if (vol->alignment > 1 && is_power_of_two(vol->alignment))
+		return vol->alignment;
+
+	unsigned int blksz = 1;
+	while ((vol->usable_leb_size & blksz) == 0)
+		blksz <<= 1;
+	return blksz;
+}
+
+static int ubi_post_bind(struct udevice *dev)
+{
+	int i;
+	int ret;
+	unsigned int blksz;
+	lbaint_t lba;
+	struct udevice *blkdev;
+	struct ubi_device *ubi = dev_get_plat(dev);
+
+	for (i = 0; i < ubi->vtbl_slots; i++) {
+		struct ubi_volume *vol = ubi->volumes[i];
+		if (!vol || vol->vol_id >= UBI_INTERNAL_VOL_START ||
+		    vol->vol_type != UBI_STATIC_VOLUME)
+			continue;
+
+		if (vol->updating || vol->upd_marker) {
+			pr_err("** UBI volume %d (\"%s\") midupdate; ignored\n",
+			       vol->vol_id, vol->name);
+			continue;
+		}
+
+		blksz = choose_blksz_for_volume(vol);
+		lba = DIV_ROUND_UP((unsigned long long)vol->used_bytes, blksz);
+
+		pr_debug("UBI volume %d (\"%s\"): %lu blocks, %d bytes each\n",
+			 vol->vol_id, vol->name, lba, blksz);
+
+		ret = blk_create_device(dev, "ubi_block", vol->name, UCLASS_UBI,
+					vol->vol_id, blksz, lba, &blkdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int ubi_dm_bind(unsigned int index)
 {
 	struct udevice *dev;
@@ -71,4 +181,5 @@ U_BOOT_DRIVER(ubi) = {
 UCLASS_DRIVER(ubi) = {
 	.id		= UCLASS_UBI,
 	.name		= "ubi",
+	.post_bind	= ubi_post_bind,
 };
-- 
2.41.0

