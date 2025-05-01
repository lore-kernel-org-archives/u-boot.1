Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14E0C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE76B8291D;
	Thu,  1 May 2025 15:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RvzKvFP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5ED828C2; Thu,  1 May 2025 15:37:57 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C538059D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-85ea482e3adso70776339f.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106673; x=1746711473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neoJySYzueLyJUux9yf1G7iL+/J4px+z9nSO8nYBqgk=;
 b=RvzKvFP3NIv9U1IK/QHGjC12essg40CfsIl5c0YakH/nu1H8+cNgwUZsCVKSH5ix3d
 nUjjRNeO5P9XfvgrsZ8/WVROOQ8mDvt7mlN9tESJ2FcUT7e4EmYgfyo/q6jXrNV5AFFf
 qL394WAACms70KXx+O22E0jJ/QJHwRsCWw3bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106673; x=1746711473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=neoJySYzueLyJUux9yf1G7iL+/J4px+z9nSO8nYBqgk=;
 b=eTeTPpavVTmHoaEqFbMWKbjtsDkxSDsGv36yIloCDPIEtGOtam2tPz9M/AruiaOvaP
 eylTx0Q5nden/gVqJ0VDOZR5eDtwbkVuZFk5BTRaIzb504W1ArV3MLdNAzhuRt5wLqgG
 8n8oMuZxXAIGwxLS5gAZSVw9LiwEL7/1rUDnCPWzacWchl+08zrHegLyoo/y2uYDasj1
 knIImmYIH/ILG/WIk5i8HaV7EDd/BvseKidUt4ZJaHUe8tieE9JAkmweBKDG10zr7ZfM
 ef7v2QmurZrHO8OLLMxoib0Xv5o3sds5KdJIg5u7sm35uwhh90KE6D3Ba6yzOcvph1jE
 o5TA==
X-Gm-Message-State: AOJu0Yxk+FF9NepMra3fv+3fpwe6KHhxCk9RNpBeLb74zKzl+AwHcy3n
 1ukB3Kk8BPCWqiZQzHx5gjunZzK72itTX2MQlQifpsE1DE6o4ShC0an4Q4vCuLvtG9zWMwGpdIg
 =
X-Gm-Gg: ASbGncvOyjUONK/Hb5AxlF3YeQW7SVtcdjOw3LTEbim+psnGdPs7+U+cI/5izjeYywV
 62GmhIR8o+CMiZgLfiD4meFO98HBq2ZPNpvaa/nQq13JG7ncuATIV4M0uIgrrIrnYigX/zVD8E4
 ApHQpo/EXlm7Hc8Bj5H9N0G0lymRGFmW22ORVNyNmUxgbAM8iJO58G52DdCyuj7Bllryo/S9Bu7
 ClU1nS40HO66AVqsSMVPF+aF+/WoL7vIQ/lQjY9LvNHpSr2ej+nVadxHM2o/xApMuZrBRbsCB3X
 hqOLHc81xeKi6DMnuUMBPiCMmO0aYksL73x6mZnghRI22SwRvcqirzTXRaYHM1JYERRK+9zdaK2
 aQA==
X-Google-Smtp-Source: AGHT+IF768q4R2G9LZehEkOrb9On5jlulOaIkuwQTrREruPR+5EBWGIrgDps8bbyB0H27P/+Vch/VQ==
X-Received: by 2002:a05:6602:117:b0:858:7b72:ec89 with SMTP id
 ca18e2360f4ac-864a3d6629bmr259310239f.5.1746106673003; 
 Thu, 01 May 2025 06:37:53 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/18] bootstd: Tweak scanning with labels
Date: Thu,  1 May 2025 07:37:13 -0600
Message-ID: <20250501133726.2627373-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

(no changes since v1)

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

