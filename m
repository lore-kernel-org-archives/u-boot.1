Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5068EC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 11:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7968E87D57;
	Tue, 19 Mar 2024 12:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BMQzlevv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8916A875E9; Tue, 19 Mar 2024 12:27:44 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 973C887D57
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 12:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnSX/SJxpSF6BHapDtW2SZs7i+ggO0S7YWlQbKnzVookZaKfMngxB//FIEQA2p6rDpLrslpy1yxNygMoKJ6Hm3kKAYAMLwJpMgI5nDp/7giQ3zFbz/VZG5jda1wpt+ZY+99ZgIHqAmDmgrNh33iwE8WatHsL4+UbpBc8U5oVlS4rw58onoW0xcDXm0yyHgCwRwba4CBu6EvdRoUVM+9EQKEbOxP5wqqNeQyexXOg9K19sQhn7DEugkUuUB/a/D6JoRCegkXShs33E6oOa/SuGUpuaUPzKH3zxX5c+8RM8LKmusHf7c0w/krUza3uf09MDHQMDv5DNKA4psWWh+e7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1BhDAeuOJ4TuryQ3pXkVMUgGAbunTnQxELamApS9YQ=;
 b=NkBEK5yLb9si7LUFBCKOL4RfFNUqtrmogmIcCfDAraAe2Z8VeR74SG6mzAcuW6J6YKDwtG0mW0pOWSWRgt/XQJzg8syol+nNbjV2pM8R4QKZACuL0OOr+MWH+U8/P2xLLSz5iRRtN2W0Qtb5TpbOQukWfpa+ii3IemmIeatDzmen5XmUa+vYVXlPdu+qL3ah9w8a/qkUFWdMHuA54fpqMXzDBgzFAmV4a5D6odZ+VSjqOh4MkaMZQTfdApTLUkKMzV5kszRIbl4hqujHDyUSyfRx1ncTX5RQ+Jrv0iawG5Q5t05uWOLKYolqdW3gti/GDXpKeOQ3CillZTxT+Z/64Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1BhDAeuOJ4TuryQ3pXkVMUgGAbunTnQxELamApS9YQ=;
 b=BMQzlevv71qNHRZMcZ0Ku0/T5hSBqMwqkZaJuQAIZ8wjzBVXjx+JP7SlJiP8O80Vn8YRcGqt4kW3Quto6o+HieD7TkqtHz/PFAhL6b3R1Znc1GDG9tVNHdl1u3DtMpN9ZktslS9Q1AdbZ8gUep94Bdi+XqczDSyrKocltToPebU=
Received: from DM6PR12CA0027.namprd12.prod.outlook.com (2603:10b6:5:1c0::40)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 11:27:38 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::9) by DM6PR12CA0027.outlook.office365.com
 (2603:10b6:5:1c0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 11:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 11:27:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 06:27:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, Harini Katakam
 <harini.katakam@amd.com>, Neal Frager <neal.frager@amd.com>, "Radhey Shyam
 Pandey" <radhey.shyam.pandey@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: dts: Add required properties for rs485 support
 for KD240
Date: Tue, 19 Mar 2024 12:27:33 +0100
Message-ID: <56e4e135ad796afd1370c3dfa2643c143ba758ee.1710847646.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=WrBxqv+u8zAOW+pmhyxM80IyNjHJjJENkysbGM3208Y=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSfZQum+M/8rDnn2vKHt9StHpdZJpdeOjn1rvRVThvmi
 W3lfytkOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEum8yzM/+8O/HToZPW6ya
 AlgPSMd+dnS5H88wP2Dzx1TpZVGKIftF5grbXFENOvrwIgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: c97f3575-a289-41f4-bca7-08dc480794d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UVJ1NYH0gGmQQVJS3uK29+jMSItED2vfdTWZhal1qIU7lRJ1k4JH4iKKiLk4q6x/apwCxcz0oWxtCU36jJnithZdwpS+58NJ0fO3Ps6qph6SlYghWkGenqsIZ2V/ds+RqC+xuH99t+E46b3eN6urrIifbWIC5MS8ScmT982IHe39/3kH2Z7h6DJfmSjjYZOfp5AGpSOaG8s10cgFQ2MM6iwVj57OV2uS4GQZACUW5bJqPpMZOPrADtL5c2v4NwqyzSzM5LrZhgdZTVdDx6I77XnZHYnyzhHra5mKnK93FNtlsi3UwgSh1zSmLHd76Ac5nDExv0LkYjFoz/fAUVTEAxU9tghhp6JMMEUgU4NmmjkGGe7hAkms2ECYVhUI47thY6SQuho7AD1p565a6rXcx2X24KYefFW7RLdNg2A8Q4LehxRpvv3brkeY0BLcPa6Q8BpHA4GwPytE8vHPsxJA66G/34M4trG10XnsXQ6XN4HqznEBRuOLXZ1+pr1AC4JglNu1BhNsy8yV7omuatJ/xV3CmoY6ds67AOMZBnbDsnCkcsTXqYflcd+gsDB3bu0Np1Mnx/3igKXp/cpeuorLCakMFu0whX6xy5X3FrauS+IYNi8geU302vNhPZ/NgYM7w0mKUgjcOSsxRRTNmtxIeJU7tUhdpTVd31HXDlu3aurM6vhX6xwp4OhfD7LVcFc3Njpb4d1tGRuu8HJ25/3s1QzhXqI3RR7YNUjihePzoRDG4bBsQacoW7l8xEIielPP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 11:27:37.6692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97f3575-a289-41f4-bca7-08dc480794d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223
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

From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>

Add "rts-gpios" and "linux,rs485-enabled-at-boot-time" properties
to uartps node to support RS485 on KD240.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
index 5202b7c48198..1727a1cc15c1 100644
--- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
@@ -356,6 +356,8 @@
 
 &uart0 {
 	status = "okay";
+	rts-gpios = <&gpio 72 GPIO_ACTIVE_HIGH>;
+	linux,rs485-enabled-at-boot-time;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart0_default>;
 	assigned-clock-rates = <100000000>;
-- 
2.36.1

