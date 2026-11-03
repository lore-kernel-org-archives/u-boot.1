Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F4606A329
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y3ZSw21O;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZsddgnLe
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1FD880DC1;
	Tue,  3 Nov 2026 09:41:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R7_ifJdsGpkg; Tue,  3 Nov 2026 09:41:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2F9A80D30
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793698895;
	b=hQr54LOFtc3N7g2l/ITppMMqbR6qlpPivgAA5x7+Ob7haM+YZkXoP+9ciSgXVtUDIKRN
	 gLC89FFVtWw2ju+MY60AFn9EkUs9jfDY3XB/euxoQI33QhjCFI7Ycms/Bm62ORvxu0UYh
	 lIPUyLbVIxnK1fhMyr8I2mfb/6X9gtTxmNl2FVN/PwDj3kBocVSyBn0zSfEQaenMGmugq
	 PpcQ3LqPspLF4RncJJVOjKIMITJ8KMtfMtdqz/LhBDAAFH48CFPXfKOqEMG3NIUKZ5GID
	 JUkGSfvt4LLL9Sza37lSfs8Avtyj8+BKpCw9/4HUp+Xm0+0nADYkvobnjSEIHa9miKQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793698895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=oGyDeKqzSSlJDLnDf9FKqpvy2blwPHfWlPLcjUOdmFE=;
	b=khLFq6nwmZ+t+K3Y8oN25iOztOzdmRdHS4LW+b33bamhttn7bmPwyGP5b+cmgoERoBUp
	 qwm+I3Ej8rIUbqa+X7FOARGPunnnPVnDS76MBWhgKSEeTo7yO3l3Rdl/9fKT+huP2GjH+
	 g+B8x6AYvfFelsAhkGKr5mg/5OqbETSlQesbLSPy9T7qiuapRmjBtdN/KVfn4kJ2uGXxb
	 CRRbNOnzAtSZS5m0yC2nbCZ38Y5F3d5Bde6K0pP+PT2X9zI681ZL+35S7/ilIy5Hr7+gM
	 ucq3RByf0ELk8jczq4QiYP3eIj8qmfhYjp7/e9SGzIGdsE6RvX2x2h6mL2tUYiTMVsw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793698895;
	bh=oGyDeKqzSSlJDLnDf9FKqpvy2blwPHfWlPLcjUOdmFE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y3ZSw21Oo/fpYuJyCY8UkpxEAhNFC74gFe0h3zeoG2UTg9sPor6l5O+GaNftWRudW
	 QKCgoi5IYQU+um67wCwRKC53jbUqMkbnZrduNdwog7W9IFVp3G0HxlUqfJltWPuQ41
	 ULo7Ly+412YfdKHF/e/ZIOYIEReKaONv+/aq7oUlpfU/Jvi34VoZoDRShglAwdPSSL
	 X1oSVIioOWLcGI7jgcMP29e9INLsoiEzoDOdTqZlpJUmsIJcxw9wvYTNHQ5SGZecJG
	 TAwroU/5PrEXBYgiVgCK7uuZm0L5p7xosL2E1W6vS/hN9FDVThp2R9gxYBjLhfmK+F
	 hbMgrwWI+g9aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2F9A80D30;
	Tue,  3 Nov 2026 09:41:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 84068356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 662AC40586
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zc1SROc_48N0 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:41:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BDC5F4057D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793698893;
 b=M6Ih7PY4w9xO5c7Tinz7SXFuwL1G3F8+mMzVVxGWP2es09XexSlP1EVh2dgyGJ4R+g2s
 uJ3O+M2ZMOKiZ6dy7spj3tPmdZVAVhjUVvUStz9avAFhaEPtGpPNdkkHU0y7mwRixHJuw
 7hOdzR06v/vwqX1NKh6CuLkV9S1mObUt0PlbvbowQKe8osNZMZQpvFyRGtNsKE/4CK1UQ
 8Kgq2YEPc0yLL26VpDZV5GYwhaHB0qrKEkQObnz/WjA4Lm0Myf1EASOLKsbNgyWpDSSLM
 bbwEK7mr74yyWXrY8Tlfx+FD69u4CPGzMtj8yH2+bUejuNGX5YfG8rP8kPDWkq1Tzdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793698893;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=oGyDeKqzSSlJDLnDf9FKqpvy2blwPHfWlPLcjUOdmFE=;
 b=Wl4bFSR+XoqRIzl5zAhJabOoKLKT6rHs2RY71nWUjk0prgFIiIQSF25+LYRDRRZBS70F
 UERiCx/NUlVNxOzR+a+Pfn1b28KoUoVstAsezd+BHoAyLRUYaTYhxTWyQIMqB6lkoQN1F
 3tvGwMFxoFNa7rZKHcKATry8MkUe5IGO2/ElBb5/0rn0N5dNt81zjJPE5wh4e7xRpVK1f
 UkLCqThefvCKDLJlreK4ZQEQryWcJTxr8uhXixGR/yaejs1CZIGruBa2q8gmkj+oL+3/U
 cx7QyxXe47H8uSWeZLhPwpIYkXMiwlQctXCXuY+TJ/9Jv7gfYhCM43trKjG3C0Rsl5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ZsddgnLe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=love.kumar@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ZsddgnLe
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDC5F4057D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ca2Wr2p3QFmeRIWDaTTd29nE8Adq4rZIZWKwUg0Wx8JvJRUun4zZGJ1aU0LHVYn5Cs1EiKIsr8CHsi4SfNQWqn3kK5q95l2erE+iIAV7BbT6izFSyo6NFvBsFeScVN2OMz4bCqyU22ewodnLm/Q3kuQUMKpwAIRrf6dNfPGYBN9Ak8C78yj2lsea24TKzrK0PjIfs5V+9FyuZuFH03sHpJyT2bB9suB54hMA+S199gR9JYaIQd08J69jf6CYv6qwRt/Baz5QFv38n4NChUapq0yxmMvfj2uu0HVlxozZJQx3CEkyVm0N1R6VqA2okC9e8iXDfEQrkSVMDWR15jOVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGyDeKqzSSlJDLnDf9FKqpvy2blwPHfWlPLcjUOdmFE=;
 b=Ao2DEFyHNkPzGGeFM+bfGAw6GsnWLZWGYQfTX6y6lDTIVwq4Gdb8MI0UDHYXVnkKe8kjPx9No+wkmBWj7mphIN2KUKWD8XhKriy6QDKnIRsbRmLgOlM51sKUEtOi7tR7xNi+LZ3VcZ3u/i33LBGae2GetlARKvAXmi09qF5nJ5ywM2vc2rSnq/ogCnM/i45PLeWSbcxneaIUqh4owIn0BvTCvZiGEpNhP/yG1EpEx+xnDiLH4sVJh85MA7oWQiPld9lM5LwK55yjLxKz9YLX5y10SY3suLSysMrEIQIe4c1wssy7lAcUDxH9JchExBi1Ze27hO68vsQ6f4urpMIdiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGyDeKqzSSlJDLnDf9FKqpvy2blwPHfWlPLcjUOdmFE=;
 b=ZsddgnLeugnllAq2mUPHKBb8Lxh+AqMb7Ay9qXabDOGSM0FG04/kkUoIcFMMnOsdISqkGU5Chv2nefNoXpP8qaHLHxpRnOq1hr49YLBa9E5BS1cTcAkNcq8BIoXLH/7KUNCOVw+vOcEHUvT+S68jkKpw5mPha/aZbELyGpfSVSw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB434898.namprd12.prod.outlook.com (2603:10b6:8:47e::22)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 09:41:25 +0000
Received: from DS5PR12MB434898.namprd12.prod.outlook.com
 ([fe80::a2b4:c80f:65bd:1412]) by DS5PR12MB434898.namprd12.prod.outlook.com
 ([fe80::a2b4:c80f:65bd:1412%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 09:41:24 +0000
Message-ID: <3160bcb2-bfa2-4e43-b5cc-de59b6477638@amd.com>
Date: Tue, 3 Nov 2026 15:10:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/63] usb: dwc3: part 1, reset and import from Linux
 v6.16
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0135.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::11) To DS5PR12MB434898.namprd12.prod.outlook.com
 (2603:10b6:8:47e::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB434898:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: f43adde8-1cf0-4487-5a67-08df398ea04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|376014|1800799024|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|11063799006|56012099006|22082099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: +xs9ooNakWU/IDxeLT+Ktrwf7eYeXkITF4AKQA7lsYgAJjYTkQfx7sX35hoMfZlbUkKsUlqFZmWZGK5CseryN8vwOQMrMRye4Qq70zR1iRCV3ffuqBvSKDa5bZaXk8/2nHc6C3BlMQGWAH8eNmmJxEUWSEc6uw85JXiCVfOjnTOMIz6BZtR4C3hG75fRADvK5xbfW/WYL/9ZBEV97Z8t/04G2DnWW90lnGy3BUHhNzdmqwiBFVyXH3UpTxznWDW3M/SXVVHkBbtKwkw9kZdkdOguTmDxGqOOOyL6UwNHTON/ogcKTzK1vV/TF3td20btB1er6ek8NeFud1T8z+qBnVekCo4X//A0DPzlHCMIgYtjrCy5mvmWENpCdCdNu2NtQ3Z6YMovRL/34heRrAK304zodsJKhXlRXHubBeATJ2pTPSD/O3F1G/U4cE2op6FIGfROjh8tynmgVO2oSTZ6WSbv9h8VBpek1lZWxL+tfV6cAkt3dMxX7SU+RDA+ujWlYGMmXXJelRrX/lRFcoJM62upp+BnIZIUgSe/+GD2uCiHxmCZHcO332y9A594ebwfuf5vBqp/rzOVZJvjn8OtCMEtmBqOXCtBKNI/Bra1CAzC6eV2Jh5FpYxgAYSoWDUs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB434898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(11063799006)(56012099006)(22082099003)(261102123227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1dxQzVlQ2lXRkhmcnovVlFqYXNxU244d0VqTGk2SXlFVFQ3NkRLaWR3RjRS?=
 =?utf-8?B?QU5BdE9DTDdWMnV6c0M5MzlSTGlBYjg2NjduNUVBRTVPeXZSYWNCOGtmUjFL?=
 =?utf-8?B?YWRLNnUrYWdzRnJzTW84Y0czY25jTDUwTHRmYkVmZHR2RkdPdStTK01nWC9x?=
 =?utf-8?B?ZGxyL0FKWUJUN0tQTjZ4dWU0c21tNytiUEozamRnR1RHejEzNlh4YktPOHZL?=
 =?utf-8?B?Um1zZU9JcTJpdUdXZldueDdUM2lTWUpMRG1tVjFtMEZvbUkzQVNqSFY0eXhP?=
 =?utf-8?B?Yi82ZlhSeXVjb1VCQ01UcUpwNDJjMGNVaEZpTkdVQ2pvQzV0SGhZUndHWTEz?=
 =?utf-8?B?WHJ3Mml4TEVqUml2Qys2SjZnNk5yc0pyNGg3akU1SnBoSnJEY1JKRFZiQzRO?=
 =?utf-8?B?TmxmYmo0TW5sOUhXcExMZmVoakhTOUZFV0V6bGVHNkVOTW9FQ0lxa0RudGJ6?=
 =?utf-8?B?eFZlNkZ5cFBORUxERExhNHdQdTVkK1hDUE9Eb0Z2c2hJWGwvNitSblNmOTJu?=
 =?utf-8?B?T1laTC9sT2ZrcWRTdTljdWYydFBzMmVBZDJhemlXYzFTRGFJMURyNzE2Z0Rz?=
 =?utf-8?B?d01Ed2dLcUYrTG5rcXppTzdjbFdTaFdaZ0ZGMFVId3JLNXNTRFd5S25SNkkz?=
 =?utf-8?B?eWF2ZEcvOXRsYWZZQnAxTmpURnJFSi9oMUwxaG1XS29CV0VnblZPbGJtdFM4?=
 =?utf-8?B?YVdsTDAvamtKYW9vTjdKK245djBLVHkyZ2FSSUR3em5UVERXellnWnZlM0lh?=
 =?utf-8?B?Yyt2QXo0VHp6bEkyWm9tbmdTUGFrYlF6b1JBTUViMUlhZk5UQ1BhTXR3SGZr?=
 =?utf-8?B?LzQ2eWx4Yko2dlZSa1gwZ2FUWWJmUXo3a2xRMzFwYXB0Zm9vemF4SEd2RGJz?=
 =?utf-8?B?dnZrTlR3bFRZMXIrZWF4T2YwZVRBVkJYdU5MczNOQjBXNytnUzFUbzcydGRq?=
 =?utf-8?B?OGcwUkZjQXZDR2V6WSt1cGhDYloyaCtsNVVCN1pKNldVQmtYNFVzT0l4bzlX?=
 =?utf-8?B?RUVQeWVFVE9oSUJkTGVsb0NjNE5zeGdhNTJMZTRiY2V0c3N5dnZyNVpxZEtD?=
 =?utf-8?B?TFRMdWVhQmsvczVOVEpWaGUraU93OEVsYlk1UnJhRG9IbzJ5K0xtTlJDZ2hH?=
 =?utf-8?B?cElCTFVJbzBXTFNzTGlGdDZNUGdqWjB3WHFXQVRlcEQzSEJEQmJOcWtDM1VY?=
 =?utf-8?B?Y0o3ZWJOUDRIUS9pNUZFelJqOGJXeVVlUXVOWkpjcUtvektHSEgzOS9VOFgx?=
 =?utf-8?B?aEJNZkFRM0g1L2ZCTk1yQ2N1QW1QclViT1duUzJHMVV5LzZRek92WEtnMVpX?=
 =?utf-8?B?aUQ3MkJDRml3T1F3b1RFN1FjU0gzR3BnbVQ5TFBaRXNLc3JtcCtGTVBpWk1x?=
 =?utf-8?B?YXJDU3hQaDJ2L1RDWmJ2c2piUVg0WTFZL1F1b1lrTVNrVDM3a0cwaU95dXRD?=
 =?utf-8?B?T0JmN1VzUlp0WUU0aVhKV1NrdC80dVR3V01qWEl5dnVXZlVJODRobWd3aERC?=
 =?utf-8?B?ME9tcTFOYmRyMUo4MG9vWDJlWllnOElUZk9Jc3VNSjhBN1IvZStDay9UOWtq?=
 =?utf-8?B?TFQ2K1JBRXE4cUIyb21LVVJMaTNuL2RPNmQ0OFo5aFdpMEhkL0U4UlZEK0dy?=
 =?utf-8?B?ME9vbEl2NWRDTTVMb2doVVhFRFNRMFZDaURHTlV4RDV5SSs1TG9LUk56NDVr?=
 =?utf-8?B?SW9Ldk4venBLcjZidHpVd2haMEZzaDVYY0xoWUxTcmN1bzlBTERpZGpySWdj?=
 =?utf-8?B?WUJ4ZWRFeFlXWnRDV0dYaUoxZHYxMXVlSlIxREorRWJsS0RuVTFpOTY4b0VF?=
 =?utf-8?B?cFRMR3FnNHlMcmV0cjR5bkN1QXRtbnNRbmNrV24zUWhQTlZCbW0xZFg0UHNy?=
 =?utf-8?B?Z3Jvelk2VFNKRHRnQTRKbXNaWW9LdEZRai93RTZuOGFzZmdRd0F2dVlNa3Nl?=
 =?utf-8?B?aldLZGNtek1FMTVVV0lobTlPZzlRR25DYVdKejYxdFNEUldCVm1EUXhTdkV0?=
 =?utf-8?B?UjJQZFFBcWU4d1MzWkU0RmtORzBBMjVFYmhPMk1BbEhNYWFwM3FGNlZxRllh?=
 =?utf-8?B?Z2NjRHJYVVJpV28rWHc4ZWplbWdpaHZ4RmZZUWQyd3ZYSjlwRDdRcUlnSnFY?=
 =?utf-8?B?TmhCSUMxRmp4eFJ4YmNCTlJZYURJa3ovV3BuZzN1eWlsUGYxSGVkYWgxNDVR?=
 =?utf-8?B?T2tsZ0hZM2t6T0NldmJYS1VFSVJTaHk3TkI3ajVMdDhFT0IrNFpnR2pjWmg3?=
 =?utf-8?B?M0JTU0p5Z3dnSXR6MGlBbmU2WUt6d2VJdEZCU1RkM1NMVkpqVEJBMWdySWtF?=
 =?utf-8?Q?+Iz4ytGnvHkkJx7Jf3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43adde8-1cf0-4487-5a67-08df398ea04f
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB434898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:41:24.8707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GZeEHUL8L3ka/ATJRcFJfJnrc17Q9gebkr623LLuIc+2zeiKPEGA7G8hWjrUXhz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 10/28/26 7:38 PM, Anders Roxell wrote:
> Hi,
> 
> This is part one of two. It resets the DWC3 driver and imports it up to
> Linux v6.16. Part two [2] follows right after this one and makes the
> tree build and work again.
> 
> Part one on its own breaks the build for every board that enables DWC3,
> and USB gadget stops working. That is expected. The two parts have to go
> in together.
> 
> Part two lists the boards that were tested on hardware, with both parts
> applied.
> 
> The driver was forked from the kernel v3.19-rc1 eleven years ago, in
> commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel to
> u-boot"). After that almost no kernel changes came back to U-Boot.
> 
> Part one is three steps:
> 
> 1. Re-import xhci-ext-caps.h from v6.16. Marek asked for this one to come
>     first, since the dwc3 imports build on it.
> 
> 2. Restore drivers/usb/dwc3 to the v3.19-rc1 import. U-Boot only files
>     like dwc3-generic.c and samsung_usb_phy.c stay.
> 
> 3. Import the dwc3 directory once per major kernel version, from v3.19
>     up to v6.16. Each commit is a raw snapshot from that kernel. The last
>     two patches re-import epautoconf.c and udc-core.c the same way.
> 
> The import commits are raw kernel snapshots. This is on purpose. It
> makes it easy to see what comes from which kernel version, and to
> compare each import with the matching kernel release. The commit
> messages say this too.
> 
> The branch has both parts [1].
> 
> [1] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v10
> [2] part two, subject: [PATCH v10 00/30] usb: dwc3: part 2, make the
>      resynced code work
> [3] v7 part one: https://lore.kernel.org/u-boot/20260824152734.159794-1-anders.roxell@linaro.org/
> [4] Marek on v9 part two: https://lore.kernel.org/u-boot/4b24f045-7fa1-4be0-8993-2bd441a7e716@mailbox.org/
> 
> v7 -> v10:
> - Skipped v8 and v9, so both parts have the same version.
> - Rebased on 8649a54d301a, since v7 did not apply anymore. The restore
>    commit conflicted on dwc3-am62.c after commit 83abf9120071 ("usb:
>    dwc3-am62: check dev_remap_addr_index() for NULL"). It still deletes
>    the file, and part two brings the fix back.
> - The restore commit keeps samsung_usb_phy.c now, instead of a patch in
>    part two that brought it back. It is U-Boot code and was never part
>    of the kernel import. Marek asked for this [4]. I kept Mattijs'
>    Reviewed-by, since the commit only deletes one file less.
> - The other 62 patches are unchanged.
> 
> Older changes are listed in v7 [3].
> 
> Cheers,
> Anders
> 
> Jens Wiklander (60):
>    usb: dwc3: restore to original v3.19-rc1 kernel import
>    usb: dwc3: import from kernel v3.19
>    usb: dwc3: import from kernel v4.0
>    usb: dwc3: import from kernel v4.1
>    usb: dwc3: import from kernel v4.2
>    usb: dwc3: import from kernel v4.3
>    usb: dwc3: import from kernel v4.4
>    usb: dwc3: import from kernel v4.5
>    usb: dwc3: import from kernel v4.6
>    usb: dwc3: import from kernel v4.7
>    usb: dwc3: import from kernel v4.8
>    usb: dwc3: import from kernel v4.9
>    usb: dwc3: import from kernel v4.10
>    usb: dwc3: import from kernel v4.11
>    usb: dwc3: import from kernel v4.12
>    usb: dwc3: import from kernel v4.13
>    usb: dwc3: import from kernel v4.14
>    usb: dwc3: import from kernel v4.15
>    usb: dwc3: import from kernel v4.16
>    usb: dwc3: import from kernel v4.17
>    usb: dwc3: import from kernel v4.18
>    usb: dwc3: import from kernel v4.19
>    usb: dwc3: import from kernel v4.20
>    usb: dwc3: import from kernel v5.0
>    usb: dwc3: import from kernel v5.1
>    usb: dwc3: import from kernel v5.2
>    usb: dwc3: import from kernel v5.3
>    usb: dwc3: import from kernel v5.4
>    usb: dwc3: import from kernel v5.5
>    usb: dwc3: import from kernel v5.6
>    usb: dwc3: import from kernel v5.7
>    usb: dwc3: import from kernel v5.8
>    usb: dwc3: import from kernel v5.9
>    usb: dwc3: import from kernel v5.10
>    usb: dwc3: import from kernel v5.11
>    usb: dwc3: import from kernel v5.12
>    usb: dwc3: import from kernel v5.13
>    usb: dwc3: import from kernel v5.14
>    usb: dwc3: import from kernel v5.15
>    usb: dwc3: import from kernel v5.16
>    usb: dwc3: import from kernel v5.17
>    usb: dwc3: import from kernel v5.18
>    usb: dwc3: import from kernel v5.19
>    usb: dwc3: import from kernel v6.0
>    usb: dwc3: import from kernel v6.1
>    usb: dwc3: import from kernel v6.2
>    usb: dwc3: import from kernel v6.3
>    usb: dwc3: import from kernel v6.4
>    usb: dwc3: import from kernel v6.5
>    usb: dwc3: import from kernel v6.6
>    usb: dwc3: import from kernel v6.7
>    usb: dwc3: import from kernel v6.8
>    usb: dwc3: import from kernel v6.9
>    usb: dwc3: import from kernel v6.10
>    usb: dwc3: import from kernel v6.11
>    usb: dwc3: import from kernel v6.12
>    usb: dwc3: import from kernel v6.13
>    usb: dwc3: import from kernel v6.14
>    usb: dwc3: import from kernel v6.15
>    usb: dwc3: import from kernel v6.16
> 
> Jerome Forissier (3):
>    usb: host: re-import xhci-ext-caps.h from kernel v6.16
>    usb: gadget: re-import epautoconf.c from kernel v6.16
>    usb: udc: re-import udc-core.c from kernel v6.16
> 
>   drivers/usb/dwc3/core.c           | 2961 +++++++++++++-----
>   drivers/usb/dwc3/core.h           | 1087 +++++--
>   drivers/usb/dwc3/debug.h          |  432 +++
>   drivers/usb/dwc3/dwc3-am62.c      |  424 ++-
>   drivers/usb/dwc3/ep0.c            |  763 +++--
>   drivers/usb/dwc3/gadget.c         | 4776 +++++++++++++++++++++--------
>   drivers/usb/dwc3/gadget.h         |  114 +-
>   drivers/usb/dwc3/glue.h           |   36 +
>   drivers/usb/dwc3/io.h             |   51 +-
>   drivers/usb/dwc3/linux-compat.h   |   16 -
>   drivers/usb/gadget/epautoconf.c   |  292 +-
>   drivers/usb/gadget/udc/udc-core.c | 1890 ++++++++++--
>   drivers/usb/host/xhci-ext-caps.h  |  158 +
>   13 files changed, 9864 insertions(+), 3136 deletions(-)
>   create mode 100644 drivers/usb/dwc3/debug.h
>   create mode 100644 drivers/usb/dwc3/glue.h
>   delete mode 100644 drivers/usb/dwc3/linux-compat.h
>   create mode 100644 drivers/usb/host/xhci-ext-caps.h
> 

Tested on AMD/Xilinx ZynqMP, Versal, Versal-Net, and Versal Gen 2 
boards. No issues observed.

Tested-by: Love Kumar <love.kumar@amd.com>

Regards,
Love Kumar
