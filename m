Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C1DC5DF84
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B232F60907;
	Tue, 18 Aug 2026 13:06:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sMfhANPOtnOI; Tue, 18 Aug 2026 13:06:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D51E60A44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058392;
	bh=aIZ5SsZgG/ipkVqNp5nZR4le5Pih2n4/02lMTVuEuDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F9rZ9Q6HJpGMcsePYjjKKHkCysEYOv3IOGVeAcVJEuii5FffRSTKd/Wll6nk11BvR
	 wOWrkGViCyfSEvQMphC5FMHqox4MXaaKUpXyGIaICLcHhgSr7/nPMAiNGUDUUlVUFs
	 veVDGYtD2uAteJmL2dMBKJFUKNbICrlEmjpUi0albwK2yFfW9V7ZAqe3oIfKEmeZrD
	 y+IAwztcRjij1WXGCf9dzfMZ36c3kYAizH/5EbgvZikb/WGw3BO4aoHqMdjRtUWHA4
	 c/910B26Pfm3m/VZcVx1OwuhB/5FXtlDlOH/Z9hqB2ZkTFM7HSaQTwj4jAGPD5mzkZ
	 p23KmpRZAHcow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D51E60A44;
	Tue, 18 Aug 2026 13:06:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DC442B2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 12:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FD4740560
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 12:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCmoCP22Ir0P for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 12:12:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::1;
 helo=bn1pr04cu002.outbound.protection.outlook.com;
 envelope-from=nathanw@msu.edu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E5BFF4056A
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pa.msu.edu
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5BFF4056A
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=izIgLRdC
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5BFF4056A
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 12:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brRSbgSlGg56OTuIySjY3nAAeiPiMTDAWU6Hq4IO8c0BzZhFcYm8n0GaCpmFVuMjKy+VPXhUP3J2iujTpjsm3tb4cDXjt9McdFKee/NLJNNwzz7gKk2ESzEYK/NsPi/B3axiolyfUFC2TSFD1xtSWJP9G4bn4b5iTbEtmQyRof58oo6X4bwGyT1nBq2c+u3f6YE97VTa2peObml/VLeXMtorOU9uegWk8MXa+j1ifZZLVu8biZQosVLU4iStRNo6LFMTq36vOsgI760DynvaV4rQMmKWqV8gawk2zc+dthYcbDyI92dSqL3aVq776aHLTBZthuOggQj9WG8h/BLjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIZ5SsZgG/ipkVqNp5nZR4le5Pih2n4/02lMTVuEuDk=;
 b=m8lRmQQaN+vNYuZHC2RTWwNQ7fx9kmW4m/MLShB+u5Oap8qE4Gwqp6fISOqkik5rCU9gkqKoS8CG1XuQnfXNycwNwEhf1T8jMxEaQKoSOUL0giTTtAewA6FUPoYaHM6XXmHRLssmCRhWnKITqeAYF67hSb/zczvW99ID4amjvNLKfx8CJ3biVps17fhLYCxN/E2dIUvra+CfWFYxMsnrdN4sVRZP05pQv1rjixjiWWzJsCbbJ0pI6w50mW6cJO87oZh1X38R4p3WkeBifccXwdwZ4GP/9y01OAs/Vb+qujS5CDdgYiLNxej4O7c5ehm4ij6QXxFtBnawBMwvwY9nmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIZ5SsZgG/ipkVqNp5nZR4le5Pih2n4/02lMTVuEuDk=;
 b=izIgLRdCxmsEOYmOFDTy/XGBrI4OF6A5cvPVR0Qe+gbbpAALrlVyhYBWL+8m9tZBGECocFYslrXMVRNu3+cJ8L+kE2lvWCScmekNGLUUi9+n2ax4q/ogeuqQk62CkUHZBKqqGbM/JdC4V07zWUF4prbLsyb+POfP+qI8IlNMNJJmO1ha4Lu6g/8DZUIvb/yTCWfb6a2YmRyipmy3B3GrqRwUgXRJPUGUSnRSt+B/gmj8QSxyGeY5YyLVJt1eGJTIhf5qflMSaDBP/v0/h9Bsi79wQ/XCdrkJ1zicYKjYMBnBk9D7taFSwdWkTxKaKP7n6RCH7eXYTFTcA7JwqQPC4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 12:12:01 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0315.012; Tue, 18 Aug 2026
 12:12:01 +0000
Message-ID: <bac10f4f-6605-40bf-a39f-5cac4beb50e4@pa.msu.edu>
Date: Tue, 18 Aug 2026 08:12:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
To: Conor Dooley <conor@kernel.org>
Cc: u-boot@lists.u-boot-project.org, conor.dooley@microchip.com,
 jamie.gibbons@microchip.com
References: <20260724173547.77823-1-nwhitehorn@pa.msu.edu>
 <20260818-rehydrate-gurgle-27ca628f2c24@spud>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Autocrypt: addr=nwhitehorn@pa.msu.edu; keydata=
 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
In-Reply-To: <20260818-rehydrate-gurgle-27ca628f2c24@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::18) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa19cce-bc18-4523-ec9f-08defd21e8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|786006|23010399003|10070799003|376014|56012099006|10067099003|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: gXhs/tI1ZGHrybHf9ve49BXa9jqE6wVTF92ArMCI3Pfm0chl3WOQC2bp+lwbbMo5QLlV7jvVFsiKJYKIuyA5W3cSwCL/CTgklQXOD+AScafEuixER8UXBubuEoP+ewCan3MhJeyDd/e9X5qLg5ExFs9kmQRsgdEGoKxFUjytcpvVd4ZjY08OrUdnOBzUKqpUj27nLD6i5Vg9+lKLsaTH5zuzuMwoHd4zKBzDP5F+GqJdGIdRkJ9NPtZCysDmnrjEf0SFYZWAOQQcnJCqGMtZ0ip1hI1S90pvwKK1Sr+TO0ZlZpu4nDzXJJGinMAFCRP7gaUFJZ+6+g2WLlwk+4Ns5YWKrgnsrFuFPlT2vwWwyOo4HpVgSi7iZgIqTO25UdJYofLVeOubcpHLDXhjzhMRrpVG2hap2LsVz2YpC6qVJrKtCXreBtqw1w6F4Sy49hnwqH++NKEj5ybW5T/kSezJwvfqioL9nBwb4wc2grUGgOtf4Ls9qFJME62FFF+Oqpnvp4A7wbiTocw3vlWrD7Y8FU49kzSSt5alCSkgYNTBBF0Pw8J2Ebl+3ptrDHM1eXmf0TBNT1uk0+n/rCDkVUyBVh6fr9cnaTfpvOhNyQikMu2JSE+wOyoEpYbBAS6epn0JbnADkJuCS2iCFK+awq0IgsdLysSmj1MOvNQ+4c7hPSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(786006)(23010399003)(10070799003)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1lHc01oTWFrYVVFQmxDSXdjVUQ4RW1KaFZBaUdXSEFVSEs0M09LN0l3NDhU?=
 =?utf-8?B?R0ZDRVBOMU1GaVpXa3hOMWJLNm9neGFkNmVpV3g3RDc3QUlicTJyWlQ4MDRI?=
 =?utf-8?B?aVRtMldMdlZyQ2c1T2pCY05WQ0h6b0hKMnZ5eDRaNDlMNTRVc2kzY2hFVmpM?=
 =?utf-8?B?YW9SUGZQbnJaMTJyL01HSCthVWpER2NHTVA5RllXWFg0VlIzclk2cXJ1MTdK?=
 =?utf-8?B?bEkwOTNQcktXMWNCK29OdTlVeFdLQk85Szk2c21iMnBUd2JXQ2Fpd2VkN3lu?=
 =?utf-8?B?ckJHeUJ1WW9odDZQV1h5anoxWU9zRm1kWUZVYkVTYkQ1TmVFSVBKQnNpZElI?=
 =?utf-8?B?aHVxQjRXeDAremJFbENia2xNVUhncStHZ2NIRmsxMEFReWx4dS9CdkkwQ0JL?=
 =?utf-8?B?QTNDYjhyS1g0SU9MSStxbW9tUlpaVE0wRkZNNGhpbjY3Umw2RlZmb1NOelRR?=
 =?utf-8?B?dGI2eXRjN3ZQVzFKcWE3THViVEFuZWtJSlp3QTB6NzJEbUJOOWxZRlpMbEgx?=
 =?utf-8?B?QmZOeXhocm5VaWlmWllTWWlqUDFLelU4eWh5bDlCREhJNmFqYVZIdzNWRTVK?=
 =?utf-8?B?Ym5LWXUzV0VaSVpNYWNQMTVUcGRMT1lVc0Z1Y2V4dlNaYjlwOUpFbVRCWUcw?=
 =?utf-8?B?NmlmZGcwczR2S2gyazZpNEtVdGNSY2xMakRlMDJteWw4MkRkNVlURDF4cVZO?=
 =?utf-8?B?d3VtWHdCZHdJWEpwTmVEbUd4dkFDN01qcHZkOUt5ZnpLZjZOblh3VnptRUJC?=
 =?utf-8?B?cC9INWhNWEFjRm9hSXRpL0VvdGFHaHk1R1dFZmJIKzdIUDZUcGJpdXZPOHFp?=
 =?utf-8?B?VnJveGp4anVDc1VNem9HSFo0VnRpOUYvN25YcytPSnZhUWhNZ2d0b08rMVhn?=
 =?utf-8?B?VXo2UStRYjZtUXRFcUEvVlkyZndFeCtHZGtRejRoY0poQzVXdWM4SUtrMHNP?=
 =?utf-8?B?MVFQOTkxYVpvYU00MzI3ZnZ4TTJuY3graXBlTkRaSThjT0NSYUxwTjdnR0Fk?=
 =?utf-8?B?Y1Z6dC83MXc5amdJWWxYamJRT0t1aThaZ1l6NjdGbnRsNW5IREZrNjVUOExu?=
 =?utf-8?B?ck04bXpxK2wrUm5qV015TkE0bStEa2NMdXpxT2xwNW1weUxLbFQ3WGc4U256?=
 =?utf-8?B?TXZaNjZQcXhKMnZmMGt0U3F2YndjdXBKMDZaVHM4OGNFN3hyb1RmeXA1bUo2?=
 =?utf-8?B?K0hmb3o1QXJsZDdIVVBQbTl6UVRIYnYxQWpoWmd4emJXeGI3SVcrMU5tSEU2?=
 =?utf-8?B?RmtGSVg2cUY4Umt3NlNnRlZEbFdJU0prQm1aUjU2WWlTWGozOWg5WDRWQ1V3?=
 =?utf-8?B?MUNBQkIzMTNxTU9NbDI5VjZnek5tUThRci9vUjNmNFE5Mk5jdkZNMm95bnd4?=
 =?utf-8?B?L1B3U0FBek5lODdjRk9uYzR3T3dEZHJGT3luMW4vL1lWSTJuNnBMU3c2WS9K?=
 =?utf-8?B?N3ZyUnpRSHhYcmJGMmRvbWpBb01oL2NGb3Y3T1RZc1duc1hLemtudXBnNUZi?=
 =?utf-8?B?RXViNllLWi9MWFhpbElsVUduSmJwdUVCbGVxdyt4VDNxdndKeEppMEF4eDg3?=
 =?utf-8?B?Tml1Uk4rcTNsM0pKUkNnanRacUZuenEyVitMS3JUVlRHSFFTSVdmUlZXK2th?=
 =?utf-8?B?L3RyZTV3VThWVG0wSzFsU3dPZnNnUzloT2R5YUtSM3I2TDFERXh1UGxmNFB3?=
 =?utf-8?B?eVNIcW0va0FENng2WkQvOW0rdjFnOC8vWS9jdTJ1MmxOU2JjckNUVUllMllY?=
 =?utf-8?B?cVprY2hyMjQrdUFEUGNoSjduVXBKVVkrUlF6UHJ2WmFTK0RhT0ZOa1pYdEM0?=
 =?utf-8?B?VDVQdU1RZkdWYVZqSUdpSHlwMktKRVVUeUxDS0NUNHgvKzJmQ2tNYi9xMEZB?=
 =?utf-8?B?MkNvQmdvVG91R0VzR3oxb0YySE9RS3gzRUk2YWlKK1hFcjRjQjh0WFhOWjdq?=
 =?utf-8?B?c2pIL2M5dDhoZzlzanNiOU9QV2dCaGdkWGpsT2NveUE2Q2lNSTBmRzRIQ2di?=
 =?utf-8?B?VU1SY3NxNyt6NUNDamxlc0FwZjRibU9HTzk3NGVPbFZ1Z3ROYlY5TVpPYnRp?=
 =?utf-8?B?RHhCT21GU2VwemhnSHZncEIzQlBHaFBXd010NFRMZ2hWZWp1RlhqSUJVRnB5?=
 =?utf-8?B?U3ZjOHozTnByK3hPQ004cjVvK2YwNkhLSHg1SVF1SlpLVVAvK3NXS2JqYWNM?=
 =?utf-8?B?aTFjT2FSWmJMQXEveXNQTjVoUzlKMU5zZlF4Q040REJrYnRxZG9Ba3dMWXdB?=
 =?utf-8?B?WW5BWEx1M3ZJbEtIeVRjMElVakRxS1huWW9rVmoydHV6d21vZFhGL2JVbEFQ?=
 =?utf-8?B?cExialJ1bEpycWIwTmFrV0gxRE1FVkcxdzdMSVh2VGk3aGJFY0tkVmhlMkRq?=
 =?utf-8?Q?F0a8Nk85U1Cxc05QH0PwEP0iLmIIkXI9xaQ0z?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa19cce-bc18-4523-ec9f-08defd21e8b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:12:01.4459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEnpyd/tHcdpi8SCVLY7IDS1v3su+8VdRkok8KYMjQD1uIl6OBWZQnD7GcaxBcpF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
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



On 8/18/26 05:29, Conor Dooley wrote:
> Hey Nathan,
>
> Sorry for missing this originally.
>
> On Fri, Jul 24, 2026 at 01:33:50PM -0400, Nathan Whitehorn wrote:
>> When working with systems with multiple FPGA firmwares, it is sometimes
>> useful to be able to use the same U-Boot and script conditional behavior
>> based on the FPGA firmware ID and version number. This, allows, for
>> example, flashing new FPGA images without flashing the bootloader and
>> letting U-Boot and the Linux kernel adapt appropriately.
>>
>> This does three things with the information:
>> 1. Prints the FPGA design ID and version to the console as part of U-Boot
>>     startup, which is helpful to a human working with the board.
>> 2. Stores the same information, plus the already-acquired FPGA serial
>>     number, in a new set of environment variables (pf_serial_number,
>>     pf_design_id, pf_design_ver [the version], and pf_design_backl
>>     [minimum-version backlevel]). These can be used in a U-Boot script to
>>     load different kernels, device trees, etc. depending on the currently
>>     installed firmware, which allows U-Boot and the kernel to adapt
>>     cleanly to FPGA firmware updates that change accessible peripherals
>>     etc.
> These two I don't really mind, I can see the value in it.
>
>> 3. Stores the same information in the device tree (under /soc) as
>>     fpga-design-version, fpga-design, and fpga-design-version-backlevel.
>>     These things are also available through the Linux system-controller
>>     driver directly, but it is handy to have them in the device tree as
>>     well.
> This I don't on the other hand. If linux needs it, it can go and get the
> information itself and if userspace needs it, I'd rather there was a
> small driver made to expose it on a dedicated interface rather than
> buried somewhere in the devicetree portion of sysfs. If it is just
> informational, the info has been emitted by U-Boot already.
> I'd also rather U-Boot didn't add undocumented properties to the
> devicetree.

Fair enough. It has been convenient for our use, but with the 
environment variables, we can also do this from a U-Boot script easily 
enough if we still want it. I'll remove this part for v2.

>> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
>> ---
>>   board/microchip/mpfs_generic/mpfs_generic.c | 31 ++++++++++++
>>   drivers/misc/mpfs_syscontroller.c           | 52 +++++++++++++++++++++
>>   include/mpfs-mailbox.h                      |  1 +
>>   3 files changed, 84 insertions(+)
>>
>> diff --git a/board/microchip/mpfs_generic/mpfs_generic.c b/board/microchip/mpfs_generic/mpfs_generic.c
>> index f57f5f4046b..469e914e083 100644
>> --- a/board/microchip/mpfs_generic/mpfs_generic.c
>> +++ b/board/microchip/mpfs_generic/mpfs_generic.c
>> @@ -114,7 +114,10 @@ int board_late_init(void)
>>   {
>>   	u32 ret;
>>   	int node;
>> +	int idx;
>>   	u8 device_serial_number[16] = {0};
>> +	char serialstring[33], designid[33];
>> +	u16 designver, designbacklevel;
>>   	void *blob = (void *)gd->fdt_blob;
>>   	struct udevice *dev;
>>   	struct mpfs_sys_serv *sys_serv_priv;
>> @@ -144,6 +147,24 @@ int board_late_init(void)
>>   		return -EINVAL;
>>   	}
>>   
>> +	/* Store design info and serial number in environment */
>> +	ret = mpfs_syscontroller_read_design_info(sys_serv_priv, designid, &designver, &designbacklevel);
>> +	if (ret) {
>> +		printf("Cannot read device design information\n");
>> +		return -EINVAL;
>> +	}
> blank line here please
>
>> +	designid[32] = 0;
> What is this doing?

This is meant to ensure NULL termination of the string.

>
>> +	for (idx = 0; idx < 16; idx++)
>> +		sprintf(&serialstring[2*idx], "%02x", device_serial_number[idx]);
> blank line here please.

Will do.

>
>> +	env_set("pf_serial_number", serialstring);
> Contrary to what I said yesterday, why not just make this
> "serial_number"? Not like the code is going to run on a non-polarfire.
>
>> +	env_set("pf_design_id", designid);
> Ditto here and below.

Sounds good to me.

>
>> +	env_set_ulong("pf_design_ver", designver);
>> +	env_set_ulong("pf_design_backl", designbacklevel);
>> +
>> +	printf("FPGA Design name: %s\n", designid);
>> +	printf("FPGA Serial: %s\n", serialstring);
>> +	printf("Design version number %d (backlevel %d)\n", designver, designbacklevel);
>> +
>>   	/* Update MAC address with device serial number */
>>   	mac_addr[0] = 0x00;
>>   	mac_addr[1] = 0x04;
>> @@ -182,6 +203,16 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>>   	u32 ret;
>>   	int node;
>>   
>> +	node = fdt_path_offset(blob, "/soc");
> Putting in the soc node doesn't really make sense anyway, the soc node
> is really the devices on axi buses.
> If this were to go anywhere, it should be in the root node.

I will just drop this part of the patch.
-Nathan

>
> Cheers,
> Conor.
>
>> +	if (node >= 0) {
>> +		if (env_get("pf_design_ver") != NULL)
>> +			fdt_setprop(blob, node, "fpga-design-version", env_get("pf_design_ver"), strlen(env_get("pf_design_id")) + 1);
>> +		if (env_get("pf_design_backl") != NULL)
>> +			fdt_setprop(blob, node, "fpga-design-version-backlevel", env_get("pf_design_backl"), strlen(env_get("pf_design_backl")) + 1);
>> +		if (env_get("pf_design_id") != NULL)
>> +			fdt_setprop(blob, node, "fpga-design", env_get("pf_design_id"), strlen(env_get("pf_design_id")) + 1);
>> +	}
>> +
>>   	node = fdt_path_offset(blob, "/soc/ethernet@20110000");
>>   	if (node >= 0) {
>>   		ret = fdt_setprop(blob, node, "local-mac-address", mac_addr, 6);
>> diff --git a/drivers/misc/mpfs_syscontroller.c b/drivers/misc/mpfs_syscontroller.c
>> index f608d5518b0..ef03ce7b262 100644
>> --- a/drivers/misc/mpfs_syscontroller.c
>> +++ b/drivers/misc/mpfs_syscontroller.c
>> @@ -129,6 +129,58 @@ int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *devi
>>   }
>>   EXPORT_SYMBOL(mpfs_syscontroller_read_sernum);
>>   
>> +/**
>> + * mpfs_syscontroller_read_sernum() - Use system service to read the device serial number
>> + * @sys_serv_priv:	system service private data
>> + * @device_serial_number:	device serial number
>> + *
>> + * Return: 0 if all went ok, else return appropriate error
>> + */
>> +int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv, u8 *designid, u16 *designver, u16 *backlevel)
>> +{
>> +	unsigned long timeoutsecs = 300;
>> +	u8 data[36];
>> +	int ret;
>> +
>> +	struct mpfs_mss_response response = {
>> +		.resp_status = 0U,
>> +		.resp_msg = (u32 *)data,
>> +		.resp_size = sizeof(data)};
>> +	struct mpfs_mss_msg msg = {
>> +		.cmd_opcode = 2,
>> +		.cmd_data_size = CMD_DATA_SIZE,
>> +		.response = &response,
>> +		.cmd_data = CMD_DATA,
>> +		.mbox_offset = MBOX_OFFSET,
>> +		.resp_offset = RESP_OFFSET};
>> +
>> +	ret = mpfs_syscontroller_run_service(sys_serv_priv->sys_controller, &msg);
>> +	if (ret) {
>> +		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Receive the response */
>> +	ret = mbox_recv(&sys_serv_priv->sys_controller->chan, &msg, timeoutsecs);
>> +	if (ret) {
>> +		dev_err(sys_serv_priv->sys_controller->chan.dev, "Service failed: %d, abort. Failure: %u\n", ret, msg.response->resp_status);
>> +		return ret;
>> +	}
>> +
>> +	debug("%s: Read successful %s\n",
>> +	      __func__, sys_serv_priv->sys_controller->chan.dev->name);
>> +
>> +	if (designid != NULL)
>> +		memcpy(designid, &data[2], 30);
>> +	if (designver != NULL)
>> +		memcpy(designver, &data[32], 2);
>> +	if (backlevel != NULL)
>> +		memcpy(backlevel, &data[34], 2);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(mpfs_syscontroller_read_design_info);
>> +
>>   static u16 mpfs_syscontroller_service_spi_copy(struct mpfs_sys_serv *sys_serv_priv, u64 dst_addr, u32 src_addr, u32 length)
>>   {
>>   	int ret;
>> diff --git a/include/mpfs-mailbox.h b/include/mpfs-mailbox.h
>> index c0ff327a4ce..5c1ade3e918 100644
>> --- a/include/mpfs-mailbox.h
>> +++ b/include/mpfs-mailbox.h
>> @@ -59,6 +59,7 @@ struct mpfs_sys_serv {
>>   
>>   int mpfs_syscontroller_run_service(struct mpfs_syscontroller_priv *sys_controller, struct mpfs_mss_msg *msg);
>>   int mpfs_syscontroller_read_sernum(struct mpfs_sys_serv *sys_serv_priv, u8 *device_serial_number);
>> +int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv *sys_serv_priv, u8 *designid, u16 *designver, u16 *backlevel);
>>   void mpfs_syscontroller_process_dtbo(struct mpfs_sys_serv *sys_serv_priv);
>>   struct mpfs_syscontroller_priv *mpfs_syscontroller_get(struct udevice *dev);
>>   
>> -- 
>> 2.34.1
>>

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


