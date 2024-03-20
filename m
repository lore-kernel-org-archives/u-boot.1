Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D12BBC6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 15:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 061C687E2C;
	Wed, 20 Mar 2024 16:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48AC4879F6; Wed, 20 Mar 2024 16:50:00 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 198B787CEA
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 16:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17CC21007;
 Wed, 20 Mar 2024 08:50:31 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 87F083F64C;
 Wed, 20 Mar 2024 08:49:54 -0700 (PDT)
Date: Wed, 20 Mar 2024 15:49:52 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, lukas.funke-oss@weidmueller.com,
 u-boot@lists.denx.de, Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng
 <bmeng@tinylab.org>, Chanho Park <chanho61.park@samsung.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Manoj Sai
 <abbaraju.manojsai@amarulasolutions.com>, Marek Vasut <marex@denx.de>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Nikhil M Jain
 <n-jain1@ti.com>, Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] spl: Introduce architecture specific init function
Message-ID: <20240320154952.4ee9052f@donnerap.manchester.arm.com>
In-Reply-To: <20240320153316.GW3442575@bill-the-cat>
References: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
 <20240320131928.1836386-2-lukas.funke-oss@weidmueller.com>
 <20240320143048.GU3442575@bill-the-cat>
 <3866627e-de73-dbc7-fd8c-bb2b0d11b5cc@ti.com>
 <20240320153316.GW3442575@bill-the-cat>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 20 Mar 2024 11:33:16 -0400
Tom Rini <trini@konsulko.com> wrote:

Hi,

> On Wed, Mar 20, 2024 at 08:52:30PM +0530, Devarsh Thakkar wrote:
> > Hi Tom, Lukas,
> > 
> > Thanks for the patch Lukas.
> > 
> > On 20/03/24 20:00, Tom Rini wrote:  
> > > On Wed, Mar 20, 2024 at 02:19:26PM +0100, lukas.funke-oss@weidmueller.com wrote:
> > >   
> > >> From: Lukas Funke <lukas.funke@weidmueller.com>
> > >>
> > >> Some architectures use spl_board_init() in their architecture specific
> > >> implementation. Board developers should be able to add board specific
> > >> implementation via spl_board_init(). Hence, introduce a spl_arch_init()
> > >> method which is called right before spl_board_init() for architecture
> > >> specific implementation.
> > >>
> > >> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>  
> > > 
> > > I think this could allow for other SoCs to clean up their existing  
> > 
> > Does it make more sense to make this SoC specific then instead of arch
> > specific to allow broader range of code?  
> 
> "soc" and "arch" are somewhat interchangeable at times, so I think we

Isn't "arch" ambiguous anyway? I connect that with CPU architecture, as in
x86, ARM, RISC-V. And we have that in the top level directories: arch/arm,
etc.
But here it's one level below, isn't it? Where "platform" (or "plat")
would be a more suiting term to describe a SoC family, like xilinx or
sunxi?
So the hierarchy would be really: arch -> plat -> soc -> board?

Or am I confused here?

Cheers,
Andre


> can go one step at a time here and bring in this abstraction and see
> where everyone else is able to clean their code up to.
> 

