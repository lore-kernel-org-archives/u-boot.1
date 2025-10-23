Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AACCCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 05:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58EE0807C0;
	Thu, 23 Oct 2025 07:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OgpxXB63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB639832BC; Thu, 23 Oct 2025 07:00:31 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 736DE80422
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 07:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VX5eyp2P/wkFUxsWRYCXif4QLYNWkP8masfY7tUbodXzMCRtHv7zGD7f7gYe2u11lPBs9wrPYv5RPlV9xHWI11e7heu79dinhrlSyUtUk+cIhpqf5HvWkczlk0kHpmEharlkkpJrYZad5CMWjg4dzR6QaOmtdTAfrKot9pGR3TDl5MrxTyIbWWVs7OGUatA6YPTM8MQaj2tjVCtWsAdYskQ8gB1XUe69DC/CD71Rm90O1Gh1F5mcPHjcH+ua2xNxBqVXLfeh8Kyhzt6XGsGdoO4m2YFdyLk2lIj2og8P+FFsQN1uwj2MHly30RE8w/PiXS9npU0psuCNYoO6OMHiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0EKurigUhjD2L+UANSC8libvNT6dY1fARK1mcnswbk=;
 b=WKCBkm6bnbZLhl/0H/8ifKU37geZwnP83+eaZjpJgBWE/tVHVC5nwaxzDg0zBHFJP1yji1o06sImicOMnqAABUlZ6ooS6UVkNr8ag0Urfl/XefuLYUvd+Dw2wNvzAAtSkdJyCBoDrlgaTkad9wZGOBVBLd66dX2qYQBYqjE+RWWPmU7ASDKxZDjH5PD/Xt5SjPcdsdJRQK2mNhFlH2fkcYfNb4pv1XGH8U19ltULAUvU/w3VXMukCtqb3eAMcUM4G/TPc9uHS6y0n4p4+A3h6U4+hwsoIcTA9Lr+rCT3zDw0oDnhgZet3CSco6xNBaNuW1yGkLzbnteUA7RvKW/qvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0EKurigUhjD2L+UANSC8libvNT6dY1fARK1mcnswbk=;
 b=OgpxXB63nKMJ/fOHs2DJa0SCEeF5Bx5ydjsDMBt1TPgr07htmaX36yqVBhbKmbVUNtJdnOKcBiVCZi/cgUM6PZZ+x/v9qXdrzYK7kfHmvLJIYdTqzql+LtJGY3B8ugh9RPa7+2ULJMHXCc7kqBI2BgczKjr3DfrVbCOrsTne6YgW40XETlyK+QeMg1pr8SyBYmpCScwFXEJYccmSqemSjdULykmYmTdmE/IZVbQsMUFvZp7Fj2i9kJZioOLH0GREJnzUyeKsXAXGj0ra0RwHX1Gscv+UP/+Ex9t8MtWKYRQ62BLgXQB+rMUBRUx/m1caMjMfpzSB3J3twV3yrTZsWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB7079.namprd03.prod.outlook.com (2603:10b6:a03:4e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 05:00:27 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 05:00:27 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH] power: regulator: Remove duplicate include of
 regulator_common.h
Date: Wed, 22 Oct 2025 22:00:17 -0700
Message-ID: <20251023050017.4580-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: e6377b53-1d6a-427e-df9e-08de11f114fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vdMcXfA7Ved9oeTylAmjv/nh5tlytGO2hQVETuvHLrklBcLgjcpihgNKRU55?=
 =?us-ascii?Q?6YHB/bOSb5z1u6JQUQd3tOZgf8bN2bfpR49NZFasmytzSkBdzzHhaPc7g6Qu?=
 =?us-ascii?Q?FACEX9Bn/8jgoKjgiOjfCNixYwaCOF+SdXIAxtS4DvIpQIsoQQxInZ/UpPWi?=
 =?us-ascii?Q?qlHYAq11V9bnsA9Et+4oszN2iNAL+0/qfkbZ1Map60GMv16u/lagKJrZOD9z?=
 =?us-ascii?Q?fRT9TIIxOkHi9i6E5vhCTH3QAnqOKpqJKfdwTiDRC/0mjYXt2XE4BJKkgYe4?=
 =?us-ascii?Q?qqs8N9H57BgwtTJxiIe/bJbWjJAZs2fZxyfMJ+id2qZiyMIo5Z0M8cQIp1H0?=
 =?us-ascii?Q?3Sprk30zzK3vd8EhZizIla6x/NSQAN13Wf9RrKhzl3VDJ0mCuXKqu36tQmvY?=
 =?us-ascii?Q?nv9v4Gw1/SmBpYd4mVjmK4pnWSYi8f+b9M45ctk1E9hbKDKDQQ9I7N3YcPVu?=
 =?us-ascii?Q?BcXPo/ajxnY6s9K/KiXh7/5TDRPVjK/13N5NhZGgp0UUKmcC1C6gXywWCsBf?=
 =?us-ascii?Q?L/pU+Q9PVckTwXjK6S5nL21wmKslss4ezpDMLm6RuV+jPhrdmbPDbZ75N/pE?=
 =?us-ascii?Q?uVlCBQ35JH6nP0zRslbKNw5NlPJQc9bSyfC1ngPv+gQgJKuIG/oRBpFVUZRZ?=
 =?us-ascii?Q?m3Lr/QIl6HFkmJ8jgEOmRnZffHaaoGOMcmkKGeXlycCF6C9wArJ6UDNCNxZh?=
 =?us-ascii?Q?P9WYiUWOGciC9eg5Bh0G5m6KOk+k8BIOIioTPWXAUrZlbQtCm6ubmDApW5cO?=
 =?us-ascii?Q?PUQ5dQ1kNWE0Sepa3dAH2OvebWbsIirk2/Bqc1H5yYdGGtQQ0xSy8k+vVsCK?=
 =?us-ascii?Q?/zLUx0ys8nMAY1/JNieBs+Ua4UFEYPzMTG8q0CH7eJYDVELKZOBk65PRr738?=
 =?us-ascii?Q?60s6ZgHCbjC8kWOad5pZllmrsiegyjN/PUFOjnXddkHgJX8fvD8iiE+Gg4uF?=
 =?us-ascii?Q?9Mk+nG0LX9S8HQq3gFlHQotXyix2ByOEaqAea05URji98iBqgBJQ/R1JRWMs?=
 =?us-ascii?Q?t/LpsdSU+vKONvzgvhzQAg5XUNpGEQOtGyVtYHOWJcXsntZl6VgC2K48fs+3?=
 =?us-ascii?Q?cosxP/4Gq69lj+6ZtWxbDWBSFjwxosJrM2CN4Ex0TH2U8zPS9S9/LTanB3ze?=
 =?us-ascii?Q?UEYyV5rF3EbEEPnRwwi4FF5BISP1Y9PEfSYhEySW6PAwbftP9x3CBqOT3iFY?=
 =?us-ascii?Q?DiTMJ1/4Gp0LiEQ7FgJUwaijEsUX1jU5MjHR5DKiSYI6hexXP5zMAAKgxNJc?=
 =?us-ascii?Q?06PKUs/8hqZws9LxRAs8G6hOqKK3kayUhrJAEBeO/LEElIbWGjxhMBLi5jnE?=
 =?us-ascii?Q?/W//xlMSPLsnsfQnCKN6ovUkK3IKu7xANEtZKKxIDfEljSxW5XtI2JF+Vzzj?=
 =?us-ascii?Q?aRdu0vFmik+zd6mvfOp1EJCoX8iwR7ZUKtsj5Clg8S1FD56KJXOeohvXJ+8V?=
 =?us-ascii?Q?Ck7eG+HdEA8AqjZA4QDGDQ4YBnS5tQEV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fnVtGsKCoBe1gQIbWNGTolxq4WhnOP35H5ESud545nPid22hghNXy8rkI5y1?=
 =?us-ascii?Q?puduOCUKdcqiI4ECAS0Z/plhXlmk5KpF0hB4prQVwgb6WhPIdMl6dMyU1JXK?=
 =?us-ascii?Q?JoRUhH3TCZnFJwbuLtTIy1UeQNfTDbiC6Kpp7V23Zlm19SQ0gWPrstWTqWuA?=
 =?us-ascii?Q?nYW6zb0Rkua6wvl288lmffp7rac2ANJObcX1IKWnRUKij86/G6JEz0MfLF0W?=
 =?us-ascii?Q?qou/w7qztDYkxNREjfFMJ4mmszrSoaokmQoKmJXDJNvWxOHc0ynhuY6Gz/ep?=
 =?us-ascii?Q?BM42Ji5iSAjtb5ZRDKdIwalBo/JJuwD/m3AnJQyjOV+sBj4rfjwSBPot6j7Q?=
 =?us-ascii?Q?ZMsA9TIr1HXDKI3RugIft8eeu9rgU90FN1k/QNU2QpbpOxwPnuuWYgkCPkY/?=
 =?us-ascii?Q?N+WKp4284z09nHLKm5PNASvmaEGWnT0tebab8IA2a8i5iKrBxGf0DtwmanOn?=
 =?us-ascii?Q?9eK9qAm+93+7TILM/bJ4wNWjXF1jpnp2IKh675w2GPMBMs/X1uttkkHqhKTy?=
 =?us-ascii?Q?oMG2AxuEpL4Xydjd798+ZxeR9kYxjyHq99PZFD281Drm0E8b1JTMwA8/En49?=
 =?us-ascii?Q?DskDWYweY8QTzz1a4DdD9trchgGrJDO6jfOuK0pNgtb0oKPmh+zZn/80+xzJ?=
 =?us-ascii?Q?8ljBZZJzRwhvC+yNgVUlZ4QqiKesRRGgXrj5FdgtHiD6T0R2uxg+13hQs9O9?=
 =?us-ascii?Q?QlcZkjZE2n7kdFiQ+3gFwjhb4REYzCnFY7pwgS11Pi+MM8wuwqCd4g2IABvS?=
 =?us-ascii?Q?8nqsk1sjGW5jorA1wxC5eYdfr+qHQHI6nncpJ5qI98HIdxRQFr0F0nmE0zFK?=
 =?us-ascii?Q?eXCRsSOYxBXA9c69YwrC2WtoOCN4JCq9ar2/SugSGfOA7UBWg4WMt/LBRLG6?=
 =?us-ascii?Q?8kDfMzyCrPnv5WOTTPIKVpr6ms2b3OogPNE7yS2qi2ii/niExFR0DIfCdTv0?=
 =?us-ascii?Q?nz9aUHCoc/zUpRmEpO5x9h8r+jboUo0TYwlcIq/Pk5O4dgDe7raNVOp8aLNy?=
 =?us-ascii?Q?7MFTVQ4ZVgJmT+wv0/If8lxE4FS3WDTNxIxjgMC30JihrmESE221mHK/88h/?=
 =?us-ascii?Q?m0Ubrak6NhwwHtgaryR5bnZeyAdyL67IS6frKsStRtcbwdcFmcMecgSPwfcR?=
 =?us-ascii?Q?7slxQQYJGzaOz/2A6YKTp6AsNKW5VugNLdZk/RzuoYD1RLQ1VPuOKLBdaYcP?=
 =?us-ascii?Q?sUXA70d8bCbIjaeOtwRItVzq/WMrqHyrk/LbYWRIkG5C5HsbPN2h6YQHY5ef?=
 =?us-ascii?Q?z0v2rrA1AyyJjKOx0U41HtqwKzIv5gxRRwJ74rszg17EPa1tArJJx/CS9BpS?=
 =?us-ascii?Q?2mrfClLCUFBgpVDQOd1WKrQRSD24HDJzptInSXf699OSqQL5W3/WGbDz3UT5?=
 =?us-ascii?Q?FoLLy0dYAcxbqbT8wYLrcuoUl2q7NVPGxw9aUrjxz5jmuD/KKTy/SJ3ousOP?=
 =?us-ascii?Q?HiQzOJIAlrQq6+0OOYMw1vJA48AvJ4VgWIWxyJgfFZM8dcyNNKIPH5mmho1f?=
 =?us-ascii?Q?XoYucYOjHnfL3N2NDA+DIjPMcSq85JTKw8C01qqd2zlDwbFBP8b3X5JiJq0J?=
 =?us-ascii?Q?/cBFMlAsXnSovt9PBhpz/sa+fLCyvAk+IR+xZaSYpQ+0V9qabJi+g66gw2MK?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6377b53-1d6a-427e-df9e-08de11f114fe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 05:00:27.1299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9BYOWy+zuTlmmSnxcaa6sZ2teoUpMrVssaTVp8PU9tvnP+NYSJqEtDQJBEBZs8HLiFb4a3O2BPs3/FbDdkn7hdS/Q4MlXpiZIR/tGYMTBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7079
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

Remove duplicate #include "regulator_common.h" statements from regulator
driver files.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/power/regulator/fixed.c            | 1 -
 drivers/power/regulator/gpio-regulator.c   | 1 -
 drivers/power/regulator/regulator_common.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/power/regulator/fixed.c b/drivers/power/regulator/fixed.c
index 996da41546a..1dd137f493e 100644
--- a/drivers/power/regulator/fixed.c
+++ b/drivers/power/regulator/fixed.c
@@ -13,7 +13,6 @@
 #include <asm/gpio.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
-#include "regulator_common.h"
 
 #include "regulator_common.h"
 
diff --git a/drivers/power/regulator/gpio-regulator.c b/drivers/power/regulator/gpio-regulator.c
index 38b22535c3d..787f8170234 100644
--- a/drivers/power/regulator/gpio-regulator.c
+++ b/drivers/power/regulator/gpio-regulator.c
@@ -12,7 +12,6 @@
 #include <linux/printk.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
-#include "regulator_common.h"
 
 #include "regulator_common.h"
 
diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index c80f10c3aa3..3ed713ce501 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -9,7 +9,6 @@
 #include <asm/gpio.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
-#include "regulator_common.h"
 
 #include "regulator_common.h"
 
-- 
2.43.7

