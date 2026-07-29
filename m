Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30370C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADCB740B2E;
	Wed, 29 Jul 2026 08:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eMpzo1gGhw5W; Wed, 29 Jul 2026 08:12:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F49D40AD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785312764;
	bh=1qb+fLxkOkEcasxX3JbBel7mN6qAgYFjL8874KldA5k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aby5Sd3QB1PVIiRn9lXGGRG2eD/QWDTUnZKL0AH26FY3NMI7WwlojWSh+LjBx4SFQ
	 3wh3AFVj8hz+KPhTOYIa42d/woTuCBvSpIZ0gCl2TRa5gFsv4vkuTkejZ2c6Di5B20
	 lpwYizM80jNeSWq8pHj3wZdeFfqsnkhfpphHeExMDmyFL8EiW1ASDfE/Z7iPbsv+16
	 U6K2LE/1un0D6AT2W23BNuYMbMn71FaUWjIGV23n/ClxA+5QbOczJdkMJgbXv/05R1
	 /0RZ/iUmGcLVz2K6YugG5MVHM9rVjtlFsTortJ71MzAFvyD5vnkOLfuvmDBePour+g
	 du6hBk82SBTWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F49D40AD0;
	Wed, 29 Jul 2026 08:12:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DBDC23F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FBBB8112D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OAsFQ4TlYI9f for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:12:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B0C3281091
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B0C3281091
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B0C3281091
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9Ne89nTGpNeN4uCoGazGSHdvYtFIGA8h0cpTlmCDSEk8pgQ/2MxjNkE8Vs6W9OhWVoJ30MRHkhLVysEOdlDgpZzWp1paXjkVCZ/3u5raRgTjcVbKQtIdsHl2+8R0U6dWFt8VW5yx9qBWdvp7iYOna9YFKL0sgae9MAGKQ934fnCt+GqHArXa9DQDUnaEFK9z8WCWT3+pjJwEd+g6hOuNBSxLBr0QZ3AksNWMEgYElvtiSl7Uz+ceI4weQWJ8LNMe7KV8Ek9/idsjDkaosG00EchI2TXZ8i+eYTxxIUvUoDIxoNwDznLgZ9ddMGtf5Gakc/Hqf335Z0b2bDDLZIw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qb+fLxkOkEcasxX3JbBel7mN6qAgYFjL8874KldA5k=;
 b=cUEC1KFn0m8vZdkZNbfUWDaO+zWEEtwvRTHHsUffh2XHe0Nfl5SVGSyXnxNIijT6aIZDf/wyGEuWkr4UXkMvGtlQ5xjaAdOuMOIXCLIhQ9NcGiDRu3cvuUbkEjL0Rn2S0drycKyNaDy57uvxS3gmXTwR+YS06m2XxY7R0VT89jp8jvwXQ+invvScuClMruGrraEDzJoTDqrHag4e5HkaLlOK1h3egFYTwCmdDBY3toV7EkRCPL8pRptNF6wlzTrGE0IwLT4rYZC9MEX8720AH+0JLuwyUpfc0JUL/PO1msdVHNeym4K+yVHyQoj8jMpvpM0G4Lf6W1j7gzMUkps41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::17) by
 CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:12:32 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::a8) by DS7P220CA0003.outlook.office365.com
 (2603:10b6:8:1ca::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:12:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:12:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:29 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 03:12:28 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 2/5] gpio: cmd: warn when a gpio offset is already claimed
Date: Wed, 29 Jul 2026 13:42:15 +0530
Message-ID: <20260729081218.550465-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729081218.550465-1-pranav.sanwal@amd.com>
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: bde99c5e-6d39-4e3a-b51b-08deed49232c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Kxo8SB2LCVg5vDhrnOe5pbOTS8bfwWnNynDEWqEh+4p9li5ZWQw1TbLAqwjHGlaAjGR8s1woAF6XmWpp8p4BU0p0fDUv8b8iKOmE28tB9G5THaQryAJ2kr9AnqXhn1ROyFljEtdjhceDvUq88Q9p8ydWgkn15PoqoRj/N6Ci/8wtWj2v8JhWFnh4V595tNHgx9ySHsK9d81ro6aWvoesS4T62uXeUKXNXeXOpdPB1KBKGd3vLD210/4Jm18qZjuiKZP2wPZtro4dOpFI69PTvFZRZB9BHh6KWWdx+7ic8PqUdGD0C5pCv/ujogNuNBC3GCLLeog6kUzPhaD/o4sW3mlsryGVM/jJwcKH9AfX9tc8Q0i8wksbnKUK8AsPuaVxe96zLXxYWzZSfr/CWX/EldQISZBhtfdpyX1WFxckgRJAxIiakObRb1cF08dDxWe2qrWnlglcSpUMhKaHnjgjsQEtlXzx/GXRYOgRLEH18mx2EPXp9RJpZjc5KVAVdsCYJLdQbi1mtOvIlFzlXWW8wS/mnc4jubYxa0qpqe0FDKG6dseKwJF5yUx5PL9TFWOI6mVkn4bg8EU6EQaptufXxpmrWJToXzLDlzEpCY2MKSAEEVUUToj3HEiGz0ROvA/EjcVuSgsH85UPQzuhHBS4lGMMiVNutYUQqDIVQzXjHg6Q+XEN6xJqZSUodTj88FswC0LmAkSf0B51io2NYeIgFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6sjvbiaDHLBKdHMppZJF0lUpab9RE4t/8pc2e2cVI0NFwF3OIuGYAUogh4DxIlUWgEiVoOPGRg9XoX2QnyTBNskgDxjGg+yipqsjJes8E5WMefIoEe+Yk+fibAkFc1DjDtqC9xPlpFpuRrxUqmQr9sOco1gQT7790FxT7aH3DH9FBPuSO2eIps0AODHJfnbC/i3r48Mk3kjy4qxdhs/uq7+PrlPgAnsOIphmhsmQIS9NqVyAyH0YxbycdbO07MloRSshFd5IkS/Imvoxqa44DwHzlEQ593ZOHFNefS+Ep6E/K8JQsy/66nbpgg56h07UzOpaXBfb4YsiTTuUfX+iMlu4Rq1jqdnE/nK6esCfqAydwOfC/RZXeWQ6/5bo9yAPtIIYG5Gf5rCTL45Lr/w//KNBfM8os90df6Sq+H1HLO4itmVi9sSlXB9Bef7Q85q1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:12:31.0847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde99c5e-6d39-4e3a-b51b-08deed49232c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qb+fLxkOkEcasxX3JbBel7mN6qAgYFjL8874KldA5k=;
 b=jp+U8kNZyxRZbEGqhtveXJkX2U4dqjrziRRwNFmg+UbUFPXJhpx6mucoAKu8VhcMQLoL4LtyKV6QBFVDMjXvoDtfAufLTm9ZlbBfJSTssea/zJ6m1SG6XGgZb/Dt8G++dQMrrmr9/V8XPAH1AHPjLzWGK5iBV/7D4yyLS9ln9m0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jp+U8kNZ
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

