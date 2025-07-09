Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4B8C83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 16:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3137183479;
	Wed,  9 Jul 2025 18:24:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="qY/uVdr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 456C98349B; Wed,  9 Jul 2025 18:24:06 +0200 (CEST)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD438344C
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 18:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:MIME-Version:Content-Type; 
 bh=q7QwfvhkIporZZhkYYK6w7+H1bjvQSF6RTUThWKL8xE=;
 b=qY/uVdr6UTNIhVMsRMdOnyf+sstrSE/7kzCWLv40tatXplK1hJmW8f+osD5qbZ5hQh0H7f6yIFWGjq75DlMnWagES1ycPsgp7tSps4A+dwslZA30j7kKdzkc+Z2Fqt+AlIFtCjgAWpSTM6Jx7YxwMzNuQCJNkDuzguy+UdvaD4g=
Received: from lukas-hpz440workstation.localnet (cm70-231.liwest.at
 [212.241.70.231]) by mail.netcube.li with ESMTPSA
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256)
 ; Wed, 9 Jul 2025 18:24:03 +0200
From: Lukas Schmid <lukas.schmid@netcube.li>
To: u-boot@lists.denx.de
Subject: [T113-s3][u-boot] PG10/PG11 (TWI3) pinmux overridden before late_init
Date: Wed, 09 Jul 2025 18:24:02 +0200
Message-ID: <2020043.yKVeVyVuyW@lukas-hpz440workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2193940.OBFZWjSADL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart2193940.OBFZWjSADL
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Lukas Schmid <lukas.schmid@netcube.li>
To: u-boot@lists.denx.de
Date: Wed, 09 Jul 2025 18:24:02 +0200
Message-ID: <2020043.yKVeVyVuyW@lukas-hpz440workstation>
MIME-Version: 1.0

Hi all,

I'm working on enabling TWI3 (I2C3) on the Allwinner T113-S3 (sun8iw20) in =
U-
Boot.

I set up the pinmux and clock for PG10/PG11 (function 3 for TWI3) using:

sunxi_gpio_set_cfgpin(SUNXI_GPG(10), SUN8I_GPG_TWI3);
sunxi_gpio_set_cfgpin(SUNXI_GPG(11), SUN8I_GPG_TWI3);
clock_twi_onoff(3, 1);

I also added the missing macro:

#define SUN8I_GPG_TWI3 3

This works fine if I call it in board_late_init(), but if I set it earlier=
=20
(e.g., i2c_init_board() or board_init()), the PG10/PG11 mux settings get=20
overwritten or cleared later on.

I verified the pinctrl register at 0x01C20824 (for PG10/PG11) is reset to=20
0xFFFFFFFF unless I reapply it in board_late_init(). Curiously, this does n=
ot=20
happen to nearby ports like PG0=E2=80=93PG7 (0x01C20820), which remain inta=
ct.

Is there some known U-Boot path that resets PG10/PG11 mux early on T113-S3?

Best regards,
Lukas Schmid
--nextPart2193940.OBFZWjSADL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEPv6dcBmn59ssZMkSJnN+drMVRtgFAmhul6IACgkQJnN+drMV
Rtjdlgf/Z5Kb6gRQw7ymPo/IS+fLgJIioVjhRCaw3knOsaZAFOwOrN6XLkHwPT0O
NvtWPDRNqBwJ/gpJZf9ixJv1RU1Lz6yWoJfhAxiQMQoL8jES2Rl87W7vO4n3bUo/
4mCjlqNDa8JiNjHgSyfbD/T6putRPLgdqyB8cTxQa2LKHlkozyvEpRp6Dcrxplpt
9CSUDpJst2+vlkgmJMNmL9oHjivTwwMUAtJQqooAVxUPFeKjI0RKb37eOvsYtMsJ
pcEcrMJddQJzWPkKPPiuS8tyn/BP481EhKrZ/RXCT65RbsRoVTx7YHVBGc7jtczG
/e452ChpXqAwcLT68V89UPvzcKpLNg==
=SUnK
-----END PGP SIGNATURE-----

--nextPart2193940.OBFZWjSADL--




