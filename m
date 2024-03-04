Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20240C54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 09:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1942487F6F;
	Mon,  4 Mar 2024 10:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HBRPtcP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32EC87F28; Mon,  4 Mar 2024 10:01:26 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C864686FCE
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 10:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412e72b0d96so1328405e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 01:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709542881; x=1710147681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axqi5l4Ztq3WiIi5s/5Po9WAHf/Ep2gUDdwyUWhnccw=;
 b=HBRPtcP/RjSUwGW3LFJALF+sSXASy1gxf5HZKrtGOCWjCVNOUqN4QRLoTCtrM7Qe6u
 HrbuD/l8YxeexkFVSzseqvpNINS6SgyAqaVT9qW1uP+hK+IRJy1f0huhVaFxZXqy5czN
 48tuYfaMVzBseqB1Zu5IatJzS0VIogCCvDbK6LMqZuVZI57dqxH4Gvgz5PABtMUUgO/x
 iInuWwBAJZSSvC/u9EhuO/4Pcx4C74Q3ujCB6fs9zB2tBlTofr4CQWfvBspj1rqcgo+3
 DTgs+oppyRF4lbU4vJzGhM2F/lBsOf7P88t59d+nhudNHnHd5OIXRBVinHUaaKFL8xD4
 kG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709542881; x=1710147681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axqi5l4Ztq3WiIi5s/5Po9WAHf/Ep2gUDdwyUWhnccw=;
 b=GQnFnOWOswR6onGHT4shHDaqhR9AThWely4/KOmpO6w5NJ4UuNBxPSH0H74vZXuWqb
 IRaq4Pc3YhPCqVDDUQjjd7HlsoRkxp3vox/BPAv4pD1FOPw7xGwwD2A6jaAee2u7GOOP
 CLHxPsRurhJrsipkepaNcvxAUGs/6nouxYL2OMYAEV1r5IIa5AkpnY1+Di9Rfv0UmUs1
 PqJO0Me6eiVFN4o29q4lrIN3G9fTx6KUqgPBonE2V9x9Cpi1Zz4ZVaMhvlzmnS0EGC9M
 D3y6kiR+5ClxYABtStRw25NnU869+i3sZcEawg0IjdPDhun49J3boB1RG6yVpAPtEPFQ
 Nd6Q==
X-Gm-Message-State: AOJu0YxI/+Nh5HdtmRHY6orKtEcY3AJ4gfEQljKgDkq78tLic8fea0DQ
 8PHMt/bbWHeMqMixXKcS0kU0Ae3aAz5LnaBKAQ0yE1AmyqIq+nxEThijr6cMzv8jBSF6xOcVc+4
 jaWI=
X-Google-Smtp-Source: AGHT+IH2vO5q1LRKSUptH+pdnT0W8bS3df9C5KDgoqDs6ICooi5gq1gCDn/j0hH/Xfc4RbOEwxtJwA==
X-Received: by 2002:a05:600c:4451:b0:412:e65a:a20 with SMTP id
 v17-20020a05600c445100b00412e65a0a20mr654546wmn.13.1709542881221; 
 Mon, 04 Mar 2024 01:01:21 -0800 (PST)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c198b00b00412c8117a34sm10281167wmq.47.2024.03.04.01.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 01:01:20 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH 1/6] arm: baltos: remove custom linker script
Date: Mon,  4 Mar 2024 11:01:06 +0200
Message-Id: <20240304090113.1410575-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
References: <20240304090113.1410575-1-ilias.apalodimas@linaro.org>
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

commit 3d74a0977f514 ("ti: am335x: Remove unused linker script") removed
the linker script for the TI variant. This linker script doesn't seem to
do anything special and on top of that, has no definitions for the EFI
runtime sections.

So let's get rid of it and use the generic linker script which defines
those correctly

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 board/vscom/baltos/u-boot.lds | 128 ----------------------------------
 1 file changed, 128 deletions(-)
 delete mode 100644 board/vscom/baltos/u-boot.lds

diff --git a/board/vscom/baltos/u-boot.lds b/board/vscom/baltos/u-boot.lds
deleted file mode 100644
index cb2ee6769753..000000000000
--- a/board/vscom/baltos/u-boot.lds
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * Copyright (c) 2004-2008 Texas Instruments
- *
- * (C) Copyright 2002
- * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
- *
- * See file CREDITS for list of people who contributed to this
- * project.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
- * MA 02111-1307 USA
- */
-
-OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
-OUTPUT_ARCH(arm)
-ENTRY(_start)
-SECTIONS
-{
-	. = 0x00000000;
-
-	. = ALIGN(4);
-	.text :
-	{
-		*(.__image_copy_start)
-		*(.vectors)
-		CPUDIR/start.o (.text*)
-		board/vscom/baltos/built-in.o (.text*)
-		*(.text*)
-	}
-
-	. = ALIGN(4);
-	.rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
-
-	. = ALIGN(4);
-	.data : {
-		*(.data*)
-	}
-
-	. = ALIGN(4);
-
-	. = .;
-
-	. = ALIGN(4);
-	__u_boot_list : {
-		KEEP(*(SORT(__u_boot_list*)));
-	}
-
-	. = ALIGN(4);
-
-	.image_copy_end :
-	{
-		*(.__image_copy_end)
-	}
-
-	.rel_dyn_start :
-	{
-		*(.__rel_dyn_start)
-	}
-
-	.rel.dyn : {
-		*(.rel*)
-	}
-
-	.rel_dyn_end :
-	{
-		*(.__rel_dyn_end)
-	}
-
-	.hash : { *(.hash*) }
-
-	.end :
-	{
-		*(.__end)
-	}
-
-	_image_binary_end = .;
-
-	/*
-	 * Deprecated: this MMU section is used by pxa at present but
-	 * should not be used by new boards/CPUs.
-	 */
-	. = ALIGN(4096);
-	.mmutable : {
-		*(.mmutable)
-	}
-
-/*
- * Compiler-generated __bss_start and __bss_end, see arch/arm/lib/bss.c
- * __bss_base and __bss_limit are for linker only (overlay ordering)
- */
-
-	.bss_start __rel_dyn_start (OVERLAY) : {
-		KEEP(*(.__bss_start));
-		__bss_base = .;
-	}
-
-	.bss __bss_base (OVERLAY) : {
-		*(.bss*)
-		 . = ALIGN(4);
-		 __bss_limit = .;
-	}
-
-	.bss_end __bss_limit (OVERLAY) : {
-		KEEP(*(.__bss_end));
-	}
-
-	.dynsym _image_binary_end : { *(.dynsym) }
-	.dynbss : { *(.dynbss) }
-	.dynstr : { *(.dynstr*) }
-	.dynamic : { *(.dynamic*) }
-	.gnu.hash : { *(.gnu.hash) }
-	.plt : { *(.plt*) }
-	.interp : { *(.interp*) }
-	.gnu : { *(.gnu*) }
-	.ARM.exidx : { *(.ARM.exidx*) }
-}
-- 
2.37.2

