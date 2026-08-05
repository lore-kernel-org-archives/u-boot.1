Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D435CC55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 11:45:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8958607B0;
	Wed,  5 Aug 2026 11:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yfHCiP0oBTT5; Wed,  5 Aug 2026 11:45:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8A0D6079D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785930344;
	bh=W/MQjRbWRkgFxcGmK2UobV0h/1qr4WfBXt2B7JshR+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Le31+shFbKzKL0ED/nocEiYeVS7HFPLqKC+r0VAHYRkHcLmXmedu/UgSCDayjFZGj
	 n6kw9RCK6imz3EZgR4qDJeRDYjMBYhi9h/7okt0GnsNf4XlpUT5+Lc7x9lKRzaJ6ts
	 97O4qIz+KI6Ure/66/mpEi4uSa2czv508nVx8tEXWl+kzDlDMqIbmQitopUIMZm5+n
	 aby1t1a2YCtQwdfeLPXAQDPP1v4kvg1F1H0L0FLGbfKF8cOpOhrtlAEoEkCwdHBiNk
	 zhBDELNrdRUCxyYB9fU45KeLkiO8nwzYd9G5EBcGmOE6yqCQ0Bphdt5FNB5t4hpYUi
	 LphsQ9nSm2OKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8A0D6079D;
	Wed,  5 Aug 2026 11:45:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 07635313
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 11:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4DF080B03
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 11:45:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XAIL72aE9lzu for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 11:45:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 682AE80AEA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 682AE80AEA
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 682AE80AEA
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 11:45:40 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qOv7HDarYZPjHjTy8+3vtVBECmxETv7/MMy6UkmScQv6Ebsig7k2MDb9rDgGOYkxnsVk6sHKgtXNWC7AP5ZiDaYxYxplr3z8vOq1vAsRGq0WU750SULuGst0nQ69UjrRZe5JIM8hN7jw1006pCcSDPgkSqnR4dfbzvNo8KBIMI/iQYcJFGWn5alUKqgAwTC8Lq+k/WnT2W+Szvt805YbdGaEQRw9jOb4PyYqwbPI3/CK31ROcDLfpLWG+QwKi0N7P0H9WVCNfPpeaZ9LRtuMcWxhm+m/Yi2hzQe4vvYY2imaS2xD9DV+xHOP337BxCrqPk+Eh8MdoOCqms499ElsxA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/MQjRbWRkgFxcGmK2UobV0h/1qr4WfBXt2B7JshR+w=;
 b=nG6ZiKzk2/hHygCFhbK11Tmtvj+CcplQ0ygILvwTXhL9cibOjPsqfxklfvMD3zAA+gudBGPqLopvLB4WgS0Bq6SHDS4esQ3isaaFn3tltiBhxqe5YzT7tKpQPU/+spxBAhH99/CxCFsS7Ey9L4lE4zyUeXV4AwP7CbJHVDQoYfAXKwb9Lh3+CMlUbS07UsI55DEMuUgTcDL79y5vPHUg3AH812+vLn1UkBXthBarVzphoRw/9lCEYoKCNdRO+FnONktWkRCoYZ3FhcHCHF2hQw3KatdLwdkn2Bbp5ku9IlZsTHajIeUebAP0SyQCGNdN6y0GkQve5A7E+Riy9qQk2A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=amd.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AS4P250CA0025.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::15)
 by DU5PR08MB10852.eurprd08.prod.outlook.com (2603:10a6:10:522::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.20; Wed, 5 Aug
 2026 11:45:33 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::4d) by AS4P250CA0025.outlook.office365.com
 (2603:10a6:20b:5e3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 11:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 11:45:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4x1vAAk4dn+j02eWE85jXbkSdVWpBP3MsyKpMi0UCRnxs7jJ8vI+O4xnDOZsZZ3/MKSV1YZyEJShWWqPX7Q681i9Ed0YPpbO2IGb8mQCNTdhodGPgAycD5Qaj5CFazuwPM++P6eey5GZAY/FgTBgMJ0GRvz9TIFqJhZQLJgT9z8DSXYO+U7tkh2utk9C+46WU6hZfmCiaG2MYuL7xM0D5t4IjP1oWQvqfj0jvs463NjXB0w6QYeXB+1LW/R+RmN5QuCy/znJCQev4NAsnd3OjHX4IiTC6NsQzl8zI/T+NqB/8UtYUf9rxOqg19wk7cDqh0rFytjNCatlWRiMmKKMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/MQjRbWRkgFxcGmK2UobV0h/1qr4WfBXt2B7JshR+w=;
 b=mf5Z800uGl2RCMG8TpIfYGJEtGy9Tbma7ixaruXd9BNAEtebzcLPhIiMIz5g4mhJ6KqvtN+iphd9HEBf/TomkoZTTVXfT8wQv19tgbipT3cMipbmX0T1taVklUKV8FvYJY+l7IHYpELNrOhRVP3rfQsWpCwONqa1cFrScF2jAKRjKz01PaOZAj9Y9Dv1bfc6X5o2CJR/7oFe8GFj0Kotk0s8jzuiEIpHR7bPSxsrXy6RFVY3KEpd5Avol60SITfPquetQYN7BmmtiF6po7PQXnEooDTtW8iN0ipZn1oGfJwf3BmMlfbXvuKibwlyouW1ZRbIBGOorQj0aEgQ0gpt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 11:44:57 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 11:44:57 +0000
Message-ID: <7a620ca6-d2f6-46d6-86f8-990eb8cf3d57@arm.com>
Date: Wed, 5 Aug 2026 13:44:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: fix TFTP blocksize threshold check
To: Padmarao Begari <padmarao.begari@amd.com>,
 u-boot@lists.u-boot-project.org, michal.simek@amd.com
Cc: git@amd.com, Tom Rini <trini@konsulko.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, nd <nd@arm.com>
References: <20260805103429.3142222-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260805103429.3142222-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0211.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::18) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DBBPR08MB10721:EE_|DB5PEPF00014B9E:EE_|DU5PR08MB10852:EE_
X-MS-Office365-Filtering-Correlation-Id: c447c8bf-6410-421b-cb54-08def2e70e7a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: YQP9PtW5TBb8iz49egzd1FbUXK5YmnguaTbtdEht43u7D2FIPBTU+w7PSvWNAD+Rtfv5XIObrKte2KlKYZZUr2SbaQMiwEgRNnQgIV+fcHiFRkGN3VXjrEJ6WsOHwmQTU6oXRclQXQYGzrfUbr3AjG1FZuI1HpQTLPN3w9q46u0eIjBzRgPuXelh0Y/vF5U+pn0fPwdLh9LKmIY/i6nhlVTnsFIEK+74EDOFsp6NLtA3ymPOawaODm+QPhl0wk0juB3xU5mFJWl3ihVzvZBAcBHHAdaBfLU82rxQKGSTPxJ6JPf1nNnqUF837gDmvrP0xrRk7qlMU8DcXg7yj46FMtB2fnoXzGqszQHYXi9tPCMiSnNVauveJY7ugCO0FErjjFi+KiG+4spGT2PycKGFytIZTJBzuw8M64hnQa6Gpzd15DgLzrb0EjKsXzuUoVWytOxFsB2encT1UZm7J5PeKLxA1mITedZq0o48X1jhec7urgNl0jQEx4YMm5iKGtK4cKsYslGge1y3gj6z6FtpKfx3jOo5bL1lB0JV3Ta6rdbOzAFczr+LTd0jVA1FGjF64tPc0eMwBUd0/x592oq/VDKgynGP2X1qqGEIbtsAOiLZLFoAwYTtk6UjBN2dEcBfF3W4ellxvTrTnBduTlOrYB0oJW8LyZdaGSlLbksrhb0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: jzVvHsm22nZCVMqlXchq1lPgUjH6oGAhNTkva8Zx1zA/xTFttiwq9vfPzYD8N25k1QgA0GVEcnkqXjoHnvkCuSdGgeOvfAtAhp4L9y/3oJjGVAzTnjayjJCk+O+PhZJ3IE2DGUITnTH493pjVEsoGytSxFXyP2zUkyRwKZPH1REgyn0aSHv4jYb+vQEiu/fSAV2RnJewgurFyTdDMbtGFnNp3PkFHbpUt5xMEl6qKOU7lHzCUqZxTyvbybeBouIWV+hmJFrrENRyAr7ZeQ5Ide+9FeiI+5GKFIrBl4pqEbwPY9/F+GRv1ludg//YlKOkIgFgSjgcL9EYrFO9AkKh/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10721
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f652a3f2-11b8-493f-0ef0-08def2e6f953
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|36860700016|23010399003|82310400026|1800799024|376014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2z3VzPLgqp0izJHkKZuO9Ek2Z/igz0aSu39S3TEMXbfQpzzwGnK8p/QzyWZE+dXpptHtxvoIEntUsmryXgj7S/d+SNiwiKNcsJPX+oeni711chELjlxzx5/57utlhG4RbnJ1485oLCgEj2Mof6slLeyX2j5ndZdwShMPB43TbFuyJsDqa/DFWyNIyHPO/vccav/rb4pNFSkht47bdVXk1DqD+PHWifKQe5WgyTtr4D98bOeOIBDG419p8Xk7ceAW50GjOjQa7m7yRXBZr0ZJEE0ZvqeE7GSSnwdUWjuELxMsLQX5f/bhfdd5pIIYNyJ2w7nHndBh5F4ZIOQtvKvTjdYlcKW81miqrhdG61dOu0pBmLm3NBXMce3eAg6dlLhviVhhJwg2Swqf01ZkJHUSQGKzCrydM2DjDWg/k+d1NGT8f0SDAwJzmIKKf4njQJjry88k6i6hqk0o3dMr24Tix/RkhKetK/DK/ee6v0HA/Izfmz0u5DY1uvbYh6M10zqDWUB1WV7wAV/50IXzFJh5gajgMJo5zBa8+edEWqZ61qunVal64rZqu+gosHe9uI/6iGs7LLieay9KRJBssOcwk9N0RSlJt7k0JOY+2+lAmanf+wF75kfGbx1VmvXOaU+Ud/SDQBkIlQl0ckTs63LSSzzZl1vL0wG/axMBjaTPn7Jl3fV+Oy8eTquVcVoeUKUIU+Id0H9faermTj3/Bl3gzA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0O73Dn9YCHiVzqs1owvcJDsj5Ojpd+T7s6CYpPuynoKNt80FxmdRvK1uuB218J+4fZxKNAeUu+9o9C5B2aiwSiOJeEIY62EWH5DpfDc7moX7vo2ltl/rCT0i26egH79ih/3TtGrocOM8Du1xV3+jOVzq8QMvQffcqeuxaBRwCCYNZ8fTbT4Kzs7sgZGsSDprRPuPbiY7+erJqFC/RkpWgxe7otTsgKrb+QMsrqH+Msjz8JAvHFLbQBpfsa82l0rM5vbBn/rNKqH8dkYnAur9QpuZ+peNuk7HIAvj/do1MQ+AN6hxZHYvCWqigsDm9VjFvIZJuGQY/29Cff1qsYauCm4ZlvQEXKTaM26XRk14ziQDY6Ze+M5BR2UvxQc8q9wjO60fQMsr6Fkn9ycJQk1ITg953Qp+kT7FrxA0f0fXUhvYPODIOAkE9dSE590E3+SE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 11:45:32.6423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c447c8bf-6410-421b-cb54-08def2e70e7a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10852
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/MQjRbWRkgFxcGmK2UobV0h/1qr4WfBXt2B7JshR+w=;
 b=GlPvP6wPUO9K8SQvCFaaPr1i0f8whBbclTZ7EBClpG6su5kJBCfbz7ZnwOZU3T2Zw0ZP2puryFiXzVGN3SIhVFo1v0dmNg9i1E4WMbqKa4sg6ZJ+vCDtd4vn1pMYGRv3F72ryPpZHEAW6PMxc0upxR1s3Rj24uw9sznUEzkOVF4=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/MQjRbWRkgFxcGmK2UobV0h/1qr4WfBXt2B7JshR+w=;
 b=GlPvP6wPUO9K8SQvCFaaPr1i0f8whBbclTZ7EBClpG6su5kJBCfbz7ZnwOZU3T2Zw0ZP2puryFiXzVGN3SIhVFo1v0dmNg9i1E4WMbqKa4sg6ZJ+vCDtd4vn1pMYGRv3F72ryPpZHEAW6PMxc0upxR1s3Rj24uw9sznUEzkOVF4=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=GlPvP6wP; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=GlPvP6wP
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

Hi Padmarao,

On 05/08/2026 12:33, Padmarao Begari wrote:
> PBUF_POOL_SIZE/IP_REASS_MAX_PBUFS are only scaled up for large TFTP
> block sizes when CONFIG_TFTP_BLOCKSIZE is strictly greater than
> TFTP_BLOCKSIZE_THRESHOLD (4096). Since the threshold itself is 4096,
> setting CONFIG_TFTP_BLOCKSIZE=4096 exactly falls through to the small
> fixed pool (PBUF_POOL_SIZE=8, IP_REASS_MAX_PBUFS=4) instead of the
> scaled one.

What practical benefit do we get by using the scaled velues (for 4096
that's PBUF_POOL_SIZE=9, IP_REASS_MAX_PBUFS=5 if I'm not mistaken)?
> 
> At blocksize 4096, the full UDP datagram (4096 data + 4-byte TFTP
> header + 8-byte UDP header = 4108 bytes) exceeds the usable IP fragment
> size (1480 bytes) and is split into 3 IP fragments that lwIP must
> reassemble on receive. The scaled sizing accounts for this explicitly
> (giving PBUF_POOL_SIZE=9, IP_REASS_MAX_PBUFS=5), so the threshold
> should include the boundary value rather than exclude it.
> 
> Change the comparison to '>=' so that CONFIG_TFTP_BLOCKSIZE=4096 also
> gets the scaled pool sizing.
> 
> Fixes: 67586012490a ("net: lwip: scale buffer pool size with TFTP block size")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  lib/lwip/u-boot/lwipopts.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
> index 8dae004f1a2..733478a0cda 100644
> --- a/lib/lwip/u-boot/lwipopts.h
> +++ b/lib/lwip/u-boot/lwipopts.h
> @@ -72,7 +72,7 @@
>  #define PBUF_POOL_RESERVE               4
>  #define TFTP_BLOCKSIZE_THRESHOLD        4096
>  
> -#if defined(CONFIG_TFTP_BLOCKSIZE) && (CONFIG_TFTP_BLOCKSIZE > TFTP_BLOCKSIZE_THRESHOLD)
> +#if defined(CONFIG_TFTP_BLOCKSIZE) && (CONFIG_TFTP_BLOCKSIZE >= TFTP_BLOCKSIZE_THRESHOLD)
>  #define PBUF_POOL_SIZE			(((CONFIG_TFTP_BLOCKSIZE + (IP_FRAG_MTU_USABLE - 1)) / \
>  					  IP_FRAG_MTU_USABLE) + PBUF_POOL_HEADROOM)

I realize that this computation of PBUF_POOL_SIZE does not take into account
the TFTP overhead. Shouldn't this be:

#define TFTP_PACKET_OVERHEAD		(4 + 8)

#define PBUF_POOL_SIZE			\
	(((CONFIG_TFTP_BLOCKSIZE + TFTP_PACKET_OVERHEAD + \
	   IP_FRAG_MTU_USABLE - 1) / IP_FRAG_MTU_USABLE) + \
	 PBUF_POOL_HEADROOM)

?
Thanks,
-- 
Jerome

