Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134B4D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 670748920C;
	Fri, 18 Oct 2024 01:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jkFGEVuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45FE089218; Fri, 18 Oct 2024 01:24:53 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16596890C2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-83a9ca86049so62066339f.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207490; x=1729812290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qeUz/ZTvvZYxyRsdra7bS4JnuP1zDRDxPGZ1bwPDABQ=;
 b=jkFGEVuDW8loGmF0hzCdX7k1ZteA45DiaxYdvkITAmYb2RbyqbYbHHmxxsymWV9DeT
 tPc664g48t6F8pK/IAPOUA1XnQoAajRsNB4CQOzS3XGbnj2mbaD3s/laUnio+KsNUgEF
 nksGRORCOu0TGjaMnW8LrW/unjfeNcSAC7Yyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207490; x=1729812290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qeUz/ZTvvZYxyRsdra7bS4JnuP1zDRDxPGZ1bwPDABQ=;
 b=D7P2vXtjZ9GU31QCD/cUiQwEBXLQLZnS7GIXBdlny3w4Nl3ZiWVzw3u2/rosBAwrDP
 SBXHTRd/psatgpIipLWP8ZWywGEb+KwduZhnJx+NkzlXMV3/wldqwGYFPpsVRfPeSEpp
 gSVigeOV+QLo4NkVhRn54xw6ZIKBcw4sBoOuyuZF11RRANk77q1Az9aPk5jz3eSC5fwN
 b8WvyRDyESBclsZHKTy27nzdTQ2ZfBIavz+I0PRQu1KVGIDspUzw7bQFxknzVcYx0ng9
 JiOCKhqJ7RnoJzv1cFQt4DFfPa6cFGFFTQrfsmhvFdq16ydrUOO4RKRzFWFko5WaI3bY
 Ho2w==
X-Gm-Message-State: AOJu0Yw2sBUHfSRDOs2CD4NtxgfygqAmmJjimIwlAaMjYEBQGwMI3Gnn
 ZXfsszTFL0i5PPYIdN+uXgRuwH7J/0P+w7Wa0lAy6nj68y6XgGQhIbiU/VsuTh2qTTDgx9F8Dc8
 =
X-Google-Smtp-Source: AGHT+IESlFC9a88EirbdLPYAAxSzx0aoRmIoJdTiq9xwQjCPoG3Yhw1fb+DLXWEVtLS0Ue3yjSnzFw==
X-Received: by 2002:a92:cda4:0:b0:3a3:b4ec:b3f1 with SMTP id
 e9e14a558f8ab-3a3f40ab54cmr3834185ab.17.1729207489753; 
 Thu, 17 Oct 2024 16:24:49 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 11/34] bootstd: Move bootflow-clearing to bootstd
Date: Thu, 17 Oct 2024 17:23:50 -0600
Message-Id: <20241017232413.724808-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

This relates to more than just the bootdev, since there is a global list
of bootflows. Move the function to the bootstd file and rename it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootdev-uclass.c | 19 +++++--------------
 boot/bootstd-uclass.c | 15 +++++++++++++++
 cmd/bootflow.c        |  2 +-
 include/bootdev.h     | 10 ----------
 include/bootstd.h     | 10 ++++++++++
 5 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index f40bf0a6979..e9dda65417d 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -554,19 +554,6 @@ int bootdev_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
 	return ops->get_bootflow(dev, iter, bflow);
 }
 
-void bootdev_clear_bootflows(struct udevice *dev)
-{
-	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
-
-	while (!list_empty(&ucp->bootflow_head)) {
-		struct bootflow *bflow;
-
-		bflow = list_first_entry(&ucp->bootflow_head, struct bootflow,
-					 bm_node);
-		bootflow_remove(bflow);
-	}
-}
-
 int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
 		       int *method_flagsp)
 {
@@ -932,7 +919,11 @@ static int bootdev_post_bind(struct udevice *dev)
 
 static int bootdev_pre_unbind(struct udevice *dev)
 {
-	bootdev_clear_bootflows(dev);
+	int ret;
+
+	ret = bootstd_clear_bootflows_for_bootdev(dev);
+	if (ret)
+		return log_msg_ret("bun", ret);
 
 	return 0;
 }
diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index bf6e49ad97a..596d3e5e41d 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -86,6 +86,21 @@ int bootstd_add_bootflow(struct bootflow *bflow)
 	return 0;
 }
 
+int bootstd_clear_bootflows_for_bootdev(struct udevice *dev)
+{
+	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+
+	while (!list_empty(&ucp->bootflow_head)) {
+		struct bootflow *bflow;
+
+		bflow = list_first_entry(&ucp->bootflow_head, struct bootflow,
+					 bm_node);
+		bootflow_remove(bflow);
+	}
+
+	return 0;
+}
+
 static int bootstd_remove(struct udevice *dev)
 {
 	struct bootstd_priv *priv = dev_get_priv(dev);
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index ff06ac3eb9f..5f656814b29 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -197,7 +197,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 		show_header();
 	}
 	if (dev)
-		bootdev_clear_bootflows(dev);
+		bootstd_clear_bootflows_for_bootdev(dev);
 	else
 		bootstd_clear_glob();
 	for (i = 0,
diff --git a/include/bootdev.h b/include/bootdev.h
index 8db198dd56b..f9cae2fd1fd 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -185,16 +185,6 @@ int bootdev_find_in_blk(struct udevice *dev, struct udevice *blk,
  */
 void bootdev_list(bool probe);
 
-/**
- * bootdev_clear_bootflows() - Clear bootflows from a bootdev
- *
- * Each bootdev maintains a list of discovered bootflows. This provides a
- * way to clear it. These bootflows are removed from the global list too.
- *
- * @dev: bootdev device to update
- */
-void bootdev_clear_bootflows(struct udevice *dev);
-
 /**
  * bootdev_first_bootflow() - Get the first bootflow from a bootdev
  *
diff --git a/include/bootstd.h b/include/bootstd.h
index 3fc93a4ec2e..4220ece785d 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -122,4 +122,14 @@ int bootstd_prog_boot(void);
  */
 int bootstd_add_bootflow(struct bootflow *bflow);
 
+/**
+ * bootstd_clear_bootflows_for_bootdev() - Clear bootflows from a bootdev
+ *
+ * Each bootdev maintains a list of discovered bootflows. This provides a
+ * way to clear it. These bootflows are removed from the global list too.
+ *
+ * @dev: bootdev device to update
+ */
+int bootstd_clear_bootflows_for_bootdev(struct udevice *dev);
+
 #endif
-- 
2.34.1

