Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AF8E7717D
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 01:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A644801FE;
	Thu, 12 Dec 2024 02:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="OGFzr03z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2F580200; Thu, 12 Dec 2024 02:04:39 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F0C1801B6
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIf+RPGOw7NCV+fqLCoQy28veU8I5+B4GnM2D/dJMPvbbT29RfXhxPIqe1rnGAYfmP3JWpJnLS+hPeUoisnTQkr0ADgAqxoHOorEmJIjYsrsi6/bQvtktUv505/BaxKfUHyMv3u4W3ZbR1LjkpC3LGlX+2YowOKYKwmBRAiKGOyBOUMC52s81xNclNViS8oOT+PMWDwczxhvWPhDksElU+lwHWTMrd0nYQ8n/t8GDr1y7FNiu3uoFl1KiqqV/z0DznkiErLXAWi7setoS+PFnA00nsq2E7lkqDWQTa8LoYg0ZERktGmJZzejjJnOpJ9KObpy/wRlwBjhMzZL44qTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8Ib/pARdI2phBOQw3WxiSutCqTa7s4+1iHmkrDkPVs=;
 b=pdfRS+jTfcS+TfbFxXoWil08N+ILgJLNH8y040y6zqwipDcWtnZtP4nONA7RluPl0p4Ptl4rEtlhql9DAYMXSBFEt2rejAIAyMCTRH11k23XNuTvbw78ENdU8tDKlpHf9M63+MN8yCLl1zrG8Qd8cfjT1+RGmrH88v8bh0gJHZ61VuZoiygyWIsT1fZqeOxfgTvYmh/1FHuIo2ccyt1kkjBbzWqIUgqSCfJZGZmxED8ZK0zwZ/Gu5RpdkNbBSIYc7GmsIfdjiw6Ca4JguRLlh++ugRJo/WMNwGHbroir8eyoZVNpbKq6BSQp2Iw9TTR7cPQ8wWk07apmdBni/E+Z0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8Ib/pARdI2phBOQw3WxiSutCqTa7s4+1iHmkrDkPVs=;
 b=OGFzr03zeytcR/BZY2/odTkFLus7+v3p0HOMaV3f4sjpcWNFec3u9HkWM+w8g1vFCYwqNv0qGv0gul4J65ZIbCvPc/Zi0Hk0UVebbs+oAlYFiCZDUeoL5uqhkfbNVzL7UdAqPqbXa7tBTSqSPTW2Aqd4UVBCr/Gd7doXsXEBCvYfV52fv25eVy3caiyz0hEr2M9K93LFaQ9Qx2b4cseTV6HCuGJEMh/KXWxxuvK7SZ6Ixi7Svj2QNzhtvuCK2Et9FjPal5OCpsM60C8gDRtHPC2QpXz66xO8H8JMkaXOQ5oubWUMxxRvUILX8mD0xJySTUvGoSo9MoCQCQ/xf5Rh5Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 01:04:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 01:04:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
CC: Ashish Kumar <Ashish.Kumar@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jason Liu <jason.hui.liu@nxp.com>, Emanuele
 Ghidoli <emanuele.ghidoli@toradex.com>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 3/3] crypto: typo volatge
Thread-Topic: [PATCH 3/3] crypto: typo volatge
Thread-Index: AQHbS+o6h+GnqTppKEeeHFUzte3Ut7Lhy7zA
Date: Thu, 12 Dec 2024 01:04:36 +0000
Message-ID: <PAXPR04MB84599DD05F70D6DAF335F69A883F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241211163154.56272-1-heinrich.schuchardt@canonical.com>
 <20241211163154.56272-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241211163154.56272-3-heinrich.schuchardt@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7913:EE_
x-ms-office365-filtering-correlation-id: be69ca5e-69c5-45cf-211b-08dd1a48f23f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?42rISPzsxmfYxhcXoC8wsqiKzTdETyOVgZKnaGZ8iCot/m3XRdQvJvVVIKzC?=
 =?us-ascii?Q?P9/qupKsX7YTLhLS0xIc/yUqonCTdz6rVMQkKVdOitByF0N3vud1LgpjoAuN?=
 =?us-ascii?Q?vxx4MRvsQ1hRzTLmp4EjH9D+CHivg50xzDcTb8ZRoD8fqnr5EEBetraEi0bR?=
 =?us-ascii?Q?ofXY+lUlAZLHc4yL4wwDWuuIjewJ/T47cbLOfYmkbA/nLrHLmGPPx1LTyo8o?=
 =?us-ascii?Q?EU85HeCmJT1gOQpw0QJ65gk1ke7M2xqnjYlEedgxzIiT7ork5uxWSyZbe2d6?=
 =?us-ascii?Q?tsr9Pel/Wkm95ndn8D94gyyxkaWRRwwBPhizmPka80Xav8DxuESh8QfPmJOe?=
 =?us-ascii?Q?JohzXqecYCWBdwboHrb6FS8t7ff1v5wrC/GINLu6GPVGrDkdE68RVp3lRE8v?=
 =?us-ascii?Q?tSPHLT+mymlCsJDYLraV5nsJqKgZa8/ncS6lXMxSGipUxPBJm4WpIlX9Sbpm?=
 =?us-ascii?Q?zFu9AGZb7Jyfl9a0Yt2Sp6qX57Nhn1I1Sk2l9/JfSWu4AEiEutJ9C/Qg13W1?=
 =?us-ascii?Q?yylHQCFwByTwYKMvk9DS4IR2H8vXTPq9GU8Lli/slR7p37DZTpJf895jMWcu?=
 =?us-ascii?Q?uHlHYXfChKRgokRVnteFA84iZ+kyDWao6pyrMixpZCPZG2GLE5TTRcek5XVm?=
 =?us-ascii?Q?59ipO9CvI8fyPWEiCtrhALgQkLQIIqs0nuIlzsuAR0OYZ6ZL8kmASJoKGOWR?=
 =?us-ascii?Q?WE+3AvdZAAY1TFmhg8PENIk1an9mrl9LtciXf4TqFJ00W4aSwa84lLmz+7bZ?=
 =?us-ascii?Q?+YfhoQH9/kkTsLmxIGZKuGWzF0DOB2SxQf258A3znOWm1Fat5hTi8FueY5GU?=
 =?us-ascii?Q?GBOTEefEdTv71EXCQwwhH6s5J/ayrHtRtUbmlAjkbHT9lAa3/57gyuivRDWn?=
 =?us-ascii?Q?tZefnKvdY07hIAeqHjHm4JVVqjfEJUzT++5zOOon0juwhKcfQ/tId0UYSwmx?=
 =?us-ascii?Q?zSaii0F2m0rfVrpjY0geTOy+Tl42yzUZXOpx7cZrAEL2mZSExZZAM58FD/KR?=
 =?us-ascii?Q?7s8IaV2jbZr0xSK4tqtaFJh/Ttf92p9mQmNMRyPY1/pCVTm2HUsZs/hQoQU4?=
 =?us-ascii?Q?K3Mi7qHOhBXv46tUr5o6WeB9Qcu12AMz12OcxmjFxk3b/6QsAKkSqyFK+C46?=
 =?us-ascii?Q?2Cv8ULeln2Fo4+sck5RL5zZsNzb0ZJLmiGo2BXu3YjIWaCDe1S6B2DgmZLBY?=
 =?us-ascii?Q?6RIfcDdrmU1jCcpNqVpfZaBmPMF4BxRQCjbI51OgqJvJj52Eikv3GelpSHCN?=
 =?us-ascii?Q?Wi87L3oOBog3l55CM0S4BWbfAbndKhIROaHMLD2ef4xdoil64pdZSSvj4opz?=
 =?us-ascii?Q?H0EPpQPPQ6TR+tUI5P37jud4mnGCDYt9/Fm5AztHPsnBXwq8ginT/5kgJYdf?=
 =?us-ascii?Q?JVX4RvsW57bUx9lnQgy2dw4BOnh0WVN1+OVTJKOT2kYZfWmfkw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HGDkzdqMkEi13J4gW74B5MsnBws88KM1bxBTa8Go0y7gfIbbwEqKKjGy0bl/?=
 =?us-ascii?Q?jjLm3YLKFDsfpnrRDz9ogSd405q8F97FgnLT6b/bgsLEF7bPrDgUUCn8nzOG?=
 =?us-ascii?Q?Q3G8iFCLDgo/Zm+gXC82aFpXuHWurZIyGm4cVpuR3msSNPZlxalrmIgnssUO?=
 =?us-ascii?Q?bfNX/pcDj05EhJ+vFo+G5uyMUbI7rD0OTJigf7UzgfIk+nKezt/rmPhfxwJf?=
 =?us-ascii?Q?Bi3lTUyu8gdws649F/DQbW8lD7fElmZaWSb6yZbQca2iyeBuWVZNWKdKAr0H?=
 =?us-ascii?Q?8yT1HfxlpuX2GtSCB+Fv6ntT141vDx1Tb8qYXTyVk4TokOpBEIpAlpZJvivK?=
 =?us-ascii?Q?zyPcOtOW9Jj5CWq89Ofve4CAbKE42V/sWsape9RpuNrcFtG9FprOW/+w1MNL?=
 =?us-ascii?Q?E623/AzgLXbQQRVZRcI0CJIG3tqi+Ewc9NeimTLix+bBJywg4ZKqaM4h6iUH?=
 =?us-ascii?Q?HMlf0OQ/WWVU6z+St3Es6HC/m+uqgSBp++G8v5+XK+gOLxaIunAprvEO/nSP?=
 =?us-ascii?Q?tAB8/Hd+XkD9ba154Q8PfiHtwt79BqB0cbA42Juuma45x/Bg9HP+LRD5LHJ9?=
 =?us-ascii?Q?tydsYDcs17ZB5DqiByde1gY+/y/KJD3Gez2DWw9iZldQheKfYnw33mviOFhW?=
 =?us-ascii?Q?FjgjAhIb/XqJCM85Q8pk7kDgZTTm2NXxjO5wuiyLXjZKezAHuUP5y91mheAk?=
 =?us-ascii?Q?S7n3gCoJo9f+s4pSszM2UR7Ap/s1pYqkl1BRmoNNoh3cA0FXMOXUledThp9p?=
 =?us-ascii?Q?2m8OoPd8SZDAuarmtOIUmBpcQo4voyWQ4esuN4PqnOaVrHUOmuF70OHE8Abj?=
 =?us-ascii?Q?/p1rHhCfkRDV0nhdVaC3Yx55b2HKRPks8k1HIqtiGAvdMBrFO5HaDhr9VhDB?=
 =?us-ascii?Q?XfxbQxSyJcPVUe72dh9ywDwioTztBxp7Jo1WtzRd5pFX1G6s12zOSKD1jV9B?=
 =?us-ascii?Q?jJYzi8k5HuBzKWH7ADHERMZ8NM3f6Ug3N/4tcifUpci8ba4CVB09kGJNj49O?=
 =?us-ascii?Q?BzgnObjqFBkg5XjImITpGTz9CTC1nWydIHbuGceRUXM/BZAx/lWa+jWU7RTN?=
 =?us-ascii?Q?+6FUDkJdweNGtA12SA9m9UA3Bm4cL/1CZX83+xtErRHupLqwx47uD6h8XhwV?=
 =?us-ascii?Q?grVO+V6j+5QTrqv0SwU77c6+DC3JaSOT3ygq3ULYWjJsKEwOiFGVMnrXDLYf?=
 =?us-ascii?Q?YgoZnDoa+7S7s4IunI368DarYCxgP6jUuojAV6Rx9K4p1zd2tVrStGqcLzxx?=
 =?us-ascii?Q?NzQe0M3vVke8te1P1VNIc2zEghKPjLtzPA+lkDVmL1jpNPXeqpLn6ag7+i5J?=
 =?us-ascii?Q?VwBj8wf3Iahr5m9+hC1clBQD0Jp78wMkFK1xUfMeaFv4EGzIVDq9GZCHFg0t?=
 =?us-ascii?Q?6zAuiXZWvs0IljEuPYuReoODoBfHkSp1F2tPpv2n0ErC+ixjWcgNZXxMeevu?=
 =?us-ascii?Q?UlD0O9ej+8hhFpvOX8uROopHQKFEQdvcvKRcvT6S/kXOiWXlgPYYPpdQB3G/?=
 =?us-ascii?Q?L2FB1geTP87p1nxRdxU9WTn77kJvL8vOjV/Zr+8WvUXixcXibY42JN852Sin?=
 =?us-ascii?Q?SBJqKI/0l2sCQibDFsU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be69ca5e-69c5-45cf-211b-08dd1a48f23f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 01:04:36.0510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwyF1vVj6lOaM1+jfS6zQ2tFBC+z9E2Ukr0H839tqHpatyAJg+wRG36Nk2L5BoFxqnfzdcUARhOXMqyGqE37gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913
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

> Subject: [PATCH 3/3] crypto: typo volatge
>=20
> %s/volatge/voltage/g
>=20
> Signed-off-by: Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
