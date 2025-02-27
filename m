Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C987C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 21:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E43AC8164E;
	Thu, 27 Feb 2025 22:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QocU+j05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92EDE81668; Thu, 27 Feb 2025 22:30:08 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32378814B6
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 22:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fea78afde5so1611322a91.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1740691805; x=1741296605;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHfjceIyKJQ+RoC+ayHRXC04kli4PGpK30vo2xxbn9g=;
 b=QocU+j05XjB8dH8bKpIq0taZbI+qwXzsyiNeMG9S1tBA+FPokCh/DeoVTGrQmLk9uH
 /8Z8CKSySOybltZQVe/94PSVSC1c7RshdijTJya+5JrYCg9nkkK24MYv/jQNC+Mo2RWI
 zdoqxLUoDMVU4d59fG8rgAp2CbIMZCgDwtYmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740691805; x=1741296605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHfjceIyKJQ+RoC+ayHRXC04kli4PGpK30vo2xxbn9g=;
 b=vZ+vYxEMHWHeaOvv0C4MVSVOYSkrF+ManNzMB9DY537RvuwuIK/dNATQSiJK6maxAc
 O46K5EDbrf13eYFHwukqFULygYxptbz8ksyazsmW28v3sVu4yimNvtSayTOFBzfLWVtO
 A4VbSK4p1nAxSw7H1tr2/hF7DBRVqPCED66JmO3GkwFoRNLqoj6uZn+UJKhjZTZczfhH
 yGEhj0JVvgRSAGZW2ZEJSemV4kcPQ3+7RLCHOmC2y/WYXokr2x5zM1UqanNT4hslJviJ
 pnyt3JT6QniSaeqCAIBeu1uuMYQijiNcB4MDlbtnE4W77t/OAjct8xOML7cEj9U1wnmL
 wz8g==
X-Gm-Message-State: AOJu0YwPTL3o3+8hwDUbkK2Hap49alyP4HYbUqHmsyo6ZeXpG8eoCaR3
 3JyKlQem4vI5FCScjmevfdAmCN/7yMzQrTt/JJkfuHmIqv/i9+tSGc5lhyLBzTsbUy+KjlkZkI9
 sLojrTCRCMQFfga9Hv7YjeD/RD+DO0xKmlRbe+Q==
X-Gm-Gg: ASbGncuZir5plkNczTiBUOkS8YCC9jTTlMZuu+mO4+xE6ma1qLsYlTFLz/ALWlANTd+
 YQWDYQKlbLa8FTQj1HhA/sbbwxSQI17076swwDSgi2NlyetPu+I1tSxAoOTsGLtiqMjuhO4irBo
 FeW/QxHg==
X-Google-Smtp-Source: AGHT+IHELIemXzVfkAhPgueIPXs2N9hpCopg5hdH3hIZbmb4S6/MR4KFytHiM1+pqvrMC0ckI8KJYADNbR/o4+EpFoE=
X-Received: by 2002:a17:90b:1b09:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-2febac1093dmr1426220a91.33.1740691804638; Thu, 27 Feb 2025
 13:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20250226161833.53689-1-dinesh.maniyam@intel.com>
 <20250226161833.53689-18-dinesh.maniyam@intel.com>
In-Reply-To: <20250226161833.53689-18-dinesh.maniyam@intel.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 27 Feb 2025 22:29:52 +0100
X-Gm-Features: AQ5f1JoOO0podvARMYqrPBeMidaMAaSsZUx_TX9z8yt7oglQbH91SjMHm5HyXDk
Message-ID: <CAOf5uwkKE-W0pPMB50rBs3Fa7Mdh75zU9nYNG2DpNLqjrp=ORQ@mail.gmail.com>
Subject: Re: [resend v3 17/19] drivers: mtd: nand: Enabled Kconfig and
 Makefile for SPL_NAND_FRAMEWORK
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Alexander Dahl <ada@thorsis.com>, William Zhang <william.zhang@broadcom.com>, 
 Igor Prusov <ivprusov@salutedevices.com>,
 Tingting Meng <tingting.meng@intel.com>, 
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>, 
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>, 
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Jit Loon Lim <jit.loon.lim@intel.com>, Sieu Mun Tang <sieu.mun.tang@intel.com>
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

On Wed, Feb 26, 2025 at 5:20=E2=80=AFPM <dinesh.maniyam@intel.com> wrote:
>
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> Enable the Kconfig and Makefile for the SPL_NAND_FRAMEWORK
> support in agilex5 family device. This will include all the basic
> files needed to use the existing nand spl support.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  drivers/mtd/nand/raw/Kconfig  |  7 +++++++
>  drivers/mtd/nand/raw/Makefile | 10 ++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index a9515c7b74..d6ac730224 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -837,4 +837,11 @@ config SYS_NAND_HW_ECC_OOBFIRST
>
>  endif  # if SPL
>
> +config SPL_NAND_FRAMEWORK
> +       bool "Compile the entire NAND framework into the SPL"
> +       help
> +         Some drivers require a lot of functionality from the NAND frame=
work
> +         core when used in SPL. This option allows compiling the full NA=
ND
> +         framework into the SPL instead of it's reduced version.
> +

This seems not relevant for this series and even I don't like the idea
to have it

Michael

>  endif  # if MTD_RAW_NAND
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefil=
e
> index 58fde3272f..0a32e184dc 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -3,8 +3,18 @@
>  # (C) Copyright 2006
>  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>
> +nand-framework-objs :=3D nand.o nand_bbt.o nand_ids.o nand_util.o \
> +                      nand_ecc.o nand_base.o nand_timings.o nand_amd.o \
> +                      nand_hynix.o nand_macronix.o nand_micron.o \
> +                      nand_samsung.o nand_toshiba.o
> +
>  ifdef CONFIG_SPL_BUILD
>
> +ifdef CONFIG_SPL_NAND_FRAMEWORK
> +obj-y +=3D $(nand-framework-objs)
> +NORMAL_DRIVERS=3Dy
> +endif
> +
>  ifdef CONFIG_SPL_NAND_DRIVERS
>  NORMAL_DRIVERS=3Dy
>  endif
> --
> 2.19.0
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
