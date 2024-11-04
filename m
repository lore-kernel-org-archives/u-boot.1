Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9320DD1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69025890F6;
	Mon,  4 Nov 2024 18:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EiW0nVYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F4B988F9F; Mon,  4 Nov 2024 18:51:43 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DFEC88F08
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83abcfb9f37so189353939f.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742699; x=1731347499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hndZiooSu6QplpANn6+0x+sY5q7jTfqLXOh98hT/S/o=;
 b=EiW0nVYXj5Be/UrR/t0bH7hhKl2VlNnaFf3XqqUXhwS9ZH3pSUUfOLt+oT79m5037n
 N4hIdxg3qXHoGCTmXApRTCH0YrMR/msjV3R+5s8I1fowDVF+F6d1Sxzd9HmclL9hBLI8
 3j6tzAwgc6WJElA0oQrXsMMqBArClRbyRMVDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742699; x=1731347499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hndZiooSu6QplpANn6+0x+sY5q7jTfqLXOh98hT/S/o=;
 b=gjxCX3EwsKQ+Tl8hROQaqxdmQrbt9y3HSwQfN5pwJ85tjNUltOox2hsoHPqxXjjA9u
 EsMNKEmgQTAiuA3TrFtvzHLvxiLjmQ36c3fnUa6vjW1FHHEDe6WRJl95YaykFixhguNA
 wgYv1HKkJNFpZFj0i9bOGLmmg1AUd17hSb6Oe5DQMARVbT7c2ion/FF67yKOCCzq0XWw
 Z1haVSI8/JhwR8YLXGhypFaZaGf4gVjpNTJz86kAz7HvMssVjmjP/ua1P+sCdFG2skgY
 uJ7wYHZusDTM7APYBQZoGv8TNpU9mK++c0hn4ud7PUgXjinGjcTgqsih7tDFKYWyId/S
 oeOQ==
X-Gm-Message-State: AOJu0YzdvnNaYBW3EP2t8HCm96dAsHJX3cbPI0NxpIKbSpYzKP2wqgDT
 Ox3U7abWXuzypOvkto7gyY3qnyBcOzyAJIlUmw0QU8xwBymd8GUm6qs/F4t2mMBCnidPgzfwfkU
 =
X-Google-Smtp-Source: AGHT+IEHos3AUx3RPMs5qkHrGOSvqgIqCrjeWyfiG5Ool31A3tGI8WtkWx56PcQTNglHh+8CEWvJOQ==
X-Received: by 2002:a05:6602:619b:b0:83b:28e2:4985 with SMTP id
 ca18e2360f4ac-83b28e24d1dmr2774872639f.12.1730742699624; 
 Mon, 04 Nov 2024 09:51:39 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 14/19] Update bootmeth_alloc_other() to record images
Date: Mon,  4 Nov 2024 10:51:05 -0700
Message-Id: <20241104175110.1048449-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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

