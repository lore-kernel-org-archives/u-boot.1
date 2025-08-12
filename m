Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8826C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABB88331B;
	Tue, 12 Aug 2025 11:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="Hs/f4mKb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0860283323; Tue, 12 Aug 2025 11:47:31 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EA4832C8
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfQNuq5/dhc2Es86E+ZyAWh7CqUoBw3PdVjOhHKgd0OOzP9lkIgruzb9Mw8XNMUqQd7umAgR4bGYf7C7iktnfN/F1fZMVIsjDkr9x9rU6owMfG9QihkhEZblxRjST8v7aca9lkTvnh1EQg0XQUhEqBPO2QB0s1pw9C6Wa85hmNaBKlW4+h9qNKxImHPc1YgWD0qlRc1KTvXNz3XqEQaWmpoiaZyAN7teRijKtGC6HiVHwbjRf+VORM9+7Z2rS6HMtdPef/hDsyThQeZLiJ7DwwUsyx2cu95CJOWe/JaTcbZRAORbWFphTf3UJhyJIyoIaonYmaaJmt22W0/3gwVTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ePNt/t3CKMUtHBsBn1/vh7ILiYXy1YaFGMk61Or5Gw=;
 b=htGxhqT0k1rb2pGvphd3v0bT5vi5sBFvsioLSW0FnAbLS5H+gTUXYG+pP8uD8e4qhebezqZWB4CEe447wgFV/dVCTBI+CeHTkx4caCNz+dT2L5xYuiJzpLmKqJiaH/Y+ZKlX5Pxb48FffZnnZNlBpejb3jKFPD8mV9YJgzXoM8BjvLHERlKu3b8dRQWVpq5t5Z7HqWS0JOuaaAphLLoS3wxgOmplGFKr631Nq/bDv1jC2xX2fUs2SmbQImzG/2n/jho3+duF568lLyadQQ19HZV+OD4YlvEAH9AswhrqdDmKH6qhIPhz8wZLS00cS3MD3EJRspdbNuaDjt3bLvgc0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ePNt/t3CKMUtHBsBn1/vh7ILiYXy1YaFGMk61Or5Gw=;
 b=Hs/f4mKbCP1ts98PGmcsJ4quKMMYLTgwgNedq5SpuHIg7drUGrnMiwFi6Jz+LTOF5Vmk9y2Jh/eo2jt6Gn0TqgHzJ9PVJt2ZyWhX0OHKIgD1aGfshLGYMbmx8JxFE1NOvECrHg0Na6d1sRcHuTAPruPhAFdp+nArZUsLn4E53sW2mCI0AkGEwoar9lA+FfYlEWbBgIUqqgiOzmfUkO9K/nRToUddhPeAXTi2rjAZ4hifa9qB1NVDbFnhj2QFrSguPhAu00UIcB1qsTS4T3uqYNQrD9LnvU3erb83Y5tNv7P47wTIsEVwDTt8Pi/K0YKsSIdFMnl9v0i1uYw2ssGvIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI0PR10MB8428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:231::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:47:25 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:47:25 +0000
Message-ID: <ebd59a06-60e2-47a9-9b60-bd3fa8009102@kontron.de>
Date: Tue, 12 Aug 2025 11:47:24 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 21/24] mtd: spinand: sync with linux-6.17-rc1
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-22-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-22-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI0PR10MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 6514a900-ada8-47ff-1abe-08ddd9853e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1NrN3hWYnZGaFJsVXVaQmE2aVdPWTNqdHllbk1sVVlmY01OdmxsdE8ybGZx?=
 =?utf-8?B?ZUlxbzRlRjFYZlNXRGlNdUtNU2ZUTHRoVEl5Rkdwd0h5RU1nV0l6MUcyR1Ju?=
 =?utf-8?B?YmhyZWxOZ1pScEtOMWM2L2RyOW1jeUZwckh4aGdnZ3lUNHBYU09DRktVbDdz?=
 =?utf-8?B?NkVDcmFjcVBZeW5RNXN1RHNHSmtRQ0hmOXZUVlEzT1huVUI0dGlzZjFZTG5O?=
 =?utf-8?B?eUxLQU1hOXkvYm1nMzdTWHRGamRLWHpxNElOMS9sRWFOMFVCUVhRQmtCNURh?=
 =?utf-8?B?b25tVzZhL1NpWVllbDdYVVc5RkRUL3YxZUxQMklZcDdaNmszYWg1cCs0VDdx?=
 =?utf-8?B?Yk1TdktNakJwbllXSXVKVmhBa3lLS0tENFBjVHZ6aUlOZ0lzMGlhRWl1alJB?=
 =?utf-8?B?Q1UvMC9lUENCaWFBQys4MXNQUnlkbnVSRDJXVDJzOXZvYXM5Rlk0Mm5QY2o1?=
 =?utf-8?B?M0JiQzd2Tk9ZSW9sWkdpZ2dvTGdSTldZSlZqR3FpNlBmRVVxUU9JTnZtN0tr?=
 =?utf-8?B?czVZSnVybm80K1YrdmJlaWc3cWJwdlVtRXl6NVlZYkhrci9ySklKREJ4dTN5?=
 =?utf-8?B?WkpxdXVhRFNHckxNSFJqVFA5cGh2cG56TzFiTzBsYUhHS1ZxeE53YU1xc0ky?=
 =?utf-8?B?NlJRUDBYek1LQkRpZFNQeTJEQTNiRTl1VE9PZXhlTndzSDAraFNZeHhoOTUr?=
 =?utf-8?B?SHJUUUtHQlViNk1vUnlyUmxneHJNaHN5WlRJZnhpbXhkbE0waDFpOWp1U1Q3?=
 =?utf-8?B?ajFHdmVKcUlaWW1aTFdmVGlPR2lNWThXQzJpT1VPVVpMNHErYkhNUFBEelBH?=
 =?utf-8?B?UFNNemV0ZmtVNnhmZ09RbUdwVmUzMU95Yjh0MDQ1YkdzdU5IdVFMZkpsRUdY?=
 =?utf-8?B?SjRJMnE5UjVYYk1QSHo1YkhIcWcwYmpYSlRaaXhVa0hVUG84MkxVQ2Y4UXB0?=
 =?utf-8?B?b3lNSGkzbzI5SEdJQjlSc0hSZVN5UlZORStNdmZsNktMQzYvZlZwbnhQK2Ri?=
 =?utf-8?B?ZHp6d2lFOUZ5bSs0d0lHeE1CcjNRSVBSdk5jZklFeW1RenhsaWR5anFhT2NX?=
 =?utf-8?B?YUdqYkRnSkNlMmJpNzA4VkVCZ1oySDVoK3RWSE1vbko2QkxXWVBhM0dKcDdq?=
 =?utf-8?B?NDVUUW9VQncyNGoyV3djNG1KQmVzYTc4eU5KVDRiYko5eldZNEdxaDQrSmNn?=
 =?utf-8?B?dklJUWIwV05HZUNYU0FHcGdCZG01WURMK2xHSkNTTEVRWU1naXUxUzdOL3dS?=
 =?utf-8?B?Z3Z3ZUcySHNjTzNTNnlhQjNxa0xkek5JR095a3UvUWdoeXNwd25qcmRtUXND?=
 =?utf-8?B?Nzc2cERFVHk4YzVWK3lwQWtYaytJQ1ZZN0diSS90NjJUSFRHdFpFdGIyZ0pi?=
 =?utf-8?B?SFJnSkdDSC9XODE2dnpwaWd1aHRyRWxDdVQ5eHBCQU9oNWdHdmY3dlZpeGRJ?=
 =?utf-8?B?NWRGR1RZRFpEOENVdXpyckh3eERYdURhTEpnWEs5aWlWS0cyUFhkTWpqMEdC?=
 =?utf-8?B?Y3JBWHlkV3dlaWRHb3pqK0EzbllzL0FsSUZjZXZac2Y0d2dWUzhsNDUrMVFw?=
 =?utf-8?B?MG5aSXJieWV1aEwwNmhsYTFTTUxna3BQMkpIK3MvRUFBR0l3RHFoMXVXVXAx?=
 =?utf-8?B?WGJKU2xPWTVPZ3Bxd1JyWmliUjdSaXBIWU1wY0VSQUw0eHVBZ3hmR2N6Wm1s?=
 =?utf-8?B?SFY2SGhKeFVuMHlRclc5QTdyRHNWQm0wcEZQQ1B6eXNueEowWkpUdkZtMk0r?=
 =?utf-8?B?Y2lDVDdiZ0ZvZDA3dGJuV3lhUmd0OXRsN1ZpcXMrTCtGVGl3K0NsRVgzc3Z5?=
 =?utf-8?B?YnRSRjFrSkpTbEgrZWV2N0k3amQrSDVJdkdxSWZreXU1VTUzaXl3WmlQZ1dp?=
 =?utf-8?B?RktQamU4b2Myb1c0MGJsUklncVNIZFlrOCtzb3IyeExJV1ZqdGdGY3dnRFAw?=
 =?utf-8?B?M08yRjhXa2doYmxaaE5WbVVUeU51bFlrQUN5RzV0VmFWanVLeG9aenJoTmVC?=
 =?utf-8?B?cCs3R2lmdVZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhmYUJwckxtb0NyVVAwVWltYXNpa2JKdmVyV3IyYllWNXFtdVpsMXNnMWhU?=
 =?utf-8?B?ZE85WXdHeC80MDRwZTRaVmRHbVpLM2R6R21XZ1VHZXJsSkFXN0JUV0tpV0J0?=
 =?utf-8?B?MTlDM3JERk45OGVGc0prVjlURHJubFQxeHFzaHBIRlJVVWoyWTNHMmpsQm1S?=
 =?utf-8?B?YWhMNVdBN1Boc2pLYmtKaWE3SHRTczc1TXhIWW50NWx3ckVKZ0RMZUtpWGFX?=
 =?utf-8?B?WjROUG9uMHhhZThlbDF4VklMZGZudEVEdUM3UkI1RXpIcmZqc2pIZEs4K0E5?=
 =?utf-8?B?ZFQ1QW1hT1VIN3NuSFpBZWFOaW9WQnozdnBFbG1GeElsbk43dUxYOWtSUkox?=
 =?utf-8?B?N0VPOTVqSGlLOWFRanAxTEd3ZC9rc2V3Z1BjNWE0RjdHZ2k3RVhEWnZTVEFT?=
 =?utf-8?B?M05oR0c1d3o2YXp6WEJUODMzU0Z2UENHYURCUmtvdzM4UkNNNWVCYm8vR1o1?=
 =?utf-8?B?WE40MnoxN21Jb3dVc3ZHdUNvN3B3eUxzRjdFRy9rL0tRS1cxZ0RheXhmekNC?=
 =?utf-8?B?cHQ4ZGc5eDhLUVd0Lzd0UWFvVEtkenA3akNyVEl6bWp0S1hVZm9Rd3JXMTNl?=
 =?utf-8?B?Y3Erd0RleVBwc21yNmZQVlVHb1ZoN0pBdDhXVkpOR0pOMTBYM3Q2TlFON2tH?=
 =?utf-8?B?d2c3YUJkb1RaSTBheGFOZ0ZOTjBCcWY4UkZlYnFuSWQwZnB0eHN2VWlRZENV?=
 =?utf-8?B?MlpKRVVtVGZqVkNvcm9HclgrdmphVmR1VnlObUZvMHpUbXVzdUR2cVJ0MWFI?=
 =?utf-8?B?TkR5SEdNdmduZkFyMEl5QjZUVmlKdUlJT2RQT3lWb1dBS25TZ09BalVDbDlI?=
 =?utf-8?B?YXVjbFNlVTlHSVRvOTBKMmNNMy9JaWdlNXljdGNYL0RjOWNBWHY0NUZUalZq?=
 =?utf-8?B?NVRDZk1mQnphY2VqUzhqSitCSi9SUkttN084cUdlQVF6bTdEV2o1QU1zN09p?=
 =?utf-8?B?TGZaTXZ5SVZacmNVdVI1Vjc5U1MxZ0tmUXR6ejlUUFNhWktYeWczdjBYaWhp?=
 =?utf-8?B?OW9pMlRlS0JwU0ZWWUF6T3pvM2FBK003WEpTV3E4NmhKeXZoVEU0aW0yb2NE?=
 =?utf-8?B?TjRMVG5uTzFIa1VqTWVqdU9nWkNBTzlENGFGdFIzT3Z3c1RJaUl5T093VGN4?=
 =?utf-8?B?Vktqb1B4enQ3aXZWNFI3eklVdGJjbFNHaXMwNHJyK2xQbFJjWitRK2VtbFpG?=
 =?utf-8?B?bFcraFRpQ3ZmcGxmZWoyZE5IbE81Wk9FY2xhNVNYTzREbHFnNm9xbGhrc3Rp?=
 =?utf-8?B?Tk1OTHdGd1pCRmxHNFJ3NCtza3QxZVpnemUvVzRwc0ZOdkwrZWVHZ0xZNkNr?=
 =?utf-8?B?aHl2TUtpMW9SMjdOS3YybGRaZ1J4a0tWVEtuemUwajRoNnRuMTZ1VlB4b1NP?=
 =?utf-8?B?OGY2NGcybW1QMGFSRHBIeEZDdXdGVWxQU2xoVTliSkJKamtLeS82MU41THZ6?=
 =?utf-8?B?UGs1d0RJRGhvaHVPb2ZJcW9HWEFNVjEzTitEd0xEZUhWcGF4TmVpdC9vcU5X?=
 =?utf-8?B?b0FjcHU0L0k0TytyaW5ZcWlyc1llQ0REWlFQVktMNmthZ08rTGQ2SUIwaGR0?=
 =?utf-8?B?WTRSdGVCN213bUVzL3RQMnp4Z3FZdnBaZ2txM0ljRGpya2lnc3dTUm95YUVv?=
 =?utf-8?B?ME8yMWlvM3lFYkdMVXc1QzZmMWhiQzhTcWltOTg4d09qRHU3STRwSXdFMEZ1?=
 =?utf-8?B?amtzQkNWWUxlZ3QzWVdYN0Y4Z2MzUzJYM1lOMUJrK3owa0NCTktsYTlmTjBr?=
 =?utf-8?B?VzJDUjhmQXRIU1NNQ3h3ZjJpVVJINUpZWTNidVR4aE0xVXBzYTBiMm9DUFZM?=
 =?utf-8?B?T212Ni9IODBDVkoxd0lvMklzdE03RkFobm5SMmQ0elgrd0I2NkFqQW8zWnNC?=
 =?utf-8?B?dG9LODBIQjZlL0lOR1lkbzJtSmNSbExRaUhGQ1RQdVEyTTZRQ09Fb0s4dkdZ?=
 =?utf-8?B?akJRdGc0WHVVN1RZOFg5dEZrMFNLUExRQmVSWTZvTFVwcmQ0ZEEyOTZvMTNG?=
 =?utf-8?B?eW5pU3pENkFPNzMzUWZaa2x5WDd2SCt6azh4NW5XM05PTDcrZmVGZ1BBUTB0?=
 =?utf-8?B?cHV3ZGtZTm5zb1dUczk2ZUtMVUpFV1FIOGFFWVdYOFNxcVN0bVF2ZWJqK1dG?=
 =?utf-8?B?N0hzN1pRNkwwQ3c5SHJ0ZHBoWjVzY2VMQ0pFenJSQTg1bnFUZ1ljMWNtWTVZ?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6514a900-ada8-47ff-1abe-08ddd9853e1e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:47:25.4689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhBOrH0TJ1Selw0lFQ6PWE5JBV31JXKUXN+xhmUWPVMyHQe2SNx4yHfU+N/H5rXHTvK2s0DBqi+jsrLNF6mkMLn4DVjZzSdEbc53JtypaHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8428
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

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> This makes u-boot spinand driver almost the same as spinand driver
> from linux-6.17-rc1. The only major differences are
>  * support of ECC engines. The linux driver supports different ECC
>    engines while u-boot driver uses on-die ecc only.
>  * per operation maximum spi bus frequency

Suggestion for subject and commit message:

###
mtd: spinand: Sync device support with Linux 6.17-rc1

This makes the U-Boot SPI NAND driver almost the same as in Linux
6.17-rc1. The only major differences are:
  * support of ECC engines. The Linux driver supports different ECC
    engines while U-Boot uses on-die ECC only.
  * per operation maximum SPI bus frequency
###

> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/Makefile         |   2 +-
>  drivers/mtd/nand/spi/alliancememory.c |  20 +-
>  drivers/mtd/nand/spi/ato.c            |  18 +-
>  drivers/mtd/nand/spi/core.c           |  21 +-
>  drivers/mtd/nand/spi/esmt.c           | 111 +++++++-
>  drivers/mtd/nand/spi/foresee.c        |  26 +-
>  drivers/mtd/nand/spi/gigadevice.c     |  80 +++---
>  drivers/mtd/nand/spi/macronix.c       | 269 ++++++++++++++++----
>  drivers/mtd/nand/spi/micron.c         | 178 +++++++++++--
>  drivers/mtd/nand/spi/paragon.c        |  24 +-
>  drivers/mtd/nand/spi/skyhigh.c        | 149 +++++++++++
>  drivers/mtd/nand/spi/toshiba.c        |  22 +-
>  drivers/mtd/nand/spi/winbond.c        | 352 +++++++++++++++++++++++---
>  drivers/mtd/nand/spi/xtx.c            |  20 +-
>  include/linux/mtd/nand.h              |  30 ++-
>  include/linux/mtd/spinand.h           | 177 ++++++++++---
>  16 files changed, 1233 insertions(+), 266 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/skyhigh.c
> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 831760da1c9..152aa1a3783 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -2,5 +2,5 @@
>  
>  spinand-objs := core.o otp.o
>  spinand-objs += alliancememory.o ato.o esmt.o foresee.o gigadevice.o macronix.o
> -spinand-objs += micron.o paragon.o toshiba.o winbond.o xtx.o
> +spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/alliancememory.c b/drivers/mtd/nand/spi/alliancememory.c
> index e29e4cc77ec..a3772b8c2f0 100644
> --- a/drivers/mtd/nand/spi/alliancememory.c
> +++ b/drivers/mtd/nand/spi/alliancememory.c
> @@ -19,20 +19,20 @@
>  #define AM_STATUS_ECC_MAX_CORRECTED	(3 << 4)
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +			   SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +			   SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +			   SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +			   SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  static int am_get_eccsize(struct mtd_info *mtd)
>  {
> diff --git a/drivers/mtd/nand/spi/ato.c b/drivers/mtd/nand/spi/ato.c
> index f0d4436cf45..a726df3eb98 100644
> --- a/drivers/mtd/nand/spi/ato.c
> +++ b/drivers/mtd/nand/spi/ato.c
> @@ -11,20 +11,23 @@
>  #endif
>  #include <linux/mtd/spinand.h>
>  
> +
>  #define SPINAND_MFR_ATO		0x9b
>  
> +
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> +
>  
>  static int ato25d1ga_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				   struct mtd_oob_region *region)
> @@ -60,6 +63,7 @@ static const struct mtd_ooblayout_ops ato25d1ga_ooblayout = {
>  	.rfree = ato25d1ga_ooblayout_free,
>  };
>  
> +
>  static const struct spinand_info ato_spinand_table[] = {
>  	SPINAND_INFO("ATO25D1GA",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x12),
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 25e7a38a874..b3d53e234b7 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -42,9 +42,9 @@ struct spinand_plat {
>  /* SPI NAND index visible in MTD names */
>  static int spi_nand_idx;
>  
> -static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
> +int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  {
> -	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(reg,
>  						      spinand->scratchbuf);
>  	int ret;
>  
> @@ -58,7 +58,7 @@ static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  
>  int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)
>  {
> -	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(reg,
> +	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(reg,
>  						      spinand->scratchbuf);
>  
>  	*spinand->scratchbuf = val;
> @@ -357,9 +357,9 @@ static void spinand_ondie_ecc_save_status(struct nand_device *nand, u8 status)
>  	spinand->last_wait_status = status;
>  }
>  
> -static int spinand_write_enable_op(struct spinand_device *spinand)
> +int spinand_write_enable_op(struct spinand_device *spinand)
>  {
> -	struct spi_mem_op op = SPINAND_WR_EN_DIS_OP(true);
> +	struct spi_mem_op op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
>  
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
> @@ -369,7 +369,7 @@ static int spinand_load_page_op(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
> -	struct spi_mem_op op = SPINAND_PAGE_READ_OP(row);
> +	struct spi_mem_op op = SPINAND_PAGE_READ_1S_1S_0_OP(row);
>  
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
> @@ -516,7 +516,7 @@ static int spinand_program_op(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	unsigned int row = nanddev_pos_to_row(nand, &req->pos);
> -	struct spi_mem_op op = SPINAND_PROG_EXEC_OP(row);
> +	struct spi_mem_op op = SPINAND_PROG_EXEC_1S_1S_0_OP(row);
>  
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
> @@ -526,7 +526,7 @@ static int spinand_erase_op(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	unsigned int row = nanddev_pos_to_row(nand, pos);
> -	struct spi_mem_op op = SPINAND_BLK_ERASE_OP(row);
> +	struct spi_mem_op op = SPINAND_BLK_ERASE_1S_1S_0_OP(row);
>  
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
> @@ -586,7 +586,7 @@ out:
>  static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
>  			      u8 ndummy, u8 *buf)
>  {
> -	struct spi_mem_op op = SPINAND_READID_OP(
> +	struct spi_mem_op op = SPINAND_READID_1S_1S_1S_OP(
>  		naddr, ndummy, spinand->scratchbuf, SPINAND_MAX_ID_LEN);
>  	int ret;
>  
> @@ -599,7 +599,7 @@ static int spinand_read_id_op(struct spinand_device *spinand, u8 naddr,
>  
>  static int spinand_reset_op(struct spinand_device *spinand)
>  {
> -	struct spi_mem_op op = SPINAND_RESET_OP;
> +	struct spi_mem_op op = SPINAND_RESET_1S_0_0_OP;
>  	int ret;
>  
>  	ret = spi_mem_exec_op(spinand->slave, &op);
> @@ -1188,6 +1188,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
> +	&skyhigh_spinand_manufacturer,
>  	&toshiba_spinand_manufacturer,
>  	&winbond_spinand_manufacturer,
>  	&xtx_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/esmt.c b/drivers/mtd/nand/spi/esmt.c
> index 23be098b885..6a46f3a3bfc 100644
> --- a/drivers/mtd/nand/spi/esmt.c
> +++ b/drivers/mtd/nand/spi/esmt.c
> @@ -8,25 +8,33 @@
>  #ifndef __UBOOT__
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#else
> +#include <dm/device_compat.h>
> +#include <spi-mem.h>
> +#include <spi.h>
>  #endif
>  #include <linux/mtd/spinand.h>
>  
>  /* ESMT uses GigaDevice 0xc8 JECDEC ID on some SPI NANDs */
>  #define SPINAND_MFR_ESMT_C8			0xc8
>  
> +#define ESMT_F50L1G41LB_CFG_OTP_PROTECT		BIT(7)
> +#define ESMT_F50L1G41LB_CFG_OTP_LOCK		\
> +	(CFG_OTP_ENABLE | ESMT_F50L1G41LB_CFG_OTP_PROTECT)
> +
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -			   SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +			   SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +			   SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -			   SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +			   SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +			   SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  /*
>   * OOB spare area map (64 bytes)
> @@ -104,6 +112,83 @@ static const struct mtd_ooblayout_ops f50l1g41lb_ooblayout = {
>  	.rfree = f50l1g41lb_ooblayout_free,
>  };
>  
> +static int f50l1g41lb_otp_info(struct spinand_device *spinand, size_t len,
> +			       struct otp_info *buf, size_t *retlen, bool user)
> +{
> +	if (len < sizeof(*buf))
> +		return -EINVAL;
> +
> +	buf->locked = 0;
> +	buf->start = 0;
> +	buf->length = user ? spinand_user_otp_size(spinand) :
> +			     spinand_fact_otp_size(spinand);
> +
> +	*retlen = sizeof(*buf);
> +	return 0;
> +}
> +
> +static int f50l1g41lb_fact_otp_info(struct spinand_device *spinand, size_t len,
> +				    struct otp_info *buf, size_t *retlen)
> +{
> +	return f50l1g41lb_otp_info(spinand, len, buf, retlen, false);
> +}
> +
> +static int f50l1g41lb_user_otp_info(struct spinand_device *spinand, size_t len,
> +				    struct otp_info *buf, size_t *retlen)
> +{
> +	return f50l1g41lb_otp_info(spinand, len, buf, retlen, true);
> +}
> +
> +static int f50l1g41lb_otp_lock(struct spinand_device *spinand, loff_t from,
> +			       size_t len)
> +{
> +	struct spi_mem_op write_op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
> +	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
> +	u8 status;
> +	int ret;
> +
> +	ret = spinand_upd_cfg(spinand, ESMT_F50L1G41LB_CFG_OTP_LOCK,
> +			      ESMT_F50L1G41LB_CFG_OTP_LOCK);
> +	if (!ret)
> +		return ret;
> +
> +	ret = spi_mem_exec_op(spinand->slave, &write_op);
> +	if (!ret)
> +		goto out;
> +
> +	ret = spi_mem_exec_op(spinand->slave, &exec_op);
> +	if (!ret)
> +		goto out;
> +
> +	ret = spinand_wait(spinand,
> +			   SPINAND_WRITE_INITIAL_DELAY_US,
> +			   SPINAND_WRITE_POLL_DELAY_US,
> +			   &status);
> +	if (!ret && (status & STATUS_PROG_FAILED))
> +		ret = -EIO;
> +
> +out:
> +	if (spinand_upd_cfg(spinand, ESMT_F50L1G41LB_CFG_OTP_LOCK, 0)) {
> +		dev_warn(spinand->slave->dev,
> +			 "Can not disable OTP mode\n");
> +		ret = -EIO;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct spinand_user_otp_ops f50l1g41lb_user_otp_ops = {
> +	.info = f50l1g41lb_user_otp_info,
> +	.lock = f50l1g41lb_otp_lock,
> +	.read = spinand_user_otp_read,
> +	.write = spinand_user_otp_write,
> +};
> +
> +static const struct spinand_fact_otp_ops f50l1g41lb_fact_otp_ops = {
> +	.info = f50l1g41lb_fact_otp_info,
> +	.read = spinand_fact_otp_read,
> +};
> +
>  static const struct spinand_info esmt_c8_spinand_table[] = {
>  	SPINAND_INFO("F50L1G41LB",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x01, 0x7f,
> @@ -114,17 +199,21 @@ static const struct spinand_info esmt_c8_spinand_table[] = {
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
> +		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL),
> +		     SPINAND_USER_OTP_INFO(28, 2, &f50l1g41lb_user_otp_ops),
> +		     SPINAND_FACT_OTP_INFO(2, 0, &f50l1g41lb_fact_otp_ops)),
>  	SPINAND_INFO("F50D1G41LB",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x11, 0x7f,
> -				0x7f, 0x7f),
> +				0x7f),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(1, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL)),
> +		     SPINAND_ECCINFO(&f50l1g41lb_ooblayout, NULL),
> +		     SPINAND_USER_OTP_INFO(28, 2, &f50l1g41lb_user_otp_ops),
> +		     SPINAND_FACT_OTP_INFO(2, 0, &f50l1g41lb_fact_otp_ops)),
>  	SPINAND_INFO("F50D2G41KA",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51, 0x7f,
>  				0x7f, 0x7f),
> diff --git a/drivers/mtd/nand/spi/foresee.c b/drivers/mtd/nand/spi/foresee.c
> index 6229c959b2c..370f8494fb5 100644
> --- a/drivers/mtd/nand/spi/foresee.c
> +++ b/drivers/mtd/nand/spi/foresee.c
> @@ -14,18 +14,18 @@
>  #define SPINAND_MFR_FORESEE		0xCD
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  static int f35sqa002g_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				    struct mtd_oob_region *region)
> @@ -83,6 +83,16 @@ static const struct spinand_info foresee_spinand_table[] = {
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
>  				     f35sqa002g_ecc_get_status)),
> +	SPINAND_INFO("F35SQA001G",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x71, 0x71),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&f35sqa002g_ooblayout,
> +				     f35sqa002g_ecc_get_status)),
>  };
>  
>  static const struct spinand_manufacturer_ops foresee_spinand_manuf_ops = {
> diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
> index f3608a13d8e..32fbe11e908 100644
> --- a/drivers/mtd/nand/spi/gigadevice.c
> +++ b/drivers/mtd/nand/spi/gigadevice.c
> @@ -28,44 +28,44 @@
>  #define GD5FXGQ4UXFXXG_STATUS_ECC_UNCOR_ERROR	(7 << 4)
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants_f,
> -		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP_3A(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP_3A(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(false, 0, 0, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(0, 0, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
> -		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
> -		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  static int gd5fxgq4xa_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
> @@ -189,7 +189,7 @@ static int gd5fxgq4uexxg_ecc_get_status(struct spinand_device *spinand,
>  					u8 status)
>  {
>  	u8 status2;
> -	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(GD5FXGQXXEXXG_REG_STATUS2,
>  						      spinand->scratchbuf);
>  	int ret;
>  
> @@ -232,7 +232,7 @@ static int gd5fxgq5xexxg_ecc_get_status(struct spinand_device *spinand,
>  					u8 status)
>  {
>  	u8 status2;
> -	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(GD5FXGQXXEXXG_REG_STATUS2,
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(GD5FXGQXXEXXG_REG_STATUS2,
>  						      spinand->scratchbuf);
>  	int ret;
>  
> @@ -537,6 +537,26 @@ static const struct spinand_info gigadevice_spinand_table[] = {
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
>  				     gd5fxgq4uexxg_ecc_get_status)),
> +	SPINAND_INFO("GD5F1GM9UExxG",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x91, 0x01),
> +		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
> +				     gd5fxgq4uexxg_ecc_get_status)),
> +	SPINAND_INFO("GD5F1GM9RExxG",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x81, 0x01),
> +		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
> +				     gd5fxgq4uexxg_ecc_get_status)),
>  };
>  
>  static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
> index c2a7aa2da96..f21103bb15a 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -5,6 +5,7 @@
>   * Author: Boris Brezillon <boris.brezillon@bootlin.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #ifndef __UBOOT__
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -13,21 +14,35 @@
>  #include <linux/mtd/spinand.h>
>  
>  #define SPINAND_MFR_MACRONIX		0xC2
> -#define MACRONIX_ECCSR_MASK		0x0F
> +#define MACRONIX_ECCSR_BF_LAST_PAGE(eccsr) FIELD_GET(GENMASK(3, 0), eccsr)
> +#define MACRONIX_ECCSR_BF_ACCUMULATED_PAGES(eccsr) FIELD_GET(GENMASK(7, 4), eccsr)
> +#define MACRONIX_CFG_CONT_READ         BIT(2)
> +#define MACRONIX_FEATURE_ADDR_READ_RETRY 0x70
> +#define MACRONIX_NUM_READ_RETRY_MODES 5
> +
> +#define STATUS_ECC_HAS_BITFLIPS_THRESHOLD (3 << 4)
> +
> +/* Bitflip theshold configuration register */
> +#define REG_CFG_BFT 0x10
> +#define CFG_BFT(x) FIELD_PREP(GENMASK(7, 4), (x))
> +
> +struct macronix_priv {
> +	bool cont_read;
> +};
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  static int mx35lfxge4ab_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				      struct mtd_oob_region *region)
> @@ -52,8 +67,9 @@ static const struct mtd_ooblayout_ops mx35lfxge4ab_ooblayout = {
>  	.rfree = mx35lfxge4ab_ooblayout_free,
>  };
>  
> -static int mx35lf1ge4ab_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
> +static int macronix_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
>  {
> +	struct macronix_priv *priv = spinand->priv;
>  	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(0x7c, 1),
>  					  SPI_MEM_OP_NO_ADDR,
>  					  SPI_MEM_OP_DUMMY(1, 1),
> @@ -63,12 +79,21 @@ static int mx35lf1ge4ab_get_eccsr(struct spinand_device *spinand, u8 *eccsr)
>  	if (ret)
>  		return ret;
>  
> -	*eccsr &= MACRONIX_ECCSR_MASK;
> +	/*
> +	 * ECCSR exposes the number of bitflips for the last read page in bits [3:0].
> +	 * Continuous read compatible chips also expose the maximum number of
> +	 * bitflips for the whole (continuous) read operation in bits [7:4].
> +	 */
> +	if (!priv->cont_read)
> +		*eccsr = MACRONIX_ECCSR_BF_LAST_PAGE(*eccsr);
> +	else
> +		*eccsr = MACRONIX_ECCSR_BF_ACCUMULATED_PAGES(*eccsr);
> +
>  	return 0;
>  }
>  
> -static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
> -				       u8 status)
> +static int macronix_ecc_get_status(struct spinand_device *spinand,
> +				   u8 status)
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	u8 eccsr;
> @@ -86,16 +111,14 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
>  		 * in order to avoid forcing the wear-leveling layer to move
>  		 * data around if it's not necessary.
>  		 */
> -		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
> +		if (macronix_get_eccsr(spinand, spinand->scratchbuf))
>  			return nanddev_get_ecc_conf(nand)->strength;
>  
>  		eccsr = *spinand->scratchbuf;
> -		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
> -			    !eccsr))
> +		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength || !eccsr))
>  			return nanddev_get_ecc_conf(nand)->strength;
>  
>  		return eccsr;
> -
>  	default:
>  		break;
>  	}
> @@ -103,6 +126,38 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
>  	return -EINVAL;
>  }
>  
> +static int macronix_set_cont_read(struct spinand_device *spinand, bool enable)
> +{
> +	struct macronix_priv *priv = spinand->priv;
> +	int ret;
> +
> +	ret = spinand_upd_cfg(spinand, MACRONIX_CFG_CONT_READ,
> +			      enable ? MACRONIX_CFG_CONT_READ : 0);
> +	if (ret)
> +		return ret;
> +
> +	priv->cont_read = enable;
> +
> +	return 0;
> +}
> +
> +/**
> + * macronix_set_read_retry - Set the retry mode
> + * @spinand: SPI NAND device
> + * @retry_mode: Specify which retry mode to set
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +static int macronix_set_read_retry(struct spinand_device *spinand,
> +					     unsigned int retry_mode)
> +{
> +	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(MACRONIX_FEATURE_ADDR_READ_RETRY,
> +							       spinand->scratchbuf);
> +
> +	*spinand->scratchbuf = retry_mode;
> +	return spi_mem_exec_op(spinand->slave, &op);
> +}
> +
>  static const struct spinand_info macronix_spinand_table[] = {
>  	SPINAND_INFO("MX35LF1GE4AB",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x12),
> @@ -113,7 +168,7 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status)),
>  	SPINAND_INFO("MX35LF2GE4AB",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x22),
>  		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
> @@ -121,10 +176,12 @@ static const struct spinand_info macronix_spinand_table[] = {
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
> -		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_HAS_QE_BIT |
> +		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
> +		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
>  	SPINAND_INFO("MX35LF2GE4AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x26, 0x03),
>  		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -132,9 +189,12 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status),
> +		     SPINAND_CONT_READ(macronix_set_cont_read),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35LF4GE4AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37, 0x03),
>  		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -142,34 +202,67 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status),
> +		     SPINAND_CONT_READ(macronix_set_cont_read),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35LF1G24AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14, 0x03),
>  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
> -		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35LF2G24AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24, 0x03),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT |
> +		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
> +	SPINAND_INFO("MX35LF2G24AD-Z4I8",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
> -		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35LF4G24AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35, 0x03),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT |
> +		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
> +	SPINAND_INFO("MX35LF4G24AD-Z4I8",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
> +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
> -		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX31LF1GE4BC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> @@ -179,7 +272,7 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status)),
>  	SPINAND_INFO("MX31UF1GE4BC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x9e),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> @@ -189,7 +282,7 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status)),
>  
>  	SPINAND_INFO("MX35LF2G14AC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x20),
> @@ -198,21 +291,38 @@ static const struct spinand_info macronix_spinand_table[] = {
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
> -		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_HAS_QE_BIT |
> +		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
> +		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status)),
>  	SPINAND_INFO("MX35UF4G24AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb5),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb5, 0x03),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT |
> +		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> +				     macronix_ecc_get_status),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
> +	SPINAND_INFO("MX35UF4G24AD-Z4I8",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
> +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35UF4GE4AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7, 0x03),
>  		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -220,7 +330,10 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status),
> +		     SPINAND_CONT_READ(macronix_set_cont_read),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35UF2G14AC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa0),
>  		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
> @@ -228,21 +341,38 @@ static const struct spinand_info macronix_spinand_table[] = {
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
> -		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_HAS_QE_BIT |
> +		     SPINAND_HAS_PROG_PLANE_SELECT_BIT |
> +		     SPINAND_HAS_READ_PLANE_SELECT_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status)),
>  	SPINAND_INFO("MX35UF2G24AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa4),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa4, 0x03),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT |
> +		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
> +		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> +				     macronix_ecc_get_status),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
> +	SPINAND_INFO("MX35UF2G24AD-Z4I8",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35UF2GE4AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6, 0x03),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -250,9 +380,12 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status),
> +		     SPINAND_CONT_READ(macronix_set_cont_read),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35UF2GE4AC",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa2),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa2, 0x01),
>  		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(4, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -260,7 +393,8 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status),
> +		     SPINAND_CONT_READ(macronix_set_cont_read)),
>  	SPINAND_INFO("MX35UF1G14AC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x90),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> @@ -270,9 +404,9 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status)),
>  	SPINAND_INFO("MX35UF1G24AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x94),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x94, 0x03),
>  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -280,9 +414,11 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35UF1GE4AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96, 0x03),
>  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -290,9 +426,12 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status),
> +		     SPINAND_CONT_READ(macronix_set_cont_read),
> +		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
> +					macronix_set_read_retry)),
>  	SPINAND_INFO("MX35UF1GE4AC",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92, 0x01),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(4, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -300,8 +439,8 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> -
> +				     macronix_ecc_get_status),
> +		     SPINAND_CONT_READ(macronix_set_cont_read)),
>  	SPINAND_INFO("MX31LF2GE4BC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2e),
>  		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> @@ -311,7 +450,7 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status)),
>  	SPINAND_INFO("MX3UF2GE4BC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae),
>  		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> @@ -321,10 +460,30 @@ static const struct spinand_info macronix_spinand_table[] = {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     macronix_ecc_get_status)),
>  };
>  
> +static int macronix_spinand_init(struct spinand_device *spinand)
> +{
> +	struct macronix_priv *priv;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	spinand->priv = priv;
> +
> +	return 0;
> +}
> +
> +static void macronix_spinand_cleanup(struct spinand_device *spinand)
> +{
> +	kfree(spinand->priv);
> +}
> +
>  static const struct spinand_manufacturer_ops macronix_spinand_manuf_ops = {
> +	.init = macronix_spinand_init,
> +	.cleanup = macronix_spinand_cleanup,
>  };
>  
>  const struct spinand_manufacturer macronix_spinand_manufacturer = {
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 01c177facfb..9af3e99664f 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -9,8 +9,14 @@
>  #ifndef __UBOOT__
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> +#include <linux/spi/spi-mem.h>
> +#else
> +#include <dm/device_compat.h>
> +#include <spi-mem.h>
> +#include <spi.h>
>  #endif
>  #include <linux/mtd/spinand.h>
> +#include <linux/string.h>
>  
>  #define SPINAND_MFR_MICRON		0x2c
>  
> @@ -30,34 +36,38 @@
>  
>  #define MICRON_SELECT_DIE(x)	((x) << 6)
>  
> +#define MICRON_MT29F2G01ABAGD_CFG_OTP_STATE		BIT(7)
> +#define MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK		\
> +	(CFG_OTP_ENABLE | MICRON_MT29F2G01ABAGD_CFG_OTP_STATE)
> +
>  static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(x4_write_cache_variants,
> -		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(x4_update_cache_variants,
> -		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  /* Micron  MT29F2G01AAAED Device */
>  static SPINAND_OP_VARIANTS(x4_read_cache_variants,
> -			   SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -			   SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -			   SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -			   SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +			   SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +			   SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(x1_write_cache_variants,
> -			   SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +			   SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(x1_update_cache_variants,
> -			   SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +			   SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  static int micron_8_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
> @@ -133,7 +143,7 @@ static const struct mtd_ooblayout_ops micron_4_ooblayout = {
>  static int micron_select_target(struct spinand_device *spinand,
>  				unsigned int target)
>  {
> -	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(MICRON_DIE_SELECT_REG,
> +	struct spi_mem_op op = SPINAND_SET_FEATURE_1S_1S_1S_OP(MICRON_DIE_SELECT_REG,
>  						      spinand->scratchbuf);
>  
>  	if (target > 1)
> @@ -170,6 +180,136 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
>  	return -EINVAL;
>  }
>  
> +static inline bool mem_is_zero(const void *s, size_t n)
> +{
> +	return !memchr_inv(s, 0, n);
> +}
> +
> +static int mt29f2g01abagd_otp_is_locked(struct spinand_device *spinand)
> +{
> +	size_t bufsize = spinand_otp_page_size(spinand);
> +	size_t retlen;
> +	u8 *buf;
> +	int ret;
> +
> +	buf = kmalloc(bufsize, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = spinand_upd_cfg(spinand,
> +			      MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK,
> +			      MICRON_MT29F2G01ABAGD_CFG_OTP_STATE);
> +	if (ret)
> +		goto free_buf;
> +
> +	ret = spinand_user_otp_read(spinand, 0, bufsize, &retlen, buf);
> +
> +	if (spinand_upd_cfg(spinand, MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK,
> +			    0)) {
> +		dev_warn(spinand->slave->dev,
> +			 "Can not disable OTP mode\n");
> +		ret = -EIO;
> +	}
> +
> +	if (ret)
> +		goto free_buf;
> +
> +	/* If all zeros, then the OTP area is locked. */
> +	if (mem_is_zero(buf, bufsize))
> +		ret = 1;
> +
> +free_buf:
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static int mt29f2g01abagd_otp_info(struct spinand_device *spinand, size_t len,
> +				   struct otp_info *buf, size_t *retlen,
> +				   bool user)
> +{
> +	int locked;
> +
> +	if (len < sizeof(*buf))
> +		return -EINVAL;
> +
> +	locked = mt29f2g01abagd_otp_is_locked(spinand);
> +	if (locked < 0)
> +		return locked;
> +
> +	buf->locked = locked;
> +	buf->start = 0;
> +	buf->length = user ? spinand_user_otp_size(spinand) :
> +			     spinand_fact_otp_size(spinand);
> +
> +	*retlen = sizeof(*buf);
> +	return 0;
> +}
> +
> +static int mt29f2g01abagd_fact_otp_info(struct spinand_device *spinand,
> +					size_t len, struct otp_info *buf,
> +					size_t *retlen)
> +{
> +	return mt29f2g01abagd_otp_info(spinand, len, buf, retlen, false);
> +}
> +
> +static int mt29f2g01abagd_user_otp_info(struct spinand_device *spinand,
> +					size_t len, struct otp_info *buf,
> +					size_t *retlen)
> +{
> +	return mt29f2g01abagd_otp_info(spinand, len, buf, retlen, true);
> +}
> +
> +static int mt29f2g01abagd_otp_lock(struct spinand_device *spinand, loff_t from,
> +				   size_t len)
> +{
> +	struct spi_mem_op write_op = SPINAND_WR_EN_DIS_1S_0_0_OP(true);
> +	struct spi_mem_op exec_op = SPINAND_PROG_EXEC_1S_1S_0_OP(0);
> +	u8 status;
> +	int ret;
> +
> +	ret = spinand_upd_cfg(spinand,
> +			      MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK,
> +			      MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK);
> +	if (!ret)
> +		return ret;
> +
> +	ret = spi_mem_exec_op(spinand->slave, &write_op);
> +	if (!ret)
> +		goto out;
> +
> +	ret = spi_mem_exec_op(spinand->slave, &exec_op);
> +	if (!ret)
> +		goto out;
> +
> +	ret = spinand_wait(spinand,
> +			   SPINAND_WRITE_INITIAL_DELAY_US,
> +			   SPINAND_WRITE_POLL_DELAY_US,
> +			   &status);
> +	if (!ret && (status & STATUS_PROG_FAILED))
> +		ret = -EIO;
> +
> +out:
> +	if (spinand_upd_cfg(spinand, MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK, 0)) {
> +		dev_warn(spinand->slave->dev,
> +			 "Can not disable OTP mode\n");
> +		ret = -EIO;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct spinand_user_otp_ops mt29f2g01abagd_user_otp_ops = {
> +	.info = mt29f2g01abagd_user_otp_info,
> +	.lock = mt29f2g01abagd_otp_lock,
> +	.read = spinand_user_otp_read,
> +	.write = spinand_user_otp_write,
> +};
> +
> +static const struct spinand_fact_otp_ops mt29f2g01abagd_fact_otp_ops = {
> +	.info = mt29f2g01abagd_fact_otp_info,
> +	.read = spinand_fact_otp_read,
> +};
> +
>  static const struct spinand_info micron_spinand_table[] = {
>  	/* M79A 2Gb 3.3V */
>  	SPINAND_INFO("MT29F2G01ABAGD",
> @@ -181,7 +321,9 @@ static const struct spinand_info micron_spinand_table[] = {
>  					      &x4_update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&micron_8_ooblayout,
> -				     micron_8_ecc_get_status)),
> +				     micron_8_ecc_get_status),
> +		     SPINAND_USER_OTP_INFO(12, 2, &mt29f2g01abagd_user_otp_ops),
> +		     SPINAND_FACT_OTP_INFO(2, 0, &mt29f2g01abagd_fact_otp_ops)),
>  	/* M79A 2Gb 1.8V */
>  	SPINAND_INFO("MT29F2G01ABBGD",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
> diff --git a/drivers/mtd/nand/spi/paragon.c b/drivers/mtd/nand/spi/paragon.c
> index 079431cea8f..a7106ae194b 100644
> --- a/drivers/mtd/nand/spi/paragon.c
> +++ b/drivers/mtd/nand/spi/paragon.c
> @@ -11,8 +11,10 @@
>  #endif
>  #include <linux/mtd/spinand.h>
>  
> +
>  #define SPINAND_MFR_PARAGON	0xa1
>  
> +
>  #define PN26G0XA_STATUS_ECC_BITMASK		(3 << 4)
>  
>  #define PN26G0XA_STATUS_ECC_NONE_DETECTED	(0 << 4)
> @@ -20,21 +22,23 @@
>  #define PN26G0XA_STATUS_ECC_ERRORED		(2 << 4)
>  #define PN26G0XA_STATUS_ECC_8_CORRECTED		(3 << 4)
>  
> +
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> +
>  
>  static int pn26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				   struct mtd_oob_region *region)
> diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhigh.c
> new file mode 100644
> index 00000000000..5e9487bd27a
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/skyhigh.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 SkyHigh Memory Limited
> + *
> + * Author: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> + * Co-Author: KR Kim <kr.kim@skyhighmemory.com>
> + */
> +
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_SKYHIGH			0x01
> +#define SKYHIGH_STATUS_ECC_1TO2_BITFLIPS	(1 << 4)
> +#define SKYHIGH_STATUS_ECC_3TO6_BITFLIPS	(2 << 4)
> +#define SKYHIGH_STATUS_ECC_UNCOR_ERROR		(3 << 4)
> +#define SKYHIGH_CONFIG_PROTECT_EN		BIT(1)
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> +
> +static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int section,
> +					 struct mtd_oob_region *region)
> +{
> +	/* ECC bytes are stored in hidden area. */
> +	return -ERANGE;
> +}
> +
> +static int skyhigh_spinand_ooblayout_free(struct mtd_info *mtd, int section,
> +					  struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	/* ECC bytes are stored in hidden area. Reserve 2 bytes for the BBM. */
> +	region->offset = 2;
> +	region->length = mtd->oobsize - 2;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops skyhigh_spinand_ooblayout = {
> +	.ecc = skyhigh_spinand_ooblayout_ecc,
> +	.rfree = skyhigh_spinand_ooblayout_free,
> +};
> +
> +static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand,
> +					  u8 status)
> +{
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case SKYHIGH_STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;
> +
> +	case SKYHIGH_STATUS_ECC_1TO2_BITFLIPS:
> +		return 2;
> +
> +	case SKYHIGH_STATUS_ECC_3TO6_BITFLIPS:
> +		return 6;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct spinand_info skyhigh_spinand_table[] = {
> +	SPINAND_INFO("S35ML01G301",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(6, 32),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_NO_RAW_ACCESS,
> +		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +				     skyhigh_spinand_ecc_get_status)),
> +	SPINAND_INFO("S35ML01G300",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
> +		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(6, 32),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_NO_RAW_ACCESS,
> +		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +				     skyhigh_spinand_ecc_get_status)),
> +	SPINAND_INFO("S35ML02G300",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
> +		     NAND_ECCREQ(6, 32),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_NO_RAW_ACCESS,
> +		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +				     skyhigh_spinand_ecc_get_status)),
> +	SPINAND_INFO("S35ML04G300",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
> +		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 2, 1, 1),
> +		     NAND_ECCREQ(6, 32),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_NO_RAW_ACCESS,
> +		     SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +				     skyhigh_spinand_ecc_get_status)),
> +};
> +
> +static int skyhigh_spinand_init(struct spinand_device *spinand)
> +{
> +	/*
> +	 * Config_Protect_En (bit 1 in Block Lock register) must be set to 1
> +	 * before writing other bits. Do it here before core unlocks all blocks
> +	 * by writing block protection bits.
> +	 */
> +	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK,
> +				    SKYHIGH_CONFIG_PROTECT_EN);
> +}
> +
> +static const struct spinand_manufacturer_ops skyhigh_spinand_manuf_ops = {
> +	.init = skyhigh_spinand_init,
> +};
> +
> +const struct spinand_manufacturer skyhigh_spinand_manufacturer = {
> +	.id = SPINAND_MFR_SKYHIGH,
> +	.name = "SkyHigh",
> +	.chips = skyhigh_spinand_table,
> +	.nchips = ARRAY_SIZE(skyhigh_spinand_table),
> +	.ops = &skyhigh_spinand_manuf_ops,
> +};
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
> index bf7da57de13..2e7572d72b4 100644
> --- a/drivers/mtd/nand/spi/toshiba.c
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -18,28 +18,28 @@
>  #define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_x4_variants,
> -		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_x4_variants,
> -		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  /*
>   * Backward compatibility for 1st generation Serial NAND devices
>   * which don't support Quad Program Load operation.
>   */
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  static int tx58cxgxsxraix_ooblayout_ecc(struct mtd_info *mtd, int section,
>  					struct mtd_oob_region *region)
> @@ -76,7 +76,7 @@ static int tx58cxgxsxraix_ecc_get_status(struct spinand_device *spinand,
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	u8 mbf = 0;
> -	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(0x30, spinand->scratchbuf);
>  
>  	switch (status & STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index fc3e3855d41..a89aaec516b 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -14,28 +14,83 @@
>  #include <linux/bitfield.h>
>  #include <linux/bug.h>
>  #include <linux/mtd/spinand.h>
> +#include <linux/delay.h>
> +
> +#define HZ_PER_MHZ			1000000UL
>  
>  #define SPINAND_MFR_WINBOND		0xEF
>  
>  #define WINBOND_CFG_BUF_READ		BIT(3)
>  
> -#define W25N04KV_STATUS_ECC_5_8_BITFLIPS FIELD_PREP_CONST(STATUS_ECC_MASK, 0x3)
> +#define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
> +
> +#define W25N0XJW_SR4			0xD0
> +#define W25N0XJW_SR4_HS			BIT(2)
> +
> +#define W35N01JW_VCR_IO_MODE			0x00
> +#define W35N01JW_VCR_IO_MODE_SINGLE_SDR		0xFF
> +#define W35N01JW_VCR_IO_MODE_OCTAL_SDR		0xDF
> +#define W35N01JW_VCR_IO_MODE_OCTAL_DDR_DS	0xE7
> +#define W35N01JW_VCR_IO_MODE_OCTAL_DDR		0xC7
> +#define W35N01JW_VCR_DUMMY_CLOCK_REG	0x01
> +
> +/*
> + * "X2" in the core is equivalent to "dual output" in the datasheets,
> + * "X4" in the core is equivalent to "quad output" in the datasheets.
> + * Quad and octal capable chips feature an absolute maximum frequency of 166MHz.
> + */
> +
> +static SPINAND_OP_VARIANTS(read_cache_octal_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 3, NULL, 0, 120 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(0, 2, NULL, 0, 105 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 20, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 16, NULL, 0, 162 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 12, NULL, 0, 124 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(0, 8, NULL, 0, 86 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(0, 2, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(0, 1, NULL, 0, 133 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_octal_variants,
> +		SPINAND_PROG_LOAD_1S_8S_8S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_8S_OP(0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_octal_variants,
> +		SPINAND_PROG_LOAD_1S_8S_8S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(read_cache_dual_quad_dtr_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 4, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 104 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2D_2D_OP(0, 4, NULL, 0, 80 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_2D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 2, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 104 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1D_1D_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 2, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  static int w25m02gv_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
> @@ -80,6 +135,18 @@ static int w25m02gv_select_target(struct spinand_device *spinand,
>  	return spi_mem_exec_op(spinand->slave, &op);
>  }
>  
> +static int w25n01kv_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	region->offset = 64 + (8 * section);
> +	region->length = 7;
> +
> +	return 0;
> +}
> +
>  static int w25n02kv_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
>  {
> @@ -104,17 +171,57 @@ static int w25n02kv_ooblayout_free(struct mtd_info *mtd, int section,
>  	return 0;
>  }
>  
> +static const struct mtd_ooblayout_ops w25n01kv_ooblayout = {
> +	.ecc = w25n01kv_ooblayout_ecc,
> +	.rfree = w25n02kv_ooblayout_free,
> +};
> +
>  static const struct mtd_ooblayout_ops w25n02kv_ooblayout = {
>  	.ecc = w25n02kv_ooblayout_ecc,
>  	.rfree = w25n02kv_ooblayout_free,
>  };
>  
> +static int w35n01jw_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				  struct mtd_oob_region *region)
> +{
> +	if (section > 7)
> +		return -ERANGE;
> +
> +	region->offset = (16 * section) + 12;
> +	region->length = 4;
> +
> +	return 0;
> +}
> +
> +static int w35n01jw_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section > 7)
> +		return -ERANGE;
> +
> +	region->offset = 16 * section;
> +	region->length = 12;
> +
> +	/* Extract BBM */
> +	if (!section) {
> +		region->offset += 2;
> +		region->length -= 2;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops w35n01jw_ooblayout = {
> +	.ecc = w35n01jw_ooblayout_ecc,
> +	.rfree = w35n01jw_ooblayout_free,
> +};
> +
>  static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
>  				   u8 status)
>  {
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	u8 mbf = 0;
> -	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
> +	struct spi_mem_op op = SPINAND_GET_FEATURE_1S_1S_1S_OP(0x30, spinand->scratchbuf);
>  
>  	switch (status & STATUS_ECC_MASK) {
>  	case STATUS_ECC_NO_BITFLIPS:
> @@ -147,18 +254,126 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
>  	return -EINVAL;
>  }
>  
> +static int w25n0xjw_hs_cfg(struct spinand_device *spinand)
> +{
> +	const struct spi_mem_op *op;
> +	bool hs;
> +	u8 sr4;
> +	int ret;
> +
> +	op = spinand->op_templates.read_cache;
> +	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
> +		hs = false;
> +	else if (op->cmd.buswidth == 1 && op->addr.buswidth == 1 &&
> +		 op->dummy.buswidth == 1 && op->data.buswidth == 1)
> +		hs = false;
> +	else if (!op->max_freq)
> +		hs = true;
> +	else
> +		hs = false;
> +
> +	ret = spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
> +	if (ret)
> +		return ret;
> +
> +	if (hs)
> +		sr4 |= W25N0XJW_SR4_HS;
> +	else
> +		sr4 &= ~W25N0XJW_SR4_HS;
> +
> +	ret = spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)
> +{
> +	struct spi_mem_op op =
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(0x81, 1),
> +			   SPI_MEM_OP_ADDR(3, reg, 1),
> +			   SPI_MEM_OP_NO_DUMMY,
> +			   SPI_MEM_OP_DATA_OUT(1, spinand->scratchbuf, 1));
> +	int ret;
> +
> +	*spinand->scratchbuf = val;
> +
> +	ret = spinand_write_enable_op(spinand);
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_mem_exec_op(spinand->slave, &op);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Write VCR operation doesn't set the busy bit in SR, which means we
> +	 * cannot perform a status poll. Minimum time of 50ns is needed to
> +	 * complete the write.
> +	 */
> +	ndelay(50);
> +
> +	return 0;
> +}
> +
> +static int w35n0xjw_vcr_cfg(struct spinand_device *spinand)
> +{
> +	const struct spi_mem_op *op;
> +	unsigned int dummy_cycles;
> +	bool dtr, single;
> +	u8 io_mode;
> +	int ret;
> +
> +	op = spinand->op_templates.read_cache;
> +
> +	single = (op->cmd.buswidth == 1 && op->addr.buswidth == 1 && op->data.buswidth == 1);
> +	dtr = (op->cmd.dtr || op->addr.dtr || op->data.dtr);
> +	if (single && !dtr)
> +		io_mode = W35N01JW_VCR_IO_MODE_SINGLE_SDR;
> +	else if (!single && !dtr)
> +		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_SDR;
> +	else if (!single && dtr)
> +		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_DDR;
> +	else
> +		return -EINVAL;
> +
> +	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_IO_MODE, io_mode);
> +	if (ret)
> +		return ret;
> +
> +	dummy_cycles = ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
> +	switch (dummy_cycles) {
> +	case 8:
> +	case 12:
> +	case 16:
> +	case 20:
> +	case 24:
> +	case 28:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	ret = w35n0xjw_write_vcr(spinand, W35N01JW_VCR_DUMMY_CLOCK_REG, dummy_cycles);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static const struct spinand_info winbond_spinand_table[] = {
> -	SPINAND_INFO("W25M02GV",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
> -		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
> +	/* 512M-bit densities */
> +	SPINAND_INFO("W25N512GW", /* 1.8V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
> +		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
>  		     NAND_ECCREQ(1, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
> -		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
> -	SPINAND_INFO("W25N01GV",
> +		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
> +	/* 1G-bit densities */
> +	SPINAND_INFO("W25N01GV", /* 3.3V */
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x21),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(1, 512),
> @@ -167,43 +382,95 @@ static const struct spinand_info winbond_spinand_table[] = {
>  					      &update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
> -	SPINAND_INFO("W25N02KV",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x22),
> -		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> -		     NAND_ECCREQ(8, 512),
> +	SPINAND_INFO("W25N01GW", /* 1.8V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x21),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> -	SPINAND_INFO("W25N01JW",
> +		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
> +	SPINAND_INFO("W25N01JW", /* high-speed 1.8V */
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbc, 0x21),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
> +		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
> +	SPINAND_INFO("W25N01KV", /* 3.3V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae, 0x21),
> +		     NAND_MEMORG(1, 2048, 96, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(4, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
> -	SPINAND_INFO("W25N02JWZEIF",
> +		     SPINAND_ECCINFO(&w25n01kv_ooblayout, w25n02kv_ecc_get_status)),
> +	SPINAND_INFO("W35N01JW", /* 1.8V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc, 0x21),
> +		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 1, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
> +					      &write_cache_octal_variants,
> +					      &update_cache_octal_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
> +		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
> +	SPINAND_INFO("W35N02JW", /* 1.8V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
> +		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
> +					      &write_cache_octal_variants,
> +					      &update_cache_octal_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
> +		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
> +	SPINAND_INFO("W35N04JW", /* 1.8V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
> +		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
> +					      &write_cache_octal_variants,
> +					      &update_cache_octal_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
> +		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
> +	/* 2G-bit densities */
> +	SPINAND_INFO("W25M02GV", /* 2x1G-bit 3.3V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 2),
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     0,
> +		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
> +		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
> +	SPINAND_INFO("W25N02JW", /* high-speed 1.8V */
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xbf, 0x22),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 2, 1),
> -		     NAND_ECCREQ(4, 512),
> -		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +		     NAND_ECCREQ(1, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_dual_quad_dtr_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> -	SPINAND_INFO("W25N512GW",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x20),
> -		     NAND_MEMORG(1, 2048, 64, 64, 512, 10, 1, 1, 1),
> -		     NAND_ECCREQ(4, 512),
> +		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
> +		     SPINAND_CONFIGURE_CHIP(w25n0xjw_hs_cfg)),
> +	SPINAND_INFO("W25N02KV", /* 3.3V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x22),
> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> -	SPINAND_INFO("W25N02KWZEIR",
> +	SPINAND_INFO("W25N02KW", /* 1.8V */
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x22),
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
> @@ -212,18 +479,19 @@ static const struct spinand_info winbond_spinand_table[] = {
>  					      &update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> -	SPINAND_INFO("W25N01GWZEIG",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x21),
> -		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> -		     NAND_ECCREQ(4, 512),
> +	/* 4G-bit densities */
> +	SPINAND_INFO("W25N04KV", /* 3.3V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
> +		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
> +		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
>  					      &update_cache_variants),
>  		     0,
> -		     SPINAND_ECCINFO(&w25m02gv_ooblayout, w25n02kv_ecc_get_status)),
> -	SPINAND_INFO("W25N04KV",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
> -		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
> +		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
> +	SPINAND_INFO("W25N04KW", /* 1.8V */
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xba, 0x23),
> +		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>  					      &write_cache_variants,
> diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
> index aee1849a71f..3e1f884fd89 100644
> --- a/drivers/mtd/nand/spi/xtx.c
> +++ b/drivers/mtd/nand/spi/xtx.c
> @@ -25,20 +25,20 @@
>  #define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
>  
>  static SPINAND_OP_VARIANTS(read_cache_variants,
> -		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> -		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
>  
>  static SPINAND_OP_VARIANTS(write_cache_variants,
> -		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
>  
>  static SPINAND_OP_VARIANTS(update_cache_variants,
> -		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> -		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
>  
>  static int xt26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				  struct mtd_oob_region *region)
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 9285edd5c4b..243955ac1a1 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -19,7 +19,7 @@
>   * @oobsize: OOB area size
>   * @pages_per_eraseblock: number of pages per eraseblock
>   * @eraseblocks_per_lun: number of eraseblocks per LUN (Logical Unit Number)
> - * @max_bad_eraseblocks_per_lun: maximum number of eraseblocks per LUN
> + * @max_bad_eraseblocks_per_lun: maximum number of bad eraseblocks per LUN
>   * @planes_per_lun: number of planes per LUN
>   * @luns_per_target: number of LUN per target (target is a synonym for die)
>   * @ntargets: total number of targets exposed by the NAND device
> @@ -286,6 +286,20 @@ nanddev_pages_per_eraseblock(const struct nand_device *nand)
>  	return nand->memorg.pages_per_eraseblock;
>  }
>  
> +/**
> + * nanddev_pages_per_target() - Get the number of pages per target
> + * @nand: NAND device
> + *
> + * Return: the number of pages per target.
> + */
> +static inline unsigned int
> +nanddev_pages_per_target(const struct nand_device *nand)
> +{
> +	return nand->memorg.pages_per_eraseblock *
> +	       nand->memorg.eraseblocks_per_lun *
> +	       nand->memorg.luns_per_target;
> +}
> +
>  /**
>   * nanddev_per_page_oobsize() - Get NAND erase block size
>   * @nand: NAND device
> @@ -309,6 +323,18 @@ nanddev_eraseblocks_per_lun(const struct nand_device *nand)
>  	return nand->memorg.eraseblocks_per_lun;
>  }
>  
> +/**
> + * nanddev_eraseblocks_per_target() - Get the number of eraseblocks per target
> + * @nand: NAND device
> + *
> + * Return: the number of eraseblocks per target.
> + */
> +static inline unsigned int
> +nanddev_eraseblocks_per_target(const struct nand_device *nand)
> +{
> +	return nand->memorg.eraseblocks_per_lun * nand->memorg.luns_per_target;
> +}
> +
>  /**
>   * nanddev_target_size() - Get the total size provided by a single target/die
>   * @nand: NAND device
> @@ -335,7 +361,7 @@ static inline unsigned int nanddev_ntargets(const struct nand_device *nand)
>  }
>  
>  /**
> - * nanddev_neraseblocks() - Get the total number of erasablocks
> + * nanddev_neraseblocks() - Get the total number of eraseblocks
>   * @nand: NAND device
>   *
>   * Return: the total number of eraseblocks exposed by @nand.
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 94f324741e0..cf9b9656d05 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -26,126 +26,218 @@
>   * Standard SPI NAND flash operations
>   */
>  
> -#define SPINAND_RESET_OP						\
> +#define SPINAND_RESET_1S_0_0_OP						\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xff, 1),				\
>  		   SPI_MEM_OP_NO_ADDR,					\
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_NO_DATA)
>  
> -#define SPINAND_WR_EN_DIS_OP(enable)					\
> +#define SPINAND_WR_EN_DIS_1S_0_0_OP(enable)				\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD((enable) ? 0x06 : 0x04, 1),		\
>  		   SPI_MEM_OP_NO_ADDR,					\
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_NO_DATA)
>  
> -#define SPINAND_READID_OP(naddr, ndummy, buf, len)			\
> +#define SPINAND_READID_1S_1S_1S_OP(naddr, ndummy, buf, len)		\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9f, 1),				\
>  		   SPI_MEM_OP_ADDR(naddr, 0, 1),			\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
>  		   SPI_MEM_OP_DATA_IN(len, buf, 1))
>  
> -#define SPINAND_SET_FEATURE_OP(reg, valptr)				\
> +#define SPINAND_SET_FEATURE_1S_1S_1S_OP(reg, valptr)			\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x1f, 1),				\
>  		   SPI_MEM_OP_ADDR(1, reg, 1),				\
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_OUT(1, valptr, 1))
>  
> -#define SPINAND_GET_FEATURE_OP(reg, valptr)				\
> +#define SPINAND_GET_FEATURE_1S_1S_1S_OP(reg, valptr)			\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0f, 1),				\
>  		   SPI_MEM_OP_ADDR(1, reg, 1),				\
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_IN(1, valptr, 1))
>  
> -#define SPINAND_BLK_ERASE_OP(addr)					\
> +#define SPINAND_BLK_ERASE_1S_1S_0_OP(addr)				\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xd8, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 1),				\
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_NO_DATA)
>  
> -#define SPINAND_PAGE_READ_OP(addr)					\
> +#define SPINAND_PAGE_READ_1S_1S_0_OP(addr)				\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x13, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 1),				\
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_NO_DATA)
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_OP(fast, addr, ndummy, buf, len)	\
> -	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
>  		   SPI_MEM_OP_ADDR(2, addr, 1),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 1))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_OP_3A(fast, addr, ndummy, buf, len) \
> -	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
> -		   SPI_MEM_OP_ADDR(3, addr, 1),				\
> +#define SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
> +		   SPI_MEM_OP_ADDR(2, addr, 1),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 1))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_X2_OP(addr, ndummy, buf, len)	\
> -	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
> -		   SPI_MEM_OP_ADDR(2, addr, 1),				\
> +#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_1S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
> +		   SPI_MEM_OP_ADDR(3, addr, 1),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 2))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_X2_OP_3A(addr, ndummy, buf, len)	\
> -	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
> +#define SPINAND_PAGE_READ_FROM_CACHE_FAST_3A_1S_1S_1S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 1),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 2))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_X4_OP(addr, ndummy, buf, len)	\
> -	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_1D_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0d, 1),				\
> +		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
> +		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
> +		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 1),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
>  		   SPI_MEM_OP_ADDR(2, addr, 1),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 4))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_X4_OP_3A(addr, ndummy, buf, len)	\
> -	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
> +#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_2S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 1),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 4))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_2D_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3d, 1),				\
> +		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
> +		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
> +		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 2),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(addr, ndummy, buf, len)	\
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(addr, ndummy, buf, len, freq) \
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
>  		   SPI_MEM_OP_ADDR(2, addr, 2),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 2))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP_3A(addr, ndummy, buf, len) \
> +#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_2S_2S_OP(addr, ndummy, buf, len, freq) \
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 2),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 2),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 2))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 2),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_2D_2D_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0xbd, 1),				\
> +		   SPI_MEM_DTR_OP_ADDR(2, addr, 2),			\
> +		   SPI_MEM_DTR_OP_DUMMY(ndummy, 2),			\
> +		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 2),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
> +		   SPI_MEM_OP_ADDR(2, addr, 1),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_1S_4S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
> +		   SPI_MEM_OP_ADDR(3, addr, 1),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_4D_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6d, 1),				\
> +		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
> +		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
> +		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 4),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(addr, ndummy, buf, len)	\
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(addr, ndummy, buf, len, freq) \
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
>  		   SPI_MEM_OP_ADDR(2, addr, 4),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 4))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP_3A(addr, ndummy, buf, len) \
> +#define SPINAND_PAGE_READ_FROM_CACHE_3A_1S_4S_4S_OP(addr, ndummy, buf, len, freq) \
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 4),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 4))
> -
> -#define SPINAND_PROG_EXEC_OP(addr)					\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 4),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_4D_4D_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0xed, 1),				\
> +		   SPI_MEM_DTR_OP_ADDR(2, addr, 4),			\
> +		   SPI_MEM_DTR_OP_DUMMY(ndummy, 4),			\
> +		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 4),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_1S_8S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x8b, 1),				\
> +		   SPI_MEM_OP_ADDR(2, addr, 1),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_8S_8S_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0xcb, 1),				\
> +		   SPI_MEM_OP_ADDR(2, addr, 8),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 8),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PAGE_READ_FROM_CACHE_1S_1D_8D_OP(addr, ndummy, buf, len, freq) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9d, 1),				\
> +		   SPI_MEM_DTR_OP_ADDR(2, addr, 1),			\
> +		   SPI_MEM_DTR_OP_DUMMY(ndummy, 1),			\
> +		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
> +		   SPI_MEM_OP_MAX_FREQ(freq))
> +
> +#define SPINAND_PROG_EXEC_1S_1S_0_OP(addr)				\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x10, 1),				\
>  		   SPI_MEM_OP_ADDR(3, addr, 1),				\
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_NO_DATA)
>  
> -#define SPINAND_PROG_LOAD(reset, addr, buf, len)			\
> +#define SPINAND_PROG_LOAD_1S_1S_1S_OP(reset, addr, buf, len)		\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x02 : 0x84, 1),		\
>  		   SPI_MEM_OP_ADDR(2, addr, 1),				\
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_OUT(len, buf, 1))
>  
> -#define SPINAND_PROG_LOAD_X4(reset, addr, buf, len)			\
> +#define SPINAND_PROG_LOAD_1S_1S_4S_OP(reset, addr, buf, len)		\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x32 : 0x34, 1),		\
>  		   SPI_MEM_OP_ADDR(2, addr, 1),				\
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_OUT(len, buf, 4))
>  
> +#define SPINAND_PROG_LOAD_1S_1S_8S_OP(addr, buf, len)			\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x82, 1),				\
> +		   SPI_MEM_OP_ADDR(2, addr, 1),				\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(len, buf, 8))
> +
> +#define SPINAND_PROG_LOAD_1S_8S_8S_OP(reset, addr, buf, len)		\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0xc2 : 0xc4, 1),		\
> +		   SPI_MEM_OP_ADDR(2, addr, 8),				\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(len, buf, 8))
> +
>  /**
>   * Standard SPI NAND flash commands
>   */
> @@ -274,6 +366,7 @@ extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
>  extern const struct spinand_manufacturer paragon_spinand_manufacturer;
> +extern const struct spinand_manufacturer skyhigh_spinand_manufacturer;
>  extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>  extern const struct spinand_manufacturer winbond_spinand_manufacturer;
>  extern const struct spinand_manufacturer xtx_spinand_manufacturer;
> @@ -453,13 +546,13 @@ struct spinand_info {
>  	}
>  
>  #define SPINAND_SELECT_TARGET(__func)					\
> -	.select_target = __func,
> +	.select_target = __func
>  
>  #define SPINAND_CONFIGURE_CHIP(__configure_chip)			\
>  	.configure_chip = __configure_chip
>  
>  #define SPINAND_CONT_READ(__set_cont_read)				\
> -	.set_cont_read = __set_cont_read,
> +	.set_cont_read = __set_cont_read
>  
>  #define SPINAND_FACT_OTP_INFO(__npages, __start_page, __ops)		\
>  	.fact_otp = {							\
> @@ -667,7 +760,9 @@ int spinand_match_and_init(struct spinand_device *spinand,
>  			   enum spinand_readid_method rdid_method);
>  
>  int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
> +int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val);
>  int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
> +int spinand_write_enable_op(struct spinand_device *spinand);
>  int spinand_select_target(struct spinand_device *spinand, unsigned int target);
>  
>  int spinand_wait(struct spinand_device *spinand, unsigned long initial_delay_us,

