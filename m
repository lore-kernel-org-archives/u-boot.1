Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB80E8306E
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 09:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3CFC8405A;
	Tue,  3 Feb 2026 10:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sttls.nl header.i=@sttls.nl header.b="PD0PnMmr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 324E084064; Tue,  3 Feb 2026 10:44:26 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8BD08404D
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 10:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Maarten.Brock@sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhzEQaBPh0s2LsLgR6lW187fRNAcQ5U8DBvJoQm38HKXXIhuZzT5H8VHnOuNX5jxVxRiM1dTUJpSDcAlkVCrFzF28fNWxzreKP48TQkZZ3Z08p7jBm/7E5YWOp+sHqrd7G8wBU22y7moWRVMpDXWWO0UzRjAFov/kEiwyqYqGRgv3J3QYzdjM59yOZ0lxoJ675LDY6y1N40LVlry0SUQXIAWo2CwSpHeICMeaHQlk2C15OfDBRbAoZt7Mwo0ZD3VktS09WjLQ2L0SAyr/A/8mvJfWbPBMoQVkxPju17UZ4KZ1NNvonlCt2CHmGHup78310vqPKT9uJnYOcn83oHwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xri1BVR4dRyP4Koa1TdpeIg2zV7CQa1/8FDHf4Ems8Q=;
 b=lgTyhp373VJwEJkcZrMptMaYJrttSs/B7wwqTvTsSmPv6waI95Z2ezecb14AAq/Rr7/nE7NQ/+A2cDNVfvtXj3FT5Ctx7wuaV60qG4lr9hMIGlKgwv4kD7pEjAkzoycNR/uSJHGv4WhMhxZofDqr1dbzn0UtnmoORkwO8KTJ+s9mnJyJJ2VNRifoa3qBlPFnPtqUgivhoaYnURfeEo+IMXM1lE9ByLJ2pWGPEMbRA/2uvnI+H+9c2xRJZAZBlqdtRu2wIyt15QHlW4aF/ZoNIVAWF0EW9PAw0epKXNrX88lh8O5u4/u9K8bzsrLFbUrJvzA5dYp3f3hTFq4FXu/tYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=amd.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xri1BVR4dRyP4Koa1TdpeIg2zV7CQa1/8FDHf4Ems8Q=;
 b=PD0PnMmrlkbwe/ylbAOCd2aoZZazX7xZ0IeqaIJc8BXns1XguzD/VemJ+TGIMY0iNANQsGCkJxYgK57wjRVe8Hue49z5UTQm2gtLwfvo0xcsKec8HbwgT5FKbvD2QTjLYStTROZaPTph/gXTDG4qo2R+nKoMUpWMvc2njppSj1jlEuBJ0P0Yay1qxHVOIpzPmYjexl2ks3xKPAWDUwnM/Tu7xNGjrbwShibYu9wUCE7AlvL0iuKYoBgwRMPEwcIFQMHo85FzOsFIUDRSekVg37FPq2SsgyhcjbFfZkvOlNvriF3AEhFatcNnV45AGS5p9M2+9P+GfnrHNiAk/0YR8w==
Received: from DUZPR01CA0259.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::7) by DUZPR05MB11093.eurprd05.prod.outlook.com
 (2603:10a6:10:4e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 09:44:20 +0000
Received: from DB1PEPF000509F3.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::30) by DUZPR01CA0259.outlook.office365.com
 (2603:10a6:10:4b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 09:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF000509F3.mail.protection.outlook.com (10.167.242.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 09:44:19 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.67) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Tue, 03 Feb 2026 09:44:18 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by DB9PR05MB9754.eurprd05.prod.outlook.com
 (2603:10a6:10:3c5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 09:44:16 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 09:44:15 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Michal Simek <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH v6 2/3] efi_var: Unify read/write access helper function
Thread-Topic: [PATCH v6 2/3] efi_var: Unify read/write access helper function
Thread-Index: AQHclOLkYyKAED+Uf0qJQQr2tyvVkbVwuLEw
Date: Tue, 3 Feb 2026 09:44:15 +0000
Message-ID: <GV2PR05MB11941E99EBCEFBB6D8F523E6F839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <cover.1770105470.git.michal.simek@amd.com>
 <620c169fb271be3ca6de3e8aea498fba7aa36d99.1770105470.git.michal.simek@amd.com>
In-Reply-To: <620c169fb271be3ca6de3e8aea498fba7aa36d99.1770105470.git.michal.simek@amd.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|DB9PR05MB9754:EE_|DB1PEPF000509F3:EE_|DUZPR05MB11093:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8d866c-6068-4b5e-77aa-08de6308cdf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?WnkweEk3QndtY3Rob0NQNFVFa2duZ0JiWSt2TDFpREpldG5MOUVhVDFLdFd4?=
 =?utf-8?B?dXNrbGJTdFRYTXRkU2hoYTlLQUpsY1FIUFlweWJEdWZrU1VDWHl2aS9hTkl1?=
 =?utf-8?B?eC9ncFhOSEJ2Y3VtMzl2TXdMazROL3YrT1VjNTljZUZ5WExNM0xBTXF6VzJK?=
 =?utf-8?B?dzFHNUZMU3E1Nmh0MzhqR0EyWGFlazBvRWxrZWlVbEtvamNsZWFVZmJsRFZE?=
 =?utf-8?B?SElyaVBNYmdidExHYU5YVjY1VHh6R2F5eFJRZ0M0aDdaSXc0ZVVqQlZDdkJr?=
 =?utf-8?B?UURjbkpVakltVzdxdHIxdUFuY1dBdmxTRytnYU1ndHJwMUI0QW9sQjhTTVpS?=
 =?utf-8?B?VE5YSjNxYzBod0l3M1VXVVFTMnNud1BXMm15VE1ua3NzZk1uUmtCUW5zcXlW?=
 =?utf-8?B?U1FyOXdKZ1NESkUzMUIvNkVYNUNBWUtIdzUzbE91UzRJbG1rbU1KRmRaR29L?=
 =?utf-8?B?cUxuSmI1ME1TOEhqelZsWHowVWJGMDVnWXBJNVl4eEJIcnJYOWdPTjRXL1ZB?=
 =?utf-8?B?WFZFdzFQZXZQdU1sbEZpTlUvY044ZTdDZGVkV1NrWkhSQVZBOHBpajBrOFYv?=
 =?utf-8?B?NnFkRGpXKzRXdXJPckFyVnJhUXQ0d2JlUE01bHNvK0NabVdqQ1hGcFV0Sllt?=
 =?utf-8?B?dzNETkRtWDFxYStZRWUyQTU0bThhMkdDK3hSZ1FlS0J0VHlmdjZITGNMdjZ0?=
 =?utf-8?B?NHlLUEl6Rnl0cFRpVmgvU21VbzhSVUZmRmtSUlNCV053RCtIY0gyZFUxZEx6?=
 =?utf-8?B?MXFnd1NOOWZHdmpOanBZZVRLSkNqeE1NR2hDL3ZkVG1kSFBJeDgrK2dZRVpN?=
 =?utf-8?B?aS81alNUNFJTd3lGVXFDZEcwMytIUFZQVUJyY01TQ3FwTmxNWnhlT3kvVGlT?=
 =?utf-8?B?dG1qaVdseE93clhvMFdnRWZ5QnhCbjAyNklIUXJtQSt3dG5kc1RPajY2Yy8r?=
 =?utf-8?B?ZjROWk9JMXdQM2huT3VxVXpISi94ZHQwOXExbGlWSWN0Y2M1MGxnNk80akZk?=
 =?utf-8?B?Wk00UC9ydzIyWGsrVUx5U3hxbUR6S0pobkJpYTdubGdFYWZiUmFDaG5qZElL?=
 =?utf-8?B?L2YxRmlCaDBDajAwZDlHd2ZtNFZDV28reGJiNm1Pam0xdHF1eXBZRUU1VXk2?=
 =?utf-8?B?VGRKMFZJYm0xb2N6Q3Y5N01UU29HdG5CTStIc1JCYVZiYllpb3BmWm04d3VV?=
 =?utf-8?B?d2tHZjduYlNnQzNoeUFaUXJyWC81RXpQZUlaQ3VCelhjSFY3Ymk3TWtiVmZU?=
 =?utf-8?B?VUszdHBRcVNuVUhvN3RIeU1CcHFkODBWdlkxZHE2cmlvdDZaTDNRSDE2Z0NJ?=
 =?utf-8?B?OWJmSWZmU0RtT2FYaG9xNkxxaFRKNldkRXdRd3loOStoL1BOT1BpSjNBbWJ4?=
 =?utf-8?B?NithTHpsdzl2d1VQTUlqeXcwVXZRZDhnN3dKQk1DU2EwSmVDekJjaE5kZDgx?=
 =?utf-8?B?SjQ4NnZpYXJ6YzYvMTJyMDJ1WTZPL04zY2NkNVhIRXozT2wwQzBqV1RIdlhT?=
 =?utf-8?B?MWF2T1BDTDNtR256VUVqRkphWGtFcFZTeG50a0V1RVMvbnVxNWdMWlhRM01L?=
 =?utf-8?B?MmY3UW9vUDRRNjVhbkdMVlAyaVF0Zjhkck9aRFNWT3czSlA2V1UyMWo2QW03?=
 =?utf-8?B?NS8yYTAvTWlwakpFTm1Yakg2L2RNNk5Yb0RUZVFGWUk2bXlWcEo2SkhBcXA5?=
 =?utf-8?B?NDlhNkQ4cjBENTl5R2xaUDAzNUJQcUw2ckpJVStBOE9KYlNja2dVdXk1THkv?=
 =?utf-8?B?MExIOC9MbE91UzRmNUZhRTFrdWFFRVdYM2Y0czNGNkpSdUJKQkJXeW45K0Ny?=
 =?utf-8?B?SVRDbkplQjB3LzczbDU0RVhaazNxdGRtU1grNXpRby9uMDBRTGZ6cVN6d0lk?=
 =?utf-8?B?MjlEVC90aUNjeXpBNnE1dlhDVDZSMFZjV0ZZTkFuZEQySkpBN1dvMDFUSnZD?=
 =?utf-8?B?d3ZHRVhhTHVNSnFQVVJ6MmFLYVlJZTdwQnZMQzlxR0pidWkvd3FiKzdDOVlW?=
 =?utf-8?B?djJWRXV6MjkvV3kxSVh6WjBRQ0ZuZXFVNkR5a0pQV1FlREZBSXJDdFY0VGFm?=
 =?utf-8?B?WldSUVBxaGtNcXBzY241dWkyUzRIYjJvRFoyV013YU9vUjM0enhwQ1JUVTM4?=
 =?utf-8?B?R3FXQUkvUkVOT0dnUUFQWUlmMFNMWDlzZDZSdkZCRGs0OWJva1B5eFZUWG5a?=
 =?utf-8?Q?nVWnEowUY73zXV1o1aftMLI=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB9754
X-CodeTwo-MessageID: f9fd53ee-01cb-4fd5-9cc3-0b630056585b.20260203094418@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c0ce40dc-41e9-4fef-fc6c-08de6308cb8e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|35042699022|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU9tSVFtYUNJSG1ocnJEbEh2aDY4WjJWMGppN0JiczNDc3YzMXRyeUxXVDgx?=
 =?utf-8?B?WVMxUCtrNGlXOVNMdHFTbW1kZFlId2ZPMEk0ZTc2Y1FsL3lTaFpYWFcwN2FG?=
 =?utf-8?B?eTFJTkJjVEdWdHFDeCtBclpRWFBPYWgrODhnd25RZEZzby9VTngwRzBWUER5?=
 =?utf-8?B?N3dxdU5zcUtSeWNuQ0VnZVpIWGxDOVVOcVN6VEtsWjI5b3p0MU1rK0NXTEtw?=
 =?utf-8?B?MjVEVk42ZFdZWXd0RkZWcVBjVys1WDE0NERaK0Q5Q2dMSDhVYlJMQmducDVt?=
 =?utf-8?B?cmxSZTZ0VUZ4RmFDZXBNeGMxeW1DU1d4V0ZYeDVCNXRvajhwQ1FsSWR6MjVP?=
 =?utf-8?B?K0tGN215UUE4RkpQUXp0R3FHY2VtZVNqeXB0QmtPRmE1SmF5YUdmT2RPbU1P?=
 =?utf-8?B?TVJZMU5FWnRKcEQ3TEY2UHdCOFRxL29wUlZsT3JqK2tqZ0QydzhkZDJNbktQ?=
 =?utf-8?B?M01tTXZZTkRLOG1IVmxxeEJxdS9LYzFrVU1CRTk3N1NYRXVkdE01UUl6MXFn?=
 =?utf-8?B?RW1sakNaTEs3RGJTYS9Pbm9NME5pL01DYzN2TVAxdDNyRldRUDN1eXQzRi8x?=
 =?utf-8?B?WnVnOFNTM2xOOFlUUUVqNEdBUEJTTXJwWWpCbGNEdmxiOUN0eVZGSE5qdUdS?=
 =?utf-8?B?VzJML1RuTG5TRXRXcDNqWEpMY1kzSVNEYmtqTWxBRE9KWEJGMDFTN01HT3pP?=
 =?utf-8?B?bjZQaWRpOTRicjd3eVpqUHBiWmhVS0pJQzkwQVB2OEpQVEdhTUZQbHljUzlK?=
 =?utf-8?B?QURRNTExL29lRFZKT0k1VjdMcXdWbUg1WDNlbFhGRFg4TU9JS2xESFcyOUhh?=
 =?utf-8?B?cG12Yk12bkRzVm5jdEp0cU4yelU4UzlySXI3RTlwRkJSd05nT2o3ZW8vVjhi?=
 =?utf-8?B?Vk1xcURaV1ZwOTkzK2M1OXk4dWdCSjM1MVgxeG9jVFR1UjhtczdtSVNyU1RQ?=
 =?utf-8?B?a3FHZWIwQlQ3OHJXRjYxdW5qSGM4OER0dFk0WXBMWUtDUityL1pxVTBMaGVP?=
 =?utf-8?B?ZFFnWTVDUXNyOG93aXZMUDgvN0lZeHVsZWZLN2hwaTh3VGRESC9vaHZNSmV5?=
 =?utf-8?B?b0Fvb1QyOEQxdUdhcndlYVZVQVM1MkpqM0d3SHk4aUNsUjc5R0RwK0J6VmNl?=
 =?utf-8?B?N2hwb1FkZm9PZEF4MUJmZ0hYeVVDcTE5WEd4eVJQdnBBbHhkUVBzVjBTQjhR?=
 =?utf-8?B?bTJoM0FGRDVSYXVjSVhFRm5EZkRKUERpck9nV2FFb3VwVm05RkNtc0U4MFdQ?=
 =?utf-8?B?bENHclVwdVFlYTA5NXBibXljVnRURmZvQmxLTHJJbDQ3ZWlmc1MzSWtrZUVi?=
 =?utf-8?B?aURiMFVZSldEOENJWXJCUXRuLy9BL0xXdjhIK0gvQWhDRjFFRUZ1OGpvbDcw?=
 =?utf-8?B?YTJiNWFxWGZaT2FNNTQ3alpnQVJrWHJzOXo0M091c2ZCaDdnOVQwUlUwSW1l?=
 =?utf-8?B?M3pxeTdKanBTRWU3bERCY1pkbm52aTNEMFRSZk56UjJJbHk4TlZEOHlFaVh5?=
 =?utf-8?B?T25wQnFMQk9zaU8zaHNGOXgyWXZ2ZmN5UUIxUnFUWVdQWGtVbkdjUGtVYTVO?=
 =?utf-8?B?NXRoNThPS1pjbzNxYWkzN0tySUdzSlZodUFXeUZ3bVpCbkdtZjYyTGxoOHVS?=
 =?utf-8?B?R1VUN0xHZzdtRmtxaUc3dEhXT3VuTHZQUWM5dHNzSlZacDhMUitETy8rTkNH?=
 =?utf-8?B?VU1vUG9ubnUzS1VKOE5vbFRscUViTEd2TUxUQ1hPTkRLN1FrWngxK0RDK0F2?=
 =?utf-8?B?dkl0WGdDN1kwcGYxZXdaQ3JneDY4YU05eHJkWnp0QjRuTnpxSjFXaEJmTlZE?=
 =?utf-8?B?aTlwRXhaYzhTNzBtSU9YZnFxMXMvOUZzVmtiUDA3NTYyZ0RNUFRiai85T3Ay?=
 =?utf-8?B?REZEUEpqeWlVT29wSnlhSEJBcXhybDAxc3hBdXJWUHhjb2F0SHI1cjlvdGJu?=
 =?utf-8?B?YjBRcnVBZWUxM0xMY2hoUEZIbENiVDZiSXVjUEduQ3I1OFFRY2x0ZkVpSE1u?=
 =?utf-8?B?WU9qUGlvcUNRVGp5MjBWMzJvUjBzSklUZEVwSHZTMlhDdVJrQmw0WHJLbVlj?=
 =?utf-8?B?akNmZWljSUNMM0lOdGovOWlEdmFYYmlpVys2aFJrUyt4WGM3bTBFd2w3cDZD?=
 =?utf-8?B?c0pXTExGbW1zMEZIV1pOd2JUeXRFQ3l3WlQrbU1jNElqaDdHcHE4ZzZPQTVs?=
 =?utf-8?B?TjhteWJFa3FMTXFRYVFUSlVjTFdxdFRoVFZNR3diZHdXeGVHaU43KzNqMEN0?=
 =?utf-8?B?TkZ5VGFKMnhLTEdKdjVoZDRkVTJRPT0=?=
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(35042699022)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pUOJ4pwiS66sKG1PzD4ObCMluOAev9KxOaqgdmxu+K8nkundz30RTVUY+1rwLWGe3I3tkGmIvCjq2cXMCnTe2pbjsF+RXwj7IRCgqNiRCkPSgrNzJ+DvwkthlWl5u/+b3LcttwfeuxPdCsTXeYFbitADC/brm/cnHn6R+TxSH3GSrss+c24hPQwhhOd6Gf9TeeXD8VCl2iA4Jl7ZwyA3H3rOEnClWYz1miZLhQ2cIsz0V+kvLeprpTnocE9SkdrK+4ZNHosKsMUsjq5m7c1MKt/J463EDvEdIAVeEF/R8O842kHwg66kngauh41UvlmvaPXfwFDMScnywE6HY0ZV2i/beuH1d8vGKrMmjKUmxU9uMw5gklqkQP+ahlE3nGfVD3kT2csSe8SY+xPkOp8FZIsR58xsHKBxTn7ji1GTIzMs1JVFDebu7mfeYAzKi6Ou
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 09:44:19.7788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8d866c-6068-4b5e-77aa-08de6308cdf2
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR05MB11093
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

SGVsbG8gTWljaGFsLA0KDQpXaHkgYXJlIHRoZSBuZXcgZnVuY3Rpb24gbmFtZXMgbm9uLXN5bW1l
dHJpY2FsPw0KZWZpX3Zhcl90b19zdG9yYWdlIDwtPiBlZmlfdmFyX2Zyb20gLi4uDQoNCk1hYXJ0
ZW4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVS1Cb290IDx1LWJvb3Qt
Ym91bmNlc0BsaXN0cy5kZW54LmRlPiBPbiBCZWhhbGYgT2YgTWljaGFsIFNpbWVrDQo+IFNlbnQ6
IFR1ZXNkYXkgMyBGZWJydWFyeSAyMDI2IDg6NTgNCj4gVG86IHUtYm9vdEBsaXN0cy5kZW54LmRl
OyBnaXRAYW1kLmNvbQ0KPiBDYzogSWxpYXMgQXBhbG9kaW1hcyA8aWxpYXMuYXBhbG9kaW1hc0Bs
aW5hcm8ub3JnPjsgSGVpbnJpY2ggU2NodWNoYXJkdA0KPiA8eHlwcm9uLmdscGtAZ214LmRlPjsg
U2hhbnR1ciBSYXRob3JlIDxpQHNoYW50dXIuY29tPjsgVG9tIFJpbmkNCj4gPHRyaW5pQGtvbnN1
bGtvLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHY2IDIvM10gZWZpX3ZhcjogVW5pZnkgcmVhZC93
cml0ZSBhY2Nlc3MgaGVscGVyIGZ1bmN0aW9uDQo+IA0KPiBlZmlfdmFyX3RvL2Zyb21fZmlsZSgp
IHN1Z2dlc3QgbWV0aG9kIHdoZXJlIHZhcmlhYmxlcyBhcmUgcGxhY2VkLiBCdXQgdGhlcmUNCj4g
aXMgbm8gcmVhc29uIGZvciBpdCBhbmQgZ2VuZXJpYyBuYW1lIGNhbiBiZSB1c2VkIHRvIHdpcmUg
YWxzbyBkaWZmZXJlbnQNCj4gbG9jYXRpb25zIGZvciB2YXJpYWJsZXMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBSZXZpZXdlZC1i
eTogSWxpYXMgQXBhbG9kaW1hcyA8aWxpYXMuYXBhbG9kaW1hc0BsaW5hcm8ub3JnPg0KPiAtLS0N
Cj4gDQo+IENoYW5nZXMgaW4gdjY6DQo+IC0gc2VkIC1pICdzL2VmaV92YXJfcmVhZC9lZmlfdmFy
X2Zyb20vZycNCj4gLSBzZWQgLWkgJ3MvZWZpX3Zhcl93cml0ZS9lZmlfdmFyX3RvX3N0b3JhZ2Uv
ZycNCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gTmV3IHBhdGNoIGJhc2VkIG9uIHJldmlldyBj
b21tZW50cyBmcm9tIHYzDQo+IA0KPiAgaW5jbHVkZS9lZmlfdmFyaWFibGUuaCAgICAgICAgfCAx
MyArKysrLS0tLS0tLS0tDQo+ICBsaWIvZWZpX2xvYWRlci9lZmlfdmFyX2ZpbGUuYyB8ICA4ICsr
KystLS0tDQo+ICBsaWIvZWZpX2xvYWRlci9lZmlfdmFyaWFibGUuYyB8ICA0ICsrLS0NCj4gIDMg
ZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9lZmlfdmFyaWFibGUuaCBiL2luY2x1ZGUvZWZpX3ZhcmlhYmxl
LmgNCj4gaW5kZXggZWU2OGZhNGE4ODVmLi4yYjA2NTA1Yjg2NTQgMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvZWZpX3ZhcmlhYmxlLmgNCj4gKysrIGIvaW5jbHVkZS9lZmlfdmFyaWFibGUuaA0KPiBA
QCAtMTM3LDEzICsxMzcsMTEgQEAgc3RydWN0IGVmaV92YXJfZmlsZSB7DQo+ICB9Ow0KPiANCj4g
IC8qKg0KPiAtICogZWZpX3Zhcl90b19maWxlKCkgLSBzYXZlIG5vbi12b2xhdGlsZSB2YXJpYWJs
ZXMgYXMgZmlsZQ0KPiAtICoNCj4gLSAqIEZpbGUgdWJvb3RlZmkudmFyIGlzIGNyZWF0ZWQgb24g
dGhlIEVGSSBzeXN0ZW0gcGFydGlvbi4NCj4gKyAqIGVmaV92YXJfdG9fc3RvcmFnZSgpIC0gc2F2
ZSBub24tdm9sYXRpbGUgdmFyaWFibGVzDQo+ICAgKg0KPiAgICogUmV0dXJuOglzdGF0dXMgY29k
ZQ0KPiAgICovDQo+IC1lZmlfc3RhdHVzX3QgZWZpX3Zhcl90b19maWxlKHZvaWQpOw0KPiArZWZp
X3N0YXR1c190IGVmaV92YXJfdG9fc3RvcmFnZSh2b2lkKTsNCj4gDQo+ICAvKioNCj4gICAqIGVm
aV92YXJfY29sbGVjdCgpIC0gY29sbGVjdCB2YXJpYWJsZXMgaW4gYnVmZmVyDQo+IEBAIC0xNzgs
MTcgKzE3NiwxNCBAQCBlZmlfc3RhdHVzX3QgX19tYXliZV91bnVzZWQNCj4gZWZpX3Zhcl9jb2xs
ZWN0KHN0cnVjdCBlZmlfdmFyX2ZpbGUgKipidWZwLCBsb2ZmX3QgKg0KPiAgZWZpX3N0YXR1c190
IGVmaV92YXJfcmVzdG9yZShzdHJ1Y3QgZWZpX3Zhcl9maWxlICpidWYsIGJvb2wgc2FmZSk7DQo+
IA0KPiAgLyoqDQo+IC0gKiBlZmlfdmFyX2Zyb21fZmlsZSgpIC0gcmVhZCB2YXJpYWJsZXMgZnJv
bSBmaWxlDQo+IC0gKg0KPiAtICogRmlsZSB1Ym9vdGVmaS52YXIgaXMgcmVhZCBmcm9tIHRoZSBF
Rkkgc3lzdGVtIHBhcnRpdGlvbnMgYW5kIHRoZSB2YXJpYWJsZXMNCj4gLSAqIHN0b3JlZCBpbiB0
aGUgZmlsZSBhcmUgY3JlYXRlZC4NCj4gKyAqIGVmaV92YXJfZnJvbSgpIC0gcmVhZCB2YXJpYWJs
ZXMNCj4gICAqDQo+ICAgKiBJbiBjYXNlIHRoZSBmaWxlIGRvZXMgbm90IGV4aXN0IHlldCBvciBh
IHZhcmlhYmxlIGNhbm5vdCBiZSBzZXQgRUZJX1NVQ0NFU1MNCj4gICAqIGlzIHJldHVybmVkLg0K
PiAgICoNCj4gICAqIFJldHVybjoJc3RhdHVzIGNvZGUNCj4gICAqLw0KPiAtZWZpX3N0YXR1c190
IGVmaV92YXJfZnJvbV9maWxlKHZvaWQpOw0KPiArZWZpX3N0YXR1c190IGVmaV92YXJfZnJvbSh2
b2lkKTsNCj4gDQo+ICAvKioNCj4gICAqIGVmaV92YXJfbWVtX2luaXQoKSAtIHNldC11cCB2YXJp
YWJsZSBsaXN0DQo+IGRpZmYgLS1naXQgYS9saWIvZWZpX2xvYWRlci9lZmlfdmFyX2ZpbGUuYyBi
L2xpYi9lZmlfbG9hZGVyL2VmaV92YXJfZmlsZS5jDQo+IGluZGV4IGQzMmVkYWFjMjc3ZC4uZDAx
MmQ2YTE4YjAyIDEwMDY0NA0KPiAtLS0gYS9saWIvZWZpX2xvYWRlci9lZmlfdmFyX2ZpbGUuYw0K
PiArKysgYi9saWIvZWZpX2xvYWRlci9lZmlfdmFyX2ZpbGUuYw0KPiBAQCAtNDMsMTMgKzQzLDEz
IEBAIHN0YXRpYyBlZmlfc3RhdHVzX3QgX19tYXliZV91bnVzZWQNCj4gZWZpX3NldF9ibGtfZGV2
X3RvX3N5c3RlbV9wYXJ0aXRpb24odm9pZCkNCj4gIH0NCj4gDQo+ICAvKioNCj4gLSAqIGVmaV92
YXJfdG9fZmlsZSgpIC0gc2F2ZSBub24tdm9sYXRpbGUgdmFyaWFibGVzIGFzIGZpbGUNCj4gKyAq
IGVmaV92YXJfdG9fc3RvcmFnZSgpIC0gc2F2ZSBub24tdm9sYXRpbGUgdmFyaWFibGVzIGFzIGZp
bGUNCj4gICAqDQo+ICAgKiBGaWxlIHVib290ZWZpLnZhciBpcyBjcmVhdGVkIG9uIHRoZSBFRkkg
c3lzdGVtIHBhcnRpb24uDQo+ICAgKg0KPiAgICogUmV0dXJuOglzdGF0dXMgY29kZQ0KPiAgICov
DQo+IC1lZmlfc3RhdHVzX3QgZWZpX3Zhcl90b19maWxlKHZvaWQpDQo+ICtlZmlfc3RhdHVzX3Qg
ZWZpX3Zhcl90b19zdG9yYWdlKHZvaWQpDQo+ICB7DQo+ICAJZWZpX3N0YXR1c190IHJldDsNCj4g
IAlzdHJ1Y3QgZWZpX3Zhcl9maWxlICpidWY7DQo+IEBAIC04NSw3ICs4NSw3IEBAIG91dDoNCj4g
IH0NCj4gDQo+ICAvKioNCj4gLSAqIGVmaV92YXJfZnJvbV9maWxlKCkgLSByZWFkIHZhcmlhYmxl
cyBmcm9tIGZpbGUNCj4gKyAqIGVmaV92YXJfZnJvbSgpIC0gcmVhZCB2YXJpYWJsZXMgZnJvbSBm
aWxlDQo+ICAgKg0KPiAgICogRmlsZSB1Ym9vdGVmaS52YXIgaXMgcmVhZCBmcm9tIHRoZSBFRkkg
c3lzdGVtIHBhcnRpdGlvbnMgYW5kIHRoZSB2YXJpYWJsZXMNCj4gICAqIHN0b3JlZCBpbiB0aGUg
ZmlsZSBhcmUgY3JlYXRlZC4NCj4gQEAgLTk4LDcgKzk4LDcgQEAgb3V0Og0KPiAgICoNCj4gICAq
IFJldHVybjoJc3RhdHVzIGNvZGUNCj4gICAqLw0KPiAtZWZpX3N0YXR1c190IGVmaV92YXJfZnJv
bV9maWxlKHZvaWQpDQo+ICtlZmlfc3RhdHVzX3QgZWZpX3Zhcl9mcm9tKHZvaWQpDQo+ICB7DQo+
ICAJc3RydWN0IGVmaV92YXJfZmlsZSAqYnVmOw0KPiAgCWxvZmZfdCBsZW47DQo+IGRpZmYgLS1n
aXQgYS9saWIvZWZpX2xvYWRlci9lZmlfdmFyaWFibGUuYyBiL2xpYi9lZmlfbG9hZGVyL2VmaV92
YXJpYWJsZS5jDQo+IGluZGV4IDZlNDUxMzRjNjFiZi4uNDJmM2JhOTAxNTU2IDEwMDY0NA0KPiAt
LS0gYS9saWIvZWZpX2xvYWRlci9lZmlfdmFyaWFibGUuYw0KPiArKysgYi9saWIvZWZpX2xvYWRl
ci9lZmlfdmFyaWFibGUuYw0KPiBAQCAtNDA0LDcgKzQwNCw3IEBAIGVmaV9zdGF0dXNfdCBlZmlf
c2V0X3ZhcmlhYmxlX2ludChjb25zdCB1MTYNCj4gKnZhcmlhYmxlX25hbWUsDQo+ICAJCWlmIChJ
U19FTkFCTEVEKENPTkZJR19FRklfVkFSSUFCTEVfTk9fU1RPUkUpKQ0KPiAgCQkJcmV0dXJuIEVG
SV9TVUNDRVNTOw0KPiANCj4gLQkJZWZpX3Zhcl90b19maWxlKCk7DQo+ICsJCWVmaV92YXJfdG9f
c3RvcmFnZSgpOw0KPiAgCX0NCj4gDQo+ICAJcmV0dXJuIEVGSV9TVUNDRVNTOw0KPiBAQCAtNTk5
LDcgKzU5OSw3IEBAIGVmaV9zdGF0dXNfdCBlZmlfaW5pdF92YXJpYWJsZXModm9pZCkNCj4gIAkJ
cmV0dXJuIHJldDsNCj4gDQo+ICAJaWYgKCFJU19FTkFCTEVEKENPTkZJR19FRklfVkFSSUFCTEVf
Tk9fU1RPUkUpKSB7DQo+IC0JCXJldCA9IGVmaV92YXJfZnJvbV9maWxlKCk7DQo+ICsJCXJldCA9
IGVmaV92YXJfZnJvbSgpOw0KPiAgCQlpZiAocmV0ICE9IEVGSV9TVUNDRVNTKQ0KPiAgCQkJcmV0
dXJuIHJldDsNCj4gIAl9DQo+IC0tDQo+IDIuNDMuMA0KDQo=
