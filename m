Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D47C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 04:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95C9880B9D;
	Tue, 15 Sep 2026 04:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LlxBpQoBjIQm; Tue, 15 Sep 2026 04:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AFC3180C23
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789445857;
	b=s/R90HObZNZBtuip7/WGFchQNEXYThS81df/gKshY7cave6HYcP8GOAiUS3X56NIF+MZ
	 vsmiTeYpuVwwY9eyG+gV6qu8GDeNp8nCynD+0aVLxDtlzZOZbrmQ7kEQuUerxgBVR3e8n
	 +0MzRygV/J6xnobXrNI6sQkLfSgla6bFbj+Pb0eFIPyDv9pP3lMRILK7kqHoDdp9PlnoJ
	 li7iHkXIQRXBbcYRNHjfdeu1cGIf0KIdpUWZlnE88X/NLSd71ZcO4Q9sJDmEhA8Or/iNz
	 WMfZnFaPp6n9SFg7V4j9mFnjFBcahBGB8LxjLIDIfeu9GzCv6LPEAp+1EfilEzSdKLA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789445857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=RSFizhuQn1p06hwnipQFPHYKf+7U8eap22K0sPu4KnM=;
	b=RuUX/vI8cGz/Aj+VaSB+eOnwxNX3LSx4HGIKhRgZkyNYtL9apfdV4J6mGH5Uxa4+vzcU
	 ROZNIpCco5wf+jWwoOSeXfDXHmIM0tv6ETIxpz2cQEU9U4feP/S8MCsn0fleyVa0o2c/4
	 OyYPdb4IoEP+/LWKW71hk39W77Fr3hESsHtDQUimPH0XRXPXUHVsl4K2NcEX7Kv2RZs/Z
	 dAwPctwexhNiM7AocOijg21RqN/ViOkELyOhmyVSEXxvtt3mpNjTotfYfe6R5pQyf4dku
	 1VegFe+YmkPopswqppGN0XYGBA67QZKUr8xk4krAtLfOJSZps+CcDawn7sBSDRVRRHQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789445857;
	bh=RSFizhuQn1p06hwnipQFPHYKf+7U8eap22K0sPu4KnM=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K35xLVYqDKzFpaBCrX1T4gFtRde5zZGMRrR1eBU+jAq1CM03N27p3dVQm8f2ntMl3
	 +X6iysY5VRQrL7VxUw16HS6goYbsctfW3LGqs00CiULb6XDBFBdg4lzF6LR+GCxX8V
	 xcfgW/cq3rOfIeWHzYM5MV3WOEjfKW3nPleOtpAZBfCtxMV93FSrJhy3Yk7CpuVjbg
	 XjwDHIib8+OTcJEUxubBdKFm+iiizfinou1fB18oxqyPYzq1HkrLKM5B4Y6VcNnP7f
	 1Ay2VYH09QXaIMeAZ+Eobqe1TGsHUfSQdkKVpwweXfXeuv5UpINwpLaqrlpQtkuxy5
	 SrJztltLkz8Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFC3180C23;
	Tue, 15 Sep 2026 04:17:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E864362
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 840FF400D0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gTGJFH0Xtvv1 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 04:17:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 42F8240082
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789445855;
 b=auLipJVN5YCNkAQU2k4D8mRpz2Ik/Lop36e6LUW0XkR7cfs+ON0ZB4HmTNNxKyqnkNvO
 Hsz6ObQ2lpXNV8/E/eLd/oLTrNWSiooQN7Jg+jAGc41VQ5TKAbvlV3W7KLepGndPgxHcp
 BJUBlPjfAd1bu06xamSD5kpyuLmJNl9IcshNpN9uJ1uGbanAYgZDQ5yrgWZocnLRPpvtd
 yYPG02/Tpp+kC5ji1/uIfVNEIim9YLP+2PGnJLr10tm/xkB852LsgNcZHUP02AjVo15m+
 AN+z4ZRiBrUNQe2qNITkBlfNDn1fteRnowihK3D3aUssmfuhp6O1wAKo2x8QqnEufgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789445855;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=RSFizhuQn1p06hwnipQFPHYKf+7U8eap22K0sPu4KnM=;
 b=F9NeU90/ezc/tReRglAGdnP0vvh262DDK2ozcPb5+xk1/+doPyMERDeDzhwWcx0Jjn1p
 xsS5EmysJZEbNJ+/qewHMHi2h0S/Azc9VsLY6llDONzpvsvdljvEt6UdKj6z8Tbk5f5S7
 Bb8ELVyExmNlqN93aXCqjHDoWVuC0siUeVJ5KP+eXFKSK6CUMDpNQawfsrYZt9afeixgf
 vthpHbTUZEq5s+nEWAvnUM84j++EdQutT00ACHUqWYCzHQwl5d1bcuv/ZsRGWA3mPW+vT
 /2GVNxEk6qv95u41j3HPjxxW2jIkFaTHB7z/fyexdOEUN6FFhhO+xcOlh0L+HH7Il4w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4g7Yyyv5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4g7Yyyv5
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42F8240082
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2rbLJdW0KPda4QQUjMgaUFNSLx9+QVap8f6i0czHTM7N/P/dNRZmt/xl55jbUkQDOTs+QRoCOkAKJvEX3iFZr5CuHBg0quVWehoCaDAQVLNeH94/GAgiXy7ob4v9axooBlXSKU9w+dlGERG06KEKjS1BaIS3mSAUiMAlUKf7wwFs5zGR2ozQcP3TnIULDQYXWozYrxJp7Hs6HTyHgJwJ6ODOCWPLhs/CDNA5PKU+tPAknUGqgK/J5qkXzK1WvFcNXTl6TxFrFwucnkcqksVgNZHY2vr/1rp7JI6rJmPd1fZ7H3lXSTL4zPp+iL7ddNhoxgTYNDwYv4c+69V6nesCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSFizhuQn1p06hwnipQFPHYKf+7U8eap22K0sPu4KnM=;
 b=UBjk0dwL9VwLVBZv372/L7NGw9kmO0y4RGs+22w3JHLcDHsXgubzkzVAfn2UYD9GrAknXTENb75i6LP3jiKNGSvolwVZl9qN+BqPvV8Qggx029BnWHmpS2E9ZWXtZrRGcL7zf03BHdcWifueQjlTRpss6UhzTRohhYvFm4nL0J7Yz0XFEPaanfEjNKk9eX7AGzF64rbyywI1XCvG7pB6xT3aGtokxINyfOmq5Fiw6T3Jszx8P2FzSHCfBd+xOUO8ByvP4/EsLXeKJeA3H5nRN8DJWE5isJxVmP4com3x9gZfKq5EIiQngnxAlQHMuo1IFIuT472OhG0Iacde4GG4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSFizhuQn1p06hwnipQFPHYKf+7U8eap22K0sPu4KnM=;
 b=4g7Yyyv5mFSisY8um/SzYza5wxCi6YAXHA+LALfRg7Cm85gUetVizPT6FAOdpQ2ccmAFESzD3xggb25NRgQ5aFUld+G1FY9CQKuQIuo3jlKfZVdWxGJliG5btDB5+Ol5/RDXqrJBV8czNEmD4KWAYv9hIOUj87c8Eef8byIOaCo=
Received: from SJ0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:a03:3a1::18)
 by SJ2PR12MB7866.namprd12.prod.outlook.com (2603:10b6:a03:4cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 04:17:28 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::80) by SJ0PR03CA0373.outlook.office365.com
 (2603:10b6:a03:3a1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 04:17:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 04:17:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 23:17:25 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 14 Sep 2026 23:17:24 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH] pci: dw_amd: Enable CPM6 host1 and quiesce interrupts on init
Date: Tue, 15 Sep 2026 09:47:17 +0530
Message-ID: <20260915041717.1956044-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SJ2PR12MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e49e29-8b27-4d07-e6cb-08df12e04059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: x4oLtsr0SQrRbbNFf7UEGBKkxeBpn/ogWkVU1ondMVG7B+ZUDOOT6w46hV5UD2ovDQ3uuz5CPVveufAjKt0B9fwrfwqXtiDPJP/VBcgYBjNS97jP1RvDUc5sEoJyCbT8fTp5uY4X7/iG3UN9QDkr2Kq12VIeMROBMi0gB55itNYgPKZa4kYg3sRmMUUOQlYY2xrFRgb1mch87AGLf+LfHg15iVSJoU9n2HU8jOCIXU16I4DtZi68aA5W39oi1Xaa2JjQ6k9OvqqqPd321BUOZZHdpVNFIwv+lW6qAz4RSz5nTXiadu+vS66v+lk9K9NadJ+4gQWNvNTZ0vpGyaSAPoeNSKTUR3AslI4MI+v34aF66SUy7J+SZ2NazehQxkCQuQkgkRgJrq30LB0DyMBXqn2TTyspJEBqliBPpguWXHHBKNkMzx3nkflh79FdLeUzlOdSguatjjojKPxJjGTnMtd6HyEIn1R5HNwYMRPzw38vcVv+hf8nP4lijhPN7uY2V4KEZv8EsQbvL+/sFs7wZqqh8HecYCW95zT4Q8bMV5NnV93Rqnpsz9tn7m6zpK0N4pLhI48hYsw7p6wJJM8emRqXoymiBMddEGGBIovD6m8oGtafES1+4xcZdqFKFMkf1a8fjaQlLlMEjKvUhw9/qQB9Zbueo5o7SSxcjXDrejVQWoJQat5EA7LoIa6vKXWuozUSb2Kl02xTu7lufpJfSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hXxEnnP5hPcMhQ/biOg8LFqEbtZyHdki4wconTCO4YGJSlKthwYmEpjQAl3lpJN3T/iR5HBcpt6/mxPa8yodKI17rZT3kvT9rbkK561JjsbFhYgDUOIKrNo18Pxj1hx0j6Fpg6Npw4AR1wDgKrdj9jCx3wxNphJi8SLGAEgFUrb+iE1vhZtn5DH/zPkv0vMrrluOwnRdrV0rrFQt4meJpyOJmD+YsZBp+wm86hQx3UFLAiU+8LDFsSSXqf0xV2ZibY4XKZh11reuBQf6WANEsrH3o6FKI153WVB3h9Yy9GlEaOdBfDR5ic2yDr27dHd3gVJI9fteW/CQA+AW6rN6q4DPBqnXlEBi4JhAmDDb0qo0XYZjuSTjX4uldbeP8VrVT5id1sQp86yq3azTkF5beup9RVlo7/jftxpMysq9/Q4l0Xvkik0ARt1pU/HikWTL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:17:27.0157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e49e29-8b27-4d07-e6cb-08df12e04059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7866
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

Add the amd,versal2-cpm6-host1 compatible to support the second CPM6
PCIe host controller, alongside the existing MDB5 and CPM6 host0.

On init, disable and clear pending interrupts.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Message-ID: <1d855c8127c24e3423e62671a4a5c08a9e4a6e32.1789111144.git.pranav.sanwal@amd.com>
---
 drivers/pci/pcie_dw_amd.c | 116 ++++++++++++++++++++++++++++++++------
 1 file changed, 98 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pcie_dw_amd.c b/drivers/pci/pcie_dw_amd.c
index 944458e668c..9e545d6ec7e 100644
--- a/drivers/pci/pcie_dw_amd.c
+++ b/drivers/pci/pcie_dw_amd.c
@@ -19,14 +19,23 @@
 
 #include "pcie_dw_common.h"
 
-/*
- * SLCR (System Level Control Register) Interrupt Register Offsets
- * These are relative to the SLCR base address from device tree
- */
+/* MDB5 SLCR (System Level Control Register) interrupt register offsets */
 #define AMD_DW_TLP_IR_STATUS_MISC	0x4c0
 #define AMD_DW_TLP_IR_DISABLE_MISC	0x4cc
 
-/* Interrupt bit definitions */
+/* CPM6 per-host MISC_EVENT registers, in the separate "intr" region */
+#define AMD_CPM6_MISC_EVENT_STATUS	0x514
+#define AMD_CPM6_MISC_EVENT_DISABLE	0x520
+
+/* CPM6 shared aggregators in the "slcr" region, common to both hosts */
+#define AMD_CPM6_PS_MISC_IR_STATUS	0x340
+#define AMD_CPM6_PS_IR_MERGED		BIT(21)
+#define AMD_CPM6_MERGED_STATUS		0x648
+#define AMD_CPM6_MERGED_DISABLE		0x654
+#define AMD_CPM6_MERGED_MISC_EVENT_HOST0	14
+#define AMD_CPM6_MERGED_MISC_EVENT_HOST1	17
+
+/* MDB5 TLP_IR interrupt bit definitions */
 #define AMD_DW_PCIE_INTR_CMPL_TIMEOUT		15
 #define AMD_DW_PCIE_INTR_PM_PME_RCVD		24
 #define AMD_DW_PCIE_INTR_PME_TO_ACK_RCVD	25
@@ -45,6 +54,8 @@
 	 BIT(AMD_DW_PCIE_INTR_FATAL)		| \
 	 AMD_DW_PCIE_INTR_INTX_MASK)
 
+#define AMD_CPM6_PCIE_INTR_MASK			BIT(22)
+
 /* DW PCIe Debug Registers (in DBI space) */
 #define AMD_DW_PCIE_PORT_DEBUG1			0x72c
 #define AMD_DW_PCIE_PORT_DEBUG1_LINK_UP		BIT(4)
@@ -58,31 +69,88 @@
 #define PCIE_RESET_CONFIG_WAIT_MS	100
 #define PCIE_T_PERST_WAIT_MS		1
 
+/**
+ * enum amd_dw_pcie_version - AMD DesignWare PCIe controller variant
+ * @AMD_DW_PCIE_MDB5: amd,versal2-mdb-host
+ * @AMD_DW_PCIE_CPM6_HOST0: amd,versal2-cpm6-host
+ * @AMD_DW_PCIE_CPM6_HOST1: amd,versal2-cpm6-host1
+ */
+enum amd_dw_pcie_version {
+	AMD_DW_PCIE_MDB5,
+	AMD_DW_PCIE_CPM6_HOST0,
+	AMD_DW_PCIE_CPM6_HOST1,
+};
+
 /**
  * struct amd_dw_pcie - AMD DesignWare PCIe controller private data
  * @dw: DesignWare PCIe common structure
- * @slcr_base: System Level Control Register base (for interrupts)
+ * @slcr_base: System Level Control Register base (IR block on MDB5, MERGED aggregator on CPM6)
+ * @intr_base: Per-host interrupt register base (aliases @slcr_base on MDB5)
+ * @version: Matched compatible variant
  */
 struct amd_dw_pcie {
 	struct pcie_dw dw;
 	void __iomem *slcr_base;
+	void __iomem *intr_base;
+	enum amd_dw_pcie_version version;
 };
 
-static void amd_dw_pcie_init_port(struct amd_dw_pcie *pcie)
+static void amd_dw_pcie_init_port_mdb5(struct amd_dw_pcie *pcie)
 {
 	u32 val;
 
-	if (!pcie->slcr_base)
-		return;
-
 	/* Disable all TLP interrupts */
 	writel(AMD_DW_PCIE_IMR_ALL_MASK,
-	       pcie->slcr_base + AMD_DW_TLP_IR_DISABLE_MISC);
+	       pcie->intr_base + AMD_DW_TLP_IR_DISABLE_MISC);
 
 	/* Clear any pending TLP interrupts */
-	val = readl(pcie->slcr_base + AMD_DW_TLP_IR_STATUS_MISC);
+	val = readl(pcie->intr_base + AMD_DW_TLP_IR_STATUS_MISC);
 	val &= AMD_DW_PCIE_IMR_ALL_MASK;
-	writel(val, pcie->slcr_base + AMD_DW_TLP_IR_STATUS_MISC);
+	writel(val, pcie->intr_base + AMD_DW_TLP_IR_STATUS_MISC);
+}
+
+static void amd_dw_pcie_init_port_cpm6(struct amd_dw_pcie *pcie)
+{
+	u32 host_bit;
+	u32 val;
+
+	writel(AMD_CPM6_PCIE_INTR_MASK,
+	       pcie->intr_base + AMD_CPM6_MISC_EVENT_DISABLE);
+
+	/* Clear every pending MISC_EVENT bit, not just the ones this driver knows */
+	val = readl(pcie->intr_base + AMD_CPM6_MISC_EVENT_STATUS);
+	writel(val, pcie->intr_base + AMD_CPM6_MISC_EVENT_STATUS);
+
+	if (!pcie->slcr_base)
+		return;
+
+	switch (pcie->version) {
+	case AMD_DW_PCIE_CPM6_HOST1:
+		host_bit = AMD_CPM6_MERGED_MISC_EVENT_HOST1;
+		break;
+	default:
+		host_bit = AMD_CPM6_MERGED_MISC_EVENT_HOST0;
+		break;
+	}
+
+	/* Mask this host's bit in the shared MERGED aggregator */
+	writel(BIT(host_bit), pcie->slcr_base + AMD_CPM6_MERGED_DISABLE);
+
+	/* Clear the latched aggregate: this host's MERGED bit and PS_MISC's MERGED bit */
+	writel(BIT(host_bit), pcie->slcr_base + AMD_CPM6_MERGED_STATUS);
+	writel(AMD_CPM6_PS_IR_MERGED,
+	       pcie->slcr_base + AMD_CPM6_PS_MISC_IR_STATUS);
+}
+
+static void amd_dw_pcie_init_port(struct amd_dw_pcie *pcie)
+{
+	if (!pcie->intr_base)
+		return;
+
+	if (pcie->version == AMD_DW_PCIE_MDB5)
+		amd_dw_pcie_init_port_mdb5(pcie);
+	else
+		amd_dw_pcie_init_port_cpm6(pcie);
 }
 
 static void amd_dw_pcie_start_link(struct amd_dw_pcie *pcie)
@@ -179,9 +247,20 @@ static int amd_dw_pcie_of_to_plat(struct udevice *dev)
 		pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 	}
 
+	pcie->version = (enum amd_dw_pcie_version)dev_get_driver_data(dev);
+
 	pcie->slcr_base = dev_read_addr_name_ptr(dev, "slcr");
 	if (!pcie->slcr_base)
-		dev_dbg(dev, "No 'slcr' region, interrupt features disabled\n");
+		dev_dbg(dev, "No 'slcr' region available\n");
+
+	if (pcie->version == AMD_DW_PCIE_MDB5) {
+		/* MDB5 has no separate 'intr' region; it aliases 'slcr' */
+		pcie->intr_base = pcie->slcr_base;
+	} else {
+		pcie->intr_base = dev_read_addr_name_ptr(dev, "intr");
+		if (!pcie->intr_base)
+			dev_dbg(dev, "No 'intr' region, interrupt features disabled\n");
+	}
 
 	ret = pci_get_regions(dev, &io_region, &mem_region, &pref_region);
 	if (ret < 0) {
@@ -222,9 +301,9 @@ static int amd_dw_pcie_probe(struct udevice *dev)
 		dev_warn(dev, "No MEM region configured!\n");
 	}
 
-	dev_dbg(dev, "dbi: 0x%lx | config: 0x%lx | atu: 0x%lx | slcr: 0x%lx\n",
+	dev_dbg(dev, "dbi: 0x%lx | config: 0x%lx | atu: 0x%lx | slcr: 0x%lx | intr: 0x%lx\n",
 		(long)pci->dbi_base, (long)pci->cfg_base,
-		(long)pci->atu_base, (long)pcie->slcr_base);
+		(long)pci->atu_base, (long)pcie->slcr_base, (long)pcie->intr_base);
 
 	return 0;
 }
@@ -235,8 +314,9 @@ static const struct dm_pci_ops amd_dw_pcie_ops = {
 };
 
 static const struct udevice_id amd_dw_pcie_ids[] = {
-	{ .compatible = "amd,versal2-mdb-host" },
-	{ .compatible = "amd,versal2-cpm6-host" },
+	{ .compatible = "amd,versal2-mdb-host", .data = AMD_DW_PCIE_MDB5 },
+	{ .compatible = "amd,versal2-cpm6-host", .data = AMD_DW_PCIE_CPM6_HOST0 },
+	{ .compatible = "amd,versal2-cpm6-host1", .data = AMD_DW_PCIE_CPM6_HOST1 },
 	{ }
 };
 
-- 
2.43.7

