Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D21EDE9AD
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 12:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12CC486FA0;
	Thu, 14 Sep 2023 14:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f+xjogdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDE7786C87; Thu, 14 Sep 2023 12:06:36 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9418B86AE9
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 12:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqhIfzddTPrFU6UuII//WnRSyWxUVy58658KPywS38SKFFzkFpd0hhhlCEV1LJNeoqD2SdWwY34A49uebIxnu7qwjwsCvJLSTzi5ySfAKz+IvJWwnj02g/dOBifGli8z54g4avNblwqmpmSHMSVKL4sHRFFTUzifc9rt37+9BIlkBfNzdn7GXF7XKx3iTI5ovFhdsjYoDpCtU+XYvqaDjgrVI1NkssAcyy4/2SRuHFsVhAl9/l0L2dTRrrfmaTgOYOMEcfgkhH6ckZ9RO3H6l1ebRDweh6YTy20YjbzB9CvDgvun9qiz2RWj5ie1+55TTH+WTyade0YzHN8FLMw56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDB96BirdZyuX8jDqj9nww1q5KYjGYw7428WKMbnkVU=;
 b=kcUmJPp7INFt5lKFDnoW5E43GoQPFYnP7OcB2RQvJdvSwPq46Z/8QtIGWitW25Vw5STGJ/EGq7X6VpSmqQ/E6RDV2MeyNwHQ0Vnl92zXrMhGQa335OMCQTZl6i9az4q24NNHnisutg1lWiIy1noT8EQO8Zn7OxeqodIOxG2PZOMuX5pT09wMZtIdjcUnWhBehirlb+sQ9/8tUYPiW0Y98oy9u0xSKt5vastX6XhriOqOlldDvMMGugTJvrHhwyZVCBRQVpAom0hvIs54rsWhqg9/g15gYrhMeq1ZMmSEjnp97mo6DXcl3y3XLsBTjw6QI9jy9z928cVc6JsR7uRf9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDB96BirdZyuX8jDqj9nww1q5KYjGYw7428WKMbnkVU=;
 b=f+xjogdkJmfPdUtTNkPTabEUI1YcTbSg5JtYuuR9WioW9lVGY8iOlIushmEgnobaXwJVhK7yUkUtSaX3uFpxmG7vOl6Zx4sM4DvXAvVUUv+hutU4GO6kIuoZ4K7ggKJkl6kRl5Xp7hCDBLa/HEXuTnrjaYClZBrMvl6Uvm4Qfgk=
Received: from SA0PR11CA0055.namprd11.prod.outlook.com (2603:10b6:806:d0::30)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:06:30 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:d0:cafe::3d) by SA0PR11CA0055.outlook.office365.com
 (2603:10b6:806:d0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 10:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 10:06:29 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 05:06:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 03:06:28 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 05:06:27 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] pinctrl: zynqmp: Display the tristate configuration for all
 pins
Date: Thu, 14 Sep 2023 15:36:20 +0530
Message-ID: <20230914100620.26346-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f8e748-b688-4c76-8b54-08dbb50a440a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fd6gCUsMUihTjWREFzgrK399c5cBpWxiGGFRoeRjsO2jNz4vBsn1sIlY80/1zCRrda/mxU5XXHiUDjyn9SjGDhDqYRJFxkCVBGb++jSzXJbC1eFU/C9TcSrqQ5G40hijHUPXKB8tLGJH4dJpJfQ+btwQxgps1t5vnxbEluk9L2yMgGfDaMsqdz5v01faEtlutDEGtuApUCfG0qsb57vu5VdUtkH0amk5t3OmTL73UX1ySydMGi2NvL7dS7evZbnIzeYWX+2y5fYUC2bjykcc2FNmet9ZC/ZJwnDCjQbOCVbDk/vwlFInmQ0uKrI14VbkGQr9g2CXfCYcOdR9DNQxDreQi2IU7ZNXVTgpumonawpLRESxWYW6nW+qDh/38JhtONJi61NUphTtyx6+v/vgDH/VE8izXOXbCxB13yCC9SFc/x/RjI3RmW/k3GvRy63T6rroMPctNrRuBPbmHPqne09T0wxQeGCRSNUDBeZgs/0ydi3xNZXXdQUvb+T0yHjgAbHNME+3bsVDM+j7zq9GTFm/IZLR7XMNT3MxwBf8Gh/DfpK2yccEiT7jPJYW7By/HpqJzQM1gQXcTTmRCFLTKjUDlN94P6rv6iw4kBBfWe/BwsqiE7FbBXCrh94Ngyl15UdaCbiNKowyaVRk+CTJOFEGgNSqs2EYeBaJXQhjBrt4UIf0FQZpAEswQh4XyaluYwhoOgvKPDQXGM+qQ4uOzi81U55NyX7smcALRs2dg6P4OVXKX7cGBkZKXpq2cPHkuvxQyUlDsk9hGYg0W71c/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(478600001)(6666004)(47076005)(36860700001)(81166007)(356005)(82740400003)(41300700001)(2906002)(107886003)(1076003)(83380400001)(336012)(426003)(2616005)(26005)(36756003)(86362001)(5660300002)(54906003)(316002)(6916009)(70586007)(70206006)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:06:29.8118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f8e748-b688-4c76-8b54-08dbb50a440a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Mailman-Approved-At: Thu, 14 Sep 2023 14:09:23 +0200
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

Read the tristate config for all the pins and display it.

ZynqMP> pinmux status MIO1
MIO1: slew:fast	bias:enabled pull:up input:cmos	drive:12mA
      volt:1.8	tri_state:enabled

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 02626a7561..d98834b1aa 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -533,6 +533,8 @@ static int zynqmp_pinctrl_get_pin_muxing(struct udevice *dev,
 				     &pinmux.drive_strength);
 	zynqmp_pm_pinctrl_get_config(selector, PM_PINCTRL_CONFIG_VOLTAGE_STATUS,
 				     &pinmux.volt_sts);
+	zynqmp_pm_pinctrl_get_config(selector, PM_PINCTRL_CONFIG_TRI_STATE,
+				     &pinmux.tri_state);
 
 	switch (pinmux.drive_strength) {
 	case PM_PINCTRL_DRIVE_STRENGTH_2MA:
@@ -553,13 +555,15 @@ static int zynqmp_pinctrl_get_pin_muxing(struct udevice *dev,
 		return -EINVAL;
 	}
 
-	snprintf(buf, size, "slew:%s\tbias:%s\tpull:%s\tinput:%s\tdrive:%dmA\tvolt:%s",
+	snprintf(buf, size,
+		 "slew:%s\tbias:%s\tpull:%s\tinput:%s\tdrive:%dmA\tvolt:%s\ttri_state:%s",
 		 pinmux.slew ? "slow" : "fast",
 		 pinmux.bias ? "enabled" : "disabled",
 		 pinmux.pull_ctrl ? "up" : "down",
 		 pinmux.input_type ? "schmitt" : "cmos",
 		 pinmux.drive_strength,
-		 pinmux.volt_sts ? "1.8" : "3.3");
+		 pinmux.volt_sts ? "1.8" : "3.3",
+		 pinmux.tri_state ? "enabled" : "disabled");
 
 	return 0;
 }
-- 
2.17.1

