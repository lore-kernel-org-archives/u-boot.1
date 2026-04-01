Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941AC1076372
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 06:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A4DC84088;
	Wed,  1 Apr 2026 08:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jnXjDoGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE685840B0; Wed,  1 Apr 2026 08:04:37 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D1A83F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 08:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiXjli1mzZxh1980EFNfXMrG1bGos8R5w63P8+G6NocROdoaz0nXHZIrW0cGuIbvrJ1z+PA7aTlriCA3RjpNb6NlurRdfKMR24ePAMVIxy8JvFVJ/RSE6GZWAzUj8ZQ3bL9zUUZT8mB0WgkyJJL0AAh60JGUf+ljhEKWrrydLyfMi6hzdrbipivYnTrWKY3RAsHEW38U/OiF3Ib0rv3NllAWe/e9ALDQeZRRcHOWz+UAtkYOugnUxF99LHJ4XBplyKnZUorLI6cW16bYOpDbTBhZOgCkoJudFae5tOkcI3Tcbq4epMcIXxfyk1BoIF5gzHE9G+nMpzd0d2qVrENPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2idZQvoj7JcDQ8d+ASM96keYKVO8Y08LGZTBuiuMAco=;
 b=xACLi3qOpw9lEA7qef+yUiwfwSDn6JQ0ldys1FXd8ezOysRlZdkvPUD/+ioY0ER80ulOfAdxE9KEbZDApZEHwjhJhFa0Iye4Sez9N0XaxAgAk2+8TJLBx4c44M0TZQPQSk3KAPeht3DNDyvcVymVLIBDDSsId6cuu+DwPAUAW5nYZUt1h4ChYxm+dlxHrKJFObvUArwtH8lW9Q+JX9eMVV9kvtt91dUtwSVJxY1FQ9XHWE/3LQrpB7fZNf+m4eFKwc092df3MTrPTXICzrUireMXlgenosZ+BlvDi+lK4E0H02cZPv4/qd+Jl426OQm8NmVReC4ThQM1H+K3L0nZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2idZQvoj7JcDQ8d+ASM96keYKVO8Y08LGZTBuiuMAco=;
 b=jnXjDoGZkm13PmeVOoI2JZo8SBXazG3ZszOKV+hsuoUZApHDi4wgqU9efv3oBGzrwYeuIaLZUtj2whthm9ttK8gQopHYfkSckZi0J+pCnvvrLJiIDPynckMzoLCJlLqMwcknZz01D7Sm4gHDzX5RIAgsLPKw5LdV6O8YoVy1Zws=
Received: from CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::21)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 06:04:30 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::b9) by CH0P221CA0039.outlook.office365.com
 (2603:10b6:610:11d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Wed,
 1 Apr 2026 06:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 06:04:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 01:04:29 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 01:04:28 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Kory Maincent <kory.maincent@bootlin.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v3 3/3] fwu: Move boottime checks to EVT_POST_PREBOOT
Date: Wed, 1 Apr 2026 08:03:46 +0200
Message-ID: <7fec12cfc852b25785577b4871b11d5629a14a8e.1775023421.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775023421.git.michal.simek@amd.com>
References: <cover.1775023421.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JGr8nXWnwZuEoGEdXLcS6H0JeuMU3j8/ahHXdAKSpZE=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSe2RrKotS1PDFIPPqxoaDzpO9B7q1vtKbPsjjtM+9wh
 4iDTFFbRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzkegDDPzW7LK4N05ZNkw8L
 i8tW29IhcTjjZ8Chr6kpG/715N6q8mf4K+8tLfV5TvnHzpLPk7i382+/mvWb96uZoTjTnXmCIpl
 zmAE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 53967fa9-c738-487d-f647-08de8fb489e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7PlxkddDKXqHc9ckPQ4vG9EoFu8UJxpEejIUCeo+23jZTXEWRGt9G7vAqoEB49kayCAMjevwUwB8gNx6qA+sqyT3myjIVg8B0eNrBcTYkBIZm9xgxKPwwPeoIFvDMmzZEmwAXs+SIdpLZR+jv5T42aveedCS+3/YiXc6A8aM/S+IwhHIOWGtxDL10KS9zauFiSdSWE0XtNvv7jjhZCY1Kl8zKHjroZPGMuuYFOtWorskC0cuXiuP32irLRmhZncy/slH7/gvNzoMRq/tIhX3Sc6JBx2GCvvtb1N4kerrNDD+shhw+chlPAgc5LoLxKZTAtuSzirrkcqc9Jnih3uJ3K9YYWhUBTzMvMwFoVFrEkO5a+w5d2QC1c3+9BtikMFIX0NftDdCpBZS6qxqOexIIbuVx6Pr7a1U5UMIH1xYN0DpkFEiD23YTaslU6L8/M3bcwmpbj1iGwKn6gxTJayi6dr61KYXeeRv6wO5+He/dNnJKydnEL0+jIB9U8isODBvXyTR296V1k32awn8dz0GxBIeYWk/XaQnD2MTLRGX6iMSuu1h6AZoiaThs1Z00vytAE27VXTfMVLJNCEW9rc3H1ejSr8Zc3MBy5P/AQ6sjKoXzeCXfDbxR1wmjNKGca8kZZSWNbYLhDUpqZSV2M3Q5fPeDe3Xg4veVxFcBBBQWSXPvv+cMt7tV3qhtYaH34BEABGRkM9EB9vEi5l3pDfKDmo2x1YMSKiyoRa+YUAHxfjnzRxFmAaLGfxbNmTJTHwKOZpXHsO32S7e2Lm+N/EIdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XtuDInwNaAjorfMKMnrOhFvV/xoc7zW5qG8WanTvT2+u30Sud/Q7Ldv3ryP40sWdd9RY6fnyDUWh/htIv4+OLBLhP3ae9fUR5hvsQc9ogl9CPL94vH1y9XmzIPkMC/5nqJUx97ZPR5MDkFcIMpRAK7fO+cr0uWRcCIXXzaSGhx6OPJZrlsLBG24tyclXrBwwpUlEHRMHXmw52F7mT2IjO4b1FV2rxp9UWgg5sM3Ho+4aug/FPIDub1YfOLjXHx3UcYI8kWr4tivelxY8bzo1bzTkQnySkdaVM++2x7D/d3HxgiDPfgpJKpoHG8SXQb4IK0JTvn+GUC0Ek7yDlbS/LZ3z9Xvuw3f+oHFfS47SRDXv39j0msiQ6qyC93L9u5F2CDVKhVR2aGlIiRyc7OeMKOqG99bsfIiEUp+V4e09RtmeNBBKDNQjL6ob1M7qb7FQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:04:30.2757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53967fa9-c738-487d-f647-08de8fb489e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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

Switch fwu_boottime_checks() from EVT_MAIN_LOOP to EVT_POST_PREBOOT
because there is no reason to call FWU so early. FWU triggers EFI
stack initialization before all devices are visible which prevents
the EFI stack from scanning these devices and adding them to EFI
variables.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 lib/fwu_updates/fwu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 37c613014d18..e82600a29a40 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -796,4 +796,4 @@ static int fwu_boottime_checks(void)
 
 	return 0;
 }
-EVENT_SPY_SIMPLE(EVT_MAIN_LOOP, fwu_boottime_checks);
+EVENT_SPY_SIMPLE(EVT_POST_PREBOOT, fwu_boottime_checks);
-- 
2.43.0

