Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121AFCCF2F2
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 12:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D24E83015;
	Mon, 19 Jan 2026 13:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YTPBlpb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0248313B; Mon, 19 Jan 2026 13:13:48 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC002800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 13:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REEXTgT9bN2lL9DKfv90a0NbKBaVUwfDPon1BMExB9CUknQwUKl7/pcp2BR8YhXhq+OJMESYwyre6n82FhqjC+8bjZDkz5u2WrkWfueP8yHRTRwWzhBn4kE8A6bhRfb5jQmGlZBt6Y+KXqX7scI6uJKWEfseDqhDvt/pFFm3XuUiufmxq0jMg3TCi0tOQNBf4gqP6IqjQlePYsVO6H1H8y44mIRIkpPVaXyDB2uhGd/j/eaWEeD7EVbqtwvABv+/RWLCUnKteDXS4rMlCEEAoKBkyOSR3Ko1+Hi9FxTeZ8HpiiTZ1CgHzk1GIrcgefZrF9iaEvQoviELIAD4OPtouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLgT9Zrrg4g8iduaJQhdLnSeerIGpCSs1d+k8dHfsKY=;
 b=X6bJEsbOwF87BSFJYaiFRuJrRlyPTKlFi18mB+LSjHUk1v0emRYMYmDMi5dAcrZ9vPRcvUI2gBvqhhaS2ZKpIy+4L4SRTEsxw8AsSVR+cmAbNhj/oMNRyc5Hv9MxGkgAqYGP4VlapSx2+kHcTfOJmeMv+Z38kXdo9kmGI/XlPjvR0DnPrr7vOcHdXoWqHuDxykAMzFfVRK6nyTPGcEMs4/rQlJU8ULnnVKMCT2czMNYCvVxWfgiNR/liLa9lRi5ViKJA++ciPMxpx6eYdyOToH6gE3pnYsthwQ+8TISGx3KMvoZKAn2wfkccOEKAKaBGHIO2BhCsSgPa0SGEK34j+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLgT9Zrrg4g8iduaJQhdLnSeerIGpCSs1d+k8dHfsKY=;
 b=YTPBlpb4CVM2c539aWo139QMwrSD1zXMnGMtYFVczqFKD22r3V9+j/RCr6ic2qX6Ml8gALLJ9wZY1QRoXV6DCEmc2KvUo4dkbBZJNnG6zExAA+LSGfPmwl5eBZ1+rPtslUsmKuqL+kl3qBTumC1CueoK+mn+TuM3KPEnU01cctY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA4PR04MB9437.eurprd04.prod.outlook.com (2603:10a6:102:2a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Mon, 19 Jan
 2026 12:13:42 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:13:42 +0000
Message-ID: <eaf50435-53c8-4d40-b7cc-edd3551e1a25@cherry.de>
Date: Mon, 19 Jan 2026 13:13:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] doc: develop: process: Move the existing block
 about patch application
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: E Shattow <e@freeshell.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260116182335.4081828-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260116182335.4081828-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA4PR04MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be1b74d-5b55-4dd0-4511-08de57542f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWdqMzJ1N3h2Y2JDdnVDU2JVYzhPeDhiV0VTNWU3WnBmdmhZM0lCTzUzaTdq?=
 =?utf-8?B?dTBTa01vVy9OaFdCNUZwVjNPcjRrMlFLaVRUaUpBMDBNUUxWRVJmYVp4NUEz?=
 =?utf-8?B?TjFhME4xWlJJT0haWG9pc1VIa0lqc2Ywb1FWa09Yd1dyVTRnTHU2aUF5VzZL?=
 =?utf-8?B?aVZwS0gwOXhSc3hrcmE0T0lwZ1k5VE1CZjVkR0k1Uzc0Zm1OcU9CRm5qaytC?=
 =?utf-8?B?djRxMDBnaXBLVTBTSWxSWVBIeWJZeVpwcEIxakt2MXJ2aHlabUlvME1qdjRC?=
 =?utf-8?B?bk1aWm5rc3NtL1F2dklIZVZCMTM0Mk5namZsOVlnblhNdU1IZ0RCNEY1YnFo?=
 =?utf-8?B?dkVWalNMeTNSODdPNW5WbVhYbXpXQzRpZldsVWhDeHMyaTNCQm9FYkF2dTNp?=
 =?utf-8?B?dXNITjFmQjh4MUVDSVRmZDVINURHbHhzNUoveW5CQnJOR3pOaUZ4c3FMemZl?=
 =?utf-8?B?VzAxME5oVWZmekE2ZmxYNlFZTDdmbFBwRHU0MVhSNlBpejgrQXNnTXFyZEps?=
 =?utf-8?B?WmhtMGdMWWFiOW5SaENqRVRZQmF4YVIzN2lJdDdxWWhYU0xxSjlLakRKaVh5?=
 =?utf-8?B?RkFJUXd0VXVUNUxUYjdKUzJGWGd3NnNjZTVLdFRzVDZwZ3c2ZmZMQzVvZEht?=
 =?utf-8?B?MUVUa0VkRjRiVHJvVHJIWENOSmZHeE1SSHVXQzhLN29oeFNSZVlDTHpmY3pl?=
 =?utf-8?B?ZnQrWm9Bb3RKWUZJTUk2RzVxRDkzaVVRRldFbEo3QlFJRXRWdVZnaUJDc25T?=
 =?utf-8?B?U2tMMnZibG8rRUpjZDRxZTVuWm9VdGFXcFAxOTVNUTFwVFZjWjFXZUk1VHlE?=
 =?utf-8?B?dkJpdlpEUVpkY25XYnJDSnNSWnUyVjJQeFloSkpUMllKeUxFb3hxMkhpd0lF?=
 =?utf-8?B?M1pJNXFLL1JBVlhOSTBoYVZYNzUzT0lSSHNiVTRiRmE5bVBRRjBKVVIvVDFk?=
 =?utf-8?B?OUtWbXgxYTNYaEVmOGJUSDlEd29yT3dOdVkycDFYMDVyTnhJZmE4ckM3YVVh?=
 =?utf-8?B?cGpPSy9NSlBsUkt1TXRJZG5udW55dWZMbFdFTlZmblpIMVF1RUkvUkpkak9t?=
 =?utf-8?B?OE9pMlgvU3QraTd6MTlMU2ZjdHluREx4WHc2cThxL2xlTHowcmhYM2h4SFk4?=
 =?utf-8?B?akt6Q0U4YzJFazFWbmZSQlNCZjdVUFJFNS9IZTdISzNQWFl4THdkT0JadWdR?=
 =?utf-8?B?WkZESFhVT21wemRuOWpCcW55Wi9SMnVHY0tyaHFGMWtRVzg5WkJtU0pBVjNY?=
 =?utf-8?B?QXl2VmtlUjAzYVBCOFpuWFExWjFJTVpZbVV2YUJKYUJ2d0lBYnpNTmJxd2hP?=
 =?utf-8?B?aWI0S3VnaEhtUVpmY1FvbjhaenFQQ3hIWnE0Y21ycHRCci9SZm1VWmNHb3pW?=
 =?utf-8?B?cVF5bUlXcjJQY3hncnJSV2VneXlEQ2s0RHFGdkY2VFh4c2dzaElEY09FNWVF?=
 =?utf-8?B?UDNoZzJiNkV3a3BTMFZkQjdLOWVOWmpjc0VwMjJmQzVhOGJoak1LMVRwak00?=
 =?utf-8?B?U3ZQK0h1QU1RSHFJbTh6TVFnL3pDT3RBTVFvcDY4N05YcitJR3VOeGVnb2Jh?=
 =?utf-8?B?VDFQRUM1OUZyV2RnTjBkMGVDNzRJZkdKT3dxNDVCN0Y0VytmcGs3RGJ3Zisz?=
 =?utf-8?B?Mi9aZk5lSGxXN0RDYkJIKzFUN3hSY3VNWXBLZTNpM0NrMWdjOWg3M2FqWUlR?=
 =?utf-8?B?ZVJOL3EyYVYxQ2pVS01nUDZ2N2tlTlRFeTZWYlNKeU5UTkVuajVUL3BqWm5D?=
 =?utf-8?B?SmprMEFBcUNwQ3Y4QmxIQWlaQ29kWWRUUHFkM0QzaFdFMGFnOEdkUTBCTVdu?=
 =?utf-8?B?akNlYmw1ZDMrVFloWm9aNWJsc1ZhSXR1b1AxdWJ1T1MreU1Fc1B5eFhyZVBE?=
 =?utf-8?B?aXlhdzQ1akE1dldTOVZMZnFwRkVCZ1l3dHpwcU9qRDNtKzFmay9aNzFyanpr?=
 =?utf-8?B?cmRqVnR1YzdPdTlLM1ZzWk96amNzbS9SaXRKMGlkWUdhVE9MbXBhV2J6WldV?=
 =?utf-8?B?c0tWc0sxTE1MZ0VMZUdvOFk2Y0grR3hJNGZUMkhCa2lOTzllSTFUTGFRZUp0?=
 =?utf-8?B?TElzWHd4emxlb05KS3BMcHF1ZWxPaTFzMm1JS1F5Zi9USGttRU50MGJ2Wnhj?=
 =?utf-8?Q?RRBw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk1xb1FwbjhoT0tXTnpuR1c0RVM1eVBkTSt5dm5Rc3JzTDREcHMycFJ1SU95?=
 =?utf-8?B?SklaeTFjWVB4UnZGenI1Nzd2NCtuWXExaE1NUG5NbnM1cVRCQTNLYWJMSSth?=
 =?utf-8?B?a3A1Q1crNzhULzZScHo4NWZzd2dDTG9VZG83U3R1MmpzK01pYnZEdzFnTXZI?=
 =?utf-8?B?RU1WREF4SjVwQ3RiN2s2WnkwTXZNTzR1VjI2QlZ0Y2wvTFpNeXVhMWNhcTIx?=
 =?utf-8?B?aHBKSERjYndYRjFDY2NUbWk4TXViaHVPeGRFeU5makl0NWlRRFRLSFgxNnIy?=
 =?utf-8?B?MHZnZk9Lb28wWnEyNnNlakR2Z2dXQjNKY0t0V2ExSVlrMGp0VFl4NnI4V2Ev?=
 =?utf-8?B?TG1OaFg4dGkyWS84Yk9ZZmlSSTlFdjZtZ2NKR3RUSTM3SWx6c1JWK000K2hh?=
 =?utf-8?B?ejZua3hBSkpNcERONWovYzZqNHZvbXVCMmdwM3FTQlkvRHV1UDBGbTBpejg3?=
 =?utf-8?B?N1JNZDg2emZ0bjdQYkVKQ0U5aEtEclBNajdPSHYyL28remNIQkpVcTh4QU9u?=
 =?utf-8?B?VHhtelBMVjZDYjZpNjFwdGV5SDA2TnBjRTQ4NVdHQzdGRWxuaEdiUkNxMkMv?=
 =?utf-8?B?K3lnZUdSN1VHTTZXN21VcUFtZWk3UFBQSUU2VExUWjBpbVVhZ3VtT0N0RWc4?=
 =?utf-8?B?VUxCMlRiUE1VN3ZaWHQ2eDNCN3FYTk1jUUFHR2t6TXFlWmIrM0lUSUxma2ln?=
 =?utf-8?B?WVlzRS8yYjVxMjFFQ01yM2RUS3VDaEhmZzVnVHFyUmFUU25raUZ1UEFlMkdr?=
 =?utf-8?B?Q2FrM0hwZ1M3cy93K3RCWEtFRVRCbk5DMVZqN1dtSUhZajNZUTl4MVBTSC9J?=
 =?utf-8?B?WS9tc0JwRURlcTFxMDROdWF3NUVyVFdWdkZLYytmb3NNenlYOWU2UXFyNEdh?=
 =?utf-8?B?V3UyZ0ZlRGxmVHFpT0NkcTd1K1NaUmpVQmU4bEtyc2FESFNXZm43U3FwM09G?=
 =?utf-8?B?QVkwT3p5eE9NK2NGYURLSGw2UVhqcmpFL2RrSFZTd3IwMVdIRFRWNzMxdXdw?=
 =?utf-8?B?NWNuc0Zjenc5dmFVTmRLcEIvQWIwakVMWGk1ZTJhcllEYU94UUpmb3pWVDhl?=
 =?utf-8?B?TnBwT1FZNis4SlBVSStmMkE1bElTdjdzRHhUYTRFRWg3UW9yNEZTenFmaXZr?=
 =?utf-8?B?OUl1NXIycm1vam5MbGQrM2JVcXdPdzJZLzRnakxNMm9jOW9lUnJwOGxaQlp0?=
 =?utf-8?B?ZlZieGYvYnVpSEkzTGJ0RUN2T3V2ZEQ4U0VzMUYzMzcveDFFNTA0ZzRlaUJE?=
 =?utf-8?B?aHo5SzhjbW9VZFBVd0lmWk1kVWRmWjIzMUpyaitXNE9lUlZjNWdmL1BYR3hM?=
 =?utf-8?B?UDZMRGMwUUNWT3diN0dLbktTRGh2TWhYVTFQckZWQXVkcnpWc0pvMGF3VDI5?=
 =?utf-8?B?eHRjdFQ2bkNnOVV1QVMxbG5Ed1IrMEovWFNVQ0hJU3FTeVQ2VDdwNy9BQ0k0?=
 =?utf-8?B?SDhNWXNsSnlQSlNab0oxOTRSVFYxdWVZWWNnUEV0RWVac2I1QkM3ZTRKMWVZ?=
 =?utf-8?B?UHk5M1pHZ3BaODQyOHVNM2YvaktWZVZURXkwMHRGOFRCc0hkRWVodmpPdm53?=
 =?utf-8?B?cmtRKzB0T05Ed29EcmpkcWFXYWdRMWVWZ3dVejZIVXgxTS9NZlBhY1hTZi82?=
 =?utf-8?B?ZWF3eGs2engxNUNwVURZK29Kb3JUdDA2cDhHNVN1MUNxcFF0ZnA2Q0ZCUkRj?=
 =?utf-8?B?V0xRS0RGMS91d3gzL0lZVWJnMFByOC9sYnFWc0g0UGZNb3E4U09DK0N3SE9K?=
 =?utf-8?B?QmZpVklEM1M0RytqWFVVQnJSRzFJdDRmeGpoMEhkQm1aeVZnUkY3YWlRdnpF?=
 =?utf-8?B?YzRkUjkwUnY2TlRodlAwMmJjQThsUHRPNTlWNk85cjZnNUd4cE9Cb0Y1dVoy?=
 =?utf-8?B?blg3NWlEV3ZaaVFsSjFPbzJ2dnVEQ1QrdGU5aEJGblJEcmk0czNTUjBmNkZ0?=
 =?utf-8?B?Z1V4NTEySEdEcElYaHBJODM0Y1BMUVowY1ZuM040SS9XY0hCL0JGeXBRbGI0?=
 =?utf-8?B?SFRBbmc3aWZmblhLeXF6dmlKZGNTM2dWcTgrdzNOZEVMVmlzSDdFaTloOEtn?=
 =?utf-8?B?Rm83RndHaDZZZllYeUtPc1RXa3ZPdXdUclFid0w4T3cxVkNLbE05QXRHY2RD?=
 =?utf-8?B?Y0cxWUM1T2tsdFNJL25VRklRV2Vha1FMcHNpU3JJSjcxTEk3RVByUHh2YjJH?=
 =?utf-8?B?SzNOYXJGT3AyL3hnWUowNW5aU2I5dEJLYzV0TkpHRzQ1Q0tDZm52TmVJUUpR?=
 =?utf-8?B?T3AzMGNkQW11UXRXUlpPWlN1WUxvbC90MVFscllUOVA0VHVnTVV2K3lHWHh5?=
 =?utf-8?B?Q0E5WExNZmFLUTBveHdDZXNzWWhzOGJtaG5oaEsyeitySFA2ckEzcnN0QlhM?=
 =?utf-8?Q?FauU+5klBTedL6zLfPfDKFyFU/QU2znSZObNY?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be1b74d-5b55-4dd0-4511-08de57542f8f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:13:42.1406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrvGVqzhejmor1jg9I2brvyfxshmYeJbACPad0b8f78VD7Da8w8TG401XLQiaUYnxYUwAsm491XJ6wk3Ngqo5S2YpIrq85eP0grRDDXTWqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9437
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

Hi Tom,

On 1/16/26 7:16 PM, Tom Rini wrote:
> We have a long block about the expectations and feedback about a patch
> applying, or not, as part of the Custodian workflow. Move this to the
> Custodians section from the Workflow of a custodian section.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - New patch.
> ---
>   doc/develop/process.rst | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index 4bfbf0eb9c63..81e1aa7e34db 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -143,6 +143,17 @@ reworked/resubmitted, or if it was rejected. However, if a submitter
>   feels it has been too long since posting their patch and not received
>   any feedback, it is OK to follow-up and ask.
>   
> +Another form of feedback is about applying the patch itself to the

The wording is odd to me, applying the patch isn't a form of feedback? I 
would assume feedback to be some interaction between the custodian and 
the submitter.

Would

"""
Another form of feedback can happen while applying the patch itself to 
the source tree.
"""

help (since we specify later that the custodian can request a rebase if 
they feel like it)?

> +source tree.  The custodian is expected to put in a "best effort" if a

Unnecessary double whitespace before "The custodian".

We could also add a label before this section so we can refer to it 
exactly later in this patch. See ".. _dco:" in the current rST file. Not 
a blocker.

Looks ok to me. (Just moving text around after all :) )

Cheers,
Quentin
