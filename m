Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB761CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 21:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A50880422;
	Fri, 22 Aug 2025 23:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="QZS2PEkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29FA82103; Fri, 22 Aug 2025 23:24:26 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 336BD8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 23:24:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30cceaaecd8so1107508fac.2
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1755897863; x=1756502663; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBE0FyG8mV3daf3eMmuKVP/rUL/fbXyl1wunLJ43VK4=;
 b=QZS2PEkOC93iUTCwqKyvX3//z5jtudm07o0YCoPAhLhcRmwMHvS/+YeuSyGYD/p2OT
 an/qGXqBUBQhxE33zAPY08FMguX9OuNsVmgfBKc0i/9UDQGVOeVieXJvPaqq6u++kL14
 9DGq7SU+tQbOoLZpRo3ZUEFOFdwAljxgwFWweniGSHz1ULkyXBFMp7wVxoy8k1vMJfjO
 wSb9kJAchdMvpRfQFlnwsMuAMKVakeNEilhlnW+5eGsnwFmedMhguBwjrP5mi3Uy5Yds
 InR0wdtwQoz7+EYbb8vXZU8Ra1Yz964WZnjg4XnWUyZF5cEvI3nyXlEhslE8tQn7nXjo
 Gq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755897863; x=1756502663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBE0FyG8mV3daf3eMmuKVP/rUL/fbXyl1wunLJ43VK4=;
 b=Qy1O6Yz434gESKti8fu4+EXewbF5d46vGryx8m3qFZSIt5ZY4/OvAbZIRb5G9yFpA9
 ywoAxYRf/h5Lz7cYHiPfzcAjJCsRpuXs5tKzoVgtAsL15I4c0Lssz+NpY/9NP4yGEizC
 BTBdR3HN7tm/xcgiXtXUiVidjdw4YfXhKgt7+9RAlqRih2oJUnH+0DhQRL17+4zQ10Wt
 QOGmCyydL8YfIFcRxha+ZOX8nv24PTHZyuBpsRnDWYi9Xsofugx7z+zweuI2MnR6/B6W
 91wIiLK/JETToAtepAw8I8VJDKhq+KfeSBASV47GwWe5yTeDPO98Mkp3RvAx0Ybc+Eg3
 5Hbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK+TTb7lfmhe+11CEn1j/KKpQrCMq1Yy+lz+BTWfaviI+NcBLgD5JT52+XQTmNtOHYY3pEODA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx6hLcaLsPbTSCPR+L/a7TxhNRyd9XhHGl7dDapE7s+RVpidbr
 qoCQ9IQkY+6+xa7G4bAR7Fiw51pglZ4KAX5saHdTzfAKZxWc/yp7o6aOe04f2Qcnu5l8FwIdSRl
 4lBlDvKn2L2/aeplpJouz8Ped64wuAB4kj+zAtVkVqw==
X-Gm-Gg: ASbGncshRG6lX5GzEIcbTj6zwhka55ZHrYBO8nTv8a27tipfWg8N+NQiiXdz283Rxjn
 zXsvUjNB0wN42Bs8cmA343W81OJPlMKW6+l3N0WrCDYF1WsXjlfs1thvLUCHZWQllOM+JoYbOKj
 e6RO6m8eLMHVHN8c3rMwqLtvuTFpLGk/uPjpRIvOl+FWIyTPR0KD/aeBVsnYzLLxZDt0x7TW6/8
 8XZLDf6pFro2Cm3OQ==
X-Google-Smtp-Source: AGHT+IFR7WhhODUEnydjFSIlTREnmYkLUgMhhulUEWp7ReEtXJT7LHNPUTGw09lhu6OVs+D9Jwjpvvf7XlCGbrSiL10=
X-Received: by 2002:a05:6870:7188:b0:314:b6a6:686c with SMTP id
 586e51a60fabf-314dce19f71mr1991125fac.46.1755897862806; Fri, 22 Aug 2025
 14:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
 <CAJ+vNU0q4ogZuNSxCMNPwXq4-ojqi7ss8ABYip0Q-BfSkvaidA@mail.gmail.com>
 <PAXPR04MB96443502294D1C7F8D66A26FE232A@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB96443502294D1C7F8D66A26FE232A@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 22 Aug 2025 14:24:12 -0700
X-Gm-Features: Ac12FXxXfRh4rl35Oida1IcuJgaS99oWegiCpD9-xUL9N7aKba5BpqSptf7jkdo
Message-ID: <CAJ+vNU1QCMd-dT94VQLL8e1T3rCWUCNzpDbzBnirL95mZH+eyA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Restore support for i.MX95 A0 silicon
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Marek Vasut <marek.vasut@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
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

On Wed, Aug 20, 2025 at 8:37=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tim Harvey <tharvey@gateworks.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B48=E6=9C=8821=E6=97=
=A5 8:52
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > =E6=8A=84=E9=80=81: Tom Rini <trini@konsulko.com>; Simon Glass <sjg@chr=
omium.org>; Alper
> > Nebi Yasak <alpernebiyasak@gmail.com>; Stefano Babic
> > <sbabic@nabladev.com>; Fabio Estevam <festevam@gmail.com>; dl-uboot-imx
> > <uboot-imx@nxp.com>; Alice Guo <alice.guo@nxp.com>; Marek Vasut
> > <marek.vasut@mailbox.org>; u-boot@lists.denx.de; Ye Li <ye.li@nxp.com>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v3 0/2] Restore support for i.MX95 A0 si=
licon
> >
> > On Wed, Aug 20, 2025 at 4:05=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.=
nxp.com>
> > wrote:
> > >
> > > Changes for v3:
> > >  - update the binman etype to generate a configuration file and a .bi=
n
> > >    file
> > >  - update Get ahab-container.img in imx95_evk.rst
> > >  - rename configs/imx95.config to configs/imx95_evk.config
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > > Alice Guo (2):
> > >       binman: add a new entry type to support .bin file generation fo=
r the
> > i.MX95 platform
> > >       imx95_evk: Restore support for i.MX95 A0 silicon
> > >
> > >  Makefile                                  |   3 +-
> > >  arch/arm/dts/imx95-u-boot.dtsi            |  44 +++++++--
> > >  arch/arm/mach-imx/Makefile                |   5 +
> > >  arch/arm/mach-imx/imx9/Kconfig            |   5 +-
> > >  arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
> > > arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
> > >  board/freescale/imx95_evk/MAINTAINERS     |   1 +
> > >  configs/imx95_19x19_evk_defconfig         | 153 +-------------------=
----------
> > >  configs/imx95_a0_19x19_evk_defconfig      |   2 +
> > >  configs/imx95_evk.config                  | 150
> > +++++++++++++++++++++++++++++
> > >  doc/board/nxp/imx95_evk.rst               |  42 +++++++-
> > >  tools/binman/entries.rst                  |  12 +++
> > >  tools/binman/etype/nxp_imx9image.py       |  85 +++++++++++++++++
> > >  13 files changed, 338 insertions(+), 191 deletions(-)
> > > ---
> > > base-commit: 0c558bbad9e7581808b358091d1fd979f860e8ac
> > > change-id: 20250809-imx95-10b5b18e0ad7
> > >
> > > Best regards,
> > > --
> > > Alice Guo <alice.guo@oss.nxp.com>
> > >
> >
> > Hi Alice,
> >
> > I have a board with IMX95 A1 silicon - with respect to this documentati=
on should
> > that be considered A0 vs B0? Are there any issues with A1 that would ma=
ke the
> > oei/sm/atf/uboot not compatible here?
> >
> > As far as I can tell the only part of boot firmware that needs compile-=
time
> > configuration based on silicon revision is the imx-oei and I only see s=
pecial
> > handling for r=3DA0. If I build with anything other than r=3DA0 the OEI=
 does not run
> > for me whereas building with r=3DA0 the OEI's appear to run fine yet I =
don't seem
> > to make it to U-Boot SPL.
> >
>
> flash.bin for i.MX95 A1 can be generated in the same way as i.MX95 A0. Ca=
n sm run work well? oei-m33-tcm.bin is required for A1.
>

Hi Alice,

Thanks for confirming this. I can report that configuring for A0 works
and I'm booting into U-Boot now on A1.

Best Regards,

Tim
