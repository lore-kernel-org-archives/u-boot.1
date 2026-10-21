Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6828E606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uAxruuYh;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EWmTSyb9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BF4C607C9;
	Wed, 21 Oct 2026 10:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aPvgA__9frNW; Wed, 21 Oct 2026 10:34:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4DFE9606B6
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792578856;
	b=PONKNLaMSFgqYzO5+ro6JhB3ahIiWh15EeIXojZMypNb8eRg012iOZQ4+HiDYkhcHGb7
	 0Gd+SSfYoRbPzglvoHn5P29yb64H+uKW1vGMYHmyvto9yrj98xDj3jVycapxn+AO6NkfF
	 eA7bzazMtHrssBIwF/0c7rgieZyr+kSUcUUtD2E4hYRf5jVaSjt8h2eVFLD+6F32H5304
	 DxTREoN/zrzCphd0pJIv6hpkjBUsmqkeM0hl8CffuWETYoCPMfMX5+3vBkZVIbEdkXGvM
	 OOuWlHzkVARZs6VvJjAuXdGMNDfWHnfWVnbKuGu3YD7bUlcvuj88IUq3PZAzQdNOrzA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792578856;
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
	bh=PObqwaXmiIkGUNE7iDPXnU6cWe3EMhmCtMaOdFjz2B8=;
	b=YT6NBUIRVmIKYgWGjP3N/P4F26GLXUZppnte4OW0FsZWojT+46K+2JRkDyXRBDEef1pk
	 qSNVmX6jR3gPpietT6u6yXHGxEDxPL3F13Q44a8IT7ILxh2GH/QGoBaIiqsOWWnQv3kby
	 N/ZYnWwklQyPiuojTJFHi48NtQpuCwOrhorFtU6ibtPov3sIbApJLsg2eDoATBFOFSJYa
	 rjBZTlS31P7HKNu4BGXOqAdbGWU2Pp+vcKJtr/AivuQKmLuZwCZ/j6sNTo7V7ryknVI6Y
	 TyIx6hkm/e1wV482EYnf2h2ZCbTbmMWIwzgv/dHnpHn9hPt9tBOUgzqUX3e4BOv9tng==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EWmTSyb9;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792578856;
	bh=PObqwaXmiIkGUNE7iDPXnU6cWe3EMhmCtMaOdFjz2B8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uAxruuYhXPURaZJ6YgC8U1mU1FJaKJVATYd3g1bePwmBw7bHbXGtt1P6v1i/gEiqJ
	 qksoeeL0897wRGsfhOosRiklFGeCXzodO3P5dYwB9Gpng2Tsy9qNasWCBumfwUEc5m
	 k46zd2fTjzzpVoF2aBJoKz+7ivz6YcJEX3ry/9lYKCW2PydpAceN8QMTSwSzyQC8Y5
	 mUTq2dkQh6pMqWBzK2ZV7oY9rCXm/ok1X0D3a0ZdDaCUhv+DicrY0jWgeTvUdjF5Oj
	 psCZeBXNrfeIZaaMjPeX0OTHo94DSnztXN1QC/+lsETsopuXKn6nf/w/vIbLMehC8g
	 NaEJ6Q6nz7cww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DFE9606B6;
	Wed, 21 Oct 2026 10:34:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE1381E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA893606B6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:34:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZOlC6rAZdXgB for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 10:34:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 080F7605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792578853;
 b=DFUJIh2/Oh9tYAMjBn7GI6wpZSLrf9PGb25VUoIkiER8A5ndl2L6DPi1UIFOndNzEgUr
 uy/mfMqaF32dzeETsWlCGDA0Zz7Utefj9L5GA6cJQB6ihkb1oOoaxV8rRVbYZtpol6neM
 GxHGJJdeX7M9JDujLg9tteYsbHyQqMzDHOPzkXfUTZnC362RKwG+ECYDWdNpMAxzCjbiK
 0VA4qIqs9UOZ/65zBqKTz5num9lVnTQfUWFWbmweZZEUEWCkVjYk4Rbih3f1UGkLdwsuT
 GJ81WuWT41V0HJQvjSCCvk/aznJVbixfuS+RKLprvtpbhVKrjvP3Lyj4JBNAGjER1Vw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792578853;
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
 bh=PObqwaXmiIkGUNE7iDPXnU6cWe3EMhmCtMaOdFjz2B8=;
 b=Y/KH05axQgzi7ton16rphCmzMcdDhCjeAx5EtfF8wcUDuY+8kvOBNwPbnIu6zUHj2oUS
 fS2BgbrKDzjg4iNA7vFmjEYfA1xeWdm+l8DguQtt1wVR5mr9nLU72IiOahXMoQcsCOIEh
 gAgde0Wyl8Ddd4NNEghBDyV8MCRJQIjHgdyGv2E4gWrNtlwNKpAOOLGdPR7pk8PaEPbuk
 ExuBm1J0tSAJlynW8WSuA0Zrw1GQZeGLQZH2/85fn6AR43qQbAp/UW/IR2dWnltl8/mn0
 KcXN2OARDd3zUR+/PmU91Vo91ewpK9pyS1o9qqGcxwjiOHvt3v+zyEvRIPnRfTrR4yg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=EWmTSyb9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=EWmTSyb9
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 080F7605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 10:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G32lOcx/Z3oNVGCn5SjYr1GEj893J9OH/SeJOLVslKx9GSsaKiIdi3xC9dqS+jFeZU/IdKKTMyyo+H6LBQ2dLbcCoAV94K05XYdbUGLtprcYX0op0M14fdVktqKgyxKHhkCh3aBeZ+Y01ZKTS/99PWRSVngmJXPL2FNsu7g+UKsriVMcA4xgRLyuoTYQUUFwdW8A5b3J9kjSP98FhpBKygKMGFYOQQaCdMt523C8BLJ1wbIU9Hrg3CIPsiHql4vOBDPaTwXNwMzWWiG+NOjC1vt1TkCm7BejRtZbbwR0M0DmRtvx5dg+UT6sOLYhUn/gkmCP545q8LFOndyZJtyo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PObqwaXmiIkGUNE7iDPXnU6cWe3EMhmCtMaOdFjz2B8=;
 b=zKfTDabp5k0ja/sdugmmSHm21spaCNSylIOBlJA3fyd/VDqTKq2hIZDFwASzv11bXL+Pl5cPEW5f0+OlU3BP49ebQER2FMoyGVYsgmGqh9Zn6hJt1TPDaT1R1+z8RvDt9wwAM8uzMty+Dq9U9msmQ0z0C7bNyL8UsGQFWWErIWhxKqFCADMtwpb7sLxwW3suepFAVBnkG3w2ivp3E14Y6VW6wqSVgYw36F1ua17Cy6enaS5wLoPW+gEPY/HceTKEr/S36r6vyezEzihr0ecbh/D3QdxQgYpV4b2anrohVPPkGzJ3qgl1u4kvZ5wHvRu1WKVgBTVa6G3tJlfk5allhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PObqwaXmiIkGUNE7iDPXnU6cWe3EMhmCtMaOdFjz2B8=;
 b=EWmTSyb9G6KM7JCyTueSLenRkkmHpI6U66ebqCy3acntw8yD+f1ZJfbGzU+egD2jj4iweUiPeZtqkavWkYuf7m6gsEcW0TglqV8kEBUy9MThK1MrDE4lukmGnCTpnrZzOjXXas5iLuKgrZ0yW9bPu3/uKbl6jjyYiCKOa4N/9pE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 10:34:04 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 10:34:04 +0000
Message-ID: <67b190b9-3e65-4f88-88cc-aed106b4e159@amd.com>
Date: Wed, 21 Oct 2026 12:34:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] xilinx: mbv: Enable Timer, Ethernet support
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
References: <cover.1792505359.git.michal.simek@amd.com>
 <d8cfd0f911d986456ff57b96a9c77e3300303f75.1792505359.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <d8cfd0f911d986456ff57b96a9c77e3300303f75.1792505359.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b932579-b060-4a50-5b41-08df2f5ed424
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PCGoRhYNb+TjFl/qqwS8dWA6pjJWHEMzBvZcuOS44os6nvyGoN7wm1GWpUWL9NzIbCvR4hHtyJ8/J6IKZGX4ZVw+sv7sVaDAZm80Kn/HznURoChMbWN6qHLVUuvyG6cBSmt+wJL6IZgckfQX8i+j60rhR7i1EGEqNBm1NW/QZlrdR/fdfLIIAUErAOu68odumCL24JKoBk55+q2sOIdS5Ex8KlEgUz0LjswHWP6Mx3DARdttNMWeuAHXq4KgPsw4+JaPv2ojevuesp6uMX1V98K6fdRY+Fl1HaTMXrUCeiiQ/Jf4F5pJNh5mdAYZxxlfB2ysLYIKtAhI1b7R3J5FMh0wsOlH+9PR9ZDeIiwztGTTGRgcy+CIORafQ2oUFMvuITbK5L3ePa1EvJtopHzssTWpMRA/tJPfw8PUNL7qSENQn0escrAEvXrp/Kuv2Ft9uOvBiwpPGn0IVukdZVwYmTeamBE7KPoqUR9w1jEYCVKmRnBYU+4TsUKC43Jfz88le8waN8oPTHsIcycJ7zXhs86er5sHQzqDv5Y+lJqksZKWzo1A2dBEKAg8sq2DNLzbFSo9u37m2gikogRssc1VaBs+coaVBUDHwydbygn75FrKv7CSM7UZr2iFM1tFBz2FoasEzOezZ8C2z6j23JIBT6LnHYSGaqa5pe21YRsKJ+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzEwbmI3eGVFK1JuV0tURUYyRE1zUWlObVBtRDZnKzk5SS9jaktoOGlrUFRP?=
 =?utf-8?B?Q2g1TUY1MlFpQnA4U3k0bTQ0VTF3WVVZTEZvRStRbzA1NjhwdGN4K2RuUTNU?=
 =?utf-8?B?b0ZuQXVTN3g2SDNNM2NRMmpocGtnTHZFWkVXaFovL3Vmb01YTHdZN0xrVS95?=
 =?utf-8?B?azBCTFgxWVdleDZMT2wrRHRRZytWS1dYNmE5eVhEWGRseTJkOUdQTDhUc20v?=
 =?utf-8?B?NmxLa3lJb0RIL0ptcXl4WGRVRElnaVczZ2c5NUJwQjhoSm1ScmxlaENvbnpt?=
 =?utf-8?B?MGhDT01pdWUvS1g4WUhUT3FaSTJVdzRycHhmSG9UUXljMCtZOTF4QTIwME5a?=
 =?utf-8?B?RUxHSDBZRGVmaFBoa0lhdlF5WnBOQXhMaG9Zb0xIRGZIYXNwZ1pSU3FVMnY5?=
 =?utf-8?B?SnpqTHFSbXFNWk53TkRpbG9nc2FmeTNkUHFMZkxvTFh0M3VWV2p4NzBUMTFX?=
 =?utf-8?B?MDE3aU0ybHp4VkZZWWRiaGJ1dTVPeUZFaXlkY1dKdWlyQVhtUTdjVE1oQTlS?=
 =?utf-8?B?SnBXWDROY0l0TnlqUk5JVlhwbnd6dmRramZMWDVyOFBxNDZMMkxtSDAyc3BY?=
 =?utf-8?B?NzZaY2p2d3VWaHdNVTd0WlhPeG0vaVFCenlXMmNScGJZMTNKU2hkS2NrK3RC?=
 =?utf-8?B?K0dXbWphN3hqakpFYlpHd2wxSFRON3VzQmNPRHZWRTlMVlJtczZwY2I3WmRn?=
 =?utf-8?B?cEJ4ZzB6ZHpXVmpURXVEUDE4Sll2VFE1TXhEbkVOeFFJbXZWZlRBMElmaWJh?=
 =?utf-8?B?OHh5L1BHSi9uTCttRVdUeEFvek5uVDZiQTVkNkRuekxTNmRxK1kxRmE2ZVJn?=
 =?utf-8?B?TmNMWnVxR1V3OWRhdEgwMVFGeGJjMzFZN2pUOVd1QzNnM2VTaEpVNG9Hc2NM?=
 =?utf-8?B?VUFOZHJIcm4rcWR0c0xuS3I2dTdVY25DclRWbVBNbm9QWjdoTVVRSnN0SUZL?=
 =?utf-8?B?UGp3YUEyK3VMRTZpWTFyYTZQNzNoUHd6bnhPRXdydCtvSlZKVzY3Nmlmc0tj?=
 =?utf-8?B?QloxOWRaemY4QmtCb3BkRWpvQmRVQVlvZDdiV2hGdHVMMDh3MlFlcnl3a1Iz?=
 =?utf-8?B?dE9pWEsyeFdlTEhSbm41K2tDUXIxQ0tyeTYrbXQ1bXFCdzFvZnlEUHpDWThM?=
 =?utf-8?B?UFpkQ2pVZ2lKK2l2czNXOU9lMHJIMTFHSE9rTjJ2bW5rbG1qUHU4dGIrN3NZ?=
 =?utf-8?B?Zm8xOGNoVnc4QjM1QmExN21NZVVWciszRlFhOXpFVFVWSVhjVGFtLzBTZ0VW?=
 =?utf-8?B?L01LK1hrZG9yVVFCN1h6QXRweDY2K0R6RXVUMFlaMXdYMlFyRE8wVGpINUNn?=
 =?utf-8?B?MTNNWE5EZmdFK1M4MDJvdjFyd0E1RWN3MDduV05vOXI2WjBwc1JNTDFVOUh1?=
 =?utf-8?B?a3BwUVFXTE9ycjh5N21NaWMxMUNndFBwME9zd1VzMkI2RXlGSVVtMHpYMXVh?=
 =?utf-8?B?RW1rbWJpSjllSUgvT3ZrT3FzOHVWRDYwQWRnSmNKdUo0aU44dzZpbk9Ub2JK?=
 =?utf-8?B?NTZxSEkzY0NpU3lBQy9sR3dHOUg5dzVzKytaRlh1NWI5SFV1cWxkNUtvSDZh?=
 =?utf-8?B?aWx0QnZJUFYyV284azhMck9ZL1NudTYreGZMTXFMQzIrd0Q3d09jUXRYSXFk?=
 =?utf-8?B?Mm5SYmdBOXo1ODh4d3ErY2hBV0MvNjFwYTZuWk1QakZwRE5LUHNEa1A0M2tx?=
 =?utf-8?B?alpGS0lLK1puUnBRZTZmUTUwOXU3UFhSVG5UN2J2Tm5YUFlyQVNqdVdSVFdQ?=
 =?utf-8?B?bW8xSWZvN1hnTHpGTSt2S0VlaUlOVGJlVVczUEdTblVpaXB6WlBMRDJtdkF5?=
 =?utf-8?B?TnNYYzNEblQ2dkEyZmMzS1U4blFwbVdFS2pqWXlZWldURE9Sak10VUFvbjUv?=
 =?utf-8?B?S3pGaGtKYlhkSy93MHJSQ0FuWXpQbTRaY05DNlZCbVRQd2lNWTYramlqeVM0?=
 =?utf-8?B?RUFSaGRTYW84cWxqb21tSnNIQmRaUmNDaFViVm5wdURmRWRycC9LS3JtWjdl?=
 =?utf-8?B?WnNETktyQVN5eVNEelF0N1ZNejNtcjJBMkRWYnhabXY0T3lQbHRBTXA2Rjl4?=
 =?utf-8?B?TzUyaXhKUGY1RCthY2I3aUNBbzlVMmF3Y01BRVZVRVBGMjd2ZFRtVlBCL3h1?=
 =?utf-8?B?RnhrUld5NkUvcUpDaTIwbWZOdEYvYkQvVXNjaUoyeUlGTnlRNy9aeWhPcktJ?=
 =?utf-8?B?MkpqMU01aGF6TUhZTW4xS1BadnBPM2lHZ0ZyV1FxM1pmZmd2aUxPUEpvSUVu?=
 =?utf-8?B?TlIvVE1ET0tPMWxYbk92Zy9tc1did1JaVzRsOG12cnBQL3oxYXhUTFhSZjFy?=
 =?utf-8?B?Mis1S0ZYSUpnKzF4SjdacFpzOEpsbUdVUVFLamcwdDRrTkJmK3Y2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b932579-b060-4a50-5b41-08df2f5ed424
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 10:34:04.4007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7NkDWVRk8A10umFLOVzKSbr0mOMt3YeRqQ3C19O8OIE9Yz31cpRZyUu1BSqr6bh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 16:09, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Enable RISC-V timer and Ethernet support.
> 
> Both the RISC-V timer and the Xilinx AXI timer are enabled by
> default to support whichever timer is enabled in the device tree.
> At runtime, U-Boot selects the appropriate timer based on the
> available device node.
> 
> The QEMU model does not support the RISC-V timer, which is why
> the AXI timer is used instead. RISC-V timer can be used for
> minimal footprint and early availability.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_mbv32_defconfig | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
> index 47cecd6878a7..c84b1a41655f 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -43,16 +43,23 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
>   CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
>   # CONFIG_SPL_CPU is not set
>   CONFIG_SPL_REMAKE_ELF=y
> -# CONFIG_CMD_MII is not set
>   CONFIG_CMD_SNTP=y
>   CONFIG_CMD_TIMER=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_NET_LWIP=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_DM_MTD=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_XILINX_AXIEMAC=y
> +CONFIG_XILINX_EMACLITE=y
> +CONFIG_PHY_MARVELL=y
> +CONFIG_PHY_TI_DP83867=y
>   CONFIG_DM_RTC=y
>   CONFIG_RTC_EMULATION=y
>   CONFIG_XILINX_UARTLITE=y
> -CONFIG_XILINX_TIMER=y
> +CONFIG_RISCV_TIMER=y

Unfortunately this can't be applied. It is working in xilinx qemu but not on 
upstream. It should stay only as enabling ethernet and that's it.

M

