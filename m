Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E8CC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 04:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2F1B81FEE;
	Tue,  1 Jul 2025 06:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pzwu5RVM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE8782B18; Tue,  1 Jul 2025 06:57:00 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 573DC8006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 06:56:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muqT6CCOb8CCryME3NgYsiZc5CWZSfL3Hbmu271If3qHaZSJVvkzkmLlt9WDmP0ZiDObnrW4JgxtrClzQXgA2JGT4t8UlcwqtAvMCUsIrxTTyNKOeLlP/AJ/bwo0/zfW13wNDLstlZSZc8X6dKOExX0PFmFUz4qw2aLpFh8e5QpIkh+CWwnhzfZrGnhNjQ1cohs8oAqkvh7m7/AaIl0Yve463Q+vAbe6R6fyGbbe5BfkVv3Ix0qjbOVngo3FX+BujMyF+lieVKGuyvitbV/OjpcoTGoHwJVNB2hvgnr1xgEA4TIzQ+iDkrjPeLMMMK8duagpfAcDGDYfG6dK8xD6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXU697CbD2t6HWBSt8wKpgJBz6KZMCeA2o9GbNm9jBk=;
 b=KnG2qkZt6w9SSR2LoKBWC4lYhohDcUxpyi9ySi1lR/Az/AgoLTxkmGICvg0u7yOhihh/BcphnXZKMzcYU5KoR4BU4CA5d5iQNK1z3odA68GhWdwwVuCtYE7poxjvziJfGAPK5dKASzYMQ///wgwOaTe7N0AKZcnjn/61IHJgH/2oAYxLvcy1dM3SoBts1++6cJcYyxy9rbbKCIDR4t9mhMrk24mI6ngrymCD/FvjoK6uWFvASykVM8ugRPKQqGJcPAdkZ9zMnbTB8ZmrwNvpdQdIUp32WoiJx3oJ3bjHsixZeJK6W9bmevc8U+B8y7cBSUA7hZsepJthYDifLH6Jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXU697CbD2t6HWBSt8wKpgJBz6KZMCeA2o9GbNm9jBk=;
 b=pzwu5RVMHydzqVxC7SSl3gQvU1vMVZqu5PVK02y6+dAxcs56PSehGHs9WGvpkOFG3hq33bn0waRcpnfaJ7pXbg2cjhIBHXXjlNjkvsu9afoVLAtTUqigZxRaFv4y/Amq3yypJUP7GaoBegBrMBeisKyyTPA4ZuN/oaBPY8RcdwDWs0hYlOeXA7inFDHR7gPLJQ4IzG2KDvG9M7FVMF+1700eEUKC56syDZTftz5eR8vRRQTjb/9oKmAx0lgqrJYict4Fvhyf62aufQqdL8f/mHrnhRGsIKFK4sx2fcA74Xc2L0v/yj7cSVl6XFnuKsY5ULrk5i6AQ6lYZq9gDcj6nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by SA2PR03MB5850.namprd03.prod.outlook.com (2603:10b6:806:118::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.33; Tue, 1 Jul
 2025 04:56:50 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8880.024; Tue, 1 Jul 2025
 04:56:50 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] arch: arm: socfpga: Include BSD-3-Clause as license identifier
Date: Mon, 30 Jun 2025 21:56:44 -0700
Message-Id: <20250701045644.10270-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0097.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::12) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|SA2PR03MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ef78bc-9756-40d8-2882-08ddb85bb0b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ncz64Cl+EG5uG1q78rQElHElbcEcpO2VxYn90QzT0Iot4SIeP8bb2fK+7AGV?=
 =?us-ascii?Q?MEh2/nBsYWw6isQTnkgNCYqVEljTD9++QfIhpwe3O2/QemX+RB2u3ffei/Z6?=
 =?us-ascii?Q?7nZNMGdTqYmQqsxemiK/p2ZlvzaIdwXKdiHOvcsngjgETlxbZV4V1gP50nJh?=
 =?us-ascii?Q?zg5j3N4nURS3LGwuFJRHOtxu757Q5MOt301Szp84wEpskK52G3BHOFryf9G1?=
 =?us-ascii?Q?c3uQAiA72q1lzxniv38z0zSsLcpaEhM2mu70NdXm59yFlLLWRQDPErsxEM51?=
 =?us-ascii?Q?i8DvjYMjRb8VbOWpaBjn1pHVDc5hkJbbpxI6M14ws4ynSbWgHa6onXsU9d5G?=
 =?us-ascii?Q?oid1z4zVSAKj8SIYoqEIE1DY2L9dqHiRKgjrZ12e8BagnmdTTcG8bzq87x58?=
 =?us-ascii?Q?CEBIXQavnQgrRInwDY47bDuJk+8QF1Blv0KHZbFm/T3tDIAt5TATL50iTGDV?=
 =?us-ascii?Q?og6PQgzcr4X62syM5jhS4waxGuxieYniPT4cigH9LARWkrLIuiM9kbuGQrX6?=
 =?us-ascii?Q?B4VkJEToo5dkgFGE8YepNdm0tU92g/eqEGz97pEa0sDEbkVkeztl9IrbTNdE?=
 =?us-ascii?Q?cbZjhF233KN09Hwc5sDnIraG31i8Bpn4KhWKtL9ekm3DoeylCfgXIc5soNQq?=
 =?us-ascii?Q?My7R4XuFz1eyJJJFIV1YdkLW+jVRB0Vf4CG/CSRyCM+WN5C8DrQS3UG4x9y4?=
 =?us-ascii?Q?oP1ymkH+xJHz7vkI4lm+zrW79qKe8eiHH8hON8hsgrmtB+rZ81QcRRAELzDA?=
 =?us-ascii?Q?VNX7QZHZ2tbQAvaRG0ef7eqHdddmcEYzFB6MWi+8rt4/9iHKxHhBX01E2r+O?=
 =?us-ascii?Q?x8/Ie6FLHFu8WQ+UKk58K11DjksMJpkF5fcgb+yCBQWnHZ8Ab4TOwyVGLFaE?=
 =?us-ascii?Q?vrTvmq4IonjpU9f1n2nfPwiMMh2AxnPGd3A+cFz5m1/MZbXhz3lMUp917/KW?=
 =?us-ascii?Q?Hg63wH/kEbmd0qjEd6hR+MLLLeLStPWofma/6qqZU3Op1cqB9/nbg17sH8Mh?=
 =?us-ascii?Q?QraYQStyf8C0xl8bu4XDUdgZZoL0FF+xXUZyqafALJrxpwNx49UokQ4dwTkg?=
 =?us-ascii?Q?6utycDA0haVPCw5D4RbS+MEcxctt2eRXFJJzhWy1hdLuiSbmQXS26b5w5qJF?=
 =?us-ascii?Q?LAlXMKF56t/hr32LcbPXSzrID3DhvlBLnaUH1HLGp7D2EZh5a+Fjg7DGlzCI?=
 =?us-ascii?Q?1984fCuVNaf2z5DFNB1Iw9NA1jmdlRh/8bHlxtW4+JbyWJiTqHbnELZWR5RW?=
 =?us-ascii?Q?Eopq4zN8SRANBdtRV/lwaiSpnGLTMjaAZRceRSUsXuMiytJQZ2HdCrsGkTjT?=
 =?us-ascii?Q?PLaNtPewtMDP4sZQC1HCu6cEsqj5WIHFrKkZkG1CBSr0/acZnBaRbvNz2gWU?=
 =?us-ascii?Q?aXCaCAA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qoRdwQvAAwxWROd2ZNPZjd9x/LGip6MB62GZzKpl4KrqP7HdWExX3jJOXLF3?=
 =?us-ascii?Q?36rKGfsiPBY2pp+FkwZYKBJo+FOX3ydeaDD/8g+t7HS4LKhUd6L90GvzFdsg?=
 =?us-ascii?Q?ANSp/KIHGIp+5iFYspCbR8tFC382GZ5n3/eIMRIKo5rgBNig0/PLIFTAchhF?=
 =?us-ascii?Q?fqZus7hNM3TRevx2ixLDU1Xo5yuxyOPy2skGnqFTJRxCbEDb/3Htoenwa78O?=
 =?us-ascii?Q?QhJZTTk0k1H6akKpcyaD1wvXRhmBiw/GJuRqO9Qi8XoqZY3Y+uk3dUhXWwaZ?=
 =?us-ascii?Q?1sEZKHeg5PSjahTcOrXysUHlD2n0/BpHO9pRAnM3f003cMi8+YhVrB9oJbWN?=
 =?us-ascii?Q?n2sBory8wGN/CugVCHUsPFllQSrfeZ8lYWS7cqwMEPKouy2KoF684PAjxGfQ?=
 =?us-ascii?Q?dSgyIlWE91WukEhlC+O5jlt4Ae6ECgS08E8+L18uv+daub9cjoMNdn+sQiGy?=
 =?us-ascii?Q?vbQpJzXsG+PxntrBNiU//fvukmrhyl/nHBSrjNIBcJsop4q4XfQT0BolFqdm?=
 =?us-ascii?Q?1mo3uKtqdzmcIJkHCvv/ajZCCkDaa6P05BFiQKvCqLlfjrpMMviauWe07ZzC?=
 =?us-ascii?Q?Ys7mROLOBUX+jWWLUo2Y0WyPwFo1O4+HHAXQs8i/Oqf0IvCX1kR3B0Au3FZB?=
 =?us-ascii?Q?iulaunxlgpJGQA000u/Lt5QMpzL7hQATk55WSXu/53GqaaVPCeZQm796bt2m?=
 =?us-ascii?Q?6008dlbW665uD9a2SPrLohP1DyZojrCap4WTdXiNiLzybCOdHBamKTnnVczD?=
 =?us-ascii?Q?TrHJC7vKLnaeaZzUNNnbx0UDfCEHyqlSwk+6vvsvm6yEqVhod5JabQOH/ckt?=
 =?us-ascii?Q?PSBFWQcMO6V4miJDZb5ooJLQip2+SypY/RjytS843gtCTHVGg+h+5/9UFH+H?=
 =?us-ascii?Q?28rm6ZvRlwM/JwK16rr9nDH29nn6k1otTv8u406RFgjI7eNU8fNtNk+Q9C2O?=
 =?us-ascii?Q?bHqGpRuYb8ysb0UONyicjcK8Yp2d7SsPme1n7hKtnv+CDsUiziu0EkcyZXJu?=
 =?us-ascii?Q?Et+c7FFQCF6qVgE+p1WeqU8ARWwt6lHdoKznaWSRwmrw5iWAnyVNllU1dy7Y?=
 =?us-ascii?Q?JL12YLPxPq8ZbgY5YoIFyS8dueE3YwTabwyjICyYdMBkrPlfElVjLH2w9yDY?=
 =?us-ascii?Q?4sW8fvyxsxAgflI1s13cJAJTziRIfH4iXMBi7x4G1tlynScSCK4vyMmfR/7U?=
 =?us-ascii?Q?Ob7J1Btt52bRbrY5QSdBOYNm0R4YLCdwcCBgLqE89W9V4JUIQWDETHfj0F4l?=
 =?us-ascii?Q?ah6khdH1scg7jfeB66pp5ApqUAUQ8X9kHAD8Q+kL1qHXFGauCOfVjP15Ltdz?=
 =?us-ascii?Q?mhmr189fJlEHum7uWOVyEreSDJVpwxsIYl/Yf+XifdgLvI49jnakoVZe/mJ8?=
 =?us-ascii?Q?XD7EwXju8eKpipTb/soh5kZ+lBGm19K+Wtpw26duxvXVma63gAiAJ3kmVZll?=
 =?us-ascii?Q?wePShvRP18+m57jqD6qKV+FhyDmoyklE7VoZCi3Xt3oX0OECuMpntTPhhyA8?=
 =?us-ascii?Q?nC5onZJu+nhaKsKcU64ntck4YHeHDJQ+wcEG4hZLcrIcFcKRzimzE8ISh2FG?=
 =?us-ascii?Q?wpTJWPhvB+kG1ZQ5gJnVisgnYbMBY/Pkbd3oOOG9mT8vpzvP2AY2+la3Zcef?=
 =?us-ascii?Q?S6kq/m8qD7Rbatpo7Tjd1fo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ef78bc-9756-40d8-2882-08ddb85bb0b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:56:50.3723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZ8u1tKu91ePPLS5nDlWOEOWBk1No0sDanRIsd5Ml8SPqz+1N/Lrbn77uGsbzABcOHPdPfQ5FRV1mf7oWPZ25ymJNCOcV3w3MfK5ORU91d28ak+Z+bgy+34r+1cssmot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5850
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

All the source code of secure_vab.c and secure_vab.h are from Intel
and Altera. Updating the license to use either GPL-2.0 or
BSD-3-Clause because this copy of code may be used for open source
and internal project.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/include/mach/secure_vab.h | 4 ++--
 arch/arm/mach-socfpga/secure_vab.c              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/secure_vab.h b/arch/arm/mach-socfpga/include/mach/secure_vab.h
index 42588588e87..1be0cb61e7a 100644
--- a/arch/arm/mach-socfpga/include/mach/secure_vab.h
+++ b/arch/arm/mach-socfpga/include/mach/secure_vab.h
@@ -1,7 +1,7 @@
-/* SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
  *
  * Copyright (C) 2020 Intel Corporation <www.intel.com>
- *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #ifndef	_SECURE_VAB_H_
diff --git a/arch/arm/mach-socfpga/secure_vab.c b/arch/arm/mach-socfpga/secure_vab.c
index 9bad2873a49..d5ff47a142c 100644
--- a/arch/arm/mach-socfpga/secure_vab.c
+++ b/arch/arm/mach-socfpga/secure_vab.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2020 Intel Corporation <www.intel.com>
  * Copyright (C) 2025 Altera Corporation <www.altera.com>
-- 
2.35.3

