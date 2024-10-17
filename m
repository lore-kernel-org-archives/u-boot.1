Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F737D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA54C892A2;
	Fri, 18 Oct 2024 01:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L9ydDra6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92C2589280; Fri, 18 Oct 2024 01:25:15 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C2F891E3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a3938e73d3so6214625ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207512; x=1729812312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VNkDJyXtxTPaaYgCSGP2Cj2kWd0X75Q9xJhLqqV9Kvo=;
 b=L9ydDra69K8Qo7vJKeswU+D9vJrltp7Y5YOaCFYbHrVfPPDwnhFeTfI9n7Cki1NL4D
 jJfoTomorlRVZOPtdE7qKt3lxVvKSSsTqNW947dUtaHlYGJViPlSXnluXT+WAn9KO0dJ
 KOG0Dc2QwA9FctQ64HcdCcEV7rPZB9lk24u88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207512; x=1729812312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNkDJyXtxTPaaYgCSGP2Cj2kWd0X75Q9xJhLqqV9Kvo=;
 b=YVW8vAUoNwYdRgLQZBzyFTEpTBmvqeIdC41gsDonwCPLQNFtbn5GwRVXccK14FJXN+
 qDB9lpniGcuJ9FZ85shArX2Ykm7Bnjkq/90sEwNX1c+Z+o02V5XGtPmDJlmjAwvxh6F/
 Naq6u7/8NBFxsc4my8fZK0idw1zAKuz+UqpOPOLTcp8O7DwNvx84k/Hj64Tj9aHNP8jU
 aIZPA8AqjhkGa6ENzYwmqlxe0xwDyw6R78vfNwhqmc+b25ijR/Vb+5IwxHSl2vpP+n0P
 dILZdddJsiQSWchjtKN8p3j/UwRyBtzeiriayFNCylwkQXYvEnIU+P8rSlDhBcX/WkSR
 vatw==
X-Gm-Message-State: AOJu0YwSRI1a1U5031flylQtDQPby8nNE02NLsBvciDRZBk6mTfOr1VO
 cvacpl3MOVZ2/9oKsQqf0qjEALBkWsREqA2NSEBPDd9g2zcMd5MX8CwUUeyXS9X2jDZKyfEPSLQ
 =
X-Google-Smtp-Source: AGHT+IEoXrRtmeZofxcTruC29JBebA1gobhM7kjUNlFtnpClQnxqktEZJRZHCK9ACqeQ1bsp8MXUPw==
X-Received: by 2002:a05:6e02:2167:b0:3a3:4164:eec9 with SMTP id
 e9e14a558f8ab-3a3f406362cmr3781725ab.14.1729207512150; 
 Thu, 17 Oct 2024 16:25:12 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 30/34] boot: Update pxe bootmeth to record images
Date: Thu, 17 Oct 2024 17:24:09 -0600
Message-Id: <20241017232413.724808-31-sjg@chromium.org>
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

 boot/bootmeth_pxe.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 0643d280f21..3e5008ab317 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -118,7 +118,8 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 {
 	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
 	struct pxe_context *ctx = dev_get_priv(dev);
-	char file_addr[17];
+	char file_addr[17], *fname;
+	struct bootflow_img *img;
 	ulong size;
 	int ret;
 
@@ -135,6 +136,17 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 		return log_msg_ret("spc", -ENOSPC);
 	*sizep = size;
 
+	fname = strdup(file_path);
+	if (!fname)
+		return log_msg_ret("pxf", -ENOMEM);
+	img = alist_add_placeholder(&bflow->images);
+	if (!img)
+		return log_msg_ret("pxi", -ENOMEM);
+	img->fname = fname;
+	img->type = type;
+	img->addr = addr;
+	img->size = size;
+
 	return 0;
 }
 
-- 
2.34.1

