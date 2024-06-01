Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77A7C25B7E
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 16:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE54F8811D;
	Sat,  1 Jun 2024 18:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62438812B; Sat,  1 Jun 2024 18:37:51 +0200 (CEST)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
 by phobos.denx.de (Postfix) with ESMTP id AEA948811C
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 18:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=macro@orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 03EF492009C; Sat,  1 Jun 2024 18:37:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id E9CF992009B;
 Sat,  1 Jun 2024 17:37:48 +0100 (BST)
Date: Sat, 1 Jun 2024 17:37:48 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 2/7] efi: Allow runtime relocate to be disabled
In-Reply-To: <7160e2f2-358c-4f3e-9865-1632ffea7975@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2406010323210.23854@angie.orcam.me.uk>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-2-79096e3ca3b3@flygoat.com>
 <CAC_iWjKKyUm=4NJVuWgUqmFR43TNcuxFKmaBJLAFKC2CQYbxJg@mail.gmail.com>
 <7160e2f2-358c-4f3e-9865-1632ffea7975@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 21 May 2024, Jiaxun Yang wrote:

> It's nearly impossible to run MIPS OS in virtual (or paged)
> segment. All MIPS OS and bootloaders are running in KSEG/XKPHYS
> segment, which directly mapping lower bits of virtual address
> into physical address. So I suppose set_virtual_address_map
> is unnecessary on MIPS because the mapping for U-Boot is
> always here and can't be disabled in hardware.

 Surely it's possible to run a MIPS OS kernel mapped via page tables, it 
is what KSEG2 and XKSEG segments can be used for with 32-bit and 64-bit 
configurations respectively.  Both CP0.Context and CP0.XContext registers 
support placing page tables in virtual memory too, KSEG2 and XKSEG 
segments respectively, and a nested TLB refill exception is supported.  
Only the TLB exception handlers themselves obviously have to be unmapped.

 These features have hardly ever been used (original MIPSCO OS reportedly 
was an example, perhaps unsurprisingly), but they are there and it cannot 
be stated that it is nearly impossible to make use of them.  It is not.

 Note that the MIPS architecture does not have a real mode, but its 
purpose is served by the unmapped segments, which are also convenient to 
use for various reasons by OSes that otherwise do virtual addressing.

 Also for the record there are SGI IP27 Linux configurations that run from 
XKSEG rather than XKPHYS (running from KSEG2 used to be supported too, but 
has been since dropped), via a wired page mapping.

 I guess none of this really matters for U-Boot, but let's get the facts 
straight so that people who are not MIPS experts are not led into false 
understanding.

  Maciej
