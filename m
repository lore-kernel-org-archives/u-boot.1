Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0190C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 16:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D00E87EB7;
	Wed, 13 Mar 2024 17:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UlVWtSGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A908272A; Wed, 13 Mar 2024 17:23:37 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3009387EA8
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 17:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a36126ee41eso978066b.2
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710347014; x=1710951814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axqi5l4Ztq3WiIi5s/5Po9WAHf/Ep2gUDdwyUWhnccw=;
 b=UlVWtSGCqSJA5FZ67DAdniQYfEJPKFm6TAwdbayksSfyo00H/BOEhqMzJhvhglA2ro
 u2RqQzULio3K/xpK2Oso1g2RfDN0AWnPa/dQ54EB4kaC0LCEYmj73XoWcD9Yff+DOf5I
 Cpuz8nTAOhqmJIECyUd5cJrOha++6q9EMbyLAZxe/mJPw9/CQkbmELaTOGevFGBS+ETu
 /owvefH434kUHyRWxoHjvyIRVSltFSo964yAkTfIlwC0kDOQil+hHZXSiRCz8LJNtxMX
 UnQlde6i2L09m2dPtjTN4hT6EfNMPBA6vo5YW68ZhWxvMZy7Ka3Ugm485WnrZ/flzfrV
 7A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710347014; x=1710951814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axqi5l4Ztq3WiIi5s/5Po9WAHf/Ep2gUDdwyUWhnccw=;
 b=Mti1O8m6l/zR8Cnfg1IswXfHt6ArFEz421z/4vaxB5b3l/+kdLzz6Z5e/jv+eqq1R/
 ZHqY6bMbKPuWj247ok1mqm3LUO/V6d6sq9LqK7XqGa9LSu+jWmBCHYF1+bdRaJ4fHlcb
 AhNLWWTy4QlXM8iBi9fSEmt/0C+raay8dSlwR4zrpHuK83hJTwHanvSDvRLAfY2JaKXc
 oAM9svKHbO/ok3cAcqyAZE4td6H+hNbKX6osvEa8pwPnJ7/TAbTZ+cA8oR+Wk/3DUIv+
 MeLtdXjbBC8CykKfX3HvxWkJPh/nF85Y9YLG8DmpLAag3hK8dNpSlMdI2Bul7ih5gDwc
 jH2w==
X-Gm-Message-State: AOJu0YwnoutmxXPJXf8R5WspxN6kukLDxIZrhHFaxL0bo08b7PC8GJ4m
 EUqFZqst5txtHKa9k4Qgs0wKXX/7TnrlzbKIFbiR62yjzvxjna0JKzIwF/sXSkWVb9SBC8vPvrk
 v
X-Google-Smtp-Source: AGHT+IGL3HrrWa3oeffGLS0Fm5mVN3z2xjzseb2lVXwYTxeXkO3CvUJlH4YChLsMtyJC+Nr/n9Au0A==
X-Received: by 2002:a17:906:4ac1:b0:a40:bff7:6e73 with SMTP id
 u1-20020a1709064ac100b00a40bff76e73mr8244218ejt.36.1710347014520; 
 Wed, 13 Mar 2024 09:23:34 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 bh21-20020a170906a0d500b00a44efa48c24sm4998860ejb.117.2024.03.13.09.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 09:23:34 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 richard.henderson@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <CFSworks@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [PATCH v3 1/7] arm: baltos: remove custom linker script
Date: Wed, 13 Mar 2024 18:23:15 +0200
Message-Id: <20240313162324.2117909-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
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

