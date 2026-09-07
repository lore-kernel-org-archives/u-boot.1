Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4FCC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 05:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31C9A6066A;
	Mon,  7 Sep 2026 05:00:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sXu429p6U7sp; Mon,  7 Sep 2026 05:00:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E2A646065A
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788757204;
	b=SI6GPOgOVKEvbRzr4YqglOi3fPj7V/7qHozjlPDN43y0nH4nMoqZFZ5+gbo9cSgYnyTw
	 7TV0F18Df/ArcNPtvcikuY71cu+mQXWQX4UHRlCMHtBhfY1XT+T804JsCyAR9gLiexoYx
	 jiFt2yjq2X4ec6KrZr2f1scvFjsHyKA3x5djjLsEQjAPF9Iqf2kQZeD0m/d+TS4i0u1h2
	 Y4Dp0/keaaMKsEORhb1iwV3zQ/yew1IpnobpD26irXtzDq0qQT3vCH0eaEzy4HiZEXNHl
	 zURCvodJVUrxeDCixUiuuyaVyA9LctzY6UOMb70ybKiVI0SqPBVVYZoKLOvbh/dlWLw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788757204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+YpXKsNWb2YWdWKD6AvB8HaLlW0D3gdv4mTBEVc0Yjo=;
	b=RdOAMocllA1mrstDj0fDJz/EmGgCxqnXoBuUvH4fKdTeHtoD4o3ho3UVtwD737S69/kA
	 ++CMpHtGmExZPCspmYoHU0RWXaPK7zoTj2G/o6cRvDcJ66rzDUd62KEL3ZLhfzQCLMMfm
	 qGy98M5VxBWKKbIEGUgTQll55OCIkK5FKmouMqgsUj50hlF/wWm3xp7PlwJz9tiasFJVY
	 3eQwHjEoYCdRBU9NJpdqkfQjnLk9p/w8OlJUBeCo22f42CCn90KrgFAyhK1HjOUntsUyz
	 8DzRDuhrVkv6edXANoJ2h3YTQTkiEzCNwYpvwyDfMowHU36ed5MkyDmKkiAdbc5vjtg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788757204;
	bh=+YpXKsNWb2YWdWKD6AvB8HaLlW0D3gdv4mTBEVc0Yjo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y0P0ahGxpuzScT7DSR9+oVZbo9IZrY0sRpPqcfNJlu9B1sBaBFsUk7DO6lvV0Rmqh
	 Dxwq//7/9a5+esVYsWu/L0I83LI6dJu2HXi37FwxnKCn9M3ZcMsuiyDg6zmzdOupY5
	 GUIfp4662HpQlefbOlNJYhUL5a2WmHpF2akzBTLeZCtL1cfpk1pEboyHKiAv+kSWiL
	 IMLjGTKzcPRpRYTWBl5YZfKCWAwj/nVvnk6DbSrZAdA5jI9urCVPrEfOCnDHNrytLt
	 q8IukihnFFR201W7tqWYRbWVeZMm/g4Oj3EwMblbjidmonaE+kkeqrsQ4NpyErY5Lk
	 XF9JFTR47pDRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2A646065A;
	Mon,  7 Sep 2026 05:00:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF1AE2FC
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A23380AFB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 05:00:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RxR9KZX_x60G for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 05:00:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 32C5780AEF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788757201;
 b=CivMVk/qdcwHcvXz8V8h4eIihxD8kP+Nfu2zBhkrzOD24udF4vPhYz8oBYTEKkVP1NsT
 syuRYg2I9fEheuYd6kdo8sDhNTwOZ92NzjKApN3S6SrnEMtcrV/31Ef03CUxY/lVAhDpZ
 zM4UNUoreonThpL1DmlHsGEdjE+0YZpZYpyQhD5fkpM7FAXaTgQ8zKtYZIQoBgVUJvAY6
 zkPbuJ7PhVBbLbZtN6Q12bjG/rvKrKL68pK86sslf/bjmgW03/9/R9JrYkey8aqXdKpPK
 PnC36zTALsDq37fXgShwcIEjEQNciUf3k4ZeKdwRYQP1ObWxnyyCECywzo2QYuz473Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788757201;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=+YpXKsNWb2YWdWKD6AvB8HaLlW0D3gdv4mTBEVc0Yjo=;
 b=UDYQPkiKHPckJ5YsHDV314LQfn+SUXr9b/q7PJ2znif8wEP7SbR4wAajESgJVq4dG2Ah
 0hz3wTkUoRP5FYa1u1VxL1BLCojNc76hRiErz8/lfbgdPAyUjwJoukcvzsBRgJAGpkBnF
 dUAiAR8F5t+gGIyziYA2Y+YaZ1S9bk1slwkUM8R7mrmE9RDDCkAoC/RDqJYnL0Ywu/9zz
 ZcupRRcBq519/idDnEOAWSmCCIQjob7rUrbzIIEflDQmMZ1P5h7lD1uB6Vxn++Nmu45uK
 Z2dKodhRodSJP88lQvijFrBhOf4JYeeFlCccmStWcjHLchPQInReh+NlM4YBVb4WVpw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=pDRKvx8B; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=eSXJLy26; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=pDRKvx8B; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=eSXJLy26
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 32C5780AEF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 04:59:59 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6873ihhR2218852;
 Sun, 6 Sep 2026 23:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=+YpXKsNWb2YWdWKD6AvB8HaLlW0D3gdv4mTBEVc0Y
 jo=; b=pDRKvx8BhJP5ZLfBIWwMyIlfocv384H+SjZmwyyZOatByNSICTpvc/eVy
 BJl/reDmFHAN/CB3e0q+U208u1xaHRJ2n+vXvrCjwhFi39BT1qyPZLVRiqdMH0q6
 WFMvPUKS2nDCv9az6MSIP/YGr4tplczAIQOj5zDzDGc6xLyhnxTYzsQCh3538wGO
 4ivIgyq2L+56WLpECPJWgjtQNlWwnp76h9MX8znYtp2lOvJ/m7EX1P2JJYTamSOX
 4oxIiubeNFe5OYCsczGdhhHBFlVAURGsc6ytLWpVKYGAbGdSgkZLDBfzEAxW30ft
 qjXHx8ZSkuQl35iszkq63LBtO8ebg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gh43n3e8b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 06 Sep 2026 23:59:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1UlfyrrlVFwaMKdgM6GfdGhR24emqLbWQydn4w+tXspwLClnwzsR+e1oubYmR2KRiUHjthLD3wHXJfgUIPlq1ATJHr+5P++r7DVHDIm/GGR7qxoV104dZ+cdDp1M4LSMCBotnO5xVOt5MUbzGTm+z43sQcQ0+XLLzXp200+M+1IbVHOecpp6dT00xzT2rlwBYgLuJbW9q7HYrHi0/vzWUZkEr7CnqDC1hIbKhDuJMGbmHcJHzvC+zQ26x8OjLczuUZpqw+BxPguu5Vv9/OCaolvh6d7D4wYjKjOrhiRAVVZrt7y5g7V0RYEDd4aYsagb8Vce06fvsgWAIIcQjwn2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YpXKsNWb2YWdWKD6AvB8HaLlW0D3gdv4mTBEVc0Yjo=;
 b=lR9LsUWSG/X7yLw3f8jk4s6v8InpVNqcoWt3RxL+FFYZ2vBnFGr35NR0dT48y4Q/grEhNRzyVRl0QpSvxx6VC3vgMED/ew/Sh1Zol7XRK8B3lmfuilrK3CFeX+L9RdV9ZVqktojPeAhdaQCgC3G/Qvigc1WJ1gMM+qmjudZtlP01UF+Ar1wYA0AivxSjqqgEN0rEPuwiGVsagGntVtQZeW5/pMealLwmlJRv6eicpNlUt1jBxMjJQOlTFBOgLJbebcxfBDKkK8nwwigTxNmei897qJdVGqaxA4cuibzWuof3GhMXV8eVC1yu91o4jN2PSD/iyOP2C4xn+j7AhsfAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YpXKsNWb2YWdWKD6AvB8HaLlW0D3gdv4mTBEVc0Yjo=;
 b=eSXJLy26OwVPZQo6zpRAhH149zRzuuAYOyshxI6ofKrpxrKlrir7l/ao1pmMM9D5qNnH5z32NGE4LTMxAdEzWZ4uDkd30Gb9UrFDsklKX7EcQmOZwKpI/vT7U4GQopoONkVt4q2oyfYlpFY++HGg4zeJep1R7pOpYY6NJ/yKLU4=
Received: from MW4PR04CA0079.namprd04.prod.outlook.com (2603:10b6:303:6b::24)
 by IA3PR10MB8705.namprd10.prod.outlook.com (2603:10b6:208:583::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 04:59:43 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::40) by MW4PR04CA0079.outlook.office365.com
 (2603:10b6:303:6b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 04:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 04:59:41 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 6 Sep
 2026 23:59:39 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 6 Sep
 2026 23:59:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 6 Sep 2026 23:59:38 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6874xYgp4024867;
 Sun, 6 Sep 2026 23:59:34 -0500
Message-ID: <d0c6ec2c-002a-46d5-8937-0b3a19c534d7@ti.com>
Date: Mon, 7 Sep 2026 10:29:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/21] Introduce resume for J7xx SoCs
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-1-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|IA3PR10MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b041c0-a1af-462e-8be7-08df0c9cd39c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 2/hlOXO9z9ItNOUuHsLefCemApnJU9+OXcnrkgQ5Anh9kTjxNuCHx6zuIoOR5Dloabu/ZrE9LzzfQPzP181dhWbht3ehLcEZI3mHozET5ZVYo35waiaPTNMLa97UB4fqngFgzUfkB4Dh8rBf3reqhL6ZjyNa9gtB6fUSlCKGZeLy6/2KirtH6R+8q4BIZsT4i9CcEy11lL7IiXlrtvXaZEPZhwfYy4Y592hpH644NOZ6mtu5nU3Y0X19oG3C9BCaiGNYpnQxk1fN9Brx3nRNkhLxr4lXpUSFa1pB4D6pzV4L3YixzZ6rmbO2wlycseePgoa0WFdhNSqZ5CXM3xbPlnF9//kPIfPgdC1sxqqONMzW9KTEdU+BX7Hzxo1UxtxcPjltRl6CfaZ+C6qRwfdp3aVsz1WFFBj4Q4hzMMAAIOl2+BAiGhmT34L5Dz1snpbzr2n27W/nJ1k/SDm4UGQGpZ61mCMx9BKTG7uFzi/ID97Zt3n2qJMx1oZZhSG36aa/jCk6uiZDyf8PwlUUkuFZwbgA/8NaVT0LjRCzkeypy4UcpeApL5GN0ReL+i619IbU8YrViCGzHBWjG73ULj3uphxEdqsDh98k0fB9WHmhISbjUi6r5uh5DX43n0SLUnGnKqo4BEGqoqIKgsw2LCPIUkMjEygrvvwsKZC+JMCXvdY=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c4u0KprUQPiNZ0J7iLYUJDW7vZapWASQc2HQYTIWcmJB6gSN4EDpZO2Jr7lJ84CT+xodfswtkY0HUISbpbAYBhfWYr3ycKps/4Y++y2xgguOsoBciWa1+UfaLA290fOipWvUpPvJ7t8mhvsfIdVfTyCk06JiupMb7xeZyaQprdQ5svwEujzVPgKPhphYrYJk5TNlyxGwzvliSYuRStAlT1sXb7RKdqWPT0hdOEJDi2TVIGK/ySM/263XRzDzVMHdKq5wPYE6xZbABFMieHRWVLn1tvfmBWRy8iTzTWx5gBekIqmt/w8H540IWXEiMFVKafns+1N+TtyU+KD1ZDho5OCcp28v8pt3aSSLEipnxR85gl4qR8vzpwTVrsCRyFAi+XQcUFrSE4eajyx8sQ3NMCJbu+Y2/kkJH7V9Pf/J+D/F5CyT7vfzBCIjWI6h2ixy
X-Exchange-RoutingPolicyChecked: ksqAa+WRe6qbikKSAX+DIUFtVRVxNomY2P3WRft2uNIPJ+245yvcdxLn3G3+0NxntMxyz3FGwSxjT8ypBcLtxALs54v/llFQh5q7ndn7X+r4q9utyKIhvMsL+Pn+u8GMGmiRQyfikh5xkJk2CA0bQFTgJnd888nuzrF9tOWZatYHQ702HLqtz8XxnSfP19Rp6dy7DyK+9ZQ9Y1oIKt4Vimd8R0l9B9uBbSSGhyUm+4mGq64hiUfU0kAVfrOU2HnTyy1r7vVynhTCOP34Fzqhq69BJEG5gK3c0am2/5mpb1TcH+ceyZATk/YVDqmnBOfZRMLyUxtMT0YT6phoqAgH6Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 04:59:41.3261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b041c0-a1af-462e-8be7-08df0c9cd39c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8705
X-Proofpoint-GUID: _T76kSVGtYjFy_mUckkenAkx8a93Re8s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA1MSBTYWx0ZWRfX/1JiixFDbgQf
 s4/TMbh/3d3s9Mkm37cYXzPwB0ab9qUo+Jc4Q/t1L3AZ6qNIIlGPL2pTjGTUtC0xVRnsN9KNZ9s
 YB4JDyrEL111W2M60z7MDuNsoG6iLZ9fhAzcBQqfRDuidptkEkwwOfnvB+qSRMlTWfDpJIiruXa
 DRaOBianO7tfhIVTvkaZ2B165dVkua8WmYQBSvp4e3qsn+CMhVuGsH0o3xtRgx+M+x1KkYlIlU6
 cfQA65iOnkXRi8uniBRg3GUcKYYuh3rbDUrOHgsaiKEhDcBnYMiniPVk7D3A8KlA1L8dBlE24hv
 YdrHARMKpMgAkphU7av/WAf543T0QovDoq2rzm42ZDLxuhSxK9gcZfo9Bz9r0vu0glr8wi996jv
 8lPfYUW5AbXQAYgb7VdVCiTfFKqiRO18UHBaJcn3ubZh7HYk3blGaDXLYpfGl8VU7vgUb3SQYer
 E07oF3zy5+g0eqwcggQ==
X-Proofpoint-ORIG-GUID: _T76kSVGtYjFy_mUckkenAkx8a93Re8s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA1MSBTYWx0ZWRfXxgHY80DFnsQx
 D/odQfFwJYiF4KRBTxf/Gxeik2u/O9W5tYW9om6bOqFiEagLzlsy6ewTm8+dWNKgg9mnJU3YHQn
 vYzxf0+bSCKcn8NQQ7q8zfzZL553ZkY=
X-Authority-Analysis: v=2.4 cv=JdSMa0KV c=1 sm=1 tr=0 ts=6a9e44c3 cx=c_pps
 a=cAYAfY5XwGGlFG+HVYY7CQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8 a=EsQ-oy5NqFSgUIwl4u8A:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_01,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070051
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

Thanks Richard,

On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> This series allows J7200/J721e/J721s2/J784s4/J722s to resume from
> suspend.
> 
> On those SoCs, a magic value is set in a PMIC register by the DM
> firmware just before suspend, then everything but the PMIC and DDR is
> powered off.
> At resume/boot time, the magic value has to be read back by U-Boot SPL in
> order to know if we are indeed in a resume situation.
> That's the purpose of j7xx_board_is_resuming() introduced here.
> 
> Then, if the SoC is resuming, the DDR has to be brought out of
> retention, at full speed and get out of low power mode.
> Between those steps, the DDR_RET pin has to be de-asserted. But the
> DDR_RET pins of all DDR chips are tied together on a single GPIO, so
> it's impossible to resume one DDR chip after the other, they must be all
> resumed at once.
> That's why it's orchestrated from board_init_f() and not in the k3ddrss
> driver.
> 
> Once the DDR is fully functional, the next steps are:
> - retrieve the LPM memory region from DTS
> - authenticate certificates from LPM memory region and apply firewalls
> - ask TIFS to restore TFA and its own minimal context
> - start TFA on remote proc
> - load and jump to DM

Please add this flow in u-boot's board specific document as well.



> 
> Disclamer:

Disclaimer

> ---------
> There's a potential attack vector in this sequence, because OPTEE could
> be modified before being reloaded.
> Also, if the certificate replay is skipped, then TFA can be read from
> MSMC.

This as well in u-boot docs

> 
> Patch 1 and 2 are from AM62 LPM series:
> https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com/
> Patch 1 adds support for DDR in self-refresh for am62/j722s
> Patch 2 adds capability to call TI_SCI_MSG_MIN_CONTEXT_RESTORE
> Patches 3-5 add LPM helpers for all SoCs
> Patch 6 adds the resume detection for all SoCs
> Patch 7 adds common code for DDR retention pin
> Patch 8 enables GTC at resume
> Patch 9 detects IO+DDR resume state for j7200/j784s4
> Patch 10 stores the wakeup reason in MCU_PSRAM0_RAM for j7200/j784s4
> Patch 11 sets the PMIC NSLEEP triggers
> Patches 12-14 add the DDR resume sequence for all SoCs
> Patches 15-18 add the resume flow for all SoCs
> Patch 19 updates the pm-cfg and schema to a new version
> Patch 20 removes now unneeded background firewall on DDR for j7200/j784s4
> Patch 21 extends the firewall for ATF region to TIFS
> 
> Tested on J722s HS-FS, J7200 GP, J784s4 GP, J721s2 GP
> 
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-min-context-restore
> 
> It needs lpm_memory_regions described in DTS:
> https://lore.kernel.org/lkml/20260427160326.370415-1-richard.genoud@bootlin.com/
> 
> It also needs a bootph-pre-ram property in PMIC-B for j721s2:
> https://lore.kernel.org/linux-arm-kernel/20260429-k3-j721s2-som-bootph-pre-ram-pmic-4c-v2-1-31a0e7677216@bootlin.com/
> 
> Changes from v4:
> - rebase onto v2026.10-rc2
> - add disclaimer in do_resume() for 2 potential attack vectors
> - include needed patches from AM62 LPM series
> - fix minor checkpatch warning (!xxx instead of == NULL)
> 
> Changes from v3:
> - rebase on 8d5f30b52f7c ("Merge patch series "env: migrate static flags list to Kconfig"") + AM62 LPM series
> 
> Changes from v2:
> - enable GTC counter at resume
> - factorise __weak j7xx_board_is_resuming()
> - reset PMIC NSLEEP triggers register in one place
> - gather Reviewed-by
> - fix comment style in k3-ddrss.c
> - clean and Factorize k3_deassert_ddr_ret()
> - change printf in dev_err in ti_sci_cmd_proc_auth_apply_fwls()
> 
> Changes from v1:
> - drop unneeded patch: configs: j784s4_evm_r5: enable TI_SCI_POWER_DOMAIN
> - factorize j7xx_board_is_resuming (that lead to patch renumbering)
> - drop From: field duplication from patch 1
> - use SYS_K3_SCRATCH_LPM_ADDR config option instead of hardcoded value
> - add missing board/ti/j722s/pm-cfg.yaml
> - migrate missing K3 platforms to new pm-boardcfg
> - remove struct lpm_addr_info mem_addr_lpm; (globals are forbidden at this stage)
> - rework ti_secure_image_auth_apply_fwls()
> - Fix pointer arithmetic: mem_addr_lpm->context_save_addr + FW_IMAGE_SIZE
> - Fix K3_LPM_WAKE_SOURCE_PMIC_GPIO value
> - Fix spellings/comments
> 
> Abhash Kumar Jha (4):
>   board: mach-k3: r5: common: enable GTC after core_resume
>   board: evm: Enable de-isolation of IOs at resume for j7200 and j784s4
>   board: mach-k3: r5: common: Store wakeup reason on scratchpad memory
>   arm: mach-k3: Update pm-boardcfg for all k3 platforms
> 
> Markus Schneider-Pargmann (TI) (2):
>   ram: k3-ddrss: Add support for DDR in self-refresh
>   firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
> 
> Prasanth Babu Mantena (3):
>   firmware: ti_sci: add low power mode operations
>   arm: dts: k3-j7200: Remove background firewall on DDR
>   arm: dts: k3-j7200: Extend firewall for ATF region to TIFS
> 
> Richard Genoud (TI) (9):
>   mach-k3: r5: common: add helper functions needed in LPM resume
>     sequence
>   global: k3: use gd to store the resume state
>   mach-k3: r5: common: introduce j7xx_board_is_resuming()
>   mach-k3: r5: common: introduce k3_deassert_ddr_ret()
>   board: mach-k3: r5: common: Set PMIC NSLEEP triggers bits at resume
>   ram: k3-ddrss: Add j722s DDR resume sequence
>   ram: k3-ddrss: support j784s4/j721e/j721s2 DDR resume
>   arm: mach-k3: j784s4: Enable LPM resume flow for J784s4/J742s2 SOCs
>   arm: mach-k3: j722s: Enable LPM resume flow
> 
> Thomas Richard (TI) (3):
>   ram: k3-ddrss: Add exit retention support
>   arm: mach-k3: j721e: Enable LPM resume flow for J7200/J721e SOC
>   arm: mach-k3: j721s2: Enable LPM resume flow
> 
>  arch/arm/dts/k3-binman.dtsi                   |   7 +-
>  arch/arm/dts/k3-j7200-binman.dtsi             |  14 -
>  arch/arm/dts/k3-j722s-r5-evm.dts              |   4 +
>  arch/arm/dts/k3-security.h                    |   1 +
>  arch/arm/include/asm/global_data.h            |  19 +
>  arch/arm/mach-k3/Kconfig                      |  10 +
>  arch/arm/mach-k3/common.c                     |   6 +
>  arch/arm/mach-k3/common.h                     |  16 +
>  arch/arm/mach-k3/include/mach/hardware.h      |   1 +
>  .../arm/mach-k3/include/mach/j721e_hardware.h |  11 +
>  .../mach-k3/include/mach/j784s4_hardware.h    |  10 +
>  arch/arm/mach-k3/include/mach/k3-ddr.h        |  16 +
>  arch/arm/mach-k3/include/mach/security.h      |   1 +
>  arch/arm/mach-k3/j721e/j721e_init.c           |  24 +
>  arch/arm/mach-k3/j721s2/j721s2_init.c         |  49 +-
>  arch/arm/mach-k3/j722s/j722s_init.c           |   6 +-
>  arch/arm/mach-k3/j784s4/j784s4_init.c         |  44 +-
>  arch/arm/mach-k3/lpm-common.h                 |  19 +
>  arch/arm/mach-k3/r5/Kconfig                   |   4 +
>  arch/arm/mach-k3/r5/Makefile                  |   1 +
>  arch/arm/mach-k3/r5/common.c                  |  17 +-
>  arch/arm/mach-k3/r5/lpm-common.c              | 446 ++++++++++++++++++
>  arch/arm/mach-k3/schema.yaml                  | 146 +++++-
>  arch/arm/mach-k3/security.c                   |  62 +++
>  board/beagle/beagleboneai64/pm-cfg.yaml       |   5 +-
>  board/beagle/beagleplay/pm-cfg.yaml           |   7 +-
>  board/beagle/beagley-ai/pm-cfg.yaml           |   7 +-
>  board/phytec/phycore_am62ax/pm-cfg.yaml       |   7 +-
>  board/phytec/phycore_am62x/pm-cfg.yaml        |   7 +-
>  board/phytec/phycore_am64x/pm-cfg.yaml        |   5 +-
>  board/phytec/phycore_am68x/pm-cfg.yaml        |   7 +-
>  board/ti/am62ax/pm-cfg.yaml                   |   7 +-
>  board/ti/am62px/pm-cfg.yaml                   |   7 +-
>  board/ti/am62x/pm-cfg.yaml                    |   7 +-
>  board/ti/am64x/pm-cfg.yaml                    |   5 +-
>  board/ti/am65x/pm-cfg.yaml                    |   7 +-
>  board/ti/j7200/pm-cfg.yaml                    |  92 +++-
>  board/ti/j721e/evm.c                          |  25 +
>  board/ti/j721e/pm-cfg.yaml                    |  92 +++-
>  board/ti/j721s2/pm-cfg.yaml                   |  94 +++-
>  board/ti/j722s/pm-cfg.yaml                    |  94 +++-
>  board/ti/j784s4/evm.c                         |  25 +
>  board/ti/j784s4/pm-cfg.yaml                   |  94 +++-
>  board/toradex/aquila-am69/pm-cfg.yaml         |   7 +-
>  board/toradex/verdin-am62/pm-cfg.yaml         |   7 +-
>  board/toradex/verdin-am62p/pm-cfg.yaml        |   7 +-
>  drivers/firmware/ti_sci.c                     | 219 +++++++++
>  drivers/firmware/ti_sci.h                     | 108 +++++
>  drivers/ram/k3-ddrss/Makefile                 |   1 +
>  drivers/ram/k3-ddrss/k3-ddrss-lpm.c           | 181 +++++++
>  drivers/ram/k3-ddrss/k3-ddrss-lpm.h           |  20 +
>  drivers/ram/k3-ddrss/k3-ddrss.c               | 295 +++++++++++-
>  drivers/ram/k3-ddrss/lpddr4_k3_reg.h          |  94 ++++
>  drivers/remoteproc/ti_k3_arm64_rproc.c        |  10 +-
>  include/linux/soc/ti/ti_sci_protocol.h        |  17 +
>  tools/binman/etype/ti_board_config.py         |   4 +-
>  56 files changed, 2395 insertions(+), 103 deletions(-)
>  create mode 100644 arch/arm/mach-k3/lpm-common.h
>  create mode 100644 arch/arm/mach-k3/r5/lpm-common.c
>  create mode 100644 drivers/ram/k3-ddrss/k3-ddrss-lpm.c
>  create mode 100644 drivers/ram/k3-ddrss/k3-ddrss-lpm.h
>  create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h
> 
> 
> base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5

