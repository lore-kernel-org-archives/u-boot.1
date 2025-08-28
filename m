Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C48CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 14:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 424A883403;
	Thu, 28 Aug 2025 16:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ogzM3K7u";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ogzM3K7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7260083327; Thu, 28 Aug 2025 15:08:08 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662E08328F
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Said.Nasibov@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=nYQydN5WvnUmABhQeruYav6l7VJlv+Hwxl94PKvZc0OjGrlYK7+bssSzVJyNg32V26bPMxX2bwC+jaQ/WFKMyJvUXNZfgCUV5PRdjq+5WgmwHQALjRyAWylVRrl/kNrEsc7fzGLaSaPXUvsJaysjBVq43Ag+mUEiWf4ebcpIlNH6k543uVUJCc741vaBnjPDE8dwBFxJEOUzhXpelqtKLWJjFkQ5c93Jl0YZZpVCeYy61etCdrBGb/ZHlgModhpFKUi102KgOsjVkRpN7Me4Ld9bYQiQOTn7xjVPbnBNJ2ETYTR5y1I7Cqve2QDvUjEIpwqfttgZSCoyn/UZHHMr4w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plvc+PcfxbdWrXdrPsR6KI7duk7ELkVkqxbv+sC80Rg=;
 b=PUSWLawVHqehfrgBrAqznqwpoII34xd+QIh0kWmL+m0Ind2FJ6xPCBogw9De943ecpB4LZDHMS3WWS+QfsLgcHCA9Elx0gpOnf1dr5Pe7XfnrojLUbmc5Xiz06WxixO4uYvf/iRQQMwt4Vi1F6JFvUHPxsMfj4Ab4jlvkoJEfPPXTgDsN5xFo6rqdYJKxI+tzvk5Rzjg+AukLxFXIXY+ONGhYJT1LbA306go6uRZIN0KYnYhj9NaVwvxBpwlKxvCM2fqAKp3Af/EpoYb43FMN6PGyEhSDrMWcrNHDPysA3Y5Zz5S/r+cMMvzKOOVvFX/2W6RK6DGaUvTyeSggIE0DA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plvc+PcfxbdWrXdrPsR6KI7duk7ELkVkqxbv+sC80Rg=;
 b=ogzM3K7utTaHIKXZZej4fS17hl+lgG39FCOA2u/ZXurIqnRKg/dOB4Qp74WpxTT734HWd32tPHoFEs3Pz4X0a2mpJTCDX0+FO29UiKX27o23CodBmE3HYIRyRa7TLx2a3PDprDwAbW6M+nnoMJDelCDk4WffSlH1uKwe+MXsgXI=
Received: from AS4P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::11)
 by AS8PR08MB6101.eurprd08.prod.outlook.com (2603:10a6:20b:29a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 13:08:04 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::b) by AS4P190CA0018.outlook.office365.com
 (2603:10a6:20b:5d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 13:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Thu, 28 Aug 2025 13:08:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6WyiCDFpzSNZsjKyhyafIZ5GcT7R5ivGI+v3yElg6TRVck+OKPLfwPMezeDIbmlaWyWuLPIlR75G2LynhnaomKkv5AMP8f8zaByOmtV6aLpbUs55AcQ1+rPOWVhHbYbtpQo2RXbPB1gUXGqeN2Ehkd/Ur7PHSsYXby/MtpR7xyJN/XPkDQ4QKi8Xqb63AzadiDi/4gSwE/vnoDS+8cBqgDLRZ2f1AmgM3Ih9nAv9UvOqYFBKTNzWI2Z0qGCXrnKZS+dpS2PrmrBsMP0hrqS9NjCnX9cGs1R3cXtRJJrFe/PGt7yWqyxEBGRgrTQwsnR3AfNdztYIT8vwPqWLel8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plvc+PcfxbdWrXdrPsR6KI7duk7ELkVkqxbv+sC80Rg=;
 b=bJPyHwHEBVzTe8XsR5xwr5fFzPNzGC/ysqZQ/CR+lG4xej9KRmtU387rrO5eJ9cbKq7ubAvPxaD7Sa3lD/+hHuB5ztBGDkVvu7ydwhPL/ZHRYmmQt7+d8Fay9Hrb6c4miEzOlaclkMARAeyD5jrgeqBTRvSENI2p+/w9WMtVikciEjJO9Ti10RFMf5iTZNSrLuUwzMcc6ndgw18zEuh8NQI1YTPXVTIDt1Oh1baBaODOxg8Wp+TtTko3/6a4FqvCssuBcbycAvVkpSdk/xD/jblGFs0EdHCpKL+s6MfK1ksbyJSq4f7IxnWYpO3aJBWKhQQ4bS9wslEPupn3dwc0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 172.205.89.229) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plvc+PcfxbdWrXdrPsR6KI7duk7ELkVkqxbv+sC80Rg=;
 b=ogzM3K7utTaHIKXZZej4fS17hl+lgG39FCOA2u/ZXurIqnRKg/dOB4Qp74WpxTT734HWd32tPHoFEs3Pz4X0a2mpJTCDX0+FO29UiKX27o23CodBmE3HYIRyRa7TLx2a3PDprDwAbW6M+nnoMJDelCDk4WffSlH1uKwe+MXsgXI=
Received: from DB8PR06CA0056.eurprd06.prod.outlook.com (2603:10a6:10:120::30)
 by AS8PR08MB9041.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 28 Aug
 2025 13:07:28 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::52) by DB8PR06CA0056.outlook.office365.com
 (2603:10a6:10:120::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 13:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 172.205.89.229 as permitted sender) receiver=protection.outlook.com;
 client-ip=172.205.89.229; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (172.205.89.229) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 13:07:28 +0000
Received: from AZ-NEU-EXJ01.Arm.com (10.240.25.132) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 13:07:27 +0000
Received: from e121818.cambridge.arm.com (10.1.199.38) by AZ-NEU-EXJ01.Arm.com
 (10.240.25.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 13:07:26 +0000
From: Said Nasibov <said.nasibov@arm.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <andre.przywara@arm.com>,
 <peter.hoyes@arm.com>, <david.hu2@arm.com>, <michael.zhao2@arm.com>,
 <marek.vasut+renesas@mailbox.org>, <mkorpershoek@kernel.org>,
 <pbrobinson@gmail.com>, <ilias.apalodimas@linaro.org>, <m.schwan@phytec.de>,
 <quentin.schulz@cherry.de>, <rayagonda.kokatanur@broadcom.com>,
 <tien.fong.chee@altera.com>, <casey.connolly@linaro.org>,
 <patrick.rudolph@9elements.com>, <alif.zakuan.yuslaimi@intel.com>,
 <boyan.karatotev@arm.com>, <Oliver.Gaskell@analog.com>,
 <duje@dujemihanovic.xyz>, <1425075683@qq.com>, Said Nasibov
 <said.nasibov@arm.com>
Subject: [RFC PATCH 2/2] vexpress64: replace distro boot with standard boot
Date: Thu, 28 Aug 2025 14:06:57 +0100
Message-ID: <20250828130657.249153-3-said.nasibov@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828130657.249153-1-said.nasibov@arm.com>
References: <20250828130657.249153-1-said.nasibov@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.1.199.38]
X-ClientProxiedBy: AZ-NEU-EX05.Arm.com (10.240.25.133) To AZ-NEU-EXJ01.Arm.com
 (10.240.25.132)
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|AS8PR08MB9041:EE_|AM3PEPF0000A795:EE_|AS8PR08MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: d873fcf4-d098-41ff-b4a8-08dde633ec15
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?gZcmcmlaivH9wJtwOZN3ziP7RDk/HbXKY/LW3iRl2KMoJ/DK6XKWw9lgOl/q?=
 =?us-ascii?Q?ltQvzd5m684H3vKqsINpIqegDlLeC6Jh7D0x6/by8SEMHqhYgurYQbad429r?=
 =?us-ascii?Q?9jVqQfsqXz3JwKC/N9QFN39JSR/ZuQgBS78LhaYclU9PiI2DaDffV0A0zcPA?=
 =?us-ascii?Q?mFZkt9Z4al7++Y6VxffUXotUuLo8rORyT/kEF6EhsvlzdXshWGlnc+1S0wn2?=
 =?us-ascii?Q?tUpUcEVJokdPWlXgsC3iER7lGTpN/pfnEPAG/99RgIVjjEiKlyFoKSuGtjiK?=
 =?us-ascii?Q?4219WKIkN6ewNFw3BKhU0B9GdzFIVzsAPDlhWnTl88J7IRnFVSYzT+fZosic?=
 =?us-ascii?Q?Tbgu4xGzvNpKQe4/p8pGpwvfmX2NA1mAj618Cq/JYJeJB2HtOYAP10Irkq87?=
 =?us-ascii?Q?mZmKgDVz0sNqVbip2XkIxCG0ZBR081BqhaI/UAwF08A1c7VMbU1+cHqXy6yw?=
 =?us-ascii?Q?6svmrAcxhdBss5+6XS/VhQdlTgdrO032BqUhWbC09FjTH0CwSaQvs3HMMlrj?=
 =?us-ascii?Q?g81HY3JYTTJV+kUnB3CmvZ6ff71aAgpw1GMFdYTpAECXgfi7HRfujZ+ZQU4k?=
 =?us-ascii?Q?9pXcnLpC0DUfIYT9Cp708VpAJkIZ0hDV3cxWrybuYYjmOuOeti8bIOdyGcoU?=
 =?us-ascii?Q?9zSXjhbCOIifa4wjd8V7GuIJF2+HTSQw3UoaCMylXYA7CkDfsMfNoZbkGrAv?=
 =?us-ascii?Q?IOiPWhFadPuFk8OsXzZ3k3C9eelebvOV4hIzF7BAtY2HIdctx5uK1VuW3Ady?=
 =?us-ascii?Q?Iyh9GFnMCyzvqLJg/VP9qreJKotVC2wWSjXQf/OhB+hqpkwMDT8w/bsWRnbz?=
 =?us-ascii?Q?v5Q8nJbDSaweWPcqgblyxXLI4LL7JUqGCi56qdlQXCEiUDpj6yjX60Fzy+J2?=
 =?us-ascii?Q?zd5t/Jc1J/x59ry1V9Unj/cs/NvRM6nGu8iFX8Rs81WE9D1cZ1PH3bFIjkqp?=
 =?us-ascii?Q?I0W/0RwSgZTpo5BMeac9ubU/7GlNqY2zXid8KnpID1PtBjHye3GJZSca9gf6?=
 =?us-ascii?Q?vI7QaAz/bkQ1PVMvV2uQwBDEV7u1wEXdgmHkIZZQeenOr74v/04GfXQa0Eut?=
 =?us-ascii?Q?Pw0lKMdKBq9p8Dn60Zzv0iZLICVrP8WNn8dSECS5AxjdfffVx4er8qw3tftv?=
 =?us-ascii?Q?Di8k1UQ50XrXJy9u222qn4UTycZOziYXonukAC3QRYxegDGP2AhzCtA1swW0?=
 =?us-ascii?Q?yE0NpxF+ER12QLAaT/nkDWyPyWmm5XOkhR8Ih5y8KWZqwJq3ajfl+ubEc8Qb?=
 =?us-ascii?Q?T5ks98FBLIul0+M17M00b82ooE4tqjBVjSkClxg5wwyd/qqyWMVzclwyJCqZ?=
 =?us-ascii?Q?XmhDqnmcoxoJrs9nzJUzDJRsWAMPcBCogzlOZfdeLj2CEiZfi3+jEBTeE9Hd?=
 =?us-ascii?Q?RyjsChFsuKuxgHm18WL9z2aiKZv5YW4/uvDY4LnN19csXAziOkqdSe8zJ8Km?=
 =?us-ascii?Q?xkaaF8fyDy/Ux4R3tl8Ip2M7ultObWDD6fx/o/8795ivGLCnnrYPPyVE+d0d?=
 =?us-ascii?Q?rKed5h6yZmEJG+s/yPWhFyqqooN7Lv+qCaPg?=
X-Forefront-Antispam-Report-Untrusted: CIP:172.205.89.229; CTRY:IE; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:nebula.arm.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9041
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 23dc0aa8-95cc-45b3-de12-08dde633d6fb
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/XFnioMyooUSIi6wN1Tt10rq8eovCE3R95JcT+ALthqKIuGWO715u8J5aCdu?=
 =?us-ascii?Q?gh41zjE8ThK0PJ6Q1tQrCXW8PXfzMBb45mx05Hn2M/djhHZ5n5ADes//JjqE?=
 =?us-ascii?Q?1LWgBMCc0yqDxvCWzRac/jUtkavuFHj8yl2f47H9xjqT5vJLpxgK59PG3fGt?=
 =?us-ascii?Q?/MnS4fbwStxrBPb4aB71PJbOwy3Vg450N9AyAp3CHPrZFUAMjk2BCQikqCSl?=
 =?us-ascii?Q?wor3by0iB0W6BVOZNt00iv0tb9Q+W063EUTcaxTF0YNmUu8WQIqCy06jsnIE?=
 =?us-ascii?Q?w/DqX9iEeMEzJ+EZLJjyv0ur4WCxwz9dBe5rbqfuey0ChkJMhx20cwluVaRz?=
 =?us-ascii?Q?y2fsceQATPl2+Qo3il5Q2M/IUv9deo4wTzcPvFCrRh8ep+Opp54TAeRbiVms?=
 =?us-ascii?Q?GhtmUZKNdlRuR8OZ2Qms1DXhYmOP/4x00eu7Oh7Gu31aZNGhlAKKoWoi2gQu?=
 =?us-ascii?Q?PoAZota62CS80s0FNyGEnr1zMuhKO9ByVozaltKEB0eb9Vfoq6dQ2AauOaG1?=
 =?us-ascii?Q?eceYCpUnHYGgjzAs9u2pnAxKDUE6qw+OszNFRyN37MxdRjxqRaJvakYRUpuJ?=
 =?us-ascii?Q?I3tJUyQFasjOBzAlF/TVDkL/JWOFiSjLYoBK6npAVoCFXun3fPPHQULfna4x?=
 =?us-ascii?Q?o14BvGFO9Of6DdtgLqFjb6dTnWzTpcpeljGa1ehRnUN+la5YJU5qDZQiRSEB?=
 =?us-ascii?Q?l0m+sCNqoSEqtHpNzYlOOkHvDVjloo1AjyKQ8RX5rZk9j1caE1vMi/dCseMO?=
 =?us-ascii?Q?MfSudrdf8YabFA1wzRmfushyutZbPUXT26WRdqcUbd71awRjJJOnX/a9Pz8/?=
 =?us-ascii?Q?LgWaGyflu1NbOv/rFN2048Py6RA6d6fA2QT0XQskobqA0pA65e8s2SOwERjP?=
 =?us-ascii?Q?y1g2IRQLtMgoEiG50tieTYZZ1mOk3y7DqJHJIuGva4O+jXEekbIXe9OV7E4O?=
 =?us-ascii?Q?GqEX8aGVidDyM1oB123I7SkABUR+uhpOpDaBnJxdFkXd8qoHVgYnkwG9hZ77?=
 =?us-ascii?Q?CMsjvWHPqe/gjAO4WAV+AvhDdBtzB/f5MRCc9rgz2FoUL6E2CYYkJKaoydnV?=
 =?us-ascii?Q?HG8vP6sIljvL7zGeBs8tXOTttEFIVw0Aiw3FY80KD8cSb22rxsTbDm9akHqe?=
 =?us-ascii?Q?YBfUHbZpGcWfN5lgQySuhm2TBIeUwoPyfIViqRnT8PQRRUfFLv/um5GmKjlU?=
 =?us-ascii?Q?Qmjva4lX/HDSF/XHcNtsezF819C1ubNgTqwVFAj0WfoEMDOBavWD3h4j6Fk1?=
 =?us-ascii?Q?Yj16kKGBSE5WJsbLz1VfPqgxmSxZ2zPUZXLrORycR6Whbi/16zhQw5g5FwZr?=
 =?us-ascii?Q?qIZJfKUOe4ub2d+b8xVI7SJL9ZWasazxrvri5mn5QjZLuAtd42G8af3Sak10?=
 =?us-ascii?Q?LiCKwQhDq33iipUy1peHIlC7vV5lCUzj0VWqa+I9Yo86UK7PKB8h/NLP20MH?=
 =?us-ascii?Q?QrwKdC6XnMqU5ztEFV/C1konkTFwIrdjBMIt40hjonO3lSquBQTqrnfqrFSE?=
 =?us-ascii?Q?hW1X/xv/R1DPKV67RMHSwrS6j1v7+pcSejEy?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(14060799003)(35042699022);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:08:03.4083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d873fcf4-d098-41ff-b4a8-08dde633ec15
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6101
X-Mailman-Approved-At: Thu, 28 Aug 2025 16:03:14 +0200
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

This commit updates vexpress64 configs to default to standard boot, and
explicitly select bootmeth_smh when standard boot is enabled.

The distro boot related variables are deliberately not removed to preserve
compatibility with existing distro boot flows.

Signed-off-by: Said Nasibov <said.nasibov@arm.com>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5872455a0fe..527a865e4dc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1413,7 +1413,8 @@ config ARCH_VEXPRESS64
        select MTD_NOR_FLASH if MTD
        select FLASH_CFI_DRIVER if MTD
        select ENV_IS_IN_FLASH if MTD
-       imply DISTRO_DEFAULTS
+       imply BOOTSTD_DEFAULTS
+       select BOOTMETH_SMH if BOOTSTD

 config TARGET_CORSTONE1000
        bool "Support Corstone1000 Platform"
--
2.34.1

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
