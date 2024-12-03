Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4001FE6C5F5
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 03:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63505894B7;
	Tue,  3 Dec 2024 04:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5463895FA; Tue,  3 Dec 2024 04:06:07 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF99988E32
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 04:06:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fESAT8t/OnAgxEsCwRTiPrZ/SH5J4CKQ40B17ryao5uTRXJDagI4q2YGR5LzyzwKvNywi2UNMhVsfz2haCOSYApZEDWcdmWL3kyZyRrolxAHVH9lsLVEGrvixCbAXYwPFkf5u0rAUvpeuKML6uQRB+o8M6YyiBe8SL8URczrG4U/XgicChxC+N/UsdYcydv01sJQEcrawSYooqIwCkMSLmCLAH4Ven2yfGoO9TdH3v0ppA2fA5izd6ITNZ3PyX48xP0vPPj0QXy4VS3K5VQeBKN4qfvCsIA5a4JH7Y3P7StnRnLzpPR9702cYteV8QW9ETXxsfeuOa2reA7Irli7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+DkJ9YaFvmk4bjlhRuFSMNMqqI4PiSj1EGbhUDiG4o=;
 b=hHKNYT2kQbaOpssCchnwCdEZdsJVyM/z/l1C67F/G5U0g8YwXEfkGaACShFtCf9qpT25/1GGSxkgxFw9A1FQmfeM24Peal0ZAVrKYJZsp6zj649WWQvpuYAhKiUXR6swVAWXx5ExrIDdZwNuZX8/kwOIZG+wUsbW5LgKIeicjNkx+1UJRbaW496ejxfPb52YJpHcy4pP9uShnysA3cT4oSj3XgwuUZDiAN1NjGr3QUCVyjoT6lCjSYNvWZdcwZIuMZ/OVZ6HEWoh4w0U1lzTWeXyZXKoltKprwnKB7fznd7AbsBX7NOCoxRPsGlo/7w7c8uiFtrlyslhZ+lwAi894g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 03:06:28 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 03:06:28 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v7 09/12] riscv: dts: jh7110: Support multiple DTBs in a Fit
 image
Date: Tue,  3 Dec 2024 11:04:27 +0800
Message-ID: <20241203030430.26089-10-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11b863a8-f8f3-4099-0852-08dd13477ab7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|41320700013|921020|38350700014;
X-Microsoft-Antispam-Message-Info: QCLU3oykW8lvWt2NNTXM6f1SWEzGCfba3IbD66jAapw3oah5pu+j/IPNonO3Ija4sOqF8FM3kpH1yOvekU4cTmlFfYwAqLoSN4bjRCBStsZ3bKQcDVkXydRiS9kqIJYv5bCR2h6h0djABQyAWc8mIaY7p/AfF9hdMncpdMpADPRDjMKWtcHo2iLILL9HuLDwYufmPFUeU2v9+sQjlEFTjyvRojAjdR9c+jYoP7NjuuRs9Zd/CbvpyQYIJ61dfcQspbJaEGKPomMpSwySqLvfJuYuKgb0OWgDVret1WhZ7PVxAafJaQ/3ufUrrCuv49pauZgJanU4rowkiZGcMo2SF2iJCb5nJmO3KMhUtnq1WZMxBEyup94MHixl2o+kJ8rhhpOu7P6sLwBv8kZTrV0c1b4VZxBrr9sUivHtNeX0E4bj9VnT06YnZiTeiS105f57iyX5zubMNaaKKke73sfVdOt+vZmMPEL2xUVWI5NQywKFMuhK5FxTAV6Zs0YIPerSGuSfLKPDuHC3sZpN7TYKQcLlCv+RdfXPW9lRzVRd6YgZWIRqp4kJNNqO6XzXSbOQem5mNSEF1RMnjFnfz+wqeIxZa8uL0c08Lm/jTg8q26pW6j2kjF+9Y1xZxJCagcG1sOLHGH20TnXZzzFvT3uQkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(41320700013)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCmR2mlLn1NFEjcOG0WEYG0s6oruIuEbIhld2FXbvJVNOH+dmghCFmkD35pT?=
 =?us-ascii?Q?ZghZkEvOe3sma3qbug2Ta+G2dqFdrIP6xdLaP6yHGgFWbwabzsPoSoz6/4UB?=
 =?us-ascii?Q?fEmlKWR8ZiLaDY1Qb2ug9oDqL8VddQJpBbqw9V/ZAiOSgH7WcIcCbVCwgf+L?=
 =?us-ascii?Q?Y7LUwuouc3eRH6XT0UUrI+fM94nUp4c+6WNRIXNj3JrFcDfgq6+lYl7mPyD5?=
 =?us-ascii?Q?FcaQQjF8kqTODSCofa/9q0NW6yJTFPlGNGcQkfZy+XavmiubtABc+NcqDbel?=
 =?us-ascii?Q?Lgn5I2+xLc8pnTMXSUkin9j/pIxUaHB0nXLL3pP9tr8HgMMORKDpB7qcjY26?=
 =?us-ascii?Q?yIMDTwY1xgC5CDoXa43PmUgbjrBQUGt1mxN3TqEV8KNxiL+Uii8bilr//P7R?=
 =?us-ascii?Q?4VExCgRCotzVQq0KnPSRjeNiIE8eG4HQg5BH3H5E2Xcy9of4Y1RTKj4ghs4z?=
 =?us-ascii?Q?UgGhhXoR97D3osWXLweQdKl5GeOh3RZXeJyqO+ZnrW13HL/7w4NLi73t2TcC?=
 =?us-ascii?Q?4XAaDB1FXLP0QiknEq5YNHWrdVwoZgO1oq6mDAcrsG2LDDEG9dmk6VDcwo35?=
 =?us-ascii?Q?sR6lR4rqnte+YjAgsGRSlAkJv2R9kmWvR3I1w9/1irwHwwyW7hsbMBEJaQDL?=
 =?us-ascii?Q?FI2cvpYADfZktKSJmeFPI1/cNgvMfiU8SDUyw0DlkpYt83j9BB3vyl0SoKHk?=
 =?us-ascii?Q?nkwco3DrbSHlTW6wOqMoj7FGw2o+q2726pnNQAnfIARliVvLYIJgrZHjm9v2?=
 =?us-ascii?Q?ZyPUyUaxD5NDvrqUkvTijwAkQ4/o8qrDhQrE+Ernx5eszVc1Wm8dz189LHDl?=
 =?us-ascii?Q?c78n69y8L57q84sKRl5PLTEBa+/KRgUEzKdAlgMWP5rPCvkymhgBby0OF3Yv?=
 =?us-ascii?Q?PfCt7B+GV2Mj26nl6syDDixusBb8m0eupSCVqKueki4IRpDNVSOtX6lhHQfN?=
 =?us-ascii?Q?lJGh2J/NGk9fQYD8G2VCyOYrEpOgtKTnyQciFwCqV/cRhJYYauXQQlBbn3bO?=
 =?us-ascii?Q?n9C1D60JsN+KjFGELIjcYJ000DN5ZLFEvxkbFrBsfasMwFu6SwEzauDNItNC?=
 =?us-ascii?Q?vQ7C4OKsg0DHkIvub/fUWArgUXB/jgoEVmmR2BCl0NhEi/98d3WeLtfc28Ml?=
 =?us-ascii?Q?I5eSVaWAHTUp1lRiQrpvh5gxLICKf3AVj6T56b0ySNYc+wbUeKSxUh9v2ktc?=
 =?us-ascii?Q?jeilkZdUnTi/Qy1/sNN5zcM4jplNQeq2LUSOMDBjXgqlRRLuHMZTYaiVw2B1?=
 =?us-ascii?Q?xpidkqYOTD+DXxV1HKSWXX4hBy93JgqNYFY4xvbwPqgCj4kG/sM769PSsAGr?=
 =?us-ascii?Q?vUTCefEVmPl8mK22NuMD7HSDfETWbsk3xjo08bBzqel00fPrHt8BL0x9IpM6?=
 =?us-ascii?Q?9xJrP9RpcMCvGuy86nzSVI0nZ5fuWDkcwsA/a8507Nw8Uw6m9yJI+R+4easm?=
 =?us-ascii?Q?AjUbWiMNIY5hD/VNofxzz/DcrATjEKe4/S7gCcWSCDjYP0QuSmuDcONdYpBx?=
 =?us-ascii?Q?iPQUwPDM/MTZ8pwCpSEfBxPIhXMlQvePQFLuw/XMrwEv4EuIT5Yxm86ESyPc?=
 =?us-ascii?Q?QxfDv9SMOyQGK+QZU6dUYXGaByWDd0cDAuBDHz+bscr3JiIhX9Sk8ispcXUh?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b863a8-f8f3-4099-0852-08dd13477ab7
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 03:06:28.0029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1XSqCkA9FMLJhBL1r2q6g+xqGVT1EqPz0bnqJkd44yFWQUPqCr2ZWszFfn7iLYikZkA+8Nzy+2e2d17/zRgDvceZp9OgjShtheS1X+F7xk=
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

Support multiple DTBs for JH7110 based boards, so they can
select the correct DT at runtime.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi | 66 +++++++++++++++++++++---
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
index 7953459e67..a928faf520 100644
--- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -110,20 +110,74 @@
 	itb {
 		fit {
 			images {
-				fdt-1 {
-					description = "NAME";
+				fdt-jh7110-milkv-mars {
+					description = "jh7110-milkv-mars";
 					load = <0x40400000>;
 					compression = "none";
 
-					uboot_fdt_blob: blob-ext {
-						filename = "u-boot.dtb";
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
+					};
+				};
+
+				fdt-jh7110-pine64-star64 {
+					description = "jh7110-pine64-star64";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
+					};
+				};
+
+				fdt-jh7110-starfive-visionfive-2-v1.2a {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
+					};
+				};
+
+				fdt-jh7110-starfive-visionfive-2-v1.3b {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
 					};
 				};
 			};
 
 			configurations {
-				conf-1 {
-					fdt = "fdt-1";
+				conf-jh7110-milkv-mars {
+					description = "jh7110-milkv-mars";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-milkv-mars";
+				};
+
+				conf-jh7110-pine64-star64 {
+					description = "jh7110-pine64-star64";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-pine64-star64";
+				};
+
+				conf-jh7110-starfive-visionfive-2-v1.2a {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-starfive-visionfive-2-v1.2a";
+				};
+
+				conf-jh7110-starfive-visionfive-2-v1.3b {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-jh7110-starfive-visionfive-2-v1.3b";
 				};
 			};
 		};
-- 
2.43.2

