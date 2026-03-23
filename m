Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F96EC01B6
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 09:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085BA83DB6;
	Mon, 23 Mar 2026 10:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Ce2bEA7k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B0183FAF; Mon, 23 Mar 2026 10:56:26 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A30A283BE1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 10:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lunrzTmpaG7wnL5jdDo7/xLBHSFvCvgUTS3aVySYQUNT7mjGpkE2AwqiOdg/PSPFmNWv9r330RN9uFFGX3aKQMxx4N/Z6qwl30ubuvlPKjJDJkNzU/EO0Kq0v0RB18fFBaigFMJ5YBycLILqze5VFoNrAUae7dzbozKB73FurrV5DtIPTISzzIhnn9QfALEIK1BmlouOakileoOywKVviJjSyPClAX/AUyaWvKvnyqcef0O37gJ2iukZ36MhXitQEDPEVlXUL6H+rluwpuZ+DCBCgKNCyzkrZXhP1Dg4Fsj59WWt6NUYz3jrpJk1+FBa8dg6p6yxzcB+7czampHJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qEvlIBjeVueuj6at5AXNHnUYHENQ0G6Gq/SERXkJxo=;
 b=aAB6teZ4xtLhLErlStJdHZWNGG1G29hydOzbK0aYfogPq6edXAlgLuPfGz9nkybsH/EdgI+IdOWJeQQjpBnenU0AwK2FcjTh8Ublk1D/bCGiAthdT/HhYgnGi5GVrwFJWgxgkA7jNkbnwfUBgXSJWa5fcCvrQnF+FwbqSu3RxxZYL8PeSz3WauTjha+69Oz91Al7E3stU0Tidb/TswBtHFk4BIF3Qo8QOUGrBC7EJuhRJI8bIhzs5KaNarEnKSw5TPW/LAaPRc3n9xdvsGHBVw46wZoKUZxbcTWTXsVAOBhjMYVTEZdnlZP8LD7Y0edEb8f0KG3q0fuSOlm/P/SCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qEvlIBjeVueuj6at5AXNHnUYHENQ0G6Gq/SERXkJxo=;
 b=Ce2bEA7kUNIGt9DaGo8TkkPaxeLAnRZF3+wlspkM6TRfKL/NOwT4dXHqdfLKk6ns6P+mXN/kHzrbPsdeYS8OWQeT0jk6mWznjoFPt2ggmmgG7JRrgTUgE1fwdOScYlrVxGnuQJ8KnldX3e5xuUcdQiRgOiVELFoQSRig5RwEoD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GVXPR10MB6008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 09:56:16 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 09:56:15 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Simon Glass <simon.glass@canonical.com>,  Tom
 Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] linker_lists: Fix end-marker alignment to prevent
 padding
In-Reply-To: <20260321134626.516665-2-sjg@chromium.org> (Simon Glass's message
 of "Sat, 21 Mar 2026 07:46:23 -0600")
References: <20260321134626.516665-1-sjg@chromium.org>
 <20260321134626.516665-2-sjg@chromium.org>
Date: Mon, 23 Mar 2026 10:56:14 +0100
Message-ID: <87jyv2oon5.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0005F6D1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::64e) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GVXPR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 595ba438-e826-4373-c4b8-08de88c26c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: qmfsPE5/2bUXBCB9in3iByYRwNmF0hBCFxIy1NRiDxvTOmvptJrKRY2JbGPn5e8V4Pbqz1YuTpyCaorhPUq4lwm6yTNz2YaLinkbzbpo1imUVVv2z7epC/1blbdsbiY9ECy5cflNXr+xCa4XYDckzmgK/UD3wauhG2qYSWS00efZxVnlOdm1InAqyo3Tj3iG7Czg5y8fid1a06DKrJ1TjEjxlltJc16Vrb4rqtTolF4x7bMKIGlWSVbXfc41TPYrdF4GBD5unPc2IIPqTvj9D7fYP59vz2IadhQyAVOopffDcHKvBg4y58rQloyLEU7VFjxDeL19TNL54G6YoIyakFZg3nb1YelbMKmBVkW+/j8pjaJHzoVTgsShbsCo8V8XjvgDbYHOxda1KfEA2c+W6kEs0gN+c3EJ5XuPondA5sfRBtWyQ9L/d6e9HnHVMxjrplreuMq5ymvl7/CoPGwInwMr8y/UrITNqRg0mzSgRWHMxWCERcm8GFgpb4zvrJxb8mrer4hUYfTQioJrnLaXKaC183cMh5ReSbmr11mHettm1GjgqM7UsIt0DlmusKFWX2mWQ5VSbKuZgsL3t1+O74E6JYUUnA4xIP4Mr9IKYMSq3oFw5Qgt7kBoYDd3y2zuPOKLEd3wkDQRFFrrLK7otXmdXSxyW06TsAiKcmJ9TaFqpxl2+ijd5yusivrgHQTrlGcavTulhH0Z4WmY+BmhV2uZA3hNWPpjqmWRsGtEl/ri6fbvef/Y/Z+03r2kIg0qkGhsgD/v2VH3Vdu1O0TFfL2qACIT5toJUkZhVc7wGOs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4dIcohdCYadiTl+R7oBxSv8rjtTx8ePDY3zBiy35EstvjDLlOxuKMrCRTpO?=
 =?us-ascii?Q?HrCzid7VMWKt1bhUd8MYPMdlMuQGZzDZojevMLoErLPwYryqENx3FtA+r5h4?=
 =?us-ascii?Q?+sRSDIWlR1/Le59L43PDCNdE8GeNd+eorFWonVT+eSnAuwM+z/CL5VWd9WwV?=
 =?us-ascii?Q?wjydxN6HFl50OHXJ9tlxSVNpvsRoUacOdLcyYS9qlgzO+z5Ny97bUwQj5Hmk?=
 =?us-ascii?Q?GpGyONP3TJCa36uGiwsQkF/+R0tUtQoJQ4eON64juLzkG/1mKUYcWCYIveXu?=
 =?us-ascii?Q?7FOqSn/ILrPU6UXkR4ekPMBnryOCqRmA4oYD9NlTlkAw4upgdUTU/PDghR6N?=
 =?us-ascii?Q?vgmqCyPgAL7NFKueWQkNT1xhFrM9htKZtqbyKYkkCLsTEqKDMWjQqlKWQbHI?=
 =?us-ascii?Q?v1PV+B0g1gZfxVFN3DjlRWF5RIb+jbLY4pDZuj2RJKG5hpEsMVvC5odSSA7h?=
 =?us-ascii?Q?vEDUoARIFCZbMIkCQJo37KX+OU6ieJWl6wxjpy5Gpc0CpraJNsBB0GnA4YV1?=
 =?us-ascii?Q?VFGEoHsdrmdhF1cE5I/9HQIyWJGH0DzHMAc8x0VnhJGNYXsZeEgPMCPP9BX4?=
 =?us-ascii?Q?YLgDyuNzgwVsAjtaI69eoK0AZXIBCGp7u5mDoRrfjuetJjTC4OpoKlCYcH3p?=
 =?us-ascii?Q?hvVjDDm4Rq7d+miO2eCJEk1/dby6bh3iFQR1fk7TCIwcC/XNEgQ9P4o2JQla?=
 =?us-ascii?Q?P0H91fhWBzdjI4d+2+XXPcF3wdBSWEXw6yVCxeNdi4Ffw41UJFkJG86JF1D1?=
 =?us-ascii?Q?Vc3drgJ4OdwF91D/ytSay89nR+Sp7FCYFBqFHFcAXyt4I5zBtfpKHwR4ck5p?=
 =?us-ascii?Q?evVlItE0jKlJGFAmK4IK/GrKbKWYm5HN73Gezwc/rFtMrWnxs+LY5IPptDWL?=
 =?us-ascii?Q?mDS3Eh1QOAbMZrrCfaUG1YPtkmIUBqzXNcY7Fd0Jin2B8kIGhpEBXACEyyAW?=
 =?us-ascii?Q?uJow4dhr5L4ivUodAmor69rv3Z6q38C+2r59I5tJ9bdp1HVP4474u+QcYtYu?=
 =?us-ascii?Q?UAOaey8sj6P7xsLb9GcrjKRNZgLoX24UQEYhURyjtElDhJdNIkR1oS1pem1Q?=
 =?us-ascii?Q?Kn9n6gyKvqqXDZoFsEn9mq/nYRhQlwUfORiKV/gn2FVK3j8BclD2406fL6HA?=
 =?us-ascii?Q?Hp9Jjt+extOwxJFGfA/H1HhKxJacyFwpLSvbGVOJf2dhavZ1LjXbw5q/c1jR?=
 =?us-ascii?Q?hTEQeKoaXLL0EwjDGCai5+edT+ERXmuTH/WnRh2UdKIcbr076fwMjSeRQXlO?=
 =?us-ascii?Q?ozuptAXT2G8fkeMAHX57Y1kysZcMadCU6VBL/8VNNxd60FPaDb+cfM76dxEf?=
 =?us-ascii?Q?zGNpVRHOYo/l4YQPF8/SzPgSh1/QSwG1BO6ovJIqlk7bpYBWSz1D+jbNV3f8?=
 =?us-ascii?Q?zTYzCVZsXINEqSNThbac9Q8Dj5LmXY2kl/tQljNaQlRGTCX6VRLnpKxYhUSu?=
 =?us-ascii?Q?zmrrs98q4NKuZiocD8N5bEGWMuLeOX8Reud/U2YdZBoPkUK8z1Fs/xQqQkhu?=
 =?us-ascii?Q?e/jiyUVuvVtcO1q5Ve4AFKQ2C8AxGW7gJXJN+PQ4aX0frvUN1m7vn4dnQmjO?=
 =?us-ascii?Q?Ql+8CUx0xPnixCi5OAnrwFyTDZSDGkOPxety6UMamISlsmwDdjS+ibq510nn?=
 =?us-ascii?Q?RkhjPAiAZtvSgwby6qPizC/cRe64qO4O9RcAkjZGsf9mwNu0NuCjKn1W5Ghr?=
 =?us-ascii?Q?LQVesIaadedtnfxYrqynOs9z2pV9DSepXQ93oldbg5R5wJF8lq/Kc6tS1OSm?=
 =?us-ascii?Q?RdQj7smYLBLNaj1B/71n4dGFImtam4g=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 595ba438-e826-4373-c4b8-08de88c26c55
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:56:15.8268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s9q1wnVBye3WGZyoNJsLSx/VdVX88SsvCAWSYjKL06GiImC2K1WfG3zzfRD/wspOR1+FV2e55Dzt/JRNwxXEWNHBnfvKTpCTJpY8VGCRxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6008
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

On Sat, Mar 21 2026, Simon Glass <sjg@chromium.org> wrote:

> From: Simon Glass <simon.glass@canonical.com>
>
> Change the alignment of end markers in ll_entry_end() and ll_end_decl()
> from __aligned(4) and __aligned(CONFIG_LINKER_LIST_ALIGN) respectively
> to __aligned(1).
>
> The linker places zero-size end markers at aligned boundaries based on
> what follows them. When the next list's start marker has a high alignment
> requirement (e.g., 32 bytes), padding gets inserted before the end
> marker. This causes the byte span (end - start) to not be an exact
> multiple of the struct size.
>
> The compiler optimises pointer subtraction (end - start) using
> magic-number multiplication for division. This optimisation only produces
> correct results when the byte span is an exact multiple of the struct
> size. With padding, the result is garbage (e.g., -858993444 instead of
> 15).
>
> By using __aligned(1), the end marker is placed immediately after the
> last entry with no padding, ensuring (end - start) equals exactly (n *
> sizeof) where n is the number of entries.

So I'm wondering why that is guaranteed. I mean, the linker is placing
these sections one after another in order


  2_foo_2_last_foo   size sizeof(struct foo), alignment max(4, alignof(struct foo))
  2_foo_3            size 0, alignment 4 (1 with your patch)
  2_bar_1            size 0, alignment CONFIG_LINKER_LIST_ALIGN
  2_bar_2_first_bar  size sizeof(struct bar), alignment max(4, alignof(struct bar))

So clearly the end of last_foo does have 4-byte alignment, yet it is
observed that the linker sometimes makes 2_foo_3's address coincide with
2_bar_1's address?

What I don't understand is that it seems that the linker could place the
zero-size object 2_foo_3 at any 4-byte aligned address between the end
of 2_foo_2_last_foo and 2_bar_1. And the same seems to be true when one
changes it to have even smaller alignment requirement.

So why does an align(1) stop the linker from placing that 0-size section
at the same address as 2_bar_1, or even force it (as we need) to put it
at the first possible address, i.e. immediately after last_foo? Unless
alignment 1 is somehow special-cased to mean "place as early as
possible", I can't see how this should provide any better guarantees
than what we already have.

So I don't oppose the patch at all, but I'd really like to understand
how it actually works.

Rasmus
