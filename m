Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124A606D83E
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Yca4hvcL;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=We5KWtwW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47A56408D4;
	Fri,  6 Nov 2026 09:35:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SklBAJvtUFu6; Fri,  6 Nov 2026 09:35:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 38ACD40944
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957714;
	b=jbMRKxJ5gZi9bzwpQ2XOjmhhn0IcJ1HSxoBe0Bq2R0fMfpu7Mvdn7FvdDzGBscaR5ve8
	 nCFDR4sV/tT9j4snin5jbamFZj3GouTdmF2Pl6QL4muNW159CsX3v3txXC741wKcbyxxx
	 MGycxEInnKGGIYoQKPZ+Y41FCr4gR5sGGjAlaXAo9NcU0cYlFO9a+jWt0ZSSOF6P03RTa
	 2jfRDC6+zY00UO2LdT32BT1U1OQUFRpis4x2AEh1q/p7jnE+XGd9t2RTaHRVKm81wL0/3
	 BR8rniD6MAUb3hA4CWFcW0ehVtAvqJjSTBGBcPkvZP4LrvMyfuU1+cVGDnAWOumaxag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957714;
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
	bh=wTaYSGXZEgQx2G2rKrHcOak+42+7QUQ6PNVajiABHbY=;
	b=RmSZmN9Bky62EMXoSOc2TwD2GxSJIMfK7VvTmIGgkwMTawDbbdfa18lp4gQAQfVsB3S2
	 0lrbZmw6OkN4WVL2R41Gv0nOyw2IIG7BkQR8BuoQaXiObkpnR76mB0ei9uXLQhUj6o482
	 ck3OL606F9goo20M0z5CXHTcKzCfvnY4c8lJxSw6avRGjE6P2aHMOG/jEsyz+k34cHYJO
	 Es3yifBvI2sKS7W/SCAChhbIHZajDQzz/DSSlWODjZ4WepTd/HBG+gQjBXniIexxcvIX2
	 vhjZLfgfLBS4Ew5feXOu7p69UvJYjGOM0svi8es2ln/e74a2X0vW7xEYV6HKXFPnNiw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=nokia.com;
	dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=We5KWtwW;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957714;
	bh=wTaYSGXZEgQx2G2rKrHcOak+42+7QUQ6PNVajiABHbY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yca4hvcLeCoWJANxDk51h5RsA9jXNGxpBdHpfiQoeHjjsvZk9gVApNY1MbvVTKB3N
	 FM/NEHHpTMiOyS+UrgzhEnKo5LL/YSrw63EYubpi+mmDij1VXADzAkeNm3RBTUHnJX
	 QhNJEtk4Gu4gpxRiD3eOiRusm3B/mGGCqIEFCz1UlOzwsfW2XD6HNSLw5vw0LsetrR
	 JX+T9s1iyalswZX75aQSYoes/lJynNaJH1SWlY0BLcmR6ZZ+dIFMMSvVLPgM761H5M
	 7CZAuicquKpKJnzwfYQJRgravrMdqMQywxexboa+4HqkAW2bxE482g8ybusrR77AJv
	 8gcOEWfyj9jog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38ACD40944;
	Fri,  6 Nov 2026 09:35:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 330E031F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 183D5408D4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zxHMAoliTJip for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54DA3408B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=We5KWtwW
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54DA3408B3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTaYSGXZEgQx2G2rKrHcOak+42+7QUQ6PNVajiABHbY=;
 b=We5KWtwW8skMM9rJDCZnjWfbfaqFAcZFt1sDuQWYfZ7qx0HL22jw9ydyec5UTVa2B1+iYS4aJUFwxjhMei8+9jDVxN2Werp9Re/E36SUhRIRugrtccW1frn8Ebqat8BGClRd407IsmocHQtFFUdo2T2GkcVH5PDAhTDmDN2AyCi9JpgjHXS5QZVlGkHb5PYYstUwOZHdy+A3yFwvEztZrRf06BHPf/uvURNG/QsHtrIxE9mJm629v09j+E01e/yRbfPSSBj5+cbim9tnH4imFsdKb3lUo9CyEU/1NNp4n77B/6wB22F6tbCQbxSB76+o8pyN5Te/u09VZV7b4nJqgQ==
Received: from DUZPR01CA0339.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::17) by AS8PR07MB7509.eurprd07.prod.outlook.com
 (2603:10a6:20b:2aa::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 09:34:56 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::3c) by DUZPR01CA0339.outlook.office365.com
 (2603:10a6:10:4b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 09:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 09:34:56 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 84469200E9;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 06 Nov 2026 11:34:13 +0200
Subject: [PATCH v2 3/9] cmd: wdt: store the device sequence number instead
 of a pointer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-3-07de25b6312a@nokia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=3697;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=g+a0hauhR4F6B0z+0xQ2fXeUn2vMXVd/idxWK3ThZzk=;
 b=R8aa2mUgSrdc45FEnTjY9CZMFFjB383pNVdvFHamJuWOajU4iZtJGpH23vtxf+y1suruko2MM
 lEg88J67xhGAebC9zWhAhYdz/Kg9RQb49s11rso6qofOe4fo0TRAwm8
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|AS8PR07MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: f45d0a89-543f-4e6a-52ef-08df3be937e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|10067099003|11063799006|261026121527099003|261102123227099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: usRGewnDpaAkmbhnmRXRSPsA4Q2xtvyS9VVgAPdFqtteW6opQLw1sMqkBKYvYpUHCp9Kti7sVoshlKs/HLe1fW+nXgH8WDisVW1jRtoHm3t/SxQ6zwa1o+xP9QNuTjWrJdUYP/3Yyq/+4RcLmj9jdDu3sCjW/Zlit0K3bTtB9we+F90671ASJY1up9SKxdeIfOr65tHk4jupQezcRNmwsikIlidhSl2catOOg2BjtTYTWPOCRU8SsjIKnlh7A4nyff8MKVvl9GxaMcO1/X1PWmIU8zDyVRl1PpKtXsCAnoAXAw/Q+H7mGs80Eu23TNdskk5kIpQUjVgUY2Avp7HAA2wg06ycWl2wHrp7RlRnHx7gmAO400IFsU6Gis3KyWi8heBKNMqb9fwGwG57laMNe5PFb5I89zUw4L9/LGZJYE3HiyrObcPrHIrqATKhMuAOqc0YGwhNhdS2iP7hToirBuguPcZ1X57P6ALdmaKusTKCpJoMxCdMTARsfjm7yWBBD6WWqHeT05FXjBwHd8cFOiKr9pc7+l9jkA+MUgrk3+Ntatu5ZVA8Dh5/yXIH6YYiWGqVXBUQPqczTceOO6+ghMRbbNMJFVCrQscwZ4HnNbgGeuAhBrM6i+rObc/sN2NhdztXHURDxLNWwTDTbxYFOA4A2b90tkrArnTGxvCMs5J2WEfx0XhwdGaYcdSF1PwdocxqfPq+Nxo7JhZjd6uOKw==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(261026121527099003)(261102123227099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6gaMXnz3ZJ67AU8+BPxlZWxjkjlJfL7/BFYZlwZHbJrhJmGM8TmLbznQGC9kaTEfRk9ehVKXOpuffRhL3zc5X3NVtSYvHir5qxy+6xme5s1kYL1hgvyTWxSPbnK/PL8IzGyLj3qtt4Dndp5nH1izCZyVBR18ifQIuuHpHMEar4G+QJl9T5d0nDz6PU02L27HD53OPhx4WwPdhrWGAZpcEYb2la7qCRJcIT9fKl2Xrd/IZiVBM++moK+1b+3BP+paf41GlGI6edazZmsKy9QFeJGeVPeEKRycfs2hr0JeT1XnzjcmUWzhFCSvXUvYX5/q63gpqIUjdeO/sZ7RrQpdQBa2Ef1iTa9IuxxkVObBNB0mjIrju+uR/WdAPUx08qhvLJ3bMU7F2QWJzozKJ3ru4lqJcX1pUzoKIlXf0x9u+5/CnDmM98rY6EzncH5eAFz4
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:56.0154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45d0a89-543f-4e6a-52ef-08df3be937e8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7509
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

The wdt command keeps the selected device in a static struct udevice
pointer. If the driver model is torn down and rebuilt, for example
after running 'ut dm', the pointer refers to  freed device and any
later 'wdt' subcommand that is run without 'wdt dev' uses freed memory.

Store the device sequence number instead and look the device up with
uclass_get_device_by_seq() each time a subcommand runs. If the device
has gone away the lookup fails and the existing "use 'wdt dev' first"
message is printed, with the selection reset, so no stale state is
kept.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 cmd/wdt.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/cmd/wdt.c b/cmd/wdt.c
index c7a06cca181..b5f7bcdc35b 100644
--- a/cmd/wdt.c
+++ b/cmd/wdt.c
@@ -9,7 +9,7 @@
 #include <dm.h>
 #include <wdt.h>
 
-static struct udevice *currdev;
+static int currdev_seq = -1;
 
 static int do_wdt_list(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
@@ -31,16 +31,18 @@ static int do_wdt_list(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_wdt_dev(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
-	int ret;
+	struct udevice *currdev;
 
 	if (argc > 1) {
-		ret = uclass_get_device_by_name(UCLASS_WDT, argv[1], &currdev);
-		if (ret) {
+		if (uclass_get_device_by_name(UCLASS_WDT, argv[1], &currdev)) {
+			currdev_seq = -1;
 			printf("Can't get the watchdog timer: %s\n", argv[1]);
 			return CMD_RET_FAILURE;
 		}
+		currdev_seq = dev_seq(currdev);
 	} else {
-		if (!currdev) {
+		if (uclass_get_device_by_seq(UCLASS_WDT, currdev_seq, &currdev)) {
+			currdev_seq = -1;
 			printf("No watchdog timer device set!\n");
 			return CMD_RET_FAILURE;
 		}
@@ -50,9 +52,10 @@ static int do_wdt_dev(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-static int check_currdev(void)
+static int check_currdev(struct udevice **devp)
 {
-	if (!currdev) {
+	if (uclass_get_device_by_seq(UCLASS_WDT, currdev_seq, devp)) {
+		currdev_seq = -1;
 		printf("No device set, use 'wdt dev' first\n");
 		return CMD_RET_FAILURE;
 	}
@@ -65,13 +68,13 @@ static int do_wdt_start(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 	u64 timeout;
 	ulong flags = 0;
+	struct udevice *currdev;
 
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
-	ret = check_currdev();
-	if (ret)
-		return ret;
+	if (check_currdev(&currdev))
+		return CMD_RET_FAILURE;
 
 	timeout = simple_strtoull(argv[1], NULL, 0);
 	if (argc > 2)
@@ -93,10 +96,10 @@ static int do_wdt_stop(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
 {
 	int ret;
+	struct udevice *currdev;
 
-	ret = check_currdev();
-	if (ret)
-		return ret;
+	if (check_currdev(&currdev))
+		return CMD_RET_FAILURE;
 
 	ret = wdt_stop(currdev);
 	if (ret == -ENOSYS) {
@@ -114,10 +117,10 @@ static int do_wdt_reset(struct cmd_tbl *cmdtp, int flag, int argc,
 			char *const argv[])
 {
 	int ret;
+	struct udevice *currdev;
 
-	ret = check_currdev();
-	if (ret)
-		return ret;
+	if (check_currdev(&currdev))
+		return CMD_RET_FAILURE;
 
 	ret = wdt_reset(currdev);
 	if (ret == -ENOSYS) {
@@ -136,10 +139,10 @@ static int do_wdt_expire(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	int ret;
 	ulong flags = 0;
+	struct udevice *currdev;
 
-	ret = check_currdev();
-	if (ret)
-		return ret;
+	if (check_currdev(&currdev))
+		return CMD_RET_FAILURE;
 
 	if (argc > 1)
 		flags = simple_strtoul(argv[1], NULL, 0);

-- 
2.39.2

