Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41C606A33A
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sK0bMqU7;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=q84dHFfh
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3180840A32;
	Thu, 26 Nov 2026 13:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_dD0r67D8zh; Thu, 26 Nov 2026 13:33:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3A39440A1B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795700034;
	b=T8rox91nAmbpSBETaNxuBrxKPMnnOiP9r+poMR1J5fj3eT1zzOtghXN3Z2bGncKlV3To
	 lYUViw6IisUGIyOn42q25aqjar4NiT/rXfH3k1xl5Vl98GDxBlKArYC9L10V2dADXQh/X
	 bAWePlZFtKQ0ylCz/Zk5fVN83kYvTJZh4LuSndxsk7HT7++kcJ0O5u+bwRcR9moUDqEJJ
	 4Rcw0Y7Udx/sOKndmm6GWq+YUr6VmJ3tA53ShlpldvhfyFTClOzuXJ22/VXuGG3pAMGWS
	 82gZtshn2S0DDJvhCHY5d1psS1b3hC7ZmeCA/YDQYUvwrPseTHZbEX2mLiahM8oDOFg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795700034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=DRZLyHF9HdalsZzJtbTVyTIihyxIc8y0ZV0KqQAKrkY=;
	b=P1ixYAAjbxbAZJGRb4XjLFb893jhe3vZD0Q6GIjuqlkhTrA9mlD+Wh/m2b5/qrFOmUYW
	 Yk97uaj8N/UYXzjia7G6JINR2/9fr2uleLS2yDVvqsC/guda5TGBtlGi1CnvDQBAwHmUy
	 QCTrXzSG9cxJVUY7l8lAnJyTHpwfQl0WN13v4FWvpCOLiecUNr2/czv2OdA4ADIuU9oRV
	 yplnauehS7C/RADREcdErcz+gNJWuA8OJYuAh84O+W/u9AOUvqzUMzMwcQ1t7Ho0fGHD4
	 tC176PjPcDx35zWhFmSx3F1NB9/DbeqUigUx0konkfXXirABaKn+APpSnQpTL9rHDhA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795700034;
	bh=DRZLyHF9HdalsZzJtbTVyTIihyxIc8y0ZV0KqQAKrkY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sK0bMqU7TdkteMd4UqoY/uXC0SNZpTi5H8f2FdNDwWhuH1x5a1WlK7sLnX65Q5d/3
	 ZBcjEz/NuDUYYXs1Cg1K3p6/jNylFGkIVbkF1m/ZBYaT9cXSvWuucQ7KdLfrv1B3hV
	 PO6tRHmA20Ftmk2bQY0YXM2om9RQ/3DCo9zYGtBefUP8v8j1IPIb2GmzaET1bRg5s0
	 JMkMtVYO/FUf4ieoT8o6B1iOlijFED0LK62mcCsX8lkRfbmOeK/u4V0yc9lGApLX6p
	 ibE2lhdLLAklvPro9FirQrqbjpw4eVoervhp6hJQiuu2Qkp9PwA8mhWSuQynl499Mh
	 me/z6J8UA+hGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A39440A1B;
	Thu, 26 Nov 2026 13:33:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23B7926D
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:54:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1567D60671
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:54:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2gi1uGUcnpqS for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:54:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D826D605D4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=q84dHFfh
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D826D605D4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRZLyHF9HdalsZzJtbTVyTIihyxIc8y0ZV0KqQAKrkY=;
 b=q84dHFfhHl8UqNEAQxN/KTbimGuKi07aroQKi00/trigqdxGSjJgE4nPG2e0K1sFSrHAKGlfcy7wKIEYdAaLI8e5cnHwxfhPuwh+5ZG+K+yrokul2qET+UkqkxEHms5jY3g5IMaqgXIOiLMAneEC/EtVo5BCNBbGXHTrJv9LWDQQptKqxnTBygqdfhIMVihPtM7bs7uFqPMxZY/sAZuMu2Uflf2z6FrAmXQCQj2rikgvveicXAUCrgtD66DvzQR48G4VjZAEAV9fVmNBqjbk3l/heNzMP3iE3plUda9S+EtvzPpNT9KrPuzhVo0C+3fzZujQZlnZCimD0gjxx4bBHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DU0PR10MB5535.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 07:53:58 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0662.001; Thu, 26 Nov 2026
 07:53:58 +0000
Message-ID: <073ea3b1-d068-4131-acf2-8c20621a96f5@kontron.de>
Date: Thu, 26 Nov 2026 08:53:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] spi: spi-mem: add spi-mem caps support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Vignesh R
 <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
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
References: <20261117224236.3150882-1-mikhail.kshevetskiy@iopsys.eu>
 <20261117224236.3150882-2-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20261117224236.3150882-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DU0PR10MB5535:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cea098e-b9f4-46e6-3148-08df4b926d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|921020|11063799006|56012099006|5023799004|260925021311599003|260925021911599003|260925022911599003|10067099003|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261102130727099003|261102123227099003|261009220027099003|261009223027099003|261009223327099003|261009221227099003|261009221727099003|6133799003|22082099003|18002099003|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info: CaAJ+yBikG1CThhhqNdsM8eQIY5bhQ0sE27MAsjf+izOIgEnkoQwst/7HeO73MJohahQF/rcsqK6Acqz2Gm75L2VpHvXbS9AvOTjqBd2XCvDQxuwpTvbCTZE0R5mvR+KoaiXOkREvesf7o4oBkCOeqEag0dbDAR+2W/MuPa3FLhxdPoA+kwggvNn+L+ejfBrnKwpIzTfFqYrVite8eaJzeif08YL+wfF0rrPQjhUF4yeRN1nsY1or/kfzBAB9ypSdix/zb+dtRtgxqSuYbq6g8wNCS2kQDl7kmo6kJ17IabKDfjhy3wkgAtiwQ+WHvYv0BbChB/DfRUI02DpBSOzWhjCyBjZPG9myR/OZ8PH1BjasRW9tKymUCQxfL6ddCvsd8V69lRscLW6bss6WUS4dRRVDVkv1Yug72lslkY85/d1yUgd2JQSb8YMjcvGQz8E+Rm503QPVeuspmpdWF17D8fIbbj/G1CASBG33/GSEmCNMbiLVWHx7LkB/5UORykVXtkhGEoDAqCM3Gucv5oRrli6kJVWICn8W3XVZQo4rUYa+yFp0G8sh3L59Ns6rF+Ts1vjGJlmgqtHaz4yGHqxtcfNAo2PCrXBlO5lMODjHv62oHQXolHFo0mcozN/YVxi4C/EVZ3MZwCo2XITDvMofOsOe1qBZhtW2bFxd5NXDjIMhRQ/T+ENwgXqM+g3IOxKCqg7WwOHEmrXHnxQDoEOlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(921020)(11063799006)(56012099006)(5023799004)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261102130727099003)(261102123227099003)(261009220027099003)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(6133799003)(22082099003)(18002099003)(4143699003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qk90RVdxQ0NQSHppdFB4NEh5THJTYkNXdkVtTzI1RTc3RTZaSlJqWUREUHVD?=
 =?utf-8?B?MEg3L21FbldiVXdQWjdpNG04bUdTLzdNTFVWRGdpVk5qV1lxRnRocnJleXFk?=
 =?utf-8?B?TXZQYnIrNFRCWWZLYU0vcDZkdGxtZUVtUVZpejVWbG9OcVd1V0xWeFVQWDNF?=
 =?utf-8?B?VVRCVysxYUFWY1F3UW15dXJ5ZGtMK1h1UkdnSThOSDBmcVFDQUFIYVFtV1JW?=
 =?utf-8?B?ck1QVkhYOXpvKzFMU2tmMkdFaDB1NTd1ejRwMzczY2h2WXdQdi8ralZHY2o4?=
 =?utf-8?B?V1VLamxPSUlrdFQrdVZiY1JYL2FGSFF3REpBMGJQcjMyRC94ZlVsczBDK0dW?=
 =?utf-8?B?cXRvaDhsL1hyWW1UMHlNTnNzWlBMNFVjRnNyNGJaRmtCd2piMGdBdEhWL2Vj?=
 =?utf-8?B?Q3NDdGdZaGVLY1Z2VnBlTWN1K2JDaC9DVVcwNTVtTTA3SkpoM0YwaHhDdnpR?=
 =?utf-8?B?dmRmNFVSd2ppRlA4N3VhaEhvTTh6a001YWRyZ1JwSjFwVGVjb09hWUZVY0I4?=
 =?utf-8?B?OVhRMlVHVDlBdmJ5U0kyUlRwR09iQUd1bHNneW40T3JkS0dGWFJ2NkJ5N2Y4?=
 =?utf-8?B?Zzl5NUVvZlh6VzA0L0g3cXRmM055eFNwYkZCYkwyK3h5cmxKTE8rYml4Wm13?=
 =?utf-8?B?MWxxdjlRa2N6RFpSR2ZnR0tMMnhWc05JUXdRVFFscGVEd09PU2liVU5jZjA3?=
 =?utf-8?B?UXFvbmZUdHpKUm9SbnV5eHNQaWZsK2o2cW44WlA2SVVhcUVlWHcyYkpRa1NC?=
 =?utf-8?B?ZXNtejN1WG00Q3hGeEx4UHBITVFoWUErQkt5MkNscTRGY003N2VFU2ZqUkxt?=
 =?utf-8?B?UE9Zcy8wZk9BTU5ucjk4YnM3dEhnK2cya1ZpWXd1YTdpYnBKVXR0TFdlaDls?=
 =?utf-8?B?YWNtMTN0OEFqWVVDRldkcThiS1A3OWdLK3poM0Q4cjEzR0tkT0tOSXBDZEZm?=
 =?utf-8?B?UWlCRTlvUWdadlBlV3hGYW5JbjE1RWYvSmltYTF5N29tUndvUjFzWmhuOGMv?=
 =?utf-8?B?MXFEV1NaMW9lQmFQSzBDaHo1NjZLcTdaVjNkMlFHY0ZFcFhXZzdyRE9FNEJw?=
 =?utf-8?B?cjFjNG54dEFMdW12a0Q4QllsZFNQTXUvS3dCQ3dET1JqTzdkaUxOcTZCL1dI?=
 =?utf-8?B?Ny9QNG13c01YdjVpYTltUk5xTWVpdEswc3NQYzVKMXd0Zk1IUEFXR2tYQjNY?=
 =?utf-8?B?Q3VzTzZkMC9reUhyRUlvam1nN2RIaHIvTHpJQ1g1cWdrL2Q2MWc2QjM5OTBH?=
 =?utf-8?B?VnBqVWVQVmlRTU1BTktKSC9COEZySURtY1poQlRBY01DenVGOWdacnlyRWRh?=
 =?utf-8?B?eUtLZFpxVXhPdzNCNVNEOUc3dm1MSi9JMGY1U2w3VENzWkpPWTBzZkpzOVA3?=
 =?utf-8?B?bGc4dDNiTHljaldoL0I4ZUxXMlFIei9OcWd2U0dkZWRBTkxkWlBsRmQrTWZp?=
 =?utf-8?B?eldjUWhoM0JyTU5hNW1yU0tFVDQzSExSZmc4VVZPcXhxNWVza256M25FTXVR?=
 =?utf-8?B?d2NFWEFBSkMxdGY1TU5hcEhBY1FKZzRaWjNXOUZxdXRlRHlGd0lmci9MYWVw?=
 =?utf-8?B?SWFvc3VkODVoNnRNQjM3ekJqNFFqaEF5VTZ6dWo2THY1eGNqZXZWU0xuRUM0?=
 =?utf-8?B?V2FZVkR2UHdmSWppeERTSVpveWRsNWtlVDRka1NpMStvWHlXcWdGQTJMRWVC?=
 =?utf-8?B?WVZPSkxnWFJWaGh0d0kwWFNPZ1BHWG1Ja2c4MTBlT2wrSEErdGlXRHJKejlt?=
 =?utf-8?B?ekdTaVNkTzMweGtTbDczZkNFRzFvL28vVlNvNmRIYXVyRFdHRkNycDVWVHA2?=
 =?utf-8?B?SThQKzR0dWN5V3JETXdldEVCSXdXVGF3VW9nbnRyYmFoSVZCRmlpdkdBTTZL?=
 =?utf-8?B?d0dPN0orNCtONjBFWkNHY20wSVVqR3VUci93Y3o2RFQ2TWxEOU9FalduNUNw?=
 =?utf-8?B?bm1NK3RyU2F0WmhBd3BYSHdzRXRmTDVCVFhmYlBhd3g4UDM5cVl4SnBHdmdy?=
 =?utf-8?B?L1E3SFJ1OHVPNnVxZEJJcVJPY0U2aUJBM0RNcXNzSWlXcGNnaVhzVG01MVJQ?=
 =?utf-8?B?WnB3UnVUcHRuWHZNWk5KMGp4ejdNVUt3WHpEKzJCaUUzdk9VT0NzVDUrR2o2?=
 =?utf-8?B?dEt0T0J4OHFQYnJSeE5qYkQvTlNLQXRPOWdRSWNaS25DWGRpTitZY204eXlv?=
 =?utf-8?B?SzFuRUpnaW01SXE0U0FWMUxnZWpmVFduOVQzMDJnRUozMEZ6aUtxUGdVM1ZM?=
 =?utf-8?B?Y3QzbUVENURBWDZ6OUE2b2Y3dGRnOEN2MndUZ3ZnMGNQbWZVY3VXMUZGUTlj?=
 =?utf-8?B?bWdzbjBRZ1Q5OTdCalJsS1hnY05yRit5K0tHZ2htb2ZaMm9QdVlLbjBLM0M5?=
 =?utf-8?Q?uq7jmTiRh1jidsF4=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cea098e-b9f4-46e6-3148-08df4b926d04
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:53:58.4423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UagLFw0uKi3TdnmoGy5EYaqgNae+q9NZOb323lHt9x7gkFQ6gdnTV0ZTWW4Yic7JZyhoI2XuhhtZ3QJj9qHWPHohBCq7fbTBLKcMqu+OQfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5535
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

If we enable DTR support here and a chip with octal DTR support is used
in U-Boot, will the chip still work in Linux? It looks like with the
changes in patch 5 U-Boot will leave the chip in octal DTR mode and
Linux will try to probe it in SDR. Do we need to switch it back to SDR?

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

