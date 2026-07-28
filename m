Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CEEC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18206608C0;
	Tue, 28 Jul 2026 13:00:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAE0Ua2C7pSO; Tue, 28 Jul 2026 13:00:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EF7B60A55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243617;
	bh=KWsZtearj78Gv5VOBKf0DsF1UuDnzmZhQfbGcyk0/No=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HBzdw/H+UBFVDC1gff7Z1KRTjZBWpIIGW5U568C38OcH/Wa0QYmRW5JZjiPVCnIPJ
	 AgYSFZ7JGPex57oz4+SwK1wlUf7w/ErMkK4HBj41YseMBtpIta1u+/N7luyvMO8uJK
	 2Bf4NYsMEJGCDPVBwOkNNweTotXW4tI2H/FKs5kr3nBXrBLo8BnEzceEwvfpiZ2U4L
	 elLkbOlAWKgrWZx6ncFFmRqWC3pfwXNEBBtThGqh+Y6ombgD8HPrIR2trkMkS9ayqC
	 RaQU7surk9M1MiabSIn0vp7K076hvnW4+RWGd3dz7ao8LEpSPC9F93VMZEGDkMwN6F
	 +s1yvAfgZbdAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EF7B60A55;
	Tue, 28 Jul 2026 13:00:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A26812E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 856C38121A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4sZ6MzwvgtET for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:37:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=gehariprasath@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2EC8D81215
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2EC8D81215
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2EC8D81215
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:37:39 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S91Zbv3583276; Tue, 28 Jul 2026 04:37:38 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fpseb05n3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 04:37:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQS4CR7GDEwknrDzaJ9xQ4jQg6+kKonZlQO4gg6FVLJSWfON53bjHnnZETDHubHh62za6sYimbL2schDaL8Hd5bdE4uafe9mrTUkXBipFe4eepc+LyXF7wvjWjYypnkyzwsRNzCUQj2u8axEd47gN92J05pL/8R5KKfLjrJjxamCWOLXP8McEOAhqFfnbDtjoacm18rA84lyNq58zLro25vAlo7mubbFanuZyURV/LWrsXsCL9uEXAqpIBDhF7iUQPbS4iJffq6STl9FJmk9iSn/YvzgiPelob7BuVcoka0s9d3/bJ8udAxSoaKcE02Xy6FdxmeK2xp7zpKsX2QpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWsZtearj78Gv5VOBKf0DsF1UuDnzmZhQfbGcyk0/No=;
 b=X5uuz0iWHX4oywOxRR7v+7hoNkfkr4eY419COyM+KBSn6oih3UnEylnwmzb7NnPVjZHhHqPXNEDC6I4aow15LusSUrVT9NLlo0Icv1g+po6mr6TpkKCNOODc7NzbLc+rYR/M62LH0Cx2H8Lefqt0eNXN6SNx6rFtgImOT8ErKkuUbZ107sx0OxqGWAstm9D/VXjgYEGbOLJxzUO9gcjrFtd4DCxppQTS2I/v+6NrDyhAYtY1MKHK/Gm/LDcjmX6FycAVrb0F5nRCPWMnEgMDd6yPK4rzhu5hndOI4K95HbCamO2nzeIBrbCZzHM7UM90Irf3CBKVtNZdKNtoCHfoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from SJ0PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:2c0::34)
 by DSWPR10MB997803.namprd10.prod.outlook.com (2603:10b6:8:36d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 09:37:34 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::84) by SJ0PR13CA0029.outlook.office365.com
 (2603:10b6:a03:2c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 09:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 09:37:33 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 04:37:33 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 04:37:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 04:37:33 -0500
Received: from [10.24.52.136] (gehariprasath.dhcp.ti.com [10.24.52.136])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66S9bUEA2400171;
 Tue, 28 Jul 2026 04:37:31 -0500
Message-ID: <4741329b-9d24-4f24-a540-9cd9418543a2@ti.com>
Date: Tue, 28 Jul 2026 15:07:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: j721e: Fix up eMMC OTAP delay for HS200 on
 SR2.0
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <anshuld@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
References: <20260728081307.3911823-1-m-shah@ti.com>
Content-Language: en-US
From: Hari Prasath <gehariprasath@ti.com>
In-Reply-To: <20260728081307.3911823-1-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|DSWPR10MB997803:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f48ef7-e73f-4040-dd97-08deec8bda55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|13003099007|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1yo/vHQSzXTCzspdeyzh7kqq5cV2ICWl/tGidgIAOzyJQ7Mj4PbPe23ZAKFNEh03x0x1PYSEGmQ542lpwNVca3yiv4gzz8dJ4fFcHw3++mziBjFNndrQS4MvNHdv4pfmXSR8bPdDHt0tSv5GViexXGSHPJjXsi5MKwv3nVomG4OVq4iWcwZ/fX5CnsGpwNMpw82RnoGbj4cwEwUKPZKv0IJikW/jowI90eVdOkEmyY1e3fB8zbJH8Gh0EkDBv0ke9bjEQXU397LcTqpbVG9xFPZwlu8osQcVT1rl0TvuF8CouqD3g4X9zmez4FijmWdSFp6Ob77UKvecdQS8Q4gkj3KzAmWEQqjQJ5Y4446S3HEw+RlXbA2en0h/F3ExhtqaVj4DJ8s1kaNMiTM1nRPoEnQkI97KbdaUS3w5zRn8dc0tvcqIN5Z/Ku/Lv/hZBgSpp63AiPxxA7kwC74+wEz/EYhfbIjM7vsjKqxNmsgewWbGiNbV2ZfHNe5rI6Ye7xD21E2sszF5A8PCD8d1SgTRN+hVAjFYnrcSYx/4IEiQ8jSzEZgpkZJAeZiGlynJZfvXy04n0VH1Wa3BFIh+9fKAOh0569jjKFbEB5QZ7CzMvnrEO2wPIVRAFHLKoI2bMwVo1dcDHrZC7uSEOrhgEiFmLRbHm8qGyJVvyMk9zG3CHiQ=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +z9om2NF/n3hPt5bFAVIjK91Dhk3EfvughIsuyAYVxMHVbHzWpmO207Ln7UF0Bn5TFTkGjFxzzUJOoDY0/j4U9BkN8e+aEsUfavFdnN/7GFFBhNH6ntyqZ10Y0ZOPue17CKUR/zv/S1GxJQL3p/ZiEp04SUIKD01ByBAATwZaQZ8yIYeJPWuc2kQJ9HhlZzKDCWhFWpyib6XKUCk9fUXvGP4Jzj6ndjMTkxgUo9YouHRudcOQ5XI8F3XmY+l4UwekpYBM1iQjMAuS/GKBlLLEC21Y8/z55s8CGMkei6/SmZ9e7kcR4+9yBBjbV7uQhoXPU4Plv0NcfTQq1Fu4GdbGUSXTIgTr4C5yM61qrsXFmZgOJnXj3BlAslgx7jdEKCHw961SBaIJc1zkg43mp8ZBOM9m2pej2ATr2afyvpx/Sd8y6A7sAlJ7wngmrovs5VG
X-Exchange-RoutingPolicyChecked: ZpIcxh64yw0fveFrJtSbGwDJyStnPPSvDlKNtJuRcqcYdZqpoppzSnMHh+bLWiDvPYKb4qACH2N0GEduGYonCJudXNbKqfswdli2VbsIW4dUGhP/dcPVDO8vNdQDhDd+yvm5KcjnvtkehQ25clKW1H6MPdZtffzVwjUpiDRnAPzN1G3vntrcX0vIW2F0RGgGFKISLKZxxVkEfeKxUgzS3uP8wbALe0ELkkjKi56WsgS4oVDIBd0GzXiCI6Ayq6x1ANmT+WRRfNpht9qWJN3VH6eqidR7B3oveN3Y8+JsPV9dETxWiIfJ4v1ZqCzLB/ECYXShpWjghLkHiXfgkVy64A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 09:37:33.9558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f48ef7-e73f-4040-dd97-08deec8bda55
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997803
X-Authority-Analysis: v=2.4 cv=c46bhx9l c=1 sm=1 tr=0 ts=6a687862 cx=c_pps
 a=scPzG5pGSpQ412Sx4Fqw/g==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=mdnbap41dKwI_sCKSogA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7C_aMj3z_wDVY96_GlgEvFYbTNyejkRV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MyBTYWx0ZWRfX4JIwiaLw1Ujv
 ocsOKj2FMV2RByikh2hqtnyBxLi9G9ts4SOaSRHInrXEn38UWdYdeDT0iFr6CObb3sFggnDzR29
 nw717NEcLXteN+3jagVvLD0u0rvTlLQ=
X-Proofpoint-GUID: 7C_aMj3z_wDVY96_GlgEvFYbTNyejkRV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MyBTYWx0ZWRfXwoWDVa4qTDle
 KJPLX70nDsA7xA5ca0eql5DGzsyH4wbcmJ95aA7krFJWveE8F1oDy89FuG/eJR1ULKI5GkwDg9e
 ySRQuAhcEJBsK7/z+qFptspSOZj1LMArsWlsLGxQL44+CAfYmX6w4EDUhm87fW+f/6Pe2x4lTWS
 Yl/vfjU+j/63VNv6BJwS/P4+wpSRlyraWTJQtF9zN0U76S4F7n8FdqfNcpCI+nkH93b/Vx8uqVV
 9uO6ie9AasXAOwpDxNE8tYT8Ev06yWdjBmFhCd8xlzbCohiTqKGuiMYAJCifDAHclVKpZtTnbzl
 fgAr39hS1gxG6ZoyRWhCuIE3uG1HW8AcodtMeg+dz9kCYleVVKOysHk95aR7zqm/qvEkWP95vS9
 NlZP3TD8lFf7kMsdWbAcYe+OylA8y/XR2mx/McWOldgUPJucSzOltaNEnifaJW/CY/VWzH08zYG
 bSSAztK+OLUvipILJWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280083
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=KWsZtearj78Gv5VOBKf0DsF1UuDnzmZhQfbGcyk0/
 No=; b=Tur0g0W/W9D3ZsxrVmLJ2v1ZvYDcTqkIgmWUTqJu6aJe1JNpGX3VfcTag
 5Tm+eVm/Oh8wqhwZ9YIFs5QU2LQv7Rg1zyS3vPfjlnsGURo+YRUBpXvVTLdqoEEZ
 ciQgJdz+YqCKLFGh/9xNvNBM/1aAAorel9aDzDllPalltKVP7n/BIuzBd6sLWCYI
 aPGxMZTDTpVHFA58THZfxscxexhpwc2t/rFwC5ZwkyApuuHjhurrC/7fKbsXHKbc
 71pQYbYb36gCeTKDxc4UryJCQmWHmx62WDmq6hMRBM4/lmU43n3opFxDdfvYeoqh
 OB0iUAyLIPM+3vzrsiPrIRSt3m3BQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWsZtearj78Gv5VOBKf0DsF1UuDnzmZhQfbGcyk0/No=;
 b=tjVr5vAjDtnLwpe0if+54ZXptdn90zGQEm+xI1W9FKlJ28BAISqNjxnmp8MWXhJO2tBOIEaQgme+43mCZyeC3d8xtTlBwvDeFhNDYDREH5KrVVSwiBCvaQ95/gVyXRQ2sA5LVRGVGnvhF5edqF1rEhAdVkz9uIBhwz3xVay7boA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Tur0g0W/; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=tjVr5vAj
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 28/07/26 1:43 pm, Moteen Shah wrote:
> The J721E SR2.0 silicon revision requires an OTAP delay of 0x8[0] for
> eMMC HS200 mode instead of the 0x6 default used by earlier revisions.
> Hence, detect the SoC revision at runtime and patch the devicetree
> accordingly.
> 
> [0] https://www.ti.com/lit/ds/symlink/tda4vm.pdf
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>   board/ti/j721e/evm.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 881392bd963..8e8a5362737 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -16,6 +16,7 @@
>   #include <asm/gpio.h>
>   #include <spl.h>
>   #include <dm.h>
> +#include <soc.h>
>   #include <asm/arch/k3-ddr.h>
>   
>   #include "../common/board_detect.h"
> @@ -33,6 +34,9 @@
>   /* Max number of MAC addresses that are parsed/processed per daughter card */
>   #define DAUGHTER_CARD_NO_OF_MAC_ADDR	8
>   
> +/* eMMC HS200 mode OTAP delay used by the J721E SR2.0 silicon revision */
> +#define EMMC_HS200_OTAP_DEL_SR2		0x8
> +
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   struct efi_fw_image fw_images[] = {
> @@ -125,11 +129,42 @@ static void __maybe_unused detect_enable_hyperflash(void *blob)
>   }
>   #endif
>   
> +static void fixup_emmc_hs200_otap_delay(void *blob)
> +{
> +	struct udevice *soc;
> +	char revision[64];
> +	u32 otap_delay = cpu_to_fdt32(EMMC_HS200_OTAP_DEL_SR2);
> +	int offset;
> +	int ret;
> +
> +	ret = soc_get(&soc);
> +	if (ret) {
> +		pr_err("WARNING: can't capture SoC details for OTAP reconfiguration\n");

error or warning. Any one pls.

> +		return;
> +	}
> +
> +	ret = soc_get_revision(soc, revision, sizeof(revision));
> +	if (ret) {
> +		pr_err("WARNING: can't capture SoC revision for OTAP reconfiguration\n");
> +		return;
> +	}
> +
> +	if (strcmp(revision, "SR2.0"))
> +		return;
> +
> +	offset = fdt_node_offset_by_compatible(blob, -1, "ti,j721e-sdhci-8bit");

pls add error check around this.

Regards,
Hari

> +	ret = fdt_setprop(blob, offset, "ti,otap-del-sel-hs200", &otap_delay,
> +			  sizeof(otap_delay));
> +	if (ret < 0)
> +		pr_err("WARNING: can't reconfigure OTAP delay\n");
> +}
> +
>   #if defined(CONFIG_XPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
>   					defined(CONFIG_TARGET_J721E_A72_EVM) || defined(CONFIG_TARGET_J721E_R5_EVM))
>   void spl_perform_board_fixups(struct spl_image_info *spl_image)
>   {
>   	detect_enable_hyperflash(spl_image->fdt_addr);
> +	fixup_emmc_hs200_otap_delay(spl_image->fdt_addr);
>   }
>   #endif
>   
> @@ -137,6 +172,7 @@ void spl_perform_board_fixups(struct spl_image_info *spl_image)
>   int ft_board_setup(void *blob, struct bd_info *bd)
>   {
>   	detect_enable_hyperflash(blob);
> +	fixup_emmc_hs200_otap_delay(blob);
>   
>   	return 0;
>   }

