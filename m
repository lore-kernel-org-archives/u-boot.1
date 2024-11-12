Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78608D41D6E
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450D489443;
	Tue, 12 Nov 2024 09:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nP85K6Hc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE898931D; Tue, 12 Nov 2024 09:50:57 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B5389440
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOsaRzeWKc6a+8YXefDa2meIoU3Rvbl2mhz1A0o936I3rxsVMeid0J/Gxlkr2O7mmRkqLYv71rOLI6gkgPmQHSVcDod7f7ctidCFMwUXCWGyqaY7I7eOA12pj6P+gsqS0ph7Wf4Q04vwk4btyqx2IkL/t9E6B1d57N1WqOiMBE3vpjHvpicilFLYMYma/Mqp95iLdwbg1Q/Iz0waYj5hN0Q7hp2UNdzdVBdWIxKgR0FFkmWBex/ByaI9t/py9os72ZlcZVwr2VTfBwZ2BtREmsZ1vTtqCmfoMxy+LWfAIkWQQsHq0/UnIWOLZ8ogIbQkLzEmKsQPG5wqu5iSd3kZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZlINoiXqvZvUev8Jo1C9hTSvSyKXHQZPEPa9Xi3nbg=;
 b=rF32iEYZ+tF/Ctyxot2cl6OmYwyvg7sBZE366WAxEHeOyrIVlwN2jvoqUa50O9h4I9mKw7v7he4DXAFviMPEaDElAZ5WJv3cqtjQ9strA94efnbAFKd/khydHUwkeNtP81wb/ZilLAXEauRLdxYkZ/i2EVaUvleyJ0WoWc4Obsg0lKaLwAkhDqFOprl7/WhiUVm8rMMLBPB6FHdcz2ffKu30sDAbBqTHt67uy3TSc2uQ/k7khTL1KXKREE76lIJPB4fbWINd+UeGWIXml1500yYj9MF1R7TeZKwx2MMiwJ7v4v2vaOtQK2IPCzVrJJbpLmWQAW8C7yuWHGJafSJ5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZlINoiXqvZvUev8Jo1C9hTSvSyKXHQZPEPa9Xi3nbg=;
 b=nP85K6HcUQIrzmEkLR0WFnBKeGIxX3Ssj+MBOWlbVTFaq8qtFVQOACSuhgJ7Vr4JhICqP0c7k8Z4P1vLWaKGmXe9FM2WaFTqal1PsCwDsIrhr8ktEYhKeAcY30X5GOI0awkZhuxVClgWVGyOPbZjXUFWKadZAclLUGjXrK8/OtU=
Received: from BL1PR13CA0072.namprd13.prod.outlook.com (2603:10b6:208:2b8::17)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 08:50:50 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::98) by BL1PR13CA0072.outlook.office365.com
 (2603:10b6:208:2b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14 via Frontend
 Transport; Tue, 12 Nov 2024 08:50:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:50:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:41 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:50:40 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v12 3/7] usb: onboard-hub: add support for Microchip USB5744
Date: Tue, 12 Nov 2024 14:20:23 +0530
Message-ID: <20241112085027.21352-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
References: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: c93bae5f-c1c5-4a4b-6119-08dd02f717dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Spa6YVXL3xig99SMquZ1YhUcyIXC3WjRtmGuMJUqJuyJz+r6fPioAZJAS3QM?=
 =?us-ascii?Q?JvtA/IKbe1V7lTAoAJogbgjFsAKEZOk4sCPfynURWoeWpuvDPrK+tnPSVMjI?=
 =?us-ascii?Q?AVd/I+SqP08BIvQLLdtSYOGOcbEAPz9G0pw2ND0g/9lSyHpEZdcn8ZKXcbxN?=
 =?us-ascii?Q?MVOpTyii3AluJtZEOZNDtuLdfQU0la1k2EtMPp8QtA5HEnse7Qm4dzhxLaMC?=
 =?us-ascii?Q?Vd2/HasDPwL16oqbjlPP8uCuiba9PFIcUrLv1YGEzwAiAqsM+cJiGDzHcJLO?=
 =?us-ascii?Q?sSo1jgZmZxIJg5wNzBs1ifwExJ5kOrOBRoQWpgDj0jufVQa9sNYOsfdYeS7T?=
 =?us-ascii?Q?31G9g9PcRp3UdHy/0z3YXr6lna2ts2bbGmDzYH9/+/ITf09dbEAoMs27OaNc?=
 =?us-ascii?Q?DppfxZnAIY3zktgftpKxmoeSRCAiCyIMa4BSVpquK245Qv4D4vKTu2I6I3Rl?=
 =?us-ascii?Q?cRW+XmnSt71rP5k6fnubYHHO834xWmBdAaoMO7Aw0Dzaji8tCK8v9Ss90JJ3?=
 =?us-ascii?Q?1M/i+/HHKS8qNtEVS9Sb83jgyAcWwFO3uJ9HhyaXoNoCkZKU1bujzcFoWTJS?=
 =?us-ascii?Q?729EZyyeAJ0LIcD76LJUBtDy3L/w0re8TJ8xxhr1IXhqlLPJE2R7a43tfAFK?=
 =?us-ascii?Q?Ub0p4fTDJtpUduYHZHaKq9LfiqS3bS496mrbvYJjyp/F/mQ0RAks+A5XFqbY?=
 =?us-ascii?Q?v87+8tt7V4qMXYc2E4M7PUuLA0Y2dS8NBYUNHVAiuCMLNMeyky4CIXtTu8HM?=
 =?us-ascii?Q?pXrToIgTfbAifa54H2prgVtZn75LSO4wyNiwuG+/TIE+wVo2TiShzURvpnHO?=
 =?us-ascii?Q?O2q63Z8J1crqP98Ypi++i79qWYo0r/6FmueF5L0YUHAgi5RPqjVCLfHdv2yb?=
 =?us-ascii?Q?EmQdLRWh/OghoeCYY4NpN2WF78/kEjUMwKRtdKx+6Wk/MvtRbDT3XkPQicof?=
 =?us-ascii?Q?rBeGBCX88AxGcwRW/wRjTka7z6xWuJ935yhsAkLKGnJS3V5SDWuqQfEL2UOX?=
 =?us-ascii?Q?1dfB9Sn6UXBMkvCsX7/1GlHVGzevEZ1q5nGS1oahVEm1AHpRtbEEdDP8Y7B8?=
 =?us-ascii?Q?zLFfXsmhLPt//aWcR/WT1W+QQmhD6/lZMEzgFwtqkdOb923CUUetcJenXKJY?=
 =?us-ascii?Q?y2Pgwn9Tm/LiQhbrmhFygnJUFIUkOFi020gpGwIcCb/I+JdTFr1OLnEuJ+eB?=
 =?us-ascii?Q?9TVPiDatn3WjA7fNm0r/gavel24dijloUbL18LsByvFX8lDUPzrU4P8qJlfZ?=
 =?us-ascii?Q?4I/Nw0SaX+2HVgwaMqSDkN9+Zp5NNBUjDvvcG+5ulbzKb+oyZgtGk3P+BdFI?=
 =?us-ascii?Q?JD5MuvtI4Pee8I4b58IHNBMCJxVGhXuW26NUiiFifXtgt+bqtFhk1SdgLyXC?=
 =?us-ascii?Q?xDHY/zqGMEKSletBZjxlApI82S3EUaHKZOixmoGmJqmgLBUYcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:50:43.5790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93bae5f-c1c5-4a4b-6119-08dd02f717dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
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
index f26223e823..83f37d2fc5 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -93,10 +93,21 @@ static const struct onboard_hub_data usb2514_data = {
 	.reset_us = 1,
 };
 
+static const struct onboard_hub_data usb5744_data = {
+	.power_on_delay_us = 10000,
+	.reset_us = 10000,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
 	{ 	.compatible = "usb424,2514", /* USB2514B USB 2.0 */
 		.data = (ulong)&usb2514_data,
+	}, {
+		.compatible = "usb424,2744", /* USB2744 USB 2.0 */
+		.data = (ulong)&usb5744_data,
+	}, {
+		.compatible = "usb424,5744", /* USB5744 USB 3.0 */
+		.data = (ulong)&usb5744_data,
 	}
 };
 
-- 
2.17.1

