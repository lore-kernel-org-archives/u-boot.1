Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4144CFA446
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 21:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0898840F8;
	Thu, 20 Nov 2025 22:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JY618OYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2EB88412F; Thu, 20 Nov 2025 20:19:09 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2077684141
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 20:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fanra3.tk@gmail.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5942b58ac81so890800e87.2
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 11:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763666333; x=1764271133; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BGDe+NEVd6YPq9oNzATWlGHR6msVhYu00fDNedIvkmk=;
 b=JY618OYPcvd5n4821oh5/xPYykLBtpfsYnU6s50Z7T5ouLwiLOZUkZ3pXC/6kH72pU
 WQxSz2aSaxEQdmYAnp4LofLv1Qdyd6/Ldotn73DBwyUpUxhkKnfqgiwNCP+m1VeZ/xnb
 MJfAglHT4LdNdRGsp5eXUDSbzRbQU9YQZZYwgTGSh7ZBUg+NGgybcZlledy3XDQQJKPp
 AygAO1dVT1TJnida9TASvAvZx/qZfa1TCiDDzw3aosj/v4fSauNMPXr/xuSBaQpRf2Bu
 Gp3kfh4cs4s24i4BYFYCNN8NfgsLrmgjPa/MjP0hOxlsqB3aAem7fXdMUPvlSmdVg5Jd
 vmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763666333; x=1764271133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGDe+NEVd6YPq9oNzATWlGHR6msVhYu00fDNedIvkmk=;
 b=q4Qoj9VjQYwNHBWXJHWPdft1jYFtIhwbdjwgDM1k060KmGv5AlRdR/g/2Axfz9MiUF
 n/0ABnaH/BRzWgrCz7x/zZUPLzcAjRzxbC8gapErqfZJPcW0+WNIs2gK2rnXFmTKcFjA
 or5dO24SAjQWYs/M4nuYSa/1m2+Qx4toVl7HhdyVJC0LVQv01Jvsf03lGTs24tHaVVJJ
 y79Lv07+36LZzAnlh1XM2OH4Ms86wSo1mmY1glpREIvNX45h1cOBUDsgYId3zo8NxjM3
 ZjWuRduGgbarHPID4EGrCAK899plFOqSAuAYuGl+XfoDTDDTTW4AbvjcLDccEnkCXFj6
 I9HA==
X-Gm-Message-State: AOJu0YxBFEz/KnTgUl1kMGynrcpd1g2Tczk00wAht89J9HT+e8gc9rAU
 PGdzm+5lweX9IqDP1yBRcMhGNKWYCevvj7HDG6Jsq9D5e5MWipYrC1D46DE8xw==
X-Gm-Gg: ASbGncvm6o4v4GGHvRcZtpSE5ximsQ01Wr+ntuG5Obr8VwvpE1SZjFMY9Sp7cx2MIwP
 65SwiWuxI7rBgp/aulYk5xeHm7QfpuydLmLLiQ6nNya2M2ll9qOlSl69XWIMeUX/t18br30M5+U
 DiPOp7U1dtaWTLUs23S8ofKzIGIuQ845ht9ZxQATZGqbtiGSqt/C3R/9V8uy2GitvJFYfyivk38
 74IVSvRsW/sspRZQGTrSqkhNhEEgUEwKEcLvxS3XrnTgm8zGBBoZAGsZJOEAs0aFLK8VcOF2bvo
 7Mzn8lGi74aTKVTyqdN9TJYPWDlrIIbZpZe6usDj/oF+hR60jsLy7SJ2w/nEwT7eOmxN3tpXys3
 VXRiRr3QTiVFsWqNTt2ZYmv5YwwyBm9ioz2h3MTpY2g7MvbSAN/V30t/oFTZotrhgsQYJfI4SuL
 ntP66NijCtIlSJb2UTBOpdlC0fBVEtf9dY6i3j4rUxQOpN+7tuLZ+vIO8eEsCxwvNvxg==
X-Google-Smtp-Source: AGHT+IF8Mya/OFMMkvWJ5hMQVIZ80aK+xPDJZOIDIdy09B+tfOoYRcafhi0tirVSqf1oWw/UiFKVrQ==
X-Received: by 2002:a05:6512:4007:b0:595:7c47:cd47 with SMTP id
 2adb3069b0e04-5969e2d27camr1602613e87.2.1763666333002; 
 Thu, 20 Nov 2025 11:18:53 -0800 (PST)
Received: from medoed-VirtualBox.. (88-112-69-49.elisa-laajakaista.fi.
 [88.112.69.49]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5969dbcd26csm931138e87.95.2025.11.20.11.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 11:18:52 -0800 (PST)
From: Surkov Kirill <fanra3.tk@gmail.com>
To: u-boot@lists.denx.de
Cc: Surkov Kirill <fanra3.tk@gmail.com>
Subject: [PATCH v3] boot: pxe_utils: Fix incorrect allocation of overlay_dir
Date: Thu, 20 Nov 2025 21:18:47 +0200
Message-ID: <20251120191846.110041-2-fanra3.tk@gmail.com>
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

The function label_boot_extension() calls snprintf on a buffer
overlay_dir. However, this buffer is not initialized properly. In the
"if" branch it is initialized using a variable "len", which is smaller
than the resulting buffer. In the "else" branch this variable is not
initialized at all. This results in a crash when calling a "sysboot"
command.

This commit fixes this issue.

Signed-off-by: Surkov Kirill <fanra3.tk@gmail.com>
---
 boot/pxe_utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 038416203fc..a2a9810a4cf 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -474,7 +474,7 @@ static void label_boot_extension(struct pxe_context *ctx,
 			slash = "";
 
 		dir_len = strlen(label->fdtdir) + strlen(slash) + 1;
-		overlay_dir = calloc(1, len);
+		overlay_dir = calloc(1, dir_len);
 		if (!overlay_dir)
 			return;
 
@@ -482,6 +482,9 @@ static void label_boot_extension(struct pxe_context *ctx,
 			 slash);
 	} else {
 		dir_len = 2;
+		overlay_dir = calloc(1, dir_len);
+		if (!overlay_dir)
+			return;
 		snprintf(overlay_dir, dir_len, "/");
 	}
 
-- 
2.43.0

