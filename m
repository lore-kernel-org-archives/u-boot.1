Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE47E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AAE08973A;
	Wed,  4 Dec 2024 00:47:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I9IeK8gV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBEDE89723; Wed,  4 Dec 2024 00:47:57 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D0A189696
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-8418ecda126so206315639f.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269674; x=1733874474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkS3683fzoxJoEwTq687VyLmFcoQd9Ie0ZIBqtD5eBU=;
 b=I9IeK8gVFaQ3Ig3tjtUS52cYbo/sMW3/cDqhPLSEOggH8iURqpzCKU+qjOjxCR8Mue
 SZKvSEakBNI0uIniREb+qnGhXkEIXKLs1pyDVtoL4XkVI0F72p70NWPdmCwJuagUzTIk
 Bq/vwCAh6rkLDv0XJQpkVrjTX7BG/MckK/9GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269674; x=1733874474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pkS3683fzoxJoEwTq687VyLmFcoQd9Ie0ZIBqtD5eBU=;
 b=a6EBfgzDY/0YKzvp8l4KJWlzSg4fPknPUcc9GZHd01bEmxLIGhysOJu/SbVTxAMZGb
 BbFbKHbkHbdVLU1aEmr+/hP4oQF/58t20kUiR+eZ+0f5kyMVnbdVcUdwRVVbdji3qR0x
 2ooajxKfEijt5jdHv6veC/WWMz7YBDG8fX7nmOi2rFDf7GboVTOrexh6WNr6jPSPRorl
 QOAh51MGwa+am2EHOgf88cgyWwRrZ703zxLfQ8BxsaJAOVHJFcUeW2AaXnDIya1Om6Va
 qimJIOeefC2FqXvgm66IfF13mih1q5+V25B3gbolZlzH9otvXDaNLgPAUs7Xjgf7oBc+
 4MjQ==
X-Gm-Message-State: AOJu0YwSgn9r2CrYAwddOXxmbxHseJU42nLiKZAugh86TcLF6u10ZdLH
 5fpiq6I+BRn4EoS+Ey26I2u+/QWCAZvGnNzYFPwXI5LEqugjvqunr5cI/bXifriy2Xck8lpfz+o
 =
X-Gm-Gg: ASbGncv7APCFNT2Y9j43Ur3wcjAyjkagK2B3crVbsDce3qLfrvzCyElTxNnUEW8vvKJ
 W6SRYB5p0gKv+yU9ko36ZrYrv0aYbiO9jGSzPvDtyv8PymxuArrl7QGDd2RSGSaPDiTVprvBBE1
 EODpgIT4d8XiZ2zleaepmfioNhg6DECNJGDMrGgSErsEMxaflxHOL2ovlyGXk7367qvDUfTfv6O
 Zdaw0YLfXDCaMasVag0ZupzoSuzV6L0mMXY+uU86LP11OFmbodJIjvlKoflgHwkKdlwrx2LdiCs
 AN2HUVOrYpc=
X-Google-Smtp-Source: AGHT+IH6QVwF8A/N/V0aD498W3SjX82+OD05A92WTRYwg9xmynUA+FNDXP8oqtx5Zzo6slAF2wQbcw==
X-Received: by 2002:a05:6602:14c5:b0:832:480d:6fe1 with SMTP id
 ca18e2360f4ac-8445b43dfcamr570053139f.0.1733269673878; 
 Tue, 03 Dec 2024 15:47:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 36/41] bootmeth_extlinux: Move boot code into common file
Date: Tue,  3 Dec 2024 16:45:54 -0700
Message-Id: <20241203234559.2938192-37-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

The extlinux and PXE code for booting is almost the same. Move it into
the common file so it is easier to keep it in sync.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 24 +++---------------------
 boot/bootmeth_pxe.c      | 19 +------------------
 boot/ext_pxe_common.c    | 24 ++++++++++++++++++++++++
 include/extlinux.h       | 11 +++++++++++
 4 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index d0a32eb8b68..b29e07788b3 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -140,27 +140,9 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	return 0;
 }
 
-static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
+static int extlinux_local_boot(struct udevice *dev, struct bootflow *bflow)
 {
-	struct extlinux_plat *plat = dev_get_plat(dev);
-	ulong addr;
-	int ret;
-
-	addr = map_to_sysmem(bflow->buf);
-
-	plat->info.dev = dev;
-	plat->info.bflow = bflow;
-
-	ret = pxe_setup_ctx(&plat->ctx, extlinux_getfile, &plat->info, true,
-			    bflow->fname, false, plat->use_fallback, bflow);
-	if (ret)
-		return log_msg_ret("ctx", -EINVAL);
-
-	ret = pxe_process(&plat->ctx, addr, false);
-	if (ret)
-		return log_msg_ret("bread", -EINVAL);
-
-	return 0;
+	return extlinux_boot(dev, bflow, extlinux_getfile);
 }
 
 static int extlinux_bootmeth_bind(struct udevice *dev)
@@ -178,7 +160,7 @@ static struct bootmeth_ops extlinux_bootmeth_ops = {
 	.check		= extlinux_check,
 	.read_bootflow	= extlinux_read_bootflow,
 	.read_file	= bootmeth_common_read_file,
-	.boot		= extlinux_boot,
+	.boot		= extlinux_local_boot,
 	.set_property	= extlinux_set_property,
 };
 
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index a9608edcef9..6ecf81d7878 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -139,24 +139,7 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 
 static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 {
-	struct extlinux_plat *plat = dev_get_plat(dev);
-	struct pxe_context *ctx = &plat->ctx;
-	ulong addr;
-	int ret;
-
-	addr = map_to_sysmem(bflow->buf);
-	plat->info.dev = dev;
-	plat->info.bflow = bflow;
-	ret = pxe_setup_ctx(ctx, extlinux_pxe_getfile, &plat->info, false,
-			    bflow->subdir, false, plat->use_fallback, bflow);
-	if (ret)
-		return log_msg_ret("ctx", -EINVAL);
-
-	ret = pxe_process(ctx, addr, false);
-	if (ret)
-		return log_msg_ret("bread", -EINVAL);
-
-	return 0;
+	return extlinux_boot(dev, bflow, extlinux_pxe_getfile);
 }
 
 static int extlinux_bootmeth_pxe_bind(struct udevice *dev)
diff --git a/boot/ext_pxe_common.c b/boot/ext_pxe_common.c
index e42865b84f5..7b9c41b5f77 100644
--- a/boot/ext_pxe_common.c
+++ b/boot/ext_pxe_common.c
@@ -74,3 +74,27 @@ int extlinux_set_property(struct udevice *dev, const char *property,
 
 	return 0;
 }
+
+int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
+		  pxe_getfile_func getfile)
+{
+	struct extlinux_plat *plat = dev_get_plat(dev);
+	ulong addr;
+	int ret;
+
+	addr = map_to_sysmem(bflow->buf);
+
+	plat->info.dev = dev;
+	plat->info.bflow = bflow;
+
+	ret = pxe_setup_ctx(&plat->ctx, getfile, &plat->info, true,
+			    bflow->fname, false, plat->use_fallback, bflow);
+	if (ret)
+		return log_msg_ret("ctx", -EINVAL);
+
+	ret = pxe_process(&plat->ctx, addr, false);
+	if (ret)
+		return log_msg_ret("bread", -EINVAL);
+
+	return 0;
+}
diff --git a/include/extlinux.h b/include/extlinux.h
index f97164954cc..69781e666c3 100644
--- a/include/extlinux.h
+++ b/include/extlinux.h
@@ -49,4 +49,15 @@ struct extlinux_plat {
 int extlinux_set_property(struct udevice *dev, const char *property,
 			  const char *value);
 
+/**
+ * extlinux_boot() - Boot a bootflow
+ *
+ * @dev: bootmeth device
+ * @bflow: Bootflow to boot
+ * @getfile: Function to use to read files
+ * Return: 0 if OK, -ve error code on failure
+ */
+int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
+		  pxe_getfile_func getfile);
+
 #endif
-- 
2.34.1

