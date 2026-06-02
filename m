Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65151CD6E57
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 14:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF23784867;
	Tue,  2 Jun 2026 16:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4NeQK6je";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C927C84868; Tue,  2 Jun 2026 16:34:55 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E6E7801A9
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 16:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWMfA7ESaNyvNlb9QIGs/JObmOvj6qJBRuyNq07vZmg00zkQEQetp3yOpETa9QVxQ52MMySYgO9CEhDisYdgHrvNITiXpRwJk5QljW9GoCjBGRpJ4oX/A4czipBPkFhiQm5JZwt8kuTkd9l/u5LALM7As1dqLGqLbJpCsiFrotzN+T1LBa+hZxTyaGTQmQYA2+k1NxDGmQ1n98yOOGOTS80U/5PAZR/S6KKhpci849nHPpXcPAy/Fz0C2Hj5Rxd43ABtJNjmrgrMJ8Iv3T9hpfk/3k7yR/vCazPcEw//3KzF6V9zypxCEkYGEX7V4GulJjcUWk4oikBcddTIchNG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5wZI0/fdZQLoGOotJ5qs0UvfAP/p+X97NKU4FENXgI=;
 b=vrYFqxtde5CHKIXc4W4SstMb3JEi94ub/eEIju1tsgMTkhnp0fMCMGlPo4kPy+Uwr47q2Kxxn6iUfBSImBYzS60+qhGzEs+cLl56HVA0aCpk5xelHYfwcN0mb3eljM42Doil+I1HEVYk3PTbMPyWh7/Z6zTh/owrYavslqnJd8s2i1Ss2Wb2caVbbuKVuwBa/PxOcc3Zr2vS/vcy326e6QPQRhcyVQKb3pqSanykYS95floq03RjOvsnKSFTyfE5ARTvsIU6dyxOLgwBnEAi4xhxHp9QdGRzfAdEXw8ndHDSrS3KPRWEmSaY+YXIO6WaJGiJyOqaV7HEQRLP5GyZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5wZI0/fdZQLoGOotJ5qs0UvfAP/p+X97NKU4FENXgI=;
 b=4NeQK6jeyu+d1/Bs/SyzHtw1Qf8laQms5oriGiXpLSIv5fW5LGL/jPDKggveFQkTzdhX+qL3VNULLQdCVd6fvoljfD+zuK3H56P10PqNsoEXzZkeNV9zb81kSDH87KOcNcxK5/LjPgcQ/F071yQPG4B/9Sr0Mi4TIv/+XQklghk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 14:34:50 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 14:34:50 +0000
Message-ID: <2e93efab-6ab5-4fe5-a347-a72b7a08331d@amd.com>
Date: Tue, 2 Jun 2026 16:34:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: versal: Fix snprintf invalid size argument
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB28050E57D668A48645AE60CFDA152@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <BESP194MB28050E57D668A48645AE60CFDA152@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e6a542-95bc-406a-cb4d-08dec0b41a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ecF4ECZb2oZXEKnYxZwfPS+jbm38M7jiTFtjGstCSByAXLmTfN7s9P7/bWxEzB7b5P+jNhAeZxTQULkJ2UQ354leZoiucGIoNHVA3EusO8x7H/fIB7Xj/lWsWjKLNTjFSapLKUDvCeuDPucWiAz5XUTfw9/8xC5UT+B9S6RFbJ3jWZc86JPWi36ShFTvtNFZ/5B/+CdU/uwoCxxlexp2Q6BBX+GjFSBbR1njd2GjRWDiighMWmvQbl6nrX2sTnTw46ky0Z8blL8n8edtQYYcbn1vZKzLHJ9ujPw2N0mVBRckpGIwhkYvn2yoZAbbIPh7LJFiJ3yGv5VFyr6xnHLrWvVcMcczZPzH5McU22Bcsy7gX4qUBkwdn8J0FN9OApfm8ovV1SsjwpNT1eIXNXd/GAA5mlxq+/DIBgIYmTURYD8vDAdUY+zPR1Fll40GBkCDEQKMWiTvd46xz5/ThGh5RfOZewd2lz8loSQVAQUppuDASaWUvsTssXLqMWSkkgupYuK1DtGx6gTD5X1DgvwB7qvV5+9T1qwb0BKyIa0YT7i1yBLXerr+lsK945A7JHiHtTav5m9lVuY4TCDVfM4cnwKZ02/IjOOvstieV/eUyZdvWRKcWOa0lMx6Uhf5S23mloI8M1tfNeYDtxzBSpYPVL9PmyuuHtta2KtSsjhA7L+wn3c3eVFCjHfFmLmSzEPV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME9EZlU3dTdLQkF0ZUFPNlZlRmE4dy9RMTl5ZmhmNFVYRmtNM2VILy85Tngw?=
 =?utf-8?B?Y3pkWENwMHZFSDVtaGkvTUdBclR0TENNOVo2LzJRcktxamIyZFdhMmtEaUIv?=
 =?utf-8?B?dWIzcDlWNEQ2bkIzR3JTd0xZM3R5OVdNWFM2elFhSFNKREZsUkJxYk0wVVhO?=
 =?utf-8?B?Snk0R2JiNi92aDdiS3hFNnlLMmY2UktuMHlLVEFpZHlLNnduamVjamp4VEJn?=
 =?utf-8?B?b1JPa3FLQ2NjV2V0QXlsWnphS2VDRTRnRk1VZkp2K3pDZU5zKzluZnNLSHBW?=
 =?utf-8?B?VnpOQkh5Y1h1VzQ1NzNNeXdLN3p6TllTcFN1UmIrUmVTWXdJQkpmUHV3U2lw?=
 =?utf-8?B?dm1kbS9kS1RxZFFSeWVtbzlHZ2xhTElGNWtlSkVCZzlnUytQdkkveFZCQlQy?=
 =?utf-8?B?RDJyb0dpYmx2WFJZWXNzWnlvOEFvRmh1azI5L05MdVBIU3RYdE1qQU5MZEkz?=
 =?utf-8?B?U0ZiUnQrRGZGRXdqSGZqdzJPM09ONmkwemJNYTNUbGVaVmtsQWJDVWRYdzIv?=
 =?utf-8?B?eDVrQzl5eEFHWE5US2VKRml3UDhldFpVNmVSVld4VEltUEtXQnlYYWUyYTIv?=
 =?utf-8?B?MEJXK0hKMlBXUEU4SmdkUUJWQkFHdk1CdUk3TkdOY0xONWZ1eHh3eDdFSmsv?=
 =?utf-8?B?V3BPbXdnMW83ODYyRElzRjUya0tobExOdCtNbWRWZlhPWk50L3ZpS1BnOXdP?=
 =?utf-8?B?eTNZRDlhQlJ1ZXd1OWEyNzIxdjlvS01HNzlORUFTZmtzT1B3bzVNMVhBQmtu?=
 =?utf-8?B?TGZldXF3Y3h0czBXdkRTWHp5MXRUaFJyeTE2Z21ZcExkNzVSazJ3WXpyMURV?=
 =?utf-8?B?SXQxRWZGWXR0WFVGYytXampMTHRWNTNSK1BhdGdpN3MvcldLR2NaR3AzWkJC?=
 =?utf-8?B?MkIvSmpjcWdDc2NLZm4wN1VjSTdNeUdpekM0T3lzeHVueTkydXV5dkc0bzFV?=
 =?utf-8?B?SDZsbnlQSGhBdXdQWFF2TzlGcVZoN01LQkJaMXVnNy9QR1d4RzlqMENhK3RD?=
 =?utf-8?B?cHpJRWlNN2JPc25QUVFieUlSMGpzb0ZXYlpWc29pNFlwbkQzYmZDR0J5U29K?=
 =?utf-8?B?bFJQRS9kVktRU3FEcVBLejY5a2Y1eXBoZThnL1RYaXZWcThQbzZYeVdoSGtR?=
 =?utf-8?B?Tmg3T0dqellvbVNBSHQ0T2RGeU5hSXR5Vy90cVdGUWNWV3VJbFBGcHNiUVhy?=
 =?utf-8?B?dkczM3JFMTVybEhTRXJma1JySmFWbXNwQm1zWHpud2VSdE9FNDdaRzNtbVlW?=
 =?utf-8?B?c1ZlazdMWkhsajZwTTZJb0J2VWJJL2VaL211blJ3VFdWNUUwQnpxWldXZDVV?=
 =?utf-8?B?Z1d6RGdiZ2dhRW1LNmp5dUNaWEpyelEyNUd1aDBsVjJReHVyTEJJOUowaDFO?=
 =?utf-8?B?czhGZ3M0aXcvVU4rd3Y1a2w0am11YlBiYVhDcVJhNGlGT01tdzR0SGFzY1pN?=
 =?utf-8?B?Mng3cjBzSGhzQTc3RVE2NzdlZ2RMVDlUK0x3cnZFVStiOVlGMG1PeEZnQ09L?=
 =?utf-8?B?Q0NSaHljQmtUUWtCRHEvaDY1TFZpUUdHSitCRW9yNnFGdml2T1pJaEtvcUxh?=
 =?utf-8?B?K1BFT2xOOHIvaXpwTzBTU0dXZmc1cGdGYkRnKzMvVzBCRDMzTXljWlp0RGE2?=
 =?utf-8?B?cUxiQ3d2Ync2aVRSaFU2OE1ENm9aeURtVUJuNFF2aGFqTjhTd2JCeEkyNFlW?=
 =?utf-8?B?WWFxc3p5aWJmWWVkY1RWR1JrU1AxVGJoNmJCMjNZd2QyYzRWZ0E2VlAvRkJy?=
 =?utf-8?B?azZDanVUeDA2U2tPaUVWSVJRMlZKT1ZxK3lHVHg1a1RXS2Y0T0x5K243ODZu?=
 =?utf-8?B?Rk1pNG5nU2lkY2twWU8zK3hFdFRMdUVmK2NiTnNTclZMZDh1bC9SWE5VQWRu?=
 =?utf-8?B?Y3VzWXFqV2RjTmdzMGdIbUR2YTZEZko5cW91WENnUUhkUHN1UEhpQmxpQ0Nl?=
 =?utf-8?B?TlB5Y2o1VWVxcFcwZjNYYW1QLzk5UE5JRHFQaDFGZ3dJMzRGdUxtN3d3QS9S?=
 =?utf-8?B?Qnlhc01RK25PMWJXdGJmL0oxL1ltMVlCU3RSOHpZdmxBeFBiSjBoN3dkTWlw?=
 =?utf-8?B?M2YyQmllcWhjUGFHM2xQZE9tNkFqWEtpeUhPdVlzV3EwUmQ1N2NuNFZxa21z?=
 =?utf-8?B?WmRmSytpZ3JTUzVOc2ZjYW9xaXBiejh2MnlBZWcveWJhWGV5VTNlR2JNSlQx?=
 =?utf-8?B?WU03M0JjVVhqQmhOaklsUmpYb3dWL3ZWVUwrVktPcHdkclhyZGdZVi9sVXFw?=
 =?utf-8?B?cHB1M1YvZElMZDcweGNzdVQ5OFQ4U3NlckpDekdDMGthc0QvdHdycnY3eFhT?=
 =?utf-8?Q?iyvdnSaseS/UYCyJLj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e6a542-95bc-406a-cb4d-08dec0b41a5d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 14:34:50.3560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88yxep0nJsFdYnYlCZK0cR04yx1dVktzBN1xu1U9S0GMFLZRLCwph/MTOKeFA3C0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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



On 6/1/26 15:02, Francois Berder wrote:
> buf is an array of size DFU_ALT_BUF_LEN bytes.
> It is gradually filled with data using snprintf but the
> size argument to snprintf is kept at DFU_ALT_BUF_LEN,
> making it possible to overflow the buffer.
> Fix this bug using the correct buffer size:
> DFU_ALT_BUF_LEN - len.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   board/xilinx/versal/board.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 9371c30ea27..978909840b9 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -418,14 +418,14 @@ void configure_capsule_updates(void)
>   	case SD_MODE1:
>   		bootseq = mmc_get_env_dev();
>   
> -		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
> +		len += snprintf(buf + len, DFU_ALT_BUF_LEN - len, "mmc %d=boot",
>   			       bootseq);
>   
>   		if (multiboot)
> -			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> +			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
>   					"%04d", multiboot);
>   
> -		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
> +		len += snprintf(buf + len, DFU_ALT_BUF_LEN - len, ".bin fat %d 1",
>   			       bootseq);
>   		break;
>   	case QSPI_MODE_24BIT:
> @@ -438,7 +438,7 @@ void configure_capsule_updates(void)
>   
>   			mtd_found_part(&base, &limit);
>   
> -			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> +			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
>   					"sf 0:0=boot.bin raw 0x%x 0x%x",
>   					base, limit);
>   		}


Please look at my reply in your second patch and please use scnprintf instead.

Thanks,
Michal
