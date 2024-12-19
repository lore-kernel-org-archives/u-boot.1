Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0270E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 13:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 295EC8021D;
	Thu, 19 Dec 2024 14:57:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QlZPOel0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 759B28022B; Thu, 19 Dec 2024 14:57:12 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1CB801F5
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 14:57:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d8fa32d3d6so10481166d6.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 05:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734616629; x=1735221429; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PxDtbX7ejZ2TBZtruKo3o1YgaoebbTFK/bBhQZdNtgY=;
 b=QlZPOel0dPzGWGl80eQa3YjaEGE9nZhScxI8R2HvQvkCnKJCTZeUsMOOSir8sY9MFP
 UP6I21HMB9tyPj6g7FlROVfWrgFcAyNAE9Y2k6wJyaE3b3fDRk3M5M5/yL10iA7r5yiU
 9mogRtKcfGGD/YV/nvonfYHlgISc5PgZX/DEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734616629; x=1735221429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PxDtbX7ejZ2TBZtruKo3o1YgaoebbTFK/bBhQZdNtgY=;
 b=uXgQ9JTd8aYVf8J+7BsIPywWBpEeaci6BeBm4u66wCona6WaEZZsEOvpxKxmxON7Bt
 l4KiLbZ8HXneIwLc8tdm2WkEYZ7TOpy4JK5oq/5bAbeANddk4ta3ea9AaHfQIs4YlANK
 rMlw4deooN8YpqyE0DALmmbKDWPPio+IXASKhqg6BzOBaOdiW/YhL2E7yuFJX8GPlsBf
 nj3roVtjwOC4HZkBtKsDbgaWz9313JR8FpSiO5HhgJXXlz8i548IGJy5vgvuYaJ/qCOL
 AQbS7LlmiqYuZi6o4fxVn85EtWSzyO3k7CRB4T2pnjmzDSkU0au5r6o0NctVEMNMx9r6
 /lyQ==
X-Gm-Message-State: AOJu0Ywh00UWn/KZyqtcPKKGA8vceQ1kFt4PUZvmPQ/w7vqPwtnSdnQi
 EzJmIbHjwZ+lVaJ5zboWDeO5p5rlxjt8hoya7H4bRLdkJ95IetbPdFgolwkLpqA=
X-Gm-Gg: ASbGncsakYL1Wur2wOuDJl7/ZAcGZCq9zhzU1tTR6TsSg76vQHQSn+q/NhDxBTvDGvQ
 UUo/aGudoBVR9ru6rqze+TM57Bstxl3JxH4DPIQ0aZL9b8AGtwlqrT2tYLicgle0WBfPDDxSd5k
 HgQmA2/semucuaRRNcZIeQO5pO1XMhem1oMse8K9X77SQXQ59MUdp9vBvj/CW0C0HXFlHMETm9C
 PmlR6xzQMOdxxEtvcBA4iCtOGH2dnZfeKBHkKfoIQiPVQXrDDPVNCWL
X-Google-Smtp-Source: AGHT+IHcW9VcG2UkNtwYRNfdFngc5xtfMEdWwA4yHh4GTsNTQ/+tUNfWvnsNG5G7ZI/edTEk76rsqQ==
X-Received: by 2002:ad4:5cef:0:b0:6d8:a7f7:c3a5 with SMTP id
 6a1803df08f44-6dd14c7525cmr52146876d6.44.1734616628706; 
 Thu, 19 Dec 2024 05:57:08 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1810cf86sm6729076d6.29.2024.12.19.05.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 05:57:07 -0800 (PST)
Date: Thu, 19 Dec 2024 07:57:04 -0600
From: Tom Rini <trini@konsulko.com>
To: "Paul HENRYS (EXT)" <paul.henrys_ext@softathome.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "paul.henrysd+nodisclaimer@gmail.com" <paul.henrysd+nodisclaimer@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH v4 3/3] tools: binman: Add tests for FIT with data
 encrypted by mkimage
Message-ID: <20241219135704.GS1505244@bill-the-cat>
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
 <20241125174717.1181452-3-paul.henrys_ext@softathome.com>
 <20241219005119.GA3555833@bill-the-cat>
 <MRZP264MB3114A97D471EA723D4D7A0B3AA062@MRZP264MB3114.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Te2AqcgdM8eQt8la"
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


--Te2AqcgdM8eQt8la
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
>=20

I will try again. But please note that "lore.kernel.org" also is missing
things, seemingly, because I started this out with b4 grabbing the
patches there, and then tried patchwork which did give me
tools/binman/test/aes256.bin but not the key file (and was a bit tricky
because of .gitignore). Thanks for explaining.

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

--Te2AqcgdM8eQt8la
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdkJjAACgkQFHw5/5Y0
tyxA0wv/UYd9tRXmJxP6XsmW+oiI5jSaeos2P0kGWztg8CFRQ71DPWnUajouC/vP
F2xLBiUwr2f13oQK3Jn0eIhPHLLkrfVwHnzDgLGdsFZciTewFSbX2/JDZILXNRnJ
i0MdH6X/vzz6EWwumPvJ0TUry8ImOWJYfNyYxdskHwQy8qrGhcbtOVpOxCY2ccWr
n6A/D2dZV8PFdxoyiKh9Q6pqS0qza/5aKtfiEFLscBEgo1t8adT3squK324SusJq
2EbqjE5flOsb8sviZNKVqCRpmfzHwtkgfWAa7pDaWzRTBF52DKjMOe0LDYWbBYZJ
dP/N/tnCI40TAcULHyAPagJGesaU/+RJHBUq3sl0l1QCH0RqUzhY0s9qbVU0lYjV
TAnT0J7tE3eKkwP7Pkj9BlsUMrb1XOJld3TVTY8vRW1j4pH3r4F8roFdL/3Thh9m
ReYVdmhSLmpDY6iS3/N0FeVfppZggCPSKbiMTxs1em+6aF1ZoVpq1ubU6TD502zL
Da/q1Qhp
=O7u3
-----END PGP SIGNATURE-----

--Te2AqcgdM8eQt8la--
