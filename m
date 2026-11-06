Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E663606D83C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TGdwOZxF;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=l0kLrebM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C82B28119E;
	Fri,  6 Nov 2026 09:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kto6oyDtxO3R; Fri,  6 Nov 2026 09:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B4CAA81194
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793957706;
	b=d4lzHT5mXszUQnbFp5Z0IcJ4cvtuVclTbkTopDPd3VJvEB8+tJd32Re/YtAL5hy9XiSy
	 XHS5mkA/3KH1AknoTWpYgy0KzdhNGP57C2Xe8rpfgoPk2HzWmuqvuD6saXAq66g13+rGs
	 oPMQAYzIsQSHmoXkojVVlI5OS4BRI9Rhhb5jMSjsGOWvhpKY0+8OatE3qCnJW/4OjXVWu
	 NKUXIqQULKMWlS3DbfI9Toe3zHrtdFMQcOF/PFYAhbrCB3/7oup88lOh7Fx1QhwKSpjFV
	 d2h4qvV7J9ZMxnQWcWecok03KozFpYG9T1ZDS1epdsqkcYI11Yyjm9KME/6Rj1EEmsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793957706;
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
	bh=xNFq8h6JQO2GPht8e1OhNEorEdR+drbiaiXuHzYOsJA=;
	b=pCoa6ZVvW+l5NU2n8auXu8e6/E+8jP9/0PGBOnFoeVP1lbcFTI5WwR1lRkI6Xz5W4TY7
	 qH3+UUHdVupE4a6t4DtTwCwkX59It2cJEEGS/z3vjwLyOcpWwWBeymCzt0AfRewjf9fro
	 VDJlv/yRlsY8pXNpXPwZzYVOnHauebFkRnjzsrD6bt9R8LQgwMHtREYcp+djQWbYfAZok
	 suR08QhNECmsXcv0pbg/7W7LgLUk0xnxqHjMae4zm8r3MPhbTcOUvuKtzo+k+uz7HwHYS
	 fvEvqcL8g+f0xjkoOvmN+lrM5qurKM1y9b5JfpeZHMTmSXkzLxc6f37Pk0r6ghsc16A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793957706;
	bh=xNFq8h6JQO2GPht8e1OhNEorEdR+drbiaiXuHzYOsJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TGdwOZxFIxX9JbkV5ibYi2WjC47L1j50CwhjcC6otMqivffEfB25kAB8Pqw1WChcU
	 QSRQZBVsP1r4cXaVekt7QsYExPwguPANv+a8WZHoLxUP+zKJx1sgSi+MkUoX07Zfir
	 Av6SWvmyDlqODs3oKQ2ZTGnIaPLiFhL4n3SK8TRiTD+HBS6zvAbIjg2XTdNw0O9Qlh
	 Wuq/lI1LZ2MOYt4ftjWyeXril5dw+cYMIjAGKeIXnNQs2RPBPRoZd1WWifETKBfy3M
	 w/gJiRQrTTQKJFKzjomy2/Rzz1f7hKv3LmWuU0ipWU/okB6a0hhSeJYR5oqc8Xj4xl
	 rhGw6n4rQaF6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4CAA81194;
	Fri,  6 Nov 2026 09:35:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 34E6631F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1AD8D6069B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qqyvmu5DI38d for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 894FD606A5
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
 header.s=selector1 header.b=l0kLrebM
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 894FD606A5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNFq8h6JQO2GPht8e1OhNEorEdR+drbiaiXuHzYOsJA=;
 b=l0kLrebMgzJgA60yZGuo7BJbiic68UxFlYQKqZ5r+Wec5LJ5q/1Z+zZkMIGfvLA/XjKslDjw+Wbv60R9ldcMgrFYpIjYZztgkZhr+vhfKzmZrcpbI4dsUqRee8OEj7b95FbmZ7kMSRGaAKriYjDr0MukhOPH0xzzaoduj2vY1ZygaNpW2SrChlQWSx7gmANUndYR2k8NMf7S+Orp9gyWcVO3H/DWFQcXpo0q6TAu0Fh22WwRdcVNyB8YICZqkO0I0UVT4AKmpDLOfsLXCuBbgh8Na7qC0DRwrXDd/YAL5/V7omLYni7KbXLxNk0h+NAwAvH0dlMMmpfX6ACI6Rd8Mw==
Received: from DB9PR02CA0002.eurprd02.prod.outlook.com (2603:10a6:10:1d9::7)
 by AS4PR07MB8875.eurprd07.prod.outlook.com (2603:10a6:20b:4f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 09:34:56 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::1e) by DB9PR02CA0002.outlook.office365.com
 (2603:10a6:10:1d9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 09:34:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 09:34:55 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 7C60C200E7;
 Fri,  6 Nov 2026 11:34:55 +0200 (EET)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 06 Nov 2026 11:34:12 +0200
Subject: [PATCH v2 2/9] watchdog: warn if timeout not longer than servicing
 interval
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-rinta-watchdog-gettimeout-v2-2-07de25b6312a@nokia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793957695; l=1487;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=4UW/agvOwt6dpXJeMxp9WovEBJD7UFgvFmf0RMZmE1I=;
 b=u/8VPls6YOw3se+IECsKlmOt4HBbFDTU+mcUmarRygy4j1wNixFYM06uW9TqfdJPZ7XIyyHA7
 8lgxOVaLNdiDZungnBKaGcsxZA3wjm4qdmqK9EnpgjDET80V6wkHYdP
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E2:EE_|AS4PR07MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e10ec2a-31d0-48ca-e384-08df3be937df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|261022105027099003|10067099003|261026140227099003|261021121427099003|261102123227099003|261028144727099003|261009223027099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: bf9En2k1pP4cr8SVOf7GO80OuOW4VcoGkJ1Nfj/+8VydY51SBAT3RIJ7BjcenVlLN2VNNHiblxx12U7PNJaqOpfZU7ZG5MPRVKk+Gt1y1nz1jWPOonbAc5a1VhMuQbD4PEHu8biUKkoVJVmUteF4stdECIQkbY8cr7xUcT64dv3BOF7jGlnJ6PnBSSEH5erHIBy/jPLlI+wJ9M1zUsGRm0wWc2bRdaPXhkFhH+nultUvUSBGYWSbnA2D7Yeo042IBFRuqFW3Ggexz+5vUyRJ0S0ZHWbfT24zPT+8sgigY/GUc2+MRPs9CNwNNnJc1OzK+QnpXbW5ORJa4DhIhFfaOTH/3CGxAK+/IKF/ZOKHNy4nL3IbAvYzei8fn4MSQsemYqx7Pk8Lv6nig+6VTnxC+zeawh8j9lO/WdjwPqTK1YV2YQWOlReQ6gZgjWbnd54RgQEiGJSDi4a/YSkADHIweKRGktEO2JhKyA6+F3kzrD59xgrGyNnr3ou/i8u8/7507+dhfLlXX1h8bupYKodBPxJA0hh7r3k9kN65w/KW8X2PXSKKrnjh1OCDZ4Dq19u13C3uEJWwU2Bl3vSvQ0qS/wzUtVmSYemDtfAtnKA9WgXZmKrWUBWBpkH9rHrcXfDrdlTu8ggRtIsjIzH/y5Z1lUjmSKL5b9ePtN0KLptPGSU=
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261022105027099003)(10067099003)(261026140227099003)(261021121427099003)(261102123227099003)(261028144727099003)(261009223027099003)(261022075727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AF1fbEal2A6CN3GWcwkaBSwkIleYtEnEYLsCJ8dPN0F7a/jBkK2c2/HGs4ROm2MQjKJ1ly4lx5XP8wpye/LcALZirzc0EKF9AMQNYkUG9+n2VQed2E5PYC6Vg+m/neDfPu9zEIxsxgGKW7EJAD4D0YJpXtBcEBWj0rGf1WBrjS7Kk5zUQXIfxHETBXYutKDH/6HOpaiY/DfIzJVCOewYYWuWtC+q2tIAik033tJtcfLIhhZHTqFuQ2V5XWxJB3RVXsiChyrb48YLe/T5MasiUpIlK0REm4QEJacEkmU7+8vgutbRwHAaNu0/6ZcClkYAC3bxncyQxhTKWnY2yqM3hvP1ynv8B77ppbDwaQZpAtqm3Da+QmJNQSb6eHAymSjD8SazAO0RxzboV1FMCM3In9bCvLCwkhtH6eWwKhfMy1wPzsYL1cl2pQRpU0+r3qXT
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:34:55.9599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e10ec2a-31d0-48ca-e384-08df3be937df
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8875
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

If watchdog timeout is not longer than servicing interval, the board resets
unexpectedly because the watchdog expires before schedule() services it.

Print a warning in wdt_start() when the timeout is not longer than the
servicing interval. If the driver implements get_timeout, the effective value
is used, otherwise the requested value or the clamped value via max_timeout_ms.

Suggested on the series "watchdog: report effective timeout"
[https://lore.kernel.org/u-boot/20260823071511.687900-1-stefan.roese@mailbox.org/]

Suggested-by: Stefan Roese <stefan.roese@mailbox.org>
Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/wdt-uclass.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 291f0187682..bf6f2a4ff96 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -178,6 +178,11 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		printf("WDT:   Started %s with%s servicing %s (%ds timeout%s)\n",
 		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
 		       svc_str, tout_s, req_str);
+
+		/* Warn if timeout is not longer than servicing interval */
+		if (IS_ENABLED(CONFIG_WATCHDOG) && timeout_ms <= priv->reset_period)
+			printf("WDT:   Warning: timeout %llums is not longer than servicing interval %lums\n",
+			       timeout_ms, priv->reset_period);
 	}
 
 	return ret;

-- 
2.39.2

