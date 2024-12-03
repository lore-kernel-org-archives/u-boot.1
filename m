Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761CAE6C5F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683898962E;
	Tue,  3 Dec 2024 04:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9E68960B; Tue,  3 Dec 2024 04:06:06 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B9988E3F
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNoOmNy9ikYDBtXxKJPkC3PjZ7F/g9fxwYClxEwsYknwFT7BqGpFoJ423PGiilrNKKGjEKbQpyqGRpNoWzdmA3LyQZkmfM02s8SUSi0guLLQ921s3oPifxeJl7BlofsdbmXwChCjhKTJREekMkeR4jXik+qL4KuJXuNdXatS/Nf8Hx1FMRJQc2iO+yaEiLtkh52rfesPIWx3NhVcbqwroXdYQFOFXBebmuyJfOqJqN4zvwZ/ZbfvNcr5+FmsWazCNlReubPnMrXPD5zwWnO2vh717IafXvmI/O/fEq7Ko7LCCgRHDONnbRIz+OM0DTD6P4warchjXOa5lBL3WHd2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJj8xDVhJZMwrvXOFmLNuUFxFv07Dm+AYRTvMJ4dmoc=;
 b=KsB6LvQAHgJZCEGbs7BtgAdzr1z1HW03H0N7gnaQVI2hJ2apwp3dmoc6A8TQQeggWTCUgejVDGhphdqOdXUknuliRbfgqtaqYD7hQnFL0kagI61niAOcwWdmArtzi7paJT1sxkQZutp0B73Uxldwjl+3KO0KWu0Up86v7GrEwC3O0nsc1U26gDMJSDqYu2MM+ib+1ECuoN0SMMspomV8cRgrUNaXHPvU9JKD73evhGawdKDyG2crjTDbV5rGFaRctoSOeUnVIvLo8bOeU1AuXEwlNP5Owjzw/2rAtOwvB+vbRu24Z6S2zqFP275P+ewsaugCeCnpRIY6zesmlROtgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 03:06:25 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:25 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 06/12] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
Date: Tue,  3 Dec 2024 11:04:24 +0800
Message-ID: <20241203030430.26089-7-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241203030430.26089-1-hal.feng@starfivetech.com>
References: <20241203030430.26089-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::8) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1180:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a494d6c-faf9-48f2-6a06-08dd134778f3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: gVRybdB7wI1MECz0hw3CFPFcTT/wdWpuPE8FAUzbqgGAEIcv/wyfZihuZskA3qG0unpfQybwiQHGyjrVzCUNEBWhP6Uh5jnNHf0XRBajXWgL9vDBmrSHuankb1ym3doR4Gm8sNlfgoa4oBwW1D8RlQHOpi8cd4vUqlpVq/ZxF6/n+xW9GbshGJ7Uxp1Ol+34Sucdjq8y1lC/siSLBL+NsHGyX1CInTwDyTpQTuQgs8h73iYsx9js0SwxMUeq5muaQBhvDiJUE2VLPVdwpc5pJeCqGphGBS0xtLqCxbMfRbgO5CfHv7gk/mDvsS0rO7I1MNWLhbyPUuMi8A6cmO2JTwoOGFn7+ya0SUZjfij8fu/KMSinKyJLnGXNFUz3TYP97gFBOeWeSQdXdn6cQzT87/6T8cItzrAS7OseEJy8Zy1cA6u5wA9jl6esIH2iCh9+9TXuV8gIrtBkVAS2vUtpuwbpmTOF6IJLV6OQMCdukcVzAjwbqBGEBEBr0BShGVhn7gwqHKHppp8QlDqcczwmdGygnLEe0AyICV59lHjBPpTmnqFwq5U+mCGQm0ip28G+EKb4vqU2O3AHUlARO7/qQLRkcDtbXLS7A2k39zbe5lbW0QC3yc/aHPAPYxciMiuF13nnnnPxE8ibzplO5g69lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hy0uParymOt8zqj7ozVyLK6glgsDmg3Elw8SIYepCj2Hv/KGEfhga+O8Km72?=
 =?us-ascii?Q?Y8t9M3/htBv8Y+f+maeX+Jgw1rMOxlgq8tM9wJmDrbE8eMRJvNGLD1IcJ+cg?=
 =?us-ascii?Q?67YGTF3K5J8dj5N+r3JL3WFfRvXWknGWjMJpSFYQNT6IrcC8thgHsdAx9rxr?=
 =?us-ascii?Q?2+3lAJsQc8VseeMvYM0bRzSo4yYPkmsOy4KeJ0b3KILOkcL6EAFZNI8aL3u9?=
 =?us-ascii?Q?/INujBLw7Cn93fT4ti6tx1GlbN9k9QPeh+dgk4jjHzp3kcTBtHfWbXVM5edw?=
 =?us-ascii?Q?pw2AqEdOhi+/CVBgjjAtNdWWPZLsgC+hLFY8UkbsVQnt5Lz3CQ7BzlmwG5bA?=
 =?us-ascii?Q?NeMWqGpvuIbpN3aL/YKH17KCda8J8ySTBcLlLrsGI8noica1OcaFfbeph3WT?=
 =?us-ascii?Q?byt07F5f6NQwoIATp1VqQu681rItiG5YGvsS9fyCXLJawAPD97x+kwy9eR8N?=
 =?us-ascii?Q?kpPUtT2IY5REUYTXILhW7PwJcwtYHVqk8/9ZLZNs1gKxg+9jjrSvhQ/Q4Ydg?=
 =?us-ascii?Q?YGKs5wg9A/T4ZognKl65vZo6SkubGARP7rsDI+0ORgXq1InrDqb3k40IniP3?=
 =?us-ascii?Q?Nk/wR9z2GXI4jgBrv/XtWqS1nY9/sO7D5RwYEXpUBlaE3SSfxHKm/nlp4Vp5?=
 =?us-ascii?Q?HOo1AADz8fGJqKNDgBI1nb/M/J/xTmZUjFGIODfTGAgHWHMosFb5R4OiYuzH?=
 =?us-ascii?Q?zAxmzmYO+ePL+0mldJ5z4mEI9dXTfdj4y7VDT06P6FTOf4eBVOWcIEj6JvuK?=
 =?us-ascii?Q?kJrgdW2Avi/SM7QQlAulacXwe25lwbhiqIUBOdPIcTege+wofxtNBrXzIlo7?=
 =?us-ascii?Q?hyD9VanIsYVFcoFCTVbW6JWT93GEHc4gThriDgbPnme72DprZU6TssEy7iuY?=
 =?us-ascii?Q?NpGhUc4t/jhugNVHUcpzuBwOhMvbt5QvCUhY9LMdKzcIIhS3aAJqM3Gj/6pD?=
 =?us-ascii?Q?NHUPBzv/EBsrT4TrDIUYRZOaU4Yl5xMW4xIeReSaDAGIiI3jg6coq3tnhpMs?=
 =?us-ascii?Q?6pUakB+Azrlq+34VhvcFVSFZ3Gc4G+k1gBzae0bR0aGqGgujFCsRDOSdz376?=
 =?us-ascii?Q?bZeAtS4y90WBER5Ebc2NY1RD8Zqj1sCspXwwXgCZ1Qt4FfyeRWXKV6Ngivh7?=
 =?us-ascii?Q?BFAcaiEyZ9+n7BI7BtI8Jhd7a3VbuHJsN6BRZ2Wi/+335llWKdegs5NJp3GZ?=
 =?us-ascii?Q?/y52Mz4EJxYBSpuQij9uAJ7EtW9Jas0AwnpzoinVJBhOHrvVH8kuRg1p+HHY?=
 =?us-ascii?Q?40qeTpAL66s9J8As3x8DIT8NjHbf5KP+bVzXOGxzFzrNlOGsC4hKDcuHwpE4?=
 =?us-ascii?Q?IGlzoz2OWSjd60EJFmKe/SlhsiFFhh66AfkvigTcPhMlgYfPQ5RL/ELxsr4g?=
 =?us-ascii?Q?WI61Hs1cM94tTJuLR7uagHKAgxFlLJxSphKxrsihOjooANdg+z4+9+DBjHw8?=
 =?us-ascii?Q?xemjog4rzLutAYEk7EYMVF2jpu39iomMjf2yQNP5FO7YAdbzUgkGLVOmMUyg?=
 =?us-ascii?Q?tK2Y+1o59nshPqyy7mz2baiLu18q+TpK8F3Q0bstchO0hcUIDIZmddwuDc9f?=
 =?us-ascii?Q?zYRZd6Xc+eo9czBbuXaaxBeR617jNaRxUqoZ4MeNbcHGVNP7PXHB8ZL+6tO9?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a494d6c-faf9-48f2-6a06-08dd134778f3
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:25.0380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6a5XqbxbjiKs96dvoevNroc8hKZPIqVhxry/GC3b3/giZXb5Re9eTFIXNV0aRM2kD1Mhj6pFJ8fHYUccp8g2UvHLnPEJbDiLw2iG+fGDAOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1180
X-Mailman-Approved-At: Tue, 03 Dec 2024 04:11:50 +0100
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

To support the other JH7110 based boards, add u-boot
device tree for them.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: H Bell <dmoo_dv@protonmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi                | 6 ++++++
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi             | 6 ++++++
 .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi      | 6 ++++++
 3 files changed, 18 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
new file mode 100644
index 0000000000..9df1e5db55
--- /dev/null
+++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
new file mode 100644
index 0000000000..9df1e5db55
--- /dev/null
+++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
new file mode 100644
index 0000000000..9df1e5db55
--- /dev/null
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
-- 
2.43.2

