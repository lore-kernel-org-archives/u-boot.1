Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B7DC04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 583F5869D6;
	Tue, 15 Aug 2023 00:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iLU3/mEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A68869C6; Tue, 15 Aug 2023 00:41:24 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABAE6869A0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34978cc9e53so18852475ab.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052881; x=1692657681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=feogD3tuT56eRGeYdhjMi3/TfBGWJSofulZpgKs1MJQ=;
 b=iLU3/mEQWf07aeyu8d2JxDqwq5fUzrcGFV2evThFMZJN/7v8r4pih1cY5hq2RZkLRn
 uOrIlXT9BoG1WvtABi6csTxNOWYZz138l8JnlijpGIZP6LXYMkjaWa08fob/PAqSM2pS
 NVdFcaEPSYB4dKCPKFSrHvCHhQFTgJkl6TZwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052881; x=1692657681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feogD3tuT56eRGeYdhjMi3/TfBGWJSofulZpgKs1MJQ=;
 b=caX6R/9Lz3JZR6j2e9GUo1FexN6xlk88m9eid8Yq8m21THkQ3WlPMN6qfHom967LxH
 ti6de2X4NcONn5Zf61hUhvq0GZS5hkAwTLS1AC4se47i01LtJENL4+LYmZ8ce7iNw6La
 ydfpr/36HABxdGZp1pYfo+7Q68V7AKWWn+blkbvDC29wFw5QY3ZbekohDVxh65F8Nx2e
 WL1LgfB5mytOhl7Uhzso/sbE6YVT9P2yR+OdKuIuE2PrVJlv1bkQ0TkcmjkAxZIFiGQw
 JAdaTmMowP2GeJDjkJMugryPc//ouFp4RAeSd/YNgcMtibIk2Za0Ghn7WrMomG2jfuy7
 Gj+w==
X-Gm-Message-State: AOJu0Yz4x1kDLf0754HoxmuDX7AxH0R+pci8c+8GyPticv4Mdh9CePoT
 38LSJAA7q956ER+CEWsk2cnhLQFIHjTYBIM5/v0=
X-Google-Smtp-Source: AGHT+IGaXWHONdUsek8p3uII9fCZobGG1wCdnvzA90EAyenxLKBhX8kPCVOTRdEyqPqgLZLm4NvJvQ==
X-Received: by 2002:a05:6e02:170a:b0:348:c293:9d9f with SMTP id
 u10-20020a056e02170a00b00348c2939d9fmr17334264ill.27.1692052881376; 
 Mon, 14 Aug 2023 15:41:21 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 07/19] expo: Add a function to prepare a cedit
Date: Mon, 14 Aug 2023 16:40:27 -0600
Message-ID: <20230814224047.535491-8-sjg@chromium.org>
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

Split out the code which prepares the cedit for use, so we can call it
from a test.

Add a log category while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c    | 32 ++++++++++++++++++++++++++------
 include/cedit.h | 15 +++++++++++++++
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 2d16086bad63..6c10b2114541 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -6,6 +6,8 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#define LOG_CATEGORY LOGC_EXPO
+
 #include <common.h>
 #include <cedit.h>
 #include <cli.h>
@@ -47,18 +49,15 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 	return 0;
 }
 
-int cedit_run(struct expo *exp)
+int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
+		  struct scene **scnp)
 {
-	struct cli_ch_state s_cch, *cch = &s_cch;
 	struct video_priv *vid_priv;
-	uint scene_id;
 	struct udevice *dev;
 	struct scene *scn;
-	bool done;
+	uint scene_id;
 	int ret;
 
-	cli_ch_init(cch);
-
 	/* For now we only support a video console */
 	ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
 	if (ret)
@@ -93,6 +92,27 @@ int cedit_run(struct expo *exp)
 	if (ret)
 		return log_msg_ret("dim", ret);
 
+	*vid_privp = vid_priv;
+	*scnp = scn;
+
+	return scene_id;
+}
+
+int cedit_run(struct expo *exp)
+{
+	struct cli_ch_state s_cch, *cch = &s_cch;
+	struct video_priv *vid_priv;
+	uint scene_id;
+	struct scene *scn;
+	bool done;
+	int ret;
+
+	cli_ch_init(cch);
+	ret = cedit_prepare(exp, &vid_priv, &scn);
+	if (ret < 0)
+		return log_msg_ret("prep", ret);
+	scene_id = ret;
+
 	done = false;
 	do {
 		struct expo_action act;
diff --git a/include/cedit.h b/include/cedit.h
index 21de12dfe7a9..851d8e83564a 100644
--- a/include/cedit.h
+++ b/include/cedit.h
@@ -8,6 +8,7 @@
 #define __CEDIT_H
 
 struct expo;
+struct scene;
 struct video_priv;
 
 /**
@@ -30,4 +31,18 @@ int cedit_arange(struct expo *exp, struct video_priv *vid_priv, uint scene_id);
  */
 int cedit_run(struct expo *exp);
 
+/**
+ * cedit_prepare() - Prepare to run a cedit
+ *
+ * Set up the video device, select the first scene and highlight the first item.
+ * This ensures that all menus have a selected item.
+ *
+ * @exp: Expo to use
+ * @vid_privp: Set to private data for the video device
+ * @scnp: Set to the first scene
+ * Return: scene ID of first scene if OK, -ve on error
+ */
+int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
+		  struct scene **scnp);
+
 #endif /* __CEDIT_H */
-- 
2.41.0.694.ge786442a9b-goog

