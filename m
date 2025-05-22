Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91285C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 16:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 157928313B;
	Thu, 22 May 2025 18:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Sk9YZTgS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49F283145; Thu, 22 May 2025 18:41:13 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F3AC8312A
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 18:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 07A2526141;
 Thu, 22 May 2025 18:41:11 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3jzRrTL3SBKC; Thu, 22 May 2025 18:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747932069; bh=fnld5Len4zqUHpbFZzM3hilKbt/er9QHqlUoVQ8bMpQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Sk9YZTgSnaqh1Es6c8jMrXzZ7wtLO3XVXccEmTbzX5OnY1pGKK2JSCCiCSI1uSdem
 DK9qmxyDWry8hX3kJysM6eYwOU+fV+NKwdO6UD1jknmWbBJ6uzbg4Vhy2oCP7To+5w
 hggf3JlzYsgdiM8iGODbR5vdUSOUCnr+atQStHNG0yfeanrbFzVl9jvGrlVzZkWA15
 /MZfTv8vPO6NVlvzcSxUHWMQqk4pSGqvRYh5PAy6xKp5eizlimyNhyBUKkcSndXqGC
 ul79YQ3xik4wg38lglflIDipMsw4hol3VSygjJmCTOhznLsuOzBAam3bwweo1B5pPE
 m1RPE5MxwjUSg==
Date: Thu, 22 May 2025 16:40:57 +0000
From: Yao Zi <ziyao@disroot.org>
To: Conor Dooley <conor@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de,
 rick@andestech.com, Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <aC9TmaY7w2PL8lbn@pie.lan>
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-eradicate-clip-538f48710ad7@spud>
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

On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
> > 
> > > The following changes since commit a3e09b24ffd4429909604f1b28455b44306edbaa:
> > > 
> > >   Merge tag 'mmc-2025-05-20' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2025-05-20 08:35:31 -0600)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> > > 
> > > [...]
> > 
> > Merged into u-boot/master, thanks!
> 
> This PR seems to have made my CI blow up, and I'm not entirely sure if
> that's something intentional or not. I've not yet bisected, but since
> the error is "Image arch not compatible with host arch", I can only
> imagine the patch in question is:
> | Subject: [PATCH v2 1/3] riscv: image: Add new image type for RV64
> | Date: Fri,  4 Apr 2025 14:48:55 +0000	[thread overview]
> | Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.com> (raw)
> | In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
> | 
> | Similar to ARM and X86, introduce a new image type which allows u-boot
> | to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.
> | 
> | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> | ---
> |  boot/image.c    | 3 ++-
> |  include/image.h | 3 ++-
> |  2 files changed, 4 insertions(+), 2 deletions(-)
> | 
> | diff --git a/boot/image.c b/boot/image.c
> | index 139c5bd035a..45299a7dc33 100644
> | --- a/boot/image.c
> | +++ b/boot/image.c
> | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] = {
> |  	{	IH_ARCH_ARC,		"arc",		"ARC",		},
> |  	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
> |  	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
> | -	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
> | +	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
> | +	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
> |  	{	-1,			"",		"",		},
> |  };
> |  
> | diff --git a/include/image.h b/include/image.h
> | index 07912606f33..411bfcd0877 100644
> | --- a/include/image.h
> | +++ b/include/image.h
> | @@ -138,7 +138,8 @@ enum {
> |  	IH_ARCH_ARC,			/* Synopsys DesignWare ARC */
> |  	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
> |  	IH_ARCH_XTENSA,			/* Xtensa	*/
> | -	IH_ARCH_RISCV,			/* RISC-V */
> | +	IH_ARCH_RISCV,			/* RISC-V 32 bit*/
> | +	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
> |  
> |  	IH_ARCH_COUNT,
> |  };
> | -- 
> | 2.43.0
> | 
> since it is changing the existing "riscv" image type to be the 32-bit
> image and requiring the new entry for 64-bit. My CI job uses the system
> mkimage to create the image that U-Boot is loading, so it doesn't know
> about the new define etc. Maybe it's not considered a problem if a new
> U-Boot cannot boot an old image, but the comment above the enum reads:
> |/*
> | * CPU Architecture Codes (supported by Linux)
> | *
> | * The following are exposed to uImage header.
> | * New IDs *MUST* be appended at the end of the list and *NEVER*
> | * inserted for backward compatibility.
> | */
> The overwhelming majority of existing supported boards in U-Boot are
> 64-bit platforms, and the 64-bit platforms are the ones that have been
> supported for longer, so my thought would be that the compatibility of
> 64-bit platforms should be prioritised over 32-bit? Or even add explicit
> 32-bit and 64-bit entries and the existing one is a catch-all for
> compatibility reasons?

I've mentioned entries with bitwidth explicitly specified in my previous
reply (and there hasn't been any response).

> I'll consider IH_ARCH_RISCV32 a better idea, instead of implying 32bit
> when no suffix attached. We (and the Linux kernel) mix 32-bit and 64-bit
> variants of RISC-V together, thus it's hard to tell the exact bitwidth
> of "IH_ARCH_RISCV" without inspecting the code around. To me, it sounds
> more like "RISC-V, but no bitwidth specified".
>
> It will be nice if we could avoid this kind of ambiguity.

(referring my own reply[1])

I'll second explicit 32-bit and 64-bit entries, and keeping
IH_ARCH_RISCV for compatibility consideration.

> 
> Hopefully my lack of bisection isn't causing me to blame something
> incorrect, but I'll go try to replicate now :)

Regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/Z_CjTyXaVrpUOPnJ@pie.lan/
