Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9C6CED266
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 04:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCCC88E32;
	Tue,  8 Oct 2024 06:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U/JzHEJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE20688E17; Tue,  8 Oct 2024 06:58:47 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 749BE88DEA
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 06:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRCXvnOTKYme0ITH1wrhYCzhpSPhCNLw8PYzjsG6aUinbcP/qsu0qanDMriR1ep5qXtUJnIOM+5SOxFa0I6dX64UbztW2OODD1GIXwTlxBZajpyorbaxaxCvqnxFaYfsPIrXezyfYpYHjF0c3pr0BWbPfgY7JTxx53zxILAkRA9wOwqgrhjD94BeDnrjVfLtoG9IFqL6mSqaAbgZogoUqTZRS/L2KGw+3AfF7hT4+3Bra9ILRZkUXjo6Bflg3MGoziIeXgK0w+SxXb+0VE8A5L+V3/yWJkcFmlF9vUYikqQBNCQkLriQdyBOuPh8JdRPpG/TIlv6LIkksTB/p6EKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPZ4NSPISvTEqKCwtvXIAxgXjG+Dt6A6HVT6uMotEhs=;
 b=t+/m5QYiXnObd2YxIDWItcZAZmhU+jKCa0mU7os2zwLAWDZQdsVt8ZIHRwe5g7Pz0nhdSHWwxtJnvUq/KU79CNSOq1/3iYq4AAyvYIVOSs4wrx3oagKVz0eYw9vE+LzNLCudNTbgm8fnTmSzVSm9gpLPszoa1ZSjLqeOKc+WbORl8reHIvO0+n555WUwUhGrfOSBKjoAKa/VIm0MrhsFrmQnOZmDuspXzG048rlTfSe1R9MOEaVEdZ8zGpPg1mPXAg+sYQv9FNKDHuY0/70b07YtXdMjlkjgGw6+tV8HmFF8lct9I3mo1aJ3E1zu4pKgirPcuo4bDBaWRPDJJ09cnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPZ4NSPISvTEqKCwtvXIAxgXjG+Dt6A6HVT6uMotEhs=;
 b=U/JzHEJw96XYbGPMHHqdS6cwl7h/FjVBf3Pfzo4+z5S+KL1UbaD6+xUCrSAGw/XOpQXqag027Z+AtKhuE9Ol89XhzPcGyxSVn/FmksBWlj2DAcP0iFAY2BrFsDGB3csGDbVoOoklPB8AFNE+0QgN9QrjQ8CaCVOLGkaIMYY7Vhk=
Received: from PH1PEPF000132EC.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::31)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 04:58:39 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2a01:111:f403:c801::5) by PH1PEPF000132EC.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Tue, 8 Oct 2024 04:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 04:58:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 23:58:37 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 23:58:35 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v6 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Tue, 8 Oct 2024 10:28:06 +0530
Message-ID: <20241008045808.28757-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
References: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: d1c3cb02-a1c4-4f79-2417-08dce755dfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MiDEcIV8dJu1OlaDNTMStFW81xWQyOZ4SSwUKaepKFsiyB13Fr36ASyyu2ug?=
 =?us-ascii?Q?072Ni3sWPVxzrWTSKmkh/9FFncbIGs9v5lcnnuRN6Z7RdLqg5XscbSi7QIjs?=
 =?us-ascii?Q?rXpo2ttJPnQH7c3GBvPSKHf5pKi8BGTEitcNGGPAbmnM887OHiQhhiPBddui?=
 =?us-ascii?Q?HDZehcTpi9ll8N/pU//c1tpiKRucotdteB3QxkMYgY0ofpd4B4yxDdp0+/lI?=
 =?us-ascii?Q?q9wgbZj/yN8PzIz0ZzoeK6KB0RFjQ19goIMmp4LZLzPAuL9I/DH9wpUJ8YyV?=
 =?us-ascii?Q?CQqeKPaipRafT0EadCjDcSrdZSJeBCob1fIYy8yCh2hvJJErA6PIgfu7dJFE?=
 =?us-ascii?Q?dGNgq3ruAiC6DKo8jQPgjfd8upJ7wef1PG13qqvRV1/4XCHqPMcpZpNSSe4V?=
 =?us-ascii?Q?DCdWV3L92P1PQ2HwKlgQO/7iX36q+pKlIt6JMBIJU7LH3ISrby3RrUUcJEpo?=
 =?us-ascii?Q?cWAVqzFaeObRy6sPZ/kTdEaekY0EcwIMuBhTGw2pztiINTCTPsM5lM5pG41U?=
 =?us-ascii?Q?tYLfyjmTctCwAuVLfp5aCWUKycyUZ68A9kr6GCF0Hbs9KQ5+iEOCVarbfGoj?=
 =?us-ascii?Q?YwIPpcmBA6Ycpbd7cpt0BeVwOsARbh8mZjKA7vw7h9McnjRW5mL5U7ZFl2/m?=
 =?us-ascii?Q?Pxf/OlSI0cFh6f8NI2u08cREiGTfLxcik3WGIttM3EuVfq9N0w99hqCHaW7J?=
 =?us-ascii?Q?I4rjmcjI/yhBehd+sjGSxr2L9EhPX/t8W/EITGXqc9DdNWvyoYSTx/nk/Jaq?=
 =?us-ascii?Q?AgXe6UMVJWqVQp8YnK5FD3Ab3mtCeXc5oNE8rlWUN5pyjOavksVEsRrxPPa1?=
 =?us-ascii?Q?XN9FaqyTtbCplCjO7GiFW02pnVOI3HyQm1RicQmsqAigCNX3Ah8fM3rxrKo/?=
 =?us-ascii?Q?X/7WKcs9u4pg1/2wuiZGpmhxhqItNpZKaGdb/CWbAX1OyfhPNAPfGUoRlY6l?=
 =?us-ascii?Q?fgalqkn0HIcw3gOJc7R/3B+ugxIHfsy0cmznN773X+S4aItsctUexLwky7cp?=
 =?us-ascii?Q?tIfaNmEu4HGtVo0NIdulryk+lszwiLhQbHO1nD7NF108DpyzGsDLl4bqVbjU?=
 =?us-ascii?Q?HnOqMX8TlGeSbaakyoDsTGiBflNz0la5+3qyXhroCeuVf/8N16UorNl6ra/S?=
 =?us-ascii?Q?8gsJHk3ktelRHyBzIfZFbFCl2HlOjdWe4s8hIN8xVR0D9GjORu6WG9jtgK6H?=
 =?us-ascii?Q?DCF4hdasNSpXhTjRljCjTKXTEMIdo55yiY0Tj6DZJGtkyQFfK4smzmnvWMtQ?=
 =?us-ascii?Q?j88KE6BzvZhpH0seNsWcJx0+zyD/seNgHfpA6pv3izP0aCV/uVHPBJRMkplT?=
 =?us-ascii?Q?QYAPLLbL4sPM4OMR1pSrVFpr5O6Ta19kEzmRysHTF6Xjw3+jEkoMHpi6BQQP?=
 =?us-ascii?Q?QOymRRDXWNcO1dsZo0h5JprnW5lj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 04:58:39.2223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c3cb02-a1c4-4f79-2417-08dce755dfd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
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

The .bind function is implemented to bind the correct
"half" of the hub that the driver wants to bind,
and returning -ENODEV for the other "half".

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 5588a3baae..a90f409719 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -177,6 +177,26 @@ err:
 	return ret;
 }
 
+static int usb_onboard_hub_bind(struct udevice *dev)
+{
+	struct ofnode_phandle_args phandle;
+	const void *fdt = gd->fdt_blob;
+	int ret, off;
+
+	ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
+	if (ret)  {
+		dev_err(dev, "peer-hub not specified\n");
+		return ret;
+	}
+
+	off = ofnode_to_offset(phandle.node);
+	ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
+	if (!ret)
+		return 0;
+
+	return -ENODEV;
+}
+
 static int usb_onboard_hub_remove(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
@@ -216,6 +236,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

