Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AFBC25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 03:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBD1884D5;
	Thu, 23 May 2024 05:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.b="UhUUdCgg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7328B884C9; Thu, 23 May 2024 05:18:12 +0200 (CEST)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2011::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 375C388517
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 05:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=wiwynn.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Delphine_CC_Chiu@wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaJ+JhirH6urzuBoms5YY80ke0qXCsypXXfmW5ZOqo15eiR/Aio1JCj3Fq3PKHhPl0i//BvrJqJBeLL+y5n+WSrFt83m4jSxai7i8OX1Tpq2Sjg8pyvwaQDQBgaaMrG59orJGi+gu4nx6FCx+XuKi9Qwfz9L+0knRFHa9YqWd/TdDkXUjk87smvH9xhJYsCrsrdxDx7t/kWoGslJZ3lIW19KDxLZUBiMWwZEiTCz7op+MEp8OYqv60Eiu6WZPECAoUGzs2+3dlkDmIQNgXmGAj1zVI/qmiOJJ4T+G00bTq4jgpNGDSpWndmO31lUNuoisk6fBQw002NeAX697rjMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yoJWYw8/7subCk9XWLvtJY7W0Yf3CJ2RphDn5rcvnE=;
 b=bpFE7x5Ec15kYd6dyatNoCB10IkXgmY96lI9ZUizcCMbZrJ/0jPkN68TRe+oc/vf7Q4XYEJy8/yMtXHTTS/ht6NOcgfks0ImCl/qKPV1kXVMzJU+c7UAlBpFRptb6I0eTx+cF0++LBLIfVrciV6ts+zwWdAcv3sQlY1zYbUKXXjFJPi+LQGbBWoSyVhcN0K7a2tp3Ba3wsponcLsbviuYZQNl6qlivYoTi2n2LixjMk/i4IMTHleLm99iJtZ+/zGHtplZD53O+ohwLLoytPs341fUJtJha0z+I5CARLBXoBoh6HM4h5g8o+xQmDOteTSyb/5CABdyGW8BQeGe7pL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yoJWYw8/7subCk9XWLvtJY7W0Yf3CJ2RphDn5rcvnE=;
 b=UhUUdCggWIVDg7r2Gr6smvQTGjTFqJxMRjXIrLeunq1NCHKFvi93qWxd/QxCtFD007bhNLDXjhK5Z5yjsJuffPaj5WuqaM5SCEeQQxHtbrS8R58xefTzI+3RZhzXIUY4mJLikypZk5WuQARfv2OJdeqfU02NPmwDqlXGYE7vkgFK+S3DAgH3ibDiyA73tuKlGOK3IO0hMshXa4VO9FnHJiNtpSOeG/HWyPvdoEO7kdmxATp+Th8rpKt3oDUMUDXucsPiFjrRftd+hbTt08FxZCG5AzShZULR2LMDWWxofvfQ8BjIVZHqCzjhpE8+gshNCDtaxwuK6PGXHgrSisxogg==
Received: from PS2PR04CA0022.apcprd04.prod.outlook.com (2603:1096:300:55::34)
 by TY0PR04MB5887.apcprd04.prod.outlook.com (2603:1096:400:214::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 03:18:04 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:55:cafe::f4) by PS2PR04CA0022.outlook.office365.com
 (2603:1096:300:55::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 03:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 03:18:03
 +0000
From: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 u-boot@lists.denx.de
Subject: [PATCH v1] ARM: dts: Revise the default baudrate
Date: Thu, 23 May 2024 11:18:00 +0800
Message-Id: <20240523031801.1061485-1-delphine_cc_chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TY0PR04MB5887:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 625b89ee-5dc4-40a4-c45a-08dc7ad6f504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8adcB+0DdDufprTDCOYVgICYbrJJLBODqp5t9hxVgoWeDTtiySn5w7BwwUIZ?=
 =?us-ascii?Q?6iwOoEIcMM3lTvwoY1RIeZTSngXy45s/xBzgHFwkFg+WLzHmDK3RDWf4/2wa?=
 =?us-ascii?Q?MxLxKDU8ipm0VpMLCND33pxesVbJIR40CtTTWIGKPycul7xAAiV8bAj25aKa?=
 =?us-ascii?Q?rPAGv9F6jGLTt11XlW6XQHHu8XLIerdjyuPeL8g0q1LeoFAuSnSDk4+TJW2V?=
 =?us-ascii?Q?+M/rBgShHQ05I1H3XtQmR00j14BSaKy4c1WRb5ozSrqkphy8dcR1i6lmysrJ?=
 =?us-ascii?Q?1oJh44HF6Fw0+btEZT+8rtYVSvDXzlPhy24CNtvXRw9Xb861M3Rax3miBh4Z?=
 =?us-ascii?Q?Ub7k5xZXJNSGEAWns+I+pv2yTumFp5RCmK164BftYJFeppa9bgwOnddSO00A?=
 =?us-ascii?Q?r57gdI6EOO/SD8BRUaA8QUdPeaOf0SkK1Kl/1Emj7V/4cSvWBpvw1Q40CtZ6?=
 =?us-ascii?Q?P+fP1ZKIG1VI0js3Df/uVRloYwOrhydE1AuTpxRV5I+9DY9PH2qzOP1rBRXJ?=
 =?us-ascii?Q?yqzVDCocE316O/goKAUT1Q+JyCFBB2Vzuq3NxYBbNuho3sbXNX6pFXntVuCH?=
 =?us-ascii?Q?Z+Rc6cGmxaST2yVqYMGnZqN7iPdsDxTt6n9G5xCBUnd99iRsH5DUirrtG21I?=
 =?us-ascii?Q?3gq+Pk7L5C6zQx7zzzrZINAp/z+RY2d5LumY8HHCTg4zNOCK+pTlVCQp288r?=
 =?us-ascii?Q?cprJONo+V/6lsQs31KnOUYXowBCp/fKeyB9Obn25fpURUWefBP9Y9e/RW4Q1?=
 =?us-ascii?Q?9dNC5BaY1OuqU/gN4X5TkEOoLmt9y2J2ls0HsyOycsl/yjDzdva41BHgTqwm?=
 =?us-ascii?Q?qeFXt04vNKHbOU3U8YK4TN+BSlH9jXAZZKn6b8psyY24q0mpOOY0BcTEamZA?=
 =?us-ascii?Q?OO7koT0Bdm0yQH4A6bH7MN5//hLkK1liaT2jZz9Sb2lxttpeA5mKibPMFXjw?=
 =?us-ascii?Q?ByotSr9kW1wqjFIpGroGuC1ULG1yYNNYzP7EI1U/IqjVGMGDio0tsFvPTbGf?=
 =?us-ascii?Q?ReU2yndk79YY1c8DSzXLwRmeLNvaCvLZ54+gCJz0pxw1+CUCE3I6Y3J83H4h?=
 =?us-ascii?Q?QE1ZkB5uviLtqWExvJuBprjf2WyTfZGy6m1dGgjLospZIadY3WHkESVzBj5u?=
 =?us-ascii?Q?htpjezbKXrEjCTgFN7rn27snsTrrkS7Pck4cBkOROoQGcmJVmCcyOOg/w8RW?=
 =?us-ascii?Q?VZEfeuI+YureestVSaBQNXc5Bx1dW927v9fpUj2jqkkLZXmMndMwYUDG4FzN?=
 =?us-ascii?Q?5rvURunTpZ72hjSQb8YRFdREes1qAGxuenEezYKBxCYbsvx9n0mC1KC9Rn2D?=
 =?us-ascii?Q?HVJJVWQUFUAn/FF5YND3f0PiyjTR0D+ddvSrzQ4WMUchv5dm7SZHT+0d6ixy?=
 =?us-ascii?Q?BTJJd4KNhw6FycKEfwp733woq1hp?=
X-Forefront-Antispam-Report: CIP:211.20.1.79; CTRY:TW; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:211-20-1-79.hinet-ip.hinet.net;
 CAT:NONE; SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 03:18:03.0994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625b89ee-5dc4-40a4-c45a-08dc7ad6f504
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167; Ip=[211.20.1.79];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5887
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

Revise the default baudrate to 57600

Signed-off-by: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
---
 configs/ast2600_openbmc_spl_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/ast2600_openbmc_spl_defconfig b/configs/ast2600_openbmc_spl_defconfig
index efd683570f..5e95780a9a 100644
--- a/configs/ast2600_openbmc_spl_defconfig
+++ b/configs/ast2600_openbmc_spl_defconfig
@@ -28,7 +28,8 @@ CONFIG_FIT_SIGNATURE=y
 CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_USE_BOOTARGS=y
-CONFIG_BOOTARGS="console=ttyS4,115200n8 root=/dev/ram rw"
+CONFIG_BOOTARGS="console=ttyS4,57600n8 root=/dev/ram rw"
+CONFIG_BAUDRATE=57600
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run bootspi"
 CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
-- 
2.25.1

