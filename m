Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730C8C369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 09:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA53882F7D;
	Tue,  8 Apr 2025 11:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="V+u98P3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB824833C6; Tue,  8 Apr 2025 11:32:52 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C61982F5A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 11:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id D533925CB6;
 Tue,  8 Apr 2025 11:32:49 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lY5u_Mygv0fJ; Tue,  8 Apr 2025 11:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744104769; bh=LZUCChEePBBwR9C7SYU8U9NrIW2tziyL3nGuekJ62iQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=V+u98P3C4nkMbk7KtnfkCHXu2By736XRjboOmtM9XWrAdu5KvA/D4dfN7WAEuWR9g
 KfqZoVSLcViJ0z1YPWWzseOW4umsVM7EIsS2vB6fRP3gYrsDz2jvafmmleemaJ+BMd
 DmyyesWlkn3gb7721KpPN3nMHB+3wl+DtGIcRgYuSghUOdKEWasxG3MV99hQSzZHA2
 tFqpjthr/W8A1lUdkJzkduoaW/C77BiaJtMunCRgTdkbsY5wnhvJf+2v1BmSog4LOB
 /Ia/0mHgWToxrr83i5qIJYt7WSGf2+VKroKITVnVD699+cKFFDPQJUaPu4qob95WCJ
 9YGtOCZ0xfiDw==
Date: Tue, 8 Apr 2025 09:32:34 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marex@denx.de>, Paul Kocialkowski <contact@paulk.fr>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] riscv: Provide __image_copy_{start_end} symbols in
 linkerscript
Message-ID: <Z_TtMpbhnBMi1Sb0@pie>
References: <20250407033744.4025-1-ziyao@disroot.org>
 <20250407033744.4025-3-ziyao@disroot.org>
 <765a4f82-d0c8-43a3-beb3-31e133fd4811@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <765a4f82-d0c8-43a3-beb3-31e133fd4811@kwiboo.se>
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

On Mon, Apr 07, 2025 at 01:10:32PM +0200, Jonas Karlman wrote:
> Hi,
> 
> On 2025-04-07 05:37, Yao Zi wrote:
> > Binman looks for __image_copy_start to determine the base address of an
> > entry if elf-base-sym isn't specified, which is missing in RISC-V port.
> > This causes binman skips RISC-V SPL entries without filling addresses
> > into its .binman_sym_table section.
> > 
> > This patch defines __image_copy_start in linkerscript of both SPL and
> > proper U-Boot to ensure binman_sym functions correctly with the default
> > binman.dtsi. The paired symbol, __image_copy_end, is introduced as well
> > for completeness.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/riscv/cpu/u-boot-spl.lds | 2 ++
> >  arch/riscv/cpu/u-boot.lds     | 3 +++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/arch/riscv/cpu/u-boot-spl.lds b/arch/riscv/cpu/u-boot-spl.lds
> > index 907094620bd..18eb62c01c6 100644
> > --- a/arch/riscv/cpu/u-boot-spl.lds
> > +++ b/arch/riscv/cpu/u-boot-spl.lds
> > @@ -16,6 +16,7 @@ ENTRY(_start)
> >  SECTIONS
> >  {
> >  	. = ALIGN(4);
> > +	__image_copy_start = ADDR(.text);
> >  	.text : {
> >  		arch/riscv/cpu/start.o	(.text)
> >  		*(.text*)
> > @@ -46,6 +47,7 @@ SECTIONS
> >  
> >  	_end = .;
> >  	_image_binary_end = .;
> > +	_image_copy_end = .;
> 
> This looks like a typo, should probably be with two _ ?

Yes, thanks for catching this. I'll correct it and apply Simon's tag in
v2. Simon, is it okay for you?

Thanks,
Yao Zi

> Regards,
> Jonas
> 
> >  
> >  	.bss : {
> >  		__bss_start = .;
> > diff --git a/arch/riscv/cpu/u-boot.lds b/arch/riscv/cpu/u-boot.lds
> > index 2ffe6ba3c8f..b11ea8b56d2 100644
> > --- a/arch/riscv/cpu/u-boot.lds
> > +++ b/arch/riscv/cpu/u-boot.lds
> > @@ -10,6 +10,7 @@ ENTRY(_start)
> >  SECTIONS
> >  {
> >  	. = ALIGN(4);
> > +	__image_copy_start = ADDR(.text);
> >  	.text : {
> >  		arch/riscv/cpu/start.o	(.text)
> >  	}
> > @@ -57,6 +58,8 @@ SECTIONS
> >  		__efi_runtime_rel_stop = .;
> >  	}
> >  
> > +	__image_copy_end = .;
> > +
> >  	/DISCARD/ : { *(.rela.plt*) }
> >  	.rela.dyn : {
> >  		__rel_dyn_start = .;
> 
