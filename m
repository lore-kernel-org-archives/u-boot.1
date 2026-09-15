Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329E3C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 06:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46A7660721;
	Tue, 15 Sep 2026 06:24:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sRaLpuuH0JsG; Tue, 15 Sep 2026 06:24:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 71CFB60708
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789453460;
	b=FGgi8QfvfJxw3sUxc98/iLCfI40VQ5xilgF5dkysU2M8u/KF/NfFxizIwe+qm08FrpJk
	 LISPO+UyWGg6lKYjxdmKGATJii/rg17ND17ZsUK97nUnA+k4UBdDpeywtqSdubaxb4Vzy
	 zbcO7oFcFqSo2y9R5JfpknwBASPKhqxfy26yu6NFOlTYV15VkYmVJ1+ER6jSWk3A/F1OZ
	 0ckhCUejxXDVQhZb7NZkl998x2sPC8qCm6xRCbd0InuID5RN/Q8ndZJcQ5lLMOdfIGEb4
	 xqDuR+qFUL0eapPDZEP3QSDpRpSuflMzza5jZZR8IYajMJ5VPhKxpANdi6Yq9s5Hgew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789453460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MTokpMyuFp1Y2Kt4FbfT0Lyv86y1SAzMr7uZ3RpTG+E=;
	b=hvviWdDkTFJZlvkT6Rf7YtR5y8sAzNNOarCxVlX7DLjzqV4UnrnClTkIPpzAjaSdlFts
	 Zq/6/RgQs2KQqQzfu7sh6nUB1ZZw5ksFYdCl4gRWoNJZ5ZdZ2O3qmwvPvrF7CZpT8EoF8
	 2i6PDjY1HYN1fTvEgQk5/5Zv0EKYXSHKY5VeaIuP0lMZhZZ9RoU0zTwuvsmI7WG4kZC37
	 2s702CWpgr8nKcqVz8WydkgehuMHOWFZzslIN+qmY8DngmltuUMnVOw+5ubM7dObFaVQh
	 u1BbbsTCdGWFddsdw44dML8pb609DXBDmWoVKErvFjfwZykVUby3AFcip86mE5WZNPA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789453460;
	bh=MTokpMyuFp1Y2Kt4FbfT0Lyv86y1SAzMr7uZ3RpTG+E=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tOxljOgDz8isMmwCGtJL2q2nWopOW4+9Ky+qe/q19/zhFc7ZnfDv4Ow+NJ5kyMk8q
	 oQNvegfHpSvT67h2hi3jcMOjQd88Ci3UBZUxE8cJHkQmS+vtJgANVavXMyI8vdiypI
	 nuF5+nWnyCDZXXkE7O0KTqD87SKhiezlCnX1mKF8bmsy5MTtlmD1VST/StKAGCGjDJ
	 Ytt6W0NqT99i4f1F4InAtAvZmgRd6HgWxiQ0MjBaqcKgzV6BFXMptHBJepoEi4lL3T
	 zB1fLSENU1WctHiO0cAZ59UleNYc7HRenYB86k9KqTnGcnsXnirFKIEz4QqUE9fIsS
	 D0CsZxCZ7vYCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71CFB60708;
	Tue, 15 Sep 2026 06:24:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD725224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3567400D0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:24:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W_2JttybYyIK for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 06:24:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5766C40082
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789453458;
 b=OCKAF6OuFaIHiqan172Cia3EnaonVMqb9uH3pBkBP0+cyw3Xir2aH1dGoSAcI6wGz1/j
 q39NjOsSZT5jrbwk4j3HW68W6WnnxgRkymkF5qPCTzfYSB76vaQQoGb26sDhzQSjZ1nJ4
 7/B38lEasiol1qyrx90r0Svb0aHZpjbWLji2XANKpTQj+TkMnng+mla54BahglcPZtxHM
 aNjKeD6iPcElyBABD8m8ssE0A0HhJkd56Z5tzQoFzfHom/h2Hdx6kia3YvUcf++0J8nPt
 ESLtWj0Yjbso40O4AvN8b5YVHJhe6Yd5R7k56TJ1rSnahQXmhNF3pY7FV5ZTv1FrOgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789453458;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=MTokpMyuFp1Y2Kt4FbfT0Lyv86y1SAzMr7uZ3RpTG+E=;
 b=qiSVcp2aEClVF3nBL3lMlyrnND4T7FUw/uG79YE2aRO52F0HX/tXLkq0W29V7t+0mJEq
 s698ZBOnCUGYTFKT5Xe6uLsGyCyzIhoBycMcxou5gU8RhRPz0ZRnMhI6ActKcrWarWfdD
 ATe0EW+PGKj2WG6rinHAiZlOntYVWErjQ4Ae0q6/7jkqA2+8gRdh6dgDdCpSpSAxZ+uLD
 CJssaOcFxKcGLBYHU6srcSDJ//2w0uQz0zfx9sJABbZwDhBsTU1fp/kfkaOLlU3xgvP01
 q+i5shfFAIkObEb89vyIlpchxMsb4o5NoCxoDEKqTuiUVtmgoxz0j7bk4VOfxpI9Xvg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=YiMiSuki; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=NqGEs08w; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=YiMiSuki; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=NqGEs08w
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5766C40082
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:24:14 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F2m8IE2989387; Tue, 15 Sep 2026 01:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=MTokpMyuFp1Y2Kt4FbfT0Lyv86y1SAzMr7uZ3RpTG
 +E=; b=YiMiSukiLlKeegwvox5OelX08zy0wsmsSya6IkI1VDRETdQG5CGPkq2T0
 vtGKao/cq7Er5JlkLHZ59htot2RJIH+jJBjp4O31g0Vdg9s0nNtB/LjjTV+d0CAv
 hC5zsRkNfvH9h0rOPyNqTnZJ1kJYIlIhS6bHfxbIGBB44Xhnk8vEbthJrKDEVofT
 FakyanhRZJNvSSh24Qe6WHaYP4Foux1EBy9iaYr1yZJ7NC4z13hPPsD/TjtMH2TE
 ZLKQzkQHo3qi4TlSBP9H/4ur2uL5M5T+ulfn2xQz2RQSz1xwfxDzKNdUPmMVFmzW
 UP8KyjOvrARo9cf1Pqe5PoyeTIBRA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gpm40v9f4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 01:24:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmn/CZz9NwMnOk0t8lNepI1EMeHcww1cPhnn6WWMcEq8/oReXk8T+y8A25VrGRSbCmmGsVE1L5DXflfRb2Uf5ia60bTTC1Diq+ZnOs6iFQEjarcY90fktBuPk7zPSAQ+02SdbckTfoLXHVv/TercJILeBFUkKXSJ3gsNGW+7U2KgZFfqF7xiC73DToZ5o0/a3iij3Lf0XlL2CAJnKaJ/gTUq0goKgpYW2JmvgXOtnNyf5odhZwwluuBuUjhWmhMINMjZFfw98Z1kL8U17nH0FYbiS2dLqwdluKUeW0iHAhX4R/DUv250rilMYlVUEW2M2ECMtPAzNX4FSjQZswwjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTokpMyuFp1Y2Kt4FbfT0Lyv86y1SAzMr7uZ3RpTG+E=;
 b=Uk56Cxd7CNZQvrwEMV0t6Kr+eFrEOhOFb1O6CVCl0VHUi1U2xrAxeyRdSjHHdvfRQ4r31XmYLqMJMwS5YKLMxEYA5I29kZD4+nF9lM98wys35eHCQcPz5rp5no1PhazEzqzlD10KvWDVS/Msb1ik2Ig77ivlCUhQIK3P7ZnNvS75eyfkJPIp6WVvy++nGtIJpNCv0/Uw803swpxnE+18Pc0qLdXk7zRXjRZwDihVZjR4F2bxSp0ouKUogUUxnYZ9BtdFt5gdls4VuTw9BoPjdEomwOSzHbrtnUxLt8DhY0Tosh1iS/3UeWHFbq9Kn9t/TxkDOmeZN3kmn0reTiLswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTokpMyuFp1Y2Kt4FbfT0Lyv86y1SAzMr7uZ3RpTG+E=;
 b=NqGEs08wmZQOXHFlzbfLSx1mveznAbkHep1PT68gZpylswtWNtfB00TjhTsJxCUKl/HVfCKEWLZyZxVSXxb+ekXNGOEhewWLAWZN1ViPSAb5rLiqVwmOobImQjY2p2+4SsBF1W2pUKeLeUXB48BkF7CI/hdeHdOyPp8NOyjCszE=
Received: from BY3PR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:39b::29)
 by CO1PR10MB4755.namprd10.prod.outlook.com (2603:10b6:303:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 15 Sep
 2026 06:24:09 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::91) by BY3PR05CA0054.outlook.office365.com
 (2603:10b6:a03:39b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 06:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 06:24:09 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:24:07 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:24:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 01:24:07 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F6O6Mm2686234;
 Tue, 15 Sep 2026 01:24:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/3] configs: add A-core no-SPL mode fragment for k3
 devices
From: Anshul Dalal <anshuld@ti.com>
To: Gokul Praveen <g-praveen@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <u-boot@lists.u-boot-project.org>
In-Reply-To: <20260903072805.31010-2-g-praveen@ti.com>
References: <20260903072805.31010-1-g-praveen@ti.com>
 <20260903072805.31010-2-g-praveen@ti.com>
Date: Tue, 15 Sep 2026 11:54:03 +0530
Message-ID: <178945344345.1987229.8256745321604612881.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789453445; l=1746;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=+NKZbG/1KJlWSbeUOvkQFV1a6pLHpMcLHjLyBKMpXi0=;
 b=xe/bfNQlCMnT2cl/aNbER0nOiPra6vLmQnY8yodPSaoqqY2qIk/tNrIOUx1dmdePXL8qLoYxN
 KP7WQOWMwp9AvmqftvH9Udhd/THIiAEQpXaHV75OgwayyJi5auANi9I
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|CO1PR10MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2cdd2b-87ce-4b82-296e-08df12f1f38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|4143699003|10067099003|5023799004|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: x50tbdsiVM1eR8P+jid5y1lCKHU3aX5DwtuWNJ4fHrttOsR7f7aHG4V+DJ+5J/QstopVjbMl0vA1MJ32J45+yrXnkr7mM4Gt69Dq4Nq5gqItg5513Il5Yu+FohWiZC0C4GEHihlfygDOw5yEaqArPQc0Qo2PXHJhCyp801A15a1NwXJfdbrnUt4PzrKcVPTnqhQN8wZoiHqOR46QHJSNRpXcrS7w/BKBwDMeI4/TeNo8vR8/d0wgrO+kEqL1VNzfwCFfi5WsFlnIuwo830h4Vq/jKiebN2lh8Vm8e+ja3Uxj+VySeI9n4EpnZspwFV8myJcsu2KMQMGUWkQVYozZJ8CSSp1BSSKGp7gBVVXyM5OLREMv/juHfdnuz6HP4rmwUaKAUaWSEP3/0HF4gP8ELf6IzGP33e77Ky5yL95sJLc/jQPAvsAaDn5Bl3YXBTl2T0cpU97zS67UrBuJf7RvI2YKzI0mvlU5emhfIPKH0xtrmtsGzavrMSbP/cKhfe0GpY5ozOkuX3fdVGdr7PLLDLBzvpC2Dg6AurCy8UHsrACj4uStdA/TRdJVgqlY1mKJ78CU21U0wh73K0I2FeLzpAdyNzaZvuylqkvdiEhxVNdLTY9EPXjFwUqBYuqEsgmkvpQ0xzSNJGEmIEaN9XKb7SXOdGKbXgeLjxvm66EuRF3gbhT97MYaIiLPwsBgk1M0spaffcGyznt4bhgG81aeQg==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(4143699003)(10067099003)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NxBPN1OdgnXdXxrzM06kJ9n0DxdmpWZj76QXvxVb9nqZCwSoA/QV9QU3xkmA2aZ29Gtdup+hHI9jTnkPcbeerh0+KC+61ZpGqNYio6MM+LGRL8NN0/FAfkCbZ+y3NuzLSH/GA4QaDBYI8Wzsa/jI8QenGbBiRkvAvDAE0NFnm9GDB+OvDqGa+4vnWze1YVxAlxUqI9aFgJJrnZBUlpcRTClbh5OREBIzYGMqpo842ecHjvtbuRHKlUg5hw+BRbhXe5c6zmXffcZ8kD/+iNrjdgadpZytYfKWM1ILyk08jvOcKzztbfFUJwGuwYd20dE/NYlKfhWx1DC9jGpjeNNFyyh9r+2gU5U69W2uU8l7VuLtCUaViL9z45blky0VqD8GysRIpQpwihQf8TZRu/DH0dUnZ9f/Er75UMfBMlxDln8BlwDI9h7HDae/pnKFUxgj
X-Exchange-RoutingPolicyChecked: QFmj2VydQykLmhV2bnH2pjltHFcXjY0LlV8bf7hw/f5j+W+qUp5L/W01ZA0ff4GDAqubeyaqeekVJbCJldtzQl/FVHPXQNV3VJcjZOrPJyt2BnezPGfzNPKT3z9opB38D1KWiusW89WRPdqD5M34GXa+54nRPhW5MQ9Q5KR5fUTlGPrBv59HtrR+KtncJFz9GpO0O96dYxXqHfo9XOYEl6RG+kEGTz9RvFn/R9pz5I/VLGalCtElWW1xG7CLZdmlFc8hn79HBO11AD1j1hDFoFZbKTWgIwrFIeE7moES7MeS2Hh/ok6hkuyAkNedZkkm8D203O6WYEQahN/B/l0woQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:24:09.1176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2cdd2b-87ce-4b82-296e-08df12f1f38f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4755
X-Proofpoint-GUID: OHpjiLugEujw5MCqutx1J4bVeJ9BTWCA
X-Proofpoint-ORIG-GUID: OHpjiLugEujw5MCqutx1J4bVeJ9BTWCA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA4OSBTYWx0ZWRfXzYNC/+Izswva
 lH6afokficappz8Zdy02YfU2ITrlTx5CpxghZTKSAUPgTjQThvJ9p2rfZ/grSnsql5LX1M2kZK7
 Pn9LxKBum3pPEQOGw7EAQI+KrKZ1ni+ALXcYOVRZOp9RpjpeLJV41JfMeLgE5lpI/By3TQPXWBr
 OqEIpe0THwjFCvdCTQWFJsPg4TI0hx9BhRfMx7Ah300aeBd7R/0x7u4Pj8kQU16bgojsalm+b5r
 TYfUxDItO4pjpCJPf0WJas5pkSd7FUY2cOsghW/jJKbBXqX6/wh8j/hkKmyVQ0RoPfOFfL/Czo3
 e6qk4YKOLFnXDNQVqRVSM+XkBcLJo2nWeXdV/y1Ps4Qljx+RlGtcNuWGiqoIip433B/G0JQewkm
 ZjkmrsyqJLg9v9mE6rv1cm9GfI0VDGXkOEls/S/+SKorxIT97oJA2rYrBjL+7cBMJvl/IPau2SI
 6Punfwi1z+Ltov/FTxQ==
X-Authority-Analysis: v=2.4 cv=JIyuIMKb c=1 sm=1 tr=0 ts=6aa8e48c cx=c_pps
 a=IWYRGtMsEs392uQhKf0YYg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=zggaZrLpKaXGQJQ6EuQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA4OSBTYWx0ZWRfX3Qw5IggcY6+3
 XK/PLeJNxe/s8oj+M7CWf9LvDsvWsbfT54sAeNZU85dLB7QVAt3+vBnachtmuBMJKWhuw/VD7qr
 21CvVr5OXOWbTJnPIwrCgvjzE467tlA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150089
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

On Thu, 03 Sep 2026 12:58:03 +0530, Gokul Praveen <g-praveen@ti.com> wrote:
> This fragment enables a boot mode for K3 platforms where the R5 SPL
> directly loads U-Boot proper, bypassing the A Core SPL stage
> 
> The R5 config modifies the payload filename to load tinospl.bin
> instead of tispl.bin. The A Core config updates the U-Boot load
> address to match the A Core SPL load address, allowing R5 SPL to
> load U-Boot directly from that location since A Core SPL is not
> present in this boot flow.
> 
> This reduces boot time by eliminating the A Core SPL stage.

I'm not a huge fan of adding single line config fragments, if the change really
is that trivial it should better go in the documentation or just be easily
exposed via Kconfig.

>
>
> diff --git a/configs/k3_a72_nospl.config b/configs/k3_a72_nospl.config
> new file mode 100644
> index 000000000000..7522acab950a
> --- /dev/null
> +++ b/configs/k3_a72_nospl.config
> @@ -0,0 +1 @@
> +CONFIG_TEXT_BASE=0x80080000

If I understand correctly this is done to match TFA's PRELOADED_BL33_BASE. This
is a valid approach but we could just use CONFIG_SPL_TEXT_BASE instead while
building tinospl.bin as the load address for U-Boot, check my comment on the
next patch.

>
> diff --git a/configs/k3_r5_nospl.config b/configs/k3_r5_nospl.config
> new file mode 100644
> index 000000000000..94931bf87988
> --- /dev/null
> +++ b/configs/k3_r5_nospl.config
> @@ -0,0 +1 @@
> +CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="tinospl.bin"

You could also just ask the user to rename 'tinospl.bin' to 'tispl.bin' which
would allow us to have Non-SPL boot without changing the R5 SPL.

NACKed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
