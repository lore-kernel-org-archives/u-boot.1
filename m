Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EEFC79FA0
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 07:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04A2380931;
	Tue,  8 Sep 2026 07:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2hrtc_wfbra; Tue,  8 Sep 2026 07:44:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 39F7D808D2
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788853441;
	b=kjpiejGuzKJfTGyVLZPotJGY9zTdwaJjnlDO7wNu69aM38jyDyhMydSVcjf4UUe5rmvL
	 JEzfteD0oPzbsZsAEmhhUbkhQAhx8B7ul8GMZFC7y8dE7C2XHFPScO86GPFP2MrH5D8Lm
	 s+bI4hBCYy/zmzc873g0KiYSBDARx3A/oir7MCXZUT68TtTG1NYhR9a3yrtG95Fq7kCEe
	 oyTlkOZbc/mRTO6U/8HH7jD0oItjibfhYMDh7/7OK1R0wjkvFmnG6ZSVfptrNpnCZWopY
	 Pb7qnvDo/Mev+6ylEH2UeH+NXjTASvj/hdzw63XLny2UMFgqQZPb2JifHSmfzx5GZlg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788853441;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=jdIfhYBDkAEP26SHhS2ZssmJKex49Vvcb33LDCS4IDQ=;
	b=fYZdkv/TwO+UA+SFyOMpgRbX0QpHmB1ybMutMM3gg/3x+QJ7sLONc5Qm5Od+Me0VO9g2
	 DA9TWj+xKf3v8KUDbi14Pk3pAO0B+eUnZbnL4NAaex65a0EjCoVKFrtY4lSihKyD2ebhy
	 ZEa9RAA6gMLkDur1N7O/jEMHU79AybaQp1+WUMYBvVm4JECC2tYpDOz0Da9fIVVrPlJO2
	 XkkxsUOH0PXBkkqPS3qi7w979paEoF2bSib0ecHVd4X5+kbmMGQ9zlsbLWfJhaTlkPC70
	 r1u0E3b55oyFpS3VRDdgSHZhGd17FkciE31g+yln3yhyivwiC7kxIhkvDggInne/qlA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788853441;
	bh=jdIfhYBDkAEP26SHhS2ZssmJKex49Vvcb33LDCS4IDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDBeyqqIZuyCXEA4SXE1K8SHdiN6itBgLRMczwoi4rmb2xhTiC8ceTEfThX30IQnk
	 uv+pA2NHEf6MSOOxWiJf1un12SdWEmsGLHJ7b4bkcjSsuqcnntcNQGfWqVaaCYQiGU
	 ddDaT5RqSk92S4WYsT+2bBt6dEPUTTl6LPlNKjzC2RhlqhhgbvVIEGXO3a+uqRdnK7
	 vBvKKbzsLZWX2CcYdIAGpndjU3Jp+IDhmWTU3YlnmIe4T/v0qopi3uJ4i1c6mRV8/U
	 usihc3SWe1w98ZQ+ycwXaifuEQMdvxaqqqYse4L+St8eSc4aVgsFJOgKWKBMkyLg3s
	 YHF44yRcudczg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39F7D808D2;
	Tue,  8 Sep 2026 07:44:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B8A0230
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 815CD605E9
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U28hlGom5v6B for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 07:43:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 934FF605E5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788853438;
 b=hKwrxt6y4mSANf9OJ/+ZCK6q9CA0ohtUGE8LUuxGW0iwFs8nJi9CPylSNRcD5G67UB/F
 xYMxkjzbAWCsfOjnXyxa1lQ3ziu4/8asu6TDdpi4QD4qaZ1JXCYafT6FgMeM9NygF8srD
 QfwSvvcQxVaSmCGZyB5Fvexo356nBTowLMSACsX7r6E4BoH2HrzIX3QOtwVVZXLdGJLEF
 H3z8yH+47tU5416B6H7DYXkZ6VN5R602KExu5fF5CddmRMDdnRPugQpq+jCOCEPUP9YwB
 Hy/fr1ikiyJXQVZSUWzPhTxyDn9ImvCjq9hmk1rBfrg4Rv1Y3Bn5WN4V0Xg8nUKmGIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788853438;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=jdIfhYBDkAEP26SHhS2ZssmJKex49Vvcb33LDCS4IDQ=;
 b=Z14lgFof8jtZeRzCiN8SluF7c/U1+ERVzFtBsYVh7NOCfC9Ije8P+2DEO5mMtmodY2JZ
 kHnWDoR0RFQ5IFj/jp4dkDIsEPkd+LEr7ub2vYRH3PMkjNLKO8KcVDuVi3dAGScVfffbP
 BW7ZtS/vGcHjSg9Az+J316TMbfs4q3W2whmMmSGtPlGems8LVjyIBzXn5P5udK3C0z1wC
 g46FFB504ufUBSU5PcgZ1YJpGJfamOuHkM/qcYaBqExnIUD4Ux4FPJu0VmPW+QrcRRjGB
 CBb2b1Rn6fxL8jPdGVXX5CcpLzEyr+CHqHlZKTvOM9wEN+ZKxlniqmnjismWdKHHQYg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=wCjJ2iVG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=wCjJ2iVG
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 934FF605E5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nDwDdDcLvWml9Z6RXkPzZY4VF5a8MBtDvCx2sC/mTVb7fkJMX0LTvIY50rT4lpcUxQRghxvHvJH2afNzmsuFNB3loD5TXHWvjk3Pkhk7koygIECL/n7XbH5GL5dODMpYAmROO1GQDG99wNmVWbPNgS4toPleNnxm9f3F+Ka3mQDOONsPlwQm8L5SBqStyNPSr28RpgmPVwC1pL7eXfL3YL023DKTRLJhFkksWGNPgWCsEA9qVlD2FqCatgegSafqc/nQAcU2q7rVGeMPp+Ckmre66esQErbl/hkcBzYUnhOZ0ymz3mv4bx0bpGlgwMs2pchRcxU8AWwLoessokXFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdIfhYBDkAEP26SHhS2ZssmJKex49Vvcb33LDCS4IDQ=;
 b=zTSIGedaqbEU1GM54AvNjvM7YdTjp+WJf8pf2b1akLuTi6UTpBdZ6fAgtkLAluSxGMdSUKdsAByZNkt0UigLIsJCKbnM3flj6YsjdNvw2Bob6J6kdNsOvz3TFIFDPaBWN8trXGZiPIkUggzMqWhrlvXoKEGAuuyCRrOSb7EVs6cXhO9kXJrAt1Jvi4kWMl96rlr9RGjctueor5qMPyvKO2NQk47C8Npr0zQuhUz5+oAaMsr2+cimMj8rBGwWAWDdjn1Npf7j3n+4EbQRMZmPxoNtjpx3M6qtwk3cYuCLYx9b9wr170Ho3HIAZMg0wH4taskBGFDsY6rpNmw2I4tNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdIfhYBDkAEP26SHhS2ZssmJKex49Vvcb33LDCS4IDQ=;
 b=wCjJ2iVGpDJqaU7awAiEPZIoEI0d4U8snuw6fNDquqjxCLrt3zZ7K1WiPCznWs53G3EemIvlytfgiLdk09orvPfrzItipnYi4jHCLQzRxIrj+0LzjzeVL64lRoi8WgHgUTck1MGhg4Ahbc4imbMKf54be1IeZ4C4jVVrftkRHgLVEBN04edFFJHycSMgliMuGPZ8vQEwQ1PkyzADOWfavBIC3B9wSeWbTc2TlqTgdw1b5fpgErFPSigKzGa8tdICi/Jb9xPPaeYRXGiGf1mNp3oef6AqDaSfTJZvpPk/qb2YltRQPhbAjU6tJfBJBp7tR4CplsR/N9VQkretEEocOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BL1PR03MB5991.namprd03.prod.outlook.com (2603:10b6:208:31a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 07:43:54 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:43:54 +0000
Message-ID: <b2169c72-52d9-4d6b-b49b-3b31fdf404e1@altera.com>
Date: Tue, 8 Sep 2026 13:13:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mmc: Make "MMC Device not found" a debug output
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <57a99d87a25d42f68f26697b81fafefcae29abad.1787514446.git.jan.kiszka@siemens.com>
 <DL9QY4SX994G.I90T7GPS8GRG@linaro.org>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <DL9QY4SX994G.I90T7GPS8GRG@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0205.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::14) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BL1PR03MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cfa278-f6b2-4b64-6dbf-08df0d7cee84
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|55112099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 4vcq5XRAUFCjsYYkKd/DBItYDryC8owOcZDTqvMQJ5ydWRakTqQxDADOnJ1oaVTD1VpSsxZ6XkfctmYOnuxyWd5/5gPqJKeXAXsT8KERLu6juibaSXV3oCQrpt7CkvrBCHzw5G/LUKgETvI4/tyOKcilPhZEn5FQjd4zIb/GGBMoGwUzYkkSbrrGJ8vZ3mk3c7rDQy6+W17qTAnKaubVWzp0U6MS5/mkrQoSs8lTGkYRYhwU0y57I62j688zDmABGeAF8KKws9/5dG/dr9TaKL/580KzI8rK4bh/kXUam3A6jQh3KRviTc+OScl71GEDFYwHbCuJ15Atqx4QLztDhgeuKVFbf/ADGRlxPQVy0+XBMvI5OfUewkROyBbhepCevr38MtWgD+iny1li+eq1AtLwGotOBPKxX7UEHmJ/9f/M2zW9cBxxT5NvjLeC0aAddH08NPLXd7Ay6rRj9XK6Sk+fQoxPCEZNrzzbfZD6dGatfEiSxAAkzdEwJVOn0bM0ajGLGdlvXJK3+yv8/A60Ft8PxfnKUrCSHAJXQ8SsvqsgJhCRYJeK6O3DcE3tWQpo7/8sznvwwmG4RDWVU+Qn9vXQUGj/7Otli/9tRNFLvJR0myE3oacsOqIG4r3vgFMhSP5hOpshVaN5juHyaNWqBIMdQhuF+SKmOrtOZ0VKxcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(55112099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRxcDNFMXNiaTBhRk1WaGpRQUNnVUMxZWV4WGVSZHZMZXpmcCtsU3ZQQlRt?=
 =?utf-8?B?RWZzSTJZQjBvSklDVmZta3lkMFQrRy9UckF2aCtYazNoN2pwSTVtNUFZVWV5?=
 =?utf-8?B?cUQ1NDRiZnNmYjVTbVlWWEVzb08vNkdBOGQ2UzRoS28yMllkQXFSS09lQjVP?=
 =?utf-8?B?VDNkWTZyZ2VMZ2ozWkcycnNlSDNaYUROUFFCNERiY2drWEFSRysweDFWd282?=
 =?utf-8?B?V1N5Y0gzTjhoWWNRbGpNeTd2M29tbHJLY2JhaFYzRis4NjRsV2Jia1BQK0RG?=
 =?utf-8?B?NzI3R295RkxqZ1llYkkxQ0I5RHhsT2dKQTVFeE52eFpZcXN2a1JRVzQzQWFM?=
 =?utf-8?B?OEw0TThnYkxKSmlPeW1NbGlxWU5pcDV4YlFDWU1yc3dZU2Jwalp3YU0xYVB1?=
 =?utf-8?B?bFBwdG5Dcys1SjlGaFd4cUhjTUdnUncwaVUrOXllYmF4eGNpYmxZY1ljSjdv?=
 =?utf-8?B?UFd0d3pyODlnWjArT3BKbFVkNGhxMnB6bENqblFjbkJSRlhpR0RTdkxWSlBR?=
 =?utf-8?B?c3h3UUwzK2ZocUpBR2NNSlB2TXVtNnE5ZWphQ1lpdDNGMkpTdGtWSXlUQmRY?=
 =?utf-8?B?OUtNMzd6SVI4REg2d1V3RkRic2ZBcXlzaVQ3bVlPUlptZk9URUJtRFZtUVdL?=
 =?utf-8?B?MjZ2b216WDJydmI1OGN3dHNRcjJoTjJGRlk0cWQ3UUFjdDZYU0hiQmNYVW0v?=
 =?utf-8?B?eUR6aTQ5VFpPVGJNaG5pUFQyTDE0dVZrcERyMHBNbkVwYmk0TUdqcElySWRx?=
 =?utf-8?B?VXhCV3Q5WjVKbWwyOVhIOGJMYjFvdzc0NDZXSVpJQkl0c0thajU4S0VaV2w4?=
 =?utf-8?B?Ui83R1pIVGh3T2N1MzFEQmpiRS9QOGk2VnRIWXdHcENwRVIwd1dOUUFYVjRB?=
 =?utf-8?B?N0ZobjJSOEhwVGJLMUV5K0ZIMUxuaTRuckpKRnIvd1hBVmRhbU5aNFdmK1Nr?=
 =?utf-8?B?V09UTDZnaGVnUzk4MkFBNExYRFB6Z3grcCt2ZldBR09YWWVidUpSVXdwdnR1?=
 =?utf-8?B?WGN2VGVkZlU1YW9EQmVUdERqb1RuclRrZjB5Y05obktDVzJnSG5MdjVGUzdq?=
 =?utf-8?B?U01ZeFRZQ09KWGZZYmwvTHNieWNldmxMUjYxQU11dGxPaVo2VFR0TmxIUWpM?=
 =?utf-8?B?KzRDNkJoU3hKZ0p5Zi9nTXBQMHlCOWpTRWRJUTB1SGJhSmdIK2JKd0MyNVFk?=
 =?utf-8?B?ZWlhQlBVQXg3S2tERHFsdmY4T0pBeWFWTWdqdXpuRmJhN0dhWDh1blhoL0VP?=
 =?utf-8?B?emFlTjYvNjdQZUNpWWMrOFE1Vzg4RmpYSGNLcnRYRGowOXlXNk9sNXIxSjlI?=
 =?utf-8?B?ZFgxSU9RTk95MFcwRGhpbDRWZy9LdVNITTZqemd5cUVuSFZCMEdhV01xV1RE?=
 =?utf-8?B?Y1lYcmhOUHhQNXFKdlZ4RlhoZlM5Q2F2MlJNY29CbVArMGJWR01HU0pONUZk?=
 =?utf-8?B?QjlDYzh6NEZ5aFJkSTVJUFF0NlRIOFhzanVFN3BmeXBPSWJtRE5WZmxGLytJ?=
 =?utf-8?B?T0JSQTFOVEVRVlpDWnY4QWVGT3BNZmJQdUtwT1lYMi9ZdDV0MDEvQit0THZY?=
 =?utf-8?B?OFRBdWFpV055Y1dEMmxKOHBQdEZ4UHNycEs3QUV2UnhCRG4vR0hHZ20vS0Zn?=
 =?utf-8?B?R0dZNldNb2hiYTlHdE4yVUNmQnMzRTdNbm9MRnlYRHRIOFBkNW9vc2VJNldx?=
 =?utf-8?B?UmVRWDRBd1lLOGx0UHpuRGlsTkwwUFVEaGpjZ1BadW5FdnkzZTJtcytKeldM?=
 =?utf-8?B?MVdjU1lrQ0JabVhhK3BHUXpjUU56WDc1d0JXV25mWXg0enhPRklBQytGdm1E?=
 =?utf-8?B?SVhlZWR4QjJSQ3R6eVBMdko0NVlST254KzlXeExpRHV0M21DTExaekVQajRs?=
 =?utf-8?B?dng5YzBPc1pMeC8ydCt3b1lhYUlNbFY1d05SV2xWKytLUENJNFgxZDJsSUZC?=
 =?utf-8?B?TFc2VEUxOVEvcUcyUFNXbC84OERjVE0yRmlUWFdaSnBVWDVUL3lmYzlPL2tF?=
 =?utf-8?B?SVIxYW9TVTg3eGMzOUpjK3hqYkJhSWsvNGxrRm1hcms1ZkE5MGRaejlwYmEz?=
 =?utf-8?B?Q0RES01XNFcyVmkxTHM3UnJCNEVvR0d5c1NpOW44dUQzZHZYeVRZUkhJanZY?=
 =?utf-8?B?MzBzOUZvbm40dWRFZFFUd1JZSDdKVndYbkVaZGQwNDFOSkh3MlRuUWordmsx?=
 =?utf-8?B?a25RMG1KS3J5TzhaMjVhdWlaZGlyNGNpdkdnZjFwbGQxVVR4Z2Z1b2xwQkxy?=
 =?utf-8?B?NkdBSFg2QjNGZVhFY281ZU1CZ2tkTHV0cjVuaW1CSDBWRmY3OTA0ZE1UUkRW?=
 =?utf-8?B?VjAySHRDQ0NCcU5QY3JpbyttT1lGWEhDUzc0N3RLMm9kTTFUeXM1SzRIS2Q4?=
 =?utf-8?Q?b7iBX3MqTY+bAoO0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cfa278-f6b2-4b64-6dbf-08df0d7cee84
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 07:43:54.2166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqu9mgKajvaP5iThv64yi4QCSrDSL57fQGXaMssgvY/5/htGlJQv7bxddlO2JdaYWOka7KbSrHk9weYmntKegyFUc0tDX9MR9U4gBtvaCNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5991
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


On 9/8/2026 12:42 PM, Ilias Apalodimas wrote:
> On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
> [...]
>
>> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
>> index 698530088fe..ec16899f92e 100644
>> --- a/drivers/mmc/mmc-uclass.c
>> +++ b/drivers/mmc/mmc-uclass.c
>> @@ -319,7 +319,7 @@ struct mmc *find_mmc_device(int dev_num)
>>
>>   	if (ret) {
>>   #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
>> -		printf("MMC Device %d not found\n", dev_num);
>> +		dev_dbg(dev, "MMC Device %d not found\n", dev_num);
> 'dev' might be unitiazed here on failures

Yes, good catch. On the failure path of blk_find_device(), 'dev'
is not guaranteed to be valid, so using it with dev_dbg() is wrong.
I think debug() is the right replacement rather than leaving printf(),
e.g.:
         debug("MMC Device %d not found\n", dev_num);


>
>>   #endif
>>   		return NULL;
>>   	}
>> diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
>> index 8f8ba34be71..573521842f6 100644
>> --- a/drivers/mmc/mmc_legacy.c
>> +++ b/drivers/mmc/mmc_legacy.c
>> @@ -45,7 +45,7 @@ struct mmc *find_mmc_device(int dev_num)
>>   	}
>>
>>   #if !defined(CONFIG_XPL_BUILD) || defined(CONFIG_SPL_LIBCOMMON_SUPPORT)
>> -	printf("MMC Device %d not found\n", dev_num);
>> +	dev_dbg(dev, "MMC Device %d not found\n", dev_num);
>>   #endif

Same for the legacy path, which has no 'dev' at all.

Thanks Ilias, you are right. Dropping my Reviewed-by until a fixed
version.

