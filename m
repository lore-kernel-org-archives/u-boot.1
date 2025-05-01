Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5681FC3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 037DF81E25;
	Thu,  1 May 2025 15:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oK5Az/h0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DCD8283E; Thu,  1 May 2025 15:38:03 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FEE28213D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-8644aa73dfcso31899039f.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106674; x=1746711474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1m6nFEkq2Q6XrKeMXGUt/K2GVPAGK+Sdc7gMjdtGa0=;
 b=oK5Az/h0sOHn6JwAteWk8CTCPGEvjs4ywUJU10iYbJL4gWh2R5YQsEI9mXMxZb4+TC
 4DHqL9KFzjaKvfXs/fw83wAbfIRdODMQptGogJYq6fEnPERrKXhsbJJZwcvBLgU758y6
 Yh0ZGxXrsVJQ/0gt0OjFRvRI7mWJGIdRo1naQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106674; x=1746711474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1m6nFEkq2Q6XrKeMXGUt/K2GVPAGK+Sdc7gMjdtGa0=;
 b=n6a83HiqZCXlo3//UFhW5ZFyNu94LkOQt0kSjTB7w728/lZQHtFzf07XcSR4zo4FXe
 oJ29BZiN7m5gn1fllkvAzFYWAPB7uDrZmQuN8ZLd93cMJxys8pl98OhV5JTwq7mDYck7
 +oY8Eu8Wn6rfmZdJZ4MKDjvpjVCz7YiPpbCELQJ6GjNm7DPzbJn+icb2O34prokpurYD
 Jys3KBkZ9ffEi99BNf12xcDPX/xts6udbB7so47STtqbbhhm5H/kTcxFipXi2PoF0PHa
 fDY1f7iq48dMFpQhfg3hZ+YKiB+35acpGQIM/rF4i68zgG2+qoFsQHlMjdrjgmzOSn2g
 htRA==
X-Gm-Message-State: AOJu0Yx83I+RyofBasTdO79UgwqAdIUeS+kvL0ToemVow/ZmkxgSl95v
 +IxJ8qQJ99zrbvV1cXrbFdRIAr0RyuZvv5j1RkKoQ77TYtDCm9NlUQAMsIM4JEYzkSLZP9vQ4Gs
 =
X-Gm-Gg: ASbGncsd7SK1W62b4Uzmx7TYJPXr1JxdQ83YgF84bSml2y3CE5HAUQryyS/0OSCq1S2
 PY0Bif9SVKMY99uONOs6zcyKjdCsFuki/hzHiWmSkq0Lve1xQp6WYbnPetiME9iFmyryUn49enT
 mCX+CMRC4DglDtxY45OK+sg9ICfIczYaWI7k6fmvgs74OHKcdc0fVe8vvK97z/QdKjUKqw2et/p
 iMVHA2+achVqIcQPWx7B2oYPAWwwppPnRR9AB9GPwCutYAX920aQjMFNz6qWg00m1+4K0o+31Rh
 5/qI9btyMD5+cm7yBHlOFnZvOnXaVNABjIvgkDotvj+hSl2oTYu4KYVsm3LZqMe11E5Rkdqwiaq
 HEA==
X-Google-Smtp-Source: AGHT+IFe4VOt/x04GGVmp+lY1DIEMchNisnezwn0sID5gU5OrAIzt6f0HpA65q2VvlCc7sCqtNghAw==
X-Received: by 2002:a05:6e02:1a86:b0:3ce:4b12:fa17 with SMTP id
 e9e14a558f8ab-3d96f2528b6mr35441315ab.19.1746106674652; 
 Thu, 01 May 2025 06:37:54 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/18] bootstd: Tidy up a nested CONFIG_IS_ENABLED(BOOTSTD)
Date: Thu,  1 May 2025 07:37:14 -0600
Message-ID: <20250501133726.2627373-15-sjg@chromium.org>
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

Fix a nested check for BOOTSTD in the bootdev.h header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

