Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E60606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 06:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sk1Z6uXi;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f4L6JIc1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B494606D0;
	Tue,  3 Nov 2026 06:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ntINqZnnWKo5; Tue,  3 Nov 2026 06:56:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 704D0606E9
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689017;
	b=gaqkZSbcLmZUgq46ez5t253g6KCa4vqvqkBCJyn3qnlMELeA9MvMmlzINKmuGd579fV4
	 +KprmbkS/JcZzHu4iPVMgnrvRopC+MJb9eE1UurK71peCYrsksRkyx6rQvkyFkDeoD4OL
	 vhV2VLaLa3wxZy5mk322XJ5Dn3KiQWWerqhACSD8Cq6IrbwIBNZL+D5hDmpIQ2IgN7/9A
	 uqQsb+Mb4bCQiBKnZi7rkWGNp9O1McuhgvLoa7tL/xNg88b+ouxPl5bSVW8P/1RfmF6fw
	 713ZK/DgC6A/4JJSsSsn8sHqCIupJ5MRSqSllcqAuU/tsIuk9HoFJf7GCojHd28APDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689017;
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
	bh=9HiYE05DSGFwuXVFjUTJuAy2Q3j3Hj6oyUtBDKZpyrU=;
	b=OvD1cPpJ0nhfa+RJNynp7wZriqAe+iBZy4tJiCjbCht1Cd5g307a7u1mSYbwqZgKgUnW
	 LK4qdd66KkUOiVMbclAZf8IHlzqmWOWzB1mtPNwBV+Q/kOGnwXOcawI9zemrUT4t+gMfp
	 pjA385yKiV81RqaYI7JVgenIZV88jbFVyCPo4LL8hywWi5QsZ/Q21hbPuJXDllzR2aGnv
	 UMBl10M8HTo7ZwSi98z22CO9EXoBHRWnD9pI4TTKD8XCAZ51SFPUhbxPuHqfT81zXZmAV
	 WYZiAg+T4sty4vhljYF1NBLZH5zwo9iYZIWX2rppls+AuoYeK6tfbrRsSAdMEIupsuw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689017;
	bh=9HiYE05DSGFwuXVFjUTJuAy2Q3j3Hj6oyUtBDKZpyrU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sk1Z6uXiEfJQcsRa/OQbKKiie3NHli0VcEOrP5NmtccxenyZYo6oK+mS0aRUBB6be
	 GPoEEDQ1jxltGBsPx+RmoxIYTWHbffUBh2GqbEkwvzqsUdJ9/LcBBPWg+ZSuXwHa35
	 Zr4mPIueeHgH/bwsNXdPtOvuY1pdVXh/DBImLzksbZL6EWUcH8jt6RF0B7xw0sz1nB
	 GUsqgZFBOIoBiOBusm2VLYKhGSC1YIX9LK9VR8OJ8QMQyfUjId1XUj4rTr9b5VwlQ/
	 d/BNYseNZRs5Fissdt6sRaJEn7lxwtVbIHu/d4TKNwURpWL1buov1WJRssXUJxCwgP
	 9lU9XhitAJmeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 704D0606E9;
	Tue,  3 Nov 2026 06:56:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C6C20411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:56:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B66A380E01
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2w70EAV68Xh5 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 06:56:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF8C680D84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689015;
 b=f0IyYgwvPOZ1KF+T0fnE9DgwnK/PttiOEQMnjCTRPpgAKpJaOrariN0U3dMXU7q2gkot
 +vSwhuRmUM/rqkevzF3bA8EVyGIeZLUHOhuupeCE4/X32HXPK894Skye8Y4MF1DtN8FmD
 ktizP12X5bxfFwrMMuNUygeorrlCVq79BPYctCM4WOwHVEBLn1DZiYZZVepyzve0mJp2g
 aqNe9ywwf8LB8bXvvXjN1EoRsBVPsd0S4NAOfOX7lxQQh77Ttj407NOZsrIIWCRxl8xyb
 5aSXKpMuRsXBYio1wRKbGX9Gzbbrv+PfHvlcXncqYe4LyH6LauAjsGZgNeNgsCay8PQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689015;
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
 bh=9HiYE05DSGFwuXVFjUTJuAy2Q3j3Hj6oyUtBDKZpyrU=;
 b=H5LIGYQ9JyFs7b33I7Yfi+d1jDdZQ5+FyX65kWgS1BOWDJIhMW0NZsRQBxNiXNHiz27a
 c52yv8qekSl/95acR3gxTUB3Vobsqj8pH38R4aPyAC9aN2P4FekV4Lc3zRl+3E2PLut6j
 Em/wZIqjyqJ9hlNKW1WRbzT5z0plDJkQYdFdyib08MuOj76CtrE9txh2nxnfVXrAuAu1f
 z8A6RAlrCGrXFnOaRobLWBGxpQxEA++2pLIGc4PB40XYCq/FzHBYHzOu8SlccKfVhreZU
 ESmjo16RLx8esUcJfVkWNTXkm/dS0+wHptgelOK0QpH2yfK975J0E19QQroqDpiKWhw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=f4L6JIc1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=f4L6JIc1
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF8C680D84
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:56:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwavLZZ1rDjWkzHZ3XQALbECRkKfzi6B/XJcw+A7XAxvhn/zO6yOrpCwbpChjNZ2Y8/SF0+HmxWVnX56XR+SCmsjU3X7zek+6x5aALemXb8DEormjQaux29z3vvMCxmnQkJGwx8WSSY1L07r5qy0tMQ012EJb5OW2z6D55lj4/yILsc4z5mzXSdID0O31GX+j9k2hsUA6+lJmvxi8u5YSz1G7dGsM+NUuJxUwj+dM/9mu72KsVmLuVIKPK6tNq/BmXz9SA1gEmhuJWxr8eq9pH5wkZmRZ2cShkxVraNToN9cEeul8yajrjHhtMlslYX95MYhCCjYA71GxJodW8ZeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HiYE05DSGFwuXVFjUTJuAy2Q3j3Hj6oyUtBDKZpyrU=;
 b=QYnh3a7NcdyraKp4w19CMwCI2WJaJdf+VzRQs6EqaXdX2d+a9TFAU8Guh0mX5h3A6S6UnHDS9fbaBqiMeSuNDZ68nHgrvlSnEztczkehRjNL64ljf06sGV4XUPea03CtziQFif2eO9v/PvQdU7iV0Z1N+CrtG/DxW94y4Ik6Rk5S4KYEYtQ0faj89gbSYQj+3ANN6TOXE47XPy7YCk1NVHvW/lBAjDdueo1qGwgyPYYmo9E07ALnGrAGjd+sAB24WXErKhzgnqD3mkOD47ui6VESJMgHNfM3KwUGbYiSq9kiqkkZTJn4cjoxNtwT+1Fsr8BI2C9abjJFqf/uUI/O7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HiYE05DSGFwuXVFjUTJuAy2Q3j3Hj6oyUtBDKZpyrU=;
 b=f4L6JIc1RMB3gUykU2MfzgxKFnulMhrz0uK1Wf39/Xn5CGMK1d6/xKKpqoVjbLlTz07ixoMjepe74psTOe+ByoPeYmSnV1eyWz5dsc8ID+klkjGG7VsX6jv8Ne8OFNxPztCRUetwk8C1M1HYQLCzVGC1QdJGzkMIZfRuT6wZpmU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:56:50 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:56:50 +0000
Message-ID: <dea1987e-b6a0-432f-8c67-4a0a88658b6d@amd.com>
Date: Tue, 3 Nov 2026 07:56:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: zynqmppl: fix pointer arithmetic in
 zynqmp_align_dma_buffer()
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <f1a657871243e50a068872f4fadfbc9a5820600b.1792503977.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f1a657871243e50a068872f4fadfbc9a5820600b.1792503977.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:a03:333::27) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: 14afda97-9b2c-4ca3-b9a1-08df3977a280
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|260925021911599003|260925022911599003|260925021311599003|11063799006|261009223027099003|261021123027099003|56012099006|261021121427099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: quqRgm8xAR1dmtczR4SjPAdcBdPqCv2widHAT6Mp1k9rkakxtaAIBMRCHxnciP8kmOFaJTsw5P94IdYK4tvFjZjtOB9Qpi3c9DFuAaOwXASXQDm661nc1OSwh6BJQcvHyYB24DS7y4vk3YWPE7gtZR4dZ5uiIOrjdlHuv/klH0JJ4stRUed2lgo2D3ka/iUs8AbhZgDbi1n8dEPY5cz3pT+YOrO1cso5G7oA4H6i2FFK7R+gMY7vhDPj/cfRGCHWktZpO8DzwINjL4grPxcvwF64hinuWRzEAqyluTTJjd6p345Y2UQ24ZBjmdkTbPcKB/EqWEdSwi5aIMZuj0A5iPG95OPbv9K+zrWu6QcY5Z7UpV/W++7nY97GJe2Ri2IESDco22itNq9mPtjKtHy4tFZs3WlapTeubccbD8UArkWKsqZZqh18AblaDcoORvJZS1nlHg5tO98GiaYMoFzZF8RDLW976JNqDVUaFdIbEo/5KH2sX4GRF3q7/XkUmqRzQqiH+5Q1UBq0UeZGOWdkns+6MuZDZnuwB7E18aJ9lV352O+r+htUPHKW40nKIjt6NrPzqtZ3hVZO0JT2f4U4KjcK3Tt6CiyRU75Fau1OIJJWyPsf7akHUQon8cEaSOy0G0OUoX1ULSmOcDUjF+P5iqaQU3dqQ/TTdKwEzgKsC2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(260925021911599003)(260925022911599003)(260925021311599003)(11063799006)(261009223027099003)(261021123027099003)(56012099006)(261021121427099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1NNaWhwVWRCLzYvZitwTkdTOVVUanI2TUVRUnJQL0JaMW1oVUR0VHk0V3Q1?=
 =?utf-8?B?QXBkcWJTQU10eGZmemI0MUxFdlJPSWxTT0JZRzBwTjA3WnN3UG4vWGl2aG5T?=
 =?utf-8?B?YlZPWFUvdk5GRGQ4L3NDT1lJejhuTUhVUkk1S0FqZU9WVmcyR0RWRlZlb2Vr?=
 =?utf-8?B?MTZjcHk0eUJ2VVNFWkZvb3JnaElsTU84N243R0JOVWpHYVBYTmpKTjBKN1dV?=
 =?utf-8?B?MnQ2Tnp5TTNobzUyV3JMVXJ5TmkwZDJybndWME1wN0xGamtKL0YxVWJnbGVU?=
 =?utf-8?B?aGFOTzdHTVZ6aFhDcFd2T0REd2pHS2xRMG0xdi82SHUzQUR2YTV3N0F3eTVL?=
 =?utf-8?B?ZVJDM1BVREdaLyt4cElNTi9Eb0orZUxoSnZoSWtyVXhLTDdvbEdsUENxaHNv?=
 =?utf-8?B?NXNWMENmMjZ0QTNmNFAwbzErdUlIcEtPMkoySlNPcDhjWk9tMkRyZU9PWjln?=
 =?utf-8?B?Nkw1NUpzTjhuYnRDalZENU1meWxOVDRib1VlbW5ub1ZYTU9PdzZiR01yRHc5?=
 =?utf-8?B?Z1FPTDRmQi9XdXU3SkszTVNKWkRiSlNkWXZDTEV3Wm1HbEVDdHJCWXoxTVdQ?=
 =?utf-8?B?aGtpUFJKejRDS3JLeksvUjhVaTRsZzRTTjZyL3JBN3gyTzZjS3ZQanNKUEFW?=
 =?utf-8?B?dVljWkZhdytEbnpNS2w1aklqdlNIeU5WZ2h0MHhaa1J6OXVsdklxaWxMQ3NQ?=
 =?utf-8?B?SmY4YjVjcU9tanVjOWhUZ2Q4cFM2S2JzQUNNd3ZUTEhTS2F0S0Ewd1VMM1Q5?=
 =?utf-8?B?UC9NZXE0VzdYSVN5eEdaSDlXSnlCLzBvNlV3aU5raTdiOGl5SE5lMnlKN2N2?=
 =?utf-8?B?MjUrMzRCMDQzb2t5MGVKRmdhY0NsaUhEWHA0enQ3ME9udGRVSkRRU2hYNVlq?=
 =?utf-8?B?d3pjMHd3dmZubHArWWJqd3prVGR5ektIbDJqczNjR09aTlN6aVc0ZWxXOFEy?=
 =?utf-8?B?aWZ5V0xMU0dnR0w5VjZhZVdPc2NjdGdYL1JnWVZIdFBrWGkzZHFVVzJid3Iz?=
 =?utf-8?B?VzRIS0tXVDNLZTNZNWRBMEZPYXlubi9LcWhjNTFHVlBDVHdqSFArWTZDcktr?=
 =?utf-8?B?S09sUkpCN05wUXR1SVpQZ2dvWFV1S3NxYkVka0Jhd2s5azhPQVl2VE9PWmpB?=
 =?utf-8?B?ZXJZNVdjYmhlTkF3QTlOdVQzb2VBc0sweG0vSE92NVRidjdFejRrcDlSTFoy?=
 =?utf-8?B?MkI5ZHhSck1VcDZhb3RvT1VGemQxUm13YWJncUZVWjVMa1cwdGt5YkErdGxQ?=
 =?utf-8?B?WTZtNmRFZnhFQWxrbFNOcm1OQlU4Yk5zeFNIQjNqQ1VMR01VRk9Vd3E5K0xJ?=
 =?utf-8?B?ZDNKOEdxczdMTG51aVllYjFDK2tRR3dKYy9OcjFFYW1ZSFgwOVdBc2xodmV6?=
 =?utf-8?B?Zk43ZEhEY0ppM1BkZ0hWWlUwUUFVNzN2b2hPdTZ4VE00bzdxOURSUTVBdTNh?=
 =?utf-8?B?ZFVUTkRvdFRqSTRBWDRzaXFyQitPaE5Ca0FsRXlQd3R6RzJkNy9TemdJelJu?=
 =?utf-8?B?YUZxZWEyRGo0RkdUbWNDTWhhbkkyMUZSOVVFdVNyb3oyKzA1d1lIS1dXMENh?=
 =?utf-8?B?RkRTTEhjWnpSM3RCQ3cxY3ZzZ0Z4dkEvUXRDR2QycXBaRXI1SXA3UnhsQWZF?=
 =?utf-8?B?cnRKUEtQdXpmMzBhTTlQYm1JTkJMQ1dJN1Bid2pVSzg2eS9VeGpOeXpPVE5I?=
 =?utf-8?B?cXUrTzZLRUwyZUNEbHg2VWhuZVgyV1lRWFVNZXBvSk5yQURKMlZvMmRxMlE5?=
 =?utf-8?B?NHR6ajV5OVRQc25RVEJld1JzV3pjVG5Vc3BuZkdBMTV2TjZwVHFXY1ZNOGcx?=
 =?utf-8?B?NFJQWGFhNEQzQTJVWlBxSmVYcHpyTm92eU5PMmVYaHkxUTBreWNWYkR3OTY1?=
 =?utf-8?B?TlBQLy9GNnQ3NE1CNXlYRE5PYkh4QlA3SDRMc3dqMDB6dnNBTWZGWGNrVWF2?=
 =?utf-8?B?WHlhTDVyNmFmZ0V4WHk2bUZ0UjAxRWpsVndpV1BqdzZJUzNscU5ZRmorb3cy?=
 =?utf-8?B?OG9zaVhqSGhFcmg4QU55VVBkSElOL0MySUMrSmgyMlNhZ3pzZUdrL3RZcjhF?=
 =?utf-8?B?cUE5NXhqaXUzcytJTXZCZCs1cFMrVWdSQkdrUVFPbjdianVQU1d4Z3FZSW05?=
 =?utf-8?B?dGl5b1pteFc3UlYyRmE5RnhSY2Z4c0xDbWVnOVg4ZE0rSk1FMWE1YmR6K0Nr?=
 =?utf-8?B?ZHpaTDRXYzFUcXNaaXA1SkFFR2ljNFl0T2xyay9aSVRScVE1cmplcFNoSTlu?=
 =?utf-8?B?RmkyaktLU0pWRFhSNU50Q0dRWmRPd09TZFVzM3dscjRkSWUwVmhLaXUzbi92?=
 =?utf-8?B?TUM3Z21tL21GS1FUcnVoZ3BqdEhRd1puUDVPamh2dW5tRnJTaml1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14afda97-9b2c-4ca3-b9a1-08df3977a280
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:56:50.1762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uh46Ze+fujCwkjKKqUxlr6guhROhALe4dbP0HPZvgB0/9flfdDD7T72M2+FvvEDc
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 15:46, Michal Simek wrote:
> From: Suraj Kakade <suraj.hanumantkakade@amd.com>
> 
> zynqmp_align_dma_buffer() steps an unaligned bitstream pointer
> back by ARCH_DMA_MINALIGN before copying into the aligned
> destination. Because new_buf is a u32 *, "new_buf -=
> ARCH_DMA_MINALIGN" subtracts ARCH_DMA_MINALIGN u32 elements
> (sizeof(u32) * ARCH_DMA_MINALIGN bytes) instead of
> ARCH_DMA_MINALIGN bytes, so the copy starts well before the
> caller-provided buffer.
> 
> Cast to ulong before subtracting so the offset is applied in
> bytes and 64-bit addresses are preserved.
> 
> Fixes: 6b2450143882 ("fpga: xilinx: zynqmp: Add PL bitstream download support for ZynqMP")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/fpga/zynqmppl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/zynqmppl.c b/drivers/fpga/zynqmppl.c
> index 048d0d2e7a1b..24af1e0173e5 100644
> --- a/drivers/fpga/zynqmppl.c
> +++ b/drivers/fpga/zynqmppl.c
> @@ -147,7 +147,7 @@ static ulong zynqmp_align_dma_buffer(u32 *buf, u32 len, u32 swap)
>   		if (new_buf > (u32 *)buf) {
>   			debug("%s: Aligned buffer is after buffer start\n",
>   			      __func__);
> -			new_buf -= ARCH_DMA_MINALIGN;
> +			new_buf = (u32 *)((ulong)new_buf - ARCH_DMA_MINALIGN);
>   		}
>   		printf("%s: Align buffer at %px to %px(swap %d)\n", __func__,
>   		       buf, new_buf, swap);
> ---
> base-commit: 74d8eae19c90dadace5a16ee8b589fff563e086a
> 

Applied.
M
