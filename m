Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA17C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C91B08215F;
	Wed, 30 Apr 2025 17:29:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZSYvOnPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B98282BAA; Wed, 30 Apr 2025 17:29:09 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D1B82153
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-60657f417c4so2381675eaf.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746026944; x=1746631744; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UgOEOeP344FHcPr1k7Gt7/aWJPjRp6fackYKK4ama/g=;
 b=ZSYvOnPnzY3iFfhBVGywH7VyTHlgMYvmsHjFI3HUwZN2afuDve+/xm1PCQ/dnoHSAc
 B6JRP83nL4v3mFgFPBgMMjseKSJBmfGblMQbv7TSqoKdJGTpkhZftuS092r1RpNLZS+M
 BECHzVxZdAjw2VVgPkACEEt1vCc8fLk9tkTzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746026944; x=1746631744;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgOEOeP344FHcPr1k7Gt7/aWJPjRp6fackYKK4ama/g=;
 b=Frf2lt7ac6Fo7Y54ojgGbVv8Zx2JdLwPEVx+M0iLcehIs2OxjrFsJesGDmMG5GCeD6
 S5PxeIISIWs2WM9Cs8RFK0H0ULJWbNnU8jY2TkKE9YO2LiOk8ewFiDA7a4IlrVb9I9Q5
 gHdTXVozBxTExJAAY6Al6yeAyRAsk4EUNr2Nsa3y9ejG2zKzhs8tSlIrAAPZUt19bR6E
 omKRDG+sqQazkQkc30JrvdFWL4kwmc9J+V7TdJBcVz0TqKea5knO2dphytwtXRsTxhv+
 JCCSslESruAGnz4H1wHrvFS67REdtUaF1tNOZ10jEOPUAF6TYhd5eRah96oS5S24ydcl
 eY1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5OD4dlNx/5VsLCa0yGsH4YlACOPymtmmdnFefvrQ21cmrMIqzAPfd9QGqDzNUl59/h08J9aw=@lists.denx.de
X-Gm-Message-State: AOJu0YyeGv/9SfzPRWqBxj56UPOpgZ5vfsMbBVO712quSN5VUm/SRq/3
 VmdGlL0J9QjIZ6B6LvVh5t8ILrQ8hE/jSetNTn75S0sfWos9unQkxopk70TFx7w=
X-Gm-Gg: ASbGncs39vNlVqAII1GKRFpoLH16fUG4qSW9enZnzMtEJk0fV3ZveMtlmsOSe5cIZp6
 R36XxPU4L62raIV3oJIcNRzi/lkJYV1fuMXyIDHQZaLZMMuzyAqaSrXPHOXXkiwbYfF0c3CBg0n
 IVw1T3piUaOlHiXL+WkJbdmv97M+CA8A7AfsD18hLdU/VZaNDam8hlKY4hONSphHpX3a7sWUlKN
 hBRn4bI9hudKzP+hKmcEho9gVtHTDy2jjQvmfK/HuKgF/Zv7Zi4r/yxhDg5J/H+LUgnwq5deS8y
 0qhkjOXSOAFmJMvc9yXZvZddf7YICnxQ9ttUro5q2+ZX0oGjfxN6JEjjDYSr1vzj24V9smwZO1v
 0Jg==
X-Google-Smtp-Source: AGHT+IFBLavxBwP0akyfo88U61sBJ827ApWmIZUlUoicyRAXxJgR0NBlUYyXYTe8wwX1hKUJr/b39Q==
X-Received: by 2002:a05:6820:1f11:b0:602:5856:255c with SMTP id
 006d021491bc7-607d44e6af7mr2037265eaf.8.1746026944517; 
 Wed, 30 Apr 2025 08:29:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60686e8b99bsm814918eaf.6.2025.04.30.08.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 08:29:03 -0700 (PDT)
Date: Wed, 30 Apr 2025 09:29:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Roese <sr@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [REGRESSION] [PATCH v6 0/3] Static initcalls
Message-ID: <20250430152900.GT1261075@bill-the-cat>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <18d1c97d9a420c40181352bf1445e2772d784d9a.camel@codethink.co.uk>
 <CAFLszTjjsdp7xijT1SVq9P3mou9vvGWmK5_ngb1Y6Ap4A99QSQ@mail.gmail.com>
 <20250430141513.GN1261075@bill-the-cat>
 <CAFLszTh-G4m2oXZya7SBBeYw2f4S0Od7=toS1H2iwMeumSsHgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U6jGr3Ew/WC+R9H0"
Content-Disposition: inline
In-Reply-To: <CAFLszTh-G4m2oXZya7SBBeYw2f4S0Od7=toS1H2iwMeumSsHgA@mail.gmail.com>
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


--U6jGr3Ew/WC+R9H0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 09:00:40AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 30 Apr 2025 at 08:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Apr 30, 2025 at 07:54:46AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 29 Apr 2025 at 16:32, Marcel Ziswiler
> > > <marcel.ziswiler@codethink.co.uk> wrote:
> > > >
> > > > Hi Jerome
> > > >
> > > > On Fri, 2025-04-04 at 15:50 +0200, Jerome Forissier wrote:
> > > > > This series replaces the dynamic initcalls (with function pointer=
s) with
> > > > > static calls, and gets rid of initcall_run_list(), init_sequence_=
f,
> > > > > init_sequence_f_r and init_sequence_r. This makes the code simple=
r and the
> > > > > binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and=
 -510
> > > > > bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> > > > >
> > > > > Execution time doesn't seem to change noticeably. There is no imp=
act on
> > > > > the SPL.
> > > > >
> > > > > The inline assembly fixes, although they look unrelated, are trig=
gered
> > > > > on some platforms with LTO enabled. For example: kirkwood_defconf=
ig.
> > > > >
> > > > > CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelin=
es/25514
> > > >
> > > > This series seems to cause a regression on rock5b. E.g. on today's =
master:
> > > >
> > > > =3D> pci enum
> > > > =3D> setenv ipaddr 192.168.10.2
> > > > =3D> ping 192.168.10.1
> > > > failed to initialize card: -12
> > > > failed to initialize card: -12
> > > > failed to initialize card: -12
> > > > failed to initialize card: -12
> > > > failed to initialize card: -12
> > > > failed to initialize card: -12
> > > > failed to initialize card: -12
> > > > failed to initialize card: -12
> > > > No ethernet found.
> > > > failed to initialize card: -12
> > > > failed to initialize card: -12
> > > > ping failed; host 192.168.10.1 is not alive
> > > >
> > > > Seems the rtl8169 driver runs out of memory trying to allocate desc=
riptors?
> > > >
> > > > If I revert this series on top of today's master:
> > > >
> > > > =3D> pci enum
> > > > =3D> setenv ipaddr 192.168.10.2
> > > > =3D> ping 192.168.10.1
> > > >
> > > > Warning: eth_rtl8169 MAC addresses don't match:
> > > > Address in DT is                00:e0:4c:68:01:5a
> > > > Address in environment is       fe:b1:db:60:25:69
> > > > Using eth_rtl8169 device
> > > > host 192.168.10.1 is alive
> > > >
> > > > I just completed the bisection and will now look into what exactly =
could be going on.
> > > >
> > > > Any insights are much appreciated.
> > > >
> > > > Thanks!
> > >
> > > I have one of these boards in my lab. Could you please apply the
> > > pending lab patches, e.g. [1]? Also, can we get this board running
> > > network tests?
> >
> > Your lab patches sadly stopped applying, I think somewhere around where
> > you didn't comment on my feedback about needing to fix problems with how
> > modern i.MX platforms do/don't handle blobs, and also the "all" make
> > target.
>=20
> I believe it was when you didn't want to disable boards which don't
> work (e.g. samus).
>=20
> Still, any conflicts are trivial, so perhaps just apply them?

Then I have to worry if the lab setup is working too. Please rebase them
to master, test and re-post.

--=20
Tom

--U6jGr3Ew/WC+R9H0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSQbwACgkQFHw5/5Y0
tyw4TAv9FRbBiLIToHAz6d5FE52J1MRk717h6X/Odoz2gmrBOeoIdJNhHNjJrV1B
M5zpJZKrjvX3dzE5yTDHiIbGV5guUb3E4CELKLisTaFdWWS9mzoEydvsE8sUHCXq
ivkt4le1woZrqKMaDfbDdz14i096RKPD2ylpM1cOtkgn7TXoccmiQ8ez4FQHAOA5
T7ffvL8L3J1GFutvVBRC8gsSoLBm7DB3/vN3NZatkGs8A3Li0v+zeJJtlDDSe/b1
N2Lcrmf4capciPEWXDB1OUUgjXa2uEbGizjpezmKNWohasd9PRAg5y0YPVBrFA/P
i57wSuNGEQzTJ0+IbWH9wDWCYibwYRXzuXkNw9b9sPV5f9AoVmWEFBTm8AZ9zpAG
v/kSIeCB1HgoU95scPG2jBajan/bunMwi5EQ4FJEIiCZL9CBAYvJOubxrcIbtSb3
oAbstIFTn+79Ariy2dm4QdygxGZvPnChU/QbQaae6wsYbou/YeFNl+zF5YiQA1+p
zyE3zAo+
=l8i7
-----END PGP SIGNATURE-----

--U6jGr3Ew/WC+R9H0--
