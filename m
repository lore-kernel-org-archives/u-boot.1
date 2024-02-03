Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711D8C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 16:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410E187BE5;
	Sat,  3 Feb 2024 17:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n18oecog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4C1187A4B; Sat,  3 Feb 2024 17:38:14 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 438BE87BDC
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 17:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-603fdc46852so32126727b3.2
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 08:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706978290; x=1707583090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+SbtxPaLs0sI6B8Aif8NsZLo5lvyC+gWqu8P/RNRM8=;
 b=n18oecog1h5d8UcY+0goc0u5vgvfnnyaIzQKGS6SzRekBp1NHCuEg9kF4gCQhdcQzh
 k2qK+PPDg2mNhvJjJdhIW+KsQIYst5HPAEq0UbiKvu9FJhRF+K9pc2IPuaoS/teZwnJ9
 RJkv2D03ptV2hcLWz4xC+CzYzrFk/zAamkxGGbT/q1Oay/5eI4Idc0373C4SgK6DXMix
 imnwJeGsGl8+ytZ17st2Qu/+RtVyMI3AVMye4nLbc7noy71WUufLoUumTSwgqv9NiuMq
 DXkrl4NSu1pR1Y14aYjc6MCs80ONX+GNS/HGhJxiVSJLSk2W7i9uuefyyDBnfEWPgHtV
 TrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706978290; x=1707583090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+SbtxPaLs0sI6B8Aif8NsZLo5lvyC+gWqu8P/RNRM8=;
 b=fpxoSQGNGGrLDkTJWcULgzOjkrOhXnGeOpMR1pdvwkNDCVSE+/1awgP57tNM6ngJxG
 d1i7LpSAZGgYhcjw6mvu0ljkRsw3SbplAtSDkU0s2epAVQuO0LMER1TLnx8hJDqTff4t
 Fvjuvar+bLmSaY7m6p7yrYWx6vaoXIOf4mCEgYy8PHqNjFdo3XCsIK+hjBkZGDZC5s/T
 a6LKJ0E0+T9llpovfhjMOKBp3TP6/QhZJnYcrDlOOirodfXGyJrxUJ7Dc3K3gnKs9UzM
 mhoL7OFsz3s3ayX188uA4ftkEkxQydkbmX7PdbArcMmiBqy4Z5s5JG10aNeQODpdwLXE
 py4g==
X-Gm-Message-State: AOJu0YybGo8AwinqcPIbPWbAUVZHPiykm6IQYuKmAN2Zag6xkCfuJKSi
 mcNzF6kVC258UffP8ZgG0x1IuQjoPTKvWyUK4TmmGFg/3YkkEKVyhaCi7dgjuzAs3CIRQlGPaeo
 E
X-Google-Smtp-Source: AGHT+IGtQ3lSNywXdc1AeddgGII9K2BYmxHP95+tKsokkrRdzNHrnlardvq7JTtGRFL9MskuE2HBSg==
X-Received: by 2002:a81:bd0c:0:b0:602:9ec9:e6f2 with SMTP id
 b12-20020a81bd0c000000b006029ec9e6f2mr11152195ywi.27.1706978290565; 
 Sat, 03 Feb 2024 08:38:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWDw9MwE77Ns0pFimYxfgy+1vRRSavTR0rtKu6T/mFBXnScnS6bZ1dleXBSKWnxb0HdY4aVKrevZDeWDu0ONk9xKHUwt2tQQC3Dv/rYhdjSOiBkv74mlBWeMIrfQCs+pu+DkyNLvfvcowwXl73vYw/A14qk3u+uf3lKIV35ZsKyY1X8C62lqxbtW07qncRnLPO9QNJrix2EtXd181GsPDhDHpr1lmq56KEdjCsdAFHwgP7/tLpA+N9xSLzX77MXLRikhwv3jcI07izR1tH2hgxyr1cloQIoB08kLxwMrHVMxtevpKzAQmAcB/E3HX+CJYSBxsDGgL1BJ3WV9eR5YHrfZNOgP9hbT9m9hmJlH8aaqJpL38Ehvywp9brbESK6JssXDmbyPpXFvbVbmw93SU9PrlEU99r5zScBuVaXmirRlZ04DW6Z5962aJjDA4UVP4K9vrFVWupeIO8igYhm7cKPWCar
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 oj16-20020a056214441000b006869d54c818sm1909086qvb.109.2024.02.03.08.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 08:38:10 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v8 7/8] bloblist: Load the bloblist from the previous loader
Date: Sat,  3 Feb 2024 08:36:26 -0800
Message-Id: <20240203163631.177508-8-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240203163631.177508-1-raymond.mao@linaro.org>
References: <20240203163631.177508-1-raymond.mao@linaro.org>
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

