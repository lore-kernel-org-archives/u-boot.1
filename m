Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DC4CA0FF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 08:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B048354B;
	Fri, 29 Aug 2025 10:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LHsCz9QO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388C8835B3; Fri, 29 Aug 2025 10:27:53 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D71883542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 10:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7722e0ca299so263770b3a.1
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1756456069; x=1757060869;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SZai1264xEjInOke0QrHE88Vudvud7xMfN4BWVdYWGw=;
 b=LHsCz9QObX7WsonHlvV6mWmlgEPKw43ugW4mA+6PDFHNS9oGwFvy55CYDX6r8cj9SQ
 xXN8fTzZbKOWFo5KOn867EADinUgQvHokRlF/n79hWyVGVx3/s2LFeHRAKKSNz1Yi6HH
 PQ/a1EZw5KUX08JV3uDL2cuQ7yDbixKl+GgFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756456069; x=1757060869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SZai1264xEjInOke0QrHE88Vudvud7xMfN4BWVdYWGw=;
 b=AXcd0SVrwVOo8N3XU506XYv+eNK8/jxLSzaai6kWBP1oYyQicpllC3rcbGsVMU2Q88
 wbW4ceWVW9Y80Bwu5truEvr0uF2wfnv2GhhsJwFEQUaX9vXJ/T3Vlr+9nzqy/BmJyT+N
 Bgt0t0lYYGHsIHwnO++B+KmsGHJoFxCHnKV6jFmProOGOcBPF9/4lR/g0v16jWukZhfo
 VNTGDCIaw4Tta9xjAIdX88FtQNAflFSPFxwMlE9MtZMuKqcoPO7qXUJw4I5owf/Z5mmX
 f68aYDh/17PMBCDjOGHYmZx5gsDLH3LHEJBQzMowcXrcoOVdqS0iTOYOBc6dIqSPFXYu
 9bSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcHjVD7XR+suvD/ZyPB0WQfQcTwsQt/Fh/Ut3fAvzJRUaJ98a304343Am9V/au7xpd+tqNXPg=@lists.denx.de
X-Gm-Message-State: AOJu0YwZq7zszIQa3hx18sD7ohKQpxGPchik91kgPB9isRBFC7K56GVR
 mL00ynpscxjPXxJj2VsA6ahnCxJSxD1dmz/1nh0qBjOfKQt8R/ZheC/93tqomH5kYk94m+WQV2x
 5ioKDfHZ/bDv5G6klSXVMxETbPwkjIjzipDBQ4FrkpA==
X-Gm-Gg: ASbGncsGPiDxOvBi9Zq7JeVPxQbvYtbTIL3M5Kbc20DaNTIzRsqDAIG8SOQHscNtc+6
 KGL3ZxHsh5Xy0MqFy1cXpewQUfW1ZwTzCRSh4pNLzYEDYjY6wBjIhINajRf80tecDBuJKm8niC8
 jhdxrKZeaP7g80flDJxKEVJAmxa8MWUjcSJNsKujPlxnTahvOrW1U+zbm3McUAPI8qRdFU5ykhY
 GbTYohs/Mx/res0
X-Google-Smtp-Source: AGHT+IHh6hnxoZoyZP6HajVWl6MSGmZVvY4QU5HzXHolJgqPccnid/VdvPTvGZUHfeQZzeFefcROqSnxmRXbFDWWMs0=
X-Received: by 2002:a17:902:f605:b0:248:dec9:4d3c with SMTP id
 d9443c01a7336-248dec95006mr63863145ad.20.1756456068605; Fri, 29 Aug 2025
 01:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250703165841.1230515-1-miquel.raynal@bootlin.com>
 <CAOf5uwnju+Z4bY0Cx0fy05TOLtaQqikq3z51zqDf2nDgCzQyWw@mail.gmail.com>
 <87wm7jjvlr.fsf@bootlin.com>
In-Reply-To: <87wm7jjvlr.fsf@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 29 Aug 2025 10:27:35 +0200
X-Gm-Features: Ac12FXyB6jkWyxJ84vX5GHVvKVG8kmrAvuepNPPLaR7jWJWxHxjobwpUKTKNWMw
Message-ID: <CAOf5uwnZ5QRE+CdAhu33xRwDdygvV4mDRsVn2sZp9ts6SEy_LA@mail.gmail.com>
Subject: Re: [PATCH] cmd: mtd: Enable speed benchmarking
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Steam Lin <stlin2@winbond.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

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

Il lun 4 ago 2025, 11:15 Miquel Raynal <miquel.raynal@bootlin.com> ha
scritto:

> Hello Michael,
>
> >> MA35D1> mtd read nor0 0x81000000 0 0x10000
> >> Reading 65536 byte(s) at offset 0x00000000
> >> MA35D1> mtd read.benchmark nor0 0x81000000 0 0x10000
> >> Reading 65536 byte(s) at offset 0x00000000
> >> Read speed: 3752kiB/s
> >>
> >
> > I was using time and reading but this looked much nicer. I will give it
> a try
> > and review.
>
> Thanks! It turned out very useful for development purposes :-)
>
> >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >> ---
>
> [...]
>
> >> -       bool dump, read, raw, woob, write_empty_pages, has_pages =3D
> false;
> >> +       bool dump, read, raw, woob, benchmark, write_empty_pages,
> has_pages =3D false;
> >>         u64 start_off, off, len, remaining, default_len;
> >>         struct mtd_oob_ops io_op =3D {};
> >>         uint user_addr =3D 0, npages;
> >> +       u32 bench_start, bench_end;
> >
> > unsigned long
>
> Okay.
>
> >>         const char *cmd =3D argv[0];
> >>         struct mtd_info *mtd;
> >>         u32 oob_len;
> >> @@ -490,6 +492,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int
> flag, int argc,
> >>         read =3D dump || !strncmp(cmd, "read", 4);
> >>         raw =3D strstr(cmd, ".raw");
> >>         woob =3D strstr(cmd, ".oob");
> >> +       benchmark =3D strstr(cmd, ".benchmark");
> >>         write_empty_pages =3D !has_pages || strstr(cmd, ".dontskipff")=
;
> >>
> >>         argc -=3D 2;
> >> @@ -559,6 +562,9 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int
> flag, int argc,
> >>
> >>         led_activity_blink();
> >>
> >> +       if (benchmark)
> >> +               bench_start =3D timer_get_us();
> >> +
> >>         /* Loop over the pages to do the actual read/write */
> >>         while (remaining) {
> >>                 /* Skip the block if it is bad */
> >> @@ -586,6 +592,13 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int
> flag, int argc,
> >>                 io_op.oobbuf +=3D io_op.oobretlen;
> >>         }
> >>
> >> +       if (benchmark && bench_start) {
> >> +               bench_end =3D timer_get_us();
> >> +               printf("%s speed: %lukiB/s\n",
> >> +                      read ? "Read" : "Write",
> >> +                      ((io_op.len * 1000000) / (bench_end -
> bench_start)) / 1024);
> >
> > Did you check if it can not wrap?
>
> That is a good question, if my calculations are correct, time capture
> may wrap if one spends more than 1h12 in the Bootloader. So yes it is
> 'doable' to make the time overlap.
>
> But is this relevant? It really is a development feature at the moment
> (developers comparing speeds would notice the overlap) and Bootloaders
> in general are not supposed to run for that long anyway. So I would
> argue that it is acceptable like that.
>

No was not. Because we run 10 seconds test

Michael

>
> Thanks,
> Miqu=C3=A8l
>
