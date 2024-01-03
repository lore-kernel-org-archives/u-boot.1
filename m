Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4635C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 15:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8E28772E;
	Wed,  3 Jan 2024 16:50:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sfiLtn2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E42278773D; Wed,  3 Jan 2024 16:50:47 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD53875EB
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 16:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-781251ed685so823426685a.3
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 07:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704297044; x=1704901844; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NduOJimhxRoJot5950GdvS/62+r2TssAViapO4SLcuI=;
 b=sfiLtn2iYjiXTR6DCFtOgv8UY6gER+syR+FuDom4S0UlkHT2u2KEE2Pz3DQHiAfwdH
 6209eVCSNrPnYOkEs0f45VLWobeEE0chRpYFvWuNBPi9ugUs8vG+8IIcvmweB7wwoOa5
 No8xRHnPf9c3lv6OIautJHtRXqIUZu8R153VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704297044; x=1704901844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NduOJimhxRoJot5950GdvS/62+r2TssAViapO4SLcuI=;
 b=HtuLynN+zTV5IB5BRDGAfs+bPUmVIk+TW4LrIaVMsYjYzKPoGqk3NFY1/y4VUGdetA
 tC148a97cWa/yFnjiJGRHJlcFRaSWsvngWqhEj3W2w1LofP64u65YCs3Sat6YU2rcHyD
 PXORI6CtOSUIRGc/is9WN7IfJ8Lze4P/iKJTjXpGS/jSZ80w/qh5pVWIrhEc0S6I4cO4
 q1IeYc7+MmrVKBJpQlaxwVqGFUtxDtUGAxBiIaZHq2K7jt0uQNkj6EkxVKAMAqXnjdW/
 7KuZ2fJOX9NXdZZf4PxSkZ1Ch7N/QZkDI+SOmy7xT4/Vn71dg/PnWP0nwWYxzwz2CWvq
 ScUw==
X-Gm-Message-State: AOJu0YxdRD7ytOozRQ7hH1NeuRp3epQ0MoqtwXLShWSEWd/8N0tq0U9L
 kmLDQLbM/PxilnKpXN9b867wA6QfS/ssXQ==
X-Google-Smtp-Source: AGHT+IHwcOZVr9oR8ghWjhGioJ/+Tj64YuJBisjthO/8Nb5INLa+tJ1nUSuJ1tAGTV750f9pdOsxQg==
X-Received: by 2002:a05:620a:24d5:b0:781:2766:3979 with SMTP id
 m21-20020a05620a24d500b0078127663979mr26108224qkn.26.1704297044202; 
 Wed, 03 Jan 2024 07:50:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 w3-20020a05620a0e8300b00781cc3f50desm2001535qkm.0.2024.01.03.07.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 07:50:43 -0800 (PST)
Date: Wed, 3 Jan 2024 10:50:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Subject: Re: [PATCH 00/26] sync am65x device tree with Linux v6.7-rc1
Message-ID: <20240103155041.GK1610741@bill-the-cat>
References: <20231221174412.210807-1-bb@ti.com>
 <20231221200056.GM2513409@bill-the-cat>
 <20231227123928.rt2wgr3qa7rw5jmf@imitate>
 <b4068fbd-e008-47a3-b2bc-b6c97f44df11@siemens.com>
 <20240102174232.GN2652760@bill-the-cat>
 <ee42d38d-c306-4451-911e-04ccdf84fc98@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2DfV5Or8vEo1OdqJ"
Content-Disposition: inline
In-Reply-To: <ee42d38d-c306-4451-911e-04ccdf84fc98@siemens.com>
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


--2DfV5Or8vEo1OdqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 06:10:55AM +0100, Jan Kiszka wrote:
> On 02.01.24 18:42, Tom Rini wrote:
> > On Tue, Jan 02, 2024 at 08:27:34AM +0100, Jan Kiszka wrote:
> >> On 27.12.23 13:39, Nishanth Menon wrote:
> >>> On 15:00-20231221, Tom Rini wrote:
> >>>> On Thu, Dec 21, 2023 at 11:43:46AM -0600, Bryan Brattlof wrote:
> >>>>
> >>>>> Hello Everyone!
> >>>>>
> >>>>> This series gets the am65x booting again along with syncing the dev=
ice
> >>>>> tree files with v6.7-rc1 Linux.
> >>>>>
> >>>>> The bulk of these patches unify the WKUP SPL board file with the ar=
m64
> >>>>> files to make future syncs from Linux much easier. In the end the D=
TBs
> >>>>> should look a lot like what the DTBs look like for the am64x which
> >>>>> is fairly similar to the am65x.
> >>>>>
> >>>>> For those interested in what UART boot looks like:
> >>>>>    https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef32=
87bc
> >>>>>
> >>>>> Thanks for reviewing and happy holidays
> >>>>> ~Bryan
> >>>>
> >>>> For the series,
> >>>> Tested-by: Tom Rini <trini@konsulko.com>
> >>>>
> >>>> Nishanth, does this path work for you?
> >>>>
> >>>
> >>> Other than the minor comments provided in the relevant patches,
> >>>
> >>> The following files also need sync up with v6.7-rc1.
> >>>
> >>> k3-am65-iot2050-common-pg2.dtsi
> >>> k3-am65-iot2050-common.dtsi
> >>> k3-am6528-iot2050-basic-common.dtsi
> >>> k3-am6548-iot2050-advanced-common.dtsi
> >>> k3-am6548-iot2050-advanced-m2.dts
> >>>
> >>> Jan - could you look at syncing those once an update to this series is
> >>> posted? We could probably have a smoother v6.8-rc1 from then on.
> >>>
> >>
> >> We currently plan to sync once support for the new SM variant is in the
> >> upstream DT. Do you see other changes that would benefit from an earli=
er
> >> sync?
> >=20
> > So this sync is because the ref platforms at least do not boot, is
> > iot2050 currently booting?
>=20
> It was booting with ~v2024.01-rc4 before Christmas, didn't try latest
> master yet.

OK, then it should still be fine but please do confirm if you have the
cycles, thanks.

--=20
Tom

--2DfV5Or8vEo1OdqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWVgkcACgkQFHw5/5Y0
tywp2gv/VClbEcjaciSfDhTUXyDdpNeBIzJXVX+pW85Alz1diYXgKk18Vrg9pGdD
VAFiycVtKHl+vWn4+skudX+jSwrUSZII73Pcr4+y2J/fm1YtKphwLxoQtBM6POds
Hsp+o+oCx2zsevDOvSAFKcjGEPtIoFeyp49RJy8QN/g1ChCpt6/AUco2ZzvGi9Wd
PyY5fAaiQjqz/Epf9wldFK1n7ECnrSAtFfuX7LO2JVvX36P6t+y6NbaZjsu13yUW
q/C/g/hHgrde13gbOWwxn8WHMhrczQJJf1V1Z5tbaLCxp2/f3Xuuc2rBv9mpSmEF
ukjcOnP4OkO21oEo3hmN+6w3fjCwg0Uduw4aasaQYwbB/qHEHuiABk8wSJMkmvwu
HU9U5ICi8YAbYnf7kbaSElwq91hcxMHskzMzEd1tcMpf1kO7BQxypoXFG2QwTCfz
nP96dkBiMlHGKXqqHSSQtr5ZzKXsZL5RROJXSgNyg5UtSEt4zJ4dVCnn/q2FoY8L
QPnpbY61
=OiMj
-----END PGP SIGNATURE-----

--2DfV5Or8vEo1OdqJ--
