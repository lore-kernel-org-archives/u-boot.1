Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D4FCCD184
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 06:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59903838CC;
	Sun, 12 Oct 2025 08:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gRijmZLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563998388C; Sun, 12 Oct 2025 08:44:33 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0116083885
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 08:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-92aee734485so125624439f.1
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 23:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760251469; x=1760856269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbbKXnJ0YeslhxCu4lFurvTn7WlsIuXpiRKWpSQqx+o=;
 b=gRijmZLKwFzkOOXPqMnUzeXNi93aGp7LWhw7EV41NIbkNrxH2x2ybVD5Z9tI69aP17
 pD2wrvdAPafsZnq+z+q/ZLR3bPOu9OgsyuwOqUY0gKlvG+LDlZW+jtt5Q8Uwv8tk1448
 +YQaFR6BqbB5Wn6aOX2/PA1E9YEepPgUHUcNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760251469; x=1760856269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbbKXnJ0YeslhxCu4lFurvTn7WlsIuXpiRKWpSQqx+o=;
 b=sR/KGaxf3QgyadBTaASGH8u3HUtUUEsuutDyRmttgtu6gm8fHyL3RGB3R1aqhxSNbW
 9ho6QcBytJB+NevjPhbYI+NVeOBRAclTqPkbla8DlawGmjZeSSwSQif9GlWy3H9kMk+7
 gzhSoKSw/ndLxECH+tMdtL+7NBi5ibKV8AkO2mqTKLntGMbZ3nfYWdwdH3PMYksn+fjD
 RRSoUnOrFUsCRAlfDAjKDu14tn5G5u6EczrB4Y6oH5Zv53W/KhYAamF7sXSnM20a742R
 eEqAJo4UlbLeKstokLsfivLHdRmK8TfW4/I3ldWz3nEvMCWDlvO/fmaWPLUTPnZLrt1K
 wHOA==
X-Gm-Message-State: AOJu0Yxsa2Yho3EJZ8MzqYlLZRwZb+q9/JiAC8ACcJQ+VkWEu6BEgicL
 o364X46vMF168H0P/5lkIC4OBvWWZIMRsSu46EfL5bpaoztfFb0n8Xsc20jbOfKkyoqvvY6zDtW
 BllFfitCVLJE=
X-Gm-Gg: ASbGncts7Th5zzH8WkUCjM2ADJykiBoRrKVXfaxZVREzjMSyAdaaGCVwABk0O7EDJgf
 GA+QfOL5hvXB7SVcIsdxkZpETJ381/006x5kSNvX9HInGNXkFPkgXBSCAejyNfReJz6HkDv0Gu6
 SMXYekMmiFUGJ8WxdKNhHGUI7fWUuOwA1sREsUvLcWgTNx2xkj5KCTyqjkzOYkHi5xA/LgaZs2U
 aQWlDuCviVf0y60LEBA/qx2tPWngwvBtdbvv7bPw4BjrgJIu5ToewpbxewmuhWxZmYEySyYkL90
 z9zdYahHe6szjPMhK0F/hoqWQFBY52uKiuV2jeAX/VZ9wri0Nbi3gJ41hWcEKBJotIjp2+IXXJZ
 P6XY0xsiNlCK9erTcEU0SNjAWKokXJsqx3i6LGOOICcKxwg==
X-Google-Smtp-Source: AGHT+IGctu4q2uIypTqxmGVGguYEDczXbimoogp4RldOyTShvkWfkt7aEXea1CR0Wm6ocoYqNAKuig==
X-Received: by 2002:a05:6e02:12c1:b0:430:8bff:c5a1 with SMTP id
 e9e14a558f8ab-4308bffc74dmr24708255ab.4.1760251469146; 
 Sat, 11 Oct 2025 23:44:29 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42f90343080sm38109625ab.22.2025.10.11.23.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 23:44:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v5 2/4] boot: Move obtaining the label into a common file
Date: Sun, 12 Oct 2025 00:43:54 -0600
Message-ID: <20251012064412.2892979-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012064412.2892979-1-sjg@chromium.org>
References: <20251012064412.2892979-1-sjg@chromium.org>
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

This updates the output from 'bootflow list'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Move 'usb' rename into a separate patch

 boot/bootflow.c    | 16 ++++++++++++++++
 cmd/bootflow.c     |  8 +++++---
 include/bootflow.h |  8 ++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 15df7069209..6485d473d69 100644
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
@@ -1010,3 +1011,18 @@ int bootflow_get_seq(const struct bootflow *bflow)
 
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
+		name = dev_get_uclass_name(media);
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
-- 
2.43.0

