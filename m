Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D814BC43602
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 10:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16D3F846A4;
	Fri,  3 Jul 2026 12:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SfIuXH3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F34758484C; Fri,  3 Jul 2026 12:11:37 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC344841F2
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 12:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4IAml1dOysFZquyjeubJObnGmTpmow1h9U471Hhq6xwvAM2B/M+X1WA44EfHpmDL7RJA86WGeuqJuhPPHKdTpAX9nhg2TgOLB6pqdl0MkRz1uVDMAnnYPCmV/S9MP590JyBug4a4xKebtpDT4w+qksiCfeysuUpTNbc4OJfWshssXr9pig4ouVdRw2z/bIRW2bMPvafbxdy2JnF2TxjlqK3JlK95X2uQFdMh3boBTjVQbJ+bmNz9Y57UJvLL6x/VRXzHdX5nIK1J5/bFbXJuRIINJlrYJHL2tcLEKocvHeLsiCNGZDwKnULj+/xlCqVS95TGZMAfrG5dx5lkN+OKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfNkNxn+MY/EK147xlnNMQlgQdct9o2DlnrdBwz23rk=;
 b=J3fUxYvaXMqvkIMI61eZ09iHCC7CB6n9RuQug4003fpuek9/RZMeZWzQndHlGD6LfP9pBJiuKSuPzjDnJX96r2f3S2YU8UZMIoZoEBoS8ichOo52gZ1P/OO+spWjqc7h91BcXFzgmhJ3AOodaLbN69pY9qYzlcE6isvmlI2m8sZsvvXRhh4IY78HhSBVEc8C5Mc5Tv6f7MOdCz1T4z8h+SJjFc41UmSlHdUPw3uWoulfffK6/sKgRDNDgvfvDhSHwfGOyc0a0OI1dg+Ar+EK5tCYsP8/oPyfmiPkOAbAl66B+TnGjJZIwKdRR8BJb4/4x2inS7Ty0h/uWS3YSzIjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfNkNxn+MY/EK147xlnNMQlgQdct9o2DlnrdBwz23rk=;
 b=SfIuXH3NkOaF9B22FFkS6tPplMn7H3wcO838cOxC89KxEI5011i9zi3EuzpBjjfeTLTnxet62DxWposZVRKtEELt0MdkRLFmv+PCfHO+2+Wm3npEelU0hIvawnYvh7WlDe00gz35tshCNPBbdXjv3+N5V1IA//l/oalwpBpTRN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:11:32 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 10:11:31 +0000
Message-ID: <af5d617d-4963-44cb-81b2-c0b0b0dc4c6f@cherry.de>
Date: Fri, 3 Jul 2026 12:11:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: sysreset: Do not end sysreset_walk_arg on
 -EPROTONOSUPPORT
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly
 <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260703-walk-arg-fix-v1-1-64beca00d7e2@oss.qualcomm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260703-walk-arg-fix-v1-1-64beca00d7e2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0263.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::36) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU2PR04MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 7877ea34-f841-4642-3c54-08ded8eb7452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ch0DlCyABRnxyM2snF/NMobka1nXQAUIGKbwl+IAGg2YVu9N6ZCXk/46nKibAZJaWri61nKYnaJ8zSWB2tiy5u77TonEkd8xiGrC4QPDrpGp6i8RvUPqy1nFw81qVRcLTUdVyeHUa+VZ06kobE3gKm6zdGGa7VYrQcgLSQ9/dlTj+mxbXqRxrcNQIBcow5iFdUNYbWTFpPYJZ+FEord8H+wsSThzJd8g4clESbhattbFQwXUNWIinmSJGMDNv9OrJ+WzVUT87YxqwEV2lTNkZ1nHpmHW09E6YC+8nqhhYDf/mcbkvfEleJAGPEklxozMUKVeqMkzcjGpCfPNir1d7ctH/X17NklF6yE3g3dc//uv9qKDpIFPVa0kKAWWfsgNyFvHIZz5irNDPYo+jl52PDnXjmegOWlcFRowYpcPmTfcdo5t2t28JOvP2fORbQUCqos4/hycd/gJIqS2yGnl4nprWU5q6tvErUPSPun1wYDC2wvOVatSBP8sC1jsnt1w4ICewB2HjYMRQbxfgmbbJ7K8EOL3ciBtaMmte4lcre1uurP64lA5bC/I5A3QNOlWaERYQBScXNzPO6OqXMZJOlZxp6oDxZVGAcqMOTF+ExXSR/pF/9EPHKAJlLpxCET4/cZ1zHd+cHrNCN9Nfg93w7xPnlXvlRru73hbHITQwqI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWRWT3ZXL0xRYk40b3JtM09leTVPd0RZZFhqS09jblRQWnZZdmMyZ3JBSWNw?=
 =?utf-8?B?VHFNK2RDNFFBYk1La1d3V2doWUdzZlZ4OXhYaHQrNWtoaWZEVmlncTdyeVBq?=
 =?utf-8?B?SmYrMEhEeTBSSlNKaE5yMGtRL2Q1QjVoOGpEVDZOVk1VQ3ZjVmNocHV4VS9F?=
 =?utf-8?B?MjRROTE5ZEFrMHlwZlMvRmtvOGttVVo0emNvSWtQZTk2R0RXWVdhanJZb1d5?=
 =?utf-8?B?ODdJM3c3NHdoU2VueXQ2a0Nub3haT1NKb0JYVjBRYktzOXhyVWZUWGhYRVlw?=
 =?utf-8?B?TnIvWmU5MDdKK01vNURPTVo4aEFTTDdBbVlNQU5OMm1sWkxOMmFaVFhleTdj?=
 =?utf-8?B?bmtKMDIxa2VUeDdoM0VVQVh6SHJINDdwb3ZqWEVPck9yVXpGWjJCb1p1K0RE?=
 =?utf-8?B?SGpTQmFleFdnaEhSK0lMbElRRDFGL2tSQjlZdFdvOFJoNzFVUnFvNnEwai9y?=
 =?utf-8?B?ZHZMejBWVXRsREkxR1czYStrUE9ydmZHTHY5K1F6dkprZUNzZEovTGNPS0dQ?=
 =?utf-8?B?MnBCZ05pVDZ5MndUVDJsRlBIK3NNYUs0RW5WZ1BGbjVrTmFkSXJ1NDA3UC9J?=
 =?utf-8?B?aEx3WXc1RFZ4VlhucG1NeFBjY1JCVEtyd3pGcTFwYXVKUkxWOUtZN3hxcCtQ?=
 =?utf-8?B?Z1RjdXR4WHlTWnFvNmMwb29GL2tlTVVwelptbU5YOU9hSkRRRFRVNjF4c3By?=
 =?utf-8?B?dFBFN3dHeXZObDJqK041ZVl6NzRGMVFoKzVGOU1rb0NVdlZrRURSVkYyb2Vu?=
 =?utf-8?B?UTBYbDVhUENMOGczbWMyUjAzSllQcFFTV1QzOW12RlRrRnNqcEJlQWhCUkxF?=
 =?utf-8?B?RmxSUCtnOElhV2FsUVJubjV1TFlwbTlGVGMySFgwRDNKNUVhaVoxNEVDcDU4?=
 =?utf-8?B?ejVBRlRWN0NXZEY1VXpWMnBnUW9SZ1ExSmwxSmk2bW8yazR4U2Z6d3AwUWNy?=
 =?utf-8?B?RFdLZWlCY1Y1MWZQOXNKd01iWjlocjJYSXM1NDFzb3NXa1ZhcFhEWjI5b1pJ?=
 =?utf-8?B?THJ6a25LZVNRbmFhL2xGNU9scSt2SXlvSmxkNlBqVGFuT3RPK3BTcVZoNWhh?=
 =?utf-8?B?MzNXMG5mMzFCWnZtWlFUMnZEcWV6d3lNSkd4SDIvM1ZDRmhjQXBadWpMeG9a?=
 =?utf-8?B?Yms0RmRDcGs5TWlSdUV4bXNBZ2xaVlVBekVqL2VEVlRDUko2dXc3K1N5Y3hP?=
 =?utf-8?B?Z2J6SURWdW5hVjJwMWw5SGpXRExpWmVLNU5qbCtxb253UjhoUExYZjlnK3Vz?=
 =?utf-8?B?ZDdZZWdmV3grUTF6ck1PUFhMcFhIQmlGSy9CZG1aSHlGMTZKL3ZhL0JGdEYz?=
 =?utf-8?B?bmRHUFNkUGFZT2FmamlreDNsMk1aRG41OUpqN1FSUXJRYjgwdEJYb2lkNUZp?=
 =?utf-8?B?YkxqOEgycG9UaDFxL0Y2WXZ1S3BBSFBORm5VSGtnZUdES2FQS1MvZDZMUm4z?=
 =?utf-8?B?Rjg1WmtGd1JEWU9TdGJHT1d4dFZxWHE3SmNHNUQ0MGpKWmVwWHppbHhEQlpz?=
 =?utf-8?B?KzgzMGY1WEd5elQvTXRoZFRSU2k4MjFzZXdSRDUyQ1RlT2xVQUNWYkV0R2h6?=
 =?utf-8?B?V2JwdlBPN1pVeFNpWUVUTFpGSmdZQVFlUG9JdSsrNHA4eUo5VnRjaVQ5ZWo4?=
 =?utf-8?B?cTZKbDFKN05jY3JmRGtUWXJZRDQ2Y0l5akFZWkxYU3FMNi92WVNlMHI2WXVj?=
 =?utf-8?B?YXU4dlR2T3NMdFlVNUl3ZG1lcVpuSW5uc2ZHY1FHamsvb0VOd09uUlAzbk9l?=
 =?utf-8?B?WFRIbFRSTGthbmR4czJObU1RWlBOVlBtL24wRnlYWGVBT01jb3VpdzRTelBZ?=
 =?utf-8?B?ZUs4bUJuUldkLy9PZWhrWGFUL0ZxQ2MrTXgrZFBLQU44ZGloWUVRRVdGYWp5?=
 =?utf-8?B?KzdXaXVIczMvVFBnNU1oTEpYeWJUZXlESWVmOUNnaGhockxYYjBxTWZFUzEr?=
 =?utf-8?B?UTI0U0xOTzZHMHhicGRhUDNBUWdhZTNpcXRNcmdFQjJZeENlQklxZWRMNWZZ?=
 =?utf-8?B?dkpaK1ZpZ3grdUloUGszaExZaWZpYlRML1dhVzJyTEpOaDd4dmZKcStieG1I?=
 =?utf-8?B?cG1ETWR2YXpRL1Zyc1krWEdmMFJpYXJOZ1B0L0h6NnpjaXVtbGoydklQMklQ?=
 =?utf-8?B?ak1zUmt5bWNkeTRpczYzaG5jZDY2QTFEZS91bkt1ekRHUytJWE5jWlp5Tnln?=
 =?utf-8?B?VExtSGJsKzczbm1IVHpjSWZZWTEvWlc5SFJKZ3JsY014dmNBUENSSmJzcXp4?=
 =?utf-8?B?b0dkQWh1MlVhdTlFQ3pjenlhenhRRWdMT2QrVkxJcjEzUDNTZW5iVGF3RVVP?=
 =?utf-8?B?TmVLUVI4ZWdBYU9sMTBteWRMdldwK0ZYNFZaY21BRGhRT01ZQVM1UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7877ea34-f841-4642-3c54-08ded8eb7452
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:11:31.7590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lERbixgt6Bu1oIlbyoSqqsTKuQzdTnajeDZ0A31Vg8NCuggfgR8R583PbxY0eZAECZBucGH/ReihCwE8TZV8xeN5juwk8H/Km7x+r3AtFFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9020
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

Hi Varada,

Thanks for the patch!

On 7/3/26 9:24 AM, Varadarajan Narayanan wrote:
> If there are multiple sysreset devices implementing request_arg callback,
> the first sysreset device will consume the args and may return
> EPROTONOSUPPORT if it doesn't implement the given argument. This will stop
> the loop.
> 
> Since -EPROTONOSUPPORT is used to indicate absence of support for that
> argument, subsequent drivers should be given a chance to see if they handle
> it. Hence do not terminate the loop on -EPROTONOSUPPORT return code.
> 
> Fixes: fcb48b89813b ("drivers: sysreset: Add sysreset op that can take arguments")
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>   drivers/sysreset/sysreset-uclass.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> index f25e09e9cd0..0fc096e7f0f 100644
> --- a/drivers/sysreset/sysreset-uclass.c
> +++ b/drivers/sysreset/sysreset-uclass.c
> @@ -89,14 +89,12 @@ int sysreset_walk_arg(int argc, char * const argv[])
>   	struct udevice *dev;
>   	int ret = -ENOSYS;
>   
> -	while (ret != -EINPROGRESS && ret != -EPROTONOSUPPORT) {
> -		for (uclass_first_device(UCLASS_SYSRESET, &dev);
> -		     dev;
> -		     uclass_next_device(&dev)) {
> -			ret = sysreset_request_arg(dev, argc, argv);
> -			if (ret == -EINPROGRESS || ret == -EPROTONOSUPPORT)
> -				break;
> -		}
> +	for (uclass_first_device(UCLASS_SYSRESET, &dev);
> +	     dev;
> +	     uclass_next_device(&dev)) {
> +		ret = sysreset_request_arg(dev, argc, argv);
> +		if (ret == -EINPROGRESS)
> +			break;
>   	}
>   
>   	return ret;
> @@ -153,6 +151,7 @@ void reset_cpu(void)
>   int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   {
>   	enum sysreset_t reset_type = SYSRESET_COLD;
> +	int ret;
>   
>   	if (argc > 2)
>   		return CMD_RET_USAGE;
> @@ -165,8 +164,12 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	mdelay(100);
>   
>   #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
> -	if (argc > 1 && sysreset_walk_arg(argc, argv) == -EINPROGRESS)
> -		return 0;
> +	if (argc > 1) {
> +		ret = sysreset_walk_arg(argc, argv);
> +		if (ret == -EINPROGRESS)
> +			return 0;
> +		log_err("No handler for reset command arguments (%d)\n", ret);

Just use printf to be consistent with the rest of the function.

But here's possibly another logic bug I think. If we pass -w to reset, 
this will try all available sysreset devices if any can handle the -w 
argument and then print that there's no handler for the reset command 
argument, which is to be expected.

So I'm wondering if we shouldn't bypass sysreset_walk_arg() entirely 
when -w is given as argument to the reset command.

Also, *any* argument starting with -w should do the warm reset, e.g. 
reset -warm should do it too as that's the current logic we have (we 
only check the first two characters of the argument).

Cheers,
Quentin
