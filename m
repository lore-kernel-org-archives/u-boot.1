Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E29606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ajXOyeOz;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d8fW7skf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5392881B52;
	Sat, 14 Nov 2026 04:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VacL7InWpwNA; Sat, 14 Nov 2026 04:36:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84D2A81B14
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794630991;
	b=qLyd74zrSkEyjQpsEEkgAfaFjDNC3gx9O00ESvbjJ8S2X44KmM62R0Co6xlOHNzXKwIy
	 nUY76aX1yckLJwCpHP3oZwhEgqgN0HCHBVfh/5r4g8EmMPeMwsn8UgC7pr8lPmSPAq88I
	 hpfF9zA1nlDbCRazkzYh+xHhh8plvGb6zW1hYNRP/RBA9r5HdwEK3DrbslN8pWjOVVsSo
	 NmNwvf4eoP4ik3ZemPuj2XTsnirKdH++c9nEviLmQgisuXsiLgHzakfiIDQ0ymFcUMESb
	 QFoEZ2KOd3LzaWB6PaW7FcAYtkjnP2ZIrIODlQKmTfWU6wgazBqMRj+eiFEBiF7wPmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794630991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B2cLJrqZs0+rAZ5rCwGpzB2pwCxNEM5Nhd6agl0MR08=;
	b=UNwrM5R2JWBvIjVo12b40Y9bC9ifsUwo5SRU5LiOU1MG2XCjkh0bxfi2sbqb9Q2gqUyU
	 A16/JWj0FDR30tO0mvEGc5Nn4Mv91IY3tw7phwjhEQtZBoNLwQdEGU4VQgGqwacNVJ1PY
	 gFf10C55JQ8bRCQvQN2v0ocERTKPqnQ1QG87iVQKhGox78jW7okrVfG7P2fy+bqzOiUrH
	 RsmGvmPtp1zGTW3FkV9RVHGtcgOYVNdDymC3untNcJgv3lspCj7BLMtrU6ZjC78cS3auy
	 iPv4x3a7LtGKAXbLdwHqw9gLeFuwIMQCfT85FNbNi5HRDLDMiL5FshIfQ+6VTZ6d5aQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794630991;
	bh=B2cLJrqZs0+rAZ5rCwGpzB2pwCxNEM5Nhd6agl0MR08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajXOyeOzzFifwLoaWw++6H/f5tcz1jEg8qEjdywq/wAhS9PZGFUyJUlZXSRs2/6cL
	 ifUjRPS50/Nm3PhMsJsIJ8DFX+2MdhZgFIb9oRPTOv3FjEBt5mWgSM/p+TaeqB2g/g
	 KHCloOafbn5uBGfcDqy4t8JltTe/Dvxr/yMY2l7e8PgYXRhNVNyyp9JBH0Dfk+pOKb
	 BzLptv1KCOEbRMFOFIL3DI4595IXOYJxIzuF3jZGwClL68jzfhhBoPEQwkG6bs+F1u
	 ZlkD+wiMVc9YGCy7XrsF4E7qZJjqZyBBsi6D5j40I2TvpOBhnSke174U6A5/eg9Mqh
	 gP1bp24eRbf7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84D2A81B14;
	Sat, 14 Nov 2026 04:36:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 86C1B1E7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76C9060D80
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hbt49fix1iPn for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 04:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 496F560896
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=d8fW7skf
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 496F560896
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2cLJrqZs0+rAZ5rCwGpzB2pwCxNEM5Nhd6agl0MR08=;
 b=d8fW7skfEwbwHjYbdKA8h8+z4Nlq+k00YYfCP/dmg6Tu2AgiUn/Oax3WjyKJP4h9UBP/hpc0+FOp78hWlX2hQK3mc41HSFATlXcL50ydqq0jyDD3T4UtmScWHj8OY3XJQpxlR9LtJ2GCnmtAQbLU6ujN4ME//bPMgwsn9TP8sGNyz7g6xdU4J8JlIZYqFFc28ke7LSh1I714WRPbxQn9raw6s8GKxED6vPz4BBzzhEOdq0jf1Ql8i6o38RF177sdNaqc0+jpN3dFdTAUdomkFkWWVr9Ia/TmTvGhcaffEgsBjKhs/GtYO+F/2CaHuaff8tzLm73rxQcz0gPXwulilg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by PA1PR04MB11082.eurprd04.prod.outlook.com (2603:10a6:102:487::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 04:36:25 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 04:36:25 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 14 Nov 2026 12:41:16 +0800
Subject: [PATCH v2 1/3] power: pf9453: define configuration value macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-91qsb-v1-1-046293559467@nxp.com>
References: <20261114-91qsb-v1-0-046293559467@nxp.com>
In-Reply-To: <20261114-91qsb-v1-0-046293559467@nxp.com>
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Joy Zou <joy.zou@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR03CA0006.apcprd03.prod.outlook.com
 (2603:1096:4:297::8) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|PA1PR04MB11082:EE_
X-MS-Office365-Filtering-Correlation-Id: 694384d8-df61-486a-452d-08df4208d739
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|23010399003|18002099003|6133799003|22082099003|261009223027099003|11063799006|56012099006|261102123227099003|10067099003|261021121427099003|261022075727099003|261026121527099003|41080700001;
X-Microsoft-Antispam-Message-Info: a+Ytg/wD1uSsZow2ilAldC7SAelRPfYPh/+foVcKDW1Q5/QHvxdS7xUbQjEA2UZ+loQcWKymBKm06XZot/Q2ILXy+uRt8ZYP62aB3Pap+LmOkBHFTcVA7OG1zy6jt0GdLq0PgZiXKWegE4A5y5qhhCWGwVt2vcbNBtA7jLVTLcrCvEz1kgQnINy28zBiU0dMHHz46322JgnfzyJBDHujWsl7j4BSCom6NSMt0f2KdtJIkwyck6CaA7OnQjK0BAlpVOIVlDDTdkQgHtsUQRt9kba6aJ7TfLriMSa9VO/B1pUMno5Xx6x9LqmIKc1rV5prAk/siKrQMw96iesIjEFN4neJINx7yHOcA53DFwALZhSfaSCOPyhkw2DKkC8/ofFgPzpsIOGmGUmH3ADZsK/lo8sFXXfw58ja55kfUQJDo0P95Xz1eEGv4aDNkBXxkhjQy9yMlrBKfwgXsL8QbUKkPatrDYOhe71yJdASehw4bvTRmWU0C9N/eQh8etsXX3REQHCoe6jlBGJGdDvwRTED19TBXupU/pghJxzo53wBmorz78kkpnhWwQLFTI2bnmDvw/pL/R8aeqZv2wOR35W+433+KTgJENfx+Jp+ihdsujOkLc66lm5Gd++YQUKM1v9veeWLpiXVy5HZodqZAq2XHqkgMd+6I8AQcwTJ4rXQorzzyEZ36YhTMsM2WnHR9Ttff31ufdGd9GhAphz3ZVCm9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(23010399003)(18002099003)(6133799003)(22082099003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021121427099003)(261022075727099003)(261026121527099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW5vS21nOVBOZGVrdDdaVkp3U1dyci9GQ2dkSzJQYmt1YlFVQS9vR2VMUDFr?=
 =?utf-8?B?Tmw3M2J5aFZ2QzRrRUdVRTZtemFyUm5SZGRPclNDREltU0k0MlZGWHRqSHhs?=
 =?utf-8?B?SDVSd3d5clBVYVFuOUU1Y25SNExZZUZLRzhGY2cwVWY4WDE1dUZnQ1RaeEFl?=
 =?utf-8?B?WkUvcFI1VjArblo1ZE1meHQwMGY3djNkQk9EaDZKalMyelNvTFJBVzJHeUUy?=
 =?utf-8?B?TWZPRjczalkyZURBTkJ3M2JJUWYxaWJrRDNnNTZmTzRYazc1MnhUVnF0L1hQ?=
 =?utf-8?B?SGYzY00velFOS2hGNUlDQjdsNnlSN29xRHBkOXAzaHBIbjZqdm8zQk1MandE?=
 =?utf-8?B?cVNGdXh2bmU2dWFLOElGODhiVDRneXZ1U0tkTkttcElBVEJnNDBaMVZHRlhV?=
 =?utf-8?B?cDdycCtEUERvWTZVSjZpSHcyMzR4aUpZMEl6VnB4YzlhVG5oeUlPYmtsWkJm?=
 =?utf-8?B?Qk8wbVM4b24rVkxBSzBnQUh3anQzQUhVdE1ubDFXNWczRFVMYUkxdkNFNGdK?=
 =?utf-8?B?Ymp1TDhhb0hnRFh4d3NSNDl5WWlvSmIxc09Felh0U0FUNDRMUjhRVFFNMy96?=
 =?utf-8?B?TjZpWXl4a0RheXVteU9VTFc4Q2tOWDJTREcxUktVdUNKQmx6MmxRQmk5LytS?=
 =?utf-8?B?dUI2YUcwZjlwbzdNNnQycnFyL2N6MzMvdWZjMnBuZWkvenl4OHc2alRGeWFu?=
 =?utf-8?B?aGFxcmp6VUVwZzQzY2Vhckk3V1ErenhXM2k3dkRFT1NWNEUwTHp0cnBuNS82?=
 =?utf-8?B?cXpnbkFhSnVSZlUrMEw1SG1FYnpXeEVTeGE3bkhNMW1yS3I4OGo2bjRZdFVo?=
 =?utf-8?B?K056S0VuZVc2bSttTUI4VkdCM1Exd1Rvdlk0TjUrWTRpL2tScjlFZ0h1UDZh?=
 =?utf-8?B?SzB6L1F4emFyT0FMaFI3NzdIQk1UNGVnN0NRcmlCamROaFIzd1VtWDl2MFdv?=
 =?utf-8?B?S09VVnZCVU5tU2VtQ0tBemhxRksyTzI0dnZMMmNhZzV0YUdkRmRlVVFhb2VD?=
 =?utf-8?B?RWhZcTdOTVE5T25uR25vWk9jKzFTZDZiQXJCQlAyMmlXZXhYdk14RlFLdEtJ?=
 =?utf-8?B?a1dXMENsNFFMTEMzRWxQUkl0MEcvY2s0RXNzZVhyWmkyOE1WUlRzQlFNeW9V?=
 =?utf-8?B?SUE5UDRRejJOSWpKVVNFamcySjFhS1FTZkZoRGNHQmI4dlU5bmUrNzIzWmhl?=
 =?utf-8?B?akZ0VVJ1RUNGelBHREFyVXlYalhWRHRXemFuQjhWREI0Ykd6RUc2RUxrS0kv?=
 =?utf-8?B?ZGFMMWkyaWVVMGVweFlZMUdFY3IvWFdiNVNlWVpUdmpnR2E0UXdoWGVudEh3?=
 =?utf-8?B?NC96RzhEM3JUcDY3STZRMTg5U0hNdWZlUTF1Mm1BM2pyWWNxdkx3NmpVdTVo?=
 =?utf-8?B?YS9Qdm5yS3VyOU9ndzgrSlBsdGQ1bjIyQ0t6ak54UmQrR09JSjRkWWNLSnZD?=
 =?utf-8?B?MkRaNzV0M0NId0U4Mld3OGlmWjE4V1V5NVFHZ2NRUTNTWEF5WkVLTGVNMTdU?=
 =?utf-8?B?MkVLcjQyTWZmWm92aEFoc1ExWWFtUkFYZ1RIcXZrb3lGdDdIVld3YkJ0cHlK?=
 =?utf-8?B?ZjlLaGxKV0Z5MUNwYUdZZjRub0NRUDVsVTAxNm5BdFJ1REFHN1dzc3BwYlJN?=
 =?utf-8?B?b0JMenRjUm1yeEtjQkkvaVRTbTUydThUc2lwWGhDa2NKcEJnaStWRFR0NUU1?=
 =?utf-8?B?YTZpek51SnNRbkYrNmY0QUo3aUpldGp3b1JNUVFUVVcwTmViY21iSmppVldm?=
 =?utf-8?B?bFVsR2IwNzdGUVFVU0xhV1BKbDNlSFB0OVhDV0FoM0JDWnFCeUxxczVIYzNj?=
 =?utf-8?B?UWZpcU5sVGViSEhLZ24zN1VYcUt4OGFMUTNMNmEvZk1aeFM3anJKRWtHWmx3?=
 =?utf-8?B?ZEkwQ24rVVFsSjNGWXN4VFprLzUrYmZtOU9IaGc2Q2draXNBcDdTM3UxWDdT?=
 =?utf-8?B?OEcwZUNJamhVSGxVWW9mbXdnQXdaay9kOEdUeWlEbU0vRjhLZ2JjVlZlT2ts?=
 =?utf-8?B?Ly9pODBBMUZsMGtTOG9jZlhvSW50NkVwM21pUnRkY0dYZU9lV0hhTUVJa01u?=
 =?utf-8?B?R3VjYlJYSnFZUWF5WkZxSElsTUtPa2Qrem1od2w0d0EyUlhHVzdtL1lXa0t0?=
 =?utf-8?B?NVpjeUwycXVzZUNwYVNCWXMwZjZuSU5YdjByUXZyc0YzM0FYcDluNkN1S0xD?=
 =?utf-8?B?bnYrNHhiNzBaanlJY0swSEw3RTY3VGllZFo0UldSK3VOTDJxbk9zVU1iMktu?=
 =?utf-8?B?RDJ1c3J1NUZLL01LVDE1OE5YUmFBSHkyZ09CblhpY2xKUVVzYmZ0U0owL3FG?=
 =?utf-8?B?YjNwRFRvZTVyRXNHaElQUzkyVXlzZER4UVN3R0FQVzBDNFlwLyt3WlpZOXov?=
 =?utf-8?Q?F87sh6pa4+DLbiHqxb37MQyG0GzpAA3ote4iU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694384d8-df61-486a-452d-08df4208d739
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 04:36:24.9391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AY2Ejhr8s9CFYqnI6H/5cpCU8dd6u2T0tG91tl+Q2JyN8jQVC8HkR39/Y7AYfI1NzYVgvlqa9HalLsd4QdJtM7JZY/rSs7d4yy/KH/BnbitBLKBamwy6wgx+VdW/XK0F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11082
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alice Guo <alice.guo@nxp.com>

Define configuration value macros for PF9453. These macros can be used
when configuring PF9453 and help improve code readability.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/power/pf9453.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/power/pf9453.h b/include/power/pf9453.h
index f33b839cde0..436798a495e 100644
--- a/include/power/pf9453.h
+++ b/include/power/pf9453.h
@@ -64,8 +64,16 @@ enum {
 #define PF9453_LDO2_MASK		0x3f
 #define PF9453_LDOSNVS_MASK		0x7f
 
+#define PF9453_RESETKEY_TIMER_MASK     0x1c
+
 #define PF9453_PMIC_RESET_WDOG_B_CFG_MASK		0xc0
 #define PF9453_PMIC_RESET_WDOG_B_CFG_WARM		0x40
 #define PF9453_PMIC_RESET_WDOG_B_CFG_COLD		0x80
 
+#define PF9453_BUCK1OUT_1100MV		0x14
+#define PF9453_BUCK2OUT_800MV		0x10
+#define PF9453_BUCK2OUT_850MV		0x14
+#define PF9453_BUCK2OUT_900MV		0x18
+#define PF9453_BUCK2OUT_STBY_650MV	0x04
+
 #endif

-- 
2.34.1

