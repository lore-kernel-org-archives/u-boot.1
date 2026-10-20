Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA081606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uVu9MNXU;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t2dg+oq4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4686B605C9;
	Tue, 20 Oct 2026 05:49:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6-aj-i_jEzos; Tue, 20 Oct 2026 05:49:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A6E660608
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792475343;
	b=tL4KXIcBKm4uLvCnDevkrQ722ZYOJknVYIYL4zIq0WHXPieP5JPQ5i0i9GzjZT4EKqXt
	 nlrOGCG+F3lNZqDhIobqbIZGJ+h2xvUPDkSM4craRJ1Sbt0sOc2qLIEq27tSdIcytxORk
	 afEHhYTzRTJc+TZlqaXXhuDKUyREsBtK80py+oKvK+WuBDT9XEQCBHxk878A0q5bHh3MV
	 hI3LhKxdqPSOZ8fbSNTjP5c1R9LJfRxvceSBggPgArb7dip/uxJ+hD8QIfXd1wMPdBLCC
	 XmT7dqrth3UjSu/QJATAm8ntwowzieg2v2oURAbZkqlAMrMf8c/ZqPLSn6uzwRxuPTw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792475343;
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
	bh=+OnjGyNx/o5uWb0l0u8+TmQbQz2v4onAMTB/y1y6TL0=;
	b=bpmhrbb/WoP/Q/5pE31vfRELZRLmPgNQmv7+NqgYNJ5TCIVpAgT0ans8bxuXESJ/fAlA
	 MdjIiszn+FcucDv5oeXlBzRliJ7SZXqxei1GSz1oaJp+1JokgUurg3+dj4xrwTO27Mr1e
	 U2D877DB/7c4iSRhBp4ts9+2pYM9pplFgx0CkULGOYbVhhtddtOGS69mqrl20rKF9s5Th
	 FaKwkRKl1I8Lj9rWphedYA+1jGB/ETXQUVsH7MGSg6IDc/1iMR4lsPv7BsmT+Uv3JNAo7
	 onf+RoQ0qJLxb2+AynbL4LbKVjfnpJ22ajByIGpTpUSou+LzgNiOGhRY6TQTz1wiLRQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792475343;
	bh=+OnjGyNx/o5uWb0l0u8+TmQbQz2v4onAMTB/y1y6TL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uVu9MNXUs7hfROj+lazHmZvSMkriG8lgiOdUPhBmDW4gA0ccoh3XSh/trf23iIqua
	 sdXajzK4pRlUezgKZVCvhL1Llsw3YcMDxDb7okXwPtUB5NN/T8WIQ68EpRHI5b13gb
	 /WyvWfNcAOBdFAZXaUcVAS2shic7qoeyEqm1nXn2LTguWCWEzbJiCCu5lCeqrrfvBc
	 7Nijuuwm3qINY1xTVLz294ExWlPAMXTq4oN7AKfUT5i1mqzgYrugjtPQ+anFfrREon
	 U96ClG70lvmB+jpJ8Nj972oSBp9DAsZhj8e8RQWCHKRQidmzWTFap6Rhfyj7Q0EUYD
	 rIkgmeeS7aMAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A6E660608;
	Tue, 20 Oct 2026 05:49:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B359279
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68B75400D2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ankHNGo1ZjRh for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 05:49:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6552E4008B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792475341;
 b=sE6q+lPnB2ysg33RJTmrE+2ur8rluQwL0Wz9IcV5T64Kdtkbk0f7FCGhZIR2tDIkMNKY
 yJv64uKlm3NQxBGacoCCiRBHPhdDjzMHY0RebVdRjRhL4Ki+11PcXZRc5ZVI5nhlwMVhG
 WyPE88o/TGAK28Vf63R8RsTJ9XB2M3acIW/B54E8LTvVesKZSYeJPrnaUUCHY/8cN7J5g
 8tfoz6JN9zeEhc09drK8XKz1JTD962jwTp0/5Z6hSU2okMzok8AU4Msf8DEhbqKM0eyoi
 DFvia6s97UiZJeAoJ1N/kfjwQ7t72VLv1wfkgZrE/bvm9544QBWL+2SakUQnU2KzxBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792475341;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
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
 bh=+OnjGyNx/o5uWb0l0u8+TmQbQz2v4onAMTB/y1y6TL0=;
 b=PiD4mBRPeqq40GaWfZEpGZzSNRKyp9pyiQNOAIIgfXGXdbuXBSTeegU5ktxcoS7QtBGx
 bULcrxNhtaD64tVn9DifAZjQaZRlNOX/T3Ir/ExXM5dDdsqFmviLgxk2hsq7BsWFrXQtc
 mjjTWvWIvJpq11jeYrIUzmJtUWNbwFJaVCM7Ekwlfd9o8lO+b87JiXI7i6y+/GH8febmt
 6Q/qy6Ys4PbajSOTLcWuIW4Z96AI94oZgNfL46au0GRgc+dlapN30Roo6lI6N2YOPBGGG
 Ay4wZ0JXnkA/6gF1zenoDWb81QOa1iWJgmzfX+EeWGx39fHJjMkLbo6hAsr7hpfkXaA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=t2dg+oq4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=t2dg+oq4
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6552E4008B
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 05:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm3C7AwNUA386DkkTWfHQB9Bxn+JGmVudy2O0a0x86Fwx+qgaIJgvGbWZHn9zy5PZX/KASyGqWlu4QWGb9YQ1seXBXFGTpuMfwEczpByDGRVeDSxcNtujmNW7DHvdlYQ1ZzZK/vyrGgpb9KAJ7O2iB/JuVIWT70eZsiQPqGprjtJ1H6md+ZW+nNGO+Qrrd4oZ0YAgTquiSiNM2H/vddaF44qs+9qIbqkzmPB6c9O81dv3wrX0cdwgMow5UZALUA/8EqTqaEG1mYbTn+HRii5ZnBFVb0ZmeHayDxXSE2FylIacZhUz2MXjlcJ+Mp7OT4JPBgZyZAj1tul/c3L6auDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OnjGyNx/o5uWb0l0u8+TmQbQz2v4onAMTB/y1y6TL0=;
 b=aKUmsjdwwfpSkL5ek2OCAKp9Sw25/Oz8TohCe6w9+IUgkyxff1MrzaOAItOTexlZtSi/XiI/6w52MgGmjKlFK6PuGA8i2pKkO1ei+DcPJD9xtgoE9xkYwJnLeiMuY64audZgsTSssIO1cZgk/sXCze8IY3d4ob8zxLAPM4R5xmtj0GN3Eef9Kc1o49jKcT3tnIm7QdVsanq1vxBADyqyUJEzcZ9rInQ34+yfCFgZONTL1JGoU1eyhvmPbp6NlrUzWGmBfE5tQpKlmnck6LXXoZ4J20/oyygNTz0FvPixgY7pRV0NVC1NLp2vc6qhpXRFq0dMOBnnr6l9P8HM8JjPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OnjGyNx/o5uWb0l0u8+TmQbQz2v4onAMTB/y1y6TL0=;
 b=t2dg+oq4Ouub4EN8FiYi0QHJRQ84sbYzcG+4WFP96bCfKb75Qp72v+GCuJ8LejDKgGU4nigQrD/NNyzFvENRCrZrKP740LEohxKUETGOnI8FZqTtnBAIv1g3Hkv7TWj5vKydbBABlHDF3R1lm+m+a4Ix8u9Yb13Th51b6rTakSA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH7PR12MB7259.namprd12.prod.outlook.com (2603:10b6:510:207::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 20 Oct
 2026 05:48:53 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 05:48:53 +0000
Message-ID: <6e01b927-ab3f-4640-9ace-a1b045d47426@amd.com>
Date: Tue, 20 Oct 2026 07:48:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] spi: decouple cadence QSPI/OSPI from direct firmware
 calls
To: Akshay Belsare <akshay.belsare@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com, Padmarao.Begari@amd.com
References: <20260921185430.3491195-1-akshay.belsare@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260921185430.3491195-1-akshay.belsare@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH7PR12MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b554a3b-ecbf-4c0d-59a8-08df2e6dd284
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261009221727099003|10067099003|261009220027099003|261009221227099003|3023799007|261009223027099003|261009223327099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mWqAX7j1MiTMYPsxamlk0PGYg4ToWeAyjGyStdy1f1355jTjGpewoN6eoy3GyJnKI/ukfuAuuSsjDx4+pQypat8jMMDQEgS1RcA2bOqdjIXtas8nl5FdpUUdUUDuv+9Q7XJzQf5bDGtKkIo9n9ZgTetwBPcRGAhd3k/W2KxRFg4u6N9wtmwZ7iAyjmEFwUj/mRC18aFZjAX9V6FwAsx3wGVS8Uqu10Dlclrb4ZXwp/Joa1vvcWfzqBMy6f29ZEeW31+yKQEWPgobYK6dBi2qOubiAfJkIhTy3Xj0S/eRl500v00TSAFtNpotBP/1FHD0YJ2O0MlABURq/CIahS7deFpYi3LDwnm6DLrEN/9oujpaOmVJXX/BcLZxLLmDXGgkesWsOMsddYfc6K0INeJiv5gryjav7NOYLhNkDPp9oT56ewgr+ZneG69X4FOaesvrFtkww/OZnV1SqStGxz6ogcKWb3dtsOaWPBuA2WIRYuuUmkY+FRE5Saq0z5gvdYQeKGsAQOe0UZOJiOVK5c7iS8IeQTd3czQDxAI7DvD686V3ZuwFaZGDgiKtqjrLkxZm69MCiN1Tje6aTSr+MQqSeiMtUxdqidN20cHi7WlJlylrcWiILuqrX9UpdwGGfKchJi5PcEK2aWjLGewV7joYi/Mx9pt7VuTmkabaGA7nVE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261009221727099003)(10067099003)(261009220027099003)(261009221227099003)(3023799007)(261009223027099003)(261009223327099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxPM2c3NW9TSE51Z2NRWGJPTmNRL0s5VlZRVnVRSjZ3alNDcVZENzg2OEV5?=
 =?utf-8?B?cDFDZDRwYXRHdlh0UVhQNnYrdWNzV3dKN0FtTE5aM1lUdEx3TDUxZmFpV2pv?=
 =?utf-8?B?N2RTQXBGYXFreUNPSVdoNnIwM0xrNXdDajErZ3FLcFBFV3pxWjJxYXI2Zm1M?=
 =?utf-8?B?NStEN3ZrYlFNditjaGtBSytXa1dzT25ZY3V2VjZXblVjVklIUjZNMEh5VFo0?=
 =?utf-8?B?NmFtYmtTT1ZTQmc2OE43bFBobHdvcHJOUzZaYlBxY2pmTENDZG9Sd0IrbWV0?=
 =?utf-8?B?cXlxc3EyK0ZFWVdEUkEyaXM2SHBFaVFpbEFNYTFFREh1OUxsK3IzNFR6TTBO?=
 =?utf-8?B?d29ZNEhnRDNDQmJ0MGlpV0FtbHRWd2EyTXFXRDVnWWVuVVlvK1BidUNHR2Uy?=
 =?utf-8?B?Z0VhaFViWm1TYk9SZVUwQUxxdk1ZZWlnRG1BLzUrUnBhK2xIOFZrYzJzQ1BK?=
 =?utf-8?B?UnBrUkZyeENPN2JzVXdyNC91MWsvNHpmWm82cnNXVXpad1d5b0hWcTJweEZs?=
 =?utf-8?B?SUxDbldZdC9ucmxWRXcyZXVQcWY5Q0hZK0t1NDcvVlloZHRxUGtaSHZ0akNt?=
 =?utf-8?B?RE0rZ2V6dXhxWnhpS2VDaWpaZlpDbmlpcmRuc3VRWVd4SDFNVk9lckJHUk0v?=
 =?utf-8?B?RHZWRTJycURmVHMzSlZKNkhIbGZvY0l0QjFUQzBPeFdCTDVKSW9wMS9pYjlv?=
 =?utf-8?B?c0xjMktlWFpJRnV5NVg2ZUFnNFVIdWxET2pKVjNHU3MvdmhFcmFkYUlXN3p1?=
 =?utf-8?B?d0R3YVFHVXdzSHJCeEFqL2I5TCtmMlczVkErcG9FM21HZmdVRFYvL1R1VjZy?=
 =?utf-8?B?TnIwSURBMGp0SWEwV3dRNWNIM1RNaUlXVUJoYzZGTjhQbUFmZ3F3Qk52ellF?=
 =?utf-8?B?WWlwSkxlcTR0TXhGL2kvL1AybE02NEJSbzdBci9STUJvWDBPd3U0MTJTelRo?=
 =?utf-8?B?ZFFTb1BnRVBCL1Z1RXRveEJYdHc3MCtVS1JtSW83Q1FpVk5zdXFpaFVNTlFy?=
 =?utf-8?B?TFlLcENLcEJ2ZnF1dldvYUt0akhzSTREbTlXOUo2Nml3WDl1N3A1WVdaMk4w?=
 =?utf-8?B?WFZCSDVHN2ZJZWdKSzBuOXNDY3BiQzBtbGVzbE9tZ0JyWWR3QWRsSzNZdVFj?=
 =?utf-8?B?b2loTjdTdGZXQ1VSc0hFNm5FWEQzdVZNZTI0alhuR3EyRjF4MEYxRFJJOVZ0?=
 =?utf-8?B?Y0d4VG15ZUNiZjlwY200a3p1akh5eHlTcjNEdTk3anJxRWx1NVUzSmQxMWFP?=
 =?utf-8?B?YkhRd2VrL3FHK3RrRFhyNzBDbWFzZWg1R3UyclVQRmlNakxDRFpqMVN4SEJ4?=
 =?utf-8?B?c2h0NmNrN3JONFhjVzhHTkw1YSsvVkllKzUyMFpnSzA5U1ZmR0htSXJ5dU1p?=
 =?utf-8?B?K05KV3RwWGVqYVFQNkdBb1BFR1p5YXBudytXMm1tYnpWOXhOeDJQQmNRbUp4?=
 =?utf-8?B?T3d4enhaRVQ0RnplbWRiaWNkTy96Um5UVDUrNklsOERLWGNHS3h0UmdMV0ZT?=
 =?utf-8?B?S09wWnRjemJLYVNPdmJ2dFdVSFJlNTlZb2JWaU05T0VkeGk1T0lqdm5aeEZ1?=
 =?utf-8?B?UEFCakRBVnU5Q3paamRSeDBmNURuUVJZTzJxYkloaEdHcENkaFExTVZCOCtU?=
 =?utf-8?B?MC91M3FieC90aDg3UExFOERjTWczaU0xdEpETzNPcFgwTVRITnBlSW1EOEJL?=
 =?utf-8?B?TUJxS3FPMllUUTN6dk9xRTFMZWNueFBaMHJLYVA1WVhUNCtQNW1lVDVuaTJ0?=
 =?utf-8?B?NjlkYWlMUDVLeGRYTkRaWHgrWXdRdjluVWd6UUYzTVRsMTJTZjdURnJQdmF3?=
 =?utf-8?B?L1ZYWTlNK29sUy8vdnIzUTNDLzlUZ1dKK1UzeUY4L2VISnZUc3prdUVET3k5?=
 =?utf-8?B?QUdpNm12dFY2RGRBVncvN2QwbjQzM2twTWJIS01NNncyR1Zvb3QwSVJsYVI1?=
 =?utf-8?B?R0tvTHJaWVg4L0JFU2RTZXU4akg2MU9SQXJwZno2UXlkQk1Lb0dsRGlrZE0x?=
 =?utf-8?B?WHEvd3Z4VXNjZk5xTTVnaWViNC9kL3A2YndmaUVpQWNIK2JUeTY0Um9rODJI?=
 =?utf-8?B?Y29VZTFDb3hDdkJzcCtJb0pzK0xxQWd5QTg4aWVlQ3JZNnlLbHZHMGhHSE1x?=
 =?utf-8?B?dmdGK2ptVStlZHZGOEpvRUl0d0JhbkFuakpHTUcxNFR2dTMrQnVkZkc1VFFP?=
 =?utf-8?B?RzAyWVpUNStwb2tnRGxXK3hRaE1VUGVBR0RIeG43dHlKZWlvSjNqV0ZEMlo4?=
 =?utf-8?B?ajBhS0krTjdxRDd1OWpCYTMzUUFDZFdxMmFxaWhnQlh4TnF6TTFkUXFZZytV?=
 =?utf-8?B?VWl0MXNTMWZxa1FzTlNWZ3I0Y1YwZTlXcXRCUUJoZGZqU2VPcmxPdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b554a3b-ecbf-4c0d-59a8-08df2e6dd284
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:48:52.9879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd6gANak6QRcauSCwuraj6DBOsNYCOSc9wLc8umpnCIOqmYO7JAKGO3EqaGmc6Cv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7259
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 9/21/26 20:54, Akshay Belsare wrote:
> cadence_qspi.c and cadence_ospi_versal.c call xilinx_pm_request()
> directly in a few places, guarded by IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)
> checks. This series replaces those with named weak/strong wrapper
> pairs (zynqmp_pm_ospi_init(), zynqmp_pm_ospi_enable_linear_mode(),
> zynqmp_pm_ospi_flash_reset()): a no-op or raw-MMIO weak default per
> platform, and a firmware-backed override in firmware-zynqmp.c.
> 
> Akshay Belsare (6):
>    power: firmware: zynqmp: add shared request_node() helper
>    spi: cadence_qspi: Abstract PM node requests behind firmware helper
>    spi: cadence_ospi_versal: decouple OSPI mux selection from firmware
>      calls
>    spi: cadence_qspi: propagate mux-select failure instead of only
>      logging it
>    firmware: zynqmp: add OSPI flash reset IOCTL wrapper
>    spi: cadence_ospi_versal: route OSPI flash reset through firmware
> 
>   arch/arm/mach-versal-net/cpu.c                | 63 +++++++++++++++
>   .../mach-versal-net/include/mach/sys_proto.h  |  8 ++
>   arch/arm/mach-versal/cpu.c                    | 63 +++++++++++++++
>   arch/arm/mach-versal/include/mach/sys_proto.h |  8 ++
>   arch/arm/mach-versal2/cpu.c                   | 63 +++++++++++++++
>   .../arm/mach-versal2/include/mach/sys_proto.h |  8 ++
>   drivers/firmware/firmware-zynqmp.c            | 38 +++++++++
>   drivers/power/domain/zynqmp-power-domain.c    |  7 --
>   drivers/spi/cadence_ospi_versal.c             | 77 ++++---------------
>   drivers/spi/cadence_qspi.c                    | 12 ++-
>   drivers/spi/cadence_qspi.h                    |  3 +-
>   drivers/spi/cadence_qspi_apb.c                | 15 +++-
>   include/zynqmp_firmware.h                     | 17 ++--
>   13 files changed, 298 insertions(+), 84 deletions(-)
> 
> --
> 2.25.1

I likely forget to answer this. This has been applied and already merged to main 
branch.

Thanks,
Michal
