Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A17C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6FC680780;
	Wed, 15 Jan 2025 14:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V2ZKJj5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C8580757; Wed, 15 Jan 2025 14:29:52 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 733C280703
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYZRTDb3kpmKbEL3f+rsI+Qs2iOMft7btQStLKnU/NOyILvWUoEVd77F+WsCEbjdmyhg++aw5uYzvWuu0S2OGE9hv9ULNYgPv2ySuyOrnzfH4Eyz3rxlkFjs3BjZ87k0XCSEybQQ/dZx6ElwbsPvLU6De1jUuXtV1FHxQuzN6404T2h4S2Occ3f0KQady32mzDZhAabABw77Srdkk8xj7IeD0rx0cMnIls/0F1FAURdoFoFOlDwHq5VFgwGpLlTAgFntEhJbQZ3BOxtvWbD0VLNfk6TEQ37U/bYuR4YtrKrDOlrJApm/Fts0FvONX/mnMH0FBmNUsu7N0ZNykQXxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+SshC//O2KgQppU+e/3G5MR+J3uebQ5bSQk9mMigR4=;
 b=JeLSSMoGLJyn0sb4ol2daE3bXLpcxatgcTxMPlHgBeJOHw4urpq8bgDXWm24dPieoFq7nCQemijkfrHROFcC5lZ6r9e+cVB9yIKdAK7hEmu9QB/ZBsS1/YLhJxGC2jrVUfSxZvW+SDRbFAOVN0QHhwPf6UCBQQ/51zTohQxb89lkSko0ITkV0mhbLjUFuEYpM7EmsjpvHtXOC3PHlDGxIsOuIu5/iQMhrjpyz3TW3dIlf/3ybu1uka1VoOwECI/JYg/0f5Yyv6JCP1rpObxrdeLUBGd0KuATSI07EHAJhWE5r0AZqxWATKFWVwIUXdhTS8kGiY9bfzZE2PKgDcsDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+SshC//O2KgQppU+e/3G5MR+J3uebQ5bSQk9mMigR4=;
 b=V2ZKJj5iUSguc29E7P+jiASI3D4yT/wouHWHa7upTRTcYAtmheWDcnWNCu/5GvkNzGN4zzWLp/JZ61N81psDJfpMJBDuUS0YfUec7EPMjE5/6j6vo0JOlfDrZ542RTOl8EjrMPfnqZMAGt/dTLHd5s2zGT/jHV7nfgYoitjg/eRl83zfRLKN10TxZ751PMpuce+cLI0X6biTHTv/3PoIlyB3Xtu9KFlpdVj6wkdXBGcQXph7cFEVNwH8kiWvU5uED2cr4eHbfgjt7vLbnNRjywcIh+MoR4gLp7UfLyUO51GsKDZmi9cDMuzMnmECcBMyxk2Jr0z6u77jtIggDVsCHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:49 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:49 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:57 +0800
Subject: [PATCH v4 10/20] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-10-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=1122;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=HRRzAfMPwiG7DveKXwQ+yoWXXYk1m3p+yIzjFi+h25Y=;
 b=TyEND6+p9QM2l2XecRZw6MNNUX7VG0Oa5qcXHSfT7sfRg1+6mmOyADYvtE68SxkgGu0tEJKNn
 9kv+bZychHGDlMiquTlyqL6YKxIvvpVsO5q78zz0uaetf0RT1BInDUu
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: f1babf28-dbcf-4592-187a-08dd3568af3f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG5aL1c4Y1p0QUtBUXFldXVFdllsWCtNM1FUUjdJRE1WTDJJWmRXMkE0RjVI?=
 =?utf-8?B?WFExZlMrK3ZwQVk4ZVB3SnN2Q1orRmFjbVFRWEltWGkzeWtKaW8xWXdMZEpp?=
 =?utf-8?B?THpIZmJvSmxCRFJPa0UrbVpYM3JnN1p3eS9iSmJOQys3eUd3OFFzV3N0UVJo?=
 =?utf-8?B?Qi93cnZmaVZpeHhNdk42Sit0dnFjUUc5d1BkdFM3WXhYendydEdWWXBUcVkz?=
 =?utf-8?B?M2p2aVN1cXBoQm1odjhOeVhHU0ttaG1rd1VWbUpGUkJUU1JBS05tZUhtTGFY?=
 =?utf-8?B?Z0FkUVhSMkdiNU1vbVNVSHFIcXVrSDF1eEZsSGVEbDZBOE53MWo1WUJQQVNE?=
 =?utf-8?B?anJxbU1ZZlpIWDQzZmw3dmtEY2ttSlZNZjBDbytZbWpvNzRDd29wR3Q4MkFm?=
 =?utf-8?B?bktxenF0NjJPOGI0dFFtc05Wd2w5TlR2eFo1UlpWWU5lbWRLcng3bjcxK0hE?=
 =?utf-8?B?ZjJJWUF5dEI0RllCZUR4ek9pSjNUOSs1Ungvd1RpWEx6dFJNZHNuWUxuamg1?=
 =?utf-8?B?c2dqMlFoQVNGUHg4dFk3STV0dG9TWWw2VjdEejdZRTAzOHF0OXpvaWVCVjFs?=
 =?utf-8?B?YVRMcmcvRDNXV2kyREFYcE42THdBU3dmZklwZU01bmRBUEt4anVTU0I2RHdE?=
 =?utf-8?B?UGlRWThRZFBiRUgrRWFVTHBBOEsrMVQ0VFZCQjhZZ0pSdWlob091RVhNM2ht?=
 =?utf-8?B?eWJRdjFFT0F1dlY3a1lETnp0S1o4aU5kRm8rbk5EZEZpY1R5RkJQUHV3N2hO?=
 =?utf-8?B?blViVE1rMnd3NEFSeW5HN3F0ODlxNFdJZEdqRGVTY25OUm9jMEhhSXhFdHhH?=
 =?utf-8?B?RithOTF6TEhoUFNzbGkwd3hWTFNwQnlwVHdDMzcraDBnWTcvbExJYVFObU96?=
 =?utf-8?B?azZsNEY0NHhMQk1mbzh6NitTV2xmSWc2NTY2R2tOSlpHNE52UWhtdlVLaE8x?=
 =?utf-8?B?cU9FMlF3MGlRZlVORXdSUzZMS245bkRxUCtveG9WTDByWFVUd1JrdFBOTXNM?=
 =?utf-8?B?bWFrWVhKOE43YnNmU0EyM1RFdmxSZHZhd1FjemF3VWR0Z3pXRkF5Y0tqYTlM?=
 =?utf-8?B?QjFZWW0xVWxlYW42aGhYbVBLZ1p3ZnEyZlpaSFZYb2E2cWJvZ2tqKy9SNWxW?=
 =?utf-8?B?VjBEcU5peHAvSW8yMWo4YTgxaDRJcmdleWdBTmFYMFdYVDJwWGZGUXozK0lE?=
 =?utf-8?B?dVdFVDl6ZE4yR1NnUUVwREpzRXVSbkNrMFVaSldaUmtKb3pSQ3VXMHVmOG5F?=
 =?utf-8?B?VlJmaEVZQUh0QWtQa3hXUTBHbGM2ZUUzTHRFRzNESmtySHBwc250dXlHZG92?=
 =?utf-8?B?WUZJRVdFSVBHalZxWUFaNk9iZzdObVJJKzRLMXdJdEhLV0Z4RVNpKzRWYTZF?=
 =?utf-8?B?TFlUaS9PTlZNZjVmemdUQUc3bXRVeExFbHBLeVlKT2N0U0RiR0JUUTBSQ3Fu?=
 =?utf-8?B?T2o5UlhRMWFZY1crQ3kvV3k2cUZON1R0dzljUnJFQVFSRUdFRVFobGNyTHpQ?=
 =?utf-8?B?bHptYzFoNERIdDE0dTZzdFZ5OXZZUzdLUXBaQnpReVhFNUVEUzQvaE15NVpr?=
 =?utf-8?B?dng5N1UwaGhVS2RQbmI0ajNpOXhrcnNiamJIRUZuZ3BFeFJIbHBmbWJUeSs5?=
 =?utf-8?B?SERHSGUyeVUwY0UvNi9PUCsrc1BsZ1M0YWNRS2FYSWlnK2kvREFORDdGZHc4?=
 =?utf-8?B?WFJ4YzM3bGxoa0kyZVBvOGRuZmtCS2ZFOHJKWi94TjRUZzg1NjZOdW5CYmJN?=
 =?utf-8?B?TE0wZkd5cWpkT2JoYUpVbnp1YUVhMVBnT0x2WHNTbnFIcUo4UzFwNFlJYkZ3?=
 =?utf-8?B?N0xLdVEvU3FHcjJQQmM3VjF0ZTg1bUVobGgyUVhpT28vcCsyQmpxMk1RVkFt?=
 =?utf-8?B?QWU3T1piRzZhT3FNY3lHNjlCcTRZZ3RMNlI3cUNrNGxkMzRsQk5KTXovYmNO?=
 =?utf-8?Q?pIFxJJ8A39ZE2AHMAiGrkUOydAH8Ibof?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjErYTIwSVFMT3I2M1Qyd0w2OTJPMXMwT3RMeXlBUkNnOWtSYVFodHdCNGYr?=
 =?utf-8?B?NXMrcWFPcEl6TUtUR1JoVUd6RzMydFdPZXZpOUNOYWhIUTdpR25icGREN1cw?=
 =?utf-8?B?aytuY0k5TXZvTW5KVWRqUlpjUXIrdjVjYllrbU00Z0EwVFdZZTQrVzFYRlkw?=
 =?utf-8?B?eXJWbFpPb2NFQndYMVo0NGFoVVRhL2g2SXduRXdkR21Ib3JmVVhLUlJDRklB?=
 =?utf-8?B?cFVnSlpvVE5CWUkzMGZ1M3E1ekVaT2FKMHlaSEtUQkNNcGJ0cXNuaUxzekZ2?=
 =?utf-8?B?ODlNOHYrQm1IMEVPSlgyLy9RMTkvcWFiQjQwaXhHNmlOU2wzb3lCTWU3b0lG?=
 =?utf-8?B?bTdkTU5LajdITVhVNXFZaWR3cXhWOENxUWpGd1c3ekRiYW41NU43K1VGNkZB?=
 =?utf-8?B?UGQ0RDBzQWQ3dmtOMFlJOENoU2JXaFZSQ1FURHNWRSs4VGlrMVBGMzNONjkw?=
 =?utf-8?B?RVpxL2tjTUVINlp4bkVBZDdRbmtXWFFjc2ZrZWpTOHNSS3ZPNjJBeTYyRnB5?=
 =?utf-8?B?MU1tbzB4WXlpd2lyczVsaTZWdU9sa1pYUnFWc01PaG5EcGZzNUtBYWlSekF2?=
 =?utf-8?B?ZFFpVDNzbVpsL0JuUEVGd09SV2hBRHp3L2xYYXFYTldNSXAxMXdQZTRpeFly?=
 =?utf-8?B?R1lYbEVJSXBTSzIxcFBzak8wMHg0KzdNeU5WeVl0bzNBUDNyUmV2bGpqUXM2?=
 =?utf-8?B?S21QOElNTlJXamgvWjZrYWxnbHVnWFdJTzBQdWFiZjM2RjhQeVY2UWI4Q0dj?=
 =?utf-8?B?NXNFemZiQ1ZjUXRkL3pLWWRtKzd1US9pNVBHYTVhUEhRakJKRTVpRHUycVFE?=
 =?utf-8?B?eWZXeDFDL2M0YXBRNGlUdmpHcjhLSWFieXFWV3FYQS9PUm40WWN1M21nc3RK?=
 =?utf-8?B?WjZNc1lWKy9pQWxKSDVrNVhlTDNwYW5ybi9QczZPRDN1VW1BL1E1QUY5QS8v?=
 =?utf-8?B?Yk9Kc2lFU0ZKNjRxMEtvSzBnZkVQMU1IZU5xMW16WGh6Rk9qMHpYVU15d21B?=
 =?utf-8?B?Y29Wd25QNTVwakRON0pFSm9mZzVTTDZIZmh0RjlXR0FXbUpaTXU1aitPMWNu?=
 =?utf-8?B?RE1qL3laRGZvYzdmMjlielZGVUQ1WlJkdHJVTEhKSUxPR1lwdGtGU0RSWTJl?=
 =?utf-8?B?VXRzVXl4OEI0dzN2Sm5wQVVVZzljSzFzZml3b2pTek1YVlpFc2VMVk1lM0tj?=
 =?utf-8?B?MnY0Ymh5bTFrWmNpc29hakUyc2JuR2U1V3FHSUJKV21rYUdBZEc4L25FY1Jw?=
 =?utf-8?B?NVJSdEl2ZFFJczlLZmJyR24vbUlWNlIwZ2oxMityTGtpT0xKNkVxWXRWTEJv?=
 =?utf-8?B?ZEYydkZTOXh1QWpSdWY2dCs3OVRWMldBQWpqRzdhOEh5NGFxNlpHdEthcVJr?=
 =?utf-8?B?bkI1OG5qUlRHYjVQOXljb2c4Z3ljR1VJa3B4OTBCTlBoTTE3RkVyMXVrWGtw?=
 =?utf-8?B?VnFKVFMrMzBHTncwMFA3L3ZJbGxyMUY2MXRteHNiaXk4MzBXeUc3K1R6S3Br?=
 =?utf-8?B?dkJzNGtLUEtDcUpVaGVmd1V4NzBJY3FjL0dmcmJjdWxRZkxUWVBmUTRaSEJw?=
 =?utf-8?B?ckozK3RSU0w1OXYwckNrUUN3SUZuUWF0UVpKWDIycWo5amhnMldBNGpVMWR5?=
 =?utf-8?B?K1QvbmxuUEQwbkw0MWw1V1pTRUxPY3IvaUlNK2JyRmNyNjFodVdVZThnVTFB?=
 =?utf-8?B?a29rQk1LbnpNTStGaFFqaGN2Nlhpa2MzK3F4TnNKdUJtL1F6MzhLVmhYYWZM?=
 =?utf-8?B?Y2JsQUZsenNHSGQ4bi9qS1k4bUY1NW5pWWUxMDJ6RVNUVHU2Si9vUTRzTVZK?=
 =?utf-8?B?dytwajBqRHhUODhFSXAzMGVxckJ5YllkT3crY2VHNThzbUdtVmRpME5aRW1G?=
 =?utf-8?B?R2hoV1MzMUt5RDZYd003RlZ1eVd0UUlwY3VTZXcrdGdVVi9yM3VvN1g1bVR6?=
 =?utf-8?B?MlA2WU5HRzhPWXQzWFNMTGRJMTdRS2VZYUIvK3hRd3F2N0VKSUp2Zk1VVWdR?=
 =?utf-8?B?UUJCMFQ1OXZNRTJET3R1VFpCVndScFhCRVRsb3FlaGxxS2xFekU1ZzExclpO?=
 =?utf-8?B?QmhlSXRTdUVQeDhJMG1pV2hGcVV6eExFWDhEMjMva2JsQ0dVUHprK1VDNmho?=
 =?utf-8?Q?Jh9nEV5sJUePqxv0wgyzlUORY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1babf28-dbcf-4592-187a-08dd3568af3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:49.0505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEHzFBx84TIQ7OSuiSJY/h0f0WnM9l2JkiPDNpHF8ThrI+sGht1tuUmCEAbypt1UBhVsrHFinuIPrIbft30hGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. The number of elements of @protocols is
specified by callee-side. Currently, set it to 4 is enough for i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/scmi_protocols.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 9607433c3276f9aa18044c414a5bde3143726cf4..3c55d228cb641bc6c0e5ca7ac885efe84b41c66d 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -141,11 +141,14 @@ struct scmi_base_discover_impl_version_out {
  * @status:		SCMI command status
  * @num_protocols:	Number of SCMI protocols in @protocol
  * @protocols:		Array of packed SCMI protocol ID's
+ *
+ * The number of elements of @protocols is specified by callee-side. Currently,
+ * set it to 4 is enough for i.MX95.
  */
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[4];
 };
 
 /**

-- 
2.34.1

