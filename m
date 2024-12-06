Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E5CE7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7231F8964B;
	Fri,  6 Dec 2024 03:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="amFIcYEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C891C8964B; Fri,  6 Dec 2024 03:38:22 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E80789639
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a789d422bcso10162265ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452699; x=1734057499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNoisvhlYym/phkHYZv/QNwyx/c4NzECymAONd28A60=;
 b=amFIcYEHdZjfcV55ZPJz3lBmt60ZPVz9whc8WJeWF/QTp3QhWCqquX82YQ0u1fqosI
 t1WcgDdYHb/Y9NeQzNc3jmlHxKtH7AhVnU03jBEPh5DjJz7vdbRlXkwYfFDaq22TVVot
 MVdNc2mpdXF4hdbbvE7iGtoqh3wIhoGmY6CKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452699; x=1734057499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNoisvhlYym/phkHYZv/QNwyx/c4NzECymAONd28A60=;
 b=hnuDgtUDGtkiayJAdgAeDF0Em4FgUIJc7JF/VLudt41sVytoo2/U3Wy26LKzZK0/Sl
 q6xIj4tWmI1VTThthkO0ergPye9kQCKisM2VEOkD/vAl50E45nPZ7xpzOxRXwL07+Df3
 g1T5fIMlhBxf2QTwvUKKiPJZ1S8IggPhf10axsshl7EQGO9A9SCoHfgLG4COUPmtB0iR
 lzSaI+k6FSPzXkHli80ZWbK8mFI7z83UNVFjwfBwnIs+OTtYNCoObzESZktdTy3g0/aq
 ySXgvVnH2UXEb3biCFqsCbBkytYyLs1lma2gKTRO6ChWVmIJwbbCt5lqVL/mF8HlKWZx
 rrkA==
X-Gm-Message-State: AOJu0Yzgwa1NL1ox522di2lQsuuxwpuqKd9skvQIFZubIrE75P79vQGU
 +HwygM/lwQohh+cBGfwtgSE/0HHrqqqgD37FM0nkkFSwbiof3lESt2fYhf39G2ykJlDquKmwpRs
 =
X-Gm-Gg: ASbGncsv1xxHCnsgAmTIy9LRddCLmBWiuMiDqUQjHbc2PeIB8AFze1AZIgKyZvel0fg
 1uJhjvi/fweKq12eS//LAbgdkuC28SJVNvmh7GBdd6EEma9TpqCpB5f96n0PHXcXyb+pbDAgQyW
 hD3AwFMnWHyEIn5HFJVWR0IQzhvCNqW93vzunBA0N9+Fzl6s7tNYIjisLbRBIXsGecdc1W3JrKo
 lNZe3d8zFxVKO3pUpoty8AyKiRaQC1aNQ6OWxA6zOgOYgCtM7Rs7XSbQ04VxrBwm+V9GbLLR0xE
 sG7R+wc1SDg=
X-Google-Smtp-Source: AGHT+IGWKTyVlT0MvofYAR8vehgC4Jmm5SrS5/DiDLBGq2ESHkYwjRfDBXg4gWR5i16f1kQrBO0Ieg==
X-Received: by 2002:a05:6e02:1c0f:b0:3a7:3760:7314 with SMTP id
 e9e14a558f8ab-3a811e29869mr22491665ab.20.1733452698776; 
 Thu, 05 Dec 2024 18:38:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 40/46] bootmeth_extlinux: Move boot code into common file
Date: Thu,  5 Dec 2024 19:36:19 -0700
Message-Id: <20241206023626.2456858-41-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Changes in v3:
- Pass through the bootfile since extlinux and PXE are different

 boot/bootmeth_extlinux.c | 24 +++---------------------
 boot/bootmeth_pxe.c      | 20 ++------------------
 boot/ext_pxe_common.c    | 25 +++++++++++++++++++++++++
 include/extlinux.h       | 15 +++++++++++++++
 4 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index d0a32eb8b68..e7277ccdaa9 100644
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
+	return extlinux_boot(dev, bflow, extlinux_getfile, true, bflow->fname);
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
index a9608edcef9..5f3d595628c 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -139,24 +139,8 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 
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
+	return extlinux_boot(dev, bflow, extlinux_pxe_getfile, false,
+			     bflow->subdir);
 }
 
 static int extlinux_bootmeth_pxe_bind(struct udevice *dev)
diff --git a/boot/ext_pxe_common.c b/boot/ext_pxe_common.c
index e42865b84f5..0d808048289 100644
--- a/boot/ext_pxe_common.c
+++ b/boot/ext_pxe_common.c
@@ -74,3 +74,28 @@ int extlinux_set_property(struct udevice *dev, const char *property,
 
 	return 0;
 }
+
+int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
+		  pxe_getfile_func getfile, bool allow_abs_path,
+		  const char *bootfile)
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
+	ret = pxe_setup_ctx(&plat->ctx, getfile, &plat->info, allow_abs_path,
+			    bootfile, false, plat->use_fallback, bflow);
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
index f97164954cc..5baa2440b53 100644
--- a/include/extlinux.h
+++ b/include/extlinux.h
@@ -49,4 +49,19 @@ struct extlinux_plat {
 int extlinux_set_property(struct udevice *dev, const char *property,
 			  const char *value);
 
+/**
+ * extlinux_boot() - Boot a bootflow
+ *
+ * @dev: bootmeth device
+ * @bflow: Bootflow to boot
+ * @getfile: Function to use to read files
+ * @allow_abs_path: true to allow absolute paths
+ * @bootfile: Bootfile whose directory loaded files are relative to, NULL if
+ *	none
+ * Return: 0 if OK, -ve error code on failure
+ */
+int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
+		  pxe_getfile_func getfile, bool allow_abs_path,
+		  const char *bootfile);
+
 #endif
-- 
2.34.1

