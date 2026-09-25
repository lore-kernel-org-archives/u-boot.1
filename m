Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F363DC9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 13:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8D6681360;
	Fri, 25 Sep 2026 13:45:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iSOlN4uENyCn; Fri, 25 Sep 2026 13:45:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 063FB812B9
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790343941;
	b=tgdPud/kdN+d0xhhgyaM8Ys/q9+5nBpSIJYJD9iba3xcoPNnXJiRAuSTeyQhyIhoDMZs
	 cmqamK9UJGb+KSB7vkyHZF3cMYRU6/E/k/hbJrXiF1ws9R9w3dsNYqJaHTif9wj1RSUGJ
	 VX6XaYGbdqb8tS78XdZz6HkGGAYfLSDcbYuU9Vlk3rVVxYKyCI1l3claXHNM5GMbzmWa5
	 FkBfTxE2xQ+RiGAwcD1dZV4QOEqHdesslPAzoKq0A7pmiIPeAScdXeZ0SXaETtzkFreaH
	 Fsg7ijD2gzrA/Wx8TzLzCzTnjUBjtEaV9EV3dXQcu8CctPD9qA0i0VsH34Vu/RP/8hQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790343941;
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
	bh=wqOCzEb0F/cxXD2mNKbYo2gOXiYOSkZ36ouEMcC4MFc=;
	b=qr8bPPdwig5pCkrPWn9zNuPTIM9pTchMe/qQaArqR6CUtE7YLbehLmGItr/wKbCYbvhR
	 ZaISXoPvzoGbNzhx4sEFj0UboHH7svowyIVuN5sAF9HK4GghcAmZGqkO4HP1OU4IYl9SF
	 nTI75dyXehB7RujX1K7WbP5Kh2kPxwrCTx3Q4m6+wH+BN/3ibqR4vGXikCMZLgoScb5ce
	 VJVkbTZ2KVGBcmy9kG3n7uyQ30PzKY2mmIrX7suuiOwXD2cQEsuDEPvYUGZZTRnE297pn
	 EMCNN3QWLOGhNVGf+hK5RhfzF2IZip/5AjGwlew5r5xJTypMXS3d1CSr/moPk30PcIw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790343941;
	bh=wqOCzEb0F/cxXD2mNKbYo2gOXiYOSkZ36ouEMcC4MFc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KCfmor1r4k0dHEv3pwgrkqfNknXVjwLgTlYTCS/Ydl0Gynwz86sHL7+ESjWFd/X54
	 sz7dEL7d0vGGSrW3G5xGSM+Nfw5jN2mxOWyO6Lye3dbHEU4bo3GlHdOXTAqAMVlo8l
	 HmU8S5JXfSJYVS1MCAbFMOUHGzqIzsL4zw3+OZBL3AGpQKy2O4YKllQGWjxfzCi3YA
	 TMNs9g4w7cslyHvKiFjVWA5bbcsoNQbDwDiPNqFZHpwrTkpmflXBaTU4EzoX6PAe2F
	 HFQT5oRk5g7zLLYBFyGeccDZg62wlzfiVbDCM/s/nGtKA4KAQfie6UWqqlgUIowfy3
	 3bGR+ejvSjjEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 063FB812B9;
	Fri, 25 Sep 2026 13:45:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 780AD332
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DC7F40CDD
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:45:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uOku0u92xzDa for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 13:45:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 292AE40CC1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790343938;
 b=KOaDsMRhj1/WAg56yNqV6jLFRie41Gif2ox5y+x7Y5FcZCNf6+o8I/nNLw8blosmYX4e
 MyQpcpMq2dV964goZWs/OYZ0glnxVeKj7bQu8AOdPghO6x/OdFshyKn4OR92jJeG/kg/p
 MDZdquXDMrzd3tsZ2gbMlviGDeB51C9PYOA51ATIDXkwF3l2wTVGFh3ltndx++zvoY0WG
 fhS4pwrtLRmgqlnwDbBFqMEFK0V2rcPSVFZEsdasfWzBV/o6vgPwttFyYO5p/XE/UcrBY
 P9BLD8MdLkTDqEtsbOu/VYy0Gn1ay194tExMt+6Slz13z34jNkdv15s/Ul5SyrLd3kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790343938;
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
 bh=wqOCzEb0F/cxXD2mNKbYo2gOXiYOSkZ36ouEMcC4MFc=;
 b=slfVdvcbwlKlu82IdQmClWiltnkDBNZPyBduOfqyIHmZFTZhyOVcZAYAefYasnuFFRAM
 FzPwHFFnhldJ9MYgAIHn/o0WhEbQDJVkItyJ5vKjLq/9PNxE+tBK+2isb1RckFChkfoWr
 vf/Iq6YAKd3YsofSMFL+vDQDF0bKdiSd3iSYYWLe4BJ0U6y7OeDWGbPlEjmNXKZ593+k1
 0BzPcHYejGLBzrkOV7aB9uf7yhLx3vv1YV98SfnFxuU0NbJ/+ximoSxJEeAemoXr6xubU
 zQXk4svTz2YZzzlAIPEU/vSCPhYmKoczT3FTKXbuobDxy0EB6TyxeH5GuRC9IrXgWsg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3GFtnxmd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3GFtnxmd
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 292AE40CC1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 13:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2DX/tHKljZI8WDeFh8jWTU/LcyftP2eJ73rqIEeOOJEr5v1f3cfLwxPMvBBqZ7PxdrwOk5IXPGkCop3FcQYaGddnoBtWr+8f0Q9r6A/nIPE9x9iExyEuMECmZDBpsb48qHihpu1NM7szGwd1uKhGRnimUznLVKXwPNBAWWG/tquOQ4iquUkyyh2ftrDgxxhUGrWUtN/MECBIPA6kZw6nI37vihAdm8oQNfyOkE3X0dHZDiyupks6Dd0IPMFpYSHHdkLdCBD+ZbrlC2E5vH3MHGorMphNwEqf0kSkQKWFVDJCPdqywYofzFTbgJJgiDu6MUcBBSu8qztltTZUFQ2Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqOCzEb0F/cxXD2mNKbYo2gOXiYOSkZ36ouEMcC4MFc=;
 b=BHgoZbaGQuoewySwPPwN649eJzgBNuvp9UAVSbDT0+pfOd87eHVaHeeMXKhUyOo8bhqBrOnKxRvaPbTPpbouVhVjMjI79Pe3Z+6yx1AtoLj1U2yiMzLYpiU3h+38xrRdnbkAcdFIWaBXdFkn9J65PN56TionA50sN6mlrUoqsYy1njOSF7lDa/iGxGDr75fNjOOT4rOjNQnetC7DzPKsv5Za3l/MBTbl9zzQhCn/ycZe6gBi4484aAw+T1NXs//wWR9HzGaS2datZZ9uy4OUdWOBX2xfLbO0NShRD3nOd+YBsFdVTEDrRFnxKIRfcx8hMaCtP3hVZ1F5/OpDejBKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqOCzEb0F/cxXD2mNKbYo2gOXiYOSkZ36ouEMcC4MFc=;
 b=3GFtnxmdbp7XRj3tDgfO3UB5YGFsQmrPsBtFadjC0gd+P4QUrTI4rv+dHLNK3H6EM29oKwJYfydPWcFAf+aXiQC4eL6SCaqDwSfVi4n5eP1FUdUgVHRViPxWPNK/JabIh0FLfP/T35f4bITYelGuAS0ic7DwdiapafXQBT76Y40=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 13:45:27 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:45:27 +0000
Message-ID: <22bcabf6-3427-410a-8de0-398236aba25c@amd.com>
Date: Fri, 25 Sep 2026 15:45:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: Add missing dependency for ZYNQMP_GPIO_MODEPIN
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Johan Jonker <jbx6244@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Tom Rini <trini@konsulko.com>
References: <c4b7a0b4461034976b18c94ad4e296f5ebba924e.1789040674.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c4b7a0b4461034976b18c94ad4e296f5ebba924e.1789040674.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::34) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2db37b-4a08-4509-fa21-08df1b0b41ed
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zJJB4m8On4cWiuXFTT1g1Hx9GNM/EZ5/OGNFqAdV8VY30dkTjXPVvtfMpstmuKtvJE+aYKPyiUwXpL9fVJN/F9uNEqhs13jrDGgu/wYbzw7b3srVKk4Cxm2YqMI4GRaIpWCsJKW6/nBKVVRxPKJC1fywD1fcTVlgZDVwJGla2FuBg5Nsbfd5vZM2jK3KnTT8x5y+yj5PVV2qgeRqLHMmtsofox0uAjb5AdKlX8pouIB4bMNnxIB65+gIjoF5YmobCSDeGGhMSqbrOWMLWwNhPvdUHM/2p9N0udxYuEgvAFUMV+4LG2btBtHVXrZLYN2qwx3kphfCJ0W+ZLPvlGQviDlKY62n400la/NLsgbLo8STsRO2m4bmvyb/VVRHnNUmYFIA7Wh714LCH9Y97JFmq4jLMYx7XK7frhzAXaMWjx6jY/YOojoIY4HTchGdH/WefYSYBkfmIHdgKi14C5b0VG8G9wII8vcw2uH1/onFFkvGXYSj9HyyM7yMBolLHzH47BByXsjZU7tyEcmjERw+R/0mfs4PNeMTXAGiOW4UmLA/BAVuZtnFaTivq9wjo/nYu7JJK27wfklZgtW2U/wgVd4pGK1rYopAzLHvKfDMKjAh2q8tvR2ipYTZ9nIbcX/06O3KSlfkuI0MiJtzU9qSyoGRmkG4391QsakgklWNatg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2R6S1FrNzdackE3R3FSd0pDYU9qSHg4V3NxS0lmL0ZZRTRXMWFoM04zS1Yr?=
 =?utf-8?B?dkdkV2xMRnBCcWdJTmVjRFptaHVuNEpPaEpmTDlLb3ZrdmVJV0w4NlZRaHdH?=
 =?utf-8?B?My9ibTR3cW0wSnhwcEZoTHRZSFpUYkd3eVUvUlJSbTQxbjZTL09GTVJyMlJK?=
 =?utf-8?B?eDhyRS9QdXZSNXBtUWNBcUdLYk9BWmY3amdraHR4eU11TGlQYjhTaDIrKzVs?=
 =?utf-8?B?Tng0WFc4b2l4L09SRFRBUGtraFozVHA4bDRMdjZtV09qd3hkSnJaSWJGOGJH?=
 =?utf-8?B?RzNDbUVuQXQ5UDUrbHp5RDlZekFZU1R2Y1VzdDJoVElEZU01em04RWVJcDF5?=
 =?utf-8?B?a1JCK0NJL1ExUGhKbUF0UXZvY0h2cXhvODdGWjVsaW53UVJjK3dxcktTOW5u?=
 =?utf-8?B?dGkzdUE4VDNTaVFuUVowZStuUE0vUjByNzlqZklYQmduTi9HTk1Zc3BIV3ZB?=
 =?utf-8?B?ekFFOXZ4elcvblB1SXVQejRDVFY5RGRXVlBOTm0rc2ZUd2RuL2laTDBLcDMr?=
 =?utf-8?B?T0wrbFpRWGZGLzBJTnFjY3ZoWXRmakR6clVUMTlSay9oZ3RrTHFZNDVrMExV?=
 =?utf-8?B?QkQwQUVsQTR1VjJrMnVUTkZCUkNHRk1GZVRDNVVHUHROalE5cVJyWXlHdWRC?=
 =?utf-8?B?OVp3RXpGNThCK0tXQnQvZ05NM25SVmFJazVMY3ZmNk9pdU52dkphOHBtb1RU?=
 =?utf-8?B?V3ZEMmZDbzhMdU8zYnJpblo3Q1Voa00vTHZZN1hIZWtNVndrWHF5NlNkVW54?=
 =?utf-8?B?Skp2ckxrZXBjb1h2RVp5a2JXdG5NSnpqRUkra1BLT25WWXRCNjl4blNpeXdo?=
 =?utf-8?B?TnFtYXhQSi92dmdJZEIvTkgvQ1VITnoyUFd2dXg0bWdIeEFXNlVnM0Z3ckpV?=
 =?utf-8?B?QmhsN3kzT2ZiSVhDams4VGxmZGVZUFVQMlZqUHQ3SzI5MWJ0MXdlS1dCQnpK?=
 =?utf-8?B?K0xxYVUyVG4reWtwZWRxaTQ3TEdYdjdFNi9tMVltbjlmUWRtcVpiMmxWRytN?=
 =?utf-8?B?elRYdVYvZmRtWklRUmU4cVNmMnB4V0JzMzlwVE5pUzVzczBiK3RCUlg1QktT?=
 =?utf-8?B?VURnNDZHU0VzZTJKdzgvc3BkSnl2bmREQzVlcGlONUQvRnZKRyt0aDN5SStS?=
 =?utf-8?B?Vk9oL0lRL0l6d3BjTTJqQ1R5YVZvY2R2ZTJ6NDVlbk8waEZ4V0dNM2lsU0ow?=
 =?utf-8?B?YUFLc3FDUFRZMUY3aDlTYjdhL1lGckdtRmtHeW1wcENlWTgwK0w0THBocTQr?=
 =?utf-8?B?WjFEZ0FzV2lUQkRqbnVndHU3UENwUHJ4aUlGM1lKalYvamF6eDI3MjlVeE5l?=
 =?utf-8?B?azRUcVhxbW1pc21kaUtqRHpmRmZkSmRMcDV2RTc4SDZkeGczbW1CYWxud1hz?=
 =?utf-8?B?RTNCZE5kb1h6TG9ORnBxdER4U0t3NGhWTS8rSk8vREx0OFJxbWJydGYzMnRz?=
 =?utf-8?B?cTh6anhBc3JOdnZEQTNieTZsM2QyUkNMMHU0aXV1dDh3M2NPNXhGRDhSTTRo?=
 =?utf-8?B?NUpiTktaU0VnWGJVeEcxR2toZHozMDlCQXhxN2NzSlgrZk5RU1pFa0I5bVBq?=
 =?utf-8?B?cGg3d0g5YmtLZjdIaXNDS3FVbUZTQzFOVnZUdi9QejIyMU90alNOMHdETUQ5?=
 =?utf-8?B?YlFsSFVoQ0ZMZ0tZNkFhNUdRRUM1cDk1dHNQL3VuRGRudFBOM2tjZzFoNVJY?=
 =?utf-8?B?ZUxJODdtRHlHU2lLTmN4VUNqckdjdk9ZUXMrd3htampLRERDR1Uxb1l2Qi9u?=
 =?utf-8?B?TmV1Vk1QYndpY1c5NCtGZ1dTY25udXMrQ1dKaWRBRzV1czFhalZJU25PbzRn?=
 =?utf-8?B?eUZURVRsdmJaMUl4SDBZbXRRYzRMUWV1dTVmeHF5cXlPc3RjM2l0K0owSFNR?=
 =?utf-8?B?Q2NmL2ZkeVNIaVZnMjFXUjFoWGp2SFJiWi9KOTBSTnEybkNFZkEwazNLckx3?=
 =?utf-8?B?YlkxUnJvRFh3NEd4Q2ZHZEc4MFRIK3VFYUduU01ZZ1QzN2d1ZHcyNTdjZVFR?=
 =?utf-8?B?dWNiTjRueHVSNXV1WnJvdjNKcW4veXMyMldqNmwvYWFQdEZvYkdiVDR5bDN6?=
 =?utf-8?B?aVVHV1lrNjM3aThidlZyR1FYQWFQSGJGNVFyRHJmRE9yNW52SVJkT2hoaVgz?=
 =?utf-8?B?UVhQTmJqWjhlcEI3NHVHeFZyR2RhTHR3TXJ6TFZOWUt2bnRscExpVzloS2dZ?=
 =?utf-8?B?UGE4MmE2SGM3V0s5elBFZzY2ZWVxdGxiZmd5eHdFMHpJbEhOajlwaVJialI4?=
 =?utf-8?B?Qi9hMnZCdU0xeUI1VEdUWG92NDdDV3hEUmd3dnhoYU9BUXhNT0pieDZIUnlq?=
 =?utf-8?B?QTJBUVRjbzBLREN1R2w5UU4vUUh4Q3ZLR0c5UFB0RHBnRW5SNksxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2db37b-4a08-4509-fa21-08df1b0b41ed
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:45:27.5897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQ0ILlGHLMArz5JvNUJA7FL7BxRcth0EMmwCVhD0NyWGU15BKYp9/+mEZaEHuS9P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882
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



On 9/10/26 13:44, Michal Simek wrote:
> The modepin GPIO driver can be used only on ZynqMP, so add the ARCH_ZYNQMP
> dependency in Kconfig to prevent it from being enabled on other platforms.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/gpio/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index a11f30436708..6da66b6f3f31 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -714,7 +714,7 @@ config NOMADIK_GPIO
>   
>   config ZYNQMP_GPIO_MODEPIN
>   	bool "ZynqMP gpio modepin"
> -	depends on DM_GPIO && ZYNQMP_FIRMWARE
> +	depends on DM_GPIO && ZYNQMP_FIRMWARE && ARCH_ZYNQMP
>   	help
>   	  This config enables the ZynqMP gpio modepin driver. ZynqMP modepin
>   	  driver will set and get the status of PS_MODE pins. These modepins
> ---
> 

Applied.
M

