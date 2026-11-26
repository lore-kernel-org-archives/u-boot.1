Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49635606A323
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bcd6uA5G;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=FHoYm/H8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 275DE81165;
	Thu, 26 Nov 2026 13:34:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qqx9pQMhkIfZ; Thu, 26 Nov 2026 13:34:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E1B5811F2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700050;
	b=a/EivnrWav2HjkST6Kn4MtY89TQr4ZRacHguvvaCEYuD5nww58uEbOs4rpH9UtgyYf+G
	 1c+MI6a48abpgzQU3GXZPPdSxFZPQ9nCAfdZLOe12eMsHBuwsnyf0E3OTSTl9tik9kelX
	 LcfXzWRlm5BCM0+/9ioeNlrqN1w/wOoc2HW8/QoQZDwyvjOwLg0COW1f+aWVDDnFqnkcY
	 2rpeIxP3XIRxL1+RIMiRSI20213MWLjNCmOaYrBoKTdpR1Em9otQdvAT8sUBzqi9dVicd
	 ir9up/G2cHTfBE52543Lb18BRWOOIYSeoZ2eTzCxhN5XodGHwkEBiHSiW0zSGmZot4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700050;
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
	bh=85I0MuHieLckZzSwWKZO1n5tFYLNxGKSbd8eQhAmduE=;
	b=p6+HiQwai83//lUnjis9UR8OjL1zjQU0R+4dCMYRSnqtfdPC3rplSVfJb/JuJsg6XNdn
	 +rY7hgabRAERSmSZGkRDbVtme/1jNpJoIzxfNQaSg1/GQuCReT+J97VCiQmh56+mb67Tk
	 7nvGZZqkzI34FtIjI5kmBpgNOrvQGRmQTzn86qzVlW9GD7EcV9Lrc74E4cd3fyk6vwqvL
	 C89X1tpZNF8i2cB97lOOWS+4FYSIEeEYuxlr5LFbO3n4rBySvFFebqv7qgNH9/LYxQJsz
	 Xbo6ZsEuOKNPGamYduEmKZUHSIUKsbejSWF+fvaO+qSQftDFHBwoktxKqtsP/5kLHoQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700050;
	bh=85I0MuHieLckZzSwWKZO1n5tFYLNxGKSbd8eQhAmduE=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bcd6uA5G9O6lFcCiEjiQtSo3+gDB/dtyGWG6q0eWTwXvinPLWqzDrGytT4bB6TPoN
	 mXb5GQV7Ts6DsJueDOFfpDX3z+n0w/rDl/CSewXZZhYqu5iMK2OnFtEKZxUqbnIm33
	 5w5a602/X3Dtb88uB04rZC7qMcjWTaLULFnqBVhMqOZ2kZ4brtFthiMVbsRMd1HGGP
	 FLbeacDqwMZ1Ksm6+JX640L81oMJPKQf1DSe6YfwQvRIqaaJy61qP0e55ZSLq3SVCa
	 IJDn5OAsZOsCDmbdMHxPs4DWdX/Pb9HrpMuvRZAB6T0fyiTXaGW6Vj2lFtFymtsoav
	 3ZvlaTLYFru0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E1B5811F2;
	Thu, 26 Nov 2026 13:34:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E4D922B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:26:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BC5540490
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xoVHlsvOuLsb for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 08:26:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F220A4048E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=FHoYm/H8
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F220A4048E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 08:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85I0MuHieLckZzSwWKZO1n5tFYLNxGKSbd8eQhAmduE=;
 b=FHoYm/H8Y57n8SXeCdvOMdOio8SrugaQQB3WNZj0ursFQbXNc6p7q+u/bb210dEYvN++b67vX/Cztac40cqBfaKai/9T3qxiDwiSOYkmziSGdO/+d/uzEQi4wKDfI64yc3gk4eTO8EB6cmS+xtrHwLk0IQWuKUZrz+SVn74WA8Lx4O1RYClflr7fnn7SPWPBY+qhbLGcWMWD9i6zNzBIzpOePEH8UhVSWugp76ZXg7kuKa+5oVpGcjRvGkUDHd+zbtV6T22Yg9QGjTaKtY3zKAWitLkFaUD8+55ki3NA5EIXgs46//AvAh9umA9IdDJjC1G/qF5qP5NKdzhiWuxvrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:596::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 08:25:54 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 08:25:53 +0000
Message-ID: <269d0afc-4419-4b6b-954d-ffa3e876d473@kontron.de>
Date: Thu, 26 Nov 2026 09:25:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mtd: spinand: update flash drivers to match
 linux-7.3 release
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
References: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
 <20261117224236.3150882-7-mikhail.kshevetskiy@iopsys.eu>
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
In-Reply-To: <20261117224236.3150882-7-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0326.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::19) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AS2PR10MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: fb11f409-6c1e-4dc2-5218-08df4b96e31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7416014|261026140227099003|11063799006|56012099006|261026121527099003|10067099003|261022105027099003|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261009223027099003|22082099003|18002099003|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: 0QalJDwkbMeOb7CIT3jxEbQh0jX7YgbnGfCkVtS/sLfQlqvkPDjvV5FlLGpv4D0OL4FMSrLgnG0lAM/xcTqn21B5zigCbxxGzluc++VJCyeNx9VQHEpJo3OH8fHdh3ME7R/DdTVyIlipZNEm/D7a+vabqTTVrxjfrbr1uT6g/0NxKuxsHKQGynK9axnEYFesA+0xXW01h+/jO6no20Ey603gtsxxzHBJia7D3CVODMbkbKTJD8WxV9vMGs1hnD+djN/fC+qV0I6K3xieigH+RrBkBfgt8liaACacWsoD3hy0QFgH23mtIVSGgRhrtxsCfFNIzvhrLFqNisU74e+sIe7drp7iy8ozUE0mL2EZRRsVvBqujf8JO0svR42T/0dQgODQYvbkM04QmS5M+6am8Gn2Jh+dk3Y7r+NOdRBPz4geyY9EwcsyWQO7+7AwrQ/wpItQH8esX4Zp8bUat8rH2TsXG0baygaVvG3HHSz5spuFu5Kdx8grwIEUt9kxz27uXKe3t1c9E1JjkPFH7fTJLJ1BvMy9QljYYcDAAQ+IFGcwYZ/xpEqQ76JJxOraNHsEmIJ3QG6MtFWob8swNlgyA+ndwcXJRqiqgPZgIhaUlE6I7nZ0L77uFkH2G2ZYAczp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(10067099003)(261022105027099003)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnNUOGdUV0JNMVNsK1dVZndrcjU5S1haNDZIUmJhR0NmemhDK0NDN1hEQTN5?=
 =?utf-8?B?QjdGYjBmeHF6QlVXNGc2NnJ2cklVbDBiaTdnaVdtMDIwNk1Na2pjTEd6ZmU3?=
 =?utf-8?B?ZDdWVGxtcXRMWHA2OUJidGxGWklzL1VqNG5obUNPYWhISnJkRE1IVS9oT2Nl?=
 =?utf-8?B?UjdmMmJTRTdZY1hSaVRHUmpseFYzQjBPNXFCTzVQQVBaL1J1dDM3Q2ZGMjBD?=
 =?utf-8?B?ckZoUXRUaExGTWp6RDR0M2JydWU0NHR6bFlGV2QxRTNReXoyVE1JNElXWEhJ?=
 =?utf-8?B?eGpMbU04Qnd5MFY3SEduSjBtOXYzc2V0VFVEbDIyRW8rMy9pRkdBcXdhQ1hE?=
 =?utf-8?B?ajd5ajc1aEFtWjFmZUxVbmhvdkhyZGVXVmlTZU13NWl3UkhPcWxjd0RycUxJ?=
 =?utf-8?B?K3hsa280Q3NpcllNVittcnhRUFZHU1BxNmlCVHV2QkIxYUFTVWRLQ1UzOXBW?=
 =?utf-8?B?RDAzK1QvVUR2UXdtWUwxb09tT0xVRE82elZIdHB3VFlScitNWVh0dmhTVkp5?=
 =?utf-8?B?eitmVHUvZnVoc0lwaFlHZHRCMlJuamJFU0RoQThxbjI1a3JvTFM2ak9adG1Y?=
 =?utf-8?B?V3pmbTRIN0p5K09KQlBNNVBNS0twQkJpZUVBRGN2YTZuWW1wTGEyTjBDSldR?=
 =?utf-8?B?RGhRNmZKeGZ1K2FDdk53RkU5Ulg1QUhqOGtiUFJEYTF3ZHZJSDhLcHVqVDcy?=
 =?utf-8?B?ZGQwRGZMMDYwUXZUOGxjN1pKUDh0YjQ5K044cWlFTVFwbHBkclF3N1h4WFhr?=
 =?utf-8?B?OFBCOGdNUG95YllaT1I2ZWthZnB1WDVreC84WHludjdDTFVsS041QnBZVnJu?=
 =?utf-8?B?QUZ4bHBabFJqZXp2N1hJM3ZVNWtGdTMrdHNyRGF5VDB2YXliKzFYYkxWalFE?=
 =?utf-8?B?YmYxMkl1S055a28zMEdUNGZMbVBRL1VmYlZIa0NuK0hkNWphcUdDeXdDQnFL?=
 =?utf-8?B?SjNOclZpeWRyTW1EUmQ1OFU4WnNXaDE5c2F1UEdsbisyM0ZtVDdReVNJZHlp?=
 =?utf-8?B?T2VEbUp5RDhoMC9nd0RZcC9LcmM1QWhOV1Z0d24zSlAzdXYxWDlnUjRJdkl0?=
 =?utf-8?B?N2FLM00wN1Z2M3AzOE1nK0JwZ2JQZlVsTDBFcG96a1BDSWFubHNCTEFNWFFU?=
 =?utf-8?B?QVRCZW13MlRqOWRzRzdIZDhSK0dmQjBCOElhaXZ2TEtid3RQcldmLzAyTmdo?=
 =?utf-8?B?ZnMwRHFmdUZpSXAyOVJTN0piRmk0UUgrakpPYjRBMERsZXNZeWR4MEtGck1C?=
 =?utf-8?B?aU9YQUdHYXp4VG5SckMxSkJUMkZZUHVRV2h6Q3pIUm9ibmQ2NVhRYTU1Ylg5?=
 =?utf-8?B?ZGJOUEJVa2piR3NNekJXcEhUZFVXTWNtUEFURjJBbVpiTjVYeGptQWN1a3Z4?=
 =?utf-8?B?eUNjYkhKS2JLZjN6YVJzcVZoRmM2Q2Nkdmx3dDgzM3M5a3RZRUZmSm1VTFhz?=
 =?utf-8?B?RXFtSDhPam9ZY3NGcllpaWFmWjdIcWRmcUtTZnZ6b2UyNzhoZlhqcXFhQllB?=
 =?utf-8?B?WFBiUkpZckZicUFFVml4L2xhdXEzNThJbldZeWZaUjBQdzhIaEhtRHNlU2pK?=
 =?utf-8?B?cHF0by9Qb0FqR01KZDgvY3RmTE9aMThXT3BIMXJ5ZVNYdXpoL2lwUDlJZ3lL?=
 =?utf-8?B?bFNYWDhyTGNDTWpmdnBsK3k2bDBVVzB1Y3RqbVJpbG1PMm1lSEVSQkdwS3ly?=
 =?utf-8?B?N0FLSk1jT1lwWFZRRkdyUEV0VDUyS202WGIyZ3BjdnZNaDRpTUxNOFlKYlZm?=
 =?utf-8?B?b3BWWU80dXZWZzM3czJ0S3Q3aEVVZWlWSU9BMkhGUzZ4YUNUVVl3cTlLYlVG?=
 =?utf-8?B?bXVCMTBZWmE4eXM2eG0wVTJCNGhtRS9HWmJsTzFHVWgvaTRuK05oM0w3Tk9u?=
 =?utf-8?B?QlM0YlAra3g5RytDWnZPK1VmTzhQeTZjUUZ2QTMzbnU1TWwvSzhLdnBwNUUw?=
 =?utf-8?B?TE1wQ1F3SHkwalJtdmI3aitxY3hQYnFJK0V3a1FUalYrVEpYd1J4Z0xaeFRh?=
 =?utf-8?B?TUtPakNHQ0krVEFMTHBtTktDZkdxWHFJVFplZUhHVlNPczh1QlZmS1U5R1dT?=
 =?utf-8?B?NktCbE5LVzEwL1E0aUJtS0R3VDVaODByMkRmUTB0ZVQyNW0xWU9MdzZiNlE3?=
 =?utf-8?B?MlhlZ3dZWC9LMmRSVVFOUldmdmdYNUlSQnFrbGxTVEU3WWE5Yk94YnQ1YXJZ?=
 =?utf-8?B?Uks2S3RRbGJ4L21Pa3dkZFpKdyt1U1pCSVh0aW5zMjRkWkMzd2RKS1pxREtD?=
 =?utf-8?B?ZTZZbWhjdVRNajlkNU9WZCtHbndtNVRXeFVONUhCckx1VlZIZW5xQ2tORmZJ?=
 =?utf-8?B?TkhHT2d2ZUMrMnRrMTBiQ0VHSGd2TFZacWRQTi8xamZvUG9QZTlsOU9vTDBF?=
 =?utf-8?Q?hcpUiQ/azi6OGpWI=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb11f409-6c1e-4dc2-5218-08df4b96e31a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 08:25:53.8392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cETYa60vIwj3NnSJPb0Wc+g9KbV2bM2J2JxnPvzYt2fwTyPISkOhyqLW5TD8MJfZrrwDtZYuUi6FbZ5yGg42U4CDcMp1szf8MDneVfsTRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7429
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
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17.11.26 23:42, Mikhail Kshevetskiy wrote:
> changes:
>  * fixes
>  * octal DTR support
>  * randomizer support
>  * continuous mode improvements
>  * more flashes supported
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/Makefile     |   5 +-
>  drivers/mtd/nand/spi/core.c       |   3 +
>  drivers/mtd/nand/spi/dosilicon.c  |  93 ++++++
>  drivers/mtd/nand/spi/esmt.c       |  26 +-
>  drivers/mtd/nand/spi/fmsh.c       |  72 +++++
>  drivers/mtd/nand/spi/foresee.c    |  34 +++
>  drivers/mtd/nand/spi/gigadevice.c | 109 ++++++-
>  drivers/mtd/nand/spi/heyangtek.c  | 132 +++++++++
>  drivers/mtd/nand/spi/macronix.c   |  83 +++++-
>  drivers/mtd/nand/spi/winbond.c    | 463 ++++++++++++++++++++++++------
>  include/linux/mtd/spinand.h       |   3 +
>  11 files changed, 911 insertions(+), 112 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/dosilicon.c
>  create mode 100644 drivers/mtd/nand/spi/heyangtek.c
> 

[...]

>  const struct spinand_manufacturer gigadevice_spinand_manufacturer = {
> diff --git a/drivers/mtd/nand/spi/heyangtek.c b/drivers/mtd/nand/spi/heyangtek.c
> new file mode 100644
> index 00000000000..c1eacf5d41f
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/heyangtek.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Authors:
> + *	Andrey Zolotarev <andrey.zolotarev@keenetic.com> - the main driver logic
> + *	Aleksei Sviridkin <f@lex.la> - adaptation to the mainline Linux kernel
> + *
> + * Based on:
> + *	https://github.com/keenetic/kernel-49/commit/bacade569fb12bc0ad31ba09bca9b890118fbca7
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_HEYANGTEK			0xc9
> +
> +#define HYF1GQ4_STATUS_ECC_LIMIT_BITFLIPS	(3 << 4)
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> +
> +/*
> + * HYF1GQ4UDACAE is a GD5F1GQ4-compatible die, so the OOB layout is taken
> + * from gd5fxgq4xa: the on-die ECC parity occupies bytes 8..15 of each
> + * 16-byte section, the bad block marker sits in byte 0 and the remaining
> + * bytes are exposed as free.
> + */
> +static int hyf1gq4_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				 struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	region->offset = (16 * section) + 8;
> +	region->length = 8;
> +
> +	return 0;
> +}
> +
> +static int hyf1gq4_ooblayout_free(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	if (section) {
> +		region->offset = 16 * section;
> +		region->length = 8;
> +	} else {
> +		/* section 0 has one byte reserved for the bad block marker */
> +		region->offset = 1;
> +		region->length = 7;

There is a fix in Linux for these lines [1]. Can you port it here, please?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mtd/nand/spi?id=30daaf3e7897b4a8d9b72e5b0c86dd6e2a4d7d85

> +	}
> +
> +	return 0;
> +}
> +

[...]

