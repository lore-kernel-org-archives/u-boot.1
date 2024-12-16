Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEBCE77183
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 19:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4398A800D7;
	Mon, 16 Dec 2024 20:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="vuZ9b4Xt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EF580104; Mon, 16 Dec 2024 20:40:44 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DEDE800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id EEC2C22513;
 Mon, 16 Dec 2024 20:40:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1734378042;
 bh=lQjFP6oOKcSy4ZHSjCiuT115ZFU+pNWrY360G2TCl7Q=;
 h=Received:From:To:Subject;
 b=vuZ9b4XtrZQMhOMY5ze4t/scKqom/JW/sF2MshgxL0+BxzdbVbtkD03Fi6ImiA3l9
 EBZ/rsdQWXdPqq9vw19G6VduzCskED0WJLgutENsM/yTKWjfze6j8Ol6YWfKvbnKrs
 4UzW9fi8xRKOGHoAUMLKUydGIJMSqbZXWWOPrW+KUpOOGwLDciwRJ8QwvDateP18/s
 ipnMSGLI6SFNnPuo26regA56LuMOzkR5EiPbICi+pGaNI7eao9MYnq1pyoRUuJUTg6
 hgRKATrXINOKdC6xqQ1X0qFdlrCj/QwABuEZGGyXSMaTAsZ3vNFcFuYht6WEcmOTMN
 UAddp2sGWKAEw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 9C6637F9A5; Mon, 16 Dec 2024 20:40:41 +0100 (CET)
Date: Mon, 16 Dec 2024 20:40:41 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Francesco Dolcini <francesco@dolcini.it>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 u-boot@lists.denx.de
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
Message-ID: <Z2CCOS76kgh_Kun9@gaggiata.pivistrello.it>
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
 <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
 <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
 <20241216190255.GA55577@francesco-nb>
 <CADg8p96Aiy-DBNc8piA5gN01E+iWHZJ4OGhY5qjOK1wCUS-O7Q@mail.gmail.com>
 <Z2B_sqO2XcAMIF3H@gaggiata.pivistrello.it>
 <CADg8p94S5kzr_yDhs0m8M_J8U_jKLCkdQ+RXiQAbmL+uF+F4+w@mail.gmail.com>
 <CAC_iWjKV09uXouhvLTKXk3B+Qfw481_unXc1phLq674R0CKyZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_iWjKV09uXouhvLTKXk3B+Qfw481_unXc1phLq674R0CKyZQ@mail.gmail.com>
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

On Mon, Dec 16, 2024 at 09:35:58PM +0200, Ilias Apalodimas wrote:
> On Mon, 16 Dec 2024 at 21:32, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Tue, 17 Dec 2024 at 00:59, Francesco Dolcini <francesco@dolcini.it> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 12:37:38AM +0530, Sughosh Ganu wrote:
> > > > On Tue, 17 Dec 2024 at 00:33, Francesco Dolcini <francesco@dolcini.it> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Mon, Dec 16, 2024 at 11:28:42AM -0300, João Paulo Gonçalves wrote:
> > > > > > Hi Sughosh,
> > > > > >
> > > > > > > Can you show the output of bdinfo. And also print the value of ram_top
> > > > > > > while booting the board.
> > > > > > >
> > > > > >
> > > > > > Below are ram_top and bdinfo:
> > > > >
> > > > > We briefly discussed this off list, what is likely happen is that our
> > > > > heap is after 0xFFFFFFFF, or said in a simpler way in the 64-bit address
> > > > > space, while ram top is at the 4GB boundary.
> > > > >
> > > > > The solution seems to either move the heap down or move ram top up.
> > > >
> > > > I am not sure I understand. Isn't the heap memory part of the U-Boot
> > > > image, meaning it will always be below the ram_top? How do you have
> > > > this configuration where the heap is above ram_top? Can you point me
> > > > to the code where the heap is getting set above ram_top.
> > >
> > > I just guessed this, I might be plain wrong. I assume some malloc is failing,
> > > maybe Joao can confirm.
> >
> > Ah okay. If it is some efi allocation that is failing, then the
> > allocation is not being done from heap. One thing that can be tried is
> > to have ram_top at 0x1_0000_0000 instead of 0xFFFF_FFFF.
> 
> It was an EFI allocation that was failing by looking at the logs

and initr_mmc.

But yes, you are right, it happens during memory allocation using lmb. So what
I wrote is just wrong (sorry!).

Francesco

