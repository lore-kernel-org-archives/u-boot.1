Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4BFD68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B81889728;
	Sat, 16 Nov 2024 00:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DHuMOeYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F7F89732; Sat, 16 Nov 2024 00:20:25 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8914B89718
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-83aad4a05eeso82636239f.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712821; x=1732317621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIHwOGiI25W1SxW3brkAxXoB+16u1YTfHNr/tjSMOBg=;
 b=DHuMOeYM/KBaFI7U/zrjREgHmz4WKBJOHUhMQK428GwJQBYAPVa+kvvoCuX45OqDj0
 tQFutz4dSbMa7rkGeMxZvsk7Xg/GSX4oRyJQKjJIWVDPLVHQX4B7T0xWCVe5QeuP+KLa
 WfcBktC0XMmA+Eg/wECIOMeu2RfXSLFrDWMpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712821; x=1732317621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIHwOGiI25W1SxW3brkAxXoB+16u1YTfHNr/tjSMOBg=;
 b=YgCvQB1S0VoNC4rK6eMeJXONd1WWSpb3WO+xqa167uGRDfuqwK9+D8OJw4YEk2oVOb
 cf0wOLfFPMKBv/97vDeUbV5vvDi6MTe5E03mI/MPmM5D8D9VnomlBZUDsUG3lG2GkwZQ
 jH/UmdSfwxd6N/hRrgaTnURunCESbyyreHRCSpxMrRrnwADWXuhusQouc8/1mxsE/Ntt
 R6E8oE3Pq7TbUKnSR7Rge1mNNfBcOwf2bhV0CpXuE0ta9Q1qxLVHmJD31nzFziwkgbF2
 4fdIU5pzaQO/+9Gpp7AWSRzI7EzQzlgVNA6FWNjZQFQZvy5n8cyF4bH/iV/nOIqs1lG6
 eeCg==
X-Gm-Message-State: AOJu0Yzk+6Cc6HcFicGZ1YLpyb30VSo/E0qcgsvV/kSmvGkqFVwfDRlb
 c76uKG1j3jYi+phTR1nwSMBGLiglBh4UiMb0M7R83mWoRA6TJtVLp03R3huVqfaRVRitrvkg0gM
 =
X-Google-Smtp-Source: AGHT+IGmk9jbZAAjAHN02elKkh1U5pHNVGXo8GYuy2OdiBJTkqa2GeyaIpgBVV+1ioBIHObLFANstA==
X-Received: by 2002:a05:6602:140f:b0:82d:16fa:52dd with SMTP id
 ca18e2360f4ac-83e6c0bee1cmr554478539f.7.1731712821286; 
 Fri, 15 Nov 2024 15:20:21 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:20:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>
Subject: [PATCH v4 18/19] bootstd: Add the concept of an ad-hoc bootflow
Date: Fri, 15 Nov 2024 16:19:25 -0700
Message-Id: <20241115231926.211999-19-sjg@chromium.org>
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

The normal situation with bootstd is that a bootflow is created from a
bootmeth. In some cases, a script or user-command may cause an image to
be loaded. To deal with this, add the concept of an ad-hoc bootflow.
This can be used to record information about manually loaded images.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add a new patch supporting ad-hoc bootflows

 boot/bootstd-uclass.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 cmd/bootflow.c        |  5 +++--
 include/bootflow.h    |  3 ++-
 include/bootstd.h     | 19 +++++++++++++++++++
 4 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index 8c0fd4e63c3..9bee73ead58 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -7,6 +7,8 @@
  */
 
 #include <alist.h>
+#include <blk.h>
+#include <bootdev.h>
 #include <bootflow.h>
 #include <bootstd.h>
 #include <dm.h>
@@ -161,11 +163,53 @@ int bootstd_get_priv(struct bootstd_priv **stdp)
 	return 0;
 }
 
+int bootstd_img_add(struct blk_desc *desc, int part, const char *fname,
+		    enum bootflow_img_t type, ulong addr, ulong size)
+{
+	struct udevice *bootdev = NULL;
+	struct bootstd_priv *std;
+	struct bootflow *bflow, bflow_s;
+	int ret;
+
+	ret = bootstd_get_priv(&std);
+	if (ret)
+		return ret;
+
+	if (desc) {
+		ret = bootdev_get_from_blk(desc->bdev, &bootdev);
+		if (ret)
+			return log_msg_ret("iad", ret);
+	}
+
+	bflow = alist_getw(&std->bootflows, std->adhoc_bflow, struct bootflow);
+	if (!bflow) {
+		bflow = &bflow_s;
+
+		bootflow_init(bflow, bootdev, NULL);
+		bflow->name = strdup("ad-hoc");
+		if (!bflow->name)
+			return log_msg_ret("ian", -ENOMEM);
+	}
+
+	if (!bootflow_img_add(bflow, fname, type, addr, size))
+		return log_msg_ret("iaf", -ENOMEM);
+
+	if (bflow == &bflow_s) {
+		ret = bootstd_add_bootflow(bflow);
+		if (ret < 0)
+			return log_msg_ret("iab", ret);
+		std->adhoc_bflow = ret;
+	}
+
+	return 0;
+}
+
 static int bootstd_probe(struct udevice *dev)
 {
 	struct bootstd_priv *std = dev_get_priv(dev);
 
 	alist_init_struct(&std->bootflows, struct bootflow);
+	std->adhoc_bflow = -1;
 
 	return 0;
 }
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index f88995a478f..5668a0c9b19 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -68,7 +68,8 @@ static void report_bootflow_err(struct bootflow *bflow, int err)
 static void show_bootflow(int index, struct bootflow *bflow, bool errors)
 {
 	printf("%3x  %-11s  %-6s  %-9.9s %4x  %-25.25s %s\n", index,
-	       bflow->method->name, bootflow_state_get_name(bflow->state),
+	       bflow->method ? bflow->method->name : "(none)",
+	       bootflow_state_get_name(bflow->state),
 	       bflow->dev ? dev_get_uclass_name(dev_get_parent(bflow->dev)) :
 	       "(none)", bflow->part, bflow->name, bflow->fname ?: "");
 	if (errors)
@@ -388,7 +389,7 @@ static int do_bootflow_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	printf("Name:      %s\n", bflow->name);
 	printf("Device:    %s\n", bflow->dev->name);
 	printf("Block dev: %s\n", bflow->blk ? bflow->blk->name : "(none)");
-	printf("Method:    %s\n", bflow->method->name);
+	printf("Method:    %s\n", bflow->method ? bflow->method->name : "(none)");
 	printf("State:     %s\n", bootflow_state_get_name(bflow->state));
 	printf("Partition: %d\n", bflow->part);
 	printf("Subdir:    %s\n", bflow->subdir ? bflow->subdir : "(none)");
diff --git a/include/bootflow.h b/include/bootflow.h
index 480cf8a5af1..d9045bc3dae 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -68,7 +68,8 @@ enum bootflow_flags_t {
  * @fs_type: Filesystem type (FS_TYPE...) if this is fixed by the media, else 0.
  *	For example, the sandbox host-filesystem bootdev sets this to
  *	FS_TYPE_SANDBOX
- * @method: Bootmethod device used to perform the boot and read files
+ * @method: Bootmethod device used to perform the boot and read files; NULL for
+ *	ad-hoc bootflows
  * @name: Name of bootflow (allocated)
  * @state: Current state (enum bootflow_state_t)
  * @subdir: Subdirectory to fetch files from (with trailing /), or NULL if none
diff --git a/include/bootstd.h b/include/bootstd.h
index 3398e48e88b..c39058c0787 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -10,10 +10,12 @@
 #define __bootstd_h
 
 #include <alist.h>
+#include <bootflow.h>
 #include <dm/ofnode_decl.h>
 #include <linux/list.h>
 #include <linux/types.h>
 
+struct blk_desc;
 struct udevice;
 
 /**
@@ -33,6 +35,7 @@ struct udevice;
  * @cur_bootflow: Currently selected bootflow (for commands)
  * @bootflows: (struct bootflow) Global list of all bootflows across all
  *	bootdevs
+ * @adhoc_bflow: Index of ad-hoc bootflow in bootflows (-1 if none)
  * @bootmeth_count: Number of bootmeth devices in @bootmeth_order
  * @bootmeth_order: List of bootmeth devices to use, in order, NULL-terminated
  * @vbe_bootmeth: Currently selected VBE bootmeth, NULL if none
@@ -47,6 +50,7 @@ struct bootstd_priv {
 	struct udevice *cur_bootdev;
 	struct bootflow *cur_bootflow;
 	struct alist bootflows;
+	int adhoc_bflow;
 	int bootmeth_count;
 	struct udevice **bootmeth_order;
 	struct udevice *vbe_bootmeth;
@@ -151,4 +155,19 @@ int bootstd_add_bootflow(struct bootflow *bflow);
  */
 int bootstd_clear_bootflows_for_bootdev(struct udevice *dev);
 
+/**
+ * bootstd_img_add() - Add an image to the ad-hoc bootflow
+ *
+ * @desc: Block descriptor for the device from which the file was loaded, or
+ *	NULL if not a block device
+ * @part: Partition number within the block device
+ * @fname: Filename of loaded file
+ * @type: File type, IH_TYPE_INVALID if not known
+ * @addr: Address where the file was loaded
+ * @size: Size of the file
+ * Return: 0 if OK, or -ve error code
+ */
+int bootstd_img_add(struct blk_desc *desc, int fs_type, const char *fname,
+		    enum bootflow_img_t type, ulong addr, ulong size);
+
 #endif
-- 
2.34.1

