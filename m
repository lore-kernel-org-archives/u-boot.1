Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC201C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4C3581D65;
	Fri, 21 Mar 2025 08:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bKjYhpzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF31E8129F; Fri, 21 Mar 2025 08:16:40 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EBDA81D65
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9G/5nKZmxjhWgEf6nrQm6Oe2M0tyIXmUD3DvWt7WNviTgep/Uzk6MScqD/H4qDsLv5YNLKCj1N/SqztUxGNgf9f0kbtv5MUvVvE6mXHMM7a5Ku08KNt8LwszXiAN47q8T0h5UgaCa5k4UBkp5Yhi9A7/uVKHwDUnriSVysb3IkDOeaPiBS1KP2B7kYd7RTlRJVbJTX9WMtCV1K7iagPoJnYbCuxONXhHmRDp5BPSQMxdFxTxduQNId68cTHHqZzMApKIvCufqvYXrZxuNxB64y9+71MkR0rAH+b2nghLunL8Jl6JokV0vRjMGPb/aWiK26rq4OjyhkIan4vnsuWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaB8ADd87xg/rVgqdSuaXPtfKkvZT11eM+BReaDLsGM=;
 b=x1JrcL1TGKp7hrIvu5mjvG71kO/GcD1KLsJQsGRe6oWxNbAZVfC1Y26Z2IgAXVeWiacL6y637nwQ1bdDbqk+2K/QcT5Pc4K2OzdJqIQckoTW3m32CZS1iXeo1SBU+SkHDSd7U1HU/LS7s4Si1/byLQvZBkoA0BbNpPhxQppE8b3ojMnRX/hWf8siYUEfQyWRdZs2jEqWcib1T61tIgsxcXuxnUYwVuW0DC7b/2WFNz3cRlXgUpLBimxDgiFLPaSh/4iJw5chMk6M5f63c7igP5xMekI7pPmEbvWkR6BGaFAHPKtkzHF1aiKljTMAN3uxAUnWPbNMG+qE0oWKSXExbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaB8ADd87xg/rVgqdSuaXPtfKkvZT11eM+BReaDLsGM=;
 b=bKjYhpzckexev+BX1HJHN97YxECDfjyaTNrat6wFVysmI/mv0N6A2HamHxh7XM4DHSwURSRBlY9pSOzX9iAS+fkBtXuFd6PNuYAS2NVzt4cTTAYJWlEg4xi1GCj/uVTdaA5lN6wn3nytFgDgSBFTiqRIe7LqR6iaZj8eGGmBdApzeb9O2OWsQlLZmvIsSnCOLXPsoJKmsA8rHQ+YPYQAY7F+4r1Qv15pt5KhmEczsFbUaUgjrs/7BpON51AzYgaJqi8XwKBMy3r+YWy+P2OyIg9jcFsoT7bcMfUJ2w/FAjGXM1DuBREbKoyYpYMBGNkwMqisJiC2vUNP1vxHVFspEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:35 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:35 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:24 +0800
Subject: [PATCH v8 10/19] imx9: scmi: add i.MX95 SoC and clock related code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-10-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VE1PR04MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: f9219d7f-33bc-4b73-72e5-08dd68485032
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkIrUDk0WXE0NVhUV3pGSUZyU2RvZmpwc1orbFlqUXhHSER4UHdXVWJSaW43?=
 =?utf-8?B?dHJCYjNsT0J5RmxmUFE1cEltVy9tbG9lVmZWQ2tqdk9IT2JFcFYwSzcydXp2?=
 =?utf-8?B?QmdkUjUxK0IzdVk4cDBHaGlCOXMzYXRVVENnZ2d3ZVJVWkQ2UVBsa2FDN0tS?=
 =?utf-8?B?c3pQRHJmWGdmOGFydHF1V0l1Z0F2WGlIemhmS0JCR1Q0TUVpZXdjYTZUcmkw?=
 =?utf-8?B?TlJVNTVRTHlNaVoxUmkyUXZvekFvNS9yVkJ5OFFaQnpBVlBLd1ZzSGcvd3Ra?=
 =?utf-8?B?NXlWaE1pU1Z3NnlyWVlFVTJKMDhreHpnQTNCUThkN0dVNjJDT3doZ3hvdVBW?=
 =?utf-8?B?N1pZVUovejFoa0M0cWpRd2dDbktmOFRhb0xZc3krL1QyT0Q5cjBqTXY4eklj?=
 =?utf-8?B?K20vdStBWDFzdU9mWmpDVE1oRWtmTlBDU1d3anlESUZ2ZTFUYkg5RzlVMHow?=
 =?utf-8?B?TjBIWjRPRVoxTVZxRWYwNGZhZXlaNkNReHdlMWNvRXBOTW4xUlFMZXFCOUE4?=
 =?utf-8?B?ay9RZUgzYitOZmpBaVBERDVDSVJwRHdGNDQ3THNIOWJMdjFQUjU3d1cxa1Bj?=
 =?utf-8?B?cVhybi9UOGlHa3NMN2RWR1RkTmVjWnprMzMvRDlXYUtzK3FSeURJbHhpdlE3?=
 =?utf-8?B?Uk5wdE45L0pWNURNTituRzlXTWQzNnlYdmNzKzduRjRGYnIzSXA3M0FzNmRV?=
 =?utf-8?B?ME53LzVoYThyVWQ1bU5nb2tuRmoyZzVpU2FaQjRlS1lhYWE5K2FodThiSnBy?=
 =?utf-8?B?UytpaTJZQmtJbjdpSUI5eXVJbi9WVW1kaGh1M2lScFVMMjFmUGxDdjVCY0Rp?=
 =?utf-8?B?ek1FMDZvR01WZm5DZFN5YjU5enNKaktIVHZTNllwbTVtR3paNUd6QjRobUZj?=
 =?utf-8?B?Yk9ncmt0d2dHU1lScHZ3UjFJUUhzOEZHeE1GUnJhS1BNbHhFaGs0QUZrTGRz?=
 =?utf-8?B?TTUybDdxNmRjc2htUk5Td3lMOHdTVWxpUldPVXpiWWh6b3R1dURtRXoxMXZH?=
 =?utf-8?B?NUtwbk9xbXFkUFdSSzZUWHpmVG1BZXh4ZmJoaDdPUFNjUXU1V1BPc0tvVm9x?=
 =?utf-8?B?R283UWY3M3M5dlFKT1pONEhxLzh4Q1JSUWVWaHpJNWNyUVZCV2ZLajlKVHhI?=
 =?utf-8?B?QnBBVWRVemRrN0pDV254TXVXbjNrbSswbDZTWlBRMUJObXh2OVBBNW81WG5q?=
 =?utf-8?B?dG4rdFlVV0JCdkc3UGM0Q0ZrT083R0RITU1iMDJIc2ZzcnNURzE2YVFESXI4?=
 =?utf-8?B?Mm0yM2ptQllmUlpiMnJoNEFSaGNFVUFWTkVPMUpxRGh5a1JaQWRqSmpIaG5k?=
 =?utf-8?B?TFdpelljS3MwcjNqcW5RL1g3YVN3S3ZxVWp0bmFoYnNUTGJRTkJlMjhyVWc1?=
 =?utf-8?B?TTd2eHQ0THdVRi9DM3dDQWdBYWxrRW10bGpoNlFnZmZWNEJKWVAzV29VZmU3?=
 =?utf-8?B?L24xdVFEbXExUk1RNmYvQWk3aW1sMUpCUW05MXA0RU9Pc0ZWclhlaXVkVUU2?=
 =?utf-8?B?MmJqVkZxK3BtVnVFZndOY20vVzR4U3BUNnB3bHlIb05oMTRud0Nxc2J4MEFG?=
 =?utf-8?B?QkNjeHU4bHJJVlcwRHlRQWROU1pIcXBHclJJaDVaOWhRbGFHVGlyRCtsY29h?=
 =?utf-8?B?WVdWejFJMzJ3NFgzaitCdmdyTnNrNzhzZ0pBbTEzWVZOeHh6NzE4MktldHc1?=
 =?utf-8?B?aWFuWlc5cWp0c1R4bXNFOWs4OW1TVVlFMDE4MVJRNHF6VWFLRnpReXpsUTdx?=
 =?utf-8?B?b1N1dzNSRW9KYitEWG1EQldIeFdVZ0dqTGt2bDhBYnhaVDhJSUtPWlRVZVNp?=
 =?utf-8?B?WWhtRGh0RU9DRU4rM3pwTmxaVThnc3cyZTgyQjIyeHExM0xjekErNFlQUWtI?=
 =?utf-8?B?dWk1MWlPb01mZlFiRUh1SklmOUxURTRhNkVPNk9EMWI1TlI1b1BURXMvTkFt?=
 =?utf-8?B?NlYra25BYlJlb0pISnR3UFBHYlhwZFRyNGc1L1VUdzk2dlVubFhhYVBURk5Y?=
 =?utf-8?B?TGNXaHlGekZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0RnYkswVE4ySjJ4Vis3T3RVZTZJYWhBUk1HeW55ZWxyb1ZsT2JVSW1ITG54?=
 =?utf-8?B?bTI5aWVtV0ozazJzVG5lc29vYWhyV2luS0R6cWRNQklmWktRUUR4Z3ZUdlpY?=
 =?utf-8?B?UUJVZnh3NCtDZWM3ek5nYzI0R2tBQjR3OXhLOUUyRDhsLzdYSERoRU81Zk93?=
 =?utf-8?B?Q1VkQzAyMVhuV3lIYkZNTVhPWDFrcUh0SlUrYUpQTWlSTlNzOHZtOUM1azNC?=
 =?utf-8?B?eHovVkd0YlRWM1JLb053cUZ2Q21BVXloOFFLbnlqRzg5c0hPbDhPdDlBVmYz?=
 =?utf-8?B?QStkSDFUaEFrQzlOWlgwdG1PS29uWVloSG5LQURiSkRGdFZJdndxNzE4L2JH?=
 =?utf-8?B?R3JYY0plNkFrSVFSTFdmMzk0RElGVU1WeDloSEs5NHp5TWhSb0xTMFdDMWgy?=
 =?utf-8?B?SUl3ZzZTSnYrdXZTUGtTN3JJeWhaNjFwMUl1VkNjN3ZuWGlXMjMySDFmUk9C?=
 =?utf-8?B?VDk4Uk5hVUJkTWpRYWVtcmFHcEpDaFNMNFVNSVlQZTVLaWxibUlEZFZKTjUy?=
 =?utf-8?B?SFdnTkM3VHQwSkhtUU1UY3ZXVVhuUDVjSHRWeDFub1A1Si9TanA2WHErcWRU?=
 =?utf-8?B?bTcrUG9QV2lKSDlCMU1CS2MxcnZzSVVDZXZJV1BQL25mdThYKy92S3hNOUJk?=
 =?utf-8?B?blRzdXRXRXpOS0hBaVJNc3hvSTNLWmxFVHYxRmMyc25mVWdhUVAvRU5vV2xV?=
 =?utf-8?B?L1Jnc2FUZEVrS25MOE9xTktwUXh5R3VwejVzY08rZmlWc0hXRUU4cFQvYUU2?=
 =?utf-8?B?bjhYVzFWWS9KeURibVluV0hYWVF2ajMvQzEreEZ1WExtQlRVcEhPMlBSN2lI?=
 =?utf-8?B?RUtDbXVjQy82OW9lM0tNb01OcHByVGl4ZEwxdUI5WG9pejF0cXhCOFFXNUpC?=
 =?utf-8?B?QTd5d0p6MFBWK2dhUC8rSjRTOUMzZ3ZtZE5yREl6RTg5UU05TmgrSlBRcG4w?=
 =?utf-8?B?cW5mRDNuaWNyL3hVL3hMOUZmdWs5TzRXeEtUclRzK1hMcmVsNzlwZkJSUDhJ?=
 =?utf-8?B?UGNUUEhsalhPK0pqem1hKzhSK2dZQ29Odm1DR3lSMlRmcUhtNFhhZUVnb0pE?=
 =?utf-8?B?RkptNDd1N3RmV3dLYXBVY21MajljaVk1TU5mZnQ0LzFPZW5MaXo5M3V2U2V3?=
 =?utf-8?B?N3J4bHZOS24rNTRnOEZrY1RITHBQU0FoeFhvME41a205OVE3VE1sK1RlYi9O?=
 =?utf-8?B?MjlxeFZ5QTMvM0FSZUE0UFBpQnJ6SlJjQzE1eFgxSUxtTVEvZUVwT0NEZ0Vq?=
 =?utf-8?B?NGVwc2htVkk1L1NqNmdYU0NtQWFwMCs2T0FveXdUaXZGeG4vVE5jRGhDUkw2?=
 =?utf-8?B?bHBTL3IwNTY2NjEvSnZsbnNjWnVBazJuK2lkS0JMdW1wNWpPV2RCallwWjBu?=
 =?utf-8?B?aFFEQTNwZW5oOHhhNTN2UzRuQUt0KzJJZ2ovMEpRUzNzY2ZrSU1aQ2h1NFJn?=
 =?utf-8?B?SGR0Vkt4anFWa3NWNjFpbHJsK2dDMS96a2tNdGpKbTB0S0JGRkRSbm9LSE1L?=
 =?utf-8?B?cU8zZ09SWkZJNzZnNFNZREQ3aWt6eHRvTTdkQkg0L1NwWGJHNVN5elBRZGxN?=
 =?utf-8?B?d3Uwd0Z4MW1qRFJWN1F6MXpZYjI0eHFYWDl4UnNLeXpRVGhCRkxQR2VDUWVO?=
 =?utf-8?B?VHcraXJyZ0g0ZlI3OXp0TnlSbGQwSCtzZ0VaRVp1ekphYVViZDVsTHl5MG95?=
 =?utf-8?B?a21zc0dBNkp5ZDJFN2x6dTU2Y2tSaUlLSW9XV050TUorM1E5MVZ4WjJhRnRG?=
 =?utf-8?B?VnF1QS9ldURPcXFGKzZmMVJadGIvSmVIa2k3a0l3ZGtmZUVMcXFFVm9WVE5J?=
 =?utf-8?B?VHlqMUVXVEJsb3hITkJLTndESmMydjdiSmNuRmFVRWJxc2o1eG1pMzhhMHdK?=
 =?utf-8?B?UVBYdnpWZHduL20zWWtzVW5FRVIyeGd6RExnTGJ5UUs5aW0zcW15WG9hb3di?=
 =?utf-8?B?c1piaDFQRjZYajFSTG44bUV3R1VkZXBtczEzSjRIdG1hYXo2REdxMDFSWG1j?=
 =?utf-8?B?UXlzR2c1ZWprSy95UnlVcE9BRnRIb2tWNGVWeVozMXFQQlFBdDE5QkYwQ3pY?=
 =?utf-8?B?MGxBMUc3TWZlNVExb29DVFJSbHpGUFk1MlYyek1EZ3ZMTFZkUzk1N2dHNlk2?=
 =?utf-8?Q?h4t1mA+ZUrvBnjIqQ8VGyXqrj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9219d7f-33bc-4b73-72e5-08dd68485032
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:35.0070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2TI8pF0KARIn8s0cBKfDHNiwEj/ncFte9SWF2JdiNH0ffHJNP/LenuPbRh+qndYIqS36h05QENwd8jE+5WIbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
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

This patch adds i.MX95 SoC and clock related code. Because they are
based on SCMI, put them in the scmi subfolder.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Ji Luo <ji.luo@nxp.com>
Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h        |   2 +
 arch/arm/include/asm/arch-imx9/clock.h     |  10 +
 arch/arm/include/asm/arch-imx9/imx-regs.h  |   6 +
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h  |  39 ++
 arch/arm/mach-imx/imx9/scmi/Makefile       |   6 +
 arch/arm/mach-imx/imx9/scmi/clock.c        |  70 +++
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c   | 133 +++++
 arch/arm/mach-imx/imx9/scmi/soc.c          | 775 +++++++++++++++++++++++++++++
 arch/sandbox/include/asm/scmi_test.h       |   2 +-
 10 files changed, 1043 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index 0d7a5734616..1f669c72d00 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -76,6 +76,8 @@
 #define MXC_CPU_IMX9111		0xCD /* dummy ID */
 #define MXC_CPU_IMX9101		0xCE /* dummy ID */
 
+#define MXC_CPU_IMX95		0x1C1 /* dummy ID */
+
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
 #define MXC_SOC_IMX8M		0x80
diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index 60d48b13b11..ffaf6b5f7d8 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -255,5 +255,15 @@ int ccm_shared_gpr_tz_access(u32 gpr, bool non_secure, bool user_mode, bool lock
 void enable_usboh3_clk(unsigned char enable);
 int set_clk_enet(enum enet_freq type);
 int set_clk_eqos(enum enet_freq type);
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable);
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate);
+ulong imx_clk_scmi_get_rate(u32 clock_id);
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id);
 void set_arm_clk(ulong freq);
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable);
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate);
+ulong imx_clk_scmi_get_rate(u32 clock_id);
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id);
 #endif
diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index ef9538bd42e..5127fe8f286 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -13,6 +13,7 @@
 #define CCM_BASE_ADDR		0x44450000UL
 #define CCM_CCGR_BASE_ADDR	0x44458000UL
 #define SYSCNT_CTRL_BASE_ADDR	0x44290000
+#define SYSCNT_CMP_BASE_ADDR	(SYSCNT_CTRL_BASE_ADDR + 0x10000)
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
@@ -20,6 +21,11 @@
 #define WDG4_BASE_ADDR      0x424a0000UL
 #define WDG5_BASE_ADDR      0x424b0000UL
 
+#define GPIO2_BASE_ADDR	    0x43810000UL
+#define GPIO3_BASE_ADDR	    0x43820000UL
+#define GPIO4_BASE_ADDR	    0x43840000UL
+#define GPIO5_BASE_ADDR	    0x43850000UL
+
 #define FSB_BASE_ADDR       0x47510000UL
 
 #define ANATOP_BASE_ADDR    0x44480000UL
diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index e4bf6a63424..df2148a53c7 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -12,6 +12,7 @@ enum imx9_soc_voltage_mode {
 	VOLT_LOW_DRIVE = 0,
 	VOLT_NOMINAL_DRIVE,
 	VOLT_OVER_DRIVE,
+	VOLT_SUPER_OVER_DRIVE,
 };
 
 void soc_power_init(void);
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 109a806852a..0780f99b49a 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -97,6 +97,8 @@ struct bd_info;
 #define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
 #define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
+#define is_imx95() (is_cpu_type(MXC_CPU_IMX95))
+
 #define is_imx9121() (is_cpu_type(MXC_CPU_IMX9121))
 #define is_imx9111() (is_cpu_type(MXC_CPU_IMX9111))
 #define is_imx9101() (is_cpu_type(MXC_CPU_IMX9101))
@@ -216,6 +218,43 @@ ulong spl_romapi_get_uboot_base(u32 image_offset, u32 rom_bt_dev);
 u32 rom_api_download_image(u8 *dest, u32 offset, u32 size);
 u32 rom_api_query_boot_infor(u32 info_type, u32 *info);
 
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+typedef struct rom_passover {
+	u16 tag;                   // Tag
+	u8  len;                   // Fixed value of 0x80
+	u8  ver;                   // Version
+	u32 boot_mode;             // Boot mode
+	u32 card_addr_mode;        // SD card address mode
+	u32 bad_blks_of_img_set0;  // NAND bad block count skipped 1
+	u32 ap_mu_id;              // AP MU ID
+	u32 bad_blks_of_img_set1;  // NAND bad block count skipped 1
+	u8  boot_stage;            // Boot stage
+	u8  img_set_sel;           // Image set booted from
+	u8  rsv0[2];               // Reserved
+	u32 img_set_end;           // Offset of Image End
+	u32 rom_version;           // ROM version
+	u8  boot_dev_state;        // Boot device state
+	u8  boot_dev_inst;         // Boot device type
+	u8  boot_dev_type;         // Boot device instance
+	u8  rsv1;                  // Reserved
+	u32 dev_page_size;         // Boot device page size
+	u32 cnt_header_ofs;        // Container header offset
+	u32 img_ofs;               // Image offset
+}  __packed rom_passover_t;
+
+/**
+ * struct scmi_rom_passover_out - Response payload for ROM_PASSOVER_GET command
+ * @status:	SCMI clock ID
+ * @attributes:	Attributes of the targets clock state
+ */
+struct scmi_rom_passover_get_out {
+	u32 status;
+	u32 numPassover;
+	u32 passover[(sizeof(rom_passover_t) + 8) / 4];
+};
+
+#endif
+
 /* For i.MX ULP */
 #define BT0CFG_LPBOOT_MASK	0x1
 #define BT0CFG_DUALBOOT_MASK	0x2
diff --git a/arch/arm/mach-imx/imx9/scmi/Makefile b/arch/arm/mach-imx/imx9/scmi/Makefile
new file mode 100644
index 00000000000..4534db08d28
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+obj-y += soc.o
+obj-y += clock_scmi.o clock.o
diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c b/arch/arm/mach-imx/imx9/scmi/clock.c
new file mode 100644
index 00000000000..6e6541eaa31
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/clock.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <dm/uclass.h>
+#include <scmi_agent.h>
+#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+
+u32 get_arm_core_clk(void)
+{
+	u32 val;
+
+	val = imx_clk_scmi_get_rate(IMX95_CLK_SEL_A55C0);
+	if (val)
+		return val;
+	return imx_clk_scmi_get_rate(IMX95_CLK_A55);
+}
+
+void init_uart_clk(u32 index)
+{
+	u32 clock_id;
+
+	switch (index) {
+	case 0:
+		clock_id = IMX95_CLK_LPUART1;
+		break;
+	case 1:
+		clock_id = IMX95_CLK_LPUART2;
+		break;
+	case 2:
+		clock_id = IMX95_CLK_LPUART3;
+		break;
+	default:
+		return;
+	}
+
+	/* 24MHz */
+	imx_clk_scmi_enable(clock_id, false);
+	imx_clk_scmi_set_parent(clock_id, IMX95_CLK_24M);
+	imx_clk_scmi_set_rate(clock_id, 24000000);
+	imx_clk_scmi_enable(clock_id, true);
+}
+
+unsigned int mxc_get_clock(enum mxc_clock clk)
+{
+	switch (clk) {
+	case MXC_ARM_CLK:
+		return get_arm_core_clk();
+	case MXC_IPG_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_BUSWAKEUP);
+	case MXC_CSPI_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPSPI1);
+	case MXC_ESDHC_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC1);
+	case MXC_ESDHC2_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC2);
+	case MXC_ESDHC3_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_USDHC3);
+	case MXC_UART_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_LPUART1);
+	case MXC_FLEXSPI_CLK:
+		return imx_clk_scmi_get_rate(IMX95_CLK_FLEXSPI1);
+	default:
+		return -1;
+	};
+
+	return -1;
+};
diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
new file mode 100644
index 00000000000..fa15b5f8df9
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <dm/uclass.h>
+#include <scmi_agent.h>
+
+int imx_clk_scmi_enable(u32 clock_id, bool enable)
+{
+	struct scmi_clk_state_in in = {
+		.clock_id = clock_id,
+		.attributes = (enable) ? 1 : 0,
+	};
+	struct scmi_clk_state_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_CONFIG_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
+ulong imx_clk_scmi_set_rate(u32 clock_id, ulong rate)
+{
+	struct scmi_clk_rate_set_in in = {
+		.clock_id = clock_id,
+		.flags = SCMI_CLK_RATE_ROUND_CLOSEST,
+		.rate_lsb = (u32)rate,
+		.rate_msb = (u32)((u64)rate >> 32),
+	};
+	struct scmi_clk_rate_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_RATE_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0)
+		return ret;
+
+	struct scmi_clk_rate_get_in in_rate = {
+		.clock_id = clock_id,
+	};
+	struct scmi_clk_rate_get_out out_rate;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK, SCMI_CLOCK_RATE_GET, in_rate, out_rate);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out_rate.status);
+	if (ret < 0)
+		return ret;
+
+	return (ulong)(((u64)out_rate.rate_msb << 32) | out_rate.rate_lsb);
+}
+
+ulong imx_clk_scmi_get_rate(u32 clock_id)
+{
+	struct scmi_clk_rate_get_in in = {
+		.clock_id = clock_id,
+	};
+	struct scmi_clk_rate_get_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_RATE_GET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0)
+		return ret;
+
+	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
+}
+
+int imx_clk_scmi_set_parent(u32 clock_id, u32 parent_id)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clock_id,
+		.parent_clk = parent_id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0 && ret != -EACCES)
+		printf("%s: %d, clock_id %u\n", __func__, ret, clock_id);
+
+	return ret;
+}
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
new file mode 100644
index 00000000000..388147118ca
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -0,0 +1,775 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ *
+ * Peng Fan <peng.fan@nxp.com>
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/armv8/mmu.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/setup.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <env_internal.h>
+#include <fuse.h>
+#include <imx_thermal.h>
+#include <linux/iopoll.h>
+#include <scmi_agent.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static rom_passover_t rom_passover_data = {0};
+
+uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
+{
+	/* Read ROM passover data */
+	struct scmi_rom_passover_get_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
+		.message_id = SCMI_MISC_ROM_PASSOVER_GET,
+		.in_msg = (u8 *)NULL,
+		.in_msg_sz = 0,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret == 0 && out.status == 0) {
+		memcpy(rom_data, (struct rom_passover_t *)out.passover, sizeof(rom_passover_t));
+	} else {
+		printf("Failed to get ROM passover data, scmi_err = %d, size_of(out) = %ld\n",
+		       out.status, sizeof(out));
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
+__weak int board_mmc_get_env_dev(int devno)
+{
+	return devno;
+}
+
+int mmc_get_env_dev(void)
+{
+	int ret;
+	u16 boot_type;
+	u8 boot_instance;
+
+	volatile gd_t *pgd = gd;
+	rom_passover_t *rdata;
+
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+	rdata = &rom_passover_data;
+#else
+	rom_passover_t rom_data = {0};
+
+	if (!pgd->reloc_off)
+		rdata = &rom_data;
+	else
+		rdata = &rom_passover_data;
+#endif
+	if (rdata->tag == 0) {
+		ret = scmi_get_rom_data(rdata);
+		if (ret != 0) {
+			puts("SCMI: failure at rom_boot_info\n");
+			return CONFIG_SYS_MMC_ENV_DEV;
+		}
+	}
+	boot_type = rdata->boot_dev_type;
+	boot_instance = rdata->boot_dev_inst;
+	set_gd(pgd);
+
+	debug("boot_type %d, instance %d\n", boot_type, boot_instance);
+
+	/* If not boot from sd/mmc, use default value */
+	if (boot_type != BOOT_TYPE_SD && boot_type != BOOT_TYPE_MMC)
+		return env_get_ulong("mmcdev", 10, CONFIG_SYS_MMC_ENV_DEV);
+
+	return board_mmc_get_env_dev(boot_instance);
+}
+#endif
+
+u32 get_cpu_speed_grade_hz(void)
+{
+	u32 speed, max_speed;
+	int ret;
+	u32 val, word, offset;
+
+	word = 17;
+	offset = 14;
+
+	ret = fuse_read(word / 8, word % 8, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	val >>= offset;
+	val &= 0xf;
+
+	max_speed = 2300000000;
+	speed = max_speed - val * 100000000;
+
+	if (is_imx95())
+		max_speed = 2000000000;
+
+	/* In case the fuse of speed grade not programmed */
+	if (speed > max_speed)
+		speed = max_speed;
+
+	return speed;
+}
+
+u32 get_cpu_temp_grade(int *minc, int *maxc)
+{
+	int ret;
+	u32 val, word, offset;
+
+	word = 17;
+	offset = 12;
+
+	ret = fuse_read(word / 8, word % 8, &val);
+	if (ret)
+		val = 0; /* If read fuse failed, return as blank fuse */
+
+	val >>= offset;
+	val &= 0x3;
+
+	if (minc && maxc) {
+		if (val == TEMP_AUTOMOTIVE) {
+			*minc = -40;
+			*maxc = 125;
+		} else if (val == TEMP_INDUSTRIAL) {
+			*minc = -40;
+			*maxc = 105;
+		} else if (val == TEMP_EXTCOMMERCIAL) {
+			*minc = -20;
+			*maxc = 105;
+		} else {
+			*minc = 0;
+			*maxc = 95;
+		}
+	}
+	return val;
+}
+
+static void set_cpu_info(struct ele_get_info_data *info)
+{
+	gd->arch.soc_rev = info->soc;
+	gd->arch.lifecycle = info->lc;
+	memcpy((void *)&gd->arch.uid, &info->uid, 4 * sizeof(u32));
+}
+
+u32 get_cpu_rev(void)
+{
+	u32 rev = (gd->arch.soc_rev >> 24) - 0xa0;
+
+	return (MXC_CPU_IMX95 << 12) | (CHIP_REV_1_0 + rev);
+}
+
+#define UNLOCK_WORD 0xD928C520
+#define REFRESH_WORD 0xB480A602
+
+static void disable_wdog(void __iomem *wdog_base)
+{
+	u32 val_cs = readl(wdog_base + 0x00);
+	int ret = 0;
+
+	if (!(val_cs & 0x80))
+		return;
+
+	/* default is 32bits cmd */
+	writel(REFRESH_WORD, (wdog_base + 0x04)); /* Refresh the CNT */
+
+	if (!(val_cs & 0x800)) {
+		writel(UNLOCK_WORD, (wdog_base + 0x04));
+		while (!(readl(wdog_base + 0x00) & 0x800))
+			;
+	}
+	writel(0x0, (wdog_base + 0x0C)); /* Set WIN to 0 */
+	writel(0x400, (wdog_base + 0x08)); /* Set timeout to default 0x400 */
+	writel(0x2120, (wdog_base + 0x00)); /* Disable it and set update */
+
+	ret = readl_poll_timeout(wdog_base, val_cs, val_cs & 0x400, 100000);
+	if (ret < 0)
+		debug("%s timeout\n", __func__);
+}
+
+static struct mm_region imx9_mem_map[] = {
+	{
+		/* M7 TCM */
+		.virt = 0x203c0000UL,
+		.phys = 0x203c0000UL,
+		.size = 0x80000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* OCRAM */
+		.virt = 0x20480000UL,
+		.phys = 0x20480000UL,
+		.size = 0xA0000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+		/* AIPS */
+		.virt = 0x40000000UL,
+		.phys = 0x40000000UL,
+		.size = 0x40000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* Flexible Serial Peripheral Interface */
+		.virt = 0x28000000UL,
+		.phys = 0x28000000UL,
+		.size = 0x8000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* DRAM1 */
+		.virt = PHYS_SDRAM,
+		.phys = PHYS_SDRAM,
+		.size = PHYS_SDRAM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				 PTE_BLOCK_OUTER_SHARE
+	}, {
+#ifdef PHYS_SDRAM_2_SIZE
+		/* DRAM2 */
+		.virt = 0x100000000UL,
+		.phys = 0x100000000UL,
+		.size = PHYS_SDRAM_2_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE
+	}, {
+#endif
+		/* empty entry to split table entry 5 if needed when TEEs are used */
+		0,
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = imx9_mem_map;
+
+static unsigned int imx9_find_dram_entry_in_mem_map(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imx9_mem_map); i++)
+		if (imx9_mem_map[i].phys == CFG_SYS_SDRAM_BASE)
+			return i;
+
+	hang();	/* Entry not found, this must never happen. */
+}
+
+void enable_caches(void)
+{
+	/* If OPTEE runs, remove OPTEE memory from MMU table to avoid speculative prefetch
+	 * If OPTEE does not run, still update the MMU table according to dram banks structure
+	 * to set correct dram size from board_phys_sdram_size
+	 */
+	int i = 0;
+	/*
+	 * please make sure that entry initial value matches
+	 * imx9_mem_map for DRAM1
+	 */
+	int entry = imx9_find_dram_entry_in_mem_map();
+	u64 attrs = imx9_mem_map[entry].attrs;
+
+	while (i < CONFIG_NR_DRAM_BANKS &&
+	       entry < ARRAY_SIZE(imx9_mem_map)) {
+		if (gd->bd->bi_dram[i].start == 0)
+			break;
+		imx9_mem_map[entry].phys = gd->bd->bi_dram[i].start;
+		imx9_mem_map[entry].virt = gd->bd->bi_dram[i].start;
+		imx9_mem_map[entry].size = gd->bd->bi_dram[i].size;
+		imx9_mem_map[entry].attrs = attrs;
+		debug("Added memory mapping (%d): %llx %llx\n", entry,
+		      imx9_mem_map[entry].phys, imx9_mem_map[entry].size);
+		i++; entry++;
+	}
+
+	icache_enable();
+	dcache_enable();
+}
+
+__weak int board_phys_sdram_size(phys_size_t *size)
+{
+	phys_size_t start, end;
+	phys_size_t val;
+
+	if (!size)
+		return -EINVAL;
+
+	val = readl(REG_DDR_CS0_BNDS);
+	start = (val >> 16) << 24;
+	end   = (val & 0xFFFF);
+	end   = end ? end + 1 : 0;
+	end   = end << 24;
+	*size = end - start;
+
+	val = readl(REG_DDR_CS1_BNDS);
+	start = (val >> 16) << 24;
+	end   = (val & 0xFFFF);
+	end   = end ? end + 1 : 0;
+	end   = end << 24;
+	*size += end - start;
+
+	return 0;
+}
+
+int dram_init(void)
+{
+	phys_size_t sdram_size;
+	int ret;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (ret)
+		return ret;
+
+	/* rom_pointer[1] contains the size of TEE occupies */
+	if (rom_pointer[1] && PHYS_SDRAM < (phys_addr_t)rom_pointer[0])
+		gd->ram_size = sdram_size - rom_pointer[1];
+	else
+		gd->ram_size = sdram_size;
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	int bank = 0;
+	int ret;
+	phys_size_t sdram_size;
+	phys_size_t sdram_b1_size, sdram_b2_size;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (ret)
+		return ret;
+
+	/* Bank 1 can't cross over 4GB space */
+	if (sdram_size > 0x80000000) {
+		sdram_b1_size = 0x100000000UL - PHYS_SDRAM;
+		sdram_b2_size = sdram_size - sdram_b1_size;
+	} else {
+		sdram_b1_size = sdram_size;
+		sdram_b2_size = 0;
+	}
+
+	gd->bd->bi_dram[bank].start = PHYS_SDRAM;
+	if (rom_pointer[1] && PHYS_SDRAM < (phys_addr_t)rom_pointer[0]) {
+		phys_addr_t optee_start = (phys_addr_t)rom_pointer[0];
+		phys_size_t optee_size = (size_t)rom_pointer[1];
+
+		gd->bd->bi_dram[bank].size = optee_start - gd->bd->bi_dram[bank].start;
+		if ((optee_start + optee_size) < (PHYS_SDRAM + sdram_b1_size)) {
+			if (++bank >= CONFIG_NR_DRAM_BANKS) {
+				puts("CONFIG_NR_DRAM_BANKS is not enough\n");
+				return -1;
+			}
+
+			gd->bd->bi_dram[bank].start = optee_start + optee_size;
+			gd->bd->bi_dram[bank].size = PHYS_SDRAM +
+				sdram_b1_size - gd->bd->bi_dram[bank].start;
+		}
+	} else {
+		gd->bd->bi_dram[bank].size = sdram_b1_size;
+	}
+
+	if (sdram_b2_size) {
+		if (++bank >= CONFIG_NR_DRAM_BANKS) {
+			puts("CONFIG_NR_DRAM_BANKS is not enough for SDRAM_2\n");
+			return -1;
+		}
+		gd->bd->bi_dram[bank].start = 0x100000000UL;
+		gd->bd->bi_dram[bank].size = sdram_b2_size;
+	}
+
+	return 0;
+}
+
+phys_size_t get_effective_memsize(void)
+{
+	int ret;
+	phys_size_t sdram_size;
+	phys_size_t sdram_b1_size;
+
+	ret = board_phys_sdram_size(&sdram_size);
+	if (!ret) {
+		/* Bank 1 can't cross over 4GB space */
+		if (sdram_size > 0x80000000)
+			sdram_b1_size = 0x100000000UL - PHYS_SDRAM;
+		else
+			sdram_b1_size = sdram_size;
+
+		if (rom_pointer[1]) {
+			/* We will relocate u-boot to Top of dram1. Tee position has three cases:
+			 * 1. At the top of dram1,  Then return the size removed optee size.
+			 * 2. In the middle of dram1, return the size of dram1.
+			 * 3. Not in the scope of dram1, return the size of dram1.
+			 */
+			if ((rom_pointer[0] + rom_pointer[1]) == (PHYS_SDRAM + sdram_b1_size))
+				return ((phys_addr_t)rom_pointer[0] - PHYS_SDRAM);
+		}
+
+		return sdram_b1_size;
+	} else {
+		return PHYS_SDRAM_SIZE;
+	}
+}
+
+void imx_get_mac_from_fuse(int dev_id, unsigned char *mac)
+{
+	u32 val[2] = {};
+	int ret, num_of_macs;
+
+	ret = fuse_read(40, 5, &val[0]);
+	if (ret)
+		goto err;
+
+	ret = fuse_read(40, 6, &val[1]);
+	if (ret)
+		goto err;
+
+	num_of_macs = (val[1] >> 24) & 0xff;
+	if (num_of_macs <= (dev_id * 3)) {
+		printf("WARNING: no MAC address assigned for MAC%d\n", dev_id);
+		goto err;
+	}
+
+	mac[0] = val[0] & 0xff;
+	mac[1] = (val[0] >> 8) & 0xff;
+	mac[2] = (val[0] >> 16) & 0xff;
+	mac[3] = (val[0] >> 24) & 0xff;
+	mac[4] = val[1] & 0xff;
+	mac[5] = (val[1] >> 8) & 0xff;
+	if (dev_id == 1)
+		mac[5] = mac[5] + 3;
+	if (dev_id == 2)
+		mac[5] = mac[5] + 6;
+
+	debug("%s: MAC%d: %pM\n", __func__, dev_id, mac);
+	return;
+err:
+	memset(mac, 0, 6);
+	printf("%s: fuse read err: %d\n", __func__, ret);
+}
+
+const char *get_imx_type(u32 imxtype)
+{
+	switch (imxtype) {
+	case MXC_CPU_IMX95:
+		return "95";/* iMX95 FULL */
+	default:
+		return "??";
+	}
+}
+
+int print_cpuinfo(void)
+{
+	u32 cpurev, max_freq;
+	int minc, maxc;
+
+	cpurev = get_cpu_rev();
+
+	printf("CPU:   i.MX%s rev%u.%u",
+	       get_imx_type((cpurev & 0x1FF000) >> 12),
+	       (cpurev & 0x000F0) >> 4, (cpurev & 0x0000F) >> 0);
+
+	max_freq = get_cpu_speed_grade_hz();
+	if (!max_freq || max_freq == mxc_get_clock(MXC_ARM_CLK)) {
+		printf(" at %uMHz\n", mxc_get_clock(MXC_ARM_CLK) / 1000000);
+	} else {
+		printf(" %u MHz (running at %u MHz)\n", max_freq / 1000000,
+		       mxc_get_clock(MXC_ARM_CLK) / 1000000);
+	}
+
+	puts("CPU:   ");
+	switch (get_cpu_temp_grade(&minc, &maxc)) {
+	case TEMP_AUTOMOTIVE:
+		puts("Automotive temperature grade ");
+		break;
+	case TEMP_INDUSTRIAL:
+		puts("Industrial temperature grade ");
+		break;
+	case TEMP_EXTCOMMERCIAL:
+		if (is_imx93())
+			puts("Extended Industrial temperature grade ");
+		else
+			puts("Extended Consumer temperature grade ");
+		break;
+	default:
+		puts("Consumer temperature grade ");
+		break;
+	}
+	printf("(%dC to %dC)", minc, maxc);
+
+	puts("\n");
+
+	return 0;
+}
+
+void build_info(void)
+{
+	u32 fw_version, sha1, res = 0, status;
+	int ret;
+
+	printf("\nBuildInfo:\n");
+
+	ret = ele_get_fw_status(&status, &res);
+	if (ret) {
+		printf("  - ELE firmware status failed %d, 0x%x\n", ret, res);
+	} else if ((status & 0xff) == 1) {
+		ret = ele_get_fw_version(&fw_version, &sha1, &res);
+		if (ret) {
+			printf("  - ELE firmware version failed %d, 0x%x\n", ret, res);
+		} else {
+			printf("  - ELE firmware version %u.%u.%u-%x",
+			       (fw_version & (0x00ff0000)) >> 16,
+			       (fw_version & (0x0000fff0)) >> 4,
+			       (fw_version & (0x0000000f)), sha1);
+			((fw_version & (0x80000000)) >> 31) == 1 ? puts("-dirty\n") : puts("\n");
+		}
+	} else {
+		printf("  - ELE firmware not included\n");
+	}
+	puts("\n");
+}
+
+int arch_misc_init(void)
+{
+	build_info();
+	return 0;
+}
+
+#if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_SPL_BUILD)
+int board_fix_fdt(void *fdt)
+{
+	return 0;
+}
+#endif
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)
+void get_board_serial(struct tag_serialnr *serialnr)
+{
+	printf("UID: %08x%08x%08x%08x\n", __be32_to_cpu(gd->arch.uid[0]),
+	       __be32_to_cpu(gd->arch.uid[1]), __be32_to_cpu(gd->arch.uid[2]),
+	       __be32_to_cpu(gd->arch.uid[3]));
+
+	serialnr->low = __be32_to_cpu(gd->arch.uid[1]);
+	serialnr->high = __be32_to_cpu(gd->arch.uid[0]);
+}
+#endif
+
+static void gpio_reset(ulong gpio_base)
+{
+	writel(0, gpio_base + 0x10);
+	writel(0, gpio_base + 0x14);
+	writel(0, gpio_base + 0x18);
+	writel(0, gpio_base + 0x1c);
+}
+
+int arch_cpu_init(void)
+{
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		disable_wdog((void __iomem *)WDG3_BASE_ADDR);
+		disable_wdog((void __iomem *)WDG4_BASE_ADDR);
+
+		gpio_reset(GPIO2_BASE_ADDR);
+		gpio_reset(GPIO3_BASE_ADDR);
+		gpio_reset(GPIO4_BASE_ADDR);
+		gpio_reset(GPIO5_BASE_ADDR);
+	}
+
+	return 0;
+}
+
+int imx9_probe_mu(void)
+{
+	struct udevice *dev;
+	int ret;
+	u32 res;
+	struct ele_get_info_data info;
+
+	ret = uclass_get_device_by_driver(UCLASS_SCMI_AGENT, DM_DRIVER_GET(scmi_mbox), &dev);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret)
+		return ret;
+
+	ret = uclass_get_device_by_name(UCLASS_PINCTRL, "protocol@19", &dev);
+	if (ret)
+		return ret;
+
+#if defined(CONFIG_SPL_BUILD)
+	ret = uclass_get_device_by_name(UCLASS_MISC, "mailbox@47530000", &dev);
+#else
+	ret = uclass_get_device_by_name(UCLASS_MISC, "mailbox@47550000", &dev);
+#endif
+	if (ret)
+		return ret;
+
+	if (gd->flags & GD_FLG_RELOC)
+		return 0;
+
+	ret = ele_get_info(&info, &res);
+	if (ret)
+		return ret;
+
+	set_cpu_info(&info);
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, imx9_probe_mu);
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, imx9_probe_mu);
+
+int timer_init(void)
+{
+	gd->arch.tbl = 0;
+	gd->arch.tbu = 0;
+
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		unsigned long freq = 24000000;
+
+		asm volatile("msr cntfrq_el0, %0" : : "r" (freq) : "memory");
+
+		/* Clear the compare frame interrupt */
+		unsigned long sctr_cmpcr_addr = SYSCNT_CMP_BASE_ADDR + 0x2c;
+		unsigned long sctr_cmpcr = readl(sctr_cmpcr_addr);
+
+		sctr_cmpcr &= ~0x1;
+		writel(sctr_cmpcr, sctr_cmpcr_addr);
+	}
+
+	return 0;
+}
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	enum boot_device dev = get_boot_device();
+	enum env_location env_loc = ENVL_UNKNOWN;
+
+	if (prio)
+		return env_loc;
+
+	switch (dev) {
+	case QSPI_BOOT:
+		env_loc = ENVL_SPI_FLASH;
+		break;
+	case SD1_BOOT:
+	case SD2_BOOT:
+	case SD3_BOOT:
+	case MMC1_BOOT:
+	case MMC2_BOOT:
+	case MMC3_BOOT:
+		env_loc =  ENVL_MMC;
+		break;
+	default:
+		env_loc = ENVL_NOWHERE;
+		break;
+	}
+
+	return env_loc;
+}
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void)
+{
+	u32 speed = get_cpu_speed_grade_hz();
+	enum imx9_soc_voltage_mode voltage = VOLT_OVER_DRIVE;
+
+	if (is_imx95()) {
+		if (speed == 2000000000)
+			voltage = VOLT_SUPER_OVER_DRIVE;
+		else if (speed == 1800000000)
+			voltage = VOLT_OVER_DRIVE;
+		else if (speed == 1400000000)
+			voltage = VOLT_NOMINAL_DRIVE;
+		else /* boot not support low drive mode according to AS */
+			printf("Unexpected A55 freq %u, default to OD\n", speed);
+	}
+
+	return voltage;
+}
+
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
+enum boot_device get_boot_device(void)
+{
+	volatile gd_t *pgd = gd;
+	int ret;
+	u16 boot_type;
+	u8 boot_instance;
+	enum boot_device boot_dev = 0;
+	rom_passover_t *rdata;
+
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+	rdata = &rom_passover_data;
+#else
+	rom_passover_t rom_data = {0};
+
+	if (pgd->reloc_off == 0)
+		rdata = &rom_data;
+	else
+		rdata = &rom_passover_data;
+#endif
+	if (rdata->tag == 0) {
+		ret = scmi_get_rom_data(rdata);
+		if (ret != 0) {
+			puts("SCMI: failure at rom_boot_info\n");
+			return -1;
+		}
+	}
+	boot_type = rdata->boot_dev_type;
+	boot_instance = rdata->boot_dev_inst;
+
+	set_gd(pgd);
+
+	switch (boot_type) {
+	case BT_DEV_TYPE_SD:
+		boot_dev = boot_instance + SD1_BOOT;
+		break;
+	case BT_DEV_TYPE_MMC:
+		boot_dev = boot_instance + MMC1_BOOT;
+		break;
+	case BT_DEV_TYPE_NAND:
+		boot_dev = NAND_BOOT;
+		break;
+	case BT_DEV_TYPE_FLEXSPINOR:
+		boot_dev = QSPI_BOOT;
+		break;
+	case BT_DEV_TYPE_USB:
+		boot_dev = boot_instance + USB_BOOT;
+		if (IS_ENABLED(CONFIG_IMX95))
+			boot_dev -= 3; //iMX95 usb instance start at 3
+		break;
+	default:
+		break;
+	}
+
+	return boot_dev;
+}
+#endif
diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index b30e536a357..c9717118bcb 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -110,7 +110,7 @@ struct sandbox_scmi_devices {
 	size_t regul_count;
 };
 
-#ifdef CONFIG_SCMI_FIRMWARE
+#if IS_ENABLED(CONFIG_SCMI_FIRMWARE)
 /**
  * sandbox_scmi_channel_id - Get the channel id
  * @dev:	Reference to the SCMI protocol device

-- 
2.43.0

