Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EC4C83F34
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 00:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF75883754;
	Sat, 19 Jul 2025 02:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="t0dQDnrj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0B1836A4; Sat, 19 Jul 2025 02:57:54 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09AD8365C
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 02:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQ2j3uNgaC1fMlI67gzlNo7IO2+tW3qgs7JvgtylRGbD0HtE5k9xL4yLSS9XoPR03qmTmVb2x1UwkBMv4xsvDmKvGXjUDeeGfzVibSwE3NY3G2JFVwt9wY8+Hm84PqWO4KeBQC3FiKJAq7MIuuqk8h8apTigtsSs+sNUmBqeDHmopXFk0KIUz86OY7taH1gMKDcZ0j68gfVVDW1hWf+/BpB6T80MAhjr6YkZ2HIeB1KWqIBLPaeQm4YJ8xrF+oIS5r3Sx60LmlZZJmbTR1cm8AMfJbYx5F9aOgT6YC5tYf9754mtcrDBezNE3PF6vtCYlH0/CQ7hRDXchnW32NsJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmPobL1fcXIt+ZReIRq+hYkPVvahBIRO5KUSdcwbC4g=;
 b=kv/zF1igDbomr5QPYpj2Ps4d6OMcfK75h+72+/rKevm8tUXpnZZyb5mSVqbCNa3wjoC99iG576CNKy55TMbQSDr3xGQPdDIG4jwrtCsTGSID3WuP5hU5EtV6Ke8YizqXhRI2RtXmb18Qrm4eeFGvay3ciW06vDEaZYZzHKL1G0vNdAQBdCPvnHn2jm/u41b84liC/XgL2hpUoyBsf71/LM6IE4QlxDwByKaJ7z1v3lUJhnO/W0RW/1MZBzyMrFTxONlKLbOnriS4oGLFFBdqOB2Z4JsUcSr2/jOOt4sfCJWH6IC+1EjPW7C+5uUWnuUEm/Vr8rOv9/ZES1sjtesX2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmPobL1fcXIt+ZReIRq+hYkPVvahBIRO5KUSdcwbC4g=;
 b=t0dQDnrjPSGtownDf04e1br0m1Mro45Ve6AzYRiT2WO0jKt3w5yzcsJiNPlMXGiCfOll+SvEiwYN1MRm6LUBeAiObWrCmFGFBWLU7tVRVJzXOwlJkzFkODxmUFc8rRbKMYOMNhB+gxepkHnaKGUetf48uuS+rLGKMZtQLvPtGUF6TQnXVxbr/6Ik+tYtLbW9PFq+bFX0J10vU7qj2byBWw5KE7fmc9F/z087y6eDUzgWrwyCEYcaldLJwWDNmqw1cD/oFtz4e19n/ceSY+3SRRwHnePjfWDzL+fEypBmHdrPFRve9iblfM0GJ4jqP/wPYnRd4Q/N5K2uDGsZ+3FG3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10218.eurprd08.prod.outlook.com (2603:10a6:800:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.39; Sat, 19 Jul
 2025 00:57:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 00:57:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 7/7] arm/airoha: add support for airoha en7523 SoC family
Date: Sat, 19 Jul 2025 03:57:17 +0300
Message-ID: <20250719005717.113842-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b427e5b-b281-44c8-7028-08ddc65f487d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?796F57mkkUdGhXBRjbEZAYccajcXOsHO+IuP1VWXEceP5bKOHRaZAY5Lr0cZ?=
 =?us-ascii?Q?OO4n2piPXZOeXAjRete8H7mTBfRNMCnAgRm9hic3Y2BKkb7cTgCKM6wIZ4g+?=
 =?us-ascii?Q?an/o36z/crJDEcJbKbwY5R52zLP5Y7QO/lWUz94Q/d4lX6Mh8tbv8UMXuqg9?=
 =?us-ascii?Q?9Qrp2nIJLtUZS0QlXFYkxnVc/CnMj/0YQfv3tN6TIGPjjYAZ0Y7ZdSvO/rny?=
 =?us-ascii?Q?5+ztaWhvdqE/GLQNZATGpf7Oayh23gZhwbwY8FMOv++QQOjc64uIVCU4/Xun?=
 =?us-ascii?Q?WgTx74K8fS+D3ExDZP5Jkm3lzxzxxGJK4wlZd3fguvlspa2gw/xiK5Xqm3mR?=
 =?us-ascii?Q?g+9X4j66+Z08xTWdTpzzSAbJORM91pCJ3t0UgLeOiPlZ+m+ifvKcWtiu7ATd?=
 =?us-ascii?Q?wj8VEW9A1nRvnd2Eu222XHIMwVF8G5k19p6mO1IlGdeGW2uQYOBZ/mlF8FWz?=
 =?us-ascii?Q?wQJOOaiSSHXpQzXFZBz9hnQhwRNsZ2BC/7XMY1RMRWHsVgf0DB6NZW8CyFsF?=
 =?us-ascii?Q?vL/l11CtcrGGvsJ7xUMVa+t5eUfdCfHf/pgrG7yN1fCrkpkT6PpH1zBGhLhW?=
 =?us-ascii?Q?ZipkgkPgSAETKC4KUFAwvR5AsNIkE1hAujCUaMuzkAEmg8FtTrvG9qesktiT?=
 =?us-ascii?Q?BgrtsOvVqvxnQt7eJLLTJlQHNKv+WxNolnP1/K0njr2qQgjIQY1TBLHY43tX?=
 =?us-ascii?Q?IC5PEmb1iHscAbTGjHFkfxdC4ykUIWcW1p63xn2Jedo2u/qFe+aFEU9jU5sD?=
 =?us-ascii?Q?fWSHzEtltgEnlBP5tSR4JvIjDnJ8h5r0SDdutZndFeCnoc/1tCl4HngNmwSN?=
 =?us-ascii?Q?hESWHkfZsmeaWbnuAmHV0QLfJ9BFgkAo16AZr3zVmRM+s+vZuiXciWfgsarp?=
 =?us-ascii?Q?n9GMumdyerY3GCVz4o+OQcymOPdecAe1EuwDUN0M7QDNEa/L1Mp+5TkEWPjV?=
 =?us-ascii?Q?r7rXPv0syzCkvrdOZsYyNGvmmwrMIU3zK96CkfW6IJtT3tsbDZq0G+uZJWg+?=
 =?us-ascii?Q?mjuKjkL0DccPoesuXQK1GBr4enabvl9r0SVSMnYuREz8QVJCBLnvYA+87VN7?=
 =?us-ascii?Q?kA63nrmDip2oAqLq0PtoFSlj+FOBZaYHosjAyvJWBax344VIPmq5hBciew3e?=
 =?us-ascii?Q?r91cy/lkX/suZZNwKB4Gc4tJWLFxynYB9YAzuALHpeFaRQe9JAPRa8ed93ZC?=
 =?us-ascii?Q?TFqlSeQlLKG02fMJO3YMIVk8PqG1nbpmUMTopZkvb2vlyZq5307s7ntMc3gT?=
 =?us-ascii?Q?oFmtHXENSVs0KWArmoxcEGVb0DUcmH26aLyAHCSnOAV4ejBv7EfsxCkEEp8e?=
 =?us-ascii?Q?JqG41hTLZp5C0ZfWKJ2ToMvYyWMCjl2/T39YH7XWM+qZBvDHLaUGxsVwZ7eM?=
 =?us-ascii?Q?hP5Gkp30T1YIcvq70rJFwisKtwM4S8bGT8cIEHi0Pnrb9IO7sEhHYuMbdbkA?=
 =?us-ascii?Q?WM6O7ysHbhr8j/bLvh+F/EpBYUmcg92umyuS4Hn3LCfh/jUdjxK9W8aXH/q8?=
 =?us-ascii?Q?kR/q8BARFlqVa34=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jdt7eFbYH8+DpjbsUMEjIfyh49CF/AB5VD2kTQRvcSQwc2pEy4dfPPLXxiD8?=
 =?us-ascii?Q?sRyX5YgmVTPCfroT6UnJuHxBfTjySBMlhHvm9dGrK0QOz12kb6VPOP4CGJHK?=
 =?us-ascii?Q?ZL467RXo7qVZHXS1X70nXX0gx3mKnYB+MinFFCyyt8ECBFoO6LzQpZ9XutWQ?=
 =?us-ascii?Q?8iJa2EgePEOouzGGQzyEAsky7dBW1/l3Tnt06enjUvSlQZllO3CZBY4oukwr?=
 =?us-ascii?Q?qOVMpnoZWdJ9yfp87GVWXFqdHJ41wA4B9kDBvw5ET8mqGryPieQMn6PVDwcy?=
 =?us-ascii?Q?bEeNuuoGrbHZ1XR1b874dO9I6NlJGxqbfN623SOPxn7uLHq3EYqtxTXrxNq/?=
 =?us-ascii?Q?YrrTd4mnSQnsI1GRBPLqKFr16Bx+QCxVXugmc8BCntsGLm9byTQ6NN7VH1Iy?=
 =?us-ascii?Q?e9L1CfrZSiM1NFvJN4v6hj6jresTQIYwdFi2b14tgjuxH5w/xhCjvXlVoMjS?=
 =?us-ascii?Q?5YmWeegD+cU6EBipRJ5+b3MEZQzZFgpFRJV56Yq9zGFQDr4vVP9oYtH6gYAy?=
 =?us-ascii?Q?QKIHlvIBmE5KTZtBFwL/IMakkJyWrwJHylBxMyXoSazJwOIcQYTBuLr69SEu?=
 =?us-ascii?Q?X0E5y7EApY7uHnfQTH2ux3/onAamICuzPHRDNGmw/bsE2Kd8aZls3AbSx8s1?=
 =?us-ascii?Q?f7IL2RXm10iCpn418gR5k0XVyGT4vPujLkIeQIK+BuXCt4ujTYLiaLglp8oV?=
 =?us-ascii?Q?sCOA4bK2OnwYiUsayITJcXzSuXfTW7HgYSvLFA+1hKe3YWkq/O8NrLtwnD7J?=
 =?us-ascii?Q?oz/3AsaX7c2jI9UhiA031dqcvq1ux+PBaAT/Vx8FYJQNOkINZRRYfNd0v842?=
 =?us-ascii?Q?DVbVDUffklBpZ/P0yyIIB5b6v8FXef6K+vs49EkOi1Iy1GNNIt3zS8QehQfF?=
 =?us-ascii?Q?C1dlSys9iSd7j5LwmCsaphfs97pJQ0DH8KXkps7iysiA5CkbgyRPKFU6cSO8?=
 =?us-ascii?Q?FW5oDjF9JIVgci3uFpnr+M0uvcCI0oLLBOmZyXN/MRk56nv93zDm60zmvfTt?=
 =?us-ascii?Q?hY0GHH32hJNQyGRn4pKrF7vavJfQDEBpR9Uap9xoYUAa6e0fjEoD8z2gTrw9?=
 =?us-ascii?Q?2zwMiHuR/uzLrXQ0lIUZmm/J+n7LyZK343cC2mQx8gtz+U146b2/VpFyGiMZ?=
 =?us-ascii?Q?cymf7ihPhJplB3sTAajfJd2DS2cUPhYrllcnhdx9qmPOW+XdANAIKx5cdm0O?=
 =?us-ascii?Q?AzO9Xu4560ZqWngZDV53kqQxz2jv+MXExrEw+ICoGDcxeBagv/7vWsSnDhHe?=
 =?us-ascii?Q?wEy+leFgtLFmcjruoBBZflh82lB+LLG5lwChP2SL5mufpw69l8C+lkPmU3ud?=
 =?us-ascii?Q?p2e6Lmq68sp7DHfksxxiqAd4MsHjB+4jkqdJKcR4bzGFcpWbLTQPPHF1DBpd?=
 =?us-ascii?Q?GZ6tdr8JOseKJV6T8/0JF5gRaytBgbvl/xs0qNRZJA+SGr3bpORqFrGc82dH?=
 =?us-ascii?Q?/PtAp7DtkuSnsu3q3XxuKdwjHvfDoAMz/MWJIsdZgPengIpfYzWiVWNDPasE?=
 =?us-ascii?Q?SoznLIwVyPIfvUTRMFrstBHXMT69WVWZJxFa9WJct2KnpOBgjy/vGxOf2Jv+?=
 =?us-ascii?Q?9COFepoRjiVfH1ZyFKSAI8ZEIeD2g0UfG7pz9dPInRItntUwDEharAGnx22u?=
 =?us-ascii?Q?5dkGNzqBBYAOeJtTZ80v00w=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b427e5b-b281-44c8-7028-08ddc65f487d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 00:57:50.0710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+AE7TVQISCjN6mulTZCBCiik2/lvu3LXRppM5Zp9oOff7pIH6vDm2YDJithh686EV+rd1DG+nmEDiJjZX0p0/YOnALyNdP6+BVvDB65Ugw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10218
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

Basic support for en7523/en7529/en7562 SoCs. After a patch
the following hardware will be supported:
 * spi-nand flashes
 * ethernet switch
 * serial console
 * clock/reset controllers

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/en7523-u-boot.dtsi             | 90 +++++++++++++++++++++
 arch/arm/mach-airoha/Kconfig                | 13 +++
 arch/arm/mach-airoha/Makefile               |  1 +
 arch/arm/mach-airoha/en7523/Makefile        |  4 +
 arch/arm/mach-airoha/en7523/init.c          | 31 +++++++
 arch/arm/mach-airoha/en7523/lowlevel_init.S | 68 ++++++++++++++++
 board/airoha/en7523/Makefile                |  3 +
 board/airoha/en7523/en7523_rfb.c            | 16 ++++
 configs/en7523_evb_defconfig                | 79 ++++++++++++++++++
 include/configs/en7523.h                    | 19 +++++
 10 files changed, 324 insertions(+)
 create mode 100644 arch/arm/dts/en7523-u-boot.dtsi
 create mode 100644 arch/arm/mach-airoha/en7523/Makefile
 create mode 100644 arch/arm/mach-airoha/en7523/init.c
 create mode 100644 arch/arm/mach-airoha/en7523/lowlevel_init.S
 create mode 100644 board/airoha/en7523/Makefile
 create mode 100644 board/airoha/en7523/en7523_rfb.c
 create mode 100644 configs/en7523_evb_defconfig
 create mode 100644 include/configs/en7523.h

diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
new file mode 100644
index 00000000000..3de477202ed
--- /dev/null
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dt-bindings/reset/airoha,en7523-reset.h>
+
+/ {
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		atf-reserved-memory@80000000 {
+			no-map;
+			reg = <0x80000000 0x40000>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		scuclk: clock-controller@1fb00000 {
+			bootph-all;
+			compatible = "airoha,en7523-scu", "syscon";
+			reg = <0x1fb00000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		chip_scu: syscon@1fa20000 {
+			compatible = "airoha,en7523-chip-scu", "syscon";
+			reg = <0x1fa20000 0x400>;
+		};
+
+		eth: ethernet@1fb50000 {
+			compatible = "airoha,en7523-eth";
+			reg = <0x1fb50000 0x2600>,
+			      <0x1fb54000 0x2000>,
+			      <0x1fb56000 0x2000>;
+			reg-names = "fe", "qdma0", "qdma1";
+
+			resets = <&scuclk EN7523_FE_RST>,
+				 <&scuclk EN7523_FE_PDMA_RST>,
+				 <&scuclk EN7523_FE_QDMA_RST>,
+				 <&scuclk EN7523_DUAL_HSI0_MAC_RST>,
+				 <&scuclk EN7523_DUAL_HSI1_MAC_RST>,
+				 <&scuclk EN7523_HSI_MAC_RST>;
+			reset-names = "fe", "pdma", "qdma",
+				      "hsi0-mac", "hsi1-mac", "hsi-mac";
+		};
+
+		switch: switch@1fb58000 {
+			compatible = "airoha,en7523-switch";
+			reg = <0x1fb58000 0x8000>;
+		};
+
+		snfi: spi@1fa10000 {
+			compatible = "airoha,en7523-snand";
+			reg = <0x1fa10000 0x140>,
+			      <0x1fa11000 0x600>;
+
+			clocks = <&scuclk EN7523_CLK_SPI>;
+			clock-names = "spi";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			spi_nand: nand@0 {
+				compatible = "spi-nand";
+				reg = <0>;
+				spi-max-frequency = <50000000>;
+				spi-tx-bus-width = <1>;
+				spi-rx-bus-width = <2>;
+			};
+		};
+	};
+
+	/delete-node/ system-controller@1fa20000;
+	/delete-node/ pcie@1fa91000;
+	/delete-node/ pcie@1fa92000;
+};
+
+&scuclk {
+	compatible = "airoha,en7523-scu", "syscon";
+};
+
+&uart1 {
+	bootph-all;
+};
diff --git a/arch/arm/mach-airoha/Kconfig b/arch/arm/mach-airoha/Kconfig
index be3562ae3ff..d4bf63867b4 100644
--- a/arch/arm/mach-airoha/Kconfig
+++ b/arch/arm/mach-airoha/Kconfig
@@ -6,6 +6,16 @@ config SYS_VENDOR
 choice
 	prompt "Airoha board select"
 
+config TARGET_EN7523
+	bool "Airoha EN7523 SoC"
+	select CPU_V7A
+	help
+	  The Airoha EN7523 family (en7523/en7529/en7562) is an ARM-based
+	  SoCs with a dual-core CPU. It comes with Wi-Fi 5/6 support and
+	  connectivity to Ethernet PHY, DDR, PCIe, USB, UART and VoIP.
+	  With advanced hardware design, EN7523 provides high processing
+	  performance and low power consumption.
+
 config TARGET_AN7581
 	bool "Airoha AN7581 SoC"
 	select ARM64
@@ -20,12 +30,15 @@ config TARGET_AN7581
 endchoice
 
 config SYS_SOC
+	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
 
 config SYS_BOARD
+	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
 
 config SYS_CONFIG_NAME
+	default "en7523" if TARGET_EN7523
 	default "an7581" if TARGET_AN7581
 
 endif
diff --git a/arch/arm/mach-airoha/Makefile b/arch/arm/mach-airoha/Makefile
index 215a300373b..91395b8a850 100644
--- a/arch/arm/mach-airoha/Makefile
+++ b/arch/arm/mach-airoha/Makefile
@@ -2,4 +2,5 @@
 
 obj-y	+= cpu.o
 
+obj-$(CONFIG_TARGET_EN7523) += en7523/
 obj-$(CONFIG_TARGET_AN7581) += an7581/
diff --git a/arch/arm/mach-airoha/en7523/Makefile b/arch/arm/mach-airoha/en7523/Makefile
new file mode 100644
index 00000000000..cd0563d415a
--- /dev/null
+++ b/arch/arm/mach-airoha/en7523/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y += lowlevel_init.o
+obj-y += init.o
diff --git a/arch/arm/mach-airoha/en7523/init.c b/arch/arm/mach-airoha/en7523/init.c
new file mode 100644
index 00000000000..674bab0363c
--- /dev/null
+++ b/arch/arm/mach-airoha/en7523/init.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fdtdec.h>
+#include <init.h>
+#include <sysreset.h>
+#include <asm/system.h>
+#include <linux/io.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Airoha EN7523/EN7529/EN7562\n");
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+void __noreturn reset_cpu(void)
+{
+	writel(0x80000000, 0x1FB00040);
+	while (1) {
+		/* loop forever */
+	}
+}
diff --git a/arch/arm/mach-airoha/en7523/lowlevel_init.S b/arch/arm/mach-airoha/en7523/lowlevel_init.S
new file mode 100644
index 00000000000..0ac1b85edb8
--- /dev/null
+++ b/arch/arm/mach-airoha/en7523/lowlevel_init.S
@@ -0,0 +1,68 @@
+/*
+ * lowlevel_init.S
+ *
+ * Copyright (C) 2022 Airoha Inc.
+ *
+ * SPDX-License-Identifier:     GPL-2.0
+ */
+.globl lowlevel_init
+lowlevel_init:
+	/* Enable SMP bit */
+	mrc	p15, 0, r0, c1, c0, 1
+	orr	r0, r0, #0x40
+	mcr	p15, 0, r0, c1, c0, 1
+	mov	pc, lr
+
+.global jumparch64_smc
+jumparch64_smc:
+	mov	r4, r3
+	mov	r3, r2
+	mov	r2, r1
+	mov	r1, r0
+	ldr	r0, =0x82000200  /* please check MTK_SIP_KERNEL_TMP_AARCH32 in vendor/arm/atf/include/bl31/services/sip_svc.h */
+#	smc	#0
+	.word	0xe1600070  @ SMC #0 to enter monitor - hand assembled
+	b	.
+
+#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_TPL_BUILD)
+.extern bl31_base_addr
+.extern rst_vector_base_addr
+
+.section .text.arch64
+.globl jumparch64
+jumparch64:
+	mov	r4, r1   /* r4 argument */
+	mov	r5, r2   /* r5 argument */
+	mov	r6, r0   /* keep LK jump addr */
+	mov	r7, r3   /* r3 = TEE boot entry, relocate to r7 */
+
+	/* setup the reset vector base address after warm reset to Aarch64 */
+	ldr	r0, =bl31_base_addr
+	ldr	r0, [r0]
+
+	ldr	r1, =rst_vector_base_addr
+	ldr	r1, [r1]
+	str	r0, [r1]
+
+	/* setup the excution state after warm reset: 1:Aarch64, 0:Aarch32 */
+	mov	r2, #0x3
+	mcr	p15, 0, r2, c12, c0, 2
+
+	isb
+	dsb
+
+	mov	r0, #0
+	mov	r1, #0
+	mov	r2, #0
+	mov	r3, #0
+
+wfi_loop:
+	/* enter WFI to request a warm reset */
+	wfi
+	b	wfi_loop
+#endif
+
+.globl do_smc
+do_smc:
+	.word	0xe1600070
+	bx	lr
diff --git a/board/airoha/en7523/Makefile b/board/airoha/en7523/Makefile
new file mode 100644
index 00000000000..c6629486f21
--- /dev/null
+++ b/board/airoha/en7523/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y	+= en7523_rfb.o
diff --git a/board/airoha/en7523/en7523_rfb.c b/board/airoha/en7523/en7523_rfb.c
new file mode 100644
index 00000000000..aa73679d929
--- /dev/null
+++ b/board/airoha/en7523/en7523_rfb.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	/* address of boot parameters */
+	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
+
+	return 0;
+}
diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
new file mode 100644
index 00000000000..440274853e9
--- /dev/null
+++ b/configs/en7523_evb_defconfig
@@ -0,0 +1,79 @@
+CONFIG_ARM=y
+CONFIG_SYS_ARCH_TIMER=y
+CONFIG_ARCH_AIROHA=y
+CONFIG_TARGET_EN7523=y
+CONFIG_TEXT_BASE=0x81E00000
+CONFIG_SYS_MALLOC_F_LEN=0x4000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x7c000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="airoha/en7523-evb"
+CONFIG_SYS_LOAD_ADDR=0x81800000
+CONFIG_BUILD_TARGET="u-boot.bin"
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTDELAY=3
+CONFIG_DEFAULT_FDT_FILE="en7523-evb"
+CONFIG_SYS_PBSIZE=1049
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="U-Boot> "
+CONFIG_SYS_MAXARGS=8
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_BOOTMENU=y
+# CONFIG_CMD_ELF is not set
+# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_BIND=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_SPI=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_LOG=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_DMA=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_EON=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_AIROHA_ETH=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_RAM=y
+CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_AIROHA_SNFI_SPI=y
+CONFIG_SHA512=y
diff --git a/include/configs/en7523.h b/include/configs/en7523.h
new file mode 100644
index 00000000000..bc62116ffcc
--- /dev/null
+++ b/include/configs/en7523.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Configuration for Airoha EN7523
+ */
+
+#ifndef __EN7523_H
+#define __EN7523_H
+
+#include <linux/sizes.h>
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_SYS_INIT_RAM_ADDR           CONFIG_TEXT_BASE
+#define CFG_SYS_INIT_RAM_SIZE           SZ_2M
+
+/* DRAM */
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+#endif
-- 
2.47.2

