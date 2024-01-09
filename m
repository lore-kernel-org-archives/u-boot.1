Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C229C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 08:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8208876FF;
	Tue,  9 Jan 2024 09:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="R6+ALqeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC9008783F; Tue,  9 Jan 2024 09:52:46 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0714.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::714])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A311B8771E
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 09:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=kontron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thomas.Schaefer@kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gxo5zYWiODjemtzBNcsKk1oJ28KxeFXFd2UUF9RYZfSeswZNCRaLqi9n8/w0XOKk6Lm03LXb0SDmq7X5YmccCMILUSkaPlugn0JsdEL/ip8Gvyvx4ZhwDENA9DIBaqrJ+1uPnfgNvmIQx9+/Ihg3IG4c11ebodl0oR8SHQPiaqmdiDRzDHRgV3vRVOCgZeAqHckB5Wr4Iht+LQtzP7alvHW+h8TrClX7TdJZOmZq+TF9pV/3VuDvM9x5nGITahsoaw42w2rkVwKonB3PQl+mqryO+4Wb3juvYmo7v4apszOl0QHPf0cly3yKYbHmXJsCayyYuWDdO02bdakefDOnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ5fVwoWhzLKIfSF0NwVUpj7sp46F0ZO1VVNywe+Iio=;
 b=mRu6POSUP/p7PNGD4Rt3iZtIgzBD5plMA/TMFgJuoolIjXimVp7kCPVLOi8/saAnisdm5Rb2k3kQttTcfawozi5e7GvEgjICbj7Ih5nWzYMLEVQqTSLbGt7FMEPl/S07DiP6+Sj979U5pur+EWDcXrAbtFS7eIEsfkY2ubIEojYnNJRTCXVtm4445XaHfSHybVRi9JkRmH8byT46qSZUJ/scR7nFZiswfiGBPtx1nkygm6eGUYCvsecE+D+eeu7JCxNbBUEbbLHnHxrIblx4T9zZm4/huWt2luliAOEqFQtyA3pTjIBt7temRUx90dRDp5/GsuuqYYFvTK40rmhoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ5fVwoWhzLKIfSF0NwVUpj7sp46F0ZO1VVNywe+Iio=;
 b=R6+ALqeBQbWO1UjzLxCCDQBE7LCujGt9jm2SwoNOHnrHC1j1sXVQW8jA4UaIKFRdsyG/n6Jr5xMCfYhbp7QeOTUGLRdaRLpDtxAIwHK+nhzISnZOnzlwGjdeRopEzA+0ozA0+CFbEX1Jj2SgQKGdf8yH9LaMLhICEx7xQbXqqF8=
Received: from GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::10)
 by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 08:52:43 +0000
Received: from GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5fc:38dc:29f1:e6c0]) by GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5fc:38dc:29f1:e6c0%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 08:52:42 +0000
From: Thomas Schaefer <Thomas.Schaefer@kontron.com>
To: "'u-boot@lists.denx.de'" <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>
Subject: FIELD_RETURN on i.MX8MNANOLPD4 EVK
Thread-Topic: FIELD_RETURN on i.MX8MNANOLPD4 EVK
Thread-Index: AdpC1mPYqerN5KQnRr+yK/uUXVwhRw==
Date: Tue, 9 Jan 2024 08:52:42 +0000
Message-ID: <GV2PR10MB6453B5A6CA444FD371798D65F76A2@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR10MB6453:EE_|AS4PR10MB6181:EE_
x-ms-office365-filtering-correlation-id: 055fffb9-1c4e-41df-06ea-08dc10f0579f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: geDipJ1X9m37ktafZVrPLQJAvCPP8aqBesEB/47GCTp3cLnE1wcUAy0pTU6/zNJ9cXMOFMRgkHCAnECruPdnMR6EltU9iW1cD1l9SkbRZ87W94CryiG1+4ShTHpBVI+RD+jk3hFczFQ0mHop4KJTeaxHKTKxki8BK54air9aqXo+X/JcyXWDS7FXEoYq3LJsywwWM/p7SZOoZ7QzjNk9iUjLd6zmB5+dfsleQrGIiskneJ/ZBBOgdyXXRYYS7drHxvDeErHKR7PHrlNVHVLPOmV00orFTEuGAZoegbOL/DrCcS0fUdnj+ph0D4WDr/0R0oeOZKuc5z54g+bwcAXkzkUcqH8VZ0YBrWWEfYQl537uqeE9+1x/oEQyYzNkTwI9jPYhbyQg9lNgbeR1Kvnh3R5WewhcNGWBnl/Wie7J1Vq+XOj2Z6v3NyOWgMEpjBMx1Dnm9w1Q49+Rgk0RIw/PK4T1/3KSmGDCTmyOlRzj9/ajPqYX5vUtVx2EnKJk7b4LH2+JX+JfGpe9AtlXE6uSm3uT8+cBFv5OhkfOV0HgiG/Tg9rHPbDkYsGnOcTrEaSZzZNxVlY7Fx3/5c07f/G0CXbUY8wkIdqx6Ju7klgEJ/YpOfJ9ujNcUl/qi4KyXbie
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(122000001)(4744005)(5660300002)(38100700002)(4326008)(2906002)(33656002)(15974865002)(41300700001)(86362001)(83380400001)(66574015)(26005)(8936002)(7696005)(6506007)(478600001)(9686003)(8676002)(71200400001)(52536014)(66946007)(316002)(66476007)(64756008)(66446008)(66556008)(6916009)(76116006)(38070700009)(55016003)(491001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?x78KHlB55sTLGPDLLA8fYy8dU+wmSlXhTMLrTlXHQ3ICXZSL3WbS0KIh3S?=
 =?iso-8859-1?Q?9k/j2W4br0ADtFYu95zT5JBX4Bu51NPdoSKiLhBy9yZtt+gZxBdYl1LznZ?=
 =?iso-8859-1?Q?MNPrbrGPNHyDCheTdmu4klP1YrVD4fpvUk9d+hTlXNUpqkffwIQmyLB3oZ?=
 =?iso-8859-1?Q?kf0PGarCqflTQf9h6BVr6Odk1dv33PN5nClv3NwctS5zbwOfTsfLivoqSP?=
 =?iso-8859-1?Q?AlikyTG/gJjYOM4dxQ+by7ECeuvamBSkphECdP43AkRiZjuEN71QL6b7sX?=
 =?iso-8859-1?Q?ImfDayjgKwqXIpPwPkkx4gBaePrqjBw+arZFMybEC2rmh08ZsLEdbem0gF?=
 =?iso-8859-1?Q?Zlj9pCLgSc0ezkUDMAgE57bQq28q5NB6dmZMLyAGmXtF6qro3YH3jYPoXs?=
 =?iso-8859-1?Q?Hiqo1fMc+L0SpLxu1216iPfpCeHSGhY+ucmj8V/R/9B2rPbOU/bAdhlRAV?=
 =?iso-8859-1?Q?keQzwyX5HouM8w6GD1rU/j2xGTkXpMt6v47UiuYHzDP32f2mSnArw5IN+I?=
 =?iso-8859-1?Q?2ycydO/SBy/1Wct0kVEng4NLDXP8/dKwoVVpEZdBA06sKqTfOM7onNV5KV?=
 =?iso-8859-1?Q?nbcY6w9Z5LRk40SQZUN7e7UNBRDo+au2byxnGSO3EmrtHS0ReFVTNRuys6?=
 =?iso-8859-1?Q?7RAqtg/CeoSH58M6mz4rt/cKFok/LOrSwYJgwqBPWp7RnE5BlmxMeD3Ebd?=
 =?iso-8859-1?Q?x9CGtHy7rGd4RnAjCUoe0gyGafhK0NDTXWN+g4YrJnEAs6PGjjhdvn2ZcT?=
 =?iso-8859-1?Q?Yw8G744d9qUwT6UR6t1ir0ftcnYK+OqBJnhtEVnJZDNzqYoYTkieTnLvee?=
 =?iso-8859-1?Q?4feGNq5DAcW2at24A1zcibv2ruVH8FYA3p1Qo60cQoU79WpAgI6J2Id4j5?=
 =?iso-8859-1?Q?0JlttZyVfExIOlImW50jm+leYGw3EOXIzfoEtSL2k1PR5bUAqMB46tvgK2?=
 =?iso-8859-1?Q?cb6Ubc2CYcxngCXpVTxjjssuEzuU9zspmXJGO8FzIghWv5nX11mqbn5eCE?=
 =?iso-8859-1?Q?/XqTmu9FF7k99NJ33Wdx/3SGxpGcywS+kb/SxfGbNICs1g0Sg5TQ9cMAVF?=
 =?iso-8859-1?Q?K7x/FJ8uR5Lnukyiv0RfWOn2Hyi3HPbRIARcD/VIkZ2+M1Jz0dG5GWTNeM?=
 =?iso-8859-1?Q?Vm9I4QrexGOMNZn1wZ74U5/4yeQOUVLM+XMoVhG2ksNF/vn7ceAAt4Dpkn?=
 =?iso-8859-1?Q?1auDTs3/dXHdqYyx1SqyiHWcu9EkgnyhrDU5GmXZnYecuNIJRlzykEAmUn?=
 =?iso-8859-1?Q?EtzFN8hl1IZg3zpa2WylQVj9/ny1SAr419PgMv9QmZRBgpB4PdXD4po2Yj?=
 =?iso-8859-1?Q?A/E1DlLZHDpUUqEbrTMGtJLQkcBtTLjXykVUOGlKsCRCEiYUATYw9RmxTi?=
 =?iso-8859-1?Q?a2frEyd73L1pQKkHBUupVHBXQ2yQlGeVtyoSYnItEJlTU/FOnIcGxQjype?=
 =?iso-8859-1?Q?haLWmf5xmxqZkafUw6/gNzz8OQCM02Djk+6Q4AEVq3ftCXYrpvX+q6rxsZ?=
 =?iso-8859-1?Q?I/STuJgX7nzaBBqVfH4Qf3LjsiQsSeBaFE6zj/AqNJTL1oPPSGDd/PyhWW?=
 =?iso-8859-1?Q?XO5vHUdWfEzljPFnOsNCsuA8vVvrrs8PSw2v3q8GWo7bJKIIKfL0xEs8mH?=
 =?iso-8859-1?Q?TNqu9JI6zTdPAw2AGuH0FHfycKe1jOFI4VyySQjaoojdoPcARo4ODCmg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 055fffb9-1c4e-41df-06ea-08dc10f0579f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 08:52:42.7683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9L3YV1/wI13mG4o1Yt57hqGHjrxphtCZnbhi5K2pFnv14nrP4ueJDhsSqztU4kkxlMf59fcDp7x3UUGP7vmQuTyQK6FRlWzQRY6bjiNQsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6181
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

Hi all,

We are trying to enable FIELD RETURN on the NXP i.MX8MNano LPD4 EVK board.

We enabled Secure Boot in u-boot in the first step. After checking proper e=
xecution of a signed bootloader image we closed the board blowing the SEC_C=
ONFIG fuse.

In the next step we created the board specific signature with UID of the CP=
U included to remove the FIELD RETURN lock. After that we were able to blow=
 the FIELD_RETURN fuse with 'fuse prog 8 3 0x1' command. But now, the board=
 cannot boot any more, it will hang after execution of the SPL bootloader p=
art.

We can observe this behavior with both signed and unsigned bootloader image=
s.

Is the FIELD_RETURN feature for the i.MX8MNano supported with u-boot v2024.=
01?

Best regards,
Thomas


Thomas Sch=E4fer
SW Design Engineer

thomas.schaefer@kontron.com
www.kontron.com



           =20
Kontron Europe GmbH
Heinrich-Barth-Stra=DFe 1-1a | 66115 Saarbr=FCcken | Germany
