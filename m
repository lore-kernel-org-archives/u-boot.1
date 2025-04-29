Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9600AC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEBF982145;
	Tue, 29 Apr 2025 14:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="PJSipluc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B708219D; Tue, 29 Apr 2025 14:31:48 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B028210D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 14:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1AE3E25B33;
 Tue, 29 Apr 2025 14:31:46 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9gWlFu334O_H; Tue, 29 Apr 2025 14:31:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745929905; bh=O5ZgJlxHzMKXb/08pyqbDn8k40+5Zwp5gOBixUSmf4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PJSiplucV/IyOWFeb1+sfZNCNGQXqpe45iCJZLFBF8pOwlVHHzs/GpMHk2d+zAOIk
 VslfHLWvOX7NxCiYb+MhTC3f04h4VgSI3oVYYU1gg533dEcaUYDeOw9bAPU+a/qmre
 b+OzcI3tg6BFiGXu3U/3gb8X774PTE9RBDva4joBj8PaSwfyQikQeDTqVQpSYRTP0z
 B7VEeOKcKxpmut8kMNzG4dqw5mfc8JnJ2TCES5qGk9VsNtPzCXWwGPQkbcp+hOwmwU
 9tBca7FfNaUUnpiv4NmgOCNo6W4s2Lh3IvqsiOPJzIDeI4z3CiOIiJa3zBC3fbieE6
 mn0VjHdn+nIiA==
Date: Tue, 29 Apr 2025 12:31:29 +0000
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 Nathaniel Hourt <I@nathaniel.land>
Subject: Re: [PATCH 1/2] Makefile: Strip leading spaces when preprocessing
 generated_defconfig
Message-ID: <aBDGoWxfU5I2_ZXs@pie.lan>
References: <20250427145011.17331-1-ziyao@disroot.org>
 <20250427145011.17331-2-ziyao@disroot.org>
 <1526A781-5592-43DE-94F2-221DAA484192@gmx.de>
 <aA5RcIbI7uhsGmu8@pie.lan> <20250427161627.GZ5495@bill-the-cat>
 <aA78p0FgCZYmoeBM@pie> <20250428144943.GA5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428144943.GA5495@bill-the-cat>
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

On Mon, Apr 28, 2025 at 08:49:43AM -0600, Tom Rini wrote:
> On Mon, Apr 28, 2025 at 03:57:27AM +0000, Yao Zi wrote:
> > On Sun, Apr 27, 2025 at 10:16:27AM -0600, Tom Rini wrote:
> > > On Sun, Apr 27, 2025 at 03:46:56PM +0000, Yao Zi wrote:
> > > > On Sun, Apr 27, 2025 at 05:19:04PM +0200, Heinrich Schuchardt wrote:
> > > > > Am 27. April 2025 16:50:10 MESZ schrieb Yao Zi <ziyao@disroot.org>:
> > > > > >Clang's preprocessor may emit extra spaces for lines starting with '#'.
> > > > > >Lines with these extra characters cannot be handled by Kconfig and will
> > > > > >be ignored with warnings like,
> > > > > >
> > > > > 
> > > > > 
> > > > > Do you have an example for reprocing the issue?
> > > > 
> > > > Sure,
> > > > 
> > > > 	clang-19 -E -nostdinc -P -I . -undef -x assembler-with-cpp \
> > > > 		configs/starfive_visionfive2_defconfig
> > > > 
> > > > or a smaller example for demonstrating the behaviour,
> > > > 
> > > > 	cat << EOF | clang -E -P -x assembler-with-cpp -
> > > > 	# comment line
> > > > 	normal line
> > > > 	EOF
> > > > 
> > > > and you could see the strange indentation. For reproducing the exact
> > > > Kconfig warnings,
> > > > 
> > > > 	make ARCH=riscv \
> > > > 		CC='clang-19 --target=riscv64-unknown-linux-musl' \
> > > > 		starfive_visionfive2_defconfig
> > > > 
> > > > (Clang is called clang-19 on my machine)
> > > > 
> > > > > Is there an understanding why Clang behaves in this way?
> > > > 
> > > > Sadly I have no idea. I guess it may serve for improving
> > > > human-readability of the preprocessed output.
> > > 
> > > This is https://github.com/llvm/llvm-project/issues/78778
> > 
> > Thanks for the reference! I did a quick search among LLVM's issues
> > before sending the patch but didn't find anything useful.
> > 
> > Do you think such workaround is acceptable? It seems the link should be
> > included in commit message as well.
> 
> I'd like to see if we can get llvm to fix this moving forward first. Can
> you please comment on the issue as you're hitting this now too?

Sure it should be fixed in LLVM and I've left a comment in the issue.

But even though it's fixed in upstream, it will be nice to have such
compatibility workarounds for some time to keep compatibile with older
Clang toolchains, about which my concern is most.

> -- 
> Tom

Best regards,
Yao Zi
