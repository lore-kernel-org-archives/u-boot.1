Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBBCC6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 08:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E1086514;
	Wed, 30 Aug 2023 10:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vaa0bzn6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3678643D; Wed, 30 Aug 2023 10:31:53 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4D548643D
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 10:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnxxLbOrp3Rb7CLXp9a4E0ypAMGDR+UiGcSZt3YA7G4hCmApSRI38tEciulEghF2yyt6BmPA8UBPhDVJKpYpiEQ6CahNaChbTa3VO8lbvPj+wKUSXHsGAyWcVS7+pHznTcCImVHBo2b3UBBfLDuC8wHzfRPyT1opzttLEw653ol0C//TPuaSdfZLze8zeNaEjBR+gFz+C/3f/0hOgly25z+Wj06q5W4s/BaAF9u91JwCNyXPgTQA2YAY5f6qCZqqlTmelot5RHjSJGRUHpSDV9qIDxiuhknYaIhjd50tyaEP6BkNZV4oi1R/Lkb3yOWC1e7sEdHXEDw6npFTpiBeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/SPYF+vlxmOo9o8/7p9ntS4tMSRDrESKqayGsIVAIo=;
 b=YGzkIlu6wD0lwEg8II87m8eNQwRTsnM67c9rmwwlOYb937gXUaCR13eLKghoFcOrL/kRCuMSVaGBVDOgXs6lNyZFW1NTzfApRH0ub61TWiEZUPRNJu05f1Sw5iBem14Ir3KY0CPDqLhSY1XULLJ/hIJckc1PMh1PX0KJZDQgLksXrJzSeJ+XMoviQZ730ji89CmHuc6UNi2DLMoQpAEGBAsPpYScgUlWk6w1ep5FNkXebp6rAliGGqFuKHwV4VpZJ17mHfJSrNjDNKNcbVEiZJL8eN7g1uIAnz0xhrNsiZD2GxQ6vdsWIonomNGc+npfmmVAjlv1ts/mcqhFanxdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/SPYF+vlxmOo9o8/7p9ntS4tMSRDrESKqayGsIVAIo=;
 b=Vaa0bzn6cgYCwzr5P+Ff/wdR7tKV2TT0Mt1vvu3Az0mVvmnmUOuN41nk0iOG5wEDURWylaAZmz4KXQ9pHFRNX/H4JTTHNRbkxoQWyiNgCNiTlSFBAIqLizvRYdjAfkHyj7zrz/+S9T3OdgrEzCQvzo/YKafjE2TsHIDo0EXvu9A=
Received: from CYZPR12CA0009.namprd12.prod.outlook.com (2603:10b6:930:8b::24)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 08:31:47 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::cd) by CYZPR12CA0009.outlook.office365.com
 (2603:10b6:930:8b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20 via Frontend
 Transport; Wed, 30 Aug 2023 08:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Wed, 30 Aug 2023 08:31:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 03:31:44 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Tom Rini
 <trini@konsulko.com>, Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Lukasz Majewski <lukma@denx.de>, Nikhil M Jain
 <n-jain1@ti.com>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>
Subject: [PATCH v2] clk: Dont return error when assigned-clocks is empty or
 missing
Date: Wed, 30 Aug 2023 10:31:42 +0200
Message-ID: <a9a9d853e0ac396cd9b3577cce26279a75765711.1693384296.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=6SYDwOnyt5AFMslOo/KFK/DXcsN7sLYvLxI8AcjE+XY=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpR3/zJvpz5TzROo/VWfuF3izFVB35ULBPrZdn7fZbV+a
 0U3i3BsRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIaD/D/ICM1f3+SxkyWXZ3
 xGzN17XYLeAnzTC/wLhk6jnliRU2L08H5QQm7pv0NcgGAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a79fbf-91f8-4d4e-94e4-08dba9338c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgC3JJ6WcgwdOfbI0TpdDtO70ASdFUMkV3COyBzo/03DqWIhe0gPvef2ceuDud6KhiXDKgFwi/h4MzyshpacMlCTkImgbbuzAphyZkdcJPZXRG3N+E2sLGRm8lzfIJhoE/4rKT18z65geSX4MJgTw6drd4j7dB/13ZxtgwVOh4BrTD5tjmJlLY1YeT52iOI8/E7vmes/SQ/WOdXz6pek+LHX/CjOVMEmxwE4Ifk4WWQP1UAc4MfczDClY8ycI/L6VtXqheRgrQ3Pk1vMDgNybfyNfBMuqd+24G4JiqUwfZnKEsn9JqYhY8aR+H+PxMB5k9b7GdZVhe2h03heoDE2V/XcS241qw/5fHz5Cku4fG6oA8okgi3tgnzPgeBzzRFmwTCYFmHUIJXJOFMMbgx+TYQD0nXlZ3hGsRR4PAjISHI1LnUeFk45+8TgKBIJV7EL2K/YzelSF/+0anmGEcGWlUbBQAPBV4jWMkY9xpO7rEjd1CUjsMdgRzXLgxhLQpPFrYqidxlbx4i9BKtzMv9YCMn0QRrU5Ba1RlmajsXtWYzeMNvr3yTU9w/dwZGnIU0xkwh/il+SF18YoVqBBP1LIBas4h3tSMMkZoquqHpAEMDtEEZhC0epQK4vEDG0NthVNgrXRneixUW0boByLdlEUIabY/ox53OSJo1ubP3cG378K2uEK8bZnB+wXQgI6v4DJMRWEWqv2eoi6o8RthOKBUqPLZRa+PShlhqm2AQGGZhOioviRHKIoH/kxWbwsX2wq2MMHRLAl7vk8BqXe+gDtJDAlyLvXPVS3Qc3iHzZFfs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(2906002)(70206006)(426003)(478600001)(26005)(16526019)(336012)(2616005)(316002)(54906003)(8936002)(4326008)(41300700001)(8676002)(44832011)(5660300002)(110136005)(70586007)(36756003)(40460700003)(40480700001)(86362001)(356005)(36860700001)(81166007)(47076005)(82740400003)(192303002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 08:31:46.7979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a79fbf-91f8-4d4e-94e4-08dba9338c83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

There is a chance that assigned-clock-rates is given and assigned-clocks
could be empty. Dont return error in that case, because the probe of the
corresponding driver will not be called at all if this fails.
Better to continue to look for it and return 0.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Add also test to cover it
- Add Tom's reviewed-by line

 arch/sandbox/dts/test.dts | 16 ++++++++++++++++
 drivers/clk/clk-uclass.c  |  8 +++++++-
 test/dm/clk.c             |  9 +++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index ff9f9222e6f9..90f876ac9c78 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -589,6 +589,22 @@
 		clock-names = "fixed", "i2c", "spi", "uart2", "uart1";
 	};
 
+	clk-test2 {
+		compatible = "sandbox,clk-test";
+		assigned-clock-rates = <321>;
+	};
+
+	clk-test3 {
+		compatible = "sandbox,clk-test";
+		assigned-clocks = <&clk_sandbox 1>;
+	};
+
+	clk-test4 {
+		compatible = "sandbox,clk-test";
+		assigned-clock-rates = <654>, <321>;
+		assigned-clocks = <&clk_sandbox 1>;
+	};
+
 	ccf: clk-ccf {
 		compatible = "sandbox,clk-ccf";
 	};
diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index dc3e9d6a2615..f186fcbcdb86 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -329,7 +329,13 @@ static int clk_set_default_rates(struct udevice *dev,
 			dev_dbg(dev,
 				"could not get assigned clock %d (err = %d)\n",
 				index, ret);
-			continue;
+			/* Skip if it is empty */
+			if (ret == -ENOENT) {
+				ret = 0;
+				continue;
+			}
+
+			return ret;
 		}
 
 		/* This is clk provider device trying to program itself
diff --git a/test/dm/clk.c b/test/dm/clk.c
index f48de05436bf..01417fbd8257 100644
--- a/test/dm/clk.c
+++ b/test/dm/clk.c
@@ -36,6 +36,15 @@ static int dm_test_clk_base(struct unit_test_state *uts)
 	ut_asserteq(clk_is_match(&clk_method1, &clk_method2), true);
 	ut_asserteq(clk_method1.id, clk_method2.id);
 
+	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test2", &dev));
+	ut_assertok(clk_set_defaults(dev, CLK_DEFAULTS_PRE));
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test3", &dev));
+	ut_assertok(clk_set_defaults(dev, CLK_DEFAULTS_PRE));
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test4", &dev));
+	ut_assertok(clk_set_defaults(dev, CLK_DEFAULTS_PRE));
+
 	return 0;
 }
 
-- 
2.36.1

