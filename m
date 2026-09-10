Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34BFC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 07:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2B664077E;
	Thu, 10 Sep 2026 07:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6tDEt4L07_0D; Thu, 10 Sep 2026 07:59:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 08E6E40708
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789027177;
	b=IvdRnyVdnVV+dYqZedKigwT4pUYM5l2yk4G4MM3t+tSXEiMq4gbeG+JHHLFqpZLFxrf1
	 9iYykLZrkrSzbvsh0kRr21+WLB8Zj3Y7TToBnaYM4rL1y9MSMz2zb8Jy3Dwj7WwcbbOee
	 2dMhSUgym+JtcGw3A7vXbaAc2nT/k7ld0RqIv5mSszd0fujYdlRG9NqDz7N6xjl5b5HPB
	 0TdB2zPt80lslVJPylrubxOgY5/ajMjzMw/Ri5R02R4DJctAfCxhCBde3qh+xOyoe18gl
	 lvKrSoGXPHCq3SL6V3twd1dTlipwSC3i1j+Kuvye0+egDmlU4tYzRnDOJX+BBnw3wTg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789027177;
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
	bh=YR69Q0ylEDZCXKigeeo+tLoo4DfWbYmA+w70lLK8xl8=;
	b=Ne9ukvzRUg05zfUV4oDsFMph9OlB0W+yHArj1WQdWVbiZ6ZKUuy28FPBGSOP5RKLlTeJ
	 KVCBJZ/Yf19oXYLu/zxb5p+BSRBvmj+APaZRSS4+z33EVKuqEFMqvmonKR3k7GnDYfU8p
	 nLBIPMZZEZJz6BqPqiYueACkKWAfLj08NV3xNjF/7oO8bDF/n3ruxIxEjszURPnq8nUCI
	 gEVPbTWTcCTQXg0HW/oU9m5H/srKKHt+IbNER0ljkSkzqzADZv31isZgSV8cUXCsPJ5GE
	 yeZWhekvozEi9tubOJ1TTUFgYHZnaCddyJW+MbRk2UIjABSTmVSA4sXZBNBHjC2oyDA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789027177;
	bh=YR69Q0ylEDZCXKigeeo+tLoo4DfWbYmA+w70lLK8xl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZfqbN3mF2i1O07vm9aQtWQRLq2quV+5qwShalJxQ/4D6l++OxIbFW/USEY4DuVB01
	 YV+fmlWxZwhCUaqISUEoEk59NonaCk395wBdrg1JSPFrCiRVGVGKCfeXQBbpoufp1R
	 8Gyv+K3zzlCaJgLeltlT2f6kWNP8u6XClXust7+zVh322Yoa6lNXdqxbbbgixon10u
	 ZxQL8xny0DOIK60WsouN9l04GB95rFCxgv+QyheAhOtrulZBOCZddB/K56clb4Avj0
	 c3k5XQhPf1Omq9oMEWT7Imhn0SSJMHM75FZXZiy7q26Sihg9sxT3d+wSqsCLDSuo8P
	 95ygriVonxCoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08E6E40708;
	Thu, 10 Sep 2026 07:59:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E49A414C
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D64A6401CB
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t1lk0lnpG3YE for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 07:59:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D6FBA401B0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789027175;
 b=Iggrcqr4aWkKzVH1FVvmsvNANbEMbvG2XDIs63PdeqoZxeC0U6WsTA5zJuodf9q7EzVn
 I7l5KB6J9ogFR1qwCfPpsX7cZAwtXA2eU+n55CONhD+wzewZDu3gJRGyumzM12T0txt4a
 ArHamppkyi9IHrCfXnFgXx6cu3wD2ULgGmNUp1F5jAtSJeQ4j78zcgzMVOfppUHHPo+q0
 rvXikpiePqMi+vTe9Z3/DmQtPMN51xTut925tb8RKv5qGraa8frn2c/YLiS1+j0t7RjZY
 Cd5a0Y9f8HXtL92egls+B9YKPnQy1ahQcXZMx8AIAI0bWB6ygtg6bSAtlLPY2H6yjKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789027175;
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
 bh=YR69Q0ylEDZCXKigeeo+tLoo4DfWbYmA+w70lLK8xl8=;
 b=CPCTuUaUb7WVSShQxBdgFC4cW/Mi81p4hoyU96X3pUg+X9YMDL912e0MnQoZPzcwUhV+
 17zPp8VrXV1Agnk4PdZHaAI3Cg3WjVsERUekCayzQEHiAtrDVCpF35e1IZKaNCJ41nwYr
 V4LVdc25rg5QEOjPWoZWkAJdYvAEcgaQhgc8pH0sdTIQmagJPQ9sw77FwBtPNM+/wyuUJ
 crjkd4DfuQ5PduuKf/fCBf/6+QM6X4kFfxHbM5SbAus8z+hHm6CblHENQQxSN+63hxRAT
 B16gsENqaVll/J89I8VEVwegTgIHURzlotuygvBgkrKLr2nThTshCXrynJC+wMudp6w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=s5BksXWn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=s5BksXWn
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6FBA401B0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:59:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnZCC5gD2ZG4OBoFfnTjbPn/6NDyK7BQPos8ClN2PETji1atX0DsHs1llj0UkhCRcwWK8MyvJGy2u2givVzQTo9hbn4l4p0m5OTD1A9bjlYKRHkf2S/Rkk5efIR/SrdPDA1Vq6jEHXJ204smdadXPG3HS+FoIjtCAs0ykgaH+U9f04+h5RibVps9wg0zDvPh7GJ2pYVpSRSt8dxAzaCTqI4BWxMnuPfav49tC7kOxTvBCQFk/PQIjj+s7PedBUWcuG00gQeJzV8+nEOzpGMadBwDwZlgv5q+7SAbM82eTjIXum+kSTNsf7f6XFthxoIbd4+tH5RLVksMiL/3ZTJMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR69Q0ylEDZCXKigeeo+tLoo4DfWbYmA+w70lLK8xl8=;
 b=UzNPTnNubv8XwmHZ5frZwvcGCeKbs9A0ierSn5/CoCQ8nikJw5M9eiPEGUJvMlBipC7Msy1W07laz1SrWspMeIBSyliMtXKq8LWw5bwi3Xl8Dgp18PtrOA4VY8Btm42NxzmWwhDL3EciqTKKjlaL+0OYwT1gDma9GeUBFP4Snc0PyYZhiZsyX+ySzDGYtQ+2Veon0GuHOzfJoEbzgaeRBuSqJWmJTuzncGG4bbc9SJiZ9GWlOzhvFqXb4CSWU2OmkIeLBZMTu58SKhdydt+0nDK2/U1sIA4PnTK8YqvLrgJmWr2dECusNv3RjLqwzGr5OG3W9e7INSoal+3qoszy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR69Q0ylEDZCXKigeeo+tLoo4DfWbYmA+w70lLK8xl8=;
 b=s5BksXWnVr2zuqGaqscNXbFHsePzNJKJ2leeQJH2Yq2rUofhouJm6ksfWqrT8i5qpRdtuiMWrm6aQsJd4DzklNsAKMPdfIkLYiLuxKZjYEXE3prmr/Nv47C2Tm8bWkEgpsEi+ZTFQRVugC+BkehWv81QIOJIe9Cq5ovft7A6k/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 07:59:29 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 07:59:29 +0000
Message-ID: <0dc17a22-7cae-4818-93aa-6a8b32391bde@amd.com>
Date: Thu, 10 Sep 2026 09:59:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 Sriram Sriram <sriramsriram@linux.microsoft.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: Tom Rini <trini@konsulko.com>, Drew Kluemke <ankluemk@microsoft.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
 <GV2PR05MB1194168C12157621CC125568F83BF2@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <GV2PR05MB1194168C12157621CC125568F83BF2@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0030.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f01da9-39c9-41e1-d9ef-08df0f11711b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DKHbF+7UPi5/KcHHFopYPUm2mmOFWbgzNS4/SdRV0wCP9cQdnbBe+ZgFFqzFGF/rpQTWJwgvpsYpfSDhZ81Z8mLGgjNCJHUePD0QIuhvixFa3J/ggQbqP0d+XMCOmriDljbOsvmlVagnfdTAibUqAvnZgt+lNYUXY4AsXwCTUJ8YwmzR4y5bhpN+XXAqomEj+88TFjCxZ172WbIfBytH0Y3ZWh5B8erhE3mo/XlVVZN491sG2cmZARYiiD9MuOGtfkXvhJUsnHfKbV6YGZAZrPBVaHn4exCBsdC74lnbU7PYTIg+YeE0U0lE0kbzMf23Kk2dQzjemYybIfnsTrSvSu4OLJOdtxprVxWOMxNb6lVDN9scmOhiORN4+eA0Zs9+ehnwuyEHbh5MIFvieYMPZLguodEjy2Kj/F9xBCRVbkg2G+uVSJ96NznArPC9xHCoj0Lj6A5TuD4MII+K/rUo53nKYZnOY/NXrInZNMH19AwJQ/A350SqA9QgZtH3Q7LLTAyU2IzRW+0wM1uvfL8BadMfBRFha70BElb90EHYmfdhMVmOcRHafEAPuJ0ezXRShYJfC8kwKhqexuDroIjZkA2dcY9xt8BHCZjLUR3SQCmdxcIXBIPgoRr53nbZzIUYEmd7y7rteocc2UMiWJoXa8Fcvok7vcI83CyPgdzCIx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3ppVkNibWo3Q0g1VHFJamorWkdLelRjYmtTcEpWcUovZU1vaHhjZkxMZXY0?=
 =?utf-8?B?Zy9RYWZCVnNXNVFMT1puVXI1YXFQTzFjYTVHb3E5elpBMWFkTTR0YVQzU1Rl?=
 =?utf-8?B?aTJBRVdEam16Uzg1NndMYkVMbWU4RkNidlJSZmp1eURkZTJycTdYV0FrcG13?=
 =?utf-8?B?QWNVMml6M0dvSlpMa1hwSE0vWmlqQ3RlNWxqR1E5YURxcjI3aTB5Qzl6WjdT?=
 =?utf-8?B?U2xXTFdIejRWUGRKb21OdTEvSFJ1NzV1NW8ySzZHZmQ5eXJvSi94SzdyY3BB?=
 =?utf-8?B?cUVPSC84c2g4MlFMTWFTRytNdUZZNnVBd2VERGVwQXhWV3pjUVZ3MHFLNXhv?=
 =?utf-8?B?SWxXYUM2eHYzU1loc0tja1AzMmVtWDdzTVhhOFBld0Fwb1JPMmFoSkVHcG5N?=
 =?utf-8?B?Znp5N0xwMkhndlphMEFQYmpVWGRFYkgwZjFkcVlWczZwRHpqV0ljcUtLTVFR?=
 =?utf-8?B?bG9VZUVLM2l5cDNtYmxpa1U4d0tnbnJOR0NLOURiZ3o5eVYwUUptRld2YVRk?=
 =?utf-8?B?elRFbWI4MjFpVE9rVHFVUTJoWkJFMGQ4aHF5alpzcXdpQ2FKRXFZanRvVzJy?=
 =?utf-8?B?bUsybGhVZmY1UWxaU0FMUU5FVmVSczcyZmo0eWRubGhzRDViTE9kSFQ5VThT?=
 =?utf-8?B?SjgxdFZ3bkVueUpKRy9vUHRaK1dnL2lTVGJ3MUU1ZXRoSGk4cTlGMTZtYkM0?=
 =?utf-8?B?VHBxTEl6TjhUbEtxbWRyZ1RyMndFblI3MHJIazllcmx4OEhwb1piSnc1OVRr?=
 =?utf-8?B?bkFGbEc5bnlreStaSFNuRHhlV01zejhHeWhNQ0xFSXBkSVFFTUw2cUJFdC9I?=
 =?utf-8?B?WXd2bExHaWwyeFZ2MHBnSkV2YVdLdUR0U3EzVUxvS0ovSzhsZ25LVlNuWkJw?=
 =?utf-8?B?Szk0RnNmaG5za25ISWNhL05xTjZZSjVTT2N1OE1jeVA4N1IzWm9aUXJOWlpk?=
 =?utf-8?B?RzJ4a3hlaVFKa3UxVWd3cVpZbWNTQThrTkVkLzdpNEJrMmxZeFVSTThnWkNR?=
 =?utf-8?B?VzJ0TnZudzJ6WDBGclRjWHp1K2Z0c1oxYXR5L2hjYlU2cTJzaGtITXdKaFQx?=
 =?utf-8?B?dlM1M2ZsYThvanE5VGdPeDd0UkJlQVB6OHV5dERRZE9ObE1rZm5sYjlsRlVI?=
 =?utf-8?B?ZkxoUEQvZTdtL0VLSjRENVlvVUoyaWw5M3c0ZGFucXptc2Z2dmtSZWxtUTJD?=
 =?utf-8?B?QjVpVVFnaG9JaExWck5pd29jc25tLytibGdGSEs1SzVSUDhzQjgxdzRiMmZs?=
 =?utf-8?B?Tk5XdjVNc2wvZm94alMvckZGNXd2UVRPaEF4cUdUdVZuWkJCeGlVYXdMVUla?=
 =?utf-8?B?bTNxMktXelZxY016dllveEZ1dVJEOC84WllkVHBhWS9XVWV4SEFrdE1kY0NK?=
 =?utf-8?B?NDdld0pGSWI5Tnc0V1YvZ3U5VjF0ZFVYN1QrSW00dlVaa2N4RmZHYk9Vby9r?=
 =?utf-8?B?d20waUo3OHYrS04wVEJoMVFLMFYrM1N2ZzJRdEx1M3FRc0dUckhzTHhrUmg0?=
 =?utf-8?B?aFpOL0x3VDE2YXpDRkE5Z05adExEUEdTTEQ1ZGkreTAvbGROYXdpS3cvdzMv?=
 =?utf-8?B?dzEzQ2pTS0RGUVFWa1FXSy9oNUFWb2o0NHRJeHRYYjNML0RpNmRQZGsvSjhq?=
 =?utf-8?B?bTRtRktlUFhOdkw1V0o3T2RzeFB2QjZ6NHFGL081cHNjS1BUZ3VnR1ZNZWZM?=
 =?utf-8?B?bHNzWXpMUTZxYVYwVHk5RXVncVdOcFVzd3pnLzQ1Q2xvWUcvd3Z2NGswRzh6?=
 =?utf-8?B?ZHhVTXBEUUUvRlJxRWFEN1VqMXNQemFSUHY3YkFudG9Sc09TMEd5Z2MxMnNV?=
 =?utf-8?B?KzhhZFhUVVM5N1BCbGZkaFVaWG9vNG1ISzk1OTlsdURkY1JybW4veEFJT0x6?=
 =?utf-8?B?VDZTbWY3dW5DU3lzQWZGNUpYb3ovOEtiYUFUK2krRnFLQnFhZFN2VTNVWGJz?=
 =?utf-8?B?OVhyeWFmZzJXV2JHbkJnd1hxanF0bDhqSW1NOFd5QWlJaTBPUURHMVVRMHJH?=
 =?utf-8?B?R2I1ZjFQR0Z4ZHNTTmNDcFJKUXpUV0E0REZFek54NFJSL3N3UXo0TU1zWE5N?=
 =?utf-8?B?ZWRYNkViWGxuSTNhejd0SGl4ZzdrbVVoSVFreEhSaUpydElxSlBiY0s1YTdU?=
 =?utf-8?B?WWIrd080VTF4QlZjSmVQOFNDUUw5NlpDbitMaktWQ1JGR0ZQTHNoYVZ4d3Ex?=
 =?utf-8?B?ZDBoZlc0bGxNUGlGZnFaek1lOFpZWUwxVzdtZm5ZSHpjZ1hIUWRoNkxaQ2pj?=
 =?utf-8?B?YXpxMnZma1VjZUwxVmR2QW9pd3NIOWFLRldRR0FqZXFOckU2aEZXT25xNFN0?=
 =?utf-8?B?c2RLcjFBeVhtMHlJV01yR2kzMzFhMllmMTgxUlRVWG1nQlNoRXd2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f01da9-39c9-41e1-d9ef-08df0f11711b
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:59:29.8108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lacpen7j5EXX94fap5f+QX/OxS+4ryVs/T9ZBQ6ehinPu+dYG7nfsm6oPbNcr5L7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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



On 9/10/26 09:56, Maarten Brock wrote:
> Hello Sriram and Drew,
> 
> It seems to me that the limit of 50 for MAX_NAME_LENGTH is pretty arbitrary.
> If you expect it to easily overflow, why not make that larger as well?

do you have a case where your board, carrier cards will require more then 50 
chars? This has been designed for Kria SOM where you have name in board eeprom 
and carrier card eeprom and it is never over 50 chars.

Thanks,
Michal
