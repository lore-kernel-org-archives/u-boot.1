Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895D4CC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 04:50:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42DAE81008;
	Thu, 15 Oct 2026 04:50:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pIQZmOggYPGG; Thu, 15 Oct 2026 04:49:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1C34B81005
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792039798;
	b=UfmB9bB6oa2qXUTX96zeDvH4WpMcyy2IUNUldnTx2M9ctZ/3gz1eopWW2fIXDEGW1tv4
	 m2efRYI0OL5hRUqUFg8NIr23RhplGq3VGXyE2K40igeDnPCdl/HZFWzBH/cBtpDpikdNO
	 tY4UVdfM1uNTzOPpijLfaHH4H8RZHvEcDx8iB9Y9M4VVU4i2NoxeDOafy4cCq/4Za3S4E
	 XkYAcVDL4FpPyTI5ijfTb94JG7EEM1eIk81zA+P4AyekJsuwM+d11oMHV9KwH/4Ir+6Tw
	 e3oQYOml6GLXUIVGl8yTyPdMhwhB4KCNFnYYQlc1UNO0xETYH6OiRBqaaSgHS/U3OXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792039798;
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
	bh=9gLpoUeU9GhZMo+5JNT8eFMpSjgn16NbujAWzL/Bjvk=;
	b=sLImFUmwIx9FywxNwhCCsq6EUImtuPWt7br40+Y9i//bWDy2/Z/59qoQDSlpadQiR17A
	 BoxWw5N/QG+hZBdUA5s5d45tatGxLk5Dm1wHLZgJj0rLyfKO8Y6LDnXCM1dFxELn4Gu5R
	 71pOY79FgGtyBvj9yo0oWdKtnz2CWA2Zt7XTmU2dqJBQYsL5MgpghmxxGNJoPMclhlCF9
	 pkuskuuft5yl6fknG2tL7umrvlMb7WvEXzPNWo4EK0BMGcR7sJITT5tdyVIRllSq/L1vt
	 GNPbky+8ld7brXdR3nfPm+bASYx2DgaP1uJQhpQb4Bmm1vczLNva2wWVDkI2nLVzM9w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792039798;
	bh=9gLpoUeU9GhZMo+5JNT8eFMpSjgn16NbujAWzL/Bjvk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s5pYTXCkpuH8Zj5H5WyCcylZQKYhfdmNcgV+R22lBVsRPPYYo3nnqbXY4cKSiA5rO
	 leGPEeZUg7/bNR7nMtqVNJewy3PmpharO1F5XatznV9pYZoNaNYsRsa2TV2leSlDgr
	 Sy5uHt8aES1bux86P80ujV8LKzHWvLnXmD9+0WBwpHx1enB/R3SP+cAPIDsP6qM1MK
	 dqP9Rm4cH2yhg0WH2ndZ6yiilSgrv4Ot2saO7LBx8vVhOxMIywhJVKTz/gSFkGJ2YC
	 AuvtefzQhITAzpymzbSEbmXhyND2SbxfOsSBaHN28HB4NzPULuGzJed5kYKLjnTzy7
	 SUbViVkoBBAag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C34B81005;
	Thu, 15 Oct 2026 04:49:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E31D6769
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D57F040223
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:49:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P789Qop-n9HW for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 04:49:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0642E40053
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792039796;
 b=iLZ2v3e8y80XgWrdz3GeS3UJx3N5s0x8Jtr60Yo2NCU9m3RcVQVYfhbbWYifAvc6XKMf
 H6ZqMa/MA/Zd4jApw4tmsJESqV1hXAC0f8zNZj6Yrl5Kuz5jlBAApds/9hbPFrY2+Nsb0
 qlmKGHDArrKtxPqU+AaNvSNXNEqKLGWc1iDhMuYg/BQiIEfZIhvIB5CmNIhXrezN7FTMV
 mHpq8bgydQ5DawFfYtSmBLCVtbQbFCBmOixKPz6EyWyEFk5/IhjAsWTmnwR7B0qCSZt+8
 +PJeXQcx4TgD+OugOJfGLOtrVhcvo0rCRJSrqGjbHYKKIhkq5tPZLvXulaoAHLLaUXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792039796;
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
 bh=9gLpoUeU9GhZMo+5JNT8eFMpSjgn16NbujAWzL/Bjvk=;
 b=qkyOaYoN2bqNMeZ3fhy1A0I08Mk3OxFnyvqpR+lZEHGqXqntUC2PeqkTPpEIT34w5n3u
 htdnmJG1dVFS+0pcOCyQp8f0vgoPoCPaDtxzUuqPAUwSSEz+84FCm3oPuzzKOAYZLPesM
 qjr5QpG5hm/D14XY5qQkh4CXP5wP91W1SnUfem8Jna1NI+abfqqATFRapOdbSD2cR/603
 o51891fhDlyRHi9voY1XZ7PPhZgpM7aG0L3rxqm4V3jAw95zVwWKAy+yrRq5y+WdD0j5B
 CJunK/lfyV+MTjTxEjyipdMzci8OakzJUfKyYkjH+t76ucDjG2jderUGp7xt1iEOfPg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=pV1SW3Zx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=pV1SW3Zx
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0642E40053
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbUQJF9zPTgKLihOUoR5XzqI873HPmEapwg3v3FCSKsDiomac2G6JojdUYi5VAB9jfFcyE2A04sd0Bd5amowM1hg5MW1Eh1XpGHydmg4rPl7w+PXBQjxIiEuGIqS5J4383phb3xpivWQlKd0GaSlUacbqfj0sLignd+2zTDLD3CXd6xj8BStSYeq+R18G6mkL9Xpt+FchHZukHiVz+Zgnhoz/wrGq8YAT0KUngqfU+h1ZOzI3m+vBOu7UcmiPgA8XI2r+OF9tEuc5m3TbXlcoLdnZVJE6wN1SwgB1q/t9/bTb0kPCteLC09TZhj6ze9cH/JKJDXYprrBOK9s+JoN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gLpoUeU9GhZMo+5JNT8eFMpSjgn16NbujAWzL/Bjvk=;
 b=ZVgmFQ3zPpqofhPZK9rvylpwMixEkFwQeq6VPlyDhtXWfYfz03V/f37sDIyUdX/jXd81YOEdTtMqXHExAgar6R2142cEzzqlHNhQay0c2a9lIbEZGzcLAJehWOBy6qrBLqFDRba0mxSkWwjMFbpP4N+YoqOUhCTWNdIB3shE/nnHK9NvnsHtU/0lYOLj016Jy6grdPNH0HUMjlu433M5ZSAUBrvghX0jqbLkqdxc04i4m4tTmXb84ZApgfuRfoFQL2VgNMEXnVmlSjORbvwBz4S1Z+Qegr0liYPVKAAU0D5P8DHpeDpeAe+yrCLOXfVJLKit6yS5SQ8PZlaeTqVO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gLpoUeU9GhZMo+5JNT8eFMpSjgn16NbujAWzL/Bjvk=;
 b=pV1SW3Zx4ZYrtgdJsC2JYvSgEeXKmMKnFrtZHaww+Lh26yINviXxXPPRuSdpDNuM4IlmmRy3uus3w7kSAF5rgjtoHgTAwRZmDN5FNpnEVV0gGGIsoBBVDS9TF7Kl2i1tRBc4sGUpMc9o6ZEOQ21jyll77m/5PsReHIBLQGvR3xc=
Received: from BN9PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:fb::11)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 04:49:50 +0000
Received: from BN3PEPF00022BC2.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::64) by BN9PR03CA0036.outlook.office365.com
 (2603:10b6:408:fb::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 04:49:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BC2.mail.protection.outlook.com (10.167.248.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 04:49:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 23:49:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 23:49:42 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 14 Oct 2026 23:49:40 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Subject: [PATCH v3 1/2] Makefile: drop GNU Make < 4.0 compatibility code
Date: Thu, 15 Oct 2026 10:19:07 +0530
Message-ID: <20261015044923.206217-2-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
References: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC2:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fdf4de-d198-4f22-e5a6-08df2a77bead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|5023799004|11063799006|22082099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 51DEZFfELMskUkySiHR785+zSprRdk3iuDS/Ej4galA61ZL0IMbp2SVqfdo/ibkWZDgefOGfe7lbKzdYDV+m2o0PWvPHaRGLDXEB3nJci3aNHKLj2vAYGdVrMum89CFIjgRp99VnZqRwC70MJ/hIsDFY4v7sLywVXQyJfuO/beHhaEwwXqg0HTsiyv6tOJgaNAfg7CI3k7xa/wiqbIpo6zwGyhRbWhjyB8tI0gLbW4OvztJE1fORWjMfOqPlxQ4jrm8eC/trRjLOYwWFGkcdG7l2G/7F0KiA5Wd8PRs6hbDKMXTCryXeQWm76UOq6i7Nr+b/OBOMMQ5EO6i25sQ0DyyHhb1Kmj1Tms5ibJ4WNqe3xURAuSNA0HH5EU1GbLEURsUBo+HlLVOROBIkSpvwuSqLwJIkSZDGR8jji6di+n3FV/ARTdPAiDX2YRE5dRe2T1OtIaM2ITr7xeyDYBVMtijyNG9MicsBddoAF2d19pGNoRZF6az4xKajupggFLrNS2U/6n7bbf2154dSvipQKh4cjMrCs356lfccsTvf3Okjc/ut7ppQgAt3oFABEcqknA8UZmT0exj2exZuKz6XWKxl4FC4LE7k3KvE7LYT53T60Z76c5qBWkruoNkcxYx6wnI93jDy9buX0MGA5ndsItY1G8s2oMR0wtyscwY9s1gwuueP00muspwnNYf5mLrWA7SQmZJ84aLPgDJx4TLrwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(5023799004)(11063799006)(22082099003)(10067099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XazZOmWPimgAYILwOlsfB49fip5sNBaTSrXjD6ouMVsQAkB07jyj4zvOlalGL/JFPKn3hu1fY55hs97pa39akP/uJ/khReoje2kGx1GNiEHxGtLTcz7NehEEdCjcjFml+RHYwvhAEbBbxOBkWGX3qqV6iOBHy4kTZqfm8ebJ2vo8h8Cb5kfPnrmzEY0ATEqbQEtTkmlkUsYI4mzPsCAq/W2zTg7+3ooJSOHiDn3928CFOIEXCm3GTMCVnwbdyUWofwA8xnYXs82rkTkzmWdydGdZrWVuQx6sXkn4sVrnGgxL6ngyxTuG++RFxj239ba/nEcpOCblU7WlDJDBTWH9MfMH8/avXoDiFfS0ye5q1v54ZMIeeiLZ36P2l1DljHL0xwh74eNhC2bTXEr73Jq3nHTdC+hSY2YDO2IK2XcxF/Gw5K2M9N3iwaVsTyAdF9Fi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 04:49:49.8015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fdf4de-d198-4f22-e5a6-08df2a77bead
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121
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

RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82,
reached EOM/EOL on June 30, 2024. While you may get extended support,
it is a good time to raise the minimum GNU Make version.

The new requirement, GNU Make 4.0, was released in October, 2013.

This follows Linux commit 5f99665ee8f4 ("kbuild: raise the minimum
GNU Make requirement to 4.0"). Raise the enforced minimum to 4.0 and
drop the now-unreachable compatibility code for older versions:

- Add an explicit "GNU Make >= 4.0 is required" version-check gate.
- Simplify the "make -s" (silent mode) detection to a single
  unconditional check instead of branching on make-4 vs make-3.8x.
  This also changes behaviour on Make 4.x: the old check matched only
  when 's' was the last single-letter flag in MAKEFLAGS, whereas the
  new check matches 's' among them, as in Linux.
- Drop the GNU Make 3.x sub-make workaround, which is now dead code.
- Document the minimum GNU Make version in doc/build/gcc.rst.

Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 Makefile          | 20 +++++---------------
 doc/build/gcc.rst |  3 +++
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 6303a0cca6a..5abd0a7ce04 100644
--- a/Makefile
+++ b/Makefile
@@ -12,6 +12,10 @@ NAME =
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
+ifeq ($(filter output-sync,$(.FEATURES)),)
+$(error GNU Make >= 4.0 is required. Your Make version is $(MAKE_VERSION))
+endif
+
 $(if $(filter __%, $(MAKECMDGOALS)), \
 	$(error targets prefixed with '__' are only for internal use))
 
@@ -93,15 +97,9 @@ endif
 
 # If the user is running make -s (silent mode), suppress echoing of
 # commands
-ifneq ($(filter 4.%,$(MAKE_VERSION)),)	# make-4
-ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
-  quiet=silent_
-endif
-else					# make-3.8x
-ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),)
   quiet=silent_
 endif
-endif
 
 export quiet Q KBUILD_VERBOSE
 
@@ -166,14 +164,6 @@ ifneq ($(abs_srctree),$(abs_objtree))
 MAKEFLAGS += --include-dir=$(abs_srctree)
 endif
 
-ifneq ($(filter 3.%,$(MAKE_VERSION)),)
-# 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
-# We need to invoke sub-make to avoid implicit rules in the top Makefile.
-need-sub-make := 1
-# Cancel implicit rules for this Makefile.
-$(this-makefile): ;
-endif
-
 export abs_srctree abs_objtree
 export sub_make_done := 1
 
diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
index 1fef718ceec..16afe292899 100644
--- a/doc/build/gcc.rst
+++ b/doc/build/gcc.rst
@@ -7,6 +7,9 @@ Dependencies
 For building U-Boot you need a GCC compiler for your host platform. If you
 are not building on the target platform you further need  a GCC cross compiler.
 
+GNU Make 4.0 or later is required to build U-Boot. Older versions are rejected
+with an error at the start of the build.
+
 Debian based
 ~~~~~~~~~~~~
 
-- 
2.43.7

