Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A70C43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 13:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E608F84A77;
	Tue, 30 Jun 2026 15:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G27Di4VC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EDC84A72; Tue, 30 Jun 2026 15:18:07 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4685084A5F
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 15:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqUlQNGdteimXZWijlo37njnKR3kZCkUhWo0b3CvIQlpL37h7KOqaJY5YVKCB2yZ7mi4mhYdfLaZmfBfCEjyi+3vIS+aK/EkI9NibEAmLwqZ1Pal0Vcb1gzuRv2a85UrcaZpBLA6Wf3HKTnPq9O05CWnnytpAgCEIEbf1cksdn6wIu+SKi8xzNgY6X0DIR5Wmdlr+ImTvCfHre2PhNIviQaMefF6Ox8mQNBEukFqlLYnR0HqtjKfmaB4lV8UdzpLuZM5CAwlYfd81ZnGqqmN85FROXAjk+6r+3bsuJuReHwdHKwsse5X62KGK0/HgOQ86WfrYhnxFjwD9LizhbjnfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7vUDozdwb/ATQHADoIg0TbX3dBiPXOXQ4rXRDRG+lk=;
 b=EqqHG8UP+x5uA5NGP90KLbS9i2Q1+s6u7ghTp+iwCa/Q0E3NrbUTqZLoGqa+vcUPM8yQi5olDIqtLZXzoW/NkYZsYuuWY3A3e0YG7BxiIH0UwTJefLDIZZI9LzVGc29NJfkGCqusZMLt3C9su0ytN0vFD2aoRsheUyAJFwdh1YEgw1h11JkKOucqPLqpQqAX88kfmvcGBtSRh62uowq8D4zL/jPWsjJvgzqlXz+Kb7x/bPYikEyy6qmZIQbT4WK5uy9wLO6YKvW9/PkzaSP1/HhIBRfIBaiYP903nn+Ipz29ns20cCOZDbXODRkAx9D/umbrjDwpEPwSe32qE6bQ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7vUDozdwb/ATQHADoIg0TbX3dBiPXOXQ4rXRDRG+lk=;
 b=G27Di4VCxtJ8wekM+ruCksroWxEXiNUDXSqIpaRlhRvH3SOdHzfdf0HpzKYplQeEMaL6nQeA78bBHXAWIXSuif1Tf7Xu3cHXEwQDvz7P+2MbHNpVL9yRmlkciHzaYrNo9HKv0Y+S61XUBbdNkyHReOT8p/XAqNJSbR0PVm8Xj5k=
Received: from MW4PR04CA0336.namprd04.prod.outlook.com (2603:10b6:303:8a::11)
 by IA4PR12MB9834.namprd12.prod.outlook.com (2603:10b6:208:5d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 13:18:00 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::44) by MW4PR04CA0336.outlook.office365.com
 (2603:10b6:303:8a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 13:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Tue, 30 Jun 2026 13:17:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 08:17:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 08:17:58 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 30 Jun 2026 08:17:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kory Maincent <kory.maincent@bootlin.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] fwu: Gracefully handle missing FWU metadata device
Date: Tue, 30 Jun 2026 15:17:50 +0200
Message-ID: <5e5241d02a04871a06dd44d3f8638f5da10893ff.1782825467.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
References: <0bd1a1b8bbe48fa3a9b89673c1e1357d50d0684a.1782825467.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=AubepPvSzdffzs2FFcAA1ls+Z0tOciewSA+gBqlYzA4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ5H2JoitvhN83jOJPjbat01zKPtCRTRi8fqymmKdMjv
 x3/9UWko5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACbCtp6R4c623rzQFVn7HllV
 av0IXBD7Q7k0bNbsQ8bzXa40l2nOK2X4K2nz1nbnG3PPyZsFnm5I05mudZHpacwLtSNpvw+2/pp
 czA0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|IA4PR12MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: fed95e70-b3cc-41c0-5b53-08ded6aa01f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XuPWEiXi4EZ+GJfKpBNvnQgdx02xXvHpHuwe8hCxkrLnW8MWYZY239JeBwWzDImfrxY5QIt1NqkJpLLnf3w32I4rKyeM0pMeRd6TFC/UYUB7BTYRKmut+/ep/0gLLuae4cU87ruVr1l6trfwWG7X09nC158/4oaq/1myyChklds5Lu7ENrWuQ7tPrx86ORmJ+Yyaa/voYhRKpOiIahM1c6xz41qthsrMG6edSen+pHbDJ70u7wAl8fCk3Zp4BaA2A42hvnXVlsDqjHh90DSzntnaXLIHqIBw2++a3KKGDcOh3CZkMv7mfj+v8tQ82BnFfmcnr6tiA1Q581DfCIiNpdD3hJSzyhfnAIDQCKaJtvkGW4df0ThP6ztBXXCpfUcd24mCvAi31GRYjwCi15q2KrCF+/+FEJ9la9gRntLLCRgdNNlv3dPIug2sq62kqolO8Gd/68FKnDs5nALAn5D7ps5ftlJmbf/jZo+hdByc7JekX4Kb0Z9UhH+uUATdCKXDSpm/GAcIEC43Ya8gP1LSD2oP5003W9ihvV8HO0TODDTz9G35cH+c9NLIyAWtix+gDorDP6hSJ3IxpNKPm+ioyBnhrZ41Sts6FaBwsFbj6CwiCJ1hCqT7SR9KhvMve5z5ZgjtlUkfrfZtmNe7Ezn7OYRTiTeUKCBISItBSw1MOWkf17AY17t/ksMBmC/kQifJVYe0sk3EFluUtJPtuFXD8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mf2vZvRDjjVz7IdKFOriqsZykEfno92pWXe4peTQAwccW/SwMy0OcgIcI7BgwbWrD88x55GADWhrVZ23Ev5qGbqQWvM1MYWfX4ZTFZjm1SRh632Z5k6cf5yt+my1bbUa24pV2niFxot+J16xXsz97uUU4/gZnIzDMMRlvA4dK8g9W+AF0F/Tx6jW4dGYPWYHWvJvl7ktZrtsGZPpl0qMUx3AETYWmQ7rXVWSX3PdhUfz+80ycy5wYBc4eDbhGaIZsT0vzQQeKDynXY6DKhFMUt769dI2XwbQADZgzOuZrphz/598gJltu6dguVCzp/M7bKjvwkMKd7POAQ1j9bNNuE/igho2hb1TUDHd8KgmLeVcPbb70fsE3Fl9GoChvd2w/nNictUaJq0Xe9hGafFU8OzK2Fogs5ECXs7p+KXr/H6JL2aP4rS+R2SOLUxX0J4Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:17:59.7565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fed95e70-b3cc-41c0-5b53-08ded6aa01f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9834
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

On systems with FWU enabled but without the required DT changes the FWU
metadata device is not found and fwu_boottime_checks() returns an error.
Being an initcall, that non-zero return aborts the boot flow

Return 0 instead so the boot continues. The preceding log_err() still
tells the user that the FWU device could not be found.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

We have reached issue where testing team is using the same defconfig
to test both scenarios and difference is in DT itself.
I think it should be quite save to return 0 if any UCLASS_FWU_MDATA driver
is not detected. If there is issue with fwu structure error is correctly
propagated.
---
 lib/fwu_updates/fwu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index e9bb1b4fc656..25eb5af572f3 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -760,7 +760,7 @@ static int fwu_boottime_checks(void)
 	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
 	if (ret) {
 		log_err("Cannot find fwu device\n");
-		return ret;
+		return 0;
 	}
 
 	/* Don't have boot time checks on sandbox */
---
base-commit: ea62096437b39ff9038f7169e461bfe7863ee85a
branch: debian-sent3

-- 
2.43.0

