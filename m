Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD1CC021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 830BF80F32;
	Tue, 18 Feb 2025 13:08:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T2ITRXHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B786B80F32; Tue, 18 Feb 2025 13:08:08 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFEEC8043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUHPGpNqAsXhHSN+QYEl75RdsTUFs2lXFszANs9pz0MIOD3tTEdpfnEj6HPcHh9QNn9vRzhuj5M/yHvgV+b4oHpfgY29NhI9MWnxYwKdqqsqUP8pNXAAOFdeqdSHutj7L29456xfjx3UZpwbxXbxVzA400v6GlaHJt4Ws5fTcukZOO0cH8cj/QJNerwDIZZbocuBCDNvP/VHTePAPNOaGbiCevzG77KYKHyOLv3MgninHWSKJ1DZ71Di5kdwdA8mn1ACO5KSjDZBpi/UWcEug6E3BxdGXXaN3SjgS/HHxc8MBHrJfMcMssg+OBYVW6eqoL/9AHzmGYzcMJkj76RnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNiWVTWU1quihDXY9rDeSU+njKG6XOHa7mhz4NKwZQI=;
 b=mZ3ceRz1HkOuDgYJQtR5vKvJDlNcoht9Ex9J3LjjreWQwdGCgK8hsgC7l6almMjNyJQo2ulzzaijgd+ftcjrf4EluDlndF8lZQVgGDSbioWfZ+SBxCT4dzvHB44nukRfX5XIcPpK2wer9BT94IQ0XznRXtf49CJI7rhHizCEAbCb2XzFZC9d9EgJOJN9ZbMGgJXHAfOE5W8jjFD54uRDGGp1WB78ixep/ej3S5enZZUjSCUx5gm3jR6Urw0RvH0cd7aGAosaQ5/wZuYnNugHIDk+ktNrWjMg8MNNErMtc0by5gIyfKOLuyUQgkWRKTnjkOrPW+BIcVYbWaIDWOM7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNiWVTWU1quihDXY9rDeSU+njKG6XOHa7mhz4NKwZQI=;
 b=T2ITRXHY1OQOfpdSeoeZlBR9+l7nSemH6LjEuI19lfcatNcOsrxD2pu445W1MDEzaSBiR+d/jhUgQkIwrzpk35wMRKf0xiRHTm571rb3f951b0bgVwY2gh3caj0Bhg9AxInBfyw6hhenEf8du8uSETgvPWO/nCwVSdpAuBuvfu39WsPaUws1rA5PJDxfVux87qsSd729l1m27Qa+d6we5bYjgQ27LLY/RMQNaoxDJV45bxEpNFP69CN0U2CODeY2fjA9IT2VpcSrIf9fchcEbFGu1tghyr0WetEQN7+z8vyzuZdvg2QS+EGX/HxfSZR6c8pXJdxndlVKb2cKSreDSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM7PR04MB7126.eurprd04.prod.outlook.com (2603:10a6:20b:117::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:08:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:08:05 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 09/20] sandbox: add SCMI clock control permissions to
 sandbox
Date: Tue, 18 Feb 2025 20:05:46 +0800
Message-ID: <20250218120559.451678-10-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5a8cd0f-f0cf-4273-edae-08dd5014e650
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pkKl6fFNnZFuQutqzQZ4SvjETR/kA1l6Yx2w+VW/nY9C0ZrSwCNIUC3ds+1C?=
 =?us-ascii?Q?iUmvN+cX3BdSSWHUvccCLNT04VQwAv4gV/mSv3+I/4A77pr/9PJsYMGGbMNa?=
 =?us-ascii?Q?nrvgx4nXCdPe73CFri5ZvkburLXucgRPEnq1OLKe+GQXDYOgD+G3BWzh8gAl?=
 =?us-ascii?Q?9G7hgZs3wmHly3fK34RQQAyfn1dtA1GLjDBJIDz/DTnrqaPvHvcbwuUnbJyv?=
 =?us-ascii?Q?cBK7Fz45rRGqA9LOeE8PfdOB848QTBM6KzhE7aAwJefzv0uwxNQhKpluLjFd?=
 =?us-ascii?Q?rnabICQh3HCgmyHMiED6XYQ/oImyRmNzvVrBrGxm3iGXFq/Ao4dVvoxnEUbl?=
 =?us-ascii?Q?cJPgdNk3noyrJ5Z8+7PDRqx5YFuYN67nkgfGnymY3nF0DTpxE7aXOzbcn5id?=
 =?us-ascii?Q?DQzfmJMZZG/abrFlLgRrKFHnIsCHAsuzkhH17f4Hdo2z/qxMfpqaBiT6MsY+?=
 =?us-ascii?Q?wGBHSI18NCbNlaE3xpIPVJ9iT8VzvOPtlYaUgf4YuO7ppU/iYum2Zj3unV68?=
 =?us-ascii?Q?EQDI8lYR9YBDsXqoMWcMMIgoCS3RGKzAwnRK1IVr8r3kK7S6IFgATkFxMVWt?=
 =?us-ascii?Q?uS02wHSPbxEDbcC/EbpSsrd3i43/1zxMjjDIXG9nqzSE9d4oZH/QgkcLb6bc?=
 =?us-ascii?Q?HhRoHwtIXwFqg4wClqzCnawa4QvmmQ5BZNd2DatW0Nby0Et+Dwe8/MHorNB0?=
 =?us-ascii?Q?WsufcOd/YdoS9ZL6x0r+fZIHXtJ3nCLmC9nsAoWbAzT/VAV9cPOuF5+5dvFC?=
 =?us-ascii?Q?y4wJxQNEWIZYUFcRpdk6gPlmAkGz+RgWH4QBX0NGs2Y9jput6To4uMMx0Hzc?=
 =?us-ascii?Q?b++HhhdbMYSwSVKxtnM8AUBHS1SUblnc4rhm7gM3lGLRcjRxDr0KOpQCerlW?=
 =?us-ascii?Q?8sq0plHqiUSLhR3M0+vSwc5ep3b7LTbuZWOSWh6Sx/i4cJs65Ki5EXmaR8QO?=
 =?us-ascii?Q?JM0qNACNsXF5HadjbPWWDb9YZU5IKoV/v+nb5RebvEgEMJEeSXVEHISOS/hu?=
 =?us-ascii?Q?af08QwHBELTZYYkt+yOfDOZYoqP3YrTd/XuxtvlE9bdh2XmCXigAOHSISRlJ?=
 =?us-ascii?Q?5g+VasG9/AiR6tJkNZ5vOnEGHDYLsyenCeAx8xezWQtwimKIKX7R8qD+I6G/?=
 =?us-ascii?Q?44PVCWr7t/1Y+GS/oZMU8qMbcn9GXHgcmK9ca0slxpT1LwjwXUNrEZDMIi39?=
 =?us-ascii?Q?5FaEG5hnviQF1Og9Qp9SPh/UXsGT5wKCKqn9KnPV5rk4z5g53aTVaonYGLHf?=
 =?us-ascii?Q?Ci3b/OPVfC1KJViLx4myJtBizl/JGmyZjB6kYBHVlM4GCcc6a9FG2CbKwF/j?=
 =?us-ascii?Q?JDrHOafrwsR3k0jRaeBga4dIvGK2Tw66m1Jw8pZfpLrontoREdMkmfawp7IB?=
 =?us-ascii?Q?Fq34uTBu5xHetsZJ3WPdEfXFZP2zahqBQGwEMwMgPj3TmrmVzWmX+JgeTR1F?=
 =?us-ascii?Q?Z+SxeHKVoKFgPZesQTDfj1eN61S34Vc1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WuszS1pTBsJnEKz1fb+aYxWdXmmFofBlW47QzVF2yBDcW15QBQmhJwl5wTvb?=
 =?us-ascii?Q?j9SVu4t3Y9UiIX8PxPlgfA5ZpFUsXWyrUTgKU8qPvemA4vHYpS4sDebPzCbf?=
 =?us-ascii?Q?Wg7Uovc4B11Ho7OEaOZbnFDr7Ox/VX6QYqd/ABndXc/8SyahwFiLjIIDMOgE?=
 =?us-ascii?Q?4PPwPYpDiUpaEg/33KZzBrhVniM96nHzAjh+SdpgFCUP+VSlQe8mGGmGAyRf?=
 =?us-ascii?Q?lm7rGOb9iOTX+qByttOgElWYmpVPEdWEg+lxZ9eDIb0gooLDAQeVC2sGQcT3?=
 =?us-ascii?Q?gEGR1/XdKYC/uKoErRui75ogAhW2rtLYKRmtANvxVj2kKwgvJ0IfOuUAbzzq?=
 =?us-ascii?Q?Wy2JAKGR18JY042zl1pj5nssl+QAseToDKElFsCNY9gvLlqxG3Q8sD5SCIcL?=
 =?us-ascii?Q?YrEN9M59gAnXa8bMWq0aRwKSmD23fM+5Y8EWKMP9q06l4IkIwwxgOn9yQcVm?=
 =?us-ascii?Q?xJUEXpEIp+0MDhNK6o7ca1otulLZItGYKfeOCMhMqOXexfJSFBqFB/e1TvVI?=
 =?us-ascii?Q?lwUOm442ZZr/BVzmeVOvIEm41GYDepm7ZaRNIqJXlETPyRp1tBcqPUfvpRsg?=
 =?us-ascii?Q?Zw02y3INp75ldF6pEUW9a0FzMBvMJdU6CEjvjQRspKrsiVDf/pHXwEGjbB3l?=
 =?us-ascii?Q?rPT2eViA5VvhBxDhJWpSRaxVHThJu1hwDAsTjCMcBPdDzpx0NPLIpZV+8LT3?=
 =?us-ascii?Q?4dbbsLu0k/NFyb/TtN3Eio583nQ3dIY1JxZEg9kikA7AOV/1mn+t71j+zEZa?=
 =?us-ascii?Q?wBqzHFFq6t2ta+FwYIx4xdfhd5Nn83HKG2XlI5B4gh4+koD3PGV9+Cey7cVv?=
 =?us-ascii?Q?2zr5fTX15M7Z00x6X7+U1Yfj3wBfOXBaScpmbTq8SUn2KxYRSO5HFreRKWYD?=
 =?us-ascii?Q?iuDkrCm1ipuxXWwzDmhSah24uT4L3FJ3DaYzMiDAC5lQ6dr2MPaMEYeuXEAC?=
 =?us-ascii?Q?Io6mfMlyJ1vIB+Ql1IL9TSKkLS7PCTCjHJyeUNEYct0QIsqs+SaUD6kzu7ik?=
 =?us-ascii?Q?8/dsWtOtybPedvv56sJxO58zqIMrscNJC0iYv205OXZCERAsY68lZDxYy6Yh?=
 =?us-ascii?Q?u6qZ6TalWMMz3q3fdLNiNXXk7PNQdQSSKxjiiTyOaBDKh4xQZJkrI5qB3Njg?=
 =?us-ascii?Q?2DXhplP3cxn6vUeC87/LLGoni/sGKJ/TOpkvznzOfi4mPZ5m2fE+3iL0mX//?=
 =?us-ascii?Q?RO9hvESdsqlTDXp0lDvTyE9SZ5dmyV4XMgLW9QQ/l5xCKxN4YfdfkKM7CRuS?=
 =?us-ascii?Q?8qJ6yr/tPpoHjLS0E2/ZqI3ZNvskb23sua4yrPtsyFAxal6NP+alFojr2obl?=
 =?us-ascii?Q?9o3hqjzqfnl6ukafuyu0GNNtfJev6R5Pj9w6v5y4Kw7GWJ4Ifs1EO+NjKHl/?=
 =?us-ascii?Q?Gm93Fx7qTkqwhLZMybHbd+qEoMLY4O+efHV6foGQTWdUS3X6cmLJ7Nj1u7QF?=
 =?us-ascii?Q?J1MkFYGwVKggStYhGe3RQmsB9kkkmZ8PWRAnsfVG/djUUb5bb3gJp1v4vGQ8?=
 =?us-ascii?Q?yIKwfmEHSGP+73i4xa51PUIxcOTiiWb2lcWtibqXOQ4gn+S6xB/n0wDMMcsp?=
 =?us-ascii?Q?WwtHD+qw3DChm8tjWUySGkA5iT6f0qHfcPDNUcEv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a8cd0f-f0cf-4273-edae-08dd5014e650
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:08:05.2020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HIf1DejMkc8xSSjruYe9colsA8UUI9N1SGBq2lcwUE6R6U0sjOIRdOQhuVsimsb2nSXCd74SQbKoS6SU0bgRw==
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

From: Alice Guo <alice.guo@oss.nxp.com>

This patch is used to add SCMI clock control permissions to sandbox for
testing.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/sandbox/include/asm/scmi_test.h       |  2 +
 drivers/firmware/scmi/sandbox-scmi_agent.c | 56 ++++++++++++++++++++--
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/include/asm/scmi_test.h b/arch/sandbox/include/asm/scmi_test.h
index 619f8f5098c..b30e536a357 100644
--- a/arch/sandbox/include/asm/scmi_test.h
+++ b/arch/sandbox/include/asm/scmi_test.h
@@ -27,10 +27,12 @@ struct sandbox_scmi_pwd {
  * @id:		Identifier of the clock used in the SCMI protocol
  * @enabled:	Clock state: true if enabled, false if disabled
  * @rate:	Clock rate in Hertz
+ * @perm:	Indicating state/parent/rate permission
  */
 struct sandbox_scmi_clk {
 	bool enabled;
 	ulong rate;
+	u32 perm;
 };
 
 /**
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 19be280ec44..74a87832dcb 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -80,9 +80,9 @@ static struct sandbox_scmi_pwd scmi_pwdom[] = {
 };
 
 static struct sandbox_scmi_clk scmi_clk[] = {
-	{ .rate = 333 },
-	{ .rate = 200 },
-	{ .rate = 1000 },
+	{ .rate = 333, .perm = 0xE0000000 },
+	{ .rate = 200, .perm = 0xE0000000 },
+	{ .rate = 1000, .perm = 0xE0000000 },
 };
 
 static struct sandbox_scmi_reset scmi_reset[] = {
@@ -700,6 +700,21 @@ static int sandbox_scmi_pwd_name_get(struct udevice *dev, struct scmi_msg *msg)
 
 /* Clock Protocol */
 
+static int sandbox_scmi_clock_protocol_version(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_clock_protocol_attribs(struct udevice *dev,
 					       struct scmi_msg *msg)
 {
@@ -740,6 +755,9 @@ static int sandbox_scmi_clock_attribs(struct udevice *dev, struct scmi_msg *msg)
 		if (clk_state->enabled)
 			out->attributes = 1;
 
+		/* Restricted clock */
+		out->attributes |= BIT(1);
+
 		ret = snprintf(out->clock_name, sizeof(out->clock_name),
 			       "clk%u", in->clock_id);
 		assert(ret > 0 && ret < sizeof(out->clock_name));
@@ -837,6 +855,34 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
+					      struct scmi_msg *msg)
+{
+	struct scmi_clk_get_permissions_in *in = NULL;
+	struct scmi_clk_get_permissions_out *out = NULL;
+	struct sandbox_scmi_clk *clk_state = NULL;
+
+	if (!msg->in_msg || msg->in_msg_sz < sizeof(*in) ||
+	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	in = (struct scmi_clk_get_permissions_in *)msg->in_msg;
+	out = (struct scmi_clk_get_permissions_out *)msg->out_msg;
+
+	clk_state = get_scmi_clk_state(in->clock_id);
+	if (!clk_state) {
+		dev_err(dev, "Unexpected clock ID %u\n", in->clock_id);
+
+		out->status = SCMI_NOT_FOUND;
+	} else {
+		out->permissions = clk_state->perm;
+
+		out->status = SCMI_SUCCESS;
+	}
+
+	return 0;
+}
+
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1193,6 +1239,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_PROTOCOL_VERSION:
+			return sandbox_scmi_clock_protocol_version(dev, msg);
 		case SCMI_PROTOCOL_ATTRIBUTES:
 			return sandbox_scmi_clock_protocol_attribs(dev, msg);
 		case SCMI_CLOCK_ATTRIBUTES:
@@ -1203,6 +1251,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_scmi_clock_rate_get(dev, msg);
 		case SCMI_CLOCK_CONFIG_SET:
 			return sandbox_scmi_clock_gate(dev, msg);
+		case SCMI_CLOCK_GET_PERMISSIONS:
+			return sandbox_scmi_clock_permissions_get(dev, msg);
 		default:
 			break;
 		}
-- 
2.43.0

