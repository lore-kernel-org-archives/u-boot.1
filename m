Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A847CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:29:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E5A834D4;
	Wed,  1 Oct 2025 23:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AIyUTbXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55712834D4; Wed,  1 Oct 2025 23:29:41 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2872A835A2
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-93607aec358so10112339f.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354177; x=1759958977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zi9H8Re+RmRsIlis1sw6tn9ctOV4Ao2j3W4JHGgVn70=;
 b=AIyUTbXIkAZQc+e6I22yRGe/fg2bnbpzXAVOkNLDsf2oUUTdAlX0ynEW8/hYbs71q2
 T+fcqrpfjV4U13h0cLBDp4+C7Li/GkYlNlyfMUFvg16qDaZ6AJsp+YdqBPmrGyXuvFzL
 2NNtHgmVpNRNyKYyNFyd0trXP2Cv6lIX3vdRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354177; x=1759958977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zi9H8Re+RmRsIlis1sw6tn9ctOV4Ao2j3W4JHGgVn70=;
 b=qjUVpvXt8nVsClmjb6snYmk8MRp0yT2Q/XcPJrMImKjJ2pMHW0qgapHkmiYUrJFUTw
 SHUcT3nkzndG/lW/TpAcQENYtu8/1cB+wt1pbDLz+vSv6twmKTLBRrd70ovN2RGfEeys
 Jcqm92C4C2CxLTnJCKoLXOTIFCOxyf5KLUdkXIR+e24gd7oUkEF3vsFXNXJBzaRNM0cq
 SYlsNDdHv/CZOTEM+qIK554fySjYW0iyLkux8uLariTa0/VMAbfDJ76FCmHdr+7GG4QM
 JWlEpdY73G1pd7XE4vl5DPW2K+Rhe9nF0fBizBJAnANxtRcE3lezhNaQxhgGiQm7SwOe
 3z7Q==
X-Gm-Message-State: AOJu0YyOlWSBBE44PaOIY4jwRtBK49uXGS43PTeNGawFq4BSjl1NvqAP
 iiPtwP5tsIymNdO2ZHcDlBjxVUvd/C7xYpHXFbhVirEKItO/zJZIZ6Go+AN9TbbEOA2Uf7MC6cQ
 BIpkc/v6Q
X-Gm-Gg: ASbGncvOwgfk9XZwiLbZ54NNuyDomXr18VMFV//3S9JGhXZ8KWYHFuCDt9XCON0bNCG
 KEh9w0V+U4BF3IuhBB2WxWgnBSCanaGndG1oiey2pZQD/4vJMHJrBRSzGatBIE+JxUzADmxVxkH
 nf4ywhjlmgjse3bwNro9QTa48yGpqHEUHwj3QI/T50G3HxQbw3uFuDMC/+df/DBDBS6u973KTs4
 DPEuBbiUfT8R2JocF982DKm0SjoWSpByfIsR/PaA2cRQXzGAshRCD1BAK5ZGy3rNrdLsJXHpCCq
 FWNXU9m6NXcsc6Ur22pZdjCpJNBjcfjEbZxAp7m9tQvbteWBh5F1+OXsfXQ6atSOGDx4Inx6Spv
 TiJzgH9MjxqjrRFdbL+GBopSjEWEDe02p6jP2amZe
X-Google-Smtp-Source: AGHT+IFqGxVKF/gNiOZ8xNxNgc1k7NGB5zmeSgA+tV4ORbHJBeLVgVg9txotB0b8HRf9dQCGZ5LO6w==
X-Received: by 2002:a05:6602:150c:b0:928:c6cc:3b1a with SMTP id
 ca18e2360f4ac-937afb06607mr719943039f.18.1759354177266; 
 Wed, 01 Oct 2025 14:29:37 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/17] boot: Move obtaining the label into a common file
Date: Wed,  1 Oct 2025 15:26:28 -0600
Message-ID: <20251001212649.3263574-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

The 'bootflow list' command supports looking at the EFI device-path when
available. Move this piece into a common function so it can be used
elsewhere.

Use 'usb' instead of 'usb_mass_storage' for usb so that it fits in the
column space.

This updates the output from 'bootflow list'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c      | 19 +++++++++++++++++++
 cmd/bootflow.c       |  8 +++++---
 include/bootflow.h   |  8 ++++++++
 test/boot/bootflow.c |  2 +-
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 2ec05fe5432..5af3f6b3163 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -11,6 +11,7 @@
 #include <bootmeth.h>
 #include <bootstd.h>
 #include <dm.h>
+#include <efi_device_path.h>
 #include <env_internal.h>
 #include <malloc.h>
 #include <serial.h>
@@ -1008,3 +1009,21 @@ int bootflow_get_seq(const struct bootflow *bflow)
 
 	return alist_calc_index(&std->bootflows, bflow);
 }
+
+const char *bootflow_guess_label(const struct bootflow *bflow)
+{
+	const char *name = NULL;
+
+	if (bflow->dev) {
+		struct udevice *media = dev_get_parent(bflow->dev);
+
+		if (device_get_uclass_id(media) == UCLASS_MASS_STORAGE)
+			name = "usb";
+		else
+			name = dev_get_uclass_name(media);
+	}
+	if (!name)
+		name = "(none)";
+
+	return name;
+}
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 551dffbb8b8..5b803d4ace5 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -70,10 +70,12 @@ static void report_bootflow_err(struct bootflow *bflow, int err)
  */
 static void show_bootflow(int index, struct bootflow *bflow, bool errors)
 {
+	const char *name = bootflow_guess_label(bflow);
+
 	printf("%3x  %-11s  %-6s  %-9.9s %4x  %-25.25s %s\n", index,
-	       bflow->method->name, bootflow_state_get_name(bflow->state),
-	       bflow->dev ? dev_get_uclass_name(dev_get_parent(bflow->dev)) :
-	       "(none)", bflow->part, bflow->name, bflow->fname ?: "");
+	       bflow->method ? bflow->method->name : "(none)",
+	       bootflow_state_get_name(bflow->state), name, bflow->part,
+	       bflow->name, bflow->fname ?: "");
 	if (errors)
 		report_bootflow_err(bflow, bflow->err);
 }
diff --git a/include/bootflow.h b/include/bootflow.h
index 2ef6eb25cf5..657e3731f11 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -692,4 +692,12 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
  */
 int bootflow_menu_poll(struct expo *exp, int *seqp);
 
+/**
+ * bootflow_guess_label() - Produce a plausible label for a bootflow
+ *
+ * This uses the uclass name or EFI device-path to come up with a useful label
+ * for display to the user. Ideally it will say "mmc", "usb", nvme", etc.
+ */
+const char *bootflow_guess_label(const struct bootflow *bflow);
+
 #endif
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 7cd83dc7443..73fe3d34d0f 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1301,7 +1301,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 	ut_assert_nextlinen("---");
 	ut_assert_nextlinen("  0  extlinux");
 	ut_assert_nextlinen(
-		"  1  efi          ready   usb_mass_    1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
+		"  1  efi          ready   usb          1  usb_mass_storage.lun0.boo /EFI/BOOT/BOOTSBOX.EFI");
 	ut_assert_nextlinen("---");
 	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
 	ut_assert_console_end();
-- 
2.43.0

