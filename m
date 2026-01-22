Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AB3C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FF583B27;
	Thu, 22 Jan 2026 00:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YDTEKt2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A18583B21; Thu, 22 Jan 2026 00:51:39 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F326C8313B
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4nsSiohGRkhvB/HILIfimYzygfikUOrVDUVgMn5Dlq15cYmhgEX6NY1EJMCV6RC2DMHXQuG4uVq26bJtKNK4ykGFt5G3CyRIEUB9IcaE/veDdbPCSs8/JSZgrWgyElncsKe9g/vqaCuD1sc57+43HAEtBXBoXdRHC9qljxp4+a5gXFWObB2d0tvCe2y2IUiE5VUGLH57Xztv7deBj9RljkO5YrBKudS+vSa7Zn8k7OQn+wC+1FFxs7iqwa8zzlMLEQlX7aBsXChLd5knbeUQea5x30lRBMIEP9wrdZhbM44I+j+Lp9CGbRuzUlHe5kjRsy74rjray/+pQyYQA+A/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRkuWfIEgwGqBvRlD8tOQaDJdyqVt3PgG+OXuys4vq8=;
 b=DJ/JJyodgpbmHQ012ug8aWnU7SiSrQ0+U4V87zf9dJbj69yLfghjW4cresetArlwi4McAC/N2LoOx4xXCbnqYUVhp9oW6BPnVx9WDDZDs5nyDosmw+ZtOyh2JpBJ1JRY0oDN638EwJms3sVm41ldxJ242R412gWt+eUpZvkV01ed6Zjq0LEmrut8hOOnjIjE/Rootj0ibFgOlHgzG5sE+JCGwNKOuRY1co6ZB16zvSJ1O+l9vjRF8hn9f7566Fl7eTg5jrw+4yzAxxboM/38KBQG9Q9c9CucxGb+xny8PNIdPJvNG01RW/2eqlSsnTNpSNT8cS/YMjt4Z5J26fLvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRkuWfIEgwGqBvRlD8tOQaDJdyqVt3PgG+OXuys4vq8=;
 b=YDTEKt2Coas0zoY9vItcxYEy0eCt6nvdyFUL6OumKX5fwtzO1KgjIzQfvYGfop8sH+blE4/SRY3Kb1038nVVGAi0cWguKYE36GdC1HQ+6y5xhdxigZtJPPmo61PWUOUSySN/T9XxQX37DCtXxlEd5T/CuM0Qk5cBrZ1uvgJP8gQdWHBFsDvTYUZUM7ldS1ILTK+3IIPTPMyrzBHK0EfPItNtFlCJJ5GXnGOmDpowKd5Ov8ZT6Wv9+/9AyuS+wBRw58BFZ/6dHIwFdZackJtlELuEcfpksHAe8AHVkqxsYIDLrOeUj5kNr1mwj94ZBKPjj1WJC7NSLN2Qc3JJ0MC0uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:51:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:51:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:47 +0800
Subject: [PATCH 04/12] imx8mp_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-4-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1f217f-152f-4a9c-45d6-08de5948014c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkR0MWFRZjgydGlLRFllbVlTMmVjRGpFcGFOdEsyYmZ1RTRkeW1OSkFScjg5?=
 =?utf-8?B?ekJyZkZ2MWh2eFBRbUZzbVhQQ1RabmpFMTdYUnZpcHBpeEcxL0xPdy9mcEVJ?=
 =?utf-8?B?R2pmbzNrci9lRVZZZncvTTNFRzV3OVZNbjN6QlJQL3c3ZTRtUWZEbkJuRGJp?=
 =?utf-8?B?WmcvdlN4YXFUWTZ6dmpqZWQ2NnQ3c2RpaXg3MWdkaXYwVWdxZ3JUbkZ4WDN2?=
 =?utf-8?B?UmZJamE1NURaRjNhM1FmZE5FSVQyYTBhbTVnS1Q3RWhuMmZFNno5aXhpN01F?=
 =?utf-8?B?UGF1THZUdFp6QWp1b3hUaDJJdkZmc212YjhCWUZqSG5rUHZ6cGdHU3YvdzE5?=
 =?utf-8?B?dTNWNHIvNnUrbFlKVkxyekpLNFdoUzg3OTFPcDlWUThobUZORGl4QWxlV1hq?=
 =?utf-8?B?L3kwMzdzQzdRaGdEQUw0WGd2bjFETkIwSG5YaG54VTAyZ1kzSXhjZkt4M1VV?=
 =?utf-8?B?OVpscTRvcUdsOC8zVjA1alJCZ2E4ZTRHNTNUaC9zZW9zWjY2bWxQcE4xVUcz?=
 =?utf-8?B?VjZtMzd2Zkd3b2tTVkc3OGM5cDRya2x3T1lPdURSOGRIVDVidkk3Q05RMWlW?=
 =?utf-8?B?dXlZcExnM1NzREpCMVBWQm52N25Odm9oK1hSMkVOcUVOZVM4aXpPbXdtSWtS?=
 =?utf-8?B?QzNtT0U4MHhzeUhtTU5mVXlkNHFSYkNNS251c011Q3FWUndJUGM2QjlsKy9J?=
 =?utf-8?B?K1dlWS9wMGU5ZFc3OFcvN0t4bmN3QWZUQ29uS05YSUMyRjZGbXo1dnpHSFp4?=
 =?utf-8?B?TkU1aFR3ejNZVE9FbDFRR3AySDFzV1k1THMvb3dudVVzQVNoWllyY0RRVW5v?=
 =?utf-8?B?OFhrc3hpUDRQZVFqd2RUbnFKQWtVbXVVdGh6VWhEamMwMkMvVzFIU3ZMbEth?=
 =?utf-8?B?aWpKSjZrMldjNXB3WXFUQ2UvZEtLZnZ3OG1icnc4TGpRamFMMTM3RVlncXJ0?=
 =?utf-8?B?dXVoMWNJNmprQVl5WEliWFhaeVh6dDQrT0FhYlAraS8rQVljNFNTSVFKZ21C?=
 =?utf-8?B?NzlrZ3JaY0VXVW1kODZiK3lTbG0zKzZzYmp5RU85Y0x0alkybmlZRUdtWXA4?=
 =?utf-8?B?SndXOUs5SWNBREpwNkhZNmdWMkVUNzQ2azdEN3NqYVE3eGNPVC9jRFF3RDRX?=
 =?utf-8?B?Q1hoY3V4K0xhSkZZZ0U4VXcwRVVsaW9WTzNkSythemtNdUF2NmY5Yzd0S1Z6?=
 =?utf-8?B?UzRVRVZWRzExclRSV2JtblkzN0VQaWduZ2srd2VZdUVHT24vUDlUOTFDbmdT?=
 =?utf-8?B?RjhiTlg1cEUrQ0lFakw5Ui9ScVhJU2VZdzN1Y01sNWZvakt3UGpJYUNBdWNj?=
 =?utf-8?B?MU1GU09rYjFtaWtRMkpJZEdJMU9jdS9pSGpqYTI5ZXg2aDFkYUVlUEZUOFFO?=
 =?utf-8?B?OTgrWm9XanFsVHlUZTllV291dmtaNDhwMytuUWJVVUNNM1pKNERYdGFyOEtG?=
 =?utf-8?B?dXFiMUZMcHhiZnRiUnUzZGs5VTFPOTJkK25WdnFOR1ZnTUdWdXVQVk9PNjNx?=
 =?utf-8?B?N0s0ZWFUM2tGQUhIckdvRVY0RVFNVFFZMUEvWldybnJDZ05oZjQ5aG1QeEdp?=
 =?utf-8?B?MTRCbXprcGxqSE5ZS2s0VlVBRXVHeDZMa1B4ekg0VXlzd1ZJbDZBei85bHlk?=
 =?utf-8?B?QmhVdTRhUkd6b3lJd202TWNGaEthV1JvTVJPcVhWSnZtMUs1dWZCN0oySDhS?=
 =?utf-8?B?UzZFeVd4NlE4K1pvY2kwZXNsZ0x4S2V2cFpmcUZBS3BjM1ZmbHdRWnRWeEpu?=
 =?utf-8?B?cXlHL3Q4VGg5Ylg0LzNDSG9OSHdmdDM2Y2xwSzYrcmp6N0tXQ1c5U2d3WUdZ?=
 =?utf-8?B?d2JCYmwzYW5kZ0p2bklCVnlBMVpEbE9YKzlMcVNuVk9mTGFuWmVhcTYxS0dw?=
 =?utf-8?B?cWtpK2VmRkNQeS9vQ0lBUWlxVVRrcU5YMk1rS2xac1VBblZUUjZRUUNzd1Zs?=
 =?utf-8?B?VTd3cHRiUUI1a3JoUVBGS3VBalVnVldvTk83a2I0Mm56WGNkOFl3Y0QzYlNW?=
 =?utf-8?B?MjdTYTJueXFqV1grUGNWckE0SEVlN2ZQTytQWStBOGxPR1dvSVY3elNwYjBj?=
 =?utf-8?B?Wm9mejJIeGoyQU45QUFtMXZ6NC9FY2NJSjlhdlNGOHcyZmZGSHgvaEsyb0dy?=
 =?utf-8?B?eGEvWElNUEJrTFA0M1lvK0NUU2YyVU02Nk9CRHdvZ01HTEVtYXJrZ1pFTmpu?=
 =?utf-8?Q?vy4/yR1hQ1zsijHhLy2JiUY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWxHT1MwdCtVVEVBUm1RcDJkL3Qyc0t5OGtjbzYzalZKNFYvL0dXWThqSlMy?=
 =?utf-8?B?QjdRcDRWazJsOHhIZmZ1Qm8wS2RFRGJvU2RoYXBrdHdBOGM2MExBS05vNHQr?=
 =?utf-8?B?RzRNaTZzUUZJK0hHOTJZTHdFY1pHUlYrVWRFam5hak13TGpNdUVERndYOTJS?=
 =?utf-8?B?RlR6M3Y3RDE3R0dzUEVENE1HZjJzUmE1UlhTTGlBV0pabHg2RHBYMTk4UjM3?=
 =?utf-8?B?V3l4akwyc1I1dDVIUWpVejd2Q25jeWcxZi9QQmFrK0xnYVhzbDVaT3JjTi9z?=
 =?utf-8?B?cDRtaEFzRkxzTWNWSjFpb0NxcnBRVUJzb2ZOYlBrWXB3TC8xMlJiL3lCSFhz?=
 =?utf-8?B?all0SE5kWVh4L09oM21EeFNPN0lVcUpFRTdTd0l3ZC9vcklxbmxiYmxSUVpz?=
 =?utf-8?B?Z3pTNXRrR1k1bmQ1SzRDWm4rNm1MZnhoZXRwVWZpMDZKellYNXdMak9vckhI?=
 =?utf-8?B?ZFhTdWtkK3M3VnQzVGxjYzd6dlpId0poMG1tNHBHMFNGU3FzbXBCYjNxY0xX?=
 =?utf-8?B?bzh3cUZLQk5CVk0vTXZoeFlZSGNHRTJLV0paSW9NaHhiMW9FVzlOeXQxVkVn?=
 =?utf-8?B?amtmZGxNQkZrQTVCdnE3MnJJa3Q5cVVaZ1hEN2tSVkZJYkhUaFdzOTVCNnpR?=
 =?utf-8?B?RFdNazhYOE5ZTTJEU3JGSU5wR0JlVWNtdjZsMUpJYmVscHRtditXN2lwaXFz?=
 =?utf-8?B?dGtpYkV1OVJjdUtGckJ5ZXF3M3grTTV5QXAyd1ZRalNueHBsbGNja3JZZXlO?=
 =?utf-8?B?VzdFYWFOekYzR1BXZEVUVDcxVFdrTitnY3JQbDZpSUJRVUJQY01IS0NOZHVW?=
 =?utf-8?B?bzBreDY4NUNEVWN3MEVtN3RiZmpQZFRlZTZXZ3QwbDJCWXNrWWtNY00zcElz?=
 =?utf-8?B?YTZGbUtyNnpDS01PanV3VVd2dDVRQ1VldzVjSTYxaEVWeUFHR1ZNcEZsOTZo?=
 =?utf-8?B?dDMrWWdaZGR6eHNsdTJlWUxsQUhiRGU5MUliY2FIOGo4MjZxcnRpdlg4d0Rz?=
 =?utf-8?B?SUp0Q3psaEV0WVFxRlZTakFtZlN3Njk0VjZzbnVSUkZ0U212R3FBcVBwdm9Y?=
 =?utf-8?B?NXlOVzZMalJQVlFsNnI0NFBnUlduQi9BUElxN3RFK0ZpV0RTcTNxNTNiUCtx?=
 =?utf-8?B?QjNvb0Y0a1N2aXRYL2lyM0JPeERYTHY2ZTUrZ3lqNUtZeDRCRUFSR2pCRkIy?=
 =?utf-8?B?N01YU0lOTWdnOUdaN0NaTXNGVGlJQVBTbnZzZ252OHJRTFV6VjQ3cW5VQ3l3?=
 =?utf-8?B?OWk3Z2tZUG5VUDNlUjVnTnRuV0FLZzBQcDZZaGtkWFZuMDhZdXdWZTdJcUhR?=
 =?utf-8?B?UzM0SFJwVVdVQ28yV1FGWVJFcUVjRWN5cXlVbXJqeGtnU3VXc2RtMUhhUTdW?=
 =?utf-8?B?bG5vckp1RzFsckEyOXN0UUZSbnVqM0MyT3VGL3hWWWR2NGNGUFphcnBMMHpF?=
 =?utf-8?B?d2h5UTFnQ05YUEc0MEt5cmZtcEVhazlualFhZW5UY3RhSGs2R3BNMWtvWThm?=
 =?utf-8?B?bWJ2NzFYdHU3Njd3eW1UdDdPZ3Irc0VBOXdrUlZ5ZE5TZlMxd3JNWHV0TG5v?=
 =?utf-8?B?eXpuZ01IYkJaSGJXN1U4RFhVcXcwUUhPSy94cVlXMGV3STVQYnArcFFXNzla?=
 =?utf-8?B?L3RYSlZhdWhqQjhxSGZGaU42V2RrWkhQcm9VRnFGam1idmtvS1F5R2pMUDln?=
 =?utf-8?B?UDd2QUdGRmF5QjBIaE9CUlh1Z1B4aGlpZU5wVkJrclNRaDd0ZjZhdm9yZmRr?=
 =?utf-8?B?ajdSelc3UDFyV1d5TjhYbmRZNEMvMURuSjF0RGZLNEtubFpoMUdleHFZK1pQ?=
 =?utf-8?B?eU5TK1h1UzlteHZlWUdPNDFuT0RpT2NJZVl6WUY1M1BPQzhWRFhNVHJ0WDh0?=
 =?utf-8?B?WG04L0tSWVJlNXJFVEZpbkhtNkVrdUF2cVdqNVZ2bmo3OUhpWFBhSW5QZ2lW?=
 =?utf-8?B?VTgxS3paUTJhUVpwQVZnRnBjM2lxaU1FNlNVN3ZtNlBCRFhZRFZSc3E2L3h5?=
 =?utf-8?B?SGVKcjBUeUhoc1JKUDhidTdFZE9MZ1drZ3AvcVQ3Z1hMVjdIenJ1S1B2S1pk?=
 =?utf-8?B?ekJVSmxIOGhvVWRibElBVEltalNnVEJ5OVdTQi9wTm1zNlFXMUtHR2ovb3JH?=
 =?utf-8?B?dnhsckdMRVQ1aTZyaDVjTlliYU16bzRNNDVtaGxiRWVIWk5GT0h3dzVnb2Ey?=
 =?utf-8?B?WWVvUTZjZFF3WnVmRjNCWHJaSis5SnplYnNOdlFwcS9FUlIrbUpJclpLT2RL?=
 =?utf-8?B?YUlXOTF1bFg1UTZRRUp3N2tMRmlMWGZXaG95MTdmdFZpTjJsWmpDKzBLQnVx?=
 =?utf-8?B?M1BrbXZFb0VJcUM1SjR2U2JLcVlWcisrTlk4dWZPRWphcDMwZ1M3dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1f217f-152f-4a9c-45d6-08de5948014c
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:51:33.8851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0kYwff5yzwGpAUdh5KcsBr2JhXOypNJFAwSv6MG0lxUpKM4DoVVXnFYDA22B86sDvy+ZrAN2GMpGtx0nWOI8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

Drop unused headers and sort them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mp_evk/imx8mp_evk.c | 2 +-
 board/freescale/imx8mp_evk/spl.c        | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index 732c0fa561d..489e5ad4d43 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -3,10 +3,10 @@
  * Copyright 2019 NXP
  */
 
-#include <asm/arch/sys_proto.h>
 #include <config.h>
 #include <efi_loader.h>
 #include <env.h>
+#include <asm/arch/sys_proto.h>
 
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
diff --git a/board/freescale/imx8mp_evk/spl.c b/board/freescale/imx8mp_evk/spl.c
index 4e6a5830b07..5b4aac42830 100644
--- a/board/freescale/imx8mp_evk/spl.c
+++ b/board/freescale/imx8mp_evk/spl.c
@@ -7,15 +7,13 @@
 #include <hang.h>
 #include <init.h>
 #include <log.h>
+#include <power/pmic.h>
+#include <power/pca9450.h>
 #include <spl.h>
 #include <asm/arch/clock.h>
+#include <asm/arch/ddr.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/arch/ddr.h>
-#include <power/pmic.h>
-#include <power/pca9450.h>
-#include <dm/uclass.h>
-#include <dm/device.h>
 
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {

-- 
2.51.0

