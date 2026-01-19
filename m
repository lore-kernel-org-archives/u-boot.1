Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F3BD29C4C
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 17:07:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B0D83015;
	Mon, 19 Jan 2026 18:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZtyngJ/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5553F83015; Mon, 19 Jan 2026 18:07:10 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D948680B98
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 18:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7cfcc131958so2940251a34.0
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 09:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768842424; x=1769447224; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b9Cfsno/5TO6oJogFA9muOrkLZpuR9hFNEeNKi0EqA4=;
 b=ZtyngJ/G/IvdcO+qzMzW87Yg6eAOiiZTG3k9UuWYnoaS2Bb2HznW3wGfgaLrOlb0dc
 lYR5eEsZqW1MT93QRMqsezeqoJsOYhHBmObvF4Rqig1ArqN5KCePbiRDkMOI+SSZsa+5
 PSrZ+le3nMVfFRZ0wHcTfbfQM7Hi46j3zXlBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768842424; x=1769447224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9Cfsno/5TO6oJogFA9muOrkLZpuR9hFNEeNKi0EqA4=;
 b=BEb24ruXbTOhY4T0dkjyc3X9U5Et8m+cxR+Rp7tlf2SJhf9bjaupSHMDEiimETOfrm
 el6W+tOUfpauPccXcvKDTeuCLAfM3N1ZGIb0BmricOxI/gNqAhi0U3a6PFmFXMP3+rUV
 nE0CunPw1skPoabni4XJ1KA0FrJL10AptIbEUwOL2PVdlf6M3hxnX3+MfcL1uENvCVu1
 tT43xGNurFBm6my8wIAi+L7eJMZNE9Df1s9erV4H/uYhoBrk2OAsHpabo+KXh7ydkiM+
 /CD/5wpEbOrKgfSRGSLrjevJWO7kWIF1jrLKElPBkgU7HqWw+xrkhmU1W12ZGbq1134r
 hTNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt/TjX50ZxUkhKm6zg5ta31xkpAigPKNHqthlCoP7k0ZDMg35yMC3i3lSXuBT8X1od514YfNs=@lists.denx.de
X-Gm-Message-State: AOJu0YyFZeJ/oGgRIVTwLXFlLBM/4dUnjNKMvBbDWUITTS4qt3G4PM2V
 lJ1csOkAQzraE1jODPzcNKVNzb1lDazHzLxbuR/KzhdLjJ8oVXdPWbiU4+lXHk6HJq4=
X-Gm-Gg: AY/fxX4YDOB2TY5fNAoBuDRoBSZns/y4vJW1qDWuJzFh+WJhIqIJTsiLxF/94IturWW
 48B26Wi0w5eyaCkFgZp/KShsao6mnZ54wrldCpdcmxQ8xveELgCX7EdbyFUOKRVigZAHXa2q50b
 7g56tnXjWkkv+tTJEdVWF/F2aiIb2gkeORhPuMz3NyiFITmmIaAg5ZUlm2XD+oNAPuzZyoji+hu
 Ns2plzXlyCUKzSiG/v5uByjWJc/r/sg/YgLye/OiYslHNGGwqnYKzDFIdX3TFzersdD3FbsQ8Gp
 gW13FoJGE45mm3KYJJFV70BEZO81UzgTC3u0caOjl7HiI78OL5lWaDktiD1loJ4bZmWzrmI92QE
 AzN8MIvX35cpwvnpCr7zG6vepwwKMW1pl9xCQejc+5DitP0PE32dBZMmP3fxLCVgejjxNHqov8x
 4qZ+gHy57f3c5Dg6iHDUVqpTcKvpWBziMSm3oUw4bZ/yoBovv4cgi5B2nr9/eOCOT6URzaWA+Oi
 tDJws7ByD2xpqyS85MKNnOWDRQ32BHIlXlk3Rs=
X-Received: by 2002:a05:6830:4982:b0:7cb:125d:2a47 with SMTP id
 46e09a7af769-7cfded3181amr6745435a34.1.1768842424546; 
 Mon, 19 Jan 2026 09:07:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0e94b2sm6931524a34.7.2026.01.19.09.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 09:07:03 -0800 (PST)
Date: Mon, 19 Jan 2026 11:07:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 christopher.obbard@linaro.org, me@samcday.com, michal.simek@amd.com,
 clamor95@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 0/5] Implement reset to EDL for qcs9100
Message-ID: <20260119170701.GD3416603@bill-the-cat>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260113144244.GV3416603@bill-the-cat>
 <aWnkOxk5xiZDG5YX@hu-varada-blr.qualcomm.com>
 <20260116144355.GK3416603@bill-the-cat>
 <aW3DjqaULjsb32QU@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b9pEDwonMMXG9UPn"
Content-Disposition: inline
In-Reply-To: <aW3DjqaULjsb32QU@hu-varada-blr.qualcomm.com>
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


--b9pEDwonMMXG9UPn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:09:26AM +0530, Varadarajan Narayanan wrote:
> On Fri, Jan 16, 2026 at 08:43:55AM -0600, Tom Rini wrote:
> > On Fri, Jan 16, 2026 at 12:39:47PM +0530, Varadarajan Narayanan wrote:
> > > On Tue, Jan 13, 2026 at 08:42:44AM -0600, Tom Rini wrote:
> > > > On Tue, Jan 13, 2026 at 04:08:35PM +0530, Varadarajan Narayanan wro=
te:
> > > >
> > > > > Using the 'reboot edl' command in Linux, the platform can reboot =
to the
> > > > > Emergency Download mode. Implement the same for U-Boot.
> > > >
> > > > Have you used buildman's size checking options before? If not,
> > >
> > > No.
> > >
> > > > https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/t=
rini/u-boot-size-test.sh?ref_type=3Dheads
> > > > may be helpful to you, as it can be a bit tricky at first (but IMHO=
 is
> > > > better than the linux kernel bloat-o-meter). I ask because, what is=
 the
> > > > size impact of these changes on things like say qemu_arm64 and qemu=
_arm?
> > > > I saw the cmd/ portion is guarded by a new CONFIG option which is g=
ood,
> > > > but I wonder about the more generic sysreset changes. Thanks!
> > >
> > > Please see below for u-boot-size-test.sh output
> > >
> > > $ ./u-boot-size-test.sh --board qcom_ipq9574_mmc
> > > Generating board list...Processing #include to produce configs/socfpg=
a_agilex5_vab_defconfig
> > > Processing #include to produce configs/r8a78000_ironhide_defconfig
> > > 	.
> > > 	.
> > > 	.
> > > Processing #include to produce configs/am69_sk_a72_defconfig
> > > Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
> > > 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> > > 06: qcom_defconfig: enable psci based sysreset
> > >     2    0    0 /2              qcom_ipq9574_mmc
> > > Completed: 2 total built, 2 newly), duration 0:00:13, rate 0.15
> > > /tmp/qcom_ipq9574_mmc/edl5/boards.cfg is up to date. Nothing to do.
> > > Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
> > > 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> > > 06: qcom_defconfig: enable psci based sysreset
> > >    aarch64: (for 1/1 boards) all +224.0 data +8.0 text +216.0
> > >             qcom_ipq9574_mmc: all +224 data +8 text +216
> > >                u-boot: add: 2/0, grow: 2/0 bytes: 224/0 (224)
> > >                  function                                   old     n=
ew   delta
> > >                  sysreset_walk_arg                            -     1=
24    +124
> > >                  do_reset                                   100     1=
60     +60
> > >                  sysreset_request_arg                         -      =
32     +32
> > >                  psci_sysreset_ops                           24      =
32      +8
> > > (no errors to report)
> >
> > OK, so minimal growth on the platforms that would use it. How about
> > platforms which don't? qemu_arm and qemu_arm64 should build the sysreset
> > code in general and that's where I'm most concerned, platforms which
> > aren't using this feature. Thanks.
>=20
> Please see below for u-boot-size-test.sh output
>=20
> $ ./u-boot-size-test.sh --board qemu_arm
> Generating board list...Processing #include to produce configs/socfpga_ag=
ilex5_vab_defconfig
> Processing #include to produce configs/imx6ulz_smm_m2_defconfig
> 	.
> 	.
> 	.
> Processing #include to produce configs/am69_sk_a72_defconfig
> Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
> 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> 06: qcom_defconfig: enable psci based sysreset
>     2    0    0 /2              qemu_arm
> Completed: 2 total built, 2 newly), duration 0:00:18, rate 0.11
> /tmp/qemu_arm/edl5/boards.cfg is up to date. Nothing to do.
> Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
> 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> 06: qcom_defconfig: enable psci based sysreset
>        arm: (for 1/1 boards) all +184.0 text +184.0
>             qemu_arm       : all +184 text +184
>                u-boot: add: 2/0, grow: 2/0 bytes: 184/0 (184)
>                  function                                   old     new  =
 delta
>                  sysreset_walk_arg                            -     104  =
  +104
>                  do_reset                                    92     136  =
   +44
>                  sysreset_request_arg                         -      32  =
   +32
>                  psci_sysreset_ops                           12      16  =
    +4
> (no errors to report)
>=20
> $ ./u-boot-size-test.sh --board qemu_arm64
> Generating board list...Processing #include to produce configs/socfpga_ag=
ilex5_vab_defconfig
> Processing #include to produce configs/imx6ulz_smm_m2_defconfig
> 	.
> 	.
> 	.
> Processing #include to produce configs/genmai_defconfig
> Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
> 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> 06: qcom_defconfig: enable psci based sysreset
>     2    0    0 /2              qemu_arm64
> Completed: 2 total built, 2 newly), duration 0:00:19, rate 0.11
> /tmp/qemu_arm64/edl5/boards.cfg is up to date. Nothing to do.
> Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
> 01: configs: am57xx_hs_evm_defconfig: Reserve EMIF memory used by PPA
> 06: qcom_defconfig: enable psci based sysreset
>    aarch64: (for 1/1 boards) all +216.0 data +8.0 rodata -8.0 text +216.0
>             qemu_arm64     : all +216 data +8 rodata -8 text +216
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

That's not great. Can you please look at if you can cleanly rework your
changes to have less, or ideally no, size growth on the 700+ other
platforms that enable SYSRESET? Thanks.

--=20
Tom

--b9pEDwonMMXG9UPn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW5ksQAKCRAr4qD1Cr/k
CrxlAPwPpDR8O8BMWU52EZrHSf7xW4ZxwT65EBTYqBxEZG7d5wD9GkW1EJP/wKBF
FWRYx2/NdTeQxRvdFtd93F7oUnLCGAU=
=DGq5
-----END PGP SIGNATURE-----

--b9pEDwonMMXG9UPn--
