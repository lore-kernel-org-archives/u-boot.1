Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBEBD41D6F
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B99E8944B;
	Tue, 12 Nov 2024 09:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tA2XvWa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8897B8943F; Tue, 12 Nov 2024 09:50:48 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E9889441
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDJwDGj6yIfqc4tUmsxcHX/Jo2LZvxsQM4jylslSbGTRsD86Rw7u9Z1auGFRG09QvirctiVSQK00VrmSVWeeL20gULJSKbjFtLP3txvf8MzNpVmSVbKddZhfmLSezW9mtlBp4/l6JakKytEV9G3NvySHext5qhYaO0SmWHcZ1ucCOWGshkFvlp6FXiLcYlaDDXsjHm7cNSM9N4NUWnvXZu3qjgyKNJUToEPg218mvxZkvSeE4vv8T8wrqPTGhdXjua8cMinqF2agTggi7nDjz0Jrl7264aQPG/tZyMNCox7FjlABRZSi1lrblUj6ugGjXipHxf9SFklajTIg2tmb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5yuUraE//q01kVgPDk4Hq5ZyfC1GwaXBQA0v8o/X5I=;
 b=jMHXqw6qzZWJklXMSzVcvU1Psi4QB3vbLZgNUUMAP93oI14wqqIBcYU+WW1yqE89tGj5xc9xSSFy/YF3RLE3uJOjf4PlEX0UfZSHpoLRJR2tDu0N0wjkDnTCbIVvN0dMnOAmstFwU4Fe4O1NOcT/HI56uIE+4MEJwn6X/6aPT9F/F+vtOzSUoHnVlcJsbLaVJG/pQy6UHC9Jyy3fGsxDBKCBvxOgZdWudmQ8UKTVI4ScnrDe//XTT6LTrJy+IGwKpBNVPQAHtYHpueIuxe6gCtftdUSf3aKHpnKFxnKfwtJF50TVqLZUohjdMWpe5omHVrz4t5070fkecDPUuVYt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5yuUraE//q01kVgPDk4Hq5ZyfC1GwaXBQA0v8o/X5I=;
 b=tA2XvWa5d4bXc2e3BwJxrG//n4nRLxYxikff7rKsLgFiowYuI2GuQ2YgOCQSoLNwsX1MRdFg6C74cjehNvTw0zPZCj4egp6LkZ3Uqso7hE7AHl7NoZh2OdiJDtWZFr0xTmlbek6xc/MHSvpP5WJV9QN/wkNm68HxCTRZb0k7GmQ=
Received: from MN2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:208:134::25)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 08:50:42 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:134:cafe::f6) by MN2PR16CA0012.outlook.office365.com
 (2603:10b6:208:134::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25 via Frontend
 Transport; Tue, 12 Nov 2024 08:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:50:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:39 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:50:38 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v12 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Tue, 12 Nov 2024 14:20:22 +0530
Message-ID: <20241112085027.21352-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
References: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SA0PR12MB4349:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a28642-b8fb-4f91-fcdd-08dd02f71694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IYCYsW69G2odmKNvHv/rwJWDWZZQSDrQOq9NZ4T4sSgowo5RQTkGYNdl50tT?=
 =?us-ascii?Q?dOmy+ZksLtuIHJ4+1tXudvnmOdadyLnSsV6xBG/6eqsUeliH02Uh+h7e6Pvy?=
 =?us-ascii?Q?kdG+grGNvNu/ftQZJrLgDGt1EM9xmCln2WCt0lslEI+1AvYBBUDz/7W8z5RP?=
 =?us-ascii?Q?goqKYBCqV+po4xvYILepBtTqvAUeKWfNk1SYmot78DiOzKhzt5Ae33CmxUzG?=
 =?us-ascii?Q?7eVjknbTXSz/Fipu4R33VQ31Z1UaY9/g4TpwR7ev0UAjJpwAFjNjZN/pr/0/?=
 =?us-ascii?Q?ImFanvKLwiKrLUT890fN1Cp6bYb8AjEGunlaUPBNFoWNoc4VVsW8lX3HIraB?=
 =?us-ascii?Q?ABTNdmjSLBDzrZIJ6mD3htxPUKgaoTmNL6v8gEjgyfd2jBMjJkpQEZpuKfbj?=
 =?us-ascii?Q?beX0vf++L1sY61l4ch7H5H3AN4DQhWjAGe00rCwX8gSqSXBQ72JU9H5LxuZB?=
 =?us-ascii?Q?2N5c/WYtU4WSZJH5xpI5yHAUs6XQRyLQeQ9Gbc3EvlOc8oPgYex4PXjEykSX?=
 =?us-ascii?Q?JKrTTHjgQhPEY5UfZFnYXVEZHv9I/F6T0fRKCW50Y0k+OCtDq1v46CAqjs1M?=
 =?us-ascii?Q?COUfO+aNel69ch+Wd1RI1TA3M1mmaQ3soQmW0XqQhDZIrGs1ujwKWXvgI7v7?=
 =?us-ascii?Q?WsQxB9obsrgrJczDIc3YINIEnkadl6MbNUoF0DQdVLJsC32YdF1hmzVPjVcP?=
 =?us-ascii?Q?lVNzBEIEgALuatBaetAvaJDHC3VjfA1CD5j1+tqK0piA4kOSPGgfuiHlclGx?=
 =?us-ascii?Q?w9PLR8Emtfyr/ty8pTVbg4WMGjppTlasf3Zelsv4JX3eJYG9In56kjtjXCFw?=
 =?us-ascii?Q?8aeQ8w/xd3PFpgoa9g0cCcnmYJIQD5VUaQ2JyHwjNPPPaXsZKQvTLu7fDs4S?=
 =?us-ascii?Q?A21WxkgZuCjz5JnggNnMnGfUhn5F9xSAXb/GPwmmn8bIUqCzT2ou8Ojuss3Z?=
 =?us-ascii?Q?Z/S4gASx6QTGKFWKUeLaGGXQ7NB3u30tHM0l8n7A0xRCDPVk0+ArfOC6JZYH?=
 =?us-ascii?Q?J3XKAADuuBIBb9sM33zQj87Ac4xzAVL860sKql/4asCUdPAoxLipeCk3FtqN?=
 =?us-ascii?Q?snzPM1ugLLZ+mI34t1WkcKfW+HcCCytP9NjdaB2ZZ1I22XBeVoMB+1Mhjz/V?=
 =?us-ascii?Q?jzPkDgfGVd8xuaBQfexuUkwM56zk062XzaNain/fATrdd83bWviv+duc5PAH?=
 =?us-ascii?Q?AkTcx5UfRrzMU1x0D5iPV4wkJL1eu17UqXSIo0V3/XUR7dwol1IWxw01U3LU?=
 =?us-ascii?Q?FJvbRfQwNR/x/6WtJS3oonpKyiHGDf4WmVMC4NUwPZtDTw9k8x6R+icnBhYa?=
 =?us-ascii?Q?Uon1HsNlQYai2FXBsC5oLzk4/krVNSKo6ahLwdzLf6KOElTK+M+GPvImCzj3?=
 =?us-ascii?Q?3FywOMZ6cogyxWpycYiEphb7HR0PgSoxXZ25P/4KJcCgQL2/yQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:50:41.4893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a28642-b8fb-4f91-fcdd-08dd02f71694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
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

Don't error out if there is no vdd regulator supply, as these are
optional properties.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index cc0501832e..f26223e823 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -57,14 +57,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
-	if (ret) {
+	if (ret && ret != -ENOENT) {
 		dev_err(dev, "can't get vdd-supply: %d\n", ret);
 		return ret;
 	}
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, true);
-	if (ret)
-		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+	if (hub->vdd) {
+		ret = regulator_set_enable_if_allowed(hub->vdd, true);
+		if (ret && ret != -ENOSYS) {
+			dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+			return ret;
+		}
+	}
 
 	return usb_onboard_hub_reset(dev);
 }
-- 
2.17.1

