Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57321CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E396A8319C;
	Mon, 29 Sep 2025 08:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PhGxvUoZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C27E68323A; Mon, 29 Sep 2025 08:54:44 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7BC8317B
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 08:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-269af38418aso54774945ad.1
 for <u-boot@lists.denx.de>; Sun, 28 Sep 2025 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1759128881; x=1759733681;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpXcJhNbwMK//wUjgZHgJ8yOICdPrBvtuoeJfG6PSrs=;
 b=PhGxvUoZGK6yOeO6bQbyIpgi2H6HWwwmB3hQaN3Y+YxSY3B2v7QFd3kxF8GJoShrZB
 5hIXwOaSonyoCNl5cdHfDZU2ePTCiQrvK1op4lGzRgmcjoY8YpsDP0WZ8Q+y5oFhfPrR
 8AwoswMaAi/T/tZgoPo40+PMpY5KneuUyhb08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759128881; x=1759733681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CpXcJhNbwMK//wUjgZHgJ8yOICdPrBvtuoeJfG6PSrs=;
 b=WmUKD9QL8Zb4n3lgaitqPqMZ7GQ9dOhpR3rzqyvSJ7ZDCUCMMR35vJmhwmlvqtpBmj
 nSNbefG14e35vd4BZJDvm6QEuJNnrtymPPK/8YCe2KmT0hhX5OjXeCOL6DevpAfhmBAW
 xTlW3r4X5tVVnOEnhUiYA0Pq36BSQ8FgshXhCuwfoR7nsLtA8VAicdHc1BL1+jD6+MpM
 lmlEaWiC/nE3upGBjMkk3j1MTOIgDh0Q2dThW4lNVZUsGle9FWaOPUqe2xiovELOa43K
 aBxzi4FngrqmdhLW7fgm9e0vh5Z/f7/lLL68nAht/Hq+DJfjFytiSFNnatxZ7XvOD8Jx
 TGFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV94agLh5gmAo737govXr7stD1KCE3jzPxXUJ1y7S6afBMr14RqH2Td/GgOpptCI0M46J7EjQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyhgoAawD0yPyzaBAdCbPiqFieN+XjIDAv2sha2UPogZYP65fgS
 ApMonFk71JcuDnjEitYZQioABZLr8ZXYqGEs98ElrWzKMv/pDe54U+BbKmHWTaMCAWAYxUZVzfY
 3QVB82AbM7a8nUFApqHiVAqS2xF0iiQHwv3UcoCanIQ==
X-Gm-Gg: ASbGncsf9+iJ53F3+cWflJOAfgEKKG0LP8xC/BI93HIVeG6GzOJ2W57qTj7Hk+DOywC
 izJJcA1VivmwpFmoykRveZDvlcS1StVgTCu+OG7ZCLX83Lr5auvbAkZP5fa8pcsjCdcgPgudU3A
 EmMCyguU12+lS2ZATQutpsOGATFPPaTVRtJV3J/A3V/CHONtW3z5QCZM8oJbHrDYAYe6v3kEedg
 bU8
X-Google-Smtp-Source: AGHT+IEKoT1klhcdmmXMWtHmmxR5zVR6IpxBvaR2EYvH32FRu+8H4x2uzQb9ls/Q2C4Hh+uzqk7bNmg3SGNdXGBMgcU=
X-Received: by 2002:a17:902:e80b:b0:267:d0fa:5f75 with SMTP id
 d9443c01a7336-27ed49df282mr195158405ad.1.1759128880726; Sun, 28 Sep 2025
 23:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250924042033.1873771-1-mikhail.kshevetskiy@iopsys.eu>
 <20250924042033.1873771-2-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20250924042033.1873771-2-mikhail.kshevetskiy@iopsys.eu>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 29 Sep 2025 08:54:29 +0200
X-Gm-Features: AS18NWDXBRlVLiHWuVeaEmk8S1A0qlhClQgj_lzsVIX9_pMa860LN3HF0US4ToY
Message-ID: <CAOf5uwmiVLuKk+9mV_brY-MTxnTrcV6-pXLFtH+ZtbYFZ009Mw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/3] cmd: mtd: add markbad command support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de, 
 Andreas Gnau <andreas.gnau@iopsys.eu>
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

Hi

I will pick the series shortly

Michael

On Wed, Sep 24, 2025 at 6:20=E2=80=AFAM Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> Some nand flashes (like spi-nand one) are registered with mtd
> subsystem only, thus nand command can't be used to work with
> such flashes. As result some functionality is missing.
>
> This patch implements 'nand markbad' functionality for mtd command.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  cmd/Kconfig |  8 ++++++++
>  cmd/mtd.c   | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 29de857ba7c..8f2a35d780b 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1511,6 +1511,14 @@ config CMD_MTD_OTP
>         help
>           MTD commands for OTP access.
>
> +config CMD_MTD_MARKBAD
> +       bool "mtd markbad"
> +       depends on CMD_MTD
> +       help
> +         MTD markbad command support.
> +
> +         This is a clone of "nand markbad" command, but for 'mtd' subsys=
tem.
> +
>  config CMD_MUX
>         bool "mux"
>         depends on MULTIPLEXER
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 2520b89eed2..95e4be9863d 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c
> @@ -711,6 +711,57 @@ out_put_mtd:
>         return ret;
>  }
>
> +#ifdef CONFIG_CMD_MTD_MARKBAD
> +static int do_mtd_markbad(struct cmd_tbl *cmdtp, int flag, int argc,
> +                         char *const argv[])
> +{
> +       struct mtd_info *mtd;
> +       loff_t off;
> +       int ret =3D 0;
> +
> +       if (argc < 3)
> +               return CMD_RET_USAGE;
> +
> +       mtd =3D get_mtd_by_name(argv[1]);
> +       if (IS_ERR_OR_NULL(mtd))
> +               return CMD_RET_FAILURE;
> +
> +       if (!mtd_can_have_bb(mtd)) {
> +               printf("Only NAND-based devices can have bad blocks\n");
> +               goto out_put_mtd;
> +       }
> +
> +       argc -=3D 2;
> +       argv +=3D 2;
> +       while (argc > 0) {
> +               off =3D hextoul(argv[0], NULL);
> +               if (!mtd_is_aligned_with_block_size(mtd, off)) {
> +                       printf("Offset not aligned with a block (0x%x)\n"=
,
> +                              mtd->erasesize);
> +                       ret =3D CMD_RET_FAILURE;
> +                       goto out_put_mtd;
> +               }
> +
> +               ret =3D mtd_block_markbad(mtd, off);
> +               if (ret) {
> +                       printf("block 0x%08llx NOT marked as bad! ERROR %=
d\n",
> +                              off, ret);
> +                       ret =3D CMD_RET_FAILURE;
> +               } else {
> +                       printf("block 0x%08llx successfully marked as bad=
\n",
> +                              off);
> +               }
> +               --argc;
> +               ++argv;
> +       }
> +
> +out_put_mtd:
> +       put_mtd_device(mtd);
> +
> +       return ret;
> +}
> +#endif
> +
>  static int do_mtd_bad(struct cmd_tbl *cmdtp, int flag, int argc,
>                       char *const argv[])
>  {
> @@ -793,6 +844,9 @@ U_BOOT_LONGHELP(mtd,
>         "mtd otpwrite                          <name> <off> <hex string>\=
n"
>         "mtd otplock                           <name> <off> <size>\n"
>         "mtd otpinfo                           <name> [u|f]\n"
> +#endif
> +#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
> +       "mtd markbad                           <name>         <off> [<off=
> ...]\n"
>  #endif
>         "\n"
>         "With:\n"
> @@ -827,5 +881,9 @@ U_BOOT_CMD_WITH_SUBCMDS(mtd, "MTD utils", mtd_help_te=
xt,
>                                              mtd_name_complete),
>                 U_BOOT_SUBCMD_MKENT_COMPLETE(erase, 4, 0, do_mtd_erase,
>                                              mtd_name_complete),
> +#if CONFIG_IS_ENABLED(CMD_MTD_MARKBAD)
> +               U_BOOT_SUBCMD_MKENT_COMPLETE(markbad, 20, 0, do_mtd_markb=
ad,
> +                                            mtd_name_complete),
> +#endif
>                 U_BOOT_SUBCMD_MKENT_COMPLETE(bad, 2, 1, do_mtd_bad,
>                                              mtd_name_complete));
> --
> 2.51.0
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
