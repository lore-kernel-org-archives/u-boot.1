Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EED2C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 14:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA59C876E9;
	Wed, 20 Dec 2023 15:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LyQ7wSFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9206587705; Wed, 20 Dec 2023 15:53:37 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F327875B6
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 15:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fzf1idRP+SmhRpAoeQ9Zum9Vh/0e3bxDebJ9tGCNTmTr8lBQSHWpozCD6ZlVX+rm7Q8R04sYNOxIeAzbZNxxOz4c87HkKS+f+9mAMDpqxPBEBN1FNGh+Dm4RCb1TNKW1UCJNzEAPDHtupz2FWJE9ao6DwiuSeWpbKcgP2hBdsPTcbq9d2hHUC/vBH6UrkOUrCPDF3+E7etAhf44oa4RnNRAkswrW5fGCbPg6Qy5jtxJCa3mQgEZbAvDz32Or+LLsbwHyikPO77jt2OGCNz+eG16NTW0rjUT+vGp5OvKiUH6JHRZAkvYvcv6MzMEnhE2/ui7wX6MtqzuOCZzi3T54zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZghoUclrf03AChAFV7UUWEPeIvy4vq1MYmK1pbB4Tw=;
 b=cSN7YzJ8+HBCDJ934EZdq/EyZ2g1GWrT4Qw8mki9CqUQ8aHFWL3CvMmduQAbxhdPH7B6fKpn2oi3xh/LIMJWyQNqKQUnevsILZhHyjFWE3UdJGsO+u9VOSaq5kAr6Fs0MrMNiTYaKKdFWXIbtoPruX/DOOdxYjL3IgnSKbYclU56vgQz2/TBI5HG+T90dOAlZ0rNxkmgcJLpCPVPF5amxOAP+ls+1mBReuKc/2xKrGmLnBhEIOi1UnxQs/G95gdbdld96tBd+Hc3GrsPHh5jKqWKBGfpGyyhxRQ/RJgx5PQ7/VUOLt9qx/fzYtTCCQJNmBik4TLhYpXtHeEeIiRgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZghoUclrf03AChAFV7UUWEPeIvy4vq1MYmK1pbB4Tw=;
 b=LyQ7wSFY/ExD9c3a/Piz2C3XQAT3ap9LSWSC399/3j7e/L+ijnAbDPwzmxOm1zCBJ4s3MytO9xWWmc6VFy66gj6xBFQxzb9C0glUGSeVP8UFPc86i7czErwJaRNxI4C9Pm1RF67rzvu6SOA6Y+/sUEeDRtZIx6uSV8O3MuiRoSs=
Received: from DM6PR08CA0032.namprd08.prod.outlook.com (2603:10b6:5:80::45) by
 CH0PR12MB5233.namprd12.prod.outlook.com (2603:10b6:610:d0::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.38; Wed, 20 Dec 2023 14:53:32 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:80:cafe::c9) by DM6PR08CA0032.outlook.office365.com
 (2603:10b6:5:80::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 14:53:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 14:53:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 08:53:30 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo <ycliang@andestech.com>, Padmarao Begari
 <padmarao.begari@microchip.com>, Rick Chen <rick@andestech.com>
Subject: [PATCH] riscv: Extend board compatible string with "qemu,mbv"
Date: Wed, 20 Dec 2023 15:53:28 +0100
Message-ID: <575ac34167776f3a3a00aa23cc5e182d1e41492f.1703084004.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Rva0KsVquD8XoqLVPYuuczfrJRDcN0MympOHBu7mbTk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSm/0+q2wxFtMWjd+ZV7642K24+8MlnXWCKbs6j6dV3X
 ALchbk6YlkYBJkYZMUUWaRtrpzZWzljivDFw3Iwc1iZQIYwcHEKwETELzAsmBbz6MOf3MkCLvOr
 Txz7au4x57HSV4Z5Nj6rxJ4b/+2e/vpEGuf7qyZnmdMvAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CH0PR12MB5233:EE_
X-MS-Office365-Filtering-Correlation-Id: eedba20a-1b80-46b7-7f7f-08dc016b6f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eb6LzaBqz5Xikiu4AQnCniy+s6jyphHcQvSFWkd3eQaYVl7phRzMdsdRVoJXfmEDeKjjv94JOoj7Y4gKgX706j8eLP8v3j05Uu1Ur/07w4fMUKCWkc7dMynDgWOefEFORyKI2KWh1t0OLC3MdcaRcUG25NduzT0mT9zxwgxQ7L79t9jVTx17nMmdqh5t6lRAJuPAJ4RXQiRD2bCRfqWPUNhGMvjK4arqn2/mTZUDnCyhAYM3CBgslVAe0537L6gu1ZeRb0lKbXMjoup5hV12meZT3RmX7yywS++JD3efrbQPM89C14OYeUNUZkUoBSbZoD2sxQIUFZrZW8RKgG00Lv5A0nEDv+vO8i0J4pe5MRA/usaU5mmabtc5iE5adIX38ZqpyReCcnkADklsqxrwE2HnbV51VOo6Hm9+W7Kib6a9QUkbcniC3xrsHpT5/A56ThrWSOGjBdl/rcB5XtBaj5ngJVGgzGwLINFxo5fXUx3pA9V9Vv/R9wotvUadFu/4gryU4nku1+H2thp51g0COpOonowD+XV4gj5nHgBgHmr+2JKVE7KkYrx7THV8NSDT54yZtlnrl0xEk6GRA2hyeeXXjplY/DAm5wfu44we5Tmkd1RylxS/AgLXBDABfJCR3dIhgcVXb+TVT3u14cCjTy4pc1RD10rQc9kGC81mbXsP3opUzAuLtT53vlvOzPvea/7+oNOERchCfspVi4TKBWaXozoKBudULn5gizLjLxCkXZGp7OmnNk/XOeIcySpz0IHykI7g6Jhd0nfbzn4I8eZ02Yobgrw8hMtEyulRRy3MSMrrDgZ+h2pxiCOYNPVY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(36840700001)(46966006)(40470700004)(336012)(16526019)(2616005)(2906002)(26005)(82740400003)(426003)(83380400001)(47076005)(4744005)(5660300002)(4326008)(110136005)(478600001)(8676002)(36860700001)(8936002)(41300700001)(54906003)(316002)(966005)(44832011)(70206006)(70586007)(81166007)(356005)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 14:53:31.5285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eedba20a-1b80-46b7-7f7f-08dc016b6f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
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

Extend compatible string to match the latest change in dt binding.

Fixes: 7576ab2facae ("riscv: Add support for AMD/Xilinx MicroBlaze V")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

dt binding patch is available here.
https://lore.kernel.org/all/69670e5a46c98a2eb73d4f2e2d571a27c46b4640.1700722941.git.michal.simek@amd.com/

---
 arch/riscv/dts/xilinx-mbv32.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/dts/xilinx-mbv32.dts b/arch/riscv/dts/xilinx-mbv32.dts
index 6a6b8b694bd1..94e42c268115 100644
--- a/arch/riscv/dts/xilinx-mbv32.dts
+++ b/arch/riscv/dts/xilinx-mbv32.dts
@@ -12,7 +12,7 @@
 	#address-cells = <1>;
 	#size-cells = <1>;
 	model = "AMD MicroBlaze V 32bit";
-	compatible = "amd,mbv";
+	compatible = "qemu,mbv", "amd,mbv";
 
 	cpus: cpus {
 		#address-cells = <1>;
-- 
2.36.1

