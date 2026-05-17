Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0708DCD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 22:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BB284676;
	Mon, 18 May 2026 00:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ioVH5j8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61D6184676; Mon, 18 May 2026 00:52:25 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4561D846EB
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 00:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bccd251d622so310334066b.3
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 15:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779058343; cv=none;
 d=google.com; s=arc-20240605;
 b=P0nMl7+9Sis3R1PjXm6oDfQWzhcz3vhBrOGypshhZcEVzA0Cb9VJklQpqJ2oY58iX9
 //DgWVPbkBagWnhEdSrf4RueVqb8rIfKxA9MZyLMBdTBeL3OAxBLIJ4OBG9pRtEgIrTX
 IxMxy72xLpvzpqLIc3R5iWyEW9hryM7SQs/rCvbFWz6E/gZKhIrULAmxTJGhoVxja6Kb
 wesS86YvsV3PEK0e+tvrlTZRjPgU+uianvir6r8u9cJ6zxFJPS1+N+k6O8o5c0e6MGHs
 rbAFNSKAplVR1tRtu3PKBiJ64Rd9WZWOp6l6FdCPX/5nsWv5aXojel0+Pju7WrztgCfZ
 zbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ThaNJ5YKFtIy3pMyM67/scUoO1si5hEDqfbrfhIIwD0=;
 fh=gBCcreOcmnJCnmOTne/RR6VZWuDXEBCdUiN6nuFlCts=;
 b=GCznaLHWvI/zaRctNJzRW1Xxtef0mNOODQ6V503ZfsPsR3QGmCwv1e1UgdO5oUsVlp
 YOxzJdg++ZWUoBALmxBeY0UInEzIZM8foEmpbWJk482M68TT71BKx0m1lIwrJlCP7MuZ
 NDMLIj4pJv8d1ytHO+eqeM/kQk8wxRsZ3SPAQ/ygOhVFVPaViWgWytWze5ZOwKitkmR5
 WIV5AerzH00oRd8QLNM/dI9qui/anOHqgOclu+Vxs5M4ElIDkqujTfKi5aKjkzI5H6jI
 a3bXuEjJ2C7MElC5REPjuU4Eqm8/lXXiC2izXe4x/WkZ6xmwNYaW69WTCRIXkvJyPd3H
 S9JA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779058343; x=1779663143; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ThaNJ5YKFtIy3pMyM67/scUoO1si5hEDqfbrfhIIwD0=;
 b=ioVH5j8+hfg9Dy7cf/z4qyK4AE+0ocsYU7q0J61XHbH6vPNsZZWcXPpcT9O9ZqtF6g
 pkOeDM3jIVjUpfTw4PZ4pK7+ldHleWqLlR3EYc5XwbrKKNsovvrXcfDQDrxoxO6GQ2DC
 /4KA/HmqkoWk6pJhIxzevw5HRCRSlNj1mHJLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779058343; x=1779663143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThaNJ5YKFtIy3pMyM67/scUoO1si5hEDqfbrfhIIwD0=;
 b=qYX29WQc+PEwGIkHhti5fiQuu20PMLwd5ReYEIlfA4OEJzkQ78ppkBLYAQKYlZfyfo
 Sl14xR5vcgOttaDybNeRY6ITW1yPKGLQR/JWefrCZooNjUUkyksN8Y41RfAX+6ZaepVE
 21XB1pPAnkBrOClwLD+6JMV78KtGF+uDqPIfWD7zyE1cyV7Qdx6YtMAPXrAEq8nrpLOd
 iwroc1wfHRC7OFG1Y+76aLIXe3goh/E8lo3q4BZ+rcTQiCObOA+mfD6zQU6GWaLhMMMG
 cuylQZFiUjJ218jhVADyYyUW4wS+fH5Z/8INx8e3Gt+17GHiOx4cROaoE2HuiH5hEzYj
 fwdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ92oK6XT/YzsquDgaTlmVqZzf9eza0WhJm54b3VKN/ytcRSRQzP6dtSCkpxiD1M+4dBvpc8Ysw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzj4Y6idT+nFP6TNYko5dhSiFSbyCHgELPpZam9opaqCJF1AIcE
 ZBaA4elgItkxjbgJuoWIwaHwULzQUVatWFEfckYM8E8BRoW47mdfPjF3nU++z9Sx8GPfIjqe/wj
 E2ILjHP3/cnoWTYIkPmZpYY3WjXC3CYld7UiTaL9b
X-Gm-Gg: Acq92OGIa+pQ9Ek+EXWdUv/WJnEFhWNi3Si1S4u3rTe1dLCQ1t/1ev9t5M57qz6Klpp
 L+mVx06YdlpBNZYX9ZUS2s8cpi7hCctrPORrGFVryvnF4cawLMZEO6ZuliPdvwpNsNcusX5LO6z
 4zsynwwjxBaY2NXz+X5LJD9K/+n440X3NDgOkW2+lQQvL/dIopJJlAh8dGzFBTVGbnSlZ2c57Y8
 bfGAKWUCqxUUj0gjEmHUG5d1NIyxu3Bb1P9iqrEiArFKhwUcHo7CVAGcLjD679ikTOsUGG7nBXE
 Uwxspwnr
X-Received: by 2002:a17:906:6185:b0:bc4:b9f5:fe27 with SMTP id
 a640c23a62f3a-bd51780c8acmr663077566b.10.1779058342735; Sun, 17 May 2026
 15:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260515054327.1033466-1-w.egorov@phytec.de>
 <20260515145400.GB1858239@bill-the-cat>
 <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
 <20260515160256.GF1858239@bill-the-cat>
 <CAFLszThfUMe=67xwzbv6TvugH3iCOO=-EoYk6oUshKru-wpDQw@mail.gmail.com>
 <20260515182441.GI1858239@bill-the-cat>
 <CAFLszTjHaqck4gVDSiBw0M9V3yZLzUa8+EjaW94G9JcO=-Ny8Q@mail.gmail.com>
 <20260515184434.GJ1858239@bill-the-cat>
In-Reply-To: <20260515184434.GJ1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 17 May 2026 16:52:10 -0600
X-Gm-Features: AVHnY4LRkoL0spnmof3nve5VsgTQHfWni9_M7H_rXQNydCgxRNpzHvkhpVP0QUc
Message-ID: <CAFLszTj616BX3ppdVLeR1mcRnXLJ41uUpQkC7gY0NOSn2ffkbw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
To: Tom Rini <trini@konsulko.com>
Cc: nm@ti.com, Wadim Egorov <w.egorov@phytec.de>, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Fri, 15 May 2026 at 12:44, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 15, 2026 at 12:32:30PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 15 May 2026 at 12:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 15, 2026 at 12:13:50PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 15 May 2026 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, May 15, 2026 at 09:35:10AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 15 May 2026 at 08:54, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrote:
> > > > > > >
> > > > > > > > A file like rm-cfg.yaml accidentally left in the source tree root
> > > > > > > > shadows the board-specific copy. binman builds the wrong YAML, the
> > > > > > > > resulting rm-cfg.bin may match a different SoC, and we end up with
> > > > > > > > the following error:
> > > > > > > >
> > > > > > > >   k3_system_controller sysctrler: k3_sysctrler_start:
> > > > > > > >       Boot Notification response failed. ret = -110
> > > > > > > >
> > > > > > > > Move the board directory ahead of the srctree root so that the
> > > > > > > > most-specific match wins.
> > > > > > > >
> > > > > > > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > > > > > > ---
> > > > > > > >  Makefile | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/Makefile b/Makefile
> > > > > > > > index 552328f9f2c..1ec29dfe0be 100644
> > > > > > > > --- a/Makefile
> > > > > > > > +++ b/Makefile
> > > > > > > > @@ -1682,7 +1682,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
> > > > > > > >               build -u -d $(binman_dtb) -O . -m \
> > > > > > > >               --allow-missing --fake-ext-blobs \
> > > > > > > >               $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> > > > > > > > -             -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> > > > > > > > +             -I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
> > > > > > > >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
> > > > > > > >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> > > > > > > >               -a atf-bl1-path=${BL1} \
> > > > > > >
> > > > > > > Why do we need to look in $(srctree) itself?
> > > > > >
> > > > > > See for example:
> > > > > >
> > > > > > arch/arm/dts/k3-j721e-binman.dtsi:308:  private-key =
> > > > > > "arch/arm/mach-k3/keys/custMpk.pem";
> > > > >
> > > > > That's not great, I'm sorry I missed it at the time. I wonder how easy
> > > > > replacing that key is with a non-dummy key. Hopefully it's done in a way
> > > > > that doesn't encourage checking private keys in to repositories..
> > > >
> > > > Typically we would use an environment var passed in from the Makefile,
> > > > as we do with BL31, TEE, TI_DM, etc.
> > > >
> > > > >
> > > > > > Also, people sometimes put files in the source tree, e.g. BL31 images,
> > > > > > in the hope that they will be found.
> > > > >
> > > > > That's also a bad practice and what BINMAN_INDIRS is for.
> > > >
> > > > Yes, but that came quite a bit later with the bintool stuff (2021).
> > > >
> > > > Anyway, with a bit of work I believe we could drop the source dir.
> > > > Would you like to look at it, or should I?
> > >
> > > Well, the first step would be getting some more feedback on how people
> > > override some of these files for example. Even more environment files
> > > seems like a bad idea and I'm not sure what BINMAN_INDIRS can't cover
> > > today.
> >
> > Assuming you mean 'environment variables', we do need the actual
> > filename, not just the directory. We could have default filenames for
> > each entry type, I suppose. Some do already.
>
> Yes, I think moving that way is the right direction. I was going to use
> -scp-path=$(SCP) as an example of something to move away from, but it
> looks like that's already being done in a way BINMAN_INDIRS should
> handle.

Yes, the idea is that '-a scp-path=$(SCP)' tells the scp entry-type
the filename to use. I'm pretty sure we could update the tests to set
that entry-arg, so we don't need the source dir in the path.

But in any case this patch is correct for now.

Regards,
Simon
