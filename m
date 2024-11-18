Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF063D49205
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2E08945E;
	Mon, 18 Nov 2024 11:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gR8weT8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB21688E3F; Mon, 18 Nov 2024 11:11:55 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A94B89464
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkHqAAEEENPqIaf+PlSHbxr/CHsa8mGSAPwXyGhd3nE3WiLrX4fffP/RMTfE9fkVadYWErbVzQneGG7nONOYdFXJkdxZAglxtz9WE23ZQRkGZxPODGqU74keAMYKUDY/hscHzn3o2HWugVMBD2QUjj6z6PnP+GW2XnZB2iVAQTOWi5VM9TuCvOwpAHd/YMU+PVG68LjiiZLmXJLEyjQEHilNTrXLhsU9YvNNFbrzXDwe2WR5fGXUycfs0n7gDTBjdEkuBxBpl905YDXE9RqBAQvpSt3A+DbYMRivMXSBOVHYWund8EcHA3paIKlfnKDY57q78enhsVeWgf5h7UvjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrNXptky7iYzzB/n8vlswtNJJKQQpnoAdorfvGpEX2o=;
 b=DeIoOU1GgFwZD04QbMIw1VfrEgH0oG3DSoGwPe0zs4bwyTA1xPPOQ7oeiPs01edAK6rIGxHdlMvjVul+lxjZcrffB3WSjkDMvqagWY5sxhjcbLl03v23YvbvcIbUc/LaVlg9tzFoxrBs6e2jI0BIcd5NmhJprrk0zwOdEBmQT6HKzFrrSagJRpwJAxjiEGO2KovE0FAgxrT7yAl255juteddiyKGTSKfQjx02wt/FaoTgsZXgDYYdyvzQ9oy6FKaPEkWk6kcij+X+9sWrb7Vg/ix7em3f+1TF4Em7iHE2eu9L7f280i/a53SF85DJcEIH2EaiHn0eK36n1o64fGzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrNXptky7iYzzB/n8vlswtNJJKQQpnoAdorfvGpEX2o=;
 b=gR8weT8EY8ITzrVOjMFsbgr9BNvuiCYIEX8LfVLGFvG5i8K8odQg922lhXxn9sR6qOSpdP+vf7AZRr8OfAloTIH1hJa/+enADIuHka+yD4p/1z8B21N0OSHlQkFGFIeCZ1S6RmGc/KUgsfjTXslPnBekovQEy8TM6bjZFXbrLLg=
Received: from CH0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::33)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 18 Nov
 2024 10:11:48 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::31) by CH0P223CA0015.outlook.office365.com
 (2603:10b6:610:116::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 10:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 10:11:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:08:05 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 04:08:03 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v13 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Mon, 18 Nov 2024 15:37:45 +0530
Message-ID: <20241118100747.30121-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
References: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a74ccae-1ae0-4d5f-af6b-08dd07b96972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UupHWO6Soc4zKsceDldNDSJmevDvcQCgZXQLTraIJGvBEKz1Dm8HwKnXs9f4?=
 =?us-ascii?Q?PQk85dAbD8yju/v/6/dysh9LQ5V+M4EZrOAQmJc1m03JtfjzGxR/ADt165Lw?=
 =?us-ascii?Q?H+YxzjPnMuvNXKbIVe93H58OfXzZ+x1cIYto2jjfG4Mfx4dhvOsEXGXSfWX/?=
 =?us-ascii?Q?eYEnMkTxkzW9ZOXVovl4hNbiUylFLZnhb5B9Gz6RE3wwORsI3lDo9l2mN1VH?=
 =?us-ascii?Q?Y8DLcerQqHi5V//jmsSLqln2UOqkcCXhwWZHoSLrENudBfvICUarurXMS/8z?=
 =?us-ascii?Q?ZtKXdpMIPAfit/+xy1JU97xdCWLzixQ/EJz+v+bZttXhNlNTYSAvCERvlYXZ?=
 =?us-ascii?Q?rgnxyZ5EkkRzqFzg3IHRc62iWflsKfFZS2fUXyc5sY9XS9VXS1VF/NgkNcfV?=
 =?us-ascii?Q?5NemcOXRSWqX6qzXhR/HaJAHdNK/kkj5ohDjNDm5Ns1Med1iuTNO3EtYLsLA?=
 =?us-ascii?Q?4kr8AkQ8ZN/e1LNiv5Moezz5XTbc629J8mtrfZQsIp1n1b62hdMsCvFd7tTK?=
 =?us-ascii?Q?GIZAGhKPSQ3waKCVf/b7cVVOnRStp8dD9WX35l/MVAmfPD0FKLEpn7KVBPo5?=
 =?us-ascii?Q?vR2b6sF+ve3Ueift7FnCQbw4vkCl6iXSiwGZJFtfiqyVDc6goVllieHR0JdH?=
 =?us-ascii?Q?iWo7pMOgoR+9MHvR6R2yEAtqUSiKlgDse9VCDUqpcM3V+pIR2bEsKeUjMyjg?=
 =?us-ascii?Q?UcFjEGFF4AMq6ISCd7EJE4MVDrHAeZe42Z0si+Qh0803/54hS1g6RVHzlg8C?=
 =?us-ascii?Q?cjAfNpMwTcwqItiHRrjZamWFa51e1n5TbgSHfc8q3nPLlxjInbfkl6/zAwnM?=
 =?us-ascii?Q?fRRk6U2VdpnRDdzEZqcC+EIFgTKlnGhxbOqmVBRdSgVKCH4tjjHWiUbmVDsD?=
 =?us-ascii?Q?/QqZ1Oja/7eHph+JA5REDCm/1GglCt1HEUKA0AysKrTfsmQRwyllGBcgWenT?=
 =?us-ascii?Q?jT+R7zzQXS+mb6nu1oDP8AWubTfvLtnGsYzww8KbH5p6N4lTMPsIo6myCMdr?=
 =?us-ascii?Q?DG7x7Pl2fsk2nGz0D3/INaINXiH3Cwgf/YCZU+nkvOMg9HlJol1ewUw/M719?=
 =?us-ascii?Q?R1IF/fE0n0mKBeDUQ1sV+TEERxvXdQItCVHi3+u9rAtNbRNLPubf8hU/re3g?=
 =?us-ascii?Q?bCT/mN6Q+v2wcWwQ0q49DuECk2iBclr77nUAJV2QDSO67pzRIggfLO7AOk7C?=
 =?us-ascii?Q?sj3OvrKNrB+lwfctcjNDCFxT5G7NnyCRQzpvyWzWPJcHL5xUNp8JIe3VNR/3?=
 =?us-ascii?Q?Au3ADhnFSn+Km0mf+6vCq6gS31gl5VJebivYTKfDIfjB3cbdCZj1YYx/GvAc?=
 =?us-ascii?Q?EoB4jUWpHChhQ9iU1k92226Xz+fVZGjG+k65gRwuLcRIB7lYnK5XQIo5MVTY?=
 =?us-ascii?Q?tHsTERumizj444FXTHJeQ4p6d07eCxGZ44Y3AgdNxkib5ue8Vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:11:47.5008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a74ccae-1ae0-4d5f-af6b-08dd07b96972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157
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
index bf71266272..6f28036e09 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -176,6 +176,26 @@ err:
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
@@ -218,6 +238,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

