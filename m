Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C70CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03CD98467E;
	Wed, 13 May 2026 16:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="l0m2byqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E58B846A4; Wed, 13 May 2026 16:10:42 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D0584671
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20260513141038b212320d5f00020737 for <u-boot@lists.denx.de>;
 Wed, 13 May 2026 16:10:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sY8GmOhdDsRwT2OOlQOGzJUCDMzD+4rDWQm4jpnkFWU=;
 b=l0m2byqpI2lcpoKbV+OL0MohHCv97CT0qoSNC38Jj7PDpHNGgwX1dxiYsw6jzltk+VfFGa
 JTFG2ZqGzRBSKzIkwu4KyM1EQv0d0sUdMcSLRqlCTvOxcnAfofhkdD2Ty1kMRCeYYHWBSSdq
 xfjBmJUp0PcPveZZiDWNFhX9+sr/z0aBSQ/evDpiG3n9heGAMrYuzG5J+QYlC4dvvcsenrJU
 j10obnYUptGIQbCpAHyXOtGwIO1GUMjmNNowGC7gTmrtbKmrFn+S14CSch9E46kRQDyk0fjj
 6M9uYmu1Jk2R97NDOinu+7BoKXH9NJHX4wUBVkWIyQLyg9lF6wFPnsKw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/6] mkimage: define log_err and log_info
Date: Wed, 13 May 2026 16:08:12 +0200
Message-ID: <20260513160816.v4.2.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
In-Reply-To: <20260513141027.351280-1-ludwig.nussel@siemens.com>
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

Define log_err and log_info centrally in mkimage.h so any file used in
this context benefits from it.

This patch is in preparation for a change in image-fit-sig.c in the
next patch.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v4:
- fix and reword comment

Changes in v3:
- make log_err use stdout too

 boot/image-pre-load.c | 3 ---
 tools/mkimage.h       | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..cd319ddb777 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -35,9 +35,6 @@ ulong image_load_offset;
  */
 static struct image_sig_info *host_info;
 
-#define log_info(fmt, args...)	printf(fmt, ##args)
-#define log_err(fmt, args...)	printf(fmt, ##args)
-
 void image_pre_load_sig_set_info(struct image_sig_info *info)
 {
 	host_info = info;
diff --git a/tools/mkimage.h b/tools/mkimage.h
index 5d6bcc9301a..d8d292a8098 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -31,6 +31,12 @@
 #endif /* MKIMAGE_DEBUG */
 
 #define log_debug(fmt, args...)	debug(fmt, ##args)
+#define log_info(fmt, args...)	printf(fmt, ##args)
+/*
+ * Use stdout rather than stderr so error messages stay
+ * interleaved with normal output in the order produced.
+ */
+#define log_err(fmt, args...)	printf(fmt, ##args)
 
 static inline void *map_sysmem(ulong paddr, unsigned long len)
 {
-- 
2.43.0

