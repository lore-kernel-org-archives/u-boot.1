Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99A2D68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC8B289725;
	Sat, 16 Nov 2024 00:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U6+CMt2Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0CBF891AD; Sat, 16 Nov 2024 00:20:15 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C13989701
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a6e960fb5dso628315ab.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712811; x=1732317611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yd/AHsQ4a61Z3sqLtTZZK/JX3O/OjD4U8zFnGEf0B9s=;
 b=U6+CMt2QoCNizZQccWO8QycmDPwTQjZqANBCBXBl+nt9d1kLAyh6vI58yLrcg05NND
 T3LZlK7dmecXX+cReFbftgUPXGRQzVYmNvGIwqWsx1yB81fNxkiBpmMkmIyUlzkLFF7n
 zXk6tQak+uPPpjnPr//j4ow0+hs3gBu0kHOUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712811; x=1732317611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yd/AHsQ4a61Z3sqLtTZZK/JX3O/OjD4U8zFnGEf0B9s=;
 b=l1sZcl4NwfEeLAFqSiz052T20tB7ppby7HGjVfDVnnss6LrXvi5uUw8SAgSlHFc88Z
 RHDagS0YuMd1ojtY9xHt/PKPWjpHETD0ZcTAIYndsPOCwcTeCbOanSjAR6kAFovWccPm
 v2/mYqeF25LEVavxxeN9BFnUpuJnlya5y73TFR60UXkNNAlcG1DyYV2934YPkIN+BtoB
 4AgNuBjQKYnpqasFEu39BMO1x47guJrOmzR3FBpn8SAEtZLA+Ie0vV7KMdBoKiQkyPl1
 NB7tf9VVymV84QRd/gHTDzmNdK1uVFpAi3SetIgoKif3zwfLVE12NasMMKKDYgahKq8X
 eyIw==
X-Gm-Message-State: AOJu0YzbUpLd7jS1pd4Imu0p/Su3QmQqeVHWFtRNQHd0e6HhVF5fm/El
 3sgRFy6mr7yaJR0la+MaoHIwjX0QcFNRuDm3p0EujD+ZkdkEc2d1eiI+dBLABsozSjvx3/E9mj0
 =
X-Google-Smtp-Source: AGHT+IFvSqoliP56JHh41gdOWYboi13X1jNDrqy3MTFYvxzE3rPrPXwcg3mxo3SU+YnrpbgCVhauyw==
X-Received: by 2002:a05:6602:340b:b0:83a:b33a:5e0a with SMTP id
 ca18e2360f4ac-83e6c0cd2cemr566820039f.4.1731712811687; 
 Fri, 15 Nov 2024 15:20:11 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:20:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v4 14/19] Update bootmeth_alloc_other() to record images
Date: Fri, 15 Nov 2024 16:19:21 -0700
Message-Id: <20241115231926.211999-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

Update this function to add the image to the list.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use the helper function

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth-uclass.c | 6 +++++-
 boot/bootmeth_script.c | 4 ++--
 include/bootmeth.h     | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 1f48d0c1f51..014b7588e8d 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -359,7 +359,7 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
 }
 
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 void **bufp, uint *sizep)
+			 enum bootflow_img_t type, void **bufp, uint *sizep)
 {
 	struct blk_desc *desc = NULL;
 	char path[200];
@@ -388,6 +388,10 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 	if (ret)
 		return log_msg_ret("all", ret);
 
+	if (!bootflow_img_add(bflow, bflow->fname, type, map_to_sysmem(buf),
+			      size))
+		return log_msg_ret("boi", -ENOMEM);
+
 	*bufp = buf;
 	*sizep = size;
 
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index a2fb2899885..020cb8a7aec 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -107,8 +107,8 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	if (ret)
 		return log_msg_ret("inf", ret);
 
-	ret = bootmeth_alloc_other(bflow, "boot.bmp", &bflow->logo,
-				   &bflow->logo_size);
+	ret = bootmeth_alloc_other(bflow, "boot.bmp", BFI_LOGO,
+				   &bflow->logo, &bflow->logo_size);
 	/* ignore error */
 
 	return 0;
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 788d4046ce9..26de593a9a4 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -384,12 +384,13 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
  *
  * @bflow: Information about file to read
  * @fname: Filename to read from (within bootflow->subdir)
+ * @type: File type (IH_TYPE_...)
  * @bufp: Returns a pointer to the allocated buffer
  * @sizep: Returns the size of the buffer
  * Return: 0 if OK,  -ENOMEM if out of memory, other -ve on other error
  */
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 void **bufp, uint *sizep);
+			 enum bootflow_img_t type, void **bufp, uint *sizep);
 
 /**
  * bootmeth_common_read_file() - Common handler for reading a file
-- 
2.34.1

