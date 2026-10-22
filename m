Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA7606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z9c+QPco;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aYnvko3D
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 93ACB40621;
	Thu, 22 Oct 2026 13:58:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xFOzMoSyzH5H; Thu, 22 Oct 2026 13:58:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA485405A6
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792677526;
	b=LO5nr9I9yO20u0wn7fiAPhiBhoTTpZ9eyAVHXkXCCHjlcHK2FjNu1KW6Gz8R2CKOkw0w
	 fGJNU9sMYVkfaYI9onGxPYeF4FGpToXdJulZZxsl0nllVaLr0bIeLhqDJPFjKmLWKdBgC
	 DSZaQSwAWGFLYcWQKlrSYXrBYPC4a39rkQ1xiimc3jj4CfVRFKvzrd8ZEJX0gxLfHm3O1
	 wAQ0lsRQrTglN/BLFVzkmodDda2zTHZQu1KzKemaIE9Ty+PM2DsKg+GB41Y1CjxdDMHYI
	 5jNFH8rxGEMgHEX4jAL/bkA/LSgPl/mgjlm1gz3Ve0dnWQjqXyluySffyiXKb0kik+g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792677526;
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
	bh=NauOznyEXdy5DTBfvOpvwnzwQuxDkJw3XrTWhfrTKPI=;
	b=cRZko39RUlqM1jV3jn1DV3dSOPwFrKHUScoHgQMrl+OHVreS6K2V5HVkZZF2JCWDrTaF
	 5bCVf33c2KcNbN+i+OLq2tYy057V7V++7PyOtiUxBa0+jTU0+a7CLbrstmihsUjXDgZ8S
	 Gv2q2kSm3BJ+dRYevJpc5w16bb49QwBVpMcB3n0vIB6V3yuy+6YE79fMC2I062KUqn9Up
	 c/7nzJuK33PWLdh7qjj3nSSF9HoXVab6qQHxc3ODmAahL/QTEmfN7c3CkMeNxiYapkQam
	 TmC1XmHFlv5xtXXchE3tJlaUmpoF6FDCULFrIr75r6f/pRrcOJ0Z7KFNig+rPUnd6eQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792677525;
	bh=NauOznyEXdy5DTBfvOpvwnzwQuxDkJw3XrTWhfrTKPI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z9c+QPcop0eAKuetKr/tSVKfYL1LLGDZEXLEG7BI4QBI6cgFSMDHZUzSwz9H9M/rg
	 J+oe31idvDPsrEVvSO/Jqk8A3tHZEWJEof6mJ8nEOi1qEjTk+Di8wRVNJh/GGBjF1+
	 K1ueAeuUUvf3EafiGmIxsPQDdToiseVD3jK/C+1KSimstER400iFOhsEpNs52Stjek
	 RaHRtC0AMnC0clqFkjCZ0dOTT27coTch0LoDf/RUkwlmD1N7Jlpc0DpLU6t6N+zRL3
	 KEqtSvbzrBnqOrhM41zeaeRBhRxkeajSGVfuFQHyy0WXcGk6uhZ6R6UW654Xj0wwtA
	 t19lsA4LL4uxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA485405A6;
	Thu, 22 Oct 2026 13:58:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7486A2A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67399400E9
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDmnDJv9z3JE for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9C08040086
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792677523;
 b=OG2NM5BvPTLZ1mcXKH4xEO/m4hJumxQDnn0S0mhB/ava8s4t5pZK9e29KXpgJUebckLp
 pZenakJCj+cYNnpH3aP7jQeCt7qmszA6OzR16BCfgvE8+pEXsF4lsePwAd1DcVQxabmel
 N/2EV5FdebZ+0yXAm6kHkOpLXBSsIlRITsyz+gIR4KNNgmp80oYBK+RiISbgol99Ttojk
 nNtFuZKid8LunkIq+F6laz95rDEThuayaz6ZyplcMuxz8/8mIHYrua0CLaGE49+58mSrD
 J8yuhNx8+GU4GyHy61EFMaNti7RQxWzfsMIzEgoLl5WCem8oZmAMMarH/QFLWXlsyIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792677523;
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
 bh=NauOznyEXdy5DTBfvOpvwnzwQuxDkJw3XrTWhfrTKPI=;
 b=RhNkQhqtGlsYuLfu4TVCREBW6sGg4S92NZqziSBnC7vKSNLGCdDe0034kajC2wE2f3KT
 tM9wpRpMpeuiCAEYrlWMyFm6d7E/UcinCx/deDaMRQixFJhXQtuaZ5pQAffusvwxzUHzs
 EdFwjJNeaGv9MYTp2aURhiQlsRvoKp7SV++Acyd/q4v1zzqMnesP1BqY3+afofD6bUw30
 Y9hOARP4zAqUPGdfNh2wh9NPVZDmQrfGskFQfDTAslIWLa0ldhn8ui6nKnQRzT93DF435
 9QN73YRs/SGTOnLWHQZS9VCi1FNz3m0ZcnYuBUbPZpT2CNTzA/nZB1kMjYNnmxzb90g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=aYnvko3D; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=aYnvko3D
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C08040086
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOH2ofRzYtk2da6YbP25uF0QsQOnfpoVV59GqPN29Yk+QSXCdz4NrTQGrcDSgTZqD2tPzqRIu/aAcdvX5xovJO+K9XcdwubZ8kn5IN8kEMTTEulVKIj29dpG07PrTFLKOuAtLgmFhOiTPxMjAuD/SziH09nhwUlEmOqQw3MnCRwx7ALHFKV/wfC/sGbK0FkkI84EUQPmqGms5ARccGn8S+qZuKOPsHGkU3KlY4991UL4xoSF/ZbOdC7rRRJOIU3FJ5LWUosyocEon4Pfm0BtXL/Sc3JHG29vwy/AuXqfuTMKiQ9qoJdkVZUUJuCLMWVx956oGvvPjK0LzZ8AnfQFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NauOznyEXdy5DTBfvOpvwnzwQuxDkJw3XrTWhfrTKPI=;
 b=O+jKrV5vGlDM4Y9wP/t9ymEGBZHAp6gHJFNB5tkr4PZojNP9pniHKmtUCU9RNHVKd5f6UXdcreldblU5VKmQLyABBdkDcifTFEhOgFDiklj9Fs6nS9O7Z7Q21bp05GXrorXtoYM5pv2mz0US592PGqNOn7Tgqm0g1CsgRq+B5XYsFhFrQ9jlGmCvUHyx01ErqCbSW3MidNn3pJZqoyMgIxD9fg1dze7Kpo6iOs55f+CiU7E7gStG9VdWMFhMNpYR4dpH7J3+Q5L1cSnxVjf/AaWHwbJ9QDUsOEVdhkyVF0jhnScG8roGQclPV3xDq7wreulrUuaMuVRVYox9w/qIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NauOznyEXdy5DTBfvOpvwnzwQuxDkJw3XrTWhfrTKPI=;
 b=aYnvko3DKWecdDlbWA5f+yI9cwVX8n5C7xasdTIAllPampZEYNR/SuZAKQHn6AydZIDPaxsEQRpUC7gvq+WXkylrCqOj6NblbX0vDK028gvhtrks4vdj45ScemnQ2HmzemMcL5boywIJ36wlkBDg4XU/etpdJLZ4JvVFnSsKo6k=
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 13:58:36 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a7) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 13:58:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 13:58:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 08:58:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 08:58:34 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Thu, 22 Oct 2026 08:58:32 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] arm64: xilinx: Enable MTD virtual concat
Date: Thu, 22 Oct 2026 19:27:07 +0530
Message-ID: <20261022135740.3869144-5-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022135740.3869144-1-padmarao.begari@amd.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: a77b64e0-44bb-4db8-bea0-08df3044912c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|18002099003|10067099003|261021121427099003|22082099003|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: xYrHZqNkPF1vg1HxvolG14nm4OWSk9zd2f6zmHIjoWvoDtv/wosOr3tViu4p4U47Y0PRSrpeHq2alvx5tIj5h3p2vuNfoPO/IEz8D6CsQxmyTtUn4gOuvz4JMBcHG21a5fThBapnNlzHa4UUrUtKgVb9g9w6/r5lrDTVaUcQ52G1tF0z2kqEMfSudXbQ3iHoRt2nr6pA88Gyg+7VYreu0vJFmyfiBHAQ9AiPPdaJse6aXYE4L9MlGHtOmQaN6IkPvoz+jHvUrYWy56epjCTugJfKtCiCDF0+NQUAIh/rRGp2A98p0TpfLtK1bMfm8w81t2TTjPVYd/qDuBiPqAt5Dws/E3xjhu2BtfFHsYU69uieMw4eH9hA5xRf3vtlT8L+YpCZAYSSXlVaKLRgyeOegneI4ejOUUTGEQFkHq+h3oltyuFf/N4ylNrS6tICSnFKTMzcOHXh/FJ8L+LEWXrIQsgip3K+73qJ7DuqJpMQrUdzJg2unDYXqAdr+Fxt0mkpNN8tOMeicePy76PdX3fBlMPWfJ6aFBahSyoDE75op+5Xb2eeb6ybn5D78HO68XKrEKO9Q9VNd+pGQRnHhohjeOcGDDfh+7Pe0b8PPYIiHzAZ59twuj6b7D324Qyb74QzyaaUQQm85n+ptuFwAb15VoD0vI4iGJvGJ0C+Qf+op/ol3ZOeGg6EjSDiutjHMOEySxTHQZ4t5wm/BLjoqKej2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(10067099003)(261021121427099003)(22082099003)(11063799006)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zM9C1wGnsfOmk+uJh2izQyImA4X3f1ku01iJ8JiPrsuvAa1yelJYugQERPgPif5/F8PP70jI+qSPrp6fvTTdFP5nfS/N17G9sK7yGCA8lD5KHEKNMDr3UZ6lc5GMOphwL450xhFpFddp54WrM9vcriQqDo+BXeptb76Xircc9XPLfSrUjSgyjluMBk2Y18nVZC0hRq1qDP1Vg0XYN1+BcOVEbtvpm/2AwbiWMiQ8YQRNwvH2Qb3reyGPBjsK1YnDbtqGUfyQtjmVHWdzVS90tL+Rfp/GhIHRkeKBYXg6McCJBIYAhHyX+qxQSa7gLRbbOX491TcvhQa2ZYMKS6G9tBvd9Q1Ha/T/BFSYZHOe6V4LH7dr33sx7VlBCbP3P3uHzxs4oWDqNWvvFjUYqbc4LjSbGRBhhSu6yI/PW6sh0y8x7Ow33tBOeAvZGeCh3+d9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:58:36.0234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77b64e0-44bb-4db8-bea0-08df3044912c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable CONFIG_MTD_CONCAT and CONFIG_MTD_VIRT_CONCAT in the ZynqMP,
Versal, Versal NET and Versal Gen 2 virt defconfigs, so that partitions
on separate QSPI/OSPI flash devices can be joined into a single MTD
device, for example to let one filesystem span two flashes.

This has no effect on boards whose device tree does not use the
"part-concat-next" property.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/amd_versal2_virt_defconfig       | 2 ++
 configs/xilinx_versal_net_virt_defconfig | 2 ++
 configs/xilinx_versal_virt_defconfig     | 2 ++
 configs/xilinx_zynqmp_virt_defconfig     | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index ea02b0c011b..e4bb0994ab5 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -120,6 +120,8 @@ CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_VIRT_CONCAT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index c9e62a85543..eb19a2b73a1 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -98,6 +98,8 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_VIRT_CONCAT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_ISSI=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index 647e0455f85..ced9297f971 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -111,6 +111,8 @@ CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_VIRT_CONCAT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index 4684edfad03..20de842fb7a 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -158,6 +158,8 @@ CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ZYNQ=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_VIRT_CONCAT=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_ARASAN=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-- 
2.34.1

