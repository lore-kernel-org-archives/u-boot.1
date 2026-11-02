Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3E606E03F
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZrgW3vkj;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Gc+8Rdhk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE5DD40642;
	Mon,  2 Nov 2026 14:53:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y9PdyULai3pV; Mon,  2 Nov 2026 14:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B123405F1
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793631193;
	b=R/CwT1xaE581R+N4VEoBXXnlEi/Sja5PHWjO/LrxB3b2YoIffhNWc8NsbC8yVBUBPQbT
	 TnMfaFEWF5DHloN+InT+qmNEg1XmCJM9cZZK1rR3W94TREX2lgonJ5VK0HWUPhYC97Twr
	 aXh3N7x3xJ6bugaB22AwumkIkzJQc5KDHgQXlfBrgRUeXweFXSRF4NH7DApkp60I+BkNN
	 42X0tsQc9yQlW1OJH7txvTYAUBzzX80/3H04mSzjSuJJYs/W8UQi5rKYKYDyZ/+0/gQsW
	 zqLQh5v1AKafgq0j5CY9HyfIjvsMlGVrMQChRKh0ytO/og8k8y66/m/kOV/8vhC+2HQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793631193;
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
	bh=NMTWwefYbdH+qV1+Rk/3sSolJ7o9Pang4wm2XuM5AQQ=;
	b=oYCtnNcj6kVv2J1TaU3UL8KFqjQlt3qaacFlyijQLNBGNClAbrJLXOLuo36uyupYlv4I
	 VnbU/G7c1/I9DGAyPmMicAIrx1BQ4GLPwOGDhu3sAUfSboAZYKQetdlFxtqaplr0X18ta
	 +nkMfnKmfo69Q+G6Y413KHD8BodzQLQL/ao/wODVb+EZ+77G9UuMoWpVPemrmLFW4HrLV
	 w1vwv6iRLm9YvxaqRJMHF5x4vfHeNBVrWispJVCtL95fUivL4/n2H5WQ4+eVgIohirGnD
	 tQOmZLNfIjymfOP9JUzG0yNlxhdIKpDcXtQxCf9vbijFZ1snjpwM/KSxxgRMWmFXBCw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793631193;
	bh=NMTWwefYbdH+qV1+Rk/3sSolJ7o9Pang4wm2XuM5AQQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZrgW3vkj/1grt8jBv2pbZLxcXVT8NRQ/7tiVtYlFhtcKxrKjWtwdQs67+vyLHrZEy
	 4juO48z7uenxfoLwhugCeP1xfGo5acjqIdhUWUckZVP2YHO8KSpfE6uQ0Hc3rUpSQk
	 4DhiMSoKMvSS/7SWozjaaYL/mvJ0UBcaWC+GvNrQ1eE2TeBuc5N8nozpA6fIKmIIsm
	 ZNf2ml0CxdGRbk3ehhaXwzhdHzuYM/D8c1xvHVPFeGM0aq+sU34gcFyz56DwJ/ggfj
	 fC+8RfnikKRk37I+AHP24K+XkqNjbJQLhKASw3QI7IQ2f8jsH06Lt+CD5h+bwRo7Z4
	 VvZ8Z5yIenGgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B123405F1;
	Mon,  2 Nov 2026 14:53:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C1981435
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B060C6066D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hzoRCe15rJbb for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 14:53:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04CB4607EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793631189;
 b=IoyEuPzGjLnvm7KL0HM9Ud2yP02YZhblRhI1jMYJz6PGM8/lwLECW8Ch5Wu9l4JPoQWn
 jGAo3FifJCEQGSNIpJt3wZsHHzc+rImxCFEVGVtBQyzi61irmFZVSaZNxaDX9NYKcKNMu
 2eyDGdKGKWgghIDJZepzosxrGQFzYo/Phe6/JRryWmayo2xF/ior58H/TqHhij4D+7rbK
 CqNsQYZsUCyY48PHyi0CsLEEr51RnRHISsv42N2vwvsgPPIjkGc81sWXvln9fgPwUArix
 Bohu5xDks7xmQB1MtOsvtWoblWhuayNVC/Df+4Z0ZmbS/8s5jDJFwzMLUWLxwzegZPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793631189;
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
 bh=NMTWwefYbdH+qV1+Rk/3sSolJ7o9Pang4wm2XuM5AQQ=;
 b=kjReI2kF0UmLia6NZpITr2AbFwnqIhKHvLdBOfvJLUhTWClPniwjA0lY9IJcZ/ygowp7
 Wne39DlKWh33tD9EbZrPyOqgo8oLzb/BCC+cc51KOaVpvPurWdey9R64nph04qzYTJ582
 +ghk9qGsezPpzCcYHPRyOCwLS3b4I9yU3NJZc7yE0qnami/vx2qVpL3U+IdmcGOEGQqlS
 tZd9h6IsLo2ACoxIOEfsGYjauOhwMgWpcsHyJsd7o20CaK9iT93vB4EAeXDbF5yXUknDJ
 /MqVHUTdgDcyF0fNQVuATWwZf64TtwOAIhRl5gzCVh+ODQSXN98EPK5jv89+MFi5MlQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Gc+8Rdhk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Gc+8Rdhk
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 04CB4607EE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:53:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTK/tBaz3WL3toea1QfECVaJXCHPvymw3OKQDea6s7g4/cLMtMTn/U1XwmW9T4bwgP+ooqoSETGFwNN9nMHeordRpplLLuKc5yNfBDmsNS+I04Jv4HGFDh1dbaVSaFF/vTRq6weok8ko07hoxx/njQgRew2GmopxJwCsd+/i6kIY5DqsD838mgfCuw43nL6KxdNwjenWstAFj4okdYjIkWMKrc74h4FdA7LXC/iWf+w1UEBsjNVlhVBwzjcUMmQ/Quh2kICehPfY5L0sBXwslJefZKivVSGPkp+hFDhpb4nvWaR9RIPqZSfWIca3HUTkQCEZshdY2PvDXZPla7dA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMTWwefYbdH+qV1+Rk/3sSolJ7o9Pang4wm2XuM5AQQ=;
 b=oNhWq65ASyfQLqc/quZE4Etje1GSxc5c2rQ89raLHo5BM6VlribTCkc2oSaZ8fGV6XZtQkURiEae/ES9U+eUodsfObxPn1INWF4kvyo37x4PZBqxXtzSnpT1CK1ABOeJx/xfp6ncC7q9yx8EtbxYJ1fkfMxPI+34vQ0yN9s3/sRs27M15Rao2xaZ9s2vFyNkrZm7b/km4RaudUTsopBdsy1kPb8E/B1HmkdE2BjUDr/B6GXg8e9qQ+5B5csSxrStpZ5hr2cO4TJSxBdRRsldFEGtRx6gFvi3XvAu14Wv0uPdnsC6A4nYgdLzBBIauIZvMaeuqucq5IrJIgJkjkmkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMTWwefYbdH+qV1+Rk/3sSolJ7o9Pang4wm2XuM5AQQ=;
 b=Gc+8Rdhk+CdgyHvhWuZjRUD36co1y52JGizlo/TbDs2dMv94T8daVfr06J47phuJZuNA0aWvtrMU8Ki/mgn+i0Vu+UUSj51MGyxlt7s/dKq2+DD5XqQPwFl5AcA1Y2gF6s0XsGeVVLucE7ebVNaSUvw8BNvk7j07uQh3+3adDjo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB6913.eurprd04.prod.outlook.com (2603:10a6:208:184::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 14:53:02 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:53:02 +0000
Message-ID: <a4934306-eb4d-4a0b-b693-82b8f8d831b8@cherry.de>
Date: Mon, 2 Nov 2026 15:53:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request: u-boot-sunxi/master for 2027.01
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.u-boot-project.org, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Christian Ratzenhofer <christian.ratzenhofer@cdnm.at>
References: <20261102114733.3468703-1-andre.przywara@arm.com>
 <20261102144240.GS3309461@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261102144240.GS3309461@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0122.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::8) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: dd2ed17c-6081-4bf2-5fdf-08df38f0fe45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yrCYh6HtC0QHs00XCVO3oW7lekBWhtozJX+zhdXXYl2Tlfjewsse4D7nqJopVstAlmecdfKAiSJYRH1JcjJsHSSg2b5lmY+n1sfsj1dzv37A/d1bF7Yid4XVgPR4pyXSCOctxDTen090fXVBEkGv49Htx/3RzXKrhYpV9hTvjp0RvXJ+44hC8W8oZrajy9L4MzSqSHBbN0aL2sl81QOLKP+of8Olgu/fkig0paCcLpW02SJAO6+XkTc0yDGPeekq1XvSkckdXr7BE3QANl4B1ONm26dyyYniYN96Fk4Un6q+h/X9xqlqKh9oFVerPpvpyyOkmbS1UQRLN9IqnZwa69mFzWjkSAo3PZU1tloKwOp3jE/FnLseE4ygTVkSmEfk7cZ6RZ9+Gjvmu1IsdtVnHZ3KR+EPRQDwLt910D857tp8PiwAhrS2mOES0ZPvk7rxJ8CRxufO64nGRHZU6i5HBhYHnuj05VSgPH5Ps5NwOMYXUgoTrIScGwU1dMIwxdjcX24ahqCOUs6ut2h3n+aPdxm73ySJ3NYsEcdgVN6DzekDqrGUr0N0NNDgVKYCe42+QAz9eW1SbS3jsxEbj/pZ8oYBauhTQjO1j7TrzALyj4JsFzx6BMq8myqedyhiiwr6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bitZSUVXUitVUEFsa2hvR0Mwb3luTkRZL3BXQ2hFSHE0VDl0WFlYZXp0bFVt?=
 =?utf-8?B?dnJKMUY0WmI1eGxUYlEwZHE5T3BRcWYrOG9oTEt5NlBjV3dUZGlqd3pYUjQw?=
 =?utf-8?B?MDVpeVRtU015emhCaHFuT2tGN202Wkhyd2FFc283cXpoTG01eTJaL1JuTjMx?=
 =?utf-8?B?M0hvM3hTdzdrbUJia2haM0tTa2MvSzJ2N0hKTktpNk5XenRPOUpCMEErcnc2?=
 =?utf-8?B?TVJzeGFOeVcvbllSNHpkSmhoL0IyVisxczUvYm5GSXN1OFQrR1pCd3A0dmZa?=
 =?utf-8?B?ZjlzbWN4MjF3Y3BGNldWVURnMitibWVMNk1YNzZkS2xJQlBBQ1NCS3pIM1h6?=
 =?utf-8?B?Z0tvVEhqQlBMMU5ZRlE1aXRxcU1tUjUvWm1iNDdwdFhJb2EvS2dOL2V0UWJw?=
 =?utf-8?B?Yld2QWtVVWZlcFdrUXJHYXdKa3MzZEdMcTJ6b0RDRVUrTVdaTEpFNG05eGNs?=
 =?utf-8?B?RzFReFVHazI5MFRDdTNDMVBSWmFZL2I5MWd1WmRDdURDa1hDWUQvUzdWbDI0?=
 =?utf-8?B?cGFDSm1jMTcrelQyNm5pT2Ftd3U1L1kyM2twWnRWMmoyZTJWV29yWjg4MnFq?=
 =?utf-8?B?blNHOEg5dThtQ3JMUnpoY2ZsV0plWVdobjlzSjNxWmUvUzNMWjRDeU85YzZL?=
 =?utf-8?B?eEwycG9QZ0Z4L3BhWGIzTjFXempaWVRUclNLcFJZQWhJUEczdEIwV3I3WmRa?=
 =?utf-8?B?UnlxU0RvSlM3Z2dtenY0VVJOVElnYkhocVh6MW5vOW9SeEhqQmdZcHkyejV3?=
 =?utf-8?B?QTlUVXE3ckFPUVRXQk9zdGtNOGdtb2tpRDE5bDM1eDdsMWZzblhmZHpKSnFX?=
 =?utf-8?B?NWpDSHRYQnEydjJDY1laV1FjRlFNSlpUTWh4RlN1bFVDRWpRay9uYjlPY1V2?=
 =?utf-8?B?Um5Tc0duL1diNFhZUDdERkVXVXYyQnhZS1VrOW9jQklQNWkzclJxUWFMMUhs?=
 =?utf-8?B?djNRQ0Y1L1lmTVFzaUFUblN0KzBuQk5KMjdyL2U1NEpUZmFFQ1U5OHdvVjhX?=
 =?utf-8?B?Sm51RmFpejRkbGw2aGdZY0pqVlRlSkNBaHRzZ2EyZDlZWThaRTZqQ1FUM3Ns?=
 =?utf-8?B?QUR6OStqUkprSjlOcENwcFV0allWeVFDNjNSM0c1TWcwVXBiQkJndFYrMnRC?=
 =?utf-8?B?aS9ReUhmSS9pVzJaZVY2Si9NeEY3NVZ3L0NsOTE3c3cvMWZmQ2hvYVlCaUpE?=
 =?utf-8?B?KzRZZVVxQ3NDZ21uNDdsWEluUHUwb09qeEpKWU0rK3ZtRjJ4aWx1b2pQUVg0?=
 =?utf-8?B?NDNBN3dBUGorcFhoWUh0M1Q1bWlGamJqQXVjcm1iUldydDE3eFBNQy9xMHRM?=
 =?utf-8?B?bm44Q3hiNjFGUnVpMnBUcUllWE9rRXVCZmtVdlpsdTN2aWpmSkpnV0lEd3JM?=
 =?utf-8?B?eE1CNVhlaExhdG5pWWdHUE9mQStaaENWd2srNmQ0Mnh1aFd1cVdTMS9PNUkr?=
 =?utf-8?B?RUlyM2VrTlRoazB0UW1NajRTWVFkTVNGOUpPZ0dZOXBoM3FGWXZ5OXIxL0Mx?=
 =?utf-8?B?SXlJeCs5elFrY3lnaXBBQlgzN1g4a2pickk3QzNmQnJvVHNLRW5qaVJ0c2Zo?=
 =?utf-8?B?eDlVdUMwTU14ajFQVUxPTjNBRzdJQmFSMHZFeE45cWRMbmVibTVRUktzbmh3?=
 =?utf-8?B?SjJ3ZnVSNHM4RE56cTdFMnFxMVZYTDZBMEFpYUs1dmpZN24rYVIvZitkOVRH?=
 =?utf-8?B?L1p6MjRobkdBWXQ3Ynh0c3VaV1NzWFhPc2VJRGh3MVNkUlRucUZZLzloTE5E?=
 =?utf-8?B?T2NCb1QyYUttcWRiUnU2NHhHZmorK0h2Y2lIaEw3b0MyNUlROERqWTJiWUJR?=
 =?utf-8?B?QzUrOHRiak9RdmdpZVZnTHdUWWE3dlhoeVZUNHdXZjZXNnhXcE5USGtuU1VP?=
 =?utf-8?B?MlpEejVLMDJKMmVkSGJsdlVUaHR3MjllNFV4OXBIYUhpODlQRGNxeUIrYUZR?=
 =?utf-8?B?RzUxUFNiNEczM21RSzNoL2FMOHJ2TjFCYlZpMmh2SW5BVktMWjVMNlNhdHZ0?=
 =?utf-8?B?ZlpnRytoMFFLWFBIcXB3WTVSaXYzdlFPaERmNW43L0FhaDYzemhqeXkvSlE2?=
 =?utf-8?B?ZCtVZVp4SkMyUHE1NFpyV1hiU3RlanJUYytiWWtjeldvLzhlNWV6RnlsT05w?=
 =?utf-8?B?cm5tK05BNk8rVWhuMStVbnlVOVpLaER0aUNGQjNvYTRnZXZ2dklxandsYnlK?=
 =?utf-8?B?dThhbmprZkJqdGJPTXlEd25jS29OZHdhM2ZrbENBUDFTeVpPWEUyUEEvcVJl?=
 =?utf-8?B?Z1FmTUVsbkRKVkQ3b294M01LalFlTlJkak45Y0RsWXBrbGNudkRLUXE3Tzdx?=
 =?utf-8?B?R2dFbTg5MWExRVY1VjJ5a1FtWHNXbnVUVldRNTNkbjBFOURUTEtPQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2ed17c-6081-4bf2-5fdf-08df38f0fe45
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:53:02.0109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNMjF0k87MhsQj/idTijsdQ19QHYUa5rleZdI5mLQ32OHuTg8e5/5hZjU3HhvbXEZD/8jHFeCTdg3sgQRU3DxVp98XZ4X0PG/yP8EwzNksY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6913
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andre,

On 11/2/26 3:42 PM, Tom Rini wrote:
> On Mon, Nov 02, 2026 at 12:47:33PM +0100, Andre Przywara wrote:
> 
>> Hi Tom,
>>
>> please pull these sunxi changes into main. Please note that's the master
>> branch on the remote side, the main branch is immutable, so I couldn't
>> push a fix there again.
> 
> Ah. On that note, I think the answer is you should start using a branch
> name (for-tom, whatever) or tag, rather than just pushing to "main" or
> "next".
> 

Maybe check in 
https://git.u-boot-project.org/u-boot/custodians/u-boot-sunxi/-/settings/repository#js-protected-branches-settings 
if main is protected, then you can unprotect if you really want to (or 
adapt it to match what you want). Just telling you how to make it 
modifiable again, but maybe Tom would really prefer a different branch 
name as requested in his previous mail.

>> Not much to report here, some cleanup for some older V3 SoCs, also a PMIC
>> fix for some Olimex A20 board.
>> H6 boards with 3GB of DRAM now work again, and the A133 build process gets
>> adjusted to the now mainlined TF-A support.
>>
>> There are bigger changes lined up, but they depend on DT bindings which
>> have not been merged to the kernel repo yet.
>>
>> Gitlab CI timed out, but worked fine until then.
> 
> Ah, I thought I had adjusted everyones projects to have 2h be the
> timeout, but I see I missed at least u-boot-sunxi, I've fixed that now.
> 

FYI, I had to bump mine to 3h a few months back, but maybe the infra is 
more stable/faster than it used to and we don't need that anymore?
