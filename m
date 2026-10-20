Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619D606A322
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fMR7PmHw;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EPDSSkG3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2B616082D;
	Tue, 20 Oct 2026 14:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ksxB_-AbEyMN; Tue, 20 Oct 2026 14:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E984860885
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505429;
	b=fhD3wPzCo9TEKqe98ooCXs2R7C6vugMWSB7wrPpPAgsChxPJVkEe3x9SlzflaQCFClXJ
	 6CpG1s9O330mRFjJDlsf/Zz2TlyKAmqlSf6xUdfJ7Ta0yq/0Z3hBiquYJN/6IBS291TCD
	 ku/C0q4WACHpxcI1uYlB4pUgHNk+4hpUqjmQoWoMsu1SGOW/yf2G17cCBCMe45Bl5Q7ae
	 KopaZ4Si/1zmw+nxB7gvhI8ax7vAbAlfjkpTHIcSITGiw/Z7gIXUnOu1DbFxT4YOOqi18
	 FwSS9BfSXnSn6r4XdqVWwDTPiT+mpjpuaLr9Lo/IIR5UfdodR+UtdMvYbixh3AIxXrA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505429;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
	bh=+le8ai34Npp8uWVz90+f3ZhxNq69JkATqh7pL9IB36k=;
	b=EyJeHihBT1kv58kRokmIHcqfElK7LwF8osAFCsX+eXZsUTwJYtfpAJIxh43wnueXig7a
	 7iia3DQPLTYnu0eg9Kv//lCDtGWf6THrOcNDfxBDOxVvxYBBRHKhWTRBgU6ZDOJ8yqydH
	 oNZewqxEt/3FVM079yq+4m+Jd3KSGPVACHq5z8/7VR4tInCiX7OzGtLEenLpP/gzJHwBY
	 pmrpIOmdvAOJcwhP3oLHC6IWXDoqEyMDthl4Q3lssCMlWXMNRLUjcxh14KqQ47jauTsVa
	 e/5ziIoHvfqY64mirCgY48uiuWoC2DUt1/dwA6S8SfMOZWguFJEDMOZ12WX39/zRuMQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505429;
	bh=+le8ai34Npp8uWVz90+f3ZhxNq69JkATqh7pL9IB36k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fMR7PmHw/j1Q4VWnzmW39AkmgSQ0lRDtA6JN+vXymsjLijUZ4IgmKY6hfqOmo/j57
	 bobA2km2S9pzX3LsniuWe6js2k04ylY97mzFjjJWWNSKXMkU+5SwaKvk7B0Lk8ajgT
	 Ql0NlAYqzL7IIffGUVzfjZxoIto1M6ZX8QO+NoAxW68596VpZ9XE0mvB4RM990a+mN
	 V90uNq/+6lku/gGl2JiGCgbbG5Hd62t1vZvLT566yFe6maS5JMEW10pRW+nrtxeYI6
	 C3fadZx09mAEKmp4cmd73DUmR5WBIftYGRO+fwAiNd9mPfGWGyES5j2EBeU1SsYSbT
	 DtURUzVWnEVhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E984860885;
	Tue, 20 Oct 2026 14:10:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC943255
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA10240359
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pT7c14zoJgs1 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EB02D4034F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c005::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505427;
 b=n6iQW/DJ2rSxU0hyYvfJdscFOIoIuFU516R61Guc3poswmYdJ3cpJUuyDwvs6VZU7wPo
 yynEbN46W6P9ZTPtXa7NIyK4MSpzEqe8BK2ze3XjPdwXNLgpbnY8lCM4K1GAjIo2/Orgf
 OCudr02CRN775Tb2kgRs0687jMXlbCgvvxOZi8SFYj9wA5Cmw0syCTVzoMsHZWB38Gf5e
 36N/Y0M0wn1TQ7+hPyJzT/+75WJsa2B/wKU7EpOVqKS+tUuB+ttkbBArCy4b9Xn3hC7d9
 7/vKYN5BSAX99tBwLThb4QIYlNTAt4NEDWVgJAGPps92YCVKlz546e6HnCRtmvitYzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505427;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=+le8ai34Npp8uWVz90+f3ZhxNq69JkATqh7pL9IB36k=;
 b=er8F+6qL1p0Zni56w53FHciio4POR/+3n5EEyUb1N0M04RHCJxDyLdnOQcQT6wXxa7ok
 Nll3cHpahhnYMslaETtP2W72NJ+lxHe1AexxvaSjorRPZvxk58NgX4JQfIw/ToJ6wbHwm
 UO7jPpJ94E8cKbikwRYfA0MBID1FcYZgrDqMPvyCslyOT/lWJIZEi0LGmY2mesf2MKz+P
 b1nl++ABm6D8WNwZMvluO65GZ2nNncJL7irt8BebCm95YbGK84ie1ONJVN59f1GV5p0ZT
 sBeF0b/5hvAxOpjSyUVRNlcSdat0BzNkLRKwWq8Z77P56KGPODKJ2maQEd1BnVS+AZA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=EPDSSkG3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c005::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=EPDSSkG3
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EB02D4034F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TngAw/K0pLi9G9YEeW3tfSqzPKmM85rfFPyZInD/pR08dxbN6X+BhVYSiBOZwibvhJMrvVjnKUVNJAquV9eRGYjktho3c0LoI6dv/uPxaHdlB7deU7dBZe8DHIoFHko/4JQPbFxBKiUUS3oom+RwBLsYnwMPn1ASGsWHzU4HafOG1uoukqFY6VN5hLz6/3wqMWaQ3YYJcEDTmD6EeDemSIll8uqro1JDLSPk079+izE7kyVX1hq3+ivjhKQivVotcGQA2CY+np00kckAPzfIDO1mrEFv++pVPCL/w6YE2bWHJ4MCUwe3zEb2MGHMfzEbtbNuDZD1nt5T7kOqL0RVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+le8ai34Npp8uWVz90+f3ZhxNq69JkATqh7pL9IB36k=;
 b=LiP2Me8vrxi+MoCO/qfkB63ab8sxDAyfODoBteI1yOvXsQVEtcYzm+gFD1sobH3JYOha5vUqCBRAuq4hypqIxYexHn46I2VAPorzSfAXDYKLoGlA1cUAUufY5vjB3ohGQCcSsmxBDK27E20m/V9YuSX5YIJ5+O7eS2VXZV2IUN4raz75+eFDCHQneODPGmyFdI0rHc/pASm9oEhucU9ZJp5jGiA3rNlFv8BgReoCJ6WfpMyBHrBPtYaOTZMtQmuwIxHBCvjainWpIs6gY6I+i+vfPJCRD8oBmXgW/cWaJlOwAASfBjzHYblEly5zggJKukRrQap9UHuo3SsD7PlC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+le8ai34Npp8uWVz90+f3ZhxNq69JkATqh7pL9IB36k=;
 b=EPDSSkG3nFaKtKB09Z/y5HEDIxrWelJlCf2Cyplz+TSPZkNOx2/WlteLlPTRL3WmrRElTLkTLFNH9pFuNWrXw7/HmUbLd7VE4IqlZVbCwCd59Nt2HkHFdez6RYxQbvkdfOAO3po8JjOPzZIf6KVo22pk66L2/PpiDmqH04MmT0I=
Received: from SJ0PR13CA0153.namprd13.prod.outlook.com (2603:10b6:a03:2c7::8)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:10:19 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::f) by SJ0PR13CA0153.outlook.office365.com
 (2603:10b6:a03:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 14:10:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 14:10:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:10 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:10:09 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/11] xilinx: mbv: Add sys prompt for mbv32 and mbv64
Date: Tue, 20 Oct 2026 16:09:30 +0200
Message-ID: <24575864503b93a808a5ac1e90bcd8ad0993539b.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=OuOzB+84xpLX+Lv73jTItYvy4UxczFjnblyzrQWPjzw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL5MXX3G4IlItJezZY3/ztEsONuoZipFOjGUM2U89O
 b6fkT7VUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABPJS2H4H1/01PFliPIfNq8W
 llPN+q5GJpNzM1snmSy9dzlqRvsVS0aGN4Fe0Xa/dm1aEHc6VOvHj+ULt+7UjbnrXP5h2vbj3ud
 EeQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: d122018d-1a3f-4981-3f80-08df2eb3df4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|11063799006|261009223027099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: L5noUJNoS6e7dLk+3Vw223VDPaAKj/qJQGuDvMtjIkgsHXG62jg+/tHoKyCghTDp4aMqEcGqvqfkS5RxHLXCBd0jUhhNeXtFQr0cOdGfuJumt5FPK0+NisBu8wUgKE0cKRqeY1Is9CazGzzndFf2SfXafroZ5DapMbL5vc3QhVESKukNl3Q6JwrG4o9gVLfo4uEBDnLtDiMR90ENIYtTGi8rT+XS/0sP0sK3Umzf0NzrxFfHVrP7bC3aoeEq/deHi3ApGi42IJOsMJkDByHlHkr4xbHWyX7WcvPq/d63lCW1ndvDqHgtsgrf8D69ZwN7Y7pFRJa00WL7J/OnU2wv16N8EtbWMYRKXuqFyMGoq/QQV898riAnM3i6FOI/0CzgoflMtOhcfVFp2kDH5JgJbkz+lTEMvD/pSe3dQ9U/RAkb0yjXyd0iENVa1UeunXXc3V3F42gPnu009QRC+2/deGl8DnGYZAeMdll0dmxfjuYOfbseRFChjfUs6d0vNgUQlhvPnuPLlGA6c0J0dTFSI0FfpgHBq5cT1eNXT8MOpiTpcZOD5LZOaIT7SIuLEXBOtCyz1KwLtQLxt4tUYI+km8HGM7tp73LPGwiOK8u/WwFh8EErW59GshHs7AaSVH+fWNmYiyrxRMlSgVWo8rUDTS0xaXz3sbEzRPAxnPrXqiR/C1sEWJcXGB7h/ZfMIQ6FzoMJGaJ9qgzRoRDOeMNEIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(261009223027099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +eseppT1mONh0Ois6UUIW/7J8B55BgSXL0Sh/KJcxu3TzEWkL2KgdJclcpZKHXhUQr/e0CVXJZ5zpdAHawFg2g9yN5YKqLwt6amdWa2HAu3hR+g2rfdenwXOJgUUA7u6UcsnR0ib9SI/8qZGYKvamj3xXCJ7YhqB9qNsUPUc8DxR8s8+v4sGjzARDoilJOahFuMQYP/TzDNMy7WBzpfQZR0njf0imUmgNr8N4wE7VHbiRCWd5q7ZkQuaqKOS5vrdE6KZ8Y2699uaZ0uha66UK4DhXlSZTBZ06gxyjmmMc12ahq8diGhoR/TtjnVZSSWUvQuluZekEdfkzQZriFpxq6e64dgPvpGU5GAEJB3NYnR3lQhrGCFfEjTkN7huOPmi94zGoOp9enp4TNVcpAUbgojgHx+l4Mzttggx2j+Cs8QXGy+g/gDhCkwk7HH/MHm+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:10:18.9068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d122018d-1a3f-4981-3f80-08df2eb3df4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>

Define CONFIG_SYS_PROMPT for the mbv32 and mbv64 device so the
U-Boot prompt is consistent with other AMD devices.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 configs/xilinx_mbv64_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 258b65ceaa68..3543ff345f45 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -43,6 +43,7 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x8C000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_SPL_CPU is not set
 CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SYS_PROMPT="mbv32> "
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_SNTP=y
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index 27d674fc34fb..69ab269619d6 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -2,3 +2,4 @@
 
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
 CONFIG_ARCH_RV64I=y
+CONFIG_SYS_PROMPT="mbv64> "
-- 
2.43.0

