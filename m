Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72698C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 348C78460E;
	Fri, 26 Jun 2026 17:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XzmMbsjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BDC8495B; Fri, 26 Jun 2026 17:01:27 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2158404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLPKcrSu7s+k2MpX4ZqussNDiLLLkCF02HVlGVVEe79lxZrXNNgO/3pCUAfkxcbI1Dxe6+yoi2h76NRpNu/iV9BmMOAr58IfxoflXny23G6EsVeCIUL9fPIKasQ4lsHfrjquz2P7LKODFLLhhkzL72ybMkrGthyNZOed2iclFwjCe7oQaZejjsJwOiEzqdt+hYoPrmcvAmfFdFmS7zZPAupnT3COzytDpsAPMwubn1WIVGe4+VjHLW+TiT1sDxEEj4GLvyGil3ulLHLvmmEvvyWh2wPtq3X5SL3A6MDerF2AKMUBFR89WfTa0B7obvZym4ePjtWrwrAFcO3u9whjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBWvQKCeKGBco2oOg5R9qkxIV5k9q6zPijxM0ZgBi5s=;
 b=s+0Z2fM9NvhxRSyI7FuQeqPodrK8+48I/ph0QnreNhlZErxbesLPvjnrEJ7fq9bPGIJlZX6Ho567xgSFdUO6/1SFreQcGp1Ose07TmQf7R4YcF6Q1TzIZpSLs5k57yEuw22LM/ie3TaUj5mSLsLKqs4DBCBMncyf5nE+FDm173G6RrNWxzL4bMYCRpLrx4CWq1mCVxIWLRNCNIlKWYkS8nSQTWg9xQ2QGORW2vvBgqUlBLsG0oZvDJqMJsyR77sHO81aXiszZ4M5v9UHy8QOjFs886pz0MplVckUerJUFQgLXbHE/rwqpkzBEwLOeh+SKsYOZT+h3ME4uGBtAYtNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBWvQKCeKGBco2oOg5R9qkxIV5k9q6zPijxM0ZgBi5s=;
 b=XzmMbsjA9U/fMEylHG70VyKmaj1YcJA1zby0z9U4lW1rJ0ctZ+B1amWV+RatjVodPEFZeofpb/1cgrPRU8pb8XqVY1iSE8D/pmUkr6kMDpBB/soh/cgfqmux9AFmataniV0A975FiQ3P26TM1mzeE4xc9kpQVP7MhioKWtBRZK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV2PR04MB11740.eurprd04.prod.outlook.com (2603:10a6:150:2cd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 15:01:21 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:01:20 +0000
Message-ID: <4946b40f-21b1-4a48-a01e-6f81548aafda@cherry.de>
Date: Fri, 26 Jun 2026 17:01:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] reset: Print reset type on diagnostic console
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-4-dmukhin@ford.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260603070743.1268544-4-dmukhin@ford.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV2PR04MB11740:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d3e0d7-e6f2-46f6-7082-08ded393c855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: cEWlsnyGEz+Gg8Gv0kndVqZE0ZPXv1Yh2PK3w1JSviTffbAgteyPc8sT7qvAhc4mpIqPZe4iyUDT8YALEadzErVIFJi+YBLGBOl9XBY3n6mbfXaaKekC/STSaaRpYAyhO/OAHzo5HE15T29rPsPHuRUnwgUQuZz6tF1Y/j7RjutFAV+l6+tLRFXa7VzuLnXkB1q+KTPesAuEhQ+k4CS+Spf1FitOOuVK0BTCxQX9ePYdPYSJWGo9EVAPtCcmfGhY7waNLEzStA6hEbtRFt4httxxzSViM/zVUODWTfYwdUBGVjuyxq8MDeLkkTZDoju8s7lEsfw9a9fNOcLwt8FGGgT5Lm2N4Kwz/d++ksJl2cMlAxWYqOAStXDUP3TLXegKdxyZsVp8Ud86LLh3aVigTkGy+Tq8Yi5+bAkLvoNksIOKDbAmEl+UKPVTInZlfzSob6LMhqioX+xU3GKrxis9NViMyRgfO0gIESres9GNvDxUFSrxTNYtDA46SIRZLwVtp2Rj3RMX6qjW5kvpPzFnRw+MRxNxQzxfCV7kJS4ftiY3ZF0sHSyML9r+6Af0ctgcX/NPtP1uvPcZOL1S5xIUps90xXPcKL49ROwba7sco9WASySo661LIhRYdBqLruyAiES9L0o4uullyySFd0YTVowULi/bd/RVI91ISXD8JYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlNhYThwelFpd1BUWVJFNW1wd3JvL3BIOTFyNW5FTkwxWG95dkx6UmY4ZFEw?=
 =?utf-8?B?NEltV0tvZy9LSDU0VS9IdzJhYU1XREJNeEg3eC9mZU0vUWhYNjRrUjFKSnhY?=
 =?utf-8?B?TkllN2R0alUrTVphZDdlWkpkWi9uYk1NUlpOTkFHWkdFMDQvRlZTZ1NvL0VI?=
 =?utf-8?B?VXZxWWtTTE9sc0RjSGd3WlMvUTBLQmhhVmhWYUx3TWcraWk0a2h4enV1Ky9Z?=
 =?utf-8?B?RDNLN0x0ODR2aDhybmVpMmxoekE0MkVWNGhzK1dqTzZSdnA0c21EaEk4N01O?=
 =?utf-8?B?R3NSeDJSWmg0YTZXb2tsbGVTdjIzQkhDM01RdHhQNFBScEgvUzJZdUVGVkVs?=
 =?utf-8?B?bDlnR2l4U01TNVhSbGtsTmswVUxuM1h1c01mNEQzZHhWMk5wSHdkTmxrenh3?=
 =?utf-8?B?ZFRzdkk5Y1BFdmxlYXNQaG1iQ0hPTnJwSjlyRCthdHl0U283am4ydXg2dmkz?=
 =?utf-8?B?ditQV0lCTHBpaFZYRkwydjQxQkluOFUxUXJLaEhZVnVxWHB3dWd2aC9pRisv?=
 =?utf-8?B?YmtaWWdLdTBGSURDcVFLQ05kSGhEMEVBd0o2ZXlLRjJKNUxMUUQ1TnEzNjVY?=
 =?utf-8?B?L1JnWTRhMHF1ZXJlYVZpQzUwS2s0WVU3SkxsK0pVc2lva0JMTDlhUjNrYTdX?=
 =?utf-8?B?dmZLbGcvaVYwWndMVGd3TE40Z2M5bFVEaldpODNEUWMrbkhxMCs0OG5Pb0Zw?=
 =?utf-8?B?eDIreVdpR2ovZzBtdFZVMkFGL0d1ME53bWVBRHF2aEQ4aEpaSlYrVm1FMm1n?=
 =?utf-8?B?ekFqUDdadXZHWlB0eXFZeEs2bFA0QmZKYUpnbElaMEh4RmgwemEzSjl6TTV5?=
 =?utf-8?B?SFk0bEZmUmlsQ2dSM3JNMkc0Y0hBcmVWbWx6Y0dYZE04aUJKODZDNStIK1Qr?=
 =?utf-8?B?MUZPNkhRWjNaRzhneURlMmlxV3BNcktNcVhyQjVOTm5nWFNBMko0MnpwRWZT?=
 =?utf-8?B?SmFXTmpQcFpweFYzaVlKVnZCMDdmYjdySTN2OFpyeUJqYWZ0ZEE5bFI1QTlG?=
 =?utf-8?B?aGhKYlBPTzZ6Q2s3bU93NHVZeUY4MGpqNVFTVVRMSzVmZ0VnaGtyWWYwNkZl?=
 =?utf-8?B?VjQrUU85MFJtazFLN0tJODYyVmUzL2dyY1hhOTdPY3crNEJqZkNpNGZpR3JI?=
 =?utf-8?B?bzZia1RTWmNjMnFac3c4aStDUVRqSmMrNjQvc0k0R285MVhqMHptMWhrNldZ?=
 =?utf-8?B?ZFZ3QUtwejg5MTM0N09abzJZTldycTNxSVp6MVowVGxSV2Z6SGNiR0c0dWJ0?=
 =?utf-8?B?TUhOdVczYWE1dStKWFhzMzIwVEZqSFFtWWhqYTc1M3VVWFNMa04xRHJWbWh3?=
 =?utf-8?B?amNFRk9sUU1sZE5ZTVpPdERoUUREUG1MWTdLSTJEMjAzaVFnRXY3eEhXTkFH?=
 =?utf-8?B?STlqUTZ4MTlhS2lKbmtOMThQL3JVdnVudm5KczVvU3psZGdnU2tKSnhDVlMy?=
 =?utf-8?B?TUdBWGtLTkdPWVlwSVUrMEVReFQ3d3N2L3ZiYk54azhiTTk5QjZvQUJEa3J0?=
 =?utf-8?B?VG0vdTZhZi9RbDdmeTlZdHBoNlhwQ3BqS3doa3dCMWhJS0pZQmw1K3lhU29n?=
 =?utf-8?B?NmhhYWMrcFVmRGxZNkRPYXMxUlNNdGRtQmUvRFdDMGVqaGlxN2RjM045a25z?=
 =?utf-8?B?UmtPSVUzTG5vVDJ2Qk41Rmt1cDY2eUFKQnpNY0pSUGllRHpvZGlZUktHMTcz?=
 =?utf-8?B?NmN5UlZ2VjlnOFQ4dUdoaVNLTkcwazdUMXNtRkRpd2NRZ24vampMdUdpL1ZC?=
 =?utf-8?B?bVUySUNaZENLemVHNGc1RkQvSVdJVFViaDdlRjhZZ3RqeUJ4REd2dVBQdGRr?=
 =?utf-8?B?UkRLbXdLVG0xcVBPR2IzT3E3bDRhSkpaZVB2cU0wV2Yya1I3QTN0b0krRjR2?=
 =?utf-8?B?TTMwTGhCM2ZxTk9tMmR2cENvU0NzN1R6d3laNUZYenFuWkhkdGY4RW9Ibis2?=
 =?utf-8?B?VDBSQ1d3RVMrL0JEQmw0c1QvcTNzQi9nUzJvNDFMbXhQUGpYZW16ckFrNTZ2?=
 =?utf-8?B?am9xQ1NCbkIyUjNSYjVjdEtIMFp1ajlKVjc5Mld0S093ZlVOanBXMlpWblZp?=
 =?utf-8?B?VjJFOGVEZ0U4MUdyQVhxT1FVWDB1U1BwUXhhNjFYcEhvOGdxM0JKd0RFWTlj?=
 =?utf-8?B?OExmM3BxS2pMREdreTBUemtETEZDSHJQOHQ3ZXBQbXI4UUVpK1R5RHYzdFRv?=
 =?utf-8?B?b0Q5WGxxQ2ZxVEJnbm1lazdEOGd5TldkQWNtWk00S1BMcXFkNFRRRmlVcDUw?=
 =?utf-8?B?RXM5N1daeE5iTSt4aFFIY0Q2a3I2ckRuQ3dCajQ0RlJJTmdvWnMxbDN3ZTla?=
 =?utf-8?B?dGM3aDdyVFgxekhZNnJ3R2pZZFNvdUVKU09WbHZ3VWZXa1N0ZlZnUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d3e0d7-e6f2-46f6-7082-08ded393c855
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:01:20.9168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBoxROKD+IQ/33r/ImdLGsaSM9Jxy94789KV0EyRgC0qFuvfoCA60K05irMn+2/+vpfPd3wKC7Tu4f77M7vpj5lJp5HW8bODXt0UM0LmfPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11740
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

Hi Denis,

On 6/3/26 9:07 AM, dmukhin@ford.com wrote:
> Add a diagnostic console trace indicating the reset type.
> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
> Changes since v3:
> - moved get_reset_type_str() next to do_reset()
> ---
>   drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> index 1ba698b37285..2b7717857ce6 100644
> --- a/drivers/sysreset/sysreset-uclass.c
> +++ b/drivers/sysreset/sysreset-uclass.c
> @@ -161,6 +161,22 @@ static enum sysreset_t sysreset_get_default_type(void)
>   	return SYSRESET_COLD;
>   }
>   
> +static const char *get_reset_type_str(enum sysreset_t reset_type)
> +{
> +	switch (reset_type) {
> +	case SYSRESET_WARM:
> +		return "warm";
> +	case SYSRESET_COLD:
> +		return "cold";
> +	case SYSRESET_POWER:
> +		return "power";
> +	case SYSRESET_POWER_OFF:
> +		return "power off";
> +	default:
> +		return "unknown";
> +	}
> +}
> +
>   int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   {
>   	enum sysreset_t reset_type = sysreset_get_default_type();
> @@ -181,7 +197,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   		}
>   	}
>   
> -	printf("resetting ...\n");
> +	printf("resetting (%s)...\n", get_reset_type_str(reset_type));

NACK, this is potentially misleading as sysreset drivers can end up 
performing something different (see sysreset_walk_arg() just below).

Cheers,
Quentin
