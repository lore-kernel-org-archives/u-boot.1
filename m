Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902A1C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED39B864AA;
	Thu, 24 Aug 2023 14:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="velq2A6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C6B5864B4; Thu, 24 Aug 2023 05:27:35 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61BC286569
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjM0e2YMs1bLp+QttzoyyASC8hyx+yfTkVSVlk4Hc7+wOxn3FJQsXbTwechgcQakMOL3YVRQfKIPe5HLRhYtSRlakkGhqSVZyBCj54fCi9msClMMcDNJcNUAz7D5K3kdE5G8WHR3eXo8vE3LyKVGmpdS2Eh9nALOTqYWCayzuAvTLDXqP5YmNRC78SVIdttV57SaI/xPMwDV52SRi4mIbxYDsUUizW98SKLzC3QbPwrLrJkHCkCUeKh+MWUMbLzixdtb73Uz9zmS+fwqgss9PFPcSeZuhARpJKtyzp3cXVzgw8L5xpdWAUREYcoyYKnqh116MB6kgE9D4NCMHklgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIc2fihWRbKSIIawaJrsTFS8U4eHsraAcC1VptABXsA=;
 b=iEkQ+FMl6+8LooFpjnNvIy6jUZOskhJxabAR0K0ZC3envAlphH2YTE/BDQevcvo0zCatgcjKfwbqvrgwzR+PjhpcT4LZIK+LyB7ClfdI8efIm+9lJRE0QBFWf7VET3qCe6zus1uHCfYy+QS4Jh/tUO4n5nnl3JfmmZpDxvSVGl8ZePwr6+3yHzPz1NFCTP4nyOIHA0Ww/kRFB9yOXR4JxB0G7YbOt5ywDrXzJgc1tlqKjhjQVH4LNFB6j6xhHV53oN0O6rnCWs2it+z6MQaWwepaYvBvid3NNBvZsqcAGT5DT3Js/q2kumfpcvlLIFrbOMgNKptaxsF76BQi8yI1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIc2fihWRbKSIIawaJrsTFS8U4eHsraAcC1VptABXsA=;
 b=velq2A6ptEOt20wjjmvLkq52TKX77B2Vp84+mCN/PY0PhYsz/B80Ig/gbDWkbrEl5vxkvwudIUu3g0SB1hpFLcUAMtQqQvnWFGS9xlpQ3unDks6XXqRrRWCA3Cq0IRIQyXwKA2UKFLfDxqNglmbFteu0U9H30B0JukEDNfpT3MY=
Received: from CY5PR22CA0012.namprd22.prod.outlook.com (2603:10b6:930:16::32)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 03:27:26 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::78) by CY5PR22CA0012.outlook.office365.com
 (2603:10b6:930:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 03:27:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 03:27:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 22:27:25 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 23 Aug 2023 22:27:24 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [UBOOT PATCH] arm64: zynqmp: Enable the config CMD_KASLRSEED
Date: Thu, 24 Aug 2023 08:57:12 +0530
Message-ID: <20230824032712.13399-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: d67f38f8-6a7b-439c-a5c6-08dba45209fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufFKo9shjeGwVdokzEw4Q3XkRSjbJH7Mhl06vyS1HffpIKBtPGCgAP1Wo70KUJfI2D9uyB349bGB9br6I64YTh2Ua7T8ZoxIHLyG1E2cDAe65vCWqStK1w1PJFhZKcZK3EPbTsMtdnv655z1PpNey5OGIS2foPtU66iSQrijERH04S/5aujfLb9yIiFZZY/bEr5bzk/vDLSgaU5K/DHmdQsxUezWlVD01g/I2xBYgIhmCkDnPAFCDZkqFKBs85P7yw4qUN6kHqPDN6GKn4+J+jgaspBDpQAf7FBez95DxjR7avQq4xf0MAodJTA14XhTKIyQcWl1yVm7Gme1vJlIF16hKVyCqa9Iid18Kl553WxCpXr51GNi8LqRo+G9V8AhhLzsMsgHj9CrmqooXIdgSP3kcFmRG7ulh5USYkrsSDbe5q1t3VjC2WWstXeRlcMfhrOUVO2uPlZBvQU8Xo9A77TGkggcNFBcU+no0DZFUoqtmA9ZegRl/OLemr6OwAAAwel+HWgV+bU4Xvr1zYSa42Ex8TZfXCa7qn078CLXfkHZstS8i+FomlpEd5hGH5NFkchn/QFOYDLSyhbEnMf23PO4L9XY7GPZpGq2fkNjKi3fUv3fD3JcvevweI0FNZFDOcu4teWqpwHilIhZ9x+Rs3rfQgipdpdaEQCJSwaawH6ouu+Qiv6tmXzDKCOlLG9aixh/fPRbHDJ030W+0Y3NOQMYAQYCkGjSxMvnQJ0qggEc2+KbDPvbppKeBZj31jfdSCjd5FJUMebrGZl5VEyMFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(82310400011)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(5660300002)(107886003)(316002)(1076003)(8936002)(8676002)(41300700001)(70206006)(6916009)(70586007)(2616005)(54906003)(40480700001)(4326008)(26005)(426003)(336012)(478600001)(6666004)(83380400001)(47076005)(36860700001)(40460700003)(2906002)(86362001)(36756003)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 03:27:26.3789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d67f38f8-6a7b-439c-a5c6-08dba45209fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015
X-Mailman-Approved-At: Thu, 24 Aug 2023 14:51:11 +0200
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

Kernel Address Space Layout Randomization (KASLR) is a hardening
feature that aims to make it more difficult to take advantage
of known exploits in the kernel, by placing kernel data structures
at a random address at each boot.The bootloader supports randomizing
the virtual address at which the kernel image is loaded.
The bootloader must provide entropy by passing a random u64 value
in the /chosen/kaslr-seed device tree node.
When we run "kaslrseed" command from U-Boot, the bootloader will
genarate the kaslr-seed and update the /chosen/kaslr-seed DT property.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_zynqmp_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index acab38fefe..b67b637e52 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -91,6 +91,7 @@ CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_GETTIME=y
 CONFIG_CMD_RNG=y
+CONFIG_CMD_KASLRSEED=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_SMC=y
-- 
2.17.1

