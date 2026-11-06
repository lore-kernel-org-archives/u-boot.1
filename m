Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC84E606EE82
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nAVmlMtW;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=JnSAg9SP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93B80407C4;
	Fri,  6 Nov 2026 09:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rsXg2mb--Eic; Fri,  6 Nov 2026 09:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6D32408C3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957705;
	b=lD3FawKwmjAGiT4m2ESuwpSzYKfLrcr/TqxPWGC/lf6p5SghASWLJ5waXJrB0KiglcWh
	 GoH/kemTA4fumPjzg+BMOJ93nJ0aHfTr/q4elWiqHfGEg5ZguZZhMvAF5j391QO27LHIm
	 GbkcC/xw8tZrUTyTzap3tjHMJiyUfvE3oKC3xfSutYLLZ8nsOsoYC/z+MDW/aI3gLJxSq
	 ze1O9V0M3v6Cz2xvegMU/1SisztKFoerh1z0rG4ra2QXcTlv2X3Mh0TgJqkrvlEbmAgo4
	 yILFUFCkFkakYJ7wFbcUb3iKQ7ThP0Tfq4Q+r/rDR74Fmb+NWJWfW7YPd2kcB7MM1nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ejNI0rxt8qiAfDvav3N+1ZY4elAYqw7Ao03s0d0pm0Y=;
	b=p/f6uKfgofCNLsaeqinwzmIVcLtOQbEYSGJyPbPgHk5zQpUSzqtbte2Q8qVLfO0tGPuu
	 CTfFfol5V6aKxpjFmuAIlq7p1jMHCF0YYBMJkFYv6UWg3nG/a/AYuiVeIzYwkufVYEGpW
	 D+IR2s4G3yKptfds8jE4qK7coxOujTXAIVsO7TxFqnx1UzAXqVNHbzQrzRpcPwwXaVQce
	 znvtpc8BfA6HsOI1gO7EQ2ym4M1gKcxqFf77d+Cp7qNCXhnGfzByKo3K7MtGBi09PlJ6N
	 Rp4bLiV9YyYs+1xKoTD8FbaaFw+cXD5AniTX0KWpi3cHEdTqE2vDXmE2/FzUAOJCIIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957704;
	bh=ejNI0rxt8qiAfDvav3N+1ZY4elAYqw7Ao03s0d0pm0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAVmlMtWcVod6YvgVzXuYmVntKQqEMp/hXMIk2HORgEsXkWJ8vpaoHUZ93l0t1KVD
	 y1tL+fkMKSa3IIF1iqemhnoI8Gf3LBZDvJZHl1PWI3/Ao8JS9agrfJG6AhZ0Y6YpmG
	 b6g57fcwVQN4Vt6HPlJDX6MTEppX+R3JPtV2y6stOMBIp2+Dj+FB1zcSCXniI9qohL
	 rKdYz9jONl9CJjnycMf7SbXNOKjpGQN2du53ku1Bh1kQgZilgC81Rbls7lCc+0jgBs
	 pc3exQEC74rTTZO+tSsPIyfIaaPl69MihXtVXU2lFJZ6ZTZRUXlrHFKIn4xqAYJJSU
	 Ys30W2XO8hmWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6D32408C3;
	Fri,  6 Nov 2026 09:35:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 11A7B31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0EF2760774
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRwF44ifYO2r for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 73C5C6069B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=JnSAg9SP
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73C5C6069B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejNI0rxt8qiAfDvav3N+1ZY4elAYqw7Ao03s0d0pm0Y=;
 b=JnSAg9SPuZLbL3UTtO7IkqW/8n+lAIAroWgjL5y5zawCnkAsnpR7TsJ3/R2WBLhV29rtX46rjw3809a6hsOK7IJEO9ZIVsLjxwKfcmjJQUJoZVR1UF1s7dG5qhwO7NN0fjGHYcdQKf3BSQUgOc7cHAMyZWsmP7/XD+eQ2L/UCn9F15VEJmRttz/IrIzMIsc7pY4XBXGGKJUE51Rv/BQBb1oRF+GNhWb/mDjjVn9s9kWQk6usy590p0h4BZo77Sei0wqnkqY3TQe7bvgfCZLQ3g6lgZ/MjphL55RIq1eGwjKQh+7e7ax7vxQIw7/vcR7+WLT+PeYLFzr2drFILAC+RA==
Received: from DUZPR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::8) by GV4PR07MB10481.eurprd07.prod.outlook.com
 (2603:10a6:150:29c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 09:34:56 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::78) by DUZPR01CA0017.outlook.office365.com
 (2603:10a6:10:46b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 09:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 6 Nov 2026 09:34:56 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 8C10D200F7;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 06 Nov 2026 11:34:14 +0200
Subject: [PATCH v2 4/9] cmd: wdt: add gettimeout command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-4-07de25b6312a@nokia.com>
References: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
In-Reply-To: <20261106-rinta-watchdog-gettimeout-v2-0-07de25b6312a@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>, 
 "Maxin B. John" <maxin.john@gmail.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=3542;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=0qAWDormK9O4wAJWe0U+lTK697XVrrPqM5gBDLWrGwc=;
 b=QXEgi+PS4Ouo2YhelnePdGXY0wPstLaJ7R7+MZ9sKw9BoXmfUUM5kUj4Y3enqeKChOc1oA36H
 56eMa3xVCITBuvJAuv9T2T0N0ZikTuw3yQrkTJx716F6+CXiJ7x+RmL
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|GV4PR07MB10481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c703346-c59c-4391-a34a-08df3be937f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261009223027099003|261021123027099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UalgS0MpQnLg74q4Jlld+j3H3aCqp/4K8Vq58dCEULWrMgnrTAsNbFvVtcTNzfAQHdJYIf7yjuuSqqppJ+AczF4tdEEPaEJRTavB+mKxMZ4oWQj3RTLW1TZBx0JZZOKAGJsGhD6iDURgQ0hLPzKKKw4ibnrt8VmOeiJC51oorukyLKU9GHdk/9AKgjOKPKMz0zts/0vW1vuUAgER1HTzQJ4WHxng6CWsbb0Xpu5sareXfDyx5dJTGxBixeWns4H9n3YqXvIOMteLjorlrNgyVIXee3R08TsV3s79KNKTZFOW/8PuDRUiP6DXq5pM/t+IkvWP/M00P6Z8jl632AiwSLVjXyrwxpuVFHK/uce4Bd9ogh6SZhcpM6cNja2qPP0sD0LCQ+rGWCJhB7rs27TtB8ogdyMM6JlDD7TkfqfiwFQgsyR+98Wip9rhypDtaXksDy0tD1WlqZZ8fT5fUDNzqWJ3krAsZoRxKRBlmPXTThkf+J3CVkG2cGKsJhlu16BTVgmOTkLD9XfY2rlKCmZsb8pF+/xrMh6+MZFf4CrLSvp/9EZ9lx58sc/QNIbnMrc/PLvAGza8THWqEMPeRW718dZmXzrBrKhflldEjMyZFoleuBE3DwLwkieFmRWzrzRvhul/Vv45Rw9E9yg+6odtCKWTxMOs89PoTDps3tpYnp8mXLuweEBM7N7Ug2Z1egCrOCJt5qaCyGUnSG/6TBlDCQ==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KOqxY3Rnqxal+mjHwieAGnTPoCET2W4Ug8S9tY9810NenR2OOFDju3ITXce1VAV47SRSAMcgziBHQcFvqImFHiwkd/4nHpHRelIkNb+UCw7aYEU/sB1z0cYaWm8aGSbgL4EDU7wFWKbBeD0PO259ge2myC5OKe6AUZofUgW2onLdZAttatxCM90fOF5+FqMm8tGO5n5KuyngtYh/NCJpse2d2oKROET/U1Ugi4qrlTp6pb7bGROpKboLZ2/qbW/PjPNyID8b5z89d+3CkpneZF6f+rQ9le1RegRFq69QWbMOKNzDcH4jyppq9qimML70YhUuV/Y2mbI/i3XZGTX+2zJAoQYOhQZenGyaurkSEcSHosxl+EQfO1fWdS6XjLwuOi1WL5J7kJHxNMd86HCMHfjB85hArN6/jBFgyYrBx3pyAMekHu2VGTwxCufIRGmr
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:56.0771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c703346-c59c-4391-a34a-08df3be937f1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB10481
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the subcommand wdt gettimeout in the U-Boot shell.
The command exposes the wdt_get_timeout() helper to the shell interface.

Command reports 'not supported' (-ENOSYS) and 'not running' (-ENODATA)
distinctly from other errors.

Add the command to the documentation.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 cmd/wdt.c             | 25 +++++++++++++++++++++++++
 doc/usage/cmd/wdt.rst | 12 +++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/cmd/wdt.c b/cmd/wdt.c
index b5f7bcdc35b..a5a5d678542 100644
--- a/cmd/wdt.c
+++ b/cmd/wdt.c
@@ -134,6 +134,29 @@ static int do_wdt_reset(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_wdt_gettimeout(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	int ret;
+	u64 timeout_ms;
+	struct udevice *currdev;
+
+	if (check_currdev(&currdev))
+		return CMD_RET_FAILURE;
+
+	ret = wdt_get_timeout(currdev, &timeout_ms);
+	if (ret == -ENOSYS)
+		printf("Getting watchdog timeout not supported.\n");
+	else if (ret == -ENODATA)
+		printf("Watchdog not running.\n");
+	else if (ret)
+		printf("Getting watchdog timeout failed (%d)\n", ret);
+	else
+		printf("Timeout: %llums\n", timeout_ms);
+
+	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
+}
+
 static int do_wdt_expire(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
@@ -165,6 +188,7 @@ U_BOOT_LONGHELP(wdt,
 	"wdt start <timeout ms> [flags] - start watchdog timer\n"
 	"wdt stop - stop watchdog timer\n"
 	"wdt reset - reset watchdog timer\n"
+	"wdt gettimeout - get device timeout in ms\n"
 	"wdt expire [flags] - expire watchdog timer immediately\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(wdt, "Watchdog sub-system", wdt_help_text,
@@ -173,4 +197,5 @@ U_BOOT_CMD_WITH_SUBCMDS(wdt, "Watchdog sub-system", wdt_help_text,
 	U_BOOT_SUBCMD_MKENT(start, 3, 1, do_wdt_start),
 	U_BOOT_SUBCMD_MKENT(stop, 1, 1, do_wdt_stop),
 	U_BOOT_SUBCMD_MKENT(reset, 1, 1, do_wdt_reset),
+	U_BOOT_SUBCMD_MKENT(gettimeout, 1, 1, do_wdt_gettimeout),
 	U_BOOT_SUBCMD_MKENT(expire, 2, 1, do_wdt_expire));
diff --git a/doc/usage/cmd/wdt.rst b/doc/usage/cmd/wdt.rst
index 28abf98def9..bb0b402aa2f 100644
--- a/doc/usage/cmd/wdt.rst
+++ b/doc/usage/cmd/wdt.rst
@@ -16,6 +16,7 @@ Synopsis
     wdt start <timeout_ms> [flags]
     wdt stop
     wdt reset
+    wdt gettimeout
     wdt expire [flags]
 
 Description
@@ -34,6 +35,11 @@ The 'wdt stop' command stops the current watchdog timer.
 
 The 'wdt reset' command resets the current watchdog timer without stopping it.
 
+The 'wdt gettimeout' command reports current watchdog device's programmed
+timeout value in milliseconds when supported by the driver. The command returns
+`CMD_RET_FAILURE` if the watchdog is not running or the driver does not
+support it.
+
 The 'wdt expire' command let's the current watchdog timer expire immediately.
 This will lead to a reset.
 
@@ -60,14 +66,18 @@ Example
     => wdt dev
     dev: watchdog@1c20ca0
     => wdt start 3000
+    => wdt gettimeout
+    Timeout: 3000ms
     => wdt reset
     => wdt stop
+    => wdt gettimeout
+    Watchdog not running.
     => wdt expire
 
     U-Boot SPL 2022.04-rc3 (Mar 25 2022 - 13:48:33 +0000)
 
  In the example above '(sunxi_wdt)' refers to the driver for the watchdog
- device.
+ device. The gettimeout example assumes the driver supports the operation.
 
 Configuration
 -------------

-- 
2.39.2

