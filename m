Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2583EC61DCD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E395140575;
	Wed, 26 Aug 2026 16:34:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nSBOPRIjfozB; Wed, 26 Aug 2026 16:34:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762093;
	bh=8ywbdS0r0pjG/F+K1K5NTj2eOPfX4eOkrOXrKlMLJug=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XfL+vl/SvIwGJlsdusv++k//KcwJWxN5qy63HUxbpAW1Z8InVPPfCEaqm/H6pq+TJ
	 DSCajvhMRJiDkd8rO3q8EXsGvWdU+9UaQ4WL54WTRBojLVIeurh/EiituMMkG0x5gi
	 OCUy9+2sg6+XTZDT3jdamVjglwR5vlp8bQG5noyRq4d63DdY9mqPYtLNRZygSm00yk
	 XmLNKWXcE3sDEPNUl7YYNZqYPMTzmcfp0zHVJyHeHiIENWlyzLjuIpc4k/nGnUmHxM
	 p/P9cLwe1wCNnllzaxtAol+aCTrfl2tDC9gXaITsqj4G2DAcFgCPF2NkOKgmRnKUq2
	 ePdWydQdzTuEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 11679405CC;
	Wed, 26 Aug 2026 16:34:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65E3129B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5890640118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53C_7P3FCBe0 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=DhZ/q/0v
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE57D400DC
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:49 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1677c91969so128679166b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762087; x=1788366887;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ywbdS0r0pjG/F+K1K5NTj2eOPfX4eOkrOXrKlMLJug=;
 b=DhZ/q/0vWBS9eV0Y2BM8Gr4qQVie+8tYca2QjrMQtNnTWDxTJsBxQOTD/hOdiJskoq
 Kw7njC7Kju/jJNFMEXObZlbSYWwk18itLrcreHheTRmot1svv94c8iU7zdB/PkkgGZjG
 TFfcXlvz+gNRpISCKXTInOMriwy+2ALiBujG/TAmV7uWJ5hLskAEyVOz/3pMIaCq+9Vj
 iID9kIJlmvUGmn4BDzl3YfXUpknsW258eVpPYop5kc+xOIiaiJkgxsoz2QXKPfzV64gu
 Wldpfiobqi62YBiyQYFFTDE50H8FkjzXoJtI8FmyVKO4HblDxKmcayQIvXPzBAq81iFw
 lfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762087; x=1788366887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ywbdS0r0pjG/F+K1K5NTj2eOPfX4eOkrOXrKlMLJug=;
 b=VxL+A01zQoQughLQo7HT3OWu3eXm/Dwkp8PxWijZXUqQGuXFp0ZEz+uz65SMQYd7Wb
 CZ5TTm8SFZUI/OLLlOSzcAi/5XF1fO6HpUOekaoxz8+yeod84fUTUinVAiQF4BwvQf8G
 +x/OC0F91YmGxraE0/oO+TmORMQ3ELFEtD3uWqdKaeqBdL+GOSoFiAQv7YS3GHcIpYtm
 +u3bVHdI29hT+JZMR/oM2QC+nnRNNs3W8ShlhWDxtEMwakFGXbYwS/1rlaV9QvxosuAx
 rPbW3nY8rEAD8h+C1WLPG+fQZdV9rjmWa8SmcDB4opydHrAk+K21XP14tGDlfxBKyVdc
 TOkA==
X-Gm-Message-State: AFuF++lV6gzTlXVemmahOQyx/EDF2p/TjeF2w1S5mNiWmH3M+2+/NTiu
 wNTchI0kLfwrjhun2d1cmY+CLq+n28XghHl9AdanX56K5leff0/wVJXc55PNg5h/Ggw=
X-Gm-Gg: AR+sD11OYqBNQG4nvUTiZHW9O7lOdhGIgdehZyNRd+qX2le4LfFET6GqjUDgz9uhalu
 OdQ4eYxKr7TnQ7aPQM+bPDmuToHaBT0JHbxftc9leSE7jbiePcisrf7njVPe4RPKs1WcVSkm0yU
 FV5VIudWW2uuKeofShZbz/TLf/cuXB00my8ySMiH8KBusQk6CGRZ3FGWv9iWC/IJqjMcGi7SKqF
 bH1TvNTuDDfO52VwWBIJ59rsx0RT53BO8by6FSvDGQbKlgBdG4UoVxDdelVDxKRtpIQRtNldxWO
 yJOfOm3p9GOTAjl94GP8DhJzAuwjEjaBhYjoUZdFrz0iR+10U5KmdzJ31fkeK6R4l9bs3smU40t
 ndDWgi/IjxjHZ55ba7M+0FobvWLcCARaxRpSbuTa/0K2NL8+VZ4w3+mfzSsYgU29aXmAKOfaIMi
 51KrOS3s63THzmQd257Mjhdj1l78p4/rfp4WeGVpE9HExXaecmpexAIqql6VwIElFfDJwDHlq3o
 w6F0jqE6CS3IaBdK53vqsDrnsYCO+A7Chp3y0wCiw==
X-Received: by 2002:a17:907:7203:b0:c20:fda7:1856 with SMTP id
 a640c23a62f3a-c250bb76be9mr928574566b.8.1787762087534; 
 Wed, 26 Aug 2026 09:34:47 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:47 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:34:00 +0400
Subject: [PATCH v2 08/13] bootmeth: share the pxelinux getfile helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-8-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6938; i=alchark@flipper.net;
 h=from:subject:message-id; bh=IfCVdCKDpbFQVFDyoFLXf33GssB5SimKbVVTmUAUkZg=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/bOyzs408W2+ULTcv9Z4Uu39K4RlDrGrO7r25C+V
 lY4PHdGx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFMd+p2RYU75xvJzf8qs3aYF2H5KftfQK6d/rc7zmKf696wp9T3bNBgZrgbMZvE
 TzTx8O2Ov954TeyVWZJzYdPMz9wHh6X+3cS1yZAMA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

bootmeth_extlinux.c and bootmeth_pxe.c carry byte-identical copies of the
pxe_getfile_func that reads a file through the bootmeth uclass, and the
Boot Loader Specification bootmeth added later needs the same thing.

Move the function into a small translation unit of its own, so that all
consumers can call reuse it without introducing PXE dependency into
bootstd or bootstd dependency into PXE.

Bootmeths which need it select the new hidden BOOTMETH_PXE_COMMON symbol.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/Kconfig               |  8 ++++++++
 boot/Makefile              |  1 +
 boot/bootmeth_extlinux.c   | 20 --------------------
 boot/bootmeth_pxe.c        | 22 +---------------------
 boot/bootmeth_pxe_common.c | 34 ++++++++++++++++++++++++++++++++++
 include/extlinux.h         | 23 +++++++++++++++++++++++
 6 files changed, 67 insertions(+), 41 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba4932..add78a0b965a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -622,9 +622,16 @@ config BOOTMETH_CROS
 
 	  Note that only x86 devices are supported at present.
 
+config BOOTMETH_PXE_COMMON
+	bool
+	help
+	  Helpers shared by the bootmeths that hand their config files to the
+	  pxelinux parser. Selected by those bootmeths, not user-visible.
+
 config BOOTMETH_EXTLINUX
 	bool "Bootdev support for extlinux boot"
 	select PXE_UTILS
+	select BOOTMETH_PXE_COMMON
 	default y
 	help
 	  Enables support for extlinux boot using bootdevs. This makes the
@@ -640,6 +647,7 @@ config BOOTMETH_EXTLINUX
 config BOOTMETH_EXTLINUX_PXE
 	bool "Bootdev support for extlinux boot over network"
 	depends on CMD_PXE && CMD_NET && DM_ETH
+	select BOOTMETH_PXE_COMMON
 	default y
 	help
 	  Enables support for extlinux boot using bootdevs. This makes the
diff --git a/boot/Makefile b/boot/Makefile
index 7fb56e7ef379..a0f6cabcdfcc 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootstd-uclass.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD_MENU) += bootflow_menu.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
 
+obj-$(CONFIG_$(PHASE_)BOOTMETH_PXE_COMMON) += bootmeth_pxe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 921d721a27b2..bce6b4995717 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -68,26 +68,6 @@ static int extlinux_get_state_desc(struct udevice *dev, char *buf, int maxsize)
 	return 0;
 }
 
-static int extlinux_getfile(struct pxe_context *ctx, const char *file_path,
-			    char *file_addr, enum bootflow_img_t type,
-			    ulong *sizep)
-{
-	struct extlinux_info *info = ctx->userdata;
-	ulong addr;
-	int ret;
-
-	addr = simple_strtoul(file_addr, NULL, 16);
-
-	/* Allow up to 1GB */
-	*sizep = 1 << 30;
-	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
-				 type, sizep);
-	if (ret)
-		return log_msg_ret("read", ret);
-
-	return 0;
-}
-
 static int extlinux_check(struct udevice *dev, struct bootflow_iter *iter)
 {
 	int ret;
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index faa8d729b151..7e999730e6ac 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -23,26 +23,6 @@
 #include <net.h>
 #include <pxe_utils.h>
 
-static int extlinux_pxe_getfile(struct pxe_context *ctx, const char *file_path,
-				char *file_addr, enum bootflow_img_t type,
-				ulong *sizep)
-{
-	struct extlinux_info *info = ctx->userdata;
-	ulong addr;
-	int ret;
-
-	addr = simple_strtoul(file_addr, NULL, 16);
-
-	/* Allow up to 1GB */
-	*sizep = 1 << 30;
-	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
-				 type, sizep);
-	if (ret)
-		return log_msg_ret("read", ret);
-
-	return 0;
-}
-
 static int extlinux_pxe_check(struct udevice *dev, struct bootflow_iter *iter)
 {
 	int ret;
@@ -158,7 +138,7 @@ static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 	info.dev = dev;
 	info.bflow = bflow;
 	info.cmdtp = &cmdtp;
-	ret = pxe_setup_ctx(ctx, &cmdtp, extlinux_pxe_getfile, &info, false,
+	ret = pxe_setup_ctx(ctx, &cmdtp, extlinux_getfile, &info, false,
 			    bflow->subdir, false, false);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
diff --git a/boot/bootmeth_pxe_common.c b/boot/bootmeth_pxe_common.c
new file mode 100644
index 000000000000..d6800f0dc349
--- /dev/null
+++ b/boot/bootmeth_pxe_common.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Helpers shared by the bootmeths that boot via the pxelinux parser
+ *
+ * Copyright 2021 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <bootflow.h>
+#include <bootmeth.h>
+#include <extlinux.h>
+#include <pxe_utils.h>
+#include <vsprintf.h>
+
+int extlinux_getfile(struct pxe_context *ctx, const char *file_path,
+		     char *file_addr, enum bootflow_img_t type, ulong *sizep)
+{
+	struct extlinux_info *info = ctx->userdata;
+	ulong addr;
+	int ret;
+
+	addr = simple_strtoul(file_addr, NULL, 16);
+
+	/* Allow up to 1GB */
+	*sizep = 1 << 30;
+	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
+				 type, sizep);
+	if (ret)
+		return log_msg_ret("read", ret);
+
+	return 0;
+}
diff --git a/include/extlinux.h b/include/extlinux.h
index 721ba46371cc..54e054501445 100644
--- a/include/extlinux.h
+++ b/include/extlinux.h
@@ -7,6 +7,11 @@
 #ifndef __extlinux_h
 #define __extlinux_h
 
+#include <bootflow.h>
+#include <linux/types.h>
+
+struct pxe_context;
+
 #define EXTLINUX_FNAME	"extlinux/extlinux.conf"
 
 /**
@@ -14,6 +19,7 @@
  *
  * @dev: bootmethod device being used to boot
  * @bflow: bootflow being booted
+ * @cmdtp: command table entry to run the boot command with, or NULL
  */
 struct extlinux_info {
 	struct udevice *dev;
@@ -21,4 +27,21 @@ struct extlinux_info {
 	struct cmd_tbl *cmdtp;
 };
 
+/**
+ * extlinux_getfile() - Read a file named by a pxelinux-style config
+ *
+ * This is the pxe_getfile_func used by every bootmeth that hands its files
+ * to the pxelinux parser. It reads the file through the bootmeth uclass, so
+ * @ctx->userdata must point at a struct extlinux_info.
+ *
+ * @ctx: PXE context
+ * @file_path: Path of the file to read
+ * @file_addr: Address to load the file to, as a hex string
+ * @type: Image type used to record the loaded file in the bootflow
+ * @sizep: Returns the file size in bytes
+ * Return: 0 if OK, -ve on error
+ */
+int extlinux_getfile(struct pxe_context *ctx, const char *file_path,
+		     char *file_addr, enum bootflow_img_t type, ulong *sizep);
+
 #endif

-- 
2.54.0

