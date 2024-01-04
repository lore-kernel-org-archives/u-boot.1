Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5132AC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3046879A3;
	Thu,  4 Jan 2024 16:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i1NwI1Ex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3625887977; Thu,  4 Jan 2024 16:11:06 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19DEF8799E
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3606ad5f1ffso842695ab.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381048; x=1704985848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IhfFkdtwmc+x40dlRQ9yQLO2Il+xbK0ZEs/XXDGabc=;
 b=i1NwI1Ex9MEGIxdrWvdiJXqw9jo6ib6xMa+QQTUd5vbQTWRyZ/MQLX0jxW+MVXcKWo
 Igcxyxabe6Sq4qItaBpWK8dCzucN4U9ALGvmG8dWCAakRHj1hq8Zk8fNVWQPYuMp7mJQ
 w++0V+OHLHZGjmYTYYXuC/RZ1/xkBG6sOpzzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381048; x=1704985848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IhfFkdtwmc+x40dlRQ9yQLO2Il+xbK0ZEs/XXDGabc=;
 b=WmaAX4GYAhM4ALwlf0to3qoS5tRbztr9KkEBSyjm3JiNd5KXN/+lg4okzY2J8U5VDs
 OPxAgXkyvuc9oNhUdAbZ2ZJ8EssCt6lE+OfLjsIr33wa9AnIsD5/3Eco8elUbRAR7Ikw
 6hsg2K43xYoDd4jQIKVFuy1cQOOkgBLfeywPewvb3acUbRZPiucFYPK7B+iFb8is6mKE
 mJ7NW/2hzy6k6D4OiMAQ4FY7cn1KhKgMrjj0SwFcI0r+tdEeg4Thr3ibNNI39/nLFzyV
 yGSYpTMeHDwn0IEimSZ5rO/+g96OJ5h8lWuQiatrTCkzaEW22uI2nUHnAD5X6QxEyL/I
 VHEg==
X-Gm-Message-State: AOJu0Yxt8f6TC7BTneXzAZgxcGeaK1pQR1LwA/YMbWyRjAFCsIPSzsIb
 LeTXmif4d+aF7sv+wcCj5UsMdIaDnnvnkDtu0oQiSrdxEk1H
X-Google-Smtp-Source: AGHT+IGGPWoJMpaQ0gGyx58wOJxbZ/AWMs5Qrtk+sHNGs2xaEX0rSeLVUrAZ8o8diHn63N+eM7K9cw==
X-Received: by 2002:a05:6e02:1bc5:b0:360:1914:49b with SMTP id
 x5-20020a056e021bc500b003601914049bmr788892ilv.47.1704381048597; 
 Thu, 04 Jan 2024 07:10:48 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v6 3/7] video: Drop unnecessary truetype operations from SPL
Date: Thu,  4 Jan 2024 08:10:38 -0700
Message-Id: <20240104151042.695717-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
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
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Anatolij Gustschin <agust@denx.de>
---

(no changes since v3)

Changes in v3:
- Add new patch to drop unnecessary truetype operations from SPL

 drivers/video/console_truetype.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 14fb81e9563..602133575f8 100644
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
2.34.1

