Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55043606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tpO73WkW;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TZb4hOGN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10A12608CD;
	Tue, 20 Oct 2026 14:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqqlmulDOHfH; Tue, 20 Oct 2026 14:10:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA4716085A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505407;
	b=oSjpNI+iLu+g7YD6PP6sMU5IOCb/cPQpRascL593TnMkL6q1irLVM9RLu7+Zc8jIYQ8r
	 ZHKZ1KThfhBjUfJIhMpRccUhgbb/HJdvwT3PnNgH6OS47dyctkm7EFgB4mQYSARi2MwtS
	 JFHkEuHu5vnLA05OB8gGPcO75b2nHoed2oW9s7qRibfFMHkH4xIcwSTmHj2Lc4TdIUszF
	 U32fDG9O5Y0kuq/S1BDA9jArdNjNaSeErZfrm4eS7K2UkCnz3zpOpyLA97zCm0/GcdTRJ
	 d/q/EirdNEhbvnwTm2n9lo0XKcq1dkCanifmy/gGREdT0DD3+vF+0EZohT7ZycGND0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
	bh=Qm0/iliIxQxxJLj1HwL+o+twF15tX9shYD5TRtszexM=;
	b=ZaNTakPqC6zoNNdV1guRt72YCzrwkKEh51TGrBJWoiJtdqIHUa1B/C8gNoI3ROwqrWXn
	 5bsp+rz5haRdhJeC+rWv+UeVD6YiEI8f96XuyX9N/nCUbuFf8O+upHVm6v5fj505UQZIJ
	 JDSeFQBGuyrC8It0QH+Wjsn1ID3htUi23Mb3weW+Kc9KxZVPJxtl0W8wKQr1WHDJEZJEm
	 loPnXRsGsQRz+2VS+vA1z1IJutrOohF9m+vlPQNB1hZr6exLGf6iVZnKg8cWMlV2EZ5VC
	 W0UtegQPQgra0thipcU4glQjTUgrkuw+W1wy3taGqfNYzdAODllrXhFObdo0tg9JpSw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505407;
	bh=Qm0/iliIxQxxJLj1HwL+o+twF15tX9shYD5TRtszexM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tpO73WkWLzWeimnGeMpNpEb4KBUx17wdG0GykMUGLoSsHA6N68Vu1SMes1ET55yr7
	 M9Vu0Zom1r5lIH+FRu0WSFaQ36tUhf30uyqllX50pP9YREM/eC0aGEX+CzbVuH9ZpF
	 V2eAhvBi9GdxYZ55b4WavqVz4VGPdhax7Fq7O+5Uj0X8voPjL/o9SCIg03rSCL9di/
	 C+oznINqCMcXBme5nzPZXUPuhoZG5mSH+xxcDSC0bx4wcx0MAXxZGb/hZYQK/+QwaT
	 htmlbsm97zB4OTqAK0PINE85AQBG8IGWFkX0f7771X8YPFgPdVq4n08Ig3GCvxjuZI
	 AYKyI8K5RGWNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA4716085A;
	Tue, 20 Oct 2026 14:10:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 719F71AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57AA58102A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJG4NivMloae for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 83D0E80DF5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505404;
 b=aIV3VY6wgsi5q1+fi0U0UucMZCAkyG3M3QbEuxbcjlWtAFIB9zx7tQ01cUpMORbZAf9J
 /7WmahydyL8OEvkIyIe1E70mYje5FurTOiSX+ZOux4qHZRN23o+dTlF2FXDtyB9uPzuC9
 ye0zmvGNNBDuc6N6AWAyBf2I7RwC621UcRvmslsIdKnbp/433LmbbxxLr/PlQiY/Gxnxa
 8qV2wRar54xkfShFd/PqHvbohmvL52j5dk1SRPc4FOMx8VrnwbvFrJPdTCLkVFCoktobD
 TJ/vhLkp7ITrBYN9lqJwzVtnDR1JgpCOtlrRsSTH3sqtP+p4B+y5aa4wXsjq8ojE1Sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505404;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=Qm0/iliIxQxxJLj1HwL+o+twF15tX9shYD5TRtszexM=;
 b=qREHWkmPawoO6T05pZFC1psvoj/WeEpH+KIeyvKi1XfMQtBup7xBilRARWQyy2WLuRKt
 hyga+mJ22jEk1xkXkslUYC7er9ZNkdqJwAvM09j5lX7UWRKR0U/iqWtujpKiDWHfppqBZ
 F9B2Q7lVza7gEOiEJZ0HLjygdXybq0M8PKreMZ5Cln9LcT3c0cmcyRRW7qgBVq2mp8WoR
 6AeVl94Bqay3r1Wu5bLokEFypJ2pLA4vvQUP5u9UdQrZ79b8ALgZtPa+QqXABZPEw8uBl
 53KV9zq+U26A8VmCWxqovL6u3nXwfYI5GkBjShr6nSuTXkfnUUsAM8muOjzHfzTdQjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=TZb4hOGN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=TZb4hOGN
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 83D0E80DF5
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSTdqQPV3voFzbbsHP7vQ5I4TisX+HQVNRZa4pfhhM3QAjvFez69PiYqvR8/PenOe3kQ7hf2ZaQVqNuZ8ViKT8zE2vjVNkmKBsQG/UfOeFC7Yx4mX7H2SucpbPGAALZzDfndXpXHl8/Q70UmbPlpWahUL9uo3w1+SFb8RMqT8uWhvvWD7/KU5nkj2PU4J2Yl6cNe3f6jWtlh4TGFXW6PAW487cpMkn1XeGnRfCGIhJchOCD82YndLQbpnXNMuDeNvjcC9ToEm9AzzRsglE4EJ6cSS8A2alAJZtJhLm+GSo2CxpPFbrIIOrbBhqp2pl/FNql2s83X19WQt0MxHViYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm0/iliIxQxxJLj1HwL+o+twF15tX9shYD5TRtszexM=;
 b=hrpY/B6lhSXwR8rxdmDQ4Wd4rgQKK2GP8M/I7VR8N30xEciGbyXtJM44hdLfFRZQQVwqZo6SOW/fYkzeiNGSFCEisci3K7mx42XXqBj9ClVHeyVOMTGMVIq8QSh7PkkAkhXEsJoWVo9yelFvTY+CBi3NqGps+o56Nd9b0FCI4iBr+gcK5JIAUyBlLzgR/x9XJN1suiYWUoRza/nyfA9hat90Hd9SdtuA3PESLfw9MFu23IkYw6ZvIssjJzt88HtMbux7vLA0sRDdJyQ7VlTtPICJfJ90ubnze0CiU2/7A2c+/lA2iYygwxNuVucNYjy+fQDQAHlQ6kQVA9Rk5HAhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm0/iliIxQxxJLj1HwL+o+twF15tX9shYD5TRtszexM=;
 b=TZb4hOGN13WWt5PVI5ZImQbZbcAZVMkw75Ck7nJpP2rBp6AK6/lPU+oGWY9faqXiVS64OYgU2jlVYP+fdF9SrIeZEpMrXIO2j/dvD+BDlKT2Hi5EB2ILJWlGcjKeZ3ZrSR4zhO0nAi/WALsZbIZMhVHsXs5M6z2AC5KRVIwE0xs=
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:09:58 +0000
Received: from DS1PEPF00053452.namprd04.prod.outlook.com
 (2603:10b6:5:3bb:cafe::56) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 14:09:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00053452.mail.protection.outlook.com (10.167.23.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:09:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:09:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:09:55 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:09:54 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/11] xilinx: mbv: Enable Timer, Ethernet support
Date: Tue, 20 Oct 2026 16:09:25 +0200
Message-ID: <d8cfd0f911d986456ff57b96a9c77e3300303f75.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Ed9WFS6DfQ2m4YI19yLCdlralsw972kaHF9DaKQRVGU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL5PuWMJp4aJjP3/J9fdTOx8HPL18NPj+6u1lzTwHL
 VLufw1511HKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATeevB8D+t963wjDtbotl6
 3XijlL5vUC5iFmJmDGid+Whn6uOU3TYM//Nk1HieMs4uVd934uqbtZwSLW6rEm0+pDhL6FnK7V7
 vzwQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053452:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: d07088b7-feb9-44fd-d335-08df2eb3d2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|18002099003|22082099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: VVOg6ZdmCsp6c8bHqlDN3oCk1J31u/L5yZ3vgwUSr8M8ZVmrZzuCrcvCvJ2W2joFvVMSEuss/InLlzguNGDt4rFoxrF+Q4Ck5TkEtehlXloWnnzXM/cDzkpwzhJrJA/re/T3uW+OV2Tj9+tphViPjOYHRg8h1xzzz+V5EznEQ/sphEnhlytK/Lp91iLPIcjEXqfW/W3RbDB3oUQXiSq3MOC1wgX3bn6RxFqfpNut2V+SMG/SB/pHMZhbad7jkEvx3xZXan71F00JBo/aCR+/5p6luR5+LibdFs+zJcJx1HCmm7qWzgTdxzVrVATUSLdV2WVmBigUiQqMGPcLROa92+PGcLn3UVs09NuWReSxdH9auySed0wbX1dMKhDkzCa7681o+RnOxWeHNWgssHpq6W/4DIjA1hoZp+M53yhBTN7nYKz6ntWLdhf015SscTZsFIT3wS4+Srj3/hGkpPbyBT6CN7ycFJFn5ApLA3zaoIE9llHtY1fPJg0/e65iaDB7HpgD93rN4C0YIzFNGI3SypjTBeKNPKPYTmdHHuqgtlJ/919qeqa2pt4ySLAKj9dzXGvenewM/VNdwD9Ias77z6etAxJtL3DPzY1qVKNdL4yQASabrE4GNKl+oVqgONGMWd/Vlf0XD3Vi+JGzKh7rl1j41V2AhmZJmPA84QdDtlXPtIa1VkAYx5mlztxdb6FIJmlmu6Q+cfAaUxKie/uLow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bQ7MMk+UMXNll5F/T4GsFiGWQbLeIt79E4dmNVfqW8XFLpKai/yK4qYxgOswmMzW0cdXOPN0qv4W1H+nvTpuQ0z2krskJaqRno9EkXSb9V22fVXnI0lqAt3m/qxdpLbbKjFJgVMhJbqvOi39PT9cEArXhvkgw8d4MvwWtrEigl+dzotOSpfPoDR3WRVSFvJGD1syNwsGNkDf7TfRB/yWmYybErPa8tXS2/0kU+Xf3JLuAiMZu6ObBgIi43tTbDsO8IwBy9p2bfUXN7eXv78e05flPY3YlpS6YgxXV5Dj1xPis2SHm9RLqfsMJHFDWN5eR2tHLkePXh7FJyee2XeZWvvn+0jlTg/9+b/wuCgsScpHTugxJI+IEjVhLeGe/FW+TDxsxav90ZhWfcdFWbJUbuJfsL6x12xTErkhKDRPYkyJWaP+8WlU1woTMIUX7UmP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:09:57.7362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07088b7-feb9-44fd-d335-08df2eb3d2a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053452.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876
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

From: Padmarao Begari <padmarao.begari@amd.com>

Enable RISC-V timer and Ethernet support.

Both the RISC-V timer and the Xilinx AXI timer are enabled by
default to support whichever timer is enabled in the device tree.
At runtime, U-Boot selects the appropriate timer based on the
available device node.

The QEMU model does not support the RISC-V timer, which is why
the AXI timer is used instead. RISC-V timer can be used for
minimal footprint and early availability.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 47cecd6878a7..c84b1a41655f 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -43,16 +43,23 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_SPL_CPU is not set
 CONFIG_SPL_REMAKE_ELF=y
-# CONFIG_CMD_MII is not set
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_LWIP=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_XILINX_AXIEMAC=y
+CONFIG_XILINX_EMACLITE=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_TI_DP83867=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
 CONFIG_XILINX_UARTLITE=y
-CONFIG_XILINX_TIMER=y
+CONFIG_RISCV_TIMER=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_BINMAN_DTB="./arch/riscv/dts/xilinx-binman.dtb"
 CONFIG_PANIC_HANG=y
-- 
2.43.0

