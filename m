Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44F606A333
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=L3ib0DyT;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=CBlZ1rPz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 578916073B;
	Tue, 27 Oct 2026 18:08:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JCA8jkoHbzL; Tue, 27 Oct 2026 18:08:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D262606CB
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793124502;
	b=ex2JRL10Q/cJxGP8QQJGFhoWX1HbHV8bnw4/hdcgPC9EpHDMHviuCfDW7q6gFE0dW+rD
	 IDtmJMf7E/bjTSYUTF/h91BA8hvRwl+Oe9ykgajz9pJsHOURIWnUvDq2fIW79RSPGtp3o
	 uY9s9mbE73hpm7yiuYr18S7oFlfO2ewDb7XoL1iWtolQq9FGc4SaUo5XE6liBgeGauBdW
	 iei46sZiG/SWP73pf2EaYWNscxUtPvYthNIeeI1gYUAbVbQr4ojlxgVUMJOR5BxZtIEYf
	 PDwMGhYZGrFF0qnCYh9vRgPNJnXlSQy1E4EkrYSGSva1Tmoa6CPHK+fPpHOjWe2yp2w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793124502;
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
	bh=sY7Vu21daewrtbKBeYsUxvFFn7eGapOeHSNNuXpz36c=;
	b=pPu7vEahqbJCF2/Djusf+3NpSzefODcFSVvXnCD9LSJcUSXTaBv1kGmx+0UtSkN7KwZK
	 aJenxSa5u5pqaXn6JQmQAL6K63eXM7AuMYcQKNpZBHrTnLcdQ6JwEcuZYa1PfmNQE32q5
	 1tnBQ3tPcbuJZuD3oztUFxZJb59ug2Dj4jQ2dcJtVkesohIwKr++MfH+37HxCKMkQQ+gh
	 bdaNXkXkvyepPO5VF2oiIW05esOkEJBLRxdIHtaOW2U2Q80s6XUhbeekKgUpAJB7FpC+V
	 e15VfrrzrgjV7kjMJVxHKmoZCkh2llxHNJIdaUQ2ePaYKVTbZx76NVFIW7bjt6LHQ3w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793124502;
	bh=sY7Vu21daewrtbKBeYsUxvFFn7eGapOeHSNNuXpz36c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L3ib0DyTEmEIuFcOLkuE+tkmrdPzGECTweWBsU35AEgYF3pHYP1R7grbTtAmDkA2g
	 bJXVa4vtQZIN+X1pokXyIBhqenMBQMpuVO6dvw+5qoh8iqI1NCj6Xf4NHtAqLyXs1h
	 mRlT+uJcp2uA4tqTAJjBk/KJNOjLoPj0Wz/Ay8I3orHfkOqxKBqhRMQW4lo5AiqFuO
	 UarhbypUmfjXyZ1g54oNbsVW6SfTNrq00d+UWEDKydbcxX7urzmmAdnlB7YMPy3q38
	 w/K6wx8WbSPmjRKJkzyBAf4B0BCG64KCB7RyuxgxhW5qIaJVwbTIbA/bxd4TzFq8w3
	 DABPafkOpQFcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D262606CB;
	Tue, 27 Oct 2026 18:08:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C1BD4D1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E0A74073B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZVUhfEw0Uy4b for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 18:08:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3B9C440732
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793124500;
 b=HWHa7j5xmCBmKfX7VJQuaXCfwEFJ6WaujypLeXuTF209wkd7nOcM2j1IMViukDcGug3l
 BbQacaYItO7ETS2aHBufabGNh2/T0smP2HgnxVo905enaDyPjNccqOOBW8rRQIm8365XT
 l4rW1XVtXaNc5Xi7qIkpBrqrkzyeH6CT6QyhNWd2tJLjqOdsLbvNl3XSjIVA4W3ib5nuO
 G5zHoIdlaBRgWGNin9krBvS8X/KPp8OtTeNgRAJWVYGJgGTnWj6gP80CMtx8iXBgPu+K8
 5e6cIrs5WWufxQPXr5a/Y5ctEo8QMNXLnDdg3nGcDZvADvDFehCd2fifs5kpPYgkJ8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793124500;
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
 bh=sY7Vu21daewrtbKBeYsUxvFFn7eGapOeHSNNuXpz36c=;
 b=aGOohHztENIjuaIAzte5ev5FmuXe5R2Hhy121TzJM2s4JtiyzHdzwuN39AaGLwv50Yuj
 qIyUEyiF+n1fZvf6xMn/IDx2QdfjH0oedgvbthXaol+U9MO7ISqqplnS3zYWkvShJILI9
 KJ1bbnxixUbQxCc5BHMNvVEBx4Gfthi0OmMiOt226DDUZN0uVGQrLKl/2O+uggtgC6icg
 ydHF4wS7xRWj3mnF7eTFXNe78zhS/MtPgwcbPKCgsydMq2g2pTFPMLQNaYBmaBsCtLfoA
 v9V6RukjI+YC1xIdxZXs1DIXhIOKipEavOPt8sZZFv4F80Edy/10oi0efYHsSzjFIIQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CBlZ1rPz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=CBlZ1rPz
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B9C440732
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xR5DTD1UQbyIRNrRsBqOl9qaJYvUwkNkpS3xRp3TvqUIeXGju9fC//EM9tK38GzhdNZYYTwhD1GIQT2C8SxdtW1KRDsyVNzg/gOPPNs30Z0dQ+PLKVm8vp12ZJfzag/434gEznErGlcYCk+Xsq4sdAHV1fYB99uxMeAEHKBkphnFcWA2xsVKb6eBDF+RsAEIMYf91vZYRpHT+GW3rtlmp6ERq8MbWRD6ZUn9hevj8kas5dbllbtsKuXRRtcQxVriIjSTNVvp8x9yBVbBGuKW0sUiY0AA0AJmP93CG7ierBBxlvO9I55137dPvu02qX/jNCzb85esZAwejs4QQT9mhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sY7Vu21daewrtbKBeYsUxvFFn7eGapOeHSNNuXpz36c=;
 b=crGjRe00Sxau8Ag9fXvPXYAMTEHfHm2AId4fp3zhjQ5ohlVgAKQfPGB0NNQz21iFIpwbulDdeoaP3AAsLb0d6W+HaOdYek67KzlvhrjkxsuyjFjCmeggDI0IGtSmhQPw/j4v9L96L37HnWsuTR3EZjLwQrTcfCnhDQcuh35tREkz+WR+DuFnh8idlngGuMY/GTn6JwIdKspwAbSMWrsG7stA68BSfWP1FQRW8MytHu1Im0ogxPvLy0s+feNX9b9MxjrxyEDu1ET4qKJ+1UaAjSi5hXzN6nFg7SCmcuQfl8f0KYEdDeNRkHmabSHVxsSxcXgqU69e7Q8/Q5laShGFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sY7Vu21daewrtbKBeYsUxvFFn7eGapOeHSNNuXpz36c=;
 b=CBlZ1rPz+hbhPvvsyklT4OuNRZL15jkp0+FHMYDYiJugr0BgdvtXcLEnQZOJdhhFn6z2mdUAETjdZymu0AAoSIDH8TkqUeJ/mX6AxzgHf0VHGHnKc//WPqTw1gSPq7oS3leQbRlg3W6sYdugCj/L8eR0/sF5tyzPmVukg9c3/rw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB9109.eurprd04.prod.outlook.com (2603:10a6:20b:448::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 18:08:12 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 18:08:12 +0000
Message-ID: <16310a8c-a6ad-4aaf-84a5-30964a05fcc7@cherry.de>
Date: Tue, 27 Oct 2026 19:08:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] global: Update references to U-Boot git repo URL
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>
References: <20261018-master-main-v1-0-e07455d232bd@gmail.com>
 <20261018-master-main-v1-2-e07455d232bd@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261018-master-main-v1-2-e07455d232bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0038.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:356::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB9109:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4cb85b-13fb-4198-425c-08df34554359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261026121527099003|11063799006|4143699003|56012099006|261026135527099003|261021123027099003|261022115727099003|261021121427099003|261021133027099003|261022113327099003|261022105027099003|261022075727099003|261021130227099003|261021135927099003|10067099003|18002099003|22082099003|261026140227099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: +FmFJwVLJ3d1J37coswKcz7yeg2JLzph7r5942Z6UUJWTqw0+RWQ9sgidukXRgLczNurGPvq6U+ZDr2gsEHuopejwicDbA90w/mGiYk+3gR7D1RKPOETjVbscpVFUKzHz7EDcJ2byAj1W93EfcXxrVuxmCp04oOl5mS5lHActzJrjFQjhncgxD8NjtpSDIn+jigIu31ib3/s9B4TyKlWLGhkbrWF4YKVYxCOq77ZeYPo+svMU8IWQ+CBD+0B4wHIR9LXXR9wwMcFTUP58d9EMXfpB7Q2BqvIKmMleQ2R5akx0wFAB+Dtf7/YjdHBuVxhv2GqpSEPmLlG7659K7J7kjxGnvFQ5GG4A08wbK1XFzda3LT7o9x8WUHS5+0Cl//DXsoSse+LjTkJAZHvEjXgUNk0IO3vJePz3kq2YogSuHInDtHuXNO3ujeN2Yh98hEBDs1oH7WsVdQ38qyGKkHG4kLZ21Sr0cQAhHXL5M0N7maYom9oJT8Du01b0xF8NkTPOHXBnbMQqCn9dSZNqnua6aOPTXf/bbgIauqXWrW8Nt9I9FCOr2+b42ldvK+/RhHbWltdIZGf2xEKaY+qCDU8CZobNM4DHsfQ6fC9uB6ARA1m7SJLnPW1b4ALYwQKYwvo17P2AQ9J4i1JBe+lvwE5voPHCcbSpjdJvkWnIwV6Pk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261026121527099003)(11063799006)(4143699003)(56012099006)(261026135527099003)(261021123027099003)(261022115727099003)(261021121427099003)(261021133027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021130227099003)(261021135927099003)(10067099003)(18002099003)(22082099003)(261026140227099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBWUnFXU2F0bmNKUkMvUTIwcUl2N1M2bisxSDhOY0pKb2NyaW9GUUpheEQr?=
 =?utf-8?B?L3phRnlWSXhyeDl0dFZHakJYbE9UcDUzdzJIbnFCREdqbzVkcWYycUN6Ry93?=
 =?utf-8?B?dFBURDBBVForSG56bjl6SktSRTVCZGdZUXhzeVE3aXJEYklEWDBXeWJGNjhl?=
 =?utf-8?B?WTVCRzI3azZXSks3amg1WGVLblZVYUFFOTE2UTZsVlJwck5ZbVpVaitBazdx?=
 =?utf-8?B?dGtiaVA5Vk4wdWNlUFRSZWp5RXlSMkdaeHpJVUsrdDh6clhtdFJVS0t3ZVJP?=
 =?utf-8?B?NjZTcVg5TXdBK3c3bC9yNnNoeEk4aGFJblZ2elU3N1ZmTEFUY1dOdEFoRTBQ?=
 =?utf-8?B?Ly9mSDZaL1dEVlAvekMvUy9nTnRnMnJld0p0ZVBzOWFZT3NzTmpkNnV5RzJm?=
 =?utf-8?B?MUlPekNZV0pSRjFRN2lUM0dLYklsU2c2eTZSa25kcHJFWmRkUWtkbTJIS1hQ?=
 =?utf-8?B?eVZaMHIzbEMybnA0RkMyY1g2bE0rdmFmejdqbGpUdDhiY2dqZ25FQjM3akdn?=
 =?utf-8?B?ZW1Wcy9KRkpCckw4UmtyUTdjRWFNVzZkZnk3S2hzK0ZqTncxTkVQUVFZZmVZ?=
 =?utf-8?B?Qk9ZQXE2UVNaN1lYTTVLNmJpNE85RGhIajZyWW50L0FLbmNVQzNVQWRvU3hI?=
 =?utf-8?B?bmtENmIyUjF3bGVaVFZpZFhJSngxTWl1SWYyYjk1TWk4ZE4zRGlyam1YZTV2?=
 =?utf-8?B?UHNRejlCV0VhU2hjN3JQSlFuUnpVVEJRQUYySlRYWjZKZkNwOG9yVXpLSUs3?=
 =?utf-8?B?UXZWalVKUzlnSUFaUjNUOE1rc3pQQ1pGNzdaK2FIWUxUb3JzSHlvaWE4d2dM?=
 =?utf-8?B?REhTVXQ0ekFQTXlndTJHTTBXSXhQWTJ3ZTdCZ2FWeFFwWGlLNUtZNUpnaE5D?=
 =?utf-8?B?MjBBRUpJUURBbzM3RkMrb21qU2dtVGJBdStZMHNSMTJmekt1M2ZUeXhoRFkx?=
 =?utf-8?B?VGZmV0F4Z1R3UnhNY3FGb0xGUmRkYnYrNWNCT2Zub1JFSnZ2anBNaVgvZS9L?=
 =?utf-8?B?cnpQKzhKVUpWVVBZU040TlB3UlVQZVRuSnhNaDdqMzZPd01GbVAvU1ZpQTVS?=
 =?utf-8?B?N09SWXBLNkVRS243TDBlbmdpMktQaEFjM1dMdmNmamw1cmdLN0xTZTNJOEdN?=
 =?utf-8?B?T3ZncVhGV250eUNGWG1CMDA0VDdJSGJLa2FvTjU2bzdaN0J5NGR1cFlsZ3o3?=
 =?utf-8?B?ODB5QVUycGdNVGZnUCtlSHgrV2NETDZwVzVZSmZtS0lCRGxQaEliKzRXaUJC?=
 =?utf-8?B?YnhnL2JEQjVlZ0F1NUR3S2xYYXhMTFFOaUVxRUk1WENSeU5na2F4cGFZZEVG?=
 =?utf-8?B?TzVVNlJRUzhqS0ZFWk9PcWozUTdUbjB0aHpPQ2RvbitZeGxEdkRJbmJueGU1?=
 =?utf-8?B?RW9oUlltOFQ5SXlBQUtZeHlYUDl0TUttZGVPWXB6OTcyNS9qV2cxVmZpSEFG?=
 =?utf-8?B?TXN4enlhRU4wVExYRGRxaWxLRUVHYUhTUysvalJiSm9yYW5nUVZGWXR1UUE4?=
 =?utf-8?B?a0Y3ejM5VWlFZHN2Y2MyMTV1UGVsb0Uwa1pTdTR4K0RRSVpQRHVZZ0ZWSmxx?=
 =?utf-8?B?RlQ4U3BSbjdwTXdoTTM1bjR6K08vTnZNamljVDFpbEJhTk1VdjBwZXFiZHIz?=
 =?utf-8?B?OHIwSUEreGYzWVNkVjl1bUVKcjNNczdXOXVMZ1hOc0cvTXVBaThiUTMwN0s1?=
 =?utf-8?B?OXp2SjhTOTl5SzZFcVNRZ2FEM3VZNTIxc2ZrVE1YTzRROGJ4VWkrVmRqdlRP?=
 =?utf-8?B?eVl0NmV0VWowMWJHY3h1aTJHZ3Fld2FhMHExcEYweU5Cc3B3MWxFNzU3OFg0?=
 =?utf-8?B?alFtTWxTTld0ck9tSkJkRGhSaVpIYU1XNzhhaThTY3lkR09kZlB5bkUzNjNO?=
 =?utf-8?B?NlpobjM2Y2hrUjV4K1RLM1NLS3FIRm5BOUZIWXZBNlpOQW10UzR1eUwyNVVX?=
 =?utf-8?B?cERsL3FsSVZHR1VZR0Y2UU5XcExCRjVGa20rYkFWVW51TldyYlI2RDlxSjBp?=
 =?utf-8?B?WGNwaDN0Mnc4bUh6VmNyRDB1UWg5UE5mcUN1ZStwOTRTVVRjZCtiRklXQVZK?=
 =?utf-8?B?MTRYZEZmMmpuYjkxYWhXRnhJRzZzWDcyaG5TT25Ibmg4QTVtaHJUL0Y2UDJ1?=
 =?utf-8?B?a2xZcFJtQ0F2ajJTWXEyaUVIWWwxMVMxd0FGajA3Y2RsaWNQek1DNFMyMmY1?=
 =?utf-8?B?eHo2YSsrSDBCRGZ3RXJmK1c5UXJpcFBKbUIwL1lHQThhd3VXOGZaajNzY1RL?=
 =?utf-8?B?ZUI1MlY2dE9QbmsyTXIxS1U4RE81bWhubGVJZ1J2UThyM0Q4YUF3OGRldzZq?=
 =?utf-8?B?QUhXcWFYRkRoS0FCNEllNTQwUFRMREVoL2t1VGs4eWw3MURzZ3Fodz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4cb85b-13fb-4198-425c-08df34554359
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 18:08:11.9188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l0/lId0ghsdAXtDKvFe+JgZbVPx4InW53L/cR0B3MeP+0N5aw/9THUk2zhgn0Jp1hRRpaxrNSWb3gbimngt+IaRKGB4I5w/ONC6agkromw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9109
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 10/18/26 5:59 PM, Massimo Pegorer wrote:
> U-Boot git repository URL is git.u-boot-project.org. Update some
> references in the documentation still pointing to the previous URL
> at DENX.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
