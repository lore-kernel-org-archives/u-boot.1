Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B289FCE095
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 14:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE2583E83;
	Thu, 26 Feb 2026 15:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ltgTxH53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2512383E83; Thu, 26 Feb 2026 15:38:14 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B36183AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bku0yHETQ64mPzAnNyQ+wQ1lIP2/h1W3xYB9eOoHdraA1GMyCD2S+RnvIojOdKxcpb5mYq4oPeBq0LA4FjZkvJr/5i83+4J+z/r1cb0Q/8jXwIltT1FOpzahdPsO9q+Q8hCEpv2tsJ7BlKmMj50qf+MsNcDyUUO/QfjjaKxUkD8KaXVglra9s5oZY2N6uiTVwyg4CDA6+djm7xfGO1g/nVOGJ/1uecDU/CIELWKiTQm3xPxQ2c0y2OARGBtyCz84aLxoo2KIKDOQhqswZLZJX9bFLfjohY1q/xnJchpP1Quo/ge4u5r9NAledZgBKkEEQZU4giDR+HbwS5FBN61/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAggqeWsFmCWkS0VVMPrW7+UIO9TgLK9nYPhu4GrF2k=;
 b=m4T+T/iyUF1PczksYB3EdZkGnOyeQzLK5VdxdBf6fzBcCcf0CcH/n1q3G4qnVJZHCv82v7GzKmwzXt2b4hTwSLUTcP+oI9XKM1b5W5FA0DUiXK66c0IrNpi4EqWKYSdy4mKsU84xJTm+UQnP+vIyGH7k2k3YdBBLnlZjZ+jOn2EtOqwa4rsAS7gATrvyX87FIK5FQW6cqB831SjaGIZr4VbvIGZSSC1ZnSmzC4J6WSQHf9m+UblU7kVCH8Ug1K2LTbAG2v6JciQHokd9umymJujJuMvSikFUzGlTDDleZC/iJrritsh3hNY9+/Gq5ltb2/01KBfZVwp2r6Gdk07wqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAggqeWsFmCWkS0VVMPrW7+UIO9TgLK9nYPhu4GrF2k=;
 b=ltgTxH534WXLI0/Wk5dUsVgDRAiVVaRRm4reWmZ/aaL+TIuPggbTSnOIm9Ll1qSpdHA59diLpG91Gb4DSOLrWy3xWw5oaZ2ShXZc7aWlgN0Y6s0PNMB2DXcy4SH3O+LAGHmcb39Jvk5+Wb0ojeSuO/Zk0VVZjsPtiy5ATa5cMT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PR3PR04MB7465.eurprd04.prod.outlook.com (2603:10a6:102:91::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 14:38:10 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 14:38:09 +0000
Message-ID: <c9921674-11ab-4357-86ff-6c209a9e2392@cherry.de>
Date: Thu, 26 Feb 2026 15:38:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sandbox: don't imply non-existent CONFIG_KEYBOARD
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20260225095830.45904-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225095830.45904-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0091.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::20) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PR3PR04MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a2b6c4-caa5-4892-8b8a-08de7544a985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7142099003;
X-Microsoft-Antispam-Message-Info: aU6P23FBF7QFlXv+vRCZJu5FmKtVYNpggMy8tNAGoshTzhO/6d8vSsqvKOv/IvUvxRlRJ9tQoH5q2977KCef7J1OQT2Go5o5r7Pr5BRmja4il1y9s/N/LEM7OevW3CN8Zn2PDTm0jqIfrRy52RLfoukvCxrgstsPj0+MwGavfHCId0un3EjDcD6Foc1HPBywNgNniz3v6c+2cnr1iU5A75TbPSPlx/QijmiAK4AESYVMhgeMAke16wuCl3jySW8Dw31I3uzImpjVKN2uMmYRnjceKTnp0iLOPiaYpE1Zydvrn1tIrzMHhUAcI7MSK6evL6ftSRhdnLXd0L895oLi2jnQr2LD+LsHOEtb7maaHBsTQfOQlkJsJLrVUPDg7Rsx0i+xZTD29iLL/b9OLDSVbwydJcKD8WVp1wTrPJVIi+JWAdoxSq6031x+PamPGErfabFHTWtpgnH4QL4LEi3qyPW4RhJFm2+j2/NpHCQBDCJrO3mbEt/rHUjvPvZMgT6CAirTYVwCW58AVoMhv/HaET4MU6jKJj/IgAfLRP/4peRff0IPF6bwyKaxIHCzllENkQ0NNNTcGIHMBhMjPYAIyEECBNzPieiNTE7oyWocN0QUzIaa37KnfxbUt6hKqYr/ooNcwCgxn8XWGVoIqgGSEditb7bHbj+C57JLVqUYzvQsE+5DPT3QHepckA+xQJbLjCKxh37opA/rJJ4u45dWaKeRUscw0LxRtmQn9MR2u2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzVOWTgyRzlmNEx1YktNRDAwQ1BDa3dDNWljdkxESVVpUlllVm1IVXBSL0lD?=
 =?utf-8?B?OEwwRGtBUFkvN2N1N09qNDBMTHhQN3I0U2RzMVg2NXgrNTZ5N205SDFSeGdO?=
 =?utf-8?B?Z1d5dFh3V2dtRDNqU1FNSjFMUjBYZ1ZuYThjekZ1U2tpUGJYRzZHNVdGak5W?=
 =?utf-8?B?UFZhMDZvLzgyMDhwNWFScHNnYVFQWTc4REw0VW4wSjVuVUxzWkNyS0pjUHpT?=
 =?utf-8?B?cnAwblVFQ08zSy9LVG9JNVhETXRXQWxicjdERitVUGU2aXlNbndCbSsvUzNB?=
 =?utf-8?B?TlBwOVVoQS94L0VVVGNkZjdqb0JQdUJuQnVqSFFVRklSdEFja0Zzb0l3OHZo?=
 =?utf-8?B?WVgwL1dtbU05UDZyaFRya1FxUmpUdzdOZ2xyMVJWVHQraUhuOE9hUUZZRUMr?=
 =?utf-8?B?aWYxaGRVaTVJUlUzR3VjQWxDQTBZWTBTWDhsb1hCcVRFTTFNM1RQU2ZGVHZH?=
 =?utf-8?B?S2srR2V6QjgwUzFFSHhXdjdEQW9oOE1GUENVMlFKWjRyekxKS0ZtT2Yybkhu?=
 =?utf-8?B?NlNoLy9FRTk2eVhXWWZhK1F3Zm1aaFIxTkFCTmRWTFZIcEJWQkd5T25yYXo5?=
 =?utf-8?B?MUpuMDUrUDh0Qy9IdWsyZVBxbUhpSFoyZCsrdmJoTWU2bUhlL1ZreU1PUzMx?=
 =?utf-8?B?N2tURjFhWERVQm5ES1RoZkQ3T2dtaUVNc21xSnJ2blY4WkZ6aXJOd01NUW5G?=
 =?utf-8?B?QS9kMkoyUldPNjh2eUpjNkl6TUd4SElRdG8reVNwQytTZ1FGRk5nNENsbFF2?=
 =?utf-8?B?QUpSbWpIT3hoN2xGZVF0WTRDWmhQa09Pa0lvQXNOUkdDbmo3NEU0NHVjVy8x?=
 =?utf-8?B?aUdtcU5PakVGbjRrR2o1M2UxaW4yUStlOXZ6RXc5cnBVRVJoUDdPUjJrZzZi?=
 =?utf-8?B?MUdMb1UwNXlML1lNS2l2dzZHMVJRbTl1SHc1em9lSE5ycG1XK3ZnN2xRNmFT?=
 =?utf-8?B?VjNyVm9vL2J4QzgwVjR2V1VUS0UrTEhQMmJYQXE5WkhXYVBDWk5KVUFKTXBr?=
 =?utf-8?B?c0FZanVoTU1wbnFlN3hiRHg3ellTL1RLOTNJR091bWRYQm1zd25jMXJBZWpT?=
 =?utf-8?B?MTEzVDBHUlNlZ0p0TTNsTWRWMFh5Zjg2S1VjbFlQVXE2Q3NPeTF2SEJOTE9S?=
 =?utf-8?B?dW9lU1dxck5Xelk2SkF0Q2Z1ZVkrVkpXZVNublJia2VyLzBlRHhCZFJ5SGdZ?=
 =?utf-8?B?amdNRElzSi9PbFRRenZkWkoweHU0bEZ5NmxwdGhLOElLUFpNVzdSL1ZvSnRT?=
 =?utf-8?B?aVNmWnJyWDR4cVVsN2g1aXVGQUJ2cGhVSVpOYkY1SjIzdVR0UXM1Z0N2NDk5?=
 =?utf-8?B?SDBRKzZFVGlsYlFpaForaGN0N2dUQTU0S01JeGE4L3ArZ0h2dFp5OWVSckxv?=
 =?utf-8?B?d2UrUXQxZ2k0VE43L3lRdkRtZWIvSjZBUVRvVGpid01FaDVyTTErVW9veFo4?=
 =?utf-8?B?MXhkRW5IZmJlR0grdzQ5ZStFNmM0Wnowd1lLcDk3ZFV6WnhPRDQ4SHlsa3NB?=
 =?utf-8?B?cmhWQm9lZTN3ckFxSjRTajVXT3l1amY5UzZnZjVoQWphZWhyWUI3Ym1oZWZB?=
 =?utf-8?B?RlloeGR2aHdyRHp2M3dnOGtscS9kTVByelRYNGhERmV2Rzg1UXg1S1hVWVcz?=
 =?utf-8?B?cjN5QTNBNTg0WUlrQzMxeGZycldMRGJxMVYwL3pSeUtqdEk1NFgvYlF6M1ZK?=
 =?utf-8?B?b3V0eG1CNk5UeHRQU1RYM0c3ZzZhY1hEV3pwK1VxamtMaTBnbTRHbFlkY05K?=
 =?utf-8?B?bzhGMVBIeThJek8yTjUxc0p3bCtSK0FkMCsycXVjMU5Rc0wyMkdvSVlPbmxQ?=
 =?utf-8?B?eURMYVZtdDdWZ1pnWnFIK3FWOWthWG8wTkJjeDBIZ1NFUVJWN0l5TXZoanJy?=
 =?utf-8?B?NUdvNjlRT2RpR2Z4NW53Y05qZ0txVW83MW5BdGNLTGd0RDRGdXFhMG9ORFdt?=
 =?utf-8?B?YTFtb2pLWGZTeC8ySGxIMS8vTXJ3RTVMOWhHdWZWR0p3Y1R5MGo1YkUrcXhp?=
 =?utf-8?B?b0VFekFLOUVnNy9pQ3hmWFhpSERsM2RMYVhaWkFMbXYyeGhkRlhYNFF0L3pt?=
 =?utf-8?B?VzFUbWNsdThUVUxYaitTOERGV2pINW1oenVJYVZva2cvbTBCb2RYUVE5ajA1?=
 =?utf-8?B?bHUwVVJrMXc4ejRqZ2lCNUZKc2tVTThQSVVmazNSTUpGSTJNQWptQzByeFJq?=
 =?utf-8?B?Y1ZLTjdIM25sNE1IOW9zQUFQK2tWUUtvQWpuT2laSmdHYkl1U2VOemMvdjdU?=
 =?utf-8?B?eU1haDVvOGlGRmhacjE2NnZFMVVRMno0Y2hCbkdoYzZCY010cUplV2xTNkNT?=
 =?utf-8?B?ZkxvUmJ3UzB4dExqT2RGYTRtWVZ5eFNXUmtQWkQ0a0ZxZVpDcm1IUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a2b6c4-caa5-4892-8b8a-08de7544a985
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 14:38:09.6924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lIp9MrfhLEzFAXqnn2k+g+ueXCCYlQBCxEH3gNiOdm0w+8Jw6TADIiStz3dzJcvxR+0sdIstbulM2e/PLhraIfXPRxulNlSBNnNMvNBYyIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7465
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

Hi Heinrich,

On 2/25/26 10:58 AM, Heinrich Schuchardt wrote:
> Symbol CONFIG_KEYBOARD does not exist.

It used to. C.f. f60e6f676764 ("input: Remove legacy KEYBOARD option") 
where platforms were all supposed to be migrated to use DM_KEYBOARD.

DM_KEYBOARD is already automatically included for sandbox via the select 
mechanism just above the git context here.

Funnily enough, select DM_SANDBOX was added before the imply KEYBOARD.

See 93e1edffb02b ("Convert CONFIG_KEYBOARD to Kconfig") and 558e12571e3c 
("sandbox, x86: select DM_KEYBOARD instead of default y entry").

I would recommend a fixes on f60e6f676764 as the symbol should have been 
removed there.

Also, there's also a similar imply for exynos, in 
arch/arm/mach-exynos/Kconfig. Which also has a companion DM_KEYBOARD 
select in arch/arm/Kconfig under the MACH_EXYNOS symbol, so it can be 
removed as well. I'll let you figure out the appropriate commit hash for 
the Fixes tag.

The change is fine, more info would be welcome (in a v2 for example) but 
I don't think it warrants a blocker, as such:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
QUentin
