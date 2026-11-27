Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000FD606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lLR86vUU;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=smlbvWE7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42CCB4085C;
	Fri, 27 Nov 2026 08:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wcz5oAbZeJfi; Fri, 27 Nov 2026 08:29:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C2EB4047C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795768159;
	b=CYMCyAS61IfkCzk2Cl7niQN3HtyS0WlOjT1gCDeviPsojxyhfdONmfLC8fiolprusa+1
	 fyLT/5S3VjbU2/3IZHZ5h850x7sr7mkCCK3frSs3lmhlzwKTHCpXnNuTGE/S/cqv+1mW/
	 XWNJEvhpBheScN6n0I42Y8RZhG3khfAF6afAgbfn780mGsOrnRpuHQX2fl+v35hZu9715
	 rF8HP7UfcaK1JRL0YhjF4zAuOGvK/W9Eemh/UwtAJJCZBE0o+ANuFS5kDUy2d/mz0BmMg
	 7hwvyurefs0CvlU7hhDfZC7LthZD/OHrp+cEw0q7NC1KhdPp2ZUXZl5SPt8U5/d/krw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795768159;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	bh=++Oqcu5QwjM8QYHMFopsY991Vl4wraQ87VLKQAfdeRs=;
	b=Avw15dZqrf8163LFK9zuVxofHhiUVKQIQKnhr5dHsoMGV35FsYMtNtBy29PIYgThouxO
	 wBiga0fJxcjRlz4EtOy4zKNAvPSxlrFcxNFMyOBv4STnK1BEGgAg3Vye9wafhbgQInQlr
	 ZWfSnRU0PdkGqo8toWJiHRMVs8sN3HHehMmbn0M55nHjSaqKprnA+s5O9oF91mxQ1Wk+9
	 po1OEPA/vbq0vaojjguB2KFx9PepRGIG9zhnYnTE/mA5C1iYOXdlwzpOpVhxJciJj4TCa
	 CX4WecUrE7taowVQltR46oONRsrQBxs6kdrajXsPbF3QxKyy20OE+fm4zNjXfdRJTDw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795768159;
	bh=++Oqcu5QwjM8QYHMFopsY991Vl4wraQ87VLKQAfdeRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lLR86vUU2MCdQ7JzhEQcQ1CI2u8/OVLYveHyBvic6alEW+gL3fhGQ1SF0jMUIfSvQ
	 GP06lYYlM8KmkmzqJFJLVAqm3LXS6fEi+WBwVQ03BvUcXjY767cewp7THirmhBc+9m
	 +KaoyywN2ldbpQaIXvCviuF1vOlyZ/5BiuS4WtYY7k9W6hPYhfufvu7plWG+htGIjD
	 fJadatRondTapOEvvXMWt8cFPu5J/A0+6kfSm5869e4bLIEiH6B7kQBI5VGb2OcPb5
	 egAdFchxxG4A2lSfThmjArCiwilad9kaGzwObSJiCpPYsDx0IVkeCHcoiDrmTwO0Ex
	 Gh9p+jUvRXf0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C2EB4047C;
	Fri, 27 Nov 2026 08:29:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F8E1325
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 45AEC4008B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PK27Onwqcuv8 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 08:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DCB8C4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=smlbvWE7
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCB8C4004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 08:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++Oqcu5QwjM8QYHMFopsY991Vl4wraQ87VLKQAfdeRs=;
 b=smlbvWE7SHH0khMlPKfqaHNQh4O9dUP8l72YJFrYg21LSvoPw9ACDi8TFUSMV3hB5i3B6eM/IQKbbVvDCZxCfi1U7MIXAxfD5Km++Rx5q7oF52uLrxz4/RcrVW6C3seoVjpo7jbiT3BAt8ajuYBjr6qiXJZ+jC9ewl6yLHSRihs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB052986.namprd12.prod.outlook.com (2603:10b6:8:47e::11)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:29:09 +0000
Received: from DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48]) by DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48%3]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 08:29:09 +0000
Message-ID: <fa05c581-afcd-4abc-a430-1198aed3b9b6@amd.com>
Date: Fri, 27 Nov 2026 09:29:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] mtd: Add MTD virtual concat support via device tree
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com
References: <20261104100005.4104985-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261104100005.4104985-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0060.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::15) To DS5PR12MB052986.namprd12.prod.outlook.com
 (2603:10b6:8:47e::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB052986:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: 471c80fb-bc6b-492b-3cfa-08df4c608208
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|6133799003|261009221227099003|261009223027099003|18002099003|22082099003|261022105027099003|10067099003|56012099006|261102123227099003|11063799006|261026121527099003|261021123027099003|261026140227099003|261022075727099003|261022115727099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: UI3MPKzPqA0fpo8g3EzqIXBBMOZQknratK/0rIeXvuP+sEvB1tH91RAdTJ6Ra7VlFe3KqJ6BGXfr/Okoukjx1YsmeWKUHcVHOhH+1QE4Gwn3QIlTkmf+AkojDpISagbGEKus2yvhVByDqTQHFPaUTP1vB4jwEXYDR36cK8GGZZz3d2dIDYmU1IXSY7vEL7or4ubVap1BNU+OwBRYSVOS09Q8/zpifTW8kmj4g1J3hH3ePk75xo0sDc5/3/lkSlFvORuIW3UR5nmjhoP1ITC6jDdzkGNJmrSYFFMPKqN4bXLEBdpwkjS8jwmP3NahR6cmHE83guanOCr/fxxRMJVjgktFfh/XJwvy331xmEsUnW5kxURngMmnmUIjiJ1s/4VzAy/qZ5GXuc60BO4d7dIlYR5u6LEHgTCiWRqb23ZQ6OKUkaYarc5iLeOKnMBNZ2ts6TUK1N9IhNZvj/suGSU9Q2tt1PTKA6F9wGHFST0rD/tIHAua+niqSjldxlcqQiXqQ8/J7MVhPOV8wyAjsOkMVuMjLApGJg9FAX9+hQUoHzg9Gv623kUgEL+NW/10r31tenohw6PqcAttLQOKHu23Gn53nn7qDk9LH1lKOZqTAmvuX+xi89Hb1hK0fq65voi/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB052986.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(261022105027099003)(10067099003)(56012099006)(261102123227099003)(11063799006)(261026121527099003)(261021123027099003)(261026140227099003)(261022075727099003)(261022115727099003)(261028144727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUI5dTh6QXdXb3VSQUhzM3IyZUNDNnNqZDAxYWx1WG9LTXRESEJvTTNPd3Za?=
 =?utf-8?B?T3dpSk5FbDhiNUh1YkZHM1JORTlKMFFtVmUra0dvajRTbFF2SmlXQWREaW93?=
 =?utf-8?B?RXYyelJrNWhRQ2RudFZxbWRDallSNktIM0xFU2U4Q3FTcTNHZGEwRkU2N0R5?=
 =?utf-8?B?dEhiaUl2NDFuRC9URnJuZU5zamJacGhuZWY4L0lQVTV6L1FtUmRzeEE5Rjhm?=
 =?utf-8?B?bWdMeWNoZ3dTZDd2R2h5dVJUaWdVRXk4NWMweG5oRUFSRTRPeEtWbzlOcGE3?=
 =?utf-8?B?NHB4bE51LzU2NngrQ2NBbEJGaTU0dEtHeWhLaEpRY25FaEErL1pMUWVwY0Zi?=
 =?utf-8?B?ZHN4S1A4Z2paMTRsbUU5RmgrU29ESllNcGNpbzJXZVIrYmVhUDZkSmsvTkNp?=
 =?utf-8?B?RVM3MnJ5QlFGSXBWQUZwZEtocWJ2clNibDBwMHVoYUZtWm5YYnB4dmlRTEd3?=
 =?utf-8?B?K1p1NFh6MU1xdzFVcm02ZFhFRFQ2d1ZyS292dmUrRHJBR2FuQ1prUjY3YlBN?=
 =?utf-8?B?NnJ2b2pBU2J0SithWTFrQ0E2SUplSVZOOGllZUNrakp3eHY1SWxmaGpJU3Zj?=
 =?utf-8?B?RnVCL2txOEJKdVRLNmptdC81Z1UvKzRVUUZpU3FCQlRtSXBwRWVabzBWVytN?=
 =?utf-8?B?QzBxTGxGZlpTMGRndTJNdmwrYjdYRFBFRGljVmwzMXRFdUdWUmd5R1pZRk42?=
 =?utf-8?B?WWp6K3RVcHU5RVRMUVpkdzMrY0FyczZyWEtZMVcyM1pyWVUxcjJqZFIydCsz?=
 =?utf-8?B?THJWZlVuM3UyQUt0UVZxMjEyV0JNZzJ6ZjRsNVBLMGl3MnZSaWVPVVZUWlAv?=
 =?utf-8?B?SFdGTXBDRFlld3RYYXhNdXd4a1VuZ3piUmFXZlFFRkcvL28rR0ozb1llbXM4?=
 =?utf-8?B?ZGhSbVpIbCtXdE9ZZjVnNXFNWXFlOEtCSXZUbkhuN0ZHN1FreHE4RUplMXdn?=
 =?utf-8?B?N3lLNXdsSVFLdXk0dExHRGl0K20rV2NVMzlHUDJnVEcxaldoVTdWY21BUHcw?=
 =?utf-8?B?d3pVQ1ZUMHFzZ1R6MHNkZy9sdTZoMGxXR1B5TW1WWmVPRk55YytNODFjMGF0?=
 =?utf-8?B?eEpWanZuY3BzNUZRRUlmTUdreEFaTHNBSFg5MEYveFNXK21OS1ZMak15ZHVS?=
 =?utf-8?B?Sis2YWJCeHptOFJ1RVV1b1pET3VmQVI0QmUrMEJmdWVjdDBTcjIxQ05hRVJo?=
 =?utf-8?B?RHdOWGxpR01RdXJheHlaL3ZzdGhBTkV0K3ZOWnpQYnNEUDNBN3lzUE0rM2NY?=
 =?utf-8?B?elhWaUJjS0VyWTJIdjAxZURpN0gvaEc4bEJORlNSU2lHNGhDMGptRE41MTFl?=
 =?utf-8?B?Y0E5SHNYTW10YUJLUE4vVDdsTEVhNTZOTVNjazdyeGkzMVZhTlFYS2paSnR3?=
 =?utf-8?B?ZnYzcWN3dkhZSjRNdnhBNDZGRktRVzFZN1YwZTY0ODF5dDQ4TzlvcTN2Mk5X?=
 =?utf-8?B?dEN2OFhROTVmUlEvWlNvdkV5Ui9qTGZBeDRwTXhCeElhQXltNVBsTm5WazMr?=
 =?utf-8?B?U2tCb2hndXlad3pMRWpIdjdickc1TGtpNXZtZXZWZ0JTalNqTXpwdEtZaHBm?=
 =?utf-8?B?NXlhbWhsMXN0Yk96UzNSMmo0bTh2UmFieFJBVGdiN0Vwd3BxTVFGQmwrRUNu?=
 =?utf-8?B?ZlJZUDNCdUIvRG1NczV0TnhXSDMwNjBkcklnSTR4WnFqN2VocFZqYSs3aW82?=
 =?utf-8?B?b0FOVWJKRDlxWE9jSTFiLzZRVWNOd2MrOWpUaFNrQ3JMYlg5Qm9YYTVlUkhm?=
 =?utf-8?B?anhDaGRwT3ZzK3pPNTlHUUZrZ0kwemJ1VU5FS29rQmZGLyt1ekJqMkNtMml4?=
 =?utf-8?B?MytWRzB3VCtxdkU3V3R4Yi9Vb0JVeUhwVXRBZ2todk9wam5qT3Fwajg4WTI2?=
 =?utf-8?B?Q2FUNUhqaXBxUHRMSDhKUldFRjNzUUNHOWVNNm5XNFh2dUpkOXgyRVEzSVhN?=
 =?utf-8?B?R2RGWE1SVFFjTjlTMDNSWnJHSWxBL1VNbUVsZjRxd2RLaG1pWTZvcGdLZzhB?=
 =?utf-8?B?REFDRDJiUjVuS1NzK2U0WnVGTVBSaGZSaFFyMzFvVC9IM2h4L2M0c1dqTXFt?=
 =?utf-8?B?NnRKWTZEcHNGNlRwOTUrSEJ4ZW05ZUVjWERlUXBZS1dYcEgxbU5ycS9WOWVu?=
 =?utf-8?B?ZU5NSnpicklRSS9vY2VHcmNJRFhkZXliZzBNZ0ZTUTl4L2lINk9lS1RnZUkv?=
 =?utf-8?B?MTJVMEp6SnhEckJFMDVrazVoWFVUSjBZNWpSTVZlbHhGODNTQk85TW9Ga0pl?=
 =?utf-8?B?Yi9KcU9nUVR3QVRXdW9pV29SQUltYnN0WUdtSHpGWURsMGNKczR5YmxTL1JH?=
 =?utf-8?B?aXg2NlRDS3crUzRlRDBZOTZXTTNtUGNRTTJXMFo1aSsvOXFiaHBBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471c80fb-bc6b-492b-3cfa-08df4c608208
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB052986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:29:09.2919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Td5bSbZE7JEuX0T8JwU5drAlEJ8UsGEJLCcVz28VVmZsUH0TBoBSWvAWSfaR/DK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/26 10:59, Padmarao Begari wrote:
> Some boards have two or more flash devices on separate chip selects
> (for example QSPI/OSPI flashes) and need a single filesystem or image
> to span them. This series adds MTD virtual concatenation, where
> partitions on different flash devices are linked in the device tree
> with the "part-concat-next" property and exposed as one concatenated
> MTD device:
> 
> 
> 	flash@0 {
> 		partitions {
> 			compatible = "fixed-partitions";
> 			part0: partition@0 {
> 				label = "flash0-part";
> 				part-concat-next = <&part1>;
> 				reg = <0x0 0x800000>;
> 			};
> 		};
> 	};
> 
> 	flash@1 {
> 		partitions {
> 			compatible = "fixed-partitions";
> 			part1: partition@0 {
> 				label = "flash1-part";
> 				reg = <0x0 0x800000>;
> 			};
> 		};
> 	};
> 
> With CONFIG_MTD_VIRT_CONCAT enabled, only the concatenated device
> ("flash0-part-flash1-part-concat") is registered. The member
> partitions are not registered individually. Multiple concat groups,
> each with two or more partitions, are supported.
> 
> This is based on the Linux driver added by
> commit 43db6366fc2d ("mtd: Add driver for concatenating devices"):
> https://git.kernel.org/torvalds/c/43db6366fc2d
> 
> If a group is incomplete, or cannot be joined, a warning is printed
> and its partitions are registered individually.
> 
> A concatenated device is kept when the partitions are scanned again. It
> is destroyed when a flash it uses is removed, e.g. by 'sf probe', or
> when mtdparts defines the partitions of that flash instead of the
> device tree. It is not destroyed while it is in use: mtdparts is not
> applied to its flash then, and removing the flash only prints a warning,
> so it should not be in use when its flash is removed.
> 
> On ZynqMP, accessing the flash on CS1 needs the GQSPI chip select fix,
> which is now sent separately:
> "spi: zynqmp_gqspi: Use the device's chip select"
> https://patchwork.ozlabs.org/project/uboot/patch/20261104092111.3906459-1-padmarao.begari@amd.com/
> 
> Patch 7 enables the option for ZynqMP, Versal, Versal NET and Versal
> Gen 2.
> 
> On ZynqMP, the board has two mt25qu512a QSPI flashes on CS0 and CS1.
> Partition "rootfs_a" (flash@0, 0x1000000-0x4000000) is concatenated
> with "rootfs_c" (flash@1, 0x1000000-0x4000000) into a single 96 MiB
> device, while the remaining partitions on each flash are registered as
> usual:
> 
>    ZynqMP> mtd list
>    SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB, total 64 MiB
>    SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB, total 64 MiB
>    (0): "rootfs_a"
>    (1): "rootfs_c"
>    List of MTD devices:
>    * nor0
>      - device: flash@0
>      - parent: spi@ff0f0000
>      - driver: jedec_spi_nor
>      - path: /axi/spi@ff0f0000/flash@0
>      - type: NOR flash
>      - block size: 0x10000 bytes
>      - min I/O: 0x1 bytes
>      - 0x000000000000-0x000004000000 : "nor0"
>          - 0x000000000000-0x000001000000 : "qspi-fsbl-uboot"
>    * nor1
>      - device: flash@1
>      - parent: spi@ff0f0000
>      - driver: jedec_spi_nor
>      - path: /axi/spi@ff0f0000/flash@1
>      - type: NOR flash
>      - block size: 0x10000 bytes
>      - min I/O: 0x1 bytes
>      - 0x000000000000-0x000004000000 : "nor1"
>          - 0x000000000000-0x000001000000 : "rootfs_b"
>    * rootfs_a-rootfs_c-concat
>      - type: NOR flash
>      - block size: 0x10000 bytes
>      - min I/O: 0x1 bytes
>      - 0x000000000000-0x000006000000 : "rootfs_a-rootfs_c-concat"
> 
> Erase/write/read-back across the CS0/CS1 boundary at 0x3000000:
> 
>    ZynqMP> mtd erase rootfs_a-rootfs_c-concat 0x02F00000 0x00200000
>    Erasing 0x02f00000 ... 0x030fffff (32 eraseblock(s))
>    ZynqMP> mtd write rootfs_a-rootfs_c-concat 0x200000 0x02F00000 0x1E3200
>    Writing 1978880 byte(s) at offset 0x02f00000
>    ZynqMP> mw.b 0x5000000 0x00 0x1E3200
>    ZynqMP> mtd read rootfs_a-rootfs_c-concat 0x5000000 0x02F00000 0x1E3200
>    Reading 1978880 byte(s) at offset 0x02f00000
>    ZynqMP> cmp.b 0x200000 0x5000000 0x1E3200
>    Total of 1978880 byte(s) were the same
> 
> On Versal NET, the board has two mx66uw2g345gx0 OSPI flashes on CS0
> and CS1 of the Cadence OSPI controller. Partition "ospi-flash1"
> (flash@0, 0x200000-0x8000000) is concatenated with "ospi-flash2"
> (flash@1, 0x0-0x200000) into a single 128 MiB device. This test also
> used "mtd: spi-nor: Remove SPI_NOR_OCTAL_DTR_READ flag for
> mx66uw2g345gx0 flash part", which the flashes on this board need and
> which is not part of this series:
> 
>    Versal NET> mtd list
>    SF: Detected mx66uw2g345gx0 with page size 256 Bytes, erase size 64 KiB, total 256 MiB
>    SF: Detected mx66uw2g345gx0 with page size 256 Bytes, erase size 64 KiB, total 256 MiB
>    SF: Detected mx25u3235f with page size 256 Bytes, erase size 4 KiB, total 4 MiB
>    (0): "ospi-flash1"
>    (1): "ospi-flash2"
>    List of MTD devices:
>    * nor0
>      - device: flash@1
>      - parent: spi@f1010000
>      - driver: jedec_spi_nor
>      - path: /axi/spi@f1010000/flash@1
>      - type: NOR flash
>      - block size: 0x10000 bytes
>      - min I/O: 0x1 bytes
>      - 0x000000000000-0x000010000000 : "nor0"
>          - 0x000000200000-0x000008000000 : "ospi-flash3"
>    * nor1
>      - device: flash@0
>      - parent: spi@f1010000
>      - driver: jedec_spi_nor
>      - path: /axi/spi@f1010000/flash@0
>      - type: NOR flash
>      - block size: 0x10000 bytes
>      - min I/O: 0x1 bytes
>      - 0x000000000000-0x000010000000 : "nor1"
>          - 0x000000000000-0x000000200000 : "ospi-flash0"
>    * nor2
>      - device: flash@2
>      - parent: spi@f1970000
>      - driver: jedec_spi_nor
>      - path: /axi/spi@f1970000/flash@2
>      - type: NOR flash
>      - block size: 0x1000 bytes
>      - min I/O: 0x1 bytes
>      - 0x000000000000-0x000000400000 : "nor2"
>          - 0x000000000000-0x000000080000 : "spi0-flash0"
>    * ospi-flash1-ospi-flash2-concat
>      - type: NOR flash
>      - block size: 0x10000 bytes
>      - min I/O: 0x1 bytes
>      - 0x000000000000-0x000008000000 : "ospi-flash1-ospi-flash2-concat"
> 
> Erase/write/read-back across the CS0/CS1 boundary at 0x7e00000, then
> reading each flash directly to check that each half landed on the
> right one:
> 
>    Versal NET> mw.b 2000000 cd 200000
>    Versal NET> mtd erase ospi-flash1-ospi-flash2-concat 7d00000 200000
>    Erasing 0x07d00000 ... 0x07efffff (32 eraseblock(s))
>    Versal NET> mtd write ospi-flash1-ospi-flash2-concat 2000000 7d00000 200000
>    Writing 2097152 byte(s) at offset 0x07d00000
>    Versal NET> mtd read  ospi-flash1-ospi-flash2-concat 3000000 7d00000 200000
>    Reading 2097152 byte(s) at offset 0x07d00000
>    Versal NET> cmp.b 2000000 3000000 200000
>    Total of 2097152 byte(s) were the same
>    Versal NET> sf probe 0:0
>    SF: Detected mx66uw2g345gx0 with page size 256 Bytes, erase size 64 KiB, total 256 MiB
>    Versal NET> sf read 4000000 7f00000 100000
>    device 0 offset 0x7f00000, size 0x100000
>    SF: 1048576 bytes @ 0x7f00000 Read: OK
>    Versal NET> cmp.b 2000000 4000000 100000
>    Total of 1048576 byte(s) were the same
>    Versal NET> sf probe 0:1
>    SF: Detected mx66uw2g345gx0 with page size 256 Bytes, erase size 64 KiB, total 256 MiB
>    Versal NET> sf read 5000000 0 100000
>    device 0 offset 0x0, size 0x100000
>    SF: 1048576 bytes @ 0x0 Read: OK
>    Versal NET> cmp.b 2100000 5000000 100000
>    Total of 1048576 byte(s) were the same
> 
> After 'sf probe' re-probed both flashes, the next 'mtd list' printed
> the concatenated device again, as the scan created it again.
> 
> Patch 4 fixes concat_write_oob() and concat_read_oob(), which made any
> write to a concatenated NAND device fail. It is needed to use the new
> support with NAND partitions.
> 
> The sandbox tests in patch 5 cover joining, access across the boundary
> between the flashes, rescanning, flashes and concatenated devices which
> are in use, removing a flash, incomplete groups and a partition which is
> out of reach. They also cover patch 4, with a concatenated NAND device.
> Patch 3 fixes the existing NAND tests, which otherwise fail when they
> run after a test that probes the MTD devices. Patch 6 adds the
> documentation, in doc/usage/mtd_concat.rst.
> 
> Changes in v2:
> - New patch to fix the lengths returned by concat_write_oob() and
>    concat_read_oob()
> - Drop "mtd: Move struct mtd_concat definition to header file", which
>    the driver no longer needs
> - New patch to move the DFS helpers to ofnode, with tests
> - Register the partitions of incomplete or failed groups individually
>    with a warning
> - Warn about an invalid part-concat-next property
> - Do not concatenate a partition which is out of reach, or which is
>    found more than once
> - Free the member partitions when a group is freed, and keep a concat
>    device that is still in use
> - Keep a concat device when the partitions are scanned again, and only
>    destroy it when a flash it uses is removed, or when mtdparts replaces
>    the partitions of that flash
> - Do not apply mtdparts to a flash while a concat device which uses it
>    is in use
> - Fix mtd_virt_concat_destroy(), which never matched, and call it from
>    del_mtd_device() so that every kind of flash is covered
> - Drop the IS_ENABLED() checks, and depend on MTD_PARTITIONS but no
>    longer on MTD_CONCAT, which also joins NAND and CFI flash chips
> - Refer to the merged Linux commit
> - Send the ZynqMP GQSPI fix as a separate patch
> - New patch to fix the NAND tests when they run after an MTD test
> - New patch with sandbox tests
> - New patch with documentation
> - Do not enable CONFIG_MTD_CONCAT in the defconfigs
> 
> Link to v1: https://patchwork.ozlabs.org/project/uboot/list/?series=529258
> 
> 
> Padmarao Begari (7):
>    dm: core: Add ofnode_find_node_with_property()
>    mtd: Add virtual concat support via device tree
>    test: dm: nand: Probe the NAND controller in the test
>    mtd: concat: Fix the lengths in the concat OOB functions
>    test: dm: Add tests for MTD virtual concat
>    doc: Add documentation for MTD virtual concat
>    arm64: xilinx: Enable MTD virtual concat
> 
>   MAINTAINERS                              |   9 +
>   arch/sandbox/dts/test.dts                |  23 +
>   configs/amd_versal2_virt_defconfig       |   1 +
>   configs/sandbox_defconfig                |   1 +
>   configs/xilinx_versal_net_virt_defconfig |   1 +
>   configs/xilinx_versal_virt_defconfig     |   1 +
>   configs/xilinx_zynqmp_virt_defconfig     |   1 +
>   doc/usage/index.rst                      |   1 +
>   doc/usage/mtd_concat.rst                 | 146 ++++++
>   drivers/core/ofnode.c                    |  31 ++
>   drivers/mtd/Kconfig                      |  17 +
>   drivers/mtd/Makefile                     |   5 +-
>   drivers/mtd/mtd_uboot.c                  |  48 +-
>   drivers/mtd/mtd_virt_concat.c            | 457 +++++++++++++++++++
>   drivers/mtd/mtdconcat.c                  |   5 +-
>   drivers/mtd/mtdcore.c                    |  12 +
>   drivers/mtd/mtdpart.c                    |  17 +
>   include/dm/ofnode.h                      |  23 +
>   include/linux/mtd/concat.h               |  86 +++-
>   test/dm/Makefile                         |   1 +
>   test/dm/mtd_concat.c                     | 543 +++++++++++++++++++++++
>   test/dm/nand.c                           |  10 +
>   test/dm/ofnode.c                         |  55 +++
>   23 files changed, 1488 insertions(+), 6 deletions(-)
>   create mode 100644 doc/usage/mtd_concat.rst
>   create mode 100644 drivers/mtd/mtd_virt_concat.c
>   create mode 100644 test/dm/mtd_concat.c
> 

This work is based on the same work which went to Linux.
CI is passing on this that's why let me apply it and get it to next to see if 
any issue pops up. Definitely I would like to see someone with SPI experience to 
review this but it is fine for me.

Applied.
M
