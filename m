Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A88C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746658785C;
	Thu, 21 Dec 2023 01:41:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KGJnUWSV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3132A8785C; Thu, 21 Dec 2023 01:41:25 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D4087880
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42778277d9aso1611331cf.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119281; x=1703724081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsizhYF8Jm2qXAIt/DkcC7XIo1yQBTVjtbYeC6krsrc=;
 b=KGJnUWSVVa6cZpkL06XAfRgLN6AgybJgNT0NNtBD8W3uSJBbqVjrtFjn84Et4rMfoa
 3B5FqEoFoch8xvMv4jnQfQJ/Sfe9M2648gXSU0afrzTbjILw1pyaWuQzcqG7uS/X6vrl
 suMFhsWQJk8cVnTtrT9ZR5+TVl7ZUKi96eaXVSTai07I2nOfsZE+XH1ljOoeagft9EJA
 AMd1Wkm7NGGNJC27NRHMU0w1dEZ7ZvABI/NrMkUfcpgJ0zE9TQFUgAZlYJlz1KJNTjf5
 CKn3eKF4kVJaT0H6olxVXxIGs3dYz9gWJ5xht2CuLxpIIn750YyM2v5jy9tOt4bjQvty
 RSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119281; x=1703724081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsizhYF8Jm2qXAIt/DkcC7XIo1yQBTVjtbYeC6krsrc=;
 b=TqXwzwxgDgjjLewTJOgm2pkifFzuDVSP2wyG3C3FDTJvDrl1Eog/gRsdbP6KphI205
 aK3yF1Ntt342ATgius+LW8c8q9/HMUQot2mcGTL1UAfVN5Py8DUhkH+eiQflwn6I/7iQ
 3w8U6wQYkpq8FMSnN1VenlIraaPCRW+f5HGytLP2A09x/sY7KCpUQkguDo4qKQzk+QQL
 mKyBW4ZCEJZKWWmkWiky+VcZgQHCovepF/TIA6krjauRiTa5mZKo5ABQ90mkOHG2sWGU
 2MU0+Z2mre6n/Q3VZ3AeankCjyeWv0JqANQqBZrc1MbMK+pXMbu5b0ZHXOAgX9kcm58l
 2bRg==
X-Gm-Message-State: AOJu0YwiOEMtw8nRt1SveG9suib6iQb2ysO6reLpRVY1GynzfjqKdYHa
 x2fdLExxsnZ1Dw7WAe0j0aBUMIyUAiB33N6mgoU=
X-Google-Smtp-Source: AGHT+IEHNKNnej/IEF8+7bUNTz7xoQwnfoIZ6pN0BFEVMBDoezfUkQVLgGxUikwNuSp41E/ClG+AFg==
X-Received: by 2002:a05:622a:3c7:b0:427:90b2:bac0 with SMTP id
 k7-20020a05622a03c700b0042790b2bac0mr1837137qtx.132.1703119281115; 
 Wed, 20 Dec 2023 16:41:21 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:41:20 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 7/9] bloblist: Load the bloblist from the previous loader
Date: Wed, 20 Dec 2023 16:40:26 -0800
Message-Id: <20231221004030.581388-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221004030.581388-1-raymond.mao@linaro.org>
References: <20231221004030.581388-1-raymond.mao@linaro.org>
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

During bloblist initialization, when CONFIG_OF_BOARD is defined,
invoke the platform custom function to load the bloblist via boot
arguments from the previous loader.
If the bloblist exists, copy it into the fixed bloblist memory region.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 common/bloblist.c  | 47 ++++++++++++++++++++++++++++------------------
 include/bloblist.h | 16 ++++++++++++++++
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index fcfd62a618..5e3e41898a 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -490,31 +490,38 @@ int bloblist_init(void)
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
+		ret = board_bloblist_from_boot_arg(addr, size);
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
 		if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
 			void *ptr = memalign(BLOBLIST_ALIGN, size);
@@ -523,7 +530,8 @@ int bloblist_init(void)
 				return log_msg_ret("alloc", -ENOMEM);
 			addr = map_to_sysmem(ptr);
 		} else if (!fixed) {
-			return log_msg_ret("!fixed", ret);
+			return log_msg_ret("BLOBLIST_FIXED is not enabled",
+					   ret);
 		}
 		log_debug("Creating new bloblist size %lx at %lx\n", size,
 			  addr);
@@ -536,6 +544,9 @@ int bloblist_init(void)
 		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
 
+	bloblist_show_stats();
+	bloblist_show_list();
+
 	return 0;
 }
 
diff --git a/include/bloblist.h b/include/bloblist.h
index c8f61c45de..e316f378b9 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -443,6 +443,22 @@ void bloblist_reloc(void *to, uint to_size);
  */
 int bloblist_init(void);
 
+#if (IS_ENABLED(CONFIG_ARCH_QEMU) && IS_ENABLED(CONFIG_ARM))
+/* Board custom function for qemu-arm */
+int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size);
+#else
+/*
+ * A board need to implement this custom function if it needs to retrieve
+ * bloblist from a previous loader
+ */
+static inline
+int board_bloblist_from_boot_arg(unsigned long __always_unused addr,
+				 unsigned long __always_unused size)
+{
+	return -1;
+}
+#endif
+
 #if CONFIG_IS_ENABLED(BLOBLIST)
 /**
  * bloblist_maybe_init() - Init the bloblist system if not already done
-- 
2.25.1

