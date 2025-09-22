Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBE2CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 11:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA00E8341A;
	Mon, 22 Sep 2025 13:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="mfcMDgOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E1308341A; Mon, 22 Sep 2025 13:12:26 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CF7833F8
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 13:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiiKzJPU3ZZTNi+yspKsW61750WpKKh7k28pvARwJ+BBbuS72rkZGGYET2OPwokZjaY0wmh9/cxW4YOLFrhwd8a3beGIe67XwP1h289SZFgiid6gDuzqb3uWhvyyRpkD577s68+DTuaznBUejGKsYK28jzn3AF9iAYPrvzQlqBg/8TXjDC0gtss7BHFHBaA7RW/n3SjexDP8Z62W0Pg7LTTq+gXD66pc3G4MovdwgPkCPCFkgYPux7aJytJNbAX6VN3J21VMISt7dpkS7+WT78cK7hQglZkkM6Wyu2o6DpkdKoPMyiyKbUn0/IU6SO1fjifYOXJjztsgxFMjvgaelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6XN/1EoFGeEEDGl0IVyteEj/mq+/yZK9gMa0TWdk3w=;
 b=m9czSjDxpTtOb+/O5OpbtlWndOZJVsdljiV0D1cbiKkMaJeW8g8HvVyJeCqPtOTBcqQjjIx3jQ4tsZW+2zBCGn0yTood3Yklc3jdZazZbJJIm1ThNEqlBbipEszSk2GcrE4uKArXYZyAuz8M2QrhUtpKOhhiLPnexwVCzvfp49hyUEkF3KQO1Drn4BO7IQFLwC100j88CndbQY972lohVd7XJsctMZBjIASxQ1BpRHCRshJrXaQWHAAb6qZC1f40Y5kTJy0Ker2cyrshr4Wgkf/DjXUkUSkFJLj8kMwttPi0cEUH1fmvNWrxJSwKkEh5dLeUxmchlPA6RNcg83OR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6XN/1EoFGeEEDGl0IVyteEj/mq+/yZK9gMa0TWdk3w=;
 b=mfcMDgOA+Ol73dllWzDRSXZfnJLqA9VPCTgtiPI+4v/GNuV9cuFJEmmySmviDS0CLgL8oYB3HyctzZEsGYmfXwZvwqsDYanle7ejcjJl++TyD60Xgpu28nBlNVBTcqVCWx4M1ZN1S90/oGSQyw/zdXRmh7CHHGODXwn+9wQ0Ue81sgO02Y5VGDKy8ENSGTbWxZ/5yDw2P8GaM+l9qqq2h7LKd5wQBZUAhE53uJuaJ4urSqnuKWF4R+oQXeFltwVNWHQC6h98LELfu41w2oLvkbADGzvAPCnqbPo9R5KIf0DhGYI5oJhOZbPnC2vzufLDB3NCb/pczVk8wrPr4eUVpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI0PR04MB10735.eurprd04.prod.outlook.com (2603:10a6:800:269::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 11:12:22 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 11:12:21 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	jagan@amarulasolutions.com,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH 3/4] spi: nxp_fspi: Support i.MX8DXL flexspi
Date: Mon, 22 Sep 2025 19:11:42 +0800
Message-Id: <20250922111143.1204915-3-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250922111143.1204915-1-ye.li@nxp.com>
References: <20250922111143.1204915-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI0PR04MB10735:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d70efe-0a90-4687-b0b8-08ddf9c8e6a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vBAmjBulDdgos257vZI1dCSEFs0NR+mH/pqgJVioWPOX75qLeAsr5sIG7ZqT?=
 =?us-ascii?Q?ibTjyPUywYuaA5CcYTyb+fkQbm/56Mw3NZJaBnvgnIIfOQATTtDKvyxL3HMV?=
 =?us-ascii?Q?e62to8M07RDRw2yo0pmIL4+rBq2jWzo2WCERqCaNw/Dj5/MGxkPoXSlUXU/A?=
 =?us-ascii?Q?HRtMWVJDYc4K4an6bGEksuI2zSMSIiICiE+lIA7BRogbPKr+WzTxyNPWcFZ3?=
 =?us-ascii?Q?QO5PEvixnzDY3AvOR7wNaYCehx410dFOncphr86x+Zd0R/0EpI7BWiPYQney?=
 =?us-ascii?Q?58jiZdlYewdZdJemLhwS/iJSJVMQUS/55L7q5lCciTYuODKztMKXJk9t/vBr?=
 =?us-ascii?Q?PEKTbQUqob85/AnBKsl0evxyqXdDtsNjORXqELojeVBh3tIOKuZeRapwovCl?=
 =?us-ascii?Q?FIPJoR+Yry/C+Izc9c9ECbYuGK0++0T9FlonQ42NiTdUc0q3RdTeMIvkTK+w?=
 =?us-ascii?Q?6t5+Jt2hpqaTPS4U6XKRtBKNHeJCwFiMNIcnE2aIx+af0KDPcz/Hen9FuSxJ?=
 =?us-ascii?Q?HHFMYEValgKP/kqWCCFS5VY5d7ZwrVJxy02GACZuCDoFFckH9kNPlInsvb9N?=
 =?us-ascii?Q?M80xu0gdwf/pLGR3OI0+TRJ/g9GKUbedSlpbQMkoLvIYllQEys6Rg/597Igz?=
 =?us-ascii?Q?zewjHHGb962/n8vW1tE0Zd8/tpTXvgWRR+oN9wU0EfzMuhOgu2e/jC9ttd6d?=
 =?us-ascii?Q?5Uq5fj/LbjafxPazatNUtb3JahZ/8fZcFWVvAZaV2iL+ntHYw9ERHmI487nf?=
 =?us-ascii?Q?yTDJiP8HgAubq1EDLLYThp9PG7qU0hoVRChMF1wDskp4naippVd7FLi0G7YM?=
 =?us-ascii?Q?wHcapI2IH+BtLE1P1sZ+lEX+Gm/+gjK/ulURmGf/+4Tm0KufYjXKfrrU/7dO?=
 =?us-ascii?Q?CSpoUKD50isHAsmKZR2y67g98AX08qeLJyDaUp0z6/eC/8/a6PdmTmZLHXOJ?=
 =?us-ascii?Q?i7Y5WdTGllQcjsfA3iEhGXn9wYUhk+dWhZmp8ohW9DDetU7cNkkp6YDC841u?=
 =?us-ascii?Q?ZLODNGeQmw8xY3WbYs+ShO03oX13plyxLcq0h8GmcMfbrveNYu0LT1tgNQE+?=
 =?us-ascii?Q?gkpCkLYCE9WTdoF5hnpiGKi0w5jaKAC7lgNS55DmXVix4j7bf1W78LZlqM+7?=
 =?us-ascii?Q?cb83bvwds5Hht1W/XQiegeXU6fbeB+rQan8Fxapw387RBjq1+R1F2GxfJfpl?=
 =?us-ascii?Q?OOaO/iyohq9Z15sPPpZjyMWyzz7thoKd/r1TR/wbk/iP7TLVnEXs/CUK+0pe?=
 =?us-ascii?Q?W6KymFHKjP5wbpQv0SuynbLNjcN9Z3HQp5ORsKmYo9einxxN9E6IMrjt7HUh?=
 =?us-ascii?Q?uNQpD9S8wiPykv4LlPUTUADZxKd7ZH6YM7JMpoGa3tx4DlBJJsBkNZ5o6o/P?=
 =?us-ascii?Q?h2MawoD17PkFh8zTEx5FF5HM3bcaJxY7yC4cA8A3pW6G29NJO4Mhg+9qkCY+?=
 =?us-ascii?Q?31oL6ProF4NNauPV59Z9F6XM7+BdB6/ND0UJrxdURbm3fWjQlAUxAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W3uHstl5kogbdZv8uj3QsZtpcOngISqqG+fYWxw4qIQ/skITcPdgEnbuNEVz?=
 =?us-ascii?Q?0EjDcyN7qY0AWqbeD8IrEzxGfQoG3ikYA4ugWbiyPUwqFreSoRS3AlFkDTrQ?=
 =?us-ascii?Q?A6IcNOrUlrXC3i4phiqvLh/6rrofeAFmI60D0LZv+Ama+R8ge5/DEfu3zDuL?=
 =?us-ascii?Q?iJUqynWX4XvIWwpVlkOjMbnAyeKfVoDH/jZwf8u55gT9GyFf/a+2FKjQYlil?=
 =?us-ascii?Q?WyaKCYEVTovZhbf4JfFElV0/GFYSs8Xm9CASvr27C7jQP/KbcqgubZC5iUG7?=
 =?us-ascii?Q?qH1w2L5p3BtNP4+xTzcsZp9zTpCHDrnC5QEeyowedWVwUpXm/DNUA3se1+Ll?=
 =?us-ascii?Q?baR9awhlv18NQSty+56L6PJpnum8b2vrjXvwmtECCBdLbn8mjFVZf+MQ/8x2?=
 =?us-ascii?Q?qJCGAML0wJhM3mXd5gtfMwiZJDlbNRwS1bjkabE/OL7BSHoijArkCQnYkYsV?=
 =?us-ascii?Q?tc1PdosPcrZVuEbYDEx2Fd6b9CM1M+3SEicxS1Jj/MoeSOQJYBJCYyC0jfZd?=
 =?us-ascii?Q?E97kvVQngtxTTDy8oKGF74ao4AO8klbQ0+5Bjk4sSaMUqOcNfw07sk1faWa/?=
 =?us-ascii?Q?9yNjhCN9ua5ZNWgUVd4/cPMW4HDKEyEN7BocTGCsM+MdUj75QlZhOo6e6rSE?=
 =?us-ascii?Q?9cHMiNhjZnKQSgouyn8u1V2XUwGqbVOLhNTDpXk74wpDWb7GdhvAo0NAwk73?=
 =?us-ascii?Q?TSw1lRXESSe5k6pfLE47RYfmzE0cFQ9uPn/HeJwBjQ5uKQSMlA6Qjuw2r2z/?=
 =?us-ascii?Q?E7CrwoUIUCFAK6hG8v5ocUweTfInYgeo+K+mvOLt3zNn/vNe1ohKFoq5bdXa?=
 =?us-ascii?Q?e77jms42IKMBtUi16q25+aWsqnNOZtbVZpnX4Hvt//pxvZyXY+Xuc2oTnhDM?=
 =?us-ascii?Q?3eE8CNXWsn6SSLPKE4i86OJVzELdM+9nGCuZfL/TqsKbkVntPKnP+dFJj9Y+?=
 =?us-ascii?Q?ksazVdsyqaStrBHU+8jA1+euXaoce2Vt4qYiMXGv1pnAsurrl/vOZY7kpTwd?=
 =?us-ascii?Q?kmzQFBYaxsskg9Qlr4y4m6ILks+1Nbz93+3iZ1XU6nYhGiNaXC84XVkavuU0?=
 =?us-ascii?Q?Q0RHnGXK9iF/jPn85VmTj6Sjj5WR2kzSRMaXQVYJZxViwzRTx+c7vWLi84U/?=
 =?us-ascii?Q?OelWTPhQRzSzDeI2fHebQAQ4pk/u/DVYwnbqUdf4nOJ0FSiGh1YqHcOygR29?=
 =?us-ascii?Q?mcXXmugh0jx/p5esKGCynAyYUj3XyI2uHzbXZ/HYswVKTCZFnWewt+2FeIf0?=
 =?us-ascii?Q?dgMa4loGmefhERMvUyy0M/2zdJKhLO1NwPYAMRkIeeZRWBBq/gpyjRI3l8ZC?=
 =?us-ascii?Q?2QIjxGNDDWusfseN6oGMcxj29IhyAI4R3FSNbkpjnCxwkNLlC1Fg+03yKgPc?=
 =?us-ascii?Q?RPE9WxmlkcZBf/MBD55DlpPgvutys5g5aaNZQeqFPT5KGN28f8QPkoG1A0Z5?=
 =?us-ascii?Q?2JLIVGpB2u2QSg6zzMms7bjyKBm2WxA+d29Vegdf6gO3LSj3fyr/ecf1LzAZ?=
 =?us-ascii?Q?xicQJKusf4tJS1lHMckdFR/QKnNaSa9ZUd3Lp7StbOkxKyCaiiA9hKzXCWd7?=
 =?us-ascii?Q?nts+8xVzFfr2tcNWfvk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d70efe-0a90-4687-b0b8-08ddf9c8e6a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:12:21.8652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6SDk68o2eyuYOh7JZaelHrisStF+pAT8LjTkkBklSPkVRMJVMI75iRs9lFg529Ow
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10735
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

Due to a errata on i.MX8DXL flexspi, we can't use AHB read, only can
read data from FIFO.
Add the compatible string for 8DXL and use a flag for the IPS read.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/spi/nxp_fspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 2a0c1959f387..97751fac025b 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -346,6 +346,15 @@ static const struct nxp_fspi_devtype_data imx8qxp_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
+static const struct nxp_fspi_devtype_data imx8dxl_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = FSPI_QUIRK_USE_IP_ONLY,
+	.lut_num = 32,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	struct udevice *dev;
 	void __iomem *iobase;
@@ -1091,6 +1100,7 @@ static const struct udevice_id nxp_fspi_ids[] = {
 	{ .compatible = "nxp,imx8mm-fspi", .data = (ulong)&imx8mm_data, },
 	{ .compatible = "nxp,imx8mp-fspi", .data = (ulong)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (ulong)&imx8qxp_data, },
+	{ .compatible = "nxp,imx8dxl-fspi", .data = (ulong)&imx8dxl_data, },
 	{ .compatible = "nxp,imxrt1170-fspi", .data = (ulong)&imxrt1170_data, },
 	{ }
 };
-- 
2.7.4

