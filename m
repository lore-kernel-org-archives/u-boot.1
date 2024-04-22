Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BF8C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 19:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 763B9889C3;
	Mon, 22 Apr 2024 21:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="htk7vWt/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6869889C1; Mon, 22 Apr 2024 21:36:12 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC9B889C3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 21:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4375ddb9eaeso28731251cf.3
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713814569; x=1714419369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L21Ma6lwh0kQWeK64WUAdv5y8b5n+0KVnewRokhfak8=;
 b=htk7vWt/kMAzgt8kxCDtwSGBAVYADUerL7zbwmE5KIJJ+tmjk7yS1YpNv1WWb+6NkL
 Nf4/mSe6yrx7G8MaL2QRWdiryg9ULZ1o0FUPiFkCcDsnhzRob4vLrcoEIs1X7TXG/HKn
 IBr8w3zhTRBifiPisLYpb++ta2YKu8eAflM3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713814569; x=1714419369;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L21Ma6lwh0kQWeK64WUAdv5y8b5n+0KVnewRokhfak8=;
 b=Mijk4gMrUYt6LRia+VhYlE8tkQEDmCH96qZ66XyAgT1dxUjv4bksn3aCPi3ZklbKg9
 TbKRZXDGP3h/TysPjbqhKr3SUiTgBCfVEs0kD0//I6Nm0TYMK2m+Q8LS61Lje31TVKsg
 Vd3vitKJHlJ+lCKXXY77k/z/BI+rhY86unbY91vUvV+vYXZNVng2Yno4ZoL7dB+xsUyU
 58Bls5p2FIzO079kN1K+Ag743lVlyHwBwUYkipCO7xHmVn/9vDed9hueuDM0BqLzQGa0
 cE5b8vL4HrfJ/QVba0wWLk7zrS4WRyscuXlXUL/o0fOEc30Ih0iM5Nk1swDYXgpBgHUr
 QX+Q==
X-Gm-Message-State: AOJu0Yx+ib+b+puUWSgBChNe9PI5nNxiGCBcaoG3jKflgFxUAx6uG1Z6
 Y5S8PqnvIJkLGGkyQ2M5J3zRrTMsXAglLATjHxHH4lY2tQnONYhmTQnJwd00Zro=
X-Google-Smtp-Source: AGHT+IGjga4KZKogIyZM1p0irH2LmXlKumpkIhr3LkiiUBMFN9CN5JkF/ZXsUs9LfKSlBuFF6LNkCQ==
X-Received: by 2002:ac8:7d05:0:b0:435:2351:75c6 with SMTP id
 g5-20020ac87d05000000b00435235175c6mr14232949qtb.46.1713814568681; 
 Mon, 22 Apr 2024 12:36:08 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 kk3-20020a05622a2c0300b00436b2135b51sm4492448qtb.64.2024.04.22.12.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 12:36:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Aaron Williams <awilliams@marvell.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Anastasiia Lukianenko <vicooodin@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, Bin Meng <bmeng@tinylab.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Doug Zobel <douglas.zobel@climate.com>, Dragan Simic <dsimic@manjaro.org>, 
 Eddie James <eajames@linux.ibm.com>, Elon Zhang <zhangzj@rock-chips.com>, 
 Enrico Leto <enrico.leto@siemens.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Grzegorz Szymaszek <gszymaszek@short.pl>, Heiko Schocher <hs@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, Jagan Teki <jagan@edgeble.ai>, 
 Johan Jonker <jbx6244@gmail.com>, John Clark <inindev@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Matthias Winker <matthias.winker@de.bosch.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Oliver Graute <oliver.graute@kococonnector.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 =?utf-8?q?Pawe=C5=82_Jarosz?= <paweljarosz3691@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Philip Oberfichtner <pro@denx.de>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Lunn <tim@feathertop.org>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Viacheslav Bocharov <adeep@lexina.in>, Vignesh R <vigneshr@ti.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>, 
 "open list:VIM3" <u-boot-amlogic@groups.io>, 
 "moderated list:ST BOARDS" <uboot-stm32@st-md-mailman.stormreply.com>
In-Reply-To: <cover.1713250508.git.michal.simek@amd.com>
References: <cover.1713250508.git.michal.simek@amd.com>
Subject: Re: [PATCH v2 0/5] Kconfig: some cleanups
Message-Id: <171381456119.1909236.8049238331801273262.b4-ty@konsulko.com>
Date: Mon, 22 Apr 2024 13:36:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Mailman-Approved-At: Mon, 22 Apr 2024 21:38:45 +0200
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

On Tue, 16 Apr 2024 08:55:14 +0200, Michal Simek wrote:

> I looked as cleaning up some dependencies and I found that qconfig is
> reporting some issues. This series is fixing some of them. But there are
> still some other pending. That's why please go and fix them if they are
> related to your board.
> 
> UTF-8: I am using uni2ascii -B < file to do conversion. When you run it in
> a loop you will find some other issue with copyright chars or some issues
> in files taken from the Linux kernel like DTs. They should be likely fixed
> in the kernel first.
> Based on discussion I am ignoring names too.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


