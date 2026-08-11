Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825BBC5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 10:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 477F8810C9;
	Tue, 11 Aug 2026 10:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52dhKDPtqg29; Tue, 11 Aug 2026 10:53:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C73D810B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786445630;
	bh=dVVOq6WMx3WKCwbWfl93VXbvrQIfgsRzQS3BEdzeqmc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVuj+yxdV4NxfeRqyJx+RVXYIDsfeiVNpd+xVCMQeikPIIY0SHmO8k3uK8O+6Okl/
	 scQRq5rzGsDjSbGlert7W/awUi5G+hKQB+cWn0cI++PB+EvtqkoR61VDYOc6sVSlBd
	 PthWVvBOhl890SlHBQnzVpKYwpT2oL/91LJbQ9woOtzf0zmmQcF/6OnSnP0k9AB7Dx
	 tOzulhRPxhqtsCUbp+bBYTkeEc+07aPqsNw2rLPqLWovcvkPfPs/VGqDJGZ6mUvxnF
	 +K/xeLEDUsq3/up6R5V4jG0Oquos6EJTiM4ywGuWnuHEOObup6ZNmZC6/LGufPkdRn
	 4ic2A76bNKn9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C73D810B6;
	Tue, 11 Aug 2026 10:53:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD05B4E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B34F740752
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x5h7iQCAj-oA for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 10:53:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B05A64073C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B05A64073C
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B05A64073C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vjw6ItLTr8AVDINHNmffuSI7IgPQuFGr+wFBwZGe+eFq93a5fawnOLuAXDsaiI/WIGOQVGBPFAXkVV/pNbEJXF1E4vXwCR4U1/M+WQXGWgoEg0A6slt/Nymj6+PX3Em9wvi+uxbKNnVcjor2zFCc3xdYozwkmrRsLAdee4gvw7Flim1102p2U+4+3r0SxhyltxLGF96iZC65wgIEtiYYCdPb4NH972tTpMNZfr1tmuNqETC2HEEYf3f/s3ClCF20y7EIlD2K0LNS9ZuhNDIDeZH1OGxgXiQ/UOM7Ojs9ae0sPKplj1APBX7gf73fOtFBUdlBgm+fn75VdmLNY8o9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVVOq6WMx3WKCwbWfl93VXbvrQIfgsRzQS3BEdzeqmc=;
 b=nkO/MktCWVge23cCrFy7HgMfILTPe4FBb5SxYODchqseck+F66b0iP+y7xvxz6sAGjqLdioAdnVn6DUF6pfpQoXLAgWA3nr67m5Cz7pfNaLiIXfCAxlaTj+TbzEdSYBrKYcnnWDmTRSrFYxYC4+nlfnfCU78pXeBlVfnn1NAHFu9eWTmmhoGDJwL/kJD0rlbGZbNo9GjppMFbplX5NugtEH7YDT5/zAQ6mjGVlznKq1PMJ+wpVyzZgMDT/VCuqwTHjXm3r8CRsPYlf91DN7QN8ddIF/GTBDzBl5yJITSkxxkTtEy+8vEYxkhD8wj0G7INZUO13gMQ3msT/Mbu09s6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from DS1P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::17) by
 IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 10:53:41 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:8:455:cafe::a9) by DS1P220CA0006.outlook.office365.com
 (2603:10b6:8:455::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 10:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 10:53:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:38 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 05:53:37 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 6/6] gpio: delay: free already-requested GPIOs on probe
 failure
Date: Tue, 11 Aug 2026 16:23:14 +0530
Message-ID: <20260811105314.3837228-7-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811105314.3837228-1-pranav.sanwal@amd.com>
References: <20260811105314.3837228-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 06705507-a3f2-4deb-487c-08def796cdce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MmB32pIT86kyDMl0mpVa51qV0dH7mrNc3Jq+toH73rfP/yu9FN6GhD8pkTcDGB4hGkNH2cRPC+9QyOq8kTaW2hX64fVkfskykWn29Xi43yBicJx2EAHxFQDWgpNoX6cygWoxetnT1voptlC2R7COyIj3vMF8Cp6vpM7BFF+CVjE44G9wpAR5Bg1svnvBHMsdnzdP8Uiitp22Cls8N+0hxNn3p7ZV4Sh2qcFiHVtmzC05VU8RBx8bFvhxxOcpFNZ0MRCF+dd4W4PkcCqn77tdnN8NQKqFG40v8oqqld0Qntp8AnZpzEs/Jg6epwEPH/E2I8JYtR/E81ViDN1jMjF1anu66YOuhM8jQvVjwlYlVVBvr76OaLYaGV1UT75vXOgFcIQ1yOgc3e9sGz7YTDrf/n6W5EvGdgy9Uqn7bTLj7IfRaaHzNKVsAvXPnWD1QVR7TQAHaYU2Uu2lf/3EEClQKjI1FFJIyc7paTsb8HAZoixng3Jupi4793CfcGoA1vhZVJLiAkWqjYlSVNz3bDaTDNzkuxKEBWVkxXLL/kcIiP4U+t4wxAmKqEl57xhCR0/ByO1N8A8H5usUiIOAO1HEBJ3ckYTFViYWB5F5BgrhCuI63J7Zzy5K+iSGJl8eGhGVVhe+ZREhYElUcGTqQqOvrojSLV8I50nrWm/onMEa6yxrlyvkhmv88ioLUowuXlZx2gumK7JsC5nBJK5YZjsA/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pvj/xjZMbJ9qbtPT78X/fK9TpKk4wxYkE1TrgTksA72YK98jrC169osLgi7nUWd4Rz0T3M5d14+9kV+winT+om2P8HDLzgRfxUkkGUWHWiL+i7FqkMXMfiq5JQLub2MEmLbMiNJry5UQ2WYVQHc5/Hdg3kHdoa8lRl1yOn7Hl/o4xqcKojFhxVzzE5ZE8hKDpqtg1uO/M5VxWtXAaJ29mAVpPUsmY8qWxFBo9bDwVCyoToCLpAv7htcGGy71HizxKZEOF4BE9Ahe8HUcmRNoAWkh9a9r2wL3T9Tch6mom7ciX5/Oxh0TLAhKASQWgpF+9/NtKImNQrWX3IdO9olaDEAHM1faW4jPY+1eVpd0TrF8k/KsJOAxpl0yRT4FGpA+i0BNclnBEYoEXU1Xik0RvyLV9iOYvX8kg6/BK0HuuKcg8Gyf6m8vzct6aiCxukm0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:53:40.2408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06705507-a3f2-4deb-487c-08def796cdce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVVOq6WMx3WKCwbWfl93VXbvrQIfgsRzQS3BEdzeqmc=;
 b=fmEZC9rUeuwlh5D7BkAfuWKiD+vzJFa70sz70VHQX8ITZzc28VOmUc+CEhdYyzSC7fLaO9lPTzBxxjNbY8YABOwyqwH6RNfYyvwobslZHerlMlTzhVFoO9hjd7xjqj4nE9TIxGelJCK/nvc1C8XGUto1aH+Ieru0dtrD+aGZ+7I=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=fmEZC9rU
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

gpio_delay_probe() requests each wrapped real GPIO in a loop and
returns immediately if gpio_request_by_name_nodev() fails partway
through, without freeing the GPIOs it already successfully requested.
gpio_delay_remove() does not cover this either, since .remove is only
called for devices that finished probing.

Free what was already requested via the same gpio_delay_free_wrapped()
helper gpio_delay_remove() uses, bounded by the number of GPIOs
actually requested so far rather than the full gpio_count.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
 drivers/gpio/gpio-delay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
index 27fc59b5ee4..747c520fb46 100644
--- a/drivers/gpio/gpio-delay.c
+++ b/drivers/gpio/gpio-delay.c
@@ -150,8 +150,10 @@ static int gpio_delay_probe(struct udevice *dev)
 		d = &priv->descs[i];
 		ret = gpio_request_by_name_nodev(node, "gpios", i,
 						 &d->real_gpio, 0);
-		if (ret)
+		if (ret) {
+			gpio_delay_free_wrapped(dev, i);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.43.7

