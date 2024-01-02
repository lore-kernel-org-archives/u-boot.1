Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CDAC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 17:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 295558787E;
	Tue,  2 Jan 2024 18:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CFiFS+Zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89533878D3; Tue,  2 Jan 2024 18:42:39 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F6B08773E
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 18:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-781716c1291so412006085a.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704217356; x=1704822156; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=za0mf2yxaTeQCKBC4s5wqh36aIyTNC9x43IB8MyQUVI=;
 b=CFiFS+Zkn8x0Ab3/mFQD1T0pirkUuK9WQYJHpBGW3i0sS357zW2O+HtYRtW4noK+Im
 s+WD/0Ny3FSU9X64HfKQMiDZOkDXwkNJF6vBB5IrffJyXLJoR9ywgKlzFcYfRVpuBYGs
 gEVhXWcAW7bzLJsVHq0csvHbyBYNS/mY8/uAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704217356; x=1704822156;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=za0mf2yxaTeQCKBC4s5wqh36aIyTNC9x43IB8MyQUVI=;
 b=WhClJ5xQfFnl3Wd98GPpX3toIWjXrxQsQEu3tHtwmMl1isHAekFW3vLNiNMvvePkeZ
 wLxuvn5P8Nv7kF5bthoX/K7K27Xr8U59JF96YknI2AXOb9fqCx1KRs8bNxo3yQ7//6ZL
 d0aH7dsg/zJr5s73zyNYGILw0ZRpB1LXkDR825CMG6OKFn0eFDKpM9jZxfr7MunHxYgE
 onfToWWEVxm1SXuIgQxFjqrzmZKoehAcjFbBeO+CWh+BoR+BjB7PJJDoThQQuz3IKfJv
 D8c4JWA1UjZzaHsRVKlno67rmTjpHyLY/aGJcK4d+5Pv2wW6P2F6sXAk4BCOqi15kMZ4
 9R7Q==
X-Gm-Message-State: AOJu0YxRnzz8RyP5lzounoM6png4eL1wRoftjm5vtfJ691InYmHSLGXf
 6aZ78J8EdAdt7pw12RJGwGuoGLaxhhzMXA==
X-Google-Smtp-Source: AGHT+IFLJnh881X5m3o0z1T9w/P5u01Wlq4L1583ERgg9EmECip7le+yuoGTuF/eYvWE5t1ch2ofRw==
X-Received: by 2002:ac8:5fce:0:b0:425:4043:5f1b with SMTP id
 k14-20020ac85fce000000b0042540435f1bmr28239171qta.89.1704217355647; 
 Tue, 02 Jan 2024 09:42:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 l8-20020ac84cc8000000b004257bf9a394sm13024730qtv.14.2024.01.02.09.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 09:42:35 -0800 (PST)
Date: Tue, 2 Jan 2024 12:42:32 -0500
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
Message-ID: <20240102174232.GN2652760@bill-the-cat>
References: <20231221174412.210807-1-bb@ti.com>
 <20231221200056.GM2513409@bill-the-cat>
 <20231227123928.rt2wgr3qa7rw5jmf@imitate>
 <b4068fbd-e008-47a3-b2bc-b6c97f44df11@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z/5rE/U5FZHjGU0G"
Content-Disposition: inline
In-Reply-To: <b4068fbd-e008-47a3-b2bc-b6c97f44df11@siemens.com>
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


--z/5rE/U5FZHjGU0G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 08:27:34AM +0100, Jan Kiszka wrote:
> On 27.12.23 13:39, Nishanth Menon wrote:
> > On 15:00-20231221, Tom Rini wrote:
> >> On Thu, Dec 21, 2023 at 11:43:46AM -0600, Bryan Brattlof wrote:
> >>
> >>> Hello Everyone!
> >>>
> >>> This series gets the am65x booting again along with syncing the device
> >>> tree files with v6.7-rc1 Linux.
> >>>
> >>> The bulk of these patches unify the WKUP SPL board file with the arm64
> >>> files to make future syncs from Linux much easier. In the end the DTBs
> >>> should look a lot like what the DTBs look like for the am64x which
> >>> is fairly similar to the am65x.
> >>>
> >>> For those interested in what UART boot looks like:
> >>>    https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287=
bc
> >>>
> >>> Thanks for reviewing and happy holidays
> >>> ~Bryan
> >>
> >> For the series,
> >> Tested-by: Tom Rini <trini@konsulko.com>
> >>
> >> Nishanth, does this path work for you?
> >>
> >=20
> > Other than the minor comments provided in the relevant patches,
> >=20
> > The following files also need sync up with v6.7-rc1.
> >=20
> > k3-am65-iot2050-common-pg2.dtsi
> > k3-am65-iot2050-common.dtsi
> > k3-am6528-iot2050-basic-common.dtsi
> > k3-am6548-iot2050-advanced-common.dtsi
> > k3-am6548-iot2050-advanced-m2.dts
> >=20
> > Jan - could you look at syncing those once an update to this series is
> > posted? We could probably have a smoother v6.8-rc1 from then on.
> >=20
>=20
> We currently plan to sync once support for the new SM variant is in the
> upstream DT. Do you see other changes that would benefit from an earlier
> sync?

So this sync is because the ref platforms at least do not boot, is
iot2050 currently booting?

--=20
Tom

--z/5rE/U5FZHjGU0G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWUSwEACgkQFHw5/5Y0
tyy+YQv9EAr1tSyg9KWy4+2dWl3eKdFFk9p4W3c50/V1hXFSRHdsJhMllFWvvqxM
LiByDrThmV2xtKfkdSO4sjNnvpVzpjfeboZnFI4gTXkAoB1cu/cvNTjS91dd9O53
59iQMPHsBQPLbLd4VIUhVEKKs//DDuNwNB8KuYSKPbd9mbwPiPdwu+PJcy7ORd4a
Eh/FhUfpcA72OVDP1HhaI352WuSYIaPZZ8MmvvFuLuBdJfJ2e06mWedFV5ynqaz4
TtBAF5mx2aPjScD1DETPhzTenveF+K2yzXEnT6nJ8KXxf5Xd6D4IaeUB0W35X9d2
fWp5G0uV5xtm8WV9NW7s1Y8RHwp1a76yNI4lOMuzJXBv1cyi6q4L6ZQqJYaRbAWg
njaK3QsMpGviHux9AK5fWfpcjTyT/4X9kW9j1LQZKSNM7KbHO1AO7luKRRVKP4Gu
0GyeQ5tTBSvWlxtPxi77dVoo/A6o35DhBnNpWU4tt7YDMoiCAdlhEv/st6gFGFYn
jILtK2T0
=vksn
-----END PGP SIGNATURE-----

--z/5rE/U5FZHjGU0G--
