Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1D1C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 18:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4168B8871F;
	Thu, 30 May 2024 20:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dddnBB6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A939788700; Thu, 30 May 2024 16:08:37 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387D5886F3
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 16:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6ab8ab4ca0bso122026d6.0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717078114; x=1717682914; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pu33TT+FSiZ2mJ5putryQDiiYjgbdxMdpLJGmCZbTto=;
 b=dddnBB6QhsC2kfPKl8u5TVIO6WCraanoUilHarG5+uWLy9R2+heKB3muM3ZK5cWW7L
 R8dgEYdxx73HvlCv5/h8k2n/HmTCtGSaeRVOCdqk/IAFQnwZX8jg2AtaIaYRwUW8ggSB
 +THqP8OF+K+mgCR+GcjGJTeoAbm0iA04vKwM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717078114; x=1717682914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pu33TT+FSiZ2mJ5putryQDiiYjgbdxMdpLJGmCZbTto=;
 b=wBPtbMpEUx/5BeZ/y5MRLH3L6ecVkVZRpYxxSL51BH6vmEJso4yEYrGrEe43SN/SO2
 dsy3XqbXeOpvYyPeG+FgN0FJfDRkv1fAhtXmLFdOakPk/tfaGD44x/poHChPdrXCrfFD
 4XZUtHnmDGPK5KBXXVeEwRNIn5iCc/9f5ajoPBNEfWJJiEEb35zpetKNhcU4Pb03hU8z
 L0zY95FTcPvLH+alhPe/QIlzfYq9UysFUm6eBulsy4p6+HRpm8LBrTTM6tDPX3cMUnQU
 CQBcAQ7yNCmjUO23J/7K/1cp6iD5Bs2pGY5xE4YbthCTSjrC/tYDD5EINIVrZbPIWbZV
 1mbQ==
X-Gm-Message-State: AOJu0YxVKS/w1D979CanYXQi933597wdM+psFBejEsS+ai2DfqF+yZ8C
 zGzniY6x0xskOyCObqJ89lWRE/s8XqGjJM1wQg78qDBCR6A2GXPKigszurfCt10=
X-Google-Smtp-Source: AGHT+IFhTeDE6EcndQJeW/XhQHNgN4Jm4oXzOJN6G3kPW2HnrWiq2IDVAOFxznK9AZFEzqo9IjB/LA==
X-Received: by 2002:a05:6214:5407:b0:6ad:73bc:b31a with SMTP id
 6a1803df08f44-6ae0cc8933cmr31156106d6.17.1717078113962; 
 Thu, 30 May 2024 07:08:33 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad67d3b2bdsm53612916d6.7.2024.05.30.07.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 07:08:33 -0700 (PDT)
Date: Thu, 30 May 2024 08:08:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Fabio Estevam <festevam@denx.de>, Hai Pham <hai.pham.ud@renesas.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Igor Prusov <IVPrusov@sberdevices.ru>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 "Polak, Leszek" <LPolak@arri.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH 0/4] arm64: versal2: Add support for new AMD Versal Gen 2
 SoC
Message-ID: <20240530140826.GM3714513@bill-the-cat>
References: <cover.1716994063.git.michal.simek@amd.com>
 <20240529161316.GP2568172@bill-the-cat>
 <990b73c8-b33c-4ae9-b100-bfeb2f2c184d@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d/j07suDMVByGIfA"
Content-Disposition: inline
In-Reply-To: <990b73c8-b33c-4ae9-b100-bfeb2f2c184d@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 30 May 2024 20:01:25 +0200
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


--d/j07suDMVByGIfA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 08:04:07AM +0200, Michal Simek wrote:
> Hi Tom,
>=20
> On 5/29/24 18:13, Tom Rini wrote:
> > On Wed, May 29, 2024 at 04:47:57PM +0200, Michal Simek wrote:
> >=20
> > > Hi,
> > >=20
> > > I am sending patches for adding initial support for new AMD Versal Ge=
n 2
> > > SoC. If you want to find out more information please take a look at t=
his
> > > page:
> > > https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html
> > >=20
> > > Thanks,
> > > Michal
> > >=20
> > >=20
> > > Michal Simek (4):
> > >    arm64: versal2: Add support for AMD Versal Gen 2
> > >    soc: versal2: Add SoC driver for AMD Versal Gen 2
> > >    mmc: versal2: Update zynq_sdhci driver to support AMD Versal Gen 2
> > >    spi: versal2: Enable spi drivers for Versal Gen 2
> >=20
> > My only concerns are name-related and not-blocking. First, should we
> > perhaps instead have arch/arm/mach-versal/{gen2,net}/ (and presumably
> > gen2-net down the line)?
>=20
> There are completely 3 different SOCs only names are similar
> Versal is 2 cores a72
> Versal NET 16 cores a78
> Versal Gen 2 8 cores a78
> with different features.

That's good to know.

> Creating subfolders under current mach-versal would be very confusing.
> We can definitely try to make it as small as possible but still they are
> separated families.

Again, I'm not nak'ing things based on the names but I'll point out that
arch/arm/mach-k3/{am*,j7*}/ contain a good number of A53 and A72
platforms of varying numbers of cores. But on the other hand, at some
level they're all part of the "Keystone 3" generation / family, which is
not how the Versal parts are handled.

> We tried to reuse existing platforms but it is hard to keep it in sync
> that's why new platform is better way to go.
> But as you know we are trying to reuse for example board/xilinx/common/
> folder as much as possible that we don't have code duplication.

That's also good and reasonable.

> > Second, and I see I can't say we should follow
> > the Linux kernel since there's no versal dts files upstream, should we
> > still be "xilinx" and not "amd" ? I do see the kernel shoves all the
> > imx8 (as an example of a modern part) stuff under
> > arch/arm64/boot/dts/freescale/ and if nothing else we should be
> > consistent between projects whenever possible. Thanks.
>=20
> I am not going to send DTSes to U-Boot and just push them to Linux kernel=
 at
> right time. And target is arch/arm64/boot/dts/amd which already exists for
> old amd socs and elba (pensando). Versal Gen 2 should go there.
>=20
> It means Versal and Versal NET will be branded under Xilinx and Versal Ge=
n 2
> will be branded under AMD. Also we are going to stop to use xlnx, dt
> prefixes for new IPs and will start to use amd, prefix.

My real only concern here is that we're consistent with whatever Linux
Kernel people demand. It's bikeshedding I'm really not inclined to argue
myself. :)

--=20
Tom

--d/j07suDMVByGIfA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZYiFcACgkQFHw5/5Y0
tyym0QwAsCRBZdZRITfg5k1n88D4qyT08IfpqmmPVKSjPKnsxSVQfohQpwXMJkH9
Ka9Mc4SHwFsWUB9Rf8Cfy+PbBmuXBYCoynA0yy8knGnsZT2NfbwFw/zS+h7nXpFV
7/YIarNB38ypmbv3V33Ur+mhprWUgLH1O1Obc3opEnTUW+YXWLoRuLRtukWyxHNy
g45OgC21d8thDfsH+mzdSiCt1AtFmZOlFeMzQ4KPZUk7dlig78ZzYB9omWaiIEep
yi2ZlZJCitlwbc51X41HlvI9JPX7SlpqgjQA9D8S/ZA189O8JqvD3w8ytSI93RL+
YFQF4acasvil2golQLIqW2Yv2OhdHASu6jwW+TF5NoOHAWDNHF4REqK5sfkRM6UN
eY+UxL6yZpGUpXVpoKIU+L8NFjYQKYkcOkH1PLDP5e0gIT4GwX/fPTQGP6Crm32Z
u8vdteiN109r28dxfG6YcaUHFN18MEtST8wc17BL5NpbUIFZDoH5hcxn6eG6Zaif
TSe7BJgN
=F/E9
-----END PGP SIGNATURE-----

--d/j07suDMVByGIfA--
