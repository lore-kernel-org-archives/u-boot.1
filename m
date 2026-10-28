Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29C4606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ECv0Nbqq;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aPNFfIZB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79F8880F31;
	Wed, 28 Oct 2026 11:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4R7i0tveFgs; Wed, 28 Oct 2026 11:11:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A28C580E79
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793185912;
	b=PnjikwxRmtnNevzaqdiDZWDW9FoVrwzCgO1upy0pu0CpJh8tZKAqTfFhXiM8+LW/w8pb
	 6hyG1I1c+FIgopn0P34yVIcRG/F7EAl8klGHquIliLxP61c33zJb51cEoiJZ2+nVb256u
	 lBKNFcRgeGy0G9HpTly4Bnh1rrQcJE0TcaYARoMbTZ3ubfa/604F7VVAJiBfoIKY4+Qlq
	 eiT/+QkgLw51ryXwok1G4hQkVGPdRbuAODKxkbbPTyeeVIIq8PG/wVDqyIKwWQx7/NGaO
	 VsNLrK8vtaoa6xWAvLxB2DJRjXKqhtimyn4ScxsLcJnS1kXmC5dVVrZfUCawsKegIbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185912;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
	bh=PZowGaWKOyovCAMSXlHcVPEm+ut1UaUSUk287coxPkk=;
	b=UYWnmtLyi5jK+nY+dfzbLrHGmG87cN1QRtdGpE3BDW3JmodKQYaNqAr8wCMOmK0X/uzO
	 wsa75pDQ7+8LnRr9KjBhsPKDiZzZQBY+UnRb6s78zsX3SPtXmm/vzjb+S+Ini2SWkGlIk
	 lxhyPj8MK8v6bstBDIb3ZyLBL7Bg07x2Kc1mjkKKtCkUxt5e0nyi3l7NTm+qa2s+CeZEu
	 ctDVE/w7/lhxW8AnGPESYZ/mZRiGp0ekSUE9IobRy5VBysbQiSu5Q0tApr+oHVP09CSYk
	 ATqLzxG5IvQPPOCyaqVbD9uBlcyM0+b+LurmYNf25s/QjpH6wm3nDfykTLp9uNcsExg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aPNFfIZB;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793185912;
	bh=PZowGaWKOyovCAMSXlHcVPEm+ut1UaUSUk287coxPkk=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ECv0NbqqVbdGnIbKQK3l24S1o3f/jCKwBWDcpxdTNbDWOUdItqg708Jn66FwWrKRn
	 xZGQceR07alIyVJbAS3wAqctvJxE5tMyAZzk3IYDwPci87kLd0Sy4F6NvtLwONPwso
	 lpDc7BGJeG4vPMbtGh/6t1irnj8qZ5LBIpqFWnP7fsVNLnmDH3K/VMUDSOSMYwBiUd
	 c9pV/l57OXiNW70SGvT1SywCKP+PyDm85W19c4sPb0qO5duv2V5ayz1bK+WvouNO9D
	 1DNe0v3xXKz7S5WcOCzO+HeraXD9nh7F6Hbwtu4OC1MtdkMItyexoQ3/iTdlgMakhN
	 mLj6PLzlElZxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A28C580E79;
	Wed, 28 Oct 2026 11:11:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BE9A529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5966F80E79
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:11:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rud-YVxY_9g5 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:11:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 81EC880E50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793185910;
 b=iayzU+koDQr1+EgXSRqkAs0NidGKKBr4SzAUfNZ021MNBIkkIja8MDoAbYkcdEb8TgCo
 qoYIpNiwRg20SxmN6ncDb+qhbHvm5pFWcFPmM+hFF2ugMq5+pcKT/uWQccafZItnnktUQ
 WWNofXYsnE4hHqYNjTQpbs7X9CVCiDacohnuQuzoyA7eQ1BW29YSkrk+gYeKpBxHuw07c
 sDDb/YcruxWUO5am1VzifgTS7+9ZBkJ4DeKxqDLDscJwGABh+WC8lFcOpPp5PFI4N6pLP
 Y/znbO/FKhyVDTTOBKvnS7Xf5tubsdwjLPBkSi8BYVdWI42Am9JQhiwDyfBz11+uu0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185910;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 bh=PZowGaWKOyovCAMSXlHcVPEm+ut1UaUSUk287coxPkk=;
 b=igAymhUqhWgr98Ds76vUQ74+yXr/7iYNFdvhq1YwXaWgToDETSJQ4LKWP/Thp+YrErEh
 3ra0NZiF/rEfHFOoW1lmhjyO6LV8tc86viTDPu1JpbQ6aeVYexBoDbahhvJMJx2pBLmtj
 uJ4RM4/aqT0Ucgi9/rHSVbEVBW0vv1U3EKL2vnvdQ8rqLcs7SRvOs9LWo5lfK3JVodqqb
 sT9r519qy8HlQC2v5dVE8jc+SyJLerZ95MrLrhAw2pSZK2TB3GBai+93jGNSVFBoY1hMX
 MhI4cBjrjIQoFBgzQWdyIoEluoRGFh5zZycAFs8rNjR7gzlSHprFFKSXnQ7amHyPCDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=aPNFfIZB; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=aPNFfIZB
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81EC880E50
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxxbccyOlZTxF1GkY9AtymVt7Gmf+R23DMtYaHNWZ7O5+/1Te2xpABNGyDQiqynAypet7XCYpSOpuKXyDfXqxVGQygBZtBtOdoVCBVoWlkwewR5IpVibnDHkLqexScbpNJD9mK066hIOJ3OeXvrcLN+Tud3q3vXcj53Rbg40lSbhy25jJhFF0QAnf7JFVRy1L4hLFKuz8c26lP1ae0sxzFLt2jD80ZCqazuZOXyW1UNXQjC6gUPk54Y41rCO2v4ujAtgGRo7eg0DQ8EWbJAijHmO/4SGanvIp6/igVu5Wybl4xuJ/ZRiiq5y/DyyKn6gSEA0ILvoY3wv1XNhG0QT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZowGaWKOyovCAMSXlHcVPEm+ut1UaUSUk287coxPkk=;
 b=oxoNi5A6V+V7x3ckn4i7rmpnDDuqPM7I+ajsfZpMAfyUGEiY8T01lcBpXy+9WbRejb0u/lN6rs933UDz+r3HSDcxYVreH9Ddv2TWgAdjq7hdARgn8vaNXNwlwNk4wCupelyq5xCLUZ3Qw72VkR71PDoD+5hTSYEaj8hqW4/NK9NXhIBnQOIqQ3MLLN3yHhdMvkBT4Kh2Av2Tb7gIMIngXxmmbNTHXTUyjLH2DX0oySTQtTNCrkBYyEhm+L2lWsyVjcFW46/jGeL0cp/9qaQPoAc5HluuNDeJrx7GSwaa/mPkEyNTpm+26RVR2g7VGDym6WOseP0Z28hgZ8OTwk1+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZowGaWKOyovCAMSXlHcVPEm+ut1UaUSUk287coxPkk=;
 b=aPNFfIZBBXJNFOs8eEVCLxtvgORkvkAgN0+KTvX6dcW5203cexGH4DLRHeFMJ2gY95L+CPFyMEgZI6XaLIpaVYzE7omHrrmcndii2ATsyNpQAiyUnBz8t4LJaP4PiG+2o8PP7cTQnqf50udlQwWkji8vhW9nW68NdCwx6GLoXRI=
Received: from CH0PR03CA0326.namprd03.prod.outlook.com (2603:10b6:610:118::9)
 by LV1PR12MB999304.namprd12.prod.outlook.com (2603:10b6:408:3f5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 11:11:43 +0000
Received: from CH2PEPF000166C7.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::a9) by CH0PR03CA0326.outlook.office365.com
 (2603:10b6:610:118::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 11:11:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C7.mail.protection.outlook.com (10.167.244.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 11:11:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:11:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:11:32 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 28 Oct 2026 06:11:30 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH 0/7] spi: cadence_qspi: Versal/Versal NET OSPI fixes and
 improvements
Date: Wed, 28 Oct 2026 16:41:07 +0530
Message-ID: <20261028111123.1198451-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C7:EE_|LV1PR12MB999304:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7e7dec-b903-430d-5a34-08df34e43f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|6133799003|18002099003|261026140227099003|261009223027099003|56012099006|11063799006|261009223327099003|261022105027099003|261009220027099003|261009221227099003|261021121427099003|261009221727099003|261022075727099003|261026121527099003|10067099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 1jNH+IUpHpN6zKO2O4uo140TIRA9+yZB+bTO2WkiV//l1Q3/Pov4r1J80ZMRkZ8RnkXVtxSEGbDiGXIVuLXCxLi8/wpAKCK0PNvWWOEZm41j7O4mqxCSVXBbkTNE7z3kdto7FwfxUh2aQC50ez6rW6pHRKSfu+80hnwDLMJsxl4Y2xQZ9tusbuiB+aXhbgZcPZzKjT49ZVQhYtcQW7g7gcz/3GqjafiDHLorAtvbbzetZE54fmvz2BUkjZ23eZs5//IcgowI/GkZ7eczVtrd9zkvKqjds1hCxHi2Z1qZPAiqQiWL3bslWJ1Bl+vFZtnvaVWf3KsLp1upzbQNijbMu8a/MkLIfnWHwuYcHKEcphT2K6lfmMaG1DAIMEiOgvaqvRcMw7ottFAISrZaOtxp5a8/IWUX37pe52cZxTF9sRboQWkg9kEJJkhpfp+YKYxW6G+MBnx/eEM6MaRCXhNsi5JEoYfouCxUGmFxZY8XiKIyzDlEep+f9ojhZAX5TWkb3vC1jF034RbRj+3QTsQjJq+2bXqeFd20juQ7Pzpj6+Lxsy/PORi34LY5pKK8hlSlK+ZwD16HNsh8kKrsrRRxxHTp5niUjhznFq4gJUeeeyiZnZ2Hn9BydsRjSrrPqhlHZ9j6gFBjUwEj1PlzGmK7w1mQh+PhSGUe5G1HuRM0c1Clv29lXqdn70voJMaA+xOOJEuP+t2JdQOXpQVoxh1DaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(6133799003)(18002099003)(261026140227099003)(261009223027099003)(56012099006)(11063799006)(261009223327099003)(261022105027099003)(261009220027099003)(261009221227099003)(261021121427099003)(261009221727099003)(261022075727099003)(261026121527099003)(10067099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j9orR866pR/1kE9UITrXAOatL/ZCKvRYN2J+wH1sKu0i5XjOFTa/Ww/OnDKH/ZSVwj9FPJuTkYcq7M4gaE8803f3c2aRNxUwttZ1HM4SncDcR2DGBD6M5j/xwO77zjVbul8y8Qvr3G0OIk5cfWOoMQQNFXuCr8CX1RdXj+t8+Hmn1cEKYAltEw+8xETtjDnELX8wiTovBP756bxmPFVYAkjeaevDNTXjvbZyHBsQIcWQ69E+kr1RgPlalKFWG0fWSsW/xlfIDr17jc5ggm8UAX9kJDn8gWrhmRPtRR3S8XTiYTYtBPM9o6o4D8kOaJ+9Mgj9C5RU4vtS4+tVSZSp4mO3Oc4O1PMBzPK7Owk9aIPy0aVjN+2yiGdhx3btjPGHvKYRoVKPRsFLgKHQUndAcVk8046N25MOTG+jaEHkQBLVOOoQM/g9YCQNT0DoZWQL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:11:42.8202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7e7dec-b903-430d-5a34-08df34e43f43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999304
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes and improves the Cadence QSPI/OSPI driver for the
AMD Versal and Versal NET platforms.

Indirect write handling:
- Poll the Indirect Operation Complete bit in the IRQ status register
  instead of waiting for the SRAM fill level to drain, and increase
  the indirect write timeouts to 500 ms as in the Linux driver. This
  fixes indirect write timeouts on Versal and Versal NET.
- Write a 4-byte aligned word to ahbbase for the unaligned tail of a
  transfer, avoiding AHB bus errors.

Controller initialization:
- Clear stale controller register contents left over from a previous
  boot stage after a soft reset.
- Initialize the read and write watermark registers (1/2 and 1/8 of
  the FIFO, as in the Linux driver).
- Set the tap granularity selection bit in the ECO register on Versal
  for reference clocks of 120 MHz and above, which octal SPI needs to
  work properly.

DMA and reads:
- Enable the DMA DONE interrupt and wait for the DMA BUSY bit to clear
  before accepting a new command.
- Stop overwriting the dummy cycles in RD_INSTR with a hardcoded value
  for partial reads on Versal, which caused data mismatches.

Padmarao Begari (7):
  spi: cadence_qspi: Fix indirect write timeout
  spi: cadence_qspi: Clean up registers in init
  spi: cadence_qspi: Initialize read and write watermark registers
  spi: cadence_qspi: Enable ECO bit for higher frequencies
  spi: cadence_qspi: Write aligned byte length to ahbbase
  spi: cadence_ospi_versal: Enable the DMA DONE interrupt
  spi: cadence_ospi_versal: Remove explicit dummy cycle setting

 drivers/spi/cadence_ospi_versal.c | 24 +++++++--
 drivers/spi/cadence_qspi.h        | 19 +++++++
 drivers/spi/cadence_qspi_apb.c    | 82 ++++++++++++++++++++++++++-----
 3 files changed, 110 insertions(+), 15 deletions(-)

-- 
2.34.1

