Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DA3C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9000760B2C;
	Thu,  3 Sep 2026 08:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kX4_jRnzKDJO; Thu,  3 Sep 2026 08:17:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9B74960B21
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423456;
	b=WZvEgqlahYBFaSbsVWv2QiVCWM197lzernghhWBevkwfGp9VjzrCM9BwdzbA0Y/qr4HL
	 WWvyvknJP72g+l4zI+xKAb8bfmwNsaIqSH6HzoIuZ64daf1r5RP4ondQb6plGDzqFVviP
	 zPOgErqfMw52OO+K0+Ebj28EmZuBcG18M7zeeLEhjsmbyxYqIGD+jmcOWDeEpN3jECt4R
	 yhvaRMUuE4LDZ5TMDVYVLctXOEuKm17wg5mO87AIlTRbmuIRNTuhGBShwymB5Sci3GVd4
	 xnFSwPlxRU12q/nfj54znG43zGdPaeTBBscLOY4G2m2W+ON9fV7nA0mZT1qWB7aZ9pw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	bh=n2Hah7R7PHu6UwQFEGDJLv5laxPOvP81vayzFjcPWcM=;
	b=XcS+teUD3hFMJDdm84d/kFAMmfZOO0g0rv2Ifi56YZRwsXs9VhSDAW6Ed1/dYf7OngOy
	 tj73R7XIwHRK7IcWuGs3d7gzm57r8jZj+zCRLhJrPVqFQwDTwHM1ckcF3OXtTck338TQN
	 CsgYSiVCTR+8ANOuqqnGDCjIE59UKBkMNK03dt2bjomVSWo8D1BqYrRHrX9Zb6SNRe22Q
	 g3/gRKfJn1u1vzLSS4eIqmFk1Fpc0mU6uGkn4RLJ3QknR5LmCR3fNjVGg0gRRkBNVTHCa
	 Uk7MwZE5JSw3o3bA8GZPgXcS3X78SeZuP8AV8hqV3KRb+IR0v11jB7GAjtVDYQjr9Bg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423456;
	bh=n2Hah7R7PHu6UwQFEGDJLv5laxPOvP81vayzFjcPWcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zYn8yr3RU05KSWAzk1NBVfeckBu8GvNokd69u2ixX/+Ahkl/x12p/UtgVtqL00hec
	 5s3t9d/7dt8ZoD+Kmzp7SN9asXr7v69aenC5CUKrSoYJg29j4kgwuJ1lQhuvk58zNZ
	 uEs2jzfq4zyj0p9Kko1kNeBigbi9A1F8eVlWGHhC6FOwatpsOVz2PdLEd72WbvpZLq
	 tjzgZzXeNrYzy57DtiPQusq339UUQveGV4Q5un/ueOepZle/pTO7+rbsWZLYNMkBIo
	 1hSKWEYagdYsUXhGWInu1wbYeInsRF4mfDFTANCK9WLtnfPXMyC1xmBP2VnrhPhXfm
	 7ve8lSJYZSASw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B74960B21;
	Thu,  3 Sep 2026 08:17:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 09DDA20F5
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDBE0403B7
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 06kIfjCDlM4h for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0F4CA403BA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423442;
 b=QKFrA4nUPJF5twTnO++4JWkelBWcBARqquMoDgoLF+gfzkdIKVK/rIbsJsTLVET2uJWC
 ST/UOrN53DBKIWSEEi9y45sNUGgLxbc0VzXOKV1Q53dmV13z+QAkCaToWWHIVFYAXcmvo
 jMYIDqq4NUUMTZ51nCVJbBJMg/Xl8xIvNdJQIWNzCPPgBEl7FaqkXzyCCiTOW58FmTZmS
 8aO6yqGd6a3PsoYczjtFz/uis8Voi9d107TTwSWASsIcWOeq8r0iiwf2SQqwaJqunrRS3
 4CQSwa/AoIdX3FKShXZtlA/d6FPzHC+5u/jkrkEZGa8qMoa5I9YXhIi+uh5nLFqxjNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423442;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
 bh=n2Hah7R7PHu6UwQFEGDJLv5laxPOvP81vayzFjcPWcM=;
 b=iAxH2xfQN/CWIwxCFZNJVB0X44HHN+z57N1IY5bumraaerE4uMcvNbfFfXLe3XIePZ7R
 6+Tky/PEGqCnfMXealOyb7AtgpsP/r7spAb5aNxN2eqwXRMA63r2BhZQreXAbQl7NrKDF
 ujLsg4FlCYHcPHZHukeiYwtw2RZpIQYUvxW1qHPrg0/4BRjkINCPHfMkm/zWUOag5WSA0
 RIm2z4nORi8fxtRgbSVhARCoFh+wjVahd0rw6OqfZYF5kS6S1qmcbh2SH5VTqr0u6Xco0
 NZTLoF7sSpB1YQoCfAzfXeAiExp7y3Ge37QSDdY/30TUBcqVIU4uzJWv62t7Z+sPZSQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=L51bCLsb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=L51bCLsb
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F4CA403BA
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXZvNI7UfMWk/NQjRSuk3ad/3yUJl7AdgrpIfRvRjN5SHKM7y3P80QzPbabZyxNgq2LFSJBmCBxnTMTpMmDxITXzUSWawtYbozflzXPjddXihiTr4KQhPNexKubyBGerhmiPD2ojjuwp2rWLVyfYIwHqLKBPnCISn/fgbYvsWgc1uBHv9MBpIhELCgC3e/E/VCBQCOnpoAEhuwYVMNoy0X3ouKz/50gZzQrNynOxns4jZ7mftetG3bIDuClD5jz5S4cPK8LbxDKSu6pbhR7wfRH4AMwVbD4clRE6NoKekoTYNX/QEnujYJO0576VlcfSFpfhcU/KoEYD0tO4KH+8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2Hah7R7PHu6UwQFEGDJLv5laxPOvP81vayzFjcPWcM=;
 b=kUEzP/3uwHKtgXaj8Nn9lDz30R2ZvP2WhQlUkk0bDMhlKXfefAfQqzccAwt0wZdHxhfI//vj0zJpXITpRv7bjya+vyLuleIoTGrf/RiIpIf6P7pfO+l+FNyew7oaDoBlnTSoMn8iF26L6FLLslNIT0exivQiLDkl6aXO8TfhFTDiV3pWHEveN24/2ymrXL0YkE6bzNCECZikbMviUQ4Bm5TIc5doJPj9XvJRV+eUtgGrte8x+kcyqpGTobIPG3OZun9ytJoIhzKSVCgYaMNkzE4Zi+TYjDdZ0MEo8WkY05zggGATE3ZvVpwRSKlfjSOh2WHM0hCTWSmiNCzhAxduww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2Hah7R7PHu6UwQFEGDJLv5laxPOvP81vayzFjcPWcM=;
 b=L51bCLsbursWUCKHUfsX8kbENXByU+M2x5OEkJKowiyLd2wI0Z5xdzEH/KfelpatTdBDURD/kfc4mEGGymMu7pd0PJOTJ5q9rk6vt7OavQA2By+jdNn+9MtWHgqd4QKTsGcXrRaGctgby4PlhdbAreXpWXfnzdeQli6IwGU1OXST/eQukaD4A8b7jwa30vuC3SrQoeRUqGFNrB7QrJhx3bq+jbPEK+/LLHNcoiDYIPTXjb3Pror5ehyG+eQTtM9a/gMwZObW9Qa/phTfHNqMI4g0iC6wzMSgrRpEa68AAedv8zP2R/5MYejNIbm1ntlfcS79kp4CTQ8OR+Z2fpmMIg==
Received: from PAYP264CA0034.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::21)
 by MR0P264MB7563.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f:cafe::6d) by PAYP264CA0034.outlook.office365.com
 (2603:10a6:102:11f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:17 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id EABDF2010C;
 Thu,  3 Sep 2026 10:17:16 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 09/15] tools: fit_image_setup_sig: set required_keynode to
 -1
Date: Thu,  3 Sep 2026 10:16:59 +0200
Message-ID: <20260903081705.12894-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|MR0P264MB7563:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57244c11-7288-43f0-4bcf-08df0993c47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: w0JlDCf5r6ZjBtH/ypcwF8iPCQSPwEADb41ohtjyJ418Xmx7mPKubtqvchtsj/5X/fA74dOdz9j/1dbUATyLBpEeOlCMQnZT3RLMfdPYdi76Rd9HTJqqFuR1tpaTykxpEBDB8v+7co7+f4FP67/vqsCLxh0e7egtXRareE5IfvnSh3+alQlo4Y7wng3wTnRkheA3qkEb0CJdF3IAHAl7OKVNFwEI3aEfff1ZNS4x63dp4XrG0GO+94XNdQ5AQV1iChycXODz4w1yvrslRI0mxgRCcaGXm2X/rE3hFWxBHkX3z/xWMKDQfPive4AeD4b32fpnwTPTAY52BDtj3dAUTtAeKJGztfAeBV8obGD44+uFc/PkFVOyXoNS58yF5SXZ7OaH3X5EdaCn9B8qbFUHw0jdWi4UGILsBnG/GTf6DakhS/8ZLMvdFy9gzpUGnCm6VFpcRTpepdDR7VJmJL/RdkS5+LLkn1S/eiKC48EpPvS3OfU2LNpl2RCUOqzlVwA/syRqNGcsouRjL3NpAVS5uWXyOOleGZTY/h3j7RWWsUx5U/tbOymy6srkkYIRN9pNsyPpNjHM4SchPUCgubOCVHwLmD1Us4uoKPZI8Di6SeSaTSg/sRAtB6/2BgLS4S+zrTpKppzhZB/ixqmCGLj5x24W7j1rvUuKJbNW5+SEyDBmwC0iwGBxMQ1rcORT31Jy1S7NHabg7vgjdBMEEOk6YA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5UaIe/jh9YApduxOfDfRy4JF0jffrb/WWDaN049Sih+NZOKcpFZYTazdDrS0NKXb2el4zj+upEOYLHiSur0toqULfyUgXelevPwW42jYMw3/E/tZxQUbfywAB1fh2S9AUrRGfSegOeH+zqkWBDKn8gEbSzBlMVIzlQdn3nDQhzWUEtnQuaflNKQPmqtmm/oPmtLKdqC9SAJv4t4mDW8n9/m6ec1gzAkxqYVyGnE2HG9xii3SxGGWJBWhmCqohKqlB9fVYm4m32wC7BYRXc6q2YLbWMh3zquKiv97kAIqFwGXM3CKh/O0gQ/6C9JnnJPid3haVXUwse9Oc+LG9HmHSg9JxKC+N7+VdAeZt0mWcWRBfFCOky9yneevZXHTKnq15ACa4ONFGvRfS4DGeN6KHBCdAsZXfhMk0hnX+gGwp1bmtToCCK/Q3/GtZlKDGpQd
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:17.0865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57244c11-7288-43f0-4bcf-08df0993c47e
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB7563
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

When initializing info about a signature, set required_keynode
to -1 instead of 0, as 0 is a valid keynode offset.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v5:
- initial version
v6:
- no change
v7:
- change info->required_keynode > 0 to info->required_keynode >= 0
  in ecdsa_verify_hash
v8:
- no change
v9:
- no change

 lib/ecdsa/ecdsa-verify.c | 2 +-
 tools/image-host.c       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 494b60b4ab0..341486de2d3 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -117,7 +117,7 @@ static int ecdsa_verify_hash(struct udevice *dev,
 	if (!ops || !ops->verify)
 		return -ENODEV;
 
-	if (info->required_keynode > 0) {
+	if (info->required_keynode >= 0) {
 		ret = fdt_get_key(&key, info->fdt_blob, info->required_keynode);
 		if (ret < 0)
 			return ret;
diff --git a/tools/image-host.c b/tools/image-host.c
index 46036673050..9a85a3dda2f 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -202,6 +202,7 @@ static int fit_image_setup_sig(struct image_sign_info *info,
 	info->checksum = image_get_checksum_algo(algo_name);
 	info->crypto = image_get_crypto_algo(algo_name);
 	info->padding = image_get_padding_algo(padding_name);
+	info->required_keynode = -1;
 	info->require_keys = require_keys;
 	info->engine_id = engine_id;
 	if (!info->checksum || !info->crypto) {
-- 
2.43.0

