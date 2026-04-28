Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD42FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A7EF84676;
	Tue, 28 Apr 2026 09:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="A/99l+Mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A36A84150; Tue, 28 Apr 2026 08:50:27 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B79B83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:50:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBv7Ywg4eBlFxN5vE5D6bCGg7yl1Fq5RuuITRhcOMsHwtIOyyL5ITOMfcliGPoi0lbRaB4TwmbemAUJqsGQtjyGwuufIawNmvW16J0yfjeilTC7LL5qOuFsz6fRHa5Y7Av71qAP7f4wLSasWgjpXjLGHZgMPXZmBH9sP+tLw7bDKa7/vB8XJeK0MLVHWr2B8/SbW18Px0+51UheNCp6IJT4UZyXmbWjc//U7rbfHC01OwhcNqY1K/joiuKW2VYRLJcMxg2OXTaKtWO7SA2WnqdoCEyFyxpWE6OCGjwH8fe5ROkSK+M6e4g7RpUftGhfsGvVYvFzSnuKw5IgXiQ42Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgPfifoMJlBg23e8E5glbqZdNu38Y2j4Q2vz0kQokuQ=;
 b=Qdvb2zCKhzmVEjR5bV4VLZv6QwRUjGsud2dFKr3JQDnK538QP6Oufu8vDliCZd3SA42rudvLkrs3PppSHMQIgOg0IRut2VVFEywpC74vbdyWqEBPnbTMH98kbAYiHqswUm3OM0lIpRIGbZXy1exWAzqpEPDELIq+mtJ+Kjv3lLXxCUolmaPTNBPuTNYxbQzRT1MKSf4bQWoSRmf8GBSXzR6TuWZ7Z0qftml9X4QHalphMKgUHmFCsDQwszjGluExn6x6KKrYDyuDSxqGoVS2ZGTbdwdk8xPTmSwsRM6RN7+vwWFHx8E49buKfo00xguD8WzaPMSrdQWctkPFota+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgPfifoMJlBg23e8E5glbqZdNu38Y2j4Q2vz0kQokuQ=;
 b=A/99l+Mh3YbFUs038rk/axKol3s8YoGDN0rYb+lmXAdGv8fchyKVR5VXs+doXcLZedgYdH4JheXPyAkSp9qdFm7EZOoloxeCMZJcseST/EUE5TvbiUi30XM0iimSPo++Thc+dZx//RMOx85o8uUOqLVS5Lj+tXgE2Hl3BCI3wVBLUitHpxGzQIa4rtsY+I8wWNo6ES19uOGwtwW4vp6DMcC0NEBFcKQY3ATSWdBu2raprONbDstchLNnpytvwc00pVEcKUsD7L9UBWvbqyx8lBRE77Stcc3nC+qjUF6T8HeFfq/PGHpsJEEGaViuNoOgvZGIacs7XdrcSzimz/c/BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BL4PR03MB8038.namprd03.prod.outlook.com (2603:10b6:208:58d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 06:50:22 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 06:50:22 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 4/8] configs: socfpga: n5x: enable required configs for DDR
 retention
Date: Tue, 28 Apr 2026 14:49:48 +0800
Message-ID: <20260428064952.3965-5-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428064952.3965-1-chen.huei.lok@altera.com>
References: <20260428064952.3965-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|BL4PR03MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 85110d5b-ba69-4e92-5357-08dea4f26b41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 1tR3DwHqPpgDhq+ynjm+OfBkxe4F240zpVXtfkjGw9MVy787+YxXlxx2FX5Ti1lzfp0ZReCT3XwvpKpzBl6GcdVPEdww8YrYwzZATtgBvVkyn9Ymf/ATZAM3xc8jr2qVt2VhncnUq8MNYidbKRo6GcLAiFlC2WoljuN7LEsMZBd8m7vA5rN0pECAX1WOE0cGPOSt5VadW5vojrUgRxlnxrZTiuQTWSpaC5PqYCEMJiFgf1ymRoJf6ViwiiItq7QyyFFCJC+xTvYJShIYmWk9mZWsQk1RmNCL0S+TWNIAHEk/SUzvEa0MPR4QV8RfIThqPKQJC5fpqU9YAu422BTTzHLHWMMGj3Y0cqTY8/S5xuhi413zX7hSHTQJx5WWHNs3Ak0XCwbXnV5yrA2QNTvPOtIfRuQmu0rsFP6IEUaTYsWsdHGrqxmFTeiTbmphoC3PjI7fa3cFbx8RYS7sRyxlOHoJkypQbPtZ5bYITwTezr2frl7ryJq9f7NjA04mvUXpy5QP0WQuWsNuZEhamjQ2KtCi7wsiPyzCaRbqZRkNtSip7oC0jgWnG/Y0zqhXUCzf/e00Hh42sBHCqFJGhtoUkbCSpfwLjyVXUKuIaftTZLZdpMqQ/uMowFhZd21u5/I+79mP7FGgNzbWOSScG9WFFD5vhCRkLeG4dVv4Caqf3g96iyatohqDYsezDuac9Ss9zCNEK0kSzT2Q9qRLp43yVZw2Z1YE7qbiy0t3jsqC5dA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uCtC/z+YD3tUbdK3agtBj5xCdG6XSEdsHbYlVfE/tv3eyRdRoPKoZ/bOWwSI?=
 =?us-ascii?Q?S5cCm5EL7EYKBKus/WVDMzuGNMLVEwtJ8GHpZIjKQ9RRpu+cctOVBVOME7mj?=
 =?us-ascii?Q?rPid/AMOqnjcnQMD5BWONBgrqhaAHJJg3oIKl024ODyE2nB+RGorPTjrwNQs?=
 =?us-ascii?Q?UIv5hdWEQ23nlpLK2FDTAPZkUn3NfVdsFEXEp0BuGPhSewrGiWMXvYvwHfhI?=
 =?us-ascii?Q?5PF8a8DE5DfEsNhsQ6Qb/HJ/Idhe2JOAmmwdiHH0rKWwOvjIZyU3jknjIS0O?=
 =?us-ascii?Q?sPYtt9O8wkDOWSTY97KKOpRHZ2wpRdt723MKM9FUxd0LvvSS/F+XKIDcmkvm?=
 =?us-ascii?Q?OW9PjUp6vuBWp1YXXRb0yqyUPeJzEJKosok5WlSLCcXWJDlrHRzrL8dK5qQ6?=
 =?us-ascii?Q?5lLkqmrjgHYItwIUhqnAvk9me39BX36rqCWKrNSl19SA3uLHDCa+I5pZ8Va2?=
 =?us-ascii?Q?/4RowIl9s1dEE0kuloNEEDs5DsnAmBWGX1L6P8vdH9sRkHCP1lfAaGzD1m3e?=
 =?us-ascii?Q?j7odXiQDB3MopxrNXv+y5I9q5HpApaNZqGZo/wDG8PnKuEcEikKXZPz6eKag?=
 =?us-ascii?Q?fHHlwGE4tXlxH/8SEU4wFnR1/MDjk6cbXR8zHw/pWMenZuRk0i5qczmROHu8?=
 =?us-ascii?Q?5Q7ocDKd38aWtok8GEChN4mXLSKVQafl0XPThBLuZxwN+k+b5LGCoVLsr+Qk?=
 =?us-ascii?Q?eas8qfKK1jz8WlkCyLJsGHOMjLI7ITfIqpqBph+pFWPrD5ZdGm2sV+5kHb30?=
 =?us-ascii?Q?OQ+BPVRrlRg5u94r+0fJ0Rw4DKOgK6qOZaMZHe433gRhxYITg8hjkC7CGnrO?=
 =?us-ascii?Q?sPBcx5nnIHNY19G7WcNEEQOytIV1y7doua4Mh1iHyq62cQ1dCsZ5rPeMD4xk?=
 =?us-ascii?Q?89lCwUcLb7Tsfct7CSmICgLN9hV6zUeU3itELBAVe4+l8T5OjiXLtCY8BJC0?=
 =?us-ascii?Q?1LeZzJdawAIY+ATbKwYCIiM7cZBi5lgCdaozxuxphEtdrDrFlMQJ4RPHJG+v?=
 =?us-ascii?Q?VhJN3AeeJy4v+8muocaeXqHW9gB1MCpttDz+qUViCPP1RNisiX4Y6UJg7C8G?=
 =?us-ascii?Q?RGWsTVEk3G8YDG+yS+i0gVhHGsWER+GAY1qmwLAijvWOU9Xba4pH4tQlI6wS?=
 =?us-ascii?Q?QdLvZe58iyBEyCiun+/asWTKmUOV+g3/vLyf6kuRjafT6Jo8nJRssq2f0EU4?=
 =?us-ascii?Q?zNpyljdDK/jANkLEMZhA2o0bMIFn1TSs27NHjsWleaeljfV4zxErMUfy1BYE?=
 =?us-ascii?Q?9Y+NLIM0l2kCDekcR84QeAr503r6yQptTUgEtVuzAe/1E/ykhnLDI6Rjk5Dw?=
 =?us-ascii?Q?SRfuku8dT0GL3H6U4nLaZ/paJkM8n77juljSOMjYa1CXG0aK5C70yqPOX6c4?=
 =?us-ascii?Q?NPusrXzOlmr/rdTEecymgVc4PxjIyWjOIuZ+a+TuJW+qO8QDM+CAl870oVJH?=
 =?us-ascii?Q?cxU1Q+8D0feQmP31+Br/Ve0KVu7CWEAMNm9gthktxhy2x/kcIlHg5B8HizWY?=
 =?us-ascii?Q?LMoZb9wDg97xmS+eaOnpvtyaHTtKRXYmQ7ONpB8j+XUe/QSBd/w2K1RP575Y?=
 =?us-ascii?Q?rvkwkZapuNIE/FEjqYmhmnkgM456zAffgkCBoZ7nexgF4oPXcjpF5auMLoBA?=
 =?us-ascii?Q?xiEeIhOyucYate1VAbYAUi5fjolhLl7lHtgqUBhEqycamc6rckTOHYA7IIyd?=
 =?us-ascii?Q?DyGNETwlNETX1MVckm/o2E3gaNkGlEyQV9WrbH43TvIRXKeseZQ6uiiB3YmK?=
 =?us-ascii?Q?HkEgFZDrSdOVI/iFLNOK0DxG+X+IjzE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85110d5b-ba69-4e92-5357-08dea4f26b41
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 06:50:22.4580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEacavwaUWajWhNwQNxfytXIP9n4M4LDtAIO2s3EeHJj6H94bvF3i1kC1X6hRK+3v+yU32QbVut7Zzl6IxpcSEERydN/INgEyxzvaUpLB0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8038
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Enable required configs to support DDR retention. Including generic
firmware loader for loading backup calibration data, and SHA384/512
checking.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index b6df9946ef3..273e74c6499 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -90,4 +90,8 @@ CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
+CONFIG_SHA512_ALGO=y
+CONFIG_SHA384=y
+CONFIG_FS_LOADER=y
+CONFIG_SPL_ENV_SUPPORT=y
 # CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7

