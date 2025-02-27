Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03978C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A12810EA;
	Thu, 27 Feb 2025 13:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="imP6xMvu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD59811B2; Thu, 27 Feb 2025 13:11:31 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E92B810EA
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcY9j0JCEHN+nOECj542lbLCZgd5I2GiXR07BUigs0mUbx0Ag5OYYcrz5FVKFyOJYW5iSTjZwyHrx+Yz1XMWutsKhUlAxSiHOl/ogdwYrfmFIXTQQx+cJyo3GjayzhIuJOD1qMz0LBddeTVBUqmc0ytlY5cCIdnV+UAbwHrvTsd7zfgAZDEuEx74WZyJtLqGuYwyTuI/7WDtF/7DRNH0TjMjqIHbhRBiQGeh7DdQrjHb2eGjIaqvro68wMorCVXijTfET6ycgwP9LHSKDh69AhcZnWrvCAOwdu2AbH/ps4qjtr55N2dALbhASSBpMlhh3p361GoOW+g3F882WIUj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCmuCYE/Biq1Txq+t/8IEjty5gB3XxffLzz8qKxLMFI=;
 b=vJBWSCdnlwrLEXaCnskf90qptHShobJq3ePFMPWSa2D6mcGdXmOWpTm9L6jNLtvPfEqUXCxpiyHKBipAG47nBYZJLadSCAQkeOQYmKK79ZvTBLWqzfh7npcltvlZiC1ApghgytvqcMWVrpzMq3qV1QS0IlTkQEKi8M4h/2VQhC8jWK6hQq3I5OKl1ZfJFnJ/PD4tn8iDaP7gu3MWC9vZSX1cMmB861g1kipIl/o7/92W14XMUNS6bNEfkrGPCiowOqGOqTn6yhCA/bTPEgX5fAZ+8/nQTnJbOWUog00jeUKjUw+6bema1CAg+vERG7Qjie+8ba4EdJgCJXL1qyAtZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCmuCYE/Biq1Txq+t/8IEjty5gB3XxffLzz8qKxLMFI=;
 b=imP6xMvuMYvaP9vMw5R7MmYX9Q9ddImxjg5+12Z3EvxTJ7oyULwv84fF+NiAfHZD2qdA3u2klZSMennbJoqc05CQ9ko2eGvgrUEmoHMmnPPUcEd4dZMMyaO1cOd2sFOx6ZULLTHogQkX77y0OWvHKGY5/38hLukPERsL5xKKEpEYao+3Re0nIXdYsA7MbyrdQ7PylfAyADTF3BqP21Nv2ESGanwIqtRCl8ngjHWNzHeCBwS5pungiPi68zVb0LCpuwF9Wa6PdKUtX0aDqbK06eB+nBqq6OA0SClCibsp1ccsjG9yKEyWeMQRYwc39yprLNsuuAF72FUvbuigL0LQnA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7596.eurprd04.prod.outlook.com (2603:10a6:10:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 12:11:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 12:11:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Fabio Estevam <festevam@denx.de>
Subject: RE: [PATCH 2/2] imx8mp_evk: Pass kernel_addr_r
Thread-Topic: [PATCH 2/2] imx8mp_evk: Pass kernel_addr_r
Thread-Index: AQHbiQJ9o6yJtg0uQU6jsVgQh3ncC7NbD1+A
Date: Thu, 27 Feb 2025 12:11:28 +0000
Message-ID: <PAXPR04MB845970334D876E40BD8E594288CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250227102916.164418-1-festevam@gmail.com>
 <20250227102916.164418-2-festevam@gmail.com>
In-Reply-To: <20250227102916.164418-2-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7596:EE_
x-ms-office365-filtering-correlation-id: 04079d91-8bbb-4a3b-35d8-08dd5727dd31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UBLJXR+9OYJn9LANJKU2Xs/XLpSa6X4QA+Xh/PGkPYNp/gZNf1p9qi7C4tFM?=
 =?us-ascii?Q?PivvhOEqpNx9oI6wCdzI76k22JB1ZJZKvgqeKe6d58l4OReNWe0UloyReEqE?=
 =?us-ascii?Q?+V9k7OTtLA8nHvGahvx1nLpmWqlu7Qsxf/+h68DvjwWJ8f+DHxmi1g7V23jH?=
 =?us-ascii?Q?VLK73MN375kCm1VShupvk/waXRH9KEHjTbVfYhtJTFkr2BzcVNIBP6czBYix?=
 =?us-ascii?Q?PUtM4lWKi9ZCWpKKPw/50IkhUp1ghW5Coh3gLLN4b+7aKyHtr8eU58o5Jjk9?=
 =?us-ascii?Q?0k+DfiDMiEy/aqq0iuoUR8qqpb0GHBM4YdKsY26Nqlx6sRQn7sHqftJVOx0L?=
 =?us-ascii?Q?81emsoIE57O7NKbTqqTgo+MQtRd9d9/+90rEBF/l63TGTKlEDjpU2vTtT3+t?=
 =?us-ascii?Q?bH46MFtIzcldvtuiRGRJ0N8Xjm3KFSF7j5o+5I9beUNtGVieoX20owDzHdSr?=
 =?us-ascii?Q?9uXNbIPI8PuOqH9SJL0Fy7r74q4KaDQ2XYD/rSraRvs7mh5lDEN9IOIsptM3?=
 =?us-ascii?Q?5OoFP+3SyWD1iBm8OoA98hExfkbT5GAsCA0r4yb31/tCTztePvkCKLhhFFYd?=
 =?us-ascii?Q?4BgEKjWQIvBOfe3i6kxrNvDfkK5oOcH+yECFo8wdZdr23xilrqnOY2w5QRHx?=
 =?us-ascii?Q?vxerdIYRcx0pJ+sLRl383iRF4eM/S968MbL/CB6ychqVSObHYzef2JkpA6uD?=
 =?us-ascii?Q?1PdHAGIHUcNtigbfO4AiIiXX+i1gXWqJ57sOvrt45HB70lCTy9PW7N2paSKw?=
 =?us-ascii?Q?tEHu8/JNjBrq9fxojjccD2B9rT4osk0MLxp2NOE86VoBUIvbOGwTXPdyXKG2?=
 =?us-ascii?Q?0M7BG6kKzD8zShXCrynwZpZwt3+5aUep/fYaBC5croCBsKC67GS8ZTcRM6H6?=
 =?us-ascii?Q?4VcVpItqEC4MCNiRCcxsGxp+6ym0GxNicvu/1vXFMDn19W7I4xmJhkai8wi1?=
 =?us-ascii?Q?21qGnRDuug0hf/3hZheFV0r1xZJQYMqfjcKkoXWxzUpXSxyAaCJ6HMyVgMmO?=
 =?us-ascii?Q?CQmeJMnG94xGdeiN5m6/6sqSxo4vACo1oCyON6005ZwbVP1CAN1sV0HlhcaR?=
 =?us-ascii?Q?PiRa7svax7sS9kdWjvVSZkhRhlSH9DoaYfd3XvKhyCXzSKM56sDG4BZeEWbh?=
 =?us-ascii?Q?U/1LbuyPVVwLeRVSJCVPVs5wPKSmSqapn4JyHyKW0oF2rqgtz7FI3ky2TtNP?=
 =?us-ascii?Q?MOsLwFAfLO8jYFMcl6JCCN+8B3zDdwlZG+oy+W6xB19vYFiTfAwM/zOzDGGz?=
 =?us-ascii?Q?QE1z6Np4KYFshEG69K7k7oKXABOiKqQ1zrEMM3zkbYqIogQXFsl5fmfLsNSF?=
 =?us-ascii?Q?u1ljylQ/hfstzsVsb7rJ5GNaMTjVEAnTnrfGLdyuzdxNJYeMorCLkHeEHyAH?=
 =?us-ascii?Q?lmBL+QOqfy60kgBpNkSTbKqSdSFuprvG60Sp5O8xSABuV4Aaa3FO7P2WG1wX?=
 =?us-ascii?Q?CyZc40xzeoWRZeh1E/dXIv7Yipec/gif?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lHKlXNfO8mQKhS8hJ0Qs72yC+TqVGdzIvxDWpwtBpssr4sUvMzr64LlcK7+a?=
 =?us-ascii?Q?X3TrIGwO8hq3pLsMX2czDwTiFgXqvGU7hqodqD5A5oaLo+UYG9TJSXkzQGnf?=
 =?us-ascii?Q?qBQ/ael4pByWUS/+z8LJhh25/z1zkO/eIhNppLG5GSMLR5dUMhGVkKq0nV/3?=
 =?us-ascii?Q?wmEZh3UP9WS1HErNWORHNW/RhdXES8xD26giOGtDq4f1PSOVGOMQ71Tktreq?=
 =?us-ascii?Q?0fyF/yYryI5taQGAX2TP+VDGS8X/wFhBmL96dUXN7mGueNYUU/7Ewdwboyir?=
 =?us-ascii?Q?4pPxsTF6G8IqG8vUZlh6ETgmMowKlt1x6HJ8+x6o5s05b6BLn0A+Y45aazmx?=
 =?us-ascii?Q?6t5t1NAODBu1n+s3hYtQZHjgBkGdnmu/jmHfgGsIYy/XAAyA67eeV9aNWKhr?=
 =?us-ascii?Q?crWrJTxT8WkLT6C2xM6bPgRccnQDvW9Utn3YmaLK2M55acEzV3RJar+go8nI?=
 =?us-ascii?Q?7/NQC5ML+n/DnmKQhTMNpwjImg8UNlSd3C2RV3h+SowrvZhKDEWOSYwSxpvn?=
 =?us-ascii?Q?v34932SwA+Xpn11UcLYPDOKd4CAFIgY8AN5fYo2MpFkVp2AD2qROtfmXOnrF?=
 =?us-ascii?Q?r4xwEtS97nV4+CE+ojsboq0cLTAsKXONq4XrUltHy1ueKKgqTKnaZR+NxBrK?=
 =?us-ascii?Q?/7oSZ5GpMsNTs2jYttaF8TQp8ZJXV0uzbTsnMdehkXmP8u2bEc5gu2ilEEoX?=
 =?us-ascii?Q?pyy+hxjY6LX8N8qEaGylFeIcg2xflsyut+fqGZFwf5jMXMjnHSYD0CsjGHoI?=
 =?us-ascii?Q?2m+UqsVDDgSJQ492a19iv7PWq2twlSROyZryRiywPTSSPRqNkLPeotDjCUxG?=
 =?us-ascii?Q?i24KNfIWhGYKTdgeoumZ3IMM+LOaN1t44F+FzOlqgaoVjdiEc6IkWsRrvb3C?=
 =?us-ascii?Q?ixMtWW3pUGwZp32y05Zf3AM5C6eBZilnOT4SxeqMSL71t/BrchYkgL7W7X3/?=
 =?us-ascii?Q?2QPnrbhRw0tr3puM02Fou0A1sKHuRQQjXQaO9WPQuCQc0owJJr8kSKZdqQH5?=
 =?us-ascii?Q?mOjbDdDAZ+yjJwusPifN35dp8iek6WOmoXzJm/5HjVT/+f+Qm2RDlojyYkM8?=
 =?us-ascii?Q?2ZOJ8SdvNc9wzdNNJ5aL1cVya5dhSwZlP/GP3skWhSOUtowv9/fK8x8nZl53?=
 =?us-ascii?Q?M1Or/ugj+Gn4nqM7HtDfaFdPKVjccHMrw6v1sB1JnQzThpmoZgKFEWCnkGEP?=
 =?us-ascii?Q?4CLhW/SoIOPi/lqHJ+2xF1vYs4yrNHyfQnxiS1AngZWaO6m6FdJLEb1WV0J7?=
 =?us-ascii?Q?tFvr7bwzZ0cSr+lsfxt1hd4wmAUJ/qbM5+zVMShY400YMVm7s5NTpHjYA2DT?=
 =?us-ascii?Q?V0lS5YvYYZ7jEeD3vOZXGJIPmcoZ0kS0nSQuG6b2ZQYnR0kw9YpDiF1bP3Oa?=
 =?us-ascii?Q?oPj/d4cdaYGBL9D5PZtzOAqv6m6haOEipJJzewnJD8U9C1zJQ3Vfk2U0M4Mn?=
 =?us-ascii?Q?fbePa9hgnpDs/wRKSxq1m8yk2o6389NpfIKuK8RYvkbWcDTiGuU6Y+3tgx+k?=
 =?us-ascii?Q?v/owENaSEtQ6No3ih9L5hdgUfp+1/xegkXDi/NpPsa7D4dio82gD+XPchPQC?=
 =?us-ascii?Q?ev2AX+JslrzejZUHt1o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04079d91-8bbb-4a3b-35d8-08dd5727dd31
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 12:11:28.2153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10HQKKh9gcfjI+ZAtiQFjzKs7Gh+5YIHQtJyxRERAT6XrGjKiLymJVqFMQKYVPPOxidJxeFVJXMSpDEebkcRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7596
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

> Subject: [PATCH 2/2] imx8mp_evk: Pass kernel_addr_r
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> Currently, booting via bootsd fails because the kernel cannot be
> retrieved.
> The reason for this is the lack of 'kernel_addr_r'.
>=20
> Pass 'kernel_addr_r' to fix booting via bootstd.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
