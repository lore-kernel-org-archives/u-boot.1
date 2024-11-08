Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56742D5E124
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 04:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9806788DD0;
	Fri,  8 Nov 2024 05:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UT1q/wio";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D08E88D5A; Fri,  8 Nov 2024 05:00:53 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C827688DD0
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 05:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y466DPWWRadfafH2v0lzxig3dh8rVcf9VBmlIaVUEKpWGioCN2IU8j6duG9HukhWGv7zWcYHLW587xIL5M58vRfNH8jieO5N3Uzyda+LL0Nn7amUSTbM1rAkUsoSiaKy6lbWRuy6ptd9rPP0rm6H3iqwhPCtAcEyPGo2WMIWpMhPCeD7mg6sYbNh5MIxpFnLNKv/U/mk1OgVADQwuYS7qIsiV7i85tb0cYZJ/HitaWmYCEICIVxzKvaIqRsDGCWiwinXjfVQTmbY4jFvzlzFJQMLr5CIIDu+k1r0ySJDXEsT2hrEhyipCcaa6OPOYJF9r9JHh5rozK9YoeA9CTBsJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XC6JohDEBTJKf8gC41uhw07UpwVf8HZaWZQLszHGntU=;
 b=tkqj0mVYtwY+HcciLTuxvvz9MzjP+umdyYWm5HHa1uCoKTQErpczaYWY8wMBSfcfTUnvgLALI0fa1HAzx4tyb+CvY/y1EfBs6V/hRbA+m+quw/Fn5HH5bdrWXANu8LjVIWASAVFrl8uT7x8RSElWuhjzBQQ5QBG7AqiW1IiV8KSeY6PFfcwHQE52NgKk8TPhW33jkzzi9q4FHOwSpjkgAcLVLKbGEv7rXAdbuAF6wz8UDatiSygtMRX3HmVdPalMMorB8+gCBADZpgZRyfOjyaW35VJHOXktiw6o51H+NcRSnfKVeYyGZO1knmTrXbkY7lLiPU5nT2M8kDQB7UC+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC6JohDEBTJKf8gC41uhw07UpwVf8HZaWZQLszHGntU=;
 b=UT1q/wioTQ0GUAIJdCj02jEE2ZMKP96xwm/PDc57s4nNTLAdojH95BYJllNMXt5sPElh0OoPfSkAYsMxVRP5CuYhcautD2mVIMtRz8AVRGUeqxz83YySOMQAdkayZwicUaRRn2zo/hVS3pjYsj+UZg+A2+SJ1kwRqpouTv5X4bU=
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 04:00:47 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::54) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 04:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 04:00:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:00:43 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 22:00:41 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v10 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Fri, 8 Nov 2024 09:29:57 +0530
Message-ID: <20241108035959.19970-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
References: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: ed65e8b5-635c-4463-4fa2-08dcffa9ecec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t4hOokVAKWc392MkEjO0a+n7vZCt2gYstFGdLxixu6tQFaEiILa9kNlDpySi?=
 =?us-ascii?Q?qAXJVzE1QjfOgICGbEwr2M4+ZZah3FQkQYSGrx6411nI/Ly/+5/ohEST/EUf?=
 =?us-ascii?Q?m+hEFVRyyNb116wNa8PlDcD4Ul2pjP4cvAXHJ+9HCHnTeeDkVQ+ZR5yl99Kf?=
 =?us-ascii?Q?ve5teLJPSai/W2pvMVFprKuzgI0fbO60Pt9+2TB2R4386aBq6b4sDOTEi6Ih?=
 =?us-ascii?Q?FVBeNhKzenm1rX5QtOX62ihaesqtvbhsA0xD/FtEC1cYmGy/DmQbho4zDOXp?=
 =?us-ascii?Q?ofh1FR9YqFQiW8b6r+LGER8408vHrw+tSXCqT0PIKaKv+VvjUYqvU3YJvkDi?=
 =?us-ascii?Q?MCoKm8I04kDrZSKq9iIYTtrpxWmVsN5Qp6NjIxv/De0Zvh70JzXBq/bg/oAO?=
 =?us-ascii?Q?uVfMAbKFvD3fvCYmK0rCQPz6BTJUVWCxdWNh/JpwK/q+SR+6PhB0PMR8fIww?=
 =?us-ascii?Q?Hae36oNcjmwfgV0LaBt/KNm2Shs8/83ptCyFQwez6FvG+62C3PGzzK2ND46l?=
 =?us-ascii?Q?gx8aMbisK4i/bGYdMj2SWIUvIsJYJBgqyrlT84Y7VGVNgCy2mSqfn0MFTUlr?=
 =?us-ascii?Q?dMjFokWEJaxwWP/MvfEuMY4t9tGcsVca1RG9iJgrq/jGiT3iLBqnN7hoczm7?=
 =?us-ascii?Q?w4EhLgxLpTBMIjH/OjwYWj0RLy/HCp+6/hJXztLZXIRte/8d8G+PzDdmaMpM?=
 =?us-ascii?Q?WReX4+OtKSN6v6t3kxiFlJbCbhPj+ROeDKd9MIFIL75BLN9U6fsKWyqHiqYJ?=
 =?us-ascii?Q?ai92VEfeqCw/A+t/aQNXNDp+sEkC/Gw/BisQRus7ZIfDeJMmfmCgVyCFj5fW?=
 =?us-ascii?Q?SAL0blQSZRKwu/0leCE9gXivMc6xTxxFcsgdAgDanVMG08nWeP/Gq3WtgWuZ?=
 =?us-ascii?Q?mAT9JhYuJmZVWoSCjHYncruBrVrtmYK976enVBLS9SwJormFYVubx7WNl2Ps?=
 =?us-ascii?Q?SPLfGN9tWNhHLBnmoEgwhLg+EPFMEkiAiw1pEkv0BPqUh6cbSjDvGdzubGf6?=
 =?us-ascii?Q?tk8DDDJTZRmB5K3B/Oz9mVdO38H/QCX8Ks38gL4OkYnY90H63jmMuh8DWK2F?=
 =?us-ascii?Q?uU7gq0mmLMnlCpaIaWeOEhEHhdsptTPxRme3qbSyQPkBoXJCnLxq7a5eJDHp?=
 =?us-ascii?Q?oPSOcy2za2wbjLpBtePA0DJXumZyEy6GlN+oHvBflDIDtk3m64O88PuqzSQF?=
 =?us-ascii?Q?/gQ2BO4a+cjH9unnIuiGxNv9OpcPeMyRlpGLUWTz8Sx3ETMhsaSd7S3gtlQh?=
 =?us-ascii?Q?MB3F271S5LuUqe+/79T523xm/vuIAifLIY4LnhXGk2c+KV8BP4/GFa0EzoGL?=
 =?us-ascii?Q?Ul8tl4/Gl8C20cjOGNR6bgPD59pc59b2V8tk6GYEOJs/pNYKyaAppjodgWwY?=
 =?us-ascii?Q?jDQXuFWmaMqHf+S/iDdKrtjfaudxhfGxuVe8xRbe5FQPTtnuXQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 04:00:46.8452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed65e8b5-635c-4463-4fa2-08dcffa9ecec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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
index dda41e1a94..cde1662c3b 100644
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
@@ -212,6 +232,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

