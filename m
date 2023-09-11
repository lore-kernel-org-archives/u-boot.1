Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60215EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D61D86E30;
	Mon, 11 Sep 2023 16:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V4Htl/Rr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 214A886E3A; Mon, 11 Sep 2023 16:11:20 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED22186D05
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPX2b96cjm7IUdeohj1ywfFf/exHPKox1dhf2rYu66X3WR7Nju6fQKOyFa9V9rvQTvynMFIl8shMH9xMsWd4I5dreifNPO3hVWHAGwBYL7jUdTSIuA620Cf6WF7lQ+zI5L0acX7vLpIo+KjCrb3S3L7mkklku/vBcIvwvMEQslckBSs3W02z5tFpIzv3MHBhm1mtetIJPr7CVQibD8dDzctFGVLyD/Z1/D017IB3GBx5QWjPwzlIQlqEfCo992dpvj7WKNVY4icPP8KFoR2RyRiVoGjFpkVp8Ui9nlgRyQENa/81DnzHZ2Kp5YiwgPa89sbOWvRsPRWK7/XsrP320A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xhrgs0aJJOvZqS22xRHXKTVskdr+xWXuepFhbsuyngM=;
 b=YOUzqOp3dmv0qp6XlnFQo9auaoSl6T7+KtqKiVLsOMavffsKaZAvfMRutzdBdr7wMGvca4L6aUfSkLyGxDk4g9RAcucFC1atun+vFJn47n1UMl71Fk17phxdBqrv/PIoTt06uGI4aEswfMmD93xyCWbipl22zFS5Ik1FVxvNm6IH8xyCg1fT51iuY0K0CozOvB6y8Y6pdkQgGm2eZcjExa/TIAU+YUqU9M7zZaderritqLXOh/4TCKeHnh0+1oDGOMr5RDeVa7nWUIdGYJb5eein72GhrZw04RbUOXnLwbX12+4UohGoqx4sxiA5mxABccqCkU6OgwFYMkd2LcQ+Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xhrgs0aJJOvZqS22xRHXKTVskdr+xWXuepFhbsuyngM=;
 b=V4Htl/RrxJepS71TOu32t2wD280e8yzPdUkFWoSUeNRic8sSNPU4ku1t+fVojsUrx4b0lrDwFsYAbPV2WABen6z2TGlHLjgyyil32aHL9JCkW6fRWRZHDcTPdvyURCd+avixkt2iHoJzF5KvARtTACPS2HmN/AKrkrcrEXddBbI=
Received: from PH0PR07CA0118.namprd07.prod.outlook.com (2603:10b6:510:4::33)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Mon, 11 Sep
 2023 14:11:12 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::a7) by PH0PR07CA0118.outlook.office365.com
 (2603:10b6:510:4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 14:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 14:11:12 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 09:11:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Thippeswamy Havalige <thippeswamy.havalige@amd.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>, Harini Katakam
 <harini.katakam@amd.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Piyush Mehta <piyush.mehta@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Robert Hancock <robert.hancock@calian.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/5] arm64: zynqmp: Update ECAM size to discover up to 256
 buses
Date: Mon, 11 Sep 2023 16:10:50 +0200
Message-ID: <087391c3e1f60b0a765fca081d47ce632fda8f06.1694441445.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694441445.git.michal.simek@amd.com>
References: <cover.1694441445.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=jfblPisUx2+2RMHrh6PVa484kCpp66k0W5owksskJxo=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/8i+Y1Tw0A30WWD9jfNWW6HPp/PIHe32tHSTDH82Qv
 vFX4LBHRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjInwKG+WXBU6X+KfAIxqq0
 T9Jil1z458A+GYb5+d9PP+WTcD7074dyy9e1t3bUyCtoAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: bf085150-2d14-4d84-fbe6-08dbb2d0f458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4/wiXjq6lDzcTe/Jf2JUcQulF+MkB6BO1G56gUBQPoFaVNUYzhj04FEl5h1JyYYKG4wFzDcnetmahZOpLD0QpHZbLg/tZ7pOO+bTEHuhYwVafNOtNS/uc8sr4uM8Y/B2xz7b57PruEU02o0NMTVhyshGXWoyjrhuwGGlGsnrvKdqQ7Z578IbSFcLsWeDQp/APfCg1+9MLBxj3+BPDxBFPltS6RZMy2A4/7RvC/z8eD2mYVHo4YP3lDmBSuty3LG4Y02IAFhDqpIEUEET/kuAJLIKzTrjC7L0OEU2KEvnbizgqCMj+6AFMCA6ypVz6lF0Y25yw3+FD518KWpre32tvtyX8AOVn9LFoQElFEt+rttBuwvWOrbUpjrTAzQtN5IQ9KtJmGL3ZUXqQJxgqj4Zev8zrL6P53W12ebDz+8sIue1K75Tayjf25RbzxkjDmmJhJl/RL6URF4RZi3S50D/C4QJhRzlQIeR/cMhrnMmK6nnmYcR+2HETBra5fTR6mJeokKnP+KRvbtEDzBF7DMcVHb9SB8DcJzTNMuuEOwdNGVZknMaf7k53aaQuj+CfKnhkNVkuOI7ZTpzIfv0UMgok1AR51Z4Gy1DPTqlZWGEX5S9JjCua62h6LURWzOtQlA2p7+s2wWECX0/Rvn5/oxEyaw+mMOKWKS3OTAWFDIdt88JptiZbHUABbm0lElnayPjO8nNlFaMUG0HuWIvqXucYB3hlyUuivgOZQbdH6NpHs+4Q45Ef3TkZmIEFJEjPIt/UGBdlSjhxNBvDXFBkq7gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(6666004)(83380400001)(356005)(82740400003)(81166007)(86362001)(36860700001)(47076005)(36756003)(2616005)(426003)(336012)(40480700001)(16526019)(26005)(70586007)(70206006)(4744005)(54906003)(110136005)(316002)(15650500001)(41300700001)(2906002)(44832011)(4326008)(8936002)(8676002)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 14:11:12.4846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf085150-2d14-4d84-fbe6-08dbb2d0f458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
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

From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>

Update ECAM size to discover up to 256 buses

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Acked-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index a71875755bc0..79c5af241104 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -678,7 +678,7 @@
 			msi-parent = <&pcie>;
 			reg = <0x0 0xfd0e0000 0x0 0x1000>,
 			      <0x0 0xfd480000 0x0 0x1000>,
-			      <0x80 0x00000000 0x0 0x1000000>;
+			      <0x80 0x00000000 0x0 0x10000000>;
 			reg-names = "breg", "pcireg", "cfg";
 			ranges = <0x02000000 0x00000000 0xe0000000 0x00000000 0xe0000000 0x00000000 0x10000000>,/* non-prefetchable memory */
 				 <0x43000000 0x00000006 0x00000000 0x00000006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
-- 
2.36.1

