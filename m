Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32044C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6A77810CC;
	Wed, 29 Jul 2026 05:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1GeFFwFlgM4; Wed, 29 Jul 2026 05:14:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1729A810BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785302049;
	bh=1qb+fLxkOkEcasxX3JbBel7mN6qAgYFjL8874KldA5k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f78Ub1+CJzuWkZblwF3eDVAJh22YxIEZCP5en7+O8k8vbSF67JFxKrnMHPmxQlP5b
	 dP/Jp25WiUqSz0NiAYREfcPmVdO176as3oU8Sz8K3JL6jZBraYgn/Tfwexq86575xL
	 yQ5NgQnOcQ6fbdOykUqmV9d2D+tl6YFsqCUVOMbCxZTG/qjwWjQZSRArkyon4pL2+W
	 81y8dG/18CNsxb0f9AjeTQkHCoBRKp/cEr1VAVbCUycMqgK6Z7Er+3oVQoxSycgTLn
	 7wHB1+qTRrlsWBWMVF9Fy9CLvQctfHCzpMDCyTgLTO+TYZ4m7RG9b1m7a+wFaCD9Fu
	 ZuUr7WaSa+qCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1729A810BA;
	Wed, 29 Jul 2026 05:14:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F2D745B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10C18810C0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fK_F7NY6eSrR for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:14:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C6155810BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6155810BA
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6155810BA
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236F28404D; Wed, 29 Jul 2026 07:13:59 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0828C8493F
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:13:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THyKbvmqTKidFPBpu5P88oVnBGE1KUWqDAIrfx2sE4Cpn4FctPIgv6VJqd3tDiKyW0EDB6YtH6NTGIsZiSzDOX4zW0t+Oem9oX2b18nvkGLXJ4qS12Vj7CU4kNdPBFam6dnK5vpknC8IDmHssOf16ZCAlajqaQujIHOpOSZ/ryzYq5ZuJFQpgn9bCxUAPxDtLJmgluElLn/+PtGyoEr7yjT7/FSOeZb1fQZZ6m8jaz0QzjvOejYipJXvwL6Mr4F4I/WdqN1ZmGykArs9kKTSZ9xI6P/YACc1T95x7NaliS0XhgHEzlM7nmBZoSpiKozpOaUbdw6xtbOKV7R0hH+nKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qb+fLxkOkEcasxX3JbBel7mN6qAgYFjL8874KldA5k=;
 b=bQNptrczmxFS/w//N4GMnUBCO2874AtIrAfManrJruqPBprVzb80Khl8VtdLHbAKE21mGt063vmD4v+GxffiGOEZtvdZldRMKth1fHMWCohrhDn4mB60iXes6bRfKyOhT7yK1lLeNnnhDZDU88C+wGLW6oCd10eU+AZ965ZLebVw7bFy6EpgL0aP1sMy10HJZPdPDabhhnxe3V3CRWZQtkiRUw46AnaXl1sMkbtG3CkMtYNCs+k5r/unoSE6HDvxnEB0S4S1Ipbx5dRYEjiUQd+elsbEygfHEywv0GGCbPKwLn5rl83yB2Lx284pYubGdxwfuHXVlhwgHZk265dd8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from PH8PR02CA0024.namprd02.prod.outlook.com (2603:10b6:510:2d0::16)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:13:53 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2d0::4) by PH8PR02CA0024.outlook.office365.com
 (2603:10b6:510:2d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 05:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 05:13:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:50 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 00:13:49 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 2/5] gpio: cmd: warn when a gpio offset is already claimed
Date: Wed, 29 Jul 2026 10:43:36 +0530
Message-ID: <20260729051339.221699-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729051339.221699-1-pranav.sanwal@amd.com>
References: <20260729051339.221699-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 820fc419-b188-40fe-09ac-08deed302e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Y4H13juPIrN+gct+3azc2KmvLKDL5BJifKLSzKEd8Aalo8q+F4+2kw0kPDv3C7aWFAR9yUBuS3GukIi6CrK3qJsQvBKF8eXBMSmW6wQFANG0moj+eskzSRfUT+aCvlVev8J4VxIk9YgkF+GsNs8v12jIFDch+3i4hC53+uCLA6yfI2YHeuLkPRfYVaqHTvfZh7mfVp+ZgJZ3fyfZySbZhF/ngdDspFRVIfxBkdAY39IQMNOCHA+IuelFmjXK3cG5oU7pIknOXc0Lnsvd6JPVV7+2Ty/LwY6y3WFJRohG5AQBQ8iqCzIK4sc7ERw2PxxYKLYFPZvSW7GHpvvxBBPfwgdTrPYVgM2SrXpCxN6Hva4kuX82GUd7c02tM3iPZafpeS1dhx2FyrwH/rjOLaVA3yMsVhX2RHiwrI8ycM3byxa4s8l+v/mBnqCntk5mvZ0w1bYoxrXNEpjdlZjQx5HjBrmtPQkxmOxR12KQO9oFRdZ9Duk3P0m0ReY0ZgUMwVjF9Wh4si4RfgWaLZe2/nkITUshd7cJ/nQtf4i763Ao7LDK/zu5f77ei5AG7ZbGJr4KhGBKGBbL50ibwT/e+efE1st2LTB33ELGVFXaKhFhzN0G4i/d8f10sUC7vkr5f/jznMH+cC01PplGsPW/cyqifTHa63jo0yfsWYMoOmNydA/vJD/b44qwQltlXsVWa9by5DF4/OktVHUz3JAyhY+nkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: btjuV+u2Z4Wo0pB0E6B2RjmsYii8XdMz44ZcDbRaapApC/YLpVN7+03nRENpYgRLi+5sU4JdVAmsJZN/DwYy/1cDOA8JuaHlYJrtY4B6cE7rYH+1HsNOqyayFakwwQrTM57/h5lpjvoIOflPXZlr/Kq+pS63eocVy1n8TbYUkJg8Y23xi9h1YlHFjXRWfs4nt/NoD0Qq4aowmGV1sl+wiIOQtd7NKVJ763inYgs3y9T0kGZIcbu/9SE3zuj+BAQLqvEi63HcAYWKfYS/UChZ9hK2ojHbYOx92cangEbfAeDsp+cvEJMmfdIotEY3PvQ1CtDTIG4bgZc4sEGfRpSJqu31M6DNGrT9gss8F5Rj9EnNEhEefRu3Uyo3p+uzTrvmT6MXpCljoBbicqvTgjreCq/w61db3/ymAKg9PO7QwIyHizyMaCbiGlctbQ+UDS7x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:13:51.9194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 820fc419-b188-40fe-09ac-08deed302e0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qb+fLxkOkEcasxX3JbBel7mN6qAgYFjL8874KldA5k=;
 b=0o5A292vunVQ3coEva/Q2NAsBZFtpsNHcgXUqnU3LpH2oyrFevolu5g3VoDWoHIFApHUKsnnj1DI8V7qu5owUr2kGOTxX6ZJWWfn6kUAIVSHgiXE/gPSZWHwk32NLrZNmcukBdklxXIYwARVcK3Go+xhZXf110CpEOzgJC8ZALA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0o5A292v
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=Pranav.sanwal@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="0o5A292v"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The "gpio" command silently swallows -EBUSY from gpio_request(), since
a pin already claimed by a driver or hog is a normal, expected
condition for "gpio set"/"gpio toggle" etc. This makes an unexpected
offset collision (e.g. two consumers unintentionally routed to the
same underlying offset) opaque to debug from the command line.

Print which label already holds the pin when this happens, using the
device/offset already resolved by gpio_lookup_name().

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---

Changes in v2:
- New patch, split out of patch 1/5 at Simon's suggestion.

 cmd/gpio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/cmd/gpio.c b/cmd/gpio.c
index 7a43dc6ab18..6992ed0e79a 100644
--- a/cmd/gpio.c
+++ b/cmd/gpio.c
@@ -137,6 +137,8 @@ static int do_gpio(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	unsigned int gpio;
 	enum gpio_cmd sub_cmd;
+	struct udevice *dev;
+	unsigned int offset;
 	int value;
 	const char *str_cmd, *str_gpio = NULL;
 #ifdef CONFIG_CMD_GPIO_READ
@@ -217,7 +219,7 @@ static int do_gpio(struct cmd_tbl *cmdtp, int flag, int argc,
 	 * code here to use the GPIO uclass interface instead of the numbered
 	 * GPIO compatibility layer.
 	 */
-	ret = gpio_lookup_name(str_gpio, NULL, NULL, &gpio);
+	ret = gpio_lookup_name(str_gpio, &dev, &offset, &gpio);
 	if (ret) {
 		printf("GPIO: '%s' not found\n", str_gpio);
 		return cmd_process_error(cmdtp, ret);
@@ -230,7 +232,12 @@ static int do_gpio(struct cmd_tbl *cmdtp, int flag, int argc,
 #endif
 	/* grab the pin before we tweak it */
 	ret = gpio_request(gpio, "cmd_gpio");
-	if (ret && ret != -EBUSY) {
+	if (IS_ENABLED(CONFIG_DM_GPIO) && ret == -EBUSY) {
+		struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+		printf("gpio: pin %s (gpio %u) already claimed by '%s'\n",
+		       str_gpio, gpio, uc_priv->name[offset]);
+	} else if (ret && ret != -EBUSY) {
 		printf("gpio: requesting pin %u failed\n", gpio);
 		return -1;
 	}
-- 
2.43.7

