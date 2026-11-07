Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71F606A32D
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kwj1mF7l;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pWPQOHV3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB8CA816DE;
	Sat,  7 Nov 2026 14:42:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6qe9xJ12voP; Sat,  7 Nov 2026 14:42:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 032FE816D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062576;
	b=rZiK5z9XlW3mfPEQ1NsXatvOzupDtJhQobJYqsLchBTVY4R5f5+pAUhzr9pYo4ebgAA1
	 geNMdeSRp9qrSyhxw+Mb8aEbpgvcpi3gNgvM8QEPS+j5oIywSumdr8kV/Ic8TgsULbcIP
	 +02IJ0snWfXd0eFrcwWE/3lUJwIZlEvOofcDRtG1mqhCmUnlzPI7UMHOId/Hxkd7rYGmy
	 +ccEvoFAY4vEHDCTHLF1kl1oqbgylUICiQyVDDppZ2mcamUeiwQHaeMbR81JOqAXfqEsr
	 HroksmtT/sw77cndyrfK9ThH7tZbZWob4isxzYJqqxfwC8Nq+wnDt2fHR3ThnWwC59Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JRTRUuuCc3sAfyQr0zuIGQRSc/T7cVA1oyDLmkCwlKc=;
	b=g56GGogau1vzeKtognbzriWVdMAMv3eWrtAUvkuTlcpEaxseh3doo24W9cg5FmzBwz3f
	 dOgBNk/F0WPjeMFU0epJoxCT+7mk6Iw4u7oRIzn+N2PfS570l/yQzDRe1vHPaWgD4iwCB
	 VEVEjqTwDBrNIcD2K+hcXW8CmCYABM+it+DO024PrCrFCbURuijcRCTP7qFhghCtaoKC9
	 qBTD5hkRwU3R8c+BzBW828GZ79bHWtgkbusB9e6xv6MY6Bg9R19nUwbJ/U8XWn+UCgU4Z
	 Zp++CSO8EQomZep2fYy6NjXrgDVMtAH8V4AhQU5lXBRf0ttp7wzKiK7m3OZp5bJiO5Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062576;
	bh=JRTRUuuCc3sAfyQr0zuIGQRSc/T7cVA1oyDLmkCwlKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kwj1mF7lu/WigijnhBRgnQNeFmXQTpZwDSiRhkSjCz9Q7ZulHF1D/FqfRMlmA/uDK
	 vNqsNvywOMqrYddQn+NrJamE5LhBEnVrY3t1R9ZgvnnnB/QUUkI1jiXln3Tb7D3JkS
	 i5ZjRPMU3dlA75LTKvBomoM3nSh0DePiBJd1Au8LkB0Vn9UuS1Fs0v5kKa5DVsDd+d
	 zUepbjy0hKCcz4Ry7ostqvhaGM1ud6UWOCddkmkCW7qP6j0Vw2zBBf+tjQt53KIW/k
	 7tPf926oAOlf8i9/pBIVvpkkV5YkLRg+hKhjuHNGjZVZdFb8H+8jASRzMtAt0u4LCc
	 exGMXp0KU8HmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 032FE816D8;
	Sat,  7 Nov 2026 14:42:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31DB534D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13EE74070B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:42:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5x5o-9vcwWwA for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:42:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F895406C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pWPQOHV3
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F895406C5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:42:52 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4b190cdc9feso945869b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794062571; x=1794667371;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JRTRUuuCc3sAfyQr0zuIGQRSc/T7cVA1oyDLmkCwlKc=;
 b=pWPQOHV3WWg/kUIn3mE9lrfqqu78GbwvCqRqSMoOLERwGeHU57igqHvseF0P06jMZc
 6b0JteugQr2CVIwFxXBiT+pwuJQHGFsb1YL+wmYvxBxaRFpgVmoCLCpxGf50N4FS/8wI
 1sgwz+GYALtiZoHJyHUVGnc+HE/KUlP1Wm9A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062571; x=1794667371;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JRTRUuuCc3sAfyQr0zuIGQRSc/T7cVA1oyDLmkCwlKc=;
 b=H2ovjl/LHiGqhPnUG4h/5HiugLHklWq6TAHxpMOgso7ctXTYAOsIugARNWCcml9mC1
 vRdmcSTyODz12NqKrLls2DQ5nskwLCJI4+B/Hjxl+Zu29n5V5XfIsYNXztIFYK2yQ+UO
 c+UwrYfIBn/DXVOC4OA0ACazDmz8sK4LfKqGQqlI/ILI68ZhFxLIcoqA1g2OITpL5m/g
 6XsyTMybUqmcIldwQ5oVkAf7kh38DhOipqx5k77ETw5apLgetxLMXsgqpFOjNJPNKi9p
 +vSulR40S8GJlKh4rysgWJGcg/WvqTf2ZeTdRyPeywsA2nIkl7xJG6o4MOHNeD02ACLh
 Jihw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWY3U9+rKpBupnIUo7buhSUzpU8Kpu63sMYV+z4mZCbe5nhxtWxHEApazrOLGKof7oGu3ZzyE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/nsqLjru1ZRU58am2pl5orRa1514KfA13Baspka2KX4VMkfhQQ
 KEGjV9hlg79k/RaQQSMF96bq3aaxNILfZwsZEfPjlpIBE8vatXYaoxMkrnA/cpXzqr0=
X-Gm-Gg: AYBFou2WjIwYjjiz9dL3hQt5tMkvjus97rXk96aOEPhYibiBu2aBU+hwcElUYFhrhRe
 KRUgfz0iz7a69dbrYguljXq+5srtntxu5+iGfA2G2EmbH33HFvmPg4WETMdCMREDVoFhy3aW7zE
 MLbiUZnkpmD6lkE2g+1zyifZ81dSnu5vbnJxRSCMeaR5Pdfc2u6dtzjtreSulOji30MABdav1hh
 g9zZPBNfImSG1hNWNGWYHtDfBZ4cBN5CQeW64+Rl74W4SODkfGDU3pJ1tTCDMmkwuWCWDbQrpe0
 8OHSxLnHdsmM48LgElIqg7cNKXRMp3WeU3Lez1vg3QTgeY4Ce4A9qGJz20c4qWgW/0FuHnFs0dL
 OF5mExWF11/+yZZ/SCHItNKPrNyBb+0AHiMQarTldVviHmZyFupvO7TAAvBCso1LRpO4TDFMBgH
 PeNf4dW2b1cqdBE0Ep4JPp0/F4+73RkrMPL2a0jLxD05k0puf1Y9mSTdIrBNZAahsAoIHfp6R0l
 MhCyhEQw++zPJkgOYsZScrZUu8uWIi094t3OkesJJ4/Y6iBRfGl51ItNB4wTvkr/gH9nT/MqO+x
 0K1EhJ6cIvfx7aagjKiZA1jLJF63p94pEdWX7cH/0Q5qjU/UpaLFEcT4zUJSRAkZR7VGWLA1QFO
 Cm2Pcxe7pchImdLeVJIzK6w9AQ/zTEV15GcDJ7ZLjNqjUv2hQY+Jzm72sRT+EDT9y49Ur4SSJeo
 EofqfzeGNlW2qT3YHE/tmwUiUly8xg4Q==
X-Received: by 2002:a05:6808:10d3:b0:4f5:d873:aaaf with SMTP id
 5614622812f47-567e1440dfbmr4931721b6e.14.1794062571535; 
 Sat, 07 Nov 2026 06:42:51 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad97a59797sm4404439fac.13.2026.11.07.06.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:42:50 -0800 (PST)
Date: Sat, 7 Nov 2026 08:42:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Yannick Fertre <yannick.fertre@foss.st.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/33] Add Engicam MicroGEA-STM32MP257D-RMM board support
Message-ID: <20261107144247.GG3741582@bill-the-cat>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104192118.GD1164024@bill-the-cat>
 <CABGWkvqisJBzV=tRQrhZ87evgF6mTff+dJvO1LVwVQC-YX=DpA@mail.gmail.com>
 <20261105144835.GM1164024@bill-the-cat>
 <CABGWkvqoNBvjynykG-Y7V8BP5OTP4TOq4zwkAwSQ_P+e8-6JPQ@mail.gmail.com>
 <20261105172616.GN1164024@bill-the-cat>
 <CABGWkvpbBG2zrPDz7Fx766TdE07YHae1KnJ-+ReqGF2CRzyydA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HN1Pm8LbG7fUecaG"
Content-Disposition: inline
In-Reply-To: <CABGWkvpbBG2zrPDz7Fx766TdE07YHae1KnJ-+ReqGF2CRzyydA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--HN1Pm8LbG7fUecaG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 07, 2026 at 03:28:57PM +0100, Dario Binacchi wrote:
> Hi Tom,
>=20
> On Thu, Nov 5, 2026 at 6:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Thu, Nov 05, 2026 at 04:39:17PM +0100, Dario Binacchi wrote:
> > > Hi Tom,
> > >
> > > On Thu, Nov 5, 2026 at 3:48=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > > >
> > > > On Thu, Nov 05, 2026 at 08:12:07AM +0100, Dario Binacchi wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, Nov 4, 2026 at 8:21=E2=80=AFPM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > > >
> > > > > > On Wed, Nov 04, 2026 at 09:49:33AM +0100, Dario Binacchi wrote:
> > > > > >
> > > > > > > This series adds support for the Engicam MicroGEA-STM32MP257D=
-RMM
> > > > > > > board, with its RGB and LVDS displays and the FWU A/B update.
> > > > > > >
> > > > > > > The first patches pick the board devicetrees, merged for Linu=
x v7.4,
> > > > > > > from devicetree-rebasing. They can be dropped if dts/upstream=
 is synced
> > > > > > > with v7.4-dts first. Then come the fixes, the refactors movin=
g the
> > > > > > > STM32MP2 environment and FWU support to the SoC code, and the=
 board
> > > > > > > support.
> > > > > >
> > > > > > What's the status on upstreaming all of the changes you're putt=
ing in
> > > > > > the -u-boot.dtsi files? Thanks.
> > > > >
> > > > > The -u-boot.dtsi contains:
> > > > >
> > > > > - U-Boot specific nodes and properties: the environment partition=
, the
> > > > >   FWU metadata and the bootph-all properties.
> > > >
> > > > bootph is to be upstreamed,  I don't recall where the FWU stuff end=
ed
> > > > up, and I'd need to double check the specific environment binding y=
ou're
> > > > referring to.
> > >
> > > I added the bootph-all properties to the -u-boot.dtsi because I saw
> > > the same in the other STM32MP25 boards, e.g. the stm32mp257f-ev1. If
> > > they should go to Linux instead, I will send them for this board.
> >
> > Yes, there's many examples of needing to upstream this still.
> >
> > > The FWU metadata node and the environment partition use bindings which
> > > are only in U-Boot: doc/device-tree-bindings/firmware/fwu-mdata-gpt.y=
aml
> > > and u-boot,mmc-env-partition in doc/device-tree-bindings/config.txt.
> > > They are not in dt-schema yet. Both are also used in the -u-boot.dtsi
> > > of the other STM32MP boards.
> >
> > OK, thanks.
> >
> > > > > - The RGB and LVDS panels, with the LTDC and LVDS endpoints. Thes=
e are
> > > > >   already upstream in Linux, but in two devicetree overlays, one =
per
> > > > >   display. Since the display is selected by the "display" environ=
ment
> > > > >   variable, which is stored in the eMMC/SD and is not available y=
et
> > > > >   when the U-Boot control devicetree is set up, both displays are
> > > > >   described here and the board code keeps only the selected one.
> > > >
> > > > You can't detect and apply the overlay instead?
> > >
> > > No, the displays can't be detected. There is no EEPROM or other ID on
> > > the board or on the displays indicating which one is connected. That =
is
> > > why the selection is left to the user, by the "display" environment
> > > variable. Since the environment is in the eMMC/SD, it is only loaded
> > > after relocation, when the devices are already bound. Is there a way
> > > to apply an overlay to the control devicetree at that point that I
> > > missed?
> >
> > Maybe? How far down the path did you try going for using overlays here?
> > And then also, since both of the overlays are upstream, is there a real
> > penalty in applying both and then doing the fixup you do to remove the
> > unused one?
>=20
> In v2, which I am about to send, a new option,
> CONFIG_OF_UPSTREAM_CONTROL_DT_OVERLAYS,
> applies the upstream overlays for both displays to the U-Boot
> devicetree at build time, and the board
> code keeps only the one selected by the "display" environment variable.
> The panels are no longer described in the -u-boot.dtsi.
>=20
> As for the bootph-all properties, I sent them to Linux [1].
>=20
> So the -u-boot.dtsi now contains only:
> - the environment partition and the FWU metadata, which use U-Boot
> specific bindings
> - the bootph-all properties, until [1] is merged
> - the LTDC "lcd" clock, until the pixel clock support [2] is merged

Thanks for doing the rework.

--=20
Tom

--HN1Pm8LbG7fUecaG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau845AAKCRAr4qD1Cr/k
CqIkAP4zborkxlPQuE2wh5v3kdT830o7TKoKsmE1NHwd5C7WhAEAj8d9QcV2b0rp
OFP0zyabVtoowt3/MLfmwT9KjaPV/AM=
=SAEG
-----END PGP SIGNATURE-----

--HN1Pm8LbG7fUecaG--
