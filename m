Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0077DE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85918967A;
	Wed,  4 Dec 2024 00:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B8Yz/73S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD1E98971E; Wed,  4 Dec 2024 00:48:02 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED5689326
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-841a6af60e9so195404039f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269677; x=1733874477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJBXxx6HiH+i0BZSnr8Ya1lsr37IE/0m9bFoPHC8N64=;
 b=B8Yz/73S42+npaOgvO2VaNbGt3T1o4U1BCvg/EZayagIKfoy4HTNyj64zs5bAizHM/
 QtidehPzhPXocUab0lMp8EIjUF5TFFbr9HXvDf3z2Z2KOsjmIugpU1XMiTqPgCA5aWws
 2NuWuKKbGEIGO2daO7HVy6OBuWZWFvm5O0Vdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269677; x=1733874477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJBXxx6HiH+i0BZSnr8Ya1lsr37IE/0m9bFoPHC8N64=;
 b=JSqE0zStzgxcAAkjid63vJHCk7yH/0gEYnridXC6+lRJrieuTggth9Qu+d+4z3yvRd
 Nkr6clpE8TyNXvFvLyYlubtijyvUio/1kvC6jMPniJSjxatqadpIa3GFjECV04ElsOTG
 bbIN3Mqi6RtfHQU4ojtGsfX7GD02KtxtHLRev83kVfmMbOmy2N/9qKY926y5ox8bnduc
 0q4TKHas+uAAXDPDCB0KyfQunacJFgXMZ3XKpYcgbwI8XDpaya8jnW9h57pNFfuTNd+r
 cYrwhHZBWxCdHMj+0XG9yeN3pquaDjeA56x+J/fqktDy9v+dgFCGX9OcaqmBm4s4/RF4
 c/KQ==
X-Gm-Message-State: AOJu0Yxznpp0c9x2j9kCIGlRhjWNlJQYbDBScVaTa4r9dA5oFeF3ys3a
 boZwZFKeQAERMhILIBIAg+yg2Y68u973VpwYQVy3q72wXlCYwXMU3P/HLyhP2cBKl4KHY6SJhqs
 =
X-Gm-Gg: ASbGnctPOU00WTZQ75f1jPh/j0lPC/uX8H5ujm3Kic92byZxCNELJAZotdPuEzSOxM2
 gswemnjcY3otcaYoYlgQ8kXpYcIcFlrpyeALi6uYQTzQke4I07dUdJKOorrx8//8tr5tRHe+iBb
 eXmHiZgnqjFQ/bbqxGYSdGTGn8kyOf9iig65iGr4RPTmc75DhbP0zEBH7ed0petYKlVeMkcRXxd
 79pXcVP+gUqF1+bj9In5bzHJ25nokkeSMQJWlMQ0Gz+So2Yb7x8wdFrPjAVn73JFk4ZnZDCuxfG
 YSx5WChlqOI=
X-Google-Smtp-Source: AGHT+IHiORxr/Z/1u2saGFSNISskG8wpAHs6CuMv+W5yn7P8usSaWRwYNJPQRDhVvK0dlJwayXrjXw==
X-Received: by 2002:a05:6602:3416:b0:83a:639b:bc44 with SMTP id
 ca18e2360f4ac-8445b543803mr511826239f.3.1733269676943; 
 Tue, 03 Dec 2024 15:47:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 37/41] bootstd: Update extlinux and pxe to allow boot
 interruption
Date: Tue,  3 Dec 2024 16:45:55 -0700
Message-Id: <20241203234559.2938192-38-sjg@chromium.org>
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

It is useful to be able to inspect things before the OS is actually
booted, perhaps to check that all is well or to adjust the kernel
command-line. Implement the 'read_all()' method to allow this.

Provide a simple test to check that the images are found.

For now it is not possible to actually continue the uninterrupted boot,
without re-reading all the images.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 10 ++++++++++
 boot/bootmeth_pxe.c      | 10 ++++++++++
 boot/ext_pxe_common.c    | 23 +++++++++++++++++++--
 include/extlinux.h       | 11 ++++++++++
 test/boot/bootflow.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index b29e07788b3..e866cf06152 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -145,6 +145,13 @@ static int extlinux_local_boot(struct udevice *dev, struct bootflow *bflow)
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
@@ -162,6 +169,9 @@ static struct bootmeth_ops extlinux_bootmeth_ops = {
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

