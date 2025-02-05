Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1153C02196
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9638092B;
	Wed,  5 Feb 2025 22:31:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nGEeSmGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA27F80562; Wed,  5 Feb 2025 20:17:20 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABEF800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 20:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f9bd7c480eso97747a91.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 11:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738783036; x=1739387836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DQhRDlH9sx/tdH2uCfBCCEGw/8L0es9d9VrvboxvP8A=;
 b=nGEeSmGLisk8NDSJTedLrbaEXcZ7yGJFA1ETXcJPWRnceK4YrCCGqMywXsVlNzWbkW
 KFu8ltMpmjbIuH70CSBKbNfxG2HN/NnjhcIj9c1ROYtXLe1zKdGA7PsGBECvshE27zaG
 mjyBJ3LRZ5vMzmL3nnACdypVOrm5TqSeHe6iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738783036; x=1739387836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQhRDlH9sx/tdH2uCfBCCEGw/8L0es9d9VrvboxvP8A=;
 b=LQOZxo7BMFIf4k4993y7AMIrROg2MyBPDBVc5bhHnovYzcTb/K0hMYzx6hS8xNKPQU
 WyQ6nbw6QbWG+srQwAoLK484VZciK/KkHiGczOtiwJVGQ/sVCAXx02ElaqO/R/1UudO2
 mv5udf3KYvdNvxn7slFd7qpx2Fa10bZrkZ0895vWLJ9HjVSBkjezzXAZo/ihiLK3GaWZ
 /5hs2vVW5ocmoRYAmp644/HuOeV4+MlWPvs2xn/LeW/XDqc2piZ2/yK55joiOMxudufR
 OgDNdCzxoaPLFYVhxHU4vo1I/nh4fF4lLU62gI55lQxQ0y/87xTim5rJNXzxYis+uGic
 x+zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqnmiaPvZNzGi4F+F4mPExy96gTL0MNv0e2y8zc9I59B7WCFOGZsJtzqlLfeKqQ3iEuC+zCt8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzb+erWprPfk5khmboGJ0/Wus8YF9qtIdKXnKf1zVqJ8EiO+y0l
 5AI26wFDvhRR6uImWV1uAASyehoeP/T5/xPwg9CNgFXYZViXjfEEfmG6pSB4KIo=
X-Gm-Gg: ASbGncsuwuDM7jfFDmdrB8e1CwROtAfBPb71GlO9eCst/bJphMrHlfsjjULlrvtrrZA
 j4XtnBHjGQ1N3GokuhYOB5oyuNiodR/rAGYvSx3fDJiOoGUyRDLMEf9PbN+AT240UDOOWZLQw0b
 liX3h0+MF93XCXxaH592V+NhWgzGEJ425Qr1AvY83M1/mheS/yQQrNp2rqKJxubivf0sa6X/oVJ
 lhZzIJKT0GrGphYQ5g7Vy2qAyLqUeCsaQ2jyQCtLZlPV7XGHQbI2ueZ+nERCENw+6N9C+WcZHte
 p41YZjd10jwBhWo=
X-Google-Smtp-Source: AGHT+IG1mWsrombRNLC22oJC0od1NIPn2wmSEbYusV5OXniCWFHDvrhM7TI3KxBBWKrJGHO1cXuxBg==
X-Received: by 2002:a05:6a00:140a:b0:71d:f4ef:6b3a with SMTP id
 d2e1a72fcca58-7303521c73fmr5972905b3a.21.1738783036223; 
 Wed, 05 Feb 2025 11:17:16 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe64267aesm12823951b3a.47.2025.02.05.11.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 11:17:15 -0800 (PST)
Date: Wed, 5 Feb 2025 13:17:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, xypron.glpk@gmx.de,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefan Roese <sr@denx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 6/6] arm64: Enable RW, RX and RO mappings for the
 relocated binary
Message-ID: <20250205191709.GA1233568@bill-the-cat>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-7-ilias.apalodimas@linaro.org>
 <ec13d51a-199e-4765-85e2-c74d4c2da8c5@linaro.org>
 <CAC_iWjL4WYhSYLDP_Jgw=MJP6a7D8SRhXH7+NCePfCHMJH+Stw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DpHKDBNbQ38cdDN1"
Content-Disposition: inline
In-Reply-To: <CAC_iWjL4WYhSYLDP_Jgw=MJP6a7D8SRhXH7+NCePfCHMJH+Stw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:31:05 +0100
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


--DpHKDBNbQ38cdDN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 12:31:33PM +0200, Ilias Apalodimas wrote:
> Hi Jerome,
>=20
> On Wed, 5 Feb 2025 at 11:57, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> >
> >
> > On 2/5/25 08:16, Ilias Apalodimas wrote:
> > > Now that we have everything in place switch the page permissions for
> > > .rodata, .text and .data just after we relocate everything in top of =
the
> > > RAM.
> > >
> > > Unfortunately we can't enable this by default, since we have examples=
 of
> > > U-Boot crashing due to invalid access. This usually happens because c=
ode
> > > defines const variables that it later writes. So hide it behind a Kco=
nfig
> > > option until we sort it out.
> > >
> > > It's worth noting that EFI runtime services are not covered by this
> > > patch on purpose. Since the OS can call SetVirtualAddressMap which can
> > > relocate runtime services, we need to set them to RX initially but re=
map
> > > them as RWX right before ExitBootServices.
> > >
> > > Link: https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-=
v1-0-450ccdadfa7e@cherry.de/
> > > Link: https://lore.kernel.org/u-boot/20250130133646.2177194-1-andre.p=
rzywara@arm.com/
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >  common/Kconfig   | 13 +++++++++++++
> > >  common/board_r.c | 20 ++++++++++++++++++++
> > >  2 files changed, 33 insertions(+)
> > >
> > > diff --git a/common/Kconfig b/common/Kconfig
> > > index 7685914fa6fd..dbae7e062b0a 100644
> > > --- a/common/Kconfig
> > > +++ b/common/Kconfig
> > > @@ -914,6 +914,19 @@ config STACKPROTECTOR
> > >         Enable stack smash detection through compiler's stack-protect=
or
> > >         canary logic
> > >
> > > +config MMU_PGPROT
> > > +     bool "Enable RO, RW and RX mappings"
> > > +     help
> > > +       U-Boot maps all pages as RWX. If selected pages will
> > > +       be marked as RO(.rodata), RX(.text), RW(.data) right after
> >
> > Space before (
>=20
> Sure
>=20
> >
> > > +       we relocate. Since code sections needs to be page aligned
> > > +       the final binary size will increase.
> > > +       The mapping can be dumped using the 'meminfo' command.
> >
> > OK
> >
> > > +       We should make this default 'y' in the future, but currently
> > > +       we have code defining const variables that are later written.
> > > +       Enabling this will crash U-Boot if that code path runs, so ke=
ep
> > > +       it off by default until we fix invalid accesses.
> >
> > Not sure this needs to be documented in the Kconfig help. Perhaps just
> > keep a patch ready and send it early in the next release cycle for peop=
le
> > to test and debug?
>=20
> I'd like people to see it and try to debug when they see random
> crashes. I think it's easier if we document that here until things are
> fixed.
> OTOH i don't really mind whatever people think it's best

We should change the tone / emphasis I think. Something like:

Enabling this feature can expose bugs in U-Boot where we have code that
violates read-only permissions for example. Use this feature with
caution.

And then we should encourage our more active SoC maintainers to default
this option to being enabled after testing out a few platforms as long
term it should be on by default but initial testing has shown that
assuming most platforms are OK isn't a good idea.

--=20
Tom

--DpHKDBNbQ38cdDN1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejuS4ACgkQFHw5/5Y0
tyyt/Av/az9RAGQZvCoQHfEkfUZqPSxyrGJdsKjDsff4eXGWSpsdK4LoHcoBnAOg
DTWYusZlQ+PoxcnOZmQRRwc8/HeyZYwwJbTBcKpiuC6tek/NBJKpnqLpgezIU+4m
w7OZFeR6qXttjgxcaQaeDkLJP7MIrO/EOS0XzPgXyrGcdz+a9Ld76sAskLWy6gom
7UCDrP8r530/xh2DCXursjsxX0rz7dUNPSannSgmx8hYmlqml3sJAkBG52MBPIgb
/ZMx2UzgaeiR1+qZPxM6K/0KohOMBuKOkM3oxsVpmmMMX+d7uzvNN6XqEnoN1AbO
OLKxJSMiifmgCLGp5i8Fe3nrTqqQLLh0UTfQWlfVDUAj68M3Ld9TBsrLilNZfZV2
43wM5WBzho4/2TkZZP9cNXAu7XUTZYvaKE1YGeZKhZKPMS4mhweAN2qYu7bzRcoF
xzeeacEgPgZA/H5jVNyCqc9lX4hmwdEgSiJlJ61y3lRQRL5s7eSN+7xz/zYEyf75
4QDcZZwO
=rPNy
-----END PGP SIGNATURE-----

--DpHKDBNbQ38cdDN1--
