Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27012D3B7D2
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 04:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601568919B;
	Mon, 25 Nov 2024 05:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T/6Tyzej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88966899E3; Mon, 25 Nov 2024 05:12:43 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52AC388EF5
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP5HZUbbtNhxPcFyGluuG0M01oN+vDpyQ338xtUqL2k1kfRmk0wFW620jrzEiTzElvAlxv29qjQ4o1s6/kwZlT/Y7wz+mHaKDR8jvNPQYIJ3WzplTZ+bjObglGe591HEgGGvfwuqctJrhqpAHqKDj0NKCcKDg/OlLaUpLLfsL/TAFsd7kNl+5vjM+SlA592Ou6iubEQeG3AffvQUYDWyTMQM+IOCLC6FFQPGmrRCJDaPojpeYXVr9avmuYHwSX6hr31/uAQQzyKj5mb/xxiFxDGejz7N5bniPe1ioua6taY43bhaNj8u/d1b37XkVRxI/1odp51DN+HjXgYcLMDVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+15XPVD5IrxrBHIP/gkNnDvS36KFEgtNQHrsbnal0oI=;
 b=HJFJr6vcXXBL+R4P+xpfTw+icjr+diC/Nz2FMW5n7ZAv9/A67efRBWPtjcRnd7n5HMKLC+4FY4/ScXEZqblpwv3zI6d6XIOBVlv+kj549BTsJHpWWhZWlJLiLNxG4bvFffJdrp78sz3xAG7PID76Mr7Dg2eYmemUSSn7Df42fwOyAZyAy75Lob3Y0YE8AUO4yBS+FNDPHJyQ6BbH7wm4WG0bxS3KgBurlZP+GXIp//BQhsJp+wy6ExIUebRTjp2Nq9qF2bj2Qx1hsY0AkuU6r9X3ciu745xcXqawMKlbRDCl2BdUzsJ3Q+TA4ARL0on5tbBU7ygMHHc9YQgnDJcSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+15XPVD5IrxrBHIP/gkNnDvS36KFEgtNQHrsbnal0oI=;
 b=T/6TyzejmY4n4gvI9aG4xwH7P/6iXcIErKLV0Vr91lubQDwFpCJedKqWdL6sq7rsycW31fEFbvqE9bZzGxBZMy76raWS6udOTDC0oJYtxcGgLuLXlr6FXFpPQKid6s+VjvymqJIm3GpLnvTtWx3s4tjEoOrDt0MlsfDcMR3LEQM=
Received: from CY5P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:b::26) by
 MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 04:12:37 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:b:cafe::1f) by CY5P221CA0012.outlook.office365.com
 (2603:10b6:930:b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend
 Transport; Mon, 25 Nov 2024 04:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 04:12:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:34 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 24 Nov 2024 22:12:33 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v14 3/5] usb: onboard-hub: add support for Microchip USB5744
Date: Mon, 25 Nov 2024 09:42:00 +0530
Message-ID: <20241125041202.980-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
References: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 3217f735-6494-4faf-be24-08dd0d07650e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HgkwAlVQaLRo6KTgmrI5RGjTABSrmp6XFV1TJZ27YO4jzStE/Pg1/3lvqmyQ?=
 =?us-ascii?Q?FbgyF9YP9N3/Uvg0UGzV/AJUfS9/J82AKldDoiAEq94Q1POZnMKJZGLFucew?=
 =?us-ascii?Q?ndyQlXJx2vrwvV7VpvfTi7gRdjFpp4QhzPGjVan+5hfwkQjkEgCoI6NWwoTt?=
 =?us-ascii?Q?m51P1UVAu072uBW4T4x8Ldv+5i4GpxJ/V6+CnvH/t28uUz3P/A7TE0nTiN5i?=
 =?us-ascii?Q?lQ7FE+XuzWSl+7yiD6WKalZKxvFyHQOUPqGWQkrZp3pt1a7QLKoQ0T6Kg6eK?=
 =?us-ascii?Q?2mdbfkePeleUTOLY2hk5vgXQRWGg00HNEfQNYBEUxNIdr68jGlynYhj32QX6?=
 =?us-ascii?Q?hmVJLG/7nJPhk3t0R2qQj3AVNZn3voGNI/XDCn7ip3QOnLdtzmIuSSuepdDN?=
 =?us-ascii?Q?QxKAwEmoKqtpUfpS4AgZDN+oF/hdg9kHH1wSRs+Ursr396Xkx34EXo5qFTol?=
 =?us-ascii?Q?vcFCiirEczIxyftTARzn47GuSdV4DLr/eel9IXjFu/JPuUignz0pLM/KZi41?=
 =?us-ascii?Q?uVKX+3kh3/mehNC07hB7SU6myW93Szf8os3i4Hd+4jyWkC2DpUNtiwOR86Uf?=
 =?us-ascii?Q?m8R844SmRsZRD72BMAQvMG7pWIv0+ypCF8JiVPmNRoXQKYfRjCnWn80cNeuk?=
 =?us-ascii?Q?DSLY8pphIxjWtgJcVlHSeQyw4qhQ808vUxCqfjRJgFvekgE1hSoy5GxNV16L?=
 =?us-ascii?Q?lvXUUqjEFVRsGmupxhFr5FSSsPuxmH3Ug1ewurUxbUzIUHNHRBj73n9nUDW5?=
 =?us-ascii?Q?AxqO7mlPeLrSUbs2a1GB+NENaWC/mjv7BWN6QHC0Zc1+QC8xtbVkm37URSKM?=
 =?us-ascii?Q?Z4bT6IREKWEPPLJywsbIkXqB8GZamUu1M0861E1tt/9G2V4zr3nYPfUG363U?=
 =?us-ascii?Q?8e/8t2ztx+4oCYKIKQqR+wuL/ID/pZk1/3VTJDT5+0bCd/xdotJvnLACMGcC?=
 =?us-ascii?Q?NWACxuFvwANucpSiagLoLbbPrZNEbbFyJxZ9gfhqUu4pbsHHcArpOmxwZrRg?=
 =?us-ascii?Q?wUxfOWrEBir1/tlXdB1AVvlzjsTIE7VLNSG5s4+HwVGY6CSrYkshtGb5HaET?=
 =?us-ascii?Q?HrK91TKRVk/NyFgPGDk1CLl6HLOta4Y/fQ4NZgdmWvSYAlwW0HJ1851gj9b/?=
 =?us-ascii?Q?ZyWVWWxFp4JhXHxDnJELK9CZZbppj8sXMd8Oh1kHmmvCAEvAKgIaQAyXWD2w?=
 =?us-ascii?Q?EZ90npEuT98wObXhI61X/lBeASaVpevDGEz2Ac4jDjMUQWweZ2DUxc3JXNjT?=
 =?us-ascii?Q?ObqpJhaukRZtpQ+9PKDUycs2H9tLmv04Uw2mmzkf/B3sANL835VPan0TwVL8?=
 =?us-ascii?Q?6o2l8u84AMRjPc0TdAaQ/OhLAXbzkealGnAhl0f4Rgif0Bs7k9cTAHA8mSC+?=
 =?us-ascii?Q?XLCJO0BbNIOyWCByrSuDocYKCF7gWcHxk5w4i4Z91SuMcBMRCpwuarXiRIvc?=
 =?us-ascii?Q?UiywTezZW7eMilaMaMM+xXUCINU6PWyr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 04:12:36.6313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3217f735-6494-4faf-be24-08dd0d07650e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127
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
 common/usb_onboard_hub.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 812e7749de..4860de5323 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -93,10 +93,21 @@ static const struct onboard_hub_data usb2514_data = {
 	.reset_us = 1,
 };
 
+static const struct onboard_hub_data usb5744_data = {
+	.power_on_delay_us = 1000,
+	.reset_us = 5,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
 		.data = (ulong)&usb2514_data,
+	}, {
+		.compatible = "usb424,2744",	/* USB2744 USB 2.0 */
+		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
+		.data = (ulong)&usb5744_data,
 	}
 };
 
-- 
2.25.1

