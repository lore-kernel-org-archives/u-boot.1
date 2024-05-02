Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF9BC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E32088BFF;
	Thu,  2 May 2024 03:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vil8zdHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB31E88BAC; Thu,  2 May 2024 03:31:52 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 906C888B98
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-43ab8e0f435so19415151cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613509; x=1715218309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hQ3kKJxpjX/fzeoHO6TObb6wMmA/5+4CIh1wdpO76DM=;
 b=Vil8zdHsShY51DgZm6xp8YzjvwRfYmkHzK78JBFBtg9qZ95mWDrpmdFSrtdQi1fyNo
 9wINPbKutE0Gi7TSogCqP71dBbRaoTRe9Sc8VCL0Dfy3RVZKId3lsvhU81kF7dB9VYAI
 g7q/xfkivixc5sxHFjJL7zqnwCwhCpCMP6udY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613509; x=1715218309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQ3kKJxpjX/fzeoHO6TObb6wMmA/5+4CIh1wdpO76DM=;
 b=ACG6rZAv6qkfzTi2WgqqLoUVqC7w2P6DF4AaWhWC/eKO6laJaNu87McfOSvu9Xz+X1
 Cy03XxSxjGAtlLgMmcJiMUJLCM/+H/RE084P70W/w9Jtk3gJrRCNf/COYFRT71Bbfc98
 MXPvYdikszoSsU3sMn6wFgWzxfvJ8Phon/iINsCumDegluVu5AWKH8xfWJdKIvCQ56hX
 LvI/LOt+oFsZgKGTx2+J3AOv3Y+X/SptZKybstY0JeVNRRGyuq/fWZ8lhExJ9qhK4KNV
 FCuTDAfVS1MHS1WLPRqQ1I+cIpNPIxtppOielEcnbtaaQAJSJe9SOIvqenmUMjI87PWp
 PBYg==
X-Gm-Message-State: AOJu0YwfPyqzdjXHPfcpQVDpZj3bhiugW+EupiaWsNGBIIsuZqaig7oL
 GGrGHu7Jl6CCf16LRQEajo5Xsokb5KCsK+bi78GpgnLf02DQRc/08CkS6a58L8zoMXnOwCnCpoD
 dMFT/afpT
X-Google-Smtp-Source: AGHT+IHglZ68Jnoqa9sWhT6zEZuFUZDAsKPlWbNj3+jfthyDpYYAqcHE8gkUaR0XWfRGYC/ooxcQUA==
X-Received: by 2002:a05:622a:1309:b0:43a:b9c9:a25a with SMTP id
 v9-20020a05622a130900b0043ab9c9a25amr5136516qtk.56.1714613509047; 
 Wed, 01 May 2024 18:31:49 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 07/81] include: Add missing <linux/types.h>
Date: Wed,  1 May 2024 19:30:24 -0600
Message-Id: <20240502013138.2383421-7-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

These files have many "Linux" style types in them, add <linux/types.h>

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/display.h    | 2 ++
 include/fuse.h       | 2 ++
 include/i2c_eeprom.h | 1 +
 include/libata.h     | 1 +
 include/ram.h        | 2 ++
 include/sm.h         | 2 +-
 6 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/display.h b/include/display.h
index 3d0121764411..e8d8aaa15fbc 100644
--- a/include/display.h
+++ b/include/display.h
@@ -6,6 +6,8 @@
 #ifndef _DISPLAY_H
 #define _DISPLAY_H
 
+#include <linux/types.h>
+
 struct udevice;
 struct display_timing;
 
diff --git a/include/fuse.h b/include/fuse.h
index d48dcdfa6474..4519821af7ea 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -11,6 +11,8 @@
 #ifndef _FUSE_H_
 #define _FUSE_H_
 
+#include <linux/types.h>
+
 /*
  * Read/Sense/Program/Override interface:
  *   bank:    Fuse bank
diff --git a/include/i2c_eeprom.h b/include/i2c_eeprom.h
index cba991e3574f..1fe32d2dd687 100644
--- a/include/i2c_eeprom.h
+++ b/include/i2c_eeprom.h
@@ -7,6 +7,7 @@
 #define __I2C_EEPROM
 
 #include <linux/errno.h>
+#include <linux/types.h>
 
 struct udevice;
 
diff --git a/include/libata.h b/include/libata.h
index a55e9315a730..fa39d21a44a0 100644
--- a/include/libata.h
+++ b/include/libata.h
@@ -10,6 +10,7 @@
 #ifndef __LIBATA_H__
 #define __LIBATA_H__
 
+#include <linux/types.h>
 
 enum {
 	/* various global constants */
diff --git a/include/ram.h b/include/ram.h
index 2fc971df465a..3600bb57a6cf 100644
--- a/include/ram.h
+++ b/include/ram.h
@@ -7,6 +7,8 @@
 #ifndef __RAM_H
 #define __RAM_H
 
+#include <linux/types.h>
+
 struct udevice;
 
 struct ram_info {
diff --git a/include/sm.h b/include/sm.h
index afa9c89055e5..fbc156ad68a7 100644
--- a/include/sm.h
+++ b/include/sm.h
@@ -19,7 +19,7 @@
  * implementation of the driver you are using.
  */
 
-#include <asm/types.h>
+#include <linux/types.h>
 #include <asm/ptrace.h>
 
 struct udevice;
-- 
2.34.1

