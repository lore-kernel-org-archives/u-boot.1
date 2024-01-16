Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F76DC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 22:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3182B8772E;
	Tue, 16 Jan 2024 23:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=variscite.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=variscite.com header.i=@variscite.com header.b="h88v+icp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F401887977; Tue, 16 Jan 2024 21:01:16 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1b::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB9E9878B3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 21:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=variscite.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ken.s@variscite.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6+NDZ6eNpPL756UigPJuXnUrRr5alQALJCZdpqvFwvdTGHLbJkKzKFxMvMEYF628ioEJbZmeU4snqRdW5QN/eO8myjeJinIweHwhkWgJBHe1KkAtkGC31EWhhKmWjEvm9YHIbMH/EPkchdwxNyWCV2NB8byaVPEW9mgySIx0+QHIR0DA82h0FuDumt/W8bZvLCu8cHYEGT+xRRySsLlABUqTJ8RifVDZPosB2oeQPZVCg1mIBkaiAzK4AmiUpCPRKHEvsMNSTRajPuFyx8hbYtJAP2vN8rzSMJWcLIWaBnsxPLVUKypjVdwixF+IQXBxj4zlmV+5wDkV6+6S4X4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmxH5Zh1Q7Cwv/zFtT/0D6cdOXOb6OFj1riN9R7p+HM=;
 b=A+drAk1sUOJNtG4nZqXfW7sl/2QSSoy80Nq+dZEt6HomK/B4wXHmR5yYSnSU3ZyEFB5hmy13APa/Ng2Mtg49pjxEwC4ViWYji5EJmZe8gun5rjSsaNfqUCS5WIXyJHRMws2WnV/axbxlw5WkxkcHn6Gf8gO5EzWgCIUd0x0qe9NQQSaFcZVwRUnOhsdnOoUNFwd2wA6nZpWE/FIynLZaWBD5H1HHvIiWwzP2XD6QQ0gMpKUNb0cOVHJvz3UbHrjXEsIGZ9V+ecRwhrvTVxQXmOZqQojXopwdKtM/foCzbeb7h82L1HRMkUN5X6myy4TEt4L2a5mI/6l+jADH1HLPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmxH5Zh1Q7Cwv/zFtT/0D6cdOXOb6OFj1riN9R7p+HM=;
 b=h88v+icpkIR6MGd6TsOcVFVM9QKR2hoFG2Qz+yf8TWSOEYccackvMLQthjrK89xIXFoDRmhKfzJCdykpqtqhN+rO2m+OYRnk7zqkEQf/gFPh8j6Da4/jpUla+qMcagRwr6TsAw/RQeFq3sGj1Ah3g3Dodfd4oKkl3mUSbHpFVBfRuuP4YdqK0GwjPNBL0YtJMTyu6fk5hyG/SknE+HNIxjjqoqyss4zOX78RMX5Av0uw40sJNdM4q4azz3D6yX2PPitv7I6G5IYEVZ4sjP5QFtMlsgKb2yTHkVDwfOC5EgD3bvpJTe2gUp2DiTW5YgrCQkG8AeABnvctEwPErjCICA==
Received: from AS8PR08MB7991.eurprd08.prod.outlook.com (2603:10a6:20b:570::15)
 by VI0PR08MB10392.eurprd08.prod.outlook.com (2603:10a6:800:210::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 20:01:12 +0000
Received: from AS8PR08MB7991.eurprd08.prod.outlook.com
 ([fe80::428a:46cc:eefe:822f]) by AS8PR08MB7991.eurprd08.prod.outlook.com
 ([fe80::428a:46cc:eefe:822f%4]) with mapi id 15.20.7202.020; Tue, 16 Jan 2024
 20:01:11 +0000
From: Ken Sloat <ken.s@variscite.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "mripard@kernel.org"
 <mripard@kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "s-anna@ti.com" <s-anna@ti.com>,
 "rogerq@kernel.org" <rogerq@kernel.org>, "nm@ti.co" <nm@ti.co>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>
CC: Nate Drude <Nate.D@variscite.com>, Eran Matityahu <eran.m@variscite.com>
Subject: [PATCH v1 1/1] net: ti: am65-cpsw-nuss: Remove incorrect RGMII_ID bit
 functionality
Thread-Topic: [PATCH v1 1/1] net: ti: am65-cpsw-nuss: Remove incorrect
 RGMII_ID bit functionality
Thread-Index: AQHaSLRYWOx1uVCStESD5JmAQRSZQA==
Date: Tue, 16 Jan 2024 20:01:11 +0000
Message-ID: <AS8PR08MB7991CFB38C65A76484AD971CEC732@AS8PR08MB7991.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR08MB7991:EE_|VI0PR08MB10392:EE_
x-ms-office365-filtering-correlation-id: 15caf229-5fad-404d-0753-08dc16cde353
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vp1EG0Gwa3FqQcF0KdPNaEE4vZK1YiL3Zv8rOQ+9tI6wPm6ZgseJLatxghNxfJKUJVvC9SD0e49D1aUkZDBItFWRIMnUzspfBq8iAfa1k7Adxhry51Pk9ztASZOcVWiREhKhDMGztI+1Ggwt4cSsnfn6hNC32pnNpsYE+fUJUwW9gsCeZjnTGM9a0+Tzxv4uqDhH3zWX1uEb+YByeocykhXfO28TJDWkdnUqeuSiMfM69SdPL050XGTutYpoGiyomCJi7hRiTbSHmoKYAuxRoBBxW9/HPeLzlHVJh+OxDjw6H1SBSOdusdHIz03cTe9DOpEHyHYOF8HJ2O2RO1rdRgHYBCSRTnp2oJ+FfHkjlR0QovWFdZA+E80+H68ABES/dx5ZOTkU8uII6xBOud4Jurn9XWtIizh+WNjs0kK5HtPBQrziYSjANvVJpm04vqIfzZlP2K0QDQMWGBPmjgn8DvLJuEpyQUBUbWCXJ3Q13gg1TLll9SbWqDWnv/SC9V2crD/oL+ML80cGRwQdLVqEWTwd+NXCOsJkvtSBBk1rIH6MhXh5JPMZcVyYaykc+S3xpxL7nVZc58nXxI7aUh12LUqIBhVPMRU2s1ur8gePI/tLkE4soGzcrlZTo/jfHCf2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7991.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39840400004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(478600001)(76116006)(6506007)(7696005)(71200400001)(110136005)(66946007)(66446008)(316002)(8676002)(8936002)(9686003)(54906003)(91956017)(66476007)(26005)(83380400001)(66556008)(64756008)(2906002)(4326008)(52536014)(5660300002)(41300700001)(33656002)(7416002)(966005)(107886003)(38070700009)(38100700002)(122000001)(921011)(86362001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hakIFexiDBV90WMfls+7puGRiTTF3N+P54z+C6rDcGya/E8ttiO+4HFuKm?=
 =?iso-8859-1?Q?gBIc/FJr65NxMbQWKyDmDNgFGVEYyvJXHFv+BusgXvfQBJsaXh3lqwh3Ic?=
 =?iso-8859-1?Q?yM+6pBtpgw2KNjygor5u3/iZHwpN+3cwC83awCWLatoebMwU1Mdsgueyr+?=
 =?iso-8859-1?Q?z9BEArHMHgluzvDv5qIdOFshHA0WHeA5kEMPUKvNGa1JXxl+aJA0MhX3fS?=
 =?iso-8859-1?Q?8IYhMUN9RsPoagyyNiXKwMxHqNRlAu6dIa9NlHvlvjJ5ijyqE2R4mxFLWh?=
 =?iso-8859-1?Q?wmSgkujDEVDxAczOwsL+QcQvSZjWvAPWH1D314q5f2Rlz3OwTIWkaSRcFV?=
 =?iso-8859-1?Q?EaW5MLLhZEDuztEYgpq/H/LYEAnd9iQDXNqHPbvZqx4usiUcocm/gkm0SG?=
 =?iso-8859-1?Q?G/OE3fENMUNEpnYbQY27NFtqoZmhOycL/7yF2wjb2HCdBFOlPhTQL3Ru88?=
 =?iso-8859-1?Q?M7/CDxyaPuFuw7p/BUG6CwnQf0+nLcUiAyTwkNWy1xD1GHRPxLIwA2nCR6?=
 =?iso-8859-1?Q?3uyBFHFIhMkF6ip482ggWjynZpL+YzplufU2hG28JW2JKNgzlNv3oL8rp0?=
 =?iso-8859-1?Q?9eNhVkmQGDE21h4hGl5u1Wp75Z7v70n5NCgf9BkRLfrD5ynMACTJ4ZUgi6?=
 =?iso-8859-1?Q?VjX/cA5H8jE1LWwDoheG6KTmgtlPpk6SfCfHHvmQctxeMJ+6Jo4elaMY1l?=
 =?iso-8859-1?Q?kQ7wQxhgkEnLw5gVqJUdyjn21GkvQswQSLewmWLQ1spIhp46hOA7mrb8U/?=
 =?iso-8859-1?Q?agmBveA0IEjdme5hrROYgAE6BKXycmVpRdh4Bo/ztnQmcyTckOaU9kTBW+?=
 =?iso-8859-1?Q?zYzPk6jjlPuhuApjW+KA81ENu8MPZFK4cy11rSupUBeUTcJCkwg/jUMVC6?=
 =?iso-8859-1?Q?fewtU2JrErWrBRupxYkCCc6VPfREE4ywcJIfcapUE49CcdrTVLwMp3d3Tn?=
 =?iso-8859-1?Q?qoqXv+rDr6zxn4/r7scDTsBeUwFsVdR3OUaeVKzbGWHNsVI0CnfERdhz+P?=
 =?iso-8859-1?Q?6230F0tq2BXp23S0S6QlWnsSmHRE0aFLgPEld5KfFuNwPKTJwkns516cec?=
 =?iso-8859-1?Q?w537eURnpjvyBBS2tTHJHtmngDtVmjHnJOM8YCiVFpbxSuH4PpOCjJCWNu?=
 =?iso-8859-1?Q?/ElD1fKscL3XfGfJCiKhA/bRW2FBGZegQx/cCJDqv+fnpdwp/+VwOJnKuO?=
 =?iso-8859-1?Q?tibboeo6JJ28buwzrpbppzAryx6Se6Yy4K3dfFvj0LtkCrGGm3HmfSYsMq?=
 =?iso-8859-1?Q?eeX/ED8tNF6zQl5MshXvIFnjM7hXGg1DPV8QVorAErXCTWP6NIST8ClHyO?=
 =?iso-8859-1?Q?F8lDBZRtKhnj4tUa5Pdi5Zlshayag0sofo8pAWgf4yxHoN8Zi0opk6mZUs?=
 =?iso-8859-1?Q?EmF8+ARz6wDJws7KeShuPdKRnFhFDXocKRyNqqC70zzYKnlmhsJtxGmJLz?=
 =?iso-8859-1?Q?iPyXHdBy9y9rHGV4Z7zvyySjODG9Z/xRgGPNZShV4tN+cmlPBInsIKXHXh?=
 =?iso-8859-1?Q?I6aq+ZPMgQqs/E50kbktl+NqcKOjQVJCT+ghsdzvDrZDQHlJolt3ganfCh?=
 =?iso-8859-1?Q?kQamXjeY8YTZ8XWXIlB4jqLf3wbnMmaWmzlmUK6DS7lLuCdoI0hWJ2IujN?=
 =?iso-8859-1?Q?zTfZ4bo2cRsqs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7991.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15caf229-5fad-404d-0753-08dc16cde353
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 20:01:11.7566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZetUR+Tx4pgx7/Mig2aHEyWRqZEQXz7GwN+KYVjWWP1KGInV6AOGFPHBGIY6qYhx5DX3xJy2z+ZDuFmKvqkpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10392
X-Mailman-Approved-At: Tue, 16 Jan 2024 23:30:31 +0100
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

The CPSW implementations on the AM6x platforms do not support the=0A=
selectable RGMII TX clk delay functionality via the RGMII_ID_MODE bit as=0A=
the earlier platforms did. According to various TI datasheets, reference=0A=
manuals, hardware design guides and TI forum posts from TI, this bit is=0A=
"not timed, tested, or characterized. RGMII_ID is enabled by default and=0A=
the register bit reserved."=0A=
=0A=
The driver implementation today however, will incorrectly set this bit=0A=
whenever the interface mode is in RGMII_ID or RGMII_TXID.=0A=
=0A=
To fix this, remove any statement setting this bit, and moreover, mask=0A=
bits 31:4 as these are all reserved.=0A=
=0A=
See:=0A=
https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1=
211306/am625-enet1_ctrl_rgmii_id-_mode=0A=
https://www.ti.com/lit/pdf/spruiv7 (Rev. B Figure 14-1717)=0A=
https://www.ti.com/lit/gpn/am625 (Rev. B Figure 7-31 Note A)=0A=
https://www.ti.com/lit/an/sprad05b/sprad05b.pdf (Rev. B Section 7.4)=0A=
=0A=
Signed-off-by: Ken Sloat <ken.s@variscite.com>=0A=
---=0A=
 drivers/net/ti/am65-cpsw-nuss.c | 10 +++-------=0A=
 1 file changed, 3 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nus=
s.c=0A=
index 18a33c4c0e..51c432408f 100644=0A=
--- a/drivers/net/ti/am65-cpsw-nuss.c=0A=
+++ b/drivers/net/ti/am65-cpsw-nuss.c=0A=
@@ -256,7 +256,6 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv =
*priv,=0A=
 {=0A=
 	struct udevice *dev =3D priv->dev;=0A=
 	u32 offset, reg, phandle;=0A=
-	bool rgmii_id =3D false;=0A=
 	fdt_addr_t gmii_sel;=0A=
 	u32 mode =3D 0;=0A=
 	ofnode node;=0A=
@@ -296,7 +295,6 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv =
*priv,=0A=
 	case PHY_INTERFACE_MODE_RGMII_ID:=0A=
 	case PHY_INTERFACE_MODE_RGMII_TXID:=0A=
 		mode =3D AM65_GMII_SEL_MODE_RGMII;=0A=
-		rgmii_id =3D true;=0A=
 		break;=0A=
 =0A=
 	case PHY_INTERFACE_MODE_SGMII:=0A=
@@ -313,15 +311,13 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_pri=
v *priv,=0A=
 		break;=0A=
 	};=0A=
 =0A=
-	if (rgmii_id)=0A=
-		mode |=3D AM65_GMII_SEL_RGMII_IDMODE;=0A=
-=0A=
-	reg =3D mode;=0A=
+	/* bits 31:4 are reserved */=0A=
+	reg =3D (GENMASK(31, 4) & reg) | mode;=0A=
 	dev_dbg(dev, "gmii_sel PHY mode: %u, new gmii_sel: %08x\n",=0A=
 		phy_mode, reg);=0A=
 	writel(reg, gmii_sel);=0A=
 =0A=
-	reg =3D readl(gmii_sel);=0A=
+	reg =3D GENMASK(3, 0) & readl(gmii_sel);=0A=
 	if (reg !=3D mode) {=0A=
 		dev_err(dev,=0A=
 			"gmii_sel PHY mode NOT SET!: requested: %08x, gmii_sel: %08x\n",=0A=
-- =0A=
2.34.1=0A=
=0A=
