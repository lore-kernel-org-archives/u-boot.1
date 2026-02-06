Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03DCEE209D
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 12:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3082783BC8;
	Fri,  6 Feb 2026 13:53:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vfASkW6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B00C83A64; Fri,  6 Feb 2026 09:19:25 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 814D6836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 09:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYPOq/je7dpaG6RsLyTRP2//aiOdXP9RSmFVduMDv6o657Zi1GxvCUTcBQukKNkpcCk2kMeVGxJAAs8ydEj/SsNOECzSVmNG+5iRAwO95vKobW/BYiUOLlZ4yjCyV6fr7NpwUJn4BlavmQ9i4E7VRYextjMhZyCIutoyx2Td0W6LmikNI4NFNZ0fXsUvyzdIMI373bSUxBLOlFIrjDCuRmq6USy/7cI69LyB9kAXGaPMKiBm2iYTOd9gBFAlIDQV60R6av62QG/rKMnoB+xDfle8jKs0/mizNiDAmZ2uOpeDjwcbYoE6EiBPb4bsZxhecBYeq5o+6tpBbrkkXrxx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn2dfroZ0prwsBBfUCFDAPMalSqDzElC/MgFCxyBCnM=;
 b=zUO+luxX53CMi/x/hhCVaQMHPn38bE8AM76PS3lCk2b3Gj3ARr9iJQY6DMT6Y0qU2jbnNdWDfy4dAo/OGURQXwaS7zFnCwjpVxAy5WDjt4W0Ws4kXN0R5xlY6ZF+7cQMOFimz2Jnv41L0XZ8nvxQwgpSrfoLd5y20Z/AlQqq65iGI1H3D3eRJRthyMcUWJKEQaIBt6BEP5UhIg7IwvWVKMpV8UhZ+O1X3RkmYw7PkpzwAvP0/TqbYf51S6MS9QZ67b261pf5ZP+nJCDfR6EkfhyLlZkkqvWsaAxCKdnsBPOOHv9CpbV848w+TpnQayqPn42Qr8cP5vRgWiYj2TXTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn2dfroZ0prwsBBfUCFDAPMalSqDzElC/MgFCxyBCnM=;
 b=vfASkW6GjPaoLz/Kvl1MDP1dzmaLmRNXVTni/G31YzxqbZjcZnxYJyyburniu6hZLjxW64eaLb2al+djtqpMVKI/rRO577Hh6Jk0ZHQ5m223S0ie5IsL/s6D+8Z8NIRWDVtD1zAwo/Mz6zX3pInmlnhX7bn8NCLdh3yZJx4x3oLTiYT0I/pcqkOKkn9GX6e+TpZK1QmItqYP5wZgOSvNJrVOW3XPqRJacqZMhQDxgB+SgeKu1y2OgQAFBOLGA5X/5oDIXNUR5zKsZ1TzsubUmxrPgfZZ4G8m0B7tzAtu/RSwVKuLoADWWDlOKRlMby7569+ZGbsKbygIvifMOBDDjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by DS7PR03MB5445.namprd03.prod.outlook.com (2603:10b6:5:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 08:19:21 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 08:19:20 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Alexander Dahl <ada@thorsis.com>, drosdi <danish.ahmad.rosdi@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH v2] drivers: fpga: Use SOC64 conditional instead of
 Agilex/Stratix10
Date: Fri,  6 Feb 2026 16:19:04 +0800
Message-ID: <20260206081904.12390-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|DS7PR03MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: 84300838-078a-4afc-c63c-08de65586d7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1Tf66plJD6BlSvpa8zIbYJC1mhaotKrHdXwIDSUInV8/SccPlNj0xLjSs7zE?=
 =?us-ascii?Q?8J0qdQGEs4Mgh6iEQg7K6AvkMQIwu3SYjP7Bn24ipO4bEtRXb3alPhFQb0zf?=
 =?us-ascii?Q?bklyJIsiWKC1miu6191siw93Z8aTYVT1AntsqO+dL2xj/HfNt6xP/3JF/6jA?=
 =?us-ascii?Q?6BSb2BBkc8H2c+vFH/cxngG0SZnXBAZrNZ6CRbUXscVWB6prIDBNroq9lkRJ?=
 =?us-ascii?Q?Wf0F/RhGzHb5pSV+dFwFu18QPyNZHi4VR7C665yd+8lZRbgzX9tFJ5O5aXOK?=
 =?us-ascii?Q?eTYjM4mfQ6OgaRGY3yTOiqU9eWjxtuKEPYBJrgNa0kunrntDpgQeehQEV4lz?=
 =?us-ascii?Q?deiLuqcxL5WRHioL1zcP185m4QdUO6dWlVHW9wEPLsv2MtrGGDTcv17TTvVt?=
 =?us-ascii?Q?viMGu/DU8qJwxKCfzBlhuOCzaZ4UrtA5+SDIFsOMQZj9EimQULCr6IesgP6M?=
 =?us-ascii?Q?CucCs9cIEVIA63NTz9gZllqFRaFnwsiV6V2ZPddY96HIy+WbELpKSC4qSXIm?=
 =?us-ascii?Q?pJSaGzdBd1BtX2hFBMXw5uOQSnoTNAGFH7nEzoNae5e+/DZDGufyNyJAwRYj?=
 =?us-ascii?Q?9mVIMy8VQRiFonsoFMtEdCJWkq0v4rZR4CsTqnlIFuWxX4iDIQs6c8BRzZPy?=
 =?us-ascii?Q?nKbThWYACkAduXbcbLYHKXYN3nvjJG82bWAz6/gGm9h54PHj6HNiVkhvs+ad?=
 =?us-ascii?Q?5v6X2IP+GWCcZaY0Ni5xfhFenJT1uF5NVsA8mqVZIF7RuEGATqTj0PCVg3SP?=
 =?us-ascii?Q?URd2WFDHkr7xEiG7EIwY7ejS0ohln+yT+8S1u2WRsq14vc7V1WdwSkKhjnFP?=
 =?us-ascii?Q?3mMT857suKUf66JHQOOR2I5nyNTfrbEnfjaFRM+6bkXtHwgDEIbMdx1DlJDJ?=
 =?us-ascii?Q?zzkJMhpX3YBlxGdAGTv1O/k+fo5FH6gsXuIs1Ijb6dO9e/xqGtZSiCdATLtm?=
 =?us-ascii?Q?GUBL1IXilyvp0dXf35PPBmGCBKUl4pg4hGIVoIAu4kSL0pCR46z+0/LPz1v2?=
 =?us-ascii?Q?7b2sQED72ZcitRfdLGoKW1ngN2wvU/GHEwTFSuG/RohPDkYdupoXKSpnVmYV?=
 =?us-ascii?Q?YiTN4mTsFrO+3aQcRjMgg/i/qUuMUR50ta9cZlKpMkcGsndXn4DnmHCwKBPe?=
 =?us-ascii?Q?bypp32y0DLJ+DHHSqOvB2ReBTW19uajAuJXtitBRhlFnrO7hLY3bcD9jdF8p?=
 =?us-ascii?Q?SolnrxSYouSZ/XGsWHtZZt/MXhtU8DlvlD9PE3wMpeAL3N2d61htZVFC4Jd2?=
 =?us-ascii?Q?c9taxclNxLliNlxsA2cgF3oVmdEjJCGa3dJcknVymhcm8BgJUSp4ee44cfX3?=
 =?us-ascii?Q?MwLAlPfI+qxZZL5nqolZ3jMg+UM8RKJAz8ufDbGf+j2/ZQ+DsFfqEB+NEobi?=
 =?us-ascii?Q?UOC77/M7r9I3MMXHNvLbhsR4nm6yA7z3HSHVMlfC7yjWiLKirqcnnSITNRgi?=
 =?us-ascii?Q?wzjGoLsbA5lxzMX9E2KO0AC2SuqNlI2LYN48/dQdoKFrKL1/i3c3QWAUxqKx?=
 =?us-ascii?Q?Hrd4CM0DTrvvCAmaobaOLPOYuFPvOLyMXQRgQygoZR67KmHeJ7kQXfCXq9mv?=
 =?us-ascii?Q?V09Eu8/NLvvRQBMfng4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wtG83/gzzIgL2zo4isRFBH3icm4mFCXVSv28aw90mI/gJqHExC0lETu3lNea?=
 =?us-ascii?Q?oTIZFX+gZHn4dVbZthBDT4EF2gPts5TKoc9qIXJ5vXRnsnE4DwhORyPDnLqF?=
 =?us-ascii?Q?OqA2K2UzggMZKB/PzZMOUCz8Ze6YjngET/AixIAeGymv7b3cThkLRvzPKusd?=
 =?us-ascii?Q?2K0GFR3KyyMDHdKNSoW/6s6iSTKDAtV1EYg1LvCK/KXnvBitZQbaoEdrI59n?=
 =?us-ascii?Q?ihg7CamThT7Cl+yxoduQP8LJ8vUOOPIyPyDV3i1XPonsFdWt56D47IqvRt+N?=
 =?us-ascii?Q?NNmG5MU0mHUHGUC16fAIjMmc9fb2VZU6NKfFReAhnqxLbS12pPnpEKe2xBKq?=
 =?us-ascii?Q?HNiXB6u3LgwC5kT6N2pw669/D9ZHZSUke7W/4KC4b0qcQuX6jhawyzlEX1sc?=
 =?us-ascii?Q?N6pgc90Z9eFVktXB0dpPsJ6b3i0LpqHy2s/1NIp0mxRxZr8ubisWxZS3AeWS?=
 =?us-ascii?Q?C0KHmHOj3ZqI1NuRfIHAPlwQzNV0Bpr63XPHDrBypjakDoyBND6tTAL7/b/h?=
 =?us-ascii?Q?MBIoYc6Sm7XfqcFf/92o3AOg3pawVNo75bCenb2hVkKHVBrgif8yBB9rkOL3?=
 =?us-ascii?Q?93sJt6aIDjfVcepMEypXvjwENfVrG3sslGstGFnSOJV+QH5f6E7uDz/H4tyT?=
 =?us-ascii?Q?lzgSw4GJGhvP2ei31Den1WXm89aTM8FfroU76kwe4VJ+Uofb8AisoWABi4QZ?=
 =?us-ascii?Q?ATFBatZP3dIq9Y13tXSU1iZoAa+TTLmPwIJ0oR5fA3QVCoJd7OYUbo5DHqi4?=
 =?us-ascii?Q?wGcQgCTjGF/I+BmY8UATXlFpK+thDmE09nUwrADQWfK1RoysZadXsf8jwSvd?=
 =?us-ascii?Q?VBb+xvnUUIaeiPnLmXwaoIBKKU2sMk08bIA83shu/7E3wwOJk0/CpHvuauR/?=
 =?us-ascii?Q?vBc8ziVeYMcCatfJFbxjYC/qB/ImtsBrBPKdEBg2M/MII21osx98m/7Y+vs7?=
 =?us-ascii?Q?+gVSkfaRjvTESjbexviCI/PE0Gf0Sccsep13GCtuG1YAUdBZHXqFN64p+G+Z?=
 =?us-ascii?Q?AbS4IePuGb/CJtwK0hp3IwCXtNthl9czoJcjjWhL8JhzCPza41T9LCN/tMdY?=
 =?us-ascii?Q?LPJTO4Tyo2kjGSMBF687ksYfUTRSZTd0DUVIcHGHwD3wnjHR5BcQmQBz44ye?=
 =?us-ascii?Q?syMXk3a8SCRni90OGREybabyF72QXNcHvQdE6dzBqBJKh7hs27Loml3D6CGq?=
 =?us-ascii?Q?fKtKmolHQph72qlNJfd2cBy3iRau9dyuP57yanl2tyMTkqKywEnFFJUyZaIB?=
 =?us-ascii?Q?XkiO5QhSsJq8hSA6hVb87uHDQ5ouZ3NylH4S+Oza6yMI/vYnA+GmmC2WckTg?=
 =?us-ascii?Q?VZIr3cJJalGX1xxXsQTRe8sJIN8EqMNHTBSSRdzTwSx7XnVw3KUrKJ266l92?=
 =?us-ascii?Q?BOGxnFRtTC3ibhpQrtOmymZynYckJctly5Kp9IeQ958lhmMah3yYMUEJHG87?=
 =?us-ascii?Q?/1U18xDcSZJVfCupuuKcGQSkAZA4cJBVVjs5sR4unEVBPNRKHbFGFjU/HUdo?=
 =?us-ascii?Q?8thrtkkMw3L/oGR4Bnj7MJq+iFuMLsAE7M2rR36VlBU6WC5O6uU6GTT+XQCi?=
 =?us-ascii?Q?Lu3H5KXp6E4WB4wue7JCY5GD2/wKZJhVVSS9G8HnWIzLWZVpIoUVAb8Bs7NM?=
 =?us-ascii?Q?DnYHNbLWSfkVZafKDfCPAI+CSJZpmpHlTbcMN2D7t2IwKdIW+2uN8MzyRVIi?=
 =?us-ascii?Q?kKHCjM/2dafknGAxo5AkG5uXSEAHDPP8UP7Z/fMoHjcNUNyk6I6BsKjiqQ++?=
 =?us-ascii?Q?tIv0BitxQA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84300838-078a-4afc-c63c-08de65586d7f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:19:20.5826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XREl2jKEBvEJM3mhZZYJRqA0R9e2FIbqY68P8l7qz0ok9zlN8Pce+arhXfs4fT5en+eylUXkUVCOZf4tU9ACNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5445
X-Mailman-Approved-At: Fri, 06 Feb 2026 13:53:15 +0100
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

From: drosdi <danish.ahmad.rosdi@altera.com>

Replace the conditional compilation checks for
CONFIG_TARGET_SOCFPGA_AGILEX and CONFIG_TARGET_SOCFPGA_STRATIX10
with a CONFIG_TARGET_SOCFPGA_SOC64 check.

The affected code is common to all SOC64-based platforms, not just
Stratix10 and Agilex. Newer devices such as Agilex7M and Agilex5 also
fall under SOC64 and require the same handling.

Signed-off-by: drosdi <danish.ahmad.rosdi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/fpga/altera.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 4a9aa74357e..246df72cb89 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -12,8 +12,7 @@
 /*
  *  Altera FPGA support
  */
-#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
 #include <asm/arch/misc.h>
 #endif
 #include <errno.h>
@@ -48,8 +47,7 @@ static const struct altera_fpga {
 #endif
 };
 
-#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) || \
-	IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_SOC64)
 int fpga_is_partial_data(int devnum, size_t img_len)
 {
 	/*
-- 
2.19.0

