Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667BBCCF2E0
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18D8880FA0;
	Mon, 19 Oct 2026 10:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NiAK_LJbpzxD; Mon, 19 Oct 2026 10:41:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4D3A80F4F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792406476;
	b=KhhjvWksOUIcDfjJSXAk1E3wD23mHon/5h4gWny5DOhpvIDQ3MZFI9sJzAoU66A+Xoul
	 6loUUz5F+W2aWqCrLbpqJkpCLcOAWtwtALV3rDfOfVjVJSW3N6eBIoMWpuRNWB0t/ECdw
	 rtLciK0Hlk0xsrK2Wsyr3Z0ITu6/bfih/o4AnO66f9wxfpGfG0q9MMX2q+3+4cIYWSQjw
	 CUeoS9WBqE6zNAeglZ7wPRtERGm2VEpmhbUbRz0kGlKzKB6Buo0bcL9pRBMQqVbqS/QOh
	 /DUWlUoh6PRMWMkRwMFvpg/CR8bHCRkAjAV2hL/5XVuvLyUhGA/EHj9DH7EyYO9t9+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406476;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p5KVk7LI6XfvhLrWszrusCIPRclSIyFgi/Eo5wBlfQM=;
	b=ZtOY1Fpy/y2t+s2oWK2hcYL+PzuT3zJEcKEal/CCz7osjntxtC/RJuu5V8ax8rr8QxVh
	 PcZFvHDnEBJNZKBlNGNcm9me+dqcRZNPwH7lSupKG4iMOJ4E5B/8YeuVfdn0IexJasnwW
	 wjMrcytC72U27abULKc7kSzA6tlifMxFWKPKUPPcE0UOBgrZeP4Cfo+fi/iuWo6ecQC+W
	 8t2SppxIP8yeHOwnfv1Nu0OozGA3vfttR92o3MrsV3/PGyJytAq0FaqyMtdo7wM6K7jgu
	 UCEmpY1E25H5y3ghfaCjNylcsYz+PPBLN1gT3o9FnvWSDbxzMrhPh9NUfAs5qN8TrBg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406476;
	bh=p5KVk7LI6XfvhLrWszrusCIPRclSIyFgi/Eo5wBlfQM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IZ4ffwIWbdtBV8U7yrNIN+rxVv4Zv9xfYbp0RRD/cjg1Mj9GDOnQK9Y5GcS+NXMpK
	 XNV+vmPAV0zDBg4fOx1zy8lHZqTYqd7ztFeOALHvd4YCosTfoX9e7nqjzJpbudPlKb
	 OVGUNH0ULQyf8ghz82UTqDao58RNGyAQxCR/ABGYMspuz9XDeuRKJVAG5VV5imm2rM
	 OkDJHQpk53JdehNoWIi/MmSi2ZDLYDKqu2kjkiwvSxfENasmn1kIlZLWw9QilAE35d
	 rGjZBnTwBMEo3iJ3t/RShjrKUPPkMh97NbVLfvOPeDKW/8v21653+AYoUD/1CNSlWA
	 Q1tH4ulvCasvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E4D3A80F4F;
	Mon, 19 Oct 2026 10:41:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F31D0279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E528440080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:41:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b_rwv_e53_-Z for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:41:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D5ADB40079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406473;
 b=etIPf3IjmVvcPTUHr5b2URnDkkFRbZnhC2gm7hXvJkKSbgjg3NoTc71U/2ya8CKNnte5
 2/7nNkQ12rGwIuW6yHYMz4FR2CFlbrC4f68Yr1B4d41nu+25utgYKT1mi5q6+N0E9BCRW
 nj4C1In8rYnZzcpQjeETbJA3K3F/H6cXy96csRLG9XpOVO5aA3r4p6nSiS9vqmnKPosEN
 nrGZjl5ihC3r2JH69taVlpAWBqfHAaZM5LB3Gx9RzasbNzkVJbhxwkD5AZrsR5WvGgwNt
 KrHEqGecuBKAZaTu/so/XQ4QFBYTYHcTnNc+OCkH4C2jQbAPkiAKwlDRkzKY7m0FBBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406473;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=p5KVk7LI6XfvhLrWszrusCIPRclSIyFgi/Eo5wBlfQM=;
 b=qqC091ihFwOtr78sSuhw3CLq5NhUVHfgMH3cgvJy74uCX0lze+ROSIkcYYsH5WGIhr2U
 e7CJtu2YU9jJJMp19xSGbJ1h0oFv0c81Gulldhpu7bDt8/GQLWVv3KnbSlWF+x1rEukNv
 /RHjisnMdjKl/HSMi4r+yJF7o9oQOX8Dk+Nwehg47KoYA7SvSy87hILbQXwG76Nhle8mJ
 TfYNmzFpUvpQq9dQhjTx0SBIp3aNwGnalEPKcJy/bJQUPUNfPhcIQNao+dpG6n2HzrkRu
 qON/OOrjD8RW0TvZXzZcojUg/aUhDlh7QOjfKHS3qAJgaOzWDh9tqgl7yY3QKD45bsw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ozw4be1I; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b="qW/lbJSI"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ozw4be1I; 
 dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=qW/lbJSI
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5ADB40079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:41:10 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8NuYf3456546; Mon, 19 Oct 2026 05:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=p5KVk7LI6XfvhLrWszrusCIPRclSIyFgi/Eo5wBlf
 QM=; b=ozw4be1Ia0yVK13tnY5oRctWT4MYsRN32rtjWD+QSK6K8uX3vuWnWU3aR
 HdGycCU/WYXaIsMoEf3jLdv2+fDz1dEA03yuZ/8ZpgBOjmYE1+XJOHJSekv38nHZ
 uFbdxEiNmyAAmcXCRJp6q2RC70zOXAWHgLausFVYVgdEuKMsNA/GdIKxmmjIkFjA
 zr3gqAGRQS3NrU8+RpZFhHj+saJJPVITrn1zca70VamwRdPIi9q24PpCOmnjkgHh
 TrXgIy55rOnK12RVN4qaJ+enA5XMv7//a5Z9MZSY6tOdYpUCOLFCLAIVeg76dvDp
 sGhQthTlY0MJ7vS5HSiKo16sPfv/w==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcr5p5a57-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:41:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZpSTPS5PZYmJiVZ52iqo9WPfHEYVf4RjZKbNpRv69GfwSKaUvXHgw+JuBzZYgX55r1KiGaNjVgTwN+wKOJQJP7kd3LTHHZwT3pdArzzrV5Z2/DSJFU6kFPfQUp0+wN26PAh/jJGQJtELrc56hqeW5bmvKJVakpotE0/AlLeTXfmrHcFbvIIfSrGX7S/16yjT9G0NLp75JOeTWuR/vVjX0+V7PFs8jIKJ/iLMG5L/WZrs/kf3FPFjJuhwiAO5TMBRtVrmZIZqhdh+wpfOCyQHiyl7t6rP5Lh7lnzgyK0juWg6wfIm6CXP3bp/fNXT5yYzmxpQyxUhwIexPDkuwzJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5KVk7LI6XfvhLrWszrusCIPRclSIyFgi/Eo5wBlfQM=;
 b=XkjP1h5GHx9jgCwl/nGQe/oh/PqcoYdC9mc/uTfxN0RxNdzOlATA5JAlBnSOWTG/r7I4q02Bk/SbbdeieZLSIleUt+iiwkkeqaH0NqBb7IHN06w72K2TxJHBFFBFHJgV45+LIqLxydFRKqagxahhjxNB40lQbQ27kGNhWhW9xYBv+pFjd2JBdULZg8sh0IGzBxuJWPiInGEk57iQ1izK9qEu1RHByhst1ufcFwxZ/xeMu7E1gpf0IGZ+7pX7NHswfl1INV4p96zmBa94VieRMG57jmzAjmV3MOlOH3k3wsuVI0dnpC9oTKgci31Gre1d5vqI1oQZp5QsNiS8yCrtsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5KVk7LI6XfvhLrWszrusCIPRclSIyFgi/Eo5wBlfQM=;
 b=qW/lbJSIuo+z7ja0Pyfog7T/Ff8psV1yBOYrW1dBTMnvmtCtfc5fgwTZvAwt6v6HnHE6XRTmIRdvRlAJjph+poXdJKKp4/4dUgN8fymoo7qulcK1AdZ7iQbd1uUqxN7h32KkbVDQlxSmuJoQgOpC2+tj6fThgXBEjR8WrzyIFg8=
Received: from PH7P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::33)
 by PH8PR10MB6552.namprd10.prod.outlook.com (2603:10b6:510:224::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.12; Mon, 19 Oct
 2026 10:40:46 +0000
Received: from PH4PEPF0000B60B.namprd21.prod.outlook.com
 (2603:10b6:510:338:cafe::1d) by PH7P223CA0025.outlook.office365.com
 (2603:10b6:510:338::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 10:40:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 PH4PEPF0000B60B.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 19 Oct 2026 10:40:44 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:40:09 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:40:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 05:40:09 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69JAdgTm2629975; Mon, 19 Oct 2026 05:40:06 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v8 6/7] arm: mach-k3: r5: common: Invoke boot of HSM M4 core
Date: Mon, 19 Oct 2026 16:09:41 +0530
Message-ID: <20261019103942.2497201-7-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019103942.2497201-1-b-padhi@ti.com>
References: <20261019103942.2497201-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60B:EE_|PH8PR10MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7a11c0-67fb-4c73-0a8d-08df2dcd6e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|261009223027099003|10067099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: HlMPwjz570CzN1PuZqLH5zDK8fCQSzSO5MC1P1WCPQIMUP3dDGTBk1Q/aGXWjC95giwpsuVxzQlD1sCjODkCrWZVItyJ+ApK/atVISlOAmxNfv5JBmQljKKTVxWenHRWPqWREeC9eiEgSwggdRH8Th/SeX91V7JV15OkFBm5UnKCNNwTgL0UjvBn/iVWUo43faPzr4M91pI2ITXAkT8jKSpv8K/frYA4ZmSX1soWNr0EE1XiKT2qXR1p0WnvqmCEyUXdWCw29SLXJBFCRAGqz0dHOlyOYBLalPiO5ID0nnqV24tw/rW3r8kv/iSonASYHbd9oKGszEXJ036zULstrDN0aPHGdHuDQu4JmdlDmDBnZmYZ4vME7Y18CtkJuv51PVt6xAbGO27SHXYaHkdxMiH4Fh+fJ91HZAr0TbNmJ3h7Su0EK+1rKgWst2bRfuMjBnsn3kAc8RiJpDKFl7o0A7p1D5l4zCXg9fVtCIpzIsuAD/jyYTq4wiXEl67LvY9hJHFlI4KlDtU8EDQ1wgojMZ9yN7gcBH7OguAhKL1/nWLXOwHsLyv//uhmQMzxk3JFQP6d3m2U5ABvnVVDIFKbrjPUgsk/TMY3afOo3VIBPgScyJLx92nT4kXwudd69yiDEadcdmYZYnCu3tAgJSfrJB1csBC4eqPsk2FRcvmmS1Y=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d1qUVxVw0JSKswINnEQ6PaREegUqYYLYg19v4Q+dNho4kfrp2mW2k5CWCxoTHSau7b6Zv49VYj6gyZXAB7IN+7cDsg38ee1sxqpS8dBk5Y4uXSfWecG5HwKcowkWYeQh5Keqz7+tC4nz+nW4zXYHoPlV4KrAQB+qJpAYlJCuUg8dc4slABBhX1dPCe1UOLoGAFkVPeV8NKQ1n0xJqqQiTL4CI5LnbK+iD0qsES6vFpxc9JVfmjkx6ArbubX0ADvYD4mK9msD1SdTPc3FdgrLvSwN3NWHwN+kPJfFhBTXvJZ6fQ4DKiomzMVNmSQjDMiCZHESIpwxwGzteV5Fd6uLixYfgqeWXDQVfMjxr4zUeBRXTVNuXL5AHfns3PKnEFvpk8mwzgkBHVy8LiLR0Sd0Or1aeeebGeyoWdOGZfdFrgiy5MBvKTex7s64v1w77Hiy
X-Exchange-RoutingPolicyChecked: 1b7D+jyeiAEVLPMxlbGyW8vptCbLFhYSp3IasKLOPwJ17ieQu+I1imGVucPBfk38jspPOBIr2y4Jq6BFvLoDTXnPl64TXZwbYq9GYCK202/bd9giThF13bIgoyQ7cO/p5MXk41dDZmTT7vM83nBrb+6GD8JETCVTWq1XPz+xxLjlfLXOxxTW+2HuPu8BrwMWpQGYeNm7sAxifEQtMeJlVXQ0Zp3etMexjvd/ufly5zDYcyWzSC5ItLbBQTj8mahwlm2leiRtNb4XzIaanb2r/ATRcKd8xKY6QqZmAa4oxUUVkc0iMtf592ScgH3h921wff3EGdPFXQZzm/vShwK0fQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:40:44.9305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7a11c0-67fb-4c73-0a8d-08df2dcd6e33
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: PH4PEPF0000B60B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6552
X-Proofpoint-ORIG-GUID: Kw6pgAzWzAh7Fm9O0xl-PXQD2-PTpKZu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX+38rwiKhI/PR
 40Pz/I/nxLMPfNKoQc6jrPcETEzAkcMvABnSkcvY/VrPdPa/QxPVEJZUcIcb5oRUi4/lSwCUND6
 +9+tJrK+VNHRhDAvRIQgZTuNWIXZe6Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX65BaeiJySGkl
 SM+xewpmxmU9alIbQp4DMJh8KQ2udud+q5konq//2RoDQzIv7pXNJZtbvq6XYRyNsW3SUVvTrUL
 NcHFglOhiXazsEDORf5FTmk5FzC4ML9U6MgFDfMpgKFP+AU3laZgp8VDguKlbL/LLlGwcnM9baa
 Etl4mdrjiUGUc5xTpxdJOvhlK2Ohsq5K4Rsb0vc9pztlbloZhGziaeOIKkjoFgrgV3PvmeCBQWC
 iSrBxSb0cbzBxN8sBwrSSfRE47VdVX6Ld5blknyHUWPoBZEbQDdPb/XrF6vizv3k3OCmQeKBZgw
 JrE7E1t3ff+alQEtxMTCL/4EVT0zaI25Qk/Pjizau18EMn3OS4jbDg9WhwbKuRYv2xP9KvuyN+z
 qw/Ntzc8IAxL5ECdTRLV02g+c0jngP1ze3uQvIgL52dIjiIbWPSV4PMhyzFhbwSvNed2Pr15fAD
 ldkuj8HaAFRckBAK2Og==
X-Authority-Analysis: v=2.4 cv=Fp2QbGrq c=1 sm=1 tr=0 ts=6ad5f3c4 cx=c_pps
 a=uwUl5xS/OuIXHPkYzYKLCw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=voM4FWlXAAAA:8 a=cm27Pg_UAAAA:8
 a=kd79XEjvzcn9TLE12NAA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: Kw6pgAzWzAh7Fm9O0xl-PXQD2-PTpKZu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190042
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

The tispl.bin fit image is packed with the HSM firmware image. Add
support to load and boot the HSM M4F core during R5 SPL stage using the
remoteprocessor framework.

Add IMAGE_ID_HSM enum and "hsm" OS type to detect HSM firmware in the
FIT image. Track the load address for all FIT images. Load HSM firmware
to remoteproc device 2 and start the core using the remoteprocessor
framework when CONFIG_REMOTEPROC_TI_K3_HSM_M4F is enabled.

Skip HSM firmware from R5 secure image authentication as TIFS will
authenticate it during the remoteproc load operation.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v8: Changelog:
1. None to this patch.

Link to v7:
https://lore.kernel.org/all/20260922084536.2477291-7-b-padhi@ti.com/

v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-7-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-8-b-padhi@ti.com/

v5: Changelog:
1. Optimize if-else ladder for logging.
2. Call ti_secure_image_post_process() only once for HSM image (during
rproc load).
3. Add R/B tag.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-12-b-padhi@ti.com/

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-11-b-padhi@ti.com/

v3: Changelog:
1. Use remoteproc framework to boot HSM core.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-8-b-padhi@ti.com/

v2: Changelog:
1. Hang system boot if HSM firmware failed to boot.
2. __maybe_unused to decrease preprocessor usage.
3. Better error messages with return code.
4. Added Error case in if-elseif-else ladder.

Note:
#define PROC_ID_HSM_M4F seems to have extra tab in the diff/patch.
But when patch gets applied in file, all of them have consistent
tabs.

Link to v1:
https://lore.kernel.org/all/18e01808-499d-4690-995a-45ac5fd727d9@ti.com

 arch/arm/mach-k3/r5/common.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 13736ca5dbc..aedde7bda3d 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -28,6 +28,7 @@ enum {
 	IMAGE_ID_TIFSSTUB_HS,
 	IMAGE_ID_TIFSSTUB_FS,
 	IMAGE_ID_TIFSSTUB_GP,
+	IMAGE_ID_HSM,
 	IMAGE_AMT,
 };
 
@@ -40,6 +41,7 @@ static const char *image_os_match[IMAGE_AMT] = {
 	"tifsstub-hs",
 	"tifsstub-fs",
 	"tifsstub-gp",
+	"hsm",
 };
 #endif
 
@@ -158,6 +160,23 @@ void __noreturn jump_to_image(struct spl_image_info *spl_image)
 				     &loadaddr);
 	}
 
+	/*
+	 * It is assumed that remoteproc device 2 is the corresponding
+	 * Cortex-M4F HSM core. Make sure DT reflects the same.
+	 */
+	if (IS_ENABLED(CONFIG_REMOTEPROC_TI_K3_HSM_M4F)) {
+		ret = rproc_load(2, fit_image_info[IMAGE_ID_HSM].load,
+				 fit_image_info[IMAGE_ID_HSM].image_len);
+		if (ret)
+			panic("Error while loading HSM firmware, ret = %d\n", ret);
+
+		ret = rproc_start(2);
+		if (ret)
+			panic("Error while starting HSM core\n");
+
+		printf("Successfully loaded and started HSM core\n");
+	}
+
 	/*
 	 * It is assumed that remoteproc device 1 is the corresponding
 	 * Cortex-A core which runs ATF. Make sure DT reflects the same.
@@ -330,17 +349,19 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	int len;
 	int i;
 	const char *os;
-	u32 addr;
+	u32 addr, load_addr;
 
 	os = fdt_getprop(fit, node, "os", &len);
 	addr = fdt_getprop_u32_default_node(fit, node, 0, "entry", -1);
+	load_addr = fdt_getprop_u32_default_node(fit, node, 0, "load", 0);
 
-	debug("%s: processing image: addr=%x, size=%d, os=%s\n", __func__,
-	      addr, *p_size, os);
+	debug("%s: processing image: addr=%x, load=%x, size=%d, os=%s\n", __func__,
+	      addr, load_addr, *p_size, os);
 
 	for (i = 0; i < IMAGE_AMT; i++) {
 		if (!strcmp(os, image_os_match[i])) {
 			fit_image_info[i].image_start = addr;
+			fit_image_info[i].load = load_addr;
 			fit_image_info[i].image_len = *p_size;
 			debug("%s: matched image for ID %d\n", __func__, i);
 			break;
@@ -356,7 +377,7 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	 * Only DM and the DTBs are being authenticated here,
 	 * rest will be authenticated when A72 cluster is up
 	 */
-	if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE)) {
+	if ((i != IMAGE_ID_ATF) && (i != IMAGE_ID_OPTEE) && (i != IMAGE_ID_HSM)) {
 		ti_secure_image_check_binary(p_image, p_size);
 		ti_secure_image_post_process(p_image, p_size);
 	} else {
-- 
2.34.1

