Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB42D74963
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 05:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56AF388EDE;
	Wed, 30 Oct 2024 06:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gBNvdUqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7038D88E32; Wed, 30 Oct 2024 06:22:33 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA7788EDE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttIobWV6Gim1ck5S7vNGRdWvCyuHci7uaSnybxMZY2omvG59/TPp1qClP2idqdMcCpITAJS2wxyL4ot3s9RgSbZjvggaR6Nh+5skPT2zskTQc71C38YL+ZaiqjaC7XyH7IZ8cVLsO+rBUhc23l10HzcuBVfxQIPT+nml9ZrZfWW/hjO8Y8Z+La3TpQo8IRPsZOgqlnKnnSYwQ/wx+jW01Kc/McjZ3+yS+EUz5zzAaSxOtlhv1XNkNMWN3MY8z+x/7PTdAorqIL7RMSCl2AGQrcV4H9trwdxCR5YJHCnXwlA7HpjLDia1J2noYSQWW0lwBL0MdjOdodx1EticsF4ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaSHtmp0jl+jly+Qik4ijvNonz6sxo7mkMJPVgIDT+E=;
 b=Itt7rATRbZ91aGr3rypkwWJlB0ga6WHWhDXtvClUzIf3WTJ2spBn6my2G3uanxW+9cYYcuV5TTVCxCybHkB8+v40C8wfDorJTbSm+RkQjGgx0YHxEpKoKJmkw8ax4QiYrsVdDvCDN958E7NwH69RvXCBqCply86Fu3I10qHo9pS9p96P4oTZDIHmbdv7wmpzuzYlMraMJ5eYIq3DpUwLsBjeL91Cj/etqWUqB7EPEzPIAOIXLgFNp34gs2NwFxWHN/BMHPXFc1gB9V630qdBrVfjLFs8vRB9vdBc7JYvJo/Nd2Shs3O9GxLShtzzyGAqvBeVHCeo8MjVCJ+ufSTkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaSHtmp0jl+jly+Qik4ijvNonz6sxo7mkMJPVgIDT+E=;
 b=gBNvdUqz4IGO5oZOI4vPjSYXGnIJ7A55Vpm4kZ4H37/LgWJ60hgCquOw1UQhzD7WZrYtF163P6oPXKGwO9/vonf7A8IiszC8CEJjT9TJUSdu8+QEXyC9MgF6e/c3uwDB3nP+nRh85mYuDuFSlqlp9pzgxMsrraPqiCFOuqCaP+c=
Received: from BY3PR05CA0055.namprd05.prod.outlook.com (2603:10b6:a03:39b::30)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 05:22:22 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::bf) by BY3PR05CA0055.outlook.office365.com
 (2603:10b6:a03:39b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.15 via Frontend
 Transport; Wed, 30 Oct 2024 05:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 05:22:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:22:20 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 00:22:18 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v8 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Wed, 30 Oct 2024 10:51:56 +0530
Message-ID: <20241030052200.24243-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
References: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 091df5d8-9cae-4a2e-5c6f-08dcf8a2d53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EFU0415L71mRKD2Iy9L9dPdjS0bwqRyVSgBMnFZXK+I1oD5blcXQhKyE5rmV?=
 =?us-ascii?Q?9ycoKQ3IdLU/M38ribk1njbegNTNld34xYUgyRI3AkrKT35LJfn0StjYZuwJ?=
 =?us-ascii?Q?XSum5RSEQ2AVQ1ujFc6Zq4kH3DhyFbYQTTCJmGNgcHSJF/ICv/n+cT832k36?=
 =?us-ascii?Q?DpWuuHtdjbv1XJIKrq7ogXkkm2wcHffUohjtku/dTOga3aiDNS5Js2UKZ2eS?=
 =?us-ascii?Q?A+qQeU2BbeaIzKacZt6xaN2ZEqbR2LzzFn/vSU2Qp6Hx+Tcm8qqtla9bP31g?=
 =?us-ascii?Q?lB1jB1TOAUGHlH3ykZyfrNLvN9HIHAwaLtMHAAgFwxWPcNI6DvRywydu5bo0?=
 =?us-ascii?Q?IeeBZSbObrZvqRM7CuAfQ1X65yZDoO/1iJ/4vBh/imF5Ki4/0Sd2Uv+ZMWCq?=
 =?us-ascii?Q?eXEzXk6nQwobrHwY3NlKUtibV4YtX60R/FPc25uUR9o9edUg5aRlRS84KOSq?=
 =?us-ascii?Q?GuQ61PBiY/WS8+5emu0Uc3UN8BoejAiljQq1Ygu1qKGcgLfHLgVCIHA3jmmw?=
 =?us-ascii?Q?Z3KGJAicvTpxItME7PHepCkKWYNs/YzuAQRCjrUthjPwZYbHkrWYDVPxbx/K?=
 =?us-ascii?Q?uNI+aNOaFHG67cHaLskuPYjWyeJl9IJ7/p/gtCvIFUMXnrvuP0YXJ7JLguij?=
 =?us-ascii?Q?bivTAe78i2yUdt+PxLDeOLAAI33gY6Nhf2FJE+8SE7yUga5xkPV3QnoMbbo0?=
 =?us-ascii?Q?qRuCavWrk2e54fjWX70pp2Y2XllvRspAeyogeHCC8wDBTFBxZP7TwRaSb193?=
 =?us-ascii?Q?QJdJAIN1rRlOdejLMT7Qez/t2Q7n4JzJdrhfOQUkem36XahOT+lBblCHERnI?=
 =?us-ascii?Q?mb0Tz5Tr8sVzvkF0/2qWZE/RjVYsvgk7/uCrD3Fh6kA7N3SBpQUw7maI7TF4?=
 =?us-ascii?Q?m92UH6X5TWlA8BbIgFVsK0xVTNcYntPzsmfXzZY2XC3FHaeunxEQqHOYWSfO?=
 =?us-ascii?Q?k9gecyO3n5BsgCqhmi4b1z/u7Cup1GZkTv6tQOlmRz+M9Xoa0lhg4twQCSUt?=
 =?us-ascii?Q?i6UhnJLcB9t2nPOYrJST/p2QBZHa7PnvxtAz5B3wwE62K+n3N+RN70y4T8OS?=
 =?us-ascii?Q?zlvpOpGPml0y+ePR6BQRF3UeYs1p7ePEeM+12sJZGYVxNM9ubuSJhpvC0Z6i?=
 =?us-ascii?Q?w9+OyAx/O3EyirKTjgzKOF2S3y8Blp6cTDSTN8JRxMBarRH+9hbuboZdO1m9?=
 =?us-ascii?Q?hfAb0cnhZ57GjzZZdNNCc4hVpLVWRLl7gV+T7dJEHjjtVruNVuIeJhmbrgAa?=
 =?us-ascii?Q?dHgOCXFsLrUW4ofUyrNorc47msB7lm7iDBpirFc2yg7BtUtbsEdFhhK91PSl?=
 =?us-ascii?Q?DnufDvo/7t+QNYMPRU7QFsvYx9YlP780MYd/iNly08SVU4HSbwfx2YZVcSM0?=
 =?us-ascii?Q?GZLglOPThwuG0ATXYtPKJ1FV1HyhB0P2VbY/tLfnUg1I6UOUSA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:22:22.4164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 091df5d8-9cae-4a2e-5c6f-08dcf8a2d53d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
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

Add support for the Microchip USB5744 USB3.0 and USB2.0 Hub.
The usb5744 driver trigger hub reset signal after soft reset.
The usb5744 hub need to reset after the phy initialization,
which toggles the gpio.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 6ef9c87fc9..fc7953e8bd 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -89,10 +89,21 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	return ret;
 }
 
+static const struct onboard_hub_data usb5744_data = {
+	.power_on_delay_us = 10000,
+	.reset_us = 10000,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
-	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
-	{ }
+	{	.compatible = "usb424,2514" /* USB2514B USB 2.0 */
+	}, {
+		.compatible = "usb424,2744", /* USB2744 USB 2.0 */
+		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb424,5744", /* USB5744 USB 3.0 */
+		.data = (ulong)&usb5744_data,
+	}
 };
 
 U_BOOT_DRIVER(usb_onboard_hub) = {
-- 
2.17.1

