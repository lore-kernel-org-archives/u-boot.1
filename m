Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270F2EC1EA5
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 12:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ACA88341A;
	Thu,  5 Feb 2026 13:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sQnLZ71C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02B18382A; Thu,  5 Feb 2026 13:04:00 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D3783015
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 13:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcao05yQ/YpOJIlkZ556tJ+JokoBT0zeyAQ8egekCxnjEAh+XGUh2azb/CWE6xAtW+6WgCLtxEIOr5ew5o7oZwKhqV+RsiuLf3bSeODDv4hPt8KU1/m5edSLoa+9lH8UotfRlbXk0EC784m9eEci5+JF7qsmLoa7YhL/twiKyKNNgmBGfuJXD6y9/tbE8s+qTeEsMwIIElM28f4+IjJh9K4p7B3vAuyjxhMvBmbI2oOPoux7nu2yyW5cKSD3iUR4BdDUcB0WqMwrpnd5yje03kKrTxtxLWyQLpmUyzdHo/BkW9Gp2q3I2KZFu8BWvAjo1yBdXfBYziM33NStQHU8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLC3TNJH+J3XwlpXRLKPClYBlhgblsH5nNrkcAgJQoM=;
 b=UnNzQx8P8vlCDN9dLgIkc9p/vhNMpDidsibWmTUwVgli8MSYrHOLEiyvTUkTL9cZjiTmOoUIthCFiwX2HTbiGa2hSEHEhBxlMK6H2Hi+/0Axwo1/hiQixPD5SUWiNbS+BxHEPf2h0vEFyGIJbowepbuIOCjyp4sLj0pkECz1xhrFBCcO4zL8XRbU5iym+aYsBt3czpxYEMJYgMMFJJMfFNxN8oAdonfzMmqzyVJ3SNe57mXOfUQOHhhUxkYe+Kb082dA5OChPco2VROqTjzH5j/cL9Brgrok9GM/qhdLmmjeGptQWA7Cw3eMOdC+17GIRJafXGc8tbG2vonQI9ptig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLC3TNJH+J3XwlpXRLKPClYBlhgblsH5nNrkcAgJQoM=;
 b=sQnLZ71CuhPsHAIR6AsX3+17dsIh8YdqLGYY9IoNXd+uR0R9sn/xwKvYqnnbYEddyk6Vh1eS95fm8qXVGb7FM2Ni9Of/nmFKx2GEH4VjrLVqHjPzIa7+ebYIhpuew6bIpJzwe2GNSIAwtoMOmAoQy1kg3B7x8cF8JrZPC0kEFknu4DQfhWyElfcxCrcNIPzY0XywENiw845cK7dauZn6vuzWyk1EzWBULjsXMhKRgJdgaSCngOF1flXEzZcHDSWNKtX455Ki30weUnLptMw8joRtdGiHqgeThSDDrWmgwUmtMy5l5n8XLNEfQ+7FPQX/PGMNihe008qrb8Ss7DB3ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB12079.eurprd04.prod.outlook.com (2603:10a6:800:310::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 12:03:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 12:03:57 +0000
Date: Thu, 5 Feb 2026 20:05:39 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 07/14] toradex: common: Add missing headers
Message-ID: <aYSHk6XMPFsoMQGs@shlinux89>
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
 <20260203-cleanup-v1-7-4221c13e7558@nxp.com>
 <20260204120855.GA30917@francesco-nb> <aYREqj0kkanBInMi@shlinux89>
 <20260205075815.GA10676@francesco-nb>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205075815.GA10676@francesco-nb>
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB12079:EE_
X-MS-Office365-Filtering-Correlation-Id: a284eb79-f6ce-4e23-1456-08de64aea372
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVd2UmxOOHA3NjZQLzB4ZGRHWkJ0cEEvQk1kLzFGaGpPTWowYTJidWpLbjZh?=
 =?utf-8?B?SXo2M1pxMnE3UzNuK21ZMVpJeTJCMmN5RllWUEl4WXZlclZuUC82UmhTaE9h?=
 =?utf-8?B?NHd1NUdmQTdtdFJvZGJGcHZ6UUYwVEJGLzdQSTZFbExZZXZXcFVKQ0xnckc4?=
 =?utf-8?B?K0Fma1h6bVVTa01TcnZrVDlrOVV6dkxIeE9GOWdZUmNCOEQzTSt5ajRseTVr?=
 =?utf-8?B?akoyUHBaUjEwRWlVZGJ6SHB2cnNPK3RBbEg0WmxjNjIzYnhuaFJOQ1FrdTli?=
 =?utf-8?B?dTdib1FCNGdDTmUySXJOUTVaZXdpUElvSFF2akFodTUrRVlyaFNIaFFQOUVZ?=
 =?utf-8?B?K3hzWXF3aFZjTnk1ZUlWejNtWVhNK2JkMjFab0pqYXBYQzZzNzBHbFBVTjNK?=
 =?utf-8?B?cU1YV3VKS0FzZTFKZDE1ZWZNR3ZBbUNuNXhhSU1wdjZuQTkyQVZXN21IZVls?=
 =?utf-8?B?Z2U2YzJyT2hNc3BnNjdKUWttb2NHajhuTnpqTEI5cG16eFZ4bHpzbzRRY1Vl?=
 =?utf-8?B?NExMNDJRai85eGdBL3VqSlBRYm5XQUtLd3Bnd014d1U4M0hWaHlrU1JqZ3FI?=
 =?utf-8?B?MFNJenpuRkdlbDRMRFp3Zk0wU0FWMXA4VVZBNmVBMWoxb0RNc3NJRU52anBj?=
 =?utf-8?B?blpnSWdoS0g4NjNsVk1EV1pWSVVGKzJrdm5jYTlVN0lPSkdYdWpsaENMaXZW?=
 =?utf-8?B?YWRQdGlGWHRLTVB6N1NUYjhWZFFtazcvTW9MWXRMdzRacFZjVEJPbE81ckFo?=
 =?utf-8?B?WWJzSTljOWg5Zy9ubVkxZXJMUGJlb1ZQcng1cjdEZ1FMSDVaK0xzS1ZqRUFk?=
 =?utf-8?B?WWIxY0lnWjk0M0xXVFJVcVRtMi8yT09iWHAzMjRuUkp0N2V1WnowZnJhMXJS?=
 =?utf-8?B?aEQ4a0dYVDBoV2VSenBQMXc4MDlZWHN0VG9ZS3lnTkJoa285azFZWmRUbHov?=
 =?utf-8?B?RXRVU2dUMHlKSXRLYkJMV0pRY1BVMXplREN6VUVmc25CTDZ5QXdualUrZmNB?=
 =?utf-8?B?TGFhVFBqVGw1WStId3czcktoK1dtSTBaVlRDV0lhUm5FeCtpcmRGWmdneVow?=
 =?utf-8?B?dll1QUFyTW9MUStQTjhvMDYrZjNWSHY4V3RtYXY0aExFMGl2SEovNFptVG5L?=
 =?utf-8?B?YmlxbmlidmhSWE5UbW0xL3IxVWM2L2tJdjVHVDE4SUlUOTlSK2M3ampLQTho?=
 =?utf-8?B?c21LWFVpS0hseU1KQ1EzOGhrbEJRcTJTVmRheUFHUW1nbklGaHBxK0ZPYlNE?=
 =?utf-8?B?N1NwVkhsbS96SURwYUwxZEp6SGV6cUNNbzlZTjVGRjVRRTJpVHVNZnc0NE43?=
 =?utf-8?B?NklIQjFmMUxEa1BOYkdGaTcxcCtHbUl2dVprcDZHMHZ3RTYrK2xveUpVVUlX?=
 =?utf-8?B?RFB6SkI5Y2VrRGpQKzhvSUdmM0dyemF1UVRvUUUwSW1wWW5obkJibjJCbDFO?=
 =?utf-8?B?ZU5wOHQrRU5odGlBanY3NStxRVJ3Z0ZRdHFnayt4emdNQk9yRG1ienhlSkpN?=
 =?utf-8?B?RFdrRWdMYUtqYlNFTEMvQjVkd1BjN054eno2L2h1a09wOWd0dldQLzVpVnkr?=
 =?utf-8?B?TjhwdWEvMmR5bjB2WGt5Y1dkMlJmWDNabTQ5VUJSejc2aWFmcUdBbWNpUmgy?=
 =?utf-8?B?dmRoMDlJc0hVb2VoYVNKRyt2Ukl1ZWVWcVMzT1NaeVM1RG8wN0ZHKzVTbkZ3?=
 =?utf-8?B?ZFNCb0p1Z1pkaVNjbTRYbVhtbnVJOHRkUE1COTJrMFA5M3JiWVdSd0U0WTRu?=
 =?utf-8?B?dk5kVVhyWG1KWDRNSUNOR3JuL1JDdzM2SWQ0YXJYbnlNelhvcS92dTM4dnZX?=
 =?utf-8?B?ajZOaFZ6VnE0Q0ROS1RhNUp4YmU1UVdZK2Z1aE9BSm0vZmVySGF6WnFNQ1ll?=
 =?utf-8?B?U1h0ZUprRmd6RFJXYTJMRlF1OXFna3FzVWRubWpmSTRKeUZGZXlzS3pyRWpO?=
 =?utf-8?B?SkpjbWJMOUVGd21zNkhtU2RObEx2emxVN1huRGJUSHFVcTRicTRSZUZCdFgy?=
 =?utf-8?B?Z1BYNDNMTFRlVzFKVzRMenpKSnh2NHVwQzZJSW5KZU1zVGhWM2pqZ0tnNWZH?=
 =?utf-8?B?aERnNGlKT1Awc1BHcXRhQVBtQ0ZNdkxLL1dxT2lONkVPeitIaWovRm5zY0tx?=
 =?utf-8?B?dWJRTHRjTkdKejVjdHFocUtsNWVvTXBPcjlXeGU1RVZ0VC92UUFISEVKbkpv?=
 =?utf-8?Q?/sZRRDs3KEPvFBmEG5VGRuA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEFxbVBOM3ZtWU5JNSs3aVRCaE5abk4xSlpuUmZ1eUtyTnZiWmVBTFhVcjFU?=
 =?utf-8?B?Vkw3S2R0dW5HTWlXY1hVRVBCUHF2ZXp1Vnk3dFg1ZEVwSnZQRklsTFduZC9U?=
 =?utf-8?B?WDd0cmxZTHFqb25TbEowVGJ6QmdxVXpORk5NbGtXUGpoNWFJaCtrRE00OUhE?=
 =?utf-8?B?NWVtMWVhcW16ZXdBdWl1SEY0RHljNXN6UnFxbWZoUTEybGVld0E0eDFxS3VZ?=
 =?utf-8?B?OUxWU254RWhJdFhyMXh1SmR5aTFpVzdrZnduc0cwbWM5ZWVaZjRFcm1ZdTJr?=
 =?utf-8?B?WUNSdXBhWGcrYldsalVYcHVYM3FjOUVzcHdYaEliKytoRXQ3aXgyVDEyb0pO?=
 =?utf-8?B?V05pQXMxa01EZ3pwSmRKbHorcXErVis0UjJwdW1tcVRZcktRcnZVQVF1MWEy?=
 =?utf-8?B?Z05EWmpjU1k2WGFVbkV3YVI0L2U1VlAvOEZVaVNmV21uQkZTRFVVN0NyejVI?=
 =?utf-8?B?aytUZ1Z4TzNqY0NURXlZdk9Ua3ZYUFgwTGNOb241a2ZaU0NJWUlLMjBQdERw?=
 =?utf-8?B?L3RJS3pIeml2TGIrYzFRL25aZWhpc3p3OU0raTJxUGZUR0xFbFJNd1RtanMw?=
 =?utf-8?B?TGIydkJmeVZ4cUJMZjY4UStNQnBLNG8yU25WVERUczNMODNBcmM3VUs4eE5O?=
 =?utf-8?B?NUI5cHZZTGo5bVpWdU50YWlkS3FPZTlWUVdzS3hMRkxhOHBrdXpvWVNPTU1M?=
 =?utf-8?B?aVpEOFREVUdPSHlxYU92bjdncGE0aTlraW1kTWpFK1poNUpzdmt1OXlmbkpD?=
 =?utf-8?B?b3hqRm1rVHlDM3c5SWZDcDNZQmRTQzExVzV0MXowUVhYTnU3ZjgvQXE5eWpC?=
 =?utf-8?B?bWhGQzZ6OERpMmVtVUZaeVBYY2QvdFBkYmxwdGxzZzVvNXhhcmRNczJUZitP?=
 =?utf-8?B?VmkydFIvZzhXSGpnWVNDWnpsWWJNMUMxOGxEYXFXTnJreERXbTJpMnNwRkRH?=
 =?utf-8?B?Y25CaGVsR3IvaDhaSEkyVjU2K1FxcnBSTTRBQWh1UXlZSThSNDZFS0VpZndj?=
 =?utf-8?B?dVd5VW9Bc1l4UGxOa210d3FHSTh3OHhCdlNsTU1PVCtrRElqSmJtcTFGN0ha?=
 =?utf-8?B?VjZJSWlGWlFqbTNINXVFenNPdUhxN2ZHeGp1L3Q3WkJCVVE3NGpRU1lZUzRn?=
 =?utf-8?B?Tkt1L2VVbUlVRDVNMTljMjlnK1RNUUJyZFNXWi9La1RKdGFzbkdTeE1PVU5G?=
 =?utf-8?B?YUtJb21IM0tIeWFkK1hjaWhodS96MldkTnhGMXhNUGNLV0Fzd2ZoM2pyZjln?=
 =?utf-8?B?Ri9oYnVhQW9FZzRMZnlHRWxveDVLTXYwVHVQWnd0VXNuZFhmWmh2VE5idXRs?=
 =?utf-8?B?Tm1yaXQ0Qmc0ZndaY0VFNk5UT3licldTV1QvMW04a0VTN2h3bkN2QlNacjZ6?=
 =?utf-8?B?REU2dVB3MTZIODJjR3J2V0thZ0RKSWNIMHZ4R0ZVa3c2NFdMSXVxQUg3VFR3?=
 =?utf-8?B?aktjSmRGU2NmRmJMR1NBem1ISGY1R3crMkxIWldoK3pVQzBaNGhWbGhRVUVX?=
 =?utf-8?B?NFRCWUJyTnorUlZSQ0x3RzNuUHJOWlFSazBJdmFmV013RWRWck1iZC9kbWw4?=
 =?utf-8?B?NVJBSElnU2IxeGdkSjZSZUQvYnBwZVQ3QXU1dUV2MDUzVW8zVjR4cnZYZVIy?=
 =?utf-8?B?V2lVWWdpd0h2bmVZVVk4YWJZek5MQ3BGU2I5Qm5mMlMrL010bzB5YS9mZzJn?=
 =?utf-8?B?dHB4V25zZDFZbVVMakJ3RVZTZ2lRZkh1N0w1UkVFcHltd2QzaCtiRVZ4eVVx?=
 =?utf-8?B?dHo5R2tGMGtaMlNmcU56c056K3k0RlJHSFQ0Y3RWQnhKRU5kRnloYTF2aW85?=
 =?utf-8?B?V0JqZ0tuZXg3OGVTNnZMU3hrVkgwTi9sR1ozYlFmVVpqckJSYUE5YWZqeXd0?=
 =?utf-8?B?RmxMVXNUQUxqK29HSDdzRUFNcllCcng0dlRrU2lKdnpMQlNVVFNoUHB5TUpB?=
 =?utf-8?B?TjB4TU9zWENPOERQOEZWSkZwQVFGcWZOUHhlaWJ0cGNjdm16UmpLa3huSTI4?=
 =?utf-8?B?aDZLWWFtaGFxRElVcXdUdDNTckg2dWFBRkJ6ZkNSdXBnbFhLRWo0RW1XZHRo?=
 =?utf-8?B?bnl0b28vTitYdkJ1WlFJZzkwNjMrbzVJeGJoMzR5NEdNMXh3QlIxNWVyb3l1?=
 =?utf-8?B?cDg0N1NtUTVveTNiYmZheWRZa0p4V2U3ejM2R1pKU3phQmNrNEFET2hKY0pG?=
 =?utf-8?B?VlB1TlB1NlVuRnk5aUdFTlIzdE9WZGxORVd0Q0p3a3lpRWhBdlY2OXM1SUF6?=
 =?utf-8?B?SThLRmRXTjZhVmM0OGY2WkxqOE53d0FtcUxtZHNCZnhyOXJOZzh1V3MydkVn?=
 =?utf-8?B?dmpMeGlMTkJaNjhXVW9McnZXYUpqc0hOcmFSWm1kMnNTTHhiMGU3dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a284eb79-f6ce-4e23-1456-08de64aea372
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:03:57.0875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzZHoYcI39Zn4ZPlNmA6T/JL3KuLK1EM6+ZRXUJPincDq2AXQpyHKETVh5KiVhRVxaHN9L/xWYxzUaR0ztyKKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12079
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

On Thu, Feb 05, 2026 at 08:58:15AM +0100, Francesco Dolcini wrote:
>On Thu, Feb 05, 2026 at 03:20:10PM +0800, Peng Fan wrote:
>> On Wed, Feb 04, 2026 at 01:08:55PM +0100, Francesco Dolcini wrote:
>> >On Tue, Feb 03, 2026 at 06:41:38PM +0800, Peng Fan (OSS) wrote:
>> >> From: Peng Fan <peng.fan@nxp.com>
>> >> 
>> >> Include linux/types.h and asm-generic/u-boot.h. Missing the two header
>> >> files will cause building error after cleaning up usage of
>> >> asm/global_data.h.
>> >> 
>> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> >> ---
>> >>  board/toradex/common/tdx-cfg-block.h | 2 ++
>> >>  board/toradex/common/tdx-common.h    | 2 ++
>> >>  2 files changed, 4 insertions(+)
>> >> 
>> >> diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/tdx-cfg-block.h
>> >> index b28033d8332e09d063a6a8ad1d4e334703077f00..067daec0d776070b0b53fc26d1043d6eb781a527 100644
>> >> --- a/board/toradex/common/tdx-cfg-block.h
>> >> +++ b/board/toradex/common/tdx-cfg-block.h
>> >> @@ -6,6 +6,8 @@
>> >>  #ifndef _TDX_CFG_BLOCK_H
>> >>  #define _TDX_CFG_BLOCK_H
>> >>  
>> >> +#include <linux/types.h>
>> >> +
>> >>  #include "tdx-common.h"
>> >>  
>> >>  struct toradex_hw {
>> >> diff --git a/board/toradex/common/tdx-common.h b/board/toradex/common/tdx-common.h
>> >> index d446e9f1d5ca7d3d5a1318b389393d28854e2263..db3369a8f9ef9b409c53c45e94aa5f22933a44fa 100644
>> >> --- a/board/toradex/common/tdx-common.h
>> >> +++ b/board/toradex/common/tdx-common.h
>> >> @@ -6,6 +6,8 @@
>> >>  #ifndef _TDX_COMMON_H
>> >>  #define _TDX_COMMON_H
>> >>  
>> >> +#include <asm-generic/u-boot.h>
>> >> +
>> >
>> >maybe just have the forward declaration?
>> >
>> >  struct bd_info;
>> >
>> >and that's it?
>> 
>> I would not add a common declaration here.
>
>Why?

This is board‑specific code, and explicitly including <asm-generic/u-boot.h>
makes the dependency on struct bd_info clear and self‑contained. Forward
declarations are more useful in common code or headers to avoid dependency
chains, which is not really a concern in this case.

Thanks,
Peng
>
>See also commit c3dc39a2f85b ("arm: Don't include common.h in header files")
>
>Francesco
>
