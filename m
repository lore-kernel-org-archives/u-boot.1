Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE666D3C916
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE72E892A0;
	Sat, 19 Oct 2024 17:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aPeA4nJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C0B38857C; Sat, 19 Oct 2024 17:22:45 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2382588F57
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a3b1aa0e80so12648395ab.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351361; x=1729956161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nJXutPa2eRaNvet/qsvgYxGC+KRiWBcRBxUjMJUZso=;
 b=aPeA4nJ0WsZaBXUI3JXTfiYF9Go7iX0wTkLppBRCJCRlFyaz+Kedfv6FitGeQq9ugd
 u40sxq/IjQHARM4iCrQnCUSJgRfTnKcbzAPEu4Nf83xLDQACEzXVvVEA0uPiqHLfOTEU
 nTg2qpUpNAHeKDkMrpzpzs/qrmnCDA5Hhp8LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351361; x=1729956161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nJXutPa2eRaNvet/qsvgYxGC+KRiWBcRBxUjMJUZso=;
 b=pmqpLCVFeLBUzmwW8X9OpJR3vZE1mn0Vtag+Mf+JSOhbqR42qhXMAxz9ky1nwmJTJh
 CiQp0/nPZgEIMuT0c4QUp28EjgmkyLYEaeKo5xzKsmFOu9RtjCBEe2qE0YsutlVRDIU8
 ebUfgp1M5mZsnZSJpxA77YVnZGG7z45iKk6Ak3mEsiXdxcKXJQhCcw/J91YJFMxPkJWk
 +Cn7qoHNk9yULcy5vb/0vwuROTXJa9xmLwa3hlzhlhLocCNPaewcmOvNez/8hhfhJvQN
 WCuMq8Iy1NEzntBv8ru3ZF6kuUIb6HRNHw3tdkXNGvwIqTqeq8mkejgmfo6rVNdnOauS
 jvUg==
X-Gm-Message-State: AOJu0YwwSTtiqGh9ZXGIJKaxO43KN7kXk5FZJjP8sseZG3v7wUJR5GD8
 yxLdIehUpZVJ3rQjkru5ZIhny+eWKDGgJd97PPjVhVg1cA4QHRLkAmcXfxn4gyp0Rp+/Ljts330
 =
X-Google-Smtp-Source: AGHT+IEUt9sG+Bixoen1L9t9Jtc7DDt4JY5jBQhZeOCG7fQcWPbCYM5UqHvDZxr1329Sl9O7SmHHXQ==
X-Received: by 2002:a92:c54f:0:b0:3a3:4391:24e9 with SMTP id
 e9e14a558f8ab-3a3f409e805mr59054265ab.20.1729351361466; 
 Sat, 19 Oct 2024 08:22:41 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:41 -0700 (PDT)
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
Subject: [PATCH v2 11/31] bootstd: Move bootflow-adding to bootstd
Date: Sat, 19 Oct 2024 09:21:51 -0600
Message-Id: <20241019152211.1014896-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

 boot/bootdev-uclass.c | 25 -------------------------
 boot/bootstd-uclass.c | 25 +++++++++++++++++++++++++
 cmd/bootflow.c        |  2 +-
 include/bootdev.h     | 15 ---------------
 include/bootstd.h     | 17 +++++++++++++++++
 5 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 64ec4fde493..eddbf60600c 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -32,31 +32,6 @@ enum {
 	BOOT_TARGETS_MAX_LEN	= 100,
 };
 
-int bootdev_add_bootflow(struct bootflow *bflow)
-{
-	struct bootstd_priv *std;
-	struct bootflow *new;
-	int ret;
-
-	ret = bootstd_get_priv(&std);
-	if (ret)
-		return ret;
-
-	new = malloc(sizeof(*bflow));
-	if (!new)
-		return log_msg_ret("bflow", -ENOMEM);
-	memcpy(new, bflow, sizeof(*bflow));
-
-	list_add_tail(&new->glob_node, &std->glob_head);
-	if (bflow->dev) {
-		struct bootdev_uc_plat *ucp = dev_get_uclass_plat(bflow->dev);
-
-		list_add_tail(&new->bm_node, &ucp->bootflow_head);
-	}
-
-	return 0;
-}
-
 int bootdev_first_bootflow(struct udevice *dev, struct bootflow **bflowp)
 {
 	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index fdb8d69e320..bf6e49ad97a 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -61,6 +61,31 @@ void bootstd_clear_glob(void)
 	bootstd_clear_glob_(std);
 }
 
+int bootstd_add_bootflow(struct bootflow *bflow)
+{
+	struct bootstd_priv *std;
+	struct bootflow *new;
+	int ret;
+
+	ret = bootstd_get_priv(&std);
+	if (ret)
+		return ret;
+
+	new = malloc(sizeof(*bflow));
+	if (!new)
+		return log_msg_ret("bflow", -ENOMEM);
+	memcpy(new, bflow, sizeof(*bflow));
+
+	list_add_tail(&new->glob_node, &std->glob_head);
+	if (bflow->dev) {
+		struct bootdev_uc_plat *ucp = dev_get_uclass_plat(bflow->dev);
+
+		list_add_tail(&new->bm_node, &ucp->bootflow_head);
+	}
+
+	return 0;
+}
+
 static int bootstd_remove(struct udevice *dev)
 {
 	struct bootstd_priv *priv = dev_get_priv(dev);
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 1588f277a4a..ff06ac3eb9f 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -207,7 +207,7 @@ static int do_bootflow_scan(struct cmd_tbl *cmdtp, int flag, int argc,
 		bflow.err = ret;
 		if (!ret)
 			num_valid++;
-		ret = bootdev_add_bootflow(&bflow);
+		ret = bootstd_add_bootflow(&bflow);
 		if (ret) {
 			printf("Out of memory\n");
 			return CMD_RET_FAILURE;
diff --git a/include/bootdev.h b/include/bootdev.h
index ad4af0d1310..8db198dd56b 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -195,21 +195,6 @@ void bootdev_list(bool probe);
  */
 void bootdev_clear_bootflows(struct udevice *dev);
 
-/**
- * bootdev_add_bootflow() - Add a bootflow to the bootdev's list
- *
- * All fields in @bflow must be set up. Note that @bflow->dev is used to add the
- * bootflow to that device.
- *
- * @dev: Bootdev device to add to
- * @bflow: Bootflow to add. Note that fields within bflow must be allocated
- *	since this function takes over ownership of these. This functions makes
- *	a copy of @bflow itself (without allocating its fields again), so the
- *	caller must dispose of the memory used by the @bflow pointer itself
- * Return: 0 if OK, -ENOMEM if out of memory
- */
-int bootdev_add_bootflow(struct bootflow *bflow);
-
 /**
  * bootdev_first_bootflow() - Get the first bootflow from a bootdev
  *
diff --git a/include/bootstd.h b/include/bootstd.h
index ac756e98d84..3fc93a4ec2e 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -105,4 +105,21 @@ void bootstd_clear_glob(void);
  */
 int bootstd_prog_boot(void);
 
+/**
+ * bootstd_add_bootflow() - Add a bootflow to the bootdev's and global list
+ *
+ * All fields in @bflow must be set up. Note that @bflow->dev is used to add the
+ * bootflow to that device.
+ *
+ * The bootflow is also added to the global list of all bootflows
+ *
+ * @dev: Bootdev device to add to
+ * @bflow: Bootflow to add. Note that fields within bflow must be allocated
+ *	since this function takes over ownership of these. This functions makes
+ *	a copy of @bflow itself (without allocating its fields again), so the
+ *	caller must dispose of the memory used by the @bflow pointer itself
+ * Return: 0 if OK, -ENOMEM if out of memory
+ */
+int bootstd_add_bootflow(struct bootflow *bflow);
+
 #endif
-- 
2.34.1

