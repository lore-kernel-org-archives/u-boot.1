Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747EFC02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 21:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E5D812BB;
	Mon, 27 Jan 2025 22:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZIEjlfy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F03812C8; Mon, 27 Jan 2025 22:08:07 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE3C8129B
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 22:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michaelsunn101@gmail.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3ce8a6bc715so38733895ab.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 13:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738012083; x=1738616883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=osdKj1KpBIwpRhg0Ggux6oNS4jUqGlpTlLf5cfE7px4=;
 b=ZIEjlfy1M5ZTqrxnNIE2bckX7ZnEXSI/pUfc+4YaRGDTF/vSMALmcLQdeZQXj/XJdm
 UhwnDvVkETYVg6SMHuGQHWd5GHgUdVrOz0y4y+IToF+Rr9Mx56yO50rLMI39Jcc8tfgV
 XOLOdyAc72xdjZFLzOztyv15tz0QrxKZS/pgBuOLJLBNo/hS5qU8O+HQ1VjrfpJO7sT1
 8HpxtIrXYPzs61mou4Nvey83JcR4EFdfh+UUzeYOkq81PjHqXz7yBCEEy7+Uk8T8xFDh
 FQxPbERDz/qqYkIueM/iQIDnfYQJOoL0K7qsFgr5gf+PN21sgVwbyEZpW1nhS6d4H/Pk
 DO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738012083; x=1738616883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=osdKj1KpBIwpRhg0Ggux6oNS4jUqGlpTlLf5cfE7px4=;
 b=JJIjYbF1//INH3dovtPpKmnrKOYd8yKBA9/ORMl8WesJx5oGwcyhF+LZeeripaSQYK
 9SvUJcdYYIDNYK/O6EhLgtkvSX7giwf7dPHgSIAoujvYp7wK4jA/6+LXj6EXFyRZSl7y
 nMR1qa3AzYZ6nHtsTs7wKW9H92dV+POnFwHI+AmGRucMfPBk/4OjHmhZyKAWSpSl7Qbg
 nmDCSbdy9mS1cNiQpHb5zpnllxUnB4ZBfn5NIfRbXB/yZqJwsTEMny5FV7g+B3wRvCJF
 DOrxmW+ARAVVPNr4bR07gPzg6Wx3ZksbJ7Gy46yUV3PcPuq0PrnKazR/l/nvxFndm81L
 ejNg==
X-Gm-Message-State: AOJu0YzVXyAJJI40MivscVi/EKIZjp1B0/ki3SLKBuLEQNeP1lKgJw+J
 rReMOsRT7telqzzfJrDSmhsmAimg/jZ9kdxevSomcaX2FQWtuYrayvsFul8=
X-Gm-Gg: ASbGnct7WEUU/CqXodRG10BCJi7Hf9ME/gaLtwC1bgGWtJhhZY4ldIdsJAK9wNUYzgO
 CY06amoymSA4T2oNtv3miyURPe9cze24RE1dcCImmlG3zbY4TjoyjjnnFlES9OP454gqm5houVH
 g2LDrS8+ythTA4Ayu0JvaZ2Aq8PiXsJsC8B/Bcia0rAVFpLuCh9tMj9Jag2eusl3ydKiA4zTo1q
 ZkVDVW/8iMYEX+tbcHLixNYQsgLEd+IDZJOpg6zyYVooFDoDX70gK4GWDzMXB8pJYw/VDHHm4ZJ
 UJ/9CKpZgDPscykzWXC+wIdrkfJKr2zl
X-Google-Smtp-Source: AGHT+IGLcfd46rUL+HRpDO2+FrFvmsZqiQGSh4gsKw0/JaSSI08uiIRkAGLxlUU4knKCtmgWLaQJMg==
X-Received: by 2002:a05:6e02:3785:b0:3cf:c7c7:bdcc with SMTP id
 e9e14a558f8ab-3cfc7c7be50mr143177485ab.5.1738012082975; 
 Mon, 27 Jan 2025 13:08:02 -0800 (PST)
Received: from valinor-2.taildfe5c2.ts.net
 ([2604:2b40:2185:31:7b1b:4ebd:7d46:b4bd])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da4462asm2806681173.55.2025.01.27.13.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 13:08:02 -0800 (PST)
From: Michael Ferolito <michaelsunn101@gmail.com>
To: u-boot@lists.denx.de
Cc: Michael Ferolito <michaelsunn101@gmail.com>, Marek Vasut <marex@denx.de>,
 Heiko Schocher <hs@denx.de>, Lukasz Majewski <l.majewski@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] USB: Fix NULLPTR dereference when serial# is unset
Date: Mon, 27 Jan 2025 15:07:41 -0600
Message-ID: <20250127210741.820819-1-michaelsunn101@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Jan 2025 22:16:40 +0100
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

The current behaviour of this function will dereference a null pointer
if the serial# environment variable is unset. This was discovered on a
board where U-Boot did not have access to the first 256MB of ram,
resulting in a board crash.
In the event that U-Boot has full access to memory, it will still read
from address 0, which is probably not optimal.
This simple check is enough to fix it.

Signed-off-by: Michael Ferolito <michaelsunn101@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/usb/gadget/g_dnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/g_dnl.c b/drivers/usb/gadget/g_dnl.c
index 631969b340..d56f9c485e 100644
--- a/drivers/usb/gadget/g_dnl.c
+++ b/drivers/usb/gadget/g_dnl.c
@@ -50,7 +50,8 @@ static const char manufacturer[] = CONFIG_USB_GADGET_MANUFACTURER;
 void g_dnl_set_serialnumber(char *s)
 {
 	memset(g_dnl_serial, 0, MAX_STRING_SERIAL);
-	strncpy(g_dnl_serial, s, MAX_STRING_SERIAL - 1);
+	if (s)
+		strncpy(g_dnl_serial, s, MAX_STRING_SERIAL - 1);
 }
 
 static struct usb_device_descriptor device_desc = {
-- 
2.48.1

