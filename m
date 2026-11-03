Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA9606A32D
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H4c+Rx2E;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LAD2Gwk/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FDD680CBC;
	Tue,  3 Nov 2026 06:58:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QHtbMW15aSD; Tue,  3 Nov 2026 06:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C77280AC4
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689133;
	b=OBbIRlgfgKp2DcMkLCyyYKEY/UGjyjO2eidqu+1s2OMhanv/cEtpBrQwftCrurwmq5X+
	 ue1Ctj7u0y3s0XNSBrYSmeqa5gMx7wjf0rxAY6QG2a5xg0Jqfeo3Yj3BfleSbqHjBxMtu
	 7/m1SLBSgZrSHC5VgnYQu7cgnmq7BXmrFxl6i20zIWn8JeajmfuZ296AGTg5uoXKfGZQQ
	 sOBdd69fEf3x3OIj8bdyFeccaaQoU4WNsNum6ZPoq787dCA94z2C5UL3wuVuE3fpJxkF0
	 FFr6HM6ow1VW1fUrQaKjmbT0ZsFpgSi+VToBfblxcACS763nLliuVd3kG0Q9R1Sr/Sg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689133;
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
	bh=7vxUn3ONIaxLRm0pXMoTyYSsu8zvqZBBffDFT94UBZA=;
	b=sYtwF+jWCSHMLkH8ls4GmsZ/0b+cg7lSGgkzAMFET2Rd9li18MAajWGgs6+yO39f71Rf
	 etXuyx8zSnRmOxutm+5zs8mCtrmX2AoNqvfkK99i7E7i1rca4yyewV0hzJMzyRXWumEaX
	 myuSIDN+5DLNvudJlcEzdIyeuh8wjQ3cAfX1c4DHrOxzN2QVsfLR/PqvX4LXwaydUERSA
	 B4b4nvB/7Lrio1p3Omz97E52AIcS0vbt2AGmW6In9KDZFwsTJ2v17R2u+iaNG2GH17dwv
	 XhdBS7cP2I3MZYDp9Z5kZpa+AtI3EeKR4egJNyixVDZ+UKQxll4rkUtmpHH/sQzKY1A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689133;
	bh=7vxUn3ONIaxLRm0pXMoTyYSsu8zvqZBBffDFT94UBZA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H4c+Rx2EZ9jUhBsHmWJCg2f7ZK8R/DtOkz7B0gctQGEvWVBypZrgtuwCQTTb+SwZT
	 ewhseEZ9/+AM1m9VyJGUZNGt+3v5zXH1oYpvF765fRf41f03bCeku5SBPHTchS0KSY
	 8FAPKrpkq16Z4XBDYItXbHnt2OedbrNuc4eT3UlrpGDHRmmdmPwS+QEw2i6dhdS02W
	 bXO2wnVRxOn/HlwDbqz13wTMaiaePeKbJahLMjPvunycn3hhzfUP9xsPLU7XkB2Ao4
	 XfnOmQ3iWVhLUrULGrqa5iw4yRtrl0wEiZRuUPnIGkIBFenIVf9dayBKpuZOe8mWkm
	 3qa81tQiimssQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C77280AC4;
	Tue,  3 Nov 2026 06:58:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60AD1235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:58:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42F7A400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:58:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLrKCidgBLbJ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 06:58:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3F49D4009D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689130;
 b=Pw2gUfEQz+ncmpA3ifXX5dYymiTBbN1+S/eBNWmzYf3zBz0DqWrf0g3JkCN+bmliQM9m
 pxikv3CC+55RBq2FNSIfZMqTyGwg2QrbiIt04zIkSuB3TqXQH3NTqeJTePAtW+XgsRIxR
 5VneFl+WLAnr4JXVDIqVp4PLz8HEtidKTZBzzqsTt9zZFCi9IYAXqa5dr/5wgMJGYep5s
 Bn9nBXlwPDFh+m0z1axxPTXBb0bhZXLerxJotkRYBm6a7gRKStd+lkOfv20GGzhd7QnpU
 uOqbGQowdMdcJQ9CqazhxGIXEd6OJvsm9rd9n9q9vDz3f2gVrdx3/wCwnfyPXIY86Og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689130;
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
 bh=7vxUn3ONIaxLRm0pXMoTyYSsu8zvqZBBffDFT94UBZA=;
 b=K3GAUJUKHuS0K1Q7lcRM8lOVVXpTE5tk1KhMLNRMGOCF9LWJkR5ZV+umm85QtqjV+g0D
 +rN5taclqWr7a3s0gjxdbe15DU2pyNkURhx00YUm9MJJR5PjSHbCiybhvinmLriovco9H
 RVR3YCql7Vrx2vGC5LrlpwcnpuS2kSqrTgMUxaKmEECy28Vde1jQzXzMiz28oDlPEYF63
 2oIBdohpYPLk45qfh2Q0HXli+GeyBjrfhyTXQSYTudag2CimqONVAj5IW3tipqroReH8v
 RK74p8x18PzO96fuEvdVJEmB+wKbRXVHvxoD3IJDkCa/KfM6ftleHBnGb298Yc9ba+w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="LAD2Gwk/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LAD2Gwk/
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F49D4009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+q7xULVOxhBJgGw5iKox75gnwqlX0DZUr8MFo6eAHejkNq93ghM9llHQHdNI0NpAdVmxo6R7wotY4a4Ac7vPuZQrmdttdoVGkpNdM3ebpBl7AIGCSbJMjsefAR4QuUQUZ0r4JbNQh3u0AmaI7wJvtzws1osY/Aw5RHBPRE0QLPKY4+dzrbESXr2IKbCi/i0q2a45/zhiR3rB/tqU4TUP5Dd38S5wxaSldLJnUyip3Hw6BWtXU1ols6wmhDpdqr85qDoG+iQqkdcCmptTwq+niwnJPnwtqRKsWcAk1HUE0MZCpBUF8C8R92MJt2TzSyLGvhNdtZdbiyODLnZ44gcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vxUn3ONIaxLRm0pXMoTyYSsu8zvqZBBffDFT94UBZA=;
 b=WK4DFa4jbF5zL6PGx/B3avhUkAt0CRj2nrRuvKdUpJXwc7VtBGCr+6oJt4+TErLXXDswHFL1o2CFWQLJgb34kTA5dx+M+bAOG2GA9kJYiHim2nvAgY2ngjfvTvrxpOIAq9tWVO6xfQ0geoH2olc7wlecIDr/qj5kGJyS1ZqXpp4XcRL3SJ2y11Q2xC7FOQDz5tKCF40/bxyPNu8XE8z3sf7wEDb6BhGWL+yoC3R2TJG+HHgypNKHpN/LrqnXBuSLgg6yGBJwwEvUTcde3vgW4DDEvd9pC8p/7Gqamh0J+irezQbfAxO5jeUzngptocddqlKioiXiQVPfektH94cdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vxUn3ONIaxLRm0pXMoTyYSsu8zvqZBBffDFT94UBZA=;
 b=LAD2Gwk/C910BrKTjouN94bU4AXKfJJaZ8R3kxyjR8Lg2PpM5kuSaEnieibUAq0uVIn6vZ9EEDxmTzGPwiW6kgp8igUQ2ELK2Z4JF9zAEtcxxiOSFjXTx6nUQZewX0uHFAimRuxnNxlnVWBtuKx15S3oxRtA5hvw7FXD8A+yP0c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:58:45 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:58:45 +0000
Message-ID: <e0e436e1-63bd-4c87-8952-9513817458c7@amd.com>
Date: Tue, 3 Nov 2026 07:58:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: zynqmp: Enable Xilinx AXI Quad SPI driver
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>, Tom Rini <trini@konsulko.com>
References: <d04f32937d9abdd81c13f680714a4e36cd0c1897.1792504249.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <d04f32937d9abdd81c13f680714a4e36cd0c1897.1792504249.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: d7410531-f60c-4a10-15f1-08df3977e720
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261009223027099003|56012099006|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HUtgtke3qDyxSQ7XBLZ41EJOB3GNdlohds39GNatkA83ulqurr3Qec9L1HwfDzXiOYlg5Z9klMm/ROE2aJVxlXBLc0oPs/IQ058xO1Z7xAfNoNiKbdXSfuN+FAwRNd7qwjFaw8hgPTwtEEr5Plq1sp0W6vsnBKfgYQToJHvIScHHCh3XxurfZPr2Hdo1e+VHnueL+SAsw+RoEJO62AHQshWTDEl196KVJVnX2sKzmVR6Z4m3ZGMyG8aBXCl79mjhjz28KoLejkfASGxmz0jyb980eXOwe/O+2fsAZd/ZUks3rwLlXagfN9UmXneQa/U4TVheGM8MjTS9LE4NV+jroh1n+hiF5/EZwM0rpwvNxYGvDEsDC3g3OxuJr54z6bZDK63bxfiBZ9qVOYF9CkSgpP4j3eoVAuoBXVAntjpnFxxJidgO4CZj/1hBbRwI/Q1A1jb3hlvURpKalbReeRdtj76T+EHlW7XdUJ8qtJ8jwx9Cor+V2dFf9xKau8aCPJXWTEG3ye/Z6o3RebnI7Bmw//zs7EwC6rZWtYYyCGROd1ljwFVBoPaZvcHSuoF0WVpndf5Ic/1Q1XK+0grKZK8OLbUl1BMjdDnMW3k1+Zcy4kyqmVIcU6K8QItiWfqkrocQhTftCDNQOCXxohXjlC2cNpnxcVM29frZ+Ml6JU4lApo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261009223027099003)(56012099006)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjkrQTBnUjF3bEoyb0x2SGJXanVSWXBwOEc1ajN5N1hBSWhzVk8vcW0xYzBH?=
 =?utf-8?B?NWdrazVMMFNWVXhMQk5HbENaV1hyQ0RzZVdhOVk0UHV3Q1lxUHJ1SHMwU0hy?=
 =?utf-8?B?M25Ddy8zdEpWdis4QWhqWDFzNlBEUm1IRXVBMEdjNVN6cC92Q2tGQVFUUFZQ?=
 =?utf-8?B?RksvbWpJaThyc0hOdGJZckFSQnJkdXRGMVBLVkF0YVVqTmkwazE2RHhOVjVF?=
 =?utf-8?B?MXFxdDVVdDczZFhuaFlBNDlpd0hPei9Na0JnSnJVbkNlRWRYb052eFlMdHJ4?=
 =?utf-8?B?bGxhTmxucVUzbXh4WTJPOCtnNjNXUUE4Wjd2dElNUFUwVm43SVpZYTlRN0JO?=
 =?utf-8?B?QW5rTmN4Rml2WVRXNEtrYUtJODQ1VUw2QUdURHM0d3ljQnNNMmEvTW42QXhB?=
 =?utf-8?B?bGtoSVpxOU53Z054MWQwMnhRRS9VVWZ6L1hQT3k5aVEycnZRVDRySlNzMnNK?=
 =?utf-8?B?eVU2ZzdjcWp4aTgzK0ljak84Qmdway9lZmIzVGtwZTFLTHduSDB0ZWVKTHla?=
 =?utf-8?B?c1VMNXlZNUtJNTNEMzJNbTYvNlhTcGdrWkpsTVBEVXJULzIzWnlhR3orR1ZO?=
 =?utf-8?B?MVdETEZaWm4wNk5tWGNpVXg1L2g5Z3BrdmxVM0YwOHBlSjdzYmxWSVpiZks4?=
 =?utf-8?B?a1MvbDdwbGNxU21HMUtBQjVyUlpPWS9GbWRJL3RVU3E0a3ZxKzc2MzE1UWlN?=
 =?utf-8?B?WmNGek9xZTF4Kys0V0Q3bDF3L2N6MnNpSThqcEVCcFY1bjlsOVJKci9zcjA0?=
 =?utf-8?B?WFdSaTNpZ3JaRGhOTUJDUk5OUTJDRWNLaFRieTU1UU8vVTQzaUJVeXdReGJj?=
 =?utf-8?B?eEtxY2tKQmcrS3pzWWhheEdTdEZaMmcwRksvRldXbEZmcndTYXdIdFJkdDhW?=
 =?utf-8?B?VjliYzNRaEUzVUVLUTQwNUdlUHNZMmNXRFZZQXoxUnZISVFZd0d3UDNiVjVl?=
 =?utf-8?B?aHFUMGorcTNIM3dLMTQ4T25SY2hCV2ZJZmYzcWJZUkY5SnR3bTlDWFZuVm9H?=
 =?utf-8?B?OWJTemZ0VzNWK0RaUmxweURyZkp3RHMxWG8yYy9JZ21IZjJ3dUs3L3U2TllU?=
 =?utf-8?B?dEpFYWFTZVl5MHh5dmpLc2NEU1hWNmsybnlJOTJXRzZpSE5lZUF2WVJHU29q?=
 =?utf-8?B?c3FxYi84SmRmVjlkOXZCRzc0Y1hYUk9hYUoxbHdHWkVXWVdZbFBmeEZzRE5G?=
 =?utf-8?B?SmwxY2ZWcjJlVUx4b0g5aWtnYjh1QzJzS3VaTG9PZ0FUb1hQVmNJazg3UDFh?=
 =?utf-8?B?ZFNSek81emNsNHhPZWN5YUxNblI2Sm5tSWN4TTBBcEwxZzZMckNEQy83NnhX?=
 =?utf-8?B?dWthWmdVdnNKb1NPZXZGM2U2Q0tod2orVDNCMHBaaUJqb1FvNFhwdDFRMjVK?=
 =?utf-8?B?UFNRRFRLemdYcUdvcEQzMmdtakFNQzVka0FBSHRGY0hXanRsVk5Uby9wWGlU?=
 =?utf-8?B?UFJONTQ3a2w3T09Dbm4vQmJiUVJ2aTNpVDltbjNPd2hNQUkvWWwvUGs0aWho?=
 =?utf-8?B?REVmNDQ4cC9pZFNudElBazM0dk1XcXp6bDNzNHBEazJ1TndWczMyUmJkZlNF?=
 =?utf-8?B?aE1OUHBCN1pGUUpOVy9pQTFHZitlMkErczFQV1ErdWRYL1MwTWhxQTZrbU9m?=
 =?utf-8?B?YUNJbktnSk1xcHlkZnlUcmtxckdhTS9xUktIRjVkVGhuYlk1RGJVZnlEZGpT?=
 =?utf-8?B?NGtxUkJrZ1lvWFBZc2kwd3lSSkhDamowRTBDK2FFQVJuZTFCWlhhMGN4R0R5?=
 =?utf-8?B?NUU5RmdnZjlJSWhncDlNNGVaTGVWdXNNSHFoWUFCRE9FcG1SZGs3K25DdndP?=
 =?utf-8?B?TEtoVm5XZk54S1RNQ1ZaZWlKMUo0dlk2NU1uWkJGbFBWdk5IUGx6SmRZUXJT?=
 =?utf-8?B?ZEh4RUw5RDlaTCtmQjB4TnNGbWFLYWZ2Zm1rYkRPd0Jzd0JrYXlkeDBiM0RP?=
 =?utf-8?B?M1BKT1d5RjBTd21oUk9CY2xvSGZhRWJNR2Y0Mzd3bG84cW5sZUJLWXRKQ29R?=
 =?utf-8?B?V2VVWldZalIydy9ZVXpmcjNISFYvcTZOcG9KU2F0SHpNazdJVFNPWXc3T1E4?=
 =?utf-8?B?aVYxeGphUVNvMGExREtOeEdWeXJzdTFhNWlPTEtQa0NFWFlsbEpqS1NBYUN2?=
 =?utf-8?B?eWhzWXpvZGZpeTNjdjJOS3J4UTRpdXpkeWEybm5ZZTJjMkNpanZDSHpROHRS?=
 =?utf-8?B?RWkxS29uNHdSY01JSnAvL0dFQzE0UDVqTy9ZMy9oWVVlcDNHNWRlMzBicGpt?=
 =?utf-8?B?TFBRL3lEd3JjZjJ1WEdBQis1cTNzaTdaM0FRTlRTY0R6SDJQaElBMjQ5dWZ1?=
 =?utf-8?B?TlRveWJIMFRXbitMR3VhOGUvRWRNNEVRcEliMGU1QTY2SWZubWk3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7410531-f60c-4a10-15f1-08df3977e720
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:58:45.2663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sc9dIzNGhpw9CJyP2JJgI+klcCHSSmhW5fqbmniQozbD/dY9llEE648Npm0Ytj1A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
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



On 10/20/26 15:50, Michal Simek wrote:
> From: Suraj Kakade <suraj.hanumantkakade@amd.com>
> 
> Enable CONFIG_XILINX_SPI to build in the AXI Quad SPI driver,
> needed for designs that include this IP core in their PL.
> 
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_zynqmp_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 4684edfad031..ed5d7cd55174 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -203,6 +203,7 @@ CONFIG_ARM_DCC=y
>   CONFIG_ZYNQ_SERIAL=y
>   CONFIG_SOC_XILINX_ZYNQMP=y
>   CONFIG_SPI=y
> +CONFIG_XILINX_SPI=y
>   CONFIG_ZYNQ_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
>   CONFIG_SPI_STACKED_PARALLEL=y
> ---
> 

Applied.
M
