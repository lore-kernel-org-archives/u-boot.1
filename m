Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2D8E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C636080352;
	Wed,  1 Jan 2025 23:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NIeaZahI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C2E8031D; Wed,  1 Jan 2025 23:22:32 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3023F803B7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216401de828so138191435ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770148; x=1736374948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p4FemGjWws/Y9/qg9q+aaakcrVRt3hoEWJpfwSw6WXQ=;
 b=NIeaZahIgRl8Sq0TiM0dsbWHbc07K36mpGDyb2PDLQGvZh2o5nxEgMA0e8cK0JdMXE
 CPlJTWEsSrxcl5ouNUoYTIXGg67TaEfsCvvIhOrw5Ho395KlKh5/TQI6jx31YlCbm3iw
 LBzJtIOz5rwp6/wdPIkA6HMKQJGbxh2e888Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770148; x=1736374948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4FemGjWws/Y9/qg9q+aaakcrVRt3hoEWJpfwSw6WXQ=;
 b=hWXpOu04f1ADEXWo9T8SpXLyJ6HXNhzLegAtUBcJ5YR42atAju/pm8wjaKx3vjwm+z
 DsAHDvUEv+nfvUe2do3bS8LhSlNwJwo9TU7sUos544bRqRbwSo71XBjGnRK0SCbn/mrL
 R2klIIBgG9JThqUmHTT+oTS718RncNwgC8mFKJNNJnJ4Ek2BlLWYd6t5XOhtl//TD5M2
 SmUTynzcUY8tucacB8Wtij6vCHLzvdXXbdsQhKoRSeH0RcSy9fMqtXesjKoQPnT7hATz
 MCxKi3xM1dkP5ZPs6lDxD/MCKccNCkPQJ9mqUBLFtslFLW0K9GY/3ZrbzOsYKl4ul0hS
 GTvA==
X-Gm-Message-State: AOJu0YwNMUNOVrlA0G0OsUabWbAqBY2KnN8ErbB91f7clWF8AaW3X8+J
 MXnRp7WXh0bN0hogzu/UDh7ozTB8isuC9VxyEld+XGkLjd7Wg/1XE0MJ2yhpGxHgZsGQhIdNpr8
 =
X-Gm-Gg: ASbGncttu3wdNkZWa7oBOuYB5WYOnjyCD2DFMlE4vv9z/hR39OVmqANlrMpAp5SIl6k
 J028i7cUbwq26tdU4NuDCRzPI4VLhzCQS9wggyPJOysyGX5MZo4OWvkHkK740jE7ObUcMfajR2N
 eW7ap84qi4EqXDxfX3+A11sd8GsvZ+YQSkQB4y7wHikHVJDB6bjb4S3J+GMeQQOaeR+k/uNvzPS
 Zld/qNGKIj16+tQbk4wHGOhLqWDRhIBMY9d5XEFX+Y7Opn4AwQ1hhU=
X-Google-Smtp-Source: AGHT+IG4zFYZGIFcCsuAiw/6sx/uw3v0mYKSEBRFqvhsZ+dquy1BYm6GFreYMeRCxa0bbWoIl2IB3g==
X-Received: by 2002:a05:6a21:6f87:b0:1db:c20f:2c4d with SMTP id
 adf61e73a8af0-1e5e044b1c1mr63797485637.2.1735770147738; 
 Wed, 01 Jan 2025 14:22:27 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 49/67] upl: Correct name of upl-images
Date: Thu,  2 Jan 2025 11:09:35 +1300
Message-ID: <20250101221003.1944600-50-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

The spec originally had both singular and plural versions of this node,
but has settled on plural. Update U-Boot to match.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_read.c  | 4 ++--
 boot/upl_write.c | 8 ++++----
 include/upl.h    | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/boot/upl_read.c b/boot/upl_read.c
index fe48ae31ffb..1b6290ffb1c 100644
--- a/boot/upl_read.c
+++ b/boot/upl_read.c
@@ -302,7 +302,7 @@ static int decode_upl_params(struct upl *upl, ofnode options)
 }
 
 /**
- * decode_upl_images() - Decode /options/upl-image nodes
+ * decode_upl_images() - Decode /options/upl-images nodes
  *
  * @node: /options node in which to look for the node
  * Return 0 if OK, -ve on error
@@ -312,7 +312,7 @@ static int decode_upl_images(struct upl *upl, ofnode options)
 	ofnode node, images;
 	int ret;
 
-	images = ofnode_find_subnode(options, UPLN_UPL_IMAGE);
+	images = ofnode_find_subnode(options, UPLN_UPL_IMAGES);
 	if (!ofnode_valid(images))
 		return log_msg_ret("img", -EINVAL);
 	log_debug("decoding '%s'\n", ofnode_get_name(images));
diff --git a/boot/upl_write.c b/boot/upl_write.c
index a1ecb809cbc..9702ef91930 100644
--- a/boot/upl_write.c
+++ b/boot/upl_write.c
@@ -268,18 +268,18 @@ static int add_upl_params(const struct upl *upl, ofnode options)
 }
 
 /**
- * add_upl_image() - Add /options/upl-image nodes and properties to the tree
+ * add_upl_images() - Add /options/upl-images nodes and properties to the tree
  *
  * @upl: UPL state
  * @node: /options node to add to
  * Return 0 if OK, -ve on error
  */
-static int add_upl_image(const struct upl *upl, ofnode options)
+static int add_upl_images(const struct upl *upl, ofnode options)
 {
 	ofnode node;
 	int ret, i;
 
-	ret = ofnode_add_subnode(options, UPLN_UPL_IMAGE, &node);
+	ret = ofnode_add_subnode(options, UPLN_UPL_IMAGES, &node);
 	if (ret)
 		return log_msg_ret("img", ret);
 
@@ -606,7 +606,7 @@ int upl_write_handoff(const struct upl *upl, ofnode root, bool skip_existing)
 	if (ret)
 		return log_msg_ret("ad1", ret);
 
-	ret = add_upl_image(upl, options);
+	ret = add_upl_images(upl, options);
 	if (ret)
 		return log_msg_ret("ad2", ret);
 
diff --git a/include/upl.h b/include/upl.h
index a4ed24edbb8..dd43e8e8529 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -30,8 +30,8 @@ struct unit_test_state;
 #define UPLP_ADDR_WIDTH		"addr-width"
 #define UPLP_ACPI_NVS_SIZE	"acpi-nvs-size"
 
-#define UPLPATH_UPL_IMAGE	"/options/upl-image"
-#define UPLN_UPL_IMAGE		"upl-image"
+#define UPLPATH_UPL_IMAGES	"/options/upl-images"
+#define UPLN_UPL_IMAGES		"upl-images"
 #define UPLN_IMAGE		"image"
 #define UPLP_FIT		"fit"
 #define UPLP_CONF_OFFSET	"conf-offset"
-- 
2.43.0

