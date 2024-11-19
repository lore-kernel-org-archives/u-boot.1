Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4111BD60D0B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 02:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD41894BD;
	Tue, 19 Nov 2024 03:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DEAC8924B; Tue, 19 Nov 2024 03:06:08 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20725.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::725])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D12389277
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ein//GJVU/4rStfTTeeTkygOK8oK51pDHyVwE9h/IVmwcagJRZiK28dUlKzr5IjAGxdtIvGJkuWPKJ0TaFR9jdTkG5YDR4ObeVj4nw9xsC+2VZFF3OctrBtlNukhxA+lDNoCqyqk/JUMlHzNlMg/qi31Z5aSOOcocKKh3xVXmuE7d7GcAqFQg7daqpFtvOgiyWtUBwwZ2yHwpfJVvUqfzWrMOgt6MCEbGznIIzQD2aL0GnqhpZ1F4qt8dmFR90kJSH4cBcfAVbXdDK0Sbpaj1pGlqTmSBTnqVVXG7vZmGOl/9jcdJ0lYwCooyqY2IreLkTx28kaXkL41+6hrnJHizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEQQk1938L+DFl6JdFbDlfxXPbg4/K8ggYDs1DPkbtc=;
 b=N4fkzDhs0hGlL3EBQjwI224q/uXSPwwOT1p3UOOtHReoBn56wtJNprOQ/tXAIcZTLDQQHXZqLrmBnbIYIvwIE5JS8cB1esV1e9ZxH0UIGnls4dFFeAEoP6qLJdRga0h6z5sVHJ8Bk5xOlQ6FPAY/gZTuyXCBmFrzcxwgn+ljsgvYO2O6sPSbFxazq4vF0FZ0S37MFolEv76iq59oAnI6UtEc3UKDEQA41b7T0Fo9L1Op5L5Gm0IrPetc7XOjhpk/twnFqM+sHeueHsgbVCtGwqHFYqpK5Lz1hbyuUp7cXaA1RsLNX5t0oh/MRaVObCcXcb/Yr+2QhEPvfkmL8slQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 02:06:12 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 02:06:12 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v5 08/11] riscv: dts: jh7110: Support multiple DTBs in a Fit
 image
Date: Tue, 19 Nov 2024 10:04:22 +0800
Message-ID: <20241119020425.51989-9-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241119020425.51989-1-hal.feng@starfivetech.com>
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b66ef6-3710-435f-2ee5-08dd083ebbe7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 64qEcHZNHWdA4GI2GX9wEmzf+bdZrEiOtU+oUwNKvQzeCzGV3fPKEHICXzh18Or+UEbCXJGIs6jZfWYpzdBNysegUPNdbdaDnNCE8Jcwzv0zt1hClX8OGRBcLFGkBQDnZbVFa5+sMdBhRMGh1Wal2JsHhilARHFz22kJ901zxo/9YPcH50YfDxH4SmWiaKMNCGLV7rgg0xNq0M+AJJKOWukJuLzfS9qRKd17pNpONStnMvUPKS/LgDwb0cCjm/JhPuBoXUW1x9992ZGCU98LFpfa+qTvy2Xh2a4pMoELvGnj8wzkwzQ8xAUugiBk88BvQDlMbkQKI3XyfZl+jy4E0Q5ZVUV6AlkQgtQtwLZIwSPWr9gUJE1tEa+25pBFb+MADuRHHmd9opMq+rgmTssw8OlY2d5ocbWKb1xZ/bWtaHV6ArOfuGBPN/aTROfOT0wYgrpjiAR+hMFjHvpxxBr/S3bzVE83EEYjtDviVbS+kB8QEB0z7tZnpEcbeiEw91kkyBaYaJOTHljYqT0IxpfZachLEopm3cftqM429TZibUdu1SYYEHLDUwDrZJJJ3NXqWC6b0z1AQ3aqdgyydAQIqI6EkhEQgidVg6RGE/hgtydu32b4TRJbBfHKAFeyhqlm431lrkhZleBxh/+Llk9I+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WFyKfMQepk2bbkOmuYD2O+fncm29UNgcheq8txc/vagR5cCmME2aQFY/jWCB?=
 =?us-ascii?Q?If/Y5UMrjC3oXObK6h8QTKfy93kxEji+kdE2VaTOPo7LDlpUTbtQxcKhLIdd?=
 =?us-ascii?Q?/x+caFviPC6ROB8aMovWsCN6tduorVtANNxXmPlq8Sg+VDVnKyGcGpHw5NtI?=
 =?us-ascii?Q?FnS7Zd8NE7q1yxLD8MV5EPl5HZElZ8GtCumG6tjgyi86eZpFsCyBJZIEMBPy?=
 =?us-ascii?Q?kn2bkFOw9+5KrPYdL8s5hysjL6tK/eObycL4v7x6YAIio0KPxcq+6hPoocpM?=
 =?us-ascii?Q?nz204rojCsdlZ6l3GZie5t8VksTtcaweKq2nSK/xZhXDM/xWl8sz/gOplrYj?=
 =?us-ascii?Q?Tf6FPdk6+jAzSseMXAXZ1c5EX7GU3oQiqww+U8DVrngjmulFwR9qtNhWxSJk?=
 =?us-ascii?Q?S2XVfpV55Z0sLI5f0Jjg6szpj9UlEBi1KCgFVYu9nC4jUhswntF/HaZVRswv?=
 =?us-ascii?Q?2eTXAypJHFsdTzvtX7XchtSYg+/C7nXk8pKAbsUBRyEHCv+L7Nq/Pk8bfQaN?=
 =?us-ascii?Q?Ihj5qjZUkN7vRQK1Wn6ipU/IfYH6C1+KfMaqwJsHwaQsmmP7jy7Us0AQlMtb?=
 =?us-ascii?Q?sJaBHMTm/IUUYHBaoP5AxbQQKL+yPYG2QcRec9BeSx2EL/+G2Wod/a+XMv7g?=
 =?us-ascii?Q?2FiJd58pFFG+BYwMmj9QVTPWtLcX3h2cm1ElAatLWHxv2IFH4RUumoD4jncz?=
 =?us-ascii?Q?ypY9iRA/vlQwfC3e+aq7Mhp5oMG/jA4ZX2R8E0ivDz0/TP1NzRnfd2R7aBGq?=
 =?us-ascii?Q?57h/LUxcWAS38mRbc8DYWRNjI/GPqiwGo+bcBqUUAxwIEWyqlcKeLygvruhq?=
 =?us-ascii?Q?QRfZULhOSocQteNq4W3AzyAE6bbQ9jA0uzzho4dNHCFBmFypf57vEySD3QoE?=
 =?us-ascii?Q?mnZHFR2cShJws+MqBEmhmtdcm3eq7EF2VYu1IByq+deCpR78YKgrGRXl2AbO?=
 =?us-ascii?Q?hHTT6mhN05N1beJrFU+RvlF955UfFq0hEzTJhi80RrUXNEyTCzDcdnCppPxB?=
 =?us-ascii?Q?77QUXpIYrfF0BbJ5ypqEcawJEbvUMvTvQ6tmyZsZPshbjIF48hIKxp/bAXQc?=
 =?us-ascii?Q?gZ67rofgLaFt5s66xcTQG4hjloYRS/n+EkrYaOsZR0IE32Cj3fQH3GlDT1RT?=
 =?us-ascii?Q?2UwASOJknhzwzkktgUyaoEP8PgL5Fajo3vBOEYDtrClwc1KwVIcFYwbozVU+?=
 =?us-ascii?Q?kpe239ZXV4zrSozZ1rweYM7BNqYKJIx+4tZH2Lg6PT3UMXEsfZcV6T22K2lB?=
 =?us-ascii?Q?/kWg9pWXIuA7HemzOVDHCY++dzg72UL4u+gJ2ZTfyV1lOPIokUhNNIlLE3XV?=
 =?us-ascii?Q?Pmjyhbkmrxyz/GYz5LbBlJMl5e2NqukuZa+aORQOfcjrsKd7O2RDk5QyENGl?=
 =?us-ascii?Q?zJAyGvB/SG1VZ95D7MoNeMfne9E5uK6+pHXNa7VfwyEBBFq4uzm4H6XQClg5?=
 =?us-ascii?Q?6ycX8AhfydfRqkbMwGnoR7KQYQKNd+AS4tHyMCCjaCCGP82n71GSOd6KIswe?=
 =?us-ascii?Q?B3lh2+G+Xlv6U9f/fM9VTeCizFWd8X91k51uvz8djA4LatvlZ1ie/l8DO5qB?=
 =?us-ascii?Q?oQdQYtuWADA3ZSXAyLokoVRS4dTWUhtoC43ry/iZYOtvhdYyPv4Z9ALfPTgs?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b66ef6-3710-435f-2ee5-08dd083ebbe7
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 02:06:09.1385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvtjV+c+MAOW3iWZp7Z8O2ToKfaOcdL1ljxPtSG5pvBFv2bTmPm18my+KeUto0xKOqLmxaS6DSRzvu+DJBIpO24mXk/kuVJ27Gfumf8tkjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Tue, 19 Nov 2024 03:08:50 +0100
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

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi | 60 ++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
index c44553455e..3928d551c9 100644
--- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -113,20 +113,74 @@
 		fit {
 			images {
 				fdt-1 {
-					description = "NAME";
+					description = "jh7110-starfive-visionfive-2-v1.3b";
 					load = <0x40400000>;
 					compression = "none";
 
-					uboot_fdt_blob: blob-ext {
-						filename = "u-boot.dtb";
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
+					};
+				};
+
+				fdt-2 {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
+					};
+				};
+
+				fdt-3 {
+					description = "jh7110-milkv-mars";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
+					};
+				};
+
+				fdt-4 {
+					description = "jh7110-pine64-star64";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
 					};
 				};
 			};
 
 			configurations {
 				conf-1 {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					firmware = "opensbi";
+					loadables = "uboot";
 					fdt = "fdt-1";
 				};
+
+				conf-2 {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-2";
+				};
+
+				conf-3 {
+					description = "jh7110-milkv-mars";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-3";
+				};
+
+				conf-4 {
+					description = "jh7110-pine64-star64";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-4";
+				};
 			};
 		};
 	};
-- 
2.43.2

