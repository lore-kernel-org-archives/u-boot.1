Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33628C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F3778210F;
	Fri, 28 Mar 2025 16:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V0YYs+TG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D41B820F5; Fri, 28 Mar 2025 16:36:48 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78CC681E6C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d571ac3d7eso5855725ab.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176203; x=1743781003; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AovJrIAVSpaMdizp4XUID8D/2RzhqmG3jCRcIjSSwxM=;
 b=V0YYs+TGNuCxNv6UOKZnQSSZ7BBqa0TYHcEmEV1XiIq5hlLPYkdACwoNs7BczNO98+
 9EKIhMKnUqNX/5qOpcAcUAbPdMoULwx2GZyc9bQXYOZs/+bqpdB1xrdcIF7dbrDjYxlL
 5s1sMnfhsVKdwkHwi707fbV3man6OjIFYjoZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176203; x=1743781003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AovJrIAVSpaMdizp4XUID8D/2RzhqmG3jCRcIjSSwxM=;
 b=CLqA4Wee3ks0pDPMqarqeXKzit2U6nZOybJKT9HJvXg7yAH2ksQ+CqiLaG/gFR2JIJ
 Wq32w3NFAK0ohaakCjKOgwe50Q60wL+98UHyCQMx1YMJ5sfkdsoRuUeRd+3D0ehr2Zdb
 GOCesH9o+ncCScTxfJaLsBveytI+s/Q/LRO8VEZQZxydqWelzPUaBQxqL7xAscGivKYe
 CAJb963xxbpFnzsRneMo1I5gXiKgVp00mtaDdg1A9CbnK8mxQaGzPhMV5kD7R7XSFHeB
 odmRvlN6EKzrxrAGcWWf12sFe+328KThFcoc5DU1Z7P8sBNAzXPogAul1ATa9lnWQZBS
 3kFA==
X-Gm-Message-State: AOJu0YwU7Uke1qA92wotXwk8biCufug53UJ7b8M13ObOfraDjWujsfDV
 xSejF8PF1VJ4mVOGR0snPmqntd71goVPpixzWP0/aKHaE7rL0OJuUIWalxiZGNmznye2y/wQErk
 =
X-Gm-Gg: ASbGnct5fXUNu36/GNiWNm56D/N3mULiZs8Nz9nFhxQy8LDdtatbEWw9ZMwQo2cLzsB
 EzqIwCQrvNG+q0jW6l/KhjRE58u6rJVRYe+e+l5/k9kTVsn2X0wiXFtdzllyZwQaZ/oJgEDUerA
 j2X5bVJmJjDi/Qe6GJxDah0aUUrPqW/277LJW41JZDk548exDON4+afhVBeMIQK9YhsU6uBX86W
 KEYd1ynive0ax/GebaNS0W4gjL1180pocGk10L8BxElt/kh1Gbg7O+QNtZ3sqzLciuV0lt5jD1v
 5B9mLYgvSx7wvUvACr+RH/NO/nUVWYh0dUwFex2u4HAR8nzivqwmvcaFlznf+PK9WSyPnEQfddh
 HeXtunQ==
X-Google-Smtp-Source: AGHT+IFTSEMQI32mxV+hYGw2lxx5fWo1SqCW165mdWc8jVMwwCTcWuaFcx0Xo8bcC3V+GnM1XQyfew==
X-Received: by 2002:a05:6e02:32c3:b0:3d5:890b:8db with SMTP id
 e9e14a558f8ab-3d5ccdca72amr100596315ab.8.1743176203485; 
 Fri, 28 Mar 2025 08:36:43 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 29/31] RFC: Revert "bloblist: Load the bloblist from the
 previous loader"
Date: Fri, 28 Mar 2025 09:35:09 -0600
Message-ID: <20250328153522.3555472-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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
index bc752b5fdf5..3f8c7f669a7 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -500,57 +500,37 @@ int bloblist_reloc(void *to, uint to_size)
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
 
@@ -558,8 +538,7 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("BLOBLIST_FIXED is not enabled",
-					   ret);
+			return log_msg_ret("!fixed", ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
@@ -572,11 +551,6 @@ int bloblist_init(void)
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
index dfe6a700e5e..191b9aa1d54 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -500,14 +500,4 @@ static inline int bloblist_maybe_init(void)
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

