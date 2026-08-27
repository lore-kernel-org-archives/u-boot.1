Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D854C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 13:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 165F4808A8;
	Thu, 27 Aug 2026 13:35:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNny-dMjK53a; Thu, 27 Aug 2026 13:35:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787837715;
	bh=OdJFmGh7Am/7Jv0z/iBAHxVmnUBAGioeL/O6fyFvAnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lsajlco2w9nl2Ma20+urBIHAtg3npq6g3Fj02ZDapOSjcCSimEiKKZYemSABwTPI+
	 TIpJFJ1dwNquw+Uork+7h8EBVCbzdZzJqzcZl4v5O/C+rrmGhFdhB50MrL4esy9pre
	 H338kqvEUaksCRZvPoywQP8YVSWaXXLdDsFvTqXEyKPbCqmfsRlZJj46oNhTBtKRIV
	 hN13i0ZHStXn8h1JrFsiluTaBDun9tyiWAy82SM0xMQGO+X/IAwDxIH8MPdDvCOECr
	 Pto0YmkNMtodvUBiF7oj78PNlqeYg/z0XF77rIxBEq1R4iCaGpyE7vlv0do1Z27rQj
	 X3YgNu9URs9NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 418CE80B63;
	Thu, 27 Aug 2026 13:35:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF7CA3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E118880B63
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bAmDBBJvW--4 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 13:35:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=Y9QsQjlZ
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C15C808A8
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:35:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0d3quk7aZrBB7wIhR8hU18+9XVxHaTtdM4/eResEpm+FH2Qc+oBGnrjN1tdeXHsLp4bK0ixBpohEZqbu3dnlXrc6E4VLgAX7pFzM/Toe+Lwp1BEvuzq+8xR1EjyeGSLIcCjJ8uGs3lNQYwlMTB4InwPjUn0cqjIxjHtZYW/G0ZlaSmnIqJkRO9Uw8ErJ8H16u2jAVsh85v6Gj4SzXggR8j0SBHNv2M2dhztgRNS3kd5tcuahvHPXvRPanzcZpoc1eqcE3ETCoL5gwwL90Qm+/Tj7kOZAgi3E8nLFj9GtR7Njfb79mopxTSFtUGb5RvC57gNoMsbhsHrz4whvxV0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdJFmGh7Am/7Jv0z/iBAHxVmnUBAGioeL/O6fyFvAnY=;
 b=WGiNaJGCVQuAHWNXB0fo+Aw9lrtbQmqkhTaC6DAEddW2fEqUIlyvPLkobhSYnBezEUfSqvOwfe6J6Eowl8INIP5e5YG7+5Ubs5oklQIinBf8NtGAA62Gqa2EJ559HVt6QTPfp2HPRTmtplQDfYt64mFxPX6/Lz9VvxBX5nPO7VWFFN1EPlM0O5U/7QmhRwgSeFqZ4jqUDDN+I0cFjZHZE+hvU5+PMYNQQYLHC6DoEHEPqiI61ksseiNa2MXSAdj2A/6+/PxAXcJWROKuxAi4Ge1l17SVz217FisiTX6GWtHUoF92k9EY+PIMfOLeMG5n6EufGyn/GI1ixd4Bklpimg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdJFmGh7Am/7Jv0z/iBAHxVmnUBAGioeL/O6fyFvAnY=;
 b=Y9QsQjlZpI6sA0wkh8ifLiicBbaW8T+2YwzQarRu/iYuBCmQFByiiB+dH89uMcRIenvovMEw1g58KdxDgE4BWcWBnbMKQfmvevuu+y+rEXABLNR/OCB8fv+1BCUjbV9O918aRtXGxkn9Wa0j+gOQDHvpB4oZiPzHtcrG87gJn3GRULysY6+7TBdN9yFEc6s4ZzYSVMAFUXG7xbZg4hld1YCUhUc65fgUkFptwk+xJcxR5LO0jtF98jJEGILyCcDQ4vsyTwSwDrTzDUGfCIZDfQMT25HABLqlbpf9lsbcBHf0K5cr33q4ZAwiMDSyF8rXKrhjTUCKGXHNPtxfo4uEAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DU0PR10MB6726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 13:35:03 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 13:35:03 +0000
Message-ID: <5ef02e5a-c0ac-4afb-b90d-4d6d075b05e6@kontron.de>
Date: Thu, 27 Aug 2026 15:35:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Marek Vasut <marex@nabladev.com>, Frieder Schrempf <frieder@fris.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Simona Toaca <simona.toaca@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>
References: <20260819070758.51350-1-frieder@fris.de>
 <20260819070758.51350-3-frieder@fris.de>
 <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
 <a8be2bf7-aafa-4e8e-9685-5fa100941805@kontron.de>
 <cfe8d0e1-c652-408c-bc47-0ae96dd0a65d@nabladev.com>
 <c81db5f1-600c-41a1-91d3-7638fc4d3d58@kontron.de>
 <b528b642-5010-4843-bfe1-d24e8b709876@nabladev.com>
 <fa652a2f-addc-47a4-b89e-755aba42509d@kontron.de>
 <83ee9efb-e09f-45d8-ac0a-cd9b2797c513@nabladev.com>
 <59ed6576-06dd-42bf-8ea2-18de427955a4@kontron.de>
 <ae6f34f9-ec68-42e3-8483-4208d6e2e883@nabladev.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <ae6f34f9-ec68-42e3-8483-4208d6e2e883@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DU0PR10MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 18611e43-e0a1-419a-e877-08df043fffd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RNhoFK5pWKrpOy3ctFL9ni6liLQyNSWgS+pS30a7nWttT8B2m+t06FB8CAXcZ6oMVOQRHVLDcggjI0mgdSvmRKrZiiXMY2WHvr6gopL8PveC+c2NaxWEL38oaKUuAx1e1BWg2Naj28uUM/vxlQMf5NJdSn4xB/ODItmkPe86ezuSFlQu/qLekvvV8csqj7BPQH0dlhnJKRvrV7i0RuqLoOYhFs0Cmvn/7jQ/BSzwLEJVPZ1f3PgW/YIDLyr9RXenf9H0bnP6IsaBJxmuPoTrwhrDeWhNtcaz+52JsZpV43wK3CCgUlr5R7jb095838o5Ry0KkFNtUfyNHIo9LMnq4iqAC7NtBDEOTJh1XEJfbqT1w0iqzyoE0nmMqwFxprAXVNOK1T8UevBfoYnfrzLooFskYY62ws4SSBudpg+pwH16IusnBD3IQT9YG7Yxp2q+96nP/Ajb2gYCuH3aelu013yGnGaEnoTpqa07Gkl8wrQ3bEYoX7aiXXgjPTlgWUeUcF2cngCvW7evALAC7tEyGSTJMJW3ECYbYLfVdx5NX2/jIiUGcHPdTO1JpaYQB5wLSrkDHP5e3HsARKHXWmRusVvxqwuxXduzaZj2910GShK1qGV34z5q9DG671nW+60LUe4EYrSwO/DtloBC/+1E5jLYcraRJgDEyjUFHIEd9oQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJ6d0M1MWZDZUhTRTNaSVJKZXR0Z0loVzlkYVgzY3Z2ZllBYVFGZEV1NDhj?=
 =?utf-8?B?QWFyWkpBQ3VKcnRHK3VINHVsR1dnWXIyMWo4aTBlOFlXMEZvRVUxWEtacHVK?=
 =?utf-8?B?MXdIZkVmL2hVZmROV0Nlb0F5ckppMXBLQkFkUXhBV3NHMThCRlpvT3drM0E0?=
 =?utf-8?B?enJ0ZDA5b0RoWU5PMXlUd3BubG9WMWlrTUU1b0hEUDBEWXlWQlh0TnlPZzBY?=
 =?utf-8?B?RFNyUzdXT2pGTEZKTlF0NzU4cTZaWUhaVmNzQ0lqTVA3VnMycVNZZ0dSZkJG?=
 =?utf-8?B?c1hKb1dNdHRzRGlMZHRuOVAwVDE0em9rNHVGcndIV1dCOG9FQnl0c2hIb0M5?=
 =?utf-8?B?UkYycUlqQmxnUkVqdjNrTGlzdkdXbldCK2ZONXZCL1ZKZmU5K1V0cUxYUTQw?=
 =?utf-8?B?eFRUY2VJQWU1SXBCSVdqSzc2MjBSZ0Z1ZHlRU0w5V3pzSnpzeUFjUkxqUVV2?=
 =?utf-8?B?Yjh4alNVbFpmQVZITDJYaFpUN3I1OEx0N0RHQlhZbmZrV3J0eWRIUlNWbEMr?=
 =?utf-8?B?ZTJYcElGK1JCalY5eGtUeHRjWDNpZjk1VUI3dGhOWm9lS1ZIZFFYMDJseVJv?=
 =?utf-8?B?TDBKV1h0MHR6T1VvYXZyQmVIUGdEekpZMXpEY2w1RUl3bUk4Q3E1Q1k5UlNa?=
 =?utf-8?B?cTA2eWF6a1NVVFAwaE1KQXp4ODl0STJoOHIwVHpGZk5teENxOENxTVJibFd4?=
 =?utf-8?B?WElqdy9qLzNwSXpsc0Y2T3U5MTZyWGpDMTN4cjBOakY4Z1U3V2NWMFB3L2Fl?=
 =?utf-8?B?eVY4ZlpMVG9GekFpR1lhWWt3S0cyTExyVWozM0JvNnE3bWRwbVFyR3BQWGpL?=
 =?utf-8?B?V0l1Zkh0VHVBUi9tdWFLOFhjTTdVaWtkcEpVWmFKeGlNbDhuNWZUcWJlQXhX?=
 =?utf-8?B?b0lodVBxTkhpOVJaTTMzNHM2TXZOKzhycndGbmEzQU4zR2dVR1FMUXk0cTM5?=
 =?utf-8?B?eHVzUk04YldTeXZQR0pSLzRDdEhsdTJ0YkpKSGE5UEQzVlB6c1RwdlVrdVhG?=
 =?utf-8?B?MlFpSndyM0xNb0hmTHVtalo0QncrRzk2K0tJenZOSVZqYVB0Tm9EVEdUclhY?=
 =?utf-8?B?bWJEUWkwY0lUM0JjZ0R2L2FIQUF2QmJnZEdkMlpIWjVNZFF0UzhUNE13MXFv?=
 =?utf-8?B?dW9LRWdqa3hPcUZJUEtLY2VOSTQ5eHhURUdla0Vod2N4T2Mwd3ZjdVpkR1hE?=
 =?utf-8?B?WHVHQndoYzh2MkpHak1zMjlhZStRSjRlSjVJTGhHVGFaSVVVOVlyZ0xpb1pu?=
 =?utf-8?B?cmZJMDhMdFB2dzA2MWx5NlJvV2IwK0tTblQzMlZmZS9CWTdxdC9pb05tSU9S?=
 =?utf-8?B?ZlBkNUNxWUkxVkNRY0hDZld3TWpzdElaUHgwTThJNURjY1lWNXlWeU5aVlVo?=
 =?utf-8?B?Y1NKK2RTR0JwRXV4b0QwQU9OVVVJOHZWUmNqajc1VFdsdVFZbVNSSU1OWnVm?=
 =?utf-8?B?YTEwZHVwK0ZJRkxPVEhPRlZ6VE1LbWo0MFJEWEZXekZ4RVFrV2x0aXJLblhs?=
 =?utf-8?B?ejQxdjFuUC85b1FZam1rYjlCYkVrZGVNTUtoeDhOM2dRTWIzbmN6NUpxanB6?=
 =?utf-8?B?MTFWMHR0VXE4RnRiLzBZVHhKaUZPQWZlN2J6eVhpY3MyYnRlUFBRRWkza2xv?=
 =?utf-8?B?bmoxbXJmQlYxbDhubmx6bVNOQkpRVFFiWUNrQlVRSG8xU0xhQ2UxTk1mdDNT?=
 =?utf-8?B?SE41NjBmZmJFdTdxNVY3MFNnVmp3RTY1bG9aeXYrNVZ2R1dLM21oVW1ib0pw?=
 =?utf-8?B?RkFITEpoaXc2dlYzU1lrSk5uZi85Wko3Ry9YbGtPSjZqNnprVHVMQXJDcmR4?=
 =?utf-8?B?dzAybEVxQ2VJaW5kMWZoMFhuOGJMNmxzZi94R0ZFVjZkc3VQUURPa1pEeTBh?=
 =?utf-8?B?M3AvcTBUZ0FRckNnZkJqSytISDJJZHQ5cERlRXlXSjJvVXVXMSs2SUowL3ZF?=
 =?utf-8?B?S1Fub1NrcXhxTzZzT2QrSXFnNGZuY0RBL05IWWR2VDVpblFmR2RtK0VzY2po?=
 =?utf-8?B?OS9UV1A2T3hEZTQrN21QZG1FNmRlblowcC81eHBmSXRaSnNSbkkzbEwxdnh2?=
 =?utf-8?B?U3hDSUhVQ2JDcGZyQjIzVThkUzNQcm1ocU5JbUg5VHdRTlRkMVFFeUkxRjdy?=
 =?utf-8?B?RWtYcFh6Q2JUMCtlalFyTUdzY1JoZE0yVVFWVlhSQWdtQUUzdC9TQWJBL0M1?=
 =?utf-8?B?MGhoeDZmVVd2aS9tUzlUM2ZHYUJJVXJwSlhTL2c5MEN4V3ovUUtUNTBlYStS?=
 =?utf-8?B?MFNTSi91bndQMVk5eHBwNko1bWxBNzkwZ1RId2ZBdVp5VVYvS05oRU9oMVpk?=
 =?utf-8?B?T0FSbWVyZWRTWkwyRjAzTk53SUxnUkswWXJOb1lCZnpjUjlza0g5NkZUcnNV?=
 =?utf-8?Q?p5eCu3dNDdZzBZMw=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 18611e43-e0a1-419a-e877-08df043fffd5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 13:35:03.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cFpeZMcF4FrTaBlYrN6C1ovuBMQ8DN9QREyTFPz0mZbMJlfdj07CvWKrCbm30YF7YvA2KqIV1jx1okGvLlD+j0psV6HJFIgQNRV8A84h06U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6726
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

On 26.08.26 14:24, Marek Vasut wrote:
> On 8/26/26 10:12 AM, Frieder Schrempf wrote:
> 
> [...]
> 
>>>> I'm not sure, but even if it would work, it would require several
>>>> separate init attempts only to read the IDs
>>>
>>> Why ? Init the bus in slowest mode with widest bus settings, then try
>>> MRRD on all available DRAM chips, then figure out which ones report
>>> valid IDs and which ones fail the MRd .
>>
>> As far as I can see this doesn't work. If we use the widest bus setting
>> (CsPresent=0x3) on a single rank module, the training fails and the DDR
>> remains in a state where the MR read doesn't work yet.
> 
> Do you need training to read the IDs ? Simply force-use the slowest bus
> mode (100 MTps iirc), the training is only relevant for the high-speed
> modes.
I don't see any existing code path for any i.MX with DDR4 that doesn't
do the training before accessing MR registers. Do you have any
references or examples? Do you have any sources for the claim that the
training is only relevant for the high-speed modes? I couldn't find
anything that supports this.

Also I would assume that doing the MRRD on an unused CS would give me
back some arbitrary random values. While I could interpret an unknown
value as "rank/cs not present", I don't think its reliable enough. Or do
you know of any error condition being reported for failed MRRD?
