Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFE8C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E272388A28;
	Sun, 11 Aug 2024 16:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FW2DYTYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC2B7889E3; Sun, 11 Aug 2024 16:52:41 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B2588847
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39b41306b4dso12800725ab.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387958; x=1723992758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9s/eJiayLlbSa/uz8wqLFciI0yl+UMAyBLHukg/URw=;
 b=FW2DYTYLCqU5peK//bOtme6EZ7iRq17J41rR7gLL6coABTZGfqc6hdKOtiBNMyk5jk
 JLRIUW4USCWJ/TF7xT/DHBfnVIsl2VGjU5eZP9gXBruqu9ik7Tegz8Q7uM4jd34DjlCQ
 qoHwhSjrl8WYP7tMN+uEEnCpUqv4XY4CjT3a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387958; x=1723992758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9s/eJiayLlbSa/uz8wqLFciI0yl+UMAyBLHukg/URw=;
 b=mafs5eDY2hKcwPEVTyuUs9var36mFCtSGT4GCKjcKK59yidHriv0KWaA6E9OgB8n1g
 lxHEHr9h0k15iCCqC0oabgP3EW0frOxy2i3GTkWK6q4F7I+0HhirJpm69EozbNhgC9gt
 waYmsQt86bUHDNUncShK4dglQTQQzRjV/K2RffvasR8d7VS9hXcuFmBvCATff8h0NW60
 kvWR8FnW7iXJMb122xJO825qI8xqGsi4dMnqmKSBzcpNgE9B1fEYvjBORbNmnVkukJEr
 mZJ/reTbN5gLn+7wqoDQPNl1vcrB9fyWuqBtqN5yXM82Z7Yx5hE62QclZTzYHqUQfM+y
 9AYw==
X-Gm-Message-State: AOJu0YzkCVkS6W/dhjPSbvNIormPrpRLwsnLuuMuPy7MFzOKEI9HW86o
 4pQ4WqoftKFYm4TQD/5C+7zEyn7RJ88QPzEage55KnwEoIknnEjnnp15Vjx/bHMaXlrFzEFGAWg
 =
X-Google-Smtp-Source: AGHT+IEPQOCrB7/W580ljpdBUsFfUDT4ZNBBCfsT+Yy07EKOS3UtatoYHd/QlFbla8t0rxpSAWKMlg==
X-Received: by 2002:a05:6e02:1e0c:b0:385:e2e5:ac37 with SMTP id
 e9e14a558f8ab-39b815a4ea5mr95389135ab.22.1723387958398; 
 Sun, 11 Aug 2024 07:52:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v3 09/40] usb: Add DEV_FLAGS_DM to stdio for USB keyboard
Date: Sun, 11 Aug 2024 08:51:38 -0600
Message-Id: <20240811145209.4191404-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

