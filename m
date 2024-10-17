Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88A9D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51098890CD;
	Fri, 18 Oct 2024 01:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z8MUMbxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17A88929F; Fri, 18 Oct 2024 01:25:18 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C0E89286
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a398638ff9so6061645ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207515; x=1729812315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JwwmgZG6S3qPpG6cuKkI09gKoVoOt3MCKYDKzFIyZCY=;
 b=Z8MUMbxwV79yEKI7Wb1ihAmDlJP+fY7eNn4zQl1b/vwLQ2VQY/ZQNfv1Ze/dpSkXmo
 m7Hz1LgWrcWrr4v696m9NHw84q1lI1Shws/UZIJCXKpkB4k3QNFBYvNvxX6K/G4qjodH
 BMH1rTXQ1Z3jyrxo9AVfNa/uEWri+/dwVwDJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207515; x=1729812315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JwwmgZG6S3qPpG6cuKkI09gKoVoOt3MCKYDKzFIyZCY=;
 b=lsJmOAYJabA8AM8PDfpg7Asluh0qTTEIBZd36u7x/W8hwHip9zS+JQ197zBndXLe5s
 oRTJ1lduMrNo3uOtV29VhWfIqXs/gTp/c+CMo2SP4vHGOo624A/ztQLzd5CqYhnkIgKT
 58RHgQHhCHP3AHSfi13NoIlmv0VblVoQmUQz7nMqJ20aAhOPx67/P6vtWfeb7bd4M7P6
 t/GyIuc00gHnd4hou0ep/5t1qmwk2/qzzuHzYdmmfDEw2QuwI9QvUUQO9HVAMqzoc7nP
 4KfUWkdW4IxbJrBE9mbonpyzPuXGj18TQB0lzoyLa1voIIx1kZ2MQUaWICsXvq4B/ZCB
 UD0w==
X-Gm-Message-State: AOJu0YwLNSZ6QuRU1iyH0pKurzPfnHPAkMZQrdPhcIFyhkL/wt88bXuT
 /Y8GjbS2UK1WvbnKBcQAz8Wyr8f1rM8jWeBjwqgIResiTdtO+xTJa8ZDUg2fLHoSMxrA4kWjeEk
 =
X-Google-Smtp-Source: AGHT+IGisKEZisOSMpd1t1DUkWpdV9lFOW8zyk0MpWbbndOBQ3HCCub3HcHjyrsxl/PtkFaXNdXRpQ==
X-Received: by 2002:a05:6e02:1a2a:b0:3a2:74f8:675d with SMTP id
 e9e14a558f8ab-3a3f40a8682mr4490535ab.20.1729207515299; 
 Thu, 17 Oct 2024 16:25:15 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 33/34] bootstd: Update cros bootmeth to record images
Date: Thu, 17 Oct 2024 17:24:12 -0600
Message-Id: <20241017232413.724808-34-sjg@chromium.org>
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

Record images loaded by this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_cros.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 3e60fd5da07..10aefe046ca 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -206,6 +206,7 @@ static int cros_read_buf(struct bootflow *bflow, void *buf, ulong size,
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	ulong base, setup, cmdline, kern_base;
+	struct bootflow_img img;
 	ulong num_blks;
 	int ret;
 
@@ -243,8 +244,27 @@ static int cros_read_buf(struct bootflow *bflow, void *buf, ulong size,
 	ret = copy_cmdline(map_sysmem(cmdline, 0), uuid, &bflow->cmdline);
 	if (ret)
 		return log_msg_ret("cmd", ret);
+
+	img.fname = strdup("setup");
+	if (!img.fname)
+		return log_msg_ret("cri", -ENOMEM);
+	img.type = IH_TYPE_X86_SETUP;
+	img.addr = setup;
+	img.size = 0x3000;
+	if (!alist_add(&bflow->images, img))
+		return log_msg_ret("cri", -ENOMEM);
+
 	bflow->x86_setup = map_sysmem(setup, 0);
 
+	img.fname = strdup("cmdline");
+	if (!img.fname)
+		return log_msg_ret("cri", -ENOMEM);
+	img.type = IH_TYPE_CMDLINE;
+	img.addr = cmdline;
+	img.size = 0x1000;
+	if (!alist_add(&bflow->images, img))
+		return log_msg_ret("cri", -ENOMEM);
+
 	return 0;
 }
 
@@ -263,6 +283,7 @@ static int cros_read_info(struct bootflow *bflow, const char *uuid,
 	struct udevice *blk = bflow->blk;
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
 	ulong offset, size, before_base;
+	struct bootflow_img img;
 	void *buf;
 	int ret;
 
@@ -306,6 +327,15 @@ static int cros_read_info(struct bootflow *bflow, const char *uuid,
 	}
 	priv->info_buf = buf;
 
+	img.fname = strdup("kernel");
+	if (!img.fname)
+		return log_msg_ret("cri", -ENOMEM);
+	img.type = IH_TYPE_KERNEL;
+	img.addr = 0;
+	img.size = priv->body_size;
+	if (!alist_add(&bflow->images, img))
+		return log_msg_ret("cri", -ENOMEM);
+
 	return 0;
 }
 
-- 
2.34.1

