Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E6DCA0FE7
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 14:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92B0830A0;
	Tue, 26 Aug 2025 16:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HQGyA4JQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773FC830CA; Tue, 26 Aug 2025 16:32:28 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4102828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 16:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b47174aec0eso3718651a12.2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1756218744; x=1756823544;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eakLp62EOhsQ66M6ueEDVjVsk+HYT5Za+irjQ8MNOOI=;
 b=HQGyA4JQNmcibX3nr14o5x8NEQ5mbYdoXvdal64oMmsSB8BxlMPvREetBePEK+6XZr
 WP4l7fFvG+IgOMqyRdO+oZ+zzdT0TuYpd4r34AL8N6rmcITx18pRj2ZaV+DJxksEb8+E
 U7bnZiEoKoLi2fsF5CsnQofIJ3rBtzIDxEkLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756218744; x=1756823544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eakLp62EOhsQ66M6ueEDVjVsk+HYT5Za+irjQ8MNOOI=;
 b=sIX+ftYIEvXHEKzto14FouuDtyDKx5fpg0qs3BUsz/EYfMlNSxsAjk8jDBOzgD8WKt
 nxWgMW+NCO7083DOKrsvWaLL59PlcPcmajGxMuCgZYI0++ctXA5hj5QbkqnuAuv1P8II
 VSGuneWQBIZnsynfvq6AHHfe8fwzMf6kEXzfk6WIY1GILN7emlFqb1r4l/wSrBOkUqxu
 ogGQcyuBDg/KIT4np1enculL05NhP+OtNtFld7LQvhI92yeMHqI+q0P7/LpKmS7YNcOp
 YmG3M+ujLNoHDID7P1oEdKJcE7ZKTwWGzM5xNwbtqdS7Xr8fWKV3xfjyWsHs9kMjlLIa
 RUdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdXo2Cp4mXXLVa3sjCn470+2Z+uDUPJtocMI6zmK5ZupD9q5R/trGN67EmdpDqnvaMIryNCaM=@lists.denx.de
X-Gm-Message-State: AOJu0YzVIgDi9FwhaqfUwe7Vz5vutlpGF+O+ISePC5W/XE0gxGzvm7a8
 MQ9gT3lqwdcK2YPGPTTloadFFQwStXm5Iuzir+7GpQ67nZ0Cpr5LI4vR5ghzSeiR4lbRItkTXz1
 hW//8byyMepbNurt5MnZv3EprHokiXILcrCJIsBS2Qg==
X-Gm-Gg: ASbGncu6RWUby07HWk5GqBRDPEMhsUYF1zEv5z0uLsllYNMI0QQ1fA5EyYtebrpD6DV
 /Ud4VWGg3sOtadng0EnCJjWFvuUARNELUdzVgbtcDIBvlaLY4HF77WO4yJ7DB/3EytHe/LJxv66
 5rjDjNgVTzs6cg6/Qkep/lSjo42W+25OBW/Xo8EvnQ4nynn65FrjS/5CNGJ4GZHjmSoo2p28UEe
 iRf0lJHEA==
X-Google-Smtp-Source: AGHT+IHIAAlgjuHj0gIhar0CQEkcOHRqCfn12z6qdv/Gxxw93fflDUJpUj6Q4C282/TV6uqEv2koJ1AtR4QJtg4qMtQ=
X-Received: by 2002:a17:903:2286:b0:248:75da:f791 with SMTP id
 d9443c01a7336-24875dafd03mr24240255ad.47.1756218744096; Tue, 26 Aug 2025
 07:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250825234829.155483-1-mikhail.kshevetskiy@iopsys.eu>
 <87h5xu2mcg.fsf@bootlin.com>
In-Reply-To: <87h5xu2mcg.fsf@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 26 Aug 2025 16:32:12 +0200
X-Gm-Features: Ac12FXz1Y0S5t-8o7MUgH78gnjK7dqai5L4hbTZVIJHqvNO7SoyEpmcBjs0-WBc
Message-ID: <CAOf5uwkOfGUmB9sfTuTBBVkuub9Ag1ahG5Si1XWuftPxc+_ZRQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: mtd: fix speed measurement in the speed benchmark
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
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

On Tue, Aug 26, 2025 at 4:23=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com>
wrote:

> Hello Mikhail,
>
> On 26/08/2025 at 02:48:29 +03, Mikhail Kshevetskiy <
> mikhail.kshevetskiy@iopsys.eu> wrote:
>
> > The shown speed inverse linearly depends on size of data.
> > See the output:
> >
> >   spi-nand: spi_nand nand@0: Micron SPI NAND was found.
> >   spi-nand: spi_nand nand@0: 256 MiB, block size: 128 KiB, page size:
> 2048, OOB size: 128
> >   ...
> >   =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x40000
> >   Reading 262144 byte(s) (128 page(s)) at offset 0x00000000
> >   Read speed: 63kiB/s
> >   =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x20000
> >   Reading 131072 byte(s) (64 page(s)) at offset 0x00000000
> >   Read speed: 127kiB/s
> >   =3D> mtd read.benchmark spi-nand0 $loadaddr 0 0x10000
> >   Reading 65536 byte(s) (32 page(s)) at offset 0x00000000
> >   Read speed: 254kiB/s
> >
> > In the spi-nand case 'io_op.len' is not the same as 'len',
> > thus we divide a size of the single block on total time.
> > This is wrong, we should divide on the time for a single
> > block.
> >
> > Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>
>
Add a fixes with commit reference, when you post v2 and address al the
other comments

Michael


> Happy to see this is useful :-) But you're totally right, it didn't use
> the correct length. Maybe I would rephrase a bit the last two sentences
> to make the commit clearer:
>
> "In the spi-nand case 'io_op.len' is not always the same as 'len', thus
> we are using the wrong amount of data to derive the speed."
>
> However, regarding the diff,
>
> > @@ -594,9 +594,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int
> flag, int argc,
> >
> >       if (benchmark && bench_start) {
> >               bench_end =3D timer_get_us();
> > +             block_time =3D (bench_end - bench_start) / (len / io_op.l=
en);
> >               printf("%s speed: %lukiB/s\n",
> >                      read ? "Read" : "Write",
> > -                    ((io_op.len * 1000000) / (bench_end - bench_start)=
)
> / 1024);
> > +                    ((io_op.len * 1000000) / block_time) / 1024);
>
> Why not just dividing the length by the benchmark time instead of
> reducing and rounding the denominator in the first place, which I
> believe makes the final result less precise?
>
> Thanks,
> Miqu=C3=A8l
>


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
