Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12511076371
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 06:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E98AB8407B;
	Wed,  1 Apr 2026 08:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tX9qyuvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA258407E; Wed,  1 Apr 2026 08:04:30 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6497483F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 08:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dK4dW/aKypVxZP3cz8S7Xyc3XxolyhCGMWVPlsRRoXnflAbFl0QVO3gY9PGwjWFQtkLBfynsPx0RQeb2xuMgBeNSEhZOx+Y/EORDhFcVQHuMDfKvuJcd+T2N5chSTdQflQfOF1p7ntLJrq131frGH5kEdCqB4tCCgBqze7hZ9rkFsR3GvRpmwMUk8m61FSLdtG7KH1CmpBtxru6/MtjNPc4fAKVNyqai7SlvUciprCCGoJlVdeGZxgBsUBpG16kupX2ne5ZZaXmogA5IbFUBPdVpp8riTqYk6e4Bjd6X95hXV44GTu1IlGHXG3pvW0hVPBEupZBQVRAQT9yy20K+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GVwp1alRADZL+xeiD0ogvIJLK8dZ8fnOWOjtFKPfQU=;
 b=gxZiWDt/CiZIkYsq1wXAGe/7NWgsQlY1jUC6IV8DKFJeLVBBNgkq8kV8Oe8mn2SFVPeNEMsydWb4IF58zeAz0tNRs20wrjkjH+sp69SFlw+6rmhBZ3EgK0AmUJ3Z7vlTTbtPxrqGMRsHSlxqlaR3vWkVWFU7avM7HFvusphr0JCDbAz/o0Xk+Wanu6ceHr2YwU6E9GoUf0vBu6Hphyv3LrKV6WpWJnnro+LTncMe7REtLcPRLxtot0TZdM8nA+ThQ107Q247yMUZ9Ihu2Up8I/L0GVcnvrd722lhmxjwj52/aYcuUGed4WO2DJhnDhBCPdm3B+74F72Uf7dFO+iy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GVwp1alRADZL+xeiD0ogvIJLK8dZ8fnOWOjtFKPfQU=;
 b=tX9qyuvELwg7PLfeug813FTAmk0piHc0p9HG3XAs6xsSm3pQVnystsREwjawGdBmU3/PMFfO8hE3A91E+kIkFclMwLZ/eT5UQ66jI5WiwMXhM5DdFHKEiqjg43/J+5SWZFx7803UucNMTZJbLbZ9Cq/I891FbGxMnkmlgpjqHQY=
Received: from CH5P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::14)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 06:04:24 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::96) by CH5P221CA0009.outlook.office365.com
 (2603:10b6:610:1f2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 06:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 06:04:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 01:04:23 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 01:04:22 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, Weijie Gao
 <weijie.gao@mediatek.com>
Subject: [PATCH v3 1/3] event: Check return value from event_notify_null()
Date: Wed, 1 Apr 2026 08:03:44 +0200
Message-ID: <cb15ff67b9915de6f0153d2b9f4114f9c8d8edfb.1775023421.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1775023421.git.michal.simek@amd.com>
References: <cover.1775023421.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pJl5J5/Vep9pfRVu71/NZonBY7GXG6G5yBFC9fZUuZ0=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSe2Rq8LLaj+zHbHu/GQInmSTF7/i1l1WZ8wsQu5lRdZ
 ysS+25jRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzk4W5Ghh2nPy4SPFN22Ha5
 jOint7omNuH1BVPbFL4c85bM2bRGI52RoW2X6IL7fYySGjEHTB6U3rloLhQ88UdAsXZKg5BsRIQ
 fNwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: aa75576b-9dfa-4954-3b88-08de8fb4863d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: At4H55HYTgWfZVd4qvqMcnrRbVMXQgCD3d/hRAs49sB+STe8KlCcfqCDBdasDpSBIUyUsI42ZiscYqOgBAUkuwkFZNP8vwodWtfFs9Z85XUEh1g7DA3RQIerdub/mGYT4FOqW3UkCg3gUkpMuaqnmzIwbNUFr/xwa6BlmRsx2o0h2lTmNH56F0J8QS29XNKOmSQa+W1swE3YHDjbwufKh133AYLVZaqlKupo9t/k9hqTJEMt0ibIS2TTQJIKDYm16xbed+2og4Uhqs31UwgD7oYZzL+lA6TVCXKwIiQv6x9/cMStjaVSR3wieoKUpyWPVheA//3R+2+LFrDaDJNvs4CqJek9RciUAcHpN7MOYdnzG73K9hBl/mGbTMfOtV7JBNlOR9hGIK7KubNQX1X9ma5s/U3VGRn0ykZ6/z3ESxcV3glv9cCy/pQEwFXkH5WWmU+RWMKWwVsmbQDR4gMyrqJfRFsmbz+saoRnun3uIK/nUn3JtvnPNbNmUyBk/GcR+moZLB5VvhdY5+hnmgrK+nVoCkAYJaMzLZkPuULzQBo2fa/xUzHQWtlHPwvgSqH4MFtY25nKVU91e/C/7i9m6uU6+yHKnNhnaxCLPmZJT9T9L3DhnNDr5LPr+F3roD5lqZWbaRtk7Ic45NVKB9cr3yZE5Iw9UPmXehoMYCpKxKIXd63P9KYfHsXfEr3ehV1lyyYzwzrjOFy0eP3sK+AR+lxNDuhvKgnINtfW1ONhKVDp84rqvg70xSnQAfZvcZT/sMo70A+Bt4oCoZqPRC0psA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kGT5DnU7ouYa2u4c/FR/43QOQydkmXX4Tnd7H12ERLjrecSqkxs6Q8a5BWSEvIuF2E0a4xWaAKAz6YTGOnQm3XQRQvyu0IUAGP36yphDBg9DgJ5tu/nX26BMz8PsGYRseakcBFugAAc1rzSiC0pY1rJU8hTfeK+qRRc4YuVTJWmfPer+azHIGxRgdLOeZFGf0JAPC+NCyDjtmEuo9FE6b0Lwf/IzSR1d76AlNTfgeOUQ0z7oovZktRIHoYXgCqPrfsy0rWmz0+KiTOMd/yMwJEA38oR8EPNlC1QKaf4Dt+vOUFGHO/GGPLvg55pvkuoGdXXr2u3VTdSeflUCdCLbjBup2ZLWzxAw84sVl/JxhhX4vFsJrXIoiyiGN9+DPv6gxiGz8qiL4iCSMMqf5ZjIGyCQSPWWbruRdBCxMkpYbUdZhf1kMFyMZkJL5+KixqfM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:04:24.1916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa75576b-9dfa-4954-3b88-08de8fb4863d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

event_notify_null() returns int but its return value is not
checked in run_main_loop() and in fwu_mdata tests.
Add proper error checking to all unchecked call sites.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- new patch in series

 common/board_r.c    | 6 +++++-
 test/dm/fwu_mdata.c | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 8cf0e14679c0..5d37345ca09d 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -569,11 +569,15 @@ static int dm_announce(void)
 
 static int run_main_loop(void)
 {
+	int ret;
+
 #ifdef CONFIG_SANDBOX
 	sandbox_main_loop_init();
 #endif
 
-	event_notify_null(EVT_MAIN_LOOP);
+	ret = event_notify_null(EVT_MAIN_LOOP);
+	if (ret)
+		return ret;
 
 	/* main_loop() can return to retry autoboot, if so just run it again */
 	for (;;)
diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index b7680632f95f..643b647af0a9 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -100,7 +100,7 @@ static int dm_test_fwu_mdata_read(struct unit_test_state *uts)
 	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
 	 * to populate g_dev global pointer in that library.
 	 */
-	event_notify_null(EVT_MAIN_LOOP);
+	ut_assertok(event_notify_null(EVT_MAIN_LOOP));
 
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
 	ut_assertok(fwu_init());
@@ -127,7 +127,7 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
 	 * to populate g_dev global pointer in that library.
 	 */
-	event_notify_null(EVT_MAIN_LOOP);
+	ut_assertok(event_notify_null(EVT_MAIN_LOOP));
 
 	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
 
-- 
2.43.0

