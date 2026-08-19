Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B5DC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAFAA6069B;
	Wed, 19 Aug 2026 13:42:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UIb1P9X2AyMq; Wed, 19 Aug 2026 13:42:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787146922;
	bh=NkG1oQcaAECW+Jxy8E4kGL4zoB8dvm4yLuZHhcKjAic=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h+kZRK6fP7eLPE20n0j2LOL+uBJRIBxU2BybA+IpKTAkBLnrgsFmuiZA1fGrB2HAM
	 0dKFx5+HwfY5F2Z4/jC9BJ7Dj4pAFnQYqgoblUGoWyWcS5l3hulf3IQz6Mg4KzfUEY
	 WxTPg2JyWVCVKqVNoWB0Iy24CZsUsC/U/zdyjmq3f8Na0+o9R9IK0sFq1622aWGGSO
	 icgKShsyHqfOgqfxZJicj/H9D441PPzJfhYWVT/acy+5BN0ArsP3N2bnQlNZcA3fTj
	 3GOGOY1Bmt5H4Fg65mjJUwkm3+l4h+6T0vB/bvVYb89RZE+zgpA5+RUNN/tATtSM5w
	 OpOUiGLt3fO5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED3326069C;
	Wed, 19 Aug 2026 13:42:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF7413AC
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC5F6405CB
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9AOvhfSshwe for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 10:16:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=XkldpFLH; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=pq2EJcrg
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8A3A3405BE
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:16:48 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67JA6EEw1816049;
 Wed, 19 Aug 2026 05:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=NkG1oQcaAECW+Jxy8E4kGL4zoB8dvm4yLuZHhcKjA
 ic=; b=XkldpFLH8U4ZnCaNLN9JYDwtJrsAHHhPqW1uq3AfESubA+0FHFZ/BwB0b
 0R/Qtr866NNyfWAOFrVmDZLOvy5uf63EYsNPMXxJsJNCJm1bQ+MaBGr+/nET6V8H
 qpujJQxp9w0phlztnRJTFOzrzBv8MjkE3FaYAGkQRfbl0MHfJ5leNcWh0i/K87ym
 jHyWp/gFVYpRFRst+lva4pPhAFF07ylVndadI6w4Omm3LWLTTJVh4nQvVf1Y49NP
 24qqrqn+QeM1SNlD11je84/TeQ0bIH8IuPH/QbRyU2N5k5WMpRS8YBRf2V/0ir6h
 pFVlyKCPQtn5SGUNd13k/rjYBj8gg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g4yemkt0x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 05:16:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsjdtLi9lKC1bYBpLKz1fe208VY6VDlEsHSNJ60PFUR9h1JL1C26Zp78Z+OeQ+sCG0GuzYnD6C1iM3mvOS+/SlEA+CDzCfWMHTKChxXXgsH3gHYLj1d9KMXKI7KTRBbKaeUDa//wu/F7Q8cdiYRvtJnjEAYqagUhkQKtHoTU/1r/75wOG7+j6ANfIbENYdOvuPxs5SyaJqWhbfIXF9nuWg2iaVB3bHGv52CM0OJOtL+nwO/IIjyHMH/wqm09sjV+p5U/nfDdTN2m9GWyVv0yGDGWOn6gVxnR0eMOSNd6F4RRTZWsyNH/ufGs4ZK9kStmlDtH2+FJ2IZa7HowkBHz5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkG1oQcaAECW+Jxy8E4kGL4zoB8dvm4yLuZHhcKjAic=;
 b=oI+ox0JOm84TWufYIrYAmQ29E1ELvbh6YJctzoiYfreqkMy8mhUyBCrv//bMza+ADtwIX5i33w0L6JIymIub+RIj1LWAsz/5KNQrqaoJkn41UcU1R+OoyXbxg5lc5d6GSKEW2GaAsmEWtc0RovKBwyw5DOag0ZbFzwlBxS+q2d6/Ft7b7RzAJpTVseiUvN1z8EKiFnVgqBCi+iMjCSItihy73xwTBG2GYS76qNsB3pGluJO1dJ7sw4/pR1xaF/Q0E7u9aihGMI4pk8KzD/BxrPhOUfYchfiXFaNaak1XMeYjPvWu2wOuhtR7zx785orMtbonSIGju7c0+ldrIJwLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkG1oQcaAECW+Jxy8E4kGL4zoB8dvm4yLuZHhcKjAic=;
 b=pq2EJcrgDlr6mapWswk3vFHXVZ/XSG4OTl3djxWGdDBC5UGwPEyYglb13Cdta91p32IWag9KryfhL1Y7MYBhW/QwmVbo4toJvEroGozB2JTJ1LMlenbAukliTvJnyRdXq39oTKI+NkH0q5e5l5wXiIg74wr/CGWiwRSzGjuOqwo=
Received: from MW4PR04CA0221.namprd04.prod.outlook.com (2603:10b6:303:87::16)
 by CY5PR10MB6143.namprd10.prod.outlook.com (2603:10b6:930:35::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:16:44 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::92) by MW4PR04CA0221.outlook.office365.com
 (2603:10b6:303:87::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Wed, 19
 Aug 2026 10:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 10:16:43 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:16:42 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 05:16:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 05:16:42 -0500
Received: from [10.24.53.154]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.154])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67JAGeDU3188149;
 Wed, 19 Aug 2026 05:16:41 -0500
Message-ID: <de9b418d-7ba6-45c6-b94f-fcdd0fa810ef@ti.com>
Date: Wed, 19 Aug 2026 15:46:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] No-SPL Boot Support
To: Tom Rini <trini@konsulko.com>
CC: <n-francis@ti.com>, <u-boot@lists.u-boot-project.org>
References: <20260818115322.101705-1-g-praveen@ti.com>
 <20260818204129.GD523975@bill-the-cat>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260818204129.GD523975@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CY5PR10MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a92ca0-1930-4580-66ae-08defddaf793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: SFgZOsUTvExR/wKa60ZhGiTRMpwUwmbGWJG58YhVk18p7mHy0CXoJnE7LZLL9HhiA7t4h3q2yQBGeIR9LyNRsO0QZZqt+J0dALrBjOXj3wVGmCTUaxS4EEwMrpkmXQ4Vk6fxRbZ2MBUUXto4HCtCglcHSRMgTXTib3/VmWwQuECwaHii/plFgOI44KJSt8MHtDDB0kHDrbISEnVLqxOKPyc2Dje+M4duVQRGevM+J9dxGTHm6cJyhZs5onyswFjwWqNeGcYH8STkCmrcgOOQjc9a7dJFsygPiH6a40FZZ+iU2h0vfxJgbDLO1Oc+h3ZkuqwIbYpsOqIineZiKZHMLM5gqIoenVTadt670bdj0tMxksJDbMyzpwgr2yRJopQmnVyejgldf3fcLQq5iTkVNqvbJ1uURt/HEOe1uwBz5rjXIzpcSrp0+FxMHS4zoayYv36pI2t4NdIGKc8pOf7T8xaY9NLEEoa6iumb83oK5tvY8or87CwVcS+jIy7rwfcydS4EkOjEw5bTWyqDdO9NQoBce/dGWR0lT4GrBCkFsrAYSyfh4Hqy1geQIjBxnakPaXqqf+vdmTcA1fZ/wv5gk30VCTDrx8K6iuYoUyF+2IuXQGHJ2tu7BgrOIdGFPvudj9EPi0iq/wZcJDn0nZy81FCLfo0vKBlb4V7QyaANg2auAA1vtA6QXgcA4BYR8pOsITwRcFQQoirxVxo942rGKA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 22/bo8PV7nQ7Gng85hvg+LamxMohA74bJ1rFeJUNi7t+9B7ugHoO05FWAsxLE80WdnX1KHdtN3kVHu11/ziMekBtAnAenQCpLreMHtLir1PT5AVJF9pfSfnQd8kTlcTY5nvzwaXXXBXVL5rv1F3aGRvnF3c2kF9i0wBzTDwTuXiZV1V74Wns6sgKMX5OvsCJz/L4wXYMhGvKorIlZpNknk3U72FL2nUEsurq+QwiZQpgkrKsDuidU904SmMZukPTwvAOR2jHGvPKbX18Xeh/C7vpYANFOTHnwKTdKtWJskUQgqfaRawcRyX3LYwrcpJhcNprz3FOtdfUD6cWD1hYNzbclQW1A9KwA7LYEOHgO/DnpGOtV1UkvqmLshShzPiBvFCdQ2lKfGEfPS7ICYPwV6HhA1rt1nXubI7+j8hrfhmC5nZLBKXlPCa+Zo0pOee5
X-Exchange-RoutingPolicyChecked: ZDUnln+ZiCEt5FJuOfQ82hEumkABEb7AyqYQCFUMtbyisZp6ZwFhrSTOT5eriwcO1tYRe5FqnKrfq4sfOn9XZu3+U5a7C2hxU31IEO7GeqlgPlbJRTB3Ab2Pijxsx6Idw9dDcTzXrc9GvkfhC1OCRHdXDUZcdw7XH4IHaGPNHf7lXPEtNn7OHsFxw91zmSvvrG+mfXmrVMBJ1NneKrGIGDa+YK9/pYZOnv5bv3lDmj7j3zCij99vacy+ms0DC5EZWi53TYzE8FoaiZyuE4kcsoz23G23qE+izwOMG995rc52qFtUELueypuTu80tyM/ScCSQJvAp2GXiOfX/tUvWXA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:16:43.0126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a92ca0-1930-4580-66ae-08defddaf793
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6143
X-Proofpoint-GUID: RH5a1JiRqVTzjbMjoYSHrDulM-lAcPbV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3OCBTYWx0ZWRfXwykXY0HCP4kr
 T5zogaF+tViPrkHq5PeeVZBE48u6XbJNXwVlnw6Jmo/8pmyz8oBtCJf3Rf8S3A+dHH7vp/91yi7
 +42XJg0tJgQ7QYtG0vw1iOo32Lx5DyQ=
X-Proofpoint-ORIG-GUID: RH5a1JiRqVTzjbMjoYSHrDulM-lAcPbV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3OCBTYWx0ZWRfX7T/hgMv/L4+A
 kAXBryqfEBXPU1E/w51k5vBvLL/gyFb32swYD9pmELL5TajPcdT3fM9/wkAvm6XmGCX+W8P/mYB
 3CbcjA8p2boqVv7WlfeLkut1esX5nuEXlw20YBmSb5/lQi0xf5cmS4CmEdoG31SpTBuGQ/tqUj9
 nO3n1FW/65giJIKKn0eEhUOmIjm56utpmzs63PlrjOBCDMZpmdNZYKbSXfV1qz02uQZVPxmMR8P
 VJSE8coTGyBzdEpPtFSaZYVXcQhC1wa73StpHGZ+X7x2Cod4U9fN3wINVBrmbHgPAdM4VVL1mOZ
 PPriMoYbivs+J0wwNHqrxF0cZIAFAFkp0FpRMcobi/1zlxonzWQh10dMHPk3q7oSZbacK885o+a
 v/r2yvjfYjcVAFoUYVkqhTBExmqYUWsW8HF490bOfkg0K2I6qm2AuUTQTRO6234S2UEkIwXk3Tw
 +MA/wmTJDcOQSPl89xw==
X-Authority-Analysis: v=2.4 cv=S9LpBosP c=1 sm=1 tr=0 ts=6a85828f cx=c_pps
 a=0GA36Cgflur6eTh9hrVzog==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=snjlpwjXruQ0duzlbIAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190078
X-Mailman-Approved-At: Wed, 19 Aug 2026 13:42:00 +0000
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

Hi Tom,

On 19/08/26 02:11, Tom Rini wrote:
> On Tue, Aug 18, 2026 at 05:23:19PM +0530, Gokul Praveen wrote:
>
>> No-SPL Mode is a boot approach that bypasses
>> the A72 SPL while retaining U-Boot in the boot flow.
>> This mode provides faster boot times compared to normal boot
>> while maintaining U-Boot's flexibility for kernel loading
>> and system configuration..
>>
>> v2<==> v1
>> ===========
>> * Updated the naming convention used from "semi-falcon" to "no-spl".
>> * Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/
>>
>> Boot logs link :
>> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
> Content-wise, this is fine. Naming wise, in v1 you explained that "No
> SPL" (as I partly suggested) isn't right, because it's just the Cortex-A
> SPL stage being skipped. So please, work on figuring out a better name
> for this flow internally. Or be sure that everyone is really happy with
> "no spl" being the name for the flow where you're skipping SPL on the
> Cortex-A side, but still having it on the Cortex-R side. Thanks.
>
Yea, I discussed this internally and changed the naming to "A-core no SPL"

boot flow to make it more specific and clear.

I have submitted a v3 as well for the same.

Thanks and Best Regards

Gokul Praveen


