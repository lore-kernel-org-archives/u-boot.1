Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0047CD4F59
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 07:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F9288BD6;
	Thu,  5 Sep 2024 09:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB67588C03; Thu,  5 Sep 2024 09:47:03 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 318A388549
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 09:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F3F9FEC;
 Thu,  5 Sep 2024 00:47:27 -0700 (PDT)
Received: from debian (X72Y076X74.nice.arm.com [10.34.125.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 896B63F66E;
 Thu,  5 Sep 2024 00:46:58 -0700 (PDT)
Date: Thu, 5 Sep 2024 09:46:55 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Weinberger <richard@nod.at>, Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 0/3] efi: Start tidying up memory management
Message-ID: <Ztlh70H-G6eP0wOr@debian>
Mail-Followup-To: Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eugene Uriev <eugeneuriev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>
References: <20240901222259.456932-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901222259.456932-1-sjg@chromium.org>
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

On Sun, Sep 01, 2024 at 04:22:56PM -0600, Simon Glass wrote:
> We have been discussing the state of EFI memory management for some
> years so I thought it might be best to send a short series showing some
> of the issues we have talked about.
> 
> This one just deals with memory allocation. It provides a way to detect
> EFI 'page allocations' when U-Boot' malloc() should be used. It should
> help us to clean up this area of U-Boot.
> 
> It also updates EFI to use U-Boot memory allocation for the pool. Most
> functions use that anyway and it is much more efficient. It also avoids
> allocating things 'in space' in conflict with the loaded images.

Hi Simon,

Thank you for this series.

I did test it on top of v2024.10-rc4 with AArch64 simulators (FVP & Qemu), with
OS boots and ACS-IR, and I see no regression. Same with sandbox on x86 and the
python tests.

Best regards,
Vincent.

> 
> This series also includes a little patch to show more information in
> the index for the EFI pages.
> 
> Note that this series is independent from Sugosh's lmb series[1],
> although I believe it will point the way to simplifying some of the
> later patches in that series.
> 
> Overall, some issues which should be resolved are:
> - allocation inconsistency, e.g. efi_add_protocol() uses malloc() but
>   efi_dp_dup() does not (this series makes a start)
> - change efi_bl_init() to register events later, when the devices are
>   actually used
> - rather than efi_set_bootdev(), provide a bootstd way to take note of
>   the device images came from and allow EFI to query that when needed
> - EFI_LOADER_BOUNCE_BUFFER - can use U-Boot bounce buffers?
> 
> Minor questions on my mind:
> - is unaligned access useful? Is there a performance penalty?
> - API confusion about whether something is an address or a pointer
> 
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=416441
> 
> Changes in v3:
> - Add new patch to drop the memset() from efi_alloc()
> - Drop patch to convert device_path allocation to use malloc()
> 
> Changes in v2:
> - Drop patch 'Show more information in efi index'
> - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> - Add the word 'warning', use log_warning() and show the end address
> 
> Simon Glass (3):
>   efi: Drop the memset() from efi_alloc()
>   efi: Allow use of malloc() for the EFI pool
>   efi: Show the location of the bounce buffer
> 
>  common/dlmalloc.c            |   7 +++
>  include/efi_loader.h         |  29 ++++++++-
>  include/malloc.h             |   7 +++
>  lib/efi_loader/efi_bootbin.c |  11 ++++
>  lib/efi_loader/efi_memory.c  | 119 ++++++++++++++++++++++++-----------
>  5 files changed, 136 insertions(+), 37 deletions(-)
> 
> -- 
> 2.34.1
> 
