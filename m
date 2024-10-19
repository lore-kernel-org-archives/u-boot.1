Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA01D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C437D892E1;
	Sat, 19 Oct 2024 17:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RTM9Xta/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8185C892DE; Sat, 19 Oct 2024 17:22:44 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A7EF88F92
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-82cd93a6617so112193339f.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351359; x=1729956159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nECejbz2qEVzzWpzWg56yMAw6vHXZOPe3fJmg9pZ3ew=;
 b=RTM9Xta/Vc7TC21cUY6gLvFzWb7guhpPHn7bLND9APRd6b1oUe5i7ap93sePN7rZJJ
 nkrp/1uGSHxOI2WGqSdYyeejqDJDkw2kfIDZA82c16nHLLwQjDjNvjmhv011R8JVJfee
 uQCJs7W1q50sK6ZTGCv3cqu691qrvGVUXr2SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351359; x=1729956159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nECejbz2qEVzzWpzWg56yMAw6vHXZOPe3fJmg9pZ3ew=;
 b=NVH4DfexUyJkRQ845v6OxZCQRFazZonS3AXQoZZNVcTWfa90Nmt2WpN+/qqF/ZDR6V
 79x7Oc7HHF1sRJuH75IFiGzqX9Q+VT7GR9QXKAe6I8ZJwB5QZOZbjeeyCF8QRDxJWE5t
 iAf7Rw9jhTaTLo7tIADUWlFsdyGXEkyMp2hCgf83CmgmahrUmXbrKL+Z9gvWq/qPu8J/
 82tz290jxyM/E+dgR8CsMvuY0L41eZ0pn1I+2MzcIUPh6zwDE1gt8UkasmhIftSNlQRR
 3Kf701yLO+gfJAi0JAUW/oBLDGHa1KWWj9l9DMTQPMWjh/EdcGdHjx4f0yvT3Kvh4gBn
 ziZw==
X-Gm-Message-State: AOJu0YylXIJBTjTXjHENpqhLpwDRHzbFGPLC0++UeBk2iTX16zbhVuFn
 jiWDr0w9/1RpCXXf3B8JtZ2v9Mn0Re0gxp2DsrYKueC7I++jM7D1Mum/OJ64nNIqWV/iel3POFM
 =
X-Google-Smtp-Source: AGHT+IH3ApDxjq7/xgOfi03WU0WeWP9bohmJWHwQyPMDYdh2TMZ9j/76FWDCmupb4Y7YYsgBtohqAA==
X-Received: by 2002:a05:6e02:174c:b0:3a3:b209:650d with SMTP id
 e9e14a558f8ab-3a3f40cbd4dmr53385565ab.26.1729351358961; 
 Sat, 19 Oct 2024 08:22:38 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 09/31] dm: core: Add a function to see if a device exists
Date: Sat, 19 Oct 2024 09:21:49 -0600
Message-Id: <20241019152211.1014896-10-sjg@chromium.org>
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

All the uclass functions for finding a device end up creating a uclass
if it doesn't exist. Add a function which instead returns NULL in this
case.

This is useful when in the 'unbind' path, since we don't want to undo
any unbinding which has already happened.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/uclass.c | 11 +++++++++++
 include/dm/uclass.h   | 11 +++++++++++
 test/dm/core.c        | 22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index 7ae0884a75e..f846a35d6b2 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -304,6 +304,17 @@ int uclass_find_device_by_name(enum uclass_id id, const char *name,
 	return uclass_find_device_by_namelen(id, name, strlen(name), devp);
 }
 
+struct udevice *uclass_try_first_device(enum uclass_id id)
+{
+	struct uclass *uc;
+
+	uc = uclass_find(id);
+	if (!uc || list_empty(&uc->dev_head))
+		return NULL;
+
+	return list_first_entry(&uc->dev_head, struct udevice, uclass_node);
+}
+
 int uclass_find_next_free_seq(struct uclass *uc)
 {
 	struct udevice *dev;
diff --git a/include/dm/uclass.h b/include/dm/uclass.h
index 456eef7f2f3..c2793040923 100644
--- a/include/dm/uclass.h
+++ b/include/dm/uclass.h
@@ -435,6 +435,17 @@ int uclass_next_device_check(struct udevice **devp);
 int uclass_first_device_drvdata(enum uclass_id id, ulong driver_data,
 				struct udevice **devp);
 
+/**
+ * uclass_try_first_device()- See if there is a device for a uclass
+ *
+ * If the uclass exists, this returns the first device on that uclass, without
+ * probing it. If the uclass does not exist, it gives up
+ *
+ * @id: Uclass ID to check
+ * Return: Pointer to device, if found, else NULL
+ */
+struct udevice *uclass_try_first_device(enum uclass_id id);
+
 /**
  * uclass_probe_all() - Probe all devices based on an uclass ID
  *
diff --git a/test/dm/core.c b/test/dm/core.c
index e0c5b9e0017..7371d3ff426 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -1351,3 +1351,25 @@ static int dm_test_dev_get_mem(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_dev_get_mem, UTF_SCAN_FDT);
+
+/* Test uclass_try_first_device() */
+static int dm_test_try_first_device(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	/* Check that it doesn't create a device or uclass */
+	ut_assertnull(uclass_find(UCLASS_TEST));
+	ut_assertnull(uclass_try_first_device(UCLASS_TEST));
+	ut_assertnull(uclass_try_first_device(UCLASS_TEST));
+	ut_assertnull(uclass_find(UCLASS_TEST));
+
+	/* Create a test device */
+	ut_assertok(device_bind_by_name(uts->root, false, &driver_info_manual,
+					&dev));
+	dev = uclass_try_first_device(UCLASS_TEST);
+	ut_assertnonnull(dev);
+	ut_asserteq(UCLASS_TEST, device_get_uclass_id(dev));
+
+	return 0;
+}
+DM_TEST(dm_test_try_first_device, 0);
-- 
2.34.1

