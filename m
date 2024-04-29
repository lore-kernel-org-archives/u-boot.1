Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85BDC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 17:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4492F887DD;
	Mon, 29 Apr 2024 19:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YTz6sI13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4832688801; Mon, 29 Apr 2024 19:00:03 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5776988516
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 19:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5708d8beec6so5898999a12.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1714410000; x=1715014800;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnQwKiTUQgV8lK7xzkATw09ffvZYKXwnPEuDjX50AUo=;
 b=YTz6sI13DpyEgma8mQyvwQMcxTgHFQXMKuDkd1ELSKMypikFr81MlBWeYMF11Q8epv
 TrMXc/B0c0Gt9a1uLeAaxsud614mwydkmXnwnsQjSc0EaX9G/5Jq4gGhVCsv1wqjX7nl
 m1MhplmlUiD4/IF9DCavsIAwjT2JbjGkkdwUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714410000; x=1715014800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnQwKiTUQgV8lK7xzkATw09ffvZYKXwnPEuDjX50AUo=;
 b=AsEZcRKw8jTBOHdRPubfaxn9jCojHVTPBK5zvHNXNYgBV7lUPHMJXGvrp7tRcF+NVA
 aC/aiVoRh+kby0AnlDW+Amr06OAjxudQWgitnkC020qkzdqZIdZBsmc+DTe3CZtbxi+S
 ZI239jjYqu2qIZNLgYaz4THX9V6MV+wAtYz5JFcfZCt3qyKOHoXVZCDW2Jy/6SaRH8ye
 a9bbvOibpvLXkuIrnHK/5kIwaT7/tS8mnQyRv3N4fLT4SYpwDCEDdzaU/365KaW2JNm4
 pFmtb9pFWgfcpRxPWoeC0LO2iu/ubM69/l5OJN72kfFnABbN93rhPZsZve7/zqSK60s8
 5IgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbDhY9PKtxwJxN2NjwDpYKYYOpdVIrevfqLvpiRwVTABmna6W3jHWqlP+ythlcXTJSgmPGmjGumES4gttnSU4FP+KXFA==
X-Gm-Message-State: AOJu0YxX1OWSXjhJY87qtXfQ41sLT+WeGzL25gnTQD55bBR+/BAwahko
 JFsrfNhQkxvPMXy/OZy/wapUxiMH08fIXWBp7HUNuUJq+U9kJKQhM4CJ0lVLbcgQ+gUeRlC7JyE
 lQz2EGhpK3h3y5GCSo6Qgl4vKfgtLTIw3LyAMRQ==
X-Google-Smtp-Source: AGHT+IF/eUMwB5KOToDzIZHIgj2IiiZNtRjBwoldX93yQDmabhWF4pdDPLq8W4HkMYVip34QRiZ6RZsmCVIsKpvXmxs=
X-Received: by 2002:a17:906:c202:b0:a52:5493:a0b9 with SMTP id
 d2-20020a170906c20200b00a525493a0b9mr9547056ejz.39.1714409999652; Mon, 29 Apr
 2024 09:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <ea0422cd-a8e6-3c36-f551-a0142893301b@marvell.com>
 <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
In-Reply-To: <CAFOYHZCAKtYiy=3X=u2+oqv3Wx8=W-vtV=+akbo+e479hPoX7A@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 29 Apr 2024 18:59:48 +0200
Message-ID: <CAOf5uwm+Am-J6-yiCy0=N=FrcVpYGubtUfW9JT6YN3dp4-zutQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: pxa3xx: Incorrect bitflip return on page read
To: Chris Packham <judge.packham@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Ravi Minnikanti <rminnikanti@marvell.com>, u-boot@lists.denx.de, hs@denx.de,
 trini@konsulko.com, sr@denx.de
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

On Mon, Apr 29, 2024 at 6:22=E2=80=AFPM Chris Packham <judge.packham@gmail.=
com> wrote:
>
> On Sun, Apr 28, 2024 at 4:15=E2=80=AFAM Ravi Minnikanti <rminnikanti@marv=
ell.com> wrote:
> >
> > Once a page is read with higher bitflips all subsequent reads
> > are returning the same bitflip value even though they have none.
> > max_bitflip variable is not being reset to 0 across page reads.
> >
> > This is causing problems like incorrectly
> > marking erase blocks bad by UBI and causing read failures.
> >
> > Verified the change with both MTD reads and UBI.
> > This change is inline with other NFC drivers.
> >
> > Sample error log where a block is marked bad incorrectly:
> >
> > ubi0: fixable bit-flip detected at PEB 125
> > ubi0: run torture test for PEB 125
> > ubi0: fixable bit-flip detected at PEB 125
> > ubi0 error: torture_peb: read problems on freshly erased PEB 125,
> > must be bad
> > ubi0 error: erase_worker: failed to erase PEB 125, error -5
> > ubi0: mark PEB 125 as bad
> >
> > Signed-off-by: rminnikanti <rminnikanti@marvell.com>
>
> Looks good to me
>
> Reviewed-by: Chris Packham <judge.packham@gmail.com>
>
> > ---
> >  drivers/mtd/nand/raw/pxa3xx_nand.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/pxa3xx_nand.c b/drivers/mtd/nand/raw/=
pxa3xx_nand.c
> > index 1d9a6d107b..d2a4faad56 100644
> > --- a/drivers/mtd/nand/raw/pxa3xx_nand.c
> > +++ b/drivers/mtd/nand/raw/pxa3xx_nand.c
> > @@ -800,6 +800,11 @@ static void prepare_start_command(struct pxa3xx_na=
nd_info *info, int command)
> >         info->ecc_err_cnt       =3D 0;
> >         info->ndcb3             =3D 0;
> >         info->need_wait         =3D 0;
> > +       /*
> > +        * Reset max_bitflips to zero. Once command is complete,
> > +        * max_bitflips for this READ is returned in ecc.read_page()
> > +        */
> > +       info->max_bitflips      =3D 0;
> >

Why this should not be put to 0 in read_page instead on prepare_start_comma=
nd?

Michael

> >         switch (command) {
> >         case NAND_CMD_READ0:
> > --
> > 2.17.1

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
