Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF835D116E3
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 02:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D82183B72;
	Thu, 27 Nov 2025 03:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tTXEM8yL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9642D842A4; Thu, 27 Nov 2025 03:14:51 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84AC783A64
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 03:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/jvPzrIuPKK9AS1C+xe652bKPHUblXheWALIivRjeBOTa07LDaoVGwIga92AbdHKL3bg/osOTigte6iFJKpOm7bO8fw2jhkle6L4sAl6IK/9p5ZNcds9TyVIpU3ogi1gytIu1YvTW0gg/ItP6bM5940sZGPHTiamQT5ttHRFn9ex6nBnCjk5RsyCKs0zxyVBGRokXpI+mfLdQh75BPEL4PaZWSuADQEEP2yW+cXeR8iXYL46sC71AZmu5CpZjEArZ6Of5A9U/TDps8Gu1R6qSbG3WhZNOY7yXONqrpFr056Imok8uNOHKUo4m7CiEQIcDWfald704d6xdkzvoDZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fi6Q81WSM1tqeJFThBdh+f/COgRzD3GCZ7LBpBuKm/w=;
 b=Yvol8SLtOFD59eD2Te7DrpbK7e5cnPyJFx6NpoLNEkjXwlBCrRQPWC84FNrelq8vfB+3QsN9LQNV4gVpUm8YioPmyXpeW/CW8qHHPGectF/53h32cYMnW9tJR4WisGUbNxMNtZYSBG81Ct1CjU6xaffoDB5/80xvdszdCqAPJodHwuYzLkdgHi6VuIZnCzIli6IiKIutMtBEgvj/Yo6TA1Vf/CsQ6XBgZKmBkTsdwxZYanrJajj1xFJiAopDnBAQoQHkuPJNWZ1J57Z/Iq6KsqT3Cue/KpKkDVz4tcL1j15ZakAXw4AqnQIdcOS3jIiZcreVwvOn7tbVEZiyTW+Tsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi6Q81WSM1tqeJFThBdh+f/COgRzD3GCZ7LBpBuKm/w=;
 b=tTXEM8yLX2vKjOpM4nujhqZmjNMH5smukm60F7n12JMXVFe0P6iG7VwailOyM5n8wdUb3/HEyMjjRRNuAspSVKt0HfGkfLsv5IgxiZCZvNkm31ABsjrtrs0AwFzMD+4RgA+7aaiYMdEMry5FqVXzAtU0V900gmbgnlRpChXs5FuGlC4Z1zIXTw5RdajtJbl6RrBUJ+XeD3vYv6B2EiT+F9SDgtszaZyVSa8Vd7J5l+ZS/jkFy4rHPpgGBdoZ2GmFrRpldafBTmU02x83gcWeavT80WidhZY3urtBx0Ixt3fL3XuP5Co+XcO1vJwn6R5OSNxv6XnLceS42C0lv9X/PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by LV9PR03MB8392.namprd03.prod.outlook.com (2603:10b6:408:366::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Thu, 27 Nov
 2025 02:14:46 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 02:14:46 +0000
Message-ID: <538f43fc-9b95-470c-ad17-5477e4effca8@altera.com>
Date: Thu, 27 Nov 2025 10:14:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] configs: cyclone5: Enable random MAC address
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-4-alif.zakuan.yuslaimi@altera.com>
 <9a806a26-9a43-4e7d-bf55-663f178db4dc@mailbox.org>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <9a806a26-9a43-4e7d-bf55-663f178db4dc@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|LV9PR03MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: e41e3bf4-bbea-47ef-1317-08de2d5abc45
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUdGZzY4K1BWR205YW94VG5XUXdCa3dETWc0dUpnRTNMOUFDUDIwZEgzYW5T?=
 =?utf-8?B?Y1JRZ2huU2EzR2pGaGc3OUlvbTErQXZKSUlqWDh0MGdtQmNtekpJYmdkQURB?=
 =?utf-8?B?SmcvUW5xamF3YUJoYm80N3UvTkNselZud2x4ZWpmaVpSSkhXS3pSTnE5dHRs?=
 =?utf-8?B?RnF6b3dVVzRhbUdsd0d4UElZazdzeG1wRGdrL1Y5NlZvWXRQVHpWZlBpVG4v?=
 =?utf-8?B?YmRXTWxZUzF0TEY2eTBURFFGdVVsV3lCTFkxMDhsUjJPT1MxaFhDUWoxTFFO?=
 =?utf-8?B?dmJqM1BBRmQrWjJlc0Z0azN2SUp2UCtoTzIvSUhmSXd0K1BFMGtYeTFYWXVl?=
 =?utf-8?B?d21wVEprSGlDbld6WFdNSEV6OGtmMEdDMGZsbGN1OGhMSnNTcHJRNU0vUGVi?=
 =?utf-8?B?eGRUZ1dwYTZEQ0xEK2ZIZWE2dHRSUGZpbWE5TzVrTEUvajRjUlQzSytaUW9B?=
 =?utf-8?B?blRvS1FqdVc2aUFtc0FJRXZtM1F4K1dOZktsbmswanRoNzZnN2hDZkZVbDVU?=
 =?utf-8?B?RUVBVXE5SnR5VUxXQmhqeXNaN0JrOTJjOVhwMEQ1MmVKYzJTbUpZQ3M0b0Iz?=
 =?utf-8?B?VFRHVktiMTZsOVRlVTVuajlTMHRqbXZteGY1dFpldTdmNkN2TWVsS1NGWGtm?=
 =?utf-8?B?QTJ1VzFQZnF6MDR1SW1DcnBLdE4yNkV3VHB0VTJnUXhNL1RETlJjNm8yVkp5?=
 =?utf-8?B?RFllQUc3T3AzWkU0ZjNNZ1FPU2M5Nk81a1pLcUZ4SlNjNFFnNmVHdTkza25x?=
 =?utf-8?B?MG1ZWUlrN2plNkNMVVAvN0lKL0pFcU1kNWdINUdKRmh4RmtuenZOcUxRcUJZ?=
 =?utf-8?B?bHo5d05qcWZGQXVpSDBKcDhIc0l1cWs2akN5a25SN0xvaHdqWEFDSkMxbTY3?=
 =?utf-8?B?OUx6ZmNDZGxIdHljNHN2UVRMMmRNcUMzYmx4WmRzZzlMQVBISjZEWkYwU1Q1?=
 =?utf-8?B?akRGbzV0a3BCcVM3RVllUXd5Z0FxMG85SGZ0blEyUVJwMjV4NU10ZlB2azFu?=
 =?utf-8?B?SVBTeHhKOUZHOVFwL2x5WXJXUDB2UGVNRmxnNm4zS3NrRmpISitXamNMRDhF?=
 =?utf-8?B?dE00akVtNXZVYTNwcTM3bXBYS2k5bmI5bE8yVTBOVFBiQzVpa0poazhyTjJp?=
 =?utf-8?B?enpJY1k0REIrSW5uUmtPOHI5YVBTYUptSzhaWW1RSmU5R29BQUVXNVBWd2kv?=
 =?utf-8?B?Qm1yM0J6V2gvTk40a2syejBSdGZjSm13c01GTjVKOXVXWmpmRldhaUR5UVky?=
 =?utf-8?B?K2xnbE5lekYvaVBqSHJOemdaTWd1Ty83VmdBVGw4d1liZlhOWFFRMTNDMjhC?=
 =?utf-8?B?VHVQRjZuTGtwMVVhRmVvQlVZN2h3OFpwNWJPTWx2am5vbDJZOVZWUlV2M1hR?=
 =?utf-8?B?ZG03VDAzNE1ZTkFRcWdoTE5jMUcvcTA3bDVPYm1INitxK2cwN1lvRVRhZERk?=
 =?utf-8?B?S1JOY2lQeHYwMkovdlhoQTgwb3JBalJnRnNsRWNwYTFadjdoNi92WWNKY2c1?=
 =?utf-8?B?bVdmaHh5NVBwdDFxckxJbEhMRlJCa2I3RXpGUnN2VldUN0pjMU1DeTNWVytM?=
 =?utf-8?B?NjZZTk5USTFGeU9Ecnk4SlcxM09TbzkvWWU2V29hYzZKZmx3MUtRTXR6SjFL?=
 =?utf-8?B?cGJaNi9nQUpCRHpsWTdVT0hxUnZ4UE1MdGRjVVhXMGZIeVRnMVh2S0tIZnN1?=
 =?utf-8?B?MUlwdGxLaUp6Skc4WmYzTUpWbmthK01BY3Z0ZnBudnFNVVQvaWt5RkhkVWwy?=
 =?utf-8?B?OGJxUjk1YjZQanhHM2w4MWdObmxZakh5b0NOVHZPUTdzWHR1Q2s1akhZaUY1?=
 =?utf-8?B?ZlM3ZU1rblM0OWh0emFHUm1NbHJJMEtnQU9hbitQN1g1M1NnMzlTbEN0RnM3?=
 =?utf-8?B?UmgzV0hiQzA0NDArbGpnOFBOMEtPVDQ0ZEwxek9xemFFdWI3Uzg2TXNEK0dp?=
 =?utf-8?Q?8zHdbI2hG+uqvL4zeHEq2av8VtTcIYOR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WitpWGJHNHAwc3ZxR3BKLzFmTHBDWDluMlpEbm84dkNaNVlCQytpVTRuMjdM?=
 =?utf-8?B?NWhwR1UyRDdNMUFIa0hpR3RMdlgrNEZiRGV4Q2pCbGZZU0g0ZWh5Y3pyaXFn?=
 =?utf-8?B?WjRVNmt2akd0ZmtkK1E4bW1uVktIT0xBV09ZWklyOEViSGVGZW1Wbi9hV2gv?=
 =?utf-8?B?NUVnVU9hdjQzeWFlSS9mMHA0ZE5aVm9yZDdOSlIzTkREMzF4T0pIZmJzckNN?=
 =?utf-8?B?VG44QUVzdndLU1NvSm9Wei80cFEzcWZxdjRINlVmMlY3eVF4c2tVcEEwL1Rj?=
 =?utf-8?B?bVRtaXp2cDM5ZFAvRFRJbWdrUkpmYUV5ODQwUTdUbWxyeEd5SEs2M0FZc3lY?=
 =?utf-8?B?RWxEd2VlTWVubzVMaUpXVGY3MkR0WXd0WXFKZ1ZRSGVydG1aVUV6QmIzRWpP?=
 =?utf-8?B?dnNUTXIwR1ltY094YVY1MEx0amFhSTQrejdveExPVWZlTUhTRy9Kd25TTUFB?=
 =?utf-8?B?ajhzUE1WQjBodmNzWEFHZFJDell4aWFlTDBmdTREZ1hNeUpIZWpSdEVkQTJl?=
 =?utf-8?B?RlZIZmpMOFZuRU8vci9zTzV6SGlacFdQQ3F2Qzk4WkJIZFZLNnRjSWliMjJu?=
 =?utf-8?B?TGJjc3ArLy9jNlNxRTdoMEFEczBPTXhRTU5wZHVUY1RORTIvMVZOL0lsRlow?=
 =?utf-8?B?UXVhYU5YL01xQmVYTXdCQTlad2lZUTQvVmtXNXpVZWJQSU1acWxiSWFnSVAx?=
 =?utf-8?B?NDQxeWlYUFVxZEFzcXc1V05aR1pIaDFwTHE0c3lTZ0pLRnlZZW52eitHUHd5?=
 =?utf-8?B?TWRRdGFuYW1URm81a1AxMGJyZ0NONDJhSDU1WERIbTJ3OTVrK0JRTVNjbk42?=
 =?utf-8?B?MVJsYkhQbHF2RzhndzlDTmF0UzRpRkVVUjljVERzN0dqREJMOXVjazZVeXpy?=
 =?utf-8?B?L0p0OU9jSG1TS2MyMHQ0Z2puNk1GbjNjUDZaNk90d0pnMzFjTjVRSGJMNS8r?=
 =?utf-8?B?MWVnSkxkQmhFVUY5SS8wNTY2dTduUWZDdmN5Z2YzWnpWV2MvYzdPUnByK0Zq?=
 =?utf-8?B?Q2dPRFFqL1VYaGdBWUorUkZzdVQvTFpVSjRpSDJzSlErWmxsVG1wb0VaMEkr?=
 =?utf-8?B?YXpRc2dObUxyK3o2a2tuV1RDSUw5cTVyQ3FoMFFNdzUwdE5leVpLc2tpMStx?=
 =?utf-8?B?dnFhSEhiSHZHZ3BHM2R5V2V0UVZKM0N1WEdWbng3MVdjTEE3eDhsVFNJbUlJ?=
 =?utf-8?B?T3orU2hnRGt4SWk2a0hHcGQrbTNMUXUzTTRPNVFvY1VCTHlBQjJsUy92R3BJ?=
 =?utf-8?B?akI1OFkrU05VaUQyZmhDcHdpZVFjb0haV1duRVB4cUhnVlMzakpWeldFeElM?=
 =?utf-8?B?dGhNODR0ODhuVEh4ejFybk9iaXg1QnVYTmQ5eXZ5UG5UM3J2bzI2citVK3dt?=
 =?utf-8?B?Z3lteVM5NTErMUNFVmZkSWlxU0pwWkNBOXljUVUzck4zbGJuY1FxTGl1Tzla?=
 =?utf-8?B?MXVpOFJNUWFWZy9PRWF4ckpIRmJoMUozZWQ1bGkwNzlGYURwTDlVcnJNMTBS?=
 =?utf-8?B?dEZuQ0N0QXRBZDh3eE1SYWtjN2ExVmdnciszam1hRzlNVERjNW5UVi9yRGpp?=
 =?utf-8?B?TE9rcTNRdVYwMmR6clhrVE56cWRJODI5YkQrRWVhTkZyd2dRN3Z4UGF2SVdu?=
 =?utf-8?B?QVZTMWpzQ2M2cFVFSk9CWG5Ocm5wSmdkVW5sRXBUaHU5RU4valJ1YSszVUgv?=
 =?utf-8?B?L21WZytJcGl4OW94R3hITHRna3RYSEFFeGsvK3VwdGN6SWVvY2dtOUVQS1Fm?=
 =?utf-8?B?Q3VRaWhQT1lHZm5mamg2Znk2b2NHTjBRTVJaYXNHdEUyckRpa29lTzNQeE9E?=
 =?utf-8?B?SDJLemJvM0Q0bEtMUklqcmtPV0plY095UGtHQWZpZTd4SXNPc2dFaHFmd0hB?=
 =?utf-8?B?MTNSM1dTdmZZcXlXRlcyWEtqUG5ROHEreW52N0dWNmI1bzBhWW95U29rczJx?=
 =?utf-8?B?WUxtTHhHSWlWSm82elhKUTBBRTNQNm1MWnRrTldUNlRTSDVmSlFJZUxJR05n?=
 =?utf-8?B?bXVqTEhJaWJzYkhQSjJwek9ZVnhpSVpQb2k3eUtIVEgyd0tLc2t4R29QOTFw?=
 =?utf-8?B?eTYybGtyQnRvRThoNEFLSHNMMnBqdENMWkFNUktLeXdvbzQwdEtJZmYrVUZz?=
 =?utf-8?B?ZDhWc05OUlV2QVIzNGxjQmxZMyt4R0VETCtQTlQyMmNPRXZrc2puSTFGVm9O?=
 =?utf-8?Q?6PCZyQzGtRxCOSZt13NR+jg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41e3bf4-bbea-47ef-1317-08de2d5abc45
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 02:14:46.5106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xec35RYYspR0jYnyQg5kjC1xR8NwSeBwu8/hi/xP7tcmKJPnvSRMNLCz38tKh7A7DSRRj7pNm1z9Rtii4+cWEHFIpuBQs6dVebozNY9duXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR03MB8392
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

Hi Marek,

On 25/11/2025 8:23 pm, Marek Vasut wrote:
> [CAUTION: This email is from outside your organization. Unless you trust 
> the sender, do not click on links or open attachments as it may be a 
> fraudulent email attempting to steal your information and/or compromise 
> your computer.]
> 
> On 11/25/25 9:13 AM, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Allow random MAC address assigned for ethernet initialization in CycloneV
> Why ? The commit message should always explain the WHY .

Thanks for the comment, I will improve the commit message in v2.

Alif
