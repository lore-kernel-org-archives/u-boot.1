Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F7606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CD0LWNoj;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wyi11jW1
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDBC2607BA;
	Tue, 24 Nov 2026 06:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZR30w6tKyZI; Tue, 24 Nov 2026 06:55:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E567606C7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795503347;
	b=McNQgFsIK/LIp1eSZT0+Y7tIlk1JfTh4dnPEEXJhGgEFey1pWcjp4xeSzjPMI+bGB6rs
	 KzGuQReA7n0ocYKa9/QdoVfZx7HE5JUpTF9p4gYX3IkpeyI3OkTytN1gLCTKWFxATUE87
	 zXatO6reyuBQEo6AbQ8ZOj/jkco4zJuyXcgJ6/lJ+j+m/JtohBqvHYFtFFL6wWxS/H8fP
	 eH8SpmlJfhvRq5QsorrCJyMA4dMWKVou/Ju5ADAkM/JPcxL39FlxJKRvJ2sHzrBFWi30S
	 q0hTy1FE59k1sHNRMmt3SnbjmsVgd6WvuEsyW2CQPQ3t12ZpH/txzW9Is9MUDrPpvdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795503347;
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
	bh=ZlrVQ6igV8xHG2BN8ouHGhM5U/Nb/mRGTSY+V2q4KYo=;
	b=C0adcF1toswfgBKZoaEJhs+S5QIPEjF1+1TJ842a0RSsm0u22ucnREmjDEsSGIzzPujO
	 6tVDVQ2wNI/YltO2zfMu348YCIhcCRdJJT52t8iZkyImkWA7nhZ8G6suyU1C20bQ+Dbda
	 vvfl2B1VisXmbmTyWnMyBWyaIV6/SnI5LXmeLKZhZwCg5vIJlgWz+kax73UhtBEbmFDmx
	 brImJinEYiuHst1/2RqAWIURyuON9WBz565o5uOWcJijWsfIZ7Ih6Mq8E4X5kuSde34kw
	 F5D+FXm6vCihWfwyR8Spj0HTIDbNoxsaigWbajhmI2bTDL6+afDHONk3n7VLxbS/E9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795503347;
	bh=ZlrVQ6igV8xHG2BN8ouHGhM5U/Nb/mRGTSY+V2q4KYo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CD0LWNojvPrRyD+7rTovEr+OPUhRGN1mC7gxcPOXeHscCXeLuaT1xMrEFwyKHg4q0
	 mysSqrh8E7OVP+B1XaRxvcQImTbnU5RVu0dsBko/n3Ao1lhS72cFbAB5/SZaoZ8WZb
	 OGyDEWqUoYCEfBO1tphz3jRmP8gUTUa3fioKC//35V2i04xWzr5hKEpDDc+Y38e8q5
	 z1+VUKt6ArKAxkdZcLN61+AqKtrBZAKWAhZbvxZ31+3+dj9qkcP/uSOsWIBDdjDTWb
	 yZvxf1DOs12JwRBhSxyLFjeebDcYwoN30EfQK8u2ojKAxq3y4k5kRAXi+wJi7opY8F
	 1NWxP1UK0uVdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E567606C7;
	Tue, 24 Nov 2026 06:55:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BE195D43
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AF91C400E0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3tjkZZ8fEgdV for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 06:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5E93E40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Wyi11jW1
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E93E40068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlrVQ6igV8xHG2BN8ouHGhM5U/Nb/mRGTSY+V2q4KYo=;
 b=Wyi11jW1DXRrRiSdNZNHbBLF11Upic44ROKznpx4opPCI91CYuNCOE7UdoWSqzkTL4GisNODt/iXFvq4gZR5PDER6oc4bLAMQ3y7iQ0kX1UZmkFFdXf4g0p2OCs8olaXWtpc1cWCX4hF/GxwbRly6RPbZhz3C/PLtsyWlbtdbW0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB052986.namprd12.prod.outlook.com (2603:10b6:8:47e::11)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 06:53:34 +0000
Received: from DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48]) by DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:53:34 +0000
Message-ID: <2314e428-a9de-411e-a9fb-5edf6a2fce04@amd.com>
Date: Tue, 24 Nov 2026 07:53:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: Remove CMD_NFS support on AMD/Xilinx platforms
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com, pbrobinson@gmail.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <3a4de5cab4546449ad0b057c3d9f3ff913b61fc2.1794217226.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <3a4de5cab4546449ad0b057c3d9f3ff913b61fc2.1794217226.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To DS5PR12MB052986.namprd12.prod.outlook.com
 (2603:10b6:8:47e::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB052986:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 56404219-baaf-42d2-7f85-08df49f7a82f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|261021123027099003|261026121527099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 781Pco9DxKBitfUgm3BP6qy6m7xPSJd9ctuiYVOKNgPhtltrxdxSX5qqEEF18zz30T4Fe82Lc0mq1MCVtBSNJD5Me3zvX7Vy71EOyu+CAWNSdOpQgBQE25NIt7pqJAnmfb+UxFlRTQDTMOzwx7/TbEM1fDzwl40hdL50RIsL3uY6W0i+iEPJgaVXMF+lIpF/LKX3aYm8YfWqhYV6WZB2cZUfi5Q7lnLmKzMWO1jA7gbOGPtpZS4sOiDxBsBVR8oVJfKX51EnKTIbxBujszG3PuWVgtiDvMHsly9uqUbu1eLKh5KfIW4x5s4cFVXzJPP4+Ib/fgjbtAbEln6+Czkm0FVt+JVGdji0eAoBnWlcz/kEqaWgzxja09B52WBm7HIz/m5wM29zjbLlFMSOAx15iVrtDugJWDrAfWEuxfCSXXH42svYljgJHgG4DC8nTXXiMA1R4vMKX5rUv6GbiGOizKZ/OQC5BT2l80avVNl8Dp4aCfqHLznyIqyInObTsZc9r6PKZj2rZ9yG3tMaelVHs2l9wd2PmSXhoYg/6/RZduSYXiM/fQ0MUE9soCCd3UmDhe23AtandABqsOTeQMUIkuYRRUAdPebqgmiIPM0qfJhmmZqxRkVle4n0yb0GNQynwid8tY6bP9fVMIRtLZKLCR/cUQqAdKkHrb87/UynrWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB052986.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021123027099003)(261026121527099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGZUcCt6NnNzUWFjREkwalBEeGdDdHMzTHpFSmp6aVpBQmJZQTlpODVxKzVJ?=
 =?utf-8?B?eFpSNldyZndNajBaMFEwenZ4cExFZkpjMERLTjgvdXNxQU16b1FqS1FmWGph?=
 =?utf-8?B?eU5taWk1bTVJREJtZDNBb3NZejk2aU0vRGx2TVJ2bXlJdk1Gank0VEx3aTAx?=
 =?utf-8?B?QXFpa3M1TGIzRG9GU3AzTWs5SVQ4cGRzVlc3bUxxYnZBMXhCR1RYbXZKVzBs?=
 =?utf-8?B?c2M5WXg3K0JGUGxob2hxVUs0QnhKQmFpTDVzUXYwWGw2SlB2OHZwTzhkSWFN?=
 =?utf-8?B?WmJmSk1QdmI5dklORjNEeHI0MXBXbzIyRlZHRW9tMng2R3I4VitvN2p0eko2?=
 =?utf-8?B?UEZiRWZ4YThhc2Z2RDVJWUsyMkI0K2NNWkNnd1MvOHFhZFg4NURYbWgzNkhS?=
 =?utf-8?B?ekZFUXVNb3F4WlZ3YmF2ZTVKWXY4UDhvc0szU2h5YytlUXA0TVZnUXBrQlhK?=
 =?utf-8?B?VHFFNmhqR1dSdkRFU1pxdE9sUnMzVEttcjJGVlRhb3BSUzZuM0NMdnUvODNK?=
 =?utf-8?B?WGViWnhCZitHUlJzODU2MThJNmgzZjhHQ0JOdmYxWVVmdG1DZVZrakFMUFl6?=
 =?utf-8?B?SGRwVXc0eER1aDRrbmh3VncybGFWZHZMSzMwb2Zxa1J4NnlUQ0wzWHgwUlAv?=
 =?utf-8?B?U1Z2aE5IbHhDQjZPUVRlSjhDSTc2ZXVuWEVUMWJkbzNqY2t6NnVZMjBRM0Vu?=
 =?utf-8?B?Y0tRRXl4MnNLb0Roa2J5M081VEE4T3M5UEdyTHBjRVAxczc3MTJsdWlGVEJn?=
 =?utf-8?B?cWFmYkU0ZktodlYwTkpmZVU5UG5udUltL2JyelhFTys5TG5uazdyVE1WTHVm?=
 =?utf-8?B?ZzNhUmRsMlBkYklGV3NFQW1MVWJJY1JLOU1GdWdHc0E3OU1SRTNyZTREYXpL?=
 =?utf-8?B?dVA4NDdtdjZ2cUNuQStuVDlhU2RiYnJXYmtFK2FEcDlocURCRVdIanZRU25w?=
 =?utf-8?B?RGd1UENPNkp1SGlrcTA3cHlWd0hHdnQ2S2s0cm1xRmpvcFJZVHlXMXdiOFZN?=
 =?utf-8?B?VXZDd20zaXdiTmZ1OXNMcjllTGdEdkJYaVpwTTF2MUJDcU1ZNWpTUTFQY254?=
 =?utf-8?B?QWNBTXIvVzhjeU5qTzFEdjdMZUtYQW1qeGtrMHBWUi9mN3FuZ0t2Y013dzNa?=
 =?utf-8?B?SzV0TjA0Y0ZYUlFoMnNGTFVNZ1R0TW83aFFlcWZ4ZjFMM01oUUh5eWhiNitz?=
 =?utf-8?B?Uk9UTzBtdi84Q2J6WGZWd2o2aFdtbEh5bllreDQ1clArK3dPbzhxU0xBT0Fu?=
 =?utf-8?B?Q2JTL1lkMXdzQlZFMTJ2cEl3V3BadWltU04wSytHcklxTU53TGVPM1lNcElK?=
 =?utf-8?B?WC8rUFIvUmpjR0hRSElqb1RmbWpxaHZHWHEyaEFkSW9nZVN3VFpYMkJvRDhr?=
 =?utf-8?B?eWw3OTl1V3lOeGhDWVNHTWUraGplMkpycVVkN0ZYY0NWZHIybkVRaXk3WGlM?=
 =?utf-8?B?V05sNytuQ1JRUjB3VE5GN2VTUUkzWG1hVlFSVXRiNjNiVTNiZnpIcHhZV3Vi?=
 =?utf-8?B?bGlUUUxRVFdNQWVaOFpkM1ZiTGNIbEVFa05OMENkeDI2cG5jQmVJZ0JOYkhP?=
 =?utf-8?B?MzQ1T3ZpV1piN1l4cktOMFU3RUdHdks1R2lqc2lZV1AzdFIyMXZUdFpQUWNR?=
 =?utf-8?B?aU8wNE5CclA3UTNNb0JjQ2JHZDBYazNHcVhiWHYwd0lxWUZVSDNJZms1RFZM?=
 =?utf-8?B?dUszdDY1VExUMzc4Tm9lTnNhR21MU2Y2c21IRjdtVzlzSFVqd3l0bjJMaGNo?=
 =?utf-8?B?WHZWZHhsbjk0OFNheGpWUnJnOWl3M1pRdjV6N0hSeGVabFBsZlJJbmJSMTRz?=
 =?utf-8?B?REdLWnNtYnZoR3c1dEF3Ym1Jb0M5c0MwVFVST29HL1F3bXk1V3JFcUdHOG1D?=
 =?utf-8?B?NllOcm0ySy9Qc1QvRXJleS9UbGFWY0ZzNGt3dG83T0k4ZWd1M2RjSGVISmtt?=
 =?utf-8?B?Q0FyaGRFUXNaanJka0xNajEzN2NiVnoxL0xNVFR2NmdXeUIySFNDZ1FkTUhX?=
 =?utf-8?B?QlhadVQ5WmhtUUJqTzMzK21iMDIyci9vL3pYeE5FVlRGWUZqN2NlTVBiZm1j?=
 =?utf-8?B?MjJjTFROUWJVUG1mbDcvMjdiQWl2bXNHT3luUEwvSzJ0VnA4bXpqbExqZHQr?=
 =?utf-8?B?M0lQbUxkd1lpN0hwL05LNzhRbUFsS1RhamdyTFhTMFZnR3Z5c1BIRDRUbllt?=
 =?utf-8?B?dTFBUG44SnE4YTFzM2I1L0xQTlNhTUQySFQ0czg5aEhMNWhFTTRYRnVPRnBM?=
 =?utf-8?B?cnFMcTlnN2t5TVEwbFRrNkhlR1VOc280ek9FK3B3eDlGWVltUGJINE5veHZ4?=
 =?utf-8?B?dFo1MVlPT0ZHQ0k4S1lNeGdqRHBUa1JqWEgyQS9GUDljNmlpb2NIZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56404219-baaf-42d2-7f85-08df49f7a82f
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB052986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:53:33.8497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ4M+P+ZWaHsi95AvBkBfj+pQDRfC4Zge26cMWPnZd15g+tdSCLekTXNa3tYQGZA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
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



On 11/9/26 10:40, Michal Simek wrote:
> Do not enable ancient NFS support by default.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Remove NFS instead of enabling it everywhere.
> 
>   configs/amd_versal2_virt_defconfig       | 1 -
>   configs/xilinx_versal_net_virt_defconfig | 1 -
>   configs/xilinx_versal_virt_defconfig     | 1 -
>   configs/xilinx_zynqmp_virt_defconfig     | 1 -
>   4 files changed, 4 deletions(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index b138d58adea8..cd3814ca1a32 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -58,7 +58,6 @@ CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_UFS=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_NFS=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index c9e62a85543d..cb73237f5807 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -46,7 +46,6 @@ CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_NFS=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index 647e0455f854..3c3fbb77cc6f 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -55,7 +55,6 @@ CONFIG_CMD_MTD=y
>   CONFIG_CMD_PCI=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_NFS=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index ed5d7cd55174..751f73ffcd2b 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -83,7 +83,6 @@ CONFIG_CMD_SDRAM=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_NFS=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_BMP=y
> ---
> base-commit: 934995f642a21ca7f35fa9aed5f061394fcba243
> 

Applied.
M
