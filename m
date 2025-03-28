Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7BAC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3066D81F0B;
	Fri, 28 Mar 2025 17:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gFqKr9Op";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16489810EA; Fri, 28 Mar 2025 17:04:28 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8716810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c09f8369cso621321a34.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743177864; x=1743782664; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6LXDZMtdiKRz4SF7QnV3RlwlKgcW2Ame88Am7tunhO8=;
 b=gFqKr9OpvIt6e8mtRMgoJ8rVESbS652mi8DdPxGV9seNJQEey+daetWhYDI1BCFNnR
 xAfF2Pnq3MYen/2tPUtUaTR9eRIh91+qYvtH50MtEXJKO1Fhh3jqBGWni0yIl4XJqduR
 GaWKlu/e5ow08GeYOEXFIx1g/9uuhKixeboPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743177864; x=1743782664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LXDZMtdiKRz4SF7QnV3RlwlKgcW2Ame88Am7tunhO8=;
 b=W8oQovbqgNmwP1S1gNWVUgtGaC5jhr8EXKW/Qm4JDRFp/sUr3nv5yb4GyaJewCcK5F
 LAekTAp7xeo8In8vRg5uQ0bqb/QlSJEesw8uj+Xe2hc5x6r1pu9YT5ZZTx9j2pdki7kL
 I1TxknKos0V3ZQcTkSmEPO+EMwnPxhGCel4VPCpt8bvEX7+Ggc+k38Dzd3WMwGKlUAgR
 HSWlaFrGb/Mc2Owqmiy3iB4CIk+3NRmRxFtu10/d6nbo3CiZH7xriZQRYfgVX1ZH8ZdD
 W5680jjjdx4LvMiet7sYurRxeTjlE2w8jLwcKg3Jv+CnGKW5XMxuXHhIK+0IyEvnzDaP
 7d/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjaodGLv/gJu1QlKmOyI87GpcCJryJXQVd2RT+nGljHGsrb8m2l2Kx0dfuC3ORke7zYP3q6vk=@lists.denx.de
X-Gm-Message-State: AOJu0YwdK9ZAow1E3aVecmdl0B7YR6lXFjc3RdK5FXl1LzUf+DGS+FP5
 wlQjmtna7+m2VaIU9N+LBuKJ+h0S5sqCMZmyoHgOCAth27vvNBBfeWY3KLvO3so=
X-Gm-Gg: ASbGncsslErjnzqwRMTMAQjxBSFjxweglUmzdlBk3NoYXzabUVRomnp5NEhVM37JWLp
 7DVD4lraLToR6Pte0E+0kshKYimVeQaW6N0GhhBxwnODdWL7e68pIJNKwRwdBgpdQ4fXRvotIou
 jC2AYSrqaSFOp+ZxuAWElCJJJ35u+HoAnpjG5IDB4Kx3ZRTRn4gtKbKDAwwE8Uei3JgJbtnnKDa
 +Q028gNkY1ik0TgUuSXeEvwJ35nj6GYSbbR1nt47bkZ85uZL3Yraa6DGObpU0zk/5U2MhjlxHXP
 vgEiq0qo9fbPJJDzcfdELa/IPHsOo5S9NMXH8zG1prOUtg6W+VM5bLoWrl3Rf7enBjjIXVRXHd1
 wfIANew==
X-Google-Smtp-Source: AGHT+IHUWiqo7PrWlVOFaxtjLyL3/oyACnMc5EVJgGGICx5EQDwCWk+z7fZyktmVMpVVMlcWxZBicA==
X-Received: by 2002:a05:6830:438e:b0:727:3f3e:53ba with SMTP id
 46e09a7af769-72c4cae182cmr5103398a34.26.1743177864153; 
 Fri, 28 Mar 2025 09:04:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58267b91sm409187a34.52.2025.03.28.09.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 09:04:23 -0700 (PDT)
Date: Fri, 28 Mar 2025 10:04:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, e@freeshell.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Manish Tomar <Manish.Tomar@nxp.com>, Mathew McBride <matt@traverse.com.au>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Robert Marko <robert.marko@sartura.hr>,
 Lukas Funke <lukas.funke@weidmueller.com>, Peng Fan <peng.fan@nxp.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com,
 Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH] efi_loader: remove EFI_BOUNCE_BUFFER
Message-ID: <20250328160419.GX93000@bill-the-cat>
References: <20250317133845.138061-1-ilias.apalodimas@linaro.org>
 <380f1f2c-59cd-4c52-a598-5e6f1ed1dcad@gmx.de>
 <CAC_iWj+DazCNrMktmwJQxt7bVPbu-qWCfjW4bgcv0cngiH03gw@mail.gmail.com>
 <CAFLszTgq25-E-n+UaJ_wRdimCLcAta-fetWpOW++NCOfN_eL5w@mail.gmail.com>
 <CAC_iWjLS_yNPCMY2RhGZ0390ZysH=N5x5JZ-qOnNjX7nofPS4Q@mail.gmail.com>
 <CAFLszThhK4-+Qh_eQLD0fuJZVodBkwit4rw5mOcGU58m6=5knw@mail.gmail.com>
 <CAC_iWj+2EsRUBT5ThAR7+wwxVkFSzrApCNDbTEEHQ-W658LwCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hLehrxlBWO9PIkJf"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+2EsRUBT5ThAR7+wwxVkFSzrApCNDbTEEHQ-W658LwCw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 28 Mar 2025 17:14:05 +0100
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


--hLehrxlBWO9PIkJf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 02:26:39PM +0200, Ilias Apalodimas wrote:
> On Fri, 28 Mar 2025 at 13:34, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 27 Mar 2025 at 15:19, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon
> > >
> > > On Thu, 27 Mar 2025 at 15:33, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Wed, 26 Mar 2025 at 02:37, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Heinrich,
> > > > >
> > > > > On Mon, 24 Mar 2025 at 19:50, Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
> > > > > >
> > > > > > On 17.03.25 14:38, Ilias Apalodimas wrote:
> > > > > >
> > > > > > %s/EFI_BOUNCE_BUFFER/CONFIG_EFI_LOADER_BOUNCE_BUFFER/
> > > > > >
> > > > > > > The EFI subsystem defines its own bounce buffer for devices t=
hat
> > > > > > > can't transfer data > 4GB. U-Boot already has a generic BOUNC=
E_BUFFER
> > > > > > > which can be reused instead of defining another symbol.
> > > > > > > The only limitation for EFI is that we don't know how big the=
 file a user
> > > > > > > chooses to transfer is and as a result we can't depend on all=
ocating the
> > > > > > > memory from the malloc area, which can prove too small.
> > > > > > >
> > > > > > > So allocate an EFI buffer of the correct size and pass it to =
the DM,
> > > > > > > which already supports bounce buffering via bounce_buffer_sta=
rt_extalign()
> > > > > >
> > > > > > Looking at
> > > > > >
> > > > > >      if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
> > > > > >
> > > > > > in drivers/block/blk-uclass.c the bounce buffer has to be expli=
citly
> > > > > > enabled by the device driver. Only the scsi drivers sets bb =3D=
 true.
> > > > > >
> > > > > > Cf. 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buff=
er flag
> > > > > > to blk_desc")
> > > > > >
> > > > > > Which device-drivers of the boards mentioned below do actually =
need
> > > > > > bounce buffering?
> > > > >
> > > > > Unfortunately, I don't have any of the hardware to test and I hav=
ent
> > > > > worked with that platform much.
> > > > > That 'bb' variable and the fact that EFI needs bigger allocations=
 is
> > > > > why I ended up allocationg properly aligned memory from the EFI
> > > > > subsystem. But as Mark pointed out, the cache flush is a no go for
> > > > > now, so I'll drop this and see if I find time to rework the bounce
> > > > > buffer logic overall
> > > >
> > > > There was quite a bit of discussion about all this in the context of
> > > > my attempt to just add a message to warn the user[1]
> > > >
> > > > We might consider adding an event to reserve memory before relocati=
on,
> > > > along with a way to discover (in board_r) where the memory was
> > > > allocated. That would make the solution more generic.
> > >
> > > I am not sure what you are trying to solve here. The EFI bounce buffer
> > > after the LMB patches can't overwrite memory, nor can it be
> > > overwritten.
> >
> > I am thinking of we can create a single implementation of the
> > bouncebuf logic which also works for EFI.
> >
> > I think the two sane things to do are:
> > - restrict U-Boot to using memory below 4GB for platforms which have
> > the DMA limitation
>=20
> You don't need that. The bounce buf code has a callback you can use to
> define the limitations
>=20
> > - create (in board_f) a special region below 4GB for use with the
> > bouncebuf logic
>=20
> The only problem with EFI is that you don't know how much memory it
> needs and we can't use the existing memalign calls. So if we replace
> that memalign in the bounce buffer code, with an lmb reservation we
> have everything we need.

It's not even an EFI problem is it? You could hit the same problem
reading a file from a filesystem outside of EFI too. These specific
SoCs just aren't heavily exercised is one of the challenges I think and
so it's possible that we have a few things to yet improve in the
bounce buffer code (which was added for other SoCs and done as generic
enough starting point for others).

--=20
Tom

--hLehrxlBWO9PIkJf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfmyIMACgkQFHw5/5Y0
tyxi3gv+NpXYr5G1oYTyQtVtjOdKjGPn0Qh0zPMeWnHxHEybg5AynX1yDck+yYUH
fGsYcCktmApk5KfzLMUVmRgrQvY0eK58boaHffkdNIAKbPH4wcLLoz5S1GT7q6Sx
qNWZEsFAqexZxl38hAPd20mzghkNoc/w3tfdIectEZo98yvdnC0lxtIOzQ4D9QWa
GBK0br4xSV99htl4N5ISwmgr6B74Bx3HNuU+JlhkR6yqO0Npnx1XrSZSP8WPMo2C
/PX27m+sp+VXQOS1ekyoOeoOvGMTF7F2+IwrGFVd1Cl+zko5Iem8sNJe+x0ajPKH
cHSEDYGZ5Yq0QJHiII2lsLIbqxEzRVVnFFamdI+oEiO2lsSo4cuzuPnheE7vtQJ3
TeCdqJ5/rt2F1rulmHBujtJyRmx9zAco6IfZ39TOJmK8Yk/tx0RBya9f8YRRScZj
0BDyCHfLtNAFQX3k1ifmqQA7Faoxw/FiIRZWbUhbMkPW8/C9n/C10h23vCLhxk6h
bOCiZOoF
=ShgF
-----END PGP SIGNATURE-----

--hLehrxlBWO9PIkJf--
