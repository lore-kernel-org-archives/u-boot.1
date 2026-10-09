Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DF2CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 08:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73BF040517;
	Fri,  9 Oct 2026 08:38:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WdfDB4fjvcob; Fri,  9 Oct 2026 08:38:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B00B4056F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791535091;
	b=WB5rvjB8LwjuUA7xrV6VPRRv5cLUHuykB1AVtwEAo2vsDm7wv9QyGBMCwXpTOxKRA9Nn
	 63/gpMF4JU26HSIcB9ZgKB3A1W8UHQlozQfpr6bALg/7mTzNiqSUj1xNopXF1J1CARowA
	 SiutUrKkQOR07ZJBMw6mYfo+V9AS7I5uh2pca25Clx+DcDzj5orRpdwuLxPucOQ9TBcyH
	 Ze24Wp5aoxbUPV90HfaSeV6P4l49MBV3FLFwo/tGTAvBweT7opfB/O39B5mW0JDhISwaP
	 21wDxkDQQK+cCm6B9yNuFkuIOtHHIum0ZfrPQLSVaBQvb5cSECTVlkTAov9ihmEiPTA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791535091;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RL85pHKwiSSTPtuHvAhDgZ/PH/pv8oJOEn+suzg29Gg=;
	b=baawTEtXhgmmbRalPTTt31FTztXYRpm24lQUHSDHXwkKdeMQUDF6WuG9aPG9XLFz+qz6
	 pl3KYqJKRdFl48yIffixUAN8sERx0WBvzKf2MavFwg0pzj3K06FOCE0FLgsUQOFdQiVZi
	 XvLVeE6t2P4Q9lxU0+f6AbIBMjfv3vfp0ipN8XOrcEfi39CuoeqpHhLp/ryWasxDuEbuS
	 uKgHdVfNPVBF5ZtpVT35qpV2m1wHunZqQdi/hbz3NfFs6jPaUPpVPtRXe0m9qlxPZASvg
	 tBipop4XgaQmYpgNVg6HchlC0aUSD6xsCQKrlYs8q0fmYIt1Q9KtP3WthbKVIFt8FqA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791535091;
	bh=RL85pHKwiSSTPtuHvAhDgZ/PH/pv8oJOEn+suzg29Gg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rWkSqOkpTW3F+MeG/63QSqmCx2sZombz3Hz72H5nZjloEoi5Sxrb5Ec2B9CPSDrm+
	 54C+o+uzlbFCz39D5cnhDZcMQCXEqun0hsyAQE1ZGv+YHPjA44CiFkTHWK4J2vn6KO
	 +np7KLubwjOi1/fY4RBfrAJ3+VbluHap6iG+G2oOgcl1LvLc8BReyo5dBGWz+iarMY
	 MkP6vEVQlW3dUaECCadakaYvPYZdMvjzhUzai8zmTUFEMn4hdUETiEPe2QYL60sl/Z
	 X1M4tcGJXPzmSmckkZElGn2m0vmsnYt5nRN2APTtU6ziDgCUdWe74S5M5U/WMJ4GNB
	 lpQGDvYysrpig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B00B4056F;
	Fri,  9 Oct 2026 08:38:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F1AC1C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:38:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 910156069F
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:38:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PawNtgqIRh7L for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 08:38:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0608B605D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791535089;
 b=QoIuJIIJcVefiay890eQp0pmv8/AtL8c+7lwBD7unxSyJKQIccbasNrmPeog6FySyyvv
 EFZt6g9unqHRyQYj9hnPOAAnMoeW9gIHsHaj5sKu2dNZQC5SdXaVlrkccsazrERjklQW4
 UxH3uaTeS2+YDVCtEGt2xbX5ojSWEIBcltczwk8/HRBt1hdV/7oa4E/eLzk6JpLM4qiSx
 TQRAmcO4Z25Qe5QLEj+tN09HDUprwuVB70hGiB+d9IHquUTh9nRh7moEdi/KbNjwt50Rr
 UUUOt9pc1Hmc7+TZddbMckvgWFzBNZ1Qqx2QxvDOKShn5Z1uiSUfZkadhI6OyDAvazg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791535089;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=RL85pHKwiSSTPtuHvAhDgZ/PH/pv8oJOEn+suzg29Gg=;
 b=kogdcDgCsEL0F9H2bx5nkZnNCpSyzX2Un32w4XSKvMcFK9JT/cjEyCLBVDLrFvf9La/u
 0jovppPIX3CIa8I/QRQoDEVP1jxhIy5vJeYuwV9ZRA6t1p7245benNdZagQOcJnrva3dl
 nO0pgeiKvWMsJ/Zhy196mMTltYGuMiJlGmJF3QVvg/tda2nZS5eT9of/cF5CmFFHyLrX3
 +8JtEeJPbLvWkvnoNf3apfTECzSdOB6zG4hJx4P0XxQ82ZwRsnJID+VJ+VnQMjJnolJhG
 qrDiqwObhmABukRq0JLHVjZ8kYLyzhZBBrjS3N8UEeL3bF+2u+kCffBzKUG/jKLG1/w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=WpjpCQWL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::1;
 helo=mrzp264cu002.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=WpjpCQWL
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0608B605D0
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FohfgcVfbq7NRlphE0fHicp2DsLxYvLrs/CgDkJNuk4bGVs9aM26DTBJMjLj5vzb3gnNimyPmYpIWWtzaUjFpG4LBp18Jd3dRXpl2qBWwGNLU7VjKF96g7kSsR3lYjTNgtL3BPJhKmDUuRclu79siVPGgLpeNyQklo5RMmMkhO+HbWwGDy0s3E9n2Ao6S1CeBFeoug+NWhBmu5VNk8LfMwJwJVvmTRpoeEvFXsNVoy1NwjcVzwMgl8mQONbY+7Vnol6e+2LJDUwLDe6gdNf1b44ybHaKjidfHCUcf7EninQKhrLe35Imz7B3DDGuRLjvDcVtj1yNbD/5rZcCCbEgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL85pHKwiSSTPtuHvAhDgZ/PH/pv8oJOEn+suzg29Gg=;
 b=hgvFm+5ruol4JK0MkyFrgbAYwmB1xjDIhKyKIvnaCVQdAvizXFxa7cXmGSRsF/fC0yFsmEBrV0iWQ4v/07qUv8UVj32fS/3/0D6zSBfCAtIKn0kDjUDwAGCI0VvHhbXjWcniAEw8adYIVxx3PIKjJNtFUj1NQToBSWzrxpjwfA4mT7hVkMO9uGGxuPXFrGtgKD8CP/VIwUJQ4xEAISlE8Tlv6y5Ernr80MeekaWEqCnB+Jrb8eyJETahpvEH2sIeePqkTdaTaO0jgk71PlRfnrYiv/pD9lNczUGRzylviuo7MQHdxfolOS66cJkmEWecTvyTooCK6KtmqttUXJb1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RL85pHKwiSSTPtuHvAhDgZ/PH/pv8oJOEn+suzg29Gg=;
 b=WpjpCQWL7y1a9+uYi5WRbPJUScUeXVNeqEEiZZrlk08yuIIJu6qx2At//7OWM8Ik7l3VzLSqI96ob9HEeJhAuhx7Fr5WCXIK7TTB44vF2yynWkLkjAo5RHTxd8rnMt/QSQjZnZdvB7KL+AzulPaepmGyYqWyUgTmdASPvoi1LZsB9iGrNCqbwuvMhMK0E0BVa/tEYdIHjV3BV+69GYPPE9lAhTOo/UvbAcO1XX9kKev/dByWGftqUxyFyckjl7jRiKEHlRGJRUqXfxOZzuACJ17bd84nWoAX/oO4QyT2p1Klpa7BBL5tHI8R94JzW/vw3U4h6vbZ20mp+QN3L7pXPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PR0P264MB3674.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 08:38:01 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 08:38:00 +0000
Message-ID: <033e7c3d-9793-484f-bcc1-628ae5a9e214@softathome.com>
Date: Fri, 9 Oct 2026 10:38:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/15] add software ecdsa support
To: raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 simon.glass@canonical.com
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
Content-Language: en-US
From: Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0116.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::7) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PR0P264MB3674:EE_
X-MS-Office365-Filtering-Correlation-Id: ff61d8db-b1b0-484b-5219-08df25e0a06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|10070799003|366016|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: cO6Eaugb1MrSR3/RF/sxlPHQwi8MHy2vMUXMt0kwbedP4V7vUst7y4SazOxLyuvsKWPrdkj5m6GrpnHuXwWn/VkEaZb+gIfDMQDzw3cdVeyMh4NvCCAFhoWB6/+MFkgDsDDzV7PHZKTmirqADlcq0MZnBjw8wXLCBXk0I3zi89ZC2J1r8ENGXX27rVNWwJgMjjPBoMqDVzwaZU5mcHoSFQ3UFsRryIeV61EaBy5QnW60X3kBfPfUT14ZC9NozACQrWFWcpzHRPwSsK2LQI2vEwomjkvtMtq3JKj7s8jRdu7YFo3MuJzvUSX3bOGkXKNQWPQdqYZyONUaztDVsYrUyX0pahSANg7AubiaCmDMrbvyzoM1UZ9sIw+SGHXqb9wHWJBBo/jxnjFHI75bmzv07iFy9YAza8Yv49KleJ9LPkaGHWktq1M0Qyi0zPwDplznSfweZvMkEMfz93AV6PgGIJHkAru+6Ra/t4d2dZH++gdKMUpfQlWsMW+ob6+gmb8viXmBv8l3unnc6EDjSepvD+6I77iPNOCutwJy1bwy/eeMS16xTnz6VCPRG0WG+BYNdT8HfNteOz1fqlaNEQVkEAusq8J2jDzT7F7UMqxTJsBcuNTV027KmLr31HHv/xvl8RE2u+Jnnpm2p+eeeEvvwaJs0neBbJ16CqrIDjMVYFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJLOGZHWHY0WVlLY3hqVGgxekphaHB2clZjMGFYTTRqVERzaXZCN1kvQ2ty?=
 =?utf-8?B?OERNVHBaWUYyT2V6b1E0WW5Pd2ZVVEFkMXh2U09IQlovdGF6N0ZSb1JqUkQ2?=
 =?utf-8?B?QnFrUUNpaHNob3B3TkFxNUQxbTd5NWorTkFKTGNKeSs5Z3FlL1NTaE42d0Vz?=
 =?utf-8?B?STM3UUppbkhFNFdtRXNBRVJZbGdSdEZVU0svWlRsOEVpcElSeHg0UHd3ZStF?=
 =?utf-8?B?a2YwcTBSSjZVS0NCbW05a2xQZFNmTWJKdDJiMWM3bzM0OUhpSitZU0I4eXpF?=
 =?utf-8?B?QzE2RXB1ZDdSdFliZlV0RjBuemtERmF4L0Jqa2VycVY3RnZ2Unh0bWM5WVVj?=
 =?utf-8?B?aTRpY0cyRXFqM05nSHlOREVFZ2RHR2NNb3N3ck1pWGJINXI4OXNLb2h0MVVI?=
 =?utf-8?B?Y3cyY0RnanUwNGNtNC9XZVRXdEN0QThQOWNzalJPd055V1grSnp5VXNrYy9o?=
 =?utf-8?B?Rk5kQ2grKzdTNlNBamlFbkNXMmxsbG5xNDcwUjFtcDJCVEhNMWhFbnNianda?=
 =?utf-8?B?M3ZNQzhWdVdzMnlqWkFWa3owOHgrcUxHbVFEYlJGYXk2YkRzcHZqMXc2NUJQ?=
 =?utf-8?B?N0pQU0pnNURVSUZiVjFlZ3RKT2U5REVEU2IvRlI2NzdBb2xUZnVmZ2FyWUJ5?=
 =?utf-8?B?NDlzdENERE5oWmxJOHBCM2RIMWUxNFRtYkUxUThGMERCVFB3S0xCRmNiWW5K?=
 =?utf-8?B?WnBDS2x6emFuR3dZQlIxTVBhSEI2UVY2OXhEbFVTVVFHSkRSVDRucXhybmkr?=
 =?utf-8?B?a1dPbkJ5UXc0RFk3T2ZKOE4xazhzUGR3d3BqUVgvT3FrcnpJdVlLOHpsZUho?=
 =?utf-8?B?eEZFdTJPTnVFOU9jQ3hKeHV3Q092N3NhV3VrMTFid29VSEZ5RHFZcGhBYVJ2?=
 =?utf-8?B?dHJCZEliYmNMR0g5cFRlWGRRWVZoSGlPUW0wZ0J5UW1XeHFMVzlBeEc3R3Zj?=
 =?utf-8?B?aTI0NWNHNkN2Zi9tOHQ5R3JQUDY5c0NoY0xTWmMzdjdDdWx6VUtjM1AyMUJN?=
 =?utf-8?B?UmREOEF1REpOaEtCamxUUmNHUUdTRTVTNTNXT2pPWlZLZEQvbW9EZzlHdzlC?=
 =?utf-8?B?bktya1ZuVjhhWHJzNXdzOGxjcU9HK1pkaDVicXBtb3ZMeVMwZms4eVlVQ1Vw?=
 =?utf-8?B?cUh1SGlubWttdFJsOTZqRWNkRnhKVDc2NENOOGE5N3F3YUY5dXovb1ZyaGNu?=
 =?utf-8?B?ZW93M1l0RVVLVHA3OElSSE51QTJPRTFsdi9JQXJvL1RORHQ4V2kxNUUvZldU?=
 =?utf-8?B?dXY3TzNhdmd3TDhyaWhBa1hGZUd4NG1SSDJlR1JmVlNnOGRQRmJYSk9OTU5r?=
 =?utf-8?B?U1FwbGRmeDVveDMyK1orcUs1czNQSTc5YVNjamNka0VhWEQ4QVhIRVl6SlZt?=
 =?utf-8?B?L1hPL2JiRytvVWpxa1dhQXRNNXJua0Vpa1dZVCtjU0hqaWZWZzhudnpSZDJE?=
 =?utf-8?B?b2lKQXo2dkpkSndPMWFuUUpiVFJMUzVlaXphWVp5Zk9laTRDWUJjNitKMmVl?=
 =?utf-8?B?M3ZCTGVXdG5YZDBicnpJYkF3dU1FTzdvK01VUXlLcktVb05rUkJVem4wcktU?=
 =?utf-8?B?K3JLdE5jTjMzby85eXVDU0JpR0JRSnIvdEVWYTlIT29URCtSVHBlQWg4cXlx?=
 =?utf-8?B?SGtMUHVrVHBsVEZTYnBRYUtXUkNiaGN3YzRPOVF2QW8wcG5mdDFmVnhOeDV6?=
 =?utf-8?B?T3VNWUg5bG15a3M5azMwQzJBNHhlRU1CNm93Z3NCSW9qVTNBVDFoZjFROVMr?=
 =?utf-8?B?K3ZZQUp1YjlmM3ZDZzBOR2tuS0dXVHlmcGZyUFdyRisrSkJ1SEVvOHZUbGE2?=
 =?utf-8?B?NjNqOUFkeS9tMDVvRUszZ1RwQjNnWXFWeDgzSVU5TEhQTURTUGtXU04xSjdL?=
 =?utf-8?B?RUhjZmhqTjl1REtUTTlzbk9mdFFsaXMrcnYvbmpINld1YytiZ3prMG1vMVJW?=
 =?utf-8?B?TjU2alM4dmtESW5BK1hkUGxqYnFHSXQzcXJSOHd2ZWRWd3N5K1hiTXhiTXM4?=
 =?utf-8?B?VlBSMDgyS2RSUnhHZXVBK05PbjFKRGpHTmVFMUNkbVJjYjRqOVZDSVFxYzdr?=
 =?utf-8?B?WTI1ZktybEUzdkx2L0JNSGR6WGpycjRCWjlzKzdoWW45S3F6ZVpoV1dzdzY3?=
 =?utf-8?B?bUE5MkxsMmFSN3Y3V04wN1l6UnNlcWFJWTloamd1TThqbHlwVjQ3T3k2NE1U?=
 =?utf-8?B?ZmlHVU0vSlVjQjZOOGFES0oySWxiUDJYalFhQm1yWWxUdlpzalk2aTNOS05M?=
 =?utf-8?B?SmZjdkJINGZLUTZvMUc5MjVEdGpRL2VUQTFMbldIVkdTNzhaVzlrRE9vUFlw?=
 =?utf-8?B?aEhuSy9qcEpyejFBR0trb0RSWmk4VDNOdE1xV1BzL1UyUTVQQTBIL1R4dnBL?=
 =?utf-8?Q?U2ONgzUattWbMwjRwDdIzscAh0L8PCG81myTaMXmz6f+j?=
X-MS-Exchange-AntiSpam-MessageData-1: 3HDe3jwqc3+99HH+lGf17VgOiiIW3TD/kDI=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff61d8db-b1b0-484b-5219-08df25e0a06e
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 08:38:00.7993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Okzo59W6otWt95bwAHRXli8jF86hJl3WheEXtzuAdouyQ3vDUuzmB05qYGyysXIjhwKjdCk5vqwWZrZEWU43Ft5TU1eDCTaYr3UOolw/+6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3674
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

Hi Raymond,

Do you think that this serie may by merged please ?

Regards,

Philippe


Le 04/09/2026 =C3=A0 10:37, Philippe Reynes a =C3=A9crit :
> This series adds the support of ecdsa with software
> using mbedtls. So boards without ecdsa hardware may
> also use signature with ecdsa.
>
> To achieve this goal, several changes are done:
> - fix the support of secp521r1
> - enable support of ecdsa in mbedtls
> - add software ecdsa signature check using mbedtls
> - add support of ecdsa for internal fit signature
> - add test for ecdsa for internal fit signature in vboot
> - add support of ecdsa for pre-load signature
> - add test for ecdsa for pre-load signature in vboot
> - enable software ecdsa signature check in sandbox
>
>
> To test this new feature, just follow those steps:
>
> 0) build u-boot using sandbox_defconfig and adding those options:
>
> CONFIG_ECDSA_MBEDTLS=3Dy
> CONFIG_ECDSA_VERIFY_MBEDTLS=3Dy
> CONFIG_ECDSA=3Dy
> CONFIG_ECDSA_VERIFY=3Dy
>
> 1) add a signature node to an its file
>       signature-256 {
>               algo =3D "sha256,ecdsa256";
>               key-name-hint =3D "private-key-256";
>       };
>
> 2) generate an ecdsa key
> openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem
>
> 3) create the itb file
> ./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb=
>
>
> 4) launch sandbox u-boot
>
> ./u-boot -d arch/sandbox/dts/test.dtb
>
> 5) on sandbox u-boot prompt, load the itb and launch bootm on it
>
> =3D> host load hostfs - 1000000 uboot-ecdsa.itb
> 4628674 bytes read in 1 ms (4.3 GiB/s)
> =3D> bootm 1000000
> ...
> ...
>     Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK
>
>
>
>
>
> Changes in v2:
> - move ECDSA_MBEDTLS to MBEDTLS_LIB_X509
> - rename lib/mbedtls/sw_ecdsa.c to lib/mbedtls/ecdsa.c
> - enhance dependencies for ECDSA_MBEDTLS
> - fix support of ecdsa521/secp521r1
> - add vboot test using ecdsa
>
> Changes in v3:
> - do not use _MBEDTLS in mbedtls_def_config.h
> - check returns and remove mem leak in lib/mbedtls/ecdsa.c
> - remove useless field  *k in struct ecdsa_test_vector_s
> - check returns in test/lib/ecdsa.c
> - fix third parameter when calling sha*_csum_wd()
> - add support of ecdsa in pre-load header
>
> Changes in v4:
> - change some dependencies to enable ecc
> - use ECDSA_MBEDTLS to build the ecdsa driver
> - support ecdsa521 and secp521r1
> - add a test calling ecdsa_verify for the ecdsa class
> - merge patch 10 and 11 (support ecdsa pre-load for binman and tests)
> - several code cleanup
>
> Change in v5:
> - fix ecdsa 521 in the first patch (instead of the 5th patch)
> - mbedtls: ecdsa is only compiled when ECDSA_MBEDTLS is enabled
> - fit_image_setup_sig: required_keynode is initiazed to -1 instead of 0
> - avoid hardcoded value for ecdsa sig and point size
> - check pointer before using them
> - free ecdsa keys when key are not found/used
>
> Change in v6:
> - fix dependencies for ecdsa
> - ecdsa is no more mandatory for tls
> - remove include u-boot/ecdsa.h in ecdsa-sw.c
> - do not use fdt_stderror with -1
> -
>
> Change in v7:
> - change uint8_t to u8 in test/dm/ecdsa.c
> - change info->required_keynode >=3D 0 in lib/ecdsa/ecdsa-verify.c
> - set required_keynode to -1 in test/dm/ecdsa.c
>
> Change in v8:
> - check exact size of data read in dtb in function fdt_get_key
> - enhance commit message to explain patch 2 (enable ecc)
> - no longer use macro CHECK with goto inside macro
> - some code cleanup
>
> Change in v9:
> - rebase on next
> - update cover letter
>
> Change in v10:
> - remove empty line at the end of ecdsa-sw.c
>
>
> Philippe Reynes (15):
>    ecdsa: fix support of secp521r1
>    mbedtls: enable support of ecc
>    ecdsa: initial support of ecdsa using mbedtls
>    test: lib: ecdsa: add initial test
>    drivers: crypto: add software ecdsa support
>    test: dm: ecdsa.c: clean this test as software ecdsa is now
>      implemented
>    test: py: vboot: prepare integration test for ecdsa
>    test: vboot: add test for ecdsa
>    tools: fit_image_setup_sig: set required_keynode to -1
>    tools: mkimage: pre-load: add support of ecdsa
>    tools: binman: pre-load: add support of ecdsa
>    boot: pre-load: add support of ecdsa
>    tools: preload_check_sign: add support of ecdsa
>    test: py: vboot: prepare test for global signature with ecdsa
>    test: py: vboot: add test for global signature with ecdsa
>
>   boot/image-pre-load.c                         |  53 +-
>   configs/sandbox_defconfig                     |   2 +
>   drivers/crypto/Makefile                       |   1 +
>   drivers/crypto/ecdsa/Makefile                 |   6 +
>   drivers/crypto/ecdsa/ecdsa-sw.c               |  31 ++
>   include/crypto/ecdsa-uclass.h                 |  15 +-
>   include/crypto/internal/ecdsa.h               |  39 ++
>   lib/ecdsa/Kconfig                             |   1 +
>   lib/ecdsa/ecdsa-libcrypto.c                   | 104 +++-
>   lib/ecdsa/ecdsa-verify.c                      |  73 ++-
>   lib/fdt-libcrypto.c                           |   2 +-
>   lib/mbedtls/Kconfig                           |  24 +
>   lib/mbedtls/Makefile                          |  20 +-
>   lib/mbedtls/ecdsa.c                           | 152 ++++++
>   lib/mbedtls/mbedtls_def_config.h              |  41 +-
>   test/dm/ecdsa.c                               | 107 +++-
>   test/lib/Makefile                             |   1 +
>   test/lib/ecdsa.c                              | 456 ++++++++++++++++++
>   test/py/tests/test_fit_ecdsa.py               |   2 +-
>   test/py/tests/test_vboot.py                   | 148 +++---
>   .../tests/vboot/sandbox-binman-ecdsa256.dts   |  24 +
>   .../tests/vboot/sandbox-binman-ecdsa384.dts   |  24 +
>   .../tests/vboot/sandbox-binman-ecdsa521.dts   |  24 +
>   ...pss.dts =3D> sandbox-binman-rsa2048-pss.dts} |   0
>   ...-binman.dts =3D> sandbox-binman-rsa2048.dts} |   0
>   .../vboot/sandbox-u-boot-global-ecdsa256.dts  |  27 ++
>   .../vboot/sandbox-u-boot-global-ecdsa384.dts  |  27 ++
>   .../vboot/sandbox-u-boot-global-ecdsa521.dts  |  27 ++
>   ... =3D> sandbox-u-boot-global-rsa2048-pss.dts} |   0
>   ....dts =3D> sandbox-u-boot-global-rsa2048.dts} |   0
>   ....its =3D> sign-configs-sha1-rsa2048-pss.its} |   0
>   ...sha1.its =3D> sign-configs-sha1-rsa2048.its} |   0
>   .../vboot/sign-configs-sha256-ecdsa256.its    |  44 ++
>   .../vboot/sign-configs-sha256-ecdsa384.its    |  44 ++
>   .../vboot/sign-configs-sha256-ecdsa521.its    |  44 ++
>   ... sign-configs-sha256-rsa2048-pss-prod.its} |   0
>   ...ts =3D> sign-configs-sha256-rsa2048-pss.its} |   0
>   ...56.its =3D> sign-configs-sha256-rsa2048.its} |   0
>   ...84.its =3D> sign-configs-sha384-rsa3072.its} |   0
>   ...s.its =3D> sign-images-sha1-rsa2048-pss.its} |   0
>   ...-sha1.its =3D> sign-images-sha1-rsa2048.its} |   0
>   .../vboot/sign-images-sha256-ecdsa256.its     |  42 ++
>   .../vboot/sign-images-sha256-ecdsa384.its     |  42 ++
>   .../vboot/sign-images-sha256-ecdsa521.its     |  42 ++
>   ...its =3D> sign-images-sha256-rsa2048-pss.its} |   0
>   ...256.its =3D> sign-images-sha256-rsa2048.its} |   0
>   ...384.its =3D> sign-images-sha384-rsa3072.its} |   0
>   tools/binman/etype/pre_load.py                |  78 ++-
>   tools/binman/ftest.py                         |  50 ++
>   tools/binman/test/ecdsa521.pem                |   7 +
>   tools/binman/test/security/pre_load_ecdsa.dts |  22 +
>   .../security/pre_load_ecdsa_invalid_algo.dts  |  22 +
>   .../security/pre_load_ecdsa_invalid_key.dts   |  22 +
>   .../security/pre_load_ecdsa_invalid_sha.dts   |  22 +
>   tools/image-host.c                            |  93 +++-
>   tools/image-sig-host.c                        |   7 +
>   tools/preload_check_sign.c                    |  30 ++
>   57 files changed, 1892 insertions(+), 150 deletions(-)
>   create mode 100644 drivers/crypto/ecdsa/Makefile
>   create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
>   create mode 100644 include/crypto/internal/ecdsa.h
>   create mode 100644 lib/mbedtls/ecdsa.c
>   create mode 100644 test/lib/ecdsa.c
>   create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
>   create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
>   create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
>   rename test/py/tests/vboot/{sandbox-binman-pss.dts =3D> sandbox-binman-=
rsa2048-pss.dts} (100%)
>   rename test/py/tests/vboot/{sandbox-binman.dts =3D> sandbox-binman-rsa2=
048.dts} (100%)
>   create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.d=
ts
>   create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.d=
ts
>   create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.d=
ts
>   rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts =3D> sandbox-=
u-boot-global-rsa2048-pss.dts} (100%)
>   rename test/py/tests/vboot/{sandbox-u-boot-global.dts =3D> sandbox-u-bo=
ot-global-rsa2048.dts} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha1-pss.its =3D> sign-configs=
-sha1-rsa2048-pss.its} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha1.its =3D> sign-configs-sha=
1-rsa2048.its} (100%)
>   create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
>   create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
>   create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
>   rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its =3D> sign-=
configs-sha256-rsa2048-pss-prod.its} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha256-pss.its =3D> sign-confi=
gs-sha256-rsa2048-pss.its} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha256.its =3D> sign-configs-s=
ha256-rsa2048.its} (100%)
>   rename test/py/tests/vboot/{sign-configs-sha384.its =3D> sign-configs-s=
ha384-rsa3072.its} (100%)
>   rename test/py/tests/vboot/{sign-images-sha1-pss.its =3D> sign-images-s=
ha1-rsa2048-pss.its} (100%)
>   rename test/py/tests/vboot/{sign-images-sha1.its =3D> sign-images-sha1-=
rsa2048.its} (100%)
>   create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
>   create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
>   create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its
>   rename test/py/tests/vboot/{sign-images-sha256-pss.its =3D> sign-images=
-sha256-rsa2048-pss.its} (100%)
>   rename test/py/tests/vboot/{sign-images-sha256.its =3D> sign-images-sha=
256-rsa2048.its} (100%)
>   rename test/py/tests/vboot/{sign-images-sha384.its =3D> sign-images-sha=
384-rsa3072.its} (100%)
>   create mode 100644 tools/binman/test/ecdsa521.pem
>   create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
>   create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_al=
go.dts
>   create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_ke=
y.dts
>   create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sh=
a.dts
>
-- This message and any attachments herein are, unless otherwise stated, co=
nfidential, intended solely for the addressees and are SoftAtHome=E2=80=99s=
 ownership. Any unauthorized use, reproduction or dissemination is prohibit=
ed unless formaly agreed beforehand by the sender. If you are not the inten=
ded addressee of this message, please immediately delete it and all its att=
achments from your computer system and notify the sender. SoftAtHome reserv=
es the right to monitor all email communications through its networks. Any =
views or opinions presented are solely those of its author and do not neces=
sarily represent those of SoftAtHome. The internet cannot guarantee the int=
egrity of this message. SoftAtHome not shall be liable for the message if a=
ltered, changed or falsified. While we take all reasonable precautions to e=
nsure that viruses are not transmitted via emails, we recommend that you ta=
ke your own measures to prevent viruses from entering your computer system.=
 SoftAtHome is a French Soci=C3=A9t=C3=A9 Anonyme with a Board of Directors=
, having a capital of 6 450 699 Euros having its registered office located =
at 9-11 rue du d=C3=A9barcad=C3=A8re =E2=80=93 92700 =E2=80=93 Colombes =E2=
=80=93 France =E2=80=93 Tel + 33 (0)1 57 66 88 88 =E2=80=93 Fax + 33 (0)1 5=
7 66 88 89 - RCS Nanterre B 500 440 813 =E2=80=93 Intra-Community VAT: FR 0=
4500440813 -- Ce message et toutes les pi=C3=A8ces jointes qui y sont inclu=
ses sont, sauf indication contraire, confidentiels, destin=C3=A9s uniquemen=
t aux destinataires et sont la propri=C3=A9t=C3=A9 de SoftAtHome. Toute uti=
lisation non autoris=C3=A9e, reproduction ou diffusion est interdite, sauf =
accord formel pr=C3=A9alable de l'exp=C3=A9diteur. Si vous n'=C3=AAtes pas =
le destinataire pr=C3=A9vu de ce message, veuillez le supprimer imm=C3=A9di=
atement ainsi que toutes ses pi=C3=A8ces jointes de votre syst=C3=A8me info=
rmatique et en informer l'exp=C3=A9diteur. SoftAtHome se r=C3=A9serve le dr=
oit de surveiller toutes les communications par e-mail via ses r=C3=A9seaux=
. Les opinions exprim=C3=A9es dans ce message sont celles de leur auteur et=
 ne repr=C3=A9sentent pas n=C3=A9cessairement celles de SoftAtHome. L=E2=80=
=99Internet ne permettant pas d=E2=80=99assurer l=E2=80=99int=C3=A9grit=C3=
=A9 de ce message, SoftAtHome d=C3=A9cline toute responsabilit=C3=A9 =C3=A0=
 ce titre, dans l=E2=80=99hypoth=C3=A8se o=C3=B9 il aurait =C3=A9t=C3=A9 al=
t=C3=A9r=C3=A9, d=C3=A9form=C3=A9 ou falsifi=C3=A9. Par ailleurs et malgr=
=C3=A9 toutes les pr=C3=A9cautions prises pour =C3=A9viter la pr=C3=A9sence=
 de virus dans nos envois, nous vous recommandons de prendre, de votre c=C3=
=B4t=C3=A9, les mesures permettant d'assurer la non-introduction de virus d=
ans votre syst=C3=A8me informatique. SoftAtHome est une Soci=C3=A9t=C3=A9 A=
nonyme fran=C3=A7aise =C3=A0 Conseil d=E2=80=99Administration ayant un capi=
tal de 6 450 699 euros, dont le si=C3=A8ge social est situ=C3=A9 au 9-11 ru=
e du d=C3=A9barcad=C3=A8re - 92700 - Colombes - France - Tel + 33 (0)1 57 6=
6 88 88 - Fax + 33 (0)1 57 66 88 89 RCS Nanterre B 500 440 813 - TVA intrac=
ommunautaire : FR 04500440813
