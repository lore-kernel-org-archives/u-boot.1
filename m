Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB777E6B27C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 13:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA4D892D5;
	Fri,  1 Nov 2024 14:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fV6SXibB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B74892D5; Fri,  1 Nov 2024 14:58:56 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1E4892C6
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 14:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b13bf566c0so111225485a.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 06:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730469533; x=1731074333; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XcGAPOirI0xNMSCCezzrGzPP3Z7rYqS37z7qGh81lBg=;
 b=fV6SXibBB7ZorOYzCE/CwJrxCmFZHPQ3BVSQ0SMvZQCF4oMPFWi5djNiJINgbfSGnA
 OIVaJSaOaNBmToP1jAAg9ezZ9OS/Y09zRUY/JoDVzbLPpMnzqAMXc9xKJDrXbgO+FwVx
 479iGnGT1nDq94Ap6GgB71JunbL6NeaKLdTv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730469533; x=1731074333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XcGAPOirI0xNMSCCezzrGzPP3Z7rYqS37z7qGh81lBg=;
 b=jqyyY8KjRx2rRn8mB13gCLKYhSUPX5IQjNpwIx2/j+Q6E6wgk45QiWiwFg4M+yJNrB
 HApluYNM5gAfVh+CMUjsI3hsSqCSt/srYjg3aRVa9PSgInk2vpUkAO30O7DIY+8rxoHE
 kSNXehtNKJ3c2wUFWZ6MvKH+6HNaH3OxkNkdlIKrZWSoulMHf6i73Sbw5zNgWx9yQZYf
 fFysdZcATKwiL4Uo60AHhfJXnq1+qCHU/qYYwzaAnepapD5r8azsCjKXL7xjHzBAeAhQ
 StZ7ln41XqZD4IMfe6gH4cApozRvn3EAqUN+JignqVDcq9Z0qS2gXmtr0s8xWrX2eDG9
 KjdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWSbDxy7CXN36h1IxTj52Vr5Gg+ZFP/hTKvhr1xBAS14i/ruaNmlBt4GZR17faeMRR8W9fDp8=@lists.denx.de
X-Gm-Message-State: AOJu0YwPkgq9e8m13UFuxljCni2eugPPWkh0uuES6+PqJdwGwp7xdIff
 qCYNxPlpGdqcTwWNHm4gNkVweOwsQOs8EUPvHAWvNtcfflS68X0VqSUrOSKDrTI=
X-Google-Smtp-Source: AGHT+IFXttbDmqLtyJLH3PhsW8/B1DkqsztSX7U2oH2EfyKOmGI0U0TXjs2FS+7SYe2SZv1acPxeeQ==
X-Received: by 2002:a05:6214:2f84:b0:6cb:3b34:55d3 with SMTP id
 6a1803df08f44-6d346027312mr118955006d6.29.1730469533275; 
 Fri, 01 Nov 2024 06:58:53 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353fc7be8sm19528186d6.45.2024.11.01.06.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 06:58:52 -0700 (PDT)
Date: Fri, 1 Nov 2024 07:58:49 -0600
From: Tom Rini <trini@konsulko.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Marek Vasut <marex@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbRVhUXSBSZTogW1BB?= =?utf-8?Q?TCH?= 14/17]
 imx95_evk: add i.MX95 19x19 EVK board basic support
Message-ID: <20241101135849.GK3600562@bill-the-cat>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
 <20241016-imx95-v1-14-f640c8f3bc1b@oss.nxp.com>
 <CAOMZO5DY7LeLvp33cnocTuW4UgA7tnmJdeUX1e3Y6wqusahBDQ@mail.gmail.com>
 <PAXPR04MB964465837D7E1BB2D85FFED7E2562@PAXPR04MB9644.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7FeNS95Kk9fbBkz+"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB964465837D7E1BB2D85FFED7E2562@PAXPR04MB9644.eurprd04.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--7FeNS95Kk9fbBkz+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 09:43:14AM +0000, Alice Guo (OSS) wrote:
> Hi Fabio,
>=20
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Fabio Estevam <festevam@gmail.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B410=E6=9C=8816=E6=97=
=A5 19:36
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > =E6=8A=84=E9=80=81: Tom Rini <trini@konsulko.com>; Lukasz Majewski <luk=
ma@denx.de>;
> > Sean Anderson <seanga2@gmail.com>; Stefano Babic <sbabic@denx.de>;
> > Marek Vasut <marex@denx.de>; dl-uboot-imx <uboot-imx@nxp.com>;
> > u-boot@lists.denx.de; Ye Li <ye.li@nxp.com>; Alice Guo <alice.guo@nxp.c=
om>;
> > Peng Fan <peng.fan@nxp.com>
> > =E4=B8=BB=E9=A2=98: [EXT] Re: [PATCH 14/17] imx95_evk: add i.MX95 19x19=
 EVK board basic
> > support
> >=20
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t this
> > email' button
> >=20
> >=20
> > Hi Alice,
> >=20
> > On Wed, Oct 16, 2024 at 4:19=E2=80=AFAM Alice Guo <alice.guo@oss.nxp.co=
m> wrote:
> > >
> > > From: Ye Li <ye.li@nxp.com>
> > >
> > > This patch adds i.MX95 19x19 EVK board basic support.
> > >
> > > Signed-off-by: Ye Li <ye.li@nxp.com>
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> >=20
> > A MAINTAINERS file is missing. CI flags this as an error.
> >=20
> > Please make sure to run the series through CI before posting v2.
> >=20
> > A general question: how is the flash.bin generated?
> >=20
> > I don't see binman support here. Why?
> >=20
> > We also need a doc/board/nxp/imx95_evk.rts file that explains how to bu=
ild and
> > boot the board, the firmware files it needs, etc.
> >=20
>=20
> We will have new revision silicon that not compatible with current silico=
n container format. The current version will not goes into mass production,=
 so I prefer to defer the binman work when new revision silicon arrives. Wi=
th current patchset, I could add doc to use imx-mkimage to pack images. Wit=
h new revision silicons ready, we could switch to binman and update doc the=
n. Is this ok for your?

I would expect the binman support to be easily adjusted to the new
format when it's available for you to test and we can easily enough mark
the first format as deprecated to start with so removing it later is
also known up-front.

--=20
Tom

--7FeNS95Kk9fbBkz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmck3pkACgkQFHw5/5Y0
tyy8GAwAngQmPGvawBTOoUJ6YbkKVH8LoGWvdm328Io3YRI2ZtAk/iHqJa8puC3t
r1yQKEYLUnR4lfoXReHF2xjHbqUKDLQPMhwXjvt24SKbzLnJiyJuHhFR4sahUlHA
j/wla/eq3QGwuLRHAv8yB0uyN8FIG5vMVdb25OkNzK9ikZ+ARd0Z0IvFTkGOzoLe
sY48P3ATGj/Sah8UscJk8NINwgaysVjicFTPkZ863u7iqubdEt2jB4IcTvQkPn5Y
HfSNauos3byi2kioSteU3oc18ancjeLmlRQ6Bz1/NTFITGDUWxqV5YFh6+xlMmgD
oXPWGuAOwjTC0LVc6QV/a1jEdg2NNpFJRlSB/4YVzHNoyKKSDqAEpq24i5eqdMMj
EkG+wESdLS+25M7/n0/YEYCT6WG/FK9NmpvpvGHOhnVZnKxCJOrMaZAGPn81fCad
SPkvmvlsEHRyQ37x2KDWNi15q9Zu4f5VPPvUwyg2cKSaLMp+e+ARp+V8iKbrHBnT
owbqDdwj
=FUie
-----END PGP SIGNATURE-----

--7FeNS95Kk9fbBkz+--
