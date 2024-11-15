Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5B8D68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FBE9896F8;
	Sat, 16 Nov 2024 00:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gbRQJio2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7CA0891C4; Sat, 16 Nov 2024 00:19:47 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C633D891A5
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83a9cd37a11so81818839f.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712784; x=1732317584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wm4E9xlZw9x6n5A9J58U+VgJ1bv+Wqol7oUbwpKYvJg=;
 b=gbRQJio2KhM/V05Vv60sx0Upz7vu55j4NGXGE2oYfbTZhCOQicByY3e3CcJwmQHJwE
 w+rPtBUidyC8JJPnkczXLMzjPCAlbA17meWprhtXqay1kiKVtrgc3bE0xvIMhCbHETH0
 /ruhic0h+BggFkmO6LPlzJdQhFIi69kBVdxig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712784; x=1732317584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wm4E9xlZw9x6n5A9J58U+VgJ1bv+Wqol7oUbwpKYvJg=;
 b=ccIcZ9+glW7YfWJrXNWTe90s8Rjvsm/xMVAlRxCgUVuvsJsATxtlDz0w5XVtslJIRX
 jiABri3/CAQOd6CXFrqj7TPXtV+es4S466MhkG5hJdwUTd4aLwTf1druIhOLIfCjrveU
 6UQJaiQ1mFq5qfWwf1Pk3KsGSuudkPRh3WJxp0zSK367hYDOF3VY/esLoR+lvpOlcGID
 EgnF8iwGrri6aiKTBqcbawjN+GImPsHjvq9mmRSZf6F84zfaod9DsNsCKhWj7A6bS4aA
 Nnl3jOg7PN4vs3M0F9GLpN5HWchDcPQoWZ6jNr/LX9MYdirn3Hk2IECBICJwnGMKanlw
 FdDQ==
X-Gm-Message-State: AOJu0Yycx832t2sI9GHO9TB95J6fR81qCCE4YTgoUZlcbtRzPTQS7XNT
 9HeGu6BrgmN0Luv9zIvVLeJeuBynBzDG01CnwQyMz9McGBCwvOnJpucBU5lFldVYElw/hns2yQg
 =
X-Google-Smtp-Source: AGHT+IE3VFjaflDjhZjWOrqGlLWisM8jdVGVxjY1EA5rJfKSfBsDFcUHaghR5W0JRMAbNiW0Tqz5tQ==
X-Received: by 2002:a05:6602:140f:b0:835:4402:e2eb with SMTP id
 ca18e2360f4ac-83e6c2b276bmr559643839f.7.1731712783733; 
 Fri, 15 Nov 2024 15:19:43 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:19:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v4 03/19] bootstd: Add a function to get bootstd only if
 available
Date: Fri, 15 Nov 2024 16:19:10 -0700
Message-Id: <20241115231926.211999-4-sjg@chromium.org>
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

Provide a function which is safe to call in the 'unbind' path, which
returns the bootstd priv data if available.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootstd-uclass.c | 11 +++++++++++
 include/bootstd.h     | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
index 596d3e5e41d..b2f80808c85 100644
--- a/boot/bootstd-uclass.c
+++ b/boot/bootstd-uclass.c
@@ -140,6 +140,17 @@ const char *const *const bootstd_get_prefixes(struct udevice *dev)
 	return std->prefixes ? std->prefixes : default_prefixes;
 }
 
+struct bootstd_priv *bootstd_try_priv(void)
+{
+	struct udevice *dev;
+
+	dev = uclass_try_first_device(UCLASS_BOOTSTD);
+	if (!dev || !device_active(dev))
+		return NULL;
+
+	return dev_get_priv(dev);
+}
+
 int bootstd_get_priv(struct bootstd_priv **stdp)
 {
 	struct udevice *dev;
diff --git a/include/bootstd.h b/include/bootstd.h
index 4220ece785d..4535d91e2ad 100644
--- a/include/bootstd.h
+++ b/include/bootstd.h
@@ -89,6 +89,23 @@ const char *const *const bootstd_get_prefixes(struct udevice *dev);
  */
 int bootstd_get_priv(struct bootstd_priv **stdp);
 
+/**
+ * bootstd_try_priv() - Try to get the (single) state for the bootstd system
+ *
+ * The state holds a global list of all bootflows that have been found. This
+ * function returns the state if available, but takes care not to create the
+ * device (or uclass) if it doesn't exist.
+ *
+ * This function is safe to use in the 'unbind' path. It will always return NULL
+ * unless the bootstd device is probed and ready, e.g. bootstd_get_priv() has
+ * previously been called.
+ *
+ * TODO(sjg@chromium.org): Consider adding a bootstd pointer to global_data
+ *
+ * Return: pointer if the device exists, else NULL
+ */
+struct bootstd_priv *bootstd_try_priv(void);
+
 /**
  * bootstd_clear_glob() - Clear the global list of bootflows
  *
-- 
2.34.1

