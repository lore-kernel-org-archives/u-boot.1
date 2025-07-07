Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE6CC83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 20:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1C483264;
	Mon,  7 Jul 2025 22:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="S4XjMyo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6339831EA; Mon,  7 Jul 2025 22:37:11 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EEAE831D6
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 22:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NS4XM0b1i8oxxTLV3EWv5l2TQt5lMWz4+nEPjbvz6TZvIC9e/pmQCT7WthBzgWAnG6f6v8soIm++3r7Z04QBV1KdQorU62xh1EdT89Kt58JphiTIISXQEzp7TYaFDNls/d7FNiUsiDdZzjoW0OORh4Yv/8wmiRdfw+2UyQw9ITXL/I1eqEGeopS0Okxek+q9iHtfkb/bX9VAloMNxCGzWCxs4isow1rCV1TTn7BsRPIQYyBy39iN0JBhhQnhZPfRtQzpoWsGWxNt15qpzljjv7sj5/VwL+HNay7PQ8oK5Ujr1+6wFKUkQpLrCpIFZ5ROeGsEQFfhgHAjk07aaib2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfQmDnj+G1EAZyhTjHUwi52OTekXMfXTOFzZWjYiT3I=;
 b=CgnNH3bFaFCEaZMVYjuVSv944/pjwkoP0LAfOW2Hzo6WLKDcjYJVcRbZiKetkvJP48sjXPygCpuD1KnrrzwjPzFBve8TeFRPUptOrVPe1w3/RzuA35dGyjEqzT4CAHu+YBTEiDqCwt58KPoqxyjfFZsmGB21g9o7GFalAT/Mot1ECv0ZZY4JOw6F6MFZbdKPJRTmif3o/ZBSy/G8ftM7WH1JXiZxRdh62B1Z5lXYILKZfoAbS9f65BCl1lYuRR7bzNNSQeugJJdSmJwUwoNoXKKqdIh7ULrHnnpTvZpIjqSMLFZHUDl7prb8Qs/eVYQSEh4VTrhkKqecG1CNOKBypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfQmDnj+G1EAZyhTjHUwi52OTekXMfXTOFzZWjYiT3I=;
 b=S4XjMyo+CjnJXIsxpj4Y3kdm+7HehZfoHljSTAY5Z3eu8Ukht3ZvM8UDwh5GqO274bIBaKUxWcxPxWkNHBNLsot8tXHfW/D8qVzC8NCGzq8m9Oz5uIlRqn6+rYINJEn6N4/OADN2WX1tMKd0/q3H9SonTVZxjUV1SLMfftOPFhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV1PR10MB8860.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 20:37:01 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Mon, 7 Jul 2025
 20:37:01 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 0/3] integer limit macro consolidation
Date: Mon,  7 Jul 2025 22:36:52 +0200
Message-ID: <20250707203655.613340-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV1PR10MB8860:EE_
X-MS-Office365-Filtering-Correlation-Id: 965e1a1c-6808-40d2-9dc1-08ddbd96069f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NUPcWVP6V1JNqSFh4DkCx0pIgS9yCwFHQQ+hbTB3uUrJm6LPh57QUB790tDQ?=
 =?us-ascii?Q?+DDt/98AC8Vd4ahH8aVnYsFlyzAn1ekhf5rrU2HDH9Nf/stR4hl3nXW/h6UZ?=
 =?us-ascii?Q?AXMp8aPUAyp76gEuZtaFuCsqtejXvRRbnR401inhvTqxGi4NQF2sUgHhElKZ?=
 =?us-ascii?Q?PHcabXNrzUSCj9oiGKzWUW6uzArHgOK9rOulX7Yo94aNa1rrhG4OOcEsldYj?=
 =?us-ascii?Q?DaPAXTudxVD45y+Bn/EJh7/AeJJkfClQsmo1EnRDt10Pr0ZpstC/FRPMvBeO?=
 =?us-ascii?Q?/O6kw/rE7D3aZ/KBQAGEDdyjCnhxbKO//sH5dBXLAEiFp6YaX85lVrtZZwNr?=
 =?us-ascii?Q?0QCiO0OPXffM3uo3nH0P4YmTQEa+E8KslpOsBOefQELjfkpWl4aTHrzayMaY?=
 =?us-ascii?Q?tX1gc855nhH+cJCMZvVYcOfMXNmnxhz2QonhlLeaRq09h76Vs+E9bgLdgJtC?=
 =?us-ascii?Q?UKesZ+0KrqhHE6blGIEKMlaqWJhWS9EILYZb+PmQQLcHsFOnRe9wB73soz9/?=
 =?us-ascii?Q?x9RcIyGyo7osJG2aD2qiWu9ihgVPVpw3oTwPkN7jus+l7wHPs9oxwW/RVO8D?=
 =?us-ascii?Q?rzB5HCm3w8zHYp4c15zkFefiXbc93Fhi2xKcG53FRcEFDCgDCQUortY2dWeJ?=
 =?us-ascii?Q?BrIrylJ2XX/NCkHrqZG66tFbOeY9yr/TCVq84dBGDjakmxFXYKpU/JvwIPfU?=
 =?us-ascii?Q?jOl3uNCPJSWu/ijC4JrSr9WyOjc7t04w6XyzBklcamTBdT0DieT8JylceGUI?=
 =?us-ascii?Q?LJGE8N78MQerX8PnKDqZg1vKHMEQMq5Gz+SCp/B62j1spZ8vQIBQ+vQ6JYhJ?=
 =?us-ascii?Q?PfsCuLxJO44F3A2OT0ajlA8JGEirbrmmPi1PjXpVyRffPdT5FY+3o7V5OCzF?=
 =?us-ascii?Q?D5ts0ZF7tGbhgMVePu0klIHbzt8qs4kqhRPShLKB4WpUighks8e4r4l8cgeu?=
 =?us-ascii?Q?ymjjUMKfxE2UsOonmAq6trm89jEYb68E7uqVe/eGrxgD/htGIxECVLRtOvP6?=
 =?us-ascii?Q?QEnGVw/aptmpyUnYuxMWpCQ4ABOdqCYAhmCKplihL2BG4GbfMCeOB0/55ss5?=
 =?us-ascii?Q?MKywCBffmj3i54iq/gmlRJ8JuWr9V7sCTlJjwEkVUhczHnFu69vqjPa86Xx2?=
 =?us-ascii?Q?1G5GwA75r+H8Pkt+RGEmnebMhX8AuQ+aQDelzm8fYegTKaT6gsmhbbS1G83I?=
 =?us-ascii?Q?XdFCHCj65Em/pnja+CB6mfj6OEFb7eL9Q6IjZA1CIs3kUlZXPn6qWAp4nrCc?=
 =?us-ascii?Q?3sQznZ2j1xSa65b77j2GZsKK2t7yD8smZo08uYC/8PIh22+ZCn2oXpVxeYo2?=
 =?us-ascii?Q?cQHaZ+v07ll4cNzcFCejcdJG+6mseVhHAmNYREReNG67b/i8mVnTnAfN9LhU?=
 =?us-ascii?Q?50ip8jIAqJ/6nPY7rWhvE96+JERHq3i8jyfGuBAB0YL6CLyhlz+iCllh7KCh?=
 =?us-ascii?Q?ZH8bmKLKKqajzrjA1RHOl70MYIqE43Zfm9ryx3pgu8yfD3g+eelviw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IvHdeZEpluVIbTWvECYUjvFkS3ICJ7JvQHeB5hMii5gQqJxv3K6b8AZqdzeH?=
 =?us-ascii?Q?uA5x3DIxcmlFG2YUkqL9KvUDcVbh7LsxY5UJJMcbz+c12/8ShJv0R/6AR9oF?=
 =?us-ascii?Q?XvnUaftwpb4XdstLix9bSOXKLsYbsnq8p81xRBfRlCd6mEZmhUZHszujUWL9?=
 =?us-ascii?Q?N0zcqUbW3+7tFYdDq9UlIL3eHawnIWYTRoWrbJtV+T+Xq1EJ5T7rq79Lg4qu?=
 =?us-ascii?Q?5F554ptsTLi4afyK6wc0VO/2Cp3QQPR1Sbtv8I7CGF9JxGvjp4qoOG7xhlWR?=
 =?us-ascii?Q?KvlZZ3TsagDnsMaPU+Uib34Qxgw0h6AH3qXapZT2qDimGw3bEu9HA0HfyGzh?=
 =?us-ascii?Q?/+jacc66C7EWR1bSn1FbTehtGDdYbCTBGsOmfooB0qnvbDNMaB0jCmfcwIi5?=
 =?us-ascii?Q?CG8bKqyQ70kONGxd1UO/MdR3QeWTPndV2UGlRj7lzQeJETPYTcH+IvL0MFRF?=
 =?us-ascii?Q?zWPaltRfhp87Cbs/Z/uUbvcqdJ0Ti3hllZKYpPpdW0nGLYysxvlkyuycdWv9?=
 =?us-ascii?Q?+e7jtcbD3de0H+riyr/hthWK7m4mpRVCXV0bs6eN5Jx+iERPtEaETYfwbl83?=
 =?us-ascii?Q?sXCE5BM/JPNOS0mNEFCV7mX2rKoiQTBeIealYwWacg1Ek5Zy3cuJg59Mw0Ow?=
 =?us-ascii?Q?R1Mpgr1ai2m7OCo1kfBBpH1/n4z0WCivj7BzZODEJWUk6PZnSaN7oNmBfBzV?=
 =?us-ascii?Q?ROIW9EDpBh270O3TBtsCUKO6ai7s/ghwVU5Uj1oTJQM02fTF0csM8BwRDwIK?=
 =?us-ascii?Q?Pykf/d/JYxAN08siX/XJBQid3TnIMFwcEMIuIMKtylXEJ8d666SDeedSdozQ?=
 =?us-ascii?Q?y/LMZPsIEo7BmGUHU1IPb0/jztpDkAT9pwId6pDMf7E9uEI3YYE9BK0r44Z+?=
 =?us-ascii?Q?6ovVDlCggKyZxIYMEno/KHGnf4nlCzhC5oLQ6eM9eQKzfYp3AhRMDw7UDT/K?=
 =?us-ascii?Q?uYlHdlCObLrk0Lbq19MCRe2YWT93Kk5P/eHDUq+zkkNaTOF+cUmlys1/273F?=
 =?us-ascii?Q?86yARZqAMq177x3UAjnMJtBLe2a1c+4dPxp7ynt5bjo/Y/8hIct6Qe99Hjc5?=
 =?us-ascii?Q?r5BSnTvXka+PlGPpWWvlpH6D4q2maq6kVWhHOYWWxAAH/4If9j7WRt92PV/n?=
 =?us-ascii?Q?w9YDIVxx7s/woe5TkfJGHwS/h0TxrrMso2NbdnRzh6UwNay9qewM4ynmI5ih?=
 =?us-ascii?Q?/kf18DHbtcoVA2ZdGjvBhN3AMtfrJjBjIQeCr4IU32S/uybirnMZYfi57mFy?=
 =?us-ascii?Q?rPsMW/hETph58LPfzgFHMeUjwvVdu8PFi6xErP++d4c3dvB1DEuqeseumjS+?=
 =?us-ascii?Q?ty2cJ0n/yu+VF7j8KiwOIvTtTRqDzereHYTqtx/ViugsZoa+nKvMT93ZRbZc?=
 =?us-ascii?Q?1scr8PN4XTF/ViMG/5H8wRJeVPTYvSvWGdQTjD2EHcTp6dxLx8MPhGAC86fY?=
 =?us-ascii?Q?Ox1/IK4vhA16/OK7YPOGV5qN/ZGAn62JQKh983MpgSK/isq35uCwKbSeVxCA?=
 =?us-ascii?Q?wLXiOLtWoiYXp9ol8pGuWgMewA6jPv9xWfvYZsq7O0sSu10sVZJNmC8aHs6z?=
 =?us-ascii?Q?h2Ph//ZEDvUkycpDcD7U4RddkPAnAmOxA6tGCyvgQQwjAWI1KU47i4IGG8Zm?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 965e1a1c-6808-40d2-9dc1-08ddbd96069f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 20:37:01.1764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXCIIVmKgbjsL6CiUPm01pOLuypcs1WU00FmxMTY4eKhrNh/iwXT3ekSIUr9+FAZ3RCUw47SBjGa5g/jrgoYSdT+WTmKd5zV+cmerC3De+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8860
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

v2: Fix typo in 1/3 caught by CI.
CI is now happy: https://github.com/u-boot/u-boot/pull/796

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

