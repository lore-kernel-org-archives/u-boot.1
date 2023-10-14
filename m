Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F42CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E159986EED;
	Sun, 15 Oct 2023 08:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QzERl7O7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C7E486867; Sun, 15 Oct 2023 08:00:21 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362E186E03
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 07:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-352a3a95271so12959115ab.0
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 22:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697349504; x=1697954304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XVF52gpBhJ/MJgCreuAWhUa3YFXZaO1z4KdXqinsYcI=;
 b=QzERl7O7SfiT5TvgR04cZJnvRuVBjildYlhNTCRI0uMC0p2h/X7DmMz60KvwYOdNS8
 S7jL9X2wIacqdbgVRQeB5Q/wg6kWtrmyZNcT1q5za2cmySwV6dIMlCNnINVqCVrCFjht
 qoPlwNJ0XwznaQq6ntYDSsMtbqCROngf49GxbbBLMn5U604wlm9r3vHqZM99ASe4rz+P
 cp/PCc53jUoMnhUstJiz57gZYeZPNN22gRk6eIutVfKffX2VJ8NZ7PpEQR2T0/H/lRe/
 P8/N5sM+/raHzxgoVDQrnydXFveZ27P5sg+2TNuqNTtcQ+chHZVg2pNkfkvnBbMHMCVP
 ClBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697349504; x=1697954304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XVF52gpBhJ/MJgCreuAWhUa3YFXZaO1z4KdXqinsYcI=;
 b=F+luVhSrXOvqXz6Jjh00pHmfPFn897pJlRMiRgE1A50WFc6TUAoljf00Mi6bPkM1ut
 YfguNa+7643TxvGtthjq0ASpoj4k5odkb99yHuZX6nM8+Xa2gexk7bRutCJ8EE+ucC3l
 NXZFIdY8wzAxI9TBTvnvhwEkixcgFicI+hMUKzQz45j2YXy8kdNzA6ER6JhbXEER4VVa
 Xdo/9JuT7xB3zveyg2i1MthVDX3hSkwgj+jahAPzWw5E4H0wVJ8VsqDuo2iC1AHLVhon
 yr2uNO7Ju733G63hcHtNBJW0xWIETAK9DQ94tmMGL06wZ5HTociBnmysTFXtNawZ3GC1
 OGdQ==
X-Gm-Message-State: AOJu0YxFr3oI7GjVNIw3RT0kHN/q4fYS5oNhtVKLh3njaMK338uYNRtu
 PcmZDHFI9lQE8EaVDnQgOs7MJLVt7CMsdg==
X-Google-Smtp-Source: AGHT+IF0lfWHfPtN4BB9MZKJHglzzqV2/L6Na5jU/9y7PW5totCaRgEAEa6qiWEblo5J8gcTYYUJTw==
X-Received: by 2002:a05:620a:2452:b0:76c:b293:84f with SMTP id
 h18-20020a05620a245200b0076cb293084fmr37776990qkn.21.1697316503811; 
 Sat, 14 Oct 2023 13:48:23 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 f2-20020a05620a12e200b007770d47c621sm1720643qkl.66.2023.10.14.13.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:23 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 14/29] fs: ext4: Add some defines for testing
Date: Sat, 14 Oct 2023 16:47:50 -0400
Message-Id: <20231014204805.439009-15-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

Add various defines which are not necessary for reading/writing
filesystems, but which are useful for creating them. These mostly come from
Linux v6.5-rc2 (what I had checked out).

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Split off from fs test

 include/ext4fs.h     |  1 +
 include/ext_common.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/ext4fs.h b/include/ext4fs.h
index cb5d9cc0a5c..dd66d27f776 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -31,6 +31,7 @@
 struct disk_partition;
 
 #define EXT4_INDEX_FL		0x00001000 /* Inode uses hash tree index */
+#define EXT4_TOPDIR_FL		0x00020000 /* Top of directory hierarchies*/
 #define EXT4_EXTENTS_FL		0x00080000 /* Inode uses extents */
 #define EXT4_EXT_MAGIC			0xf30a
 #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM	0x0010
diff --git a/include/ext_common.h b/include/ext_common.h
index 30a0c248414..b09bbde116a 100644
--- a/include/ext_common.h
+++ b/include/ext_common.h
@@ -35,6 +35,16 @@ struct cmd_tbl;
 #define EXT2_PATH_MAX				4096
 /* Maximum nesting of symlinks, used to prevent a loop.  */
 #define	EXT2_MAX_SYMLINKCNT		8
+/* Maximum file name length */
+#define EXT2_NAME_LEN 255
+
+/*
+ * Revision levels
+ */
+#define EXT2_GOOD_OLD_REV	0	/* The good old (original) format */
+#define EXT2_DYNAMIC_REV	1	/* V2 format w/ dynamic inode sizes */
+
+#define EXT2_GOOD_OLD_INODE_SIZE 128
 
 /* Filetype used in directory entry.  */
 #define	FILETYPE_UNKNOWN		0
@@ -48,6 +58,10 @@ struct cmd_tbl;
 #define FILETYPE_INO_DIRECTORY		0040000
 #define FILETYPE_INO_SYMLINK		0120000
 #define EXT2_ROOT_INO			2 /* Root inode */
+#define EXT2_BOOT_LOADER_INO		5 /* Boot loader inode */
+
+/* First non-reserved inode for old ext2 filesystems */
+#define EXT2_GOOD_OLD_FIRST_INO	11
 
 /* The size of an ext2 block in bytes.  */
 #define EXT2_BLOCK_SIZE(data)	   (1 << LOG2_BLOCK_SIZE(data))
-- 
2.37.1

