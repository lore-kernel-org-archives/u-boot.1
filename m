Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4CEC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 04:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C02584A3C;
	Fri, 10 Jul 2026 06:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="AyJEppwy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29828847AF; Fri, 10 Jul 2026 06:51:49 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3EE6849BA
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcUc+8TIcKH2AzPvDuuVe8frY2Ia3w6ZekZB+tdAwMNOt+Iu+/hBqQMGvGzX3lXVrsDX3PbJp/pF6yGQGfT3hUfk1g11BJEYk8MeOD+9EGBGj4c+zsU1Z8d5xll3+oFQICJ/vyyemhBw3JOLXulS4tEFtq7kKZBNLjtL1iWkriFlCPv/NjpQ7V00cLBbRn5DsZJVPufAGd7icnYLpYElzbvGo/9Y1oN3NsaKc6HhxFIUnMY50pTYrFoOx0UW0ZAadNzMN179V3zgPMzFLiJrzCvCDSntRjUvYLDPfV3V2QbyTb+IfTprOis/WE1/MA8ys2Ntku2Y/5nV9brAx05Xeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T0QWJBCNSAke92LnG5JHA2XQcjwhkDBf9i/Qvd9r2E=;
 b=XOPIjfHDYMdcGjp4sfYvj/ACfZSNYoCDYhNcuiU6wW9nYXcvoA+cw7zvA6iSiDdmULYyG9Oycr9StE1ucxi0yROe6pfHxccgpn/bdpE7YeVrg1ltp7g7c9L70Kbeq8B85L/2M86JsyTfFXA/dOKdJQ99j4FPk5nJVdTnMcPAurxltMKK6YzGRbce/o6Rc3dsDUYyl5Qg8IP+AEqXzttQLNatvkKx7KXVRn15IakZiVdDTcREyrYloaCK/cAhBmMCkF9/KguB+IBXvjbCpW9Nc+4B02Fyt/h4xntqsjMINN1rjD4Fx7u0gOAKB0JXsH9X11tcJm4J65KQhGaF3E9kPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T0QWJBCNSAke92LnG5JHA2XQcjwhkDBf9i/Qvd9r2E=;
 b=AyJEppwy2yDlc49KLqskf891k5XQzmcRqaJOjyXrnVSN0GO+Uz+yvY4ZxjOqG3JVRAakQCWBNoUnK82NiMjOASTpUMgPyxjTo+qgv4KiRYoWktgXjkylAVmMJ401yW0pZ15EdDw6G8KQga/VKKqLKcB93In0PD2fzThKHVafwmSAPPUIU1eGwhf3ADN/ncRst76ED4Y8GJyWg0jcEDpC8LzgIt/gZ6bV5OyjCEYbDciJ/DKzz2O/0z9dY7eTfWMUeVF8FCweV9KibN4dvOD91MbHyvTaqyieCz6Dc562i1PfS3uzWWmCESwISYFkW9WitXDILkebGLCsTOVfV99GGg==
Received: from DU2PR04CA0175.eurprd04.prod.outlook.com (2603:10a6:10:2b0::30)
 by GV2PR07MB11857.eurprd07.prod.outlook.com (2603:10a6:150:306::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 04:51:43 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::2d) by DU2PR04CA0175.outlook.office365.com
 (2603:10a6:10:2b0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 04:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 10 Jul 2026 04:51:42 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8C1D223C49;
 Fri, 10 Jul 2026 07:51:42 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 10 Jul 2026 07:51:19 +0300
Subject: [PATCH 3/6] watchdog: sbsa_gwdt: add get_timeout operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-rinta-watchdog-gettime-v1-3-9a982fb93f49@nokia.com>
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783659102; l=1824;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=4qSemVv78PH44oPD+Y/pDGJBGkjlIY//uwJOiYFP/Sk=;
 b=Jn4b8IHlheD8z2gkwzv/uzqKeF/tBchK4NRPd0RUMV19A40UHaEi1oRQOXTM4wvljNZRv57aW
 fTB/+Z96VejC7+dinHwQgXHpR47Dy1YxR8hf91KqpMrDuTxhqG0RtvA
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|GV2PR07MB11857:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c35e120-4a4c-4149-c354-08dede3ef01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: i9e7k/7g1XdkNGiE+nX9Wlp+GCnZQXehafiiUGmL9zTPzwDzhZ4oHfHv86U3IcrUnHEALlgI4pvrzwdQj5ABqsBccRTsOZh3eGoZkLwUSJLy6mTvFZvTexueFLrg1x/wql+NO12EJMbVXUjwHAeupnsoYk5JK47pLuTt9iPqPpSTxd0yCk4SEpUN+v6vwVxuFHrq260apzaQW5Mt9HL7LNsqgfJHNUFG+kz0X44bk5Vi8mquFvd/UJfyVBjUoXor3WYA1Lr8M7llk/g/hg1i4YebjW6XwA2dn3d1nXnOmj3ZpNbElgAjfk5dEj6YFvZaCoe7T4nVetx5YxzqtM1FHUtqwMKEKk36yPKdfZyIAMwSzyWdct8+GzovHhO3+Qw/+sG+9qWSd7L74HxDZOfslMIpMmn7sp4MVFMivKd10QfAz2uJ8TIIpaslDOweMzHXFGDMhkpyOdb5y4n7l0osyNVBrsquNsXC1hzDVrxKmsL/a3GV2l5b0mrAXg8WHZZ4asWLytDg0g4S1yQIZg4+vipowyOKPgSQb5RhakdViXDDq3OrZeAf/5YqOwtY9Irz3rKSX7rra96DkaD68kvYq/LfcIrcwJidgKVZPNOsxoyGnmex63A36/rtVky3OsvwqhGQJhIhDTsNtrJ+O8W5yvy2854Znh0d5uZa5bDbDNSBQRXuMKk33s7Sfiqc90pKEI6jYVjca6KQgXmnjgoOtg==
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d5hJJsYHpSG/UZ8/++9LhCqKfHohr0TRnHXzMsmP5/DDZ1DDxoiSWq/UtIqztbtUCHBh/9Mx0S9kujSKrwdAR8rGgN5OSoyUj+uS2N4YcYPcpRFu59zBFbNGk/I0UQ9tdu26gmHqbhXvHAVLXrfxqfJDl+fBU+XauvdeHwahK9JwhBnh5ZPQg4A+ZIca9ByeEbqSiLXKgA+y0+AR63tXXX7GFuIq6cbNWahFaYusAEIpXfl9PmT8eP9iIW/NZyXELPLBZSR5ruDzgDw9RlcVVqO2co3yZ7sLK285Q/6+hZI6hngKdsyowcmsa2aZWlLFmK7tpfWMYBx7GeL6E4s+lNv0hKQQTBU25Q41wb9Je7TxGRAYbc16vBkARz2rMg4BfKzx9Z4YSSDFzXFd6um6TK0gIVo9g7vJRPcUZOyoJ3KEpdMRoP+qM9xa6ekXi6bB
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:51:42.9951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c35e120-4a4c-4149-c354-08dede3ef01d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11857
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

Implement the get_timeout operation for the SBSA watchdog driver.

Add a timeout_ms field in sbsa_gwdt_priv.

In sbsa_gwdt_start(), store the clamped timeout value
written to the register to the timeout_ms field.

In sbsa_gwdt_get_timeout(), write the effective timeout
to *timeout_ms.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/sbsa_gwdt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 3a924cb2b9a..3e91d093f4d 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -35,6 +35,7 @@
 struct sbsa_gwdt_priv {
 	void __iomem *reg_refresh;
 	void __iomem *reg_control;
+	u64 timeout_ms;
 };
 
 static int sbsa_gwdt_reset(struct udevice *dev)
@@ -46,6 +47,14 @@ static int sbsa_gwdt_reset(struct udevice *dev)
 	return 0;
 }
 
+static int sbsa_gwdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
+{
+	struct sbsa_gwdt_priv *priv = dev_get_priv(dev);
+	*timeout_ms = priv->timeout_ms;
+
+	return 0;
+}
+
 static int sbsa_gwdt_start(struct udevice *dev, u64 timeout, ulong flags)
 {
 	struct sbsa_gwdt_priv *priv = dev_get_priv(dev);
@@ -65,6 +74,7 @@ static int sbsa_gwdt_start(struct udevice *dev, u64 timeout, ulong flags)
 	if (tout_wdog > U32_MAX)
 		tout_wdog = U32_MAX;
 
+	priv->timeout_ms = clk ? (tout_wdog * 2 * 1000) / clk : 0;
 	writel(tout_wdog, priv->reg_control + SBSA_GWDT_WOR);
 
 	/* writing WCS will cause an explicit watchdog refresh */
@@ -116,6 +126,7 @@ static const struct wdt_ops sbsa_gwdt_ops = {
 	.reset = sbsa_gwdt_reset,
 	.stop = sbsa_gwdt_stop,
 	.expire_now = sbsa_gwdt_expire_now,
+	.get_timeout = sbsa_gwdt_get_timeout,
 };
 
 static const struct udevice_id sbsa_gwdt_ids[] = {

-- 
2.39.2

