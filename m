Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11399606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jCBj+Pcm;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FIOkaNRf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1D5980F6B;
	Wed, 28 Oct 2026 11:15:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CzmMhS5w8SJf; Wed, 28 Oct 2026 11:15:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D2A8080DE8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793186135;
	b=UyipDc0t6/c/HWwwhLzK+q4gGXss7K7uI+qJheKMUbJXO3YK1plslzbVXId3JaU1PPkh
	 amF6qPTKgtJ/8q6ecrHkROHkPQu/4GOirkC+a/E95v8b28Wec8AI/fIgTgP1R/V5BM4ZB
	 0NNTxdIPF49dGniSvMGXg6BC3fNeMCsw0yD28EVR5ZuZJyCCg6hCb8vnaAnIJFdhNRWg0
	 ww6PROIS1PqY6vj+dLSp15beT7N6vKd0zP/lXj7CmVwQiFkHOrd/qAamqhTNwDn7FXeig
	 +EprC0x9jvS0/VqXqcUC5jQrYagLU7LVxQak9//M536V7RlvUx353ec/iptUleiCKGQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793186135;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bPR5M+VDZDuWen9WnyfffDc/dnw4S+pUF08UPIAc5XQ=;
	b=cQ4/tGmgn7TDC8WiDw9ktKGxOkYkTDBGr85tJvHXtx3/O/LMNbnfShgvVu+ImFcWR13I
	 KExVHtmgaPDYFiuwbZYr95YJVD67kusSVj1tCRIMNGy2mY+V1Hx+LEWJkqV9pJgObRKEp
	 qArO4M3ElTLEWSeKBjE6PCvSUr8p89wIcqD+SaIdEUVfQwnEHeiTDQ2LnX7XxoUZTZoiG
	 gnnWJIA8Iyj4b4PrSVnjLrxGXxpZHB6XFemVQct2Hi5uZTQjN+da3koaEywKubNptlyCD
	 ycPebkNYj1YbBkyDtIvs7IrpE+vA4E6YSuDvQaAo3sgYidJjEkGi19j05HAVQyV3DMQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FIOkaNRf;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793186135;
	bh=bPR5M+VDZDuWen9WnyfffDc/dnw4S+pUF08UPIAc5XQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jCBj+PcmaGZBv0NZBfg3ciU9O1+i966sNMNC5tal784AIV7U6UiMGO8RsKLjZ4S7x
	 jxVGELY7sh/3gATO8J/lCJZ1QaUMbM/mUD2P6dkusbFnGtXVKPEwti3Lg1x04H7M1G
	 /6fEAJXgPQCb1Kj2JXfrtzgi6yP/d6phr1Qn3DEW5YJ5DLmQfUktegRlYR3UlxnohQ
	 Iu8n+u4afq2TnQlIyUMIm/cWLn99Vro16i7OTM57Hg5rQyQfHQphpC97EMYjYvkv3k
	 wuFuEBPk3lqON1ig2wj0xQuy39Gh0Fd9efeEQ3qq3wMomGig5X3plNyYypC7HfxPRu
	 HMJH6GhnkyvlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2A8080DE8;
	Wed, 28 Oct 2026 11:15:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 13D93529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0514380DE8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:15:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rSd-1ivRMh_i for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:15:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C74080B09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793186133;
 b=NZLLZbg3JYY++uc2EMyg+/S0xsXnQ28O6SjsySGpluTvbc5qDjLtWBpjwLIRZuQ/JTHf
 RLsZLYfKMXchf0FHcrom4IG6V3IQuOXEsKnSTj4wpLTvknRSnb4i1hv88sbKQh1nss9IN
 rKk0UWGgKYtlZur+AJKHOalWpfQbvLUIwgxbCzmZ7XTeY1Q4sv1st5ENrQDQniWbml6zW
 0MnIIH1R0n1zTMFLzTozPjhHY9UdwXM/Z8rAOfZiEGr4vTtsXQABlmGSGLwSrtAOcPoYc
 2T7c8Fm2ZbHjKeZ4vYh5NjKVBhgP6o+EwR5O02Exxnv4bGc9HJMQSkzXCIOx1cP8Yig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793186133;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 bh=bPR5M+VDZDuWen9WnyfffDc/dnw4S+pUF08UPIAc5XQ=;
 b=snUle/c+2Z2HPKjosK6Ik8BGjCXDXSeiKyDGWSquTiJl3U+7R7mTVG3nJHveBJzK1bL1
 HrFvaRLx0bN8pCP2i2j/OUZMu0m52UqZCN80fBpDsFeW+zrHItNq3ejKEmJjPfohHRhIg
 VKMe2ZGlwYxKhjDhLBEDpz53L9vGxYqDHlY9lI1vap3oIjadmu4CpKS/yIO3CNpkaut97
 ve9V8O9PJNf8fYOFlmVl9nvTN1jsBEcPWv0JaO9PVGrxcXKdHeV5jLqh2nBqzjPJNir9F
 TlDq2j8y7G7HQhZXcAWQSutuATha6j+xlKueBAbcA2RQ3emrxFxxthCiy108uPpGFjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FIOkaNRf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FIOkaNRf
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C74080B09
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:15:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPgPKz642SJMMkMARaMtjtJac7kEJ0wJfzk8DGu265hNTTJ8YWByoeOgtf7VZ46fHtYBvuDBZJnfZLJ7W+ZdyEAlHcN36XfwmqzN72cpWMPegtvLkod1jVt739pPTzSC2Royn0aAnGp4QQpGHBAhvO1JkCLri+nsLmMgH11sU4Vf1zczga64gYye2X7PPntIcwzaDVO6qeyyjrVlm2koNrqkoF03a+fwSuQPcu4TXQrNsjgP6v/43ukODpvMAHEKFSe1vwtw2s7VLJpPFywJFlCjuPZwn/2cVGiapgUSDipkksWjTbljv4/+B3Q8ixuFB0EvQ08LKy2qsBNEAghhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPR5M+VDZDuWen9WnyfffDc/dnw4S+pUF08UPIAc5XQ=;
 b=CPknJuaqOhMLUJA1Rmbpwf4CNRF8Ud4cfgTiEyaDWJHawT/a/75T4LzeVeBYezF1bL/m8ceW6D8RHZ3HeWdQ/NsFclmb4HJHVXWO44rG+D+C+0bxDYM75CS+BpTeuzoFDW9LXymi3oHicH2r9Hq83Tdqp/vu3ppq4pVUNndcJFa/1PZGUwRSpDpvbBd8BDCGk+WfPeNPYPpa0Jemo2kzrxHqYc1gKCZPuJTNZp167Vd1FgL68rytvUhH77W3g54mt5Jc6sUhLMVFbBcS/yrKuaZOuSMH9xgnNKSZlA9gyUl2mMmqmSv0g0M2p7CrkvSCXHiUGyui6tsGW6f4tSJMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPR5M+VDZDuWen9WnyfffDc/dnw4S+pUF08UPIAc5XQ=;
 b=FIOkaNRf8XY+ZyCXzICqKRlpkEMPgkhZA/ldlfsWW40crW9sUQhVTK3UOX7hv3NYu6SdI7HDpOgHfgXeL2oe5VCNCcakapBC9xe8T/u6OOol0G3joposHek8xh307nNcEpFWIQeycP6L7fbS2K7fpoalIuCLBePrGsCzKKbKZY8=
Received: from SJ0PR03CA0161.namprd03.prod.outlook.com (2603:10b6:a03:338::16)
 by AT6PR12MB717548.namprd12.prod.outlook.com (2603:10b6:170:10f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 11:12:31 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::1d) by SJ0PR03CA0161.outlook.office365.com
 (2603:10b6:a03:338::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Wed,
 28 Oct 2026 11:12:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 11:12:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:08 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 28 Oct 2026 06:12:05 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Tom Rini
 <trini@konsulko.com>, Akshay Belsare <akshay.belsare@amd.com>
Subject: [PATCH 2/7] spi: cadence_qspi: Clean up registers in init
Date: Wed, 28 Oct 2026 16:41:09 +0530
Message-ID: <20261028111123.1198451-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028111123.1198451-1-padmarao.begari@amd.com>
References: <20261028111123.1198451-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|AT6PR12MB717548:EE_
X-MS-Office365-Filtering-Correlation-Id: 1395fd09-3311-4cb7-d05d-08df34e45b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261021121427099003|261021123027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: whIppBZIy/UL9cBNGwZfjGWVfGPTTf6awwueFDvyNyH4YjG9eefcsWgH3fjEkiCI13Me54jmnX5CpSrp7jZApipFuIinuB6d/hZd/7vwcEbla9r9hS1pKTcZ7TG7ZrQwkSY//+/y+Meo+da4pQ6si7wn9+L68EZkhM4L2a3uU/CPQf/W5cRZTS7tESWrfpDQYyOyFRjPloEAxIGnhEhV87CLKixkO2Pty8GwsenOg+4KMedOAin+inoK/H+NZXZi2WQW8cuRhOTwIL8d3vM9Lr+/K2MhWGIKhJr9V1yHxJrWUldj0d+8h6sZix5M1mLAAKvk1z31F5qA/eRaqvVGpMDvX8LOsB9f2S8Ojkqb0Zic67v5We3ClPdSQKg2P5PdslSyMc1iw5/l87XtEMFG2NGn3+bbYTbWtY8AdflJKH7abfoabptZas8IUumpNVd9YYHlY88AO/Mztt+rTEGh3JF+9Dn1lH9TjLXRdVQ41oPWpSKJqFJZP30AUAwD7UBEIzdTViFxpeiinW36b/wxGlWxsFMBu4z34F8OdM8KH03Pwef3L3p2v7Jfvei3tAkz0SDup8wkCNpAYi2BMiXNBUmjL7Xm2YBhJq3mV5gecjuXPy2vn7u2xXwLuIJDZWvOtBPNfInd/GNxIrnUx1pHIYR4qK6dbAwBbZE/YYfe1qo0t5zRR44fS7VS3U9DKPTl7bSLaGNLesbe/Fq8LE1wKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gfk1itfh9SNtBO2wOxdDxYVlFDKHp9uLV1maPVHaRyXGUdP4qewCR/qn/5EFzCrR13hraypsWLOHnV0Vvr70mw8q8Tnj0vBVh00pBdWIxMYgjefW5FSpxyK3ik+lIoZFm5ehkw3htJWOCXaD+bsyO7TXewXbIaGNYuudBx134/8NStZzXddnHN9SVDQdcaAAZHVGrzCjh9cXw1A64fzUMkxD1m/cZg6t2jlDHU/lUFb63r61zoBktnTI/Qxut5HdXDaVYO2zquq185Jtd2nsIPy0cCGJ1bJJ6eAORb61VBd4eAbzzbT0gP6ZrJanEhia4ImWc9KOuqDzogtRTZdule5+pigbntaUQlFclrQnlRbdXvf5z/TKg+2q0s5qcjvQSlsk4xZr+8YxUKKype9LGen2fKfbAl9O3cKcJ5Hestyarf4/YAnuCjKlWBGp2My+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:12:29.3049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1395fd09-3311-4cb7-d05d-08df34e45b03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT6PR12MB717548
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Clean up the Cadence QSPI registers during controller init. The register
contents may be invalid if this controller is used in a previous boot
stage and U-Boot is entered after a soft reset (no power-on reset). This
may cause issues in U-Boot.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index e2a3ed3e018..f977dfa08e9 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -344,12 +344,35 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 	/* Configure the remap address register, no remap */
 	writel(0, priv->regbase + CQSPI_REG_REMAP);
 
+	/* Clear the read instruction register */
+	writel(0, priv->regbase + CQSPI_REG_RD_INSTR);
+
+	/* Reset the PHY delay lines */
+	writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK,
+	       priv->regbase + CQSPI_REG_PHY_CONFIG);
+
+	/* Disable the DQS and clear the read capture delay */
+	reg = readl(priv->regbase + CQSPI_REG_RD_DATA_CAPTURE);
+	reg &= ~CQSPI_REG_READCAPTURE_DQS_ENABLE;
+	reg &= ~(CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK
+		 << CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB);
+	writel(reg, priv->regbase + CQSPI_REG_RD_DATA_CAPTURE);
+
 	/* Indirect mode configurations */
 	writel(priv->fifo_depth / 2, priv->regbase + CQSPI_REG_SRAMPARTITION);
 
 	/* Disable all interrupts */
 	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
 
+	/* Disable DTR, PHY and direct access mode, clear the chip select */
+	reg = readl(priv->regbase + CQSPI_REG_CONFIG);
+	reg &= ~CQSPI_REG_CONFIG_DTR_PROT_EN_MASK;
+	reg &= ~CQSPI_REG_CONFIG_PHY_ENABLE_MASK;
+	reg &= ~CQSPI_REG_CONFIG_DIRECT;
+	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
+		 << CQSPI_REG_CONFIG_CHIPSELECT_LSB);
+	writel(reg, priv->regbase + CQSPI_REG_CONFIG);
+
 	cadence_qspi_apb_controller_enable(priv->regbase);
 }
 
-- 
2.34.1

