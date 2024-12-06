Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84113E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54708978C;
	Fri,  6 Dec 2024 03:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lylkJOkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D0E89639; Fri,  6 Dec 2024 03:38:26 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B70B89753
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a77c066a15so6015515ab.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452702; x=1734057502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMR03ciOncqkvtcejI0AIuBObAhV4KL1rA4xH5j3ORY=;
 b=lylkJOkhB/Y4NQjJOUy/GdtdUbRbodkc5h2XHhA+pRI2NnAqxUAF5b47Konsp0yW1v
 D6JRDGeCQGfxCh7A3MwmXTyA7OriWk+hTzAqsfbYxKS4utY5MOk+5+I3GH5OXQzqj4l1
 /e3lMBYifkJT3NyOtBPZdHlsFrdqCsmfbUNBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452702; x=1734057502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMR03ciOncqkvtcejI0AIuBObAhV4KL1rA4xH5j3ORY=;
 b=OvAPeqa26PeDMnPLUYiwuTE7u6bBd4HftIzvElm6F8d1Ml2200YHliQEQCIwbsc4qF
 WdPThbx94ixWpnLroTcwiRTGKr+mURvHOJqinqfqH4zGRgF/WbFlUw9LnoLL/L89GFUH
 ky4VRzw3hBMLNRgengmAoLzDNJdhBiWRSoeFujvxafTDs5WjERq8V6eetyXYtfOZ9DM4
 EyZsos0i1fytoxyGsCO4hz5Dl4Ak6uzyYCEbr/3legi2fCvQKG9C+R/3RWNLSIdegX5q
 5fimsyDZqP3q7ioazrdsiE1QK5ieYyRautfjPtAqIkZaYZAWYjtjzFQoSQ6/kfBsMLdV
 pvLg==
X-Gm-Message-State: AOJu0YwOp1y0lQnqpQXFHZad5z5ZFq94Rp1r90+bHhRDPtevIOyyk5CG
 SApMD3gC61e4SntKyLlJsu7ALp373RrmMtuOlCQ6do686s/hzo3YatgBBzGTOQPov+ksTKwg3G8
 =
X-Gm-Gg: ASbGnct7zL/EL1DxWQKrllFR/Qnjn+BwsgIvBFtwGojMQPYujiciqNDqDPHgwkFVVCG
 ON6uCvfxaX4eO9DmUnYaE3ps4SrAKhduQqhYLdKDJmkIoCBVYvVC3lrat28GkRqdcg/ixIcVqub
 4/jBJOPWdD9asE3dXsZ0w1pDNivIrqm5U+ohGteqPi4jG6m0Dhbx1/4SkGDVEN0J3PdXGJneeTc
 DL7H3JLMX1A7GzM8Pnd1Yi3MlGh2s4R9IV9SqOTGPEThu/ai+V5/euujFnBX682zxRVZ7dtqfoF
 mCHNxijeQTs=
X-Google-Smtp-Source: AGHT+IE/Ne6pAWaBmHQbYPzBDBBpTDM+JRDDRQ0ZL50nUPpMnhQhDCnL/0/qRtIp8GLRnu/uPZQfug==
X-Received: by 2002:a05:6602:2d81:b0:835:4d27:edf6 with SMTP id
 ca18e2360f4ac-8447e238b26mr185357539f.7.1733452701881; 
 Thu, 05 Dec 2024 18:38:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:38:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 41/46] bootstd: Update extlinux and pxe to allow boot
 interruption
Date: Thu,  5 Dec 2024 19:36:20 -0700
Message-Id: <20241206023626.2456858-42-sjg@chromium.org>
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

It is useful to be able to inspect things before the OS is actually
booted, perhaps to check that all is well or to adjust the kernel
command-line. Implement the 'read_all()' method to allow this.

Provide a simple test to check that the images are found.

For now it is not possible to actually continue the uninterrupted boot,
without re-reading all the images.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Pass through the bootfile since extlinux and PXE are different

 boot/bootmeth_extlinux.c | 11 ++++++++++
 boot/bootmeth_pxe.c      | 11 ++++++++++
 boot/ext_pxe_common.c    | 29 ++++++++++++++++++++++++---
 include/extlinux.h       | 15 ++++++++++++++
 test/boot/bootflow.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index e7277ccdaa9..bd9026d448b 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -145,6 +145,14 @@ static int extlinux_local_boot(struct udevice *dev, struct bootflow *bflow)
 	return extlinux_boot(dev, bflow, extlinux_getfile, true, bflow->fname);
 }
 
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
+static int extlinux_local_read_all(struct udevice *dev, struct bootflow *bflow)
+{
+	return extlinux_read_all(dev, bflow, extlinux_getfile, true,
+				 bflow->fname);
+}
+#endif
+
 static int extlinux_bootmeth_bind(struct udevice *dev)
 {
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
@@ -162,6 +170,9 @@ static struct bootmeth_ops extlinux_bootmeth_ops = {
 	.read_file	= bootmeth_common_read_file,
 	.boot		= extlinux_local_boot,
 	.set_property	= extlinux_set_property,
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
+	.read_all	= extlinux_local_read_all,
+#endif
 };
 
 static const struct udevice_id extlinux_bootmeth_ids[] = {
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 5f3d595628c..4b5b88bae52 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -143,6 +143,14 @@ static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 			     bflow->subdir);
 }
 
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
+static int extlinux_pxe_read_all(struct udevice *dev, struct bootflow *bflow)
+{
+	return extlinux_read_all(dev, bflow, extlinux_pxe_getfile, false,
+				 bflow->subdir);
+}
+#endif
+
 static int extlinux_bootmeth_pxe_bind(struct udevice *dev)
 {
 	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
@@ -159,6 +167,9 @@ static struct bootmeth_ops extlinux_bootmeth_pxe_ops = {
 	.read_file	= extlinux_pxe_read_file,
 	.boot		= extlinux_pxe_boot,
 	.set_property	= extlinux_set_property,
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
+	.read_all	= extlinux_pxe_read_all,
+#endif
 };
 
 static const struct udevice_id extlinux_bootmeth_pxe_ids[] = {
diff --git a/boot/ext_pxe_common.c b/boot/ext_pxe_common.c
index 0d808048289..6e999af5fca 100644
--- a/boot/ext_pxe_common.c
+++ b/boot/ext_pxe_common.c
@@ -75,9 +75,9 @@ int extlinux_set_property(struct udevice *dev, const char *property,
 	return 0;
 }
 
-int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
-		  pxe_getfile_func getfile, bool allow_abs_path,
-		  const char *bootfile)
+static int extlinux_process(struct udevice *dev, struct bootflow *bflow,
+			    pxe_getfile_func getfile, bool allow_abs_path,
+			    const char *bootfile, bool no_boot)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
 	ulong addr;
@@ -92,6 +92,7 @@ int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
 			    bootfile, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
+	plat->ctx.no_boot = no_boot;
 
 	ret = pxe_process(&plat->ctx, addr, false);
 	if (ret)
@@ -99,3 +100,25 @@ int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
 
 	return 0;
 }
+
+int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
+		  pxe_getfile_func getfile, bool allow_abs_path,
+		  const char *bootfile)
+{
+	return extlinux_process(dev, bflow, getfile, allow_abs_path, bootfile,
+				false);
+}
+
+int extlinux_read_all(struct udevice *dev, struct bootflow *bflow,
+		      pxe_getfile_func getfile, bool allow_abs_path,
+		      const char *bootfile)
+{
+	int ret;
+
+	ret = extlinux_process(dev, bflow, getfile, allow_abs_path, bootfile,
+			       true);
+	if (ret)
+		return log_msg_ret("era", -EINVAL);
+
+	return 0;
+}
diff --git a/include/extlinux.h b/include/extlinux.h
index 5baa2440b53..f64597ebdef 100644
--- a/include/extlinux.h
+++ b/include/extlinux.h
@@ -64,4 +64,19 @@ int extlinux_boot(struct udevice *dev, struct bootflow *bflow,
 		  pxe_getfile_func getfile, bool allow_abs_path,
 		  const char *bootfile);
 
+/**
+ * extlinux_read_all() - read all files for a bootflow
+ *
+ * @dev: Bootmethod device to boot
+ * @bflow: Bootflow to read
+ * @getfile: Function to use to read files
+ * @allow_abs_path: true to allow absolute paths
+ * @bootfile: Bootfile whose directory loaded files are relative to, NULL if
+ *	none
+ * Return: 0 if OK, -EIO on I/O error, other -ve on other error
+ */
+int extlinux_read_all(struct udevice *dev, struct bootflow *bflow,
+		      pxe_getfile_func getfile, bool allow_abs_path,
+		      const char *bootfile);
+
 #endif
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f7d12765928..ef8c0c1bbaa 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1433,3 +1433,46 @@ static int bootstd_adhoc(struct unit_test_state *uts)
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

