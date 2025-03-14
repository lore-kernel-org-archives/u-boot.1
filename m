Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20E0C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 17:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC49281E6C;
	Fri, 14 Mar 2025 18:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oKMJONej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC09F81E92; Fri, 14 Mar 2025 18:42:39 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D7A801DE
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCUr1vEnfmGyAVqy94jrqJjUysu4UxTQVurSivLDrrnOy2u3NU/AaFePiVzKwfKhwGtNn1Ja+1bmTcsYkx2YbgPff5pbbAldd+0bzIpaBBtWcye8Lj+ybiJxIYmLi24NjXJcJfFWGF97NK07G4d1Rac8ZIMjwIaDvzjsJ3yTxLuUJh87tSqLznUsNnWRRiXg/lW2f9VpDjwDlg2AUjFi3IjsggJfeDg/ntZKrxmM4tZRS4fykM2FQ8Pz0YSQN1bjwHLZPE4pYUD13+np63D359gAi8WxUuZXQvEpHi36z4ytom5pLKPY6WVhgICdbDTPR3CTaULdzrsH5LPGGY9tUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr56owTFpds+npnbHCgixqQJcbFKcwCSEOfOi8JBvk0=;
 b=FYZTzEdO4ckVPPHFEqcFmdstIy48G2KH5aOGLEoobzFoj5q2PFFzqvReA9oV5ZzcTIpMu4mhjUqJKdpnKcL9wtdrNX3qq/gf0ES38Gd7VE0hm7y7Ax1/J1ZLq0OSn2uLhjCNta3O/lpPp4gnaneUk45kdL789wrV1JG7ENPOOi7k+3hWefUpcNjtGjNsqRFYA6hem/5DMVROUY1Z3Wj72BEoAQKnOP58RMdIoLcOC9COKcQOoTevzgZ47qku7nr+ln5ZaJsa/qRWawLKiUnpELf1sXECon23QiRvLLmjeEaoY4JXUjFcSdSCWtIXkSwNctbKv0O/dnrcTu9rqO4POA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr56owTFpds+npnbHCgixqQJcbFKcwCSEOfOi8JBvk0=;
 b=oKMJONejk79ZNQMCGR7an4AGRGdomJyEH73avrkQaNKj4tJvWC0GMwXrtx29hjSaqEpHlLol+eyZii/qe9VEXbq16tdU7LD6EeBWMemdc9yCnNaa6ZIgOr5FUw0/VtmNPHZ9hc6L0I1QXvO06UaSsDjx4KBrOWov7fUDD2LSxBlPaKaCI4GGm8VVcbLfiKWCpUJHuDgOYB1nWUkL3s+L0sRYTW9w7n0hzahqCCZc+T2IXjto6hGN+9xs1nxG5TyQVXc7lxiCfJRanGsl6S/5IpFBJIPXcQt6zbzlulqX5MLNWmHJuHUv4rbRSWqpGEewDgP1IU7HRjbNM68nDS4iMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by LV3PR03MB7777.namprd03.prod.outlook.com (2603:10b6:408:28c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 17:42:34 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 17:42:34 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] reset: socfpga: release more A10 peripherals out of reset
Date: Fri, 14 Mar 2025 10:42:25 -0700
Message-Id: <20250314174225.1245-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|LV3PR03MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: e920cc2c-73a0-4e24-8581-08dd631f9a5c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M3324/yRBoU5mPlQ4NB5sW6kgjwECkJtXlPOJyXLzbF1zPIGw4rUgO3yK0NM?=
 =?us-ascii?Q?kpVXAXt1z85hrJVqag9DoKfinAcMdYKoka/3pUakHZJcuOcN3kwp4f3hZW9D?=
 =?us-ascii?Q?Slx4DM2ugP2eDR801Xw+2vBc5ftyd6ZwVIotbBoGXLoGygVUGtgAr63673UN?=
 =?us-ascii?Q?996SM7gRm5TIyDMrwYDDydkqtb3yFFULofA4yI+9CDKc1709RVEDAGU+6HU7?=
 =?us-ascii?Q?VoIq9Y7gLmVMNErkDMa4yqsW9Tys+4wD3tR1WojhK0485bUX+7krosUKVJqY?=
 =?us-ascii?Q?A5/wStMAxKOdKHxeEnB6dG4Kavp35cUHPzpdE3kWQMzDoEwHFjqS2fK95W+V?=
 =?us-ascii?Q?loRmTT6EqH51hmWP8HHSpVbVrNUbymM9XOxyO7oZqq8O3X+5zj5QwS2n1zzi?=
 =?us-ascii?Q?F/J2ejJq7JSkXEEikC7XP/P0oEqD9n6XjGqRT445LMkp5p7PYg+X/RlLYrzb?=
 =?us-ascii?Q?yPWn6wKaibmYEm0xFKWrvR7tvjTQ2NDE9QRrRL0rzIsCGUAcJUp5Sb3dkU2a?=
 =?us-ascii?Q?F5oLQoFvQ2D25IzzNssN9wDrP0J3uLBK/h44rtMRfButHXIncSTGcXE357P4?=
 =?us-ascii?Q?rHC9ciY7638/zN8/ASyQFQ61vQgnduhcyZcIk5zpE5hGyznrLQlhK+rvLbyY?=
 =?us-ascii?Q?vw6u1a3UgjLmA+NZo2VMsmzvE/M6+wNkuZtUezIqJ+ho0zaPr6to0Yv0YSbJ?=
 =?us-ascii?Q?cJqSs5zf4rt0j6PCPlLlbCs3JSspz++FiuBXCfdbHLSN+L2QTZGT2CiF3rDE?=
 =?us-ascii?Q?01sFIqX8Akp5FQJUdTki5WDLmEY/IzzGyc+0lyHUKIsNn9In+jLACbnmIDAr?=
 =?us-ascii?Q?1khC8avxWAxCzgcTye4/XP2cgH+tBl5VmdRWyIBarCeXgkVnBkvARPryKPzJ?=
 =?us-ascii?Q?sTg6u4SOj++QsIKpkIzEXyTQ7Ez/bPBsNgVpjo7Acy7HcPunCtd9EoizZeR2?=
 =?us-ascii?Q?kwvBPgciIUJ+Os55gkHdAerGRpNX5BKZ9KRNa7KKDHabBDZdDcV4nJ0fPxBH?=
 =?us-ascii?Q?AaNNgMG96JMPUZg8U1RLjyIOxlUX6JlXCnpG876yaRczljzQFOrnjJgu3E0e?=
 =?us-ascii?Q?i65/QjvtYBWcJEhtg9vgmZpuhhT/ildhvEY8bjIJrXDlFcVNYWckkWrxBYP1?=
 =?us-ascii?Q?FrSmidY4W+gWrRsuNvpSwHgGyRPVZYA7naVCd9lgGtnwpBUYfuZRqt3dJroO?=
 =?us-ascii?Q?4MwIH38EoXogbx5k6Jjx2p1UrsUp6KPTUv4C0hMtpYRS9ffhJpRq/IaEIZGg?=
 =?us-ascii?Q?D2Rhvlpx8bybgAdifPkFVb8wIsV/WaXswUuQ8ejYXMUpL7ngtEwULPMHzoHR?=
 =?us-ascii?Q?TxZQ8S1nVvC3p9El/aijPA9aUT2U+SWQVlfJYJXbM2Zsnec8k3DQHvW/HEKB?=
 =?us-ascii?Q?Pf6xUIzAvkn11iqRD84ni2hTtDig?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OP30VhdqAPFTywkTuvepwuZIHP7se1fpA0CLct4aWMekSF9E/ak7Fs9UfYgr?=
 =?us-ascii?Q?AeUk2+raAVuA0pLcc2XwFx3ynTR1fa6IaATALkj2HK1znkepi/586n6cRk3M?=
 =?us-ascii?Q?lqn2ik9GULSWGyi3YJXCYu3VwKcyhjUSvsZyvw1moAYroJGoF6Gvah2DJgbk?=
 =?us-ascii?Q?fPWhLDR9iYxctIHHAscu+MINDEOBHWNy4r16ud8znWYFtiA+tAwno8x0HaCB?=
 =?us-ascii?Q?etlQOuuh+n8IevIVxlFz6fcBamjKuaqmUV68MpzJIBJ+5ZYs1mU24NeeajId?=
 =?us-ascii?Q?2A5mMmCL7T5cLht/u9P0crWk2Kf48iB9jBGUKO9G2plsm/YJoa90a1gXMg6S?=
 =?us-ascii?Q?sFRlRYk3SGTMurD0GEFKvv0faaqC/J43rrDIivGLoqrA/KCFxFkbRTxnNwgx?=
 =?us-ascii?Q?ibBlI0tgb/Os8KER5NloPP5W7JZqO6CHK94w1VfxdJs6tgHKiY6nwr9LaAE6?=
 =?us-ascii?Q?NcphcwsLFXULafyjCV6M6xwtc8er8NIX+Lv5BFMugE/VR6fj/FnIIxgTIqh2?=
 =?us-ascii?Q?f3FQLl//XK2VPTm89DD2hYHw6dfUIoECZuailFFZoDYodEOWuJsa3uZiCO+P?=
 =?us-ascii?Q?oA147qazQk93zJWP1xxDaYx7AAOabxmZOjmejLrLSRDpAaz8T1UBzzEYRIr8?=
 =?us-ascii?Q?SXawcw1N+/b7Ivrd++KAnYkTkWAizoomyimBPbIRkk/RF0ttb9vCS5WZwD8Q?=
 =?us-ascii?Q?/cVYXBUwPIT00a+/Oskx/h1YHfOnF1swxriFgnYouS4JQj8oX1zP6AcewQLe?=
 =?us-ascii?Q?hjs3Q0+JbpTuOybwKNQTgrSrzI79CKA1mVxV25qprKgfi7IPmBiiZUYWJ6GE?=
 =?us-ascii?Q?Bvv3Z0lgq/GqmmRbuCg8SOEg+K1Ug/tO3ARmDUn26tIu51sR8nexx7HU7dFl?=
 =?us-ascii?Q?EWX5IqJJXOt7/yH9VlFzCnS8FsRrtUnwy+bHzcxANcfEkuycLmibGjaUZp17?=
 =?us-ascii?Q?pn59Y3OPQa377Ntpis3eZCPAaL6UoqNLxqtLk7iwwucL1+anMexc3yPkb7sn?=
 =?us-ascii?Q?FSqqKX9/qusxcqxt+r4E0RkXDIGvCkV/2UySJ4ubMZwsNNK4AXGIziPLS2AR?=
 =?us-ascii?Q?dk85yqViYcZ+rHyyRW3N6Uik4iRzo7/i/prPs72kSRuMwI9+0zeGj9m77VE6?=
 =?us-ascii?Q?wC+k6VQ/tZ3ReFSTgp6ssG8VVBttCBAiv+d/cxk+lFGim5om7XJzd3TyhbfD?=
 =?us-ascii?Q?i9SNAd83ZxA2sjY78Hthyl8SHaktnYibr4R43mvm4AXxhgDSVCnG0tXXviq3?=
 =?us-ascii?Q?+aapKWJgu0P8jBtcdQ7pCNSfDk5S+WyzEjMkbp9OGR7Ooi8CNTzRRC1kGFj0?=
 =?us-ascii?Q?rS1aWxMwVSrY2FwA/jMdIFoAc4C85MPtcK/bvNJLoXMh20R0ioXq9c6hcxxT?=
 =?us-ascii?Q?lXOB9dLjT6lFXHdkDEkQ3a35ZZOQq6f6jBoKsCmfxvmHZvWBgFA194XW0Xbt?=
 =?us-ascii?Q?BoJAy+MG/sJFvcl/jB5jtYh9QAlZmkspwCR9Li3j1hUCWnmKqKxDYqjWY1UG?=
 =?us-ascii?Q?CoovXgba3p2E8A6TzDIlmiLiPDjkFqxYLFyyQQCGvQRusPCLZVRiIhi12tUT?=
 =?us-ascii?Q?vM9fhGja0SWaJEmhgCz1+4TeReOcTkAxZL+w7VIFlTIpGre/eVIL50EuMkGZ?=
 =?us-ascii?Q?pfSjSioOUq1ye/EacPnkImU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e920cc2c-73a0-4e24-8581-08dd631f9a5c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 17:42:34.3570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVs/j3fvNjBIAPqc/HJ2XsI8Ruk/WLynGFu2wQHh9Bymr5DnawkN+j0Vt4BQ/qtmSzAeHT/B3yqJ0igvCLYd3cHVH2ShMStEVLqdf14qzQDfpie45oz0PiqWu6J4zkQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7777
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

Current implementation releases most peripherals out of reset for
gen5, but A10 has more peripherals than gen5, hence this patch is
required to release the rest of peripherals to support old kernels.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/reset/reset-socfpga.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index 76d108080d..e57729f0ef 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -23,6 +23,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/sizes.h>
+#include <linux/kconfig.h>
 
 #define BANK_INCREMENT		4
 #define NR_BANKS		8
@@ -114,6 +115,8 @@ static int socfpga_reset_remove(struct udevice *dev)
 	if (socfpga_reset_keep_enabled()) {
 		puts("Deasserting all peripheral resets\n");
 		writel(0, data->modrst_base + 4);
+		if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_ARRIA10))
+			writel(0, data->modrst_base + 8);
 	}
 
 	return 0;
-- 
2.35.3

