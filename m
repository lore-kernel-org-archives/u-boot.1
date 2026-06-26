Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCFEC43327
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAA398460E;
	Fri, 26 Jun 2026 17:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Qnv2N16D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E11684704; Fri, 26 Jun 2026 17:00:20 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB2F8404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhZ8rYytfXGK0fczavFTEASdyrjxW5bzdXFdqlngFXhdkBSgBuPb489T2j+J8WPcdHh36ATGUDWVLxrzgbDgVG0qCyGeTw9/yZcrMSbYT73Jjm8G05djDlGgqwnNdvkP7+RAp/QhZlQ+C2HnT2e412iVZIN0Dgc54aVmYkkQcgay6MxO8VNB/9x2zN9NAUYKQQR9Zfi7X2FkZqET22D0iEodEkPl6pY6hVKRbZQ4qbwIzecTNrf6+DDQrhQSsI7RpoHE2W8ONwnNjLdwB6s7mUFUbxa9bfwLJnKOTkqhGD5FBB0anuFQBrFJU4ZbfjRYP+NZe4lPGUI0dtdaR6S7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy9D1oRu+kg275EghMRa+yC/BoxT6E89MdZsaCWQZFc=;
 b=xSGiIJGQ9vTvgb+kyu06jNBZ5mhHsJLoZd+pffv4XUUwNZworfHdrUYH7fgyEinWFK85DEbduSKVxIcgwS5yzl3zG1L73iRc92nkOyerjniUO9lNyID2UekeLrXX79NMkMSNg1dK/z4+eQmOyw6Bll6TzEEGYlhxuqDFok7UM2lgELbXAk6+GFbHZ9t6vkqhQGEeatWalMbJZsCo62nS6poAf37oVcbcggXWhBFTypIVEssQVo4u3GFeN6sAqO7RNparQA/E7aiLnDmQLCKeYLdElFE+x+C/eer4OrX77U+uhLO5TDGaBqWwGOzTb4tGfh3EFkDmMZA5zBmNahLopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy9D1oRu+kg275EghMRa+yC/BoxT6E89MdZsaCWQZFc=;
 b=Qnv2N16DqBY7DSulvEHQrrAzGyKDHX29ti+jHqwUdFjcBPUryaNECQLh9zgfX2JO9z/l61+2VVBoAdrRaW4bC2XPehxOotWAluIvTwddZgblQKzLiicQRPcZfnKiFHrpbrq0ktWX0RDeKDDDLXEbqQDWFc7Qs5U84JZqbhl4VYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM7PR04MB7160.eurprd04.prod.outlook.com (2603:10a6:20b:119::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 15:00:15 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 15:00:14 +0000
Message-ID: <dc8099b0-bd91-4aec-8683-16e46b7910cb@cherry.de>
Date: Fri, 26 Jun 2026 17:00:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] reset: Add explicit cold reset support
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-3-dmukhin@ford.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260603070743.1268544-3-dmukhin@ford.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM7PR04MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 71babb21-df1c-49e4-652c-08ded393a06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 02Iu9O6gqGUokEO2U7v/UX32x9o23UamjxYyRxaYCILCuiBAvWMfU6UOLURNrB/7jovlkAG5s1YWSGwOnAfHTH+hOXUHHDnm3J9V0tIbD9CTWSlsERsP440KmbWKFfSwM+8Fx8aYhXEDGPajTKZjhd4Vc3WdpG5/quA3BtNMWzJk12MpJq0KCENS+1aF65Ac5YaRvB34qyAPKvZIuRsnQVA2AIUDfq73hWMqOiuG+J12kQcGWFIFEMWEteatmmDA7gWX0sCgImV5v64JOyVuv0ATVuN335ZVQJAmUs86D377BPvQdSOIbqe3r9BnFBLceEmUMEYrzpdYs6wtNbN5XITvD+N/8iO8Pqn74EWpf9ijHb/izTHVUDo3713ckXJ/DWchRhGt6fw/mevEalTxCjzfO1f78y8Cs9S73bjFF+2WBqj0Y3iJKA42vOAknr2FrtX7EMeppDEKRAzEbYUR11CbueOwcHSvqX6RVl/z6AF0hHhuo/hS+oIVKUbiSn22SzBcSYEHFN/dKzTNB+JNYlg5QfAIUOHJ3Js50fzve9fmXHG3KJwEDERArtBhvnVBBP6ueuuJ3qRoLyq/uCAEhxiiHhOqXSPmbD45fhNX13vl/OiQmMy2+d/mjS8LUKXvJvTbrV03Yh/FVg6eZYCyZi+TYH2ttiCIX8xVyrGnhI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTg4MEloUjUxK3VTRmpEOUpKMjNuSS9jTW4vU3QyNWRMbVJsWjBJQ0dwL1I2?=
 =?utf-8?B?MzhSZ3dQNWI5R1ZoYlNJL285T3YxKzdVb3M2MU5KRHZmdDhSRFdDYXNDYVlX?=
 =?utf-8?B?WlRqMnNEOXJjekErTGhZb2s4cDFVUlNvUjNoUEVQUHpzbGU1aitobG1KS3Bm?=
 =?utf-8?B?elJzNDhuREV1SXZJOHVwZjRFQnFyWUZTV2pZbWNRbFM4V0xVUlhoL3ozeGt6?=
 =?utf-8?B?NUhtR0JZc1JvQ0VXYXREb2x5UTBaWnRuUzRMdXNESW1PcWpjZFRTK0NwZE1J?=
 =?utf-8?B?Ynp0elJtdWJnekdZTTd3ZWZ6MVhyS2xTamZhckg4dWJBK2taVi9mTXp1QXBF?=
 =?utf-8?B?NlZ4Z0pqZEw3MkV4SkJzK0R4eHVKMEVpTndwelVBR1ZLdi9tL0huVTJhclFT?=
 =?utf-8?B?ekhaTDlHUTdTMlZoWUFycVRpTXVDTGlKeUF3enpqNjB1UEQvZG00NU5ac2xx?=
 =?utf-8?B?ZnZEdmFxK2JSWkdnU2psMEhFcGF3OWMvZFQzZTNHUk1SWlRmZWhsK0hsOGlL?=
 =?utf-8?B?a2phbjVESXVkRm9uSmU5djVsVmZJZSt6MVMvbXlWSXlJUGNIYlJzek1POVp1?=
 =?utf-8?B?blZIeDZhVzUrQ2Qwb2hxRmM2NWJzd2ZncXFRaDNrQTlJOUtBK0lOellwbFd3?=
 =?utf-8?B?S0M4cDhWVmF5N3ZNWEppcUNzcGVlRERnS3RVcUx1ZDFPb04zamFqVzFRQlg5?=
 =?utf-8?B?TFZLelFhdUdHVjBPKzRlRU5jaSs5RlZ1eEh4N3V2YXh5NHVST2lzNmthS0My?=
 =?utf-8?B?eHkyZi9Da2tEOUdvbnBGbkVIeVJRdWdObWp0bFdGNlA4R25hbVkrNkRTT2V5?=
 =?utf-8?B?T3VadzU5ZmlCYVNuOXdYcXExQVdWMTlDeFg4QTRJK2pWbHlRTTV2d0xldUN0?=
 =?utf-8?B?QWx4dkZVS3NRakFONXpFemE0d09pcWxSb2VJdDhDZGRFViswY01uWnZPTXFL?=
 =?utf-8?B?K1NrK0lUZzBxaUpKRE83UDBpYjdJZENYMEt0dDMvWkJNMmtUNXRyd1pWeVly?=
 =?utf-8?B?MnUxTGJBbW9tMjZaQjBrYlJkenZqWE9DM2tQTzM4YlE5dkpPS2FESi9RZkQw?=
 =?utf-8?B?MkNGY1J6cWlrbTd3c2NHTGxtQXpUZTl0UlNwNkVSc1E1NmVFS3RhV2FPdDRZ?=
 =?utf-8?B?RU1NQUw0eDNWSWZ4R3RjNWd3eUt4S0RPM2srTURIRDIycGNVVzhEcytuTVlK?=
 =?utf-8?B?R3BUSklFTFhRczFwaVVFTk1PZk9WVlh1VFkraXFCaE1TWGp4RERDb1QydHhW?=
 =?utf-8?B?Qk11ZUQ3eURIaW1ndlFyQWpFcWgvQkl5MTZ4U2NKVkdSWmZ3a0ZPc09VMkFB?=
 =?utf-8?B?dUJYNE5DU0xtb3NZRWJxMW1KTGNCd2pvZmwzREpXNmtMMzRPV0lxL1liMjhU?=
 =?utf-8?B?RkdFUEE3bU1nblFDWWxwb3NKNVZOVFFNdlRCZGZMSGJtSG9HcTZIaXMwV2ti?=
 =?utf-8?B?WmdSYVJoWXdNb1dFQUJwbklEV1JpaVVqZytLOUhTOHUxYkQ0N2ttd0NkS0Z5?=
 =?utf-8?B?S1FzcDhUR25nTTBONDlaUGc3K1dNeGxPekdHVU8rZURMU3RaVlhKWXdnQVJy?=
 =?utf-8?B?dWJTQnN4T1o4RGRRREs3MGU1K08xbUxQTkwwTk8vUHd4K1QrT0x3VXBuWGRJ?=
 =?utf-8?B?Q29DMkZDZkpRb0xMcjN5YTlMVlY4eTFEYWxrWkVWQnA2V0Y4T2Q4aDhXOU5J?=
 =?utf-8?B?ZGtCY0E0YW5KOStYTjYrQlRnZXIyU2d4NEVmK2w2Q1dyOGVzaThCaHp1cHFD?=
 =?utf-8?B?UlpKbGE2a3VmTkhla3ZLN3k1WEY5Q3NpdlN0WGVSMm9DNHJWRUVadzZUb3BN?=
 =?utf-8?B?Q1Eyc0ZYODdiTlJTV2xEYmFxZENvb1RYQUhBMDlic3YvdFVpRm5QSXJxOEgv?=
 =?utf-8?B?aUZhRmdTQUwyaVNMQzZFa1RDbkhWRE9YdUhmYmVncmpOalEvNU1BUTYyZ0Vr?=
 =?utf-8?B?RksxeUV3YzMwMy9DeTJKamtVb0RNdnVyeTROUi9WYWx1T2MxMzBxbE80ZEQ4?=
 =?utf-8?B?TWpObkN6R29XaElUbjc1RnEyNHZ0K1l1UjNZTm5BQzdwWXQ0WG5XenZTL0h3?=
 =?utf-8?B?S2IyZ2FTY2UzaTdXTi8xYlZnbERHaGJyWDk4R1ZyWTJqWmhCd3RxbTNsaUFq?=
 =?utf-8?B?SU51MnlHU1R1ZzJSeTYrREtDRmxkUUlmUUErc0hEdUorMUxrVXdHVFN1WThL?=
 =?utf-8?B?eXR5SnVIT2xuYmcvZS9VdFpGL2Iya2VJOWNCZU5VRDBnZmhyZXpzS2JaVnFu?=
 =?utf-8?B?bXlXcGtIWGZueXp3SndQLy9VL1FpdmhoR1Q5MW00YjVZd1pTMGExOWhzZVds?=
 =?utf-8?B?QlY0YjdRTHR4ZWhRWjN1QmM1ZDJtbmMwM0k0bkNqVmJHSkdZRkNCdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 71babb21-df1c-49e4-652c-08ded393a06e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 15:00:14.0758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjBjXzHviXaaa/qQbrQwr5an8PCy+l5onAo8QtFkqTWs9zXqiU8A8DLYBT3KKlfyjaLAgGliZq+oteyLbLoST9QJUlUax/0a/YZGUw6VcBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7160
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
> Some prototype boards default to a non-cold reset type, e.g. warm reset.
> 
> Add 'reset -c' so users can explicitly request a cold reset when needed.
> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
> Changes since v3:
> - preserved existing behavior for 'reset -edl' handling
> - corrected commit message formatting
> ---
>   cmd/boot.c                         |  3 ++-
>   drivers/sysreset/sysreset-uclass.c | 13 +++++++++++--
>   2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/cmd/boot.c b/cmd/boot.c
> index 29cdf4a9a81a..5cac6cf3fed0 100644
> --- a/cmd/boot.c
> +++ b/cmd/boot.c
> @@ -59,13 +59,14 @@ U_BOOT_CMD(
>   U_BOOT_CMD(
>   	reset, 2, 0,	do_reset,
>   	"Perform RESET of the CPU",
> -	"- cold boot without level specifier\n"
> +	"- reset using the configured default type\n"

NACK. It performs a cold boot when the level (-w) is not specified so we 
need to keep this as is.

>   #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
>   // All options handled by sysreset drivers via their sysreset_ops.request_arg callback
>   #ifdef CONFIG_SYSRESET_QCOM_PSCI
>   	"reset -edl - Boot to Emergency DownLoad mode\n"
>   #endif
>   #endif
> +	"reset -c - cold reset if implemented\n"

But... why? `reset` already does that why do we need yet another option 
for something we already do when no argument is passed?

>   	"reset -w - warm reset if implemented"
>   );
>   
> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> index 5c6dd7cc1c55..1ba698b37285 100644
> --- a/drivers/sysreset/sysreset-uclass.c
> +++ b/drivers/sysreset/sysreset-uclass.c
> @@ -168,8 +168,17 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   	if (argc > 2)
>   		return CMD_RET_USAGE;
>   
> -	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> -		reset_type = SYSRESET_WARM;
> +	if (argc == 2 && argv[1][0] == '-' && strlen(argv[1]) == 2) {
> +		switch (argv[1][1]) {
> +		case 'c':
> +			reset_type = SYSRESET_COLD;
> +			break;
> +		case 'w':
> +			reset_type = SYSRESET_WARM;
> +			break;
> +		default:
> +			return CMD_RET_USAGE;

NACK. We support passing arguments to sysreset drivers whenever -w is 
not passed, so this will break them. See the sysreset_walk_arg below.

Cheers,
Quentin
