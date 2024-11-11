Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28022D12D5C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A15289363;
	Mon, 11 Nov 2024 03:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9681892E8; Mon, 11 Nov 2024 03:09:46 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A978911D
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoVQ2oWM2g2/Yixo0uFpyEZb9VmhGDGOlCQtBuPSZl2HJPrwh/4xWX7yLRUZXvCt2400OjyBdBYYDduuqLNZJlhIs5J4YcNKw+TP3LMQCyxS8GmxfA1rXEJqkh/SI45OB5r8h8tMo3108hQI55J9cCLy26+qr0Mu2Zjc4WeSdujR660V+0+AD7cEBQWpp61am/bGp/puSfDWzsMqgstA+wvOkPRlY1J65/Fl3Qv87JycEP44Dl5mHnduerrZR5YW+T8DjFCZKmYldDTzBP5cACXlyuILf2dgzra0lMOwtd7f8CoOj7ou1kR3M0EBmz2O34zaAJTJ48OJV3vXXtmLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Teslqh+/7jTeja25hbVAVO5Lzf8DZypBF5iTfAG71IA=;
 b=eOP/i8Gwa0cm4X7eay1WHV0ADDB0ZulNnftc9gakCsxQ7XIOc2b/gqTzE+EA2Hn9Ojst+xBDkyOQZpYcA8So/kZPvFdfBJfvhcVhrhYEXcrZED4pFHT73HZQM344SihXvgojUgCuuRG7mvfoH6QG7eAN7nCYZiARirtseS3RWoGieBX76AjAhHZkPdJjBpmyd8bLBdw3w6UZT7fFK6jfoAedqz1DyNBGVbkRMW/VlYUI3YTKLmBojNgR25CLoeSzySE8hK3bY4iETVKdtg5/GIg4hpuoZ00ZIOZ87DvYKP7TEr7tiw/zsQTir2jLekcLgLxRj4pH0h22IzzXVri8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:49 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:49 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 08/13] riscv: dts: jh7110: Add u-boot device tree for
 JH7110 based boards
Date: Mon, 11 Nov 2024 10:08:03 +0800
Message-ID: <20241111020808.38974-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f1f708-1123-4f48-f5e5-08dd01f5ebf6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: fmQLyPef0iQMb4qdkevP8KyqVabBnGhZ7Qi7rWoECsXZR9c+SU/4TV9S8HbiE1NqRM1POT/HabSx7eY+Qesgg4ToI9/7MsKqrUWQxsnGhLnxEmkrhtypJgGMoC5IuDU9hLo8KcyzORFMxxMYu/MDeGY6F+qJQ38aGdXO+fqp6Rh9DGDlPpOuwVGDTEs9/V9mbDPFR89q0aqVm/MZ/Mpsm5Vr5QqOoNXXaBog9IbxiQGaBivqG+FhQLxfpWai67K3msIcc2udybdb8w10rZUirJzUrNWjjkkMQ9Y9D+0o11Y1hsdVSS+u8Pdyw+g+tieQNpDL9IgmOOSZA4/GMDlrt3GT4TqAoIePceZiZS2tPN+dBx1ftBqg5nfWZl6LHTVCk4IT7N/zNS08EPmP8DgsJajNp4QzcX27nOuJcrN1EnBfSX3weU9N36OCZnRbmhJgC5k2zv2hi/GNlrK/Igtlp6jKIU6p5JU1mJgy/Gz7gBFHesOhn1/70yY0QhA2tMyGtlMBV2ZHgdYtXgN8HuCBSb/67gWOxEjf/ZwBlGHRGNcsInbJdD8EBO7htvmTe9VmjCvzqkoxT+isWZ0pNm0bXw+86RbcMBIu+0CHGxVSLmB2HkRKiJqhNJjfvcsXXWJ5ifuOqfiwz7Kmc1norE6ZhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9RK1oHW81BzuLkW1J6fspplZ9VHOQj8vyB5vY83sLnNKET4yZnacfkWPk+kD?=
 =?us-ascii?Q?BEo/fVri8bJL5vsItod4rdcUWogMWSN7fUJD3I4WCC8uqef8R3A10m+ptPJO?=
 =?us-ascii?Q?bsXekGg2EKJ1o7nobJDco4N6X8u92YObIWkND5cP30dQeDwWNYu7W3iJ2RWh?=
 =?us-ascii?Q?PAPB72egNwmjco5gwa/7Tq17DcNIFoiHDr6TOE5i0ZaK0g0cDYAewfKqLSeb?=
 =?us-ascii?Q?dZ7UBZ+JLMO3/sGVGWoqOrdDL1Bm9TmNlOYS8fGIDQbICmeAhIVsfYF3Tdjn?=
 =?us-ascii?Q?/HYkVXMiR2T9fZw12Pb/FCSwo2kcj6eT3y/OLOXnodsi9xFFh9gvZBKLGYqw?=
 =?us-ascii?Q?iGSOPId4jAt2oeiwY9sG49RbR4S5SFz3jYKvGVUxPfeqPapgj2DKPVjEE9VG?=
 =?us-ascii?Q?DJxeWh1iNmkj+q1ylj9Ti1dIQIKptRoZ1DtJar4OvNcHl6FMCG5XEEZJ9xf2?=
 =?us-ascii?Q?czPyYDuTIyuCabQvTFF+9DRetKGfT7eHVfEgWX+ht/sA6QSmKJ53VFxK3QYH?=
 =?us-ascii?Q?S9cb0NNpfVLwMV/Rcl+WHI+uxeW0ANEQtTExOJjbnY9kZM9fJRlOpH0+oV83?=
 =?us-ascii?Q?fKowubBx33cL/LCZ6WDIqI8UnmiC11UqUmMx5qUrZrIdRb56baO+RXqufAOE?=
 =?us-ascii?Q?PAtYfdJuIbu20/JtARJwwcWzWeWGQhtuwNNYM2LNKoBjWCuczFhmg9rH2idg?=
 =?us-ascii?Q?Onum044JlBWMSA5xR+kU9svIUMTGi9JOANkjZ4mkH5r45wpq9sIC9ExPhYk8?=
 =?us-ascii?Q?rmdrPSuyDK9n4AtqYpte9wd4d4i1XjtHHeFlHdtiIDbtDDqWqawTG/0ce+7n?=
 =?us-ascii?Q?2dBp2Fl2RvKLCj4qt42JyyleghQcrRaq2fqtBjuwB06xl99H0AafNotYFVn3?=
 =?us-ascii?Q?G+rZ3D83n3wrMzRcLxkGbceMZ5jCMvZ6Z/XrdEL9LBu8DcDw+F3BaXUrw2rg?=
 =?us-ascii?Q?IXeQ1nooznk4IQ5M0uvdn29HRd8ZFVg7e6hKIJZ4MM8mOludVmXTMEg5ewd+?=
 =?us-ascii?Q?KUyfKRGbuZ41doS9s8fo2AdzmQeAmykesYbeeK5dDvGMPk/Pi+tHdiPdwodm?=
 =?us-ascii?Q?PCPf1pF/Ug1cuW1qdP/a63GTzz051qY3icqPmUsxE+N/EGzAoQpeecUmkbTy?=
 =?us-ascii?Q?AOtAtdIX/LckS711nQw1FU9Fzlw+C4eImo5Z2l0RBLLDatYCXakF3DHRxurL?=
 =?us-ascii?Q?50iEpdY/2aYeFK0BVe01afI69aNRcgnBABHjhrm71ScRUi3FO9VZfqaiW9cn?=
 =?us-ascii?Q?SNQDJf6e/bshfUixgH3ZuPdLwEv0OvVGVRd/WS/dj4wW3lF7jkOUhxEEjLpl?=
 =?us-ascii?Q?w/QkFMP+yL0E480fmkN8IJ/bQgUHvZ8CZZ2zEdHtaSu/L3rWIdGY63wvlIIx?=
 =?us-ascii?Q?kk4lpaq1xcEK3M3E7q5xtDygjb43+FnZJWbi2wz+EmaGAiLZprgmIOh6Rgz7?=
 =?us-ascii?Q?0mPceOxFRs5xFPEx7VQX1D5LzKw9EJAgGnDzbigoKPOnnSaPoSrKCQ6/VJj+?=
 =?us-ascii?Q?iU9s3VCXAKmjKMw5e9o78RgjZfsIsqToIjA+1iL9QzRkS8g8yfeIEeYbL00V?=
 =?us-ascii?Q?8b2z8CzN/rUxhqEVi0431evAgbdb6wYpEOlV2YATIOKP3OxWhYBD2MaBCiDQ?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f1f708-1123-4f48-f5e5-08dd01f5ebf6
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:49.4709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+ryhexoZWBQWJG7w89j9MFPRAPfIFMU5VrkdPmIYusSvXpqaj7efJ2+MTZIiKWUnM9LC8ZjPy2GPvi40v4SZ9Whe9SnSW7vdMGiz8rrJc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: H Bell <dmoo_dv@protonmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi           | 10 ++++++++++
 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi        |  6 ++++++
 .../dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi |  6 ++++++
 3 files changed, 22 insertions(+)
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi

diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
new file mode 100644
index 0000000000..cf4f0d4c06
--- /dev/null
+++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 StarFive Technology Co., Ltd.
+ */
+
+#include "jh7110-common-u-boot.dtsi"
+
+&phy0 {
+	/delete-property/ motorcomm,tx-clk-10-inverted;
+};
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

