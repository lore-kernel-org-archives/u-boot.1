Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AE1E87827
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E886840B1;
	Tue,  3 Feb 2026 14:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="l+pXt9R2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D044C83FF8; Tue,  3 Feb 2026 08:48:42 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6392F83FC8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfBW4V5jsMCkxGAMsY4o57kqJJb3oDcrH5puXw20A40k7RUlcziUQfxkjSVnvG7mWBSJBoTtoZ079YxtdIU1GF7K60xd/jBvZ3d9YFcN2Ufyznq3amSmIGVKTD3RhLAGlF3rcDERFgkDQiDpDmAX0rsAXP9+aBmZEsKdYQVxKYwICREZRQh/YS3K+fzXc5/B4FmZ1zddR4ljr0D7/rmEjOqExumEhHQplsfc0pclSL7NRl7ArA2oQe7Jo4hLxkGVjJQvNDnG3jtlbTjRZUevieU/kmIbul/d7VXgFiQ5oJLx3FZA9oWtp5lNkNW2BU2yfD+25ThgbQcaNFb0qUH8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJVF72QN87BXTfJ9UDZCt3XktbBMgnbbhpVg1jxUEWA=;
 b=AM8KXSxFuaM6QOo2s4ge9qN6jevo2Tl3Kg26vgoVQmNFme1QvTyiTHXbYRY8DpuHgWGd1tzI6gJz4N8T+4n3X1nD9fT2C9x0oRE4RQ4UL9B8fpa9NxrURBfsGqqZshPfXtLeedXSXB8BAmODVTGrlWdv7o2pdbmKcxg1jpLLjoAHorAd/iXWVnH3Jyd3B39xMNMthkfnAkzrTTTO1tlYmYUvDa3bDjxO5HqZ3Vl7LoRpACLUSPn6PNkpGLHAcYvdZ0wli2JWWLJDiRlQrkn/i7tt+mnomXmMeJbC5JztP1DoUJFhAgfrdkL9+VHXJDWycFVyKLZjVlGGaP/l1tOKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJVF72QN87BXTfJ9UDZCt3XktbBMgnbbhpVg1jxUEWA=;
 b=l+pXt9R2mH72H3/crxj9uaXNd5nbDK0GwBh4+HqaQvdvNLf9Nec6H2NvoI9jlnIuC6B9UOoPVGPKcY8mlI+mq0B7AxQz7flQ3VLBLrTKZsEb8TXM1O/qTco2En1anQTHCN7PKbrgi7aU/811LEsyTODqSmBuFPnsb/V3YZPT0T3k5nKmeMvlhwFNmCxNEyy7YXqo0llhuoGY8aLKjyJRP7CmnlorulOmiPw5gVHlEdQ1Dzk8Z/CtjC9y+KAmX1+Bd6PyACVWgiW6+VxOELdqLhiYDyYveE6EzBBt64GarD0JVb5MAuAGMR/bJRVg7JxvGEqu4Qzchl1Cvvvu+IRHHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DSWPR03MB989105.namprd03.prod.outlook.com (2603:10b6:8:35e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:48:37 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:48:37 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2 0/5] arm: socfpga: enable NAND boot support on Agilex
 platforms
Date: Tue,  3 Feb 2026 15:47:16 +0800
Message-ID: <20260203074721.25520-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To MW5PR03MB6929.namprd03.prod.outlook.com
 (2603:10b6:303:1c6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DSWPR03MB989105:EE_
X-MS-Office365-Filtering-Correlation-Id: 446f26c7-fd66-459d-1011-08de62f8a2be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U3V8IcLyQF/ZDSoHJwjntijf9+gSnRN2STCeymFW8A2oORo4XgPK2/OK8w7q?=
 =?us-ascii?Q?KD+9CfPczykrh5V4tuWFLGoXBcN9YHqJL80i5R/UcEE9g60yCzVMsK/qhURu?=
 =?us-ascii?Q?VJSjx0WKluH563smlKNRkHWRaOaw70v0UUz7UkJihhJOj59DF0VpzWfCqqwt?=
 =?us-ascii?Q?AiGDwKbotCIbFrLLS4HDVTBpXGRq2MNmEqFvfHoQJzUSZK9idfUjeyys3W8M?=
 =?us-ascii?Q?o1oWczfOkuU08WJS4yTuPDkhk7QyBXKhnnFS2GNCjBKNVHaak0h6UZq1rYZT?=
 =?us-ascii?Q?dwt22mA5LRK2bcTMUanA+yFT4qTYjNOEzPWcBXV6pLhXU8L4GaJxx38Wo/L9?=
 =?us-ascii?Q?OiJM8S+Pu/F7AyWD2h4S8TrlOUjJMUBKItoGnIyoT9vXe45lnUf/kKoSqEB1?=
 =?us-ascii?Q?2t5B/NSqfRLrhaIJbPTTjUIfvCdIk/rwCD9syy0J7G4y/QOnEO6N3v1EDcDZ?=
 =?us-ascii?Q?u7WfrXhCuli7vcwGKlLQQ7Wdi1fg1TOl3swCPtNF+6YHAmEbglcvfgzlp/i3?=
 =?us-ascii?Q?TwJ4DW0z8sTLtBoZ92mdmRDo2i6VRtmM0xpKA2put7WdFXKcXXKOao0QFu/J?=
 =?us-ascii?Q?tPIiVT/B1D8GFDXLQwQuzVIy2WKI5T6zDR4Dq2P1Qq71/TSVULjLq0VASpdp?=
 =?us-ascii?Q?8VKqwEdJwxcZxlW74jO5S+O4E+S/RCl8CKVUyKegqaPtCba/pWbxGavyTzvg?=
 =?us-ascii?Q?xdv/+3ml8qRuFE7uOslwz7HtCSQ0hnFxOUGBx+PfC4MJcixBTW/TJEs2ImnT?=
 =?us-ascii?Q?QyHFa4M80vTFiiLhXi2JdUjoz6E0BfyYQArzeIHCPeYK2e6V0UaO4VPnTcqT?=
 =?us-ascii?Q?85eHT/NuNKuitoPGZtIA2T1sTWemp3IpFcqG3mEogr6GiN8au+Sqk4lnGv0s?=
 =?us-ascii?Q?tB8cFduk4onXEEkJCuKIXs3gH/a95q9cA0s0YXn8dvTbfCefgF8Tm0wtAS0e?=
 =?us-ascii?Q?EwcQWH87Ml6Pc9dmlclNjCTZGIgz9kNSMQUooJj82Bb8MgtRvhnfE6hDrHX0?=
 =?us-ascii?Q?UmXqwY0qEOxX9x5i024z7b7DDhUz1srTxEkZcenJn6LlvcWw9x1alJ283PQJ?=
 =?us-ascii?Q?s3/s5kT6O2WP64mFR8iCWVqdtoOw0SkQakZF04H7Ga1WNhxX+kp6uvDKbv46?=
 =?us-ascii?Q?+6l00E9QQvYF09VmFBNNCf9mhJcE8SNxut9Cly96nItuqmQQP18V1F0n3WRl?=
 =?us-ascii?Q?ORMjl2R/jyaDSfF2cumOCnN9NsxPHNYZE6kf9H7vFRSIulgvAgun5A1ZY/aA?=
 =?us-ascii?Q?Ka6eJ+JiHUWmNgN+pHflwfQH2L6GSQrSxodJ2HWCtlYkkLmG1rC/QBOT6MaL?=
 =?us-ascii?Q?cqGZMYexXkOq6aRBE0CBBtaM7CKniriA4HZJJpxtPAY6Nwe9hx24PL4hry/6?=
 =?us-ascii?Q?Gwu5xf+u4NWL+AuKONYOEQWnKF8wJXI0VcBfCwIhi8/saAiqYurK/HoMoTtO?=
 =?us-ascii?Q?yk/dnUTWZXdzHj2INxscEHpI7C065VfrEs9VVoA0AZHiE1oEprmlcK8n7MmG?=
 =?us-ascii?Q?SLJ3hqDuPy8cawIzITV1QIv0wyu+vQQ/We7N5plnAcBgbscWbzn15Y9g2n4n?=
 =?us-ascii?Q?NGw6tW+RD8hlaFuzjgGHhukN93oa+/wGEjImv99U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QV7JDKAm60tsyKeGDtyuv1v6H6o9SjyDxhdT2egfSQZhlCYkLwGBLqojnYpo?=
 =?us-ascii?Q?u8lnGnuNkvVoPLANlvAq4oER52+eTKOXTXZ/P4OmxLcfONrXqmKXxP40B0N9?=
 =?us-ascii?Q?7IIIrN7Ob/+N5WsM+eMEp1KvM02z/6P2NzjK92uJcZAVrFEePx6TXH4B6LH/?=
 =?us-ascii?Q?LrqfFsFxovl6foImd0hfqUcU4UZVrF8mpmmNda1GHCh2GRMMTxkwhX2IAWXW?=
 =?us-ascii?Q?0cA0ZYTM66mpdhwgGYxJPTKp/m4GA0C7kazIpoJofRls2gd7GwNVOViI6B17?=
 =?us-ascii?Q?h64o0imc1b9QCvAfP6mDC1WfZgkEbOQ5THeWPJqb4pSC9K03ruEK8qnfJZIb?=
 =?us-ascii?Q?hseGT7BQGrK9tdkE/fpd066O6S3loqZtHLzSi2LX6mmZuLuX7bLp7jcuQDk2?=
 =?us-ascii?Q?5Fw9V2wi+IgXDtMlAYIx7FYIRtHHxSLDobfFCWraGHRyza/wjMi60SLTH1/F?=
 =?us-ascii?Q?KTJzLWQnX5RwuRSoqqGBGVLv8WUDiP8MqEGszc0COUktZx7QEdNcTTHf7p3A?=
 =?us-ascii?Q?ZSPSVVXK6nnG5pyEar7J0RD+2+3hDHXcsRiWKDF0q+7bODsKNOW+2nfRDn9O?=
 =?us-ascii?Q?QVhUO9rsTXqUHk3v5v+GvA2+vAiVq6tDiSb3I1Ztx35WXO72Eh94H7qwaGKQ?=
 =?us-ascii?Q?vTQ3VcSCVJjG0ZoIMYT4Jdb9lXDS/PzaxYr6+ZVq8qMXXygJrQjjvEerNLRN?=
 =?us-ascii?Q?dwW66xTFnhT9dTiq4hBRZGZOLmKaVOxPXnqoWOnyOKlmZR09O+zbbacR5mdn?=
 =?us-ascii?Q?lo1IIfizWuTTCMWClhM12aQcTtDc9hdJTZmd6bDzeg02Ev9IWDJzrzBLFWfa?=
 =?us-ascii?Q?UP4mhA08Na9tDrIn0MSrNKAuMXMvUMA5QRnCFHKdwTek1eKqzzyTZ9asEJC8?=
 =?us-ascii?Q?ZMojRW2pWB8pnMKhWaOzaS1ShIp+2AN3/riBtH4rQFxLdMCW3Ai1lWcUxt6p?=
 =?us-ascii?Q?6I+5cYTC8jIV0sNmbtlJZiSfnOKCyHexGe08gckA8eZZDn+K1CSaEwAEgzSD?=
 =?us-ascii?Q?hDK4t4W/+8OgfWxyH5xvTTmRED9HUGMWyvL8k81aFrlAsClU7F/RKaPRKhTL?=
 =?us-ascii?Q?cWSUo9F1Yy7O9kpqWL4D1ZYKhbTPFziqaxJlyUK4nEngg0OfZ28UtJVL32iz?=
 =?us-ascii?Q?EbofSgzVirGjaDLodjyLcXP0XPTkPKLYY6MU9sGvWM7x9SmYWMD55TJfohOW?=
 =?us-ascii?Q?be9QLMvL/aIfBhr+ssLjlL+QFgV6HjkTf42YTdK+zqErrirasXrdJJqPQVtj?=
 =?us-ascii?Q?XIBh2cuT2WeO/ymgJKgrdFPiZUJsq3okGs5hwHAUYPkW2HVWf4Uy4zwG7iHr?=
 =?us-ascii?Q?rzfe12xVh2cvEVQvJGmAwlyTzDii2kzt/p0B/JqU+VDeImHIIhCGxmKzlnIL?=
 =?us-ascii?Q?5B7GcHD3V7I70iIS05Ns0rDUZvABqZmlVN0KgzRl5iMMGtBGZg0Iy1hNJ0WY?=
 =?us-ascii?Q?FOKEgzw+wJdqXYI5kktApqH58COADoejSgBec+iwsTd1cnxfSbjNg5Yfa2B5?=
 =?us-ascii?Q?lpX4/uyD/lLPLSrDLJL2Hrao2vql2TCH7gf+/wrBsXNW1A71Ks/+Fhn1Rc36?=
 =?us-ascii?Q?d5cSJavhR38MYB/H/HfZtgvTOXYIbFxtcIa+m6AlGXD8lLlZpLg5RBxR9p9o?=
 =?us-ascii?Q?xl+PV2ylW6VZ0f+2BqWfRdRh8ddVC/efAjAsVkdTCU4DJE15dWzii97x3Pnz?=
 =?us-ascii?Q?mXbMgDpNFJ0BuBMRL6U+yvXwHZLiXB1uFoj4upANXFkKpI+cw1reCUATfziA?=
 =?us-ascii?Q?h5IZO+t0LV5m+9KXC255MT+jZhvf08Y=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446f26c7-fd66-459d-1011-08de62f8a2be
X-MS-Exchange-CrossTenant-AuthSource: MW5PR03MB6929.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:48:37.0998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0w0Twjx4gIF90ZN3UM2twZ2wSErEnPwZcDiknYeEuE+CK8Gg51PDRnim1txZktOraVaIvYREJMKRhrhUrmVYA4Z6EeAcV87ZKrpSIoQA13E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989105
X-Mailman-Approved-At: Tue, 03 Feb 2026 14:34:39 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

This series enables NAND boot support on SoCFPGA Agilex platforms.

It adds support for loading U-Boot from NAND in SPL using the full
NAND/MTD framework, cleans up controller-specific SPL helpers, and
enables the required NAND configuration for Agilex boards.

No functional change is intended for platforms that do not enable
SPL NAND MTD framework support.

v1->v2:
--------
Patch 1: Add SPL_MAX_SIZE dependency

History:
--------
[v1]: https://patchwork.ozlabs.org/project/uboot/cover/20260129050446.8858-1-dinesh.maniyam@altera.com/

Dinesh Maniyam (5):
  mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE Kconfig option
  mtd: nand: add generic SPL NAND MTD loader
  mtd: nand: wire SPL NAND MTD loader into SPL build
  arm: socfpga: imply SPL_NAND_FRAMEWORK_CAPABLE for Agilex platforms
  arm: socfpga: enable NAND support for Agilex

 arch/arm/mach-socfpga/Kconfig       |  2 +
 configs/socfpga_agilex_defconfig    | 11 +++++
 drivers/mtd/nand/raw/Kconfig        | 30 ++++++++++++
 drivers/mtd/nand/raw/Makefile       |  1 +
 drivers/mtd/nand/raw/spl_nand_mtd.c | 76 +++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/spl_nand_mtd.c

-- 
2.43.7

