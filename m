Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A5606A89A
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hHFNEwr6;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VNm5VMjN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2A4440A79;
	Wed, 11 Nov 2026 10:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gh-7qpXDtyy6; Wed, 11 Nov 2026 10:28:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D9CF040A30
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392894;
	b=LvJOH7mPSGmD2MsDU7ClPWbbc6YTS40Q0STbsaYyVmkk0VoVo46RXJN5TY8u+yxySIHG
	 35ZZ8wEW8O4oMb4jpaqBwKj/L9RA/y+nSmUspufgd9jfbaw1IArxV83X1GBUbfaX8rgPw
	 +JsEFZ62NEeOiZeR9OIxMFrhRJqV789imoCJsQ+v9vAs82lNGo6//Y3do6NJ1xTDLmAv8
	 mPuBT8SuhG6ivrKvZZ0XLHoA0ZHkhc1HprOVam3UeztcJna+XvU8K6m0kS1GOJeZ2va6L
	 LJBSFY7YwRCepaskZt3oX+NO1NiQUO+g1fBp8lw8VvVgL2ZHCQtdVr0nPR0yiorFSyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392894;
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
	bh=Dnh8Fb3mPAzCEF3wlM4sav589C0uxuU+TYYyGhQf6wg=;
	b=rDeJlICAW19EuL9fkP987XHfcGcHdQS2+P+8QhHy7/t6f+rpyR6JymUoNy1PMO9fXbzE
	 lC3As4aGx7CINWONTLBQe7AHUmyzeD9UP1M9EDIOkS7oo4Hwo1XqgjqoMCSMx0vknuEmu
	 BquPSFfkH6Iv4k1fEZ2HodsWwTPwoLtetntOWzxmscB4ua70LjPvANyt/PKIHqpPX/KbF
	 oB6Nxe16yFq7eMw+XbP6vjpw2I048BuuuRMEIzY8lifeAwPRaTRVO464H5z10OeKx43qT
	 tDj9qgagBcvPRGFWcKf9bo8bTm0bgWooL8uO8VdC/02dNS8EUBV1EyI8/CnioMfGdGQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392894;
	bh=Dnh8Fb3mPAzCEF3wlM4sav589C0uxuU+TYYyGhQf6wg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hHFNEwr6U7pJTLvLrtOcdbV0VHzR1wUxO+Aluz/X1xBryE1PYNccCXERd9UjlQ6k5
	 kme6/E3hsDQR2OwNW3jqkuD59eRFTr//Lxu3+TFcexgyhP5cwLBG0A3tqrYe4G7kO6
	 3I7ELEQ3bHBy0nmxnfw/ndRimJCanU9bi+K3Nz9hkukhtb3d8yllaJ/E9f+X8yZGIp
	 Cx9o09kHTvn/ZuBOlccRsVgQmq5T7+NtDX4oP/9Z2oXXKnc5F95+CBgYx0OV7KzkDJ
	 9i0K8ST+DfjXGtBjT6Ey6R6ejc2YQgMRlJyS1HFxb6TAbT4dF3amJ4/RiVq7Jir5i+
	 ROas3OwycEarA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9CF040A30;
	Wed, 11 Nov 2026 10:28:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 50CE3731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A34640217
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:28:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 752HFlFX7pii for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:28:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E880A40070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VNm5VMjN
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E880A40070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dnh8Fb3mPAzCEF3wlM4sav589C0uxuU+TYYyGhQf6wg=;
 b=VNm5VMjNRi3em6zzdx+6NJ2Gpq9b1+ixYUfNZmV1DTRhAdz1uKR1jZhCN2oVtYBgkCGkKwpNWDR6mo0ArWwPJKKyEQvWtQPxvqgkcAaqo7kG67hi7xzPUO28WclZP3PZ/x4m89OnP1qL7fahmSNCfqplp25e8bjmqPcMDjEnFa4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 10:28:05 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:28:04 +0000
Message-ID: <e2cb16ac-fb98-49cc-a092-8f3026409c43@amd.com>
Date: Wed, 11 Nov 2026 11:28:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: zynq: Add missing handoff script to XSA flow
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
References: <20261111062128.215998-1-briansune@gmail.com>
 <7d5f0c9f-6f04-4773-a0f6-1cab069a2f77@amd.com>
 <CAN7C2SC+Xzh-MsgoS5zYq2piDajpLh8BzGTkBdzCQ396oLgEPg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAN7C2SC+Xzh-MsgoS5zYq2piDajpLh8BzGTkBdzCQ396oLgEPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: b9de8056-aefd-4c7b-434c-08df3fde7874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|261009223027099003|10067099003|261028144727099003|261102130727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fIS45pCR5Yn5pLRUR8Vd3qiKrTc5sy0WuDTCCWcq1UojiW7iYjRFYBrT0qkwDEaKKiRuKfPybu1j4GwTLATt7e6Vv87HlIqFvkDQOIzrZFIs2gb0wbwt4u+N8FTMv0LjsgRopsER1ayGwb7OcI4SHeUtzo3mW65XNNb2spGqiwkmL1Y1IjogmMO7lWhXxAm0VbRhIIFRSl/rLLPmboGx/zNEID8jQEABcdneyGd+Rt/8fMSHHNHvLxNMkThj+jlGRZbsEMy52G4VPWQcnaCmdAdtElv47lMG2E5DTbDGQTWqBncw2u8e8bxn3m9ftLzJ8wV4+nMPNCZAgXqaaghAqvUGZx7S1FzqbIwSnlTsyo+4zGcBRAkdI89owoqtSPuKBQL/wRTW6t3Ca7K4BniWhTvpWA/Trs45TFSwnFztSeIs8aRS+MFBIZf3i5s6LvijSWInbkBEJQHC6s9stqmS9wsACKAXlr2ouHho8dky+9IES/9/1DRl2rF/iclnR8wEgaa3uA+qdE4oDu2Rgl9HaAiC8aB8YHmz6EZITwyUI9DR/ClhxPA4H3f09etcwi7sP1d4Hef7Ur4XalKyFIrlFV9W9mar7Xxy1TBLk2i+KIRUuUWXdvNcTXFHXCz2DXiZgD0PURqcQT7k/AqzkTJO7zFEf1cktMBk7Ay3jIfDJtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(261009223027099003)(10067099003)(261028144727099003)(261102130727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjMrSEhmcmU1M2tBWExyV0ppN0dqVGtsb1BzdHJtbUNabklqQng5WVlxL1ph?=
 =?utf-8?B?WHFxeVJJTkF5eEc5V210M2p1WHY3eFNWdGtQbXFqdkNNMzVvcVppZ0dpek5P?=
 =?utf-8?B?dXN6d3hYZDAzUlJDV0xiaE9YSWFHWWY2ZngvS3F2UWNtTzBSajBUTFJkV1dx?=
 =?utf-8?B?ejlSS0R0SFY0NnpITy85YmthdFdHK0d2SVZGb2hmSnQrMjVyQWZTT1drN0VL?=
 =?utf-8?B?a2JhWXRVa2tZbnJsQ2hQdngwNDlONk92Z2dKRnNpd0o0bmVtcEpkV0RrNkZJ?=
 =?utf-8?B?bENxNlNNeGNBeWhsTHBkdUZKeWxLR25xZFB5QlZmSkZLSXJXbzFjaHEwcXg5?=
 =?utf-8?B?RGs1SHI3TXBoN1BuRFRyem1yTzhsWmw4UGdBUDZ4U05DSUlRNnVKUmRyWW8y?=
 =?utf-8?B?dVJrcW1FdHpWcHlnekx4UUpncHFTT1gyT21HMmxaZVU2RGFTaE8waFpNQ1p5?=
 =?utf-8?B?bzNrT0x5c1k2a1k5c1dzditCZFozODVNRDZQSFVUeDNSSzlyRkJmSkZ3OXpu?=
 =?utf-8?B?b1BGRUhxTTk5Ukp2d3NZZDVDd0tUOVlUWUJvOWhraUdSVU5ib2cyalI4MGtP?=
 =?utf-8?B?SHpyNnR6aTdGcUlpTlVjbHBPVFZNMGlVcmVDK2VOdGN6MlhjYWpVOUFYTGEr?=
 =?utf-8?B?ckxTUDBlQTdsQXNyYnBRMXlTaFlteEIydEllSHlVUTBiUDY3dGpsZTdIRFdm?=
 =?utf-8?B?bS83bEZwNS9KZ1NrbWtTV3JlakJQbUFlYWJPQTBtck5qendHbUUwSlV6aCtC?=
 =?utf-8?B?a3k3Y2RSbFU5QUxjZE9yZm9YWUZiUDBYVUZzdGlBY3dJdGtTbmx6VGtDZUh2?=
 =?utf-8?B?Ym9hMGxRZ3p1Q1pvZ2ZsWVNiYklFeFBWUjRFQzROajN4dzBGY0hvZE54M3lk?=
 =?utf-8?B?eGJHaGk5Vy9HTUF5SEJxWE9Gc3Jxa3pYbGFOL2JLaUFpSE9haHI1TWo5d3BP?=
 =?utf-8?B?aE9kOGlyVmNQYjZiVWFyczdVNE9ST3d6Q25KMU13eWRObko0dUMxWjUzNHBW?=
 =?utf-8?B?a29qb0d6a2treVJaWGdQdzBLTGZodjBIcDNWSk5XcE1sbTVwRlhVNm5YTklO?=
 =?utf-8?B?ajI5M0JOOHRUMktNZ0F5Z25DMzlVZkxicUlxbkEvVGVNczNsTlFORE4vYkRE?=
 =?utf-8?B?K1I4MnNGOGlUMmlTcCtRM3ZCeVkzZUE3SXE2bDFYdGxITlowTE92YzBkMWpn?=
 =?utf-8?B?TlRsMkY0MEVsZmgxMWtJNnRuSGtJRUVIOW1wcm16Zkk4ZjIrS1lKZVVHUDRB?=
 =?utf-8?B?VnNtOXZNOFBZVUl6OEJVOGJIOExBelU0MUpidXdoVEdJOVBTVHRvSHN1cXpu?=
 =?utf-8?B?TnZrWTJ4bmthZXlGZlBqQ1BtT3cyVGVVYW5pZ1VRN1k3aFJ6clFCWnJmek5I?=
 =?utf-8?B?RzUzbWU0dkczSkdvU01ZVlZCaTgrdEIrZGczR1dtR1hMSG9qZ25wVG1SQm4x?=
 =?utf-8?B?VjFsVGdnYUdSYmlLaTFSbGhHZjFTcTdhcnZNcUFFKzdlaGQwOGkrL1REY2xN?=
 =?utf-8?B?c1psbC9MVDF2eWkwcFNOZ1NtTExDNCtzSmo1Y3RFTlZ3bGRUVzcyUGx5YzlK?=
 =?utf-8?B?TzdJTjRCSUFVN1ExMTlKY3U0aFVpR3Rsa09STEJaOUhNQzZkU3ZTcmRzaVps?=
 =?utf-8?B?VUVoTzZSMStmdkJsbWRvU1lZcjdVYlBSQWpTeEtmaW44SGk2bldEL0NKMXhP?=
 =?utf-8?B?cWs1UEdSYUEvMmx4Ly9lamJTeS9kWXNrekx0eHRRam1IZnNKVnBFSi9iNlhX?=
 =?utf-8?B?cThDWXhhRkZxZEN4SndmUHdIY1AvRjNBLzZRdldHWW0rUW5KWXZJNmtJWDB2?=
 =?utf-8?B?YU1OaStFYTB3ditxclUwMmpVWURxTlUvdzBxQVZmWGhmZ3ZyUCs2WlNGeXFU?=
 =?utf-8?B?V1BrTTMrN1hkcFgzaWNGQ2tEZ0g4SGMwSXh6UkhuNzUyY1hBZDNPV0UwdFV0?=
 =?utf-8?B?Q3JxZmlISXgwOXN0L2gvclV4aGVMSmQwVVBHWVppU1gwRFd3WCtxd25SRkEx?=
 =?utf-8?B?V2dXbUVrVUdOS09kdWtuUWFhSlMyb0dPZE9tWEcrMTZuUFhMMVkvREpEVmNn?=
 =?utf-8?B?UnJJdWFXSENaMFVURFRFSDlyTG5zUG5OTnpmUlpnYlJlNEhUNWo2WC9zVDRl?=
 =?utf-8?B?b2hiNzVhUSs2MkoyS2hKa3VsSmNRdzB5ZXA4ckNiS1dUUTlkZC9BN0J1aU1G?=
 =?utf-8?B?UTZNU0FmYVBialJDT3h3ek1ka3A3dEZMek5FVTZQY0JCR1gyZDJUMnVPU0ZQ?=
 =?utf-8?B?ZW93dVhNbTNEdUNSL05ub3IxODRwdktmekpGT0swaVR6U1UzQmNrRUd5N3ZP?=
 =?utf-8?B?eTVzL3FMNDVEWUNONjB5YmU1TTBXTGZwK2JDVXJrQXJrallFajBxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9de8056-aefd-4c7b-434c-08df3fde7874
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:28:04.6975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kF1swU6YisA5CqupGdQbkJl+jGJzxIie4Nf8wFYr1KCdqmAzFdsi0QGbIXDCqcs5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 09:37, Sune Brian wrote:
> On Wed, Nov 11, 2026 at 4:13 PM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 11/11/26 07:21, Brian Sune wrote:
>>> This patch adds XSA handoff for ZYNQ core modifications.
>>
>> Add XSA ...
>>
>>>
>>> User now can place XSA file next to the board folder where auto
>>> generated from Vivado build flow.
>>
>> What would be intended workflow?
> 
> The intended flow is any XSA changes from Vivado build:
> i.e. changed MIO unused or EMIO rerouting etc you have to update the board
> file ps7_init_gpl.c to ensure boot follows.

It means you want to just move xsa to your board which will unpack it 
automatically.

My suggestion is to pretty much do this

./tools/zynq_<whatever with xsa> <path to xsa> <path to your board>


When I placed xsa to board folder your code just run that operations all the 
time. I don't think this is the best workflow.


>>
>>>
>>> Signed-off-by: Brian Sune <briansune@gmail.com>
>>> ---
>>>    arch/arm/mach-zynq/config.mk | 97 ++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 97 insertions(+)zy
>>>    create mode 100644 arch/arm/mach-zynq/config.mk
>>>
>>> diff --git a/arch/arm/mach-zynq/config.mk b/arch/arm/mach-zynq/config.mk
>>> new file mode 100644
>>> index 00000000000..2680db85d25
>>> --- /dev/null
>>> +++ b/arch/arm/mach-zynq/config.mk
>>> @@ -0,0 +1,97 @@
>>> +# SPDX-License-Identifier: GPL-2.0+
>>> +#
>>> +# Brian Sune <briansune@gmail.com>
>>> +#
>>> +# HANDOFF_PATH
>>> +# ------------
>>> +# Unset - Board path where ###.xsa locates and "ps7_init_gpl.c" should be placed.
>>> +# Set   - Custom path points to "###.xsa" file.
>>> +#
>>> +# HANDOFF_KEEP
>>> +# ------------
>>> +# Unset      - Clean ps7_init_gpl files.
>>> +# Set        - HANDOFF_KEEP= , Clean ps7_init_gpl files.
>>> +#      HANDOFF_KEEP=0, Clean ps7_init_gpl files.
>>> +#      HANDOFF_KEEP=1, Backup header files and rename to "ps7_init_gpl.c.handoff_backup.<timestamp>".
>>> +#
>>> +# Version Log
>>> +# -----------
>>> +# Date - 2026/11
>>> +# 1.0.0 - Initial Release XSA handoff for custom boards and existing boards
>>> +
>>> +ifeq ($(CONFIG_ARCH_ZYNQ),y)
>>> +archprepare: zynq_handoff_prepare
>>> +endif
>>> +
>>> +define COMMENT_C_FUNC
>>> +     FILE_PATH="$(2)"; \
>>> +     TEXT_MATCH=$$(printf '%s' "$(1)" | sed 's/(/\\(/g'); \
>>> +     C_FUNC_HEAD=$$(awk "/$$TEXT_MATCH/ {{print NR; exit}}" "$$FILE_PATH"); \
>>> +     if [ -n "$$C_FUNC_HEAD" ]; then \
>>> +             C_FUNC_HEAD=$$((C_FUNC_HEAD - 1)); \
>>> +             C_FUNC_TAIL=$$(awk -v start="$$C_FUNC_HEAD" '/^\}/ {if (NR > start) {print NR; exit}}' "$$FILE_PATH"); \
>>> +     fi; \
>>> +     if [ -n "$$C_FUNC_HEAD" ] && [ -n "$$C_FUNC_TAIL" ]; then \
>>> +             sed -i "$$C_FUNC_HEAD,$$C_FUNC_TAIL s/^/\/\//" "$$FILE_PATH"; \
>>> +             echo "[INFO] Commented out lines $$C_FUNC_HEAD and $$C_FUNC_TAIL."; \
>>> +     fi
>>> +endef
>>> +
>>> +zynq_handoff_prepare:
>>> +     @set -- $$(awk -F'"' ' \
>>> +             /^CONFIG_SYS_VENDOR=/ {v=$$2} \
>>> +             /^CONFIG_DEFAULT_DEVICE_TREE=/ {b=$$2} \
>>> +             END {print v, b}' .config); \
>>> +             VENDOR=$$1; \
>>> +             BOARD=$$2; \
>>> +             if [ -z "$$VENDOR" ] || [ -z "$$BOARD" ]; then \
>>> +                     exit 0; \
>>> +             fi; \
>>> +             BOARD_DIR=$(srctree)/board/$$VENDOR/zynq/$$BOARD; \
>>> +             if [ "$$HANDOFF_PATH" ]; then \
>>> +                     echo "[INFO] Using manually specified handoff folder: $$HANDOFF_PATH"; \
>>> +             else \
>>> +                     HANDOFF_PATH=$$BOARD_DIR; \
>>> +                     if [ ! -d "$$HANDOFF_PATH" ]; then \
>>> +                             exit 0; \
>>> +                     fi; \
>>> +                     echo "[INFO] Try auto-detected handoff XSA: $$HANDOFF_PATH"; \
>>> +             fi; \
>>> +             TEMP_DIR=$$(mktemp -dp "$$BOARD_DIR/"); \
>>
>> When you do out of tree compilation you very likely don't want any script to
>> change your code under your hands.
> 
> This script will on execute when XSA is not given next to the board
> folder nor custom flag setup.
> So it will simply exit and silently cont'd.
> While the intention for this is run > make prepare phase.
> 
>>
>> I don't have issue with this idea to automate this but I see this more like a
>> tool not something what you want to run in every build. Please look below.
>>
>>
>>> +             trap 'rm -rf "$$TEMP_DIR"' EXIT; \
>>> +             XSA_FILE=$$(ls $(srctree)/"$$HANDOFF_PATH"/*.xsa 2>/dev/null | head -n 1); \
>>> +             if [ -z "$$XSA_FILE" ]; then \
>>> +                     exit 0; \
>>> +             fi; \
>>> +             echo "[INFO] XSA: $${XSA_FILE##*/}"; \
>>> +             unzip -q -o "$$XSA_FILE" ps7_init_gpl.c -d "$$TEMP_DIR/"; \
>>> +             if [ ! -f "$$TEMP_DIR/ps7_init_gpl.c" ]; then \
>>> +                     echo "[WARM] XSA unzip unsuccessful."; \
>>> +                     exit 0; \
>>> +             fi; \
>>> +                             if [ "$${HANDOFF_KEEP:-0}" != "0" ]; then \
>>> +                     echo "[INFO] Preserving old GPL files..."; \
>>> +                     TIMESTAMP=$$(date +%Y%m%d_%H%M%S); \
>>> +                     for f in "$$BOARD_DIR"/*.c; do \
>>> +                             [ -e "$$f" ] || continue; \
>>> +                             echo "[INFO] $$f -> $${f%.c}.c.handoff_backup.$$TIMESTAMP"; \
>>> +                             mv "$$f" "$${f%.c}.c.handoff_backup.$$TIMESTAMP"; \
>>> +                     done; \
>>> +             else \
>>> +                     echo "[INFO] Clean old GPL files..."; \
>>> +                     if ls "$$BOARD_DIR"/*.c >/dev/null 2>&1; then \
>>> +                             rm "$$BOARD_DIR"/*.c; \
>>> +                             echo "[INFO] Removed old GPL file..."; \
>>> +                     fi; \
>>> +             fi; \
>>> +             sed -i 's|#include "ps7_init_gpl.h"|#include <asm/arch/ps7_init_gpl.h>|g' "$$TEMP_DIR/ps7_init_gpl.c"; \
>>> +             echo "[INFO] Masking GPL unused functions..."; \
>>> +             FUNC_NAME="ps7_config(unsigned"; \
>>> +             $(call COMMENT_C_FUNC,$$FUNC_NAME,$$TEMP_DIR/ps7_init_gpl.c); \
>>> +             sed -i 's/^ps7_debug(/ps7_debug(void/g' "$$TEMP_DIR/ps7_init_gpl.c"; \
>>> +             sed -i 's/^ps7_post_config(/ps7_post_config(void/g' "$$TEMP_DIR/ps7_init_gpl.c"; \
>>> +             sed -i 's/^ps7_init(/ps7_init(void/g' "$$TEMP_DIR/ps7_init_gpl.c"; \
>>> +             sed -i "/For delay calculation using global timer/,\$$d" "$$TEMP_DIR/ps7_init_gpl.c"; \
>>> +             sed -i "/int\nps7_config/,\$$d" "$$TEMP_DIR/ps7_init_gpl.c"; \
>>
>> This sounds very similar to
>> tools/zynqmp_psu_init_minimize.sh
> 
> I am not aware that Xilinx has this as I moved from socfpga and did
> similar things.

Welcome on board.

> 
>>
>> obviously you target Zynq and not ZynqMP but one part is extract it form xsa and
>> second about cleaning. And there are much more things to clean.
>>
>> You should divide it to two parts.
>> 1. just unpacking xsa and installing it to certain configured board
> 
> There are actually not installations at all as 2024 Vivado generated
> XSA that cannot directly
> extract and place w/o build fails.

Sorry not following. By installing I meant simply unzip and copy that ps7_init* 
files to board folder.

> 
>> 2. ps7 cleanup
> 
> The cleanup does have a flag for users to select keep or not.

Which flag are you talking about?

> 
> TBH: I am also amazed by why Xilinx did not include XSA handoff flow
> between upstream u-boot.

Because SPL is not Xilinx official/supported boot flow. Only FSBL is.

> I do understand that most of the users use the Petalinux build flow on
> top of Yocto.
> But this setup completely wastes a lot of computation power and complex things.
> I run this script and boot my board w/o any issue when simply passing
> Vivado exported XSA.

But they use only fsbl which is feature rich bootloader.

> 
> Any feedback is Welcome =]
> 
> FYI
> I also noticed the board flag of the ZYNQ is kind of funny.
> I had to use device-tree labels in this current script to make things
> work normally.
More details please.

Thanks,
Michal



