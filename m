Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB78E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2AA87206;
	Mon,  2 Oct 2023 03:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mrJtz8Vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E566870CE; Mon,  2 Oct 2023 03:16:08 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C72C4870FF
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3513c435465so5905935ab.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209302; x=1696814102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xARQXtNl+ZxCU2B/wlVvLjFxxUEHK3o3B+sJN0Cxz8s=;
 b=mrJtz8VtAA9es38rUBvu6QvjU6Nq8TDpp8sehvMqJfoCC9QypdammtTSP1njkPenQJ
 cbOot0Rg82GOzbVzIFqRmbgswQnF75AJf8PBmKzN+sNyg+QeOSdoJOxOBFjU+a75KXKr
 FkTcC1q8j2XuABZt6OvEs7jBXBa65URIEEwR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209302; x=1696814102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xARQXtNl+ZxCU2B/wlVvLjFxxUEHK3o3B+sJN0Cxz8s=;
 b=bF+Fe9xEIzBQBVtpRl5ah3Eea5SPhYMFrbDtS3PoAnWY+DUXEWDO2wcvpn2vmsz49p
 kPdRwAYLU5XdNHBk3Ivlwbm8emMqE4lkxWjeY/SB/nNriS9dQl7GIOskqNmyTi8Wy0Pd
 JPeJngJeo0oMUkyPSfjxdRJJLm7FNXqq7MhbdsX1yFV3zHs+0N0FXzTmK4s6uEKYwfKF
 0aCfOdTAUmcjgvOTSWMaY7VMxhISHuf0tRPYiEphRGdCanGe+xFY1K7ZcrCtJTaUuNTx
 aT88fp0DxI3MQx88tiGCrKVBLyqRCNvKnpLHKzG2WGtMCOFWwS2+9xSpkT2ZCNjnHqnr
 gy9g==
X-Gm-Message-State: AOJu0Yxg95mZOj8o29OotCe48r5k0YqBFkSuYUx9kcI24T49upOOtUu5
 8O4X4TOZ/FxhboGk5x0hCjugxHaZ+lczd8r6+TU=
X-Google-Smtp-Source: AGHT+IEcqVv0ewoXkWIy2hDF5+59i/CIOgE0fRasfxiNQ1d3u9joEgeKW/SfGN4xZtQ+RvSsdQ6lmg==
X-Received: by 2002:a92:c246:0:b0:34f:dfb5:8e8 with SMTP id
 k6-20020a92c246000000b0034fdfb508e8mr9006150ilo.14.1696209301952; 
 Sun, 01 Oct 2023 18:15:01 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:15:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 08/12] video: Drop unnecessary truetype operations from SPL
Date: Sun,  1 Oct 2023 19:14:43 -0600
Message-ID: <20231002011450.462468-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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

Saving and restoring entries is used for expo and for the command line,
which we don't use in SPL. Drop these methods.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to drop unnecessary truetype operations from SPL

 drivers/video/console_truetype.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 14fb81e9563c..602133575f8c 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
+#include <spl.h>
 #include <video.h>
 #include <video_console.h>
 
@@ -799,6 +800,9 @@ static int truetype_entry_save(struct udevice *dev, struct abuf *buf)
 	struct console_tt_store store;
 	const uint size = sizeof(store);
 
+	if (spl_phase() <= PHASE_SPL)
+		return -ENOSYS;
+
 	/*
 	 * store the whole priv structure as it is simpler that picking out
 	 * what we need
@@ -820,6 +824,9 @@ static int truetype_entry_restore(struct udevice *dev, struct abuf *buf)
 	struct console_tt_priv *priv = dev_get_priv(dev);
 	struct console_tt_store store;
 
+	if (spl_phase() <= PHASE_SPL)
+		return -ENOSYS;
+
 	memcpy(&store, abuf_data(buf), sizeof(store));
 
 	vc_priv->xcur_frac = store.cur.xpos_frac;
@@ -844,6 +851,9 @@ static int truetype_set_cursor_visible(struct udevice *dev, bool visible,
 	uint out, val;
 	int ret;
 
+	if (spl_phase() <= PHASE_SPL)
+		return -ENOSYS;
+
 	if (!visible)
 		return 0;
 
-- 
2.42.0.582.g8ccd20d70d-goog

