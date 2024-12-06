Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8BCE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 16:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643A489616;
	Fri,  6 Dec 2024 17:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TrRmE0QO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C817989622; Fri,  6 Dec 2024 17:39:39 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB61888E41
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 17:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-46727cc31ecso21697251cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 08:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733503176; x=1734107976; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6XwsIsYx+lCjIGoZ9wo3ImEreZ1W5Nu1OSK4u1mpYsQ=;
 b=TrRmE0QOm0M8RmCh7qgwv3BMI4jCASjsqKzRBDVQ4JlRdnFGNvIRPhOcNpPlsQKVzB
 TDwq1i0gftjl9RHhl/6pAjz3fROdd7jPlTgAfyiDjDb9gl7jWf3HUW5PqaIF3LNEBFbC
 Gvu7p1aNiaw/cGcm9cqmWbM6MKgHphT2IW6wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733503176; x=1734107976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XwsIsYx+lCjIGoZ9wo3ImEreZ1W5Nu1OSK4u1mpYsQ=;
 b=iieelAfe2+cP//TJF+xDt3Aow52u52hAPjtKSJhLN0Zs+YXryL6IXvfoslH0F2oSG/
 SnTmPN6zAXkvvN/H7JF7Mt7PupKh1Ki4JpPHgXuphEwKg+41+TAMUwI4sr/HwRvl1RMv
 aB1ZmDZrG8iRQddKs3Z+zJfZYpTZ5ezQwqJgtJi/HLunt64IQ2+d3BCN1EKonkgk/dmw
 BIZ4RF/5Axd4T/KefovjNocKHLGnxPLkq1+KLRNQl7L47JoyknSrhyE1rKVimVUkv0ik
 51dFhxZ8sbiYIiICPYGdmHxvMlC3VSspfdI/pWLvaHdxkFZI42/Q/Aib1G1EbfGhv4NV
 orFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMW98raKkekKMFhT9btUrZKccXbGUspgzaOMMR+gCeHFBMGJG8Jul+x3hmCAo7LWLeIUB0ZZY=@lists.denx.de
X-Gm-Message-State: AOJu0YxRtUCTfI4dE0/QDhzeAzna1oVpAWDj1fo5XB+LMrwx/R0Once2
 +ZGDGaS21yOw79zvg7iBj2I8bCy+Y24yYqtcMfF0aLHAScaDNQ3eBxxuVEKdlNM=
X-Gm-Gg: ASbGncsNXuT2BYtsUlM+CFzOf1hZupAH69K+U0CD7YZi+kdNI9hiLj81Y/9cr7Ka+5v
 myOF/GsOPfd4bLwG5apszTzC9x53KKsV0l6ucoKgJtTJJDGe8xCiYUE76GQ6hpqZ6DKfjKXt/O/
 aydQkVfz0Zz1psMRDO0ZicVV4wqCEUps4tirYxkINJYMu3HWMbIZs7bhCQGVxfaBPTp8q72ZOqr
 8ts6/8+EuVWbOOnvQbE/sZgPrOqYTL64lPD/dig1QYPmWGqmg==
X-Google-Smtp-Source: AGHT+IERZi2SuY8EZV8fx6YRiqhe0xejjoXya9lXzqKgM64Tb2QeMK/E3xSazs/g9I9YdIfx/jx1aA==
X-Received: by 2002:ac8:59d5:0:b0:466:aa1b:1cfd with SMTP id
 d75a77b69052e-46734cb539bmr61486161cf.15.1733503175660; 
 Fri, 06 Dec 2024 08:39:35 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296ca681sm22555851cf.24.2024.12.06.08.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 08:39:34 -0800 (PST)
Date: Fri, 6 Dec 2024 10:39:31 -0600
From: Tom Rini <trini@konsulko.com>
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
Cc: Jon Humphreys <j-humphreys@ti.com>, Marek Vasut <marek.vasut@mailbox.org>,
 "Simek, Michal" <michal.simek@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 "uboot-stm32@st-md-mailman.stormreply.com"
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories
 support in QSPI driver"
Message-ID: <20241206163931.GS2457179@bill-the-cat>
References: <edcec18f-75a0-44d8-907a-f042779ca6ee@mailbox.org>
 <86ses458k3.fsf@udb0321960.dhcp.ti.com>
 <f7bb335d-681a-4b60-92f6-b605cc6f477f@mailbox.org>
 <86pln759j9.fsf@udb0321960.dhcp.ti.com>
 <33e99705-77e3-4acf-95f7-fad65f60ae62@mailbox.org>
 <86ldxp6ehf.fsf@udb0321960.dhcp.ti.com>
 <865xny69y1.fsf@udb0321960.dhcp.ti.com>
 <SA1PR12MB86974AC7EFCCBD7AE99FDD3E98302@SA1PR12MB8697.namprd12.prod.outlook.com>
 <8634j15t1y.fsf@udb0321960.dhcp.ti.com>
 <SA1PR12MB869743652A0B3EC3335A9F9F98312@SA1PR12MB8697.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="alfT6XMccdNcK5wJ"
Content-Disposition: inline
In-Reply-To: <SA1PR12MB869743652A0B3EC3335A9F9F98312@SA1PR12MB8697.namprd12.prod.outlook.com>
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


--alfT6XMccdNcK5wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 09:46:08AM +0000, Abbarapu, Venkatesh wrote:
>=20
>=20
> > -----Original Message-----
> > From: Jon Humphreys <j-humphreys@ti.com>
> > Sent: Friday, December 6, 2024 10:04 AM
> > To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; Marek Vasut
> > <marek.vasut@mailbox.org>; Simek, Michal <michal.simek@amd.com>; u-
> > boot@lists.denx.de; Tom Rini <trini@konsulko.com>
> > Cc: Andre Przywara <andre.przywara@arm.com>; Ashok Reddy Soma
> > <ashok.reddy.soma@amd.com>; Jagan Teki <jagan@amarulasolutions.com>;
> > Michael Walle <mwalle@kernel.org>; Patrice Chotard
> > <patrice.chotard@foss.st.com>; Patrick Delaunay <patrick.delaunay@foss.=
st.com>;
> > Pratyush Yadav <p.yadav@ti.com>; Quentin Schulz <quentin.schulz@cherry.=
de>;
> > Sean Anderson <seanga2@gmail.com>; Simon Glass <sjg@chromium.org>;
> > Takahiro Kuwano <Takahiro.Kuwano@infineon.com>; Tudor Ambarus
> > <tudor.ambarus@linaro.org>; uboot-stm32@st-md-mailman.stormreply.com
> > Subject: RE: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel memories =
support in
> > QSPI driver"
> >=20
> > "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com> writes:
> >=20
> > > Hi,
> > >
> > >> -----Original Message-----
> > >> From: Jon Humphreys <j-humphreys@ti.com>
> > >> Sent: Thursday, December 5, 2024 9:47 AM
> > >> To: Marek Vasut <marek.vasut@mailbox.org>; Simek, Michal
> > >> <michal.simek@amd.com>; u-boot@lists.denx.de; Tom Rini
> > >> <trini@konsulko.com>
> > >> Cc: Andre Przywara <andre.przywara@arm.com>; Ashok Reddy Soma
> > >> <ashok.reddy.soma@amd.com>; Jagan Teki <jagan@amarulasolutions.com>;
> > >> Michael Walle <mwalle@kernel.org>; Patrice Chotard
> > >> <patrice.chotard@foss.st.com>; Patrick Delaunay
> > >> <patrick.delaunay@foss.st.com>; Pratyush Yadav <p.yadav@ti.com>;
> > >> Quentin Schulz <quentin.schulz@cherry.de>; Sean Anderson
> > >> <seanga2@gmail.com>; Simon Glass <sjg@chromium.org>; Takahiro Kuwano
> > >> <Takahiro.Kuwano@infineon.com>; Tudor Ambarus
> > >> <tudor.ambarus@linaro.org>; Abbarapu, Venkatesh
> > >> <venkatesh.abbarapu@amd.com>;
> > >> uboot-stm32@st-md-mailman.stormreply.com
> > >> Subject: Re: [PATCH 1/6] Revert "spi: zynq_qspi: Add parallel
> > >> memories support in QSPI driver"
> > >>
> > >> Jon Humphreys <j-humphreys@ti.com> writes:
> > >>
> > >> > Marek Vasut <marek.vasut@mailbox.org> writes:
> > >> >
> > >> >> On 11/7/24 4:49 PM, Jon Humphreys wrote:
> > >> >>> Marek Vasut <marek.vasut@mailbox.org> writes:
> > >> >>>
> > >> >>>> On 11/6/24 10:58 PM, Jon Humphreys wrote:
> > >> >>>>> Marek Vasut <marek.vasut@mailbox.org> writes:
> > >> >>>>>
> > >> >>>>>> On 11/6/24 8:18 PM, Jon Humphreys wrote:
> > >> >>>>>>> Marek Vasut <marek.vasut@mailbox.org> writes:
> > >> >>>>>>>
> > >> >>>>>>>> On 10/23/24 10:17 AM, Michal Simek wrote:
> > >> >>>>>>>>>
> > >> >>>>>>>>>
> > >> >>>>>>>>> On 10/22/24 23:06, Marek Vasut wrote:
> > >> >>>>>>>>>> This reverts commit
> > 1e36d34b52e7a1ebe5a2a5339d6905540f4253aa.
> > >> >>>>>>>>>>
> > >> >>>>>>>>>> This parallel/stacked support breaks basic SPI NOR
> > >> >>>>>>>>>> support, e.g. this no longer works:
> > >> >>>>>>>>>>
> > >> >>>>>>>>>> =3D> sf probe && sf update 0x50000000 0 0x160000
> > >> >>>>>>>>>> SF: Detected s25fs512s with page size 256 Bytes, erase
> > >> >>>>>>>>>> size
> > >> >>>>>>>>>> 256 KiB, total 64 MiB device 0 offset 0x0, size 0x160000
> > >> >>>>>>>>>> SPI flash failed in read step
> > >> >>>>>>>>>
> > >> >>>>>>>>> Reverting everything seems to me too much. Tom has tested
> > >> >>>>>>>>> it on his HW and didn't see any issue. That's why better to
> > >> >>>>>>>>> look at code which is causing this.
> > >> >>>>>>>>> You are reverting everything but likely there is specific
> > >> >>>>>>>>> patch which is causing this. Which one is it?
> > >> >>>>>>>>> Which board was used for your testing? Likely we don't have
> > >> >>>>>>>>> access to
> > >> it.
> > >> >>>>>>>>> Is there any QEMU available which can be used for debuggin=
g?
> > >> >>>>>>>>
> > >> >>>>>>>> The testcase including the exact SPI NOR model is above.
> > >> >>>>>>>>
> > >> >>>>>>>> iMX6 with w25q16dw seems to be broken too.
> > >> >>>>>>>>
> > >> >>>>>>>> Basically every board I have access no longer has a working
> > >> >>>>>>>> "sf probe ; sf update" combination ... so yeah, this means
> > >> >>>>>>>> this patchset is fundamentally broken.
> > >> >>>>>>>>
> > >> >>>>>>>
> > >> >>>>>>> I can also confirm that the patch series:
> > >> >>>>>>>
> > >> >>>>>>> f8efc68b30e Merge patch series "spi-nor: Add parallel and
> > >> >>>>>>> stacked memories support"
> > >> >>>>>>>
> > >> >>>>>>> breaks SPI NOR on TI platforms, particularly SK-AM62 and SK-
> > AM62P:
> > >> >>>>>>>
> > >> >>>>>>> U-Boot 2024.10-00752-gf8efc68b30e2 (Nov 06 2024 - 12:25:13
> > >> >>>>>>> -0600)
> > >> >>>>>>>
> > >> >>>>>>> SoC:   AM62X SR1.0 HS-FS
> > >> >>>>>>> Model: Texas Instruments AM625 SK ...
> > >> >>>>>>> Hit any key to stop autoboot:  0 =3D> sf probe && sf update
> > >> >>>>>>> ${loadaddr} 0x400000 0x10
> > >> >>>>>>> SF: Detected s28hs512t with page size 256 Bytes, erase size
> > >> >>>>>>> 256 KiB, total 64 MiB device 0 offset 0x400000, size 0x10 SPI
> > >> >>>>>>> flash failed in read step =3D>
> > >> >>>>>> Sigh ... can you please test current u-boot/master and see if
> > >> >>>>>> the error is fixed there ?
> > >> >>>>>>
> > >> >>>>>
> > >> >>>>> Yes I had verified it also fails against master, although the
> > >> >>>>> behavior was a bit different.  The .'s below are our DMA engine
> > >> >>>>> waiting
> > >> indefinitely.
> > >> >>>>>
> > >> >>>>> =3D> sf probe && sf update ${loadaddr} 0x400000 0x10
> > >> >>>>> SF: Detected s28hs512t with page size 256 Bytes, erase size 256
> > >> >>>>> KiB, total 64 MiB device 0 offset 0x400000, size 0x10
> > >> >>>>> .....................................................
> > >> >>>>>
> > >> >>>>> I have not investigated further.
> > >> >>>>
> > >> >>>> Can you try and run some 'git bisect' to find out exactly which
> > >> >>>> commit broke your use case ? There is a bunch of fixes for the
> > >> >>>> worst breakage that landed recently, but clearly there is more.
> > >> >>>>
> > >> >>>> Full revert seems increasingly appealing ...
> > >> >>>
> > >> >>> commit 5d40b3d384d
> > >> >> So there is still something broken in that specific commit that I
> > >> >> missed when removing the defects ? Sigh ... can you try to narrow=
 it down ?
> > >> >
> > >> > Hi Marek, I tried to narrow the changes in commit
> > >> > 5d40b3d384dc536ec26ce9b76b20b0b84749d2d1 a bit by first applying
> > >> > all of the changes in the .h files, and then for spi-nor-core.c,
> > >> > only applying changes per function. The only function change that
> > >> > causes errors was spi_nor_read(). With the changes in
> > >> > spi_nor_read() in commit
> > >> > 5d40b3d384dc536ec26ce9b76b20b0b84749d2d1 applied to the prior
> > >> > commit fbe16bc2801, did I get:
> > >> >
> > >> > =3D> sf probe && sf update ${loadaddr} 0x400000 0x10
> > >> > SF: Detected s28hs512t with page size 256 Bytes, erase size 256
> > >> > KiB, total 64 MiB device 0 offset 0x400000, size 0x10 SPI flash
> > >> > failed in read step
> > >> >
> > >>
> > >> Hi all.  What is the status of addressing the failures introduced by
> > >> this patchset?  I tried building from u-boot next and still see the =
failure.
> > >>
> > >> Marek, was the isolation of changes I performed above helpful in
> > >> understanding the failure?
> > >>
> > >
> > > Can you try by applying this change
> > > https://lore.kernel.org/u-boot/20241118090544.21956-1-venkatesh.abbara
> > > pu@amd.com/
> > >
> >=20
> > Hi Venkatesh, the patch seems to remove the issue I was seeing.
> >=20
> > Thanks
> > Jon
>=20
> Hi Humphreys,
> Thank you for confirming that the patch worked and resolved the issue.

OK, but going back to the patch in question, Tudor has requested
changes. When can we expect a v2 that addresses those, so that Jon and
Marek can also confirm their platforms work? Thanks.

--=20
Tom

--alfT6XMccdNcK5wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTKL8ACgkQFHw5/5Y0
tyy9Jwv+PcWpv69r+9w3rNbBnJBc/qlRHyvg6CHPr474Xl8V64V2WttFIBXfG+MP
Nej6iAla3lA/ihp2ZuS9dAuXyY600sWGXKUEqrQpzKALse6knwvQjR5JBmR13J9A
1yY385ajXfnYu28HsuPYGsckdLRdKpdpIlaQQqxK+B2wEAYvMtazcnmcFEbxCPAS
3srlhtB4o8tO9yvGGo+6invXd4E9/gExDfWWT4d3r8KqIWys9+IRSZzXl35N2kg/
5qMwPtpAmPdYO7kvbFyhXvnk3MibsLPTAN6IVWs46RJ4sj1AVet/ufOoRLb96uQE
kUTA5e7tUPJSpVCX2qKFwrwsowtrSH3XaLX3WZbeBcuwH+DJIM13WVnDIBY2mae7
JQ6EzuK/ai79MDjCrp3LRvLBewAwDJrdtc/mUn3aDb6ehcNPpP/vC5sIHNMFvDBo
0TDHHl0rkuM30B1sQ+H53DCRQZLZ9MyHRA/ZNcWpmwUPBZKEFp84onRxqnar+nML
MRA1OwvO
=5V6T
-----END PGP SIGNATURE-----

--alfT6XMccdNcK5wJ--
