Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44948C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88B1D87F6E;
	Tue, 12 Mar 2024 15:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FOkFceJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574A987F5E; Tue, 12 Mar 2024 15:08:44 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B03B87F56
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso6546950a12.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710252522; x=1710857322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axqi5l4Ztq3WiIi5s/5Po9WAHf/Ep2gUDdwyUWhnccw=;
 b=FOkFceJzjYwo6ibVUSURL4TdGsNySKCdX+xNhMZMNLnyK0gOPSAc1T3EIFJrTKUn7S
 /Yku3Klc+qBhbU/U31pktx8b5X2Uwfu2CUPhMLKzgd3jcTHucZRVm8cj0JqXm1oZAu3p
 QYwjK830N+1la2M+fWXoFbFBMTRwQmGu3Hm7kmru/l0M+E/pqg7fzWyTl9/YARhIJp98
 msVNwNtU+Hrhcde9Gc7XekrkQf2JWihDK2zk747pDi9ZLaQOetwvC+lLy0k3tf31SbMI
 Y4xWnnNPEAhs3BJK4mtoC+m8AqJFH8aVEBPi6xSbMhjlXmhDogSdSkgSLXZtVbKlrLDf
 ExiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710252522; x=1710857322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axqi5l4Ztq3WiIi5s/5Po9WAHf/Ep2gUDdwyUWhnccw=;
 b=mjYjM7XFF/O9XETK9NWUlrnBExwfzTkksSx6rdtQ/z7aYhO6DdaTl+L32XiBVW5bkB
 uwOF3zNDcevS9iRElnhvQ8S0HuZyJ1wjlsRl7hMYF+jcw67/zvVDuMsE17C2GSAjLBCT
 xEaKRiSlLqlY8oh3Y9Mtt+XavtydUJazJqYN7WERqv3lW9042slFfQiMaS+EeAJqJrlc
 +q5KLE0c7E1zATfiKtN4gl/Zg8UqamLK5Ym+1eWi3XZVMDXNOCua/49IvA8xJKDk1w4j
 7czo2wT2Iy+CY0VngiXsVGQmNVGXv4t+WNGsl5Ji2H249x+d4smr5IdujCZmmUZorrYY
 zzZA==
X-Gm-Message-State: AOJu0Yxxpu+1FkWwtl98mwsIeUxdfkeVA4gX+jS8HVXYn1kO/zrFPdLq
 oRQXexqxjMY3Db7K+2Dco+Mhce0fStWNewh6gPK4MvkwgRcRpEsLuwW9zmeSwf2DIV4qvY29BCf
 2I9I=
X-Google-Smtp-Source: AGHT+IE54YP0QBPmQg5Jb8ocQ5Z8Dpoa03OiUd9Nwa54ih0almygQP2WPixS0XsQz2iYikTmmai+7g==
X-Received: by 2002:a50:8ad7:0:b0:567:15a6:848e with SMTP id
 k23-20020a508ad7000000b0056715a6848emr6847525edk.18.1710252521706; 
 Tue, 12 Mar 2024 07:08:41 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a056402001700b0056857701bf5sm2246086edu.81.2024.03.12.07.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 07:08:40 -0700 (PDT)
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
Subject: [PATCH 1/7 v2] arm: baltos: remove custom linker script
Date: Tue, 12 Mar 2024 16:08:23 +0200
Message-Id: <20240312140832.1968215-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
References: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
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

