Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04A0CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 13:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341A684A6B;
	Thu,  7 May 2026 15:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cZBciG1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263E784A7D; Thu,  7 May 2026 15:09:01 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC3684A57
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 15:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbAMtozkrWQ65Zti4ek7c2pVmVm4CDXGy+bs88mhGTca9k9/fixKtX0zM/pcVARUVfPk+DN0k0uVQGajtRdnbaJV5Qtk4AnBoxfdeAp91LW4UZi2u+IzccbJ5yUGXYYGuWAg3+piAcjH+d7VRO6EK1sJxzXXTRo+THWhtOGgH0c8eBi/dq3LN4D6DKXd/zSOTbU/V9zS1qqwqtt4pLeHA8decCCG/Z5piHOELp+DCI0dDesSdc9jZWun0ens9Zfbw8aapCm94d03muDl1YLwqcKgyYV62+aYnWf1FoMXNXpFJDOS3FDR0mXV0W7ZanG4rpdwPzLGZLvhIpuynPpUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzB/JR9BTJ7ecBVyN8iLMf04P+P2tZZtiBpv1LtNDxs=;
 b=fAcV/q+Iz8+ZVeOUYF69fddJvXT6SD8a7QBVu885EplBPMKkSLVVZ1kAurp076+G6/6Aa4DvSdIIGJWZZ6LpKORT9aUL31t8y3ZoGmK1kgwdXQoa/4L2XKU5nmq/6OZvbhKhXNSrSmhL5bh8IOJdniW8Tjw/NOwydGpv49bYaP8gIpOSD5xYAIODcLlq2qsZHOIXqFJfTEnAJD92yCTz/uHEEAi80+j+GmGXQkaLanjmmXDgAuOJ+iWfIFeyH6tANVjm6oJpwV8zMJ7kup/mJ2irGoZJYh+rDvV/qP9cWe4qAip00extjpbL83zEeJViNe6fzOwJbrDbF9IbVHvwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzB/JR9BTJ7ecBVyN8iLMf04P+P2tZZtiBpv1LtNDxs=;
 b=cZBciG1NIeuGUAqSkSOLe931IVMZKH8gpJ1u/0QFQFjC8vRdStVSDhafS9TpYSwJ3Rde0Pm6jK/ZAAeELAkb1sEdiPV0mgPD7aWtusZ1Hf2rFySa5K65pDg7lAIWcZt2jt2jzW/P7RBtdSM7wZYpgSH2102GVLfipVxvMHZGJ6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 13:08:54 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:08:54 +0000
Message-ID: <dc13566a-b477-4580-8954-0c0f83608ff1@cherry.de>
Date: Thu, 7 May 2026 15:08:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] binman: x509_cert: add PKCS#11/HSM signing support
To: Sergio Prado <sergio.prado@e-labworks.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com,
 wolfgang.wallner@at.abb.com, bb@ti.com, y.moog@phytec.de,
 xypron.glpk@gmx.de, jerome.forissier@arm.com, afd@ti.com,
 Wojciech.Dubowik@mt.com
References: <20260423154536.768603-1-sergio.prado@e-labworks.com>
 <20260423154536.768603-3-sergio.prado@e-labworks.com>
 <df749b3b-0210-4b31-a4e0-8f7af9084589@cherry.de>
 <CANu7NGs0=o5H7o=qwoQj5EYMxDtB7_NTus_-18Q1UZBnk3DiuQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANu7NGs0=o5H7o=qwoQj5EYMxDtB7_NTus_-18Q1UZBnk3DiuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::36) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf52d88-8472-4c97-3a17-08deac39ca79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Zq3D7j8GR+CNnEnDd//+yHi+D9LQVCm+qheIPA8tgnm3dJMAqVQfmAE6rHr3vDlY94EgUSOUrm9rqLP6NRcd659xa26QlCr4Q908egEqDJsxKUGRoo1H+rGhBQ8LAy+ERxsUtIKf9olEs4v24QNXvfhFZchifaeO8PofxxP7dSTAZubzTKJLyQFF05Z6EDhNpu5UsJd1BL8spYozuhKV4ZdUeaQTAyjXHgAdfcHRadq3JZz3O9kJtouICLazpRMlnfgyWtK5BYa8sH3k0zTO2adIjUEM7KQWuJZ5PZmfaF0E3GZ99R6+7z/AGNf6BUd5Clp/Gh8B0l70DUV1xvSUZrkgHGdFdOiQY+/RR6a8M8coKbRIx4ufcLj9DckQ4j+Q+1JpuS8P5sHJqBEm3cMwviafmcuQraNqT9GKo5CTDKBF8AG56tM13ijt7v1DkCyIrlsShHXKT+DOjAWe4s2J0FjjX+LAeaSqQLwqQUcem6wQ5h+VPjfsRHK163uDDGR55MV8ZuFNnQhlIkD884HXkHDpvXyQz/L608MR7IwaZXVG3n0Ur0cQXyb5g/WInUpNM5yEtltemhabOiJ0E9Isuk9tWi9tcynv4nUhgdHVo6+QRlLCE6Q0HeMqgDj8FSTtuOqbyMAMpKOX9RS44iNZF+S7N/4VTARlqhpOcbErZLG01JhrlYtaanAjt4c7tD8U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czBrMnhHaGw2bHMwSTh4ZDhrL0pxdUZCZWYyWmNBeW9lUUpwQ0lJeVhpOVU5?=
 =?utf-8?B?NHlTOEdiL2NISVY5VlFmOXlwLys1Mmk0bmxnMkJZbDZRSnJCKzV1aUwwMTJj?=
 =?utf-8?B?NHQrUEpLcG9pSkUxekpESjlKZ3FRVU1jOGpTY0o3Wk11RjVPa2Rsd292aTc4?=
 =?utf-8?B?a1Z1WDZySDZLZ1ZhK1h2L3BPK2tzcGY4OWE4eS9DSG5OTG4yMTd4bVV5M2Y4?=
 =?utf-8?B?MDdtV1p3UnIydEtWVGhGakVGY1ZvVkk4TTJyRFpoUDBEcUtzSThYVGhmREhq?=
 =?utf-8?B?MklGQ0R4bjdNK2Y3VWdJazcwMWUrU01PTnE5QkdUYlJwaXo5SWZoV2FFQTd6?=
 =?utf-8?B?dldJVjNrU1FTTWo0OENDaE1XRVhHbEZSK2dsemN0Q0FjY0VmSUlGZFVzMEpZ?=
 =?utf-8?B?TzJjZUVUTVBWVThTbkNVRTNZR3hEekdNR0ZWS2pvTEVobUUrR0hHSmJmTkdJ?=
 =?utf-8?B?V0ZwQ09nbkZUQXR1NERFQndUWnNYUnU3SG8xakFFc0NMdXIzY0hyRTUzTTMr?=
 =?utf-8?B?dEVacmJoUTBPM0RvWTRWTDFkWDZIelZIL0RId1VoN09lK1ZkSmd1Sjl0Q1Ba?=
 =?utf-8?B?WEpHaXNJcWlDNitIenVTaHp6OThmdG9HKzlja1lvanNIMXdqdzRuQzF5S1VE?=
 =?utf-8?B?ckc0ZjFuTVFxYTFEUUFIZzg5bmlhTzRyTTY3N2dFZ0JyemJoYkxsemRNeEQ3?=
 =?utf-8?B?UGVRcEJEMVV2azZMNFpmb28vNEQyTGkrbnVZZCsvRXFTZDVUZGY1OTRjVnR3?=
 =?utf-8?B?Y3dnL1FEMlY1Njg5cmdKOEpJV1hUVDhmN2lncE1rWkhCU2JyWFFKSkt3Ykxs?=
 =?utf-8?B?N000ZGlSVDRJQmVoSHUrdkJaTGMxUE9IOXBYaXpQRC83K2k4MzR3YitGTmdM?=
 =?utf-8?B?aE42OURFNEI1anBaMnpBL1lETUpJVy9TNjN5QmIyb3ZVVVVsZnlPbTNjckkw?=
 =?utf-8?B?VVVTdWZab0VKS1ArY3VyVHJvbUZxUEZQS1Q4QXhkNENmdWtWWnhWdjF1Qy9Y?=
 =?utf-8?B?VHR3K0ZHZUExaTJ0Z28zRzc5K3VWbGw3bnhrTDdCVzZzNmkxVjg0OHB4U1dk?=
 =?utf-8?B?UkFGTDkwRXRQa1lEZTJ5cGhoNkdQMDBEVGRpdVJtQUhCUk1sbVpMbmxveHpw?=
 =?utf-8?B?RGRlL2UrV0lPNzZEaWJSb01XR0JXQ3B0SmZWdGpsemNNeFJyeFJOdUxOckFu?=
 =?utf-8?B?TlM2aTlDU0YyN1FjN3ZxWjA2aW1tOHpRbkNlWHFmNVRlckF1cjN0S1FDVWZs?=
 =?utf-8?B?K3I3U0tidEtpenpBdVNNN2QrZ1lTM1UzQzVEa3BBc1RmYTIxRzV0ZSttY0Ey?=
 =?utf-8?B?bk4xVjhUZ081Z2pvVU1laWR1cXJ1YzgrZWp0TE40WmlNQ2pVRUtPL0hPNHkv?=
 =?utf-8?B?UWFsLzdSeXdHdTlVTjJIeWd6ZUpNVTJITkVVVFlQT2RQdDVPY1VodlI1UGxV?=
 =?utf-8?B?RHp6WFNJclJHeGxDcFB3bUJHb2tPNlcxcG9hZCtyTzd1VTcxYXRsZXlTYWM1?=
 =?utf-8?B?aWNhb01XSUZhWkpSdHpqUnpqVzN6MHIwS0V5SEtxb2I1NEZSbE1Fa01SVTFk?=
 =?utf-8?B?cnZUbllIUmE4Sm9hZzdzQlpaWnhjT1RBMGh5cFNHcTBtMlg3Sm1SS25BMlpy?=
 =?utf-8?B?eVdyZnF2Qm1VanZXZjFZSlQvckp6RlJGSjlENXA2MFcwSU5YeUsyTlQ5ZEJw?=
 =?utf-8?B?ZHJsN2ZpS09jblRUdUhvcjFEMmZsMk4vRW1xM3YrNmpCMFVJOW5yTEUzYTlN?=
 =?utf-8?B?dE9EbkNHS0ZOL3hmS0Z5cnMrcFV3UktBZzJGQkEzVjcvWmVlL0RMVFIwWW1s?=
 =?utf-8?B?eUlQbE9lUjVXVG9sMkgrVUFTbXBFNUJQNTV6MWZQZ0NaREVuTHVRWExRV1ZC?=
 =?utf-8?B?Y1VEbGRTYjBLTUI3Wkh5YUwyWnRnWTV5LzNGS1NsWG1PRnRNbEZVYVp5anlF?=
 =?utf-8?B?QmFVRDdLWWVoKzQySGdtVVBKMkZvdzEwd0JvYkxLZlFvQWxBbmpKWEN3S3pu?=
 =?utf-8?B?TnBSUTRoNHFKb2prbFVmWnEzaHl2QitBUUhoM0p1N2xiamlvY0JBTjRUaGdR?=
 =?utf-8?B?dHNQNmZlU3J5R3I4VDNUaVFaSVM2aGRSRnlGa3dMRXJaZFZHaWVXQ1dORWd3?=
 =?utf-8?B?bGRtWVZqc3B3bjJ1MDgzM21VVHlwM01yMjFoc1RrQVJuanh6aEhMRmV5bzFJ?=
 =?utf-8?B?TUpJZGJVZnNIcGNtdjgyRlh2dHBQRUtJVUZMbWtiZExtQ2IrLzI2MTdEdFh6?=
 =?utf-8?B?bzhML1ROYUJMM2ZwUUdvS0FEV3lZc2xHQnZFT1l0ZCtwdmhQVXNHaHMzWkVZ?=
 =?utf-8?B?WE1VMHozVkhHYVJIcTkyMi92TEVkNHFrUFFBbFRqVDZMMVNrUm8xZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf52d88-8472-4c97-3a17-08deac39ca79
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:08:54.4440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZy1xbgwMe9J3VDstYx7MGvN29bvwTzfLrquAHtwNcFkhVOkgkNqTLcgNB4LJie6kaQVq+1zFBusNQsqaVWYMDGhcmjR9Zc52rY/dVs2YYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295
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

Hi Sergio,

On 4/30/26 8:23 PM, Sergio Prado wrote:
> Hi Quentin,
> 
> On 4/28/26 X:XX PM, Quentin Schulz wrote:
> 
>> +BINMAN_PKCS11_MODULE
>> +    Path to the PKCS#11 shared library (.so) for HSM signing. When set,
> it is
>> +    passed as ``-a pkcs11-module=<path>`` to binman. Only needed when the
>> +    module is not already configured via ``openssl.cnf`` or the
>> +    ``PKCS11_MODULE_PATH`` environment variable. Typically used together
> with
>> +    ``BINMAN_PKCS11_URI``::
>>
>> OK, but why do we want to have this variable for storing the path to the
>> module lib instead of using an openssl.cnf?
> 
> Agreed. I’ll drop BINMAN_PKCS11_MODULE and rely on external OpenSSL
> configuration (openssl.cnf) instead.
> 
>> Also, this is stating it's for signing boot artifacts with an HSM, but
>> that isn't true. It won't work with FIT images, which use DT properties
>> instead (see fit,engine, fit,engine-keydir/key-name-hint.).
>>
>> I'm assuming it's possible we want different keys for different boot
>> artifacts, so this is also a bit too generic of a name?
> 
> Good point. I’ll scope this more precisely to X.509 usage. Would
> BINMAN_X509_PKCS11_URI be appropriate, or do you have a preferred naming
> convention here?
> 

Is this really PKCS11-specific? Is there no other way to get an x509 
than by PKCS11 or plaintext file? Trying to think about potentially 
having other providers needing something similar and then setting 
BINMAN_X509_PKCS11_URI for that would be confusing.

>> +# Serializes concurrent PKCS#11 signing operations. SoftHSM2 and many
> real
>> +# HSMs do not support simultaneous logins from multiple threads, so
> binman's
>> +# ThreadPoolExecutor would otherwise cause intermittent login failures.
>> +_pkcs11_lock = threading.Lock()
>>
>> Is there really no external mechanism to make sure this cannot happen?
>> or maybe some sort of session concept?
>>
>> binman tests will run on multiple processes (see ConcurrentTestSuite)
>> when not instructed to run on one thread (via -T 0, used for test
>> coverage). My worry is whether this is multiprocess safe (hunch is no).
> 
> OK. I’ll investigate whether this can be handled externally (e.g. via
> token/session configuration) or if a more robust approach is needed.
> 
>> +    def _pkcs11_use_provider(self):
>> +        """Return True if the provider API should be used for PKCS#11
> signing.
>> +        ...
>> +        """
>> +        if self._use_provider is None:
>> +            out = self.run_cmd('list', '-providers') or ''
>> +            self._use_provider = 'pkcs11' in out
>> +        return self._use_provider
>>
>> Why force the user to use providers if one is available? Can't they use
>> an engine even if a pkcs11 provider is available (e.g. you have both
>> pkcs11 provider support via softhsm2, but only engine support for your
>> HSM). Isn't this something the user can specify via openssl.cnf?
> 
>  From my testing with SoftHSM2:
> 
> - Provider-based flow: configuring openssl.cnf is sufficient. OpenSSL
> dispatches "pkcs11:" URIs via the STORE API without additional CLI
> arguments.
> - Engine-based flow: configuring the engine in openssl.cnf alone is not
> sufficient; "-engine pkcs11 -keyform engine" must still be passed
> explicitly.
> 

Being curious now, I'm wondering if setting the -key to 
org.openssl.engine:pkcs11:<key> would be enough on OpenSSL 3.x? C.f. 
https://docs.openssl.org/3.0/man1/openssl/#engine-options

We of course cannot use this when we still support OpenSSL 1.x though.

> I would be fine with supporting provider-based flows only, as it simplifies
> the implementation and covers my use case (OpenEmbedded integration).
> However, I’m concerned about compatibility with older distributions where
> PKCS#11 provider support may not be available by default. What would you
> recommend in this case?
> 

I'm tempted to say "another person's problem". I was already not happy 
to contribute support for OpenSSL engines in FIT signing because it's 
been deprecated for years at that point but I needed it (could have kept 
it downstream though). We just need to make sure it's not impossible to 
support if someone really wants it (and it needs to work with OpenSSL 
1.x I believe, even though it's official EoL you can still buy 
commercial support for it).

Cheers,
Quentin
