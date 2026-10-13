Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15867CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0AE8406D1;
	Tue, 13 Oct 2026 08:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZrTgEqckjzA; Tue, 13 Oct 2026 08:38:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 42B2C406C6
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791880729;
	b=A8tnsUJj4E/JwB0xTBLQ8vO0AI8igfSqp1/5CQaO/SKSPI8itIptFEcq7aMOtAkodmj1
	 B/8KYomQ1KrbWEMmQ5HqvjHAVHUijThmRebdmcT1RCYAcYDW3B2eQ05LkD+05Vv7Ntjmp
	 G0sjLccG4nDCSdqZuYDzN7dXDqfNFipqg0JBEL3qVlMiVi60stNNcNGTksvZT8LLwGPDV
	 OWgjwUiVqMnJbR77G7nXbI7yPdz1zZOQOueog4Nx840pqhEVGvdjzb8wkNdEviqFUt0Xt
	 MRlDx/H4lys5KKlKsQa9ZneveJFexbAtvoG3N4bRnO7SCxMYINJSF0Am/XqLdNByy7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791880729;
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
	bh=S6+bxpZKfDFfqVYtkkAY5YPnDeYRNyqukQw945CNxAk=;
	b=PjhdwY2CB6oNchdCFnVRvt0dJQxh2H4a4JTrkVaUUgZ/4ZNZRT+m9u0BsDMw6mwIRnjg
	 A27TRHsf/T1EG9Lak9Y5WDL7iIer3tbQut+cbCgDimdlrbA4wdErBrat4Z1lZPTSBptu/
	 3cfAx/DFJblFszPTsplviCsW4ofk1yi6z446etJ1Gg2JJATGteOO4XugmK7A8T3bQakdt
	 YmnarNW4UJdzaw30c5P+O2dKakpuVZ9/MSHLTbUzlagQZNEv2QbRUiXNpurg1ulBvVOf1
	 nQz5OI5PJKawHIDIQFJ8j6nItQ5oL0xWmd1VPQ1to6CFTd4+jNv0BTvRC0UAEQi5Hkg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791880729;
	bh=S6+bxpZKfDFfqVYtkkAY5YPnDeYRNyqukQw945CNxAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eHAZ75ZPsE6xIL4uAOYY3iss3KZ0QQpumgHsJ1nJauZhu6QKlEv9S5hHfehW3cD37
	 R8VFOXdAKUdI+QtvU6LimV1ZN99iQU8MmYAue4h8FFc3Iv+K3xYwFV00+rCEObxSbq
	 /ehpLqnUAur5g0Yq/CDjbK9SbKFBiEjwOs/zs2LBiLOKvGZ7TnhDB450A1uqB0hxlI
	 P82RwD/QCI0VnaLV+rTGHkFjziOXxocqqZA/Q7KRBZWN3x26R0agRRpzXCZ0X95bq7
	 zznqZlWs8QdPAn5+Y1RL0nVColq7XvoTR+4pZ5C8CYeld8QrPIZ5EjdoEsoj9shnMQ
	 hFj4UnK+KjD1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42B2C406C6;
	Tue, 13 Oct 2026 08:38:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E985105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E424980935
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:38:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wd7p8IGFHUA6 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:38:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E36ED808C4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791880727;
 b=CCBOPSku0wYvWg2w3nzM/Cn27VVr8yJyHWjuI/TCcDtbKCDt8dwfoCQAm6a6s7hjqzbu
 76JYZnGKHxeZlPXc48lwbrWjF5aaSGdk41WbfS4s0ApWdOy6WIotf/hFmuq81fHqtZfNo
 iQLR7l5AXTjq80zWXVr/10EioaJCuFDmQtMMyQzpRMVG6RlQxYa07VAvLSk+Rp37kUWfz
 DhFuBJVi+vPYGYPYsNtezMuGEeQv6k7v0s5P+pzvJJljEQ8jebEXBDrV/2QMwTVvXEs/B
 1SQnv90fXBexJIz7NaAJlObl+jmo2edeo0jGrhXblTletTfUHh1oDy1lIGFcA0jtMLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791880727;
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
 bh=S6+bxpZKfDFfqVYtkkAY5YPnDeYRNyqukQw945CNxAk=;
 b=CIVZHHKEGupStk3UJHnkUJxmYLJZ+ZHxXZPnAdQ+geb/O8PSl0LUwUuWhHIDhA3xaFhF
 QCLKZuk5OjaGH1oVcQtoAA1yfybz6f38cLzvQKZ1c2DQ0TW0PFETdYKBcRPZxw+UfD2RE
 1t4ff+9TUr+IQPkS8UgJUWoajC+PmW15RoHBPQjOrLl2053oh6JrJWU2MI/iz6Zho8ewN
 CGHin3Nm568iSiQvqyz7+u9kS+00LU8VBm0h2J8/ySpa/t6eNo+OD86luiKLB99VgWe0Z
 9A9fww6njHpXzxsGGrPozmL0crMv/Ru9tw5W2e6qRyo7rHAxs6iD24ASu3uY9Dxh/Yg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=J53i9H8p; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::5;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=J53i9H8p
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E36ED808C4
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLcZwkUf6cYkIVutaDVP9UQFV1MunZCxRT2+htcn/XRj3ZfZizj02vO6v5WDU7SPF8tRho7DkbvOaAcvMXJ7sk1apbakpRVujj2XlYcqFERhJd4yonMKInk0iTxwCjGdtxLJwJVKFRNu977/G/dbipO9P3iMQZFCcdBUw8QtoTd6uwv5Ihmu5RybT8oynG98BOTq3MJQ+2SmY3z7HF9oJbfobm2D90k/MNsU6GRcHRDBZS9JcQ28eY9DZpS6Dqme0FFvHSxMYWc7dTCPIZnzfmOH4DOCpu41ojZJ7qgZJfcSSyo8bTtX4RVNWYCQvLqLwbRo8KbathHNwLjWM/lUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6+bxpZKfDFfqVYtkkAY5YPnDeYRNyqukQw945CNxAk=;
 b=yJ7TEhbVmzU1WvjwWc3c2+T/045U8M3ItJRJqMon3J2sSWys0i/psFqODteCVS86TKsG9lyqNpyhV6bZvbXvKQsRlceE5bFOKBsYTXSrp47YOGNsLyUPXHoue1ATHgqJMl4ZCJHjwVSQ466iSyzP1BqqbVFQISJ7HXskHDJTyMKZb+FSnhduyC2G9U8pAX4+Fch7yOfhtsmM/6n26awDPWTRE58hOVSEdpoDCA+d3nZ1Bn8fU6ADD0mPFc0anAIqxHC7fBXKHhsmiXLnancl3Rme9SXn/Z/T8Dy+fbxOLTfyHXxk3S6bB1PLkSmU2d53gttyP2VboUIy76MyLOhj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6+bxpZKfDFfqVYtkkAY5YPnDeYRNyqukQw945CNxAk=;
 b=J53i9H8phDUbNno5XYebq467vz6kmah3gxim/DJyczyjpW6RZLk75auoWZPwlUwvYWmX10mcUZCOEiZgJJPyNXrTWdKa6OMXYYPUEXS1UfNotkdELD3KDBBWdunq+FbuQFQOINNtk8n+4iAtoz59qjvzI1tf5C98deWgkGU4XIk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 13 Oct
 2026 08:38:39 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 08:38:39 +0000
Message-ID: <35349d86-f7f5-4f13-aaa2-f4b8c9a1d166@amd.com>
Date: Tue, 13 Oct 2026 10:38:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] xilinx: Use CONFIG_TPM_AUTOSTART on Kria
To: Michael Haener <michael.haener@siemens.com>,
 u-boot@lists.u-boot-project.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20261006155217.187050-1-michael.haener@siemens.com>
 <20261008215518.209510-1-michael.haener@siemens.com>
 <20261008215518.209510-4-michael.haener@siemens.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261008215518.209510-4-michael.haener@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0047.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::7) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 617c6368-311c-43d0-a643-08df290560f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info: 7hmecKwwGLtdpjxYbm8U0RMYBrwpqUhP4+HcuFh5jB68vIfMSTIWWKdN0HRXr19ADGg+RXVF6pNawEcw87I32euaWOXxUSAF7iBWWESu7sUy6x4o8CpGnHd53H2rs7XjSJYK0Ol6+ZB0nZ95Kl/aMb3SAl/Tek2xBgVzZ0DGSJr6GBZavAmnfKjT7PNsS7ntiMuCxfvyjFKTBg8GuBMOrFhy/S461XtE6P+sooEfN8Mc9mhrUbm/PhyVUZSd4x3ORXo/HN7twV1Cu/RODubrpoT5BPojbmbHcGoCWAvuJHJkprE+Wx6m9TwV+UD75mHbpXpQSbdOqq5QI0SB6e32TlKSXuI2WTjorgfGjNiZVkVK2OUdQQzwmXW34DZmbSNSekg4PlLNP8fV3w1Wml8RPcLeyZICnMvbQMt3xTMxMegC4GP5DTsON7B0Qf1ROIh2GfTZp3iibFAiZ93Cy8LyEo2jEQO6/ec5kFExQaI6Mny+Ued/zllMPViYo++f/0/BYrS8okg6bv+hXzoEH72Ib2N1KLDxstx2VqqhPBhApjys698XVLMLTJRTVuFRXtikomsY0vGXFA/ViFotgvfXv0+HjD/7rqRS/zSBf/AmZNNlrAJhdI6uP6QCTkYTUvO1GWptbVzkSdHmoLDEiOhyIHnoA/NLQ5QQAeX6jPQhDQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lzg1KzVhYnhlTWlMdStmN2lKK01EellUeTFXT0ZJSTI5OGxMQXpPaXFiaHhQ?=
 =?utf-8?B?Y0w3MWdBdmRsK1paaUZvbVAzOGNMV2xVcXkxNTNORFA2N2ZqbWtCUVFYRDhX?=
 =?utf-8?B?MEkzSHBiOFV2cGR2ejZnK1BmTitabUpLTFovWFUzRlBiV09vN3V1WDNxQita?=
 =?utf-8?B?SDJ0bnUyN0pLMk9DVVJFRkJmZ3FITTYyai94U1poTmRyYmk5WHdtS3JrMlcy?=
 =?utf-8?B?cGJZRHhlUWlObW1JeVhDdVZQMTc3cXhFYkhHbkNjSTNLR1JIQitqOGpTYXh5?=
 =?utf-8?B?ejdWaStMZnpyYmVwSFFab1ZzT2M2eExJVENLb3AvUkwraXJ4aStoVzBCZFFY?=
 =?utf-8?B?UU5nbTBTV0xRL0hzdW13MVh5NmlGajZtVlVIZUhyZGZkcTFoZzNMbHNjZUZa?=
 =?utf-8?B?UlhXQjV5RWd0MERUN3ZGRTNyWTZubTJXL0x4MVB6ODRDTkc5Wjg5VTNwbXY5?=
 =?utf-8?B?MmRwaTA2V3lIQWlsZ3hUdGluTXNwMU5mRi9TR2ROTzBFU2N6cjFEdXFWMEg1?=
 =?utf-8?B?YkplZHQ2NmVNN3BabFFFYUZsYmM2YUdnYURFMDY4S25iY29wbFhydnhuSnNh?=
 =?utf-8?B?dDBOT1BiUTZtZGI1YTZVdWhVbERydE1vZ09ZY3NUTC80Qkt3R25RbkY2R3R3?=
 =?utf-8?B?cTUyY3h4Y1RienhtckpkdytUYVllVzVzSFIyeWVDTlBWR2VPc0VDaW5HTFNQ?=
 =?utf-8?B?ekt5QmR2dUpIYU00dE9BdlZLVlJxblpoZXk4K0FyZmQ5NktVb041dHBITVVG?=
 =?utf-8?B?OWtCZEFhdUIyVHRDUTFBUURrTjlPVS8xLzdIZy9GSWl4Qk9YVzd2UFRsTFU5?=
 =?utf-8?B?ZHBSdjlPeFV4dDBvbks2OUM1dnRvei9laTJXZFkrY0N0WVN4ZVh2NEExMjBm?=
 =?utf-8?B?dVhUWGdGYUZMK0JtRTRaWElVUEFpa0ZwMW9nZllOSTNQNHBNRzQzeEZpNzRv?=
 =?utf-8?B?TU5saURTeXhscEpoMmtOU2o4T01mQXN1UzBIL2JLWjBwOWV3b2dRbkVLeCtX?=
 =?utf-8?B?MTFFeEMwaHVHYWZKcnZpalJyRGpsSmg3bFhJOXdvV2xVVU9menFyOTZFWUtl?=
 =?utf-8?B?NDFCS2YyeEJRQ2xLaHlNZ2JOcGRNNjU3dFRzUGxFQUpZZFFqOXBoZEFBR0Ft?=
 =?utf-8?B?dFlnbjQ3SWhwaXl5WlZwbkt6TDh6aURlenpkWU1oOGlmc2pGODFkcThiZUFU?=
 =?utf-8?B?R1A1a21vNXhvSzR3UTlWeHk2NEFsMWpxL0tLeDhaQ09UZSt2bXU3SG5IU05F?=
 =?utf-8?B?dXJCL29NVzQrblJhZW9yMFNQRzlhMldBb1J0M1h6Sk5iWGFWaElEZ3FJWTdT?=
 =?utf-8?B?TzhCSXNWelNwT2F2K2NNRlQwZ00xM0RxRTc1cko0YUd6YktYaklrV1lXakVv?=
 =?utf-8?B?M0NqSjVGc2RWVjlkY1BIcElOeEZDb05zR0hOZ1ZZc1dzZzVCY3lrZ3NNa1Ex?=
 =?utf-8?B?T3psVVRHY2wwMG9DbkNubW1ranZyWXVSaDJGNkllQlo1d0xFeWs2MzN0Q2FF?=
 =?utf-8?B?dUFwWWlJZllaeTZYblBzRkRCNkw4aHVaTDNaQUFhNDFYb3lCcW9SdjdMVFU3?=
 =?utf-8?B?TktnbUNUYTVIdzNSOWFPeDRaVDNOSmVZYnFhNGEwNnA2QUpEQ3l1NHdzamZ3?=
 =?utf-8?B?OVBjUzd6YXlYUjlPaXc4TjNERG1ORHFmYXdZcUwrT1Fpb0MvR0NOS0o2cERX?=
 =?utf-8?B?MFlPUDhCdFRHQ09sVzlSb0JRa1RPRC8yUmduUEh5OVFaWkJPeUUwQWVvMzlT?=
 =?utf-8?B?aTRLZ2tla3dFRHNRTUNJV25ENlFxQ2RHYzZOUURkelVVTkh2YVdDYlFKa1h5?=
 =?utf-8?B?WlVQWlZ5YUJ4aFRhNTc3VFptejRzTnBDUGlVOVUzZjFZQVZmZy9yT0JmWkFS?=
 =?utf-8?B?QkRMaERnTnRmTG9PVjFZTlYzU2lUVWRzejgwTjlBSzZvT082ay9LQVphVHAv?=
 =?utf-8?B?c2NqZEVMcFhUMEV4WWkycUJmK1hqMm1YZXg0c0pWN3Zaa3VRWjg0V2J5Sk9Q?=
 =?utf-8?B?aEQ5MEpncVlCZE5Ib2xoNmNiK3BERkNYS0h3bXdlMFh6NVJYWW9RaGR1K0gx?=
 =?utf-8?B?eVpGd0wybU9Tbkdjd2JHQ0VZWlM4MlpGMEE2SnAzVndMd0ZLVWdZVjVEamE4?=
 =?utf-8?B?Q2s0ZkNlb1A3UkdSUytNQ0dnUnM4dW5RSWpBZi9XL3FuQ2JOTDFFUXJRTUQ3?=
 =?utf-8?B?ZVNzaXljczhhS1ZoQVprRzBEaVdiMTdMeTRvd0x5aXpkVktkUUQ3QzAzS0JS?=
 =?utf-8?B?OTFDNHBvaEErc0w0WXh2ZjNIcjZxQTliL3hDeWlNNE92ejJMY3E1bVE3WktH?=
 =?utf-8?B?d3ZMamFQWnN5Z1lCSEJsZGl2SlVVdlJDRjZzczMzMVdpVUNnWEZsZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 617c6368-311c-43d0-a643-08df290560f8
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:38:38.9769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAI4XucSXv7407EZKGnfRMT9nm/+nAS6zjwbcJp9d9zrfJ2urBdpQqcJOoZ2Daco
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
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



On 10/8/26 23:55, Michael Haener wrote:
> The Kria boards start the TPM with a 'tpm autostart' call in the board
> environment. Enable CONFIG_TPM_AUTOSTART instead and drop tpm_setup from
> the environment, so the TPM is started even when the preboot script is
> changed or skipped.
> 
> The TPM is now started before preboot, so the TPM reset hints for some
> carrier card revisions are printed after the startup. Boards which still
> have the old environment saved run 'tpm autostart' a second time, which
> is harmless.
> 
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes in v4:
> - Add Reviewed-by from Ilias
> 
> Changes in v3:
> - New patch
> 
>   board/xilinx/zynqmp/zynqmp_kria.env  | 4 +---
>   configs/xilinx_zynqmp_kria_defconfig | 1 +
>   2 files changed, 2 insertions(+), 3 deletions(-)
Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
