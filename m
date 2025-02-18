Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ABCC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D86A80F56;
	Tue, 18 Feb 2025 13:08:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dzlzrCXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A77D80F85; Tue, 18 Feb 2025 13:08:04 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFAF88043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvpWLmhF9cd8sMchbVugXM3kyzfNp634taTsXxUzJSZo5f1O1zvgiSJf8K9F8k6NoPyXNUaHRfVMmQwfMxVOJQMvokaRUgR+qTRgLi+G2dlHHTaS8B34Yjd5t1uD/sESmHkbRsbtio+KlIkpNaatITJ60/oOF3s7afTkvRg1plwn8Sso4N1RUsFRE8IKJ0U/Wtag693jZaqbZ6Bk2vJT64LZPxOHKrPQNI3duDzoBQBXNXBkQQ94v9QlKgIBF772NWfTJ3ge5If/myuxlrts0Iuyt5YTFt4dZXm5athnx8zyNHG1J2vyH6I8AkR+u+tbQfGqiRttzUanO7SJQe5ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGfho7WgwoXxANG6pPypodoGpSQFSIaUnuy/StX3fFw=;
 b=TYzJUsjApb3DaE64eGT46s/mSYWN3eDK4UewqxR0XY3PYFhqjDbdzISc8h1omwCNfGadKpggt8/9lld3ZF83cL2Uev/cgQMu8IZVnWMluO2FyG2VYCWdnk8hUA1hDlTC4s6Ppub4PTELm5IjC1H5HSMQ3oPZ3HV6cRdRUfv6uHtEQWgwZ4hYn52rWycyYwd95FnAS4ANo532LZuqBRfA8wmXOerQK6vJ05JZzXckaMau+Ux1ncRcncqMehR/D/l6ti2+edWtqYt+GHMy9WOX6q8xVCk9kWPAOAi8jWl40Ng7mJR0GtC1nn+vQTsblw8I9wMmN96IYONG88oCjLPj5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGfho7WgwoXxANG6pPypodoGpSQFSIaUnuy/StX3fFw=;
 b=dzlzrCXPbqellUBc70+KnjM5XTtqCn86n/EGf7vgLJKevjhPaEZD0xjs6opodFWJHMpQuTkC+O93XC5rIlpVhOLllBRfq9ektUC6wgUhGkPQQmvVjTAT4TnmWX+G6w4iVskFQCGvUaywOzY/mi0TuYcvVHELEQtzAAfMf2HEjG1Fl/ggffeH4+MqNwEAne0GgDRFoPmVoZxgBN9j0/dzr/3/wtWf5szi6XY3puJDdPcYM9T6Kze+QP2a+Jr6vy2W36i9SE6WhY+iI89Ly5qQnxo9Ghrk2Nd01BTMUTaa5/JUsvf+MGTDJ4cKkgshVkpkYJdDuP1Qk/cBZWg5dADNpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM7PR04MB7126.eurprd04.prod.outlook.com (2603:10a6:20b:117::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:08:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:08:00 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 08/20] clk: scmi: check the clock state/parent/rate control
 permissions
Date: Tue, 18 Feb 2025 20:05:45 +0800
Message-ID: <20250218120559.451678-9-alice.guo@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM7PR04MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 0346e446-d676-48e6-8769-08dd5014e34b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mUbChxvlEmcZANK3GVt7Y9TveF6Sju8iAbswgxQ2uekpWeTl98kzujvE99I1?=
 =?us-ascii?Q?jvKQ2LrUZoK2KXh6leAGwR58VM0ouJYE4Y98BYpkrRmX+RFAqJeJuWsmSWXY?=
 =?us-ascii?Q?3vshFppwt195IFbY3yk876uEwCa/OQ9r4YhAW+lkZKGbRUDJSTB8GsPt09w4?=
 =?us-ascii?Q?cO49PdpO3oSj5LabJctZ+jbJTsZP89HPwDA8Se369qEXfi4zzfDuisxc8ev2?=
 =?us-ascii?Q?VeKOA8z4evis5ObwezBH5exWRQf6wKK6bHd8vZVx56Y+XXMH720YjcW7Niy5?=
 =?us-ascii?Q?csSjb3JaJibQwp52Rkz9SqbciepmsB40tGil8BEbWxOw3NurxdwZzefDhHCZ?=
 =?us-ascii?Q?7UGEKHC58F+cNpEcWKYlFQPWFOJ5k+LvN93V2OKBmOVOSo6tz2ANj2KEqe9h?=
 =?us-ascii?Q?oXENRIM0zLl+avnRDEhWwhWHuzboHNQFHT0xj+qIN8Hin1wacUotVpPffrTc?=
 =?us-ascii?Q?rmz+m0n9aEWZupFi0DXPIEXyxqGa44CPuG0gCgaqfP7XC2jnKS4nzLWP7/9X?=
 =?us-ascii?Q?RWxSpgo2t/R2kPvF1mcWy14Z3CANvemj+xx52KNyYcktfyQPmoeOpSz2799/?=
 =?us-ascii?Q?KxmMMQuo6koZglEYFn3CfJUcxo9LIgVlAW7/wr68X4akK+KVcRUoYfwvRj7W?=
 =?us-ascii?Q?jG+ORFx6kNPKl0Y9QZTB5P5k+GnIFMRASqRo+VupEqm7QrOwlOpvEPpoyW+I?=
 =?us-ascii?Q?QW8FSlWMf0ss8dhd6pibnN0YOpSzw5C83JwOnfvInmIjh/uD/8DdVlNvm8q4?=
 =?us-ascii?Q?T6mFigOWkHBvMArIC3Ta5lxGPdjxChzwX7BCbjAniTqusKuO3ZjOJF/JVUG6?=
 =?us-ascii?Q?xqbarPBIRrbEAukWuM5DNAJCcn+pugkvN388gXZYvhPc6fu11KuyfbZPgco/?=
 =?us-ascii?Q?vPkgK6eNTgB3saSSHLma76GLwrQqpvbDL3N6CDiN3RNgf8qA8mLKfSw2cnDE?=
 =?us-ascii?Q?5LV3wzSQK+9qIJIuVmtSfaYS9CRYW8M6KltVOr7EfiFvUSKGVJ6pWsYcl4DP?=
 =?us-ascii?Q?J+1P1I/hgE6kTpvbPpPsK958oMnpCPEGojod05lhNzRKcAr/CYj8i8dY2HjG?=
 =?us-ascii?Q?dMhzi9dCJkYuMBUNQg7pBQK7icToCodhl/zZA1BGvo6D6m4n77TsYdiLsFT6?=
 =?us-ascii?Q?VlS8FZieSsVROUXP/eDUeHA1MXNWZjYpMVIbQvm8n7Z7B1TV1tcD9XP9SMIm?=
 =?us-ascii?Q?BGLJqdNP7/ZJd84tebYEl2y7gGfajhCTQJaxIOqgY11NC6C/sa+5FY3WGbqY?=
 =?us-ascii?Q?nHdHl/NEStT2BAmzFqsXTCP7P3NVVWOcE6Dl4krJFGZN7mLckvDM2Jzy7PSy?=
 =?us-ascii?Q?1DPIKJUOvAUzE5bNNVoKZOetT5Do5EeYwEmrZcJP+TaRe+Vd1MG333ZpfYwg?=
 =?us-ascii?Q?6qjp99RuJ79K2SfGuJLUrXVvkO0Ez1jlCWDz/42nDo398NhOXo+5YkEoaz1d?=
 =?us-ascii?Q?YyPVNXfy9yXuc7j8bpX9LFxwMHV9252s?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6edJvNx575f/zjMhjhoHiE4xSc5ovcRAtCcboU0e5lr+Ga+gu1GmSXgBAUAZ?=
 =?us-ascii?Q?DwylBmZaQEE7jI5lmVrJvJa6V4C/tH/0N1kKEs7d7s85y9Gc1SmH7bbQ5tKQ?=
 =?us-ascii?Q?CCy1nVDNL9wDw9a98zHrOKLZygpKjU8dF+IEsyZLRtrBuX8zJjyELjrL1vRs?=
 =?us-ascii?Q?iYk/2z3SDQpGjgdSYi9s8sEIsWAIsKUxjehB2eavCR2gDPk+CH+fQ0irFvwm?=
 =?us-ascii?Q?lzAhpdeNYuLAWZiZ2lXBeSq9Tq5U6t5pews/9Zc1TvQ1uZ2+nrgkv4qLpSn/?=
 =?us-ascii?Q?igbjBYt7Bkm9KEFZD0c+wfcaFs8z3wPGOyPBEJycO9H9U8l0J1VvxGMPpGn4?=
 =?us-ascii?Q?6FcRJGC3vFYxax1/hxmAg527wqH5Y8TXWj7Ajg0KE/0wOYRZcZbnbn+rdde7?=
 =?us-ascii?Q?Dn41mCaxKnW+lqZT/Uo4gb9vEQyUZtT8uZRxznG0V3yfL3rP/O79WRfn18x9?=
 =?us-ascii?Q?MMjyAndteRLPa79PXQGuC+weKN1HN6jK/LrsPAA4WO1mYAZn9P9gxATMmUOI?=
 =?us-ascii?Q?axijj12sy7mjyovgHyOwoIqA29PVOpdbFbw+tXi0Z/BTnRyg91+GuwHKw8Kp?=
 =?us-ascii?Q?3q1NbY+cdVu4hch4iI4Zxxi2RqHdkRQ6wKvzyCVPPspULWz5Oe6BLPzq8dMa?=
 =?us-ascii?Q?CGyzvK6ut8dmDoR2iDrnS23BeyIWad1cnb8XZxaQUziHWwzp+HU23lxgJrOY?=
 =?us-ascii?Q?wqPz1l2I+2kCU73i+IUi96Vb9ppG+NfLAzqnpieG+tKP++taTbgW8J8GEBXF?=
 =?us-ascii?Q?ycv5Ok3FR2CbrTob3TbCGks1/itUN7x+1oe1drJZ4wamR8sb43bp9bjYdfnv?=
 =?us-ascii?Q?1g7UeOAchIDOsq7YouTq6OpRCGi/CXCeEa41UAx96LhDFCoeuHOn65CaDQsi?=
 =?us-ascii?Q?4ir/pSR1RQxmjtLW1uqvxTXsxi8PNyAKCkTWvnBgtSO0dQqRFWfpeWt9iZ8E?=
 =?us-ascii?Q?VHpElAu4jhLqAQni4tTBLR+caorAykXbGyaqYe92YCBYjG9tVdRdI8ToaTJO?=
 =?us-ascii?Q?1tjbL/1J9bCbVDgcSregycr3EfZfkQT0mbQjMyWYOStuX1z919KTSQXCij6M?=
 =?us-ascii?Q?HZeVxcLVvIdGQSGH6hYKPqP3XqHGH0MrwR6DUl+CiDrMZ+ltd3aLY2moau4U?=
 =?us-ascii?Q?KQDW+WnbLRkSppCEXOTM3O8calZJm4/Ko32Q78zZFbevCbYk7aim6fGuS0l4?=
 =?us-ascii?Q?hH9Goq/CJPmyhAjHr51VyWTOjQnENKjmcb7vyIRHABo3CtQHW0/nacAjFsfh?=
 =?us-ascii?Q?+X20fM7ZfvjD+rOKI2PS55/+fbnywLG2FDjIjtF+dDSt1AIlaIiprC8so2eh?=
 =?us-ascii?Q?ztMylYWP/KiL9MROPco10KFV4FHT2djVe+aJ1U/o7PiUBWcXbzYlZwjhp5/X?=
 =?us-ascii?Q?ZNHq2v46GARbdQG81flf+A+P8Ge9I29PgVKIb4loIujUgFOEvNu5BixwlHtd?=
 =?us-ascii?Q?Ct8Z1fL6DLVAN7oQT6vMCeRUHJEET0H6Cz+UP6EDjsRZIBLcVEXx4m8RG/3e?=
 =?us-ascii?Q?QC5d6wI2VHZVJbWOxUQ0lpbf84A9OQgG3kQSTi5qtn98T8fGQVZitOtHpsIm?=
 =?us-ascii?Q?z7U82fyiclQ7ypqvkg5VroEFYDq2mqWM6gJPDdj0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0346e446-d676-48e6-8769-08dd5014e34b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:08:00.2554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05ia0jnF5lx4OIl2LEQBqfeqetTQcOV2TqYKqjGndtAKrOSDMIYalbWlRUsZJdWNTp7uUs83+3HXiOD58zW4iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7126
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

From: Alice Guo <alice.guo@nxp.com>

Clock driver based on SCMI clock management protocol in Linux checks
clock state, parent and rate control permissions. To be consistent with
the kernel driver, add this check here.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c   | 172 ++++++++++++++++++++++++++++++++++++---
 include/scmi_protocols.h |  26 +++++-
 2 files changed, 187 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 84333cdd0cc..4fce92d064f 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -12,6 +12,56 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	u32 version;
+	int ret;
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
+	if (ret) {
+		debug("get SCMI clock management protocol version failed\n");
+		return ret;
+	}
+
+	if (version < CLOCK_PROTOCOL_VERSION_3_0) {
+		debug("SCMI clock management protocol version is less than 3.0.\n");
+		return -EINVAL;
+	}
+
+	struct scmi_clk_get_permissions_in in = {
+		.clock_id = clkid,
+	};
+	struct scmi_clk_get_permissions_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+		.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret) {
+		debug("get SCMI clock management protocol permissions failed\n");
+		return ret;
+	}
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0) {
+		debug("the status code of getting permissions: %d\n", ret);
+		return ret;
+	}
+
+	*perm = out.permissions;
+	return 0;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -32,7 +82,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -53,6 +104,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -78,11 +130,49 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 1);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be enabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 1);
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 0);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be disabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 0);
 }
 
@@ -108,7 +198,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -133,9 +223,33 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+			return __scmi_clk_set_rate(clk, rate);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock rate cannot be changed by the agent.\n");
+		return 0;
+	}
+
+	return __scmi_clk_set_rate(clk, rate);
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
 	size_t num_clocks, i;
 	int ret;
 
@@ -156,29 +270,44 @@ static int scmi_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
+				free(&attributes);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -197,6 +326,29 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return -ENOTSUPP;
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+		return __scmi_clk_set_parent(clk, parent);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	debug("SCMI CLOCK: the clock's parent cannot be changed by the agent.\n");
+	return 0;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 0d8c177025c..2684f4177dd 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,13 +731,15 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
-	SCMI_CLOCK_PARENT_SET = 0xD
+	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero.
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */
-- 
2.43.0

