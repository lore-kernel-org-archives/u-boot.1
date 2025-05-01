Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12D9C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24B0F81FAB;
	Thu,  1 May 2025 15:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hh1j6p+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A8DC8214B; Thu,  1 May 2025 15:37:43 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 672DC820F6
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-85d9a87660fso108816939f.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106658; x=1746711458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jthDqotT8zS85ofCux29lkA8ro3rGDvLMr53Q5htYP4=;
 b=hh1j6p+iiT3Sky8KfdXb+avLqbikUv4omy2fZQAno6+RbgGG0QRsiyS8cJuETIwqRA
 64XlT8NaxuJtYdhtlSdliS8M10mtDhQW9kPrXy8dNUYSnYz2GscFS8H9/4eUvC7KHiIx
 0+4rNavTU+ZVaVe5mKc2n7GKf5h7YqMGOF5PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106658; x=1746711458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jthDqotT8zS85ofCux29lkA8ro3rGDvLMr53Q5htYP4=;
 b=uMkGaEfxpjsSOhmMIPJTU0xibTmqWBQl9AujZ0C8KWq2S+RsGmro4qL+LGb9VgKp/J
 8X9nuCqQ7n48BlEiZyIB88S2d2A+ldoj/73iJhiCnBk/U9AylcVNYwaZxLUhb+Irl/Zt
 ElxOn0MquEvFagCesqE3mVAc808dK8K3ukfioSrIoFynheDz4hSv0AL5QwCwhI7rY1tM
 DO1/vUZI0bBSeUoL0iNMiBvKq61FoUBhFRXCEFWymWGv/9Z7eimgNnTc1rFl7WgW962I
 jZLDpQLYWgwpeRjLNb08nblwczAwRFJUZ3AuH2gGkcvL2nPe7+fY96pQ2X9k4uH2CZ0u
 25+A==
X-Gm-Message-State: AOJu0Yx38AgqD7qnml6DIfzV33d61qJh+CZ/Bwtu4++3hRu3iWc5OiJJ
 8zXRXLWkE4dzQCecdVIZg9fVgh8YJAhAVFI95pXL3LhyXJKf/w/EntQtbo2rnx/TwwvtC455Usc
 =
X-Gm-Gg: ASbGncvuXlYV43fZxl0iD4zLYMP5WsctJ61RCQvIQev+k+c9XSak2Eaz43QAwAi652L
 O0J7PJlFXjxFHOTZLJXhcma39Uo3rmLiIZpp69uNz1Dq4XywrJ3ffNxdcZmgo1FBkG5Il/nhjWx
 Vh9cOdwhOZ97KrKPtZ9QUvVLuSNRZs1mSwV+iJ9+pSI8H/wmmF3dlTiD1Nr33rTUkZrfMLO/8b3
 06CMYe8eDR4M1iq6J0sUKeAFH7ejCpUTQnjuvbrB3uLzQI+UouwYYjkiDj/a4Qmp2Az+ZKfebT8
 niLaV33JH+Cs1DM9wsWTLMvvAVLWQqeWIHnxcdztRLBubwZp6DHYWyU9AIWZo0FFD2BhiLvwsy4
 KRQ==
X-Google-Smtp-Source: AGHT+IECAIjCetf6OkZQF5/fStCc9x1O/tHW9xHwzjlfKWoaqOxSNLAzjTuZlixwhBmVGJ3ok7+d1Q==
X-Received: by 2002:a05:6602:728b:b0:861:d8ca:3587 with SMTP id
 ca18e2360f4ac-86497f69743mr972665339f.4.1746106658624; 
 Thu, 01 May 2025 06:37:38 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/18] fs: boot: Update bootmeth_alloc_other() to use abuf
Date: Thu,  1 May 2025 07:37:04 -0600
Message-ID: <20250501133726.2627373-5-sjg@chromium.org>
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

Using an abuf for this function simplifies returning the size and also
makes it easier to free memory afterwards. Update the API and callers.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth-uclass.c | 12 ++++--------
 boot/bootmeth_script.c |  6 ++++--
 cmd/bootflow.c         |  2 +-
 include/bootflow.h     |  2 +-
 include/bootmeth.h     |  5 ++---
 5 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 78a3671f96a..02bbe77b563 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -360,13 +360,11 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
 }
 
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 enum bootflow_img_t type, void **bufp, uint *sizep)
+			 enum bootflow_img_t type, struct abuf *buf)
 {
 	struct blk_desc *desc = NULL;
-	struct abuf buf;
 	char path[200];
 	loff_t size;
-	size_t bsize;
 	int ret;
 
 	snprintf(path, sizeof(path), "%s%s", bflow->subdir, fname);
@@ -386,16 +384,14 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 	if (ret)
 		return log_msg_ret("fs", ret);
 
-	ret = fs_read_alloc(path, size, 0, &buf);
+	ret = fs_read_alloc(path, size, 0, buf);
 	if (ret)
 		return log_msg_ret("all", ret);
 
-	if (!bootflow_img_add(bflow, bflow->fname, type, abuf_addr(&buf), size))
+	if (!bootflow_img_add(bflow, bflow->fname, type, map_to_sysmem(buf),
+			      size))
 		return log_msg_ret("boi", -ENOMEM);
 
-	*bufp = abuf_uninit_move(&buf, &bsize);
-	*sizep = bsize;
-
 	return 0;
 }
 
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 020cb8a7aec..b3a51a35e89 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
+#include <abuf.h>
 #include <blk.h>
 #include <bootflow.h>
 #include <bootmeth.h>
@@ -68,6 +69,7 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	struct blk_desc *desc = NULL;
 	const char *const *prefixes;
 	const char *prefix;
+	struct abuf buf;
 	int ret, i;
 
 	ret = uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
@@ -107,8 +109,8 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	if (ret)
 		return log_msg_ret("inf", ret);
 
-	ret = bootmeth_alloc_other(bflow, "boot.bmp", BFI_LOGO,
-				   &bflow->logo, &bflow->logo_size);
+	ret = bootmeth_alloc_other(bflow, "boot.bmp", BFI_LOGO, &buf);
+	bflow->logo = abuf_uninit_move(&buf, &bflow->logo_size);
 	/* ignore error */
 
 	return 0;
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index e9ac9746104..0163129deba 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -419,7 +419,7 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("Logo:      %s\n", bflow->logo ?
 	       simple_xtoa((ulong)map_to_sysmem(bflow->logo)) : "(none)");
 	if (bflow->logo) {
-		printf("Logo size: %x (%d bytes)\n", bflow->logo_size,
+		printf("Logo size: %zx (%zd bytes)\n", bflow->logo_size,
 		       bflow->logo_size);
 	}
 	printf("FDT:       %s\n", bflow->fdt_fname);
diff --git a/include/bootflow.h b/include/bootflow.h
index 2caeb80b878..d988bc9355b 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -101,7 +101,7 @@ struct bootflow {
 	char *subdir;
 	char *fname;
 	void *logo;
-	uint logo_size;
+	size_t logo_size;
 	char *buf;
 	int size;
 	int err;
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 03301c90580..c32bbbab7e9 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -385,12 +385,11 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
  * @bflow: Information about file to read
  * @fname: Filename to read from (within bootflow->subdir)
  * @type: File type (IH_TYPE_...)
- * @bufp: Returns a pointer to the allocated buffer
- * @sizep: Returns the size of the buffer
+ * @buf: Returns the allocated buffer
  * Return: 0 if OK,  -ENOMEM if out of memory, other -ve on other error
  */
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 enum bootflow_img_t type, void **bufp, uint *sizep);
+			 enum bootflow_img_t type, struct abuf *buf);
 
 /**
  * bootmeth_common_read_file() - Common handler for reading a file
-- 
2.43.0

