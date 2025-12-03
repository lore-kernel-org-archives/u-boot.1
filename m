Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2B3D12690
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 08:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F33A83F61;
	Wed,  3 Dec 2025 09:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Fqr1pe1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D0783F61; Wed,  3 Dec 2025 09:52:44 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BE4983F5B
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 09:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl4NnudwesWjAKJt+D+YHIC2RCA3x6d0POLfKpNDhBY/KUns5L2mVoCxbyM4CS4W2OLYQS6YTF4FMSDYLnRlWTShTA8wPTjq2qaXmm8cv0uqP0yMdHWV8F4uc4+DLGPQ4r2DS1cPJ1i70r8GzTSzdVdDWXctxOxSRI+r4gdIpdU3xambC9VtZj4+ho9AB8HZD4Cup6TrWekWYyHPdcDBXmAR7K5/YH5Exe0YlDiPvFaZnrcrZW0Xj54A3lfu7oFsct/RYhMcSoaWLhtSRxXpMYSFv60e/NczcwZAnHomqscT7JLh1UL5duNuXNK3lMm4l2bWupJM1wrrG31ha5qZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc1rka5htvcixgADOorZUd6Yogg4ujbsYxBIiZP7QUw=;
 b=JVG0/QkN+nmzyDF2LGwKonxhQI78xP92G4O/ZxWhcc7aXNGGRfj0x+yTr0r2TglJC8O1E7dNC8y0yoaw9twrymqB5myRRh3MCsmokDwFCW8RiLuoVR4oDE9a/CUXwWxmjXXeIfT8gn+J0IKHGEa8ESqUWF3b+0mwvtu+ioYmW45m+HL0bc088vczTf9Vq+4idcGXRakJI8MWGiE0JqS3V93Fb3GCcGmpdOxEGW5VR+wBXm5hK/NjEJdefzw3haBuR7I6mJGFoDeRhjiAHRyUcgCJ4Po+UfUoKm+JsfiTBV0HHrVfzkhGHzcA80LLu+klV5KNl14UTglIaFe6m1z3pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc1rka5htvcixgADOorZUd6Yogg4ujbsYxBIiZP7QUw=;
 b=Fqr1pe1tEDp4XXz4tiIp4y2buntq43X7+r/7LDU6INz6ojEboPRhNFnS0g+p0ARhuo5Mnij2mZ5KyDUfZwu4Lvzc5L6GzNlQEzNFnYNHFeqSCSBht77mAfE3rTrVdWeMi+7VNJLZBfSXvQJ8svvuyfaI+H+yHmOz0zb5jhTmVbjwcGtkPczao+QBur3Zc+31Ws9IZOlsoHRBhXbmrBxWVi4SjyEXa2RTScY3WXynM/beq0CuzN5hPYEYH5xc6PUYMEauWvNBirKoFUgvcvCvgzlMbPVbkE1T1EWLG1CzdUIK9XBSWErj19OamwrXA6w+qN1f5iU0DyoNfGg2kGF3Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB11407.eurprd04.prod.outlook.com (2603:10a6:102:4f7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 08:52:40 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 08:52:40 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/2] Updates the i.MX8ULP EVK board support
Date: Wed, 03 Dec 2025 16:51:39 +0800
Message-Id: <20251203-imx8ulp-v1-0-c05ced433033@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABv6L2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNj3czcCovSnALdRDNzUwujZHNTU5NUJaDqgqLUtMwKsEnRSmVGSrG
 1tQBKsgwlXQAAAA==
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Garrett Giordano <ggiordano@phytec.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB11407:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bdea6f-fa77-44a3-32c8-08de32495072
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THR6TlZZczVmR0VkNGVaU0JvRkc1eFFZeEcrWE1Wd0dqOFAydE5iVlpsU2tx?=
 =?utf-8?B?eUcra0pkWElOWHFXQ0tXSm00VGpFOUlTWE1WRHd2am4zbzlHVkFHMlVPQ3M2?=
 =?utf-8?B?dktJS1JMZldRN2RSRGlxT3pPUk92MVQvd3lsTmlreFYwQTlGWlh6REF6L0Q0?=
 =?utf-8?B?R2pQTUg5dE5KTXpNOHdMQjZmWFJ5cDk4aWJFbTR1N0RJeVBabzNxU3c0QXBO?=
 =?utf-8?B?cHZLV0o2QiszbU5SSnBLSVd5VldBbnB4QWZiajV5b2JUeER4eWFleVJHSU9v?=
 =?utf-8?B?M05IWlpoNk95SDVZSjYraGpVN202RURPd0Ruc0tTcmJjOXhiWXNhYU1NaXhI?=
 =?utf-8?B?U3NHVFcwK21rVW92TnlJc1RSOVBQenJJWkFpT3lyb01PNWV5MFpZTVBJc1NT?=
 =?utf-8?B?b2o5czZyZGtLcEFXbXpFVmJ2dGhXY2dMZXdqYXhzd3k4YThET0ZYTlF3QXRi?=
 =?utf-8?B?VTJCZlhlN0dlMzNvczJnSFZWbWpHUEFPT0lnMFRBaHJnVGNObkh0TVFiV1Vl?=
 =?utf-8?B?UExpUHVKTHNxUFZzb2ZrT3NiRC8xUUdzQkFUK2V6WHlwdDF3anFpUWhWMmlE?=
 =?utf-8?B?NEpWVlM0TzJrOHcyWFpzMXd3clRldlRzbDlqT2VUYWpJay9vaHZaaU9wRnhG?=
 =?utf-8?B?eUpYd253TmhQMzFJR0wwazBQcFlMSk5XVzlLcU85VDBtNkx3VHJHR3NLTUJx?=
 =?utf-8?B?aTZZa2w5bnE0TUtaWlFTaTNYOXRyblZXby8wMjU1M0drbDlwcUFDZUxNdVVR?=
 =?utf-8?B?ekozNXp5a3d0V0hIb2hWaVlvWUxVM1F0NXA0Q2pDUzhpTVdpUUVxWktvUjZi?=
 =?utf-8?B?MldlN0NsNUVMa05aT0lVbGJJVkxnbm9KVFUxV0wwWnR0MG0weHRBQ2hGM2xC?=
 =?utf-8?B?MXMrcG9nQ3ZqUlFCUkYrUkJLdUJtRTc1dnA3SExTWmpqNHl1cHQrZ3lrS3FI?=
 =?utf-8?B?emdtZkFON1EzYyt0WjRBRWptZmM1TVhSZkNoWnNhc2dGUXBwVDRiSlNaSFov?=
 =?utf-8?B?RkxBVlZxajVkZFlveTZSeEdrZ1F4NENiSFJ3MXhvekFTcHpuNmMwMHVQU2o2?=
 =?utf-8?B?T0FNY0Z0YUNVQUVaSEJYeUgyWXJ0Z3lpNVJ2SmVlUzJ6bmxuem5kN21RUUx5?=
 =?utf-8?B?K1N3akYycWs5STY0T21UcXI3TEErbXdYVVNKY3J2M0xOb01abmhMcVM0Z2lD?=
 =?utf-8?B?b0RsY2ZXQjRkWkRqYzc3NVNiZ2pxaUNFbkd4NFQxWHJQRXI5YVJWbFhrS2Uv?=
 =?utf-8?B?WUpudGYwNXhRNWl5d1lEN3dPdDd3VjVEOHQrOE1naFhNNnNBT0NicnpwaDl2?=
 =?utf-8?B?aGxjRlZRWk1ZR1k5cXAvaFovNjYya1BkYlB6NHRLb29PZEhIWGp2SUUxZmZR?=
 =?utf-8?B?Sy81dEw1Q29ZMUJkcEY2UVZvcEVMRjFpRmlXaG9rSWdWUnQ1UFJEK2xmVnhT?=
 =?utf-8?B?MVJudkZzZnRKL0JmOVczekVXMlZUTlBRRTJTWW1DaStWa0Rhc2kwUUhyRERG?=
 =?utf-8?B?U1VKcC9QN0N3cExzQ3BqUFB2RnhSWCtsa09RSXBUNHo3Z1FNbVdVZnVNTDFy?=
 =?utf-8?B?WDhRUGw4ZWVuREZ5L3gybDFjbkNDS0QzZVJITGZXUmNIMThFa2JBYWVMam85?=
 =?utf-8?B?N2RKVlZIaXg5RTJFTTU1bDNZMGo4OHdTUnEwVG1lWTV5VlRlbWp0eHd0UUox?=
 =?utf-8?B?YXNXM2xlU2toUnJtV0dmSi9NQ0FvSHAyS3BidktSSUpOQ2ZwTTA4cWJ1WFhr?=
 =?utf-8?B?cTE1WkZhYzIydkoyR3VSYVV1UDcrNDRXM0FzdnpQbklLVUhnbWNjZmtRQmVy?=
 =?utf-8?B?ZUMySFMzTDVCRDFyQ1VMdEUybnVLRUJEbmN0aGdSK0xiSDZMVFp6Y0VvVjhE?=
 =?utf-8?B?dS9qSG0wYytITnpXTWo5NGsyZHRMNXRHTC9RRDlJakJSWnMxQWFKKzdaYlFD?=
 =?utf-8?B?NTFRaWNOOGRLWmNkN3kyYmtGT1lnS0RqWENzYWc0c3ZoYjhWUlRRNm84c1pt?=
 =?utf-8?B?VFRESjdwSTNKTEliMmp0Q0U0cDk1OTVTMVNsZTF5RlVWdGFUcHpDbVRyVm9v?=
 =?utf-8?Q?12oh7V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJtQnFwTE1LQUkzZ1BkV3lFTW90TXVENEZJMk5TNTE4bnlrZ0NtMXIxU2Qz?=
 =?utf-8?B?QUhhMC8zMmdka2EwK3NYeDJYemJVVHJMWXpHRVo2OGpITTN5dVoyWXZuYjhO?=
 =?utf-8?B?ZlB4YnhGOUgrWGcwekpwdG1OOXU4YjdjSVVkWlY3WG8zVGI5TlNpV1MvVHc5?=
 =?utf-8?B?VGFST1pRMG1VNHpVYitxakdhQzBHbHE5YWZuaFFjQ1FGUTFidUpOTDNyWkFw?=
 =?utf-8?B?cnJLQmNZczFQSFUvNmNnRndoanNmY0J3R3NIYkJ5SGRFWjF2Q1RxNDBDekJV?=
 =?utf-8?B?VlNTUm05WEtSaHdveVcrWVJ4a0g5MzN1QXlSK1FyV2REZmFJSHhTNGMzd3Yz?=
 =?utf-8?B?R01XSnhhY0ZCUzZXZUZLUXdNeWNCcmZqSnJ5ZEY0ZEZYM1ZYSE8rKzlhMjht?=
 =?utf-8?B?MTA0Wit3RnFLWXE0eDY5QjRVRlBXbGhCS3lOcmRnUnhMZyt0OGRXRldnMk1K?=
 =?utf-8?B?MUgzVW16eVQ0RnkwQ0lhYkhqNGVCNHl2enk1QTdEUTNubTBSZkkzVTVOL1FG?=
 =?utf-8?B?ZmFtYjhTazNKMXNtMGNWZGsyZlZIS3NBeG5TdDBpNUtsSW1TZjNHUlhHWXU0?=
 =?utf-8?B?bzdtWTdGRkVOU0FzVVlsc0VRUWNEdXJ4ZG1SanBuSVliSXVzTVY2b3FpcjRM?=
 =?utf-8?B?SGVoQUR1dWRXbWJlaUp3amZ3cW1HN0FadzErSGZrdno3aUVjcHA2alJKelgy?=
 =?utf-8?B?Q0ZWeC9IL2wwMW5vaHdFNlFIMjVoOXI4UHpqaSs2djNOSkUwOXJHSXZiOGUy?=
 =?utf-8?B?cC9ONjh3MmZtTDloQnZMS0NERUNDREZTVUNvallDVk5PTmtLTGN2aUdNWHpI?=
 =?utf-8?B?Uk82WTBQaGR2Y0k0Vm1mejRsSnBQQ2dPbmJiZlF3anJpTUtML0QwK1ZpeWFX?=
 =?utf-8?B?bWVaTG9PMFNneFZoL3E1MlNMRTlYRjJLNmVQZTlJSmpwMnNURkljc05VOG02?=
 =?utf-8?B?aWZlVlc2RVRDd2FTeHpGcnRVdWhseVJ4S1gwcFJRRUJxb2I4ckY5cE95by9N?=
 =?utf-8?B?TUQ5MUtOekZxL2VyN0JkTFVQbHRrUXlONWwyelNNNHp2ajdqMzd5UUs1VzhK?=
 =?utf-8?B?TldPRnBJS1R2QUozeHJUVktpRFdLUitpUm5VUzJyYjhjYUsxeVJXSHA4Nmg4?=
 =?utf-8?B?Rjk5VnNoekZvdnBPa1VEY09UVUQ0N1FTdXMxWXUxOFMwZUtGa2FNRVU0S2xn?=
 =?utf-8?B?aHZKb1Q4OE5SY2pqV3kzMHdxT0h0SGJ4dlBnWG9HUzdzT2pReUZwOFhXbnFB?=
 =?utf-8?B?Znp6WVdLWHUvMm1iVWNDQ0JmTEI0QUV4MXF4SGlVR0VZa3JqZnJwdXB1Sysy?=
 =?utf-8?B?SW1CVEJTVS9iVjRWRGJnNlpLVG1vSkczN240cmhFTVlrUi9pODY5T0E3RnRW?=
 =?utf-8?B?dTFqTGtrWDVCNEpDUGN6cEk3ZmxudTNMWDdoU214cHdPVmIraW5pNkEwdXlN?=
 =?utf-8?B?dFU0KzBXM2hvSjc4NEJxY09VYnZjYUtzQ1Y1aFhWOSs2ZkYwSVBjQ0JUL1FQ?=
 =?utf-8?B?aFJuM2NoZXlYTC80TytyZ2JnMkJlU1BCTyt1L04wZVhUVVdEQklpUVNEdWVv?=
 =?utf-8?B?NndMUzl1NEIwaXptY041YjRmd2VIbVFlSStWZ0sydHpJc3ZsQll1bXZnYUpq?=
 =?utf-8?B?RGdTN1JkUmN4emYvNGk0UVBhbkxsM0V6bkN0RXhtSFpUL2tOZlMrQWs1YTZx?=
 =?utf-8?B?QW1aSkkxMU12bTdVTndQMDRJbEZHQ05sRkFyZkE2UUZ3Qi9TalAwVWxvMUZF?=
 =?utf-8?B?cG1EUlI3RE1VZC9kV243MlI3SDJ6TjlGYW5hVlNNVzNVQTBGY1cwTWhjRFdV?=
 =?utf-8?B?WU9XaEMvOTZYSUtyamtwenFPdnYvdG90WVhDcDFDZzVBZEowMURSbWxwczdF?=
 =?utf-8?B?R1JXT1Y2OWcvWk9QOG0rclBwYmNua2g5bkw5bHduWURIYVkrVlBUR21FRDFs?=
 =?utf-8?B?c1dVbEpId3d5ejlBVWx1VEp3WGNTMXU1VGRZdktMMUV6TUlCVm1ZbDc5a1h2?=
 =?utf-8?B?S2tKUVVEamVBb1BodjFXVVNXTlVpOUFweGlTeERKcFdBbDlVVFdBQ0NlaHpH?=
 =?utf-8?B?STA1RUwrMkllWWRZWkUwc1BHWUhlSTM0UFNkd0xUQXJGYkJZUUoyV21sMGFo?=
 =?utf-8?Q?4M6E/FrniRvWYjJm2G1fuKrsf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bdea6f-fa77-44a3-32c8-08de32495072
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:52:40.0217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWKwX6f11RTlq9MSJjtdYbMYiJWfzrAyRIzTtqzuzC75eU/fd7s9mcRg9OfYWTdNUbhEnaBq7NBSvkpijo1iOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11407
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

Changes for v2:
 - Delete fdt_high and initrd_high from imx8ulp_evk.env.
 - Remove arch/arm/dts/imx8ulp.dtsi and arch/arm/dts/imx8ulp-evk.dts.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      imx8ulp_evk: Move environment variables to .env file
      imx8ulp_evk: Switch to use devicetree imported from Linux kernel release

 arch/arm/dts/Makefile                       |   3 -
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi        |   8 +
 arch/arm/dts/imx8ulp-evk.dts                | 125 --------
 arch/arm/dts/imx8ulp.dtsi                   | 476 ----------------------------
 arch/arm/mach-imx/imx8ulp/Kconfig           |   2 +
 board/freescale/imx8ulp_evk/imx8ulp_evk.env |  97 ++++++
 configs/imx8ulp_evk_defconfig               |   7 +-
 include/configs/imx8ulp_evk.h               |  24 --
 8 files changed, 110 insertions(+), 632 deletions(-)
---
base-commit: 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
change-id: 20251203-imx8ulp-a67582c7554e

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

