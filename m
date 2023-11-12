Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299B2C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68FCE87469;
	Sun, 12 Nov 2023 21:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AEJduyH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A5738710C; Sun, 12 Nov 2023 21:03:14 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC7487036
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-359343e399fso14454945ab.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819386; x=1700424186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8MF8Lzydt+ohQrqFqr9JSjLZfgfvALPh8aBlhOYX08=;
 b=AEJduyH2sXHYOkZ0KPF/lzc+cFZYpK1Sv35FaaS429g+g/6xbGf+79a9r0nUp08RZN
 3H0gTTXTmNuFuluL1ofGC6MscDQlr2APg3yOgNEwl2AdDf17azn8dgF2OWXEGz6Sv4tE
 NfgVsHIEUsFebtuKlu8O+EecBc7ZCkzlhrwTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819386; x=1700424186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8MF8Lzydt+ohQrqFqr9JSjLZfgfvALPh8aBlhOYX08=;
 b=USX5YVQigpeudgilqCz6BcF7EIcZbRY8TeP+Ci1nkuPvSySaproIMwmMvgCWxvQFCF
 /lc31ALWtsU3doqKT3b60NRl/kz7Yp3l3bX9bzhe5uhuvuR0cy9nWc1DgsNFX4YqUz6N
 T9HPSDwbHH/TL4hgUgDvDoyeP/hCzHUOycbwZaPLaD0uAWLJbEIUcITeH6EpHbKHH7WU
 wfuuddlpvbAgCQkFf4n00Nc+wp4x7t0fqEDWVCB6zRPsCZzMZ1fsJVDFAj4dMJLhkIuX
 1nAoV0LHFIRRJbtL+PpeZUTdOwlq80hlDWR1tQSLvfWsrU4cSf07KTJtvIiSfSbRDR5E
 Gbpg==
X-Gm-Message-State: AOJu0YyoZv1p2bsGaZKvce1vO1rBro44I+jOHJzY3L3DQmISXrx1ql24
 vu1+uA3RR2ZwFokeY75TOjW2WFmEJWIBrP2MU/TMVg==
X-Google-Smtp-Source: AGHT+IGTIMRVLujxpNGQJhwMg6z7tuexvWPcCI2NX8rNmmPLew0YJ86RwmRDhlKaX87+xFbGauAnLQ==
X-Received: by 2002:a05:6e02:164d:b0:351:ab2:2621 with SMTP id
 v13-20020a056e02164d00b003510ab22621mr9472202ilu.15.1699819386500; 
 Sun, 12 Nov 2023 12:03:06 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 08/12] video: Drop unnecessary truetype operations from SPL
Date: Sun, 12 Nov 2023 13:02:45 -0700
Message-ID: <20231112200255.172351-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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
2.42.0.869.gea05f2083d-goog

