Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FC8C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF61981E47;
	Wed, 19 Mar 2025 15:39:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jN844zO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0859381E47; Wed, 19 Mar 2025 15:39:10 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 173F481EBB
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:39:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so6815789f8f.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395145; x=1742999945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V41w3+WINnrt7rkQNFLRPUVdzKMp0JgzLtt67xPgEiI=;
 b=jN844zO53solM97s+aQn5Hcz/dGtsoYdUfM51tWcGId4QFW9yQ2m/4gJMLc9Ba3tpw
 NQaBxtvMDKY8Depz6sYcIVIoJLKbSNauU7sNYsCR5FviSmJi5FJXDVjQaUHa3px2WWxY
 4wMzUgHeXq0404P0TxTbeWsj1aoDmE/1cYbQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395145; x=1742999945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V41w3+WINnrt7rkQNFLRPUVdzKMp0JgzLtt67xPgEiI=;
 b=YkEX6LILyQsNEWoijfEy+0UdqBU5OUMH57i3gCPniYJ3gwWakkRxPElgb7H136Z6Hv
 ju7XIEwqZE5II18lYQPid1B0mhM63Z5DxrzXdhDq3e23/EoWa8hZRf/ufc4qvko3ewBi
 moAh56cuIrkpm9n6HJHUdrB7f+4dvQAqYc1bDlzor2nXq0Te8t82a0LkwYzM7kMJZX6I
 Pxt5j6F61LUumvBy/uZ+GQgo0HvxemBW4POKOOekXA8d/ynG82VpPwt6XxhjdnWSeF0T
 xNvuqC3NGfFa2XeU/49/5KBJY3NsrVkcN9z5wx05gx5sA0N75EY0+qDD6o33QoGDNrQZ
 E+OQ==
X-Gm-Message-State: AOJu0Ywe1Mn/nvRPN3VhILv+TSNz8GpvMGbLRFVY9k0a/VryQanGN4HQ
 vpTTcxW5UOa290/2lsmt6Ieir9hHXRsPra2hlHNsEEFykUiThHdtpcqZZfp8JYj9QlBmGhQxhD0
 =
X-Gm-Gg: ASbGncs2ryuoCl5tyOXooWUll0e7PG+Hx550te2rfppj0+l+DUNEhgtPTOOSv82Hhct
 NUGkj1WWWq9rF4qhCzKw/lyGLVwD5kFeVZ835ly7UTt+SyNP7QH4xwto3OmzrJ+p6KOV272JtXo
 4aOC6YE3O5NKK2N4FKqQEffRQQYq/qjlD+ysahXnK2ty0KitwLqzbcYV0hc8eZMDRmYNZiEDThS
 gQ9lYc8rarrcsnFTQ69Yjra5dShT30+NLMgz5tKrMF+iQiaxvSum/QzX+ij1IPViu+itKOH/7zG
 5VDRHrIafEMmrbzyyAT+xXPu+PlfJvKxlMMpTw/ePA==
X-Google-Smtp-Source: AGHT+IE6jHth+OtKv5Aio+/lXUkaId0qDtLK19zTiwlXw5GqTOnXjgobuPFOuXG9615RpCHsSvFl+Q==
X-Received: by 2002:a05:6000:1448:b0:390:f0ff:2c11 with SMTP id
 ffacd0b85a97d-399739b9d52mr2747864f8f.2.1742395144908; 
 Wed, 19 Mar 2025 07:39:04 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:39:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/17] bootstd: Tweak scanning with labels
Date: Wed, 19 Mar 2025 15:38:06 +0100
Message-ID: <20250319143820.2385092-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

The current implementation of labels uses the ordering of the media
devices to start its scan but then uses the ordering of the (child)
bootdev devices to iterate from then on. This is inconsistent and can
miss some bootdevs.

Update bootdev_next_label() so that it uses the ordering of the bootdev
devices to perform its scan. Check for running out of labels as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootdev-uclass.c | 70 +++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 3791ebfcb42..cfb298d5be5 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -421,7 +421,7 @@ int bootdev_find_by_label(const char *label, struct udevice **devp,
 			  int *method_flagsp)
 {
 	int seq, ret, method_flags = 0;
-	struct udevice *media;
+	struct udevice *bdev;
 	struct uclass *uc;
 	enum uclass_id id;
 
@@ -433,10 +433,27 @@ int bootdev_find_by_label(const char *label, struct udevice **devp,
 		return log_msg_ret("uc", ret);
 	id = ret;
 
-	/* Iterate through devices in the media uclass (e.g. UCLASS_MMC) */
-	uclass_id_foreach_dev(id, media, uc) {
-		struct udevice *bdev, *blk;
-		int ret;
+	/*
+	 * Iterate through all the bootdevs looking for the first one for the
+	 * correct media uclass (e.g. UCLASS_MMC). We do it this way so that
+	 * iter_incr() can continue iterating through others with the same media
+	 * uclass, thus making sure that every relevant bootdev is used.
+	 *
+	 * If instead we found the first media device of the correct uclass,
+	 * then started with its bootdev, that bootdev may be somewhere in the
+	 * middle of the UCLASS_BOOTDEV ordering, thus we would leave out quite
+	 * a few bootdevs as the iteration continues
+	 */
+	uclass_id_foreach_dev(UCLASS_BOOTDEV, bdev, uc) {
+		struct udevice *media;
+
+		media = dev_get_parent(bdev);
+		if (device_get_uclass_id(media) != id) {
+			log_debug("- skip, media '%s' want id '%s'\n",
+				  dev_get_uclass_name(media),
+				  uclass_get_name(id));
+			continue;
+		}
 
 		/* if there is no seq, match anything */
 		if (seq != -1 && dev_seq(media) != seq) {
@@ -444,33 +461,20 @@ int bootdev_find_by_label(const char *label, struct udevice **devp,
 			continue;
 		}
 
-		ret = device_find_first_child_by_uclass(media, UCLASS_BOOTDEV,
-							&bdev);
-		if (ret) {
-			log_debug("- looking via blk, seq=%d, id=%d\n", seq,
-				  id);
-			ret = blk_find_device(id, seq, &blk);
-			if (!ret) {
-				log_debug("- get from blk %s\n", blk->name);
-				ret = bootdev_get_from_blk(blk, &bdev);
-			}
-		}
-		if (!ret) {
-			log_debug("- found %s\n", bdev->name);
-			*devp = bdev;
-
-			/*
-			 * if no sequence number was provided, we must scan all
-			 * bootdevs for this media uclass
-			 */
-			if (seq == -1)
-				method_flags |= BOOTFLOW_METHF_SINGLE_UCLASS;
-			if (method_flagsp)
-				*method_flagsp = method_flags;
-			log_debug("method flags %x\n", method_flags);
-			return 0;
-		}
-		log_debug("- no device in %s\n", media->name);
+		log_debug("- found bdev, seq=%d id %s\n", dev_seq(bdev),
+			  uclass_get_name(id));
+		*devp = bdev;
+
+		/*
+		 * if no sequence number was provided, we must scan all
+		 * bootdevs for this media uclass
+		 */
+		if (seq == -1)
+			method_flags |= BOOTFLOW_METHF_SINGLE_UCLASS;
+		if (method_flagsp)
+			*method_flagsp = method_flags;
+		log_debug("method flags %x\n", method_flags);
+		return 0;
 	}
 
 	return -ENOENT;
@@ -586,6 +590,8 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
 		const char *label = iter->labels[iter->cur_label];
 		int ret;
 
+		if (!label)
+			break;
 		log_debug("Scanning: %s\n", label);
 		ret = bootdev_hunt_and_find_by_label(label, &dev,
 						     method_flagsp);
-- 
2.43.0

