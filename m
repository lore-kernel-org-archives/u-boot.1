Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDC2C2D0CD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 20:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D05CE808AF;
	Sat, 17 May 2025 22:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V+mj+cA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2222880FA8; Sat, 17 May 2025 22:44:35 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E568004F
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 22:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso2557083a12.1
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 13:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747514671; x=1748119471;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5mHDn4UxGK1rdyD+gf9I0EBCD5OSJKYLI+XOk4ufYQ=;
 b=V+mj+cA6nWclgrvmEkhEBPrHlZN0KIUB/Wj51+y3NP/IzcNzxepR9VoBrWrl2y7nUt
 VHBMKkiifFpA+nIpv6VQJEUEb6jNpWZ1KkL7Q0kihQ8Unff22thEj0c4qzBaT8MOgb4N
 CrYz4xYyVLgHTThMN2Bm+l9EXTBggDQPRDVtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747514671; x=1748119471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f5mHDn4UxGK1rdyD+gf9I0EBCD5OSJKYLI+XOk4ufYQ=;
 b=sH+T5ZibgTWiQCNxrBZR0euEsIfjd8Ak4MGizrqDQvA/1nZJIKLkWq693hrI7m9qzv
 p4VtM67oCCkjLVkGrnxqIpAo0yG81+/AWQEoC393XBeVB0JYBXoFjObVmGXu7bhyKwQc
 4whWCx5KUkPJRNH2kNF90mP+TN5r2iOENuyR/2BqYp7oNvuNkqBrXKJx1AqpXs43QzJ4
 WkIA9E73sYDZ+QvlMzFmRmQpnJMfScebDGiva817hIzWdWc2kD3ZEEVn7l2H9N8zIFOP
 SlwauRYCiM+yKxi48k4l3d7Zi9RmrNnvpjO2XvNGpl49H6hr+Kfo2E1BT4V0/vybMVLN
 9CQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOS2ygYvWgT22MRXNdNf4McWLPjNGsS9vwoBHxx9fhmk+vyeNUmf2m5giapJquvk5ZL+5yi3k=@lists.denx.de
X-Gm-Message-State: AOJu0YwxUJplkxMlHH72po75ozgFKKSkjg3u5Y96rp7mdcpYPRI4DuoK
 2fY8llAVdGGty5FFTk+V6k6PzewVO7u6JARAolR3Zv6ijfp9lmrDzxUE8UANLei6zI78fp4azJN
 Lbc8oSdUhvaC47A4HtEE06YogPs7pj+Svj3hfVe6KDg==
X-Gm-Gg: ASbGncscFP3AHjIk3Ds0kFidOeaQMEKNT0cACKLRYp7kkak88g2mj3CRHTEYwIXnlw8
 yqo8z1CmoNX3SvBr617gbTM0e4Eayh+R6LH91AIuhcRCsGwOdGUUu/pansh3RfGVPbYTAbv62gi
 NFYcjpZ91oCJFB2qJN8cbvjC9WU4hQOw==
X-Google-Smtp-Source: AGHT+IEyr9HHlSg0RRklOrh/L3iXjQHfuRclHM3FFYlrIWzt0S2FvAyfVHgUg5rxnfHPerwgNh0typPf27t4aAescT0=
X-Received: by 2002:a17:903:2ac4:b0:220:ff82:1c60 with SMTP id
 d9443c01a7336-231b3987551mr193209415ad.14.1747514671279; Sat, 17 May 2025
 13:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
 <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
 <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
 <CAOMZO5Ac3NdTu=rWJ4e=YR5t=ck+qbNbf9SH3zikUghqMineMQ@mail.gmail.com>
 <CAOf5uwnfC0nLBy1QhcDe_VpqE9LGh5fKV_Br4_=rZxMBNHw1ww@mail.gmail.com>
 <CAOMZO5AcUbYa0+40jZ=2a1dxO7D+tif82Arkguf_vVsP=CkzAA@mail.gmail.com>
In-Reply-To: <CAOMZO5AcUbYa0+40jZ=2a1dxO7D+tif82Arkguf_vVsP=CkzAA@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 17 May 2025 22:44:19 +0200
X-Gm-Features: AX0GCFuPw-95QK9Y-R6XdDbEWop8pKZXePDWn-F_BfwByu4isf1z0eURC1NIgFk
Message-ID: <CAOf5uw=cb2jQK1f-avqRvYxukYb-Sy-jWDvqEyM+nRLTnXcAwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
To: Fabio Estevam <festevam@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Adam Ford <aford173@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
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

On Sat, May 17, 2025 at 10:28=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> On Sat, May 17, 2025 at 5:15=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
>
> > Can you please point me to an example of a tested board?
>
> I have just tested the top-of-tree U-Boot on an imx8mn evk board:
>
> U-Boot SPL 2025.07-rc2-00018-g126a88d49bca (May 17 2025 - 17:21:14 -0300)
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> SEC0:  RNG instantiated
> Normal Boot
> Trying to boot from BOOTROM
> Boot Stage: Primary boot
> image offset 0x8000, pagesize 0x200, ivt offset 0x0
> NOTICE:  Do not release JR0 to NS as it can be used by HAB
> NOTICE:  BL31: v2.12.0(release):v2.12.0
> NOTICE:  BL31: Built : 17:16:49, May 17 2025
>

I was on master except this commit

commit 128d997a8772cc174f38d529d8b25f90b3aa8ad8
Author: Jonas Karlman <jonas@kwiboo.se>
Date:   Sat May 10 15:32:01 2025 +0000

    clk: Fix clk_set_parent() regression

    The commit ac30d90f3367 ("clk: Ensure the parent clocks are enabled
    while reparenting") add a call to clk_enable() for the parent clock.

    For clock drivers that do not implement the enable() ops, like most
    Rockchip clock drivers, this now cause the set_parent() ops to never
    be called when CLK_CCF=3Dn (default for Rockchip).


I can not try today but if you can, is this the commit that could break my =
boot?

Michael
>
> U-Boot 2025.07-rc2-00018-g126a88d49bca (May 17 2025 - 17:21:14 -0300)
>
> CPU:   NXP i.MX8MNano Quad Rev1.0 A53 at 1200 MHz
> CPU:   Consumer temperature grade (0C to 95C) at 32C
> Model: NXP i.MX8MNano DDR4 EVK board
> DRAM:  2 GiB
> Core:  180 devices, 23 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout=
)
> MMC:   FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... Reading from MMC(1)... OK
> In:    serial@30890000
> Out:   serial@30890000
> Err:   serial@30890000
> SEC0:  RNG instantiated
> Net:   eth0: ethernet@30be0000
> Hit any key to stop autoboot:  0
> u-boot=3D>
>
> Make sure you are using the most recent U-Boot. We had some imx8m
> clock drive hickups after 2025.04.



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
