Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB87C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B99869C9;
	Tue, 15 Aug 2023 00:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OBFlcpEj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869CA869B5; Tue, 15 Aug 2023 00:41:23 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AC3869A2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-791071b9a5eso170994539f.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052880; x=1692657680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SKUH/a3daQsjrMHvTQr7rtWpKHXuRKpksdijDTCa30Q=;
 b=OBFlcpEjAgZo+MzHQG3xiAXWZGtEhIUwb8o0iCCX5yKNljxdInxtZriX0UyKhh9zc0
 QEPPl190HRCx66GE87dPk9rgHVvcRxR8BBScydwY+mYTEKlHaBD08sG3sS7sAbX1Ws+h
 zxSXDEx/5hCAmK73k4dCNWtPpVyCH1yh+jbG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052880; x=1692657680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKUH/a3daQsjrMHvTQr7rtWpKHXuRKpksdijDTCa30Q=;
 b=RG4qFJwoKrrtrvvz3rcA4eJ/XkfRE3zkJIe+o3zcipbX6MCo2otnRTRcDSWbDcIe0c
 Vg8Vs5Jc8LnVh7VatIHq1hQGVZFXjDelNMdlVRXbOy444CjE7zBNNyK1WHIJG+gFxleI
 k2LzOqltknn6SFUQrcYDLP0BS5rWPOIABrpJFqTGkKKn/Pd3C10dge2/MGt09Xb7u6RP
 k+slvFKDlHFXTCkpftYib7JIZmNa/IiXIbsaPHWqC/8WfKbsWD4IrOL1kiO31jBri0+l
 Z7S7mltaoNss/uLfR0NfvFGm2aKl061RGBGulOWMJu/oVlbNOH4wkZffNxFlml8UvHvy
 ak5w==
X-Gm-Message-State: AOJu0Ywe1Hm3cUj0e3tRBy85VFOG/Fr2MGYZ4Gl/TItoLLqxAe4EyMpV
 nKmFkIYLIGSEDBQWVJnl/9EmJd6YIEpGveJGIx0=
X-Google-Smtp-Source: AGHT+IGhsipAiu8WHKGc//QkrqCVEgWUR0OFlbAZuOoDkPmyCWMN+wzEauHjrH5kFhzMyncAZkz2Vw==
X-Received: by 2002:a05:6e02:1d02:b0:349:4598:b99a with SMTP id
 i2-20020a056e021d0200b003494598b99amr16978261ila.13.1692052879936; 
 Mon, 14 Aug 2023 15:41:19 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 05/19] expo: Split out cedit into its own header
Date: Mon, 14 Aug 2023 16:40:25 -0600
Message-ID: <20230814224047.535491-6-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

Before adding more functions to this interface, create a new header for
the configuration editor.

Fix up the expo header guard while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c    |  1 +
 cmd/cedit.c     |  1 +
 include/cedit.h | 33 +++++++++++++++++++++++++++++++++
 include/expo.h  | 27 +++------------------------
 4 files changed, 38 insertions(+), 24 deletions(-)
 create mode 100644 include/cedit.h

diff --git a/boot/cedit.c b/boot/cedit.c
index ee24658917bc..2d16086bad63 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cedit.h>
 #include <cli.h>
 #include <dm.h>
 #include <expo.h>
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 0cae304c4adc..5f0e84403f5b 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <cedit.h>
 #include <command.h>
 #include <expo.h>
 #include <fs.h>
diff --git a/include/cedit.h b/include/cedit.h
new file mode 100644
index 000000000000..21de12dfe7a9
--- /dev/null
+++ b/include/cedit.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __CEDIT_H
+#define __CEDIT_H
+
+struct expo;
+struct video_priv;
+
+/**
+ * cedit_arange() - Arrange objects in a configuration-editor scene
+ *
+ * @exp: Expo to update
+ * @vid_priv: Private info of the video device
+ * @scene_id: scene ID to arrange
+ * Returns: 0 if OK, -ve on error
+ */
+int cedit_arange(struct expo *exp, struct video_priv *vid_priv, uint scene_id);
+
+/**
+ * cedit_run() - Run a configuration editor
+ *
+ * This accepts input until the user quits with Escape
+ *
+ * @exp: Expo to use
+ * Returns: 0 if OK, -ve on error
+ */
+int cedit_run(struct expo *exp);
+
+#endif /* __CEDIT_H */
diff --git a/include/expo.h b/include/expo.h
index 0b1d944a169f..da151074d207 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -4,14 +4,13 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#ifndef __SCENE_H
-#define __SCENE_H
+#ifndef __EXPO_H
+#define __EXPO_H
 
 #include <dm/ofnode_decl.h>
 #include <linux/list.h>
 
 struct udevice;
-struct video_priv;
 
 /**
  * enum expoact_type - types of actions reported by the expo
@@ -676,24 +675,4 @@ int expo_apply_theme(struct expo *exp, ofnode node);
  */
 int expo_build(ofnode root, struct expo **expp);
 
-/**
- * cedit_arange() - Arrange objects in a configuration-editor scene
- *
- * @exp: Expo to update
- * @vid_priv: Private info of the video device
- * @scene_id: scene ID to arrange
- * Returns: 0 if OK, -ve on error
- */
-int cedit_arange(struct expo *exp, struct video_priv *vid_priv, uint scene_id);
-
-/**
- * cedit_run() - Run a configuration editor
- *
- * This accepts input until the user quits with Escape
- *
- * @exp: Expo to use
- * Returns: 0 if OK, -ve on error
- */
-int cedit_run(struct expo *exp);
-
-#endif /*__SCENE_H */
+#endif /*__EXPO_H */
-- 
2.41.0.694.ge786442a9b-goog

