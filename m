Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8404CE7718F
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 04:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BE67803B5;
	Sat, 28 Dec 2024 05:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y3xkvUVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A84F80422; Sat, 28 Dec 2024 05:29:51 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D0C80381
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 05:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkoM41EIoMKPRV5qAZsdxjV5CqYMGNe3zG/Pa0vZ/GKQ8xasmY+K9w9WzU49cAMtp9khRl+qU3fFFr5/o1JEUpv0iMN0io4nXyjOFrteI/sswVKjpk8Abw7cx4ozdBmw6Y2EGRbsUbF2STvaT8+LHC+u0GcBPEUtbKRvL5qli2t6/kPp53yvK4ON5uq8nNmy8lZWkHbG47c5WxldUzRG8vkON980UZi0A0Bi67bQu2utSGxgGzioTPfuKFmu8HMWEEHbqd41F0/aX+Y/xOliTcX70PH77gSeMIHdfACnnuof/GeMFGkoFf237U36geiH/eH5JCGdv8jbrPf2QFMGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7iD/px0xpQR+ucOquxsnh2f4CrNF4UxCUFgqKbj1+Q=;
 b=DymyLn5dkdqDit+jxDRLQj5z0htQbQxaDcwWkNZX8D2CpCwXbpWqt9DYZTEJ3daKDR948xpC8HCFmep6Gp9kJKraqTjXuBUDOKiQOrvmhi+hUz7Xg3cFtwg4EK7mk5tTRiVFuMYO+Knw32BHPsPGtKTXU78ZakdlBP4JTgCwZhY2KxBepMmwgLa63N0OiXpHQHbOJXDjUju8nDf/59ZU/F5fR76kCAYtfGlOkfas1aBRkVwvw34x+fe0g/Wq6fALjBV1SV1RMh+503JbN2216k8H9OiPvGY4/EYhrfWkv52O7j9EtXfryTL8vIG0UmsqW68g4usQmnBRDxDxbGSLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7iD/px0xpQR+ucOquxsnh2f4CrNF4UxCUFgqKbj1+Q=;
 b=Y3xkvUVfKs/9LTGmlwuv6du/HyTFyZvBEEu286gBMvX5gr/IODPKaeIxXoJaPaVEP0pXvheAnHtatAOHC2KzI17PnPAILxqtEBUt4CybnmeymRk1GKRhHL/WCQArh915H52lUb/OCaKh1xCep3MegX+eJ1s88ZvquL8b3AprV1Q=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Sat, 28 Dec
 2024 04:29:39 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 04:29:39 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>,
 "marex@denx.de" <marex@denx.de>, "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "seanga2@gmail.com"
 <seanga2@gmail.com>, "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, 
 "sjg@chromium.org" <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Topic: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Index: AQHbWBrUi10JtBBhZE6rXbOanbpUqbL6aIkAgACo9OA=
Date: Sat, 28 Dec 2024 04:29:39 +0000
Message-ID: <SA1PR12MB869745E73B63621C18E0E4D6980F2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241227044934.2109997-1-venkatesh.abbarapu@amd.com>
 <20241227182306.GE1505244@bill-the-cat>
In-Reply-To: <20241227182306.GE1505244@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|DS0PR12MB9324:EE_
x-ms-office365-filtering-correlation-id: 378e7b2b-0ee6-4a30-69e7-08dd26f83e5e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?TKRqOmD359zzahriRjbgzx4SXxzzQhJrHPEU8Q2JgN9DvYQY/LHjbEC+6b7P?=
 =?us-ascii?Q?pwvGiHZmphm9rB7pTACAjtFaiQHkfVPS4kP1eJPcRPymHCCKcZFKOFDErD8N?=
 =?us-ascii?Q?xU3kEXYDhOWha+XzX5HYF8YQMigcHDB52ENJ0FhJdudbvp26qj/gpjzk+Jxn?=
 =?us-ascii?Q?bupaHjhpdbY8rYHsewpwftUCyO8bFUkEwdGd/elhAiD/RR8hMFYeucLiLawX?=
 =?us-ascii?Q?1g4MiBeKKl/CRQLmVCjV4jtzdJomDsCsiQkmHe8hJ+XybCmbxcOalLPREA4f?=
 =?us-ascii?Q?WPe2R/wAq8/85qH3g1W79bU7RKa/C+Pp8Ly3L34alQb8J1OioDo52q3oOcWD?=
 =?us-ascii?Q?ad2Bx1Fmq+NtJWeChS/F4cBv/eUPVqbFqMGhBbsXTn+L2pXW1+hXG1ZTbAA1?=
 =?us-ascii?Q?njvf/0DAIRGjoJ2aLE7QGvDwRogASuQiq+V+JNSPxmry2EMJpqCCH7p4vnH3?=
 =?us-ascii?Q?s1Uxls231XKpa3Rd9Sbm3vgo8oc3nZ0L7iEske42G8Ai2lHsKH6lzSeBDoHF?=
 =?us-ascii?Q?bKCFSmJOmlGfCPsLKBpoyGyltccPMGRdJOLYZOWcgz+hMQng2xmAD7TbcLFq?=
 =?us-ascii?Q?33nncEwjtiinZzPmDoX34fUnK9kURGh9GRzZR2mjrOBi2CqVAiKE06VWC56y?=
 =?us-ascii?Q?3NIl8NiUptbIeHwkmPovaJcbbBkX7hxVmsfej41JBTEaKN4XzO4wXqRl5iL8?=
 =?us-ascii?Q?l+UXLsaVY6LstaML/q8ciqHSQcJAyESYW4cRGDGw4JXYAWfjX7izHKLygiON?=
 =?us-ascii?Q?hr8/8bihLxC3TeAyspGMmoUNlVeHmhP/0PxSaPEhb3+lQ8pzEE7VW/MSKPBN?=
 =?us-ascii?Q?IC/E9nP6NcvWXCyqBwdsA5bHw9aZTSoaWkfWgXuoXsUgkG213ASseotjuPtE?=
 =?us-ascii?Q?d/5xifuYO+VyA78033XrRehm3N6MLDmPVjMColWzXQaIXVIC8q8iOnqKPExw?=
 =?us-ascii?Q?6C5hGTgHFy8NxVmHy/Yn4x84CtB/lNpJjAX+pL+y3bHiXjZHpvLfC95BwXEB?=
 =?us-ascii?Q?ay99pvv/yKrA4/p3s4fZON+RKezngAhVvNxurxGJyhpC/8Uo+u93VzZ2Hmnp?=
 =?us-ascii?Q?tjimBBNGhvjqtaZEe0rBHtmnh5roet0tek7AyCmq7HSJufYBc/fJvptJsR75?=
 =?us-ascii?Q?VP5bC/P0HXLXyWMwYyPsWqEe1wXwD2yC+Zc6IZ0M5yP8UGlIgRIgdhtYUOTl?=
 =?us-ascii?Q?tqMuh4aVKWa0H1gOmgswCKh+e+abJJTaE8CbklNxID0ljVd+dtrexya8Me75?=
 =?us-ascii?Q?22IumYwlGTYjvSs2FRmyocbXcaClihwPuXLod6LkG9WXHlcdwqJmcbz9wQMI?=
 =?us-ascii?Q?/NNpBBVrxgIgbiqXF/mnGXwFCi1JIKNVtrot/OXu7GtogR7bDxXTEuwmhTxC?=
 =?us-ascii?Q?kWthdp3SThFI3ted6w7H4dh2yJ+LPBNzVHLSHsHzpnekc02m7Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JboiD4qwsQdWupTZexFQwVgt0l/SOLVyl65Uoru6Iza+WS3ymnW3QySXjb+m?=
 =?us-ascii?Q?sFZ7C9xwCGQfWjkvLWq/XeJsaUb07A3bzUGuQ9CnAFDU52BrZs2c5g6zZRSN?=
 =?us-ascii?Q?9DYQgGZFoYoAtILFzfPRjslfGYtYz8xLRgyKRgcmVWAsPLi1ZZ/CQ1Om2Aa6?=
 =?us-ascii?Q?IqvcYDcroVjxLs3DhTci2Dk4E+tKP2UiCzu8JcK1Aove9bQqAcX4AlnGWKmy?=
 =?us-ascii?Q?bXKcdrFfQE4j/+JhGYRQyONs1gTHRQPBEv1oK8Id/nqgY0E2OzH8W4z8ndun?=
 =?us-ascii?Q?EISiJiLA6jnxDulMs0dTgzVZqxrkstdFvTmwEbTJPGgzWU+IdDkAQqGTSOti?=
 =?us-ascii?Q?9xnlPsesCwT4aGfh8cF6bBSBI6iA4jlYdaQImuHJOVhAKjr2zWlnIhZSKfHS?=
 =?us-ascii?Q?eiXGuwUpP6zTf/w6D0X+pIEbwSZ6xUjmmP+U7o5bXEeG1P4XavO8Xo35YQ+g?=
 =?us-ascii?Q?V0EbATCdsXFBmwaNfV+KBYg7ac/E8gYqcjaKi+dIpZkmvJzL0eXX/z5KJ9eN?=
 =?us-ascii?Q?iJIfufbPoWHi7O2i4yZ7wxoi9IYk/1VoSGMcvte/+d/cb3K4OL2k6qQmLm99?=
 =?us-ascii?Q?k804kHgbfdIhe2L5kQCA1aaR/oqgUmdM6RXG9QdJqXt9yIkWR0RumuhcWDlh?=
 =?us-ascii?Q?QCy+C0pNc47wrjDx7GwQh1Yf7l1ecbElULz2RgKgYaQ3gGchuntPgEDD+YZq?=
 =?us-ascii?Q?yM4Y/BSGADQtYLcfV/oWcCRzlbJ31T4FXwwcPrJJ8/aZpsZYLjPHhnGdZkJN?=
 =?us-ascii?Q?nAOnSr0GTr71HFhlTeYT4JwqgX8hWK5dJ3r/EWdXaF7wQkokuapmOyxh8fUM?=
 =?us-ascii?Q?9qOP+sdigoqvIgOT+JtDzqrLBs4ZlGQeqUCgA59zBQ09WWidDGdGBYS0dgQo?=
 =?us-ascii?Q?sQe9Y+IGma5vAlsWhq0h5oxr42EIhcADfbsai+0IorIkiPl+1mbVf4Ticw/p?=
 =?us-ascii?Q?WFNTwyxeZcDwLjz3Aqfoyvv90Z3HoN6L1wxvDxfQhnHnFLix0HF26dgM2tXa?=
 =?us-ascii?Q?09AuP24NDV+92Oj507zdVopdPgMYVnhzMa2mz6cFWVBLz0dYe8H0UWB7u61b?=
 =?us-ascii?Q?sFCDI4oJGDfoz0kBBi06iZZqGUEzXzTGJ5e02wc22H4llHv9k0wO2GJ+auiK?=
 =?us-ascii?Q?/9MEx4I96o1+fFjMbp7HVY0HI+fCw2EFzI9pC43ba/yaGNsSKwd1t1bAj/Oe?=
 =?us-ascii?Q?GV1wUyffkFC0+MOAjfKefL/cWsHE3xmFVHDJkNs1iX99UVs5L07rszxQYj1V?=
 =?us-ascii?Q?Qbeg/EV4JKtYjnWKzycZj3/bgPF8HEarWDzTu7lhDF0gmVk+CxufDyP70qv5?=
 =?us-ascii?Q?hu/vke+Oz5FEL+p1fmy1t5zw+JTiCLn0ELMI9FjEORaww5c2Ljqux4Lf99Z4?=
 =?us-ascii?Q?NzVuZnVqdNylEnZSF5B4Sl1q8YSwERHVbQOGqeN0nnLaIMPXZ4+Z+kn0cy9F?=
 =?us-ascii?Q?MH4T9HSt0KqKec+nvGNykK4lvuwkmki4Z22fT73Xqcikpr0nYlhBut8MmAym?=
 =?us-ascii?Q?v8bvkNHpxlCFLr3ZLEZgnfy0yzrRWFJwQtXbujPJUSgR1FkpGExPoC+Acpgc?=
 =?us-ascii?Q?8NRxNKb3XbMRKsqhtfA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378e7b2b-0ee6-4a30-69e7-08dd26f83e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2024 04:29:39.6472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ToJyUQVp6ZurgjBYN2tlmfKqD7x/wTOMcsWfbI/k8XcDpQy2PVWCmDw2gBqxVVNsVSGttL2xdpr5WPYIPNAng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324
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

Hi Tom,

> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, December 27, 2024 11:53 PM
> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.denx.de; tudor.ambarus@linaro.org; j-humphreys@ti.com;
> marex@denx.de; Simek, Michal <michal.simek@amd.com>;
> jagan@amarulasolutions.com; vigneshr@ti.com; u-kumar1@ti.com;
> seanga2@gmail.com; caleb.connolly@linaro.org; sjg@chromium.org;
> william.zhang@broadcom.com; stefan_b@posteo.net; quentin.schulz@cherry.de=
;
> Takahiro.Kuwano@infineon.com; p-mantena@ti.com; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
> SPI_STACKED_PARALLEL is enabled
>=20
> On Fri, Dec 27, 2024 at 10:19:34AM +0530, Venkatesh Yadav Abbarapu wrote:
>=20
> > Update the spi_nor_read() function based on the config SPI_FLASH_BAR
> > and update the length and bank calculation by spliting the memory of
> > 16MB size banks only when the address width is 3byte.
> > Fix the read issue for 4byte address width by passing the entire
> > length to the read function. Also update the size when the
> > configuration is stacked.
> >
> > Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked memories
> > support")
> > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>=20
> I don't think you've run this through CI?
> https://source.denx.de/u-boot/u-boot/-/jobs/984698#L289 and similar on al=
l sandbox
> targets, and Azure shows it too.
>=20

Ok...Could you please run the CI on the "v3 patch" once, as this patch is e=
ntirely separated the parallel code with the default one.

[PATCH v3] mtd: spi-nor: Fix the spi_nor_read() when config SPI_STACKED_PAR=
ALLEL is enabled

Thanks
Venkatesh
> --
> Tom
