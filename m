Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA532D0E6DD
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 10:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0718488E91;
	Mon, 21 Oct 2024 12:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="dYqPJwCm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0JW8r+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD17C88EA7; Mon, 21 Oct 2024 12:20:20 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB5C088E61
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 12:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
Date: Mon, 21 Oct 2024 12:20:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729506018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pv0wUqxFCypq5Vk9awYDmPWT7iEqHWhoFO2Lp1umZLE=;
 b=dYqPJwCm7KZlsKqn5yXmLwhU8QysyBk5dYF8wyjCdovkI9mPcrmG0/YeJbOOXNkS0pJulm
 tzNp4LzmJUe12WVtERiX7QZNaq6WHULEl/n0AQsgiQnfrgDt6zoh+bJx0g4NHau8oE6oqa
 LpRo75UIWx3Jo4G1n0j7fWzAcEozpk2inUtIz/dOTEnKbtU7yNDLcE8wOAvTk21FmGe98F
 jAi1iH5cn5mKHtBobjogpXirafap6BKeD3MfWxIDSwoD/sf1XcVXo5Gz+49sNZGlE66UTW
 FBsbkFfrlZoj/NR3C88So142LgK8u3+hclTP2PN4iwzNOUjENXOAGlGD2A4vRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729506018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pv0wUqxFCypq5Vk9awYDmPWT7iEqHWhoFO2Lp1umZLE=;
 b=j0JW8r+aukmO6hg+jt8xL6IR6BYLCBGvAWSMdTHJTi7ev6Kl0O8ryTbLg2xQjtr6653ThY
 9fCCLP3dbstextDQ==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
Message-ID: <20241021122017.34fc9f3c@mitra>
In-Reply-To: <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
 <20241018161908.3f6a13eb@mitra>
 <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
Organization: Linutronix GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

Am Mon, 21 Oct 2024 08:03:35 +0200
schrieb Alexander Dahl <ada@thorsis.com>:

> Hello Benedikt,
>=20
> Am Fri, Oct 18, 2024 at 04:19:08PM +0200 schrieb Benedikt Spranger:
> > On Fri, 18 Oct 2024 15:11:20 +0200
> > Alexander Dahl <ada@thorsis.com> wrote:
> >=20
> > Hello Alexander,
> >=20
> > > Am Fri, Oct 18, 2024 at 10:30:00AM +0200 schrieb Benedikt
> > > Spranger:
> > > > OK, you might say the nand_atmel NAND driver is obsolete, but it
> > > > was the only solution to get booting from NAND running. The new
> > > > DM based NAND driver refused to do anything usefull, so I
> > > > dropped it after spending a couple of days debugging it:
> > >=20
> > > Strange.  I have at least three different boards with SAMA5D27
> > > successfully booting from NAND flash with the new DM based driver
> > > (unfortunately none of them upstreamed, which also won't change
> > > in the foreseeable future, sorry).
> > OK.
> > =20
> > > Do you use at91bootstrap as 2nd level bootloader like me or
> > > something else?
> > I use the U-Boot SPL. There is no UBI support in at91boostrap. There
> > were some attemps, but...
> > No interest at the at91bootstrap side.
>=20
> Yeah, been there.  Wanted at91bootstrap to boot from SPI-NOR which is
> _not_ Quad-SPI, and the feature request was closed with "if you wanna
> do it by yourself, ask our support for help". :-/
>=20
> > > For me it was basically getting the dts for U-Boot correct, but
> > > I got that running with all U-Boot releases since 2023.04 up to
> > > 2024.10.  Could you share some more detail?
> > I face all the trouble in SPL. And since the SPL is the essential
> > part here (UBI support) I gave up at one point. I simply couldn't
> > any usefull read data from the NAND flash, but all 0.
>=20
> You can not store bootstrap or SPL in UBI, it must sit in first sector
> of raw NAND, I suppose that's how you load SPL?
Sorry for not beeing that clear.
The SPL sits in the first Page in NAND flash. It does it's magic and
then load the U-Boot payload from an UBI volume (Or directly load a
kernel). Then it "starts" the payload.

> Did you try reading/writing raw NAND from there?
I try to read from SPL. That's all what ubispl wants. No need for write
support here.

> I'm not familiar with SPL, does it consider dts?
It consider dts.

> I could share my dts parts if that helps you.
That would be great. I definitly give it a try.
So here is a quick extract (EBI is also used otherwise) of what I did.
Hopefully I did not forget anything...

--- a/arch/arm/dts/at91-sama5d27_ABC.dts
+++ b/arch/arm/dts/at91-sama5d27_ABC.dts
@@ -63,7 +63,62 @@
                                        bias-disable;
                                        bootph-all;
                                };
+
+                               pinctrl_nand0_default: nand0_default {
+                                       pinmux =3D
+                                       <PIN_PA0__D0>,
+                                        <PIN_PA1__D1>,
+                                        <PIN_PA2__D2>,
+                                        <PIN_PA3__D3>,
+                                        <PIN_PA4__D4>,
+                                        <PIN_PA5__D5>,
+                                        <PIN_PA6__D6>,
+                                        <PIN_PA7__D7>,
+                                       <PIN_PA8__NWE_NANDWE>,
+                                        <PIN_PA9__NCS3>,
+                                        <PIN_PA10__A21_NANDALE>,
+                                        <PIN_PA11__A22_NANDCLE>,
+                                        <PIN_PA12__NRD_NANDOE>,
+                                        <PIN_PA21__NANDRDY>;
+                                       bias-disable;
+                               };
                        };
                };
        };
 };
+
+&ebi {
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_nand0_default>;
+       status =3D "okay";
+
+       nand_controller: nand-controller {
+               status =3D "okay";
+
+               nand@3 {
+                       reg =3D <0x3 0x0 0x800000>;
+                       //atmel,rb =3D <0>;
+                       nand-bus-width =3D <8>;
+                       nand-ecc-mode =3D "hw";
+                       nand-ecc-strength =3D <4>;
+                       nand-ecc-step-size =3D <512>;
+                       nand-on-flash-bbt;
+
+                       partitions {
+                               compatible =3D "fixed-partitions";
+                               #address-cells =3D <1>;
+                               #size-cells =3D <1>;
+
+                               spl@0 {
+                                       label =3D "spl";
+                                       reg =3D <0x0 0x40000>;
+                               };
+
+                               ubi@40000 {
+                                       label =3D "UBI";
+                                       reg =3D <0x40000 0x0>;
+                               };
+                       };
+                };
+        };
+};
=20
> (What I do here: SoC loads at91bootstrap from raw NAND at offset 0,
> at91bootstrap loads U-Boot from raw NAND at some offset like 0x20000,
> U-Boot (proper) loads everything else from UBI.)
=46rom my experience that can cause significant headache starting after
5-6 years in use. That's what I try to avoid :)

Regards
    Benedikt Spranger
