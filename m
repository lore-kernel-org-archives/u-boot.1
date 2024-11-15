Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D11D68BDA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C08C9896F1;
	Sat, 16 Nov 2024 00:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ltz1zVi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A858896F1; Sat, 16 Nov 2024 00:19:45 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E88CE891AD
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-83a9ca86049so75420639f.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712780; x=1732317580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPHiJYN04nZ7+/eY24bzDrae23nMc+JW5izOYtWqU8U=;
 b=ltz1zVi+SeWKrf2i38MubPSkNTN0nQHBKPytuEs1y8fUPC+4Z1QbkR53b78MCSKcAk
 3qX5pCOrtNVTe/njWELRtCsqGJG35yD8KSPRm2PywaKzfvuIZQNczT4hXKaxboN7P4zX
 mfdpkYQXknUz8IFxyUM4DJmwjuxlf2CGyBXA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712780; x=1732317580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPHiJYN04nZ7+/eY24bzDrae23nMc+JW5izOYtWqU8U=;
 b=sC7wNlGFVhS1SAklji74kMCVZpn/xEqkZB6ivxPT+l/nQZ9SE0bc3Xuk824oDUAyAq
 RBe62pJEIdqMc2EF5A4mtK90owNZkqRsHicjtTNnlNZ/peW953qTL9qqA++Z2dBXj9Ln
 Bj0zlM3ABWpmbVe9xMaVGtHe4/Zs8A4hp/nIg4awB+dJQ6uv7oG1Nrv9NCqJQsy7LXXK
 6JhEPGgcIEliTNbVBwc51yAvhtYD1asc8ADQwCUTxTEw2a09vagP4LyPgyrL4k14IufO
 MxNb5YTQoR8VMPg8UsORCthIE3KIHa3bme4KodOsSl8vhJpv9raPjNlbDV/aRTkJCCtg
 sGcw==
X-Gm-Message-State: AOJu0YwCqf2Mhb2EzgHfLaeE2BP1IYzMoj9qlTo1tZ1PyFalQ4oMAZiy
 zdtxGmi3MgDEkmciz0oJ4Lcpmink2RltBpwKmnXYDVo+UnwJ+zfHK9XaXuciPS0u60HomxaaCl4
 =
X-Google-Smtp-Source: AGHT+IGyJjkuLEY5YU8Du5QK6fAATvpra5lZJgk0E0ocDNFHBJnVTlx6TVoaeY/59qbRMg2ZFWkaAw==
X-Received: by 2002:a05:6602:140f:b0:83a:b43b:da89 with SMTP id
 ca18e2360f4ac-83e6c319858mr493196439f.10.1731712780574; 
 Fri, 15 Nov 2024 15:19:40 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:19:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [PATCH v4 02/19] bootstd: Move bootflow-clearing to bootstd
Date: Fri, 15 Nov 2024 16:19:09 -0700
Message-Id: <20241115231926.211999-3-sjg@chromium.org>
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

This relates to more than just the bootdev, since there is a global list
of bootflows. Move the function to the bootstd file and rename it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 boot/bootdev-uclass.c | 19 +++++--------------
 boot/bootstd-uclass.c | 15 +++++++++++++++
 cmd/bootflow.c        |  2 +-
 include/bootdev.h     | 10 ----------
 include/bootstd.h     | 10 ++++++++++
 5 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index eddbf60600c..26b003427ec 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -557,19 +557,6 @@ int bootdev_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
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
@@ -935,7 +922,11 @@ static int bootdev_post_bind(struct udevice *dev)
 
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
index 8962464bbf8..1c1146ce11e 100644
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

