Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CEDD44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18276895FA;
	Tue, 19 Nov 2024 14:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b7gphkzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A137C89712; Tue, 19 Nov 2024 14:20:27 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 686368959C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a761c7c4fbso10303405ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022423; x=1732627223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erD8gkm3Av1iLV4cowTNHjLOWrEy/uDVOGXrNspU2cg=;
 b=b7gphkzc2JyUFNU8utLdrgG6mlE+hpW/OtO2xGIyDSct8X0XI0/F3zP3uxGXrii9Op
 y7YrlPnwTABPM8aUGPb/J7m3ci1UNN/YJFb8VxImfZ0uTVuBtY4p583BPxtBudKlWSn0
 IUOKPoiWn93+fqGfmn9qRQXG5Gg4zuonll7hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022423; x=1732627223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erD8gkm3Av1iLV4cowTNHjLOWrEy/uDVOGXrNspU2cg=;
 b=R3irPgk9Pm+1VgiTZ5Ej1iwaYSNnr9yrn7ZeReKbz5kDhx3iPZbvP5zrDGix9L+pPN
 os+ugRcp9W9FvdT8q3oqjkfo8qEDHTTrno/kmSO3mwQqW0IGwX+xq+F7DKTh/Rui7ghc
 VSgqpIfsotlz6lROFvaQMsIe78jHuC/pHbH4EqA7wFkR/SOwP2zss2Cd+eqjedjfBDS9
 9Ir4DWvs80sCUjHpbtdHmXjcid8dCgSCFNOd0WY9v5C1eo78n8yHmbD1vmw/M/+o26w7
 Gp+4Q4CPQYEmZcc1dzkIuCSOO9p6ZzPoSHWnCe7pABDciDA/ViAz7+UH74EuEFOiiK0a
 5f5Q==
X-Gm-Message-State: AOJu0YxPYi3tO3KSCrLRK9e+ahuwpubDSj/nAZ7F8hrctgmv9/ERrUDw
 Eu+1J/P80ALzH/DE/ZST4loYQUYQlW3gIrUfaIulNSpbL0Wqi0FeOQZ40vqvLyf1q6uPfVNdAH0
 =
X-Google-Smtp-Source: AGHT+IGGszPn17rCtu9CmBR99OrrXXF9dsVg1RkpP+J4KWQigIUsvx9vx3GCcmAtLnexkSUHR4spnQ==
X-Received: by 2002:a05:6e02:3305:b0:3a7:453c:b16e with SMTP id
 e9e14a558f8ab-3a74804aff2mr143233905ab.13.1732022423674; 
 Tue, 19 Nov 2024 05:20:23 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 34/39] bootmeth_extlinux: Move boot code into common file
Date: Tue, 19 Nov 2024 06:18:39 -0700
Message-Id: <20241119131844.4078144-35-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

 boot/bootmeth_extlinux.c | 24 +++---------------------
 boot/bootmeth_pxe.c      | 19 +------------------
 boot/ext_pxe_common.c    | 24 ++++++++++++++++++++++++
 include/extlinux.h       | 11 +++++++++++
 4 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index ce11077ee35..df5b5ea7bf4 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -138,27 +138,9 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
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
@@ -176,7 +158,7 @@ static struct bootmeth_ops extlinux_bootmeth_ops = {
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

