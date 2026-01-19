Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D523C98315
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 00:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7968313B;
	Mon, 19 Jan 2026 01:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="oB7VTkEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3198397A; Mon, 19 Jan 2026 01:10:08 +0100 (CET)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 800B083015
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 01:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=vagrant@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=1nAR/YAuYVMVdsZPyStU+vuB1aiRm61QXWRGbNtDKnM=; b=oB7VTkEPUYvj89E3jLOxfbDx2U
 DsDj9mYDtVylpEka80qVXTVAuijmz5nbSj852A+wPiZOatk4FlipdlLb18aMRY0KsVkdzo3AwivnV
 DFPTbXrYmHAPWLsgm4hXCzqm5UfXe1hywm9qwun0I3Hghe1wgWONLyudQP85NTbCcFS95oX7oh34z
 Q3K/cveNbCIzJbOWBBm1IUse+XcoowhX/+cPMTVtNwE2HvQvxIlsi7Bu08OcT+2ednhmzNplTqUYX
 7NMzr9vcJhmdSDKinI0BT99CHlH/6xbNDw+o2SFmJMaPd6ZDPsMMXwD1P5gnlMIfbsbPlxFw6ICtA
 9eWwVXyg==;
Received: from authenticated user by stravinsky.debian.org with utf8esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <vagrant@debian.org>)
 id 1vhcqF-00A9Fl-GG; Mon, 19 Jan 2026 00:09:59 +0000
From: Vagrant Cascadian <vagrant@debian.org>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Subject: [PATCH] board: unmatched: Workaround failure to find .dtb file.
Date: Sun, 18 Jan 2026 16:09:53 -0800
Message-ID: <877bteqx7y.fsf@wireframe>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Debian-User: vagrant
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The fdtdfile variable contains quotes:

  printenv fdtfile
  fdtfile=3D"sifive/hifive-unmatched-a00.dtb"

But this leads to issues which booting with an extlinux.conf format
file failing to find the .dtb file:

  Retrieving file: /usr/lib/linux-image-6.12.63+deb13-riscv64/"sifive/hifiv=
e-unmatched-a00.dtb"
  Skipping fdtdir /usr/lib/linux-image-6.12.63+deb13-riscv64/ for failure r=
etrieving dts

Other platforms (e.g. rockpro64-rk3399) do not contain quotes in the
fdtfile variable, and work properly out of the box.

The workaround suggested by marex is to hard-code the correct .dtb
value, which works for me.

This has been present at least since version 2025.01, also present in
2026.01. I have not yet tested against git master branch.

This could probably be properly fixed by stripping the quotes in
whatever processes the .env file. There are numerous other boards that
have the same way of setting the fdtfile variable, which might
similarly be effected by this issue.

Signed-off-by: Vagrant Cascadian <vagrant@debian.org>

Not sure who all to CC on this, please feel free to forward
appropriately!

=2D--
 board/sifive/unmatched/unmatched.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/sifive/unmatched/unmatched.env b/board/sifive/unmatched/=
unmatched.env
index 34425dc9efa..cdba2c8ae0e 100644
=2D-- a/board/sifive/unmatched/unmatched.env
+++ b/board/sifive/unmatched/unmatched.env
@@ -16,4 +16,4 @@ partitions=3D
     name=3Dloader1,start=3D17K,size=3D1M,type=3D${type_guid_gpt_loader1};
     name=3Dloader2,size=3D4MB,type=3D${type_guid_gpt_loader2};
     name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system};
=2Dfdtfile=3DCONFIG_DEFAULT_FDT_FILE
+fdtfile=3Dsifive/hifive-unmatched-a00.dtb
=2D-=20
2.47.3


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCaW12UQAKCRDcUY/If5cW
qrOUAQCVD0kSty9AbABTTATzA/OtrsA15i4YX8XLgHEMfl6jYQEAmhLq2WP+CF63
e6kfBkgwOmX5XZwu/S4NbNX4SW/cOwE=
=cQVA
-----END PGP SIGNATURE-----
--=-=-=--
