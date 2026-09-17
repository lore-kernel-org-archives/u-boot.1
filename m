Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E7CC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 08:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85C6F40755;
	Thu, 17 Sep 2026 08:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p3LXQtlz5Cwz; Thu, 17 Sep 2026 08:43:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6FCA940536
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789634598;
	b=IRfdch5AqBSyNMOL0cPz7q0bJzOX+TnXiRq97w4ZpqIqOf1MAbzlDsNTAha0g2kd+cEs
	 /KFfc0+ghVg4CLQtrHCTs5hnDhyXu4aI3+8dcajbkCsF5puYWm8rCpJe+NK5yIwRep8YE
	 Y1NrOI3OJBgyJYX2zu2M27Vz4S0+fIlk78KTyq0yQPbI9YYf7RBt90x2Letin5r9gfw97
	 99t4DdKqfC0aJgBJrFML/dm0iKktwU2JKQZkVROUEJVoWpDfRKPvkVKtHDaKUGFE/9sgv
	 TCUF3pkfk3V/QnNoeKe+9EHrX9nckRsE09dOiixLGUJh1FmB0T2BHvRB9KAYd/vGU/g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789634598;
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
	bh=ayTNQ29Qq44YYdqiIiqBIxe5RXwTZesRPqt4WfAQvQQ=;
	b=sGfuPMqv9HKQF7RAL3I2Yz/C7OcNVAtMQUs7FrSXNK1QbzHYK40mbe/HQ9VeGrJDMspO
	 TSYbeJMxWP0O8uZdfmhmrnh6WOBqEaGJ46voLTS6uQpPPa5axZd+Sbm3zye/iGpWmy7P0
	 I9dYXCuHGH3jDgKu59ww+dfGJd9Zk+HKC+RgtCRycq4dolxZ5trssZVlyol4IBYr6Q2Mb
	 g7XZO4jY69EVkzuZ2gq/8XU1iWD/Sld9rUU3WHVEVX9fNytIpLMsbZ4SUFzV5H7TNTAO+
	 DD5FlN9UZVYqcHDY83BQ1BU9UwEw4WcgbnnDlHFzQY0xKazLgVgykCnwlL36D//fVEA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NMHlTe6J;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789634598;
	bh=ayTNQ29Qq44YYdqiIiqBIxe5RXwTZesRPqt4WfAQvQQ=;
	h=Date:Subject:From:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hro+EgMP74peFNPGAnUQD0ThElm1uIHKZ+aLVewJVvwjKjPpgJqsMvCSQccWpQcnG
	 YQgW4YluplpGSXF1YUFeAHGm9A97xZ/G9cUVJLnwHQFBaGvWrIOZZP0ayIGhXgmgXU
	 AagiRRvTWzracWIOGWbsx6DZWJO7GX/pgJZmh1/DeTLIVZXEaf/iLU90zoHFzEVbyH
	 fHHrR72z9UKcUpQtkKNV8HoFPeIMITi0MVhygMVZpO77PzhaPngb919lwdMsfJw1Li
	 PMJaDRUxgM4S0LIXe0Bm9SdGceTeNbI5vhF5mZ39Gd7yZVjIyVb25yq7gdARhglxFF
	 UmIQ3BjfXf2zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FCA940536;
	Thu, 17 Sep 2026 08:43:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 698552EB
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F2BF40543
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:43:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ok-oUOZUTQD7 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 08:43:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B86FB40535
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789634596;
 b=GuYyg1dJoO2LVVz0O1UeCiw5xqk8trPxQSA2KDuXMrecdg8nQRJzZuCxK+57AoMJlCXv
 C3FGEgpM3W97mJVu57Y+tZ+wDaTUbRnrCdnnmNqY5J8NqamrQkPDd5r3iML688pc0qdCI
 g0SyIGfwTa22dRVSnb2Ipq+7pTJzOBbHTbzzicsmiPIb+e/n0OkPl1ge2ZfFNNqn8+DMN
 mlpxiMVaWGXq8DPdqTvMdRs40vyKDElDX9JYwxb3aVE/Kefzuq9IwmwAVr8zmIFGX1Fup
 Wz0kI6ZRFINqDEXlTfLsoQnUbz+qcDSMqAwGN7blp6/WEhcKghiencvBd2dF535zjUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789634596;
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
 bh=ayTNQ29Qq44YYdqiIiqBIxe5RXwTZesRPqt4WfAQvQQ=;
 b=FfyykNH0gegYMysFb74kk9fIoVORrXtmefoZ8jCEavLwYVmItGPgPDYc9tmqlFzGtrBE
 c0hXIWqWhWSmVInOd7Mf77gPj7pfb3jgV49GoBv4n4F/KS3SAozEbeJv0f57v/4d9PHi2
 qoncQ0VdSxxFYXml+snAjEs+ChET/8VXPUaR8pxHlaaI/bRLuzkv5zA/vPlheRiBgZfsk
 zNAXgAaoUqgIn6uWKVytJtzFHnCZ9sGXpYSHemomJmJPBApmU1Ojx/N8QPXSEq4kL7uw0
 JH1WeZU4nL84NmSxl+xUybGOwUzuLJdkrJJWQLvGclgTGW6vKClK+eN9D9Q+6sFMKPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=NMHlTe6J; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=NMHlTe6J
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B86FB40535
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 08:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+KDyZPOCcxl/eFVb6937a4i/k6jyGoYANsnNSd2JIMYkby4uvIxBwxEpS+oGFE4RMXXgPCXPnsyFpJ2XHrSYCa1/CZqd4+ZpBAEP0bALTUDwSUIvNEjY3qtWzBLv04lZ93EhV3MQmcZiw/A/h1IvCscxK+nU67MFTzKedQYWFZUvea3pi2nDRPD1Sz42fKUZtPIGyg4eXrqbZVde4Y7AaQJds3HvRv/YRYf2qe4Ne28Uhx1Wh0uOWbgyMC8niWhYA3FgBnLlvVf50qufb50zsHTXOLiuxGJD5Tt8jq+v7eUHnhqs6IHoesn0hlUdHsz3qNwHc6za5SqUPckkNWdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayTNQ29Qq44YYdqiIiqBIxe5RXwTZesRPqt4WfAQvQQ=;
 b=DSi83MfY+Q0qPGALFgPyqbnbEGiwrvG/I2TDn+EoVG/AalXJxCBXUPUe31Q9jaDVqApi8ojI3lC3r+PecDmdJ3fpH0wOIKfSrE5TvMjIW4qrE3i9FVqHj/+vdkshrCVFvkp8dY3xhcWtFpL5z1pY+oLPx4iVHGsUHXMr9hSChz/Chqf+8vqKPgoSF7NAAfa3gyIlw5jEbav9aaBiNBr7KbHKiFdHlb9dIalyCrUDocQnVHtOuEwT5VxQqU6tnGjU0VpprF8bO87/FjjBdz3G/NgeMhnaX+NbYybN5xNMupDjoYY5tX8H4AhXTo6kJxF4oipu/EL6JkmJbEnebPpsSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayTNQ29Qq44YYdqiIiqBIxe5RXwTZesRPqt4WfAQvQQ=;
 b=NMHlTe6JBQ6vzECJlxDC2l5kInPdKoapQ2V9Dmol3CM09O+/KLBPUaarNZZ4hIX72Oc/teb0KD7QA6RVRrEkwNRyXRudawod3s6A9pTsamA2B5lxKBJA6LuTC3t9Aj2Vz/ipyyRIQVmMH6mwW5vw/JJLHaP29a3ltOYkSkq3rDdZSCqYy3VRUeA+ZgCvLNrV5k94SKBBcAgT5qfvBoBRZpnE3GTDy9M4FMubi8XWucIGlGROmfOZcPisa7mUE3rcOW10PGGKGhP007cEY4Y//twhtpkJhqnfFILh9OpqpzAy8S7ZUpHif6sTdfwR3sWhtZDBAkD9vO/2RmQVtu1eAA==
Received: from MI3PEPF00007536.ITAP293.PROD.OUTLOOK.COM (2603:10a6:298:1::4c8)
 by AMBPR10MB089059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6ec::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:43:11 +0000
Received: from MI3PEPF00008559.eurprd05.prod.outlook.com (2603:10a6:298:1::95)
 by MI3PEPF00007536.outlook.office365.com (2603:10a6:298:1::4c8) with
 Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id
 15.21.382.12 via Frontend Transport; Thu, 17 Sep 2026 08:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008559.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 08:43:10 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 10:49:15 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 10:43:09 +0200
Message-ID: <77c4054d-3da4-4094-9138-b8a45c491349@foss.st.com>
Date: Thu, 17 Sep 2026 10:43:08 +0200
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
Content-Language: en-US
In-Reply-To: <9b29dee6-5a40-43aa-bfd8-4590876b3e67@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008559:EE_|AMBPR10MB089059:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9bc52d-20a8-47a5-c459-08df1497b477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|22082099003|3023799007|11063799006|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 47pbnFNmgHV/w2WKSGUwjI4+ME5MoNfUVEP6s2VTywSIA0XSp9f3x8lhaQMfdpoftCketM6Pq3NkZbiCdT+x2VJCvv6f0Jqwnpk1R6QcQXhiTDrEwgRNakld8Bx+kw1SrUBhvXv8mknZZR6FX7eL5dne7NXTZZf1zN4anqgH2aTqlrH30TAoe/hfadqp6pLr+/Crja52P2TKce9mV2EaZjpEN5phNOifIHWWtZdqyEGcsNl852WPfSItYiF5HpTDT5FgQBI8x322/KI5FHALxwQP9iNkZ7IjCk7HUWEvX64nwH04xMz0IeTG3IUeoLiX5Fp0hLTEc8vXp3znrnuhUjE3aBdRdxF8ZAqc3ezT0V1INONBBUVlQs4fI/VGN8NIMr5uQ7vjGB5VKUYv9BAPUSadQd1dio5kN49b8fGp+5+lev5bjivhfAJbyhDl7LpZpKmwXRV1c/+4nQbjnLwlWUIai41gR0lXMIs3LzqchwNKpWhwoSOe37fxoWMY/IxU+eKm+IWsoK2fMy6eU52ajvb1+txZZq3tsal+3mODS97uK2m8DGCv9X4t2c7Mq4JA3x3dc+2Rwopr/xXMUGRrscEp41QDWppYjJwvp5y7DEOdVeQvZThq21q0yakWkpT52fcxYQpXMjPAI8QthVLebBJJWyo5WQf3NLbKZpCJ31VCAtxHQnl66T0UezX/PArrhtkjANRzDdw6OZCu6coyNg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CgKTZAdMBHit62uSPRTI5lLf70oiIvn7IiSI2Di7XWSOrxJj+tZ8NCxELWjv5n9OqM+Q3fNTeJG3+n5tbeYDJJIJu1i1EIZD5PlAgELgiqE651TTgtUw3Ft1zby8KWVGK/W/7+pfKRbHcLTW4z3bY2KgEor28apt8ZxH+P6WaBbx1YSfOvLwqQCzpX8XqlqGHXsgP/ZqsUiQkIEREXvqdwX59d0+QGo02cFsaleL9a1TOOkp/kn37QeyGXAfEI0T4oQSLA86B/XUk0jalITLWV3F+5tcPlwsZ0pudsmMhATEX+/Mm1Mc9yBOD0+hJhYBlhfahv08vzpob4Pn5IB8+f3u/zgbxMpHuEgYFFw4qv+J6cWc/p+r2+F8vu642irVpmU0Pw5ZX9ZN/XPktTaDSYh0U73AHsv55wi9EA0VS8rqF8Dx6wiFQiTDGah1wfDF
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:43:10.9495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9bc52d-20a8-47a5-c459-08df1497b477
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008559.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB089059
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



On 9/11/26 14:38, Patrice CHOTARD wrote:
> 
> 
> On 9/7/26 11:07, Mattijs Korpershoek wrote:
>> Hi Patrice,
>>
>> Thank you for the patch and sorry for the review delays.
>>
>> On Mon, Aug 17, 2026 at 17:41, Patrice Chotard <patrice.chotard@foss.st.com> wrote:
>>
>>> schedule was added in sleep_thread() by commit 4b6a3e860878
>>> ("usb: gadget: f_mass_storage: Add schedule() in sleep_thread()").
>>> to ensure that watchdog is still reset periodically even on platform
>>> that doesn't implement g_dnl_board_usb_cable_connected() and in case USB
>>> cable is not connected.
>>>
>>> Instead of calling schedule() for each for() loop iteration, call
>>> schedule() only in case g_dnl_board_usb_cable_connected() is not
>>> overloaded, in this particular case, g_dnl_board_usb_cable_connected()'s
>>> return value is -EOPNOTSUPP.
>>>
>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> ---
>>>  drivers/usb/gadget/f_mass_storage.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
>>> index 621852080e2..f467693d2cb 100644
>>> --- a/drivers/usb/gadget/f_mass_storage.c
>>> +++ b/drivers/usb/gadget/f_mass_storage.c
>>> @@ -651,6 +651,7 @@ static void busy_indicator(void)
>>>  static int sleep_thread(struct fsg_common *common)
>>>  {
>>>  	int i = 0, k = 0;
>>> +	int ret;
>>>  
>>>  	/* Wait until a signal arrives or we are woken up */
>>>  	for (;;) {
>>> @@ -673,13 +674,15 @@ static int sleep_thread(struct fsg_common *common)
>>>  				return -EPIPE;
>>>  
>>>  			/* Check cable connection */
>>> -			if (!g_dnl_board_usb_cable_connected())
>>> +			ret = g_dnl_board_usb_cable_connected();
>>> +			if (!ret)
>>>  				return -EIO;
>>> +			if (ret == -EOPNOTSUPP)
>>> +				schedule();
>>
>> What happens on boards that override g_dnl_board_usb_cable_connected()
>> that return a positive value?
>>
>> Per my understanding, schedule() will never be called, and the watchdog
>> will be triggered at some point, no?
> 
> Hi Mattijs,
> 
> In case g_dnl_board_usb_cable_connected() returns 1 (it's currently the case 
> on STM32MP157c-DK2 board), we stay inside sleep_thread() for(;;) loop until 
> common->thread_wakeup_needed is set to 1 by wakeup_thread(). 
> 
> wakeup_thread() is called periodically (around every second, it was what i observed 
> during testing) by either bulk_out_complete() or bulk_in_complete().
> 
> Then we came back in fsg_main_thread() which was sleep_thread() caller, 
> and came back in while(1) loop of do_usb_mass_storage() where schedule() is called.
> 
> So watchdog is reset periodically.
> 
> Patrice
>>
>>>  
>>>  			k = 0;
>>>  		}
>>>  
>>> -		schedule();
>>>  		dm_usb_gadget_handle_interrupts(udcdev);
>>>  	}
>>>  	common->thread_wakeup_needed = 0;
>>>
>>> -- 
>>> 2.43.0
> 
Hi Mattijs

We got a discussion with Marek on the previous version of this patch [1].
Marek's proposal is more simple/efficient than this current patch.

This patch will be abandoned.

Thanks 
Patrice

[1] https://patchwork.ozlabs.org/project/uboot/patch/20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com/
