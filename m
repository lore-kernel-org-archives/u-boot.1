Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC50CCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A33856073C;
	Tue, 13 Oct 2026 08:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f5DYl0z_TzKo; Tue, 13 Oct 2026 08:09:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E64ED60755
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791878969;
	b=XbtTUnh+dVHtxFQRenHXb9Ae654S9XmB/iKIFHcVncAx8YvZPF6vmEQ3mxBv5aHDdKTt
	 vUscMR7nHzWlE79padmZC61CBYQL1GG02v2ggw1220ZMBPo7H+E44oyOuoAyL8hQ2Nygy
	 CH3c3h8ufJ+3N9JmmHb+I7AkY8rd4T66NmA7e0d274rwBdxfVgC4XlImzir1myzbhnZWh
	 mBtwpySdqcaiiPDBxznGMglFjB5YKgDDynFFV7OC/VpcquHr+BK6F01I5c0rbOgCJNLx0
	 0pOJ6kNyDydypkGuDAvh0xA2xrzef0rvb7wpvCE/IcUo0M01Bp4kAq2JsVn3+4LXG7g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791878969;
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
	bh=B9XcmFzydLGjXZbquora3slMlIY6xOURqMlKTR3/hEU=;
	b=aynZcleJn56KmYhDHjBlC+ka3KM/slEl+hYWtTRdSDbTqFWT8WtZRwA0bYAAjjxuq06o
	 0pVv6H8gBJeHV95f4u/bdbnh8eJHV6JRX53E1g3fVwILo2jIjNXtVpJ6NmZ0GkX5rX6iz
	 NgsXPGyJJQzCY45ZpGT12ih/NYcgwTpt/LJh0SNkEI9Lq3gGIzE/BIsAK7fub3b7Ks3rL
	 di+AY5iSfL9Umi9fH4zTWPSFlvWYQ71PO3oc6bfoB3syapvtrKzPwBkWLZsgDE0MjxDZd
	 AGVCNV9eqeRcgKGX2VfI2L+99Xhij+mO2xv3VkmwdcEF1PjvY7SnscAC1KMqhNTgQsw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1HJS64Nx;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791878969;
	bh=B9XcmFzydLGjXZbquora3slMlIY6xOURqMlKTR3/hEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gqw0YljHYg7loB1Sbi2559uSl9kz4xVnNR25d3LBTi83Cw1xzxr9qDHAHPbQxZwkA
	 460axubyTW196EVf8xde4UWh0CD0OGy+LsXVBzm6tFIzrZIhzLrNqeMyAbyV4arNhy
	 F+gSmZ9XEWLZWm/1A9c2360qcV1enazY+mbyuyv7vhA4L7c00DXK0nvWRB4Y8pF9uq
	 QpDDh53T5t/xKIiTKryBmqVLlg/eKtnIUdggVesEv5O88+3meOnP9dIlduBVmul+Am
	 sDZLOFMTQ/bqYg6E5+Ha2RDJx/Cyem1TWp0MvvR2I1AViCnP+OVojkHnGK8UUavztW
	 IK22mVHyBhC3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E64ED60755;
	Tue, 13 Oct 2026 08:09:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BE5C105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 819E860755
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:09:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Muf1T7F4C-Qo for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:09:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9FF36073C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791878967;
 b=f6eZfLpMr0A4csiNWhK4JUsOx1zIq+bwiUkShuXKQU28GQasP6fhM25yXZYqzJqQeIbt
 8LUlYNCxsSXUAx/nJWJcBSVdNCRFtgxlsZByv9FD7zKQ/6unr95v2lGK59rrKhlpPL+uA
 7jlIrRyluj0BeC50u9xzlei7ddo98WO0v3CJZ6tRkk8EQxCeVKWVVf/7rZxet+XlPiFo5
 VN3ea9U8ajBz6viH2ZwR3FKVXBz1B8zS9uq5VptGz3BsiIaEsxpEHNp+sufJZxRwIAllu
 8gOszXSaPinlg2ZgRhgfIiOdDnVAv+T8pSloPHhxBIZqhprTLa+BLOYCUGY5mIZrtEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791878967;
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
 bh=B9XcmFzydLGjXZbquora3slMlIY6xOURqMlKTR3/hEU=;
 b=beyRXAg++pTlAwqP/F/j4OQNrx47H9etzXFyF4oK92YtceBwhPF8EydRRbiWgSkpK23J
 j9S1n0F78/dzlfzmnKawhO1jSXXU/vPVogizWwNLN6Er6maLDuTHGcxSHH+t937WDhgA4
 +ym7MWNAmPlWD+9QDdfvtenbdqKu2rf/VBt7PhNuuLyN/9ShGK+j0UrKKJ6vaXOBFrLhw
 o2rwm32rg1Bh3fJfFcJKSaUjrfWJ3Gp0TjjQK5WE7yF1JfBWI8E0jBHGz9paerVGGvPTe
 eKch4Q0GRmwOV68RlA5ouIA/SpMor8NmBl59rfA4PoYcEW9fFPQfFWrXEQihbx9t39g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1HJS64Nx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1HJS64Nx
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9FF36073C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ig6mkCuEHcdm5zlUzjE59nETMShsyt+fg+Lq29tFtxuHHZK/BSYUhepkFfD/QKe9kKBzBdMokbV0XFdglB92rLy34AMqIBA2OEaDmMhlWEFeeDiz6CIhKvkilfE+16sQpQMohBGZQTZtAy2gsmdsEIpoSCtxirH6y43FtLsX+mXA6GO3IAJcUplc0tcwIMLImnyjo2oKSZhBhlIz5N+l4Ga7rWQBm2yR6MwUbBf83tJt2pf0XXQxXo/20oUo9gjOaqBPDsNFTz8JubU5q7vrFEOWioadLuBoX0yjzKhOUBu3o4rXc+1idDG6v1E6LuL73W2JYLoL8dIrUzGQ75AvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9XcmFzydLGjXZbquora3slMlIY6xOURqMlKTR3/hEU=;
 b=Y7Fl70JJPkRXKJWnjphor/32q2Jz8+fqQo3wFK0TGvOmq9P7SGtGYqKvakYdUxewKFMCtKmNlYQAVWCOwZYmTnQEUyVCvK0FMJQNvzzT9B4+6VlgZjD1LrT/UdEVx7UdqCEhfpeYKz6cmWLqLBi3KLbz5zlkuaiwV6QaF2zqAXahQzdOs8tMIATKvP6N5ryyapUq07V0roX5O8+phk6n7+koFIUj7sSwi60rh8V+JMMM1Lx5p+vt8sw6MVWVP23AsEySSeLkivmJ0hEb+OTVJUPw6JMNJ8ZRzkNxJH/mX9qUxBbv7+2sNYz0kMm0x77NJLZG9Ox+AeTRaNIZvYkXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9XcmFzydLGjXZbquora3slMlIY6xOURqMlKTR3/hEU=;
 b=1HJS64Nx9vpWt7l+epDozmlgwFZRPf+httqvtpFR/xV32lYuJuRY7ToiUqxOIrisjCf46sEz7iiFP8DaY7yymkJi1bjn31G2pydxPoYIwWj9qvIu5lxdV2cLGfN8UT9q75kAwi3tV4yYAJQf0bq9Gf9XgAJCTs7LR/0tRoaGA6M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.19; Tue, 13 Oct
 2026 08:09:20 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 08:09:20 +0000
Message-ID: <9495bf38-b219-4f76-8744-924dc82f8bb1@amd.com>
Date: Tue, 13 Oct 2026 10:09:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: fru: fix OOB access in OEM MAC record parsing
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.u-boot-project.org
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20260922065452.1908297-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260922065452.1908297-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0102.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::14) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c524d4e-7d2e-42f2-9ca1-08df290148ea
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261009223027099003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GbDUWOgnuOsnGlHv3qlhd755sp738DTtYlKxLEQ5N+cB46A/CLm4xYWtCUndxZPpJ4b+NqSt6eAC2gsk9/SuE3Z1zLSOZddwWYWtDN/2V59NXuyeOvrL/7TQ7bwP9Z38lbTwNIU3xHP1BzKOA6HboaI0OPQVidaYTSQV/xYYqT5nKRkVTJ60EbvDWjeH9JK+icMSArB2NTQTJuJ0+Ko3ukPMiFDuOOGygPYP5ID2sfNETfmv6Q4b67OwhiucAN0/KZrMoF/UKKBDC+LIU7xxM6rBJU6+1u0clPMqVCtx/xujb1VMOGJlKO8cjMGL0mVndk0ibQe+HXXWCPGenO+rc1bOqOgKKHUgUKFMofCplxtUTG50Tm7EsduZLuZSvf2YNrF8BIuTUi8NwOuu8DoL1Yr6dhUyWjNqfFR9fqx+FjbvpSJBCWwRjscCvtxxN+MsuC9RyW4jmLsNyLpksjLPGIFaTTAEX5v+QuoBzXBn/nM55SPGUg89st0zDRqRyLCYAlHjgR3vnl0eqI2Nct5XiNtFzbwS49pQ9O0PBKOioHxu1mmNpVwuzf+OWBkM+VsrcblVRXgEMYBco3KgfdUXFYvTZDthTmSqisfpwdlzqwd04e0A6nGcp7wMHKmB2qtpQlMlxi/Yiz8qnzsfy5sf6LkE34u9OgnbvPUn9XFnW7Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hoRnR0aXc4dmtMUGFsYjB2TSt0Y2lxdWd6S3hSYm4yamh2V0tXR3dUcGh5?=
 =?utf-8?B?bDUyNFFheVMwaEtSVjdDRFVKbmxpM2JyeTRkRmpsZFkrbnpiQWREcGxmTmN3?=
 =?utf-8?B?eFlGNXgvUTBvdnRUa2owQXprZ2NzTGFzN05JdmJTNnNaMUZhYzFicFBieW50?=
 =?utf-8?B?VFlHeTUrSWNMQ3ltdXZOcnNlcktuc1poNnUvLzJXdEJVZllCaW5jOHNjNThH?=
 =?utf-8?B?Y2VUaUtGZndBTFJkaXV0YmhrazFudEVmdmxROWV6QmFBSlcyMzZRUzZBbDBY?=
 =?utf-8?B?RzF4MkRNaWlZNHVseE5NQS9EMy9TMlM4VTQ5Y0xLdHB2Vk0yOFlvbmFjaGtU?=
 =?utf-8?B?dnRyUXFkdU1YODgzWk8xditYZjRhLzB1VWJuaGJLRWFsZy9KZXhnQ2JkK1c4?=
 =?utf-8?B?dmZJcDBveUNMZDB5Z1BCbFhOMXFyeFhrbENycy9ORDRCL0Q5d0swMEN1QlhU?=
 =?utf-8?B?NVlreXVwOE02SHhxQ3hpNS8zYVcram84WUU0WXBtRHFyOGVVSkJaSWVBdG90?=
 =?utf-8?B?YXFNNlFnYmR5KzB0Qmd5MUFSa1lBb2dIaFdOVTl0QWNzeHNCa3NzMU16Ui81?=
 =?utf-8?B?NS9WeFpMcUlXRUtqVGw4aHRLdm1vNHFnMjhsT013bDFZaWhibGYwanllaHZV?=
 =?utf-8?B?WDFsdVFXQTRYamJOWHUzRmJSU0ZLQkFubVpCTGxhN3hkaGJUOG5ZQURCbWVG?=
 =?utf-8?B?Z3Zhci8xYXVzZit5M0ZCMmhhMG9RTm5NK2htQzFRT2hKMUF5SG0vdThzUVVn?=
 =?utf-8?B?bzB6R2JyWHIrMy9TZ3c2MnR0MHVFQ2dENW8rUS91bUloYjhNMWVrb0JYYXFP?=
 =?utf-8?B?L0FSQVlBQlRZc3Y4RklxTzBCaitPYzNWSGlNeUtnN2tjRWpGOHdOWnBPLzNk?=
 =?utf-8?B?dnEwM3lXUmd3cCtJaFBwRkVpQXlCbTMxWnhkQm96NWQzclhWS0UxaEdjN3ho?=
 =?utf-8?B?QW5NRTdRVXZONmp6eGwvVEYvcnBRVTlSMVBHaC9vZzAzbVhzQ05JUUZHNFdK?=
 =?utf-8?B?M0tqOHl5ZS9rOEU5MUl1cUhDbklCd1E2UHhJYVRvbHVvR3dZYTg3cElVS2pU?=
 =?utf-8?B?VXpXN2g2cDMxeHB4TDJnOXBEZWgxeENEcFlZZFFvZUtFUWhySHZpUC9UdXdJ?=
 =?utf-8?B?SDBpdlAxbzNGMmkrV0hFazIxYlJKT0NwU0NmNmFHL0cvSE5ERkh0VlhZVWdy?=
 =?utf-8?B?T1JMYmx2MFVDYWVHd0s0MENOeS9oaTFmbGFQSEp1QWpFTWJwUmhrWnhHVEVy?=
 =?utf-8?B?ZWd4WVFPT2RrSVpMQTBsU1FEbFdDSW9ueXFrdlo0aW5XN1pCMWFtZGllb3Rn?=
 =?utf-8?B?MXdEQ001Skdnek5keEVLUGl4eWFhcHczREtDUDVkd1pWcFg3WVZLN3pWcStj?=
 =?utf-8?B?RzJBeVI0NGRuUzAvTmtVTHFadWFoZmhZaENicDhoN1pXbEUzL1p3NWtKTkFW?=
 =?utf-8?B?V3crYU5kcUl1ZDZkaVlHclNxRERiaDVXbzZRdENyU0FjdjBic0Zld1o0Ymc5?=
 =?utf-8?B?OW9jYWFtUFNmcmVUZEg3OEJIZk53OWRjVjRxbDV5SFljYVhEWjUrZ3VxRUps?=
 =?utf-8?B?VkRrTnUxb2g1Q0JhMjF6b1EwempqQlB2V1QyeGk3UGVPVURGM1UzNFB5SkJL?=
 =?utf-8?B?Rlo0VEdET09IUmlreHJZU01jaE5EaFkxTGpRS1k4OENlbDFYb3p3dnZsOHE1?=
 =?utf-8?B?b2ZBKzRuSWdCTHRBNTdwcEt1ZUxOcjIrSGxMbElrRHNjWGJwS2JhM2hWakth?=
 =?utf-8?B?cmFMYW5MNlE2c1ZnMnp6T2dTc05tL0NBMjJGYlVuOUdFakFEbGdRSmMwRXdh?=
 =?utf-8?B?ancza0FhNnNDQWlzbXZObHVVOTJjbWZORGlNM2l2Q0lEUm9acjVQRVdiTk9p?=
 =?utf-8?B?Q1FjellVT1lMeG1lMzZyRlFLNnRja1VvRE9UemFQVWFHeVo2d3E2YTd5RHY5?=
 =?utf-8?B?UFVMVHdxN3o3dUhwUVhqV3htMFh5TWJUWjZDOHErdXBBQWhvL1l5WGQwM0I1?=
 =?utf-8?B?TGNteE52dDllaU1iNGRMTEs5RFNSU1ZpTEZrVDhJT1VnclRuSnpoTDkvdnhD?=
 =?utf-8?B?dGFCbUoxbDhKMVliUlpzRC9FS2tMMkV4NlJKR1U3dlE4bEFteEl0QVpwSXF3?=
 =?utf-8?B?a2VmMm9GZmdGWlBLZVNEYTNNTjVMMHhVL2F3eUk2V0NSRkNxNkdING9Zc1Bz?=
 =?utf-8?B?MDUxNFBIc0NFdFpVWWtxUlZVREJtOUtkamVGS3dqRTA3OVpwUDNnMjVsekp5?=
 =?utf-8?B?bW1EQ1Q3UGtYSjZUeU9GZnowSGhDU0pxb3lUdWwrWnJ0eVZhK2RzdktoVkZL?=
 =?utf-8?B?T01yS0dQdks3TW1qR244aE1jbUUxc1pLVUtoaDZ2QXpoNmQvYWxaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c524d4e-7d2e-42f2-9ca1-08df290148ea
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:09:20.5479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAMp73Cb6op5pctHfGN4lgzDqRcLS05I1wI3upIj06RYF0uxjPVcFHHANzhEpEN+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 9/22/26 08:54, Pranav Tilak wrote:
> In fru_parse_multirec() the OEM MAC memcpy uses the EEPROM record
> length minus the IANA/version prefix with no check against the
> destination. A short record makes that length negative and it is
> converted to a large unsigned size by memcpy(), while an oversized
> record writes past the stored MAC array.
> 
> Validate the OEM MAC record length before calculating the copy size.
> Return -EINVAL when the MAC payload is not a whole number of MAC
> addresses or exceeds the destination buffer.
> 
> Fixes: 7a036b674fc8 ("fru: ops: Add support to read mac addresses from multirecord")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>   board/xilinx/common/fru_ops.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/common/fru_ops.c b/board/xilinx/common/fru_ops.c
> index 610293bccf7..24b135f7666 100644
> --- a/board/xilinx/common/fru_ops.c
> +++ b/board/xilinx/common/fru_ops.c
> @@ -260,8 +260,13 @@ static int fru_parse_multirec(unsigned long addr)
>   			if (CONFIG_IS_ENABLED(FRU_SC))
>   				type = FRU_SC_MACID;
>   
> -			if (mac->ver == type) {
> +			if (mrc.len >= FRU_MULTIREC_MAC_OFFSET &&
> +			    mac->ver == type) {
>   				mac_len = mrc.len - FRU_MULTIREC_MAC_OFFSET;
> +				if (mac_len % ETH_ALEN ||
> +				    mac_len > sizeof(fru_data.mac.macid))
> +					return -EINVAL;
> +
>   				memcpy(&fru_data.mac.macid, mac->macid, mac_len);
>   			}
>   		}

Applied.
M
