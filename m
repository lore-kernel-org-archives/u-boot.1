Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0D606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=1KXk+a3G;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xsO2vrAx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 570754074F;
	Thu, 22 Oct 2026 13:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S_ii4oz8iTyG; Thu, 22 Oct 2026 13:58:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9383F407C3
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792677499;
	b=QA1EJtdneHIzE3tW2gK+6aTyl4+mD8TG6lkaValvocv8G4hQF3uE82MAYN3AmKIMcDGS
	 fqT9SIhlhCFnJZrkcdLUHZOpugEdcS1FLVsZJaRM/hnrVGrtw8SHp7BFNgTD9m1yCyv4k
	 L1S1urLGbfwzcPq77vtnxpOXHq3w73NRavxPG50OQ0brWVbpEYPN7sk3pMNExarBV2Uj8
	 +kf91D+VHjIQzitHsT8N6T9PGfy6GAO0LpPSwTpFj1Pj02iIl8E79J2VeI7q9PUOeD3Eb
	 OMFRiG5Pp8R8U2SfV0M1fVbe8FPL/YfaKcfnGSZVISTo+JiNz525afm541BEPzQe2Ew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792677499;
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
	bh=8SwzwNxxXmlUdY/T3e8aB31jnd9XEzrZmN6pcZv40xE=;
	b=KiXmKguasM1QRsSKw5RXBAqvneoPvP0QM1yahjHtZuIz9kf0k9MNGSle+OyF9TzZ8/CC
	 AcZc1nhuWG51hj4mIKIJNZ8xGsdU649MSJIWmMK067jc/wIqpym45O6PqKJVnAga3Hxgu
	 Yv0BYD324o4YJQveJa4x3uXWLxaGOHBp4ByLJG/GXqIV1iaT8QyU+O6goi10r0WjvujCJ
	 ntLdj8XPKs1Lj75zSiMTWpAANcATFMjEbP4PC94QxmUZ4CmrFJBw33RX2n4H6RpU+4NSm
	 RG5D4h8sW9yQPijc7XUHkivCGG/Oz47rEqZCmr4UfpXXkpUDcEVLC45sgWNIavZZeWQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792677499;
	bh=8SwzwNxxXmlUdY/T3e8aB31jnd9XEzrZmN6pcZv40xE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1KXk+a3G/hYmYmzeQ3r9vsTJnc0hJum6Ea2UhmsLnXISCNLKNAHUUfefeBrugFW56
	 lIHZeZ7P3ZPSG/K61yaDsorSvYR4CTbIoBRhJGD0ff7SIC+XqRq0KTdzcYOJquEl3Q
	 j1MtKX6teFyem0elCz0tthv/GoPsvdVS955L1nO0/9L+p35z3KLJeI43mRRsO6X1CZ
	 0tymqAQS8TJ5W5E0W9Ewr+gIrG4O+yIdHYwyhBSXdr9dp/YK9aOMerFyzUxcKhqd+F
	 xMmj+XVnrdRsGFtXhK9iuvn+JgVZE78cMUsKAzIv9uUCN+U8fs+Rg35UT2+jLLcIJz
	 Ltyw4g7s1ludw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9383F407C3;
	Thu, 22 Oct 2026 13:58:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2127395C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12B74607D1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nfxINLsBaphF for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:58:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA3ED6072E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792677497;
 b=phtsBz8x/qbqInpuAIMnmO4XgEo32n55jue2jgycPlViqah1jcCO/SKZf7GgYL5fgOsR
 FpSZR8aqzwQ5Qak2rZHfg773TFsm3cBuBTd0p98puzqC+LZOI4g2CnL+3zZkRsA1h6hrC
 a1ekDwHRR18JY5Pq/Pf0874cTN5gjmbB/L21srM7RykNiO3Mc9YNmEYLp4eM/9BXuQsmx
 IBuS96bw2o/FoWbkSlsvhhOBMEYbVFzfEbpeaIWSkxnXLEg2uOGK8Z/R1v/fCiQzmB/HI
 QeMRLpMFuK0kuFo/zaL4aENFrqpVAQ76aERXxkSF+CRQK+4Rbla6hnJwPHuslSvaMLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792677497;
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
 bh=8SwzwNxxXmlUdY/T3e8aB31jnd9XEzrZmN6pcZv40xE=;
 b=CyV9u6vzan6LE18NtkGxy3ldPlxCUS8vXXsFX2DRHYBtdrtpT3kmq51Z4YuH+VJQLxeb
 gHGrNWSP8lBBi61aI3LJIoAAPbg9MiLXKO9cj7BLqMiLrMc3udRelrkJVei/mc3RJigAm
 +oRugDAEAdCbYnKZoFIeKBaLluurzaheAMD/6suCnrLr1wbMCosCrVrNWWxq6g0E0IdOo
 zTdsEIWC/a3R6u3V/QvSCYW+Gqs2BX55gOpO8tmr96GeZ4avJoDk5ebfATO8fyfISU6Bd
 7da5Hm8yksVT+xPc7MHnMUABQmtKc49jeXnD4oclc+EoMEgoXMNfUSw6pwimoIKqljg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=xsO2vrAx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=xsO2vrAx
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA3ED6072E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFSy9c2F0djF0NKwMrInitTSAZsgdyAPDgMvw49VSVbfqMexB1EHVCnNNyYr37e/bS02Pykn0Pe/YfdRAXmz6U3wBvTc05D2Pe29p8A85KendMjNvpMrfYZItvaC1xHnpBIthxRDPLRJ0EvqqsTuA8AJ2GBLMMPzp+qSQtkyj0l5xa9HI5H33V8tTsUxU7V+pHnb20yxTk5hFrKY4Gjf7Cd86uRiTknaW+iGLyNIN8Nz6YPfcW8ldNDOpy7NaE1tuBMydHONXnGa1wqXutIDUHXJxzShRtwOxs+Lc1CKiDyqEdooD+ohsVPK/pkp8B32KeKITP4MgZJFRU56Q1dWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SwzwNxxXmlUdY/T3e8aB31jnd9XEzrZmN6pcZv40xE=;
 b=uZi8K43vjBisS3N02YRM6766WE5bcM+jLvyw2fH/4yRJtDwiWw5iiTgZ2Adl42sXjp6SLwjKoqCUFz8LnrDa2tUY3BF1+uRRNLzjTO8ajt/kADB9CJUI1YHGrG8LgsvgmnbEDAzSO4Lu5udTaL8G3eoxS/QFAjEkxp/FitjF/695VBwhQZDUY1hZQ8ASdE8k0LhqNOPceOOIt28GaJ8VtQruAtgCjQkPsm9xpuj5Zb2mCwwQmjFdOa0mKP7OT+mi03fbWqSiTg5hz5Gw2SUNYVjP2Ij8iAF5ldAqR4K0AmLT9lN3qQun48UgTkC0Ow33SO903tO64HBZGpK47pmQ7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SwzwNxxXmlUdY/T3e8aB31jnd9XEzrZmN6pcZv40xE=;
 b=xsO2vrAxQZ7SxTVL5zOMCsfxK9zFgHpLQJ/e0PVM5/h4XMLBtHiSCQq+NcsUuBLpNK/WFENn2zaJLWh+TkHSxdyAr065RTzjihsJCWy1G5sPy08/AW0UymKIgFjeqCkqFUy78eJBu14iV9FyFeKkzCaPHhLTnp1ZoPL/NN+wano=
Received: from MW4PR04CA0045.namprd04.prod.outlook.com (2603:10b6:303:6a::20)
 by PH8PR12MB6964.namprd12.prod.outlook.com (2603:10b6:510:1bf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Thu, 22 Oct
 2026 13:58:12 +0000
Received: from SJ1PEPF000037AD.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::5) by MW4PR04CA0045.outlook.office365.com
 (2603:10b6:303:6a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 13:58:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AD.mail.protection.outlook.com (10.167.244.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 13:58:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 08:58:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 08:58:09 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Thu, 22 Oct 2026 08:58:07 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Abbarapu Venkatesh Yadav
 <venkyada@qti.qualcomm.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH 3/4] spi: zynqmp_gqspi: fix chip select for part-concat flash
 configs
Date: Thu, 22 Oct 2026 19:27:06 +0530
Message-ID: <20261022135740.3869144-4-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022135740.3869144-1-padmarao.begari@amd.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AD:EE_|PH8PR12MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a3b4a8-0c76-4483-852d-08df3044823e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|261021121427099003|56012099006|261009221227099003|261009223327099003|261009223027099003|11063799006|261009220027099003|261009221727099003|22082099003|10067099003|18002099003|261021123027099003|6133799003;
X-Microsoft-Antispam-Message-Info: EOtlrSkc6KwPN901I6xahqwgG1EHg3eITa7wrMfEwPsmR5QSZ0ssbWdKxoatp9xsoe+DupIxBPNCVlCxV9k4t869ZW0zIDmaC/29VC06fr4UGsDTtA2NAPyqfkrFqv9FtCWf9TjRgiJF1Z2yj8hQlCXykF7OKEa+snBKThsmO4XCTEhR788ZZK6QlsxqTkxcO3AFTHlrD++HhmFfVe8iloEiBqcDCx6XOHTTo2yudtYVPd4fLCRFw9lanxXGDG9J+WTcvGRZ+qCA7SKkWPrhragB9RUNhKmCKgpEWmhyntJAqssI0jJfcVIYMH9RhrVF7VkQxUH4QQktx4gog4NsY9J2BFBbLgH5foLzeidmAHdQ3022xX3OzzzKww1vYe5/4c3zAE+bb6GwpDOvBlVuc6MNV7LjfCsuqYxIwD6FVjrGkrZ+3jcuIT2GGRSPFjB9zJ3/GJK4faQQ5OaZXMSHUM33Y2Uxdw1l/8T29t6X583OmQzgkY5PZIrDyKCLkl1pCdStk9a0FosdYb2yICNMo6xixYWKIpklRq2m7bjEEFrIPifQbLhUtU9ps1wU6xTgMHx3v8SCTBkQzgULMgjR9PoU9HW42HVXdNpdi5YicvlyKwuWQBBwigC6afkDyFoOrXE7Uwt9nrEZg3A11DlwYJSzroFrzHzeUrjERsRlR0Rd/sYiw6c5v/w9q22PsfrFNSoIPxWG4Hl1hEAExBfr5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(261021121427099003)(56012099006)(261009221227099003)(261009223327099003)(261009223027099003)(11063799006)(261009220027099003)(261009221727099003)(22082099003)(10067099003)(18002099003)(261021123027099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kyumdBONUgT8GkybpW86RYRHURzle3U+1Heze+wOYHnGcNcFLzURM1mkV4MGQPb6quRxedW/py06c/Beo5ctH4Ij9t3FkbTH6ev2ohgPpAHdZz1i4rqc8/kRYZJGU0JfsZumw86PIWtREK2OaZ3ezTVJ2CFmBjDwfQ5aGBZwyLCm0sKA8RROyzR3r19PswppDGsUUVa8tVkSz0Ru8IgHvUJ79Rw7Fl6KeNAjk+YEN2QRSixniVBAElpPaDFkfeRPsW300bQZ6D/TiLpVHhPY/VUzbtYaPgQsgpY2h8cURJQvLokYyL2ZaIxr33IPdtMF9q4YXL984pQrQgZFsUokNOqRTG6qPOumjiuz1U35ib22G8NSTp+GknvSXMN1nVZBm/VLH9T/UY4K/DAcO5z40dsbW2t/PLan/jJ7CaDp8d/xX1Q79rsjLmg8XjiBZCf+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:58:10.9686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a3b4a8-0c76-4483-852d-08df3044823e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6964
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

The ZynqMP GQSPI driver hardcodes CS0 as the default chip select when
SPI_XFER_U_PAGE is not set. This works for stacked-memories
configurations where spi-nor-core.c toggles the SPI_XFER_U_PAGE flag
based on address offset, but breaks part-concat configurations where
two independent flash nodes (flash@0 on CS0, flash@1 on CS1) are
concatenated at the MTD layer.

With part-concat, SPI_XFER_U_PAGE is never set because
SNOR_F_HAS_STACKED is not active (no stacked-memories DT property).
As a result, the second flash on CS1 is always accessed on CS0,
causing incorrect reads and potential data corruption.

Fix the driver to use spi_chip_select() from the DM SPI framework
as the fallback when SPI_XFER_U_PAGE is not set. spi_chip_select()
returns plat->cs[0], which is populated from the DT "reg" property:
  - flash@0 (reg=<0>) -> cs=0  -> CS0
  - flash@1 (reg=<1>) -> cs=1  -> CS1

For stacked-memories (reg=<0>,<1>), spi_chip_select() returns 0 (the
first CS), but this path is only reached for lower-half accesses
since SPI_XFER_U_PAGE handles upper-half CS1 switching. Both
configurations now work correctly.

Fixes: 217b0a28b6db ("spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/zynqmp_gqspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index f572f2b3f15..d160203c817 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -881,7 +881,7 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 	if (slave->flags & SPI_XFER_U_PAGE)
 		priv->u_page = 1;
 	else
-		priv->u_page = 0;
+		priv->u_page = spi_chip_select(slave->dev);
 
 	if ((slave->flags & GQSPI_SELECT_LOWER_CS) &&
 	    (slave->flags & GQSPI_SELECT_UPPER_CS))
-- 
2.34.1

