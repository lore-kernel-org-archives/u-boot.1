Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297E5D3C544
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D598906D;
	Fri, 18 Oct 2024 05:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DsCieldE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822F5891AA; Fri, 18 Oct 2024 05:05:23 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A4588E81
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:05:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbd092f7f0so10871576d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729220720; x=1729825520; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OQJNRhoyLTdNGsJsf8Qn5/+LTZQ0UDkf/foWksiHso0=;
 b=DsCieldE2NBeSipel85lV+mz+pzp9/GLreF+wIQTge5YIOW9G/Y7odEpn8nLWC271p
 hEM5Ns5GuC7+eyq3762Xx0bY00Vpz0Q7xkv5oRywvPXKU8Hkrvyl/6tJSrinypGx2tLf
 OAZ+PUG3mzXj32IgQRwTsvHGiR6e5GQ286d04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729220720; x=1729825520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OQJNRhoyLTdNGsJsf8Qn5/+LTZQ0UDkf/foWksiHso0=;
 b=CbfWZgtREl01VByilcC+uEaFAt7io8I7LM1KgfJgozrGP14R/gb+2S8wY6lvjbl2NZ
 aXCYQov2mjYlRYyHCmh8aUAU7vOwU5bWoeWfp91ehrh3aJNSSn83T0PZP5LOpQZsXsrH
 vu2tJIBj6Z8hBTnWfDlC+vpzZzI6E/3g3QpsVo9FJe3f8Lu2J2aB4lu0C+ftfTQ09Mb0
 teQOUUtszx82/eC69Vk0RI7BDvlWVLoV6SNSkYGb3Pnf4eqji28lTFbBxGwf0C/v3hTz
 p+gtJ83eZqcaY8xkN4BtHzSwnE3p64OE18G6MIiyyvYSFCC9WuLA4EXgU2Gp4xuNNAAu
 h8UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyyPMIIP3pTctpwlC6jTouJ3ub4JlH4vXnpXX1URiPQdGQBR2adOAFSsO70lmddJLcUAJBWhA=@lists.denx.de
X-Gm-Message-State: AOJu0YyOAPALumYZrCeSw7HfkY/1owBJIAVTtyH76Dl82S7BBkaySgIn
 Qz8bAwdto0b1HZc73OQIpWVu8udYQwCwDUESVWnBPVfoZySOi4735gkYtUlDtGDwnZLh+T3p88V
 oNiolALOcHw6tTxRRdfq7jOSz7hP38hoVxIhT
X-Google-Smtp-Source: AGHT+IFNzfo+rqWdTlDhG5TT8VhUAUaJrbuDi/GySrhQvS+WtVTAwKPJbEzt65QSp8t6cqQ/5BWTQCgjXfJPWKqk5Uw=
X-Received: by 2002:a05:6214:4597:b0:6cb:c6d2:3567 with SMTP id
 6a1803df08f44-6cde14c2a9fmr14121126d6.3.1729220719717; Thu, 17 Oct 2024
 20:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-7-sjg@chromium.org>
 <56ceb77c-efcb-40cb-a497-0952a8457950@gmx.de>
 <CAFLszThLt96h=+28HaD3LmUk-wgj6mnQFav40ndxTxXVZDQw7g@mail.gmail.com>
 <20241018001734.GR4959@bill-the-cat>
In-Reply-To: <20241018001734.GR4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 21:05:08 -0600
Message-ID: <CAFLszThZY6fOOYovYV2KdQHpZ-1q9RK1HyZxrCY8AJ8MYceeXA@mail.gmail.com>
Subject: Re: [PATCH v6 06/12] efi: Use the same filename for all sandbox builds
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 17 Oct 2024 at 18:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 17, 2024 at 05:23:19PM -0600, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Mon, 30 Sept 2024 at 17:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 26.09.24 23:59, Simon Glass wrote:
> > > > Sandbox is not a real architecture, but within U-Boot it is real enough.
> > > > We should not need to pretend it is x86 or ARM anywhere in the code.
> > > >
> > > > Also we want to be able to locate the sandbox app using a single
> > > > filename, 'bootsbox.efi', to avoid needing tests to produce different
> > > > files on each host architecture.
> > > >
> > > > Drop the confusing use of host architecture and just let sandbox be
> > > > sandbox.
> > >
> > > As I already wrote in
> > > https://lore.kernel.org/u-boot/ae1cf1fa-766e-46a0-8ef9-2c2c7af73d9e@gmx.de/
> > > this patch should not be merged.
> > >
> > > bootsbx.efi does not exist in the UEFI specification.
> >
> > If that is of concern I can get it added. Let me know.
> >
> > >
> > > Without this patch I can test that shim work and grub are correctly
> > > loaded from a distro image. This patch makes the sandbox misbehave.
> >
> > Why don't you do that with QEMU?
> >
> > If we want sandbox to do this, I could add a way for sandbox to select
> > its architecture. But this patch is correct, sorry. It is basically a
> > revert of your patch:
> >
> > 3a0654ecd0d efi_loader: correctly identify binary name
> >
> > Let me know if you would like a selection mechanism and I'll see what I can do.
>
> I'm confused. It sounds like Heinrich is using sandbox to test on
> various hosts, how U-Boot behaves, without relying on "just test in
> QEMU". I don't see how this disconnects from your usual request on how
> to use sandbox for further testing. What is breaking for you, Simon, by
> us saying that the host instruction set determines what we load and run
> (and so, is portable whereas saying "sandbox" is not, between x86 hosts,
> arm64 hosts and riscv64 hosts).

This:

Also we want to be able to locate the sandbox app using a single
filename, 'bootsbox.efi', to avoid needing tests to produce different
files on each host architecture.

The idea of using sandbox to run native EFI apps is new to me, but it
sounds great, if it will get us more tests in this area.

But sandbox is sandbox. It is not (x86, arm, riscv). It is a fake
architecture that we use in U-Boot. I've offered to create a way to
get the behaviour that Heinrich wants, so let's see what he says.

Regards,
Simon
