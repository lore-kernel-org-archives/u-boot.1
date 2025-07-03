Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0598AC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 17:20:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2E280E9A;
	Thu,  3 Jul 2025 19:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZQOcrZkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9775081D5D; Thu,  3 Jul 2025 19:20:00 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 454DE8091A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 19:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b2fca9dc5f8so126196a12.1
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1751563197; x=1752167997;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UIgQqhRZ7HTXjcJ2iMk9KWLAZu07Degy1wUoombKxc=;
 b=ZQOcrZkG8oB+yiW21SGFYy9TN451umDMdl99OI45y5jAEnTxm5CGPz/1ZPRGIw6sx0
 WR+W15982DmWh3ZZ6nx9Pm+Xtc0T9cm3+H5H1fSsaGR3KJHpBoKoPt0zH8bv5RWZq7kG
 0u3mKMVopWF3X1qOaZaMETcthDJ6gp4c82tcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751563197; x=1752167997;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UIgQqhRZ7HTXjcJ2iMk9KWLAZu07Degy1wUoombKxc=;
 b=iXzYr8n8SbmwIgBEp/NpECIaUKpgLinsOuMW+biKIY3jd+w4Gdy6X1yMvp6sAVV7/M
 RUaybWDL0DhqxY7j3KtzsBpT2fIqiwLfg7NWiY9GWZbLqDSdVWweselNfYfUdITiF+/9
 tURNzHO1WCuDn3Vfnmut3cFnDuySBs5E9tsiBvwCUDbdT3/vYkd0kHF17kfeEOjOEbaP
 V9gAPVGyfu+KBl0vRiYgsCTryicOgNaQ3AJRChG9l4eWOmleFr7ef719N3/Fb0Bpo3D3
 2mvRE0nBt77jJQNHLJj3vriDx6KxPIYoW4Nm05wIO/et9LQV+R/Ks3WOJRnY0lj7Iruf
 TEGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO95cu4JsLVIpg1Vsq7BSmP4kyrlUJsRf2ObacXQmnNOfNoWBQBXFRDv6V/Y2fzJuzm/+lJOk=@lists.denx.de
X-Gm-Message-State: AOJu0YztkSoPALwQpDdGqMm1A+6SqwI4e1JwxFcFoy+cWqcjBuSrei6h
 z9rEtDYFqdflDbj/phqsrcJfY7wwnNeg2qLSxUkiZYRrS5zkYfJnu+9rmV/0gRe0u9IvxjI4KpH
 EaeJ8zxBqpgwwHTCXHSytUfaFXhXIceIJFskEFLJYLA==
X-Gm-Gg: ASbGncsDcapU4nJ6nJtrrVenA9xVn5nZYOfaSY2z3w3jCarg/EsQaxKhEVuYIWmKWUB
 L2JJ7G05T6xMGll0iDbfhivRdFPKCrmuk/u1dFDjxNw3tWg0V+SXrRoTyNBll2UrnXgPJiPJMCn
 LY//YhT/ARgiJqPjDmOqblKxb7IunVgemb5ekEHNeLEnE5F5XYvffLeGNJJ6MUNS6dqxxj3lPKB
 Km4
X-Google-Smtp-Source: AGHT+IEEpo2cNrPXgbStXVUpk2InM/3mVIhkFErX47mrL04nKhxnm6RmP5qoQUQtn3CPvVyZTP5+tC6ZDqeWpo2jfA8=
X-Received: by 2002:a17:90b:384b:b0:313:271a:af56 with SMTP id
 98e67ed59e1d1-31a9d64dd41mr4666156a91.30.1751563196472; Thu, 03 Jul 2025
 10:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250703165841.1230515-1-miquel.raynal@bootlin.com>
In-Reply-To: <20250703165841.1230515-1-miquel.raynal@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 3 Jul 2025 19:19:45 +0200
X-Gm-Features: Ac12FXzGVpSQlZw3b9FrcCXnqhQn4QGOpkBLe5OBL5j7HjfL9IlODeJnRa-JqqQ
Message-ID: <CAOf5uwnju+Z4bY0Cx0fy05TOLtaQqikq3z51zqDf2nDgCzQyWw@mail.gmail.com>
Subject: Re: [PATCH] cmd: mtd: Enable speed benchmarking
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Steam Lin <stlin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

Hi Miquel

On Thu, Jul 3, 2025 at 6:58=E2=80=AFPM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Linux features a flash_speed speed test from the mtd-utils suite, U-Boot
> does not. Benchmarks are useful for speed improvement developments as
> well as troubleshooting or regression testing sometimes.
>
> Enable a benchmark option to enable this feature.
>
> Example of output on a Nuvoton platform:
>
> MA35D1> mtd read nor0 0x81000000 0 0x10000
> Reading 65536 byte(s) at offset 0x00000000
> MA35D1> mtd read.benchmark nor0 0x81000000 0 0x10000
> Reading 65536 byte(s) at offset 0x00000000
> Read speed: 3752kiB/s
>

I was using time and reading but this looked much nicer. I will give it a t=
ry
and review.


> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  cmd/mtd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index c25997cfb246..d5843db663d7 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -17,6 +17,7 @@
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <mtd.h>
> +#include <time.h>
>  #include <dm/devres.h>
>  #include <linux/err.h>
>
> @@ -466,10 +467,11 @@ static int mtd_special_write_oob(struct mtd_info *m=
td, u64 off,
>  static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
>                      char *const argv[])
>  {
> -       bool dump, read, raw, woob, write_empty_pages, has_pages =3D fals=
e;
> +       bool dump, read, raw, woob, benchmark, write_empty_pages, has_pag=
es =3D false;
>         u64 start_off, off, len, remaining, default_len;
>         struct mtd_oob_ops io_op =3D {};
>         uint user_addr =3D 0, npages;
> +       u32 bench_start, bench_end;

unsigned long

>         const char *cmd =3D argv[0];
>         struct mtd_info *mtd;
>         u32 oob_len;
> @@ -490,6 +492,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>         read =3D dump || !strncmp(cmd, "read", 4);
>         raw =3D strstr(cmd, ".raw");
>         woob =3D strstr(cmd, ".oob");
> +       benchmark =3D strstr(cmd, ".benchmark");
>         write_empty_pages =3D !has_pages || strstr(cmd, ".dontskipff");
>
>         argc -=3D 2;
> @@ -559,6 +562,9 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag,=
 int argc,
>
>         led_activity_blink();
>
> +       if (benchmark)
> +               bench_start =3D timer_get_us();
> +
>         /* Loop over the pages to do the actual read/write */
>         while (remaining) {
>                 /* Skip the block if it is bad */
> @@ -586,6 +592,13 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
, int argc,
>                 io_op.oobbuf +=3D io_op.oobretlen;
>         }
>
> +       if (benchmark && bench_start) {
> +               bench_end =3D timer_get_us();
> +               printf("%s speed: %lukiB/s\n",
> +                      read ? "Read" : "Write",
> +                      ((io_op.len * 1000000) / (bench_end - bench_start)=
) / 1024);

Did you check if it can not wrap?

Michael

> +       }
> +
>         led_activity_off();
>
>         if (!ret && dump)
> --
> 2.49.0
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
