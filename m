Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B26EA4E04
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5109783F56;
	Mon,  2 Mar 2026 15:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SwuvfYLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DA4F83F61; Mon,  2 Mar 2026 15:25:32 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D330983F30
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:25:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-463a0e14b4dso1605952b6e.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 06:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772461528; x=1773066328; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Av5yt8nrzWyzBeqR8+j3GfeNypFAAkd+nKtjj4jrj1c=;
 b=SwuvfYLfnZBEfHlv34OYSuj1eMn0dh7llgG7nertQ8JMXX16k98sj7NHnvbPqVw3bU
 Q2O7ZwzZ17rcfGRSWHrwuZLzgOHR6sF1b3KHXCRBi33MplDn66cp+hrodyTJpCOB/X6P
 NRg5PisQid8ZWuq5S2tMnHNAFMC3Lisej1S0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772461528; x=1773066328;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Av5yt8nrzWyzBeqR8+j3GfeNypFAAkd+nKtjj4jrj1c=;
 b=asMrHPBPxTlHtc3SByi9151esIt0oegdiXGYGUe/TKkk60F3aEPRMPh5it2BEVRVhY
 7k+DHJr3ZsStI5eWCD7TsxOvlt2VwcZK5ZQFNDShqy4p10bWRkIJM7Jq1V9doVa3aA+J
 2MB232QxtbkY/WYAY8SPvozrqZ5UtQIlXIWrMypc3WvV9JMef3qEbGJJmpZpn0gL3RWP
 QjzhGBFgfwf6tmG7jETVpzvHF9pw7PD4sG8Pe6kSMUpavF6W/e2WtcSPKsv78Jm3dz7u
 PLDMK5dKmRZgmptjiOYm5OTPZ1JgrWYMjX4WFDmPmPwLldviU2ce1RLz9UucB9Z0FcnV
 mrtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWareL/OL8KYztRNlZaJtX4pbedoseixh691pqQd0bORkSkS6V60C2Knd9sRqWYQ9XBcsJ7tGQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwuhmNcTyTbwL05d1aStIOHH8wRKG3FS1JSlQie0TLOcNzeLK14
 ITqLQ5CRzIsyoqKuGSNPIPMGE8jj67NLMGp33sJboMh9DwjGoYSwGhPgcPBou7HMLJE=
X-Gm-Gg: ATEYQzybvAM6fvrJubtu9QUiDiLn5KtaRq1fa3Ferf90OSaVa1ms7Yxuv8O+3zJJd80
 Bj/HFeEozNp72vNtIETB4Da/CiaG0/eqzAMF+sgLqKs43HNdIDQEpH/QPvRoMy1+4jZe10VTTdx
 waUh5zeXcN6L2s5tpSnQKXX6x3deVJ/veg5eXEMXcgIroEDtSnun+Mfq0G5f0nOzndsvoPqfSQR
 oVG7nnR1PT753uOTET2zSAba9uX0anXq+FzKC6Nq+BVRTT3pt1rMswJ1y84Nr5Xsk1Z7ijGdxxz
 Qd0iGk1CPLTOCW2wBH4IcTWFlWL5+KjUcIvxBcRpOJbPBrG1sGzebZreILgkBB5YScQaznqtO5M
 Mvn3dab6iJ4oeovpW3gw6qX39LgMFsPRrPufcs3QLiTHuNUNotPRSkhPGARi4U/rum8BnjP5S3z
 FhzSHhExju4bZIhv+3u9WnoOp2f8yCetY5HddWYkQ+ReC/a1EHiLdPmgNZVIrROaDHCEpB4KpO+
 kJJEcdPGjph5Ss/qwPd9l1xwHvhDHlk2FKDeBM/m1ysHkL0r7U=
X-Received: by 2002:a05:6808:1523:b0:45e:bb69:4e99 with SMTP id
 5614622812f47-464beca6fcamr6357610b6e.47.1772461528292; 
 Mon, 02 Mar 2026 06:25:28 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41668233c4bsm3251982fac.19.2026.03.02.06.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 06:25:27 -0800 (PST)
Date: Mon, 2 Mar 2026 08:25:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>,
 Yang Xiwen <forbidden405@outlook.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de, nd@arm.com
Subject: Re: [PATCH 1/1] net: do not use non-existent CONFIG_DM_CLK
Message-ID: <20260302142525.GB1388590@bill-the-cat>
References: <20260225061426.45981-1-heinrich.schuchardt@canonical.com>
 <45e3b935-6e0a-471f-b87f-6c03edd4f237@arm.com>
 <20260227144909.GR1593142@bill-the-cat>
 <99c81520-9f2f-43b9-81d6-c60fab345533@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Gw/+xfO7AEBf/OxD"
Content-Disposition: inline
In-Reply-To: <99c81520-9f2f-43b9-81d6-c60fab345533@arm.com>
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


--Gw/+xfO7AEBf/OxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 03:17:39PM +0100, Jerome Forissier wrote:
>=20
>=20
> On 27/02/2026 15:49, Tom Rini wrote:
> > On Fri, Feb 27, 2026 at 11:03:32AM +0100, Jerome Forissier wrote:
> >> Hi Heinrich,
> >>
> >> On 25/02/2026 07:14, Heinrich Schuchardt wrote:
> >>> For enabling the clock driver we use symbol CONFIG_CLK.
> >>> Select this symbol for the HiSilicon Fast Ethernet Controller driver.
> >>>
> >>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >>> ---
> >>> @Jerome
> >>>
> >>> I could not find any usage of the drivers.
> >>> Should they be removed?
> >>
> >> You mean no defconfig enables them? It could be that some project
> >> downstream depends on them though. But do we care if we don't build th=
em
> >> upstream? Tom, what do you think?
> >=20
> > In this case, there never was a "DM_CLK" symbol, even for driver model
> > using CLK, it should just have been CLK to start with.
>=20
>=20
> I think the question is more bout HIFEMAC_ETH and HIFEMAC_MDIO which don't
> seem to be used anywhere:
>=20
> jerome@builder:~/work/u-boot (master)$ git grep HIFEMAC_ETH
> drivers/net/Kconfig:config HIFEMAC_ETH
> drivers/net/Makefile:obj-$(CONFIG_HIFEMAC_ETH) +=3D hifemac.o
> jerome@builder:~/work/u-boot (master)$ git grep HIFEMAC_MDIO
> drivers/net/Kconfig:config HIFEMAC_MDIO
> drivers/net/Makefile:obj-$(CONFIG_HIFEMAC_MDIO) +=3D hifemac_mdio.o
> jerome@builder:~/work/u-boot (master)$

Ah, OK, sorry. Yang Xiwen, is there a platform that will be submitted
upstream that enables this driver? Thanks!

--=20
Tom

--Gw/+xfO7AEBf/OxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaWd0gAKCRAr4qD1Cr/k
ChkeAQD4ezUlpUO1dK3wzVPkjNT/ctGTn+0mqEjkkuEpggDynwD/TKoVnF//o+wm
2ABdDAH+TctoX4jOB077FLfiBKsmxwM=
=mYqp
-----END PGP SIGNATURE-----

--Gw/+xfO7AEBf/OxD--
