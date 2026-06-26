Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F57C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 16:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642E98404D;
	Fri, 26 Jun 2026 18:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZXNJY7Zs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42E0884704; Fri, 26 Jun 2026 18:24:39 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD8BF83FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 18:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG1vZC1LtcI61TiQQkcpK/94F9odMZOPW4CCRBJ3P8fCLwfSkRFRCQq4Z+/f5wlZK03CrFgHRsQq8WwSGb1YiaP1IzpRqpMTd+M0eUX41lAnUlf2FA7AbgXmCzY8dTIulD3aBUgGLI9cyCM/6kHnJDvyU8ZUXz988cS30mL6bUclAGcfalHeXwGtHj36mxP2OqfzUlKfjH945u+YMIqx438EBIfGGD41nyNjsZR832qqWd6lNgZ6AqNKOEeyGFxOEvJwMSQe00N8hpOEvObqlOXFEK6ARu/6hYvakvHarW6ObsLetXFIfqxG7xc9FJHhxqXdJ8QD9NIiKu8c1QMh0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc73unWslp3+fh0wFfVmyGCblT5mhztqpVtBQ8xP+74=;
 b=YicJ+9iuv3jJpoCY4ZYdYgARqstxbxHb44VEvjEyuO4Kfs+LhqJ7g8Gf39qJaLEfJdiKRRXm66d9JCWVYpJ+4SPwseX/Kf308JpevLXERqN9lX/CL9PxdmnfpX3PEazfB524fk6mQHXpMKf9UMOC7K31czwHyk+YOPSe8YmXWQV+JpAtMW4PYkDFjtyaHWq6NVP14Xe/LVibpO1AaqEqza//2vl7p2cnRPjMRl3bTbHCQXHlGgUbNYpkEYRRKtBrBgspgY12dJoLwbJYeW3jyhHeWayphTfzbi0MW6NLHNWbhawRifkxVLq03z9b3ygnaIkql43kLjywFCzrW7zdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc73unWslp3+fh0wFfVmyGCblT5mhztqpVtBQ8xP+74=;
 b=ZXNJY7Zsk6XHnOdnlhVuXjV7bixxDBjqfcMqcqgTr5nNQDkzB4u8LO9q9ojpB/7MnoVPJPqF1p/n1WGfcqQECbSUqgpR/2kmBBSuAt3B2OpM9vywxL1SPJXZXzZBzDcfd6T+OAemJrZB6oW47EzwpLKxQiAt4/nSr1HxbGXVUQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8751.eurprd04.prod.outlook.com (2603:10a6:102:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:24:34 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 16:24:34 +0000
Message-ID: <9a11b1b1-8db2-4e45-aa75-ca99152d3e62@cherry.de>
Date: Fri, 26 Jun 2026 18:24:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] cmd: gpt: enable extension to manipulate GPT PTE
 attributes
To: dmukhin@ford.com, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20260605033907.1909319-1-dmukhin@ford.com>
 <20260605033907.1909319-5-dmukhin@ford.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260605033907.1909319-5-dmukhin@ford.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0290.eurprd07.prod.outlook.com
 (2603:10a6:800:130::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: e9498fcf-cff0-4193-50f5-08ded39f6890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wDMe9SwDuuRQgl+BzUbOrdF86Fe2xCo5prqVi0G6oWiyPuxjjVL7Xvrd/iEXaKd9XAEKhGFqHvr1nceSuwBWPtl7kdfqITNgKfDjQNqqkg1ZkJzGsZRp0Np4kZH7INObkpZVy9pU9L/C8I40QWD6F/xQUVDu3mPoHmclJUKqEkwiMVRqRkY8jPNjkhirEXqrXQlbAXhRis2oReCG4G1OwT6evTbuxl1TanUuD33jtkf7t8kqioX004Sq0MMP97Uc893P0D/S7HPvJ929+b5M2hCJrFkGdWI7Ji72eqJxRiF2TK2VUS19eItRMgiTUVJiqs4OZskk8Hif0a3wl+XWMU1ay5LMDUDUEu+KlZgikdcu0RV7IOMEiXem/cDBzHNKFYXg+pL5pm1RjB4zn7CarLcUPk9Nr5xqAbLxULDkYd8moRq3sAAVCyV3kH77DJHedbnmM+lm4R6RLw93b12cJw9fQKrSfajJXoOo6ZMjp1GFN/aChc7ONgvZS0+NMGozRKjwSUAcW9P7ZulRDGq6ijyxMAGHAB9s3ms0zpv2RyYJtfGjLQxlCbSBDUFrdv9olEUuIK4PhbeJm3R/Xc6EOZBgdE/tV7T8VEzPytimq/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1VLVWlVV3hJVkRuSldtdVNGMDZWTmZ4czBoT29QMXNVR0tVL0tNK0ZTc3Vp?=
 =?utf-8?B?akRzbzZyVkcydUx4QUNFSmg5Tzl3c25hQkluRnpnU1dCaWRUb3lhY0dEcmFx?=
 =?utf-8?B?T2RSSzhLKzhpWDE4anFhNzNMYlJJbUk3MGNKMkNlbXZZZUhibHdTdEJyOXdW?=
 =?utf-8?B?RDVEa0lZREtXWDZ1MU15THhFdFlyZWpVdUJ6aEVJZThRbFhQTTd5STJMais0?=
 =?utf-8?B?T1lLU1NwQ3d5cmpIOEhpdzQ0RWg4YWt2LzBGMWdiTXdnZjlMRGJMMGJLVUxI?=
 =?utf-8?B?Y0lacURQVmFha3dqVUhNU2lDOWtpV2FvVzRSLzdTRlUrODNnSjhYeUVEV0lM?=
 =?utf-8?B?eU1KNXZIa01ZM1YwWXRSNEI1emdmd2pYU0hXNXJVbVdDemtxdnY3UzRwMXdv?=
 =?utf-8?B?MTFVK0ZUNWMwZU9hYi9oM0hvQzhUVnI4QU9LcVlMSXluZEhjMStuRG9PZ2E3?=
 =?utf-8?B?TmIvVGxDZHd2Uzkva0FwWldBWWRNMjQrQkFqY252Z0FNYTNqUzA2MnppOGRS?=
 =?utf-8?B?ZXlWNktXeFdMV1JSL2VmTDdSR3FmTytrVDhqUDBLUlRacGNDZmdKL3ZjMzBD?=
 =?utf-8?B?cDlhQk5tdWRKT0dqQnVhWlN2bEtwYytPdjg3djBMeXFOUVZFeVhwcEgrdXBR?=
 =?utf-8?B?K1p0MU9SYlNqQ21WUy90S1RiL3hyVW14WnFKazZIVDlsWENJamFqRlRjd1dR?=
 =?utf-8?B?YmtQZmtyQkpZOXE2b0xuOXJxNGMvY2x3YmZ4V25tNHl2ZGxyOHFrY3lFZlBq?=
 =?utf-8?B?eW8yWi9kc3VZbUdrSDFDa3kyd0FybFljczlYRWV0VFFINXI5L0prRXVzY1Ns?=
 =?utf-8?B?SER4MzlPZFJsbU1lRWpPRzdDSHpYak84ck9YT1EzWTJNTStTZm9qeDJPUGt2?=
 =?utf-8?B?TnRMWU9id0daT2xpUHdLenlWbHVaMXdaaTdTZk9PRjRKYmFYdlNzeVRFVGdm?=
 =?utf-8?B?NmI5RzhyVE9CTDlWbldyMXZEdllmMFNycVNVRWtkaUZ3d3lFMlp3UUFMeFh6?=
 =?utf-8?B?QmsrNjczMklkemtpOEJCcWVoOHVKN2FjZUprVmdXSTVBaGZKT0tyWkpNdysz?=
 =?utf-8?B?a0NFbVhsOUZuWHl4Q1QxZ3k3RG1PWUtrUUVKTTA4eHlUbFA1V29rcndYcWZO?=
 =?utf-8?B?blZCV2hrSTZGV1RXSGczMS9HSVpJT3lWT0FBcXdkRThQM1dvVk9CNjZrT0lM?=
 =?utf-8?B?T2xrNCtjaUMwM2tQcEdGT0RQSnRnV3lKallIZU5NU01PbWd2TnAxMU5CekV3?=
 =?utf-8?B?cnF4MUo2VU4vNUhEQzlUUERoUTFKNmk2OVRsZi8vdkYxYWNxWnFlNHIzY2o3?=
 =?utf-8?B?M3JXU2YrdUxXQTFTTGxQdzZDNzl4Z2pJaEVNZkFlN3FMelNZYUNZZC8zT2xj?=
 =?utf-8?B?SWoxSzM0QnJxdVpiWkxXYmV1SlhERzdjMzdsK0ZlNWZxQS9nRndKSkFOL2hE?=
 =?utf-8?B?VGJlUlAvcnA3MW40dVZkald5Qy9wbkZYVVVPVDhtbThqdEw1Yk55a3BtRUs3?=
 =?utf-8?B?dE44TXZEV0JjYThRNUZ0MnRsU3BNV1hFTXZnQmxaU1FLNkpTSmxmQmlRaUtN?=
 =?utf-8?B?WUZqNnpOOE55Y2d5WkxHbWd2RkxMOWljZWVQTytEWFVhV2ovdFRhc3FpcllW?=
 =?utf-8?B?aERNZzkwcVB1WXFxdTMxbnZjVG42UVI0aWd0M2VNdTBJQW5xMndhd1JnM2VM?=
 =?utf-8?B?a21QeTBzb2M5aEFWUGxENWNxUThxTzNmWTN1Q2lGcmRmekU2Y2ExcEtYMkFp?=
 =?utf-8?B?aXlzMGR3WDNjQWRQa1lhc25tLzMwR0xTT1A4cllsWkJNWWFqSEFURzBBN1J4?=
 =?utf-8?B?VGJFQk9YMmJHNlBXMk5tN1Z4Rm5aT0pWaFNnV3U4THR2OEd1OHBtSHRlb0xT?=
 =?utf-8?B?QUlZaXVpM2pISjVjTzR3VWp2VUt3S2xUY2tjcVBWdDk5TDhPOU5zZXo4QWw3?=
 =?utf-8?B?bnBueFlvYU4zdmFHWW5jSDJOZDRkZnNUZlJhckJLT083dTdUTUNjV3UrVk90?=
 =?utf-8?B?R3pHblJnNFVESDBwRXUrZUI4bVVyVVVyU2dmV25FbUNWeDdWbXIvUzZtcjFm?=
 =?utf-8?B?Zm9CbU9jK3doKzlrdFllOWpFamloWVJJY29hcTdDZzI1ZkEvM294am9zU1NP?=
 =?utf-8?B?LzhJWXg3bVJhTmQzMFg4SmkwNnpRa1RjZFZaUFRFNXJFSS9VZUVCWk9jR3hl?=
 =?utf-8?B?SWRWUkIwZSs3Nzh6ZmVmWDZmS1NGL05IK2Y2alR2L3NtdVRTTXh3d0U1M2l1?=
 =?utf-8?B?M05vdkEyYVE0aTRZNk1RUjZiVmJXaEtBbWxzQlBIMmJGMXlzc1I3dE5lWGUz?=
 =?utf-8?B?Rlc1d0hPdituODVqWk9FMVFMcFMrd1NlKzNvNUowNjNmRmNrLy9Kdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e9498fcf-cff0-4193-50f5-08ded39f6890
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:24:34.1685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy1LvKjadgQx/jpqtWgOphHPS9e3DP2iUmh53NnIexpq+e+xYiLsfatYg6jPhMQ4NkbLJKo9MJgWfqQofxIqtdqW4GNaT9ARiChhEmNCods=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8751
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

On 6/5/26 5:39 AM, dmukhin@ford.com wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> Enable extension for existing 'gpt' command to manipulate top 16
> bits of GPT PTE attributes to assist ChromiumOS-style boot counters.
> 
> Follow the existing syntax for specifying <interface, device, partition>
> tuple.
> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
>   cmd/Kconfig |  8 +++++
>   cmd/gpt.c   | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 105 insertions(+)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c71c6824a196..83409e60da8b 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1319,6 +1319,14 @@ config CMD_GPT
>   	  Enable the 'gpt' command to ready and write GPT style partition
>   	  tables.
>   
> +config CMD_GPT_FLAGS
> +	bool "GPT partition flags commands"
> +	depends on CMD_GPT
> +	select PARTITION_TYPE_GUID
> +	help
> +	  Enables the GUID partition table attributes manipulation (bits 48:63)
> +	  in a ChromiumOS-style manner.
> +
>   config CMD_GPT_RENAME
>   	bool "GPT partition renaming commands"
>   	depends on CMD_GPT
> diff --git a/cmd/gpt.c b/cmd/gpt.c
> index 205f696c8072..4d55cb588ac2 100644
> --- a/cmd/gpt.c
> +++ b/cmd/gpt.c
> @@ -11,6 +11,9 @@
>    */
>   
>   #include <blk.h>
> +#ifdef CONFIG_CMD_GPT_FLAGS
> +#include <cros_flags.h>
> +#endif
>   #include <env.h>
>   #include <log.h>
>   #include <malloc.h>
> @@ -1116,6 +1119,64 @@ out:
>   }
>   #endif
>   
> +#ifdef CONFIG_CMD_GPT_FLAGS
> +static int do_get_gpt_flags(struct blk_desc *desc, int partnum)
> +{
> +	u16 guid_flags;
> +	int rc;
> +
> +	rc = read_disk_flags(desc, partnum, &guid_flags);
> +	if (rc < 0) {
> +		printf("ERROR: partnum %d: failed to read GPT flags: %d\n",
> +		       partnum, rc);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	printf("P=%d S=%d T=%d\n",
> +	       cros_flags_get_priority(guid_flags),
> +	       cros_flags_get_successful(guid_flags),
> +	       cros_flags_get_tries(guid_flags));
> +
> +	return 0;
> +}
> +
> +static int do_set_gpt_flags(struct blk_desc *desc, int partnum,
> +                            const char *key, int value)
> +{
> +	u16 guid_flags;
> +	int rc;
> +
> +	rc = read_disk_flags(desc, partnum, &guid_flags);
> +	if (rc < 0) {
> +		printf("ERROR: partnum %d: failed to read GPT flags: %d\n",
> +		       partnum, rc);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (!strcmp(key, "set-flags")) {
> +		guid_flags = (u16)(value & 0xffff);
> +	} else if (!strcmp(key, "set-priority")) {
> +		guid_flags = cros_flags_set_priority(guid_flags, value);
> +	} else if (!strcmp(key, "set-successful")) {
> +		guid_flags = cros_flags_set_successful(guid_flags, value);
> +	} else if (!strcmp(key, "set-tries")) {
> +		guid_flags = cros_flags_set_tries(guid_flags, value);
> +	} else {
> +		printf("ERROR: unsupported command '%s'\n", key);
> +		return CMD_RET_FAILURE;

CMD_RET_USAGE

> +	}
> +
> +	rc = write_disk_flags(desc, partnum, guid_flags);
> +	if (rc < 0) {
> +		pr_err("ERROR: partnum %d: failed to write GPT flags: %d\n",
> +               partnum, rc);
> +		return CMD_RET_FAILURE;
> +    }
> +
> +	return 0;
> +}
> +#endif /* CONFIG_CMD_GPT_FLAGS */
> +
>   /**
>    * do_gpt(): Perform GPT operations
>    *
> @@ -1176,6 +1237,23 @@ static int do_gpt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   		ret = do_rename_gpt_parts(blk_dev_desc, argv[1], argv[4], argv[5]);
>   	} else if ((strcmp(argv[1], "set-bootable") == 0)) {
>   		ret = gpt_set_bootable(blk_dev_desc, argv[4]);
> +#endif
> +#ifdef CONFIG_CMD_GPT_FLAGS
> +	} else if (!strcmp(argv[1], "get-flags")) {
> +		if (argc < 5)
> +			return CMD_RET_FAILURE;

CMD_RET_USAGE

> +		ret = do_get_gpt_flags(blk_dev_desc,
> +		                       simple_strtol(argv[4], NULL, 0));
> +	} else if (!strcmp(argv[1], "set-flags") ||
> +		   !strcmp(argv[1], "set-priority") ||
> +		   !strcmp(argv[1], "set-successful") ||
> +		   !strcmp(argv[1], "set-tries")) {
> +		if (argc < 6)
> +			return CMD_RET_FAILURE;

CMD_RET_USAGE

> +		ret = do_set_gpt_flags(blk_dev_desc, /* argv[2,3] */
> +		                       simple_strtol(argv[4], NULL, 0),
> +		                       argv[1],
> +		                       simple_strtol(argv[5], NULL, 0));
>   #endif
>   	} else {
>   		return CMD_RET_USAGE;
> @@ -1237,4 +1315,23 @@ U_BOOT_CMD(gpt, CONFIG_SYS_MAXARGS, 1, do_gpt,
>   	" gpt set-bootable mmc 0 boot_a,boot_b\n"
>   	" gpt transpose mmc 0 1 2\n"
>   #endif
> +#ifdef CONFIG_CMD_GPT_FLAGS
> +	"gpt partition boot flag manipulation:\n"
> +	" gpt get-flags <interface> <dev> <partid>\n"
> +	"    - read top 16-bit of partition attributes (bits 48:63)\n"
> +	" gpt set-flags <interface> <dev> <partid> <flags-in-hex>\n"
> +	"    - write top 16-bit of partition attributes (bits 48:63)\n"
> +	" gpt set-successful <interface> <dev> <partid> {0,1}\n"
> +	"    - set 'boot successful' bit\n"
> +	" gpt set-priority <interface> <dev> <partid> [0..15]\n"
> +	"    - set priority; 0 - non-bootable\n"
> +	" gpt set-tries <interface> <dev> <partid> [0..15]\n"
> +	"    - set tries (boot counter)\n"

These are the first subcommands that use "partid" as an argument 
identifier, can you rather use a name we've already used in another 
subcommand (if applicable).

I'm wondering if we need the additional get-/set- prefix? It could be 
enough to pass a 4th argument to know whether we want a get or a set. 
Either way is fine I guess.

I really recommend to not go with decimal values, U-Boot has a mix of 
hexadecimal and base 10 numbers all over the place but we typically say 
the default should be hex, c.f. 
https://docs.u-boot-project.org/en/latest/usage/cmdline.html#representing-numbers

In any case, the base needs to be made explicit in doc/usage/cmd/gpt.rst 
so there is no possible confusion.

> +	" Example usage:\n"
> +	" gpt get-flags nvme 0 1\n"
> +	" gpt set-flags nvme 0 1 0xff\n"
> +	" gpt set-priority nvme 0 1 0\n"
> +	" gpt set-successful nvme 0 1 1\n"
> +	" gpt set-tries nvme 0 1 15\n"

I don't think we want examples in the help text in U-Boot, it'll 
unnecessarily increase the size of the binary. I see we have it for 
other gpt subcommands so maybe that's fine /me shrugs.

We absolutely do need an update to doc/usage/cmd/gpt.rst to reflect 
those changes though (and there you can have examples!).

Cheers,
Quentin
