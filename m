Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C76C5472C
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 13:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 693D388914;
	Sat, 24 Aug 2024 15:27:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="lOXsWdz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7795A8888F; Sat, 24 Aug 2024 14:30:50 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26C188997
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 14:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcqaaWLHQMGZx1pJ8bzFAXzeaV4U0/s4BxjdjZMSy9jq/KFM/ExOJkEOeoXRD8VN64B59aBbG06kF5JkunNnT2UAzVz5YgK6dtzHhzbIFZHWd9CBCBajbiLfrWP8j2g7HQE6a0pGoEoNvnyFWeJU6oI6rp1QKvArXuaUXFvufUbrWzCFTCqOPwPu0sN39ZVMQxEvclx78t90mF6ObTA9VtR70d1muO4w9unzCfKxLUr3vh6z/mvgqw29MDdk9EBvr2gWzMiBRupixXRBuMgPPQWi5vnnSr0aZAqSkmWRmXVITgR2Es1l0LfLCNMamkECUrI6l8Bg1TMv5+1FMUojRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pubHgJ2xwAvb9BvdH0z3P3SGU4VchJ37jJpKs0MRSXc=;
 b=nYWmcA8YCUiT3T9+6g8e3ZwVjPTJ0tqgF0M1V5uLhp8cRtCUFpGye05dAIb4iWeiCu+FDVUNrKECAWgp8jgTeu7CYJX2/2rNcT0RuBuL48Z11cwc6oux6xjek8JQFo3UOTuWiygymCkBeHP08DghR2i0nctJZvyQO0jaBujqRHmPt7pqBsPagICRVHN74gvVLLgHYzzHGECth5ormWVRAetQcreYz2Hj5hnY+FOmojxkYtWnAAlXVV/g/aJaNTlXOamtvfpIGuYJadrrJs2Eqj8k8uMCJAiSwuuZx0UcWTKfaQddIGgOh4jtI7Cg4h3uKR7gCnatL03Qa0HQpsFxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pubHgJ2xwAvb9BvdH0z3P3SGU4VchJ37jJpKs0MRSXc=;
 b=lOXsWdz7xgaFFpJK1TRC9mzXcaONMoWzL/oevM4hpZLb39+dR8TYbUsq4+ZMZO9jC0se3b/M3qh7BXD8TnQzhxf91gyvbmyu/QC7gxff805+x4S0GUfl1bN+of9tnOMuvtshcTbldtVnhyzwY/YadZmCoiTFPzcKZgB7wrzSE1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB7765.eurprd08.prod.outlook.com (2603:10a6:20b:521::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.13; Sat, 24 Aug
 2024 12:30:44 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 12:30:44 +0000
Message-ID: <c77f2748-129f-4307-9bab-8691da69b0b9@genexis.eu>
Date: Sat, 24 Aug 2024 15:30:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 7/9] net/tcp: simplify tcp header filling code
To: Simon Glass <sjg@chromium.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-8-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThroMFX-+G5r0uhkVsWwO9GWtK4qVZPTzx-2fiu+YLd2g@mail.gmail.com>
 <b7c9d535-9295-4a6b-9b8e-a62a123bc1fc@genexis.eu>
 <CAFLszTgFXHoWjdeZ+Ze_vpvRpA4B1C=zpsKzJsMtuLkzH_HFmg@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszTgFXHoWjdeZ+Ze_vpvRpA4B1C=zpsKzJsMtuLkzH_HFmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00011B51.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a5fdb5-ca6e-4ca8-6e1b-08dcc43892df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGptWnAwRkVrSE1vS2RhUmxsTDRTVVJzZG9OSjlOQkk0eTdPb2FxOGhGVlpF?=
 =?utf-8?B?NjYxSkJUK0lwTklPYlRQeStXWThDT1Vzd0RhWG43engvMy9VazNnNmZpMDJW?=
 =?utf-8?B?SU4zVzVKUlF4MU9aclhyYTFsNGxBQUFDK2VXa3FhcnFraFdCSHBVNXA3YSsr?=
 =?utf-8?B?eGdpZUdlUlgveGljOTlJd0ZVbUpUNm9La1NGanpLYi9QdUZuSVN5a25YU0k4?=
 =?utf-8?B?NDZ1RGloUzA1c3ZhNTQrbjNySStseW5qWDNiZzRzZWFYSHhJMkp5ZEZkMEtU?=
 =?utf-8?B?Tk55UTVwU3VDZE1wVThtQXdienBiL0p1a281bmRXVlY4UFNRclVFYVVJQzZj?=
 =?utf-8?B?RGdVbFdWUDAzZ0F2U1BJTk4xYVd1ZDdIUkZ0dFQzZUNVTkFDNE8zS2tobU9T?=
 =?utf-8?B?OXVyMkFsNVdTdUpuQ1NuUzBHS0dNSUMwT0pVaWszN3c0bk1sZk9IMFRHRDJk?=
 =?utf-8?B?M2lBS1ZLcmpWNWdSVzIwaThPa1pMZFFBcU03Si9DMjBhWTY4K1QvNmFmMU1m?=
 =?utf-8?B?dU5xTm5mbksvTGNlaVlkeHI3UjBzdFkxNkxLSnJTblZZendmMXZSK1RkcWJ5?=
 =?utf-8?B?aUxDYjFad0NTOHlzZlBiNjBrcXhFcnJPSEhhZ3Q3RmlVRWUxY3M1bmNtTzNy?=
 =?utf-8?B?OWJWUS9kMkQwbVFlY0dkcVpKQWhUaW5ZNm9tVU55Y3hIK2Zaakc0R3VYSEQz?=
 =?utf-8?B?Ry8xcUltMXFHVDg3dXBPWlBIMEpWTFBPUXlONDcraXBmRjdaaGNmN1pOcTAw?=
 =?utf-8?B?ZkdqeDRxUFR0U1k3QlNkMTgzT2pYekhCb0xkRWNZL0FkN1E3MjU0V3FZbjhp?=
 =?utf-8?B?dmZROTdHNkVBZ3VDQ2RzdW4rWWY3Q1V6UitFbit6UW9PUVdtZkpURnVrSFNB?=
 =?utf-8?B?YjY0a1RNVkJIWG52NXhWbWZlY21sZmY4eHpMRm1VZXNqWTN2bytXZHVMWGZk?=
 =?utf-8?B?TkN1bmM4cjI4R1l0RlRuZFpwWXF0N3llVkhFc2pDcE4xRDVTWitGK2ZaUmw4?=
 =?utf-8?B?cjBGcExSS21MUkxxalA5NTBUejMzN3FLUkhwaGdzMjBDTmlKdW1DdnpqR3Iv?=
 =?utf-8?B?OHpkMndXSXFPMzNENm1ablB3clFHUVdDMUIyd29DVkhBRUM4RGdXSWlFZTcr?=
 =?utf-8?B?cGZIaDhkdFI1TjRJdEJ6dmNYellSYVBzRHVoZlM0WW41SWFUMEZrOFFwT21w?=
 =?utf-8?B?TnNIMkJDMC92MElRUHE3VDUzQXdzb2lIZzZneXNtb2d5cGVaWjVwYmhSY292?=
 =?utf-8?B?OFBXMjBZYmpLT0t2Uk1PT0wrSkUwUldMQ3NzY0ltV28yYkZoK005TGJXNVNJ?=
 =?utf-8?B?Wm5Ca0tZSmF3NHU1NzV5QjQ0YVArMXREWVcybEc4UjZqakVUVnVNNHBMV0lj?=
 =?utf-8?B?T0xlV0lEV1BtdDNmR0p1MkZwYmIrdmtxUVdCV1p0NlB6MVdDazRnNElvZlBW?=
 =?utf-8?B?aUZsN1BmbEc2V0NaYUFBUkdETGc5NFZVYkp6dGpnenN2cTBXOGkwdmR2S1BT?=
 =?utf-8?B?djlQTStUU3Faem5GbXE3MXZ2THp1Y2tiaFdNTnBsS3FFZWtMelFFd1NZS3Zx?=
 =?utf-8?B?dXllU1ZHbURPcG9sTHduQ3Vsd1pmOHpVMXRrS1ZodEFRai9zNWJobFV5WURI?=
 =?utf-8?B?dW5UTlNvT3F2cVlySTBnNHp4aVdORzJoRmc3Rzh3VzhGempHSm9uOHhvTjdo?=
 =?utf-8?B?MVlCLzM4dE90NGtPL2dUSTQ4Uys4Q3c0V0prN0FzWEFlWGhKa1dENDRnK2ZW?=
 =?utf-8?B?ZHJtb2I1d2J2MHdSVFhob3czM0hGTWZ5ZkZRK2wxNnBIaE10UG9hLzV6WFl0?=
 =?utf-8?B?S3RleHZTcE9JeC94ekRmQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURZQS9OMW5STG9hbm9KQ05wc3I1MzhPa2szZmR3NUdoUU9oUGloTFExOStt?=
 =?utf-8?B?Qm9WK1pHU0ZKdm5kaWJlWnRVRk1nQm9QUGdQaXRnK1AzMFV1Szl0WWJmdlFH?=
 =?utf-8?B?cDRoeXRHMjdwbDRCVGcrWXE3ZmNuU2h6NXJzQjVzWGszckE2dWZlN3VCcTd0?=
 =?utf-8?B?SXpMZkZlbTFsVGZMZ2VmalRGM3JHY3VpOFJGR0VBeSt6bjhJL2IvU2g3OHc0?=
 =?utf-8?B?UTBtdFlWbzNWakg0SXBuVWcvNFl6bG9WRnRGSExqZm8xbWgyN3REWDIzelZi?=
 =?utf-8?B?U0I5VHlGdUczWEU5cVRmSk5sb0MvRkhGbkJTTjJ4a2VEM3BTNWhaZVFMYm1j?=
 =?utf-8?B?REY2RWtkWFVVaWFTL2RZcDdua0hzQURCZVpTMDJROVdDclRoSnNJTXB5WUU4?=
 =?utf-8?B?S1ZwRUd0ckg3WmxWdFFveHB4SnNnKzM3dzVnWmxEU1l4M0U1dEhsTkhEbUVr?=
 =?utf-8?B?Qk44aTl2bzFFbFR0Y2M0NzBYVXV5Q2hYdEFYRUg0eGhhRC9QVTFHUHlwWHM2?=
 =?utf-8?B?SzlKTG9BSEhKN00xWitGcmMxcVZ1ZjMrb3lFeDU5bFRremY3REoxVkZMRkc2?=
 =?utf-8?B?S3dUZFBDVXVEb3pPL3RteDlvSE5OclhIM2QrLzM3Zk5VQnk2d2lYcTlHVGxV?=
 =?utf-8?B?RzQ0RW1rTWlTWmw4L09SMGk5cVRQemZpTGt0OU9vMndhdjh5Skg1TnFTMndo?=
 =?utf-8?B?NHloOGRIdGEvTkM0NlExam5xdU05N0FHTGdQcFJ2SUJydkFxdHgrT1phdUlJ?=
 =?utf-8?B?bGpOamdWRnBkc0N4SVJ3QS9BTmR5cUlINUcxd3dmVUdadkovVVdvL29KMDFy?=
 =?utf-8?B?WUw0aXYxbGVMUmFVUHNsRldrVXJaeWF4THdxbzdLWE1ZRGhZY1JITnErWW9q?=
 =?utf-8?B?OUlyWCtEU2FxRjAzTmNPeDk5TElJSDR0SnduOVEwR0ExeVllM25sVHNIZy94?=
 =?utf-8?B?MUhJMnJUeVFuODh5dlY1QzdzN2E4VUhZcjVBdWg1d0NBQ3RMdnIyY0EzdFR6?=
 =?utf-8?B?UGwwa2VkSzg4ZlFTYUtEWlFiTGgxWnAyUEIvVysrSTBaUDhaOHZGNktXT3FM?=
 =?utf-8?B?bldoNDI5dnpCRmZyemV4Zm9CU0Y2NHFnc0xpS1F6ZmxLZ1ZIekJKOStibmZr?=
 =?utf-8?B?TUgzQzFlZTZHcjdSemFQaEN6TndhWU5QUG84Q3A0dE93dXVia3hGOWNvU0po?=
 =?utf-8?B?ektTVGpRQ2ZXbklldXpadGtwN2laQy9EbERTUElLTFdZTkdCRVhhTXAzYlBv?=
 =?utf-8?B?RHhjMTZzanZlRnF0ZDR3dk1KTDQ3YzBHeUpCQzRVK1ByWlY0Wkp2eXJJQTVB?=
 =?utf-8?B?dExOQVY1cXlzTzFqUVFlanRHTlc2MXorcTRQOHgwUXdMcTVwWkhyemxtTXNV?=
 =?utf-8?B?QTNqK3pSSmpYem5pNlhyYWxlS0lCaWxVa0JIZDRlKzhmay9HU3JrWkJ4SVFN?=
 =?utf-8?B?SlphYld6WlQ1VFkxc1VjRnlYTUVkcGtVQkFKWXpJRm9JVC9CaFlqTG9KQXlC?=
 =?utf-8?B?WU5mUThMZWxibDJoRkZqcGliaURWRkV5d2JXRVJsdWRjNlNGc2RYcEJzSi9j?=
 =?utf-8?B?bTFwNUxKdDNpa1BLSE9OVHJqWkFRMEhGTVJmR1ZXL3BQaG9vcEJaY1FZTjZv?=
 =?utf-8?B?bXNYWUowOXFNQklyV2NsSG5mdC9ibFF0R1QrMEtEMlFGZXRlZld5blp5VFZW?=
 =?utf-8?B?YVFqWW5ueFlqZ1RsNHk0b0FhQk5BTTkvZFFUVldOM0Ziem43YmtDNG1GNkUz?=
 =?utf-8?B?WjRaSDNoeWhuWmNKOUtoc25nNGQxN3U2TFIzem1tNWpTK2Zma3hHZXlEVmpD?=
 =?utf-8?B?UndRNUlndTlmNXIxbUJ4aTl5dUVnTEwzMFpBZW9wbmxWQVBEdlFBMzYvLzFk?=
 =?utf-8?B?ZmxXbDZWcXkrNDVPc2hxMUxUZ2pSN011V2NoTWJRbFd1ZXBmNEtLT0pYWllM?=
 =?utf-8?B?T2dRWStCZG0zTTFOSTFZSU1URUNyS29hUmVUcUQzdkhERmFzcW1EeklCTE5C?=
 =?utf-8?B?YTd5VTY1c0tnUXhQUWlZK1JNWGpsNVdjSGlCd1lvQ1B1OGtFU0c5L2NpeEVQ?=
 =?utf-8?B?ZGtIMU1DbUJSdUh5aC9WRmlXbVhDWmJPT3hydVIzM0VvWldUOUVTQkpRS0hF?=
 =?utf-8?B?YzJUODhTT2tDcHZONEdacTk0YmQyVnVmY2xvd2dGNk1XVXBSU3FuRUZVMVNw?=
 =?utf-8?Q?sGs3DaWrjdb9+EwblpaKUG8=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a5fdb5-ca6e-4ca8-6e1b-08dcc43892df
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 12:30:44.2772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWL2oSojV3/WwK0aSTZAO6QIqs7WNXIahcXPvqLyRUcmDczrpdEROIvhoyBxk1fWOitTIAYoq+0M8MzvBgstRUJCoBYEKR5K6hQXbYRho0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7765
X-Mailman-Approved-At: Sat, 24 Aug 2024 15:27:30 +0200
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

actually I know nothing about sandbox emulator


On 23.08.2024 23:47, Simon Glass wrote:
> Hi Mikhail,
>
> On Fri, 23 Aug 2024 at 09:12, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@genexis.eu> wrote:
>> By the way, I'd like to know your opinion:
>>  * should I add a sample implementation of http/1.1 compatible
>> web-server to this patch series?
>>
>> This can be used as a base for other implementations like firmware
>> upgrade web-server used by some vendors.
> Do you mean using the sandbox emulator? Yes I think that would be very helpful.
>
> Regards,
> Simon
>
>
>> Mikhail Kshevetskiy
>>
>>
>> On 17.08.2024 18:58, Simon Glass wrote:
>>> Hi Mikhail,
>>>
>>> On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
>>> <mikhail.kshevetskiy@iopsys.eu> wrote:
>>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>>> ---
>>>>  net/tcp.c | 70 +++++++++++++++++++++++++++++--------------------------
>>>>  1 file changed, 37 insertions(+), 33 deletions(-)
>>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>
>>> nits below
>>>
>>>> diff --git a/net/tcp.c b/net/tcp.c
>>>> index 2c34556c26d..7014d5b4f43 100644
>>>> --- a/net/tcp.c
>>>> +++ b/net/tcp.c
>>>> @@ -527,10 +527,37 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
>>>>         b->ip.end = TCP_O_END;
>>>>  }
>>>>
>>>> +const char *tcpflags_to_str(char tcpflags, char *buf, int size)
>>>> +{
>>>> +       int i = 0, len;
>>>> +       char *orig = buf;
>>>> +       const struct {
>>>> +               int             bit;
>>>> +               const char      *name;
>>>> +       } desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
>>>> +                   {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}, {0, NULL}};
>>>> +
>>>> +       *orig = '\0';
>>>> +       while (desc[i].name != NULL) {
>>> try to avoid comparing with NULL or 0
>>>
>>>> +               len = strlen(desc[i].name);
>>>> +               if (size <= len + 1)
>>>> +                       break;
>>>> +               if (buf != orig) {
>>>> +                       *buf++ = ',';
>>>> +                       size--;
>>>> +               }
>>>> +               strcpy(buf, desc[i].name);
>>>> +               buf += len;
>>>> +               size -= len;
>>>> +       }
>>>> +       return orig;
>>>> +}
>>>> +
>>>>  int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>>>>                        u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
>>>>  {
>>>>         union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
>>>> +       char buf[24];
>>>>         int pkt_hdr_len;
>>>>         int pkt_len;
>>>>         int tcp_len;
>>>> @@ -540,55 +567,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>>>>          *         4 bits reserved options
>>>>          */
>>>>         b->ip.hdr.tcp_flags = action;
>>>> -       pkt_hdr_len = IP_TCP_HDR_SIZE;
>>>>         b->ip.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
>>>>
>>>>         switch (action) {
>>>>         case TCP_SYN:
>>>>                 debug_cond(DEBUG_DEV_PKT,
>>>> -                          "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
>>>> -                          &tcp->rhost, &net_ip,
>>>> -                          tcp_seq_num, tcp_ack_num);
>>>> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
>>>> +                          tcpflags_to_str(action, buf, sizeof(buf)),
>>>> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>>>>                 net_set_syn_options(tcp, b);
>>>>                 pkt_hdr_len = IP_TCP_O_SIZE;
>>>>                 break;
>>>> -       case TCP_SYN | TCP_ACK:
>>>> -       case TCP_ACK:
>>>> -               pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
>>>> -               b->ip.hdr.tcp_flags = action;
>>>> -               debug_cond(DEBUG_DEV_PKT,
>>>> -                          "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
>>>> -                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
>>>> -                          action);
>>>> -               break;
>>>> -       case TCP_FIN:
>>>> -               debug_cond(DEBUG_DEV_PKT,
>>>> -                          "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
>>>> -                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>>>> -               payload_len = 0;
>>>> -               pkt_hdr_len = IP_TCP_HDR_SIZE;
>>>> -               break;
>>>>         case TCP_RST | TCP_ACK:
>>>>         case TCP_RST:
>>>>                 debug_cond(DEBUG_DEV_PKT,
>>>> -                          "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
>>>> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
>>>> +                          tcpflags_to_str(action, buf, sizeof(buf)),
>>>>                            &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>>>> +               pkt_hdr_len = IP_TCP_HDR_SIZE;
>>>>                 break;
>>>> -       /* Notify connection closing */
>>>> -       case (TCP_FIN | TCP_ACK):
>>>> -       case (TCP_FIN | TCP_ACK | TCP_PUSH):
>>>> -               debug_cond(DEBUG_DEV_PKT,
>>>> -                          "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
>>>> -                          &tcp->rhost, &net_ip,
>>>> -                          tcp_seq_num, tcp_ack_num, action);
>>>> -               fallthrough;
>>>>         default:
>>>>                 pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
>>>> -               b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
>>>>                 debug_cond(DEBUG_DEV_PKT,
>>>> -                          "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
>>>> -                          &tcp->rhost, &net_ip,
>>>> -                          tcp_seq_num, tcp_ack_num, action);
>>>> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
>>>> +                          tcpflags_to_str(action, buf, sizeof(buf)),
>>>> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>>>> +               break;
>>>>         }
>>>>
>>>>         pkt_len = pkt_hdr_len + payload_len;
>>>> --
>>>> 2.39.2
>>>>
>>> Regards,
>>> Simon
