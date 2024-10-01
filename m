Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D02CCEB2FE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39B1C890FA;
	Tue,  1 Oct 2024 07:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KPGcPP5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DFA489125; Tue,  1 Oct 2024 07:28:52 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE4288F63
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIQ4jPQ+h8tcEM9ZOBK8EdpPf78vWTadDfS8tUJW6i8kgnMnCAAts2HR5tiUMl20FRk2tLsloGx8KmmiH3ulF77fjfOjxJU3WRoJ1of89liPlpFZDI4rLf7HV0ZS8SwK2yVCpFW727lzM25MHrDEnGKrxBnJMdS/B5l2rMBsbbiWPL98zXxt11DB1L+lW0rxPkiEkYSWkAP93vHL6OowHMEeMjDnXcbilLFxLcBzbXOhaOz8Zt5F5igmgXMKfa6/aMSVD0T8wnfA0QlxnqzcfCVAvghIptOimLO5pV8N/ru9Rll59i2OkToIcn3lcRfdUsncEHHzNzOVhMTp2QL7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iKTTNGnjnIekvttA7BWSPdTAYnfX/npeQnM4e1z+T8=;
 b=vIZPBzkF42mBPnxc91RxJdz99TtPikM9xw1NB6RVUizM1sxx1ahu1I67489nPnG+786cqlhHE3NpZ9pv00oftrufIAuk+rNrAGyvoYvwAtcQitwCBJg/oVwnWgpUrgMBQA9v/1BA8QAGgsiaWLBMwcbOEIIZWm7w63D+ubrn+Dy0t0uczAtJp8gU52NJudcQHw82AxhEJuKXv0i7C1V9iKwC8BGkWzbzo7QRAPiPRyXFEQwX0Ji0LWlxCp7tCR5lWAtuPThIBelLptv2KFI47EfXyoGaAZQGpfUH5/W29YIRypLf7qzJUiNjm9ytjbut0lTqS9nxlw8UGAyhy+P01w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iKTTNGnjnIekvttA7BWSPdTAYnfX/npeQnM4e1z+T8=;
 b=KPGcPP5vjBCgN2t69BSkW2WF3RK3ein7GaI9EbqiJsSP0ec7sdZJy5xLb+Dqi5BpEU6e/sjeAGWNIEFddwOS3uKWflEbD4bHMchpokn8umEf/Cjs0stBRyMn/3bwjuULa3ReeqnpINGqNxCWxc8vvVpeLYjqPSSa3zx/3oVtcDs=
Received: from BY5PR16CA0030.namprd16.prod.outlook.com (2603:10b6:a03:1a0::43)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 1 Oct
 2024 05:12:54 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::4e) by BY5PR16CA0030.outlook.office365.com
 (2603:10b6:a03:1a0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 05:12:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 05:12:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:10:46 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 00:10:44 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v3 2/7] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Tue, 1 Oct 2024 10:35:24 +0530
Message-ID: <20241001050529.17922-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf075d9-2bad-4205-86a1-08dce1d7b472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hNiG5RAK0NkavC7wNcTL89PuYfWPTKXntX1cmUF8oVi56d3PpV1ItbYOdbuE?=
 =?us-ascii?Q?ss2XN9RVXQRJ1VW6pT5jYmI3Vtu+mSiXCOVpSIQXLsogJ/O98tUbemEFrQYX?=
 =?us-ascii?Q?ou7yDvLpwfIQfnM5cFI2Te3K5jxworO8ZvHxxt1h5plB3haWv48Gr116+bni?=
 =?us-ascii?Q?XpeIL8S0L3+Xpo6mFUHC3Cdwy17Hirda8i1rHkdVuBvXztuE4DmqQgNSkw2s?=
 =?us-ascii?Q?m/83J6GeiPQFcb/jVLrpM7j/OkHcQVPwdPyJ+rEScloTM6d/svSW/63RXTzq?=
 =?us-ascii?Q?eemrs8fN2m9xCdi28f07VRhlNjsEGD5nDf8Hafqw+rqH5F4c4dSR+iZJ5HwA?=
 =?us-ascii?Q?RkRxl6AZxyNAC01GnJB7X6bevU/npUnTeRL0mYbUv3NSCihv3f3qhc9W1jBi?=
 =?us-ascii?Q?8pvvVcPxpk4zHt4rqJdfVDa3P6WRWBD8OYZrIzdPP2aPvNmgYNgplPwJRNsy?=
 =?us-ascii?Q?kZJwiB8zx/BMbe5SdCBKoDnvJ0oWdmQqdFwwrkgQ2WycL+KF5Jsm6ikK+mTP?=
 =?us-ascii?Q?hj3EM7pWCOxUi5pWPGv4SkYi3y4XbRCdzm2QpU2leygj+C5P2WHy9Fa3Sn6P?=
 =?us-ascii?Q?tpteHs3mnTK7ig5zcAgb8sKKnchXOq+j2QiOm+kdvVHrkfrC8OxOskJQr4DR?=
 =?us-ascii?Q?ZcLz6vwH3dxAw6x4WD8eLFMO5ZGQDg3cfM9PQD6ayte7hujV/nsCyppxFOG7?=
 =?us-ascii?Q?+TmqXUjh7EbaP2982sY5HzRce0MMYBjN7lK/lvBuLIdGCSmwRBQiIpBwKl59?=
 =?us-ascii?Q?22VF1MDKgyqa+2TBndJqNe9Y84fcuRkixxbhat9dM13IycQ92bSyQV+LHPET?=
 =?us-ascii?Q?+qRT5QTmxjJ2O85yLxHJgdMQyWl3YBwH7YpYfKosbKClVO+dDI+QpnNbk627?=
 =?us-ascii?Q?GEziDegcry3K+ZW/swm/4/iDmYGdwCXwArZM91hK0XntjmuUTsCxUYYA3x6c?=
 =?us-ascii?Q?Znul6586CR1yVkjho7f3p66cJOEtQqwvAHlgvOzMes6syfbGC18fwA7OtIKp?=
 =?us-ascii?Q?C32Zu8y3WJEctaMz1Awvtly2sUvTf9sCunLJ1/p/pOS9BdWfT11Cpz73EMLb?=
 =?us-ascii?Q?1cptkChl3gBXnOCJua3BJNGT88M9GKbSK+YHO8BOuDNTPSjhMG06WvQyKZkv?=
 =?us-ascii?Q?r+ekJx9sT9AouSnnsk349vKJf+6TnHysfesZgidN+XCXSo/xRNRtMsMSzHi3?=
 =?us-ascii?Q?bIdZNo/WtznFscybzPLujatTqD26JX724l15eez5egRClNmSJmgDPioX5DnH?=
 =?us-ascii?Q?hfsT1bxkHo47FZ5a2+Sy31dUjBj0Eq8pPXZIeea9HCEtNsDts20KBGl1PZbF?=
 =?us-ascii?Q?xsecWLZ7jwv5ygKrtMJQ8K24YUpN5YX1eIXwmD+8CWdi/H8x6PijTetoo8Lk?=
 =?us-ascii?Q?Q2TGfWSmiQo0SIdARknmxJ9mz0MrkZFfXerH9Ln/VrdI8+k95M0iaOzkfVEG?=
 =?us-ascii?Q?vWf9XsmvGJ8Up7Uyrxy/UHKNgW+lmksN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:12:54.0609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf075d9-2bad-4205-86a1-08dce1d7b472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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
---
 common/usb_onboard_hub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 9ecc638c7a..a9fc9bba87 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -31,14 +31,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
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
 
 	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
-- 
2.17.1

