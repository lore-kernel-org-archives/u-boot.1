Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1F5C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B14680C96;
	Thu, 13 Feb 2025 15:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BbwS5mbB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EEF80EBD; Thu, 13 Feb 2025 15:25:54 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 742A380A55
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-471c15c24f0so5703851cf.1
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739456751; x=1740061551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZuStnbPTgAi1qMkVvC1rzvhuSbqEpXuQ8dy013TbVyQ=;
 b=BbwS5mbBljz2viXIbBgtunP1oQ16Dpc3uqB9njY4Fi+Pbal+nCHtceyc3Qb385SpyS
 Xt8ykDnpcCZXOVISRbWapF7cogZgMpXgKJMHb12ov8qYq3ILaANVpgserEld5Kiy3ZS2
 crd/5mMjFVc5fOldtDa4+CrFRQiRuYd6T7muk99ksPYvXqb0SrPGMJHiKGlC9bu31sqN
 5K31Au/4VUD/Sfznsk+6ovxOtv0TaI/IXH1NsEvyJ/YYA2aW4XmNc10ZiGenxNx7QENa
 UDs0syzTC+mAXI79XUWlXNX8PnywoInbLlhG58vPjEDfJpMDXr2YIb0X819LQ955RY8N
 dYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739456751; x=1740061551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZuStnbPTgAi1qMkVvC1rzvhuSbqEpXuQ8dy013TbVyQ=;
 b=OeZT2VFIA8dE7E9Y4+v1jJF9TXSGXjjaM+CUPEPlsVRCDarkTUpdNFBJeI5d8gJheZ
 IEaI2iFhr6NjKynlpGQn0Z94zaOBGzBgn7xRE6lUcEDoqoUMD7QuwUvpMpDicW9AJ+qw
 wUShAwCUS7LNjB7aLUb0hmtbM9obB0Hs2YIe9qshXDInZYDMh+F9waiR4lF7AnSSRQHs
 Yw6DGjUC0V92PNZQ6lVSW2ABH/xo/Iyg3QquGrKufUdbChgv+QsCwGzzkWdT1UwNP5Dt
 zNvlKuhK/diaenSbzIoup8n8CkIuoSzNtoQ1OWadBqgWvDWfJKBBGH+0cQcr2IUuy4aQ
 1zxQ==
X-Gm-Message-State: AOJu0YyfHZK19RfJr17GDhHufE1l9lJ0kC+iM/xrXQ6/6NvEmeB6Oskv
 yo2TU83Ket2KWurM9JDErMM5sR/RBPHGNVvQELE9yXcOt/Wbzv/LkJBRZauZa0niicJZ42r9LNq
 3RJ0=
X-Gm-Gg: ASbGncsaH6FcFpQgv19qcRyw2lHpgXDbgvY9QA91RG9+9I+1EG8VbMvF1xGF26eQf8f
 QtggYZgKkAwhAXGeKhXo9Vbs6EUC231Uy3mharv7POfpJRRGZYDMr4+7zXrwZrWdA8/+OlH/EJ7
 7LHsmPDh525ZqxX4PPsSFVHg4ut3JbGm8kMYn81hRs2lnIiADJczVeXXMiOfzVFBV2J+AEqtJ+X
 fpzvnZMglUbHuunLZdN59fySAagw0+Y3IylAppTRaM6GVmxyuf21I8ZIC9QTu4SlB+xI8u/xHAy
 oDTOgulS96vivwOo9BX/AFSbuU3ZcY5wlyzrjZPgx0m/SEnkK2Fo0jF7T4qTAQUoX2ivx6nGeSx
 KqBQtokA39J+gXA==
X-Google-Smtp-Source: AGHT+IHZ0VYpBGAYtMEISn2P+ZC7Ijd1Sjo/8oYzwpIMq0ayjPjbWAV46JM+geJ0uRQWzxVRBwbEGw==
X-Received: by 2002:ac8:58cc:0:b0:471:ba79:cf31 with SMTP id
 d75a77b69052e-471ba79d22fmr89267991cf.49.1739456750741; 
 Thu, 13 Feb 2025 06:25:50 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2a4c1b4sm8473801cf.48.2025.02.13.06.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 06:25:49 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>, Jonas Karlman <jonas@kwiboo.se>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Richard Weinberger <richard@nod.at>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH 1/2] bloblist: refactor xferlist and bloblist
Date: Thu, 13 Feb 2025 06:25:33 -0800
Message-Id: <20250213142538.928937-1-raymond.mao@linaro.org>
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
---
 arch/arm/lib/xferlist.c |  8 +++---
 common/bloblist.c       | 60 +++++++++++++++++++++--------------------
 common/board_f.c        | 24 ++++++++++-------
 include/bloblist.h      |  8 +++---
 4 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
index f9c5d88bd47..9c39ae0ccac 100644
--- a/arch/arm/lib/xferlist.c
+++ b/arch/arm/lib/xferlist.c
@@ -8,11 +8,11 @@
 #include <bloblist.h>
 #include "xferlist.h"
 
-int xferlist_from_boot_arg(ulong addr, ulong size)
+int xferlist_from_boot_arg(ulong *addr)
 {
 	int ret;
 
-	ret = bloblist_check(saved_args[3], size);
+	ret = bloblist_check(saved_args[3], 0);
 	if (ret)
 		return ret;
 
@@ -21,5 +21,7 @@ int xferlist_from_boot_arg(ulong addr, ulong size)
 	if (ret)
 		return ret;
 
-	return bloblist_reloc((void *)addr, size);
+	*addr = bloblist_get_base();
+
+	return 0;
 }
diff --git a/common/bloblist.c b/common/bloblist.c
index 31ba0311090..0a6ecf7277f 100644
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
 
-	/*
-	 * If the current boot stage is the first phase of U-Boot, then an
-	 * architecture-specific routine should be used to handle the bloblist
-	 * passed from the previous boot loader
-	 */
-	if (xpl_is_first_phase() && !IS_ENABLED(CONFIG_BLOBLIST_ALLOC))
-		ret = xferlist_from_boot_arg(addr, size);
-	else if (from_addr)
-		ret = bloblist_check(addr, size);
+		ret = -ENOENT;
 
-	if (ret)
-		log_warning("Bloblist at %lx not found (err=%d)\n",
-			    addr, ret);
-	else
-		/* Get the real size */
-		size = gd->bloblist->total_size;
+		if (xpl_prev_phase() == PHASE_TPL &&
+		    !IS_ENABLED(CONFIG_TPL_BLOBLIST))
+			from_addr = false;
+		if (fixed)
+			addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
+					      CONFIG_BLOBLIST_ADDR);
+		size = CONFIG_BLOBLIST_SIZE;
+
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
index 98aacf52733..691bd2e8544 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -507,13 +507,11 @@ static inline int bloblist_maybe_init(void)
 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
 
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

