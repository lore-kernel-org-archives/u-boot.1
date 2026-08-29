Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB79EC61DE1
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 14:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AAAC6061B;
	Sat, 29 Aug 2026 14:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EnGytDzC_39A; Sat, 29 Aug 2026 14:34:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788014084;
	bh=L2YrGJ6AWv/YeFLe8NhoE85TpA4pHN4yTXwmL8uZUmk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HWHv6It4i+6TgaTkJyYSeIiErO1ZRms42EPwufktlzaBOlfzsv9eZQ1Jf3HcX6E7c
	 zruGaM09+orHtzdPcFcj+bCFd9PJsN4H2+wKqc6/b2zwNA7VBin1ZWHX7kWZUVfdC/
	 wiLHyqY3FmP9HQAofSZ+86kqXWX+3qeDHmk2VnvMPx56FygUp9a6E8QkWeAPMJHAaA
	 h2m83XjpIaxjVkXPUJJBxAGyegcuMMbthlJo1DvQXRZzlhf+HXd939PPH5QUpfPMPB
	 8Ilk7gr8dmrgWJyrsGOBoCBQ3ovH0BRKE58eofSkOUQ8CVZeH+qZA1ggAR0SLx911/
	 6TR/G3Xw0LPkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E4FA060690;
	Sat, 29 Aug 2026 14:34:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 491AC127
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4469460631
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VJSHUnZqszk5 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 14:34:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=EeF6YwuH; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=fUDaWOPm
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6968660628
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 14:34:35 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67TDxoMm4097395; Sat, 29 Aug 2026 09:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=L2YrGJ6AWv/YeFLe8NhoE85TpA4pHN4yTXwmL8uZU
 mk=; b=EeF6YwuHnz5C3tqjIhH0MZo4BLhZ7D7huY6ptj1DoQ+WBQgivZqnhLp8N
 60ftB1U3MQtX8BQYQCrj2ixs7+hvwyHfHVv2TRn7Fhiaj+l7H8B1XwH8vpyRufIc
 CN/RHtqUYOQDOF6D3lrqaYxnnOtpsGahpanWEKxvjUt+EUHJTPblzgBYGnRN0bru
 eRR9tyQIPsqVY/vJFkc4DE7Sq36WjY8V+Kue3ONKCkGV1NpQjWPFphNeaYjRIe23
 8tgX97dKlz+al3l5uiERw0FUn2fkgDk2xQjUo8OgbEymavGoCErSEp1K2LdtoNd8
 sGmFFHZIRZUyOZQ5Sz+mz21RlO3hA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010000.outbound.protection.outlook.com
 [52.101.193.0])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gbqr29rwg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 09:34:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWVl6549vtfnh8dtoCzbB9lbKQ44z+3StdK5SJpzH4HVbNuaFHqumOs3PcHVHe0GSFcn1y0LgelLN2dtWHo3Rm72CHCQpP4QaXVgVBpLx4hez/Fv4hOxzLa0OGmXKbV42YOGYIw7UJTRLAUhP3JOVYrial8Uss1mH8d7Yqc/zphgrmRRYpUNMQoqyxpxxtS4g1XYqQLRWQf122eoMEwWefCbhskSNkffOK2jiJ5XhFLZR8RDITLBlt1lS3QEbgojaEEGhDpY8NxrDUQyin+UP12rADl1ESvpoofMWyrDvK+kYMYL3gwoPkwUlIw8BbKIv4ugBXQYPTtZ9M2nKfUtJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2YrGJ6AWv/YeFLe8NhoE85TpA4pHN4yTXwmL8uZUmk=;
 b=G4x1yC31jfcnzBF0UtdAT0nIYUYq34A264y98rQNym+prCfHlswy6rGXoh1nmtaiUP7xloNprkXpFQHl8ofQx/n+JiZQb+wZI0Q/W4282Okt8YRET9SNv71Mor6XiKbNfVh1d+//1KPq8idtoc7BPJx2b7bbGFesNkYKge4sOpKDd2lwLc4/zrzmkkdE8bIEPqvHOaZ0sglG9Qx3CZPQRC3fJyWl9ucNAgzBc7BKVbOUb0Cs7Yg/tygkz+58EofzEv/CT8H/S1StonGZLep5vbAlEALnSu7kZbl4DlG0XxJWufpewlZLB3P3D/hNPPxC5XruJA/DWsGynXd+guJilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2YrGJ6AWv/YeFLe8NhoE85TpA4pHN4yTXwmL8uZUmk=;
 b=fUDaWOPm7eNEzfLAnMOQ+wP+7sKGjXhlVtFYBq09gMEyn4bF3kpUgZky99/aL7JcNXO91X9LiOoTpm1ZbF1esPiOFw1CrZnPr4sxwA4zRPGQixlPAMZmFT7y5sOJT9RPn70UJQFiLx2v69HNk/qheB8s0JV2Dy/VlWoz8GpAr8k=
Received: from SJ0PR05CA0063.namprd05.prod.outlook.com (2603:10b6:a03:332::8)
 by PH0PR10MB4583.namprd10.prod.outlook.com (2603:10b6:510:43::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 14:34:31 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::95) by SJ0PR05CA0063.outlook.office365.com
 (2603:10b6:a03:332::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Sat, 29
 Aug 2026 14:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 14:34:30 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 09:34:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 09:34:24 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TEYNAj530318;
 Sat, 29 Aug 2026 09:34:23 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Sat, 29 Aug 2026 09:34:22 -0500
Subject: [PATCH 04/14] board: ti: am64x: split the EVM and SK board entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260829-maintainer-fixes-v1-4-e4e03971e14c@ti.com>
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
In-Reply-To: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Bryan Brattlof" <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|PH0PR10MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: c51f8d8f-52f7-493d-ea75-08df05daa340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eZeAuzZDhnATH493Z3581dz9dgFTSfFk4t6qh+cwcWyH2kj4tohFaLZQ4ubJYDhbzSWLXVTa4aAM4fSY+3geFnmG8SUtux3UdP86LJ4fpyjU7pf+0QrPbjus06U0bhYkn2o87JXcls37lne2JX+G9q/LJNz9FfWCYwKNDjTwu8m8F+5GOI+riPAKAzqY/Wayrx0PW2LRPB/yoXB9QDMlnEZPHyxFT56YT9uQUdirooIFOzMKD95nzi6LZzj6ZJtKTOQrEsHq2nPPZRQX2LY8HTHrUFfGrpJdHzc2I2Q3h8lxwXa8rWx0N3cWCHGun7R0d459tOK+4Yzm/eE1m7EWkPvOuZaAXRqjHrUPtLcr1eG3yN5E++mV9gWAAhivFBHFUYMYQiqIUAzDcv9kKMSC/mWrzALEvKFfBJlfD2o9RFTYTTYFnmIs3yeoyxMhkfxb68YtPphvN6S9p/bLaHkyMGOaors63QZdRNFY6fzQtHEjkT8Z9fmfNhN6zsGVRjKqfHVMEusEEoPhQMomChDNC+r1JNX+HVG2W6XLZEVr76vwO1LCLQfFSNoH6Hrpb7vqMDZm/UYqyKXCTcrDieS5vJzGfuqxa6fMFBdsq8Dg94Idsj8E+ZXllcUJ2adei9bK5+Lm1s1ogkkZu9tSK8Z/IIzf+ZfUkcbUAwfhbEFIhpM0ipDSEj5B8mRJYC2fZvYDr0aFngzfrKxtNrKbSyGHYA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WCJwqQG3lBvd7GTee4Axoy64h6i4nCMyEOYUWezozTUPQyM7y8lJqoBj9wk9NMSzjYMomkFpS8r2+xRsb52Pwk8aqTd9iU4yWTSThkzylag2jRNU1E1nHErEtZAxxnDkc56/bvVo7tDUPHAr/aldpeRPw7w6rVHV5tGCRjPDV6c8YW4LglPmNxV/4i6MqoNgcTSznAGg84a+g6tW7sxDn7+fwx42DLyxXQhsAOdZSyXyOdSr6Z8NNHDr26b0XTnLdENF41ldinJChCl+Ir5iWJBYsMZUOSkZ0GqHJi1YoMYOT3gW47/MkXsEDJZ3cH0pgh6APSuJ+61TTWFdsUttOXqZilVgdoJ9hGMD7an6/vR5aAq/UBOhNMN8RpeaieJKkXxPXDNMSt/qll6K3+t3K4zm/VDd4rDIi0ZhsoNu2o5RYzb0yckMeCJ25AiCn3yy
X-Exchange-RoutingPolicyChecked: JwilNk7+TBBFhdicbGFLLlF9hh9eDZBZP8QqhOqzrNgAI+8RQt3sAxwS9Popw4B+rJVVWxjxzRwaoXvU3WchD9OGqx3vwBQH/wn91lo0dXF46Z0b7OgFfS3Zsguf2MSdo2yI49Ng9asJcM8G8V6DAt+SxllJcV1Ri/rd2FfxZH51quZASLUbHrrNGGwL65p+GwVIgIPf6Feu4oNJ4s4LI6d8gso8yP0KEI5rpeo6cc0cuveqB/2KnS47suwt4RNCzA+1HpuooUMjlcMunWeGrcPGTx/z9lE5YaSCMl2ejWsNGi1kmMQKZIZMQi01wcLMUhfB+2tDLOvK42P9qm/w2w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:34:30.8516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51f8d8f-52f7-493d-ea75-08df05daa340
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4583
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX3QLjUoEREhEx
 1qomPppPy9a9Slk5pC0UpTyk4+FdQ063G55l3DsynBU7trHNM8+Mr2ME1+bCO3G7vVfF6LIf4Cv
 x7lzY/eyuysoaKv+YkzfJLO34cHyYPE=
X-Authority-Analysis: v=2.4 cv=KqJ9H2WN c=1 sm=1 tr=0 ts=6a92edfa cx=c_pps
 a=ucUdQIQ8V72PEv2waZrxmA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=k-42gJp3AAAA:8 a=cTXftkx0V1RGd5E9CJUA:9 a=QEXdDO2ut3YA:10
 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: T_loclKqghE1d9JLfinwZatckGtlL1_S
X-Proofpoint-ORIG-GUID: T_loclKqghE1d9JLfinwZatckGtlL1_S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEyNiBTYWx0ZWRfX9cwc3jqlN8+k
 c8q89b+4XJXb6x1omJ1Xtpg7IbWocDwokr2oCfHsIB/gULvYKBTCKvAdgz3aMh59JxHut06Jsfh
 WMnfaTe9FYYagnJdgMOdB728vOAKX/zCy1GLAO+c5oPUa/OaEmtarqU8iT4GYfuXP4rbZX2edMv
 hXaBZ07Lz/9TqOqwi7sv1JnT7Yn0PzH30BOC55r4WweGk3BpRtAUXQIoc0bXtnUqL4qMhD40cVk
 D/qPplh54w/2kb24BYNYRYdsiAOMKAHAMjb09SjbVjhzQpDD95ojD1DJoV/I2Fovzhan15xzFAW
 whyWTfLwOEeil2BmTZb4TgNiEkYsG9xlh1Oz/Ng3XLeI1McPfnwcz9k1wSmAIbqdrAeoeWA4wmp
 W1HWY5QKGqDnPme3h4SCTvhache6jWlJga6zcRsmT7lxSlR+AfbNK/tbyBovNbQJwCCo5F5Wca4
 uimzvszlo4jjZfNQmQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290126
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

There are two boards which TI supports based upon the AM64 SOC, the
SK-AM64B and the TMDS64EVM. Split their MAINTAINERS entries so we can
better track which files are needed for each board.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am64x/MAINTAINERS | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/board/ti/am64x/MAINTAINERS b/board/ti/am64x/MAINTAINERS
index 78a21d66af73..3f0a8f9d6971 100644
--- a/board/ti/am64x/MAINTAINERS
+++ b/board/ti/am64x/MAINTAINERS
@@ -1,8 +1,17 @@
-AM64x BOARD
+SK-AM64B BOARD
 M:	Vignesh Raghavendra <vigneshr@ti.com>
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
 F:	board/ti/am64x/
-F:	include/configs/am64x_evm.h
-F:	configs/am64x_evm_r5_defconfig
 F:	configs/am64x_evm_a53_defconfig
+F:	configs/am64x_evm_r5_defconfig
+F:	include/configs/am64x_evm.h
+
+TMDS64EVM BOARD
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/am64x/
+F:	configs/am64x_evm_a53_defconfig
+F:	configs/am64x_evm_r5_defconfig
+F:	include/configs/am64x_evm.h

-- 
2.54.0

