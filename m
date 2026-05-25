Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B20CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C3F8465D;
	Mon, 25 May 2026 04:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ThRVQXMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674AE846CA; Mon, 25 May 2026 04:44:08 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C7A8841D7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zdgge2ta0bI4SHWYarUnLz/LYGRhq90lzPl8vgjoTBUJXMX5GzLQXE7juZTT3jyN1vjoKCHjDyla/i46iAjcwFF/Z2xZbfLzPkG8UHJbePpKqxs2Jnuj/vFOaBN7X8hI9drGmmNE4sKcW0w+LoRUDoVCobtvp+uIE4ugWB0D5eDajzg7nz7cDq6f9u5fi6mGusJY22g7n7rikjqgOu3LyMsqdYnMlVG12obIittiwbgHq0BxV2527ORhFYY5gRm6xAdZz2KltLCe+ZOxMN1eVOFMj+mT+URoNLGcAoQtdqQxwboWSeuqGH0TH9gvuo6MGZEXiOnD7qyxR+Rm6+OOjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGCkhJpVtlOpgKBaw+WalIVjAC9XJiz1koV6EDege/Y=;
 b=QrbmA9cg43c9PGyLPIuB9Mi7ADYUdnMuJDLJLDta2RieDx8gr6BMhm+UT5sAQZXrT6a/+lEVJXrq6EKhsrljNTDK3Akdetps+zl7+257zyj5V57qOwDVSzf1fuAjm88UKjFgJbkizpnvmYUxBm4PGTySvNJtrqTCo4brwZERn80wdRCjdECHFH7W4Xc4ZEFwCqcdpQhgK6jDW2JJIrgf7NiHOmYflC5fGuVOPMWU3uzpD5F+jb+HduCzh9dr76bWUbZtoo7TyfYJQHad4cER6CLAXfMYuJtDfuaIq7Htc1SkGrqQkj5ZQ7YxrPmtX4mZRyosTLp8pt1ynV4QLYDBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGCkhJpVtlOpgKBaw+WalIVjAC9XJiz1koV6EDege/Y=;
 b=ThRVQXMH+9d6CjKVOO4r8CsZdMYtVDBTYoJ/uFJEcDKg2pnTgdWUhflm4Na8q1kq2VXork7NsnxNxjym1qFyHftfUvzT7xjU4jRAWSQBvaYGb8N2SfMKIaAowfM8a48vHn3N42ZCcU6BgG1svudFE2c7D/txMEZ75ShGYtU5G0fJurWWlAs/snIr+owwMfQi8aGMWPLdpk6iY5lBbnoa3vW1V0CixmuD0Dmi6DvpIS57W8zxmgmzAF4/L8qoTX8tyDnr/HP90sPFeYODdg4cPDJ2GoeExIRryC23F5/K2MvxOT40387FhSzdSXLtXoB/HYoai7SLm8h0nNTrusbztA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB12113.eurprd04.prod.outlook.com (2603:10a6:800:314::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Mon, 25 May
 2026 02:44:02 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:44:02 +0000
From: peng.fan@nxp.com
To: stefan_b@posteo.net,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] pinctrl: at91: Use dev_read_addr_index()
Date: Mon, 25 May 2026 12:00:32 +0800
Message-ID: <20260525040033.2367042-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::11) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB12113:EE_
X-MS-Office365-Filtering-Correlation-Id: 793bce5f-a30d-459f-40f0-08deba077ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|18002099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: O5jcyP1JZ1rETLhD1woYmtEQ5MGZZW/+0oeUO4muAD95yrLngyFWNGJ+/LQ7o+odT9B3xAXtWFW1Y4MQqpRADImeJKhtIUO4wTgcmKgN1aincYzjGkyjAlhC35mMcMQwtmOVGE0g+3Q90nKjYeUFebHn6bSN6DQPfu+63zhfAzKRxitB+5lNLrcBjq/avVdKuH2M5M6gZH4twQdDjFkotYNFvFm6hvlFJcR/7MzD7+OHY8pYCEy3uMLPxi1AvxauHkFLP4jrBdEPYxvxq6CkjOt5I6abVLx1vLkP7v3SsKMc7Nx8qQ9lwebT77NAz9OIwia72Z7e9p/UUsPbaCSajOA1JxoH07cb3KuzX3s3U/WbNAABx5zG1+ZvtVlKgwukGUklok8RQHGlRup4NSZoMFsBkgBecpeRC98uRS1t1NSlMoIt/Tjx6kwHXeSiGLZKSqzp+4xEDk43rp6TKxiWS0fYZVYeJNSVTTimV+Lospp52yMqnWT5lO5j8f4RkGWZ3ihIQJpYC+4pjWxn03oUnf/GMCnONYApiOjQPnMka8H5WFkxpOj7WTdGLMLdHbk1ygMoSyw2x+NWK2QAcjidydT+GX6WZeXkF0U1FoCS5MMjFNb4FO9v9p0t4JFfr9HmMpNhgrlH22bqcY/yB0tdlNBgobkO8/JnTaCkRkrmhmzSE0X2fgYr2InRwxfm8kFqa7NXBd6rZS1HtKJCxkaLmdUU4MQXJVGeLevssDP3LPzqWKLmwtJqTqr2Y6iS4ncE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(18002099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MyYl+y80bak/2rwCbDE7Kjk8wsy4FSaK/QzUGt74Eoqec1Y1pzhV8zrvpfXZ?=
 =?us-ascii?Q?lAieYHQZg/bLRO0ze1UcJgu26jSLnFLS5VmzAHPEa9dxZDjCAVMq57+ltv4y?=
 =?us-ascii?Q?4vYurgdAPx5EFhS7FIWVMPgr39TxtC6TiesatfV0BDDm0BkaR9yq1ZCY//M/?=
 =?us-ascii?Q?fusDEDEVtlN7zCwrg6NsqOX6Ilg9/LueMmTnNn59nBJAw8n0Ks+IUSifhj28?=
 =?us-ascii?Q?CS69/8E0XZ+71qzg3urkw7nHXJD5Hw4WdM3pY77C+ggLkIG/Ap//fvIIZ8tO?=
 =?us-ascii?Q?QoVd9Eicuuag3NjWMUiRVaADBilUL0B+bxE+vsaCAs2wo2K4V4+ahJq11i4u?=
 =?us-ascii?Q?+qBd1/Vtkv1kn9NqWiC8Ri4bOkUGmR3nh02K/IS52qr6rByo4git5CQb58yu?=
 =?us-ascii?Q?vwe6iKr/n488h/i8pIIZir1LzuLegoz5bFcqWrdN3HVpPKV2URiFaGdO9q3W?=
 =?us-ascii?Q?v9xZP2pakQlY0zzBr9t0Gz/aAImwSh6zy325RRvekLAp7Rn+GlRBYahaWqkP?=
 =?us-ascii?Q?F/AMoAzkizNprrupA29uTAoAiC7YLA5+0PCQa1xySxSgjtx1AH9g4FnXdfzP?=
 =?us-ascii?Q?RMqzJylZovJdxzB8WC6kyvHV9dIJi7Z9oGG+zLgzRvrpp3khjW7getKoortE?=
 =?us-ascii?Q?6R0Uo76zi9AjeewefXGqDIXUAi8whKHz2oJqwlX2dfUR3SqL9bQAndO9obgq?=
 =?us-ascii?Q?8UXMI6frnztE2EJVgmwy805JBnvvw+mx1wIM3Osfiv4E6s1XF99K1RvEKZsV?=
 =?us-ascii?Q?r5fNPsSbXM+surHuMZ7uMvITkuLY72e4alrqLanadAtP5TVXTfJatzbSNsZE?=
 =?us-ascii?Q?+WbztBAZMsbYyyk6NNljBO38AaBVLfGytgeeP06YNHUYAuB6yHiVDuZ1GovO?=
 =?us-ascii?Q?x4DC9U2Gf47sPcz7t/eeAHQRLtjkD2IIycjfPSuzhwp+ev5cozYD/KsPUqNv?=
 =?us-ascii?Q?1rqi2D2ydJNflumc18e8W+QKp7L9ZCECxFWIxYSLNrzCOw7LSeOQCniOwype?=
 =?us-ascii?Q?lRa91nU7tyXOF2A674Y/aeCSKocg6e3D09rpOO2D0h9fMyt1ta3AYnKUbflA?=
 =?us-ascii?Q?kOZIwlXpYArgrRhty4kjoEL6xNMAI8fMkgdVZDokxAlE3C1dNkA1kRliy4qs?=
 =?us-ascii?Q?AwmSsYM/KV2eVQwgucFzrteUSxkvjLw1P0azl6yllSxWUzvNEV77XwALODd6?=
 =?us-ascii?Q?mTpUPWwH0nlpk6dDbCn4QGDPr6BMfH/YxwO8dQXWpqtPG4X2xfY/ThFGu4+I?=
 =?us-ascii?Q?zGxh13Hi81lPFbk1BVngZRCV/LLpofrWHgoCUXP01LZ9NaIGBAsm0hOltZ0p?=
 =?us-ascii?Q?XspZqJsNEbj7wQCyY4GssAF0cdf9J083noShwrHSNUavHw1aqSO3wTp3pqFE?=
 =?us-ascii?Q?V5K6Md3ACRt52WcJC9RFcE87wrM1uVx13bC5f5RAMTsUFRzxvsg6LIKKRWUK?=
 =?us-ascii?Q?lB7p1zzODo5RaY8ap/CBeKoA6zgSQ0poqzqvyb+ZDs3Locs14Bl2L+D3RL2j?=
 =?us-ascii?Q?6CdK5CjtYSzVdU4ZGkewKYfnokoMkDuCYnXZl1rDpbnLg16fbMWWgChwlBJU?=
 =?us-ascii?Q?B7N8wID/zFUddLq8O3IKH8eUDiehrcp/KrwPOXdwhU9xDi2iUtMBXNxLKY9x?=
 =?us-ascii?Q?ugYcrY0M9Fm4FnhuyA/DMD4TxOn0Z3uK0QY1AWiFdmF+WvkkxQ4/ulerzRdn?=
 =?us-ascii?Q?AhJF0iAd9Ce/utubSQoVCwXEjU7EQ0D0zfG/lahymrso+UzoD7Qp1bKccDNr?=
 =?us-ascii?Q?lJjRKJt/lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793bce5f-a30d-459f-40f0-08deba077ac0
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:44:02.2325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzV8MNgsY7HCBYd4l/3zkA2jfyLLvq9novKvVEG89L2l/I38ZayOH0U+knWh11CF3Km+zBlAVC1q5BkogKRtVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12113
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

Use dev_read_addr_index() which supports both live device tree and flat
DT backends, avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/pinctrl-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 2938635ed95..50a130d700f 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -527,7 +527,7 @@ static int at91_pinctrl_probe(struct udevice *dev)
 
 	if (list_empty(&dev->child_head)) {
 		for (index = 0; index < MAX_GPIO_BANKS; index++) {
-			addr_base = devfdt_get_addr_index(dev, index);
+			addr_base = dev_read_addr_index(dev, index);
 			if (addr_base == FDT_ADDR_T_NONE)
 				break;
 
-- 
2.51.0

