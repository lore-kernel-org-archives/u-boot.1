Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04844C982C7
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 14:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D94382BF2;
	Fri, 16 Jan 2026 15:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TabRLcy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A237F8309A; Fri, 16 Jan 2026 15:44:01 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B9380077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 15:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7cfd819ae5eso1014128a34.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768574638; x=1769179438; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r8uGgmC1+TZ13AdRrA7WX/1qVe6g2N2zPa3y52KB4U0=;
 b=TabRLcy/qzfvXGHrZBvsw9OC4eSZTRNr1ZlSh1cbLhMBed/prPqOmFyOQ/u7tOuHR1
 QRfUFPI/iLtfgDIRjaP5q8h7giRBVTu5obPF+SqR4C72gjm2SZNVZa/1DjfoS+YGvo4p
 0jPjHSztjz3E5PBpOIBN7DXaqCbhm2FckUlns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768574638; x=1769179438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8uGgmC1+TZ13AdRrA7WX/1qVe6g2N2zPa3y52KB4U0=;
 b=ucwIVujyaZeHDpM4f6NHUY6x1n8aCv8+mE5WOGrdWe36ywika8hKR3emIIh63SJfGM
 L5SnYFQxgKPdziFkDMWvoNuLeiN6hcngkjkHzu2H5QEzkRz0bRHFpq+VHlpPVUqFqyE4
 JhtEDYC1NjGHhyqUpwdCAPC79AexIgilQ+M4u6D9z1mLI03y8NMkDaZO4cCUv/Ux3Sz5
 Oif8ojq4XSeqeQ5bVhUtPqF5VHUIVYhm8k3CnjrpxT2qvS0eGeQVMmLo0yDGLGeZ20fS
 fC913FXpYY5eZY2OTzCZ6fS6BOWYJVvPc0Ly/1TiSZ+zbKCFRh7RRzy07q/AnoHmsqmP
 uDLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQPvtSAW0ivxzjKd2XRk7dtHq7xPy0lTCtnM2t9uZUJah0hJavVn1PXOWAutDaaLe18VgKyVU=@lists.denx.de
X-Gm-Message-State: AOJu0YzJLAOcLfvGhcd9uIYrJVmhdkS6cFklER5wjzGeODW2vxvcrZnF
 lZqqsp3/u8JzpMozKlExfWaCz8q8pZkE5Nx9mRsvuDGjFCg5Ucv9C8tTKiFcn1YqZ1A=
X-Gm-Gg: AY/fxX6EHEu90oMshDg+hfXEitaT8sdhcH92NyPKrKtp4F/bUGHChivLG60FE7T8o3b
 /0JhdHoAFnk7CHL0eJ9d1qjmtP3kBqVCyb07/s5Kiqmgi5SPfU0KpsMqY5ztbN8OCqTR8EOsQVN
 Rmh1dYno8OcVYxPF3v+72Xb/4Zkq9dkR/pRjc8jmVNUkXSQUiH8n9x5kn2iCR2nWPGMbdDMH11W
 lzBDSVepF6w/eoITDv/Ec5RNKxbn52AaJ3sASm6UKZq04SOjBUpi5jBsvAfLuaoS2gmzCPus3fX
 gjHrKgzYmcS1exsFDcE0BNma+2wItMfmjOV5pwNgskSEnKbH4FBw/O9ILPTRY4V0CUjqVpNMj5X
 H/zxec5T0CzNAlrTpBpMEIeeRw3xsXI2/9o+xCPAo/k7fL2IxJ+REMYlsz3Y2ByEZQJxrXF/spW
 R9V8Mp9wk+1NuKX430/NKRud1wM981IvKqdjDG/23BKOdFPnLXSFSLvevO2Y+7pBHdXE7/lF9TD
 o6At00ys/2PMKHoRNFpMf1pMur2fnM0qkoO0DA=
X-Received: by 2002:a05:6830:83ab:b0:7cf:d4b2:d64e with SMTP id
 46e09a7af769-7cfded3185bmr1709682a34.3.1768574637819; 
 Fri, 16 Jan 2026 06:43:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0e92d3sm1793790a34.9.2026.01.16.06.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 06:43:57 -0800 (PST)
Date: Fri, 16 Jan 2026 08:43:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 christopher.obbard@linaro.org, me@samcday.com, michal.simek@amd.com,
 clamor95@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 0/5] Implement reset to EDL for qcs9100
Message-ID: <20260116144355.GK3416603@bill-the-cat>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260113144244.GV3416603@bill-the-cat>
 <aWnkOxk5xiZDG5YX@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z3gHInWG5mf2+k45"
Content-Disposition: inline
In-Reply-To: <aWnkOxk5xiZDG5YX@hu-varada-blr.qualcomm.com>
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


--Z3gHInWG5mf2+k45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 12:39:47PM +0530, Varadarajan Narayanan wrote:
> On Tue, Jan 13, 2026 at 08:42:44AM -0600, Tom Rini wrote:
> > On Tue, Jan 13, 2026 at 04:08:35PM +0530, Varadarajan Narayanan wrote:
> >
> > > Using the 'reboot edl' command in Linux, the platform can reboot to t=
he
> > > Emergency Download mode. Implement the same for U-Boot.
> >
> > Have you used buildman's size checking options before? If not,
>=20
> No.
>=20
> > https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini=
/u-boot-size-test.sh?ref_type=3Dheads
> > may be helpful to you, as it can be a bit tricky at first (but IMHO is
> > better than the linux kernel bloat-o-meter). I ask because, what is the
> > size impact of these changes on things like say qemu_arm64 and qemu_arm?
> > I saw the cmd/ portion is guarded by a new CONFIG option which is good,
> > but I wonder about the more generic sysreset changes. Thanks!
>=20
> Please see below for u-boot-size-test.sh output
>=20
> $ ./u-boot-size-test.sh --board qcom_ipq9574_mmc
> Generating board list...Processing #include to produce configs/socfpga_ag=
ilex5_vab_defconfig
> Processing #include to produce configs/r8a78000_ironhide_defconfig
> 	.
> 	.
> 	.
> Processing #include to produce configs/am69_sk_a72_defconfig
> Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
> 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> 06: qcom_defconfig: enable psci based sysreset
>     2    0    0 /2              qcom_ipq9574_mmc
> Completed: 2 total built, 2 newly), duration 0:00:13, rate 0.15
> /tmp/qcom_ipq9574_mmc/edl5/boards.cfg is up to date. Nothing to do.
> Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
> 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> 06: qcom_defconfig: enable psci based sysreset
>    aarch64: (for 1/1 boards) all +224.0 data +8.0 text +216.0
>             qcom_ipq9574_mmc: all +224 data +8 text +216
>                u-boot: add: 2/0, grow: 2/0 bytes: 224/0 (224)
>                  function                                   old     new  =
 delta
>                  sysreset_walk_arg                            -     124  =
  +124
>                  do_reset                                   100     160  =
   +60
>                  sysreset_request_arg                         -      32  =
   +32
>                  psci_sysreset_ops                           24      32  =
    +8
> (no errors to report)

OK, so minimal growth on the platforms that would use it. How about
platforms which don't? qemu_arm and qemu_arm64 should build the sysreset
code in general and that's where I'm most concerned, platforms which
aren't using this feature. Thanks.

--=20
Tom

--Z3gHInWG5mf2+k45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWpOqgAKCRAr4qD1Cr/k
Cg3PAP9tLnDpQy9XfsFhuTpucOW8rXA8PVbQPR/Fn5kPD+nmHgEAwUsEZlxbD1+d
3KWpVb9JEN7vRAmMEYEmnfMYpGSo3QY=
=dznr
-----END PGP SIGNATURE-----

--Z3gHInWG5mf2+k45--
