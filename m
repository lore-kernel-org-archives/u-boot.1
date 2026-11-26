Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BD0606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=auHvfs0j;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=UATdwmjz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE23B811E3;
	Thu, 26 Nov 2026 13:34:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rfU1PC9kUg3X; Thu, 26 Nov 2026 13:34:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A0218811CB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700045;
	b=ZU158M2vX33k6pNRnpy8yDIG6AICRwprd13j8NwDTzkI1vnfUmBuqEO2mrLH3nS1aIHu
	 sbgaL9VH4bCisGoG5/CxRs78tC0/E+aY2Uq216M7ACNnC7LjLNoUYleWspGgJInNfBwJW
	 ClJxAXbRD6Q6VWigJytmlNtSJfQf3IUaXki+gMaEh8GjyTmCs8DitdvoPVEozcxKdFs30
	 q4WEdlzPnWMMZ2jLKMcLOG8Mft/GdZNgISqXW4qFlGaINqdmOeh1gYJ+6mQMVn6FkptrI
	 UALTljI7WrtszItPxMumIQNQsh9QGDggEXZ7L1zRSwWzS+T/QuSzQcPE2Q47qSPqfwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BCjf0vMFR6spw48NruZU2L3nYl3dP2YpiScCMjS/eKw=;
	b=qdUGVLzMJWCnt5EVfpkQ/mM1aGlcwEihM0+XvYlXT1biM115Zm4oZWCCY3y8aebkHxrW
	 2OGyg8TfMThSnvCwmoOLGDYaTxT35oYTAak6mgprTfTd3+AXBcL0XpONEGiIGJLbWTYCJ
	 aU2N/3O2JPx4xx4sNGGDY+w6vKqpz+Gr0qn6k3HIHRGozzLBYCY+AIhZmpNoxsUjCwX5w
	 7VjLYi9u13XIBDv0UoJ33v5IUEWS0m3oKzrmyW5MAs9SF2f4BE+1OSDdSALo3nnA2U2fQ
	 WvKqlqrsBhFEMQqwm7xyrHS/4zukIDxmGXXFcJFEu6qMcv4ZY8wL4qwR9qm2L/fwpdg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700045;
	bh=BCjf0vMFR6spw48NruZU2L3nYl3dP2YpiScCMjS/eKw=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=auHvfs0jdu1/J81DQBYjjFNzc3D8tLAcb+b2VANqWFpdVzWTphbM0ionUL7udBnOZ
	 ZkBp3uwiLq/1pQABm1d56LUQn6VXx5DY6ZpocVy+/qIrIawu975y5rUj7y4egc4QWk
	 ZX5i/EmpIAWOnT6YdWEk2d1YybSyCZ7FlpxY9w5bboK+8/tHKJvDusdvdlM7iO4syy
	 jaxkaMlfk72ZBlIjppZPWQrEMMyWTHtlyeSFLkxH8akkNrW/y5nfuyNW9DQUC8ciKA
	 ejiu+T3tm3lqX5s6PzCkn6nnt8eEDGyfSGA9j7O05r0nIAKVPsM/KqPvt1MJNPeuqR
	 yulTyyIWYN0CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0218811CB;
	Thu, 26 Nov 2026 13:34:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A8FA32D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C11C608BD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VA1v99g2n1Wg for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 08:13:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 124A8608B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=UATdwmjz
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 124A8608B0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCjf0vMFR6spw48NruZU2L3nYl3dP2YpiScCMjS/eKw=;
 b=UATdwmjzf2MU5ibQmip+0QTM4DCwK6q3SjHXch2NMr0fQsFyAMSGisXsTl0R+D/ICWmpA3il+7krUjOUolbR75vemOql7syZVisLYgYMLdlbCBsSPRgNuo9f8sVl16e+zy5QY7JVUWZcu/xp8J+pNorWgfFT+rPa0aNSDN/aD+XeazCWMQe1/OZkztopSkRJxM7AaeqfM131cGzw75P614FFAcNMY+wep0/u9463jg3Je9XfLmtH3GzerO3FrQj5VzWEK7F1BNLzrL322E8Ls8ScUvy0ivQxHIjorKsL+nMo/lSQNhtbcdnNczd22l0rZDYrSuI/bJkPCmqDYHEa7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DBAPR10MB4076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Thu, 26 Nov
 2026 08:13:22 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 08:13:22 +0000
Message-ID: <0a795dd8-8beb-4c93-9dd5-2a13512f34eb@kontron.de>
Date: Thu, 26 Nov 2026 09:13:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] spi: spi-mem: add spi-mem caps support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
References: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
 <20261117224236.3150882-2-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goat?=
 =?UTF-8?Q?er?= <clg@kaod.org>, Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Daniel Golle <daniel@makrotopia.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Aleksei Sviridkin <f@lex.la>,
 Zunyi Hu <roberhu001@163.com>, Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Mark Brown <broonie@kernel.org>,
 Yuho Choi <oss.patchbox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Akshay Belsare <akshay.belsare@amd.com>,
 Cooper Huang <cooper_huang@aspeedtech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Cole Munz <Munzzyy1@proton.me>,
 u-boot@lists.u-boot-project.org
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20261117224236.3150882-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DBAPR10MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b20cf4a-f51e-452b-8af1-08df4b95231f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|56012099006|260925022911599003|260925021311599003|260925021911599003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|18002099003|22082099003|5023799004|11063799006|6133799003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: RYG0NEkk8Jz02BJm4+598DO3YIyk4Ge3Awagd+Vr6aEtdGbbmNhRcM1+sFJrE7RYRDQNLNFJ7Iak6bdcTUfkAd05chIgE0lEvQNnokjw9K0OPyA2jWizzXmqtye8ia7fS9XEWDzYHrlZlW6IuxsxCvz9N3DwlP7CtOdF03+KRtJmwo5d4hKMJ7cN+nfpIRIYDf+LKjknrSOnbPTWJqGzzNq7ZEnawcWpqc44O8N3FIwzSIbytyEq/WiLj9H+wv/Y/Or3VyQOJLd/fZXQXQbkAQkcdDI38QXfcy87udU8iwsq8Gj6zRB5XvNyQuyRxKjMYfgxR3Pjlc6OMG8Rw9oxWWrBMJfTqbXmdKjCM/Ft98zrMA0WhEAkbxFS3cGSEpAIFndniiUJprsopOlDPl6bDnuJzxKV4YXJwcLjKbuQ63JI8auDEgvEBZNeuErs/pVfLM+WzYOYel1RkIQvrMMljDDpx+ucNydkQKAE3Pqc0e2qHcBcV7Cv1CBSa/Pw3ck8v8/k/yB+qQmhZQDk+ChAtArxbMXRkJ30M3dT+4eneaKT+IgBFdzLKzIGzj/AyvdnRg7zsMqkPTpFt6g4NWbWiCY01ubaWGSRPuzssO2YoZtJGr3LACkYFJaVsJYT50jAVCDJ2q17aLv8Y7aCsUIxPLNL9CSUUMkrY5DzpVaKeS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(18002099003)(22082099003)(5023799004)(11063799006)(6133799003)(4143699003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0hHU3c5Q3BYN2h2YXNyQ0RyNTFxdEdiSnpmeXBPSlVsRis1dDhXL0xCSlVP?=
 =?utf-8?B?TEdKME1seTl3c3NhQnVPOHQwTXEvUm9zbGI4bVNFdXdDVHZZM3VXZjByRHZ1?=
 =?utf-8?B?R0FHcTFMQ2RRNGlzWG01RnBJT1UwOHJvZWhUc3krWndYZjJSb2JQdVRFM3hr?=
 =?utf-8?B?b2wvQ09IZW9QS0xSeWgrYzNkMm5jRCt1Z1ZvTGE4bXFKZFdVbmQwU0sxLzNQ?=
 =?utf-8?B?aldueEs0QkFEUnhQVVl0U1BlL1BITy94eVkvQ0dKbkFEUEUzWFBCL0FOTzBZ?=
 =?utf-8?B?QnlwUG5QMjdROGN0NUdzRzVyVEMyUFNVcjJCYWdVZ2VXMTN5Tzh2SFdGVnpV?=
 =?utf-8?B?aVZTVi9ORUhOZDBZTlRoQ1VIQVpFb3ZkQjREVm1SaVBQU2tFRTh3cDhlSk1j?=
 =?utf-8?B?dE9oZ0FLRU9LbzlKK1dUR05SL1JMMkd1NE1qYVVFL01TSEdWYnk0Qmt0MnFn?=
 =?utf-8?B?eDNUT0I1VU1LV0Z2cS9YQXpXeGx0WXNMWlAwakdnWWw0NVRneVA5ZmZtWm52?=
 =?utf-8?B?WUpMK3FUUGpZdVdDaldVYkhCSkxzQkJ0SHhobmJwNXByb1d0QjlRU0s4djdu?=
 =?utf-8?B?ZDJ1MDdNdHlGbVlvSVM5STA3RitpZ3c4TzNZNzVEV1p6eGVxU01PK0xad21t?=
 =?utf-8?B?M1RQWnl1SG41Z3ZRRW1qVjNBakdNOFBGUHgyam5MVjIxNjJHSlg4d2tGQVNN?=
 =?utf-8?B?M2g1alMvS3JYRGkvQ3hBTzFlbmc0R1laeVFGTzBpaVZFUnVHQW9CQnNZam5Z?=
 =?utf-8?B?Y0laTmN5Z1poK0pOYW9hZ3dOc3ZIN2pGL25rcXJFb0dhclhNUGNZbG5nWlVJ?=
 =?utf-8?B?ZytmbFZ6bStueWs0WWpJUG5vZmdyaTdXYmJPckw3NmZGZnBKMENDMkNPQVR1?=
 =?utf-8?B?LzJEb3BqODErR05Zc1p6SWJ3blBXMStnK0VkOFdqOWRGTGFwWnVWdGZ3Q3J1?=
 =?utf-8?B?S1ZEN3RUN3RMU2xwUTl0R0pnWDdDcDNaM1hrS1k3a29PZzdFVU1jTy81bGg0?=
 =?utf-8?B?UFp1L29nNkVLSWVxN3pzY3dzR2xYaWxrcFppOXk4dVYvTkZTbTIyeTduQTQz?=
 =?utf-8?B?cUpzTXlmbXJZSklNUHFNc3M4K1Flc2hWMlhTWG4wSWFqNmIrZHNleTlLOXdX?=
 =?utf-8?B?YWh4Rmd6Rnc4anpRVWl1SXU1YkRpKzd3OUhOKzIvUVdUSzJjMGQ3SHhsaTAx?=
 =?utf-8?B?VFBKUmQ1VTh3OWE2MnNFZEpCai8wUmJuRXMwUWhmSkRmblFhTjFhdnhJNFh3?=
 =?utf-8?B?RTZXeDROWFAycURiTlkxQ2FrZUsxUnZ3QzBFRmRDNXpLR2xiT0FrKzFaYStx?=
 =?utf-8?B?bE9ZbnoxYzBnR0pPdHpUNkxJcGtZVVJXZENtV0ZJYlA5VzNjRGVxdy8weUNB?=
 =?utf-8?B?NFRNQnE1NkFqOURPbGRHeE1CZHJ4Y28rU3RuR3NWUXR5MmVuTFlUM3BoWHBG?=
 =?utf-8?B?ZEhxd2N2RVE0QWg3aHpEWnZpVnRyZjExdkdXMGROMytKZ21Ea0FVMGwrdE9X?=
 =?utf-8?B?c0hHTjM0d3ZBM2dpbTZZbEpkekt4K1dOWmJOMTFiMGI0WlJhV0R5dGI2Y0Fr?=
 =?utf-8?B?c1Fqc2FlWjk0RVBoU0VpS2ZQYVFLZzBMRU1NWE90T3VSVm9vM3krdVNaVmNv?=
 =?utf-8?B?VzhhNjZSY0g5L3pyT3ZHR21Ud3FOSkYxejZNcEs5RExIMzdIVWc1TGJJbjVy?=
 =?utf-8?B?bnAzNElWaW5KaTJQUHlTbWErWU1ITE4wbFJGbHJuTUhwUHk1VXBMbVVBSHo5?=
 =?utf-8?B?U2k2b2psQjNzN3I3NGFqU3BSQXZpL0l1VFkwVnFEbXpvZUNJZ25UQ3dFcjlz?=
 =?utf-8?B?UC9YS2RJZlBLcjZIREJqQXk1NG1LTWgxUElBVnZLRVB5a2FxVzNJSUd6Q1Nh?=
 =?utf-8?B?cmRqb1dTOW9QQk1xQUVvMWhCV3JBTTRIbHZ0cnV4WGNvZ2FsRTFJTFdmYzY3?=
 =?utf-8?B?QWVLQzJ6TGQ1QmRZNzNHSjRiaUpYTFNoQTlOeUxPOFRaWlpwa1Btc0d5eDdm?=
 =?utf-8?B?dGpLVWk4UUhuQUthVG44bEJ2d1hxQjl3QnpRdnVEemxGZGZzeTl0Ym1RNml5?=
 =?utf-8?B?aFZlY0drV1F1VGRNK1UvZGdyZlhUdEF3amNUdnBheXZ1c04zSHh4YVlWZHM2?=
 =?utf-8?B?S2xGTmxwdzVkT0tsaXVGRzdLSXphdy8xZFVEQkdsM25xYXRiVkIvWk9zVWhM?=
 =?utf-8?B?djE0bDdnbVppeTdDM3JLaUYzaGFmTUx5YnIxTDVKTHc1WXlyQStmeW56dXhy?=
 =?utf-8?B?OFpOZi9KZFV3RTJXNGZyU1VsT1RyeFZlSHNPQjF4TUR2MDFveXJodkZucU1X?=
 =?utf-8?B?YlBmcFJtaXlFeno1dC92UzdVU1BWSFRmTHF3eEYwcXVEWjE5Y3JsY2M1dmxN?=
 =?utf-8?Q?oIgD7rB6XUQyMlm0=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b20cf4a-f51e-452b-8af1-08df4b95231f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:13:22.2157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asg5lKG5dHtkq4/NAXMIm9MGNQIaOC0oCe8eGJSc4g0h6YWTaKYW2e/IITFEkQswwW4xVEwPmbSSiyxJ0obNdiSmKfOA0i8rZMURq+O4avY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4076
X-Mailman-Approved-At: Thu, 26 Nov 2026 13:33:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17.11.26 23:42, Mikhail Kshevetskiy wrote:
> This makes code more generic. Also it allows check for DTR support
> and emit DTR operations only if it supported by the spi controller.
> 
> This is necessary for spinand DTR support.
> 
> The patch based on following linux commits:
>  * 4a3cc7fb6e63bcfd ("spi: spi-mem: Introduce a capability structure")
>  * cb7e96ee81edaa48 ("spi: spi-mem: Check the controller extra capabilities")
>  * 9a15efc5d5e6b5be ("spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper")
>  * a433c2cbd75ab76f ("spi: spi-mem: Add an ecc parameter to the spi_mem_op structure")
>  * 030ace430afcf847 ("spi: spi-mem: Allow specifying the byte order in Octal DTR mode")
>  * 8618271887ca10ac ("spi: spi-mem: Limit octal DTR constraints to octal DTR situations")
>  * a9be454927de3b6d ("spi: cadence-quadspi: Provide a capability structure")
>  * 29c8c00d9f9db5fb ("spi: add driver for NXP XSPI controller")
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/spi/cadence_qspi.c | 10 ++++---
>  drivers/spi/nxp_xspi.c     | 12 ++++----
>  drivers/spi/spi-mem.c      | 61 +++++++++++++++++++++-----------------
>  include/spi-mem.h          | 19 ++++++++++--
>  include/spi.h              |  1 +
>  5 files changed, 63 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index bb8e7004a34..c3be4b1edb2 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -400,10 +400,7 @@ static bool cadence_spi_mem_supports_op(struct spi_slave *slave,
>  	if (!(all_true || all_false))
>  		return false;
>  
> -	if (all_true)
> -		return spi_mem_dtr_supports_op(slave, op);
> -	else
> -		return spi_mem_default_supports_op(slave, op);
> +	return spi_mem_default_supports_op(slave, op);
>  }
>  
>  static int cadence_spi_of_to_plat(struct udevice *bus)
> @@ -472,10 +469,15 @@ static const struct spi_controller_mem_ops cadence_spi_mem_ops = {
>  	.supports_op = cadence_spi_mem_supports_op,
>  };
>  
> +static const struct spi_controller_mem_caps cadence_spi_mem_caps = {
> +	.dtr = true,
> +};
> +
>  static const struct dm_spi_ops cadence_spi_ops = {
>  	.set_speed	= cadence_spi_set_speed,
>  	.set_mode	= cadence_spi_set_mode,
>  	.mem_ops	= &cadence_spi_mem_ops,
> +	.mem_caps	= &cadence_spi_mem_caps,
>  	/*
>  	 * cs_info is not needed, since we require all chip selects to be
>  	 * in the device tree explicitly
> diff --git a/drivers/spi/nxp_xspi.c b/drivers/spi/nxp_xspi.c
> index 7ba3f00e506..9c70a4a19c1 100644
> --- a/drivers/spi/nxp_xspi.c
> +++ b/drivers/spi/nxp_xspi.c
> @@ -326,10 +326,7 @@ static bool nxp_xspi_supports_op(struct spi_slave *slave,
>  	    op->data.nbytes > x->devtype_data->txfifo)
>  		return false;
>  
> -	if (op->cmd.dtr)
> -		return spi_mem_dtr_supports_op(slave, op);
> -	else
> -		return spi_mem_default_supports_op(slave, op);
> +	return spi_mem_default_supports_op(slave, op);
>  }
>  
>  static int xspi_update_lut(struct nxp_xspi *x, u32 seq_index, const u32 *lut_base, u32 num_of_seq)
> @@ -700,11 +697,16 @@ static const struct spi_controller_mem_ops nxp_xspi_mem_ops = {
>  	.exec_op = nxp_xspi_exec_op,
>  };
>  
> +static const struct spi_controller_mem_caps nxp_xspi_mem_caps = {
> +	.dtr = true,
> +};
> +
>  static const struct dm_spi_ops nxp_xspi_ops = {
>  	.claim_bus	= nxp_xspi_claim_bus,
>  	.set_speed	= nxp_xspi_set_speed,
>  	.set_mode	= nxp_xspi_set_mode,
> -	.mem_ops        = &nxp_xspi_mem_ops,
> +	.mem_ops	= &nxp_xspi_mem_ops,
> +	.mem_caps	= &nxp_xspi_mem_caps,
>  };
>  
>  static int nxp_xspi_of_to_plat(struct udevice *bus)
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 3fd2353af94..1c23f3d8843 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -171,38 +171,43 @@ static bool spi_mem_check_buswidth(struct spi_slave *slave,
>  	return true;
>  }
>  
> -bool spi_mem_dtr_supports_op(struct spi_slave *slave,
> -			     const struct spi_mem_op *op)
> -{
> -	if (op->cmd.buswidth == 8 && op->cmd.nbytes % 2)
> -		return false;
> -
> -	if (op->addr.nbytes && op->addr.buswidth == 8 && op->addr.nbytes % 2)
> -		return false;
> -
> -	if (op->dummy.nbytes && op->dummy.buswidth == 8 && op->dummy.nbytes % 2)
> -		return false;
> -
> -	/*
> -	 * Transactions of odd length do not make sense for 8D-8D-8D mode
> -	 * because a byte is transferred in just half a cycle.
> -	 */
> -	if (op->data.dir != SPI_MEM_NO_DATA && op->data.dir != SPI_MEM_DATA_IN &&

This line contains a U-Boot-specific exception to allow odd-length
reads. It was introduced in

db58dc5438e ("spi: spi-mem: perform odd len check only while writing data")

By removing this and replacing it with the Linux implementation in
spi_mem_default_supports_op() below, the behavior changes. An odd-length
"sf read" or similar will stop working.

I think we need to keep this read exception.

> -	    op->data.buswidth == 8 && op->data.nbytes % 2)
> -		return false;
> -
> -	return spi_mem_check_buswidth(slave, op);
> -}
> -EXPORT_SYMBOL_GPL(spi_mem_dtr_supports_op);
> -
>  bool spi_mem_default_supports_op(struct spi_slave *slave,
>  				 const struct spi_mem_op *op)
>  {
> -	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
> -		return false;
> +	struct udevice *bus = slave->dev->parent;
> +	struct dm_spi_ops *ops = spi_get_ops(bus);
> +	bool op_is_dtr =
> +		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
> +
> +	if (op_is_dtr) {
> +		if (!spi_mem_controller_is_capable(ops, dtr))
> +			return false;
> +
> +		if (op->data.swap16 && !spi_mem_controller_is_capable(ops, swap16))
> +			return false;
> +
> +		/* Extra 8D-8D-8D limitations */
> +		if (op->cmd.dtr && op->cmd.buswidth == 8) {
> +			if (op->cmd.nbytes != 2)
> +				return false;
> +
> +			if ((op->addr.nbytes % 2) ||
> +			    (op->dummy.nbytes % 2) ||
> +			    (op->data.nbytes % 2)) {
> +				dev_err(bus,
> +					"Even byte numbers not allowed in octal DTR operations\n");
> +				return false;
> +			}
> +		}
> +	} else {
> +		if (op->cmd.nbytes != 1)
> +			return false;
> +	}
>  
> -	if (op->cmd.nbytes != 1)
> -		return false;
> +	if (op->data.ecc) {
> +		if (!spi_mem_controller_is_capable(ops, ecc))
> +			return false;
> +	}
>  
>  	return spi_mem_check_buswidth(slave, op);
>  }
> diff --git a/include/spi-mem.h b/include/spi-mem.h
> index 36281a62f77..8c20feebfca 100644
> --- a/include/spi-mem.h
> +++ b/include/spi-mem.h
> @@ -331,6 +331,22 @@ struct spi_controller_mem_ops {
>  				u64 offs, size_t len, const void *buf);
>  };
>  
> +/**
> + * struct spi_controller_mem_caps - SPI memory controller capabilities
> + * @dtr: Supports DTR operations
> + * @ecc: Supports operations with error correction
> + * @swap16: Supports swapping bytes on a 16 bit boundary when configured in
> + *          Octal DTR
> + */
> +struct spi_controller_mem_caps {
> +	bool dtr;
> +	bool ecc;
> +	bool swap16;
> +};
> +
> +#define spi_mem_controller_is_capable(spi_ops, cap)	\
> +	((spi_ops)->mem_caps && (spi_ops)->mem_caps->cap)
> +
>  #ifndef __UBOOT__
>  /**
>   * struct spi_mem_driver - SPI memory driver
> @@ -395,9 +411,6 @@ int spi_mem_adjust_op_size(struct spi_slave *slave, struct spi_mem_op *op);
>  u64 spi_mem_calc_op_duration(struct spi_mem_op *op);
>  
>  bool spi_mem_supports_op(struct spi_slave *slave, const struct spi_mem_op *op);
> -bool spi_mem_dtr_supports_op(struct spi_slave *slave,
> -			     const struct spi_mem_op *op);
> -
>  bool spi_mem_default_supports_op(struct spi_slave *slave,
>  				 const struct spi_mem_op *op);
>  
> diff --git a/include/spi.h b/include/spi.h
> index f477763bdc6..6697d09e9e3 100644
> --- a/include/spi.h
> +++ b/include/spi.h
> @@ -494,6 +494,7 @@ struct dm_spi_ops {
>  	 * has native support for memory like operations.
>  	 */
>  	const struct spi_controller_mem_ops *mem_ops;
> +	const struct spi_controller_mem_caps *mem_caps;
>  
>  	/**
>  	 * Set transfer speed.

