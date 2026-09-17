Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438AEC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE55F60845;
	Thu, 17 Sep 2026 09:32:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GxwTZt27yAst; Thu, 17 Sep 2026 09:32:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D383160838
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789637527;
	b=jTKdUSAXacaVGA7hUz/HTDNfD93luQint/yXsrRO37M8LAe64OMqKfv6N8Y6y259sXvv
	 FYe+BXzjXpydg34GLKC0Am6rp9Y0p0/Xi/vAV4K7O5KTT9p66aLro9j1N52GE7lFwbmSj
	 DYob4ni9/j50dfdGdQdbYvzMGWLmRG2heir0y3PF2DIuK33KmbsTubPwncHmOi7zRDWfM
	 3obut4DP/AWeTbN2ERe83T4FFKFQfanJCar0vOOqFkhREZUPGemlP0P997apa+fPm0T3W
	 rUrSHXBqxatMFQHhetAyh+NxXFm8Cl88+TiddUHurz1fFAxilz9aA+vdiq2aSGctQvg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789637527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:References:
	 Content-Language:From:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 X-CodeTwoProcessed:X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=2eZuiSMmXu2/Y826LOn3dw/2h1stdONB+UNhCaqVphA=;
	b=SDwpnaoCF7fOGsXGI6FjmDlSq40XQY9G6JF+eWSKtLgjp+dULaoPx4tO0cNgYmRQYrXa
	 yM0zsaJKGhVN28k4nmCmhKuqweQJt6DRfMF6/Xja+JkBg7L7rbke766vjATqHD5jjRN3d
	 fYlPf1zGsYomvg4/3DzzgejJH5KmQ0Gw9vKF70Ewf+dHYh7WNwvL8yuXTDlzSSdk1EUxO
	 6I780HHTR4OeIJOX2R0HSSWN5af+tiieX93eyfLafvgltl6o38tOlhxUG7OaswoJh22mg
	 MNRH6yPY79CaBG5Kfd+Dzj4XV7hg9c8df5XQO3kSRy1Qm5OR2v/HPmAsObztnuMKwbA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789637527;
	bh=2eZuiSMmXu2/Y826LOn3dw/2h1stdONB+UNhCaqVphA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JE8qvpc1UVKc0e0sex92jntw92ES8ZmP0k8+djrOCtURMWhK+b0IShXvgZxY0+fwu
	 ZsYrOuViZ8F7hhak+WNOjhppz1AZhZdIwMJ2AkEYdQ8pU5FPE+CqQvSOEmav71vdkR
	 Wz9ZvsCkhZbujhVfJArhYGAhMautYo4UqUUZL83NmnXX5WrguKja0cnJ5R/Nd+GL4t
	 3PfGkpImWY7cM3vBkVnQU2s/zM1K7I6ZNtysPtwQntZBGV6Hc2zvORK2R/Nf4zD06F
	 pe8UPaOvt8oCI8I4x1MCflXcit9KEEaaG43IiXG2Qc1Kn3c7po6sToV57UlmFw1mX/
	 COGS+Pr/B0PSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D383160838;
	Thu, 17 Sep 2026 09:32:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B37F422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4E8C40750
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:32:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hwLPEwvQhLNv for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:32:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 946A9406FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789637524;
 b=VcDl+oV9s4Nyhi5+CcPjU3Au21S9+wdN4lMBvbkIENsV8+EXZWgqK+V7cMZ91B9McJVh
 Qkv9uEtaJ/HjR7kXBySQ5ldpduQCyz4GjGTbUU5dQX3SZJIU+/WezBpne7BZkqi059oWB
 d10gxqjKwwXDElD/riK5lddmpTQk0CMf1K4znMOO5Vv4+3zhFlImgTRqAVBHPIXBKJ1wP
 3nzNHtfqV1AFs/SnE20OqTXMbgz/UrO1FcTmeLoEfLGwUZVKR9hguWI3+FX1TVsrWykQT
 xzZkaXcpY4pvCtGfYTOw+QCcObjOesUyBFw5aTQXzobiWnDlGZf8XhhJRc6SRGf0MNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789637524;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Authentication-Results-Original:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:Organization:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
 X-CodeTwoProcessed:X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 bh=2eZuiSMmXu2/Y826LOn3dw/2h1stdONB+UNhCaqVphA=;
 b=E8+xATSyrXPmR07PXHy/FuvBFHq8rU6PAPKKznxpv+mMGBVFyBkYXCARE39J6dB0vVOC
 I4Zn1caIZsvsLadYwtVGSmiYrsE/LFrwuk8XK3NqAoijGULK6OLfF4wuQ/uHCtJvCh7Vr
 JfsAMqx0xp9Ely7gBi2picAXf1SialIUiSGSkF/VfC/C095rfjNeKPDUeaDSGoIPAhPsf
 1GgFj0/8vLxG7jST5JSrrrvjB8EXTVhVyvSOx9pTOC4DiTcnI4/29YTxuRRdGuJXYQZef
 AM3Y9Yko3nRV/0DBrNEpjrDjBjV/15q5RLqA8+fQCBeTanIYmApDyLa5H5bLE1mn1mg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=topic.nl; 
 dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=XxZPNTb7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=mike.looijmans@topic.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=XxZPNTb7
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 946A9406FB
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAIXxvtCJH+mnEToDlN0fycGYHA0RONYIiNFjs8yTk+q8GTAmoAh5fykfSeDaIvLfWw+b0h4DRnbNnw/rITYTkoFZUcldazwzuAExSMZlVIsic/yKpMi4hfw1msWC+BI/+hT5AfD1WL69ZtXXzfB7jRErVFoOJ+zVBC+jjLpebUNuehD9rOOTSraP7tqYz+REKHL4D2Kjek92a5XlD2PYJOTQ+r8aMxUpRM6mTOHOw/zmLExDgCMg2Cd4e7sF5koXDdwHNd4TyOdpAQspTQfQAUM6wP5EBanJ5xwUaazs9rfelvyvNh42o0ekyitIpCiCYcywc1tuJUPdd4VCiChvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eZuiSMmXu2/Y826LOn3dw/2h1stdONB+UNhCaqVphA=;
 b=p2k3ib2flS5J+/ASrD6KNb/5SPV1vxy+Wd3tczmRv93Yw92oWSdkJc3ajKJxePd2oa3LS5jqn6SypDfHhfpc9oBYs3779jpBxP5pJSsaA4SNNWvWNwVhte8r5uBhlg+x3q1f8aTeOVCdWE6B2ZKGCzoPnVFZvZyjW+XewJBtjvLksFVqhIsnOJcjD+qbdiKG/p2GG9yfX3qSQM5f+quetfBMHK1VZXgeBD8ZZABT6oZl+qglb0HG702EX01OoYmq9QC1Kcq6ULjW3cb5lQgCWPgreub/gjMM4BvuIcAC71M86Hr+wllAT8VrITHaTUwxVDJX701s1XLJl3+DALh5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=topic.nl; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=topic.nl; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eZuiSMmXu2/Y826LOn3dw/2h1stdONB+UNhCaqVphA=;
 b=XxZPNTb7SxpQ0NaBoS3LwKDfPGqTHVmcXL+NZJN2RW1wcS5Imeoqb6P8YlWfrTdAOkuuj2fc9OERRgalZJLlrrIgPUhtOwtfDNn3JzQ3SaEYqJqC9gdjTGoHy1O3guVltsZbIMeE77s6fGwoMaOeO6b0ZalJdTShYFRPK3rKu4L4UbSEDXeB/5eK+CRmh9uu3opA1bZxLB/hvP3jz9qDia8bZ9wZ/OeNfKceOtxdVH1DwvmVgyUmzlM8FN7+iccO5dylme5G2+NwyAl9TwDCBDBzhG9Tqysu8KlSunaHXEVwEts9In45vF7Qx9LkqSLfjGepKyZzZxJXGwplV8Z0nQ==
Received: from DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) by AM0PR04MB238523.eurprd04.prod.outlook.com
 (2603:10a6:20b:7f9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:31:56 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::84) by DUZPR01CA0088.outlook.office365.com
 (2603:10a6:10:46a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 09:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:31:55 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.68) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Thu, 17 Sep 2026 09:31:54 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by DB8PR04MB6777.eurprd04.prod.outlook.com
 (2603:10a6:10:11f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:31:53 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 09:31:53 +0000
Message-ID: <cf721bcf-d2e1-4ab0-8311-8b4afdc1934a@topic.nl>
Date: Thu, 17 Sep 2026 11:31:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mtd: spi: Expose SPI-NOR as a GPT-capable MTD block
 device
To: u-boot@lists.u-boot-project.org
References: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.67031a70-ac53-471b-b4b0-0a834c310cf8@emailsignatures365.codetwo.com>
Content-Language: nl, en-US
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
In-Reply-To: <20260917-series1-spinor-mtd-gpt-v1-0-d065abbc7454@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0036.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::16) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR04MB12030:EE_|DB8PR04MB6777:EE_|DB3PEPF0000885D:EE_|AM0PR04MB238523:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b97e82-85ed-442d-90be-08df149e8398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|3023799007|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 1pDJsM5Aq9p9FVRX7rGvmFlWMSjBNer73otw8AcMiTjm9c9wu0+69/vEhXVpkmncwqB9bYWgRX8Ed0vHJ8UYKxOtJfKXqaxUPXiq0G3PVOISYBCKBFYTOKBDtgix5WukdWST8PPqmQSYC+4ZlJL9pYlKePPRABnYZ2k+iI/IT1s5OT4W+6qANenFp2S3+T4Em3i05TnZdwuuvv6bQjZgQBe326i3f3CXRv99emhfoS/L9r+YjSsdwuqhvPSHNw6YsOIZSADSEZI40nYky2ZOj2s9SdbBJSCajexMHV/3UAU1Z6BBercQpIVC8lB22eepb+fUsIrnQTZIgSRTNYiIZ/BLtGchJnTH//DkJt9S2Dmxpous+qfiJhcl2ZNdOlBobBw/HBZvr/VBtqfZKqGkXF/g1M4lPRLAKi/cQHhvriVKgQ8j+yszB45qo3Gj+zb0efekFVyRYOCJOQ2R87iLBJa07nNMpYiYtmLx2Rn8ZHdaRf4K692TlqCf/LyjC8o2VGpfuVrPRwPKERbdRyfmB274mWJh+cHDGTs1RPQ2FF5nIpAMzNwCt74U8UsEz9OxIS1654roHnU6K1eVXdQD77SWOLL7ekap9uXH+zruvdR/ZuNK6vdLmS9asydgMUjO48ppoaRqBZyQG8a2XSyx2Qk3A+9afG6bcW8SIf3ObU4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR04MB12030.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(3023799007)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: svQCpCpfudYQw5CXmpbKlK/tDF0f39F922a06AE6ITVKDUbsB+MOvklOzOqyrHTJJEbtKwwwc6tMsMX4ryrHZH9dYohA1U4jO0iAdkFbfvmbvheVUcDZ1G7KWbfc+0t4BtxvDUXcHAz3KGZH0bdQ5CuoqqS9xLgsoLje79gXgODshaZ8S/GB0C3Nnn0iagy+8kCNp50Xn7JTnnDCjqM6vDiDDJp2ZMhL/JsYiocf6JtuewI0r94TFZ5JbX5NKiRjIwPftW7qXIAHD9lktAh4ZKehYcQggFBM7IYV79LAMv/6WbA0MO150ACf44bS8vsSjQB3TNsdePTrtkXrN+2OQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777
X-CodeTwo-MessageID: eef1996f-24cc-47e2-b160-18b3371fd9f2.20260917093154@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 064a22c2-f67a-4209-1d7e-08df149e820a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|14060799003|36860700016|1800799024|35042699022|82310400026|376014|10067099003|3023799007|6133799003|18002099003|22082099003|56012099006|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: W5yBl33s3Fk8rNkjEwX4LVlY5cVXQEbFdCXWlQ2jsKlRjtcXdt+iBxwzZo0no6qUIwzeUMVrkN0WEPBgjq3FgjyLztfJYFidC1826MPVdHsv3vrbuWUmRhPGQUwMuXxuU4TaX40vUSosUs4CEVtbAHnKoTnf+a0jEh3uOKWjF42oRXfp5Aqa6jwG6ySPgyN2+5jodmjBcnJ5vFGs/heCdZOb5mxukC7rJZVfEzWYVgnJXwO5RlXwHW+d+khflj17bGu2QXZVRikGkQ1oljTSUj6LG+dup+sBs1VapHTayjLlRT9VaWuQk9l80Dakj6yWmSfU3+gwcRHVDo56H7FJqUl9TRhZC5q8ddzfO2Wu5ILsgvitfHYDLkbfd14GqPo4EwW6/sKSNIoubz1h/XYqxyJsgaj2BA+L9XP7LQPvMjhCijH7eoSObT7UTNoEawxigsO3iTPS2iiIROccEFsBm6DezHR8M8QlgR+PbXl6oNFQeUKIwgihGPKd/nnZUQdVE37yUJ+Uxc5NhriekvZrIGq0Safk69D9n5lHjVXS7XuFxQwxlePaCxauhx/GM3vN7owt3XNLobQjpljbYf9H172V74F1BUx/rCCs+g6loCX5d5h/wLwXTF3Fo2/nwcABp8PK1M0sT64xL3cgp61+Zw==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(23010399003)(14060799003)(36860700016)(1800799024)(35042699022)(82310400026)(376014)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bRLZftjjsXevHza4t5Ct8m2RZDPDzK12vrzAfoySKl56XE/5hjTTeXpnXcf5hWybqtsQQamhp+2edExWW60Tl4t50MAxqiZGe2KH8AQ8fqJlAhwy1pHt8j25Lbf/sO4gwFX4ex2n7fwft7nPHgWpPJfndgMzo3wGP2eQjn78KP30U4dZUVSd9qh4uzzTwsvvyPMondKygvl1e1US8mbUghZOQd3lQQifaZuCrqXsZ5JHgUykJNpJo5xtaA1y8Iy75GiNoJASAEfyxpuZLsanmHNkz1/pS0Oh0kyOHwdvII1V8KE6jY/URABBvMFj8BG9WrHlK7Dvk6lQenIVeNWOTqwRfP3TwsQjN5AhV21rXKBWoTw4AnYUHFfh2cIdaLmSlxV7THCDqfA7FbYx9Cpmb9PvevSIOD3h5cyvtgdO8IRzo1x1y+GnvV56ZioVXNcX
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:31:55.4647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b97e82-85ed-442d-90be-08df149e8398
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB238523
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

Nice, I've quickly applied this patch, it indeed fixed a bunch of missing=20
things, however, something about the partitioning is still missing.

I have a SPI NOR device, which has two partitions, one for the bootloader a=
nd=20
one for the rootfs. The rootfs is populated with a squashfs that u-boot can=
=20
also read (works with MMC).

The MTD block device now registers, but the partitioning isn't hooked up=20
properly yet. The MTD partitions don't appear until I run the "mtd list"=20
command. And attempting to access the partitions also doesn't work.

Example serial session:

ZynqMP> part list mtd 0

Partition Map for mtd device 0=C2=A0 --=C2=A0 =C2=A0Partition Type: MTD

ZynqMP> mtd list
List of MTD devices:
* nor0
 =C2=A0 - device: flash@0
 =C2=A0 - parent: spi@ff0f0000
 =C2=A0 - driver: jedec_spi_nor
 =C2=A0 - path: /axi/spi@ff0f0000/flash@0
 =C2=A0 - type: NOR flash
 =C2=A0 - block size: 0x20000 bytes
 =C2=A0 - min I/O: 0x1 bytes
 =C2=A0 - 0x000000000000-0x000010000000 : "nor0"
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - 0x000000000000-0x000000180000 : "qspi=
-boot-bin"
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - 0x000000180000-0x000010000000 : "qspi=
-rootfs"
ZynqMP> part list mtd 0

Partition Map for mtd device 0=C2=A0 --=C2=A0 =C2=A0Partition Type: MTD

- 0x000000000000-0x000000180000 : "qspi-boot-bin"
- 0x000000180000-0x000010000000 : "qspi-rootfs"
ZynqMP> ls mtd 0:2
** Invalid partition 2 **
Couldn't find partition mtd 0:2
ZynqMP> ls mtd 0:1
** Invalid partition type "" (expect "U-Boot")
Couldn't find partition mtd 0:1


On 9/17/26 08:59, Vandhiadevan Karunamoorthy wrote:
> This series lets SPI-NOR flash be exposed through the existing MTD
> block (UCLASS_MTD) device, so it can be partitioned with a standard
> GPT/MBR table and addressed like any other block device (e.g. by
> fastboot, "part", or "gpt" commands), instead of requiring the
> mtdparts=3D command-line partitioning scheme.
>
> Patch 1 is a standalone bugfix: mtd_blk_probe() never set
> bdesc->lba, so any MTD-backed block device reported zero blocks and
> could not be scanned for a partition table. This affects all MTD
> block devices, not just SPI-NOR.
>
> Patch 2 wires sf_probe.c to bind the SPI-NOR device into the MTD
> block subsystem via the existing mtd_bind() (no signature change),
> using a fixed 4 KB logical block size (new CONFIG_MTD_BLOCK_SIZE
> Kconfig value) instead of mtd_bind()'s 512-byte default, matching the
> sector size GPT images are generated with.
>
> Patch 3 fixes blk_get_devnum_by_uclass_idname() so a block device
> whose declared uclass_id (UCLASS_MTD, set by mtd_bind()) differs
> from its parent's uclass (UCLASS_SPI_FLASH) can still be looked up by
> interface name -- required for the "mtd" interface to work at all
> via the generic block lookup helpers.
>
> Patch 4 is a standalone bugfix found while validating this series:
> part_init() takes a fast path when a block device's part_type is
> already cached (e.g. PART_TYPE_MTD from a prior probe), so a GPT
> written via fastboot to a previously-probed SPI-NOR block device
> kept reporting the stale MTD type instead of switching to EFI. Force
> re-detection after writing a new GPT so the device is recognized
> correctly on the next partition lookup.
>
> No existing API signatures are changed and no new Kconfig-gated
> behavior is introduced for devices that don't opt in.
>
> ---
> To: u-boot@lists.u-boot-project.org
> To: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Anurag Dutta <a-dutta@ti.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Udit Kumar <u-kumar1@ti.com>
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss=
.qualcomm.com>
>
> ---
> Vandhiadevan Karunamoorthy (4):
>        mtd: mtdblock: fix lba not being set on MTD block devices
>        mtd: spi: sf_probe: bind SPI-NOR into MTD block subsystem
>        blk: uclass: dispatch UCLASS_MTD lookups by block descriptor
>        disk: part_efi: force partition re-detection after GPT write
>
>   disk/part_efi.c            |  2 ++
>   drivers/block/blk-uclass.c |  3 +++
>   drivers/mtd/Kconfig        |  9 +++++++++
>   drivers/mtd/mtdblock.c     |  2 ++
>   drivers/mtd/spi/sf_probe.c | 35 +++++++++++++++++++++++++++++++++++
>   5 files changed, 51 insertions(+)
> ---
> base-commit: a57e30ef46731309e7120d2900d294ac934f7609
> change-id: 20260824-series1-spinor-mtd-gpt-c3694cb91fa7
>
> Best regards,
> --
> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
