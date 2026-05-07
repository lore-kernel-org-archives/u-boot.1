Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FA8CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 12:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD6684A78;
	Thu,  7 May 2026 14:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="D2v8KC+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF9484B07; Thu,  7 May 2026 14:07:46 +0200 (CEST)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6E184A72
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 14:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260507120738fb58baa354000207ac for <u-boot@lists.denx.de>;
 Thu, 07 May 2026 14:07:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=B1ONDcQZc0EmhAKCrcqlizdExyEoD8WrK2NKFQZnvfg=;
 b=D2v8KC+xB5elP/Rin58tFmVqNw3KDhP1w8Y3ICA3Jk9HOiQPxRG9z1kvlHZRUuPFEZbOcT
 1N/GNC/kYMBzMVy+D6IG3Tbu7bDsOvymSPxmwcpajoF9cR/aATvUGIKuP+yL2naINiqHofBA
 eWD3gxqHMD1FmzVD/08r/aU266SpRa4ENub49lLShTVGIHJiRsf+UOgR8faTyFHRZ5PkD2dk
 +efdy7GYj0NBb1KpvO6MUgjvKLu4iXKm2jUfKzpuA92vraGZPEXNq1294HIa3k2Vkb3DjRz3
 rqhO0qUUslBIgtwu5PDCsVMbgqqqQPBtfjme0OhceikBNp7I3N6wxkcw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/4] mkimage: define log_err and log_info
Date: Thu,  7 May 2026 14:06:23 +0200
Message-ID: <20260507140624.v3.2.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
In-Reply-To: <20260507120735.310325-1-ludwig.nussel@siemens.com>
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
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

---

Changes in v3:
- make log_err use stdout too

 boot/image-pre-load.c | 3 ---
 tools/mkimage.h       | 5 +++++
 2 files changed, 5 insertions(+), 3 deletions(-)

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
index 5d6bcc9301a..caa51491f02 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -31,6 +31,11 @@
 #endif /* MKIMAGE_DEBUG */
 
 #define log_debug(fmt, args...)	debug(fmt, ##args)
+#define log_info(fmt, args...)	printf(fmt, ##args)
+/* can't use stderr here as that's unbuffered and would produce
+ * output different from u-boot's console
+ */
+#define log_err(fmt, args...)	printf(fmt, ##args)
 
 static inline void *map_sysmem(ulong paddr, unsigned long len)
 {
-- 
2.43.0

