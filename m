Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E54CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 05:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACEEB836AC;
	Fri, 15 May 2026 07:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SqEknw2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C47838BB; Fri, 15 May 2026 07:43:41 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3198D8341A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhGAzuPKJ2C+za7pxRxk7LbNRXU5s01OEl2aDFzN7a6IR4z7J+jl3xrEFdu3U+fSJxuf4bS/9OMf+Xox42+KrPCex3x3MLCUnrtYvovb4uR4Y0a1qqmQXh3RVw9v09kzzsk4BoOLEU3YKs7ZpKcQu3jED+7hBdBV1UpClZfuP4y0gSrpLnd+mo+78BxfBhhMLhSnkPeMkxAn5/F4SBgATlgQMolJfno+lp8uC5ZSzod3u7Ru9WAsRFKGYbQdQSR/1HeyQe0nQJ/va8T4iAEfLRpjsLY8gaz0Jmk/8B37K/BzWQfMmr8EADC384Zmguys8/5OXs0eccAeMn0Q/ikPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5TF934jhdggwpprGFSm4SOaEImwRE8wdJKV2kW2i04=;
 b=WOEUZYMHB35b0clQK4woryz5kQWwk+4EEpRrwczJ7PPkGhz+MvtN9BHrKAREHIMVU3ciY2h4hVzSgmGelO7YZBd0il4Oki18PWqHxeMKlYhVmjJtmucpgsvJMbV3Ecs54It700aXoslnc6++VTIhUpf2U3yKkmkW+bYQbRXsYo8sztsk4YNrGtxLUIhb6XPgJZpy7rAp7CiwScqMKgHwocWwUzFcd28sKyBjeWC0LzIgtdfr1uar0rcAn9VQS/iWkDJIZAjEP4nf4fCpr7/3Qg+ezWPNeamzu3DKwxFx2uSQJ044UddF7L5Nwpg+M//EzatU8SAEyBN8FwTxH+h26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5TF934jhdggwpprGFSm4SOaEImwRE8wdJKV2kW2i04=;
 b=SqEknw2LOP00FGcK9vXdjr3VD7o80R2MyDoVXJfbFSTC9dMuwqG+LzMEUTUD7QuCT904lEJVnTP5Rx+IKAEDhuWOJNhKtGxsOenQM5EtFug8eUvcVRYhoR74zQzYDb0RR3i2SnlXCrmMiogzWZ9BwsFtHxQWKeiDPp3SoEf4f9A8Ie5cYDmAq70USt6sizO2Y/VVr7yCypbV5fNDFY1s1KNiRIxL6xRaqRKPwwwLKAqG3fIlUk966nDM+nI0eVBGKWuoDBNXtFPoGZxx88w6vpyRWe44F0eD4sw/6I97QSOjLWxph2FPpN8Viu9gn32APKJv0N5vJ8X+PhHOE1Kijw==
Received: from AS9P194CA0011.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::16)
 by DB9P195MB2105.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 05:43:36 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:20b:46d:cafe::b3) by AS9P194CA0011.outlook.office365.com
 (2603:10a6:20b:46d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.13 via Frontend Transport; Fri,
 15 May 2026 05:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Fri, 15 May 2026 05:43:35 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 07:43:34 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <sughosh.ganu@arm.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH] Makefile: binman: Search board directory before srctree
Date: Fri, 15 May 2026 07:43:27 +0200
Message-ID: <20260515054327.1033466-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|DB9P195MB2105:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a416eb2-94a4-4f71-28d9-08deb244e7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 9y7j1RJlNBAXa7QDK2GQ7gs9eeXLvqMWmiIRZEvebwuGDphNHli2oDyobXz0tHqJ6xgsXmWGccAE6xYtoE8BvsIjA0I3uhpJZt/Mmu2FCFcIFHqmXfglAKyxhotUTtpf1rYC1sUBL1HV8MpOAbuMena14RT2FGksbu6golb44Gvp9iPStszb4+VeYEL+yvBlir5jbILNMDIyFhh/x86CS6iPmJ9f68zJrR2R2W09tTK0pmD4xBv5YLqZW8LVJ0OMpJBDYHTuNpEZxLB52q+rDSdpm8MWt05I6zaOZuKELr7fh0FGPThgQfkwzNDZeICoI16BRY7Lpwx2L51TLvBqruf7EzfL9N/M1eZlAE5PcQXI5lBs9wa1lMpYB6Y9b68VA9yYtCaBUtLAdX/oKbrPCBzdXRS63xGM/wkPRHjO47PFEc4rGDeGOvU/cRtMG9o/SOlzG0RJy83y2cPWf1SutvGhZHae44DvRdObaA7+ZVo0jKsNNqfKBN2aq12fnAmVuGE2c53CL+mO6t8/5OFhjNeTdf16lQY3vKdE+Lac6LgKujDCVJ673G3DbpM/BwUuktTCMwridvA9EKK4KZt0xU8OdszP93Y1PRHkWiVcQRfNiiCY0IMMWtSQ6w8XXzhS+QREH9Ksgksu/MEaD1NplAnfVkaOJ4tHRmj33XtGDkIaraTPmX7j2Gh2gwL8J4dYcvz5DQkbn+vcrU07NhJgqOhRitzjWWxkelKTFbLsaRM=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rsOpRsEm7h8l8bdm8XxvPLdCyyJXiJHP5juZTLWaJ7/lbNOLdwv8hvpXUUVpfxEWB1r3WK7yyN1LD7xfNt682bkEASZ7TK8SyqG6HU2KClfzj/oNkEgvFhCMFHgY1vtiKulWNNg2G5jZSBRuoyrjP7KAKI7eZm3jFhdNb5vBnhrVeJwmrjh2TLZgnp3TrsI8UmeLUi4LOog4zRXldjvowcwyaMKJqxK4oJ5+a0nKs88oUhl9RC+HD7uHkX3gnwdjpaXSBio8rOpur1x+SDuAZxYYP21dwjJe3pBNYO9ouTgLmPHnClErGY1dJUvZOHwbA+YxJqVyhj/YrCMr9jHMDpex8PwWGJ1i+UwwaswCMGp/dZtvD7429Ppr88O2feqav6PuZznSAC4fvzc0J9b/Ss2+KeZTkStVFRthKtZ7tdkNC3vqtS60iTWBeG0LPdNF
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:43:35.1053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a416eb2-94a4-4f71-28d9-08deb244e7e9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2105
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

A file like rm-cfg.yaml accidentally left in the source tree root
shadows the board-specific copy. binman builds the wrong YAML, the
resulting rm-cfg.bin may match a different SoC, and we end up with
the following error:

  k3_system_controller sysctrler: k3_sysctrler_start:
      Boot Notification response failed. ret = -110

Move the board directory ahead of the srctree root so that the
most-specific match wins.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 552328f9f2c..1ec29dfe0be 100644
--- a/Makefile
+++ b/Makefile
@@ -1682,7 +1682,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		build -u -d $(binman_dtb) -O . -m \
 		--allow-missing --fake-ext-blobs \
 		$(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
-		-I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
+		-I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
 		$(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
 		$(foreach f,$(BINMAN_INDIRS),-I $(f)) \
 		-a atf-bl1-path=${BL1} \
-- 
2.48.1

