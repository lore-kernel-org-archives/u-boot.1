Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109D2C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 13:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7911881250;
	Mon, 27 Jan 2025 14:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F2880F96; Mon, 27 Jan 2025 09:39:47 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F1380F10
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 09:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS3LCM5Tef7JudEmOK8nzBBNtKudT3VpWiWrMy/XyFQGq/3jnp5ULsOmEMDGtkqd3eVexhNIFnCaWuiHVTyWPlIA37fdenbeM4J0cqHiAQpxWxsVaN4Lu7lLPYC1jldWfTR985qTNIts3V4DMkrtQDv5M65VHivJH6wks7s1kDc3diedI1lsOe4xWP/5cX5858b/y5296N38/xM3w+FuFlipTg/NsvBiAhsjMMTDvfdoSyjZVOv3tHwm3Vzth61V2mYUD+qBQbRgRJSvNEqGS19ONoXClEcjPGGFd+gqlwxZ0lgYlnwFU2LzjRnGOi5312cqqKc9g186rHyUu3ulmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4KPNDw7ajiMKbi7cQrVlO5SMpwgxbfvrRoA/LlINTw=;
 b=dogAe5aEs4wgvxx6R8pT9Mi2Vf5HuiFzKbZEAvard2YmXHAsesl1SsG7WwyLH+BR9fY+C3QWobJKXbaBbyLWh3ht4j7Ggksh+XombuNLn9V11dtLs622GoEtc+74A1AkH9QhENik+j+6gp8AFtwEWDedvFwJjWSg/CCi+53VHmNj+to/OIpJ6CZh8rRRDJyfarijmY859VyQEbDcIn3sdwfPvVxBMVroH5RSJa8JhmIqd50XR858mEz5TPAklTah3QbVObwKl6gFNF3ptXb0KSH5fbPn+WikLXSZsRf/lHmmXLEzBpkx2NwHQUpKai9KDhbVwAkzjKiBI3B6gc7dgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1308.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.8; Mon, 27 Jan
 2025 08:39:37 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8377.007; Mon, 27 Jan 2025
 08:39:37 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v1] board: starfive: Update the maintainer file for VisionFive
 2 board
Date: Mon, 27 Jan 2025 16:38:14 +0800
Message-ID: <20250127083814.67839-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::15) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1308:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a14be4-5aa2-4d0f-6e87-08dd3eae2217
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: BJzin0fm6CAdbwhsZMALjt6QGz3TXUVnRKIbbFsvSkzV3+q3XmFk/RNtwLh30PtNDFaPBn2PzWIiOGjnUXT8doqWPTUwwjQHrM04ud5ytsLj8UcNGrfDg7SP1tzl0l45cBYYeI2s6XTLQd9uy3GOC401MPGHQA9ixLdSixp4cG1IXpxt9PspX4O5TjbmEOFiZFx+d/0EDFTbz8Ef9eJNaEm7Bq88tp7711vN6R/rdHCLs7CBZ7ft/HRfz9nnw8nTv0p4HyEWylQyt6UUzRVKeQOZElcOsdIOpShgc4nJurCboQYu12kLWTllI4bF/DI5r87dCHYw6PNYEZv54sO6wbb46hj7gxAFa9FBSRr8gqSOdyzVCVEkYd+kmD4Tlws3FI2czBLzV44dQr2vMo7wcj1MdHx6j1tjitc9Spx30yHnKrVXNvDfjTG+KS2aWmimU/S5paeeFxORu0zElge+5sYJeYj85xzM73RTMXZ+1TPqu6FtNajM78YJYL9vfk7n8OkaC0LnhY0AGkgajg+tqdH2RIW/BKGciQLakHmD/1TYzPkjEEp9uQOrGSc+gGFhnozlD+d0wO66tg/pk2F/Sx8Z7Le07WTV2BhxaE7MGMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(52116014)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q7mh3CuVZd+oJJDTin+X4vDd6iwWzPgp3Q0qXb7tk+9ieiRp+7nxyEwnivc4?=
 =?us-ascii?Q?Q22tIim9Wft19KQQSJ579F8uIAfphO+aEayQmJzDIHgLgXoLtSx2B57U7VZ8?=
 =?us-ascii?Q?fB+bC/riX2R0wy2EOJa0Jm+F5iSdHTgqo0eXfhxXJsyfdF4iNkMI2kKvPOSq?=
 =?us-ascii?Q?mJMLByObb4WiKFV9i1Gfct6KNRNQSMR7B+yhNBFhjGG1+SNizNxRo8vmA+9u?=
 =?us-ascii?Q?OIPn86pMnkFZZuiiUkl4Qfoa1TZbQRXv36Sann4Vq9JdkIv8ocV/yuqhwtqn?=
 =?us-ascii?Q?a3OcFWXctYJiqUvAUu8BIBoZtgLSGJM5xigLqngcjUoEpLmejfzhy0NbtHXE?=
 =?us-ascii?Q?MrhZT6KxP8kUy3XF/TASTvJyylF4Ns24v+QZU3om1xYPruXv3R5S2T7QRNnw?=
 =?us-ascii?Q?EcKbEQeeVEI0jmz7SSTTj/IxQlVmC9xdKwndVZNDCLfrZlZHCHe7SNOOGwYr?=
 =?us-ascii?Q?aYJfeyA6+S8vojknxjs9btLIwPyoX0zIKfSFFbGlkSk+3VR0nhi8O+QGpG7M?=
 =?us-ascii?Q?ofD9a2M7SQSN9DoBQU+RK2e71kIcE3kpK143ovw/bWORGexCut002OwYQFzf?=
 =?us-ascii?Q?gh6e4JGOIpX8NziDFgY/7X+YJRHdhR0coiQQsSQM6YAUK3Y5Tp7SSwaobz9Y?=
 =?us-ascii?Q?ZePZIcnGRxnGWjYmYn1lEi87q68uObIttHOOsc+SPrbA3xGlFz0arIjbQNOM?=
 =?us-ascii?Q?HHsd3j1ttEp0aRm5n48mrgC9KhKV8K2LYezpLSeTGKyh2RYVUQkPKHhOTHcX?=
 =?us-ascii?Q?jeRErNhGxbEj/ESUuYOWQFW7EvTO5W/4671Mpiska7ZNZsWLbBaRFrW3tmh7?=
 =?us-ascii?Q?lGUJGZ9lrtezYk0XBNfYlmFOOgiNg0W3iEdQWdF6Gkruyr2x6U7F+XLpusks?=
 =?us-ascii?Q?85kE20OIHx6UgZ24SVudagOx9qHC/KU2boxvSvYxFlaivIK/2IXdkL4Csvwo?=
 =?us-ascii?Q?9THzNRS8Kzh7jprB6r4DbanZqlJdQtwjT9K2NNBQV5YUOqwe7aLJYwvu9S/s?=
 =?us-ascii?Q?hvhEIWDX/keVCoubwHWrXhQSeDgrvU297S0M1nO9ycV5pB68VtbNYHqjHpuT?=
 =?us-ascii?Q?w/9VU2ii9PGbmm8DHYIEnvPhXgxjXDwfiYEI/N5T7Q3xnUfSRWwolPbMdSag?=
 =?us-ascii?Q?3rQw94TsrKMu8rxY9ITliibBzN+6dhjkp4joH1oidjVpkaozOChgpDSNW/Pa?=
 =?us-ascii?Q?3ZNoXJQW/vF7YeJGvzHjtHbL/aGaKGcFRCIADvQSXLcEML0klqee6ktQtArd?=
 =?us-ascii?Q?XCj8vk33CU+TrIdrytZZ0v469BEmAvZQKFQN1Vg/KMW5GpDBqG4rS9bl2lCE?=
 =?us-ascii?Q?N4hjgs9l/aSssGeqONeF9A1UTQ7YOH3RQBjlDHds6EYoY0YB6UqPpGn8k8Az?=
 =?us-ascii?Q?ZCM0ojXLXVeY9vq1eqP/O6qHD3vPYQgMYDLBY7aJazG4vVnsJ/Sr4LSQUKn+?=
 =?us-ascii?Q?v11S3vxBtWxvMaryzPwyCEA1PbSrHipcfhIGGjzrYeVRUWDpF4EipgWjn/UV?=
 =?us-ascii?Q?PfMITMn11Ss3L+H9K53WJxOEWa/s8RHANW8bAvZwsKQNe/tpKEb3QV+GbmHE?=
 =?us-ascii?Q?0zJ8UMort1qA9Cwj3/jnu12NbwvubZ3kfMElt5limE2f4XAO6GcnvTRW8UKI?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a14be4-5aa2-4d0f-6e87-08dd3eae2217
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 08:39:37.4948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOCh+2MPkeFk5p+XJCtN8nXOAk83dbgdfMYEe6ywl4gPWdiwzEyHsIId9WzvKdn26x/yUpCrBUAzj4sCgnx35t/FEcWPg2NpIlY25nBa2Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1308
X-Mailman-Approved-At: Mon, 27 Jan 2025 14:02:41 +0100
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

Update maintainers for StarFive VisionFive 2 board and add the
missing drivers to the file list.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b41..14fe8368548 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -1,8 +1,16 @@
 STARFIVE JH7110 VISIONFIVE2 BOARD
 M:	Minda Chen <minda.chen@starfivetech.com>
+M:	Hal Feng <hal.feng@starfivetech.com>
 S:	Maintained
+F:	arch/riscv/cpu/jh7110/
+F:	arch/riscv/dts/jh7110*
 F:	arch/riscv/include/asm/arch-jh7110/
 F:	board/starfive/visionfive2/
+F:	doc/board/starfive/visionfive2.rst
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
+F:	drivers/clk/starfive/clk-jh7110*
 F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/pinctrl/starfive/pinctrl-jh7110*
+F:	drivers/ram/starfive/
+F:	drivers/reset/reset-jh7110.c

base-commit: d8a7100d658eb201fa0e955667fdff298db31945
-- 
2.43.2

