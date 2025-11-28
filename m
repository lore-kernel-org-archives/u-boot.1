Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09163D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 13:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F7D84562;
	Fri, 28 Nov 2025 14:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iDrXhEij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F1A8455E; Fri, 28 Nov 2025 14:18:07 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A8184550
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 14:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzRS30P9t2HSzE9HXrUOwnGJGj/b/GMvDXO/P2tMiBpNFZYEKTv9EMIK0wIQfPTFUJEdPQcOHAgbqiutj7BUXZ0uucltl1rW8MU8RKESLt+tMwS+3Q7GZAl344oJ5kk6pGuxR/RbiH7PQgoxi8pjB9rfsFnrTYVWSUHKX1dKprwONFIZSddcwrLbhtf3wdKsvPMwH0Z9X3omhf4fjvXFwciLVO9Omg9xWF7941sab/JS2AZfqCrqD+7Q7dVEgyyJOC37Gmt/AgpTUsVt7zVFkiMy/Go3D9Y4Ox5EXN2xzG0UYFQRuS3mtmHbQu0XZxu9+LEQzxMhM0aLuBZXFx05Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2eVpD5IS4hlCbCAUnr5LQ+OxPjv520gJsmtPcQb4wA=;
 b=zMjE1TrE36Qnl5IkJEsT59iN59qNvGgduuQ8TZNyyEpOyLVNLQ1CF36UuN4dJu48YbJOXR/jln2JHAka5eOdJsrhVynZ3HQUDFT/lx3dMDl508B16kglq22AHASvAVR0gYlAh2kfh+08gO2MXwP+eQzeuntUQ+L/Fs0G6R8wbcmjWGETMtauEGWAItmYczxuEpKn0T1vkXSq7fcqRfC3JzTYeaW9KeWNaqxjLt3bhG7yW+6rW0T1UcU5YyrSpdSWHNVAWmXa0BZr9cZjAeSxkr7GYjZa/nsNuMSBiZjBZVh3pvTh/DQM6/0fz8082QgfJz4n0tQSNTu7S5KE3xw/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2eVpD5IS4hlCbCAUnr5LQ+OxPjv520gJsmtPcQb4wA=;
 b=iDrXhEijHexZda5vLexuOnkkdBeeVYYe1bSaZg6zaSX/54v+O67jeHX5bQ5mlKh/5GVPnhqWwPhaOwwoEnY/8MD0ef0Gptg3B1EvA4t6nZyhMzMkXbIcM4mfXYt0a/wlemDKz6DHxnxjNLHvv5516tFHeg2C2xtEMtWKbYCFhnCJfLo5kqdsp3rKmTiLdOGnpG4pgbPj0f+VMca65etYUpuNPp30YAWMNdRSarq+i83yKN2rXL++wN9Ed+ElTGcW7I7zVjG58gQqGllKD6/hEXCRuQRVDp1Z4d8NxRDqxY7Ldf49RQ7H+/m6NgLPLMJYLeSFphLZ9qlSe+Fjd76UrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA2PR04MB10188.eurprd04.prod.outlook.com (2603:10a6:102:406::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 13:18:03 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 13:18:01 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 28 Nov 2025 21:16:35 +0800
Subject: [PATCH v1 3/4] imx8ulp: clock: Drop
 CONFIG_USB_MAX_CONTROLLER_COUNT dependency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-usb2-v1-3-25ec5ac127ff@nxp.com>
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
In-Reply-To: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|PA2PR04MB10188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da546bb-f6a7-4046-0af5-08de2e808e88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c3prWS81WFJCMm1DQ1cvNFdHeThjamZVUGdDVnE1N0dYSE4yY2V0Z0R4Tmhv?=
 =?utf-8?B?NERlS3VVNmV0QVdBUFM2VGdoNy9oSDBKV09aZkpoejRlcUlyUFBURWc4d3I0?=
 =?utf-8?B?YVJ6Z2V5QW8ydE5jOXpsMVB5TENOdGtydnFRb2VYd2pDaGtoMms3Q1JpOEwz?=
 =?utf-8?B?dDRsVEVUa0pVOUZpeG1oK0x0T3FyNDFUbk1XMDcrOU5XOG94V21ZWnlLTGow?=
 =?utf-8?B?QzR1MDFlOHBOc2lnZDNWUHdmWm1TMVFQOEdiZFVDNHBwL0pVYW1nVTBzMDcw?=
 =?utf-8?B?VEdoR3EyZEdaSjlaUE5keWtobkkrVmRHZ3RXWktmK2NBdDRBQVVJZ2tRb0dK?=
 =?utf-8?B?L1lRU3hELzcxL3BYbVhLUlUza01TSkVWZnJ5QWs2Z3drM210YU1ETWp2ZVN6?=
 =?utf-8?B?U29aSGtuZ0w4dkVqYXM5RVZFTUh6Ri9qNlpjeldIdVFpQzVaZGYvL2dSVTFa?=
 =?utf-8?B?M3RrYkJvWC9UZnp3d0JiZVZqY2t1UW9ab1pSRUVReWVpTnI2cWQ1WGVYTmlO?=
 =?utf-8?B?dnJZYUdKN05Fc0YxVGFYMkt1NkNrb1VVWExTR2htdkZleUs2SVB2TEtSdHhH?=
 =?utf-8?B?c1ZMM3lEL3FoS3FSbWxYbHdwQXZlb1Z4TC93dTJUMEwyZnRJaW1tYmlieVNX?=
 =?utf-8?B?L1J1ZE84VFBiUnc2NHVVVlE3cFBiOER3N0tWbDVXVnNpcWhpMzRZVjkwQXdE?=
 =?utf-8?B?WEdKbWFqaFFSdm8yTjVvQW1VdldHaFZPaS9SSG5qS0xpRDIvazNmQXVjOHQ0?=
 =?utf-8?B?c0V5dlV1bGRoTnpyNEwvSFlRdnRCSmM3K0MwMVowNmNFby8wSFBTSW5rRmM1?=
 =?utf-8?B?eUJIK3RTV2lwcWRBQ3lkWlpKblR6TktjZVNEbjVzdnVYOXcvckpvSnVqZlVW?=
 =?utf-8?B?QWJWTjlVTTNDMjkrcVJaZUpTOFkrUGlJc0kwTmdtOHczQ1owczQ5VzZhNy9B?=
 =?utf-8?B?ajhTUnpxcm1iY3k0b3VxS0ZiY3BxZ2pDT3RGRUxSM3VwMko3a3JoazUrVWJB?=
 =?utf-8?B?NW0xU0tWT3d0SWgxcVc4NzVFRUlxeUsweG1pTnhsTjkxZkN0K0pEOUtINm1S?=
 =?utf-8?B?Y0dRTUJYRDJSby95Z0VyWWN0N2lFQW5MYXliUUh0QU9Qb0UyRElCeXVRQmdz?=
 =?utf-8?B?YXBoUVp1ci9sSXlRKzgybEcyZFVvSFg5UjNMT04wUjFqWnRXQVZEYVcrWDZq?=
 =?utf-8?B?aTcrWVV0UzBUVnE3TmdBT0ZBZVExSmI0V1RkaVd0eDh1M2gwOGRDdDdSdlA2?=
 =?utf-8?B?VGRsUzNGbFpSazJpQUVMZmRhazRKeTA1TzZoVXMrVStxL1pVd0RIVVc3czE2?=
 =?utf-8?B?MmJFRUc0WUc5emFsc0ZDN2R4cFgxRHNkVndHTGtZcndEcWdWcWQzd1UxYUJK?=
 =?utf-8?B?aSs0YVpoTnFQbGFjUFBLcEUrOEI5V2xwOWhIcCtaNU85ZkFuM1BZOGFBZjhK?=
 =?utf-8?B?eGl4QnRPUnQ4bTdtbTZWUmVzUElhdHBSSXhmcklHWDVlY0RIQjNNcDRmQTNx?=
 =?utf-8?B?ZFhKemVWbGxCYWw2ZmVZak1LVkxYUm9wL0lla2EraHZWNStVWW90c2lpYU44?=
 =?utf-8?B?UGF1S1BMRmpRRXBHRitBUWdEVTYreXVzRFBUK3JXT0dGcEFGeGc0T0Ixanhp?=
 =?utf-8?B?YW5ycU1rekx5UFFoUWNiS2drRVVRdnFCTXc5K05iQnpZeVYxblduM0l6V0JX?=
 =?utf-8?B?L3E3YUJJOHNyL0tIODdWcVREbm00YUdKZFZsV0lBN0xFV3ZQTzVOQkVjQ0th?=
 =?utf-8?B?THRDWGdGN01yZmRFSEdrRUhQMVYvNlFGVS9TU2l5K1hqb3VqcFUzaWdKMGdK?=
 =?utf-8?B?Z1Y4VWlMbW9jVWh2ZUtWRXpxM3RUNDNUQlRjblV2dWFVU1dsMGVjR3VMaWhp?=
 =?utf-8?B?SUFZV25BdGthYkhxLzZqdFZnZWpmbVZsNzBvZW85eXJXdFU0UnBzK1NiZEZz?=
 =?utf-8?B?czNyN005RTRqV2RSUThyRDNLSjVqMTdDcnFCamVsN2hkUGRLUUpYY1h4c2ps?=
 =?utf-8?B?V2Z6MURkMWxDQ0VVSUh5aWpaUFNIYVVMSnhHamJYV0dERFVvWjVjNkorRExK?=
 =?utf-8?Q?aYRBeb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlrL3p5K21RUUpaczhOUmZ2U1lhNFIzTXBOWitSR3VubUhtSk5OeUtuM1ZF?=
 =?utf-8?B?WXQ5RUY1bFh3ZGRVTHNxY0l2bHBmTGpOektWVTdFYWljMmlIRUNWV25FN3BP?=
 =?utf-8?B?ZzZvdGsvQzRDbXppd1Bwd1lwNmZOL216Z3RuZmg0SVFGZVpxNExYMXBoOVVs?=
 =?utf-8?B?MEZDdUpSSG5seXZ0V3MwMWRGcUpMUE5NODlGR1JlN050V2czM2RESDBIdjNX?=
 =?utf-8?B?a1JLYThBQWhsWFVoYnl0MzYxNzloYVV2RkRwV2lHUkl1M1gyU2pKa2dhd1pE?=
 =?utf-8?B?di9CbHBmOXFCdmg4UHBoY2VKVUJldjhSRW03eEZGYUVkdWs1dnBqbGFxT1hB?=
 =?utf-8?B?cmMwTkZkdGM3NmRTOTZhWlpPWlFUeEdtakNyeUJsMGVkd0x3Vk9QSUdlanhv?=
 =?utf-8?B?NnpKUk5DcDNpbkhsdzlRK2tCL2lGejNPczRVcFNtVm8xd3hyL2d2T29IZGJJ?=
 =?utf-8?B?ZVRQK1BMdmcrSUFSSTBpSVM0c3Z2cW50a3hLblJFbmVoTWZuMHVDamlGbFFP?=
 =?utf-8?B?Snl2SEtkNEx0VkFISVQ3Y0xaMjJrRTY2MUhOU2l3RXl2cU5nbWU4amhQeitR?=
 =?utf-8?B?UHpTS0N0Z3d0d2tsYnZEU0ZaYmdtOVVieE0rUkk0SWtnMERQcHNkcDBOZi9x?=
 =?utf-8?B?cjliWHZmT2dtd0V3ZHNmV1JzblVyZFMxdnc0aWNLUUYxUENuWTNHUHZFZXhL?=
 =?utf-8?B?Z21qYS92aW5vWjcwM3I1ck9zMUpqYktDWEVNbWQ3cGkrekkzVUd3UlpyV1NF?=
 =?utf-8?B?NkRDYWlzRGsvQitEU0FaaDUzU3BRemxLM1diaTBpOFdBOEhYUkxlSGxGL09D?=
 =?utf-8?B?OElHT1ZkU1k0Z1BnelV3WS9IVnRBOWNLWDY0Z1BiYVAyRk5DRytaVytobFBx?=
 =?utf-8?B?MEcxVUNyd0ZuQ1czcmdzclN2bjFjOE5CYVBVcWh5WjNwM1U3REViNUZRdWJm?=
 =?utf-8?B?OHprTE1xbllmd1NwNGhZeWdwaUVHLzhwNVUrcCsxK3ZOTXI2UmU4cUJPcGpr?=
 =?utf-8?B?dnVUS0JxakhoUVlpc3dmWWlnVzhDNHJXN2xEMTJqOWd2LzZKWE5pb2FhcEQ1?=
 =?utf-8?B?ejNwQXFxYWh4dXJzc2lLR1NOaXQxZWk4RGh5L3dBblpZNVh3THV5UmlDb1V2?=
 =?utf-8?B?S0tlaUlTU2JleG8xUS9meHEvdktnUkdibVg3Y1VnQWVxTkQ4TzBvTDBzTllQ?=
 =?utf-8?B?OUYzc0JJWXp5eENlSjcrY0pQV1h3TTUyM2txNU1uUFdVUnRnZHdMaUdrTmdB?=
 =?utf-8?B?YmFoYkNOUFg5aHVGaFZJRkNqTXhpNnBUbGhyS2Fhb3pIWHRscDRTMVQ3dUUz?=
 =?utf-8?B?UXhOdmVOYlRKdGFTeUNQVjR4ZDB1UUlPT3p1ejhoQ3YvSnNEbDQ5Q1MrK2t1?=
 =?utf-8?B?bU9FSHNvaGcwSDRhOHlObjZOT05rUm54YnBzdkM2V3JGcFoxMzV4VkE0Uldk?=
 =?utf-8?B?b3NxcGNDL3VVTWVNeDQxZ3pSekgrY2diWjV1dmxKanpMZEJRWVJiemx1eklp?=
 =?utf-8?B?YUZhRWF3NEpUQ3V1U2F3c29WRFdHNnBQanlVNHVYcVhKbHRqTmxQTS82dzRP?=
 =?utf-8?B?OHRKRGowWEZHYWFHZk9HZUlXc1lpcm5qUjhWWHJ4RTNsanYrcUZPZnpWNGNv?=
 =?utf-8?B?TXRkd3hVd0xTN0dWRjVML0U5YnNlT0UzaS90WnJpeHFUbVA3NlhnTlFlbi9R?=
 =?utf-8?B?VzJGWDlCVHlTZ2c4b3F4S2pENkp2RVNES1Z3UEdienFScEJkaks5eXRIR1VO?=
 =?utf-8?B?VllZNnpkUE5QRmpXZVk5SUZYSys3U2ZLbWZRaFBxTWZ4K2JOWVJueVhRQTJW?=
 =?utf-8?B?QWo4NFJ3cnV0WmRwbDBDVXdTYm9ZVE1mV24za0NGRFNMdXUzVERLOTEvdVBV?=
 =?utf-8?B?VGhnL04wcXFSNkNFU3dRbnk3MFBnNXdsUk5ibzJNNlM4KzhRNDFRbnhDQ1Ba?=
 =?utf-8?B?c3FoY0lud0R6Y1hUeFByVCszTGg3YkJySUs2SUNNYWlzeU1PT1ZBd0FjTmtl?=
 =?utf-8?B?YWxRWi9JcFd5amxyVkp0bXZrQVhPMHYweXo1My9hWnM4SEpnMFBZbGJJNHgz?=
 =?utf-8?B?aUIzM1psYldKVUJHbG1LbWVIMVpHWjNDU1FlOEZxTGFNaWFmY3lkd09VaTMz?=
 =?utf-8?Q?GCLYqszqbXif43n78NSDpa1iY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da546bb-f6a7-4046-0af5-08de2e808e88
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 13:18:01.7217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2RQoyYYCD6YcJx1lyG71KhrTeAFxgfPjEJRXWppBJ7Lee44reSbm0Vpi8rSGTfsu8YZ8KPynrMDsSaN/0mRbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10188
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

From: Ye Li <ye.li@nxp.com>

Remove the use of CONFIG_USB_MAX_CONTROLLER_COUNT in
enable_usboh3_clk(), as this option is relevant for non-DM USB. The
i.MX8ULP platform uses DM-based USB, so this dependency is unnecessary.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/clock.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-imx/imx8ulp/clock.c b/arch/arm/mach-imx/imx8ulp/clock.c
index c390f20d769..faf81262160 100644
--- a/arch/arm/mach-imx/imx8ulp/clock.c
+++ b/arch/arm/mach-imx/imx8ulp/clock.c
@@ -286,14 +286,10 @@ void enable_usboh3_clk(unsigned char enable)
 		pcc_reset_peripheral(4, USB0_PCC4_SLOT, false);
 		pcc_reset_peripheral(4, USBPHY_PCC4_SLOT, false);
 
-#ifdef CONFIG_USB_MAX_CONTROLLER_COUNT
-		if (CONFIG_USB_MAX_CONTROLLER_COUNT > 1) {
-			pcc_clock_enable(4, USB1_PCC4_SLOT, true);
-			pcc_clock_enable(4, USB1PHY_PCC4_SLOT, true);
-			pcc_reset_peripheral(4, USB1_PCC4_SLOT, false);
-			pcc_reset_peripheral(4, USB1PHY_PCC4_SLOT, false);
-		}
-#endif
+		pcc_clock_enable(4, USB1_PCC4_SLOT, true);
+		pcc_clock_enable(4, USB1PHY_PCC4_SLOT, true);
+		pcc_reset_peripheral(4, USB1_PCC4_SLOT, false);
+		pcc_reset_peripheral(4, USB1PHY_PCC4_SLOT, false);
 
 		pcc_clock_enable(4, USB_XBAR_PCC4_SLOT, true);
 	} else {

-- 
2.43.0

