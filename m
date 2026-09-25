Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC0BC98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A8AE4084E;
	Fri, 25 Sep 2026 13:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ep0HGOgSFSos; Fri, 25 Sep 2026 13:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BE48240740
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790344342;
	b=muy3NInG88r5cFKbFhXteKeWiiIm0iCfrCXq9WeElcPQT2DxLvdxJsbsLUHVphA/VFU+
	 VOscNf8O5ZYLqm6K1MWAmG3QriE3WPaH34GplFeK8tS87gkky1E4FOM9hk4yFyDo2NFcF
	 rX5wNyxgzvqvZ4KL3tHYV1cC4zeEWTZoDukVclIM5WPCNYNneCf35qlPnLIERH23lf5VY
	 5jthqJAjHROOHuRZt9sYYKMWhrYpPtZpWgznQICRiCfGx1FNXeMpAL+MlOQuNgWDtcPmE
	 2iRAcveRUaMbrcE0C3uOg3bSK67RyptJ0RibNnp+lIpXMTV9f/rlzDNPDcToOrbdSYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790344342;
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
	bh=vmq1gfc6f6bAAqotoG17OHPk3zCxS2y4NJJnHtr0kNg=;
	b=JGh3EK39ZIjwvO5ZiePoK8dYbCujjtJVBRRkoMiQNC1r1S0dOKSBQObYYeXYzef/gLsA
	 rURJ9Pnu2LaSEI5ArUHm32Hf/VuAVGOUj8sUePCBQrZhmK7QP8s3Yi9XXKORriwCEasK5
	 J+t/Cp7IvHe50j4uQF3v1fUqREbblnEOlO5dt0k2GOyw1zqo9m3Tb+10nAbcTfwzEK3Yi
	 yUmjHn0idxseC8qc+84Z+y4iqMDiEbbvbzkbHD1JPqqPe1YjaepHDmEoDVgSJhEr0dhVZ
	 uvpjVzQ1VPCsKgWYNWknDs/8zV3/d7GPwx9tYVO3oH8Tv1vevJO+CyuQq6hBz6j5+1A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790344342;
	bh=vmq1gfc6f6bAAqotoG17OHPk3zCxS2y4NJJnHtr0kNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vqhdoFLshUx5xg8CT4L0hH1C9GgmD3yxukiHuTs/c4ZeCNRmIPvqjCliKiOmO9USc
	 xBIy87cpHB5gPFYUIAokBC4xK12aYoCgxMuK6Mnpt70DqTnzSql2m3SQXqTKmxnwTX
	 uJvV//41RaXY86A51VoPI8Uv5QQio+XthGCP9TsZxtGkZFl9gNqlLUs2vjvlKqPpi/
	 V1thRM5tFgcLh1rRq7o1vOUksxT3Q1u6NSzu1ZQEosRnQTc6xReoQUHqWuYM7J8gkA
	 8UIBcSVuufR10C9V7rNsF6G7aMmgux5nFs01E/KDmfPwFrt4/1BpZ87ukM8WPrbCDh
	 tOQm4qQUSDshA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE48240740;
	Fri, 25 Sep 2026 13:52:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 276F132F
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D4F5606CA
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLT6p-ecyC0D for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:52:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4BF4560623
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790344340;
 b=D10tNA3jFMnVPS51b9v/D0s1ao7m2M2WNrd4PzD+WfHMjSv+NPPA+mngA2UHLELvJFEU
 M8BkqFSEdGVSuupBn7ijunxGz7TTlTNrRE4k6pYtzoUfwCJS467bWX/gNnmHB9gbvbEaJ
 nwAC110vv59xXZKsrB1GwBYjvJJ8b4CpdB6YcYjRmOpMQztY+h6QwunnZ7zp4s+ZIo5Um
 bYzqT/zCkQEmWUpDN8mfexHnJeKDCIQfus7if01Uq/fW6/X0m+05zueRecVjiAVvFp6Vx
 1UBc3HUx1wFGJp4xCrRzob5Kv+kvQ2nn6OlMqxV8IYvZJazmdvfbUA6gfV6UvOp/S9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790344340;
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
 bh=vmq1gfc6f6bAAqotoG17OHPk3zCxS2y4NJJnHtr0kNg=;
 b=bmIVR4EmChgpXTLatx0E30odihVLEY2vRbD6jg9v6uNMmQSV0do+c5dT3fCr66Gp4j+P
 FgMOy/FOggQpXex/O7gM39WrPye9+SDdLKOg8B47x+gkjaPCS46a0cE9uT9bEoZGbeqep
 wfLJXlYe3CYttj7V27dqb0umO5jYc3aHfh8kmYZd7E5sjW7lhbDu/PIICX8JcWVeo/8aA
 q8rEx6a5ptAiW+dusBo9TO6CdZJksOLEnk3AdJP4AOGOJv4L+0KlDAqMF1Jg10vMRqdec
 xjYO/HaQq/U4dvBU7AFPSDQ1ZKIXslyVv9CpBDeMiqY5Pxbn6k9NrC6g36wCrYPdCEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="Q8pkR8+/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Q8pkR8+/
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BF4560623
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7hVr7txh1FZgWpm5c/EGVkr5aYxlZ/ctiKPmbzK1teDj2Hi9Flq8raypa9aTFRDWs+jmcZ1roXw4ifnOwQ7jTVCoL/o2EMt9Lp8m5MRm/dcZ3kOzzNnii0ZKDKknxOH9XQsEbsowyiUjCBEWyIek/Qh5dzFDaVGPY6IUkcvPwpRH86F2EwjwSMPc82c6apTyLDhr5t0KeOwVRXG5SEgt+X3bHtdRKxw0Nkh6UOAf342OKAMsLLB0tvlgfYTJQQMRvoU5USLA4I55oSoc9Mzjlshm531H0P2HLCeRtdgLdUCYNVMXfsq4sL7iVLHqE24db4tz5Z7Ad53OYY7z3K/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmq1gfc6f6bAAqotoG17OHPk3zCxS2y4NJJnHtr0kNg=;
 b=bNwDF40u+zvPue0Ng4DOfqRR6DdqpYqU3xw5I/knSVAx0TVttMIJPjglC09Z9m5RPUPs+Q1pKtJ/OFnFo5w2RSLmdH0VHIwWBdu7cP2qPIys4U/A960QLovS57X15S7NmA+BmnKAr/ZXB7y+J66mgi5s450b37t1lJWPIQewga0/UeYHqihXim/YDoR1IAs1IbkB3tYB1Pk5iYunMvZ0o0w7GfsSEXlZOhcZqAGOnPzqrptHxLRmt/TkZVSYOoiGNY4hxbreKJorEaTeLLynP45ch95zWGMHESERqkpkznHEke20EJ4wfkwvPLoejsWjEHI3mXTDf3H+xE5bbiFoUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmq1gfc6f6bAAqotoG17OHPk3zCxS2y4NJJnHtr0kNg=;
 b=Q8pkR8+/GLyHLdGTiRZXpRH4M2Lx3Kn9vFCojXpvAHMVKc6gTjMpWrhTluicMG3KCFdBDBTPWU5G1/DA5P1W+EJscQh30OtqrkOFm8SYlY6fPETac5k7oGK9ekbIJSAchoUZQ56tvk03bj6LB9ZMRELZGqBz/tp+XlUyNk3BJZo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:52:11 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:52:11 +0000
Message-ID: <84191007-befe-403f-b31f-f857160287bd@amd.com>
Date: Fri, 25 Sep 2026 15:51:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] board: xilinx: board_name_decode() allocation fix
 and weak ft_board_setup()
To: Sriram Sriram <sriramsriram@linux.microsoft.com>,
 u-boot@lists.u-boot-project.org
Cc: Michal Simek <monstr@monstr.eu>, Maarten Brock <Maarten.Brock@sttls.nl>,
 Tom Rini <trini@konsulko.com>, Drew Kluemke <ankluemk@microsoft.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260916173611.29425-1-sriramsriram@linux.microsoft.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260916173611.29425-1-sriramsriram@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0033.eurprd03.prod.outlook.com
 (2603:10a6:803:118::22) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c6bec12-a183-4a80-1fe1-08df1b0c32d2
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YPWMrryE1yXFYUeO8bQaFQEsDq7FVZT4ea6/v64s3tf6W40GqYX+oVgPZj7peJuSWdjrviGOJYzLAdV39ngBojIXL6HjExvfE4EssH1m4UrRqrqXOzv2vXJL+kzaSOIHTvOlAMe9teNP0OKrVqBvYNIlL7ptYiTykn1y6jZjj8m7XsuXa1yWzZ5tKg22BXCeYHiax6ILubc5OePvkQ07Hbj2IE/EFGLpGefIn5EK3BF0fYsNCs2YZjX1x8GUvFErEV2S9JL6F0X6fURkjeUVrSD06MR0fRnym2xbU4+U1nZ6IRiYKe+HglEyjUzg+VF/a9VZna5YLFW6I4J6DqjRe5t1ImYbLWsthPtG0Byd6mpP+2uyb1pWhAa0yikGTyaK/iCgbT6lBbmSqIWzoQxbeGWZkGrGpOIRaWUrF/mUuQXwxPC8fMsKDLFLKPRJdopwBYoSTjIO9JzzZYDXvmq5tNht62YBaYqdYG47wvuBx5ERz+T5DEMzY1Rs/Z55QUMBGzmvcC9G98uVgN9zX7BAPb5IYup2yTCSsBiVZLUGOur8anAvDijdFhlCYcNQYis/SLiTYVnzGIg3aYq9SUeEmEVkVaVYXjP/JHWZcYrwVBtVk0NGX/tw2b3k2QfHc5QMadNqxX2+5oDtKypgflMua/Q4i/MUNnuCFrP94pIyaaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2NUUVI1SW1YbTl5UGNzbzFvV1VwVEphemZsSm50YXZXZ3IyY2dnRytKbnpW?=
 =?utf-8?B?VUdZQ3J6VitDTVpBa1QzaHR5bXV1S0w5QlE2c2V1bzN3Q09mNFdyZ2Y1Tm1Q?=
 =?utf-8?B?K0VSUHZXY1BSYXExNVVaZ041aGo2OExpblNzY1VMbkRKZWhlSlNudEZjUldJ?=
 =?utf-8?B?eWtGT0tDQzN4cEk0OHpnUjVoSXo5c0NiYWcrTXZXZWZXRGdONkVmK2I2TTlJ?=
 =?utf-8?B?Y1BFRjRjbEFGcG13VW1IQ0lvMXdITmFxV3l3R2JXd012Y2dDQ2QzZUxkeVEx?=
 =?utf-8?B?OFRjNmxaT2NESm5SNVpjNnMzWEoyQm9Ydzkrc2FYZnRETGtaSmpjTHBjQlZB?=
 =?utf-8?B?U2JDc0JLclYzTWFieHg3TG5SR0dMRmJuam9ZZHJzV2lSNENObFFhZzVuOVdT?=
 =?utf-8?B?S2IvYnRWdUl4RTNXMnk1b2ZSMGxiMHcwMHFMem4ydjB5Zkx2U0RGVkdyRkFG?=
 =?utf-8?B?UDFRS3RMdndWdy9XU3Y1QXJSWmMxdEFBVXFIelk1dGFadjNxL1NoWlJ6UWJv?=
 =?utf-8?B?a2QxeDZ3VFdlV3YycEg5QWJWWktCNmFBUkdDWENaSk5STzVqOUo1a0llQVJw?=
 =?utf-8?B?UHJNa2l3TFc1aEFjMENxNytkNWdieXNidVBQR25Uem5zaHEzNDIrbHdqNkN5?=
 =?utf-8?B?M3ZLOGZPRUZLaURLRVU5YURHOWkxYXpuWEs2Vmo5THpiVU1sTlBrdXU1UTJV?=
 =?utf-8?B?SmgxVEZWZTR3NmlaSmF2RkU5VEc3cS9LREI5RHdNR21jbGNQME16blhOdUht?=
 =?utf-8?B?WnBCdW9WTEpEdHVnYzBrSE5NdW5CVW5wRG9PSk5xd215UFlZQ1RWSTlTZCtT?=
 =?utf-8?B?bjVBSVpMMFYyRk1DZ2RzQUs2ZXdEK1BwVWttUWQxSjR2NWxnRDhJNHg0UDRP?=
 =?utf-8?B?ZlYwTmJYZkF3djZHK1Q0bVdIVERYanpjOVJoU1dtRzdIc3ZIQ3Iyb3UyRmNQ?=
 =?utf-8?B?bndxcjRKdEVGdVVsZjZzSzNiZ1NPb0ozbFNidklZOGppbWVEZTREOXY1NDFo?=
 =?utf-8?B?VHlzSHZ5eUFFMGdyQ3czckxrbzdMaHBXcDN4VS9zVFh4N21uS1RoR1ZIdGpz?=
 =?utf-8?B?aWkvYk9yTkRhTVZFTjA0c0dBbGlEQzVXT3B4T2hhaVVYTGQrclM2OHdjci8z?=
 =?utf-8?B?NjUzVzhmUkh5S1Z1dUZaNkxFL3ZqcWNJbGxCQVhjYnArS0tSZjNJaXpwMzZ2?=
 =?utf-8?B?VnJwczJzaWFGUE1OYlg5Zjc1czJNZE1tbjhRVzM1aGJEZkltOWtVZEZmclg5?=
 =?utf-8?B?NjV4YUg4NThLYlYyWjR6VjNvUEF3clJPMGVQVVRHUm95WHN2VVRQU0doYTNO?=
 =?utf-8?B?angwcDFWUkh0NThzRURwS0xKeWZ6TG00bFREQ0Mvekh5bHJINXpRaXhsOW90?=
 =?utf-8?B?bHNzcVhkY3J1bDZXemE4T0V2c2FidlZ2a1ZkeCtPTEZacWt2SVNPbFFkSzFB?=
 =?utf-8?B?UHhzY283VkpOQ2RIU3NRK0d5WmdMU1NValFvV3N1SmYwbUFYanY5OTB2YjBl?=
 =?utf-8?B?bnhqazF0WEZWUDZLOUhhQjdNWGdlWHE5TCtyeWg3cWEwREpHUHRoem52dU4x?=
 =?utf-8?B?THMzeDBFbkwrY3BISVllNWo5eTBxRjgwY2ZHenpacTY3SWZHaE5yWFljaThj?=
 =?utf-8?B?aTBxeUNtZkRxRzZqME9ISlBHVHdaWmFEeTRwN3FqRmY0RzVHS0FFU2c3SXdl?=
 =?utf-8?B?dTdpUTBqZnJkMUhnZWoxTUptbjVNWWNTUm9INHdGL0lHZUM1aXd4YzErMER0?=
 =?utf-8?B?em9zT0tML096ZDN0L3h4ZE5ScEFSYTVUemd4bW0wQUsxeXBrMmxVTy9nQ09Q?=
 =?utf-8?B?RjE0N0d6cXl0RmJzQ1NIemF0V0kvSmtoc01tVDY5a0cyMmRXZDRhQit6N20x?=
 =?utf-8?B?cUZwUjVjcTdPUFVOdEU1Q3FaVVhSMGJ6TFRsZFdsQ0x3OCtZRjZwMEFGK0Rm?=
 =?utf-8?B?MURXMHRLa3h2VmE3WDBNeVozbmc3RHNoN0g1eXlyMThHdk1GU2hBZ1h2Uk1r?=
 =?utf-8?B?dXJzbHU2M2F1eW1qS2E5TmFtU1lxemwra3c3RjREcmpjT2Z4NHpyNktiSEE0?=
 =?utf-8?B?WXRKMUhZaHZCSDJNRFNmcExTZ3lEREsxUytKb1RKZUlaYXRRUU55cVA2OGZq?=
 =?utf-8?B?QUNpbnRJZmhmRnpmTXpCVlQwSm81UitGdmNEL1FPOHRVelZJMFpBQTRmNXVB?=
 =?utf-8?B?QmhLVzZRVVRteEVCNGl3Sm1UUTJDTWw3YmEyTHEyWVFsZHJvTXlvRzM0eGFV?=
 =?utf-8?B?ZVhJeExTNTJPSytaUW5sdVZoalA5K1c2ZmNISCtrRC9jcWRLYUZoWkVWbEcy?=
 =?utf-8?B?d2h2aXM3Y3lka2prTkJ3TmwzTlRVUTUwMTZ3Vy96TGw2RWZHTENuUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c6bec12-a183-4a80-1fe1-08df1b0c32d2
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:52:11.6684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sc0WNhd9dHZ2n0fOJ0cIcCmPjatpfTjDlbBL6L76BueW8TteSYl5x4r9ZBPAYtH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
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



On 9/16/26 19:36, Sriram Sriram wrote:
> v1 1/2 ("board: xilinx: Use strlcat() in board_name_decode()") is dropped
> from this series in favour of Pranav Tilak's patch, which fixes the same
> heap overflow without the extra strlen().
> 
> It is replaced here by a separate defect in the same function that
> neither version of the strlcat() conversion touches: the calloc() result
> is never checked (the test is on board_info), and that early return is
> the one exit path that does not free board_local_name.
> 
> 2/2 is unchanged from v1 and is resent per Michal's request.
> 
> Sriram Sriram (2):
>    board: xilinx: Check calloc() result in board_name_decode()
>    board: xilinx: Make ft_board_setup() weak
> 
>   board/xilinx/common/board.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 

Applied.
M
