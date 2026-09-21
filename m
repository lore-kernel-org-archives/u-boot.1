Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA28C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 18:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D639160778;
	Mon, 21 Sep 2026 18:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8hUvw5El8d2W; Mon, 21 Sep 2026 18:56:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E761A6074A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790016971;
	b=PgwUU85G3hGy3LTmaL+DCNx/eUHQ+9iI4bLrIHaQc2Ig91r8EF7KlH1XR02Df9fEhzdk
	 yhtrvCC+wyNl0yCjV6i1LNe/0Gq+IrNbvkEjBI0bt3RECAqqm09Ihj18cdOtqRarBkeNE
	 x+G2kiefT0Kg8cEeB7yCbZwSxUacp196ZmUtIGl+aqqU3eI7NBoV373VtDHTv1xg9FTTX
	 XuR7bB+nJPs9O3XCbK3AKxwoUVCjKCs7pt+81fbjcMX+o+OEHiZAU9QPhVLOb2La/OH1b
	 5o/tJSFkAwUE+VibF1Oh5Q51NlZURN4SvMQB+jKNb3THEDdIRYWbNM1UGPXe8ZGH/EA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790016971;
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
	bh=UlW1fmZNFj3Ki+qqJhzgY7rfLfJFuzclxrx3IIjmbfc=;
	b=VKjoM6zhIlVRSSiiII0N97ULWNHjTcPESLOYU6l385RV+g68Sos9STeFl80iGj09Hcho
	 BuGud4ihAWN487WpqKXgEYDBa95uNYgfbAiCb+q27XqAtLEzntjqLsZAWJns7nQyZtXq4
	 IHYreDCHhZARraC7m3QxAk4G3/JFY8+HbFV5H/nyeGM0J9V+ZSUHxHkbBPEwE2MYHmJm6
	 41mpk6GUwCXQ83XKDUWrWib+MWSjb3oKXAiYtOhYYXBVQrPJYFKTBUZKvzawjDrQduoVH
	 FS7XTyBgfSmxmv1IXw9W7eZJ+eJeCYw2piP01TzxDiphVOwoThrfL0j4XECaLQBIcZQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790016971;
	bh=UlW1fmZNFj3Ki+qqJhzgY7rfLfJFuzclxrx3IIjmbfc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DbTDst1d3niOuOxuCTruF31wEo0lDUEU0Mv+BPjPPSlRIY/1jeUja1xuiM6x4hmj0
	 P0DonPJXdoEuVldM8nLz6p2bMaV7ig+2hfPYCEOg3PCVHU00MyPH3BCfiifLxqoQKd
	 o8VOFGgbNXeKcz1TX9nXzLywSfQzquA2HvJhRfFqfgNSX33PQjXBlB8eKUD64g27CA
	 ZOveFSIgsCXYYu3LEg023AY5RhzRUsehHf0MVtMXDnB36JEIT0WvQ1+NvKPIVslzHz
	 wAWHkEdAydaXY3thb+v6p9OaGRkUb1SUbc1kIwNDKRHSDt7AW6sKI06SjRpHiDqzJM
	 7Qk4m9HFXnUdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E761A6074A;
	Mon, 21 Sep 2026 18:56:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B9E43A9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 090F780DB8
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hwaNDT4wwW9j for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 18:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8327780D2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c000::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790016969;
 b=Gg32LDwsWTYudZr4o6mXjYXLqy0iDURZbtGM9NkKVVfnJ4I6okJlRTDmcILep3V6W6nF
 Cxs3h5mquj1er8aPkh28C2bzQjOB5v2PfL9xDIz4NlHvI6BREz0sRl07YtA7/TcLOS/PW
 RbEMKVOK3UINRT4xNCsLxBpJC7EELUfTGuM3IO4DP6xtxJY7Nq8lmZxAJID3OYjhmmzZ0
 zGFRYVdgxRL9mHK2VR4054+orh+39Q/IDorJpqB8BA0h/8zM1d8I6Vnn6WEYaFDY44vxO
 DDhM67u5z3ls06lucnYIgML8h73pZdU/4rbomuPInjkjtLUVOo3LhrUATqTb3ChwQIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790016969;
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
 bh=UlW1fmZNFj3Ki+qqJhzgY7rfLfJFuzclxrx3IIjmbfc=;
 b=mQ2lMl2nxMD4VKhOqPsBIRsGAjBi9Nef/mUsP7I3o1lyWV8PXK/j/eTLScfcJ0cdxBxX
 EE2u6wViE8qL+Jp9OUo8YFUgpv6XFCC/d1gxP12NE7DEwz2yL8H718R+stwEguZZWULtV
 DSs0aJHReApR3QzJjuCxMaHnBq4mfwsT8staGWBOtPGHukfBRxbhY/+0/effBK45wNdko
 YpRMpfXyqlOAbySMQ+7ETVSHJTHtvZJECXebenJPsLQBafwFruUZe9XwA0L5pE6SrsYXJ
 CNbV/zPnI3GJgoT9Z4PuTWo/5vziZaflLSUBHoIPVbeO4WCZErBnVZyOUXsPmvhSApw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=BnEbu16n; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c000::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=BnEbu16n
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8327780D2C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsbX4MTehCtiRIZTLqjz12XAGq4M6wkK2Npa7glEh8PKSNwpSnstqhP1E/CD3a33Idgo5PdgEqAciAy31onCJ/aXuUkDmhGnP7TFEzvBvKhmtL1hQOVeHaWGoSg9yYCylQBPWw/d5BDlLOHzhG8Vh6kF5GEraoNhKVtye8byu/NSlGewYK8WAzPPkY5Ss16X8lx2MX8K0kIRGiN6ix0zp7NUPWonDkG/qmivq26An7NpEnT6mj8iJ2/vnMq2ITyztNNeBi5UnNsDpgTlg+AozieWJeJlihkTjVUhzXWB0NpyT1+VhFfeB6KKXo8hYec2JDxfr21wVW42Y4Vt+vfq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlW1fmZNFj3Ki+qqJhzgY7rfLfJFuzclxrx3IIjmbfc=;
 b=uL8bCfU28qMIVGoihrsGmmuuqmTvt6UBmgCWvqXyx9mMff+cAgKnnM5yForVgMceM7SYCgM5FHZHqK3Z0pzLazQVI1AfwQPYcT9ar3W8TbQMHsjDCrCbIrCecncB39OQYTUH3U9wMXAE7YqeKezGWIevaVjlsoBTXGiXhoSsjgOYCzt6OowU1OgN8T5x8usjzRTAq9msVRhjoVqdQHlei2pCsenWDnXtHsJ4tfSpQIHmj9krXb+Dla/gOb7LU+aSh7CQpkMNjdD0TqW57IHm7GYWuli0aCDa6nD5HqKMqt71pWJZ667x/sQ88wnI3YDSzsX+SQ/hqTegM/tZHBIysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlW1fmZNFj3Ki+qqJhzgY7rfLfJFuzclxrx3IIjmbfc=;
 b=BnEbu16nD22uI9i4irgmdo1Mq9WVTNqAMAPcxDysDBR/rSBVW12PmVWC+8OJiu4ktPGecjvcdOlhwXDuaWBAM0108FECZOKoE7Pv4SbIk80WIq9GAviYrQnt0bySZWe4ETrY8CuuJU1hGMCEEowV/9oJCxqXBnXtQsPfvIAvwMM=
Received: from SJ0PR13CA0085.namprd13.prod.outlook.com (2603:10b6:a03:2c4::30)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:56:00 +0000
Received: from SJ1PEPF000037A4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::a0) by SJ0PR13CA0085.outlook.office365.com
 (2603:10b6:a03:2c4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.11 via Frontend Transport; Mon,
 21 Sep 2026 18:56:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A4.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 18:56:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:55:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:55:58 -0500
Received: from xhdamitn40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 13:55:51 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <Padmarao.Begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Padmarao Begari <padmarao.begari@amd.com>
Subject: [PATCH 3/6] spi: cadence_ospi_versal: decouple OSPI mux selection
 from firmware calls
Date: Tue, 22 Sep 2026 00:24:12 +0530
Message-ID: <20260921185430.3491195-4-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921185430.3491195-1-akshay.belsare@amd.com>
References: <20260921185430.3491195-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A4:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 7764b70d-b880-4446-616b-08df1811fa39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|11063799006|56012099006|3023799007|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KhJ0Ux3XI0xnlDFkh+hWW2MiRrqLdlAYeRGx7yg5IJYjZffcihwHLSJ0q66xIp5oxQpHUBh1rr5a9GgUN+Ztfm4nRgINW9F/Pbx4NOq5sPlBuY7WuEcYBMyGmzm8J0A8jGMYCEPoGaZL5WWvyfeHn5+s5/0pQjJISOkJViBK14bHS+sZS/w3K8UXA7QHs3W1uJ/iq1oJMQEVMD+PamLH9aRfTkuLnLGT5aOTXW4WSPRsCW9o4tkQ48DnVGlWkYb2j/rSp4KczpyLgUiXKL+At87KCFAZLdVFokUHbrQNztHNPUfF+WgsJAhQnq3wJjYoOu/TH5WS7aRsDP0pr5toc+DBYAd0bRUzIhcM3ju4pPm+QvHG8TvlETQKhzgpi+MrYhqzj5Tpbpc0snnuMMgMyDyMMsNVxiI/e1n9v9QYcrUJFpEWRRYQhs1h2mgWsj2eTzOiIRkr4BPbqI/mo6G8EqRWtAKlD0chezypQ3bDmF1Q4UjEEh8Z2ju0OIXXJs+uCL/laEef4AIs0TBO+JCsmV0g4KHLKES11F4wEgK+vZCpLKktIAF7D+V0zyPltvnZqxaFLtLICODeRWtWHYDANFxbbIqHNwQw1fO8IoiQi7/IDRtj7t+9gpe6Q0e+Z79sMTd7VulV31gQAR0kIqM2FRXn9j60/rlZr4QQirUeWU29dZ3+WexJDFlZlaYBvmZ8zEBILGXnJpbxADf5iFdZxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(11063799006)(56012099006)(3023799007)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j2oHJapOY7OTX5u81kSh/TcIwvcIwvh8Ij5ZFg+dbLoOAYkppmo8y/rPn6vUi5Wy3jjZvkROdxTkiA7RGtMFLpcb8SwEfiPaj+XUmn03BVBJ408jraqfdPn7rpRI+kZzYMYnA720RZjzVAx+KjRBpmJ2zUbNAwV+V6HHcTq+yM1087bg5jVeeuDgLMf8mHPaCF4OEqJH9Wt/66yB7H5GXfelSSZcbpEAPyIVYBhD7P7SeAniv8kIzfIoEDjcB+1se85i/lp0QNsZL9fZCgprRCXfxfrhMgDPJ1MSbF64B+26p0/XQSuTOOOnUk28x/ikSgTn7Q3F7fuTkp37Z/Rj2VVrhUBwGEWl9l06tUgiwJp+/slVXZfka+pB7KebWQxeSTcurNzthoY+xvqn83Iu9evLhR/qiJlPLhqGEuVus9Vv8o0YpsN/k/iA3evtVJ/3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:56:00.0199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7764b70d-b880-4446-616b-08df1811fa39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
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

cadence_qspi_apb_enable_linear_mode() currently selects between a
firmware request and direct register access based on
IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE).

Introduce zynqmp_pm_ospi_enable_linear_mode(bool enable) with weak
default implementations for Versal, Versal Net, and Versal Gen 2, and
a firmware-backed override in firmware-zynqmp.c, guarded to those
platforms since ZynqMP has no OSPI AXI mux to select. This removes the
firmware-specific conditional from the driver while preserving existing
behavior.

Use a boolean argument instead of PM_OSPI_MUX_SEL_* values so the weak
default implementations remain independent of zynqmp_firmware.h and
firmware-specific definitions.

zynqmp_pm_ospi_enable_linear_mode() only calls xilinx_pm_request(), so
it lives outside the CONFIG_ZYNQMP_IPI-guarded block, same as the
other wrapper functions above it.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 arch/arm/mach-versal-net/cpu.c                | 12 +++++++++
 .../mach-versal-net/include/mach/sys_proto.h  |  2 ++
 arch/arm/mach-versal/cpu.c                    | 12 +++++++++
 arch/arm/mach-versal/include/mach/sys_proto.h |  2 ++
 arch/arm/mach-versal2/cpu.c                   | 12 +++++++++
 .../arm/mach-versal2/include/mach/sys_proto.h |  2 ++
 drivers/firmware/firmware-zynqmp.c            | 11 ++++++++
 drivers/spi/cadence_ospi_versal.c             | 27 +++++--------------
 8 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index 1555751da2e..f5c8e684dda 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -238,6 +238,18 @@ bool soc_detection(void)
 	return true;
 }
 
+__weak int zynqmp_pm_ospi_enable_linear_mode(bool enable)
+{
+	if (enable)
+		writel(readl(VERSAL_AXI_MUX_SEL) |
+		       VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
+	else
+		writel(readl(VERSAL_AXI_MUX_SEL) &
+		       ~VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
+
+	return 0;
+}
+
 U_BOOT_DRVINFO(soc_xilinx_versal_net) = {
 	.name = "soc_xilinx_versal_net",
 };
diff --git a/arch/arm/mach-versal-net/include/mach/sys_proto.h b/arch/arm/mach-versal-net/include/mach/sys_proto.h
index 4907dae1108..2682b0faeea 100644
--- a/arch/arm/mach-versal-net/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal-net/include/mach/sys_proto.h
@@ -13,3 +13,5 @@ void versal_net_timer_setup(void);
 u8 versal_net_get_bootmode(void);
 /* Direct MMIO read of the bootmode register (EL3 / no-firmware path) */
 u32 versal_net_bootmode_reg(void);
+/* Overridable OSPI AXI-mux select: weak MMIO default, firmware override */
+int zynqmp_pm_ospi_enable_linear_mode(bool enable);
diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 7521d45bc1a..3ec51bf560e 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -178,6 +178,18 @@ u8 __weak versal_get_bootmode(void)
 	return reg & BOOT_MODES_MASK;
 }
 
+__weak int zynqmp_pm_ospi_enable_linear_mode(bool enable)
+{
+	if (enable)
+		writel(readl(VERSAL_AXI_MUX_SEL) |
+		       VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
+	else
+		writel(readl(VERSAL_AXI_MUX_SEL) &
+		       ~VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
+
+	return 0;
+}
+
 U_BOOT_DRVINFO(soc_xilinx_versal) = {
 	.name = "soc_xilinx_versal",
 };
diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
index cb373e6fad9..da357abaaee 100644
--- a/arch/arm/mach-versal/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal/include/mach/sys_proto.h
@@ -27,5 +27,7 @@ u8 versal_get_bootmode(void);
 u32 versal_bootmode_reg(void);
 /* EL3 clock/timer register setup, called from board_early_init_r() */
 void versal_timer_setup(void);
+/* Overridable OSPI AXI-mux select: weak MMIO default, firmware override */
+int zynqmp_pm_ospi_enable_linear_mode(bool enable);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 19baa1331bd..c2173161fd7 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -311,6 +311,18 @@ bool soc_detection(void)
 	return true;
 }
 
+__weak int zynqmp_pm_ospi_enable_linear_mode(bool enable)
+{
+	if (enable)
+		writel(readl(VERSAL_AXI_MUX_SEL) |
+		       VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
+	else
+		writel(readl(VERSAL_AXI_MUX_SEL) &
+		       ~VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
+
+	return 0;
+}
+
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
 };
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index d678adf9c26..30db724bc2c 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -21,6 +21,8 @@ u32 versal2_multi_boot_reg(void);
 u8 versal2_get_bootmode(void);
 /* EL3 clock/timer register setup, called from board_early_init_r() */
 void versal2_timer_setup(void);
+/* Overridable OSPI AXI-mux select: weak MMIO default, firmware override */
+int zynqmp_pm_ospi_enable_linear_mode(bool enable);
 
 int zynqmp_pm_wait_mphy_tx_rx_config_ready(u32 timeout_us);
 int zynqmp_pm_wait_sram_init_done(u32 timeout_us);
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index dad7fd086bf..d09e92de1b0 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -858,6 +858,17 @@ int zynqmp_pm_ospi_init(void)
 				      ZYNQMP_PM_MAX_QOS, ZYNQMP_PM_REQUEST_ACK_NO);
 }
 
+#if defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL_NET) || \
+	defined(CONFIG_ARCH_VERSAL2)
+int zynqmp_pm_ospi_enable_linear_mode(bool enable)
+{
+	u32 select = enable ? PM_OSPI_MUX_SEL_LINEAR : PM_OSPI_MUX_SEL_DMA;
+
+	return xilinx_pm_request(PM_IOCTL, PM_DEV_OSPI, IOCTL_OSPI_MUX_SELECT,
+				 select, 0, 0, 0, NULL);
+}
+#endif
+
 static const struct udevice_id zynqmp_firmware_ids[] = {
 	{ .compatible = "xlnx,zynqmp-firmware", .data = (ulong)smc_call_legacy },
 	{ .compatible = "xlnx,versal-firmware", .data = (ulong)smc_call_legacy},
diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index e6f4ba49e77..602a7f4884c 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -12,8 +12,8 @@
 #include <asm/gpio.h>
 #include <asm/cache.h>
 #include <cpu_func.h>
-#include <zynqmp_firmware.h>
 #include <asm/arch/hardware.h>
+#include <asm/arch/sys_proto.h>
 #include "cadence_qspi.h"
 
 int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
@@ -200,25 +200,12 @@ int cadence_qspi_flash_reset(struct udevice *dev)
 
 void cadence_qspi_apb_enable_linear_mode(bool enable)
 {
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
-		if (enable)
-			/* ahb read mode */
-			xilinx_pm_request(PM_IOCTL, PM_DEV_OSPI,
-					  IOCTL_OSPI_MUX_SELECT,
-					  PM_OSPI_MUX_SEL_LINEAR, 0, 0, 0, NULL);
-		else
-			/* DMA mode */
-			xilinx_pm_request(PM_IOCTL, PM_DEV_OSPI,
-					  IOCTL_OSPI_MUX_SELECT,
-					  PM_OSPI_MUX_SEL_DMA, 0, 0, 0, NULL);
-	} else {
-		if (enable)
-			writel(readl(VERSAL_AXI_MUX_SEL) |
-			       VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
-		else
-			writel(readl(VERSAL_AXI_MUX_SEL) &
-			       ~VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
-	}
+	int ret;
+
+	/* ahb read mode vs. DMA mode */
+	ret = zynqmp_pm_ospi_enable_linear_mode(enable);
+	if (ret)
+		printf("%s: failed to select OSPI mux mode: %d\n", __func__, ret);
 }
 
 int cadence_device_reset(struct udevice *bus)
-- 
2.25.1

