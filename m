Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30838D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908DF8920A;
	Fri, 18 Oct 2024 01:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nj6dLEAC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C05E891E2; Fri, 18 Oct 2024 01:24:50 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CAEF89208
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-83a9cd37a11so67028739f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207486; x=1729812286; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3xIPbguRRxf317ABAtRRJDd36IWVkZfLN2KDNVFHC4=;
 b=nj6dLEACbCgQKrKfzkyX1aD3DD6NN/F6HcjQrcgyjoOu/nyMsRl+xjAK0zLIEYJ0RA
 ms9ytspryl661nI+t87MgUyjRlda+PadTPfMV9lirP5kM7CwDRCCtXemUwX8BGN2p8mR
 jgVC6MMaA+psDcTG12hiCXvYx8/4a+eDAIdkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207486; x=1729812286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v3xIPbguRRxf317ABAtRRJDd36IWVkZfLN2KDNVFHC4=;
 b=SPBoLV6WXQJHzpezXBtxZAAOWmIhJAYqAi003UBcfc4CLSqMs0FdT30K5xfY41l9kb
 KKbC/KlMmzvIMPM6elz7Jq4lX1o5YvZDfOxZce3GGy7ZmIaJ/CYNXHW1f9CYgSbPC2kr
 zy/PnCyBpkdvSPJp8mb+RrYU11F5c+LCZgfa8Ee+s3fEx9Jwdh7HK8tvXvequ2yFfUnR
 CBtt9M6e2gW79Y/XFB/uc2UQJy6595WhCYDdvbzcSqAmzZdhxdD/+s3JpnFv1bo8ujXC
 v5Hu1NKCwk9Q4Y/g7sEbBq1dPMZvLa6DjoYs1//nX/X65AoekiBgAlbwZEwPiDlLR+G0
 aZWQ==
X-Gm-Message-State: AOJu0Yxm8Sxc0KBd/4MnVecMor76HrAPvatlwvS/HyJI2eyE+VhSIx7E
 wXrBUInPb1kkDm7nMCiNkeOBlOdiNjjqJr1Tdxg38Hjhw8FRzRP1OJFO3J3k53EI48O60vM6368
 =
X-Google-Smtp-Source: AGHT+IHdYDf1mQd+XS8dwTSUxDE/hevtrUK8xUifRH7W45Mm0dxdIsbu5ma/MrrwJ5NqsHmJ3cJRUg==
X-Received: by 2002:a05:6e02:148a:b0:3a3:4122:b56e with SMTP id
 e9e14a558f8ab-3a3f40c03ddmr3565885ab.26.1729207485832; 
 Thu, 17 Oct 2024 16:24:45 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 08/34] dm: core: Add a function to see if a device exists
Date: Thu, 17 Oct 2024 17:23:47 -0600
Message-Id: <20241017232413.724808-9-sjg@chromium.org>
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

All the uclass functions for finding a device end up creating a uclass
if it doesn't exist. Add a function which instead returns NULL in this
case.

This is useful when in the 'unbind' path, since we don't want to undo
any unbinding which has already happened.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

