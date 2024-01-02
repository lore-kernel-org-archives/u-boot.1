Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D551C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 22:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DE1D87990;
	Tue,  2 Jan 2024 23:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GBOBlN7H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641A687990; Tue,  2 Jan 2024 23:14:04 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89438794F
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 23:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-680861506afso29095726d6.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704233636; x=1704838436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNpBd71cqsDpMZzeRKIBtAAjQ+KjajAPxbRpI6lDj4k=;
 b=GBOBlN7H4qHt4I/TH55+cAXEYqBGh7OQNqGt4nPiIgbTKM1zPP+yXj746LpA28meJg
 1iiit9D/wAqK2SfHMGvN2zaE8b2v8rf4YRBvCR2ALbWpMgnkiMEw/KDTt4AdmGTvyico
 zJngYbWCny9EcwaFT1TW2bba3NFVkrbJs89LDqNlytCKj/MMHBmT6V3bJX7rWd1I6Xeb
 DOQY7bekFAnVJoL4qSiOLvdAtbu7dObf237K6rKxzp7Mf2JRMARxt0hJ0MhpJJrY9fV8
 EXonKwieyGY5XPvL7DgGbJdkYEzliH1jABUfH/tSMTnQsFuDv0wBKSIk3ybFDFS9MluS
 ts4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704233636; x=1704838436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNpBd71cqsDpMZzeRKIBtAAjQ+KjajAPxbRpI6lDj4k=;
 b=Xigh3sGZ+jnzb0BEe9fgNsbbQlHhZnVVTcVuK5FopnLKq62x2w3Et4ShUSHZESGjZ0
 +YWmCcpFzIJGOPUscexo89znSBDX5b+ZvSPk4Yo1IRvQt85Bj6NBQvZJlB3nCGK2vT+q
 ZHbw5hHgaU8jHkv7K/RAm5oguLJJiYUrO0d4Kt4SVu5L1vPZNGt7vNg8NdFEyheRDFEz
 StOwhWzQzSTuVW3LJ1HPhTzxps5e0dXAgP4vE327HOpaIXFfVETF399muc0xc0Ta0rdS
 0N39ftYXvoNTBZ81sHS+a4+OyiZebp42/1+Nf9voY8p03+ELIhlHpPvuhVQOJot5PRQx
 tVLw==
X-Gm-Message-State: AOJu0Ywum9YCFsbADz7EDN2TcYtTZtIv8264U+s/HQE94HbpsaRzQxsi
 HpiqzJ65oUoaLqV2xnzy3CmZrx9r8YRR5h1JaB5jVHwEaGs=
X-Google-Smtp-Source: AGHT+IGaTa3YF0t7KMLdON3VAbtLBfnOr6xMsUvbKMlnFZV6SGINIlcjq2/W/xJPvw//MEclFnmRxg==
X-Received: by 2002:a05:6214:cc4:b0:67f:2167:ade0 with SMTP id
 4-20020a0562140cc400b0067f2167ade0mr201177qvx.54.1704233636027; 
 Tue, 02 Jan 2024 14:13:56 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 mg14-20020a056214560e00b0067f70cc986asm10431487qvb.92.2024.01.02.14.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 14:13:55 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 7/9] bloblist: Load the bloblist from the previous loader
Date: Tue,  2 Jan 2024 14:12:32 -0800
Message-Id: <20240102221237.1007090-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102221237.1007090-1-raymond.mao@linaro.org>
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
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

During bloblist initialization, when OF_BOARD is defined, load the
bloblist via boot arguments from the previous loader.
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

 common/bloblist.c  | 66 +++++++++++++++++++++++++++++++++-------------
 include/bloblist.h | 10 +++++++
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 4e76975627..65c3c031d0 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -17,6 +17,9 @@
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
 
+/* local debug macro */
+#undef BLOBLIST_DEBUG
+
 /*
  * A bloblist is a single contiguous chunk of memory with a header
  * (struct bloblist_hdr) and a number of blobs in it.
@@ -487,37 +490,58 @@ int bloblist_reloc(void *to, uint to_size)
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
+	 * If U-Boot is in the first phase that a board specific routine should
+	 * install the bloblist passed from previous loader to this fixed
 	 * address.
 	 */
-	expected = fixed && !u_boot_first_phase();
+	bool from_board = fixed && IS_ENABLED(CONFIG_OF_BOARD) &&
+			  u_boot_first_phase();
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
+	if (from_board)
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
 
@@ -525,7 +549,8 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("!fixed", ret);
+			return log_msg_ret("BLOBLIST_FIXED is not enabled",
+					   ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
@@ -538,6 +563,11 @@ int bloblist_init(void)
 		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
 
+#ifdef BLOBLIST_DEBUG
+	bloblist_show_stats();
+	bloblist_show_list();
+#endif
+
 	return 0;
 }
 
diff --git a/include/bloblist.h b/include/bloblist.h
index 81f1dfa027..af215932bc 100644
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

