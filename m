Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045A0E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843C48021D;
	Thu, 19 Dec 2024 16:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SdJExwxs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445BF8022B; Thu, 19 Dec 2024 16:15:21 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847C48021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so63622485a.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734621317; x=1735226117; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rz2i2AKnAmkk2tyXiomv+mZHcBTq8HKetGPPn5Z63bI=;
 b=SdJExwxshpEEO6roP49usaswaYTF+oTux3yM0zbpMHLc9uRYeOz8mqKZ2TpoqkUXol
 Mn0pFDlkn95CeLTafWeS38ID0srVogqSopVHhlK4Wnbh5jQB5Nq8cmbSfCSf6X/ImTEI
 Uztk+0N/LoNOcaBtO6GGkblzAwEvhrwKyUETo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734621317; x=1735226117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rz2i2AKnAmkk2tyXiomv+mZHcBTq8HKetGPPn5Z63bI=;
 b=PWZkJVRYLkP0qWcqK1ImYTcc6DCsszlY5pyB3CJlqatMpGkUqjauYDwkk9uGew4AC0
 lCxaAeBJjCj2GfGC3SCXiZY4JpiAV9l7bs8/br943GEcsNwbGH/wh+YkWwKQDUPqh3ZF
 vuPRtB/aI21GAKOdZxS5bhfeCXfcQimx6SORKBaU+BCEEk2mhQFr/zvDInf5ssq15nSm
 wGAyUnUtcTFCLgb6j1nb+HgxZXEC3jzGMXJW+E0L5Fz5TSM33lgOyg4PQpNC3ECxvR1/
 AFLL/W9VvQiPP6i6Cq+eji5poMpO3mg0NSivD5pjBxryhT/RtofrzXGtZfQMe6qauZwP
 ZDBQ==
X-Gm-Message-State: AOJu0YyrJ2aRYuZWE9JQetAY/6uygbEazPLKG6wwJ/piJixmqvDL9yyH
 EZ7qw+3AQDU0ZS4OC/tWW620clCSb+/CgQiHug91w3HCJa64jm+UMGLqPlalE04=
X-Gm-Gg: ASbGnct2ImoL/cFLIHpuifIj1Zkjf/N49ICp8K1rQMj4tn8YNOQKGOyw4QPdZiqYJsP
 3f4AzQF6PusA3MeBpCH4YcA80mBeVkQYvoqScYbCZsfsRCWv5xLGNQocIkRqEIQ1XMAQalc7lae
 6ig+UOMpBEutZAAkWMx67emcAcxe9CJ02lW4oAv8+wdSCX/6uzDQBabMBAzZFZtmuusZuPHXC5h
 eeO1Odvk1wqXPDXlyZ6Co/aTWnlRq0f5cGE3SxWF5KwVXT867cb+j/W
X-Google-Smtp-Source: AGHT+IEMDmuLH4edFz55cY/nbW9src8mFf45pvKjQUro5tvxSZN3LM7JLywgef1panIfriIASJmw0Q==
X-Received: by 2002:a05:620a:8001:b0:7b1:b216:e2fb with SMTP id
 af79cd13be357-7b9aa8d596bmr580608785a.20.1734621317374; 
 Thu, 19 Dec 2024 07:15:17 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac4e2741sm54346485a.119.2024.12.19.07.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 07:15:16 -0800 (PST)
Date: Thu, 19 Dec 2024 09:15:13 -0600
From: Tom Rini <trini@konsulko.com>
To: "Paul HENRYS (EXT)" <paul.henrys_ext@softathome.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "paul.henrysd+nodisclaimer@gmail.com" <paul.henrysd+nodisclaimer@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH v4 3/3] tools: binman: Add tests for FIT with data
 encrypted by mkimage
Message-ID: <20241219151513.GU1505244@bill-the-cat>
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
 <20241125174717.1181452-3-paul.henrys_ext@softathome.com>
 <20241219005119.GA3555833@bill-the-cat>
 <MRZP264MB3114A97D471EA723D4D7A0B3AA062@MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8cbu7HLK5pl5JUbC"
Content-Disposition: inline
In-Reply-To: <MRZP264MB3114A97D471EA723D4D7A0B3AA062@MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM>
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


--8cbu7HLK5pl5JUbC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 09:51:16AM +0000, Paul HENRYS (EXT) wrote:
> Hello Tom,
>=20
> The issue comes from the key that is reported missing (or zero size):
>=20
> ValueError: Error 1 running 'mkimage -t -k /tmp/binmant.nvd038o5/keys -F =
/tmp/binman.is3n51x5/fit.fit': File /tmp/binmant.nvd038o5/keys/aes256.bin d=
on't have the expected size (size=3D0, expected=3D32)
>=20
> The issue is that the "binary" file fails to be provided in patchwork. I =
send the following mail about this on 05/08/24:

Indeed, I thought I had fixed that up, but didn't do it correctly,
thanks!

>=20
> > Hi Simon,
> >=20
> > Sorry for the late reply as I missed your message blocked in quarantine.
> > It looks like when I push a patch with binary data, patchworks does not=
 seem to get it right. Nonetheless, using git send-email, a copy is also se=
nt to me and I do get the patch right.
> > I put you in CC this time so you should also have received a copy of th=
e patches. Could you take a look you get the patch "[v2,3/3] tools: binman:=
 Add tests for FIT with data encrypted by mkimage" with the binary data?
> >=20
> > The end of the patch with the binary data should be as such:
> >=20
> > diff --git a/tools/binman/test/aes256.bin b/tools/binman/test/aes256.bi=
n                                                                          =
                       =20
> > new file mode 100644                                                   =
                                                                           =
                       =20
> > index 0000000000000000000000000000000000000000..09b8bf6254ada5c084039f3=
2916bc7d30233bb2c                                                          =
                       =20
> > GIT binary patch                                                       =
                                                                           =
                       =20
> > literal 32                                                             =
                                                                           =
                       =20
> > ncmXpsGBz<aGq<obNK8sjNli=3D7$jr*l$<50zC@d;2DJ=3Ds4pC}7U                =
                                                                           =
                           =20
> >                                                                        =
                                                                           =
                       =20
> > literal 0                                                              =
                                                                           =
                       =20
> > HcmV?d00001
> >=20
> >=20
> > FYI, I also added the requested changes.
> >=20
> > Best regards,
> > Paul
>=20
> Best regards,
> Paul
>=20
> ________________________________________
> From:=A0Tom Rini
> Sent:=A0Thursday, December 19, 2024 01:51
> To:=A0Paul HENRYS (EXT)
> Cc:=A0u-boot@lists.denx.de; paul.henrysd+nodisclaimer@gmail.com; sjg@chro=
mium.org; al.kochet@gmail.com
> Subject:=A0Re: [PATCH v4 3/3] tools: binman: Add tests for FIT with data =
encrypted by mkimage
>=20
>=20
> On Mon, Nov 25, 2024 at 06:47:17PM +0100, Paul HENRYS wrote:
>=20
>=20
>=20
> > Test the property 'fit,encrypt' to encrypt FIT data.
>=20
> >
>=20
> > Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> > ---
>=20
> > Changes for v4:
>=20
> > - Update the tests to use 'fit,encrypt'
>=20
> >
>=20
> >=A0 tools/binman/ftest.py=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 45 +++++++++++++++
>=20
> >=A0 tools/binman/test/343_fit_encrypt_data.dts=A0=A0=A0 |=A0 53 ++++++++=
++++++++++
>=20
> >=A0 .../test/344_fit_encrypt_data_no_key.dts=A0=A0=A0=A0=A0 |=A0 53 ++++=
++++++++++++++
>=20
> >=A0 tools/binman/test/aes256.bin=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | Bin 0 -> 32 bytes
>=20
> >=A0 4 files changed, 151 insertions(+)
>=20
> >=A0 create mode 100644 tools/binman/test/343_fit_encrypt_data.dts
>=20
> >=A0 create mode 100644 tools/binman/test/344_fit_encrypt_data_no_key.dts
>=20
> >=A0 create mode 100644 tools/binman/test/aes256.bin
>=20
>=20
>=20
> This fails in CI:
>=20
> https://source.denx.de/u-boot/u-boot/-/jobs/980030
>=20
> or
>=20
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10169&view=
=3Dlogs&j=3Dc59aff74-743b-5f08-f408-4a608a489153&t=3Df2ea3536-b291-5a39-ad9=
2-0220c9b8101a&l=3D300
>=20
> Please see https://docs.u-boot.org/en/latest/develop/ci_testing.html=A0for
>=20
> how to trigger Azure yourself to resolve these, thanks!
>=20
>=20
>=20
> --
>=20
> Tom
>=20

--=20
Tom

--8cbu7HLK5pl5JUbC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdkOH0ACgkQFHw5/5Y0
tyz2yQwAoLZZpNZUbaNsSxkqMZvDVuGKhhRjWyUT+i1oU9mRId3ZTDpuwt1JxDX0
VVF3a0KnlO2V0OmnyPKxvN57Oe6gc3eW6rvlksn4fy+37EU6INKZmiXy8PQzD6Jc
MkR3ay/2kDIqp40mXVV3oC7ah3yGijj3fx773SnMaV4zC2VxXUkfxLMF81sLGlpp
kPJSS1ezGur13pD0ghICp0P6O1ziZK4pPTTQs9v2soruCJY1ZBf90FUT90nNIFK/
6Z9G5WvRxxpCg69q9w+UpA24kGPWE13Z6DWN0F9zCFneP+OVXnG0OEgruWvybBlp
Qc7/LewqkU/gH0UYlNP8yP295Kbv7xfBcXDyP1/RA9DaGTXORRrWwpopnI+L75Vu
RGIAlgZsE2YGR2zqUUxLDLznZasrpBPDPxGCKoojlhew7s24s64VddjThS9g5Vm3
aJIPzXzAdOqfVQYvdQYQhptN/qIyhjKqMBxj/K8QDmA8CkYd5TdwiPtNKaqxeked
NcnSR9UA
=Dx7n
-----END PGP SIGNATURE-----

--8cbu7HLK5pl5JUbC--
