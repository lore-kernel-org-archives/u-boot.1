Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931C606A330
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dQcKZ23u;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TL79+h3d;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=MhTmmRYI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8688680CBD;
	Wed, 25 Nov 2026 15:32:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 08i9Vkfz_s45; Wed, 25 Nov 2026 15:32:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A84AC80CB9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795620749;
	b=Mr406ijb1OCeTJUGUlPx7+LO5N+mybsx13zkTz80Veh/Qc/4oEsub6lEk/0RJQqXX6R4
	 3TaWLWEDJt44XESj/T+UJPXb02w2rv9kQdMyirvOxsCpI4BjJbaKxF2fw/vwPj9HdwTXp
	 5COPU4jZh/BkAmbUq9uMgZt59cdcRiyLBEy4QvVcgtgwmI78WTqH9DsifjtW7JJDh8z1K
	 2IyuG7XjLZ/5lxXfWsRVXGS6aPl51Zo/lTyFJFX/M14XGrRoxPHO0aDv6ktr7xRnL7pw0
	 BSdrLSvzU6x3eXyfR2KEJI1y8qCiYtsFrrdXsU5iwaii1kCkMPT1eWDgHHafdQp2cow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795620749;
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RApj11pV6s/Zs43HzrLGDkNF+PGLnie9zIlG/mcaAVw=;
	b=lOs9kfY/QsQgj0myEen+RjLk045oOdiU9Z8hAf6qlUvTT2dm+Wk/Ct1H2RzuWwlk4qAP
	 qx2CKQLzL6sBDBo10LZQjWIV7Bl0QRKUAsdQERReuREyDQG4NVn8kUxZANl+rCK5kvAHV
	 otBVytriGm9DYvSi0AwRuNWy99MyZClng67QN07yjZ82twmPlx7tmRhlP/BhKhJUMHHV6
	 N0D5Q9IDx2BcK8dMhv/2oGhYZ1KAzJsSjkN/AOwYFUnOi/EAH4ABWS3MchUw89tBn7jIK
	 O+dyJOpNqQ0LC9eafTDHuOrfEEmBJ5cSBgb8LjCZuv7tFvT9+BEEl7b74ISOQegYzyA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795620749;
	bh=RApj11pV6s/Zs43HzrLGDkNF+PGLnie9zIlG/mcaAVw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQcKZ23u1HNA9ZYDmSrhDwjzKguJoUR1EOVpXXxrGbvUPFomtmidKcHRC1KVpabcL
	 4suogAdot4qeFxLWqm4r/WSC+REqvEyG3SYRlwlAJkznJaHaZF6PgLI3cKAikemNcF
	 8krLfWl3PXVLpG98HrXJbRPJHtVXAY09lSKeHvLtmuwmV+Z30q7r3utpuEBmj4bTfd
	 +JuOQk6+p+F6xz5NpsoZYlFqYaLQ0uLzR++Mzj5NlKRcP1dnpw7KB4D3xVvoH5Nyuw
	 3b0uHpV/4a/2L4Uu1Jlz6SKqHC536OGZ8owGcqTDZ3pAt6FMAl0UXFcxL6zePohSb+
	 PiY9c96lx0lJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A84AC80CB9;
	Wed, 25 Nov 2026 15:32:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DDCF1C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:32:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 035D4400E6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:32:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cG6ldtfpyHRN for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 15:32:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1C680400CB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=gehariprasath@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TL79+h3d; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=MhTmmRYI
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C680400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:32:25 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APEKrH41417364; Wed, 25 Nov 2026 09:32:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=RApj11pV6s/Zs43HzrLGDkNF+PGLnie9zIlG/mcaA
 Vw=; b=TL79+h3dYwgEReugXwOSWO2yO4FKN+6rr0XBn2bEvbWHJr6uIn1/+LXaF
 woy8s6+3OyIU4zpT4Bnm9xNWueLDg0MELdRsHvkRRA6oiwtgMuIJOganNHfSEAFE
 ND+FkW+o4TTozatAASAU5JUZcTQbQg8CZzWpRP6oPwJZcDT2dEaKnL3zdU8I5MIX
 9hKDcedg6YHi0g0TUgi/fyYBFn+OA8rqk1tOzGBNLYz3iWhE0iMNrnfvdcGr8ufg
 nSgGuvnCsqlHC5b9v/K/n+b8d/D4NZwNQqJ4ISm+oTWmR1FVlThx2S2uNV57dL4e
 frVM/qyfxJq4WkWO8OxlumHwn4plw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j5v3ba37v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 25 Nov 2026 09:32:24 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RApj11pV6s/Zs43HzrLGDkNF+PGLnie9zIlG/mcaAVw=;
 b=MhTmmRYICYI+NgXg1QYZeyCdyKTxu1QtOM8dwe0B6psqCMQTzcEFzdytKktIs80k2Nfq8a6SMRpDcXpoPJdxQMqQicD07KEBrbkSZHrq7bVFcvCPgeEss77u2wxeyANDgLLzUkJBuwwU2kWH0OrvOm5Tbhry3pjImkcW/leKgCA=
Received: from MW3PR06CA0013.namprd06.prod.outlook.com (2603:10b6:303:2a::18)
 by SA2PR10MB4474.namprd10.prod.outlook.com (2603:10b6:806:11b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 15:32:20 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::21) by MW3PR06CA0013.outlook.office365.com
 (2603:10b6:303:2a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 15:32:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 15:32:20 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 25 Nov
 2026 09:31:55 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 25 Nov
 2026 09:31:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 25 Nov 2026 09:31:46 -0600
Received: from [10.249.138.105] ([10.249.138.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6APFVhXF4004403;
 Wed, 25 Nov 2026 09:31:44 -0600
Message-ID: <7dd6cbc5-4a47-4c0d-9b44-72f78cc1758c@ti.com>
Date: Wed, 25 Nov 2026 21:01:43 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j784s4-r5: Fix FSS range for OSPI1
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
References: <20261124081525.1719157-1-m-shah@ti.com>
Content-Language: en-US
From: Hari Prasath G E <gehariprasath@ti.com>
In-Reply-To: <20261124081525.1719157-1-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|SA2PR10MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: bba873a4-742d-41ba-c856-08df4b094bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|260925021311599003|260925022911599003|260925021911599003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: ax6T26Qyug82V6jG8rPwdArzbFvqXZGOTQ/kSL+dCchIFE+XSp7tWgooowDBsw8QZBT1qFQsgMgkMoKMZj5dALJsrRW2/Dw5AJ9tpLLM7ttbsTY0S1Y8JAgaJ2/TPoV0haKpRut838BXr1khDaGhtk+7mCjzPgul/ucIHEsOmxQveADqpchhT/2oEorD3/0b3QlXrqWQtvzZoqEV2fcy7ViKwb1GcCy/oVEHAjPW0tN1nktnm31tNN/YED0PI5lSZpqgiA2d2BnHbhiWybqLVN53eLU2NrIMECNa4goCt6nwUbzqbH3wm0S9rv0FDJu5jBke/JGnyzqjt6VPhjEkJvDJ70Fft4jMwRXkTr9KZNfR9DoK9vs5ra20Bqy/gJ5swEIPqasFh//oQ+1n3lSBt2o9TvQ/Ko955yrm0OYpAs+R21bgbrQm9KUjpH0K9F0doUOWesBxUVeNwBTztroV83lQiDTGAB611COFRkiZ9sk5RUahYBrFL56bXCTB15awCpn4nzyNH2bsZSP9J1hmXMl2N1BwgYB06HXqZ9n5S+PUjneIFR5qPo1e2B89Q/aa1+lwzc6r4gmMBQS0cVoLjZJuSIim7UE22L8LQMKdcc49VRWkCZvxVZhtqbAl2Wk4JOFdoYEURqWVmjW30aTDUkZqkS23UWjwMBW5Fa45LE29vQUjGG3c0dpe0rfQXWQs6Fjz6sQJaldOR0aNW9S7Yw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M4fC5cAfG+PRNnIa0l3ej1qaml0NzGbyYLaqhXn6pQc4ZI0EVj7Wkd8XQfjHPaXaEXfg6iG8gMYE7g+ZTljgVVcUU5+lSnyWvhy4/wjsDlxSqvrAjr9DTGJrpCrA8o4auiKgrXna3MyQZcRjIVQiSNkHVflWBsq1W2m/98nMd2fuIg0/M3p03zxqGzoll01tc7/UYqGMYb/coMTZTeKUnioJw0ZjfxO9DGMYg9dzPIKLd6jriUwqLY931hvAic7Ab76L0L/y69I2jNyNMuZ86cz7Hjd0Nkiz4Z8EmZvI6fZXEh7fnNc0Ugn57y7P0xz1g8itV5lK6joSa+MPwhcosUwbVC7q/uTMOsFUZoQDb93HsPAm1uskxMK9d7pqWo1XNcU29SPU10/RAHP/3989UQop3FfSVI4ipGIKLzCykJShX5B41jOyRbcRRLStnP9G
X-Exchange-RoutingPolicyChecked: VzWcyhzZ0Wjm98eG9Epuyoepg9732CCr/xEhYDJwY2uhfGg4UbW8jWWW45D5wQbNs5Fiy4ROOKCkSYyCSlCZZJpsMRRxigqHQdVMzAGZKWrCsu4UqcA6qpVQ6eDI6OIzLrFVPtE3yRinGmRshUGB//lJF2KairX61zdDURpxKjvoHLZV1Zz0BftIQMhcAk0N2PR3kSu/soSbvUv3JHXU1SJakiqWp/lEn29IewtSuoyVQKzSjPIqSY+RKpglgyT3xFTR1y6cUUVW7laP65nelGkJ099QnxV5ttQYL+KdleZW59byFe5C5vkJcAfRoCFhZd6eTbTbt0y8EMCIzdRYuQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 15:32:20.4980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba873a4-742d-41ba-c856-08df4b094bab
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4474
X-Proofpoint-ORIG-GUID: 9vokrSp9eZvcbPUraUgozlQ4PS9GVj3-
X-Authority-Analysis: v=2.4 cv=TPrQ2Fla c=1 sm=1 tr=0 ts=6b06ff88 cx=c_pps
 a=cXHsTeABgwIgPhuKzetQTw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8
 a=sozttTNsAAAA:8 a=teNHpaB2pTR_vls7laYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX6WeM1mAYWFGw
 sA7X8nNafD2ccAynA9oM3AH/bl3riM3M6b++Jb+lT0qqWynhNEk63cUoNyeItiEf+58YYhiOuDK
 fWAf6NZ7mOu0L1BQeoNspL/5XyCuBBpAb6zx+s8kXcphjQqJysMwz3zqk03VFBptPp3rudaaZ5Q
 8I5WFo3++eri7rCQSjsBeK2Iawdx8a1jkfDq4zpotmBzXAODdmS+3U4/Qs/Twk5WQjCiOjCO5oZ
 aE0YHYxibB9DQi3Vp+1czzcQE+FO+Rh4VW89PYSmCRhP1siBPi3wExGLRBirblKAC2OUmrN6St5
 uc+sd/ZtbjJizrW+Aypoxg/17V2gikm42HGqwL3/A0htnrrINX7LB3aBNv1clJtB58yzoKWMAj4
 XfNeQsVGAB0iWPltiI6Cy3aTa7W2bzg79N+fD4qi0JZpQSlhkWBLppTrbYJEzlW984SHLCwZpbP
 HW31fUg0UAZOALXfN1w==
X-Proofpoint-GUID: 9vokrSp9eZvcbPUraUgozlQ4PS9GVj3-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MSBTYWx0ZWRfX7mvkMTNBHazT
 OUJizXIyu2+7n8Ho80q2Xi+YVI7K14EtjcRzd4RkPqNpIqRzVBQkWcEqzooGyh1phLox9uOiUig
 S1molkJxBhb/ko4bf/0h15FZ3LXO4LI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250061
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey Moteen,

On 11/24/2026 1:45 PM, Moteen Shah wrote:
> The R5 FSS ranges override covers only 128 MiB of the FSS data region,
> ending at 0x57ffffff. The OSPI1 data window starts at 0x58000000, so
> translating its address fails and the Cadence QSPI probe returns
> -EINVAL. SPL then cannot boot from QSPI and reports "Invalid bus 1".
> 
> Widen the range to 256 MiB so that it covers both OSPI0 and OSPI1.
> 
> Fixes: 9151844547c8 ("arch: arm: dts: k3-j784s4-r5-evm: Add missing fss range")
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
> Bootlogs: https://gist.github.com/Jamm02/96d884c47b0a589d168aac8fa7b90a10
> 

Thanks for addressing this.

Reviewed-by: Hari Prasath Gujulan Elango <gehariprasath@ti.com>

Regards,
Hari

>   arch/arm/dts/k3-j784s4-r5.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/k3-j784s4-r5.dtsi b/arch/arm/dts/k3-j784s4-r5.dtsi
> index afbb8faca44..8bad08bd423 100644
> --- a/arch/arm/dts/k3-j784s4-r5.dtsi
> +++ b/arch/arm/dts/k3-j784s4-r5.dtsi
> @@ -103,7 +103,7 @@
>   &fss {
>   	/* enable ranges missing from the FSS node */
>   	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
> -		 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
> +		 <0x0 0x50000000 0x0 0x50000000 0x0 0x10000000>;
>   };
>   
>   &mcu_ringacc {

