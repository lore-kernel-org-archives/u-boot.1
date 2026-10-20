Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5E606A32F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MFeh87Mo;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UP9p4Hnn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2BCA608F6;
	Tue, 20 Oct 2026 13:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id narqMbEA1KGp; Tue, 20 Oct 2026 13:54:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3399D608C7
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504445;
	b=oMwAB0NbLBXpKpmf/cDFgcpgSDCw7lQVpGdzNL0/qHYPur6nzg4xzLzVy+XRjEFGX9In
	 dAEwgrKOwQfvdQoGNvAkd5+U9rpNFbsLEJ/ixoleyrwhr3HoG/jFPirShs4mDPR9hSyWd
	 ESsTSCUNalaRNWlwrPGfTosV4EkXZXXmcaGth3a90dMTFRifA+Q1O/WLRsXRRLK6AM6S9
	 g1jKmZD/7QsWJ2fb2JQ6P/JCsqAIj32zvwEKDL4XC/y9J0gBsVpEJn2yj+sw9lqWHOlpB
	 eMECJtWmy7NGBxdnBrzzEAtkoNARK6SRFPcHw/+HsyfCDpb1+FHG5eMtiPyyo3yLfaw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504445;
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
	bh=t0T1i5ju2X7gv4aUd79kWeQPzzThQ92jKmGUKf6efCg=;
	b=LatIsy/1ipI4b4PwtVAhsTXEXs0xAWsTlrsY4bG89cX694YziXvABRMg6Y4+tCzvMV/0
	 0FYiKgla0OsPiiuJ4IDb/CnYdymQt82BGDjBIg+yGFX9PeTooIbAP3rMXjrrLBxVDI8zS
	 ereNYQiyya3JMj1jJ8inrZ4et374oQbf2IrM7KMfzXmQqyTnOEaXXkZ/WLXivozFAzJsc
	 eYEjPULnyP0lrUvhGhE9T3vnru5kZFVomjJIXANDA1CmGuYJr7yMeVXMMvA0hMmSmVAKq
	 CAslEfcDeLXZHhVbo8nmhcapFeiiMua3VkiJuF5DAmRtcknozM5FuV1twRCzCfef8cw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504445;
	bh=t0T1i5ju2X7gv4aUd79kWeQPzzThQ92jKmGUKf6efCg=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MFeh87MoAfAZtpDQ8cOH2vzXBlvAi1QwzUkrC2QmDbJnl8D6vMwyQW9BQ61RvDO9v
	 rs/94t0Y4793Q92Cqk3izQJw3OpQNlOrF/zV3Bp39sk3T9Bt0PdVYOuEmSZ2OD1xLx
	 7nXh7zVVN4R/Xjzhe/KDh1xDojnHLK92614bE6C+1tTybFwrXtzSJFgYvUaIHrWcpX
	 +IphELTvnOeIH4jeA0eog90c6x/yDt/YuSriGsL4eSjWEoj9lDj+Bn3FqQyn9wIR7f
	 trPdV3Pp8i94/nVsgZ84RA7Z9bkm7QdqSt8DWdVHrHJH3DMggZ8O6I1J7dBD+/413U
	 fxcpfecEciRjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3399D608C7;
	Tue, 20 Oct 2026 13:54:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F00B4769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E1BAA4034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I5caeF8W1plE for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:53:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0A2D240070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504437;
 b=andpTejTIK1hjUTncTUltzPawsUmGOOJ+4C9o9UgBiuBLDTMqZk2OmHJ0v8pJLFpcwpG
 E67c/PjPpSatcoFjSvGCywaiiG7cw06Sbq2uP4XxpNdPOMTYJMI7t1syqgjWbQUUG7N7r
 jGxWaCSgZMYdYPKJaz6sbeQ7tS6g5VnEIbe9qDyFqRuGCsnvllo4Eauvjy6Lscfjy2zrR
 5chpzylbsaRPCQeNF5SwgML+TOy3qwfl7QcWD3MUOxIfz/lMFYn7Wlzhk10bGwT4OzXrk
 gUnzadd09w96b8pXDZTaVPa7unsGgQtgmAsQXEGUWU4Z7mHeUYbGuJ7gGjqkjbortKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504437;
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
 bh=t0T1i5ju2X7gv4aUd79kWeQPzzThQ92jKmGUKf6efCg=;
 b=sKzpHwgRVJ8ufPdvu7vHqrgLgs0ASSz6E0AQFFW99krviGBri9ZT8zPRTO+x+NyovsUZ
 b2P2p4JmLuRohQbxjkyIqre7SrvXdee0GojZbmNEyuVMdaNPdhlt/zDWtsb1JDyc8heLA
 +4NAfR3knQnJDFQFDOX822JcwwbBD/g1SWxM/2PoG/19FoIp1DIFvBegvcit+jrqw7TYn
 KGEI/OxpSWb3d9yV/y+MtmMKQOZEm67KMktmQJT4JeW6eE2bbCLku0joLXrrXIJg2nnEX
 0CitzZKpyhtBayOLJhUahF5F61QKEROrkizzuy1KuJPbmgsKpnhMwN+YKPdha+e7Y4g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=UP9p4Hnn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=UP9p4Hnn
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A2D240070
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxKKfN8SmbCBuqbymlisUm9XVDnplYKcd7AvVgwZO2rxuZsIecfoP9kqxVKCX+CGKH4uAc8c7d52VknfCk7/9Gfkpy2Uu09wxCiLtp+5llTs/WwOsrecWrwOgqU+XXZvgjGJqWEFW3QwS9b3IDSqLNQ+/5oB3SL4OQXnZRBtR3waN69G1GNpkGhlG6nA+3YJQY+qRCsLLkZX7k0TTs5Gl+Na4uCs+GNugyq+k0WSjN3JMtH1PQ35iL87tawOgRUr64T4rN1pmF2W+H+LAzwSubtuLu/QyEfkao2NRIpeJSR6Kq0eD+GgWWAAKw2IEtZVkZZgl5FCNlRXMR5PAxFqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0T1i5ju2X7gv4aUd79kWeQPzzThQ92jKmGUKf6efCg=;
 b=XOjzVbrnQcDxUrUGGELD7w3IJLDWn3oMHQEsoeqWIdeD92vP6l63wzLx85UBJAXUd+/Eleq5ezuTANTI7lHE2EnCAMIQxIWLc5bQGBX5tUiPQSHN3EgPKPKhwLgGHmH94tT54ZoAj/+0eEcQ/vH3XF0oTmK0wO+fNxkG9JZkFyKnvSjhTMK1XH/FWeowGUK8BpbPhRXcUKt77mAbFx9E3D5ghMxVfuGnR2+v7N/s0DAdjXSkqlDfE82pis6MEMeNvlj+22CtSgwuRrIbk9H2GVAky5ttoupEtxRN4GFM2Nsmz+gmVnx+B8vKVsa+h59acrFOnoz8HoI4oB42gx0nCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0T1i5ju2X7gv4aUd79kWeQPzzThQ92jKmGUKf6efCg=;
 b=UP9p4HnnifULYNdZo4fD8qjFCHp/jZAG/JbUy2C758qzE7kDF8CDulRt+OVCYfsf+8kEik4SEINx/6X6ePhg2KAPdV7J71H4EdwBzr1WXo0eRxBxssnWsXRvjycYLaV8RYpQHQKguUd7oe2ZqQkvNpjK/e/q8w2ErdtHwyE0Ahc=
Received: from MN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:208:52d::32)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:53:52 +0000
Received: from IA0PEPF0000003C.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::34) by MN0PR04CA0021.outlook.office365.com
 (2603:10b6:208:52d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 13:53:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003C.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:53:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:53:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:53:49 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:53:49 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] configs: versal: Skip relocation for mini OSPI
Date: Tue, 20 Oct 2026 15:53:39 +0200
Message-ID: <21c97d8831b6b7dd13f7869a5da1588749f68047.1792504417.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3410; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BOTeCQsrg0nvj99n/nnz+Zlz1BicPt1ECkaGB75v6fo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL8qyOP9W5f2SPKvp0lPsbus57/O322jRLTFBjkGlT
 GzRTSbDjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjI/BuMDL93H5gmv/xd3QXL
 vytPHFUQv+Lu6R6Z9rElLpTpjenkDAGGf/bihnETdf/eeM+zbtu03VoSSy9eKK/MMJbJrzy+v/x
 SIBsA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003C:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: ab323eee-f2f6-4852-21ff-08df2eb19270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: gWrlRY/MUd+y3aEB24hiHPceMF8mQtbWrRhvcAC6L28zDCCl6PBLe6mshS383iFWoglIvBm8+XYRWhE5fLGrkYUe7vOv/7BNWR2zWOjj6t7fsTAdsQt6XkeRErSmMlRV7qt1SRDe662O9UmGweONtmcm/EKuhTdeuV3NsEgx7fURBKmTYdvGa0Nxi6gaOOYRQtsYCplFjM2YiSnCGk1d3wMYUdnRhTHfxEcmYXcNVqVaG2g6CQyizNrLQAk2hDIPwFcCVOpWm1InNAxnh5KLSU2Ngxg60WB+haj9z2KKkl1maFYk5qCoaQwbpK9tyyfWXPx50+ID7O1IrSMadZpTnilLnKGXFikUsQhrWMp6LscOMf5/lYcCQpTB9p7AhBoCL0LsDtCRKcHokHL8e18mDj1G+RPSs+8r/YzXYw0bJhXXFDUfjkFY1pGlrVKMUGgkpGeDnZqXwQX3QwAOxYWHhM7OyWr8eQB82ZvcbWzWnsf4ti6KFxvVMmJPZdY5s1s4ij+HIZXp1aOXnhclIlwkd4EAvgnIA/hD+rz7BTuSo2tOgdChWCAMn1szoROTbcmq9upv4OnK5u+fClC9BcMtdg8uD9D1PzFl46puTaaAl4AI/II0uzJpXFoft3k0tbcbJ3jMCkh3YPBO5sEKAsvtVQ8CGnuKvJzyvs5CSyVzUCNXMK8bx1IGcEX2GWcy/8yuZCKshC8YNae2dIdGWQOxMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MmTB+FOOifS7l7WLAEKcRjottbHTqg4jGCI8//CbdKlfol7kT6VRL+uNeLrn/LfOVzkZiCiJ+AzQf3eX7ChHiNEM3YFu13Z4A5TgsJJ4z/IS69xAO+Mvez7tMmce3NKfdbH62tm+6ss6Snfw45z/mQjwzehLOIZZqzNpoa3J/ZicXjZR3e8dO6Eou/9dtniPBJFrDmb7aHaz9Nbtx7nK+T2qvaaz7mrBHHvW/8Eq15kwYkX4lOlC7CxakkEfh6Ei6lCC13hKAA3FVSgDYR7dOu8Dy9RpwU5fujhmwKb0+tpg7s+kCb0L0SzjA7V0tuYaZjSbTd4Ydsd9dEoWk/iGTIuZ8ET88nvVU6z0IozG7oIyrrG79czsqKUpEduCne6WuFF6Bqs2w0SOxEEjiAdYNf2nj0zH8afimAFe+RsYYmPyAiTODYvRjjYsOACDs9/t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:53:51.0351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab323eee-f2f6-4852-21ff-08df2eb19270
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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

From: Padmarao Begari <padmarao.begari@amd.com>

The mini OSPI image runs from OCM, so relocation only copies it from
one end of OCM to the other and both copies must fit at once. Enable
SKIP_RELOCATE and move TEXT_BASE from 0xFFFC0000 to 0xFFFE0000, so
the image is linked into the top 128KB and runs where it is loaded.
Set BOARD_SIZE_LIMIT to 131072(128KB) so the build fails if the image
outgrows that window.

With SKIP_RELOCATE the image is not relocated, but U-Boot still places
malloc, bd_info, gd, the device tree copy and the stack below the top
of RAM, which is now where the image is. The top of RAM cannot be
lowered from the board code because it is compiled out under
CONFIG_XILINX_MINI. Set SYS_MEM_TOP_HIDE to 0x20000(128KB) so the top
of RAM ends at TEXT_BASE and all of them land below the image.

Set CUSTOM_SYS_INIT_SP_ADDR to 0xFFFD8000, so the early stack and
the early malloc arena placed below it are below the image too.
SKIP_RELOCATE is behind EXPERT, so enable that.

Example memory map, the sizes depend on the build:

  Address      Region                             Size
  -----------  --------------------------------  ------
  0x100000000  top of OCM
  0xFFFFD800   free, under BOARD_SIZE_LIMIT      0x2800
  0xFFFFC330   DTB appended by OF_SEPARATE       0x14D0
  0xFFFF95A0   .rela.dyn, not applied            0x2D90
  0xFFFF8460   .bss                              0x1140
  0xFFFF7A38   .data                              0xA28
  0xFFFF2E40   .rodata                           0x4BF8
  0xFFFE0000   .text, at TEXT_BASE              0x12E40
  0xFFFDCB00   malloc                            0x3500
  0xFFFDCA80   bd_info                             0x80
  0xFFFDC940   gd                                 0x140
  0xFFFDB460   device tree copy                  0x14E0
  0xFFFC0000   stack, grows down from 0xFFFDB450 0x1B450

The early stack and the early malloc arena sit inside the stack area.
Both are free once the driver model is rebound against the main
malloc arena.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_versal_mini_ospi_defconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
index e116b0cc1bcb..7c0b14fac361 100644
--- a/configs/xilinx_versal_mini_ospi_defconfig
+++ b/configs/xilinx_versal_mini_ospi_defconfig
@@ -2,12 +2,12 @@ CONFIG_ARM=y
 CONFIG_SYS_CONFIG_NAME="xilinx_versal_mini"
 CONFIG_COUNTER_FREQUENCY=100000000
 CONFIG_ARCH_VERSAL=y
-CONFIG_TEXT_BASE=0xFFFC0000
+CONFIG_TEXT_BASE=0xFFFE0000
 CONFIG_SYS_MALLOC_LEN=0x3000
 CONFIG_SYS_MALLOC_F_LEN=0x500
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE2000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFD8000
 CONFIG_SF_DEFAULT_SPEED=30000000
 CONFIG_ENV_SIZE=0x80
 # CONFIG_DM_GPIO is not set
@@ -17,9 +17,12 @@ CONFIG_XILINX_MINI=y
 CONFIG_SYS_MEM_RSVD_FOR_MMU=y
 CONFIG_VERSAL_NO_DDR=y
 # CONFIG_PSCI_RESET is not set
+CONFIG_SYS_MEM_TOP_HIDE=0x20000
 CONFIG_LTO=y
-# CONFIG_EXPERT is not set
+CONFIG_SKIP_RELOCATE=y
 CONFIG_REMAKE_ELF=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=131072
 # CONFIG_AUTOBOOT is not set
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
---

-- 
2.43.0

