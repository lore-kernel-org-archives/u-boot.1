Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF82EC0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D9D80EF6;
	Sun,  9 Feb 2025 22:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nryKJAvs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C8B80A23; Sun,  9 Feb 2025 22:16:53 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CCF809A5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d04d767d3aso31725445ab.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135809; x=1739740609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ojS3JN0A4Cz6QFtUmW3Yowd16KcaNeXDOxVvEXyoR0=;
 b=nryKJAvsTrH7lQ+abZk1KQyduQpmgeTIYh6IUt7FPJKCCTxaISpY+UaPEW9lAcrQBS
 Wf0pV/0cccfg2oHvj7Ih43TBU8CwOD6zMZdhS8WVVg8eOkSktyGs53WroSPvBOgBRU14
 hYR3M2dab0TyQTT3F6mYn8hZmcdaCbh2bD3gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135809; x=1739740609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ojS3JN0A4Cz6QFtUmW3Yowd16KcaNeXDOxVvEXyoR0=;
 b=DChxFC/CoeAoohjh6Gtg+qNqi3FzHglPYAqG8k4dFGz5qp2sMM1o+Iy2E1ikFsgoCJ
 5RVj7Y5kEoWv4jrDVj+UB2IaFkXZWADOb4z5hz4empULwlK8ITfGZf61/kXaKjGjj1Af
 gmZY4ewNkCnWSh0kUey03neqg19Nj8MrhnGPqLliGjYDJSjTiBpVvqstOuGOSwQNB4Bn
 prK5QtsH90e+3B89sR+2VIn8k8S29oMFaA+x1lOswZ3AKUQgdqzWjUABY7kET3GCfiqp
 SwhiTE2y0tUuLOIVlgke8IJYYPQftsjW/T9dlv1sg5y3DLJZUfKAPCAL4o6LbgjYuAln
 MfjA==
X-Gm-Message-State: AOJu0YyFLwsQdvp1+chHWlLo7XhPZ0c5CQDFplm+7kNyEnt+aDfmrKyA
 puG4kVORndSrByceCth3Vz9zC5gAR4ZQBuhgDzHZOORKbgTk32tj6x3VCuW89FvfRqm6tIXUUpE
 =
X-Gm-Gg: ASbGncuP923nOuMLW/u9ThxDJ1qrzx4Zhr9y8RQ0KXYgBDqQUnOmBY83QcQplKtovf9
 SDcIn0j1soW6/vc+WAbB3GSjVx+vgU0aTpNQ2RJmG36OxisBm2h6ZESUQdfTZR6ruzR3kS/lMpX
 rzrocl6Ba1X7AA8oZJC5hrqwp/6u1Ec458g/xPmCNzza61hzknsm7Bbbc0ubyRKvuQRI2iWF9un
 3fZZhWGLdUvpoRN6B7iawXJbW5QLlkU12GNZpnhhvg6k7yuAGkZbd8nQCa3PV4frDNjiMkoQTu1
 pdqsqaGLHVSYenwMuIG0QLkzlDwpbwbyRnSnzrH7ZrR60gNjKkjM
X-Google-Smtp-Source: AGHT+IHPpuE5ZofLyTzo49L+U6Fs55l0KogNEDVHqGLFmAmt8Cr7iwOyEVc+PylRojnkshTuNQICFw==
X-Received: by 2002:a05:6e02:1948:b0:3cf:cb93:de02 with SMTP id
 e9e14a558f8ab-3d13de78c94mr109688635ab.3.1739135809509; 
 Sun, 09 Feb 2025 13:16:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 33/35] RFC: Revert "bloblist: Load the bloblist from the
 previous loader"
Date: Sun,  9 Feb 2025 14:14:54 -0700
Message-ID: <20250209211502.2299245-34-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

The logic of this has become too confusing.

The primary issue with the patch is that U-Boot needs to set up a
bloblist in the first phase where BLOBLIST is enabled. Subsequent
phases can then use that bloblist.

But the first phase of U-Boot cannot assume that one exists.

Reverting this commit seems like a better starting point for getting
things working for all use-cases.

Note: The work to tidy this up is apparently underway. For this series,
a revert is the easiest path.

This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.

https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/bloblist.c  | 64 ++++++++++++++--------------------------------
 include/bloblist.h | 10 --------
 2 files changed, 19 insertions(+), 55 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index e8acfc74331..7eda94ecdf9 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -487,57 +487,37 @@ int bloblist_reloc(void *to, uint to_size)
 	return 0;
 }
 
-/*
- * Weak default function for getting bloblist from boot args.
- */
-int __weak xferlist_from_boot_arg(ulong __always_unused addr,
-				  ulong __always_unused size)
-{
-	return -ENOENT;
-}
-
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr = 0, size;
-	/*
-	 * If U-Boot is not in the first phase, an existing bloblist must be
-	 * at a fixed address.
-	 */
-	bool from_addr = fixed && !xpl_is_first_phase();
-	/*
-	 * If U-Boot is in the first phase that an arch custom routine should
-	 * install the bloblist passed from previous loader to this fixed
+	ulong addr, size;
+	bool expected;
+
+	/**
+	 * We don't expect to find an existing bloblist in the first phase of
+	 * U-Boot that runs. Also we have no way to receive the address of an
+	 * allocated bloblist from a previous stage, so it must be at a fixed
 	 * address.
 	 */
-	bool from_boot_arg = fixed && xpl_is_first_phase();
-
+	expected = fixed && !xpl_is_first_phase();
 	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-		from_addr = false;
+		expected = false;
 	if (fixed)
 		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
 				      CONFIG_BLOBLIST_ADDR);
 	size = CONFIG_BLOBLIST_SIZE;
-
-	if (from_boot_arg)
-		ret = xferlist_from_boot_arg(addr, size);
-	else if (from_addr)
+	if (expected) {
 		ret = bloblist_check(addr, size);
-
-	if (ret)
-		log_warning("Bloblist at %lx not found (err=%d)\n",
-			    addr, ret);
-	else
-		/* Get the real size */
-		size = gd->bloblist->total_size;
-
+		if (ret) {
+			log_warning("Expected bloblist at %lx not found (err=%d)\n",
+				    addr, ret);
+		} else {
+			/* Get the real size, if it is not what we expected */
+			size = gd->bloblist->total_size;
+		}
+	}
 	if (ret) {
-		/*
-		 * If we don't have a bloblist from a fixed address, or the one
-		 * in the fixed address is not valid. we must allocate the
-		 * memory for it now.
-		 */
 		if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
 			void *ptr = memalign(BLOBLIST_ALIGN, size);
 
@@ -545,8 +525,7 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("BLOBLIST_FIXED is not enabled",
-					   ret);
+			return log_msg_ret("!fixed", ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
@@ -559,11 +538,6 @@ int bloblist_init(void)
 		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
 
-#ifdef DEBUG
-	bloblist_show_stats();
-	bloblist_show_list();
-#endif
-
 	return 0;
 }
 
diff --git a/include/bloblist.h b/include/bloblist.h
index 1e1ca34aa92..5063ab66e4a 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -482,14 +482,4 @@ static inline int bloblist_maybe_init(void)
  */
 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
 
-/**
- * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
- *			      to the specified address.
- *
- * @addr: Address for the bloblist
- * @size: Size of space reserved for the bloblist
- * Return: 0 if OK, else on error
- */
-int xferlist_from_boot_arg(ulong addr, ulong size);
-
 #endif /* __BLOBLIST_H */
-- 
2.43.0

