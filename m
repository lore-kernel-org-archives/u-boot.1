Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A292C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 12:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 402F360BD8;
	Fri,  4 Sep 2026 12:03:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oyAhdMljFyTn; Fri,  4 Sep 2026 12:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3EA8B60BBE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788523416;
	b=JVD7gyREbB2w8uBlhHio35K4js9jt1rJX2i6TooF79pTQULnvqxIODBpL4Lm0P0m8mUy
	 rHg434bSsx4erGFEmpr4cRjqDRQHWWSNnX3InCTw/8BLcifncbYDB3DRyaPW6wfn7Lb/R
	 +15DPNHYETgAADMDLG2kBhBqIVgVk+bhreqyROkSiPaW9IMfG6YWBrOfpWU0FLY8pltUI
	 bPal7YpwcL6XSvgTySWCq1f7PvNh9B1m3lzQvYUZCaLhCZAdMfR+RudwUa+ZRMAxwMlJx
	 12kc/YWywGRdoTHEuFYbIOm3dVdIGgoSmrLN1WaBGNDe3Jx+4gm9sEazPKF7QZ3xGow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788523416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LG2zLIiXrQDpmWTjgnVP1luIbQP3J5+vRaQnQERr2w0=;
	b=UbKMW98jxrFHXEvjQh8wi+gst7+58P5ECDAO5zIoAcMxkwlTJnex9QGqXIpZsGw372oI
	 gKDqu8rDVTgKeTsUHnpzMepvXgVwFsB712xftUFEu7MByjm3s155m8UxXDJ6bYcaliuG6
	 Fg05Z2uQcR+IiW86dm2OBYJ4LrLICe+Dlk5saPwJqfU5+vyoH82g7uPyjFBpxh5Tk/Gsl
	 wvkDOTJnfENjXlBUhByqM1RhvPtEdqDYFtZwK4x9a+66iup96YSLM3lh4oi28ciMIZ/ud
	 w/+AMUE8cCIaCnSYkoffs9tZKziLySxkzVy6bgdCaFI6byfged5vlE2jJrUTDyhqBkA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Wt9DKFYV;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=LZRCBatW;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788523416;
	bh=LG2zLIiXrQDpmWTjgnVP1luIbQP3J5+vRaQnQERr2w0=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z2TnJvhsOR15GXbo+IT1TY2TAnsOHYuCAor80Q5xvZykKny6NuEeZmi54Qh7tB1/w
	 +Wb5QsszPk2DvuCbdGY5SxfQidl/zNGgzYQVqyfw+86GIYr4fMzlJW2eM6IQJWb7B8
	 0JI50fwgxet14SDMiL+ZXwBWKOV0VpJDQExAIlZeQOpg8npIMvdvvlwWRyFNcl1Bn9
	 cQhlOFiZm/wCmRhq4+52eIuxRfik6q1p472P1VhtSKg3IHkggqjPeqGnEYDzvPYrhK
	 auq9Qc+P1bZqAvSCJkwtWRUzaxwR1OTLpGplr/BFWQkb7YlkP/h2gVKOQn+WlxmIMd
	 wuoENAjB/SR2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EA8B60BBE;
	Fri,  4 Sep 2026 12:03:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C960F14
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 725F0607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6oJ7Or33kNLJ for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 12:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 88800605D2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788523414;
 b=ATn8rlpmYNYEtsF/GYUeoQ77agfNsfvdxeG+ESCmpihYssrm6Hmgd0zNVXCCQSJOVeYp
 RNnySzu28/CUYJxds5nySl2JXhBK6T9MRveONp0vJigMc9fQJpW53QGdgRsDl237iKF88
 G/n3tIvCN9wWC85uuWoTNPS5OK2Pd6c52zJTIPIu6FYuYEEhta4hhfu+0aExJ9jfotAqn
 V/YrLALqyJnM47nrvq3qheEfLyaGfZZwZCtyXZoxfo2ctBG1uRg/xbS9evQf5N9P5/4ef
 otKAp7qNrUqueE9YSKP4P+7nqHja5dk2coinjeFUNfY116G9vJ3iv85DJUazB+DAeCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788523414;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=LG2zLIiXrQDpmWTjgnVP1luIbQP3J5+vRaQnQERr2w0=;
 b=m2hNIAK30AHu4UPDZslVMyasu+6yrOnwWHG2hzKwHUUkYsku3EtnRR+Z2x6FABluDjy2
 R4hpCLSdL97ei+q3ZYy6sYlh48bK+ElMPhb0phiVwctYYgudfyd2LodHClb+Y8PVRtoUM
 NML51CKz5TE1VhLLMgxeJ+SI9DW2Zsr0mNbRtAzOykvdNz8wOTm1qnZ498+4te2ZCKxtY
 Xeg5Wrzsnry5I2wL/q1ynCh/h2iXumYyg9RQ37eQJvHQlhkWHbM6xnIWSJrm0bypHP8Q2
 c3GXF5Ha7M5zkTrbZ+9YT371MOtlTVTZfDQmF39ix+4n8OD2rM+w3asJNloZvoQ7sbw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Wt9DKFYV; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=LZRCBatW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=s-vadapalli@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Wt9DKFYV; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=LZRCBatW
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88800605D2
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 12:03:34 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 684AHJte1941784;
 Fri, 4 Sep 2026 07:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=LG2zLIiXrQDpm
 WTjgnVP1luIbQP3J5+vRaQnQERr2w0=; b=Wt9DKFYVvGBwa45atIsRyMd/JeGOb
 F9fjRbhPvXovUA6WOGSeunCJsGFK1kpexQeYvHFW+cn9VMs5cEWpq592kIgTbzEP
 a6n+h/UTlYwhRW5/Q3C/F8UxV+D0q9E8rHKAs5ncRK9gXBhB/xL6G7cMt5UBIVU1
 o9FWfA+319Jy3yEt+E++uUUNiIqOKWLj78/mD5w0u+HSd9YcqmdxR8hSsTEVPOqw
 t+pbm/H4a5LgpWcBzqrWjSSQaqczr6jdE1WE+bQXQl3bMZk+k3jkPWjxwPp+zU0y
 6HuCrRqn/ck3mdmWCD60HWsD04tCWvBpF20wbi2Pf7c2L/v6xqpcFDw2Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012066.outbound.protection.outlook.com [52.101.53.66])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gfrs31q3x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 04 Sep 2026 07:03:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l37mKpbGnEU2gq6Z4IZakV+8Z4fGSUnzlIdjDEQg77mU4bsrlE7VS2gM+5Py78LJUnDTb0Ypo9ZYby6a69DnCNPQeXMPT034VIDJIBdYu5rsWpCk6Pm6wofz6DnbC+70DNVxaRKJPBeFYvlSIaiqocoH8vxOtGIaZAY9DPvy0dCeRQnayA0d+loTltuDYQVdh8O4f4BhqvovN/7xzTL+2i51h4F5Q6+dWek7lSsUopQynRR5Y7nbDr3x8Xs4VFjv0EnnRAoHgLFNUKOr/6hPClRVz4/faodHrGaAjLrCTgx7UefpcAwzdZYAbRSZB3zUbzlbVZR4xZu5iT9TRZNrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LG2zLIiXrQDpmWTjgnVP1luIbQP3J5+vRaQnQERr2w0=;
 b=q/CEqlVIQqoi6wF5lbKzyvBw9KMCbTkBuNSQxvPs4X3ko/ozyM60vtilze6HqZ9bnZXYeFHDxlvAvT2vkO0g3p5IkDYYCF6k9pvvK/CcHvYTdeE8d6sOTesP+EeB1nsvTjG1snhr03m8MiZOYtOV/MHXAJc6jLuWhtHkoA6YdSfbbV08h8q1aMuXPsW8JzeCn9oUNpNB8oA5/mecqqkyMv3UWQPoZuQWRo29VwYtGjo2RHOnH0CLetFYhaXlWGY9WLwtbJ8kCbsEO8veM93UGbSkMMKvZSE1h5tQXrRBkbeQ9GXnXvZci4BflmUixXLqV8qbf0DSQ1qokPRXNpV4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG2zLIiXrQDpmWTjgnVP1luIbQP3J5+vRaQnQERr2w0=;
 b=LZRCBatWb0OBvjkp78t3H+VQvbmH2J5v2N1WfPrpgAAwKaJEm6AmBB+eu1ALddth+ZfeDfixd4ZX8x3rWrxmK1aigrxWqanrGVSEH3YJ/GEAVYUFsaBI6iIOB8WsJIJN++uAHRGBYwMIiDOw2aj7QS62ASb4tCoyDLzkdVVZVhc=
Received: from SJ0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:a03:331::34)
 by DS4PPF376CF97B3.namprd10.prod.outlook.com (2603:10b6:f:fc00::d13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Fri, 4 Sep 2026
 12:03:28 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::90) by SJ0PR03CA0089.outlook.office365.com
 (2603:10b6:a03:331::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 12:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 12:03:26 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:26 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 4 Sep
 2026 07:02:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 4 Sep 2026 07:02:26 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 684C2NcF3456269;
 Fri, 4 Sep 2026 07:02:24 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <neil.armstrong@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/7] Enable PCI functionality on AM654 at U-Boot proper
Date: Fri, 4 Sep 2026 17:35:49 +0530
Message-ID: <20260904120604.3612484-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS4PPF376CF97B3:EE_
X-MS-Office365-Filtering-Correlation-Id: a34e30ef-da9c-44b6-fd99-08df0a7c8719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 2weI+AE6wZIU9eSBuarm9vmo7P4jNIqWsPDMTmXW2McADFhrkfTsvx4e6xw2qpBSk6xmW8TYSV9BDJjf8edj6CQvOeEGD7f/syhn9FcnKjle2+/PhN8uwgE4fSfEvOPuSAa7dJnQ0lPC7V2zGbZQLRxFhc2oS/Zy5gIKgx4Dp8fBjMgyOYSxYZIQcMJm7gffVuvaEXck/f9xNGvxh90Q3j75uMpEgrIz+RDrNjZQN+E/RC0uways5pEppMj4jCo6De+8TfnWNfcCzTXNwYHrFBzRLzXT+VX8vbjtpGoW0xymULmRFmiXgcdOAQ1fRN0h84n7/I38vnm5D7gicmNDw19BFldofPlJpeHp/SDYmbs2akXNCQQvmlg7URXbVNr3uWW2Lu8QHfspdYi8Qx3qnVO2zmEj8UDO8EleNjrZ1G45RB2A6YNFvpi5QAdt9uVa/jRP/3sWHGstH2VNhTkoS/ndyWTtwzF1GrzOb7McVOTc+jk9elx3yR4ydSZN8BZD86rlOjiHc1wb38JEGqcyUJ0K9GHZMdrvDMPNRnSSDFGEpCHvUDesDb0ZzoR3dhVBzIiMuUTi/8QEImlGfEMxYw1rn6zGs5EiN8YfGkiBCdpd4uE+vLHtiekPtnufqRn6nNa732sQB3T+Q6ypzI4e6RiuNizEoW53oiGPcybTpLY3CbWuV+a+CiHEzgBmczw8HmQ4jiyWdMR2Y2QOOAchow==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x2QtFcifpJX8TmxcY8GCTCDhobgSoJNtoHK+MX2kf24qHezhWcEeEoHjJRK1T6h0MRmN6klXlS8Q6SfBrBF6Wm6+wfKT4XAbIi5BlDJCaXSYjpJkFjN5w0YwNB08NvfREvDvfKrdXXYxmAOatDjxJ4WQzs0BMZURDlWoH8y6rG7PmAfqKVv09RMyMhqMYaa9oW40Rxfwlq90ltqLHF4X14RkcA1vmvaOHKLUM9PYeVW5snl1PUkLqDxh24dQOof/8YczPd+d7jYXtwkeN70EgwhDE4S/gFjmXQ2iBJefgVFg/wxaWRk8r6BpO+JOMbrj/AXb8rpf5GnPcdCZmrA6gXNrFA3OL+R0Shd2ozbUw8WZYKaGoLtLXnz5yYoyhfGtqVhoWSYZA+Tl4A8GUQIcmYau614jm/ZYu+xDqxhiPuXYHsN+GmpKiNb5FgYJt3f3
X-Exchange-RoutingPolicyChecked: LqOx46jqMEaibQaqsMTpiH64bM8UbwmqemgfarHmHurq8wzZ5QB0wT4CO3vKAlprkU084nK483cj+e9/SYdB92COgaYS9IVczzI5sKX1eXJW3SU5DJC5dh55ZaJvNmC7avZn/RUv4TghtZ3XzWrs5o74VA+iP35t4CYYoK6M0k8rR9G9Ndx2dqRMfhqtEJ7bnFEWZT9mh46bj+/r1YKGD0LOsVc/93soQwYSqxmlqy1yKNd080wuGpopsTeAawEYvFAce36cMFbMXAnvGZASw4VZZi61OEhiZR7Gb9KMkKixTTIsJdtnlBnJLgivjDiwS7ID6rAysYCLPeQu3jzPlA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:03:26.7446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a34e30ef-da9c-44b6-fd99-08df0a7c8719
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF376CF97B3
X-Proofpoint-GUID: jz-zS2dwAbo6ELjXCDJ64FXxS0fT9SJj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfXzshhWDOsw/tD
 nsXZkfbgA5Zf9sEzQ0iMCZtJJ6plJr54G1AttlAbI1DApFXkyHQAWSyhhFwMQanqwcvqkLRu9pX
 DioHpbLUl77srC9bwhOnAHhIEBjYfEk=
X-Authority-Analysis: v=2.4 cv=GshyPE1C c=1 sm=1 tr=0 ts=6a9ab392 cx=c_pps
 a=VTZ9QiboGVM1ljQMw9N7kA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=NEAV23lmAAAA:8 a=Elxs5dHThqak5dLQ6NsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEwNyBTYWx0ZWRfXy/VJPs+VTArO
 Bx1pp2vlUaZkavzmi65sxQaDWD9/GEqHxZQuRhp+hHJF2AlQRwJCdkc2NFV2CUr4Siibhc4gh8A
 AIhjIT1OueK4IC/nQacT6eQOhoInBTFeyDxGwx2BCMA5Bz1xEO6CJ9O+n4dZY5YcSE9PAuBirdA
 B4f2uuLELelZazmHSv+TKpYyqy3GRtcJalSEn7iZeChOkjKMsNEuhAKCFKZGh1i0QJqGyiMZ6uo
 AvJsR5StG+VqZRHhZL8jKFZOKnsJSOn73rAtu6RuPy0B93iHBB/r7d9EBxoReepivNeAfCWscSV
 /6fHaiH4dDiRTEAjG+KrAsUVPamWTexCr6BL1Gpq9CqfjXwfMnm7qzDW6saPxag3SaG4k7vpLjD
 dh2qdnm7O2NPHMhK+Zw7UUUpu404+5m+PvHRvnrYZ0yk5Maahq5ejOap+mp16SlCCW4H32gRRDW
 21R5qOXyX5kx3fqwBFA==
X-Proofpoint-ORIG-GUID: jz-zS2dwAbo6ELjXCDJ64FXxS0fT9SJj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040107
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

Hello,

This series enables PCI Root-Complex functionality at U-Boot proper on
the AM654 SoC. Although this was apparently enabled in the past, it is
not functional as of now (without this series).

Series is based on commit
cc557af4553 configs: sc5xx: set default FDT file
of the main branch of U-Boot.

Series has been validated with the PCI x2 Lane + USB2.0 daughtercard
mounted on the AM654 Base Board. Logs:
https://gist.github.com/Siddharth-Vadapalli-at-TI/3f005c5ff6c00dbd7890aba860757551

Regards,
Siddharth.

Siddharth Vadapalli (7):
  phy: ti: phy-ti-am654: fix logic for programming clock parent
  pci: pcie_dw_ti: fetch num-lanes from the device-tree and use it
  pci: pcie_dw_ti: fetch reset-gpios from the device-tree and use it
  board: ti: am65x: evm: add support for SPL to update U-Boot
    device-tree
  arm: dts: k3-am65x-binman: package overlay for PCI-USB2 daughtercard
  arm: dts: k3-am654: add bootph-all to gpio@38 for daughtercard
    detection
  configs: am65x_evm_a53_defconfig: enable support for PCI-USB2
    daughtercard

 arch/arm/dts/k3-am654-base-board-u-boot.dtsi |  4 +-
 arch/arm/dts/k3-am65x-binman.dtsi            | 35 ++++++++-
 board/ti/am65x/evm.c                         | 76 ++++++++++++++++++--
 configs/am65x_evm_a53_defconfig              |  6 +-
 drivers/pci/pcie_dw_ti.c                     | 27 +++++++
 drivers/phy/phy-ti-am654.c                   | 12 +++-
 6 files changed, 146 insertions(+), 14 deletions(-)

-- 
2.51.1

