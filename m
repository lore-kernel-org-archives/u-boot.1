Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03F1C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15072874E9;
	Sun, 19 Nov 2023 20:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FF/ER4BQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB521874EA; Sun, 19 Nov 2023 20:12:31 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0D178749D
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35b059b06d1so275055ab.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421137; x=1701025937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qxsOJrNVSQLDNI+WCJjnwCmT1ZIoCRe3tFSf9ODlzaI=;
 b=FF/ER4BQkiGdg/TmwwgfIEH4aUQ2i/lGDiHcHjdU2+ineJ9MNQSHoNy1bD++8XeNVc
 77oTPa+4wXHkzhTEkRJlkhPKUBBtWH6c2VxgGtHgxRpDUUSNLz3jErCdDAUyZJ+RWj2O
 AG60YUi/G5fkfcKAlXyXU3TokDO6ir91ti0/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421137; x=1701025937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qxsOJrNVSQLDNI+WCJjnwCmT1ZIoCRe3tFSf9ODlzaI=;
 b=a35kI/LdD6mHCMhqpEmAPFStXLenoxVfVpLzmEH07y11BbqFJzL+s/dhTKyLlP+i2V
 thkyoiWqp8W5sdSyBYghI0CkIIGS7kE30qe+CRteHK2SyC4PHsFWeYbnoAt9R1BKhFeV
 V8BivboA3NdXraAXiUYn3V28XbteJ12QMkQHALK6ZX2dL7p2Ie3iDm0bi/O4AJXzdqaM
 DpsJaEpXN9+cKX7tpLyBCF8EaIV51i/27qFmNd5oMJFeZGX1jbyQS1LQxi5Yp8ZTibBy
 Id4IJ9yRXjEG9cyRxKcaVX1OY769Zv/2hyapCKeIejQQad2zDPm084GwsBCHJvpIAuqN
 2D1w==
X-Gm-Message-State: AOJu0YxF9lEdMAeNWQbQD9n00Zukj4XUC/5QYDDb0nhTpl8RP4FBt6OZ
 EQKX8t4Jp/znuPQgLbgBnIIuwQbwWKy/eVCDdmOrAQ==
X-Google-Smtp-Source: AGHT+IHglUWszRJb8zd6l2gu7+cx4rNg0UZ2/cmruAyw4JyEXuyU0IuFGcXVZxhxgmuMDtUg9DyzWg==
X-Received: by 2002:a92:6410:0:b0:359:523d:f1fb with SMTP id
 y16-20020a926410000000b00359523df1fbmr5661804ilb.5.1700421137494; 
 Sun, 19 Nov 2023 11:12:17 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v5 08/12] video: Drop unnecessary truetype operations from SPL
Date: Sun, 19 Nov 2023 12:11:43 -0700
Message-ID: <20231119191202.667180-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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
2.43.0.rc0.421.g78406f8d94-goog

