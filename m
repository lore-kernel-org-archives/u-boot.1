Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ADF606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0UfctiLZ;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YcWfuFsM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 550DE40898;
	Tue, 20 Oct 2026 14:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQ7t4EUZwzD0; Tue, 20 Oct 2026 14:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9FF74407F3
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505417;
	b=c3kb2Icuyb4VKYW63BPqX6Nx6EkrZFoWkFr2u9wH9RU7U7eZV8ddICCGQycGZN5Tp2hs
	 rLBga01zNx1pX3fRbYfRDXlJc6Ffsr+DzImlv7W+o/O5wZngnZis6Qi7bh1b9f/Rr48S4
	 Ygc2UVZTAEVIbwx5yO8C4JREA22korXoarveyDPn+Uuno/nkkgggFX8CFu73IUIyExNIA
	 icomp2ox05gPWFqVyonklDdv3qPBlRmcG0zIZ/TYiPVJyS2O/WrU3V9cdKNMM+JLOuJZi
	 kBLc4zi3XT118JMeSjhU13e6EV41NGZaGTPWKpW6Yws0K+xap2weot77U5UYbkiigpQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505417;
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
	bh=69EX3WaZKjQBdsC47qxvDX2v3lhskG8JXgdJbL2pYbY=;
	b=YZJIiIDP8+AiYZu8c/+r97n4hzOvY6M4kX2idj/ZhcZCJX7pDKuRf4jwqLD5VkyaeX2m
	 BiYjBUxbPbitVjIKzw88e/K8APi03JmCJGmkp4oeXIhSTojtW+r2m6MAcEeTeZ7QTx4GN
	 BU4Xi+j+4H7Ofo+VwejDJ6MhL5OP/Jw1TKoGOGyL6uiVcnSK59qyE3zziXEK5Ay5Uv0FA
	 3eiUkQpgzxHWmQD/NMIgflk06Vn3qnaS/8TN25c0etLfrzaPFYzoZUfXE2KiHdx0SMDI3
	 PUzbY69t5VkAOUj+LMfLB2OdjTtGkCsuMc8arhj38B0pEKDqgFGM14TAqlLUulz4G8A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505417;
	bh=69EX3WaZKjQBdsC47qxvDX2v3lhskG8JXgdJbL2pYbY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0UfctiLZiORk45zkX4r2ylEbbpPR65aw60IEKNGmcVfxv2p7NrsC9TnlZgfQVS2yU
	 ojhz4P+msOVjtOutF2xEtDVlsA6+VwIaOkoR6YKWurE+9fVvhVSPunyuL8i1lPfcxi
	 LpkJp0gzYsrVczRnDBhaVOp1e2Kdcg1M9LLqYr4KpzzAwUH1QZ36CL4ydpsFOeTrVv
	 UD5VsRazcZ8PaA2WcE0Olww6XNf8Fa8TVf69jbORrfuXw26nhj55VgiRCCPT02DWW6
	 D70ItEVUrbX+5TlUfsn6tosY9YUPF5e4aXikMoAzXnfHZC3fwxgKeEvbMwta+STG0Z
	 kyTePgcpwDD1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FF74407F3;
	Tue, 20 Oct 2026 14:10:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6AD01AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8DFF40359
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dBgoQvuVaTLA for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 03B264034F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505412;
 b=ELVn2tJ1ldQ4nMuHr7r+r/1alUOid0PqXNyX4ZeEybNfohWY3rIlcDjQHeMTK3XKWxEu
 loonHz3X02PqBNKtVYlwSca73GnpLequl8foenJ8PSc9awBo4C7tIICBeVjo2d1pZv24b
 J6bk7VTk9FQJBAFQ4JbiMWhhspuEUNEVS7U49kBCO7l/lt85JfiSYrePDLlecoqmEOEOp
 eq2MS0gGHlrdU9IKO0POPcI6D0bJwH/bpecD4gL2GJBTtGtFn12+yutqLbv3BG2PGCXpJ
 d9Kxc/jGoP/bZiPwKQPa/CjvgqoaaTf8/YGpeAP69gFH5RayFe9TDNUewS/SF2Ngnhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505412;
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
 bh=69EX3WaZKjQBdsC47qxvDX2v3lhskG8JXgdJbL2pYbY=;
 b=rEtgD2AumPSLe1lvrlxDsdZBK/3/C1ipu2qzbxtzdqsQPXcoscbJ7me9JOKAosebLS4B
 LND+acTc8xwpRgcvgcORRvLdlc8LlLop3KaTilTOZB4wxWnGYtVWHcdNb3Nw4j0dszy/T
 45nMMeVCiX1za2otPufjDUK+toNsDt0H/qSy2KiEmI4HbrQVMX/ru5fO+4ildfkH52sFl
 GQPlVR2cYH4TwK0Fl09MtMsYgezhnKKvk976o0crFFlFAyvOYmRBxQjoO5sJLZBqkejHd
 HLcf6SZ3fi1W7qB5apwQ3WEdrq6FDU4a94lojakJrEMjubBm3Knzmsl2GuUN1pQBe8w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YcWfuFsM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=YcWfuFsM
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03B264034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+mfiZJeTxnjC1DFUn7jbMcaZr4yFs2zrLuSZSKCNGfoAr0uzy7/33wY3VB1jitAp6bRbCpy5J/nuk1ex8TWh5l+peEd18X9nrEXUxW6v++Zawi61nqbaJedlDp/ooWIiD1A22z8+CN8d49b7mfEsVdallfggPl6BPUN1va7urQ3G0mK2TIBTA1K+9E/bQFbMb7szK4wYm0UeC2u9SKDhF9ai9MiLlaOkJ2Pw7o8znReKSlLDEyRJF8cqMpeuhIWaqp6VqPWmDjUprM60h5YjmP/8tOl0+lkTOJVV3Z78KgqXoZG35kjfnVeL59Y/hKU9BYh+AQh1kun2Ic/b/JZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69EX3WaZKjQBdsC47qxvDX2v3lhskG8JXgdJbL2pYbY=;
 b=aEWb0dgXq+NIVEaZX+i8UQhxveb/DE5k+w9zL/+ijRvBhvDda1pL/E/DLazRVobn0Kcs9bxKuBA6jL2kzyhYv3DAFYo+ZngflXdKSuKlMCW+IJiDSLnklyrLmn6xlzIpfdg7qVqepzR5s30n2Bj28aJcKn7XbHBfnYghbAK9IHPckOI41m3Ryj9Ff+oDIn7HlZjfCSyIy+WNZOXCF9nDXJsUCHxwYAKEhaZ8wa+RbS+bhLB8/8eu5pjjKAeUlujxpGMMaiuBjjfrYjsjEYyT6+XyIYzjJjYsyGf0gpWrP/xFvUtyKzSmIFkMR6I0bjZ+sQQq7vsDjVAyYrn4fOUGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69EX3WaZKjQBdsC47qxvDX2v3lhskG8JXgdJbL2pYbY=;
 b=YcWfuFsMNyeWPHIbN9iW/2d3e41DPCn2lB//nyvR/nlby21qLegq+MkEjtPN1cgqhEwN/NsBmERtQpTqkogPsoXEL2gjsrP8UChrN9wpx5UeqnrnOODLEf1ft/R6pIMHsfsRXCFa4rNGEywIRAJpyHKJpE0b10ciJ9D1wtaOgBY=
Received: from SJ0PR13CA0087.namprd13.prod.outlook.com (2603:10b6:a03:2c4::32)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 14:10:08 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::14) by SJ0PR13CA0087.outlook.office365.com
 (2603:10b6:a03:2c4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 14:10:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:10:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:01 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:10:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/11] xilinx: mbv: Enable CMD_EXCEPTION
Date: Tue, 20 Oct 2026 16:09:27 +0200
Message-ID: <75fa2bb5460c552aa16be22c7cbed06dcb58aa42.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=676; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=arXKqhS7FnoEXtVEraZ3/8WyMlzdD+xOk93vk3R70zk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL5NNnOIhvDLClXme4b73UfUF4gsYGlcJx34RrjHdd
 NDZaadYRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzkRBjDP6MtW21XrLbt21sa
 Z7OjxK8/JCZ1h51XTlbwph2Mpz4L6jL8UyooEz9e/FBbnGHTu813Ck6d9Vyqv7v2eJGxyuaKW6e
 /8gEA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7796d6-93e6-4b42-2f47-08df2eb3d8c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z9vsveM8Qr6bzGcdbGSSGBh6jg9OZrEY0ky0anAermcJzK9hKhDDe1hA95xiV6EhAf7aS3a7BpLGK9/U9VtOYs9OLanu1BnqXSqQNfX9a8vkiApIKViip2A0PjQxVhvukKwBXwVeupuqJWYJvLo+Yl2IWircAtywrqImig818MFU6MN7vuDrSkIak0uSOaa2l4q7BO9prYvfPSw7fLEfPvaBnGn01DV5ak/kGmGAVyhLMyYZlZbqnq83NRcD3Pt6BX78mkS4qrX12ngKWH5Sc/I0Ni2HIzOVqF+0Tlp3RLV3You1BruudpaXdVJoDgK7Ch+YqVYcXcoQOsJTTE2vKK2K1+QnM2k36dsqWFeKW+UrwS6BycMrUU3EmJgUh1xQ29QjOFJKEE/eq/kIZOAgA9wnYtqUpP+ijUNHzM9Xm3nE/GCwf3d0up2sd9SLnJez+0zJFvN/V/SBUVD8U3tE9kr7Bud7x62cZagTu5/LL+Ik+kQeb/Gn7mf4hpwBIjrPxxaqiweKl2HXWIvLLB7wlX5URsDNG9pQmu+FflKC2QCLl5KzKR66SZ1IlUXvLUiqcusCXPvZlzE067MleSJsyu3SqI42xicxD/h+C+gXv9eGwVTEJHcWYy4apZZ4Kvgr22dT+wuYINbDej+bDoKG4kuMtTOo/COZj/JfJYy8ICWJxBsKj3Jd/iHtVJZeyQ7X5QTgpFhA3T5n/jC4WdhOeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wBOmAPE39dtMn9xiqTuBrcjEvsz6N8LlujAVd4Z5OgitLDwNeQaBPGe+B71fCaLIQ3nfr1IYpR8Db5MVrcmoB2mH0NSwXscFujNowm8JN5Gqb3xF7ILIOX5QiqjPOGFnT5j4cV4YEP9i6UNFzy/vyRBlIcpONm5/yWx/b6RvZYpgO5gn+Wata+HX7LxX5S4AVw78FBLlsSkRnRSVvKHH7RmmGPJBcHeift+l98d72IGyL15fGhEDbI6bi92B/vz0JjIz/eIOq1/PkqpqiPBEy/w1vJN4ar4s8bNqEuZ4bbTblx0+EUtv69hRd6HvP05rZtzTSU6pwmF1Mka5WQ+6k5uRTNuXmWqyBU03QLdL5HhpgINgibauWDI1qCyqql7gBNVWqR/uYnCs3HHwFZAzND92LkG0b3kGgjr06t0br4pAL+2LyFBpteNF1tcdmYxV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:10:07.9836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7796d6-93e6-4b42-2f47-08df2eb3d8c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
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

Command is useful for testing the system and checking that exceptions are
working property that's why enable it by default.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index a65ed7966af5..4195fe0f05a1 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -47,6 +47,7 @@ CONFIG_SPL_REMAKE_ELF=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_SNTP=y
+CONFIG_CMD_EXCEPTION=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
-- 
2.43.0

