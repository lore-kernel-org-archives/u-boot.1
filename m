Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7E6C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 09:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F22EB83DF7;
	Mon,  4 Aug 2025 11:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rccJSZlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4035583EC9; Mon,  4 Aug 2025 11:22:44 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE8983DC9
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 11:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2400f746440so32171015ad.2
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754299359; x=1754904159;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gAeCGr/5+2zQMZVY75EIxtGwTI0mpQK/E7flT6Hicrs=;
 b=rccJSZlEphcakBdkRbUdYMGbPT979CyU2C3L0g8JjEKALI5GP+kdVcK8wqQHPGJJYQ
 f+o1gb45qgZgvOCWRWcDO+DDkvO8s7Y3AVSiw2dqZKAst1jU1T3ImP8wtZxW6AwkQlTI
 lpRi8XpWVXoIz1UJomWitrPNdkWtJXFABDlFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754299359; x=1754904159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gAeCGr/5+2zQMZVY75EIxtGwTI0mpQK/E7flT6Hicrs=;
 b=sZui3/MfKYOlndg2l6FXHC4B6o0IHxPX7nTDIPprtb5mWD5bhxn1s5rQ4kEo1ysoTR
 J0gEB5d3yZm7ly1d3T0UM1pJRIwuZA2P1DreyjeuvkH7TmK/Piw9hnzqr2Wix5G4aKxW
 VvtoPUJswkoXH+QOfsHUYaMp4dOFidm2meAK8ctmZcQafjHYWJdEJkowh/GFQzTOKny2
 jwKkOTjBlGFcMybKiNxn+DL2ki5j+5zbX7hxtW08451pH+ySIbn5ZBdz0wXPA8ZVrARM
 cutoB0rafmoKuZUqGZbeNB597Xk/cSErRsH4SODu3A8dGEUbx4f2HhMlzk+tglCm1AFj
 Rh/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVUZQQEZ0JyWCU+B91MQ+wkphvcQKOUU9WHu+cB7fPGPILP9yAvhoCS11jP6vc2hNh3mlXmuc=@lists.denx.de
X-Gm-Message-State: AOJu0YyFPxVuaC5x3brFvy7FH+4IPHZr7/Agm4cV5azd4D/TIXtlfoHL
 xdmHBQAHcvV9+U73Q6dSNaZtpEsE1MHYv2bVT6/QA2dacjv5LAfhQrrtXYMS92k25AGJ5ZeBioR
 779y/loZKRXvNDM0NWwPgBrvt+/xjyDK7YjNA4qAMAA==
X-Gm-Gg: ASbGncs33ffDtS4746yQld0oE/piywALGsL7PsnPSEyL893gx5nSmcXKl1h+dzZC6/1
 5ttw0ZcAE7PDsL/z7bZqf5PsqkGadwflrwIgfmSTo/ZOMied5Xun+6/BfpzAcYeAJj6S5/xQObH
 wJ81hSODvpIO0hnN7eNgEFZrs3oeT/WPl+bguN50RBy4ATy/NxHU4TgzMwS74Q4DaUJ5TbJ5GdT
 oLH3eeg
X-Google-Smtp-Source: AGHT+IHyxkvKq9WNTsAH8Y8lZ8kYgns7WvzzHchIYnKDlKXOdcV0rzxhe/nkrF2Fmzh7M0ncM3eTZeoqawisrisHRik=
X-Received: by 2002:a17:902:f693:b0:240:41a3:c18a with SMTP id
 d9443c01a7336-24246f562a2mr113565905ad.6.1754299359242; Mon, 04 Aug 2025
 02:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250804092137.404647-1-miquel.raynal@bootlin.com>
In-Reply-To: <20250804092137.404647-1-miquel.raynal@bootlin.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 4 Aug 2025 11:22:27 +0200
X-Gm-Features: Ac12FXxElRLYOBmR3Z3KW7_PmZ4utvXBCzmh6TQmK_CtNh5UMBptZ7oSZQxmvPI
Message-ID: <CAOf5uw=DzXH1g4=hVzSbQrjy12zuNO1p9N+UUZYrOi2xkowRdg@mail.gmail.com>
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

On Mon, Aug 4, 2025 at 11:21=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com>
wrote:

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
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Changes in v2:
> * Use an unsigned long as advised by Michael for accounting time.
> ---
>  cmd/mtd.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index c25997cfb246..2520b89eed2c 100644
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
> @@ -466,8 +467,9 @@ static int mtd_special_write_oob(struct mtd_info *mtd=
,
> u64 off,
>  static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
>                      char *const argv[])
>  {
> -       bool dump, read, raw, woob, write_empty_pages, has_pages =3D fals=
e;
> +       bool dump, read, raw, woob, benchmark, write_empty_pages,
> has_pages =3D false;
>         u64 start_off, off, len, remaining, default_len;
> +       unsigned long bench_start, bench_end;
>         struct mtd_oob_ops io_op =3D {};
>         uint user_addr =3D 0, npages;
>         const char *cmd =3D argv[0];
> @@ -490,6 +492,7 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag,
> int argc,
>         read =3D dump || !strncmp(cmd, "read", 4);
>         raw =3D strstr(cmd, ".raw");
>         woob =3D strstr(cmd, ".oob");
> +       benchmark =3D strstr(cmd, ".benchmark");
>         write_empty_pages =3D !has_pages || strstr(cmd, ".dontskipff");
>
>         argc -=3D 2;
> @@ -559,6 +562,9 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag,
> int argc,
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
,
> int argc,
>                 io_op.oobbuf +=3D io_op.oobretlen;
>         }
>
> +       if (benchmark && bench_start) {
> +               bench_end =3D timer_get_us();
> +               printf("%s speed: %lukiB/s\n",
> +                      read ? "Read" : "Write",
> +                      ((io_op.len * 1000000) / (bench_end - bench_start)=
)
> / 1024);
> +       }
> +
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>


>         led_activity_off();
>
>         if (!ret && dump)
> --
> 2.50.1
>
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
