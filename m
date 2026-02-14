Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9451BEF5851
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 20:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CFB83AA9;
	Sat, 14 Feb 2026 21:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r/XRsPv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54B2C83AAB; Sat, 14 Feb 2026 21:49:50 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7C6283AA7
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 21:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d1872504cbso1910223a34.0
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 12:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771102186; x=1771706986; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nQwP2gBITVPP+YDdYkwki0PoThSNb6eGSHBqF7jAU8Q=;
 b=r/XRsPv2pRWLHBI+C71uWuIMH96yFR+Pn9yn5oBGPtk7jFcKnvGWNoAb9LQKY6SIKS
 mMNeqwbOn52SdavXLpdFrmea+UZPIcPXL3Bt82kOyUXcRj7dgvQySXtnGn8cX2GFMEqW
 ZzYkrbB6r08aLHDR6tP5wf/ckpbIYoI87uIUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771102186; x=1771706986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQwP2gBITVPP+YDdYkwki0PoThSNb6eGSHBqF7jAU8Q=;
 b=LHLoP5ni8qLwqE7j9hw2He5rGqZx4tOk7sAwtfqQIP2IPash465aQ1m9cMsLCIy9kE
 +seZW17EnwVW8MGg7R3Q9t+ZF/tXM5HWvYgJJQTrLrbSHhmt8ldYRFk3ZWe1ibbMlxNL
 82QYo7UuFeZxv8Se6MPln1/ORrW0Rgp7uGp9atoyRSKdyrmJi6yJFOAdcXfp83kjYnhs
 a4XK0YOH/0L/5rsBQT7ivBU7DeOQCgC1bYUUCr1O2f18VmB3JMIYtR9xkVBh1xo1oRw6
 VW/g6aOtvlIKXkz4p7Qs9kDKbumZ5y7Wrp9lnCTa2GXxLTbZ/QFT9cOVjaI1d2SaNgba
 3HZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq+3b0bnx7OXViJOvmc11RbSsl85LiifzxmorKDsBc3O612/ZNe2VLSIt166/z1X3IxTdA1O4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6ScidZS3wKPGSd3u4dafaY6DXieGtZb1VAi0k28dfm1J22WEJ
 +x5KwRE5P4MH6wrXNhuwZdbTYQyDGO+KimclBsL9moTPdW2TcKe4KOuD7uXwIIWFEBk=
X-Gm-Gg: AZuq6aJwmVz2O5Jd66uRiOWLlT/q5mHIJ7IAu8CYpE67EorFr0zJe8L/nxqtb0ABpiU
 LoG0bwuyZmgxGEcO8VBaB2IsYL5PAuv04FsRTZGfUBWS4y56LthSg0g5UJJs2SteIpZu4ttDMSq
 XwtSMUw7mCVfU3CMCNGEVG+O6ImvA8I1N0Y2JCiY4h4L/FBzspfEZ2TRg6iReB3NCKMhGmcMvmW
 wrhR22EZAaL/QdFxTW8Rdm46efRDPT+5LZ3TOhLhJbBfAAzS6owhTv/v/080QsF/cW3kiIu1ggM
 nZxWyhVvvejMr9EuhVNTU7BUehbmfJSR6d5oNqT4kqoYfLTzIKlC8VtGLwUPgzmJEGVu0eyzYL/
 n53twJgaAewMOmczYF88P16DheW6eSfqEKKhjKuk6CuP9PQcgi+iOB8A3oVXxvWGS50RHDX3126
 YvhyOG8+xWQr+Xr4Y0r7AVxyOjrsTqJC9jU6ARY2lFPIqsdTEl6PGaF7hyuKUqwbrOM6+PW+51v
 bmDqpb51kBRljv4lSx3/+Txu3nbg4oHpQUddXBAzuxz9ZBFlyw=
X-Received: by 2002:a05:6830:8113:b0:7cf:c665:8884 with SMTP id
 46e09a7af769-7d4cdfaaabamr1560914a34.17.1771102186371; 
 Sat, 14 Feb 2026 12:49:46 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f96b8sm8878359a34.21.2026.02.14.12.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 12:49:45 -0800 (PST)
Date: Sat, 14 Feb 2026 14:49:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Lok, Chen Huei" <chen.huei.lok@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: Pull request: SoCFPGA changes for u-boot-socfpga-next-20260213
Message-ID: <20260214204943.GT2747538@bill-the-cat>
References: <LV8PR03MB81379CE3BDF36A06DC1D517BA761A@LV8PR03MB8137.namprd03.prod.outlook.com>
 <20260214185409.GS2747538@bill-the-cat>
 <CAN7C2SAbayHsJWyKQE=trBhV-qFTdVTdV-pFCM-ji4tRzZoUTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dVU8n+VNUu5nw9cJ"
Content-Disposition: inline
In-Reply-To: <CAN7C2SAbayHsJWyKQE=trBhV-qFTdVTdV-pFCM-ji4tRzZoUTg@mail.gmail.com>
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


--dVU8n+VNUu5nw9cJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 15, 2026 at 03:58:35AM +0800, Sune Brian wrote:
> On Sun, Feb 15, 2026 at 2:54=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sat, Feb 14, 2026 at 04:45:41AM +0000, Chee, Tien Fong wrote:
> >
> > > Dear Tom,
> > >
> > > This pull request updates SoCFPGA platforms with DDR improvements, ne=
w board support, Agilex5 enhancements and general cleanup across the codeba=
se.
> > > DDR and memory handling
> > >
> > >   *
> > > Add DRAM size checking support for Arria10.
> > >   *
> > > Widen MEM_TOTAL_CAPACITY mask handling in IOSSM mailbox driver.
> > >   *
> > > Assign unit address to memory node for improved memory representation=
 and consistency.
> > >
> > > Agilex / Agilex5 updates
> > >
> > >   *
> > > Restore multi-DTB support for NAND boot and fix NAND clock handling.
> > >   *
> > > Enable SD card UHS mode and eMMC HS200/HS400 mode support on Agilex5.
> > >   *
> > > Fix DT property naming conventions for Agilex5.
> > >   *
> > > Exclude AGILEX_L4_SYS_FREE_CLK from clock enable/disable operations t=
o avoid unintended clock control.
> > >
> > > New board support
> > >
> > >   *
> > > Add support for CoreCourse Cyclone V boards:
> > >      *
> > > AC501
> > >      *
> > > AC550
> > > Including device trees, QTS configuration, defconfigs and maintainers=
 entries.
> > >
> > > Fixes and cleanup
> > >
> > >   *
> > > Fix GEN5 handoff script path.
> > >   *
> > > Remove incorrect CONFIG_SPL_LDSCRIPT settings.
> > >   *
> > > Replace legacy TARGET namespace and perform related cleanup across So=
CFPGA code.
> > >   *
> > > General Kconfig, build and SoCFPGA maintenance updates.
> > >
> > > Overall this pull request improves platform robustness, adds new boar=
d coverage and cleans up legacy configuration usage across the SoCFPGA U-Bo=
ot codebase.
> > > Thanks.
> > >
> > > Best regards,
> > > Tien Fong
> > >
> > > The following changes since commit f9ffeec4bdcf1da655a0ffea482062adde=
78fee8:
> > >
> > >   board: toradex: Make A53 get RAM size from DT in K3 boards (2026-02=
-12 08:12:09 -0600)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git tags/u-=
boot-socfpga-next-20260213
> > >
> > > for you to fetch changes up to 4b567f8e252e27f6dafdfe22de1bad147595e3=
3b:
> > >
> > >   Replace TARGET namespace and cleanup properly (2026-02-13 20:35:09 =
+0800)
> > >
> >
>=20
> Hi Tom,
>=20
> Actually I am also troubled by this manners:
>=20
> If there are patches that are not committed yet while new patches do
> rely on the other holding patches.
>=20
> Under that background should the new patch that relies on another
> follow the new one or ignore the dependent patch.
> Keep using the master to develop.

I'm not sure I follow you, sorry. It's hard to get gitlab to show the
merge commit diff itself, but:
$ git show 136faf7b0cc9
commit 136faf7b0cc92af1d38b0db1bfaa5405e884ee2d
Merge: 6caff66ce469 62f7a9460209
Author: Tom Rini <trini@konsulko.com>
Date:   Sat Feb 14 08:58:38 2026 -0600

    Merge tag 'u-boot-socfpga-next-20260213' of https://source.denx.de/u-bo=
ot/custodians/u-boot-socfpga into next
   =20
    This pull request updates SoCFPGA platforms with DDR improvements, new
    board support, Agilex5 enhancements and general cleanup across the
    codebase.
   =20
    DDR and memory handling
   =20
      * Add DRAM size checking support for Arria10.
      * Widen MEM_TOTAL_CAPACITY mask handling in IOSSM mailbox driver.
      * Assign unit address to memory node for improved memory
        representation and consistency.
   =20
    Agilex / Agilex5 updates
   =20
      * Restore multi-DTB support for NAND boot and fix NAND clock handling.
      * Enable SD card UHS mode and eMMC HS200/HS400 mode support on Agilex=
5.
      * Fix DT property naming conventions for Agilex5.
      * Exclude AGILEX_L4_SYS_FREE_CLK from clock enable/disable operations
        to avoid unintended clock control.
   =20
    New board support
   =20
      * Add support for CoreCourse Cyclone V boards:
         * AC501
         * AC550
    Including device trees, QTS configuration, defconfigs and maintainers
    entries.
   =20
    Fixes and cleanup
   =20
      * Fix GEN5 handoff script path.
      * Remove incorrect CONFIG_SPL_LDSCRIPT settings.
      * Replace legacy TARGET namespace and perform related cleanup across
        SoCFPGA code.
      * General Kconfig, build and SoCFPGA maintenance updates.
   =20
    Overall this pull request improves platform robustness, adds new board
    coverage and cleans up legacy configuration usage across the SoCFPGA
    U-Boot codebase.
   =20
    [trini: Change TARGET_SOCFPGA_CYCLONE5 to ARCH_SOCFPGA_CYCLONE5 in the
    new platforms this added]
    Signed-off-by: Tom Rini <trini@konsulko.com>

diff --cc arch/arm/mach-socfpga/Kconfig
index f2e959b56624,3a9e018ce234..aec0fb7b1c8e
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@@ -237,7 -237,15 +237,15 @@@ config TARGET_SOCFPGA_TERASIC_DE1_SO
 =20
  config TARGET_SOCFPGA_TERASIC_SOCKIT
  	bool "Terasic SoCkit (Cyclone V)"
- 	select TARGET_SOCFPGA_CYCLONE5
+ 	select ARCH_SOCFPGA_CYCLONE5
+=20
+ config TARGET_SOCFPGA_CORECOURSE_AC501SOC
+ 	bool "CoreCourse AC501SoC (Cyclone V)"
 -	select TARGET_SOCFPGA_CYCLONE5
++	select ARCH_SOCFPGA_CYCLONE5
+=20
+ config TARGET_SOCFPGA_CORECOURSE_AC550SOC
+ 	bool "CoreCourse AC550SoC (Cyclone V)"
 -	select TARGET_SOCFPGA_CYCLONE5
++	select ARCH_SOCFPGA_CYCLONE5
 =20
  endchoice
 =20
And this is the simple and obviously correct type of change custodians
are allowed to make, if they don't want to push changes out to being
merged even later. The symbol TARGET_SOCFPGA_CYCLONE5 was globally
renamed to ARCH_SOCFPGA_CYCLONE5, and so could have been corrected (And
SoB'd) by Tien Fong. But since this didn't go through CI, it wasn't
caught, so I fixed it up, rather than push everything back again.

In some cases, people will develop their series and say it depends on
another going in first, for example:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D489945
is functionally blocked by:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D491484
and the cover letter notes this.

--=20
Tom

--dVU8n+VNUu5nw9cJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZDf5AAKCRAr4qD1Cr/k
Cj+pAP0U+njXKEjyfMGY+1rSfjGSxal3cHbtVNS+ZV/EP8sLjQEA/ot4nO0beJ9j
kf+BEx0tMtD0lxrbsPkOclkuVVx5Egs=
=4BbR
-----END PGP SIGNATURE-----

--dVU8n+VNUu5nw9cJ--
