Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA50CD68EE
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 06:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510A78647E;
	Tue, 10 Oct 2023 08:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ybbjZiBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6ED886D2D; Tue, 10 Oct 2023 08:31:57 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64B528647E
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 08:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3Vc4GlMYv/byk7Fi2Og/LwdvB4yWVnq0hS9COc2Qj7Ni/qgS6xDkn0K3aI0Ek69QrXGtVj0icygLrDsgz13DYPM7egOaM7+picvS1A12nCMcSJbWV+8zmBo3u7cCKrpEZ9jBnetSxjbstF22oyWMm0+y/yEdAJYcOPcigr2p7kigA54NsG4jEVpsVXqP+UFLoVbu06V46zMElp6HkoO2amLOZXNBbkriJ3ossb0HCTH6JfEhex5kTVKkjaMDHp9igaeqMfjFfhSoRKG9ei/g0zWGh4TRw4RjrtcbZD5auNibFV+QNBejAUC7j84gdaFjhVwR+L+v2qkvjqj/zaV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWheCFomNkDzqtjyP+EVGkut6YDiJAVN5ZQsUZjD6Tg=;
 b=ey7ndew6eMjBdGFwZwAjFC7VxkuAPK8oIQ8oSJBvl1hWPhLa+lFUG67nh3gM3wHVdoLmvxP7aywHjIS7ECRNY6RZkC5KsTX6q6pbFnu+P34dGUMZ8kw4NtcNo+A2RybGWYiiGa7MufpYJHRzOLu1asaIqt6SyYMBxiR6wO6Kg7gNBvcFbLt/hgTMuD1Swjj603s++jKvchz/1XNHGFv/H2KmYK840sdu0kxmSHl21Wb6xPCiYvjWUoXM9ZUY6+a/TDiYsCoteRH8KTwCbB4obJh+Ft6lxW6kPmxWEkcM7MCM4IrOxcPL9izf1B+p6/Eomv68rVZyPrMtPutvex1N3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWheCFomNkDzqtjyP+EVGkut6YDiJAVN5ZQsUZjD6Tg=;
 b=ybbjZiBn1QLQ7T8vcKtn5+dWIdqdeQTdaM6mAMLoolMScxiAaY1UTdQEUOrFpFNxANE/vgf+ra2diwe8XSEvKadrQH9kjCBcdT7BSBWrEg8mBF1lmJgOu9Si8dKW9yZ1jJpxN0SPv9MtoYS2bhwo1YQPwI1VpMvd19z2imqoFOY=
Received: from DS7PR05CA0063.namprd05.prod.outlook.com (2603:10b6:8:57::19) by
 CY5PR12MB6576.namprd12.prod.outlook.com (2603:10b6:930:40::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 06:31:51 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::7d) by DS7PR05CA0063.outlook.office365.com
 (2603:10b6:8:57::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Tue, 10 Oct 2023 06:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 10 Oct 2023 06:31:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 01:31:47 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 10 Oct 2023 01:31:45 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] drivers: firmware: Handle error case in the zynqmp_pm_feature
Date: Tue, 10 Oct 2023 12:01:38 +0530
Message-ID: <20231010063138.26471-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CY5PR12MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1ed2b2-8b2d-46c3-51ae-08dbc95a960c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5s75iUXz5nebPaKQeQ0Ot0Snugc3VYDMo6h2oB3k1Zu9BQzVGPbNOvXZvvX7sAVJpgavlPxp24sBwCTcmq/meABDjVkL3KakBJJ9ODPWD6x3ieLUfwa6iDvLPUP8wWKp3rGwZYybtz/eQEvjn73kyylK1DwBD5KQ6YY6+n/yWn86R4mY1FI9Ubjcn9Y4Rr9doLJnT2x2b+JCTOC0viJ8lkdxvcJITgRkBep4znuLNg+UaPB+nf5pX8onPmMKGdohPExQD1HCu07QBJT6TR1m4CAo2PPPHf3mQm0sYoqSHmmtuOH3v1HssFZ41O9MRKpVvgrcTGgMORD5qQdewPaRimCmdKVUSSaUTbVJK8w6wbJlZp+UeVt3Kdtla69ZdkhdStNiFHvRdxSQJfluv+dZr9ynvZsdKFc0V4TJAC0zkyuwIvAz0i0Uquoi//g116DNK/Hn9tYLXlM+BDr/NZ1EhysqfFRk/YDH+2PdGdUFwS9NqmJzD0DrDPVR6l6y77elvRrNSIk69RzHiIbQFjNmLAkLrIlAska4L6IupUXDIUaP30H09ECd9dK37i30xk8YxFy8IzKrVhlZ4H1k+p/5KQUoF5yU1mboXGjc15DD0JLtZPYN+8C2kQQyMDkICM6ci12z0tHhoIA4TausLH0oKZCLYFTLlBTKQ6ahyZdjyuMeHOJpzja1ZEOmtsXhrPzhaiyqYbVw6VV/bCGWNTc71BxQAeyBqNFPSYNBUnjVUt7gSSrTdn19xXEJLpdSeuiHFy52leTepuRxReXcVlTHNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(86362001)(81166007)(356005)(36756003)(40480700001)(82740400003)(478600001)(4744005)(41300700001)(5660300002)(6666004)(4326008)(336012)(8936002)(1076003)(8676002)(107886003)(2616005)(40460700003)(426003)(47076005)(83380400001)(54906003)(6916009)(70586007)(2906002)(70206006)(316002)(26005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 06:31:50.3905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1ed2b2-8b2d-46c3-51ae-08dbc95a960c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6576
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

There is a unused variable ret, due to which we are getting sparse warning
as below.
warning: variable 'ret' set but not used [-Wunused-but-set-variable].
In case of error return the "ret" value.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/firmware/firmware-zynqmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 43fb7fa778..57d5a1f469 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -204,6 +204,9 @@ int zynqmp_pm_feature(const u32 api_id)
 	ret = xilinx_pm_request(PM_FEATURE_CHECK, api_id, 0, 0, 0,
 				ret_payload);
 
+	if (ret)
+		return ret;
+
 	/* Return feature check version */
 	return ret_payload[1] & FIRMWARE_VERSION_MASK;
 }
-- 
2.17.1

