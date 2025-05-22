Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7B8C54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 15:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9820B830F3;
	Thu, 22 May 2025 17:37:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFCD5830F4; Thu, 22 May 2025 17:37:14 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D862830E9
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 17:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 54MFaogw034531
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 22 May 2025 23:36:50 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 23:36:50 +0800
Date: Thu, 22 May 2025 23:36:47 +0800
From: Leo Liang <ycliang@andestech.com>
To: Tom Rini <trini@konsulko.com>
CC: Conor Dooley <conor@kernel.org>, <u-boot@lists.denx.de>,
 <rick@andestech.com>, Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <aC9Ejx01_If9pQVP@swlinux02>
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud>
 <20250522144559.GL100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250522144559.GL100073@bill-the-cat>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 54MFaogw034531
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

On Thu, May 22, 2025 at 08:45:59AM -0600, Tom Rini wrote:
> On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> > On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
> > > 
> > > > The following changes since commit a3e09b24ffd4429909604f1b28455b44306edbaa:
> > > > 
> > > >   Merge tag 'mmc-2025-05-20' of https://source.denx.de/u-boot/custodians/u-boot-mmc (2025-05-20 08:35:31 -0600)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> > > > 
> > > > [...]
> > > 
> > > Merged into u-boot/master, thanks!
> > 
> > This PR seems to have made my CI blow up, and I'm not entirely sure if
> > that's something intentional or not. I've not yet bisected, but since
> > the error is "Image arch not compatible with host arch", I can only
> > imagine the patch in question is:
> > | Subject: [PATCH v2 1/3] riscv: image: Add new image type for RV64
> > | Date: Fri,  4 Apr 2025 14:48:55 +0000	[thread overview]
> > | Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.com> (raw)
> > | In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com>
> > | 
> > | Similar to ARM and X86, introduce a new image type which allows u-boot
> > | to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.
> > | 
> > | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> > | ---
> > |  boot/image.c    | 3 ++-
> > |  include/image.h | 3 ++-
> > |  2 files changed, 4 insertions(+), 2 deletions(-)
> > | 
> > | diff --git a/boot/image.c b/boot/image.c
> > | index 139c5bd035a..45299a7dc33 100644
> > | --- a/boot/image.c
> > | +++ b/boot/image.c
> > | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] = {
> > |  	{	IH_ARCH_ARC,		"arc",		"ARC",		},
> > |  	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
> > |  	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
> > | -	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
> > | +	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
> > | +	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
> > |  	{	-1,			"",		"",		},
> > |  };
> > |  
> > | diff --git a/include/image.h b/include/image.h
> > | index 07912606f33..411bfcd0877 100644
> > | --- a/include/image.h
> > | +++ b/include/image.h
> > | @@ -138,7 +138,8 @@ enum {
> > |  	IH_ARCH_ARC,			/* Synopsys DesignWare ARC */
> > |  	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
> > |  	IH_ARCH_XTENSA,			/* Xtensa	*/
> > | -	IH_ARCH_RISCV,			/* RISC-V */
> > | +	IH_ARCH_RISCV,			/* RISC-V 32 bit*/
> > | +	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
> > |  
> > |  	IH_ARCH_COUNT,
> > |  };
> > | -- 
> > | 2.43.0
> > | 
> > since it is changing the existing "riscv" image type to be the 32-bit
> > image and requiring the new entry for 64-bit. My CI job uses the system
> > mkimage to create the image that U-Boot is loading, so it doesn't know
> > about the new define etc. Maybe it's not considered a problem if a new
> > U-Boot cannot boot an old image, but the comment above the enum reads:
> > |/*
> > | * CPU Architecture Codes (supported by Linux)
> > | *
> > | * The following are exposed to uImage header.
> > | * New IDs *MUST* be appended at the end of the list and *NEVER*
> > | * inserted for backward compatibility.
> > | */
> > The overwhelming majority of existing supported boards in U-Boot are
> > 64-bit platforms, and the 64-bit platforms are the ones that have been
> > supported for longer, so my thought would be that the compatibility of
> > 64-bit platforms should be prioritised over 32-bit? Or even add explicit
> > 32-bit and 64-bit entries and the existing one is a catch-all for
> > compatibility reasons?
> > 
> > Hopefully my lack of bisection isn't causing me to blame something
> > incorrect, but I'll go try to replicate now :)
> 
> Ugh. No, this is a problem that needs to be fixed and I'm sorry I missed
> it during reviews. We need to keep the list compatible.

Hi Conor, Tom,

I am so sorry! I did not catch the compatibility issue as well.
How do you think we should proceed from here?
Maybe revert the whole patchset first?
And then send a fix up patch after?

Best regards,
Leo

> 
> -- 
> Tom



