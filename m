Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3440ECD37A7
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 14:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B88884C7E;
	Fri,  8 May 2026 16:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mPv16tNq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D51EF84CC9; Fri,  8 May 2026 16:38:18 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE0184AB3
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 16:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnLpzcCZ0ru/qOW9btK0+OI3yrBM848iKKc0VC0f/q04WwqqRDlIUrxB7UHnoY5745wyW+WQJgDZFqv5QI9v++qbkFCys1lUij1pYPaQeMyQfE01zTmXy+aIr09kL2+V47A58jUsoAWUy7OzSR2H5Uz563ggG1ovslUKGkVtaSfNIE8gICroByEj65Id14IaoK0yf3znEx0mxHlizl8iUOJ6irud57i7Jut8wJUQgvyPMZlGpoQAlEqWTSyAhD/DNGNfxa1qeV6qwJqpC/LJV/1eO7bxQixsKEc34LxTjPdb+fZ6SnNyAW+y8wVkxwmTQYBYb4ZaFiy2CKVDhV7a+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q865CB3OFLaDQ0f2hjiiJ17PSpOkPyIXOfQ32XYe7Nc=;
 b=evgQLzORJQ2qlnTQfMDcstYgbX4gNX+WMx1yC9zdTYT/URAvX1D96lwtaI1Zn3trZ6j1dRkd9ISfYZV6FuYVUtsLAB636uaNglVIBnZDITVmjyQWVoczVw7t61QKwfxPV1uFH+dviKDJentygyMKQySGjmdySWbgDQiLfK0JyAjTQLRFqvYdG3RrpoYKjhm8v2jyT+r5mmWA1HbjEAYxWMgJdoX+43ucAHMioCukCS8GHiQqFTSTZzJmZ/rejV7fSNGL/vGzoL6iqLxoaGNl510O3Do4Kmje+shoKvra2RIdGNnW/1fQnmjZMOWDqlcpNrFj/46mwfS1yovzBrQ3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q865CB3OFLaDQ0f2hjiiJ17PSpOkPyIXOfQ32XYe7Nc=;
 b=mPv16tNqesxjLTBMN31uR4Ho5IKMuYLo1ZWYR9ozus+skWmB173RUeWe3Yox/nE2wgUd70hagWH6I/r/7ILCNB3YGm4+1iuxYrGjulw721IVbPKzAZD1/H9B+JKjOVGAJQCWbNrfdKPJmeIX+GLBjcojNHKThdjIUHJMig50QXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV2PR04MB12319.eurprd04.prod.outlook.com (2603:10a6:150:32a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 14:38:13 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 14:38:12 +0000
Message-ID: <c41e2288-a920-4bf3-bd2b-99151708270c@cherry.de>
Date: Fri, 8 May 2026 16:38:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] misc: cros_ec: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260507220725.209205-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0252.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::25) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV2PR04MB12319:EE_
X-MS-Office365-Filtering-Correlation-Id: fd816a2d-1973-4269-0097-08dead0f6e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: hHRAM3amfnkYpfIRDxqTzyEYFJw/Rt5k7z/tOeNkXnMJP4D+0gH6GJ90AhIbjvkL67tHjdCWJ5D6ld+J7fi5n5ilCBHIIPnsRH2adJlCKCpwQJUQDGkWDVKaZoUibIIH97mdUnoSfDvMVdYHy09PFTnihqfCK8utVx1phz22dk1B8DjaEkZ3dD/DTTwBZuKXjYrTJr3+V/stTk26uwMJaz5BZVmsFY2JTR7WxXSzO607viy9b8+O53bPTP7kba3+A2+FCNHCajL4s2P9T6eiMGkAi6wG0To2u3qVJP2CsIZjTGEXZzVo3WwpdvIDdTAZPEZnOBGwPkAdjd8ACi0SbbcG2zwu5JlV+CkLq6PKAJJQHwSvzqBDJ9meBJhVqYy+fd4M2oBPnpBBFH9QJ2hEpZNjthjWsTHjvf8IKd5CFJ77VO9iLl+aZfCg7zW5pOiocKheCZuA4VgASpbGB8FEFBIWmLroDyltH3MM9mnX5WBBVPkQ9/HiThhKSySRs9BGiemEzyKHZgKOxW+IDOty+aX6flP8yQCvWQbcbxrBqewdsJL5rF8Ro7yj5hHFpooH29AJBzkfUt5hN/CXlfJWrTzlOt12ZwurRQ/y+w3eeU2thkJH1Z8muSJLFZie2WEFI0t7ddPn3l2K50tWN2eEsFaFfPpThhW0wD6cK5bnVYTf8rpolxHnLvSWKymEYUJS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUxpcjRDS1d4RmdpNkZiTEFRMHorSWp4eGRMcmloak04Y0sweWFreFRHemVZ?=
 =?utf-8?B?OWJHaHpHZitvczBsTTdCdTd4Yk85Rm9wekpqbTJEUjUrWlFPZ1hmMjFoTDRV?=
 =?utf-8?B?UGdtNWhBYkptazFTbWRjZHZyWi9wQ2tYTUVISUtXdHY4VHhPbnFCdDQ0Q3h6?=
 =?utf-8?B?TkphV2lTdE85cm80R1BIWlE1cGhMNXNuemVsdFI1SkVnNnJRbUYxNXlDdlFV?=
 =?utf-8?B?azdCRWlJVFh2bWN2R3RkQnFDQ2VpYitFc1JMUEFMOGI0eWdUMkY5QXVBMmNi?=
 =?utf-8?B?aDJoZGlmbFlYOVhWZ0l5MGxJdHM0M1o5clRpdTNaa2JxOVFpTWQ4STU4WEtx?=
 =?utf-8?B?Z3VsMVlOeTVpaSszajBWZm44amNzMUYzL3lzenZkT052aTM3OTRlcllLaWc2?=
 =?utf-8?B?SEpVQlYyVytSa0pEUkJpcmxWSTI1Y0kxKzRKRzY4cW9JOFhLM3A4S1lOR2pI?=
 =?utf-8?B?TlNxWDZId3B1Q3dHQWVGV09mdE5qaHNvN3hyR1RoM1EwbStHakVUZ2o3WDBh?=
 =?utf-8?B?RjY1UnBFcmlBUVpScGkxaEVtZndoaHFDZ1JGZFRyWis0cjljdHdzTDBwTGxH?=
 =?utf-8?B?TWFubzFEWms3YlZGZFU3SldOck9GVmFEdzhER1IvMjk3ZHIrc1JQa1loMy9G?=
 =?utf-8?B?bU5rU3I3d29RUXpObjE5NFdMVVVvOTFsNmRZRzJ2SERwYkZDdjF6YkVVNWxz?=
 =?utf-8?B?M1ZSSkFjQXdNVlA5dXV3UEpudDZpR1pieGt5MDNhVk0xdDliTk1DcGVTRWwv?=
 =?utf-8?B?clFTV3l4aGxpVWNBb2FJWjJuSHVXZnRrQU85emY3bk1RL0w0TVNFZElURHJq?=
 =?utf-8?B?QzhiQnJISFV0SDlvalJlblJiQkJjQkhzTDdlMkx1c29VbjFEMzVSZmgrbWln?=
 =?utf-8?B?MU5mT3pVQ0VIb1FPSVhkaDNOSmlQbXdFeVJCdHhJZy9lZ1lHRUp4SUdhcnRV?=
 =?utf-8?B?WmxBNklOTjRjVy82VnRiTzZSUkZQai9NUCtOLzFwb2ZwUUF2eHh2K3pNU3E0?=
 =?utf-8?B?bERtRlRnbks0ejBxT2FGTVpsd2JCelB1UXdlL3FhMGVLejV2Uk9vdWFzd1N1?=
 =?utf-8?B?ZUtGVWRoQm03Z0NqNUxMWEc1Z3F6T0E4bXJVUUVNdzVNWnBBNVRKd2E5THFU?=
 =?utf-8?B?d2JFZU5EN2dUN2lYY1lLK0JFU2dOT21GQlVia1ZRbkFSMVpTelFsUjc2ZDZw?=
 =?utf-8?B?SE15bjhTVC83Y1pDbTBLZGIrbVVoSGFEZ3l4SzdhVEdab0JrcHpycXlKNldu?=
 =?utf-8?B?dCtma0ZrVXVYNWtYcEtoNkRHbkdKSVFKQXRQUmp5elZiRjBhcWNhK3Z3NHNT?=
 =?utf-8?B?M2QvSEJVcHo4dzJGNzlrMGEzWWJpTHdFM0tlNER0bmdRSmpPS0lEWUNTd0Ur?=
 =?utf-8?B?MjhQeUo3UXBJVUxyanJCOFZNZEN6Y0E2ZzRjOGUwM3drNEtNOU1OcDJ5azdz?=
 =?utf-8?B?cWoraVF6dmd1TkR4WkhOWGFtcjBHUkgyRlIvOStvdDZzVU44UXpqSXBPRHF3?=
 =?utf-8?B?RE9CQ1BDclhINUw3dks1c0hMaVJ4OFA1UjRIZEZ0WTZIU00vWDllcllZQ2Vi?=
 =?utf-8?B?b0MyZ2xrYTl4MWZ2bEpxRklFYTlTOVRWL2ZublprSDVuSjIvU05MdXRNN2dh?=
 =?utf-8?B?blAvYXhmTlp0UEI2YTZBdmhqVC9JRHovcEhwcGxjUmhuUmtkMlVrZUdlV2E3?=
 =?utf-8?B?SmI4KzBDOEw5TzBLS3dIUHR5amFqUktHUndFaGpQbDhNL0xHaGZmVzNuQjJ0?=
 =?utf-8?B?UVVwSFhSdUNDbmRCRXBROHl6WTY2enF4ellRQlNubW9aaExsWCtkTzZpMGRO?=
 =?utf-8?B?N3NJOW5vVmtUeHZCbXY2Ri9JQmx4UTNIalc0dzRjNkVvZ2c1d1FoSjBCK3kw?=
 =?utf-8?B?RXZQKzBKbjVDanBxNDE3VDRFQ0U4NWt1TEErWjB0bkR5aEdvakNydnRnallk?=
 =?utf-8?B?dngvY20rTXplWGE1RlNOcjRBOEZrSStOR29lOERmZURYYVRkTGk2anhjV2Y0?=
 =?utf-8?B?c1ErS1p4MDJZQ3hOR0JzZlFWUWFieWJUU1FBZHJmN1J5eHB1LzZmVG0zRHQr?=
 =?utf-8?B?U3ZNbS9GTFY3cHRwVHNYYWU5QmgrN0RXS2RMWlh6VWZBUFVycVgzeXhoNkpi?=
 =?utf-8?B?RExKd2FSVTdKeCt1K1JvS3dkM3hmdGRqWVBOMS91amdIandmRzdXd3k3T0k3?=
 =?utf-8?B?SElLNHc5eUppdjdqY2RpVHN2KzFVSXpIK0lmcDg1aXJSa0NwektQRE1GRk9j?=
 =?utf-8?B?RnNsMFpKOHloRnRDYVJ2ODdsNWNMeWthQm1zTjBmeFNiVTlQbDN1aWNaUGpI?=
 =?utf-8?B?bzBLbUVUcUN4US9tcmhpNkRhOXpjVC9JQ0x5bEtCT0VOVVhpMENEdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fd816a2d-1973-4269-0097-08dead0f6e98
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 14:38:12.8918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaVWOI9Q4jjfgKEgNXiAQtFWYb1IomhgMR1M3tQ+sd3qCgvsxXtmqfbRElz/ccWQoJtuj9mUO4cIposvnl3cwNOyZMBdwrrYfeHRWBlWiRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12319
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

On 5/8/26 12:07 AM, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
