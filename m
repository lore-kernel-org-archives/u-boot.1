Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842B606A31E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cUX/aE3k;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=OssUunUO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B21234082F;
	Wed, 21 Oct 2026 08:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hyJE58YWgjK3; Wed, 21 Oct 2026 08:08:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D27504082A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792570109;
	b=kYHHjkDtxQDpqmYqtk7v8Qi2Y/wNIRDnlUW4eIFra8knH3I7DAC7buHa9VI+xGy7J8EL
	 zrvqGvrAX0Fb5KzkRZuaTnOj1DEspeIgK85yo1VZumHad0BMKuVKHd1Q7ITVuZQMn86MY
	 YvqHNK0IvE3gI2EBONdhUeFPgnGIiuDfmfMRA+tBIMGD23MMQfsoWaRlHkRIPoM3uMoFZ
	 ewjulPdsTPJpeh9AzMcfksyp8D1mxHR5ZixnKlrBRYBzZusEgI/oHkymtf7PSc6rQfckX
	 M5Bex0TMtPNYom8F/xzTycD0r3+Nxf+Kmnbr5ZLD9Gvn6ZGdg46R3aAQgkNPG5XxRkg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792570109;
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
	bh=1WQ5qUji0F8lGOFpAnIysQPJFyQyxHz8fBJJdqDvE6o=;
	b=kawPB+3cuy5U+WrMCWB3CTnnSx6ejACZ8Xgipbd8uDJMvC9cF7479mS3mjz2/TEMem6v
	 z/jmmWUtjglG6FcWaDpNZ1TKKHUdt6lY1dTbgkcXCCjowN35bW9XgyRCkedCHcY7jy23l
	 J1AKMSZ/iae+hGC/466y+KoSsyl1QAwywRBgoaJnJMNa7vC2F9D5KHQgn6jUssegEyXqS
	 ipvM4EgKQze/ULuBVu/jUMeOS1bMW2jY8XyEOlBrkmsc2Jh7rMwT8APdbjfFFBKM7zzo3
	 wb7/FMFuFx/z4zWZBGXMWODxuzxK2hKV9R6Q6jkZyr5hIddjhzWuJOJt7gFjTelQ3GA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792570108;
	bh=1WQ5qUji0F8lGOFpAnIysQPJFyQyxHz8fBJJdqDvE6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cUX/aE3kwNH9I9xjXmgXklUFqYPCVWfpjQ2Rehqqw5RdsP1OHvpqy+i4WFP685rqg
	 xvol1bT4euZCa1YuXs/7n8IA9i4lRdOzQqHPC8tkMFO4HUNvhlB7Ckkw56AUT2bX+F
	 Xz8KGGFHAiaC7SQtSEOnDx+K/cZFXFAJdlRcCsLyVwr8jVWswjA0nPlykZ3t8FX4ik
	 aUWWAI+yiPIY3/NzDKFB8nL5XoeGM9Fmbeleq7Hhdgo1zOXyFlK988alDDVFPZeUfx
	 3h893kLWCWUV+4fY+Di12tDP38aFmWGlwR/lV720DPwqTUvg8mAulq7rJivX2vMwLd
	 UQEUUSVMJpFlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D27504082A;
	Wed, 21 Oct 2026 08:08:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AD97E50
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F17146078A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDZhbxVThpl1 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 17CBF60763
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792570098;
 b=g4LiMXcr/VulXp2zWUxmDdQdvHhGcN7nw2iXt43W7RzO/XnjPA2g1mOXi3owsxy+r37h
 kP+F6qmRQjKGHfG6ZpebDzzjspmeX7AEqJpcM+6iVUhVmD3yrywzdT9REl+aLG0cMHzF/
 cObOAsD3YkIPj8G2vhrd1RZKY5/tM3z8dsXCmko38iow6nptIHS7b6CZP7vmC8SWh0keG
 gFoZENiumouhXkf6+h5v5v3Njpc8tKOWFdj6pxDShvAb0WqA1s+KxhZviprgLdNOmHsKg
 di8SQx3kNT03BNkTw7T5yu4IITO+3SRCIMQZuZVHSO8oBVSAw5QhBYouuLsWNNnoRdQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792570098;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=1WQ5qUji0F8lGOFpAnIysQPJFyQyxHz8fBJJdqDvE6o=;
 b=luTdEX1qPdUMtHaWuWlOPYAowZP7iJzqoCoXEbLqUhQKrcdDssGm0wxJMqOKsXz01lIe
 ErdcgwqGsZacFZzrm/GiZKyGgEQFGWIlls8f/fB3mKA3fSy595TE9ynIGjawFMq337hWY
 uHcVPupQTps8Jy/vv1RBobln+6DKPM+S6qeWvOjV5dZ3jDHLhV5Bq3wYs79GB757DsN96
 3jzUI3IyAiI/ICPsTG1pNonzUv3uxrUYy822lN+cRU9XB7IaVCDA0KUOfth5jPCN3dChc
 v3W4kW2zppn4d0u2v6hUohEGj6SoOvERC8ae71SssoNUJejI4Gh/FRJ4bVIX3lcj7Gg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=OssUunUO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=OssUunUO
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17CBF60763
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrI5KIC5VUWiqC9vMePsCX9RS05f/muB48THvsg3ygC5oudQx66uRNw7kGurFMvxD+H00eU7RAb/L4hCQM7ogrbJz/xn8wsJj9UjytwMbaE5qokYACyVo4nRsRWCvdrLrFasSyuR7kY/p59LykAr6ViO1Z9FX7Vncb3C3gHuAtrtxw7LyVabMa0+5zm+kIefAn1CR68D4JQ1OyISJ2ZK1y3BG3XDdiyh5D4oWqEWQVoc02ZIerwor53HjA6KYLAG83ioJ9LzczE8qjk5DoTepoymrXd+s8cKBWJ+4ijzLYam5DZgj3Rfk3kMXfobqSqe3iyU3AsTtwAb1lKpt//KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WQ5qUji0F8lGOFpAnIysQPJFyQyxHz8fBJJdqDvE6o=;
 b=QkWdnxdSWWdSxNZZHw7QGU2CZ2hrqt9mQj2m4AjmEV6mtFmnvm/RLjsO7Q25rmnxq81xK+55vOQJhh+3wj+yyR6R94qxpD0dC+nP17frQ18HE3IxGGfdt9xVnV88w11lAA3QpEoiAruEO0a5miKOUAq97OoxkBMrWUZsLWXGnAktv7WFjwqTkmxbZ3Po4/nEwPLdleOh3hugIMDfvMkoIxvHBt6ewSjKjj+HhyFHE6bwct3h34LLXWcMeV1gOBeSfZ3MtBh0B/2AVmy513fB+N+C5qh/jebN9m5UTDRfUA33gWnaS9dtPKXo++xest+J/d8cD7Erb1JaW6NhxanVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WQ5qUji0F8lGOFpAnIysQPJFyQyxHz8fBJJdqDvE6o=;
 b=OssUunUORJTI+Ek9NOAr4SwBOw+KgK+PULQtv6VBdlFugymsQDLyyJR3E7y83ijNQHxwPRKDD4kqiFLmgZpP5OcoyZAiGxd6ozsYOBnGKqottsC05cl5dd5dIORi6BHtgMm4VCeOtnpePSTUSLrx/vH99Js0gd1k7EwULjb4p+B8OrijAXeVT/IuPYvO/CG7VXY8sTPgx93siBuFqui/0+b3fWX61YGsKLfIGhO9Zb6zDVLQxxQ1R/XicuxjGVStdezxL8wKx601myPsJhHGhcdCERNEuiqp7LGgrH5pKLsAK5mkAR9X1WiTCfaTYF3iyhqzetRNnCY/p6iqXRS/IQ==
Received: from OS6P279CA0149.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3a::6) by
 VI0PR07MB11591.eurprd07.prod.outlook.com (2603:10a6:800:2f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 08:08:11 +0000
Received: from CPH1EPF0000051A.eurprd04.prod.outlook.com
 (2603:10a6:e10:3a:cafe::a1) by OS6P279CA0149.outlook.office365.com
 (2603:10a6:e10:3a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 08:08:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 CPH1EPF0000051A.mail.protection.outlook.com (10.167.241.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 08:08:10 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 44858200D1;
 Wed, 21 Oct 2026 11:08:10 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Wed, 21 Oct 2026 11:08:11 +0300
Subject: [PATCH 3/7] cmd: wdt: add gettimeout command
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rinta-watchdog-gettimeout-v1-3-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570090; l=3397;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=Mfl1BRgBYUku3DCC7SDa5ltO88+ZY+Ve4I1zwGHODpQ=;
 b=C0p3bavxJw0ufdxd2HGuv2hmA2lk4DkNvc5rflQiLl9HAGov3RD7PGPIJd+LlGzfNqjneO9dB
 VhSAId9yQZZCJJIjWzh9YE9GHFw1gqD4Gapuy3WSb/CV49c0hgnuOOK
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000051A:EE_|VI0PR07MB11591:EE_
X-MS-Office365-Filtering-Correlation-Id: c92ae850-5578-46b5-bee7-08df2f4a72a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Sm6sg0QF1nitM49DCpngUk0lWX/hYaYAasBTT0R6x7n5lwgFYIjfPxvt/WKUIo3HpWyhg479FupQNzFxwWAJx35ZhEDj4p+Go1f4gi/2x4ghn65wIknnL0ZaZOpt6cOkiKHmtFgUUOvGrTD7J9HJeJ4mRXba/Zg1Fx6W4r9ScZ1QJ5toYA+5nKdg5dSaRKPV0nqSkOXMiK8/ufqsMh65ekspmNAYKv3o0SzXxfrlil96O/Zql6tx7NVEajocujjUZmhOJ9Vlvzc1NPLsTy+Het1I0NvaEq8muTTX6Vf/Ly1UAYQ6/s7WY5Y6S7KWMgUgJ6GbPkTrgNJsYZ7PCXak0JGjy6oRcluPaV4tNz7bOK7N/AooU/33qvX6+lZdGMBufXsVxzHJnlcN7dV7RfRPUj4rFLr7MCN4/cNIjSpaco7SgTEH+dD39ZtjZ909ayXrM2BUlN4BGZoS0W5/WXMuBfoCcfotGUCwTdyV+x0AzbQsRfAxszoh8tFPC7h0DKfZ0ySQq727p8g2V6CZmDLYCv4QxnG/lWhFprn7IfYk14y4/YMUZwBGKDFGLklhYlIAN7AJS4bhS/uipEeHxXRF9xItrxt8QjrswzDlEoKst+mvycEOXv1+nJQniW61mw4fbJswL2DT9gnLNdr+2fZy1EUE/cnoffn4ROzrvatObWQNlbpApNw8m4Gt67ViyU35JoRBH4TT49+uJrs16ZxJJw==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: coep84++ThJgJSy0nqwOvFBm+2YE07Yu8h4lpBIiJldVpv4TZej3tQCi38StxflPXi4oBRhL8vLLVNMC5Q7nQ/p0SpuTKhyeuPPMeD49FsSe1NOS6HdhAfdAePDvw96+me4MdKSyQJjh2KJpXEDoam+WIrw94BZ+B9WNMglcx2Tj3szQhnl9UACQaJ7hNHcbx6NIxAeRRSLFm2FDMX29r/baW0fP/AA1cMtrCMZJ65d3JAvJRcpJfbesS0Pon578SfG0SO93D407FyEywiHL4MtI8MrZb1EMAFEHgROjYRaJAaBucCCx+PMTEEg2Ystf03H2XeMOvjFhmg5dDoeoJ08dts8ONx2rurNOFtOgTSN+gZaEXE6NOTX0DqBxxt3i7Cd/i98A2cIhwv8AqCEHtoSm+S119wRUw9hjf7oSyBxE7xmU9L13ABry+HL1a+M2
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:08:10.6490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c92ae850-5578-46b5-bee7-08df2f4a72a5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CPH1EPF0000051A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11591
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
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
 doc/usage/cmd/wdt.rst | 10 +++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/cmd/wdt.c b/cmd/wdt.c
index c7a06cca181..8d982df153f 100644
--- a/cmd/wdt.c
+++ b/cmd/wdt.c
@@ -131,6 +131,29 @@ static int do_wdt_reset(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_wdt_gettimeout(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	int ret;
+	u64 timeout_ms;
+
+	ret = check_currdev();
+	if (ret)
+		return ret;
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
@@ -162,6 +185,7 @@ U_BOOT_LONGHELP(wdt,
 	"wdt start <timeout ms> [flags] - start watchdog timer\n"
 	"wdt stop - stop watchdog timer\n"
 	"wdt reset - reset watchdog timer\n"
+	"wdt gettimeout - get device timeout in ms\n"
 	"wdt expire [flags] - expire watchdog timer immediately\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(wdt, "Watchdog sub-system", wdt_help_text,
@@ -170,4 +194,5 @@ U_BOOT_CMD_WITH_SUBCMDS(wdt, "Watchdog sub-system", wdt_help_text,
 	U_BOOT_SUBCMD_MKENT(start, 3, 1, do_wdt_start),
 	U_BOOT_SUBCMD_MKENT(stop, 1, 1, do_wdt_stop),
 	U_BOOT_SUBCMD_MKENT(reset, 1, 1, do_wdt_reset),
+	U_BOOT_SUBCMD_MKENT(gettimeout, 1, 1, do_wdt_gettimeout),
 	U_BOOT_SUBCMD_MKENT(expire, 2, 1, do_wdt_expire));
diff --git a/doc/usage/cmd/wdt.rst b/doc/usage/cmd/wdt.rst
index 28abf98def9..debfaad3bce 100644
--- a/doc/usage/cmd/wdt.rst
+++ b/doc/usage/cmd/wdt.rst
@@ -16,6 +16,7 @@ Synopsis
     wdt start <timeout_ms> [flags]
     wdt stop
     wdt reset
+    wdt gettimeout
     wdt expire [flags]
 
 Description
@@ -34,6 +35,9 @@ The 'wdt stop' command stops the current watchdog timer.
 
 The 'wdt reset' command resets the current watchdog timer without stopping it.
 
+The 'wdt gettimeout' command reports current watchdog device's programmed
+timeout value in milliseconds when supported by the driver.
+
 The 'wdt expire' command let's the current watchdog timer expire immediately.
 This will lead to a reset.
 
@@ -60,14 +64,18 @@ Example
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

