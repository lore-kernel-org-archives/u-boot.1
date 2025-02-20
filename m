Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFF8C021AA
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 00:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1815E80A46;
	Thu, 20 Feb 2025 01:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gX99vqtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5888980805; Thu, 20 Feb 2025 01:02:39 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B3480F0A
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 01:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46fcbb96ba9so4569471cf.0
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740009754; x=1740614554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=73JxOZeDBuAGD3nxq93wx03OHZWobPlrutawG4H65BE=;
 b=gX99vqtxkhrcRk5iQ39THBjdNxJ86cBMrUJNR9dN3MEU9I1g9mrK0ldLbgw9x4b0vH
 LGwD1ljRORSsODo25c8v9a3cGrrLommrSc7TqjS4LvA4v/fZ6GrnCr4iGVzs0l+jBDj6
 kg0DSPz80Frtu3gPs6IJrQLQnCH/tOGZD4PCrLwVgO07JZ4F8J/9COpRNo1ioarsV/mE
 5tYCaDjnWnyX79xN7jWiiWyb4npfUAnNrpGL1GGwrUey7fEDHICKUm/Ewjyl790cnYmX
 N8FDbzdOLbPOxg/gknKt+FLtZDGWppzGaAa5FL5fTtgFD32O8W4U8k7p30dOd5cmt3F6
 iKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740009754; x=1740614554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73JxOZeDBuAGD3nxq93wx03OHZWobPlrutawG4H65BE=;
 b=M3mpuXEOZ8Y7qbkN0xhozXhVoJPyElLxZ+TpZcvPbLasWBYCs0zLo+OgndeQoUJLJP
 ZT6fftu0aRtQMg5ce/4fPSJfMeoNsfhytIXmE0C0qBUWizfKdyzNIh9JcApeoK8bNVHD
 cUpT13NeVlbHTfUYxTlQrym84ma4G7nKBix6S4V97s/X2ZgBeWaLoWMnHyPvKrFF7/3q
 vJeQqzS8aNfZvpj2qojEMpPvE8j53DPzdSX73QBhBVdbAwYHknT4d7s4OOZMtp3mZp9y
 nOL161XEuAwTYVvjiY0i0j+ospOCHnYyPHUzctfbMC3jD7UWm6sW8MTU1g8Q9nH8zDki
 M6XQ==
X-Gm-Message-State: AOJu0Ywm9lrKEIf6S0F2SSVLFL4u0TZxshgSUpwovdMJvYCZdyBfCPjq
 mPVFmF6Hau7xOInEZ0jhJz4PX/JcpzldfnEnNUFSUz5t6Hnme+qH4fAFYkJbey/sS/bpTodhxyr
 gwEg=
X-Gm-Gg: ASbGncvfpY2g3gr9CWN/1rKZW0EC2/U6Tb1UZkmCLoyvvd47vCHrmQPllqkY9wui02G
 SM3zu5ymDj10qvBlSnnaMW79M2B/nB7lSgEATEq8PhDwRJ96iaHbQ7HZ6d5gykMN52dqS7Wtp1p
 GBy73mWfVrw0ZVfnvS5ZPFlb7FafQaM9YYVbt/tvIBw3jqeLcHa+LjN5LPavhKtniGvUAODFwUb
 54SA6t+qUyQvDCtWMkrAOnF5KW6LbKh9S5g+uD0fJ/I288ILs7StX90cxCB7pkfIjirKwegPCAd
 kufPlH7Kalxu7q+Fbs9Y2H4BEcEoB58ZGV01KI+b
X-Google-Smtp-Source: AGHT+IHWDwsWq2JFMmNpIsfmgYSCTp3F5jwG+audf/ENj7bbgEvKrKk/7J24AbTmRfexiwBPp3eFGg==
X-Received: by 2002:a05:622a:19a5:b0:472:e9:59ff with SMTP id
 d75a77b69052e-47200e95b74mr130294611cf.19.1740009753965; 
 Wed, 19 Feb 2025 16:02:33 -0800 (PST)
Received: from ubuntu.localdomain ([209.227.153.148])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4720bc52905sm11510361cf.26.2025.02.19.16.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 16:02:32 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Stefan Roese <sr@denx.de>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Richard Weinberger <richard@nod.at>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH v2 1/2] bloblist: refactor xferlist and bloblist
Date: Wed, 19 Feb 2025 16:02:19 -0800
Message-Id: <20250220000223.1044376-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Refactor the xferlist to remove the relocating when bloblist passed
from the boot args.
Refactor bloblist init to use incoming standard passage by default
if a valid transfer list exists in the boot args.
For bloblist relocation, use the actual total size if it has a smaller
BLOBLIST_SIZE_RELOC.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2:
- Call bloblist_check_reg_conv() inside bloblist_check() to check arg1 and arg2 first.

 arch/arm/lib/xferlist.c | 12 +++----
 common/bloblist.c       | 73 +++++++++++++++++++++++------------------
 common/board_f.c        | 24 +++++++++-----
 include/bloblist.h      | 11 +++----
 4 files changed, 66 insertions(+), 54 deletions(-)

diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
index f9c5d88bd47..6425936d354 100644
--- a/arch/arm/lib/xferlist.c
+++ b/arch/arm/lib/xferlist.c
@@ -8,18 +8,16 @@
 #include <bloblist.h>
 #include "xferlist.h"
 
-int xferlist_from_boot_arg(ulong addr, ulong size)
+int xferlist_from_boot_arg(ulong *addr)
 {
 	int ret;
 
-	ret = bloblist_check(saved_args[3], size);
-	if (ret)
-		return ret;
-
 	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
-				      saved_args[1]);
+				      saved_args[1], saved_args[3]);
 	if (ret)
 		return ret;
 
-	return bloblist_reloc((void *)addr, size);
+	*addr = bloblist_get_base();
+
+	return 0;
 }
diff --git a/common/bloblist.c b/common/bloblist.c
index 31ba0311090..f1bbb4ab13e 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -505,8 +505,7 @@ int bloblist_reloc(void *to, uint to_size)
 /*
  * Weak default function for getting bloblist from boot args.
  */
-int __weak xferlist_from_boot_arg(ulong __always_unused addr,
-				  ulong __always_unused size)
+int __weak xferlist_from_boot_arg(ulong __always_unused *addr)
 {
 	return -ENOENT;
 }
@@ -514,37 +513,39 @@ int __weak xferlist_from_boot_arg(ulong __always_unused addr,
 int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
-	int ret = -ENOENT;
+	int ret = 0;
 	ulong addr = 0, size;
-	/*
-	 * If U-Boot is not in the first phase, an existing bloblist must be
-	 * at a fixed address.
-	 */
-	bool from_addr = fixed && !xpl_is_first_phase();
-	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
-		from_addr = false;
-	if (fixed)
-		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
-				      CONFIG_BLOBLIST_ADDR);
-	size = CONFIG_BLOBLIST_SIZE;
 
+	/* Check if a valid transfer list passed in */
+	if (!xferlist_from_boot_arg(&addr)) {
+		size = bloblist_get_total_size();
+	} else {
+		/*
+		 * If U-Boot is not in the first phase, an existing bloblist must
+		 * be at a fixed address.
+		 */
+		bool from_addr = fixed && !xpl_is_first_phase();
+
+		ret = -ENOENT;
 
-	/*
-	 * If the current boot stage is the first phase of U-Boot, then an
-	 * architecture-specific routine should be used to handle the bloblist
-	 * passed from the previous boot loader
-	 */
-	if (xpl_is_first_phase() && !IS_ENABLED(CONFIG_BLOBLIST_ALLOC))
-		ret = xferlist_from_boot_arg(addr, size);
-	else if (from_addr)
-		ret = bloblist_check(addr, size);
+		if (xpl_prev_phase() == PHASE_TPL &&
+		    !IS_ENABLED(CONFIG_TPL_BLOBLIST))
+			from_addr = false;
+		if (fixed)
+			addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+					      CONFIG_BLOBLIST_ADDR);
+		size = CONFIG_BLOBLIST_SIZE;
 
-	if (ret)
-		log_warning("Bloblist at %lx not found (err=%d)\n",
-			    addr, ret);
-	else
-		/* Get the real size */
-		size = gd->bloblist->total_size;
+		if (from_addr)
+			ret = bloblist_check(addr, size);
+
+		if (ret)
+			log_warning("Bloblist at %lx not found (err=%d)\n",
+				    addr, ret);
+		else
+			/* Get the real size */
+			size = gd->bloblist->total_size;
+	}
 
 	if (ret) {
 		/*
@@ -569,6 +570,7 @@ int bloblist_init(void)
 		log_debug("Found existing bloblist size %lx at %lx\n", size,
 			  addr);
 	}
+
 	if (ret)
 		return log_msg_ret("ini", ret);
 	gd->flags |= GD_FLG_BLOBLIST_READY;
@@ -589,10 +591,11 @@ int bloblist_maybe_init(void)
 	return 0;
 }
 
-int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
 {
 	u64 version = BLOBLIST_REGCONV_VER;
 	ulong sigval;
+	int ret;
 
 	if ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
 			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) {
@@ -603,8 +606,14 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
 			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
 	}
 
-	if (rzero || rsig != sigval ||
-	    rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
+	if (rzero || rsig != sigval)
+		return -EIO;
+
+	ret = bloblist_check(xlist, 0);
+	if (ret)
+		return ret;
+
+	if (rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
 		gd->bloblist = NULL;  /* Reset the gd bloblist pointer */
 		return -EIO;
 	}
diff --git a/common/board_f.c b/common/board_f.c
index 6c5c3bfab48..2912320054f 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -624,11 +624,14 @@ static int reserve_stacks(void)
 static int reserve_bloblist(void)
 {
 #ifdef CONFIG_BLOBLIST
+	ulong size = bloblist_get_total_size();
+
+	if (size < CONFIG_BLOBLIST_SIZE_RELOC)
+		size = CONFIG_BLOBLIST_SIZE_RELOC;
+
 	/* Align to a 4KB boundary for easier reading of addresses */
-	gd->start_addr_sp = ALIGN_DOWN(gd->start_addr_sp -
-				       CONFIG_BLOBLIST_SIZE_RELOC, 0x1000);
-	gd->boardf->new_bloblist = map_sysmem(gd->start_addr_sp,
-					      CONFIG_BLOBLIST_SIZE_RELOC);
+	gd->start_addr_sp = ALIGN_DOWN(gd->start_addr_sp - size, 0x1000);
+	gd->boardf->new_bloblist = map_sysmem(gd->start_addr_sp, size);
 #endif
 
 	return 0;
@@ -698,11 +701,14 @@ static int reloc_bloblist(void)
 		return 0;
 	}
 	if (gd->boardf->new_bloblist) {
-		debug("Copying bloblist from %p to %p, size %x\n",
-		      gd->bloblist, gd->boardf->new_bloblist,
-	gd->bloblist->total_size);
-		return bloblist_reloc(gd->boardf->new_bloblist,
-				      CONFIG_BLOBLIST_SIZE_RELOC);
+		ulong size = bloblist_get_total_size();
+
+		if (size < CONFIG_BLOBLIST_SIZE_RELOC)
+			size = CONFIG_BLOBLIST_SIZE_RELOC;
+
+		debug("Copying bloblist from %p to %p, size %lx\n",
+		      gd->bloblist, gd->boardf->new_bloblist, size);
+		return bloblist_reloc(gd->boardf->new_bloblist, size);
 	}
 #endif
 
diff --git a/include/bloblist.h b/include/bloblist.h
index 98aacf52733..8156ef725d3 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -501,19 +501,18 @@ static inline int bloblist_maybe_init(void)
  * @rfdt:  Register that holds the FDT base address.
  * @rzero: Register that must be zero.
  * @rsig:  Register that holds signature and register conventions version.
+ * @xlist: Register that holds the transfer list.
  * Return: 0 if OK, -EIO if the bloblist is not compliant to the register
  *	   conventions.
  */
-int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
+int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist);
 
 /**
- * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
- *			      to the specified address.
+ * xferlist_from_boot_arg() - Get bloblist from the boot args.
  *
- * @addr: Address for the bloblist
- * @size: Size of space reserved for the bloblist
+ * @addr: Address of the bloblist
  * Return: 0 if OK, else on error
  */
-int xferlist_from_boot_arg(ulong addr, ulong size);
+int xferlist_from_boot_arg(ulong *addr);
 
 #endif /* __BLOBLIST_H */
-- 
2.25.1

