Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A13CA0EED
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 15:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D44781D5D;
	Sat, 23 Aug 2025 17:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ipUus3Ra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF111830B3; Sat, 23 Aug 2025 17:11:49 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7245380422
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 17:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vfz65viDlItnewh6qnBKp60GuX9d3Pdje0DRKRVjcSPh193+d+/ufa6fw7ExOgIuViJLRiG7mzFOBBQ3zu2LWAjiGwWaXoJRfGnCbcjKBUqScKd+LRCPyg8xMj5gMP3/DpAjG6LB97U/T9L6gWBs6Tz6a/b/CUe+KeZ/ijFG/vzCs26eX6EnfGIlU6DDh41Aqjkd3cXGIrWtFVUUhJ4RRKlWTooqwWuF68VrDCWVlgvRnz3r54lGmCv+Ee6e92xSdhSKz1crn+rRH/UMU2ZxZE/xiLRCmHCdDdCuSFF1VMk6PLKSE3jU+VPYtcsO9IiKc46bNfatLsPlll9A1uTkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezMoyVIhrAlZ00uGT8ZKaRqUKKdC50cOb/v9rrvDRnc=;
 b=JfFc5AcC8Lzd/20puADVjiAS1026vOLYbqKE8bIqQzbHzKqku+apwheXvPgRcHBYaQpAyo+9CagzFPO2GVobFZ0riLBWg21/tL9+sxADzBZJJ3QFaJckZ6UGMYruybauRugrlhWD/7nLigz4kbBDTDIBNfHzZOkilfyd1ikIzuTMBkX+6O6yvcmWi3xhyaT4jSPBAZUQfNnHidQ2kSss4ec1ge6+5sUUGHCaoWFX23cZLgGsYmlsw6bNn40HLAgqrcN3KLEXL7PxbOLRPrf1GQnIjgzENt6hxuxL3DB/g/4ChqwGbO06w71Z6COl+gSMDSERsLk7kG0LX8oLDeT4Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezMoyVIhrAlZ00uGT8ZKaRqUKKdC50cOb/v9rrvDRnc=;
 b=ipUus3RauvmMp1oAyuTYJXqMpctOsOhfCkM6F66vybc3QW6SI8zJYgpaRKdkTAALpLCfQVsMU+16W4PAhXHuauOudLUqr9lhP2PE16e/w/yN6JUzEYb5PO98c743I9gJdfdbf4p1SDA7h5tW0kUk4hhUaekPJrc2mPEDlv7L20hnALKByHZp9SvgIsrPmowfTjfYduRFN6flYoCdBiq6qJz/Y6F8f53WGiaj+VjEu0ZLYdH5/7XKXBvUbJ+Nss1I5njBsWGl013gXNZXjAhiztM43aP3/ykwU/QewnOmAZ/i8Hvj8zwCn5AfO+2rrQKjuBe57hz9cLef8fZViF711w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6661.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 15:11:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.017; Sat, 23 Aug 2025
 15:11:45 +0000
Message-ID: <1555b61e-5f76-45e9-bdce-37e9e1933f93@siemens.com>
Date: Sat, 23 Aug 2025 17:11:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: Wait for logo generation before stripping
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
References: <ea8ba903-2066-4fd6-86b9-58ad944c7f27@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ea8ba903-2066-4fd6-86b9-58ad944c7f27@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 864582e4-abb6-47a0-7f4c-08dde2575f59
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHc4a2d4cGs4OXk4UGVEQU9nMmhuVzRRdVNoMnVwdzQ3bC9qZ2t3SnpOZnoz?=
 =?utf-8?B?OEdhbi9WelVrazNhajdjWjdTMmFxTGcrUjVQMGdkeWM2UUNZOFVBNUMra2Jz?=
 =?utf-8?B?MWNTZFpyaWN6NGZLU2FSeGg4eU5aU3E1b0VGY2FNS242eXV4WERkN09SK0g5?=
 =?utf-8?B?R0lJOVhpSkFBYUZOSUljMTFZNU9iOWxJRmQ1OTcvVk03NXllLytHclQrRmho?=
 =?utf-8?B?UWd6ckh4N2d5OFc2dm9pS3lDOGpYTEFnSUtQM2pkYVdzS3YwWnArenBOd0Q1?=
 =?utf-8?B?U1ZaalZlelhWaWlRS0dOcEVEbE1FQnRNcGpEdVR2TTRCdkhPdlk1ZDA3Qkhq?=
 =?utf-8?B?cmV3Y0dHejVtQ0QyRTBDUnRLVmR2d2Nvd0ZSYzJuOC8wZWFSV1NtNWZJL0o1?=
 =?utf-8?B?aWFyeWgxbCtQY1dnV2tjSUpYWllIUUh0TlpqZFdyQVJnY3BjclFuQjJhTWZ6?=
 =?utf-8?B?NzhOdmtCdWFHS1N4V0lWWmxFQUo3QjRzNnZ2VmM0QW5YWGdkN1BoTnoyY09r?=
 =?utf-8?B?UGcwNklMdEczTUMxb3Vzbk0yYkxzVG1HdDhmb0dzRHJzSWxFL0RVeUtKTEdH?=
 =?utf-8?B?WHNWeS9sSHBNUGtZMW9Ia29qanBIRjdySnkrZzRzazhpSngwL1UwdHYxMmE2?=
 =?utf-8?B?WVFRcHd4V3lQdG4vNUhocG9lOU9qR3NzaW1FSjl1Ny8yREI0SDkwYjBDU240?=
 =?utf-8?B?dVhvdDJ4NmRWRGZjSWFoRmEwbUtBSWc3dEw1cUpNYitYaWkrUkpYc283MnlZ?=
 =?utf-8?B?SnVOZ3RzY2sveTRuL1hiK2ttN0NWeENGVUN0Z2Q3Q2JKdElUelVPU0VWWTJ3?=
 =?utf-8?B?Y3owOVFORlI3RGZZSGNKN0ZjNzVPblF2WWtDSVk0ZHk2SEtzaFRGMlV2Tjd5?=
 =?utf-8?B?ZHpqY0pKaTVEbWtVZjNvSGlaT1JEYU9XQmk3bHVxSEhETmZTSXh4Y1VBYVU4?=
 =?utf-8?B?Y0ZRQTRrY3k3ZTY0OTh0aHNVa01KQUdqSDlzWW15NUg1QlJoZDdlek9qcnU1?=
 =?utf-8?B?YzZ3bWd6dmFCMTlmbWVlYjdmb2d3UzZVMjJVUmF6V1VjZkxGd2xaalNLZWhL?=
 =?utf-8?B?M0RwL1d5ZmpkSUxVRHdEY0FMY0Y1ajhzbTllbTVWVHZhTHR2ZENiM3RXZlRX?=
 =?utf-8?B?KzIxeXo0ZnpZdDhTUnNtQ1BWMWJTRzFmb0dHWkN1WVBqWVBmWCswZjJLTlZr?=
 =?utf-8?B?OHNsK1UvWGNPa1drdDBhenJHWDJycEVOV2xJK0hwSTY3Mmw5NE5nektYeWNS?=
 =?utf-8?B?ODBiVW8zVGFHdDZSN1IzSmI4RHRMdUtGaVQ2a3JsbFpTYjFXa0w0bEJqYmlQ?=
 =?utf-8?B?RDBjL2srdldjMmc3blBLS21BZkkyRDZqMW5lcjN0clRHWTZXUForbnBXUUxL?=
 =?utf-8?B?Wjl4OEVOKytha0VBRmlzaGovamZEbkNwc2Y4Uy9tOCttZlpuM0pzZlJFcmVh?=
 =?utf-8?B?TlBDbGVFZ0NPUnF2dmJtMDJmblZOQzdjaHZxbzNZRDFJaE4rSUwyNWlUb3A5?=
 =?utf-8?B?NnZVNzZhbUZnbVlaeDdRbXMyaEg1WWhpV3kvemc5TW53cENzUHZXODNsb0tG?=
 =?utf-8?B?em53eExxZkVpUi9ldVR3OFFzc2VjYzVFSEsrRzZDeEwxbUdtcUhGYSt6V0d2?=
 =?utf-8?B?VC9wZzdYdm42SkhYVmMrZkgzZi9yem41aCtiU0tjMlVWTTIrb3BscC8wOUdK?=
 =?utf-8?B?OUdQYS9VaVpaS3VxdUF1bFV0TEwxcW9IYUpoZFZOVEVnOHViL2UvMXptN1Vi?=
 =?utf-8?B?cjdBMjBqR2h3YVc3WXVQM2M0TmJOL0l6RDdySjdhT09Zc1Y1aldhMmxnM3NI?=
 =?utf-8?B?SjJWMkFmSS9XZXM0OW91TVIyc1lDbDE3UkhPeHZQTWV3MXU3RXVabUxwejBr?=
 =?utf-8?B?K1FOMEZTTjEwTEczeFVsSDV2Ritod3Y4ekhiYzNYcDUxMDlvaExZaHB3azBG?=
 =?utf-8?Q?nmq8ryvygKc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um5EbmNRSlBBSFJEanlSakFndmdpOUszV3Z5Rk9VR0U4UUY1MlV6UVRwaGky?=
 =?utf-8?B?MmQvUWpWb1ZoVTU2N2I1cW5IWC8xZUF1VHFSanJycmUwRjRsQzd4ZDl5Z3Rx?=
 =?utf-8?B?VVVyUlJhSFlmMXFwcnlkdVJWN2lUQ3g0ZnErV2dUUk5abjM4aG56Und2K1dX?=
 =?utf-8?B?ZXpDdkh2djYwY1FtYVpuM05CaWEvMUN4c1JtMStZeFVtUjNieDF5UURPNVFz?=
 =?utf-8?B?T0Mya3JtWGtJaWFPMU1Ca0NXaWUwemVYeVN6TVNjMWNNOGlsczhEYUVwNXBX?=
 =?utf-8?B?YXVBL2RnSW5PRjFJSGtGb3dqK1VNY3BsQ0NxUVNKUVUvZVR1RVV4TXlhNCtV?=
 =?utf-8?B?N09lRzVqSENTOWwxNHFqRVlSMVhVUENaRnJQcUF2Z1p4YWFmZmNETzdQMDI4?=
 =?utf-8?B?UmZZQnlFUlIyZnRrMlNaeEt2Z0k5YVM5cVRKeTF6aFkxNWlEQVFNSEtpc25x?=
 =?utf-8?B?cTZEQzd0UWtSWTdnQTRwenhocUpMaXFlYmdOWHBDcmhHUU9xcmUyaE1TZ1Ey?=
 =?utf-8?B?Q0gyMFdGMG91R0QzaDhaT2x2TjVMTmdiWXlsQ3BNZHRyR3Nyb1lKWVZOV0NV?=
 =?utf-8?B?a3lYL0taTVpyUExWSjEvazFTYlRZU0hYSjcxam5qbkVzek4vcFVQT2ZyT2k5?=
 =?utf-8?B?cTliUURsMnhNaWRKdHBoVmVVZHI2allEekQwOTI3TEp6ZHFYWlZRU29BeWJx?=
 =?utf-8?B?eVRrNk9XVk5LQnFrNm5tV3hBUXBsU2hiT20xL2I1T0FiTFZ2SW1EM1BDZkxT?=
 =?utf-8?B?SXJHbkVhUWV3REU5a0svRG1nbXZicHBRRlJ4RWp3WkZFRjdsdkNLZWtSU24x?=
 =?utf-8?B?dmRyUGw5Q1pJNzUwSUo3ektUS21CTVZGdzkyN0V6blk2NDdwS1VHdkx6amc5?=
 =?utf-8?B?OVBkQnErRUY4SEwwV2tWcHJPSkExUmJkU0dwYmplNVRUQmh4Tk9sTEJWL1VM?=
 =?utf-8?B?Qlk2NGhSSDd1NlJiYUx1eUVjeUx2cCtJUEVXbFRsclkyMmd3cXRCM0JDa0dn?=
 =?utf-8?B?MksvRW9EMkZqOHRzd3FrZ0plM2JXUDZCZkN1QzNyU0pQRjN4MmI0bGlFTEgz?=
 =?utf-8?B?Y2NKQW5SbklYSXV4ZDVvZHJQMkFWLytCZmpoSlUzWEtpZGVRa0Y5c1ZBOVU1?=
 =?utf-8?B?N2NFRUJXMElJNjlPdXdmcFFtZ1NmelZscjd5c1ZCU1k4TTdTKzVGeXhpOWZM?=
 =?utf-8?B?QmgxV2kyT2lGcXArOVdVZ3dyN01LbHU1NGhIN2EyZ0g4T3BSSis5T0pLNlpP?=
 =?utf-8?B?SmFPNkJEdDRHN3Baa0NDeWJXTnRSTjloWmhqRUZ0eVJTN2xHa2lTVUh6a1JB?=
 =?utf-8?B?K3VSTE4zTGtDKzlBajMvYWIxUFNIeHIwekF6Y3dDWklKejQ3ZU8zY0taNmpv?=
 =?utf-8?B?MlpJVDFTblorU1Zybnc1V0EvM1F0N016KytVTmtvVWZwZnZtNENXQ2sza25R?=
 =?utf-8?B?Y0pVSmJvS2RhSXlLcjBnTFlUbWlYZGMzMXphcVI2dU8wV3diU2xtKzZWN0NN?=
 =?utf-8?B?bGlPZ0ZuTlA0REtUdzRKVFpIN24xRCsycnc2RzFlZWwraWExOERDeW15UG1v?=
 =?utf-8?B?Vklud3kyVFF3Yzh6ck80QVRhS0N2TFhYWTNGR1Bia1ltVnB0WG50WnpCaVBI?=
 =?utf-8?B?cEhoVkZOUGVwZ1NEOHA4dTN5U0ZSc1Q5MzdhMG9qN0NmMk96b0hXS1RKRHVy?=
 =?utf-8?B?Y2xqZVMySUtQajJLcitWeUJBL3pxZktSWndLS2o5ZUN2REM2ZjlxQ2VoTzZT?=
 =?utf-8?B?YlZybmhCQVY5cnBTVStGSXhUMTJENE9LRFhnYmpFUDVENWVaQjlWTFByUnls?=
 =?utf-8?B?OGFtTTNVVDVRa2V5VGdwMDQxVWw0dlBiRjRmRmFFQ0k0MXJYWUlSRGhrcUFy?=
 =?utf-8?B?Tm4rM2ZHbU1LeDRVaS9pcVd3ZFB4amE2T21FcHZiMzlHMTJIUitGNmw3TG5z?=
 =?utf-8?B?NzhIck9jT1ZEd2JodnBSdkN5VVVGbEZWOHFydVB1eHNjTlNESGtYd1JCSXF3?=
 =?utf-8?B?c2dWcmdtU2hxU3RoSUJ0dWE5WlpzU21SUUZ3eWwyK0lyYkYvNlllRGhDQTYx?=
 =?utf-8?B?d0JjUGFMVjNGNkN4MjNnKzRDNDA2Y2dTT1ZuU1cyUUR5K2NEUTVTWkJhL1Na?=
 =?utf-8?Q?mBBSB9PvThO7DUVa+9766YKub?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864582e4-abb6-47a0-7f4c-08dde2575f59
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 15:11:45.0147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkozyFO0qLOEPGV5rTbGeoNCuCmiflpGUUPgOZnQ/jqig3Vxc+OwRse6JHaApODVNAysK1tK85z9J6mPjmFBVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6661
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

On 23.08.25 13:30, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We otherwise risk that strip will fail because the bmp_logo binary is in
> use during a multi-job build.

Strike this: I had qemu-user registered which papered over that "make
cross_tools" actually runs foreign bmp_logo on the builder. Make the
build fails under normal conditions.

We need to disable that execution if CROSS_BUILD_TOOLS is enabled. Patch
follows.

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Also feels a bit strange that the logo data is generated when one asks 
> for building tools. As long as that is the case, we need such an 
> ordering.

But this behavior remains ugly.

Jan

> 
>  tools/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index 02297e8c93a..9b8a89e66e6 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -356,7 +356,7 @@ override HOSTCFLAGS = $(CFLAGS)
>  
>  quiet_cmd_crosstools_strip = STRIP   $^
>        cmd_crosstools_strip = $(STRIP) $^; touch $@
> -$(obj)/.strip: $(call objectify,$(filter $(always),$(hostprogs-y)))
> +$(obj)/.strip: $(call objectify,$(filter $(always),$(hostprogs-y))) $(LOGO-y)
>  	$(call cmd,crosstools_strip)
>  
>  always += .strip

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
