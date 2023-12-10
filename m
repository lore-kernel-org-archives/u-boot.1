Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAA9C10DCE
	for <u-boot@archiver.kernel.org>; Sun, 10 Dec 2023 18:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C258764D;
	Sun, 10 Dec 2023 19:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Eh0yWVXn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DED9876B2; Sun, 10 Dec 2023 19:55:59 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E5B876F3
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 19:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5df49931b4eso12665347b3.0
 for <u-boot@lists.denx.de>; Sun, 10 Dec 2023 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702234553; x=1702839353; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gtxlRcilN60vY2K/Hw0HhJqKBdPSknxb/EUEQU57U04=;
 b=Eh0yWVXnK+QKJjIgYDnTIOnyhtwgZACWL/JNIwpOnQgNfVzEmIA3dmtcZ+CNYKHYEH
 VGcjgc46eO1gde/oBHiox68DnxwTtCYyp45GBs0OOkuPmX472FGVuBoGIbcQ3VmQw5Cw
 /Yu/osS85rDGOSHuBsuUfaTmXRvN+BSuMEwrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702234553; x=1702839353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtxlRcilN60vY2K/Hw0HhJqKBdPSknxb/EUEQU57U04=;
 b=ECB5WllaxZMoRlmUIwIL3hU+Wmbdl+tUN/7fNS8Fj0hG76ZqrDg4jLmlkrnMtV6vSX
 JqB3a4JH67U88c3xj06LszRrheZz0+4H3D2/U+NOqiz8RobyU5Rtb5nGqb+q4ooNCPik
 qIzVWTvP73H0cjJGPnwi26DkIAenSNhg/3BU25XAXBUmSrK3j0VBuO8rb2DU9BwTbTWd
 afHLW0IzCaE7mGEsfQ65Y0Sy8GyihBp5YwStOwU6D/vjc5UVNOabX3IRYriQmtJsbT49
 5GTWQSN76+weEhucwUQFti8xsqsTW+mJkVUSB8q8+d3XbTcgJcOUOO96fWHjvx9sxa2R
 kYZw==
X-Gm-Message-State: AOJu0YynXMnHwXA7xgBdknZZWtRdkocAmkil3rHV01AhKVV/AfHC+QAk
 EKO3i1yHttewfhE9Ih0dchyO2A==
X-Google-Smtp-Source: AGHT+IFafPIqoGbmRwQKtghdzKIB3KIM6Kp7ej8orcCd2jOpaI5YhMn06yVmWaO3UnG6PsMMpcWU0w==
X-Received: by 2002:a81:d541:0:b0:5d2:bb18:5834 with SMTP id
 l1-20020a81d541000000b005d2bb185834mr2180828ywj.15.1702234552949; 
 Sun, 10 Dec 2023 10:55:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8dee-9b11-e8b3-3204.res6.spectrum.com.
 [2603:6081:7b00:6400:8dee:9b11:e8b3:3204])
 by smtp.gmail.com with ESMTPSA id
 q130-20020a815c88000000b00582b239674esm2403286ywb.129.2023.12.10.10.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 10:55:52 -0800 (PST)
Date: Sun, 10 Dec 2023 13:55:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 u-boot-custodians@lists.denx.de, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 conor+dt@kernel.org, Caleb Connolly <caleb.connolly@linaro.org>,
 neil.armstrong@linaro.org, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Message-ID: <20231210185549.GR2513409@bill-the-cat>
References: <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
 <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
 <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>
 <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
 <34334add-4017-46f6-873a-d9233e29f640@linaro.org>
 <CAFA6WYN_uf0+tHm7RxXXz_7U3tdbdsK1rttnQN-rcfRknrcDQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3BMPCuFghd0pYmNX"
Content-Disposition: inline
In-Reply-To: <CAFA6WYN_uf0+tHm7RxXXz_7U3tdbdsK1rttnQN-rcfRknrcDQA@mail.gmail.com>
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


--3BMPCuFghd0pYmNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 10:35:02AM +0530, Sumit Garg wrote:
> On Tue, 5 Dec 2023 at 15:39, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 05/12/2023 10:45, Sumit Garg wrote:
> > > + U-boot custodians list
> > >
> > > On Tue, 5 Dec 2023 at 12:58, Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 05/12/2023 08:13, Sumit Garg wrote:
> > >>>>> @DT bindings maintainers,
> > >>>>>
> > >>>>> Given the ease of maintenance of DT bindings within Linux kernel
> > >>>>> source tree, I don't have a specific objection there. But can we =
ease
> > >>>>> DTS testing for firmware/bootloader projects by providing a versi=
oned
> > >>>>> release package for DT bindings? Or if someone else has a better =
idea
> > >>>>> here please feel free to chime in.
> > >>>>
> > >>>> This doesn't work for you?:
> > >>>>
> > >>>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicet=
ree-rebasing.git/
> > >>>
> > >>> Thanks, this is certainly a good step which I wasn't aware of. Furt=
her
> > >>> simplification can be done to decouple devicetree source files from=
 DT
> > >>> bindings.
> > >>
> > >> Why?
> > >
> > > I suppose you are already aware that Linux DTS files are a subset of
> > > what could be supported by devicetree schemas. There can be
> > > firmware/bootloader specific properties (one example being [1]) which
> > > Linux kernel can simply ignore. Will you be willing to add all of
> > > those DT properties to Linux DTS files and maintain them?
> >
> > We already added them and we already maintain them. DTS describes the
> > hardware, not the OS-subset of the hardware.
>=20
> Let look at some numbers if your statement is justified or not for the
> example I gave:
>=20
> u-boot$ git grep -nr bootph-* arch/arm* | wc -l
> 4079
>=20
> linux$ git grep -nr bootph-* arch/arm* | wc -l
> 267
>=20
> It looks like there is always going to be a catch up game regarding DT
> properties which either Linux kernel or u-boot or any other
> firmware/bootloader project don't care about.

I want to chime in here just because that specific binding is both
relatively new (and so platforms are working on upstreaming it now) and
board-maintainers have gotten some feedback which has lead to:
https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/12
that someone needs to have time to work on and that will in turn reduce
the number of instances both in U-Boot and then upstream. It's also one
of the first examples of properties not used directly in Linux but that
is valid and so there was some initial back-and-forth on getting the
dts(i) changes accepted to the kernel tree.

--=20
Tom

--3BMPCuFghd0pYmNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV2CbIACgkQFHw5/5Y0
tyxBLwwAra4kAkCRhGfWKVHE23Crdw5BcbvuOj+NQmiALuT2OzPLzdJwQQxkLi05
O97KlJ8KW+ko+oOKsnI4a8K9uDJHGOwnJvPTYZzHR+yObUwVaXf0eqOTdFKy0V1u
kHBh0f66wUdASq8rz7A4esiln8EA9d3Fxubndc6A+hk0Y5FQu27YWfX7Ng4sCbTY
zbRoJFJC0fLXAVr2qzMWiU2hBTnXkwYDfsIakwKa8Q176Qt1Bj3Da2oefZc0sYVl
E+fZM+QpZNCKwWFHI9kM9G6poj8wyhQYucuidvKgNTlEpq9gfZD0r8jKqnjL//sd
A0HoKg/Bv43bWx2akZeIKqlSV3Zv7ikOoZg81GNvgF1hcBj7YIrMHoH0ICR0CJGR
bRnWWPTEzBNkjb9EDc35kV/N9STw3odEAgppGJSQVnO9dePzEnYnrzU5Pu2eX6zZ
0Q0ZmZQm4eGmgzB3iYT8W9sdNT0LZUL5k8GsJWCX6bFH8kBD5cOWtnDIdmDVFWJp
2OQaZDGg
=gIRK
-----END PGP SIGNATURE-----

--3BMPCuFghd0pYmNX--
