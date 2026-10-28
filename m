Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98BB606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x7DT8OzG;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=AJVr0jPD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7049480D9F;
	Wed, 28 Oct 2026 13:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H43wWkiDW_ns; Wed, 28 Oct 2026 13:53:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A23A80CCE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793195639;
	b=ahHqt3hAzTEJI/RXS0Dmr5gE2vw/fnh1V4oNmw5ZLro4ydTxSiz9BhtOcQ9AkMqt9Hqd
	 dgp/EfP4E9/mMXjO+NUaXpXuCwWNI8PSX4CTuC0byfu0JbIBsiokS+TF+Vl0aEhI4G5pA
	 V24ga0LtG8uXA/kDNQf7TthJJ2tpP7184CPo9k55dsPBo0O52bxqVJbzsCVPqVO87kiPa
	 5yDrIxvlpfqBlE04vohcmyV4O2imO/fh8FpWyOjoPReujHG4Tcnbuuv2w8MHoeFhE6RTC
	 s/0YwOKFly76KVPayQAguA04Gh4hPf8EnpNpkytCKj6XKbaIEAxvy0SiYlE/9WmurOA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793195639;
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
	bh=mh2UY/c0wkFd6GOjfXBtp1nyTiBMfvNov4aAmOE9wNM=;
	b=fxrajD1u9pnLYAlKuTHhMD+uJ+4RarzyEvINmkvh0xDgQIxUu2nom9o7gHXY2gY9Hznr
	 50YZLjZ6Tw6hIm3rKbrYrvPN1CeGuYV2ypWjKDM0h0WvKm2no1s25EMC7fon1MmEOB4xa
	 qg43kzcxqjFF7qSvaXAjjFkYN3NJ3druZiDgz8WgEJdSRIdE/K+t0AN6se47fktGCMcgr
	 vGBJkZhc/McxFY3jzeZ67GqQwsncfJ3ojD5yqGH/++1bt7B2JNFhQvmOHn4oT+IXWOFe3
	 jylV6qLq677Uv3qonOtEkFwIbH3PKrbOYw6BxHnUizjE7YTxZaYDT3+9MW9SfoGrf9Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793195639;
	bh=mh2UY/c0wkFd6GOjfXBtp1nyTiBMfvNov4aAmOE9wNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x7DT8OzG58FT8F1beESx1hw/EKrdDx4MqXaFT+9m+gkZlhX/yEYOO3EGgBCUgXh+X
	 Q1ZYEEMxVHkxqeCQtzfEGilFK//az59Voz/90MPooj4t0Q+CCpPA7OjUaqXf8CwoCv
	 PEHQQ6IiB/2HhytUQ3vLtOhVjf7SqZ1Okeg1eAyOnbptc0ZpOxEmUQiFz/k8O5V4KH
	 hE9hN9Amnk6A0HnLyxaaEK1ryKkW9fx/iLO848hUBLPuHHBfnXViHgsp5wmSQELEem
	 khINMb57UBM14ZznpG6G/eBYBvUZYSK5zZslC3kg+Z44+HZMdzlSiEdM4UfL9J9Hm7
	 E7o0wQyhv2jaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A23A80CCE;
	Wed, 28 Oct 2026 13:53:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9C25D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D74C64008A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MpzW_W4M0l2a for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 13:53:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 297C140064
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793195637;
 b=gVjtROXdNtIIjPdGz0KjuataWXHWpIYzEieVsatjLfEIUkhvIWoUsE1+gruwYc0JCDK2
 3QLAAHyM8aPmvGlOEoONfjHoz0/zKfdAa07gPNXLHpc8wTBMDZxp01J25Yhqreb/qd+bM
 OSdJeo4VRggWVjFPbC1N5IPDMYrW1y07HrGbF9/1g7oWHJbBmwxLbqyNS/2vl4fham2Tm
 t5oQI5HzN06BbcZiL0OzxnGsS8QJQ1rqY0tzEkdTmhMCxiA5p8rsJxc7/+n9QU6Pv4lyX
 N0xmzvDVqDr2NdADSiDiRg/mF79DjJxAMxcvzF7blEEph3g7ZEROhEkl72R7iQZDHFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793195637;
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
 bh=mh2UY/c0wkFd6GOjfXBtp1nyTiBMfvNov4aAmOE9wNM=;
 b=B6AkzRxDivPUJPdOE1lbtfL0acO+ubTlAfZHhowCsxKjWOUnxVypxn+EBMa6FBHTE6ii
 cVzZHmNqr4XKzDQLALagHokODbDo0fzt70M8utjUpRyNyANXauqZ1kiy9W1YTZ7zP7iEF
 8bkpA9hRXWEjJqYwZj/X2sEjBWJsoGu4nN4AM+xnjIBdZugIWB0JrH+gKu3l3JUxmfBK9
 vvpneehfIi0qAGqZxIHC9UnlapGi18wEsK+K4hrK24hscubl1X0u+Ff/ddwAGBsgVLD29
 aDXJziCzU0stV4LxjGC+CuEPTNspWF4JGhwdtO6oRLG6yDfVNDM7//58a56HbUtx6Lw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=AJVr0jPD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=AJVr0jPD
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 297C140064
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxpSb8ZOtPT7hMOUAT8FWvL3KfOr5NhuCw4Lc2lhbkGbur/NXr+8OH6FK1hkpouFMYPNtTz2KEso7NUJmHyGf897QWtfef+vcIRen4iP76kHQ8/T+kWP9l44khxJf4fRc80hvkHhOi7j0zjHkzaybSzNtVWhL5ufhfZ8K0I5nH6K/b6LtuNQQDh/xx4Gh0IUakw5pRwbDYl1UnG25mkJEf/K91CDwh479piLeeTm1RSXTxGgL5Krz6U5/zS42qz4xWxBVRAmkzYYFp8WQBST5+iqjkx3uOgDDa1vx5tpP2WADmgsWCrc7yjmRmW8KmUt0tG35gOwJztDNn1lNhKqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh2UY/c0wkFd6GOjfXBtp1nyTiBMfvNov4aAmOE9wNM=;
 b=ylrrtHUEp+NeLt2emcnr68JX3kcqmtntr8lbSjUm0pTjYXpoQQ+1YgOCsK++wXgRlcjP8iV43UvRM6g4C94apKays/pOo4HCqe52bky3Ljn1WN4iK/GD3MPp7kQSqUEQhRkg9EsZATZHsAP33pkQamnyCgGXX8o/kg6oo83u8K6J3ILb54h7EZ1PmBg13HCKrt7+V1CPaXmW8mFMHiOkB7ooxFbiejtyMSDwDqm9Wkwjzanykt3z37zxUKoF/tsb5szNXcgk0AeATlrJIr4I4ExdzRrxIl3gQWr6MoJjgYr1fR/mqwYQoyGZ3CH2Z/0DjsI5tXc9ILEKl3DSEjHQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh2UY/c0wkFd6GOjfXBtp1nyTiBMfvNov4aAmOE9wNM=;
 b=AJVr0jPDcnZJl77NSYRFqo2TVpy9cnQb60YE6Hbaow5oBglEZpb3ZtbLnr/ECmX/dWllpqYT51B6Lm8DBk/90SBpW0/rQAzKNce9/dmj6Ij6Jw8/eyxrzo9ge8cmTIxnRl+DI+IEMpiGJ3eFKzHuDOsk90BYjOvwH2zW4OVcDow=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BR2PR04MB250856.eurprd04.prod.outlook.com (2603:10a6:2c8:4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 13:53:52 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:53:52 +0000
Message-ID: <329f16d1-f498-426a-b4ec-0d7caf8d249c@cherry.de>
Date: Wed, 28 Oct 2026 14:53:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Add support for OpenSSL Provider API
To: Tom Rini <trini@konsulko.com>, Eddie Kovsky <ekovsky@redhat.com>
Cc: Tobias Olausson <tobias@eub.se>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Simon Glass
 <sjg@chromium.org>, Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
References: <20260429180247.83091-1-ekovsky@redhat.com>
 <20261027182303.GA2414934@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261027182303.GA2414934@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0052.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BR2PR04MB250856:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f68680-52f4-4612-197a-08df34fae623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|261009223027099003|261022105027099003|10067099003|56012099006|261026140227099003|22082099003|18002099003|261026121527099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: UkLyXO0IJZtMEBJ1mi2nARu7ybcffAcB16pQtQIfg47kcYmlCKY9vR+0AMHN3fVe8Q8xJPqxPqfUfzixUa9qZKBEPapN8SRBSO6H8Uc5kwjfHgnsR3eC0K6NAFe5URbxz/8xWafbsj6qh3dEzRrUGAFJh60nSkAIa1Z/49RNCO2ss+EsVuvtZgEai6SjRjY+50RNNVp/jkyqh959LVl5IM2CfHh1KSIHHLPwciHeTSN5p8m1/eejmKtU3ROPVuulqaiIZdOHm/nN+ZDH3CopKGNtHkvrBhXozHOwUvvfZrxCCcEXfRq6zyHWMVxIZ/V1/OGLUbeK/eJ6WOCqSpMinNy3n5/a+gUHQsa5MaJhSdSW0m3C5ZVF+acuGql4dqCZ67Zmv6/9Z3re0REoCMOrp1kyJxnOoL5JwFZuEMCVcZYdM/fuxegFV+Fxnend0seZMX/NzUab0SdCcec+igPqs7N9lrKdVAtN3vFT4e4Qw1htHmuCWi0ARzErydcaL4EZ/MbFl5sZ8kJdKNj2ejGpsRMBdulvpv5xZia65OJwImuMMHCdj+MFYgoD6bNZ7x4BvqJaix7MAylN+OoCD8L8cdqMMiyJlOHmLoN/M07SIf01cv0Gxaco101HwNOe3a7R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(261009223027099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(22082099003)(18002099003)(261026121527099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0VTWVMwamFWU2NSRnBaRzJrRFR0Sk91c0tpd2FkVTZZZzhPUHNqZ3IzMUtM?=
 =?utf-8?B?QmFXN3hiMmNnb2U3U3ZBN3ZVd09CTUZmbWR4cVRNY1MxVGNkRDNsZEFGUWQr?=
 =?utf-8?B?ZlVHY0xrQitTZksrOXovbXVwU0pGN2pkOEhWMlNkUE1tMEd5TGx1S2tWUzNB?=
 =?utf-8?B?ZzNNUnpoazVXUFBvTjBMWkU1YUtWU2lDRFAraUdZV0JXckE1VjJ5dys4ZTgw?=
 =?utf-8?B?dGpjYkVUNVJ3YnV4WHVWMVg3T2xWVHhQejFBOEZKejVCU2xEYWVQZmJsb3Mr?=
 =?utf-8?B?QVJXU1g0SHdOcFdFRGR0Y0xKbTBhQjZEVElENGs5MmFyS3dhVWo0bDdMOXo2?=
 =?utf-8?B?dzM1aVFFdEdNYkV3VFZ6N2FSTnNVb1hiUlN5b2Z1NEhvM0M1OWljT0JLNEVQ?=
 =?utf-8?B?N1F3dytlWTBBM0JkVnJ0RU40eHd6djVvaVZhdmJtckR3Qml5NnVqdzF0Nzgw?=
 =?utf-8?B?ay9tU3VoSnptNDh3RE16RDRrOTBUWkcyM1BqaGpDWVNCTldtL1NLeXRCRjZp?=
 =?utf-8?B?bkFoUVA4bjRwbXRaMHBFeEVSM1JBTTBxTWZTcGZmdEdQRkNKVGwzbmRnV2tp?=
 =?utf-8?B?aktreGg5RWdPTFR0VWp1QTArblhmOHI1UHFkN21KLzVWaE9SbVVrMXQwcUNX?=
 =?utf-8?B?ZmxPa2ZQeEpJaEU5V3krZE1KY3E1NlU3UWhoWnNpRWZGR3hWaHJQR2lSR2to?=
 =?utf-8?B?UCtJMUwrV0ttRDVqdFJMS25DMG9MMGVSY2l0Y3Z1NE9iU3lZSmhBaVo4ZGxj?=
 =?utf-8?B?RHhvUVY1NU04Q2NSS3RPdjc1Mk8rYlM3QXVZdENIR2dxSkU2WEhILy9UVEIz?=
 =?utf-8?B?Qk5wQUFOK0NVcTJXOTVIcHVaeW9ONExYSUJOeW50WXBrWFg3emJTRFlXV2l0?=
 =?utf-8?B?TU96UmhjbGFib0VTM3R1cUpGZFZDSy94ME1rb3V3RWJHZnBiMnRjNzlseTh2?=
 =?utf-8?B?K256MHRoczdqQlFoYVRwYjRVQkxsemI2WE82WlZOU0czc1BvWDdFSDgrS20w?=
 =?utf-8?B?TjdzYzdJb1VTZzR5M0VhaktnS2FBdVlEbUU3bk9WdEpPc1pEaGpMVzhEZUlZ?=
 =?utf-8?B?R054MEQ0cDU0czZwaDRTS2t2WmRlOC9XVmJQaUx3VWxqa3Fjck4walhtRGtV?=
 =?utf-8?B?aEl5b0F0eVcyZnRIZmFsUHQveXhPVzVERzIzTnpDQzVuY0ZhaUtJS1MxMVpv?=
 =?utf-8?B?WlZQcy9CY0hRczhhdFdEdXUwMEdNNU5qYWsyVGJoN05wUC9KS2U2alVwTUw5?=
 =?utf-8?B?VGNMdHlubW5MSkEvbnUzZmtPZnRoZmEwYlZselJCK0ZkNUo1dk5UenRDYzMy?=
 =?utf-8?B?M2t5Vi9PV204bFBCNVJPWFdMWlNSbWtPeTd4djBBWnQ2cThpMmdDVnQyckZV?=
 =?utf-8?B?V2ZyMTZldkQzdTM4ZHVpeXIzQzhsZkg5a0t1dzFLcUNxTEQvcUJUUElDRTFK?=
 =?utf-8?B?akp3VzI3R0xNR1J0a1NMdXlnT2dUeHFOZ04ybXE5Z3phVFA3ejBaYzE1dXE5?=
 =?utf-8?B?S1p4aExGcUN6ak9lTURaWm1ReTRlRWxHUUc2MkNGcWQ1ZEhrRDhwUkhKRi9z?=
 =?utf-8?B?VHJMR2t5NDlhbGJ6VExSZ3hVNXAvRXhqek1TT1dpQUtkaWpsN0s0Vno2M3gz?=
 =?utf-8?B?WlRHZXN1blBKbVd1Y1VCRFM3OFdrYm92Vm14L3hEM1pDanRlWE9JU2M4YzQz?=
 =?utf-8?B?NE1lcUhtcW5ReS93R0tGdHF5ZnVlVmZlaDg1K2lkci8vajluL1MwclZNTVZE?=
 =?utf-8?B?Nmg0ZUZDOG9pVEtmbmxJVDlZcy9Dd2hMakQxanF2d0hjQmt3clhLV0JJS1Rr?=
 =?utf-8?B?enV0TDFaZzZGcHVCK3ZSS3ZhTzA1Y1piNnVCUXRWZ1NWc1FBc3JzWS9DSlZ0?=
 =?utf-8?B?WmJBZnp1dTUrWHBNVWUvL2RCZE0yOHFOUXVkN1ZFU3lXUWFaUWJpTFdXZ2FG?=
 =?utf-8?B?bFdJS3NPUlUyd1k2TGJKWm5sRXdwSkJhdjZDWXZNTERRM0lkNWRTaW1INEFO?=
 =?utf-8?B?TmRIdHdZTzFjeXkrV25Wa3F2U0hhejkyd0ltb1YwVDVRT2NncTJKcVJJbFFq?=
 =?utf-8?B?VDJJVE41aFdjbVdFS1hpcXRMdXlKckFobDN5enZ3MEJPcDczbjJ5YzloVkZP?=
 =?utf-8?B?NWlId08vY0cwMFpHQ0Y2STNRc3hGdkd0SW9oSWxDR2dhMkNlVEl4a3ZoUHVH?=
 =?utf-8?B?dUJZVGlXNGN3ZmRoVVU0TEJLb05HaXFUVzJWNUkvSVI3a1JsQ2lBcC9hREph?=
 =?utf-8?B?TFRYTFcwNmtYRG5xOUVQZWNwVURLdVRGbGpneTRkQ2h5Zm8vek5NRS9vWmNl?=
 =?utf-8?B?cXJHeit6L3YvQmkxcHZ2ZXFSd1ZJS0xnODNFVFY4bS9rUXZPdmFvdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f68680-52f4-4612-197a-08df34fae623
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:53:51.8917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Jk16jkTu8UzN9QvDUipPw9HtNtL+vybdsOIqsK2ZuB8hMzBTNdk6WEakKzqDqv9nT92eX34md48lHKR7/yo3x1tqJeNCPHgLrgsivOmAIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB250856
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom, Eddie,

On 10/27/26 7:23 PM, Tom Rini wrote:
> On Wed, Apr 29, 2026 at 12:02:45PM -0600, Eddie Kovsky wrote:
> 
>> The Engine API has been deprecated since the release of OpenSSL 3.0. End
>> users have been advised to migrate to the new Provider interface.
>> Several distributions have already removed support for engines, which is
>> preventing U-Boot from being compiled in those environments.
>>
>> Add support for the Provider API while continuing to support the existing
>> Engine API on distros shipping older releases of OpenSSL.
>>
>> This is based on similar work contributed by Jan Stancek updating Linux
>> to use the Provider interface.
>>
>>      commit 558bdc45dfb2669e1741384a0c80be9c82fa052c
>>      Author: Jan Stancek <jstancek@redhat.com>
>>      Date:   Fri Sep 20 19:52:48 2024 +0300
>>
>>          sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
>>
>> The changes have been tested with the FIT signature verification vboot
>> tests on Fedora 42 and Debian 13. All 30 tests pass with both the legacy
>> Engine library installed and with the Provider API.
>>
>> Tested-by Enric Balletbo i Serra <eballetb@redhat.com>
>> Tested-by Mark Kettenis <mark.kettenis@xs4all.nl>
>> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
>> ---
>> Changes in v4:
>> - Add comment that @engine pointer is null when using pkcs11 provider
>> - Remove extra line break
>> - Add pkcs11-provider package to build dependencies
>> v3: https://lore.kernel.org/u-boot/20260120164524.253188-1-ekovsky@redhat.com/
> 
> Hey folks. So I think at this point we're still expecting a v5, and that
> should be able to be merged, yes? If so, is there some update on status
> there, or some way the rest of the community can help out? I think this
> is something that will really need to be sorted out for the v2027.01
> release or a lot more projects are going to start having problems
> building U-Boot. Thanks!
> 

I think we really should focus on gating the engine code for now, so we 
can compile on Fedora 44 without openssl-devel-engine, and the other 
distros that have switched to OpenSSL 4 already (Fedora 45, Yocto, etc...).

Note that Yocto has decided to take the v4 of this patch a few months 
back, c.f. 
https://git.openembedded.org/openembedded-core/commit/?id=e7692ccf13484c8064f45dbaecd67ed8ea119cbc

We can then spend more time implementing actual OpenSSL provider support 
later, as this will be a new feature and doesn't have time pressure 
(well, for upstream U-Boot that is :) ).

Cheers,
Quentin
