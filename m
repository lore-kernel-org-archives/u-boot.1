Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB41C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8982387CF8;
	Fri, 19 Jan 2024 16:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wpRhVyxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B59487CF8; Fri, 19 Jan 2024 16:12:42 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A66687CFA
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-781753f52afso53508085a.2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705677158; x=1706281958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+SbtxPaLs0sI6B8Aif8NsZLo5lvyC+gWqu8P/RNRM8=;
 b=wpRhVyxvEXEcGKfRpwILqn7w5klcMaBG+7yAIw8QAr1ZUbX7Y/V2vpYP/PBV80TM7V
 AfltkkrV1AKRlyOSuNd8stE5PNTQU6xGhTVmt2OIh4VLmtAsR5qj+eFscqpvywOzYLOX
 1BzUdDLrD3uWJl/m8eeGPymn5+Z24vnkHNJAR7FFk2r2UfEqV7rU+iHfMRqEPBsKcYAI
 alwj/rI7gXzeiVH6fCxiiowS16bP5l8kkwxdflILEtfbwHpAaZ/C4LPs6LujcyO0dSTa
 YMAHeGm+nEzj3Ylpki7u4TCHXx96hTSmOZuzU0vLmBrZxQ1MnKBXL63DUtKmByr+UJl3
 MNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705677158; x=1706281958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+SbtxPaLs0sI6B8Aif8NsZLo5lvyC+gWqu8P/RNRM8=;
 b=CoBs+AaNJK576XLZIRgJR25DXab5hWOfEQBijg7/8UjL9++LSB9GkVgaa8sskZjO1Z
 p5LTEnPnrJNCjVLAXobdhxY1Ybxiq5WlBAGk6WiX1bWkPhtbtpP1mL66u5Q8bjG1BuFw
 ACTiBCzaWjhIAQoYh6V7QIEi9iBsU2ZaRwTu7FgfWQyj2QjGbru5Sg0020B7M5EK2rJq
 GVLm4aLY5XGIp2I0q8HbW25Tf8TaFkCKuT67TRoj2h5DM/OjUpxPdpU8uXUZnD3r5y3C
 BkLBYHl2qoZbte+l18mJ4zAo+I6XaG5b27svUDjvjO8zwUFgnAqDX4ZI6VqoMiofI9iE
 byqQ==
X-Gm-Message-State: AOJu0YzQ0828L5sVIAkZt1PjIW9EP/sDDMTGSMi3u5GdEMLoKAiXrx7W
 cBHY2USwj+pP3Z+SWLbS4FiA6WCvqhN/PlCjWpRV5zUrIfRvpcscJE1qvdbn+wMLBBlY/jDoyl3
 a
X-Google-Smtp-Source: AGHT+IFpya3o95DjK797GbfRjSYZVSus4rUmzkeqGLJkKoXj/VmfxhZuwfHesFJYQfKz4yzJIFLXsA==
X-Received: by 2002:a05:620a:298c:b0:783:5cd1:ef6c with SMTP id
 r12-20020a05620a298c00b007835cd1ef6cmr34632qkp.60.1705677158601; 
 Fri, 19 Jan 2024 07:12:38 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a37c208000000b0078322dc4f97sm6142113qkm.26.2024.01.19.07.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:12:38 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v7 7/8] bloblist: Load the bloblist from the previous loader
Date: Fri, 19 Jan 2024 07:10:03 -0800
Message-Id: <20240119151007.715348-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119151007.715348-1-raymond.mao@linaro.org>
References: <20240119151007.715348-1-raymond.mao@linaro.org>
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

During bloblist initialization, load the bloblist via boot arguments
from the previous loader.
If a valid bloblist exists in boot arguments, relocate it into the
fixed bloblist memory region.
If not, fallback to support BLOBLIST_ADDR or BLOBLIST_ALLOC.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v4
- Add weak default function.
- Add comments for BLOBLIST_ALLOC.
- Add local debug macro.
- Refine the commit message.
Changes in V5
- Drop the dependence on OF_BOARD.
- Remove local debug macro.

 common/bloblist.c  | 62 ++++++++++++++++++++++++++++++++--------------
 include/bloblist.h | 10 ++++++++
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index c2fd07575f..ad06d7a179 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -487,37 +487,57 @@ int bloblist_reloc(void *to, uint to_size)
 	return 0;
 }
 
+/*
+ * Weak default function for getting bloblist from boot args.
+ */
+int __weak xferlist_from_boot_arg(ulong __always_unused addr,
+				  ulong __always_unused size)
+{
+	return -ENOENT;
+}
+
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
 	ulong addr, size;
-	bool expected;
-
-	/**
-	 * We don't expect to find an existing bloblist in the first phase of
-	 * U-Boot that runs. Also we have no way to receive the address of an
-	 * allocated bloblist from a previous stage, so it must be at a fixed
+	/*
+	 * If U-Boot is not in the first phase, an existing bloblist must be
+	 * at a fixed address.
+	 */
+	bool from_addr = fixed && !u_boot_first_phase();
+	/*
+	 * If U-Boot is in the first phase that an arch custom routine should
+	 * install the bloblist passed from previous loader to this fixed
 	 * address.
 	 */
-	expected = fixed && !u_boot_first_phase();
+	bool from_boot_arg = fixed && u_boot_first_phase();
+
 	if (spl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-		expected = false;
+		from_addr = false;
 	if (fixed)
 		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
 				      CONFIG_BLOBLIST_ADDR);
 	size = CONFIG_BLOBLIST_SIZE;
-	if (expected) {
+
+	if (from_boot_arg)
+		ret = xferlist_from_boot_arg(addr, size);
+	else if (from_addr)
 		ret = bloblist_check(addr, size);
-		if (ret) {
-			log_warning("Expected bloblist at %lx not found (err=%d)\n",
-				    addr, ret);
-		} else {
-			/* Get the real size, if it is not what we expected */
-			size = gd->bloblist->total_size;
-		}
-	}
+
+	if (ret)
+		log_warning("Bloblist at %lx not found (err=%d)\n",
+			    addr, ret);
+	else
+		/* Get the real size */
+		size = gd->bloblist->total_size;
+
 	if (ret) {
+		/*
+		 * If we don't have a bloblist from a fixed address, or the one
+		 * in the fixed address is not valid. we must allocate the
+		 * memory for it now.
+		 */
 		if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
 			void *ptr = memalign(BLOBLIST_ALIGN, size);
 
@@ -525,7 +545,8 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("!fixed", ret);
+			return log_msg_ret("BLOBLIST_FIXED is not enabled",
+					   ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
@@ -538,6 +559,11 @@ int bloblist_init(void)
 		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
 
+#ifdef DEBUG
+	bloblist_show_stats();
+	bloblist_show_list();
+#endif
+
 	return 0;
 }
 
diff --git a/include/bloblist.h b/include/bloblist.h
index 0ae079d62a..7fbdd622bc 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -482,4 +482,14 @@ static inline int bloblist_maybe_init(void)
  */
 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
 
+/**
+ * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
+ *			      to the specified address.
+ *
+ * @addr: Address for the bloblist
+ * @size: Size of space reserved for the bloblist
+ * Return: 0 if OK, else on error
+ */
+int xferlist_from_boot_arg(ulong addr, ulong size);
+
 #endif /* __BLOBLIST_H */
-- 
2.25.1

