Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E51FD88C3
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 22:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D68283FBC;
	Tue, 10 Mar 2026 23:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="T1p+23Tg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3705083FC1; Tue, 10 Mar 2026 23:06:36 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9817E83FA4
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 23:06:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-358d80f60ccso7383090a91.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1773180390; x=1773785190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r+T5GP83B2f/2lg++VGjyykxbfKzCSL83pbgwvMwDnE=;
 b=T1p+23TgB7AtxOy4Sn9jo7Pqis6x2SfD+P2o9eGLkPbdgkiyvjFA6AR//it1sSbMx4
 5yI7QHJ4r8PszCu4eFcrkeC1XnZvC0dw8BbULCje/Cujsot8jZ9m7u7X+WrZvcAklOBy
 O7zeDht7JGKUU4wtkPGGVBW6N5vvv/4d6/pOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773180390; x=1773785190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+T5GP83B2f/2lg++VGjyykxbfKzCSL83pbgwvMwDnE=;
 b=iVPfO2vruTtkz0kIlBaGtkUAggIIepen7rpifL3UOEQn+C1Wy04Ww/TOLpeS9JcRjV
 kRzZvwuwCgTwvtWfxNlUM09RAfYR9DRAVVbfpInYiFhGHY18eoA752/wlFLwkSYPTo4o
 9IQJPxno4VB1nAS5FdfMhLt6b6dhT0ck7HsvNZPd58tMW7gQHKyRl2KoXEJhvmxJa0/N
 DNC5aati3yvhawY46vtr3az0Tm90Er1DnkUbWFfBQefsDenkJm2vyCDRdXRQn5cv+5RQ
 VMX+5ato+Zd1tZmzHIonX4Gqb/24IvjoF/NACmd/zNg1EabdDr3yRaGFLWZImDlRtn90
 7QqA==
X-Gm-Message-State: AOJu0YzAdn2imok6cYZndIDDnQ63MNDlaY9k2KzisQf6yFN17qzux49Y
 pElOOF+OCbAkj6qw8XVCVrU3TtFwltGL2RmiKC+XCHg7nf/YCL+THwOe7W/K5TZvWA1Vh72WLXn
 oWl60
X-Gm-Gg: ATEYQzwocruEf1w7a+4t/BkLHHVjzgbCHdb5B0coFrC4Kgt2D4ig4gPIkBMqHZXvCsj
 9dLFwTw5Ek/TpgMFUnPb51BoH+MnsdB01xpwUf9CK256ZAhoLBkCkQnsAUWjBWHw0RZsxVNceP9
 k9sCK7oey255njn6L/UwDM/jVELMbsTs34bZhQ0NdLJff3+cFLC+5+Fe0tWy9bf00f0CADJjpUr
 5q1JfYmfxKpPyEqRwXtiiYZlffdmDmPWoL4FuzzQ759gt7YkfL2GVKhPI6H29lDQqpqEKW7qrET
 dTGLpy8TwoaazuNwU7tEYWQuKC5OV78W0LM//l2U3NYQk3r3PJUWfvO32rkO2hbxm19s0GGgsEE
 IWPMdrm7ks7Q92MHruWOXJjJbNCeLGF2EDiwQFZaTZv536vdssEoaeg0Ph1CEox1qsD93VJEFQf
 zrKWzIH5jjnvrkag==
X-Received: by 2002:a17:90b:2fcf:b0:356:7b41:d348 with SMTP id
 98e67ed59e1d1-35a012df63bmr326495a91.20.1773180390467; 
 Tue, 10 Mar 2026 15:06:30 -0700 (PDT)
Received: from kinako ([2400:2200:2da:3879:3cf2:df32:3c60:892e])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35a02fc845asm68040a91.11.2026.03.10.15.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 15:06:30 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: u-boot@lists.denx.de
Cc: Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] fs: fat: Refactor dirty flag handling
Date: Wed, 11 Mar 2026 07:06:18 +0900
Message-ID: <20260310220619.1762455-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
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

Refactor the dirty flag handling a little bit so an inline
function is called instead of directly stuffing a value into
the variable.

This allows variable that holds the flag to be completely removed
if its not used i.e. CONFIG_FAT_WIRTE=n

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 fs/fat/fat.c       |  2 +-
 fs/fat/fat_write.c |  9 ++++-----
 include/fat.h      | 26 ++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 9ce5df59f9ba..1f05533a3781 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -690,7 +690,7 @@ static int get_fs_info(fsdata *mydata)
 	}
 
 	mydata->fatbufnum = -1;
-	mydata->fat_dirty = 0;
+	fat_mark_clean(mydata);
 	mydata->fatbuf = malloc_cache_aligned(FATBUFSIZE);
 	if (mydata->fatbuf == NULL) {
 		debug("Error: allocating memory\n");
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 0b924541187c..e1b5b32bfcbf 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -223,9 +223,9 @@ static int flush_dirty_fat_buffer(fsdata *mydata)
 	__u32 startblock = mydata->fatbufnum * FATBUFBLOCKS;
 
 	debug("debug: evicting %d, dirty: %d\n", mydata->fatbufnum,
-	      (int)mydata->fat_dirty);
+	      (int)fat_is_dirty(mydata));
 
-	if ((!mydata->fat_dirty) || (mydata->fatbufnum == -1))
+	if (!fat_is_dirty(mydata) || (mydata->fatbufnum == -1))
 		return 0;
 
 	/* Cap length if fatlength is not a multiple of FATBUFBLOCKS */
@@ -248,7 +248,7 @@ static int flush_dirty_fat_buffer(fsdata *mydata)
 			return -1;
 		}
 	}
-	mydata->fat_dirty = 0;
+	fat_mark_clean(mydata);
 
 	return 0;
 }
@@ -484,8 +484,7 @@ static int set_fatent_value(fsdata *mydata, __u32 entry, __u32 entry_value)
 		mydata->fatbufnum = bufnum;
 	}
 
-	/* Mark as dirty */
-	mydata->fat_dirty = 1;
+	fat_mark_dirty(mydata);
 
 	/* Set the actual entry */
 	switch (mydata->fatsize) {
diff --git a/include/fat.h b/include/fat.h
index bdf430f70675..40da0370a444 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -165,7 +165,9 @@ typedef struct {
 	int	fatsize;	/* Size of FAT in bits */
 	__u32	fatlength;	/* Length of FAT in sectors */
 	__u16	fat_sect;	/* Starting sector of the FAT */
+#ifdef CONFIG_FAT_WRITE
 	__u8	fat_dirty;      /* Set if fatbuf has been modified */
+#endif
 	__u32	rootdir_sect;	/* Start sector of root directory */
 	__u16	sect_size;	/* Size of sectors in bytes */
 	__u16	clust_size;	/* Size of clusters in sectors */
@@ -190,6 +192,30 @@ static inline u32 sect_to_clust(fsdata *fsdata, int sect)
 	return (sect - fsdata->data_begin) / fsdata->clust_size;
 }
 
+static inline void fat_mark_clean(fsdata *fsdata)
+{
+#ifdef CONFIG_FAT_WRITE
+	fsdata->fat_dirty = 0;
+#endif
+}
+
+static inline void fat_mark_dirty(fsdata *fsdata)
+{
+#ifdef CONFIG_FAT_WRITE
+	fsdata->fat_dirty = 1;
+#endif
+}
+
+static inline bool fat_is_dirty(fsdata *fsdata)
+{
+#ifdef CONFIG_FAT_WRITE
+	if (fsdata->fat_dirty)
+		return true;
+#endif
+
+	return false;
+}
+
 int file_fat_detectfs(void);
 int fat_exists(const char *filename);
 int fat_size(const char *filename, loff_t *size);
-- 
2.51.0

