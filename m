Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCD6C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 04:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0958406CA;
	Tue,  4 Aug 2026 04:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q_atjais0v3V; Tue,  4 Aug 2026 04:35:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F0DA406AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785818112;
	bh=vc2uvQrODlRR9qcZkUnzOCvQ++BebC5qH8NkJMfuPqQ=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lnQgoifGGWrgMI9Au1JXLmwhLbNzBP/Q6im6uzJUDtGK7dBAVT0HUqcp8H/yEyZ7U
	 J+UPUzbzVYZT4eNgRSsQY9AhhDjqMtNG+2RwPxJNVukThjpG7l1zm++TFw1QuEnwc/
	 rHr6mGqYCZaz8lB/guAaUwE7RZlFDOAzYZRAtGpndp443fF6ptkVEvKhO2e8CfmUX4
	 0zuwQFx7U03dCXfF+/LxZo67KTdnabeJsgbWd3MFKl/wrljAyd3C4wipIcPyvxKkfR
	 sdkJrbU/+OpH2Rj3FJge/uqgq8Fw+zgVf6xXPr23tS1imFGNMu+zfDXZmy+vrm5XlM
	 CQohK3v2U75dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F0DA406AC;
	Tue,  4 Aug 2026 04:35:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DAA70194
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 04:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC3954005B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 04:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j7Kquc0CexP2 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 04:35:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A248A4002B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A248A4002B
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A248A4002B
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 04:35:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B7F842FC; Tue,  4 Aug 2026 06:35:04 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679C280087
 for <u-boot@lists.denx.de>; Tue,  4 Aug 2026 06:35:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APlN4AmgYazAlz+rp3UyjA9D7B1CtDzzfpEiPN1SrIiCIh+nf1zYZwz7akYc9UFnNpncSkqHse2tT++yUsqGw6ngHGqEn85d0qx0N++alSiGFHiaVhJa1QqXea2kaegUyxHdbr4OTUwIF0s86o/nAnym6Xq9Jc7B/FOs7HXn4Yn9/GiU7nJinyPB9ODe4e2yeq7HuRwQDtdWdbWrRoBpMUc3DD48vtzDuU7Gog9eHLZDANXE3688ZPtWcbw/bM2uuiV29rpffYz39SvOeJKxZ0Uq4QOZdDVWNiixWw75kW61Whz4ib/JpT9I36f4LyZyqs+m8YBoYY4gYo1yJfDVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc2uvQrODlRR9qcZkUnzOCvQ++BebC5qH8NkJMfuPqQ=;
 b=pR4iPIfX6F0S/5DYDW1fSjh3SE4S3J6iRUa0JW5sojV1L/pw4Jj4bbKQVXFZeTVPX2rBcrlttsGecGVl5Q7jYFxyB8FLH7h1l1lG+lJjYsEwIAGxPinu9mdLvcUGq1/TQ+DhbNFQ/QLMKkaBKT4NGaK+hnngsi9SjaX+Dck5dKRREGRBD2hNfN8e5/vnrYXHTE8Ir1Kh8eB26yFGi7u02INTgIZFDvCYYRWykVRt1TXe9xcOZUU3B0Fdp2cZ97PvVPy8f8Xs+ab3ffsgs+Uu20Or7IJpn/wVgxQFqcxfhNEOWKBjROnW9ng3Lc/YSF/B98efd6eZUjEn4Oy4pLq9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by DSWPR03MB989128.namprd03.prod.outlook.com (2603:10b6:8:35e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 04:34:58 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 04:34:58 +0000
Message-ID: <6555d7d3-77a7-4613-82b2-90e55add2cb2@altera.com>
Date: Tue, 4 Aug 2026 12:34:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: socfpga_n5x: Set CONFIG_SYS_LOAD_ADDR to
 0x02000000
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Elly Siew Chin Lim <elly.siew.chin.lim@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
References: <20260507005538.7502-1-dinesh.maniyam@altera.com>
Content-Language: en-US
In-Reply-To: <20260507005538.7502-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|DSWPR03MB989128:EE_
X-MS-Office365-Filtering-Correlation-Id: dc59893b-ba37-48cb-b3e7-08def1e1bd77
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kjU5/yK+jK+jhlmdHB1ryKYSszj0Cm329+yQOnMjRpPGm7LW0ncf7FWfxLJmVYcFcrYgPzrO+vckQTb/1aVkTU1HqRx8kJwqgJDxrC6RTLTfKl1gk9Zg2QrlyubNPaqDhCvkNepuw/AQv51ywZFSdcTKCc1l4AoyGCKslG82KN6mLZPexXDQrMtQ9F8kvopuS3US9VqEnRACc9cLSc8Y5GPRYncMUTp1T91Yo7FEUTmZpMx0UOCojqu/0+Ng4jKqoTJ/vjzTdDg6yj8CT4YIr8r0Xa3BH+KcnP6+m+LLtD+MboUcVFn2B4/7plkoGh0TFkEf12QqmEfOX9gOE3WxSTRcQsTdzRw18bjnViUfhJAsAMTPn7TFOrY8rRHDzk4pGxCmAktPHPDih+Uet5A/EY32mVg4gNV8p1SXJIaXyG7Y0PIwXLDTbFRxco6CJJPyicMF0T3DjMjhh7lI0bWYVqSVQivSR8ZKaFsAw4G/9lYVSFunIqakJA+xMQvm+qACpRFIrpgLjNYowwRSRQjKCr59BwsNBwU9HnI+DDEUZxaQDvOA+QLSco2nQkE4OCEQyIAhJlP5pT6zrQKKTbdDcz9RWHQV3ffIMxRnWsZK2K+DN8vxgMdSG9EsKeL2FfEYlP8cRyrJ+RnajXJsbHYsSA0cv8gVbRk065BCQ2ONU4Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0J6Z0l1NXgrZUI2aWRXa1dsaDZ2bE04NFhSZzUvazJzZEowcTY1NEQzZU50?=
 =?utf-8?B?c0RpWUdzNnNzUEc4UG5ZN0dLMFI4a0piMnpxb1h0T00vS21ZWmFYV21SU3pX?=
 =?utf-8?B?Y3lKaWtISXI3ZWxqdTVsUllhUlNlWG5jQTYySWswLzV2Zjd2c1FQS3E0NmZW?=
 =?utf-8?B?R016Z2R1KzhOTUpzV2RiZWtpWHNZL2U4UEdjZGozUm9PRWcwcFJoWHFkQTRk?=
 =?utf-8?B?QzQwSnk1THdtaTJKb1V6SlpnYmErTVc3SnpGei9mWFo4SnZPRkh6RjZjUlhz?=
 =?utf-8?B?REZxMHRaek93M0xSVEdOVU1ZMWZsQm13d2ZXdTRvYS9HdEhiUzAxUVkwQmo3?=
 =?utf-8?B?RGdxcksxVXp1MkkvNlkyc0pLQTdQNW01SXo3cU5KK1pLMmZHcjRNWXBOQUsy?=
 =?utf-8?B?NjZkT0h0REhNL2ViS21mcU1uMTk1QnIwTElOajhPVjg5dVZvSHFBcG9kMW9O?=
 =?utf-8?B?bkZUTU8zak05Sms4ZmR1MWNqKzFZcDRVVy84RnFZZWxhcU10dFQ3dFZucEEr?=
 =?utf-8?B?NDNQbFZrK01HaXhjZlFHNnVDeXRMeFNTUGtQOHRLSDBjK2tITzYzMVVDNE9O?=
 =?utf-8?B?K0xDVDJkanRXWVYvS3p3c2o3eDlUbDczWDFBZkJWdVlOY244WndvalhLODF5?=
 =?utf-8?B?akdrTDFvTCt1MEY1UDFkbHJnbitNRXhlV2craHdaNlkveVBVcmZpNG1nditU?=
 =?utf-8?B?cExTai83LzlkdE9vTWJEVG9zVDRiS1NhelFhWmM4WG1VZlZqbW1HaTQ5b01i?=
 =?utf-8?B?aVlMYTlVcVc5ZHEzT2gvbVd5aVNDTmQ0RGFKU04weWowNjU2eDlDZnBOQnFz?=
 =?utf-8?B?TU4xSHNZdTNFUE5hdnYwWXJsODBQU01od3NORHZWL0JGWHdoZmczamtKZElz?=
 =?utf-8?B?RWdldmxGUmRkMDdJUlVTK3VoVk1Ma0lDMFFFbklxYW1CckkzekVOL0o2WWRu?=
 =?utf-8?B?VnlpUk5kWk5sdFpWNlBTSm1sQm10NTBpYmliZmZXQlBOUWNtVU5lQnhOZDFx?=
 =?utf-8?B?bTJydFU5dzVEV0tzMXpVdVhOa2tRbkFIQzFVWXdtbE51aUNqMVdLNHY1a1gr?=
 =?utf-8?B?dzdkKzROMkhnR0prWWE3VWxLQksxTmZYV0ZvQ3FrZUw2UlptREdZRWIwWWt3?=
 =?utf-8?B?bDlUbDQzY2VMS2w1by9ZdTZVSE5Kdk5VYWdRWnkwUUVtSFBzMUJOeWZseHov?=
 =?utf-8?B?MFlHREdia1dJZkxJQ3d4LzZhcFZlYUtZbmhlQkVtYmR1WnhlUnRiR042Rlp4?=
 =?utf-8?B?V0xyZzdINGFpYW9jcWJONDgzeEZZcTludDExQW5kWFFtMFF6ZFFLWHk4bDR5?=
 =?utf-8?B?T2RwWTU5S3dGSDUzd05KSmtaU1BxWmU0ejdjYXlzVFh4OENpM1lYUG5ITnF1?=
 =?utf-8?B?OTlkcE13NWdmMlc3ZE14ZGVwUUx0NmNNUHB5VkZRODVjeTB4UE8rRXhac0Q3?=
 =?utf-8?B?bFQvMWZQYW8xSmVyZ2owTjAxNkJPVkJOZG5VbExrSUU1clpiZjhlQTJ2MjJa?=
 =?utf-8?B?RGp2MkZDbUk4WFVzY1djRUd1ZXRKUEh6d1pTNlEvRTY4QW4vaGt1Zm5UKzkw?=
 =?utf-8?B?VnhtcVBUaGVJUlN4M29LZUdCRkNQbS95WVluVkdUdjFKVEhobG84dFJZTklD?=
 =?utf-8?B?V3ZwV1RxbHpPUHZVRS9hMHNkblQxa0p5cW1oYW9PM1QxSWNrbDhRQ2lDak1K?=
 =?utf-8?B?TnlMSWVZYzFKbmk2bzkzSzBUcTU0MFI5NVJTbkxYZ2Y2RXlseGlqNkZ1TmJT?=
 =?utf-8?B?QlUzVmxjQk5rWWU3eFRUU2tnK1dXMW4waVFMQ21lb2ZuQ0xhUGYxbTgxSis1?=
 =?utf-8?B?K2lvcXUzQmpGZ0o5RUR6azRmeDlXd1pQWEFwTldNTlc3TTlCbFdxczl1QWFS?=
 =?utf-8?B?SHRGZ2hWSmhTQ2lHR2NmcjlPR3FMUDlHd3MyQzFIU0R4UUNEbmNhNlV4QjN6?=
 =?utf-8?B?dkhJRDh1ZWt6TEZkVWVlcHFGLy8vTFNXcDh0REs1WFVPQkdRWW5mQ3ltNUo4?=
 =?utf-8?B?RDhmY3N2cWdKZll3NnMwNWlqYm5NQ1IvaENHVVNib2RWWmdxdG5VdkVwb1ht?=
 =?utf-8?B?WDVhR2RkazdodnQzZDgvMzBNSTQ3SWhkTU81RU1EcU44cTk1OFUzS1dDTndw?=
 =?utf-8?B?V2l1YkRjQmRLRnY4VTd4SkRBVnBpQy9YZW5iSTdnRXI2Qk1GYXRWb1RkMUtt?=
 =?utf-8?B?ancvMG5sdzE3cDA2YitrcEowcmhkZllDRVFSNFFoVUIvMmVKNVRMbkdrWVNy?=
 =?utf-8?B?MGxGNzJnUG15U2RXczJhVFZMaXJ3NTMzY2w1TDFPNnVzOG5DYmJLam03Z3BR?=
 =?utf-8?B?aHJsNVpaY3dqa0FWM1Fmb3JyeGJ0MThwOXo2U1VMMHBxS1hNMkdnZll5Mnla?=
 =?utf-8?Q?F+Nw0eAg0ibvDSsM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc59893b-ba37-48cb-b3e7-08def1e1bd77
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 04:34:58.4544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZme04kE7NcgoNpmCFj9g8W2j8frpXTPdBL8MQw3MAfhgDCmU+F8wyGlCKcn+A2OqTxOnDdaVt9t+LfWCgoIVV4QSSrRVwtN/iZeKltmdDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989128
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vc2uvQrODlRR9qcZkUnzOCvQ++BebC5qH8NkJMfuPqQ=;
 b=jm4zgO53HccePcGoN76s03eknjE2JRMpNxdfaujmM5DKstP2qMnSW3HxCTlTEUaK7TxwdEpZEv1OCSs4pKXZ+kNe2STQd6NVuhEe4VH6gHc56bTgNcPiJKr2JwWomt0Nxj72UpqWPAC46HHuqCnKipE8ZWWG7dKl/dQpoDp/cHEw8XwdYOHb0aHfqsuwa0FrMVmTcfwT7UBJu4BVCKWuscbLLlYcYCccCaVpSKdhOGdWleOLJ2+TO5vZA7HGv96eZ+t0Ru0hfgQwXtwyd7XNlYXACC7IMtLz7FlLis0bnLAGBEmt+8mYKfu7oyTjNRJDuojCr25UsZl0hQk0IbWcyg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=jm4zgO53
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tien.fong.chee@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="jm4zgO53"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Chee, Tien Fong via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Dinesh,

On Thu, 07 May 2026 08:55:38 +0800, dinesh.maniyam@altera.com wrote:

> The default load address of 0x01000000 falls within the 32MB region
> reserved at the start of DDR. Bump it to 0x02000000 across all the
> N5X SoCDK defconfigs to match the sibling Agilex / Stratix 10 SoCDK.

Nit (optional): the "32MB region reserved at the start of DDR" claim is 
not cited in-tree. The stronger rationale is already in the patch — 
ARCH_SOCFPGA defaults to 0x01000000, while Agilex/Stratix 10 SoCDK and 
N5X SPL_LOAD_FIT_ADDRESS/scriptaddr already use the 0x02000000 
convention. Fine to leave as-is or tighten in a follow-up.


> 	"loadaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
> 	"fdt_addr=1100000\0" \
> 	"scriptaddr=0x02100000\0" \

Follow-up only (not a blocker for this patch): board env still 
hard-codes fdt_addr=0x01100000 below the new loadaddr. Worth aligning 
later if low DDR must stay clear of payloads.


Best regards,
Tien Fong
