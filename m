Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55A3C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 16:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDEDD88A9D;
	Mon, 16 Sep 2024 18:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V+axwNxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 139C588EC6; Mon, 16 Sep 2024 18:33:26 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0575889FC
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 18:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4581ee65b46so31284391cf.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726504403; x=1727109203; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S2lwqi2n8YgnUR9o3HLHOVtZ8M2YW4W34rd7E7tKLig=;
 b=V+axwNxASEXN2PAwZp3skUMECAzfX+4zpZJxK/8voXGlEcrJWqAoonpOYrnWqoGYRz
 W2K0Fnpu/QsrEaOBuSUsXT1nXyNjpJI/xeRhI5wWtrCBaDx47ZuRy4OPGvDhQY/aaJ6N
 SgMomd9TE8taes7v9YYmnULBQ+5ExiQFTgG0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726504403; x=1727109203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S2lwqi2n8YgnUR9o3HLHOVtZ8M2YW4W34rd7E7tKLig=;
 b=eBUQ2AOtwoHDR9IldisvL+5742fvH5dCUdLwnJhmsCj5KFy203qT16TQP7OM38Wy0x
 rZTVYapEo52D+SpN80onuUDiOn9o9ACYdz+VVQ1FCK/MerP9AHAVGjCv9l/8Ak3x3a4Y
 ou7C4inwGHRW1VnOJJatfdPTSe6Wj0Su09YC/XUdXb8Z06VSVF3Hh65i7UxaV3FGcOo8
 691X7/Bi9WjU5KCQYG4NCQzGLFPE3wBr8s8OwQPQroZjr2Eoab0b8+SCKFpKYJedr3oM
 xJ6qMLA89UM6sWVwxGIkdDlAJBm4WA+Xzw8UDKW6K16VA3B030UZ55Sb21GeTPhsoHdh
 Gsyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnKIU61GCSsImK9vBGzCXU4EkRoimwyddwJ+UkUOBqOFlePoJimoRtJHJSAA7VH8NR0AEU+0o=@lists.denx.de
X-Gm-Message-State: AOJu0YwnQ6opB8rJLUeV97E+FmmP2Oirucp+Lejz5rUQsTQyEUjwtFFT
 PJJ5dlWuCcW49HAmoB8YZfyWExH8677rna/vKZ7tNGDjensUoudmuRWS7nf2D9s=
X-Google-Smtp-Source: AGHT+IEZfrELeVvRMWjVPfLTfyzfYi2CSbwvy+alF0CEawo9I6ws1e6E0+2xn/98C6y355StlnkShA==
X-Received: by 2002:ac8:5e12:0:b0:458:4ac7:866b with SMTP id
 d75a77b69052e-4599d29c115mr253503231cf.45.1726504402594; 
 Mon, 16 Sep 2024 09:33:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aacaa318sm29033721cf.57.2024.09.16.09.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 09:33:21 -0700 (PDT)
Date: Mon, 16 Sep 2024 10:33:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 10/14] efi_loader: Disable ANSI output for tests
Message-ID: <20240916163319.GG4252@bill-the-cat>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-11-sjg@chromium.org>
 <d421b72a-eb0a-4aa8-be6e-3825c8b08da6@gmx.de>
 <CAFLszTjRSoWr0uncOdMY=6Oc4dnLP7gH2hj0BgDF67ukQEmmdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/fNTlvLLG2SE6O28"
Content-Disposition: inline
In-Reply-To: <CAFLszTjRSoWr0uncOdMY=6Oc4dnLP7gH2hj0BgDF67ukQEmmdw@mail.gmail.com>
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


--/fNTlvLLG2SE6O28
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 05:42:12PM +0200, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Thu, 12 Sept 2024 at 08:58, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
> >
> > On 02.09.24 03:18, Simon Glass wrote:
> > > We don't want ANSI characters written in tests since it is a pain to
> > > check the output with ut_assert_nextline() et al.
> > >
> > > Provide a way to tests to request that ANSI characters not be sent.
> > >
> > > Add a proper function comment while we are here, to encourage others.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> >
> > This patch was already NAKed in the last version.
> >
> > Please, adjust the test framework if you need filtering.
>=20
> In what way should it be adjusted? I hope you are not suggesting that
> sandbox should try to filter out ANSI characters in its assertions?

Well, perhaps the pytest framework should be filtering it out? And
again and to be clear, I can't reliably run these tests on _hardware_
because of the ANSI characters tripping things up, this is not a
"sandbox" problem.

--=20
Tom

--/fNTlvLLG2SE6O28
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmboXc8ACgkQFHw5/5Y0
tyxXvwv/eotjvF9c+s3kAsPDn1pAAgsL6GYLMV6YDNaAlOoyOMwsIbZgaltrTwtn
YMzHV9PZn334Yb5dEpwr6+JpEfXjwJtvhhKEGQXo9633v15B1o6qVHJmOcCaGOEU
Hm50KF0YL+MFREW+3KITxWVIQcVDxeLBWXt/QsPMjt/cAvF2O1D8+CgBnSK/D9H7
Z0W4oxa2lRZrmKjuWU6VtUxwVIPGmVU4m3JY2ZkUFbWPS/6T3e9a5mE44hQ2l3WR
g0X7HckcwKnWXuwAAg6aOTc2q7PqO9bBViJGX8OnfQc6+Np/35dgiJyp0vUPuajF
pbCSEH1L9Q2Now1Qy5xfOIRaUo6+aCPdxNnGazVGUXy6pk/XcaWVvZQbrDSyjt6J
8XYqlmwmBgs9da2NI1Xz6VEd1wX0EOg6U+qonDbqa5+trds3shkBJzE6WETEHlAw
Vs7WdsnMDFcTZrfT268lnudUHT2ga+ulkGMqlkLssgiZ2jKnvR7JBsGdJVf8siZq
kD3L+Ecw
=vUNQ
-----END PGP SIGNATURE-----

--/fNTlvLLG2SE6O28--
