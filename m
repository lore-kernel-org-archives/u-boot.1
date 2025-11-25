Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E934CFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 08:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B319783FAA;
	Tue, 25 Nov 2025 09:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gfqXATiD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA52C83EAE; Tue, 25 Nov 2025 09:13:38 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9357683F6E
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 09:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o37ysjvNETQNwfA3HYNIf/Ad8t13JD0wPMqfdXbJneX5J4Se3wr/9wyuPeW2BihtJz695/OD6y7IvJHKPLQybZrASukKlgBPMPHL5GJW5nk741yAgzGzxTlN9rVkFyfH5IjD4wTz8NUwcuB0ifrsSqFLkuo567WowExkLvPlRQChsidcGFW/Z7ozKq4uRQKy2T5DbkXwqpO2sjfE4WabkaPe4Q/Z73VWbxjUoaVj1mTdE9Cf4kr732DeSAbyF68JjdsbkSavzXuBLExBOOx6e8eAuHmaBpW2yvNl0js3DP8xCbi8FdV4zCg9gpvMlVDNrTbOzOXD3MOIpyNumLAd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqbzQS+GYVeIWC3EABkYHmnESKj2+lnAr/wAI/RL/5c=;
 b=VQC3fF9wj/aT7J0ly2K2FYsRrT9GxcxNVg2BcCogtcDEBKxuYo2NzMPLJt1wBBOnv+ZQlJQ/ESNkU3J3XjckukJC0D2yZkSqjKp1wJh9mEF5NZXQFBDk+J2f07NIB55QhZ6Cl2sdk8ZTznSxzyYimcWxdlZoYnXnHvfnSLdCUpIWP55mLDDf5KED8B6CVAO7Vqa2uh1Q0wQ7RXiVDzn/idsoOBVSeOsaqzLPFa57VA+f2UY5c8TJnqHR9fY+5jjslTmynrP6HROQfmtYXiBV7MkG3vfqrMahoT4Am4bVW2NwnumfBW7JACpZyTuRRIf8wtHYAtgfukHCvE0EHYp+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqbzQS+GYVeIWC3EABkYHmnESKj2+lnAr/wAI/RL/5c=;
 b=gfqXATiDIGIm1nzlj8Bk1sZPf6QFG/uNYMi7h3njzdqSP2ESXA4JP1ovirF0cZXIPnQ4IB0QKk0Vtj4DMFRlpxffh9qIBIlSukr3sUCovyrgfZy9V0QwXnXV/+xOgXCqA/MgUCIi03cXnA/9zxf2c7Ver5KeckXBPopgzfTEwXljRK0P0IjxCc5xlxZO5ZsA5S9tF1YKLyPR2sgfdP+ilSBr/KMRC5UvUfmTZ82Jwxgw+MAG9WJiVUNmvMyeKzGbWgxUuQpBsSiaTVpJieGFYaK9GNVXNGrjkw2qoSUgRAwSGL3SgRXeb9EG4DNs8vx4AaMgK2p7L/Fm+ROfL2CArw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by DS7PR03MB5447.namprd03.prod.outlook.com (2603:10b6:5:2c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 08:13:31 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::194c:fdcc:dc20:149c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:13:31 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Brian Sune <briansune@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 8/8] configs: cyclone5: Disable SPI in SPL
Date: Tue, 25 Nov 2025 00:13:16 -0800
Message-ID: <20251125081316.17329-9-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0044.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::21) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|DS7PR03MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: 69059561-babf-46aa-a978-08de2bfa8529
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ui453Yf69tcGc8gasbiwRRKK5Uqq0Pkq8HYyMZ5xDfWE9xBlb2NfZoq7Rls?=
 =?us-ascii?Q?oe7Y0nK94I67+gMuOBtR3+5TOBIFAzHg3YIElzL64uR5M4djIRic9DtkBqY5?=
 =?us-ascii?Q?4RLU6d2PsxZPyGuN9h7Xq3C0Xp1BggalM2qpNYsNKC7oOpEI+9EvMjNiqN0Q?=
 =?us-ascii?Q?lVyljGnhpql5sKDU66PgC7DQfinYutKHV7tFLvnujzGV9wTrQ2GZLgIeIjQX?=
 =?us-ascii?Q?NNIB0ou6Aq1TR9O7gASD9PqjG1Xd63C59izcz+LcQzmmre9I1QbnjvW5Pa8L?=
 =?us-ascii?Q?qzioJursG8ovyOVPQoQ+qWHYbCDk1j2tbg0zxlK9n+o7JJbQeKgzD5Iosypc?=
 =?us-ascii?Q?PuGK7Ycw9/u+wawxfZtil6IuCWA/HdpBpv3JrEWgwViGmrWf+36vDW7j7/Kk?=
 =?us-ascii?Q?nZdKzt3VPnElk8CScbMs+RvkiZ3C7ihCdGmznJyJEBhyJ6B1JGBiwwBZTAVK?=
 =?us-ascii?Q?k2gu2Ld0+Akn3GxMnsEzHTmJMf/cQFhAO601ck+RgApX3ju08CaP4IgP1rs/?=
 =?us-ascii?Q?WyKj7fYa9HBbhxb0EJDxRjF4lpfg1iUtTXYfwq9RTfPJ8wlqxAATnV7JxT1A?=
 =?us-ascii?Q?MKfyipltsTcrwjPOeNT5ibMORp0tIWL/mC4dGypZX+InBUK9k/muroZ7K4JD?=
 =?us-ascii?Q?Wq2IyVOk6oPWX3ydnPpgI5tazl4oXKAozZQ+8jFt13xu1nxULUdxvErfHnCS?=
 =?us-ascii?Q?rdzDCm66XPoUhMKTHD4JmjFIezemqejqAfMriU4EpOZii8vnClhWUg7DpkCq?=
 =?us-ascii?Q?YLu3kWLzHLHfj6anFv3dD/G7QNeIRA309BTct7+/gBqz6O/UItV9QApVr29A?=
 =?us-ascii?Q?5m/Zu/EjrtF/zCDtlip1mKQBH9WpdYQwRAnihjbj0RVfYeuvEz0QAutRnMCw?=
 =?us-ascii?Q?GbOdonirYtU19nDVfOLhokAhSeHZeEvppgN4xBIDEPmfE3GLTFarmOmVKXq1?=
 =?us-ascii?Q?QUOYUbAL7jlkjmTUwMGnv2cYG1PVVfkbO4a4bFwUyMVjkRzy/Xz+x/Ul3im1?=
 =?us-ascii?Q?8d69ajDBKQJjcnqxvWIEmJ3gFC/Z5CqKGjL/Q+jtb3D7oMxmkeBVm0TyakD1?=
 =?us-ascii?Q?B5SQ+8OKq2Ynohcr3XrGoYUvj/KzE29d+N6ZGTePJupTDA0aUsdFNoYzgcPs?=
 =?us-ascii?Q?qFYKEYMZzYR4YFKRv6gNhqRZLnKAX5LtdmZOYRem7+gGPL8Uru6avSjh6GSW?=
 =?us-ascii?Q?IRGXHgNT9Az5xeyVi5suRgHIXHIFpA4hHRo2HsOde50j63YWhzQKdFeuTUyZ?=
 =?us-ascii?Q?IMtGC1P39A7/DBkU4bwZdLVvTnexBg5YEVfNsuud4PZ72vD1qESKgJ22PgXe?=
 =?us-ascii?Q?/r0cVc25OWBTqTz3pEuw4YeDU5eRibobbJ43HL4TYydMJYnMtFU6/fwpJSgh?=
 =?us-ascii?Q?zrf3c4MJC9GH5qsYpcPkYSrGX6RJb6PKUZjmpyk05cGEDN1jWuTi5cgtT88I?=
 =?us-ascii?Q?mg9N9G5zwvTqdfGaDyCbDOTcvTJBj0lp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qsxh0U+/SXrqNIsji1CkbT+x6UfZqxSJwtGU9+xBe/l+TnSwlUOlcTj3TFt3?=
 =?us-ascii?Q?Og8IPVQbiP37T8ZDuYOzkBvuT0ZljdozvJ1Mju2AC21pRvxTCWUaH0qvUn5O?=
 =?us-ascii?Q?vBA/cwpwsZGwGVg2JuSmEmwAbJYLM6ALgd8BSnWIFQcPlRJAJH8X6bIxQ+KY?=
 =?us-ascii?Q?+8LIlfzvAzyBxvG2fjpox7bWVqbiAM+lmDye/hI/CySgk3w3lkvL9l1sT01Z?=
 =?us-ascii?Q?XRZA+SsoJVD4uraad7PL+I6tofq3kJpIu/ogoCmq+G0BeMkgcO0IoVuIuEt/?=
 =?us-ascii?Q?s+EPe3SwQPdsM/MnmrzD2T0OHnnCS1lgtg622OKKHPy5pq1aW8n0h0x5UAoX?=
 =?us-ascii?Q?+zqT6lt8swH+BRD5JhxPTGFaFiIB94gfZjVFQfk6HPLVIPWdsbWmVD13OZ0o?=
 =?us-ascii?Q?56pQ6ocIogk8FIpow/qmO/I4vhDixaKFlHx+FEWRjmKoxBbj58d3OuRa/Qh7?=
 =?us-ascii?Q?YrEygkZK7oBC+Am9kJvzHd3RXiLUgMPWjLTLZcoEwrgyQlAhreiirhFWRDeR?=
 =?us-ascii?Q?JZZTTjgVCGKUFj/0/MMIUld5HlCtyFfrP0XiYezUUe+TRSAvqfoNwLj93Sc6?=
 =?us-ascii?Q?TSbdaWTvAgPMhVvYZ3si//IAAyoiR7kAEujapszyOiGv/sIkNqLY/7kIsnug?=
 =?us-ascii?Q?iHAHZzmQF1F2kSt/IbMEysh3O88oueOUGYdRgV3OBwO5g3joXTNttQMo4dDy?=
 =?us-ascii?Q?bGDDSF0MD5sPJGrXM/SuqMYXoZOfENEhE3I60UHCf7j4LHqiGuYvtqV1Cw6D?=
 =?us-ascii?Q?2GRJwBDqgAEMEx1QNgRy9gsc1efTZG2ny4i6ydx8e8n+Q6/6uHwbwfKUF0x4?=
 =?us-ascii?Q?pEYr1J1b+wLPYk9Kgewmd/XRe35eo493Zuvc/dYsxb1SgmpD5DizFNzjbcnf?=
 =?us-ascii?Q?XT++yjtVBd47WTyrJ+woiZDJdxWMhJ5GWIDSNL8tq4V8PszGA18a+Jkb2GWT?=
 =?us-ascii?Q?2OoC/1NPlOiEc+gQIaSsdpH3w/OcBgQXAIyxES4azNQ8wQSrB15B28AHBxqh?=
 =?us-ascii?Q?ixi/pvzx0SVrEzv+JAkI1s1+tlOLlzjGwiqHl2gWXyWfvdsABOIk+qz2AAJF?=
 =?us-ascii?Q?4VbhKtI1prhXgyho1tfji2lajlGIKKVOOZrH+4ckQyBfELGhSG4IEIJLdKYD?=
 =?us-ascii?Q?NykUYCeNV/ceHBCKoEfFj//TUJtr0cW9zBG1C4J00fN3QP9qrsSXt9DqvHsY?=
 =?us-ascii?Q?TNJbD9QVvm1rnhabChpKe7JICqnZXXNJ+vNFL7icSC0cSFvUZcJ21qqqrls6?=
 =?us-ascii?Q?Hv2sN+OJJyP6nkAVVi8ApuRihV+/GJdMeBTMGEJt4RAmudPQbt3zjB46VBQg?=
 =?us-ascii?Q?8yAt5SgAfV4XXCVPeRhlzZEDfAiUd9ezm32FlTBvorI4JFxFIcwF7KFrBtzY?=
 =?us-ascii?Q?49ayGKlSxeWMJs03cwHAj8J4NluqYV4F5pBcaiq+K2J5bVV7n1dSs9WIc9uM?=
 =?us-ascii?Q?pXISfpntiyEOXlmyFREx/8nA9ulewPqzcktCyBlmYKu+lq65ERPImeiEbqFn?=
 =?us-ascii?Q?SH9YfOSxYl1mZ4DMgMwKMjdM7Lq3waIO68lQy2KUaU9PZMtGWkqULwkKji4P?=
 =?us-ascii?Q?xpHwHBV8R1J7it51KReDWG3AQ9MO0mK7w0R74WB7Dtik+fzXRLJA9XbuBMPZ?=
 =?us-ascii?Q?BcFBuhSc16dx3hGdoG+D/Fs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69059561-babf-46aa-a978-08de2bfa8529
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:13:31.0760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaQ/418/SCpOSps6Z5qcQeXiW7ZodRiwZydq8UPGOsX3SotE/fJq3si71KppKdvmXUA7y+KM/TWp0SpCFRrXYl3bWwrQGb59JC4Gvo7gieI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5447
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Disable support for using SPI in SPL to solve Cyclone V storage issue as
the OCRAM is only 64kb. The SPI configurations are only
required during uboot proper only.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_cyclone5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index 94bb05d20ff..6d9acf6c231 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -12,6 +12,7 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_STACK=0x0
 CONFIG_SPL_TEXT_BASE=0xFFFF0000
 CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
+# CONFIG_SPL_SPI is not set
 CONFIG_SPL_FS_FAT=y
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
-- 
2.43.7

