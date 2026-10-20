Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10124606AA0D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ugN52AdW;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pSB/Ue+C
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4253E407E6;
	Tue, 20 Oct 2026 14:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sAiLyryKopnT; Tue, 20 Oct 2026 14:17:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C1E1407E5
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505861;
	b=ZCc3MS49rkBiCQ61iLu7JuWczJviiw8o8wpD48qvY20EDDfLdhggEYC+6Zn2kLSxvwfT
	 yRELNWfW8TZh0sZo9/hgrEgdlU9FCSOlyJEagvMvq6zqUcoliFoz8QQyRVQIV+ANXOkI6
	 HyUEDqJTzYaQLxS67acvUq3KGDjd65ExQpkegNaFLfCBAuFb2X1fnHNJR1GFEuTAfBjIW
	 WnXmeIt5fExF0ltIXHEtGcOXBoumohIRsOEq0+lDrPWtP4JZ3AIIw4wVBwNZroUNpqk8/
	 YQZWmB9R6vQgMNqlpr+FYKRc76PfTg2g4KdmFWl1YRuUZg26ubtTY1xos4evpCf81Vw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fatNn8YaNG0yLBtmk8S552HIaan/EpEmc7NMJ86FZkw=;
	b=m8nXkvOhAr/yCCdbApJFGFwIooEPIMAktkSvXMnGrP87MNlmW79XHchVz3m87buZj/CW
	 FvROmjFK1FEnjblfQD4YUGqw2CH3lRvXovijZoCGXdSVrzO7YqQbTckSdpVmQixaiRpBu
	 uQqgwFpXYtNznbs+SIiq9y/lYGrhGdCH1N3FelpHn16CSnMolm9/XdGoUBMDY1bD8Lgch
	 /CHNbfEFbxvfyNLCafQ1zmM+It36+N9eq0pRVoi/hQV0c7GOq5YGjjOEGUz9psls5RRau
	 BBqthNsNkAwCIKUqitNUQb8Ehr9fH5sj0R1eMq1cf2y12v19TzZl3UO7+JY6xNh7YDA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505861;
	bh=fatNn8YaNG0yLBtmk8S552HIaan/EpEmc7NMJ86FZkw=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ugN52AdWwsHt4/bobYNVvPrZv16uaYwr3uIj0Pfl/1HL9zmFUK4mMlZdUmGRYjHPl
	 ZM0LGWeDkfs7VomR8oW2YD4yFF3K7JtW/48CEF1etzNyrRI4ylCywQO5SEFYsk5RSt
	 I91wip0/Cx3vuSKEPyW3G/l9SU8IDMhaTK73qFTEu6DC8ruBMCNx8xj/lKQnhDtVL3
	 0CC31e5vroBAj7UNJNIZaxqKBSosV17UzSEiQycn3X5RAM8CpNJ3RQ5QWpdN8XhoLL
	 o9mbWhIZe+gAIl26591Cc/+qJb+K8Ec9Uso0GHWepLHwa8+T37nm8gBNOzzqvYxhDs
	 XqPjdHQGprgzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C1E1407E5;
	Tue, 20 Oct 2026 14:17:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 16CEA1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0BD080E34
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id No7V3ojId5bW for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4399780D9F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505859;
 b=cPpv7hn+wN2ckiZjnkYK05iVoMMHHE8EtMNMw6cK/d+kbHTZDearr7df4fQ9ZmadmkEg
 gPWlOM9e1yK9FC9KNZ424/bnZ8w7qmzViQqVmXr3Cp3jsFUP8L91xvclkIAzRIOv8Y0Jk
 VMxSQIi4oK5zUE4Ba5hoiCndEVlcUzbJ+3xufIoESJlkBqcU3VZuF2ydw9/T/0aDQTv5v
 4oJ8wTtWn2a2zL0OMFKvc4E9LtwY4A9rhM2xl8/qSjQUw5HSpkmyyamTvWOKxCKM5QyqF
 LAhHrdK+oMUXvj1xqYQ0Cvn2g6ZDNw0+i7t3Iv9AgdxbDXONLTSH4ro5Ay7R1yKKhPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505859;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:X-Developer-Signature:X-Developer-Key:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=fatNn8YaNG0yLBtmk8S552HIaan/EpEmc7NMJ86FZkw=;
 b=mAExl+lrOhZwBcC4ELEcbnhzrId0ieOM7uQHD7jnQskheRUKIEDMNskLfY7mU9p0LrJr
 fwnXNnqPc7Z89P0tBqS+iBgSX1u3/JPqzCwmGYctRvNZsI2PZGFCALlpearwIIT1zpoJ0
 MgeKX0tskpUUv6nVpJqc+DlqwVY1uKKaU0XcRLE2/166IDyLzO223NvHY5wGhcUYpMfG5
 3duIpxapC5M/ArXbeJjUMT4MSk/ZJ4VyKTx1tnbk3TiUpGdFKc1zQZlDg4JvAKmkR6jL+
 eHK0hun/zs7h2k36ylwNBjoxvvG8eWa+MBULPCIH3/70ka232IPhbv+fo2TeVXyvB9Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="pSB/Ue+C"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=pSB/Ue+C
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4399780D9F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFh6iPExffZ5Nk3M/zVC6Vk/1U5izp9AOtz2YTZ6lQWDTJOymyM6ekEn65hBP2c3LZNrQs0580fjC1Pn2/HL02hqOyiNZTsm859BebTaCIxMyjRx5qX92AmzWhlOAe9OxpO2AZnte+CX43TsRuagdYgtjuRG0fmaGfLe2U9DWywuwXWp3u3oEVEuvDOsw0r20jA1MW7ru9fZJS62hTnTzkoAaLyoA6klU2Sq254z55ECn4QrKm3pj+GNdrf2ItGkSe7IAatHVBpJnDjC337/2zZWKsJWIg0doE06JFWs/c1B25Jx53KR3Kufs04ljBWuYBcNNJwD+bnGqRRjxXSFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fatNn8YaNG0yLBtmk8S552HIaan/EpEmc7NMJ86FZkw=;
 b=iQLzHf1Em/w04bZgBMHRrsGyE5CVbNlB1tuku/pvaOIHrKJuRbqGasmbzUHM/ZbI6UtAp9LN7NGPvJPxS4ZWQw/8XKTtD8LfVNhfptSrCowaFODgL/zKlkDyv/ePz3u3CwX1wRuZsDtKnCp7d0ZYOCaHA1wxZGADbeLO6HrqvZAbvcMLIVdvIkGs1vVUDToEL6UQW/WLV8v0r5GuLUNy2Cqmb5zhS/iQnjvMFaNKLsrISbLNtbCHNIm2+pnWql6qjTvuWe/PtV3/szEFwIS/e7EJkXMwipzRy4ohCJO9ByEnjjHHEPYzrMYB4OCsRH64B4OiEhQewK2rdoGa/Jd7fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fatNn8YaNG0yLBtmk8S552HIaan/EpEmc7NMJ86FZkw=;
 b=pSB/Ue+C3Tzpdse0Ht3ZXlI33jP/3yMr5LbEuri71GhmxO/DjAOf24NErlVvMx2whAd3nQDnLVV6ULXZRBtsP86hR8f+TSgoryO5/SZ0Zr0m9Old4rS61IghisJEK18at2HlFMfp1oIUieJwYio7anJ2pxFQtycbCfKzvZNy00k=
Received: from SJ0PR13CA0190.namprd13.prod.outlook.com (2603:10b6:a03:2c3::15)
 by DS4PR12MB9817.namprd12.prod.outlook.com (2603:10b6:8:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:17:32 +0000
Received: from PH7PEPF00000008.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::65) by SJ0PR13CA0190.outlook.office365.com
 (2603:10b6:a03:2c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 14:17:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF00000008.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:17:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:17:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:17:27 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:17:26 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Pranav Sanwal
 <pranav.sanwal@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] arm64: versal2: Disable FF-A
Date: Tue, 20 Oct 2026 16:17:17 +0200
Message-ID: <c0af1071a0b965e208391eaaf000a25008730ac0.1792505836.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=623; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=MtxzqABSisVp/fRrnrdRJQjltz0T1nw5juy+gly1DvY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL/8SXWe5/+Cqndtje3ueJ/777hdZ98lLpyGiZXfsY
 x1+JfvmjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhIiSjD/6Qv/RciG2e3zbk1
 Yapk2Smtu0eXfmKNfVvfu0ppr9BUs8sM/z3vL9lYfcWM5RWju2doxaItazcKyrW4F3t4lr+odDm
 7kBMA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF00000008:EE_|DS4PR12MB9817:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a1f002-4138-4f26-c043-08df2eb4e114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: MXGzassG40FzLkvDegfQmRLh8wwAdWLB49V31qVnsOAL5zCc0lcGTWP6xM1eCkGS3zxLWTCPexu4qBjK76LmOGvHr1TwPdZI/ddogG9p1QxF7T172AYfq0ydq6kqMCmeYCFuI7egp+N6gP+3MKNyMaKl+hwBLw50ZcxvxHja3NhGyLdm+ZFd/c8XNxfcJ9Vw58ENijR7ObANgi9dPbk7p033PNPkh6pIY9FvFqAnC66gQh9/c49+QJbH6CDNzbCjJVHoUtEuY2eSvfvAD/I8UQNj3VobUYZZOTXb4yZQbGupuud4s220qGQr+84PNAUxvt/P5Xu64x7KOu+6sURwFdgK5jfH2oVBfdmoTGaH+J2MNEIOg24ifyYui+msfKABij2yKNcZZY6MPkj9tsk9uFHSF8uSEP1ovpr7KUjJij/GdCYFFqUWTsyZYcQRrmV8lwPekStP2whSlxtslDH080pYMj5gT922O6t6lcszmFYT/8tsZ6qfVTP9M5wpSTRK6924TkknifoNFiWFy/kSNH0m2AGZfU40bn8wRJzzmoBNvdUlCK5XAOVCOUq65CYl8XcJntZhhqeUmWVtB0IQO3pI8aHnhSiKkViGSQ82vEWHSbThW6lXKoo/gJyE/9kYsoqNXrnsDNYaEZQgYvUtofO9GmuaNskK4Eqk1+Rk/C1JM++IQtAxJt672+gPm1t81hHo8X2pngAgedQZ8AEVxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BTcsgsyl2TJM1ZPalBZLgyWHvTICaGLxvmSouu3AGxwtLNa/kMZlFMiphLKWo1qZ44xzJd5CiahNC2qqjWjdAQmVM3dWrLk6zXImNlysq6srW3CikQtzSdXu2XFN0xEv5ZPCVRQRk5IdsLb4KbotVVpNFhYpVQPsV/4/nV1MGKUWX7OSU3YT4YOFW846eVpnDUedcYfPBqJeC3k0jDyAejNoHu6gecbvciTR8nDoXJqwPketLqKOfQ68wS1ozS1VpHFicILYnH0eEW6mjZZUc6zNJtkLDOUSi0e4G+zfCcDaSFXJvvEsRytG4XgiotLqvR5QJaBWizdY5MZQEcW+KQk4cAfOAwD8ShFXW9HGESm0RxBuETDJFAQF8WisER/7Xe+eWmj1xy3FTymhaAdybhVTjnmlXDXI9UfYP+BeTu5LdzvBTQqHphMymi5H/oP4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:17:31.4397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a1f002-4138-4f26-c043-08df2eb4e114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF00000008.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9817
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Disable unused FF-A transport layer.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index f6f87df632a2..b138d58adea8 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -92,7 +92,6 @@ CONFIG_DFU_MTD=y
 CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
-CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_SCMI_FIRMWARE=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_VERSALPL=y
---

-- 
2.43.0

