Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D430606A32E
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ItLW8OA7;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=WjmqhqwH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 075D440A7B;
	Thu, 12 Nov 2026 08:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YqP2Y8gnJPg4; Thu, 12 Nov 2026 08:27:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2714B40A58
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794472021;
	b=pi9DUdvC2LypVwSR7+QesP2UmNor/60ZB0ledKQdF0QXTjGjAwNK1ZCoF2Pz8r2X6tfr
	 QCHUFxHdE27AXbaXg4I9kZ5WI8rUwc5dw7u5iNGSPYBzIkAyfjEBkzeCnXslc1OF3sfQB
	 DeHR62+x2/2+I60GXVMcqkqrYpit1Dujz9UB2HZZ/Cg1QnBBne3ux7YyR/W/ezvQ7+I71
	 jQ7xs0kttHJmuPKBpFcGxJzB5F8p6UmPdf5CfiGXQtUcauZl3z2pNVWyDRWcOqR18O19t
	 ajF/3vnkvgSiNzihQBwgD4h2rCyQj4vyBodioCXP8P95BVB6B0spg/iVsu/OPmivGIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wT6AbrgudaHxlx1x7Bgh/zFww7egoC28Qmb+xbkd7WM=;
	b=M9FVa4TddBnenfPkrigNNUWy+UQcNJROwe1Ns12t0GihuvTuitK4NSvajlnBIoNSPlqO
	 i/2oNA3Z4O7TbV5FPLmqjKmRKGNE//85HWAo/zzQR/ITo4kyLe+Pz8uYd0bqTuReq6R1j
	 VfMRw3u1rTpJhS57lJpBn0dtYAFSFR3cVXJqHhdVT0QRDjwutoo43yFuSL7OB23YPC496
	 9v/Lz8F1lD8Ervs5PTzLUEmaPrNYvpttzwuhNKAfqsaX6CyNvW43fXBmCLux2DmJJLHUw
	 XtoKXBWaeJGkEjEbrw9hHTiHIrl6cT/hnTEedQHShJXg5sj1X5b7Zz/2pb84NLuxXjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=WjmqhqwH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794472021;
	bh=wT6AbrgudaHxlx1x7Bgh/zFww7egoC28Qmb+xbkd7WM=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ItLW8OA7NLk0wPsBivWWPEGP8dlBgs1b0soU4MQpUjynco4q5fPjK5S335TiJ/i0Q
	 t4sXMYks15wrXmnCAufW6l/apoFtQnwI/m/Fgz8Y94lrE8itmqny4d78yyYQeebQvG
	 J5s4YxVvlzsUYSpS4Iv8Ic2A614y1ll4eKj4IczDxftU5d3fM2kV6ZavbBkxmU9bLX
	 JBRkSNMu+rDakA3DRrm75fKaFuqEp/yCGwtWP8dDcx07RKJQpZtDhm22aGGdz4iQCX
	 YKmMVukf38MPhkG2vvhKjIbQAwFIXv+829euN4fnuE0+3wT1AOZ3VwOnEpaCccI7Mu
	 YJmK76dvTd7gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2714B40A58;
	Thu, 12 Nov 2026 08:27:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CA4B2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32C3640A58
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:27:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GYP5JgjvqasQ for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 08:26:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 68F8D40A52
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=WjmqhqwH
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 68F8D40A52
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wT6AbrgudaHxlx1x7Bgh/zFww7egoC28Qmb+xbkd7WM=;
 b=WjmqhqwHrRgBW3xrQZazQHO/Cw+Jiu2aHMaKhScoyvpWXV/7Vdf7KNKffQNvBnWznzpALFG2UHA3PEhtKY9P03NbcNgOaAdjYI+mCGIIwmfeV1eME+GxSzTtNMCL+BZuEqnS8AKG2eKAOvzHVWVXXAL/kgf2k957eT8hAzRV974aVVCq1vefFNceynS54V5cFQCUyIckdCkAdHRv3m6M5WU8G4Hia63VzJ09DeRDbUSALotaf3Y4+3tkO1sjd+at7JpvMddCGOZBcsgm5niRWkgVfGwsKY0gG8w4WNpX1AA+Eu0cMPGTpIPWOPpLk774rxpHpa1z+d8Szy77jG+2Fg==
Received: from LO4P123CA0218.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a6::7)
 by GVUPR10MB9677.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:360::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 08:26:52 +0000
Received: from MI3PEPF0000848C.eurprd02.prod.outlook.com
 (2603:10a6:600:1a6:cafe::67) by LO4P123CA0218.outlook.office365.com
 (2603:10a6:600:1a6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 12 Nov 2026 08:26:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000848C.mail.protection.outlook.com (10.167.240.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:26:52 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:27:48 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 09:26:50 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 0/3] mmc: mmc_set_part_conf() fixes
Date: Thu, 12 Nov 2026 09:26:47 +0100
Message-ID: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEd49WoC/4WNUQqDMBBEryL73UgSVEq/eo8issZNTUEj2Rhax
 Ls32gP08zHzZjZgCo4YbsUGgZJj5+cM+lKAGXF+knBDZtBSN0rJWqwLx0A4dQuGaPxsO+vexKK
 SipRtiOoBIdtLoDPI8qP9Ma/9i0w85o7G6Dj68Dmvkzp6/1+SElI02A+orxWisXfrmUuOpfETt
 Pu+fwG36edq0gAAAA==
X-Change-ID: 20261105-upstream_partconf_fixes-401e1f6ee5da
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Torsten Rupp
 <torsten.rupp@8tronix.de>, Eric Chung <eric.chung@riscstar.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848C:EE_|GVUPR10MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 76089239-270e-472f-47d2-08df4096b419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|11063799006|56012099006|18002099003|10067099003|261009223027099003|261102130727099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|3023799007|261026121527099003;
X-Microsoft-Antispam-Message-Info: 26bfCT+fNAxMe/IFN2wBmBaJAA3/hHtBbtNEJAM9HNukacPoqFqmF/TsumchFxUlw7q/2Wf618j8uo1Uz/COrIHnmjSsR1B05k807aO2wiF6N6vPW7RS/94NMtLO6K9B+QnbaenLUP/iDvC8YUDaSKxldDF1t1ItP8tt5E99KRWKvF8ukAJQAY2+O3zp5QadxIF1G14XeILukEkCfpPlRZZ8XaJSvQuoeBF1YHr0owyUkaaXhPEUsErm9g2a3ORlEfNA8YjMzgvUSnRRmp7Hi3+U57Q/CG3msDz2XhBszwMcKfYqSQ6Zvb64J6VJiqUbRP93A5z/zFuVq9at72AbQpaqp8LNgWJrCCiYMGY45dib4klanpx9sZx79Fpbhe5Dewwm87a476W/si+qGqzYMenSn9UQDr6nZNGUS53dRplAm0kypitnMER4mQ4qSs7NGzveRZze6Nz3PvRUSm01/aJ47j0BbuCX+QoGuQzUxw+tdpupSkIqk+ICjqBr6xAKH7qrX6lLrnTTzya3s1Fybnr2lU56asCd/tl8Ht9P6oCTM5Yv+gK7QcoCTAJcVDxD/0vmpo51hb8ONUKTCizVPxU0tNEyIkUjLHJMSvvCBmd+fGGqksl+uYYIlk/5iRlWBF4XR2D6+QqLgyl1QBTFObjj1F3dKr4YzXeQdrWbd6k=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(10067099003)(261009223027099003)(261102130727099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(3023799007)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m2PxGv8F6608xqQBXdkhFVx3yB8k9kC+f0CB4jBsfl5LWwPvTxSupW2OrXLzNHSV9MnJ2fBh13T4fzhx1g09s4CwtpuuyMRxy+wlUi4jbGKSxGz6xwUoCkvEsy2x7xVfHTOJifZ31aS9TcBWyIYrG6xZv7yCEddWrNk8tE+bxXMbBi+/e7FAh1ZtajuAJb6rm9y8XCVmADMgv3kr8+2w+fskt+VPJfraPz2fCZyw7lkERK2RsF1Ve0zXPR9MR0SybTfiPt/maFivf0xHvgXtj6yJUUYa9SfOSY2aGmQUe7oU97DbU7STqSLKsz5bDU+wldrOCE886iZmBmA5a607vrnqoKzHQ42yKAY2mOjnZysSL+Zw2K3s8ClfXkRRpr+4qQ8GmvCNHKKP1QKOHRzyDcnKaZ621f/5UzDsH8sKtFP1t414W3LAOSCAdDFYxXvz
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:26:52.0348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76089239-270e-472f-47d2-08df4096b419
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9677
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds mmc_set_part_conf() parameters sanity check 
and fix the partition selection after "mmc partconf" command on eMMC.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v2:
- Reorder do_mmc_partconf() parameter check. 
- Refine do_mmc_partconf() part_num parameter check.
- Replace introduced log_err() by printf().
- Update mmc_list_add() header in drivers/mmc/mmc_private.h.
- Update PATCH 3 commit title/message.
- Link to v1: https://patch.msgid.link/20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com

To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Torsten Rupp <torsten.rupp@8tronix.de>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>

---
Patrice Chotard (1):
      cmd: mmc: Add mmc_set_part_conf() parameters sanity check

Patrick Delaunay (2):
      mmc: export mmc_set_capacity()
      mmc: mmc_boot: keep hwpart and capacity in sync after changing PARTITION_ACCESS.

 cmd/mmc.c                 | 17 ++++++++++++++++-
 drivers/mmc/mmc.c         |  2 +-
 drivers/mmc/mmc_boot.c    | 17 ++++++++++++++---
 drivers/mmc/mmc_private.h |  9 +++++++++
 include/mmc.h             |  8 +++++---
 5 files changed, 45 insertions(+), 8 deletions(-)
---
base-commit: ca397fed3948483c4708054d3e73a51962f2b27c
change-id: 20261105-upstream_partconf_fixes-401e1f6ee5da

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

