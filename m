Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33D606A323
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KbR5zFTD;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=hYW9qx0a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B304D60AB9;
	Fri, 30 Oct 2026 09:57:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1RpvRHm2l8xg; Fri, 30 Oct 2026 09:57:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0245A60AA5
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793354245;
	b=EqpoqZLgnoN5FQqB40byT7LkJh1aNlqsUMSD4GP1ezB0LRuJ3ZfJl4uEIRO4D0urkiin
	 39LIqmeKXRMogpNR3K58VAxnfaNGfjIw0T79L4CHPFz/Oot2VJyrWOSIVnabhqrLmQoWa
	 0T9W+eUpqDBsC87lZE4bzwHt9PGZ0P9MyUFzzUA+52GMbcKjhH7+46R/pOMxlIPQZ1agF
	 M8rixmm5qkFqm4LmA/vHohHT418R4XIBkJl94SvvUlG/QVUJB06+AzJqlY5cczdgCYPxT
	 YH2I+npxW9JCnAzgM2H07qYZ8D2rYs6x3/u0M42BC247mxUFxEb5F0nEt9OdrMp0pgg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793354245;
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
	bh=S6uXs+kXyItI9ze+wTBJ1kcuqhKgljLv7MPYdg021NU=;
	b=pSfXc52kuVhni0pNo3EILPiKly9hhQSOIcIqt8WKkmxM3FApG14QTGSWcaN0mYZVowdj
	 tMqgBJXctp7zlI2ZLD12o6XhtfZO2A8NDhPwfaOp8pruzClb0E4JyLsQni67ddQX1itav
	 8e0A/9jsqYowiXoqYshQsgjYOWhk6isFRZslaKQpnzGMu4FAeBTAHeMBc9lUNveiOMgG0
	 nfpOq/wd2OmdWviTNJvnDCqnuyqwv1W+p0HQGTpA5HHXYY5XSEEW+3l8SY/WEiFKMYlYK
	 d4t1bm2lQNHwf/VQ5hp2/o8/cFHXG3pJEwJjGEZUVdn4/WitpXjpk8pNF8S4LTr3jmA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793354245;
	bh=S6uXs+kXyItI9ze+wTBJ1kcuqhKgljLv7MPYdg021NU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KbR5zFTDK10XDpfNb/Fnwf+HgdouAwUiLaGrz3CAoN5C/czfiOlAKAN9aHa4Qr6o1
	 5fearJC2M4TchMZZxTlwEIHAvPTk4BRdaz/dLDcEm/38QNP7Fn38kJeWjGkXHw1mIL
	 knFuKEdVkANjJuWD4+oj+swKTKidpfS4aIRYBK8s+qhtXHQD8ecRvUzO7AlkDypF3t
	 zdwhAyJEw9MxqJqBDkOnVo9K3xzSnUg92gYIMcFj+QwrmCqXbwW9sj2P8LrswtSS1l
	 EkqjJBkJg9BkqFXn1qfBBEGjlWCfHuFcuO0/S1QB7eQEOof2AbLUoizUV8yrLLPyIS
	 dvWIkNLGPIx1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0245A60AA5;
	Fri, 30 Oct 2026 09:57:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A151E235
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:57:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86B2940AD4
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:57:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pVfnp21S13ca for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:57:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C899240A85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793354242;
 b=OyeVZN6mRpnceJ2mcEnjn0DNMYv48AvfZGfGpUZUzEaBffiEMgWx/t3tNe484/wGjIhm
 nGp9qKBVJ7dnbI3ZL7UgsAJvCx65FzdDc1++H16UlxoRdQg7jZwYqQ5b2o8XYarwoKgy1
 N/eaq/D7fUoobPDvHPDcy3yuaZ4KJ8PD4YQsFGJNn1Z1lLu9T3m8e6BXk4lEDnkvh5Yzk
 U/EKhgKUDrQGeJydfXOJCWktd4vNK7+V0PtkpzKO+zSNGwakwu8Kq8OAgE/leLpTgY6Vj
 NtxDmxHv9Az61AumesFTysl8VMe2q2xeRZPo+GTpNE4GIhesnH4wh+2yPxhjbR62NNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793354242;
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
 bh=S6uXs+kXyItI9ze+wTBJ1kcuqhKgljLv7MPYdg021NU=;
 b=bF9fajkzTueB9LPE5e6QH2RpOKSi6cBdYG2wxoYOXrUmmTP3Cyk/lIEpeQg58exdTCNV
 5g9zgLE8ChRoaXxMiSgLdcIgkHVQwqxrhNCH+AxkZJQR9fFSkZisDvbHBjw0Op7PAJiUh
 ug82ppO/5N3bpRq9FbgJesy1WZi88Y0WSE4sOg04epwpIdpenLbqjlsyhmEkKoVORvGZJ
 +mWcIqnZj56IdqNF/VVHzSRq9wlE5OvB4hTweevrRXDlTH+6LXJmLTAuTrxcHd0++v8Kx
 nvrgQANXXl31EGrKuB4XV9pUukT7daUM5GQPTWLGhPUjT+IH5JL5K9RLjHtYY30S/hw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=hYW9qx0a; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=hYW9qx0a
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C899240A85
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsYs7E7g/P/hy2bfyUYWShw8ygcFVDp0OvN7qcweZbCPzJ5cXy7gDCxP+EYVcXLLwpDjoT10oiTYvKLzQqmiE3ZfJUi+f0G/Y+kU5W/NqDf8HYsslrMHg4hB7cx7zoHFEQ27oa5hIIGoxewgyet88LPnckTnUgPRugXu16YkwxpmSw7nRdVE1wOJNE8LWMIKvp8/xxUXTvR8vVLd2aWJVMrwvuGXgCFntiaeCYZfv6rcidXuOlFdz6+libaLTnf/CeHI47NtDiAdIvIue+0lbtggwYZvA0IAl2VgD4/VgP4enoT/79Dq0f/tJWH3CHQRt+/jOeZP6mzh1ksyc9/36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6uXs+kXyItI9ze+wTBJ1kcuqhKgljLv7MPYdg021NU=;
 b=RMMixUh5lILE03SkZW6AVsBUK2x9hCj+krgygs+eA7FkacRiSCC37zHP2JOee4at6Hq+4iEST6NWmYeIjeOsaH86Yl9jdW5+faWg0QteRpW021uzgyzKGynI4HWWeVJCe7GSsXg4eyBkd1h7RN5y9avrGuO3mTZhVcs/r8KqepttgC5GBCOU5GQf97HHpIO3euFDg2GMm+WchJASCuHQbUVfiyFl9KLO5m762m9OCkH9Sf0/cbUOZU2AKvIzW5NP8U5dckg1zaWsVdyBa+eVP0xSV4oilLaNMsnh6rb/LmzU9YfdJPgwQ2cMj8BjLF/jOtcAz0aNlN2UA8UTKEAJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6uXs+kXyItI9ze+wTBJ1kcuqhKgljLv7MPYdg021NU=;
 b=hYW9qx0a+RfBjebWYXHIFlZK5VxUou8ztMAji2WwcgerUi8SUUHhq7N09rXPZ87d742H0gCDfqUI5F7oS+6cDmFThI6FmEtQ/3kFosmuc5tryGKUseLh2mvXBUxn+b64ZWqa6qEfn8Th9ueq9OsS9JriCVjrWCixhVk3nFg0oL0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB9950.eurprd04.prod.outlook.com (2603:10a6:150:11a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 09:57:13 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 09:57:13 +0000
Message-ID: <f7b2f1f2-e8c6-47c1-8e47-795f6ade7618@cherry.de>
Date: Fri, 30 Oct 2026 10:57:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
To: Eddie Kovsky <ekovsky@redhat.com>, Tom Rini <trini@konsulko.com>,
 Tobias Olausson <tobias@eub.se>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>,
 Jan Stancek <jstancek@redhat.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>, a.fatoum@pengutronix.de,
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: u-boot@lists.u-boot-project.org, Bastian <bst@pengutronix.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Jaipaul Cheernam <jaipaul.cheernam@est.tech>
References: <20261029201348.730274-1-ekovsky@redhat.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261029201348.730274-1-ekovsky@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5565e53a-cabd-495e-37a0-08df366c2c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|23010399003|261022115727099003|261021130227099003|261022113327099003|261021121427099003|261022105027099003|10067099003|56012099006|261021123027099003|261026121527099003|22082099003|18002099003|921020|11063799006|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: IKW4EtHUMRgSJShKWmKrs39morN1JkS5RTvsgjzgAnpCUebpiY+nQH95fN3tO7SsC3j0FYnZBJGZTIrxW/N/QjJNrvOLeONega2xSR7K3tPp1o9QoVo3zou6mWlLLJPbnWM6kBUplW7hq3X8oeUlNQK6x6JHsgdIN2dsTqBQajXkldXywaB3ie1T4jaW3EniAmtvh2eZyygB1MLtghjk9krDVaPMzM6Aoe2xjvtkpRz75D3bPQ2zuggXh156QKelS9qi23Jf17M7+5LUgHXAE2baXLoLrX3IVNRTEv1NRSxfC0EgxdrOWDmnVLXulGtqdScDBW0nM99U2a30mZB6JBh9unUcJEczleFG2Q8f/MQzHaLEmG4QZ4Hi940XaCUJyJ873zLOctznTd0QcfvY0ubWrvGrn6kGcIvXgDMHpvVVOGo/19CRfqQcr6kn5EIlHSCDFMJBGzueJQYHu4M30TWGFKw6nUsl5SJxrebldp2Iz6eM9PnxiTjSTnjj1P7n1+X0962HElhj0KxTrEDRl3VzqeKgc5OWgwz0+8UpqRESyS+vPLlud7wzytsjGZMngESH9oSPjKJYK7AMlqoGafLp2M9PvT+coNDHWo4jPKPJ544vmBnlDGDiH8WtbJ7mScxpYa40kGlzee94KZpLf0h3JPziUQ9z51Ec5XDmXaMpGMeVAet6A+Dvo908UqyAprXtGfzzia+JeAayoEKTEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(261022115727099003)(261021130227099003)(261022113327099003)(261021121427099003)(261022105027099003)(10067099003)(56012099006)(261021123027099003)(261026121527099003)(22082099003)(18002099003)(921020)(11063799006)(261028144727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHg4NFE4YmxkZ0kvOE8zTWNjZHNSUG9QSWRhT3g5MHN0SVNWZVpsUTR1U29S?=
 =?utf-8?B?RE9KY3JTTEt4Z2d1ZjF6NzhQUWd3N1dzSHBuNENqcFpkQUFBRkIrS1lZcGpL?=
 =?utf-8?B?aU8zcVdaY1BuejZzV3NHZG9nNkswcy8yaU4rQVBBeXZqT3NEbHdhVk12RGpK?=
 =?utf-8?B?dnp3MVVZRkFNK2ExY0crajRKNTFxS1R6N2t1VTdENVg4aGR5MDB1SnRSV0pY?=
 =?utf-8?B?MEN4MVlUWUpndmo0VzNCT1AvTFlWZ1I0RExnSkFkWWVoSG1CT0lIa2VmVlBW?=
 =?utf-8?B?RDZvbnBXRUxqRUhzR1h5NytjdTJmR2ZmaEtNYnN2dUtNQndpUkZQWUxSd0RU?=
 =?utf-8?B?K2w3TmRQTjBJdnlDM1g1ajlDV2VEQ2xtb0RrV3dpM1RPQ3JPalVnY05wUUxs?=
 =?utf-8?B?SjFDSzkzQU9KOWNpSm5VSHhKaXlYTTNGbDZYbGltdCticmdUZVRxdVNMclB0?=
 =?utf-8?B?VmdVTTFkeGU5amlIazVqaERQaFk0dW5MbUkzM2hJWEJWbTVMaUJzbHNsZm0w?=
 =?utf-8?B?QS9tR0JaeHdHYmpvTFg2cCtZQW5XRmwzdUFSMFZHQkFnRU93bTlkN2wvKzd6?=
 =?utf-8?B?d3FFay9EUGFFV1BGcXJmczN2RjZGTnE2U3FnZTBRQ2haazlsT28ra29SSXhP?=
 =?utf-8?B?NW5rQ0FuQmtDaXRYdzhQekl6QUx4bjNrU25IQVhQdTJsU0xCK0hhNFJiY1VN?=
 =?utf-8?B?bFVjUEdpK0VoOWsrZG5XL2IzMHFrQVZjZHdUenFJTkNiaXBNMzdJTkE4SStu?=
 =?utf-8?B?ZGZDODh6QlFuQVhFM1BtT09JVDhPMzI3MVhSSTVBa3FZZmlRUmhtUHQvNE1w?=
 =?utf-8?B?ZjlDNURMcUwwK3dXV0U4L3RWZ3NzRVdXcGVKZzJhbXJpVHh6MmhoNGJ4Sm8x?=
 =?utf-8?B?ZGNadFdrZUoyODB6bWR0Si9lYjRuRzBYVTQ3bldlSFJnN2JLUlRwS0V3UUZP?=
 =?utf-8?B?RStKd3pYb0tUR1dqOFMvNTd0MTVKbXJsN1gvbjU1U0pEb1dWNTRXeXRQelpP?=
 =?utf-8?B?RkI1dWdaLzJPYXczUnZYK1lWbUVCQko5K3hFODFKdzhJZW1Db1VOY3V6cWxQ?=
 =?utf-8?B?WWtwUWtvSHF3TW44N2s2ekcvbE1nWlNmQk40QmFaRUJjd2JCSnhXemk1T3R4?=
 =?utf-8?B?YytOM1EzaDFjNm1YbW1WUlY1OGVJbGpYcElTK0M0TW9jVUh2NllzaUl3OUY5?=
 =?utf-8?B?ZEl6dWx3VmlScmF6c0h4UVA0cmJvVGZMWWx2ME56enJNcHMxcDZOa2JEc281?=
 =?utf-8?B?clhMTjFia1NUd244bUtVUE9pUTg3S3VJMnFEaXBoWElYK0lTL25SWjNrYUU1?=
 =?utf-8?B?WVdzckFFUlpkUEE2MjJSQm5OQXBFTlNkdGl3N24xVXlPamNxTlVzT2RqeDJ2?=
 =?utf-8?B?MENmbFlyQndld3ExMnZJNG03KzgvWlp0Q2I0cEJ6d3ROZkx3dFdHbGtONXUv?=
 =?utf-8?B?YktvQURSeWJXVVJ0R05XSkVWVS9leTFpL0pFdWc0cnVDQTBCQ2d1UEZoQjdD?=
 =?utf-8?B?alJRVDJ2K2Q1a1l6SWdoZ2Z2Y3JveEpqaWsweXpqb1VPeXh4THNBc1ZOcHd2?=
 =?utf-8?B?WGoyZEdZTTRqa0RCTnNkUDU5dFROT1krN1kycXQ4R2hQaWdTZ20xOEF6Y2ZP?=
 =?utf-8?B?OW8zdTRYaURWb0pxQUxjVzJWRWU5WEtibHRQNDYzbDBTY0F6WG5CczFPaEZq?=
 =?utf-8?B?cis0aFNVSUJLR1dlK1RncE9lODNaZS9oOHk3ZGxQR2s5MU45eEdFcm8zR0N5?=
 =?utf-8?B?TGZFRUs1V2FVenZMdURlR2VwM0N4NE5relpyYlkzdmZCRkk2NDVwOVMybDRn?=
 =?utf-8?B?TVA5R3pVQkE0Qi9ybXMySEszd29talN3V1NPME8vVXZ1a01HZUtFRnRseUsz?=
 =?utf-8?B?Rm5XNE15TlQ2YjEvL0JFblNOYWNMRWJhVzVkTWdIeDd0NllaOFJ4MXY5ZFhK?=
 =?utf-8?B?K2Zla1JWUVZzMld0ZHdUS0VqcXAyeUl1T2diUHRpV2RSUHcxWmNKNjlTUjEx?=
 =?utf-8?B?bDNhaUJTWnRhR3QvL2plQzFVeU1valJqcEtZSlVrZThIVXllbk9YZHRGeWJ4?=
 =?utf-8?B?Wjk5RE5rckREM3RUck8rOWpqTEhnWGxabXhvWkxGNHlQaEg0bXgxVVRqdG16?=
 =?utf-8?B?MW5VVTlYdE1mNEdMVlQrZzVlRk1xMm02OFFyMnhRZlZwWHZpK3kyaFNJS001?=
 =?utf-8?B?ZFR4VUdyTVgyWllheUQyVCtMbjNpc2FvWTRlemJKTFRZS0ZjandqZllVY2Vm?=
 =?utf-8?B?YmNkdDRwU3hWVHAxcTl0RFBmQnNPbmlDcEJyWFJ6VUcvMnFpMTFqVnNhMThB?=
 =?utf-8?B?RXJVeU1HZWczeXRkSGZQNkVnODZIR2V3QW43b0FEeTlXNW5KSXpUUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5565e53a-cabd-495e-37a0-08df366c2c17
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 09:57:13.5268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NglMg4qz8yFA990qJVD96vDLMoN+QhcaYS/YGKVG6hUPdg9Ag4EkZUGUkWaggLsrH7bjXwITM/f9xKkDTemr4BMGjZtVMuOv7KShVG0IfJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9950
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eddie,

On 10/29/26 9:13 PM, Eddie Kovsky wrote:
> The Engine API has been deprecated since the release of OpenSSL 3.0. End
> users have been advised to migrate to the new Provider interface.
> Several distributions have already removed support for engines, which is
> preventing U-Boot from being compiled in those environments.
> 
> This series adds support for the OpenSSL Provider API while continuing
> to support the existing Engine API on distros shipping older releases of
> OpenSSL. Build dependencies for local development and CI are also
> updated, while the final patch adds support for using hardware tokens
> with the Provider API.
> 
> The changes have been tested with the FIT signature verification vboot
> tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
> tests pass with both the legacy Engine library installed and with the
> Provider API.
> 

I'm NACKing this series quickly because we are having pressure from 
multiple projects and Tom would like to see this fixed ASAP, and this 
version here should not be merged. From a cursory look a lot of feedback 
was ignored, possibly because I did too many rounds of reviews and it 
got difficult to follow. I'll therefore spend time next week to collect 
the reviews I made on v4 and that sill apply and post them condensed on 
this thread.

Please, we just need to fix the build issue for 2027.01. We don't need 
providers in 2027.01, just the ability to build on OpenSSL 4 and on 
distros with OpenSSL3 with engines disabled, without breaking OpenSSL 
engine support for other cases. If you get a patch to fix this, please 
send it whenever you can, I'll still collect the reviews from v4 and 
post it here. If you're not interested in doing that, lemme know and 
I'll take over this part and you can always test the patch(es) if you 
want to.

Cheers,
Quentin
