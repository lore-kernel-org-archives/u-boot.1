Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256D1CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 15:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6811B81D6A;
	Thu,  2 Oct 2025 17:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="RS28K90o";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="RS28K90o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C107E828A2; Thu,  2 Oct 2025 17:41:22 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADC080107
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 17:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=udz/rI6wbPsIKKVU4eX6PPfUN6VtY1lbtmb2Kt7+l3k9aseS353WkEoIbiQPjEni/Mcxu5RNxYmBsU4j5cThrrLK+/UI6SOpmxUQE/EJcJXuRctM1Xh5UvTDs5rAQ3eU75inhsAqr3MY9s5Eohg2jiCsIrOXbjJkDJyadMlQTWYdKqbHEvIgodD9w2OjvfbcFUkahyWjmV709C/DQhCQDW74nZC5vhE5tKYD33bXcajpiErMHDGVlw5KgkuyQRP5vTBgAmSvIYPqYMdQVG13XuM7zKSfqRVRH04qSYu1o/ieRS8RKFq51iDjNpbher3HvLJ2z99xJDo174QQSEtcNw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4SBrsjyEzSd/8HITbkC6VWufcwlZ1FxTqJPdJgMpw0=;
 b=ORymCdF/QbQ5cJGbLmI5g+8R9g+G7KyTMjb6eJYmZMsLy4kfjlBWzXc1gqqjRov6Wy7yLtLoK5KjppYxQyjWOxgw6neTIhrrmOWTbAMba5CJOZGBK8dmM6erCT5xfi4/JyCqsxan48+Bxuk1T2S9CZ8KJ5NszltyngOtUtczGh77AFg0ReRZ3x+8cQdi4az2GhKABYZ9aDY4D5n3ntEHXiF1fNEKwqAfGkxUPKpQb0BnOIjN5WNvrzJ+fVQx6n7QSs7BtwZRtHP90GbxQtgPLHkvZkFX797qObpGPeqLgKBQPFeCZ5sMk80JhD74dJu0riRXiJH5fmelNWrl6oWDHg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=canonical.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4SBrsjyEzSd/8HITbkC6VWufcwlZ1FxTqJPdJgMpw0=;
 b=RS28K90okCMiO7Uj4FoUhQWbBS2I5H+kP4Vr40w43ZqKYoAxqVFV2ExV5QdtajNHu22nbm0SkNcsLmWnav/U2Ybbpr4uNc9tzY0oqbpv+L2Ur04HknP5K7CELNLTlM52+0TyaN4WjUV9U3yJtj4bwlDG1srVCGJq8b0seApSf5BoaRz3UIGmckEuZS9WhuIDg14sz81NInLKb8yUhHTx/M3r0AvyX+DLb1nrRB5bhhkr+8IAW1zEuLszE91cNgGpRfFUhIDyFNF1Tue9IAQ/cqm1UhgelUATPqVF/2KmjSMNG35CWpLOW+jMY/ZjCmUfCuvPZpyl49uLnQ1QKvYeKw==
Received: from DU6P191CA0037.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::16)
 by PAXPR03MB7780.eurprd03.prod.outlook.com (2603:10a6:102:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 15:41:13 +0000
Received: from DU2PEPF0001E9BF.eurprd03.prod.outlook.com
 (2603:10a6:10:53f:cafe::c4) by DU6P191CA0037.outlook.office365.com
 (2603:10a6:10:53f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 15:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DU2PEPF0001E9BF.mail.protection.outlook.com (10.167.8.68) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via
 Frontend Transport; Thu, 2 Oct 2025 15:41:13 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 1222E20080097; Thu, 02 Oct 2025 15:41:13 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (unknown
 [52.101.72.114])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id D11672008009F; 
 Thu, 02 Oct 2025 15:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL/YUeF4UlAMKt23ygWBA3NLqV0G+rug82fTvpPmBVedI9MFVHt4aov3eicfnPkWgMxaPejULIaTYZ9PzvkPa6Adm2kGE9tcPioM+fT1nn1wWpn2+NkXnwYXgX+YB2R8sMW+7J0RNcTl5wZS+0yv7XnsQxvHFHagOoQZ65rL4FnorXiH1g0SyAaP952HpjllBg/HRSK5Q1cLDXTpjUSY8GGbITi5hWWXkg/wBHwiu4QRY/yYkq0o3ycnK1CxfGIYKM9bmqcLuMtjM+IETRIABgE3x0DWpqg61BtR7a47GysRbnadtFCjtpfo+x7Sksy8LpNrHRXybhGFJUHdMexWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4SBrsjyEzSd/8HITbkC6VWufcwlZ1FxTqJPdJgMpw0=;
 b=GjKZareS+Vb4VCsoZ1xscpSRkIoPykvs4nPznDEoSRYBShSDUafuNe9XjNb5xIOKBW10ps8RqHX/tr0pJbDMTdpuvhcfrIp6O5O0nsRzZCT4FHPua3Dfqti5QNGJdbHXG6xjhpEj7kamPhc5elQ3o6+lm3srrGPszFVZE/HW9UQ85Q/5GOBwg+o+F5yhw1jmwsIPGIRAVPZ8Ien64BHQcRn8cnZBMput1T1Cc8mJQYfiVnBX0cvhlB8AXkYxBehJRSASbxIfv6kFRjQZvek9Mkr5KpkqP3y/CQljiR3ZMS21xvsGSWFS5BfNwYxPTbps/P+ynczld9YHBPkfRzy2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4SBrsjyEzSd/8HITbkC6VWufcwlZ1FxTqJPdJgMpw0=;
 b=RS28K90okCMiO7Uj4FoUhQWbBS2I5H+kP4Vr40w43ZqKYoAxqVFV2ExV5QdtajNHu22nbm0SkNcsLmWnav/U2Ybbpr4uNc9tzY0oqbpv+L2Ur04HknP5K7CELNLTlM52+0TyaN4WjUV9U3yJtj4bwlDG1srVCGJq8b0seApSf5BoaRz3UIGmckEuZS9WhuIDg14sz81NInLKb8yUhHTx/M3r0AvyX+DLb1nrRB5bhhkr+8IAW1zEuLszE91cNgGpRfFUhIDyFNF1Tue9IAQ/cqm1UhgelUATPqVF/2KmjSMNG35CWpLOW+jMY/ZjCmUfCuvPZpyl49uLnQ1QKvYeKw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PA4PR03MB7373.eurprd03.prod.outlook.com (2603:10a6:102:108::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 15:41:06 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 15:41:05 +0000
Message-ID: <df246cee-652f-4cd9-b09e-5b09f41ae444@seco.com>
Date: Thu, 2 Oct 2025 11:41:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: semihosting: Use correct variable for error check
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20251002-fs_semihosting-v1-1-1124e6becc51@linaro.org>
 <2780374a-3a85-4969-96df-34e331a53c53@gmx.de>
 <7f274115-8fd1-46c3-866c-278569aca469@seco.com>
 <c0aad39a-a72b-4f1c-b10b-ae922ae4039b@canonical.com>
 <25dcea70-da3e-499d-90ae-732ebd253a57@seco.com>
 <24b8d055-d90d-4390-8cd7-1541ef989a41@canonical.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <24b8d055-d90d-4390-8cd7-1541ef989a41@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::8) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|PA4PR03MB7373:EE_|DU2PEPF0001E9BF:EE_|PAXPR03MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: af0eee18-ae59-4409-f599-08de01ca1e26
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?RFYyZlN0UERJYlBUNVJSYmhJOHp4dGd3cXNVWVhESzZwNXVoZTdSekhPS3JY?=
 =?utf-8?B?SnRTbWdVYmxVdkZ3cFhYSlFmdWtsU3ZRcE1qV3NVY2NhQWVvVDlvdW5wdC9F?=
 =?utf-8?B?ZE5uNEtOU2M2TGl5Q3JxanZSeXdyUEcvZjJpcVlWWDdLSHpld2hXbUlJeWRq?=
 =?utf-8?B?RlVWeGlzeGRHT2M3OVdSZzdsR1lGUlRUQmI4bWxQT3NHMUp6a21IclpKTjY3?=
 =?utf-8?B?bElGOUt5Ty9pVHVlVEZ0cFc3NzJEWjRlSnU2QVVpcFZMODkwNjZxcFE5Mm0x?=
 =?utf-8?B?NmZlRnc1TVpXUEZzQzhkRXdOWU9CU0U4ZU1BeU5VVGd1TGx6K0R0NE1Nd0Nw?=
 =?utf-8?B?ejNodFY0R0NmUHVLUjdGbS8xQmRmOGk2bFFROFJxS0xiM3ZWcWY4cDJBRk8y?=
 =?utf-8?B?d2JPMkRzRk1UKzVKWWVPTTlDTGhyNEZEZXk0dDdTQkdNaE4vbHFWTDRXK1Ja?=
 =?utf-8?B?dURNdy93V2tYL2hxMTdYcjJJcDErNzRxVEJvYWFCWXQ1dXFhU3dQNXJYNGVs?=
 =?utf-8?B?N01hdytPbzdJNyt6M01qVU9OUjV1Tkt3UXpBTEpxV3c2N2FoTGtvSXdGVmlP?=
 =?utf-8?B?OU9LSnZETVFIWm1Mb1hlOFpQNkduV2tQM2RGajhqQnQ1aGlDT2UxcVJQR1Ji?=
 =?utf-8?B?Nlc2cEx5YTBDSDc5by8yOWJuV0UxQ25lQXAxZkswOTZ3S1M1dnZLL3hLK3Uy?=
 =?utf-8?B?clF0cDlTYlZkMkZjU1lmTnpCWXA5RTFhOTlhelJXN1NYUTFYZStDWVZrVGt4?=
 =?utf-8?B?aHd5Ujk1ZWhqTWEzdUVGM0RDMS9KQy9Qd1FVQURXZGNUZldVUk0xa1pyY0tN?=
 =?utf-8?B?blBtRitVSllOaXV0YUpPRDFGWm82TEZZbHVhSjU0Q1k2Z1l0MXRlczMrLzdH?=
 =?utf-8?B?bTgyRXNwSXVZRGVDU2xxdXlkWWV1djYwTnF1bE9wRjhZVm9kSnJ4RkFaSWY3?=
 =?utf-8?B?OHh1VysreVo4dVh2TmNWeDB4c2JraUQxbFg1bEJ1UWt3NlhycDNURnRQRkIy?=
 =?utf-8?B?bkQyK0VGaktEQWVSR1JmQ1Q5cjZvVjk4aVcvYjVHUWFnVEtaNW5hSWFkQmJa?=
 =?utf-8?B?VTdVQ25EQ3RVYnhUVnV0RVU1MVAwby82S1I5YURLeXVwRWpSL1FCWWt6OUNJ?=
 =?utf-8?B?YnNjVlV1S2lLUk1yNWg4eGNHRk8yenRMU3JobnNxV0J3TE1sZC8xT1hxMzJr?=
 =?utf-8?B?blFWbHNVcjJYOU84T1draExnU1J0U2wxQ2FrMFloa05FMGlCcUo1d0tJd2cz?=
 =?utf-8?B?azJYcUMwWURuVE43b2JVTzFJRE82WSs3N3V5NUxRa3RQMDVCUEE0N29hUEcz?=
 =?utf-8?B?aFVyTHMxY081VDF4UHowb2FYd3l3L1RnSjRaMHZKZFZoakNsRW1vcWd4NWN4?=
 =?utf-8?B?WGJHc29ZYmV1T1VvbHFEcEZYb2RodjZhcXdZak0zN05oYWVYSENhUWdyUFpI?=
 =?utf-8?B?VHhwR1ZPTUk3NjNnWWp6Z25JbWIwVytkWGFmNzRhb1VnMWlOdmhTREU5Qlhy?=
 =?utf-8?B?Q1Q4UEs4R0ZBYzNObEo3dy9RU204ckVuUDUyWm1xV3pTZlNHSEJFOXVrVEhI?=
 =?utf-8?B?MzVyNlc1aWxSSmxKN3lrU1lkWUMyVWh1Ry93M0pOVHd4d0pHa1h3emNYMzRa?=
 =?utf-8?B?RG1uOHN3dWFFQXpmTlE2S1dCRVozOUdsSHBSRC9OdzhUM2VMSG81eVFBTXhF?=
 =?utf-8?B?c054SzdtU2JWejc5L1VHOWpmakY2Y3RIY3hLM1lCMFVhUGZpM3J4Q1BUdXFZ?=
 =?utf-8?B?L3ZCREVnZVM4RjdQNThEdDUveG5OVUZBaEtJOUdOTkxMSnpjMTJURTdVZGc2?=
 =?utf-8?B?b3NxdGVUb0loOUptWDFBUlRqQ2dNTkxHaXdvbnpyOWpLSDI3cE9IY3JBdVN4?=
 =?utf-8?B?dlcrQzRodnhDUFIxQmNuMGVLams1Q1dhRVREVU9tQkZpejJVWFZUSm9PcHN5?=
 =?utf-8?B?V0NHZ2tSaDYxMVVRVVViRXNGekVuSVhDR1BjOUxCd1VMTTNUb3RiVHhqL1FE?=
 =?utf-8?B?SVFmQW96QkFnPT0=?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7373
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e5b0a141-1563-493d-140e-08de01ca195a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|1800799024|82310400026|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3dicHJZWG8zdlR4azFzSnVnMVJGLytjNlBCYnpVa0l0WUhFRm5hekZTQ3M1?=
 =?utf-8?B?R1E4WEUybXRoTGcvUUthb3h0eUtLUzlkUXZ3K3dVNkh0ZnZ4VHVqcXpxU0Ri?=
 =?utf-8?B?b3Z3Wnp2bmRoR1N0eUFWQmpHWFJRMHMxQjJYVUxKNXl2bUtIVlNMOUxFeFBV?=
 =?utf-8?B?MFBNbGdQZU1OT2JYclhFcVJaaFdrclU1RzFlNlZ4K0QwTkVTTU1FT1MyZEdn?=
 =?utf-8?B?Tnh4aFUvbWxtVmg3UC9MN1VvQURoYmw2ME1obXRBNGNiVkNsaFJPeFBrTVJt?=
 =?utf-8?B?d3RORWZSMFc0SWh4bmRISkd2Zk1DQXVOQnpYd1h2ZEZLM09nZ2x5Q1JWRXFS?=
 =?utf-8?B?eXRud2ZsK3IrbDNZVVRNV2NWYWoyaG92TDZhMk9FczFXWEJSMEcrNXFsTmNS?=
 =?utf-8?B?U3l0S1pFMkcxQmEvdGd2U3BCRTgvWTFtOXRUNnNkbzI3V1FjQmEvWDZFOHly?=
 =?utf-8?B?S21tMmZ3ay9FVTJTb2ZsZzFKRDduT212YkN5N09Kb0ZXdUVKR0U5UmVIN0RX?=
 =?utf-8?B?c2xlVlcvRkd2VXl2TWhmSHZRTlhTM2R5ZmVtL05jOGZPdlJpY2dranIrRDRW?=
 =?utf-8?B?MXNxNmxZRkNyYmY4OXBQOHczZDhzZmdNUUg5WTgwSEM3OHJoa0lVZDA5dFkv?=
 =?utf-8?B?UzVZNWFNVWxpekJpM280Mm5xb2pzejV5VGxSS2k4aFZRVU5FNmV4b09EVVpx?=
 =?utf-8?B?MHVvWHJqU0NNbEl1RUV6clhEeEpOcUxmMXcycVY3OEV0ZFJrQjJXRHBoTzQy?=
 =?utf-8?B?eVNZbEY0K3ozSENQaFJ2OXBsclB3aUJWWWZuYlhRTnhHM1cvb2hhZTlOd0R6?=
 =?utf-8?B?T2pRNWw5R0FSZ3NjM0orbEJaaHlTdHBjZGNpOVo2Rjh0eUQ0MjJvejRjTlA4?=
 =?utf-8?B?Rk5lbEdBT2VMdlBpN3d0YkVJQkJ0N3BFMmw4UFBhUWd5NGlzS1FwK0NrdmpM?=
 =?utf-8?B?SjliMlZ5MmNDU3U3Z3NkdThPNHRBbDM0V05FUUJJOFdub2RQQWFiUGdGbThS?=
 =?utf-8?B?U3lXa1BIZURBYndvN0FvZ2NWdGV2SmIxeGcwaUtiaHhNdjZza2FNcHQ4RWgw?=
 =?utf-8?B?VDEyRmlabzdITlJWYkIwUks4SG9wMzZmdWc5ZkVSUTI0NThxVm9qLytFKy9k?=
 =?utf-8?B?UEpNejdqYzZ5b2I4UVgwZFBTdkJydlpPdTk0RUJYOVErUThkb1VBTUsxbUdw?=
 =?utf-8?B?ODVnZFg1eWx1RDZCcWlMRlZMRDFnbnJyQzI3NWZldEdDUVpEOTNnNW5PbVFn?=
 =?utf-8?B?N3MrSlNxbVplZjRDbUpJQkxDdFl0T3J4MmNYR2ZmaWxZT1ZocTdPb2tlTnRk?=
 =?utf-8?B?a2RuMjNTbnhyVm5URGxOVHhlRVJ6N1Q5NlM5em01eXFGV3JMTGF2WFRBaFo4?=
 =?utf-8?B?MDlsMTRqa1BwNGVSUDJxMmswdUx2blRpdXpyYi9rbmhncmt3U0dWeUhWRHhZ?=
 =?utf-8?B?b1kzNTdGaHNqeGpzVGRZZ0NzOUdxYmNBMUFUMm1BbktVOFBMUndGQW5oQ3E3?=
 =?utf-8?B?cXNUcHJaM2kyVXEyVEJwYm84ZnFvUVR3VVAvZ3dRLzU5OVkrT3J6UXJCRTVM?=
 =?utf-8?B?TzNwak05K0h5eEVLbEdybFEyNXB2ZHFBemhKSXpMRm8weUdTUnpNNVQ4Vnpt?=
 =?utf-8?B?ZHZMbitTSDlvOTZFVzJHNU4yMS9KVlRTbjlRemE4c05QZzdUTXEvTTljWUR0?=
 =?utf-8?B?QktHWFV4Y25vamY0SHFubWoycVV2WE1VUVdzdjVDcmd5Nms5TWtOL0dnS0ho?=
 =?utf-8?B?b2RjQiswbTR4d21XaFc1ekxDT0JxeFNneXJBQlZFTWNSSTBVaHJBU0R6K3NO?=
 =?utf-8?B?cHVjWDRTbk56c2o1blc3Y0JyNTBQb05mUGZPZnRMZno3ZU9WdFVBVlVGdE00?=
 =?utf-8?B?V0xHdGpHYjNQTHdYOGFtMWF6RWQxVWdGT2NWM2NsMjJld2s3NWxid0F2ZHhC?=
 =?utf-8?B?ejdZMTlURDdXN3NPVDVXS0xQZmRFb3VjR1VIT0htbXJDS3F4SjhLelhibE00?=
 =?utf-8?B?K0JMVDhDNHY1V3puYkU4eHlORW50UUNzTkdNZ2ZwSXNaWW1Oa1ozLy9ZVEpK?=
 =?utf-8?B?RkMzUHg4dFhrNXl3bWNTUWtlQXh1Mjc1MzJlZ0tNOXozMUc3MjZCeUNmSE5z?=
 =?utf-8?Q?ciHc=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(1800799024)(82310400026)(36860700013)(35042699022);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:41:13.3285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af0eee18-ae59-4409-f599-08de01ca1e26
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9BF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7780
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

On 10/2/25 11:23, Heinrich Schuchardt wrote:
> On 10/2/25 17:15, Sean Anderson wrote:
>> On 10/2/25 11:07, Heinrich Schuchardt wrote:
>>> On 10/2/25 16:36, Sean Anderson wrote:
>>>> On 10/2/25 05:52, Heinrich Schuchardt wrote:
>>>>> On 10/2/25 11:39, Andrew Goodbody wrote:
>>>>>> After calling a function that can return an error, the test to detect
>>>>>> that error should use the return value not a different variable. Fix it.
>>>>>>
>>>>>> This issue was found by Smatch.
>>>>>>
>>>>>
>>>>> Fixes: f676b45151c3 ("fs: Add semihosting filesystem")
>>>>>
>>>>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>>>> ---
>>>>>>     fs/semihostingfs.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>>>>> index 77e39ca407e4d240a1fd573497c5b6b908816454..9d7a136b9ba9b035545b34b31df58e2d65de7db9 100644
>>>>>> --- a/fs/semihostingfs.c
>>>>>> +++ b/fs/semihostingfs.c
>>>>>> @@ -35,7 +35,7 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>>>>         }
>>>>>>         if (!maxsize) {
>>>>>>             size = smh_flen(fd);
>>>>>> -        if (ret < 0) {
>>>>>> +        if (size < 0) {
>>>>>
>>>>> The ARM specification (https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2fdui0203%2fj%2fsemihosting%2fsemihosting%2doperations%2fsys%2dflen%2d%2d0x0c%2d&umid=f17ab8fc-2d9d-4cce-91e2-e7e66f117613&rct=1759398729&auth=d807158c60b7d2502abde8a2fc01f40662980862-e0799d2d4d61f93cae033d54733c8fa50ef84918) has:
>>>>>
>>>>> SYS_FLEN (0x0C)
>>>>>
>>>>> Returns the length of a specified file.
>>>>> On exit, R0 contains:
>>>>>       the current length of the file object, if the call is successful
>>>>>       -1 if an error occurs.
>>>>>
>>>>> Please, consider that the file length on 32bit systems may exceed 2^31 You must not consider this as an error.
>>>>>
>>>>> %s/if (size < 0)/if (size == -1L)/
>>>>
>>>> This cannot occur because on a 32-bit system SYS_FLEN only returns
>>>> 32-bits of information. The host must detect files that exceed 2 GiB in
>>>> size and return -1 (simulating EOVERFLOW).
>>>
>>> I don't think so.
>>>
>>> QEMU will read into the st_size field of a struct stat and copy that value to the return value. The st_size field will have at least 64 bits on a 64 bit system. And copying to the 32 bit target will simply truncate it.
>>>
>>> Expect overruns for files that are larger than 0xffffffff.
>>
>> Yes. And there's nothing we can do about this. If there is a 9 GiB file,
>> SYS_FLEN will report it as a 1 GiB file. This is a bug in QEMU (and
>> OpenOCD too) that we shouldn't attempt to work around in U-Boot.
>>
>> --Sean
> 
> We should handle a 2.5 GiB file correctly and not treat is an an error.
> Such a large file could be an installation ISO that the EFI subsystem passes to Linux as memory block device (pmem).

And what about a 4.4 GiB DVD iso?

The flen interface is fundamentally limited on 32-bit systems. There is
no sense in working around it. Especially because reading such large
values is certain to take ages over JTAG, and there are far-better
interfaces to use on emulated hardware (e.g. virtio file system device).

--Sean
