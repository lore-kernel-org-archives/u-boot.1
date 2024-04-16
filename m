Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A71FC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 16:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C598688426;
	Tue, 16 Apr 2024 18:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="faHMWIgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FA6488435; Tue, 16 Apr 2024 18:28:20 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4963988439
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 18:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-69b40061bbeso24539636d6.1
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713284895; x=1713889695; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FqcHMg+io5TRH47p0UVmvNME9n6tMmHq8yiZwGXoRr0=;
 b=faHMWIgXA2SEOBYEReze7EXhWY6lfH1ex7AdqXsm+h4xSsWEHkaIzEM94Th1AwF7j1
 adBcail8nNwOVdoS0bjiB0XkXOaltdtfJIimRbC4DxHPGtfSwAxa1/8VNB4srjz19vHL
 P+LPBdWtqCeS1ivxiAksBltwUYg/Ccop/k4fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713284895; x=1713889695;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FqcHMg+io5TRH47p0UVmvNME9n6tMmHq8yiZwGXoRr0=;
 b=dXrPO/rVZtDIXmDzINrSvQpab445qfhrvxU6ycNsjIJzRxBJf5OcXesteluHb4pgF4
 7Wi0tKDHnhH61/1SnNvZ2gluYXDJi/v/oTxvwBSX5eVN/Y1QCUMUuRqCMPkU7fzVCzGs
 4XoD1Td+9vnJJMxowqH6QBIpJmAdOzKRCGIYh9/l6S7nvgOTaEhiTZarLrW+NyehIFj2
 g4kdOpFm6vjwe3z/G3nSbsC+v53NI1zdMs2K79X4eNbCr/XAVt+M0EtgJA0EyPu4nmLe
 voRBEG7u/DrBj+nzoa+AeOtYyRafBoRL8017bJitsOEZ+VSJONRfIdLJIJfV+fUxg+eA
 0/vA==
X-Gm-Message-State: AOJu0Ywg/TyDPerBOCRbA5IuSO6FFj4BO01MbY9Dvj4TvA8oQxFU5P1b
 NecbyXmpFVZ7q7lrVnUyuVkucYqzQZH9H/00NB4Q9bNSH3CZ6gPG+8g5XTDtGJ0=
X-Google-Smtp-Source: AGHT+IEL94VJrEVoPYjUqrOkB9/X0f8WrQ+EyhOfaP3jywV6st9dfv8dm8YAc3A5xO45C2b2nfOdlw==
X-Received: by 2002:a0c:c60f:0:b0:69b:2aa8:dc66 with SMTP id
 v15-20020a0cc60f000000b0069b2aa8dc66mr12430164qvi.28.1713284895011; 
 Tue, 16 Apr 2024 09:28:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 gs15-20020a056214226f00b0069942a53f46sm4709704qvb.53.2024.04.16.09.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 09:28:14 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:28:07 +0200
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Aaron Williams <awilliams@marvell.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anastasiia Lukianenko <vicooodin@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Doug Zobel <douglas.zobel@climate.com>,
 Enrico Leto <enrico.leto@siemens.com>, Fabio Estevam <festevam@gmail.com>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Grzegorz Szymaszek <gszymaszek@short.pl>, Heiko Schocher <hs@denx.de>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 =?utf-8?B?UGF3ZcWC?= Jarosz <paweljarosz3691@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Philip Oberfichtner <pro@denx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Viacheslav Bocharov <adeep@lexina.in>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 "open list:VIM3" <u-boot-amlogic@groups.io>,
 "moderated list:ST BOARDS" <uboot-stm32@st-md-mailman.stormreply.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 5/5] common: Convert *.c/h from UTF-8 to ASCII enconfing
Message-ID: <20240416162807.GP1054907@bill-the-cat>
References: <cover.1713250508.git.michal.simek@amd.com>
 <abe7e535b9e4ee13cea1e6d1c37c8f1f6e6014e3.1713250508.git.michal.simek@amd.com>
 <20240416160631.GO1054907@bill-the-cat>
 <58f122b7-e9b4-4028-941a-0f1b647ffe4e@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4eJGolvCP+Hs53Rs"
Content-Disposition: inline
In-Reply-To: <58f122b7-e9b4-4028-941a-0f1b647ffe4e@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 16 Apr 2024 18:28:47 +0200
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


--4eJGolvCP+Hs53Rs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 06:19:48PM +0200, Heinrich Schuchardt wrote:
> On 16.04.24 18:06, Tom Rini wrote:
> > On Tue, Apr 16, 2024 at 08:55:19AM +0200, Michal Simek wrote:
> >=20
> > > Convert UTF-8 chars to ASCII in cases where make sense. No Copyright =
or
> > > names are converted.
> > >=20
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > >=20
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
> > Now, how did you test / find these? Given names a CI test is unlikely
> > to be doable but if it's otherwise scriptable I can put it in my loops
> > and just fixup as needed (like I do today for adding <common.h> for
> > example).
> >=20
>=20
> There seem no to be too many non-ASCI strings outside of comments.
> Should we care about non-ASCII comments?
>=20
> $ find . -name '*.h' -exec grep -P -Hn "[^\x00-\x7F]" {} \; | grep -v
> ':\s*[\/\*']
> ./include/configs/tec-ng.h:13:#define CFG_TEGRA_BOARD_STRING    "Avionic
> Design Tamonten=E2=84=A2 NG Evaluation Carrier"
> ./arch/mips/mach-octeon/include/mach/cvmx-pko3.h:369:   MEMALG_SUB =3D 9,
>      /* mem =3D mem =E2=80=93 PKO_SEND_MEM_S[OFFSET] */
>=20
> $ find . -name '*.c' -exec grep -P -Hn "[^\x00-\x7F]" {} \; | grep -v
> ':\s*[\/\*']
> ./drivers/mtd/nand/raw/nand_ids.c:65:   {"H27QCG8T2E5R=E2=80=90BCF 64G 3.=
3V 8-bit",
> ./drivers/video/dw_mipi_dsi.c:861:MODULE_AUTHOR("Yannick Fertr=C3=A9
> <yannick.fertre@st.com>");
> ./board/bosch/acc/acc.c:440:    .SRT =3D 0, // Set to 1 for temperatures
> above 85=C2=B0C
> ./cmd/2048.c:65:                                printf("   =C2=B7   ");
> ./cmd/2048.c:79:        printf("        =E2=86=90, =E2=86=91, =E2=86=92, =
=E2=86=93 or q        \n");

I think we need to keep the "2048" game ones as it's part of the reason
(can we display certain things properly) it exists but comments and
general strings should be fixed. And I think I can use the above
examples to put something in to my scripts to catch new additions.
Thanks!

--=20
Tom

--4eJGolvCP+Hs53Rs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYepxEACgkQFHw5/5Y0
tyxKngv+KN55TwUiPhzrmZO2E12hsvfYQydZ4xJsZ4fieMjAzsN54feusrRz29cQ
hjWIR8ZsIHFVdZ9nMAuI6jB1Oz1W8Y2ku5CgHRjq7J5Qybtu5Wr4x9myGNjPaUVz
UaatipZz0t6ENjMt9R0UAON15wZeX8tjsSIvs2Rv82sznSSUYxICnUkPgYDO1ace
MQjpWgQlqx/0p3wmmDd9GCCgxL3EAzvMAvZ0LifmJtwQFo1XzZ8T2gRaWMtUhjKQ
FcNwnt8oWFTwfwE7H1G97vopNTI5aOeeBmZTOdKBrbr4bf1BEXiUDIKVtYORtzJA
Zh4gz0l6TBMuZd3hXn9KPh8zr9GiK3mPOXqdF8guY6T9qh8n3hvvEHVEdw8JOzqs
eDOCHo418A33Ls3uHyGVzuCkia+CAE/EqF8fe13TqBKE/G5kjUUE1C5PMFPYy2TM
JGdiGIc0PFpScZIjvly818MwfH248mbI6ApQq0o8KG9p9Osl95D6kkBraJYSF+Xh
MYkTRKnc
=ZzGS
-----END PGP SIGNATURE-----

--4eJGolvCP+Hs53Rs--
