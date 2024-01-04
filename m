Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84CEC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 09:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E39878AD;
	Thu,  4 Jan 2024 10:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ho0M/266";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB84D87954; Thu,  4 Jan 2024 10:13:08 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B2E5874DD
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 10:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaMNA4oeYfWshQhEaHehGw4nclRz8ZHUW+N7w/K1uratPHOoRxQniWNGyf9SnfJNEcTwkUfwQh0IPwdXLHqOwX0ZbKkVu34QDzShJMghPM6GYYvsLy1shMxsyWRxy1XNMHWIks8W0GmIWN8Vt6hFU5N0pHalNN87Jq7E9lUvWHzBPlOW1BzeHnx0qvmwQE3ipNyUsMEPhoDwaVJj6jDgWW6E+EmggvAyVS19fQvxq0jAOhmAjQi7mwuXhvD1g6fZjs2a69cA/itwX6vOW6c2Wnaqj3wozbuu0ETWUAHWpns5Y4Z/FtsUeTWMZ44POoYSxSbXbVcVObbLbsjX5ElAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRbaGpAVfBHedMz+eGx2cDhBfkWOBye9ioPZVPnbp9M=;
 b=RdWjIpUcnuSkQ+cUoclGkb61ifqlL7JlvXoQM3jKD9DbIeMw6kpm2pkR+1+zuBUhGhotWcNhPbkLlBjBawkunpzQHqM4BvvJSZwGGAMhXcW7YOQISL0To9kn6MBR/MPdZDlvZoCChhHeiWweGEdV85YgxXHlvetQmxLoS/navgufQXfNdGwwIUPfQ+rAYkVyfFJq0duNIXAgfC6G47gYttYUTOhaHyW1TCDh6Mvacw2mT7i4NuYqD49j5Bd6C1bpOaE3uV8bAG88ab5lBwXjsJGrXzOwzdJjS8rjHoUGF7xXJ7YX25iwfyWfabtLCLWTmfkvQS5FxfxWCS5ITrmZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRbaGpAVfBHedMz+eGx2cDhBfkWOBye9ioPZVPnbp9M=;
 b=Ho0M/266fvohN2zIYh0OeZTPmKpe7KCXd5X7wvaimhz4snVVhXQkI30ybvfEItU6Z6jyYDDq4FS9qGySmtf1FicILDuBBssgDzYPmg/f/ap1jNT50gJiLgRYeSXn52paVb0DD9K9Wf93RSCic6vvHdeU73RbZmxtZzFgxV/UslU=
Received: from CYZPR17CA0006.namprd17.prod.outlook.com (2603:10b6:930:8c::7)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 09:13:02 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:8c:cafe::d7) by CYZPR17CA0006.outlook.office365.com
 (2603:10b6:930:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 09:13:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.12 via Frontend Transport; Thu, 4 Jan 2024 09:13:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 03:12:59 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] arm64: zynqmp: Rename zynqmp-power node to power-management
Date: Thu, 4 Jan 2024 10:12:57 +0100
Message-ID: <a2f7fe30e3630c262c2773a595b7a0c8918573a0.1704359569.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=6exNYpoP/+emRijUBBOrOkP7h6aIneV2GQybdl0TG6Q=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtRpZZPeux5dzvryu9tTwftpukGFjD02C7ZqnMn62fNYU
 btS5FB8RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIrxDDPENxgS/Lq3m4BZ53
 azDwZJzrDIprYJifw3OEV+Hf8VA9B4MlclO5a/5O+7cOAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: c651921e-73e1-49be-f03d-08dc0d055a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +kWy7YUZApaI/z8jJkVR4eiX1jUGQEu0AAFvq6f+sPcZx7rtBjEHHB899gBGVwQ1rTiP8XVX14ube1ziSfjaAnT0MMy7WrbRO6RxfdGb8exZtGuDHIbeNltXYr7GRBWLyUqxIIuf9gV0CNFMitYoPX64pFj8okD6vi5qNOCI+SeRXDQp1yyPxOBkV0v9FssrGrkaIaM0if3gFsyzt1+QwCguuR5DIccfru9O5xbFpXx39Dd8ZyPlej4tqcwVqfXjH74kBAAS8KiYmi/JDWoPxM+I3uMW9Hj2uG3POLVi6YDNEzENg2Ct5e3r1ZJ9XRJRVD9HwHQM6feXjm/eVgWFL/PAbtTsD8bAiBm0TSqjSIfzx/KetMAAs9FfNORXb6txUrgYWJB5vUYg9fjTu1S+KeYYf3P/xNR2O6a4jidQkXNQ0soKJteKrlWMzAW/V7i87MTkkWPlRIoGRjVZwfl8eJ23F7NzsoVHsAdd+npnWk5y0ItXod/gHbgEox10JVMPw9F+pgZlXgbje6T8yDUGFfwDwYMpzCt0pAw9nXcuWoe0m6qObtRmsX2rolbaExeCO9JzaSJVgumfIvYOCV3FqBG0ahHafrQY0GYdoOoTi8il2X7p94tidfYLS/2v64DmUJZHApFcB/zw5v5cPdkD8STUuWt6rPL/af5qIs38gEsqVu4hxi92K78xar2KyLwiH66FBP4T/1HKIkkXgMDmme6O79RoWQLq5azF41jzeYs8HwIZzvV8wPXYmuqwBZSd9Y1e3lz3nJoiF9tzyj3PjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(26005)(336012)(4744005)(47076005)(2616005)(356005)(83380400001)(16526019)(81166007)(82740400003)(5660300002)(36860700001)(54906003)(8676002)(110136005)(8936002)(316002)(44832011)(41300700001)(2906002)(4326008)(966005)(70586007)(70206006)(478600001)(86362001)(426003)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:13:02.2487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c651921e-73e1-49be-f03d-08dc0d055a83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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

Rename zynqmp-power node name to power-management which is more aligned
with generic node name recommendation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Linux patch already reviewed here
https://lore.kernel.org/r/bf24cde92c2b9e2824847687fab69fc25c533d53.1703161663.git.michal.simek@amd.com
---
 arch/arm/dts/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 21be909b1abe..2066d5b616d2 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -198,7 +198,7 @@
 			method = "smc";
 			bootph-all;
 
-			zynqmp_power: zynqmp-power {
+			zynqmp_power: power-management {
 				bootph-all;
 				compatible = "xlnx,zynqmp-power";
 				interrupt-parent = <&gic>;
-- 
2.36.1

