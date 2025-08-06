Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B03C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DDB83236;
	Thu,  7 Aug 2025 00:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bbNJcifP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B628331C; Thu,  7 Aug 2025 00:13:26 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A20831C6
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3e406ca2d22so1889605ab.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754518402; x=1755123202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I6CjgHo1RCAdq7JjT+J0TJ2t/SFCHl8beA8kkVt8MdU=;
 b=bbNJcifPu6FtGCW6T/9dv7djGHx8S1QgAUvjkDBaujGFbHcptOJYifbWk5m/JV4QrP
 LJUCg5LOgrdXnUDFtpG2eodiTfHUaMwFu82hSxqBwGweMUxCx6bL8LCUF9nNub1h7L3Y
 WswHkGr0KlWK2r2oo0lfeU5+6bA8+Ahp87DRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754518402; x=1755123202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6CjgHo1RCAdq7JjT+J0TJ2t/SFCHl8beA8kkVt8MdU=;
 b=CDP7xhwfxkt/RJduCxLvw2FAqLM9Ry6qSpjZ8TKFfmAqXKj7tp3/ypxN0+GTtyRq64
 JLhTGOqLD3M+pWQZiHNtXjtqqI4Th6WmsncfRkpFSBE1E/NWgx3zXpa8aiSCVR6TX5lU
 sq/7zzM6HA11waIO7vjMm0re2aFGq/r/FWwIkubalBD5l3iW7najEBQczbHZ3opZtsRv
 IvFip1ggZj8Pz/mdlbvHD1EphJD37Yilb5WbxawOHOBPCDimPXJcgxRE315rmfql8tan
 66jSNICsB/KUdfrHhHJIx3/nl98CveNfEMED82OmQ14uaK4q84quSwbAX+Pg/vj3w5Wh
 ZBkA==
X-Gm-Message-State: AOJu0Yw6w8bxDg7WRCTPNF/tuMnfC6VfJ+eJ2IVfgU8q8ytN8bwr2e8U
 m0qFS8KA6ynHvb9OH6atnXiPniAQRF+21yuiNXzEnRsBlzMqv/Uo5JzYjqRiYawS94I=
X-Gm-Gg: ASbGncsAHVP5I0FXWeGU2y9wrywTlcVC164zuFC7hbXISy3iLHCeba0TA+DgNIJvCRa
 W0qy/Wkti2Rr89N6YASz/BfaP10iay+g2Dzes55xJek6EcmQ3JyF8GtfVlQFiKVdML/EHMvZi8/
 Zx79t2tEDRnaOhBzo0y60k4kYq63NwqSey3x1bEAXnE4C2hwB3VnlspN0Dt17Ed568wLV3BGkmC
 BeSTB7QGZXSy1/UkKUmSWPvxMx26rAIDjfMJYC8XAijtrrsv0iTdVf/PTVIvIEmnyQNmO1SiJLs
 BWMrGFLjmvDZPNA4k1E7hBGWXqtQyvw7GK0J44KfUhCuk8OAFLJX2q1oODDqBPp02DN1tpB9JBO
 KIJdZNJvATKjnicvXXt5t5JViyT0G112qRAJ61H7FKGT3LrWXPxQged9r21SgI+Fa/VU=
X-Google-Smtp-Source: AGHT+IE2pXS2+iDGjn4jDdoswCQjlwMrp2jBIVwiDOpZ5haPwrH54BMR5IXx8xvbFFyx4f8N7VRS3w==
X-Received: by 2002:a05:6e02:2686:b0:3e5:176d:768a with SMTP id
 e9e14a558f8ab-3e51b8f65a2mr66382775ab.10.1754518402450; 
 Wed, 06 Aug 2025 15:13:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3e402b12e8asm65977375ab.48.2025.08.06.15.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:13:21 -0700 (PDT)
Date: Wed, 6 Aug 2025 16:13:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@denx.de>
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20250806221319.GU124814@bill-the-cat>
References: <20250806193230.133482-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JODKmzKjntllxDQJ"
Content-Disposition: inline
In-Reply-To: <20250806193230.133482-1-marek.vasut+renesas@mailbox.org>
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


--JODKmzKjntllxDQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 09:30:21PM +0200, Marek Vasut wrote:

> Various fixes for smatch warnings, the i2c one might be also coming in via
> Heiko / I2C tree, let me know if there is conflict.
>=20
> There is also W77Q51NW SPI NOR ID support and matching update for the SH =
DTs.
> The SH DT changes are also landing in mainline Linux, so they will disapp=
ear
> the next time OF_UPSTREAM DTs get synced in, without any expected rebase =
noise.
>=20
> The following changes since commit 007610da2cca405ea7739fc120d90085be4b6a=
c2:
>=20
>   Makefile: Remove expansion of undefined variable (2025-08-04 18:23:16 -=
0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 52a4e9079f680cb3d455d2740f5887ee9089b327:
>=20
>   arm64: renesas: r8a779g3: Enable Winbond SPI NOR support on Retronix R-=
Car V4H Sparrow Hawk board (2025-08-06 17:08:44 +0200)
>=20

After talking with Marek on IRC, I've dropped the DTS portion here as
the changes are not yet in Linus' tree and so dts/upstream is not the
appropriate location. With that, and a slight rewording of the merge
commit message to reflect the lack of DT changes, this is now applied to
u-boot/master, thanks!

--=20
Tom

--JODKmzKjntllxDQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJPTewAKCRAr4qD1Cr/k
CgU+AP4ij9btN7QITiztuyXOMmmxf2XH68fdiioN1rs3MdESjAEA1virJ3ZTRm6f
H8owpWv7ekrHD4SQmlF264B6mker8ws=
=4BQr
-----END PGP SIGNATURE-----

--JODKmzKjntllxDQJ--
