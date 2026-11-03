Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB6606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tTFWq2Js;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qnowQfxC
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DAE4E6070C;
	Tue,  3 Nov 2026 06:59:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wB32nbZjc9zi; Tue,  3 Nov 2026 06:59:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A30C606D0
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689199;
	b=f7ih/8uFL+ldTswP31w0x31fvVI7VlzXQz1cHaTcdOxLbng3SJ2wNZ2biyoCWhCZc/+e
	 tWc4Sfd+AHRqJ3oZexL/MEEDTQOmfpKxsggg/Wcx/md9O0tWA9VSWnyDa4mnMuidEPvyF
	 AFni9KKA9uvUjcgkrHyoJuFBfGZB9TONN3F9WCQ26sMlPGgPpLpbxDo9GrfmjulUHq3Ui
	 osbpQjvkK7dffIMq5Y/Gyl8dhC2S6JA7fi3Er5sLjVq6LRg3vnZBiEMtj7Ca5asyQgkdq
	 Kgm9X5ReqF90uvVwRHrCLmljc3dWeLjh0di/QOg0Wj9/qdaLi63Sh+dyJa6JwLqsmuw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689199;
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
	bh=SNAqZ+SkthJWyTmvef3h2M9C1EGo799IVBsQtXDPjLc=;
	b=GIy6U+h7oop2bIdycYr8fO4TrCYntvE89jlMNflth/PpEhlpxshFnZO0yluf0fwdTyfO
	 K/h+2cHuuJhRGNk4jH0gNVXcXtU77QSOVbuhqcUb5VYnRQ/NFO5qoH7+yAmhjbj2a+V34
	 WV8fLThM3Vdadw2l+35stvzGMdbNqomTdy9Lc40mY9n+ZCM8GcNBZdC00eimNvJwNC/v0
	 2c+pYVaJQCzA8bAC3aVAhu/5N8kqOgzZqwJAucFmYYR63qG/MA56Ut7gEs5kdFkTckjPc
	 gCykZQoS/x1awqpm9W0vorfbk2RERWtlvlYunSqlcy052cr2kFxOb/i7lEDLQq4ISoA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689199;
	bh=SNAqZ+SkthJWyTmvef3h2M9C1EGo799IVBsQtXDPjLc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tTFWq2JsfnHtbIk8suZCbbMilFFQgDMQBUGXbb1uMLKrCHR+FjUHldKFssgT+KNcn
	 R+FH/7BoPeWBVRhuYThBQvVswiC3KAMjhdTCJXJ/+yRHbnEJNgepWgKrhg+z+PkPvE
	 1rZdcriK6YY0OP+0HfVyryVG/G4cVBQ2KQ6ZIXCOLjxdD1SxpqhCR2MzXjHNfjOb3k
	 5idwIszwoIUUuqgTmJaoc4WJUiqGXqURH08cUhHSW0+S2n4934gZ9NYdTieO7fMhNQ
	 qGwdcGjQ1ayN0i+4TR+Szpu0j8rI0mJ7JQJvLiDOSXJxr0EPLhVCH/Tn0JotMwE/Qh
	 Fp5Zsrun1BQrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A30C606D0;
	Tue,  3 Nov 2026 06:59:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6264C411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 445D1400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7zQor8Rr5lxg for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 06:59:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A1774009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689197;
 b=EqLrhVvVltgbO7vDh1EVCtIO8PIcMej1Sh1C5ejoDEP3TeoLbqB5nQMFUUjkL42bm/xQ
 LLqCCCT9pIkM4LYjpByEBnBBtrHZf98Wd0YxGjeVR40aUqvr4Wz0KHQa3FY/iYImIU4QX
 dFTZNdNE3Xr+r6kv05XYDfrMpfcLRggvdWclb4EU7zCSjIbRX2IN1erxtXK/CO66tMyG2
 C4rPHBS6XD38mprOdfEeL0ru8J3Z/gdJyGk1GUdh69CUslsZ9sYZaPBi8tCfNpkfXTcUO
 cPYZXe3UvlSj7TUt79y4NryDl6CUX4WLj3Kf3kiUr9LFBaIHWq91wN1ctqvb8Ywi6IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689197;
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
 bh=SNAqZ+SkthJWyTmvef3h2M9C1EGo799IVBsQtXDPjLc=;
 b=Wu+ujEAANhPmC44GWT9u1FwHk3Kp34a2P6NtPVvnW4JKlS8l4Pkw/P7UhQkd9f486oZe
 3cCUdQEuGMtw97UQkWXs8acYXRwasiW4Obop3WF8vBsjzpd7dVF3g6cz1SMEm7ZDKtwFD
 B3LqSOjqntExT7pxDjstdoPQQutDoUJhPpjNz3vLLbHoOuhTbS/lc5G4DHhVd82TaYE5g
 ju6W4+p33OpjXO+HyShm597YFtoJUIheChzETM9jcH6SE5HzR12+CFbb+1/CPMX24XSjc
 TBPSJ45fzqx6kc2JNOnVpDzAPxvv7A1+dfhJq8PMYeJnymC2qxH15h37s7Ch9TOsMZw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qnowQfxC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qnowQfxC
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A1774009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:59:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6KCc5UpVtjFbsVYXOm0+TeD+z77p27p6Ciu83jcpq0OAsUMBzEZgUMv/nCQ3UF4l4VzTs5aaxsWagvBpjSNGAwNBBqTOawBbBbp9vGdeq7rx26Y3wkn2zcUU6xCju5fnSJ9FzaUP+PAhifn1aFM8M2uhjieHGV0k7n5YiFNfSUnaW5YmJbcCWfqRQ3vbR1MQoLWNxYjFmK0A7dFNKunURmzXQuUi4g9J4jIMks7WtaItcqUCECdRPWU8XZku4LU7zRe8XD1MvsqmOgObedPbe5fS2slopHg7xgojWwkhmdpyas+EWlrVQRbJ2fGdbQ6tW5nnyPSJPLpfNwF73gizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNAqZ+SkthJWyTmvef3h2M9C1EGo799IVBsQtXDPjLc=;
 b=vN4FNbI7fJLN237WTQeSqYv69hh81cFlj+Lf+8WJtr2CH4417/mjrX6mSXxmg0BGp+t5807nRVb7DEMU87U+cmuifk9rOvjTxX88EvmJ4DNc+AhkRjLpfUu9NxjuLsfYIRRW0xQksHdceFNO3w12MZCp1mMWaehN1bKG5Ta0D3PgOe+6LDU39Y83iGyvJ2jsTr9rM4t43JNRM8wgeS8ei0YoLWe3uSYAK+rrDUiXmmLoWdGPMzQAWWqWCyHRFwc5IUgusHYK1SCIDIsMwIrsx4zxz3x9PcmBSN46oPNq1ZcnsgHr6T/KHGIqVyl9BAaNT2d5rr6BA2AEyJXXHuf45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNAqZ+SkthJWyTmvef3h2M9C1EGo799IVBsQtXDPjLc=;
 b=qnowQfxCxzKYi2PAFFuZwxeLjuGlmCHzWWTvkubkgc+j4hseWPwzNMYieNLkRD9nA4NZJLBslNREeX9fyFSqeB2AUZACltLO+ci/jYHVElNoB40rCCTszohHSNOMlfLIqbw0oSB0yka3Yiw8Os2jZIeOacCnnKuVrhkxwYh0SBE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:59:52 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:59:51 +0000
Message-ID: <a4b6b1cf-9cd3-4b46-8553-44bb3b6d972e@amd.com>
Date: Tue, 3 Nov 2026 07:59:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: versal: Skip relocation for mini OSPI
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
References: <21c97d8831b6b7dd13f7869a5da1588749f68047.1792504417.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <21c97d8831b6b7dd13f7869a5da1588749f68047.1792504417.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::6) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b20197b-f8ed-45b6-7efe-08df39780ec5
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261009223027099003|261028144727099003|261026140227099003|261021123027099003|56012099006|261021121427099003|261026121527099003|261022115727099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TsmH1HfjtvLZEEKiUY+BxKKgWgpuaCVW9MamXxDV5ofbTw6dpcoJD0AZ5PrRwHo4cAVbUE5XUjKY857rRA3Q1XOz/V3lUpn6uovWUgZw0KgSB5uOUQGtq/vxfciip8wLTzR/2OvFW0qNs2RHcGnFl2bDvDmO5z8GN/r/317en7lZ42JYg4R/8YygZVJGep93J8OYL9LDrxDIRd7Jlswe7JZmCEz36NohP/Co4kFHBxdwLEn6QB864O62xIOCh7a+GnCi5mJT5Oyg6Aik0f3/mrVJ04kDqEZahkjMSfLOkS2KqcKWrSlYgaAVkQSEgAHIg+/9AMjdVAWyX++hlPij5K1svqrhqpb8cBkLX/QYK2eejh7L52RAAM0oWu9T62HYGUTDlYIYgarW4hAhuXAmfE8Z68377r8Q00n7kEsj1/SOQYCfSiSMryj6gkitSvKYDA1njdwrPAaIwkV54ndcAZrpE7ovRwoaxZnERgEX2Z6KoqLZmQYvoretiw/xNoUOcnQLBinKmhTczL2ZJvQ9ofaOrQpvYv+F24Voi8Io5m3Bf2TNjjTrkmiB51Ko9LEMWlK/qihqeAbJuC7DDzAScN8VJetUtkjS7NdpBLyupv5YFMLc73TTdgMIo1AjuZDebAZDPiAmemA4fQ/yIbmtPxvfAURddHvWDcHX+3HbW44=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261009223027099003)(261028144727099003)(261026140227099003)(261021123027099003)(56012099006)(261021121427099003)(261026121527099003)(261022115727099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk5hKytyL3dpaHpDZElKWU1MN0pIR0xIUDhCQnhIOW5WWGtGc05Ocm5xd1pz?=
 =?utf-8?B?a0lremxMZ3RuZm1XcmQ0Uk9YSHFjejhHSHVidU03L3l0WllGOTNiRXVnTmxG?=
 =?utf-8?B?WTZZbGwzL1ZDT3hJMmlETE9LOGdrZ1p4SEVEZlI0Ri9ZUmN5eHFIOG9BcXM5?=
 =?utf-8?B?Q0l5YkVHWVluTXpzU3hBK0hmMXdHd1grVlJEVUk3Ri9EbTJWQzZTZFNqQUtE?=
 =?utf-8?B?YW5Ia1VQQVBoWERYQldYZEFacDNXcTVFQnIyTjE1ODJDUUNCQXVvQ0xzQVVQ?=
 =?utf-8?B?ZTBTaDY5K1VqcW9nc0V1eXArTmVXbDY1OTh3UXdZMWRJYnJ6d0hxWkpqYm1s?=
 =?utf-8?B?QkpVdCsxbVMvRVdoQ2x0VkFqQnVYaENscUtEZnVQUGtFVENONmNONTNSbkZw?=
 =?utf-8?B?V3dvU2RxZUNrYzd0UkVSWWU5bEhhTk81R1RuVzFTVm16amJBLzR2ZExkZFlw?=
 =?utf-8?B?SHZ5WXVIYnZ5VEFGbUlzVVl4Qk5iSHpjWU5yT0k1RmNpUnprWTkwM2xBdnVn?=
 =?utf-8?B?ZnBCTmRWZzZvVXBKRGFFNnY2eUNtanFVZEJVVnc3eFNvUnA2b2NlR0hYRGR2?=
 =?utf-8?B?Y0NSTmNUODYycVJxN2g3d2ZPamEzQU9jSC93RU9uV3ptaExGejliOHc0cG9s?=
 =?utf-8?B?MStYcjl4a1V5S2xqRTZSYzUvbFN5aGlNa2hIRWRKbFV1Mk5Mc2ZuaXlyZmZp?=
 =?utf-8?B?TWtuQjAvNUZnY3ZNRmJlTGd3NDRSMlhtVmx2MmtiNHdWNU8xUkltZVh3cnln?=
 =?utf-8?B?anhYbFlFRWZhZ1hWNTU3dXk1VmFkeU5tV3pLQlA0VEtkKzNYcnFsaFpBcGVQ?=
 =?utf-8?B?TmVHT0JTYUNsMmgvRUUyVkZzQWF0NWxvbHlGZjJGcDVsYlYzQ1ZYM2Q1RFJT?=
 =?utf-8?B?TlRYTktQRVJHaXljaHNlTE1Oc2swUnJqY0xwSlRuKzVLdzEzQ2tTc0JsMVNv?=
 =?utf-8?B?UE5pajFoM3lKUmhYemN1Z0NtVzFLT3Avd2ZkZDJIWUo1TysvYWxPQllNWmZI?=
 =?utf-8?B?bldSVWt6Q3A2SWFwRmRoT2ZpdjhsNXZNemoxUkIyTjIwRm9SSmFMdm1UUEc5?=
 =?utf-8?B?TDRmOEIwS09xdkx0bm9ZZjY4eE9XYXc2MCtLT245TVJEWCsyMDVmTmVBYTM3?=
 =?utf-8?B?blJkd1JrOUFnRGxZWWw3MlRTdDl2d1dVc2JmOHMwN1UvSXJLQ2hLakhjb2NJ?=
 =?utf-8?B?Ym5RS2JINWRTVEhqcVVIT2R3VlJjbWdKRDc3RmowRGFKOEh0SEtFZjBEbjMw?=
 =?utf-8?B?Skh0R0xtNkxuU2pyMnlTQjlsQzJYWU5RN3F1YlU1QWpiOGNnSVZaYnJqcEJy?=
 =?utf-8?B?WFhKMlZPdVJWR2ROd3MzRW9CWVp4L2FSRTN2R0k2Ti9jbnczUU9YUjFoYzQ2?=
 =?utf-8?B?RUdMbitpcG9HaXNKOXA2VDRWNVFEdzdrV3hicEU1bDJSL1NVTERwVFRkLzV0?=
 =?utf-8?B?cnVhRThtbnZiSEk4UUVDVk1wV2dVeTkyMVBUWGlYUlVPaFRlNnE4U1FXbG4z?=
 =?utf-8?B?Y2xpUTJrZVE0T3hVZTFTUDQxSXlPbXJGZGRtZmI0M3hlSW13UE9sSFRLQzN2?=
 =?utf-8?B?SHpOWW1hN2pYQjJmbDA4YUhBT3BhWnd4eDVZVFk0enpCOHozVVhqYkE3Vm5h?=
 =?utf-8?B?Ry9RUEZyU21tT2RwOWJNK2piUkRxdHdFMmY5bnpOUDZUV3V6ZFlZWk1taXdX?=
 =?utf-8?B?SW85cEYyalhPQjE0eHdFeUNPVi84STZpMVZBWnd3TWR0cENLMmRtak9iaDFO?=
 =?utf-8?B?N0dIbXUyUXpoa2lFNVJvM0FGUUJkWGtKbVZNTmlQVC9ORWlWMCs3c282TmJO?=
 =?utf-8?B?L0IwMFNueDh4Y3FaYlh6MDd2VE55aFdtZ1RsOXdtN3liWTIzSUlUL0h3RU5W?=
 =?utf-8?B?ZTB2cVpBMEN6OW4vK0hES213bXRyOXAxdkd0UWpTQytJYUcwV3FMOFB3TkZr?=
 =?utf-8?B?ak4yU3daS0M3bzVJS1Y3a2R2R3l0UTJmbnVXWlFEbHYrNEw0YnYxWjJtM1h2?=
 =?utf-8?B?R1BQN25DL0ZtdWg2MVlieCtFK1A4MzFSeHJtNTZNTnBOZ1VUcU5hZFVTTUsy?=
 =?utf-8?B?SHVwcW9wemFVMXlua3lmNXJkaGprQ3BOaEhvVzkvMS9UU2tDVVZRNmZLVnhS?=
 =?utf-8?B?MFM4OVVoZjIzZGszbnAzVzY3M1pZVXpYZWUzYTVSZkNDbUhUUzg1S285a3F6?=
 =?utf-8?B?MnV1dlBCRlFxeHI4MTQxMGEzSlBUcHduSFllN1Yzd2RiNkYrbXZZd0s2Rzc5?=
 =?utf-8?B?eDV1STZEeW9IWXNGVEQwN0dxMzQyTTdtVS94MEFMaUdZZHNtTjFDZ3JiL0VM?=
 =?utf-8?B?ZURvUUQyRFpzWmQ5UDF5Vm8ycm5sL3lFVHBsMUtISXBDckhKVWMwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b20197b-f8ed-45b6-7efe-08df39780ec5
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:59:51.8351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgjSGugwzVIBY7v30kiAm1ur5UR5TGntxhAaCA7gEjfdcl7J/lUcM4XTf40TTvLX
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



On 10/20/26 15:53, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> The mini OSPI image runs from OCM, so relocation only copies it from
> one end of OCM to the other and both copies must fit at once. Enable
> SKIP_RELOCATE and move TEXT_BASE from 0xFFFC0000 to 0xFFFE0000, so
> the image is linked into the top 128KB and runs where it is loaded.
> Set BOARD_SIZE_LIMIT to 131072(128KB) so the build fails if the image
> outgrows that window.
> 
> With SKIP_RELOCATE the image is not relocated, but U-Boot still places
> malloc, bd_info, gd, the device tree copy and the stack below the top
> of RAM, which is now where the image is. The top of RAM cannot be
> lowered from the board code because it is compiled out under
> CONFIG_XILINX_MINI. Set SYS_MEM_TOP_HIDE to 0x20000(128KB) so the top
> of RAM ends at TEXT_BASE and all of them land below the image.
> 
> Set CUSTOM_SYS_INIT_SP_ADDR to 0xFFFD8000, so the early stack and
> the early malloc arena placed below it are below the image too.
> SKIP_RELOCATE is behind EXPERT, so enable that.
> 
> Example memory map, the sizes depend on the build:
> 
>    Address      Region                             Size
>    -----------  --------------------------------  ------
>    0x100000000  top of OCM
>    0xFFFFD800   free, under BOARD_SIZE_LIMIT      0x2800
>    0xFFFFC330   DTB appended by OF_SEPARATE       0x14D0
>    0xFFFF95A0   .rela.dyn, not applied            0x2D90
>    0xFFFF8460   .bss                              0x1140
>    0xFFFF7A38   .data                              0xA28
>    0xFFFF2E40   .rodata                           0x4BF8
>    0xFFFE0000   .text, at TEXT_BASE              0x12E40
>    0xFFFDCB00   malloc                            0x3500
>    0xFFFDCA80   bd_info                             0x80
>    0xFFFDC940   gd                                 0x140
>    0xFFFDB460   device tree copy                  0x14E0
>    0xFFFC0000   stack, grows down from 0xFFFDB450 0x1B450
> 
> The early stack and the early malloc arena sit inside the stack area.
> Both are free once the driver model is rebound against the main
> malloc arena.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_versal_mini_ospi_defconfig | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
> index e116b0cc1bcb..7c0b14fac361 100644
> --- a/configs/xilinx_versal_mini_ospi_defconfig
> +++ b/configs/xilinx_versal_mini_ospi_defconfig
> @@ -2,12 +2,12 @@ CONFIG_ARM=y
>   CONFIG_SYS_CONFIG_NAME="xilinx_versal_mini"
>   CONFIG_COUNTER_FREQUENCY=100000000
>   CONFIG_ARCH_VERSAL=y
> -CONFIG_TEXT_BASE=0xFFFC0000
> +CONFIG_TEXT_BASE=0xFFFE0000
>   CONFIG_SYS_MALLOC_LEN=0x3000
>   CONFIG_SYS_MALLOC_F_LEN=0x500
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE2000
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFD8000
>   CONFIG_SF_DEFAULT_SPEED=30000000
>   CONFIG_ENV_SIZE=0x80
>   # CONFIG_DM_GPIO is not set
> @@ -17,9 +17,12 @@ CONFIG_XILINX_MINI=y
>   CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   CONFIG_VERSAL_NO_DDR=y
>   # CONFIG_PSCI_RESET is not set
> +CONFIG_SYS_MEM_TOP_HIDE=0x20000
>   CONFIG_LTO=y
> -# CONFIG_EXPERT is not set
> +CONFIG_SKIP_RELOCATE=y
>   CONFIG_REMAKE_ELF=y
> +CONFIG_HAS_BOARD_SIZE_LIMIT=y
> +CONFIG_BOARD_SIZE_LIMIT=131072
>   # CONFIG_AUTOBOOT is not set
>   CONFIG_SYS_CONSOLE_INFO_QUIET=y
>   # CONFIG_DISPLAY_CPUINFO is not set
> ---
> 

Applied.
M
