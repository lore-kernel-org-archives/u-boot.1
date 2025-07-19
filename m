Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22166C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 11:20:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87F8683045;
	Tue, 29 Jul 2025 13:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sJbt8QWo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32188830EA; Tue, 29 Jul 2025 13:19:55 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 402FA83045
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 13:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSqnlBiQ9AMXDelaXUzDNg/EpBuZgpQ4Tl+O7nQAhSA1u8CWA74bUe556qMYPfXCpAC2ostkuudZsh35GavAeGTDTdECRDZQ7J9UqWpGRrkdLhEjGqJgss+azOh6tKwscUVt8olhhUgvkPTMlyKe3fC4frOhyTwAmBl2Pu4GEwtbXKW04Vx5k72Sndy3ebg7LeRzwLn75K8eJmHctKKG/2wV0pVxLxxh7bWpvgvhE6OxAZqnkyfr2rKHZha3MaYFDnIbWj8wL1KpMHyEnIz3Z3eSRUet/1oVVjtpthRRYfx9APofo5fqtYjrkkUQW9GKEFAUDFgAD+h5EeQSF0OsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2La2x0lA3D0+z/vl3aFZXi1hiH2k44+HLST/Rpi08AE=;
 b=yAsvYAKGHRxfptyVUTYvkDTso3XOW2yamAEUa3g7RcmLZox3Q/HuR3mlRo9UnFpZSQeNqGDqqzZ19JZJYQCoseVG+U8Iy/NkWPAzz526uE3/pCQ4Lp6H+6KkfAOZmNuJ4hng6HvNmoAAhGopEKMUE5/GuFgSuGvTv/+hvijDzWSffPcdgOpZgSk40m+euN0HzYfWE0OcPJDj0kIpzrll8YIQ4c+GyGZb8p6+PzPqpBVcOIc876KgdzRVn1nIZho22j8FzlR2PYst5cemceHAspo10F9Aj/hZSqlrf9f+sZ/Guj87MeByPjhxYoul0S8m8PpHD3VpTG8Az+gXgCzIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2La2x0lA3D0+z/vl3aFZXi1hiH2k44+HLST/Rpi08AE=;
 b=sJbt8QWoKXbEM5pPsjcihZjS93FyMAcPV1qUXqWNrfFIq/XLrODvygcVk+KNtv88t3dZFgpybaJSgoY7cAAGP4r/vkkVW2ibIFhXuFktgDap1e14ZFsk8HaaWwL7HpDs6asVyHIekwd16hLcxR1GAyeuV0hACWQ/RSP9hUmWfBMB1iWkZ1MmUlBgmSRnslflxlzVdc4IXkQGElzVlOolO9ZRnptlAhBd+afDMtI9kGd79t4JGZWBjuTRRCliH6HiFceGI0Nka8ZjRVs+paEQCO3mz/SAvtZHyTAGYIsngYn/DKnHuUMAMj7r8Lx+eXZdJnnU3UZlqOVUp+awiS0djQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10648.eurprd04.prod.outlook.com (2603:10a6:10:586::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 29 Jul
 2025 11:19:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 11:19:51 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Sun, 20 Jul 2025 06:13:53 +0800
Subject: [PATCH 2/6] Add serial# for SPL SDP download
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-imx95-v1-2-759619b47b1f@oss.nxp.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
In-Reply-To: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
 Adrian Alonso <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10648:EE_
X-MS-Office365-Filtering-Correlation-Id: 892d1deb-1ba5-4708-3863-08ddce91d605
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDlBWUljd2w1c0xLd1d1ZkxsOFlnUDVzSzlGODlDWkk2cmFTT0hzZ1hCVHBx?=
 =?utf-8?B?WjczbFF6VjVZY2tDWlhlYmVlQkliN0dTK01tYmE0d0E0T3VzVWVnTUZSNWFl?=
 =?utf-8?B?L3ZOYWJFek1tTUJCZHJKZk40cndzTU5BbjlPcjh1YXRPeXdqczRCN0Iydm80?=
 =?utf-8?B?ODh5Y1BVT3M0blNWYzA0MWdHd1hOV21WVU1XeW9pUkl6Qmthamw0M3kwN3Bw?=
 =?utf-8?B?OVNlWS91NlEydmxIV3VnUmtyMFFQTzhkdEZ6cjJNeFFKajhXdVFsNW1YaVA5?=
 =?utf-8?B?eEpNSy9PVVRxSXNiZ0pKUm10YXIzVmdTV0h3M25MOEdIQW9BNjVnS2xVR2pn?=
 =?utf-8?B?QVl5MFRvV2wrTE9USEd4citlL2FjZWV4cUhZcnRmL3lwQzRjOWFaL1hvWkVH?=
 =?utf-8?B?dWNWZStQM2NhNDhkUEFrdHlNWDNnRUVNTk9VNWpEelFYNS8vR2dyVWdmTW10?=
 =?utf-8?B?T2dxZHN3aGFJUExROW1ycGlRMkd2ZFRxeXBmQm90dXBqOHpXSEJnbmxtd3h3?=
 =?utf-8?B?R3hDeTdPc21zT0kzTFZaL1ZienZTSFl5WDNTUjJPaDhDZkk1REVhdkRTQjlt?=
 =?utf-8?B?eFRuRXpUQk5xeWdJbFJpZ0dwZzAvMzdIUHNLZSt1ODczN2J3aXVWL3VlYzN2?=
 =?utf-8?B?RG0zakx0ZXp0N2cvNDFPdndabFZKNVR2RmJicGRYZnd1ZlJiMUVLRU8yQVdU?=
 =?utf-8?B?czBlcTJGL1RNUml0UFcydkoyTU5RaUNMejQ1cHBYWFVvM2p3MkJwSjVIRlZF?=
 =?utf-8?B?cE1WdVhHSTEwZ1drMWY1TTZLVnF5NFFGeEJIUFVtOFpZTis2aDRnNHRZcUNa?=
 =?utf-8?B?M0dVQ0lZZ3RoSjNNOTR2NTJrSFNneFI3RWlIdHZkWUR2Mm13ak5wME1GTmR5?=
 =?utf-8?B?RE54NW4yVGhkVkl6azkrd2JEQ0NZYmxsc3N0THBzWldIdmFBQlQ5ZlRHRGJT?=
 =?utf-8?B?dVdsVzcrOW1rajJibnFhVHFucHpsYnRVQmV4aTYvWXdKWE5GZmI0T0VndTE1?=
 =?utf-8?B?ZG1MSXhSL0RsQURxME1xSmVIUnYrK1ZjcmVaaUxXdFJoRm1qcnJPK0M5WTJE?=
 =?utf-8?B?aWlodDBoVEpjWXdUejJ4b3F4SjYxaWxTMC9vcVd4NUs0WVpPdXZlWEhqN3dS?=
 =?utf-8?B?QU9GVlJ3eTZWOFJQemRTdFRrYjNZaUZOMTMrSHlLbXRPMXJKcFVRY2cwQVA3?=
 =?utf-8?B?bnBIWHF3YytVWFFQN0RvUGFsa0tobXFzQTUrbkwwYk9XNThYMTliMk14K1BC?=
 =?utf-8?B?OHZ2UzFFV3hpL2YvMjl1RStubDVkbmk1Y1ZqNC95aFdNL1BjMEQyWGNFUGl4?=
 =?utf-8?B?L0ZIQmFCeTVSWklma09hTnNUYnI1V0QwQWp3SzNubEw2QUFwUFZDbVVBclk2?=
 =?utf-8?B?VDRROEtCQmMxMTQ0L3JDd3VmNFNLKzRWVG1KOVdBWjlPQzBnSWx1UWZWSVZH?=
 =?utf-8?B?OUg4d0NJejZEdFJDZC9mTXV6dTBHZW1pK1dLK0Nzay9hejNtbE5HamFmVnR6?=
 =?utf-8?B?YXFkQzNlelRHL2F3UTIzdVpkU2ErZFFFZlRwWDJBWm5oU3lpWUdtR1R0WFR1?=
 =?utf-8?B?UGZKdXlIRzlKQ0h1WHlHUUtUQmRsb1NPdTkyOFZDUzB2YnVrbWNNcUVCL1dj?=
 =?utf-8?B?UGN1N3VpclZBaStuc0Vzb1dNZ2dLZjIwQjZaZFp2c2lIUkY2VVQ5d1AvOExs?=
 =?utf-8?B?TWwyOGIxeXBFTHUrS1BhZzFZQW5pWVVVdlFhU0ZkSk5QMWlvL0RDbk5RcUFV?=
 =?utf-8?B?cjQ2WHhmNjh0cUgzZXhSYjBmVU51cjJGYitad3pSVHNDQUcrMUw2SWg0WnQx?=
 =?utf-8?B?aW5aWjgyNFErWnowejRBYy82MUNOV2hiK0V1RlpiRHY2cWJRTUxwbUozWkpO?=
 =?utf-8?B?NW5IUmNEZElURHVBbWI3eWNyTmR0RTR1ZVF4eVZqalR1eXhodStSOUZocUc3?=
 =?utf-8?B?MHV3UXZZeWhMTHFJYk1VTmVCUC9kVTRadktBWllpaFE5L1RjS3hNRmR4MVpO?=
 =?utf-8?Q?ghB2IQa9vumaf16+FpF+s0SDtwESbI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFJGVWVHN3Y4VTFtYURuYVBXTERZRkJOTU9qeVZjUEFWK3VabTZnOHpHZy9z?=
 =?utf-8?B?Z2ZJNDc3VXBUQnN2WnRFbjBCbWRSRnpGeEFhZHFXWmxqTnNwaUhxQytiTy95?=
 =?utf-8?B?bFNpUHFuVlVRNXFMVE05ekQ1VUMvL29wSlNYTlpWbVRvVkx6NGNzcjdNdis0?=
 =?utf-8?B?R29SdE16OWRmTktvdENTSE16VlZLeGJtZUlPaVNQTmdjRHZRaFVKWExWSVJk?=
 =?utf-8?B?U0dZMWZMSCtDb1hEVFVoODA5QXVTc3NTN1F0UmxCYk8xSmxtUVJ0SktxUkxZ?=
 =?utf-8?B?SGlBZThHUER3ZkFSbE5iNjhvalVrQUFCVDhtNXZaNWU1N1IxT2ZjZ0VyNEpt?=
 =?utf-8?B?SVpiaEhNem04bk01M1VGQS9yWU5RbWlsNCt5NXJub1JKcGdIcjZnTXpCNVJh?=
 =?utf-8?B?V1o1ZklnWmJGWkx1bkpaU2Z2UzdJNWdyMGlCS0pUL3NaM251SEpZRU8ramlJ?=
 =?utf-8?B?NGxMb1ZvY0F5OXo1cnh0MDJBcVZMZzkva05pT3Y5Q2NVOWg2Rnh3ck4vd01n?=
 =?utf-8?B?RW9qVSt4aFNZSGxpWm5NMXd3T2ZMQlc3ajMvVGU2aDZEMEpYcXBnUTE0RGk3?=
 =?utf-8?B?MWdwcExtVnNTalRHQmxtNGxCenI1UzdPbGR5aUZaM0pNTkdtUHdEY0RKUWpM?=
 =?utf-8?B?MWNQZjhJWndUREpTRS8wbGpYQXpzNlc0MEUybkJjakJrVHpvQmlXa2VhNVQ2?=
 =?utf-8?B?VUR0U3RsQWlQSy96Nm1nNXhIWEkrbktsMHRhdnF2cXViQk4xbWxsMUFwQkNO?=
 =?utf-8?B?OGtWWU5TMVYzQ3dwSUN3ZjV3bmdFZDJqR2YzZGQxSFhsZkl6NWp2YXlkR2sx?=
 =?utf-8?B?OHErTjhzT3haaUI3RUY0TnZmcTArandQUERQQWc4Y0taZU9IWWRZT1dJV1l4?=
 =?utf-8?B?MkdXNXdsRTFFMXlIamovQU1RcGZEa3kvYVpkcjhFUXhzSFZha0hkdk5kMnBC?=
 =?utf-8?B?a2RiaW1WR3h0aHRINndmekZWN1BaZ0FwK2dIeENVSmw3bzlZWENKSWxXRXA1?=
 =?utf-8?B?djlXWXFPZUJ1dkxkMzJ0aE9WZzF3UGtnSFI5L25weFE5YzVvNUtmd3B5eFJT?=
 =?utf-8?B?VHFyVmtDMk11VUZHNXlTT1dHNDVFQWVHYi9mRWJjYlBZc0doQlo4dWVFbUVC?=
 =?utf-8?B?Z2dPZDBSbm5HUWdLRkVwaHhRejB5cklod0ozazJFQ0NEeEdxclFQczZVYUdk?=
 =?utf-8?B?cFBpUUNjK2ZwQ1FtOW95YTIyd3pwejl5d3JuU2t4OXdFRHl1eloxOS9FSGJN?=
 =?utf-8?B?d212Q1hJUm0zREExcEZOdDZWM0drV2lEVGQ0WjE3NXdxZTBwMGNNb2E0WGFi?=
 =?utf-8?B?OGFZekhaeFBHQWNiTVhqenZzMU9zV3gwOEowNGZycFhuNi9QOVA4b2l4NTJu?=
 =?utf-8?B?N3grNUVRRHNHS3dUTS9DTG11ZlJ4RURuNXo5WE5kczh3RjQ0MlBaT1QrNmR2?=
 =?utf-8?B?bGJobi91Z0p4WVpwc1hLQ2I1OHJQMTVRZ2NacVJsSHMrTDFjbVNSMmxoQnJw?=
 =?utf-8?B?UVRKemlpclhSVlVvQnhVTms0aE5PMGs4S2d2cTBKVXU3QkNsbDFRS21HNmxC?=
 =?utf-8?B?dlJ3cXJtK0RRQ0djV0E3U3dNay9iK1ZrdDM2NWgyYUpNWHQ2bEhlNXdaV0pM?=
 =?utf-8?B?NU9UVzJaUVI0TWRNNnY3VmVpeitUM1JCdFJCT2Y0dTBGOUJnbHE5RXMvRmtI?=
 =?utf-8?B?MnEyWWVhZjR2M1BkdTg1M3pCeWlqZGpzVWhCanBoLzg1NlhuUzY5Nnc1QWRG?=
 =?utf-8?B?UmxWLzdtKytvdGh4N1NjZURxcWFYOFBXUWZERWkzUzRsOFJXeThncHRnYVIy?=
 =?utf-8?B?V2xtTnBSelV1MVZBQXVLOWxXcUd3K0RBT2UrQ0cxSUxoTndhM29MeW8va2Q5?=
 =?utf-8?B?cHlLWFNveW5VV1hZZ3p5dTZrSkowbEpnOUtQVTdPbVZIbmxKTTZwSGQ5U3J5?=
 =?utf-8?B?YW1CbHhCZHRuL1hPZlRyby9mTlNQZ01LT3N2N3VHcW5RTWVJQ0RUbXNkcEl0?=
 =?utf-8?B?RXFlNklSZm50cDNXN2I4L1M3emtoMUtRbDdmSC83VktBSlVxb3ZnY1dNQjZ4?=
 =?utf-8?B?VmJPMm1JNjUxbFBuZXViM3RlUHZUQ2t5N00zbTdzSVp1NWRzZ09FZnBrSmR5?=
 =?utf-8?Q?tw5dsnmHbFJnM9cXdEmMLuYri?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892d1deb-1ba5-4708-3863-08ddce91d605
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:19:51.4658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAsd5gXbru7MKLSeg0BqIQc2PMeYsmfTIpIT6wmmSTI7P28jfMDZcvmrHl8iDxdt0OH0sqe0w68zojKBgXmJ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10648
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

From: Frank Li <Frank.Li@nxp.com>

After update this, uuu(>1.6) can use below command to filter out devices
when multi boards connected.

uuu -ms <serial#> ...
[sudo] uuu -lsusb can list known devices with serial# informaiton.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/spl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 4a86d8698b4..24a8cf167d1 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -21,6 +21,8 @@
 #include <g_dnl.h>
 #include <linux/libfdt.h>
 #include <memalign.h>
+#include <asm/setup.h>
+#include <asm/bootm.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -184,6 +186,14 @@ u32 spl_boot_device(void)
 #ifdef CONFIG_SPL_USB_GADGET
 int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
 {
+#ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
+	struct tag_serialnr serialnr;
+	char serial_string[0x21] = {0};
+
+	get_board_serial(&serialnr);
+	snprintf(serial_string, sizeof(serial_string), "%08x%08x", serialnr.high, serialnr.low);
+	g_dnl_set_serialnumber(serial_string);
+#endif
 	put_unaligned(0x0151, &dev->idProduct);
 
 	return 0;

-- 
2.43.0

