Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D8CC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 20:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C37248070C;
	Wed,  4 Jun 2025 22:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="d8C02TuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7FD807B1; Wed,  4 Jun 2025 22:41:06 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1238C801BE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 22:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEdMAVHqMkAZX3ymRNzD2Gz/ypcTTWC8RSigClJu3gHhwCV8YpbBbMsS8mCc36YmVHy6UUUaJ5L4BUJk/4aV9NuBLw28shl4xWMmYpf7biFsshHQ5WytJ7uvCFRNVrZKsz6et1bdWx3oTB3jkotbl1FFzpguGs1be7sEyWHM5oKlllOEvFR2gS+HwIe7uND9FFbokKWZyybQs6/9WuOFB8eecghb/ZtuOxJCLcERqT8fnTwwGNzm5QOb1aRgyrK87zZ/hPOKxlEDEIEotQFcd77yiCBC3mLOUM+jQcXdI6p0JmA7pYcvJG7DMuT6p6rbb4P55I0rqlt4MMLiA+PQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTP07tz3ogPI3H9D+FEG4gOjzO/8vp39DW/zT/v0mh8=;
 b=JWSu1Xj7fuk6UR48nLPdBYyaqcwidsoz5f9bcgNEFIjuLIs/nVfVA8Iq/uBpz4PYeWu3E0o737CiUSbR3QX1EnK/FIJsSz1GiWyMGf2NAkAFh1w5U8WA4Zc2qMO+bLInqFV6okaOA11znrUUTAJdoCEBWRYskjJsCRKuRqZJnXmJJEFG7rTEvagZ8dWTwm+hjEhOweooAiKpkuono6uNLUiHwCL+HECVZezFmSHmczRErIH9jLN3CrA6XHitwgc7+mhFQNe9DBXN1JaesglksNi87e9N4BUFs2SgI7hcwrCaVrUlnjK2g+h1zvr9r5yfsk1NpLK8mJz02mBTxiAusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTP07tz3ogPI3H9D+FEG4gOjzO/8vp39DW/zT/v0mh8=;
 b=d8C02TuNRijSAtquoj0xZHWzJMSOCWfipaYHX5igg5PZyB8L5XVEGFiiqkxLWDVFtSO8x33grovFw/OVSJkSHdW3TGuuMI72yzplJIJDxrEH8PonSk2WW4enP/+IHYb4SUpsi20xNm7uviNUWWSosdW5+XgvWwbBfcvGuVb/MPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAWPR10MB7718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:361::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 20:41:00 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 20:40:59 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,  Angelo Dureghello
 <angelo@kernel-space.org>,  Michal Simek <michal.simek@amd.com>,  Daniel
 Schwierzeck <daniel.schwierzeck@gmail.com>,  Rick Chen
 <rick@andestech.com>,  Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com
Subject: Re: [PATCH 00/12] drop volatile from global data
In-Reply-To: <20250604200702.GS1382132@bill-the-cat> (Tom Rini's message of
 "Wed, 4 Jun 2025 14:07:02 -0600")
References: <20250604195612.2312979-1-ravi@prevas.dk>
 <20250604200702.GS1382132@bill-the-cat>
Date: Wed, 04 Jun 2025 22:40:58 +0200
Message-ID: <87msan1bqd.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAWPR10MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c6b3c3-4ec0-45c0-efdf-08dda3a81d56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R5qm4Ir3gIuvXT+5dECGIcTz8jlYJHaHW/JEoSOTN91F5K712zpB0nuEl6MT?=
 =?us-ascii?Q?UwkkSMtzw2zy/8xh7i9grfODYwg5lscL7t/IXW8yqzOlAms0ggbZUtYA37Y/?=
 =?us-ascii?Q?lQTd15su4fNCzqdNewBYcZ+2WnUtT6v+XYsaqDOkYgUQFvVZhHcqIWtgYnkl?=
 =?us-ascii?Q?hsVe6uufHWo/4f8mB81J8FQkD4otrnfjFBrPw+LpLBamsNpR9DqYrdtMGmIh?=
 =?us-ascii?Q?Bgd+u2PHvYz9b+7Wd0oGPZThli6hvqs3XGSsgrYArwWQsDyNI4sAt+WxCBQk?=
 =?us-ascii?Q?yQtvEx9K/aRLb5LZypcsxJ+T/KjdQHb/CYedBjSERovQAt3O7QC1GvrAINFI?=
 =?us-ascii?Q?NYPlq2gC4cabHSDe+bP+iGpk7dYzlHeh7G1hW0WWdA47/uYifOLWkiXWxm4L?=
 =?us-ascii?Q?KNai3xcbhoo6ro1trd5Bmqt/JgJN3Er2Tea7Gx5jTJ/3m8uZOzqaxhr27X0U?=
 =?us-ascii?Q?BquExfQDYi4tJ4CxUqj3AhfuZCtBhvJzc74vMVOx4XINHbMB7jQKOpZou7Pw?=
 =?us-ascii?Q?U9H3mdIcKcLTWblUlKOgXDWi38EY9wZk6uYq6lL/L4EWzhF7ituz174Cd6ra?=
 =?us-ascii?Q?Gi10Ias/uZuQx/QGRLP3kuxAPquc5JemZvjeLMYhW0uRkyrObbLoJ8pq/KdO?=
 =?us-ascii?Q?6SasmdHmVygnNTXX2tlzqXj/1jqgJXgk7Y6Ploo3oKfOHyXuTcBZDzLXZl0K?=
 =?us-ascii?Q?GM9bMJ9rZr3eyvx/AwAypxGq9DA6EEgTX9AMogStbcDSDgdYNuJO2KH8869v?=
 =?us-ascii?Q?LMdGlYvHE0VszbQ3zzeRjXCrYirEF3bCMZunGymbl9+f76qk+AheJhqHqZJs?=
 =?us-ascii?Q?1tBPTothHTw1vIB9o16Hj2M49O9bPo189Y9sw6lWL9sZ4qklIhm5hRuUr2U3?=
 =?us-ascii?Q?Rs1Y4O0Lh/1embCjPFzYjEC7sj221na9TV2zJ30ztvi8v5OBU3AfB5q1RQdC?=
 =?us-ascii?Q?xkHOZwRL1dct2j0geHJxXjwDGePvsiRSmGF7Mj5rYvOyvsowsTlkz8M/MpCq?=
 =?us-ascii?Q?Sc1wCdWwNuCDnynmhfXCDqP++tjD86gjy97/kWJcxaXPurxlRR02FZvDEGVO?=
 =?us-ascii?Q?MfBNdakHAtqp29SRErv7ys7EQf+bUODMU+gX8GDJIT2lmbbm6xqDe1UEaAU6?=
 =?us-ascii?Q?WEDU2XMCE7C4gMvsVi49vzBRZ3FXVfORAWyzl3jQHJVPQqouFkmqFOzIrN7b?=
 =?us-ascii?Q?40Eh2jgmTGUbRsi1EzVffhGankYv2oURuCfJ51SEYRw5ES6x29zp1AWx+LI5?=
 =?us-ascii?Q?p7+eDKBXba8lbQq45SvRHNiYZNyMVAqua128KkY48ZKlKLc/n7gVzUQ0MzwT?=
 =?us-ascii?Q?PQLWh2DwTMVmJ4ReQsK/TGOAaciuIT9IfpeB9ggjnmOr2dW2DD4qI/k5JU4p?=
 =?us-ascii?Q?swZy7AQHeehWG3jXl8TafJoYXLQXvNz5+SFdEIGro/pSTilTehJ2A+upDdYQ?=
 =?us-ascii?Q?vd4HY2QpQK1ZtqalGXxtZw9mCtPFar3NT1+NxT4QFummzgy5K+flQFrmAQEW?=
 =?us-ascii?Q?Xx7774Nb3jXw6/M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YIfb+VKO9AvpEu3veoXMWMhRXxo09pr//2DkDAOZbuOOQvvBX7SljDtEweTC?=
 =?us-ascii?Q?iKlIeq9EKFy+QiYnZm1QEGW7UpuOVdGKKpMpokDCSGboykUGwUEGa7U6AJOX?=
 =?us-ascii?Q?PxsASd6zpQK74Ud97DA2Y+iGzlHxNahcq0EZeyK1pW/bJRTNuP+TYRLmgoCO?=
 =?us-ascii?Q?KbbVSnOiKcuMFKk4wdssG1usaB2GSaKeHAAE/5pfgL62ZDJdRsAGm0RdGuZ5?=
 =?us-ascii?Q?hhCGlgKrI/BXbcYkoNBtDyq0a3Q3WER1T2JFx/HXCS+crF2KOsanMvpm/QKg?=
 =?us-ascii?Q?oL+6yfpIDgwQEosM5Yjm6ng00KnLrpvhV45P0sn04DEFaRos7yvTEy5RLaqP?=
 =?us-ascii?Q?QmTihqhrw1ZaMSaLJHC6Qpy0UwghexqQegVW7eoeD5lr/fWv72Q454a+iAgs?=
 =?us-ascii?Q?+EiwxqUUY/m4c5lmp2ZHhzT7OUsuMUZWrYJtJ0XMyqB2jkUkevZkTm6b6Cx/?=
 =?us-ascii?Q?6lD+3JY5VeNCeANG6ZigV6qVNP2uzFpN+xts1SGuw2RhlrbWbSL4w70EAvUA?=
 =?us-ascii?Q?ajpO93P+o+R+uwHQPGbzCW4UsQLe5/nyXv/TPYkm9aOOxiwL/CdEsFwwL8lu?=
 =?us-ascii?Q?fDX4AdU6QG5b98VIA6lqQBi6maO7DLututPXH3s92ynyoG/vhokT1LSmRcEQ?=
 =?us-ascii?Q?4cOX+bmxEIQX+7vOU/0kGTD3R6sLnWhQb1XAmUxLPEd36gZwRgeKylusVtBy?=
 =?us-ascii?Q?zLLKoa4Lnb4CbmPnV2+zTI78iz1YMwfoqmHE3zihsX4UZQDWphi58KobeSJJ?=
 =?us-ascii?Q?g+uP/In6DXC5NCLguhX/UM4anAQoTvycQU+TzpZZfXmjm2VnfVx1cxCH/lyz?=
 =?us-ascii?Q?fcI40AVb0pXmXWPf4k1wnnm9ZAknijNWcfhKtZhzb6kj1SFkGvmqzS/NExZ/?=
 =?us-ascii?Q?5yDDl5DSyfDNhywVYTZCsjlemUQBfKz+Cpq1G91lf/KgbQPTfqnjf90cNnYs?=
 =?us-ascii?Q?KUclZGEyhN25rUNy8DZaGSt+bEbSJVjsTrxJ6DqB6aM6eVJYgWEEP6/jDu4F?=
 =?us-ascii?Q?5SLzow/abD7N6uQpjidhBJtulIeUT+gJ+ocEs6YcC6jbedMLe9qimJ9y2dr8?=
 =?us-ascii?Q?oorTfTyd+vZtzqkhs6qI23edyIcYMJcAkV0zXZMhqvbF/FWBA+pPEzyub+VS?=
 =?us-ascii?Q?cczj0832IV7XRV8NFUk9KlNx0XorR5S8G7odOsATQJMbEQCgBEfrSuqBlH4J?=
 =?us-ascii?Q?yQq/qB+8prCnXH2/Vlo3kDY407gKuN5faU75Es8M9B9I23IZS/N2yQYpHXpv?=
 =?us-ascii?Q?7DCm/btTjcqE5ZLTeNJ7A5V5oV4FPgCQ0WeJ69eR/Gr8UiNaQpY0oTDKbcsf?=
 =?us-ascii?Q?OIbP2GDnarICIMhRAygHWMosm9TSSQM/1VW99l2P3uShM4ULrQ5plbiMi3wj?=
 =?us-ascii?Q?ynPbVEhvbmSwzq0x1vAtQ8NE536mA3G9LzUioUJSKLdOGwrT84ALMZ8yNfZp?=
 =?us-ascii?Q?7mddYB7A0nCjjDgO1g40Wd/17r7x4z5X2IbHoqK8by644JCl9o6GcgakKbcp?=
 =?us-ascii?Q?frDJvGnP0gtr2ISPNZHAleSvRH0YTwE+NVFo2Vs0NaqcFTrTTrxKIZDC1T6u?=
 =?us-ascii?Q?Ea4NeddQApURSsZkBrdS7A/dERqM5p1J3HHfIWVNmOX2ebDlaoNnOiRlRrIk?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c6b3c3-4ec0-45c0-efdf-08dda3a81d56
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 20:40:59.9589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TAPQVNJkYlVUwQNiGNRw4tK8N7xHgdaO54x+P4/bZdnaY/c6OphtiIUcke5gxK8C2RhXoVhxs39x+rkGUm56j141DRgu/qoblVfz67zg5AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7718
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

On Wed, Jun 04 2025, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Jun 04, 2025 at 09:56:00PM +0200, Rasmus Villemoes wrote:
>> There's really no reason for the gd pointer to have the volatile
>> qualifier.
>> 
>> In fact, I claim that it's completely unnecessary and just pessimizes
>> code generation and forces ugly casts in lots of places. For example,
>> see the casts in drivers/core/tag.c where elements are added to
>> gd->dm_taglist, or a helper such as cyclic_get_list() that should not
>> be needed.
>> 
>> Also, it is what ends up standing in the way of an otherwise
>> innocent code cleanup of list.h:
>> https://lore.kernel.org/u-boot/20250522165656.GB2179216@bill-the-cat/
>> 
>> Note that riscv, x86 as well as arm64 with LTO enabled has not had
>> this volatile qualifier, so it's unlikely there's any generic code
>> that depends on it.
>> 
>> CI seems mostly happy:
>> 
>>   https://github.com/u-boot/u-boot/pull/775/checks?check_run_id=43463083829
>> 
>> The one failing test seems to be an infrastructure thing unrelated to
>> these patches ("docker: filesystem layer verification failed for
>> digest
>> sha256:379cc6cd06dc3fc80e31d5170204c0cfcc25cb3b3ad457ced23bed2b38ec9f36")
>
> Azure seems to be having some hiccups, sadly. I know from my end I can't
> hit "rerun failed jobs", is there an option visible to you like that?

Technically yes, practically no.

On
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=11303&view=results,
I see a "Rerun failed jobs" button. Clicking that, I get a popup saying

  Rerun Stage

  Are you sure you want to rerun failed jobs in the stage 'world_build'?

and after clicking yes, a banner with red(dish) background appears at
the top of the page with text

  TF400813: The user 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa' is not authorized to access this resource.

and after that the "Rerun" button is greyed out.

I can do a trivial change the commit log for the first patch and
force-push, which triggers a new round of tests, but I don't know if
it's worth it. I think the current revision is the third time I've had
CI chew on it before sending the series to the list, and each time
there's been at least one test failing, every time for reasons I've
deemed unrelated to the patches.

Rasmus
