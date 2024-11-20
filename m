Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1134DD743D8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 20:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AB4E8910B;
	Wed, 20 Nov 2024 21:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qnuAH/3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 255E589301; Wed, 20 Nov 2024 19:06:45 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C864889346
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 19:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-46101120e70so349631cf.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732126000; x=1732730800; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KIgpyphRz6hOMD/n6XPZ+0XeyeeXh/Egu7p8MBAnYNw=;
 b=qnuAH/3HRmZC2UNYBziui+tMW4XvdBrG4XZzWItvyuEk0uQ0sIzhT7fETts/Tk/8lH
 u2bRt9y0aWw2DGpb31qqxkIdR7AZwjVln/BI1E8CL4EQyyxkXaAyX4KB3W12CFDBIM22
 HAZ2pNMS9I0TxFEtCYsuy2FeHF3HutRiyEEVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732126000; x=1732730800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIgpyphRz6hOMD/n6XPZ+0XeyeeXh/Egu7p8MBAnYNw=;
 b=sWnT0QHsebA3ltso5C0wL54IgvHgL5hGeyPRGwLK8ZAW5ggq+HekOJnj3tjT9AgZQC
 zaWiyY81plKNXmVSGGuHE/q+CYBWqpITj2J1dyeinZvpUu7kV3pEiEZxhddgMHTlidZg
 yZy63+iG7tnwoRrO74jlFmr1wIb5CK/Zhj43DGBeMjMVSjDUh6/szgode4M/lhSrok/2
 LL9wCiW3QJQZTnWgROgprv4raMJDY7qSPDXB9XraQU22q3sqdgjFSAIEjQyBzRlHYS2p
 ZqaiHtr7fDGfVno+u5k6Lu9kxdbKDGYpZDxny1+AZX3V7qNsZYil8F7bkBuC/6uwah0W
 TGFw==
X-Gm-Message-State: AOJu0YzOs2qsOg+DK1EW08L6QB4Di1KOiY8eH0gxkgy1U2XZIU5ogvx4
 5IlhJ81l3MVA6vQ/8iJWnUPaE1G1fRMN4gpjZbFI3IXHQbOiRmmUsHtmrPUtvCo=
X-Google-Smtp-Source: AGHT+IFvz7urlQI/HdktGSf9HfiERKM33WHIZkbjBsiK/boNm6pQrzTJTQCOwYt+kQCZT2jnxsrA4g==
X-Received: by 2002:a05:6214:20a5:b0:6d4:1199:52 with SMTP id
 6a1803df08f44-6d43782aba9mr45788806d6.28.1732126000628; 
 Wed, 20 Nov 2024 10:06:40 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d4380f464dsm13434736d6.63.2024.11.20.10.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 10:06:39 -0800 (PST)
Date: Wed, 20 Nov 2024 12:06:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Levi Yun <yeoreum.yun@arm.com>, Marek Vasut <marex@denx.de>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Wei Ming Chen <jj251510319013@gmail.com>
Subject: Re: [PATCH 00/15] efi_loader: Add support for logging to a buffer
Message-ID: <20241120180633.GE3600562@bill-the-cat>
References: <20241028124815.47262-1-sjg@chromium.org>
 <CAC_iWjKtaN54B98OKbkoXkC_GmKJ=x+M4=UY_O6roSOpZaDxag@mail.gmail.com>
 <CAFLszTj9Dc-uF=GjSyxTue5Sw3ohUnDaAnAc5sz2dxfQ3gEuxw@mail.gmail.com>
 <CAC_iWjJkAfJHp_NDXJMfNPe7OhBp6B_WBMxvwU_qHU5tamm6ZA@mail.gmail.com>
 <CAFLszTiL88dHANMHo1bK2Uj5K1-7B56_Uk8keSQTo6FUfUoOVQ@mail.gmail.com>
 <CAC_iWjJOFv1v5VPoJ2UEu1YR84i1GUdB7tEng-uqgZ+6o_XWZw@mail.gmail.com>
 <CAFLszThCONSk2v30pGDGyGjz9mz2X0mtpqGCWSZJdbAuDaT0bw@mail.gmail.com>
 <CAC_iWj+g1nMA1DrWjguP=YiQhKOmyGKyu233Eb6Zjcv0x4yatA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rFVE7GfguTf5rhNd"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+g1nMA1DrWjguP=YiQhKOmyGKyu233Eb6Zjcv0x4yatA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 20 Nov 2024 21:41:16 +0100
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


--rFVE7GfguTf5rhNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 05:55:18PM +0200, Ilias Apalodimas wrote:
> Hi Simon,
>=20
> On Wed, 20 Nov 2024 at 17:37, Simon Glass <sjg@chromium.org> wrote:
> >
> > HI Ilias,
> >
> > On Fri, 1 Nov 2024 at 05:32, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, 31 Oct 2024 at 20:02, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Tue, 29 Oct 2024 at 19:32, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Tue, 29 Oct 2024 at 17:45, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Tue, 29 Oct 2024 at 10:58, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Mon, 28 Oct 2024 at 14:48, Simon Glass <sjg@chromium.org> =
wrote:
> > > > > > > >
> > > > > > > > It is a bit of a pain to log EFI boot-services calls at pre=
sent. The
> > > > > > > > output goes to the console so cannot easily be inspected la=
ter. Also it
> > > > > > > > would be useful to be able to store the log and review it l=
ater, perhaps
> > > > > > > > after something has gone wrong.
> > > > > > > >
> > > > > > > > This series makes a start on implementing a log-to-buffer f=
eature. It
> > > > > > > > provides a simple 'efidebug log' command to inspect the buf=
fer. For now,
> > > > > > > > only memory allocations are logged.
> > > > > > >
> > > > > > > Why is this problem specific to EFI and no U-Boot in general?=
 Do we
> > > > > > > have a similar machinery for malloc()?
> > > > > >
> > > > > > Mostly because an app can make EFI calls and we want to know wh=
at they
> > > > > > are, e.g. to debug them and figure out what might be wrong when
> > > > > > something doesn't boot.
> > > > >
> > > > > EFI_PRINT() has been proven pretty useful for this. I don't perso=
nally
> > > > > see the point of adding ~1300 lines of code to replace a print.
> > > > > What would make more sense is teach EFI_PRINT to log errors in a =
buffer.
> > > >
> > > > Is that a NAK? Please be clear if you are reviewing the code or just
> > > > rejecting the whole idea.
> > >
> > > For the idea, no. But I don't think what's implemented here is what w=
e want.
> > >
> > > To track what EFI services are called, we already have EFI_ENTRY and =
EFI_EXIT.
> > > Why don't we instead, add a logging service (and we already have
> > > ftrace iirc) and plug it in the macros above?
> > > That would make more sense not to mention way less code.
> >
> > I am wanting to programmatically log and manage what EFI_LOADER does,
> > so that bootstd can present a high-level view of what is going on,
> > e.g. which protocols are used, how much memory is allocated and where.
> > So this is not just about logging text output.
>=20
> Why the EFI_LOADER only? Bootstd is supposed to cover more cases, so
> why not a generic framework for all boot commands?

This feels similar to the point I've made elsewhere in this overarching
series, why not do this at existing common points in the code path?

--=20
Tom

--rFVE7GfguTf5rhNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc+JSUACgkQFHw5/5Y0
tyy/AAv8CaK/gKPcPa+SFomJEnMTBGZ2Hj+M6gdnCrr3H8P1daU0aP38oSB5b+65
ZbSjz8BbREfWBEB7R0hdT7dgKyWtXnNU261ZBzgQOhNzcQF+zVOZ4yZvQFzUPidb
ShDNboJwgHfYAmlFmvUqtDr+m0bswQ5izpc21L1J0HfjDhsp5Mi76QOWTrfKJyF3
bPnTzp5cP9u/SeisZihI7zX5nrp2Njm12iUFmYNDP5f/z/g8D2cxoLy5kb1MyrUz
XMgij3fvJa6yjOOR0Y9f4+Z2hZU+UWzqTsWJzEV8giXLv/fM66CA/KGL+vIvFSND
yXpDWZEgy8NPHtLDYnZvvuwxsovNrSkcGOQqa45UMMsdQb0i/yGcAv2jBxQKGox/
tHvMvqKBso15fCLnU7rI4NNHsll4H783wUaWevf0BjzYbi08NKMDkbxhe7DmwXnt
7Pqkd7F4LMxcVK0GvdHIPbBGrC6wL3V6X4Lggy42tq3nPmlKOGQFBgZ4EV1yR8FJ
Gg3iFTIT
=lTsj
-----END PGP SIGNATURE-----

--rFVE7GfguTf5rhNd--
