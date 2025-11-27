Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BE6CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 05:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A1A842E7;
	Thu, 27 Nov 2025 06:21:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="U+HBOdvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61725842EB; Thu, 27 Nov 2025 06:21:18 +0100 (CET)
Received: from sender3-op-o15.zoho.com (sender3-op-o15.zoho.com
 [136.143.184.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BD1842CD
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 06:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1764220870; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ThE6pOMGvgHPduGqVCOfwa61E0O1oGvveFmq05wjS7GFS1TjiLdRWD/oD7leDXU2ku7wSxA969mtSIsYpxK1vGbhZoui1Uv9ShkDBRKtDBBz7YNKt8uY20Jzcprb0gBrxisFMFBDgGu4HWDzOL9sWExRTocymBqbCnSmsc4+2S4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764220870;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=z/avwZ+N+jyT4/41QIpboQf5cXD2GV0yr5/gml7TCvE=; 
 b=QMY1fz74OylzDwBR5ydz4XBeT3cesJx+3vXoDSCo/305+1pLAw4tZySafFwhotJmkNMKJ3zcQHBj17yka6errLbhCNSs/9i/Io12DuGhgKXoS0EXu5cNZD4SsgkE7fQf6ADB3baxhlw+1N+7JhlqPdJrtKq4lQ1hdQL25t0KekY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764220870; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=z/avwZ+N+jyT4/41QIpboQf5cXD2GV0yr5/gml7TCvE=;
 b=U+HBOdvHL5escfwButY8Kytm4EX8mr8rAXm1UnNHSESiqgegDCkwX2IP47TrvxDi
 gnjXs8N/bOkMVtQGwAZja3Vcg/9ja++TCJjVlqD2jOrHC0FPfev+FJPM5cB8GTzMMPW
 DB4uHJgu64E5725uOaf/GpTfgE+mRXfyAq7wKu49jzR1izY2h6glvb3KPIw0EK5q9RF
 mBBEsNyP11So6P00r1m0BJel78BwD95wkIbdQTlvmQSzPzUX9Q2o8/7LWz7AjZDaS4P
 XQd9YYQ8RdzbI/sXKm/XsmwsVxE/jh/qDY1HSbLMIVO5eStYNhX1qQLd0rZAYRGAGuB
 +yAlG7M43A==
Received: by mx.zohomail.com with SMTPS id 1764220867614444.11489814522906;
 Wed, 26 Nov 2025 21:21:07 -0800 (PST)
Message-ID: <3011ae00cb3784c885cba99ea9892fdb288c4565.camel@icenowy.me>
Subject: Re: [RFC PATCH v1 0/4] Add upstream board Xunlong Orange Pi RV
From: Icenowy Zheng <uwu@icenowy.me>
To: E Shattow <e@freeshell.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Minda Chen
 <minda.chen@starfivetech.com>,  Hal Feng <hal.feng@starfivetech.com>, Tom
 Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Date: Thu, 27 Nov 2025 13:21:02 +0800
In-Reply-To: <1cb6747e-a54d-4b54-8cbc-f41932e1a29a@freeshell.de>
References: <20251126221552.87574-1-e@freeshell.de>
 <B7BF64B9-B3C7-4885-B1F2-767D69298313@gmx.de>
 <1cb6747e-a54d-4b54-8cbc-f41932e1a29a@freeshell.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
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

=E5=9C=A8 2025-11-26=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 15:42 -0800=EF=BC=
=8CE Shattow=E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 11/26/25 14:34, Heinrich Schuchardt wrote:
> > Am 26. November 2025 23:15:25 MEZ schrieb E Shattow
> > <e@freeshell.de>:
> > > Xunlong Orange Pi RV patches are now queued up for the next merge
> > > window
> > > to Linux v6.19, so let's introduce support for this board.
> > >=20
> > > Note: The content of EEPROM is not known to be unique on this
> > > board, and
> > > in this RFC there is a placeholder value of "XOPIRV".
> >=20
> > If OrangePi is not providing a unique value, shouldn't we create a
> > separate defconfig (including the vf2 one) and override the output
> > of the eeprom reading function by a configuration value?
> >=20
> > That way we can reuse most code and avoid that users have to update
> > the EEPROM to "XOPIRV".
> >=20
> > Best regards
> >=20
> > Heinrich
> >=20
> > >=20
> > > E Shattow (4):
> > > =C2=A0riscv: dts: starfive: Add Orange Pi RV from upstream Linux for-
> > > next
> > > =C2=A0board: starfive: visionfive2: Add Orange Pi RV selection by
> > > product_id
> > > =C2=A0riscv: dts: Add placeholder files for pending upstream Orange P=
i
> > > RV
> > > =C2=A0configs: starfive: Add Orange Pi RV to visionfive2
> > >=20
> > > arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi | 76
> > > +++++++++++++++++++
> > > board/starfive/visionfive2/spl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +
> > > .../visionfive2/starfive_visionfive2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +
> > > configs/starfive_visionfive2_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
> > > .../src/riscv/starfive/jh7110-orangepi-rv.dts |=C2=A0 0
> > > 5 files changed, 82 insertions(+), 1 deletion(-)
> > > create mode 100644 arch/riscv/dts/jh7110-orangepi-rv-u-boot.dtsi
> > > create mode 100644 dts/upstream/src/riscv/starfive/jh7110-
> > > orangepi-rv.dts
> > >=20
> > >=20
> > > base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
> >=20
>=20
> Sure I'd like more testing data about these boards, I don't have the
> board myself so I don't know the answer to that.
>=20
> What is the content of EEPROM, for reference?

```
root@opirv [ ~ ] # i2cdump 5 0x50
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-5, address 0x50, mode byte
Continue? [Y/n]=20
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 53 46 56 46 02 00 02 00 88 00 00 00 01 00 01 00    SFVF?.?.?...?.?.
10: 58 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    X...............
20: 00 00 00 00 00 00 00 00 20 20 53 74 61 72 46 69    ........  StarFi
30: 76 65 20 54 65 63 68 6e 6f 6c 6f 67 79 20 43 6f    ve Technology Co
40: 2e 2c 20 4c 74 64 2e 00 00 00 56 46 37 31 31 30    ., Ltd....VF7110
50: 42 31 2d 32 32 32 38 2d 44 30 30 34 45 30 30 30    B1-2228-D004E000
60: 2d 30 30 30 30 30 32 37 31 00 6d da 04 00 02 00    -00000271.m??.?.
70: 14 00 00 00 02 00 01 41 c0 74 2b fc f4 0e 6c cf    ?...?.?A?t+???l?
80: 39 00 00 00 00 00 f4 9e ff ff ff ff ff ff ff ff    9.....??........
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
```

From my OPi RV, where the original Linux upstream DT is developed.

>=20
> If it's all the same as VisionFive 2 and boots with dts from
> VisionFive
> 2 (1.3b?) then it might not be needed to do more than add
> documentation
> for the board to reference the VisionFive 2 and explain how to
> properly
> set fdtfile. Inventing a new board identifier when the manufacturer
> has
> not provided one sounds convenient to me, and it is not to the
> exclusion
> of a separate board config just for that special situation. The
> documentation can explain either or both situations, expanding how to
> compile for the board.
>=20
> How does network and eMMC function with the series applied, not
> changing
> the EEPROM content (remains what I was understood is the same as
> VisionFive 2), and manually setting the fdtfile variable?
>=20
> -E

