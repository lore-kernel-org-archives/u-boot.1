Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EB2CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 15:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F060838BB;
	Tue, 12 May 2026 17:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="f+uXill9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B964083C51; Tue, 12 May 2026 17:26:33 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE75A836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 17:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8Ot0Hhw2FANAkxB1j1x03mG9Qn7jOEjFK1LquM0WFkuq1IK+M4IkBoqlgB8J/OriJCcGJvERumAXYi6T8Atzk6FMGxUrwwFqDHrb+tNizg5gHfCTeEnJuB1VU+wzWqiDEyNiGCYd8M7ojzKDGei/OeUxQ5MOdPGqzafbY3f2diRxwTFj61TrgRCJn3GaKrj0YiGbH68V8Tl3trYGJZ64SoI62VbL9F7KPKjkSLbl79jjubbvjjmVwqzID9c30hkDJgkswOZd3dTdNRPidewswWP+nJKdn//W4VMabBfLHP69V3qXY+Q1AbpIyUDxTssPdlMsInqJpHVL6/kNQZXlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpjw/SP7+d6E688QeO7tfABz9Ovw4/Jriduc+jqBc1I=;
 b=M0bmAqYNQG61rE2aFiTe5aEXG9T93zRvnL/7w13oU3VYtj2oPgKQYDpYVlq3BeTUYvew8c23Fg/plZpSIKDhQHfcMcXDtSOp97bpQCsd0F0HG3K+pYmTAzxb6AmpOf4BiMo5ftVb+jTXYBDNKBOqexe6Bdcp7/EjRtP3kGxE7eXLWvbtasFZIcE6DlNRwigeANyEBNXt64YCITQ0VSP6kXmXz0Nj/SbOWgUmHYQH5zehWOvgJSZNbzEoXnkuH3ZLyuKax7cpawmAA6Yw4SuN7pPRS/7cmGUFMUkKk5Cxy6vnk2hUiK+kj97FMydywk+opytvNLf9tRXivf+nWyrxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpjw/SP7+d6E688QeO7tfABz9Ovw4/Jriduc+jqBc1I=;
 b=f+uXill9RwuZPaBNm9ySYG3VXphayAFo0MZqb3vZBccqiVLpmtKzt0qpOGlL7ml2SzOkAU7Ia+h09YN5MaJLPHTsTgdf0oni1F97xWLSuIBFSW93b/lTwWCQ1UGt1VvPLhUKXVinITakyUSSEzfrLCdH4BnAyGmt6/gZr4PL8YitJKUE8oJV1zfD0z5D05B+DJxz12e8Jycz9eEXAUlzfdkYiKYIAmVbQtgg2u6IZfOa/Pcl225gVh0dnq0kotsDF9Zp5Wb01cowWvbPETXXedVeJW/diigQaUWLJUGKv0Cm4SyZVjZThCYe65r/MhbJaOk+jyX4yapREEIS65gpGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DU0PR10MB6318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 15:26:29 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 15:26:29 +0000
Message-ID: <48643850-76b6-464e-a317-d3df81291a7a@siemens.com>
Date: Tue, 12 May 2026 17:26:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v3,0/4] Improve FIT signature handling
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
 <CAFLszTjc1w3WTmXLbgQifH8ZBUyN-sF-NQ-bvYq45tqWscVuZw@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTjc1w3WTmXLbgQifH8ZBUyN-sF-NQ-bvYq45tqWscVuZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0202CA0053.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::30) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DU0PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b2cceb-5093-41f4-c49e-08deb03ad6c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799003|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: vc+QM9zupnP4tDQmH4TOr4fcfiwTYF2s+DDXGKuLRIU+Qhwt3AOx4DxARe7wmb/921FcR+7WNiHyQt4FA91lhx7B1+o7+47McX9XkDKiCWI2C/Dr0aZZSGgtYpOFK83GEUbwJFQVv4TDwsFLVb4QsKsxl9W6chLkIVUX2IJ2KoTQ1oVhaQ/lJmhtk7ixHJnPs1NOnie9m5aaEqi5U9zXjgoNMyNaMLEEDqZi3yqREGVxDpBkXh2bEvlOOknMboJ6FJ+fuYXTxvmENz3aeOjX+T2NCX8He6Y3iIv/z9+dw9HdHVs6CJ8oidNEzhJvD29Y2xT38PvA4Zb1fPJKa4cDCFWZk3+Irami8xBeF3tkNgSCiFdNwN27kO3xQv+iht6SRfGW2ZQNxpkaMDA1CrL6BLBkw+eGp1Ml9v9C0bgfYtUSrSo/xrF53kCt7eBamUHbI2BDVFUXdGDam9EqHDfV5MzyhSsh6x6Yyb7E/kyQENITwapGe0qW+kKGmgcCzRru/u2y9i1tgO0whgRGFU0nT9tb75r0bDd9L5QkuMYtvviZcpwLjhqp+bNK4zkFYXZSUCPmms86/WA2IdxSW2v2jhPkB1VW2ju+lu7qWa4DQKlz9rsJFA98Q/pK8N8vwvo1xN4y0foV9fUyW6sKEhlKAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(56012099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dExwUjUxRGxpTWZZWTFsZjFmdEF6ZmtEK3F0N1dNV1RmRUs0Wm1FUlpLOW5C?=
 =?utf-8?B?cjVkcWQxQU9qOXMreUNZY2FramZKbkpRS2Rwb3dhaWIvNW1WTm9kdjZwNmZ3?=
 =?utf-8?B?MzhWM09rR1YxYXFDaVdGM3BxdVBId3dGeVovQ0UxLzl4SC80ckl6ZE0vUDJt?=
 =?utf-8?B?UkhOanVheFh6NjJZVlp2UnVPcGxsOTJjZ2ZKcWVLbk0zbkd5RDdlV0dYZjhz?=
 =?utf-8?B?YmJOTzk0U2w0eGFVOS90T0ZMT29xRTNBYlo3MzRMWHNNWFE2OHNnazdWckxT?=
 =?utf-8?B?cFNnOTZuVE9RNVVLU3BDaFpYSTg0UUN5WURSTDcxWk9UTk80R0xLU01SNGMx?=
 =?utf-8?B?RFg0K1NQeW4wRXIxUDRQL3BGUmxKSWludGFxYmp6dm5Jb1VFK1ZwWUhEd0xa?=
 =?utf-8?B?YXY0VmUzcjhPT2Z0SmVrbkZoSngxOVFueG80dGVVeXAybEtiTURvYTl5bHN6?=
 =?utf-8?B?QVB5S2NDY2xxQjN5V3kvZURzdmlxTG1UbFBPTE5Gb3d4a1JCZFM0RmpEYStp?=
 =?utf-8?B?dFRQdVhnOGY4c05tMWpYUkFPSGx4Uk1EdjZKaExWaFQ2OUZ4UWlRQXZSM0Ft?=
 =?utf-8?B?cnYrK0tWazl1a0UvV2hVSEkrREdxNWZWSHJsUlRNSm55TnRoNkxHM0JIYXl6?=
 =?utf-8?B?MkVnZ1BSRi9tUThiOTRNNlN4VlZzeFF1R2tPRUFyTWpWKzEvVkxkZEhVSnNw?=
 =?utf-8?B?NUZiMVIxazZpemM1RVdpVS9jY2pidmtlWDhlbXBlTFdRTlNTNDh4d2hZWU5P?=
 =?utf-8?B?dVpKWDZtQ3BXZmZBajhreU9lUzlUZFZyelRtbUhkSFZFL1c2S1R4NEppTnFK?=
 =?utf-8?B?RTZ1NEErWFJrdlU4aHhWc0JwNTY1Q0ZOMS9IUHpZS1FPK1hUb3FVTnhVV2Ju?=
 =?utf-8?B?R3grTVhxOEJIeDZMZVN0SHQzQWdXdTZKWjJiMDlSQnVPZk9WQmVwYWxTV3gx?=
 =?utf-8?B?V3cyTVVLTHhJUVFRQmlDVDd4MXhGeEIvUS9zM0N4QVpJZXRndVkwdjIvZlFu?=
 =?utf-8?B?ZkRmZmJVZndEYWg3MDBWY1U4QitwOXFoZXBrYTlMODRzcUJkd2JDdENRT3dT?=
 =?utf-8?B?d1FjYUlDOGMvM2Q1THp3aS9RRDJ2WERNMU9JNTg4YzJ4djVtOGZacDNtS1FQ?=
 =?utf-8?B?WTRtR1dGNm56USt2WGFaWE9Helh1VWdNc0x1N3hza1FrR2dtb2g4WVNlMnJL?=
 =?utf-8?B?ZGVTamg0TVBZVlNtRklUeHk2aXo3WWNKTnpMVmFIUFJ2bmxLU1V2S1BQZzFU?=
 =?utf-8?B?SS9lTjhkQys2MDAzdUNDdnVxU3lnUDNpY2I4ZFVXVk9pcHBEL2U1M0FtK1lQ?=
 =?utf-8?B?cksxTVUydEdCWFVwVE1VWFI5VC9ZWUUyTmV6RHVGb0JyMVhNOFQzYWFnRTFC?=
 =?utf-8?B?T3ozd2dlazdvOHpXUHl0OHVEbVE2UWx3TmZPVFk5RytzeVpNelExVTlWdzl2?=
 =?utf-8?B?eGhaTFpUc3A1ZzZXZDdtVGhERExlZldDWFBUL2YyODlFaFVmdDVEUDRGTjRQ?=
 =?utf-8?B?Tm9qVndsQzdIQlFkcEdmY0k0RDU0U24rY0V1d2ZPVHVTNDRXdEdCTThib2FS?=
 =?utf-8?B?U3hFV25LNzUxQTZaTlp3SVR2N0hrMTJueEVFT1FnNGFHWGxHRUd3ZGFXNThP?=
 =?utf-8?B?WElZR2s1RXBZS3dEYjQxZkptR2x6QTA4amt2VmZKUnMvQUxTQXhXL1JEMlBM?=
 =?utf-8?B?TTU5SDVJSDBUck5idWtNNkxWbXFVUTNaSmcyWFN1Vk1BeVlDWWQxRXhGSVdT?=
 =?utf-8?B?N3IxY1U0ZlF1Ykd5bksxSVlaOE1ZcTNRWEVKYTNheWd0WWN4R3habFhGakVG?=
 =?utf-8?B?UzA1NklzMXNHaStxWnNzNkNsSHgrUXZwMjdrRnhvQUs0ZU5JMDJDbU1SNTM5?=
 =?utf-8?B?ZWtiUUVDZkhSaHJWOGpGMXpLU1FOdXJjNU1uZ1NpdDBmR1FBcStUaTg0RVlR?=
 =?utf-8?B?aENXdkUvdFJONmlDT3lETlFGT1p5SlZscEJKVmtGUUI1UVBiWDl5RWtjY2RP?=
 =?utf-8?B?OGU3UForc3cxL3FoVjVjKzRsQUd0L2dseDFWbnU0Qm9xcW9tdWdaTG9jUmxz?=
 =?utf-8?B?RHNnelFrK3NlQnFqTENwUVpFaGJadlpNVEpNNnJKd1BHb0VKYzYrazZaN2Ji?=
 =?utf-8?B?OGlGYXBtcEZFN2ZwMnJaeGYyZGhOVGt1Y21DMWxRdXR0U2lna3BHUUxqNzBU?=
 =?utf-8?B?R3F2T1ZrL0xMdzhoWWsyd25HTVh3WnlMOGlDRDd1TDcwakl4QWNIOFc0Mzho?=
 =?utf-8?B?cVFQR0VzeUgxR0s2K2IwN1NiWGpEN3Rpa29tQjUxeWZwaThub0VPazAzdTBH?=
 =?utf-8?B?KzcvcUxuQmhCVm9oNXlBbGpOZTk3UWlRSFVuNkVJMXp6QmxKYWZUQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b2cceb-5093-41f4-c49e-08deb03ad6c0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 15:26:29.2121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCCo0MJSgQYQcCqNGWOGcM047vUD7Px0gkW0XD6z6Eukh+96GWsYSz+Me56R5OCWe5Ea3mV3nKIe47N8PJuqnrXUx78fZel0btwsZg9NLSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6318
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

On 5/7/26 18:39, Simon Glass wrote:
> Hi Ludwig,
> 
> On 2026-05-07T12:06:22, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> 
>> (optionally) enforce signatures so we can't accidentally boot
>> unsigned fit images.
> 
> Since you are adding a new policy knob (FIT_SIGNATURE_REQUIRED) and a
> new verifier path (fit_all_configurations_verify()), please can you
> add coverage in test/py/tests/test_vboot.py for both the
> required-but-no-keys case and the iminfo signature path? Without tests
> it is easy for a future change to silently regress the fail-closed
> behaviour.

The function also tests image signing. That's mutually exclusive to 
having conf signatures required. Should I adjust the function to not 
expect successful image signing tests when
fit_require_config_sigs is on, resp only test the fail-closed mode if 
fit_require_config_sigs is actually on?

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
