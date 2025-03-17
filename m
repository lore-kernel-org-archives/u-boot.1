Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B440C28B2F
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17CF81A0C;
	Mon, 17 Mar 2025 04:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181299;
	bh=iT7Ccc71TYihkAIUbpIOQaMGk/MiLnzfrjmH5Nlf7mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qEIR8W3kznbdM1w5G8L9MZYsqM1/GcL1vJa77aZvMqODkfp9RCC4bX4AY8TpzEXUK
	 5Rd1nHkLxlSrvXmSsWKV/jvUhrasWkDjHpwvY80wjiO4i+YFv1J+5wVFJx/7BH2oSA
	 TEaXhezGoKqLpIufOOXThiQYKCbrOuYMRE5vsvhIl7zRsTIls+msSIVFHqxdVU6P6x
	 bGI5ga+L6TuYxs/VIvqocNqiboulXPviXuBOExxzYC78fqO7arcGnjvNZAtunaBxiN
	 0X7qwZDPSonbc5/JiLPLB0z4zNpnTqjFYlpefkF/N76qLAJAM9N9VhijffLMyLhVeH
	 EafIltdIYROJQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23C881101; Mon, 17 Mar 2025 04:14:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5CC81760
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZekQX3uc"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D43C101F7A3D; Mon, 17 Mar 2025 04:14:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181296; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=iT7Ccc71TYihkAIUbpIOQaMGk/MiLnzfrjmH5Nlf7mc=;
 b=ZekQX3ucrHNMLajhrLiU0ldmzU3n/moDtk9p0bgxRBFKj0K0KLctP3pdEWszSclxGMBGoK
 SLiMn5wHjJ+e/5Jq7Pw0z1ZHQDuDTymlDAoiWQjZvNX8DHbul/ByNgiQIi00HjPcYHkhwq
 4uwnMZYg0amdHJHZ450TQ2Guu5tZEpjevn+tPWrGrACIfdpFuUflphSXFejRtT2wFruGcr
 UIirySN9gyOF0Kji+treZxt2F4FZu2B33+Q6B9CUtTsWMGGmOM+cVxCgVnEX9squWTtX/4
 7KpYFHz3olFI3U/FbSSOUEC+5H34KRqXHBJBe2aqOWpXepb1HL6k9CtWBourAg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 04/11] linux: Add generic struct stat {}
Date: Mon, 17 Mar 2025 04:12:43 +0100
Message-ID: <20250317031418.223019-5-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317031418.223019-1-marex@denx.de>
References: <20250317031418.223019-1-marex@denx.de>
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
V3: No change
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

