Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40496EC8724
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A6208676C;
	Thu,  7 Sep 2023 14:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jJv4AOdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236E986785; Thu,  7 Sep 2023 14:56:03 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D2086682
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHPH6hkh7FZAujjaYPjJHETcDOUFKOLozE+a4e4ljktwmoczGe0P0oNXgBU/Bo60bW4OmOobNhS6qCqCB1CKjfTMHTNC7ZeMhn4cT4cIjLJse0ntI2fJRJr5zS6oaUw03c2e8zN04dExJXgUpPsWqx9KYbV6kH4eSUJeLzFlHXRTQDW3JI1q/s9uqXVCoY50Ddj/H/CNEyrUArKsFzwETudzH23CsBUES7zfT4xt+sOn/kiilYSOpw1TELK6aDQo2e2/HDT6yFYU4wrTCBxsTdmY9A+IiuWQP5kI6urSt8nyr6l/g0BtPn29FOLs5fDwbV1AkTEATY338iPMWBSshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1PsOk6XD9mO2cojzjoAL1sJNJpO1I2RDhke9MKXod4=;
 b=QhSAat7Hk5Zv34xkCbwCRV/18qiIp2vQKYR8Ut9G6wIdvfz//zmcPJTkh2V2LaSQCphg9MkvbhFzox7AAz2f48w/L+tx6ocDpVKP6EWpcc1PuNuIZwIXG/EWobSzr4rb5naZCz92ZTtFYRke+++5wje7i8YdoQQrCaoGCZeiEyY+Kvej8Q0JwwOjH+EpRVjtp/IPfR1bX8G0t0oKNB0G6MTJETyS3LzBygImcU4y/e7GV9G6RNhDljKb49aE1FnlLsmqYdzjiWiI+2rGokcAsxHqZgIsYBDgBTqjwqSVNwxg9N2Iz3DarxkcAsx1maeOMXMcYfoH5BWUvkSz58Y5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1PsOk6XD9mO2cojzjoAL1sJNJpO1I2RDhke9MKXod4=;
 b=jJv4AOdf+O1uTZrqCe+Ye4z9rJTwotlwaResprzm4ivW9XnVOr2vi6OpTGs1HhLubLlHPeWmBv8VHGnlPGBwavaqCS6UGke0Q40kmW/5EpyX4ncyV5uPm3fKmM4p1FkkHEXPpD8dSENBORV/in6C17MQUmJPIS5y41okKExxreE=
Received: from MW4PR04CA0085.namprd04.prod.outlook.com (2603:10b6:303:6b::30)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 12:55:54 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::b1) by MW4PR04CA0085.outlook.office365.com
 (2603:10b6:303:6b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Thu, 7 Sep 2023 12:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 12:55:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 07:55:50 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Dzmitry Sankouski <dsankouski@gmail.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] sandbox: test: Fix typo in test.dts
Date: Thu, 7 Sep 2023 14:55:48 +0200
Message-ID: <f0276ada1166fb05bb4277c213b4c8f96b63173f.1694091345.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=632; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qUYAAzCMPtHJKOD9UaL2arVCrYVdh+b0fgtFwzugjvg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpSfJ4Kcauev5vC8nX1Zb6b13uacdepm1Ru5nnCreP07d
 PPs/vNnO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEjjkxzGYv2HOK41S7/543
 UUWN8W7Merz5dQxzZfzlw2Xb6vL+9tRuaf/f+WHp/koRAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: b83d3343-1c5b-401b-da81-08dbafa1c4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoJGUvLIoHnUrZflDirYRDskRf+fwObAjI41NzlNSGY/ax0/xwRwTC/gHwamWhNs9AzE6sX3rxPcfLcSA3k2++tgsl/oMrL7FWAt61VCvZ1kMOUGq8niEQtfIMPOfSjnJmASCwsh9mPqrGiPsVf8HUBRr56IXYfCRj1zqdguP77wcuxvm+ZItr+QkEl7aQPnzDWP/mBS5Z8vPjtElStqYBwGHfivRGYKIT8OdAeo+DyA17CwWMhC8MtMvq2kNHnZV1FNHMDbCJ02RuUaaic7ckPLxo4eyEOUGZlAl4MQJri5G2033wkND74uq2JAJDjdC24fIIZtRBtqNt1ZvNRJrVG7Sg2oaEjgVjeq2n9ye8NFzqrveXZgTv/jXK0lKIxJeKaaImeLvmxewXjpCLyNuTWRm+wqAWEnR696nAq5xt7DkkQCqCBh603SAoczKU6G/6NUutiqCzqrERWF14yxStydd7/bBneBgslPxEWslKMcrP/+g1NHMxNL7D+HP/ZFdyiOJhqqhjN/L1zntSb1MYU8O97XY+vW2lNqjpg4oo13gRt6vHTSBMYbrD3dBsNlZ2fa2gulSRoziGCidW4Bg28PHM2GSXfZ80ASwmbxMiDT1xjJLci3cPzLowoS3HX3SN0Cdx/oJmCaGkt9QU46chOosBglz37xlCRcxBSVjwoxqZlCYhMLnY53c276fo+6/fLW3VGFlqq+2xl0ebuR/Y/IrB7+WCeXxeUR/xDxBZiv0yzLKnhOp6rJCDY+UxD+Tf62AlL2RylaIWzjbtq/enaKARW/z0dHH5sFXTvaDg4WVs0ZJPVZ3TFWY2PvHmWq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(82310400011)(1800799009)(451199024)(186009)(46966006)(36840700001)(40470700004)(41300700001)(40480700001)(36860700001)(82740400003)(70206006)(47076005)(70586007)(54906003)(316002)(110136005)(26005)(16526019)(44832011)(2616005)(5660300002)(86362001)(8936002)(478600001)(4326008)(8676002)(336012)(426003)(36756003)(40460700003)(83380400001)(4744005)(2906002)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 12:55:52.5490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b83d3343-1c5b-401b-da81-08dbafa1c4a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

s/parititon/partition/

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/sandbox/dts/test.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index cf1b3da9cace..19f184e791bf 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -112,7 +112,7 @@
 		/*
 		 * This is used for the VBE OS-request tests. A FAT filesystem
 		 * created in a partition with the VBE information appearing
-		 * before the parititon starts
+		 * before the partition starts
 		 */
 		firmware0 {
 			bootph-verify;
-- 
2.36.1

