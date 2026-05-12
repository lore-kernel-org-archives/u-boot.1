Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E258ECD4F26
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52DAB80398;
	Tue, 12 May 2026 10:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=infineon.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=infineon.com header.i=@infineon.com header.b="UjbdaI6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 559C983015; Tue, 12 May 2026 07:18:25 +0200 (CEST)
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA4F803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Takahiro.Kuwano@infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1778563103; x=1810099103;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XyW2QRDij/glskk3mm1urDverf9IbeOmR0J0Eta8La4=;
 b=UjbdaI6i5RPJCA2CwsGAtvYqZhMdRoRXFfyaPxQSgIV3OwsQb0NNHJHP
 A9FJVtFinHNNRD4gw4ZYYNKmlkeBZX11XUpcavKZrxI6VK2HN9Kl/CTQW
 VxyL1338CGnJWXsk9NawAM+HBbEgeTNxhXbTxELMNtgDDENJr20V+rGmj Q=;
X-CSE-ConnectionGUID: ovRyjibbRBqVklsATLdk1w==
X-CSE-MsgGUID: /zAiJtPITe+KyEu/UKoAgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="157208690"
X-IronPort-AV: E=Sophos;i="6.23,230,1770591600"; d="scan'208";a="157208690"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 07:18:22 +0200
Received: from MUCSE813.infineon.com (172.23.29.39) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 07:18:22 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE813.infineon.com
 (172.23.29.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 07:18:22 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.037; Tue, 12 May 2026 07:18:22 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <vjardin@free.fr>
CC: <u-boot@lists.denx.de>, <christoph.reiter@evk.biz>,
 <dlechner@baylibre.com>, <flaviu.nistor@gmail.com>, <jeyu@issi.com>,
 <marek.vasut+renesas@mailbox.org>, <miquel.raynal@bootlin.com>,
 <yangshiji66@outlook.com>, <ssunkkan@gmail.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: RE: [PATCH v1] mtd: spi-nor: Add gd55lb02gf chips
Thread-Topic: [PATCH v1] mtd: spi-nor: Add gd55lb02gf chips
Thread-Index: AQHc4Mt1nus7H+92dk68A3upwZMt9bYIkXXQgACqZ4CAAJU6sA==
Date: Tue, 12 May 2026 05:18:21 +0000
Message-ID: <e884dda604e24a7f9102270c49d15874@infineon.com>
References: <20260510222140.603755-1-vjardin@free.fr>
 <77e1b83ec3d549d0a2fe2816241446c7@infineon.com>
 <agJN-3C_Pril04zA@L30177.local>
In-Reply-To: <agJN-3C_Pril04zA@L30177.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 12 May 2026 10:12:36 +0200
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

> Hi Takahiro,
Hi Vincent,

>=20
> Le 11/05/26 10:28, Takahiro.Kuwano@infineon.com a =E9crit :
>=20
> > 0xc8671c is for GD55LB02GE and there is duplicate entry appears in the =
last
> > part of GigaDevice entries. Besides SPI_NOR_HAS_TB flag is missing in t=
he
> > "gd55lb02g" entry...
>=20
> I deliberately did not copy SPI_NOR_HAS_TB. The GD55LB02GF
> datasheet (Rev1.2) documents an SR layout that the uboot's current
> SPI_NOR_HAS_TB handling cannot drive correctly from my understanding:
>=20
Thanks for pointing out. I just assumed GD55LB02GE flags were correct.

>   - datasheet table 4 (SR1): bits S6..S2 are BP4..BP0
>     Bit S5 is BP3, not a TB bit.

Now I understand this device has 4-bit BPs (BP3..BP0) + TB (BP4).
BP3..BP0 select the size of locked area and BP4 selects the location of
locked area, upper or lower.

>   - datasheet table 5 (SR2): bit S14 is CMP (Complement Protect). Default=
 value CMP =3D 0.
>   - datasheet tables 2 and 3: show that the BP4..BP0 region grows from th=
e bottom of the
>     array when CMP =3D 0, and from the top when CMP =3D 1. The TB-equival=
ent direction
>     selection lives at SR2 bit S14 on this die.

CMP inverts the locked and unlocked area, not equivalent to TB.

>=20
> currently,
>   - include/linux/mtd/spi-nor.h defines SR_TB =3D BIT(5).
>   - drivers/mtd/spi/spi-nor-core.c reads and writes that bit in SR1 when
>     SNOR_F_HAS_SR_TB is set.

In Linux, HAS_4BIT_BP and HAS_SR_TB_BIT6 flags handle that, but not in
u-boot yet.

>   - the same file spi-nor-core.c has the comment "CMP: complement
>     protect - only support CMP=3D0 (range is not complemented)", ie the
>     framework never reads SR2 for CMP.
>=20

In Linux, CMP support will be applied soon.

> If SPI_NOR_HAS_TB is set on the GD55LB02GF entry, the framework will togg=
le
> SR1 bit 5 on every direction change in sf protect which on this die is BP=
3
> not a direction selector.
>=20
> For the same reason, SPI_NOR_HAS_LOCK on this entry covers only a subset =
of
> the chip's protection levels,
> SR_BP0/BP1/BP2 (defined at include/linux/mtd/spi-nor.h) as BITs 2..4
> miss BP3 and BP4.
>=20
> A vendor hook handling the full 5-BP + SR2-CMP layout is out of scope for=
 this patch.
>=20
We need to sync u-boot to Linux. For now, let's drop SPI_NOR_HAS_LOCK flag.

> > >         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
> > > +       {INFO("gd55lb02gf", 0xc8601C, 0, 64 * 1024, 4096,       SECT_=
4K |
> > > +       SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
> >
> > Could you create a new entry just after "gd55lb02ge" with the same flag=
s with
> > it? GD55LB02G'F' should be a successor chip of GD55LB02G'E'.
>=20
> ok, I will move the entry next to gd55lb02ge in v2.
>=20
> Best regards,
>   Vincent

Thanks,
Takahiro

