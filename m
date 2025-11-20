Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A77DCFA447
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 21:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67ABB8409E;
	Thu, 20 Nov 2025 22:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VQq9HsIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B771840AE; Thu, 20 Nov 2025 19:51:52 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A57B8405F
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 19:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fanra3.tk@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5942a631c2dso1360477e87.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763664709; x=1764269509; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kTsJodsB3m+TChiQ6nXbXFgUsbRj8t3wxbjzkPLEyXg=;
 b=VQq9HsIW0CbEKnvePX16jYsEkm8Hl6TV+bI8LBU6e/T2NOUcrAzUD3IBGuVoKrr8P1
 eymd8RdydDniSChWO1F7x7dCKpqLPbGlrqiGolgdjBXmp7NRkLX1nyNTjl3b+bQf5EFa
 GQTPhuFaZgl17y6Eoywm/uf4JL/YOq36eNVx4VsV96+tqOYumBN0wrIppQxLInev6mrI
 ac5Lm1N8YInapfYRNJLpKdIb2c90ZaOjayti3ib7Wvk80Lsb7q0X+hLxARmU+7WcOzIf
 ksLqFo+L6EwV5DalEYE68VGzA9KhEG0t7WpMMmTAqu2gSVHT5AMeWiEM3nj3b3U6/ZT/
 8L8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763664709; x=1764269509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTsJodsB3m+TChiQ6nXbXFgUsbRj8t3wxbjzkPLEyXg=;
 b=Nsfy9M9p+NiZnX3+1c0lqvwciPVAN9xTa0+pvKBA+lQnXWIYUR71ao5tbHCQhyRBPl
 3mvVYcWSwI7saSbifg61m3wY7pVXCT6OQ3FRm4Etv1KY+FRJ6tzvcgQg9YBpU9KSumpK
 GVF1uXo1PP482OMSwj6jffK6HVc5gZvA/dJcKWJwG7+zHMameQz85eGaoaZUrofu58GS
 plkfxptKvf+sk1y+HVvxeIeSlgKNvXdXRgCwlam6hP+0cvjCNMxUn4tQYKiCIwI6FGtM
 Edpsjh7F68Q0jb7x4FgXyCKXKzMhkweW30C/LIjgwY/1t1aPbWGW1Yu9doh7wp+hbPDW
 vG5g==
X-Gm-Message-State: AOJu0YzN9lXMrZcBLwR35FPDwl13BU3y/9+mZ75Ez9nXTXhrlK/+3M+h
 wYlDpeO7NApmgKE2ld/372D58MH2yJY1q61fcNS1pBq4RhMp5QJ2CNBbfysr0w==
X-Gm-Gg: ASbGncswC5Mrg7IA5wy/eylmNC1yWvk3mYGiwc5qANRctmUgqHQeeuZzWPsbgzgbCHD
 kfDaondGeMDX2QkeKAppY75syYwWFj0BjxdOtNDFVhRqb45FfjezSCeXefhYOY1//dka4nKT3gp
 dfpqcTSwSfwljs1ZJuDkdmNYqVsBLv+OrMNn6+9YaTxGLgDNwNbWaL4Cbb2jJ88+Yjlxz/xzVL9
 C9EhqWWNul5t29DZtdoe7xbvCjCzzBotioy2hOAvHTdEfOr368WCPNaGxF8thoarw/aoYKo3gyP
 Z3RebYQ9xvsPh1CrPrl3tqpg11ubU8KO5rYJbZMjTz05LTW5RzlOiu515HKzkZeeG0OJS5PE0aU
 w90Z/JDYr5xjhn+UH9ba5XiScOWUSGe+1Kxe8Bh86Bw5Lve/7ZZuTWvI0L3dQNWulVg0J6RC4vY
 6fFBVOQcrd8c4juXtiIvQ+Cm0Yn5fKCwcDhMdnDlg1OusON78NKJN/OdY=
X-Google-Smtp-Source: AGHT+IEI7AB6xKDUlLCdk8ZKNy/Q6vpkr3xGDkCOTOQ7TBGO0EyCF+acXCWAW6MEksjDu6AKiA8VHA==
X-Received: by 2002:a05:6512:33cc:b0:578:ed03:7b5f with SMTP id
 2adb3069b0e04-596a2ef9f4fmr73292e87.26.1763664708944; 
 Thu, 20 Nov 2025 10:51:48 -0800 (PST)
Received: from medoed-VirtualBox.. (88-112-69-49.elisa-laajakaista.fi.
 [88.112.69.49]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5969db81b1dsm893455e87.23.2025.11.20.10.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 10:51:48 -0800 (PST)
From: Surkov Kirill <fanra3.tk@gmail.com>
To: u-boot@lists.denx.de
Cc: Surkov Kirill <fanra3.tk@gmail.com>
Subject: [PATCH] boot: pxe_utils: Allocate space for overlay_dir before
 writing into it
Date: Thu, 20 Nov 2025 20:51:43 +0200
Message-ID: <20251120185143.109371-1-fanra3.tk@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Nov 2025 22:04:13 +0100
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

The pxe_utils/label_boot_extension calls snprintf on an uninitialized memory overlay_dir.
This results in a crash when calling sysboot.

This commit fixes this issue.

Signed-off-by: Surkov Kirill <fanra3.tk@gmail.com>
---
 boot/pxe_utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 038416203fc..fc72dbf6020 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -463,6 +463,8 @@ static void label_boot_extension(struct pxe_context *ctx,
 	if (fdt_check_header(working_fdt))
 		return;
 
+	overlay_dir = calloc(1, len);
+
 	/* Use fdtdir for now as the overlay devicetree directory */
 	if (label->fdtdir) {
 		len = strlen(label->fdtdir);
@@ -474,7 +476,6 @@ static void label_boot_extension(struct pxe_context *ctx,
 			slash = "";
 
 		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
-		overlay_dir = calloc(1, len);
 		if (!overlay_dir)
 			return;
 
-- 
2.43.0

