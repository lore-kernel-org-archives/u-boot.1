Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A14CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E62280DD2;
	Mon, 12 Oct 2026 14:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hhzQiS1tBc2A; Mon, 12 Oct 2026 14:51:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E144E80DC3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791816683;
	b=cZ9EWoduvZ1IJx8o/+OHti4IshTnYgFx/N02OM27ML1E6vKlEwhTf5mP2gAcUxmMzD8F
	 zfkI16QkCdJnVhHcD+81ZQgOngVrt/rBQV0MYHWfLLKoS93V2HQXWoR2r19c2k9lVUaC6
	 eK/Mz9NXA/h5y+zdqJAl8RHyg4tJgzwkG4ZOI0+eg96O1eEmVv6KVnbHUw11zXZRZNH/b
	 Ou/hqlIBacn39a976OoK022/v5wR5ZAtkiNJnPo4qPyoNprLUAciATx3oKcD43W/YnqQ4
	 e4TvXmoIi7NOXs94UBbsY7Y2mqki6Dk3pBt8qrKjSS7QtaWDJbUaUW/KakBXyonRtjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791816683;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=+IbeP8MyNQuRJ2dTrbgwhPIodj+OrWv4i+6G1h5+Wag=;
	b=YP4MymlUu9iT1dPN3RureoOrECCsdt4X4wPPF0qbfgh2bibYzYE/qMmhLGYJh+Dut2tr
	 7dgTLLsBfTH0d/qzfVm2RfLWsS59ruGF2ipE0lmwR6HodtFFEedZt62nHikwea3eNMLdf
	 yWBYNvidOs11WpckROdI7WDozzM4sKUznAXtRnNKk2J6mO3toaT+sSscOx+WmBggwbJyc
	 Y8+BvSz858LjGAdP2EhIHCB/v6raQipIGNRp1wIGtY0IllKPgARfB/B38h6FRbhTNLkPV
	 ABtSK8ktcCY1/3QokeDwb5FstFVOTaYdW1cpb/cyk8qf1a1Fd8YkJlkAl3S62eOb9Tw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791816683;
	bh=+IbeP8MyNQuRJ2dTrbgwhPIodj+OrWv4i+6G1h5+Wag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iTfslUg6BWLEunOZWSi59M1Z1Bw0JcLHqVE+PELLhXB/qJ2wM+axIIWptt5xEKti8
	 NI4r6abetshoEi/6fAPm+kZmwEBVgkqb+Yxmhav00/aJ0WE14G8fEOFcMujvAfsEr7
	 QF+8KJe6KUi4oeSKxjHMCg+E0lXpS2anKCJs9oon3tMK4+NOt5utuS0mAkd61+XVc6
	 qJKA5FKLyy8ZQNfIZnr5NsVfjlqVe21YJbx9k9DIoj8xlFj75nLoc9CtM12c2z1DEs
	 HWWLYkN9K9aCT2Ko33y2Z1xh5kMb4zXiIz8wGP+5d59DXUv4DoDKroVcLV3dmRlCu1
	 TqOdgAB2IfVGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E144E80DC3;
	Mon, 12 Oct 2026 14:51:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CD7E179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:51:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 318C140588
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A92nw98byExN for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 28A404059A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791816677;
 b=KCJLomREBqQEjdrwDoPp6ppcehqZFcFksHceaKLDmuUPDLsxf5N+26M4TYcsFOlBoWvJ
 apJwQsJoI0iNeY/2Tir8BCbFF3zgOIXtCpJ7YkMaLBZE0QGjCPEdELf0OeWzRSMg746vJ
 eDM1TnbhAuZHJjwBab7PlhGZF9amK7NaU5mPO9U4Xr1wuRD8Zv2tTr+kB3m08MXTVZj+R
 6jfGVhZgnAUwfYIF8T2oBruZWmNXU41fSmm/zpzmzaZa0TniLAL87hyAVabNZjtKQPJD0
 Ld9Xxqm7Jylf9b3YiUGtrhzykXaadCAh78R2wco+AF6NI/TMlA7rpPS6MTgfdvZ1K1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791816677;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=+IbeP8MyNQuRJ2dTrbgwhPIodj+OrWv4i+6G1h5+Wag=;
 b=KrKVAiLcN9IhkpQcm9ibRjIqpIuUKwPm0p7FV7B0Z82Q1YLpI3cBB81oioM2utZ97OJe
 1qFvADt4tfYE4mEYnNSDKBTim5tAtPw2u7FBpjbt+z8J/oTGU2ZNTg4WQcRyLe6GJ+jdg
 WZVbNDl4NKYwKSknfxw/CpjL9Hdnc0HYKkicaoXihJWhHVPzmVudSQAhBCwD2p7UZWkxs
 wFazRyFeFQlyz7agTKFSIetbm3vRyckeDuPCKb0NQie8ywuuWdmQ/4NiPi2l7TyfWtw3l
 dZUzFNrMCdhm2uDPGfUl7oWGppE++T0Yd9cWYLC3zq5t8R+Ti3GeSAV2g7g3iZ3SYqQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=XkP+GECS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=XkP+GECS
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28A404059A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSnw2z4KA/98fuzXe0pLl1/GpEDyUof0ZNb5WDQFPcy7xwc9hVOtHMIk8ohMvH9Qys6fbyKkTJfPuPJYRFdWHQXvtT64F6N1/8OFaSt+6yebDwQKe/HpP2lJLmyJbZkLNFJEFtyVQanUIRsxh5Z1b+8zD5QeHHjV4ST+dJfgY7G4ABmms2/KgpEwTh4Xvq6bPR0UGLoSH6HYvR+cJg7cpN1J06LtLKBIQQ0DjFA/fZ59lqsQ2rHNU59aafe2q0UVSpfhAwRBaTiwsi05HQD2eNtF05k9NvE47ACTG6yjVaISpcFjp4RKDAh0sJYkq95kwfcNfkozHwsVrfFwTCwpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IbeP8MyNQuRJ2dTrbgwhPIodj+OrWv4i+6G1h5+Wag=;
 b=t5l4RF6UKT/nA/8TFLsb9M6/Aim1Karir6nlrwGDGxTJKvFICi6C9VdSbfEEANLv2YuO5VMw5BfB+Qsh+jFkjgCF0wDpKPIAxfSe4Ely2PG50GoIvQwXyjBxmszt1HRoDuAtlWYiKbLnLmM1mge1qdMMhjhKi3rqHVFXOteH02loYE6MQRFvtru6QA0NfKf5TQ14kh1A+2FPq9tocjKRLUgGfMdsV9wCgGva54ZV8n18U3cZ8xrwygbYaTPt3ghuPk0ibND3Pso8U4SewJs1A7Zh+olfDl/GCxQ3cmdo9/s2lKr0ub0sS0p8nGhh2ke2vY2YWePX5bvaxjvI1XJhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IbeP8MyNQuRJ2dTrbgwhPIodj+OrWv4i+6G1h5+Wag=;
 b=XkP+GECSo3TWDoVF4DvYmS1Rwpd/lbR12Cva7WvicKuzTjGXfvaGawT8Zg1dkhpGStMmLwjlak8NSJb0VdGpr6HkCh8qX8/xy/DOkHhSuzLSfXTddboEuqt/YbS2WQJ/j0OP06MtRorzAmPKxrqzs/WdBE0gsURaOFaUN/EVrN5kDBq3+Uqgzm22YQBiUjkHJdyqcxT+ulDjdRENUVCugPtr87c+hWXXglsSa4IvmBNGSdc3JblEagW9a+gfSX91dbxmk68/6QL5FNVl2o7y+8CBU/X1e/CUBXP41zOnjQF7AdV7/vKj5/KnsrlNQ5VwFDDA5SLiKmFN2dI/s6ZxrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6204.namprd03.prod.outlook.com (2603:10b6:408:101::21)
 by LV0PR03MB113757.namprd03.prod.outlook.com (2603:10b6:408:3ed::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 14:51:12 +0000
Received: from BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4]) by BN9PR03MB6204.namprd03.prod.outlook.com
 ([fe80::47fd:71fd:88fe:6fe4%4]) with mapi id 15.21.0472.015; Mon, 12 Oct 2026
 14:51:04 +0000
Message-ID: <a677e019-dd28-420b-a9d7-808808b56264@altera.com>
Date: Mon, 12 Oct 2026 20:20:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Yixun Lan <dlan@kernel.org>
Cc: Zixian Zeng <sycamoremoon376@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
 <20261012143013-GKJ26088@kernel.org>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261012143013-GKJ26088@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6204:EE_|LV0PR03MB113757:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b5a557-7379-48fe-e3fe-08df28701d33
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|261009223027099003|4143699003|11063799006|6133799003|22082099003|18002099003|55112099003|56012099006;
X-Microsoft-Antispam-Message-Info: qTox1lYjI9KmodPimf471QC935jJNzmeyQSXIIJI3IXEcH3AhPLHQ6ChQprem+lR53lomn8ON+ZHh/sfOsU9r6WXEst5CISg1zfhNAa5cEmWaZXENls5Qhhfu8QFQG5UE27pXdh0t8/X6inqBW8II/BuL1Ee37DYJMXiSbkghq3o3CuHRYYBdlbM3BQVUvpdgz4/Zew4Es7tc1JIc85jylKadMdJ3bXZbcuJeRXP4SdLRwMyWPYZg/r9pJhrStWQMMCYNS0TrCu2UJ6RHzvs4yF+jE5g3vmlDnq+1yuc/v+TpZoxht2WXrQA5ONnvBJnsTEx8zIw7qrUGah9gbUp23dfWfYEQ/6WjJ5BvSSQR0zjOtqp0ihO0jPlBSQoEr6Q5C1F1Aya/g8NJ1qilVmjeQm16JCiaxMf9JD8wehT8mYTGXA77yho8sgHh9Str6hHuvEkINjC65N1CYGTZosrV9uyT84dkp6/FSTOw+9rQH0hhMkECG07luPxR6zZSRmd2pWCuX7OPURr1eiKLhpf7W2PGbPXddsG2gEFaHjcSSfd1VK/vHSvqZfWOm68ow2dGJ3DFaLZlRHvRnNdjdWuRE5cB7wMDPmXiVZANZx079MiyYkLPJFwBJRy5yxZUlrT88P6Ooth0y1EZq3G6ztnVvsQQOop2eCrZ7Ti0C6RpAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR03MB6204.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(261009223027099003)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003)(55112099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3A4UXFHR2UvMXptS3hFL2l2YlNHQ01nZ3NESDk2aitITlZVTUdadk94Qk9N?=
 =?utf-8?B?Z0dDMHBtb1FkTXJmN1N3ZTdIUmJtekN4RzVxOVpJZ0hOT0JPMzNqajlmZ2hn?=
 =?utf-8?B?S0xYc0pPKzhwSm5iK3FHbVVwTWY2cGJzUW1jL05QQ3Y1UGMydlNnRWpDVjQ2?=
 =?utf-8?B?VXNta0xpRjJUbGpRcFlsL3dQVkgrVStiTkVHRDcrN2hYQWo3Mk9JK2dkdUNM?=
 =?utf-8?B?TC9hanU1LzNqZVBLc29kMG9JSHZZdUU5dUIwZ0ptWGthWGhVK2tWbUllYnpl?=
 =?utf-8?B?YmxNZUhLVmRxK0FxbUxuNGZCU2dXOG43ZWd2dlBHTUtueEJuQ1JBbXNQbjZR?=
 =?utf-8?B?QngrZjhPUjhXVDNyVkM5bEpLV0g1eldSR0p5Mk4rLzlCN2RFNnR3S0hVM3BC?=
 =?utf-8?B?cndDaGxaZUlPbW9QMVhMVEI4c3VpRHBuRWtQajFZVUJhV0d4ZlEzcXdHdTZm?=
 =?utf-8?B?Qy9vUlpQdzNjaDdEUTd2ak5QamoxUTlIY1lBYVBCRHVva29UVm91Y2UxQURx?=
 =?utf-8?B?MG92MTl1RVZRK0x3VUE3MlYveFlBT1JicXVyN1hIdlV2aE9JSFJiRThqRmE2?=
 =?utf-8?B?ZFRsR2JJNU9DOTg1cUVsQTg4cnFBS1FhaXdQNWdDZ1NiRzNPdld3NGg4UHQ4?=
 =?utf-8?B?MDBjUWltVHc1aGFaa1k3em9PQlk3c2pybUVsaWoxUHpHdk0zazN2MzhYcE4w?=
 =?utf-8?B?WEJqQnJpYWNrdXd4b3VvMDU5K3JxT1h0N2kyZEZoOG9HREpMWDl3UnFDbHRY?=
 =?utf-8?B?dGVBYXZjQWN6N3FzUGIzUVdYdGZHV3dCS0Zuc1F1YjdObzFnM2FDOWpYMlVF?=
 =?utf-8?B?ZTRsUFR1Qkc2Z3lhTVZlblpjTXVkT1d6QjIveisrL09jZm1mcFNReTlSb2FG?=
 =?utf-8?B?VnE1dWJhaklYTWwwMkg1enp4cThLc2hSTFlXWmZ4NXNwRy9teFRWc24zanc3?=
 =?utf-8?B?dmx4MStUR1dFb2VrL1RuOXlJZEE0M0hmRWZZMi8zTGg0azlMMDAzUjM5VVF4?=
 =?utf-8?B?Ty9IZHptVDl4cGNtQXFWclAvN3o5ejFOa2NzK3Njei9mR0VKMUhWWk1MbStw?=
 =?utf-8?B?ZnpDSFhPakV5WDExRzQzbGgrbm81aWtxYVcrSzYybFBoQWFBQ0I1UGJCWUZa?=
 =?utf-8?B?RVhVeDJOemtTUG5qUXd4cHFLZ0JCcXZSbXBHMVU1VFE5elFaQ1FGM3hTMlgw?=
 =?utf-8?B?UVV4d2RGQUhKMmtvbmxhNXB3R2taOGo2MnJEQzA1UkFxRURJK3BrM2w3Sjlx?=
 =?utf-8?B?Q01XRHhiRE8rUnZJT3JobFAzVTZzeFNLeER5OUVXWFFiQkhrakR6VHhFdDUr?=
 =?utf-8?B?bzlNQ2FYNmhDNlhIQThXNjhEcWpSYUpGdWJLd1pHUjlGL2VPS3RtVU5YZFd5?=
 =?utf-8?B?c2RTOVpUckhlNmRqY1RyN2lBRWpZclg4OXpmUEdTYkZIYURRbTBWTXppajJU?=
 =?utf-8?B?NXF0QVppSGx3ZmR6U2pqaTRhWTk3d0taVGNmb3JNaTZEQm0yamRjdHJIbENL?=
 =?utf-8?B?K00xcjFrZUdTTmtPWUR6UUhOd1ExTXZLZ3ltR0h6L0hPcHRQaW4vVW9ZN1Fx?=
 =?utf-8?B?c3RCeGl6Z0JiWU1JcVpDVTVjaTFhTGRvV3FXRGpTY25wNm5QZjZZY01DWVFo?=
 =?utf-8?B?dHRhUFhJMkdVMUJVdTdISjBURWVIaThZazhHYzVkUXdDYWwxVTc4b0xUR2hm?=
 =?utf-8?B?dFBsNnVGNk56ZEhmaFJ3Q3grUjdQa1BoMHBTTFFMOWJnb3dyOFNmR01lSzdM?=
 =?utf-8?B?WElzUnZ0c3B1TW11SXFISGZvMmt4UmRWVWlsRUtSUWdFeVpPbk4wb3Q3L3Fm?=
 =?utf-8?B?MlBpM0tXdHVXV2NJYTZ5RXFUakxoNGgwOUtmbHdKZ1p2SzltYkN1RjVHb3dW?=
 =?utf-8?B?VlR4UHNMUVJzaUQwWGlFUHoxNVpXMTJLQTIwUUVvMkovVnZlYldkRnlLZ1Q0?=
 =?utf-8?B?OXRHTjhyNGtQSnpGeHROakZkZlhreXBkK0l2RzVFRUZ5cTVUL2RWR3Z0Mng4?=
 =?utf-8?B?M3g4SGMwaG9VWVV1WTg3NGNvWFVwTFZGcUZyNFc1YzhQeVR1VUFGVWd3cnF4?=
 =?utf-8?B?bTJuK3V5eDFzLzhxcXBrVXBwSGhKWlNoWFVGZkpBN2dTdWY5VWZMTWhMYnlk?=
 =?utf-8?B?SEVUM2gxd24yaU1xUkxuUVZRRDZrMjdYblhTdVFaamcySnl1WWpGeXQ0d3E2?=
 =?utf-8?B?NWdWaDRnSklmdEdGQ1ZBQUJYZVVGa2J6ZEtQbnNLL1RyVlp3cGNYMWJzUElv?=
 =?utf-8?B?TCtZU1VpR3VkTmp6OERYeU0yM0NGL3ZocHFBSFJzcVpuU1BXRzFvbkV2ZFBR?=
 =?utf-8?B?WlYrY0xoRzN4RlROWXM1MThOOVFlaC9rNy9Ld2pkYW1ZUEpqQndxaGJPUkl4?=
 =?utf-8?Q?rG9l0JtPUFhRFLdo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b5a557-7379-48fe-e3fe-08df28701d33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 14:51:04.8229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRxm6s4mGqKuvg6ZxWHfZ8D/KlNO3B1YunLMxjw92QXBuoxbhAxsYprj8pLFWkA5XagvH5oNtFTVESBDlNlK4akmWFm/gPtCVsxLFKCJnkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR03MB113757
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

Hi Yixun,

On 12-10-2026 20:00, Yixun Lan wrote:
> Hi Kathpalia, Zexian,
>
> On 19:30 Mon 12 Oct     , Kathpalia, Tanmay wrote:
>> On 12-10-2026 18:45, Zixian Zeng wrote:
>>> On 2026/10/11 22:31, Kathpalia, Tanmay wrote:
>>>> Hi Zixian,
>>>>
>>>> Thanks for the logs.
>>>>
>>>> I hit the same pattern while testing the Cadence SD6HC driver.
>>>> Multi-block reads failed and single-block reads worked. On that board
>>>> the host and the card were in 1.8 V mode, but the I/O supply had been
>>>> left at 3.3 V. A short transfer got through; a longer one failed on the
>>>> data lines.
>>>> Both stages on K1 use the same PIO loop, so a FIFO that drains slower
>>>> than the card delivers would show up in U-Boot proper as well. Your
>>>> SPL/proper split fits an electrical setup difference.
>>>>
>>>> The SPL failure is irq=408020. Bit 22 is the Data End Bit Error (EDEB,
>>>> SD mode only): the controller detected 0 at the end-bit position of
>>>> read data on DAT, or of the write CRC status. That is a bad edge on
>>>> the data line during the transfer.
>>>>
>>>> On the Banana Pi F3, aldo1 is vqmmc-supply of &sdhci0. The U-Boot
>>>> dtsi names it vdd_1v8_mmc, and the SPL prints "vdd_1v8_mmc,
>>>> value:1800000" before MMC2. set_vdd_mmc() in board/spacemit/k1/spl.c,
>>>> called from board_init_f(), writes 1800000. The dts leaves aldo1 at
>>>> 0.5 V to 3.4 V. SD High Speed (mode=2) uses 3.3 V signaling; 1.8 V is
>>>> only after a UHS switch. mmc1_cfg is power-source 3300, and
>>>> mmc1_uhs_cfg is the 1.8 V state. For this mode the rail should be 3.3 V.
>>>>
>>>> CONFIG_SPL_MMC_IO_VOLTAGE is not set, so mmc_set_signal_voltage() is a
>>>> stub and signal_voltage stays MMC_SIGNAL_VOLTAGE_000. aldo1 stays at
>>>> 1.8 V. U-Boot proper has CONFIG_MMC_IO_VOLTAGE. mmc_set_initial_state()
>>>> requests MMC_SIGNAL_VOLTAGE_330, so the driver writes 3300000 to the
>>>> same vqmmc-supply and clears SDHCI_CTRL_VDD_180 before the transfer
>>>> that succeeds.
>>>>
>>>> CONFIG_SPL_PINCTRL is not set either. The driver calls
>>>> pinctrl_select_state() under IS_ENABLED(CONFIG_PINCTRL), but that
>>>> function is a stub unless CONFIG_IS_ENABLED(PINCTRL), and the return
>>>> is ignored. SPL never applies mmc1_cfg. Proper selects "default" for
>>>> SD_HS, which is that state.
>>>>
>>>> Keeping the multi-block path, set_vdd_mmc() to 3300000, or enable
>>>> CONFIG_SPL_MMC_IO_VOLTAGE. If the 32-block CMD18 still fails, enable
>>>> CONFIG_SPL_PINCTRL so mmc1_cfg is applied. If either makes the read
>>>> succeed, this is the F3 failure.
>>>>
>>>> Regards,
>>>> Tanmay
>>> Hi Tanmay,
>>>
>>> Your diagnosis was right - it is the I/O voltage.
>>> Enabling CONFIG_SPL_MMC_IO_VOLTAGE makes
>>> the multi-block read work on the Banana Pi-F3:
>>>
>>> Based on previous commit, I patched the following changes:
>>>
>>> diff --git a/configs/spacemit_k1_defconfig
>>> b/configs/spacemit_k1_defconfig
>>> index 9c15d96eae2..f5c717e5965 100644
>>> --- a/configs/spacemit_k1_defconfig
>>> +++ b/configs/spacemit_k1_defconfig
>>> @@ -95,6 +95,7 @@ CONFIG_MMC=y
>>>   CONFIG_MMC_SDHCI=y
>>>   CONFIG_MMC_SDHCI_SPACEMIT=y
>>>   CONFIG_MMC_IO_VOLTAGE=y
>>> +CONFIG_SPL_MMC_IO_VOLTAGE=y
>>>   CONFIG_MMC_HS200_SUPPORT=y
>>>   CONFIG_MMC_HS400_SUPPORT=y
>>>   CONFIG_MMC_HS400_ES_SUPPORT=y
>>> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
>>> index 23c655c6def..58374c482b3 100644
>>> --- a/drivers/mmc/spacemit_sdhci.c
>>> +++ b/drivers/mmc/spacemit_sdhci.c
>>> @@ -251,6 +251,10 @@ static void spacemit_sdhci_set_voltage(struct
>>> sdhci_host *host)
>>>                          bool ok;
>>>                          int voltage_mv = to_180 ? 1800000 : 3300000;
>>>
>>> +                       printf("sdhci: voltage signal_voltage=%u
>>> vqmmc=%s -> %dmV\n",
>>> +                              mmc->signal_voltage,
>>> +                              mmc->vqmmc_supply ?
>>> mmc->vqmmc_supply->name : "none",
>>> +                              voltage_mv);
>>>                          if (spacemit_sdhci_set_vqmmc_voltage(mmc,
>>> voltage_mv))
>>>                                  return;
>>>                          if (!IS_SD(mmc))
>>> @@ -274,7 +278,8 @@ static void spacemit_sdhci_set_voltage(struct
>>> sdhci_host *host)
>>>                          break;
>>>                  }
>>>                  default:
>>> -                       /* No signal voltage switch required */
>>> +                       printf("sdhci: voltage signal_voltage=%u -> no
>>> switch\n",
>>> +                              mmc->signal_voltage);
>>>                          return;
>>>                  }
>>>          }
>>>
>>> Booting logs as follows:
>>>
>>> U-Boot SPL 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
>>> Fail to detect board:-2
>>> vdd_core, value:900000
>>> vdd_1v8, value:1800000
>>> vdd_1v8_mmc, value:1800000
>>> DDR firmware: [0xc081d880]:0xf0227179, size:0x8d98
>>> DDR is ready
>>> No SPI controller (-19)
>>> Trying to boot from MMC2
>>> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
>>> max_clk=204800000
>>> sdhci: voltage signal_voltage=0 -> no switch
>>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
>>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
>>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
>>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
>>> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
>>> mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef
>>> cmd23_host=1 scr0=2358043 cmd23_card=1
>>> sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
>>> mmc: multi-blk blkcnt=1956 clk=50000000 mode=2 width=4 caps=300207ef
>>> cmd23_host=1 scr0=2358043 cmd23_card=1
>>> sdhci: multi cmd18 arg=1000 blks=1956 blksz=512 mode=32 dma=0
>>>
>>> <debug_uart>
>>>
>>>
>>> U-Boot 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
>>>
>>> DRAM:  4 GiB
>>> Core:  338 devices, 22 uclasses, devicetree: separate
>>> MMC:   sdhci: mmc@d4281000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
>>> max_clk=204800000
>>> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
>>> max_clk=204800000
>>> mmc@d4280000: 1, mmc@d4281000: 0
>>> Loading Environment from nowhere... OK
>>> In:    serial@d4017000
>>> Out:   serial@d4017000
>>> Err:   serial@d4017000
>>> Net:   No ethernet found.
>>> =>
>>>
>>> With the voltage corrected, a single 1956 block PIO CMD18 loads
>>> the whole FIT,so the controller is fine with the FIFO back pressure,
>>> the slow SPL drain was a symptom, not the cause :-).
>>>
>>> Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
>>> "sdhci: voltage signal_voltage=0 -> no switch".
>>> Since mmc_set_signWith the voltage corrected, a single 1956 block PIO
>>> CMD18 loads
>>> the whole FIT,so the controller is fine with the FIFO back pressure,
>>> the slow SPL drain was a symptom, not the cause :-).
>>>
>>> Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
>>> "sdhci: voltage signal_voltage=0 -> no switch".
>>> Since mmc_set_signal_voltage() is a stub in SPL, so mmc->signal_voltage
>>> stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
>>> "no switch required" path, and aldo1 stayed at the initial 1800000 that
>>> set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed
>>> after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is
>>> what hid it.
>>>
>>> On the pinctrl side I had already run the SPL with standalone
>>> CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
>>> mmc1_uhs_cfg plus their pin groups. I confirmed that
>>> pinctrl_select_state() return successfully. The multi-block read still
>>> failed the same way with the rail at 1.8V.
>>>
>>> Therefore, I suspect that configuring the MMC signal voltage to 1.8V
>>> in pmic_init() may need to be modified.
>>>
>>> Thanks for your suggestions and guidance.
>>>
>>> Best regards,
>>> Zixianal_voltage() is a stub in SPL, so mmc->signal_voltage
>>> stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
>>> "no switch required" path, and aldo1 stayed at the initial 1800000 that
>>> set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed
>>> after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is
>>> what hid it.
>>>
>>> On the pinctrl side I had already run the SPL with standalone
>>> CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
>>> mmc1_uhs_cfg plus their pin groups. I confirmed that
>>> pinctrl_select_state() return successfully. The multi-block read still
>>> failed the same way with the rail at 1.8V.
>>>
>>> Therefore, I suspect that configuring the MMC signal voltage to 1.8V
>>> in pmic_init() may need to be modified.
>>>
>>> Thanks for your suggestions and guidance.
>>>
>>>
>> Hi Zixian,
>>
>> Thank you for the quick testing and for posting detailed results. Your
>> patience with the suggested tests helped us reach the root cause
>> within two days.
>>
>> With CONFIG_SPL_MMC_IO_VOLTAGE enabled, aldo1 is changed from its
>> initial 1.8 V to 3.3 V and both the 32-block and 1956-block reads
>> succeed.
>>
>> I am still unsure why set_vdd_mmc() initializes this rail to 1.8 V.
> I'm also looking into this..
>
> It's definitely wrong here, and should be fixed in my opinion, refer
> to SD spec, the initial IO should be 3.3v, and later may change to 1.8v
> according to OCR report, the BROM code will set IO to 3.3v by default

Agreed. The host and I/O signaling rail should initially be at 3.3 V,
and the card powers up using 3.3 V signaling. It may switch to 1.8 V
later only when entering a supported UHS timing mode.

> since cold boot, and I've done a test on this, drop set_vdd_mmc() & without
> CONFIG_SPL_MMC_IO_VOLTAGE enabled, the multi block read still works fine
> on SPL stage

Thanks for testing the multi-block operation after dropping
set_vdd_mmc() and without CONFIG_SPL_MMC_IO_VOLTAGE. Since the BootROM
leaves the I/O rail at 3.3 V after a cold boot, the successful result is
expected and confirms that set_vdd_mmc() incorrectly changes it to
1.8 V.

>
> Also with Zexian's above test, it also prove that, enabling CONFIG_SPL_MMC_IO_VOLTAGE
> will lead the mmc core calling set_voltage() which will set IO to 3.3v, which also
> fix the problem

I think both changes should be made:

1. Initialize the MMC I/O rail to 3.3 V instead of 1.8 V.
2. Enable CONFIG_SPL_MMC_IO_VOLTAGE so the MMC core can manage any
    subsequent signal-voltage transitions correctly.

>> Since we do not know the original hardware requirement, any change to
>> that default should be reviewed by the code owner.
>>
>> I suggest enabling both CONFIG_SPL_MMC_IO_VOLTAGE and
>> CONFIG_SPL_PINCTRL. The former fixes the voltage issue, while the
>> latter ensures SPL applies the defined MMC pad configuration instead
>> of relying on the Boot ROM state.
>>
> I agree, it's safe to do this
>
>> Dave, I hope you are aligned with the changes discussed and tested.
>> Could you please post a new version incorporating them?
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>
>> Regards,
>> Tanmay
>>
