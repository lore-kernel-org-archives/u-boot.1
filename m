Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF78C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 19:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 773BD80E11;
	Wed, 29 Jul 2026 19:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sftgSsY8FLRh; Wed, 29 Jul 2026 19:51:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BCC880E3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785354714;
	bh=N3Rn2MSq4Q94hw1zfKgiZEUyxDGapHSHNsg6K3wxGgE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q4o9OTugEVEV4GEBIRrDjF2YAIt7WfqUbWYI7JyzgLNRCuAn6FRGEfKup6azM6h+N
	 V9pwGfdMSRIC8WB8fTVRwIpsZOlnUx/Pomc98onvbg0VJNetQDjPtE+iOllJaB7gRI
	 W14unlzKgtbZdsltlCifZVzxGSy0p9YOoNvSAoq3WIoEbrHldk7aS6imQA/HsVHOT4
	 g7mJu8cyjSzC0aJAxcWaHHXSxjoVfE3Ym7eJrEozFzzhDpMsQRZYMEBexcwnXno4oP
	 bvIgUdL6dacfpFvW0EdKrd5khntSZ10P9sKfoWpMvfH/Oq4jdnowAPetgHRn+Il0fM
	 Ok6rnujwpYFyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BCC880E3D;
	Wed, 29 Jul 2026 19:51:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C8C142CE
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA497400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:51:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k7VGkHAALPHr for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 19:51:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BF19C4009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF19C4009C
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF19C4009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 19:51:51 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66TJl0mt3350875;
 Wed, 29 Jul 2026 14:51:42 -0500
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fqqytr13q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 14:51:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJjn0rAJK7FHhx8CFReedgJTb2PtotXdrWL/j4OuRcoeiy2SkRF10IP4K4YB/OqBVkW4pbvRtgUQXtyMO7d88axgdW3JQVLgwJV7Xf58Q68HZyPTFvgUei7b7yF0RrEVtYbSSpxsmU6IJDceAZHf2FllBEtKsciDk/iqHSCJfUDw2q5Cn/M8iq2S0W5FTkl07TCCSAj958e3ry0c4Sz2Dd47bCpR1EBD6qJYlAMeETsCm1sUFj3m9pffpdnF6CpVpwqaJkcEf0/mhdj+87wBPU8q51KdhPT2xh44rC3DRyztoxaXttexFnSD44kJdDixxV8h7yBkeyypeX35eNsTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3Rn2MSq4Q94hw1zfKgiZEUyxDGapHSHNsg6K3wxGgE=;
 b=vnffSiN5To/Bycnz79ZPtAyrJZg1suxkq+5d9T3doTiKazN1FE/ugs3mkhxBekZkEexVWPAYS8ywFSM5Mhz8kIgvtlM5hKrRehn1Pz4RMvtWdROwHSSFc/FK+Hp73na/Qj0iAr+DUkdzeH7a7nolm0fd6/8/LyvtJIWPU7vyiMranrSIFwXRCmXoI2Epe0IV1xYO3qgF3iis3x4mLvE7thkdyQzqy1kf0Uq6tc/RE7ReOQh0Q+w4EHZ2dQCTp+io3E6YChMZnCgQ0PFHtT4pksTTVTdJskvBcrEDYhTm3eFiTOQxKev9R6NVQSl7A/8y41HGCx6r1K5AQotazaqOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from MW4PR04CA0133.namprd04.prod.outlook.com (2603:10b6:303:84::18)
 by DS7PR10MB5008.namprd10.prod.outlook.com (2603:10b6:5:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 19:51:39 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::6c) by MW4PR04CA0133.outlook.office365.com
 (2603:10b6:303:84::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 19:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 19:51:38 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 14:50:50 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 14:50:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 14:50:50 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TJonUk1262285;
 Wed, 29 Jul 2026 14:50:49 -0500
Message-ID: <5f1da605-283f-4c21-84c3-1539834ecdc1@ti.com>
Date: Wed, 29 Jul 2026 14:50:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 2/3] k3-am62-pocketbeagle2: add initial board support
To: <rs@ti.com>, Anshul Dalal <anshuld@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <trini@konsulko.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
References: <20260729193209.798946-2-rs@ti.com>
 <20260729193209.798946-4-rs@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260729193209.798946-4-rs@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|DS7PR10MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: c06596ab-5fdf-4890-e372-08deedaace11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|13003099007|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pzUAlYu7A35zIO3dqHjh+6LLFg5rJhSBdg5oL0QQ1RnRqwkkq2m+LpFRl3ob7qnQJKiz4b4o7mCZ2MrxGYqZfoBJUe6vZkk1qdtz65xwomfBKzsljma7x9BdhmOLaaDF2M44Z3NLQQl4AdunO//j/8lZ6lcfJfQ7f60gwrC8KjjRJsPYrRCRHt6+YcPh5CjF79TT5Y/RcAyJsjxvg6HybJp/esvFfiGke+aB1sp6U46rP7OVOyZGFlypPmTvayZ4vbfmxXXWPJBi95MipDtuHX1tw5sN+uG59//nfrXanChcFS7JSB1TCinfJoLJQ+vaTn+OnSau3UBXeQq/x4wT+161w9u/rV+krA7BUz88puPyzJiTgAnADYS6i0JydCfAZLVEIzd+iCsXlMorUv0ASrRkGdtx3ghR7/P2ZNXpGCQfdZVX0OTRDQJ4ePuBFah0qURL5lmfMiejELk3yE7IXVwrZBH6hQoFpK9Hei/39g26w2GWRgB17thdsrn1dD4xUHo/TdQC/Ep3U19VvGxE73F8mciETDhZNnmLxZSw2tkD2BNJN+3epqweTnjqaEUIMddLtxQS9bzGCT24eHjkQHvwTAENxuL7uW7cN5weMm1+tSrCorCVxOzeg+kCBxF1t/Gnj+mKsb5e/dQE1YL51n6TXBuHbWnX/3tZJZqEII5JBp+icF1BiPyICXH+xiMnvxYyweqCrzGjG9DDkX6m5Q==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(13003099007)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 70SgNPKQtvoqdTatUzxqC+1DlFWS1tzusLQB5uT36p1BWYCyyjg900KLEU6yVoAeXZ/jj+W9+y/lY9zF17VTI+NV+oj39Eh3iJ9/i0KyTWQOs5dHx1eb4Vuld8xyoOeETdOyKut4WtcGE1/EOnmomxPaSI0eEccePnLl18avBvFknzZupc6rcbmbG4rh/AzNtWzo8UqhrhjCJnEa7SqUlnWOKNOubEq6o1bceV1s0qt8IupG4V9QoeW8hLmFCARfZZ/KdAeRvte8+kWicKO+2J1oQDdI+PLTEgAov2czbtgvaAlyCSlmzntsTgeYaZ3sTtvA8kJkG68ViCqd45tOfLI8t9lC5Yrtg/OriYwEmSocxp7oVQ8j2ZvBPf7UVyhnRQYRwD9Onu3Z0zvb0KK71TN0jjDDFAs28F3OQ93oSqYh9TBtaskdus+T78R/U0AP
X-Exchange-RoutingPolicyChecked: izfd6jsSuKlhv8LYkp/9JFCA1jaNe/FZ+iGvW0IOBTKo/qixwN2bU3p19tWdKAaM2fco+cVRHGxP10TKlGqWCFNVUQJW2AQSJz9BgOTq8e92rY/VL+kV8Q/6ZmtuxYx8K0bx0ST5z1otEQAIzmb4YTIm8DF0VkODOIpX3BgsgORBRnYmCpoKFrL93a8Mo3nDD9qVPmjF/m5dPs28943PvzyTesjsqs5dEvDXb6m4be39pux4U+mTlDpKhCc508KR4/j8UDUQmB8Df4cBZh4l+wqD4XdSC/1FOpTNj8spMNmuGMCRkJEIGaq2iPGeo3iItzGbfIQAzRzQDjyzEvbPpQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 19:51:38.9433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06596ab-5fdf-4890-e372-08deedaace11
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfXxvtyFUg3o7On
 PMhDx4rBeHDns0dzzZBT6Pa8ImmSFl1MLlaQu55d06SvFupsho3vjB6TcIfGq49G+/0yhliRHax
 0HxdPjCLvE2lBmfIGPP21oLJFhsD3VXcQ7PHv+2bJicCR8LDPFvdbARmE0SsRnRjnH00gr6zk/U
 mQBbnpA3dtiIfSEKpvyLIsHG/Ma4V2yG0gkY7rBl0S21sA54TDRuIgMerTD8oITY60ZqgQcznE0
 4bLjLJ6dqofIEPo2h9zETMU766vAo2ZGFziGfmcPHu6FBb5VMCPNi1l2pVgeLOCdCNxX08dq97Y
 A6nWLVCqg2vINzn2STtHK4L4b5EGxDKNHtbKd5xJudwoM3tYuH1xYQ7HjJMpl1UvHIHp3Y1bGZn
 PepM2S3hjRNeymTRopo1yAl7AIIv2Przotu5zYsN9FyHKTqfhq9wrZH7lLQBaweFxU2VGWAfdO8
 Sbgfq+jEkhyzrQyG/bg==
X-Proofpoint-GUID: FmJouX6w57eDhzZ33oW2iFcLk7ZM1Sr8
X-Authority-Analysis: v=2.4 cv=AOkSgtoa c=1 sm=1 tr=0 ts=6a6a59ce cx=c_pps
 a=BcPl/o76WFXIZ3b3OvynCQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=lLZmtIKjAAAA:8 a=l75Z8bIhkbM6NC1FY8IA:9 a=QEXdDO2ut3YA:10
 a=q5Nj8NTjyn2D8kUwajRn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX3VfeBqHyc+xT
 mBIt+Q8pvfYRbttj86OhbRisdadl70lkcOV3kCLYJq39HBXV+X0RLNEeqTuFVdOAwT6/sCP5y0P
 JhNELcppJ2437QMnL0FJ8Yy2z1OLCjg=
X-Proofpoint-ORIG-GUID: FmJouX6w57eDhzZ33oW2iFcLk7ZM1Sr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290152
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=N3Rn2MSq4Q94hw1zfKgiZEUyxDGapHSHNsg6K3wxG
 gE=; b=mYNPzqRDmQY0yckjEVmzYVM2QPuiA2yltPbXxM7L2QouNZVThAl+e5g1i
 JNgji7UqaU1OFirLsVZK0wMHbmhE+KqRi1rrQVoJKU31ktFB9DKj85aVNGNmLl4C
 WWK7hggWBWdmWKFUT3FX2wXZNxPPs7FgysnnWEXIYsySO6V2/LROchbRfhTUmNB9
 g0KOrLvWHAa6Gy/gcnaPv1LW6qRiB2vnmlNG4Q+no4iR4BSG13t8BNOZGF6420hD
 4OROivrfNDV33QWuneK3QJrV3ftVelFNxDAN+Dc1O4hltzcw5CigDeqp+ZKvfkjP
 Av1awtF040ra75O99ZnY3VU3Bp0WA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3Rn2MSq4Q94hw1zfKgiZEUyxDGapHSHNsg6K3wxGgE=;
 b=BXlV4dSz1RZtLOjtTkwQjdCs4D8FkIXNt3NxSXf/cPCWlOHsd1BnI175vy2t/Qqu9MrA8MOpWVQWVCglfRGz5jUjNGcL9uSr02CRhkO6oDD9M+Q44O04Fh4Y0JOV36ptFy2i0Rn6nXurLVngBonauMxMambdsiTYruNb/7Wnkjk=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mYNPzqRD; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=BXlV4dSz
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

On 7/29/26 2:32 PM, rs@ti.com wrote:
> From: Randolph Sapp <rs@ti.com>
> 
> Add initial board support for the PocketBeagle 2, based on Robert Nelson
> and Bryan Brattlof's work. Unify all debug consoles to main_uart6. Use
> DDR config v10.32 from our sysconfig tool [1] for Kingston's memory [2],
> (4Gb Desnity with a CL of 11 and CWL of 9). Add support for the
> SPL_TEXT_BASE config parameter. Ensure all files have a summary and SPDX
> identifier.
> 
> Also, use board_get_usable_ram_top() to fixup our relocaddr since
> otherwise the u-boot stack reservation will collide with the
> wkup_r5fss0_core0_memory_region.
> 
> [1] https://dev.ti.com/sysconfig
> [2] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/6465/D2516AN9EXGXN-TU.pdf
> 
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
> v3:
> 	- Use board_get_usable_ram_top
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   ...> k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} |  92 +++---
>   ...dtsi => k3-am62-pocketbeagle2-u-boot.dtsi} | 160 ++++++----
>   arch/arm/dts/k3-am62-r5-pocketbeagle2.dts     |  35 +++
>   arch/arm/mach-k3/am62x/Kconfig                |   1 +
>   board/beagle/pocketbeagle2/Kconfig            |  60 ++++
>   board/beagle/pocketbeagle2/MAINTAINERS        |  10 +
>   board/beagle/pocketbeagle2/Makefile           |   9 +
>   .../board-cfg.yaml                            |   0
>   .../{beagleplay => pocketbeagle2}/pm-cfg.yaml |   0
>   board/beagle/pocketbeagle2/pocketbeagle2.c    |  58 ++++
>   .../pocketbeagle2/pocketbeagle2.env}          |  20 +-
>   .../pocketbeagle2}/rm-cfg.yaml                |   4 +-
>   .../sec-cfg.yaml                              |   0
>   ...onfig => am62_pocketbeagle2_a53_defconfig} |  24 +-
>   ...config => am62_pocketbeagle2_r5_defconfig} |  11 +-
>   doc/board/beagle/am62_pocketbeagle2.rst       | 279 ++++++++++++++++++
>   doc/board/beagle/index.rst                    |   1 +
>   .../configs/{beagley_ai.h => pocketbeagle2.h} |   8 +-
>   19 files changed, 636 insertions(+), 137 deletions(-)
>   copy arch/arm/dts/{k3-am62x-sk-ddr4-1600MTs.dtsi => k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} (97%)
>   copy arch/arm/dts/{k3-am67a-beagley-ai-u-boot.dtsi => k3-am62-pocketbeagle2-u-boot.dtsi} (53%)


Beagley-AI and PocketBeagle2 are completely different boards, any similarity
between the DTSI files is coincidental. Why is git thinking 53% is enough
similarity to consider this a copy, making the diff mostly nonsense?
See if you can adjust your format-patch params to fix this.


>   create mode 100644 arch/arm/dts/k3-am62-r5-pocketbeagle2.dts
>   create mode 100644 board/beagle/pocketbeagle2/Kconfig
>   create mode 100644 board/beagle/pocketbeagle2/MAINTAINERS
>   create mode 100644 board/beagle/pocketbeagle2/Makefile
>   copy board/beagle/{beagleplay => pocketbeagle2}/board-cfg.yaml (100%)
>   copy board/beagle/{beagleplay => pocketbeagle2}/pm-cfg.yaml (100%)
>   create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2.c
>   copy board/{ti/am62x/am62x.env => beagle/pocketbeagle2/pocketbeagle2.env} (64%)
>   copy board/{phytec/phycore_am62x => beagle/pocketbeagle2}/rm-cfg.yaml (99%)
>   copy board/beagle/{beagleplay => pocketbeagle2}/sec-cfg.yaml (100%)
>   copy configs/{am62x_beagleplay_a53_defconfig => am62_pocketbeagle2_a53_defconfig} (87%)
>   copy configs/{am62x_beagleplay_r5_defconfig => am62_pocketbeagle2_r5_defconfig} (89%)
>   create mode 100644 doc/board/beagle/am62_pocketbeagle2.rst
>   copy include/configs/{beagley_ai.h => pocketbeagle2.h} (57%)
> 

Same here.

Andrew

