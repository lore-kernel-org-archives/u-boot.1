Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFA6CA0EFC
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 10:38:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46741828A2;
	Sun, 24 Aug 2025 12:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PTEQpqRh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE46F82DA1; Sun, 24 Aug 2025 12:38:06 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3730800C1
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 12:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-32326e67c95so3805612a91.3
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1756031882; x=1756636682;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9JS6lPobsOorp9rmOzkb/yKoYBSKoqx/mv4lY5/TKGY=;
 b=PTEQpqRh3P3MOO1BlPdVEC6ijoYfOqkhvg8oorOMk/tp2RtnQgwor1y9/ISeFWPlUR
 QRempYTd192vjosVA376753QV4LiCDkIH4gK6iBT43UIwwkmePNJZByWsXFl13VBRYxp
 mHTYd3OyIEIgpLWScOWGEDyBy6Qkny4vWG9Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756031882; x=1756636682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9JS6lPobsOorp9rmOzkb/yKoYBSKoqx/mv4lY5/TKGY=;
 b=pO7aLYvYc2E9dMPCm9MZRd5zK4ba6q4RJzThbjiylZ+MhCL0f3KeByQfOYkXYcORXB
 pr1Ptwlz/hy0HQ+MjjrIQAnxBu+TUcqbWZeGy38q/B4e9wJU4PeLcX5zv/RFYvz++tUp
 JbeDfIZyftULtDnA/Omw+oUQnnht2I/tBbSSQ5hTtCPZ1Fe254OIQDlyDZBsQx5LmyPD
 MvFPgqQ7EjCgK2XF+Wa97+fWglmLeu5om/pkCbTrwzFg5qNG2i1wr1JxRU2cI8p/DOXm
 HcGcFqodz8GW5sKcEKxvHmAEzyYw/3aab06lImfYIuaQe37BiwPvucl27YCxJtn/4UWB
 KJcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMRr/xSsXRjzJ9UWNqojC67ahbC00h2BHqdn5RyVJG00T5U4nMnUwweKKDnR+8wNWZBJLjZ/c=@lists.denx.de
X-Gm-Message-State: AOJu0YzOXGg3xs9CitzG+lcHIIEH9fogsAAFy9ezWg5rVnPqolKvUt+k
 ZO6dfEywoTSEzDouTlD8SnWN+59ycCxAKCvTCsBpp+BcXQ4vx8r6NP99y5ZE4B0UnXllYnhossx
 gW2Se35MCAwTHfjzf3dA1d4P7Az7nLNxT9s6f+jdk0A==
X-Gm-Gg: ASbGncvM1kr2IfHjR542ybGXpaypYp8CaTraw75SvmIjcuUMYYSf034wS5bT7uUHrIV
 2WoFU4TsFYClPR4xxAPJN3k6DupmR8OBFpemQN2MjSoPJFgtLan/5ba1mhZTTGLw4XkM7M+fqHJ
 KyWMJrPnfgmb+XP2/Z5WEWEYouTZvspn6vEXpb5Uu5DgRIK8XDjgsUeDfNp5qlnDXTVqbcSipO3
 X2qfWs=
X-Google-Smtp-Source: AGHT+IFzFyeihHJAN/51o4tbOm7qF9uxZCThkOqlKTJp3L1RX2CjdVjpVM2DvhumrFeCacls5qpb2DnzUaQMVbtEaWw=
X-Received: by 2002:a17:90b:1642:b0:31f:2ef4:bc04 with SMTP id
 98e67ed59e1d1-32515e4f2d2mr11351320a91.14.1756031882365; Sun, 24 Aug 2025
 03:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250804092137.404647-1-miquel.raynal@bootlin.com>
 <CAOf5uw=DzXH1g4=hVzSbQrjy12zuNO1p9N+UUZYrOi2xkowRdg@mail.gmail.com>
In-Reply-To: <CAOf5uw=DzXH1g4=hVzSbQrjy12zuNO1p9N+UUZYrOi2xkowRdg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 24 Aug 2025 12:37:49 +0200
X-Gm-Features: Ac12FXyXj8rWzXOc2Q9DNj80BuFbxFJ_UXbkX5-gMWEuYKhuuGrV6yOlhH6MJ2A
Message-ID: <CAOf5uwno76aLnFEUaiE69cjd+8TjFNseaboVxjBWTySJKnVqoA@mail.gmail.com>
Subject: Re: [PATCH v2] cmd: mtd: Enable speed benchmarking
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de, 
 Steam Lin <stlin2@winbond.com>
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

On Mon, Aug 4, 2025 at 11:22=E2=80=AFAM Michael Nazzareno Trimarchi <
michael@amarulasolutions.com> wrote:

> Hi
>
> On Mon, Aug 4, 2025 at 11:21=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com>
> wrote:
>
>> Linux features a flash_speed speed test from the mtd-utils suite, U-Boot
>> does not. Benchmarks are useful for speed improvement developments as
>> well as troubleshooting or regression testing sometimes.
>>
>> Enable a benchmark option to enable this feature.
>>
>> Example of output on a Nuvoton platform:
>>
>> MA35D1> mtd read nor0 0x81000000 0 0x10000
>> Reading 65536 byte(s) at offset 0x00000000
>> MA35D1> mtd read.benchmark nor0 0x81000000 0 0x10000
>> Reading 65536 byte(s) at offset 0x00000000
>> Read speed: 3752kiB/s
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>> Changes in v2:
>> * Use an unsigned long as advised by Michael for accounting time.
>> ---
>>  cmd/mtd.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/cmd/mtd.c b/cmd/mtd.c
>> index c25997cfb246..2520b89eed2c 100644
>> --- a/cmd/mtd.c
>> +++ b/cmd/mtd.c
>> @@ -17,6 +17,7 @@
>>  #include <malloc.h>
>>  #include <mapmem.h>
>>  #include <mtd.h>
>> +#include <time.h>
>>  #include <dm/devres.h>
>>  #include <linux/err.h>
>>
>> @@ -466,8 +467,9 @@ static int mtd_special_write_oob(struct mtd_info
>> *mtd, u64 off,
>>  static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
>>                      char *const argv[])
>>  {
>> -       bool dump, read, raw, woob, write_empty_pages, has_pages =3D fal=
se;
>> +       bool dump, read, raw, woob, benchmark, write_empty_pages,
>> has_pages =3D false;
>>         u64 start_off, off, len, remaining, default_len;
>> +       unsigned long bench_start, bench_end;
>>         struct mtd_oob_ops io_op =3D {};
>>         uint user_addr =3D 0, npages;
>>         const char *cmd =3D argv[0];
>> @@ -490,6 +492,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
,
>> int argc,
>>         read =3D dump || !strncmp(cmd, "read", 4);
>>         raw =3D strstr(cmd, ".raw");
>>         woob =3D strstr(cmd, ".oob");
>> +       benchmark =3D strstr(cmd, ".benchmark");
>>         write_empty_pages =3D !has_pages || strstr(cmd, ".dontskipff");
>>
>>         argc -=3D 2;
>> @@ -559,6 +562,9 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag=
,
>> int argc,
>>
>>         led_activity_blink();
>>
>> +       if (benchmark)
>> +               bench_start =3D timer_get_us();
>> +
>>         /* Loop over the pages to do the actual read/write */
>>         while (remaining) {
>>                 /* Skip the block if it is bad */
>> @@ -586,6 +592,13 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int
>> flag, int argc,
>>                 io_op.oobbuf +=3D io_op.oobretlen;
>>         }
>>
>> +       if (benchmark && bench_start) {
>> +               bench_end =3D timer_get_us();
>> +               printf("%s speed: %lukiB/s\n",
>> +                      read ? "Read" : "Write",
>> +                      ((io_op.len * 1000000) / (bench_end -
>> bench_start)) / 1024);
>> +       }
>> +
>>
>
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
>
>
>>         led_activity_off();
>>
>>         if (!ret && dump)
>> --
>> 2.50.1
>>
>>
>
>
Applied thanks

Michael

> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
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
