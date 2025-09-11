Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC94CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 05:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2B3E832AD;
	Thu, 11 Sep 2025 07:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CFaQdkKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0528319C; Thu, 11 Sep 2025 07:12:32 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098978329B
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 07:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ze3YKqe/gwWGavsBYhMcIp13VzYX37a8RjkvW2CiYoiTEj0AgpkbuQ/u3fG9Avji9ZixeF0LHuNqouuJMq9xCXOR5oCgEkleRzZn1r/AOygrXRYpKVin5HL2kORo2AK76JR5H4lMKF8IidUXPnCZTlu3bPX6FA20t11bU+R+nSZe8m3vn+pkjhaEsFkF46bx2YRPJfi0oYtU0uoN4LDAF7rXvDcmfqd7UobXtrZV2k7M4svxqWhvqUkUhwGWC2etsZ+ELeBZoDc3+ptEY1w4opqTrkilqj/Cho27gqBDl6a+jUupzBlsRFeyWJMfXIR1fW25wcZKgo20QHiXCfgR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMykyzucuqU7bDZc2/kHwttJRYF1ilOn7yMafmQcStQ=;
 b=ptLLy3zSO3PgNj4A+73GofRJBMatems6SuIqcKfBXZH+IXt8jpdmubVmcR1BhyRRCPoVlfdH/JI6PavtRIytSnlRZyZBMVmZreJEgzRkNPX6NYZ6XJfTe25kJOGApUNFIwqQbSN7vXzH8FirMTg5Aa1YLbCOs0PLsj/LL+Izu+bOiPi7G/Hc+CvH2iaWlLXaTXK3fSexiL2u7aCruba8k6u1XSIpV8O7fRs8xCugGkyf7T2JZvEdXWRzv0XKZMfUclnNhnEbXxAtMFqDfwfraAMjP1oyKETPrCl7nFUC9ZfMWJH2gjG7XuOWRkG6fP1o+59KNcoUruFlf2iG37HrRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMykyzucuqU7bDZc2/kHwttJRYF1ilOn7yMafmQcStQ=;
 b=CFaQdkKyFxYbws3YMuSXdSb4aCn1JWHzV9D6vZbbPecs4Tp7UHXqMiYyTm2PM0/ypTF+P4rwHYU9u9TrOx+tVyH6/zTcbmUTNJrBQZkasFnq7LNPgxuscoFaq1u0i+oOu+Qsp6gY/EUDArzMt5FFkXxkHt8LZzv/TyWH1wSltBefrDdMiMlRsNf6Ij56CNziOcue0N9C3hFHSqQULsF05X0d3NX9bf+qGsgPxX6BjZhLb28/Z5yjOD4clywNnk5qR85YcJ7P2CJzENOUXMPTQx8p4IPPVgD7PqdQuXgv0zrStMGY14FyOorDAixpi+zKAtUApYAzX6gsGWXjnGF9hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by DM6PR03MB5050.namprd03.prod.outlook.com (2603:10b6:5:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 05:12:29 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::4e88:c0c9:a27b:8f13%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 05:12:29 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Date: Wed, 10 Sep 2025 22:12:04 -0700
Message-Id: <20250911051207.10479-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
References: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28)
 To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|DM6PR03MB5050:EE_
X-MS-Office365-Filtering-Correlation-Id: 79822936-3b6b-4f27-b05b-08ddf0f1cd3b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HpsXyn9qSVdpzme8Q+Gj1gwRgCV0XUQVUcSzqeg+mJt62EoKEJBHvGaiD6Iv?=
 =?us-ascii?Q?V4qZT9xWzGmYRXXWvAW92TjGls6iBFZArCGZAbk7oEg0OaUkqn79APabjqBy?=
 =?us-ascii?Q?SYO+fF/3Ba0ChZ38jCqUSJY46kYlgdV9/7lyZ0MwCHjSNew/NqdKKX6SGMD1?=
 =?us-ascii?Q?0qnnbShUQnDP07uo7obVw2CQqUuBY/FDjafmDMbgHEgzMmKz43b6NZ5HkQy3?=
 =?us-ascii?Q?ZaX8fp7M8ujbcAc128fH6bsV/vbv2j/j80PceweTzvottd3pFJciu2UTSEXF?=
 =?us-ascii?Q?fCcvz0VTGlyDswwHbV9zadlqNkUfQzRej5BY6G9Y7ZT7NNhYvaaiFezSvinz?=
 =?us-ascii?Q?ey8ACLU6+gkVm0gzzpuczudQfwGvJmvSxDiH8tQWjxv7CZL4SY4WPoUzkCfh?=
 =?us-ascii?Q?JmQvZkHznCp8C//2h7N6OUvHZ8RXYMiYihZENmUfSKFHBFJ9FRxKq0ZUtSvR?=
 =?us-ascii?Q?VQ8J4UMuFj8UjAIO21o1Ox37RDWz+RXMhwAP9TMWNUf4Wkl4FrPOHw6DALXa?=
 =?us-ascii?Q?NWz6PFkJA4GEhvgIUWwhpHMOftXnJgqECmsOApsNxQVf98UQj4kWpNw4GK8Z?=
 =?us-ascii?Q?taiJ68QHUCC/Fn1XntDa2Hc1WJEifQZjQXw/KuJXyvLck8xpygzUR9NEg1Nc?=
 =?us-ascii?Q?TcFpTkEsF8r4u5xJE4NgFgqLig1+2OIOxlQUWRiG/XcNXKCcu5Q3n166sbWV?=
 =?us-ascii?Q?Pw/1kFc0Iap+sncQQhSrNZCXY8Zd31Vb2VFE6iwzvNOaGIeSYKKg0v9BVFW4?=
 =?us-ascii?Q?ZZJUp7ygFvvIALvvvLplr0sQyWHgMBm7yWilCZswlLpCr/7tr3rLYk/2uiVi?=
 =?us-ascii?Q?rSSl6/5qfxGf3oZzLtPqSs8uO5CwzHUUtlOGRl5s5rV6JOifM8k6nrTTvytg?=
 =?us-ascii?Q?t+YklyL005qBCHysh+MSFOYUOA4nLcGdobppDJu0Y6Hfp0HvfvGnaTrH6GaA?=
 =?us-ascii?Q?NmmZBoWqppBQI6DBp6OPmwkkHqxFnsvbX7kkhz5U3D+mvCDonAlSCJ/26jSf?=
 =?us-ascii?Q?d8J58dd0Su0PBXnBrqRDO1cKVRfcjD6xNDc66MvQD8UmtdwKFat6uEvB9asE?=
 =?us-ascii?Q?/utjTwtWskOpRBZzjMEVkNAFh6MN96lEIc4IPVqbpMjZqMzZgrY2zwq93z/Z?=
 =?us-ascii?Q?lsRz9cv0q/QIESs8V6PxSTnetLxVe034CkTycV2QHisK21knChbY94yNhC+Z?=
 =?us-ascii?Q?rsdMRx1jXfU7At1HFyoW/HkWdezpU6Afo8eqT3uutKPSHlaRLKoi/T9pDd9a?=
 =?us-ascii?Q?wymvktcKt/MnemBSoNr3t+GmzCLszfiQryW6Olzfk1NqtMkVt3cagQTD2/bX?=
 =?us-ascii?Q?T96cf9x6LQ7V37JnN2RfKeY5l9s3YkjIj4HO1kgwCRtSWlO1UTfEbhLhB3hS?=
 =?us-ascii?Q?4bNAchY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qvHdT9k0/16K7utrp2ZdG8QBiFqltECBaXuwbS+R3gw6MEnuF5zwhn99SF5S?=
 =?us-ascii?Q?M0Nx3f8+0BLj1YfkX5ngP4+ft/+e/HrFxbcrED52Pt25sykrpAEup2mm8Boc?=
 =?us-ascii?Q?EUEnd/ii6KypO5/z8Tjc6DYOzdlkgZkw4H2bkaKwYt+DI6T9my1NFwh4R0YA?=
 =?us-ascii?Q?a+KtOZA3Gy5UtY9oWtcHE9SiU5uKYnhHuvaFZXjONzDxWhdJalGZThWf7abv?=
 =?us-ascii?Q?YSLhDMFwYyviGf+EAhtgxPc0YiVOz1kbMB4IMU35r+zuj6gZcvhfqxMjAWgp?=
 =?us-ascii?Q?RR50rS734FoCLUDYH6MHeubNHs+Zee6+zTWeIokFkxKGpcL9AhOcn5jd41q2?=
 =?us-ascii?Q?kZz942HX1rtCy8MbF/dWm33qicVjNhLQqnfi/Kq/bt+r6db0gHgpUG5LxWol?=
 =?us-ascii?Q?ndtY6kxPQx3hDqovWX7AUqG4nJOT9IHm/L7dhFo49FOX702ipiEMoneftcfW?=
 =?us-ascii?Q?pHVfId/O3PF6qrWvxyvDgu6NAXAVXism0FHB8GE5sghD3r16IAfhVKhqcz/P?=
 =?us-ascii?Q?d8gwqu86cUwRh5JJYAgwxrA2Ql4ISp7oJNZTV8GbsuO+XMKiocRaF9PqGKVM?=
 =?us-ascii?Q?+lfIPzSlt0nQPYrY2ecVuWTMhhYaKYwHns6C0OXFTSQNgXCdtutvDgDvtngq?=
 =?us-ascii?Q?ZADV5yvHR2tv+lOD4cuXS3d/ZxpH/3NRlmMlAy5L33K0T+xwI5oOssnCwfCm?=
 =?us-ascii?Q?4JsBsX7jUipe9Q/Nh7lHjpZl9nSb2C8iWz920J3Wtzkoiy5IT/+yvtsEBMA+?=
 =?us-ascii?Q?iDNeTn+Ne/d/GAftN3C78aoc02pEmbQ8KIHpUFcaK+EfkrotWJDwqGaORLSY?=
 =?us-ascii?Q?FspL87qe1E23/BQuaghpEL4RCe/zLB8eAveqTBaLa4ZV5f2916YODffVKDwQ?=
 =?us-ascii?Q?XpfH/+gE9sZcpGG1pbsSPNLxxS2TKM+nvpIOI2kvJ7V36fD9W+GwuNijRo2b?=
 =?us-ascii?Q?3Ltz9y7ZFOkLlsXM32ER4DM8WQJT+VzjRwmZLfO9q8au/b0fSEG3tZLOhUHq?=
 =?us-ascii?Q?eEb1L+GoEtLnkaut1bbkPXgiYuA43QvFQjHbvIMKyvWlnX1tR3Ke3egIp7mw?=
 =?us-ascii?Q?utive7E+YeuoAUomYhFwD6zKiPnsMNDvO+Q9rQpbpQfzeQ4dDlHqr8Y2MY3r?=
 =?us-ascii?Q?JgukWeEa5MnVNeR/3WAOiUZ0ukCtnrTmE+hqz7Si++wvIqHvwXAUpfUuVPK/?=
 =?us-ascii?Q?7TVl6Mv73R4p5MbvetzWlTj1AVbAecmU0rC1zeOvCAWX6dXJUfOkM97Er9To?=
 =?us-ascii?Q?Mz3uJsw2P7RPWJfQSBTVPtxdgSsAyBHSnM81e4UtzjkqLKUMpUf8I8oNTdaz?=
 =?us-ascii?Q?j4oIJQwFCxbqCVoESoiwlU6iAbvaO12nHS15g8S1MxVNIuk03dedzcj/oKV9?=
 =?us-ascii?Q?Ofus7QysV6rDSDeFx84kJTT1ABQNtT785g/uwy3IjMNtZ4lUBT/3by5yZ+6r?=
 =?us-ascii?Q?Xt5md3gBJwb/3KSfmoAk6WStqNM9g2Yx+EAOq0j2qfhQmKWPi6EmQ+8kK3Dt?=
 =?us-ascii?Q?n/e0WYGxxyTIYhiVa4HzezfxZTSwGqT1ILp/SLwfExSNu1dbrPyk3mtJWUV6?=
 =?us-ascii?Q?9zuSgDyKOogJmjWt5TRIksGcwPhShrmkKQJMyyPGPT7qs4BDwnluyzj1bHSZ?=
 =?us-ascii?Q?fu2OaFyLPggKoRsNOl/l4/s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79822936-3b6b-4f27-b05b-08ddf0f1cd3b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:12:29.0324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxPeSV96A4OOi5EvL4iXQWm+5jWJbMpmdTerUkx1ZDauF+XI6tA1HJJKsLkzw2Uu6HoeD3YCKJbbb1uCVroXe+OwKg7zBtckSev4AOwA+r+/bvhQ2SeniEBPT4CffgcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
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

USB 3.1 node is enabled for Agilex5.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index 2ab143e38f8..86e6d374948 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 #include "socfpga_agilex5.dtsi"
 
@@ -87,6 +88,10 @@
 	disable-over-current;
 };
 
+&usb31 {
+	status = "okay";
+};
+
 &watchdog0 {
 	status = "okay";
 };
-- 
2.35.3

