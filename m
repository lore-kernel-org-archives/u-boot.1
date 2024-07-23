Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22B3C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 15:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217BD880D1;
	Tue, 23 Jul 2024 17:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HwF7L4sc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F3B88107; Tue, 23 Jul 2024 17:29:35 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60DF788056
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 17:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-708bf659898so2788089a34.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721748570; x=1722353370; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=maLcJBNspMezKfQRvhyTkbqBwTo8JaIzwXr9GvqHb54=;
 b=HwF7L4scnA2MltNCw2pzX3wP7XQW+7NVGvkZ9MpU1JsxyzjGfjqEi7Alonm3FdDXK+
 MYjclN8cltPvNAgIn3tPRb3bbDje2qEiA9RQzkN9fI1WdC+71fRjsYNZicO0gFkrwGeW
 fz3LClbNpEpy6C8NO/etTDcxUv3hv9mlG96mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721748570; x=1722353370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maLcJBNspMezKfQRvhyTkbqBwTo8JaIzwXr9GvqHb54=;
 b=sUccNJxfyIVtvBKwzKYdW72YMe3GfhxVP9a3bVr+mJCBpz/NVcxKVPpjWGALojgAqK
 bGov/j3lP6zJOLqsn+hT0CR4dX+QyuN2SqPQFyndRFEWHQzbKgBNCozPpnkBMV+wqkOt
 rsLg2DH53+Xf69VBFJgEYJF/F5rlgXhzHRB+DJhaAFCeqdKbUl+KodFh30NruIZz4qDP
 2WnxXcurEPXWtOLGecW4Vi3XgZ6sHFPUd1ySzz3LYciuff+5ffWbmW3CgHfdVH+ntjv0
 GLDjWXSwLHz9ZaFa+7hIs810Bq+LDiEGhka1xnlXUYZBns+xKkT+8iAczQCANtGLHGLs
 J1/A==
X-Gm-Message-State: AOJu0YxTs8PCyPwLbqqBYVYqSMZAWlbtIHi/ZTQRP0u48WHBGuqCgBYY
 jYQkp++suW6SgKDTV2VNCTLW/4bBETLUU1NuDo6YC6TdJOrKPow3Z0IHAL+Fkbg=
X-Google-Smtp-Source: AGHT+IGNq5QkH8PhjcEt4QWPG+pVFTcxJZMQG2ezNebWPlTgwiUlYyE7jhp43CQVsINBM6eUq6sb4Q==
X-Received: by 2002:a05:6830:6c18:b0:704:4d7e:380f with SMTP id
 46e09a7af769-70900899818mr13614457a34.1.1721748570000; 
 Tue, 23 Jul 2024 08:29:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f60d2160sm2043419a34.30.2024.07.23.08.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 08:29:29 -0700 (PDT)
Date: Tue, 23 Jul 2024 09:29:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
Message-ID: <20240723152926.GI989285@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240708140242.GA38804@bill-the-cat>
 <CADg8p968x-UsiHEazS81+DxSXN0DLHpjTEDYDA+0LO=3hGK86A@mail.gmail.com>
 <20240722173325.GA989285@bill-the-cat>
 <CADg8p97bFNApmT+sPPs4MYhyOwzAdK_7M6n__0CaX5iV1MvK-w@mail.gmail.com>
 <20240723144836.GH989285@bill-the-cat>
 <CADg8p96619yU3Li94_JsJx5VUpDpF7SqF3m9McHhQFYLchvktw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BOt2qk4j+IF1pAyB"
Content-Disposition: inline
In-Reply-To: <CADg8p96619yU3Li94_JsJx5VUpDpF7SqF3m9McHhQFYLchvktw@mail.gmail.com>
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


--BOt2qk4j+IF1pAyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 08:21:11PM +0530, Sughosh Ganu wrote:
> On Tue, 23 Jul 2024 at 20:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jul 22, 2024 at 11:07:45PM +0530, Sughosh Ganu wrote:
> > > On Mon, 22 Jul 2024 at 23:03, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Jul 22, 2024 at 11:58:18AM +0530, Sughosh Ganu wrote:
> > > > > On Mon, 8 Jul 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:
> > > > > >
> > > > > > > The aim of this patch series is to fix the current state of
> > > > > > > incoherence between modules when it comes to memory usage. Th=
e primary
> > > > > > > issue that this series is trying to fix is that the EFI memor=
y module
> > > > > > > which is responsible for allocating and freeing memory, does =
not have
> > > > > > > any visibility of the memory that is being used by the LMB
> > > > > > > module. This is further complicated by the fact that the LMB
> > > > > > > allocations are caller specific -- the LMB memory map is not =
global
> > > > > > > nor persistent. This means that the memory "allocated" by the=
 LMB
> > > > > > > module might be relevant only for a given function. Hence one=
 of the
> > > > > > > requirements for making the memory usage visible across modul=
es is to
> > > > > > > make LMB allocations persistent and global, and then have mea=
ns to
> > > > > > > communicate the use of memory across modules.
> > > > > > >
> > > > > > > The first set of patches in this series work on making the LM=
B memory
> > > > > > > map persistent and global. This is being done keeping in mind=
 the
> > > > > > > usage of LMB memory by platforms where the same memory region=
 can be
> > > > > > > used to load multiple different images. What is not allowed i=
s to
> > > > > > > overwrite memory that has been allocated by the other module,
> > > > > > > currently the EFI memory module. This is being achieved by in=
troducing
> > > > > > > a new flag, LMB_NOOVERWRITE, which represents memory which ca=
nnot be
> > > > > > > re-requested once allocated.
> > > > > > >
> > > > > > > A review comment on the earlier version was to do away with t=
he static
> > > > > > > arrays for the LMB lists of free and used memory. This version
> > > > > > > uses the alloced list data structure for the LMB lists.
> > > > > > >
> > > > > > > The second set of patches are making changes to the EFI memor=
y module
> > > > > > > to make use of the LMB functions to allocate and free memory.=
 A
> > > > > > > *_flags() version of LMB API's has been introduced for the sa=
me. The
> > > > > > > earlier version was using notification mechanism from both LM=
B and EFI
> > > > > > > modules to maintain memory coherence. This version makes use =
of the
> > > > > > > LMB API functions for the memory allocations. This is based o=
n review
> > > > > > > comments of EFI maintainers.
> > > > > >
> > > > > > On am64x_evm_a53, the last test in test/py/tests/test_net_boot.=
py fails
> > > > > > due to:
> > > > > > ...
> > > > > > TFTP from server 192.168.116.10; our IP address is 192.168.116.=
23
> > > > > > Filename 'pxelinux.cfg/default-arm-k3'.
> > > > > > Load address: 0x80100000
> > > > > > Loading: ##################################################  64=
 Bytes
> > > > > >          8.8 KiB/s
> > > > > > done
> > > > > > Bytes transferred =3D 64 (40 hex)
> > > > > >   1  pxe          ready   ethernet     0  port@1.bootdev.0     =
     extlinux/extlinux.conf
> > > > > > ** Booting bootflow 'port@1.bootdev.0' with pxe
> > > > > > Retrieving file: pxelinux.cfg/default-arm
> > > > > > am65_cpsw_nuss_port ethernet@8000000port@1: K3 CPSW: rflow_id_b=
ase: 16
> > > > > > link up on port 1, speed 1000, full duplex
> > > > > > Using ethernet@8000000port@1 device
> > > > > > TFTP from server 192.168.116.10; our IP address is 192.168.116.=
23
> > > > > > Filename 'pxelinux.cfg/default-arm'.
> > > > > >
> > > > > > TFTP error: trying to overwrite reserved memory...
> > > > > > Couldn't retrieve pxelinux.cfg/default-arm
> > > > >
> > > > > So this seems to be failing because the address used to load the =
pxe
> > > > > config file seems to be overlapping with an already reserved regi=
on of
> > > > > memory. Can you please check if modifying the address works?
> > > >
> > > > I'm not sure what address you're thinking of modifying but, this is=
n't
> > > > overwriting U-Boot itself so it's a case that needs to work.
> > >
> > > Can you please print the lmb memory map through bdinfo and share it
> > > with me. That will give some info on what is causing the issue. Thing
> > > is, with this patchset, if there is another reservation with a
> > > different flag(like LMB_NOMAP, LMB_NOOVERWRITE), this would cause the
> > > load to fail.
> >
> > Well hunh. I thought I had reproduced the issue before posting, but I
> > just pushed the same tree (I'm fairly certain) over to my lab and the
> > tests are passing now. So, lets just see what happens with the next
> > iteration of the series, sorry for the noise.
>=20
> Okay, I will put out the LMB only, non-rfc series once the CI has gone
> through fine. Btw, I hope you have seen my comment on irc about having
> the SPL_LMB config symbol as a bool, instead of def_bool y. Thanks.

I'll investigate that further once I can poke at the code, thanks.

--=20
Tom

--BOt2qk4j+IF1pAyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmafzEwACgkQFHw5/5Y0
tyxi0Av/VQPP+APS8/2suAsGMiDOPZ32/28FDbAatZsdHTS9It9vs+pNqPweznAR
CGup2qcJeWrrPrSxVWx8vNs+MC3BPLAhOXRcY8j+Sj1ym5BEJDppmpf//sfyAmhH
bwWiH244ob3Uqgy4YNvMuRehw0BJ4Z0AJQdbioNqPh9Ds4TcmQmRguUW7UbH6rFA
pGXGwFPd+kO3YRtBi5fXUBWL5AbuxsWGNQckne5wiQp9f2c/92YDV+6/xNjap3TZ
bqjeMSFqRHI4hcZpj0+2SqW6V/U4wXX8LjKSl9e0NlRchLs8hKHDB+TMvOFUI6Zt
jn24qC79/SEV74Z6Wmn9tBEolhhGDnTDIAZTQHOghWmjOHWhKUy5DUDYkUpEnzd9
GLJbO6fsc+w4iLYIFlY2tzYNmDEfp9KASIK+gqXYMAYRfKiFnoBIa4dG43yStwxb
glL1FhhBSXaJkji1VDYWGeGDV+3RVYfLrgXR4xTdaSaU57csN12FLHkWAF+seJag
bKdJ2gAu
=fKsv
-----END PGP SIGNATURE-----

--BOt2qk4j+IF1pAyB--
