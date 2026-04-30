Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC5CFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B1C8464D;
	Thu, 30 Apr 2026 14:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="if1zqHzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 223C6803C6; Thu, 30 Apr 2026 14:26:46 +0200 (CEST)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4649C83693
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202604301226442b4d15666800020712 for <u-boot@lists.denx.de>;
 Thu, 30 Apr 2026 14:26:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jQMDvmVUtXBudJ6npZmQkwtfP21WCE7LxaqBwwze4Y4=;
 b=if1zqHzZsuaH6kfl8q9V0sksQBCRcVkBMI3eINVOpmV//T5YJBVuHwey2OPv0WiAxXwpPX
 +GFNAYt2B/3fOqdi9Ip9V4QT8wSxPeLiGplAUNu0XypmrqE9Gz9EigYyq+cdx/lofEivD7L/
 rO5jLCPzXduqm3nFKG5Mellhw6P8ZXNtTspJ7OL7F3CPlgY5U/ZO2LwiMapmlHBLnU5K+EsV
 F7Dv6XSpDQ1z8NpE75AlmgCiDvkW1UjEi4sjx5Kk/ZHU36fswECYTOWPQizHvSsBqz1EQ/I6
 oeKG3GzJe1YLDXDSnE+v6Kx3Ddr0DngwsBjTP+ZelYd0Ra5WyJcfcI3Q==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/4] mkimage: define log_err and log_info
Date: Thu, 30 Apr 2026 14:26:01 +0200
Message-ID: <20260430142602.v2.2.2405ba52fddd2e9ff1bbc24585e1e3140f660637@changeid>
In-Reply-To: <20260430122629.606153-1-ludwig.nussel@siemens.com>
References: <20260430122629.606153-1-ludwig.nussel@siemens.com>
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

Define log_err an log_info centrally in mkimage.h so any file used
in this context benefits from it.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>

---

(no changes since v1)

 boot/image-pre-load.c | 3 ---
 tools/mkimage.h       | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

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
index 5d6bcc9301a..62fbfcacbb3 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -31,6 +31,8 @@
 #endif /* MKIMAGE_DEBUG */
 
 #define log_debug(fmt, args...)	debug(fmt, ##args)
+#define log_info(fmt, args...)	printf(fmt, ##args)
+#define log_err(fmt, args...)	fprintf(stderr, fmt, ##args)
 
 static inline void *map_sysmem(ulong paddr, unsigned long len)
 {
-- 
2.43.0

