Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4D1EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90C186E46;
	Mon, 11 Sep 2023 16:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NOP3knYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF0D86E3E; Mon, 11 Sep 2023 16:11:18 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFE786E39
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfxctEaYk6HfLCuRWwvUuWgQYYeIDtt4mlIqoV1w8h2eeOaVjjNiDhHNJQqkt4vNRWeQ+/GwXk88XpLiJkVWDxBevJTFxsRpg/U+ad9J77dGMvQhnIXuucdpxAvcm2wn3gWt0VZTCsEp2ltPVbImFLCY9k2c3eITgx473uik2T7BNfAjo6IxQW+4wR5D781pYOUNbDBuAL0C2gO6vjqr7+IQIsDLbqmgJMyl0T2dn5QXy+t74uQJEh4eZGVmGHeIvpUwQAM++zv/ZN03xOzA3pEjnnMCouMd1vaWSONhc7FdKVOwXXmfMFAaiT37Ysp0njwZK3w2fs2AQ51we9VkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOEXOynzQ64H/kJ6N8OSWJRVQdAf6lYJeiRnpDQEBVs=;
 b=N0+Rz0WgY93olD80PJvHW0x3X/dWzQvVaa3wu/sR57zrMFEuK8AZcpG7d0emuSt48jJruLrqg3aOo+ZdwRKUwVcg56VfP3A7FhN/hHKb6LnRyzUVbMsAriMV9Ng8ZLpZ0I6RNOG/wPINrQ5xGYCRBPzN77d63fCbJY49TMjIhd7lZKo4dJNvqLTuFV5Cal26KGoJIaLO4GqgmuJMmoDDLIqPb4gfG/I0JTgxXFlaLd+bCU7I9/jAaz4eBry2PszSmNAFWp/IhMij9DLVOPzA4U1E8u7LAV8RdOs974E1KaiyKG2KZKyvfCrDLo43CTOQJJDfV8OVrpYAqKjUIWvGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOEXOynzQ64H/kJ6N8OSWJRVQdAf6lYJeiRnpDQEBVs=;
 b=NOP3knYc8PDaT/HVESzGJKuk/y772OXOHFh03EyYTljUIPLAPRnkZxvLvtQolxeStXIyBvESGjgdFcKSxj508JjDkh18uzXDD/s5ycW/U1whR8TXgmBN1fEhYRaxSUodGmNCETEXMhmRu155aZP4+ih4R6y90gIw/fnVCWJMsjE=
Received: from PH0PR07CA0104.namprd07.prod.outlook.com (2603:10b6:510:4::19)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 14:11:12 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::64) by PH0PR07CA0104.outlook.office365.com
 (2603:10b6:510:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 14:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 14:11:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 09:11:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Srinivas Neeli <srinivas.neeli@amd.com>, Harini Katakam
 <harini.katakam@amd.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Piyush Mehta <piyush.mehta@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/5] arm64: zynqmp: Add resets property for CAN nodes
Date: Mon, 11 Sep 2023 16:10:49 +0200
Message-ID: <c4efb7ac361eec591a2f775e161ec446c4dc04c1.1694441445.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694441445.git.michal.simek@amd.com>
References: <cover.1694441445.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=IgQA4c7RbKz7ye4fbVS77tC+E1TXp8rvtkjpAspLGkI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/8i8chc4ti50/NftK5ZHdK8wPFs24nXOAfdr6RZsP6
 Nnsrvkg0xHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmUrmPYX6u10x9eRbhL77O
 XxYkaZRLLrOz/M4wk9Hd+vTtdIbpTbfK3s5s8Vv7kjfkMAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f886bf-8196-4dff-dbe0-08dbb2d0f3b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBBaft6L7LW9tPKLW3yMVpf2Pds3tSubGSxqx4KmgRllYRALx7tvTqeTJzT5LIKDxW/2dahWLPB8vRihLB4S0u+1YeuljM2egXscZ6g4H855rzA24YpqyPESxSAnY0E89Lr84Jdli2TQKQzoVY7ZJPfWQYBF4cbGTzPzuq5K99GMyLkzn4grAgSXMc8wQuqSoDBT7Tv0HjOkZHlbMoOOTgyOgLPH7cHoyeZxZwaTefSITe7ZaKu5geRYDitLPveFSifd12ACcSooHUj7cv9/EzNHSyqJwFe5uPZhgz3jW5HLkPowV1T1arDrpj7V96wkwV9XnyDCysGUsDMGEG1aYU0Ugpj6f0GyPrcEnNe9U8zKW5j7TxdDBGOuOVtnIY+BqKiJ4nPXSwQKwgS7XQ/OcIs0tUf54e8SMrfi1rWEbrDFhONCHRVKo/BVS7cCj0qhJ4b5zpe4axl9Qy/A9VrPjhjV2Ad6gF7jwI8abouQujbagCN46iZGQxw6ek8n/Sgcyef9nB92e6TWuHDxF0C2UiE3rRdbSOxJz/TxOfTNQgRYD3SKLYIuTQ/E3F5dSZ4Sf3YlVr0/Op8UzcXYEEg2rJkrwgvWXFEZRyEJHPi5N/J7chbJMxg2GiL1zXAdFJ7v7DN1jOt06vdzuQfUYcYYUDazlCHq4L03MPHmUYyjODNfN2hE1JxP3iXHtubB90/i9EuBYEq4JyTvNtfzHJXhM1E6UIAB4+HsqsTZcH0WYW0PyIlEflqSIzu/2gsIDlRh2ST9qRyZyOlV3IS7MTIwBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(44832011)(8676002)(8936002)(4326008)(41300700001)(110136005)(54906003)(4744005)(70586007)(5660300002)(70206006)(316002)(2906002)(40460700003)(356005)(82740400003)(47076005)(81166007)(40480700001)(2616005)(426003)(26005)(336012)(86362001)(36756003)(36860700001)(16526019)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 14:11:11.4221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f886bf-8196-4dff-dbe0-08dbb2d0f3b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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

From: Srinivas Neeli <srinivas.neeli@amd.com>

Added resets property for CAN nodes.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 355f360281b5..a71875755bc0 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -262,6 +262,7 @@
 			interrupt-parent = <&gic>;
 			tx-fifo-depth = <0x40>;
 			rx-fifo-depth = <0x40>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_CAN0>;
 			power-domains = <&zynqmp_firmware PD_CAN_0>;
 		};
 
@@ -274,6 +275,7 @@
 			interrupt-parent = <&gic>;
 			tx-fifo-depth = <0x40>;
 			rx-fifo-depth = <0x40>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_CAN1>;
 			power-domains = <&zynqmp_firmware PD_CAN_1>;
 		};
 
-- 
2.36.1

