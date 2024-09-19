Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77748CF3959
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040ED891C3;
	Thu, 19 Sep 2024 17:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="QeNeUF3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBD4889CD; Thu, 19 Sep 2024 17:28:13 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A87A6891C3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D48021480588; Thu, 19 Sep 2024 17:28:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1726759690; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=mqgmzVllabRjjvYG6ZA7mnZ6/Bu+w0D+Utsz68Mp41Y=;
 b=QeNeUF3sBc51ru6J34hJLSbU+sxUizDqU1Rm+ekkhlW2EU1mRuV2mBIJRPcRABUIs1Pq0o
 eYuEQbLSf5RJwnw4vT+7XJgCH+h3J1PIszBBWXsVQ54svvjcy0NmRMqSTnXtVi9jL5Jita
 n6PR2NDdfrAS5xGuhI3G85yskXwOKS6IOBPEbEzVlNBFVFjk7eULWearitotDS5LQ79WeE
 /adOSJeeirMvGGmubZlv2gL61OHr8/wtAYmPsb5FWaOSJ2n6XK20jESBkWzx6f6y1hx3Mj
 VFaAFswOirEmhfOja86jQxizWaIrhaOrLpzOCFpxAs9vQxdkDnb6pBioBvmYuQ==
Date: Thu, 19 Sep 2024 17:28:04 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Alexander Dahl <ada@thorsis.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH] doc: Move the generic memory-documentation to doc/
Message-ID: <20240919-removal-boney-174f9c8a26df@thorsis.com>
Mail-Followup-To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <20240919151424.57663-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919151424.57663-1-sjg@chromium.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Simon,

Am Thu, Sep 19, 2024 at 05:14:22PM +0200 schrieb Simon Glass:
> Move this section of the README into doc/ with some minor updates to
> mention SPL and user lower-case hex.

Maybe try not to rewrap unchanged paragraphs,
so `git show --color-moved` can detect those as just moved?

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  README                 | 45 ------------------------------------------
>  doc/develop/index.rst  |  1 +
>  doc/develop/memory.rst | 45 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 45 deletions(-)
>  create mode 100644 doc/develop/memory.rst
> 
> diff --git a/README b/README
> index 4be1e8c22a0..d73042406b6 100644
> --- a/README
> +++ b/README
> @@ -2516,51 +2516,6 @@ On RISC-V, the following registers are used:
>  
>      ==> U-Boot will use gp to hold a pointer to the global data
>  
> -Memory Management:
> -------------------
> -
> -U-Boot runs in system state and uses physical addresses, i.e. the
> -MMU is not used either for address mapping nor for memory protection.
> -
> -The available memory is mapped to fixed addresses using the memory
> -controller. In this process, a contiguous block is formed for each
> -memory type (Flash, SDRAM, SRAM), even when it consists of several
> -physical memory banks.
> -
> -U-Boot is installed in the first 128 kB of the first Flash bank (on
> -TQM8xxL modules this is the range 0x40000000 ... 0x4001FFFF). After
> -booting and sizing and initializing DRAM, the code relocates itself
> -to the upper end of DRAM. Immediately below the U-Boot code some
> -memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN
> -configuration setting]. Below that, a structure with global Board
> -Info data is placed, followed by the stack (growing downward).
> -
> -Additionally, some exception handler code is copied to the low 8 kB
> -of DRAM (0x00000000 ... 0x00001FFF).
> -
> -So a typical memory configuration with 16 MB of DRAM could look like
> -this:
> -
> -	0x0000 0000	Exception Vector code
> -	      :
> -	0x0000 1FFF
> -	0x0000 2000	Free for Application Use
> -	      :
> -	      :
> -
> -	      :
> -	      :
> -	0x00FB FF20	Monitor Stack (Growing downward)
> -	0x00FB FFAC	Board Info Data and permanent copy of global data
> -	0x00FC 0000	Malloc Arena
> -	      :
> -	0x00FD FFFF
> -	0x00FE 0000	RAM Copy of Monitor Code
> -	...		eventually: LCD or video framebuffer
> -	...		eventually: pRAM (Protected RAM - unchanged by reset)
> -	0x00FF FFFF	[End of RAM]
> -
> -
>  System Initialization:
>  ----------------------
>  
> diff --git a/doc/develop/index.rst b/doc/develop/index.rst
> index 0d0e60ab56c..cbea38d4323 100644
> --- a/doc/develop/index.rst
> +++ b/doc/develop/index.rst
> @@ -13,6 +13,7 @@ General
>     codingstyle
>     designprinciples
>     docstyle
> +   memory
>     patman
>     process
>     release_cycle
> diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
> new file mode 100644
> index 00000000000..fa1ae5e97ed
> --- /dev/null
> +++ b/doc/develop/memory.rst
> @@ -0,0 +1,45 @@
> +.. SPDX-License-Identifier: GPL-2.0+:
> +
> +Memory Management
> +-----------------
> +
> +U-Boot runs in system state and uses physical addresses, i.e. the
> +MMU is not used either for address mapping nor for memory protection.
> +
> +The available memory is mapped to fixed addresses using the
> +memory-controller. In this process, a contiguous block is formed for each
> +memory type (Flash, SDRAM, SRAM), even when it consists of several
> +physical-memory banks.
> +
> +U-Boot is installed in XIP flash memory, or may be loaded into a lower region of
> +RAM by a secondary program loader (SPL). After
> +booting and sizing and initialising DRAM, the code relocates itself
> +to the upper end of DRAM. Immediately below the U-Boot code some
> +memory is reserved for use by malloc() [see CONFIG_SYS_MALLOC_LEN
> +configuration setting]. Below that, a structure with global Board-Info
> +data is placed, followed by the stack (growing downward).
> +
> +Additionally, some exception handler code may be copied to the low 8 kB
> +of DRAM (0x00000000 ... 0x00001fff).
> +
> +So a typical memory configuration with 16 MB of DRAM could look like
> +this::
> +
> +	0x0000 0000	Exception Vector code
> +	      :
> +	0x0000 1fff
> +	0x0000 2000	Free for Application Use
> +	      :
> +	      :
> +
> +	      :
> +	      :
> +	0x00fb ff20	Monitor Stack (Growing downward)
> +	0x00fb ffac	Board Info Data and permanent copy of global data
> +	0x00fc 0000	Malloc Arena

Arena?

`make htmldocs` runs fine, page looks okay, thus:

Acked-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

> +	      :
> +	0x00fd ffff
> +	0x00fe 0000	RAM Copy of Monitor Code
> +	...		eventually: LCD or video framebuffer
> +	...		eventually: pRAM (Protected RAM - unchanged by reset)
> +	0x00ff ffff	[End of RAM]
> -- 
> 2.43.0
> 
