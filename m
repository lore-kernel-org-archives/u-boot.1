Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6412FC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 12:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4249940B05;
	Thu,  3 Sep 2026 12:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jlq6dhXOy0zP; Thu,  3 Sep 2026 12:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5966140AEF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788439863;
	b=J56IDCgip9GrkxCQBq3kFWkBEI+tJHVfQWlKBOgwAKYXEuTjeNLnoRQQGNRLPokjB87E
	 bwuOOaW304Bz5E+4e+1kYeA3C2X4mWCecDxlQ5xfPyzqSQpwXNV1DymkeZL6kKb1VFgs9
	 Z87ESqJfUpZIDV1q+SWHpzn9yfdiD0RhhmEO1a+Lc+SN+D/L9xA/XRf98EmGekEgYw0RI
	 XmB9K6GjrK52wYgxl5HC82Dot2q6NRQ4WWt26Ixks2yEjd648uKwuNTDqH71VpixtYk9K
	 2ofA7hwDMcLUDS7ecMuYHzUFco5vWilodXxXbdYXti1zyUNVulLy2tIuK2r1BqXvYvg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788439863;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4duFJIAIGVVhclkDDYyFB/kiL2S8rmkT+7Lc0zIoOgI=;
	b=lygh1DH63y1KMWsGMYdiCWfphaSnzjozKeeDCHGJu+cnC524qcPLUsxKtAWruVwBkHZy
	 U3NTkgXCiDvHrcBR2R+w5D8Ezo5Ed00U8wYKRUbF9rIUkK427xqn/HB/uBIW7UA0o2arQ
	 NdzwnRQunqWuFzrukUDgDHc3IzMEuooC8jimvxhTcV7erOFiyYYFuDLb/gj4qNAnD2wtJ
	 49Flow1M3jkP6zdlol4fIDEi9j75ynPNz9zEbp9lQiCQUp+45bhrMbEneL3FmCzYPchMW
	 CM2ZWCLnxuA7i+Pe+9qJbRUW4ID9Kthxb2OWlrnmhviXYWsQHYHr5DG3WtnSsD+7CbQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788439863;
	bh=4duFJIAIGVVhclkDDYyFB/kiL2S8rmkT+7Lc0zIoOgI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0NBbOuJrdob8ue+iXVxseckb9H+Mxm+UNghb4o+wVy8MOFm9YKIC6jEN7efapd0IB
	 hlFdXB9lULbDj8fSzqLegC6a4qKFjHRy/5EOKJEx38Odfu5mlNRm9SUoUSWMSiFmMc
	 /8Iy8Of+q7M6A2hDm3nIxZ6RY91EMmqAb4AOS8elOLcjSHXQV3BB2NKUk5748GeYPJ
	 S5i6efEFsxXyWgAazGvjMeIUMNgvrWYKSURwDTRoqb+MPmVto7ewwjfJ+cf/uu1jW2
	 WIwOHiJnBM84wwCefjLG20k3zcl+xYVshvB0uJ8WFlQpFKaXElt5QTptXz9PLaoQdH
	 0KXXx49Tf1d5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5966140AEF;
	Thu,  3 Sep 2026 12:51:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 01619498
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 06:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2A4160861
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 06:42:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wc4xDZ5f5j7R for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 06:42:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9126E6081D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788417768;
 b=LiHmvTp1JmH2zmhn0FbTRjM1nuNKYyxhTvYwnqDvKPOWQ22+3pMwiF2C6kNjHSydifgK
 ZDCvjUN8Nf/oJIbO71BHnyx7DshwYYMxJWRdIEFKBGJtkRX9tZTv/m9tvKz5wilFkj6cn
 buXwxUGwNTNa/2WuPPGwAhAI00WGOMHf2PTwLYc5ff6ULeb9hcyltNHTy0BOb5l6FpeAf
 tFy/BBp8L/g5riHZQ3e6qF6T9Up1rBrLaHyBFo8CI1DQ0jysuV3FFgmxoI4ZplOwmfCry
 3X+yil+UBCjZtyvhUL6uxm3etBRCF9SOO6jIW73mfyBrxU2fKXYHskOTKtyf53rRhng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788417768;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=4duFJIAIGVVhclkDDYyFB/kiL2S8rmkT+7Lc0zIoOgI=;
 b=X2bMgStG+YmOiUxfVNRlZP6j/P23ChhleH0xRQ17IdrEoqf2df6FA0Eru64w/gxl5ivy
 u6uXPK7dBXN33osLenpmyxSpFU3eUjCG2Ozj/aNiBYFIUb6c+2gKDFgmuiwzi4Hh3Eo40
 FDNGP8lvLHGqkdVE6FTmgyLwvGM/tPr4eb5zCLb0VTq7Sz2vr2LNYrlzNKr4dHGFxjY+z
 hb/Rr2Vrbuy2jmd+AsRei5BlXZJL+LWqFTkS4rRCHHI5UMnv1Mpbv84lBy6uB11tqJWaT
 lx8Dz4tdd6BJx+gQewulzAqM4hHRvaFVycUc5OiSybXprnacpBAHtbtn+C0J6iJ31AQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=DxbLxyRW; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=iaRkCCZf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=DxbLxyRW; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=iaRkCCZf
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9126E6081D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 06:42:47 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6835jQtH137314;
 Thu, 3 Sep 2026 01:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=4duFJIAIGVVhclkDDYyFB/kiL2S8rmkT+7Lc0zIoO
 gI=; b=DxbLxyRWmgUm+1mG43ZJihfYbG5pct+QA4i+O4UHL0Wg5EEiUlSp23N5F
 X8asLs5VnjcO9DX1pBg7war/r6KpRHN7Esg6lKRvdwrhLSk83JdOR7TxTQRXdSaD
 O5C1JzdGMn4M8GSD8pbspONy0aai0bWc2B25hxCxrCUTOOJfHBmC3YJTJh4vVQZ9
 irQDMxcyPk2XT86rWITiW88iAm6CmsX0v4yWcFZwgD5ni3uwC90Zx1T/8BlPJYhd
 YPhTCvw+HtxtO92572Tzw58GN6JeeqDstuKT/RLxbvQ44BGDS7cXc40cpsHWpaS7
 woDO5PuR01NR2qCHn/kvQLVWm8Kzg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gewt8hvd7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 01:42:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wa3Yr73M0vxvxUjMys8Cm1QbQv/x9liCZv9opau00di6SUW/BwyuXsrW16In8Hguc6T25FcQIdoqUfUlfAL/VumOHo95oQ1K0lWkOFtAUYBu45hIEfTht2p8b2LuL8iah/aoX/R5cM/htejmZ66F6C9mJy6u9zYyKUJ/yTcmnllUR6DFW0LuM4OQHoIiSKqCRMPz5TFp6WqNxEQyAC1L/nJoKiSQ/mQDFjRxSRhwqdOIk99PVthxErriGmK9nCKQEohnv62kwFa6iOP/uw/QkuiTCiMrVzYHeYb/B95k5U9X766stCoOUg6jXgZnpCx59T5JACzzLblgk1p7feLeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4duFJIAIGVVhclkDDYyFB/kiL2S8rmkT+7Lc0zIoOgI=;
 b=uj4S0Kd/1khmLRPtJLOdxZ/tNc+EQcO6P1zQsSE6PUDcBz5Y96P1j/FVbUNfyAoDraQwuphM2dcQ+J9A1SlpJ1Ox2vF76y+3jtwrlD98XbXA5DqfylcWqsnCKPNzjqq+IPALN0bnzXBqbCSCtr8WZQZGJyMCvaarOFYGIxwHiuRwR93IYzuJfOZYRZGWTpUTU6GoAJlIMV/Il/RcDV+olvs3r82u3FaB4D34rj9ihJkrUdH0bHnbyh1zKTno9RjcZr2ws8f6BqcpqxSz4sLZQr8QvbBBdgZU3LWnm3HfOKJDNd5ydLF+GqeWSx/Cle3gUo5gnuwxh4pj7sYCC1aaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4duFJIAIGVVhclkDDYyFB/kiL2S8rmkT+7Lc0zIoOgI=;
 b=iaRkCCZfj1XhoKsc843ogCQQ+oZdLXhSEF5EMRMZcxl+eFIZkLonOZq82CqXuVQQOEhH0nXbIu3+GC0VvhY5MkftSuJJT0xAETaUyTxROANME1QWL+FGdcCF46/rXydFbe8WX8qzVuSZ6P/1QpAxLO5P7dWlf89q6uvPM8Ocm5A=
Received: from SJ0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:a03:3a0::9)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 06:42:41 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::c) by SJ0PR03CA0244.outlook.office365.com
 (2603:10b6:a03:3a0::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 06:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 06:42:39 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 01:41:57 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 01:41:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 01:41:57 -0500
Received: from [10.24.51.66]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.51.66])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6836fsJh2080420;
 Thu, 3 Sep 2026 01:41:55 -0500
Message-ID: <f3f747d5-805a-4b3b-a90a-e6e30923bef3@ti.com>
Date: Thu, 3 Sep 2026 12:11:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] A-core no-SPL Boot Support
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <a-nandan@ti.com>,
 <u-boot@lists.u-boot-project.org>, Gokul Praveen <g-praveen@ti.com>
References: <20260819101910.39192-1-g-praveen@ti.com>
 <20260901162303.ccuk2gvcoogftjmy@bryanbrattlof.com>
 <a53e3b29-8025-4067-8233-385ec3295696@ti.com>
 <20260902134504.wayifwb3liu3d7pl@bryanbrattlof.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260902134504.wayifwb3liu3d7pl@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SJ0PR10MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: b79ec28b-0fe6-4da4-af87-08df09868c84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|13003099007|56012099006|10067099003|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: XcpUJgA8J6P8Bb+oKi2RE0lS1u0OLfSP7+QHx1RwoQBLMAF2npT+yWhwo8KT7z2EbYDH4RCEvFYkCncT8cRXMoV3ro30ArewuQjUfdWuTSfS9iwTbTV8q5rD2IbhCD6qQAHC37up6Qomh84L62Q78aXrrjtLPTa8+RV+EpKaHmyQQjUr/KpmugKFE9M/k0dy++o3GDxWzSZqyULhX0jOgp5mlAubP0r+Nf05V1suTMhbSqzWmuvcurPeJrJTXOvIITIsP46y8VmH61sKGBHE5V2bUfj7FiHVizrgZ5PByOwdTT0h9E4aUy256z96sXirpi8YQ0OrvR/AX1wKUM2YoRarLuyiF0OO39fAyis7sHRUktCDkmyD5LXySeWFcHiuRYFCuuTjQc7wN52KV/NZbbBZDsLhpLXN1fduKYTLsg6sKrcXLLZ7TfoccJRSGCjJ88IiPYS/NVWA07+mI9RRWAzwzmcoBysoB7ubAwokJEr18gGLCH/p2nsbMG9PHxg9hT9FcUD3c2SgxaD3/oM2dWkmT9QXqwxhoPZrNjZWHhOG+I6Gvv74CANSiEQcu7Q1dEldBWBijr5VygBWeh4KhesQN65bJ0Ig6A4ckwkw/G3kfiaQ1roJMUKQEU2nMpM3+mPE4p0VW3O+di67GktflSNicucpDEzUZI2+W6i7/wbkGDqzZReT7jNBRVBEQ+qi+DnuzWgzSbNO8dJ2ks4LOg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(13003099007)(56012099006)(10067099003)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CK/jPMozdmTyD6Lb+6XBm09he4wGnUc0oQG6ViAcTYT2ZEfB127m/khHykIw9vplUwZxKsnLqqHNyKgzCin6ucvImCt/WvnUSqEnDCfVLHpI7BsnHn06a+9us0yso/htQrmhXcLqFWgLVxtM1kquf+bbupsyqiMYJHBwlm/rxRtAYeUBQqbV3BnJQU4Nc6guK6af+tBobiDRG2Z4YYcVHFDUUNuUG3MgW/E61MqqtxTf4IjFxepvuIch04AOPSlOezwxlq63pJ9tmyNyBajs7ZG7jA6qUwGKoS3JBkdlwQRmsDstlJ7zqv5ZqnbrlbihG/jrOULfrHxXh4qI0meimJFJ/t+9UZDUyjfcjqY06lNJqt7cTwk84G2AinFpbY/ltosMhzrWkgzry6WXJc03gh6JfyVRikwvqJ6zKYe2XlHSsUhYTXgjtTLBogsG1ACU
X-Exchange-RoutingPolicyChecked: NraXiy2JG6qs2WIAdoQX4dpI/v8ZZBjaEGVR5kT4IwpbqMi2bCk1tzUTRFdba1mekVOgDNtGvuxjkM35dID1UsTRVgoPoK9Fq859b7h2nkvEsGN+DeX0z4Az92Wy7BPwGomGQZysb8HKoxS9iKK64uJD1E+LwZ4JrIQENdCjpfMLlD0bFQYnHaCKuP/BwHNqmfgdTol5Cdvdig8k5E8mYzN+wWiBgdDnYn7bldDzVsD559YyXmWew92upB4BYD9z2mD+mEMiQh3ldN0WN3PPkpe5SaXMoUpgMExdelHNgnZQkah6Pvj2RR0pK44pOZAxkpiR7bDzSr+LHv2GeF8Wvg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 06:42:39.6381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79ec28b-0fe6-4da4-af87-08df09868c84
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Authority-Analysis: v=2.4 cv=de+wG3Xe c=1 sm=1 tr=0 ts=6a9916e4 cx=c_pps
 a=IzBZuH+2DL2Wyeknq0uBXA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=2PEmM9_SpxaWMda0OLIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uFpjHUdVKHo7bYGlALx5WbwwF5ncxLpM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA1OCBTYWx0ZWRfX6y0aDL0TyO9p
 kdAEPHndOd0ELGf3ZX2uBNJXQnn5TyikkYqogmA1U0TL14qCdDbKQZlTdz9OGwY0ZvbfB4sBFw7
 9IEVtGLdr0xNsMslzWucqb9m0Zihvfk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA1OCBTYWx0ZWRfX+6jBP3hc8D0/
 12qIBaz8t6tl1cnfAB6BdqaJP6FXZB38l1M10g0Ty0AdhhCLFpyd5I+pi2ivg1zAXxMjHkKb5Mt
 XAd4oioecAJ2vi9Z10OqLFPkQZ8Ee9bf2ZHIABsjnXFsMgBmZfPu/1w4OTUOQ+avV6nm4W1tUHm
 BgmYl808tx3dwBIy7JrVRwQQe0LiKABzopUhuOU9ldjXAcHInAJq8ik46ekgLVQbUJv5prPSfjU
 Xd4bo5z7zUmVom28sw/PQbpBMY1nCXGq7R0AIhNzQZhjN+lShEPx63OtNJPdcVykpTEFVqx53vj
 CQ3wJg6fhE0kY4GgEPJcCdyxDeO/eXGEMCqGgey+rjNEdqCaTaF2aC/Un6a8qX4EcGzr9SuIEhx
 lT6fT3nyYbNoH3TOhKC/FJZobFrJgf2c1OjZAZuvRjBnSxEgY9bkgbLvITnF4O4lLPHWiemunNI
 +RLZDqde+KcuSnVI8cw==
X-Proofpoint-GUID: uFpjHUdVKHo7bYGlALx5WbwwF5ncxLpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030058
X-Mailman-Approved-At: Thu, 03 Sep 2026 12:50:58 +0000
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

Hi Bryan.

On 02/09/26 19:15, Bryan Brattlof wrote:
> On September  2, 2026 thus sayeth Gokul Praveen:
>> Hi Bryan,
>>
>> On 01/09/26 21:53, Bryan Brattlof wrote:
>>> On August 19, 2026 thus sayeth Gokul Praveen:
>>>> A-Core no-SPL Mode is a boot approach that bypasses
>>>> the A Core SPL while retaining U-Boot in the boot flow.
>>>> This mode provides faster boot times compared to normal boot
>>>> while maintaining U-Boot's flexibility for kernel loading
>>>> and system configuration..
>>>>
>>>> v3<==> v2
>>>> ===========
>>>> * Updated the naming convention used from "no-spl" to "A-core no-spl" to
>>>> * make it more specific and clear..
>>>> * Link to v2:https://lore.kernel.org/all/20260818115322.101705-1-g-praveen@ti.com/
>>>>
>>>> v2<==> v1
>>>> ===========
>>>> * Updated the naming convention used from "semi-falcon" to "no-spl".
>>>> * Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/
>>>>
>>>> Boot logs link :
>>>> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
>>>>
>>>> Gokul Praveen (3):
>>>>     configs: add A-core no-SPL mode fragment for k3 devices
>>>>     arm: k3-binman: add tinospl.bin for direct U-Boot boot
>>>>     doc: ti: document A Core no-SPL boot mode for J784S4 EVM
>>>>
>>>>    Makefile                               |   2 +-
>>>>    arch/arm/dts/k3-binman.dtsi            |  47 ++++++++
>>>>    arch/arm/dts/k3-j784s4-binman.dtsi     |  65 +++++++++++
>>>>    arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  14 +++
>>>>    configs/k3_a72_nospl.config            |   1 +
>>>>    configs/k3_r5_nospl.config             |   1 +
>>> Please make sure to update the board/ti/*/MAINTAINERS entries for these
>>> config fragments.
>> Got it, do you recommend creating a separate MAINTAINERS folder
>>
>> in the board/ti folder and adding my name under some TI BOOTFLOWS heading
>> with subheading as
>>
>> A-Core no-SPL mode or do you instead  recommend adding TI BOOTFLOWS heading
>> with subheading as
>>
>> A-Core no-SPL mode inside all the board/ti/*/MAINTAINERS files.
> As long as one board has it covered we should be good. Because this
> looks to only be for the J784S4-EVM I would suggest adding them to the
> EVM block inside board/ti/j784s4/MAINTAINERS

Sure , I will do that. Can you also put a "reviewed by" if possible

so that I can add that while sending the v4 patch.

Regards

Gokul Praveen

>
> ~Bryan
