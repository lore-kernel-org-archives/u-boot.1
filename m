Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4CCC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98ADC8896B;
	Mon,  5 Aug 2024 16:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GrXWtHvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C4978896B; Mon,  5 Aug 2024 16:06:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81D3F884AC
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF9IUhVY7tHdsTX0o/oi/RNS+FmBAmEGA13L/5sAmKb98smXk1CR5HmsFaqj7/zRZ5+aAoaBGgGrSZxI+NwmzT24EvEzd872UNqr95LKnH+gz/ZjunBcawP6SJ9wqgv7TCU5FLJeyh2Mh65eXss3KoLdbORdmiMfi3iU6Rmo765wpE+7eX7b6FRZSVa6UeRDRDbSpBK9D2Itc5zkO/2FuUXUhdeV8Xq8pN+VQm5aBq8SriXM0WHNbCTvgxFlt0qDvK+1cYzt5sayhSniwm+NzmrH95ptTJmjMFdgsCUEvU1Cl1WmsCOHRiwzxgGxCNULczEpOZCv6xIF5nCE5dUamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kgc5MtoHQVQTi7hTFrhzSgqyxScc/3ypTew5BLdr8SM=;
 b=OA86DooGfyzZmkMO4Bi+XP8V/3IeELQN9SkFVg8xWS20tbz16rewJKpGaoDGfIM9jed2KdNqCAVaAmDSJm4kejuHdin4DcVDymsLbszPdsDRAIuUdPFd9SIbRBd9SGp/4QuJNt8wh3NZ5kemT54mtCjkbvrcH1ZZbzPNIxKA+iml8QBP5Iv4FeCxdb/ke4s9x4uMnrNJTVLIBjfIob8DylVK6wQLFGaFDib5rhiZG27j6nGR+8kLgtwjGy5ehwVI+fnSIkdeT0KqmCIUnsQXT2Rgfq1cq/UkClM4qBmdLqRaMg3f3qRt6/yclC2y0PE7TJ4rUxbpW4G1Kt2X4qZHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kgc5MtoHQVQTi7hTFrhzSgqyxScc/3ypTew5BLdr8SM=;
 b=GrXWtHvFDYjnr1eeUCXoOW2xjKJDuM+JBxgis29HHBUBhFEDoIX2hT5pTSxbKJ4JN8QmNxGngfw2R2pCwbfnqRaI74jpS0lSkN92rXrRyZDR1GxpqaH5rCm/S2QOPhp6cm4w1fmVFkOU2wKnlZk8SILslEAhbdUU6Cp6E/OUEsEr/f6MikQVOn86tEszgS9PWp5q9nwJkTXSiDmdxSqzwhGDXYCDC2x5igKkjpcNe09EdBJuY5MuZiAhLLG8pFf9D5YtNgpu1YtacUvBOa+GNeTJBX7fKb770SrWwRW/7h7Yb4BTb3sdOi0ZKT/xbgjU13tjRrqvFstYBU2MWEZ8bw==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU0PR04MB9275.eurprd04.prod.outlook.com (2603:10a6:10:356::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Mon, 5 Aug
 2024 14:06:16 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Mon, 5 Aug 2024
 14:06:16 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Gary Bisson <bisson.gary@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH 4/5] mach-imx: Add i.MX 8ULP binman support
Thread-Topic: [PATCH 4/5] mach-imx: Add i.MX 8ULP binman support
Thread-Index: AQHa5zUY8cjKmnc8OEy4k05gtGnYwLIYsrKQ
Date: Mon, 5 Aug 2024 14:06:16 +0000
Message-ID: <DB9PR04MB8461AB9EB730D0E17FD0E3D988BE2@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805124326.544310-5-bisson.gary@gmail.com>
In-Reply-To: <20240805124326.544310-5-bisson.gary@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|DU0PR04MB9275:EE_
x-ms-office365-filtering-correlation-id: 2d0ba83a-abe5-44b2-67d3-08dcb557c5a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?32fzzikrqrQ02vLyFY6Spb6JTutCciLIPS4r991alqVlzgPgAGyBm4lpIz4y?=
 =?us-ascii?Q?94T4zHH8z94jqqk4bUxiwSBmm1WosB6jdho/zDlVw5bmOE0TARmfpJZM/Kua?=
 =?us-ascii?Q?cqmhtqDm0izFu2jBhqXjxtS9pWiH6GfJXcpzxSUh6eniVAFPVzX9vRYFpKR5?=
 =?us-ascii?Q?6koa83yMpakY9TNXY4Cp3/fgNFvTLY/6Gaz1BE67tgTbITEZpLhxAR25W3Bf?=
 =?us-ascii?Q?ntwgWdJ/kttVfzrXgoNIKBc5uFPF7QHmvGrOGdvC6ZUzDmXFCdfASWQYiNO3?=
 =?us-ascii?Q?pJ4rlsDNbsouGUj4mfbWAOMhBFKsylv1DEQmswVEKajwS0IyDWAV4zZznXBg?=
 =?us-ascii?Q?ZUJ14f+c6tZEN2Z3n9jyrYYn5saxfGhmk6op4TbtQxTZ3/7AuEDI1yMBezjN?=
 =?us-ascii?Q?F/a9zfjoZWJZ8qz7l35w4oKd15EUQ56Eapuhx+4IXFKEvcuE4Pequ376BZsX?=
 =?us-ascii?Q?Z5zgIAim0VxmSQNBGJht6LI6i5mXMCnDPcwae4yGTwOYKLPX++NIIFuJclnm?=
 =?us-ascii?Q?h06pi1Av1mGwAESvF28y6nd63xg7CiKW1xTd5UmmubhbY+OTTQenPaP/QIzI?=
 =?us-ascii?Q?XI09t4ZNh5UK7sHnATHtcsaqD3YymG1Vu1bICnHfEUGCyjIAEmXMh8pBcT72?=
 =?us-ascii?Q?Ct2mxcPyrklpbNm1P3xs+vShFH6rGgu0aNl2O+4zDOnAftzTf4F6kzONV/fk?=
 =?us-ascii?Q?HJwrra6LM9ZdUSGkjxDJB6jJR4BLYdt+k6Q/6jOqI7G+wF4VVDJRS1vnmfsz?=
 =?us-ascii?Q?ItCB3ohLIg/kmw/fDNG69E+QPEJcksPfw2YDueTrzePTFFfRcj66h8FtUUXA?=
 =?us-ascii?Q?kUCOEREclxF9ria3ye/lh4v4Zs5kG+L4LxvM5ymjweQDwSabH57eqzE8eqPm?=
 =?us-ascii?Q?JuOL3VWSveUrefqR43ER4MNOtZzu8oUzK2U2nWYh1gMQgIXo9ieR+0exUlni?=
 =?us-ascii?Q?2Krx4zYDZmQdNDFHc8vrJLc6+xUI8lGA0ICwTCKjo8H5jC1TpshT6MgdVkPI?=
 =?us-ascii?Q?yvxhn/1HPKUTmo1ORWokNvI6NHqEzbeiN1IdxKWxcRlxQuXQaiZ6eZBmS1xb?=
 =?us-ascii?Q?zu1k0QIwPhOhi7nMFFwv4VlhW+jhbJFSvUERtv+jTmkFw3wkqFF7lU2W0xlI?=
 =?us-ascii?Q?Z7o2RJNYHRplJhwQN4xKKVQlwQMAIU82BEfj6y1xkVc2yHyYUUE0CaTm7veA?=
 =?us-ascii?Q?RtRtyiRZ7Cnxw1rt3FqlMMiTRMhTzp80ZiscBTxa6pqj8GHh5bWzteYu4LuK?=
 =?us-ascii?Q?dc2nuTSdMNPUjYdMWQXDqkZrzYcfv35wMSYvoAyqpx84k9XA7edC7gadWeep?=
 =?us-ascii?Q?pcb9taSi+ztIwuAGxL49BzrHSbnthjytGFCU+0DIKpohDvGLZxVJbxBI2bwA?=
 =?us-ascii?Q?6c0TYpa7bM08YN/XuD2yuNxWy/elnOR9EjTiCWUY13I3Jdew9A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2ntuZNoC6hWaqrEJa3pHSkiRWp/qJnckKvXWevQkjclgFRHjxEQ1m5mX8vCt?=
 =?us-ascii?Q?z9xZOh6nhYfogyjJEKvMUv6C68MeVSvvtQKGZXZ/cI3q9cLwlxgw2Ztz1zJj?=
 =?us-ascii?Q?Iv4q1fknQQjK+LO1CQ2fE8eR4A0xtnLzOftexza5zA+vYbp6HQ/lYz5vTgpT?=
 =?us-ascii?Q?X8w8ZJnI3Tn64bYvYNr/zalbGNj2sd/w3yDHOxVedwL6h7n3QkDoA/o33yon?=
 =?us-ascii?Q?Okg7wKFlHzQa73/RkFHqd3iCI1d8bAzG55PjCiJiI+vpYJ9/VErX4bIsfecO?=
 =?us-ascii?Q?y9ciEpDh5pGP0FTFCRTY4URx+RBus8N+8L7pfDfwfArsrGO+I50bIosZ4vKg?=
 =?us-ascii?Q?nnRdjzSMBu9lPR+sosYWnwvlCNxH5mqIYF/sWawrsmKeG+MU0bax0DQI+2up?=
 =?us-ascii?Q?ZoA6gxX7VjUVkNN3pu7MkOTIqbSeJqwcmV151HPEMP72IT/G0rS3Ofz9t5+6?=
 =?us-ascii?Q?f1DlO9bbKYcp5nfN+AyJDcxp0OASPYTnUjyqiXqZafeguxTD9rKNia3wSYaI?=
 =?us-ascii?Q?BR9UWrigCB5xa6EfjI7+CKejXf0aUfnnR4anUmxxCs8/eRFywsEUvRt3tt0J?=
 =?us-ascii?Q?uvaVmxFss4yU65Z5HGVVqWefRrj5uLodUGJFR+Kd8mkbd4vzhmPqJTiPZTVd?=
 =?us-ascii?Q?aGxgV280oQLOZGUkAW7dR46XEU945ZaxmB3fJtFz/xZAUo5kQ89Jd8lEhBrR?=
 =?us-ascii?Q?8ivdDlD4Ui88Y80rWOW4fHZtElkcm3Zv6sW111MkZ9ynB68UNEl1HPuYbMsY?=
 =?us-ascii?Q?2S+UCJZtUOsPlFWf5+VYHdmJ1H55zKe9pL8hUS9NHWo1u/HW8s2Gwa/H+HA/?=
 =?us-ascii?Q?c9J0HNMtBoD64NiKNoIf3ZVcDEoOTkihirnLieaHIY1tDELHJdHH7d+BHBeE?=
 =?us-ascii?Q?3OEm+EnrKGOut5x7oF20aBkOjWBShMyiXgHy0lrMr1ie8FFWwmmUnyYq5t7w?=
 =?us-ascii?Q?ACVCSJ/8E+rJGQx2jsC+ZhpUUP0G4TlmWpRB8Oqh7YontohtBOXufsy/3sLM?=
 =?us-ascii?Q?j4fbSRmHVHsKlk0G98iA8gbEEBonpNlauOl4L+Im3Fy3dGD5LsXbCwm8dt08?=
 =?us-ascii?Q?G2PUJUgrKGqXVE3rDRQ58/57uM8n/1kik9cEsYlDkKgKEankIRqNuz0Fvtyd?=
 =?us-ascii?Q?EB5oGespkz3s9AudIRdHv4PKGzteza6Yfqosu80MwV3SZOWnNbVLel4Pl3mB?=
 =?us-ascii?Q?ygfb4VFeWR5VxPPkr9rwRcqLo/hiqk3p4XkbuiRlG0CXAHftXfGoBywuMg19?=
 =?us-ascii?Q?+DhE9fcoedQyb9WELhVaMwMRSykqvaEIVvx5dGWvEoH2rfr8P5fwnBL3ulx8?=
 =?us-ascii?Q?Xndv8BuwsSbUTNZ92FgT7ZAQFmqb7iYF1JKLcvF2c4MlxBgFkK4//HXYVLmq?=
 =?us-ascii?Q?0AyjO+eBmsaQGuHb24GZqGh0yI8xbqdjMp74t3VM/lyT6dP4ZndUuUwcsUgm?=
 =?us-ascii?Q?YIBRjZ3i0M6Y6BMjD5yqe3tALvxIHXwxSE78fT4cGvAb/+ORyQWRcmfoCKyq?=
 =?us-ascii?Q?K61hvQhnHO4Bl1aokorddnZ59Uld4O7KKtXZJ8AlYAh+vLGfwIv60/NPWgRz?=
 =?us-ascii?Q?nJbSS1Y9mzwcStwLKeg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0ba83a-abe5-44b2-67d3-08dcb557c5a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 14:06:16.1870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x043E9Y8Z/TdV9RVk+EpObxN4Kwzv1bdS7WVc7Ye2lhe3Qex5wa1LmmX6h6kdACjhJmgJfQHpJGbrMmEClQbNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9275
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

> Subject: [PATCH 4/5] mach-imx: Add i.MX 8ULP binman support
>=20
> - Re-use i.MX 93 Makefile target as similar boot process
> - Create imx8ulp-u-boot.dtsi for binman image architecture
> - Create both SPL and U-Boot containers configuration
>=20
> Key differences between the 93 and 8ULP SPL container are:
> - No LPDDR training library needed for 8ULP
> - 8ULP requires a uPower binary (RISC-V core) for power management
> - 8ULP also requires a M33 binary to work properly
>=20
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
