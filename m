Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8C3C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D3EF86FB8;
	Tue, 19 Dec 2023 15:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iShZ6F3Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78CC186EEB; Tue, 19 Dec 2023 15:03:39 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D60D87053
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d3758fdd2eso35354067b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702994613; x=1703599413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fscd+Ahyjoxp6UUJSjAZqLv+9mT9DkLsoBf16HzdwqE=;
 b=iShZ6F3Q24+340Er7jq2wHE/hx9uZHPq05kV6/fuzCdDhAdueDibQwOBF7yiJnBg62
 yrrSNVkgvtfHlZLpLP07qul3Z8GQmX+jTSRgaE4laxqBGBalrm0QG5ajlKFArv2hs3bH
 qBeOrz0ZLzNhzukG0fKeX3W9DoVYqzMPqLsWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702994613; x=1703599413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fscd+Ahyjoxp6UUJSjAZqLv+9mT9DkLsoBf16HzdwqE=;
 b=czjefA2x+hm1xIBjoyx/qgZRxY32kX7mTb30y813M7P+h7c4MqbvVTzLj0UBZj8utf
 LgZUqGRGNV2TJeUm7W07uLzVoqTg9cKD1UL2GLOrld+mRivggnGzpTSvJOADN+bZaVgk
 bsPMc4Wf+EXUqc6bcuPJJ39wDQ1YgG/OIjb91bYUdOyRKn99XnRMNL6bqICmdmoItFT/
 siiW5ZygqSvSA+V2ukCdfSa3x3L8XuDhlZTOw9JuNmIfNX2fBYwSRE4r8eHvo/uCUXvm
 zvs/TIlmtQvBe5EWrYy/LeYmL+hWAv8r8KumVOOlrVZ0zcAHsYG4usN730Y+QNcXfwMb
 7DFA==
X-Gm-Message-State: AOJu0Yx2Af0CMgSFuW4rgPZtVVIt0v5FGAgiaRyhcMp899M7ld4WemSG
 8WEhh7p7T4o1mwVYmnX5nRKmzB5kTG4xghr41/4=
X-Google-Smtp-Source: AGHT+IFtcNFe3eDKvei68Jfxh42XAZXi8Bb832iSeDVql/ow/ngsv9srtByCq+6OpZGJzXfpcjPA+w==
X-Received: by 2002:a81:7305:0:b0:5d7:1941:356c with SMTP id
 o5-20020a817305000000b005d71941356cmr12349074ywc.83.1702994612016; 
 Tue, 19 Dec 2023 06:03:32 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a81d10d000000b005e5dcde1da2sm2409006ywi.80.2023.12.19.06.03.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 06:03:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] ti: am335x: Remove unused linker script
Date: Tue, 19 Dec 2023 09:03:30 -0500
Message-Id: <20231219140330.2322794-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

The board specific linker script has not been used in a long time here,
remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/ti/am335x/u-boot.lds | 164 -------------------------------------
 1 file changed, 164 deletions(-)
 delete mode 100644 board/ti/am335x/u-boot.lds

diff --git a/board/ti/am335x/u-boot.lds b/board/ti/am335x/u-boot.lds
deleted file mode 100644
index 087dee8bb2ed..000000000000
--- a/board/ti/am335x/u-boot.lds
+++ /dev/null
@@ -1,164 +0,0 @@
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
-		board/ti/am335x/built-in.o (.text*)
-	}
-
-	/* This needs to come before *(.text*) */
-	.__efi_runtime_start : {
-		*(.__efi_runtime_start)
-	}
-
-	.efi_runtime : {
-		*(.text.efi_runtime*)
-		*(.rodata.efi_runtime*)
-		*(.data.efi_runtime*)
-	}
-
-	.__efi_runtime_stop : {
-		*(.__efi_runtime_stop)
-	}
-
-	.text_rest :
-	{
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
-	.efi_runtime_rel_start :
-	{
-		*(.__efi_runtime_rel_start)
-	}
-
-	.efi_runtime_rel : {
-		*(.rel*.efi_runtime)
-		*(.rel*.efi_runtime.*)
-	}
-
-	.efi_runtime_rel_stop :
-	{
-		*(.__efi_runtime_rel_stop)
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
2.34.1

