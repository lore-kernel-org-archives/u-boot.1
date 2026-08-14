Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4A5C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 12:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B6B44071D;
	Fri, 14 Aug 2026 12:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QdacLqI7aydF; Fri, 14 Aug 2026 12:01:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0016F40573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786708906;
	bh=IsD0jDh1+6cmvUIbZ/+oBOb67gdSlSbf28H+N3DFltQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E2zr2VQ7ebIfyrTZ5RqQD3fN7wLLqzyUTCh4gM72nooe/ti9J6zYOeFnsPG430YlI
	 YEEvuZqLbTfChN5G2UnsE40j48b4v/qbYKYiZ321sMQRSssP6Va2y1HBnSDr/wtm3T
	 HGUB6dwaY7tIce3/RnIlEuPM9KPrEdEr3CasR1z5IeXb/MmcAksxEfZcp0mfy5SWrm
	 gsfzWcDtJD/Aj0OQL3a6PfVkvkFBjd4iBpvfHQoESSX/3RD4VVEfKXfOpQvbjxWM7S
	 dkZ4niol8n9EPQ21j5tiMWGy7FUARQPDcYO4YjB8p++BhKaXUX9PQwhOQM1uX/99U2
	 jLosIJBSi2InA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0016F40573;
	Fri, 14 Aug 2026 12:01:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BA5C194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 12:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DEE04030E
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 12:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9DhxUKhwsrC for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 12:01:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=n-francis@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 53FE6402BB
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53FE6402BB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=VkE2Xo9i; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=SjaE8KGq
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 53FE6402BB
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 12:01:43 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67EAe8091504041;
 Fri, 14 Aug 2026 07:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=IsD0jDh1+6cmvUIbZ/+oBOb67gdSlSbf28H+N3DFl
 tQ=; b=VkE2Xo9icj+q+gxQ9eGQArA+ZnjZinHPbiCuQ22C+0uizo5Zr/xwd5moU
 3QEVs9X28Yez2qkBfD6+rTXbzMCNRrAPzKcJfYOztZyLadayDEFEIbijlAQxwYiI
 BA99ZQIki4NFkqAPKfNiJ/M2KeRrbHj0Dn8LYz2ssXbhXPG9RxaLKdudzwHNguCb
 1RZJAKPkL8aVfGrPX8Eo3VCXSUoFOAGEShrfMH57t9kXL+Hj6/BQLRxsEHsNzXxE
 GCK9+dfzy4bV/15FsMft09oowgrbl0xlvUtZIacU+7uM20PPMDrTLJ1PQufOmDG+
 4Oy2NkVC1eYIacS6jyVOSsfJoITyA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by m0384305.ppops.net (PPS) with ESMTPS id 4g1tryj6y7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 07:01:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJe/RpiP9E8RZ33KpGPIsCz0qOdLsj8+nr+hRH0kEWiqOMJNlryXIfBnvsgtQE5MOP5bi159KB6QxnczzNsnK/BTuVc6WhfAT7TV7Zg7Kh+MAvbX6km9hTQ26uCNIn8tYJvIu+HAsh4olmqcQ6ZruDZ0rdMUWuUtgTwsCiXrIEMFwQk0zvjXZ3poYJVb0Ir675FNxYLKE71lo81wGMVcmF/T9wlm/wSgyzPxZ2Lfj/UfnKhzyHumRag9PrsSWWa6DSc7vrzwbeSfNZHMzBKk8vZPM88w0zkejz+VPGMRJ2hpoV8s7zs8yihW+uG9N/C0s1fnh02jaUwlcmrM+PbYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsD0jDh1+6cmvUIbZ/+oBOb67gdSlSbf28H+N3DFltQ=;
 b=dhdr12LCyjeam/WCzKSMrpz2HGzSVD3s0ISN4o9LUwyPqYaCO33mmquWZkacGlAr9BekmYGpO9hbNX8RSUNZDsHKaO9xsxVvz+ZmMKUQk9AdQLAz3ptENp61IXv8rZ2GCvAe5Qj1p2nQcch8Z5wYQBpRYAAMnNyd4XlnClD28RZcHF5GbphHTj2lCRRjVzcinnyH1eiLI6lSApI0UrDTZU02sBdnJIFPc8W0Jdzu2rdC1spnUskQ5AvNRT+LRuYQO2PuNugMPulVeeqJwNwYsXxzULzBupL/+tAesF2xVgUK5Q9MY/OopojPhuQMa1Ak3rz9jLoIpEs02YbKmZdfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsD0jDh1+6cmvUIbZ/+oBOb67gdSlSbf28H+N3DFltQ=;
 b=SjaE8KGq1+czLY3c7NBXCDjs4IX2L5NsdFOVPqr4v6vjUWVDzRlIg0iX+fL/ikbtTQ0v1XyiKl4k4bYQJ1dsyZPaSVIlmnmxhOxnMY7qEnL/ERu1DRbyNDQYgy/O4/4sRAEPh8hhdg2+F9QzeE2VIw7zZimfHdEUziyMsmSVIbc=
Received: from MW4P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::30)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 12:01:38 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:114:cafe::82) by MW4P222CA0025.outlook.office365.com
 (2603:10b6:303:114::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Fri,
 14 Aug 2026 12:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 12:01:37 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 07:01:11 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 07:01:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 07:01:11 -0500
Received: from [10.249.132.191] ([10.249.132.191])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67EC19Ms1675383;
 Fri, 14 Aug 2026 07:01:10 -0500
Message-ID: <538ff0b8-0344-4cc7-bc6e-b71adb86e2d2@ti.com>
Date: Fri, 14 Aug 2026 17:31:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm: k3-binman: add tisemifalcon.bin for semi-falcon
 mode
To: Gokul Praveen <g-praveen@ti.com>, <trini@konsulko.com>, <a-nandan@ti.com>, 
 <u-boot@lists.u-boot-project.org>
References: <20260814102153.44487-1-g-praveen@ti.com>
 <20260814102153.44487-3-g-praveen@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260814102153.44487-3-g-praveen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|CH2PR10MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffc8ce1-eb21-432e-bef9-08def9fbcb18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: 5UtGkgNbtmjPbJcis5NuEWh+TLESGXNDkkJBI5KGzny4wh2dM+DSEcHX7/qEcx5M58YtQcxaU2EFKDA59bXPkrtSGvm4UugAiD+atZhGPrv4FRp9qaZFrtSwfOveiVUp1ilf0Q7CZEqyB1iDQRxn3jg9vPqZe5H9qsCbdr5ZmoIiez1ZP8cvWXJsMKPl46cp5ryhLspR40ryys79RbR3So7H14PcjAZlsxy5vPZ2dRH2ZdAuFmePGaBztexAb6YS/D4Dq3zRXYdIQiz7YBauIFuU+cWK0922QqVYGV3o3oE9oyV6QnFwDPXZ0Zk8CQ5uHpB4Vh99BWo5bswXKU1unQ+iDmQZePK7kVme4tM1bFjsdkuEwbh79Rae55/OguSprrznhzpifxq+OMAtSrxG+1tNjRCsp2p7LTiwHNSAjAKJ0v5nEnko5iPXMiDC9r7z5yugz8TQgIWt7N7i5mixj9sdpEhL/pNri79HGcpKEFvWr3apBDOcdo4Zp/TCoYk9ES+Bf5QWWN0IZxcZZjDte2H9VXhx1KcvMReimmFW11NTwbrvHwRqsXFxkQUKSzJ01mDqOU0S1oOuR3srAHAcTqpRfEPTx73gCck8To+lPqx1f316Fy2Ol35/wR5QWkMa1Kq8WizUjlyhm37AiI48FoxnaWGKOR6t/OVVrjKxnselLyKzZLyzXmn7k3ppyb/C5PljOnaChspnBNEmi0XXmg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: POuUelUoXcYJeKy5a7J/AgOrVg8CFWyMK0cLsRaUyWpbwT5vM8vTmZPvKjYUUsTrAvS47vLnXedxoFppu9L8TGUye0ICr8bJ+rYxB2XQCfbY2IqH6w2T5nmiBAK6ebRB74NKlb12axRx7/umWVzyMbOJPFY5g82AP3GEqw0SR9HrdKBJ0xRlOpE7/uT0F2QAS/r22h9FwrDlnSKimLBJPj45oJr86tAZjzwupcdQ7iB/xDnY4VCzX1UtoWP0ZgEt7vSG7cBotq/8INJlkSkAKz1FFUFAB3QAExUFWDCTQQs/l9uy1GKsVkuoKQrrfgzLg1ZNUyh7YQNIlnCi0ft4w0kdg6rT6JAWtuxIm1wU1SlYuOJZAj4rERXzD0sXDJpDBcNcjFrOtp+juk232I5VzHns3k9BGY0/ze+2PfuZCLJyOAuQtHkhB5QMGKPbW/bz
X-Exchange-RoutingPolicyChecked: F2jq1nrVcLsP0xxZgrfmo2nuu3LU/WROW6akjuLMH36NSdgwqRr5ftjOK+kBP2AiJUMkk9OySVzOWcj9yM24+mk71LbJ2xM4QcS+d4aZRTOLKAVxlfId53l4YdPPlyCei/qcAtN1c+x5ifYAGYnG39HEm66/oH/UUff8/qIIGJZOFM200fB8t1VlsPXG/Ig9tSEBM9MUXlQLSlsxmin0HveX3Ld/2X8HH/cK6N9AE6GAJrFIAVItLBMXSRUAKDwHLog9a8fqYo+szWU14NJkglB1D/HxkWh56jv0mXRJ54vRHf3PtxC/dLES8NrAe/AVriLEISjinq/YbfzwihdhvA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 12:01:37.1361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffc8ce1-eb21-432e-bef9-08def9fbcb18
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX7WdcfEOp1IXE
 R6a7ZwIvTTd9GAiAa7pcObFkSzs0hpsv6ZXbvQdXwwMMTi6aeS+J3/+MKAKf2LhsT7ZyevzZkyP
 g/5qqyR9xEbhNp4hUw2GDToogLhjrqkIRo+9AzxSCVR9R5m+MUXnKP4tr09NemdE81KW6GG5l0I
 SQKq6AbIdqOwNnH/W//0F1N0Pe7omAFzRW6yHobZku62pwILrFg4Qi21OE2onUMr59YrcNfED1x
 IY091gUnen/7kmmrakvVjtS8n5i4stFXngGlmwlDsQx0h0aHhuwtAvlhmWqzdma0zOe9pTpt1Jb
 SPct9t5yrcvpy3K6e+Tigxd5ZgK6KAlpaaSI3KlX6scD5Fir+ZDLiGifosdJr2vX2dLZwYa+9nl
 LN9BwV4lYYsEIrlHlQx5gDAdDGQpk/vliiq3OLBFY1/J3vSZ8RA0JCy1QGX8o1dS8ci4td7UEaM
 xpMB44o2+h+2SrAMQ1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA5MSBTYWx0ZWRfX4uMRvqb/0w7z
 IF+bUuo8GkG5LKgO1rgaX0+/C5KFNmJg39f95shWjkCiNggyoxzeZmmKHWJQ1sL1S9HjpKVpF4z
 RE+nw4RMhOTYUz282wFiSqgdePR+jw8=
X-Proofpoint-GUID: Vx6dmizqS_Ili6CBJU_XYfIbJY1oMmSE
X-Authority-Analysis: v=2.4 cv=H87rBeYi c=1 sm=1 tr=0 ts=6a7f03a5 cx=c_pps
 a=QXY2dPTpL+Q+r2h5MCHSUA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=-0k1na25Rvk-juqXF8QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Vx6dmizqS_Ili6CBJU_XYfIbJY1oMmSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140091
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

On 8/14/2026 3:51 PM, Gokul Praveen wrote:
> This patch adds creation of tisemifalcon.bin for J784S4 EVM.
> 
> The contents are the same as the existing tispl.bin but A72's SPL and
> the FDT have been removed as they are not needed in semi-falcon mode
> and instead UBOOT and its FDT are added.
> 
> This reduces boot time since A72 SPL is skipped.
> 
> tispl.bin = TFA + TEE + DM + A72 SPL + FDT(A72 SPL)
> tifalcon.bin = TFA + TEE + DM + UBOOT + FDT(UBOOT)
> 
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> ---
>  Makefile                               |  2 +-
>  arch/arm/dts/k3-binman.dtsi            | 47 +++++++++++++++++++
>  arch/arm/dts/k3-j784s4-binman.dtsi     | 65 ++++++++++++++++++++++++++
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi | 14 ++++++
>  4 files changed, 127 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index c6253670a94..ce2501602f4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2556,7 +2556,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
>  	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
>  	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
>  	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
> -	       imx9image* m33-oei-ddrfw* tifalcon.bin
> +	       imx9image* m33-oei-ddrfw* tifalcon.bin tisemifalcon.bin
>  
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_FILES  += include/config include/generated spl tpl vpl \
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index ad127663d03..d82b8630554 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -543,6 +543,53 @@
>  		};
>  	};
>  
> +	ti_semifalcon_template: template-16 {
> +		filename = "tisemifalcon.bin";
> +		pad-byte = <0xff>;
> +
> +		fit {
> +			description = "Configuration for semi-falcon boot";
> +			#address-cells = <1>;
> +
> +			images {
> +				atf {
> +					description = "ARM Trusted Firmware";
> +					type = "firmware";
> +					arch = "arm64";
> +					compression = "none";
> +					os = "arm-trusted-firmware";
> +					load = <CONFIG_K3_ATF_LOAD_ADDR>;
> +					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
> +					atf-bl31 {
> +						filename = "bl31.bin";
> +					};
> +				};
> +				tee {
> +					description = "OP-TEE";
> +					type = "tee";
> +					arch = "arm64";
> +					compression = "none";
> +					os = "tee";
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					tee-os {
> +						filename = "tee-raw.bin";
> +						optional;
> +					};
> +				};
> +				dm {
> +					description = "DM binary";
> +					type = "firmware";
> +					arch = "arm32";
> +					compression = "none";
> +					os = "DM";
> +					load = <0x89000000>;
> +					entry = <0x89000000>;
> +				};
> +			};
> +		};
> +	};
> +
>  };
>  
>  #endif
> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> index 34b2cc1e681..d109b3d460c 100644
> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -317,4 +317,69 @@
>  		};
>  	};
>  };
> +
> +&binman{
> +	ti_semifalcon: template-17{
> +		insert-template = <&ti_semifalcon_template>;
> +
> +		fit {
> +			images {
> +				dm {
> +					ti-dm {
> +					};
> +				};
> +
> +				uboot {
> +					description = UBOOT_BOARD_DESCRIPTION;
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					ti-secure {
> +						content = <&u_boot_nodtb_semifalcon>;
> +						keyfile = "custMpk.pem";
> +					};
> +					u_boot_nodtb_semifalcon: blob-ext {
> +						filename = "u-boot-nodtb.bin";
> +					};
> +					hash {
> +						algo = "crc32";
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = BOARD_DESCRIPTION;
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +
> +					ti-secure {
> +						content = <&j784s4_evm_dtb_semifalcon>;
> +						keyfile = "custMpk.pem";
> +					};
> +
> +					j784s4_evm_dtb_semifalcon: blob-ext {
> +						filename = "u-boot.dtb";
> +					};
> +
> +					hash {
> +						algo = "crc32";
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = BOARD_DESCRIPTION;
> +					firmware = "atf";
> +					loadables = "tee", "dm", "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +	};
> +};
>  #endif
> diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> index cc0b562d27e..d22cdc09a7e 100644
> --- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> @@ -87,6 +87,20 @@
>  	u-boot-unsigned {
>  		insert-template = <&u_boot_unsigned>;
>  	};
> +
> +	ti-semifalcon {
> +		insert-template = <&ti_semifalcon>;
> +
> +		fit {
> +			images {
> +				dm {
> +					ti-dm {
> +						filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> +					};
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  #endif

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

