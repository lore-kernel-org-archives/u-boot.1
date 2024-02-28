Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8A9C54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 10:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7419387D7E;
	Wed, 28 Feb 2024 11:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cAqrbtHd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D21387ECC; Wed, 28 Feb 2024 11:48:36 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CE778800C
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:48:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412a3371133so24250765e9.2
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 02:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709117313; x=1709722113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0q8g5g/mbTqm5EkO78PISZ6mP9TphYlAc5QG72jqGRs=;
 b=cAqrbtHdZiktuxHAK2I72aKoacUYp7GU3rm+aI4hFa2EMZvY0lOYT+DxYZ8ZUw1cB6
 nTwvwiYwFj1JbhIxo8c2IJXuWY4JuQQJEbldOooAluoKrx0lqPJ2hpt8DntZaIY7hHhm
 88Q7wYadSbYd804/RYucRwsYr6R+h1fty4KB2hSexiue6H+bWqhro0ywbkmeAccqkOUa
 rLU1CQ3rDjbWkFP54YHMp2mxat2lMLxl4KPvWZldaJzpEHS/9k/iZ6sSWkviRwJBVvfb
 vuvZmz1MaHEmPt4ArV+Z/KOKhXcJLQDVyQtrf3+j+m08phng8SJMWgsZVL9vguHJJ7li
 vjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709117313; x=1709722113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0q8g5g/mbTqm5EkO78PISZ6mP9TphYlAc5QG72jqGRs=;
 b=gpzQFJaYGViPceRKvxeeO4I6x3H84Pmh3L0g78iHgmI73nAfBS/wRYcQ1sGMCInl2h
 0CkxZpOF4BCYKxDiucY8YHslbwwjW1sRBIu8tcZACSwJ2dlW8nbN1YpEOzneWYl1HitO
 VfBNiXZ9KijjV+tIjywzivmVqFlkmrawCNAfn4VstO83xdSOtpm1goOB9NsNBkCLW52h
 mcs8tkxOhmSoLAWorwgRiqg3nzrs0uW0FkrGdWYB+O22bvvw23dtb6iKEuKHXOFt5GTU
 EXkEWc8naxExBmvpDnXfe/N0wc5S9Kv2t1P2pMDYQig6Chg65H2Od2GMsNAyyCNGSbod
 RiGA==
X-Gm-Message-State: AOJu0YwkSR7MML73DksXq0Gi7NITTjIxCFqWJXrEg90hfvAXSgjxpPau
 WXw2NlKl4r6Waj+7OKiNsqmESJZYW1Bzl37sA6dH8J2gKiL/pZ7zFbTUtdXVHQcuGTdj91izIBU
 NxhY=
X-Google-Smtp-Source: AGHT+IHx9rfUXqlvhe/mos58xvgCxM7Gl+/oNYPideFJ4pp4P0OtZ1rWt9DPSOupmEX39qAZfgWYbw==
X-Received: by 2002:a05:600c:138f:b0:411:a5f9:26f5 with SMTP id
 u15-20020a05600c138f00b00411a5f926f5mr10540473wmf.38.1709117313543; 
 Wed, 28 Feb 2024 02:48:33 -0800 (PST)
Received: from hades.. ([78.87.146.252]) by smtp.gmail.com with ESMTPSA id
 x1-20020a05600c2a4100b00410dd253008sm1680314wme.42.2024.02.28.02.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 02:48:33 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com,
	cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
Subject: [RFC PATCH 1/6] arm: baltos: remove custom linker script
Date: Wed, 28 Feb 2024 12:48:04 +0200
Message-Id: <20240228104811.1366694-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
References: <20240228104811.1366694-1-ilias.apalodimas@linaro.org>
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

