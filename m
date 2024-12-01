Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5F7D49773
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 14:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E56A8929D;
	Sun,  1 Dec 2024 15:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kvkk1zEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FB689287; Sun,  1 Dec 2024 15:43:11 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAC6789390
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 15:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8418ecda128so122092339f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733064184; x=1733668984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wbWMIBDx0k8n8nEJLqR586S8OkAyT1gYzI1DTscHaM=;
 b=kvkk1zEEaJDwR7PKoIvD2wLiBDNpntX/C/VPR9b7TmE7aBCqaSKo8v/3rt6drQl7qU
 JIVv0hx9JSqYq+fAvHAswGqEgMegXZDYnb9JPTdcj5Hag6CCHGRBcvdTUNRQ8MsErT5C
 UnCceuEfvHLYxrGqXENyrSuFjc8U/OtSlHh2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733064184; x=1733668984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wbWMIBDx0k8n8nEJLqR586S8OkAyT1gYzI1DTscHaM=;
 b=ozHRByLth0Hcsx9j1DPz1GK/P/LN5sNwySKoDtK6QH3G8Dfc8+yhoab0RPdqOssgKD
 HnAHzltjI4Du4Xu0ZR02L7cywa8P5VtD9ib9hxVvwraoHNqdpQBFyRF9+CKuIMDLKXIf
 CUYXVTeNithhbL+VaZkACvxsUnbJodJTTd08VFePGClaiaTKMBc2HStBaUM26u2q42/4
 hmwdN9ofPkUBLw2gjMqATEL2vkQvJUxkwixHKOeuBxqgoVyJRJ2qC2NyoggSFyehVh/p
 WT+fqzyA8bwmO7M0TLddkHWdR2Uri1ia13HwneYxvxIy3zeMUblZl0eEy8adTA2SQ+gE
 q6Eg==
X-Gm-Message-State: AOJu0YzUmaJvLYvbKZ4ROYfC/36TKgdR0juMyaaBdh43weNvHp1isdbD
 MqWIkrvTxnArpC7ZZF1VgMnycfHTudx3pkNKapmIayJzEI2mMpMyP4jTGXBRgYwrLdy7m0ybVNg
 =
X-Gm-Gg: ASbGncu6CYLjF7Mm1sZlHmhCcZN3/fNp9UBUvBjTppbjLEsyNg/HiKxNbwJDx0fP+ov
 TC9AN3I+1/LlFF71GQmhFKuWK7ozbfzTFm76LfHuk5HGl7eJMN28G/E3kXT0R5XtNd2gDZKy3cC
 iThdxryrth7mpGYPWcKIoFU5uLmRVpn4zdbHxofoe9cMieLYNUq6PAjuYeX4Q6npHwkDck7GKy+
 ixtqb7PxJmjeYoa95raszVpfwXoX6zN1QaqmDhZ7TLs
X-Google-Smtp-Source: AGHT+IFScHKkSbJEhXlqUkB5NuVnUuhzz18wsnsHSW6EPc88MpDGczwxq97DrQzR6S+G9HuNBUe9cw==
X-Received: by 2002:a05:6602:6b0d:b0:83a:b79c:66b6 with SMTP id
 ca18e2360f4ac-843ecf9f73emr2110136239f.2.1733064184108; 
 Sun, 01 Dec 2024 06:43:04 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8755sm160826839f.17.2024.12.01.06.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 06:43:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marex@denx.de>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
Subject: [PATCH 5/8] fdt: Allow the devicetree to come from a bloblist
Date: Sun,  1 Dec 2024 07:42:33 -0700
Message-ID: <20241201144240.1664398-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201144240.1664398-1-sjg@chromium.org>
References: <20241201144240.1664398-1-sjg@chromium.org>
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

Standard passage provides for a bloblist to be passed from one firmware
phase to the next. That can be used to pass the devicetree along as well.
Add an option to support this.

Tests for this will be added as part of the Universal Payload work.

Note: This is the correct way to deal with bloblist, since it allows
boards to choose whether they want to use the devicetree from there, or
not.

Link: https://patchwork.ozlabs.org/project/uboot/patch/20231226094625.221671-1-sjg@chromium.org/
Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228133654.2356023-1-sjg@chromium.org/
Link: https://patchwork.ozlabs.org/project/uboot/patch/20231228194725.2482268-1-sjg@chromium.org/
Link: https://patchwork.ozlabs.org/project/uboot/patch/20240104014919.413568-1-sjg@chromium.org/
Link: https://patchwork.ozlabs.org/project/uboot/patch/20230921015730.1511373-31-sjg@chromium.org/
Link: https://patchwork.ozlabs.org/project/uboot/patch/20230830180524.315916-31-sjg@chromium.org/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/bloblist.c                  |  1 +
 doc/develop/devicetree/control.rst |  3 ++
 dts/Kconfig                        |  8 ++++++
 include/fdtdec.h                   |  3 +-
 lib/fdtdec.c                       | 44 ++++++++++++++++++++++--------
 5 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index ec6ff7a5a93..e8acfc74331 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -56,6 +56,7 @@ static struct tag_name {
 	{ BLOBLISTT_INTEL_VBT, "Intel Video-BIOS table" },
 	{ BLOBLISTT_SMBIOS_TABLES, "SMBIOS tables for x86" },
 	{ BLOBLISTT_VBOOT_CTX, "Chrome OS vboot context" },
+	{ BLOBLISTT_CONTROL_FDT, "Control FDT" },
 
 	/* BLOBLISTT_PROJECT_AREA */
 	{ BLOBLISTT_U_BOOT_SPL_HANDOFF, "SPL hand-off" },
diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 2a3b48fa6c7..4180eeb5629 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -137,6 +137,9 @@ If `OF_BOARD` is selected by Kconfig, a board-specific routine will provide the
 devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
+If CONFIG_OF_BLOBLIST is defined, the devicetree comes from a bloblist passed
+from a previous stage.
+
 If CONFIG_SANDBOX is defined, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
 default and -T for the test devicetree, used to run sandbox unit tests.
diff --git a/dts/Kconfig b/dts/Kconfig
index ffd50c04846..41a758e83a6 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -167,6 +167,14 @@ config OF_INITIAL_DTB_READONLY
 	  If initial DTB for DT control is read-only (e.g. points to
 	  memory-mapped flash memory), then set this option.
 
+config OF_BLOBLIST
+	bool "DTB is provided by a bloblist"
+	help
+	  Select this to read the devicetree from the bloblist. This allows
+	  using a bloblist to transfer the devicetree between  U-Boot phases.
+	  The devicetree is stored in the bloblist by an early phase so that
+	  U-Boot can read it.
+
 config OF_BOARD
 	bool "Provided by the board (e.g a previous loader) at runtime"
 	default y if SANDBOX || OF_HAS_PRIOR_STAGE
diff --git a/include/fdtdec.h b/include/fdtdec.h
index 8f25e1b7e92..aa7e4b62dbf 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -72,7 +72,7 @@ struct bd_info;
  *	U-Boot is packaged as an ELF file, e.g. for debugging purposes
  * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. This should
  *	be used for debugging/development only
- * @FDTSRC_NONE: No devicetree at all
+ * @FDTSRC_BLOBLIST: Provided by a bloblist from an earlier phase
  */
 enum fdt_source_t {
 	FDTSRC_SEPARATE,
@@ -80,6 +80,7 @@ enum fdt_source_t {
 	FDTSRC_BOARD,
 	FDTSRC_EMBED,
 	FDTSRC_ENV,
+	FDTSRC_BLOBLIST,
 };
 
 /*
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index d36b01bd3f1..9d3afb79d87 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -7,6 +7,10 @@
  */
 
 #ifndef USE_HOSTCC
+
+#define LOG_CATEGORY	LOGC_DT
+
+#include <bloblist.h>
 #include <boot_fit.h>
 #include <display_options.h>
 #include <dm.h>
@@ -86,6 +90,7 @@ static const char *const fdt_src_name[] = {
 	[FDTSRC_BOARD] = "board",
 	[FDTSRC_EMBED] = "embed",
 	[FDTSRC_ENV] = "env",
+	[FDTSRC_BLOBLIST] = "bloblist",
 };
 
 const char *fdtdec_get_srcname(void)
@@ -1664,20 +1669,35 @@ int fdtdec_setup(void)
 	int ret;
 
 	/* The devicetree is typically appended to U-Boot */
-	if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
-		gd->fdt_blob = fdt_find_separate();
-		gd->fdt_src = FDTSRC_SEPARATE;
-	} else { /* embed dtb in ELF file for testing / development */
-		gd->fdt_blob = dtb_dt_embedded();
-		gd->fdt_src = FDTSRC_EMBED;
-	}
-
-	/* Allow the board to override the fdt address. */
-	if (IS_ENABLED(CONFIG_OF_BOARD)) {
-		gd->fdt_blob = board_fdt_blob_setup(&ret);
+	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
+		ret = bloblist_maybe_init();
 		if (ret)
 			return ret;
-		gd->fdt_src = FDTSRC_BOARD;
+		gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+		if (!gd->fdt_blob) {
+			printf("Not FDT found in bloblist\n");
+			bloblist_show_list();
+			return -ENOENT;
+		}
+		gd->fdt_src = FDTSRC_BLOBLIST;
+		bloblist_show_list();
+		log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
+	} else {
+		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
+			gd->fdt_blob = fdt_find_separate();
+			gd->fdt_src = FDTSRC_SEPARATE;
+		} else { /* embed dtb in ELF file for testing / development */
+			gd->fdt_blob = dtb_dt_embedded();
+			gd->fdt_src = FDTSRC_EMBED;
+		}
+
+		/* Allow the board to override the fdt address. */
+		if (IS_ENABLED(CONFIG_OF_BOARD)) {
+			gd->fdt_blob = board_fdt_blob_setup(&ret);
+			if (ret)
+				return ret;
+			gd->fdt_src = FDTSRC_BOARD;
+		}
 	}
 
 	/* Allow the early environment to override the fdt address */
-- 
2.43.0

