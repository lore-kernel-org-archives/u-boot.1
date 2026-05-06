Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73141CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 10:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD91848A1;
	Wed,  6 May 2026 12:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rrTrq70z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57DB848C2; Wed,  6 May 2026 12:58:07 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A2784897
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 12:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67b6da5a618so10341214a12.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 03:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778065085; cv=none;
 d=google.com; s=arc-20240605;
 b=PXd31kt8kyM8CQcjItqPm1xuyxag9VBmBvhr4U3+btrfIIC20yElh4ZUuJbPIHOvKO
 MAhlsifcfAj6z6bGmslFgqtM61Hs/ujYiZLzTNP5L6KYe4TGkl2ZQ7JkhSX+LzgfgU9X
 RqSGEttwvcgDXScCZH+E++BC4BTNsd9oCN+ZWVOYfPToJTAc6xxKcKV2C2iMNxnQGOn5
 xpwGNyba5lJNzAxLNNmXTwL7YQRw3G5gHQNdbAsmmknGHHcwzrY+KOCVwfm82rKZvPLd
 jDRc0lnQgVTFTwlUlBXSW2HBXeE9ExNLduxmg+W5ispL2v8BdncPtGIpGhbUc6umKflv
 9i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7sUOGE+lhV4ytO2w7PLZHCwxKSe3KskgdPdcuzN2KoQ=;
 fh=EoWNFPKoMb5QWZPyW1MqG1mjPy5SqqOqKuMx4QcFFmU=;
 b=iqDWhxMCxfM4KcbKHsUIjAALBlGAjqO2TlpBOJJtUdGlqW88M5C6V5JIgUhCP7H7zm
 qhnn57/adlgWVJYROt68RJrsHFeTndz8nMJGVVAOr4zc5DOOAZucqWr2EQnkTS/krXrF
 p2KZzIDjquy4wUuXfHy4AArnh2tMAK2iBdVtxE/uijve9yhUXK1aouWQITvokRwIyt0F
 k6eMcy4UciIIp45Lz6BAlVL3Z5EVO0J+BOR/JqI4GVJjk/FBdZw+4Yv+9UPXz4OIlTD2
 kl8FEDNYSuEPYPyzZhsg9t/MLLtbINXmpNdaGvtA7s5rw7MNoeVgmNYL49wl69ejFLGf
 h8pQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778065085; x=1778669885; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7sUOGE+lhV4ytO2w7PLZHCwxKSe3KskgdPdcuzN2KoQ=;
 b=rrTrq70zMWfkIug9jIk+kvYbLr4vvqVM4LOU4Mk+WyT53/bm6n6522R72CjJ3tjB/C
 iZ2VDhFwl+mgh+Boh5fp+BjHiiRkEA7i0whultuSiZK12fo6wyEzapaKqyERz1TjKJkM
 77Geys9m3RVNTyOmPBjGbHnNmRHPosyqiSS2UuJWkZEaM4XcsaJ6Ww1O0KV1AoMgbLEK
 K0u4HLRDEIhglYY/lSohNdtoKxTiumA3ojwnJg4yK1gPUK26re7/TsSjE74aQOY4rfn1
 ObSYMrNtDOAU1+MHh9RKjQwZhADM/Wa9CrYW90ku6kbD0CnsTe1pbF2ocLJEXcUgcRt+
 Bnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778065085; x=1778669885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sUOGE+lhV4ytO2w7PLZHCwxKSe3KskgdPdcuzN2KoQ=;
 b=m19EKHdHS4hFT9avOCnMyk/6iGPB5zfdDDm5VwKBvcsopyBn/5jPbIltPCsaCsUbhp
 9Krd8jbGhGmW4LL++r13EHbjzAh63AqVW9UgLdkKL/VKfqXRGdZD4JmCXk1qD4t3Pos5
 x44cisLTCsv7OZO1Mp88QLRmIitSOCWCP2JG5SwDI1R2arVOnnNvHpg21LSQwCd8R6kl
 1ANf7DSYf+MuD9GdMh9Wy6opZRykJey+oaBHYyBCOkv5rRcLi3La9wtavw92p901lJPt
 hRJw42nPwt+8sva42tvLK2CGJtf/dp8C/Z3JQTW6x01TR12slvPYnzuufBBQrkkR0SuV
 8AxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Hzs979ITjxIIokBHjeeZpO8J2ACsUCdMHbKPGzEbFpcPXDIzWduDzniRgRuLhzvIqrSYssN8=@lists.denx.de
X-Gm-Message-State: AOJu0YzqyH4WtvpewdX+KEWg4T8cVz2lnCbgx+3FE95J5MnPtwb9Q7aO
 CSVzUguaBdITDJpISVCejbYWVyB4SWJNPPYHaIEnmywez8V7GrWPn4XVo1gvEdAG7/+HNm/wHnG
 k41X/Rmwr8Ozuc6iCVX81N4ma/VkKVr8=
X-Gm-Gg: AeBDievWjUUlG5P0JrsWNTTBzxtxhLQOWEFv+7cpumAhnz3yksizIZxnexGURmI46Ne
 cFYMcTFRcUy7P4leHEdnNY9hQjjThogBmbVCr/H3EWpH4HWAERcCR67buw+HAwKHTwKTAxhHv81
 RWLi+5cL+ZgjY5FuSuhbjT7rybYZQEqZ+3qojm6Qwb9Ho4ZFdckfypgtJzpD9/r2BhjKZ7KYxe8
 neMmyt9QICko7TFG5xm5GT3bapNScWBjdbmPKJa97uixm8p/x22EsilrtnwSurl9rruzAqzhgTv
 AMGg0NWiJDAyykuPUZvoTxEMFspKPtkl7Jlu5PdnbvA1LlkOIZTQ2ZlyXqJ30ssYVF0njDPmoZO
 MB16k81iSXDS4FL7/igO4rtgyxXYP77MsJKV7I6KRjdqfn6/6aN/5eO07vvg5pt2OdClARJfYXC
 ZKzqdnN/JXFgA=
X-Received: by 2002:a05:6402:3446:b0:66e:56a2:b67b with SMTP id
 4fb4d7f45d1cf-67d648a0538mr904542a12.20.1778065085038; Wed, 06 May 2026
 03:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260428162319.99B4268B05@verein.lst.de>
 <20260428163918.C5D4268C4E@verein.lst.de>
In-Reply-To: <20260428163918.C5D4268C4E@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 6 May 2026 11:57:53 +0100
X-Gm-Features: AVHnY4K1psoqQae9effStnqIUx9hzG7FRPCCuaPXLUuh6ezggYo5VG9bfnNWFQk
Message-ID: <CALeDE9N7s9epvmY2XKsjMiEvTyf6Q4eykqMhgoH4RnOsxsh+JQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] ARM: bcm283x: Add bcm2712 PCIe memory window
To: Torsten Duwe <duwe@lst.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>, 
 Andrea della Porta <andrea.porta@suse.com>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Stanimir Varbanov <stanimir.varbanov@suse.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Pedro Falcato <pfalcato@suse.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 28 Apr 2026 at 17:39, Torsten Duwe <duwe@lst.de> wrote:
>
> From: Torsten Duwe <duwe@suse.de>
>
> Add a mapping region for the PCIe bus address spaces to the BCM2712
> memory controller setup. Generously merging the PCIe address spaces
> works sufficiently well for a boot loader.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Co-authored-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Tested-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  arch/arm/mach-bcm283x/init.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 7a1de22e0ae..7a2faaa4de6 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -18,7 +18,7 @@
>  #ifdef CONFIG_ARM64
>  #include <asm/armv8/mmu.h>
>
> -#define MEM_MAP_MAX_ENTRIES (4)
> +#define MEM_MAP_MAX_ENTRIES (5)
>
>  static struct mm_region bcm283x_mem_map[MEM_MAP_MAX_ENTRIES] = {
>         {
> @@ -83,6 +83,14 @@ static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
>                 .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>                          PTE_BLOCK_NON_SHARE |
>                          PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* Whole PCIe section */
> +               .virt = 0x1800000000UL,
> +               .phys = 0x1800000000UL,
> +               .size = 0x0800000000UL,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
>         }, {
>                 /* SoC bus */
>                 .virt = 0x107c000000UL,
> --
> 2.54.0
>
