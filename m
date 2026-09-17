Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C87C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB03F608B5;
	Thu, 17 Sep 2026 13:23:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eqmOe0yQ7Gkr; Thu, 17 Sep 2026 13:23:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1486B6069A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789651388;
	b=pyhnAmPoGZkh4+ylwtEUqrXG4QNpzJ12LRZd3oaZm59iVxJMyUHakPsKnKsRSpLe4tQP
	 xnl4FtCzXCIfKb/EX15gT7NV5Rzpsy/lTPmZdHoFt0JG08/KvFxF160J1dsDcgi0wc2kO
	 5zOLdFrX6jFvsTgo/T0/ihihGLmoX4xiXncKe/WEa+3KOAtTa3mflAcSd/D2G9U/s01T9
	 NvCY7yNpQhqsbxLVTtQCqlRCDXrl0+vicFO5Jp5+7U1DwA3YUneCHwbFlqvbHBybkx8WP
	 LofGWCgQs8o4F1LL1Ol89jo3uaNMmeqDi6DO9CQTN2O+cIs8eceFSI9XpZ4Z4sxviYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789651388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=Nn2bZ7k92gk5+kYGwwL41kl6sgrzrmOD409zn5qJsko=;
	b=tEaCXhaEyU/GPS1Y7s4MfrCTy6wB3FXw9GSt074Z/j9G8Pz/3Qwqgmbx5JiR3WWUNOPV
	 V2MQ/hwFXm08yggsob7AgIarrjhuSkwQ2IVcfbk6OlbayieCWjLi2mzxVMFta37+1w0E8
	 jH/Qa0lM9KginefdjxqI1JiusZMpLSW1CVbml8R/sX67j2ccddCGR747nOYBSl9GdSiyb
	 tdZpyEPrEn1UxihJLNsZOAVg9/OVsLpjdJ3tZm+VmRofnS0AiEA5MYePqhK+ztc8ZqOP2
	 ghPV29AL2OC84vopVLoK8iriSRYC6wMNHeZqhN7ZzCVJyfmKmMJmFJN/HTZYADtRXjw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789651388;
	bh=Nn2bZ7k92gk5+kYGwwL41kl6sgrzrmOD409zn5qJsko=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/brW8sMWB2MZjbeokMB5X3Gc4/RhHPN0lIAA/0qg08Alg96R54Tvv5OuB2TKQzO9
	 CpJ0LE7zn0oUPf+c2IEty9QkjUPvGKUKinB5RGfJca0rORKrJzvIj0Ose9kEbdxX33
	 Ip9YksKecuORMpiLuZD12GQevWUnxwTD1ZYBE/bQoVnFv9+L2uWL5dKF9qWImNt+MA
	 3fbQuF9cbaL0rzGA9z5YPYTEf+Sa2pFttXA8JNCn2CStX8LgokJ/Pl4Eas6W5Dop5P
	 HQIwazupGgrsIg/htDO68SbylJpwTw6X1Uq6l4CFRKZXSdS8OE1ljNi6x5VPXif/Ly
	 uATxMGjCMl/6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1486B6069A;
	Thu, 17 Sep 2026 13:23:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D14F33AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C388740355
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c5UQkp2t04Ps for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 13:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E5EC94027C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789651385;
 b=bZZhlj8Ugc6/ukws8cfbkzUcHicsb1e4XLww/FfaOEnCjzXwZWe0DKzyGUhYuayU4Hu5
 yNeXWQFXq9n4Iz0YC+k5yv+QC5fnH0BEJeS2wHxT+4ilINGFNAJRnKlJviJ7P3Rw4HNpe
 9OW8wpfW9AruHglH32geB3KscX/f/Q4Pmq4eT06r06GtohBU6weqXLFHx/BvEL6iy10gJ
 3YH5KtF16AO12Ran9IFrMmnWRXOrtBlotRJV7QAdiGcXfQLGJTp0W1z5EBKqy/6atvg+i
 CKrXrYc8xsdknEvMIl4BcB/Pg4XgQFaESBf/6Wr5wYMYyWw/40GHVqfLDBj1KoA6d1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789651385;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
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
 bh=Nn2bZ7k92gk5+kYGwwL41kl6sgrzrmOD409zn5qJsko=;
 b=HU92QT6NFcGXdo7k91mTVBVDqY/W0VQl9OuWgkmGceMpoUF09MuuJ6QwO7ewLP3204Rd
 HJHxoN+Xei867vnN4D5v/1HaVpWheP1eC0J6Rr5njJVdy++N5S2xCU7hGPSqwqEz25wid
 YUI570m+rDAaxdiTNFHyJvwdA+LZfJhcpETCPJPNpzg99V6eMeVeM2g87fD4vI1Ed9bTR
 Lkat4AsATkNmTgnKpDOlTNyvpGyAxKcNUyLxO6EKQZg8FF7UNTKiom5ONlD5FvwUFP0id
 9+n0qA8Rh3lDiICka/3hFOCJZ4zxE7PQ8yvWVoAuC9e4h5/chgxNJZeP4cf0vFt9nSA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=asEzDVo7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=asEzDVo7
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5EC94027C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:23:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS7Es8l+g53C1iOVJFBrcxnObdKckXxVWZryDMPZODgu5w+CwQSzhJI6Vapfn2wZ6HTkN1b3pSVjzzgy55zxC8N+HOJkx6ecxPkrBZkNt1I5OzHxXtfoEpmfEx1Sq294rGuT11AFij0bcTuCZyHb2mpCPXbeKpAv0Qe/TIThVDf4XMw9DR7/N/87UdOM0UnzpIF/kfM1Xe/tNALxTE8tFUhPIHuX4S77HskCmOJ0UUQpARrda2mCxASLKhAAdVSr9b079Qr2id/RgeyU8Y0BZnx11vGctiX6zm05aLkSVxtrxUU2rX4F302UkElCIqsSqOEC3CFkXvxP6vna4Pz8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn2bZ7k92gk5+kYGwwL41kl6sgrzrmOD409zn5qJsko=;
 b=t0BDQxp0I46NiWl65KjfaWfQu+asMw4/CBvl2Lo04cbvjcoBKqphiaSbn3asNNjLOwqIYQSSjATvgxS72oTD8RnUHnUaXhqo8DiOG+vKMSSczcQfbfShEBljFfoA73I+XI/ZVYv5aLOyvgzu2DpV3/8PRNe1oG2M0GkEo7I1R2dg1R5Yxr9Sz6OrJ2m3YgLLFasBxkZy8UqAHv3gjDgj4VQrGC+1zePJgSKnG+jHHoG6qtfuS8b7Amrdnr+o4b8q+O4uv0ZGgsg/NNlsN61mWsphzhBkfQ3NNxCMZ6mPlhWN8lKTm/WdXRTO/R9KPO/6Fh3Cw4DGessvcYe43PQtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn2bZ7k92gk5+kYGwwL41kl6sgrzrmOD409zn5qJsko=;
 b=asEzDVo7d3Si2JqdLa/OSmSO6u7lPfzUmQDS4zIPYsVR4myRJBvexBQ4BAkYHgtIuRctvyNLme9SZtGWzi5ol1dZ+vvZnHW72/OZazuyizESnf3N/Vh6YDZZE4yu4Zk7iRr7tusEDBHv2g3Ersn31O0ouE8+WnGRQpRTtIIHsDoyqpiQ0uAkca8ACMamTvRFriGkZPhAqjD+XKov8AAegiFr3knYMKf7SKjwwVBdLR+G3u6Ia3+cLc/P+Z5mJqc2lpDUEnAauUjMs9BB1W1FNik9pGg/APGioosQHkoSJeuml85+pk3JmcUeBnQjEZ4qk5MQPdiDjp6DaURbzXAnDQ==
Received: from ZR0P278CA0198.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:44::12)
 by GVXPR10MB8614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Thu, 17 Sep
 2026 13:22:53 +0000
Received: from MI3PEPF0000848A.eurprd02.prod.outlook.com
 (2603:10a6:910:44:cafe::a3) by ZR0P278CA0198.outlook.office365.com
 (2603:10a6:910:44::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 13:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000848A.mail.protection.outlook.com (10.167.240.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 13:22:52 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 15:28:23 +0200
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 15:22:51 +0200
Message-ID: <61524734-81b4-4869-9029-222d3a7e3ff3@foss.st.com>
Date: Thu, 17 Sep 2026 15:22:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] configs: stm32mp25: Enable CMD_BDINFO_EXTRA flag
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
References: <20260904-upstream_update_mp2_defconfig-v1-0-695c0abaac73@foss.st.com>
 <20260904-upstream_update_mp2_defconfig-v1-1-695c0abaac73@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260904-upstream_update_mp2_defconfig-v1-1-695c0abaac73@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.100]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848A:EE_|GVXPR10MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: f93d8a26-48fb-43d6-f743-08df14bec6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oS7EI7p/oiE7acj/ZWPtBFJpdGeOYbdHLg9NMZBpQDFc0/IRi/v7n43sLTyXJmjldbnqA86D2d7YnisY3+JsOsKyzRRDVSqwp7BrNTHq69hSBd4LRUlwwsW1LWlObXTLgDN2L/s7WuumWN7F47XpFc+uS2WFNCz+Fz/X38vY06UKHAHdo5E9vRCLO8lAgnAlo3pK4SyN9Zdk3sP0v3HddGL4EkWzDU4G8g5tDo7vQN7SXdiNwUNuzbk2NDavTBiO6RnnAi3wPf36s7iIMITx/qU4j9qO2l8PwMomG4eP04Zyc1JGrFzLQOUj8ZHTXb5Q9vsoFt81rMHiumXzZaoMlzSX+e87rmPUtNetWFn8yJvCFD2VHPlVfBksNMfHDRHkxR5lOpC6S41gMOhuOOyx+73+xVIjUOasvEAVaZRjmITFurAstspiGQk6v9V/gJxSBg3ygBYhRf85+LA6PcdhvqsrX1CcqB+DZ2r3RW3FicchdFCp0Zs6A3M5RBoo4p8k3uz5MtV7Q+R3O45fAOf0I08xFmqImEcJXzRGj1ZW9haFEcEMlMWj05HZBre66FTDaQjdrHTDfur7CkQSdRzKWbKnMVTnehSeSCGT3dsJ9+kHcu+EkoZXIRFUQwW9mH49U8TI5Scwme1VOx8/Riu8ZQPhu/pLdeKHS4YBb2iq+0BEhYsPZUJPr5JVjs4FhALnIh+bSKpalQYnIU6XG+F9Iw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kBCWHCpo88SpytixYuMDsJcRyIfRVt4AxNQTeZhFxd8AQ4i9pcIrk4DxkWuAQcq2wCQtViFlEM/tpomHVu9PhTZ5V9AgKSVmmTC9yv8lq4yCetldjfPTN2Tq5gksutbZtXf6oG2oh+gkMT8RnLKwoaZl5qaeFzKkm7SPJTHNKFFP6188rmPyAI8pHzhvNaCNsElmnUR7DhbebVcvy4qGXsrWh2QYm7XP5SJ61QV9KQUBYgQAO9yidapLlTHEJDBvQdeqi1TTsUB7Jtc0SIM7Pk8fK8vSZZtnFlPtBstWn0kx7NcT00Idx1/1y5JhYaIOZeaMmkRtGhA/mO9ERCJAQ+iyUC5B2n4RoedgitMlyxQrBbRjjVS/JA11UlG6dBIDmUAkLBVoEKcPh4LrBV1eDJmNYrPAEO0gAQdQsh7emnC+ErL4FgzlfXNOE923iFNz
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:22:52.3387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f93d8a26-48fb-43d6-f743-08df14bec6f3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000848A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8614
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

Hi,

On 9/4/26 12:18, Patrice Chotard wrote:
> Enable CMD_BDINFO_EXTRA flag for stm32mp25_defconfig
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   configs/stm32mp25_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
> index 42335aafeaf..e55ca2e3f0f 100644
> --- a/configs/stm32mp25_defconfig
> +++ b/configs/stm32mp25_defconfig
> @@ -22,7 +22,7 @@ CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_BOOTDELAY=1
>   CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
>   CONFIG_SYS_PROMPT="STM32MP> "
> -# CONFIG_CMD_BDI is not set
> +CONFIG_CMD_BDINFO_EXTRA=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_ADTIMG=y
>   # CONFIG_CMD_ELF is not set
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick



