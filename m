Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6F5CE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D374186C9B;
	Wed, 20 Sep 2023 05:00:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fq8RUzgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E6886BFF; Wed, 20 Sep 2023 05:00:46 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B5D86C6B
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34fdbda09bbso10357225ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178843; x=1695783643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pUM+QcA7uQKhfeT+gP55x83zFJyYFQndO1iFOOHWYk=;
 b=Fq8RUzgqsTCy6T4a4EI/Pxqt3J16nlbdw8pOKBVuNTd4bjigTg1X1AMc/63gpTlYdW
 dyzaB91rmw3T5yvnpInNRbSkSgf+FtIs46H+Aoic1S53nRxfPFFicEmyX3k1JKLVx1EG
 Aum5YSFYtd2Flei/buiFbPE9zZQAaQFKkJpow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178843; x=1695783643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pUM+QcA7uQKhfeT+gP55x83zFJyYFQndO1iFOOHWYk=;
 b=XQNJBdSCThHewVvA9kIUDQU13wAa/Apr2qJ7H2DBPbCT0tbkV68dR8/LKxwJsNV6cS
 0qOa+2bKARgyfGVNepnTT6DNyUvVf9wUOvoV+bhhRUiGl1LICvk0SI4PfPWnuvsjgW1A
 I8EPS8nLMJzQjOvAbsXLbL3yEyUQiRvsnv23ind0hlad6YvXMTGgwECq7rfS8XK2aTxV
 TWYYj23mcQu83jo8z6Vn+GNh7CF8a2nhKN/b6QT73PnOzscHzrx8/FaYh1HjVIpR58FV
 SNNVw8D6BBihYYhhTvG0uUBZmFm+QuLHmPQN0VRwthjr8LoYTTFpqQwlLli8JCSfNB7m
 yDfA==
X-Gm-Message-State: AOJu0Yw8/Nz4+qVKEg33Tt8KHXXoDus3crYBNEQDcjG/Iou8L3xY2vtn
 DYTpFgB95cyMoOdZAaI59YX291G8FHtz/0dZ/RU=
X-Google-Smtp-Source: AGHT+IHt7ht0ZODUYoG4Ik3+LKHqGOzN3wpoFnOJnGrb/e2/ukCC2s6UkiHxUEDRaN5KpAopE2CwEA==
X-Received: by 2002:a05:6e02:1d83:b0:349:3020:d103 with SMTP id
 h3-20020a056e021d8300b003493020d103mr1863911ila.25.1695178843007; 
 Tue, 19 Sep 2023 20:00:43 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 13/20] bootstd: Keep track of use of usb stop
Date: Tue, 19 Sep 2023 21:00:14 -0600
Message-ID: <20230920030027.1385833-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

(no changes since v1)

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
index e5fe949f254c..27e172a4fe5b 100644
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
+	if (IS_ENABLED(CONFIG_BOOTSTD)) {
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

