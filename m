Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BBDC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1820C86DBD;
	Mon, 22 Jul 2024 19:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wx6cc8sY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B32087EDC; Mon, 22 Jul 2024 19:33:32 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AA9F87D1A
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7039e4a4a03so2579535a34.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721669609; x=1722274409; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KJm6nDWtRcXQ4Nj5mnYmUZoZNhHHYymtgJ+eh3rb1uc=;
 b=Wx6cc8sYGuVMQF3BbrnwdtQn54kYNnQwVBWWznzrtPsxBAy4FBsqR31EGG0HZrLUxg
 yJk2Ft1+mNIjzf5r6KZNzm/PgKH3htKgsCtMNrBD+CWShFETS2K9c0BwwnMpEP6c7SFx
 1tCrEatxmCZpsREBKV+2g+Ki6AQGt5hPWK+wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721669609; x=1722274409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJm6nDWtRcXQ4Nj5mnYmUZoZNhHHYymtgJ+eh3rb1uc=;
 b=ZVphuNUScoJ+OGkvXJucnGp7xt/ApmXUb/XKDf0eFk9ojymjeQomm2l7xzxwN48HDE
 yBO0FO9MA4uTYjiyNodHbKxpNF5Pe/iawaq8qDoXE1OXCoaTXY469vXQeK4KxhsBDwL0
 8uaObV6lY+VLvWwZX3N+akztOcByfA+XJIGgr5GvMP9YLO5r6jK+ivOfV9u/2A5Hq2jF
 350Zo142pxkBAAKoeOkpsoDGMEHHCwFmhMmN6sieNcpR+I55ONT43v5o48lRLJEwJMkG
 cbIwRQvXlEdNT48QDyTImZCD7tsyHYOvVCnfUKSz4KcSIWaNJWg0fFdpwYSlu9PyHdXI
 YUJw==
X-Gm-Message-State: AOJu0Yz9QqcyYAcdzbled73yrYT7fVvewu9rLJ310IugGpMJ+E8mayWA
 QWTZQFOFb0GNoJKXQobgYntCCPHB0Fm6XCBQ+8JFBDvIT9Pd+bcATbH/EP+5TBw=
X-Google-Smtp-Source: AGHT+IEy2aWoag+7K+zNgQ8SlcfI9njFHxMFKrmT2uC6T9rgmItQprtjIFM7UPI6zOUUuXqSGfsy1w==
X-Received: by 2002:a05:6830:6209:b0:703:6d44:41a5 with SMTP id
 46e09a7af769-708fdadef23mr11560822a34.6.1721669608962; 
 Mon, 22 Jul 2024 10:33:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60a55e1sm1604445a34.11.2024.07.22.10.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:33:28 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:33:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
Message-ID: <20240722173325.GA989285@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240708140242.GA38804@bill-the-cat>
 <CADg8p968x-UsiHEazS81+DxSXN0DLHpjTEDYDA+0LO=3hGK86A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KC9YLLUOEOCyMhbA"
Content-Disposition: inline
In-Reply-To: <CADg8p968x-UsiHEazS81+DxSXN0DLHpjTEDYDA+0LO=3hGK86A@mail.gmail.com>
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


--KC9YLLUOEOCyMhbA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 11:58:18AM +0530, Sughosh Ganu wrote:
> On Mon, 8 Jul 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:
> >
> > > The aim of this patch series is to fix the current state of
> > > incoherence between modules when it comes to memory usage. The primary
> > > issue that this series is trying to fix is that the EFI memory module
> > > which is responsible for allocating and freeing memory, does not have
> > > any visibility of the memory that is being used by the LMB
> > > module. This is further complicated by the fact that the LMB
> > > allocations are caller specific -- the LMB memory map is not global
> > > nor persistent. This means that the memory "allocated" by the LMB
> > > module might be relevant only for a given function. Hence one of the
> > > requirements for making the memory usage visible across modules is to
> > > make LMB allocations persistent and global, and then have means to
> > > communicate the use of memory across modules.
> > >
> > > The first set of patches in this series work on making the LMB memory
> > > map persistent and global. This is being done keeping in mind the
> > > usage of LMB memory by platforms where the same memory region can be
> > > used to load multiple different images. What is not allowed is to
> > > overwrite memory that has been allocated by the other module,
> > > currently the EFI memory module. This is being achieved by introducing
> > > a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> > > re-requested once allocated.
> > >
> > > A review comment on the earlier version was to do away with the static
> > > arrays for the LMB lists of free and used memory. This version
> > > uses the alloced list data structure for the LMB lists.
> > >
> > > The second set of patches are making changes to the EFI memory module
> > > to make use of the LMB functions to allocate and free memory. A
> > > *_flags() version of LMB API's has been introduced for the same. The
> > > earlier version was using notification mechanism from both LMB and EFI
> > > modules to maintain memory coherence. This version makes use of the
> > > LMB API functions for the memory allocations. This is based on review
> > > comments of EFI maintainers.
> >
> > On am64x_evm_a53, the last test in test/py/tests/test_net_boot.py fails
> > due to:
> > ...
> > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > Filename 'pxelinux.cfg/default-arm-k3'.
> > Load address: 0x80100000
> > Loading: ##################################################  64 Bytes
> >          8.8 KiB/s
> > done
> > Bytes transferred =3D 64 (40 hex)
> >   1  pxe          ready   ethernet     0  port@1.bootdev.0          ext=
linux/extlinux.conf
> > ** Booting bootflow 'port@1.bootdev.0' with pxe
> > Retrieving file: pxelinux.cfg/default-arm
> > am65_cpsw_nuss_port ethernet@8000000port@1: K3 CPSW: rflow_id_base: 16
> > link up on port 1, speed 1000, full duplex
> > Using ethernet@8000000port@1 device
> > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > Filename 'pxelinux.cfg/default-arm'.
> >
> > TFTP error: trying to overwrite reserved memory...
> > Couldn't retrieve pxelinux.cfg/default-arm
>=20
> So this seems to be failing because the address used to load the pxe
> config file seems to be overlapping with an already reserved region of
> memory. Can you please check if modifying the address works?

I'm not sure what address you're thinking of modifying but, this isn't
overwriting U-Boot itself so it's a case that needs to work.

--=20
Tom

--KC9YLLUOEOCyMhbA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmael+IACgkQFHw5/5Y0
tyyqCQv+JWoa93dOeDMJZWgS7qYd26Y6aEW8QqVIkXNgfe6tAxW8oy0sr9sQ1wie
haCCXTHycbSt6tWPwCNuj4lHobPQwwwGWJQ+NGKgemOMFEXr452KuSE7t3niGsfq
2Z/nxRmhRbkuR795A//KcueuOJ7fS/V+Kx2HO7Q0kmeb/pTHduaVUSUDozZz+qoa
IgZr3iCiUups2TdiwzOn5kGka0+fhA6SSY+/EQArBiwVmYSu9yWSaw+E//WVrelq
qFDgXr5Xv1Cjd3mvMHOO0Oa3U6DsSwKL00DjB8kHRKvHJin6eJG20sgauYuyPJiz
5d+0kpEJUehN+6KMw4ifQo+HxrkNzJkwKhzxHMFRYjJEQXj3J5Nti2/AwH/jA6Ng
wJZRmwE34Qop/BC4fcfO/v0ifpPJqvravo5f9gzTYD+zKT9DU1XXhE/gB1XWZKuf
int3eGp8bcwL6nOuiusqm2flVfF3YgIEwB5D1LW8dUqX8JQJ0St5e/4GkoKrVABG
bzayeEXs
=oVUb
-----END PGP SIGNATURE-----

--KC9YLLUOEOCyMhbA--
