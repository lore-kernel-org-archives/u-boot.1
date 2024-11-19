Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618E4D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D5A1895B2;
	Tue, 19 Nov 2024 14:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Es7TjBD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29178959C; Tue, 19 Nov 2024 14:20:29 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59708959C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3a77980fe3aso2027945ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022426; x=1732627226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eB7Tg5/Mj2EmHboymdl4Ei1AWpM9QElJe94D4ZwFlTA=;
 b=Es7TjBD0IVW5+d0r1w8F2TV1qX9mUtdWbF0jwkfQr+v/LwCFJ6CPi3/oaagqM9YUkN
 UrMUkIQuMjvT8jv2vowZ7hoN/w/j4AN1C6ptC12rjNAJyGguRT7+BKz8Mng5DI/22UmZ
 O+jIE1tYIvUgjXv0TCiwYScbcV9bYB9FVIlfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022426; x=1732627226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eB7Tg5/Mj2EmHboymdl4Ei1AWpM9QElJe94D4ZwFlTA=;
 b=jl6JNu52gZF8zaMXk3U8onw6ff256Gjwzucc+l7p9HF4WOnqoyDs/uQ2+tbX+dRyQK
 1Mv/mBJaPIBgHw3AXCTVyALRC+jcvZPvdTCMKoxzzhGAVCSONA0UI2jBCzn83AKjlk8q
 OA4vycCFfkBUJjnRyLHAlwWf68arcDyBgc0dJdkOlbv5lKlEsyVl4jvUPrfodoxPnmj0
 tk0y77O3bgKEkUQerqIUhZ7iFfnEary0u5iNarhCexqchJJmhq+xCKuigIdSSdGpPE4F
 +1Rg3G9tgA0khWAaFBGY6F1jIqoVKGjOBQrL0E31ZnHZALKVc3Ib8Ru+NwMyCLItTXlP
 JA7w==
X-Gm-Message-State: AOJu0YyFaCYXEypwv7ZBgMLXqmRYBV7hxk+ueuQObtNyYdqKh9eKARAp
 iFqsCZ51m12Fw/bEyS+QTQ/gZIDDc5N9cECMFEvo9uFyBpuKLPm++hBDYFsPfsFcKQ8iDeDbri0
 =
X-Google-Smtp-Source: AGHT+IEglFtDAEVf18lSUwgToV2y46iIj0q+gNOlwYnWtd6Twlc4aQJcKeq3bB3/EnXvlPxzlm6RcQ==
X-Received: by 2002:a05:6e02:19c9:b0:3a7:7f41:a35e with SMTP id
 e9e14a558f8ab-3a77f41a715mr8357005ab.5.1732022425874; 
 Tue, 19 Nov 2024 05:20:25 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 35/39] bootstd: Update extlinux and pxe to allow boot
 interruption
Date: Tue, 19 Nov 2024 06:18:40 -0700
Message-Id: <20241119131844.4078144-36-sjg@chromium.org>
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

It is useful to be able to inspect things before the OS is actually
booted, perhaps to check that all is well or to adjust the kernel
command-line. Implement the 'read_all()' method to allow this.

Provide a simple test to check that the images are found.

For now it is not possible to actually continue the uninterrupted boot,
without re-reading all the images.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_extlinux.c | 10 ++++++++++
 boot/bootmeth_pxe.c      | 10 ++++++++++
 boot/ext_pxe_common.c    | 23 +++++++++++++++++++--
 include/extlinux.h       | 11 ++++++++++
 test/boot/bootflow.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index df5b5ea7bf4..14c13971852 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -143,6 +143,13 @@ static int extlinux_local_boot(struct udevice *dev, struct bootflow *bflow)
 	return extlinux_boot(dev, bflow, extlinux_getfile);
 }
 
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
+static int extlinux_local_read_all(struct udevice *dev, struct bootflow *bflow)
+{
+	return extlinux_read_all(dev, bflow, extlinux_getfile);
+}
+#endif
+
 static int extlinux_bootmeth_bind(struct udevice *dev)
 {
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
@@ -160,6 +167,9 @@ static struct bootmeth_ops extlinux_bootmeth_ops = {
 	.read_file	= bootmeth_common_read_file,
 	.boot		= extlinux_local_boot,
 	.set_property	= extlinux_set_property,
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
+	.read_all	= extlinux_local_read_all,
+#endif
 };
 
 static const struct udevice_id extlinux_bootmeth_ids[] = {
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 6ecf81d7878..a4dd48a7010 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -142,6 +142,13 @@ static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 	return extlinux_boot(dev, bflow, extlinux_pxe_getfile);
 }
 
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
+static int extlinux_pxe_read_all(struct udevice *dev, struct bootflow *bflow)
+{
+	return extlinux_read_all(dev, bflow, extlinux_pxe_getfile);
+}
+#endif
+
 static int extlinux_bootmeth_pxe_bind(struct udevice *dev)
 {
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
@@ -158,6 +165,9 @@ static struct bootmeth_ops extlinux_bootmeth_pxe_ops = {
 	.read_file	= extlinux_pxe_read_file,
 	.boot		= extlinux_pxe_boot,
 	.set_property	= extlinux_set_property,
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
+	.read_all	= extlinux_pxe_read_all,
+#endif
 };
 
 static const struct udevice_id extlinux_bootmeth_pxe_ids[] = {
diff --git a/boot/ext_pxe_common.c b/boot/ext_pxe_common.c
index 7b9c41b5f77..c7f690dee17 100644
--- a/boot/ext_pxe_common.c
+++ b/boot/ext_pxe_common.c
@@ -75,8 +75,8 @@ int extlinux_set_property(struct udevice *dev, const char *property,
 	return 0;
 }
 
-int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
-		  pxe_getfile_func getfile)
+static int extlinux_process(struct udevice *dev, struct bootflow *bflow,
+			    pxe_getfile_func getfile, bool no_boot)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
 	ulong addr;
@@ -91,6 +91,7 @@ int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
 			    bflow->fname, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
+	plat->ctx.no_boot = no_boot;
 
 	ret = pxe_process(&plat->ctx, addr, false);
 	if (ret)
@@ -98,3 +99,21 @@ int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
 
 	return 0;
 }
+
+int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
+		  pxe_getfile_func getfile)
+{
+	return extlinux_process(dev, bflow, getfile, false);
+}
+
+int extlinux_read_all(struct udevice *dev, struct bootflow *bflow,
+		      pxe_getfile_func getfile)
+{
+	int ret;
+
+	ret = extlinux_process(dev, bflow, getfile, true);
+	if (ret)
+		return log_msg_ret("era", -EINVAL);
+
+	return 0;
+}
diff --git a/include/extlinux.h b/include/extlinux.h
index 69781e666c3..ab93761c54c 100644
--- a/include/extlinux.h
+++ b/include/extlinux.h
@@ -60,4 +60,15 @@ int extlinux_set_property(struct udevice *dev, const char *property,
 int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
 		  pxe_getfile_func getfile);
 
+/**
+ * extlinux_read_all() - read all files for a bootflow
+ *
+ * @dev: Bootmethod device to boot
+ * @bflow: Bootflow to read
+ * @getfile: Function to use to read files
+ * Return: 0 if OK, -EIO on I/O error, other -ve on other error
+ */
+int extlinux_read_all(struct udevice *dev, struct bootflow *bflow,
+		      pxe_getfile_func getfile);
+
 #endif
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 749d79d3295..4671bd7ab1f 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1410,3 +1410,46 @@ static int bootstd_adhoc(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(bootstd_adhoc, UTF_CONSOLE);
+
+/* Check scanning extlinux, adjusting cmdline and booting */
+static int bootflow_scan_extlinux(struct unit_test_state *uts)
+{
+	const struct bootflow_img *img;
+	struct bootstd_priv *std;
+	struct bootflow *bflow;
+
+	ut_assertok(run_command("bootflow scan", 0));
+	ut_assert_console_end();
+	ut_assertok(bootstd_get_priv(&std));
+
+	ut_asserteq(1, std->bootflows.count);
+
+	bflow = alist_getw(&std->bootflows, 0, struct bootflow);
+	std->cur_bootflow = bflow;
+
+	/* read all the images, but don't actually boot */
+	ut_assertok(inject_response(uts));
+	ut_assertok(bootflow_read_all(bflow));
+
+	/* check that the command line is now present */
+	ut_asserteq_str(
+		"ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB",
+		bflow->cmdline);
+
+	ut_asserteq(3, bflow->images.count);
+
+	/* check each image */
+	img = alist_get(&bflow->images, 0, struct bootflow_img);
+	ut_asserteq_strn("# extlinux.conf", map_sysmem(img->addr, 0));
+
+	img = alist_get(&bflow->images, 1, struct bootflow_img);
+	ut_asserteq(IH_TYPE_KERNEL, img->type);
+	ut_asserteq(0x1000000, img->addr);	/* kernel_addr_r */
+
+	img = alist_get(&bflow->images, 2, struct bootflow_img);
+	ut_asserteq(IH_TYPE_RAMDISK, img->type);
+	ut_asserteq(0x2000000, img->addr);	/* ramdisk_addr_r */
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_scan_extlinux, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.34.1

