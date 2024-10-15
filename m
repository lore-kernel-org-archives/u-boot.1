Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DB1CFC283
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 10:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A8ED88EA7;
	Tue, 15 Oct 2024 12:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="L9GsYy2D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF1B890F2; Tue, 15 Oct 2024 12:19:24 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE4EC88E7A
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: f165b34e-8ade-11ef-93fa-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f165b34e-8ade-11ef-93fa-005056994fde;
 Tue, 15 Oct 2024 12:19:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=umbDJaJ71jbV0PGijbnr3Uh1wvuqbcAJcsYkka9MzrM=;
 b=L9GsYy2DrpoM9vyAJlXsrjwVqC4NoSl8ZC3baDhXWuqpqE1q1VtpBahnh/HuUd6s6SHXQj5NCphLv
 fE30LIdA1sTHDwygu4F6/IFn6fVT9kye4t4LB39aSV6Aojlqgpk3/94BAA9lAC0ej5Z2CcdJMWTObH
 hWsVD93T/k4iBG2c+rwDaePhMoLxybtogEZ8xU+oPOyWmUtX05VrR+00rc8wcDgoZRzXP+RIrCFGfR
 23TfrmdqekpZ+YfOAuyYkCn18+hfwDcqE+30NgRedT3OnyrwiuCvqoelwzzrTDOQ1AgmXtX0QT4Is/
 UJ1dxNsn4ygLjEINEMqqIaAN6N5OcYg==
X-KPN-MID: 33|fD2CYhh8UM9GCr/xwSzmjBunDKC+ra39osgwR78JNXqXtR/u23ixFUXFm7VUJ4O
 ONT5zem51z672tLLBr/YBme+2JLWwfqEjOo1tgR0swvY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|mfc2UglvdoTZuL3Jn62jY3Ny5WwJ1Vx+mu6Zn1TGN9haUyCRYMafnyH1O3ri1it
 mphrJQlkLsXyqM0hKZJX3FQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id ef89713c-8ade-11ef-b655-00505699b758;
 Tue, 15 Oct 2024 12:19:22 +0200 (CEST)
Date: Tue, 15 Oct 2024 12:19:17 +0200
Message-Id: <87cyk1hdne.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
In-Reply-To: <20241014211150.GX53053@bill-the-cat> (message from Tom Rini on
 Mon, 14 Oct 2024 15:11:50 -0600)
Subject: Re: [PATCH v6 12/12] test: efi: boot: Add a test for the efi bootmeth
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-13-sjg@chromium.org>
 <20241011223227.GA630742@bill-the-cat>
 <CAFLszTgoxND_qi8WzdgC8-mQLf0e14Mt=KgXy=bqWkqo4svG9Q@mail.gmail.com>
 <20241014035122.GE53053@bill-the-cat>
 <CAFLszTiVsoTdKiKmPVugc9cLk-A+XM2EdiPUE0AFK=g8RPx+0g@mail.gmail.com>
 <20241014211150.GX53053@bill-the-cat>
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

> Date: Mon, 14 Oct 2024 15:11:50 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Mon, Oct 14, 2024 at 01:13:41PM -0600, Simon Glass wrote:
> 
> [snip]
> > Or perhaps just have a way to turn it off? I first sent this patch
> > last November. It is just wrong to generate output like this which we
> > don't want. There isn't even a test for it, so just add a way to
> > disable it, and be done!
> 
> I don't know that it's unwanted. As I'm trying to get Heinrich to
> explain, _why_ does efi_setup_console_size need to exist, and do what it
> does? This isn't the case of color-coding the output of tests as they
> happen, there must be a reason we care about knowing the console size.
> At that point we can figure out if the right answer is:
> - Don't generate that check on serial ports, it's somewhere between
>   misleading to wrong.
> - text-based tests just need to expect and skip it because there's a
>   good reason to need to know the console size and not just assume
>   80x24.
> - Something else we won't know until it's clearly explained why we do
>   this.

Sadly this is a misfeature of UEFI.  The EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL
is required if console devices are supported by the UEFI
implementation, and is built around the concept of "text mode" with a
fixed number of character rows and columns.  That pretty much assumes
there is some sort of terminal emulator on the other end.  And this is
pretty much incompatible with anything that just want to log serial
output.

I think it is possible to do better though.  Instead of calling
efi_setup_console_size() in efi_init_obj_list(), we could postpone
this until the application makes a call that requires us to know the
size.  This would mean that a simple EFI application that just uses
EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.OutputString() (such as the Hello
world EFI application or the OpenBSD EFI bootloader) wouldn't have to
do the size query.
