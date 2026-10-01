Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4352FCA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 07:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DEF5C407F6;
	Thu,  1 Oct 2026 07:27:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BnC2xfw9dVrg; Thu,  1 Oct 2026 07:27:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1740840A22
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790839648;
	b=ZVdnfK9QpjOSmslyA0tftKwzFGovhr5SKiXfwT/IxMRJIyngj/a6dbj9iGuFfVehJX7P
	 eTmvBUUClQFU3OX1Avq3C8rp8Y2ncH3rlg8JluI4FjaVB46vjWccAID+PR9OFOkpKvLs2
	 aR89rADEph2ov3FBXzJVdK1rjYSW80ZLs9HUQbhIbsrfsXeJyOctlnUdLbJeRbq7wbOqP
	 Ss7GloSCbHtIVSP8nOfabmjmUp8vE4oWO9IV7Xkrhc62+CxsNf+o/A/SoPN7yz5u40ACM
	 mNBSPCqXaCTfTUxsFdRJKrJ2oaQgN3JVGPdXnCs3oBzUbsTSHtdPLZG2DvoMGcBzJsg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790839648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=q9Q2dU1Si4D3npTH990t0pXpIygcW5djWzAMc6aM/O8=;
	b=Ql6fLqepfza12QL/971MODxFTI6Co/DtY+M5c8c34M1U6+JH281Iv7LLDMboSRP4XqsD
	 MolbHU7ehS/OaJBcAFISGu2OvikFtzg3VBYe0R5H08Oi84H6uxpZ54yo7biWTZhcQ/fs6
	 28yY21gBRKbG3oHn551x93O8o4ukLoa0Y9TkL3m9mWsJJwjZOIy6aBqccsR4lZxChc2OL
	 ogak7j2lEOnZWdMQ2SbTCXRcC7haJq+G3HuxUDIlphTB0QWclmzZj5ag6wF0ZIkiAlFpA
	 lEydmw8aOQW7suoeScspzZhNvearI2TN/0yFy6D032ZHE2Ta7x8/o/EtxtJDsnB527Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ManpOeOu;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790839648;
	bh=q9Q2dU1Si4D3npTH990t0pXpIygcW5djWzAMc6aM/O8=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qMJCgHGVZ7YcojbDebRRBIMCxljFyJXFi8CF1AiYg2QilNkDGQ1pRsAdYVuWz8ek1
	 9VM8wpmrLuTRQhxnJWC4KuHG0NdLGaW2kW1sbvAGzUyEEd6gpdoTEpRcZfqi1i8cXD
	 OAHgdNHjl22igRnWLK6kataz/qb22kRsGKNBsfH29TLWkCke5sb86J7bmQ0Dwo2hXN
	 LlLMVrkOSoZ8UdRmfgQEALD2eAaZRLjQO25uM7vJtPIi+IuKl9zgIEorSlk88tZ6OV
	 cjqhgouy+AOq6sCYkFiYIq9IFFqes7r3+DRdIzku6Lb7p+QRBGRRVOypodYUL49o3p
	 lPDu70cP+ShnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1740840A22;
	Thu,  1 Oct 2026 07:27:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BCF434D
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 07:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F155F407F5
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 07:27:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XwQtTAdUrBnm for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 07:27:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C60A2406E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790839646;
 b=j/i6iEf4MA0zM+C2rQ87Uw3r3dcuiOHqDuryRh19o633ZRUDd8wjsP/hWn44giIHAPeS
 qnwLkh+TldztgdVVL8y5pvvCBfq/1kjtCOCGE558HAjsBeoKEOuWyz3YwL7rBW83I7nuw
 8YlrVx6MOzEIOF/lp10Jb5i4csD5x7dS6MjX7CF3ScAE7wxXcYPnpv3pFbMKMusXMn+zW
 51nNUBQVTSK3eOYAoJRJzeco6k8uaDFvWdF7wlZEbur34frZJ4/Klf/DOzJtFuMQ6lbL9
 e23nLELmUYnhEhmxudWIT8Ri1dBe+bZSwF8cOELO9jQV0OFeDho/mrg7Aj0s21n1srg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790839646;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 bh=q9Q2dU1Si4D3npTH990t0pXpIygcW5djWzAMc6aM/O8=;
 b=prEdXykSDcpRTIbRmFYCtVfrDEJirxbq4AnlaQhEOOint7EkFcLXycTXpV8U8gPRtFGE
 mF2+2GwmYBCimWZMqOfWt0Hcggk4mKrMGB4FRj0d5iwJnW5FlIJAogGMwbvZcxjezlKlG
 w8UUJjohBqNISt/PPpmuQR3PlWKnCOFX52JnpowRWHbYVp6Hj02mxeyylMH3AjVx8IY82
 JyWft47GTLX0nJbSXQh0rnbxIuuRbiqjEUzBn+BCiCA2zy4GvE6s3FCJwcKcf7uXX7BV8
 NgF2CnsaE4okUwnWBescNK8+S+LZsc8NAG1ac3ECWNsuLLoz5b+Rtmon+5s45K26zrg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ManpOeOu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=prasad.kummari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ManpOeOu
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C60A2406E6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 07:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6BqRW59Xd6nimVVhjx+0k9+X4gUhjnyEPlmt7bNcprcYRKSbNJNFqAPxwRIss4ML88TW00F7F6VrmUiKrXvGl2Fji4NQy1LIZA7HnrwkWOUJggsdV7eo8TkkuTFcuZ8Qaqj+c6sgWmxHbvYYvd70H103SFconNuNabGvkKbeK31s5VkpkKIZI2QKTz5ve/TEV+qB18paSwk4APfx5TfazAJVi8w0eSSZq+zxtBIcMgW8Kl2aZekF4P7FAKDNuDphaajopDbysD6mp4puiaI5DvV/uh2y5ALkg/z3JPT5HLWYBTS/diCoeyyNM0AEd2wLa4e3fyXBLsfyfY32znwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9Q2dU1Si4D3npTH990t0pXpIygcW5djWzAMc6aM/O8=;
 b=esdmwlwLPqAsdjQlbVCN/UOLS14w/IYBt+YFZANZTJ3XJo5vfb4JTDinHNrm6wLCRfOksepXtQrNa8plaC+pLCkUuXa/LBS8g5tBRyG5uf3CrGwpX2OP8zad265iufl0ZzF2bHtlKItkxa1rLoHcFqBXB0tOCtyxyPJNLUnW9CjtVqGcIcr8vKLMH7fntbZ85/hqXHKFQz+96BII3uD6d0Kry2sqca3OVNhVXKFDoWlyhc10I0nRF2jWCNCd3BRbS8mxuTYCyw9YjV1BAeyp9mJpsUIFqnDw5MdqbQ51eTDmIUUOfBT9XDscZJd90AOh1JwHYFmIpQoc/lP4lrsJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9Q2dU1Si4D3npTH990t0pXpIygcW5djWzAMc6aM/O8=;
 b=ManpOeOudXWzPtOXrwNt+1y5WybM5C7oXuSUIPMze7W3PQSVdTdOPXSNnsc0vAutqC5zPPILMZSUeZb3swQU1G94CvvepzbwRNM5NwRhefL7u2eNXuzw9SggQvQB/0w61dLqG01A2yf1JWOhPVe/94I0PpkH1ePY+4/WCEYe8ag=
Received: from CH0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:610:cd::6)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 07:27:16 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:610:cd:cafe::4d) by CH0PR03CA0091.outlook.office365.com
 (2603:10b6:610:cd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 07:27:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 07:27:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 02:26:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 02:26:33 -0500
Received: from xhdkummari50x.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 02:26:31 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <padmarao.begari@amd.com>,
 <akshay.belsare@amd.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] rsa: fix undersized modulus buffers in rsa_gen_key_prop()
Date: Thu, 1 Oct 2026 12:46:20 +0530
Message-ID: <20261001071620.2377255-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6a7413-0558-4a0a-0159-08df1f8d6abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: hExsI0uzfGjM+KPcG/vioIPwxJwWjnPeXVtFrRCNgvgI/vlPU8u/AfmkkM1oaKcYA1OfUPlWA4IxwPw2osSqzdjKwA1jTnxUhu6HMT0g6n9TAiZSSJ/8tpaoDYr9jIQDq12NiHK3qZVAQ7tduhcy+vlW5WC2cl86S2yvA+hFIwl42eVLHDlVXfHmONHjmttFHA9wpOxI4qU+OE8lrFva5Bf6WuSSLMl6NhVvAyWPfooPy/kyzaOP31pb+UyIc4OkjbsYGwn9Ccq27gZbfR++RyBF/tI0QsKV0hE08GPCwKmq1uzk19H/WqRFzg/jBqkiiPBkrPuMdKjH26IEL3xqxLil2ZrlWM0EJeVAmrBMnOPJoXtoIjXi5kF8aFHrQ8bWIrTXMB4tuGO1Dv7ZcNlu0Tm9AT9seMY4teZJIW7+mX62QZM3PaTYotIpREFF2VCIL6w+TSMd+QnmqDowBuwJir2SBBZsa1x7SM3ebWXz9Bul4vu6xwa1zEMTv64rwjDTAJP4nQaGa3c2754LbkphmKOF2QY1P6DRj+tCyqaJQXtAxaeq/BQXnFKY7sb6rqoY3QtNnkTOOddRdkaJ9xkuVcV0VmRuNyH0t1xCQzOeHJbuEVzVyxMy/sTNQD0SJ1Gtea1tsSqAi+rKtwbQXDZtvAJr4VbxAkqeWfWKIFOLBGfYa/7JFG+rZHTw+B50YG7AuLcdoCMvO7SjSn8P5m8kYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IrBbBZMPc9avPDQkz1C2pTK2FvrlFnIqlZgVKtrBUnOyhhaxA+zyUjQgfLqoIYqCZmY1WzEdfeqpjpKaoTOqctvj23L4Q3H5DelLxhJ08gXzY9hJ2QqBc5rR63Gm5SgEzR9XwAi/ia3uxMinJ3Gx42YPutm87zwMXYbHWAFRXV776QvvWXwFPVQWBAaIkVj9P+VbdlneBT1P6WeP5zrvWsfw4HmW/UdPpbm5+xPTs0uWOVnsOrmZ+7+fcm91+wH2TbRFajBxgDU482FPNf825f2OyqCwFacHqYVB4s8Bl8FySijjPEnFaCjcpexSpgMhe125E63JzSM/DbQqAc5exijTERkiTUJs1ZoDKizjvL+mJcJIJIOfJDlkZW+E0wffG3ibJDIJCjft9w0rqppya3U9iUhEOcrpqCaS6wRgFRUdByE9xfM9wlMCDaTc6Jsb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:27:15.1079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6a7413-0558-4a0a-0159-08df1f8d6abd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
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

n and rr are sized with a floor division by 32 (num_bits >> 5), but
br_i32_decode() and the zero-init loop before br_i32_reduce() need
ceil(bits/32) words plus a header word. Whenever the stripped modulus
byte length isn't a multiple of 4, br_i32_decode() writes one word
past the end of n; whenever it's odd, the zero-init loop writes one
zero word past the end of rr. The modulus length is fully
attacker-controlled via the DER public key's ASN.1 INTEGER length, so
both overflows are reachable with a crafted key.

Switch both allocations to ceiling division so they always hold the
full word count each site writes. rrtmp is already exactly sized and
is left unchanged.

Fixes: 49d0ea3746ca ("lib: rsa: fix allocated size for rr and rrtmp in rsa_gen_key_prop()")
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
UT:
Tested on sandbox without fix:

=> ut lib lib_rsa_keyprop_oob
Test: lib_rsa_keyprop_oob: rsa.c
rsa_gen_key_prop: n_sz=257 leading_zeros=0 stripped_bytes=257
num_bits=2056
rsa_gen_key_prop: n_words=65 rr_words=129 rrtmp_words=130
n=000000001a0a5ae0 rr=000000001a0a5bf0 rrtmp=000000001a0a7010 (UNFIXED
sizing)
rsa_gen_key_prop: br_i32_decode(n) done, n[0] (bit_length)=2056
n0inv_input n[1]=0x968b6a4d
rsa_gen_key_prop: rlen=4112 rr zero-init loop wrote indices 1..129
rsa_gen_key_prop: br_i32_reduce(rr) done, rr[0] (bit_length)=2056
Tests run: 1, 0 ms, average: 0 ms, failures: 0

Tested on sandbox with fix:

=> ut lib lib_rsa_keyprop_oob
Test: lib_rsa_keyprop_oob: rsa.c
rsa_gen_key_prop: n_sz=257 leading_zeros=0 stripped_bytes=257
num_bits=2056
rsa_gen_key_prop: n_words=66 rr_words=130 rrtmp_words=130
n=000000001a0a5ae0 rr=000000001a0a5bf0 rrtmp=000000001a0a7010
rsa_gen_key_prop: br_i32_decode(n) done, n[0] (bit_length)=2056
n0inv_input n[1]=0x968b6a4d
rsa_gen_key_prop: rlen=4112 rr zero-init loop wrote indices 1..129
rsa_gen_key_prop: br_i32_reduce(rr) done, rr[0] (bit_length)=2056
Tests run: 1, 1 ms, average: 1 ms, failures: 0

Tested on versal2 without fix:

versal2> ut lib lib_rsa_keyprop_oob
Test: lib_rsa_keyprop_oob: rsa.c
rsa_gen_key_prop: n_sz=257 leading_zeros=0 stripped_bytes=257
num_bits=2056
rsa_gen_key_prop: n_words=65 rr_words=129 rrtmp_words=130
n=000000007bf027a0 rr=000000007bf028b0 rrtmp=000000007bf02ac0 (UNFIXED
sizing)
rsa_gen_key_prop: br_i32_decode(n) done, n[0] (bit_length)=2056
n0inv_input n[1]=0x968b6a4d
rsa_gen_key_prop: rlen=4112 rr zero-init loop wrote indices 1..129
rsa_gen_key_prop: br_i32_reduce(rr) done, rr[0] (bit_length)=2056
Tests run: 1, 39 ms, average: 39 ms, failures: 0

Tested on vek385 with fix:

versal2> ut lib lib_rsa_keyprop_oob
Test: lib_rsa_keyprop_oob: rsa.c
rsa_gen_key_prop: n_sz=257 leading_zeros=0 stripped_bytes=257
num_bits=2056
rsa_gen_key_prop: n_words=66 rr_words=130 rrtmp_words=130
n=000000007bf027a0 rr=000000007bf028b0 rrtmp=000000007bf02ac0
rsa_gen_key_prop: br_i32_decode(n) done, n[0] (bit_length)=2056
n0inv_input n[1]=0x968b6a4d
rsa_gen_key_prop: rlen=4112 rr zero-init loop wrote indices 1..129
rsa_gen_key_prop: br_i32_reduce(rr) done, rr[0] (bit_length)=2056
Tests run: 1, 38 ms, average: 38 ms, failures: 0

 lib/rsa/rsa-keyprop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/rsa/rsa-keyprop.c b/lib/rsa/rsa-keyprop.c
index 80d0594a430..9b5aa1114e3 100644
--- a/lib/rsa/rsa-keyprop.c
+++ b/lib/rsa/rsa-keyprop.c
@@ -677,8 +677,8 @@ int rsa_gen_key_prop(const void *key, uint32_t keylen, struct key_prop **prop)
 	}
 	memcpy((void *)(*prop)->modulus, &rsa_key.n[i], rsa_key.n_sz - i);
 
-	n = calloc(sizeof(uint32_t), 1 + ((*prop)->num_bits >> 5));
-	rr = calloc(sizeof(uint32_t), 1 + (((*prop)->num_bits * 2) >> 5));
+	n = calloc(sizeof(uint32_t), 1 + (((*prop)->num_bits + 31) >> 5));
+	rr = calloc(sizeof(uint32_t), 1 + ((((*prop)->num_bits * 2) + 31) >> 5));
 	rrtmp = calloc(sizeof(uint32_t), 2 + (((*prop)->num_bits * 2) >> 5));
 	if (!n || !rr || !rrtmp) {
 		ret = -ENOMEM;
-- 
2.43.0

