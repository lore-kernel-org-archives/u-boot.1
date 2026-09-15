Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD99C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 10:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51D2D60731;
	Tue, 15 Sep 2026 10:10:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MVTPu3lSx-uz; Tue, 15 Sep 2026 10:10:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4F7B760681
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789467041;
	b=VcHwezw05tC6YiOkp22QTQFqqchPH4cXuM7fiX4O1IBdROJuHq/DqnbjgX1kC3XXtgXb
	 +kb189AA8QWNB4TpNyQklnil8z0CWwtZRow4Thgh4WJottnhY3Pkn3bqWVy0xzYm0jzwR
	 xu9pmuKvP1xRB/iSin7NehA460YQEWEFartooyJ9BBF9Cqlo7dm9NaQFtnMwwfj1bWDQ9
	 Ha+jRDcIb39U0xinK/NI4h4s3qRpWDVDjrcPiY8WIhSDQ/LYSzx397xzOT4MSShFCwOij
	 Trb4rxrEgPJB5MutziHUwQQ9Mpjb5WTBep/gZU4isGB26PD4Janr0eNbRrK69SqrMtA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789467041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	bh=6gWvA5W1PD47Nvp9DgVEZ1JiSN25vDzCF8ULjDAOBKA=;
	b=H0mgfqbJH44WnYHNHb/EMrHqE9+H0DUEYwC5vtFem0nONtFL5lAPx7t/biJxSVyOo3k4
	 /AjresHcnaFEy/gG4nshaj3R6ClH7+ooGhW9rJJAutxXnw0nX6E1kEvkJmDKFsRdGwOTm
	 axnGq/5TOjC63itSo+1ik89aVkZtfY8suBAnBJjvALYY79CMCfKg3AH5itHmesc7/+VGK
	 PwojvBfj2Qm33q/AKEBYQc8BFDLT2WI0OXyEzIkEMXKDqbteiZLtLpDy2ns6NwEUbSk6u
	 ZsBCy9drWtQNYKT/X9nbKYLd4O4xMmUSu+tu80pBOsu27rY9c+yBLr2gSni7GSMZapw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Hf47l8BN;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789467041;
	bh=6gWvA5W1PD47Nvp9DgVEZ1JiSN25vDzCF8ULjDAOBKA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q2tofN3XCSCakxf+K3BaegIlKRtTOPIpiibE4TMJCzxrnci1nhlRoAqrtsTwwQjyo
	 uqFHft7xEyFB0ftwL4+dg8gMjbr+uHZd5YUx0Arg6ToyOqNin8jG8dNeynVpua1Tyr
	 waIm+kS7I09XCkretkPM+rDZZ5AKV+Grs2DGcaKJJriuYaID8tIkdtqCqDrn9pgySq
	 KTdnlXeRaWevdPQts90ompz8A0iL2710TSgyQjOvOU8lxPK/IZOFuwPyVULTDXYP6k
	 mlBDYBQEqyql5crt8FwIz+uwTNLD7VfqqwnieqG6bcSWRUivzBJMczFFUVGQBlrpul
	 e9L3SOQmJ16wQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F7B760681;
	Tue, 15 Sep 2026 10:10:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DA75A259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C37B060681
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:10:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D94yFlvYJuew for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 10:10:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 405C6605DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789467038;
 b=PquI348tR4lXu6atZwFRydKZWajNSIMHsAga4vQJqTV6IITAZlsL95oLXzAiT+PIiK1a
 90AcpwkoQfF8OUROkQs/rJetR0UAszyUJybYdSYUFVZyDR3h9r6zrPT2PL+0Wc7PdcDi+
 5yR+h1K6TzeCzU/2OQHBtXffCKPb/QbIDNhVN7PwhKgd26t4vl68IgitIVahv10NnwZZU
 EhP3wPphUP6MAlLkDcRgf9x0BUdXKxv+dA8aTscfTmR5jati0VRegQib59Xbvq9EWeiuS
 mZP2uSFnUg36KeJWc4MWS7mSGQWG1sBuTZ6AnpR6pgKrO4rLK8PKCsy5x8WSxMnnVyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789467038;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:References:Content-Language:From:Autocrypt:
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
 bh=6gWvA5W1PD47Nvp9DgVEZ1JiSN25vDzCF8ULjDAOBKA=;
 b=LwNN5PseDdeYiVYQ4uRou1Zwt9JH4O8z2c0LoJnX8Xb/mU2WdsYDpU0jIaaAD7kROImM
 up8W0YpY/Kd9uhrUVuJAQuu15EDKtFGYxkWk7mMhYW+n+dOhxyr9OC7s6XDi8L9lsRivs
 mbqY55m5GjBZsEGZysAm57060Ujbwl4pnLiCqfFoIW/xpoAO5cvYlErr7tuCB78zt3/Vx
 fQy4B2NeXgZ0AyMX42bD3IlxfipdG9ufPfimv9JD10JtdFiVhIrinxIpkSXVPU+uEX1xs
 tqi0oXKrHh2Vaw6F/WktpvI4SFemkU5pECEaS2R+CLYOKHhg8ki31XIaAOz0G5MEnWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Hf47l8BN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Hf47l8BN
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 405C6605DE
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 10:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H22LKNeeonQe4+HWHDys/YlU6W1pWxln8VlbqUMzFRkT4Gd3nw3pXQdAZR1yOzSMJhZmZyrP4/ZBFu083eHgqwUc+C441VOr4MvHTn0jbqJayKIwBMNA2FslaNqlMaO+ipWpOekRrTLyKAGlqnXP+nt2Jq9bCT06CBeYimOYULUEh8m6QsAipI1nw2M9xkkHXzYUK7B2vNlsKnGzeI/Dp1VAk4bL2jx/SUX70yvYjaU+S0na+Rc9gVFam21k7LFTnl2PpiM85SkFshhLqg2OIf93mvwC9AlhjH9w9t3P/Of7EbKycejIKIbCL3eOSEIfsGdRmhdcQMBQBXmmdCdImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gWvA5W1PD47Nvp9DgVEZ1JiSN25vDzCF8ULjDAOBKA=;
 b=pGvZz6d++Kl0fNp+6GZehM+3zERSWbSA2+lSPLQvzR/cBCT3zz7PVdWL/MXm3kpmbboSNgTFUabCyZVD1lhSb/otuhmwryTi0H3iw+KJ1ntITXubVYoOHXRufhwcNGg7DgHYOTe/TSMCcwE1hP02e9YCh/Ou14aWAXPUR3PpNeY3XEqK+i0wxx5AQ7gvjosyonAXDGnd/YSH7CG5BOU9QEAbyeK/fKWUkjmTWYo5aPNWCzQ+6XnT9Jf8LupDyZCCLE7TfmEA8ECSuxbvM9jk9jIzokjI/1SogJZW3iWSt3C2eypYCo2lnNyh7I8+IGmB4SWtCXSCRoCYKKPMVzz7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gWvA5W1PD47Nvp9DgVEZ1JiSN25vDzCF8ULjDAOBKA=;
 b=Hf47l8BN+BX0w2UdEFss6XWkzQsyHvS2MIdb+fva1RnxQpoZjg6TGhYmzvjHrRVAO4jOFW0uembVXf+DdJnOhEFSEEpP2f6EOyQnF2sFW0aVPxaR2xjQXdQ8vHvVjdmYXkn0pJXTQIUKJWTVUAVADr0xVwYfM5/p9Y46UFd2n/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB999103.namprd12.prod.outlook.com (2603:10b6:8:2fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 10:10:33 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 10:10:33 +0000
Message-ID: <dde2ebd2-fc2a-4ec3-9d94-67c6e199585c@amd.com>
Date: Tue, 15 Sep 2026 12:10:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mach-zynq: Support SPL boot from QSPI in memory-mapped
 mode
To: Mike Looijmans <mike.looijmans@topic.nl>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.dbc3adc1-d306-4fa6-89c4-2074e3ea28d1@emailsignatures365.codetwo.com>
 <20260915080242.81591-1-mike.looijmans@topic.nl>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260915080242.81591-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB999103:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5b3285-217f-47d0-8f70-08df13119472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: +I6tBemhuzorLwY7xhS9e9aQUM1XGHuzEnY/AsbWkI2E0H1bYunfzMpdv6ZgShF6OFy4NHP73WrtecCucqYygtZmnH0vxXCFd15rAZHaSg687F59ItFTCFF0OknWm8FDcUU37SYP4vWs0Xj/GOztdv9zXsiRu5/dQQJznkS7NE21kjmcigTOU+GM+cG+a/NtzfcK2DVeH8gGumCS89CWTYJfhYe8ZL8jhsejN8l4IOMm6Gjum7LtL2AtDvhaizts/RY+NHzzVLx69070w8e+wdBzVvlfA6yJ8iK5sPaT1fscEcAFfX5ww5Q/7PIH3Hg2zt1E34FR4PyLTQEREChF7bYJyRKiguqJ9VUwuu0J+5cVvDVzf+6Ju6WMA9U8MnwIyzLIw25TCQhf+4Bi4dbXCp9lsGr/6kjVhYF0yWoUTHa9Ks8c2vCTgRT9p+wb4YhCqo16mMikdcLdPWIgDRY3LQgirvUhfOTlDQlkBBVv0mrbkC1CtpNpx//OCFs39VCCpSo3WAujyowTLpCdeC/ak+sXzMU8kl/PP+5ih/tD06us62xk1s52Psp4JNV46yEWdI9ShLBiDDwQPE9d7B0nYqbZ2uGzQtyuSwBjrCDRB/RC4rA9U/ESjG7yXHjmsU4GkbpMWjSv2MBIvpVEwSbkXJe/T1+4mPLLVOhrbV78yfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmVsNlpWVzIzaEtsbTNjcENpZk9ndkhUeGdsYW83TDU3OWhWdWNYRmRVTlhi?=
 =?utf-8?B?aTVxaTZEYkN5eDdiL1JoaWtJUk5CU2hLNksyalo2UmFFU1E2d0Q1ZDBlZDFm?=
 =?utf-8?B?TTJZQURiWEhpb3piQ1ZpcEVKbE0wVEtzeVdCRWVkU2ZOU3NRVEZuNGdPNDBQ?=
 =?utf-8?B?L01mN3dDYUhmTC9tMUFJNUJRWWZYZTNHWkIxdnZlTnJpMVFLNG5kdEpibUp0?=
 =?utf-8?B?UzZnZ3hUbGk2WnJmTE5laXlEclM5S05KOThsODJBWmltRElnZnF2S3lvdFVO?=
 =?utf-8?B?S2ptSXdzbUtMc3J6OGRpMzdSaDZLMXhmRWMraDJqcVBOYmt3aVNweEJaZ3BX?=
 =?utf-8?B?RTlsRXNLQ1N4MzJrN0ZUTnB5ZDQ0enNnTzdVYTdBTlR3MklSMDJGWnYzNDVF?=
 =?utf-8?B?THZoOGNmcXJ4bjcxcFFCbjM3MHovNlNaS0toNXVyY3dKYnhrMkdRemE5blNR?=
 =?utf-8?B?Q2tZQzdmTEE2SUFKbm5IVDU1VWgzQXpTbFREUGcvOXdkMUZUZUlab2xJU2FR?=
 =?utf-8?B?bU01VFduN0xsZVR1RStadHFyOEcwa0c5THhDMGE2VEtZeThESWhzK1ArUGFS?=
 =?utf-8?B?bGt1QTZ6VmZta0ZaVHZRdlMxS0pDVjhIRUxpMi8yRTFuS2NYYjdVemxlVlRn?=
 =?utf-8?B?dVBsVDRIMG5yVUpESnFaODdhRkNvNVJyVklteGlMSEpkclJ1R0Q2RFF0bUJF?=
 =?utf-8?B?d3NSTE54cDAyVmhVVkd2NlhOQ2VlZVFYTjViMWxxdUcyRHlvYU1hOUJIM1Ry?=
 =?utf-8?B?aE5tbHlpd05nOFA4RXZTTXVVanp4TWlmMjVOcExmV1FpNktaVURVOUc5L1cv?=
 =?utf-8?B?T01kUm1RUDY0bW11TEQyYVdiT05JKzFOeTlwT1dBVlB3ZG45VWFwRWxObVRO?=
 =?utf-8?B?dnE1d1NLWHNEbjR3d3JNeFBqa0hGNHo5MkF2T2lmME9SQkREb2FjcVBsaVBQ?=
 =?utf-8?B?cDZqVWJFWWRVNWdidTJVY0ZrMXlGRWhoa01SWjFYOUg0eTV6c24rcm5iQXdz?=
 =?utf-8?B?SnA2ZENsRlN4WjFydnVqanJ6aDZ6dHV6aXpGQm44VVFGTDZaVVZQTzlibEJj?=
 =?utf-8?B?S3RRbmtiWUtKZllobTBpbWlxWjZaNVNEMWQ5RnovOHRmKzcwRHZPc2VOcDc4?=
 =?utf-8?B?OCt1Z0kyUUxWRW5BZVFMYi9Ra3ZMeXFMb3dGT1l2M01NSHZtRHFSVkltYW5x?=
 =?utf-8?B?S3RXVXFQcC9Qa1drTnozaGRZQjhIYVZDaFhZMGV3SVdKUmdwYmdObFY0d3hN?=
 =?utf-8?B?c2dsaEFpcTlZTFZSdHg1dFhWaVcrbk5xMjZuWjlQOS9IdGxPbnp6ZSs3NTg4?=
 =?utf-8?B?R2UrOGFUeElZenU1UkNLNkJRSjQwZkllbVE0WHpmN002T29henlveFhtaTVl?=
 =?utf-8?B?NzFmVU00ZDYwMEl5WmYvbnhHWERTaFNPWnRuNXhTR3RFQ0hqZFJUWW9Jcm5T?=
 =?utf-8?B?eVBXZlBEZXRSTlJWV1kxWkhIckZqaEtVTDBjWGNvaUhISzl5SE9VMGZQMzNT?=
 =?utf-8?B?WEN0b0NTUlZEcFQvZ3lGV0xvb1ZwZ1VzOE9kemx1cHRkeXA2M3Z4eVpOOXR6?=
 =?utf-8?B?cTVmOFV0Rm1FN1liRnVHd1lRNktwdXpPcGJUOXI0WDVic0RQekxUOUkwM1M2?=
 =?utf-8?B?OGpCZ3FLVkljRWlQRm5WYjVMV1BWais5Y2VON01SVS8xd0txNjBJSWtnWnMx?=
 =?utf-8?B?UjlxSHN6am55RUlXQ3lHVzhldWE5b3BtekhxN1pUeERsekhydnVVTHRiNTJa?=
 =?utf-8?B?OWhUVlhTUnJVWTFlUnhveU1XbGtYUlJ1ZTd3RS9FdnZtbTlTakZJVGRCQWtH?=
 =?utf-8?B?N3E3Yy9JOEZDQ2RTc2dnWlI2ZEMyQUhzTTc0M3E3Rno0NGpEeWxLU3dyZWNM?=
 =?utf-8?B?QW9lNE8wSmZHSlZyLzczWU1KdTYxVUxPTStNRHZVV3lqOE9nbHZFclpINklO?=
 =?utf-8?B?SGo1Y3h1WXRoUTlEczhXeTNzWkU1eUgwVjlKanF4b1RVaXN1TFFjbkJ3eU0z?=
 =?utf-8?B?U09DeStaVjhpTUFOdGZBN0xMcmdDTHovQm9xWldsSFo5Mm1EOWF1czFENDVI?=
 =?utf-8?B?UzlRejBaQkh4WUpTUnZjbnhBTDdRb3FVQVU0R2lFU056UWcrR3pOcXJYWUxL?=
 =?utf-8?B?L2tlb2E4TFdoa3NROWF3cTVtTlVDMlJqSE1VK2JTRUtQd1NIdGQ0WFVUUWFL?=
 =?utf-8?B?aUhhNDFxZWdoalptUEtwRlBaejR0b0p3OUxIWUJ6YVBjT2FPdmczK0FxM3E4?=
 =?utf-8?B?WVdXOVpUcG9wcGQ0UElMZVBxMktsY29ONFp3c1Z6dUh1cWZKNnJQNnF6M3Ba?=
 =?utf-8?Q?t49gaOE7uQDSpPjmzf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5b3285-217f-47d0-8f70-08df13119472
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 10:10:33.7164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H1isrI/nK4SJpGJyxlApjivUisaDM2C8sdyAUIi5r425ivxMV9k1J38/ZaRCgW3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999103
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

Hi Mike,

you are sending email to
u-boot@lists.denx.de

but you should be sending it here.
u-boot@lists.u-boot-project.org

On 9/15/26 10:02, Mike Looijmans wrote:
> When the Zynq boots from QSPI NOR flash, the ROM will have set up the
> QSPI NOR in linear mode, and the contents are now memory mapped (the first
> 16MB/32MB at least). All that needs to be done at this stage is to memcpy
> the u-boot code into DDR RAM. This is not only extremely simple, it's also
> the fastest method to read QSPI flash on this platform.
> This corresponds to a standard NOR boot, hence this mode is selected as
> SPL_NOR_SUPPORT.
> 
> Add a menu choice to select which method to use.
> 
> To boot from QSPI NOR, write "boot.bin" to offset 0 and write "u-boot.img"
> to offset CONFIG_SPL_PAD_TO in the flash. Usually CONFIG_SPL_PAD_TO will
> be 0x20000 as the SPL code easily fits in 128k. The offset must fit in the
> accessible range for linear mode, which is 16MB for single and 32MB for
> the dual chip modes.
> 

Also say that this limit is not checked yet.

> Tested on topic_miami boards.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
> Changes in v3:
> Make the QSPI NOR mode a menu choice as suggested by Michal Simek
> Obtain payload offset from device-tree config in spl_nor_get_uboot_base()
> 
> Changes in v2:
> Reworded and amended commit text
> Add #define for magic QSPI linear mode address
> Use old method by default, use SPL_NOR_SUPPORT to switch to mmap
> 
>   arch/arm/Kconfig              |  4 ----
>   arch/arm/mach-zynq/Kconfig    | 34 ++++++++++++++++++++++++++++++----
>   arch/arm/mach-zynq/spl.c      | 22 +++++++++++++++++++++-
>   include/configs/zynq-common.h |  3 +++
>   4 files changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 514bf2000b4..fa965125e80 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1346,8 +1346,6 @@ config ARCH_ZYNQ
>   	select SPL_SOC_INIT if SPL
>   	select SPL_CLK if SPL
>   	select SPL_DM if SPL
> -	select SPL_DM_SPI if SPL
> -	select SPL_DM_SPI_FLASH if SPL
>   	select SPL_OF_CONTROL if SPL
>   	select SPL_SEPARATE_BSS if SPL
>   	select SPL_TIMER if SPL
> @@ -1398,8 +1396,6 @@ config ARCH_ZYNQMP
>   	imply SPL_LIBGENERIC_SUPPORT if SPL
>   	imply SPL_MMC if SPL && MMC_SDHCI_ZYNQ
>   	imply SPL_SERIAL if SPL
> -	imply SPL_SPI if SPL && ZYNQ_QSPI
> -	imply SPL_SPI_FLASH_SUPPORT if SPL && ZYNQ_QSPI

Did you test it on ZynqMP too?

>   	select SPL_SEPARATE_BSS if SPL
>   	select SUPPORT_SPL
>   	imply ZYNQMP_IPI if DM_MAILBOX
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index c3f505fa15c..6167f5e51b4 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -18,11 +18,37 @@ config SPL_MMC
>   config SPL_SERIAL
>   	default y
>   
> -config SPL_SPI_FLASH_SUPPORT
> -	default y if ZYNQ_QSPI
> +choice
> +	prompt "SPL QSPI boot access method"
> +	depends on SPL && ZYNQ_QSPI


Likely not.

> +	default ZYNQ_SPL_QSPI_DM_SPI
> +	help
> +	  Select how to load u-boot.img (U-Boot proper) into memory from the SPL
> +	  loader when QSPI is the boot device.
> +
> +config ZYNQ_SPL_QSPI_DM_SPI
> +	bool "DM SPI-NOR framework"
> +	select SPL_DM_SPI
> +	select SPL_DM_SPI_FLASH
> +	select SPL_SPI
> +	select SPL_SPI_FLASH_SUPPORT
> +	help
> +	  Use the SPI-NOR drivers to transfer U-Boot proper into main memory
> +	  from the QSPI flash.
> +
> +config ZYNQ_SPL_QSPI_MMAP
> +	bool "Memory-mapped linear (NOR) mode"
> +	select SPL_NOR_SUPPORT
> +	help
> +	  When the Zynq boots from QSPI NOR flash, the ROM will have set up the
> +	  QSPI NOR in linear mode. This option just uses memcpy to transfer
> +	  U-Boot proper into main memory. This reduces the SPL size by about 12k
> +	  and is the fastest boot method. For this to work, u-boot.img must be
> +	  within the first 16MB at offset CONFIG_SPL_PAD_TO, or config value
> +	  "u-boot,spl-payload-offset" in the device-tree.
> +
> +endchoice
>   
> -config SPL_SPI
> -	default y if ZYNQ_QSPI
>   
>   config ZYNQ_DDRC_INIT
>   	bool "Zynq DDRC initialization"
> diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
> index dc964dc2f9f..534374078cb 100644
> --- a/arch/arm/mach-zynq/spl.c
> +++ b/arch/arm/mach-zynq/spl.c
> @@ -15,6 +15,8 @@
>   #include <asm/arch/sys_proto.h>
>   #include <asm/arch/ps7_init_gpl.h>
>   
> +#include <dm/ofnode.h>
> +
>   #if defined(CONFIG_DEBUG_UART_BOARD_INIT)
>   void board_debug_uart_init(void)
>   {
> @@ -42,12 +44,30 @@ void spl_soc_init(void)
>   }
>   #endif
>   
> +#ifdef CONFIG_SPL_NOR_SUPPORT
> +unsigned long spl_nor_get_uboot_base(void)
> +{
> +	int payload_offs = CONFIG_SPL_PAD_TO;
> +
> +	if (CONFIG_IS_ENABLED(OF_REAL)) {
> +		payload_offs = ofnode_conf_read_int("u-boot,spl-payload-offset",
> +						    payload_offs);

doc/device-tree-bindings/config.txt

u-boot,spl-payload-offset (int)
         If present (and SPL is controlled by the device-tree), this allows
         to override the CONFIG_SYS_SPI_U_BOOT_OFFS setting using a value
         from the device-tree.

you need to update it's description because this if for NOR not for SPI.


> +	}
> +
> +	return ZYNQ_QSPI0_LINEAR_ADDR + payload_offs;
> +}
> +#endif
> +
>   u32 spl_boot_device(void)
>   {
>   	u32 mode;
>   
>   	switch ((zynq_slcr_get_boot_mode()) & ZYNQ_BM_MASK) {
> -#ifdef CONFIG_SPL_SPI
> +#ifdef CONFIG_SPL_NOR_SUPPORT
> +	case ZYNQ_BM_QSPI:
> +		mode = BOOT_DEVICE_NOR;
> +		break;
> +#elif CONFIG_SPL_SPI

I think you should do

#if CONFIG_SPL_SPI

#elif CONFIG_SPL_NOR_SUPPORT

It will be clear that you need to disable SPL_SPI to get to NOR support.
Also diff will have one line less.

>   	case ZYNQ_BM_QSPI:
>   		mode = BOOT_DEVICE_SPI;
>   		break;
> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
> index 94273d0deb9..4e14c74e31f 100644
> --- a/include/configs/zynq-common.h
> +++ b/include/configs/zynq-common.h
> @@ -35,6 +35,9 @@
>   /* Ethernet driver */
>   
>   /* NOR */
> +/* Load address is mmap address of QSPI flash, plus the offset */
> +#define ZYNQ_QSPI0_LINEAR_ADDR	0xfc000000
> +#define CFG_SYS_UBOOT_BASE	(ZYNQ_QSPI0_LINEAR_ADDR + CONFIG_SPL_PAD_TO)

did you test also XIP? If not, please add a note to commit message that XIP is 
not tested because this macro is used for XIP too.

Thanks,
Michal
