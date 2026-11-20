Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8010560A2613
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qr7Yh3v2;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Jz9g5x2B
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58CEE816F6;
	Fri, 20 Nov 2026 21:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0p7XEU6fVJzs; Fri, 20 Nov 2026 21:21:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E653816D4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795209698;
	b=D5IU/a35sgAUS8kkDVFYcDQcdXSo9mLqYmXMDyk/KYqBuT0/GeCEnvmlsXP0tTQm6ekG
	 R5fX9A0EbOPyEQWgtdmw2BMeTVoyN0RxziR+QJYH9a4/xffHXr9LmdlMsKZT1wKCd4vph
	 NW2fW8ugX0rBto9nf2Wz/PIaHHz0JxmlZTKzZHH07TVML5rIyukXxeKuCxBYeJoF8yhaC
	 fCtU3lEtbtVYFbhnhgXfLfvT9aePOIhMsJrZ4bi10cJtVhV2kXfkEaLlff0nZskDydaYk
	 R4yn5HrWKFgTwq8dsBs5JfqeVbLgGPwQMTBcsn6jBdNNoJkOm7WASOPX70cfSWZ3UjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795209698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pg92/TM2Jbz+jpxng0cnysYHqRfAh6lLqL0yIuj3+aw=;
	b=fT8YUF4dBy0ajExHoF9oq7S+cF2U9SVoGOw83gFfvx+mTaipm7S6HElgBIodIoiYv2Lz
	 lCEELE1RsoP6xH2lUWZhTGLk6SLmZoMcKo0OpdtcnY8rQjy03vwPIgc9ZdZLEnw/JMe2F
	 S7r/QdKs+hh2ySRoJxgSTCp3KdWfq6Lz/eAzXmFxM+NliwpMEvRLOc4apVCZi0+icfH+w
	 5THhrkyX62GcIN4cc0G2LEMC03Y5J3SgcjJDhla1+W9Ix5BVCgxlQXdp45lIjR5gMHO4v
	 FSpzc4spk8eTlVMkVGgUpvhwUOkZPgNfkKevHiOb7O6fR8OlzTTQyroObr+NNJ9TZhg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795209698;
	bh=pg92/TM2Jbz+jpxng0cnysYHqRfAh6lLqL0yIuj3+aw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qr7Yh3v2qEmV9x9E6ZkoB0fMWXdtSnXrcJAktJXYtnlWec2V2dCdKbEJQzhvZ/E3/
	 FMERbrZB8E5ebnELWLFzGImHDsqcBJWj3S/8fHX4ZL1nOAYVbURqX0UEcTEdnNJ4w8
	 bFgZiiGmIP15Y3pyBzPhVMnxOuz7dw72qR1CNyTkLk7/mcXDbOthd5z/PYRRXNqdJh
	 7L7nvzUbkN9HtKpCvR+F+b8Zb7r5Tzo5mBMl+5Cafs8cWHU9ThEeF8Cxlyl2lcLqca
	 Jt+ZEEx26t9TDu42gLNerihVr/c1TwNN7XAUqMUdvMCeMHMAlijoC1oqfoGzXfl34H
	 FednPlNbaYceg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E653816D4;
	Fri, 20 Nov 2026 21:21:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D6584759
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C766D40E70
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:21:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kvPIc1WcdrcW for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:21:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC41240E65
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Jz9g5x2B
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC41240E65
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:21:35 +0000 (UTC)
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67c58f18765so1009667d50.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795209694; x=1795814494;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pg92/TM2Jbz+jpxng0cnysYHqRfAh6lLqL0yIuj3+aw=;
 b=Jz9g5x2Bt8MClVp4VaXqY7IC69t4rRARdsuPonNmu7wbHj7CWoWvBe8aDXEYTefLXb
 EeWV9AigUKbKTW1Fh6wnv3QuYXtMLhkAu6mwSTcy4SI6R/G4U6ooNfAw0I2QFmzCJECt
 NhJ0V/XHO/UEJp63iwIueruWKn+ErC30194yzp/AbmHtGf65wdeygYlhn+vj+qs5p61J
 zYTnTCbbF+S0mqvEIkj1LB0hsxyEQDEYsoBj/x+Mxj/fHsUOLsk653pZREkyE/nfelbq
 jU+xNcI5NorBxBsErFPCr4OG0yTbR58DJGjjeEaMyeBsMmg3vNtfr35QNq5qeyv61CIL
 bh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795209694; x=1795814494;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pg92/TM2Jbz+jpxng0cnysYHqRfAh6lLqL0yIuj3+aw=;
 b=I/e4Zzj0S8AfeJf0nQ0rnyG1iVc1wGtIxJxN85cJu4vASDG2G6u2sY0XzM0NfXFdWD
 boqza6cC6byuAEtYg3qwgspvBdMJfjvqz2fMonIkJdyszbpmTER3WM05Rnb7lxpyRYfp
 PC8voWLgzC1BEfXzu0yEjwbOoWa4qHDpfCqZ10YL5XqVcBfJ6WGgIXBLe0HsMGDk6a3D
 0BbAK72IlYg7hcgM8S59IO3bNlLNTYzGO0K3ZVQOcLRPjoSOIi+FiN9PGYE6Nkc3q8c7
 117DEt630ezfM9qUAJvyp4JcauNt8Z5oSirt0geh6tqdXlCcdK5nFdSUiOkrJwddyFnE
 ypUQ==
X-Gm-Message-State: APuU4Z8PmBP6BPZyAuZtOfxd4JG3+qUrJYnsI/4QkWusrIWxC7O4gf55
 n84FQR+xhMnuoPgLlOGv+XdBtYvQDa/OVHizjtJbzwbGY53IW9tvRKWk0boCGohWV9xrbSoXJ7P
 7afwJCLp8toXQhvkcuwDnywNfySpl1VBuReUu7kIE2g==
X-Gm-Gg: AZFdTZd+vx46DPu5cikq8FV9QSYRlaVvajs8DyKlq/BBmrm0c2AtB9+nK8iN6D1qpSv
 h5WKT8OFryPrbSb9z/wIanid4pQGfGQ+idKv4eirF26KBaRLscUPu8ep3fBRspCiXVYEFZuCpJy
 ZWTTflUhDzPc+BxERzb1wihpPr4QXbCkAyYf3v6/3o+ZZs4viFZGZUo9dih3lc84iDF1uLlSMEp
 Yll3OLjzFeh2wBerl0Opku9Zfe9Gi8Obvn7+zMK1z85A+SOPl3IJZ5hMuuo+s/KLgCrPFg8qIiq
 dfIQb8JjxEl/jWqxWx/VeaXULqAUIFK/USxRM9a4w8W7g+Kygh/xVDl006kNIySWoFerFKVrp2l
 Fy68P/XoO5k02PE7HVnRpq+0KhvBddiQoFRMfgeoLzmCwdEpyZ79wgLeSGZFtYgPlcu+IAAZpBp
 Q/BFnmAsB/L9zdQgPKZtImMiD6NTqes9IGYqqOqlDuaOCgg4QBdKGT+PeEU3Z2R1KjxfhV71TIC
 tOG35+c0x0z+SHzPJ48ZNoKJL9J/RYhobNfra2tBxBaVQvDHPDyGKQcUp52osWDpRdJLN/2cxl1
 YEMBRQqWFKyjocxYz8FEwR0Q6GipyPImPeJJBg7RnUu+RqXSJ2+iXlYZceYhJ5Yf2aeD1l4RGvk
 dhx+tNzwfXQHdtKHap07mLNGmQflar415eMYyvS3nJyQeitOpgbA/1taDsjlImDBMZcPAJPMkYV
 oy7O0Hcw7HbBeCwdbrkMzCqyto6hvfiwkj62DvscM23ceK2pQoik0T2bqOE0EgKkiIwzVe6g53B
 U/ibd2sZIrq68hISQ==
X-Received: by 2002:a05:690e:4394:b0:679:8db9:517c with SMTP id
 956f58d0204a3-67df42c4560mr879800d50.6.1795209693819; Fri, 20 Nov 2026
 13:21:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
 <20261120-apple-t603x-support-v2-4-606b4f5fadc5@jannau.net>
In-Reply-To: <20261120-apple-t603x-support-v2-4-606b4f5fadc5@jannau.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Nov 2026 23:20:57 +0200
X-Gm-Features: Aa3M54qm88u75vhj-AqcUBzpzlfSq41SF7zzGbK8SEZ8ND7a364JqMTDLnaflzE
Message-ID: <CAC_iWjKy+OjvzG70xS2L1J+wf2D2nQKy_2U7B7hXbCeQw0JZ8A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm: apple: Add Apple M3 Ultra (t6032) support
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 asahi@lists.linux.dev, Anshul Dalal <anshuld@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 20:53, Janne Grunau <j@jannau.net> wrote:
>
> Apple's M3 Ultra (t6032) SoC consists like its M1 and M2 predecessors of
> two M3 Max dies with an "UltraFusion" interconnect. Since it is only
> used in the Mac Studio the mem map does not need to duplicate all
> entries. Two of the USB4 / Thunderbolt complexes on the second die are
> unused. Only PCIe host controller on the first die is used directly. The
> PCIe IO on the second die is used internally to connect the NVMe
> controller with the NAND flash.
> Most of u-boot's existing drivers are compatible with the hardware and
> M3 Ultra device trees will carry "apple,t8103-*" as fallback compatible
> strings. Only apple-atcphy-reset will use a new compatible as M3 Ultra
> has ThunderBolt 5 / USB4v2 USB-C ports.
>
> Acked-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/mach-apple/board.c        |   3 +
>  arch/arm/mach-apple/memmap/t6032.h | 136 +++++++++++++++++++++++++++++++++++++
>  doc/board/apple/m1.rst             |   1 +
>  3 files changed, 140 insertions(+)
>
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index c93c3bd56aa9..ae1b1a7b8a43 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -21,6 +21,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  #include "memmap/t6020.h"
>  #include "memmap/t6022.h"
>  #include "memmap/t6030.h"
> +#include "memmap/t6032.h"
>  #include "memmap/t8103.h"
>  #include "memmap/t8122.h"
>
> @@ -77,6 +78,8 @@ void build_mem_map(void)
>                  of_machine_is_compatible("apple,t6031") ||
>                  of_machine_is_compatible("apple,t6034"))
>                 mem_map = t6030_mem_map;
> +       else if (of_machine_is_compatible("apple,t6032"))
> +               mem_map = t6032_mem_map;
>         else
>                 panic("Unsupported SoC\n");
>
> diff --git a/arch/arm/mach-apple/memmap/t6032.h b/arch/arm/mach-apple/memmap/t6032.h
> new file mode 100644
> index 000000000000..5616d7f32285
> --- /dev/null
> +++ b/arch/arm/mach-apple/memmap/t6032.h
> @@ -0,0 +1,136 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2026 Janne Grunau <j@jannau.net>
> + */
> +
> +#ifndef APPLE_MEM_MAP_T6032_H
> +#define APPLE_MEM_MAP_T6032_H
> +
> +#include <asm/armv8/mmu.h>
> +#include <linux/sizes.h>
> +
> +/* Apple M3 Ultra */
> +static struct mm_region t6032_mem_map[] = {
> +       {
> +               /* I/O */
> +               .virt = 0x280000000,
> +               .phys = 0x280000000,
> +               .size = 2UL * SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x300000000,
> +               .phys = 0x300000000,
> +               .size = 3UL * SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* PCIE */
> +               .virt = 0x580000000,
> +               .phys = 0x580000000,
> +               .size = SZ_512M,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* PCIE */
> +               .virt = 0x5a0000000,
> +               .phys = 0x5a0000000,
> +               .size = SZ_512M,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +                        PTE_BLOCK_INNER_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* PCIE */
> +               .virt = 0x5c0000000,
> +               .phys = 0x5c0000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +                        PTE_BLOCK_INNER_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC0 */
> +               .virt = 0x700000000,
> +               .phys = 0x700000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC1 */
> +               .virt = 0xb00000000,
> +               .phys = 0xb00000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC2 */
> +               .virt = 0xf00000000,
> +               .phys = 0xf00000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC3 */
> +               .virt = 0x1300000000,
> +               .phys = 0x1300000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x2280000000,
> +               .phys = 0x2280000000,
> +               .size = 2UL * SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x2300000000,
> +               .phys = 0x2300000000,
> +               .size = 3UL * SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC4 */
> +               .virt = 0x2700000000,
> +               .phys = 0x2700000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC5 */
> +               .virt = 0x2b00000000,
> +               .phys = 0x2b00000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* RAM */
> +               .virt = 0x10000000000,
> +               .phys = 0x10000000000,
> +               .size = 16UL * SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +                        PTE_BLOCK_INNER_SHARE
> +       }, {
> +               /* Framebuffer */
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> +                        PTE_BLOCK_INNER_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* List terminator */
> +               0,
> +       }
> +};
> +
> +#endif /* APPLE_MEM_MAP_T6032_H */
> diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
> index 3b4fb2913981..8637e29b9498 100644
> --- a/doc/board/apple/m1.rst
> +++ b/doc/board/apple/m1.rst
> @@ -18,6 +18,7 @@ the following SoCs work:
>   - Apple M2 Ultra SoC (t6022)
>   - Apple M3 Pro SoC (t6030)
>   - Apple M3 Max SoC (t6031 and t6034)
> + - Apple M3 Ultra SoC (t6032)
>
>  On these SoCs the following hardware is supported:
>
>
> --
> 2.56.1
>
