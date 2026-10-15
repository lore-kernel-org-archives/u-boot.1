Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB28CC6B3A
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 11:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E27D16077F;
	Thu, 15 Oct 2026 11:18:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id brhHFQuTuKrV; Thu, 15 Oct 2026 11:18:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3FCDB60758
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792063122;
	b=TkBuw9wNTTFbzcWDFlJv1M7QBWM6yPwmaXYERjmXRqLvRPHBWw8aP95cmuX0ZvhjZQ5r
	 +D6IluYLEiMh5d8I5u6Yq3O1InD2RDsN1AYzHknafcgZs6qE1687YYpmjx+W7twVT29E1
	 UeIKVgQjyna0jZ4JZ9BNppCLW/9MXNqUd02eaYP+WtH6HzB8qjZmXLhwliz7hc7NTFbTe
	 dxVL1x5E5wZyaZc9oSv+yxUDuYwfXzLCViHVQFL6gVmvWn7ebRKX/6YZhGJHk/kzT9iO0
	 7nfk0Av3UCj63rhJjLmUE/NCvKEYb/X1Qv8BXy3OTcU0SdIWZxOihZLrLERXuEvu9yg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792063122;
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
	bh=/ZUHSzf+PCx95GLiltcKLltaRqgtHeul3uaKw9JQkeU=;
	b=NJEpFnyMlt9hlviAnFAWiF0EHiZjFw29hNBn7+AaCLOjqoGwdxTgs+dq8d9uJGvHsnfg
	 CnuRfW7kq+vWpIzWL29+Cg08tJYDnJqynlZUihqvJ7wRejxY6pbk87MgAjhxViE8bFF39
	 TPY3IwdGbQTSkUypNgkz9wy3xN00BR0kMd8DqGrcFE2VRSL63Ff/qrumDCda3+9VW/h2P
	 +Dg3+uZXfY67/kRmb5lTjFheBIXxme+cgTNa9wnclLLRrsAODehyGNCymIeujM0GM8HDH
	 VE7IU6lgKWm8SKcj02mkO8neleqisLfgyKAyGb9Ih9kwTkcP/Bbgv5di9+ukcHlH57g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792063122;
	bh=/ZUHSzf+PCx95GLiltcKLltaRqgtHeul3uaKw9JQkeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QCIBdIf1dWgSzwKYRKWaVZxTw75lAkd2luFogg/7KnHbAx2hmdlxPdYjjP1cLKUp8
	 08ANTqi/luG97J4BcJRSEEskO2oxLSOqJ2HRgGobSQywMXENQDeRPjmcBbJIijdPeh
	 MT7zLu9twEHJgwrxBPFjO7Hew83Q3t3JCCjFvdjXVyArcaD+t/xamZonBTVf+eYbEG
	 PzQX9S+ED7Cq01vIZshMQToF/R5Xj8UlSVvZx4et0VZduaK6CeTPxjMZxwmFT1er9i
	 /YYhHJCJzZ/Zkik4PENEAd9AVHIXqP0aBU22MXSHRWssnYT3bZL4kaVJNh8LwGzMef
	 ireyeuoeA0SAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FCDB60758;
	Thu, 15 Oct 2026 11:18:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CD51A58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A8E94084B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xz7NLm7SZHhh for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:18:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 86E6A4080C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792063120;
 b=exDbzu2eE39g4aKgjEvM/C2Tvin/YgyQGt642C8jM6pTOq1IDS1vESYcKW4leWiWy5wQ
 C9fbhSryI1vZBc0vfggOif6n16AibNIeOiTvPhAbqlHaBULxLQF1GJM+R5YabT5Tppjr3
 UMNx2EhU1Vc+5jiTkPOX/BmlNy2jXI/vVTX8nZPWvl8ualaJWPGzpZ5p15+l/S8yc+yUl
 Kf1JVzUmcpTaCWDz80IUHZ6AaH7qdO9D0TN85SIco+P1FH11fhE7aa4N6UYl482xNMb44
 MKAzbVcxAqAFhYbu3lVUaI4ODPa5VvEOtNXkoLtEhzn3DeByDtqnGQHFGVlTaMRgahw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792063120;
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
 bh=/ZUHSzf+PCx95GLiltcKLltaRqgtHeul3uaKw9JQkeU=;
 b=gpyGNZbE7KtRyaP0BC3h2TCypboDx2A0HaCQ5WqLhHZK0NgiR2OjUbN7nFhUcWqPS8RY
 ltK/T0NDAK0c6SGiorcJgZowUC1HtERaB1gg083CiRxDIJZnwEPum1+Or+lu3Ktx0QjAN
 CoQBqFpINU0zhI4mGMOgnt1P3Cjs+aGhkWAd2z2xKWa+RSDUL8U1hREEIY0Za70S08Azo
 yYQ+DDpG34ELUnNl1eRkvdrGtSbQq6JAaWAhipiA6AfpPtC+jBWqZVML2LX0ebRU3Mjqj
 7vPNXgDm+9XF5kdfeakPoLa8D1FhVswc4MwDbfGEJwsCJLvVzrtoN/6F3dm+ZWQ+YmA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ZPEWoFTF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ZPEWoFTF
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 86E6A4080C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUyyl0Sav1aNYdsmzlAugR4a17y2CDiwgSFriqYqFw/WsXgzQuq66NlfKSu3Tewx9rVVTW0/wTOMWoJhZh39q+k4gYwD91ISUVRHl5se1vF366manc1Oiwb+W+a9Rzl5dzIha57eYpuQyTAZJElNKzPZt/v71fXxKPdNtQ8+40RebFWJ0YWWNQ4+DAeRAOIM7Yr1FO2JTjo8n8hbN/9J8CBfEdTb8hrGsYj2atDsbyzvuGhPqFVBRqsm7iEwzxAvVBKlEpfQ5B3TaRhfyLxJL22zqsVArt6U7gaQ3IoFgnhyo342R/qn1AtIElEJpXG4OkYa0avaiWK5ZiRHtiCWYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZUHSzf+PCx95GLiltcKLltaRqgtHeul3uaKw9JQkeU=;
 b=K6LSQZWj/LJ1azlCMymzhuBoyeDbUcLzAidSbn4lqZfNZrRag9qIiFqdlbbHbWajvE6Ugq+P4bWLgjg6Q8icAhyhXGkbXpmigXX5LEUeFRz60Q4Kbg5B9eZAr1NFBJGzrNblT3jC4UVH04PjT6aF3/luFumK39DhE1t1FciY7ebcfWuvlvZ7ot9NcTbjSL9pEhkdPNNnH2r6hO0XZEe1hcgzFaa9jYHJmI/pB5z5yMVjrsCuplq8rCFpijl+D8TGbmVOdHfZEA//ALi1Q/Jar9l473jZbSed9VBIbSLl6yVt/PytrQYjqgNlZJzaNW9gNC8bh4QYh6HTy7cxNS8UZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZUHSzf+PCx95GLiltcKLltaRqgtHeul3uaKw9JQkeU=;
 b=ZPEWoFTFqBMZjJ8A1/SLAlkxjmMSrH9ceVZwGU3X9az+UyOY+vPbsPWxoXDbQhY/HzktlIj7QowaWX+ncv5lIgK0mH+F1+y2GQ62h1/euNW5K2AG/oUXOfW7ESfb5cY2oxwOWqTMPfh4C4E/ph7p5JCvz6O02WhPv9OXiHsFp58=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Thu, 15 Oct
 2026 11:18:32 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:18:32 +0000
Message-ID: <beeee5b3-e96f-4fa2-b46e-df0e75916843@cherry.de>
Date: Thu, 15 Oct 2026 13:18:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] MAINTAINERS: Cover all virtio driver-model tests
To: Bin Meng <bin.meng@processmission.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <20261015111328.1269775-1-bin.meng@processmission.com>
 <20261015111328.1269775-8-bin.meng@processmission.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261015111328.1269775-8-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::31) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA4PR04MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d39c21-ce5e-4729-187e-08df2aae0c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|10067099003|22082099003|18002099003|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5TU2mm/P5VpjzMHVjg4uP3TMsMZinxDn2fK7nWykI1vpDVLE5Dz+gM/eXqzZrCHCYJWmbbYnpH8mi1tvaa5K54ZQZxR/f5KM4M3NqA4zSlPHnNoaWoTRCmzpEtxInwbLUvYeBTIaOxZyFCRPWJDsprX1s0jUETd0XvixRNGnaRj+cn592IHg2sr/GvRuv8QzpQJ646Y6KiV9zT5i2NmwFMYDcVJPfVPkLPEwG0rYJjQAFxYgUgFM56IyvaxM2q5NIMhDHBYSjXQ92dXEXjmC0FYorwVXzfiCBzS3+Sf1EZaldYdITXxykrMX8uMhUnLZ3j+PjEpLb4nv1+cSqi8MTYmJ1SivA1GAk3DyfHyiZW9N98v0kXqnG1Tvr8pTTB6zcz4HtbBVnAb7qktkHjjOp2ztKhBFmNrgO3l+xDNRU001wH7OyqUT8UFfYUWaYr/LUre49ELTxspoLZOc4qHTwV3wX14j3igs3uSrOKCLu7FjVRF0ZpuqMx/tP4wOAuX0nfc6Uu78xfGQD18Y6jrdcB7YMIv02esI0b1gyfdmLGzRaDOlA08M4j7nQr6rh5DOo4bNkkM+FbtLQP75AsOIw/btJHxvZw9MgI8EgZDT+U68rUov0o/xHYq8z0ipLCm5NAGBLZlwi763f2QQ3GfsOk7H4qPhfD2fGqcHByZ6cNk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDVEWDR6eXdVcmZvNDlWd3BRK3Q2aUhyTEIzRDNjN3FpWXZ0V3Zpd1JWV0lv?=
 =?utf-8?B?RHhoSUtzUTRNdE9XQldWVTFwaDdOY3lqa0I2TVpHVlNBTVRHVjgwOVF3VnBi?=
 =?utf-8?B?VXNkNUUvRXpScWE3SWdUSmU3bHBWVzBaamc1dVFxeDFaRGg1R0xMZGt5SVcx?=
 =?utf-8?B?eVE2Q3lHMlgzb0Q5T0JUeHBjck1MOVZRRmR4bGw4YVV6eTREdHd1Yk0zT2Rt?=
 =?utf-8?B?TzJ6ZFJuTEFzSFNQTStHalplYkc1ZjFtYkZFUEtjSXBuTWxiNjExM3hVUmJt?=
 =?utf-8?B?VHg1SHhBWS9jY1ZERVpYb3FnOEN0VlZjU25ycENpc1ZwUG1mM1Nld29nRVNZ?=
 =?utf-8?B?dXkvOHNiWjZ2ZWh2eTlvSk05ZU0wdFdqeXdmVjU0UjFoTHArVHF5R0I2UmhO?=
 =?utf-8?B?aHQ1b0tNdHJrNUpOaUxGeGt0OFFENEdTVHh6TUdsRmJtZU5abWFWem5sMnRD?=
 =?utf-8?B?aWZzWUlSZXFEbjFZMHlvUDRWMFpHaDg3OWJWVTViaWVLQ0pKQWJycC9lTk4r?=
 =?utf-8?B?ZDM4eVpmYVJXdC9aYmdPNmxmU2tFRk9jTzlxMUtlK0NBcGlqTE9sekFhbHcx?=
 =?utf-8?B?QW05QnZENUlMVS9Dc01RZkNZcTh0dWFXdWpMSXhtQ3NqQmIxOGtsczNhWWZV?=
 =?utf-8?B?UEFqUVdyTlVyVFlGK3NvSkY4T3JqL0RoT1NoRm9NS2ljZkdBSFdib2w5YVlB?=
 =?utf-8?B?YlVVbmQ1NkdWWGV0d1BnbW1iVTRLU2Y3dnY0eVNwZjdMSUh0dnRDQjVkQjVK?=
 =?utf-8?B?L0c3Y3FpM2RYMGhSZnkvdnE0L2d3bDFJZ2hoaTBtV2dNMDcxa3p3cjMxYUVD?=
 =?utf-8?B?Y09mdUZqWjdWMkhaRHFpU2IzVU9waklsY3ZsNzhGaWdCS2ZKQ1JWNWR1U2dv?=
 =?utf-8?B?VlZXaWxmUkFIOVBjT2YwMjRzVW0vRWp6ZVRhc0gzZ0Q5YmRWS0dWUG9YbmpC?=
 =?utf-8?B?a1BVMERLOGRpdjh1MlFaeG9QbngyNXZhYnlmT3JtRWk2K1JBN0NTL2tsV3pw?=
 =?utf-8?B?WHlGVW1QeU1VbmJzSmJKV2ZIU1RoRUhNR2h0Zk5kZlhPbkhSVDR5Yll5Nllr?=
 =?utf-8?B?T0RGWUtJZ3ltREJTY2lDTkRBcTFLcDl3Z3pjQlgvcHlPY3ZmbllweXlSb25v?=
 =?utf-8?B?anloV2dnSmtDOTB2WWE3S1dEdEdMbXQzYnhEU1VkV1RJZ2M3YjU5dWN0ckkr?=
 =?utf-8?B?blNzaS9BZmFQZTZ6WjFVenVlSFlYUWR3NnllOUpNWDRXYmNmeWV0bDZtV3Q0?=
 =?utf-8?B?b2N4VzJCdnFLTjgvS2hNMXNvTGtseFpwaGx0SW9VOVU3T3M5dDE2WGE3OFBV?=
 =?utf-8?B?TGNFZ0UyaVJ4VGFTUEZodTlEdEVhV2RLaGxiS3NnWHJGa2x3eGNzb0d3Rk96?=
 =?utf-8?B?alF4L0Nnd1RrV05iQXIzeFhMQmdDZmJSTE9aQUNrTGs5QUNtTkNWTmYxdXMz?=
 =?utf-8?B?Lzk1NW9aeDJUUjZqYVViNFN2cERLVUNsMUdXeGN2dlJsNlJPVnRMSkNzbjhh?=
 =?utf-8?B?TzJrSkpxVllrdlI4aUttem1FY0NKd0llZFI3OTFRc1ArV21uNUxYQ3VlWHo1?=
 =?utf-8?B?NXBSTGZlK2xiTmdMY3UwNTFYQ1VOLy90b3ZyYUFtZXNJNFNPbTN1SE9CSGFX?=
 =?utf-8?B?WFg3blMyNk4yYVVvSmZQcDhXZGF3RkdUajVYVCtiS2pnbWgxUW9wK09HM0tD?=
 =?utf-8?B?ZzRFOXVnSlpmNkNTQklxU3ZqaUpiMTArYnhGQmdBTzFkdlFlR0dFMHlDT0hP?=
 =?utf-8?B?cjkxRisrVTkzUXZJYVlmYi93NmxhWG9KZVRoN294Q3B3OHZLR2VSd3hCbVdR?=
 =?utf-8?B?TFVZS0tRZk9kMTFXSE8rR1c2ZmZWa3R2TVZHQ0dkSTJFdWZBNE1rTXcyKzdq?=
 =?utf-8?B?QmsvMXFiNklSa2h6NXlTVXlXdGJZK0VOZXo4c0dsdDBrdkRGZ3FsbUZjSGRN?=
 =?utf-8?B?VUVWWVRoVVVKaWpoTTFGczVZdk4xM2tPVC9Bd1BJT0pHMnd2NXY3M1pPbW9z?=
 =?utf-8?B?WmlBT3lKTjFtcDJwTUxHRzVNOCtIVHovMUhLd011M0pORVJxdTFzK3BiVHFv?=
 =?utf-8?B?TTR0alVzcjQzbEphbWEvWEV4UEptcVpvY0x5VFJoaWx2bGdCTmRvdXFwWi9w?=
 =?utf-8?B?SVhNM1RLaTNBMVltRnJQZUNqbVFjdm1pa2ZDdHlJM2dBcGwxRXFBdEsvMmlU?=
 =?utf-8?B?bG1nL2FBOXZpYWh0clVKQ0gzejd1ZFQ3aHVGRURORi9RQjZXT1RTTHoxajNO?=
 =?utf-8?B?VzZGMUxCaUJWbTNXZnE5L0gzc2NnUGdtc2dEVTJRdVJueVJxU3RnL2ZsTEsy?=
 =?utf-8?B?ODJIamdwbEt0bmpYNkVtdXZ3RWNrUUdTbDduZXZZYlJFNDlXeVdKeXpQWndJ?=
 =?utf-8?Q?GJ3qb+W5z3LnXbogfDIkGMmjBf72JZDZhlKjNAxY3g1yF?=
X-MS-Exchange-AntiSpam-MessageData-1: CPAxGaXUcvDPdg==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d39c21-ce5e-4729-187e-08df2aae0c0a
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:18:32.6212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZWJzT2MYdxs/qTrIHglCghxamPymVScYaqp5ablKFeC++v3lKLoT0fhJi4Uhjho8hcIeFAfKX2vU46HsFRxaFiqMj7evQrlJgyf6O0P218=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9222
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

Hi Bin Meng,

On 10/15/26 1:13 PM, Bin Meng wrote:
> The virtio entry only matches test/dm/virtio.c, leaving the existing
> device and RNG tests outside its coverage. Use a wildcard instead.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28d090d3c36..05963a84c0d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1869,7 +1869,7 @@ S:	Maintained
>   F:	drivers/virtio/
>   F:	cmd/virtio.c
>   F:	include/virtio*.h
> -F:	test/dm/virtio.c
> +F:	test/dm/virtio*.c
>   F:	doc/develop/driver-model/virtio.rst
>   

How about switching the whole MAINTAINERS entry to

N: virtio

In any case:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
