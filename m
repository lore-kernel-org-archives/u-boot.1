Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141BB606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m7LbiDgZ;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cl8AZsdi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E22D480DC8;
	Tue,  3 Nov 2026 07:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R42BvFiYMQbo; Tue,  3 Nov 2026 07:02:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B1DD80D81
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689326;
	b=G+kw2vTiCjcPTRwSmnLUcEdQKbujnS8uwKjti9vIVQdtq9F93lOtgLJ0Mtr5g7eJRsX2
	 82wMJMgpCTN/339IhmzjP7ejVz+0qngkOGoxO8l/DFAqoACGMsogUWkWX82Ek2ShA0Dzd
	 bwCB57T8KQxYUn4DmJbgWCXArxr/aHlQDm3/qy59xZ6GoXRqgXoOrub8J0Z8icB1pRNVK
	 DcLirruCfoY0w7DtskgX2HTP4si2Zwp5uwL5NMjci29fDtyybGOr5sh84vhO6gOwuzbga
	 I0h/FVIJh8M06BHdEab+loSrm/VwyMrHuBvtCg+1f3EbOONnVfDxaptsGyI3GJ7W1ww==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=UOY2t1UjQlNIVrBmvCQI3/RkbXmWwewNqZXDX1+6CXo=;
	b=rMMSU0B356WQEatWyyK0QcaiaXzqiJ8/Y8Irnn3QGVOSONYD+8HD3mpAZpXYXuh5GnL1
	 RSIjEIkyHrLpM2WR+AAAi9bDRtU/HvF1Rt3sjLndoJPPa1sD+qgAcFbS8OFcbGs3kkCm/
	 dHuA2kajE+4XN+4LbA+iY/2wUZQ/vjgakmH3xfmI56fIWbXCAqTHNGVK6/Cy82gl/c8Rd
	 3mM0C6XNJzzracHK/cvI3yXi406lnZvlK/Af4oaqBq3bfnLJIVo04MEL5aMAnMIFyNih8
	 HklUPat63+wBbOccAMKjbivub6aUtx0i0FYUa4gI0k0UdMA+oy3hANvOHPRM5EUSAUQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689326;
	bh=UOY2t1UjQlNIVrBmvCQI3/RkbXmWwewNqZXDX1+6CXo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m7LbiDgZZgkyS2lBeAeLyre6hIbI9CJrY/SBoRXsqlZElvkMJCdSPgr9pswc47TKV
	 swsiYo3Y7oKSJbP7NbpPYg41PimFW2NItY8BBCXjSr6q2CWX3B4BbFTTO0oChqShm3
	 0S4H5KGQe5wWMXtgFxH/+88OKdDNtobtno+WgwAvJty+D/uJRRGtefiImfM6C3bL6i
	 jKBRJ0fmZOVjkWz7yeeAyZVUw5UA0uX1Rh+Jixay8zEU3TzhGjYSvUynqh63NAtSeW
	 VQEU35q51YZlUBmxAflmPeYoVk/COkKKVdEb7GSakSjDyIZVUDMtQ/YQtfAM42euFh
	 rry2OOmYp99Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B1DD80D81;
	Tue,  3 Nov 2026 07:02:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 39F582AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2975560705
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44MH58GuiGoU for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:02:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 797E660642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689323;
 b=ooDuQplxIlJ4KBma33+kivjeamOORhpxRksCAq4odVnEIR2R1pfQcw2YdGCZ2HJ6c+cm
 6Xa43ETQ2zLs1mFg9IgNpqMpIHtkYUCEOd4cPSmDsgjo9PdnKNdIlEY0nRMH5hSF3lcAD
 iTJL6ZflAB7J2UxvEY3kLO1Dec+N5cr1Y5pPNnNCvzI+iIFA8Djx2bO0iChGHlaVfZsvq
 nO0rM0HpwS9yacyUfmYya4F3mOJBNDk2QPvPwMKj7nkjWN3zJcYrirsht9hpnzzw7tuIB
 yzOK2PqJTxXKBhnCpdMCiusyzvcq6hRXXKFqQICqavelcRsmTlkJdPrupJgYQq59Trw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689323;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=UOY2t1UjQlNIVrBmvCQI3/RkbXmWwewNqZXDX1+6CXo=;
 b=F9DhUiLYlR+0KAhvKJRqo5pPGsp4bZ5/76XYT6qNn5AfIGaiYnFAJmAw81TUlIRppktU
 1nyoyUN9GY4Qo/oWD9z+C1leQBKJINMtBr/vbCZ+oeVrWUWHw7WeoKjoa82OiMunKbPWm
 Ss/SiPC0m54aMh6RKzaVwAFNxLOmmHL/qT/acJWcFeocvbs0540kwwr7gAuTr/tZlDGpz
 Engi0NlsZxghh2AbwhcY3/gcSkIqzLZz2kLssvZ8CNKS+mk3mBNX8b28oIpz5d/TTBAdR
 2I6zAqcW2jJv2zFAHxPkLHtJ1Pr2fRuRJ2UNmtqolZtYWnEgXIzX6Kz9oCoTXuh9tBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cl8AZsdi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cl8AZsdi
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 797E660642
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWqHTOkDFiM3LgeFm8v8kqc3wayMRvcKHC+l5ucTEbbDw7n03c5fWrBn6BX1SbGcK77SulMueH6c8K6P0TOWqJY5K4wu0sSvoPLa2uikCtkNBlrLFWnJcez8eg8fFw+oH9bj/fjzeTWMSeHl1q/V3ECZb/czoZWX+IHxlL/+bWNZLFPo6cEPEar999ssnYAeMmOwWpdRdyOAVN0/Le9jnDupMzQ/p183Hx2QOV81YMPEhIa65czOoyvxtfPO4pbVnRZrHgLI2DZQZZZ/mOXdt4Vh2VOF3/X+ClFLWB8JL4b7UsY3JceKqj/dzXsEDNrvnCk8ZH3EDeqRiBzt87j5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOY2t1UjQlNIVrBmvCQI3/RkbXmWwewNqZXDX1+6CXo=;
 b=CClf2FSukFH/kO38zX8iOwjIUHZEHjpr1w7zYzirB7/Y2lIjRNmRf7qcI/6ljvr2dfmR+7pZXvzfu1SskEfwtnafmNBAXdVoLhjxHnR0e0w7MMGd8zgvNHGW6Fo1OM0C2glgXT2h4UIyPThs/dLrIAhPhA0KRy4Ci/pH7vC8lA4/syh0380/QexC/hL7LA3cCddv9nO8ySxgCZ4y422O9o+BR6xbNwNYeU518Dm6a5+BVEG5qUxfjkNyyvHOxKt5g3EdYp4/FxuwzaE9wuo5H1jnF7EfbihbYZq/2yAZ92V2jdd3gAsoIFrPyVwk4hHniyFHPUw65CYTwL96AquXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOY2t1UjQlNIVrBmvCQI3/RkbXmWwewNqZXDX1+6CXo=;
 b=cl8AZsdir5OYYHtTeR3+K0FpjtAtbegcyFEnIeSw04MiDglQSz5LE03RzVKe7yuPZDi+PRwCq+pB7nNufCAtKrUCTV+WTcgZX3Dqe+TWpRqlQTjqs/0t3imC3PPwQxLFwQShDQn/wKd7EpVBmiXv0ET4FbbZiPnIo/2pO4jW1Uc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:01:58 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:01:58 +0000
Message-ID: <7df8a788-5285-4781-b48f-ea05e0a5db2b@amd.com>
Date: Tue, 3 Nov 2026 08:01:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Disable FF-A
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <c0af1071a0b965e208391eaaf000a25008730ac0.1792505836.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c0af1071a0b965e208391eaaf000a25008730ac0.1792505836.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8b78d5-e767-4062-96f3-08df39785a39
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|11063799006|261009223027099003|261021123027099003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VotNFKquV/prDZdtn3TiladMptMcbRfC3oxhI/UykJRFS0ehdXLtsqRMElACm/x3IPoIwoUkSECAQCDv6WUH7Qt0v2Z6ti0ImrBROET4cHUb1bpV6s0v8lCRG76Ra2zu7UptJh/5/+Vjlal4TdGoPZjcqnL0J5sljNiff1UKcvR2yn/nVAaGu3MQ3apXXv40kRMUaVRIiuLURvWypFPb/G+jYtLDJRtLH75p3OdJtWIwsofpwWTXbM5ZHRbWk64BTyc9+omYh/VfsDa0MM4EamASYzl+0YeJhmRV3NjP3YJyFvd+2iUe8ro08+ggTaSF+S7+FKlppO2EM/Lo/kyYrh9ea8N1IYUzxkS4KG5t37D5tD8ZS4XYh6dfl6woJrtn6fA4VgjTLkItxXVP0pWDTxqbO0pZJfoxJr8boO1VrRaLyQGqZsMLvXFYezeaYhMMIQ/XXuxBfY92ABlirdfh2y6ssCGU6rOeHOW1hyNH1xUagFxv2B1FaaaUxpmen9aPRFR8v+7rB9pz/48y/JM6QUwrxdFXfsKDyhJhC6LJsFsf/yJ2B4E1Clyfgaw1+S5gKt6ta78MlvPahjl4Qm8PiVQN5ywIV1xu6i+9gi2Gu5wFy34oEoFDehTSvdgztRZ4g+3/toChi1bIaasrqonYFoH8H+9dBIFh9wqQ6xgr3q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(11063799006)(261009223027099003)(261021123027099003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZpNnZMcG1xVS9rN2ZIcGVza2Q4VVB0RENZcTFmbUtNd2s4UTg3WWZ0TkVR?=
 =?utf-8?B?R2VRRDBPcGFHYjNrU2diVm1WbTVGTllzdnhmU082dStkQXdVUUp4TGg3YXN3?=
 =?utf-8?B?cHBLQUJzVkZlRm5Rdk96b0lhSHlQbWRMS1Q4TXBlRVpqeFJWZjd6Q0tqV3Iz?=
 =?utf-8?B?SHpaMWs0VjdyMG5TS1hZRFpHVTdWa3IwMmRHcjlWUVVtbFQ4VU5XL3FVZmJu?=
 =?utf-8?B?SWgyaWNxcE1qRURZY2ZHU2hvMHk1QnZlclF1MGZiQlhvK2N1ZVp1ZGlERjdq?=
 =?utf-8?B?TXl3cW84d1NOd2tFYVd1NmVlTG5ZTEpnQzVOL1crNXNlbXVpZFFKbnRXU002?=
 =?utf-8?B?Sk9heUJ5N2VteVpwRUpWakxFMVpGcEI5cERlbXBhbm04alhzNGtpbzB5ZFdU?=
 =?utf-8?B?Y1VLOTh4QklERSt5THVkNUxSOU5VWmFDbThKM05JaVR3Q1NnRk1EME5uK05j?=
 =?utf-8?B?R2hoYUF2VWxpL05ENUUyc1RJc2VhYzJ6dHhUY1RPQ3NvZGRXL0tKYktDTWZJ?=
 =?utf-8?B?c0Z6dld4QnZaVWF3eXdrbnRQRXRvdE1CREFadVhNNVdONzc5azZGMTNWMUFR?=
 =?utf-8?B?Z3I5Nlo2RGFZQ2dZOU9RMmVwT29qYXc0b0tHVUI2RGc1SEx4aThhWUNmQWh2?=
 =?utf-8?B?VUFScTg2Nm1SR3Y0V2pobUhoZlVCa1NQa3hsWTF5Y1d6ZnJhVHVTUnE5Y2RD?=
 =?utf-8?B?RzdyekRnK2ZhbHU3Q2tUbEdPTmFrVXVDOTJUMy9zbFh4WG9KMzByMDdHaUJU?=
 =?utf-8?B?UkJkTWZuWllvUkdTdTJiM0trdENhMlRCMXQvSzM5cHNDWHlLcFF5ZXlUZjVB?=
 =?utf-8?B?Z3R6L3I3MWYyWjdHVlhrQnNTNHIyc3dhcXF1WGgvcXczNjlvUG9XbHUrcVVm?=
 =?utf-8?B?SGdDVS9aWDRHMWRFMENhS0x5aWkrOWVsMkdwdzRkUUtTWGNka0VSN0c5bXpk?=
 =?utf-8?B?Mm13RlpHaE1JQ1NtRmpFY2dpbW90S054QTFLSWxXNEZWcmxTSzRzVVhFc3Vo?=
 =?utf-8?B?Q1ZUSkJaUDczdDlJZHJlaUU5dWpJWktNTlVkRzlSQjhEaUlPVmhYenkrdW5E?=
 =?utf-8?B?eDJTNTAyRTdIYlZQZXhNWHViSmM3L2RmWWZOMTVNVmZtbXp0RktiQW9tNUR1?=
 =?utf-8?B?RXRJemF6NnNncmZGNnNTc0JDVkErV3NDOWJnV25qSXBJcVUwN1BGYjNFMWFu?=
 =?utf-8?B?WXVMdmtLNE5sZjFuRTF3TVBiQXlJeVlWNmNjbjVFTmRoSFYzbjBaeTF2bjZF?=
 =?utf-8?B?RDYwVmsrT3VJTTN2MW9YaVZPL0NGQ2h5cG9PSlZFc1dhbWJLTGFrcnd4NVM1?=
 =?utf-8?B?OUVnMTR4OERnYkdNdVAyWVBpajJpejN3TkRha3RvS3craWtCRmVvSkoxSGFn?=
 =?utf-8?B?a3l1c3VtcDN3cWNoNEVpOUQ1dkVmaC9jMmUyZGUwSjBDaTZQeVJpRW5uZU53?=
 =?utf-8?B?d1YveTNrWTBicmtmRXNiRWF3a0ZmemZ6UkZKa1p4Ykt5M2lDLzB6U2JWL1lV?=
 =?utf-8?B?YTFiVFFKRmJkQWY2OE0xVUZPL3BuUjRKV3R3Sis1aVBkQW5YdjZnVlhEckNk?=
 =?utf-8?B?cUNwNTJKbVFWblNwRkZ5Q05ZOVFVSDdYNnhCbUJ4bFpnQXBwNzBZRytvQ2c1?=
 =?utf-8?B?MXIxZFh3VFZpRFZGYld3eHdJWDhUamwySUJ2QW9hTkFmMXIvNDV4TmloMTA3?=
 =?utf-8?B?c2ZxQXJCREVaaDdFUW5uRDZWWHp6ZyswQWl3MFVBRnJwdDY5aktHVndHaDJS?=
 =?utf-8?B?WitDLzROUTZQVDROQUQyYXdxallCdVE1T0lNKzNRR1J5VXZnUk1zL0N5L0hi?=
 =?utf-8?B?YXJlZkt4WmZia3VvL2xnZnZQRlBYS0ZxTWZIK1Nva0k5cGViSVkvWnFmVWlM?=
 =?utf-8?B?UkszVEcyL2FPVzdzWlFxT2U1QmhyVzBwdHZ2T3pra0J1MUgrVGtiTDQ4K1ZJ?=
 =?utf-8?B?b0k3eFRsT1A0ck1vMyt0MjBjWlBneVBtSDF4cVNnSXZndE14ZlJYUXlPRTdX?=
 =?utf-8?B?M1ZOcW43eENucUorOWdFd1RqRUhiZHRJTjA3Qytmdyt0Rmh0bjVZUjZhUVVW?=
 =?utf-8?B?SXZJV3I0bFY1eVFZNzdIR3VjQld5SXlBVk56RHo3bXVQaThjZU5zcFlJSHdh?=
 =?utf-8?B?bmFxWndpRm1xTS90disvUE04Vk5OVE1WcHR4OEc5QkpUZFYyOU8zekE1c0VF?=
 =?utf-8?B?VnBDN1pYa1EyUHRBcTBZcFUwTGJKWFgzcnExM2c2STZKMFdJVk1lWm5qNlRT?=
 =?utf-8?B?dnVYY1dHN0dsZzRXWHBYeG5xOWZRMHo4UmFUNk9veXRrQnlOSG1aNWd3MU1D?=
 =?utf-8?B?djZwc256OC94Ymd6dXcwQUNOdWQxTlliLzVZcU55T3c0UTdacnFSdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8b78d5-e767-4062-96f3-08df39785a39
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:01:58.3306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUm2IC6g6lho0mzBbWXSvx+1/nHY/fPQAhK3z/FmKSsUEPBKyJjABtNoNXqP6xIc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 16:17, Michal Simek wrote:
> Disable unused FF-A transport layer.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index f6f87df632a2..b138d58adea8 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -92,7 +92,6 @@ CONFIG_DFU_MTD=y
>   CONFIG_DFU_RAM=y
>   CONFIG_DFU_SF=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
> -CONFIG_ARM_FFA_TRANSPORT=y
>   CONFIG_SCMI_FIRMWARE=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_VERSALPL=y
> ---
> 

Applied.
M
