Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D31E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 07:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E98286AB9;
	Mon,  9 Oct 2023 09:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696837773;
	bh=QosWndO6MTkX6ouxNhTw3/r2mVYQIaYXT1IO6Xdr1oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SZuBo9mgYfG0emN7ejiJUxAzoNRynkmFibi1FUYSYwiTQcTkie3OYsql8u/wdq25H
	 DDS+6wgfDuV4CsFMJBY0UQgNPwBbl7FG/S4kf6IlGBxuB+idpjf2mlSdiBFJKKpdp9
	 CxbBogVehPnOoIUCVAPiY6Y0F+95kxBVkFpJL6+R2Nz6P1OBXLz/+JMwNdgD4IcwCc
	 ko8dBk/pPmOuFldZdYua4hPc3Zxlh9yGmHC0hWLkvkeD90tm/ae16iTc7wf6W6unYj
	 Gj9+qbUhNQ9WhRO3U0Y9192dfiwOIbPlv+QlLyk3Sjiz1hROKVoLXKaRNqxvf1G9ki
	 QOqI75BAVwMpg==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 223E586B3C;
 Mon,  9 Oct 2023 09:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696837772;
 bh=QosWndO6MTkX6ouxNhTw3/r2mVYQIaYXT1IO6Xdr1oc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kDRm4bzv+xCvHur6S6G966cY9v6dVaIOaIX7kYuneveHQm/VXhMBvFZlvVQX/aPL6
 K1e/PH/wAiCnc2gToY7VLqE+tO9t7vDl/+4VVIs9XAMnwOBt+GSv3MCzD/Iu4lfUHr
 H6jJbwNOuNeVudHYTGkrMOaQcAg195VOTcffZP0P0GJOkQG+De419ID5QvulDpvoAP
 tfo/lOG9dJLTpYdhUYre8Xzf7SF3juILTmXPvvpvxUzFE+Es3cAoiEVcW32Ismk81f
 ukUtRwwctwZnvqzuX2L8gs+ZU2PDALZ90Z2O4Fxua1zjRnQbmJDINJ+z4FCQqin/+Q
 R/0wTVlwZXr4A==
Date: Mon, 9 Oct 2023 09:49:24 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Alan Kay <alan@londelec.com>, cody@londelec.com, Stefano Babic
 <sbabic@denx.de>, Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH] mxs: Don't enable 4P2 reg if mx28 is powered only
 from DCDC_BATT without 5V
Message-ID: <20231009094924.56042353@wsk>
In-Reply-To: <CAOMZO5BJyoxUTBuygdL7tOyzJfRGJT1BQHJ_r0qAD8jYfC+CbQ@mail.gmail.com>
References: <20220830174932.96360-1-alan@londelec.com>
 <CAOMZO5BJyoxUTBuygdL7tOyzJfRGJT1BQHJ_r0qAD8jYfC+CbQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6P3gowXHTydSr8xiqbPLLe+";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/6P3gowXHTydSr8xiqbPLLe+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio, Alan,

> Hi Alan,
>=20
> [Adding Lukasz and Cody]
>=20
> On Tue, Aug 30, 2022 at 2:49=E2=80=AFPM Alan Kay <alan@londelec.com> wrot=
e:
> >
> > mxs_power_enable_4p2() was added to mxs_batt_boot() in
> > 'commit a0f97610757d ("ARM: mxs: Enable DCDC converter for battery
> > boot")' to enable DCDC converter when board is powered from 5V and
> > has detected sufficient battery voltage.
> > This involves enabling 4P2 regulator and there is a code
> > in mxs_power_enable_4p2() that disables VDDIO, VDDA, VDDD outputs of
> > the DCDC converter and enables BO for each power rail e.g.
> >
> >         setbits_le32(&power_regs->hw_power_vddioctrl,
> >                 POWER_VDDIOCTRL_DISABLE_FET |
> > POWER_VDDIOCTRL_PWDN_BRNOUT);
> >
> > In case the mx28 is powered by the 5V source and linear regulators
> > are supplying power to the VDDIO, VDDA, VDDD rails there is no
> > issue.
> >
> > However if the mx28 is powered by the DCDC_BATT source only without
> > 5V, disabling the DCDC converter outputs causes brownout power down.
> >
> > The proposed solution is not to call mxs_power_enable_4p2() at all
> > if the mx28 is powered by the DCDC_BATT source only. There is no
> > reason to enable 4P2 regulator in this case and setup of all
> > registers is done in mxs_batt_boot().
> >
> > Also there is no need to enable 5V brownout in
> > mxs_power_init() in this case.
> >
> > Please consider if this is acceptable and I will submit a proper
> > patch.
> >
> > Signed-off-by: Alan Kay <alan@londelec.com> =20
>=20
> Cody also sent a fix for this issue:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20230703163340.101490-2-=
cody@londelec.com/

Isn't this already addressed with:
https://source.denx.de/u-boot/u-boot/-/commit/79230640cb4fb780e2be9bb9a47b3=
1976b18cac4

Please also look into the recent patches for imx287 (xea board for
reference):

tig -- arch/arm/cpu/arm926ejs/mxs/spl_power_init.c

At least SHA1: 65b9b3462bec2966911658836983819ab4e4823e


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/6P3gowXHTydSr8xiqbPLLe+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUjsIQACgkQAR8vZIA0
zr38Twf/c02uUVJLAS/WTqzhvRZsxv9Wolexu0mVcFTF1HK1E4709/Y4AxLusNGs
cXUQCiABf/DGb8VjN4f+RCWU+MjGus91dgmXRHV28vEkywlPmxR/ZVhdqOJTrFrh
bSMblF0PiRDvbcgwpyzuqOf64j32skc444OGYTfQCWcuitCpusJYt350Y94FUsD3
yCS3PVKiHQekVv+BcvwpE+u4zkR4KIlXOq6jEw5jx7lVDI6YtGf9sjnD1DaAC+wG
AyACbFH0HlJSllHjuGaEGa9sm8+lltvi1zy0KJk0KfERg6MPGfY6DHjFmD9bSXZj
26Svycy8knPKl+WyzoWRgAvrINn2jA==
=caIG
-----END PGP SIGNATURE-----

--Sig_/6P3gowXHTydSr8xiqbPLLe+--
