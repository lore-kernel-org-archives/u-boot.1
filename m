Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92210D74978
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9C95891FC;
	Wed, 30 Oct 2024 07:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GLwUptdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38DDA891FA; Wed, 30 Oct 2024 07:43:47 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C2189212
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+T9lJSWQ7NWeCtpYoTFiDI+cH7IiQrS9KwuYv6r9WIC97zqMazge8J6VHYR/tyKrTgP4bpMZ7HqOoOch5ewUbu544CQIF4YC9AB5K2PD01KkEsyyy5oQg6/9cLou2kwblRduzZyN1tycRlN5CsA90rbx4rnDmPV4+W6arHG1q8T8sWJDrC9Sk9GIvGPIxfHrrZj3IOolO+6N87GhH9Lau5VGx3nY2Y7pAQkdeJ9AGg/VT5iwVQZ+/h9azhoL26ke8I5gJznIkeD7J6uuK0QHu0sNjyKWdHNMtwb7TAmNm8Vfuk4cbqN2CMP99J6np02zBK6nTwmxLDGEoDmOq+www==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlT/8/Tc3sSlejZ78zLxrCLdeR/7bUUWHC2c4oBzfk8=;
 b=j3N62/OBpm0136lxTu201iDqvdGec7+0sdDortFwGMaTdkrztqyBvoHrhVuaFwvcTbevu1dMq6W2rvPumdhYC43iHIG2Q7DxMbo/JuMT87xcfjEzodJxAcWrV4K31RK3l05+RdhF4lCOBiRRXagSUDP9Y2zFjPgxVyILhjcNbxdnTJBBjmuPwNvCVeVzWgyIa9fXbO8/nsN7NoQgq1bhoVqnLB0SJXqG3s1/r/vGqdS4Pzwtl9hwf+XcRkEN0kznWHIqQ7WwhyXHI1rlcNAjm3hms/gITjJ2SVp5z1Q6eE83s854O4L8fo9m2B5HQeoq2FkFDkFrSVNEPkzSxonAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlT/8/Tc3sSlejZ78zLxrCLdeR/7bUUWHC2c4oBzfk8=;
 b=GLwUptdEuWfxJAHtyaeDr+QeCa/UnQP6Ck6DI2xSxLnUZhk4Fn64UezPafTtDZaVovTyWACWmLh7TVQD2j+rej6ZrK9rQRGTR84zGsjEfhzouggQQYaETDXqwAB2YNneWMQN58wP0l9R1j63f8AiHAK81yR0LCWAwIVvqWPDXTw=
Received: from PH7P220CA0080.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::23)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 06:43:34 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::36) by PH7P220CA0080.outlook.office365.com
 (2603:10b6:510:32c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Wed, 30 Oct 2024 06:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:43:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:32 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 01:43:30 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v9 5/7] usb: onboard-hub: Bail out if peer hub is already
 probed
Date: Wed, 30 Oct 2024 12:13:12 +0530
Message-ID: <20241030064314.28604-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc6c5c6-873b-4453-6bb6-08dcf8ae2cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/g17HIApQmqhsO7Jf/LCWqKB5JuUhfi5+dKQfZolWHLQG2oaospK8e93U73f?=
 =?us-ascii?Q?uMvN1bEn3cC6QbQyGUtk5CAHvyNWuHD2Zvz3cxMg2/Zz/LOdclLRu42tcbHZ?=
 =?us-ascii?Q?+YqD71izPiixRbj4QWeitZXHDVihGlpXn8qPmpQ4DxG64gPV+ICLyu4nvjQS?=
 =?us-ascii?Q?h4amfxPSp8Go50hC39779ZJnIYmX1OoLZPcm6mUSB59stGzgsFFt+E7dys+i?=
 =?us-ascii?Q?V2EcfA5EgFeDCQzSVCkwyqPSQt0tworeZ5T3h+YfDnt36Ww7+YIXl39itC9U?=
 =?us-ascii?Q?z2E7iuCAKfoI8Hvxe8kVigW6qanKy4Nh5DsQW/Xtb8/iLpcqVhZ0gOL3b9+k?=
 =?us-ascii?Q?MTjQNOywykwnQtl+VQWGEjmxwpJWMb2Dkdv/1IPns28PKY1pkg7I6JODR8b7?=
 =?us-ascii?Q?wg46W2e/5fVUPFYZmtTbiDIsMWP3W0Pt9faIVBXJdev7pCKFBqNaFtdnAzSm?=
 =?us-ascii?Q?0X85FnEK0D5nkouWqBjCA1/IUh+U8dpTh1vMX40T8Dryh72vKwiIS0QCjgrS?=
 =?us-ascii?Q?BOOdnp8c/oCMn0yk9HUpkjmgYk8xM4x65VrztwD7r9eijerNUgdN5fNY9ihE?=
 =?us-ascii?Q?3qOdfsOTqbI6IySNpmxoFNSwmPKsEnlk68DDohaj6j3xGLyX8Qa4ngD1B1PI?=
 =?us-ascii?Q?HfqHKSjUQViauVAk5fvNIPaSaETYyOb9DjYdGmfjMkdNvWRqRg7Qioepz+bo?=
 =?us-ascii?Q?BFe4iMlqmiK+ENnI23vK/ksw8lXw96YIJjohg8WDGHs1+dg9iQhJNfL8r22l?=
 =?us-ascii?Q?D8H/LSNUOd5I5fueSmP82o17AhfHKQL2ARwUmi1IGSLbNosvtoiGGP9gloOC?=
 =?us-ascii?Q?KOq6Jyp1AEC8wB4TrLI0jpJHWOO/onm0bWX/DYDs3BjKPxXIrerIoEFHVFkc?=
 =?us-ascii?Q?zwiT+9T8holIuFHHZnxcKewXziWOIGE37oZhzEEC33aLYoGSFtZ1oh41O3ec?=
 =?us-ascii?Q?Zi8lzN7ejrIIZE6TU/spGAXrvyK4sU2TqSn3rEBz5WJ19tLSNy8cygWYA2L/?=
 =?us-ascii?Q?UeWn4CrlFeU+Tnpp8TtmqF8qr4boKj5IGa3r/XOL60vjPK6QoAw8BFdPX4lk?=
 =?us-ascii?Q?srYKNHAwG6WoJuZyDHjkAdqrBawBmCHCkT1RX1j2F76r7k7kD83O7U9e/fwJ?=
 =?us-ascii?Q?BRvQVmRmXXlhHZO//nA3xOPIMhzKCOsiu+wB8n6fKgUCITdsqv0SdgaicDK7?=
 =?us-ascii?Q?mUmZdpZUw63R4wZ4/gBM7kSuhGxKii2cH8KYQAsVDbdLr9pe9WZmtpCDwxKU?=
 =?us-ascii?Q?pTP+vpYjqnJc2z2mwh2JQ3rwcqtAU1x+DLl8Gz/deWtS3uvb8jU2rBbbyVSZ?=
 =?us-ascii?Q?FW5VfBlir81ufPBbQBQmoF32qvJLisTpER7Ip6/YflnBaaGp0mIIczk1YjYp?=
 =?us-ascii?Q?VNhG2tDMQkns1Bqby0e8y0QQfBWKeHKrZ7evojAriu2R2l+pXA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:43:34.1069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc6c5c6-873b-4453-6bb6-08dcf8ae2cf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
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
index 1a3569a135..661eeb4bcf 100644
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
@@ -213,6 +233,7 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 U_BOOT_DRIVER(usb_onboard_hub) = {
 	.name	= "usb_onboard_hub",
 	.id	= UCLASS_USB_HUB,
+	.bind   = usb_onboard_hub_bind,
 	.probe = usb_onboard_hub_probe,
 	.remove = usb_onboard_hub_remove,
 	.of_match = usb_onboard_hub_ids,
-- 
2.17.1

