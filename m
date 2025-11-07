Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A79CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 22:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A9E83E23;
	Fri,  7 Nov 2025 23:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aqkX1dXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C943D83E42; Fri,  7 Nov 2025 23:00:29 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A736383E20
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 23:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-656b4094e4eso137118eaf.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 14:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762552826; x=1763157626; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zYPdSES/AahdCMWajvshyQUZeKiRw84G9AHtG8aXgSc=;
 b=aqkX1dXTo103a8gKRNZ4SaOi9BqCjnDv+0egZWryZYQl3w2+ln+VF0UmCzllckdu9C
 9uqoLqcDFvb1abarLbliFrGEVKN2ppLRE12zoCG2lQcHF1pcmxpv+UN372dH40CE888c
 l3osA1d8t3Rnoq5T1ZMBCwnHNHhbtpv5d0JgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762552826; x=1763157626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYPdSES/AahdCMWajvshyQUZeKiRw84G9AHtG8aXgSc=;
 b=JfseZ8r+oHphtQgCK3+TJDcaA6SwNAZy3CMmLkStEVNt45wzYy4owXULIqlcdqzdwB
 mqCg6zTiIMc5C5wuegIelpKPUF9AyGtz7Z3rBtcgiZ0ZvSKJ3HLc76Q9DmZ4kZ1FyQaf
 NR9M77gW32FZy5HcmxB3fJFSDdH5MKicTCTtRUiqLJhdjTNhdZX7/UomiyUqSY03o5c2
 DXvDzf2Sk/43Cl6nkm1oIroFtioQiw028D/RtiXTazN4iV1SUxMQzOTv9knXVDoySpNO
 L9wrfGC4UMfI3QAyT/+lY+u16lFk3f918ggsuiFR0BL/ppwy1RhxymhYSowe7Z3Pd5xD
 oqOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9HYju8yKtRiljA0rCC7or2evLpEU1pCHE4Mb89pm3CQ3Kmoz2DdpxRrpV3PwHgiaRoZQD5Mo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3dkjy0uuzd09iPJsgy8hCliQl09OkWiyk6dVTHZzm/34AFQ4s
 XSfBaRIq6b+CsMYqmo7kXThWyZSu3bg4W4Rz+XSp6KD3OzRbhLCEyAuSFZb0ZfOcZiM=
X-Gm-Gg: ASbGncucAoHYV8jHTWxLFPivufm62Kf6QtBHe8dw5l8457c5QZ5whSTJN6zvAjbXiAV
 ePs8gUVQH/rQDy0ay0bdA8uu6li1psUgHy+QfkZ8QOas6XJ6Lp2qXVFsVE0o/ZoDlLiBKXYaYJV
 MNHwAamaPVuluXb7HB7aFfnKETkP6dexXLsZrUoGw8MQ4u4OS75HnPLmv87nii6Y4Dw84fDKxLX
 uTbcWOECSlhmWkg9rMPH0xTcyKqL9c9qL37rKOPGuVjWE78x8nAgCa19xELSnFV+LHSIYnmSi3f
 xbiYDcgnnissrjr3R7aMMyz0n9igqygYyQnauHeS8aMgDn0Xp+Fp4gPJMTXE/msNxqjjbeuCU1K
 YaiGa+GRppGE8O5NCUywCBJIoBlbAgN7U8aGFYViv7x39N55X48DRqSPjLJLv6RVwwN3E03E465
 w5TK3XmYoCPeUOtKPkSl3h0D8Vc+cRyAg7vlah+ezrXaz7F7vS6/lj6tqZ6fe0
X-Google-Smtp-Source: AGHT+IGdTEzEEWOWd/qjdOgnfsoTKcU3lmHuAFa17npZYH/pSwjh5aOPzGB9lmkTIGdEkMa8jpnHaw==
X-Received: by 2002:a05:6808:6f8f:b0:44f:e801:d6d9 with SMTP id
 5614622812f47-4502a2dedf0mr477253b6e.39.1762552826298; 
 Fri, 07 Nov 2025 14:00:26 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4500253c20csm2845222b6e.4.2025.11.07.14.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 14:00:25 -0800 (PST)
Date: Fri, 7 Nov 2025 16:00:21 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vishal Mahaveer <vishalm@ti.com>,
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
 Sebin Francis <sebin.francis@ti.com>,
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Nathan Morrisson <nmorrisson@phytec.com>,
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>,
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 E Shattow <e@freeshell.de>, Devarsh Thakkar <devarsht@ti.com>,
 Peng Fan <peng.fan@nxp.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v4 00/13] am62: IO+DDR resume support
Message-ID: <20251107220021.GA3498997@bill-the-cat>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ntgL8EoHQEl0UdmK"
Content-Disposition: inline
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Fri, 07 Nov 2025 23:03:56 +0100
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


--ntgL8EoHQEl0UdmK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:59:18AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> Hi,
>=20
> this series introduces support to resume from IO+DDR. IO+DDR is a low
> power mode of am62a and am62p in which nearly everything is powered off
> except DDR which is in self-refresh and a few pins which detect
> activity and can wakeup the system again.
>=20
> On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
> it is, the DDR initialization sequence in k3-ddrss differs slightly as
> it has to get the DDR out of the self-refresh.
>=20
> Afterward a specific address determined from DT is used to get the
> metadata that stores relevant context addresses. The context is restored
> using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
> further initializations are skipped and uboot SPL directly jumps into
> the DM resume address which takes care of the rest.
>=20
> k3-ddrss is using absolute register accesses at the moment. I am trying
> to submit syscon DT patches upstream to access these through syscon,
> unfortunately there is ongoing discussion regarding syscon.
>=20
> I tested this on am62a.

Please make sure this builds without warnings (enable CONFIG_WERROR):
+(am62px_evm_r5) arch/arm/mach-k3/common.c: In function 'lpm_resume_from_dd=
r':
+(am62px_evm_r5) arch/arm/mach-k3/common.c:252:42: error: cast to pointer f=
rom integer of different size [-Werror=3Dint-to-pointer-cast]
+(am62px_evm_r5)   252 |         struct lpm_meta_data lpm_data =3D *(struct=
 lpm_meta_data *)meta_data_addr;
+(am62px_evm_r5)       |                                          ^
+(am62px_evm_r5) arch/arm/mach-k3/common.c:263:45: error: cast to pointer f=
rom integer of different size [-Werror=3Dint-to-pointer-cast]
+(am62px_evm_r5)   263 |         image_entry =3D (image_entry_noargs_t)(u64=
 *)lpm_data.dm_jump_address;
+(am62px_evm_r5)       |                                             ^
+(am62px_evm_r5) cc1: all warnings being treated as errors

Thanks!

--=20
Tom

--ntgL8EoHQEl0UdmK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQ5r8gAKCRAr4qD1Cr/k
CqjlAP9EKri/ooV1wfW0Gu+1RG/rigMDBscxfuWx7JC94dJgVgD/W/9CnQwLe5Oh
w3JLBAnZSwoyf+ldYds+rJtfpcnmDQI=
=M4/K
-----END PGP SIGNATURE-----

--ntgL8EoHQEl0UdmK--
