Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F30C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:13:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47B9286528;
	Wed, 23 Aug 2023 23:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BakjYbYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4CE864CD; Wed, 23 Aug 2023 23:11:23 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C20E986445
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34bbc5eb310so18043795ab.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825078; x=1693429878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnNwJyasKavJ2S9TxaGysxyYYTKE7vnPGvVw5bNIS2A=;
 b=BakjYbYVSRjzJdOiMdNvnnG/L0cmYZOvd90DvqbbgHr8wvScoeKmfL2XsyWlStzeT4
 uXoxdI0okXBAF7+EetocEwgtTQh2PbRepnVpVyAwAyqkFrzhArvNZ5dxyh+EfB/LBVAa
 HOmyXw+NNGzvXWxOA56UgSimjogZWqJ5YA3TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825078; x=1693429878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XnNwJyasKavJ2S9TxaGysxyYYTKE7vnPGvVw5bNIS2A=;
 b=Zk3c7lmcAzHdTNzhQrSZ/hidBXoaaB/9b1pmB9XJviT38yqKrn3hEPnObryLZ+h4Cl
 x42kfb92QQPeQ04BaMk8k0k+U5baqeKGFO3LssNQ6LBkXEyyrdsg0LKyt4plC8SAU7YO
 OJ3wnytBr9emKadRVe8NI98v2pzHxf+7Rnl7vTK4q16W8C4Dx1om+lHuwZQeLKJXqok5
 osnQeyOLEMAj6V0RqS2fJoI8iKpmIQPr0Ve2E7aCf5k5Qh0eEcK6cUb/7M3ePcAzRzj+
 G4bHJrKP1XjPsijozqOE3PXw46X0HPtvOYX/9DfNPGvJJGnLPec0buZdpxHLtPOKOp/e
 rGeg==
X-Gm-Message-State: AOJu0Yx2fGVqkEG6LDeZdGWfqX4yuNNmVEJRtgok5aOkAFHU41Cj71Tf
 2+vyDp8RTDfnIZtRmElGAOG7KjaKwfuESwMKLPc=
X-Google-Smtp-Source: AGHT+IEoXrla7BVzqynKRK+RqQ3VnREx48ehnF37q9o37FA8mU5e0xgO2GMyCO96yoVhiCaChW6qdQ==
X-Received: by 2002:a05:6e02:20c3:b0:347:6b30:5bd3 with SMTP id
 3-20020a056e0220c300b003476b305bd3mr4320117ilq.13.1692825078408; 
 Wed, 23 Aug 2023 14:11:18 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 13/20] bootstd: Keep track of use of usb stop
Date: Wed, 23 Aug 2023 15:10:30 -0600
Message-ID: <20230823211059.1235147-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
index fa52bc3a9c4..f91495b0682 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -820,6 +820,33 @@ int bootdev_hunt(const char *spec, bool show)
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
index 7a03435ba77..9dee7b98078 100644
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
index 848233187f8..b079a91b5b7 100644
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
2.42.0.rc1.204.g551eb34607-goog

