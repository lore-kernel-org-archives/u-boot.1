Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F30BCC6B2E
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 04:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB2D060A42;
	Thu, 15 Oct 2026 04:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWjOpw0AAQHv; Thu, 15 Oct 2026 04:50:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB246608FC
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792039811;
	b=Wi2DAePDtjiX7zP3acZiJ/fQ6hs6io/Xm1faIfe1vRauHRp4kvc6kyFESjiefM1Wh2iH
	 ELViISgWHfOt7IEMKmuoBdx9okRlLD7zQeXShsEh9IynNBP3ZS2fcrRnPjd0SycN4B0XK
	 SvozdxURSazcK/hkrO+44Q/U4KHhYrKTl1u12IXb+H/krFunefbL8ev5+TLdqFgQEXMq6
	 Dpx7Ho3duacurOdXdqOmm5PpBeT0ivZvTU/A2RMTqLqQ7tjz+FLAqxhhw1GlyomjVTuD7
	 RfrXW9AnAQOiKDaPFHLtAJB296I0M5ofGQ4rzGD6+QrED/1ZqDfjckDtIurXu0hFZgQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792039811;
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
	bh=0R1MoMaSTEIlVoWud7UK45NB+IOcIEv5Q4A8rUpp3c0=;
	b=e3unjVgQ5sXYkRd2eZtnS+eiAqhXNGN/ISrH+zO9N6s7BnkJKHj6iiZqznRVbc00JCdC
	 VPR/dC9cq2obAXOwt/aG82Cc0Bh4DQYaXeP7LU1Qf2E4MDC4SDVqATGI/oBPCBILkeLiP
	 dv4iZ3K9dC98qiz5rs1LUd/oQCNBVsd8TfzYLjIuSuK22F/0eJK8r7+Pvvytz73SQ04CX
	 FY1EdS7yjrxoPBvXDQ25H7fwTpiTXZw7f6C/Rxp6R+SBifsb8ILudRt+FgGEiaFvYnSxt
	 PhslyZubBeXhQUNFbRMhMtLEopNJc15t7eJlzHSm/5eHrT029UAuUGzQecWYGIrUCrg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792039811;
	bh=0R1MoMaSTEIlVoWud7UK45NB+IOcIEv5Q4A8rUpp3c0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KY94vvX/ALx7HHgD+/qMTV2eMkru8kfkCpUDoZNcg+atk89+Rxhmmy4iiDuM8zZBI
	 4nqVCtpFbpChq3NOEhqzv69XzQ/vy3lF4KcQDWuCVQEYUAO+meBXSrYwikcJwD2PKl
	 LmWGTYUJjIaoMiD/CvmMPKdyBN345a0JHoBJMPWl0YmlwGLbhDTjIJTKEO7KD2euZ2
	 shvNvS7qlQFZ0kIUfF2HkO1Y/5xT8KcgCxcBnCgJ9r+p4oxH/d5BlkJX/pyToJA0UI
	 I7cMztDC7I8hsrctGSjq/BQIYWSW3wuLXRq8E0GF1IDijbu9NR/eKWAToHjaY9+gz+
	 HdDUsLVL11VGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB246608FC;
	Thu, 15 Oct 2026 04:50:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 61336A58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 471B540223
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:50:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y6rabFXklbUu for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 04:50:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 728D940053
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792039808;
 b=WvICz3giRc676K4fG0DNwwDvFijSlYSHt6jsUo09ruAeF6SZNEW0dOpXkGFjkKa+uXVH
 LVWm9mf+PsJ8fz7PTottdTyYsnI5izAes6pem+xqx+Rxon3CQ5iWiXCpgbysCVu4UNa/z
 RfgjcOT0+fOR+nGPXw831JofyPzNOmKnI7PrlUwMOJWHqllTOGQewH7k+qlQpLOLlx17B
 BRA4pCWL3FWeFg7r91BIyESuTXMgZ3YjLONL73bGKi+d3mNW2qobFbSKx69EyWdYwQts8
 C/1TfBauWnnCjXfAfD3U95OxjD8II6tRF+Ur9C2mwPKl6s+UzIckjCzY069GDBkZJDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792039808;
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
 bh=0R1MoMaSTEIlVoWud7UK45NB+IOcIEv5Q4A8rUpp3c0=;
 b=pt+W5Nvnru1DoMwufGjYaIQtdsn+bLRdjvZ3E2/pP+H0mlj1iBYKFhC9BZVQhgyFFEap
 2ZGV9DmVd+yT+QH7BcJRnBCeXdhu0PaWZ+gCC9Vb4g+1hxb4YLpqLXWFB0Fw3Pz0yZRAj
 ngCFKBy8Nuo7CRLLUUv4lSoZSljmbDZaj5vQkEQgbYjQz8rWSFkYj4zuA7Y33ohzb79wE
 wpAAlrGAGYdXA4hm5t7LtDNAozqUPw6nlk2DGQu1vcYfvH0fyhyYVo/cGTgEIrSmssC7W
 5IVLCjFxZgYxWt9p1fNfrOixQC1QW362mFJEwrYQF2OwB2UxrfWq2Nb7RVc+/h9MmIg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1wEb7HhT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1wEb7HhT
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 728D940053
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 04:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOwAW5t/SKjao7N5M6xeKF+oZO//+V8RzFxZdfcn/jqJAOqVVohvsmvWsp8s+UqWyapixFkW433pHt0iHi2cu7M69cg/KYFlH0L9wMnLP5+2dbCuLaPufZo8QBBULitCwxHVT2wnngpBxT2T4N2VcInfjDOe/5dMh9aUuGZFkwjXIlq/BeX2a4i1gaA7BDAHpn42upXsLguoQEVyS5tkydB0RwpIcYWecX9C5n2XNQeY1VGgYpjQNf7SdD1+uMEjjBlXRiEzR2pqiM6KlimCHPO8GCsmFl2eIygAz5tEmsycsSGJWTQTjEThyu8sKbyMxudYxdiMr2mq0DAMi0nVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0R1MoMaSTEIlVoWud7UK45NB+IOcIEv5Q4A8rUpp3c0=;
 b=fJJhvkIUqQgiRjoSGqZkKlqoJDcrN5qMxemf6+WH9EIJYfHpVRXRVx/9aLPoac1aI40F3smvuTlANJ5W1e2g81y8ayyLJlaOOP16wmuvKkTlFcieKQLoqru4wUbIu2d/2ZoXXBLOE0LYUegdjmG8UYyfK/iHw84PBRmtvykD3WNZd4cQfIx7o/QZJD1YBUM24nO8gWR17b2zQJOfA21/NN/igF+iUn+u+S88C2QSqORg5lfd7RPtMyG1NVSVoOuE9GqykIdnyhBkow2vObnT3pwj/ltP4nPcKFmwpMQlTLr1jDghk0ifhaEJ/AlF1WlNbrhy7jY9Vq12/ML7xS4TYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0R1MoMaSTEIlVoWud7UK45NB+IOcIEv5Q4A8rUpp3c0=;
 b=1wEb7HhTx9b2MmxKTiQfHOkbcW3sRzMl4cPaMFWPOs5ULNiDHmadXs40OuTNcD4stSU4oluIj/nxeCbL7dEAy6oenvA49hded1a5B/DBshJxmiaIXUjxSPPQHGJpzws2Tm2+EJNffB4i/aI2Rng0dxQynXpF2D40Z2dJdIMK6Zc=
Received: from BN9PR03CA0394.namprd03.prod.outlook.com (2603:10b6:408:111::9)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 04:49:58 +0000
Received: from BN7PEPF0000009D.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::e) by BN9PR03CA0394.outlook.office365.com
 (2603:10b6:408:111::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 04:49:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009D.mail.protection.outlook.com (10.167.248.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 04:49:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 23:49:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 23:49:50 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 14 Oct 2026 23:49:47 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Rasmus Villemoes <rv@rasmusvillemoes.dk>, Sumit Garg
 <sumit.garg@kernel.org>
Subject: [PATCH v3 2/2] scripts: pass dtc cpp flags via a GCC response file
Date: Thu, 15 Oct 2026 10:19:08 +0530
Message-ID: <20261015044923.206217-3-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
References: <20261015044923.206217-1-suraj.hanumantkakade@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009D:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: d742877f-6a29-469e-0418-08df2a77c36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|3023799007|261009223027099003|56012099006|11063799006|6133799003|22082099003|20052099010|18002099003;
X-Microsoft-Antispam-Message-Info: 7xFrgtFSyBFjvkbGnxRqzXv+D2NEeNZOwwOrFvf9S5gl5oi/CISCn9F5stbyvAuJjDz1sTSXBcDx4PBsQBZ4660DPy6WAx5Mg4l3gKYDw5P4SaDvtdIlGbhcs1ntBUFDzWI8pwrUOxsZdv2V5jvx9c5yGBXlGK896NM2ZlHyfEfop6L44OsYV5WXLbu8fV2VuAOFopuQkRPTl5kpMu0cCDJvgq2JFqN/20jtKUG8QwpPZwmfchAEF7cHWWoTAhQGutod6aGraruWRfmr5tGs//3PnuDNYKY2TMRVXWKbeOtIibARkHuDo02zlJtDHK2qHEElW/AZh3lL3cYczlBSrXraLQc5WZ0JFKogOe7uT94zjKSncUiA1q8/U4xHC0IhsduqYYsl6nc1bGyfZR4qjqW9TB1Zlb7WYqzou6ieK5kxroPRV6oArhznFexcZTzRiokRvJO19MFb+u5ivZEKrswOCad7Hxx8JmoSYUso+tN09+RVKorAn+VYXkZpObCqcvJkOt3iy/WY9CTTTQ2i9QbDwU6uLtFe+nqfm4kMg9hFdR7V5TIx6eH1FrN2sQL85EbzwfuyeZ8JoT9UfCXn9RWcty4g9w/1QilICLrDmpCXd9Z5vpw2HMqgarNywq/K6ZdIsTPF4IomOr0CFhNq7zegWii0rOs6srKnJNShaEgAPo2gXXQGOq04BLh4J/9BOa3aQ7DkgMV5KzTcpSOniw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(3023799007)(261009223027099003)(56012099006)(11063799006)(6133799003)(22082099003)(20052099010)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sjUBn4UUO0usPIxySWF2DpP526HMkVrOS1H+wBVHl6UygQVZCKFlT3GOF9AA7NN8q/2jYW9ndOo7S/3heR52jDXg85WHsyB8D7Sd4LszO9gTluCISBtcZeL7br1rHu+XJQfP3/20FYQlFpwx1vb6/Hm5BwMWE2Nz5u4Yjy94ASPCXVlNLM8cr88Vh+m8J/ABbjvsEnfTE8rDnGCUf8sBBtySpkB17liDb74OW+5hiMqeEZ4y67pfoxCo4x8B1TCtmoH7LY1RbNPMyJR40ePmvuf6X1YW1+tFOIaxbQb5sqcwF7sYWKkReucHH5kBEYIwl3BkbUcnn/0FSsgiEMTVGfDkO0kHBJNYuVPrBq2ANz3bc91Z0+MWncu6Xq6wLnC0gI/GdneCJAnpZ7WYDfxFg1VnW9DeBP80mvwFnspZXhZT7JjuB4d/uKVh750TqZwI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 04:49:57.7587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d742877f-6a29-469e-0418-08df2a77c36b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254
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

cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
path) in the HOSTCC command. With a long $(srctree) that command is
too large for /bin/sh -c and Make fails with "Argument list too
long" while building a .dtb.

Write the flags to a per-target .dtc.flags.tmp file and pass @file to
HOSTCC/CPP for dtb and dtbo generation and the DEVICE_TREE_DEBUG diff,
so the shell command stays short. The flags are still compared and
saved with the command, so a change to them rebuilds the output, and
the file is only written when a rebuild is needed.
dts/upstream/Makefile uses short relative include paths and is left
unchanged.

GNU Make 4.0 is now the enforced minimum, so using $(file ...) is safe.

Fixes: 3a4e5944c96c ("Makefile: Allow upstream DT subtree to provide DT includes")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 scripts/Kbuild.include | 17 ++++++++++++++---
 scripts/Makefile.lib   | 15 ++++++++++++---
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index ece44b73506..f07918b1819 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -114,8 +114,11 @@ cmd = @set -e; $(echo-cmd) $($(quiet)redirect) $(cmd_$(1))
 ifneq ($(KBUILD_NOCMDDEP),1)
 # Check if both commands are the same including their order. Result is empty
 # string if equal. User may override this check using make KBUILD_NOCMDDEP=1
-cmd-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(cmd_$@))), \
-                         $(subst $(space),$(space_escape),$(strip $(cmd_$1))))
+#
+# cmd_extra_<rule> is optional text compared and saved with the command, but
+# not passed to the shell. cmdflags_<target> is that text from the last build.
+cmd-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(cmd_$@) $(cmdflags_$@))), \
+                         $(subst $(space),$(space_escape),$(strip $(cmd_$1) $(cmd_extra_$1))))
 else
 cmd-check = $(if $(strip $(cmd_$@)),,1)
 endif
@@ -128,6 +131,10 @@ endif
 # (needed for the shell)
 make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
 
+# Record cmd_extra_<rule> for the next cmd-check without putting it on a
+# shell command line.
+cmd_savecmdflags = $(if $(cmd_extra_$(1)),$(file >$(dot-target).cmdflags,cmdflags_$@ := $(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_extra_$(1))))))
+
 # Find any prerequisites that are newer than target or that do not exist.
 # (This is not true for now; $? should contain any non-existent prerequisites,
 # but it does not work as expected when .SECONDARY is present. This seems a bug
@@ -145,15 +152,19 @@ if-changed-cond = $(newer-prereqs)$(cmd-check)$(check-FORCE)
 if_changed = $(if $(if-changed-cond),$(cmd_and_savecmd),@:)
 
 cmd_and_savecmd =                                                            \
+	$(cmd_prepare_$(1))$(cmd_savecmdflags)                               \
 	$(cmd);                                                              \
-	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd
+	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd;           \
+	$(if $(cmd_extra_$(1)),cat $(dot-target).cmdflags >> $(dot-target).cmd && rm -f $(dot-target).cmdflags;)
 
 # Execute the command and also postprocess generated .d dependencies file.
 if_changed_dep = $(if $(if-changed-cond),$(cmd_and_fixdep),@:)
 
 cmd_and_fixdep =                                                             \
+	$(cmd_prepare_$(1))$(cmd_savecmdflags)                               \
 	$(cmd);                                                              \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
+	$(if $(cmd_extra_$(1)),cat $(dot-target).cmdflags >> $(dot-target).cmd && rm -f $(dot-target).cmdflags;) \
 	rm -f $(depfile)
 
 # Usage: $(call if_changed_rule,foo)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 122c8e78204..0c0abbd19de 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -424,7 +424,7 @@ endif
 # minimize the diff between upstream DTs and U-Boot DTs.
 ifdef DEVICE_TREE_DEBUG
 cmd_dtc_diff = \
-	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtn-tmp) $< ; \
+	$(HOSTCC) -E @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtn-tmp) $< ; \
 	$(DTC) -s -O dts -o $@.clean.dts -b 0 \
 		-i $(dir $<) $(DTC_FLAGS) $(dtn-tmp) || \
 		(echo "Check $(shell pwd)/$< for errors" && false); \
@@ -448,7 +448,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	(cat $< > $(pre-tmp)); \
 	$(foreach f,$(subst $(quote),,$(dtsi_include_list) $(CONFIG_DEVICE_TREE_INCLUDES)), \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
-	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
+	$(HOSTCC) -E @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
 		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
@@ -477,6 +477,15 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) $(DT_TMP_SCHEMA) FOR
 
 pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
+dtc-flags-tmp = $(subst $(comma),_,$(dot-target).dtc.flags.tmp)
+
+# if_changed_dep compares cmd_extra_* but does not pass it to the shell.
+# The response file is written only after that check decides to rebuild.
+cmd_extra_dtb = $(dtc_cpp_flags) -I$(obj)
+cmd_prepare_dtb = $(file >$(dtc-flags-tmp),$(cmd_extra_dtb))
+
+cmd_extra_dtco = $(dtc_cpp_flags)
+cmd_prepare_dtco = $(file >$(dtc-flags-tmp),$(cmd_extra_dtco))
 
 # DTCO
 # ---------------------------------------------------------------------------
@@ -486,7 +495,7 @@ quiet_cmd_dtco = DTCO    $@
 # No generation of assembly file either
 # Modified for U-Boot
 cmd_dtco = mkdir -p $(dir ${dtc-tmp}) ; \
-	$(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
+	$(CPP) @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(DTC) -@ -O dtb -o $@ -b 0 \
 		-i $(dir $<) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
-- 
2.43.7

