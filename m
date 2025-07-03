Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB064C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDF682F00;
	Thu,  3 Jul 2025 13:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Snan6F8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA5E82063; Thu,  3 Jul 2025 13:37:41 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54B9C82103
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTRUoeS80M3nTl9q7g/nImSfVmSbmGdCyFp0sVvCNEjR0GRkNqafruLb/aDmU3z+2SsasUtXZh4RPgjRDnv1v2RT9j9B40Wc5xitNCWpwcFEppfTOevWyMjMaLNUaMgBfDBpmk3lQEEG+0ssK4z6daNJs6l08tHODGIv59eb+VWddHxVQPqa/3O0NzuAww6GNQEJkP8qqoekJYp8eIvYDdxwaaypyXajeYEEd3Y1Sd4EggBKN4rkdwI/4/LQMdzI8RKO7k/EQFxBEJCKKYtoytu/HzQC+mdjurqfRRFFiGeWGhcsrb9YY5qyy+t8Dd6xs7Cu12arI+C8eyOzL7gThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU7X0riYkNkoUZiZ1yUFqyuhhZHqQ9ztm/Uk5a/ZDLQ=;
 b=j8ICIKtmQ2nWbHnxSHxvxirJqzK5R+ISvV74XeROJQbGBPNh19hSwJgnXxF2zhyaCofCCP5W5J1SUU8LfL0XYsQWWR5uOwyIn43pNGfJ+WE64F4tQwzDe1qG/OhSIo+HbKD90rI+mzChzJeI2QKIXQRU01F85s3yaqCZsSd2/pzMQuQGWgt0BPtz/TWssxZ+o/dFCsNJiXdD/qa1vC+fvLYF6uSZpWiWjvqlMfelpE5fJGKR7xAqdbN/mAH00j6Mx72hDnoCeZnG/Xg2Y2AlGM26LLzu2LNLLkCJsl7pBPBYrqGGEfq9BvQP3/BPqoJ/Z9L7Jae0fJ85JE6p6HuRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jU7X0riYkNkoUZiZ1yUFqyuhhZHqQ9ztm/Uk5a/ZDLQ=;
 b=Snan6F8pzIqmXXnqO/hjAqPTS9w7s+b5A6u1g6H50BDNaz+hL9gltS3uBYnkRwWAtuT+rratZys/pR1+gKb9DzaxQagBZKfN837U4l7Rbv9s2WdVzCUqA1jmSUVb3xjJaDorh1JUMBSvXrrcjBN+rMc1hrqUoYdW4jij/XwdgLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS2PR10MB7573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:544::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 11:37:35 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 11:37:34 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 0/3] integer limit macro consolidation
Date: Thu,  3 Jul 2025 13:37:27 +0200
Message-ID: <20250703113730.531225-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0116.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::33) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS2PR10MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f808840-e3fc-4321-9b54-08ddba260124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8rDr6A0LJbM1GtJpHdEl34dWRtSS86abTT8MOPDs4boi8gQHz3NF1KtoShHi?=
 =?us-ascii?Q?OnnGA3DrJcGs5eO+stg8LVEEzSWP/MRTgsrZebki6KlSuo8d9rxVLNAmD0nE?=
 =?us-ascii?Q?0VuGwh/ZncyzbxU3d9jfXmhoj0SvYwIIZeggh+Mz559JJ++VZGQ10EJ65zRW?=
 =?us-ascii?Q?7loV3w4kwGao+5DKSMkoq0xqQPjjIcM/nxjShEFclgAZGVYflb42W0ThVgQS?=
 =?us-ascii?Q?gYp2pnyDiV/Ox94ugJReXHM5uLKfGXbAct5PVJAjz0hiVtARM2AQ81KIcWMX?=
 =?us-ascii?Q?uYiFD8ryhXMJ6wMri/2ThaOz5F5jPV0b5ok/UfzQ+ZDWyyJGU18VG22sod3z?=
 =?us-ascii?Q?gWoV4BqnKrN8HsQQB4ta4Pzvb4l5KT50Jxh3ZVEv+Ej+p+Yj3bhW8gECdXIR?=
 =?us-ascii?Q?208D4OJSSB8ae7hLM5SZui2VnHVUN51Noprd3c6lny1DC47657aoUK8J24yD?=
 =?us-ascii?Q?MnTnADHgmSRfFNWuUD0dLxbv104lUrRwHpTKE6grtt61P0aORe4s71OvB0U1?=
 =?us-ascii?Q?IX3G/X81EwGTQfpddj9nQijTSSr1woJqsa5+Y7Ltp71L9deLkG+/205QQs3V?=
 =?us-ascii?Q?nuZjQERbzomPJ8sfSq20iN1wi661CLfYqoj4+pUWn6+HVpqozJoYvJPqykKD?=
 =?us-ascii?Q?dDLbqaS0A9ohnl9w77mrqFKse19WW6l1G4zDNmTXxSt1QB5ebJs5HAtulJXL?=
 =?us-ascii?Q?Q6arVQDFjDDLd6q4zAtfjrbTvc6NyTtfXUpqPc2HjOrA04KmHkan2i4Fi5IR?=
 =?us-ascii?Q?DhkJoLl8enz/BoPCfPhiD69hloLBFhRESEIZ5n5U7rmRasqNLUrWNjXehyvU?=
 =?us-ascii?Q?a3+Ql0EcayIyXtMFJ6KYE9fR42atrltF/kwy2L8a8vSlun8GtKWEy6vI/u3H?=
 =?us-ascii?Q?y3GgWLd3+ze9P13s0rG9UZPGExpTKuuCeOsabQC6VEkvPjQbIGAoA3prWKyU?=
 =?us-ascii?Q?1aMBaEAWg0Z5iGHyfH8JIOjlQqO1jjlrP6nK6rjeJ/3/HlGHjYVnPhx3TkQv?=
 =?us-ascii?Q?sumrUxr+tsL3p5ZafFd8gJ62KY7Ng162MYfJdIErYfN27aXugzHfGn0HoSC2?=
 =?us-ascii?Q?fvtlS56RLqUCrNIqtSYOvILLheF3InogJv7CbnOXlmXO61mmCeBIjIfLC3MO?=
 =?us-ascii?Q?dpIbVLzqgIQDaw2x6aM6EraIPdXQiVqlElCoiXj9cWUTM+WhuiVXwPPJjpJl?=
 =?us-ascii?Q?uJiaw3rcB6JEhZ2VFMPV0guu0tsiEwkFM0Tp9Tvj9iWk4gwUh3XrCRhQxCY8?=
 =?us-ascii?Q?xV+b7xNHzlK6Ra0TTIVPLLQIegK/8+SkNX+18K5/CgaPveqGh9Ex7QZYHFMq?=
 =?us-ascii?Q?Pb+csYn+Ek59D6jT6yWBpawYlxoYmFH5uE+v+bF5NHRNXlLQDJwvGhHSG+GM?=
 =?us-ascii?Q?QcJcW6nzc1EeUsRoQNOQ6MxondhSXB9H0BHjL4+z856HsGRyW5rzKpn3n2BK?=
 =?us-ascii?Q?g3OiQb07oXfmilFBUZSH4yn9Di9Ue3XqcvOMpj/iL+rOPd5+YDdgpg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GbZg2eJl+QPyx9cK+kyCvk0oCr0a4TAsNpkFrpCr0gtAyZaFPJr+9+gEEcbY?=
 =?us-ascii?Q?vyFn47oagvw0Igc97AJitFaiy8SQWNBQxi5ZFq3mLx/YWr3P+Jo8znJW7B+v?=
 =?us-ascii?Q?iW8ttgNLDzumsicV0i8K+EEDepHZzezZkefiDd9AvgSMm0j6/7zObNqZoo3A?=
 =?us-ascii?Q?UW6Utjhsotr1GwOAMIeRncte3haKI0UMyqwyp4oHtgO/aGzvZoXwsc2WJXKA?=
 =?us-ascii?Q?JhcBLXuoUHbY+Yd7xbj3PElGbWEE1PsoQRR9RCcYrkhfgrKBWPCcrZdJTmhX?=
 =?us-ascii?Q?Y1rm1XDMad5Bg8xXu+YYSskgbrdyxETDjym27aqqvCl+Dz6xe98Y8LbYJUSv?=
 =?us-ascii?Q?YMMV4n1z5wBKsL4YTWaKML3zIQMP2L3AYOmzH5oXyg1t8McFOh+qOdskAy6t?=
 =?us-ascii?Q?CO5eoIuJuEm09EVh80QaSpFZ6o14dWVUDmEcLcvdQPkG4Y9dl+Lz842viVam?=
 =?us-ascii?Q?NRvYvd5rZcXs02TllCIVLjWy03PVyxwrmW9wR44gf7/VhCbUKocAXMU2vpQn?=
 =?us-ascii?Q?3uHj1+pnF6rrYBZdRGJ52zy+wFxgC+4nNKW+CvD1MEKUzavCpWjoYc6mDGLr?=
 =?us-ascii?Q?TMnv/61FSWZS7UplTETg0flJ7q+NI6+qh2ay1gWGF6EQPJ++ZHVfbgx/61aV?=
 =?us-ascii?Q?Lk2ixIlIRGtgJGPOb1IaNmOx23wNUHTpS2/WCflEdQOVvhB7fhn5fxBjU1SU?=
 =?us-ascii?Q?LY9tMEffLQLyLG3/NkDClnaDK4Khr1E7QFw8D+/x7A05pEu75PZUNup5ZNz3?=
 =?us-ascii?Q?oZmTsL9hWALJNySNhvbw5LX+iiMUDEBl349SbxTuFsii9JbqkRRDscp6quhJ?=
 =?us-ascii?Q?PRVMhty9sT5JTIXC9HkJOhD7KREi5MZ2VAaV/SHuVnC3pmbnU9uRZHmcnriZ?=
 =?us-ascii?Q?aQ6+ZFrRk88sHgOtPuEoAmoiRX1aGr0vXVpielIPQEWe8xd8VootoOdEZRew?=
 =?us-ascii?Q?Hq4YbmNKzZsjPmbwuF4mgys7ZJZVfJ2WUZmT3iRa8lzn0DZEbmF89qp37QkT?=
 =?us-ascii?Q?56X4bE3OV4ogpBONH3Oeejm24fBbkcc3HIrrEE+KejcmuXx4FSGbjFrtFpBF?=
 =?us-ascii?Q?y4eVf/VuWkUCZ1kZUyoVTw4MllBs2jDyexDn8hgWi1wQ7vWw3zp7spDGtfoy?=
 =?us-ascii?Q?IX8ZaTRZ9SDbgRn5ni5N8ri5oOs+gkHr7u/3+moIuCEj6LUp+A8csk7grEGT?=
 =?us-ascii?Q?BEy5qbRWTobWckeZ7y3lbUeVvbiNq4ExvOkzVac0I9Q5FLHub5rwQtAv3Gd/?=
 =?us-ascii?Q?1MSxvHFZ06GxnRD9jMmarl6b0k4HgOITxIrZt4rZqO5xCnCHK2wsjN+Cw/S8?=
 =?us-ascii?Q?lOWZ78gP0DMvuU/IPKrVGbLPQ2TTlNHkVI4usHwbttwYAbYBloy3NQIYejE7?=
 =?us-ascii?Q?TZ2CwU71+F03iV5MvEa8FilIoUBdb9npUacB6pjERRZKhaAe1NpdtpkKfYeI?=
 =?us-ascii?Q?i69alqCblfF9sT98RQHCOjIhH8+0b3ubcJWSlMT+mwRIiwRpYTeoeJfHmlid?=
 =?us-ascii?Q?gRuPugdenVr2ymPuVoZD/ibZrjW9JZa4DI8FxVqxirM3sacyU4jXmT6WOlrs?=
 =?us-ascii?Q?G5x+l7Mjv6F5smTQy3d6l7KfEp2MdIZWoR/NVsdW0qfApabUI956k9qogT1s?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f808840-e3fc-4321-9b54-08ddba260124
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:37:34.8579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLafhiBsK+ci6XVudd+h87cNXWcOK/JuHlwjsG2tdiL5CsEvjaH1H6/qwOAVT79H7+y/g4rVslE7Hao+HBCm1h0A7wVVy50VP2MJLNgUVug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7573
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

I was bitten by our limit macros not being usable in #if conditionals
when building a standalone app. It turns out that the work to fix that
had already been started by the inclusion of the mbedtls library, so
it's something that people do hit.

Let's finish the job by providing suitable limit macros for all three families:

- Standard C types, char, short, ...
- Kernel-style fixed-width types s8, u64, ...
- POSIX/C99 fixed-width types int16_t, uint32_t, ...

Please note that a naive approach like spelling out the full decimal
value for the constants doesn't really work, as there is no such thing
as a "negative integer constant". That is, doing

#define LLONG_MIN -9223372036854775808LL

would lead to the compiler complaining

  warning: integer constant is so large that it is unsigned

and the type of that LLONG_MIN would actually be "unsigned long long", so e.g.

#if LLONG_MIN >= 0
#warning "LLONG_MIN is not negative?"
#endif

would fire.

Rasmus Villemoes (3):
  move more limits from kernel.h to limits.h and standardize their
    definitions
  move limits for sNN/uNN types from kernel.h to limits.h
  limits.h: provide all limit macros for standard [u]intNN_t types

 include/limits.h       | 58 +++++++++++++++++++++++++++++++++++++++---
 include/linux/kernel.h | 26 -------------------
 include/stdint.h       |  2 +-
 3 files changed, 55 insertions(+), 31 deletions(-)

-- 
2.50.0

