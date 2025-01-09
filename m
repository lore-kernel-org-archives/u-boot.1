Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9513DE77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9188070D;
	Thu,  9 Jan 2025 03:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Py01yPxr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59ABC80704; Thu,  9 Jan 2025 03:23:54 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B624080702
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EE6uiKlzkncJi1p9cP2obw9TPl0Gmv5vo9bT0z/jFQuNrDOlaV9T8k+syqT9j/nwEsleDFbbBn4DeLhJ5np/d3bIa48DgwYtn6VctyxolNAVhfSdXxDkfPlF8UDycyrnluK9nvTLxCcyTFoySkOol+vnCFXU5g5MCgqMs+0zoLZQ/NkpNkMOCVZu34fvcMNlgEbE+LePYbmr+rhuJzEhVcCSeT5o2nnru5cWuFE0erzELye03w6ftF2KuyRTmDljh/cgowJgYI1xF/BA62z59L4z3lu9bblcLq53lByHT4axWl/qXzqFRaYvmOuLEU5Wlxpg/BR285rpHBlV9MqDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4w+OqxF6dkU5TnaaRwxp1+xu6Oer2EsNUhqanQ6Cwc=;
 b=sy5cehrG1y7TbVVlS74EtLB6iT6xFGiH/deLvLDA4jZln4j+7tITZGvQjcVLEge3oS9T3AHwobT/TNmc5OysuX2QjrXFMNJfCOir7YBPHb7uOuGQITaQLtYJ3kPGGs5qQ8y1ErxX0zp/lt5sUe48ZKDOmKP+l2PRiPRRBQSHjEVZePCJXfhpUOmLG18XYfdwzT8GH9+eTTBmmPeT9/u9ne+lIArpZKgtxVKBYcEFw0Xg71NLxm8KGbgW1eP4HlSjzz2s4nuWJHnL9fCoXCzkxI/1TFg4EY9rMmdyJcEmchj1kUYsX8JepfMr9J7N2NKJt+f7XQklyQ1qw7a6EMkBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4w+OqxF6dkU5TnaaRwxp1+xu6Oer2EsNUhqanQ6Cwc=;
 b=Py01yPxrsNCcTdCHDPEZrMRW5QRtrN4ruVVcgwWxPuy4afjbyxbaQ8PdE15IvrFKo5hOPbUe7kGpFypIKJpCPxA2BEs3JHeChuDkcPLtTdjX3qA1ydhJUhDZeqhxNaD3yNkb2f8gJ0DXJKsUAkzgkaKeXXpNEKN2EjJ+Zq4QbRL6/18ONpf73Ut/dnoX1788RlBjGL3Qm9abcfNLWFvz55Z7F6vpU0QrNE9GyBmAy/YWizHZO0GEn3e5QB80JhnYlw/lgT5R2Qf/J2l6dE3SJTTiBGDtkqwVPOpjdPGpwgJJP2Nixp5d3bjn+wyy4v101BcgNc2XJIjFzxrmPCF0GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:47 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:17 +0800
Subject: [PATCH v3 16/17] imx: imx93-11x11-evk: drop duplicated nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-16-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4615d65b-4acc-401c-ed63-08dd3054a5c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzRPd3JrWlpJcEJNREZuZ1ExN015Ymw0aUV2N2EwNDZwcTR0UHRSeUx3NExT?=
 =?utf-8?B?UTIrbUNqTm1obmhRazdTaHMrUVpZczBUTFljbEljdGtVY01Pa2tOSE9YQ0VG?=
 =?utf-8?B?a2tiYk1pMVkyN2Z2RkZDamh4MHFCdGdDcG5rUE8vLy9SWDArSWhpUWRvMisy?=
 =?utf-8?B?YmtjbjB2a011RXNNclVVQ01kaFpMKzhXYWV0RW9sSUpPZERrLzVNZjk2Y0I3?=
 =?utf-8?B?OXplY1hMZzloVFJiKzQ1Wm1jcXNEZlJYZWdCcFVNNWV4SlJXVGtpMXR0cmZU?=
 =?utf-8?B?VGJvMTd3b1FSZHRjVUtHNGZlaVJPUzBZQXlTOEcxS2ZNMUhuNlFMQTcvWmdY?=
 =?utf-8?B?cCsrRDF4elZobkppdUdBRjRpbmJsamVhazBaNUNyemtJTkxxTVlxMWsreUdr?=
 =?utf-8?B?cmNyRzErcGhFcXpzVkI0K1BpN21VY2xnSVJnWjR4N1V4UDl2U3Y4bXJEaVo4?=
 =?utf-8?B?WFdJUC9NL3RNM3lBTGF1cTl5eXZ6SUc4a2VLNFlMbnpVb1M5UnlDZjJudEZW?=
 =?utf-8?B?Zml3cFVZRVl5RDZNTzgzckJ6WG1GOE5YaE9WVlJGMDdlRVphT2I3bHNEMCtR?=
 =?utf-8?B?N1hrbGxFWTBPbG9XbkpFVUlwNFFBMkxnSE9WYXFUZ3lYVndJK083OWJGWUxP?=
 =?utf-8?B?L1k0MWZnTllnRTZpVis3WVYwcWJnODd5cFFWUmU1SFB0Vm8xUmtTdGhua0RX?=
 =?utf-8?B?b3liRTlqdTJqZnpoWGxFazExSEFTaXpGSzRkSVdjT20zWklOeGU1ejNSRHY0?=
 =?utf-8?B?ZCs4QW5DNzNWaTFIb01tclQxR1lnZGdsMU5DdGlqRmRTaVZOWkpxZ3Y3Ri9U?=
 =?utf-8?B?aUVLbkljN0FPUTFiWHcwdUJsYkZudE1lYUZaOTRuOWNlckFBUy83d2ZqSjlI?=
 =?utf-8?B?M3Z4QTFvbjE5cythaUxiOXMzbXAvUUtUUGRkNmkxMTU4Qnl5SnpKRlU3bmNp?=
 =?utf-8?B?a0phU3FLT29jb1R0UjVVS2s5dHErMXdYN0w2R21keHozcm43NVRPMnFUQ00r?=
 =?utf-8?B?anBzNkltUzBVWXRsK1Bld25neTFzQVhMUm1WanRCaEV0MDQ2bWNqbDl6RVZz?=
 =?utf-8?B?aFdCQXhDY1pyOEZva3JrU2Jod0F6empWcC92OEdwYXdTZDZzbkFkcXpLdjFx?=
 =?utf-8?B?MVdoczFINUxQcTJvTllaT2RYRVF5dTVlQTVEV0Q5VHUrUVlSb3lVK3R4SVc0?=
 =?utf-8?B?amR0TFdYZm9Za3NyclZvLzhyNkh6V2lhUnB5ODc5OHp5aWlqTjJ1dlFPbUtP?=
 =?utf-8?B?UVBaYzZTS3lQZnJpRVE3U0FVY2FmNW16RFBBUGhBQklPM2haS2ExWDRaQzZT?=
 =?utf-8?B?M2U0VFQvK25BZ2FaMklCQ3FsTktwTGNRUUZMVUhOWjZmbk5Gb25VWEpOSWFQ?=
 =?utf-8?B?WlVGUHhLQnRBSWcweXlrNHdkcmxvM3AvWDV3QjIwbWZBaGluTkVjc2o5S1NW?=
 =?utf-8?B?UHByU29MbHRVdkFOeGVDRDRuQ0JrcGxITHJFT3JxYVVPUHg2V0c3M2t1MTNH?=
 =?utf-8?B?a0ExZ3dqaDdUQmI3cGhoUm5PdzROR3JsZ2dHdGFUcU05am5QMzNlVGRpdlhB?=
 =?utf-8?B?MktQTC91Sjl1eUk1VGlOVVQraVlacVpUOE9SZmRNOUQzWVZ6bzdQNDR4NGR2?=
 =?utf-8?B?ejJZd2g0cWg0MktrTDBlRHBCeUVTcnZzY3ZnKzZXQUtBOTRHcXpyUFZKNGdj?=
 =?utf-8?B?SkRHbHZHRzR5L0Jrc0dSUGp0OFFyUWxiQjJlNTlVTXA0aXM3ckczTXR2QnVw?=
 =?utf-8?B?OGVUMmpOMGEyVHIyT2hoTVlzR2hkNEpzNU1FZDFqSnFzaFVseGl3MytiS2My?=
 =?utf-8?B?ZTFPVWZSTS8vYkYxcWJsNjJWbk80OWlHWEhtSVMyUHBaNVA4bExtRGlPVkZ5?=
 =?utf-8?B?UUFNUXdYTjl2VUtnTkkvR2R6akdGc2JBcnpkN1F5MEljWlhBYW5Ib0dlMVdR?=
 =?utf-8?Q?AIb+wPZvePP0XJC8As4DQYAYZLaYKA8z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekNzYnBIV1E4RG5uRzcvUE5qZU4zOGhEcEtZTTFIRnh1SVZaTlZkQkpSUURQ?=
 =?utf-8?B?SUFPZmJrblVLMk8yS2RwR1owNHk5TnBqS1RPVWUyVDJDOHFtUTltNDBRNGFu?=
 =?utf-8?B?NlMvYkxOVUFESUVreUFXZEQzdGtXai9hL0VzbktwMWRVc3VTcm1OckkzeXVV?=
 =?utf-8?B?RzUrWkVzRzEzNnIvU3ZTUE5kOVFkM2V2UFFKSG1UV0I0TDczM1B5MTJlZkNM?=
 =?utf-8?B?a2FCc1paZmhPQjJrZXhHZXlRajVpWVJVNmZ4dEVBVTlmQzRhM20zdjNnalRM?=
 =?utf-8?B?NCtQT0xzNHNlOWs0UHlZSWk4UUhnS21lTGVIWTBjZUtrSXBHOU9oQ01sQlJ1?=
 =?utf-8?B?djJrWGlxdXpXQjhnYlNJQXZhSUFDQ3FRMUlkRk9sNDF0K0NzcGZONUgzcWVS?=
 =?utf-8?B?SmZLcjJrTEwvODNFYzBLeWZHRWt1Vis0b0FEZmtFV2ZhaDZQQVdGejA2Tzl6?=
 =?utf-8?B?aG1qd29lbmI2V3BBeVoxdWpFNExjektONEdoV1VZbmlEdzRUSkg0RGhOeFV6?=
 =?utf-8?B?ZndXWUJpcWhDMVZLbEtQQWpRN2FxNHdqSmIrMmJ3R0tQOWo2OHhTN1NOSk5u?=
 =?utf-8?B?NkVTa3hHNVl6aEZHbE9qaWpSR0tLME9SQnNyWnJsaXNZdnJkY01OVDA3Skhr?=
 =?utf-8?B?Vmk1MjNwaktkRVcycHEyTTVKUGhGU3N0WEoxTTBKVkVMQmhTdXkrN1FhdDRP?=
 =?utf-8?B?SW1nak8rSXEzT21VN2UzMm9aWFMrTjNMMG9iNnFGWHYvUEZNaEhLazZITFhN?=
 =?utf-8?B?U2Q2VXdtZStiRk5ybklUQjNUQzRsc3hzUmJIZlRpSXhpeitzRkVTRFdrd3ZC?=
 =?utf-8?B?UFVYbnhlanBQdmRtNUJMUkRLdGI2Y3BIUTYxKytGbEgrczNVTGtXVDUxMERt?=
 =?utf-8?B?MmVzVnljK3dMYW04dVMremNNSDdwd0Z1OXE4YUh5L3pNZUx5SC9sdi9JUWxo?=
 =?utf-8?B?VjJ3UU5aOEdVVGdTWW5waHBhMHc0STA3aUVPSkZ2L2Jpamo2aTVERVFDZExn?=
 =?utf-8?B?eW9SaFg2bVBBWmd5TzNYbFo5V2R1VTd6VFhxVHYwVjRrakxZYzRtQ25jNDQ1?=
 =?utf-8?B?SXhzQTc4em5WUXFUaU1ya25jdVpuaVNHZUVuVk15b1hsWHBlb01GZEFucFY5?=
 =?utf-8?B?VVpuaWhOeTdMM0VNNDFTTktwcHUzdTBHVFlSRWFPQUNNMnRBamtqZk5zTFZ5?=
 =?utf-8?B?UkxzemZjakYwMzRHNGZscUlkbGZjTkFsRGJRQU1UMkpGazFwQldjcWRQUmFR?=
 =?utf-8?B?dFZ0cFIySDNKVXd4SzQyaCsxUkNCaEc4bzg3M204d0wxbDBiaHdWdEk0dmo3?=
 =?utf-8?B?THlMdTJXcEMxZjBNVHVXdWM4b1A3aDk2bzdCc2Rha2cyK3l1SmpyM2hDSWtE?=
 =?utf-8?B?NE9MY0E2YXZReWtWdXFBdlNuWFJSd09yaGFBcEcvZ0hIWDhlb1kxMmxXbmRT?=
 =?utf-8?B?c21BRnFvV3pPbU1BZy9mbEFjS3duYW1jc3QrR2VjZmo1clMwM3d1ei8wdjdG?=
 =?utf-8?B?Yzk1WTI2bk5BcEpuUVpxaGhUWkxsNGZqMEJaeWhwSGp0VEpDUGI1RVdBZTJ0?=
 =?utf-8?B?eE9mS0ZLdlg2SU5jU1pXR0VzRWNZdWJhbVZzSWgvdklvZlJOc2tOalp4UGVG?=
 =?utf-8?B?RG85Q0FqajBRSmYzM1g0QVJQQ01iazFBUWRLK1Z2WWNDK1ZvWllYN3IvT09X?=
 =?utf-8?B?b3V4c3JUK0pPRG1vQkdmUzBGelY0OEwrekg0QVJ3Z0JJVlR2UkZjbGRwRGU3?=
 =?utf-8?B?TVBqbzE2ZFNsUitqVm9iY0VjU2psekd3aVVveG5SRjhMam0yTFp5bU1xUmZh?=
 =?utf-8?B?NjZRYTdDdW1ZSXFidXNIcEJONU5WMEd4M0w4cHAxK3Q4RjJWQXEvQmlqcFRE?=
 =?utf-8?B?UVh1enpMeXBTdjk1QXVMOXV5RVlXa0VzNm9qbnAzK1BVU1pyRHQ5Zlo4YXFJ?=
 =?utf-8?B?Z0grYlZibnNnUEZXY3ZzNmZkNXB1cnZnSGc4SHRPSnlBbUJGZTA2aDJ5NWh5?=
 =?utf-8?B?REN2cDRJNDhuNGNjRFk2ZVo4RVRleWRFMnZPZGtKbGQzQmlnd3oza3BuZG5Z?=
 =?utf-8?B?dXArTm04RENVUTFaRGQwYkFzTERrbTFZUkJKWkl4WjVZVHUvREM3dVB3RHY4?=
 =?utf-8?Q?MzzAXeULslw/8QHB6wZrvyu9+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4615d65b-4acc-401c-ed63-08dd3054a5c1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:47.4330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Az8QhtSeJNDS1gABFVrvZ94XFVK2BkhXxb3ap8r3OxDGGPnCJzxh2kuH2J2jI8Xlty89vfm7X5zIncjefui1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

The upstream dts already has the lpi2c2 subnodes, so drop the duplicated
ones in u-boot dtsi.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx93-11x11-evk-u-boot.dtsi | 118 -------------------------------
 1 file changed, 118 deletions(-)

diff --git a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
index 408e601bc90eb69744ce1198498e01b12f814ca9..a99ba99bfb4f2c08752472536f2450c8e79fb87e 100644
--- a/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx93-11x11-evk-u-boot.dtsi
@@ -26,111 +26,6 @@
 	bootph-pre-ram;
 };
 
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2>;
-	status = "okay";
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <650000>;
-				regulator-max-microvolt = <2237500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	adp5585gpio: gpio@34 {
-		compatible = "adp5585";
-		reg = <0x34>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
-
 &aips1 {
 	bootph-pre-ram;
 	bootph-all;
@@ -149,19 +44,6 @@
 &iomuxc {
 	bootph-pre-ram;
 	bootph-some-ram;
-
-	pinctrl_lpi2c2: lpi2c2grp {
-		fsl,pins = <
-			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
-			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
-		>;
-	};
-
-	pinctrl_pcal6524: pcal6524grp {
-		fsl,pins = <
-			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-		>;
-	};
 };
 
 &reg_usdhc2_vmmc {

-- 
2.35.3

