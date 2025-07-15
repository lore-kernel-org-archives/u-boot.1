Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C77EC83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 21:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BFF4830B3;
	Tue, 15 Jul 2025 23:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="boCAaqBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 369F8830C8; Tue, 15 Jul 2025 23:42:13 +0200 (CEST)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D5498309A
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 23:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752615724; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DQjFAvs1Oo2RjVjzlPxPKUC1X2LEeB/s5yTdue+/QqstmTkzH35Di7H79AeYkUxv6os7irIMql6lk6cpSab9wO59dII+h9hOvQaW52T2mxJ+aZOAZ3xdwWCiI98uYs0M8wQHtNmgtPMcJ9EuPtLLFW/AWMkkjbRiT8SpYDWYu6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1752615724;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YfsH2UWzxIzNmNEAfaYLlPFquugKv6HMORCOmeDsKrs=; 
 b=MkrgxxB52+zCc8YN5Y3BDW1hxqif6nhsRHuS7oBuOnriPbUxU9Da4V+m0RQ/hY6xxCUWv3R/SbN+gPIB4mpHMqJFLHKqapy1G0eaZcQWmCB/Dv9AqRDkaXN+3yrVYru6RIzDKJWl/ewfPBIqHjWwb8QdBftPlz3WvIoFjR5jN2o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752615724; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=YfsH2UWzxIzNmNEAfaYLlPFquugKv6HMORCOmeDsKrs=;
 b=boCAaqBEYZRjR8krKMOAlx7ObbQ3VNsO6aEEEvl72olXWFrbM8EuGoHcSMaDhH08
 KA3MinMseo/0uS5MRcHifO/dRtV2UdIOI5cEnL3TVdAfkMl8steoNOH2ngTLaJfD0B+
 p2T4iY7sAkZJfMq3cjxk/DRkf6Ox/VlpVWC4JOZ0=
Received: by mx.zohomail.com with SMTPS id 1752615722357743.2875535097518;
 Tue, 15 Jul 2025 14:42:02 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 80294180F0F; Tue, 15 Jul 2025 23:41:56 +0200 (CEST)
Date: Tue, 15 Jul 2025 23:41:56 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] rockchip: rock5b-rk3588: Add support for ROCK 5B+
Message-ID: <4w4js2kvttti73op54urtecq33lu4twfz6xqgtz74dbbhy3ahw@y4a7j22kvjko>
References: <20250714223410.1836893-1-jonas@kwiboo.se>
 <20250714223410.1836893-5-jonas@kwiboo.se>
 <e46mypj2zn7ggff7ivef3k7ejqnc6swng6tfi2cymlipcak6fc@6n43szvkzzvf>
 <7c172335-4ad6-4503-bc40-c56301970813@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3xyrsb3eaqdb4t3h"
Content-Disposition: inline
In-Reply-To: <7c172335-4ad6-4503-bc40-c56301970813@kwiboo.se>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/252.589.14
X-ZohoMailClient: External
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


--3xyrsb3eaqdb4t3h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] rockchip: rock5b-rk3588: Add support for ROCK 5B+
MIME-Version: 1.0

Hi,

On Tue, Jul 15, 2025 at 08:26:27PM +0200, Jonas Karlman wrote:
> On 7/15/2025 6:48 PM, Sebastian Reichel wrote:
> > On Mon, Jul 14, 2025 at 10:34:01PM +0000, Jonas Karlman wrote:
> >> Include FDTs for both ROCK 5B and 5B+ in the FIT and add board
> >> selection code to load the 5B+ FDT when the ADC channel 5 value is
> >> close to 4095.
> >=20
> > The Rock 5B uses the same channel and starts with 0V for revision A
> > and jumps in 0.3V steps for newer revisions. So technically a Rock
> > 5B revision H would be detected as Rock 5B+ with this code. IDK if
> > Radxa will ever release such a board. But I have an alternative
> > implementation, which does the board detection via the DDR memory
> > type (Rock 5B =3D LPDDR4, Rock 5B+ =3D LPDDR5):
>=20
> Radxa's U-Boot has following table of SARADC values, something that seem
> to match for the board model and revisions I have access to.
>=20
> static struct variant_def variants[] =3D {
> 	{"rockchip,rk3588", 300, 380, "rockchip/rk3588s-radxa-e54c.dtb"},
> 	{"rockchip,rk3588", 980, 1060, "rockchip/rk3588-rock-5t.dtb"},
> 	{"rockchip,rk3588", 1650, 1730, "rockchip/rk3588s-radxa-e52c.dtb"},
> 	{"rockchip,rk3588", 2360, 2440, "rockchip/rk3588s-rock-5c.dtb"},
> 	{"rockchip,rk3588", 3370, 3450, "rockchip/rk3588s-rock-5d.dtb"},
> 	{"rockchip,rk3588", 4050, 4130, "rockchip/rk3588-rock-5b-plus.dtb"},
> };

Interesting. When I checked they still had a standalone config for
each board :) I guess if Radxa started relying on this there is a
lower chance of collisions. On the other hand the Rock 5T looks
quite close to your Rock 5B values.

> My Radxa rk358x boards report following for SARADC ch5:
> - ROCK 5B+ (no emmc): 4073, 1790329 uV
> - ROCK 5B+ (with emmc): 4075, 1791208 uV
> - ROCK 5B v1.42:  854, 375384 uV
> - ROCK 5B v1.42: 1100, 483516 uV
> - ROCK 5B v1.45: 1211, 532307 uV
> - ROCK 5B v1.46: 2109, 927032 uV
> - ROCK 5A v1.1: 682, 299780 uV
> - ROCK 5A v1.2: 685, 301098 uV
> - ROCK 5C v1.1: 2402, 1055824 uV
> - ROCK 5C Lite v1.1: 2402, 1055824 uV=20
> - E52C v1.2: 1692, 743736 uV
> - E54C v1.2: 340, 149450 uV
>=20
> So Radxa's table seem to match values reported by my boards/models.
>=20
> Maybe the ROCK 5B is a little bit more flaky in reading out the ADC
> value and matching using some different way could improve board accuracy.

I was looking at the table on page 15 of the Rock 5B schematics:

https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock_5b_v1423_sch.pdf

> > https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot/-=
/commit/9803234dbb014a8fa4b495aa8f95bdc710d88380
>=20
> rockchip_sdram_size() and asm/arch-rockchip/sdram.h already contains
> code and defines for these regs, so should probably be re-used instead
> of re-inventing how the DRAM type is read from OS reg if we go with DRAM
> type matching ;-)

Right.

> > Considering that the different memory is something Radxa explicitly
> > promotes as board difference between 5B and 5B+ it seems like a
> > better approach to me.
>=20
> My main concern with using DRAM type matching is that it may limit
> what models can be supported by a single defconfig.

Fully agreed.

> > Note I only haven't send this yet, since I
> > was waiting for the Rock 5B+ DT to land in the upstream kernel. But
>=20
> Sorry, I have not looked at your downstream tree for some time ;-)

No worries, I do not expect anyone doing so :)

> Btw, you can probably drop my "HACK: mkimage: fit: Keep data that should
> be loaded into SRAM embedded" from your tree, it should not be needed
> since long time now that PIO mode typically is used instead of DMA for
> TF-A loading.

Ack.

> > I'm totally happy for you to take care of this :)
>=20
> I can probably extend the check to include DRAM type testing for a v2,
> should probably make board model matching as safe as it can be.

Combining both methods sounds good to me. The DRAM type check is
quite cheap.

Greetings,

-- Sebastian

--3xyrsb3eaqdb4t3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmh2yyAACgkQ2O7X88g7
+prfow//eSE4TXe9Gy+CX6I+A7MFG0CYb0YUb1HAxWfmae+IU0d00X5VRoKfzUiT
+JIlKXHZ4EZ9/IXeRgiZivpD9WcvLHaviyVdDs1uRJYSWdFj9mMcSD0DiSodsGMw
Vac7fIlSjQX+c8Cf+p2a3wGvkThRoAicRW/OBHn7hb5APb5be3Z+YAxPwYHuMqX0
CXxP4RZeAJM9yBXi/yJi/fAsEAdySSe5OzUMleyfgVvtWmrsLAmhZNhh1Y/Yni5S
4o/v383WWzyUlY7XAXbOMg8aY9Bb45kYq/UNjErAVYZPKiJge58JCnDJKZ/RTkop
D1XJsUpjid8fpwF2X6ypg+RB72nPo+q/lA/MyxMbYjlJJDX5DVfItIHtdvDH39Ic
UaaSCPRRBF5TA9CtkTrbUa4ceXTYwKKOFJVbG2R7O/o/d3QFqoJT8VLs+njZpnjl
1wTFpKgoWxUz9ZHDusZjUsYCOLN0WL47Ule7YV5ilRd/dPUrHb/0eHa3DuNIYaP4
B+u8QRfvovBUoYU+0OtRm27ZfAEAY31+SbcA/APjCLIJVtQMRmVDEjS01v/W9/gt
l6bVCw8AOrlZQmxfCoQ5hcbZc4pydjH+JRIHr6qtkLzfqBRE7s53JWYh2Cgh654A
RuHCkcIBhlVLEp2Yt841EVmO+WzqD93klm2g1LvNvLLZzWvnIJU=
=5oD+
-----END PGP SIGNATURE-----

--3xyrsb3eaqdb4t3h--
