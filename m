Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004C7C9830E
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 15:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D30260C13;
	Fri, 25 Sep 2026 15:50:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xPaqpUo-qvi1; Fri, 25 Sep 2026 15:50:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3E68E60BB2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790351442;
	b=Fg2K22ca8ePBI0NP6BFPIaofryZxi4Tp5vnB/cerslanGdfLRM0l9MMD0Wj4sqtCcFaC
	 gVCjzjrBfwC00mut5W/8XEnDOTqSxDQxQ22s3efPFPp+dJP+3m+dYSHHUQuMV2ZSJUPev
	 70uw7+Uvak5RuDqNidHy5hpNrnTXUjTBm0S5G11U5vGNUzRser7D7/5doPRzEXb2sFjcg
	 Sfn+JArTC3LldhqYYuO4DbezdCHfa52t7aIbzfKA+Ou6NNpud1cvRkNuaVJif+jE2njrJ
	 kLEZF2N+jXAadLdGwwBcqZp4eDR4vWzPQK24Brwcc/bNmy2HntKVmPpxNJ59bSW8tdg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790351442;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:From:Content-Language:In-Reply-To:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xogLvGD71/ppByclXHxm+CXOOg1vBQku5n+eqdovGNo=;
	b=D6jDlILGtj/loqKSyNFt0ds3mvpkAZq1Y3JXZuDeSvUzbv+GGL1/SqVF7qeKN6Dexgz+
	 1q2gGR1bj8kOxVXVmHVJavSNMTIttHGwlqSKmyK5N9jLCIId8BFF6+Zb1b209s+9j2vG8
	 8+XG8wxx4oX7YTzkkG6+u8X0TyKhiTEz4At1o+5lfUaBTP3eFDxLZgOrfLQZW2SXXfuxb
	 okyYcHJaK+bf7G4m84ZaPzwcM2DvnIh6gpY28NrsjNeqfs0QdkVPTEndavq5/FX85L5sT
	 4NPVa4ktSymGHPQVzEHgwIhYtQDLaPmpG1g8PGZC/k5yyD6v+cjlyphYIoZSdHA6c6Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790351442;
	bh=xogLvGD71/ppByclXHxm+CXOOg1vBQku5n+eqdovGNo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zJd83nv848xZ2vQR1BEqVR8qcgEPvy2DOZsi/o8kn4WvX/sXbf6MO3piGaMgQKVqd
	 eJu9AEzb0tf6wPOkbsRp1bJyvwH7sUD9ZirF1jYVYqQbKndmuQ3h2dxj19IPY6DOAk
	 79nWTDmfWDSW36eAAmYC6Xq9eK/+yhFWdkjM8AGZXyw20UVLhJNSvf+rZOV/h/VxRi
	 T6AQ/3RyNEpiOMkDQNgzO7kA5JNI7qj2KsuX3JjWV27A0eN8PqUqxe/9RSckG7u+pR
	 yDfO4N6ZCkK6PdwqLz4qQvLaSHqkYAJQpYs1DCRHtMSry9gvGO31ZKqMz0wi6kkNhK
	 5AQW3eCedZceg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E68E60BB2;
	Fri, 25 Sep 2026 15:50:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C32D355
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 15:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E08B40B4B
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 15:50:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQQZAht39Da5 for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 15:50:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B071440B27
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790351439;
 b=shUWYqCrYW6BWWuEbV7yFwvsVAgfL4sDA3E+GZVPwwK6bhsoMVGdVamaR7l+yT75S0b8
 osoZKMzMgraLzoyvig83QbwvCm9unI53xHB2xvwFdvI9E267yl0fTlljTpMyZCyjTKUan
 93ESPx94ku3gkV0VQHYDmu3UEYTaIyru8M4tov/jS8elmW1OyThCKdC3RsPUABSAT0DWN
 5QuDotgayQdWpzzAoePZQi7srWlFVK9Fu47HC8hNW5oY2sBTSPj86VtMthRFA+U2lNQQx
 7zqViW/UMTqg8cbcTdWdYbz0XmqyV63wSZ0nOFEy5E4BV6ZxucvUuJxO1edFBSIpTOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790351439;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=xogLvGD71/ppByclXHxm+CXOOg1vBQku5n+eqdovGNo=;
 b=oNOpaWu+mONEkadTR7bmHrtJhzptKSl/ZA1NoKKr6W8KebSwFgEkOG+UiuQSfYAo2Ffd
 M2V3BYBCDSkw5gsn3OOTYpMV2GWm59x/zkxnuf3aCCT0HRP5xIw6ezWTotCjUOlj7OUr6
 3vGqCaNHwwQ8l+VjimBEFhd3afsXQelX8wqK9EvFJIW04ihhc7exsMDJyOQfGHimwCRqa
 i1jEMINZ7wT+7N83P9EV06r1LY9Hiymqu7tOxgMd575hK4//k8XQ5IWcDuZ7g0kYeAAq6
 pVSYYXYWZp5/SrYk4vePEV7cKX7cwZ+sSc6KGic4dUNOve3M/0mwWpQpnRYS2Tf4kVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=iBurD6rS; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=iDxpHV7F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=vigneshr@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=iBurD6rS; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=iDxpHV7F
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B071440B27
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 15:50:37 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PE3UcQ2253493; Fri, 25 Sep 2026 10:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xogLvGD71/ppByclXHxm+CXOOg1vBQku5n+eqdovG
 No=; b=iBurD6rSM8dNlKDM+wZaZmeg0QUx4oNT8STEi+uisTetnujLU5+Kc4PfO
 Ap2nP3nSTawmuR98F0XbPcaLr7WSmEtiHZaoAvXiOCVmg/s6Ma0U40HSLcZhEA/t
 B8po017Kc1Gnxb/UVBTtyMxjWluMhj8tge3YBCePEEv1xlex8s1Ko+l588J2HIGr
 DYtIcOipogzgs6ehhaMshg4kL9dSvfmzNuaVFUcqoPL0nKKmjve6o/1kdoQlOBHy
 A+0ecnR3xprMMwKOgYwJjLnfZX62JJV1RjO6/AE3K+vwaBpTjCAh0JXC8NrplnAQ
 YfIM98cKmuMB844Y2ZQ+FBOajf9aw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gwtcnrq5d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 10:50:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVdhRn66yeg3GIJtj3HS9MuH9fo/azhnn8AKrGsY9PhT88kpwwduj4M0QFdd1bwsJaONWYReS2kOAOl/V+ajNQaA1/dCPKhBJ2H9YTE7S/fHdKT7yLekFhdiAih8lcNSDv+h1Z8XZWJP4roRH7iqhzBfGeWZgi7W1tDku+iHCvq51z2DPJTCYcabD7CrJBnSvjBZAUtQ2uNqHr0avxtlJ5AJnefa2bKN1q2NkaTAie09FZaKWipsv54Jn/dln/FMzu52JSD+G6qO50vGsXMrsrPaorogzbKW1LiueMddR3P21QxY6jKkXvDdOPr/in8GasnxrqXvdcWStdlfiSPRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xogLvGD71/ppByclXHxm+CXOOg1vBQku5n+eqdovGNo=;
 b=MOYJw295ymXVrGFJK1O1y53iR4J1j3rDkXrf2cBlPQ9uAIMkJmEq4wPX8Bt2vrk07WlUjoudFcHlFdCmav6USz2j78PX/ZqedHy+inSeFEZdzo7RpzaRzpHJkd9cvewVH261SFKAE7WBAcQubB66wiZmeAsW9DGDlDp2PyVsrpq+yJiHfD27RsiGl/bOxSz23RN35iIvFR1iSHANjyMqYVAqR9nipx0CFtquku6Hagts9cZRhHWogVWPne4MofS5I3PVjYhUAsRQIZvSPCmJ+DiUeNxbC939GUmmNRluKOeWQVhMeSKM5a3yhWfcj1Bv54+TZiEl5nBn6L68ojNWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xogLvGD71/ppByclXHxm+CXOOg1vBQku5n+eqdovGNo=;
 b=iDxpHV7FeJtHsD6IjHTiVPmhpSxCXlEEb3KHPlwpinGnFMZG3nklB2nHrmkHisMGV6ri92XTc+E9g2gDOOC1nvgdTQMVe3TC7M7/ycKo7Z9em7MUEBf4E1IjMJX0DiU1C++SbNfDotnEhOXuFlF+TPHy5AR3Pi5GE19h/6W9POs=
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by IA1PR10MB7288.namprd10.prod.outlook.com (2603:10b6:208:3fc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 15:50:32 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::76) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Fri, 25
 Sep 2026 15:50:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 15:50:28 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 10:49:55 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 10:49:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 10:49:54 -0500
Received: from [10.249.135.163] ([10.249.135.163])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PFnqpx3031493;
 Fri, 25 Sep 2026 10:49:53 -0500
Message-ID: <27a0c3d5-0537-45fe-856a-5f685c2f68d3@ti.com>
Date: Fri, 25 Sep 2026 21:19:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Enable NET_RANDOM_ETHADDR config options for
To: Chintan Vankar <c-vankar@ti.com>, Tom Rini <trini@konsulko.com>
CC: <danishanwar@ti.com>, <u-boot@lists.u-boot-project.org>
References: <20260925110758.843871-1-c-vankar@ti.com>
From: Vignesh Raghanvendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20260925110758.843871-1-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|IA1PR10MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c50a25f-1f3e-4abd-fab7-08df1b1cb8cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: s1myHersx5fTBJge/LGOJh3StQw8daAdQ7T17VLRLf+XVVOCe9qf+6/c1Sy9g6htBy0lmwUSpDM4j4Oqw1A1lG7uSTVs2buBmba/aJ1vVr5tr+lKMpMu/e9Raheq/T4XqoQ7NNCmbhvKFr1v0GmgdMJvUcScrIlS3kVItSv3xPsZdw2Tg8WDykGjT34RK+x7v9ECgXkczy1NqcC4AfZf7SOAc4ViliRnIXnFsh0n1wXRy8G7FX2eTaMgIIQnuNCABGBIMRl2HW2SGoJHvsbtfhPORLMcb2UsB6FjJhrt2B7iQ1AYzWwNp3ytf+DSHbxxwbfsRX744Vq8SKC8lmCgm6nWeioBbcOw8srC+BbiDDn2oVhqU5uvzUcnODaBJksMpDB5txQUepG7jXOI/Tho1bViuZFHOzM8cHUmRrVeZ2NWY0MD6OB5jj9IaXxL3xo3ssj/L4Y5NKHAKCY8mqHPcLQvunVlO1kK3CIeDUlyDAqTQTzs5Tz1cKGy9SMmhMoEFTGy8IkC3DmGQqzb/nBJrExsXfuxWz9ysP/lK2duvcu75Mpv2wcsqxRJtPtrJmPEmwPZS77ZmELcmSEg+EvVxmqUPfnnGPEx9Yhr8TLPeQ6h/v1eSSFh+6p1n2gAWOLLGijNQQXX1JBwtq4WTPPh3DchM4kQfPg/I3/WPfU9xfgBWjOJEZidb9hdo5Uyq33uMpEMlQSTLC7sb+5A1rtU8w==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KM5f6GCpi5HUGjhneCLkCKQ0CDLO1onwDBNjAHeePeCHuz4qO7uqnFBQUxKLcOjdc9esN4c87GA+W+89RweuIbjqThJLVIFMF4jeLEbBpI9ugSOnxyW9PSF5ZSRR3MJvM4TPKnmMxSUGS92gEOE2c0of4u3ZUk5HZ9WDaEExjKqaaB2xgm+uQlXw5bkvZH+5AWFvhcPsiXVR50EWWZkPQ+hxp+9SV3Itzj3AOA4xyOYqysPq75w16kGWHHczDTnWOyaqt2FS7gIc84zRgM8s+tAGFBVdOJ+c9CsPAVunT0ZsMQFdCoakJKFLXdCT8nLXmaUj9sVsk6kV+5CW2wIf2HRyznwEC9DSubQ5c3bUjI5X+VgaVqUeFGMZSakby5TIBjuQg8QKelOGmpeQjXtYGKD8t6YubVStw8MEnnStTyRG5lZ5jxXgw7z76ge34pwu
X-Exchange-RoutingPolicyChecked: W15i32yFM/47wMm4DheiJWlK+KeTiJN5EWfCownvBB64KRixDTXthdUHCedqZTvGsfWm+ZDpHtGmwT4+zG4sdwxBndw09xjtzE3VCxLSUcjpDFAcjz4sjpIaW+cExWvVFMQRKeuRNtTjQHVSqNP6v0tK1+QsnyfL74yMIKvvtASct0Gh2vY/yDYtSdHaPir71aRrjMok1ldX7KZB1MSLXxZ9O8t9/quqmKsUDGWxTIlCq7opRbNJyPpo6P/TRyUf/o4Ftb9nwZDIFklqwwz8PXKCmVRkvsNyNCWv9Bn7P5adHeJMjAX6xfDmy26J4MC/scpaF2sZPn/0kY+Od/An6w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:50:28.2681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c50a25f-1f3e-4abd-fab7-08df1b1cb8cd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7288
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX2hjL/WKS1dtD
 Q8s2wQmguOIkqjf/KwlxGxB4iuUtmDSSShUayaIaYk0J8kWPPruFjZgngC7gr1YeUWSchztR8sa
 AH+lA+tu+d5HPshEHT8iR5KbOW0OSSw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MyBTYWx0ZWRfX7d48lMZgzYpL
 ySIVWXozZMt9We651bduSbq//Ret2MWf7hgF77Ey1Z4GwgsX63yA5p+e2/hdVWpFHbOXaZovD2W
 4zkbuRAStGDQLWmOKgTxtYvH5x1WVq1xTQ2SGzLIB+0MM/EsIztJXEmoc+3fTwWHnpffGynNtGg
 GnFv5bwZgt4STJovDthY57jh6yZVL7YRCCp45SLPoLqSDa+YJpgCf28J8KYDFhyeZE9th67QQbC
 SkeiQOH6BF0fpm60XZVY22gWvIBcBXWSexB/DBZHuJFTlZmxkbLtbUNwnVWxJJG/Vx29L02TX86
 knyXH33vS8sCKYik0RI8pPypO76BllieIt6y2z2BCs6fXn0mNXMz0z5NvV2WsGSORIVBs6+Lq2+
 5EYG/NMMpkBWfBW+slkj2FQCGNqkeCeVVX44Pfh7b6+CLsxKTxiuhx4oFCvlzOwfS7Xym4UC1pz
 ptQrnBI2ngAMZirNGdw==
X-Proofpoint-ORIG-GUID: wQVbiQPT22fQs6TEq2kPqDckGVBYjOuZ
X-Authority-Analysis: v=2.4 cv=P6evFSAu c=1 sm=1 tr=0 ts=6ab6984b cx=c_pps
 a=/+1uodU8fX0iA2MSh+wdtw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=JF85ImcqU3ru2Gb7KZcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wQVbiQPT22fQs6TEq2kPqDckGVBYjOuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250063
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



On 25/09/26 4:37 pm, Chintan Vankar wrote:
> SK-AM64 supports Ethernet boot, to get the MAC address during R5 and A53
> stage enable NET_RANDOM_ETHADDR config options.
> 
> This series is based on commit '9e002445cd0d' of origin/next branch of
> u-boot.
> 

Why not use the actual address allocated for the device via
CTRLMMR_MAC_IDx registers? I guess thats what ROM uses for downloading
the initial bootloader?

> Chintan Vankar (2):
>   configs: am64x_evm_r5_defconfig: Enable NET_RANDOM_ETHADDR config
>     option
>   configs: am64x_evm_a53_defconfig: Enable NET_RANDOM_ETHADDR config
>     option
> 
>  configs/am64x_evm_a53_defconfig | 1 +
>  configs/am64x_evm_r5_defconfig  | 1 +
>  2 files changed, 2 insertions(+)
> 

