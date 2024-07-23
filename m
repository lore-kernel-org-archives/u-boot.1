Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C76C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 14:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3451487B1D;
	Tue, 23 Jul 2024 16:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UJ64WTPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C35087C7E; Tue, 23 Jul 2024 16:48:48 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2FC87A6D
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-70448cae1e0so2987782a34.3
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721746119; x=1722350919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k1gbeCQxqfeGkYcLx6JRBcvqM8SnljoMu2vQMHPu8+o=;
 b=UJ64WTPPjG33XzdorVXERUBlncL9OMD0flCEHYUTdGieo6UG/y2AMitskWEpTevBDo
 MWE2U7rT34WIiLoOSQtbN0a5lJwIbQOIPeGahBVTYhgHCdm1pgt+rnAbwFqAj2/TC3Yk
 xE9nfUEHwoPnX9SCJYC4pjjbf0W6avGrSMU18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721746119; x=1722350919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1gbeCQxqfeGkYcLx6JRBcvqM8SnljoMu2vQMHPu8+o=;
 b=Tb57EloZFoCITwc4qUAXp2ipL//N53YTO6/DTpQAYm2G5gZDCfH8POshKGye5mCUZM
 4GVMIzo7NcGuaqPehfAdpn1iE7D9Imt9BkUm+sR/NIWrP9wkyZZwYs/RQQDdg8sMlVsw
 vKFXiA6qECzMBy5QXpcLAAfeRHcvUD0CqGsbLC8ZG/icvglSFQH8bI8ppf01f0S/Uz8y
 i8bIVq9UL5sL4LTsap8YGtwP+NXQCokjZxrCW3lCS5nTt4u0RuhsowboLY7bozAsAMjD
 +CdmN2j9Bt62Ck6vQ41mPWs8WEQUrYs/l2Oyn5wlenRZQm2x4gHh6luR1rf+23ULOYcH
 1Mhw==
X-Gm-Message-State: AOJu0YzsS481/CxjXCvqIIOIUeXlqlVEAduHO24I3+bB3Jv3LumYa1dU
 JoBdWX2H02XlRyoRAAxXQiHC5yg9XngnvtGEY9AHJags0k9UKSjefZN7YbEWBwo=
X-Google-Smtp-Source: AGHT+IHhIjzmCFZTPbCJzzf7RVDjqW++03tPVqNvsQeATZ0lJlR6VFUvIgfAQQGufRWL/rPHMvVHbA==
X-Received: by 2002:a05:6830:64ca:b0:704:4b6f:ac87 with SMTP id
 46e09a7af769-7090092798fmr11870220a34.17.1721746119585; 
 Tue, 23 Jul 2024 07:48:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f61913b8sm2023288a34.68.2024.07.23.07.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:48:38 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:48:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
Message-ID: <20240723144836.GH989285@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240708140242.GA38804@bill-the-cat>
 <CADg8p968x-UsiHEazS81+DxSXN0DLHpjTEDYDA+0LO=3hGK86A@mail.gmail.com>
 <20240722173325.GA989285@bill-the-cat>
 <CADg8p97bFNApmT+sPPs4MYhyOwzAdK_7M6n__0CaX5iV1MvK-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w0PtqE7kbAHM5k4X"
Content-Disposition: inline
In-Reply-To: <CADg8p97bFNApmT+sPPs4MYhyOwzAdK_7M6n__0CaX5iV1MvK-w@mail.gmail.com>
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


--w0PtqE7kbAHM5k4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:07:45PM +0530, Sughosh Ganu wrote:
> On Mon, 22 Jul 2024 at 23:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jul 22, 2024 at 11:58:18AM +0530, Sughosh Ganu wrote:
> > > On Mon, 8 Jul 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:
> > > >
> > > > > The aim of this patch series is to fix the current state of
> > > > > incoherence between modules when it comes to memory usage. The pr=
imary
> > > > > issue that this series is trying to fix is that the EFI memory mo=
dule
> > > > > which is responsible for allocating and freeing memory, does not =
have
> > > > > any visibility of the memory that is being used by the LMB
> > > > > module. This is further complicated by the fact that the LMB
> > > > > allocations are caller specific -- the LMB memory map is not glob=
al
> > > > > nor persistent. This means that the memory "allocated" by the LMB
> > > > > module might be relevant only for a given function. Hence one of =
the
> > > > > requirements for making the memory usage visible across modules i=
s to
> > > > > make LMB allocations persistent and global, and then have means to
> > > > > communicate the use of memory across modules.
> > > > >
> > > > > The first set of patches in this series work on making the LMB me=
mory
> > > > > map persistent and global. This is being done keeping in mind the
> > > > > usage of LMB memory by platforms where the same memory region can=
 be
> > > > > used to load multiple different images. What is not allowed is to
> > > > > overwrite memory that has been allocated by the other module,
> > > > > currently the EFI memory module. This is being achieved by introd=
ucing
> > > > > a new flag, LMB_NOOVERWRITE, which represents memory which cannot=
 be
> > > > > re-requested once allocated.
> > > > >
> > > > > A review comment on the earlier version was to do away with the s=
tatic
> > > > > arrays for the LMB lists of free and used memory. This version
> > > > > uses the alloced list data structure for the LMB lists.
> > > > >
> > > > > The second set of patches are making changes to the EFI memory mo=
dule
> > > > > to make use of the LMB functions to allocate and free memory. A
> > > > > *_flags() version of LMB API's has been introduced for the same. =
The
> > > > > earlier version was using notification mechanism from both LMB an=
d EFI
> > > > > modules to maintain memory coherence. This version makes use of t=
he
> > > > > LMB API functions for the memory allocations. This is based on re=
view
> > > > > comments of EFI maintainers.
> > > >
> > > > On am64x_evm_a53, the last test in test/py/tests/test_net_boot.py f=
ails
> > > > due to:
> > > > ...
> > > > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > > > Filename 'pxelinux.cfg/default-arm-k3'.
> > > > Load address: 0x80100000
> > > > Loading: ##################################################  64 Byt=
es
> > > >          8.8 KiB/s
> > > > done
> > > > Bytes transferred =3D 64 (40 hex)
> > > >   1  pxe          ready   ethernet     0  port@1.bootdev.0         =
 extlinux/extlinux.conf
> > > > ** Booting bootflow 'port@1.bootdev.0' with pxe
> > > > Retrieving file: pxelinux.cfg/default-arm
> > > > am65_cpsw_nuss_port ethernet@8000000port@1: K3 CPSW: rflow_id_base:=
 16
> > > > link up on port 1, speed 1000, full duplex
> > > > Using ethernet@8000000port@1 device
> > > > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > > > Filename 'pxelinux.cfg/default-arm'.
> > > >
> > > > TFTP error: trying to overwrite reserved memory...
> > > > Couldn't retrieve pxelinux.cfg/default-arm
> > >
> > > So this seems to be failing because the address used to load the pxe
> > > config file seems to be overlapping with an already reserved region of
> > > memory. Can you please check if modifying the address works?
> >
> > I'm not sure what address you're thinking of modifying but, this isn't
> > overwriting U-Boot itself so it's a case that needs to work.
>=20
> Can you please print the lmb memory map through bdinfo and share it
> with me. That will give some info on what is causing the issue. Thing
> is, with this patchset, if there is another reservation with a
> different flag(like LMB_NOMAP, LMB_NOOVERWRITE), this would cause the
> load to fail.

Well hunh. I thought I had reproduced the issue before posting, but I
just pushed the same tree (I'm fairly certain) over to my lab and the
tests are passing now. So, lets just see what happens with the next
iteration of the series, sorry for the noise.

--=20
Tom

--w0PtqE7kbAHM5k4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmafwsAACgkQFHw5/5Y0
tyy0kQv9GCETgC9oi43TOebCtTYjDHtDfnFRDFn7LYNw00sw/RUb03+Vp5Yi1st7
8v9aSkj4ex95eRL5F55no6N1f06du7Ui8b7Ubf+9zTWkWGgU8B6jB/4EhcvlPs/I
bEM6NSgg8VIV4Ik2VWZXF1KBf7T/sxJCNVUBybdPpqiFdo/PXVAzBgbIGT6UAXCl
IKd5aDmAjdxpdOuE8HJ2Xq1hevSQrW3Xly9tgqm1xIf9xuR9nvTKZFrkjUu/CopL
HT3+mlbboJy+DcdJGPfpr+CJT/wFIxCGkHHHKdii678A4/M6E7DehQfHwzqlr5pA
GmF0xRUFwyQ53+gVfpPDQe8cJrs4WndKUZvQZHL6/gvSdbzmvacu6lE4q5V72wF4
Nm3qYcRyKUiXJsBdxmNweeZaW/poD8Jy18Iw0lVpTa2ft5ynO9hTNaG6DdTaj0XB
7tQUdfp9lltXt12COn5FoxKasfVoQ4hhGQzXs4yHXCwUBFi8OqKqrwI5Udr0ol3g
rR6oSVxl
=t2Yk
-----END PGP SIGNATURE-----

--w0PtqE7kbAHM5k4X--
