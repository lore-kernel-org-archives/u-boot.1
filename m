Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70AEC4167D
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 15:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADE8E8769B;
	Wed,  1 Nov 2023 16:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pcjCDe8p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97F7A87595; Wed,  1 Nov 2023 16:05:37 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 000A38769B
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 16:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpEKOj6oXnyrgL4hvjBMM6YtEgZj6/K+sV7C30AwjzvIxRPJlSqlDCA9vm0eH6sejEk0XKi0B4zcFhzJcFl8VmjETO8T7mfmaDf0i+rgqHaEUwtn53WvKtaLS0koD5HCEg/+ioMwyXT5ijFUZ2RdqDneUIXCzFRceOIcPRGiAAKXU3zO8nVCzTMHhvBmsLUIDHFsSotr49wsF5nYKqAMRIdjyHrdMA60Iwf2lwsxuJiqFvX8KaYQCEwFq8vj6zFwgbX/aT9sR6dkftQAJLZWxZ9/2sTxHmWdbr3OWwB536HqvY6PwVuNNCWeYBiiTwEuCTO5he9WqbGKMEj4CwGeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOw6+vefCjLn6DJPQSI+uHGNdOkk9LlnO8jfFrwKHTc=;
 b=gq6aEmHO26B79cbl+pXLjjil3BStKKMdH1JJ5xLsCEvBau6eruHThuTTTSdPGYFJDVhYJE8vjdATIw1KNJq9FucqLGjtqUFHgKibLdgbAS17u17GHDAsIYKKgFWvAeADCxemeP1SZRS976ETjAq9IVYcYa3GXs+fW+4VkTF9oNBNxLz5duYtN1SackwWrfTCdFYHFHHDNqRqQfKT1AWDXaauX1eEnnqbZpJR9sOHCmo4syeDqSgDPe5UIszgHnEDaqGOBYD5Zo36BrRuxIQyjFIU4fYk6dn9ICU63EThQd9nXpCJ1SnXXbKu2Lios9Bylx9U7b5KUTMMYv4lMeij8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOw6+vefCjLn6DJPQSI+uHGNdOkk9LlnO8jfFrwKHTc=;
 b=pcjCDe8p2syBArUQz1OWBctzRsGoS+6gGL85wGdjQpPB+j+zz3gTyHUu5EUnvyZ+6elmetl0Jca0VHhjRqfAoV5dE5LyuAZbRUW2CJcCi5IlVxMMpyqQ0w5fJzKYCNRSKBLrRMQFQM7O/QSWUI29sYFWS2FRbRx5Jq5lAMpz3RU=
Received: from BL1PR13CA0207.namprd13.prod.outlook.com (2603:10b6:208:2be::32)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:05:29 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::70) by BL1PR13CA0207.outlook.office365.com
 (2603:10b6:208:2be::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 15:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 15:05:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 10:05:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] dt-bindings: Remove VSC8531 specific RGMII delay definitions
Date: Wed, 1 Nov 2023 16:05:16 +0100
Message-ID: <bbd343474856a67252f3b31d22b3b5a80ad04043.1698851109.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=UN7arpEButugLjN1ZY1oQWYYPEXpCkkDipCdx/6LZXE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSnTLVfvpN9zEWuvTCczP5hfsCCp5Yb7y+YOaf25RobW
 fO+rXbOHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi8bcZ5vDkWXWbmTCU//ff
 bRE1VWs6/6aJHxjmJzlN4bvwWW/izm08q8z5THQUcvJmAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2ac5db-1ed1-4bf8-8d5c-08dbdaebfc0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJX8+CCRj6Pb6VnMMEQtOUDuIyrX+08cy7S2DxUJCo9IvgeoUTSpWXYiysKTE3DZmUgmfxORYJZbU3ErIEM+7fwlRJsdsYswlZ2UNsqpYw6u+a9s3xQwrjrq6H8mIYuurdubiJRi79f0buVb0jxxwyNdURqbQXTbsTDxFMY1IoaC4sirpatSpte1fEkwPCRY+9wVF2LDvIexgBVdH2BXML6LV6mviadeWs72k6ZxaOodWVNDD3FL08Mvxt/8KkLHegjFG7+xw2mUlPi+Pmqy3BgwtoIo2kmZDP0jNjjA/cAK9d4SkD/qzj7IdGLFQNlfQCAGWNlkNfwikfUkKD3XVxcLBGzuqqggXTo55aSKS/7vwXwCqmnbbIbKur/+M1BnLY09XUv590yjyxTpEKptYdaSOoaVG4vltFzjKkyn8qtEh2Gv1oKyhTwfZGljIpS/S6toXxFvd8UembTVmcKo3KVg9uU+6F9BxM6OLHPJyS0+4eF2C8xqZY4ZukKkZHBziePJHAmFyVKgTHHz6tjUQCU0Jds1IZf6GqS8ce8idVZiYUk1GUF7uxrajJjggAOnBhcJQvw6iAh1v+m4rrfq5YPIc73YfuanlycW0uxw2GqdmAvZ1o2NOXavfTIH6uGozZOlzqwqcEiZHq2qQv0AEesQn8Z3fKD6/FZwJHT49PuUPnBjfafrOyRh2F+B8gnh4jasXwh5KflBY7AZP4IWcWjv9mIbrwQhZxf+Idm/tG+QzopzzNOEpP+ZOv4wbgD7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(16526019)(26005)(47076005)(6666004)(2616005)(336012)(83380400001)(426003)(36860700001)(8676002)(478600001)(2906002)(5660300002)(110136005)(44832011)(70586007)(41300700001)(70206006)(966005)(316002)(8936002)(36756003)(356005)(82740400003)(81166007)(40480700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:05:28.1745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2ac5db-1ed1-4bf8-8d5c-08dbdaebfc0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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

Based on Linux upstream discussion value enumeration shouldn't be used.
Instead of it delay in pS should be used that's why remove it from the
header.

Link: https://lore.kernel.org/all/YNsm%2F0dmpBgO8mqr@lunn.ch/
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/dt-bindings/net/mscc-phy-vsc8531.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
index 61f5287d7523..c340437414fb 100644
--- a/include/dt-bindings/net/mscc-phy-vsc8531.h
+++ b/include/dt-bindings/net/mscc-phy-vsc8531.h
@@ -28,13 +28,4 @@
 #define VSC8531_FORCE_LED_OFF			14
 #define VSC8531_FORCE_LED_ON			15
 
-#define VSC8531_RGMII_CLK_DELAY_0_2_NS	0
-#define VSC8531_RGMII_CLK_DELAY_0_8_NS	1
-#define VSC8531_RGMII_CLK_DELAY_1_1_NS	2
-#define VSC8531_RGMII_CLK_DELAY_1_7_NS	3
-#define VSC8531_RGMII_CLK_DELAY_2_0_NS	4
-#define VSC8531_RGMII_CLK_DELAY_2_3_NS	5
-#define VSC8531_RGMII_CLK_DELAY_2_6_NS	6
-#define VSC8531_RGMII_CLK_DELAY_3_4_NS	7
-
 #endif
-- 
2.36.1

