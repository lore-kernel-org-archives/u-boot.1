Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBDAC87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8087282BA1;
	Tue, 29 Jul 2025 18:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="YYII9YP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98D1382BA7; Tue, 29 Jul 2025 18:02:57 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA80A82B07
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-301704710a9so3364343fac.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1753804973; x=1754409773; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqAHCKqQoUOYdZg3b5fkB7M1aj3vkkEHhoihYWoOHNY=;
 b=YYII9YP6+G64md9H3Mt8YMeiR8nAG/1tDaH/NFRKj+sg61inDKQ7nvba3HywL/WTdy
 53Hpm4U8i8ynJZJC6fPjCOaqkyRvDZt5Cq7Y8yX5FZzCF9dP2E3hsckxp2oXvU8a62+F
 hfUljstSQ005TD8LEbOmewQezEz3Z83MC7dH1XMlm9v3dk37xr3X+LKXLjDJHPPhzo9x
 +b3u3eZN0MrBMk92i0pfQMBQJ2jKCc0R5diuceXQC19xL9oMOcoMn/7GyiSrmoWqzxl2
 DUuOWvSUprpli76ScOexlhoCrJ/+U5zYAdrZVaInfBX1BjNE/mUjxVMyTpNzjfYSqaFx
 OBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804973; x=1754409773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqAHCKqQoUOYdZg3b5fkB7M1aj3vkkEHhoihYWoOHNY=;
 b=OvrmUdROxlR/thiQV96TN6YEpgI9rmA/oJH7OfaM+3VebBbTf96n5M6oHZtlZFcQm+
 KTIMzX+EAw2r6mG5JYxgNoTVBXf7rxXazGi8BlnqOp5wJt6xHTUbgmvRoCgKIBmGZ4fh
 akrCobZRRwIqZkwcj9daH9hJUkf7nX2dNx6sMTxjTnGcXQlZAAX5HdFM7g6scolr3tgv
 7MjyqWWX8EthBMDKTEtFxkzL8mHX1XHzjB/iOEf7eKyUGR1TG7/XyMK1SsBQtVJmYdQ0
 PzBIOz1nfrzq/ZqFpiCdc1foqcw9ysCgtqsGWGaPV6HWGr5AePRsFBNNT+qXQKQhDIrl
 DH0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4KIKBVX+4J0u/xAODyi0/S+uGKONfK9/zfJgjwMzk/ARhLHP9Bldc6Dnu4HnX0NEGTJYGqww=@lists.denx.de
X-Gm-Message-State: AOJu0YxGKZ20AK84LnIOIkYBuFmLuVAoUfZpXyuLH+WMCKF0tVt+lwKg
 ZilxW8s7tWiLZo6DzW9JxEZ/NkWQNsDj+sYd51RFSTn2rEetqm3cTKS+vF0lGSeBQkU637xP46P
 GeIJq9rfO5k51b890W+0bMrYQuVsHjYj4zIVogFbWhw==
X-Gm-Gg: ASbGncuH8cwq7Mf6ZPQ225hO1yaeTOLjwyaXpbO/DcFAbh3p0GjoP9hW8qHXROIHKYX
 KWrfolFRnCLeBwWIkOyM7j0lvrUYgtqlB71m6OubsQMkPCtwS72rvLt98vdL6+6wQtlLBqm6FrX
 sYHEomvCiZ0OOkoeqDhvYgIoe5q51XFmLlvbF9SY0VrFW9rNIpLV1Eu5vnnA8Yx3302k6qaMnTM
 KcAJCPPqSQyargxmA==
X-Google-Smtp-Source: AGHT+IGEJ73z2R4j5dCnXnZ4oQEy1YfbMEGd+1zw2srmcYvFUuEI8ITmrorjSZC2rvkSMGSz6GbSAqpF3aDBVlZF6qs=
X-Received: by 2002:a05:6820:178f:b0:615:b4c8:ee80 with SMTP id
 006d021491bc7-6195cf8e8femr226808eaf.0.1753804973092; Tue, 29 Jul 2025
 09:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
 <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 29 Jul 2025 09:02:42 -0700
X-Gm-Features: Ac12FXzrREIt7hkq6bZQIO9d66cqWkq0Jxdguq88jJTXsOUfn0boQzZpeFhqNqU
Message-ID: <CAJ+vNU1asw79GMnsTxNevg+xRo-1SQ9j_f+4e-TEy4TPZ+Qt+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] imx: add i.MX95 b0 support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>
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

On Mon, Jul 28, 2025 at 7:21=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> Hi Tim,
>

Hi Alice,

Please stop top-posting in replies - It forces users to read the mail
in a backwards order to properly understand, content gets lost and out
of order and threads get broken.

> A0 has been dropped.

This is unacceptable. Had I known this series was doing this I would
have NAK'd it. There was no mention in the commit log that this would
drop support for A0. There are many vendors like myself who have A0
silicon evk's that will likely never get upgraded and should not
become bricks.

We need to at least know how to get back to working boot firmware for
A0. I would be fine if there was just a Kconfig to select A0.

>
> Please use mx95a0-ahab-container.img and the older imx-oei, and then you =
can check if this change needs to be added.

Yes, I tried mx95a0-ahab-container.img but I think you need to be more
specific with the 'older imx-oei' - there are obviously patches in the
OEI's that also drop support for A0. Regardless, I've gone back to the
OEI that I was using previously (lf-6.6.52-2.2.0) and I'm still not
booting and reverting commit 9936724aa9b ("imx95_evk: Add i.MX95 B0
support") didn't get me booting either. I'm still trying to figure it
out.

Best Regards,

Tim

> static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
>  {
>         struct scmi_clk_parent_set_in in =3D {
> -               .clock_id =3D clk->id,
> -               .parent_clk =3D parent->id,
> +               .clock_id =3D clk_get_id(clk),
> +               .parent_clk =3D clk_get_id(parent),
>         };
> This is the patch link of the change: https://patchwork.ozlabs.org/projec=
t/uboot/patch/20250707202034.385890-1-alice.guo@oss.nxp.com/
>
> Best Regards,
> Alice Guo
>
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tim Harvey <tharvey@gateworks.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B47=E6=9C=8829=E6=97=
=A5 2:02
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>; Y=
e Li <ye.li@nxp.com>
> > =E6=8A=84=E9=80=81: Stefano Babic <sbabic@nabladev.com>; Fabio Estevam
> > <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>; Tom Rini
> > <trini@konsulko.com>; u-boot@lists.denx.de; Alice Guo <alice.guo@nxp.co=
m>;
> > Jacky Bai <ping.bai@nxp.com>; Peng Fan <peng.fan@nxp.com>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v2 0/4] imx: add i.MX95 b0 support
> >
> > On Mon, Jul 14, 2025 at 11:41=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss=
.nxp.com>
> > wrote:
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > > Alice Guo (2):
> > >       tools: imx8image: Add 2 new commands CMD_CNTR_VERSION and
> > CMD_DUMMY_DDR
> > >       imx95_evk: Add i.MX95 B0 support
> > >
> > > Ye Li (2):
> > >       arm: imx: Update ELE get_info structure for i.MX94
> > >       spl: imx: Add support for new PQC container
> > >
> > >  arch/arm/dts/imx95-u-boot.dtsi            |  8 ++---
> > >  arch/arm/include/asm/mach-imx/ele_api.h   |  2 ++
> > >  arch/arm/mach-imx/image-container.c       |  2 +-
> > >  arch/arm/mach-imx/imx9/Kconfig            |  1 +
> > >  arch/arm/mach-imx/imx9/scmi/container.cfg |  1 +
> > > arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  5 +--
> > >  common/spl/Kconfig                        |  7 ++++
> > >  doc/board/nxp/imx95_evk.rst               | 12 +++----
> > >  include/imx8image.h                       |  6 ++++
> > >  include/imx_container.h                   | 11 ++++++
> > >  tools/imx8image.c                         | 57
> > ++++++++++++++++++++++++-------
> > >  11 files changed, 86 insertions(+), 26 deletions(-)
> > > ---
> > > base-commit: cd79a2839b01571b6f2915c219f71c05e3c97482
> > > change-id: 20250708-imx95b0-e12a13552658
> > >
> > > Best regards,
> > > --
> > > Alice Guo <alice.guo@oss.nxp.com>
> > >
> >
> > Hi Alice,
> >
> > It would appear that some of these changes break compatibility with A0 =
silicon
> > chips. I've tried rolling some things back using the old ahab container=
 and older
> > imx-oei but am still not able to boot my imx95_19x19_evk with A0. Can y=
ou
> > please explain what is necessary for
> > A0 vs B0?
> >
> > Best Regards,
> >
> > Tim
