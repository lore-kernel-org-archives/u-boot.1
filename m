Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3148FC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 05:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F01E580C87;
	Wed, 16 Sep 2026 05:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OAroiBN7FiGv; Wed, 16 Sep 2026 05:03:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD72B80CA6
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789535016;
	b=DdNgQyNgWH0ZLNNuBhKYB6eBdQRd85q5zY5+mUpWwF4WCVSP5vpgMPviqvIUN2RyZ2Ed
	 BlX/Vz1l1CiZ3OLtyOmZinwFTMK4VkjftrW1aihrziaskNhLX3rZg6zwP2UuYR6/NVlWz
	 w/sy6qB4xRMOosx8fdHMzsBLgfnoeh+EJ/r1+nT7l2Y6kreYPlVC3uBiFsFqpYjB+5Eu4
	 fcp5C4PwjdnqBDtsEIIEiWDJTVq6IuRKUnkDUJ7hWML+QIBfF8IiCnL7arK+VrYzdIiks
	 xwg1nq+T9vb7n6h3uUaPJ/TOyxfVKvfUblJvh+sorL1+GGcFzYOrBZ24mU4SRGHeXmg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789535016;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Authentication-Results-Original:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 References:X-CodeTwoProcessed:X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=KE+zF9xHF7VdPDhWiHg0s2wN9PnrEz+crlhXL4Nej6g=;
	b=tLLDcNz0APSM2l0GehtZPjbJt9WpXSvkohJFpgNvMqQqkP106zKGybQUA3K4HdgXGEg9
	 ztAfMsuxoK225nwiLZRrJyVQUNjiEvKCV3M32RjaOfq7wpIYTwQbH55JgEM/a5V5NOfMy
	 gCwdtR3/g7I2hbEH5/phfJ3iz7M+HQMPQV4XosakoWPlVNnObcSlsf6dsfd/hkXTizyO6
	 QqaACnKSHSstsbs7m/YcfdqRYY58MSWoJMFms5vHrX3JQ8ctY/Rxt7E6yqeybfpwDbIlQ
	 4IOO1TueySOyBIDChgUDCHZS2rK9P+MzZ4ieQe9jA74MzXlKHwVtWPGE8xatgidZ/XA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=topic.nl;
	dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=hjVtGLvk;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789535016;
	bh=KE+zF9xHF7VdPDhWiHg0s2wN9PnrEz+crlhXL4Nej6g=;
	h=From:To:CC:Subject:Date:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Ib2F6uyUDhYBvSnW0nY4+KtWAjY1qkHcR+nR32FzQriiezhJHafUTJk2PizXcY1Ve
	 mH02GRBU+leSZKq8hffwz6A7FkjooxXyRX27il+03nrPbDMd5V0A9jiZQaT5hgkcKW
	 Mv0QHhzONkusEdIitbYsvDbuQjFVVweObQj6YuZcY1/lBq2NGteqhZmbLtRBVD9uR2
	 BjcfHrZuQP/u+3N0osrGvrKgoKRMztOwP8lea4bDlnETvX9U90ecRUdAQL4RIk9dTQ
	 wo/lk3Z7wU2hCszlZh8P7s31BeW4IaR833VNSfNtkViszSNuYgbljchVVw4c1eow0J
	 cweDZIMqn9+tQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD72B80CA6;
	Wed, 16 Sep 2026 05:03:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D744A259
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8CC580CA6
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:03:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wJ26b_BWHNWx for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 05:03:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2252180C7E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789535013;
 b=Stp8BpI2QYTxEbdT8mzOFWajPoeOu/ry/gxwIkoTgCdu3ZEdVcNRAdTBQTCGP60XZ5oP
 VcGOmtLJrNyn1j+HFZYO3YEIWzqlWAfzvs5ImQ0CUR0cBnBbyjRK7tlw/VmPS4YZl2r3F
 mMoSzfQut0JtISZpX2k4SBUfakMoGxlNU9gELIwjb7LR9Avw2tG/+gR1ccRFyVGvZD+BY
 Ge8P6N1WlTHlX50owJFwN+JzvsskfS+54hlY86H0Lv/vNmE/MM3rame7TqWD8EoDXRS34
 gElvFjlOVPzK4zP4TYUNEHRNjNl5Wc8/1pYClnQ9qjieK+MOk6vZirHENQQXjNf40Sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789535013;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Authentication-Results-Original:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
 References:X-CodeTwoProcessed:X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=KE+zF9xHF7VdPDhWiHg0s2wN9PnrEz+crlhXL4Nej6g=;
 b=pA9uh0ALqqLjAEOY//l60YujtTyj3WIKn2gvx68ZTy8sPfiLIOv0LMZtjzGjnIhDLh73
 /GsyzPk+eNCqg6I6YLbjoJCZLlfm63CV1zs6TOfZpQ211Z31Eib8OvIuWobDJKJMMZIKm
 nxiN7Ihg2qPlUM11qbWySz0JtOJqZsiAqV0rv6Z4ArFtRt/ySmIA2fyyJzUJUjve5RaqH
 IqfHe4vMeH0RxhSzfasWjwx/z5bvbVs5X07r7V1lVmYtq25uxHeJk7QixlkJihE1zkJOU
 RW9SSPFTPHRTXUaJzGaMjjT37SUiuGs81wMS+d8CBmtuPaaQFwmZNlp+EMh1qOjtvow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=topic.nl; 
 dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=hjVtGLvk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=mike.looijmans@topic.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=hjVtGLvk
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2252180C7E
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5FsSlv2kqFVCFqJPittG3M0t/12GuLaxz4gM3a4qMC+RgytOg6l4+QeLEByWWN0PVoCTFUmUFEs8WqwRMlzLRsEdMcQZO2i/Aqo+hvxrbnPXSM5URX+2iOERSZPahI05gXbUrFz5NfGwXz8Pjl0BkmJ1+C72rFptbv+u9Xa7opjdtfp2rRz+yrQkvOXmPLysFVgZTED3eEfpXT83ZH1K8woA06oU5mKAmYBq3RM81P3mZAdecgpFVynIBiqKnPWpXu27rHDYl3x8JYeIM7POaqq9dG4c/dOcvz3R6oa55SJpIPvhs7+aaUlnGSuDm3GqsdoCMWw+5+PkRcB54ejTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE+zF9xHF7VdPDhWiHg0s2wN9PnrEz+crlhXL4Nej6g=;
 b=E7kWS9TJO0Ck8MLV2jCFCA+jMuEnC7AdlnfHs8tlAPDYlpMqjqsnk7+N6hCJuuQ8WRcm6Z1fZCdmTp6NeIrRWlFqTI4k4aUVdrhVgiBDhWUU6+XITBsAeaeq9EN+ML6FKuN4nbJqOUKPshyWaYsAKlJjQ7CxLyvjUxrQr/cNEZcoCyIKzqebZq6nwapoGYo4xSsELqD/IfXFflVfbTSAqt6/lGUBI7ZY5tu/EkOi8SBId4aBKvgQxLk25PPyqJoBa4yILQdNXC6hCqfrhNYVhekKkxLIVjWwGAvNnQ710mQTG+C2KlluDo+Aa/XGFBurLWXHEZKHq8osL11yNNoPvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=topic.nl; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=topic.nl; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE+zF9xHF7VdPDhWiHg0s2wN9PnrEz+crlhXL4Nej6g=;
 b=hjVtGLvkOgWGF+8CI+164JmF2YeonmrX7AQ3XLhak/2KrLfSswFZQX2sKTCZzcpMJrAtjpx3DTXuPaDB0NsBSlnuRb6pwgoVRsaN6F875z/UifvarGfqekJ1/eW5wG5F8gbSvYBqIrCN3K31/G892Gx/NpcGEDFen3RxNyzm1xESke35moRaf997RnVnCyCXhxjJfkM/uI6to6J9D6qv5/r5QQITNkwYMY9zIfxRHEimFW3CfKw8aCW5aSzs92fVR/GtOGkprRFbpG09/oJNfgFdAuWRkWCIq5+Y4moLZIbvU38CbLPXnbXacujExml+i2nwKTb3Vhm5uvLxRlIrZw==
Received: from AS4P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::19)
 by AMDPR04MB11679.eurprd04.prod.outlook.com (2603:10a6:20b:716::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 05:03:24 +0000
Received: from CPH1EPF0000051B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::7f) by AS4P192CA0007.outlook.office365.com
 (2603:10a6:20b:5da::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 05:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 CPH1EPF0000051B.mail.protection.outlook.com (10.167.241.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 05:03:23 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.69) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Wed, 16 Sep 2026 05:03:22 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by AM0PR04MB6769.eurprd04.prod.outlook.com
 (2603:10a6:208:17f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Wed, 16 Sep
 2026 05:03:19 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 05:03:19 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.u-boot-project.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Daniel Golle <daniel@makrotopia.org>, Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Change u-boot@lists.denx.de to
 u-boot@lists.u-boot-project.org
Date: Wed, 16 Sep 2026 07:02:48 +0200
Message-ID: <20260916050312.7618-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0026.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::20) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR04MB12030:EE_|AM0PR04MB6769:EE_|CPH1EPF0000051B:EE_|AMDPR04MB11679:EE_
X-MS-Office365-Filtering-Correlation-Id: 954e73aa-5309-47c5-1552-08df13afd57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|7416014|1800799024|376014|52116014|38350700014|6133799003|13003099007|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: 5/JC1rfGkpA5/hmA9aFCeAft1bvZ+e1H+KCz0zk4SGXfHuKSQxTa+gWd8SMVZBLSFHXMK0Ke8YXz7cOaKgwaEzW0WQ4IF8B2b6oxHPNe84i7oMDJ3Ysuute2WhHLqBh0YBrrSgSGLo0Gemn7vc0jycTBj6cgRg8nhzamSsl2pn5/mDVEWHkD6YrT11gx52swsFcbl5Pvxc+GiMUEo7oQOTYHkw5musylMqWhPX8/k6lJ/PI1ZOyE0FmcRkjlSiCpH92NBlGPdEnfjI0FyS6RnBmRuQ2P0wTh/+5P1FSOiuEzuAMGA6pZ3VBLiyIA5tJ+5mbqQ5blFA4RG54XwvGe8F6IHY8+br9Jzk2U/S1ekBNAFKkel8Aney23QviKQXhqeXE6UMMMGDqjkZhH5yZQVDo+EYPJvJLLGOs/h9J8ytzxE07S9DmEBCeJMsc6EacuX203Rim7kCSbBrYPbL9VPUJ7zobXKTfcciGDkiLsxA9Oja7G+OHQT25bYcmJ8jd7MRvz75BZJVSO52z4jnQu/y9hb47ss2ojhT3R+N7r9O3YL1g2/B2IWI89egbAljJeaFPI3w8BfksvDMFWaUn7y6P5k7nPhJdVsmFWJeaE3JVwiUI0eO+MnCsxd8WzR3A98gVz+mpiQLO03PDWN+sVUu0k1e4mCG/sAFNzQBsyi/w=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR04MB12030.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(376014)(52116014)(38350700014)(6133799003)(13003099007)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: KkhZ/KpNZwGSjVO1+SrVd4Ijul2ivuT15C2z8U0eoBcWdSGWHU/qmI5oEePvJkAFrQnsQBSM8tCemEzqmCzSAT2dZnm2j4stWtuzEBHFEn5+QSjBDfVbQSTrgBdhaUT7YLfzWubgce4wr+ljUTFV28cbFRcbISotkuuoKeC0FQtd10thY72Q92cVgpyzP0WSR3CpWPNRgmJ51yNO+4P/Jo8zSc9/eG24/Qw1QbJmXh8JhlJznPZRr8KF+pU5pGr0MgabfJsT8AeyyoGcugxNcVgDrbRCXSAtR/nd6bVAMf3dO2T56MbEkUXGCZnMQPwGbp1a7Gl+FGBDYvrfFs59Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6769
X-CodeTwo-MessageID: dffcb9f5-ae5e-499c-9410-4805633863ae.20260916050322@westeu11-emailsignatures-cloud.codetwo.com
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4c5643b3-0c93-4843-8d61-6d64d131693b@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF0000051B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a0e15ff7-a721-47b5-1065-08df13afd33e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|7416014|1800799024|23010399003|376014|82310400026|35042699022|56012099006|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: LXErZQOPmpFNopizV8/LBr+mBZr/bdZ72p3/LOtSpVhbiYuzKhOTYNjthG+4ULZmGJhRFNAwNh1gFlEKRrEIheO1NqNDec5N7Aw5lW6ck0mOyDU2imG0DT9BOb78NnKVz1LbjtHpOFFf+TjV4SfMhwm4d2D/zJSuDtWjrDD2LTnglUF27UV6Udb/AONe1jYMSP7LHBMYviEVWro2IVru8ORnwZBOHcp0c73ILJk+xcpBVC7E5Yp+22VPKqk6eglqPvzKdHRhIDg5sfanh4HxT9nLCDBQEP6BZadHmQ+mwgv2q+ot0g19WuesguXOzNcb8FH+fJdH91n7T5gP1Myq4WjeeCBWfzVOLO27VVB7a94EP/P8Y9xsLFL9thrSu3TGGfvLvCdDpkA2Cz0D4YYsQzoDyl8RcCwJWvkdANI0NAewA6pPmEmmXZOmAxrqELIVfW8fzUMIdySYsEh1Tq/60R8kkqIjSt4lRMLDmLPv8/IgTnjpoVqWjEcqE2kyYR0okp2upb0bA/eJKC/8ETd2MO4Z4q620dXMW/bnYNtdxAbYOEP0fK7Y4N5Z3ulUw63ENspzBXbah17+J09P9KjMB5/ivSZakQOw77KjiFhqFMcT4+4vpMbZzraOvQKk0mbCXBjiLpvUgignMgUpUhtT9A==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(7416014)(1800799024)(23010399003)(376014)(82310400026)(35042699022)(56012099006)(10067099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: He9D8qzxOSk2EELJjFLFR4kh4mxLuRYXS6c4t1wq/g1rdFs+lV/od92xiVFMxnupuJSA5FNN6sdL22+nH00DhuANkPZ2nhu/P5RLcg4vbeHmqDsgZmSLZMZgDRYgmw+Rwb9KTTOFePgvBhSNaLm+YClgIB2X4FSl0fofDbgUofz/vTCckYBJRQd9rQzb1y2GvL8IPk7qcZBRU+2+TGotcdJnTpbIF9TM/FWcH6793no9DFUIrnEL7BvhEOp6Z+2PyqZNAYLdRZaaRDmgfPMITwQfSpIYAHeCJkDpspXtvUhPrxzugGdT28qWihWjcM/2KDuwn9KN3K2T11/PyWcEhTzsNuTWVv9bdkzYtvFmt0vCm8PkB6WhxKd+HIsHQsAHrvOv3wBBDPavnJF6bkfgtYUMEt0kg3jojHsp+YVxdz/bZSEI4Wu/x87yAMeANdtQ
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 05:03:23.0003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 954e73aa-5309-47c5-1552-08df13afd57e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000051B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11679
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

The obsolete 'u-boot@lists.denx.de' address occurs in several places. Use
  sed s/u-boot@lists.denx.de/u-boot@lists.u-boot-project.org/g
so that patman and similar tools, as well as mortals, send their e-mails
to the correct mail list address.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 MAINTAINERS                     | 2 +-
 README                          | 6 +++---
 doc/develop/security.rst        | 2 +-
 doc/develop/sending_patches.rst | 6 +++---
 doc/git-mailrc                  | 2 +-
 tools/patman/settings.py        | 2 +-
 tools/u_boot_pylib/gitutil.py   | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de67..89a525631fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2050,7 +2050,7 @@ F:	test/py/tests/test_xxd/
=20
 THE REST
 M:	Tom Rini <trini@konsulko.com>
-L:	u-boot@lists.denx.de
+L:	u-boot@lists.u-boot-project.org
 Q:	http://patchwork.ozlabs.org/project/uboot/list/
 S:	Maintained
 T:	git https://source.denx.de/u-boot/u-boot.git
diff --git a/README b/README
index 5653f687e82..d77acc48999 100644
--- a/README
+++ b/README
@@ -45,9 +45,9 @@ Where to get help:
=20
 In case you have questions about, problems with or contributions for
 U-Boot, you should send a message to the U-Boot mailing list at
-<u-boot@lists.denx.de>. There is also an archive of previous traffic
-on the mailing list - please search the archive before asking FAQ's.
-Please see https://lists.denx.de/pipermail/u-boot and
+<u-boot@lists.u-boot-project.org>. There is also an archive of previous
+traffic on the mailing list - please search the archive before asking
+FAQ's. Please see https://lists.denx.de/pipermail/u-boot and
 https://marc.info/?l=3Du-boot
=20
 Where to get source code:
diff --git a/doc/develop/security.rst b/doc/develop/security.rst
index 84b130646f3..ed652ec756e 100644
--- a/doc/develop/security.rst
+++ b/doc/develop/security.rst
@@ -11,7 +11,7 @@ Contact
 -------
=20
 The preferred initial point of contact is to send email to
-`u-boot@lists.denx.de` and use `scripts/get_maintainers.pl` to also includ=
e any
+`u-boot@lists.u-boot-project.org` and use `scripts/get_maintainers.pl` to =
also include any
 relevant custodians. In addition, Tom Rini should be contacted at
 `trini@konsulko.com`.
=20
diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.=
rst
index c3e0ef27824..85b45e8f3a4 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -25,7 +25,7 @@ Using b4
 Use the `b4 <https://b4.docs.kernel.org/en/latest/>`__ tool to prepare and=
 send
 your patches. b4 has become the preferred tool to sending patches for many=
 Linux
 kernel contributors, and U-Boot ships with a ready-to-use ``.b4-config`` t=
hat
-targets ``u-boot@lists.denx.de`` and integrates with ``scripts/get_maintai=
ner.pl``
+targets ``u-boot@lists.u-boot-project.org`` and integrates with ``scripts/=
get_maintainer.pl``
 for recipient discovery.
=20
 Start a topical series with ``b4 prep`` and keep the commits organised wit=
h
@@ -51,7 +51,7 @@ additional runs.
=20
 When the series is ready, use ``b4 send``. Begin with ``--dry-run`` to rev=
iew the
 generated emails and ``--reflect`` to copy yourself for records before
-dispatching to ``u-boot@lists.denx.de``.
+dispatching to ``u-boot@lists.u-boot-project.org``.
=20
 .. code-block:: bash
=20
@@ -86,7 +86,7 @@ patman now lives outside the U-Boot tree; install it with
 General Patch Submission Rules
 ------------------------------
=20
-* All patches must be sent to the `u-boot@lists.denx.de
+* All patches must be sent to the `u-boot@lists.u-boot-project.org
   <https://lists.denx.de/listinfo/u-boot>`_ mailing list.
=20
 * If your patch affects the code maintained by one of the :ref:`custodians=
`, CC
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 65626d89eac..f0ba30a5c74 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -5,7 +5,7 @@
 # Then when sending patches, you can use:
 #	git send-email --to u-boot --cc i2c ...
=20
-alias uboot  u-boot@lists.denx.de
+alias uboot  u-boot@lists.u-boot-project.org
 alias u-boot uboot
=20
 # Maintainer aliases.  Use the same alias here as patchwork to keep
diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index 17229e0d823..fe65b1d3fb7 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -162,7 +162,7 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
 def ReadGitAliases(fname):
     """Read a git alias file. This is in the form used by git:
=20
-    alias uboot  u-boot@lists.denx.de
+    alias uboot  u-boot@lists.u-boot-project.org
     alias wd     Wolfgang Denk <wd@denx.de>
=20
     Args:
diff --git a/tools/u_boot_pylib/gitutil.py b/tools/u_boot_pylib/gitutil.py
index 34b4dbb4839..59688aa7147 100644
--- a/tools/u_boot_pylib/gitutil.py
+++ b/tools/u_boot_pylib/gitutil.py
@@ -528,7 +528,7 @@ send --cc-cmd cc-fname" cover p1 p2'
                   "Please add something like this to a commit\n"
                   "Series-to: Fred Bloggs <f.blogs@napier.co.nz>\n"
                   "Or do something like this\n"
-                  "git config sendemail.to u-boot@lists.denx.de")
+                  "git config sendemail.to u-boot@lists.u-boot-project.org=
")
             return None
     cc =3D build_email_list(list(set(series.get('cc')) - set(series.get('t=
o'))),
                           alias, '--cc', warn_on_error)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
branch: maintainers

--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
