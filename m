Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D630CCF9FA
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 09:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A909838CC;
	Fri, 31 Oct 2025 10:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="cbwprjWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC935838CE; Fri, 31 Oct 2025 10:36:11 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C3C83642
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHyj3p4TGUbFEIvEFOfodlaLc6CFQQHu3o1k/KO1r3qZJD8oAKytSV2FCXlDTVR4Mi+HxXh7preIwrhmkJow61fyWxJciulvdFCOSbcbfdPmuTwNKDjwhnB4EV3N+IccX38Pj26KttnlNcthJpN+B8ZVAu17mjKIJZBVOB3sC2rutCQ1a4VqnmQz/7kH7gv2FCIYdCT+YVoEUahv+X06v8gA3bDyrOcH6NL8B4Af+QDdR7MBzfmQzT5sn/luujP35G+ZgDup2xTNAoIuKVZtUah2L+tUW33KylRsqO+5lrDV/GhTbV5EMogvDBLS7CVN8I9g8jGp8+g1ymFqWgwRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4paBHxnRsmlp7nLT1f0jt7dd9vOMuzA83ovin4DGzY=;
 b=S5x0wGKC9REDDNvASMDT/ycNOqRx+BLpx9oDeH40DGxFp3IgjX3qv+ShHyMaM4t0FO5zbs8Yi+ftAH56U1L+WxIW02EoNWeX8BJ8J33Mq8mauTTFpC1BqkaljKpJKn/4tmxtgLjoPfP+HQqL7AAuxTFQdJbbC28dPwXYnLz/vM+eERDMQEYjjGPypOPxVuxAX/k2mcHkQdPyRVowgWx7AHuCYd7WS6ajmsbLDX1nezRKLTNqgsaK2VsKzgcWehCJ3Fw9z39XiqdecP/ce0q+yfLJ34M9xlI4PMDvPTv7qllBiPp11gJDraf3aScnAsPYcoKyNVZ0oT5UdRJnKNsEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4paBHxnRsmlp7nLT1f0jt7dd9vOMuzA83ovin4DGzY=;
 b=cbwprjWdLb2hv13fCXx43V7MDgmFoWOkBd//1/4LSgnhejt/2tp9NB6bchXDo7FTIYIAcyEvCNUp1iaqEcgTNpvJC1hz/a35JmkBRaHcm3h8JbTZ/MdmrnRxO3taU5FzduuHm8AunwvJuxPRyRZsA0XzahkLlkz+6OUVq4AH93zRp4XcRjpKfnOABPpgutCh/3ebA+CLU8j3g0NL7gMLHBHKMn/w9oCg6Bl4ZFEjQbTcJrbTo4GHZ266YIcynACkA67p5rWkxZAws96cZgQHiEdeUVFSbwZUhmZxJZuJAos13Mz9z7mOtqF4QYxikv48yeiXdfYfweT2hTEkLRnJWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:36:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:36:08 +0000
Message-ID: <55d68052-0610-434e-8f6e-4c1808e43207@siemens.com>
Date: Fri, 31 Oct 2025 10:36:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: small Issue with u-boot/tools/key2dtsi.py
To: "Hans Gfirtner (Nokia)" <hans.gfirtner@nokia.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <AS5PR07MB9799CED5D37A580FD862C1B5FAF8A@AS5PR07MB9799.eurprd07.prod.outlook.com>
 <efd72055-b96d-40e5-beb5-e6af08664180@siemens.com>
 <AS5PR07MB979928242B521581C1C07153FAF8A@AS5PR07MB9799.eurprd07.prod.outlook.com>
 <AS5PR07MB97996638E48C9C5BC79EDFF8FAF8A@AS5PR07MB9799.eurprd07.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AS5PR07MB97996638E48C9C5BC79EDFF8FAF8A@AS5PR07MB9799.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0018.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: f423cf74-ea04-4e34-7c5b-08de1860eb5d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ynl4eVBZcDdVZ1VXY1VyS1ZHL2ZObE9JMjlobWkwbjFmZlRsYVdYcUcxSDV4?=
 =?utf-8?B?eGJmNUwvUGtxSXNUU0Jzd1NhNTFaWTBNWE5sN2p6MEd5Sm5LRWJvRzJXSlpX?=
 =?utf-8?B?UlFVVE1vWVl0QU5RSjdhY2VIUTY5bUV4MnJ2U0xUN0Zac21yZUE0aStXV213?=
 =?utf-8?B?ejJpMUEwUmh4bERISmVHazFINURMWHQwSCthUlJubnRoWHVDV2tENU9DSS92?=
 =?utf-8?B?c2xWWWtBRFdjRmJ6bFRnNmFEeE1xR1hMYkpZdG1HT1BHMVpYemRUNUtUZVYz?=
 =?utf-8?B?VHh3OEIrcGJxYTRpbXMvcVpsQUxqKzU5Ynp0K2JXbnhSMWF0aWpmTzRQQWth?=
 =?utf-8?B?YU1OMXZ0eS9MYjR0Y0FSZDZIa1R4bEV1VUpBWW9WMmlkV1ZJenloUWpXcU8y?=
 =?utf-8?B?VDhkQzBKL21mTlJNRTNxSE1PcVhKUDBGdEhLL1pJcmdsanRjdDdIMWJyTVNR?=
 =?utf-8?B?M09jVDlEV0hqblZpb3JJY0VTcGhTMFdaZURyQkNjbEhZK3lPS0Z4OHk4emxk?=
 =?utf-8?B?ckZQK2lna2ZjOTZNL3lKdHRxa2c5YU5jbHpzS1QzMTk5VzAxSlVWcDhBZ0Ru?=
 =?utf-8?B?N3B4SGpaMXAwMEl4N0pqeFpHSFVHRWhXcXRhdlpMRWkyTStNWFBELy9nTU9T?=
 =?utf-8?B?NFlCV0pNeUVCM2crajdFbk12YUhkak5KOEJRNDRPWUttNDUrLy91QzRWWno4?=
 =?utf-8?B?bnJjdHRWcDlUTEo3MFArTjhhRzJzVGVnNDZtRjdWS0NPZENJTCtCcVRSWERa?=
 =?utf-8?B?QXVYUnZ6UmIrVzFsZTBld0Fzc2U5V2I3YTVvVGNHL2J1WWF5QlpMRERRdVVt?=
 =?utf-8?B?bkxMZDQxWkdORG1vWkpQZDFEWlh3eWU4dUpUZ2R0NWNESlEyS0RFbUtqWUtG?=
 =?utf-8?B?bUs2RC82RkZNbUROeXRMR3RHOXNQcUI3MkJlazlpRDd6NlJmUUUvZDFJT0cv?=
 =?utf-8?B?NGNHMFlFd05qb212M1hLZEUwUWZnTWNOemZaVDlOd0hqVFl0MFN5aldUVUo3?=
 =?utf-8?B?RHNvRzYxOXVkMnNnZE9ObmQxRGJxNU5zQytWdkcyblR3NTdpQndTMGo5L3ZV?=
 =?utf-8?B?ZTZaV0gzdWE4eVVGZHQ4c1pDZ1J2ZHlmczZuZVBMTmVXQmVSR2JkdThqck8r?=
 =?utf-8?B?eHlIMFk4OGxZTmNGMnBEWnluL1BjalNXdnJlSzNQeE4wUVZjd3pSUEloKzRR?=
 =?utf-8?B?Wjg4eFFhWEgxLzhpTDJUcTlYaEc4YWlRSlBTTXhhNjF1ekt2Lzd4WlVrYWJ2?=
 =?utf-8?B?V1dRQWdScU1yOThJQWMzc0dLSGxtMFBybG1wZ0tzWm1kbUZiZ1dZTWd0NU9p?=
 =?utf-8?B?emU1cTNYbWtuUkNqVURzQmY3V1h1QkxoNFFMZGY5TWJEWlpubmFydWhLLytG?=
 =?utf-8?B?UkVZZ0J2MXFjYmU5Wlp1VGpuSXdjdFlmVUNNbWswOWxWamplcEZ1WlFSOHho?=
 =?utf-8?B?cmJzSm1GUzBmdW1NZGdqdzF0RGhTc0o2MFZQb013cEIzK051NWVUek82Zldk?=
 =?utf-8?B?OUpIVGgzdU5pL2JGdm1hWmdNQjd3MFVncjRGS3RndmNDdndjbU5oT09kTXJl?=
 =?utf-8?B?Mk9oQ0ZyY0lnSUExTElJblBPbFJPWUlYaWpvSytmeGpORDlnOEVuRGg1RlR4?=
 =?utf-8?B?NUZZVXVlWlM0K0JrWlNJdlJMYlpPYWl6MkhLRDNsNFkweEMzYy9NSzlEcVI4?=
 =?utf-8?B?SkhJcnJzbGdaS2laRE5mMVdMTWh6MFlqRm8wMVJzQmxXZmxPM2IydkdreENr?=
 =?utf-8?B?QkJuK3o3ZEZhc3hrSjIxZTVZaXBuNWJKcE5QOHMzOWZqOVFQQ2I5cnRrcjZ4?=
 =?utf-8?B?RnUrZnQ3YWJ0YmxhdnFxT29GRFFDQ01SVXdhRnFrREJzYTRIZ1hkQzUyUkJs?=
 =?utf-8?B?aWZjY2lza2dYQlNoWXMveEdhdTE3Y0NLSXB4RCsxQlNKOUxTbUJqdWlNT2VF?=
 =?utf-8?Q?jaEBcI11saqNrKU6EOIa5i32WYgi+xrm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXZOUmVIWDlGbVhYZ1FFQjFEeHViUk9aVGYxMW5vYmJQUmtpNFlvTUZXSGVm?=
 =?utf-8?B?SU5TRkVMbHRGb3BtNk1iSEprSWgzaTFxNFJ5cWhmSktlRW9rNTEzVkFCTnlQ?=
 =?utf-8?B?czZ6RzgwVTM3ZVQydTNtcnZsemdhVXplMDhubUFFdmFzUHN0VHlTTHA2amVJ?=
 =?utf-8?B?VTZpcXRLTlI4R1dvNnR4QkUveDRZRWpia0U4VjArSGxSNTJhNXptS2wrM3BY?=
 =?utf-8?B?enZGSStuZVlObnlwL1VoQ0xWdHVuaXFoNlJyQjdvS2tZL1FrWnUrNE9tZGlp?=
 =?utf-8?B?T0lMQUJQWWM0MUdsYkl3UUhNTFl6amNpUWs5d0o3NllKeHoxN2FKa3BpRU01?=
 =?utf-8?B?VjhpclY1QUdPN0Z0SG1iSm14RDVrOFZoRmlrbmVpRjZVWW51S1owSXoxMFVo?=
 =?utf-8?B?amZSR29LTUZIc205N0FSbHR3eHo4dHk4dmVpOWUvalNXYXFPTEJ1YUhUMDV2?=
 =?utf-8?B?cjBsb0xMTmFqbGMxUXhWbHoxZUptdjcwQXNxSW1TeTV4SGp5OS9mTUE2YWhv?=
 =?utf-8?B?Y0FpQVU5c3dtLzhCemF0QVRwL2VIM3lCeEdXaG1JVlJkN3pnV3FlejMyTy9F?=
 =?utf-8?B?WWVDcUh3YXFySS9aWEQwRi9yWllZS1dESXRZdTRTSnpwdVNiRXMzamkrVllt?=
 =?utf-8?B?NGNLK2xiSUhRMW5BTnZxMHViNjE4VHV5S0k1Qk1abW5DUHd4SVFrN3dJZmNr?=
 =?utf-8?B?YllUSURXUU51Wjh2Q05XcVpDUlN4UU5LTTVNOER3STVHd2RaZWNZZm5ZVE5E?=
 =?utf-8?B?cWZIditvOHBnNUcwV1hDK2NkWE1YaU9tSkwxd3FGeEQwSFNYQkJjUU95ODl1?=
 =?utf-8?B?VnhtVkpxeHFTTzZXMVh3RDc3TUtjZEYrQlY1N241dDhpWE1kWFk4ZCtkWEFp?=
 =?utf-8?B?S0NPaGtNZUptNHRnanVvZmpSRmxKZ3Z3WXJSQjhEQWV6clBZN1VIeEZKVTUr?=
 =?utf-8?B?RDR6N1E0SXI5blVUQ2o3cnRvUVZjeDk4SG5RRXF2bGUyU2hwSUFaZ2ZlWHo2?=
 =?utf-8?B?SGpKTi9vbFVIVnpCS3lSeGhuLzRFblR6L1pJRGNUN3JkWlIxSk40aUhGVHBv?=
 =?utf-8?B?YWg0dEo4OUE4WGJvMkllSWo5WXBlbk1EVllJQzAreXlpelpVd3FLOE1uNjQy?=
 =?utf-8?B?TGRHc2lvczZBRnpwRUkwVGh6dzBrYXhvVW0rOU5FZDR0UmxPODdjbHo1ZWhB?=
 =?utf-8?B?bWFBSlNXUzRmSzV4U0s5dkR0UG9MN0I2OTNESUJJa2o3TWxpZXAyNktmRnMv?=
 =?utf-8?B?NTFlR1pYMTY4T1hubUlIMmFsMGNLbHpPanl2SGNZS2xLODAvaElvaDMxbHpr?=
 =?utf-8?B?UWpMVWFLalVEMFIrSjAwVml5dXhIRG1OeEpSMElPWWNGamtKMld4N2V1dXFJ?=
 =?utf-8?B?MktBRk1IZEs4Y1h4aUJLTHp3NEZMQzk3bGQ4ejRlZFJZVDMrb1FQWi95WFRE?=
 =?utf-8?B?Y1JneHZJcGxIZDlSWER2S01taVBhNzhnaDIrS0pBSytnZ3VaeWVQUHFoWDFs?=
 =?utf-8?B?aFZzVzl4QW00UWtmTGZzVU9GcmR2ZFpVN1l0V05OaDc5cnkybUdQVnRHZ0FB?=
 =?utf-8?B?NDRtU0VVTjMvMUE0aDVSQUpIdWsxWWNLQTRBc0pJbUFNSWVWK1NBeUI0VStV?=
 =?utf-8?B?SkI2NHp1TXh6NW0zaTR5K3cxZ2oyTXV4L3Zrb1YyYkVXMlR5dEFkc2V0STNR?=
 =?utf-8?B?YjF0Z1BuQ2JnSkNGMVVFdldiQjZDUDd5aXJtaTk2Rk5VZ044am1JQkY3YXVB?=
 =?utf-8?B?Z2xnaFA1V1lSam0vcnBueVYrSTV3cU9LMngwcEp6d2E4S0YrME1ZdnV2cXh5?=
 =?utf-8?B?YVBUMWFLVHp1TDBOaXErLzgrcys4b0trdHBpVzl2dUJLSHdlT1RPYjV0enIx?=
 =?utf-8?B?ZndOdVEwSzFueGNOUFc4cE0wRXErRzlpSjlRYkZRcWhGNFdYOGcrcFRVWkh1?=
 =?utf-8?B?a2VWeHpPbHhKazZmRWo3YzVmN29rcGs3TGdBWWVQbG1KdVpZWVh4cmRRc3Iw?=
 =?utf-8?B?OGpQL0lWdzBLWlA5dHlmRFUwbnlqcjByUmJYLzYzYzBib2tPTVg0QkpSTFZI?=
 =?utf-8?B?a0RWK1p0NGkyUit4a2tONStZRlhWMG03NFIwNm9ZRklKMkNueVFiVGM2YWZB?=
 =?utf-8?B?bkZVUURsckJIamY4d1JsMUZtTUdKdUErUC9TRFpKQmhZNTdpc3dvUGtQOS8x?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f423cf74-ea04-4e34-7c5b-08de1860eb5d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:36:08.0139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTIeXrLIh4hmJrIpHbYSsv+rjOyAfQCrqedWm4fbvVSpRNUAcUzIueHPCRykQttbxx5PrBH3Q0XjlhgQbc7Atg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5626
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

On 31.10.25 10:07, Hans Gfirtner (Nokia) wrote:
> Hi jan, all
> 
> I experienced an issue with some public keys (probability ~0,5%) u-boot fails to load secure kernel image:
> 
> There is a small flaw in the script, imagine you calculated a “rsa, r-squared” value with leading zero, then this script outputs just 255 values for it, without the leading 00.
> I tested this with a script generating hundreds of keys and observed this error with approximately 0.5% chance (matching to the probability of having 00 in first place).
> I fixed this locally in our u-boot by adding ", 256" to make sure leading zeros will also be generated:
> 
> out.write('\t\t\trsa,r-squared = [{}];\n'.format(int_to_bytestr(r_squared, 256)))

Well, that may only help for certain key sizes. What if r_squared needs
more than 256 bytes?

> 
> An example for a problematic public key (generated with openssl) to reproduce the issue would be:
> -----BEGIN PUBLIC KEY-----
> MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5FeZKqBPrnGw3PgvfJ7a
> ajFUMt94MIBsW5movhjKfdCqHJt0oS/bQWAeOEzW7eaAU9RnQev8ud+WgyVuKyrz
> AaUZ6gpQC4V/Ll3Z1k06JXGInCxTVaOQh/A3fCgntqQmyotK6UeE/Xe9uvQ7Olw7
> n+d1nyGWWTrWt5wqQ2HRCyiDtD9kSMYoM9rKlU301oJOCBKZlvHJz+zP3jNz52ZB
> SFe3daaYmbIGz4mDTigJjGEh2BA8M+rT+/JkAUqUBC07wC+DsuNpr/A8QSTWs1Lk
> YwpUuzTaDij/UN1gJ/Xw2NMEkQMAbz6F4U4TbBez6/zDa52i/LmRn4A1nxy7agY8
> kwIDAQAB
> -----END PUBLIC KEY-----
> 

Thanks for the report. I just sent a patch that is supposed to fix the
root cause.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
