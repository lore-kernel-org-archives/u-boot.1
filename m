Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03740C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5394A88532;
	Sat, 27 Apr 2024 16:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="krsALWyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F363F8857D; Sat, 27 Apr 2024 16:11:29 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E1288429
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78edc3e80e6so220103585a.2
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227086; x=1714831886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IZAqPR/Jqtwd72BEUlKX6pFFYjYmmmbW1Vr8iyQ6O8E=;
 b=krsALWyWZDgfJsy0rR7qOTF2yCT5haa4xyTAixDB10+Wnl8AySI7nVhqW1cIAo/lnF
 Cobxu8ocU84VFRoPzwcJY6CBIjA/ujaZ0xzM7JRuz/Kpwa7lDWwZo+wKk9LNVAEXoema
 sXdEYCmvoZEGw7NEEpUwHrwIc2Nhe9MPR3KKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227086; x=1714831886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZAqPR/Jqtwd72BEUlKX6pFFYjYmmmbW1Vr8iyQ6O8E=;
 b=qVnNCUpgqoe/VvxpnJjEFocOF7DY+BcoAGbIkB3LDy3IBjzVSf0lU1yA/vsqd85bRt
 ehDuZrqsbbIBdyrYVPziA85GXykGtvA4AWYnkHfCeMNNTSUJNDf5ilgJcoPegM+4nG+Y
 yDSiTUYI+l5ykwaR6nKKYEReSjNX5ckGSabx3e2CZ+qi24t/pwk1zhadgOCgMBxDTgsl
 bOLJFQ/703wcD/RFpcHjF0vgHpctJwNKiudXo0tS3j5EFsktPyH56n3mQ1hcaVZa3GJY
 6rI1b/lTgjqSdqlLnrvrtToiLGios3x0Coy9X+lblEWu7aQqEAeH9QriCighTMIhIheF
 RH5A==
X-Gm-Message-State: AOJu0YzghwCELg1FEGTsTbD6Ulsv1QJNx+5qqWNpwFJpotH5YH2Nl7NC
 z0Qa1DzjEVQWsFpngESF1MFCGXCLQOKJx4CmOCCb06CzfOEfL06XfZ1udYRevampDL6WXcCPkfU
 Skvc2Cg==
X-Google-Smtp-Source: AGHT+IE4HaJhsM02YXTaIvAO1D/nHXaKFDRLmhSP6QYPUO1NNGEH+W+CcCuJmnj7iSgL8nQBWjDQTA==
X-Received: by 2002:a05:620a:13fc:b0:78d:61ff:d608 with SMTP id
 h28-20020a05620a13fc00b0078d61ffd608mr6450417qkl.22.1714227085527; 
 Sat, 27 Apr 2024 07:11:25 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 13/18] part: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:11:01 -0600
Message-Id: <20240427141106.3406000-14-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

Remove <common.h> from all "part/" files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 disk/disk-uclass.c | 1 -
 disk/part.c        | 1 -
 disk/part_amiga.c  | 2 +-
 disk/part_dos.c    | 2 +-
 disk/part_efi.c    | 1 -
 disk/part_iso.c    | 1 -
 disk/part_mac.c    | 1 -
 7 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/disk/disk-uclass.c b/disk/disk-uclass.c
index efe4bf1f9490..ee3cc4407d76 100644
--- a/disk/disk-uclass.c
+++ b/disk/disk-uclass.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_PARTITION
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/disk/part.c b/disk/part.c
index 2bee6695828a..bc932526f906 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <env.h>
diff --git a/disk/part_amiga.c b/disk/part_amiga.c
index 65e30fea558d..9b0f2fe74985 100644
--- a/disk/part_amiga.c
+++ b/disk/part_amiga.c
@@ -4,12 +4,12 @@
  * Hans-Joerg Frieden, Hyperion Entertainment
  * Hans-JoergF@hyperion-entertainment.com
  */
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <ide.h>
 #include "part_amiga.h"
 #include <part.h>
+#include <vsprintf.h>
 
 #undef AMIGA_DEBUG
 
diff --git a/disk/part_dos.c b/disk/part_dos.c
index 567ead7511de..e6b5295e0ec4 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -13,11 +13,11 @@
  * http://developer.apple.com/techpubs/mac/Devices/Devices-126.html#MARKER-14-92
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <ide.h>
 #include <memalign.h>
+#include <vsprintf.h>
 #include <asm/unaligned.h>
 #include <linux/compiler.h>
 #include "part_dos.h"
diff --git a/disk/part_efi.c b/disk/part_efi.c
index 4ce9243ef25c..b1a03bd165e0 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -12,7 +12,6 @@
 
 #define LOG_CATEGORY LOGC_FS
 
-#include <common.h>
 #include <blk.h>
 #include <log.h>
 #include <part.h>
diff --git a/disk/part_iso.c b/disk/part_iso.c
index 6ac6d95be921..6e05b2feffba 100644
--- a/disk/part_iso.c
+++ b/disk/part_iso.c
@@ -4,7 +4,6 @@
  * Denis Peter, MPL AG Switzerland, d.peter@mpl.ch.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <command.h>
 #include <part.h>
diff --git a/disk/part_mac.c b/disk/part_mac.c
index db5e203be592..81a65823be99 100644
--- a/disk/part_mac.c
+++ b/disk/part_mac.c
@@ -12,7 +12,6 @@
  * http://developer.apple.com/techpubs/mac/Devices/Devices-126.html#MARKER-14-92
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <memalign.h>
-- 
2.34.1

