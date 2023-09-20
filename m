Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12472CE79CE
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 13:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E7E4869F1;
	Wed, 20 Sep 2023 15:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XW2FiaE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E91869F5; Wed, 20 Sep 2023 15:31:08 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF90886413
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 15:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-792979d4cb5so261843539f.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695216661; x=1695821461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XsKVTQqecwa3woqrC8LX2WCPBm1rNe3O+cNr+xH7Iq8=;
 b=XW2FiaE8ip9S0qz0QniXgjia1p6DOdHBkvM7Nbro0n/HTKunFTn+UJ9iepYv4cuIrw
 TDC/zWc3TKqsDV+BRjeMaEWEqzVFlhRpe0k2zBwhjSrV2L/RZDJlvPPTQ39iTQ+5LbzR
 XTI2jqq9CeQ5hZKfebU7Px+yP289DWy2CLOFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695216661; x=1695821461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XsKVTQqecwa3woqrC8LX2WCPBm1rNe3O+cNr+xH7Iq8=;
 b=oE68jaI4xqYu9V6lfD4RPYDLi5ZJTnyLCnHlWQzIPawROY/VLz8bxrJRNULmvbvryt
 /RshodCe0mAfzsxfjGmrBuJxFnpSL0nTXFwPD9brvEd+ZrCEWaLHrJuIWk/v+m7iQNEz
 DqemZHqKjUP90aN0acbiFRLYaKszlR4xITBaI6fep5PBhmz1YXIbhd5Mmf6u7TvcmNv3
 pjgZQ4OFtrVUsDKFKMIv5qP9LjpSHsWT4lyFZbMVXWtRo6r8T6IUguwWqOTbw88r+Sbl
 uUif4uTXzrfXvfJTM8PdwT+ICdm2pK+5PlxEla85oRNnt1lXUfdWrABvZq5Uc8IVf3sa
 NPTA==
X-Gm-Message-State: AOJu0YzZ41eBm0eHJd60w5zuRjqWJFntbNRc+cbqjLDswXBqV8twJNrM
 dE49vX3xJWihoJN6U4UW5apyaU30iWsNuG2oI7s=
X-Google-Smtp-Source: AGHT+IGMnvzZWtfBZeReaMdAD/mecI8x44WjkgFjS7m2hgxskv+TLfKY4AcTUDJvcEv0owndHLH1Tw==
X-Received: by 2002:a6b:5c06:0:b0:783:63d6:4c5 with SMTP id
 z6-20020a6b5c06000000b0078363d604c5mr3097226ioh.12.1695216661427; 
 Wed, 20 Sep 2023 06:31:01 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 q9-20020a0566380ec900b0042b3f0c94d9sm4218066jas.107.2023.09.20.06.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 06:31:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 13/20] bootstd: Keep track of use of usb stop
Date: Wed, 20 Sep 2023 07:29:49 -0600
Message-ID: <20230920133003.1413865-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
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

When 'usb stop' is run, doing 'bootflow scan' does not run the USB hunter
again so does not see any devices. Fix this by telling bootstd about the
state of USB.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v6:
- Ensure that bootstd functions are not called in SPL

 boot/bootdev-uclass.c         | 27 +++++++++++++++++++++++++++
 drivers/usb/host/usb-uclass.c |  8 ++++++++
 include/bootdev.h             |  9 +++++++++
 3 files changed, 44 insertions(+)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 69506e3865fc..974ddee5d2fa 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -830,6 +830,33 @@ int bootdev_hunt(const char *spec, bool show)
 	return result;
 }
 
+int bootdev_unhunt(enum uclass_id id)
+{
+	struct bootdev_hunter *start;
+	int n_ent, i;
+
+	start = ll_entry_start(struct bootdev_hunter, bootdev_hunter);
+	n_ent = ll_entry_count(struct bootdev_hunter, bootdev_hunter);
+	for (i = 0; i < n_ent; i++) {
+		struct bootdev_hunter *info = start + i;
+
+		if (info->uclass == id) {
+			struct bootstd_priv *std;
+			int ret;
+
+			ret = bootstd_get_priv(&std);
+			if (ret)
+				return log_msg_ret("std", ret);
+			if (!(std->hunters_used & BIT(i)))
+				return -EALREADY;
+			std->hunters_used &= ~BIT(i);
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 int bootdev_hunt_prio(enum bootdev_prio_t prio, bool show)
 {
 	struct bootdev_hunter *start;
diff --git a/drivers/usb/host/usb-uclass.c b/drivers/usb/host/usb-uclass.c
index e5fe949f254c..a1cd0ad2d669 100644
--- a/drivers/usb/host/usb-uclass.c
+++ b/drivers/usb/host/usb-uclass.c
@@ -9,6 +9,7 @@
 #define LOG_CATEGORY UCLASS_USB
 
 #include <common.h>
+#include <bootdev.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
@@ -208,6 +209,13 @@ int usb_stop(void)
 #ifdef CONFIG_USB_STORAGE
 	usb_stor_reset();
 #endif
+	if (CONFIG_IS_ENABLED(BOOTSTD)) {
+		int ret;
+
+		ret = bootdev_unhunt(UCLASS_USB);
+		if (IS_ENABLED(CONFIG_BOOTSTD_FULL) && ret && ret != -EALREADY)
+			printf("failed to unhunt USB (err=%dE)\n", ret);
+	}
 	uc_priv->companion_device_count = 0;
 	usb_started = 0;
 
diff --git a/include/bootdev.h b/include/bootdev.h
index 848233187f87..b079a91b5b7f 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -320,6 +320,15 @@ int bootdev_hunt(const char *spec, bool show);
  */
 int bootdev_hunt_prio(enum bootdev_prio_t prio, bool show);
 
+/**
+ * bootdev_unhunt() - Mark a device as needing to be hunted again
+ *
+ * @id: uclass ID to update
+ * Return: 0 if done, -EALREADY if already in this state, -ENOENT if no hunter
+ * found for that uclass
+ */
+int bootdev_unhunt(enum uclass_id id);
+
 /**
  * bootdev_hunt_and_find_by_label() - Hunt for bootdevs by label
  *
-- 
2.42.0.459.ge4e396fd5e-goog

