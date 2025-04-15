Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF454C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 14:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B1A98214D;
	Tue, 15 Apr 2025 16:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tf/kfTGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED6982A27; Tue, 15 Apr 2025 16:43:28 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A2FE80FEC
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 16:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff85fec403so6305108a91.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744728205; x=1745333005; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glMeeONHsep2Czxe0ZgDuljNN4HwLGA00Tc2fk+hqT4=;
 b=Tf/kfTGRqTLa+ltTIhlBrxA5Hod8hEyadwG72dSvJU+6M1vzWLQi3tpx8Hyxp5ZC38
 QHAxuGXvO+JAsWBVAbSNCf/E6rBJKpLL+l/ShjRffNcyfE54VDOP8jL0qO1XuqZ3wUW3
 CFwu8XQlOMovU5yuoJ+I8T9VDI3C8bghbAMy8B93ecfNGMx8rFKuy1tRe3Co0lHsKGSa
 /Cejl34R9jMRABVAsB9d1yU3m+fZrHe6oYRLVzyatBOupqSWPEC8xvCxbFacbVEDT1To
 5CZtGKGK1wIL4u/zikn9PrWmtRYenhagD4F1ppoTqE6eHaGf8chzlFvXAZbabMuSbcRk
 gnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744728205; x=1745333005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glMeeONHsep2Czxe0ZgDuljNN4HwLGA00Tc2fk+hqT4=;
 b=JpUmy91SzwBamxgGJz93qlmRF9n9a/1NEw3NWCwA9j/z1K53jHi36rzhiYMJbVw/25
 fcLxeQ/Kdqnc0OnDBfysE6AKOt3M2QnZ5Q5t253CgmumeEc6IALSL0TP220hu1ToxdcD
 3T6ZIkTXiTmiPg3hFKOp5eLyhvNOwpyqeCvkxmBKp2h38cA4fH9Rp2yzSGaWQHEpenyD
 EjLM6rQMA3gmmFryhKA66aVsaRuYg0KTU/9dmQjj7OGVkMnMALke1YrJI+g4EvMb8qc/
 o46BooaxEplMZQJTpaQxqHM7KREzZUyJ+8k7ocwjsX9yyKZ0V89H/dyWLGIhltS1oyNN
 H3NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoQRvjCGjG0/TvsIDKrV1h7lNJoDcEqXiQdqIB6gVQTaJq9DlysIzAo8w/Rdk2OcKewNfuQRA=@lists.denx.de
X-Gm-Message-State: AOJu0YyI+r+mWP+vcPVjmUR836NDUjTj3dNxFSl74ugqH4F97IjTdw7D
 SPHTZLVTpsA2xw5ML0wSD8VNrja6HmcMRl8NkYvO/+zC0vq9Djl1K0n5uaAst7EmpAU3hMYBW0H
 m2jqYUckXSBfwlRVC/IKQKr0CiYA=
X-Gm-Gg: ASbGncskaR8gtrX4EIqWc/+XCL3qkn9dfwRjF2QIR4pdiksnqjxF9ZEkae0SlmJCzZe
 UgmU1FM6vrzcxqI31YqbqoCynhWZyZtov2WGShtFPrshtzyEjYfS9beO4at1tczrYv5rCeolEL5
 IgAD3zOQ3mg0KGb84Jb4y+PomAxolWrKP2
X-Google-Smtp-Source: AGHT+IGzFsi+PBo8u1SrDWmM0KgeEj0I6JUiZf5xDrZgGGvitaINLdCVrujJsXiUbov2Q95CtgoS7R3XJStuwnFjvxY=
X-Received: by 2002:a17:90b:5243:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-3084f3249aamr5219322a91.5.1744728204740; Tue, 15 Apr 2025
 07:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
In-Reply-To: <20250415142846.GA244333@francesco-nb>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 15 Apr 2025 09:43:12 -0500
X-Gm-Features: ATxdqUEV5ZHQQgZr_KpjAcm2VPjZ_qolRSw1rihMHWC4j3wSkZE2Qh9IijspF2E
Message-ID: <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
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

On Tue, Apr 15, 2025 at 9:28=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> Hello Marex, Fabio, all
>
> On Sun, Mar 23, 2025 at 04:58:45PM +0100, Marek Vasut wrote:
> > Convert clock-osc-24m back to osc_24m and clock-osc-32k back to osc_32k=
.
> > These are the clock which match clock tables in Linux. This is now
> > possible because the clock drivers now resolve clock names based on
> > clock-names DT property in the CCM DT node.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
>
> Current USB fastboot functionality from U-Boot proper in master is broken
> on Verdin iMX8M Plus since commit b4734c9c333b ("clk: imx: Convert
> clock-osc-* back to osc_*"). Other i.MX SoCs might be affected, I have
> not looked into every detail.
>
>   Could not fetch index
>   Failed to get PHY0 for usb@38100000
>   Could not fetch index
>   Failed to get PHY0 for usb@38100000
>   No USB device found
>   USB init failed: -19
>
> Reverting this commit on top of master is not trivial (there are
> conflicts, and I have not looked into the details).
>
> Full log for reference
>
>   U-Boot SPL 2025.04-rc4-00537-gb4734c9c333b (Apr 15 2025 - 16:14:09 +020=
0)
>   Training FAILED
>   DDR configured as single rank
>   WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
>   SEC0:  RNG instantiated
>   Normal Boot
>   Trying to boot from BOOTROM
>   Boot Stage: USB boot
>   Find img info 0x4802ec00, size 1116
>   Need continue download 1024
>   NOTICE:  Do not release JR0 to NS as it can be used by HAB
>   NOTICE:  BL31: v2.12.0(release):v2.12.0-946-g4d913df8f85e
>   NOTICE:  BL31: Built : 13:19:07, Apr 15 2025
>
>
>   U-Boot 2025.04-rc4-00537-gb4734c9c333b (Apr 15 2025 - 16:14:09 +0200)
>
>   CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
>   CPU:   Industrial temperature grade (-40C to 105C) at 56C
>   Reset cause: POR
>   DRAM:  4 GiB
>   Core:  309 devices, 31 uclasses, devicetree: separate
>   WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeo=
ut)
>   MMC:   FSL_SDHC: 1, FSL_SDHC: 2
>   Loading Environment from nowhere... OK
>   In:    serial@30880000
>   Out:   serial@30880000
>   Err:   serial@30880000
>   Model: Toradex 0058 Verdin iMX8M Plus Quad 4GB WB IT V1.0B
>   Serial#: 06849144
>   Carrier: Toradex Dahlia V1.1A, Serial# 10763256
>   SEC0:  RNG instantiated
>   Setting variant to wifi
>   Net:   pca953x gpio-expander@21: Error reading output register
>   eth1: ethernet@30be0000, eth0: ethernet@30bf0000 [PRIME]
>   Hit any key to stop autoboot:  0
>   Could not fetch index
>   Failed to get PHY0 for usb@38100000
>   Could not fetch index
>   Failed to get PHY0 for usb@38100000

When running my 8M Plus in Host mode, I got similar "Failed to get
PHY0 for usb" failures, but I hadn't yet bisected it.  The PHY itself
doesn't appear to have a clock reference itself, but it does reference
a power-domain which uses multiple clocks. I wonder if one of the
clocks in the hsio power domain isn't registering properly.   I won't
be near my 8MP until much later tonight, but can you run 'dm tree' to
see what clocks are enumerated and which might be missing?

adam

>   No USB device found
>   USB init failed: -19
>   Verdin iMX8MP #
>
> Any suggestion?
> Francesco
>
