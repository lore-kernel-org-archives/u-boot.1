Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE9BC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F53381F28;
	Wed, 19 Mar 2025 15:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KF3QzfGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F73481E47; Wed, 19 Mar 2025 15:39:11 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C30538193A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:39:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39133f709f5so4314730f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395147; x=1742999947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6afDhkxfscx31CFLLxIJ0D9RJpJWYk/MSn8eMxtI7fY=;
 b=KF3QzfGsnIHVWFEFH8Eo56Zbuxk0fSpn2A+MiaRcoDoK6TAadnjqOGo29G8DAZV5bc
 3fsZvFTng8S5gvwJJU813feQh9ERQ7xTmtnY9T3pLETwnFkAJWWuWMBch1VoRvkWQt0+
 Ny9BO7ahj0rhYx//ElZjVemiXmtxSAXPa6IbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395147; x=1742999947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6afDhkxfscx31CFLLxIJ0D9RJpJWYk/MSn8eMxtI7fY=;
 b=fchslXdACjH5VpbNHX9JiXYupVwvQ12ejkqfQ4XFgzkPeqKHiez011vRavdBY3NGPy
 ddJ462ianR3Y4ei8Ja96f4AsbzuxWFu9d/eeFFeHkDVEMApdx0GqMsY+DTjZ886JM5p6
 Sai5lkcnSwfflfl5Ei7KTxjRSjfEA18YtCW93AWcwxCI2+Ao6mF6hBHDAQPdOKV/3gvt
 3joFV8HwRBQ2xAdQzEJ2ur7qh9UotIGrT/pXVf+UFFeAYkRPE7EPEhzH8kg2IaPxbt3k
 zi98S0OEzO6x7AgeI+GoKRJxMCmzjRkMFl1gcMaI5ZhdqrhJyGulsNmzeAsIAVpJkkNF
 7yvg==
X-Gm-Message-State: AOJu0YyNl4aYAe0el+2hCAQooK5KIGFH1iC//t5242DN8CA14IGvccLA
 RXymHgaKfoLvtqyKMIvS+Jc2INJmihczukfXrgVe95i6VwAF88CwqOoeQGeLylgFrQD0aGn0Gg0
 =
X-Gm-Gg: ASbGnct6L1AFf1hGUC0HLxJEYi1H/p8YUjm/COrzks7/682HNxHWgOCk2dtyZ6DZK6G
 dSL0wbaJ4S9wRDqT2HYxQq4wVbC2rQAXz6nB2ezcZ8laru+UI1GXn2QkXrCpqNRNaT51Ft/THCQ
 gIDsPNCvCrpUQkdto6r4u5TBHiRLDiJNwe6ab7/GScDoe9QC53+cpxe4vTwdxsSausjcsjbs9Hl
 Pf585C0B3cN16XF89I0bolMvyPIBzvtpB3jiGXV+1URaHgnWrPWeEL+0GYeyrUt4EtllilXro54
 399SndMEvugLk2WetKgkw97SWDZKXOKsRjGKxtlRgA==
X-Google-Smtp-Source: AGHT+IGxuT91tNX5UpwAluP4c08CUboh86Pj0pdm3Ux31oWm4Fay5fOVTlF6fmQd3m1r99xgxmoRGQ==
X-Received: by 2002:a05:6000:1fa7:b0:38f:355b:13e9 with SMTP id
 ffacd0b85a97d-399739c1008mr3270350f8f.15.1742395146625; 
 Wed, 19 Mar 2025 07:39:06 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:39:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/17] bootstd: Tidy up a nested CONFIG_IS_ENABLED(BOOTSTD)
Date: Wed, 19 Mar 2025 15:38:07 +0100
Message-ID: <20250319143820.2385092-14-sjg@chromium.org>
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

Fix a nested check for BOOTSTD in the bootdev.h header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/bootdev.h | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/include/bootdev.h b/include/bootdev.h
index 12c90c4ec1b..9ab95cebc12 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -368,7 +368,6 @@ int bootdev_next_prio(struct bootflow_iter *iter, struct udevice **devp);
  */
 int bootdev_setup_for_dev(struct udevice *parent, const char *drv_name);
 
-#if CONFIG_IS_ENABLED(BOOTSTD)
 /**
  * bootdev_setup_for_sibling_blk() - Bind a new bootdev device for a blk device
  *
@@ -383,32 +382,6 @@ int bootdev_setup_for_dev(struct udevice *parent, const char *drv_name);
  * Return: 0 if OK, -ve on error
  */
 int bootdev_setup_for_sibling_blk(struct udevice *blk, const char *drv_name);
-#else
-static int bootdev_setup_for_sibling_blk(struct udevice *blk,
-					 const char *drv_name)
-{
-	return 0;
-}
-#endif
-
-/**
- * bootdev_get_sibling_blk() - Locate the block device for a bootdev
- *
- * @dev: bootdev to check
- * @blkp: returns associated block device
- * Return: 0 if OK, -EINVAL if @dev is not a bootdev device, other -ve on other
- *	error
- */
-int bootdev_get_sibling_blk(struct udevice *dev, struct udevice **blkp);
-
-/**
- * bootdev_get_from_blk() - Get the bootdev given a block device
- *
- * @blk: Block device to check
- * @bootdebp: Returns the bootdev found, if any
- * Return 0 if OK, -ve on error
- */
-int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp);
 
 /**
  * bootdev_unbind_dev() - Unbind a bootdev device
@@ -421,6 +394,7 @@ int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp);
  * Return: 0 if OK, -ve on error
  */
 int bootdev_unbind_dev(struct udevice *parent);
+
 #else
 static inline int bootdev_setup_for_dev(struct udevice *parent,
 					const char *drv_name)
@@ -440,4 +414,23 @@ static inline int bootdev_unbind_dev(struct udevice *parent)
 }
 #endif
 
+/**
+ * bootdev_get_sibling_blk() - Locate the block device for a bootdev
+ *
+ * @dev: bootdev to check
+ * @blkp: returns associated block device
+ * Return: 0 if OK, -EINVAL if @dev is not a bootdev device, other -ve on other
+ *	error
+ */
+int bootdev_get_sibling_blk(struct udevice *dev, struct udevice **blkp);
+
+/**
+ * bootdev_get_from_blk() - Get the bootdev given a block device
+ *
+ * @blk: Block device to check
+ * @bootdebp: Returns the bootdev found, if any
+ * Return 0 if OK, -ve on error
+ */
+int bootdev_get_from_blk(struct udevice *blk, struct udevice **bootdevp);
+
 #endif
-- 
2.43.0

