Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E36C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02E5180F6F;
	Thu, 20 Feb 2025 14:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="OxAQjKvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D1B680EC0; Thu, 20 Feb 2025 09:54:50 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD19801DE
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgtXxHvEdpw6Eyy3jWk2FTw3KT2ueNBKl0/D/U5I78Ni0THDwI8H3rkfMpKkrwRQarM5xR37ZdjIiUIoY+AGm0dJ3TjUFZC3kzR4i0xhmBZ0IEORbwdrczVZx71ab7jpwetK9mXzX9lHMGCq3x4iP2Esc25tpkG+0O5t1w4WopboVCuBOwAF9vH4fonGkTvwrTe8kJgsC3E8JlpYR2h1TsKn/MdHBV7GpEdAhrRfzlkL5pzYgEAxul8/8qg9Bn3Td9eyc1weTWXYR3af+H3iIfLdpki55+CQ9l2kfbnP0V9LJNwinYZnvGyJDGC+GJDZnyvL1GoFodfJlFrNlKc/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9Fg4WH8nsLPv8eVB3SYRvHp1N3zlh70J1BInwMcbM8=;
 b=ADFscmP/Tgr78VSy0aqVtoz9LZpicEgD+rhxQePG5sHJpy1Q1dYx0FVgOh1Px8dl4irB4GQY/NOi8VRfExxFydHZBI1iKvg9w/zQjKLMd3c9+zqW1eTuZT3IfrJGpNS56odS0UEK8XybfznKaZCcJh/XBCPGyYcUsFhfLKCBJ7JMyo5Syk4NLDK+959Jn6PsGpjbkl8x5rCfOtc7+pDY/uTHvC2+cGUe4/+8YeRc7FZVh4vbyabSzvl8xcGlwFp1hp8f5LQCUhdEcZWzwLzjfWVjBscKnCfQVpr1bqdhkxAvKzaN5lmIWh8SXpDdKOuhPDCxeIrmHCv/yFz6NTApKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9Fg4WH8nsLPv8eVB3SYRvHp1N3zlh70J1BInwMcbM8=;
 b=OxAQjKvCT1EX3fL8We0/9ADpKLoC4ACpQ+K3PEHcovpONM+ESmhJMkguqCpWwozVMeKHfv4fQnglH2W5zgIhL1QFaAvuLZOvAigaJH2J0GN5S0C6td75vkoNgrYt5hYij2Js5maNCRcMur9hxVQbNM2A65GwSIOkE2HHd2BSH2Wf5t1eojb1YolVw/b/mP7jsnfa9xdmYYdhD0xReXPWQbFVxTgQ9AOhZrX5KXC+k1zVs2FqP9rynq7666OrzVIwGGO1ELSj1OaFNHxKqY1BVkGHPpjJFZil01VBOLkHjUZVvl3F46LeuK//w6TBYoJLMhc3l15N4h3JeqrznjwiUA==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by PAWPR03MB9129.eurprd03.prod.outlook.com (2603:10a6:102:33d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:54:43 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8445.019; Thu, 20 Feb 2025
 08:54:43 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, BELOUARGA Mohamed
 <m.belouarga@technologyandstrategy.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>,
 =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marjolaine Amate
 <marjolaine.amate@odyssee-systemes.fr>, Matthias Brugger <mbrugger@suse.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Piotr Wojtaszczyk
 <piotr.wojtaszczyk@timesys.com>, Ramon Fried <rfried.dev@gmail.com>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, Tom Rini <trini@konsulko.com>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Topic: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Index: AQHbd7boMg6OKeAhq0iRP9GJxZu6mLNPHACAgADetAA=
Date: Thu, 20 Feb 2025 08:54:43 +0000
Message-ID: <f5074534-b565-460d-9943-6493174db3f9@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <CALeDE9M1gvJ1Z=vNr345V35QjgfGU_Q2Wki5dMF-zAqY-ko=BQ@mail.gmail.com>
In-Reply-To: <CALeDE9M1gvJ1Z=vNr345V35QjgfGU_Q2Wki5dMF-zAqY-ko=BQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|PAWPR03MB9129:EE_
x-ms-office365-filtering-correlation-id: 6c540f37-a1ef-47ff-ebdf-08dd518c3817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?am03VUcvQjRWSjdETDdvSzZ6RitmTVFPUzZVRWE0c0lwM0dVQ2dQVVliUlhI?=
 =?utf-8?B?OElqQi80T0M2bFMzVlc0N0F0YjJ4WWpOaFVmaXlGR1J6eGJ1ZWlNaEQ3RDRo?=
 =?utf-8?B?Uks3N1NtMmxUNTZCNTVmYlkyMkJ4dmNKZktuZ0tvR0xLTlhEcHNYaTA0citP?=
 =?utf-8?B?cS9NV2o5TFJmZEpBU2o5T2w3ZmNSa1JPOWhCNWI5ODVBdStWMmNYY2FHRHlh?=
 =?utf-8?B?ZEdmVWVhYktqWnF6dVQ3UnV3akNkWGxPZ3paYWR4a0svcWJXVDlFTklFSStt?=
 =?utf-8?B?S2ladnBTemRkajBxanJsSHpKN1pnWGZrdWxWMG1HUkViL3NJUkJ5bW1lTmZz?=
 =?utf-8?B?SmpLMFhsalV6MnZ5NHVza3djSE1HOVMrV3dUQk5Ma09SUWlVSmdiV0NwTnND?=
 =?utf-8?B?ZnNHaExVNE0zbjZnQjJ4UEFWZHVicHpFcVlSTk11OUs0dk9LamtidFhPL0dQ?=
 =?utf-8?B?UjNyNEpBc3RnanU1ejB4UXJ6cVF2OUdjS2JQWXhwOUhpb2xRMnhiaElWYkhp?=
 =?utf-8?B?YUU2Lyt0Z1VhbHRnNlY2R3VIUERjaS93MWpocUVxSzAxNlg1cWFVNlRsN3Zq?=
 =?utf-8?B?alB2ZGlxTGMvY0hoLzBCSEt2VlJNUHVMSndLS3ozY3RHWGlLZ25oSWVVOXdW?=
 =?utf-8?B?REZsU2dXc05RRE9SdWhuU0d4UmdaUDRDcnozbEE5bjU5WWNLRi9WQ3Q0aTlh?=
 =?utf-8?B?WVE5OVE2U25Wc2dLMTViVmpzdnF0WnJqUEdqNWJtK2RuOElNYlE2Z1FwUzNq?=
 =?utf-8?B?aWRkZ2xkUm5DYmtLU0RwanhHNFgrY3BaTVNIK3Z1dzg4OWlQZG8wcFlDekRQ?=
 =?utf-8?B?NmJLT0NXUFlyR2xady8zMUc5RjlMQkxnbi81ZGVaQit6RWtNOGJOWkFmVWFC?=
 =?utf-8?B?NzFKR1hSUUxkUVJia1cwVmJIT2xBVk5xRjRCcEdxaHBRQlVOVlVHSEx0bkM2?=
 =?utf-8?B?TEFoNFBFT202cWpUNTJyRXVUcGRGNWdDaUljYXRzZW54djdDOFdNdDJvQnZS?=
 =?utf-8?B?VzZteFUzYjRlbUhBL1E5NENvNW1qY2cydzlHZkhHc1FjV2xxQUhUVk9aRWxv?=
 =?utf-8?B?S1lXMHpMNlU1T0hiRkY5VUQ0TkFTZUg3L2FoV1ZNblVRMyt5a0FDa0lHUWc1?=
 =?utf-8?B?UjJlQ1dKZjhENkl1akxiZFJiZjFzSEE0bXVLcmpmQ0xyOVJuSmJVcVdHcGFu?=
 =?utf-8?B?d2x0WnZ1RGtwN0h2K0h1V0V4M2VCQThTZ2xYNnNUTmRLb2llWkRXVC8zbEtY?=
 =?utf-8?B?bmdoZDFGVjBIcUdkb0VyYjZydmthS3ZEbDRDWStYeHBWOXJyS2cvaTNRTUdY?=
 =?utf-8?B?RkZkUEQ0YXpmbUwzS1JjOXZmbWtRa1NhRUllaGdvSGVMWDRuSE1RdjQ2TVpn?=
 =?utf-8?B?TVVFQmZaMWNuWk5ld0pwT3dtdVJJK3lyczQxaHNRS1pFTTJJY2U1dFQvY3hl?=
 =?utf-8?B?UGJuSzlBVVN6Mk5JMUE5YjlVSk9maXhkQmxTZTJPTm1YcmM3T3JDMnJBMkNW?=
 =?utf-8?B?ZklJTGQ1MXFONkUwWUdKN25vcUp4L3JJdmtRQ0xRQ0ZSQk5ONlhUZ2hLa2hv?=
 =?utf-8?B?a0EvcERncGRMYXVZSTdEakRCS2ZFMWxtRzhYOTNaVXJEL2x0bEVxMGMxR3R1?=
 =?utf-8?B?a1JVS2RmUW0yVlBDTThWN0VON2J5RzlBM3JHVzlwaS85TUIxUFpIVjROMkdo?=
 =?utf-8?B?Uk9ZU1RxbzBZdC9Xb1JUN0huY3k2ZnlsWHZQVW03Q1JTOHFmbVhTL1RjLy9o?=
 =?utf-8?B?L1ExNmNvZVZaZkpxWThxdFcxaXhtaWo5ekNBRGhnTFNONms3MzhmMU9sbWNW?=
 =?utf-8?B?TVg3UjhTSFpvaU96KzduRG92V24vYURPbDFFTzVpZzhYai9iS25FQWVBMlQx?=
 =?utf-8?B?UEJwdGZVWm41d1REd1RLL3dnZWV3TG16SUhOdEZONzErT2pyTC8xazF4UWc2?=
 =?utf-8?Q?WNdr50E2BbpDnAzbBot97vv+F+oSOziZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0VxWXpZK2dQbXdvRHdMRytKQWFrVkFvT0pHVmxYektjdU5UaHErTkdnK1lU?=
 =?utf-8?B?Y290SXBqWFZoOFFHc3piTkJZZFNDU3g2WEtHUlgvSkhFRDhhamh2WFkxRUE2?=
 =?utf-8?B?T3YzbFdUN1hGbnBuUDFCUEE4aUJnekhJMmFlYS94VDd3cldSK20xaUcwdlhG?=
 =?utf-8?B?RXAwY0NNOVd4TUNLekVFM0FPRHNpa3ZQNHBpRzd3RThkMm9KOEt3R2dBWENi?=
 =?utf-8?B?Z2JaeFdtbTBxTC95NFEyd2pkM0U2dTlkWGxpTlltd3FpT3lzLzc3enBiVUV2?=
 =?utf-8?B?NjVISlpwci9jeTNPdkkvZHN2YmlxMjc3NnBvN2JxYkVNQ1d6eUtDUjl2bS9y?=
 =?utf-8?B?MWw1MGZxdUNtYVZsVHcxcUZmcWZkbHo5NkdQQUw4WE9tVDVpWkNLc1VmQjBG?=
 =?utf-8?B?VzE3SXN0Sk5tWEtTb1JyTzhxM3Z0SWQzWGxocmF4clF4R0ZqK05GNkpndVJ0?=
 =?utf-8?B?NW1WTFk4NTgyejJxaS9VWWlrSmJrdjYwanh6V1JrQTQrTUVHT0E0NHYrRnA1?=
 =?utf-8?B?V0VMN1l1eThaKzN0MkdoM3JyN2pFNmt4bEhtRy93UDhVVnNmV2tLRXRabkM1?=
 =?utf-8?B?UXlzeXZvRVpvclRXWDJ4VmhHWGdFN0gwazVOeDJsTDlDcDRwK0dYRCtqenlO?=
 =?utf-8?B?aS8ycFlSbjdpKzVBYTMzS3Q0aUxqMVg5KzZubFFaQWEzRUZpbVY3VVhZNzR5?=
 =?utf-8?B?eG8rcFhadCtkSUIvem1aYmVEaHZ2WVE3cmZPcG4xclg5QmRXcmR6bXozTDFV?=
 =?utf-8?B?U013eVFKTHVVbS9lWDEvVjdRbUZMci9uVk8rb2hnMVZhb2FlVmNhblhZSkdG?=
 =?utf-8?B?N3gvM1paYklhdmhNUWRGUmJuVFRzMldCWEZkMWlNQzNVWktwYkxNUDFkNHZj?=
 =?utf-8?B?VWZKK2t6YnYya05ZNkV6TC9Ea2h6MnE4c0NzWU9TRDN4TnpORHQ5T3FmdU5o?=
 =?utf-8?B?c3locVJyVXVNaFkrNURCK1E2dDF0MU4vL3NYYW1vb25vVFdDY2w4ZE0wM05L?=
 =?utf-8?B?aVFUVHNrZFNsazM5WnNjelBqZTRJOGhXZlg5MnUwWXpBL0RRWmJyRVJIUTFM?=
 =?utf-8?B?TW9TczlJT1RWNUgzSDRUczlHWXN1NG9uNTNrVGxoVWdLR1ZobDFXU0sxaVlE?=
 =?utf-8?B?Y1I3RmFuOWtzNmdwWUxrK2c3Ti83aTgvbUFOVldNbVhVQ1kxWW51VitwYy82?=
 =?utf-8?B?NUxHdXZaQ0tpRnFPQ2JZZFRaY0dqRGhhMkFDVEdFMUZSc21KL3ppVjZ1SXV2?=
 =?utf-8?B?Qk1kd3BRVTgrdlJSNjQwa2MwYjZwYXovYk9ySGl5T0xtSE4vMGhWTEFyR1FO?=
 =?utf-8?B?NnZLY1pvdzBZa3V3Z0tqd0JscGxXdFNLSlJiK2dna2tCejVCK211WjNIUlRj?=
 =?utf-8?B?MFRjQmphV3dYMUhGZVFjRU5MRnhhc01pYmIxRis2VXMxNkxvM1V6MUsrZFN5?=
 =?utf-8?B?dFJwczRYb3FoTTM5Y0xYdXNPaTNMMVEzQVVjREY3VkdLcG9xMmgvcDJRR1BN?=
 =?utf-8?B?YUNBOUlIMklTVjh0ZzZzOXN1NmZFbllKVEVZdWl5SGdYSnJodjcydGJ1eXN2?=
 =?utf-8?B?MUFZZytxanpQQUhBTFUvcXQ1ZnNzbEZkOUVqK2dqWjR5Ri93d2Fka2paTHhV?=
 =?utf-8?B?Zkh0OCt6VnhBOGVTTHRlNTNlQ21CQktnTWVTYmVqNUd4enlWWmlrZmVLQ1VQ?=
 =?utf-8?B?Vmt1SWZVRU1JK1A4NVNhbFo3NWFZdGZvZGZIVEw4OTV5aFNWeWZoZ3BjOStn?=
 =?utf-8?B?bExIUXZESE1yZjQzcGNrNCtqcURmd1RlRUpmOHlKUng0MnlXNFAvbmNmbjhH?=
 =?utf-8?B?OURMV2tKdmFUMlRobDBWaGJwRklBK0IzaTdOY1dORnQxTzl4VXF6NWhjSHNo?=
 =?utf-8?B?cExST0hIbnliU3ZIM0FEaFhNTlJGek1paU5kTWpDSDBpd2F4MlQyODUvMjhw?=
 =?utf-8?B?UUY4T3R4UDhPOTN5N1Y0OHFBMU5hUWd1M3luRXFCZjlaWVNxUk0rc2VXREFI?=
 =?utf-8?B?SUFOU0RMMEI3ODhaenVkVVpFUE1LZ2VkQzJYWEpqNnVrUEhpNGNJaXdaZ0Zh?=
 =?utf-8?B?TXJTaUw3ZjV4WUJVWHJQNU9CUE5uaHVVbGtydk9kUVFmTXFOK2szL1k1Q3NB?=
 =?utf-8?B?d1BjY0NJRUZPWkJrT1dQcHlLeGsyS0E0Rlh0K3BRZDMvVGVEYWFEQmNsRzlM?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA1E9FD2F8416F4597041DD335012851@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c540f37-a1ef-47ff-ebdf-08dd518c3817
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:54:43.4490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fyn7jcx13UUwNbysUMvTlEmgO6DyI0I5Hsnr+M+ZVgPZmm263nufMJDR28IOx7DpXEF9FWQu6aukUJ+GaKwdwk9jzrF0SngRQntlIOaLcZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9129
X-Mailman-Approved-At: Thu, 20 Feb 2025 14:50:09 +0100
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

SGkgUGV0ZXIsDQoNCk9uIDE5LzAyLzIwMjUgMjE6MzcsIFBldGVyIFJvYmluc29uIHdyb3RlOg0K
PiBIaSBPbGVrc2lpLA0KPg0KPiBJJ3ZlIHN0YXJ0ZWQgdG8gbG9vayBhdCB0aGlzLg0KPg0KPiBP
biBXZWQsIDUgRmViIDIwMjUgYXQgMTA6MTUsIE9sZWtzaWkgTW9pc2llaWV2IA0KPiA8T2xla3Np
aV9Nb2lzaWVpZXZAZXBhbS5jb20+IHdyb3RlOg0KPg0KPiAgICAgVGhpcyBwYXRjaCBzZXJpZXMg
cHJvdmlkZXMgZ2VuZXJpYyBzdXBwb3J0IGZvciBSYXNwYmVycnkgUEkgNSBpbg0KPiAgICAgVS1C
b290IHdpdGggYWRkaXRpb25hbCBoYXJkd2FyZSBkcml2ZXJzLg0KPiAgICAgVGhlIGZvbGxvd2lu
ZyBmZWF0dXJlcyB3ZXJlIGltcGxlbWVudGVkOg0KPiAgICAgMSkgYWRkIGdlbmVyaWMgYm9hcmQg
Y29uZmlnIGZvciBSYXNwYmVycnkgUEk1IGluY2x1ZGluZyBkZXZpY2UtdHJlZQ0KPiAgICAgZmls
ZXM7DQo+DQo+DQo+IFdlIGFscmVhZHkgaGF2ZSBiYXNpYyBzdXBwb3J0IGZvciB0aGUgUlBpNSBz
aW5jZSBKYW4gbGFzdCB5ZWFyLCB5b3UgDQo+IGNhbiBzZWUgdGhlIHBhdGNoZXMgWzFdLiBUaGlz
IHNlcmlvdXMgc2hvdWxkIGJ1aWxkIG9uIHRoYXQgcmF0aGVyIHRoYW4gDQo+IGFkZCBuZXcgZHVw
bGljYXRlZCBiaXRzLiBJdCBzdXBwb3J0cyBiYXNpYyBzZXJpYWwgYW5kIG1TRCBzdXBwb3J0Lg0K
DQpUaGFua3MgbWVudGlvbmluZy4gSSB3aWxsIGRvIGZ1bGwgcmViYXNlIGFmdGVyIHVwc3RyZWFt
aW5nIG9mIHRoZSANCmR0LWJpbmRpbmdzIHRvIHRoZSBMaW51eCBLZXJuZWwuDQoNCk9sZWtzaWkN
Cg==
