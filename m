Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC6BD16275
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 14:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2AD88AE7;
	Mon, 14 Oct 2024 16:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jMlhwjc+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A50489048; Mon, 14 Oct 2024 16:27:29 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19D968839A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 16:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-45effbc3348so37645911cf.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728916041; x=1729520841; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ETJblymMrFH55qjT3BTOXIT738PIi2YWLjd3/0mIAM=;
 b=jMlhwjc+UvMTor5oYf6XHcANJJH5PF/IjwIyjCmdz5Yb2+AfreMVFj8kgnqF6cR9Hu
 pbSS7+rEpNI5fzIsrBiZPEJDvVTcXUokmMX77DlMNnoSRSKhidpcYkqTm4RP+5cZUJeb
 NqLve1yxl6G3H+uMJW3mxASzORoc4iJb1PcIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728916041; x=1729520841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ETJblymMrFH55qjT3BTOXIT738PIi2YWLjd3/0mIAM=;
 b=Ru2QXzCAaxc80g1fuIa3woNV9cANAM4urJqzXXOK2AFnWsTuX9J1GT1GXZiqzjBmzy
 PTyJLEL21/gAC7EypIH9TgoI72mZ+CXKj6DziCjJ10wSpunbHqZ6CwGLx2FojD9SyItV
 iL4aR1Cuw+T3P8yl7pKpumCcmm1q7H9QNVxOPWNM5BJw5zouN32SfO2P9ZabmUwcgeU3
 jt5Ko0AqX2kltlQrLhGZ28I3SjMj44N4XCuTDFK+5KDRfgLGOY1NMJ08MhxzWymcCx9+
 sjYws9X+XyDe6u6/kFOlO5bRnxJiQ7UQH8OJWIHurwzb/wZOJNQQBlO0aRrvm3Bf/ETF
 +aiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW36BI9AxHfpAIUyl28FvcDgafCrPWOcfyGl5r8xUQKfbCTahx+SC3cwqTpEQw/LbaI+/HSKS8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx05gFMCHCruxaO3ZjjwZrKYjUqthw0+tVEYA1yjWeKfOEjUX95
 kNjvJLFoln39GE6KakmLPEzqj0Q1/Mr81hMOHnNMHTh7S4VVjAn31EP0d61NqGs=
X-Google-Smtp-Source: AGHT+IGFBuSdYk4d3c1rC6/YhpkrYg7VDsrymbqG1oc2Yz/YwzN1bLsUN/MqKyOboNh/IIeT3g4Ptw==
X-Received: by 2002:a05:622a:5b8e:b0:460:6f9e:96a8 with SMTP id
 d75a77b69052e-4606f9e9765mr37517381cf.50.1728916041178; 
 Mon, 14 Oct 2024 07:27:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460427e8012sm45703341cf.38.2024.10.14.07.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 07:27:20 -0700 (PDT)
Date: Mon, 14 Oct 2024 08:27:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 devarsht@ti.com, jonas@kwiboo.se, richard@nod.at,
 raymond.mao@linaro.org, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] boardf: Modify DRAM message
Message-ID: <20241014142717.GJ53053@bill-the-cat>
References: <20241010070909.288313-1-n-francis@ti.com>
 <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
 <f194f14a-c7c3-4aed-b4b8-f093f64c7b69@ti.com>
 <31aeb96d-55b1-4587-b212-2632ae4cc124@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QD9DkBJrNz3Ifc9p"
Content-Disposition: inline
In-Reply-To: <31aeb96d-55b1-4587-b212-2632ae4cc124@ti.com>
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


--QD9DkBJrNz3Ifc9p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:10:43AM +0530, Neha Malcom Francis wrote:
> Hi Andrew
>=20
> On 11/10/24 01:59, Andrew Davis wrote:
> > On 10/10/24 1:50 PM, Simon Glass wrote:
> > > Hi Neha,
> > >=20
> > > On Thu, 10 Oct 2024 at 01:09, Neha Malcom Francis <n-francis@ti.com> =
wrote:
> > > >=20
> > > > The message "DRAM:=A0 2 GiB (effective 32 GiB)" can be a little con=
fusing,
> > > > modify the message to show exactly what is meant:
> > > >=20
> > > > "DRAM:=A0 2 GiB (available for U-Boot out of total 32 GiB)"
> > > >=20
> > > > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > > > ---
> > > > =A0 common/board_f.c | 2 +-
> > > > =A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/common/board_f.c b/common/board_f.c
> > > > index 154675d0e40..b7add8f7d3d 100644
> > > > --- a/common/board_f.c
> > > > +++ b/common/board_f.c
> > > > @@ -254,7 +254,7 @@ static int show_dram_config(void)
> > > >=20
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 print_size(gd->ram_size, "");
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 if (!sizes_near(gd->ram_size, size)) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf(" (effective ");
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf(" (available for=
 U-Boot out of total ");
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 print_size(size, "=
)");
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > =A0=A0=A0=A0=A0=A0=A0=A0 board_add_ram_info(0);
> > > > --=20
> > > > 2.34.1
> > > >=20
> > >=20
> > > I've forgotten why the first number can be so much lower than the
> > > second. What is causing that?
> > >=20
> > > This is quite a long string...could we say "(total 32 GiB)" ? Then
> > > perhaps add something to doc/ to talk about the banner that U-Boot
> > > prints?
> > >=20
> >=20
> > Why not just only print the total number? The amount available to
> > U-Boot seems like an internal detail, I'd guess most folks just what
> > to see at a glance how much DDR was detected on their system.
> >=20
>=20
> Looking at the git history of this line, seems like we were printing U-Bo=
ot
> available size first and then modified it to show the entire DRAM availab=
le
> as "effective size"... quite possibly directly showing the total is a bet=
ter
> idea.
>=20
> Unless anyone has any reason to have this detail?

There's probably more history as well, but not totally relevant these
days. Some solution that starts from "most SoCs are 64bit and can easily
address all memory" and goes from there to not grow the overall U-Boot
binary much would be good.

--=20
Tom

--QD9DkBJrNz3Ifc9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNKkUACgkQFHw5/5Y0
tyy9dwv/U2PONltDj43LuNmf08w1s1Q1AQLzS25vPzOCWTwEx0lqdtgrO5vZewhB
q/hD0+dGkGIiYHcm39mwAbjq50Qfjs/An+jStdYtuwD2+NBJUpp6KCPcojtg1GI2
g2fNV/i482Y2qSbIg04pdvMsdSh2B0CjAHazodxhU3dL41IxA+PrbnubYl0EEgzP
LU+KWZlmCd+UXhx63cEhdwfpJW8JTS+fT0UmLpA8/EkXyzYvLFns9m6+56lKwUsf
TDfTg7RrP47FrfKPbuBbuYVTJrkpw/5eoOfdd2Hwe/T1clw114lnHiWknbYaKM8C
wAVk93orsvziJ4JrSPO9RADMlq+K9fP+Cn7cf7olUa/hmbx7ofOk2vovfdVfuvqK
KXD3TxurQSown17gSba6SDjq2FLPPNfdKuPM5IwFqqHSGASEYn0hUKI2Otvex4hw
iPuropHiaQ4ynnLUWhjmeQKxMpFiZuPNdx4JZuQFRigIt+XRpH3mIOowDD4Di5Z0
0egJk4Ce
=9HhZ
-----END PGP SIGNATURE-----

--QD9DkBJrNz3Ifc9p--
