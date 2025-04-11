Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3148DC3601E
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 02:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1575482BAA;
	Fri, 11 Apr 2025 04:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BuUSVIpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D47782BAF; Fri, 11 Apr 2025 04:46:08 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5988682B5B
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 04:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaH58ymaQOMcM/mqwwQHUKrEzpjqw8iSNpeFmBOaHCJoDO9Rldi2LucRlAJ+OPvgDdkKlOfQ7sc1c/1ZjvBNRaZm6F9iWbsVn339r096KhHC6f+H7zvmvlaOIw2aAWba6Y1BqZfEZ5lY6TgNUKR5yPxS4Ac5noXX4xp+xNPn1Mn7CmvkcZypDhozYYfD+pLs0xUcc09r9p3CiqKPya8XPEsT4KTjkvWAmpU3nHv7iLlTlK6SdhRFNsr8QG2+brfjmw7+qPcYPjyXtNAT0AWZe3AxHnvS8ePbLi7jsxrWAs5wKsd/5m5DxWTd7ZPpTBCDKF+gtMsRcSaKhtJbs+rP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwuhxBXAG2DMwsvQub1OOVAh7G33sPv0/VU+XcPBqYs=;
 b=rdBGZdhPDHHFPaIXBWq14wmT6MHoK2VOJvT/083hZwAsr1UiprYShTgYtlvXqeDxH8N06PfsSPqS7QUthbh23OrzahX1BSQGveDO4Xrv3qCBIY/kIYCU6IED339wCxmWVS7albB6a5ubRnzLnaA8qt2PzPr7pN4E1r2mFBdbbZrfZHP/dNJZr+LxYXkF9WgzQ1tw6X2bfqvY1xuFGcK2Zg/s0vjmrSsGEmEgvdg4/auFtai8B9qcxzNv24tpJ1LMwWOQ0GJPcdXWFgwuheELHoVmfztl3reeL2rgmyRDMrbhlBQklTHAC37UFB2Nl+EKUwQNtvVQRjN4NkOefnbUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwuhxBXAG2DMwsvQub1OOVAh7G33sPv0/VU+XcPBqYs=;
 b=BuUSVIpfES75aZYVAkeDNA5PcFrBShLgkKkOJdfo3S08CaG9eLfrlJVned2YsPHRkQUaGECJNdGFClPlNeKomiHNk1tKFiyzmSv3Db3DeOqt65LspV6/fXUpNO0fxerv6VvQNlzhOVHhkjQWvkOjlsGkvu7XC+dYl1+1ic5BVJ2N1YyXAFOHA7zO2JzXcHvOmdbrdpT6R0cvgoDX+vthEb0TY3RFb5WGSVDKx4X0/552V9YLKCMFFj48Ilc2D+3ZozQKT9CTjznB5/SZzAXWA8SjjeS2swPGGLA6rcOfKpSWqEozNiyrWU2NjbwXPYwDUA9nIeoi7xH9w8es7UmVoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 02:46:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.024; Fri, 11 Apr 2025
 02:46:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] mmc: sdhci: Fix possible Synchronous Abort using PIO mode
Date: Fri, 11 Apr 2025 11:54:16 +0800
Message-Id: <174434362344.24440.3789381531749673719.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250123214850.3085559-1-jonas@kwiboo.se>
References: <20250123214850.3085559-1-jonas@kwiboo.se>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bbb85c-0abf-4c24-1cdc-08dd78a2ffac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTRVbkpVeUhpOHRNd05STzZIdmNaai9uaU44dUhPajN6NDNENkgxeGtNN0Er?=
 =?utf-8?B?L2h3Zjk3RTI5Q1Z0YW1NVnhMUUdzWlhiQjJRRmlidVNMaThaKzVrUXh4U25X?=
 =?utf-8?B?VkFDZXdqc2ZqMkM3clI3VzZncTB6L0tQR2hVelpQcWJqUjVzL1dPSjRyZHg1?=
 =?utf-8?B?aGJnZVVLS0N1enV4N2V3L3d6VjZIeEZzTXo5VWhLVEhFa1V5UmlRVWRoZVRv?=
 =?utf-8?B?ZE1LYm85aHk2aStKa0ZlbWlHOUZNdnFyajJuM2xYZmlsblBCdFhwTkpGZ2tW?=
 =?utf-8?B?bDFUWnB1R2I1L0dHRiszdjlJRlB0aWVRb3c5ZW1neVhQL1RBVnM1YUhUWG5X?=
 =?utf-8?B?K1F2N1NiakRGOVBpWHhuUWVrQ0NQS25EdWNtZHhKeDJLZXFValovK3hxZ1B5?=
 =?utf-8?B?dlh6RDV2OWlBaWh3SnI3a0JyekhhRjIyc1ZUR0ZLWiswK092ck5zeXJMdFZO?=
 =?utf-8?B?Sm9JZnllbFZVV2UwK242WVRNa0NTV3U2ZGQ1Z1JRQ3IzK2YxK2F1R0ZOWmd3?=
 =?utf-8?B?MjZraG5iWlhXNXNReFkvUEp6M3V6NEZuU20xbzZFSUdNLzNEVUpENmxvL0w1?=
 =?utf-8?B?UUR1cTg2dkJWazNUbzY2bHdGNytNU251b2Z2R0xZTXRaVWRCNmxBUWhuSlQx?=
 =?utf-8?B?UFpBdWZ6QytHME94WURaWnNzc2l5bXZGbHhqdTZKTDJYM3Rrb2FlQlRFS3Q0?=
 =?utf-8?B?UEFzQ1ZVaDBVWFM2LzhuRDVQclU4SVdZVFBjTHVaS3dpMEtVMGxSZ3Y2dTVt?=
 =?utf-8?B?WW9lQlRRU2V3VmhWMTNkSDlpdzZXT1c4K1NyYWw5VTUzWFpCemJVWXM4OCtm?=
 =?utf-8?B?SVptWmo1ckJKZnpMdzNGOHMyZ0ZJekd4T00wMmZWZFJhK1UxMTluN1ZvUjFR?=
 =?utf-8?B?SEV4bitqYlp3OVlCRVZHTGE0ZTNuY0hia0cwd09EZXFsZXArUzBRNkIvRytI?=
 =?utf-8?B?RlFoL3R1V3diVmxkVTNTbUJsRHA2L0dOSlBhdTU3bUlJY3p3dDNuM2JITnVO?=
 =?utf-8?B?ZDdHbjBOSlkrVHlKK05VenZ0WDVkQzQydEpvTUtHamZuUzdnakpMbTZiNDRI?=
 =?utf-8?B?a1hYaTh4dzJIVjRDY0dOSERGaDJkRXBzTm9NOHpONGpncVo1VGw1L2lKNnd2?=
 =?utf-8?B?Q1JZQnkybkM4ZXRpZzBVd0ZScm9FWDhiUmJTWTJYcC9SYmZ6QnJhd1BjOE9T?=
 =?utf-8?B?N3VibE94cGZPblQvOEc0SzdaSm5TR1pJMEV6V2xCbDNZVjF5NnJRdjZ6TGZO?=
 =?utf-8?B?QkVoMjcrWVYydExvQ204MndIWWlYVTNoM1RadTJYN2ErRk9sckY0VVF0Q1Uz?=
 =?utf-8?B?bjJ6dTliNTFwcE52SmlEeEFBL3FhcjdyNzh5c3J3S0VIR3ArbUNkS01Tdkx6?=
 =?utf-8?B?S1UzbVh5ZENOSHlBcmdOL0xXWTcyM0xVdjBVZWZ0NFdOTnNKbHhwZGF0dk9V?=
 =?utf-8?B?REs1K0c4V2NWMTE1S2pPNnB2WElsVGpiekNJRm1uMXRlNjlXNTRycExtSmtw?=
 =?utf-8?B?MlRuUzJtekVYbHNLM1k2TWdrUHBSUWt6cy9DUll0azZtdGNwMHY5Zzdoa0hj?=
 =?utf-8?B?NW0wV0RWbEdhdXgzVlNqRHE1VnR0d01scllkYWM4RlRmVWxRMGtobW1vNTQ3?=
 =?utf-8?B?NDZmVURNc0o2N2JnR25YeUhuS0hDK2RNQThlZmtmUEFucVppVXc2U2tSOGRq?=
 =?utf-8?B?RitSbXZnTGdWOExCSHVzbmlwZVRMZDQ0SXRMZjJEWjhYekFnWTRzODJ0b3pE?=
 =?utf-8?B?RE8vdGF3UDQ3T25kS1hFdGtzdkdndFZyaUhDL2xJSmhPQm0ra0IrWStRWTFl?=
 =?utf-8?B?SFJ0MkFqTUtkSUt6TGV1cW1od0JsaTk0VXBmT2g0YmxnSjFxaE9wbHR1UmxC?=
 =?utf-8?B?N2Y5VUppRk85bGVvWW5ENkVaR0lNRHd2dHNLcXBKMFdkeTA1UjJqeGRZcUhk?=
 =?utf-8?B?ZmkwVE5ubDBhR21hYWxCcEpDSVl1UmE5NXdTdDdWczd2cjRDT0I4TWlOM2xj?=
 =?utf-8?B?RjFMUzJzZWpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHl1SzhHbXFyNVNFbmxCZUZMRWtLemxoVU1oZ0VQS2FjN2o0NTZJUjEwaHgw?=
 =?utf-8?B?WkpuZGZqWlBDa2QrWGV2Rk11NGtpQi9XcGRzd2lSOHVKaEQ1NVM2ZnM0SjYy?=
 =?utf-8?B?VFU5aEtTMTJ4WXRGU1FrbEdKRUR5VHp4czk5R3RrajlSaGVtTEQvdVpPa2NK?=
 =?utf-8?B?SU5WcUtmamJCMmNpeUQ4Ykc1VFJyeWFCdDFSd3M1Q29WejJBd0t3bXhCTGRX?=
 =?utf-8?B?L0IwY2FLWmkyMTF2eWpZWE42L21zd3ZEbDVPekY3dFlJQzhzdWlhSGxQYVpK?=
 =?utf-8?B?NXY1dkxzU0ZpT2NLbnQ1T3NFK2ZTTllIS1N1ZHZmWk56dDZEL0JYeC9JV3lk?=
 =?utf-8?B?dGpEd21ZQVl0Z0ZKd3BBaEsvaFIwRURZTmVHRkp2TEt5eVpiRHNJL0MzcVZx?=
 =?utf-8?B?c2xMSGlMT3NGemRvQ2ZSdlVhMlVZd1pETlJsQU8vUndmNXNmMHQ4VVNJV3Uy?=
 =?utf-8?B?WnNaWTZNM25xbXRPQ210bm1UMFJFaVdVcWF6Y0pGWWl5R3h3emRmd1lCVFB0?=
 =?utf-8?B?cjRiZ1JCS0V1K296cVErcUJFMlpsUE9COWxLUzBra3RkNUpwUkNraTZIdS9P?=
 =?utf-8?B?bWl5ZmJ1L0wvbUxmTTNBQ3JNdWtiV0RxS2cyNnRINDV3M2lFdS94NmhZV2NF?=
 =?utf-8?B?WGpaR2hMbjh5WktISGdFcXFtWEg2d09CM2VsalJCMExQb01IM1Y1c0JwNi81?=
 =?utf-8?B?UkVmZk9CNkxBTnZvR21YQ3UreE5WbXNzUHVhb3ZhZ2Y0OGR0MDFSbnBRTFBO?=
 =?utf-8?B?dnJydWx1S0lWMDdWS2dwQVo0UXJaeEpFOTE2dU81bElOSUE0MG55WTNIcXNW?=
 =?utf-8?B?MjNYWnFVUWdLMmlnK0UzQ2MyOWw1dHdLYXlGcFBTem40NHBMd0ZteUZKd2lV?=
 =?utf-8?B?N2Njb1BGZlMybEErSTlNdThHTmdUVFp4ZFc1MkRMVVkwSnZoR3IyYkY5OE9N?=
 =?utf-8?B?UmFkYi9DQmFrb3QxVWpCa0Z1RUhUSUNpbFN6dUp3NnMxcDdmNjZXdEVuZG5J?=
 =?utf-8?B?YWJ2UEYxVmg2QmdIUjlwNDVsN3liRUJob1pVbkg3OUFRanY2Y3hMMzkza1Jl?=
 =?utf-8?B?dXJtYnVBQ21iejVJY25vK2dJcEIwOTlZMThTVXc2dGlXOVFDWktiK0Y5YU5V?=
 =?utf-8?B?NDlSeE9KZzdkNGZLSTI2SFhvdzdMTWFvd0NVbndGV2lyQVpFNlBrSk13M3I3?=
 =?utf-8?B?cjFxbytZQ3FJTjhncFI3bDlvblA4ampJSFhHdGtqNUZQMHJyMmc4aEZFbFlz?=
 =?utf-8?B?ejBHRERKMDNqbUs2WWpPRHA0U0t0RGNxRUxOdTJSU2JUbHhlekhMdnBmd1dW?=
 =?utf-8?B?Q05FWTNGMEp1T1o2R2pYcEZnNWJKU1U1YXdlNWZSUlZQVDNxWnRPQ0JBSjVZ?=
 =?utf-8?B?Uk1jQXdrYWlXd1BnY1g3S3Y0SGQ2M2x0Z244YnQrM1pBalU0VElwdlpuR2U1?=
 =?utf-8?B?WENhd0lnQU54NnBzMVVFNkx5d2RwNDlSY2ozNmxNdGFVejlPcXBYaXc1aXhR?=
 =?utf-8?B?dHN3MmtKL2FpM3RlUW54MUpQYnh2SEw5a2JORlpGZ1RtTndMTXJjaEFHS250?=
 =?utf-8?B?RjRFRzNFTytiamxBbURDLzEyYjJuaVg2a3B5QnBxUTZob1haYUJJSFU2SHZ2?=
 =?utf-8?B?dWFzVVlZTXAzS2JlOEF5akxoNnNyWkJ4TzBJa3luN0xMUmthQjFFNkZlcE9v?=
 =?utf-8?B?RVprY2xQMVk2bU5abVFFbzlWWHNsU1ZPakR3L3hxeDRiMjFtYmpobDhsVG1C?=
 =?utf-8?B?U1d2aDZrUE1JQ2FZYlh5YlFTSGZTSVZIc1M3RVZ1aWgwUlo5N3R5TjVFOFZ2?=
 =?utf-8?B?Zy9meXdONkpETWZoMlhpSzhOMjluS0tqTStZamJ1WmdjNFRURDJSSk1HV2g5?=
 =?utf-8?B?M2ovTG14bEg4RWlGemdNZEIwVmYxcWgyV1k2LzFjWXp0dVhyODJJUHdIMmhp?=
 =?utf-8?B?dlBlaWR2K2ZBSGNmWnRiU25VWWtueTl1MmZlbHdDSDkzRXRPSms2UHJWcXRq?=
 =?utf-8?B?OUl5M2JLalFCeEZGblpnUktKWXlGYUwrTkQzL3cxRmNxNk9iMUppYThYOFB4?=
 =?utf-8?B?dTMveU5kMmh2VnEwTUJRSUNoaHJnNzh3dVNBeGFsVURqNzM3MkgxV0xOb2Ir?=
 =?utf-8?Q?2FnennNfwK+lxwYmrS2J9NqoS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bbb85c-0abf-4c24-1cdc-08dd78a2ffac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 02:46:03.1285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD+v+zrRZi+yuCwN5ZnpU/GPwv+ABz5lfPwK0BGEqDHxjkhALwV8O1kS3yysHmu6onAXf1Qsr5W56UIXFgRThw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798
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

From: Peng Fan <peng.fan@nxp.com>


On Thu, 23 Jan 2025 21:48:48 +0000, Jonas Karlman wrote:
> When MMC_SDHCI_SDMA=y or MMC_SDHCI_ADMA=y and PIO mode is used
> dma_unmap_single() is called on an unmapped address, 0x0. This may
> result in a Synchronous Abort:
> 
>   ## Checking hash(es) for Image atf-1 ... sha256+ OK
>   CMD_SEND:16
>                   ARG                      0x00000200
>                   MMC_RSP_R1,5,6,7         0x00000900
>   CMD_SEND:18
>                   ARG                      0x00004005
>   "Synchronous Abort" handler, esr 0x96000147
>   elr: 00000000400015bc lr : 0000000040012b4c
>   x 0: 0000000000008000 x 1: 0000000000092600
>   x 2: 0000000000000040 x 3: 000000000000003f
>   x 4: 0000000000000030 x 5: 0000000000000001
>   x 6: 0000000000000001 x 7: 0000000000000000
>   x 8: 000000000000000a x 9: 0000000000000090
>   x10: 0000000043dffc68 x11: 0000000043c00440
>   x12: 0000000043c00440 x13: ffffffffbfe00000
>   x14: 000000000000031c x15: 0000000240000000
>   x16: 000000004001145c x17: 0000000000000032
>   x18: 0000000043dffef0 x19: 0000000043c00000
>   x20: 0000000043dffbc8 x21: 0000000000000000
>   x22: 00000000000f3d95 x23: 0000000000000002
>   x24: 0000000000000493 x25: 0000000000092600
>   x26: 0000000000000001 x27: 0000000000000001
>   x28: 0000000000000008 x29: 0000000043dffab0
> 
> [...]

Applied, thanks!

[1/1] mmc: sdhci: Fix possible Synchronous Abort using PIO mode
      commit: 2057bb4b5160a3668d4785adb6ce0f0d08325c48

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
