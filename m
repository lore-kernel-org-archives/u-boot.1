Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F52C2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 06:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC0988590;
	Fri, 28 Jun 2024 08:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="sA/jNMFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F21C48859F; Fri, 28 Jun 2024 08:34:49 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4768088585
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 08:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=902a16d01=Conor.Dooley@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1719556488; x=1751092488;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=UTMes7vYn0d275H2w2KSBnebV2EY5Kv4ehYwgFsHIgk=;
 b=sA/jNMFOEc79VR3SZXy9ugM1IId67uMVmYQdPNqW+20CfqSzj6W/CJ/V
 VWZaA2vZBx71JDgmZcXMYvnZJevyKNFuuTQOMX1FWmeq5W6+pZYGAPEBx
 iJisxgbizmaFtoBe6EOl43eJyg9lrBmNsGXwDZdD0rhH9PcnY9QV1QBcD
 yuMwGhNvjylAs4FPtnjU1SUMV+av3grBqTzgCxgNxG8Xf6nW6jVM3hFt/
 Uyobn7YqcnU1tUUpspTbYOpHnnX30+ghXfinXS7s4Y61jbGwgFFPYLVmq
 M4lwGQj87tERk2pvnxnCob1l9alRMDfHcb/dxBZ/ns/1rc2zXg8lI4Jyj Q==;
X-CSE-ConnectionGUID: 0k6mE2eaSM+9gANiXsd8Aw==
X-CSE-MsgGUID: UbYLIWsZQBCs/tNF10ESTw==
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
 d="asc'?scan'208";a="28617918"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jun 2024 23:34:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 27 Jun 2024 23:34:40 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 27 Jun 2024 23:34:39 -0700
Date: Fri, 28 Jun 2024 07:34:21 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Conor Dooley <conor@kernel.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>, Ivan Griffin
 <ivan.griffin@microchip.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
Message-ID: <20240628-unexposed-cosmos-db27a71fc2b5@wendy>
References: <20240625090806.1787287-2-conor.dooley@microchip.com>
 <20240625143421.GR38804@bill-the-cat>
 <CAFLszTipm2MB9L8tubRxh_cF-BOXciBo5ypnjomm5rTj_F4fAQ@mail.gmail.com>
 <20240627-endnote-cacti-5c8ae6251234@wendy>
 <CAFLszTj3uSd8UOvmg5M2x1EOnidocRYxiBg0SeG8-eCfm1huRQ@mail.gmail.com>
 <20240627-prowess-train-e37fe71c1310@spud>
 <CAC_iWjKz18jONK-vVw1BR7xwJDqqD_rAF55yqdyfwN-gRqwMTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2M6NztYZEdfSnPIR"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKz18jONK-vVw1BR7xwJDqqD_rAF55yqdyfwN-gRqwMTg@mail.gmail.com>
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

--2M6NztYZEdfSnPIR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 08:53:11AM +0300, Ilias Apalodimas wrote:
> On Thu, 27 Jun 2024 at 23:27, Conor Dooley <conor@kernel.org> wrote:
> > On Thu, Jun 27, 2024 at 11:50:33AM +0100, Simon Glass wrote:
> > > On Thu, 27 Jun 2024 at 10:38, Conor Dooley <conor.dooley@microchip.co=
m> wrote:
> > > > On Thu, Jun 27, 2024 at 09:36:49AM +0100, Simon Glass wrote:

> > > > I think the only way a bloblist could work is if it was created at =
build
> > > > time and linked into the firmware, since the on-disk format seems p=
retty
> > > > minimal. Is there tooling for generating a bloblist at build time t=
hat I
> > > > could use to check whether or not a bloblist is viable?
> > > > I'd also have to investigate how that would interact with OpenSBI, =
since
> > > > it's integrated into the firmware and involved with loading U-Boot.
> > >
> > > There is not such a tool, but it would be easy enough to write. If you
> > > think that would help, I could give it a try.
> >
> > I mean I could also just do it myself, I just wanted to know if it
> > existed, since that'd make investigating this pretty straightforward to
> > do.
>=20
> Someone is already working on it.
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/29253
> this will help!

Eww, gerrit. Thanks for the link.

> > Either way, the firmware already is capable of doing this with a
> > devicetree blob, so I figure even if we manage to get bloblist stuff
> > going, there's little harm in supporting what's already there?
>=20
> There isn't, but OTOH the bloblist support is already in u-boot.

Devicetree in a1 support is already in U-Boot too, it's already been
nicely placed in gd->arch.firmware_fdt_addr by the arch code :)

> I would prefer to try that out first. Up to you

If it is up to me, I am going to say go with what I have already done,
as it's much easier to update U-Boot on a disk that you can write to
=66rom Linux than it is to change the firmware in envm and something
functional already exists.

--2M6NztYZEdfSnPIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn5ZbQAKCRB4tDGHoIJi
0gi1AP4gEbVID8nPZwYH0+nE5xCbb8g7s58wHJkUfBZXvy4SwQD+NTCm7VVeVBin
nfzxrO9CL1TBtg9x/MMXxJ+CrWb8ZA4=
=jrqI
-----END PGP SIGNATURE-----

--2M6NztYZEdfSnPIR--
