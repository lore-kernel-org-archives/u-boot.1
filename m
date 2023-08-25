Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C53C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11EC98650F;
	Fri, 25 Aug 2023 09:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zb8gBZwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C926E852DB; Fri, 25 Aug 2023 09:11:58 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CCCA86961
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6/QxVD+U7PMTG2rI0TVqKVTVrZMugLWO2uwaVcaYSD2w2bbNmFHDTEKckEQqjYHd+VRDqqfaQDXKJ1LYrytDQLtQxNizyy4UUAcgxHu71pasfkZUSlN+Mq8sMpU9B08+m11NmjfM4EBitUfJXuDmFAKYKjNYIcCGLMZo4EFY9OHotVUrX7gGsPecybbO/xytEKE0Iqq74Bgg7rLl06MheQef6bhmXKKkOdCzgg9ovfZxjaLwcLXqnpioiK1JCT4YK4j7WAP7eqzntwqTJRU3fwTe8wIHh6Dnd1QImU5yjfAdyx9H1roAICF67hFPAve5ujnDY4Cf+PWnr7M1jmZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ich3rqw73XBBgKz0jpfqt8JSYAEa/Y0ya5aBj5cds/s=;
 b=h6Cl0LhlIL0mKow3iLs/0SEMVZvl7JKTnOzwFncFHGSkyBq5Lc7JTNTaCUw+YSQsAEbCHNLgcLq0CX1702lS3tLWlINxZkO6YE9rVGEWJu+GDlKQ86W4/RzgOuJ0F8MUJJF6uCrLGTC8ogAdZccHkfJnGXk+5qZTW5i1g4Baeyg8Iogao+Dw3plaaclU4kSo4k0jPCTK+SwcJw/FbWkUiZ7BypnhSUTv1xNeWJpDSng4nHpxq9haorQ17JxYMjCzUZkkB550+5uTfhdOmwq3m9aQW/UmZ5SntIrH5j+Ld1UCFv3hRJt/0aqrho5z1vAQdjwuT8fzqA0U6//V7eJA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ich3rqw73XBBgKz0jpfqt8JSYAEa/Y0ya5aBj5cds/s=;
 b=zb8gBZwDbfuh6wkBVIvs9i0DMlJ86pr97ITcdPZfZg02YA8FWLPdd2uNAyy1TormOQIIuXGy4S1PxfGf9woD8SbKdmVYdE3r3L7zYMX+JZVxXi+2VZN/xYjC7uAZaNxtM0fAPXRLQkwK9PYxBGxfmNXiyYjO7ZgRyZDpr/eQHig=
Received: from DM6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:5:80::26) by
 CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.29; Fri, 25 Aug 2023 07:11:52 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::37) by DM6PR08CA0013.outlook.office365.com
 (2603:10b6:5:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 07:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 07:11:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:11:49 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Setup default si570 frequency to 156.25MHz
Date: Fri, 25 Aug 2023 09:11:29 +0200
Message-ID: <c052ddf39e392e97f87f1c57ea06f3508733c672.1692947486.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/sddR2o8T+UidV26M4o1gAU1PCQyFTCL0FF+w5wNwi4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpQXIXJ3vebW6ixbbtFY7TTru9cUn0ML9eVO+vzjaIs6Z
 zTpW1NYRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIhUcM8x301cVXll18uLtq
 oynPjHW91zROdzPML9N/ZDFfbKvV8s0dj5/+u1R7SyTmPQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b69a5b4-5d0f-4479-5f97-08dba53a8d9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOqfoe3Rulyg/jrkttbEfI0vpBTrKzIZxV9FtllxaWlOR2vEtpoCuM2TJXQQWLc95WyxPQXc5nYEhsoKH9LTGio1d2pepNziC88hewYW8Yoqo4bNAbouh19wihQA4jpmqm4cocPxvpUjx1GvtbcaTj4fhf6tGb35SEgHX/Bz/7arvNjxjXhzjO/qL1Go+KZS2xYnQNwEkQE4GgKpw2j7Z2RX49ad9Ivv2HPPsunz1js3IOYz3vcea4MvAZKjNiBBdTnEXKSMUZ3pFbj8jcPpJNqZEMK8C5a7CZcHZFu+96yGYbVK1wX9ErhWSy1rYdnjgspmxaIdFb3ad3vp2bmm7oezqX4kDhPjMwd1hLlQCqW6jbt0BsBEedfZwkE/3k4x0mRX9d2u6zkfckn6wwNiEeA191fyN4SfyuoVs8s4kGjEW1oPHiguct7szooWM5JTbEm1VrXXczH5C69mjKa3nkh5qxKFs7+ptW0ERdlvgLf6f7eNEOGRG/aR0A/augVPj+87QCDQ2OGmRQxYt3VbN0g2hAi4J8RrYctIW3g4Toz21ktPbS5IeEp5hnJYTRLQEILwhZ9kNnEU4Z0IYAKSbO4eXu0TZ0EbUn8fyvgAsqws62Tk3aHRDAzQrrCUv47B/gtD7GNAafPBJ06kadw1yT3dA+m3I3wvSKx/VXnaiKTNn65Kf1NCm0dHvw+APGsBKSo3SrTk5vy/nNayXoKWa4hRlsJShgzxlQIGGPyxSPmBXF+DkNObnhjo7zpPFJcwXqmoC4sDtrYm8C8RYGNxAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(40460700003)(8676002)(8936002)(41300700001)(6666004)(316002)(36756003)(110136005)(70586007)(70206006)(86362001)(40480700001)(47076005)(26005)(478600001)(16526019)(336012)(36860700001)(44832011)(83380400001)(2906002)(2616005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:11:50.4263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b69a5b4-5d0f-4479-5f97-08dba53a8d9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
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

All si570 mgt chips have factory default 156.25MHz but DT changed it to
148.5MHz. After tracking it is pretty much c&p fault taken from Zynq
zc702/zc706 boards where 148.5MHz was setup as default because it was
requirement for AD7511 chip available on these boards.
ZynqMP board don't contain this chip that's why factory default frequency
can be used.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zcu102-revA.dts | 2 +-
 arch/arm/dts/zynqmp-zcu106-revA.dts | 2 +-
 arch/arm/dts/zynqmp-zcu208-revA.dts | 2 +-
 arch/arm/dts/zynqmp-zcu216-revA.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
index 79d67c495dee..0f7230b9526e 100644
--- a/arch/arm/dts/zynqmp-zcu102-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
@@ -602,7 +602,7 @@
 				reg = <0x5d>;
 				temperature-stability = <50>; /* copy from zc702 */
 				factory-fout = <156250000>;
-				clock-frequency = <148500000>;
+				clock-frequency = <156250000>;
 				clock-output-names = "si570_mgt";
 			};
 		};
diff --git a/arch/arm/dts/zynqmp-zcu106-revA.dts b/arch/arm/dts/zynqmp-zcu106-revA.dts
index 7a8094a16b79..f8019c592a7f 100644
--- a/arch/arm/dts/zynqmp-zcu106-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu106-revA.dts
@@ -592,7 +592,7 @@
 				reg = <0x5d>;
 				temperature-stability = <50>; /* copy from zc702 */
 				factory-fout = <156250000>;
-				clock-frequency = <148500000>;
+				clock-frequency = <156250000>;
 				clock-output-names = "si570_mgt";
 			};
 		};
diff --git a/arch/arm/dts/zynqmp-zcu208-revA.dts b/arch/arm/dts/zynqmp-zcu208-revA.dts
index 9b3ae67bff12..0c1f50943ac0 100644
--- a/arch/arm/dts/zynqmp-zcu208-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu208-revA.dts
@@ -489,7 +489,7 @@
 				reg = <0x5d>;
 				temperature-stability = <50>;
 				factory-fout = <156250000>;
-				clock-frequency = <148500000>;
+				clock-frequency = <156250000>;
 				clock-output-names = "si570_mgt";
 			};
 		};
diff --git a/arch/arm/dts/zynqmp-zcu216-revA.dts b/arch/arm/dts/zynqmp-zcu216-revA.dts
index 43eeaec5b15b..8ca01f01a3ab 100644
--- a/arch/arm/dts/zynqmp-zcu216-revA.dts
+++ b/arch/arm/dts/zynqmp-zcu216-revA.dts
@@ -499,7 +499,7 @@
 				reg = <0x5d>;
 				temperature-stability = <50>;
 				factory-fout = <156250000>;
-				clock-frequency = <148500000>;
+				clock-frequency = <156250000>;
 				clock-output-names = "si570_mgt";
 			};
 		};
-- 
2.36.1

