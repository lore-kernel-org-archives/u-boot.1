Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13B606A31C
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oT8wVc80;
	dkim=pass (2048-bit key, unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256 header.s=selector1 header.b=SgzXe1kD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74CD380D43;
	Wed, 21 Oct 2026 08:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5kcbbk5YvDG; Wed, 21 Oct 2026 08:08:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 145C981155
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792570106;
	b=pmAsq25uHkKPi5/b5UZmc176K83Fwc5zDpnI/Em3pFcCH9iaxIL+cOVDv2ESd7g8DHAs
	 fM29UH8nrx95jvTTI6R6NMU45R9VzLMik4NnxcZzs/CpN7qx7TjMThvcMWbxB6iVUES6h
	 WekfzNMlrnoJDbkdtdWy2aHft5RrTLbS+cr5qAXLdRX7AO+UbTs6/WHpFuby6FGJaX1XF
	 L9Pn1P3BEmYGRKN3QLMFDnr2QOEYFUYYXTLn95Qld8BGWe+Sl1nK39bSbQ6Wo7rC5l9+f
	 DYRhcICR6DASHGbP7CsHUGBHXiYoHzFX+mdHACgxLNqWKNnF41/iDFfPAx8gUDnClMQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792570106;
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
	bh=6F+YIKc5R3x9GDGHjzgHmzTBjoMOLAxRuaE+B/mAA48=;
	b=sWbbm62rA/tPbvjIk5UTH7zIL2MEhoNwHXk5+JoCHQrfsAD2lPBFErvd+sCv3sBYEuwx
	 RFDH99pqgq2dIkLN5bP40+ZuQE0lffD/YX9n6bP/PwevzvUsGwBga+kg5Z9JU934M/Efa
	 c5L1wFcck+qGTRHw2uBrYNyChB2GVtqfhD1494OedvDblETj1NYoPtuCZsbdD5eN2vN1o
	 E3yzsMKNde3m4idiooj7l4qIOHAPNSl8vYC1XNXw4q/zBreC0JaDC9G6rm2A8B8wuVCQp
	 fcyRSKua2RIZQAfHnA8r/437eEDv6JtP+kLlJcpKsNnz0bmUPqwGVVdPMNRnnXrXHcQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792570106;
	bh=6F+YIKc5R3x9GDGHjzgHmzTBjoMOLAxRuaE+B/mAA48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oT8wVc80NJrGI6WKCf1LoePDbJHBq36xr1vK2Gws1kJPPpCsbY5FX1rJdrFf87Q0k
	 TxEol/sGTDNvx63rlg4IGB+QIKv/ZCNmCVJRvJ+HIL8Qi5X2zcPHMuUuQ+f/IHpTfB
	 /X8aIsAZqKGmhTCqEyOzCfNtS3jmjyaT84BdFppBcHXgotB7kWCeNbzLRsFOhn+59Y
	 5FGEbyd8cafZomTn76lQlh9mB4DCe98jD+y5P3B5n22j7lZQDkPZwCgmvRzcsjbBjZ
	 xTxA0mBTSbKTR5HgkQFK+VonAlMRogzA5hXJVpcmjG+vRs2BLobXJfsaLjRvuCf5RC
	 PF0SN8Kwi3WvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 145C981155;
	Wed, 21 Oct 2026 08:08:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E02B7995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D224740050
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7cZ9ZsUEZCO for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 08:08:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 98A6D40060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792570098;
 b=QKJMKRPqXA356WuQkvRd+Bj/hMI3O6zru3pAxJVQuacNciFYjOXaPjYLeCnumApAsaEW
 d/W0eGlyZ451H9YOqbT7WYndKI++tZ4af/e5t8CHO2lG+AMvaHzUs9tCVnrcDL6W6nU/m
 1mDBTt61Dui0su/LwwbejaE4++dUEwSmnfcadihUJEcbXKQabgTI82a5tgb+59ImFRIr/
 VjV7ghjjs+X+JLIA6cJKOtz3xNijkETR/gZYiQoISP3vuP0rxOxk9ZPkXJHp04fNKkSKB
 r4d3bu+ftPq+Ro47Q5uS+cXkb85vZt7KiIpCg4O/eui7PwXVFvyqvzVld1pF79ctxDQ==
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
 bh=6F+YIKc5R3x9GDGHjzgHmzTBjoMOLAxRuaE+B/mAA48=;
 b=CPc5Ra1UReyiDvTHUhOO4pG4onNNrE6+o4BujQlv+512lUH1/CPJzPb9Loqh86rlOwCr
 hBC18T6iEXxDofBknbEsNMZOPf3SfbLdC40JyUlj6HNWlyE34xnTj5mFd+amd33pzkZxL
 GDqiuok3Uqu4lldprb9CUj45va7/wV5SxSHDmYI+4uVGp53SIZK2WVBeaUP40qZxxygbP
 yCiYNPcqSX109y3v6ycva3Ps26jdP9xzH48k1xbVRA0WrfHiTWsyKYN5f800mtJK12QAe
 E5Kg6puchFXU9Ty2qS27daMuVwyqkDVMF00zGcbr+oKm89Wx/G576Xwp6mEE852EcOQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=nokia.com;
 dkim=pass header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=SgzXe1kD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=SgzXe1kD
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98A6D40060
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 08:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuJdlidnXAptP1MohDw0XpOlo5pJdAVOEIndMPS9q0Ha0jVekLnzDtiEUb1qsp5h1ByNn8IUuaQLQk15DCB5ECY3CR4eWROs6CfbBptJiA/jThKKHyuzmRD8y7xfit0mut8WaOWBnIB6NBi/hueG0NWuhTTgKOpub9PzkIoHtH+FW7t91cUHMgsqeIrXqaac0yQtCQsE3vUdCEYsOKHWt5FZsAFg5eMjCgLL5+9c715SI+nvAaW0eDCRwS/nzYWma5nr/5XQZ2neKcXVBsMSrPIYxPDoQqHIdVPQ1vyuH0UT+nBDvq3Tc0yyM88suJWDHIfBVZgk/RuL16FH/D3K2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F+YIKc5R3x9GDGHjzgHmzTBjoMOLAxRuaE+B/mAA48=;
 b=WEZlpt4EVg/rPY53GuCC4VhQ/UNks/xW27F2K9YdMU/As99tOCXL52kUwU+GRx+lHC3DU72LP3F0R+y1/wutunEMFweDzP6pOsaCgNP3gnlJyaIbDfUTsNztAYlfJZ1/mfbVZX+niRxVOvDvdu+OYRggsrOwxlWBDD9Pz3lwpSKydJJ4hITFXaVLGhSptjSv2pTj24zyBDow+EHJqA9LAzRG3576MiuoD2p4XmwmuKA7BtIfG99+keQ8oXRzEBMW5/4Vrh/2kjzkOy5EcwjQq3SRTm6ruxifnQy7DdXpQ04cnukm96Ogtx1I+GtEBj67g7aAMXJ5aSvK8zxCIsyyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F+YIKc5R3x9GDGHjzgHmzTBjoMOLAxRuaE+B/mAA48=;
 b=SgzXe1kDyKYTl9hfa2hiXMM2aYJFnNmQBrVwzpoknV7mBg79q4Sbc9rak0NSwVB9DTMt6Be+KLS7clbirzzMuSbKX/wLej1RV2xzc8BFtgfijSnJY1HnOsZIIMVPfDbBegrqIsBkYqf/DbKrnVGqPCCES6XC2pvhOdLTGwLJjtMkfEUO3K6VhoeoEoxu19NVvFp9JqVUOrR5m0lN4RSXnMlZm8RxgALSfsu5tYFvOwJ5+f6iFzuUBSoG3taVGn63TjngoJS64b31a8Y7yq0eiWP7VBgWLUN6OTQ9dd2F5BooYVtTFjDdZpqOTW2ZhLILwUdXc9hL41w8piGme1pHGw==
Received: from AS9PR06CA0289.eurprd06.prod.outlook.com (2603:10a6:20b:45a::29)
 by PAXPR07MB7951.eurprd07.prod.outlook.com (2603:10a6:102:13b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 08:08:11 +0000
Received: from AMS0EPF00000567.eurprd02.prod.outlook.com
 (2603:10a6:20b:45a:cafe::3b) by AS9PR06CA0289.outlook.office365.com
 (2603:10a6:20b:45a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 08:08:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 131.228.2.20) smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS0EPF00000567.mail.protection.outlook.com (10.167.242.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 08:08:10 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 5B002200D9;
 Wed, 21 Oct 2026 11:08:10 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Wed, 21 Oct 2026 11:08:15 +0300
Subject: [PATCH 7/7] test: wdt: add tests for wdt_get_timeout(), wdt
 gettimeout and warning print
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-rinta-watchdog-gettimeout-v1-7-e7f3157b8bab@nokia.com>
References: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
In-Reply-To: <20261021-rinta-watchdog-gettimeout-v1-0-e7f3157b8bab@nokia.com>
To: u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Yuri Zaporozhets <yuriz@vodafonemail.de>, 
 Jonathan GUILLOT <jonathan@joggee.fr>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792570090; l=3525;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=uMRpt/RYKcMCR0f1IzQ0MtDetFgKy8DyhYoM7IDXBE8=;
 b=4oPapWytc37O2k/o1yhL253FtA9K9AF6We5tVy4QSLgXo4C9Fy7b9KTyO8qpyIgQEvV2DPYZl
 fUz72IzVpAUC6lQkL5+xBshUJpydc2dRt4SpwDQ4RFFcxCpVrl7YoGm
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000567:EE_|PAXPR07MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: 76805aa6-87c9-4922-3c80-08df2f4a72d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: /e/ukpU6cWyHb9oPCezIKrhHxyMiK5JPamCsRQv+85N5RQ/We/7wCCWTe5BkWS0n1kOnjWrOxn7z31uGtHIS48x//OOv2VLJNZ/iNlBdWQ5S+/QKOVFZUgJgMcfX3xHQ97w8g64FJDFJuKR/uYrEAwqOnrgoj/yDGUUM6reLUjfrzbjg2DvosZoH6kCxX3jkbEBzME7s16raA12BpehoN1gtsuAE8EyYz0BAfyAbNoqh/nyUXjbD8CZn2S+9MGB1JfRe1iA8Dw4N9Na7jcotqNxwdEC2fBuyHgDf0MMF9QpBQu1nQy54NBfx3HKgDAY5bt3TqlzD/mfwp8soAZhl9yM6UAowRyUnjA7Wp3MvQYiEW1Wiuvbp6+hkYSANLMtA5aFEgG4uQvlIQx7axkgq01lyuNMQ79P7KYZ7Er70bqC9bkBKyOMY6fsjyFftJkWvzJsggU3vJDXUb9PcEwRilNxG2yfZDdPelfllrJzMOJ4R5JRA6KW8ipjVJ5kDk/ZOVlTBLy+qYG2EpoDhXRZf13NkanfdunDAsKFRdXHHk10wgpCipPYsG5/zeCJOl+MBtvsKat1Ca79UO8AwUeorI80n5moLBopDyIlmubEjnX+M0BKqkX3niIls+w74JzSG7i2o7HtgxlGYUniNjSOjsFVd/Mq3XU4iykG42nV3MeYZgp7RX6dC2ANlb4Lurd4B5SjOxCqf4t0lHVfKgnzIYw==
X-Forefront-Antispam-Report: CIP:131.228.2.20; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mqVkjuJL4E4IsrAnaMQJaUBFAQexIcFEru336sfZN3Vi+EFvK4a92FQp3GfcKf39+pRwcMCEAGDUsnCHF8PHQTcaYYAmZh/2fD/Cm/uuXVJpHeijQfGMEfajBBGWcz0PQi5+vTul2Vewa5Vatjg5rqTenUF3f593RGMOgYZslF9VxeJzbqOee9qjPeTG7Qen8jznTDyrSPE9HxhS3kKDI3XIpqcg4GhmdFC5WQJSAD6c26mucloRlfIb5SN/giF8Nq96PMi0R9C+0MBjDVDb0wXGLy+Ux3CXQwhaFnrpEvYqHNEpLw7Y+Shu1Vr0QOi3MIBqmMhvqSZgqdL8HfPISnl+juMJ9kHkRDKxxR6cULQGvdgwoqzkrHVOkRfPgemwotvfoiIPgqW+YTLt3s635jnQ+r9wcletBCO0kYl/8769t/KbwU8T/PoAXDhFd7iB
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 08:08:10.9714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76805aa6-87c9-4922-3c80-08df2f4a72d7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.20];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000567.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7951
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test for the wdt_get_timeout() helper and the subcommand
wdt gettimeout which exposes this helper to the shell interface.

Add a test for the warning print when requested timeout is shorter
than the servicing interval.

Sandbox driver tests the success-path and the not-running case,
and GPIO driver tests the not-supported path.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 test/dm/wdt.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/test/dm/wdt.c b/test/dm/wdt.c
index 2e9d641d6bb..38c488db225 100644
--- a/test/dm/wdt.c
+++ b/test/dm/wdt.c
@@ -25,6 +25,7 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
 	struct udevice *dev;
 	struct wdt_uc_plat *plat;
 	const u64 timeout = 4000;
+	u64 get_timeout_val;
 
 	ut_assertok(uclass_get_device_by_driver(UCLASS_WDT,
 						DM_DRIVER_GET(wdt_sandbox), &dev));
@@ -68,8 +69,42 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
 	ut_assert_nextline("WDT:   Started %s with servicing every 50ms (%ds timeout)",
 			   dev->name, SANDBOX_WDT_MAX_TIMEOUT_MS / 1000);
 	ut_assert_console_end();
+
+	/* wdt_get_timeout() helper */
 	ut_assertok(wdt_stop(dev));
 	ut_asserteq(false, state->wdt.running);
+	ut_asserteq(-ENODATA, wdt_get_timeout(dev, &get_timeout_val));
+	ut_assertok(wdt_start(dev, timeout, 0));
+	ut_asserteq(true, state->wdt.running);
+	ut_asserteq(timeout, state->wdt.counter);
+	ut_assertok(wdt_get_timeout(dev, &get_timeout_val));
+	ut_asserteq(timeout, get_timeout_val);
+
+	/* wdt gettimeout command */
+	ut_assertok(wdt_stop(dev));
+	ut_assertok(run_commandf("wdt dev %s", dev->name));
+	console_record_reset();
+	ut_asserteq(CMD_RET_FAILURE, run_commandf("wdt gettimeout"));
+	ut_assert_nextline("Watchdog not running.");
+	ut_assert_console_end();
+
+	ut_assertok(wdt_start(dev, timeout, 0));
+	console_record_reset();
+	ut_assertok(run_commandf("wdt gettimeout"));
+	ut_assert_nextline("Timeout: %llums", timeout);
+	ut_assert_console_end();
+	ut_assertok(wdt_stop(dev));
+
+	/* warning print when timeout smaller than servicing interval (50ms) */
+	console_record_reset();
+	ut_assertok(wdt_start(dev, 21, 0));
+	ut_asserteq(21, state->wdt.counter);
+	ut_assert_nextline("WDT:   Started %s with servicing every 50ms (%ds timeout)",
+			   dev->name, 21 / 1000);
+	ut_assert_nextline(
+		"WDT:   timeout %dms is shorter than or equal to servicing interval 50ms", 21);
+	ut_assert_console_end();
+	ut_assertok(wdt_stop(dev));
 
 	return 0;
 }
@@ -87,6 +122,7 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 	const u64 timeout = 4000;
 	const int offset = 8;
 	int val;
+	u64 get_timeout_val;
 
 	ut_assertok(uclass_get_device_by_name(UCLASS_WDT,
 					      "wdt-gpio-toggle", &wdt));
@@ -104,6 +140,15 @@ static int dm_test_wdt_gpio_toggle(struct unit_test_state *uts)
 			   wdt->name, (u32)lldiv(timeout, 1000));
 	ut_assert_console_end();
 
+	/* GPIO driver does not implement get_timeout op */
+	ut_asserteq(-ENOSYS, wdt_get_timeout(wdt, &get_timeout_val));
+	ut_assertok(run_commandf("wdt dev %s", wdt->name));
+
+	console_record_reset();
+	ut_asserteq(CMD_RET_FAILURE, run_commandf("wdt gettimeout"));
+	ut_assert_nextline("Getting watchdog timeout not supported.");
+	ut_assert_console_end();
+
 	val = sandbox_gpio_get_value(gpio, offset);
 	ut_assertok(wdt_reset(wdt));
 	ut_asserteq(!val, sandbox_gpio_get_value(gpio, offset));

-- 
2.39.2

