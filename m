Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047FECD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 17:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3120846BC;
	Thu, 14 May 2026 19:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MK8Bshz4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF3C8467C; Thu, 14 May 2026 19:55:09 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F9D58469A
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 19:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-479d68a9063so3152089b6e.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 10:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778781305; x=1779386105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5KfgDEAtgnZsk7+w8PJsFXqlE+wveHRiTNoAse/Cduk=;
 b=MK8Bshz4BvoYwU5vJAjmW+QwA9Mw273woK15clJYeo8keOfhDxL2IOO+ZyXvdXYlgN
 CbOBykDl3rWGbu/bQkDBYYrZGj1KUlavVTZtWQRUjPYU3mCnXlj78qp3SRA+rxr2LW0k
 zpB50wPW7qy6fXbT8W8PLkqKZHoOIUX9xZprE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778781305; x=1779386105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5KfgDEAtgnZsk7+w8PJsFXqlE+wveHRiTNoAse/Cduk=;
 b=TBh9OPgiDA+2MphuDLnK3lWcmttY/oEGae07jtPY44b/Z42EYPDe/4Jw5QhHrxh2YL
 3JqoyWAojC9lDzt1ig+nvv/mx+048X4eZGmEbK/qYfcWuBo1vB5WNovZtJl913KxWoZL
 I9GNp0TPB45tVKjhRjZ2S/jRDIUPOXj35/OypIDK/GtKUjSNKGSYFLaRcNdKsClJlFkQ
 AKyt1cqtP//ndpSWnLUhxjl/rf2PHxMGapWNQh4ghC5RQd0mRWo0aYwljlPvIi+ecRNP
 68XGV42jKmKwr6keB5nFOiishfwVGJBaKmpuwJaDjxOuT8Ha1j/X+yF6EIj8wk4EruD2
 iasQ==
X-Gm-Message-State: AOJu0Yzhdxp3ypX+dTIUYglyP/rZLU/fgJsGtgU+sAYR4K6Nxc2kijqd
 Y9pQNnNfTaJ1ZjiaJwbL/HDO315iAqk8LLMc1jn3QVR3UnossoEYLkNbsaN2lIuxYmfRGnyosd8
 UWa1lXcFZpO/a
X-Gm-Gg: Acq92OH0TaRQpeEqCiS5WH2Sq03QY8x1dluZXshd7370Pxma+494LsEwaoqSRqU7N3e
 uPf9H4IL3iWGC+n9mnpOhMU9osXLBuSWvp4HJcQEMCVmfm2KDAyJjLwhcNF1V7W0b34nTmI88UZ
 dawGnhVAzE5qedhPEFOTafoMwcH/fe9k236Y8WT+pp+ZHQPtay9kt0qgRGO4ryvH6DRJwuOPZw9
 8V1nFgRC+Avpuz8h4dfIvss9TMSsxLhV+40GKoCFNOOZ7T+39q8WZEeWc/T5qo33vABri0FMoft
 nly2kOXWC1U408kTVf9b8PoGgAn59JHS+N4UM75iHxXTCdFiebZM2vovDTPI1dujUvEOW/aRKJI
 Y6aUX1tKepkak1KOTXY2c1Y8ixVCR7syM+Owlho1HWnHmG54FHAj5EnQNLs+SIl9UQE15DkDni+
 C9K5q0u0YSLOCTEJ5zVLwHSbgtEWHPaUp2ZKPiWq3cfa9TGUxmhd2cFZ93eEAJyFotDf9S+cWzh
 QixkTUnQ9si3mLtaDhEnVt+xwCQyOyz0tZJpRyWjoUOV3/kpi2aPccbSJI88y9KfLve1r55ofc=
X-Received: by 2002:a54:4e88:0:b0:46c:e542:cc3e with SMTP id
 5614622812f47-482e55e65a9mr247836b6e.6.1778781304960; 
 Thu, 14 May 2026 10:55:04 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-482d379f062sm1758710b6e.6.2026.05.14.10.55.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:55:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/3] bloblist: Rework bloblist_init and bloblist_maybe_init
Date: Thu, 14 May 2026 11:42:29 -0600
Message-ID: <20260514175457.4047707-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514175457.4047707-1-trini@konsulko.com>
References: <20260514175457.4047707-1-trini@konsulko.com>
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

With bloblist, we need to both see if one already exists as well as
create one if it does not. However, the current implementation leads to
odd cases where we attempt to create a bloblist before this is possible
and have things be overly complicated when we are given one to work
with.

This reworks things to instead have a bloblist_exists function, which as
the name implies checks for an existing bloblist. This is used in
the case of booting, to see if we have one and in turn if we have a
device tree there as well as in the bloblist_init function to see if we
need to do anything.

In practical details, we move the logic from bloblist_init that was
checking for a bloblist to the new bloblist_exists function and then can
clarify the logic as it is much easier to state when we know we do not
have one rather than all the ways we might have one. Then we have the
locations that set gd->bloblist now also set the GD_FLG_BLOBLIST_READY
flag.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/bloblist.c  | 144 +++++++++++++++++++++++----------------------
 common/board_f.c   |   4 +-
 include/bloblist.h |  32 +++++-----
 lib/fdtdec.c       |  15 ++---
 4 files changed, 96 insertions(+), 99 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 09afdd1f96b4..51ae9cc50a5f 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -448,6 +448,7 @@ int bloblist_new(ulong addr, uint size, uint flags, uint align_log2)
 	hdr->align_log2 = align_log2 ? align_log2 : BLOBLIST_BLOB_ALIGN_LOG2;
 	hdr->chksum = 0;
 	gd->bloblist = hdr;
+	gd->flags |= GD_FLG_BLOBLIST_READY;
 
 	return 0;
 }
@@ -475,6 +476,7 @@ int bloblist_check(ulong addr, uint size)
 		return log_msg_ret("Bad checksum", -EIO);
 	}
 	gd->bloblist = hdr;
+	gd->flags |= GD_FLG_BLOBLIST_READY;
 
 	return 0;
 }
@@ -576,90 +578,88 @@ int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
 	return -ENOENT;
 }
 
-int bloblist_init(void)
+bool bloblist_exists(void)
 {
-	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
-	int ret = 0;
-	ulong addr = 0, size;
+	int ret;
+	ulong addr = 0;
 
 	/* Check if a valid transfer list passed in */
-	if (!xferlist_from_boot_arg(&addr)) {
-		size = bloblist_get_total_size();
-	} else {
-		/*
-		 * If U-Boot is not in the first phase, an existing bloblist must
-		 * be at a fixed address.
-		 */
-		bool from_addr = fixed && !xpl_is_first_phase();
-
-		/*
-		 * If Firmware Handoff is mandatory but no transfer list is
-		 * observed, report it as an error.
-		 */
-		if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
-			return -ENOENT;
-
-		ret = -ENOENT;
-
-		if (xpl_prev_phase() == PHASE_TPL &&
-		    !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-			from_addr = false;
-		if (fixed)
-			addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
-					      CONFIG_BLOBLIST_ADDR);
-		size = CONFIG_BLOBLIST_SIZE;
-
-		if (from_addr)
-			ret = bloblist_check(addr, size);
+	if (!xferlist_from_boot_arg(&addr))
+		goto found;
 
-		if (ret)
-			log_debug("Bloblist at %lx not found (err=%d)\n",
-				  addr, ret);
-		else
-			/* Get the real size */
-			size = gd->bloblist->total_size;
-	}
+	/*
+	 * If Firmware Handoff is mandatory but no transfer list is
+	 * observed, report it as an error.
+	 */
+	if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
+		return false;
 
-	if (ret) {
-		/*
-		 * If we don't have a bloblist from a fixed address, or the one
-		 * in the fixed address is not valid. we must allocate the
-		 * memory for it now.
-		 */
-		if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
-			void *ptr = memalign(BLOBLIST_ALIGN, size);
-
-			if (!ptr)
-				return log_msg_ret("alloc", -ENOMEM);
-			addr = map_to_sysmem(ptr);
-		} else if (!fixed) {
-			return log_msg_ret("BLOBLIST_FIXED is not enabled",
-					   ret);
-		}
-		log_debug("Creating new bloblist size %lx at %lx\n", size,
-			  addr);
-		ret = bloblist_new(addr, size, 0, 0);
-	} else {
-		log_debug("Found existing bloblist size %lx at %lx\n", size,
-			  addr);
-	}
+	/*
+	 * We have checked for a valid transfer list being passed. At this
+	 * point, if we do not have a fixed address for the bloblist, we cannot
+	 * be provided with one.
+	 */
+	if (xpl_is_first_phase() || !IS_ENABLED(CONFIG_BLOBLIST_FIXED))
+		return false;
 
-	if (ret)
-		return log_msg_ret("ini", ret);
-	gd->flags |= GD_FLG_BLOBLIST_READY;
+	/*
+	 * Check for a valid list as the configured address.
+	 */
+	addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+			      CONFIG_BLOBLIST_ADDR);
+	ret = bloblist_check(addr, CONFIG_BLOBLIST_SIZE);
+	if (!ret)
+		goto found;
+
+	log_debug("Bloblist at %lx not found (err=%d)\n", addr, ret);
+	return false;
 
+found:
 #ifdef DEBUG
 	bloblist_show_stats();
 	bloblist_show_list();
 #endif
-
-	return 0;
+	return true;
 }
 
-int bloblist_maybe_init(void)
+int bloblist_init(void)
 {
-	if (CONFIG_IS_ENABLED(BLOBLIST) && !(gd->flags & GD_FLG_BLOBLIST_READY))
-		return bloblist_init();
+	int ret;
+	ulong addr = 0, size = CONFIG_BLOBLIST_SIZE;
+
+	if (gd->flags & GD_FLG_BLOBLIST_READY) {
+		log_debug("Found existing bloblist size %x at %p\n",
+			  gd->bloblist->total_size, gd->bloblist);
+		return 0;
+	}
+
+	/*
+	 * If Firmware Handoff is mandatory but no transfer list has been
+	 * observed by fdtdec_setup, report it as an error.
+	 */
+	if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
+		return -ENOENT;
+
+	/*
+	 * If we don't have an existing bloblist, we either need
+	 * to allocate one now, or initialize the fixed address
+	 * space as a bloblist.
+	 */
+	if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
+		void *ptr = memalign(BLOBLIST_ALIGN, size);
+
+		if (!ptr)
+			return log_msg_ret("alloc", -ENOMEM);
+		addr = map_to_sysmem(ptr);
+	} else
+		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+				      CONFIG_BLOBLIST_ADDR);
+
+	log_debug("Creating new bloblist size %lx at %lx\n", size,
+		  addr);
+	ret = bloblist_new(addr, size, 0, 0);
+	if (ret)
+		return log_msg_ret("ini", ret);
 
 	return 0;
 }
@@ -687,7 +687,9 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
 		return ret;
 
 	if (rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
-		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
+		/* Remove this bloblist from gd */
+		gd->bloblist = NULL;
+		gd->flags &= ~GD_FLG_BLOBLIST_READY;
 		return -EIO;
 	}
 
diff --git a/common/board_f.c b/common/board_f.c
index ce87c619e680..c39e3b940d3b 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -894,7 +894,9 @@ static void initcall_run_f(void)
 	INITCALL(log_init);
 	INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
 	INITCALL(event_init);
-	INITCALL(bloblist_maybe_init);
+#if CONFIG_IS_ENABLED(BLOBLIST)
+	INITCALL(bloblist_init);
+#endif
 	INITCALL(setup_spl_handoff);
 #if CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F)
 	INITCALL(console_record_init);
diff --git a/include/bloblist.h b/include/bloblist.h
index e67b2a76358d..4c5787729654 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -488,10 +488,24 @@ const char *bloblist_tag_name(enum bloblist_tag_t tag);
  */
 int bloblist_reloc(void *to, uint to_size);
 
+/**
+ * bloblist_exists() - Check for the prior existence of a bloblist
+ *
+ * This will check for a transfer list having been passed via standard
+ * convention. If CONFIG_BLOBLIST_PASSAGE_MANDATORY is selected and one is not
+ * found, we return false.
+ *
+ * If CONFIG_BLOBLIST_FIXED is selected, it uses CONFIG_BLOBLIST_ADDR and
+ * CONFIG_BLOBLIST_SIZE to check for a bloblist.
+ *
+ * Return: true if found, false if not
+ */
+bool bloblist_exists(void);
+
 /**
  * bloblist_init() - Init the bloblist system with a single bloblist
  *
- * This locates and sets up the blocklist for use.
+ * This creates a bloblist for use, if not already found.
  *
  * If CONFIG_BLOBLIST_FIXED is selected, it uses CONFIG_BLOBLIST_ADDR and
  * CONFIG_BLOBLIST_SIZE to set up a bloblist for use by U-Boot.
@@ -508,22 +522,6 @@ int bloblist_reloc(void *to, uint to_size);
  */
 int bloblist_init(void);
 
-#if CONFIG_IS_ENABLED(BLOBLIST)
-/**
- * bloblist_maybe_init() - Init the bloblist system if not already done
- *
- * Calls bloblist_init() if the GD_FLG_BLOBLIST_READY flag is not set
- *
- * Return: 0 if OK, -ve on error
- */
-int bloblist_maybe_init(void);
-#else
-static inline int bloblist_maybe_init(void)
-{
-	return 0;
-}
-#endif /* BLOBLIST */
-
 /**
  * bloblist_check_reg_conv() - Check whether the bloblist is compliant to
  *			       the register conventions according to the
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c67b6e8c133e..7fd7f7ff01e5 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1822,17 +1822,12 @@ int fdtdec_setup(void)
 	int ret = -ENOENT;
 
 	/*
-	 * If allowing a bloblist, check that first. There was discussion about
-	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
-	 *
-	 * The necessary test is whether the previous phase passed a bloblist,
-	 * not whether this phase creates one.
+	 * If allowing a bloblist, check that first. The necessary test is
+	 * whether the previous phase passed a bloblist, not whether this phase
+	 * creates one.
 	 */
-	if (CONFIG_IS_ENABLED(BLOBLIST) &&
-	    (xpl_prev_phase() != PHASE_TPL ||
-	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
-		ret = bloblist_maybe_init();
-		if (!ret) {
+	if (CONFIG_IS_ENABLED(BLOBLIST) && (xpl_prev_phase() != PHASE_TPL)) {
+		if (bloblist_exists()) {
 			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
 			if (gd->fdt_blob) {
 				gd->fdt_src = FDTSRC_BLOBLIST;
-- 
2.43.0

