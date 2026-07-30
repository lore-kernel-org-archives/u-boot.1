Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF52C55167
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 22:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4509660A6A;
	Thu, 30 Jul 2026 22:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJC4LSn8ZjET; Thu, 30 Jul 2026 22:07:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3541560A6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785449260;
	bh=iCWydQ73kSN7zj8XwkOTuZTB9MnyjhbKQ+dAYw+vj1M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j7opZHEE5XZ+IrZOeK5BklK++HRf3DZw7Y6caX755/8044D09qEKtT+LPu3vAhFJN
	 xlPGIf04K/GgtzsnUC4ZoIFz6RvIFw6vnCjIeEfYc0F8o7mojhpgJAjJLVG3sTlsCk
	 K1k9gl5IwwkmminFWgdqMiWMJdoth2wLoR+y2U8krlZfBgQLlnXhrEUbgA/A+NzFSP
	 Dnrs6mhl9WRymTd6XA0LkonoZwQS+ggCWhY0TiVJpIqZ6TwhVi5zspGaE1XTmxw/3b
	 nTMluJd5gSvb44w5XHaDHaP0NCfmmsklHmiAntbaKubrQZyOeleosLD+4kdNtcQ670
	 h3BjLTbAu6x8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3541560A6F;
	Thu, 30 Jul 2026 22:07:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 33D0F69
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 22:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19CB660A6F
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 22:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MDLzlYS5nNr2 for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 22:07:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 24CC860A6A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24CC860A6A
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24CC860A6A
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 22:07:37 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66UM53IA3804395;
 Thu, 30 Jul 2026 17:07:29 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by m0384305.ppops.net (PPS) with ESMTPS id 4frf3j80hc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 17:07:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDLrPQrhtjnBiTsBGgulvXW528sVshpH7gDiyIITRjRuSO7Ql7EiHhLEH+ONxfhcGCNVu3b+JQsxxq9PNYYfqZHzAs/HbfrB00dWk/7/0m0rfmWVuBcm8zmIXDV2YPzGLlRu9Izgn+oHw63DT5lBmENyGxyTZe8pzYD1foA0bFXNKOwHZv6ULvHwksOlV4ySsWSg+E8LAzqt4HI+XJ5oaMRFD3jiWKhTwr99G3Fl/tTpN5/aJd8gQFiZAkDQX/8+dvVphyzJMfdk2YbWvLa4q1xc99s9k/kKeuHZ+qYQGPl98OlWDg4+9BCrtjDJKRHRNICjFtdA9jHAZzACAiQYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCWydQ73kSN7zj8XwkOTuZTB9MnyjhbKQ+dAYw+vj1M=;
 b=v3zLXPubk6BxvRZeJ5JfUvtJsmzdVVqXD2e5FYZFTXp91XrcqcqVqnMNZ/uFMqizFRwhXsWOVlM0AJ3f//CiFfdKAu7QmeBEHUSKuBcHOfSeQlJoeDzXh16cxdKMQOHmXMxSvSGruPIVKGF4SQOi7lvbHhdLrAjiG2cLxUFlL/bdPEbtYduOFihYtFSWJyGlLTOMqkB/OkPoH/sJ0vNuRk7ZYFCekUouDziD1TtzIGTAFqFhocfu5SAjEstOeny05AeN8d56ClS6uLj+c5hicKbhAKzJvuZfy043M8YzHWVG+VkqWtr8+Me41+SLPZvmyUEneT3N+VnJQTp/8VUn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by IA0PR10MB7254.namprd10.prod.outlook.com (2603:10b6:208:3dc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 22:07:19 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::5d) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 22:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 22:07:17 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 17:07:17 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 17:07:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 30 Jul 2026 17:07:17 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66UM7GTS4150574;
 Thu, 30 Jul 2026 17:07:16 -0500
Message-ID: <d26abcc3-4e46-40b6-ab13-47bf8ce106c3@ti.com>
Date: Thu, 30 Jul 2026 17:07:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 2/3] k3-am62-pocketbeagle2: add initial board support
To: <rs@ti.com>, Anshul Dalal <anshuld@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <trini@konsulko.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
References: <20260730215319.965327-2-rs@ti.com>
 <20260730215319.965327-4-rs@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260730215319.965327-4-rs@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|IA0PR10MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 27afb35a-0273-4cc2-978b-08deee86eb85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|13003099007|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XHXR6E3TblPfeC3vAmlBzabvhNIfQhMafPqjNp1Pd2fXnGdSUrTuA3K2yMTVZyBjMeQD+AREiQTQRmYIhqtZeZk/dbk26NUq/i4YheNly0wO3TFsaDO0yUuClG0EoPRoCjNGF4yCgLGZXlXDSngSwmupKPqGZZuoNmPGmRKhSa9EhbJm5Nix3/hxRzi7n7J1Fmlk+RwXVDuQhFT8s4Hjxh+imQwRGikyQd0npGk4o/rGHLl5Q5BiNTwBPuz3n02kpMQGKVHQLFxL2sEAqlvQPpNSzlZbJvxwmphJqFqJHtcIopF7po62kkk1tRLk/077cfRHX/Zlp7nl/PRMbRhBtZ2WngA6dUVbamqDJ5ynPECoDIvgBAHdu0Z11DkoxzatMj8RxcCK7h8KTNAS71glpeAjs4puz9dYGNofExoyqJzuVZO6Ak0xjH25UUnIYR4CtY5EOZMQY9dG2ZE8YFatsKxYj0Js1cSJKEBdVYzGvE75tBmsk19AhJo5MkPVLPcq3c9x75iTCWGtQk8ACtnjDqEuVF53916OX/YimwfRPXM/+5AQyLRBZDSw6b8x3imdRD+u+tgmtfRN4271tpT1V6Uhf/DNKF++Hhx4ZbBRu/ErWR9XXxwBD5mGSvnzlMBOtUxIHPjRerNXJ4zY8HERuzy83u8rgezSLLIjuqB/vyWSL/hTg2RKPuTDWH5SDj2YEqlFIkVvHCJmIpnux0xjRA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(13003099007)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wSZMTYNVHvu3lloOyEIdutEFsn3ZJ6C6u61YR3heJP/tCwuP5J0sbUyRHRP2Zd+nZRXWBvn0CpuczNSYu0UzOboebTmoR9e00gjzu2tyb05bRE7d8/OkY/jBtLp99KN0Bt4A/5uvR6O8+g9ZzBJ8o7r/ye/Pg3YxOSYGdUl7X5DU+oeq0kbvfS8zqgDl/O1nJ883rTJdweaQMGeqTAWJNL79y16x1TSrenP8GhAWy2OUWS4SILtXwLOWcvOO1W3hPP1RWUcHbZCSiStVjoRhVejwsg/hwmd3kdLPsMZsjUjXWka0q1knABCcBwC2n/Bf0lPaUzJsTO0Ym6bmx+CzbgRj5fWsF2LjYzYH3YKWPgDpDpsnR+yPvomK9quVWS9mhWxjq4ibGVvs4aZdCyaItysDKKrGmCCC/KMIfpReL8S+m9DIQ8ESIdlkT/NmNVpY
X-Exchange-RoutingPolicyChecked: AzotqBOKe+9/ndomC5B5BJUxHl31Fe0VDvKRGMEEpIc2FhAei/ap49tRZDTPf70U263amcNuosjUkA1F3tIkTk8OcmRbrE2TdWRgZUquf1CtQB2AdQIQ1BzOp0qV1mc1Jm7ouee/8kozi9MITlnuiQ1DtPqRQcdOG9v4B8akHfmKDpHq5cMs82a32ubinDMSi6uj18NeIfnpqRSsQQswn0MCtwg9JFhcBr5FfSLeGpBUJUH5RDwA1EIyRF01mW2E0zjkQiTGXEIOtLIIFJIrhZyDql93J9Acb7imcWvxwO7cror/tmxetKjKIlis5Km8ZQaktVsE2GnoYl/M/QAoSA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 22:07:17.6693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27afb35a-0273-4cc2-978b-08deee86eb85
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7254
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1OCBTYWx0ZWRfX8Zl8jQzICw6z
 rtiyn7acymCGMtzJ2mWpM11OSN4xkdd/vTHZEFd4J+ThwtOdZX+0zx+Mu8UP9b778jjnt7XutPl
 FPUlRjYSSuRHpKl+1pWs/40Fl3vXV4o=
X-Authority-Analysis: v=2.4 cv=Hs5G3UTS c=1 sm=1 tr=0 ts=6a6bcb21 cx=c_pps
 a=JAdTqqN4+A8LnUbrk8iLvA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=lLZmtIKjAAAA:8
 a=4UJxQYhGHt-_XVyZFkkA:9 a=QEXdDO2ut3YA:10 a=q5Nj8NTjyn2D8kUwajRn:22
X-Proofpoint-GUID: -zeao5kAMoYHZjG8g-VSIjxNCiiGSNkr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1OCBTYWx0ZWRfX6BvVmoGAdaWa
 f8op+lRKJsBJjP/DhZIBbEEFGCX4Us3krMqc+OXmShB+EbIeOQF/Xczp59CxrqhS6uIQynoqLSs
 oQm1CCNz7ikSsOJ2vGW5HRTNR9XEC5Oc2UZOwYDUyNQnLSxbN4hp3CkPUctELnL/cZTqq2Zp2N+
 mtsTDTmkYbcTLTtd7BOPv0qxUi3tTif21dQiixFu2OpRPhcxpbAxoM8ctGdyGuheu5uGMB/sioL
 GiHXIssxfXrd6pYpnGI5TQagnDebDT52J+2I029ynWOYwVsRJT46zh7VcTzaxsdl0re7E7VdR1n
 rhB7nQwv8S+bQRixn0NOQ/Z0vJ3TbdG67+qL6b7f2wqfvSEEUdFHwhKnAp2O+JPwC/m8fnavg68
 o1COhA4/JtPs4l/sDIGN5cIudmFv/DiA7yRGxrYWf+YBXXX1OxRbmeQlKnPRjB4wEs4r3JUehIp
 sXgConWYHv3jyTflzyg==
X-Proofpoint-ORIG-GUID: -zeao5kAMoYHZjG8g-VSIjxNCiiGSNkr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300158
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=iCWydQ73kSN7zj8XwkOTuZTB9MnyjhbKQ+dAYw+vj
 1M=; b=N5thH2WjzovYMD9Yccvn3M3KDzUdLLUsHTHBmBdBBNTpkDhAoCf/yonwT
 2j0Ntmk6P3luHTsmWiDZozx5RDJ9gPLmgh18rU4NIKDEyymrfu/dgtYieV97Jl6c
 Uus8q/xpURtlLAc6Ax13BcDaa1Nqd2b2YJpFu0nODV1yCdkFtSVnpV9CzHoyl8x2
 I1BOtSZzXXEKhmM78mEMOiwAo/izykxUTAFN762KYUw8IV0zUPxEa/pONjl6m5oB
 Q5MX31jPOYeWkjX/HlsR0lkp9HTjF3Qwm6UXgyptU1FvLZiGPo0r0qZRftZFVhf/
 L30BUsP19hI2dMpy6VvFQJl1Hs5og==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCWydQ73kSN7zj8XwkOTuZTB9MnyjhbKQ+dAYw+vj1M=;
 b=FmM4O6oOe3kDrx6HMfX3dcd25+dXD3gIZiptqXXJV8kR96naWA3JhHUmJndot35tg7fghQ+Qr7Fi4ks8s0fyNKVfvBDr5OAcZABoca5F9Hgze9XI31XnsDcuJTPnhnJ+OJRTPSGxsZAdh7Xv8X07ub7l0ObDSnfPMIVwwNG197c=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=N5thH2Wj; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=FmM4O6oO
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

On 7/30/26 4:53 PM, rs@ti.com wrote:
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
> v5:
> 	- Sync rm-cfg.yaml with am62x config. These apparently shouldn't
> 	  be different between SOCs unless you are doing something
> 	  application specific that requires unusual resource
> 	  reservations. The discrepancy here was just due to age.
> ---
>   arch/arm/dts/Makefile                         |   1 +
>   ...> k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} |  92 +++---
>   .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 307 ++++++++++++++++++
>   arch/arm/dts/k3-am62-r5-pocketbeagle2.dts     |  35 ++
>   arch/arm/mach-k3/am62x/Kconfig                |   1 +
>   board/beagle/pocketbeagle2/Kconfig            |  60 ++++
>   board/beagle/pocketbeagle2/MAINTAINERS        |  10 +
>   board/beagle/pocketbeagle2/Makefile           |   9 +
>   .../board-cfg.yaml                            |   0
>   .../{beagleplay => pocketbeagle2}/pm-cfg.yaml |   0
>   board/beagle/pocketbeagle2/pocketbeagle2.c    |  58 ++++
>   board/beagle/pocketbeagle2/pocketbeagle2.env  |  26 ++
>   .../pocketbeagle2}/rm-cfg.yaml                |   0
>   .../sec-cfg.yaml                              |   0
>   ...onfig => am62_pocketbeagle2_a53_defconfig} |  24 +-
>   ...config => am62_pocketbeagle2_r5_defconfig} |  11 +-
>   doc/board/beagle/am62_pocketbeagle2.rst       | 279 ++++++++++++++++
>   doc/board/beagle/index.rst                    |   1 +
>   include/configs/pocketbeagle2.h               |  14 +
>   19 files changed, 867 insertions(+), 61 deletions(-)
>   copy arch/arm/dts/{k3-am62x-sk-ddr4-1600MTs.dtsi => k3-am62-pocketbeagle2-ddr4-1600MTs.dtsi} (97%)
>   create mode 100644 arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi

Wish we had better templates for the binman stuff so this much didn't need
cloned for every new AM62 board. Problem for another time I guess. Everything
else here looks good to me,

Reviewed-by: Andrew Davis <afd@ti.com>

