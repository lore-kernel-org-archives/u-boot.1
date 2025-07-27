Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBC7C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 12:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7EE83A26;
	Wed,  6 Aug 2025 14:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mu5NwUSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D144483A26; Wed,  6 Aug 2025 14:40:57 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F9883A26
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 14:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmPFQ183aLLCFQwDlb73fGWZe9IrvlKLuW80LJb7fleLnf56Nse9yjR12gHwOk8w6lGrFuR/jbcbrYo2CvpkzjmVNPGWJX2gSD3rO18nDXHYNmGEAaQAH86myRm8kM4JBK/9WLloJr4Yg7gluZ5api6CVOI5Q5RcAZzejhnxR9kX9MK3BGo7WmPy1Rvsa64/20xa9cG5HSt8tGxK3dd8/JfYVOJU0cfnnIjWFEER13ycIse2B7FDeA3PTrAvs+1epTWGa+TGLSB9kbOZhEgVJ7+dHg8aQzq3oLA/J0Grimm4QsBtpgvRmYWdsYknd3mf7tUJbl84XOAw3p6P6A0opg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IkqvbuVeykc+TuADTHSYR7VodY68QBjmb5sj5zbJGk=;
 b=vfUFPXQAh9Jql22WS8hsp90Qll06bPiGlgnWBuZdMwh3fzZle/PYqpI/rsXSZ7cguorhR20vN8l3rjYCAn8HwM9ajpgD3tUwdrjAMu+IpuQwDBcG4t7jnnRY7XhjPaILUkpHby7dWF/h5ZZ9CwvpE6vAxQmFe2FuwAjHIzu/C6xPZWu3CZDkUHqNLuiE+ScfsD259aCQjCF1wgBjRya8tvtlewhP3TNL1IQqAsdedftVBbJ7dYqrEW8K9zQiLk4+nIdcMvRa1cn8fLJr197+qQnSlGh90ojHEfZDi3L1l6gxZF9wX69k1BB0BGZnpw7dSf/bvgsg2hBgbenA+/E4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IkqvbuVeykc+TuADTHSYR7VodY68QBjmb5sj5zbJGk=;
 b=mu5NwUSp3eOAdZ3tUr4ogHroi0T4S0AbKe9aOd392rdF/0SZglJAd3Xckczo5ANTsSF9bGsUV+B4dLEoSTZPDAo6JpDlGY4dRPkGE4RkVnZjAGbTuRIV1vde5x8omb1eCQ1+JyEOmHG/0bqbaHkoI9OEO65rPaHZzkfV7V0T2stpeaPFqxYc+hM+HFCDbtXEm+zXifQ8ahGiokWsICaFIX2Jkr01qGLvoMilM2nHTAzNQwbDZgJVy2ETZbnvpFd7BE9nmTX66aiMfzZJK8IXy7sAszuXW2d+6Ce+O56sq3seSGlgQBQbiH3XgE0HKWqOVMLNwzCULSSE2ZC5HgCNag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by OSKPR04MB11391.eurprd04.prod.outlook.com (2603:10a6:e10:99::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 12:40:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8989.020; Wed, 6 Aug 2025
 12:40:53 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Jul 2025 07:35:01 +0800
Subject: [PATCH v2 2/2] imx95_evk: Restore support for i.MX95 A0 silicon
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-imx95b0-v1-2-5cdae3764d21@oss.nxp.com>
References: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
In-Reply-To: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|OSKPR04MB11391:EE_
X-MS-Office365-Filtering-Correlation-Id: ba605906-f485-4ba0-31c8-08ddd4e67aea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTFGUnd0YmxrTE9PbkJwSmtXL29Dd3AyTHFZTmJBeVE4TUs2KzFDcFN0dFFS?=
 =?utf-8?B?OFgvUWFVbzRtQ0ZpdkFSSHFocjE2VXlMMEtySFJ2VVNDcTBQOUx1cGhNQW1J?=
 =?utf-8?B?SWJMaDZlaHp6RlFuNkNpSnJuejJZRmZhNkRxUHpXQTZNTUZ4RjIzR085N3RR?=
 =?utf-8?B?THhGczNVWlppRUN0RFNSanJTOHZ5MjMxYUpUWEpwbFVZNGd6L3hCQ2ZiVnVE?=
 =?utf-8?B?VjBoYkNHcldodGdXMU5SaDdMbEVWUzZ2ZjB3aWJ5ekhSVllXaXdneUpoTVUx?=
 =?utf-8?B?U1NQL3BPSHF4REp1TStJT2JFWTJXOEtrT2kvSE40WENycm8rdXZPRVVsSm5F?=
 =?utf-8?B?b29MTjFrTGcybHVIMHZqcWxKN2g1azB2U1JibXh5RTdDTlVCRnhicW9GR2Q0?=
 =?utf-8?B?ajJQcjlPa3dKNlFSZWZ5NiszWGNsQVBGTWRKNjJmbUF2YmMyOFVIeUprVkc3?=
 =?utf-8?B?MEY3Ri9USmhxWjFURzU3WUxHUWp2TThOUEEvYVN2YjdQU0gxQmFiNnM0amlj?=
 =?utf-8?B?OXkvZHU5NU1BUEpKNWtRZndwNEpHN1pqKzI2aGRXbHNUL0F0dGd6TXZSR1BR?=
 =?utf-8?B?QlR3NHI3SldxMFF4ZFgyeFlZT2RHS2JjWGVYaWVZUUJjSzRDZUNYQmNZblRY?=
 =?utf-8?B?bis5ZjVjMzdMby9vckxPNXNnRzNZWXJWellwbnkvbVV3TGhBaHVJVnFiVUNC?=
 =?utf-8?B?Zkk5OG5nVlV5eW1uano5KzN1Ylk5dGtESDhXcDJFSEtqd1ZDbWdUTXV3UmEz?=
 =?utf-8?B?SU5nOUdnRlN3Szhab3QzQUhibyt4OHI2SnZFeWxORlBFajBvc0laaFNsV2dR?=
 =?utf-8?B?NEQyRXV5dmxaa0xmUEtOMWd6clNjTGdtN2VSYU1Vai9tdjBCUTdNdksxSFJr?=
 =?utf-8?B?OStGMTgvWmhCTEdWejdxMTNGOFhmeEVucFVheDNRUWJoM21JS0pEZE9ocVFo?=
 =?utf-8?B?dkZJQnliOWV6SHF5QjZyc0VkdUR0YjcwS1hEdDFTbUY0VFdwbjJLa0lJL2Vl?=
 =?utf-8?B?RVlqZmNoY0sxSVI2ZC9OZGloZHlXTzFGTXBobmx2SGhnRDRJcmFLWk5adXJM?=
 =?utf-8?B?TXNhTTBRVzJUVjdLZ0hMK2FGSll1UlFlRGx5ZDdib1B5TGJDWk1UNWhVZEEr?=
 =?utf-8?B?MWhNOFRzZkJscDBGdWZhbnhpRnZLVCtUL3NMVWxZTUlyeHFLakwrbEZsWW91?=
 =?utf-8?B?RzdFcU5KVzBMTjhFZDNxWHdJNnV6Y0U4ZFNLN0NFd3A2R2lzQnkwSzYwRGp5?=
 =?utf-8?B?NmM1ai9hdUZ1SHFWVnU3OE1Bc0hwKy90MUVpaGJhYmpKZ3VmOWdKOWkweWxx?=
 =?utf-8?B?alJrYkVTMTlUV3I5VXQvendtZ1Z5bmJzaUgrNFhLb2ZkWVRnWFB6STREK0NM?=
 =?utf-8?B?WW9OUjJIN2IvdjZvZzRGSmdKd1ZiS0daTWdGSjVTMXdaL1kzdjg1U09vRWtB?=
 =?utf-8?B?dGZUeTFZbDZtYzJNQUw2bGM5N0lOYWs2ZG56d3BOVXlWcWg0a0NheU5zUkE0?=
 =?utf-8?B?cm9UbW5IWGt0VUtSUm5IaER2YWU5NElwOUFmY0FhdU1OYTdrSFdoMDc2U0hK?=
 =?utf-8?B?alZrZGV3MnNQdzZkQWxwTWpLa0FpcDVTdDRnM1liRnc3K3pRNGQ2MDRkVTJw?=
 =?utf-8?B?bUYxdGpuU3FCWnhjRjVDOXl2d0NDZVhnZWRsRXk4VXlpS25RTjM3aWxDZnNj?=
 =?utf-8?B?eFQ3UUZTUGpqcStiSnEyMkZwQk9mWGxSNnJiRnIxbHoxQmRTQThabU9LVmlQ?=
 =?utf-8?B?b3RBSTB3N0tBOUhDWXdnY2FkZ1BtdlRsZCtSd0VOMC85dDNMQ1RReWNDZk5G?=
 =?utf-8?B?R2dkZVl0ZEczT1poQ0h0MlJhWlBycFZrc0Q2TUhHN0VKQnhIaG4vcGdjcjNi?=
 =?utf-8?B?R1dFaUpHMGZDZkhMQTRsTjdKRlBaSlRwSkJ5a3R6N1Q3TE15TGZRVzBDVGJz?=
 =?utf-8?B?bURUelYybVpKU05qRW0xWjRaek5qaUtadEszSiszSFRENW5IOUttZ0NXaXpT?=
 =?utf-8?Q?8xBdkjveHoT+6jKbZ0poRQswGUbMOU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTZRMlV3R0NGYWVlSEx0RWk2ZXJ5RCs4M29PUU5qRVErV3k5bGtVUjgrQncz?=
 =?utf-8?B?YWtqbmxkZ2EvazZLVWJwYzUydklJWDlYV3pRZVA0SEVOZElBaGliRHhGd1RQ?=
 =?utf-8?B?aUtBYlFCb05sbVBsQzJCOUI4Tkd0dnpkNjUvblFFR0dlR2NiQTFLeElLVWZM?=
 =?utf-8?B?MnBQUXhYT3JKaGlWY3UwNEpHd3AvWHFEZXR3WnkvRnhpeEZ1NVhQYUZMVUlW?=
 =?utf-8?B?MGtRN2RhRmM1SmZ4OCtZVGxndmViMFRzcW9LMlJaSnBEeC9BeTNSTGF5TG5m?=
 =?utf-8?B?Qit1VkRjOTVPcm1iRUVLSHEvU0VhWTg5NlZCcDBqWEtkYXJUQ2xGbkpLc3Yz?=
 =?utf-8?B?MjlnVThLeEErTDMwODhKZU5NMmxSbWQzdGdpZFI2SVR3NHNWSm9nZ1RVNEMr?=
 =?utf-8?B?c3lvYnkyT3kvTEtETy9jK3pFRi9nazRCeUFQMlFYaS84MWdja0xHZTlEc044?=
 =?utf-8?B?bkNFLzFMSU5oNVFhSGtGb0FOOWVTcnpLOWoxMFlrNFlxdS9rV0tzVE5WUit0?=
 =?utf-8?B?SG1XL3J1R0ZtZzZUY1kxTENHeFhhL1didkdYQWVTS01DYnpRYVlia1FZNnU2?=
 =?utf-8?B?SXZLUlhCR3kxUDVJOGdnL3ZwYUxub0FuaEQvNCtGRkJzK3lRUnAzaG1uVVk1?=
 =?utf-8?B?bkZhemIxOFdEMzEzNi9QM1NvK3hyYzNGU1I2a2N5bFgvTktablVxczVsQ0dJ?=
 =?utf-8?B?bHhvbkFRaEVwaWt6QzlHcG5yTHRwa1g2cVR0TlBqbm1lWjdqTXRVM1gyTlFS?=
 =?utf-8?B?WGw2ZWRGZGpMMkNnNEkzUDNBYjlwamtmSk04VCtvRHkxWTdYWHJQbUhxdTQx?=
 =?utf-8?B?QXRub0t6bFk3WkxaQjRhNVFOWXpOdEZ6M1MyUlFyb2x5cUJTNDViWS9tTjlz?=
 =?utf-8?B?bVZlUFhhOVY0MEpFbUU3cDRCR214TVBWSHNCaGNlT1ZyT210Q3hUYS9CVGR0?=
 =?utf-8?B?aTRFVnhhM1NpaEw2cG4xR2czbDVjZGpIVFpHUFZ5NnpLYlh0VU5oVjRGNERn?=
 =?utf-8?B?U0xCQ2h1NnhFNHVpMldxdUZmblZGUlp6V0dCYmFrZkhPMUN5azJUSTBDMGpk?=
 =?utf-8?B?Nlh2VWpQSjc1a0wzMmRPV3JsQ0pmYU9xMFRXUC9JTXB4Z0Q5WUNac25QV3F0?=
 =?utf-8?B?ZWsxR2VFeGdaNmNGRzRRbHgxSnFOd0cwZU54cVZ3b1lUVE9QdllZTks1c0lP?=
 =?utf-8?B?c2hvRDZYWHdNNVdsR2F1VjY3a3NFZjFpY2FSUGFBRDVzMEQ2WitvVlYrMGlB?=
 =?utf-8?B?YllxTWpvQXdvdEdIdkJndjJVdnpNVnFQQmZHKyt0a2pYS2M2Tlhvc3FncGJB?=
 =?utf-8?B?MmVZR3F3cUtxTDg5My9ObDBRNHVWRHNGaGl5ZHBRWnFJU1p0STNHakZXbmJN?=
 =?utf-8?B?TzBhM25UQVhIOUQ5ajdYeEltZVN1MTZPeE45TDd4UExTZWZEZHV0SXVScTFV?=
 =?utf-8?B?Y2V6VUQ2WHpaanVjSjNla1MvVHlhY2dWTXFCWFR4eENhMmYyS3JvdWxzeVB5?=
 =?utf-8?B?cWNnQWFzNUNwTFEvelZVU2JHMWtXb2hrZjhMd0ZuZWs1UzUzeFhUTmZ4WjFJ?=
 =?utf-8?B?dWhTelFlYmxDTDZYMzlvZEdlTThJaHpOSTVaLzVuWDVEMzRoTDlVaDMrVDU1?=
 =?utf-8?B?SHVYQlpnc3J2RVROTE5iUHdpRkFCQk5sd1VhcnhpQzIyYW1WdzZyaDVkcDQ2?=
 =?utf-8?B?cmdzajB6WjY0UFc5NXVvdlliYmRyUFBsVkF0VTV6OUU5SjZJaEpiSUNKcis1?=
 =?utf-8?B?NGJmZjFQWm5KOE4yOU54QzJ6dXUwZXQ1eUNGSWNrSUM5cmdOL1l4V3BXeVA0?=
 =?utf-8?B?SmNGNmQyZ3A5QXJ3YW44NUFWNlB5cHRNd0ZyV25MOFJpU3NmQjFidFo1TlZT?=
 =?utf-8?B?U1dDeXQrL25vYnlPUFMrSFNHV1lpdEJtdWovWEZ5MytzdU9jeTVHUXBMYjFu?=
 =?utf-8?B?RncxZk1Jc2Faanl5SEFnREJTN1hhK2RJalFvNVkwanpxZ2hQNEJ5VEZOWlVw?=
 =?utf-8?B?ZXVnYlBjWTA5Q1Z6RkJ1VmVBd2ZWNTA1Q3pHS09BWkdJZUVWYnFCNys1Uy93?=
 =?utf-8?B?MUF3SFhwSnAzNzBSQVpRLzY2NFhMQlpvYTRBWUZVcTFSb3hyL3A0MGhsTTR2?=
 =?utf-8?Q?FsF0QAGizYH/7uOLduD0F556g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba605906-f485-4ba0-31c8-08ddd4e67aea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:40:52.9839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1NVfc3C0VYRrfhizfYLbLcpehyOkbTSDxr/qDTkRPdr9+YyRhNSXTayK3+pLCjWBCHBjjKihjrQMEE27AoXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11391
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

From: Alice Guo <alice.guo@nxp.com>

This patch is used to restore support for i.MX95 A0 silicon. To avoid
duplicating defconfig, imx95.config is added and can be shared between
imx95_a0_19x19_evk_defconfig and imx95_19x19_evk_defconfig.

container.cfg and imximage.cfg are used to created .cfgout files that
are be passed to mkimage with -n to build flash.bin. Now they have been
deleted and replaced by adding their content to the property cfg-content
of node which type is nxp-config under binman node.

Fixes: 9936724aa9b ("imx95_evk: Add i.MX95 B0 support")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx95-u-boot.dtsi            |  48 ++++++++++
 arch/arm/mach-imx/Makefile                |   5 +
 arch/arm/mach-imx/imx9/Kconfig            |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
 configs/imx95.config                      | 150 +++++++++++++++++++++++++++++
 configs/imx95_19x19_evk_defconfig         | 153 +-----------------------------
 configs/imx95_a0_19x19_evk_defconfig      |   2 +
 doc/board/nxp/imx95_evk.rst               |  41 +++++++-
 9 files changed, 247 insertions(+), 184 deletions(-)

diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 9bf8f9834c9..227e220cd65 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -51,6 +51,54 @@
 			filename = "flash.bin";
 			pad-byte = <0x00>;
 
+			imximage-cfg {
+				type = "nxp-config";
+				cfg-path = "spl/u-boot-spl.cfgout";
+#ifdef CONFIG_IMX95_A0
+				cfg-content = "BOOT_FROM SD",
+					      "SOC_TYPE IMX9",
+					      "APPEND mx95a0-ahab-container.img",
+					      "CONTAINER",
+					      "IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000",
+					      "HOLD 0x10000",
+					      "IMAGE OEI oei-m33-tcm.bin 0x1ffc0000",
+					      "IMAGE M33 m33_image.bin 0x1ffc0000",
+					      "IMAGE A55 spl/u-boot-spl.bin 0x20480000",
+					      "DUMMY_V2X 0x8b000000";
+#else
+				cfg-content = "CNTR_VERSION 2",
+					      "BOOT_FROM SD",
+					      "SOC_TYPE IMX9",
+					      "APPEND mx95b0-ahab-container.img",
+					      "CONTAINER",
+					      "DUMMY_DDR",
+					      "IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000",
+					      "HOLD 0x10000",
+					      "IMAGE M33 m33_image.bin 0x1ffc0000",
+					      "IMAGE A55 spl/u-boot-spl.bin 0x20480000",
+					      "DUMMY_V2X 0x8b000000";
+#endif
+			};
+
+			container-cfg {
+				type = "nxp-config";
+				cfg-path = "u-boot-container.cfgout";
+#ifdef CONFIG_IMX95_A0
+				cfg-content = "BOOT_FROM SD",
+					      "SOC_TYPE IMX9",
+					      "CONTAINER",
+					      "IMAGE A55 bl31.bin 0x8a200000",
+					      "IMAGE A55 u-boot.bin 0x90200000";
+#else
+				cfg-content = "CNTR_VERSION 2",
+					      "BOOT_FROM SD",
+					      "SOC_TYPE IMX9",
+					      "CONTAINER",
+					      "IMAGE A55 bl31.bin 0x8a200000",
+					      "IMAGE A55 u-boot.bin 0x90200000";
+#endif
+			};
+
 			spl {
 				align = <0x400>;
 				align-size = <0x400>;
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 8bd85e889ab..fa2cdaba144 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -223,6 +223,10 @@ endif
 
 ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
+ifneq ($(and $(CONFIG_IMX95),$(CONFIG_BINMAN)),)
+SPL: spl/u-boot-spl.bin FORCE
+	$(call if_changed,mkimage)
+else
 quiet_cmd_cpp_cfg_imx9_check = CHECK    $@
 cmd_cpp_cfg_imx9_check = $(CPP) $(cpp_flags) -D__ASSEMBLY__ -x c -o $@ $< && $(srctree)/tools/imx9_image.sh $@
 
@@ -244,6 +248,7 @@ u-boot-container.cfgout: $(IMX_CONTAINER_CFG) FORCE
 flash.bin: spl/u-boot-spl-ddr.bin container.cfgout FORCE
 	$(call if_changed,mkimage)
 endif
+endif
 
 else
 MKIMAGEFLAGS_SPL = -n $(filter-out $(PLUGIN).bin $< $(PHONY),$^) \
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 4e0e194690b..b6acbb20ff0 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -25,6 +25,9 @@ config IMX91
 	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95_A0
+	bool "Support for i.MX95 A0 silicon version"
+
 config IMX95
 	bool
 	select ARCH_MISC_INIT
@@ -33,7 +36,7 @@ config IMX95
 	select DM_MAILBOX
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
-	select IMX_PQC_SUPPORT
+	select IMX_PQC_SUPPORT if !IMX95_A0
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
deleted file mode 100644
index b25f3b726c5..00000000000
--- a/arch/arm/mach-imx/imx9/scmi/container.cfg
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2025 NXP
- */
-
-CNTR_VERSION 2
-BOOT_FROM SD
-SOC_TYPE IMX9
-CONTAINER
-IMAGE A55 bl31.bin 0x8a200000
-IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
deleted file mode 100644
index c2c92174c1c..00000000000
--- a/arch/arm/mach-imx/imx9/scmi/imximage.cfg
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2025 NXP
- */
-
-CNTR_VERSION 2
-BOOT_FROM SD
-SOC_TYPE IMX9
-APPEND mx95b0-ahab-container.img
-CONTAINER
-DUMMY_DDR
-IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
-HOLD 0x10000
-IMAGE M33 m33_image.bin 0x1ffc0000
-IMAGE A55 spl/u-boot-spl.bin 0x20480000
-DUMMY_V2X 0x8b000000
diff --git a/configs/imx95.config b/configs/imx95.config
new file mode 100644
index 00000000000..231b42cb377
--- /dev/null
+++ b/configs/imx95.config
@@ -0,0 +1,150 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
index 73818a82627..abbd0ab3068 100644
--- a/configs/imx95_19x19_evk_defconfig
+++ b/configs/imx95_19x19_evk_defconfig
@@ -1,152 +1 @@
-CONFIG_ARM=y
-CONFIG_ARCH_IMX9=y
-CONFIG_TEXT_BASE=0x90200000
-CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SYS_MALLOC_F_LEN=0x10000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=3
-CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
-CONFIG_SF_DEFAULT_SPEED=40000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0x700000
-CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
-CONFIG_TARGET_IMX95_19X19_EVK=y
-CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_SYS_MONITOR_LEN=524288
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_TEXT_BASE=0x20480000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x204d6000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-CONFIG_SYS_LOAD_ADDR=0x90400000
-CONFIG_SPL=y
-CONFIG_SPL_RECOVER_DATA_SECTION=y
-CONFIG_PCI=y
-CONFIG_SYS_MEMTEST_START=0x90000000
-CONFIG_SYS_MEMTEST_END=0xA0000000
-CONFIG_REMAKE_ELF=y
-CONFIG_FIT=y
-CONFIG_FIT_VERBOSE=y
-CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
-CONFIG_SYS_CBSIZE=2048
-CONFIG_SYS_PBSIZE=2074
-CONFIG_BOARD_EARLY_INIT_F=y
-# CONFIG_BOARD_INIT is not set
-CONFIG_BOARD_LATE_INIT=y
-CONFIG_PCI_INIT_R=y
-CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_BOARD_INIT=y
-CONFIG_SPL_LOAD_IMX_CONTAINER=y
-CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
-CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
-CONFIG_SPL_I2C=y
-CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_POWER=y
-CONFIG_SPL_WATCHDOG=y
-CONFIG_SYS_PROMPT="u-boot=> "
-CONFIG_CMD_ERASEENV=y
-CONFIG_CMD_NVEDIT_EFI=y
-CONFIG_CRC32_VERIFY=y
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_CLK=y
-CONFIG_CMD_DFU=y
-CONFIG_CMD_FUSE=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_PCI=y
-CONFIG_CMD_POWEROFF=y
-CONFIG_CMD_SNTP=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_EFIDEBUG=y
-CONFIG_CMD_RTC=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_GETTIME=y
-CONFIG_CMD_TIMER=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_CMD_HASH=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_NOWHERE=y
-CONFIG_ENV_IS_IN_MMC=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ENV_MMC_DEVICE_INDEX=1
-CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="eth0"
-CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_SYS_RX_ETH_BUFFER=8
-CONFIG_SPL_DM=y
-CONFIG_REGMAP=y
-CONFIG_SYSCON=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_CLK=y
-CONFIG_SPL_CLK=y
-CONFIG_SPL_CLK_CCF=y
-CONFIG_CLK_CCF=y
-CONFIG_CLK_SCMI=y
-CONFIG_SPL_CLK_SCMI=y
-CONFIG_DFU_MMC=y
-CONFIG_DFU_RAM=y
-CONFIG_SPL_FIRMWARE=y
-# CONFIG_SCMI_AGENT_SMCCC is not set
-CONFIG_IMX_RGPIO2P=y
-CONFIG_DM_PCA953X=y
-CONFIG_ADP5585_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_IMX_LPI2C=y
-CONFIG_IMX_MU_MBOX=y
-CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_MMC_IO_VOLTAGE=y
-CONFIG_MMC_UHS_SUPPORT=y
-CONFIG_MMC_HS400_ES_SUPPORT=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
-CONFIG_SPI_FLASH_MT35XU=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_AQUANTIA=y
-CONFIG_PHY_REALTEK=y
-CONFIG_DM_MDIO=y
-CONFIG_MII=y
-CONFIG_FSL_ENETC=y
-CONFIG_PCIE_ECAM_GENERIC=y
-CONFIG_PHY=y
-CONFIG_PINCTRL=y
-CONFIG_SPL_PINCTRL=y
-CONFIG_PINCTRL_IMX_SCMI=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_SCMI_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_SPL_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_SPL_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_DM_RTC=y
-CONFIG_DM_SERIAL=y
-CONFIG_FSL_LPUART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_NXP_FSPI=y
-CONFIG_ULP_WATCHDOG=y
-CONFIG_LZO=y
-CONFIG_BZIP2=y
+#include <configs/imx95.config>
diff --git a/configs/imx95_a0_19x19_evk_defconfig b/configs/imx95_a0_19x19_evk_defconfig
new file mode 100644
index 00000000000..17b89728e15
--- /dev/null
+++ b/configs/imx95_a0_19x19_evk_defconfig
@@ -0,0 +1,2 @@
+#include <configs/imx95.config>
+CONFIG_IMX95_A0=y
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
index 27cd15eb7c9..83ec628f989 100644
--- a/doc/board/nxp/imx95_evk.rst
+++ b/doc/board/nxp/imx95_evk.rst
@@ -21,6 +21,16 @@ Get ahab-container.img
 
 Note: srctree is U-Boot source directory
 
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
+   $ sh firmware-ele-imx-1.3.0-17945fc.bin --auto-accept
+   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctree)
+
+i.MX95 B0 silicon version
+
 .. code-block:: bash
 
    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
@@ -53,12 +63,24 @@ branch: master
    $ export TOOLS=$PWD
    $ git clone -b master https://github.com/nxp-imx/imx-oei.git
    $ cd imx-oei
-   $ make board=mx95lp5 oei=ddr DEBUG=1
+
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=A0 DDR_CONFIG=XIMX95LPD5EVK19_6400mbps_train_timing_a1 all
    $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
 
-   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ make board=mx95lp5 oei=tcm DEBUG=1 r=A0 all
    $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
 
+i.MX95 B0 silicon version
+
+.. code-block:: bash
+
+   $ make board=mx95lp5 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
 Get and Build System Manager Image
 --------------------------------------
 
@@ -82,13 +104,14 @@ Get and Build the ARM Trusted Firmware
 
 Note: srctree is U-Boot source directory
 Get ATF from: https://github.com/nxp-imx/imx-atf/
-branch: lf_v2.10
+branch: lf_v2.12
 
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-
    $ unset LDFLAGS
-   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
+   $ unset AS
+   $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
    $ cd imx-atf
    $ make PLAT=imx95 bl31
    $ cp build/imx95/release/bl31.bin $(srctree)
@@ -96,6 +119,16 @@ branch: lf_v2.10
 Build the Bootloader Image
 --------------------------
 
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_a0_19x19_evk_defconfig
+   $ make
+
+i.MX95 B0 silicon version
+
 .. code-block:: bash
 
    $ export CROSS_COMPILE=aarch64-poky-linux-

-- 
2.43.0

