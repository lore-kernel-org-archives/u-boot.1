Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43040C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A779787A42;
	Mon,  8 Jan 2024 11:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HgGM5VO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987F687A45; Mon,  8 Jan 2024 11:26:08 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87AB587A24
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN5c7Zwt4IGlnux4gnB2Um0T71jMh1PuO2x1UXbDj0qi0kQoO+Uubz8Z7n1fDyHZFL6aHd+XghdZN16EZZcef5ca+v+Nz/0mfmQIoiwcKBHZ4KMydc5e9lPWnat9OrCOwfUdail0apr+shOFzPmGNH/Bu3ujnaPpvE/ATo6p1A9kTqW9H3mn87cQrb1OiN0qt7nrjzOWoTSX9/7BCWaK60KtGD1GXXtBcnp4V9MoIgqg6dP8RqRBFB666/xBUxRDG8FqtChdalh4redXquTlZ4EFN2RxQIhvnQGuRhxZzvCXvXfVHYS9k/3xY29Xd9PiBr2TClL1EIsIU++GFyibAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMk9YB8tSu+9NMfX+kKKyluRCxwejBkd6MwwmH6xIHk=;
 b=fQgHmvszLB1xqKG1FPW/cILIwbB1tbaVEKAK45FE5xVqicyTeTLlgLz3XrSqWIP8MiwuEF5tz0uUCzkKzjAoPAtCRGjuBsX6VfwulkBcDFQVJvGtcx8nufA7WPA5nyhaLtNeT6AoOOqVe+6qaYleFX/BRnMfqAvpRK0csHXtkIxbIKGthzojwacz5hSJWuM0c5JHseQB//xGGVpzfZTxbKREkZdZJ1rFvjnM1rfrtAyjXLqKfbmQxLostImLZbHw/EAU6ZVQFvWa8OeHl/KmtkiMqQhEyniqdl8osWkyRGqax8UkRzKLQNmYUKaeqSOZRS0kCC9MsTjURVNUNv5DqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMk9YB8tSu+9NMfX+kKKyluRCxwejBkd6MwwmH6xIHk=;
 b=HgGM5VO5Y/iUdiJZJgWDd1XCJdxq0TtbMA+AR1Wi+KX7+6wAKPgkuQiFW4yUUtdxKNyXFpM/MfKHPrC2pJTTX7aG5Vjnj73vHScm1O9fllxnoegoooze7rVhb41JhmE15UxkOaOfYcg5JO177cII/EIt0EXwaZGvjZjtvU87tVQ=
Received: from SA0PR11CA0026.namprd11.prod.outlook.com (2603:10b6:806:d3::31)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 10:26:02 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::b0) by SA0PR11CA0026.outlook.office365.com
 (2603:10b6:806:d3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 10:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 10:26:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 04:26:00 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH] arm64: zynqmp: Describe interrupt by using macro (OCM)
Date: Mon, 8 Jan 2024 11:25:57 +0100
Message-ID: <6a51f47d239002679db03a787057fdc58610515d.1704709554.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=756; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=N7GO3sMkZet5XBUrt5z83rGYwbf9h7nMVwOdkkxmjHk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTZZzdfnDB32qSJO2UfBCUlb88+urzm7v4pQYbvjxuWC
 USwuNzd2hHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmorudYX6Vw7dsu6iKRcVH
 2mLm/fa7G7P+9RmGeYpCk2cF5FRritb+STtb9CFvfnDJZQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 0339ef80-621c-45ef-f510-08dc103436b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZKL2zoEWkcLU68+hfMS5LPKRVbuWcsQr1705vUdGHNBN7swVRuYm0x1Sj3MWXNWiXCo6j4bR/kfq/EGfah+J9UWo00iRCmXDJEfES1Eo9DAdf8+e7OThe8oV9LREpx+rLoGvYoUFW7y3iIYf5hM87sOlmpUD6EElrNtmbRLvks3uuxZPT+swdm02m7kBHCKX3ECQ0e2qJ23iXYS6vAtDZEn+4x/anpYgmYweBJZfaD9dVvShb7EK0CfX42q0+jtXrIIwg3nB1Dz2OOYUNOp+78HjrP6yvDU1QdVceiXxxKvjr49wJzOtbC49DWk3cN4N+AfoHrBsqi+ONnoVEsGO7f5oW8PpRDGTv5Kv7UDCAB0f6DdIfflr3yvFquVu+VDj8Zu+CA4sV8jnyFJdIP2Nnjo8gftoP+CbhvyWrxje5L1W88hN7F2VxYprvlwWxycXgFJ/saLbCGL0LExIoGMuYJfApD5QDdXwLdemu2cVeUrDWWApP0N+3bH+cL2KQkr2Toc7BX7Ew4K6L0M48tJUMDT0No8DJJs1bRV0ultET5PWI42n2m+VL2q/aKbgk2B4tYrxd0AoEtN/tZyGpjIl5TrucW/ggrF3dUH/nc5CXfXxFETChyuWRSi62m/99gAaEKQzXKazSHRiWimVYjLYevv05RXA05Pj8+2p7SJUEn2/MdeD8RnD4pl9RkIZJW05KGRzApRiNHqD9A+SWNzYJjYqqUgwJqqNwTpCendNihyBRWzsY/BPpthUdb28jTIcTmDMK5hbstay01HSiyX4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(41300700001)(2616005)(26005)(336012)(426003)(16526019)(6666004)(478600001)(36756003)(86362001)(81166007)(356005)(82740400003)(47076005)(83380400001)(36860700001)(4744005)(2906002)(70206006)(40460700003)(5660300002)(8936002)(8676002)(70586007)(40480700001)(316002)(54906003)(110136005)(44832011)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:26:02.1093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0339ef80-621c-45ef-f510-08dc103436b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131
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

OCM controller interrupt description hasn't been converted by using macros
that's why fix it now.

Fixes: 6b049190c9c5 ("arm64: zynqmp: Describe interrupts by using macros")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 21be909b1abe..9cfddb8d25eb 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -737,7 +737,7 @@
 			compatible = "xlnx,zynqmp-ocmc-1.0";
 			reg = <0x0 0xff960000 0x0 0x1000>;
 			interrupt-parent = <&gic>;
-			interrupts = <0 10 4>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pcie: pcie@fd0e0000 {
-- 
2.36.1

