Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA2606E20F
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=B+rrxqet;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=hV2ImJaQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 12C1B40DC3;
	Fri, 13 Nov 2026 17:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gFyaKRp5N3QD; Fri, 13 Nov 2026 17:26:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57CFB40DA7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794590792;
	b=qfHGTCj4ftNpEFO3NizCR/LSXYAwqbGSuPZ39zNewXuPW6/wlW4sy0HKsG600EIN+U0y
	 4pQqYVtFIYDssJfkmeTN2jjlJjVCJ21uTQW+bBhlS6P84MubuSqf+tgu0sG3TOA8zTA1L
	 c043J6KnB2pGjawL80LU508yF33YBRXizt5Mse4pDlbNYNkSUYz66Z1eOlzeAk8l9iQJ3
	 FbIF9km3Fc7o2K79ZNErhXbuCk1YMOqObYlJcYPlC3kArBPIsfBkWZ6rTa/d8Bei5+8t0
	 BeUTMkX05gzaeVOfbe4NhY6IHs5bdSChJay3Mz6iBk696vyx/TPea5fK5jNdb8Y8Vdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794590792;
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
	bh=E/OmQRaeVeFXVGKhNnkHUkcut3f64M1HC8OAVlY1W2U=;
	b=hmz9xW0bBZUY0H2bOYTWKYcf/i+yunpkMZTWzR8qTGJwcmmd9VxWn+W/iKDVoKmYCNof
	 /adlbuyLxCN99CHVoFWP8OvYR4UX57dnAAd0amN+bca1UHtZ0TfDxs6axvtFm4HKuS7y7
	 zCDVkf78JUs3laLG+nShe+YJrbh8h6HB1oh62NRDdXMpX2W+nd6b9UkTkttDtDiyZ//2T
	 kojOAVVJUbkzmwZ3Xm9Gk02IHHmLrrMKnUsAonF6DwO5Q6uhcANZ+TdizL9LKHmIt7d/a
	 i+MUZKJ6S3VPJ2qL+el9wRFUlUSnZsoIj5EiMjDvvTbFjcXONzzbMvl8zD/M4IkFFaQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794590792;
	bh=E/OmQRaeVeFXVGKhNnkHUkcut3f64M1HC8OAVlY1W2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B+rrxqetkK+iwTlXzggENhQ6mDt3ybo059m/pHnc7TrupIMVnWnrHFa163mfeQ8P9
	 S3/6mSFwsG6Q/c3ey6WjJZUAq9i8FR0uHGUnbmXWxcsFGApLdL1FRMzwuswu8NcoKr
	 /3qOeuXsMJuL/ipiK6YDmHRLrCsToP4dVdM05CHaANvWMo60YK9KOJaUMYe6HH2Tib
	 TQ1ed4U5Ah611NM6hCAqxm1dR/c97eb1PMeNpHurfKSTbDTmsIx5tqI/ucsSWz+86U
	 4IPnYe8Bn509hFP9edELHDBHzY4hGlkUIMLUBs5ABzDpsJWVOQJ+o89L0518LdRQAS
	 uc44M4IpLShng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57CFB40DA7;
	Fri, 13 Nov 2026 17:26:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 620702E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:26:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 481806066D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:26:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xP-Lo8DfZvzf for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:26:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 84D5360653
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=hV2ImJaQ
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84D5360653
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/OmQRaeVeFXVGKhNnkHUkcut3f64M1HC8OAVlY1W2U=;
 b=hV2ImJaQDGTAUk/DVJtKVWgITwzI8ZRj14cfWLMuc76JoNweKGgaz+09tmawxPRWMbWjY/reztB1Iiqmml0kpnEhnwEQORDJkDP6n7UwkeiTyz9vycoACZVf9ZvGX7PdW3qMXr572ISpG1oXL2caN9pMWcGGjaMUWeWJf7u9xrg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by MMZPR04MB461369.eurprd04.prod.outlook.com (2603:10a6:190:53::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 17:26:27 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 17:26:27 +0000
Message-ID: <11c4c16f-6889-4754-b5e0-272f907b6be4@cherry.de>
Date: Fri, 13 Nov 2026 18:26:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] clk: rockchip: rk3588: Align BxPLL entries in PLL
 table
To: Jonas Karlman <jonas@kwiboo.se>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261111231251.160051-1-jonas@kwiboo.se>
 <20261111231251.160051-8-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261111231251.160051-8-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0007.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::12) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|MMZPR04MB461369:EE_
X-MS-Office365-Filtering-Correlation-Id: 601a2a32-6c80-4a8e-bdfa-08df41ab3f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 2efyUGdODnvy/PCzrNgt7aAeqSzcLp5SxLv83cD+hdqnp7Bdcn7tvKcPOy0LYXSygfLnzpJ9LBIAdm5QaznSuemkVAD2m7ZAd0sreV+VssMjIIMIGB74evNu+G7EWJndvC17XaG76qPRigfvKZo4hwpzQMV2Xt/h4uPZJNsCW4mBR6E+3jdPA8KPYLWfvdYLLi7U17yRibFYVKWXjvd3yN/lh1gMCtIBAmgMl63MU57f0DhnovdnxMot96aIHFkLMCQ/0oT9JS06cPrzBKAiYsZbkcoFwJjm/Vliv2+aYH7eFZfV799yepUV/QXUCUo6TQntuGddPiZ8sLGqgcQ4Pee++fEnSWfT2XjB8vO3pRGYMfGXK52pbwp8rpjK8DTqHqdNnEekvUojklAUqrT9+0HTL9MmzCVpQwW3lr+iNJ2MCjYVeL4yyczFkMlnOKYrNuFa1pCEyqoL5LY7bNJUnOVQKTBmONI+zCDx70UmbmRHcVnjKoxdXUoLyEhDqTo1nahiKeUgcqiznwfSeC1cvuaYfibChdUlnMSRAbQr1LhabMtMw0S/5ERLfh5bdH6AXvuI7ZfsogVe+OdSCS4o56q1nXZOwPGE9cCQsdpHgAn1k6L29dxuJBKaYzEwN0vA3rwXwIJuPwFQeqoEdJnEyqt4fjzYw85Vrl9OAgY8Fvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTJRY1NFQ0hZN0pFTlc2T0dnU0tqZDd6MUcvS29xWEtqVTByc3R5YVlaeHBP?=
 =?utf-8?B?Q0FHK0oyK0Jhdm9iZXBLYXMyd0J3MFF5NHk1d3pVVGtySUoxd2laSXZQaHJ6?=
 =?utf-8?B?a3hyNGdERGpPUXRjV05DdkxkVXllcXBtQzhOT0pmK0llNnhEZk1QMXJpazl6?=
 =?utf-8?B?NTJKM3Fad3hKM3JITDJCL3pBMVEwMVF5aFptZUU0WDEwZHRqUmFIQU1lWkRZ?=
 =?utf-8?B?RVh2eE8yUFl6QzJqU2VsZE95Z01GODN4Z0F5eGJ0aDI5SStiZWFBRGZBNVph?=
 =?utf-8?B?OTErRG00OThmeXVFbkxxS3FCblJsWVJtbG5aS2xUc3lUTkYwL2NETmI3NHZm?=
 =?utf-8?B?NDJyVzFzRTVnTW5LU1gyWS9rREx4bTVaRXJEWWdjeHlWaGRJamdITTJ0RzI4?=
 =?utf-8?B?NitmWVFJQ3AzWFZ4Z25YNVllMm5NVnArczBodDVwR1E1RmxPZk91cVBzU2lh?=
 =?utf-8?B?M3A4RkhjejA0K1JXY1ZBdlczZ29MWTNjZW5JVFUzS2J3bllFZHRDRGNoWVFQ?=
 =?utf-8?B?UUlCOG5xQ0tSeW1rbmpRMTNoMEtHbDlDQ2hUaTVCKzVYTVV5czk2QWtQZnRo?=
 =?utf-8?B?Nkh0cFZmOFp1L0p5RWJuTWJrTEllTW5VcG9HcENyWkp6NDdqYUR4N0cxcGo3?=
 =?utf-8?B?ZndyZUNHNkRKMzBEQUJ2bEliZENEUklVRjN6TGNZNnpzNnU3VzBBNWR5bnJt?=
 =?utf-8?B?V1lRZ0h0K1laY1podGxUWmR0Rm8wb09KeEszTjJXYkswK0dWNmRzekwybVNJ?=
 =?utf-8?B?NEk0ZElFb0Z4eVI1RlVzcXJqSmRUWW9nTlM4UFdTRWJMWkIyeCt5WW43dGg1?=
 =?utf-8?B?NTN2L3VwR0UrTmpRWmdFMllvRUZsM0tseWxTUGhJNkhicUVzUHo1OURETWpM?=
 =?utf-8?B?TklDaWs2TWduek4wcVlvN1hmSm9wWmpPUGhUVyt2YTlOMncyRXNYUTBNQTgv?=
 =?utf-8?B?dFNLQ1VyRmVVdXdieGRITGJuWjNYWEJsOWxzNVNuMXpkWUlWQjRMb3g2N0Z3?=
 =?utf-8?B?NElKSkN0V3p6Ym1leDh4Yy9EM0FnN09UaHVZUTRMWDZVZS9aMWw2TDRORmlM?=
 =?utf-8?B?M2FMY1VzdHN0THYzRUhZS0RFdGRHejV1RWRVRzBoa3JjZ29DakdRbXZWejZj?=
 =?utf-8?B?UHNNRUdBZUswU1lBa29pZDVrNmZQRTV4cnhDOHBhTFZIZ1l3VXpZb2xqOSt0?=
 =?utf-8?B?V2NFK1F1ZzZkTXpCS2tSZzZsRTRWZWRMc1ZNOHdBa0NHTHNMMXNKMVROaGdq?=
 =?utf-8?B?WUt3d2QrMGhXenRSNUF2WGlvRERkLzFmZllrZlMvdUVoV2R0cGZ3elNZUXNo?=
 =?utf-8?B?Q0dkOElRU0tTSHRyVWhsQmNERjlOQXZkVDVpN1ZaUC9lZmRFTENuOFBLZnho?=
 =?utf-8?B?TXc3MTRBRXZJMzh5dDRna0xsd0pPSG0zZ21hYjZoWkdpUWtXUUJkT3lJUCs4?=
 =?utf-8?B?cTJLc2VmLzk4R25OY3ZXNzFwRTdINnNCRDlHOER2cXk4VWs4UzhSOHh2UVBq?=
 =?utf-8?B?S3YzVU9ydi9IYWM1SzlPZTJ5clVYcEh6c2FTSFlleTJUT2xyeTU3SDAyeWhU?=
 =?utf-8?B?TWZRck93Vlp6QVdCQms2anVFSktMaE5WdFFJUlJ6UmwxZnJzeGI2NzhNSEtP?=
 =?utf-8?B?UzdoYmVnVGJERXRRcWNLemI1VHhUOTVqcm9aQnprRzNNUWpoMTY0bkJWRFpJ?=
 =?utf-8?B?WC9hbmdFNW83N1R2NTU5NnRaQitIWUN6c0dpT2J0czlCOWN6MjB4RjJ1VUM5?=
 =?utf-8?B?dWd3NGNZVGMrNmgzbm5hRkVlY0E1N0VoKzY0WXdGRVdFRmw0UjNDbnczNmVM?=
 =?utf-8?B?M0JhdGxMd08rYUhxMnlROWVEdVl5VnlsQzllckptVzNCbE14NWkxSlNqWDBt?=
 =?utf-8?B?aU9OWlQyRVBWYXlmZ1B5MDRJd1ZIM1pWL2VQQnBpMXBCNGxRZHY5b1RTYXBJ?=
 =?utf-8?B?SU5iR1BCYWdUWjQ4bXozd3U3aDVhT0Z5Q1Z1cSttRDVHb2k5dmcwV1ptQ3Ev?=
 =?utf-8?B?enJUdUFvK1g4U29WaEhYdUU3eXlna05PeDNmbDRBbnFHSFlodjh5dkc3Q1NT?=
 =?utf-8?B?Q0h0L0p1Nm02aEhlNko2eEpTWW9adDAxZ05yWG1mWW9ESDNURk4xMzU3N1g3?=
 =?utf-8?B?WXlycFVDN080RUJTaUE2SjlQbldVanNOYUMxNGhyaitzK0xITU0wQ3NwWnJx?=
 =?utf-8?B?Y3UxbDV2WmhWTFlBNnQyM0JRUjVXd2lrRVFta2YwTWVYRmQwdzNaZWxHeDU2?=
 =?utf-8?B?a3FBQm1TMUdwczdhdFVPTHhVVDA0OEpiZWV5clhTRDBXZENIU0lQTytzd0kw?=
 =?utf-8?B?bUZnbXhEUGJKOHBKdzBqblp3UXZQYVpBeW44WGIyZFRQV2tUN25sdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 601a2a32-6c80-4a8e-bdfa-08df41ab3f65
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 17:26:27.1711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qk2xRYwKasDFwBmMaHCS2efGqlaHCAjg/uCitL+qx4pnT49eRhVgYY6ECImfCSO4ZfRwnE3MiqCuDG7GbhJmSjQ3ekw2Ax3IvR5XAI967Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB461369
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 11/12/26 12:12 AM, Jonas Karlman wrote:
> Keep the B0PLL and B1PLL entries formatted in a similar way matching the
> other PLL entries for consistency.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
