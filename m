Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30AEC282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 09:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C28FA81253;
	Tue,  4 Mar 2025 10:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="EToBb5xa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9431881249; Tue,  4 Mar 2025 10:24:16 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D758003E
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 10:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuDtY6yEV0gmUGMO9ek69WdKOqbDokmT0X1EdIkYjzr6vG2Nh0KzMCnZkxKM7wh4G+O9so1avU500vD/XHGUdY8Sa1GxPuRKBRrh2kN9+hgYVpfzqLaBIC+5ot2sgzj45A5fJB5FX3TIBymt/V+8nTDdtMrzjEUJ4pXo5QCeGxdxkAlNju2C634leEh7qXPlYLOhVT/iX/VB3Z36EHhm1NRQa8gU8P2oGfTsn0G9+CzE0c/ARpU6i5kmF2DtyEQ1oR4jx/LOrCtU4qhUtMmR2w7Lf+ZqwSpo2MAwhgecpzI2Hs/jmiBov2pKSq9eRN0UyPYMYVVJPhKl1c85Mh4wCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=No2db9QjUl5oGF77ccayF7yavlyphOr1o5Y0P295Dmk=;
 b=g9BpeEL46dwCJKAO+/SPh0dK/H70A9/tOwKv0kNQNnj5HhjokQ6Ebzn0+Zu/bBPx8Ox/jXQXFAYDOwNoY1tbMxCX8LzXLLxvyuut3WXanxEaJUclMYEuHF+sSSR1ESS4Dkjr0ZkwggII+M+mfsN+pfW00aLcLY7tM0EETOoWsVfjq+3vuaOQq9Ecmx+ruJvnCRB8h6F6m66eaRd1ZZ/m9xC+ajJSL6JUG6onHFTRdelJsR3IEOJv5g6Z8RxpYdi1VCZDH7vll7L3LmV2JiiXVw5rFhVMBkEABtGCQRhyHBCd6YFPm8k+YdXlwTHViDMhnSoNbupAzpyoBQxv7rGLSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=No2db9QjUl5oGF77ccayF7yavlyphOr1o5Y0P295Dmk=;
 b=EToBb5xaqhD0GEEZFCNAPoZz+x7iyTdSP8Y9tCwjJb/M7+VtLmeyXnRl/gO+1VsGJyjdcf7HpR7vGCyJHkZlf7vWz980s1FwkejQbqsompCJK7H+isPKMBueOSzkH86gD+8z23RUc0TaEe3ODn1bqx7ct76b7o5T0wI1KPgwws0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DUZPR10MB8233.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 09:24:08 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8466.028; Tue, 4 Mar 2025
 09:24:08 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] scripts/setlocalversion: Reinstate .scmversion support
In-Reply-To: <20250302183128.326418-1-marex@denx.de> (Marek Vasut's message of
 "Sun, 2 Mar 2025 19:30:28 +0100")
References: <20250302183128.326418-1-marex@denx.de>
Date: Tue, 04 Mar 2025 10:24:06 +0100
Message-ID: <87tt895etl.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::33) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DUZPR10MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 240919d7-dbce-4b4d-4f31-08dd5afe50cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/4IjF5y8XNM528ovQPLPsDJZPA3HWwPP6smJBqq4RSzoJPEMqWV9bIifz0Xf?=
 =?us-ascii?Q?vqP2VR8nPCwNCoEe4eFvDF97k5YntauxHo9cDs1eQ44DS5SFs8GCsxHpxu8/?=
 =?us-ascii?Q?fxP8LXkhvPVVJiju08Q62HzYUw1uTgPDRykXWP4fL5iRfVr18b2a9IQSan1l?=
 =?us-ascii?Q?iEk3dGU7ctWIRBXgYnUrU0hSyogmE6pwAOJe+1uVrQIKtjAngaOdZG65B5Wf?=
 =?us-ascii?Q?1fVOS8y1+uA9dRyBh24YsjSjBakeN+wnHWcAWfwEtDdQZkcksL2KrFhaMHzC?=
 =?us-ascii?Q?lz90xzCGZ7x7EYc6y8Q2pQYSwpR+QGuUMbIxTXVImRoQFZ2YYyw7sKKvOrYa?=
 =?us-ascii?Q?MsnqBQay35U3PH7aBnVmDa3xF9tO4Y/EzzzpMI8K1F5I5I7RZI5kdVGYdr/I?=
 =?us-ascii?Q?LkvpagxPqubdYOAev7+DOIOcQDM7E2YA+6g87URHu1KAyDnqBL+uH48Zeo69?=
 =?us-ascii?Q?upei/jNpk3URYp4bT9aXKkiYdQxz9+9vkVSpxGRT5qUbQJq6K0o4VGannVHf?=
 =?us-ascii?Q?HHb0zZ5F0upyXrao5xuDbcgZYdDYRERk/diPGRoqNSv4+/visA1i+mv8FHHO?=
 =?us-ascii?Q?kxxj2E723SWBupPsjOLiKVAVj66HJIct5YOoxHo74dvS5aeSJBrQokZBp6gY?=
 =?us-ascii?Q?YggvGYntxtRpb0oq+joOx7d5UpUH+55IYgcLdgai6JWpzonDHrsiaQ4Qbpg1?=
 =?us-ascii?Q?M7UMUS3KtwCn1k6IKNZ6R4kxrhicGgD0HpNTdnJx87V+BfLhHeC1pTNHWgyx?=
 =?us-ascii?Q?MupsdtaAQZyuLQXkD4KxtVO2LJSXFfVUXqM6JMwMe76nSwGzmZI6Fcqtkv6h?=
 =?us-ascii?Q?mmf4BwvhdEEj24LMRPhbVD8XrxpYXbW3uOXtCz+hW25W0L+FGODLQ3vwPb4x?=
 =?us-ascii?Q?b+bFasqlcd7PyNykQgGlfhasgKwgvK2VW2taqO52luTqxEs84nI7XKlB5K74?=
 =?us-ascii?Q?cqoZOmGyYLAg3QgpLwzqk7oFAFzPkM521Gog9K+3uuMB+Q0KvRr6ThAxwVF0?=
 =?us-ascii?Q?qNts2qTiJJDTdl6UUYKjolzHOuZIP2HBXqujTAsSfTCE+vpw0YYBq6SOc6XY?=
 =?us-ascii?Q?Uer9v/JIZAp6dp/lG0Z056gcqiwsPn2CoW+nQR/LfsZddG1nyhPTXliEHicp?=
 =?us-ascii?Q?b+gWVRmA2je6uTm7MaSa5cfwE6Bh9oh24w3R6mXCnrTzgqDf23pH5DF6+9vx?=
 =?us-ascii?Q?Fqu490gFF4/7ohGetfR85clmZ+SsGp3Lecm2ImOlh6BPH/JVX/lhiiXLXz/4?=
 =?us-ascii?Q?IB9mfobkSmnPRdl+hVhNZceL92H0Vnqc7M9+KTjGnIT63x5AY5WIE9tHNSep?=
 =?us-ascii?Q?4HbbjGlhncuM08qeofxTCV1/8ZF2ltUDfadCvdQFcWAAKH7rLn+8WzPbumkp?=
 =?us-ascii?Q?unDjV3FHbU1KKhLEf97dUM9elTS3n6TgE+HA2KPbySLPiShss1rJb1XR9uOw?=
 =?us-ascii?Q?H0dTOcLXOqJMsDfxFABhBLitijsflFvd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kXJdbLijFhJD0R28Wc+GNaic6wnR1mjdJQRaUlnfHjSUUX/V7qtN5fMSAehK?=
 =?us-ascii?Q?N8Ec4ayr8x9sNIEgNu/yUrpkKaDAYb75zCW8kh3vKiic07qJp86Ulwwfpu3H?=
 =?us-ascii?Q?cdT5CwB1Df1o8M22jjum26RF8UNdJOzCZgXy2g7DmxDCLE7DZ9uGHbAd2dM9?=
 =?us-ascii?Q?j4w9MO3Csz+LCezHOyplvaj+VX322BrDWUIy2nAyMi5T+QVgVDFqNceBB4fM?=
 =?us-ascii?Q?+W2+NZ8h6ytIUxuJXmDDzcCRGBGk3y8eCFSR+3Fyk2mHFL7aHknnxXTtcUu4?=
 =?us-ascii?Q?MvF/HvVc2ysYf7u2D1ZvdEBuV+YunX/UI2Axc2IiCRzSHxr29leybwUl6T2C?=
 =?us-ascii?Q?pqtQMq3CqgU7juE7OPvrF+mD7bx2VgpJ4pvf5mkJnNZEhzew7EtYMGibyn0e?=
 =?us-ascii?Q?tuzoXcNdSyau2RSNuL60sGTb8C2bAKmmbjsG6mvTn4RD877LEFuDpNl4OpsK?=
 =?us-ascii?Q?KfSAOn5NqApcxNidnkg18uzbf6IKeJE45F26s5yNckVAJAPjluoHXdKcdf6Y?=
 =?us-ascii?Q?hVjcm2uaw1iUfMZa+y1SfdCS2s3XpgUW5RS0ADzACw7zyRpepve8Qd68OopC?=
 =?us-ascii?Q?HtZoLBurVl4z4b9r9qbetLRRY5mYOZjwk1lZg5xsVeAUz4/dUdO2iry+7lx1?=
 =?us-ascii?Q?bO9+W7DT3C7KP7XVx5U14OZXevSBP/KuFrJs6xLw75ZhU0BoP5YhcryUmCN8?=
 =?us-ascii?Q?2wCe9wTj6GEIAO6l2nkwU3ADy5piunZzkXOID5beCRKXhYw138zoeAhtY/P8?=
 =?us-ascii?Q?y2IuRmmRHdrBDarwq5Gejs49BwTa3aFrs9uWSXqHFGtre+0naCD1Qp4kf4Ac?=
 =?us-ascii?Q?d1WYEmL6NQUyrOjxlnmbSw4ptADfMj1cNdDpckeMZ8sweQur7/f/l3rI7lmn?=
 =?us-ascii?Q?JkhPZJ9twNfh+MbRSXT0fzO5Jgqst61Ve5oJcz6Fl8Bmm8rDcyzpdoT/17v1?=
 =?us-ascii?Q?XCIe/+kZqgpwVfQfIirMi+MaMIqKfvGOW64fgbIav/zCjmV61J5u7/u9K/tz?=
 =?us-ascii?Q?gAsXSZBO/1r7hadbHsPeujKjZ0w8GMzTNVB0VTF1wVxCW2Mn+b6ZRdBAsmXb?=
 =?us-ascii?Q?jeLXfVLpbrSSnm/vtzHXWrP9vUTXq+45WGU2boWXfRo6ZyVcHp0X8+P9gWDn?=
 =?us-ascii?Q?iaPmrgcJ+qQwrI+pwSEq3MiWq7yDXLiEL3HUbuhbBD5en6bFrzX4fUxsI+r5?=
 =?us-ascii?Q?6BNR5KvtHYrT5uOvzrIlnCJNsdD2a5htzhDzsOlqX4lA/v7EJBPXrJLuLlop?=
 =?us-ascii?Q?orIYz/NarZuA53GdmxeyQM8xlNnU4dAMqCMROPGxPDFu1xF/NdMpmLJGqFy5?=
 =?us-ascii?Q?nZUN24TcK45ysnBJ1OLkVRljDS3au5cxO8uF8l9Xz0yPmLW44XcNs57MI/u8?=
 =?us-ascii?Q?8uuS6Jw2A9jt9Yyfrx8evdusDREUz/WqfIPdyDxYd7UueTgmGdPqkqt0n1+X?=
 =?us-ascii?Q?Os2nZ7hWICWaevhDyEdfM6efA1hfw/790o0asrXEWu+wj+0/Tv85db19FO8w?=
 =?us-ascii?Q?m1H/wO3DsTZdGUMXcHPKnGl9jpVzYO78eyCsiy3jcSGWr+qtDrcfcxJXKo/r?=
 =?us-ascii?Q?0cyxDIi7z8y5gszyEtPHwy20s58vOLLDpLWrFQEnz2xp19dX1e4uLPmE9pnH?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 240919d7-dbce-4b4d-4f31-08dd5afe50cf
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 09:24:08.2534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDd4t35b6mCBI7Dk8W6TfjhrZk/u7Zsh5aD88G/EQ5Dt4S0usUJJNzrqujMJiE2Wpi6uT6rCpiQmkYDW8z6PESjfeDqX67eMTj2y9B2KWWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8233
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

On Sun, Mar 02 2025, Marek Vasut <marex@denx.de> wrote:

> The .scmversion is used by oe-core to append U-Boot version string.
>
> LOCALVERSION is not fully compatible replacement as it adds trailing
> "-dirty" string at the end of version string in case the U-Boot git
> tree contains uncommitted changes. This behavior itself is correct.
> However, OE builds do clone U-Boot sources from git and may apply
> additional patches on top, which are not tracked in U-Boot git tree,
> but rather in the OE metalayer git tree, which leads to the addition
> of "-dirty" string as well.
>

... which is then _also_ correct, no? It means that U-Boot is built from
v2024.10-321-gabcd1234 plus some entirely unknown additional patches,
which can be anything from fixing a typo in a printf string to
completely overhauling everything.

> The .scmversion used by oe-core used to replace the version string
> suffix fully, including the "-dirty" string. Reinstate support for
> the .scmversion to let OE core do exactly that as it used to do it.

No, please don't. Let's not let this script deviate from upstream linux
again, and let's instead try to fix the bug in oe-core that (ab)uses
this legacy .scmversion file. The fundamental bug is that oe-core
creates these .scmversion files unconditionally, even if they end up
empty, making CONFIG_LOCALVERSION_AUTO completely useless. I have long
since worked around those bugs in my own u-boot and linux recipes, but
I'd much rather be able to eventually drop those workarounds.

Why doesn't doing what kernel.bbclass has done,

export LOCALVERSION = "${UBOOT_LOCALVERSION}"

work for you?

Rasmus
