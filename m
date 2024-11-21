Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8C6E64039
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00400891A8;
	Thu, 21 Nov 2024 23:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Qkg49PP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F4E891C4; Thu, 21 Nov 2024 23:49:11 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A8A888C05
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7f71f2b136eso1282418a12.1
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1732229347; x=1732834147;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWWPth5uQkZhgwvhd76A2YD+HHlFbWjNY4MLrsWKwD8=;
 b=Qkg49PP28TMrobRGIui89sA4Dn2/xVG6urL8HIbHtvLvMXMgKUmC5vMFG9+be3Rpyw
 UHvT+YxL02hQuRmd2tnrmKrq94ZjSbk8Oydd6R1VbyggpjlvShVMiRSoIDgDPSKUkzQi
 Wpsf3dL6sM29ZxX8HmfkFImlXrLSSDOjoFrjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732229347; x=1732834147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWWPth5uQkZhgwvhd76A2YD+HHlFbWjNY4MLrsWKwD8=;
 b=RTau+ZJpwfQUf8SiIkRQ3k3NFN8b2e1mm1X7Yg9xkIbDJ+oqdq0qW23DsK+GhccS6x
 hZBRmuPzl9KhUVLXz5ufWtYLxs2Q/iuYAsLsL+1lCJk99fnZdROWWrcw2tR1TXaYOIRL
 Y/EYkULBGo9QZaWyHRdrXANdz9p9aKNjSwcaJo/ocPKYFwxpyD+nbW5OJG3GgiZOMGFA
 NTF6mJ+Exhcuos8NwQzylcHS/+DyyBFRo0gYNIBEcLzpos8vo2hMSbcDJncWBA3zZHk3
 Fs583pa2y2L7DthWxmoh7syreLju4HjNlGI5fgaZx/hqbE5xxu29WFXy9BlUuuOUlldO
 HrKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6A7fdZcAzEKvisCFoZV5MJQVUZklnf79Fs7BlFQcqiwyi+O37zodExWUU5YUZZv+oA2b5QIw=@lists.denx.de
X-Gm-Message-State: AOJu0YxH2N7fhuYZDUe47QIS5oaCAZMVKmIoN/88xUWSG9z4shqbBmIt
 kQDlQUVrx192cVCHR26cp2UqN2g5kgoP3p4vf10yMutpJW7r5fBIxQ24oNUgTya54yNMMt+D9wE
 DoG87tIVR69Ma3gD7LhMAdpMs9lA/fobzmUMRLlRmECphUkQ2
X-Gm-Gg: ASbGncuSmqka7JyoJup88DeQq3/GKqZ+79NI2nrAiuzrTfCfqBT5OA2fZRD4Kti6WjY
 bO2I0jNMSNbY+/UrPmLio+NPk10Nk18g=
X-Google-Smtp-Source: AGHT+IFkJx2oMKlx53tfDL39X/Gum4hNdD5F0O8ZCRf2jD4Br0G9nS/XYho22SOh9AeyAgdWlXzCgpv5OVLVegqTTUs=
X-Received: by 2002:a17:90b:4b4f:b0:2ea:83a0:4797 with SMTP id
 98e67ed59e1d1-2eb0e2336e3mr667624a91.11.1732229347481; Thu, 21 Nov 2024
 14:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018083006.10349-2-b.spranger@linutronix.de>
 <0c9225d8-9cd2-407e-aea8-baf31efcac34@linaro.org>
 <442a29af-c0b5-4ef1-9b38-51d96b0fe6c0@linaro.org>
In-Reply-To: <442a29af-c0b5-4ef1-9b38-51d96b0fe6c0@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 21 Nov 2024 23:48:56 +0100
Message-ID: <CAOf5uwnQ_xNzQMTDfftf2rJfa1GZps=-FV7KkdWd7W2LdTzhCg@mail.gmail.com>
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D2 based board
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: dario.binacchi@amarulasolutions.com, 
 Benedikt Spranger <b.spranger@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

HI all

On Tue, Nov 19, 2024 at 4:46=E2=80=AFPM Eugen Hristev <eugen.hristev@linaro=
.org> wrote:
>
>
>
> On 11/12/24 15:45, Eugen Hristev wrote:
> >
> >
> > On 10/18/24 11:30, Benedikt Spranger wrote:
> >> Hi,
> >>
> >> while porting an ATSAMA5D2 based board (booting from NAND flash with U=
BI)
> >> I stumbled over generic, NAND- and UBI related asperity:
> >>
> >> 1. tiny-printf does not handle NULL arguments to '%s' in a proper way
> >> 2. vtbl_check() has an useless debug output due to a typo
> >> 3. NAND: An informative output fails badly, if the NAND vendor is unkn=
own
> >> 4. the nand_atmel driver lacks a vital initialisation
> >>
> >> OK, you might say the nand_atmel NAND driver is obsolete, but it was t=
he
> >> only solution to get booting from NAND running. The new DM based NAND =
driver
> >> refused to do anything usefull, so I dropped it after spending a coupl=
e of
> >> days debugging it:
> >>
> >> <RANT>brilliant!</RANT>
> >>

I totally missed those patches. I'm really concerned about it. I will
review the respin

Michael

> >> regards
> >>     Benedikt Spranger
> >>
> >> Benedikt Spranger (5):
> >>   tiny-printf: Handle NULL pointer argument to %s
> >>   drivers/mtd/ubispl/ubispl.c: Fix error message
> >>   mtd: nand: raw: Fix potential NULL pointer dereference
> >>   mtd: nand: Update NAND manufacturer Ids
> >>   mtd: nand: raw: atmel_nand: Add missing nand_scan_ident()
> >>
> >>  drivers/mtd/nand/raw/atmel_nand.c |  4 ++++
> >>  drivers/mtd/nand/raw/nand_base.c  |  8 ++++----
> >>  drivers/mtd/nand/raw/nand_ids.c   | 22 ++++++++++++----------
> >>  drivers/mtd/ubispl/ubispl.c       |  2 +-
> >>  include/linux/mtd/rawnand.h       | 23 +++++++++++++----------
> >>  lib/tiny-printf.c                 |  2 +-
> >>  6 files changed, 35 insertions(+), 26 deletions(-)
> >>
> >
> > Coming back to these patches I had a look and except a typo , it looks =
good.
> > I can take these through at91 tree or maybe Michael you want to have a
> > look as they touch the MTD/NAND drivers ?
> >
> > Thanks,
> > Eugen
>
>
> I have applied patches 1 and 2 to u-boot-at91/next .
> The other three would need a resubmit .
>
> Eugen



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
