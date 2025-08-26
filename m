Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80E9CA0FE7
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 19:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 337A08313F;
	Tue, 26 Aug 2025 21:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PXjuWGDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5341C83145; Tue, 26 Aug 2025 21:46:13 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40745830F6
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 21:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e96dd4bd847so1047699276.0
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 12:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756237570; x=1756842370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tpYpQBH17vzsBxON1MLvQIQgtg2jqkbnw8K/uxA7jjY=;
 b=PXjuWGDImvQg41n6v/SuP3TliuSM3aIgKYtUYkgd+3M7j8j4tutNiRho32aT0suue1
 ocFXeJGugRPlQoWU44pZwL14E44wUE42Fef99Obs1wCmF0Ydo9hGPJsGJ9SnNciPj+/c
 G0I6FTUBXA6DYwBgNRoxpNK5PF2mJhPbYCJCiY/ZVtmu9ymAUiQ9nT7zRTw5S2leLDFE
 wkhvErEab9F0TWnPT6zPqRm1GjE821EZ8yiVigRdgnj/eCyRYxVVQzaWZ5u9aQ4B2H/j
 xfBBdIQ5qDpbA7KWPTJ3EFrhN6AIEZI1UyJbeeKYdVmMDBL4A9g5l0iZ2IAnpxq8i6Vv
 jvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756237570; x=1756842370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tpYpQBH17vzsBxON1MLvQIQgtg2jqkbnw8K/uxA7jjY=;
 b=wpoEIjd6/nMf6iy/WThwdr3JfsivT5WXm3rlp4L27kSm/tier75UksVDYkDWBdNd6A
 OAIvVSvZXy6EC0gpEN3izW35iNw2T7FN7PgMa2YbhP3wmIyrdvd5V0fR2e/5kn27xNeG
 moeakPSv2TTFwbn2akJOSb0tEcxiFbgBVQXXyVaxlPp++d5WsBn6KWVv6nJn9LK5dYjB
 RpALgUE5T31WFLuZHhxhJJ6zBARO+RYDoFeru8FPo1+YbF/b8mbk6GAW4qgPRf0BYgBa
 RFMQ0s969tqqMgwQOu2yIVhJpGfI8+/7IJbkGREaKbx4aFz6sVnydgvNjrUhQstSNeHW
 psMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS8g9anla+hbVKkVTjwaIGLRT/hddAEoeD58ebt4jzchCadZ5ysooQf1tZbxYwQBT33X6BLqk=@lists.denx.de
X-Gm-Message-State: AOJu0YxFZmS8WshffhErzqMNJsFwbIUvggJFlpvNXt2taL6NnzrdXWrt
 vp1ScEoO3CnVDF+cjyFAIfq5TaENYGagSqxoWAOpPhO+n1pEfJoRtbLRpKxiSg==
X-Gm-Gg: ASbGncvVVAO0RF5NJ/1bY6sJLIebLgIDeMf2/uM9GYZIeQX6ZHswrfnV6KPGAx70aGo
 nvHIQDiBOEL6WdmU+CQgXTTJDqjXwopcpou4TxHU6FiE/mzUfncfASC1PeIcf30a0cYlf8yJGVV
 dNGyoIoK0s+zjtvx6fnz/PAodM+Ezliz1Hv/3r6vDpdrp8khbm1y43w92MQh36OFf3wB0vQM91C
 yuFMiAcZCmqS6ZcPJSeZXmlbvHmMwgQolkt0wafVTmV4eo9L6dts2AyNalpjcrXeHDcBHd7gfps
 fMwuliafPeCXsYlO/gdyv373U1foDnlkzgVk/+c9UaPFciLokvERdDLphYXqgB4tInViznY0JxK
 d2neBXaX2x9faKDz06zrv3Jhulv+y66lhNAmSeLavDfqTqMsIT84KgQY3icfiEDT8UlfJYjkPkK
 LFKnV7ZjX15Q==
X-Google-Smtp-Source: AGHT+IEzqJWpIBV2xLfqHfiTYHP3VxkSzFKlN0SDu8LJ35SpMWdgRU7y+Em0LKV/1+4JRK1GutM7Gw==
X-Received: by 2002:a05:690c:6704:b0:721:391d:8ede with SMTP id
 00721157ae682-721391d9f27mr27574857b3.23.1756237569824; 
 Tue, 26 Aug 2025 12:46:09 -0700 (PDT)
Received: from localhost.localdomain
 (76-229-100-169.lightspeed.irvnca.sbcglobal.net. [76.229.100.169])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7213998fedfsm3388197b3.32.2025.08.26.12.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 12:46:09 -0700 (PDT)
From: Tony Dinh <mibodhi@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: [PATCH] fs: ext4fs: add CONFIG_EXT4_MAX_JOURNAL_ENTRIES to Kconfig
Date: Tue, 26 Aug 2025 12:45:37 -0700
Message-Id: <20250826194537.20788-1-mibodhi@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Add maximum ext4 journal entries to Kconfig. It is necessary since the
number of journal entries is proportional to disk capacity. For example,
an ext4 4TB HDD partition could require approximately 500 entries.

Signed-off-by: Tony Dinh <mibodhi@gmail.com>
---
 fs/ext4/Kconfig        | 8 ++++++++
 fs/ext4/ext4_journal.h | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 8ddaebebd48..a2faa9f878a 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -12,3 +12,11 @@ config EXT4_WRITE
 	help
 	  This provides support for creating and writing new files to an
 	  existing ext4 filesystem partition.
+
+config EXT4_MAX_JOURNAL_ENTRIES
+	int "Maximum numbers of journal entries for ext4 filesystem"
+	default 100
+	depends on EXT4_WRITE
+	help
+	  This provides support for allocating the maximum number of
+	  journal entries in disks formatted with ext4 filesysyem.
diff --git a/fs/ext4/ext4_journal.h b/fs/ext4/ext4_journal.h
index 43fb8e76641..a492df49fbe 100644
--- a/fs/ext4/ext4_journal.h
+++ b/fs/ext4/ext4_journal.h
@@ -38,7 +38,7 @@
 #define EXT3_JOURNAL_FLAG_LAST_TAG	8
 
 /* Maximum entries in 1 journal transaction */
-#define MAX_JOURNAL_ENTRIES 100
+#define MAX_JOURNAL_ENTRIES CONFIG_EXT4_MAX_JOURNAL_ENTRIES
 struct journal_log {
 	char *buf;
 	int blknr;
-- 
2.39.5

