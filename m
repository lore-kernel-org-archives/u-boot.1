Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12798C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 18:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C508186D;
	Tue, 11 Mar 2025 19:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yddB8Vti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4815B81335; Tue, 11 Mar 2025 15:35:56 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4685801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 15:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so33117705e9.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741703753; x=1742308553;
 darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rlsA7jmOrPhoMg6/nKIHtXI6/BqZb9viipGVTzyVLkU=;
 b=yddB8VtiS2f7RMds1tMR//49hhoEGhdczJmr2AQ+Fsci6B2Qn0qwiIPhHTKdyzyJVf
 1KXX4wHs3AaZU3UwllusWJmOmYwKXancVWRyvuSKW7FcJIOSppGG9F/ckSpD3HS0e2KR
 ufF0vo4nRbP1x/+ONoMBfJnFavaKBgOwVCnn6qu1lGB/Nu4K6roM+18qDVSGzulauMXb
 4WwMKQCo8ABGotTdrm9r8amEQ1ajmU1XHhq5c8nVK5Cxqf7SWQA01k8j0AYifUX857Lt
 g4maSpQ2O9AGP11hB/9Bc8fClc79iJRXfJ8x+OZvwToXorbzQrbKQV9S9dkCrMTc1RNr
 Z9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741703753; x=1742308553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlsA7jmOrPhoMg6/nKIHtXI6/BqZb9viipGVTzyVLkU=;
 b=dRMnsNhlgs1gzxrltWJeCrlRifVYJ/Auc1rkv0pKe8/uDd10vj7lNWtP8HL4aUCASw
 jUSSEvEo4ci8V75i3Pf/n/XwwyM+IPbmDqAd2+sU5dsM0gX70B2xQQ47s3AYcBpnbOtq
 WLnhhYnN4ECgOfA1ttaCQCE5l2AUHgH8+LnAPWn0vH6qRYUq1Jf1EdA58cpYxxfAgdzP
 rADt3/r/7po/csfvMtESAEeCoYoT/d8xSYG/ebLDM/eioXPicE2SQkb9VqGF3kVjPZiz
 UsQND9lsAavzlQwq2guFwB/QICjzIIli3lrajYMtPiFNJLD83QeXZsey/JV+rC+ljXLW
 p1Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNESa+SdciCxeWNb+Nbt7N6cYm8YOnk/yvcXPQPmlnLBE+MiG1yCH4GXCKM+a6aebLONQSCw0=@lists.denx.de
X-Gm-Message-State: AOJu0YxZQNMcK8KNuyu69tdvNd7c5NWe+36MY0RN4j1hf5zDpQwJc70r
 sLrS/xr0md/RYxH8Z0DeFrWAQVpBmzYZb6IEY1vvLStTUd9Rub9Rqy7r+KHperw=
X-Gm-Gg: ASbGncv8ZizeHieE04f2tn/bMXWQ9ih9XhfUzk3crrNG6UOOq1x3MP1tFfSMJpFS9Qg
 QnI00c8K6W/rIYTDLdWA0wdy56mxUGaDofroKXnxngJupDT7Gwp1UVgT1jCdv8pI8Njq8mDhf53
 JGYVaGPEbBlQNHt/Hh+CMOjCBNRYjVpu3PLYEd1kU4XxB13HTATjXpMnwsnpm8e63J3WVqDNNzb
 P3nY3uCb2LTa09n8gq/JeMTegZKTIZdbHz+EqVFciH+KuRJsugzHfg0wknczL3YAFvH9tiDhDEH
 Uelxu7OUGSdROgDI5ESXnUYU4MfOHY9lxMZ6eVWA
X-Google-Smtp-Source: AGHT+IEi4F/rM2PmJKGRiSk/vmRTqLhX6htqtIcDgc1B7+QbLGA1SOT+cBdLpRCkstFAb6JVsojuhw==
X-Received: by 2002:a05:600c:1c14:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-43cf0ae15acmr95668815e9.7.1741703752975; 
 Tue, 11 Mar 2025 07:35:52 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:8c7a:e319:aa31:249f])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43ce3d5a0e2sm130397945e9.12.2025.03.11.07.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 07:35:52 -0700 (PDT)
Date: Tue, 11 Mar 2025 15:35:51 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de,
 Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>,
 Akashdeep Kaur <a-kaur@ti.com>, 
 Hari Nagalla <hnagalla@ti.com>, Judith Mendez <jm@ti.com>,
 Andrew Davis <afd@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH 00/19] am62: IO+DDR resume support
Message-ID: <c5fvf3an6jnzljh7ady5d64pjtojvq6q3ywmarichgznx7flsa@3jn2f6uf5klg>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
 <CAFA6WYMBHo4O-e-SeG8mZ9ec2RJsBc4F86mCi5un=mxOWfXasQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yp7ubcace43pg5ty"
Content-Disposition: inline
In-Reply-To: <CAFA6WYMBHo4O-e-SeG8mZ9ec2RJsBc4F86mCi5un=mxOWfXasQ@mail.gmail.com>
X-Mailman-Approved-At: Tue, 11 Mar 2025 19:37:38 +0100
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


--yp7ubcace43pg5ty
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/19] am62: IO+DDR resume support
MIME-Version: 1.0

Hi Sumit,

On Tue, Mar 11, 2025 at 04:19:58PM +0530, Sumit Garg wrote:
> Hi Markus,
>=20
> On Tue, 11 Mar 2025 at 16:02, Markus Schneider-Pargmann
> <msp@baylibre.com> wrote:
> >
> > Hi,
> >
> > this series introduces support to resume from IO+DDR. IO+DDR is a low
> > power mode of am62a and am62p in which nearly everything is powered off
> > except DDR which is in self-refresh and a few pins which detect
> > activity and can wakeup the system again.
> >
> > On resume uboot SPL is loaded and checks if this is a IO+DDR resume. If
> > it is, the DDR initialization sequence in k3-ddrss differs slightly as
> > it has to get the DDR out of the self-refresh.
> >
> > Afterwards a specific address determined from DT is used to get the
> > metadata that stores relevant context addresses. The context is restored
> > using the tisci message TI_SCI_MSG_MIN_CONTEXT_RESTORE. At the end all
> > further initializations are skipped and uboot SPL directly jumps into
> > the DM resume address which takes care of the rest.
> >
> > The devicetree R5F related patches were picked up from the mailinglist
> > and are required to find the correct address of the metadata.
> >
> > k3-ddrss is using absolute register accesses at the moment. I am trying
> > to submit syscon DT patches upstream to access these through syscon,
> > unfortunately there is ongoing discussion regarding syscon.
> >
> > I tested this on am62a.
> >
> > Best,
> > Markus
> >
> > To: Tom Rini <trini@konsulko.com>
> > To: Vignesh Raghavendra <vigneshr@ti.com>
> > To: Bryan Brattlof <bb@ti.com>
> > To: Sumit Garg <sumit.garg@linaro.org>
> > Cc: u-boot@lists.denx.de
> >
> > Cc: Vishal Mahaveer <vishalm@ti.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Dhruva Gole <d-gole@ti.com>
> > Cc: Sebin Francis <sebin.francis@ti.com>
> > Cc: Kendall Willis <k-willis@ti.com>
> > Cc: Akashdeep Kaur <a-kaur@ti.com>
> >
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> > Devarsh Thakkar (3):
> >       arm64: dts: ti: k3-am62a-wakeup: Add R5F device node
> >       arm64: dts: ti: k3-am62a7-sk: Enable IPC with remote processors
> >       arm64: dts: ti: k3-am62p5-sk: Enable IPC with remote processors
> >
> > Hari Nagalla (2):
> >       arm64: dts: ti: k3-am62a-mcu: Add R5F remote proc node
> >       arm64: dts: ti: k3-am62x-sk-common: Enable IPC with remote proces=
sors
> >
> > Jai Luthra (1):
> >       arm64: dts: ti: k3-am62a-main: Add C7xv device node
> >
> > Markus Schneider-Pargmann (13):
> >       arm: mach-k3: Remove CANUART IO isolation
> >       arm: mach-k3: Kconfig: Add symbols for IO+DDR Low Power Mode
> >       ram: k3-ddrss: Add support for DDR in self-refresh
> >       firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
> >       arm: mach-k3: common: Add CANUART wakeup check helpers
> >       arm: mach-k3: common: Add lpm_resume_from_ddr
> >       arm: mach-k3: common: Helper for LPM meta data address from DT
> >       arm: mach-k3: am62a7_init: Resume on LPM exit
> >       arm: mach-k3: am62p5_init: Resume on LPM exit
> >       arm: dts: k3-am62a: Add r5 device nodes
> >       arm: dts: k3-am62p: Add r5 device nodes
> >       configs: am62ax_evm_r5: Enable IODDR resume support
> >       configs: am62p_evm_r5_defconfig: Enable IODDR resume support
> >
> >  arch/arm/dts/k3-am62a7-sk-u-boot.dtsi             |  16 +++
> >  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi             |  20 +++
> >  arch/arm/mach-k3/Kconfig                          |   9 ++
> >  arch/arm/mach-k3/am62ax/am62a7_init.c             |  11 ++
> >  arch/arm/mach-k3/am62px/am62p5_init.c             |  12 ++
> >  arch/arm/mach-k3/am62x/am625_init.c               |   2 +
> >  arch/arm/mach-k3/common.c                         | 162 ++++++++++++++=
+++++++
> >  arch/arm/mach-k3/common.h                         |   4 +
> >  arch/arm/mach-k3/include/mach/hardware.h          |  32 +++++
> >  configs/am62ax_evm_r5_defconfig                   |   1 +
> >  configs/am62px_evm_r5_defconfig                   |   1 +
> >  drivers/firmware/ti_sci.c                         |  38 +++++
> >  drivers/firmware/ti_sci.h                         |  14 ++
> >  drivers/ram/k3-ddrss/k3-ddrss.c                   | 165 ++++++++++++++=
++++++++
>=20
> >  dts/upstream/src/arm64/ti/k3-am62a-main.dtsi      |  12 ++
> >  dts/upstream/src/arm64/ti/k3-am62a-mcu.dtsi       |  25 ++++
> >  dts/upstream/src/arm64/ti/k3-am62a-wakeup.dtsi    |  25 ++++
> >  dts/upstream/src/arm64/ti/k3-am62a7-sk.dts        |  96 ++++++++++++-
> >  dts/upstream/src/arm64/ti/k3-am62p5-sk.dts        |  50 ++++++-
> >  dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi |  35 ++++-
>=20
> The dts/upstream is a git subtree and is rather a snapshot of upstream
> devicetree-rebasing repo. It's not allowed to directly patch it but
> rather we need to resync or cherry-pick patches from upstream [1].
>=20
> So rather than picking patches from ML, you should wait for them to
> land in the Linux kernel for a cherry-pick to work. Or otherwise you
> can choose to rely on *-u-boot.dtsi for the time being.
>=20
> [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#res=
yncing-with-devicetree-rebasing

Thanks for the link, I didn't notice the handy scripts. Yes these are
currently only mailinglist patches, but hopefully soon in the kernel so
I can replace them in this series. I sent the series anyways to get some
feedback already so I can work on the other aspects that need fixing in
these patches.

Thank you!

Best
Markus

--yp7ubcace43pg5ty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd8KHufh7XoFiu4kEkjLTi1BWuPwUCZ9BKQgAKCRAkjLTi1BWu
P/w8AP4sUqR5RGslkVPXLHwPrlSgseC+obuRR9BLSgODpRzY+AD9FOU8ovgugNZi
ErtaLadrW2xyqrVLF4BSZTApCNUYBQI=
=Qgde
-----END PGP SIGNATURE-----

--yp7ubcace43pg5ty--
