Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17535F94CB0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75879842C7;
	Tue, 21 Apr 2026 23:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="OyjJQr5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58F3842FC; Tue, 21 Apr 2026 23:10:09 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500DD841C8
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkiVmybqaVscZoGkCeMiv1nszp1xLAWcdwCS5STbxOrbm+rcKi3YZRSaTYb4l2XSavweOJcHvJXO47N+DvYPTsu1BCO1gmhUa3yjhjtfHmaUr+YcHZ7AMRx23Yl4WJ6S3bTZngc2TdIAleQqjMCYSlX4CWGkGKJymWdJbHuqBYm9E5E0dyU7JJm/Nlj4Yzb4adhl9cxrNJ1dM5JBtuGH6X0sFmzX0QLQb8PTn+eX+VeyLtEzNsosU/ti1LnJUqeEV/BSpWjUaro8NAxIRUcdU5QeQJar6gw1vleJ0GTScXMagpgbsI7omWvSfHhTLyqPvkbnAyOnxLB+vL9/m1q+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEvJKlhd3A7Ocy2rWdwOvOo23kqK/5mRZ8D01WC6NC4=;
 b=fV4/M+mXUB97XkdVLsMJpcBUKgFFyFm4Fvt9n4Hwenc8nr3Zev5+Q77TMfheevBWZVZRQhjciITUwXoi8kp2Y4E3K3IlIbPZICBEQtW3mt96i1owoB/sbLBbL62Nj64e6cy6K0FVHnoJ2lsmFBOtuUi7zoKJM2YPOWJmBn3EiCVJmjD33FaYzbWCcRo6fA1z4r4zAqAZu3v2mdlUPRwH3vbqpanR6KUJ+CjrJ/RV7kuhV84yHQWInNumHl+AUDHJcNeiMsyPcb3mxQLit0L97cTgFkWW3SqyJ2hFtdEBoVOoJFYt/esSRJNOkJ6qThfjSeUbcqgBQUMzy78cOv637A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEvJKlhd3A7Ocy2rWdwOvOo23kqK/5mRZ8D01WC6NC4=;
 b=OyjJQr5GnHTXxE4crTlhSdVIzoDScwiRdUkmJLhTKx+tJI+UcOiPCSQPYaHsIPHF1BMknFGRHHYbmy9KhfCPOrJFrTotRt3JuNPYeK6gjE/yAxGUX2z9DqX2k5dOwYIi1Yf2PkErNdDEu9wDFVFHuyEqncZQixV9gSEnzr8bo66C4nkbCf0H7RhbYtWTeZZ8CBuieazsso6VjTF+edwiMzY8A88JI8UomwsBWJ4wHBGlwYemOqWN6my7eM5GaKQlhoPqwfuE9GRF8T9nLfCNxpHSeu/z1uiAMA/2Nrun0kylw+DrFaajod6isMc7sU2qFUm+9uXGs9vliyMvlsWDCw==
Received: from PA7P264CA0490.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3dc::9)
 by MR0P264MB5439.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 21:09:57 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc:cafe::8d) by PA7P264CA0490.outlook.office365.com
 (2603:10a6:102:3dc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 21:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Tue, 21 Apr 2026 21:09:57 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id A2BFF202C3;
 Tue, 21 Apr 2026 23:09:57 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 09/15] tools: fit_image_setup_sig: set required_keynode to
 -1
Date: Tue, 21 Apr 2026 23:09:48 +0200
Message-ID: <20260421210954.1170437-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421210954.1170437-1-philippe.reynes@softathome.com>
References: <20260421210954.1170437-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|MR0P264MB5439:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d86e8bb2-0a03-4797-3530-08de9fea57dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: svyOdflR8AJuAka6kyek0VeGaBKA654DQI1FKzemBc0tvDWJAGkA3cJrb3Gx4PGJbWKeSP1z6EIOg3Vgu47831mzEGsD0uMJTPFEdfHlA63E0b59b1Gzni2VO5pBshSVMFeSe2dvkbi/HrepQen/ID0EWDGYgKCOUvo4wC6NWIm24JqFMx+l5kQX65tYHr9MgCzE1/V0WAwFsKXytcHWtlVlMplDW+gxmO6Y7dJTccRpPK32hlrLLp8NnqpbsBKtZnBswIhoFL+8S3l15OhAjDnBoBazLeAiX1ONLC3IpVQ1MtGHJpXPEWGXhUrzxYcC+2GxFpF/4zgxWS8ibXQ1YgJ/08wkV1MFBrtzcRldeEgci2FZrImZsq34k2sQ57AJVpDopamfINgcjhw9r2YYXQ1b37phw6JSGvtHQnW+RKQtLYveNUmgwa50+Duk1n0E1qCAc4T6XX8mqPpl3GjeN+QwerjpvW1HmiaQZFOEcUvMgCwG8qRhJ2dKji02acVsAZDFWLX3xSl4NzTXT0D0QLOB/k+8giuegKge/UrdRuxS5OsqSZTgWCDLrqFz8t3Xz9gEuzSCWF4/3tnZeIj4eggDE+a5Qul5wfok8FSsZtofT7D9lxLmsS0yEr00qTdUI/2dNskLDk8Alg4KHX7VW/RJz6KWC/2JDT3aWK185ws2ROc0W6Dbz6hxQNNKIh8ABf717Av4cKFA++23xGqqw/YtX2O7pEAzD8s5jthxovbs0jQHQad+UN+k8bvOglmjBZJozyAdORpdg1erzZeBLg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J6KL9KzgWv2e0GzmAcry/Q1QgTHXd0qQjIKujxlbOm84Gy/rzj9vtXTyecCpGi4jlzEs6xf85s++NKCW7G7Dp87WlOFSyJCuoCEg2x255u/2LXYRpGkEJLnTawemM3EGVONzMPxZrDlqG+2iAKknqhT7G052Vz/LH9A1U/PgOPGtNPKACFJ3iHmzneSIct/As7nevFWJq+0g3nqN0e5nPVeZKUXjuMRymtsXChxFI6cP38cgoBtcTonCvV+0FE0vhGc/HfabtFOQrRhfEoqyzLaZnmaCv+8VAbEfvIrp7+f78BhZBOzgFsO2dXQgKDMr4s6gIYi4EydY6lWU8cjdOrH/F4ridILstC9dapHleqKd7Q+PKxK3u2qksw0wURx/cvD/7qlQPxAvUY2r2O5uyZba3pFvpaMZ7UsZ55zXff2mSv4QibYv7BFWIo81PNOm
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:09:57.7943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86e8bb2-0a03-4797-3530-08de9fea57dc
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5439
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

When initializing info about a signature, set required_keynode
to -1 instead of 0, as 0 is a valid keynode offset.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v5:
- initial version

 tools/image-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/image-host.c b/tools/image-host.c
index 8b550af0dc1..f5681d6c1f9 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -198,6 +198,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	info->checksum = image_get_checksum_algo(algo_name);
 	info->crypto = image_get_crypto_algo(algo_name);
 	info->padding = image_get_padding_algo(padding_name);
+	info->required_keynode = -1;
 	info->require_keys = require_keys;
 	info->engine_id = engine_id;
 	if (!info->checksum || !info->crypto) {
-- 
2.43.0

