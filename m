Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71176CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 14:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9C1F60B33;
	Fri, 16 Oct 2026 14:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n4eg5WKTrM6D; Fri, 16 Oct 2026 14:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 26A3C60B1E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792162700;
	b=DRzKohx9Nq1B4VEWicVEOsP43WWE3uNsYQ+QoqIx07t/+VK0fFMFThG4PUlHABLVpl1O
	 mUYVi+isp6YRA4sk6RI/gLBiLOE59k2SSSx/xW5ZDnDh00iTSYxqOMDxgcS8CWq7QcPX+
	 mMxjm8gEbA3iZvrzhiVpJHQ338/fTktBHDbXlVItLY+ouSFK/6PZ9pdHtAiVEcaFN9T93
	 wZenDlNzP7NVq8T0EwtXaWpJxoO+QxfqTV+CuB88zkH6oAaYj/R8rx29sM5tq1inhf+9B
	 fLsV2QrdANNV65zrsquq8mvgYFJJR+U+keuV316JOQeV3wRHrjHaFwM/MyZDUCw91xw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792162700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+RzKecp+H1yhXDKmEos7gcoxucT5M02HbKuDHnIbjFI=;
	b=Fijiy3GVOnPFCI5LmAB7SmrBpYbLmLo0+CeqaAgLNRaGHQ53KMy9sClzxH9CtWvju0NR
	 OwSUSnOmiKq9VXAtlgojrWCLuPvHcpvTgMeAnuCbpMYiMBhF8SzadzZ9sPrGTij6NHX5W
	 WW1HYimZa6E7PNXL+a+GSXaVRpQr/8VTIvf66UWBX+s9NaBfTg9ttdSCFImCSzHi7BRO1
	 sIlqTcwvNi+it0VK7xFqr0OP4ZvfDseIx+YBh+mKEQCak/C3kBz/Lq1S6QU42pilH73H6
	 fL/hQHuat0XmM9wxnNtREx4Pmp8BzWWh6k4wvjn09zw2tC6unz5tQUtchfEFzrXRlRw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=BN9RSpNb;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792162700;
	bh=+RzKecp+H1yhXDKmEos7gcoxucT5M02HbKuDHnIbjFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q4OE/FyaICdRCdp3OAoB+onFgzQmD2yPXZTDyO+CCviKY4HY0RcCIhk40esfuePbF
	 etcBNpXaw3U5FHkhHfw7ERFcgOVw4BNtYQSBIY2ZUhOe49R7zkfWvVzz+jgreWw/55
	 QC1i+xbiqIYoxZl1ryj5pOzf5p4qgFzmXwYuUiYaoYFnYVdYXZsaxsnI+9Ibj3cw00
	 m2XnBmjotc8CB3QCia79LQPNh/HuT+KEmGsvMZZ9FZkhwQu7K0xk5tO1BdnEUwD9sy
	 qjbBJ1DyHO6Araqms75lUGizo9IR/9Cy3cr1mYTSqvnjEejVXPb4yFAdaRMxi+rnG5
	 uVrxsWbUG/gLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26A3C60B1E;
	Fri, 16 Oct 2026 14:58:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A37D769
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1BE3960B29
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3E1u_fJwo_f9 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 14:58:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2E7F60ADF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792162698;
 b=YIg4RFZj+lgJPRlF0ISPD5taRu4KsPDx5Xqo06fAUBoPVIKEJTD1G/G5APCCy6yiaPn9
 tGF/UqxoRaR5m5/nJgIzgZ462ebiSsR5UV2ubs/P7wqiIvIJCTzAwmk/rroXX9y9ZhBCJ
 3r6qkJ/34lticcdo+JLQ6JkqbSMg/nIVpeEVg8GqMvhOFgV5RZbH4WHbxjfTtN4yZSFno
 O+L6v7CKL1soytUNgncnsFrcJETbfzEJu+FmvFPQiK5teOIl+gr9lDK3LZNcXf5I/Lod/
 SOlm2dZPuW4bA63+8YPoQdU4963O73PtJokOn+oKlNouApc93W1u7LzXccjkT7zv8HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792162698;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=+RzKecp+H1yhXDKmEos7gcoxucT5M02HbKuDHnIbjFI=;
 b=pitrf7wN2JR0MateAvSEzYiwzoaOMxG/nCFhSF9bxWBKJZKd1qYpr3+gd4X0TrooOmvV
 nZ+T4nO8bbhPv94d+aSBNzvAme8hqxpAGiFlpEVIzLsP/jo2j9nB/oeNMwvsg6sX0uAjP
 PafB5UXQXFTs0OgqFH9XN7iS8qXNuCg91rkXbK5swBvBzkhl81VZCZ2l9iWX+eQPKQNQ4
 thhTzXX5wdic0NwiVJ7DEmiLD6DEBqY85tY2zAw6rSwgGNu1881eTg6j96x3knJvcLi1f
 JtQ+rJKxsGF0mVq093iAsA+lKEQRt1IcQG+PerY70VI6OuGRLt+CqjFkkjNRw3mA9Tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=BN9RSpNb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=BN9RSpNb
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2E7F60ADF
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoL9FyfBNABy3JodHJyGlOUsSM8KeDfRhQqxVF7aLoOoMsXyX4lZzygjB9p6cikCyaX0G2QYPIJtW9bN2SJ3tbjPkOzSc++iinIBvrPAY8FesVzHkPFTH+Nr0CLsx/xqAvKQspDbKD3q4yD0ba0iA1RmWP+hISc6o3zmb2eemvHEmp1ByD1Aot4Q+UyN63SiXXSmwn1O/L70/o+SAUwrjsRZ4aw7jHOOvbaI4WD5zqNZvyAt/l5cBaNYMXa8di2x3WkW1LN8umj3g2Z3VutEGGkatFtmmuxYHsZC4Qt6Hxytm70xx/HEZWOeZRfQ6XbJivjF2qOgsi0REQlGwGON9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RzKecp+H1yhXDKmEos7gcoxucT5M02HbKuDHnIbjFI=;
 b=ycofmg6a2hV45lTn84A6+dgrltSJUuQV9fiKXdqDd4vvnmfDKEWhVCT0gGTg8pUTx7/5BwaIViBeSlb7H/lpP50pWtys/L0lxXRABBV1+1E0wddl7NMlk1FvQc+sFbKzKTZOihqG1Cb1vi9O0RV2k6aDlKkLiclXwa4Eshq1eUh493EMYKZpxzV3qTj45nsLp4JHrgteZk3qXMt1Sgg6XfDWJGaVZstkwvki8vQYWvOlIEu8QMuV7EBYQTyZxiojZ27GerBPYj4ntavWjYYrf8KYCWrq/Loev+4aYg9yiHphcFI2wRmO8lenrJZE9722sj3vKWFhNMRdDiSA0rxAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RzKecp+H1yhXDKmEos7gcoxucT5M02HbKuDHnIbjFI=;
 b=BN9RSpNbdKtYQX9fK9NsoZac0+O0BhQSG56O099/TbpynhR1yvMflkWt80fG6tB0E5YZ26qYdhX1jjBmVyFgYi+zcUrrf9vANTvxGlChYotFpU7fXmMQinMPjKe8Ba4kc8kc3TG6JzTw4vd9S/CBhsGxDDokuatU4eOfk9iWei0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7797.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:58:12 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 14:58:12 +0000
Message-ID: <67a1c467-c8fe-42f9-9460-a4121d542c2b@cherry.de>
Date: Fri, 16 Oct 2026 16:58:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: rk3528: Split out common NanoPi
 u-boot.dtsi
To: HystericalDragons@proton.me, u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
 <20261012-nanopi-r28s-v2-1-3d162759dd3d@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261012-nanopi-r28s-v2-1-3d162759dd3d@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0285.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::6) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 624eae67-b604-4ec7-8bdf-08df2b95e636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|4143699003|11063799006|10067099003|56012099006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: gb6XLet6XTnWfP8s4C02eZX743co4eBA98u+wseZIUvAlYYur1VI+LdJaa643/zxOv0iSY0cnzpZOSc50Y3+VsSlb2AKq5nhYadG38kKlbl9Iow6uQUE1Ec8C4ewBt9iOpzSZqAkIYETOvsVEE+7OUHIuWp8bZWZt9j4bf4NzpA3R2cC6NL5VXasSiBkwqdvepNUMC9ekABB10iEM+AjkMhozJLjaLYOumsJxqOq2PGculqwo4xkt49IM1fH26qpkoFd3atKuTAo5CXpffGGDie62jGws9zWjngNY9SYpSNd7tLcH6FNYduC+W4ec8+ufAIfjcPd2aPc/1/IXHUBLiemDFFZgVuqsyqHl4nuHbrVj0BkHcJdWqxlB+OuRzZcCIPMPF/kzzml9YwqYQxu9NesYOq5SaAQdtRQD9xWnPczX+yRBqWws9XcTuoR1xCAdmNnmY/fHKTQ357rJoxd3DCe9biLxYxHQVL+Vk/qgEsXASKhz104zHsakSSzxeI9PYPDalt+BUDqeuEmG0ktENEmSG0vVchb+K1H4G5MUz1Scu8GmNcBJIRrcQKKHQoLnUOtJmkAfWN3DRH53nBuoI/jOvGRLFluKf74FqwpXrCLeup53rZWW/L30myW7VQns/YnzsWrx1mHhKoaDqUJhnci1zk2iffoDvczfb3YXjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(4143699003)(11063799006)(10067099003)(56012099006)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnBJYU1xMWkvUk16NEhWdHdhNWUxUVlKR2kyWjdDWSt4dFNYbWVQdVp5Nmg5?=
 =?utf-8?B?dHhDZjFZNmRFbUpOenZ5bWdzeEowOGZkb1oySzhzVm5pRFRZam0xRVBNeE9K?=
 =?utf-8?B?V3JNMXo5bk1hdjYyeVZxQkVmK1dYQmtCekZ1N01ZbndtMzRXOEFpK1BDZ0pO?=
 =?utf-8?B?b0xyZ0VHN0ljSmRzSWYxd3BZN0t2V1ZPanAzMS9LLytWZWp6ZzE0c0MzdzVZ?=
 =?utf-8?B?dzUvTlNHY3ZKdVNKeVFpbG5WcitOSlR0V2tkVkdXQUdQVnVESVpTRlVtMmZG?=
 =?utf-8?B?L1oxMzZoTlFzZ3JablppMVY3aXNOVHJqYnpwMXlOa2J6cnJoL0JLbG9iMUhI?=
 =?utf-8?B?cTI5NE5HV0Q4MS9xL3Y3YWVzNVNIZmxkNTB0MzJBV2duNnBPQzMva2hZdnpy?=
 =?utf-8?B?eitnRGNGUms5QXFNTnJVak9UaEk1SW9HclI2NTBDZHp4K2tYMnVSN0hHSlBS?=
 =?utf-8?B?TTY1MjB2S2F2ZmI1M0hCOExYL3BkSmRicSs1MXpVaGxqVVVBU29RRnJ0a3pE?=
 =?utf-8?B?c2I1anR6b0YvdENYeXZsZysyN2hjdHdHSHZFUm8vc2xJalJjdlpmMnliZGhL?=
 =?utf-8?B?Yng4OFZIaTJKajdRR0hlbUN2eEJ3V1Q3N213WGFCTHlnc1pYT2d1VnphRitV?=
 =?utf-8?B?WE5vbTZ6ZW5vZk5PYzliY1Ira0lyZDAxd2srTW9ucUZMdkZTbkZ6MG1mU213?=
 =?utf-8?B?MXprTWk5M3VRcE16S1B2N1FXUVNJd3VtSWo1TXdialA1VFVkUlB4MHJPbDFP?=
 =?utf-8?B?SFdrWlVkWmVWaCtDbzhlbnRZNzV1MUFmcldBQ1pvbnBjQXkrT2JscTV4UjE0?=
 =?utf-8?B?U0pTRWJYL1gvVi9qY1FOVE1yb0JRSDV3NXBaMDhQVTRvcldSQnVQVWNPdHFx?=
 =?utf-8?B?WmV5dmlQYVUrNk50dFB0SFRjR0h6RHQ3U04zVzBsSWpvazNHKzNmR1lzRm1q?=
 =?utf-8?B?NktrQUl6R0VBS0NIdHZqNENuRkc4akNobENPOE9TOUI0dFgxN2crRXpxTWpn?=
 =?utf-8?B?ZlZZZ1lydHd5aDlBRXVVM3dGY2MxSWg0bVN3c0dVMFExWnpkcS9PbkNKTDJr?=
 =?utf-8?B?RkQwMVFBZDJtNzBCLzh3U3M1VDUyUXVOK1NQRXhjOWl3Z1FsQ0lXeE5RRC9X?=
 =?utf-8?B?UWNmVnZYMHo3S2o2aWlYaGh4b01hTGlmdkxlWXZPeHJoc0tmclMyVFdLREhz?=
 =?utf-8?B?N1BsdzN3RndIZExJb0N1eWt4ME1kNEYvMENGblh5aHlNTzNPU2Y1TUExSjEw?=
 =?utf-8?B?YTlxTXFFTThrLzNvblFUbVpTZlF4WWJsbFMxM0JSemRGamMwWS91OThrYnd5?=
 =?utf-8?B?NnNTeEtJUVpPN3NPNzM3MzJKcDB0UXZLb1BpdHg5SVMydzRqU2lZNVM2MUFT?=
 =?utf-8?B?bDE4Vkp1MUhCaVNYeXh3SHpnelJWNUVlRzl1K3ZnQVJNcis0dG4zYmhhWEFU?=
 =?utf-8?B?SDFHQ3RYSUVjL2VUNnFIM0dPcHRqNHU0dlRkMGsvVmtuLzVWbm00TENGYWJw?=
 =?utf-8?B?NXZpc1graFJhUDNDMzlzTmtqT0tOSnBUVG9rc2U2TGwwdkVXVldibDh5dndp?=
 =?utf-8?B?amhPZVVRWk1HVzAzNTYyQ1pjZldTWnBqQ2IvQXZONHNsblZxSytYaTc1Tlp5?=
 =?utf-8?B?b2xYeU00OHZ4RnBEMXhZVzFZU2xvWDVCckpVMGhRam5xSUVJMzl5T1NOa214?=
 =?utf-8?B?bDBoN3Vxc1ZMRm5CME53blBUdGhLUTV3Rm1UUnQxOXdmZWFOaEQxVXdYaXpk?=
 =?utf-8?B?REpqTUlhVGgzayt3ZW9MTS9wbENvdnlzWEVpVU9GVDR3ZG5rc3JkMndMVWNF?=
 =?utf-8?B?bGowbERLWTFiK2VFYmZFdGRIZHRwRUtJVHdsRjEwOHcyTzQwblVTRVQ0Zndl?=
 =?utf-8?B?OGtySHgxb0VCT1lZVmxFTXZZQTF4d1JpRlFoZ0lhcjV0c0c2NFhDYjc1WitP?=
 =?utf-8?B?Rjd0Rm5qUnF3OVhHOE5xbXdmeHJEalp2TWVHU3NEenNkSVQzb0tSWndCTm8x?=
 =?utf-8?B?Y3ZyN3cyelgwWERCSGJNMlBJWUJLbjBZUHlCbGgwaXAzQmxvUHBsd3hYQjJk?=
 =?utf-8?B?SkxCdmRtUDY3Mk9RSGp2dzNGUHc0OXR5c0h1ZUNVV2pSWFA5My9lL1RVSEJE?=
 =?utf-8?B?bjNTdFh6L05FVDA1L21xbVcxL1pmUmZOMnRTdW50bitMM2lUV1BQRzFSU1Vx?=
 =?utf-8?B?cFI3STNqY0dFaVF1dEtLQktLaHZyZktpcXZZaVNaZkNsZ0ViWmlWRHdzajAx?=
 =?utf-8?B?VFoza0lGLy81U0tTN0o1cEJKZVdMQUxYaGVXZzVzdjlJR3hMTGVQWG9lWkg3?=
 =?utf-8?B?bGVoQ25sK1ZkOWVFZmlyM081ZDVoT1dERXAyemxISVNQY3Ewcjljdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 624eae67-b604-4ec7-8bdf-08df2b95e636
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:58:12.4012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IT3M7oLM/AEcAyp0MPyuMCXR34Vkzo1D+Q1m7hC6GMFvt9HYtjYmz9vok/nPtEhv+FFzt/w7HfDH6luaDNM6V2bT64BxXBKk5RNfOmpGKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7797
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

Hi 安容,

On 10/12/26 3:22 PM, 安容 via B4 Relay wrote:
> From: 安容 <HystericalDragons@proton.me>
> 
> The Linux devicetree of the NanoPi Zero2 has been split into a common
> rk3528-nanopi.dtsi, which the NanoPi R28S builds on. Both boards use
> the same PWM regulators for vdd_arm and vdd_logic.
> 
> Move the U-Boot specific parts of the NanoPi Zero2 into a common
> rk3528-nanopi-u-boot.dtsi in the same way, so that the NanoPi R28S can
> include it instead of duplicating it. No functional change.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
