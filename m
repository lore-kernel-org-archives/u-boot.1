Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298D9E6E80E
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 11:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 878538405A;
	Tue,  3 Feb 2026 12:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="mHoSXCOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5DA184082; Tue,  3 Feb 2026 12:29:23 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5788401A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 12:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niB2GEUx2qYqrqkqk4fZfE1JVHhz1F99rsWuIBFec+b0ItNyaGsheAcASFkJvXbCOOWhNf1BRcdZWvbAczzaPe+z5TU/ovIjJt0kt+nXZ7oyZI4awNbMx4gK/SM4v76Z7Cdtdj7OodX/tKAUmaYXumanF/wnaVdeAVGNFxK8SMcftRJZmclI7DqtubYQMAgjwKffLJTjBVMloD5nT9xsA7NV6+XnGtqWBwA+DWYWujD9kQh4ggMVOTLRrLugQddxQWXi27gatz7kvqsNsJ1fq6okGbtwY35UBLjJoC/inKBzpxqIcOsWUxPHdFBY8uRqfGr/lQymzNkUlLmAIQ0qDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNnAA9+UrQmf30lU5tefAnOzhrNvGQ/yCgT2ypzVsJg=;
 b=HmzXHJTiLJQskhmOMvR12sLXDd0gdxQqmdB4xkKdMpkhj6z7/acKQwmJaIq1WbP5NSYECQbQgaJyx2InjEjwkYSpFH6ttn/7szEfi3JPcWCHp17vU8fQbIi0eML5i7+ODxqUXITJRZMwyw9nGu+WJZ5hx66AyjRL6bBwt7Wd1hMZz3fs/9cUexBBQAy8BOZ2GPWA/e+HYMDMK9b3U0Qwm/xPBjd/iY6vAIQ/zQ5nX/i6im+t3pTm9eB3nf2lcLkywV3XGol5LV4UOrNvq18ywkRIvp2Gy15Z6073uh/+ZGy5EDMc7aoPfw34u0tETnX5Pm49RQxKPMMKoqcS7i2dhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=amd.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNnAA9+UrQmf30lU5tefAnOzhrNvGQ/yCgT2ypzVsJg=;
 b=mHoSXCOLTpUVjzZO2P7v869/M2ZVqfntKftsjHMfokVJg775eEoSTnlpx1ba+XVyAndXc/LW7HlTGUnkLZyKBsYXVBLrnj/rALwCuxyhwvtFrWdLxZ4Y0x4AAVGTCM2bQAQ5apyy8aer4vvAxhgEIItE6uzSaUD8bLFg5O9ezZ0VkD2bIq9l8KMyawNC1TmFSTCjX3oSe5PJNRIGAiI3RZcv0cPevUuf9KnuIO7npbWdFQJb7a0tLWP4pAvpAA3OcxOxdmTkJswDPY2+PToJ4q0r6RKekoxU0u7ZC+CEnihRFPhJ8xCtEhf3G3H1WlPR2hvPvcRETlbI3Nh08htmFA==
Received: from DUZPR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::18) by AM9PR05MB8874.eurprd05.prod.outlook.com
 (2603:10a6:20b:439::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:29:16 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::6c) by DUZPR01CA0087.outlook.office365.com
 (2603:10a6:10:46a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 11:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 11:29:15 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (40.93.214.100) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 03 Feb 2026 11:29:15 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by AS8PR05MB8803.eurprd05.prod.outlook.com
 (2603:10a6:20b:422::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 11:29:12 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 11:29:11 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Michal Simek <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH v6 2/3] efi_var: Unify read/write access helper function
Thread-Topic: [PATCH v6 2/3] efi_var: Unify read/write access helper function
Thread-Index: AQHclOLkYyKAED+Uf0qJQQr2tyvVkbVwuLEwgAAIHACAAA7A0A==
Date: Tue, 3 Feb 2026 11:29:11 +0000
Message-ID: <GV2PR05MB1194157700C5D0ABCF1578C64839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <cover.1770105470.git.michal.simek@amd.com>
 <620c169fb271be3ca6de3e8aea498fba7aa36d99.1770105470.git.michal.simek@amd.com>
 <GV2PR05MB11941E99EBCEFBB6D8F523E6F839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <92c5c4f6-05fd-4c65-be43-b5125030cacb@amd.com>
In-Reply-To: <92c5c4f6-05fd-4c65-be43-b5125030cacb@amd.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|AS8PR05MB8803:EE_|DB1PEPF000509F4:EE_|AM9PR05MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fadf82-b06d-41f1-246b-08de631776a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?MGtVZVI0N2l2Y1EwZjFta1FYd1FCdS9HT3Bkem5SR2tldTBrSTRPb0NJYjVF?=
 =?utf-8?B?NWEzN240R09pQkt3UTVTd3JmRTlYeVNOV1JYOFU5RXE2czdMSk1lczFsRm5R?=
 =?utf-8?B?WjZpZi9QZlV6Ryt6TVlmLzE1NjNvYUFCYzBJaXphR0FGc3ZlT0tpY1dUbUVM?=
 =?utf-8?B?MEpSeThQSjJGZTl0RHdDR3NZaEVmTlp2OVJJOVIrVEhqclVLYlcvRnV6RENN?=
 =?utf-8?B?MG9RSlhCdXE3MkZYQ3REMll4cmluaXFqdFpXMVkyUDFxSGp2Wjk5Zjl4dDRV?=
 =?utf-8?B?bmxjQW92WldEandqN0x6QlV2Y2pNNkV3UTBrOGVEVmNYZVBOa1Z1anZ4V1Av?=
 =?utf-8?B?b2ZXamkyMnFDTnpTSGpEL0Fsd2pXVkx5ZFF3Z1BBb0swRDZVVUNSSGxIN0Vn?=
 =?utf-8?B?dFRPS1o5REhjVnp2NTFxQnhGbVJTYlRRUWM5ZFVEMnNjM0VJYmx4QUdPTXRW?=
 =?utf-8?B?NTc1WWo5ZmR5R21YQkdMbEE0MmVkWVlXR3hod2s1a1cramhnRDNCQnZROHA3?=
 =?utf-8?B?ZTZPQXVmQ0xjM1NUaHNrTmcwUjYvR256WGpJdjVQeUdzQmhhYkRXY0paa3hr?=
 =?utf-8?B?QmxITVNYYjlkdmJ1bTJvNTBnbE1oejcwRkQ5Z0c2ZXNuNXBYeWFwSU5PcEtw?=
 =?utf-8?B?aDNJYjFqWGhMVWtseWdLMnFXeHBzU1BIbTkwazMxSnlXWjd3WTVVQlBLTzZG?=
 =?utf-8?B?UE1XbCtOWXlpQnJkdmVWbzRndit4aER6OS9FRldaSHVMUmh6Q0hNOEhvbnA3?=
 =?utf-8?B?VExUN3FlZkVkMDVPWVhrempWQXVwSmEvTDluaEZZc0dWcnpFVjVTSTR6V0dO?=
 =?utf-8?B?S3EzOGJxQ0kxMy9TclNnVnFIK1N4NHdEM1Y1NlVQWlVlT2FhY3psNlNBRDFq?=
 =?utf-8?B?ZklGRGhiQjdheE9EdkpBeXRxeEZ5REh4dE9RWDl4ME5QQ2JObEpXcWJlQjZu?=
 =?utf-8?B?ODZYSFpqUzBZSnc4dHhVTmoveG4wL3NuaHBJN0MxdHpjMkdWRURzRkpSYldp?=
 =?utf-8?B?M2g4RFlObTc0MCtWZk05WkhDOVJwMmNkU0tQNHZtd3hRSnNrMUU4RmZDWGMv?=
 =?utf-8?B?NjhXckFmTDhUSThyK203YmE5ak1hb3FkMFljajZoUGZYcWk4bE9UT3lDTTB0?=
 =?utf-8?B?YXNSTVRnREZmRkljT09maUNETmFlMXZPWldJL0dhMG5PSEgwNUN1YkZvUUxx?=
 =?utf-8?B?WGZMYUlrY0YyUkRlSC9mSGtPQkpYTHJxeXdhUVl3aE5tL1lMNGdnOGpXL0N3?=
 =?utf-8?B?aWFFOW1NSnhUOXNVeWpGckU5U2hNbUFlczJEY3JMa3o0S2RQZnQrY0RrbjA5?=
 =?utf-8?B?cW1sdHRuNjFPclBSSVplT3R2VEF0SEFTV3pVRDQ3UHgybENLdVJvUy9Ma2ZE?=
 =?utf-8?B?MDY5YXF2dHVFWU1kUjhhOW0vdVdNTDB1UGdTVDd0czlXQXdIU3BSNXg0dlha?=
 =?utf-8?B?V3liTDllNFQ1MHFMMnBxRThzTnJlc256T1ZHVStWZ2JKMFhDTzNxcWRJVEdy?=
 =?utf-8?B?RHJDRlE4cUk3cW16L2o1b3dVYWdpQ1NhNXdkdmVKRlozT0QxVnMwY1p6SzRJ?=
 =?utf-8?B?MmFVY25FRUpqSHhGK1hEZ2w3R0dqYzRBdmxNcEJnWVQwdUxRWEJvOVpFNXJF?=
 =?utf-8?B?ZVRPMERyK0dFNXNEZTcxL0Y4SUYyNEdpZUdKYmZBVGxSOC9wNHVlbUtDbTJk?=
 =?utf-8?B?Tk9TUmdZM3N5bXhKNnYzUElzbVF2UFJKSXFzVmxLck15b3JUZ0VrTWNNbWdN?=
 =?utf-8?B?S0lnRWlkTU5FaHVvb2RNQ1lNckdrRGxMbWRLT2xFWWx5djFuK1JHZ2kvQUF0?=
 =?utf-8?B?c1NVeE13UnFEN2E2UTNDdW02d0xWNTF2QWMyVCtwamttRUp1WmF3QjdRT01E?=
 =?utf-8?B?ZEJpTHYwanpNZEIyVXl6VENZQUF6NUlSb05yTXM2TTdBTTh2L1p1S0Jadm9O?=
 =?utf-8?B?TkdGVFprWTdDQmdJeTFZNTlVZFovQ1BKQnNGYm5ER2k0akZWejFpMkJSU0s5?=
 =?utf-8?B?ekxmdnBmVTg2aXpzZGE5RkxhWVZURThPUTVRRGphMjFBdTVlRDJNUVdzVXF4?=
 =?utf-8?B?VFJQb296Z3RQSnJmaXB4NU5pb29oRS82a3E5YmJJZ0pBSkhHL0RYRGJSRzlS?=
 =?utf-8?B?QTJpZUE1SnlYVUhYbmVSa25OMTVCUzNQNWZPczZCbkljcUROVnlKRTF2Z2dm?=
 =?utf-8?Q?m0879CiUfilYaMAI9wp3Sr4=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB8803
X-CodeTwo-MessageID: 05764501-f62e-43e2-8971-45e88a43ae07.20260203112915@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5bbabf56-01d4-45bf-c3e2-08de631773f3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|36860700013|35042699022|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aE50eERNVjRJNnlpTmVlV0FLaFhYTXVRcDQwOUFWU0JJU3I5K1J5cTJjMHND?=
 =?utf-8?B?MXZrZnBFTVptSWhsWmJUUWlsUVBDSHNRbFBaQnJ6ZVZKRC9VNmRmOUs2Y0tQ?=
 =?utf-8?B?QnRnQm1mdHRhc1VlNkQzL1BOSnJQSng1UWhZbzZuWXZnWW1LVmNYelRGK3ZS?=
 =?utf-8?B?S20vOHRBbzdOMDQ0c0VZV0drMGZMRmlHTEFRTTZLMTdMZ2VBTlBZdzMwS1hk?=
 =?utf-8?B?aW9VY3JqbytmYWFUVWh3eWV0NTlhaHpPb3B1OFJuazFLVXdPcSttb2hDT0JW?=
 =?utf-8?B?MUxhUHY1cVNXQTBqZW5KMUw2bVFVVitBYnE2RkhTZENVdHhmSTJxV1ZQOXZ3?=
 =?utf-8?B?eFVmV2RZMWhtdmJzTm13TFNlL1krOTByWnk4VU0xMUI4TGl5ZWdQSXk3Vjli?=
 =?utf-8?B?WnIwcmdNNXhxVUc4b0JiV2NsSE1acnl4WE84OWUyMmtjOGYvaXFZNWxEMkJU?=
 =?utf-8?B?cERjcnNzRU8zK0ZUN2RsOFFZZW5YUERKaXY1dWRXZ2RRNEZadVpVUFlDcXpa?=
 =?utf-8?B?b3VQVjd4TGdrZW1NenN5M1RkaDJDWUFvd3phdzJIYWJldkdpWTVsa0xvdWNl?=
 =?utf-8?B?RTVxLzloajVhSnlXeVJIY0JQT3BSVXdGMUw1Q1NZTGdKTkVwQjRuT3p2UE1Q?=
 =?utf-8?B?bmh4bmh3T0NUUmJFNmROS0x0cVlqTTlKemovbFNvNU5nYTJQbkVRaTFoNHhB?=
 =?utf-8?B?b0srZUdXdHI0ZjI3MlgxMmpacnVhS1FOS05rcVNUN2dudnRnRVk5QVhrZTMy?=
 =?utf-8?B?VUtlaEZjOGJBdjFSOUV6OXZtUW4yOElHTkVZS0ROWU9XWG91Zy9RLzdDQS9i?=
 =?utf-8?B?U0JJYUFKQ1NSTEM0NmkwaDFGMTVadVNRNEttVlBlQjRNQUVTTmhnU2M1WHA0?=
 =?utf-8?B?OWRJVDFSSm1PMnVXa3dMRmdEdU5wQVVna2RFYmdqcytUWXRkQ1l3NDRpREVT?=
 =?utf-8?B?VGpvSWJyQ0RpQVpxazUyclV4QWFybkRNRFErMUc5UTBoMC9MRU9qNkFtZ0F4?=
 =?utf-8?B?WGF4WDd2OU9sblMvbXhPT2k1c3FQdWw0bkx4UUtKaGthU203MWo5SDdCUHJk?=
 =?utf-8?B?ZDVybmorcFUrNUVVN25ZK1d5b0lnRXZNaHV6VEFRVUdUZGxETWlRME4rbWgw?=
 =?utf-8?B?Tk53aHJpR3VmL1ZuU1djQnF4czI2ek9lMWdyMGxkSlBYMkF5RVA5WEtyMXhV?=
 =?utf-8?B?YndGb2xOSmFMdU5paDRCTk55K1k4ckVCYXBVcW9VZ2ZweFFxS09EYmpOVWpU?=
 =?utf-8?B?RjZCKzN1ekE5endrcC9pZ2dZZDZwL1FBdjA5bEhQa2lRYW1hRmtvT3pJbEFn?=
 =?utf-8?B?ZmdWaVFlYmwreitvS3prTjAzdGplZGgwTmZiSTF1R25zVVJLc2RuTXVSTTIz?=
 =?utf-8?B?TW4xRGFIVnpBL2ZPUmVtYXhyTFVGWlZhYVpBV1ZkRkZxdmZpZ1VxTE56ZXA5?=
 =?utf-8?B?dGQ3dFM2R2hGWUhWT0xxQVVGTGRrQ2N2aEd2eDdIR3FHNm9rT1IxMEF2VUdw?=
 =?utf-8?B?aXZvUVVNNGczUWNhWDczK3pRNUFUNU5ud3ZuSXB5VU93Qkh0SE42d3IyTUxu?=
 =?utf-8?B?R20vKytJNm1aRGt2QnN0STdHZjk5QS9wQkwzVzZHbWx0cUQvclNBMHBHU3l4?=
 =?utf-8?B?clBtSUVRUlErY3NiOXFidWhDZG90djhrckNhWFRGRGVtNk8zN3FFbXQzWnRW?=
 =?utf-8?B?aXBGcVpQeE9JRldzZy9nVnBSZGs2c1VBWm8vVjFXVm1uWGNhSkxTbDQwcmpn?=
 =?utf-8?B?ak5ETEdaYXJsOURJcTRqZzc5bUEwb0pTY0dSVW80V2pEYjZ4ek5tQlVZSjZG?=
 =?utf-8?B?TER2dVlPVDgwU3M4T21IOEVHdkF3Undua2E0ZkhWVkUxcG9EdVhWZGdXZVgw?=
 =?utf-8?B?ckF3SCtKYVRla2ZVZHFKTkhOeDZHbkVTQXhtNmQ1MzFtRXY4YVgwck01eVY0?=
 =?utf-8?B?aWJ4ZjlraDRIcVQ2cys1c2hIUElQdEloRUdsdXpLNlhSZ2ZTTUtIVDZ5ajhw?=
 =?utf-8?B?QVdiYzFNbEIxTFFDSVhUZnpMdmYrbkFqeUVYREJvcXBVbGFVVEFLaGJWRDZi?=
 =?utf-8?B?MnJRcDQ1WU9WTW91QUx2eWpWSWk4TVJaS0tQdWpRUWkyWVBPZEh4YVREVHpo?=
 =?utf-8?B?TDhGYW1CYzVINjV4R3V4Zi9KQ0NIMGcvdUFiUnB3Y1pIWDU1U1ZaTU9sVUhM?=
 =?utf-8?B?YW5xcDR4REZjQVFHbzl6M1FjVHRZbEs5M0JvS0Vzc0ptN0xnaUJ0K3YrMkpq?=
 =?utf-8?B?cGlwUk9PSGx6U0NqdGRnbG9nbDNBPT0=?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(36860700013)(35042699022)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yWdEDsYg+aX3oMy0En2qcP5XURTrXW6/j9RVkDacxe7Wvth1g2tLH4r/jEwETQOH6RSMVMs9yNoZbfoZu7LCgc9bopDGS2KvU81istRTnzW00hVtMvnE1iPGUqpOz0JSuCSSXSPQCOWdU7q99dQxG3x3nn7p/xCw29AQNqaolxDPz/G1PWoXLLI7aIRcwtv+cR6mla3W1//SnMD7XSKtMRp2EbYe8ZF4g/tWI1k3jTdHU88LkkEv1cYUFDDRcLO1liVCnktxYKvgHIB3ExXtF2NnN4lD5KSFPTYxqU/m+CcVuqhYoWcE/MoOrQWjgTJM3kSNbUhCrI7RJ745z2zOVCSsYx/9ezOnzgz41S62MpLoqOy+/G0/GCfAIy4VL1Azwpmf7uz1aH3cTUb8aTmYNQNzjy8qHoyiInl5ix4Q/2nB4v3BNWSzI84KCndol2/R
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:29:15.8130 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fadf82-b06d-41f1-246b-08de631776a9
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB8874
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWwgU2ltZWsgPG1pY2hh
bC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5IDMgRmVicnVhcnkgMjAyNiAxMToxMA0K
PiBUbzogTWFhcnRlbiBCcm9jayA8TWFhcnRlbi5Ccm9ja0BzdHRscy5ubD47IHUtYm9vdEBsaXN0
cy5kZW54LmRlOw0KPiBnaXRAYW1kLmNvbQ0KPiBDYzogSWxpYXMgQXBhbG9kaW1hcyA8aWxpYXMu
YXBhbG9kaW1hc0BsaW5hcm8ub3JnPjsgSGVpbnJpY2ggU2NodWNoYXJkdA0KPiA8eHlwcm9uLmds
cGtAZ214LmRlPjsgU2hhbnR1ciBSYXRob3JlIDxpQHNoYW50dXIuY29tPjsgVG9tIFJpbmkNCj4g
PHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAyLzNdIGVmaV92
YXI6IFVuaWZ5IHJlYWQvd3JpdGUgYWNjZXNzIGhlbHBlciBmdW5jdGlvbg0KPiANCj4gSGksDQo+
IA0KPiBPbiAyLzMvMjYgMTA6NDQsIE1hYXJ0ZW4gQnJvY2sgd3JvdGU6DQo+ID4gSGVsbG8gTWlj
aGFsLA0KPiA+DQo+ID4gV2h5IGFyZSB0aGUgbmV3IGZ1bmN0aW9uIG5hbWVzIG5vbi1zeW1tZXRy
aWNhbD8NCj4gPiBlZmlfdmFyX3RvX3N0b3JhZ2UgPC0+IGVmaV92YXJfZnJvbSAuLi4NCj4gDQo+
IElsaWFzIHdhcyBhc2tpbmcgYWJvdXQgdGhlc2UgbmFtZXMgaW4gdjUgcmV2aWV3Lg0KDQpJJ20g
c3VyZSBoZSBtZWFudCBzb21ldGhpbmcgZGlmZmVyZW50IGZyb20gd2hhdCB5b3UgaW1wbGVtZW50
ZWQuDQoNCj4gSSBhbSBvayB3aXRoIHRoaXMgd2l0aCBhIHNtYWxsIG5pdC4NCj4gQ2FuIHdlIHJl
bmFtZSBlZmlfdmFyX3JlYWQvd3JpdGUgdG8gZWZpX3Zhcl9mcm9tL3RvX3N0b3JhZ2U/IEkgd2Fu
dCB0bw0KPiBtYWtlIGl0IGNsZWFsZXIgd2hhdCB0aGVzZSBmdW5jdGlvbnMgYXJlIHVzZWQgZm9y
DQo+IA0KPiBXaXRoIHRoZSBjaGFuZ2VzIGFib3ZlDQo+IFJldmlld2VkLWJ5OiBJbGlhcyBBcGFs
b2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+DQoNCkkgdGhpbmsgSWxpYXMgbWVh
bnQgdG8gdXNlOg0KZWZpX3Zhcl9mcm9tX3N0b3JhZ2UgJiBlZmlfdmFyX3RvX3N0b3JhZ2UNCmFu
ZCBub3Q6DQplZmlfdmFyX2Zyb20gICAgICAgICAmIGVmaV92YXJfdG9fc3RvcmFnZQ0KDQo+IA0K
PiBUaGFua3MsDQo+IE1pY2hhbA0KDQpLaW5kIHJlZ2FyZHMsDQpNYWFydGVuDQo=
