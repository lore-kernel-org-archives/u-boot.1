Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320D2CD8CA7
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9403283FF5;
	Tue,  9 Jun 2026 12:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B4gNkyFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2467A8405A; Tue,  9 Jun 2026 12:11:04 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079DD83FEC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0mZO6IfYbTRjQDSCZQRJESrrDZXuBzFBct7/b649w8I26HtzmFixMhnRvu5gO7PmS4Ff+UYo23a026rG3mEP5qIHhsQJoWMxwUzUPobmj4P3JZvO63l4WS1YViwCLWjFwyLtWOS6ONkLnEnl2WGV0/eTwVQfQi7PeFd974rqNRV80R0OXUjkcuQLy4PnE5V/J3aRdFZf2W2f2rUzhUfAQcnhWwSfwSZdQ0ahRtxxXMBrY78ifg+LjeidJTnBeXMO2aTC25CLMWdjHf3058oT9FSInb7KwCx2KXveEw1Q0LGPyOLy+TCzH+ghFuBy7oDE5lOKAk81KjvmBzZS2YBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws4VgZc4PmJ524nRqhmE2tkLL/Sk3o5GWl/uAvby5J4=;
 b=oFZFxgnNgu9yjxBprjPwx7byeOHZoM1h1Vp78/pYLKT4voJ1QIR3R2RW+075zf5WXk/MCO+uLqyRFVDsFxpVzoH32WYDdT7QgxaDKTO5oZpXENx1EmKmbhwxfXRT2woAd9QMNiczGcUhDyw/1z9Z2mqOGi+rBsKSeoNJjiJBd1IgzVyedg9kGZw2HXAGLc19y3K6kSw+jku8qL/E+//mVCoZNHQ0rqUA3mbXaZDihlHMW8xGtZwbUt1tqvBnHv37doUI1oB18yNFY2LU+FFFasY0bOnzqXzTTnOYhCq+uMg5I24Xb6t2he5QJmkzUDFXi+tB5TbHIif804AJG+FhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws4VgZc4PmJ524nRqhmE2tkLL/Sk3o5GWl/uAvby5J4=;
 b=B4gNkyFk3lu/OmVLE8M7expDePoWyP9D3WsyXjOP3K7QbeJzQPzfuvynCH2nxmrK6yrvd4doF2Jdjg/HV3Q5leWY1xMxm4Z5J/Zkg27ZkiKFUWzDyZyguGrXgC1Cjlp986UZYQqN2UtV9Mau5QI7ECWyPitGY4+TX2qth6wTB60=
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 10:10:50 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::45) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 10:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 10:10:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 05:10:48 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 05:10:46 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] rng: tpm_rng: start TPM before reading random numbers
Date: Tue, 9 Jun 2026 15:40:11 +0530
Message-ID: <20260609101039.584994-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e36c6ab-13e6-4734-a512-08dec60f620f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: RNkfLobAdTogkVd+XAau+7eyE0fylbn3dHx6sGhXiop1PIy2D3mHxSKDpcMSJZR1x3SFj56OOZz/XcAaHZC+UEA2TDbZOiFTCrKZgNMqDX9dKkKWumcdMgLqqdP4k3z87mzTXITwyTq6mWwWrFBrewfI717ZcmnUCkZ3sdraBKDpXVBzhwDoAb2iCWCTnXoy94ynGMkq66uMEeGGRm4ZHhZke0WE1hchE3aLLaW3DMgLe0VNT8A+ywkZKnIbYuov2TQSHy+YtNXzPjDNIEeZzvDDmAW0wWScSHN0tnDX0Vs53fEwCzvzSh8Aw3ScOmfTBG21nPeD0BjMcaGUvvjYyx5cVrt+lEEbCbOBRUdfIcAtRRqo6Ck+moYhoxoWlw6shCxlvwYtcDsniwZlDgZAxLZtRtgP7e3Az0ZiR+OvW/wf8CpqcTEry/lwXwcuFtUp8fD+fBNkdMX0CqCJVlQNAf20f5Z7XLKEVfgBWuiWWtdTrsCOPm8jUuSODCqZTgUzteSJvuRZbsXUGsOXe2sDos3dQMRuyXJtNMuNG+xmkh5vAsmvXsQLsA6InfB05Sn8hxwb2l6qxA+qRBwU2UCKj9Cpszshagx8fcpWyFzF3ysl0ooIHvFHk60USA1qBao/lMaHcMf2MZRT3/qqwpoZT01/T8RwBu5iDEUjeVP40U97UOYUDEiPuHiVvHV6885Pfe1UMXyinKlFdf81gbsF7051VMiQj3apYFaWk5AAtV8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dY2IpBwVflwzuZVArYsHdk7wUL9wiIOqObuvsfFVSuvxf2VSLCehAg/yCk53r7uWIHNEedy37kttlacxid76lOj9NwrL3ScvSi5Pi5XJJvfRUWzVZk/F4gjm/J9XLaol3OJkFFZTQKTBOYvN9qQhegv/mI0Wwb3wDuLd0pqJ8hqCmn9pDwuQhIfUWN9U/w5rIlseznREVFdzbXWdzEiLt/mhHIdFOrngwxyzGJq4OLaoac5Oxpu9jmbfjUfXhemkTp/fTk/5FPN1olcKBwCqWEuIKi8y1Faabu4VlyawGH7jB80LFKCXonkf9Lh1fA1VoeTjeFO01q+N/tN+kauYQZnNMNaex5YcoNAlkkCRX4VY+UNQnRHRf0rieQjlGunu6vZb4C6f5fL+zWiizm0B+6OFyShuUlwwescVFH2MeXg5cPDZmCzlprpTCzZrF6gP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:10:50.4796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e36c6ab-13e6-4734-a512-08dec60f620f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
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

The tpm-rng driver calls tpm_get_random() without first ensuring the
TPM device is opened and started. When systemd-boot or fdt_fixup_kaslr
triggers an RNG read early in boot, the TPM2 device hasn't been
initialized yet, causing the command to fail:

  tpm-rng tpm-rng: dm_rng_read failed: -1

Fix this by calling tpm_auto_start() on the parent TPM device before
tpm_get_random(). This ensures the TPM is initialized before use.

Fixes: e67ffb5aa5ab ("tpm: rng: Add driver model interface for TPM RNG device")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/rng/tpm_rng.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/rng/tpm_rng.c b/drivers/rng/tpm_rng.c
index 1a5e9e2e4b4..374e0ac1ff8 100644
--- a/drivers/rng/tpm_rng.c
+++ b/drivers/rng/tpm_rng.c
@@ -4,12 +4,20 @@
  */
 
 #include <dm.h>
+#include <log.h>
 #include <rng.h>
 #include <tpm_api.h>
 
 static int rng_tpm_random_read(struct udevice *dev, void *data, size_t count)
 {
-	return tpm_get_random(dev_get_parent(dev), data, count);
+	struct udevice *tpm_dev = dev_get_parent(dev);
+	u32 rc;
+
+	rc = tpm_auto_start(tpm_dev);
+	if (rc)
+		return log_msg_ret("start", -EIO);
+
+	return tpm_get_random(tpm_dev, data, count);
 }
 
 static const struct dm_rng_ops tpm_rng_ops = {
-- 
2.34.1

