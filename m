Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035EFCEBF65
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 07:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF6C89099;
	Fri, 27 Sep 2024 09:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MxdRk7k2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B331C8909B; Fri, 27 Sep 2024 09:01:56 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F92B890AA
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a992ip0pea8qTFywxH5TWdgkuICwnfWa/GMNPMe8nrSihjtpIhYa1QAMoxQLnbvi2xaRNqZmvVmBW0H+MFC67fiWiiRxCLsQG7VJovMKgBzTzQ7ZGDDAjiPMQugt1sVLPU6dAIJxC4MIFhO+1QLlbU0dAdKKvOOVFfRLrR8uOyn45FYHpDpnkOXLOMPOc9kB1tD9UVf3hgmvOCSaI7mpLrAiwO7GmT3GSIdauER3fpez3slFlP9cPWLuWnHg11imHKeyrPh6GOgCV5kj+90TagfhQRJ2yiks/ioIY/7GPO9RrHcWIe/ZmwX/oieTGU6cJVfg+dC5NXK6ama4ugGxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr2G2LD9DXqJWLIfIGs7Dg9sDiuyBAofgJH40XCCQ4s=;
 b=BbTFRu5pe/GXFXkKiw7ScBYq+9B7EdBeikMDZo2gvygJ6L7e9e0kI8ZWBAGX2i8I+u+NEkROxkbgZzVS4CuOKOFi3P7A+faUCbwPBwLl+/d5GXoEoaE8nPpLpCauxs2W/tgEDiHiv+WxmumzRC+5IPL77pJH9TdoQEyLcHBjt4sCjQZOwEVY+YJYpAZZxMa9Rm0qIBg++MK5TF91QnkxJcuQPJ027dIM8Tj+szA+sjn2rdrgBfHdyU5Kq3S4tyYbB3Hjc7sCDL9OzPtCUqkVDENHXxcOEl5UM8GbcRehZFxhSsfGkZ8YaezKIifK46miTF1ufSyc5sdffmZvAkI+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr2G2LD9DXqJWLIfIGs7Dg9sDiuyBAofgJH40XCCQ4s=;
 b=MxdRk7k2xkkKkcdR+vJqLdWcp+2vMfiD7b3w5WTLa0LyefN/aZxh2OCd2ztMTyagBosElk+AHom28ojcSrYtgERNOiIUxvwsSFx/hPd0UPaTqTsTMedghP9zSON7nck+oRCm7S1e10xQGnsqeefD4Lcn42plFx0J8jZICvDs51M=
Received: from BN9PR03CA0502.namprd03.prod.outlook.com (2603:10b6:408:130::27)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 07:01:47 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:130:cafe::66) by BN9PR03CA0502.outlook.office365.com
 (2603:10b6:408:130::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26 via Frontend
 Transport; Fri, 27 Sep 2024 07:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 07:01:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:44 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 02:01:43 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v2 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Fri, 27 Sep 2024 12:31:35 +0530
Message-ID: <20240927070137.21816-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 3381db31-4408-4a22-2476-08dcdec2408d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6XZmYZPghyndbjl7oWbaQM3Imx9cx+794AAyT9OcK1Lr02kzHX4Cwcew4K8p?=
 =?us-ascii?Q?WK48Olx9+TC8hDoo6W7R7DkQk/rO3yWcCEGOwUTIUxqeka2bVYab9VwvOrNQ?=
 =?us-ascii?Q?FlGcIL7yq2fB/OBCTN5RKoI2W4iQRQPPWUIDhYwDvuGtFtb3DzkFKdc4/2Su?=
 =?us-ascii?Q?h43y69s1aPdcajNkvvbxNkQRTn2Dh2zjD0yoN1lN4XVJV6Uj75zGwAhhXm3g?=
 =?us-ascii?Q?n4Kq5lqG2qNHP8ysdMkMHPSNXEnIxieYsr36QHRLepdv+jhGHM6BAAseNXKc?=
 =?us-ascii?Q?szhOlF+lESN3rVOQ509VomrW8yL5rzynCED3b1gBN9RKyTgSzQUBE3tRZrdX?=
 =?us-ascii?Q?844K68jKrCrOKETjqWFgMq0N8Cf0tyjri5BBHci1XKeHX/SmVR4p3PPCV3Z3?=
 =?us-ascii?Q?j4r/kGxXSztZie0fZi3MqZ3xfUHKVFJDuAX+ufApiHWlTw+WykG5J/iEplGo?=
 =?us-ascii?Q?vgrl6UomnW0nzPdbFsEZ11OFg14KXsSKHoB+OaeEXPTJNSrR2eIkrlzcF0Fm?=
 =?us-ascii?Q?Iih3DXIcwmtYZPZkl8soAcZe+cDEKxeRNeqFK/x+IypDOuc6ru77vT7TKums?=
 =?us-ascii?Q?tyEWkaXwI6QcIDl8bDYAA9yLsDqx8RBO1zFBzG6+HZ1fdYQ/x0/QLUHh6P9g?=
 =?us-ascii?Q?w2xT3eGkFFux7Lv77LuskgqW6zGQLTt6mwL6yNlHIJtHNumoC6EXBKwQhKpc?=
 =?us-ascii?Q?ghZD4Ihf8RERdce1Kn77qtaPDF0/oTEUXQhwys35EBl0bgexQxNeIG06GuhJ?=
 =?us-ascii?Q?dqNByl7YUICoh5lOnqhwyA9/8YkonkbE3DErdSTsj8Rju4xOAfFXeaJiD/C4?=
 =?us-ascii?Q?6XYtdjIHqaVfZM/8AhBLvQyU1crKVB2E/gykNE8KGfkzxIW/TUTh80mBev/m?=
 =?us-ascii?Q?DwwfYQHiqFYvJ90QULj4fuQujRGSoV7Ji4usauxyPogE3BUGUv7w+kcGuhuc?=
 =?us-ascii?Q?19ld4y3LmDn51TbL+/uf4hzzFh/pRV9uTxz9fT2R1YbGdU+99Rc0iS0E2bOs?=
 =?us-ascii?Q?C+Nv5LIha97Ax5LWw0TZ3S00M1rl8rfqsn5frz/vy6UXEouDwY8EofzoemFi?=
 =?us-ascii?Q?VzXY/y+z1uf7M1IVicJBKy/hiczhwx4WUvmZ9qQfTL7B4rBJrJ9CR0Lrju8W?=
 =?us-ascii?Q?oQiJwVFtk+NYSjU8vilxPY1TxV5TYk0toUcYODp4g4S6CIGiqfPSAqnGRmnt?=
 =?us-ascii?Q?UvLoo0jCB3ak89oXB4hBlWVPMLf6GN2iQg678mzRprtofd8/1zFjCyZfoPAs?=
 =?us-ascii?Q?GFzBS42InG2jcbKc9GRfLOCaSdbyZkQEbusgcu2B8uCJWATo2fJSDjt6Ud1Q?=
 =?us-ascii?Q?wmlhL2MnAzN2CBIIZefFAG3vcBy70uYVFjrzrB3f5mF6vVP6JNajG2eYbQrY?=
 =?us-ascii?Q?EXN03CwMTDZRE0mWgz96SbUgp0Nh7wlBHrtjad7ww5xvwg8K+WmKNah6KpqG?=
 =?us-ascii?Q?uGkUwsd1pXZe12zfxTBTxf3qusTkjMff?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:01:46.7156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3381db31-4408-4a22-2476-08dcdec2408d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757
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
---
 common/usb_onboard_hub.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 00808ed45e..9c50ca09c9 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -162,6 +162,25 @@ err:
 	return ret;
 }
 
+static int usb_onboard_hub_bind(struct udevice *dev)
+{
+	struct ofnode_phandle_args phandle;
+	const void *fdt = gd->fdt_blob;
+	int ret, off;
+
+	if (dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle)) {
+		dev_err(dev, "peer-hub not specified\n");
+		return -ENOENT;
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
@@ -202,6 +221,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

