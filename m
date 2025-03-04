Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B369C282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 06:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D53F80F56;
	Tue,  4 Mar 2025 07:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CLbcQrkp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC2680F92; Tue,  4 Mar 2025 07:58:27 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A2F680786
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 07:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0hWCe4huArm546VV2zZ6d0ToWk8/5iEjYXnZLJ3Oze3+maC1Z56hxIvKtBVWLhO83UDwV64WlcfJylcUenVtL1fPNgwRJqDgs4KZu2F79vQC1ZCq1dyx92hfGGvOlpjupBkk44FZ0zQMDe4PtCi9Fh6bF7gApOo5OQ1zyzMq9JicXNjJr3GXieA9S4jn96lP6AneV5+WjxWmrpQrcMy1iWnU2UHvU9QamT0d9XuD1nLhrTN4AEc2EBANywNnAC2RWYOY6X4vxrpJY0QXxOyeAMe9WyyEt8GC4m5fNS/io41uzzDgmRfkLM099vydGrk99Og2fFZxgFpUKWFVvTG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4JGagtDGrxaudrd8vKf7Ry1qX1bzS3G89+6iyz7XNs=;
 b=eQllWheKJ/qbpKEuK8fe8Zp0z+8vCBh+yf8yCI5MoAtB3lLaKlb922SWkFzF3ikpYUNthOuITeRw81busVm0R8uIUChDqehGZ1X5nA7OuFGVPjLqEq34SS6kMMWQEFakClzvSnXtR+O0XH/TPEg4YnDUDPyk9ra7rhMg8yS0iii4vQobdqHp+eQ+JgoYpzsqaJrGCVLCzQiEExrTx8RFS6uraj+b1DdP+feyk4ZKnDtISoMj9sTsWO18aDR90EfycVKXMFmn4vzrGg7qC9Errp6/CrWZKG1PL5DUoNgexDWdmpkXOV/BLvTpWAn3rsH78coIVgiwialRu7udzr362A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4JGagtDGrxaudrd8vKf7Ry1qX1bzS3G89+6iyz7XNs=;
 b=CLbcQrkphsztQq7yYeixN7LnZ0N11qWFHQJP5JS2uII+ksdlqNH9vOQuFVRypS55m2K3wBI5B9MDe08vTPoaUJ77VHkr4cmxcHnCpAjBY+NSURJTh0nAeXcWeytTiBtxX0PhDh1Fy/L6aubycbXyuXHQYMAU/oiot1fF39ES/0T41ej4OkhGiZF6wpmKpLXA8Nr1za8tHh2iji+ZzU/7MUjpl2njPIy/wKEOeLOmjV2CzpAvBsMDUEcaMEBu88DPx4MK33oOdUREEgz+g9YXLHKMx2urUhpehBJ1K4rPjQNeRhSzaxmKoYtfo+oycQNbCK9XeMc417yx1pnpoz5XZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8248.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 06:58:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Tue, 4 Mar 2025
 06:58:22 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com
Subject: [PATCH v2] mailbox: add i.MX Messaging Unit (MU) driver
Date: Tue,  4 Mar 2025 14:57:40 +0800
Message-ID: <20250304065740.2732356-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 39142c7f-a429-4d0f-4350-08dd5ae9f3f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DD1sn5Df6tA9IbGgCGbPEfb9zVkIyHE+xjKUe2ezE90j9yGYPZWaWim1UQmG?=
 =?us-ascii?Q?7C+N7AQKY8ykW8l1+UEoxoJxGfxCIfBjMkjA8o5CM4RKbKVGX7pZK+q+apTE?=
 =?us-ascii?Q?I/UAwPzxRYmdtb7XiO7qf5N/bekYRf5AjcBmrWjwBb2lPR3bCY3OzDjuOI3C?=
 =?us-ascii?Q?c3osnsFysYfmJud7SdVdzg4xdI7fo9V1f289k1kO6l64Xj6XHCXU6ElAWZv3?=
 =?us-ascii?Q?F/I5ZUTYeTLxOarOsboMtE6RUXV2Q4IWrCjxLYq7/dQAPoDYSemUBYiGGfh6?=
 =?us-ascii?Q?u4FnRgiPHACiQYS6gDYY1YlR4NU2T5b7goPPK/irGgg+6PG0ohvtJnxB5xBQ?=
 =?us-ascii?Q?cZaYmR7hofNiLtuJ9MMRnvjlXzJ8O83tPAeJQIpt5xFJ87pIj4wNto29Yxv2?=
 =?us-ascii?Q?vOejRjGIZTTL6R2GuRIJcBGqy3qKnqUSQXMZIADRvwQsBScpYrLTgMpsamE9?=
 =?us-ascii?Q?4zWiACr4ipGi4VZDTLgBgb68vxesybFu+uzYnhPkT7j9oMWRy3OLw/XMks3t?=
 =?us-ascii?Q?WfWs9wSQRIOwz8TeF+DxCQgiCJXU+A4sPi352G7jfypFxvAEop5BicHIgTC5?=
 =?us-ascii?Q?+SqS2VpUk9Jh7ld9lksWVUlAiE80kkMYtWEKpUksm80yySumtwAbl2ZsGfrY?=
 =?us-ascii?Q?eUMf+xcTQxYMaHKJORwH52oKltCpStWixgdSmGAW42YJZnBV+IPYZOQGzKAh?=
 =?us-ascii?Q?jXbwrOAPhZPwpbWN0ysGSCxOegggpuIT6bFPX70Nx6Lsctl3I2PPF0Vztpmz?=
 =?us-ascii?Q?CwqJZPruGSfL47IDyxI57TVLiWbSvhZjU8mBuAvvlxuiIrmJ6XJMHDdutMIE?=
 =?us-ascii?Q?i2LFQIYNveBXDxlhYuqjoWyiC5fSrzBLZdHDlCy+LVYCkKgALtL5meqgRCuN?=
 =?us-ascii?Q?UQ3/gUHRhbVjc+xcKecD16PkZWfi+Z5/s6yLOyDkGZxAPj0r/1PwdF6OMoJl?=
 =?us-ascii?Q?QeOzXIKZq+bU3os/5VsoutygfIm3iAWkMcZk+R0ORkZFtJwcO493ade4b+Jd?=
 =?us-ascii?Q?ZoaE0xRFvX54++CYfzG/OXmwUlU5FYfDDQaxCbObYj9YG9utDNUARHTL5a/1?=
 =?us-ascii?Q?i5XzADdi5I2lIr0l1xqB3aot1tUNtwNxmUpzPNoNOZ1Cq3KrAAkW6uEVa98j?=
 =?us-ascii?Q?wfsTB90vHOMQhSV/PsQCj8kGSACdAhqIZVefB8GznxhHE2llgH2D7sjGEwH1?=
 =?us-ascii?Q?xzHG1ZVJTeCLTtjpXcGz6v4mhlUG5ke2xmi5SJivkMrwQIk4eM7VssMixAct?=
 =?us-ascii?Q?vxFu5BFaoy27SMnfXqelHLq5Gq0HvdjnYDbtnY2sgStb+qXPrC9SfOIIgUG1?=
 =?us-ascii?Q?Je/456zEBtJD2HOvF27XEnucbXtoOTpZvmmUuA7b3sd+6ZsFr0P3m5dkcpJx?=
 =?us-ascii?Q?aWIMFl0zVdOiQh+OmKqDG8Rbf2hIsWoYnGkCqeDkBYYnYxFHQ9PJXg0hQJFQ?=
 =?us-ascii?Q?j309VwLasLtsujyuf0ycNWQEA2oK7LGM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zlqTdHxE4QG3i8aDfs9jIz2szcH3k8BV6m1Py9sRBR0rmf3ywi2iLzpEJvY8?=
 =?us-ascii?Q?Ws1ECyvL5aMfHsOpkUtiIA0h65BcZ4CRz7Qu8WY0HjHJmwC44rXEUSGhcuzJ?=
 =?us-ascii?Q?PxjJ7VOb7pY9ivuItjvpTkvOOLgfuCxYWmwKmXwvlLKx0k3oGIfiFh+LfIXL?=
 =?us-ascii?Q?SVFPRykicFMNBH5+CSwrNBndYARlYIBKhuyXMl1IRwo78fGkgzpui6FF00AN?=
 =?us-ascii?Q?vVWRxbEBjx6d6kfCzIZ60DMnbrroQYB5flFT9hWpJ+2ajrjfthg+5JgND9gr?=
 =?us-ascii?Q?K4IvaPg992zOwPTGUlPfkJc8j/NfqYE4zHivWU09CiQTwZ1D8xISxyoy5xAB?=
 =?us-ascii?Q?G6jXa1iU3EiYBfqaglFTQdS0I/VwzAf3/+b5rRQqQlcHnqrc1a6x8NgF9uvT?=
 =?us-ascii?Q?OXLNu1ALUw6RswkV8NcW4KqaLMyN/HQ8RikoqXyXFlDlXqQn+cq6VhBmrOeA?=
 =?us-ascii?Q?05BOEEXviY/j48RNsbnmxLl3ntI0JLax+QRQyxqm6zRl9Q/nDV0Vt0rs0YuN?=
 =?us-ascii?Q?alDo7NGbY8bhXhZWDREXd2FxtvGczlkZiQLHg4AafCKeV1ZKPiZUFzepQv7O?=
 =?us-ascii?Q?geIu3RBpD0z0Gb297RrwHZgUhoAaRQg4hdROP/Gt40+QrGY0NiTGoFM3gb/y?=
 =?us-ascii?Q?kQ4dzRXFrfEjULDPNVh0Sl5OxFzJ4dDO5C/ecFoSc+Gfh2p07aRyJAoirS9G?=
 =?us-ascii?Q?I9qregu5qJ6oePcl0DrmUc7NfEVyJXfWAYAJvoF9n/W3Wq4udj9HgeXiUCjb?=
 =?us-ascii?Q?56h9j2NDvVVwJlCE+VryAkRt0NVw6ihfVcPt7HddZ0/7JI9ki18Tlf79KZZ8?=
 =?us-ascii?Q?p7s7sK0XgvtTam4sRmEvJFYBPKDydqbqOqLgTbFiBx1TRhxtzO/O74cBH3Zj?=
 =?us-ascii?Q?nhD8TnYA8SJYOx/ryq5t/FiylNerlG7BPv+7lUDc5U+xUxICwiyciU6o6MsR?=
 =?us-ascii?Q?6txQ2VFTSbGuQN/fDnJA6RS3dw8tsNH+VTwR3YQ2mLt1f0KwsrVRobpizzHx?=
 =?us-ascii?Q?Bg/sGDHAwK12qooqzhh5IOAk7rWgtFHgIyqSmeG6CUDEEKeXpk/pANX6cqfV?=
 =?us-ascii?Q?YZos3vmhjjQvTKDXUsWrpHARbZT6Yt4Kda8rViuizE1ZXNjaynNhXMDXLYvr?=
 =?us-ascii?Q?6dLP/8w5R5HGlrUFKAXkPFpE891GUWn4axEORN+sRq6YYRokyGiOeGygkUKW?=
 =?us-ascii?Q?2Wuhhrt8RSHcPUzzvHQ6E151TgaCf2W9fBgKRP/R2Cn7pHlkJ9DAoAorcLff?=
 =?us-ascii?Q?LxnaGTvsGQufvvvN0cNNql5TsZjd1sayTzivKXXLtNsoQpoSegZ35hxgZ44f?=
 =?us-ascii?Q?edYwunBRv63dB+myp+U/Qw2l7g0xACW9ybd0SJPaih3Ezz5LEYGWxq9YZxpp?=
 =?us-ascii?Q?UBq8fqadvsxsuMjYrgYysS8aw3GqFSTgIOfiuu1pOmV4duqPD+7XtEXgC6oC?=
 =?us-ascii?Q?AgyCxdw+VFd+yz1fnUu/BKxAAb2fD2IhoTGbEMy4hgLl9rJQp69Y5vWcy63X?=
 =?us-ascii?Q?bCn82wo7YgXKEaUJM8cUDVO0+roCtJv2nPJ2jpqA9rrg5X0R4o4Nhw3TEmC1?=
 =?us-ascii?Q?tY7znAUfffQN22dOWjFjBzkep25dWHd7w2NI4EIs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39142c7f-a429-4d0f-4350-08dd5ae9f3f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 06:58:22.6431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1+E3ee7l7Dobt340yp2Y6PDjLhUhms2efE8kT8RZq8IvH7VrVZ2fxldoLig5nwd2O5Ndgm6rOO5GuC+tGlN6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8248
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

Changes for v2:
 - remove support for i.MX8ULP

 MAINTAINERS                   |   1 +
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 443 ++++++++++++++++++++++++++++++++++
 4 files changed, 452 insertions(+)
 create mode 100644 drivers/mailbox/imx-mailbox.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 687262b355..f13629bc87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -315,6 +315,7 @@ F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	common/spl/spl_imx_container.c
 F:	doc/imx/
+F:	drivers/mailbox/imx-mailbox.c
 F:	drivers/serial/serial_mxc.c
 F:	include/imx_container.h
 
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a74..4d9f004eba 100644
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
index 6072fa1956..574add6000 100644
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
index 0000000000..b1e0465e7a
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,443 @@
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
+	if (plat->channels[chan->id]) {
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
+static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V1,
+	.xTR	= 0x20,
+	.xRR	= 0x40,
+	.xSR	= {0x60, 0x60, 0x60, 0x60},
+	.xCR	= {0x64, 0x64, 0x64, 0x64, 0x64},
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
+	{ .compatible = "fsl,imx7ulp-mu", .data = (ulong)&imx_mu_cfg_imx7ulp },
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

