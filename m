Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07639C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A71D760842;
	Thu, 17 Sep 2026 09:02:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MegQbLZSCk2h; Thu, 17 Sep 2026 09:02:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9BA3E607CE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789635732;
	b=p6Pstva1B6QQ5NdJ+EkveHE4EjpiHgzDQkRNoMm9LekORUlRum7Kxfl+W4/Fr458IqQe
	 HE+xmW9P9+caws5eNzk+M7x7nw01b+spbeIb3S4mMirj1RDe55ICuUl53TNWb/lRGuMSy
	 +fRA28ZgffYYUvfOaYoRl69EQ3tsF1+nlY/oIZpu+wDfWs9bR9SbJAwnyfpNPadgBuLEM
	 iRWlkOzRAxNbUcrvcWeEjuOBwruh4ODPFCBHBUBlVjE2jFQ5OcVfoxLz9h79JeSD5/Qaw
	 A5nB6050/OC0s9I0KghFIWrFRiAK5jhy6fSOR4ONUytu4Yl3WcPMYpslAg/7OTbF2LA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789635732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:CC:References:Content-Language:In-Reply-To:
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
	bh=Z6Nnw+vQwgd8xMOkc5K8PpqK2rlmwliLXsCVKLgfIi4=;
	b=JJIeqJ7uvk3kH5oEMKUr7CbKHYATljk79NQ4g2mOm4DFFFIRTfIyrEALOz+Thc4fmmFG
	 19Gwgr4Q1BIWx3L2QBHhi7NBNrYh8NN7A6h/b0FFdbE7o89PHIueEOd5u9s8oUHYPdtt+
	 IMuV4F2mo8VdUg/3xTaobTqUQI8Iv9KENbqNNYTpirov5W7DFFkLXJgIHaMG7JinNfaBd
	 aJV2PH6Wbz7eqoBnrwrMk7enoRD1zo31Z9MDRyH19xW5p4LFJgia/KlIGTKUgzhDcW2At
	 l2BB68PKYcdTyBvzqmF0mVR1EGisYizFoGkJb4nTb2m7NqXzQSv7nbvTXB0iLwdwqJw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=m8e2+FSU;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789635732;
	bh=Z6Nnw+vQwgd8xMOkc5K8PpqK2rlmwliLXsCVKLgfIi4=;
	h=Date:Subject:From:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EH6Kz4/QIyoKzW826Wnno5upBhjJMoUVvmP29lBY26pbrtmgc4D3S1YotqrQBXMRJ
	 daJ0kOenvjXHAsi+T3E1kK+c5Qe9hqZgEAUIzaSX4ctvCjUCg1uw2LGIdyN5jS//Ii
	 1NTxu4PuISCUre3Urdj7vOSvCyIfeEs68hGj1+7cvNeRLpsa9+hnhJJJCTIKBxAFLR
	 K30HVMPT+S3kFeHyswFyfL5g5meQsMZ80MZD3U6/yXBG6bUsv4OQOTyNsT4OXz2fHf
	 w6ERK4ZR5jh/YQhWxqJf1zFpRBWTDSdaD/fAYVEYsaccw1Bh2+yA8OQIoNQlY9Rqdy
	 d+x2OLDmmI5Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BA3E607CE;
	Thu, 17 Sep 2026 09:02:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DBB742D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04090607CE
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:02:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WaQUvqctt4Gq for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:02:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 73765605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789635730;
 b=NFYjaqpHsslHjm8jOS7Np3lgwpi864UrEAkg/qeS48Wg7LkV8T6rI1HJTMI4V0WJa/z0
 G5KQV6+j4cz4xhd6a+jER3la+Z47EqZC1ARhEkPwB0FKG1dyihEQvxZQhhUEpGkpLTu+T
 TJZ9tRvNfr8awfZDhevCQodV2ixqsZCXPjoKT3iZd4/jtes2N0nBSprebRGpsM55FTWva
 WNH/q3rqvMq1IC9yRN3rGNluCUfz7bIXeiHoOVcweQBqSKxeL8qc421prJNn8O6DuMOQ/
 iNol9maIYyyJw2v62VNTWsIKzcPPtZ0vWMJRshUbH/FzOY8ej6fPAghC2cLpL3jKYWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789635730;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:CC:
 References:Content-Language:In-Reply-To:Content-Type:
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
 bh=Z6Nnw+vQwgd8xMOkc5K8PpqK2rlmwliLXsCVKLgfIi4=;
 b=RdpES4nKMR581gBk2qCBTf7rOsoS7VmsistWgATwGW9Jr/Lpr1XRjyDApbUh7ozXSrjb
 aLzyyqJYMQxk9tmYsCyBtk6ys3RDUuLGkkK89fD3W7yl0VaTCzwDHfuF0cpX5fcbdrueu
 DqdFENVUkxkc546Fmx8ePBWNISDRUg15VVWaiTgyuCyhRjVbLv7RvhE9Ticv9NtvA+LPi
 XWf5C3lgNr3e883elqyt10v03/8DeLBrLi/RVAukoXBzT6ZGHp+Zbq+QVzxKBuijCD6Sn
 S+UCTNIq7c8pdUof8XYK77ToQz+DSExkFb0r4Pi+oEMnE8Q/kx3SkWf99xeS6uQ5tVQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=m8e2+FSU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=m8e2+FSU
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73765605E8
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRAqLtRamN4w2UBJ4HEmCMQVZpAj2YF+GFa/UgcfEK/fDth6+a9mxOVyK/b2ur6q1WBIj+LPRIGdzoakRCE1Z1ZKoAUIVofTMeYSzybQDtFM2HMEzygnhZ+R4GUAOo5DsZL7Mnvpuk5FO84W0dhc4JZ7rcjEJRs8zzXKrGaoXgRyJBGTAi9hcCdZjj5JEqSDPVttZ91k0hmZVsMKB4Sf9xVFkyyST0Zz2MRD9QccKrm/SlTjz1Ef18aDPlq1kUnrvbRW8hz3ejYeHmSRxldASrG4uO7M5575g7E1PjWEPKviau0PvY8P1qJw8UdrkRb6PTwippjIhQENZ7drZ07E7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6Nnw+vQwgd8xMOkc5K8PpqK2rlmwliLXsCVKLgfIi4=;
 b=c2SYjooG108prYHlOQwEqSRZh/AfRRK6Pd8Axo9jE1LFWeE1C210mr8pFZk6ktTDin45jyu76OuFW89nFJe8qo22bIAcUj58SuFffJZfZrsHuR78KGlI0CBo0qtzVJKKG363TaM3xX7/kgs1fVnV6Fb3GHSxmfdZPakE5Q3GBXWPBIWZASeQbjlQ/pKSq5gjU2afk6gf48nl4FwsbQbfF3Df9dKL/v7Kr/b27eqWSQF0zHNGQ4XfmrKhL9NWMJHvlbv/fo6qsfSluBSy5ZDbjR87XeoI/b+flBpfTd5ZYZpC6N5Cny0A8iAAo8a6jVLeSmcxtxAN+USfcfcIJ9i6JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6Nnw+vQwgd8xMOkc5K8PpqK2rlmwliLXsCVKLgfIi4=;
 b=m8e2+FSUJHtZE2fltGUKNxW3Pq4Us2NUP/cKIpZiG8NDBY2mODX9c24EtUBkNYuwN9orssV65w02hiDbOeqnbBvSn0V7eZGKc/qW3lahdiK9oTMlvx9xMP92JeFjbe3nVRpx4rdGt8hSp5YoHSZ6rysgdcvdApGkjFvWw41kro39twgpZ+kJ5pSsmiokJhhcBkh4txPBu9boyuJ+Fsa1+wzOS+MW/cXZD3mVowtzmvVUgDR3PccnOgAyHSN9d/YPk+WqsWtDpM70P0IAjz8iZ71Lx8B6bZsPLcw4OlBh56Cjh/aUori8iwxtJ6yJxsFwnqtYNuzRjd2IhVEgsV6+6w==
Received: from PR1P264CA0016.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::21)
 by MI9PR10MB992185.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:b8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:02:03 +0000
Received: from MA3PEPF00000403.eurprd04.prod.outlook.com
 (2603:10a6:102:19e:cafe::21) by PR1P264CA0016.outlook.office365.com
 (2603:10a6:102:19e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MA3PEPF00000403.mail.protection.outlook.com (10.167.241.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:02:03 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 11:08:07 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 11:02:02 +0200
Message-ID: <391bec1e-c65d-4126-937d-81d49b92b6a9@foss.st.com>
Date: Thu, 17 Sep 2026 11:02:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: f_mass_storage: Optimize schedule() call
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
 <20260817-move_schedule_inside_sleep_thread-v1-2-0023194e8c47@foss.st.com>
 <87fqzltop3.fsf@kernel.org>
 <9b29dee6-5a40-43aa-bfd8-4590876b3e67@foss.st.com>
 <77c4054d-3da4-4094-9138-b8a45c491349@foss.st.com>
Content-Language: en-US
In-Reply-To: <77c4054d-3da4-4094-9138-b8a45c491349@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000403:EE_|MI9PR10MB992185:EE_
X-MS-Office365-Filtering-Correlation-Id: 32aa9776-c882-46c0-dc72-08df149a576a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|3023799007|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PEmW9H4E6K6fcO2A0xwrLLazd8XR8aWzWWhVuew8HRuoh59bZGR0cr1AMdJuYTKQkt+4MFUF3Qm0YIfjW8h4EKTKoJtIT0+FsGps+lBk10T/zleEM9MDWrDbPEowGFWwvXPyPChjEDuTm+Atb7JwonVJYvcF+DHNOFR/GzdaZVQkQtWax5IJkJy8wogZTE0QzOZ5oFaMJCrYZ9qmAitJZ6yhhmEuBcjkahRlxSEkRra0vVL/j5NhH/6g+VnsPd4o0Fkq6Vtg6oPCcrpeNLpOJ/Wpxngpx2GgUREnpBolZZg/72jBct0Jt8KTPtqip9bZTMKOkmnxDVKddYMafJCv2A4T+HXPD9h+CU6sPg9p5rX4zpLspEMbBfhxtt1Jc5sDk6ZiakeN13LMmLHv0tQO12/C0HMtAL6fzWekAJoEcKNF0SCK8w5sNNbXdL/kxSBkXhicwEj9kerlJqfgwqEH/YItVimr2RZwA0JaVz7UHZ8/nJ9RYbyUbIctGS/aBpe4fY3OTbgHzThb7R9VeeCi0XLzjqQih1t7MuaNEepdPrRMZfpdsYJr+TBmPF8+oy6+UpFPEiVL75Yf8+MUfQ44R4r/glPYipVXUD7FE9LdWAnSsKfT97iQkkoKk8pl/Z6Dn0NGTMYkuuriHpruQ/N73p/zeoh2rUnpxmdWwHjgrWOkELntgF3lXx85KCLKStT8VWTT4Mxn880btoXo3oeczA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(3023799007)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jAiA7EcR6dLJ7/3XeyW6Apg0tCgZdMbmhvFg2AaQTwA6x/zMB7vRxp9tHiCsxDnCv8Tavp8pPLUD+Kq0x6jnlJ59SwwFE5Bq7/V6LAABB4BKsg1sck2mQ5DoAh9z8MQZDAKBX3KXFQWKugz09FmSCHp/vWv3kmmt6r4TRpR2ahoikBRlDHBIAJNJIUtLlSaz1fRObJj19v6QSRDo9ROZ9pk079f6f+/hpOSRnqA6oCV+BpjpJOdcoTv/PHOKo4mQcGiS9Dz1V7Q8AHZ6d/jILzkPzrPJCQ3oCdiB5mfk5VIcBFqzyX0YefH3vdtgF6rMjxH8j7Aaf3CkFSCsV2DdnD27YtRs98n/2bdav+bmSJgmj/AtKZGUk/iZgoRMhd9+kebCe2g4TA9soCce2Lyw2K1q8iSdfFZI1Dv2BUxF9HL1j0kFKT5iGSX/jWPCLekk
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:02:03.2751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32aa9776-c882-46c0-dc72-08df149a576a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000403.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992185
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



On 9/17/26 10:43, Patrice CHOTARD wrote:
> 
> 
> On 9/11/26 14:38, Patrice CHOTARD wrote:
>>
>>
>> On 9/7/26 11:07, Mattijs Korpershoek wrote:
>>> Hi Patrice,
>>>
>>> Thank you for the patch and sorry for the review delays.
>>>
>>> On Mon, Aug 17, 2026 at 17:41, Patrice Chotard <patrice.chotard@foss.st.com> wrote:
>>>
>>>> schedule was added in sleep_thread() by commit 4b6a3e860878
>>>> ("usb: gadget: f_mass_storage: Add schedule() in sleep_thread()").
>>>> to ensure that watchdog is still reset periodically even on platform
>>>> that doesn't implement g_dnl_board_usb_cable_connected() and in case USB
>>>> cable is not connected.
>>>>
>>>> Instead of calling schedule() for each for() loop iteration, call
>>>> schedule() only in case g_dnl_board_usb_cable_connected() is not
>>>> overloaded, in this particular case, g_dnl_board_usb_cable_connected()'s
>>>> return value is -EOPNOTSUPP.
>>>>
>>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>> ---
>>>>  drivers/usb/gadget/f_mass_storage.c | 7 +++++--
>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
>>>> index 621852080e2..f467693d2cb 100644
>>>> --- a/drivers/usb/gadget/f_mass_storage.c
>>>> +++ b/drivers/usb/gadget/f_mass_storage.c
>>>> @@ -651,6 +651,7 @@ static void busy_indicator(void)
>>>>  static int sleep_thread(struct fsg_common *common)
>>>>  {
>>>>  	int i = 0, k = 0;
>>>> +	int ret;
>>>>  
>>>>  	/* Wait until a signal arrives or we are woken up */
>>>>  	for (;;) {
>>>> @@ -673,13 +674,15 @@ static int sleep_thread(struct fsg_common *common)
>>>>  				return -EPIPE;
>>>>  
>>>>  			/* Check cable connection */
>>>> -			if (!g_dnl_board_usb_cable_connected())
>>>> +			ret = g_dnl_board_usb_cable_connected();
>>>> +			if (!ret)
>>>>  				return -EIO;
>>>> +			if (ret == -EOPNOTSUPP)
>>>> +				schedule();
>>>
>>> What happens on boards that override g_dnl_board_usb_cable_connected()
>>> that return a positive value?
>>>
>>> Per my understanding, schedule() will never be called, and the watchdog
>>> will be triggered at some point, no?
>>
>> Hi Mattijs,
>>
>> In case g_dnl_board_usb_cable_connected() returns 1 (it's currently the case 
>> on STM32MP157c-DK2 board), we stay inside sleep_thread() for(;;) loop until 
>> common->thread_wakeup_needed is set to 1 by wakeup_thread(). 
>>
>> wakeup_thread() is called periodically (around every second, it was what i observed 
>> during testing) by either bulk_out_complete() or bulk_in_complete().
>>
>> Then we came back in fsg_main_thread() which was sleep_thread() caller, 
>> and came back in while(1) loop of do_usb_mass_storage() where schedule() is called.
>>
>> So watchdog is reset periodically.
>>
>> Patrice
>>>
>>>>  
>>>>  			k = 0;
>>>>  		}
>>>>  
>>>> -		schedule();
>>>>  		dm_usb_gadget_handle_interrupts(udcdev);
>>>>  	}
>>>>  	common->thread_wakeup_needed = 0;
>>>>
>>>> -- 
>>>> 2.43.0
>>
> Hi Mattijs
> 
> We got a discussion with Marek on the previous version of this patch [1].
> Marek's proposal is more simple/efficient than this current patch.
> 
> This patch will be abandoned.
> 
> Thanks 
> Patrice
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com/

For information

I submitted Marek's proposal: https://patchwork.ozlabs.org/project/uboot/patch/20260917-ums_increase_ctrl-c_responsiveness-v1-1-95305f044ec2@foss.st.com/

Thanks
Patrice 
