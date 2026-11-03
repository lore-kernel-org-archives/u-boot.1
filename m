Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E2606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rQtTor2u;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uXbmKQxD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68C1460642;
	Tue,  3 Nov 2026 07:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q3S8tAn1HSQL; Tue,  3 Nov 2026 07:02:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95E3560705
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689359;
	b=FLTAWIv8Ua60NPZaaawxVVAFBqH5xHK0orCSUBXD2cTeSWQYFupK65t1nXE1jyui9PSL
	 epK8Q8NDU69jCMkdPDW1pynWbg0nkcqSJks3Z/0ZuIuXyUQoDa/XCCEoNvmI0jkEAEBU1
	 5brdmaMJlmHP5eTMho8AK8eDQW7ruPXgwCNWqWkN2EEoMSDSLCUG/jbjxfNj5FdoDkvz3
	 rXC2GtJqVw/TXNhHz5hKrIYxlVpsfVxiflzk2Bc+Gb9xh2TQ9vIgKQ1XK++h2lJxv4znl
	 qqoK09T60uv1ZCSMMKV4tNy1+ty4DwrXhMrkG9duLFi0lwPVpGRwQzYx8OZX6z61h0Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689359;
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
	bh=biBzhF9CVrWV0ED9OokIfc/E0vXKWo0J3UQgiQcgdI8=;
	b=cwOcs5sjSN7hrYQldZYiQ8r9aZ/kiE4vrt+I7dGNP1x+xbhyveh26uGt35h2UAKjGiG+
	 T2aQzCgP3w0Jgn7I4eFPrw+eEb+Yzaii9yMbngVogTJpTsZEUfdGYi7Frz1G8ZriBhC55
	 8Zj3vbRixtZnfP6MI6xMg4EwztefTkWJMYfmlNmU/3MEe4glCIUmxn/hZ75Ihl2lls2UG
	 iFcoc6loOdUSfhnKUG5XwWqq3tN35uMRpKnDpATpt0UUcoZnUNCipNq/GYk3Pm4lMpnFQ
	 wJRtCHGpcCR+Ylk39VlR4I+T/SW8sv2m56EVigMy9AKG8QbjV6DKy2A7cKh2x24EMWg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689359;
	bh=biBzhF9CVrWV0ED9OokIfc/E0vXKWo0J3UQgiQcgdI8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rQtTor2uAsofa5laen9/FHnKDushDVeoSLZZYSOfBjP99fBg0WxbMFcpkcudIu92w
	 Qii20wP1CB/yLb2ZzN62AqI9/anm/rQisNzFPNzZnK9m1rNQU985RE8UEf4H+P0zSC
	 4UrNQZYA6Wrgw/R4tzeGWC2qf1Gs9/JshIFSUhC6J3yB5+oalSwP/QOpo3tfOZGsy1
	 1e2ajWkpzyJX534pJCW3/U5G55UpkERXCLJFopa8DFo1KgRc+N2p8IaH1AnVH6L9bV
	 OLRCjZw9YI/ZbNAQ7T91Dab6Xo4J3i/prOS/Hc5+JQlHGM1J2V7+A7t65+OIeiBMWE
	 snPtC47ZUOjzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95E3560705;
	Tue,  3 Nov 2026 07:02:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 27623411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16F5C40589
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uYeo4NuSg5Bz for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41A1A4054A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689357;
 b=EJ1RqMmyt3N8kWk77gTrglvQhoDTZ/TLDFurHAX7wFrYkEfLJ53MQF4D9v/iGvj/bBoH
 gQV1b7zm2nD6VIaIF0XlGGxNaYmAXdbORpDqd+tNdwNzPf2hwk1XamuN2FVYWDiRqSnyG
 MQohyY1xc+D74JuvAuRfVhCtasXM8rnhxyXaPQOe0Ikn5Z5WHAhvRnex16XQcciONe2ba
 91SazdZ6G4q3APwxHeOVMPRqdOOmReSHSdOpZlTOqDRQxXljBlMtbfWDcx1qVKP42Wf4c
 3t41OW0sgPk3vXu0MSdLL5uOHkvm0uIHluyan5IdFb0mQGICoXtsOrFPW85+2wualEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689357;
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
 bh=biBzhF9CVrWV0ED9OokIfc/E0vXKWo0J3UQgiQcgdI8=;
 b=P0B7IZhgoJXzmaZMNTzFq/Q/d+UHcPjd9lzV8wXjKEXWO9C/WJ7rhReQymyNUFhVcCu7
 ZRyiI45rQ3VQz8vrBc1CcU4Fjyfb235oXhp8FWt8ImyI23w0JCFEcdMwhW96CfQf5WH1e
 94++1UZruGzuXUhmRDnNZNt+1yYyPUgnmtiTxfDCDGwfq96uIwEh6SAGYuCLfJuA5WISN
 6RYx34xEhfeDJ+Myj9wl1RGki4YYj/Oj06GkA7RN11cpvQ5u8/JmbAyomXovvZbViWrQY
 r4zHG81SZqkUUv751trBBZpMs/V8dx/1+V7pxJegAm0iNgK9k/Dkcnimt93u+OVMgmA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=uXbmKQxD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=uXbmKQxD
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41A1A4054A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLXS+fjYuus536taS6RTR8HEAZ4aPEw9K5kKv2ZCN/Xo0rc4oWy27Q2fEWmgFyY6X0TyVLPXsl4E5FoNpsVGD6ELKnZrVtsX08RvbjPaaDKTXG3A6hdVuOu1lwYe2jze9J0dvncDKd6pxtoMjeR/wtMIfeOItpTa2p8M1c/u9YeDVghXJ4L3YpxHnkN0QF7Aurdi5FJ8FULTm+nyEgWGVxvAGJUOiB7O8NfNQRsYKkKczB0A37IpQAXlFndZt7AdqulFgP+D/BbhDz/yq71GvOGH3UFS/BjeV5jslsfGYEMqERmu5Ukm9rCtlKY9wj1YbXYDgKiURV9VYQt9eGxqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biBzhF9CVrWV0ED9OokIfc/E0vXKWo0J3UQgiQcgdI8=;
 b=I1iUl6hKC4LunnMPAOE0aUjjGVh+puBokFC9mv0E17lHNJTve7IEIxpCItniNYkas91+7yWJgiIlKjsJY7cp63UOD8lrS38T8t3N6BBeLSTyG/ffua7smzgCWX60qbxvDo/aB79HBHxuIiWmJLdpe1mdcjHh2F3BMeaCS4//SIX1Vwg1IgUNTw1grUaNeWRBTdPdIcQKmlurbgupWpMuqQnZs010UFxiCT3mtk4O9/kRau4wKl/ypn+taIlqMDOlrlc/xGP/nQtbVXV73MtZgDmnpj+qGHbM/o/HUg9OULZVCTNTIVQH5v1628yBBXKm9W4E/7Y8WhPhN3nQGqgz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biBzhF9CVrWV0ED9OokIfc/E0vXKWo0J3UQgiQcgdI8=;
 b=uXbmKQxDUQUd2cbi/JtLjyXLF2UP9+BfcWyxn8cFYolMCvmvqiZx9d2wxXqTJTkd1lheRCQvfBa7ugUk4YRUk1JVy5ESCxtmutf1U8GWACUFca11RVgHVZGyvcfN+i4ODG1eZflh+qoZpID2CEhrYzecEwQUhKwFGr4uO9zuvWI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:02:32 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:02:32 +0000
Message-ID: <0be19912-2841-481e-b129-6e9f27781e02@amd.com>
Date: Tue, 3 Nov 2026 08:02:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Fix DTOVL warning about graphs in kv/kr260
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Shaikh Mohammed Suhan <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>
References: <3445b6285bcae67a16c284c524c0a57aba8c00ff.1792505988.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <3445b6285bcae67a16c284c524c0a57aba8c00ff.1792505988.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:a03:338::31) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d40f56c-1ef0-45fe-d245-08df39786e9e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261009223027099003|261028144727099003|261026140227099003|56012099006|261021121427099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lK32TxSa8TKIc5Mzm33CX6Gd5snhHAY4YbqFjzGlM3jllL0VNwhch3UkqTHarVWwHA99qmlZRLx4veo1YlJZKSaBTHNpFjg35vg1Db/HS8Oz503+kNqjyNfKu7htCHIqu1jg1iJEnLT0mqZEitjCQFr6NiFLx+HkGOBqr5DmCocEF6U4McPQw/vFsZgUrGeadFCfRcJxzwHRAG4lfsyYOkQTvadKbgvRHErlefsnJgvvgIfknpBW3aDMfDftTklPp7fDXVmzVm4+ElvSMwW5jcbIAFnfsnLczZD0hM2wmQ1PiznlIT1M53B5ZKN/97McBx2GYofVy60Y6cocQ1eZAri7nEWMaKL1tuWyO8Q6p26YSFfRmj9b6030oQTyNsv/dAA4M1NZAZIvAdd1+H1MK+xAU97stUnMEnYcwHbeD89FnTGczKPTGIZuBW/ii9QXmlxkis9DFrYZ6axVT9WBKItC0TAGjA4ZsWE1LbeJvM/orLcaVscd6LNFXTREBXbAzrhnx0soibUUqO3+G7OyuopIyBD/Iia3sJNlOsGlY4KoowPU7s3MKN6cBoBpz+KELOwjvdsovquKvEkk8Z4V/tC8cbBGM1GrNwjN0yy8CkPomigzCqqZSJgHpCe0a6DoK4N8SszIjbk2LUzmfdzQCY54s/aQfa1o0phSCOHFwdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261009223027099003)(261028144727099003)(261026140227099003)(56012099006)(261021121427099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJmMkU1dk1hYXNtdWFCMThNUG9yQVVoaktVejhZYTRQSmtzM1FyaUp5RlJv?=
 =?utf-8?B?ZkRIN05rT2RkYzlyMFdweVRpZ0MxcWtHRDNZWm96RTFtVldTWTFuNkxWZWJ6?=
 =?utf-8?B?TDZraW1wY1UwSG1pMFFjZVVPSmhMcmxSWmtYZFFoNUxOemZWc1QxdjhXRlpz?=
 =?utf-8?B?bEpRSzJEQUU0QlRmaU44b0lQNDZPbmF3c3BRYmJOb0NSM3diSjZBVnowVkNU?=
 =?utf-8?B?L0NONGxMYkZobnhxR0J0MmJrMnpmVWUwamIrR29YQWh0R0drMVdrRSt2U3ZR?=
 =?utf-8?B?YTUxb2d5S09hcFRUT1NKSDBnd0NqQ1A3bTdvdmZtZWhJdDhpR2tySjhkYXh6?=
 =?utf-8?B?NG9NSzRFWEJKcXJkQVBTSE1WMk9XNGs3UkhLUW4zUE04VjJ2amZDNExpMEFD?=
 =?utf-8?B?OWdDTm85RmhBbVQ2NG5hVlZjOVZ5VEtHbmRpV2xGNXBGT0syRTY3VFBQWVo5?=
 =?utf-8?B?L2tIZGE5WHdaNlFoTUZCSWJtMnN1T0VjSW5mOVVLNDNGbzcyWEtDY2d4cDg0?=
 =?utf-8?B?Wk1heHZlNy9adVRxOXFDWlpTSzRZMk1SaGQ5WGlmYzdSekoxQUs5T2hYZHVK?=
 =?utf-8?B?cis0alFjMVU1SWlrNFlCVlJtUTRBRjdyWFVNd0dxZXBoeUpNZ0tWQ2ZqRSsy?=
 =?utf-8?B?cjMzSkxOSWx1bUJLdnhQTE51cGpLRUF6alhvVDhJVllpVDhaUzU1WDZGZWxI?=
 =?utf-8?B?T2FtS3oxUW5KVlNZcDF0TzB6anI5aG9lVUliWjgrdlIzWWM4UWdkR2oxeFNm?=
 =?utf-8?B?SHdubUtuOWV4Tlo1MjgvcjF1ZVkwZVhXd3NOd1kxbDI5VjdLR0hKRDYwMllO?=
 =?utf-8?B?T2NXd0JJandQU1ZtVk9KKzI4ZThucUFTK011NHU1QXlzK0RuSEJ4MzV4YUFJ?=
 =?utf-8?B?YVV1RXl0TXM5MWRWaENzZE5vam1BQzJ0MGppRnZIRUVJNjd4SVdmaTJ0cUNO?=
 =?utf-8?B?UWMyUVlUVHBDdEN2LzQzdHE4QVU1dXQ0bmF0U2Y0VDJ6Q2ROWlZBSXpSUm45?=
 =?utf-8?B?UFllQVpvNVhMNUFLZmNiVm1TZ3NFcFQwTU50ekVsWE5TTFNDVGR3bU1XL2NS?=
 =?utf-8?B?aFQ4alpDYnFwNmgvMzczYjV4dTkxbnFReXBLM1pTcWNraFdmcUNVZGg1anBH?=
 =?utf-8?B?RUFYQmVqZHYvZmpCUVBDK25mbTRKakV5ejJzdERDWkxITFRGdTdVWjF2ZmtB?=
 =?utf-8?B?dS9SemIrTDZZcDBYeWtSRWRvM1kzWDE0N0JlRjhNVnNhTDR3cnZ5RU5UcnYx?=
 =?utf-8?B?VGhiN1pueGw1UC9uK3B3aDB2OEFQTUdMREdYZzBqTnpKNCs0elI0cjZaUkJy?=
 =?utf-8?B?dUJWL2ZvQklEc2FRZHJTOGJ0U1dpSXVqUEJneVFJNlZkelZ1b0J6dzhDbElB?=
 =?utf-8?B?ZURyS3FjZmttNDZWNVl2TWVOK21qd0RDSS9WeWNPeWJ4TDRKVlkwaUlOU2pJ?=
 =?utf-8?B?RjVWVURUWjJTQ0d6elZIazYvaUxTcmhOeVYvUUl1TXU3YXZka1BXUjEwcnFI?=
 =?utf-8?B?cGJFemVMSnR4YlBhQ25DZk42WTFaSE5HVzFjUXR4VnlvQ0J2aWVvemVobUlL?=
 =?utf-8?B?SkJveTRkcTMwaWp0K2hrK0FYYjYvN0VyNTE4aE9qQldLWHBZanZmRit6aWdo?=
 =?utf-8?B?ZmhtcDU4b08xSlVFVlhKUW1YczhEbW1rOHpTUjk0cEVQSTc3SzUyRnVSeU1t?=
 =?utf-8?B?Q01xZUNYR0R4Vk5aNDhiTWpYcFVVSU9NcDNtZGxsQThMamtEbmx6eDc0TmJ0?=
 =?utf-8?B?NHpOcnFtSThoK1dUTHZmQzQ0SFFTNlp4dVZVa3FtQmZwUlpTNVlVYUN1NUR6?=
 =?utf-8?B?UG95Vngwa2k4STBlaS9ncUkyR0M5ZmFubmlLaGFndEtlaXM4RHhoTko3MFc3?=
 =?utf-8?B?OG03SFFXWVpPWWl0M2RkenZnSlZReFR1cS9TUGtCbXI3ZzQvZ3VNU1lNUHJE?=
 =?utf-8?B?VDR5K1d5VTc4dWw3UGFhZU11Wm8zYm9qZUNlSFZXTzlqZkh5RCtNRjhXVjAv?=
 =?utf-8?B?MjBKSVk0Nkdqdk9DY2R5dU44aURWeHlCaFkyN1JudHkvbGNCcWdFdE0wbTdX?=
 =?utf-8?B?MmlSRGhlWDB4azZaVmdKK3daekRDT1g4a29nY0FuUEcybDRxZTFXK0RjRXhw?=
 =?utf-8?B?anZsQm5pUksybVEzK3FkVEJ1VDdjZVRUS05xdUp5L09ScXZUdndldUlGRXBk?=
 =?utf-8?B?dXZOOW9Jb2NRNW1VelJtVmFET3JUeVNpSHIrK3MyQVJSemlFMDJWeVk0NHQ1?=
 =?utf-8?B?YzZid2Nxb3ZzTEhUdVFBVEZPakpzR21Vb0tBVzlFSTluY2VNOGpwejJaVmZp?=
 =?utf-8?B?UUhTMU9hM1krRjQ4ZnFmQVJnK21FNFYrMW9xTDBVekFQYm5aY1FKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d40f56c-1ef0-45fe-d245-08df39786e9e
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:02:32.5758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV38B1UvW81WIU09rGxcsJs8sgPZplllFEKxI9mrU691d/NYB1y0bfy0sRtSWonK
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



On 10/20/26 16:19, Michal Simek wrote:
> DTC is generating warnings about missing port like:
> DTOVL   arch/arm/dts/zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtbo: Warning (graph_port):
>   /fragment@5/__overlay__: graph port node name should be 'port'
> ...
> 
> That's why change description and add it directly to dpsub mode to contain
> full description with also port.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 4 ++++
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 4 ++++
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 4 ++++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 4 ++++
>   4 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 3a47beb9f995..0d1be060d866 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -176,7 +176,11 @@
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
>   
>   	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
>   		out_dp: port@5 {
> +			reg = <5>;
>   			dpsub_dp_out: endpoint {
>   				remote-endpoint = <&dpcon_in>;
>   			};
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index ddcee42ffbfd..09e1c11692d8 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -176,7 +176,11 @@
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
>   
>   	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
>   		out_dp: port@5 {
> +			reg = <5>;
>   			dpsub_dp_out: endpoint {
>   				remote-endpoint = <&dpcon_in>;
>   			};
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index fc8d3467198d..7cce0906dfc3 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -152,7 +152,11 @@
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
>   
>   	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
>   		out_dp: port@5 {
> +			reg = <5>;
>   			dpsub_dp_out: endpoint {
>   				remote-endpoint = <&dpcon_in>;
>   			};
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index 80d1577c92bd..63328b3e224a 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -137,7 +137,11 @@
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
>   
>   	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
>   		out_dp: port@5 {
> +			reg = <5>;
>   			dpsub_dp_out: endpoint {
>   				remote-endpoint = <&dpcon_in>;
>   			};
> ---
> 

Applied.
M
