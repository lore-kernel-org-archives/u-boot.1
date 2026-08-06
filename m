Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3720C56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 16:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 991AC4083C;
	Thu,  6 Aug 2026 16:46:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fBZxD8ueQ156; Thu,  6 Aug 2026 16:46:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90CAE4083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786034816;
	bh=OKY/S4OegHSTScRVS2rWFb5n723UjWT7pw5oqMJdX0c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gg9dSkPNEcSVcNTCYjA2pZP3tiWfY7eFGJZXEcyZbtBWFUr3vtAb/0XrVBkxlYoa8
	 QBXjS6oqe7mW2N32LY/TWHC6ey0UHY8hf+pFxnq584dzlRexyRS7oi1DPtuGU/jwiP
	 /QqsGOE2UcU9cIi2rwSPa9dtG39d0HPmfnwIKKoC1NnMsW9KcpHM0h9hUJBifpXD9i
	 QgXrIFOEQDxJGkC6hgUFyUJADWM75Goe8fA/BdU7H1rDeWmHEy8lViz9xLjWfm2jzQ
	 C+zzwTWDx+l6tDzQK5k6PTOhBKM1SOaSIbOcPLW56RGV98ceV0QUzSqa1QY0lwbpsJ
	 ttj0ql3sUHtLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90CAE4083F;
	Thu,  6 Aug 2026 16:46:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E2DDA218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D43454083C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CjUQMdhL5-v6 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 16:46:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CB36E40838
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB36E40838
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB36E40838
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 16:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMu1I4E9mZFcBOo5sWpu9nmycLrAVPd/7oPw60r6hRFe8h6gXHqiOhVWOzhOLkTGduRYUXV599Cdsnwigo0TVOMe7y2pIOt30lgStfmuaaoJcSrLm/wATxuruFTbJ6DnoSbTuNK16KBEl7WSfp67jtgfRSsoEvlH+B6JFwHi8mabYuLYRYcqJVNe11hB8ldX46WS8nN/3Ae+VpzsHABVS16yrbMXK4jfluFLKiZkfqIg4VCFlfki/NM51KKY/+sV6UzwSf3s+ML/ivqsHwDfBuPLhWRODCeY77kf7sID+w4n4SE/VAhzyjlyM+T73hOo1PXp3aAeKEeW1HF/MBxSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKY/S4OegHSTScRVS2rWFb5n723UjWT7pw5oqMJdX0c=;
 b=vzjPIulN1hpi3+sj2PLAX9aSh21+zh5cnBxlD70M79omIY7RryhRgpod/nT/ExkEI2uAahsWoz4QZO2ZHuG1NPxBiKP4Uhfr45tPmdyWPbOcYG7B6tLwICCWWlDGUPcnPatKXLTZRqJUvO3t9ZygtOXBJqpW+pPvJerH6G8bHR1/cRiJLnUYmlXdpmAPRQAILeMlV4pRx47QLscpca4lqdOetjC0FKZE89EG4PV5uFnr7wHlzE3IyKd+pViNH3+1Wbo6oTsZvJYNWya6HKXrQV2NMKqQocz88hYd6NM8sj7hJeP1uNDmXjXgOzHfzilP8ynBGPPly8Bvz51YeOqE8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18)
 by VI2PR04MB11097.eurprd04.prod.outlook.com (2603:10a6:800:293::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 16:46:42 +0000
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5]) by AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 16:46:42 +0000
Message-ID: <f3d4bfd6-3b99-426b-b025-d236b9feedff@cherry.de>
Date: Thu, 6 Aug 2026 18:46:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: spl: replace ifdef by IS_ENABLED for
 timer_init() call condition
To: Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com,
 sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.u-boot-project.org
References: <cded3ae1-b908-49c6-af92-30b931d160c1@gmail.com>
 <c6530788-e823-4cb4-905a-5473d9c00914@cherry.de>
 <6e43369a-832e-40d3-af23-a0981af84d75@gmail.com>
 <75f48c14-bad9-4250-a4b5-321cc17bc1ec@cherry.de>
 <20260730220623.GI1773261@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730220623.GI1773261@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::14) To AS8PR04MB7733.eurprd04.prod.outlook.com
 (2603:10a6:20b:288::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7733:EE_|VI2PR04MB11097:EE_
X-MS-Office365-Filtering-Correlation-Id: de52b2c6-560b-4e45-8dd4-08def3da4b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|23010399003|11063799006|4143699003|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tSExI5C+yRRhoQ9IF6SV0vquM/PyO3bfn0d6ROE6BTuvUD9lQiq2iRV4jOTV6mbS75WOZlFGS0uDhCiq1h8oF4AesUdkOB79SyKvcql3nmUkeUw39KdzDjwfxwCzmq/F9PloSinm/i0mw0LyCuVSLWpNvOaa69mMzuoNEb672QAEmgdu5QF8+/89TdDZ1iJtwEcMltp24uuqaOG3Tc6UIXpiqbBwdTh5aDJDHcPdw/8fADnIcFQBNslkZeO10GI28MSVdunIqWbu62EkVI0D/EvsaL1eRvNQ9WarswLSWb1zCowbTaZBpSVGBQzZ6olinsnY1bYLacaktVqsWdluckKvOBEstf6qx/HVQs7vrmnPXYHguTFq5cGoz9W+OqImUvehNJLGg8NCjLXPd+wHaI2oHsB47s2t2FxR+vKh/XEjiyBQfcdtwqsa7D3pSO2G3OA6pgwm+olyf3Cd96glTuRQDVOG0eu3P6UKObdnStUv3bIk713qBmFZi1jo9hry9+fnUP5d8Wybf6wz7Lbw5jiBH29FmHgl1kx+1n6IUNHCRDttxF/z/frJGNIW6DrfOC1UgI+rBIU4RScS5NI/vTrh8gbkgaw2rbu4/YWbmVgHIZJuWcePdxB0ykOVfNoHtbXm9Y+hprSq0bVK0gUfz2eRykqVayICA+Zw9jWU744=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB7733.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0FlNXVnSUlvYUt0ajUxcVFvUlFCZmd3VjNYbFBkdEE4S0NmUGxaNWR3eFNK?=
 =?utf-8?B?ekswTCt1SThDRzZMWi8zVnMxZHFuZlVGckhKZUFYN0pHNHV6YXBEekQ3dzZx?=
 =?utf-8?B?T0NtbXpSVnZwbFZMZU5tYjJ2Q0pNUzFIMHhLYjZQMUhHcHRkeHJEUk5pSXln?=
 =?utf-8?B?ejVoeXp3b2tBZ2IrTnIzVURhTG0xa1JPVVBKOXNlblQ4WFQvRFJOMDh2NDdn?=
 =?utf-8?B?RWVpdGM4OTJDT3k4Z05XWW5PNWZpb1M0aVlhNHBEUVgyMHpFYTNhTndMdmRo?=
 =?utf-8?B?M3h5OGd5eGpJRzkrRi9VN0R6MzhFNXRiY1ozbXdkVlBHU0JZYVB2R1NQbzZh?=
 =?utf-8?B?MmpWZk1rVkFBZS90cTRIN0lUUEs2L01ZQjN4elRTZGNYelBocm5uTktPQ3d4?=
 =?utf-8?B?MzJrSnJKakszZFgzTkFGTGFhWVhTYUJlYk92aDVaUllEaEdDTHhkNHZIckov?=
 =?utf-8?B?MERWT1YraVptRG5mc1FIVG9HSHppK0g3THNCTmlZUTdwdm9XSXNmbG1GRGgx?=
 =?utf-8?B?aVd5N0kvdW91ZzkzY1VRbWRoQXpwRlB2Zm5QcXkvREI4TFkwTDhqSzM4Wnlj?=
 =?utf-8?B?cHp0ZS9wbE5XckRxekcrNkxEcDkxVTJFTzVkelI1eSs1Nnc1K2Y2WnRHQW94?=
 =?utf-8?B?NzB2cGRSaTVXSUtjV3pxVzBxVUgvVnJhdk0xaDVyemRybGVxVU5IcmprZ2R3?=
 =?utf-8?B?VDY0N3A1cXdqQyt5dzFJWGdjSmZoNzAxR1dpNngyUENUNzFGQVVsdWNvMW1U?=
 =?utf-8?B?eVFTd2lEMGJhT2FKZTdodnIxamY2bFIrNlMzdFRTQ1Z6d0ZtZUFDaS9DNFEy?=
 =?utf-8?B?aEQvbnV6Qy9VSkE3L3FTM0pTSm9PekR2cmhzS0w5aFg1NHluS1kzVzVLT1gx?=
 =?utf-8?B?ZDgwZlliU2VhSmdFUHM0TnkvajJaMWNPcjZSbGRwbTZFUFN6NWl4eGRrWFgv?=
 =?utf-8?B?d2wxTkpjTlR0YmpmWG94RTQrK2NqK3NZVmpwV0tNbkJKV0w1eWkxSkc5WFlW?=
 =?utf-8?B?MW1yN0JIYVFQZkpmTUdNZWFxNkZZYlhUckVzdGovaWRuV1p5WEtjZER0a2Vm?=
 =?utf-8?B?K0lBNmNWL3VYVSs2VFFUdUprWVJxdzNqYTV0eGg3cFZsczBhM1RmRGJkWVJn?=
 =?utf-8?B?ckt3UEgwSzJxRUJORWFVRTNUVzF6cG5ZTzRQZ2Z4ZXVUMzd3Z1ZQSWNWN2xq?=
 =?utf-8?B?RnIwa3J4Z25iUHp5YXRLZHBKQUZxekxMWWR6bjZvbXJjREtZbjRiUGN1c1Bl?=
 =?utf-8?B?c3ZBdEJjbnBSNXBwbHJuTFJ4OEVITFRieEFaQUxPWXR6cWR2UEtoZEVITm1y?=
 =?utf-8?B?aXdhdlR0NHVsWlZndGVQSWo5UXRxY2QweStXbXlSdGloSjhKcndhLzNka1g5?=
 =?utf-8?B?amNYSXlZODhuR1hPU050VVJvcGNKQkViWVAzdUZUS0NTcWE3S2tkak5XUG9E?=
 =?utf-8?B?VEs0MkJDZ0RiNWlaTWpGZE9zbXZZemxacWhxVVdycitVMnZXL3NHc3NMUm5m?=
 =?utf-8?B?OTZ5VzlWR2NRUU9NbHVWMGh2OGdPOUp2WnlLTk9MKzlzOFEyVmJRMm9Qem9M?=
 =?utf-8?B?Z1VuZGExcGJZU29Bc3pwWkVUVy9yRDkrajNETFV4Q1BuT2NKWlloYmJMcktN?=
 =?utf-8?B?TmJPbkx3c2NOZFBvQ25FamEvZzZ3dWNINnNxbTVMOUNzUlBiSGFnSmZjMGFT?=
 =?utf-8?B?b3N1TGl0NmErek1nNzRKRHZDeC82bjc2Sm1JQlhkaGNHWHgxS3hyM1AwTWpB?=
 =?utf-8?B?WUYxR0k5Zlh1TE0rRmIvYWhoU1g3WkNNdnBaLzQveVpzSVJTY0Y4d3JnL2xD?=
 =?utf-8?B?elpmYm1RaUx2Y2U3UmZWSkFwUk9raVo1ajRrd0JJNWdyN2lIQWU5Z25xN3FH?=
 =?utf-8?B?VGgyOXYwV3MzVlNUSlVoMXNiWUNvSVo5TUFYZnpvMmF3UGxwbU5rYkdlQXpn?=
 =?utf-8?B?UGpuTHdaeDRUOGtxZkJFajhxRVBtSUZ4SVVENndxaGhTenFROHlQRFFZdS9O?=
 =?utf-8?B?Rmd4ZXRGL1NuSTc2bFl3OUdQOStEV3d1RkZ0cjJpeXlvSXZPL0tqQVZPOTRk?=
 =?utf-8?B?bCtBRTlOL0VWcDljUEhBdERSMHlyc1hWSGpGY1VoSTl5cjFLL2RIVTFaSFZz?=
 =?utf-8?B?amVGWVFqanJnR29xeFBoL0tQckNrTXFKclF5RGtScHl4TDN3S0w0Z1JtN0FX?=
 =?utf-8?B?VUZMUXV2ZWkrVU40UklKWHBUaVRwMmQyUFRCTlhkRk5Wdmkyd2N0MHdlYWhw?=
 =?utf-8?B?K1F4K3dSNGtqVVNoaWhJMDFyV2M3NHFGNXZCdlF6Wmx1T2hwZ2JjQmp4UGEy?=
 =?utf-8?B?M2xUWjRESnJUSHhVajN5V2o3YnU5dGRPN29XVkpuSDBQcVF3amdYYVNrYzV1?=
 =?utf-8?Q?2uTEVspmnj9iGBauafQ9INXhMbQ+eUtiJqldA55I78NxO?=
X-MS-Exchange-AntiSpam-MessageData-1: eQjW624mM/LpRWfzlpxXR96mfnf/FwpMfBs=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: de52b2c6-560b-4e45-8dd4-08def3da4b28
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7733.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:46:42.4562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kS1WRjcIbLgFwNm2wjABQwhrGimIITviwDN6DX7p3mn8KLVp6vac5K9/OEDGqT8xnD7GvBN38VbuRB0zvFP+JyZFcjARlJN5AEWgldBlaIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11097
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKY/S4OegHSTScRVS2rWFb5n723UjWT7pw5oqMJdX0c=;
 b=VKl1h5doIXy8QdJLvxqrX64f2vzS9Xc5sIgDEk0TU/z5DJ4h89qkQjgLNfmocV84n9lI6zEHBE6gV/DZJ3zHH3W8fjmglq8sJ1awH/r3pzDIxFcRZ3fDvK5bfPKuFT5YbnHyEVxegRoxPaRoziSlmNIq5AMVJUuB9104KCuUAgs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=VKl1h5do
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/31/26 12:06 AM, Tom Rini wrote:
> On Thu, Jul 30, 2026 at 05:37:52PM +0200, Quentin Schulz wrote:
>> Hi Johan,
>>
>> On 7/24/26 11:53 AM, Johan Jonker wrote:
>>>
>>>
>>> On 7/24/26 10:45, Quentin Schulz wrote:
>>>> Hi Johan,
>>>>
>>>> On 7/24/26 12:17 AM, Johan Jonker wrote:
>>>>> Not all Rockchip SoC models use the ARM arch timer.
>>>>> Call the function timer_init() only when
>>>>> CONFIG_SYS_ARCH_TIMER is available.
>>>>> Replace the ifdef call condition by IS_ENABLED
>>>>> to increase build coverage and make the code easier to read.
>>>>>
>>>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>> ---
>>>>>
>>>>> Previous version not needed for serie, so resend separate.
>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-5-jbx6244@gmail.com/
>>>>>
>>>>
>>>
>>> Hi Quentin,
>>>> You didn't answer Kever's question in the linked patch and I have the same question.
>>>
>>> Yes we end up the same code. But...
>>>
>>>>
>>>> This is essentially the same code, so what's the benefit, are you trying to fix a specific issue? How does this improve the situation?
>>>    > How does doing that increase code coverage... etc :)
>>>
>>> This patch originates around the time this concept as introduced.
>>> We are changing all code to the new norm and we leave this as it is...
>>> Fix this as well as a favor to Simon as part of the review. As we are there then fix them all as this is the new norm.
>>> https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-6-jbx6244@gmail.com/
>>>
>>
>> This doesn't point at what Simon could have said that prompted this patch.
>> The pointed patch did actually fix something, and instead of using
>>
>> #ifdef CONFIG_SYS_ARCH_TIMER
>>
>> you used
>>
>>      if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
>>
>> which is absolutely the correct and "modern" way of doing it.
> 
> Right, and when it makes sense to and improves the readability of the
> overall code. If it not a must-do every time. There is a judgement call
> to it.
> 
>>> The concept:
>>>
>>> Currently with #ifdef the compiler sees this code:
>>> =============
>>>
>>> 	rockchip_stimer_init();
>>>
>>> 	ret = dram_init();
>>>
>>> =============
>>>
>>> Now the compiler sees this code:
>>>
>>>
>>> int timer_init(void)
>>> {
>>> 	gd->arch.tbl = 0;
>>> 	gd->arch.tbu = 0;
>>>
>>> #ifdef CFG_SYS_HZ_CLOCK
>>> 	gd->arch.timer_rate_hz = CFG_SYS_HZ_CLOCK;
>>> #else
>>> 	gd->arch.timer_rate_hz = read_cntfrq();
>>> #endif
>>> 	return 0;
>>> }
>>>
>>>
>>>
>>> 	rockchip_stimer_init();
>>>
>>> 	if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
>>> 		timer_init();
>>>
>>> 	ret = dram_init();
>>>
>>> ============
>>>
>>> By using IS_ENABLED and CONFIG_IS_ENABLED the compiler is able to look further into code and catch possible errors or warnings.
>>
>> I don't know anything about compilers but I'm surprised this would actually
>> do anything different than what we currently have.
>>
>> If CONFIG_SYS_ARCH_TIMER is not set, then you get
>>
>> if (0)
>>      timer_init();
>>
>> which the compiler will (hopefully) see as a non-reachable branch and
>> discard it.
>>
>> Otherwise, it'll be:
>>
>> if (1)
>>      timer_init();
>>
>> which hopefully the compiler will simply replace without the branch:
>>
>> timer_init();
>>
>> Maybe Simon or someone else can teach me something here because my naive
>> view on this is: does not make a difference. What kind of benefits do we
>> have, what do you run to see those benefits?
> 
> The compiler benefit that using IS_ENABLED provides is that we will make
> sure that timer_init is declared in a header that is included. That's
> it. It can be useful for more generic code, but it's of course imperfect
> if the include chain brings it on some platforms, but not others (as a
> warning pointed out on IRC today reminded me).
> 

Yeah I'm not too sure of the benefit. We need to have timer_init() 
defined and thus may require "fallbacks" that are just empty stubs. 
Jonas had a look at doing size optimization for TPL for Rockchip a month 
ago and if i remember correctly, empty __weak stubs were actually 
costing a few bytes compared to simply not having one declared. See 
https://libera.catirclogs.org/linux-rockchip/2026-07-01 for some context.

>>> There is even a warning for it in ./scripts/checkpatch.pl
>>>
>>
>> I'm aware, I quite often trigger it :)
>>
>>> ============
>>> __weak void rockchip_stimer_init(void)
>>> {
>>> #if defined(CONFIG_ROCKCHIP_STIMER_BASE)
>>>
>>> #endif
>>> }
>>> ============
>>> There are exceptions like in rockchip_stimer_init where certain defines are missing, so that's still allowed.
>>> In all other settings we use IS_ENABLED and CONFIG_IS_ENABLED.
>>> Hope that explains your questions.
>>>
>>
>> Not really no, sorry.
>>
>> The commit log is misleading and needs rewording. As far as my understanding
>> goes, it's clean-up. Maybe there's something helpful for the compiler but
>> you need to prove it because I don't see it (I'm interested to know if it
>> does, so please tell us!).
> 
> I agree, at minimum, the commit message isn't clear that we're just
> replacing #ifdef with if (IS_ENABLED()) as a clean-up. I'll defer to
> Quentin on if that's worthwhile doing here, or not.
> 

It's fine for me, I just don't want to only receive that kind of patches 
as I don't find them particularly useful :)

Cheers,
Quentin
