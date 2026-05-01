Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDD2FF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 07:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 350C384099;
	Fri,  1 May 2026 09:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="IeWNMAva";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 898EA84099; Fri,  1 May 2026 09:40:02 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28BD080086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMlne9NPw7QUEgOHokaqpCub/0cXj32prqwTAg1Iiuzfc+dlqQMMVsbrGiQmZghXKxXDuCMVInEwwkbbSsEhMsSQZmuM7tvf0d1Uj6FQBFNtR1X0TKaukeioSbyw2Is7V14/ii9HCFnJB5ehYNXKPoBVRk0C5t+vTe4jAUcNXNtnvCRvMDLADD/gsXRpzwDSFrKlTYSrCZhRkN4AXnAQUjYtRfUnourxT15qWwkoH3wjqmXkHzPpmn88IHADSPgM8WkNDsQJEdlsa5jL5N1R3LG77NmJmfkUHLHcQ1nd09QevS/YL1AlKIMBk5b+Gjhq3WN5GqYyFeaylYhDIvgPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTz5C2Xov+g6K2GA7oo82z1k1cTtm4xQGv48zbBxpXQ=;
 b=ep9Fz935wfJ0BPcfvMWE00cyRzoCD9C+E/QWk6mUlqzWhHXfWNlYn0Avv/f0dY5c4njrLEHSfoj4to+BSn4TX6p4XGd9Uwyv/voYQqqw/+y+5L861uu5gI/i+h+qaU1lK+FJf2+vFNyICy6EnauNRRbH3KsafpGHfRjQP4EEnps7q4pSqwl9TfXtdS9OUd4KRqBqka+sy6w3pMNPoNy8YC6EARursdPW7g4Z/MlpZ7S2KtPwTL5zagaRtVw6CmnRq+zq8obbRzkaIrOr6+rlJ/Lg4xzk1ypeSBd4N/whaf6vRfZMt8yDrd/0w7SkqcNoECCUcqkGVIF0USLPYhWppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTz5C2Xov+g6K2GA7oo82z1k1cTtm4xQGv48zbBxpXQ=;
 b=IeWNMAvaiTOae/+sYlFmDVgzMULbgZ/igZTWsxGsH6i6HtN8Py+T0F9oPbfl82xsqJhq5YHDZc3801avl388wYkHYMBi0Mv3YjLwz8Elj3NgtS4LDEJhv6f9NZiND4UqATb7zhZ7ObDU8SKm5dgL5wf60waC7AX4YeOY5OxVFwQr38WhM40a8CN8vRAYAn6D2xdlXmtwG0Uu3w6JOvxrik4x0xYqEg8n+G4mCaKhsHqGIVGAXFWhfy7sGSubC711j4MtT/om8MKFlW9iaZITcNClLgEYSyyYfKEPTUUZWcyrKM3NZqMIhmCKPKmsavLhJ5LELf2IL4tEDjW5G7sxQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7185.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:315::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 07:39:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 07:39:55 +0000
Message-ID: <07b731ba-adc2-4538-bed8-02c12eaa1936@siemens.com>
Date: Fri, 1 May 2026 09:39:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Add FIT multi-DTB selection for Qualcomm platforms
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sughosh.ganu@arm.com,
 ilias.apalodimas@linaro.org, gchan9527@gmail.com, mchitale@ventanamicro.com,
 maximmosk4@gmail.com, jonas@kwiboo.se, marek.vasut@mailbox.org,
 quentin.schulz@cherry.de, peng.fan@nxp.com, sajattack@postmarketos.org,
 balaji.selvanathan@oss.qualcomm.com, wolfgang.wallner@at.abb.com,
 e@freeshell.de, yangshiji66@outlook.com, funderscore@postmarketos.org,
 hs@nabladev.com, kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <d786d7a7-0601-4680-aa73-96334ccad320@siemens.com>
 <afROIxgv7NYnXiF-@sumit-xelite>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <afROIxgv7NYnXiF-@sumit-xelite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: e177121d-27a2-48fa-2af3-08dea754d699
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: A/I6Rna2vEJHP0v+PQ2joMLdpuhkw7hsMptBQ4tnyBA+SlNmT/M51GpDc6YetLkj8PRtJ46qFb/icNxztB/sOpDYACNnRabOzEJTIJVFbkbNXQR+1LA0lipg0mmo7jiW9PlF4UAzRKpCo8QD4SXWBEDefCZnypLhSpF5vhvVDy19LrIlUhXH/WYQwRhxdZUGpsxWgsX6qggziEKZwtD8unqiOGXrB2EmJ0AWhPZ2rvzON8k8/XDS0TK5M/Yv39yqN6RtEqjFCXEsdYsZZvHJYHWI2Wd96T86IOtsF8ocImxBetWgglXF4ZCE9zI0ElOaF6/oSJBQJwFGirCK8pX/498/P2l1uUD8Sst7MgW8Sl1NhEQ4AUxTjFGaZy+nyRmbE3wqyPNNiILFda9U7g+JjX+c8s/Kt1zDdNVLwl0ccIb87MzzZUxCmIdcCMbUZAW0T5fD5oLyEeq1Wqf++6bVHjXpCdue6Sf9V4slWzZTIaJfyWLOc9dALaDqn11Sbe93oTWfJDET3OZFvn4gEkwR6NEpJuPEWGBOED6eCm0BX/002ogX+J+aAYLqInAj5iXuoszwvnKnPp2dFEQgJpnf5GFhHJjnXfALfclavaDBK3HbzDOC1bnelHlbMa+irnDyB7WUT0RV3F0cOKxxCKcTYOo8F1tirKhh4Jk4crJAFDLgcGmZKAXPVFCx8foLTfIJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(55112099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlR4c3VLcWxpRHJwWW1kRk9MbFhjU0xVVEQwM1NFejZkZVpKUS9HSnJNc3l3?=
 =?utf-8?B?b1ZrWUdRVS9SS2lyL0p6UjUwcDdtWnV4SnV0S1YxNnVwT0k0ZWJWeEhYUzht?=
 =?utf-8?B?blIzNHBtZEZWZWpjRkIxOFRSZHdGUXBvYStuU3BBUFdGYlkxbGVKaFpyNWhj?=
 =?utf-8?B?NHpLa2RLdmxjVHl0ZEhwNlhDRDUvQ3A3bi9MMUp5N1VRZERjdnRZSmVhU3p1?=
 =?utf-8?B?V3BDTWlJUVFhU3JlK0ZCMkJ0NTZWbUNLazR2N2dOdmZJeGJncSs3QUJieGdo?=
 =?utf-8?B?dEpBMU9LNndwalM0VU1zbTVHVEttVWVXRmU0dDVVN2RxUkx6MWowRm8rMEFj?=
 =?utf-8?B?bFlLRHZkMENzV3pnNGpOalFxbEs3VklwRHVWdXh0UE9GUjJkdmJKellRYTE1?=
 =?utf-8?B?TDZCOHpZTmNSeDVXYTQ0NWgyTis5VlBwR3BpZTBCTUEzVit1RmpBbWlQN2NW?=
 =?utf-8?B?M0JoR0Q0MVNFV1JpcjJEZVZxUkdvY0RJaE1pTy9pbElkTEVLRE5lR2JJVVl2?=
 =?utf-8?B?aHFoUTd6RFBFaWlYUEdOeVRuMi92ckxaQXR4UTQ1YkV5d1dXaEFpenY0bjda?=
 =?utf-8?B?NlJrT3NKSHhjLzZxWkQxS3gvNlhzeWZBV3hFWGZDcU5rMzZDUi9HREIxeG5X?=
 =?utf-8?B?dExaVS9XTDUwSkFzdFBnVXVyckdvN0JHVEJ0OUYwSDRDZkMwNXU3Y3NMNi9a?=
 =?utf-8?B?RVFLNVBJK21tWFJ4TjZnOTNwRVdXSWNtRFBtN0F5SUR3NDNqZzJkajJBSEJG?=
 =?utf-8?B?QVpZVFFLVUtNdGxVMEc3L1BSaVY5elBUa09Nb2RoZHpaVHdlYTFFMFk3NzV1?=
 =?utf-8?B?SWx3SWVEdTNHYnVZakI0Q2kxVWQxQW00ZDdLaytFYVB4dTZvTjNnN04ybG9E?=
 =?utf-8?B?OE5xcDNvR0tNS1dldm5xQ2docUljUFJjdlRmQWFnTGtpTHRYUXZ2UVhVTlNS?=
 =?utf-8?B?aVg1TlBLaW9rY0RZUmtqRkc3cEovTmNGZTBJQ2pXV3p6dFZ6aGtJeHRTV2Vy?=
 =?utf-8?B?cmVyTFh2STNIcDJoaTBNdDdiL0hQOHdBQ1pnNU85d2RvNStFT3VzekVJdnM2?=
 =?utf-8?B?VGtpWXdMWmZSMWdPVnJkdXozVFRrVkk2WHQweU55bGw0VnpQa2ErQzZ2U1Ra?=
 =?utf-8?B?UFVqbUYyK3I4SDhOMjZQUGlTakcyWUJ3K1h5Tm5CR09wa2RWZDhqNXBCQTFN?=
 =?utf-8?B?T2pGMXpWTGhtbVJxL3pmMHQ5VXpueXRqcUhsM1BvUys3UDUybFZhTHl0emd1?=
 =?utf-8?B?am5KSml5VkJieUYyUGFCdUdmWHlWODhYK3ZnakZmcGlTbXJmZlZ0alBBaEZM?=
 =?utf-8?B?SHhMK1gyNkJudTBHb2Z2a08xK2VtZnNuQWZ4QmRBbXljNWdHNW5iSWxka3Vv?=
 =?utf-8?B?T1lEUm5TaitoYUViQjFCOU12dE9LbHdyb0JSV1pXUmF1bzRTTkNWSm9VZ2RE?=
 =?utf-8?B?KzlFM1FxSzl0Yks3OGlUbzlseUFnTjNPaUszbmlUd3BDS3oyVmR0dU1IK0U3?=
 =?utf-8?B?SE1GSE52dUg0Rkl2VFM4VXVmOU4xd3JhcnlYV1pTdG9KT243YmZ0RHlzUnRY?=
 =?utf-8?B?ZmV1NGJqTEhOaG9BTnBEdUJydHhwRjlQOVRKWXhQZ01uNDk4VUJrM1ZHYlpV?=
 =?utf-8?B?WnRnNHpYSkR2TEM4eXd4czlHdWNxTW9KOU9JTXc1T0tSZVF2RWxkYVRDSGR4?=
 =?utf-8?B?aDdBNkhqZHNqZ0cyQVJrSnNRWWdBQjlIN0lIeU0rTlg2ZjlnY2JhWXdWaG1T?=
 =?utf-8?B?dU9Qa2JRNXB0M0oxVlhVK1JEeWNJNnRxRjhDZFhIaW1xUHJSNzUwMTZGUmN0?=
 =?utf-8?B?TEtDdmJwNDZGdXBRK082Sjg1UWtSaWJ5L0t4UW56OVFhVDFRMmFHeGhWU0dJ?=
 =?utf-8?B?amI5WCtLeVBkNWpyd3lyWUlaM3BLSEoyK2x6TzVIejJrY3BKZ3NBVzVwYm00?=
 =?utf-8?B?THVQUk9lTlJOYS9vYkVIVENNVHUwS2dQZEpEZjRIUmh0V2UrRDV2cnpTYnVO?=
 =?utf-8?B?b0tIQ1cyUDFBbFBramFTLzJ0VXcwUkwrQ2VSeUJMMEhRRzhDOGZvWkF0OURK?=
 =?utf-8?B?aXRkd3NRSmRLR0NGaE1MMDN0WXp4Qmh1YkM1SWNUZlMxSEgrL2VOVGt6anVY?=
 =?utf-8?B?NHlzbWtjejJjZnpWaEdra0JkWmtTZ2xPdThTU3RLcUlLajkrUUQ4UHZ2eHNu?=
 =?utf-8?B?b09RNHcxTTZCZlkzZjYva0ljNkE1Q0JLbG1BWUJCMFNGc2g3dWJJT3FkL3dG?=
 =?utf-8?B?TUdJSWxVaWRGSG9vNUlpVzlUOXlLTDlhdHU1RUdJWGRVM1YyUTNEdDVzcUpW?=
 =?utf-8?B?VXIvYSswbzJFWmFpalFsSndYaGJGV3Y1M0F6SXZuNVRLelNaR2RsUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e177121d-27a2-48fa-2af3-08dea754d699
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 07:39:55.6858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbQIP4fC2u27b190pXJk9j6V+5gZSjog04d6KgkKQbt11I9RkHcgI2eGsPtEquvyPYN5A2XUUPdK8xpvLVWO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7185
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

On 01.05.26 08:54, Sumit Garg wrote:
> Hi Jan,
> 
> On Fri, Apr 17, 2026 at 02:15:43PM +0200, Jan Kiszka wrote:
>> On 17.04.26 14:09, Aswin Murugan wrote:
>>> This series adds dynamic device tree selection from FIT images for
>>> Qualcomm Snapdragon platforms, enabling U-Boot to select the
>>> appropriate DTB based on hardware parameters detected from SMEM.
>>>
>>> Qualcomm fit based DTB format is documented in [1]
>>> The fit image contains only DTB, while the kernel will be part of UKI image.
>>>
>>
>> I suppose you know that UKIs (systemd-boot, EFI Boot Guard) provide DTB
>> selection as well. However, that is a fix-up for the case the firmware
>> does not provide a fitting DTB. This here is supposed to support the
>> firmware DTB delivery, correct?
>>
> 
> I would say instead that it's an alternate way to bundle multiple DTBs
> in a specific DT partition which are used by firmware to select
> appropriate DTB for the board the firmware is running on.

Right. We (and likely not only us) implemented that kind of DTB
selection many years ago for the IOT2050 boards with existing U-Boot
features here. But we embedded the supported DTBs into the U-Boot FIT
image so that they naturally become part of the secure boot chain.

> 
> The source of this DTBs are from kernel only where the OEM has to take
> care of 1:1 compatibility among kernel and DTB. This approach has been
> deployed for Yocto and Android based systems but I do agree with general
> purpose distros bundling DTBs in UKIs is surely an alternative option.

This is just a workaround for broken vendor firmware or vendor kernels.
In the ideal world, the firmware delivers an upstream-approved DTB to an
upstream kernel. Any update of firmware or kernel only augments bindings
and DTBs, adding features or refining them in a compatible way, not
breaking them - SystemReady.

In real world, premature vendor code gets shipped first and only cleaned
up later on via upstream (if at all). Then you need to fix up the
mismatches between in-field firmware and upstreamed kernels. And all
that obviously in secure, updatable way, therefore UKI embedding.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
