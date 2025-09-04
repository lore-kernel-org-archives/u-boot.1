Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CADFCA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 08:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED2F83734;
	Thu,  4 Sep 2025 10:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 155728368F; Thu,  4 Sep 2025 04:39:54 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7959E833F9
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 04:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTYM0NsGkj031YB6KW5Rq75zNjcm37WBVs5MoYfzH2boQ+Gvdjfy2V4SuNS2pXzMF/FohTanGIbV/N2EtpRtzLYV/a2D3ypbrfBjmDugdyWW5GJZC8AfWP/u7Oq2eWjBvAodkelq0l4j1MzdXiptFInsT388tYfQpmpX8mV3Xcx+VotRpw1XpB0VRmGeP1b89aIgeBIA8C0qb7+I36jqwL3cPQYK7rJnqfRZNjWL6XPWnf1r9Q8x+odpEGbcvdGaMwsxdkEJrNr+iu/urU3BxYhruRPQ63rq1GRwVtfk9AXTni06si5rgMxfnbl1xIox5B6Ym4G5jZnMk0VLeDVlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3MkCQxhq89oYDiBM4Rk5dqoXuK9OZaZxcXYCcpAffU=;
 b=aUH+9yXznbOxxR8obRjzFzTmwDQ4ELgWGlZHr8+GxofEis1Pt6IoYwG2f538Sw6rDwDOVqDRZu5zgor2Ey7sc/44xnadEI4usbOqEvzLuHEWcJne6hzMIQamUmaQRCRXHc9qXirWfnY0t0reDvQmJ1MP9oSqvxHuUZ9G9hJPE5BkqaFA81b71d+d5T6UbJ8And1CFrk2YcKEOOc+yWzqqYJPsEyCpD8VGnY18HnrsD+Eum/M3ij+MXuAihsEScTy4I7ej4bfv7+OE6pc/8K/avHO0dWITCLgLbnpMF0JV88xbh8VDo2Gafk306ZPEf5LWMQ5RhfxuTWV/hoxtVFMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1179.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 02:39:46 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 02:39:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Sumit Garg <sumit.garg@kernel.org>, E Shattow <e@freeshell.de>
CC: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [RFC 02/10] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Thread-Topic: [RFC 02/10] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Thread-Index: AQHcGKuSErPPD5xdX0KCjfd0f+b6VLSAV92AgAD8nYCAAP6vIA==
Date: Thu, 4 Sep 2025 02:39:45 +0000
Message-ID: <ZQ2PR01MB13079882F31D06E973973C1AE6002@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-3-hal.feng@starfivetech.com>
 <3b75e20f-261e-4a23-b2b6-d4f4596b5fb3@freeshell.de>
 <aLghZaUyZZpUHOzP@sumit-X1>
In-Reply-To: <aLghZaUyZZpUHOzP@sumit-X1>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1179:EE_
x-ms-office365-filtering-correlation-id: 3e24d523-799d-4a97-1a9e-08ddeb5c4f68
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: xDSKg48feZ7TBkq7k9ds5sjBnDi+mzoR1+jOksc5cis0CWlOUEGSPSW8IM+MUbWPy29oT4V615x3mPeg1Rf7N4hQFYVDG3rppXGKk59jtV7J16rL1B51AdIRQrEyVE2QCYHTB0cK8kcDtfg65YbGs41RcBJczVwOIDavUObFWSBNRnSqps897esBTDlZxmz0sL3KFAp7KeX7DyT2FXJJEIDjAXbF3lGELfK/JUubLGkAbEJAiP8BTDH1HC/3Q+BpBnGUsFLiRnfwUJpM4MEG9bOaPTwqEmJnbE0+EVp6brGpxwmNIiIWx5mVahdN95Z4U6fj9DlXDxqhQw1byhRfAFA+Lb+JPD7nM65MACCZs/xCeTLUbznxATHBdML7rk59P+FWxrEvqCqbhcveYx24OMUu7iDYiB2c6UXRtsKu0drLiQ0i0+/Tmmb46/69QUf2k30eFB4Zsh3JZwnCEnvV7ZILUGcespICJKG1yUMq87USMJ7PRiMLiObEdKwZlZgbqz8VVfrbWTvM3sJfEttBwq5Tjki1424N60lWFBZ76TMRTgu++iVGMTd0RTPTrQYCvBYfVqt0xePDA0Qmu40E/vyttST75frzK/UbSwJkJgg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IrX+HnN2G55/CegYVkVRRYip/tKrsaU6tskIiRC+ihwFMKmQKmb59oOMvfnx?=
 =?us-ascii?Q?7T/+fPVAas+JpQv+Re6TizRV4n3CD7GTlGPKt2Bnb7K6itju7dE6/oac48hP?=
 =?us-ascii?Q?HxAH4AoL+HnWnjWrbHOPl90QHSh5vyl4hW7HAo5g6t+frWyoiZqtSOh5p76u?=
 =?us-ascii?Q?pQe8ltdpxz4wTOv/aI6kGLIGK0qd8xiTVwZqBjPKhaTKVw9z5QOgk7qEU7KJ?=
 =?us-ascii?Q?bVLCqkAP9LHGZRQ6W3gzwmivoQYzjE5RAzaspQow5OT0pXbSsmgt8pqtsgCQ?=
 =?us-ascii?Q?7HnpO/+PuY4CA8Iyvql0OspUM7LhGSdf646h5XGsiCxQlLcm/5N3JILGAL+w?=
 =?us-ascii?Q?Ug84iMQhh+v6eFhYDdc4DUy0kZ81KIiG7nn0PEyz/0XGAI7roFxphVJcMvy+?=
 =?us-ascii?Q?EWDg3Ww6vA5llTYlUiCTSdLGU21vaXAd0i17FrT/V4J17gKH0D8DXLsnTwO7?=
 =?us-ascii?Q?GmQTz+oVqDXmb801wWa/7gX5hnx/Jzr9n6SpMP2lz4WQFKmFxYHzeW5VEl0t?=
 =?us-ascii?Q?pNhgdgVtDRapjLkeAHZxKfm6DKkkJJ5SCwf3qXynGAPbp5rsnlbcflWqxn5d?=
 =?us-ascii?Q?cjJ4d5jgTdifqXEjGRmj4kyATjy0J20V4ytjW3I15fwCpBIVQJzyvO1qDjNC?=
 =?us-ascii?Q?r+ks4LSH9by+lGelmpj7RV9SADJ4jjzywmvkqWBHNubMPop2dR8JcUAjBJfC?=
 =?us-ascii?Q?f7KatfUg8UW4o2gywBTK6WDEE9nZhypLJxsd22Tlztng9uOoVaYLFSVEFP1t?=
 =?us-ascii?Q?VWSh9PhQAYCCMOGu20tNAkTtQ6dPgcSmU8sDYDbrcrMtswGbPyr4cC27HOrI?=
 =?us-ascii?Q?+sk/JLm2hWT/hUxjKiAFaslpSu4eTgFKWPkzmvhLB3GiBIxkS4UywGtfuTB2?=
 =?us-ascii?Q?DFxSXw68uguB6Kue6b4ey7WepnhzS9GvFpkpeJXCiKM8oEpSkGaVmt+I5ypn?=
 =?us-ascii?Q?2l0Hl9PaKV9Xd/xqVwjyAzHmzh+SCWH/qQuyaJmXYLU+SvFZaKjuGDsVlxm1?=
 =?us-ascii?Q?7hnP+Vlp+CQyn3zUrNc59uZWnAK16shy/tEo1qi+qb2pPch5MlW8LJJ5A/iP?=
 =?us-ascii?Q?/au/LI2eavJZMJ8QIuSYAQCJBhwiTo9nJ+7J3h06YRsIu84P6cOmWhU6e02D?=
 =?us-ascii?Q?0Mbhe3lain4Hs7zh6rwO4KEsDyzsLFxvfBopT3ZbVr0Iq0HtWgcAi0Ks3Zek?=
 =?us-ascii?Q?3aMg9qnVilLaos0piRedYL8Occi004HC5nRo1H2kPVbBHdNq1bhH81ER1fyV?=
 =?us-ascii?Q?HmHln+wvbSqxXilezAUACpY2mu/ihaKZW1GreVqa42bArgzYA6PihCvqPwCz?=
 =?us-ascii?Q?t1rOzHhqgyJq3PNqL+vWiK+ROGlnndZeaapDxdnFEZvSST64MzGTZ5xe8eLV?=
 =?us-ascii?Q?sEcbMxxQZEkQrmbOiBb1UfLav8/uU8SyNYKoN4hCd1/8yZKUoTWSVS2TkHaa?=
 =?us-ascii?Q?KHmg9azpwlKJEeGYW/QD3ribRTHUOWj4zDW7TcBeqr/Gdm9SfQT5xz7R/1N4?=
 =?us-ascii?Q?t1VACtn/UAxffPbgWFmAFZmct5HgzwM2fyclC0UnRBXh9GK815U3sywgmlDZ?=
 =?us-ascii?Q?j1KWKbHv2Aj13cxv2A0QtfVlqFeb/03TfIc5E2Jn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e24d523-799d-4a97-1a9e-08ddeb5c4f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 02:39:45.8076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3e3WLe7MOz5H/9yFfba5kPznnfp/DZc1W1O/oVzPm38FMVovFBqEm//tFf6A1fTXEvZFXI85oW78fHVOTtCsGEKm0ftWz4TV+kJgSQCqRzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1179
X-Mailman-Approved-At: Thu, 04 Sep 2025 10:21:09 +0200
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

> On 03.09.25 19:07, Sumit Garg wrote:
> On Tue, Sep 02, 2025 at 01:03:09PM -0700, E Shattow wrote:
> > Hi Hal,
> >
> > On 8/28/25 23:09, Hal Feng wrote:
> > > VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.
> > >
> > > Board features:
> > > - JH7110S SoC
> > > - 2/4/8 GiB LPDDR4 DRAM
> > > - AXP15060 PMIC
> > > - 40 pin GPIO header
> > > - 1x USB 3.0 host port
> > > - 3x USB 2.0 host port
> > > - 1x M.2 M-Key (size: 2242)
> > > - 1x MicroSD slot (optional non-removable eMMC)
> > > - 1x QSPI Flash
> > > - 1x I2C EEPROM
> > > - 1x 1Gbps Ethernet port
> > > - SDIO-based Wi-Fi & UART-based Bluetooth
> > > - 1x HDMI port
> > > - 1x 2-lane DSI
> > > - 1x 2-lane CSI
> > >
> >
> > Prefer to see subject line and URL of recent upstream discussion or
> > git web commit for the new or modified dts changes from upstream of
> > devicetree-rebasing in this commit and not just in the cover letter.
> >
> > + From upstream LKML discussion "[RFC 3/3] riscv: dts: starfive: Add
> > VisionFive 2 Lite board device tree" [1].
> > + 1:
> > https://lore.kernel.org/all/20250821100930.71404-4-hal.feng@starfivete
> > ch.com/
> >
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---
> > >  .../jh7110s-starfive-visionfive-2-lite.dts    | 152 ++++++++++++++++=
++
> > >  1 file changed, 152 insertions(+)
> > >  create mode 100644
> > > dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.d
> > > ts
> > >
> > > diff --git
> > > a/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite
> > > .dts
> > > b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite
> > > .dts
> > > new file mode 100644
> > > index 00000000000..a0cb9912eb8
> > > --- /dev/null
> > > +++ b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-
> > > +++ lite.dts
> >
> > No, do not directly add or modify upstream dts in dts/upstream/src
> > subtree. We are not permitted in U-Boot to merge out-of-band
> > devicetree changes to the devicetree-rebasing subtree as this creates
> > more work for Tom, if I understand correctly?
> >
> > Instead add or modify this dts as
> > arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi filename.
>=20
> That's right. dts/upstream subtree isn't allowed to be directly patched b=
ut it is
> rather synced regularly with devicetree-rebasing. So please follow
> documentation documentation here [1].
>=20
> [1] https://docs.u-
> boot.org/en/latest/develop/devicetree/control.html#resyncing-with-
> devicetree-rebasing

Please ignore patch 1 and patch 2 and don't merge them into u-boot.
I  had noted it in the cover-letter. To be clearer, I will point it out in =
the
commit messages next time.

The reason to add these two patches is that it will fail to compile without
these two patches and be more convenient for the developers to test the
series.

Best regards,
Hal
