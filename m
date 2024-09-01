Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D50C54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE1688A75;
	Mon,  2 Sep 2024 00:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lVwY1QlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B27B88BBF; Mon,  2 Sep 2024 00:27:00 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 611A788AB9
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-82a245753bfso121704139f.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229615; x=1725834415; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9s/eJiayLlbSa/uz8wqLFciI0yl+UMAyBLHukg/URw=;
 b=lVwY1QlDEhkgf1WWO4+/Xis6RdxepTlIX7nO4POyYNFDWLFjHko8DYTlLeqw4dsGxc
 94caKhlqUt4Xi+0n+s8y+f3ko0d4DBJmjRxepTOGZvl1kc4XIGn0jP0b0VImBYBTPi2h
 AVdtDTXSJ/rKSBjV5Y2u8AIBlEafeXrXZ1qxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229615; x=1725834415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9s/eJiayLlbSa/uz8wqLFciI0yl+UMAyBLHukg/URw=;
 b=E2HHronyk7x7T9X4wjAZBPHNR4hcNqQV0qz4wf0/J/FL/3zkUp7cB75FsFPUG1Na5I
 xFDusC9xc1+yGAemlmkGnXNUAiG3zQn8Cq/YHQbKBTJyYYkHsfxosxxF3wfd9+v1iWUU
 5P9HsZZu3RBP6tM/h49KK9lvMerpDx93mTTP7v8clk4QiWnPvj8mQiDrt7q5lFojFeSG
 1XlaZwYyCKIZDad8eQBBo55PPnpEJojCFkQZqkl/qo+TqOWPfnlGGLKAToyfDx4otvov
 WaPpX8ZJgaDucNtRB8555gmNnMct48odTVmgfo/VREBch4uRTTVqkZYCOR8WwXYk1puw
 ACZA==
X-Gm-Message-State: AOJu0YzqqY1a9rIa2l6KDkJsINQ6qhjzmmz71D7ziID4NAVDfl4aGXha
 g7q4zUVwCQ1b9qjRcCTtWPWHiN7jCXpI5xsHi9iwWpCEeuXG2m98dWXfWAJ8cqMkGadfzfgowkE
 =
X-Google-Smtp-Source: AGHT+IHa7X+VsK9DjIq8xffGrABBzYyG7RoGK7LTF7ewDZ1tmfv0lDXEf4X2QxrtR7w3Z4URMRTrdw==
X-Received: by 2002:a05:6602:29cf:b0:803:f97f:59d8 with SMTP id
 ca18e2360f4ac-82a10d7d132mr1609857439f.0.1725229615590; 
 Sun, 01 Sep 2024 15:26:55 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v4 08/23] usb: Add DEV_FLAGS_DM to stdio for USB keyboard
Date: Sun,  1 Sep 2024 16:26:19 -0600
Message-Id: <20240901222634.460873-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

This device contains a pointer to struct udevice so set the flag
indicating that, just to be tidy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/usb_kbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index b834b2f703d..1d9845b01ed 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -612,7 +612,7 @@ static int probe_usb_keyboard(struct usb_device *dev)
 	debug("USB KBD: register.\n");
 	memset(&usb_kbd_dev, 0, sizeof(struct stdio_dev));
 	strcpy(usb_kbd_dev.name, DEVNAME);
-	usb_kbd_dev.flags =  DEV_FLAGS_INPUT;
+	usb_kbd_dev.flags = DEV_FLAGS_INPUT | DEV_FLAGS_DM;
 	usb_kbd_dev.getc = usb_kbd_getc;
 	usb_kbd_dev.tstc = usb_kbd_testc;
 	usb_kbd_dev.priv = (void *)dev;
-- 
2.34.1

