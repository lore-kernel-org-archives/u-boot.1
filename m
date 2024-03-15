Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F20C54E66
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 06:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6208087F9C;
	Fri, 15 Mar 2024 07:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QUyr2Js8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0D6187FAA; Fri, 15 Mar 2024 07:44:06 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0566587F8F
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 07:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33e94c12f33so1550149f8f.3
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710485044; x=1711089844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axqi5l4Ztq3WiIi5s/5Po9WAHf/Ep2gUDdwyUWhnccw=;
 b=QUyr2Js8+o21Arq5cMPZDPsd5t/+S0ZLDHNkh6MvVmfpULv4jVBzv5/93qfx7Yc2dY
 TVQl5mMOd+fMtO2cA0JvAqyiV7HMX8lEFYLgEj5h8SFNnLlH44qx3vry5qXRfV25xDHi
 Jal96oruZ99EabNR6r0NJrUcOFlmjKC6DwE7rG1zssh+CQwt0sFIj3JaQ0PXF1GMmaKH
 DXH1S75iEvWa5ld9ndLmpH33FR4LCIRuoBXkWs97EXJxbZD+o5eoRgzfYc5pq75rff3i
 IWfk0jdlgMv2bSsE4RMO/uwp8fpscZYBijXm3mhShZnOPGz+G+Na+w8+3E4ra5MP99E6
 6jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710485044; x=1711089844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axqi5l4Ztq3WiIi5s/5Po9WAHf/Ep2gUDdwyUWhnccw=;
 b=iBoUFCLwIWZct5PjDrSz202GhFaMbpjYoF6JzxZ/iwu4JkAuwxt76TVhrDVbGd9JJb
 Pb84JREWbRn7GUys+lL86/+epUw8+Xxi6QvEKCGUROyVs/yrtWDR/+md4Il0WBrKHbGf
 Tud0jbrQHx3k0iP6EFHC4wEH8kBET88tZC+RNgTU8QqcEufLvg/ImrmHZlZDwcyDQeJ1
 0t5/516Y+FNQu3qfmssFKZSUjmvOt0loWKgnnrCoGUFr5lAW4hnEl9lhb5BHkdlWYaJI
 Hf0nVnoEGQTYNpZvO016eCHMmlNVldN6uZ/rcaBMG7fk1t0pFpvnCurZqRyTrsHZjc7/
 3Liw==
X-Gm-Message-State: AOJu0YwplowzqfHNgd+NMiLuYHGxSDOiujwOSO+jjd9xuepcs8yYpLaF
 X3d+gy74KgJ9xSdiYaftwAHDF8iU3eBS80KbHc+okcl0xwAgU1/wnEIdB7wuso7XCztkpehdGC9
 C
X-Google-Smtp-Source: AGHT+IFrzhYQDoIisCzJz2bjyYlnVaV1dPs5zx7Haa2YSY6lY0nayDyHJq276M6VMCbo82GoxSVOgg==
X-Received: by 2002:adf:ce85:0:b0:33e:d470:da8f with SMTP id
 r5-20020adfce85000000b0033ed470da8fmr304520wrn.17.1710485044521; 
 Thu, 14 Mar 2024 23:44:04 -0700 (PDT)
Received: from hades.. (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 v18-20020adfe4d2000000b0033ec9936909sm2398658wrm.39.2024.03.14.23.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 23:44:04 -0700 (PDT)
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
Subject: [PATCH v4 1/7] arm: baltos: remove custom linker script
Date: Fri, 15 Mar 2024 08:43:45 +0200
Message-Id: <20240315064354.2215266-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240315064354.2215266-1-ilias.apalodimas@linaro.org>
References: <20240315064354.2215266-1-ilias.apalodimas@linaro.org>
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

