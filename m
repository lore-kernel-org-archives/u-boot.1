Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE20C35FF1
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B68981B5C;
	Thu, 13 Mar 2025 20:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741893262;
	bh=lWWyf44Mdnb1+q9q25jTFad+9N4V2MupXODleO6/J20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HBaku64gStQmeHhciPU5ENaL+V2dXp9ZQYqNkrkXY1KI3SWNqzPvj72szp7cddD9N
	 vK8kojDR0yz5myqu1kQHKjoa0XKrh/JmrcV8BcrQzXyd7fZOIQoxdvG1viiz1Y8Fpi
	 XrVZXhWG/gwz5XFy0qBKIc7DNK1Zx7vaZfhaU70sSqmUesKeL4a7Si2Y56fyAnJtz+
	 vPw+p5NdXhMSdo7epKyNFUMdCXlZ2UOwdXtnhTjVphgdx3viuKKcLUKpBSM9NCGX7v
	 6pBwPZs8P4orm/MbF8im8kks1/o+m67CYOAjWAGd5aNuW7Zxhb7tHD/EhfUKerp9tX
	 1YEit9sikCY6g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9468191C; Thu, 13 Mar 2025 20:14:17 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF39C8191C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:14:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="J0a4C/br"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 70A97101FF34E; Thu, 13 Mar 2025 20:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741893254; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=lWWyf44Mdnb1+q9q25jTFad+9N4V2MupXODleO6/J20=;
 b=J0a4C/brwwxZNaGoVtiwTPs0OWsA2kQXch6RrKfC6srAngJXIhp95AASq0NFvrnBSQFuD4
 tHBlZpYHhueEGedlYRg3ZuzTN6g/WtltkT8h2iHTL0EwsjtavbsE/S/RGyTTUQ8irz2jIa
 jKHibglb+JQiw7KGcaD1Hgiveh0kla48H75FzDGuVStRE/6FBHY49INMhNt7L0JTDYoGhQ
 vYQM0QwnTz4GlQdhq7UIEUxWQteh2E1e63jaF1jDEq0Gwsd8moYMyafjAyeLB0JdWPlugL
 ksnSD6q32LzKg0d0a+4WQ54ZHw/mY2P9qzpMoWVfzGLtSnAup2XSzPo6zDdGlw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/11] linux: Add generic struct stat {}
Date: Thu, 13 Mar 2025 20:13:20 +0100
Message-ID: <20250313191348.170054-5-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313191348.170054-1-marex@denx.de>
References: <20250313191348.170054-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add generic implementation of struct stat {} imported from Linux 6.13.y
commit 27560b371ab8 ("fs: pack struct kstat better"). This can be used
by filesystem code imported from elsewhere. Now struct stat {} becomes
available on all supported architectures.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 include/linux/stat.h | 45 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/linux/stat.h b/include/linux/stat.h
index 5eba6334e60..b65bff7e97d 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -65,9 +65,7 @@ struct stat {
 	unsigned long	__unused5;
 };
 
-#endif	/* __PPC__ */
-
-#if defined (__ARM__) || defined (__I386__) || defined (__M68K__) || defined (__bfin__) ||\
+#elif defined (__ARM__) || defined (__I386__) || defined (__M68K__) || defined (__bfin__) ||\
 	defined (__microblaze__) || defined (__nios2__)
 
 struct stat {
@@ -93,9 +91,7 @@ struct stat {
 	unsigned long  __unused5;
 };
 
-#endif	/* __ARM__ */
-
-#if defined (__MIPS__)
+#elif defined (__MIPS__)
 
 struct stat {
 	dev_t		st_dev;
@@ -124,9 +120,7 @@ struct stat {
 	long		st_pad4[14];
 };
 
-#endif	/* __MIPS__ */
-
-#if defined(__SH__) || defined(__XTENSA__)
+#elif defined(__SH__) || defined(__XTENSA__)
 
 struct stat {
 	unsigned long st_dev;
@@ -149,7 +143,38 @@ struct stat {
 	unsigned long  __unused5;
 };
 
-#endif /* __SH__  || __XTENSA__ */
+#else
+
+/*
+ * Everybody gets this wrong and has to stick with it for all
+ * eternity. Hopefully, this version gets used by new architectures
+ * so they don't fall into the same traps.
+ *
+ */
+struct stat {
+	unsigned long	st_dev;		/* Device.  */
+	unsigned long	st_ino;		/* File serial number.  */
+	unsigned int	st_mode;	/* File mode.  */
+	unsigned int	st_nlink;	/* Link count.  */
+	unsigned int	st_uid;		/* User ID of the file's owner.  */
+	unsigned int	st_gid;		/* Group ID of the file's group. */
+	unsigned long	st_rdev;	/* Device number, if device.  */
+	unsigned long	__pad1;
+	long		st_size;	/* Size of file, in bytes.  */
+	int		st_blksize;	/* Optimal block size for I/O.  */
+	int		__pad2;
+	long		st_blocks;	/* Number 512-byte blocks allocated. */
+	long		st_atime;	/* Time of last access.  */
+	unsigned long	st_atime_nsec;
+	long		st_mtime;	/* Time of last modification.  */
+	unsigned long	st_mtime_nsec;
+	long		st_ctime;	/* Time of last status change.  */
+	unsigned long	st_ctime_nsec;
+	unsigned int	__unused4;
+	unsigned int	__unused5;
+};
+
+#endif
 
 #ifdef __cplusplus
 }
-- 
2.47.2

