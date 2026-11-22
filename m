Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CE606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wNL4QuTP;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=X1C62U0+;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Ojz/mjW8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B62D80D73;
	Sun, 22 Nov 2026 16:21:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vjE7DmveKHzc; Sun, 22 Nov 2026 16:21:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7309D80D5C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795364511;
	b=V/YeGpbqiwi5pNJeL/xEbgvGKNquC/IZVMlLXBE9nQqIY8D1doE+4b8n1f23cmf2AEk9
	 69bykyaOrayvJfdeAUBMTynLozBNEJVQfEP1Qw0rVJldVYkt5IVqeud4+7PwjppMYKypR
	 YSuh/wT7M1aZNCO9aMBKabG9TXd6ZLilWHxDbr6J1D7X4/StN17obzsz/CIgsP6DrZEx3
	 tWXPtt0+RM9CC9uXnGAmGImxFWGdGt7rFQGbl5xzCuf8/DbqnicHii8jeL/oDHxtWs/SI
	 4C0UlB2H3jQUxUes9eeaUA9JXOilAAw17yw84il/vfb3/rBr411cuZHyHMc1eyUcX8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795364511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+FHU3eraR7CIAttioJgL4++65fHGLfUuwQVaMsCBqIk=;
	b=SilXZ4lgBMwk3y1aYJ/kOoF4AFUBA7JWkqYnG8nsJGmD/EmI64rPV9QecYQhCGuwzjsp
	 OATJ71nXuX5/yrGuAF5Vfz0ZKgFt9Wwhb2FvucQbY4641P2SvpDEbUcQmwYsdtcKaIAe1
	 mBgqvmec6mMiyqutFtT7rpUwpl1VCUWVbF3JapU2vn42dD1DSo30JUCIw8vpuooRKUhyO
	 Ut7d3sQ8x7lvCA45Vewxg8TIRrMn3u0nYSaDMVuwodFh0Y+VToWOlQi1sJvbPhSu51S5R
	 iIt/ks3qUDslV7+GKiODrmcjJbKHlDLI3FkwQhgFX3PGudC/geD4by4i0Fmw5hpCj+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795364511;
	bh=+FHU3eraR7CIAttioJgL4++65fHGLfUuwQVaMsCBqIk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wNL4QuTPrtQjKPa9fLrodtXEC3SARPZfR8VvUS2s6z0p7YSgetZ4fs9joIpSoQ0v7
	 KzWyxp/KAf+Q6TNp0TWofKIwnLsUUR5R4AEFsQu/mYn5Kf3P9zCxs4Ps4XtcQCWPNF
	 QE/O0pJyIWJ/xE7MheeFgcwxsr5f2tONjZJXkHyD5lL9k5GJ1rkcriKltLH+URvaXs
	 lFPYySAg5WT5tXUHRu95O1P+i6F1cP7vi4IHA1rCUJ6O60v3VbhAi+xKwhPZyxBOCt
	 kVzgVfzzvzOdWovSJsPFzANLhsqE24R2DBe52bPJCakEq9Z5ZZfGWbC3VwRtB5ec3k
	 B2qzvYRk+iyog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7309D80D5C;
	Sun, 22 Nov 2026 16:21:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1094422B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA8EE400BB
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cabNFMap8MWd for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 16:21:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F2B09400B3
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=X1C62U0+; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=Ojz/mjW8
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F2B09400B3
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 16:21:47 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AMFQf1T1590302;
 Sun, 22 Nov 2026 10:21:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=+FHU3eraR7CIAttioJgL4++65fHGLfUuwQVaMsCBq
 Ik=; b=X1C62U0+zTMeZxnqOkUa/IRrBvGOWEpCHQ3nM0uxyjNRqmBFE2wRBanAC
 7X8to6W+JoGk+aj7Wr8yV00XNecS3uLqA0ziwSBwLPlBmHGHj/vSTBWEMTodY6X7
 1x7hzzis9+aiWY+gTdFMIR8WFVblCL9vaBACs3tz+wozd0KGcjcs2S/8GjUec53v
 IyV/lpNNNW7V/BsoaKw/TzPOTlUhQP7b3vrffEM6Qb7rkYCmcM2qQ1r+MUk4Dxg3
 0y3FFcavh4D1WwRxBfM9W3tFgdZmbgL6M/8dSM/onflDxS/iUuJJ6e0mh1n9yn7B
 m1o+p3aBIui1pW0YZWpCHjL5LhXfg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by m0384305.ppops.net (PPS) with ESMTPS id 4j3x4s92hj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 22 Nov 2026 10:21:44 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FHU3eraR7CIAttioJgL4++65fHGLfUuwQVaMsCBqIk=;
 b=Ojz/mjW8V0UuAp5jLG7YegDcK9fqvnV4mdYI9Veb5qwyDLVwtX7gDnPshq5ZoQbrLYFTH4NLVznaTKyv3fmFt+9pRyscFhvCDEkZZgo41s5TtMkRDkMjyYcccS2pTyjBhR9UoOWEYqehYiHh/oeOHUix2CwDY6NKh1dSR0MnZPQ=
Received: from CH0PR07CA0010.namprd07.prod.outlook.com (2603:10b6:610:32::15)
 by DM3PPFC0AC38E58.namprd10.prod.outlook.com (2603:10b6:f:fc00::c47)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Sun, 22 Nov
 2026 16:21:36 +0000
Received: from DM3PEPF000265BB.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::89) by CH0PR07CA0010.outlook.office365.com
 (2603:10b6:610:32::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Sun,
 22 Nov 2026 16:21:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DM3PEPF000265BB.mail.protection.outlook.com (10.167.23.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Sun, 22 Nov 2026 16:21:35 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 22 Nov
 2026 10:21:25 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 22 Nov
 2026 10:21:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 22 Nov 2026 10:21:25 -0600
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AMGLL2G940875;
 Sun, 22 Nov 2026 10:21:22 -0600
Message-ID: <5f8693a4-aba1-42d9-b814-ffa0f5529087@ti.com>
Date: Sun, 22 Nov 2026 21:51:20 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark
 regulators as bootph-all
To: Tom Rini <trini@konsulko.com>, Francesco Valla <francesco@valla.it>,
 Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.u-boot-project.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Andrew Davis <afd@ti.com>, Nishanth Menon
 <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, <u-kumar1@ti.com>
References: <20261121-beagley-regulators-fix-v1-1-467ace9d717f@valla.it>
 <awL1l3x5U0GRhY-K@bywater> <20261122140953.GK3176972@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261122140953.GK3176972@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BB:EE_|DM3PPFC0AC38E58:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb93710-35d8-4c47-958e-08df48b4ae06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|261021121427099003|4143699003|56012099006|261102123227099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: VINiT/uKc9qdyzQNUjtobE8S3Gws6cIYV8JZ+OY4MG07xDcBXdUGOsA6FT4Q6UQ4yDG4dSu7vQSRsq6kTYaFusAL7orocsIrSEWpm4sd0ghhh0/rLW6vnjHRDL5QhaVUHQFdXFDJDGtE2pEExKb5nadm6eHKQuUFblfSL3DSy3Xi8tPaR6UFt9fk1ABX97EclbIq0+VjGM7x81kW1s8LzOTqDaUAjODdPmKl5vWECQploXKFKkEAfX4T2V3uPJwKCRcsLv88F+hdkHfc3ptoaNcPRjFDlMKW2z4IN0CCGAmY7efRMH1zOisjLlIjy+gbKrDBcH0LgJbjwiKuYA5JyUNvzT+SNcOb20o3Wjh20pabU1vkhfYuOMVFeH09Ldd1H3rXZ51e/tvEgFa/XFtqZXQ2m0jbjyUIfnMS++Vgo0M5A7aRUtioyiT1Ck0tkcKSArYVaH5PVhHXqVbOkh8M3XdroKVWnnJgKMfqi625axLxQIWNT1GMqiPF6x/YbRSctHF1SwpDV8G5LF6U9LjwtSDqD06S27ohLS6yg3cqrApy5zr5x6UGIdsdN7Nyu6WAaCyglNCS1fh2A50Mn1L4yQSE8zGOMrxtF43jpaOXriYQD7QYVEyXdTZGcf07YlX+pbHaIdf3qC7vHLGNjmkzyYHdmyNRpujC67RWZvOWyYk=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(261021121427099003)(4143699003)(56012099006)(261102123227099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N0ma017kwiv3S024E4Gs8kSpuFSiIP7nbdKGJVh7e4ZGOKawkJjxsy75ukM5LEN/vPxOCpE6GmrM0hhnFGOWzDUEUolB3bTUwvU6lZsz+b1SqTSPPtmZWM59SSAXe98XCw37DTYV14pr1gRdOr5I+m6n9jj6OLGHNRRiljv3AOXPjPt9VQgIrRoeOULezvtXMwRcQFVQhycshUd2BYgDza3/SKxiVGXjKIZfsSncgDr3ZQwFA5LTIYZCmGNWsfGdP+zkvz6VwNluQBN6aDo1U41RLG6q94uwrfKammEPjeuMMD9DbFwvaM20cSkEEPfrH0EB0hAwypdY0D1jKqCX6p4Sb44EzlOTCTBRcCjk94Pb/AorlDGjSQsjvhVqfOi7j4gbuTylVouZ9HuT3jz9Bky6nubNW+KfAuJkEd0cBtIlCGocEORkNlzTFej8LIek
X-Exchange-RoutingPolicyChecked: TuCqo/eqVReC//y3E9plA5q23uAkPTisszRBcMTgQwSAC+pP7Lx/1elFsrLeOtWsYvFBgSFd/SPJ3RKgg0YLRXpOW0ru/z1woYN4Lt4csHaC5C5hMNkSb9uP1Lwz/QyKfH9E6Uyx/TFN/UUnoPUD1ix99k6l+NqINlagkWDgr0BAuElZG39RgGA/Qjg2jbSt73MywT/3PbEBy+o9VP9ZLCKxk39gg8SEI8vHKR0YZVCzF3rox5F0O8+zQn/XQyqv+LTM+31oDs8vUaOrtoItxxXCP/u1qxbHVmCorUG+2Q06XXzMy1BGqzGl2PNpFI6qcrnjSVYumNA1L687GMoKvQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 16:21:35.9847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb93710-35d8-4c47-958e-08df48b4ae06
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFC0AC38E58
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA2NSBTYWx0ZWRfX2UGOUIC/DQxx
 pzwl+Kdbq8QlNerAl9W6QXnNujpE8RLSy30uIjDBfNA7bWmMrd4LmkBd7Vl5NS9xOQo9pQ5JDkb
 PGJtOVHJIA2v+b/3NORHsy8kimtdWwA=
X-Proofpoint-GUID: U065fhuG2d-DK3cmMRoLIVs0Sg_33jMO
X-Authority-Analysis: v=2.4 cv=d8pgWhjE c=1 sm=1 tr=0 ts=6b031698 cx=c_pps
 a=6DSn5gaiYX6F7sdBrIJkYg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=P-IC7800AAAA:8
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=rhqkBTUJJwxMnZupLCIA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: U065fhuG2d-DK3cmMRoLIVs0Sg_33jMO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA2NSBTYWx0ZWRfXyC+4o5oQ9LGn
 uciNGOncqhxf++OyF6OfUL18dzfuPjuSLp8lyEEuOSq9hKk4eQlekob6er4MTX8spRL2T+bgbhF
 Cz4q0DX7IybKoVxc1aLxcHKspxTdogyXV9eOR/vItzuy+q7VID2hDJZ0DlqXmQbWxwII6DV06Vj
 h2gS+B69+nkDFCc07XIkSRpSjvxWKYMra2f6qplG/cE4lMCVlwAo4+hr0KR3aYHH2qYZ9+/lw0/
 LaXTgY3lBI7T177ECcgIjvYDyvsZsvsuPtmv4vNVta16o7yL8aIYUsfrUjv3VSAmTxEaryaovB9
 nlBfgv/vkF2VI77cMW+18TRyDtA/vb9DOMFAYZGuqZiHzwvyjM5Npmp8voTfeQezzPBHAKT06Lt
 eCOS+/zZDCaouS850M82Z3vwzaAxO08ZnqklUbJzGABKuQNFoQk6IC9zwhdilneK6sarK/WmSyj
 iauThQGRYMz0i73S+sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_03,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220065
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Francesco,

On 11/22/2026 7:39 PM, Tom Rini wrote:
> On Sun, Nov 22, 2026 at 03:03:33PM +0100, Francesco Valla wrote:
>> Hello,
>>
>> On Sat, Nov 21, 2026 at 10:35:13PM +0100, Francesco Valla wrote:
>>> Commit 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is
>>> missing") changed the behavior of TPS65219 PMIC driver, which now fails
>>> to probe if the regulators sub-node is missing. This leads to a hang if
>>> a device marks as bootph-all the PMIC node but not the sub-nodes.
>>>
>>> On the BeagleY-AI, this results in no further messages after TF-A in
>>> normal conditions or, if early debug is enabled, an explicit failure:
>>>
>>>   spl_early_init() failed: -6
>>>
>>>   resetting ...
>>>   no sysreset
>>>   ### ERROR ### Please RESET the board ###
>>>
>>> With the bootph-all property added to all regulators, the boot completes
>>> successfully.
>>>
>>
>> While preparing the corrsponding patch for linux-devicetree I stumbled
>> upon the same done for the Beagleplay, and in particular the reply at
>> [1]. Should we instead drop the bootph-all tag from the PMIC driver?
>>
>>> Signed-off-by: Francesco Valla <francesco@valla.it>
>>> ---
>>> I'll send the corresponding fix to the kernel as soon as possible, so
>>> tit can be picked up at next DTS sync.
>>> ---
>>>  arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
>>> index 0e810e7f492d..72f9284471e4 100644
>>> --- a/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi
>>> +++ b/arch/arm/dts/k3-am67a-beagley-ai-u-boot.dtsi


PMIC is fixed function, for normal boot purpose, you can update board's
config in u-boot to skip this.

If you really want pmic, please check which nodes you need instead of
enabling all, ref [0].
And of course these changes shall come from linux DT sync.

[0]
https://elixir.bootlin.com/linux/v7.3.1/source/arch/arm64/boot/dts/ti/k3-j722s-evm.dts#L511


>>> @@ -57,6 +57,30 @@
>>>  	bootph-all;
>>>  };
>>>  
>>> +&buck1_reg {
>>> +	bootph-all;
>>> +};
>>> +
>>> +&buck2_reg {
>>> +	bootph-all;
>>> +};
>>> +
>>> +&ldo1_reg {
>>> +	bootph-all;
>>> +};
>>> +
>>> +&ldo2_reg {
>>> +	bootph-all;
>>> +};
>>> +
>>> +&ldo3_reg {
>>> +	bootph-all;
>>> +};
>>> +
>>> +&ldo4_reg {
>>> +	bootph-all;
>>> +};
>>> +
>>>  #if IS_ENABLED(CONFIG_TARGET_J722S_R5_BEAGLEY_AI)
>>>  
>>>  &binman {
>>>
>>> ---
>>> base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
>>> change-id: 20261121-beagley-regulators-fix-3306a2b896f2
>>>
>>> Best regards,
>>> --  
>>> Francesco Valla <francesco@valla.it>
>>>
>>
>> Regards,
>> Francesco
>>
>> [1] https://lore.kernel.org/all/04ef3762-86d5-4d61-93f4-202f0c120433@ti.com/
> 
> Adding in Anshul and Udit...
> 

