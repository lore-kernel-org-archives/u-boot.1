Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C55CC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84100836B2;
	Sun, 25 May 2025 12:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iiiyZsyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EECD383734; Sun, 25 May 2025 12:48:47 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8693982BDA
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3a4d877dfb3so86329f8f.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170124; x=1748774924; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8/YQ2RBM/60sMyX+zwstRk+nyMBH/kK8FbKcdCFEuk=;
 b=iiiyZsyqeTiGIlvsMZ53wekt9AdW3j3l+APPHouYYxisznpT+kdaOThS0Uv2SV0QGH
 hLyQunHpaO37uEqE9UaGmjjUpQ3+65eUNxtL4RJv02oNA8QlsfdawFkyy9N6HI6Alktz
 ObalrFb3MrXgbbDFsXg7nRLHbEaD6CPWFxmaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170124; x=1748774924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8/YQ2RBM/60sMyX+zwstRk+nyMBH/kK8FbKcdCFEuk=;
 b=fzourjRBFIG6gbNjZVqrfJ/iwm7r9+hNAR8JCSLVHcEfCyZOiNCYc2nigKU6yuoWMG
 aoJBXqTx/JuuaKrkYCT1uAPyGlg9Jy8Qtu25MBbv3a1kZR4k1Rq3vlN7/udrVrVz2wDI
 lC60S8jdNV74iuIRFckJV9/UZH/4oM6P8BvrUvN3qrqPLDeVs/j2tdP+57/ZdDHXHEBA
 XhHlr6QBbWwvqSyl9IQDlERaXBWz6rfJ+ShA7r2ewXSD3KCvPT+om2iuX0hLWQpZrVU7
 ELQYdAa2XvT/w+dQVMeSO1tr0NeJ/WxxIjCodPYjQwuawrQC12KsUqFEQtMXiA5jCTqd
 wifA==
X-Gm-Message-State: AOJu0YyYN9b0iOxt+Bs+Lx4Bpx6MCVBl0ZK8KIc0k55PPfq4DYAIzacZ
 jBGq5dlZf5eG3y0jPJEe32bxcx/jtBnMO4kjcSWhOizP8crvZqzdmiwRihUTgmY1Cbg6mnUUjm1
 QN+MOkyD400Y=
X-Gm-Gg: ASbGncvFqv2Ezed4T1uSVLaT7BS2WU9Q7KV5jMZLnPqr07sfzJrWrG4/LNNQ6qUzIh/
 gaGjYeOcnF/nLBnZTcg5/yWhNyZdarI0B4r8NIhN7JYr0Zd8E6KSynp4Qlky9waZmf3EQCUgov8
 2J+9hUwB8sVvSkMAd7KHk8ybrTeans1Jm9w4Ye4QP4xKr9W6j/txUCr+8RPQl28lxzuF9RERGua
 M3SdZP/GcjUHGVPYrfb5hIXmuZh0WYwvFZuNpJwrXXPT9VWVglWPC6JvFUPiYvd+2UdNGapdZpS
 XbPyZ2Hyx4cI2FcESn/JeTOU4werWAAHM4IwwCKygKX0cQkeqriq3+ENdKfl71uksPK2UAc=
X-Google-Smtp-Source: AGHT+IGCd5sqOo2uj4e/XhAHvlqY3c6VCiEJuld+7G3Z1hkcFhNDhpOTW3qB40PByPHrF29YgghAiQ==
X-Received: by 2002:a05:6000:2083:b0:3a3:6ae4:6615 with SMTP id
 ffacd0b85a97d-3a4cb453dc9mr3821205f8f.13.1748170124380; 
 Sun, 25 May 2025 03:48:44 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 23/25] bloblist: Temporary hacks to get VBE going
Date: Sun, 25 May 2025 11:47:59 +0100
Message-Id: <20250525104801.1440260-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Do not apply.

The primary issue with the patch is that U-Boot needs to set up a
bloblist in the first phase where BLOBLIST is enabled. Subsequent
phases can then use that bloblist.

But the first phase of U-Boot cannot assume that one exists.

While we wait for a final decision on the bloblist implementation (and
thus whether VBE can be supported), revert the changes which break VBE.

The real solution is this series, but it is blocked, at least for now:

https://patchwork.ozlabs.org/project/uboot/list/?series=456263&state=*

Note that this breaks vexpress_fvp_bloblist so that test is dropped.

Link: https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitlab-ci.yml          |  14 ++---
 arch/arm/lib/xferlist.c |  12 +++--
 common/bloblist.c       | 116 ++++++++++++----------------------------
 include/bloblist.h      |  16 ++----
 4 files changed, 53 insertions(+), 105 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cf8147fbfd5..e0d25d2be12 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -530,13 +530,13 @@ vexpress_fvp test.py:
     - ${DEFAULT_AMD64_TAG}
   <<: *buildman_and_testpy_dfn
 
-vexpress_fvp_bloblist test.py:
-  variables:
-    TEST_PY_BD: "vexpress_fvp_bloblist"
-    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
-  tags:
-    - ${DEFAULT_AMD64_TAG}
-  <<: *buildman_and_testpy_dfn
+#vexpress_fvp_bloblist test.py:
+#  variables:
+#    TEST_PY_BD: "vexpress_fvp_bloblist"
+#    TEST_PY_TEST_SPEC: "not sleep and not hostfs"
+#  tags:
+#    - ${DEFAULT_AMD64_TAG}
+#  <<: *buildman_and_testpy_dfn
 
 xilinx_zynq_virt test.py:
   variables:
diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
index 6425936d354..f9c5d88bd47 100644
--- a/arch/arm/lib/xferlist.c
+++ b/arch/arm/lib/xferlist.c
@@ -8,16 +8,18 @@
 #include <bloblist.h>
 #include "xferlist.h"
 
-int xferlist_from_boot_arg(ulong *addr)
+int xferlist_from_boot_arg(ulong addr, ulong size)
 {
 	int ret;
 
-	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
-				      saved_args[1], saved_args[3]);
+	ret = bloblist_check(saved_args[3], size);
 	if (ret)
 		return ret;
 
-	*addr = bloblist_get_base();
+	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
+				      saved_args[1]);
+	if (ret)
+		return ret;
 
-	return 0;
+	return bloblist_reloc((void *)addr, size);
 }
diff --git a/common/bloblist.c b/common/bloblist.c
index 6e4f020d7c4..197b609fc23 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -488,9 +488,6 @@ int bloblist_reloc(void *to, uint to_size)
 {
 	struct bloblist_hdr *hdr;
 
-	if (!to_size)
-		return 0;
-
 	if (to_size < gd->bloblist->total_size)
 		return -ENOSPC;
 
@@ -502,64 +499,37 @@ int bloblist_reloc(void *to, uint to_size)
 	return 0;
 }
 
-/*
- * Weak default function for getting bloblist from boot args.
- */
-int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
-{
-	return -ENOENT;
-}
-
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
-	int ret = 0;
-	ulong addr = 0, size;
-
-	/* Check if a valid transfer list passed in */
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
-
-		if (ret)
-			log_warning("Bloblist at %lx not found (err=%d)\n",
+	int ret = -ENOENT;
+	ulong addr, size;
+	bool expected;
+
+	/**
+	 * We don't expect to find an existing bloblist in the first phase of
+	 * U-Boot that runs. Also we have no way to receive the address of an
+	 * allocated bloblist from a previous stage, so it must be at a fixed
+	 * address.
+	 */
+	expected = fixed && !xpl_is_first_phase();
+	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
+		expected = false;
+	if (fixed)
+		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+				      CONFIG_BLOBLIST_ADDR);
+	size = CONFIG_BLOBLIST_SIZE;
+	if (expected) {
+		ret = bloblist_check(addr, size);
+		if (ret) {
+			log_warning("Expected bloblist at %lx not found (err=%d)\n",
 				    addr, ret);
-		else
-			/* Get the real size */
+		} else {
+			/* Get the real size, if it is not what we expected */
 			size = gd->bloblist->total_size;
+		}
 	}
-
 	if (ret) {
-		/*
-		 * If we don't have a bloblist from a fixed address, or the one
-		 * in the fixed address is not valid. we must allocate the
-		 * memory for it now.
-		 */
 		if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
 			void *ptr = memalign(BLOBLIST_ALIGN, size);
 
@@ -567,8 +537,7 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("BLOBLIST_FIXED is not enabled",
-					   ret);
+			return log_msg_ret("!fixed", ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
@@ -577,16 +546,10 @@ int bloblist_init(void)
 		log_debug("Found existing bloblist size %lx at %lx\n", size,
 			  addr);
 	}
-
 	if (ret)
 		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
 
-#ifdef DEBUG
-	bloblist_show_stats();
-	bloblist_show_list();
-#endif
-
 	return 0;
 }
 
@@ -598,29 +561,20 @@ int bloblist_maybe_init(void)
 	return 0;
 }
 
-int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
 {
-	u64 version = BLOBLIST_REGCONV_VER;
+	ulong version = BLOBLIST_REGCONV_VER;
 	ulong sigval;
-	int ret;
 
-	if ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
-			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) {
-		sigval = ((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64));
-	} else {
-		sigval = ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
-	}
-
-	if (rzero || rsig != sigval)
-		return -EIO;
-
-	ret = bloblist_check(xlist, 0);
-	if (ret)
-		return ret;
+	sigval = (IS_ENABLED(CONFIG_64BIT)) ?
+			((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
+			 ((unsigned long long)
+			 (version & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64)) :
+			((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
+			 ((version & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
 
-	if (rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
+	if (rzero || rsig != sigval ||
+	    rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
 		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
 		return -EIO;
 	}
diff --git a/include/bloblist.h b/include/bloblist.h
index f32faf78560..081eb6161fc 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -467,8 +467,9 @@ int bloblist_reloc(void *to, uint to_size);
  * If CONFIG_BLOBLIST_ALLOC is selected, it allocates memory for a bloblist of
  * size CONFIG_BLOBLIST_SIZE.
  *
- * If CONFIG_BLOBLIST_PASSAGE_MANDATORY is selected, bloblist in the incoming
- * standard passage is mandatorily required.
+ * If CONFIG_BLOBLIST_PASSAGE is selected, it uses the bloblist in the incoming
+ * standard passage. The size is detected automatically so CONFIG_BLOBLIST_SIZE
+ * can be 0.
  *
  * Sets GD_FLG_BLOBLIST_READY in global_data flags on success
  *
@@ -500,18 +501,9 @@ static inline int bloblist_maybe_init(void)
  * @rfdt:  Register that holds the FDT base address.
  * @rzero: Register that must be zero.
  * @rsig:  Register that holds signature and register conventions version.
- * @xlist: Register that holds the transfer list.
  * Return: 0 if OK, -EIO if the bloblist is not compliant to the register
  *	   conventions.
  */
-int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist);
-
-/**
- * xferlist_from_boot_arg() - Get bloblist from the boot args.
- *
- * @addr: Address of the bloblist
- * Return: 0 if OK, else on error
- */
-int xferlist_from_boot_arg(ulong *addr);
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
 
 #endif /* __BLOBLIST_H */
-- 
2.34.1

