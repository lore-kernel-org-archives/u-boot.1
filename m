Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179B1606A329
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=E0HckjwY;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VyI/IugY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69C7F606A2;
	Tue,  3 Nov 2026 07:22:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PAhDywnbC95u; Tue,  3 Nov 2026 07:22:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9357606E9
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793690574;
	b=aHeooYN6Hbzy9W8GYUb1rEd+9dCwh2ROaoB0r4ivv9Dn93AsBC9rZWGFnfNIKMI/6zTS
	 RNy+tykrG3YLZ9djBJ0gF4BgapprgLRQA76a+mZ7+K39oMqOPgcAKMc3qxvqCmgw/r5qq
	 sCJHlHGQBv505+bXd7RArfsVoMuEfYJaWgtWo0GgNuJK5/230X+YVGJl17etX+rUl+ouC
	 bnGBCqvYP7soHa/SmWxRc2frcWMuIY/pqNCZvUJ4QzXcNZRd7SgMiN97O1ePUaHy/Sf3g
	 voQ8TdnF9Tus09padbY+enjFwJq9BuXdmZaSsFaRrl+KQNvfTBPOdDV0uZScw4Vt8dQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793690574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GNnG2auW6XTqEi73K0bHpLEa+yP7Ouvmkx6I5beexYE=;
	b=l07jn7OIZkv8pCATWwBrByeDMrCiBtvtr7FgXnvysYh+InWa9amCWmR3LnGmITJkBhDX
	 Bx9jk3FAaEnXkCvk8hmSyhXDLqCdG18dOBTJwFq9BIruxKm8tCReLd1r3b61rvLdGCzUs
	 CjoY8F1agGhRCCiLi/LBqafiplzZam5aOKL/FIHBc+OTZDyvk2mPGIOkPY0flVtNBQjbJ
	 VLdvvuNppFAQwzixR+h/UUzVArSfhH5nUqCZnpisF5dnSUzdyrmuO9b7LpXfd7EUAOvhh
	 KeXgaP7wS/Z3ADAgH7PaNuFykGzCVlyRPvk1Rd7iZHm4dFs3c86Il3MUS2CrNHa3qng==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793690574;
	bh=GNnG2auW6XTqEi73K0bHpLEa+yP7Ouvmkx6I5beexYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E0HckjwYM/4cLGmjoYcbKCJB/P75jSHcm4nftOrySNceBCodwkRyEdQsNh61hyOuM
	 nBSQnpbubFldqKy21o/nD/e5UPdn5l52pwCyDdbeKcB4/fxwIXuUSYQHVfdcocJgsC
	 nhB8mJSF0ChbKGeOa9jdc6DIpw7l4xiFh36DYeAfJ612e4JwtWYswq/munU8nCWouN
	 xglB3Fs2DORT7kMuEOJ2cqf1DYx+fRga9NdOts6LMr/ZRUkohOxMZtVNh/5p2deZTa
	 QGIZye5sa7NKZzCn3+JB2IZ47RWE5U9WDUvbernO53VuvLxFyt0KN+7V7SSVJ05ohE
	 W6DFVucn3cRKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9357606E9;
	Tue,  3 Nov 2026 07:22:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 204B6411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:22:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 100C04058A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:22:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tPLs0oIFNItN for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:22:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3566C40589
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793690573;
 b=s7leIEvMxWrmA19J4kTBjeUhLoD1ylLo2fG7MDTtOZLIf7G6saeMHogZpLPAIRpzQc4H
 EA16OEpHjiHGnSKW9BrXPkNnsLyhysFblw5RPfSopcODXMklJM37r/fOjOk3RkTjtqHl8
 ys9le0NRIFYqiOzcxeq3E+ntYeI2qpr9iePphkm0RU+Hnw+vZaDpFcvflZafEM41F3hSG
 pvqh2T7mgX0ir1WNMLsn83Dkyfr9b5nCosBF222pqZs2RiaugkUiAd6ggjgVrkmHVJPWS
 ovy8w4kBFoNGYULNsOns4ptrn0rz121KbvB6dzZABOxFr57zvkHvS40CaOC2s4yujRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793690573;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=GNnG2auW6XTqEi73K0bHpLEa+yP7Ouvmkx6I5beexYE=;
 b=P6FCyDgRphm2rZ5/RBPZyNS4gZI9mxEks4xF/tW2myYaSlp6ZunD0w4Pbk1xSDw9B/VL
 SRUcve5AVV+GTbPv8Iom9NiTmfzHXd1NaRDdzsgNetfuqH85jki5YjaEE5T4Ir2+gZa9R
 vWYC4Y+laZfJrLz7gSgZ5ppEEFAF/uFzfP6BdkqWlWvFhf7KCLTPwCmXpFQH9VkhRYQag
 szNIoAoFq8F2jNQQ2UfJrTFW1BxHqw+5lOWJMQPtllYxiQUmH7o1YW7DEaJkumTgbOMPv
 mAGw4JpwBprfH1lfLqjmrJqfMNWzjz7LHbHWMA/4TfEgqnhygVXx4zQYsh914+Tb69g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="VyI/IugY"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VyI/IugY
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3566C40589
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9ohAb6u6STYSN8Bk/JHxqSQkxuJiJSWWj3WdDpwpsA/k53xG/yrGWW6yvxeauuqqxkk/g9/eGJgkLBsGoXugfYdm0hwg6ykb5Jzt1YK4ZCCYddlMlA/ILLl3BsaHpXZoYY+8gNPctZkSZvsfdO8Gi7U9TFU9LDcHupSb6efKLTz6rDwXlpOwJkgqlRmcKDXDOPSLpebghcdA3AYFZ+hFeURwYiRu7hvlmZ1SOVDYymrMZwaT+KL/z5YGMpq16pqPA6NuBSrgGpJzhbkvbPvSk45OyWHuyW2ghdc0wRFxCW3we09NKwXLzIx6BIvYcSNiiuJDY1mMraiwoeCUDWI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNnG2auW6XTqEi73K0bHpLEa+yP7Ouvmkx6I5beexYE=;
 b=UUskNCe8kgCy+GLRIKthl6sFardYzNQGZAYJTeos93pCaPnkHzQ6oCV4P9Vutao442FxvFv2OHzBg+6tYZ7S5Sbby90TdwYFB39soomsOQ2XbzNka586CI6k3VH+mM4PQXlrcptqbHoEvVWTstrsy9CnpQG0wYq98SN4USCIC4rA4UytY66XnvukGpr9SO0s37D4+CrtjTs7qTO0fDfSfVYddcs0mMlIrJiScoKNMkg+c667hGqWiGMb/YH3e5VwSS0vEYTGEMW+9+Esv1EaZHoV/g7K+dWvQHgMi84CmrDVG+tyIkqdp6AxQeTVHzCyNJupBnQoYC7jXNndEc/g+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNnG2auW6XTqEi73K0bHpLEa+yP7Ouvmkx6I5beexYE=;
 b=VyI/IugY71dIw88w8U4AGTeZynbnxFd9jI1EwBX8p/h0/NNpVA8uTloEzGMt916lnfjFBw86D1sDrymS3AX2oYMYvW94ExE4C7GRwkAlZwzi2gYfy4Zbim5RzECpP7OKIn9PGwGLPpNxu2ngMlicG3jZg+Ts8F+kNseQSCRClq8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 07:22:49 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:22:49 +0000
Message-ID: <5d7a1905-464e-45bc-96fd-00f954d08693@amd.com>
Date: Tue, 3 Nov 2026 08:22:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: zynqmp: Remove 1 second delay in psu_uboot_init
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.u-boot-project.org
Cc: Akshay Belsare <akshay.belsare@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.1317d009-0e43-4329-a100-1e7fd66855c7@emailsignatures365.codetwo.com>
 <20261021144702.8027-1-mike.looijmans@topic.nl>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261021144702.8027-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0063.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 325091ef-fac6-4094-d43d-08df397b43ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|10067099003|56012099006|261009223027099003|261022105027099003|261028144727099003|261021123027099003|11063799006|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info: xlggOcHjvFJp9P6hKAu4Ts592iXjPtKLLAQQxJZ/j3Se+nom3RbpjDSeX9x6gMiFsLW5AjxHfHTv18jxvstDfdLUMHZK+s9IN915OAHUk2q9B3eaAZjiXT4Tc5YiARYXKv2WP4oOWVsYSBLIcd7Bns0t6KbK6RcgRfY92amOTMgD4o3yNwiecxHP9TGyayilVyLbajfCrwf8G8E7PaAyLkAupJ75cpTO0qGoSyGfDiZtW1T+bRQsfRAvpz7jqIlZ55ANuPLeedjzoRoGeYaR3JWfPn71n1AFWloRiYv9Kv9JJHMATwDGtcNeNnJ4pTZ5VveXpQP5ad+C+U+SCGqnUOUXow2u1ucxPUUlCPnaXOyq9ePbAEopjxIvdcR/HiHJwhRaZTveQXLPo1wUa4bwkucOCxtMdB8ufk0iL+UT/ylYAA/CXPwEYQZAd/N/PMiFDfzmkDkuVVCXU6tf/ZM2N1/WpnzWgnLd3UMlo+CEYaYRBPCh76mrOiLIl/sPGz2P79z5NV7O2puheY4bU+WARa11WIr4ez9/eyeej9vfq4ZTvoMEusMKXaojemiCrSFMXlm4RstsDsKvejusYRIEWkXAl6yLmB3f4Q9sumwDDxUrtwEsFvlAYHr17+zoJgA1l0asax9bi0PdnRhrkSXffL1dX8wtYzG3N0xbSY+8Adg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(261028144727099003)(261021123027099003)(11063799006)(4143699003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2Fqd1RscGFzRmQvRm1DUWZvOWRWMlVqU0I1OUpSZk9GSm9UN2hYbnM3TmdT?=
 =?utf-8?B?ZGEvbjVHWUZkcUVWT0Y4dHJ0U1haU1cyWmZGVGxhemswK2dLN2hmUVZvSW4x?=
 =?utf-8?B?ZUMrNUhnMHlhaW1YZGV0TWNtVy8yQ3BlSXhYYStlamJWTGhHRjYwRnJHT3la?=
 =?utf-8?B?bU9lRzZScFcwZmVHbkJyVGdTTVZnbHplTklhaEtnV29uZ28xeGdlNDdaVHdV?=
 =?utf-8?B?STlGWVVDN1JrQnVaWE1VTTh5TkcrSmF4Nm1wdlM0TGNKcytHRThxcThUMUVN?=
 =?utf-8?B?ZWhFUlVDR1NPa2xTaE9ic2FXblpEMmNCd0hDbXB6SVRicXMxYnIwWlJ0anFX?=
 =?utf-8?B?ZGRPZDlFTk9RSzJGV0tPbXZCbUQ2SHV6QjNrMFZiaTRkRVUwY0oxQ1VHY0ZT?=
 =?utf-8?B?Zlk2VyszdzZBeFR6NTJHb2hqNjRUeG1qQm11ZkJBZEdEQis3cHh1MVNRaGlw?=
 =?utf-8?B?eWlJRXBJZUExK3NacllKRWZMSlIwOXFkRmJsNU16aWQxZXBkWXVRZmZBc3ZB?=
 =?utf-8?B?VW9ZQkNndXp5KzM1UzZoZzF4WGE2eTYxRmM2bVBJaXorZ3BYUlk4Vk9iN1NI?=
 =?utf-8?B?eXQ4NGdRdXZGbDJFZVlGZnl6MEFlZkpMLzhEdjZZdUJuUkVjcFdQWUkvTk1X?=
 =?utf-8?B?YnpzTEtQUjVpOVZ6WnpySUFjazBFdnVhMitGNS9tL2xrb1V5NCtWbElJZFRG?=
 =?utf-8?B?Y0FhajVKL1lZK2VHUHU3Ly9zc0ttMVlBZzlKVllGTHJ6NDBXWEkvSXkwMnhv?=
 =?utf-8?B?amlld3RabUhSREFSM2VWVWVsRHV5K1RHTEZpZW0zMkQ0MnhtazZPajJHbDND?=
 =?utf-8?B?b0NDanhGclpaVzVFVGRqUlU0OVlQQTRCdGVENzZ4dGZubldUQWRJMmdoK2Fw?=
 =?utf-8?B?REl1THJOMWt5YzBVb2NCSDlscHl0bFBmTVJzTzBJL01va2drKzFURlo1aVl0?=
 =?utf-8?B?dFZOY0pGRjlQaDZ4UHVGOWR6L0U0bEc3ckx4UExwZTh6YTFlemc0ZjJLTzRJ?=
 =?utf-8?B?MTlicCtsUFJSWkpaZUhIYmxpMmVzY1BnZUZlY2VuMmtEd1h2L1MyaU5Gc0VR?=
 =?utf-8?B?N014YTJYUUtuWk96T1ZxMzA0amVJc3RJbjBMSTJQYlIrTWYreUZlUkhPcGNL?=
 =?utf-8?B?dlBWUHR1eE9xZGdTem40c1RMWjU3dDYyem9tQXVOWlpXWVVjZ0VDc3duQ0Vs?=
 =?utf-8?B?bUQzUm5XM0pNWTRKMGoweEJuSk53L2V3TStUNSttUlhHSVhwM2t4SHpYbkRu?=
 =?utf-8?B?U1dCMVZ1TWpscGs2R0pQTi95VVViWHV4S3daM1Q5d2M5c25BL0Y2R29lR25U?=
 =?utf-8?B?Yjk5UWVDbmUzWStvUnNxdVp2RjF3Zkdaenh1YmR3eFJWeWloVHhLblo1Y2Mv?=
 =?utf-8?B?VnFVc3JRVHBZMDhkZTdUN3owMzVaRUxydUZwMW1udUdGZFNQRHVTbDB2ZGw1?=
 =?utf-8?B?MHhodDNxS1Jna2daZytJbnh1UkZWQzdNMmJTR2FEZDhNcVJZRDd2ZWFwTUJh?=
 =?utf-8?B?cU1HTHpWZ2xYTDVxZkFQQlArYTVIb1JKQWJPOVY5bE10eVd6NGYwalJxN3NW?=
 =?utf-8?B?UFRkT3dpVXJyUUZVYUI1dUE3STFueUlNYWFLclQrVjl2VklrZmtpNnhwNzBl?=
 =?utf-8?B?ai8xMGJxM2dPYTUxVXVTNzNSTUlLbXhHS2U5dFpnUm5SVThJd0RCNVNQNDk5?=
 =?utf-8?B?a3NHREZEN2tYMXJvYnJlcE5GNXh2OVFWR2hhaUpxODFGT3E3N1VZM3N2ZmxX?=
 =?utf-8?B?MjVTcUJSUUxSVkJlVUJVSVo5OGpQWG9RVmZiaWpNNlN6SHhjdTkzSlkwTlhw?=
 =?utf-8?B?bHNTcEZrR3FDM3Vrc1cra0ZkMzMyUDc4a09OK3J0WHk2ejlqZXcxQUxHRURi?=
 =?utf-8?B?Uzd5ekZ3TGwxN1ZzcDVOdU5kRmQ4YW14U2xtbVNXUGxSZDd4S0lWS3VpcHZ0?=
 =?utf-8?B?OUtWZ29vNVlPZ0RmRXRoN2tlaXAvOFpjVTZUS0s2emhsVXl6TzZlZnFRQlZs?=
 =?utf-8?B?cHphU2hhRTlDMW9qM09jcmJmaVBaQkFjQlBObWRzdW5FY3RPb25adVZITyta?=
 =?utf-8?B?UkthcmtkRFp2N3VkL2FRMmRVNCtPdVBaMTRIWXpKOU9rT0hWdU1DOEw1Y1lX?=
 =?utf-8?B?YURkN2FMTU5vbVBZUEFZVkpxSDN5UWQ2Vk5XQkRFeUVId1pYZmFIeGR2YVF6?=
 =?utf-8?B?TW94SG1WRnJGTnZ3R2RRUGdjMjQ3eHlTckpjZmJ6WDZmVkVtTllLNGtzZytG?=
 =?utf-8?B?TmlwUmJ2VGE2REV6K3dCUGR5by9UK1NXcWNyVEhMMkdlUXJZSWhueTh5QUxH?=
 =?utf-8?B?cFZSd2tNSWhDdW9xN3VmSG9ra04xNUlWM1RxNmlqdW42SmFVbENZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325091ef-fac6-4094-d43d-08df397b43ce
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:22:49.3510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7ipD3DtNYskZKl4FePCr7SYS33uuRZm6HMQmnfjwDEVvUR6oj69tnrnVt68+YoE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
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



On 10/21/26 16:46, Mike Looijmans wrote:
> There's a 1 second udelay call in psu_uboot_init that supposedly waits
> for clock propagation. It was likely added somewhere in history as a
> workaround, but testing shows that it isn't needed at all.
> 
> The psu_init routines internally check and wait for a PLL lock already.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>   board/xilinx/zynqmp/zynqmp.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index c7464b493c5..0fe0c34df67 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -81,9 +81,6 @@ int __maybe_unused psu_uboot_init(void)
>   	writel(ZYNQMP_CCI_REG_CCI_MISC_CTRL_NIDEN,
>   	       ZYNQMP_CCI_REG_CCI_MISC_CTRL);
>   
> -	/* Delay is required for clocks to be propagated */
> -	udelay(1000000);
> -	
>   	return 0;
>   }
>   
> ---
> base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
> branch: zynqmp-init-no-delay
> 

Applied.
M
