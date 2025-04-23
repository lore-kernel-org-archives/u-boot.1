Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311D4C369D1
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4B281F6B;
	Wed, 23 Apr 2025 16:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tpSNVE+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB7B81E72; Wed, 23 Apr 2025 16:56:58 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F11B807AE
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX8ZxcfBNPeRPIZYtkE6wRgRoDWXzf1WKFSbgs2PL9SLWyCDA3fG67GWHgecuTqv9cQCJ99gyK9wI95RHVdZ9nwEfsBGxC0WXXWUA9MRFG87O5906rEYQwYIBUsHz7Ln8QicLHRv7ipX9gz/erGVpNbijFNbNNYqKVZ5+gtgcN8kdWorBHOE/5KlTdGHOaTYlepkIIkAidsam89ohOzNgCxTOR0YI6d3AQjsxirH7XMl30jEnLVRaTFhjgub506JwuVeWVXTtWJBzGCYWT9gp+SLvEXNBLT3jeeHiVIYTp0Sb8uLLFxYxTaVsSU8KZdurnpnrY75HnlM7KW3//QhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+XZ7CDrvAQ0Pd3ftRDxg4nq1xb0yFB9OW/vPr/hCio=;
 b=pgv8pa1y56fb6PnFAWI1UTfUtggpgSBMuzA+t19j71qqqiDRCFweeNj5aVYS4frKRtN81tNrnxWQkdktAMgsFmC5y069g4plE7qT24pkxsnXZHTh2IzUmKX1f8XTUjK9v1Ai8LYOeZ5zBgPpcsYrY3mDwJtYC1+pAX1bNkayiVx8tRYzAhB2tR570jRRKz3tx3T86qr75tGvqgLvcSKFVtnOpUlB/fo776XWVuB1aerezF+5RXVL1bYOI3jFh7yNr+tyxGCsEk5wVxmP7FMI0biZHSgUncuJYIKhEaifkSnIDeHgZjAsceBA/tdMB6T5CmngDmdkaGRHQSc1n/WdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+XZ7CDrvAQ0Pd3ftRDxg4nq1xb0yFB9OW/vPr/hCio=;
 b=tpSNVE+tpY4LOcnMHL3M1gCoR4xb0a2lBrVhMwXQ/YuyOAXJHHqHnoS/xjcsR+U2a3XOR5hIKeUgfRAq9in7P7WGhjMERalHWIHtEWAFSnlF1dw/k8ABGFhxKIh/PsqRM47inISIONpoitjl5RPXhlbpasXhux0hzVpw49SDCQ4pYkebTvy61inWLfeYIQwlmL3pyUJWNNUd9eZ3CcUZ0vRv7/ymMHAt1V1Q+tVZVPn0oxexsYSVPI8c39+81eEQpbfY2Kd3ki3ZYN+3o8s1s878A/sqx2JbzO6NdUOIRWi1UhtSai1g3nhq+GVI3myDE+5D67emgfzE5KjDwJTC4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 14:56:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 14:56:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] power: regulator: scmi: Move regulator subnode hack to
 scmi_regulator
Date: Thu, 24 Apr 2025 00:05:35 +0800
Message-Id: <174542428426.32054.14202485983657290388.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250322014444.174796-1-marex@denx.de>
References: <20250322014444.174796-1-marex@denx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: ec29926e-d4c3-4d59-13f3-08dd82771543
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzVudW10WnZTcm9sQTk4ZE1OZzNGakpyOWMrSEtDamVuWlFQQkxXS2lsWGJq?=
 =?utf-8?B?UDNpT0I0SzdzS2tySVRjOHRlc3JNMWE0bWhRMmxadzNueXRCOXZrcGJlQ2Qy?=
 =?utf-8?B?K1Z2KzNqejZMYm8wdHhnd1FGZGJ2S3EycnZ0RUVkRUU1UlRuY3pOelZnNCtN?=
 =?utf-8?B?dTRkVFU1TEhOb0oyS1lRK3c1SWI0bnYwYjNXMHFjMENyYzJ1bjhwdnc3eGxM?=
 =?utf-8?B?NEk2U1ZvOXVFYjIzaUw4WlB3MFh1a09LRXJKdGkxQWlDMUhHYnBvRTBydlFR?=
 =?utf-8?B?TG8xby9xSDg1ZDlzRXRvRVJEcncxZUZTOTN2bzlRenJnN2xLOFhmYS9MSXZK?=
 =?utf-8?B?U0pLQ1p6b0x6ZEMzOWVuZ2xsaEl0WnlidUd4KzRuMmM1MG9sT0hYYTNwQnRv?=
 =?utf-8?B?c3B2YWUrM2VQaEtGNm1rN1ErclZBRVBQekR4aytGTVVleFhYb1BHVE5OcEpP?=
 =?utf-8?B?d25NN0tZYVJINGE1THJEemRrN0RFekg5Y2xiTFRsaTZtK1lWWlFkQzVyQ3VZ?=
 =?utf-8?B?aWlwWWN1eHcyM2hpRnp6Lzk0T3poRDZteFBvTlNMUUlCTXphZitwVU5pVzRP?=
 =?utf-8?B?UWdkZFBqVTJoZFc2bjFHMExYUVhTaFZOSlhELy90VWc2bzBMTkQvME9BVXVp?=
 =?utf-8?B?K3N2QUJhaElIYXBSeE1EM0l2MGNKWlNIc1MybXhvUVVPN3pwZytnVHVWd2tP?=
 =?utf-8?B?L2NiTzVEL0xTNXNENDJBUlVhMW96YkdkVm05c0toTnJRWk9lSElDWUJWNXFr?=
 =?utf-8?B?QUZ3UkFHRjNBbmltVkFBRHVDZHh3Rkx2VGlUSW5RVTVQNnNnYmFrSTRWdkxl?=
 =?utf-8?B?djJUV0tSaGJVdG5MUFVuR0QrY2RuTHIvdE83b0JDTFhEUEh0OUxrKy9NQVhM?=
 =?utf-8?B?TWhKbXhJRWpWb2pjZkdxNlY2dmk0RDNSMDRpWGJDcTFqa2lQb0UyNXIvNEdw?=
 =?utf-8?B?SVdBMmxQZzZJL3FKNjhudWNuWm1XRkZUMmRZV0dKTU00b0xxd041UmhmV3k1?=
 =?utf-8?B?dUFLVmdqczFPTnpaYU9pcHFXRFpKM2d5WTA1VEttN2hUQ3VuT2RDUE9KbllD?=
 =?utf-8?B?aExRZVhTcnkrdlhXb1orYkw0Sit1QzJUQ3hTK0NTYVdDa0gyWDh2eUlWNUJU?=
 =?utf-8?B?QWhmUVZBd293cWdVN0xuM3NrQnFHeDZpc25SOXd4WEJYOVRXNTZxaVh3SG8y?=
 =?utf-8?B?enNIRnNUR0hkSHNuNGVZMThhSy8yR1ZPL1dkdFRleWYyUHlzT1lJajR6cEtN?=
 =?utf-8?B?SE5kS1pta2E2QWdyZjZqRGFmWEw2NmVTQ0xwZDN1OWhBckhFdjdWWmRZNUNm?=
 =?utf-8?B?KzVHWjBEVHdFd1p6aS91MXlGRVNPRFRPRm9Lc2lNeDVEbVZXcFkrektQMWlt?=
 =?utf-8?B?Vk5NTzRkZ3ZoTCsyM1lCTkFNZXpMSmFKYzA1d3VVQ0lFY0pmdVNDN3laWExN?=
 =?utf-8?B?RG9IUHpUdFAzZVgwMjduZkNITDhWZy8wKzZwUmhkZ0hRV1Iwc2phdzJGNjVa?=
 =?utf-8?B?L3F0aENzUStZMmp4QnBMWkVWeTZzdlh6bE1EOStiTDVFZGpRS2hFdnI4NEJK?=
 =?utf-8?B?TlkyQ0JzNEQ3bE0xMStYb05yY3ArVHhDSDJ1b2gwY0IxbENUTUlyMGJFZGNk?=
 =?utf-8?B?Ty9qVkZxTUwzOUZKaGQvREFLck9GbXRrMU5zY1NBYXNySnh1Z0p4TzEwNmt4?=
 =?utf-8?B?cXpBeFF1bFBhdWMvMkZkdFBxeWJvZ0xnRHFmeXVXT3NZV2xEcnF1dXNmaURG?=
 =?utf-8?B?SDZNUnFYZ0pMbGk1VGx6bVBLbkVFM04vTS9POTY4MXJpYWlheUl0YlhzaUR6?=
 =?utf-8?B?cDA0T0ptOE1obFBZdHVIcGw4Z2pKUloyR2VVaWI2aFYvczY0SW5GVHNpbE01?=
 =?utf-8?B?ZElNekRiWFFYTzhYMTZRaGJCamQyL2phR0o4cWZlK3ZvZC9MdWUzMVZPTGZy?=
 =?utf-8?B?WUV5QVlzUk8xbjhOQ2RINzBydjU3dDB1Q0lBa1hEd2dCMnlVc0MrN1g3VVBn?=
 =?utf-8?Q?jPk+kWeP/dy5uTZfL+BzQ0Fh/i8MEQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yy9uYVcyNnNvdFdJSmFEaEZqc0c5N2dFTlNDY1FUNnpJMUtlNUhwZEFBR1Ir?=
 =?utf-8?B?WEFNL1JtVEk2T1dZNHNzVktReUZTRHBLTTc1SGxnZ2syTDl4WVIyaTVRclJE?=
 =?utf-8?B?VUdJRFlsdVBxVXorakdZbGUvR214V08zWkIvYjhiQnF3NjBOY01CTFhqV1cr?=
 =?utf-8?B?UDlDMTFudkMxSXhLQVNRRGt3eE1mS25kTjl2cVBjeXRIQUcvTGpSL2laY2Ez?=
 =?utf-8?B?U2E1WDVNTFhZMjg5YUFjUU4rMnU1bUY3VTZBM3ZCUjZXZEp0UHdxc0lwVk8z?=
 =?utf-8?B?b0hrbkJuNi8zUlNOM3RoU0pMelVMNWt4NERHTnJwWkNRWnFqeUNZS2ZhaDdY?=
 =?utf-8?B?Zk14dUFHZFpYOTRnWXQrLzAzTkYrQnBiZFlzdkFzQkExM25nUGlsUU1DeVpQ?=
 =?utf-8?B?ODdPYjJEUE9FR3ZVUk85TkE5NDlWS2hqR2JJWGNOaGtTajhwRG92WnFDT0tt?=
 =?utf-8?B?UlErMXlWTVJlU2lBRWtYWHk1M3VhZE9YMXorcnJpd3pENEV4aWdqK1dWeG00?=
 =?utf-8?B?VmFFQjlyK1ZvcmFwVVAxZWhFVnVyUUczWVlOSklqT0xiTUp4Ymw4Z1FsUHhF?=
 =?utf-8?B?SnRZMmxoQUIwaHZCbXZnQXN6c3Rvbk1KaUpMdjR5SnY3cVcxdG14elozTW9n?=
 =?utf-8?B?R1JoQmgxcEc3OFlCM0NNL0VLY2dwOTdGdVIxR1g2K1ZocG8rSVU4ckc2bE5l?=
 =?utf-8?B?SytGc1VzTmNyUTJMbFhFT0FWRHdsRzQ2RnZVb0x6cjNud21WV0lWMmZvYnpY?=
 =?utf-8?B?c3RkR1hpMTFBaEs2NGh5elJ0aUdOVkl3NmltNzgxdTlLazNTSGM2N0R0WkVq?=
 =?utf-8?B?V2t4VjBNdFgvSUxKdFB5a1FMM2sxRVI1UjUybUdoYVR1b3piSlJqKzM1QTBh?=
 =?utf-8?B?cFBOQ0JJa2xQUC9GWlQ4VmRUWFZ2Q1BXUWlvMkFacGs1TW5DbTNGMVREam0x?=
 =?utf-8?B?ZEJVM3pDVWdvT3B5OVo0eTFvelFCb3lqN2x1dXg5Kzlsb2VLS3RYYnpvYUpn?=
 =?utf-8?B?LzRSOWgvRDNZL1pLVzZKRHR0TnFWMU90eW5KSlNrREIrVjFDREhEN1l1VlNt?=
 =?utf-8?B?YzhjSXBIdEtSZm5FdjNSZEVwVitwOFlCWUc0WXg3clB3dStmeEtiVC9pcHNn?=
 =?utf-8?B?ZWgxYUtHa05jT3lrN3ZqbDFwdExQY2ZIaG9aK09IVVI0Q1B1TkV4MjNXRSts?=
 =?utf-8?B?ckRxelYzeW1VR3J5TEliYkY2ZTJ6SExIek8wSTlFcHdvendTVi80bUViUjlr?=
 =?utf-8?B?c0NKNGoyMkJqNGo0SW8zVEZaNVdDQjZZcDdVcHpCMnJRTGYvWDcvWXdWREx0?=
 =?utf-8?B?UG90Ukx0ZU5XcHVPMlVXZzBYYTAwUU1UK3U4WUJXZ0t6eUhGYkgvUURyOUs2?=
 =?utf-8?B?by9SdkIxeTBUQXFjRGlVSFIzMm8vZ0VBbUthNm5QTE9LNWIrMmtnVk1GUHVv?=
 =?utf-8?B?MW5xODU3QWI0bUhCUTRteDNQQ3VTeGlVVGplQkVhaUVrV3ZRSTJsUXhsNHBW?=
 =?utf-8?B?OG8wL0RTWlBVY3JhNGo5NmdDLzgydERDME1xQ0hVc1ZZYlpXK1d3Mms3OTdn?=
 =?utf-8?B?WG0rRWQ0Vm82RGhzZ2hQQTF2SkUwRDFaa0d1bEFrOGNPZjE0YW1QTkFZNFM4?=
 =?utf-8?B?a1F4ZGU5OSs4SGtkaENUdEZBb1FwQ3FLNk1NVGlQWDlRRzQvN0xWeEJsY3dn?=
 =?utf-8?B?N0hlbW9vMEZpQjlNRHhUSHZSMGdtTHl3RmpzQllOQzlVNmMramVOSzk0ckFr?=
 =?utf-8?B?a2MvNG5SbnJQWGZMK0xmQytweWhOa0lzdk9PS0VHVWQ0VjZpOFI1WHNQUmk0?=
 =?utf-8?B?QXZoajJOVnZ6TWpDZnBjRUoxRUFRUlZqRFFSQ0FTcElxR0hXS0pBYlg5eDRU?=
 =?utf-8?B?ME1jYlcxM3VZMGcwSmk3OFMzZHVRRE9hVTlFWnFjNkZVZzMxODRwSFJCRHlO?=
 =?utf-8?B?NE9yOXdudFB3a1FYdnd2WkFrcEI2ZWR1QjJUMmliMWVXVmRsSFpFWi84UkZu?=
 =?utf-8?B?RlQ2YnNEeDZQZm1qYVJ5YkgyUU9tUllHMlBYSW91MVBZd1RKanFXdUNGUE1H?=
 =?utf-8?B?cmdDbjhLTWdvQXlieGF2cWF2cE9MWURZOWk5VURCNW5HUms5Q1NhalFoeFVH?=
 =?utf-8?Q?eslbZA7lwpShkC3OpF5WGuIC2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec29926e-d4c3-4d59-13f3-08dd82771543
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:56:53.2448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWvi1edjdbUPPFyUm4en0NUPHBAVbriA2hoJ6ysLPEj3joqlhsVL9O0Uud13NqM030N3roRY5dZlopc6vgdNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
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


On Sat, 22 Mar 2025 02:44:40 +0100, Marek Vasut wrote:
> The current code attempts to bind scmi_voltage_domain to regulator subnode
> of the SCMI protocol node, so scmi_voltage_domain can then bind regulators
> directly to subnodes of its node. This kind of behavior should not be in
> core code, move it into scmi_voltage_domain driver code. Let the driver
> descend into regulator node and bind regulators to its subnodes.
> 
> 
> [...]

After apply a fix from Alice Guo, applied, thanks!

[1/1] power: regulator: scmi: Move regulator subnode hack to scmi_regulator
      commit: 2a8e7ea4f948e3de7033b297fd827fe082cd63da

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
