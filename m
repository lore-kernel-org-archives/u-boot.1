Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A863C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 18:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DF4760736;
	Mon, 21 Sep 2026 18:56:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CgmPyWOxUuzp; Mon, 21 Sep 2026 18:55:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6FEF560738
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790016959;
	b=rZ9FCuhfMgi8CAzbNiGRbu1rAQC6Qzn+6ZWXpg0XSbd9Ojz6gfy0qtXxSlF5caOAEI6Y
	 en8mGX+OJyrMU2bJ8E5BQSR3UUZuB4OIXz+tDZqx88UWWiFHJyKzoRnHaOs7ZMcDbJC77
	 doEH+xk8TsDhknoPr3KhPCgP1TNkeE+3rEFM1g5q7/iBB+4ZGgVUVOx67rZTY+FcevKVJ
	 YmB2chEDSSNZxkatcXLOLCXs/ZxuOzfSvc0Y/sPJp2lsdC60DPk0t1N8DiTiWHyKht3dc
	 PX60uJ/NnzSJrBIm919yE4D1BaGWaAi8tSmPDBlLip10tJd8K9z4+5PKpkN6UifZTMA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790016959;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=JfzqtN8XZSQbkFMIQnOmhJ8seumNSu+5bWX3IpVIY0k=;
	b=pmjtMeX336WP7Ptb6lwZmIE2KL29JwMz0Ja9xzNB2/mlz+8zRZ5j9WdSWdrNCmUAxAXw
	 uqur3P6N4Gzrsv9qnWawymQkduDYT4Sbx0Qqbzi5x/0AB2nnTHZ14WQejVxFIG16U0GTj
	 cRJjqffflRAts56X/5fgk5AAqBXLIUJluFZiwAwULLDiFRY8x3YbmXKPrCLnvFgbJ/a6F
	 IhF9HLAK45hP92wP0Fc22zjbiFZNrVh9Mz19/p7/KUmxMLe5bT/kwrHSzmxIjiOD/27UQ
	 cwJrv3ukp7W6gGIJEoEl0xgMMc2Ags9dTgfSMk5ybMVjilaF7KxPzl7JZCadYRZUpFw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790016959;
	bh=JfzqtN8XZSQbkFMIQnOmhJ8seumNSu+5bWX3IpVIY0k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WTRv02y0yOrY5DVcYIfpIt8sI8eXN1h8bbowqf4PSSHaLCIsrdf8IyvbpE6OJAUXB
	 I3rlyaGXjWrbGL6dAb0DcCmSaz4iOMu3bgLqAuemdZoHt7IOO11zmTRlOlmbPL4m0/
	 KIST73a1aZNdwFyH3nu0kUHP+ZtX7hCc9482Q2QQdhdTxZibZQLpeZu3wvhmctf+V8
	 kfNwGvzenVWtBK1IIMuX4MWwNcuw7488p29oIqaMVEEZiXate3TjVHcRhYIRgj6hPE
	 d1rTjPtNb5kmA4wtImUAy+6rVqS45LGpL3m770JIdkM5hF6MFPIZAE5NPZe+tWrefj
	 P+Fifz+hqNufQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6FEF560738;
	Mon, 21 Sep 2026 18:55:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BB083224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8720401DF
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C01Dtvv6CrER for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 18:55:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EBDED400D2
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790016957;
 b=mIhpHUFF6hJkER/YHsTuu7J4rQSJoyC4rLPn7Y9GHb87qiC3kdbn36Cf1voEERefWjLI
 2XYqee3odAkjYzCZ8qf8zknreOGadMpxauy8tv5BROjS7MYXcOd3EnfKD8ZmwkeNkcj1G
 G8R2OmGnSo9G2ZuydAwucPkJ4FJwWoY/gjrcPF5d1kGAGYNgWXRzsWey72a0DANYrat0H
 Yr4o/PQybJ9Qm8B1nBDOakE+F9Rx/WGfOi9SgsSUhtwqn57tvF9nFVtRPzJURD1a+W+NF
 KpYo3u1k0c+yanF4V7ry8TvKtSwJmXCtsW78Hm/4uPT0AzBWbzxST7S2LHhQivot45g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790016957;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=JfzqtN8XZSQbkFMIQnOmhJ8seumNSu+5bWX3IpVIY0k=;
 b=Jwbt7oEBBNbXoJtDR3Y76X+Vj9ZHc9tzoIaJ5iIZMYPPuayODiROGSNI2pnx4j2UW0ZT
 fbEBJCXSTUhaTZBJ6bQ+AZPUzYxPbMNXTL2kNQJppM5akZPmZTvyPAcZGZ9CO2X4Q2taa
 6xKlSSuotoWhzVeWJnosqRDeaXPGoT1TmZIQZHw4iehKDTr/BV+qo386Z+ZaKJDak2GcQ
 FicrXdE4vBoFya3t3ysWaVxEXr2vKwWNMMb+FJXjF7nzdtOxatLZF4/2PnQzXyYfpa+Lm
 PKmdxfnlxoBlOAHtGkK608fs3kWZn5rxbwzJXfxY/HVvJccg8/yV4o6sxmjsyXrRPOw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wII7OcgD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wII7OcgD
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBDED400D2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTdWPIuAN+2w208XPT6fhLbhPR1DrHL5JUzuxf8vRlNR07oLB+fbT0FmWiOjGzYBYNPI6a302z1spjhrkBAASZucdb0euZz/bbgvCp0KsE56kEKofs0euJB49zepuCK/bx+XZgFL8lhySu8X5we41kzvPd0AJ8bc00MrDtQ8g1G6mqOH/40JDCCsPXRDmFpp0ZEdkEgE+LibWzeZiEY57svoDsbic81H74UffiH45eiJibLdnrlMmblve9Y4kPEd7vpPA0e5yG7dg7HJ6zemB3qz9g3bXl+HhIpR/+UUGmXydYNwWfPtlR1U2lKWFZdcc/jTsU9IOOUdrKCocE+c+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfzqtN8XZSQbkFMIQnOmhJ8seumNSu+5bWX3IpVIY0k=;
 b=heyWqu/c3dU33tT9lwMRi3aJMrtZ/hoRerg6j8m7bwJKmp0KDy6Kn/OOQPAbKHnrPvFz/dXIXhz+CIhFHfUPGqx4L29B+Z50RBRMavdwTYFtsLsns3ObG3GMEmSLhI61SFbknURb4z7I57ddV5ywJJprNx5mPlRpqoYHJjVXW1rvL11yZcfMUCmP38T4g8qlgjDhm+ZdllqBlDBeYhDa1xgpJnSjTRhd8tYtgeAM/AhceAqbvhqQdmjKJfI4wzl0MF4wJN2dKIQwBkFdcpFp/6NfQc9o3RKLEVsNutm7q9R86mzGMl4XonaO7OcV5A8b9a0Xe9rJiWkQJ0g+AL17bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfzqtN8XZSQbkFMIQnOmhJ8seumNSu+5bWX3IpVIY0k=;
 b=wII7OcgD43GpCNbzxetpmOUxPzHdJw+aqMw14Rhmry9HQGjCmdEHyd9p3nR6GmWVsQkjq0HB1b+cMZXW6UeLSvhzkgXDRkAG+QDtDdhxS+i/iBt+NCFBqorB3zUitA7ydex8/iEOjU9d0JSsfOhEjzSr3IwQ5jJTKpghLKlKO1A=
Received: from CH3P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::29)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:55:49 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::64) by CH3P221CA0005.outlook.office365.com
 (2603:10b6:610:1e7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 18:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 18:55:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:55:48 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:55:47 -0500
Received: from xhdamitn40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 13:55:40 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <Padmarao.Begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Padmarao Begari
 <padmarao.begari@amd.com>
Subject: [PATCH 2/6] spi: cadence_qspi: Abstract PM node requests behind
 firmware helper
Date: Tue, 22 Sep 2026 00:24:11 +0530
Message-ID: <20260921185430.3491195-3-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921185430.3491195-1-akshay.belsare@amd.com>
References: <20260921185430.3491195-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|CY3PR12MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: 32497fab-9122-45fa-bd60-08df1811f38a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|6133799003|22082099003|18002099003|11063799006|5023799004|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: obaiIoFn8OVwVnSFhnRsILyJQjk9t8E9M5ILkWdcbRG6pAMvksELxTlXvEl1ttWC1Du8UBvx+s9vVyqe90NPh7CuAO+4hIiBjgwXFVV+sMNgzr/FctQj8GC66m6IkGT3fTvzNjeoApf54e9HW6HRJEXyCtF2asNY1lIQaUNZYzShTLnICBjFY3j2QAw5N8F5BET6pwjfAAqPOHGnpNUc1I9JEJMjPH70cLEdmCBq4JCqHp/o43MJ00OaTLcZZzmvI0v0rncujomgC80BI6SZNgq32+hQJed9kXy3gk6sMPMMR9IaA2i/BYuKEqozD9uH16UJO8fjK33vqkg7L3pu/rKzPKLrN5ENr5Rcd0NDfuBEdCKxCKW+qLQTSs96cM+qh1K9QtMvgifZ7EetI9Qgjga6DlOYOYznEtMMfVPlXTVu+82KPwEo/RS+xIIap+BHrJL3Lc+t23tMNUeA4orA44IqPX0FeEgSOJXxaWl2eQlSkYhFI5X8NqOeYaPP+Uqyfg0m8aPREaOEFYnOjoHYQ0NzBKQhtu7mPYM0Ff0UdA0g9XxGO1WyfIN4R+DqYRI/imZ5z3SCFUTD7SlvijfDgbB0m6xl1PXYRBlByhCmYYuMTGMzvWKFZsi01HcUCLpBbc7LwpoyiosQovzVOBGMssYm+TCij/Aj/8CPF6BV1XABDp17RmemXNLp0H5tF/N1EMIw8zUGESxqUZ+nQyXmKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(5023799004)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FH5iaFFfgupUJcxmXEk2s/HhWaXJUJ1ZzqK9EN8NX9b3EwojtaombDVIViqMWfa3/on2XcuWKeSVPDYMKXWQNMu8vlofgBfq9ganATS5aqQIaG2cUBzxFHg1a4s7vaoyiFlHr+ufssQd5tOSwV0Ov1JfiQ42hvA0F+3jEkE3TGliAe7QkT0kqJFab3BcqwLpNmNhBWi9LqU1Yw0pGIW1sZOGZkCGG/RDCHzETBIVbavzOZLQ8LqpLtVA9oAmopyCgtRh6c2bMcvwGWt7BQc5/ppF/aoRXmd3O6GYzflMPbO2whaioKGURNZeoWcz9gyJF2p8++uVBfD07vBGSy0kyigCc0EWV8uQEgeCEBU6l93Of7ugHok7Sl+DbHn0jYb8pVfU43kcny1sxopDOXcoce70h1Ff0QgzjLvug1EMElw1wubafJDVAjmwupUco4wk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:55:48.8497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32497fab-9122-45fa-bd60-08df1811f38a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
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

cadence_spi_probe() currently invokes
xilinx_pm_request(PM_REQUEST_NODE, ...) directly, guarded by
IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE).

Introduce zynqmp_pm_ospi_init() with a weak no-op default
implementation and a firmware-backed override in firmware-zynqmp.c that
performs the PM_REQUEST_NODE call. This removes the firmware-specific
conditional from the driver and keeps capability, QoS, and acknowledge
parameters encapsulated within the firmware layer. The probe() call
site checks and propagates the return value.

zynqmp_pm_ospi_init() only calls zynqmp_pm_request_node(), so it lives
next to it, outside the CONFIG_ZYNQMP_IPI-guarded block, for the same
reason.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 drivers/firmware/firmware-zynqmp.c |  6 ++++++
 drivers/spi/cadence_qspi.c         | 12 ++++++++----
 drivers/spi/cadence_qspi.h         |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 50a7f8c02e7..dad7fd086bf 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -852,6 +852,12 @@ int zynqmp_pm_request_node(const u32 node, const u32 capabilities, const u32 qos
 				 ack, 0, 0, NULL);
 }
 
+int zynqmp_pm_ospi_init(void)
+{
+	return zynqmp_pm_request_node(PM_DEV_OSPI, ZYNQMP_PM_CAPABILITY_ACCESS,
+				      ZYNQMP_PM_MAX_QOS, ZYNQMP_PM_REQUEST_ACK_NO);
+}
+
 static const struct udevice_id zynqmp_firmware_ids[] = {
 	{ .compatible = "xlnx,zynqmp-firmware", .data = (ulong)smc_call_legacy },
 	{ .compatible = "xlnx,versal-firmware", .data = (ulong)smc_call_legacy},
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 984d4a39ded..31dfbe88d21 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -39,6 +39,11 @@ __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 	return 0;
 }
 
+__weak int zynqmp_pm_ospi_init(void)
+{
+	return 0;
+}
+
 __weak int cadence_device_reset(struct udevice *dev)
 {
 	return 0;
@@ -234,10 +239,9 @@ static int cadence_spi_probe(struct udevice *bus)
 		debug("Cadence QSPI: DMA mode enabled\n");
 	}
 
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
-		xilinx_pm_request(PM_REQUEST_NODE, PM_DEV_OSPI,
-				  ZYNQMP_PM_CAPABILITY_ACCESS, ZYNQMP_PM_MAX_QOS,
-				  ZYNQMP_PM_REQUEST_ACK_NO, 0, 0, NULL);
+	ret = zynqmp_pm_ospi_init();
+	if (ret)
+		return ret;
 
 	if (priv->ref_clk_hz == 0) {
 		ret = clk_get_by_index(bus, 0, &clk);
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1e9081c2d17..f8716aa8c7d 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -317,6 +317,7 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
+int zynqmp_pm_ospi_init(void);
 int cadence_device_reset(struct udevice *dev);
 int cadence_qspi_setup_opcode_ext(struct cadence_spi_priv *priv,
 				  const struct spi_mem_op *op,
-- 
2.25.1

