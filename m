Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C059CC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 02:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0671E848BF;
	Fri,  3 Jul 2026 04:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rXoD/OuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21C0849F0; Fri,  3 Jul 2026 04:35:14 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0EAD84857
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 04:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LF7XUyRKRCCH8Twru5Z88F+njQ8RWUmWIX6J5U4TV1nZv8EiCVhGpClYKy2vQ4Y5Qk5AoavLVnBFsJrpNc0UFLYOqWOAB2cFQ99eYwdGT2iO/5nWXfSmqfrQtajvu7jQTa+QIXrCLZa29LbPR/dKb/QmKkZdL+yidGMXYKSEKvzRguwW36JMkexgSzGAgr8UThPD2D4QYwKM9pGQHmKEjLoBpsOM9MgF0hCmpXxAiZhPGv6VKG7qsyCxnIqo1/NHdUHc6iKuMf3zPXJ8d2BJMLSU1SSD/FOT8lXAqJ95hPxckMdP0bGWI9oe3Bnsbz4XJNz+zLwo/bkLRGOoX/ifRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xl6pbWdM8TGMVuHHaKF2zr8+cTFZe8E4pRx8uWgDjg=;
 b=mCosF5/XdnUoxLWJKAUtO2iQObdzjR1HcRSG+/D6YRwwfevfal4woMPEKVfzVLwQxo/bmGqsHJouQ7JjCD5rSzC+UrJg7h/qDlweLPZztFA3+O3QNfed+7b3WN1/P3je49aXxFwcANvtjnYCPdD64Kws8a38FqzygZsTxlU/2N2N1qI+BCEqcuzifCR8pVoR2FdklVIu3U8zPMLPOwwcoNfKuy9CiqC6RoACIDjb65/r6k9eVKZ2wyj10aMtdKYXd0n/jTE1ipf/irT4VsC361+f05Bx/cdIvViTDg3gulg41UVgixzlqxt7ujbyoVbjmwLbNEx3yXPzPypbYsUHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xl6pbWdM8TGMVuHHaKF2zr8+cTFZe8E4pRx8uWgDjg=;
 b=rXoD/OuFk/LEISAxRuyenuIZq4bYjk9Yqiloj0ien9VTFwC7ANkdn/csBiema57x8QtyIVvfcF3Wfph74bNX3QjwBqABnVWHruJcDZ44hxQvqoSzAvBbGiADxZrlfHTJ/glnh9kI2slYOL/4wRVnArWzpZoa9LXHZj/T4hMkYGa81i2WRDWmSVFkfg7akcYT5zgXaAbts8JzJu6EjcDhz9a9VAO4rjIYbJuPi3+qgdseODwOJkUe7n67QWI9usDoUYt2L1rR7tfTUbr4Sl7spCTK/YoVnf0D699gJ7lNf5eBOJuXHTgyr/cX/rZOPwvZjnON+EVY8ZWWtq+k7gFGIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA2PR03MB5851.namprd03.prod.outlook.com (2603:10b6:806:11b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Fri, 3 Jul
 2026 02:35:08 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 02:35:08 +0000
Message-ID: <68f2fce5-91d8-47ce-bb0a-72373cb2f3e3@altera.com>
Date: Fri, 3 Jul 2026 10:35:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cmd: i3c: fix list and current needing pre-selected
 controller
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>
References: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
 <20260701102754.345049-3-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <20260701102754.345049-3-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA2PR03MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: e4337bf9-1bf2-4c1c-9e14-08ded8abb2c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|18002099003|5023799004|56012099006|3023799007|55112099003|11063799006|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: YeLVdmFJVxPnYq5yWl+Wz/ZeSdRHbqA0j2E6eM/yYolCeFY2+0OyhUepwxZDa+ckQ/BeNEXKIQEBEziHA9dUor+kmQSkKBB20ar3Re2iNrpdCQtI8VUdmBnSEGOk/3jOWqgAbFNxRy+vUinU1vJz1Ka5+s+YOsv+oqslFI1xLWYIXKXOXplO/TiwH9C86V5yh4xckxX/yS73VyMfFLegtl9TK/7TTbenShCBxe3HICybA/BkHievRgxCHMGOduUluJQzo6/x4gFkn9Z0mrZGNIXgLj9YhMMol08xs/068MKF8jEwmNstaDbeXbA9fuirMGPTMzPsOk5HLNL5+9n/LRaW7rwFyyAj53GOZxprze1MAi2awDR1FisnTfEWMBZfogZEnDeUSMlWjU9RRaN1XzlXXUoFYJAb+0yLfhzvUBoAJ+FoJcfEgPERBmhqtDk9k4aCNkGl4y+gXVTcOwH+X1kHp4iwEzxFk/SRblnteGhrgefW4EJLBvMb+BbGxQz9FQR2dP3ikwKch5saxzSZHUuq5y+6ldNY6ZjhHS4pSM78tnf+yxxMt2ckIJKx+j0wCq5gLWaxh95BTrOjSirjfS3iulDo0z/gS2wHNB7k4uG7BjPUjYsuB7nk9wE86gLlcPLWoE7L1eFSAAzg/8vLRMns8VTAc9DXGvWBh8d9qbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(5023799004)(56012099006)(3023799007)(55112099003)(11063799006)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnVkcWpNNWNlYWZpdWNmTEpqTDIxaUsyRHJ3dTk3MkRhSzJjckZEZW8xWjYw?=
 =?utf-8?B?SExWT3lMcXEwOWJIKzRYdGh3ZUNScThlSW9qTXB3cWtBenMrU2lpTStWQUZR?=
 =?utf-8?B?UllLUVZjSEUvR09GdVd1MUFIQ2swc0hoNGRYSG9oczBucitMSUxDSGpsTFp0?=
 =?utf-8?B?TTNzYkJPa2docUFvb3VQY01DUEdwVWNkVXU3YnIzY3k4WkNNT09UYzlGTUY2?=
 =?utf-8?B?QWNNUmRkQ3dvL1BBWWZRSm1nNVhEaGxweURyV08rVzEyZUJRNzltVVJQWDlx?=
 =?utf-8?B?eXdUZG9ONlRjcElLbEdVYjFOUDFOV3QxbTN3eHdRT1grdDY4ZGFJeStyblda?=
 =?utf-8?B?UmRjR04zZ3ovRGQvdWJMdTBieUYvMWg4eTZMbGROVWFSemJHdFpzdHlmVGNJ?=
 =?utf-8?B?aU4xY0l4SFpoRmhEQnBvT0F6L2tlTzhmNDd5cjlzNUZ1Ti9Ib2V2RitFeXRr?=
 =?utf-8?B?a3Q2ZTluMDhMZXFaQjFYZnZxTUZJNEpKWE1RLzVtaHBiNlJEdVVrT0h0MGRX?=
 =?utf-8?B?Q1M5UlcyaU81d0x2dERTQ055VDFnM0JhTHFWVXBLOFBOd2NuRHVNamR5Rmxj?=
 =?utf-8?B?bEkydzBuckNsQmkyS0VVUklVRHErV1RqeU9XQVd1RTJKZ1RDQlV5c1RLSHYv?=
 =?utf-8?B?TTRFUjVNekxDc203Y0F1eUxNbmd1NnR0WGdhcTlmL0ErWWR0SFQ4eWViT0lN?=
 =?utf-8?B?bHcvakNlWCtHbUtBRkhXM1ZCZFBHQkRBYUFhRTdidUR5eEF4c3BtY3hZMFFO?=
 =?utf-8?B?RFJ3ZENSWklIRjkvNDJJeUJ2V0dVcUY3eUVlM3dUTnZ3aFJJZWZ1ekVXUGJz?=
 =?utf-8?B?YVBvazg3YXRaQU5ZZFdLZGVVaUJSSTRycS93QW1vUVVEeEgzb09lWXYzcnYx?=
 =?utf-8?B?bGhEVmVhUkVSTnJ0Ny9SQkQyNVRLNlpYU3NjVzF6enBFWjl3MmlMdko4aU9q?=
 =?utf-8?B?dGdnckdwbTh2ZFJFNHN1WlU3aGk2SGcyNHJMdEMxYnN2dDBsWm5LN1Q0c04v?=
 =?utf-8?B?QUEyN1ZFbmlQL3d5YWRrNm4xNVVzTTNrU1NqaGhjMndOY1dxUkFZTUh6TGZJ?=
 =?utf-8?B?YkVnUUlrYmdNRE1MQ1lSWkQxbTJWMTBpWlNBVFQrbWdZcm9TVitaVHMvb0lW?=
 =?utf-8?B?SnJmS2lic3FxUW8wZ3NaOURURTZ2QVhadzZWZlhTRHBxUmgvSGlyeEZaQk9C?=
 =?utf-8?B?YUpzbjNySk90S3kxVXk4QXRRZ0hyZVd2MlBkZjcrU0RZeE5oZHNCRmY0Snpu?=
 =?utf-8?B?WEFocXZwcjRodWtQOTNQWmozUmdldFhrSGlmT2czSFpzMGFhWnZERzNrLzNs?=
 =?utf-8?B?YmdhbkJzK3NPNDdncVcvbjdlVmhXa2dzZE8vZXJyYjZFTldCd3pOaEplMHcr?=
 =?utf-8?B?UTZQOEFNOGVhb2pHVFFGaU1SR2tjaGRnS21RSzVTbC9GalgzRm1iZEo3Ujhm?=
 =?utf-8?B?cktGd2piczN0YnJUUU5CY0JTY1lJQnhIbU85cm50TUp3allTNk9WRmxYdzRL?=
 =?utf-8?B?akZKaGw3SDlwSzE0R1RMc3ZudHNqOHpzTU1PN2lQd2FiY0VQamxqMWJISTRV?=
 =?utf-8?B?YVdjeEIrVHM4VnNKcEpFQ0xDYnlSY1FNQ2NwVk5QdVJ5alQ1S0Vad0lISGhw?=
 =?utf-8?B?dUZhTEl6eHl6N3ZocGl6OEp5WHRzOURSMjJLMEtyM2plOHBRbTVoSDBvWFFF?=
 =?utf-8?B?MjErMkN0b0diSmJWd3dpR1NsdE1nYTllNitLQ0ZOaTIwVC9sL2dDdm1TWEx6?=
 =?utf-8?B?eTFPZ1hRQTA5QWQ1cFZLU2pCWHI5RHNFRnR5RFNZRmxmUE43c0ZvbkRCaWdT?=
 =?utf-8?B?aXRRRmNWUEE0YitxM1BSSThyYUcxaHlzZzh1blBFRnlPYVpyNVU1RThPZkk5?=
 =?utf-8?B?NHRUcG9xV3VEbVdzMUhoZTdWMTRuOWpHMEpCMHZtZVlmVlptR1R3dmk4TDVC?=
 =?utf-8?B?T3FCeS9WVUI2S2NjdE81RnR4WEpiUkZCWm5YVkhYNlpkVTBOYUlIZ01DYUV4?=
 =?utf-8?B?RkJLeWFEMUg1dUM1b3hNMktxUDcvdkJaNDBFT05LL0JlSXR3cW9pQXZQRHBD?=
 =?utf-8?B?NVhhTS9LdFAvVExhV3dzZ29zaDBtdy9DdGlyL0kwcUNvRW85LytadGxwY0hV?=
 =?utf-8?B?Y3d3SHRZVS9MWFJBUVltQllTam5tNmx6OFd5TU5Cekp6d0QyTVE2ZVJYc1o1?=
 =?utf-8?B?WnQzeE5GNy9EVW00WGZ3UDUrQytPNDdLZTdSMmVTNlN0WG9MbHlEekpDZU1J?=
 =?utf-8?B?KysvM1BLWnFvSy95L3orOC9lcm50bU5sQ3JDK0JXbys4NlF2YmNSem85SUt5?=
 =?utf-8?B?Z0IrTy9IblUyWGoxVVM3VFJ5dVBwcGwwcXArRnJzQmJOZElOdjc5d016K3NB?=
 =?utf-8?Q?g2Z+U9KIpbNQOlcU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4337bf9-1bf2-4c1c-9e14-08ded8abb2c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 02:35:08.6109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XaWbZMCaivfhFdbAQ2Ts2Xm8+mteiN1f2yGX/utjpybpwX7fVU8Y6sIBj686Jv73kaaO8RlNGK96BJLmVFOsiYTgVF4HWIMNUuRtiHZLSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5851
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

Hi Thilak,

On 1/7/2026 6:27 pm, Pranav Tilak wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> The !currdev guard in do_i3c() was placed before the list and current
> handlers, causing both to fail when no controller is pre-selected.
> Move the guard to only protect device_list, write and read which
> actually need a controller.
> 
> Fixes: b875409da737 ("cmd: Add i3c command support.")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>  cmd/i3c.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/cmd/i3c.c b/cmd/i3c.c
> index 08957f4d447..ba99a937990 100644
> --- a/cmd/i3c.c
> +++ b/cmd/i3c.c
> @@ -240,16 +240,17 @@ static int do_i3c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         if (!is_i3c_subcommand(subcmd))
>                 return handle_i3c_select(subcmd);
> 
> +       if (!strcmp(subcmd, "list"))
> +               return handle_i3c_list();
> +       else if (!strcmp(subcmd, "current"))
> +               return handle_i3c_current();
> +
>         if (!currdev) {
>                 printf("i3c: No I3C controller selected\n");
>                 return CMD_RET_FAILURE;
>         }
> 
> -       if (!strcmp(subcmd, "list"))
> -               return handle_i3c_list();
> -       else if (!strcmp(subcmd, "current"))
> -               return handle_i3c_current();
> -       else if (!strcmp(subcmd, "device_list"))
> +       if (!strcmp(subcmd, "device_list"))
>                 return handle_i3c_device_list();
>         else if (!strcmp(subcmd, "write"))
>                 return handle_i3c_write(argc, argv);
> --
> 2.43.0
> 

The fix is correct. handle_i3c_list() enumerates the UCLASS_I3C devices and never touches currdev, and handle_i3c_current() already handles the !currdev case itself ("No current controller selected"), so gating both behind the guard was wrong. write/read also keep their own internal !currdev checks, so nothing is weakened by moving the guard down.

Reviewed-by: Dinesh Maniyam dinesh.maniyam@altera.com
