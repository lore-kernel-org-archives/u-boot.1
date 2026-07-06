Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8750EC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 14:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D899D846FD;
	Mon,  6 Jul 2026 16:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AYr+SSp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D260848BF; Mon,  6 Jul 2026 16:59:13 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF9A846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 16:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-69ed219d3ecso2564451eaf.2
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783349950; x=1783954750; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zSqHyr9E7eG0TZN4HjU2zoixa7tYU1Ui3+wq5xDwAok=;
 b=AYr+SSp1cOE6CIy+Jfp0ktJLGZ//4Oe+0aRPklC2RmiO6LvAjBjvIGfWelVjBLNS+h
 ZEWBH7jYvzBE18jP/wzqdjWyzwcJHArfn7TzeEysbet3XOGj2u6g9KkutBKSelyvwfvL
 6DQCSwM4NXLVpqc98ch/Acw16mGwQ8bU8c/e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783349950; x=1783954750;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zSqHyr9E7eG0TZN4HjU2zoixa7tYU1Ui3+wq5xDwAok=;
 b=R5JEOq1xHKqfNnWCcS5KpvBhOenkTyDIpmvTMqzLm00vlhMLReDm/veBgfVxtNdTOR
 oQt0ekIOPJnAL8Q3Z12Q2AHYeo/WiLqFtOwUCL6ysLAFqMWC9DF7ebp179P7yrAQ/bAP
 3N+wWFz9Ee7LKJLmEsKZi3GNQ3DFEaZtZviSchkx5Lq4Jzrlkj1/QMK5/KOunltDGSEy
 mglkXd58vP9T9sUDUBsE/dQ8DYKT5VB425VZi6yl+Aaf+UCI69ig+ww5ps0rPWh8Nrze
 +vHRvqADDerWOFbE9xJYleHAGuTYmicBQ1Fz5PSzh0kH8ZnsIcLF5COkZu/IfjrOTtbT
 II/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NIdVSMmeRxUNG92HiLr88v5a0/ThJWICU7oQsPSlI833qFEIzPGEuHVqiPJxzzbN3RsQTNcQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxmQSDrJcvZEQD+S0cLL5EgKiyzWYM9d9Sjjo1Grq2QLmrr51lT
 +RR9cTS6ixX/wCVOZuggi5v6D6fjctRsUox2n5rZNO0PDPNOMrI4+jZtOXN2aFyr3Ac=
X-Gm-Gg: AfdE7cl+PIIB0DnEwXyKyi+Mp3729gwzg2PsAPO1oDyps/gZ9q0KG4+QJuIDGQ40ixt
 uOfiNs5wFLph73w8oIbLnVavnZaV/vv8h2vN/cESRwt6YfRENgNrev2lOi5zy+2KLSLUg2EvVHj
 dsUA67LHh9gNtabI4v7eHSCsZZbE5AVejulihOf9cuYpsw1f6AQiahqibtWOetgt9TJWgeIhMud
 BNPLjKt0DlqmmBI7xbLlkL2D5hyO/Ymt4HaTjAQ8D5QRQ1LnXKh9eEApOcmuihHwsk6TlplkBd8
 Ek7yM1A1wqVZgP+/nbnDPWKoyjsedgJKjaN50IMYY818iv1x1LWbhKlC54kviT3hoUHPLLbdjHC
 ok/C8b6wJXmIExgocCHfWuJx0zYPTq/k2BAHRAVCsR+6NnLhYxoKy2A7abL3j1+gVaYC4BBkJO9
 Ascjz7H6k8PEEXzW2y4/k0vu8M5YIoApTLvpjod3fFVb78fCNEq/wDiMt+kAcz28RT2GO7OWKL3
 wBhudy13TsQAIeiFjAhqXHU8wis7fydOK8hpQ==
X-Received: by 2002:a05:6820:2205:b0:6a1:50eb:2121 with SMTP id
 006d021491bc7-6a3556c8b12mr502519eaf.69.1783349949874; 
 Mon, 06 Jul 2026 07:59:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm10669780fac.17.2026.07.06.07.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 07:59:09 -0700 (PDT)
Date: Mon, 6 Jul 2026 08:59:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] imx93_frdm: Add OP-TEE device tree node
Message-ID: <20260706145906.GW749385@bill-the-cat>
References: <20260706-master-v1-1-25bae88d130a@bootlin.com>
 <CALeDE9P-5NG_a0T=dXB2KQcPCGJoSVeRXk6yQPXLesws=ypK6A@mail.gmail.com>
 <DJRKOYKA0DDQ.PI5Q86TGLP22@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uptbWlynIhR7I8Fp"
Content-Disposition: inline
In-Reply-To: <DJRKOYKA0DDQ.PI5Q86TGLP22@bootlin.com>
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


--uptbWlynIhR7I8Fp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 04:54:17PM +0200, Mathieu Dubois-Briand wrote:
> Hi,
>=20
> On Mon Jul 6, 2026 at 4:14 PM CEST, Peter Robinson wrote:
> > On Mon, 6 Jul 2026 at 13:34, Mathieu Dubois-Briand
> > <mathieu.dubois-briand@bootlin.com> wrote:
> >>
> >> Add missing firmware/optee node, so is can be both used and copied into
> >> Linux device tree by optee_copy_firmware_node(). This is consistent wi=
th
> >> other i.MX93 boards.
> >
> > Shouldn't this be going to the upstream Linux DT at which point get it
> > when we resync?
>=20
> I don't think it should. Or maybe it should, but then we are doing wrong
> things for other boards, particularly for the i.MX family.
>=20
> We have this node in the -u-boot.dtsi file for various other boards:
>=20
> git grep "linaro,optee-tz" -- '*-u-boot.dtsi'
> arch/arm/dts/imx8mm-u-boot.dtsi:                        compatible =3D "l=
inaro,optee-tz";
> arch/arm/dts/imx8mn-u-boot.dtsi:                        compatible =3D "l=
inaro,optee-tz";
> arch/arm/dts/imx8mp-debix-model-a-u-boot.dtsi:                  compatibl=
e =3D "linaro,optee-tz";
> arch/arm/dts/imx8mp-navqp-u-boot.dtsi:                  compatible =3D "l=
inaro,optee-tz";
> arch/arm/dts/imx8mp-u-boot.dtsi:                        compatible =3D "l=
inaro,optee-tz";
> arch/arm/dts/imx91-11x11-evk-u-boot.dtsi:                       compatibl=
e =3D "linaro,optee-tz";
> arch/arm/dts/imx91-11x11-frdm-u-boot.dtsi:                      compatibl=
e =3D "linaro,optee-tz";
> arch/arm/dts/imx91-93-phyboard-segin-common-u-boot.dtsi:                 =
       compatible =3D "linaro,optee-tz";
> arch/arm/dts/imx93-11x11-evk-u-boot.dtsi:                       compatibl=
e =3D "linaro,optee-tz";
> arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi:                      compatibl=
e =3D "linaro,optee-tz";
> arch/arm/dts/imx93-9x9-qsb-u-boot.dtsi:                 compatible =3D "l=
inaro,optee-tz";
> arch/arm/dts/imx93-kontron-bl-osm-s-u-boot.dtsi:                        c=
ompatible =3D "linaro,optee-tz";
> arch/arm/dts/imx93-var-som-symphony-u-boot.dtsi:                        c=
ompatible =3D "linaro,optee-tz";
> arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi:                       compatibl=
e =3D "linaro,optee-tz";
> arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi:                       compatibl=
e =3D "linaro,optee-tz";

Since I assume this would still pass validation in the Linux kernel,
yes, it looks like a lot of platforms are doing it wrong here and should
be pushing this upstream. Thanks.

--=20
Tom

--uptbWlynIhR7I8Fp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakvCtAAKCRAr4qD1Cr/k
CkfNAQC7N4epJ/fE0PopyCM21HdPHcqqUuEtnPVbyuuEzQppswEA6e+Bv+sGYq76
xZljAz4gHvv7YZ5ot4opiMQVzru68ww=
=E3j7
-----END PGP SIGNATURE-----

--uptbWlynIhR7I8Fp--
