Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B91ACCF9EB
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 00:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B044B8331F;
	Thu, 30 Oct 2025 01:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hNdXq+za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96ED08334F; Thu, 30 Oct 2025 01:54:49 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19B41832BC
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 01:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3d18422565eso402530fac.1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 17:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761785686; x=1762390486; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AFZWxiQqIQpjEd/WrOkiNjLJ8AvrcKUuOQkeH6VxkIQ=;
 b=hNdXq+zanriEuL4S7BhXJijKOY07pq4J+q7Hh36iHds6qmtp6WwX3BwW185rfn4bvA
 fmq5fWk2EqXcrJS3HgwLY96FzwtPmflmTeognqKSt8u+Cveu4mV50iNYE/wNgpjOwMFg
 zKK8bvipW38vHUloUGqqSxSAhxZh4yhEZh34Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761785686; x=1762390486;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFZWxiQqIQpjEd/WrOkiNjLJ8AvrcKUuOQkeH6VxkIQ=;
 b=Lj8KXSDer9/h0pPoZpktSwOwkF9bO/sV8NQaZc6Q/QFONHh574PVuMYrfo2I+dhoqw
 6fcSR2OEWrgQhMaWe06n/kggdu6DMBysB3pdGxAOANT4Yo7HpxXNNA3TyiQ6n6mgwS7e
 SMpZRGWiEATif8SF+dkrH0wtpyBAwoJqfdx2L+TUeiNhcxsxLrf6WkEVo9eQfUrI3C2g
 Zu3DL00bKEngunlBA9GpxmDLAmwcrx2Vh3kEbmW+UKcVnapSsmGHJ6qboYYsEP/mX+bt
 w1oprsreZ/ecAQ89SCBkX5XUn6oor8Iq7e63MXm6LG3+issc/1k1wcL4h0VMrvNC6HTY
 K6HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU61qVarslX0FaQdYOZVCaJK7IQGAFH2ESNrDolqcxZlcD2ktY13hnLf8IDaZWAZeBc0iwee+Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yzp++9HwDRXQvCMpUJXgrt94tWoIMXdo5141Fhk+Ezsp+z2cs65
 SEcUxHosEzRX1D70ykTIpmib8Sq3r8leUwLVArdN0icQyYfyeAOUBrTY7ixHLJjTAKU=
X-Gm-Gg: ASbGncsF4BUsYXi1kBb9tZk1z6Rx6Wp9z2qjmAx6UJFIVBBRNIImjli3E6Zquf0r6LF
 N4HlqsCSkzZqijQJcwRwEjy5+ZHdTv0joiN5raH0bwhM5GiizMWafeD8LVYPof9YW2c/tZT5K3w
 0YjPM9mKaJOjyaY3Ma4XpYIvKOCfeZI/haisdQeZYybA7Khh6w77CUNS/0919HFMH7asoBCwOwL
 NmL1mbiMSv51tOVMejFOaCp9CxIStiwxAavnVfpRXKPVUfzDaPGlBguOjq1wUOdHyV/eNpnPhv6
 KfBZ1eeDoMySw6JCHY1sqjCPyQYYgeO94Io9E5Wd1nvfiCOGVjdCO5fMJhtpyA1GkuZe11jhfJ/
 WyUmruVlXQQ+8qpp5d1FRQT96DlyfF7yDEOMVIGqdcNQ7PbGso0fozJgCJ0ALa4lu5wQC7AnFJi
 7WTYHGAkQ0d1zkmb+HFhphjSEai/Zf0DexeqSk+5I=
X-Google-Smtp-Source: AGHT+IHzB2QBKKr7rH//579VMBrvVvS49ZNb42s79MSOIrc+VhIiDfn/kIJL8gkk2LQJ5vogw6ipvg==
X-Received: by 2002:a05:6870:ac0e:b0:3d2:4f4a:9212 with SMTP id
 586e51a60fabf-3d745d95514mr2647373fac.3.1761785685711; 
 Wed, 29 Oct 2025 17:54:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e20f1c0csm5321485fac.0.2025.10.29.17.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 17:54:44 -0700 (PDT)
Date: Wed, 29 Oct 2025 18:54:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>, 
 dl-uboot-imx <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ye Li <ye.li@nxp.com>, Beleswar Padhi <b-padhi@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>,
 Ryan Eatmon <reatmon@ti.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 00/12] remoteproc: Add support for i.MX8M[M/N/P/Q] and
 i.MX93
Message-ID: <20251030005441.GQ6688@bill-the-cat>
References: <20251022-imx-rproc-v3-v3-0-92273a82c5da@nxp.com>
 <CAOMZO5ASxBCdTQFfoUA7k5aXKwQZS+MC75kHw7uHoHsF1AgbcQ@mail.gmail.com>
 <20251028121607.GF9371@nxa18884-linux.ap.freescale.net>
 <PAXPR04MB84591B0C66FE17F3E0792BB988FBA@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="usPbJs5tOB+I/q51"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84591B0C66FE17F3E0792BB988FBA@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--usPbJs5tOB+I/q51
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:31:50AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v3 00/12] remoteproc: Add support for
> > i.MX8M[M/N/P/Q] and i.MX93
> >=20
> > Hi Fabio,
> >=20
> > On Sun, Oct 26, 2025 at 08:28:50AM -0300, Fabio Estevam wrote:
> > >Hi Peng,
> > >
> > >On Tue, Oct 21, 2025 at 9:48=E2=80=AFPM Peng Fan <peng.fan@nxp.com>
> > wrote:
> > >>
> > >> CI: https://dev.azure.com/pengfan/uboot-
> > ci/_build/results?buildId=3D21
> > >>
> > >> This patch series introduces remoteproc support for NXP i.MX8M
> > and
> > >> i.MX93 platforms. Most of the i.MX-specific logic is ported from the
> > >> Linux kernel to ensure compatibility and maintainability.
> > >
> > >I'm getting the following ut_dm_dm_test_remoteproc_elf error in
> > Gitlab CI:
> > >
> > >https://source.denx.de/u-boot/custodians/u-boot-imx/-
> > /jobs/1274168#L276
> >=20
> > Not sure why it fails, my azure CI pass.
> > I build this with sandbox64_defconfig using my local PC and run ./u-
> > boot -d arch/sandbox/dts/sandbox64.dtb With command: ut dm
> > dm_test_remoteproc_elf I not see failures.
> >=20
> > Let me rebase to latest master, push to CI and retest.
>=20
> Still no clue why sandbox amd64 pass, but sandbox arm64 clang fail.
>=20
> More and more I am thinking this might be compiler or else caused
> the issue.
>=20
> I am not sure how to run the arm64 sandbox clang test at my local,
> I built sandox64 with aarch64 gcc and ran it on i.MX8MP-EVK, no
> issue.

How about with aarch64 clang on that device? I would hope you could grab
the official aarch64 binaries, but as a worst case, building an image
with OpenEmbedded that includes llvm, etc, should suffice.

--=20
Tom

--usPbJs5tOB+I/q51
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQK3TgAKCRAr4qD1Cr/k
CrXqAQDSPtLkAZJNB6DPMxrhckZoa9XQlg8v+HFoASWPOS98cgEA5UvZCxjAZcqQ
su6SeoOetL29uGjJOFwo1P6cJf5IIgc=
=Gju9
-----END PGP SIGNATURE-----

--usPbJs5tOB+I/q51--
