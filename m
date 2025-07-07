Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E35C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 569A683281;
	Mon,  7 Jul 2025 17:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="ucNz0toA";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="ucNz0toA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F3983145; Mon,  7 Jul 2025 15:50:46 +0200 (CEST)
Received: from GVAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c214::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA5B8304D
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 15:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pieter.van.trappen@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhIyEXPI8lX2Lwh2FbzRE/ly35zD39SO7/To2Dc8otlhR6aqg9S2wAGKlartIOBaYvXlY6aGqceq0Q3m38pVKmgt2z+hV6aP9VioC9sBOrs+WRwzZd+d1WRAn4dQZct1t2DwK9Wcqj6SUmJCCcR/lNcqnwohuF3eb1mRx+VJxOJpgg4/g4rDuWZ1gwPqIkWMut0IU8UXnFkj7RtpXOnZVuNCztnqYpW6Z+Nezv7nwWv0eoCNBKY5aOpYDKNJeCot+8iSjY99hqcMyIRjG+Wi/l+pMbIYr3EIusUV720QHyT39k1wrfgRxMzXf9Iy3mg62mqHrY0AxQ0iveXbAGccgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwpOpB+qJ1JhGrRokH30Kb4H0cjZLs1NrsOBveGVj4c=;
 b=HLLkRfqsiIdpMXTIHNoooy1u9UCLUeh3QJ0JFTY1Harn5MPtiMi0StTKw7+JPdxxmbZbEj3cXAu0l3xQ5rvKGiw77lEJcmY0XtXSUqmxJymU2NubuxBhfKO4ItKF4jazdu4WLcTGYWsnhyY1KyJOO/gPnBH7XZs4ShYWBf1nuPoXJ/YJ7xnYAK+gsD5BgjtCaySzUbYPJOUpd9kVTBOON2iM21RVb6wKFzokyvDEQ8IFLi9N8z7HebroE0npm93NeEug+51w1JCHtP7Wd0f2CXr/wu1ecPdwh7Y50+fTVAugAJKszil7AX+JNDO5JK9JGmXhQNkS/LFeSnUdbc4eUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.16.99) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwpOpB+qJ1JhGrRokH30Kb4H0cjZLs1NrsOBveGVj4c=;
 b=ucNz0toAfjqYVQziNCAwikqjZk664Rr6tHaBBUoiZIYfoJdX9hrBHy1MLrPLO1VlKedMTMOMknl8W677NUDfMWLlmyChjbJLO0XoOhQrj+VJnd2gAWKe8wZuNp7Pl1HftDxXlbQ69KtXLlQEeSqcCBduGUAaa/9Fy35EMoHRMiQ=
Received: from AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35)
 by ZR5P278MB1796.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 13:50:36 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::66) by AM8P190CA0030.outlook.office365.com
 (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 13:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.16.99)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.16.99 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.16.99; helo=mx4.crn.activeguard.cloud; pr=C
Received: from mx4.crn.activeguard.cloud (51.107.16.99) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 7 Jul 2025 13:50:36 +0000
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=ucNz0toA
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17010003.outbound.protection.outlook.com
 [40.93.85.3])
 by mx4.crn.activeguard.cloud (Postfix) with ESMTPS id D87CE7F016;
 Mon, 07 Jul 2025 15:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwpOpB+qJ1JhGrRokH30Kb4H0cjZLs1NrsOBveGVj4c=;
 b=ucNz0toAfjqYVQziNCAwikqjZk664Rr6tHaBBUoiZIYfoJdX9hrBHy1MLrPLO1VlKedMTMOMknl8W677NUDfMWLlmyChjbJLO0XoOhQrj+VJnd2gAWKe8wZuNp7Pl1HftDxXlbQ69KtXLlQEeSqcCBduGUAaa/9Fy35EMoHRMiQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::14)
 by ZR1P278MB1706.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 13:50:35 +0000
Received: from ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8]) by ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a96:59c:94fe:3ae8%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 13:50:35 +0000
Message-ID: <628f2930-354e-4658-bcae-4fc91fce92a3@cern.ch>
Date: Mon, 7 Jul 2025 15:50:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] drivers: fpga/firmware: add Kconfig dependencies
To: Michal Simek <michal.simek@amd.com>
References: <20250705205710.792370-1-vtpieter@gmail.com>
 <20250705205710.792370-3-vtpieter@gmail.com>
 <57b676ae-84d6-4459-92f6-f9096536def3@amd.com>
Content-Language: en-US, fr
From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Cc: vtpieter@gmail.com, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <57b676ae-84d6-4459-92f6-f9096536def3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::18) To ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:4f::14)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: ZR0P278MB0759:EE_|ZR1P278MB1706:EE_|AMS0EPF00000191:EE_|ZR5P278MB1796:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c113e5-d407-46a7-6849-08ddbd5d4050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|10070799003; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?S3BxMTFMY1kydzRDbDMxTFNSUlVSYXJtTXhsbmxpb2VQRURSUkIvcC93SmFm?=
 =?utf-8?B?QUJqSytSYkdxQU9KWUhNMVhwbEFLemtoaE8zYk5IVHcvT040WVp2RnFmUUFN?=
 =?utf-8?B?SnAvMncrRExsc1ZjQ0hCS1pwSHNWNHVqUFh0eTNsMDZZWUhNL1VUdDJPcU5O?=
 =?utf-8?B?bnBscHA0RkQ1MUxGcXBnUFZWNHZ3clRldVZLRGZyYXp5bEtQaHVWdE9rNjQ3?=
 =?utf-8?B?RmVFMmtsM0VlK1h6Mm9lWVcxWHB0RCtpUDBqL3p2MHB4OThxK3hDbW5ES3Q4?=
 =?utf-8?B?aTNJc2szZmE3ckl3VGpodWs2bGFSdkJWRUM4OU9hZHg3ZUdrTW5BcGI2T29h?=
 =?utf-8?B?MnRZMFVRYlk2UCtuVlJVdTRqQSthaHltQW85citTK2E4aG5WWmtXd0YzN3pm?=
 =?utf-8?B?eksxZGwyS2wxdTd3RFJsMnp1YXJ4bUFiOWZoSlIwQ0RCZFVqVmxEQjZVT2FT?=
 =?utf-8?B?cm55ZXA5Uy8ydjl5VmszcDlkaDJ3ajRjeWpJMFNJN3JpTjFDaE5lWkVrOXBt?=
 =?utf-8?B?SDQ5a005REdRc1JXQTcrR2ZmVUkzLzZWcmx1anBzaWZPVFQzSG10N0xxdmkx?=
 =?utf-8?B?TWJZMFVsZ3g0R0V4RzNnYy85VjFHcUlQYkovN094dEpUcG51elh6QlJDUFFk?=
 =?utf-8?B?d3IySExWREIwek05NHFkVnFnd2NzRUhXemZEekJoYWVTMWlYSTJVcXJoQWkz?=
 =?utf-8?B?OUVvOHJ2dS8xTUlHNnpkc002VUdiUWxSSGlRaFIxVkgxSGxBcjFRQ2NrZVJt?=
 =?utf-8?B?SmdLUldHZHBDUmlGN21XblFuOHMxeHZ0UTFaWFBab1VwVFlFd2pFT24xRHJu?=
 =?utf-8?B?TUpWOEJQUms2M28ydFdEaGtKakxZNEJmQVBxMVU3cXFlWVNtb2RTZlpKR04y?=
 =?utf-8?B?dkdUMVZXTjdLUDRDVk5MSVZqblJ1QXBFTTU5ZWRpQ3h5TWhyb1J5SHhDSHRp?=
 =?utf-8?B?bmNScS8yS2drQ05oKzNkZjM4bFBUK0k4d29uV1hiQ25HY00rbmNDNEg1QnpP?=
 =?utf-8?B?UkRKYk5oNlRjSEpwZlpUZWVHb0tUMDU4MmdIWkpCN3F4alVQTXVxZVpKaEgr?=
 =?utf-8?B?WmtoWkpOT3E4eDdXRGZOSlR6VkVnTGE5eWppcUVjL01Ob1QwZ3gySDE2SjR5?=
 =?utf-8?B?QnFsNEJrakwxTU1Td0d6dzJmRy9SU1lWTmtpc1hJelY2OWZRU3NaaTZRK2Rx?=
 =?utf-8?B?dWdaOEdFNHh4YjFhRkVOSkFVR2NvTlRQNnlVMUxHWmVyVXpVejFSbjIzbi8w?=
 =?utf-8?B?T2xUdnRPRVltTktmaUd0NXU1NlpOWVI0UVdiVnZ2L08wSVh0ZEM2WThUS292?=
 =?utf-8?B?cDJEbnVWWUZkMkpXaDFwdFVKR0lPVFZRQVpxdE5IVWljM3l3VnpqTDg4YjBR?=
 =?utf-8?B?ak5aZk5nZVBHYmRFRDhlM2Z3cWNKanhBRC8rNzBkOGY4QVVXR2Y3UmYrQVFF?=
 =?utf-8?B?M1ZrcjRReUN3NWZZelg1bzJSdi9DeFNteGRYaEttTGx0Zyt6ZTZ0bVdhanJZ?=
 =?utf-8?B?Z3BrYXZVdjlXM2VxZHM1d2oxbStJa0w5WnJZS1cwQlN5elFobURPMUdWMkZ6?=
 =?utf-8?B?V0ZpZGVZRi9YRG9IRzFkQnRMMm1RMTQvSi9CK1FHWU45VVpIdVlaWlhZRGJu?=
 =?utf-8?B?UVIxY2VsVWpaSzMvcmtjYjNvL1BNM3R5dmJIemg2bXUwYTd4a0ExejdIZXcy?=
 =?utf-8?B?Y3k0K1VsQVdzdkl0a3daRlExNnJuWUlERGdhUUIzNXJyb3Z0S3M1SEs2ZFZC?=
 =?utf-8?B?SmNGblVvYnVoam9SNklqRmExRTR1UjA5NnVpWk9Fb1RNUXhCbjVuNEJMcVNm?=
 =?utf-8?B?cVFBQU9MamNJQVZ0T3ZKR0FZSHRTc3BCMXBqVEpNdVJFODJxRnA4NCt0d3RP?=
 =?utf-8?B?LzduL3dCdFhOZzFlVG5rakFkOUdkZm5SN1Q0Rm5Vbzg5ZXZLSHNEV0lzYncy?=
 =?utf-8?Q?svO8BVKM9sA=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:ZR0P278MB0759.CHEP278.PROD.OUTLOOK.COM; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(10070799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1706
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ba92ec4e-12e0-4079-58af-08ddbd5d3f64
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|14060799003|35042699022|19092799006|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0E1WmRlMTU3UFFnUStoUjl6OHU1cmNEdjU3REdTT2gzYml3RzBhV0hSZ3FB?=
 =?utf-8?B?TE9lWWVsYXc1Y0ZtaWFpTG9zaFRrUElFRERIUW9QanZwUERONHNMOHpxVUt5?=
 =?utf-8?B?aTRuaW5aYjhPZEZrUmVRMjBHT0lZNnp0T0JlbXhEb1ZNRXpNY2w5WTQ1cjBn?=
 =?utf-8?B?UlB1QUU1b3V4bWtHTDNubm1heXQ3UVZyd2hGRXNIN2pWRGY5YWdMNlBlSmFW?=
 =?utf-8?B?d1hEQW9Ba3F0SnFFSEtHMWlqeHJmbmdwWjN4RU5lWGdGNVpyMXg0ZHI1Nk1R?=
 =?utf-8?B?MHM0MEVyRnphMmswek5ycUJMTmxzTWZrdmkweEdIZ3BaZkVDVExjMmF5bDRm?=
 =?utf-8?B?ODBlQ0RwUmlTVHlCd3ZuaDJZeVRIUkgxQnZhelNpOE1MTlFtSE9UZG1XbGkr?=
 =?utf-8?B?R25EbTZxeVBoSWovWlVsblF6a2lobkdjVVIwbitJbklaeTZpdUxxNDlCbHBI?=
 =?utf-8?B?K1pBMkErSGZLeEJIdmVFN1VvM1A3eks4Q1FBdUNmZGx5Z3NQM3VHOElzV29l?=
 =?utf-8?B?ZlV2b2pyUnRxbXlqU2dxRmlBcGNrU24yMStENWg0MU4zV2NybDNVWVpva0RM?=
 =?utf-8?B?c0cyK2t6OFlhVnRkb2lwWFcyY1p2M0NFb1dyK3NPcm56alArRGRIZDdHaldu?=
 =?utf-8?B?c3lmd2thNmVkLytFWGxhbXArZmwxeFU4ZFlHMHNkL0Uvdk94OXhUK2xhQ3VS?=
 =?utf-8?B?K1BJakNuenYwZjNxK0xRS3Jjd3A3RFFvb2xGMElSSVo3bzFBSHpKNWwvZ0RO?=
 =?utf-8?B?cE1Wc1NRTXFoUldydjhHTU1NaDlrM0g1NUxuTkRxZGpwanIwTDVGSFhITXY5?=
 =?utf-8?B?WHFmZ3M4WGNlSTEzbGRsY2hVaFl0VFRXcktFMWU5MnM5eUs4TUZueVAxZWk4?=
 =?utf-8?B?NS83OFNJUXdEQStwN20xWnNIMlFGb242VTgzNk1IOWRTdHpIdU55dlBqT3dp?=
 =?utf-8?B?VDQzQ0lWZ1o3dDlVUTlkTHYwMHRnUmtINGNJL0hpQURGSHRzM3YrVklvclJm?=
 =?utf-8?B?dGtSRnZiOGh6WlRJN1RVYTRMcXc5clptRnEyVmcvY0YzQ3hiWWFrY2xGMzFO?=
 =?utf-8?B?NHNmZkhxVVM2ZFBTMEQvNXl5WVlUWDF4UFJOY1dDeXREU2pTaXIxT0tDSlBr?=
 =?utf-8?B?VmZhenhhQ0ZhWENzN0ZzSzhxMVVxb2JoTkVySHBhRDdtUXFycFlxRXRIRDFt?=
 =?utf-8?B?WVhFU2FGd2V5eGk5UE5BKzMvY3hvT0IxZWxRVlBvTk1HOFk0dUxYZVZ3c2lh?=
 =?utf-8?B?UHhyQzdrL21weHVMZVlYbmJjOGFFVWFWaS9YaHdiWXh3YmticUdTWlp4RU9X?=
 =?utf-8?B?QkhUakF4YW9BTUF4eFZXYjk5am1odkE1WEU1UmlOeW9wNkRqRmJMRFVlVTZP?=
 =?utf-8?B?dHFhSTBxMzNEZjJGQVAwaXp6S04ra04zTFA5MC9xTHlSQ1U5dWk0WEVjcnEw?=
 =?utf-8?B?cmp3c0wvS2JtWCtaMU9mWUkrY3Y1MnlaNVFEeTZpUHB6VTdhNStJaWVoZlNa?=
 =?utf-8?B?N25IZ1djODFyY3hLanAxLzh3QmlWbWhuVjJHanVkZEd2Qi9UQ2hvcFJyR2Ix?=
 =?utf-8?B?V2h3VFdXT0ZKSEx4RExCZ0NlQTd0amN3Yml3ZDJ6d2dxbEQzdlJvSzM4N2xn?=
 =?utf-8?B?czdnczJvUjJ4enYxOXNDTnFpOWp1djVlNmhNYkN3eGVoaG0yUnBlR3pHb1lW?=
 =?utf-8?B?b1ZSb3VzY0o3dlJoaUZoanZzM0o1cmwzZVcrZVMvNVY0RVBTUFVFY3lVSmlq?=
 =?utf-8?B?TmZrUE4wUjRITDlxaUlvR21aY1o5aEFJWm9oNXp0UHNrZkxkTm5TZlJZMmdB?=
 =?utf-8?B?SUJNYnhFLzZiaDV1eGZoTDN2L2Z1d0hrWXh6UkExcjQzOFExUm9jWnRxVHNM?=
 =?utf-8?B?M0xxNmRiMmdpY0VpY0JpaUV4d29hdnhyTzY1L0ZEK1VKblpZUFQ0aEQ1OTJ5?=
 =?utf-8?B?bU9jc3lxdlA0aUVaSjgvMjRITW9KUjlmb2tKZ1k1Z0xkOTNsWDYwc2ZuV05s?=
 =?utf-8?B?Qll0d2xuNWlqVW5NUU1kek84MEh5YytHOHpxUEhWMis3NkIrdG1hb0xvRHdh?=
 =?utf-8?Q?Ltf8v0?=
X-Forefront-Antispam-Report: CIP:51.107.16.99; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx4.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(14060799003)(35042699022)(19092799006)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 13:50:36.4296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c113e5-d407-46a7-6849-08ddbd5d4050
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.107.16.99];
 Helo=[mx4.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR5P278MB1796
X-Mailman-Approved-At: Mon, 07 Jul 2025 17:54:47 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 07/07/2025 11:27, Michal Simek wrote:
> 
> 
> On 7/5/25 22:57, vtpieter@gmail.com wrote:
>> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>>
>> FPGA_SOCFPGA requires ARCH_SOCFPGA cause socfpga.c contains
>> arch/arm/mach-socfpga/* include macros.
>>
>> ZYNQMP_FIRMWARE requires ARCH_ZYNQMP cause firmware-zynqmp.c contains
>> arch/arm/mach-zynqmp/* include macros.
>>
>> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
>> ---
>>   drivers/firmware/Kconfig | 1 +
>>   drivers/fpga/Kconfig     | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index 8789b1ea141..f3302d34354 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -29,6 +29,7 @@ config TI_SCI_PROTOCOL
>>   config ZYNQMP_FIRMWARE
>>       bool "ZynqMP Firmware interface"
>> +    depends on ARCH_ZYNQMP
> 
> This has been already fixed by
> https://lore.kernel.org/all/20250702010410.18828-1-trini@konsulko.com/
> 
> M

Right I see, also my dependencies are not complete. I rebased on next 
but I guess that commit didn't make it yet to the next tree.

I'll amend this and the other patches after your comments for a v5 patch 
set.

Thanks, Pieter
