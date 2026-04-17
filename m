Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF68F43682
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 600DC83EEF;
	Fri, 17 Apr 2026 10:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="b6Jx5CXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670E5841C2; Fri, 17 Apr 2026 10:59:10 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2532F83B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NK7ChZoTAIqGHqkQvgqo3FIMQkbtD43pDKhj5FGz/5nGoghOEZeBBbWH2UX04pVPtMS34Wpl3tcD1DilleEIyBY+MIKFpglFYaV7biYHtAoouJtyYlOfuxbx7R3qGN5TlMnbH8rv14brAbQ5YT5RIjd+czTIpg7pqIT6PZPSablOpb+I2eZt35+eZieMWYgHRtQzFrVVbDYbn+OLsX6T9PuDakkLZuL4tbs6fVsmbIrHnEiss5AGZz52qvVw8Ncb7yvI4ls3IoJI7wGViyuxytPb7wEg25XiXxrNGkaEierWsDarTEeXQfsJMeosmLoUWBMutb5RsLsO4w7uJer7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw1PwMgw+9mLDRnQdlUTYFpQ5KUUeiFJ1PRyPFS2Ufs=;
 b=kZG/nY/VbhbCcYQLEkHpuoM5XLMuVBZpIPP1XU5MKKKpHKNL+dhrWF7s0ZrmtBcSyIcmCq4nKn50w5ftZIGQQLUEBso5qbLcHRqkWBgeoaU48qrCwwDCIbNzvuyTvMIIfe1W8BXjYanSeJ7cPZvqDNV5SXfEavgL2taSsmr49b+S4KNd1F7znuc1/G20Upiom7W+um0lF6MM0RaNCuww0HaZcQoRLt/Hxu+uYBNBcZQx7CoYvNEaSiwmzt6qf7PIy67OyKIZiVfg/kAuUwUEEXEQ848Pn0pCY9PQt+qV7pbLj8upW5V8AWk2pT+gH6c2VHAI2ev9iIhUy/dMcY1kxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw1PwMgw+9mLDRnQdlUTYFpQ5KUUeiFJ1PRyPFS2Ufs=;
 b=b6Jx5CXy4InKsWhGLXkITyVA/LtISlJxN9TfPvokHq/gzYnoxAd66JwLuu5gUrdbKx6W7r/VZ9h3BYgL5TVAVpKaLpVvUFK/fVnviEQI89llB7qtmn3Tj356+z05Q0kVCzZ6DVeG5SvwCF4P1DQ72a3TKj+Zex67IbqPsKbXYuznuYUC3Ueib3FlUkgUlAZ2UiQ4XE1rWKyemB1A7ybSVHxE0/cXLDbujIfH+qPEbQQVKzp9ZlUPRtR/pXg1MCwozlTdWeak1RUwcP3KvdBZb9SNEALVKZGVOblxUM7tBr2dFdzbYN7D2lJ/AhfWkRB9dUNKLKRTOSmjpYteC2M/Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS7PR03MB8094.namprd03.prod.outlook.com (2603:10b6:8:252::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 08:59:04 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 08:59:04 +0000
Message-ID: <2ccbcd51-eba3-4e00-b99a-8d8736c26440@altera.com>
Date: Fri, 17 Apr 2026 16:58:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Fix old TARGET naming to ARCH for PL330
To: Brian Sune <briansune@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20260407153650.26404-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260407153650.26404-1-briansune@gmail.com>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DS7PR03MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: a438ee98-94e2-4bc8-d9b0-08de9c5f9318
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: rc1X9qxvDPGxFcb77jIne/qo51wIQtmhpRbhTLjAwJCJ+3zBjcfsecKjFBhPpPNxCAFhYs6DQ66vUbtVsAffMgSYbqlEyWKzLkwGnf2iG+7TS3VuTrjZe/4LJPYPLInBrleGlUoRoIULcNXXpuCmiaEQ5T5+7wQbN2DxhVDfB+tSBjqaaXSv7adBcHKl3WYgG6S2XXunTjlQ4AYMprT1uZiwfk1o8206usDnpvPIae/Pb+DaQ5b3e/F2DnxOOWjuU9u8HRfKZftyDrDi5XwvuwWZCGFBK37YMlfX2uXCFx5FuhyX/bwlzdSVvs/0I6KxJkkf48ZKKGttsCN3OBom06TIAt+31nCU5ubnYJll7Mg+Hv9/FNlaWG+YEWmv9XxHVkpt5xSUZXTJi4hGQmQJvZX9Y4JNZruyaoBvxPHO4TQW+ZU3oEfrHfte1l4a433XYThyRSRg1BrOkaDca3hl5lJcn8hm1HCErOOSkC/l+R1Cbw2eqBRoUa/mx/vzy02WPqRlst9YajgTFBDuwamNF3mpCz0S4i4+5zMk+Uag7qzO4UZuSzv7HJkcseNwQ5SrjwTqQaTrMGbfupiLFwrt9q+w1+o7f3a31NJZBn9f3wio0bSlzhTEh5HnhOsyjKhPKCs7xjNT43KancQ/oLKEJKXI/DE5X3SPKfRIqhnmfYiQrDestrvt5yPJ3J6bN6CZKiDIumy1jXQB4SKPZ6vuO5XtzrkXke+8opQWekrj31s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(56012099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJkTlBNeWdmK2JJWE9OTmdmUW0wUFBTN05Zdm5ycUdYTVB1L0hMUno0T0Ri?=
 =?utf-8?B?NWpyZVBPMGVOcHNiWkNLRVpBUXNNS0ZVVC9IQWhXdGNwVkVVYnlKZXJNQ2Ju?=
 =?utf-8?B?YkdsR1Q5NEdiWVl4ZGQxa01PamRxeEJITldiVGFtZHBaSkxHSjVpaFM2WU05?=
 =?utf-8?B?UlVWR3k2MU41dEExRlNkSU1aNWJUNys3amxrdVRJcHpLcHZBdzA1eS91THVa?=
 =?utf-8?B?d093VStBMWRBR21GVVZ0UzR0RHlCUjc2a3JicC9lZjcxcmdRUlZ0R21FT1Ez?=
 =?utf-8?B?K1VPVE9qV21RZHZaai93alB5SmdydXQ1TGVld0t4Mnd2UlZJbGxPZDV2eldK?=
 =?utf-8?B?ZGQ1dHhnamhGYmpTTktoalpCQ2hRdWk4RVRXaDNEc3lWa3kwZ2tmYnIxSlpx?=
 =?utf-8?B?NlNNemMwa09zOEhUQWpDZzBBYk96OUdKbjhFVEVDdUh1T0o1WGpuc2wvcnc2?=
 =?utf-8?B?WUp1TmlDVVBTclUvWFRtQ0ZMT1FadWowek9ROHd3R0RvcGhWZzVQdmNpN2dh?=
 =?utf-8?B?QjFleWhVWDhQSHVBZmQ4M2NZS2xqblNjQTVkM1hTWXJ4RzBiWGJOei90SjMy?=
 =?utf-8?B?RWJjNXZnWXJrZVFlSExvZXZlcUF1bTJjRHRoOFowTDJiNk9oTDZTNGp2UGZO?=
 =?utf-8?B?K3ZlU1FVeENPTkQ1VGMwTXlPQ1Z4TnZvc1ZoMFF5UDNGRkhUcWhqSStoWml1?=
 =?utf-8?B?SnMrSVB1N2kwVUp1VElkNmtmKzZtWHdBd0dGUU9Kem1YOFRJWXdMRzRXVW1w?=
 =?utf-8?B?T3FQbmNZYVh2U1VTUTAvMXhBSHF5UktuL3A0enovZ2NsU25ic0pZbWdUTlF6?=
 =?utf-8?B?VEpZR3RaUDIrV1hmMGdoOE5naFQzc2FrcVdSMGE5ajVodTNrd0dGTFk4TENC?=
 =?utf-8?B?ZlVEMjZjTnNoR0tJeUsxNDdNRkdjbnBjTHkreEtpSm1xaTZiNU13a0orenZo?=
 =?utf-8?B?TTZIQkF1OHBxbHZ1SVRNZmtLZHRMakVEVzZpSUV0T0ZyL3RmUnB3NTJqRUhz?=
 =?utf-8?B?cE5Yb3hMcDBtUVM0dTRpVzlVbTdyTDI4cUZkOXRMa0cxR3J1RkVLM2pnUUZM?=
 =?utf-8?B?UE52VmJZbUdxaHc2NTZkV1JxYi83NjZMWVplbGowcTVkbDRWRHVDZVpSWjBU?=
 =?utf-8?B?V3BUQllTNEgxMFZ0dmJ1V1F4bUxtbnk0ZWdXYUhmZ0FTRGUwSU40b1FUNHFF?=
 =?utf-8?B?K1pTQVAreFFIK0k1T29oVnRmU0s5NUcyTXBBN3lwUzlVTHFnaWtNeWVkRW5h?=
 =?utf-8?B?akNuWUdzNlVmVXpPQ0dpYnZjeTRJTUg2NEZ5cUlENlBNSGxLWnhndm1Sd1My?=
 =?utf-8?B?ZlNOWVBCY29ieCtqMGc0MVI5S3VFU2lHR01FRlpLdFRTYW1JY3ZreXVuUE43?=
 =?utf-8?B?R0MvYitvOGNSbExxZGlnQ3I4cU1mRGZOc0RueVRaODVqVjJMTWNaRVpIZVFm?=
 =?utf-8?B?U3Q1d0d2aVZpZkN2WHBuMzVWOGNjQ0Y0UTRIVFBwV3FxWUEvanRDSlgvVTNi?=
 =?utf-8?B?YW43dEtXLzVWT08zc0NrWFFJdG1waEgrM21BNW1lN0ZMUWZ2VkRrMUVodzJN?=
 =?utf-8?B?YnlYMDJzSWwxZG5SZGFpNHZOMW9wV0owZUZRTVRaK3ZIeE91ZmdlQ0JNVXVL?=
 =?utf-8?B?SWRyNVNEMGdrS0w0bWpJWUw0QnA1RlEybUZ2dGNyUUdIN1BUT0llUzVHTVpl?=
 =?utf-8?B?RzFuWWc5SjFEN2ZmYlZjYk9BbWZOYWFmOVZkYkFtVVkvZGYvdGhxbFZ2djJm?=
 =?utf-8?B?TVVxbUJjY1ZwYUY4VnhWRWJIa2lERUducUE4MDduWjVnSitGb0xFL0IyRHZP?=
 =?utf-8?B?aytyVzQxQ3U5cTNwUXFuOWorQmV3VHBmcXJCalhWUDJPL2JXd1lvT2hzUzdO?=
 =?utf-8?B?U0hsZXRWZkpJQjd1U2wycC9Xd2s2dG04WCtwTGl1emdGZ0I1VXY2QzRUeEZy?=
 =?utf-8?B?bXREc0EvWmthc244NS9jWEQ0R1VCK3gydDFGd1JnZE5SSFNRb3R5SEsybEQv?=
 =?utf-8?B?UWxnZEkyczVxSmdlTFZuVGxhK2dJaVhWcnU0MDVRLzFBLzFFR0ZIdUpZK0dh?=
 =?utf-8?B?VU45NjkwTE9NUTlUSFJTNHNKZHJzZXdNWm02b2pTRGVmcjVUUHRxUWsxU1hF?=
 =?utf-8?B?Umo0aGRsUU9EZEFnMTN5K1hUVFhXSTU1RkFxZDNXcVQ4dUFWUExBbTNrblF6?=
 =?utf-8?B?aTMzYk41NTFzNEpOb1ByUGQ4eVBldDg1ZlJNYWFWVHdFbHZqQlF0WllQdTdS?=
 =?utf-8?B?blA0RmtRSUJrYnJ3OXVRYTBmVkxiemhNcTN3QjBVMHZpVFFNd3ZpcDJqUDBh?=
 =?utf-8?B?SUR3cFpJYjVRdnRGN0FoQXhjYjNlbGRJZE9xRWFoOWJKUFY3enRBZEFMaHJz?=
 =?utf-8?Q?TZYQqg8TPUZaC9I8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a438ee98-94e2-4bc8-d9b0-08de9c5f9318
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 08:59:04.3017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cALJeK+qP/NlyiFxHiojJ0lXZ0GCNGDXekyIX0BUQH42dlGB00vSdvwFllcp8LmFLRBU37XcCjNK9m2yF+el4sKG9FdLnvXoGNJFAChOoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8094
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 7/4/2026 11:36 pm, Brian Sune wrote:
> latest u-boot fixed the old naming from TARGET to ARCH
> however, cmd Kconfig is not aligned to latest naming.
>
> Signed-off-by: Brian Sune<briansune@gmail.com>
> ---
>   cmd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index f47ce7f45ce..aead5c80cc6 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1893,7 +1893,7 @@ menu "Shell scripting commands"
>   
>   config CMD_C5_PL330_DMA
>   	bool "Release Reset DMA Channels for PL330 Handshake"
> -	depends on TARGET_SOCFPGA_CYCLONE5
> +	depends on ARCH_SOCFPGA_CYCLONE5
>   	help
>   	  Provides access to Reset Manager Per2ModRst. Enables DMA
>   	  channels for ARM PrimeCell PL330 via reset release.

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, 
Tien Fong
