Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EC4CF31B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 12:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C51A83E0E;
	Wed, 19 Nov 2025 13:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="B8hR3RL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 923FF83E0E; Wed, 19 Nov 2025 13:19:18 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD27283EA6
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 13:19:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ9EcIhD5/ERORvmYH5WF0xgEtWL+yUc3U5WvDy0KXRrEr+5I2ALxMC4NHQpbRSl+5IxdquRf5yxBXRJ3SI9sWZf4qYo9q/5c8JMpLFijWcn/YUHq19HHwCluDZLKasHB6vXnLZVLuU0fPEc5aO8XpAyKlVMkAccq/efRaj0WJHGoLHuzM2gSfKs1fru0g89LyeoOr3ezpGqdTrUqwU0FCTeeVjtYgmWX241+EVs7IVn97KxEvjI/PtS/mniDnMCauSsRARQ3dnxBjgorR4wA8amYdFVuGvDWARiIeBOSZfb/mu5R17zTR9dn25FSf846YABjfAjLb97mbYhwV3/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d82jfQTW8QwNaa0c9iMrE2wJFf6GJ7y1qjoynlS+tuw=;
 b=mEBSPh1q5FUtdspJqBsETM/z0cunDLgcpSQgx4sIZ7BoQfbgiUFVJPjP82cIqi3tT4RoDHJrqAt44Nk90cWGnZaKXBnfmaH/yEPYc0hwQPjt8XGsrwTHEI3D/iQiWVLysF05hzI5vKow6HZDJnZUXtUwHyBAlP4g4FQ9PQDU8HOl91/xv7wXDWTozzzyAreCb//suFG/NvglbJYIs+K2zSEfIrnejbNO4hhHXRIocDHwuX+VsbCyILwvpPA+9WCNVkMujuWJh49B8sMZO5Xsgepbrvr8XxDJuRaL7rtGxTXG/lG1aXZq1Z8dS7CA1ZL5EOlOvu5RIzEZ/Dp7fv7eFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d82jfQTW8QwNaa0c9iMrE2wJFf6GJ7y1qjoynlS+tuw=;
 b=B8hR3RL7n5DtYzI5NlS6H6592j7kvYcYFSwo20WNrjAo4l2iAZMi3NGE17E4UXa8fdLnL6YT3hIg13G/cRKyRZj4kTrd76+H+js5LprDlxnBWmVHwscfUaeUOB8NPbkuQiaNGJOtzIJOo/Q1SGmM0lb87oM1mWygXTBmzu2a2H2I1GiqEu9QHdB17/dWuak4ElKgss27bedFIE0YvJUxhmND1LI/JqK/Y4EyQFZsz6KuZijW4bmUUpad07JXET8btoUiLCbzu0DPi20i7rZIxFeQv2c02LDKdcOMfaJY+0lRuKnKe/6hUIBO6Lofud3k1Obze7+aLPdtE6b782jNog==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by FR8PR06MB10836.eurprd06.prod.outlook.com (2603:10a6:d10:1b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 12:19:09 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 12:19:09 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Quentin Schulz <foss+uboot@0leil.net>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov
 <ant.v.moryakov@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>, Peter Robinson
 <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, Kever Yang
 <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 2/4] tools: binman: mkimage: add support for passing
 the engine
Thread-Topic: [PATCH v2 2/4] tools: binman: mkimage: add support for passing
 the engine
Thread-Index: AQHcV/p/DkdWXRIHIU26N9WqYdPqkLT5wjJc
Date: Wed, 19 Nov 2025 12:19:09 +0000
Message-ID: <DB9PR06MB8512D66041BC33351E38D0E0CBD7A@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-2-e053f683c0b8@cherry.de>
In-Reply-To: <20251117-binman-engine-v2-2-e053f683c0b8@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-11-19T12:19:09.009Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|FR8PR06MB10836:EE_
x-ms-office365-filtering-correlation-id: 3ddd8ef4-4e6a-40e6-bc73-08de2765d7a5
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bPNfK1zKwWS6do7J23M2D+hznHZGYJZDATc5yLS3a5dReVUNmFdqaQoxDZ?=
 =?iso-8859-1?Q?1bhyq7tBmaiMarNlZKW58lW9PCV855ljFPBN1tF5s0Yc4rvg7vqZPbJ4ba?=
 =?iso-8859-1?Q?Fw3k/9p0H4Y8ScWFEw0XowfUTcoLIt+1+y07D/X9+6UiVDBAQj2hFAqPll?=
 =?iso-8859-1?Q?egldIhtMcAGYhEHCKiy3x3EwRf+wIOgSHRUesb+3ctFzsSUiMAy4bmKcy8?=
 =?iso-8859-1?Q?i+nve1nsLE75xt/7AvgEYuiAh3hoO0DR8kc8hZtYY29tXherrstNr45/Om?=
 =?iso-8859-1?Q?1iNnk4sSgafPtHh2Mm4+77RoMXaK0/R4xnZsYdF05aWErh5Av6PGWYrLtA?=
 =?iso-8859-1?Q?jSCnnwUzWinmUgxtOZXf9YP63FMEZbhHz79THWlj8ci8VHyYf9ps7ZzKvT?=
 =?iso-8859-1?Q?BLQ8JzBklLtvQUzSegZsIsA0iuc9EzET1bpiywfT4OLcZk6ok+PQVfHbzF?=
 =?iso-8859-1?Q?Se1wIWgTF/6iE5y1pnfDKPtxUdv/l2Bt6qKB5/h+0p1vz1+aHRH1Rnv5f+?=
 =?iso-8859-1?Q?1YSyoEc5s16ToEjE/HtdjDOEgBmkgfn+o3S3jEPmYW3GVvFm4MFNL75hnZ?=
 =?iso-8859-1?Q?GoZCJQYpUSblQ2BvyBCzt70p1Odlk52fiLjTbWtPXjYX9gRukFs4y0iQ/k?=
 =?iso-8859-1?Q?OhK5CgK52PiClRQhOllYXVll3lYVfqMFLbutXrrQG//FLcXupCHHuXAqQm?=
 =?iso-8859-1?Q?tnphf4rPoyWwSdV27PKE7Hb2nbAWPj3ulFGGthTXGbV0MAD33wJ7seraie?=
 =?iso-8859-1?Q?M/n1K3X1ZeIxSXxryElhv+ntJFd37dTUaQEEjLNOckcl6SGDoJONvvwmjx?=
 =?iso-8859-1?Q?ZznxzybvJERPoRSriD48Fcc97i48WjPwfrdxCrNBY9HynBtTpGdK4yLyRW?=
 =?iso-8859-1?Q?7mElY6aPH/7fEwrHhbcUpUImSSwpOAAn3EXIy7YX/D1nKa9PEOKNfeVuwO?=
 =?iso-8859-1?Q?wo7ClA+1sQwbt+wzMH43RdE0HBwIiMWy/X6nTARMHyJEInRtHInVAoPI3N?=
 =?iso-8859-1?Q?6I8XjOnLNqPVtiIY2bv3BuRx7zkMbJYuap9fe3m5GX2U5rNPWOR8dA1ow8?=
 =?iso-8859-1?Q?DE7Qqqpg6k5+eYk5/2ag5aMzf3io4gJWVktzTuQ6jOgz7L10iPmDJm5gW6?=
 =?iso-8859-1?Q?tHZF6zCMfpB5OLLmauyX8fXM7cxS50RGQAggfKsFrmJxtWcBkNNdHoLnAD?=
 =?iso-8859-1?Q?J2cnh8er+9QgGNu8p7Mw6vn8obHoh95a0nSxtY/GHtAjq2rim+7S8g+RYS?=
 =?iso-8859-1?Q?asU0eqIPO3ZOHZolM9P2utnsUPJp1Z20C3YPdevEjUfcr8SSzXXwuOzBwm?=
 =?iso-8859-1?Q?s3PN5YKQ0G3NjBNZb5h3mG3gif9B95xPp541hHsfSYRJolp3/VfZMuVKED?=
 =?iso-8859-1?Q?SMXlR6rbIEffcPtJdrwW4Wwl7XszncoZ+jECSvWS9ayKKyjMbpq5QB8qp7?=
 =?iso-8859-1?Q?sBvBluvX5L97x3D4kAcolvQNI6XS1xch95pcCPUqWmOWdv2+TJP5U5iqTr?=
 =?iso-8859-1?Q?D/ehQnp8jebBmfmTKlfnAVndTw9/HiOQo63P3xcTyDmtqc4Dr+lu1bmZlQ?=
 =?iso-8859-1?Q?Jfo/EgsmWkanPi3+cvlAU/xUrIu7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6O8PbB/WZTCdN9mCXldvvMWmdsy8LXRokPV0wHsPK7i3ftxur2wl29mPAH?=
 =?iso-8859-1?Q?JXd7dVg4TPpFOOmOo++yEMJkJvJdTi0D691WfNCXmTyOm0iom7VV1ev1tL?=
 =?iso-8859-1?Q?8ZNV9988nnwvMLezhmbCqrqPnle/z7nOcbj2rhjmtwArFFpNk25F7NsjU3?=
 =?iso-8859-1?Q?SS2prOLN2KUN9Y/mOnc2MF0WJCHB2Z86CY3+gxX0trx5VLIfkc2nYwgS/F?=
 =?iso-8859-1?Q?JUpBipHEcV94YQvwfs3Yk9W5adW+gOf/n5LcE5saikeQ7et7yfdP1zVavy?=
 =?iso-8859-1?Q?abZnt8oGMl0kj8i5SIgD5xglKTg9zARjc93XAIGj3YPZV2pLI2Eds/wGoc?=
 =?iso-8859-1?Q?8+u+5zWNEazLntFCvX8PnLw5UU6e5Vw+kHZ0zKNBs83bO4QUEgkFdp9YYP?=
 =?iso-8859-1?Q?GnYtdYYSUQzgxeHdDWAj12TeVIVxj42SFKSmWMIGOsm5XO7NUcDk6LOCLi?=
 =?iso-8859-1?Q?kIik8ToyICLuNFV8BAK6ub1c2PVSgDZVCDjcI4Y6J5c3PvWR+3aVug7Tnx?=
 =?iso-8859-1?Q?287L1K1AAXIhIz8Bi9tWXCwfXcs4T2GG7jrVI/IUyk+IYiS+A3hgrP9kF6?=
 =?iso-8859-1?Q?xkL6ErwqLjm0qQEo2OFDfvwtuaTL/bA3ED0SXuTQEiubgRwOa4R+uk5tq3?=
 =?iso-8859-1?Q?hQ9dBSNir5zHABp5xNRCvirfKBJiqUlMIm1aKtm/K988MTrUpY8gABXGBk?=
 =?iso-8859-1?Q?DetA+90LNYIB6z2OBg2ioEyT5Mvz67kJYUl+Ya/YPryorWsNKIjbD6wQTK?=
 =?iso-8859-1?Q?9C7GIEl96Oqgyaliq+iKy4AFaSmuguv3A1Hq9Tpw7zc2LIcM3nk9nHBJPC?=
 =?iso-8859-1?Q?5cRu22mOGa4cvhM9M/5miGlcTKLmizoxFkS2YUgl4TjzQEh06RnAigxY6D?=
 =?iso-8859-1?Q?OEmnGD+CTtdgL3HgfuVVZ52LBBKQy1zxqwDJTtF8asSB8Zdu6hL0oVozc0?=
 =?iso-8859-1?Q?Wyd1LHwSomA66Yb+jmqqhos0ffvM0uSI8qfRZFGNDou6zvBc6BvGRCzmj2?=
 =?iso-8859-1?Q?BqmMLxndkD/11wEV+Y2QdVc8QalM5cKWYaAG/KzTYvQPEY/7Gf+Aw+5s6K?=
 =?iso-8859-1?Q?MI82n630FL1MCUV2ePSXVMk+eayJo8JzNEMc4GWa2nFgznRHfbGx7b0mYv?=
 =?iso-8859-1?Q?zt+CD1ybSBnE8gTDzxyjxGTiNVvP15I9RWDipXut/ngeBby5hghFD6Smk3?=
 =?iso-8859-1?Q?JSfKaEJQgZ0fHXBl1MFgKS8QqPXNNJbEEJWzYPZbpUlKFkrqw2rpIEi04T?=
 =?iso-8859-1?Q?tPxFxT2CXdhHB2gvPIdngfmj1tqUlGl6upLMwStiKq2EM14HbSNbJnt4ei?=
 =?iso-8859-1?Q?Xq20VuGoJaCnXcgK28+BmVUwHtlB7xkV5ECacKXAvBFNwf2PrWY4xFsudA?=
 =?iso-8859-1?Q?oRqQjQd3csFKUXVVKxNvTc+eeelyti3pYYZ+jwUxntTRABDatpLBOH9fRm?=
 =?iso-8859-1?Q?caq48zLYclqh4Gk0tX9OaDS1xe4F3/KcQktkgC5a+LC1C6A49YBASUutRQ?=
 =?iso-8859-1?Q?Nu+o3XnD7npRE6+Uh/ntH0IqTq6BUajbhQQBe1uNdOHQaM1ayC+P90bk2j?=
 =?iso-8859-1?Q?l9fxmdjAMvT+hPpe8LOEQBwAon+2v0BC9p9l3cWttFu0k3GFalXIQzDK0q?=
 =?iso-8859-1?Q?zmPAVL3AUxBx1Ww7vb0a7byO7kxYI/uZb/b/FliLpjZBPBjX+aJ/j4+g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddd8ef4-4e6a-40e6-bc73-08de2765d7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 12:19:09.5702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYph8Ei8HKrJF5occZOWuNOvjPg1f/CtgbOE8LprgbM/WbmCO/p3Fr5/GMoGJ8KvuaHBdESIRrWHv5IavDfTya1Bu1TjWgC2Ei4+FQhWW5fbVG789xRryqRS4pWqJMHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR8PR06MB10836
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

Hi Quentin,=0A=
=0A=
From: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> =0A=
> mkimage has support for OpenSSL engines but binman currently doesn't for=
=0A=
> direct callers of mkimage (e.g. the fit etype). This prepares for adding=
=0A=
> support for OpenSSL engines for signing elements of a FIT image, which=0A=
> will done in the next commit.=0A=
> =0A=
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> ---=0A=
> =A0tools/binman/btool/mkimage.py | 5 ++++-=0A=
> =A01 file changed, 4 insertions(+), 1 deletion(-)=0A=
=0A=
Reviewed-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
