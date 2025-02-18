Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FADC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097C780BA8;
	Tue, 18 Feb 2025 13:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CWKJcpdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE7880C98; Tue, 18 Feb 2025 13:06:38 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC2980BA8
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGRPbfiTzSmtalfPEZlVdfd/jSxBduaAZNabKCL9cu3O3PoCRrdVVFHdJ1eiI7jLE87QXBDkeSlFif9iEVFmLds9U+azq0T6si6B1H0Flsw0aR75v6+GzasoDv48LYeglgJyCuzH43D6l6ME0XyYe18Ouqn/ojXzVd9Ct3G+89GVPvmGzj3bOaAhCyppJCAbv3mEB18W3A5n3rT7DPzhB1zlGiVbV4zVNozN4PK02clm3C4A/cVSM2DakkLmgMq9XpeYDjlJQVwvMbNdH9ST6ElS+8En3VEZopaIJOkUevx/YL1JUx9jZhXaR2Wa8ZxHaawUeK6zrhZ2y7UJzPFpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoX690YmFRWj7DRnhwNMMUaZAbOO4hCxlpJpl8sM+/w=;
 b=hqHDw+KZTyu8Jya0oC7i4qzu0pt1fEXpC93twQfioTnRu4jbwV1ioTOlxPI+vK72nWBGsj4BbLb5bQ+tpiHVV2jD6wBg1GX6h7cX3HUejsDeG4S+0QbrZ4hFhMJMoVPbkDAqr6JoFhy0DfanBgzj9kfvdHIaiHM+MozXx+rNv4v5eZdTmkbHT86YA+u8M/dYNRTmuymTAdhtoEsqZO8zIHXDmkd7W24r3179Xll/37GS+Y/T/aJ1SO+AKNgW+wPWGEHKbEAnBMZ9lEgWj4Tzr+5uG2xyOBXXIhnnEGx8vmftqX9ywX5Javp7mCj9K053/mytQS9kwFxh4UHrP4XeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoX690YmFRWj7DRnhwNMMUaZAbOO4hCxlpJpl8sM+/w=;
 b=CWKJcpdz6w631e+ieGvTFVJjs1b26kriq7lO15QN3Jn+JzImGfX0Pw6kj4jN+ADicekyQu5VgHG0RxBv8Uf74ZYUTCnSNbiEosDdZmOgO7pa9eLraGB9xMhv7fDhsvHh51ehoa44TigFPpaWeF6JTsvpK9VGtr4zHXc8wsQpeOz+iTJbIuc4uMXATVNEc5cv6Q2KxI1RhEvcWfnH4wXBjmWLlvjCHRyG5MncCEbPqw/QLEmNOBg1pVWG7CeK31V8jX3GX/ccMqzWRLfcnmaJSRW+natSRfvj4zieWQSJBSCJeGED+yvh9jfYH22cQU1Z7suGwoIyV3F4aDhVCTb8KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:06:33 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:06:33 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 01/20] mailbox: add i.MX Messaging Unit (MU) driver
Date: Tue, 18 Feb 2025 20:05:38 +0800
Message-ID: <20250218120559.451678-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1ebf54-4762-41b7-3880-08dd5014af9c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6dByOzpyapqze9PSqiBdtRuZbjTs/PW/9ze24xqH5sPIbi5BZzm0NR4owzDj?=
 =?us-ascii?Q?ODdHjQ6OFmW84BcnC11kyABtS5l8XfIXuJeYloeZfXHkVj8vcFsfBorPVYO4?=
 =?us-ascii?Q?IHseL6hOvoPjWzwPx01LQVcfNL/TBqEa/d++yqSovey32qnFbgmwsq4xg2qj?=
 =?us-ascii?Q?r6L9+UAJ+hFNykxA2JHpS1gFj2gmrYrO6X4reWiWKoEisV9hrWp1kUjZM1eW?=
 =?us-ascii?Q?4Ul33QSu44knS/l9i4lkaALeBYEbny1sfXMghi1g0UhF/y5+nVeVzTuDn2DQ?=
 =?us-ascii?Q?FY3l9h35GRkYTGdqGRfV6D8Zt3aQDvzt8hNkHaOBuhaLW8/7QftRgHhq3wzv?=
 =?us-ascii?Q?mFfCLocOgIHP6lplPkVfThj7MsdKefNQYNyu++DySFiaDQeC06rXlaqNcJDE?=
 =?us-ascii?Q?49UTgK9oaiIYKeJkcHjKCriTqxVCcqAmiE1tYPFGr48ZDdZYZiiBZmYYrFMj?=
 =?us-ascii?Q?yMymFwRlbPttTjcquDFHlQYdIOEnJNdNkJQ8dDLy5DMnCeR91yFRsBG3aXvJ?=
 =?us-ascii?Q?6OCJf3DYFBrNDOJVKE77Dn3d0/Mqm3N5XgN/jbnJjNMv0pDWs17jw8IDcTZk?=
 =?us-ascii?Q?C8S/yWlZ/utU193nC9uyIiMyjqxdAywbEb+rGcPFafADXfm1KfJja4dyUEOp?=
 =?us-ascii?Q?ku8jLZUoftCrHXN4rehJzDDU5zT6EZ1sMrwIXNPXnD5SpXI7k6Zp9eVPS/EN?=
 =?us-ascii?Q?vF7BwbVOX3LpeG77yG4L/SLTPlgBIOGP4ed0rylh4NqbS9juTwRTwZf+F0k9?=
 =?us-ascii?Q?vMk9atvm2jdt1oqLcNwuZ5YtMOtoivJtcHsD7FrqB1L+OiK+7k9M7728dymb?=
 =?us-ascii?Q?b+poAGW7E1u1uy75f0u4QaHKHMZViHxOk8cLA4Rp58qKVsXnkOBUaXbyOJye?=
 =?us-ascii?Q?AYWypzWxgtwY5nWdvGWoDypijNmp/Iz6pcH5S62A9n+MK3U3vTxJsaP5l9I9?=
 =?us-ascii?Q?j5OQ1bGLi3C6oRcCf/aNbxdAgBhe3ZBn48bwlzcazqZvBDCV9AwcgIKBYsko?=
 =?us-ascii?Q?2x23CUnuS6A5NTMqlXrg0l/HlWfaCIT5H29U3bW9YrWR5VxolvFrI/eFjRhQ?=
 =?us-ascii?Q?FOArODPOEyI7DxLOz4Yo2g7owZBTZ5TP6y0UVgtDnn4efO5rGi63vx0x4uGx?=
 =?us-ascii?Q?LZPqzJV7+fYJaUPCswkp8RMBndbECqlLJVQhMt1C/EGK4RCdljb5jCI+ckr3?=
 =?us-ascii?Q?mkRTxuijV5tjrMx4pghnTHTkK33Irk2kNw4HQNPRCWq0Cs56vgDgxVzNuGAv?=
 =?us-ascii?Q?Slh7QDGTWqRgnmeglRrmTE+afks3iHFHA9CviVYI8xgdUjgNUbzYMTbcCv7w?=
 =?us-ascii?Q?u1XUYmVy7E3Arocb6fnqcE4HIj1GjAwhN5vh4TA8Ufr0rlUmLhbIS0DkSoFe?=
 =?us-ascii?Q?Lyv7B/KW3ZS9LsH1y+XczL1f5ZYJhciumySouNhc2nUw8ukCxlPQ9hEjGFzS?=
 =?us-ascii?Q?QESu3c9320F/khxa4ItFXRhHG0pkaaBg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ZscjUwQ7ocsb+wSvtieN4LhsC5VctYPzjECZmrhVGdBjnN57WqRNFTBMG9b?=
 =?us-ascii?Q?jAilkcxtTKg0WynCwJaYUE4iO56wfvu0D8JllIwMwpYOlDX8vIsy3Dg76qHI?=
 =?us-ascii?Q?T41izEhxHYd5pp53qdGqE8HuPCQpa85ObNlj7IYJcNigNZIuoztkGsjvIcqK?=
 =?us-ascii?Q?Khcwke8FDUfDAa/N1Aq7RqggkmLiBcQZr9TJkC6xS3SXLcjI949nnoKAWHhk?=
 =?us-ascii?Q?bQtcGr35WBjSjVcMddr0PGcyeZC7oESFuoT5gWVetj4e8tb/okEHYAgaM84q?=
 =?us-ascii?Q?xYNo7goCWkwuRVug2AIsxyucBXI4ff5umVSAJD8ZXJhqupwy3yMvvon+2iaI?=
 =?us-ascii?Q?7drdyMV2tC3SDvV3iHV1vhN0iz7RMVFeaprN8SRAXfXHvfti5uDkNzXWTqtw?=
 =?us-ascii?Q?r+slHLegRzIU3bf9M7fau/0y0lfLTdRhEcnzxFh82TtPeY3CGG2QgmwKE7GB?=
 =?us-ascii?Q?zOLHB4cXt0Gsbl+v6+5N9AKFK5Dv2qLVrcEJMyQSAnHZVyhcxV4PeVkHhhSm?=
 =?us-ascii?Q?qhwD2jcCBgJZATWKj4dnwG6OcnqLgremcLNlvwgSdW0mt3Aj0Fbe3TQ9iztV?=
 =?us-ascii?Q?i0ACxdKAhGQt0lrtQM8eqKv50uFCG5HsiuQkajtYdePMM19xuP7JYI0eSazD?=
 =?us-ascii?Q?fkmHACxh8WAZLUVbrH1biOubJYE19ioPR+OmLpKZJ1EpY8ABBz7AiLGEB+4/?=
 =?us-ascii?Q?1MYOSOuqxx/7F228gpQz52Bp5Fe0GgwWxyID7zfeWTT6TxUp6rfuCBhQ2JAk?=
 =?us-ascii?Q?QEjOIUGP36LBwxtvKQd/sO9UEoqwiy4Rg1K9Mmb0DFAFLgg50z9lkwsR+Swy?=
 =?us-ascii?Q?YbgxOAxAHZaAAFrEfrxHxgvyeA+RbuZW47KQkL+r6Nenjt97cAWMi7qeVOke?=
 =?us-ascii?Q?TQD44hdF6ViEXZPRqHHG95++//qwVw5qOJEI0m8uN34oFMR7GyYI6aWRSXyo?=
 =?us-ascii?Q?Q7+JbPP8nXOqIAd6USh4mbYWaFD/RPBsj3vdLd0rBBpqp9muWeKU8T7E7CZM?=
 =?us-ascii?Q?p45te046nsJMuzybM2Oh9cpgmi4BSUQ70jUY+boq73saqguyIvXbdpiPmel6?=
 =?us-ascii?Q?1ax7eGv9eZ2s25RBtwX8tqNY3RZr7nrg5kPLvNURefkfL9TRxzyxaCK8QF4r?=
 =?us-ascii?Q?PTUwLfsC829CV4dt46Y07Zr7MCc8y/5PkI/vnd3AjFE1NcAWTUVWA1jaPPlG?=
 =?us-ascii?Q?xuAof8elAv4/FLryAGbzS58N1dbZwwbM8E8R0w+oajvTp00Fg6GcBt0umgJS?=
 =?us-ascii?Q?WQpLDWxoL109SVeCqtm877v4ZtMN67E8bXWT4ogVOdxvfgeCk7ZG03SqCmuq?=
 =?us-ascii?Q?cQM5ddbysGxrdUFqTx7+feOVdGUgdGyw5Uz6ulzUPLQhPrEdF5kK4QDHfioA?=
 =?us-ascii?Q?owxVFhhiRkwz5F8SEaNEvn0UTef/F4f7HDGo80JxpkSLe/KWXWVfSJDjZdGk?=
 =?us-ascii?Q?RoqQy0paSd1ckJLHPXDRoJFJzss42VmwMYTYgQqZL/16m9Lw5On7DNfolt86?=
 =?us-ascii?Q?g0VSS9KfzM6ky/AvCmjJ5J1spj7syM9WhvceX9vHCkrQScX12RXW5ME9LT8t?=
 =?us-ascii?Q?bd3ZOYdQPWpJRyYV3um1k1U3uHuU/BpOUsk5Y0ef?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1ebf54-4762-41b7-3880-08dd5014af9c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:06:33.6607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7qrfqtxs9mwzlVyHyygoJ3B0tmFO2f5UhMexrWZRFcGgA53llZKTV/U0/CM0EQ6piInyWx0FW+i7H6cmwbMeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777
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

From: Peng Fan <peng.fan@nxp.com>

This patch provides a driver for i.MX Messaging Unit (MU) using the
commom mailbox framework.

This is ported from Linux (v6.12.8) driver
drivers/mailbox/imx-mailbox.c. Its commit SHA is:
39d7d6177f0c ("mailbox: imx: use device name in interrupt name")

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 MAINTAINERS                   |   1 +
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 430 ++++++++++++++++++++++++++++++++++
 4 files changed, 439 insertions(+)
 create mode 100644 drivers/mailbox/imx-mailbox.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 10f7f1fd180..605e3002fea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -313,6 +313,7 @@ F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	common/spl/spl_imx_container.c
 F:	doc/imx/
+F:	drivers/mailbox/imx-mailbox.c
 F:	drivers/serial/serial_mxc.c
 F:	include/imx_container.h
 
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a742..4d9f004ebad 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -21,6 +21,13 @@ config APPLE_MBOX
 	  such as the System Management Controller (SMC) and NVMe and this
 	  driver is required to get that functionality up and running.
 
+config IMX_MU_MBOX
+	bool "Enable i.MX MU MBOX support"
+	depends on DM_MAILBOX
+	help
+	  Enable support for i.MX Messaging Unit for communication with other
+	  processors on the SoC using mailbox interface
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 6072fa1956b..574add60005 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
+obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 00000000000..a33356ea7bd
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mailbox-uclass.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+#include <linux/compat.h>
+
+/* This driver only exposes the status bits to keep with the
+ * polling methodology of u-boot.
+ */
+DECLARE_GLOBAL_DATA_PTR;
+
+#define IMX_MU_CHANS		24
+
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX          = 0, /* Tx */
+	IMX_MU_TYPE_RX          = 1, /* Rx */
+	IMX_MU_TYPE_TXDB        = 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB        = 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST         = 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2     = 5, /* Tx doorbell with S/W ACK */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
+};
+
+struct imx_mu_con_priv {
+	unsigned int		idx;
+	enum imx_mu_chan_type	type;
+	struct mbox_chan	*chan;
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
+};
+
+struct imx_mu {
+	void __iomem *base;
+	const struct imx_mu_dcfg *dcfg;
+	u32 num_tr;
+	u32 num_rr;
+	/* use pointers to channel as a way to reserve channels */
+	struct mbox_chan *channels[IMX_MU_CHANS];
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+};
+
+struct imx_mu_dcfg {
+	int (*tx)(struct imx_mu *plat, struct imx_mu_con_priv *cp, const void *data);
+	int (*rx)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*init)(struct imx_mu *plat);
+	int (*of_xlate)(struct mbox_chan *chan, struct ofnode_phandle_args *args);
+	enum imx_mu_type type;
+	u32	xTR;			/* Transmit Register0 */
+	u32	xRR;			/* Receive Register0 */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+};
+
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
+
+static void imx_mu_write(struct imx_mu *plat, u32 val, u32 offs)
+{
+	iowrite32(val, plat->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu *plat, u32 offs)
+{
+	return ioread32(plat->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu *plat, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	u32 val;
+
+	val = imx_mu_read(plat, plat->dcfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(plat, val, plat->dcfg->xCR[type]);
+
+	return val;
+}
+
+/* check that the channel is open or owned by caller */
+static int imx_mu_check_channel(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	if (plat->channels[chan->id] != NULL) {
+		/* if reserved check that caller owns */
+		if (plat->channels[chan->id] == chan)
+			return 1; /* caller owns the channel */
+
+		return -EACCES;
+	}
+
+	return 0; /* channel empty */
+}
+
+static int imx_mu_chan_request(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp;
+	enum imx_mu_chan_type type;
+	int idx;
+
+	type = chan->id / 4;
+	idx = chan->id % 4;
+
+	if (imx_mu_check_channel(chan) < 0) /* check if channel already in use */
+		return -EPERM;
+
+	plat->channels[chan->id] = chan;
+	chan->con_priv = kcalloc(1, sizeof(struct imx_mu_con_priv), 0);
+	if (!chan->con_priv)
+		return -ENOMEM;
+	cp = chan->con_priv;
+	cp->idx = idx;
+	cp->type = type;
+	cp->chan = chan;
+
+	switch (type) {
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, IMX_MU_xCR_RIEn(plat->dcfg->type, idx), 0);
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, IMX_MU_xCR_GIEn(plat->dcfg->type, idx), 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_free(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) <= 0) /* check that the channel is also not empty */
+		return -EINVAL;
+
+	/* if you own channel and  channel is NOT empty */
+	plat->channels[chan->id] = NULL;
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(plat, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		break;
+	}
+
+	kfree(cp);
+
+	return 0;
+}
+
+static int imx_mu_send(struct mbox_chan *chan, const void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	return plat->dcfg->tx(plat, cp, data);
+}
+
+static int imx_mu_recv(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 ctrl, val;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_RXDB:
+		/* check if GSR[GIRn] bit is set */
+		if (readx_poll_timeout(ioread32, plat->base + plat->dcfg->xSR[IMX_MU_GSR],
+			val, val & BIT(cp->idx), 1000000) < 0)
+			return -EBUSY;
+
+		ctrl = imx_mu_read(plat, plat->dcfg->xCR[IMX_MU_GIER]);
+		val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+		val &= IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		dev_warn(chan->dev, "Unhandled channel type %d\n", cp->type);
+		return -EOPNOTSUPP;
+	};
+
+	if (val == IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx))
+		plat->dcfg->rxdb(plat, cp);
+
+	return 0;
+}
+
+static int imx_mu_of_to_plat(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	plat->base = (struct mu_type *)addr;
+
+	return 0;
+}
+
+static int imx_mu_init_generic(struct imx_mu *plat)
+{
+	unsigned int i;
+	unsigned int val;
+
+	if (plat->num_rr > 4 || plat->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Set default MU configuration */
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(plat, 0, plat->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(plat, val, plat->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < plat->num_rr; i++)
+		imx_mu_read(plat, plat->dcfg->xRR + i * 4);
+
+	return 0;
+}
+
+static int imx_mu_generic_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	enum imx_mu_chan_type type;
+	int idx, cid;
+
+	if (args->args_count != 2) {
+		dev_err(chan->dev, "Invalid argument count %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	type = args->args[0]; /* channel type */
+	idx = args->args[1]; /* index */
+
+	cid = type * 4 + idx;
+	if (cid >= IMX_MU_CHANS) {
+		dev_err(chan->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n",
+			cid, type, idx);
+		return -EINVAL;
+	}
+
+	chan->id = cid;
+
+	return 0;
+}
+
+static int imx_mu_generic_tx(struct imx_mu *plat, struct imx_mu_con_priv *cp,
+			     const void *data)
+{
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(plat, IMX_MU_GCR, IMX_MU_xCR_GIRn(plat->dcfg->type, cp->idx), 0);
+		break;
+	default:
+		dev_warn(cp->chan->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_generic_rxdb(struct imx_mu *plat, struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(plat, IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx),
+		     plat->dcfg->xSR[IMX_MU_GSR]);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V1,
+	.xTR	= 0x0,
+	.xRR	= 0x10,
+	.xSR	= {0x20, 0x20, 0x20, 0x20},
+	.xCR	= {0x24, 0x24, 0x24, 0x24, 0x24},
+};
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct udevice_id ids[] = {
+	{ .compatible = "fsl,imx6sx-mu", .data = (ulong)&imx_mu_cfg_imx6sx },
+	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
+	{ }
+};
+
+int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	return plat->dcfg->of_xlate(chan, args);
+}
+
+struct mbox_ops imx_mu_ops = {
+	.of_xlate = imx_mu_of_xlate,
+	.request  = imx_mu_chan_request,
+	.rfree    = imx_mu_chan_free,
+	.send     = imx_mu_send,
+	.recv     = imx_mu_recv,
+};
+
+static void imx_mu_get_tr_rr(struct imx_mu *plat)
+{
+	u32 val;
+
+	if (plat->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(plat, IMX_MU_V2_PAR_OFF);
+		plat->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		plat->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		plat->num_tr = 4;
+		plat->num_rr = 4;
+	}
+}
+
+static int imx_mu_probe(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	plat->dcfg = (void *)dev_get_driver_data(dev);
+
+	imx_mu_get_tr_rr(plat);
+
+	ret = plat->dcfg->init(plat);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imx_mu) = {
+	.name = "imx-mu",
+	.id = UCLASS_MAILBOX,
+	.of_match = ids,
+	.of_to_plat = imx_mu_of_to_plat,
+	.plat_auto = sizeof(struct imx_mu),
+	.probe = imx_mu_probe,
+	.ops = &imx_mu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.43.0

