Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0349DC02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 02:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F33D80A29;
	Wed,  5 Feb 2025 02:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wbhd0Lfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B0C80842; Wed,  5 Feb 2025 02:57:58 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEAF580A0A
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71ded02b779so3458705a34.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720674; x=1739325474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mko+q15srDcjLlXHRwsjAbmw7SQq5hHWwVWYNG31oBY=;
 b=Wbhd0LfnSngPTohGrGJiE8zYEq5JHmEf/bOKO267MOjcOzrIFzyhiTRFcOgEckj5z5
 Mw6cUFOEXxe5tEJgR/+GI2JOSIDrCxd5Jb+ZqHXzQNht7zVE6vIonE+fwdQdxN00r4FW
 G+CqTVyjjSXIv9jvjjc18OekBt2tWwp/fgb6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720674; x=1739325474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mko+q15srDcjLlXHRwsjAbmw7SQq5hHWwVWYNG31oBY=;
 b=uAjKF4t9m0zHCdsnqRMKD+x5emNvCXKDaDtk5H2ix/Kp9b7jTcr4IS3qQ0XiFE1yX+
 Cc9liScERkw35T3vSaE/bORQmQVHpHM8mSrZjjvCYFbzi3qNLe+ImWZ5pTnYQ9YF49np
 2wQ1f1k01WKNtmpvPurE03jTZgG9ok5YxSSkmgqgSkB/cslrdP51SJipfYMKEEjlxxB3
 65pDhdZNr2HW2KTBiffsBtXPJwDzAXgvBWARqjVABRaV5AEgKVvZPIZIQeaz9NK6ePE1
 TiDIFCMZ9cusCdsg1EsKeU6dLwQdstOnwU0L5uu+Czft5JzI6fG7xwciPmXI9Eb5J5US
 Hdkg==
X-Gm-Message-State: AOJu0YwDcR6fhc+G2TheOa3PeQRsMpTdfVnIOCdEHdxmDk9+7b8iCiyy
 ARL3gTeIP8vasBJKQFBIbk8qpjYB9m/Iyoo6X3Ajg3jARPjT9IwuRdJZFSZrSJDloo1huwTwPUc
 =
X-Gm-Gg: ASbGncuIrVr6UYI8tV+KuStotJIhi8sb+rLkCtNKtucQzJfpeeYfoRqeSDtrMkTDAvX
 MJiieCn/ZONOUOswJt089jrWWZOOxgUNB3t+C2A2ApfmAODOwy3CCp+r80rl8aiGEC/o8m18g3O
 8QGnn6+kdJUaEF6b+nfxdjy9b6U81prdpojSngD7RtHWUm8HdpHMfu6SVNBviZ8LhKyy08JzKkO
 oSwWMkLdIy27pUc5A2QIj8WgllAtptAGTLACmZVor+yZMWwIGpBV7cNAHxrsK1FgO7vALLMju7W
 ZSCL1uYyOdHCnRu+DkJmtQ9qpBVtC7VeHTGV/r7hevVaOXG0w4gU
X-Google-Smtp-Source: AGHT+IEvqyN68xAur8AcDsHC5ThRExksPfp3bo8pmmIocssx1/IDniGv4GTAflhiDWiAmh0hQt5dUg==
X-Received: by 2002:a05:6830:610f:b0:71d:fc52:1ab6 with SMTP id
 46e09a7af769-726a42ae8ecmr835524a34.23.1738720673815; 
 Tue, 04 Feb 2025 17:57:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 28/29] Revert "bloblist: Load the bloblist from the previous
 loader"
Date: Tue,  4 Feb 2025 18:55:18 -0700
Message-ID: <20250205015606.2686149-29-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.

https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

