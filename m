Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC64DCDD0E6
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 20:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CA888FD6;
	Tue, 22 Oct 2024 22:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729628369;
	bh=e9PfrbG3Eh7W3pHj97e2lT0rd8xw7XUlGEff1tJjWf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vp/WurDPONw8C6IrnhkD2VpYoGQdiDVtkyVdQ4GjkhiI6h+E99DQErbZAu4eV6HwB
	 AHZS3pjAmT9DepOGw0IHDu0QX6MA0XTw1zVuDM2YxgZk5GDtSyrmoNPYgNR7Y3/aoS
	 /lrb1i7+L1tnU9sI0s8DE4Au7uWyg7/H9kEaqd0oy9e+dv8U6DFGzCNvgRUF+YhhrX
	 tnS4MBFL1Da7My3g1bk8eGjG8SlDX5Z4KYOQewYTgSIkFDYyvjveldN/c3D7QJN73X
	 cITZquAi4GUIrkvR4g/gx9predqbcqc933lFx0lFYh4yaX3PrAMPbtx1JKUd6GNxRw
	 2ZB/UhEXbXCyQ==
Received: from crub (p5483347b.dip0.t-ipconnect.de [84.131.52.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3F77388FCC;
 Tue, 22 Oct 2024 22:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729628366;
 bh=e9PfrbG3Eh7W3pHj97e2lT0rd8xw7XUlGEff1tJjWf4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=llNIZcMtjYy/B1lf2Ny2RmHIseURrvUGs2AWEsXpyJvhHgsRNCZZALXSxFJv2HjIq
 T00XRXbMJ7OJQ0wNJRHl3DPD+AXfkXMF4IK8ipfQihOyw28r+czXyvRRwfvE6GRlbH
 mSH5jGNJyre/zEactPc52exgkXBNYb6/tWZuJCp9X7G/7gEcZjpgo+myOPzQ0QCyLx
 HIcPkQFbqS0vBajj7gCzvXW/6Sx6+epad2WCWtQwPc2R2TZPxO0mqZILPs34Bulbs3
 ZF8eJtNbXGwGiuTEjNIxFRp3DqtZnTMv6tiIgHTx3XWuRP2adBaegOPogH6eu41Dk0
 1VVZ+ARIFhQ3Q==
Date: Tue, 22 Oct 2024 22:19:25 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Tom Rini <trini@konsulko.com>, Devarsh Thakkar <devarsht@ti.com>, nm@ti.com
Cc: u-boot@lists.denx.de, bb@ti.com, sjg@chromium.org, praneeth@ti.com,
 vigneshr@ti.com, s-jain1@ti.com, r-donadkar@ti.com, j-humphreys@ti.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, akashi.tkhro@gmail.com,
 mkorpershoek@baylibre.com, eajames@linux.ibm.com,
 caleb.connolly@linaro.org, quentin.schulz@cherry.de,
 martinstolpe@gmail.com, iivanov@suse.de, n-jain1@ti.com
Subject: Re: [PATCH 0/3] Simple-framebuffer node related updates
Message-ID: <20241022221925.61550574@crub>
In-Reply-To: <20241021202056.GU4959@bill-the-cat>
References: <20240925151354.480704-1-devarsht@ti.com>
 <66434f62-e7e6-5414-cc5e-64f516288795@ti.com>
 <20241021202056.GU4959@bill-the-cat>
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

On Mon, 21 Oct 2024 14:20:56 -0600
Tom Rini trini@konsulko.com wrote:

> On Mon, Oct 21, 2024 at 08:47:55PM +0530, Devarsh Thakkar wrote:
> > Gentle reminder.
> > 
> > Hi Tom, Bryan,
> > 
> > On 25/09/24 20:43, Devarsh Thakkar wrote:  
> > > This series fixes some compilation issues related to FDT_SIMPLEFB
> > > and VIDEO and along with that enables support for dynamic simplefb
> > > node enablement for AM62x platform.
> > > 
> > > Devarsh Thakkar (3):
> > >   boot/Kconfig: Add Video Kconfig as dependency for FDT_SIMPLEFB
> > >   boot: fdt_simplefb: Remove conditional compilation checks for VIDEO
> > >     Kconfig
> > >   board: ti: am62x: evm: Update simple-framebuffer node in device-tree
> > >   
> > 
> > 
> > Is it possible to pull in this series for -next branch ? It is already
> > carrying a R-B for first two patches and last one was peer reviewed informally
> > too [1].
> > 
> > [1]:
> > https://lore.kernel.org/all/CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4jX7=rw@mail.gmail.com/  
> 
> Anatolij, do you have time to pick up some patches for v2025.01? Thanks.

series applied to u-boot-video/master, thanks!

--
Anatolij
