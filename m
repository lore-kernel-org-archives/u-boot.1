Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8374CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 16:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 331F588C39;
	Mon,  2 Sep 2024 18:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jQDegF2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC04988C40; Mon,  2 Sep 2024 18:19:28 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA5A88363
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 18:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c35b72f943so13367206d6.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725293965; x=1725898765; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z19wiATM+rI47+ayfHuiz3T9GfeKEzEh3tZQHlJtqiI=;
 b=jQDegF2T7dqKwMlGliOLrMMM8vqWkSsj8iYqN8Hf1nMC4nyU8Wygnh7bQhp5Pr/FQK
 QjYdUUQSVYasTDsQwzyXStv/CjsrfnJ5JOOwqIM/6fsx9775lOyHsEnYe7i+LI5IJ/yP
 t8HBQwflERGyT49XkFFgiclNtbSDe1dZtAvos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725293965; x=1725898765;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z19wiATM+rI47+ayfHuiz3T9GfeKEzEh3tZQHlJtqiI=;
 b=gMpZ5CuuwxPVsWmbgNFdR5IkMwCCqP1Os6iXgiC/S4IOwjxhPQaF/ZTajwLXqrHhCN
 KChvpAa2AbDiyUrLu3xHTefEMI5G8qgWvf4/mNxg74kLAAlMZOWDDlmt0BghUqs2uZQj
 noms7Pa/Er9aiI2KyHubHXX0OEyBT+WG9LwivkNve26y3rPYOh+ajkjtPkhDwBCLzQKE
 vPECTVtggk9C1Il3eJ0E4d0ywGP2ZZPnGY0+iomZy/8AnGjfeY/bZHXJW9AYNGtQgefa
 TClLQ5Mko4op7zf5U3gD/PQAHHxWJBnZSQyujL1JHUYQEqnLXCRZM5Um8EPIUwyOKmmC
 p6Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFxfZnFV7P+F3TKnKjft+2DcjYOz+NSyOhwm1Ln7pQRXVNmfMIX/tMUl5oNoUMr/vr1WLuLr0=@lists.denx.de
X-Gm-Message-State: AOJu0YwGYlPcoT4PRRmeiYFMzhEG6j6KbEZwBU01YyOLonSBfvm9YesW
 H4tFlDW2g4KD7h2XMXwwnmkev0D7KNm3LZqIImCf/XgELp7dBxi7k0Y97n+zRIE=
X-Google-Smtp-Source: AGHT+IHtipve8LS0YAVcLP9IhIwpMDE2qxdOv1leQxMElkoEeAQCfgbnrwRr8FluTn6QsRGSj1Y9xg==
X-Received: by 2002:a05:6214:c8:b0:6c3:5392:4e03 with SMTP id
 6a1803df08f44-6c35392539fmr158878526d6.21.1725293965166; 
 Mon, 02 Sep 2024 09:19:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c35bd06de7sm20989456d6.17.2024.09.02.09.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 09:19:24 -0700 (PDT)
Date: Mon, 2 Sep 2024 10:19:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, git@amd.com
Subject: Re: [u-boot-test-hooks][PATCH] travis-ci: Skip the saveenv and reset
 test cases on xilinx zynq qemu
Message-ID: <20240902161922.GD2479150@bill-the-cat>
References: <20240902095357.311-1-venkatesh.abbarapu@amd.com>
 <93b022d1-63ae-4b7a-aa62-6be2a5c2a7e1@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lfSGlSTZfzkR9FRV"
Content-Disposition: inline
In-Reply-To: <93b022d1-63ae-4b7a-aa62-6be2a5c2a7e1@amd.com>
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


--lfSGlSTZfzkR9FRV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2024 at 12:11:22PM +0200, Michal Simek wrote:
> Hi Tom,
>=20
> On 9/2/24 11:53, Venkatesh Yadav Abbarapu wrote:
> > There is an issue with the xilinx zynq qemu qspi driver during the erase
> > operation in dual parallel configuration, so skip these
> > tests for now.
> >=20
> > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > ---
> >   py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py | 2 ++
> >   py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py       | 2 ++
> >   2 files changed, 4 insertions(+)
> >=20
> > diff --git a/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py b/py=
/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
> > index 267285f..42685ad 100644
> > --- a/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
> > +++ b/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
> > @@ -1 +1,3 @@
> >   env__spl_skipped =3D True
> > +env__saveenv_test_skip =3D True
> > +env__reset_test_skip =3D True
> > diff --git a/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py b/py/travi=
s-ci/u_boot_boardenv_zynq_zc702_qemu.py
> > index 267285f..42685ad 100644
> > --- a/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
> > +++ b/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
> > @@ -1 +1,3 @@
> >   env__spl_skipped =3D True
> > +env__saveenv_test_skip =3D True
> > +env__reset_test_skip =3D True
>=20
>=20
> CI found bug in Qemu which is reported here.
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/jobs/878781
>=20
> as
>=20
> ----------------------------- Captured stdout call ----------------------=
-------
> Saving Environment to SPIFlash... Erasing SPI flash...qemu-system-arm:
> ../util/fifo8.c:62: fifo8_pop: Assertion `fifo->num > 0' failed.
>=20
> It is bug in Qemu and we have already asked our Qemu team to fix this but
> hard to say when fix reach upstream and then there is CI pipeline update
> too.
> That's why the most sensible thing to do is disable these tests to be able
> to pass CI for dual stacked/parallel configurations.
>=20
> Acked-by: Michal Simek <michal.simek@amd.com>

Thanks for explaining, I'm sure once QEMU is fixed and we've updated our
Dockerfile to have it someone will send a revert for this change.

--=20
Tom

--lfSGlSTZfzkR9FRV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbV5YkACgkQFHw5/5Y0
tyy4/gwAmy/aCi0LC5wb3pL6/ZLuPomlRumbnqGpmWvpeSe0JWAk1/joj8fUhjOd
lfgfn7M7BqEMCbfcVcNkL/O05kr6km6NdEVmI7tKODwdYkD/iE33yAUXC0KmffWr
ewt6PK0Xfqpm4djvqofmKCcd4WfN2vp9+ftPi66ddaK4A4tWGSXO9TeO+43rJXxr
9RmepjOs1MtKl7xD4qdsIDiOVRPyinSwNRFHMhL39au5wdXZGW0QIvSUStyIiKqi
sTOj35FeH3wZrvBfQg9ErRtED6ZUyHAWxrcWp31l+kUvFJkaTXrGQaJKX+ySmtMP
ZmQwN6qoczkyJg6LgN64dxTkD3l5obfngPHe0Xb6vPqGSgzEdk+h1/BNh6H+7NKQ
Ge++6ix9RI+GpN44Q32ZkWwqQdY06XsJMyzMb/rAeiZGNUhzeVF43h8AMcXjjVyG
xLX1SaNZmM5OPpnXGm8FFY00qvUiyYGZB9zPgwZLDxdYTHObegPjQCGn8PUZeIJL
SeF96YOj
=RFay
-----END PGP SIGNATURE-----

--lfSGlSTZfzkR9FRV--
