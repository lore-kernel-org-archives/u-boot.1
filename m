Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701F606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aaW4Ua0y;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YIA+U4OE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1533880C3D;
	Mon,  9 Nov 2026 06:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X6H88-TPNjIB; Mon,  9 Nov 2026 06:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B8C280BB6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794205636;
	b=qNJxYfFprQK+AyUDYeO28vRZlydcwUbZBLnNAu2QLaCLXQ54d9RqLVBkLDWVD9swp6eJ
	 /AxwCN84vQ3UTmApyFFaTpyBy3UYlT+gcghc7TiCFCD6ATPn+TkvdsxsG0987oJyIhtCK
	 HqoPw/JJNQ8M1XmiGuowZlsBooaGKb3hbx7VmHAqXR1I8YOh3c732XhIfqDbvMl673uag
	 umpUTOYTCmGU6JkkwHF1RJm6yvh+YMTtsdtoEcnN5ODXtw6jKvVvU1xBE/k7c6Z6929+V
	 wb0MEXZVLcu/hafOzLTapWHLAGNZOavpGwULRABN1NwedAeMyMMD4ZjYgNwKmp4FHbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794205636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5jVqJVdwd7gWIkqq5V2yRVl950Hef1WePsO3YB1ShdA=;
	b=HqOt32RqyUKrIvb4mOK17dzkq671sRaSPAEMDDyYQ9bYZve/qMyrj73ka+aJZpTbYttB
	 JLGJHyGzKWMLvB7Mv0EhtXGNvoKugypQ4ieD8iqKndqouzrXL5uHl4ZONxTbRMP7e3e6q
	 pebmKMBBzmBDiaxNYvJWha6FGu5m8nloPNwuxL2MxppQyOy0boWZeVavoYKqYhnBj4gUV
	 S7DsIbJreap0sgl5f0iLYMOCE2dLxy8fTxH3ZQ0mnVRL/U2aq7jxx8MKrLcMjLRmymmPP
	 Si8CJ0xCR2ceBXe07w99XHjdgac1nmbXIu/4i5dhCI/MSqz7pAM9fo/JJbJIRUk3pkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YIA+U4OE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794205636;
	bh=5jVqJVdwd7gWIkqq5V2yRVl950Hef1WePsO3YB1ShdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aaW4Ua0yDQq8s8SxJhG4BEuX79lSmZXz07e1EuMzSaNGNDfy3mC5POvZLAAYd1nfh
	 oHviGseTMQMhomRVkGW9m/1owE1TPUjFZtZYv0/KYtoIABgMJYRBcyFwvNb+AFpR8u
	 Ol/m5ki6Smh3cQxhpLTe8IcTB1zrw6vQal5067OY1a91F6V5LDOaGYA2F+4Hhh0LHF
	 FvntyRgFoxr2WaZXPnAHDsUQ0HRxjmINoYauY+nOw9EfccH4+Kuxn3dmlxfaGhxaqL
	 fWp/VSV7M29daZDwgG9ySVnCiYfKqNPeXbOaP96lQrAyPNUUDdjicS+c6qLhslcOfq
	 smUpoCxsT1BTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B8C280BB6;
	Mon,  9 Nov 2026 06:27:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E64E235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BFC58098C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fGHii3wyZUlS for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 06:27:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CAC0180E49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YIA+U4OE
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CAC0180E49
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jVqJVdwd7gWIkqq5V2yRVl950Hef1WePsO3YB1ShdA=;
 b=YIA+U4OE7vWAotQa1AcTn9pL7d/GKaYb/jipUxTC0/+lCHxt77UOlBQ9VXdMnGGHTx4bF3dAS9k74uHIdt+L0po/yLYuDEUyzbCkJLCbijq/R0z2SwGGGjMQFDg2godNIpQA64oOPOWzzAFzcpvHbXTQQX+DlFgSC2FZDDCaS/tE/iOUc5T1kFWk2D7kak0JKWE05/9jtIW4MKox3VZTAT9gxv84KWjsuuCqmzGg1i5JLCQeeHixFnH/62bvXcllHunLt5YYM1HPPcs7mUXqraxnxUrHk49/KmzM2nFvA7lmw3EZdAOm8R26QxqhQfHtnh6RQq3VhzPf+tQQ5Dus4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV4PR04MB912432.eurprd04.prod.outlook.com (2603:10a6:150:40e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 06:27:06 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 06:27:06 +0000
Date: Mon, 9 Nov 2026 14:23:36 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Honbo He <hehongbo918@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <sanderson@brivo.com>,
 Johan Jonker <jbx6244@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 S??bastien Szymanski <sebastien.szymanski@armadeus.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH] serial: lpuart: add debug UART support
Message-ID: <avFm6PPHfgacEPJT@nxa18884-linux-1.ap.freescale.net>
References: <1B}.ZqLi.7bU8WuTOrTk.1gy2rS@seznam.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1B}.ZqLi.7bU8WuTOrTk.1gy2rS@seznam.cz>
X-ClientProxiedBy: SI3PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV4PR04MB912432:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b282ca-0369-409d-bc0b-08df3e2a79d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|19092799006|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: IWnlanM21wFt0gDGoPFghvJ+6wuIZEFavF355whuxuXJmDh35J7suNHW3zocQHNriZob4pClfPCppdl2q54LoV0jubclO4d1y2z2TYl+c4tkzx0IKiAHnyZrIZgxFqv6uQP+3ob+pMhRN1sjIyXLrdfl2Tvdg9CvNOylTW2Xq9iOQPKKDayOSriBr2GZvFH3Sb1LaRh7WF6vuumFVNawDl9MYkwZJYkvQZNBP1+cGW120d78ZzNo/0riZA+aORqEH9NkOmMxPrD0SUYKEUdTHtWVEtCTQrOpqqyDFk/68rdAivsk6h1nmsdCEczvwXIvrLBC57IxhSIYqjH3hg3fKtOhqiSgS28E4KoWeHa2jq27RgGI8qE5I7hj0Yss+l9QDsPxgyhPku3FAHXlhbs/ZX2D4m9WDzY27EjVdiLojqqQ9qT5rOOt8svHXL2xmHR3by4e5ly2sTL9rHtRaD6T0VMAMxzCjnxrZraSV/SXqdc2aMO0nhs2srqNlY8PP4Ei+FXRYXynpmjflPgztcbVya3UUcBZDS3Hti82JopvUPmgIqIMBucOGeXVRbArcSLog5w3hqSD3820Vxl7KEs7x2bKfes+oujgpkGCfus4FLCDBRQmKvpl+ZIsbh5LY5y8aiJTJwle3u9in/62ojGGqzVWUy0VZn28yE1X8/TFo8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(19092799006)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hHMh/0g9Sep9L9H7aKWjN/o+t5RzkwusCDPuuqHNPKgUThG5Dcx+HN4gCKCi?=
 =?us-ascii?Q?MR5qqCXMSCBlhQ5JgOOXMA9oLc1C6fHl25hgfLJOb/n5dytVEgos4dZI9OES?=
 =?us-ascii?Q?3+hLBbWeISSWx/IKNIX9QoUzitJIZZlmBaPXy7ppOvttf2Yw9qnDF5pHK04c?=
 =?us-ascii?Q?Xbi2PL0BrEU6ByKGmRYtx8Py//Zscjyojt555/6YpFBQQ9MuuyDv4Ucsv5gh?=
 =?us-ascii?Q?2bIO2OwPdrq1l02Pv6lHCJVvfFqtnKpBswpxf8XMDQDkfhSqHt4QRC3Pfot9?=
 =?us-ascii?Q?J9/rWPhv8/Fs5d3XlnblyovDp3mzGEr9tW5spSaRjmA42SC59phP/XjvGfAO?=
 =?us-ascii?Q?R/qzLRXRtH+P5N4XXhFJvpzoq5tsbs4djgrBH7BbgGbM3Ra3Uw83dT6gQJp1?=
 =?us-ascii?Q?+fha9UdAUwXc/RtLf9fjd0wKK8fhjaySh2DZEC8BvTtx2ed5jkQysTSwhoPB?=
 =?us-ascii?Q?qX1yULUVE60i3NhFXjRt/7ZmOdRYUwXgcAtkbdk2mkdOw++0k8UzLRj1qWze?=
 =?us-ascii?Q?bcdoQz3hcrn3yxWzkLMzkRLhJCwczaUb/fYhxI2DZ1O2gXCGawiW9cECRF22?=
 =?us-ascii?Q?DQGVWYGofoxSDyeqPyvWEGmFZH5U0dJKVhxphW5u4h7mSiAL2JjPJ4QMRAS6?=
 =?us-ascii?Q?zn1/Tme8NsdFox11Nj4cow4aiM83s0bp670O6G5O4SX6zR2WtK84XDXks5u6?=
 =?us-ascii?Q?gJEbkQxp0miaI/mJNL0hR+6z9JT/7hNNKzy9W0nDRtTWQ9KY5olDdAf3oug4?=
 =?us-ascii?Q?zGSjdQgbLFyXD+hovpLIV1f6LYyWSPtHI5HPcMZXlSyOlhZBryAB5a8nExbC?=
 =?us-ascii?Q?pICWN3vyMYr+Uaz1vhufgcS678zWhc7KjMdkiJna5rz7jV9hLVvK1RV7LXfs?=
 =?us-ascii?Q?Bl75sNvPdmIKY48rJmiOeOZnmlPRoShirJQIs93te+SokyQCtqd15Y7XB1Tb?=
 =?us-ascii?Q?ivEU+CirsHOVc0VkJPdkDE2V3GC5BlhL51RARREIF/oRhQ/2J2Z5Hx6hXj/V?=
 =?us-ascii?Q?nhtYTcM4LeW8O6IpwTJbZt3UcGmpzHzUYMBa/uze8j0r06AFecfu7ZxJqb+E?=
 =?us-ascii?Q?xrTHj3IPwZZrX26OwO/nfSWMeE273Fcvf8CjitnAvlgKQzBipTYnceoym1mT?=
 =?us-ascii?Q?vkS7MLdRd9ZrM4KYw3E9W3vas/lBeJel9G+HQo2vrIe6O7a0hza3jzSg/sGv?=
 =?us-ascii?Q?PEjYJdOLUreQp3KmSCb3er3kdI5AIccjJifk58vKuAZ7jdQftsKcmTXwosLV?=
 =?us-ascii?Q?JYaUsd2soJym3Bc0XIwNO1+j0SsMt4/6Nrpf/ubU21yPFkobySHo6/OezAF/?=
 =?us-ascii?Q?wzBaxxcFCRwtaX+MheGSF7s1ucwZ75cYEX1EitMovAX8YsgvK6syZW3FFZPP?=
 =?us-ascii?Q?tyMLvKfCNe5meTGxrchYrLxGHMpQwu7h2h4kaNpyc/idtxBms0jbEvVyNMpy?=
 =?us-ascii?Q?twmwKNzF9XsaFw9dl9svYg9RTfCjZg6XX+2UbEhN3Z4pun8Qie4VW6DyftJf?=
 =?us-ascii?Q?JbVS1+Ms3VE3QAX9Lt7HWEiAGmqUpXO2a+zMzLbY0F/H6ZZ0eVRlcf2jLbP5?=
 =?us-ascii?Q?ago6WOEBs588UWUSM8nu2Uhwy0qant0oJrK6Hlg6hBpND0GJUUEAWuBIIWyc?=
 =?us-ascii?Q?6mXW9La/s+jsZNCdAMWyk2w0PkC1e6eU0iHErEL17/txe/XCcd3D4ceUh92F?=
 =?us-ascii?Q?ZD2uFLYSfQHTs43b9BFx1awJjtCy+EYX0PxKXcEekkbzsZPQplTZcIyRbGH8?=
 =?us-ascii?Q?E8aBa0SKTyffXJ0mTTppQKz2ohyyauzFIi8e7xy2QpVDXuznFwxU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b282ca-0369-409d-bc0b-08df3e2a79d4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 06:27:06.8001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCog7ZtZGdVoZLXxRdT+K0dXBTy64aGXq5GPeel+/+Ukc6IaBQ2NujlaQlg/Kj5Q74PlADTY9VAUI6/Aa3/JB8tJYm3lkbTW0d8LNZEixNOWyBxR0CshVOzoA/9HRQYT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB912432
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 09:05:48AM +0100, Tomas Paukrt wrote:
>Add support for the debug UART to the LPUART driver for the LPUART
>found on i.MX7ULP, i.MX8, i.MX8ULP, i.MX9 and i.MXRT, so that e.g. the
>output before relocation is available on boards which skip the driver
>model before relocation (SKIP_EARLY_DM).
>
>Move the baud rate calculation of _lpuart32_serial_setbrg_7ulp() into
>a helper taking the register base and the clock rate, so that it can
>be shared by the driver and the debug UART.
>
>The debug UART is also used by SPL, where debug_uart_init() may be
>called before the clocks and pins are set up (e.g. on i.MX9). With
>DEBUG_UART_SKIP_INIT the UART is not touched there and the output is
>dropped while the transmitter is not enabled instead of waiting for it
>forever.
>
>Tested on an i.MX91 board with and without DEBUG_UART_SKIP_INIT.
>
>Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>

LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
