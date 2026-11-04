Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA496606A682
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UVqWqTkT;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=NaTXTCDC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A822280C6C;
	Wed,  4 Nov 2026 17:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9mPCfmu-AtuN; Wed,  4 Nov 2026 17:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D5CED80C5C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793814677;
	b=hm5WGm907bxQoAIMzdmIFPY6ocAnoBUudKuCR27VZwG6IvhP4qskmxkgCL4RcohfVLMa
	 P+Sq9SuNrwCq6t1a6i1MyTccUiljDK60LTVPj7KiFS2o+aDZ+/gdTyf6RSpNjUxL0cZvf
	 Li4tdvhLHwyqwMzCM4/jYoOf3Uz616mrr1QNHo2lHoQcja5aUl/HfHepXQjG3qpE2Su8R
	 ezQ6UXYAhqCz4QjbvyvfAyjpRZaBK9Tuv6zsTglZQ7rmv+dGZb9UW0B57k5Ah1/OaM7Ax
	 sAnprOogBT2Hir8JRsfm8z2SEhDsCbnVDuU7XsBbHsJ4zNPZkjFe9DB8Cvbj60PbtCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793814677;
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
	bh=67CZCsB6NQ2VsjsJb8LogHZbetovxZxnASrXAatDJ7U=;
	b=LmytwsS1ahiyJeqWvAbqEcXmn3x/gjFWfKGBRrJkoyz4B9vcXOgKlShq28aivGxy/+nc
	 fNWrpVuRsNFX0NrrcNNZfv1xrzAUC4zN4Ig7hK2aIPHEp6m1TdXiTZgnadSIbSpxU1VOP
	 lA2spujqGGoJ1GJse+HVSY129VjoeRIjnHhnbXvUytT8FZI6Q4EmFIywvzWIco5whlLbV
	 lHhs2MRLSCJVcr/Y6vPa2/ltmjbg5B2CT1Ng8IPmlHhCrrBQjhcso3XwQoUaD1+USG4z0
	 6i2fRIBoGNKcbuGvoAWfIcIj7dm60EEozsHM39op/Q2ZIcDie7udQRmLYd57NrxQ/fg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793814677;
	bh=67CZCsB6NQ2VsjsJb8LogHZbetovxZxnASrXAatDJ7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UVqWqTkT6zPZgaRHVCxFzQWsZuyT64iOw7Evs3op0yGOE5SgD7sdEZTFMgit6eESA
	 NCwEhgUkT6tW/ldZxgR6FlkcG4XiXodfH/+mtZ6LvFGcZlLsQTfiEqJTCF1rMi9cpW
	 NzBqFp1gA0HFHv4b63dtDiZJR6+QCTrg6MtERzxF532jjLBmuP0OzAhRzPpMLuXzFr
	 bCWaA2o22SqQ/GXLNCEjL1rHuHoAJ3egxx7mqxEWNnWCo7Tvnb/AVuLxfC22hdDMCZ
	 SMbjUzSt8xYBMErbo2SFn39EJVp3W5CyuCgO079vtatpSqCJ1mtexL9KmsWe7s1xqQ
	 QfUzcKT9QZ7Tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5CED80C5C;
	Wed,  4 Nov 2026 17:51:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AFA5177B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40FBA60697
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6FcKodu7tX4n for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 17:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0BED605F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=NaTXTCDC
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0BED605F7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67CZCsB6NQ2VsjsJb8LogHZbetovxZxnASrXAatDJ7U=;
 b=NaTXTCDC+J6fBLUeLpzCg4Gmo2Vni9At3tRBq5gd7SEfQo9fO0v1Z/50mzcDwUJBNbuvEdfGFf7C6onAAobiJ5h7v2LUUZp55NJPGm+NkILi//7g042uKJKmdk5h1lvNg9pDKRljjLZTztVilg1X7AhI3y+8c7Tdh3pWdAFhH2o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV2PR04MB11740.eurprd04.prod.outlook.com (2603:10a6:150:2cd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 17:51:01 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 17:51:01 +0000
Message-ID: <ca7b3725-cabd-4064-95dd-46c3eaa325f0@cherry.de>
Date: Wed, 4 Nov 2026 18:51:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/30] usb: dwc3: part 2, make the resynced code work
To: Anders Roxell <anders.roxell@linaro.org>
Cc: u-boot@lists.u-boot-project.org, marek.vasut@mailbox.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 s-vadapalli@ti.com
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
 <b464c545-c1f4-461f-8f17-48854bd70825@cherry.de> <aunlk5FaVe_jcpSr@monster>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aunlk5FaVe_jcpSr@monster>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV2PR04MB11740:EE_
X-MS-Office365-Filtering-Correlation-Id: 199d79eb-e4f0-43e6-2b9c-08df3a9c3093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|4143699003|11063799006|56012099006|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: I74u6QDfsgImCZuNLVgNzAFCx8RCEntgvFC4F3CseVvcWiCrzX3hZ0AM4grvebtkRC+hMSM7Fv/CYs4A+b2FiJszTXAlb/rGlrdMv7iZIMl1b2n2AAubXgdvI9CmfPxPcoyhFEi7ZKZklAlkBZPc02DHIABiGqgs4lrXH1nUFuzM+7cTofO/JpC3cc30dXEfTOf1GvafgaqplXsx8TqhtbFITb+ADnxT28iwtHJE0ow98VGIA0f4ATN/w6W7JN3ozPx+rypnV93QWwe0NGiuBXOS2sVp8/VtI9xGP6sq+jDl4RmiewaCgcw2r2kydYXG/wKqIU0fwZatCDf9Z2KU9EtNTsuegNW7lxTOdJnNAsqFgn1eOH9GY2AYCD+pFHfUjTN7188oza/VTO7kHYRuf8Wm0TwR+8e30qgpMO6dX/jnr17KGhX41tbRQWrYw1WlrYhhnmEXXTzOdWDPx+sPg59VHK9mGOMXkVBqQx6gNcncvhBaLISoey9BHs3hUMT3q1wlzihTsWsaqPo/peMRude3wIAOESZqsjYLTwvMTAsqFlyhO20aM5dqpvfrvw4UFqo7ZennbRXUG6XBgb3ccZN+1yJkuR1Ly/9o9dfgFusc5KSs6BtGEJHO7QBxOeOhMXadrk49DHlSngQReJMimc2iSba3LZny7O5O4aLDXx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekw5QlNDNi9aQURTVk1hVXQ5UjhCdjBJamk1cU1qVlh6TUdFZllSa2xYYk85?=
 =?utf-8?B?VnZYYm13dVFxbVZiUHoxQUdUQlJ4NFBjQ0RuV25UR09tSmhLMGM4dkV2VkFH?=
 =?utf-8?B?N2FFc2NFb1puTENZdVAzNmNjQkU1RFZYN2JGYktIY0xxQWlXWjZTdnBPM2Ra?=
 =?utf-8?B?bm9MVkkwcTZrUzUxc0ExSHB5dXdraklPTEFONStPSUJkdy9UTjBVZElQWkxL?=
 =?utf-8?B?aWFpTTYzbC9PK1dZN0p0U3hUVVN4Nk5sT2lkUDRUdUtQbXFDOFhCZjcwTHZY?=
 =?utf-8?B?OTVjWU5rZlhtVEZoVDBPNjRZeTUxQXdGczg2OEJRbWNmWlBKVHhNeHpqRXVX?=
 =?utf-8?B?MUNYOVkwQytSZFRpdzhPMjNGbTlZN2VzNjk3Vms0SmVOUmw2cFpZNmh4UTBU?=
 =?utf-8?B?aDZHcWhyTG92bDVuRFM4dU42aXJTZDlkdHcwN1d0aVFDL1pXK0dZU3J2bnVw?=
 =?utf-8?B?bjN4QnFHcFdWODdFa3lIWTZ3RlRFMnBoOEljTVppUEFrZkc0b2FEd3pEL01m?=
 =?utf-8?B?S3oxRjhGUi80ZFJWYWhnSnpxai92NGhXcGxNZzFZMitnQ0ZBUHgyS21XeEI0?=
 =?utf-8?B?ZTJvRnk5bVNjQnNBMVNEZy9RQWkyS08xcUhXOEE2VGRMOFNXR0JMOXlkdm0z?=
 =?utf-8?B?NUdwMFBMZG5oZW5jTUZ0WVRQOHo2UHhaUjFPUThrSUZyZUh2QTc0RG8wN3Vs?=
 =?utf-8?B?TEdTNFEyaUgxejJjQjBtNm43d1BPVmJEemJKMXJVbmhUMkVUbUlVcW1XVDB3?=
 =?utf-8?B?Y01DdlNaNFppN05leUlCbEovOERZRi9sZm50Mloycm9XYVJ6Zng0dldpSkU0?=
 =?utf-8?B?d0p6Zi9HT3ZxcmduZkgxbG5wUXpuejMvbmczeVJOMVBGMVQ2TWQ1ZjdSRkJ6?=
 =?utf-8?B?MkVQY0h4bWt0S3B1Vml6UjJ2S0V4eXhmeUNmWWJlQnBLbU9yM2pNTDlWOWVk?=
 =?utf-8?B?TmxJNVBXRVlhL2RJMnNFcjRYeWN0YVZLOWZsOVJ0ckcwSnJPL290cm5xZEpY?=
 =?utf-8?B?SEZUcWg4elhrM1plK29vcjN3U2wrc0loeHk0dW40cHJjWlRnemduNmF1M0Z5?=
 =?utf-8?B?WVpGYm5nWVJYaGh5Q3ZSMVcxWm5qRCs4UHdSc2RLVVljN28vTlIvbm94Rkw2?=
 =?utf-8?B?aTdsSElYTWJsSVJ1OFF4UzQvR01ERDdtUTZPMExURThXVmtQcUhWbFlDMkZs?=
 =?utf-8?B?M2pFZ0JoZVFDOFZXME85ZGJIN2doclhqOS9HMjBLOFRLTmVmQzQ3M081TCs1?=
 =?utf-8?B?QjQvbDBMbWpLRHlQQ2tKSk5TNmVRU2psOGMzR2tQQWJuM2dtc1VvMmgyazVV?=
 =?utf-8?B?bkdIb3FOR2VBbXZlcm9rQXJxUUs5SEdIV3l5WWRncnMwckx4MzVBckJWOHd3?=
 =?utf-8?B?Mk0vVDlnK1FoQkMzN0RFTjdoQnV0M3U1dXBXbFRBU09TSXZDNlB1STZhdi83?=
 =?utf-8?B?alk0WGI0MzFxRDZkRkVXb0ZVVHJIT0Vocmgxbk4wUkVjckJqa2ZLcFFkSVBN?=
 =?utf-8?B?amJ4cDQyV040cGZZaGpTendnY0JNeGIvRTBqc0RQeWZack0wdFBQVFJtUW1K?=
 =?utf-8?B?akhaL3pja3FRRTJJWUtqL0xpa1JTaWQyeE82WXM0QmY3dEc4YW5ETzBhZHpJ?=
 =?utf-8?B?NW44MVc3dEE2NzFWYUVLaFc0WE1TdFhrSGtLWnp1WEgwblRyTTZNc04xRyta?=
 =?utf-8?B?ZzJucVZOQVpsd0dnbjlGa2NFZXp1c21HdmpHdEtJbzBiV1FMTW9XOHg3UHE0?=
 =?utf-8?B?Nm5hMVJEbDRRNlFQZ1NPV3o2OHBFRlBjd1NWbGFvaDA3NWt3TFo2TnZXNmZ6?=
 =?utf-8?B?N3MreW53ams5ZWdTVElrYS83VFBJZzVKaDdvVWRKbEk1YnhpaGJ6RHlYZU1a?=
 =?utf-8?B?bTRjRm5EZU1kd1JEdUZBanhwY2RUNU1ndFpYN3ZJNHBMRk1YRmxSTnF5eUtv?=
 =?utf-8?B?NTQ0SGtwMFplZ3d0WGd3RTAwSExneVVxazZtVzh0OTJpRkZ2dGl1OE0xTExY?=
 =?utf-8?B?YUY5bElKVFZZUzNKTnEzVmo2ckdPREt3UE53MUFxMkJValVBU2hBMTUxWG9B?=
 =?utf-8?B?M1dLSmd5TDZIQW5hajQrK0lrM3k4blpud1JjU210RFFYcnMvckxxK2w5QzRn?=
 =?utf-8?B?Z3pnK1V1cE0rbk5ZZGRGZi83RnJWUFJ3VW1oVXJNR1Z5dzA1dDVoUlRET1pU?=
 =?utf-8?B?b3MwZTVIMXhrTDAxclVnRUY5UVBnZGhzUUtVV0FFM1BHNU9HNHZnZlRRTkpl?=
 =?utf-8?B?WnJPNVkzQkdoOFhvc3BFNUFDZG5Gem91Ujdwdm9PeFNRS2JuNUF5RUFNZ2ZT?=
 =?utf-8?B?U2pxa1lMdmpsalhWNjluRkxzZ0Q1Z2RlN0RmekRVSFhPNlVBeTNHQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 199d79eb-e4f0-43e6-2b9c-08df3a9c3093
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:51:01.5555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8ENtkEnboGxjp9UiFhsWuL03w1StKTmYyQlp8Xk4Efvcz1DhdXJFIG0IRZxCTBqna1t4QujVqUluLb0q5mWNu4LNC/9HdbNkDejdRf+zqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11740
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Anders,

On 11/3/26 2:45 PM, Anders Roxell wrote:
> On 2026-10-30 15:28, Quentin Schulz wrote:
>> Hi Andrew,
>>
>> On 10/28/26 3:15 PM, Anders Roxell wrote:
>>> Hi,
>>>
> 
> [ ... ]
> 
>> - Q7 USB P0 (lower) with Sandisk Extreme Pro USB stick,
>> - Q7 USB P2 (upper) with Sandisk Extreme Pro USB stick,
>>
>> RK3399 Puma behaves the same in main and with your series applied.
>> RK3588 Tiger has some regressions.
>>
>> Q7 USB P2 (upper) doesn't detect the Sandisk Ultra Flair USB stick anymore.
>> It does on main branch, but on the USB2 controller only.
>>
>> Q7 USB P0 (lower) has issues handling the Kingston USB stick. 1st try:
> 
> Hi Quentin,
> 
> Thanks for testing both boards.
> 
> About the OTG port: no need to spend more time on it.
> 
> v10 had two bugs in the dwc3 core. It never read the core version, so
> every version check was false. It also cleared the GSBUSCFG0 REQINFO
> bits on every controller, and main does not touch them. v11 fixes both.
> My best guess for the Kingston write on P0 is REQINFO, but I have no
> Tiger to test it on.
> 
> Did the other sticks pass with v10? That is the Ultra Flair and the
> Extreme Pro on P0, and the Kingston and the Extreme Pro on P2. I want
> to know if it is only one stick on each port.
> 

- Q7 USB P0 (lower) with Sandisk Ultra Flair USB stick,
- Q7 USB P2 (upper) with Sandisk Ultra Flair USB stick,
- Q7 USB P0 (lower) with Kingston USB stick,
- Q7 USB P2 (upper) with Kingston USB stick,
- Q7 USB P0 (lower) with Sandisk Extreme Pro USB stick,
- Q7 USB P2 (upper) with Sandisk Extreme Pro USB stick,

was what I tested, on both v10 and main, on both RK3588 Tiger and RK3399 
Puma. I only reported the ones that didn't work, so yes to your question 
above.

> Can you run the same tests with v11? It is on [1], on top of main
> ab4dc5aacf95.
> 

With v11 checked out, I only tested the scenarios with regressions I 
reported in the previous mail, that is only, on RK3588 Tiger only, with 
Kingston USB stick on P0 and Ultra Flair on P2.

2/2 tries were successful (regression gone) for the Kingston stick on P0.

5/5 tries for Ultra Flair on P2 (detected on the USB2 controller same as 
on main) were successful (regression gone). I got one try for Ultra 
Flair on P2 that reported the stick on the USB3 controller, funnily 
enough, the only try when I got a "cannot reset port 1!?". All other 
times, the USB stick was attached to the USB2 controller (like on main).

I would like to run all test scenarios again and see if v11 introduces 
other regressions compared to v10, but this takes me about 2h 
uninterrupted and I'm not sure I will have time tomorrow or Friday as 
there are other fires to put out (still have to review the OpenSSL 
provider thing again, and I'm now finally impacted by it myself as I 
updated to Fedora 45 with OpenSSL 4 this morning).

Please shout at me if you don't get a test report before next Monday 2pm 
UTC.

Cheers,
Quentin
