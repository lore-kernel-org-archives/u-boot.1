Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1A5C5DF77
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9371A607BD;
	Mon, 17 Aug 2026 15:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yqL8b8pZxwUx; Mon, 17 Aug 2026 15:41:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 092936072A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981276;
	bh=McFqC0v+r09VQgApQjbjkkzRdU0dYmtMaRQb/l63lRU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YAiIDGmsr7tvZ2Ypzo60Cv3bwAWhAQ2G4Oji/RXVDx9L/ZLPfockEF5tfQaWv/XTg
	 ZclyV7dS553oqGGzNiedE4LuYEDdGHZDNlrhNjh99bEAOBaRr/4F7YOkJP8me4HIid
	 VtqaIhgzpX9fFhI8Fv122zzG43JbE7MXEDwJ69X4p/jKYwBc6PGFVRxWDGeA/3MdNw
	 C+kiEW/kc1r75NluNMJEKT9vVkDBHV15jQ1vp4SrdzYwMA0ru3869BvOqnoeUd/lR1
	 1MRzWI5eg78B8kFrHTsET8nZRpft0WtPAhVoDmYu38Md1RM92Jz4P/gcDNwumIWxla
	 mHMefLiIPqRHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 092936072A;
	Mon, 17 Aug 2026 15:41:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 46BEC333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CEC3401C7
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7MspZq2-g8pN for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:41:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6291040105
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6291040105
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=eBVLBTYm
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6291040105
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxAJyawxJ6thTR1gxb0FT/ZTtRe7eXs7dZalmxhRn9tj1a0e/K44BMk016gonMuCIumz3eT2XjSomWwT227QNTse56Bfslj4MWl+buYRt+NsASQ0PLzEdyf3PrdQ33X1mQx2yLqpFsXl6aSBg1QgLdrIOY7TVKRXUFaQMbD/F45CqfwFkdjWxJH8WYJeaXuVC0BCqEP0NeZTl1cJelnJqMFbY71XktKcJJ1GcvmyTwhSkkvI16HVgf3FSkphUTta+vB/aViXCYYfdEBElT1NGX8QHxtwZis1IH788OS97uyp+BiAFLjpI65GvznxIF6TIaDk/4qu3QepyT2MOfvmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McFqC0v+r09VQgApQjbjkkzRdU0dYmtMaRQb/l63lRU=;
 b=fhP0i7Zz7fYRPHbW1brTWFpRVFPFid3TcWKAuWqNuAUW3Zjww7a60j6LiSW0qmoQnJaLzT6MTYJfnGuMt+Y2Ee2OlECUuIxnB55DAUp9tA6ZL70HxKv38n4kOuHEwFsFK7gljupnbghwnxhesJXiQiwqiVw/5+spMUqA5duyI7CP5AlR3l3OcoPnR6LGx0j3k3xVTwtZWTBjq3s7OZZl+dp9rpUtwHTWRml+BXHV4WPk6wOfGkAeihtrHCSpwMWsCke9Vi6LlKrSXKIzTjMt7D2GP67Z6Hx8Rl89nIhy0g2wLo8qSFxK6XTy/lqzEwHAzDt5k6AbETT/8+N1b1gKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=denx.de smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McFqC0v+r09VQgApQjbjkkzRdU0dYmtMaRQb/l63lRU=;
 b=eBVLBTYmMUJMZnbzXuOPMSfPgtNDzyPtAoZK35pK/e/P69ytNDUT/HiljgR5kP0MiVtnnEYFgeeGtujODmrWIPipXyt0rzhgXE7WiwHxUzJFMyN9RWLxYxdkLAZ0xUyld72TXucP9UAyP8W/iviuJi7IQsV/hmYl5ga/PinkEQgV6awwPFOk8h5Rm6+OW7iEja5sQ0tleojEIXq48uBpExL5YpL+kT/KiUwE/JDw4NCvIdbah1ksdyy44w1T+OvWV8S9JyvpnKICMoVB+AZO7kISVwORtDw0Qqw+r5WJ2FH4JUtDC+ImzfqMnXyoMlsaBVsM3ueqf9ppGUZfJxJInA==
Received: from DU7P250CA0009.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::13)
 by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:41:08 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::6b) by DU7P250CA0009.outlook.office365.com
 (2603:10a6:10:54f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 15:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 15:41:08 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 17 Aug
 2026 17:46:05 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 17 Aug
 2026 17:41:07 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 17 Aug 2026 17:41:05 +0200
Subject: [PATCH 2/2] usb: gadget: f_mass_storage: Optimize schedule() call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-move_schedule_inside_sleep_thread-v1-2-0023194e8c47@foss.st.com>
References: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
In-Reply-To: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
To: <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, "Tom
 Rini" <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|DB9PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cde0e8b-fd1e-48ee-61af-08defc75f4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f/pRrd5d03B1cam1SxOGekZ/nmZKVcVUjseNYooPE6c7pp+H0d6ive2dUk1MQHC64ce8lZPxYCUYIr+0xR33GJ/3s4kWpEyJwxq9yqYYnD41+CLTDbb36noANu8YrK1GnruPuLbx1MelOsgb0MXRoDKic6ODZJc/T4iTei+ErIqzAZLedv6VCqlVQWMSIkJCbjAq6Z0P0HijOgZOIORSJGMgoYS3OT/w7FYweMGQSgOHu/FzkT55Yy5N5Dp9JDq1regLoyCw3Dp10XDUMoI5pnjDZeFn9TyDtvCuWBjTAXbDDEhc43/P98khXVQJcjN93hCZXrVXSEFlVO/pLMLueu4FI2zmiefMRVHd5WRYXUuC5gTwkzA73M8Ox0Z9yKuGjvbLZVE5jFef3pGV2l81yl4OVOoUtC5d87iZwtHFLcXN6f5v1bBvEa0R/vg8D7H+tkgggM3OyWzz9zgXqz42ceoFYU0UlPNShbWFfsfrngCDCp+Qma6WeZOhS8P8SDz0nIWQSLwr3HsHpAs+GuuRUpxvisspeRsHWgkmT1HQytL3GZX5q7+LW47HN1GIOeC7Z6W7XUXv57xytfSY+oMJDZtl3RE4VqsErFVzBbZdufAG3SjWt6tDDR5HLKzNkwpxlIyJ7WpWmmjmu0qDaS7h/uD/5f+OHIb/unTUgX+AlvJjyEt/php5YQYjiarhc0BC6iOCeMbpaMlOM1UvLxolyQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XwguUtOCqbPOe16ptKGGCqpWofxUGng+Bg9mtTv0a31XA4QnG8MqrLaaO9W72nSpo55jY3fe4G26Y0OglNoV0UeFwQCinxUTyHhIxc3nG8Z4c/7LuRlPdhUYMP4HfCvNNw+FTJKINugCMo6yZSZVMScqGHZh7alM7GppvAnCE8bBBB3K0bkbwLr7e6bo1YrVGy99CJFDax8WupqxHnzNd4i8yVs3vvWqpRoetH2PQ+U3YcQPb5XfXb5ubWBaJ1eTUl7ie1IKDQTrGsyE/K/LlYG1I4BmXNcjm7UKmxKt9/g+rZWwRYX9OFUzJWmp3tjCjWSOuwneq2pUhCc1FPG0/8rrO3g/DyfwlQKmNioc5onZHxRaXvqh1LtuiFc8p4A62CQU9ncZgVsX8MQLcyMlqyLz7wBQwlkTUYgOZpH/Lg/wlhRWrkyYp3lFCZqMoyBJ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:41:08.1762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cde0e8b-fd1e-48ee-61af-08defc75f4e0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5211
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

schedule was added in sleep_thread() by commit 4b6a3e860878
("usb: gadget: f_mass_storage: Add schedule() in sleep_thread()").
to ensure that watchdog is still reset periodically even on platform
that doesn't implement g_dnl_board_usb_cable_connected() and in case USB
cable is not connected.

Instead of calling schedule() for each for() loop iteration, call
schedule() only in case g_dnl_board_usb_cable_connected() is not
overloaded, in this particular case, g_dnl_board_usb_cable_connected()'s
return value is -EOPNOTSUPP.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/usb/gadget/f_mass_storage.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 621852080e2..f467693d2cb 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -651,6 +651,7 @@ static void busy_indicator(void)
 static int sleep_thread(struct fsg_common *common)
 {
 	int i = 0, k = 0;
+	int ret;
 
 	/* Wait until a signal arrives or we are woken up */
 	for (;;) {
@@ -673,13 +674,15 @@ static int sleep_thread(struct fsg_common *common)
 				return -EPIPE;
 
 			/* Check cable connection */
-			if (!g_dnl_board_usb_cable_connected())
+			ret = g_dnl_board_usb_cable_connected();
+			if (!ret)
 				return -EIO;
+			if (ret == -EOPNOTSUPP)
+				schedule();
 
 			k = 0;
 		}
 
-		schedule();
 		dm_usb_gadget_handle_interrupts(udcdev);
 	}
 	common->thread_wakeup_needed = 0;

-- 
2.43.0

