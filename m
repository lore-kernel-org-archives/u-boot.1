Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D85FCF3185
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 10:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47C583E0E;
	Wed, 19 Nov 2025 11:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="d7wGwdBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A60983E7A; Wed, 19 Nov 2025 11:45:59 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1337183DBF
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 11:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwKxtmVHLuBPhc58Hb5bVNSPaMYJ6/auG1a3Zq8TA9u4LuxLVXQCyU54kb41Kkbi28VETX1s2uf+wTqwOKIRW+bexmHGRXV3tLqhhAAc6SxVQVkfwIHl60pqnh+lyRcQoixXMA6W/LnFhx58mlhLaYCoRIOyMiTBx2VT2v8NL5vxOfIHBb2BfuSnMe8DWrVBVCoI40FelerZu0yeEEPSoaUEiFkCI/elEZ2w7HNEoPt+himZUnd6z85IS+HcDJPPip/Y+26MTBX4FnvV8SolGLO2hKBJL8neb+wpMko1rHs6Amiu4FAd89s8bAS6c44fGbqry4T+vASGvPwZKbMozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUQC9ItrM2PYJuVjZ7U42z1dlgitOzV1A02ogW44iDI=;
 b=uDhdO7ucOEf5uSveU0SuUL4tD9Ox4rvAZP1MxHm2QkHG15wMoBL+NP3oENGsnLo3tb7ryyH3EprQRvIwaMPBbhw1jQqLiOqgcfPxf48ujsmPRQbvsRySN1ceDye110UKhjNY6wUT0XnW0+UKs+9y2pWqJVC+LQLr5pAsqs0bFfefo8DfZnBQ9sALIr8pGLcp3X/C5OQR8rEzR4SMwjoDTiS4IIzxzNlBSRkugsKPmTZXE4lcT4E+EoCaKsus/YEZUEHuv1wnPP8oRFolpOf7wrPJr5TvCn9mZYZit/D+S1hvMV8E6q/yCCVCnF6iEJLRM7X8qDvUL+ujg3WX4ZRZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUQC9ItrM2PYJuVjZ7U42z1dlgitOzV1A02ogW44iDI=;
 b=d7wGwdBFatTQEofHchSbniu9fRCjNywcK0YexoubaPMnxgrVzeK2XEEgusXedass2EkvPgbyone3XbSs64e+7e60NdxB9wxGjIkjpWkI7CtqXOa50/EwGXWeV5Px64qs8DTIBPVJBaz3IKYpGxPfrDDLyBWzfm1ZcmiJ5G3PVrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10743.eurprd04.prod.outlook.com (2603:10a6:10:588::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:45:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:45:55 +0000
Message-ID: <bec215b1-02c6-4380-97f1-f8626b2ddab0@cherry.de>
Date: Wed, 19 Nov 2025 11:45:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: Enable RK806 PMIC on rk3588-evb
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>, Chaoyi Chen
 <kernel@airkyi.com>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Finley Xiao <finley.xiao@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20251119015554.153-1-kernel@airkyi.com>
 <bae11d52-65cf-4d8f-a51e-115a90a7444c@cherry.de>
 <208fb48c-a4b6-4b5d-a8a3-9587fd447ab9@rock-chips.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <208fb48c-a4b6-4b5d-a8a3-9587fd447ab9@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10743:EE_
X-MS-Office365-Filtering-Correlation-Id: 003885a6-009b-41e2-2be8-08de2758d0e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2pPRkUzbGx6d2lxcmVyaGR1RlExb0ErSy9GMG5rRWxBYVBYenpscGU4eUJh?=
 =?utf-8?B?TnFCYXZ3cy85NHEvR2dPUmJQMjdIYUZpWFJKU0lFdkRsOGZwMjRxQTRjQzdI?=
 =?utf-8?B?eElTZFo4dlRRbVhid2prYS9oOHlPWmdvc0QwUVRUcTdTN0JUanlhREpab2FB?=
 =?utf-8?B?NEliU08wQWdQSEtUZk1YLzZvQlhweU5ER1B0bnNpV3FmTUhvU3RFL2MxNXU0?=
 =?utf-8?B?b3EreXdqdlpOT2kyYTZXVloxZTdMbHB3QVVqZWw0NDJSenpoRGQ2T0hVL1VQ?=
 =?utf-8?B?dVZsdVhBRGo1aU5rNmljNk5tVElYTXlOQUQzWmNPSjkrS09LNkoxS3dmNmlX?=
 =?utf-8?B?cGEvM2JjTUxMUjFHdndxQmU0a3o0ZE5ZeDA1SlJheW1KUjJnYXFjcHdqcmVm?=
 =?utf-8?B?YlF0YkxRZStHclpXa1pKNUZscnZSYXkzcHB0V0E1YzlvWkRvamVGTEljUXc0?=
 =?utf-8?B?RitCSkhaU05JUDA4eFZKM2hoQ2dia1U0TjVtU1UxVkkyRms1NitrVVVGOWxZ?=
 =?utf-8?B?ZE44VXRlRmFid0ZxdmJ4a2YvdXc2Z3JlbDdSRUErbEZTZzZZd2toMUhsY0pa?=
 =?utf-8?B?aHU4cVBndlpWTG1wYTdtSHdnVFBObUZSRWVLSUE1ZjRyOGlNWHdvTVVBS3ZV?=
 =?utf-8?B?RElMakc5QWxzNkphc0NJNjQ2MmZ5MjgvdHZyb3h3TmJhREdxRGVhcnQySWdv?=
 =?utf-8?B?YmlkeW9vWnVrMTRNYlFZbU5KQ05lRnBLSzQvMytyYVVRN1ZnUFphcWd3ZW96?=
 =?utf-8?B?bVRTeTd1eXpIK1lUdkdnZEdJWWEwYWo5Ukx6U21DRy9HSGt0N0ErRzVkbWNv?=
 =?utf-8?B?WTdDbXlXKzZSb2N0ZndHZHZNMllUOFQ3bzdpeVV3T0hSTWxJNitrb0VIUzNO?=
 =?utf-8?B?VHkrV3FReVhSdWxVZzB5Zmp3dGliZmlSSlVsNUMyK3VydVE5L092enNsU1lv?=
 =?utf-8?B?NjhmZExNYkREODJUZUVVOWdMK2dzTitjaVpSNU50alZKQ01iTWpkL1dWbERm?=
 =?utf-8?B?SGtCaU1PL1hBWXpFa0NiU2cyRUNMdGtjMnFBdTljSVQvU2ZuOWQ5b2FlOVh1?=
 =?utf-8?B?YXlReTEwYmV4MisvNkhpZVlzTmhuLzVGdjdubXJkL2dUTkV6WThQT2NhN2hs?=
 =?utf-8?B?MzBBeWkzSzNNbmszUTNQZ3lSMGtXM0JIcTg0OGt3TTVtUFdyTVhLN1dXcVlU?=
 =?utf-8?B?eHRsK1J4dm1TNUpIcGNyVVN3aTVxalFEcXU4MENaQ3ZkL2ZPellJU0tUbkJX?=
 =?utf-8?B?R0lnajNKN3RpNnBaQjFrUkJBcEtZYmY0R3o1Zndkb3Nsb0piUEVyL0pJQXJI?=
 =?utf-8?B?V2JxWTBMWEtwSjVRMko5UHZpMFB6cm55SVlvRlZuNWtmenJwdVRxNDcySVFH?=
 =?utf-8?B?TXdZeGFFMjdoTUdmeWlFaUxFekVkSkJ3VkF5dExSM1UrU2ZucmFxZ2ZrUm1r?=
 =?utf-8?B?OTZVWEcwZ3EzamhPdERTVnlNRXM0a3lqSWlvS0QvYmhuZzl2TFlGZkRSWmpp?=
 =?utf-8?B?R3lMbStuOVQzblMzY2pMT1F1MDRIV1ZKVHBVOEhpM2p6NnYzSXlVSndBZGJp?=
 =?utf-8?B?SWhiYTUxekxRWHozcnFkK25kNHIvK1E5Sk9HZGdNcDBBMDFKcm5EWUZtOHV1?=
 =?utf-8?B?SDBYdmJIYldRc0NpeTN1eHR6UXN2MVRpQ0tUZDA5SkZ4bk81aUpjL1QzUUZo?=
 =?utf-8?B?Y1l6MDl2all5Sm5BaWY1TG5DRjFSMTAxenNFT25nVVZENno1UlI0WjJnT1Fh?=
 =?utf-8?B?N3cwK3JVbWNDQ2xKSDNyMFRnMmNqc3M2WTc3cXViZlBUK2UrMWliOWc4Zk1B?=
 =?utf-8?B?ZzU3UEtRQmkrVjIyTDlYZlNzUVh3cDc1Zkp0MkVPOW1tTFlUdGZXWDhkemFO?=
 =?utf-8?B?V1ZQZzRhY0pWaTl5dXRYamNpZktzaGlzclVFRHVEUURoWjAwZXYyQ3hrRXNv?=
 =?utf-8?B?Z3JyajRVeWZMNTVlN3JHcEVUSm41QkVseW05Q0FDZXp2Yjh5NEpNNFYrc2xx?=
 =?utf-8?B?R0lxQ2FQdWVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VFNjUxd3hGdmw3YmhuVE5sdFNkQmQyeHI5aHNkTkR2b2lBVC85bmVUdGRr?=
 =?utf-8?B?WTh6c3JnOEpJNWMydE4xWERSckZMMFRGeW5GZjltZmJ1RTM2Mi9TNG5sTTBH?=
 =?utf-8?B?UjhNK05kMW8rL1ZYNXFvYXBTYVF3OUJRUTBtUzdHaEkrWDl6QXFiUWpaT2h4?=
 =?utf-8?B?aDY2MGR6OHJPdElFYStPZmxYT2xqOUpHWXdySkxqRGh1TzVwbzFteWhla0FD?=
 =?utf-8?B?MEtDcEJSQlZ1ZFExM3FqYm45NUxqYXJpVnAvNGRaT09lNHdpdGVFV1VoZEl0?=
 =?utf-8?B?UlprMGoxNk9VU2FydXh0eGFlWk9zeUxyN1U0OS9lcVhZVmtJRiswMHM5K3Uy?=
 =?utf-8?B?bkZUSWdoZU0rTm9kakxSTVJUQ1JsVTk1Tkt3cFJsVjQxUnRzb2dEVEhPOWs5?=
 =?utf-8?B?WFp1NzhUT1cyZFpLcVEyb1NWMmM3cDNGcWQzbS9WbCtCU3ZHZzRvakVPQ21C?=
 =?utf-8?B?VmZmVUpLK2hRNlVYeURkblhXOWpYdEtIdkpqYXg5YXJFMkRHZTl1OSt0WFJ5?=
 =?utf-8?B?c1k2ZW9JVEpFbUt6WTBJVWdlVjF2d1g3UHFuc2QvQ3JmQlZoUnRGREJ4bWpw?=
 =?utf-8?B?UkRjOTV4VHFabEFGLzdnV25LbCtGeXExZExMMWxPSjhHZWI1LzV3WG82clIx?=
 =?utf-8?B?ZGFCVXJEMEJya2YzczRlSklIcGZ6NlE2ZVg3NGJLL2VjdG9jTkJLbWJlUkkv?=
 =?utf-8?B?MWUxNHl3aUJjV2kwMDBLbWE1dlUrZVlkZjl6bnZwcWMvRDBhYk1yKzZZblFq?=
 =?utf-8?B?ZWxtTGxPSlhXbDlyYTl2aFovaml2TGtMN0dnTm1BdjVwOFF0ZUNxWVlucEg3?=
 =?utf-8?B?c3oxQUxhR2EwUjlYbkNwR2o5dVcrcHdBU2sxWjdxcmdxY1h0bWpVVkxCckJZ?=
 =?utf-8?B?dERoWEQxV3ozRy9sbEFEUjJwNlZtZWxIZGp0Vmtxcld4dXZXeHd1aStDT1hS?=
 =?utf-8?B?bTBJTGQzd0xWdHlUbWFLN1ZXdEdPOFg0MFE2NUxBZ0duYTJkNHZsNWdqbEFZ?=
 =?utf-8?B?M2M5c2hQQXNoUjd4K1dwbmdaa280VlNvNGM0OWN1dDZES09DdGo2ZGs4bGQ1?=
 =?utf-8?B?UXJvS0JmVGVLaFpjaVJaVGg5TktrYjNNSFJGYWR4V2dsN3NmeDM5dmlFU1g5?=
 =?utf-8?B?bFI3bUxZM2hnaG1YaHlYOUV5b3R5c2ZPenJBVlNTbVZpSWJRdkZSNXRlK1dW?=
 =?utf-8?B?MkNKaG5mYWlaUzhtRUVGaWVhMGNSb1c2RE4wNERVSllJbVlVMExsRjZvbTlq?=
 =?utf-8?B?blpDU3IvOTZiT0NpUzFaOSswZzRXcjlJa3kxbW9XaUpWY3NrRkx4aDRqb2Jv?=
 =?utf-8?B?MFpVekJjNDRCZUtmZkQ3L3o3OWhON3FoekZVRjNwejkvc1B1UmEzYndwTTdJ?=
 =?utf-8?B?WERJeHRRbTNUTjhyam9HTkFEYmo1d24zWk9IMzJwWHNXRHF3UU50aEZvZEty?=
 =?utf-8?B?SmpwVDIrMVZoVXZoWDVnWGJDMFN4Sk4yYzVnN3QyZnFqRnBSVkZkWnltdmNR?=
 =?utf-8?B?cnZiMkI5RDB0c0p1Yi9iTnBUejZ4cEdsekdjamVpS0ltdmNocXViWGRIQ2NH?=
 =?utf-8?B?TzU0VEQwU2hWTFpONHoyUzU1MDY2NTZ4RWdzZzlpdWhlTElZeCt5U2ZINjZm?=
 =?utf-8?B?Q3VZZ0tsbUcyZXhWcnFLc2RZMjgxY2ppQjc2eGx3cWFpNzJQOGpGNEZzSmVa?=
 =?utf-8?B?eTJrWDVtRG8vL3BkOEU3c0pBSVZ1RVRGVmdIcWtPaWJMTlY2VTJPck9kdHNN?=
 =?utf-8?B?OStnZzNWc1R3a1FIRTV0QnJFOUlIb0d4VGtRUEVsNi8yTEpub25HUkR5TmZE?=
 =?utf-8?B?VUZPa2lhWGZSTXIvd05UT0k4dnVNaFJTSzNKano0dUFxM2pCanhQZ1NPcEV0?=
 =?utf-8?B?a2RPN2pxZ3ErSWU4R1F4SUdCSjA2eFlTU0NmRzRnTjl5ME93MU1Lc1h4U3JD?=
 =?utf-8?B?QXM4U3hkMjlsTWVRMlFIaVRNTFlmVHJnN01QNDJxNEtIeHVPaXhlOVl4Nkxz?=
 =?utf-8?B?dkxXU1Z5Qzd1L3RMblRRaE5NSFlQQnpJZ3ljQlpIeGRkTG50czZQY25ZbVl4?=
 =?utf-8?B?RFl4UHdMWjBjNnlqZ2hWMmNEelpnYmN0UmJiekRDU05TQU0yRFdwYlV4ejdm?=
 =?utf-8?B?bXhBcDFjMDJDQ1l1cTRjZnZ3cDdvRDdjaENLWisvREo2d01kMU9aR3FaWEJH?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 003885a6-009b-41e2-2be8-08de2758d0e8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:45:55.0010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uShZFLSYFO/TGkAKBEEYr81aMAWEhoFemOf9lA34tnGjBlQlZNActEk01a94Za15/iTFNEJijbU4xEj4X3w/fYyrHvmGv7REuLj0P4oXK5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10743
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

On 11/19/25 11:09 AM, Chaoyi Chen wrote:
> Hi Quentin,
> 
> On 11/19/2025 5:52 PM, Quentin Schulz wrote:
>> Hi Chaoyi Chen,
>>
>> On 11/19/25 2:55 AM, Chaoyi Chen wrote:
>>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>>
>>> Some pmdomains rely on RK806 PMIC for power supply. If we don't
>>> enable them in U-Boot, random panic may occur during the Kernel
>>> boot process.
>>>
>>
>> The kernel shouldn't rely on U-Boot doing something to work, so please 
>> fix this with upstream Linux kernel.
>>
>> Can you tell us what's the issue?
>>
>> The issue with this patch here is that we probably would need **all** 
>> RK3588 boards to have the PMIC enabled, and all the appropriate 
>> regulators brought up before booting into the kernel. It'd be *much* 
>> better this is fixed in Linux (and depending on what we're talking 
>> about, it may need another fix in U-Boot so that whatever depends on 
>> the PM domain works as well).
>>
>> Also, why the PMIC in SPL but not the regulators?
> 
> It make sense, but I haven't thought of a specific solution for Kernel yet.
> 
> To be specific, I'm trying to get RKVENC to work. It uses an independent 
> power domain. If RK806 is not enabled in U-Boot, the first power-up 
> attempt for the pmdomain corresponding to RKVENC will fail in the Kernel.
> 

I assume you tried to add

domain-supply = <&vdd_vdenc_s0>;

to power-domain@RK3588_PD_VCODEC node to model what the HW is expecting?

Doing something similar to the NPU essentially, which has a similar 
issue as far as I remember (I am not too involved in kernel development 
nowadays so I only get snippets of info here and there).

> And essentially, the operations of pmdomains in the Kernel are dependent 
> on regulators. But it seems that pmdomains driver haven't dealt with 
> this. I have seen some cases, but it seems that the dependency issue has 
> not been fully resolved [0].
> 

The problem with working around the issue by applying bandage fixes in 
U-Boot is that nobody will actually work on fixing the actual issue. 
We've seen that with SoCs with IO domains which are still not properly 
supported by the kernel but since IO domains are now initialized by 
U-Boot, the issue doesn't show anymore, c.f. 
https://lore.kernel.org/linux-rockchip/20230904115816.1237684-1-s.hauer@pengutronix.de/.

Cheers,
Quentin
