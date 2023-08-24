Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE69C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C5686A3E;
	Thu, 24 Aug 2023 21:56:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kB8w8XxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227EA8683C; Thu, 24 Aug 2023 21:56:20 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A1608683C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-790cadee81bso7148239f.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906976; x=1693511776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXuuPIgeS6x80/5Wz/9qgAxRCTRzmvZPMLlcPrye/v4=;
 b=kB8w8XxB7pQY+yKJITxb+NdOdzqKNyKIUZpWZ5iX5sd26y3xhzQNNyngaKvss3rcr7
 vXceVEc1B69dWXdYm8VNghaEYnThS0VprTi10dDmMz5N006IUb7rMD/B++Uzd+0GmltE
 W9Xg+CcTMuGIy92S5U8bQdK/qri8z35IEuvDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906976; x=1693511776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXuuPIgeS6x80/5Wz/9qgAxRCTRzmvZPMLlcPrye/v4=;
 b=Lgudxgiuco4/r9sRbgCDZknuXMTNi8PegbT+9tJfYZq95WTmgQI8I8sWY6tQFqJT+D
 f4WNUT31OTP6Gdy/9fNUE7nYcxnzsZZwcDIv8Yr6i/vf3ueh3NtC9CHte25jAoZD3vl3
 6HuB0xxSiXiKMTo8KBSl+tnDju3xShB/iOo2AKvrm+OFSeKp7SLy/c5qFMfhUw0pD++6
 uqAzasVh/6jeJalaCk5+Tgy64eutXzeYEk/ypMvUhWcWlQ+B/pMgMLhaxHp2paWiHKiD
 zrNMGvLcgifjzIrT6kGGT3Puw1DVk5usObQJ8viTbiZy6pOyRHiyWk8w91fmZ6RsRFKn
 gDEA==
X-Gm-Message-State: AOJu0YwfKGq6bSWs0DYeg23qDd+T6uEEZeQXlVF+mWBbnhKdIzyLSt+l
 4cgRvY6quu2Y4TJH9wJqJGLg6MfFlyQbx174SwQ=
X-Google-Smtp-Source: AGHT+IHyqj1E7CaFPA3nWC0aVGn3SsXv+pAx2PVeBdBaAuMW66vhsv9fa3e81daL+dWVYzrnUf7LJQ==
X-Received: by 2002:a5e:c102:0:b0:788:2eaf:46ce with SMTP id
 v2-20020a5ec102000000b007882eaf46cemr7624494iol.9.1692906975871; 
 Thu, 24 Aug 2023 12:56:15 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 20/23] bootstd: Support bootmeths which can scan any
 partition
Date: Thu, 24 Aug 2023 13:55:43 -0600
Message-ID: <20230824195553.1685996-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

Some bootmeths support scanning a partition without a filesystem on it.
Add a flag to support this.

This will allow the ChromiumOS bootmeth to find kernel partition, which
are stored in a special format, without a filesystem.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c   | 17 ++++++++++++++---
 doc/develop/bootstd.rst | 11 ++++++-----
 include/bootmeth.h      |  3 +++
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index c4044d87dc3e..69506e3865fc 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -111,6 +111,8 @@ int bootdev_bind(struct udevice *parent, const char *drv_name, const char *name,
 int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 			struct bootflow_iter *iter, struct bootflow *bflow)
 {
+	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(bflow->method);
+	bool allow_any_part = plat->flags & BOOTMETHF_ANY_PART;
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
 	struct disk_partition info;
 	char partstr[20];
@@ -142,6 +144,7 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 	 * us whether there is valid media there
 	 */
 	ret = part_get_info(desc, iter->part, &info);
+	log_debug("part_get_info() returned %d\n", ret);
 	if (!iter->part && ret == -ENOENT)
 		ret = 0;
 
@@ -154,7 +157,7 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 		ret = -ESHUTDOWN;
 	else
 		bflow->state = BOOTFLOWST_MEDIA;
-	if (ret) {
+	if (ret && !allow_any_part) {
 		/* allow partition 1 to be missing */
 		if (iter->part == 1) {
 			iter->max_part = 3;
@@ -174,9 +177,15 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 	if (!iter->part) {
 		iter->first_bootable = part_get_bootable(desc);
 		log_debug("checking bootable=%d\n", iter->first_bootable);
+	} else if (allow_any_part) {
+		/*
+		 * allow any partition to be scanned, by skipping any checks
+		 * for filesystems or partition contents on this disk
+		 */
 
 	/* if there are bootable partitions, scan only those */
-	} else if (iter->first_bootable ? !info.bootable : iter->part != 1) {
+	} else if (iter->first_bootable >= 0 &&
+		   (iter->first_bootable ? !info.bootable : iter->part != 1)) {
 		return log_msg_ret("boot", -EINVAL);
 	} else {
 		ret = fs_set_blk_dev_with_part(desc, bflow->part);
@@ -193,6 +202,7 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
 		bflow->state = BOOTFLOWST_FS;
 	}
 
+	log_debug("method %s\n", bflow->method->name);
 	ret = bootmeth_read_bootflow(bflow->method, bflow);
 	if (ret)
 		return log_msg_ret("method", ret);
@@ -559,7 +569,8 @@ int bootdev_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
 {
 	const struct bootdev_ops *ops = bootdev_get_ops(dev);
 
-	log_debug("->get_bootflow %s=%p\n", dev->name, ops->get_bootflow);
+	log_debug("->get_bootflow %s,%x=%p\n", dev->name, iter->part,
+		  ops->get_bootflow);
 	bootflow_init(bflow, dev, iter->method);
 	if (!ops->get_bootflow)
 		return default_get_bootflow(dev, iter, bflow);
diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
index ec3136535783..c01e0971dc84 100644
--- a/doc/develop/bootstd.rst
+++ b/doc/develop/bootstd.rst
@@ -677,11 +677,12 @@ Assuming the bootmeth is happy, or at least indicates that it is willing to try
 partition. If that works it tries to detect a file system. If that works then it
 calls the bootmeth device once more, this time to read the bootflow.
 
-Note: At present a filesystem is needed for the bootmeth to be called on block
-devices, simply because we don't have any examples where this is not the case.
-This feature can be added as needed. Note that sandbox is a special case, since
-in that case the host filesystem can be accessed even though the block device
-is NULL.
+Note: Normally a filesystem is needed for the bootmeth to be called on block
+devices, but bootmeths which don't need that can set the BOOTMETHF_ANY_PART
+flag to indicate that they can scan any partition. An example is the ChromiumOS
+bootmeth which can store a kernel in a raw partition. Note also that sandbox is
+a special case, since in that case the host filesystem can be accessed even
+though the block device is NULL.
 
 If we take the example of the `bootmeth_extlinux` driver, this call ends up at
 `extlinux_read_bootflow()`. It has the filesystem ready, so tries various
diff --git a/include/bootmeth.h b/include/bootmeth.h
index d3d8d608cd78..0fc36104ece0 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -16,9 +16,12 @@ struct udevice;
  * enum bootmeth_flags - Flags for bootmeths
  *
  * @BOOTMETHF_GLOBAL: bootmeth handles bootdev selection automatically
+ * @BOOTMETHF_ANY_PART: bootmeth is willing to check any partition, even if it
+ * has no filesystem
  */
 enum bootmeth_flags {
 	BOOTMETHF_GLOBAL	= BIT(0),
+	BOOTMETHF_ANY_PART	= BIT(1),
 };
 
 /**
-- 
2.42.0.rc1.204.g551eb34607-goog

