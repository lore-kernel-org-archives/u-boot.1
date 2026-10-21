Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E82606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X+00MYJ5;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=h0OwwFxq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D90AB80FFD;
	Wed, 21 Oct 2026 04:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yVg1zKKJR-9S; Wed, 21 Oct 2026 04:01:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B51A280F75
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792555272;
	b=EsHUOm9kK2d8phQVahRo8CZnIq3ZKzwC40xlHCtPwarTgYttR4RiIEQ84/UYYisO3e4K
	 Rio03SKIaFUAJN4SN5NXV79WAQI/fhtr6u4Lo6O6hGHa346tUAPO6Edf+veGe/ublfzBw
	 BMuDWa9OzvSBR5UZayS370x/y63yzP7Mz52qgbVmkpa3+KotyS5lJJ40M2Jpgo16iKzF/
	 +EWmare3rjcjx8bJnJJx6OSGaY/WJnBqAuSbCu3524SX39fNx2KePfcrcYua8N82CXEqy
	 yQlnpB17PQiEPrLWYYrx10kZQPn79TRDgSamlzFv5iCMHSURuyEKiIiXHhV7XR75FZQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792555272;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UuYX6Ts6nBOVTxDGUHyxoqRrBHZ22IG/qHnjIkAsFDI=;
	b=Sgrzdr1pLpdwKSL/W3U9w4XEQndFiOJ466YlGgyXPxTeCmc/Y6lmYAd6MiEMA2MRUAFC
	 tp0pAjJOwzi9J47buuU9dMD0vnWEKvRHF4/5Bxy8t1XJFlF9eHFT+yeAx9CRQVuaPO9qN
	 vE/8utByk+h5KdxOold2nM+EYN400ZkjBYLb6dl0OGzo5gCA5WZ7Owklmx8i3Lfyys1Rw
	 ycNskQOQ6luzwUlZl22elz6NUis9iLw1tfKQKMJFEDtRUB0YwEe1O2u3zOSPso1HDGkt/
	 5b28N2iYrkyZB3LjCykpvsv2ic+th84cB/A+USWDwH/n3oBEa8QCP8Ux1bXqX12TmEA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792555272;
	bh=UuYX6Ts6nBOVTxDGUHyxoqRrBHZ22IG/qHnjIkAsFDI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X+00MYJ55xZaPBNQzRSYYr2Xko8l1fdh0XgSLgNxO2Svoe7o0JnL18nk98PeVNk76
	 uorxP5ST220VOhWKsQORB9Mq6ZCqgTi3yptvDWWhRjBc1QczW/MmJvROVDTG/YB66o
	 QL03n2LX1u/vkbYkNAJG1PVl4tzvxyl4rsmxqvCg3GE4TV3iB7BYfey/KLsm1w0RGC
	 WCz2yNUUfEogP3uF6QwkYFUaWHzLf/1DUg/lyNMn47mcrs0jZ7gktuakXkqgxH3YiE
	 QWdMzP5PVi/kRMPL73Qv+LkA+YTGmkpCDnDGBFcgT0YKj0IuZvsJFwPOWi9oS7+sSG
	 xh3fyLqiJ6EEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B51A280F75;
	Wed, 21 Oct 2026 04:01:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5299C1AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:01:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38B3740769
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:01:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XTSRqIGYk2HZ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 04:01:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F93640765
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792555270;
 b=D0+OwYWRRlDyBO1NZTQip1P+s5kLVHN1W1yZSxbGxfCLz1OymHBmXVRcAZN0HfAT+1Dg
 umVv3Pa3UhSSuyb9TgF7+Kjq3m5WmgakmOIg2O/gz5AxzJ8CNFkvB/Si7wxEeePecBwc0
 fMwVuL3w/KYoNB+2T3KqvjZaLn6Na/WihL0HeodDTsn+6RxAiBZ2OgH7aH91ly03GcBbP
 imBpOJcH4zLYfssP9JXx5VhRSuBegAUK6O1rmgBkEK9IJTyWJ183DHHBdqGypcxdssUh7
 KDr63CFrzarp32LVwbbDfmQI933wPGcy1SRUR/jbH/NXe5Bz8lxRFsp2Sbj6E3GC6MA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792555270;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=UuYX6Ts6nBOVTxDGUHyxoqRrBHZ22IG/qHnjIkAsFDI=;
 b=ZDYYj0kfdLgMHXN+yhqNoDsWCjjEawVcpj1vS0Wvbx+JsjJFP9h25sXGoGzkqPrkLft8
 Eym5mBZV55F0K7DuKjjFuyuVrVxZkka6m8luKuJIHWqIFnaIMLOKgL+PQy+7M7l5zlmml
 TtpTkgEKMpNDbGkdJICYMhhK7v/b41duIGd51vhw8ibGZkt1gsQNmNUHpzMNQqzI2Z2W/
 At8WcIisJxEwhiA+F4NBOVzm9aAQKU3PQGABz/keVwqerUMVJ/Dl/qrMHCmIlvw/iz7ne
 r/vCowRy7oZWAbSxbY+iMM+HOQQNhFXMAfeGtQB2f6HBwpd3nxhxogkxp1RWg1xHceg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=h0OwwFxq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=h0OwwFxq
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F93640765
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:01:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0528844F6; Wed, 21 Oct 2026 06:01:05 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BC118056B
 for <u-boot@lists.denx.de>; Wed, 21 Oct 2026 06:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHybiuE4QW1V8FblArJeycJAE0nqH7KlCFg3M6hZ9FvGRsf94nive8sE0GpikiDlQaf8liooRlRYstSa1T3qPt9+EFT9bjSs9wFg+zTZkIGUoNAMz7QesN7DOic4v61fb5Dbaj9zDfifGfORa++8h/JAqQX1RBnwS6ZV/+Ro5khy4gzOnFW9y0Jb5Hj9w9HK5GB7QD/9XdZ0Anrf2aw/ljdFV465qi8ca/+P76CKA3S7kbyRtVyfNJnpOHWu3OE4X+xBsCOXl8rCdSxhGZoK3bJe47tz6QEVkWA0SKVuaUDeQz9Wv8Ueit1CB795USu0R/6FITU+MurXmdQPBLziFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuYX6Ts6nBOVTxDGUHyxoqRrBHZ22IG/qHnjIkAsFDI=;
 b=wwMO7WCUlRqf9pICSJu1nh1DUXrbDe3/DqMUM/+VmXzJf7T2Jp534EpjvQXvz+wA63UOezxEHmgxuHUzZImqJFrExmkTlg21Y0sBVeb5/kMtgVmIj8qw2esjkq6aKxcBzAhtFeCg/39Ly5fOi7c8JJ5mXJawUfBRGY9P7IEDM+8oGFXCRZ71Fn6Tbs80c9IIjvAC7oYsBsinoITfEHHPnETMNEtUlrWdZ7mmnyWN28DQCU/vyIo1ktoyF5DIr1/zknYpfnq+I35UIbD9g6cvzxgc0OUuVatHspZI2A/JmJFpGHrribvilmXy44f4SWmFdRDTrpzRjtkS1tJB/fXFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuYX6Ts6nBOVTxDGUHyxoqRrBHZ22IG/qHnjIkAsFDI=;
 b=h0OwwFxqSAsyxzEn3I/+vs7DPNd9kIH7W7TX1VOsNJlmSFLOixu/1Vu20Pev/jy3jDZtc3P4HvbVhGaAijxEotf3g7RyeQ9A+Cnphocg9xqCy6nhpT3b7Y+X8mWwd5xD3uvlXvyit+uF41KP67WnnYKot6QTgRGgs+K/Rkldfo53qGAdKoh1QwO4GM/7IBOSRnHsUPX7qN9OHZB/giilH5YjjiMc3wBxGsapkRKgu5wxVz8tNoW3lFuUYZlQwaRplmouFNS1pFltk5X4LA6R7xMVzH8Iqhl/Wg+4laCuYnDk4Ro/Fgafx6hZu7kQ8k0F7jW5EcdIFVUmG63ugEwmwg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by BY5PR03MB4917.namprd03.prod.outlook.com (2603:10b6:a03:1e9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 04:00:53 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0522.013; Wed, 21 Oct 2026
 04:00:53 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Johan Jonker <jbx6244@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v2] arm: socfpga: agilex3: Add Agilex3 SoCFPGA support
Date: Wed, 21 Oct 2026 12:00:42 +0800
Message-ID: <20261021040042.8259-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|BY5PR03MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff2955e-05b0-49cc-0835-08df2f27e65f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|11063799006|261009221227099003|261009221727099003|261009220027099003|261009223027099003|261009223327099003|10067099003|18002099003|55112099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: dqHWTy5U0ThOtn2mRMtZ9ZGfSTzzpAV71gnLQ7UGZdToO6+L2vqZDgcM1VJBAit/K9SFVE/xfcx3+w13ywfkWBpw6+6PtVf+mKVh/Jhv+TCWBg26UDfrdkF54tM3y/Y7F/lCoO/aAxcpCpaqUFlcitOEILsuChtH8q4X/05HeDwbOp7DGeO7DVzCbAH4LHWeT+x2RlN/JmQz93MVK/XRmXbvH/T3hGNoNrmpq4dT4WcayAxb2EcSTrmIxnvzcXZuaiMcZ7zFMp8YnZHx9CcO6hV1dmcBXI21OTLd3k0OeQQG/uXajrEFcS+QQ5ao8dsIwouoktQjUYlNLpcmuUnBlubXmONHyO8NN2mBrU43Fe1/dNM5p4PWiIk08mh+TW+s6fzX7Hj5j4vRTTCVAbAmyp+R/hSX/a/mh+6Y8tI1zWx1ECEjuFr+aAw1VdixJJfEVu3ss8w7oRv7duCDirCtFB90/UrfWaMc4hVHVoZcsxIyA5cDyY7BTOADCaic7WNgdSE/XRcceB8/vzBqGKIe1UPGQDhaiKyNAGv9RmdRD7IhGhB77W7xMsuR/sKFKR01H7Ems/5zSda7+uC8qbHJs/MY8wxFwbLMKJB6gi8TYJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(11063799006)(261009221227099003)(261009221727099003)(261009220027099003)(261009223027099003)(261009223327099003)(10067099003)(18002099003)(55112099003)(6133799003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?teXqvL5a1iijTWAf0Ne9vun38kBPJJ2mei9FK0KCiMuWucIDYXXa+cPYMPDV?=
 =?us-ascii?Q?uQ+SMqK5TbC1vH4ZITbRgsXi1gIegD1rdMjJ5y6Cn/kTT/wIubcm2la4liuP?=
 =?us-ascii?Q?7GymXRjzRD7fglkKQKwrpEgLSvI5TYbuySucz8b0QSvohoQ8MhkvQuFabhV9?=
 =?us-ascii?Q?Gm1+wAxvXvrvwT/rjHd2szlJF35MbyHZJSNDIr+9wMjRSpNxkH0PDk8r3iJ3?=
 =?us-ascii?Q?1w8yJurctRTudBF2yGkyKVj7rf1i/8/QEhQcYtizaIaKd7Qkok0nCX66jwqv?=
 =?us-ascii?Q?sfHR2VFhrxJGcH7zHkODY5oIN/O2djcwRWBkKwPRpwqWnlKHnHyNw28vaFX8?=
 =?us-ascii?Q?FwzzdWlJalnQRojE4PTBIrMObDvJGeQ8WS1XxTT6y7wtKj4h2SM1PlZpncVV?=
 =?us-ascii?Q?yvxNZA0G1nkKtePaeGmrN3NdwXbRS8YuoOs4z7x6u1ChRxiL1owU5bZMr2pS?=
 =?us-ascii?Q?9VExoKyZ50zRMOWlqmbVgY4uiQ88BoGU5LBJUkd1UsHFPUx76mOWqIBX7wts?=
 =?us-ascii?Q?CSTy6FV0hyexbXwk1YGXfecryPqAjofXbMgTQmOMqNvcSYaAeQGaO4zxq9yD?=
 =?us-ascii?Q?WRKnIlcnkWI18M75Ih/JCvQVfOrho0W14rLvGpDMQOGLknc7UjQHG/NK3ccF?=
 =?us-ascii?Q?0qjTKhONQY0xruV9locNTzvDow89C5AiroDzoIuCu0VhvdUAdzUrlfKqxDo3?=
 =?us-ascii?Q?gcLmhsFu8oBpeLLTjO1uHH4E1ZzXjn+WhOsO0KgSoijcQXMnT7ih/MyzPH1j?=
 =?us-ascii?Q?aFBfHRM9lvvWk66IO9uYVF9zqm9633pepV3DBqw05g0ox+sdieieiyIGV3xF?=
 =?us-ascii?Q?P1rNBGSK8Kd11qJ2jD7pJRuGbTyYyLJ1lQ9MQCGZOyUpUMsTbmbPAirvFApr?=
 =?us-ascii?Q?24t2yotkrD0gtM6PJrMkaAur0nlW/46TJfGq3GQh++eZbpsbE/RWgHxjKgNe?=
 =?us-ascii?Q?qQnEYxpYsJ+WRUWyFGOPX/OChsfNRCHjktvt1G5qenI5HL5xIREj2S/CKPaB?=
 =?us-ascii?Q?oiGxLALlfDyXTFX/rZsO4efTMG0f6Hv0DerkdRE41CTMjF0HAvdz9aT/Oep8?=
 =?us-ascii?Q?VY4PSd/S1sj38hD2Man1nImTLXezvZPYXp7JIdaHi8BvU0WB8MdIHvObcfM4?=
 =?us-ascii?Q?QYP2FrjoFGPe/P25bTWYz2Tu/CftS4g/r2iKRkF+pQsuBKNhyWabC3A8kcpF?=
 =?us-ascii?Q?d/L+oP/7ohkXNJ9jzmFNn87B6R0PxrXUUfvL39bXzin2F4eYT+b6SognF8W5?=
 =?us-ascii?Q?D3wMuU8mSzM2TphEdHV3v+0Gn4la5jP9Ye7xGkFDy8paK2FSPTQ4BgdUdVXX?=
 =?us-ascii?Q?phmTToaix5Rubw/+kmU0KRt6tLuXtjDnGohEMTEC13KA44f1eiNDu1sK0QhT?=
 =?us-ascii?Q?VNjofLSACjOFWmQdH4wvcfg9H9wGnk2hz3FQkZNyCCWGmpZBEz+idc8JP7Kf?=
 =?us-ascii?Q?23wGxHyflwNtXnZFH3lnlYf8s/u9ORa6mmQ4DedgP8+ZyMp1EaxYR/rqLWJV?=
 =?us-ascii?Q?nI+58fhUyNH4XwqIAq5NgrQTortsninUzC2UXCK45PNq+AWjyXvoJ5ARKRGG?=
 =?us-ascii?Q?rDLpxBkWwWf7wUX5LNv8gysFKBkjky9M6v380aOd8Da/4nNhQ8GoADBf0yLu?=
 =?us-ascii?Q?NI9wzJAK9ehQeyN1dZcDzv58lqElBO3EfeITRvYJiTMbnLcCB4vCGC8WzEFc?=
 =?us-ascii?Q?kB2h+cU3ZNhWK/z3Yq17VoEZi8FQE7K+6aejSnHvrXnCViG/lqpL265EF1jH?=
 =?us-ascii?Q?kTpbU1PueUAjXFMxtHYRldY3Uc/IGVc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff2955e-05b0-49cc-0835-08df2f27e65f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:00:53.4834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8NX6N7EuOI06gncAb/fbW+4huvqA/FA+Thggsrn1W7jNEzveU4fWSNNIO8RlJro4gEpeHFmvKY4DJmCCnYUNwuL+XXmTwbDm8SWovi8m8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4917
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add initial Agilex3 SoCDK board support based on the Agilex5 platform.
Agilex3 reuses the Agilex5 SoC DTSI, U-Boot DTSI, and defconfig, with
these board-level differences:

- Ethernet uses GMAC2 only with a Micrel KSZ90X1 PHY. Agilex5 enables
  GMAC0 and GMAC2 with a Marvell PHY
- QSPI map is 12 MiB u-boot + 52 MiB root with U-Boot offset 0xa00000.
  Agilex5 uses 66 MiB + 190 MiB and offset 0x4000000
- TARGET_SOCFPGA_AGILEX3_SOCDK is added with an Agilex3-only config
  header that uses the 12m/52m QSPI layout
- MMC enables SDR104 (sdhci-caps-mask) in the board DT

Series-version: 2

Series-changes: 2
- Move Agilex3 QSPI bootcmd to board config; restore shared SoC64
  BOOTENV_DEV_QSPI 66m/190m path
- Add TARGET_SOCFPGA_AGILEX3_SOCDK with an Agilex3-only config header
  that uses the 12m/52m QSPI layout
- Use rgmii-id instead of rgmii
- Restore LPDDR Inline ECC memory examples

Series-links: 1:515644

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../arm/dts/socfpga_agilex3_socdk-u-boot.dtsi | 185 +++++++++++++++
 arch/arm/dts/socfpga_agilex3_socdk.dts        | 222 ++++++++++++++++++
 arch/arm/mach-socfpga/Kconfig                 |  11 +
 configs/socfpga_agilex3_defconfig             |  10 +
 include/configs/socfpga_agilex3_socdk.h       |  33 +++
 include/configs/socfpga_soc64_common.h        |   2 +
 7 files changed, 464 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex3_socdk.dts
 create mode 100644 configs/socfpga_agilex3_defconfig
 create mode 100644 include/configs/socfpga_agilex3_socdk.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f082b6..9a8ce0bbf7e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -416,6 +416,7 @@ dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
+	socfpga_agilex3_socdk.dtb			\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
 	socfpga_arria5_secu1.dtb			\
diff --git a/arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
new file mode 100644
index 00000000000..0e624db5fa0
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex3_socdk-u-boot.dtsi
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
+	 */
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&service_reserved {
+	reg = <0x0 0x80000000 0x0 0x2000000>;
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	bootph-all;
+};
+
+&qspi {
+	status = "okay";
+};
+
+&nand {
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/socfpga_agilex3_socdk.dts b/arch/arm/dts/socfpga_agilex3_socdk.dts
new file mode 100644
index 00000000000..26e55a41f94
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex3_socdk.dts
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex3 SoCDK";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet2 = &gmac2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 20 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps1 {
+			label = "hps_led1";
+			gpios = <&portb 19 GPIO_ACTIVE_HIGH>;
+		};
+
+		hps2 {
+			label = "hps_led2";
+			gpios = <&portb 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i3c0 {
+	status = "okay";
+};
+
+&i3c1 {
+	status = "okay";
+};
+
+&mmc {
+	sd-uhs-sdr104;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&usb31 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&timer1 {
+	status = "okay";
+};
+
+&timer2 {
+	status = "okay";
+};
+
+&timer3 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
+&nand {
+	status = "okay";
+
+	flash1: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0 0x200000>;
+		};
+		partition@200000 {
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
+		};
+	};
+};
+
+&qspi {
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu02g";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x00c00000>;
+			};
+
+			root: partition@c00000 {
+				label = "root";
+				reg = <0x00c00000 0x03400000>;
+			};
+		};
+	};
+};
+
+&gmac2 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&emac2_phy0>;
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		emac2_phy0: ethernet-phy@0 {
+			reg = <0>;
+			rxc-skew-ps = <0>;
+			rxdv-skew-ps = <0>;
+			rxd0-skew-ps = <0>;
+			rxd1-skew-ps = <0>;
+			rxd2-skew-ps = <0>;
+			rxd3-skew-ps = <0>;
+			txc-skew-ps = <0>;
+			txen-skew-ps = <60>;
+			txd0-skew-ps = <60>;
+			txd1-skew-ps = <60>;
+			txd2-skew-ps = <60>;
+			txd3-skew-ps = <60>;
+		};
+	};
+};
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index cfb66aa1305..a9b7f056b49 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -197,6 +197,14 @@ config TARGET_SOCFPGA_AGILEX5_SOCDK
 	bool "Intel SOCFPGA SoCDK (Agilex5)"
 	select ARCH_SOCFPGA_AGILEX5
 
+config TARGET_SOCFPGA_AGILEX3_SOCDK
+	bool "Intel SOCFPGA SoCDK (Agilex3)"
+	select ARCH_SOCFPGA_AGILEX5
+	help
+	  Support for the Intel Agilex3 SoCDK board. Agilex3 reuses the
+	  Agilex5 architecture select and board code, with an Agilex3-only
+	  config header that uses the 12 MiB / 52 MiB QSPI flash layout.
+
 config TARGET_SOCFPGA_ARIES_MCVEVK
 	bool "Aries MCVEVK (Cyclone V)"
 	select ARCH_SOCFPGA_CYCLONE5
@@ -280,6 +288,7 @@ endchoice
 config SYS_BOARD
 	default "agilex7m-socdk" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
+	default "agilex5-socdk" if TARGET_SOCFPGA_AGILEX3_SOCDK
 	default "agilex-socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "arria5-socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
 	default "arria10-socdk" if TARGET_SOCFPGA_ARRIA10_SOCDK
@@ -305,6 +314,7 @@ config SYS_BOARD
 config SYS_VENDOR
 	default "intel" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX5_SOCDK
+	default "intel" if TARGET_SOCFPGA_AGILEX3_SOCDK
 	default "intel" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "intel" if TARGET_SOCFPGA_N5X_SOCDK
 	default "altera" if TARGET_SOCFPGA_ARRIA5_SOCDK
@@ -331,6 +341,7 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "socfpga_agilex7m_socdk" if TARGET_SOCFPGA_AGILEX7M_SOCDK
 	default "socfpga_agilex5_socdk" if TARGET_SOCFPGA_AGILEX5_SOCDK
+	default "socfpga_agilex3_socdk" if TARGET_SOCFPGA_AGILEX3_SOCDK
 	default "socfpga_agilex_socdk" if TARGET_SOCFPGA_AGILEX_SOCDK
 	default "socfpga_arria5_secu1" if TARGET_SOCFPGA_ARRIA5_SECU1
 	default "socfpga_arria5_socdk" if TARGET_SOCFPGA_ARRIA5_SOCDK
diff --git a/configs/socfpga_agilex3_defconfig b/configs/socfpga_agilex3_defconfig
new file mode 100644
index 00000000000..f4963967f7b
--- /dev/null
+++ b/configs/socfpga_agilex3_defconfig
@@ -0,0 +1,10 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+# CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK is not set
+CONFIG_TARGET_SOCFPGA_AGILEX3_SOCDK=y
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex3_socdk"
+CONFIG_IDENT_STRING="socfpga_agilex3"
+CONFIG_SYS_PROMPT="SOCFPGA_AGILEX3 # "
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x0a00000
diff --git a/include/configs/socfpga_agilex3_socdk.h b/include/configs/socfpga_agilex3_socdk.h
new file mode 100644
index 00000000000..ec9878355b0
--- /dev/null
+++ b/include/configs/socfpga_agilex3_socdk.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ *
+ */
+
+#ifndef __CONFIG_SOCFPGA_AGILEX3_H__
+#define __CONFIG_SOCFPGA_AGILEX3_H__
+
+/*
+ * Agilex3 QSPI layout is 12 MiB u-boot + 52 MiB root. Override the shared
+ * SoC64 66m/190m bootcmd so other boards keep the default path.
+ */
+#define AGILEX3_BOOTENV_UNUSED(...)
+#define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
+	AGILEX3_BOOTENV_UNUSED(devtypeu, instance) \
+	"bootcmd_" #devtypel "=ubi detach; sf probe && " \
+	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
+	"setenv mtdparts 'mtdparts=nor0:12m(u-boot),52m(root); " \
+	"nand.0:2m(nand_uboot),500m(nand_root)' && " \
+	"env select UBI; saveenv && " \
+	"ubi part root && " \
+	"if ubi part root && ubi readvol ${scriptaddr} script; " \
+	"then echo QSPI: Running script from UBIFS; " \
+	"elif sf read ${scriptaddr} ${qspiscriptaddr} ${scriptsize}; " \
+	"then echo QSPI: Running script from JFFS2; fi; " \
+	"echo QSPI: Trying to boot script at ${scriptaddr} && " \
+	"source ${scriptaddr}; " \
+	"echo QSPI: SCRIPT FAILED: continuing...; ubi detach;\0"
+
+#include <configs/socfpga_soc64_common.h>
+
+#endif	/* __CONFIG_SOCFPGA_AGILEX3_H__ */
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 4d333c63ad9..86fbdbccd39 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -72,6 +72,7 @@
 #define BOOT_TARGET_DEVICES_QSPI(func)
 #endif
 
+#ifndef BOOTENV_DEV_QSPI
 #define BOOTENV_DEV_QSPI(devtypeu, devtypel, instance) \
 	"bootcmd_qspi=ubi detach; sf probe && " \
 	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
@@ -86,6 +87,7 @@
 	"echo QSPI: Trying to boot script at ${scriptaddr} && " \
 	"source ${scriptaddr}; " \
 	"echo QSPI: SCRIPT FAILED: continuing...; ubi detach;\0"
+#endif
 
 #define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
 	"qspi "
-- 
2.43.7

