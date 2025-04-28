Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B950BC369D1
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 01:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D88DF80F9C;
	Mon, 28 Apr 2025 03:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="RL0CIsoY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CB2C80FDA; Mon, 28 Apr 2025 03:05:43 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC4580BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 03:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZY33MdYE0bc6iHBY+dHXRdyZzJdS1TTdJpx3LFnWGVqAIYQtWhqzKOEGlKv4/tqlXHBG5DhyO798Jaj+SM6pOuctkJZKFtdNmzl7p/XyKQf7cikEAH0XVnHby38jpCLkJLnlH6mn7Fn7fJ1uxU0NIuTvmm1J9qbM3vanS10c8Jk3oNLLutpxyezzslPSZ75bKKx3HfiwQ01pre7AWbIaFCI3e1uVKrnxgfnYC9HeHnWbHBm5tdCGkwj9xk1wPTg4K2gA1c48aQHH1XHnLT+jdjW4eHhqfKqFxbNjgdic+o75lkgt89Ldjx0lHYb7oTLCT3ks+eBlwL8zgIVPYvYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uepobpARUyeNTO7E9gQmrD5pbdmi1mJzmCgkz1Ch4c=;
 b=WQwTRDmaJ781HsaDGWTjZlcfb8PT6OeU6scTnryz0a0Oz/orbI19n90faksI/+tssAR/AFOMV83HHK/FZXYqfd7tSAo81/k9zlc8bxyXR4PN96c4G6EYYuO7kFUGW7sDw0v0fGUidLk3wDlEqDnPL2iHE8/kOwVDohdba7kVfVgUw2UCbql9dBJADVjDmTzG8ru+5gqLRfiD6GauNejUpAIfJjb5mfAsa0kLkSwcAwlHjLOB5gmSXQb+gpFoAdI/IcUIHegKS5roYhCN7wOt3v7h8+upqOofs27No45ZogaqZAQJ6JBDbiAyUU76DvHhExxYnBRL1IKHmGqdfI1FdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uepobpARUyeNTO7E9gQmrD5pbdmi1mJzmCgkz1Ch4c=;
 b=RL0CIsoYa4EsZoKWnevIE44F2QdBAWvg9/LvBexdQPHYOIG+w3AmH9jdOIjxNtVzZFTG6UEnXitVdY0SsIvfOb86tvG9gUHX+Wk96cGZMdIzp5XP3NCqP9Lz4FgE0c6xtKJZtzg/pJQ11ifXelGhktSwerpOs8tY1ogPytou0uASENCLnuFLlprS3OYA6mFke0QSGC6PgQaefVIsNdHX2AVuRhrgDqM4wWcPsVfQGop6S0j0HiP0IW05n2qYhN6eMq5piqN2OVmVsrDT+AyIH5+U4nPj+RdxLnnHb2SPE3B2YXUaYvBgMpwfR9aRqZX1AZB5CzwfwBM0LefJM8+5YQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10244.eurprd04.prod.outlook.com (2603:10a6:150:17b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 01:05:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 01:05:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Kongyang Liu
 <seashell11234455@gmail.com>
Subject: RE: [PATCH] mmc: cv1800b: Fix build without MMC_SUPPORTS_TUNING
Thread-Topic: [PATCH] mmc: cv1800b: Fix build without MMC_SUPPORTS_TUNING
Thread-Index: AQHbt73X3pmhxH4I8kSyMog3ZzxHFbO4Q7XA
Date: Mon, 28 Apr 2025 01:05:38 +0000
Message-ID: <PAXPR04MB8459ABE3535405A25942DABD88812@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250427214637.321693-1-alexander.sverdlin@gmail.com>
In-Reply-To: <20250427214637.321693-1-alexander.sverdlin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10244:EE_
x-ms-office365-filtering-correlation-id: 9d0d73eb-3ad2-4a83-f5f8-08dd85f0c9d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GoAtTuznFkQw8tu5325qaObHJfX/3zDITkv8FkBhbIT90OQcj/JdV723Q+K1?=
 =?us-ascii?Q?FT57PWvaDwjXAWH5RvGzpzJVzkeNVplKMRRpsr3cdMhL7r+6iCHXuliBJ8cI?=
 =?us-ascii?Q?0sM8UteB1Cx365WygsHC5wtdg+D1FVvB3pz/387UbA0ogKY7StRKrPVbNLoG?=
 =?us-ascii?Q?nlxCfQ3WsQeDN12B4mNZvCcpWG1M815Jwez57ltycl5q2cPuzF0rfd/OWHho?=
 =?us-ascii?Q?wry/FCV+DMdlJpw+hbesoDLlcIgjWmDY7gbDRe8sQcY/JT2MxkUhLvxOL9fN?=
 =?us-ascii?Q?IrcGDlW42+d/A3VbIQUz4OXpteuIGKNyno8Y0QDdqomgFCC5rlHapRyvoNmT?=
 =?us-ascii?Q?LlE0U9Ged47Q66Pqhjf6wWgznLBZyP5N3ISeuo68fOcKwOt+39W4ivB7ROAL?=
 =?us-ascii?Q?noWnx8cpn2Oa9OzGDHTf6/bWLlPbmo/lLeGc5Sx19ayo03XwfUTMl9V3zWBL?=
 =?us-ascii?Q?yeor/cXIpX8wbBQ2J/JZkotgXAS6/V8PD74VrlSUOiGUvnL/lFs/a4xtXHXV?=
 =?us-ascii?Q?1w8UBfw0EI4SHbuV0tuH85eefU8b42mJbEmUbNsM47Pu9tSC+tNVx8vXFpWC?=
 =?us-ascii?Q?fWdYLku92Dx1X7ghngvv9xFKneK9WfzlyfYzdH1dAxeUasnmmRzgxMnD6U7O?=
 =?us-ascii?Q?4lbJt70R2fU3XWdtOjeBFgdp2hevVa9c5O6B11R8ODQzDVkiLgw9jlkwvND5?=
 =?us-ascii?Q?hZU4Vp6TUiaV+g6s+Ue2JuiEmBGps5Dyo/RKUNbd09vtJRht6OJjJLck6Sqo?=
 =?us-ascii?Q?x0AmtzLbDUzBB+HXztiKLQZulEPOxEyepgBZX5Am4QAS7RaBujpeqBdesHX4?=
 =?us-ascii?Q?b1Uidm8vkHaF+dZ1ckFV6xRgCqLlyQfQQgABfHMZK64vhXjVTWjnXMoIAQ6o?=
 =?us-ascii?Q?+TQUp0KtODp1sGvExMx+dtIq3C4eZC/HFtQkGC2z5vMFH4S7V6nLWDLXp/yv?=
 =?us-ascii?Q?HH036HLYK0dspCHS2J55WhABN+wde2C/SwTydLWdu1VHG2G7KjqcAWW4aY9p?=
 =?us-ascii?Q?7QSN+RT9FVVB1adrUjqFW4XfcRmJqiI6wSjnvrVInOLiNk2qPWhw39ILoM3E?=
 =?us-ascii?Q?1GRn0DgrCSTbt+vFDbhk6UuYSb6zsy8dPsPzS9R4QmkoPCmUQtwAnL87XKZB?=
 =?us-ascii?Q?k1PxsbmU4OWlZf07Q4d1oABMOa/1bGjZ8vk73Tx6vlrcW9ZwR/BgPsB7VyEg?=
 =?us-ascii?Q?jbaPeeBe8ieMH+nFQoIezxumhU+UAsUh11mwl0Ms210FdfNxX8r2QDMg5Xbk?=
 =?us-ascii?Q?yGTxkdeMRr3QfTYVX4kyU3PIKy/kwsYpB5kv0GVQ8r13tkRikSh1oPR38B82?=
 =?us-ascii?Q?d4EIAO+02vLLCQgyboh8b7auHrKZ8kCny5OSQhMBGkn43kKzBXRk0h8p9LfP?=
 =?us-ascii?Q?ZQw5qQ0Y0L6l2bobt0W76FgoZspoxTcSnTx+5TKUxs6xM8Zp+09bupgzUEST?=
 =?us-ascii?Q?ndLSqxypZIYmpNz3rKvRnyaIH43VVUlbjoe6fU1fsjvGYVyrMA7YsK+kzptu?=
 =?us-ascii?Q?P//30yONqUYLJEU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HqcxIO/98/rD555Jn9I9Gx5NtsZy+ZiBhHIN09TBJ7tevIwuy7V8hU8bZMg5?=
 =?us-ascii?Q?V4LeDBGWfW+1rHqOqsBnOuggti/cWXV28QM0YKdpvu/Ovd+O9b+akjCBs2i2?=
 =?us-ascii?Q?OgIu/9npkalLubBXEJM2lYqRrTzpIMrZaQYNSReDF8PYzjenw5dxuWhO7W22?=
 =?us-ascii?Q?M7u9RSFzzjhbnszwKzFySBhq9NaCApTfaMWiRILKfV/AggDPVhGni2UwmthC?=
 =?us-ascii?Q?AmTpUyQVDR7diwhm/u0Y9H0l6GLK98k2EMIn5QUt1x/WrqeqvLPpqCvNrpC+?=
 =?us-ascii?Q?nmkgxqDY0JNBpESWreEtfdGAAbxCSxpUxM2vyOa6zzBHYdj9zi6vURo1Fjgq?=
 =?us-ascii?Q?Ldu8VwLQvWJ+bYp9jpBbyS/wlzeGCidipRyb0kJs8OUID3btU2VZl97BjqP1?=
 =?us-ascii?Q?/NuPddDaAWC58Rk7rEnkEvfQT2RB7fMkFxjd1PZjmaxTrIeWO7PXYTEOCW22?=
 =?us-ascii?Q?Y/tFFUTw2RcVUHHL5qAGaw+hiLmMc7owerObg7k8TRmHSrCQvmR6ul5S0ucL?=
 =?us-ascii?Q?3hims1auYyNrZGPVo2QtT5mv3Qd0Nzc2g+pNp79Xp9uM14e51xNvFhfPLqX2?=
 =?us-ascii?Q?37Vuo4IbN3/5HBYuV2fWgSFrZtyJjQ3nyE4/H7nkBGcsSJgPDUV6UbTPsjGh?=
 =?us-ascii?Q?jxcS3oJ4EKqQCigLY5jNiHpboY5EMrcP85zxSpcEL3oRlQBeQuQ1ivLxaVjF?=
 =?us-ascii?Q?h7J8NmZ4/+fDBJY42WxKRAmvnB9YoyWGCAFYbQcxoEgnTx1dSJQnVe9daoI3?=
 =?us-ascii?Q?Swmg5vL+PeiNhNThmKLuHQmikE2RG5fHravHhTxFHa0LF26YuPk5Qsn871+P?=
 =?us-ascii?Q?gIknu445BrQ2eL99h31Zhj96ypD+h2htOTxRDsRW6V6flnniCq28rjPSg9Jf?=
 =?us-ascii?Q?CQgHMpY6hzmsrVFXe++kjISziH6ysnDyNii0MWwY81z4VFxYqp9BVqrqCUsG?=
 =?us-ascii?Q?PkphB8WU3NfRaVGkKWGrrhZYb2NAYBHEUyMvbPc3Z+MYjldRVsWOuREooNd+?=
 =?us-ascii?Q?y1gdnV8LHvPPdvv0w32aYWxOZujrbX65fGrPorAg9gayYV9HjaeBGMpZARGF?=
 =?us-ascii?Q?j22tFNGMRCpIyqWtMMJmCDPMDsSCNVwYFGtjo/c3PUIJg6iuHe/rbKhNjj9j?=
 =?us-ascii?Q?VXs8t7K3cy/t73VuZxTaxP1HVBUcRm76ehMd6xmMSnEpL1zbv+8+ETz0jQnH?=
 =?us-ascii?Q?71xe80nSFXQKT6+I0CA2Jk1V/D2khJyEk8hVmI5e2xvYvwNW98v67Ek6vOvU?=
 =?us-ascii?Q?mC9/A+XErtbI7vvZAGetUOiFcYZGJtCnmtQzaaxa9TQvSBogFikg4NwBKkwu?=
 =?us-ascii?Q?DY9mFInz9sGOWT0nXovljZPLUOFfDODDvVS8rd/Rsx2bBdzWm0AuoXqXZ4Dn?=
 =?us-ascii?Q?4RucF0yDB3HgOePYuxOYYss5K9+76FqFu5USNWHMAo3MGhwl9u1S2qKc8Dgl?=
 =?us-ascii?Q?MzZqHfHjnJRIZbbjvZ7bmiat4SpWAMTVe2cka7Ihd7EdAGRPjx4LEEYBvve+?=
 =?us-ascii?Q?QUIOr/yuyC3WbY4HZTui2MX9eQzT+5dwZ1+aZo5UT/UJN2lMRqq5Ze+TEVPg?=
 =?us-ascii?Q?SIR+qqIRLL7/USc5Zx8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0d73eb-3ad2-4a83-f5f8-08dd85f0c9d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 01:05:38.1000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/rsGrLlILBwgKH+C1Rs1IMJ9zwoiuTOhxgyr5v6or/gCVKF5zQtdCxbGGG5cebnrkOAy4XI65mfTT03Fy8WhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10244
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

> Subject: [PATCH] mmc: cv1800b: Fix build without
> MMC_SUPPORTS_TUNING
>=20
> That's how it looks like without CONFIG_MMC_SUPPORTS_TUNING
> before the
> patch:
>=20
> aarch64-buildroot-linux-gnu-ld.bfd: drivers/mmc/cv1800b_sdhci.o: in
> function `cv1800b_execute_tuning':
> drivers/mmc/cv1800b_sdhci.c:47:(.text.cv1800b_execute_tuning+0x50
> ): undefined reference to `mmc_send_tuning'
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
