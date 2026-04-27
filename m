Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EC1FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1255839D9;
	Mon, 27 Apr 2026 11:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HfMPY++Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7D8383C14; Mon, 27 Apr 2026 11:14:04 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA10183693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kwt2EnQIX2jqn52AJw1Qbhic2WvajS1oASB4h5vj/T+FwLYXhhoBK3/DmEtCDHOZIHyvx0H8nUOdLfOS9DJSCcVcUx8i9KBhmV3PLbYfr2P1STV2b5fb71oRufffVSRgJ11J7NL0bveiWNLDTVft7VRMen0aZiGFts/dgMo/jQSkhT0437mL7yHXe2XBvk0JTkSfeSi9ypQ0rHCnGoIAIkpRsQY2peCwQc1jGIpX9uGkK5R3TPIyWClRDmwm7ZgnJ/Y8a1JQZv7Jc3+u7kJKjXdClEHLAQsr8VrLIYqRTyxNQ1kSSzDVbMbfjqZcXOYLU07Zwe3cfDsASV08KrJRAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npcr4Ab7+DZFYp5nCN/NFvaWKNSRPUSt6yONx62iwiA=;
 b=X+R/xaatH3B438VNuw0lQtBDqU5CHZojoFdz4OhlFFfR5Q17vH8jxZFuwOyZ/SuXQB+T6Vw07iwzlLsMYEJXrxbMi6gdkbulJl5+3UsFh8X6Zm8HkrBAhlLlOn7zBlPsdmc9kEq28hGxKBe5V1lYHNAaxCMukLOqKxGFYeOKnkFmZC9v8Ma0AOFtxWGWxMBQ9EXWDppAS+7kW0+6g7jJhVSP+UABXLHGplrpNul3pLa3CxC0FmaCPQA4woyYrrK6nHI+lRHYVAVgEH0zQsN3rNfbcAuyH9tePCrB9jo58ySvjNAcxC0/IXMR6t1g5YteKPIoE+zQIMwiplAcs0juXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npcr4Ab7+DZFYp5nCN/NFvaWKNSRPUSt6yONx62iwiA=;
 b=HfMPY++QQgkbR8Twfr978i7VRrK164SbfTixv1u2sFJTTD9et4bH59uUWHOm040KVHTU2nFnjH7yR+646wmz1mE9EseuJPQeI/+Fdqm+CP/ADYR+GCFVH1vxkRUszCRosEuBqA/jVV77aurY6vOplQkvLxWFOb2gb+Cc/acHS2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by VI2PR04MB10787.eurprd04.prod.outlook.com (2603:10a6:800:26d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 09:13:58 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 09:13:58 +0000
Message-ID: <04536c1e-c732-4d55-a98d-c14acf2d8336@cherry.de>
Date: Mon, 27 Apr 2026 11:13:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdtgrep: Add option to reserve free space in the output
 FDT
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260422023131.2813748-1-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260422023131.2813748-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF00000936.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::827) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|VI2PR04MB10787:EE_
X-MS-Office365-Filtering-Correlation-Id: e75a5658-250e-4bd9-6fcc-08dea43d5039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UhULLL4Kbvo6oaQqg1C5Kq+TyHtEHQPGL08W+EPLTaWyuEOMhW5Mrz0+O9k9diwMDjeTU9xnGXsZTWZWtBqKwlch3NalpaApyTWerl8UuAGPMh6BDKtLyrF2WhfNsjGNDtq1+IcnQ4td0vC5I1xMjl6GvlKs/qY03n4OBMKrG/IlEGxzQgRcB6IG7heTZu029paTWejqZ7+3avBq9Al8q42EsjlkV2Zb/yQmw9Ctiuda8zNcVzIPOMEVWOFPA4NO5iVUe8xqw61UEquf6vEpmsSiJWqvnxPGBSHspvOf/SuetGCEn8UCpUKM8JyFLs0Uc9HoXsAHmZNDgOueSUOmf/P4kpsinMDijeTxbY0vZ9b7sbRl3QM01CY8O89l1WEVAFlU1frNZieZvkhdRxmIwyQK3lPiG3HnLlljVCLnDXj9WrRvrCwCqAHfOs1BZn5x8U523HHvDbpJQ4jxkBnvUrs8RHaifbExlel15kiRccY1CMKOFTH2/bCAwu9bgYyAYXlKbJGfzyOv9WVKSXv5sCWja6UmVbQRNUwWoT2AYOTBXl1ay283rxtc7L9k7EYbtcLdSvwc1niBCvZdsKFJomsAnaksFa/a5pzHjUfgKrTttnHrPYX11wEB+MHp4gnNd0xx+W9I6d6TubSPdpe8tQBQqAEwySG/Iapkck9PXRURQd2e5UQJvRkudgJBHeM7+vGLpGdtCixpb58z9sE+SkB7ludm+hNAlmOtfWs2Cfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anRLejdJUFdBM0ZBczAySGJqRE5xTEpQZGpWK0wrb2RGcVJXcitoTkU3bzMw?=
 =?utf-8?B?ajFrV1JhU0RmRnl4T3dGNDR1dkx0SFprWlJVbVJYekw3Q2QvclNwZU12WEVj?=
 =?utf-8?B?cEk2Ymw1L0VKNzNZbUJoUDR5dDNMMGlTMHlVQjNXR3BqdUNKK3g3RDhCR2tS?=
 =?utf-8?B?SzJXUTBjckUwN1I4TU95ZlE2UGZIbnMyRkVkYWhvYUtxV1lBZzFRMVhPNEJZ?=
 =?utf-8?B?TFBweXp1UGtySGdmdEErR21naUxoNXNFVDM1ZzNvM3FWY3I4ckd0K0dCblFZ?=
 =?utf-8?B?SzVlOXUreGg5akV3Y2hpSWtMNDh4WVpwZ05oMit2NnZualQvU0RtVy9xcWkw?=
 =?utf-8?B?UDlXQTIwTGZ4VjBjTTBUTTNzM1FaU2huWElnWFp4NmlORnh3SjJ2ZzM0YjZ6?=
 =?utf-8?B?TlB1cWRxZWE0ODBES1F3Zm9xeUMyTGdKL0pzaUtyQW5YOUx0UHBXS3l5bXM4?=
 =?utf-8?B?Y0xzL3BDdjFZdkxsTEh4WklXTGxiVVZxZGttQ1JlbDRJVnRtMUhmNUl2RUpx?=
 =?utf-8?B?VkFIanNFdTRxVGtUZkNOM1ZkSDU4NUlIbHE3RTc0RUtKd1V3OHMwOTBDY0J5?=
 =?utf-8?B?UDdhVmkwcWkwT09HVnVGckxNM1p0MU9IbkxvVldHVzR6bTdLeEx6QVVQbjdO?=
 =?utf-8?B?d0dMTmxJSmtqQjF3bE15VnhmMWtUNHQxVTJ0M0oxSnlTQ3dKTzV4YVQ3TUo5?=
 =?utf-8?B?Um5RckJJbHdHRUZ3K1pXWWhKSGxJK0RsYjhXM2ZwdThyd3paS2V2TEVTajlt?=
 =?utf-8?B?RFBZY2xPT0xJdGxRa0xaUTdyaWp3ZG5EejV5OEh3djRhdlgxQy9POEZVUkc5?=
 =?utf-8?B?OVRKVmRMUDVRQ3NyRExWR0ppQmxYeUg0OXFJRzZqZ2FtbVAyd2hFNFNCUkVB?=
 =?utf-8?B?QzBHZEg2RGJZK2ptZTJnY0UvL3VIZDMrMHNzVmVER1lvVzhHNzlRQVZ0V1B3?=
 =?utf-8?B?OThxY2tGSU8rQnljcjgxK1piNkFoUjRCU3ZRcnQyVlVzR3R1ZVlnMVlaSVZi?=
 =?utf-8?B?Z3dxbGJKa1JwbGgvM3RKM1AwaXBSRDBHK0FXU2daZUdZNTFaZXRhWmhhMlk1?=
 =?utf-8?B?dURPSlRUdnlaSmhRZGNpMGNiZmtTcnNMRmlmM2NDdHdpOEtENWg4TE51U094?=
 =?utf-8?B?N2ZrbEl5SGMzUkhuRWowcXNHSUw4Rll3bDJhaWt4NVVMMW4zcURQTmVFeDlD?=
 =?utf-8?B?Z0I2R2RONDVVWm5VZlEzM0xMZE41TENTSXRJNzJWckIwS0o3SndhRmY2eEJw?=
 =?utf-8?B?emJ0NWFqL1AzRnlnMGFyM1htbzFoTnMweWRScHF1V2dUWnFWNmVCZnpSWGRQ?=
 =?utf-8?B?dmR1MWd0MWN6WnJqek9OU0pnZHpuMy9lakJrNHczcG5PcmlhK1c0K1g4bGRE?=
 =?utf-8?B?NFVQT2h3WGg5UUxRSnl0Y3lkeTVLYlhvaVVOK2JhQU16d2dlSHcxWXlKSVVt?=
 =?utf-8?B?UGlsb2FRRHdRM0dyNzlmN21lOEFUbkk3NnY2bGdvSnJ3OVRVUnkxNGdkbG5Q?=
 =?utf-8?B?ZmNWdTA4SXhYOUpPenM2eXpIOVVvaWlSdHBSVDZRbldQVmtIb2ErWk9zZkha?=
 =?utf-8?B?UFV4WGEyS0dVd2x2bFR6UlhUT0I2L1FMeDNOemp6NzdHZmh3U0w4a1RhSXkz?=
 =?utf-8?B?STVuVjNDUVEyYVovVGRURzFuWkdjUVdycVJrSjFjb0NqdTJtVEJJSVB3eFYz?=
 =?utf-8?B?WDR6WGQ2V3Q1YXVxZjJTYmdRSFBEWWljdWFEaXBTUGVmaXJXUXVtL2duTHdB?=
 =?utf-8?B?czdQTWtIcnp2ZzdoZzAwQ3dscnlHVVk2eUFDS1pZODNJQzhtSEtEU3N6Ukda?=
 =?utf-8?B?SU83M0tCNmFqQ0pTZEltdmlwd2wxQW9jU0szRHBkeDZNRFBHQ2RqcnNBcUdE?=
 =?utf-8?B?dzcvTkhGZzVqL1lOTmxsT1N1eWUrK2VpakxldFlhcEd4dUVleUMzVE1kL1dT?=
 =?utf-8?B?WDg2QloxenZiSG9aK0lWVlRmM2ROTUs3NHRRZzZ6VmdxZWNzMmk0K0JjckhP?=
 =?utf-8?B?NkNVWWZkUytlVU9Bd1VFcHBMUUE0VUVockFQazJIb01IQ3dhaHVtWTJ6YnJH?=
 =?utf-8?B?YnJ6MHdYMklxemxGODZTMUtjQkcyaTZKcXgyKzZEV0FsSUY4OUN3QmNIa1Qy?=
 =?utf-8?B?ck41cGFES1JGYzVXWUdWeUt4eHJ4TnEwREdJc0tNRnUwUFdBQk5oakVJdExH?=
 =?utf-8?B?bW90QTBkWVhCNEkraGxBNWtyZEkxMk1XYmNNYTFQMWxXQzJQRHdjbG9uN0Rm?=
 =?utf-8?B?NktlaGNjTUJmbUJ5TzhGNkV5RElLcGlod1l2N2NYdFZXbWpyMUVxb3dMKzJp?=
 =?utf-8?B?UjJLWUR2eFN3b3ArUjdjVmhxREVLSjNnc2E2QzhkbXBVYjU1RzFmaDFyRVV0?=
 =?utf-8?Q?2zb7BVx/e9cGJRKDZe8YdIKRCDTdVqnlrZxOr?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e75a5658-250e-4bd9-6fcc-08dea43d5039
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 09:13:58.0994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oNx/auDWML9tl/mrgbx2KmpESMnV15qZdEsCh0Nd5zONl4SI2zvwo7WQk7mlbJemisU1yHUm1F/D99ZMcqniM8JfbbtxGPnRJIHZFAUJ/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10787
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

Hi Simon, Marek,

On 4/22/26 4:31 AM, Simon Glass wrote:
> When producing a DTB from fdtgrep, there is no way to reserve extra
> space so that more nodes/properties can be added at runtime without
> growing totalsize first.
> 

Ok but why is that an issue? What is the actual usecase? What I'm afraid 
of is that you pad enough and you hit random bugs because you forget 
that adding enough properties can now hit the size limit and you forgot 
to add the logic to resize/grow the fdt when it's too small to fit new 
properties.

> Add a -B/--pad option that appends a caller-specified number of free
> bytes after the strings section and grows totalsize accordingly. The
> padding is applied after fdt_pack(), so it is not reclaimed when -r is
> used.
> 
> Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/btool/fdtgrep.py |  3 ++-
>   tools/fdtgrep.c               | 31 ++++++++++++++++++++++++++++++-
>   2 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/binman/btool/fdtgrep.py b/tools/binman/btool/fdtgrep.py
> index 446b2f4144b..7b393241878 100644
> --- a/tools/binman/btool/fdtgrep.py
> +++ b/tools/binman/btool/fdtgrep.py
> @@ -16,9 +16,10 @@ Output formats are:
>   	dtb - device tree blob (sets -Hmt automatically)
>   	bin - device tree fragment (may not be a valid .dtb)
>   
> -Options: -[haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
> +Options: -[haAB:c:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTvhV]
>     -a, --show-address                 Display address
>     -A, --colour                       Show all nodes/tags, colour those that match
> +  -B, --pad <arg>                    Append free space to the output FDT, for later growth
>     -b, --include-node-with-prop <arg> Include contains containing property
>     -c, --include-compat <arg>         Compatible nodes to include in grep
>     -C, --exclude-compat <arg>         Compatible nodes to exclude in grep

I'm tempted to remove this and just tell people to look at the 
documentation in tools/fdtgrep.c. Especially since we don't actually 
allow the user to pass any of those parameters themselves via the 
bintool, so it isn't actually useful.

> diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
> index b4c041070f5..83e3d0b9314 100644
> --- a/tools/fdtgrep.c
> +++ b/tools/fdtgrep.c
> @@ -64,6 +64,7 @@ struct display_info {
>   	int types_exc;		/* Mask of types that we exclude (FDT_IS...) */
>   	int invert;		/* Invert polarity of match */
>   	int props_up;		/* Imply properties up to supernodes */
> +	int pad;		/* Free bytes to append after the strings section */
>   	struct value_node *value_head;	/* List of values to match */
>   	const char *output_fname;	/* Output filename */
>   	FILE *fout;		/* File to write dts/dtb output */
> @@ -913,6 +914,27 @@ static int do_fdtgrep(struct display_info *disp, const char *filename)
>   			size = fdt_totalsize(fdt);
>   		}
>   
> +		if (disp->pad) {
> +			int new_size = fdt_totalsize(fdt) + disp->pad;
> +			void *new_fdt = realloc(fdt, new_size);
> +
> +			if (!new_fdt) {
> +				fprintf(stderr, "Out_of_memory\n");

Should we free fdt here?

man realloc says

        If there is not enough available memory, realloc() shall return a
        null pointer and set errno to [ENOMEM].  If realloc() returns a
        null pointer and errno has been set to [ENOMEM], the memory
        referenced by ptr shall not be changed.

though it also says

        The realloc() function shall deallocate the old object pointed to
        by ptr and return a pointer to a new object that has the size
        specified by size.

so if it happens in that order, it's freed before being reallocated (but 
I would guess this to be racey since you want to copy the content of the 
old object into the new object and if you free the space and it can be 
claimed and used by something else).

Cheers,
Quentin
