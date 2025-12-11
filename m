Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77BBD41C09
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:05:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5963983C08;
	Thu, 11 Dec 2025 11:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c9m//F9/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF8FF83BFE; Thu, 11 Dec 2025 08:18:35 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A98C807C0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh7jBLW9fq9CoTwWgJOfUPiyZ05E5Ahn8kYVJhpqQGCdfDFWtcbxjTX+/JrRGykmWUMD7aHv3/cKyP+UXSy9kHPZz5WHK36a0FYzS74k/g8EXClidt5Sf0IomoRos/hZvg3ktkrBW0AtNFPGHYUmmUNsMtCrEpQHs0B9uOU47j04WDltJdS6uFYcVR7sbUFU5OBQab9ZPR36UoySTPPgaJCpIgzV9S0igBRfq7YCdElpxvcQGTPkpl4u4qaw9X2Bi04augCU+X998KxPCDw9xJaijKiL0leN5Hu45vitvpwsk55qFV5nRaEvYHyPUYQmZp3C26cbMYdElus5NlLs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLGGB0JNXLV0R0uwFKPBbQBVe587HVnxk5jwrgiM2Kc=;
 b=Vjw9XNkwBDNmYU3r4qPJYTgcrvuIG5OREFOD+zhZo89tCD2LI6hLlAW/Q4c1NY1o6JcMHieYNhXBLbvg/AotPYh/xmbK5n3d0k5LoaMG0I1lJryUABLxG6KVMEGBWCaBlJ/tu/nzUtmRMLuy6Ei2hnbmP0oI0taHzMK797ANuQykcnM50z79MwScAyRcNCc1y99sEv+Dto9aju+vlXbPuhEMekPhsMnBDZJNxmDTAl5Xs4DsiBvvlzxpglUnEnxbImZXDakRSwtXDgMRuTJtFEVApJBouCkX5u05SuBaPPjafeFk73c3aMQLkkztOo8EjgrVa2wACAIt5Sg7A8fmfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLGGB0JNXLV0R0uwFKPBbQBVe587HVnxk5jwrgiM2Kc=;
 b=c9m//F9/s61glrFek3lb0db8/labiNuE77+vamlwwZyefP1LVgVL9oPdl9LjviGcRg6f4W6Ul5NJQ2Y8EFF9W5L21JZ+PX3l3HnOtkt6qIzyS/TR0/78gUmMt+RHm2Rq47WGuKxOMeBAH72BVpT2cX6oNuJXjSwO0cBHCe5QGUolncHf6x93JIziXKxn8MOD1deb6ouP15GR/OhmSZWp1fmNfd3cRHnPGvDYWJG91JaA1yaos9P7Zd5QPb41pV6WCzDdmsSOaW0SYhzjROSTpNfMVkEEWTexgVSQBBbSzELAILhiuGjWh6BeYQvV7JRyQoBN9TLDw80x/5X7orBPmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU6PR04MB11184.eurprd04.prod.outlook.com (2603:10a6:10:5c1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 07:18:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 07:18:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] clk: scmi: Fix name defer
Date: Thu, 11 Dec 2025 16:31:42 +0800
Message-Id: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG6BOmkC/x2MQQqAIBAAvyJ7bkGNCPtKdBBdayktFCII/550n
 IGZFwplpgKTeCHTzYXP1EB1Atxm00rIvjFoqQellUJ37FhcZOT4YOAHZQgkjbG29yO07MrU9L+
 cl1o/hdbXl2IAAAA=
X-Change-ID: 20251211-clk-scmi-imx-fix-0ffe099aa3d7
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU6PR04MB11184:EE_
X-MS-Office365-Filtering-Correlation-Id: f29939d7-7c34-469c-5de4-08de38857910
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDRUdm9LaDZOYVg2c3pDOFp6dm1QRXJUOXdjaC9nQ0EybkdJSitwZnVWd01S?=
 =?utf-8?B?aFZ5V29tWDNYNWZmRjJxMXdFdnp6bjY5TTRkblEvdWhGRGVYNFE5NGtvMjJM?=
 =?utf-8?B?YTJpcHl2T2hzVm93Ty95eUJMQ3MzNENjOTh5UWczQnVYVmt4Sm11bDJXaEJl?=
 =?utf-8?B?R2JJY3hPNHZRM0VHQ0hrZTIwdTcycVNpQ1RPOU1Pa0Y1M1pOSUllckhVWFRY?=
 =?utf-8?B?ejNORmt0Wmx5VVR3S3ZqYjVKWjUwaGVCRDJuZDQ2ZXlpT0E1MzMyNWh5Z3FG?=
 =?utf-8?B?bysxZ3A0Z2V6N25wNmZBREdtQUlXUFRZYmN2bkJrWFY1YWhNZnRXT1FiUG5x?=
 =?utf-8?B?TnB0RUpVcnh6SG53eHJlUE9DRWVESkNubzR0amJqVVlRMHJUV1NLT3o2OGJv?=
 =?utf-8?B?WERSdW9ubkJPNVVkalp3RlplRmdnWVJJcVVyT0hla1NaUEtaZGZ3dzNtdnZs?=
 =?utf-8?B?RllFMHhYTzREWEZHa2J6bWFDU25FMFdFdGtEQmJhMWhaUlRDdk5TWjBIZThq?=
 =?utf-8?B?YnlHT3hxS0kxWklhMXZBc3c4TWRsVlBrQVJQdnJtNVlaazVLVGZoR0RjY3dl?=
 =?utf-8?B?QVkxQzkyUGJGMWVmYlp3RmdIa0R1bTQvSlAwMXFIWjdVNjRIeTFLd1JLZHVB?=
 =?utf-8?B?L0hrVERad1J0V3IvUnh5SEZUSzNIelFhcGtnbGFWb0xqdVg5U1VaWnNGNzYr?=
 =?utf-8?B?UTRpaWJvalAyQVFSUFptRW41ZnpDUUs4SlJpNWpHc0cvT3hTS3hrYmgzVUNq?=
 =?utf-8?B?STNTMDR3S2dLV3BmekU5UXNRNXNQNlNYNCtUVFJvdTR3Y2YyRzBZUW5keUdh?=
 =?utf-8?B?MTI1bFk4NVVnN0V1K2FDbnVKREczMDlBV2hJYld3TEx6bEtIT3hscXlOb2gr?=
 =?utf-8?B?aGJkaTFGVHpQYmUxTVJaZTNDUlFwN3pjQklOWHo3NU56NUJHRHpBQTA4MDJu?=
 =?utf-8?B?Z3c5anZ3V2ZNenRFb20xV3FkcWswNWtkdmUySUg3dTFpR1hha2tnUFhwZ1I1?=
 =?utf-8?B?MDRxcGl6R3JNOTh1TmtJdlFGQzBrb2FINzlJc1pHcEpBZUtkN0NvL0lzOWIx?=
 =?utf-8?B?M2J5ZHNyblNpUHQyOFFralloNlRpV3dEVU1IQnZCWGYrYWlKUGM3TTFuV1JZ?=
 =?utf-8?B?SkNqd2dLK2NKRVdiOW1weHlHeFBqak1uTXhvRUkvalR0QS81TGkvRlFTT2Ra?=
 =?utf-8?B?Q1g2NkFBS1BUaE1QdW9zTVNkS0NzV25sbHh3YXlwNmZQdVJJTjZXMml3L3BJ?=
 =?utf-8?B?blZQMVU5c2VLU3B5emdJTk9Uem1HRjVxSXN5REMwbEhtallvUU9iN0poOTg4?=
 =?utf-8?B?ZWF4Z09OYUxTYXQvRHUwRW9UdFJTdU5LN3NpaWFvMzhXZWtaa2hyWjluQjly?=
 =?utf-8?B?LzdTeWxQVEZOR3FZbWorQ1czK1NTY3dzNFNKeEhKTDNSMGdWN2l0REY0bUVt?=
 =?utf-8?B?MCtGeEhIYVZZUFA1Wm9BN2poS3pMOHpwN09xeVR2Vm5ucGwzOTVDU25VY3dj?=
 =?utf-8?B?U0V3RUhTN29aUjcrRmxsbyt0S2k1QWNzMTBPNGY1dEZKZmhFdlBrZXZxRi94?=
 =?utf-8?B?Ukh3bnp4R1RBSzRudjJQVEl5TzBOd29wL3JpaEZqc2xLSlZqeW9YVTBPNVJE?=
 =?utf-8?B?Z1JqbnVTeGJJcFpVc0xYelIrOTlLRlRsYXhxMlR1cU9xcDlHTEdGQSs0eGVG?=
 =?utf-8?B?c0YwYmVvV0hSUVIxcDJraUJjSnZnZFU4S21CMWJ0QkFvK0YyVEtOZWtCc0Zu?=
 =?utf-8?B?QlVualZxN3J4b0U1UUFzb1ArTnFXRkVUb3FsMjk0eDBSOFFWM1NSZms0WDM0?=
 =?utf-8?B?Y29CQjU0SksrZzhIdXlCN2NETDhNaW1iMFJyR3Q4dzlmRkZMSHZxeUJ6aENo?=
 =?utf-8?B?RWYwV3prb3pBdHRxNW52ZGV6Y0xxeVNXc0lqR2o3WnRhZHdDWXhFQTZjUW1N?=
 =?utf-8?B?MWZIUmhIdy8yRlFxczlIY3loVmRQS252UkpXYVRNTmNkVVhCdUhkWTVjL1F2?=
 =?utf-8?B?WElWVkgyMWJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW45a09TKzVMdHdoOVN1d2tBeWQ3dHluLzJGOGtKSGlZMTdhYm9rRktEOCtu?=
 =?utf-8?B?ZHZGZ21kUlVpcDhWZ0hCRWJUQnU0UFhiTU1LM1d0SWFUbmdWVWJtVWF0OHQw?=
 =?utf-8?B?NGFDYUFXcEgvQzQ3SmdDQVA2c0JjaEl1bnJ3ZmdBa0ovL2xaekliTUNVOWp3?=
 =?utf-8?B?cFVoRGFjS3pGeEtjcm9lZXM0QkVrdTNpays3NGVXVG5rVGRjcE52UVpXSU1y?=
 =?utf-8?B?ZHdoam02d0ViRTVkS1pYRU5lOXZScENWeVlMUXN0ZzA5VHMzTUlwYS8ydDNC?=
 =?utf-8?B?TXB5b1dYUm81dmNWRmtGS0pTeWpvRkRpeGx5VFBZYjBIMmJmTTUyZGFCazVo?=
 =?utf-8?B?ODMxd01BbHFFSC9WeWVVdnZDY29GejNOSkNpajF2MWp3R3hqdUtYUCtjNTBU?=
 =?utf-8?B?ZVExWkEwbDZ1NzZQM0Zvems1SXozQlVLZk1yLy8vbTdJeW8yUEMyY1VzeC90?=
 =?utf-8?B?WWxEaW54WmUxWWJtZFZsOUlPeGl6V3lJbVpsSzFOTko1WVJJMlBGb2gvR0Y3?=
 =?utf-8?B?U1JqcVVlNmIwL3J1eXZXanpsWVdCNWlhMVNTbUxIbnoyTGY4dnd4SHgzSlhp?=
 =?utf-8?B?M2FIcnB6eWNkRW1RdW1RUDJjTjZrcE02U2U5bm5NMjVkNzREa3ZhTnFMRWF2?=
 =?utf-8?B?ajllaHl4ZzduTWFLMVFIWTdIL283a1pQYWdjSkxTdHRpT0NhMzNwTFp5RHBM?=
 =?utf-8?B?Y3ZNKzBJVzlacHRuN2MvWXNweVgyZTFRNUdBZTRNQjFCTWlCeHZvL2RwT2VZ?=
 =?utf-8?B?b0ZmNmY1RTRnZG1LU2ZUSVJiWTg3RmFFSm41ekgwQ3FqaTFxNm9WV0UvbEhn?=
 =?utf-8?B?dG1vVStMcmRsODg4VjZOL0JzajR6K0ZzTDlQUTl1ZDlIV3RRak5PdElxSW5s?=
 =?utf-8?B?dXJ0Rm5jZ1ovK2lETktsYjliUW1GQjhiYnBrM1dEMzBZd3hLUDhBMlFGL2Zr?=
 =?utf-8?B?bk9vbVlwUTFRSld2VjNPT21pNnNUUGRUSTEvQnE3M05uMzFNcVJGSGJ3TWY0?=
 =?utf-8?B?bXdJUTFKcW16bFZKVURya1dqb0FhRi9UUDFDZDFyZU5JOVFDS0hVMkY5S2tK?=
 =?utf-8?B?NXY0YmVKWEpGNmRYMERpMzJQSVM4dkRvR3BEOGc0TmFUeURGeVRvYmVJN1FG?=
 =?utf-8?B?UFVHeFFnVU9SREk5cllweDBwMkxIeUtHbEJVUGJ6clQ1bzFTK1pPSWV5cjdk?=
 =?utf-8?B?TTdPQ09KcWJncC9ZbzJXTloyTWhTN2MxbVJ5L0lpZGFLa0s0MW1nd2hnb1Fl?=
 =?utf-8?B?QUZocjdrekdqZHpIQXg5NWpOZGhrSFBBUlVvRGZEMFBjcVk0OVdQclN6bFNa?=
 =?utf-8?B?MEJxWUJIdUx6T0pZaFZQWW9Pd0pGa2RvMFJ0ZkxocjY3cmJmMFU2Y2d5VTMy?=
 =?utf-8?B?dU9hcXh1VkZCbmora2l0b0w4U2c1YlBybk9rZ1h2VVEyTzViS2tFcWwwZFBr?=
 =?utf-8?B?UjBPajZwSFZPeElSNmMvUkNmaUhod3paTFNSdEVoNTNxUEdOUmY1SGYxQitu?=
 =?utf-8?B?ZEE0QUZoR21sNmdmU3lWeHN6djczVHNFa1UxSUhiT1NraFNsenFBdjhQOTVC?=
 =?utf-8?B?dmpzY1Z4dExHOU5WMDAydmZmNW13bmNBVHl6RUdUNmRWZjg1ejlLdjVJRFpG?=
 =?utf-8?B?VGVOcEM0OGdIbVllcFVYQU1WZDFtZitUMkcwN25RZTdEQUhEMk9lTUlvbTYz?=
 =?utf-8?B?R0dOZi9EVGlMbm9zdzVxRzlkMEFqT1h1aEpYa3daSE93MnNvVmRpRXBEdVpw?=
 =?utf-8?B?MlNkbXB2dG55SWk4NFhXOGxsUVNRN3p3ckQxZlB3djJHVzJwRklrbXZuaFhw?=
 =?utf-8?B?c21UT09ZMmUwVDQ5NFoxSko3V29zRVZnMURRMHpvWFE3VUZ6UGQ3QnY4RGtm?=
 =?utf-8?B?ekhSN3poWkFwY2p1NGhrYjNCYW5pRUdSZ3RIOXp1VTRoSEJEVFZjQjhRMm5W?=
 =?utf-8?B?TDlkUFlWcjl3ckw0NWNac3BBTWNhNExhVklCZWs1NmFVRkZLaHk0MTlSUDNY?=
 =?utf-8?B?NCs4TXNpN2lEOGVJOHB1SkhDNDhMc1dXK05PeFMzWVlXVUZGTWI0VGd6eUlz?=
 =?utf-8?B?N0tZOXZjT3NibEFNRzcrOWY4cUlGT1U5NnlBbldzaXZRa2FlREI4OVVTS2VK?=
 =?utf-8?Q?cZNdRw5K3ikpStiHSGyreyAX/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29939d7-7c34-469c-5de4-08de38857910
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 07:18:24.8924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZRKONoRj+CciS1d0XmwfWwzIUomco8ACnE0EAcT17EWj5sWcP58UBFtxSJCf9WYreYDwTga5aHOyAfwaIk3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11184
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

With name defer, imx95-blk-ctl clk driver not able to find hsiopll when
registering the gate.

Patch 1 to export a function that used to resolve the scmi clk
Patch 2 is to update imx95 blk ctl driver to use the new API.

This might not be good solution, but I not think out of better method.

Patch based on https://lore.kernel.org/u-boot/20251208-sqqs-v1-0-290f0594e30b@foss.st.com/T/#t

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      clk: scmi: export scmi_clk_resolve_attr
      clk: imx95-blk-ctrl: Resolve scmi clk before using it

 drivers/clk/clk_scmi.c              | 20 +++++++++-------
 drivers/clk/imx/Makefile            |  6 ++++-
 drivers/clk/imx/clk-imx95-blkctrl.c | 48 ++++++++++++++++++++++++++++++++++++-
 include/clk/scmi.h                  | 12 ++++++++++
 4 files changed, 75 insertions(+), 11 deletions(-)
---
base-commit: d41e5e6195061908e8d9b3e0da8ef9ea8bf37193
change-id: 20251211-clk-scmi-imx-fix-0ffe099aa3d7

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

