Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C6CCCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:32:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EECB2836B4;
	Wed,  1 Oct 2025 22:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q4yCqJV/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF29836A7; Wed,  1 Oct 2025 22:30:57 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1507A836A7
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7ae21804971so113280a34.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350654; x=1759955454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VOgiun4n8RNxiEhyzgtVZCzJe2GarRWsLhYt5w78nvg=;
 b=Q4yCqJV/fHkLsVV5USXDnN0jfy4jTlQf1UQL3dKYJSuAxsXgxaofWuNvlsAQiTUAvk
 95kfwSfj/tfyq0FKawYPBzYMFHYUZnlpGfojouqOhrFmP+ApWJmFgIGHpW6nTXO+FTVf
 wJE2wtLu4MnIzfniiE7j+sxoUxosaZOCINCn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350654; x=1759955454;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VOgiun4n8RNxiEhyzgtVZCzJe2GarRWsLhYt5w78nvg=;
 b=ll+1gFVI+sr/mzUAmVIoN7K8i+zW0vWxnJIfpZ+YXUN5J6HuylPXlHUTFxQ2RKWS5O
 82ZVMVCwJs2xzsrSc0vhxS2eLg5W2F9pSpAyD/3i6aPq/5l1BpVipy9UNwMcZLlczFZq
 T8QldHXrcSpaJLHj8NEGQw89VyBpsT+iGSpDo5s/UeyLqHyDiOHJ9OyCQH47YoxDvAiz
 EZWaRYUInaeB3dzV+7roaeFc+w/Y4Q7YpB1FFCQAzkCeN/hv169aO5/k4nJxmLxSd5nS
 67y+QgJ6dUEmJWH5qcNrLGlTnG/gHnw+v8O/D3ZdRcrGgrA9ivWH4skQAErAiGVn/WkS
 /Z6A==
X-Gm-Message-State: AOJu0Yw+VGvV18Plf+cWa+cm22PFSF69xz9JNzq5AW15JO98e/Macs6b
 JXF5AcZyYP57Pu3NEPRnApaPIFWDkqkhIPO3nHiCyUvVQydeet3ts6DbiFNATfzJT3iKqsESuBB
 8qy6K/kQ=
X-Gm-Gg: ASbGncvAmtsLckgi2Zn5WBAK6GVJZMC+PEiUrn6A7BFCX+TNgEmbN+DTdbIbPoQgzjo
 zAPZN6MvObA7BmlUsGMDnLkyR2fHLwFXssRR0FLbx6eCo6REpoV7xt8w9g3qna3EiQ3FHVOlwnm
 YibowB+plY7iaoQbU6/pTIhcMP4LQNyo7gr7vcgPjiEefof588IN3DUIrAXR7XaurAq0BQylxh2
 cgsa1m56ot9TtIKrDWpb0b6JkiIpymovaYjS/LZ/lPN76liGTJQYDgX8ZaZSK1/FpJAs3H27bu1
 cbvCPJC6VsmH+M2V0tTyZs5T14fb+fCsAtUty32TPbwWQY2zOjdHYeZSXYnUzp8d5Bs5WYvB81t
 CH2rpXLW9CW4UUn6Kxag0MpCgPA8J4Z2iL6RJgsBxpRGREBr+rJp/dJKEnA8Br26tFj7KkDZqRO
 cFuaNA6CA=
X-Google-Smtp-Source: AGHT+IFTEk9fzuyT/n0iHYv+9EOBtK8eQw5uEf8K+ANtzGfoqxU/NqYttZ4YktYpDy7vUxtudXMZzw==
X-Received: by 2002:a05:6830:3c0d:b0:7b3:5908:34d8 with SMTP id
 46e09a7af769-7bdda0883e0mr3283255a34.11.1759350653690; 
 Wed, 01 Oct 2025 13:30:53 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e1bc8058bsm101285eaf.20.2025.10.01.13.30.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] iotrace: Finish migrating this to Kconfig
Date: Wed,  1 Oct 2025 14:30:52 -0600
Message-ID: <20251001203052.2828467-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

When I migrated this to Kconfig in commit 68e54040ccc3 ("sandbox: Move
CONFIG_IO_TRACE to Kconfig") I didn't look hard enough for other
details. As explained in the README, this is valid for ARM too. So start
by making this be a prompted question and CMD_IOTRACE depend on IO_TRACE
being enabled.  Next, migrate the information out of README and in to
the appropriate help text for existing options in Kconfig. Finally, make
this option be default y on SANDBOX but not selected as it's valid to
build without it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 README         | 22 ----------------------
 arch/Kconfig   |  1 -
 cmd/Kconfig    | 11 +++++++++++
 common/Kconfig | 11 ++++++++++-
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/README b/README
index 27cde241bef4..20a73bab802c 100644
--- a/README
+++ b/README
@@ -300,28 +300,6 @@ The following options need to be configured:
 		Note that if the GPIO device uses I2C, then the I2C interface
 		must also be configured. See I2C Support, below.
 
-- I/O tracing:
-		When CONFIG_IO_TRACE is selected, U-Boot intercepts all I/O
-		accesses and can checksum them or write a list of them out
-		to memory. See the 'iotrace' command for details. This is
-		useful for testing device drivers since it can confirm that
-		the driver behaves the same way before and after a code
-		change. Currently this is supported on sandbox and arm. To
-		add support for your architecture, add '#include <iotrace.h>'
-		to the bottom of arch/<arch>/include/asm/io.h and test.
-
-		Example output from the 'iotrace stats' command is below.
-		Note that if the trace buffer is exhausted, the checksum will
-		still continue to operate.
-
-			iotrace is enabled
-			Start:  10000000	(buffer start address)
-			Size:   00010000	(buffer size)
-			Offset: 00000120	(current buffer offset)
-			Output: 10000120	(start + offset)
-			Count:  00000018	(number of trace records)
-			CRC32:  9526fb66	(CRC32 of all trace records)
-
 - Timestamp Support:
 
 		When CONFIG_TIMESTAMP is selected, the timestamp
diff --git a/arch/Kconfig b/arch/Kconfig
index 7e05e0c22634..3133f892f945 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -202,7 +202,6 @@ config SANDBOX
 	select DM_SPI
 	select DM_SPI_FLASH
 	select GZIP_COMPRESSED
-	select IO_TRACE
 	select LZO
 	select MMC
 	select MTD
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5e5252ef1347..761b126e3271 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1308,12 +1308,23 @@ config CMD_IO
 
 config CMD_IOTRACE
 	bool "iotrace - Support for tracing I/O activity"
+	depends on IO_TRACE
 	help
 	  Provides an 'iotrace' command which supports recording I/O reads and
 	  writes in a trace buffer in memory . It also maintains a checksum
 	  of the trace records (even if space is exhausted) so that the
 	  sequence of I/O accesses can be verified.
 
+	  Example output from the 'iotrace stats' command is below.
+
+		iotrace is enabled
+		Start:  10000000	(buffer start address)
+		Size:   00010000	(buffer size)
+		Offset: 00000120	(current buffer offset)
+		Output: 10000120	(start + offset)
+		Count:  00000018	(number of trace records)
+		CRC32:  9526fb66	(CRC32 of all trace records)
+
 	  When debugging drivers it is useful to see what I/O accesses were
 	  done and in what order.
 
diff --git a/common/Kconfig b/common/Kconfig
index 30bf225362ee..0c25a8fc866e 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1264,4 +1264,13 @@ config VPL_IMAGE_SIGN_INFO
 endif
 
 config IO_TRACE
-	bool
+	bool "Intercept and checksum all I/O accesses"
+	depends on ARM || SANDBOX
+	default y if SANDBOX
+	help
+	  When enabled, U-Boot intercepts all I/O accesses and can checksum
+	  them or write a list of them out to memory. See the 'iotrace' command
+	  for details. This is useful for testing device drivers since it can
+	  confirm that the driver behaves the same way before and after a code
+	  change. To add support for your architecture, add '#include
+	  <iotrace.h>' to the bottom of arch/<arch>/include/asm/io.h and test.
-- 
2.43.0

