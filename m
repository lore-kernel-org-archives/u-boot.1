Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E726D1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 145ED88DFB;
	Mon,  4 Nov 2024 18:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ehbl2zQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EAC288E1C; Mon,  4 Nov 2024 18:51:23 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F428880B
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83ac05206f6so171458539f.2
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742679; x=1731347479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZi1iH5xTnU6wsXBL2jxaYVAIGlwutaFkGYvoL31L6E=;
 b=ehbl2zQmeq0+NJ5aa+aMPUQodCg8/BuAKQPdA3HM215zJH9waTsYME6BD0SB8PXxGT
 U2z28GV9MPtBbpKdAhH/IP15nAWz+nsFVXohwCRjxpUydGyN8BjYBauvzBEhVQPQt4sB
 n5NAh3luC0QBfTISJyFO8KvMOAsPPSse301wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742679; x=1731347479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZi1iH5xTnU6wsXBL2jxaYVAIGlwutaFkGYvoL31L6E=;
 b=nY3s1quX6lPTsosTO3qbw1FpU3/ufs50Eve6rEAuy1M/tg9kO7SFzaWAv8AAHIoxzY
 Ot90P6U9JcAhncBTgCESySr45bJWWjIP0+jnYyTQMd2XzYZylcJCcXEybGgKBwgGbdcR
 m5FdSo8oMS69TRZxUYZ8bopJSlAifF/Qzvo+oVaK+m+jq0INdwtE0hdP+Dgone5Z/6hf
 cYjrXXo3iSIPMta+8VO2x/M8IT36CiVY0BvNOKIhxVIlN6OjDq0NYWkj/+R3eeAW34o4
 hk+t1byXVvDAa94p3NzoH+9RdqQ1yOMAXe0n0J+/QpQVVaKwpF8ogEi07WsiCJdVHhBL
 fJAw==
X-Gm-Message-State: AOJu0Yy78do2kCJQIhIOTm6FH132XTLHcsJYaFvR63lAH0rQdGD8a+hB
 Q0knNiNmuAcmDx7zpEU3pxxqDxcZZ0UBVf+zyqFj2HkObBjWYWN9PB88NHXMbKm7r55wfgNTAZA
 =
X-Google-Smtp-Source: AGHT+IFq+QJIesTrXBv7jaHCFFvG55+d0eusKpkXSy+7DBpxCbOz4mk8N3ZgPsxH503bFkOEYCsZ8w==
X-Received: by 2002:a05:6602:641c:b0:837:7f8e:dfe2 with SMTP id
 ca18e2360f4ac-83b64f38eeamr1732407339f.2.1730742679466; 
 Mon, 04 Nov 2024 09:51:19 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:18 -0800 (PST)
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
Subject: [PATCH v3 02/19] bootstd: Move bootflow-clearing to bootstd
Date: Mon,  4 Nov 2024 10:50:53 -0700
Message-Id: <20241104175110.1048449-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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

