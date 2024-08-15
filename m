Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D4CC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC0288B9C;
	Thu, 15 Aug 2024 22:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XeoOEWo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B732888B7F; Thu, 15 Aug 2024 22:25:57 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A55AD88B0C
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39b3f65b387so5722475ab.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753549; x=1724358349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9s/eJiayLlbSa/uz8wqLFciI0yl+UMAyBLHukg/URw=;
 b=XeoOEWo0u64xHFy4pi32wxbMPD8nIsDnH0Z8dHQHRe8yNu1c1fZ0mIDRNvWW7hyo05
 1M0B3x4Cd2uudvFgX7i/SP8rWuFolQ3ryLpBzmv8tNRFE9JMfE7IlKO6mnSNyBy2O4C1
 /unW3vPeOiVuxgLqxWAwway5x1sTAI+13ZzLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753549; x=1724358349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9s/eJiayLlbSa/uz8wqLFciI0yl+UMAyBLHukg/URw=;
 b=hBXcXlGkNkUvy/7Tk2udj8VWeie9FH+ohADSE/Q+9r2crwFIAzMphBPfLQFMKW2LJZ
 7sGJU/p3guYZJf6f9oUkFU1c8SwmcG0XBYVI53HqApP5I8MaZvZ965NTthUDD0GqSLzE
 jr/Ate3ORzCpFQWbsdvom/d/S9MtO40WBEVIseAU8rKLo0vPPTlnktmyffLaLN667e41
 4DtQv33bzcMPir9H+hyJOjFZEUe+KeoD9SWM7qLcNPUHcgs5HGtYLqAUA5A1TnuOOzCV
 XHCIR7Qt0PIclcTF3vS56jTaC8iFiMXbO0RqSx6UDPxTxw1pWkKxM1iuxqukUwn1+iIV
 giPg==
X-Gm-Message-State: AOJu0Yx9ZXFH7ktwZa/0q/KU9zRoUvYVeDk11ZRBTpIS36tS59AJVERU
 qM2aMn9MEbkbYcbEla/rj027Qy/C16IHzTrLaDLEwT4CpwlZjKyiQZgkOadxO6YyzMsmeCmhLlZ
 JPA==
X-Google-Smtp-Source: AGHT+IGYLUxlqbp8ubLVAHVYh53xcYTNuPsNq1GBcdRIoU0AdhraLEoz0UzhFfkTUMbWCPLB0ARXsg==
X-Received: by 2002:a05:6e02:152b:b0:396:c825:4db6 with SMTP id
 e9e14a558f8ab-39d26d64999mr10467025ab.26.1723753549297; 
 Thu, 15 Aug 2024 13:25:49 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:25:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v3 09/24] usb: Add DEV_FLAGS_DM to stdio for USB keyboard
Date: Thu, 15 Aug 2024 14:25:20 -0600
Message-Id: <20240815202535.767869-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

