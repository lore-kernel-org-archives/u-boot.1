Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CAACC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 04:19:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A826A406E3;
	Wed, 14 Oct 2026 04:19:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IGlVJVwp6vE7; Wed, 14 Oct 2026 04:19:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D5E77406E1
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791951557;
	b=G6ztDWnK+JwJX6qNE+rcF9chCYLBlq0o23sK/uDp2/vTI4UvZpqafAeqyXL12k1Sx+gD
	 5zUbrdSiDCi32Kp0/ax2qUe6THdpJLKMmqQIaOO+PoBA2ZMkkc9Nlb+24UuxS9yz6sy9H
	 mfjeNAH/dQNoRyt0z61waZzr4GF8AtWwBPjllLinZbIIOVEKVN+waVoFkrTGVYsxjJfeT
	 zOcjAIi5Wg9OYvzukwOyKz7XKxmQsG8v90Xcfh0jsx7wFG0ab8yk4QqM7k0T8NLgsVQw9
	 fkSRLnOTcBPnJg7/G3AkxTtOa0Snr4ne/BRQuZvHtRoJEVvuDoRSt7iJJP3N8wawSUg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791951557;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received:Received:DKIM-Signature:
	 Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NqdvfpdxXS2YuhPtJaPGF4BC8HAQf9iDV0ts7DRj15g=;
	b=R05U8TeOs5CRvnPwddds2cnTOkVbmw1uDCySHdDR7jgWTP/A0SmgntkYl11EOZ5Dbzyf
	 iELbCEbOJX0EbZzlJXa/5MtLfG1zw32z3QBG2Kfct8Zi9x5pwM3fU6yzMej6cyAPriMkq
	 Y4/u5Se1zufWC3R6u5lVY1FjGHWoSnTuyMYn7dtVrnovqGY8stYDqyh9WGBHHEbr4UBlW
	 mFGq8bnxPmEGUYkqGH8gENGT/2athYzgyvIYWACrKEi1/aBhdmhLuKMhkcN/2lv6VXow0
	 MsyKw1Nukl9TYh1AipMTQt6odoetRTz5x/ybVfzWrHzp7R52PPy2FE8sW/jUG32FGNA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=UxSHf6qq;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=f+otF98q;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791951557;
	bh=NqdvfpdxXS2YuhPtJaPGF4BC8HAQf9iDV0ts7DRj15g=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pnac1pHlwe2tGuCdvNrkO5E0gKzD2jmOiCjXcLxj7LHTdr3o59gyDD9WoPL/SaiFI
	 uX5f49NAkXnC/s92l7zNeLXIIJ6QKZ4xTikI8RM6N7dkJdj3vWgMQJbs6acp6KnrB1
	 biTGYSU8HgVY3hoscI8Cc6ngLnA1xisHcP7YWVWQcFesHZq0FIARWN1LpE5S/fKeFa
	 zDPYQswciMOx7xAVGi9WQBWm9XnPz9lhpzZw0/TBtWZrxWx9RloLoAHXI+YIPxpCGL
	 pcDbW7T1S8j8SvWqBCYzp1GE4D8p9Ua89WIIdaqw9WFGBqmEjwBaH6MVsSJ0L/PFwo
	 2yHlPqGniuWuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D5E77406E1;
	Wed, 14 Oct 2026 04:19:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CECFA2E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3FE8406E1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OON9IHo6Kr7 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 04:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 108D8406B0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791951547;
 b=PrM2aBu3n2ZpTvMI2jezYPb+mfezSktlrJwOWWBtg5FZWKgUuttbX4evtHD4mP2QDU9K
 /N04iXWVnzGOwKmSw2SoxgSql/B/1YtY8wlHv5IS9H3QBJYnDtK9w7Pe0GRz6aosU0JzT
 T2v+AOw6hkuqbbHeyU1P9c5Uu2wulYSZWObdDHqkB5cmPxXeMyiYIWU5A5c5aHDLcHIsD
 YkMQBAxFjpnbHanFGnl3NeiQBrKD8ubP+z6WY0MprCPgc7GFTWTNVmZFrmzUBWepmdHZD
 eMNDj5hJzxQUe9ahC5yDC/IvfElEj191KmFEPCkubBVmJsMiO8Ggxjxsp7NMevApGjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791951547;
 h=Received:DKIM-Signature:Received:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=NqdvfpdxXS2YuhPtJaPGF4BC8HAQf9iDV0ts7DRj15g=;
 b=aZVop7JZKZp/r11ba9lVbLUJhz5fhhSFnGCuA/79H3Jyyp8K5TYR+OnanCDOMtyJ6lgA
 yKF2tg32EEH51BFy+wDN0O8k2/rfD67oqgitJaA2P5/iynJTHW5wkAeUDSPSTXiEF36f1
 L//8obiZUfFM9aX0IVmbQERn1b2HX2lCUT2zvRa1hBL2MAREwQyYilOG2xaXTg3g/CENm
 c4/Zz8ViTSQUH43vIr62B8vigy1vzG7n6SpAvFqlP3PcK84lC31RYyYJqipke8uSgRxQb
 RjhyK3a39Ad+xW5THE1Gn+EzqOkCL4AKk//daFS6vn71iQYOUpAXHzNv9mw3CJUuhkQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=UxSHf6qq; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=f+otF98q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 108D8406B0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:14:00 +0000 (UTC)
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=UxSHf6qq; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=f+otF98q
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E1Me4U1773246; Tue, 13 Oct 2026 23:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=NqdvfpdxXS2Yu
 hPtJaPGF4BC8HAQf9iDV0ts7DRj15g=; b=UxSHf6qq/JyZFthJQaSFUxha+TymM
 vixqqwgaq+YIOo6O2XMKmS1RYGUv9JAxdsRcC0lFLDiOAW3OiHqAHgj/0h9KbE7C
 5Kz9Q9pXouM8Q/D0/iywNTfCldQa5otqrjqjU1EmfLj2vAGhphOSc/ttwCwpezQ9
 g/7bPpk91sgWU6ILs/EcHVQnC6l3F+B11ppXakv1ibucPIGFAhTAWOBYpaJbkmXf
 nGgZCp/YZJQ7keOdhrnCwveb617PFpC5KPcXhYiPVBJ4xRyaJ4UKoE6WN0bnHulB
 9yjblg2VI0kfAXFYPkpF8futz6Cykghp8Me8wit8TO7upZZT50YBThGaw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ha017gu63-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 13 Oct 2026 23:13:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elDaPk1Xp0tQc/o/vOA416v32xgo0Kiq9LUjAe16BFQX70y5OeQLoDq1RroE8gXjEUIAjTHaETzQRu0SWSN7rLq9RLhGVajYVTXrTsuT8tMxFDRNaALhIsh9BsnSO8dWzXGPJj0bwaWgDFSGJHnkWh/3btfB3eLMRMr/tYAb3jUAsypmIWG3IQYZ99xVx1j8OI8Zkg5knzfYzKsPzShn7IaiAA+Say/V5BdahxfRThBrNfHh92Z76AVVdnUG0Sh2gG6TaGZYj49JeVp3ZJBR1K3seKKy/0iZCDDGixlunIGzZcL0eaghH/dGb6ABjd6eHXU98BdQyJBABxw5KVSsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqdvfpdxXS2YuhPtJaPGF4BC8HAQf9iDV0ts7DRj15g=;
 b=P4Xzg4ObDa3bavrQ5XcLtFBcjWnIzBc2TOmJ1+nfM/897esPVzQt3FLcEbDgRL8dd56a0OA3e/sqpUVgbJMGacsFgBsEMDeBrQrk2t0NEWe5h6VSWZH/+bOexAhg68MRqlmZV6LlctAZVC71dCDMM61uqKW41/e9h+nr4XUgGNeh+pztpd17aHhr0EAquqVfcipODLXitxGxtYml5x3hQv2s2wWObncPA8Di9rpGS5pU/a2xoa0dlG8Amh+LiN8Ad+249doqRan3aVFxKVaHVv0OywgHXZWwcV3IIXry8P72d2lGlxBVifcdg3ankxHKgRlYnhKkpb1dhzWW7rW6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqdvfpdxXS2YuhPtJaPGF4BC8HAQf9iDV0ts7DRj15g=;
 b=f+otF98qiaLdEDAYFx7TLX0ANAEocV5Ee0Xbx6V59vsnLU08mxn8KEaOUHHuXbZ7jp5AVWwxyMejL/YEQX5lUOWtOR5hTfgTjx8t9fvmC9/to5hpKjm4lRVc27Zz4C1iofpJhlL5pA0TO36TKC2TOmAMlZNNuhsbtihXpwE0+pM=
Received: from BL1P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::6)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 14 Oct
 2026 04:13:54 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:208:2c7:cafe::aa) by BL1P222CA0001.outlook.office365.com
 (2603:10b6:208:2c7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 04:13:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 04:13:52 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 23:13:14 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 13 Oct
 2026 23:13:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 13 Oct 2026 23:13:14 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69E4DCDA1545636;
 Tue, 13 Oct 2026 23:13:13 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>
CC: <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] mtd: HBMC-AM654: Increase calibration count
Date: Wed, 14 Oct 2026 09:43:07 +0530
Message-ID: <20261014041307.2016965-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|CH0PR10MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: cf57bbc6-d069-4e75-c379-08df29a98ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|56012099006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: JRhkoa4TcvHThSIh0VZKd7bEtRtl2VisBSfzOdU+SBYZ8ZS+ZEr+9gD5eld2mgd7THii/3Pw2UauT1am6slFW3L5/S4FUcMT5hLsZueO3Y91CXdS8W1Ax3M76d26lmt+rrpB/f/3/b2h1ETCZgcifI/X7U0ilxxU9/RoN5YvLZoyn224CWVtEXL1ESRobr0nalfYXKIVD1KQBwEe+aIOkPXM+ulDxr7YE6v7Vma0QAfutcHWcvVKPxRm1zlOh0YUiY7ye85r1kUGEXSoxLxwt/BR7nhvcWyKgHC5/jYTd13j7Ywahtu4i6L69MN86B09h5RTau1pTWOm4+S7hqW/IPa1MMs+J/PW0zFgkzQ95+TMYCd93LaAiAm4+zshBGGrzDkQaQr/5470LuDj42iZv7H5+BFMYH3CkYqnUX9ZCFLW1T+9XE2qb8aqU7XJxeeVMwAcUPIA2jxdgz2QA+ONK0rWrqB6M+oOnh2IjnBVrDVKX+wmtn4vBGuLw/2lpYR32Kiml7yse6dFTqhGEUsEQYcXaH3WzbKpPJvcTXyrdYq4wCntLylzGwkmUxljRhkWTi+WZ5XJ9vSYZFtDd45oWVB+h0CtNDzPBg/7OOjqoHikjZPb7fJpu9agRDXxdU3wrGHhZ88AgIKh11QkhyIVgWzvdJ9KN3ZISU6TX1/SV7tCe4zrLR4o4LMecN+7Y7yL6gMzxt9ho8wVHBDrSeotOA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iwijLWZ1GD0Ccljxe3njwvSgdan4DB9pChrWYcjOcQlPwUlDLaNGXJ7MZx4PHpzLe6WR4l2uAiwwsKoKjmrsjvFalIpDNm1zIUuFQt1Ji++4BOGiMFg0svbaHYkppmmAo2Dh/wXJEaWcp+YwG8n39MVqFIJdrs3f3U2/d0pUK3txhZXcWxa11cVsibGXy9c7cT3Mzz3lvaAt82/Y9BHn779+vuRITNOv//A626iDUHLPGWnp8bRLl2N3f+P0C+qVQ6z12faJ0/0sBr7BOvGs8PxIsYNaIMFas3EaAOXn7D3QV6SoZL0d0JkNMyl6chT72hOCnnJhHLuZ0nfVVxlqhGcSu35l4iQfEgUvH/1xzbRh+6RziXlODL3ijO5cCJzPlDwEK3b4JSYnUj+qGttM31EyG8j8v4UlDK7+QeN5QlEQ3pHWtB6kN+smA8X+VbhP
X-Exchange-RoutingPolicyChecked: OSCD4JRWtfmK64hn6BRrWRFQ6tUHNBIgrnaUQrlrP7OuUrzPouWRveA9lmLyhJumtLMG3RphD/WpBXFpXOneqeooP1hSrSa1tmtFiswCZICr0rDwZ3HJ5VJ4euDOk3aUIQBblKknDXE0pP7euO1YkJnBpWb8mJx0eea8dCjMHcpwqs7YD/Ug9ihWO+QaVnvcEm0UPHuRu6Qpy16QAZRq5MRnPTftmHLNj5xgGhoZLJtOF2wB+dPeijxUAiI89zl+UgN6T159vl4fVEic5+uYkvbIB9mMx+HtWPW52fYJhFjoKFIqY3E/s4fqZE/rNRvvi+VLZyZJqJbL5dN5jyFDXA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 04:13:52.7981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf57bbc6-d069-4e75-c379-08df29a98ea3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX7ZbO1o2Swsyg
 +n6KoaJnHY4ltqCiL7S6WPrjWqAzUecee2pyniYpUBLvLLGJEvcKmQtR0BPChQV6mBk5K9Z6cSC
 r9aO64zs/8X0ZngAR9kKD4u3o//y0b4PaHKLozYQW9xc3e8BnqRwC/qbBcbKlB4vIbmyAtMbFtt
 bGp/qJF1Ddmz/uo9UIPmt3NYny8yhL9QPrRqHIwv2c4kVgypGMpr9mh8LhImLOKxykQFWfF+vHR
 CdlzPzlvdBqWhu/xIL1/Gd7W056Q+s4+9mp/9DECeLL3EPuJ/FJKpc0BfbZdUlGh+37Y9fsKk6P
 AKYYXyLmB28taVXGE162C8oOGFTd1SlA9hC6nBaZC3tmhHxwtEXqwIOW9wdSgDUtRxEF2t1I4/v
 +qezxzTxabYgmusywgYiWNAbX3bpuceZRLUWlzQ4sAhjCVFf/Uavra8WtOEjiO5UjBWux0y9pOt
 IbrYKAfjzNTlb6LN4kw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX9VBw9CZXX9Lh
 m0rFPjmbpxjTHebKEUFhzqJloA+X+bf/SHWa4lY9Ae+E0FA8Nb3J9ZXFJxksDHqLggh/zKnLyes
 GOvpx0Wiy5J2H1fBwc65afsy7Av6SSk=
X-Proofpoint-GUID: y89XqLZVUlPWrNk9HU08XUWqSj8YWHz2
X-Proofpoint-ORIG-GUID: y89XqLZVUlPWrNk9HU08XUWqSj8YWHz2
X-Authority-Analysis: v=2.4 cv=JdkpPkKV c=1 sm=1 tr=0 ts=6acf0186 cx=c_pps
 a=IN6nX5sQGDwae/9PVKyrlQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=mUxYDsGzSiYCVNfhPAkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140016
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

Increase calibration count to achieve better reliability when booting
from hyperflash

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/mtd/hbmc-am654.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/hbmc-am654.c b/drivers/mtd/hbmc-am654.c
index 98988a8e24d..5ad0d561fe3 100644
--- a/drivers/mtd/hbmc-am654.c
+++ b/drivers/mtd/hbmc-am654.c
@@ -11,7 +11,7 @@
 
 #define FSS_SYSC_REG	0x4
 
-#define HYPERBUS_CALIB_COUNT 25
+#define HYPERBUS_CALIB_COUNT 100
 
 struct am654_hbmc_priv {
 	void __iomem *mmiobase;
-- 
2.34.1

