Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBCCC3DA6D
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 00:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDFD982CD2;
	Wed, 21 May 2025 02:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lb0s+kSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FED282D2E; Wed, 21 May 2025 02:55:09 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DD782C2F
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmG7AqiteFq6YXctZO6MEMJxrj5+aCWnTaH420owOilB7aGqJIjrf/Q+GPquc5XD2cVp/SoOA7PlBVb/64Qqdf6AZ92wFUHYSfaqIFsuVLtkXYtlflRVYPUCCTzlW/zfSRliTdxObtINGxy6AFWzuoMyEA0scQ2OqobDOu5stkAPRYnJMNr2KWMx1SrVLmBoKO6aX6hgAbrl+6E8QSoMKgcg1XjIjwVX7DJrfcrAt/ScDuN6lIQ5X00EaSurJWeF7yWi19io4ANPlo54AmlfeuHyV1J8yC6CfhSUiMK+G+PCicaj8luGgPGcDrenLEW5OLzvLC0EIaD5G5X52aAKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTk7+t1qN5tbXch9mdEfERHjdYPUxPGlR6AS+HKDoZQ=;
 b=gup5lm4R9OckoHhopi9imebozjcQVU2sHxeJ0KD72Xe/l44wPPoc24RGRzuEex6KKCHbEOAEflAO6BiITfG0W6vxVF3dUU6IrSbEd7CbGr6Dte5LASmFC6sX75xndZmVfmoB0KGC+9M9iQHxan75iw6c+Z+Qpcu2KHq71fJI350rrJ+qGmljyfK4xAIcl0pxBeakrjzD5PaInc/BuqN1Cb+LoO+9r4VDnMFy4bQZ2qiw11Y60bHaYcSiweglbv2Ex7nmWVxV9mzcSdLxwG1Dbw6t68ONVG5J0LpOhNziHk6EKmiPEyknMKZyDGPJYl+berNu8u0hHiI+FbKNUCsGHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTk7+t1qN5tbXch9mdEfERHjdYPUxPGlR6AS+HKDoZQ=;
 b=lb0s+kSjZ/Yppyv0I+wrYx0EEdCMAp4sdm4B8dlD7ZK2nMJ73s6nvmypVsJAoDUow3A4kF42h9UftIZS3mgET5SW8oej4ubqeLcM4MaBl6p3FlZHdTl8HOflbrO5JIZFb4mXUfulbZMabki5C9TOUc+BPAfx4BMSd6gBQ+K6UPmqiGOUiIc7muJ+0XY5wnv850QAlnT1lBKpRRP3ddwx7U9W2aqAMhnCezo8MKqpgMPGGmMYpiNhndOghIfL8y92uOLg6GgIQai4pk03UDfmcCApOb1ajDzeflyZYr+MDXx3JSl6/1tocDYG+mL//WhXVoQGoZwZEzLR98Yq7JWeoQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9961.eurprd04.prod.outlook.com (2603:10a6:10:4ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 00:55:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8722.031; Wed, 21 May 2025
 00:55:05 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Judith Mendez <jm@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] mmc: am654_sdhci: Clear UHS_MODE_SELECT when < MMC_HS_52
Thread-Topic: [PATCH] mmc: am654_sdhci: Clear UHS_MODE_SELECT when < MMC_HS_52
Thread-Index: AQHbydrVrloYbEIh1kyrFVSw++09DbPcQgqw
Date: Wed, 21 May 2025 00:55:05 +0000
Message-ID: <PAXPR04MB845999031A8017815D3B8EF7889EA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250520225915.146026-1-jm@ti.com>
In-Reply-To: <20250520225915.146026-1-jm@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB9961:EE_
x-ms-office365-filtering-correlation-id: 08ceb39d-8664-48e8-b931-08dd98022003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?jxCRaC6/hiGnkfbfx0HuMZuDiRX9iIj7CWT8tBSmqw+szt1HLyjiJd5bEk/i?=
 =?us-ascii?Q?RNWM4dX5lypLnknqjwG0GOc1gM7FG53/lPMSzP56ZVc6uN6MNA+/s0dKJvnu?=
 =?us-ascii?Q?RNTkadcPPC3WN+DEImoJQVo6WRoZOCEL5iK1//r29/RfZX7lHX3+yo8abkdp?=
 =?us-ascii?Q?/UCqImyfLTEOxj5Z65/N1gUUl0R5+WkuS+mHLWHPP2b0eYtIdV+EhnuO22Iy?=
 =?us-ascii?Q?5AGYDsq9pBqruCzDZUvIIwq4fQ6UkfCX+JvZBvbvGPqX6Ldc3ikist18KGeT?=
 =?us-ascii?Q?0T9uxww4ziv+MlaO59ldUSQ6sWE9Ee/tHLuSFX4F41O9FyUeFQvK0ohkghe+?=
 =?us-ascii?Q?WX/u0uL1yPTuilGc9DuAL1HcX8iEwSlKQ3HwOAVObnKHSW4n/LhSTR6CBPH+?=
 =?us-ascii?Q?t6YvW70jSUqukuGk1uWkxNjYj+c1R5IpRLXlM1bcwqMT1pNdzsSM7dqa92Gc?=
 =?us-ascii?Q?cn51CtZBqkdJxzDbS4it+r8R3JrpNxU/WtyiqSJRl4m7s0MJUTVaEi9nGk/8?=
 =?us-ascii?Q?qrulwopr5NVL8e1e0KAHpZT1qeDFN3Q7Aqme8ZjU6J3upL7yp1+EHb0eH8ok?=
 =?us-ascii?Q?NLyLdWJeEpJPIa33zeX4pFXwMJ+kpJkmb/yzIxwqcLY9Y4/BatNyL7JhP+9s?=
 =?us-ascii?Q?eopkdr8/8WAp8PAd7Ablf8eCqZ6t3SXKAjJBmEMQ6mW15x/RXys7o9CZgaf1?=
 =?us-ascii?Q?5SoeBlGgv1q8aIf1/mcXent4iNn7MJl21XvW/a5I/gGN63tG0BQyUkNJ0Jn2?=
 =?us-ascii?Q?0gmO8z/q9oR992uBuM74PnfZBzoOxsdb7HnnvaWVvDowDoO49Ht+CIUWiXOE?=
 =?us-ascii?Q?81MyXNMpHf1ooCDIEMX0TXQy673OmOtRJZn31bNzsE/wuzwsBYif1b0tcdg1?=
 =?us-ascii?Q?j9cfG+3ARgN8AL4Vuf8iAi84l/TL4LLay2ANzmTpW7Q/EtJFpOhCLbI3xfbq?=
 =?us-ascii?Q?rluHAIuFtBfE0UAgTzvVHUyWYu/304w/e+KpCz1NAckq8kJgQQSCAZdGly+r?=
 =?us-ascii?Q?BpOPOSekNQaNCxdODMJxEroQE2rT+6sNAQ1m2wbIatP5YikazW2rfu02zjhU?=
 =?us-ascii?Q?/JXiTs+MSyy1LbDKd1jsiYb43lv5W2hDd4B9VO8oVPl7e6VP38og42x4N8V3?=
 =?us-ascii?Q?TC9Ix4QW7TSqQTlpuFSZGRvx/6US6Rsi+qDyEg1ftu+PBqTUOZkIspmbNDCa?=
 =?us-ascii?Q?B4FtBPt3XldDmtWUNrVIpJ0wTJDp3BDfgslTvkq6siEzmBYUHQra5cpA1ZdD?=
 =?us-ascii?Q?I6dRP/b6OqPhrrVL8Cr/AZh2wpam+LHjcYOJcwucwbDXofakdg5MjC2/SNnl?=
 =?us-ascii?Q?2rg+W++Y8F0wUy0iMQBLXaTROgqkdyXGU6SpNtigeH4f2+w/97lZJuIc/ebc?=
 =?us-ascii?Q?ORx/3Cxw0re8RoQa1uGsySNhIcQTUSwhgQzUeSJriRh5//XaLXKkghAUHrRL?=
 =?us-ascii?Q?t/dq70JgsNladrDAs6jVWZsQnDPt+5td84JcEmgZC2sU9EQ5bMPYfw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/MV1cKAfIPt99yy5OSfWEq+mhBqcnA8qWDdeMidFqUR+M781cM5/WWPjzwPL?=
 =?us-ascii?Q?8QaW+aH+ZlGIkQnyE/u8EGzZ02pOeFWSFLF4SxRy6APIR1Q64KxD2/VawhZf?=
 =?us-ascii?Q?R28cbgXFQOo1SMzqWRJ5s2jEwHfLs41vgnrkKhQ3Jt2s9u4k0Mr65aV2SpGB?=
 =?us-ascii?Q?i344irju9qdAsuvaQi8AP1bxh+6m/pwQVJN5knfa1qlA5ddcbXzPwj798rXm?=
 =?us-ascii?Q?aXlmp6simYsbDPkUpK7DDnqd0mNhKoIz6kB5uYd7+jZKZjyYkFbYe8gCKfzp?=
 =?us-ascii?Q?g/KsKCyUmYWxuHv/DpYjgWFz5i8nGLyCNu+qA9Gvxe+5s93OBFcKkh/1U989?=
 =?us-ascii?Q?bLSQ9a4m8uquJI6WUG7jSJqxUvOxDH17M+2j13rmqFjj2yybIUT9kmHZwRB5?=
 =?us-ascii?Q?hImOJqs5Zi/A+mXJiaKMsFRiV4x9Jbd0o/9gmYb1bmKUOqwcw6L367GOvsQs?=
 =?us-ascii?Q?F14P48G29+8CKNB3SlnqnzUq72OYQVxYK0GWzlu88mxXE9wwWn4svfKhdA1f?=
 =?us-ascii?Q?36kYkwAI6mCUTKrbgfo1F1+6Q86Hj7WvRF+qEVqZcxFYPbLJQjIk9Q13ki/Q?=
 =?us-ascii?Q?rVrtp6YDnaolb3O/Uejkh+HISVlNjo6VDJC2J7duie9o4CWycQ+1BVGUwH62?=
 =?us-ascii?Q?7hjFyYOlUApIrrkFn/EyvWk17iFz2qaoyvrQNcP6tKL5ZHdPDOG9grDmmLnW?=
 =?us-ascii?Q?wAL9gUvjcDhqqUxEYBZzfoZbtmb/JQ5jvNIveQmmGXxteFrtZXjk961msBdz?=
 =?us-ascii?Q?0iW7fPBzLGKYTfOOeMskAfoPcosjz2V+xkfcVD8/Zf0y+Qhuzof4lIpXsHb/?=
 =?us-ascii?Q?mK12wWYRxei9uoALsHl2p0HBqxjB6wbMWnIIwjrEm/KcVhmFckE+Px1PbSCc?=
 =?us-ascii?Q?fvd7OR2QYC7p5EpIIohdxPsn1hX8yBVQDKR3LbCJbf7miKr7SbViacrVHfK3?=
 =?us-ascii?Q?9P3dcah7mkiiJzWAhzP1It/TpjWyh0so4uXVURdiNJJjM15hGjDXDSSqIKLu?=
 =?us-ascii?Q?ifGSbLHuRhnap+3qylhCmVYj6xFrQfShdjzCNsMs9o76f9rCaYaEIDh3GfGk?=
 =?us-ascii?Q?l1MBg/k2bajozQzJzGyn6DQTMZJMQwWKdti6/2iiF8XBiOupFfmz7+Wp4h0W?=
 =?us-ascii?Q?2lP15YivUOgsai9NLhPUWQQTdWUyFpUtW65tGpb2blnD8CLYCBWxCVEarxxJ?=
 =?us-ascii?Q?tkpKNk72drilqIUjlmDHzvUgSfu8DliB8br06LC+l7FY+HPSBc2YwckK6pjn?=
 =?us-ascii?Q?Njedj9ICaZCll1La/zQfsPHquHH6a9fAUnGGioa581lLOgSYcTvuvljU4np/?=
 =?us-ascii?Q?rN80je7JYwskTPJB8ZlPUJHZZJ0DHw7g92MpQGH3e0FjN0PC76lDwtgDS1HD?=
 =?us-ascii?Q?4XqdRudPVz7vAw6qUiwMdopVPTsCF72wRK7iuI4EqkioRDO2R1ZuFdULjURN?=
 =?us-ascii?Q?lfPU+FgzlPEh9u1JzwU9PiP0ucTMNTUg/RrmqRmnqmRPn39aZbJRgValcGla?=
 =?us-ascii?Q?5TE+ZcbNoN+0lYfRDR4e8m4l4ra3+o1rygUAx1K2jIL9lTgH7koAAwBWzjOg?=
 =?us-ascii?Q?yINMnGRascweiYYrCow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ceb39d-8664-48e8-b931-08dd98022003
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 00:55:05.0609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cO1iFwUzF2kygdITyD7W4qp+7DdsZSiR6Q85D/ovR7RsNiGNFIinIcOt530jvEbrlvlGSsW7X3qWPAgtWRs9TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9961
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

> Subject: [PATCH] mmc: am654_sdhci: Clear UHS_MODE_SELECT when
> < MMC_HS_52
>=20
> This clears UHS_MODE_SELECT for timing modes < MMC_HS_52.
>=20
> When initializing to HS400 mode, the host controller downgrades to
> non-uhs modes so clear UHS_MODE_SELECT at modes < MMC_HS_52.

Typo: '<'  ->   '<=3D'

>=20
> This fixes eMMC writes on j7200 EVM.
>=20
> Fixes: 6067aa66b3bb ("mmc: am654_sdhci: Add
> am654_sdhci_set_control_reg")
> Signed-off-by: Judith Mendez <jm@ti.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

