Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365A0E8782A
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2A8F841B8;
	Tue,  3 Feb 2026 14:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="RMFyYKzG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A67483FFF; Tue,  3 Feb 2026 08:57:10 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3322083FF9
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVbpO5FqmUlJpR3foaL3Mg34JziJYnRmn6waJgVET2O3ZMVa9F7TOhF3yZRVqjxilB+jNbX6phnXjjvYmaFhNPwj1A1VrRXHj1BJz5Jbl5Aja/i/cInsAON6mL/NWNXv/cWP3TUlp/mANpxMD3PEel3L7oDmBMUqgz0zm8CYNnpXlL/UEgS+rRH/ZMyIa1VQCIHmGP9QVtqdkQMhgU9d6fFc0hSGSGlEWPb0bcShLhkSqaXyl+4wf1CQ0viHN7mz2q8G7zAdrfqnxHulblFOTwV7bBEw2oCO8jWGm3mBxioyLZK4+3idA55y5n7CjeqwzYiaenKRFE75oY5Zn66zrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cX3ltezkPSFzZbZAHMkaQaCIP4eYmISAsJ5BB56PAqg=;
 b=hcDUMNaIpd/zJKyCWPeLdnFsdki3h2hkR0dBSiFMyPfvGwBSnKdZgCtGl6dbUm/H8NYCgcBrrHp5gR5F15UYZIOxcXbqBodBD9IWv/fHteFgY0OeqmMf3IIjclLgobxXxtFYPb4S/eaE2DyNL/YLQzPcqANjPAk6pB2Nmmj3SmsBhzW8I4oWxMUz9zI6sIsgXdqazjr2/2EwUKZvncerr+iyBrFPMdNgLzPK2u6UIuLC/ZJmMEAW5P012qw7vVjdtB9/71g/gIke63v63smrbOe6Wo30qNPpEnUSVQkpOd4AVHagsXaCPPUFl1rRcQrSOlcHZdYD+E6uEttVjBnsmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX3ltezkPSFzZbZAHMkaQaCIP4eYmISAsJ5BB56PAqg=;
 b=RMFyYKzGfPEuCK8XB1QnmgSCDWcgGja5MQQYr1HEpaQflaFtJgHcQSNqtLqukGvD1PO0mn7tlsb7yUh89BfIiQHmvE2+ZMAWScukr31EyjI4Qi4Spk4TifNIOSBHUNYKAsOg+A25kK6aqBxBde/B5W9YWhspFdjb2vW4kdy+sLEV3kbhrmSnR5FYyl5QKFoPu3ml+/UlsT3KEYec21MrkpwwR7josOum0yHD1s2N+v41/AwDpYkNI5KehMfCV3PCP/wGqlMwjqv7bKKSMb3XGWmE++J3ac6ze3CvpXBGzSrZLG0geAvFO/IRpUYZLvddCYDs4qxcDVOWVmVgKG6ezQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by CH0PR03MB6098.namprd03.prod.outlook.com (2603:10b6:610:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:57:04 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:57:04 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] socfpga: agilex: fix NAND clock handling
Date: Tue,  3 Feb 2026 15:56:53 +0800
Message-ID: <20260203075653.4843-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|CH0PR03MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4df274-72ca-4b11-c47b-08de62f9d1ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rzmeY/9R+TVtwoTKctyoGXQLz1BvWD4LUEJcusAHPbcEtAHotgQaY+rpdFQ6?=
 =?us-ascii?Q?hfMPq6QNl2l28MxSsFSWBjQ8OeN2qyQu2xBUnyHP+rTfMej4280hBGF6SRKL?=
 =?us-ascii?Q?nxWkK7k/7cYjADm8bn6YCgrOJWfTQm1FaZDtlJxpbIwqB86eXC8PlTx2/Rnj?=
 =?us-ascii?Q?5TmvrF0JCJJYtUtCqRoq2Lv/4Ssy5Em+pgXliVCxyWaycl7UmcCIyC4nMmBe?=
 =?us-ascii?Q?r9DyTWQuYoHmU42EY29ksZ8Y+PL2HGB9Itj2WAPt4pMw2sklpmM0fjB8tYH0?=
 =?us-ascii?Q?X076Hf9vMZh1Kz54hx1fA8JkfToNbkso1aAsgkLAlSLwIUgjo4EFCShUz78J?=
 =?us-ascii?Q?DWdGewnedtX9LxZq9cF3v9dzZeV36kimDSGO3hUMMDyyr+L5qUVMbrVDvXeW?=
 =?us-ascii?Q?osbxMLkwtZwkSuliS3/Zt+y/WWo7krSXuwK8vRJdmiuUDcRwA+96FZEzDPTn?=
 =?us-ascii?Q?MXTxtvOlCcKcbyJhCnrC1184VG4kUmU+c1OTXa5cDWskJYnn8itWercCNwt1?=
 =?us-ascii?Q?6BqjHTSBsUNkrJO+VJtC6Wj/baXJzLXe8swEq7eICiRAdzxg3CrPZcISFYd0?=
 =?us-ascii?Q?uPdFw8yKLu8Jfy+RqZIo7Ffyu9CJ1rOUnneUd0xEKQ5ABt0q85fWirR85efW?=
 =?us-ascii?Q?bdzffGMEey8XFe2a1GhATvr0DAMBPWiYiROtglNCtUhL8nEyTKpxnsx1Jgb0?=
 =?us-ascii?Q?J/vS+/Z98ZRQLUWaXWwaiTQizyNC13XP2/TGwc1yF0VxyP4s4xS5KRz0H4BF?=
 =?us-ascii?Q?uzD1YPUD3ODklIkMoE+HQDwtjN6Mk2mG4A6izpNz5LTUgRHGVissAJGpI0+l?=
 =?us-ascii?Q?OPYgtCpbrl0s/uBrwtSq6FuzbGDSTsKiNuBpDUPqK/zBqOSzLQgZU1/WUEiS?=
 =?us-ascii?Q?ajIWhZxK++r742u9Q4lBl8uAAJ8kue8Vt9LfAARfMa420H8F9J0QKgCYoEBW?=
 =?us-ascii?Q?da1fqf+sxBVKEq/ZsliMoA9WqF683Ve4vpR0SxkraEjkZ6IH/2+K3rqsNvz/?=
 =?us-ascii?Q?PdG8HQxDhrm+Ot+2XNGGCLIr2cZDT2kAE9+dzn/SDgTTlBB5zMdSpTOGlDpa?=
 =?us-ascii?Q?ZFeHErmVCWK8KBnoqS0lrXXodlJKeqxKlyX9F6b753eIvXZ4Lc/QlHA8roQT?=
 =?us-ascii?Q?+MEpiMKI9i7gvVvIfmHkJVtc4OA7/sokxr166ZRCEntAnl/Xk1E/o/M+4YCx?=
 =?us-ascii?Q?1SPGc7mVxH+U0f42yXELmZLKT3I9FxP5RSWUgTQlwsj9SAnG17QOolaRFawP?=
 =?us-ascii?Q?X9Q744AnvS3CyYbkwr2u+/2w53YIgZo8+ied0ZHsfTw6nyLZAaIP4MUDmGvm?=
 =?us-ascii?Q?v0Llbe5pkLU/THQPS5/YY0xXpZFdgULfaf57iKdDfCz/YiImw/W7eJ+f18/L?=
 =?us-ascii?Q?avNZKBD+OET0YY3l43/sD+ytmY3K8t8RrNmPbh7A9YB3FVlkNSxZKi7yXnLt?=
 =?us-ascii?Q?XIYTQ8ABYUOBalAj6T24G2zmL8Y82foAAqDdT2o/Wv0ZIakM5lxLI+YWRUAr?=
 =?us-ascii?Q?wXNOJyx49dfYBrea5uj+4r/pvTZEoNHYZ/mqi0SviWVBMe2xfHtt28VQdmcf?=
 =?us-ascii?Q?GtS6I/CHuiP55W8LJ9o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Fw9jtgyZ9qlkfzK7YU7pTVYF9blbflEY6Fcx911MjBVEvu6fAY25LRVdJQ9?=
 =?us-ascii?Q?N4fizD3nKRl2nhl6lXzNRJ4Sw1sDGcFXijiNoDtAbRZ2AvKoAJ6xram5AHTX?=
 =?us-ascii?Q?KrEzFWJ2iKsE3W3EB+VA/gxADkOpOf3vhVF7oPBDh41YI1iK3yHkVDBLreAZ?=
 =?us-ascii?Q?T3lqkP8MuDptg6YzEhozW00VnVfuOlP7W3rGNqz+DFao5hg24DsJsm6dFo9g?=
 =?us-ascii?Q?Zya5WRECK8uhnro8pPRqFn0bidpOOxI+tPRglVfTHNnMapw2xFz5HVCbUK4o?=
 =?us-ascii?Q?xYVqoBLI+Ize8wgCWnsp5VJNff2kMkllLOj3xMxxU0Cx5tCvH9TtJ4YFnIpG?=
 =?us-ascii?Q?0vgLNrlSBeu1dfiN4ldue0grjEK+raRji4NXh8hm3aJKaGeSNyALfL7ZlfXF?=
 =?us-ascii?Q?4q4Vk/ApzDLBaGz7GKUCIOJzbCx2oAWgBoF4fk4WtAMAyvZvFjn4JVyruGqi?=
 =?us-ascii?Q?KsCNiV33u60DLW7T0NDWjSv1MvXdLX3jhYqNxy/JYPchYvfmp2jsIgEf61GP?=
 =?us-ascii?Q?HnsmDgbMFqGDPqBqhMCS+P9yUNHoYUUzCvE/wr+lEmjcwUZSYqb1GiPwzlFt?=
 =?us-ascii?Q?pImHf8EbXVDVNGlmKn4rwMdAmQCzXKoWpl8FZ+wB+r1P9+oyqGCg+rsPz54T?=
 =?us-ascii?Q?HVs59Z4yjQgBplsEz0+liTGfCNdIJL1iskwYkx7xdheh3wmhjs1w9pUVmCZF?=
 =?us-ascii?Q?nCvzGEmIisyN6H8N4FwAmKlATeEvefwPS3scLdl+K5OvtazMFn2hj58Ewqd7?=
 =?us-ascii?Q?gmMSnsU9ac+qa5i0AvKbUACtfFjZFQtU2KSURnLbKWS2YSYalOss/OiAx22O?=
 =?us-ascii?Q?2E7jB8XZaO246vyrYA3XuqeJ9otOfCXxnj2N1O1SVCzCA6FPpu3VTNdlzivG?=
 =?us-ascii?Q?F7hI9uOnzor0Ywuk9Exmgjk24ZaM/J0U2Or8WvrXGP1XAOUrwyiVl/Ukzyue?=
 =?us-ascii?Q?3Ltw7GDmf/1y2p83922gqq5I6KLmF9NS64wmRGAdDSdmgrkEOgxP5c2IAsos?=
 =?us-ascii?Q?kC6x2utyw2kDzXaBE6UXK5LHYgZbpkfHitIYFzhNZwajPpd19+OgJb6Lmzd3?=
 =?us-ascii?Q?hIIVcmFNGc+xr3KrA3Mznk2ToIgOmgZLwW3xe3xdjbZ21QUOpmC4IU4Rq3W8?=
 =?us-ascii?Q?ZVXka9dqw+e50VfF0gEz2pzvZ5/PHBG39ckLmgx5qpUFyGNqADVdEDq+czug?=
 =?us-ascii?Q?MEObnKFWgVLaVgtiXA2I3AQvYcB/Tsbrq9v1lMnIth6o06zrMn88jbLkKugQ?=
 =?us-ascii?Q?UITuvInOddfjOGaelj/h821Wv14EmJHJIzkIN1ok1tjHMGWStokzguwyiK1h?=
 =?us-ascii?Q?xPJ0egqGW0FEWuuUM9BbSFNw3FWCZ76CyrKdiWk4v+N/X5QpRfGaHPDrin1/?=
 =?us-ascii?Q?i/mFEF+jB+e86JfAAlJC0ZAli3GhB7K02tWFwcJg8cOk0d8GDrXt3U3lDrao?=
 =?us-ascii?Q?C1a4PVl4mWLw18Fcca5t7ix4TS3gQiTvqgirT02RdFgLE9yFx5PxRuLq13AS?=
 =?us-ascii?Q?M1T+0vsI+/kLMS4lmgzfFSnq8dYdO0O/uBqhCyQ2lfuUOCNlVhzQ0rG/wu05?=
 =?us-ascii?Q?gGX+IJ6rh50Fyyt86u69jn+BPUyFzYwJWj//p6GR7oqhAKvNvng3ecG3B62j?=
 =?us-ascii?Q?F24ewQC72dr2k8n23OOATA7gUiy3dFcfSsndwRG3bEsJjikJBY1zkK2PVl1v?=
 =?us-ascii?Q?21yg53j/xlgwdfKBOYwjG8O7L+0fuH0pO9v3UlNKpIbVtPFNRsfAm2cBZgGL?=
 =?us-ascii?Q?gIFv1Iq4HBp8gy3NvaZeTuGWJuti5+w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4df274-72ca-4b11-c47b-08de62f9d1ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:57:04.3042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uemaqf5prFiWixD125XpKVmihhKO7ZrVw13MV15LMiiBA4bKsGizmvz58X4rw8V0X4Am+SRM8N2+xp8839iVWImLcss6Nv6b2wKsrOUbstk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6098
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

In v2025.10, the Agilex clock driver was updated to support
clk_enable() and clk_disable() using clock-ID based bitmasks.
However, only AGILEX_NAND_CLK was implemented, while the NAND DT
node still referenced both nand and nand_x clocks.

Since AGILEX_NAND_X_CLK is not defined in the clock driver or the
clock-ID specification, clk_enable() failed during NAND probe.
As a result, the Denali NAND controller never completed
initialization.

Fix this by mapping the NAND X clock to the existing l4_mp clock
bitmask, aligning the DT expectations with the clock driver and
restoring proper NAND controller initialization.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/clk/altera/clk-agilex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index fdbf834bb2f..f1e2fded7d4 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -657,6 +657,7 @@ static int bitmask_from_clk_id(struct clk *clk)
 		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK;
 		break;
 	case AGILEX_L4_MP_CLK:
+	case AGILEX_NAND_X_CLK:
 		plat->pllgrp = CLKMGR_MAINPLL_EN;
 		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK;
 		break;
-- 
2.19.0

