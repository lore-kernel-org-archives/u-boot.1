Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1140BC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 18:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED5D8460E;
	Fri, 26 Jun 2026 20:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H3bge0hp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 288A6846DF; Fri, 26 Jun 2026 20:16:09 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66BE83FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 20:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAqMhFJRh7okmr1AMf0sIM1AZOk7PRYEfLq0LurQHR8B3MbMNSyyq7HDvWeQpNgLm1z/B+mlNFKf/x5ZNbQBDrdXjg54uZCN1c3lUJyXd6jsBFk6G6465TC7OYIIzWYszOqsRAvdUjkgulUIOQAcLtl7bLtDRVg6JBYlspILaGtuY1fokSERbt2FqVm7fayddc+RlD7M/NTH6b2sue6KsuMWa+TIBZoezBoLqFKs4MDAi1UBb6kNFHT9j06tChM9ClvPrPNZRJSYqfFlORb47LRt/sknWmw1y6UfJPE8RmAOPZFILad5k8AabdH3LvPmathQ0JlBj4ywNIQDrW468w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWx+5vwgscQQ8BZXNoBdA/1+lzVRXjANzLa9oNAqb0k=;
 b=joiA9f6Mw2w9Y3IVEEbepmeLrC5I/OvuneDFcea3CEruTVxPxEqIzsel/yKaYksZIzytuE9HlHrxg9DdkXn5upYo8vCKIFvtGc9+QVtYjM3BEE/hyZJW4ooy+FLuRu+rqoBlOJXrgDqNEbNQcJ1VRcQpKqT43cf/Re5yuLx4/3BR2FUzWjTRavmKW1cAJUVo1TnktNOnwvphbdSAJMmUyrEnrrg3BNiv5KUPd+1eXYW4yCWdKvdZvQlNiX3m23EQ2v9MWdFxszLPbdn2HtszKQle71BBPjLbE1NShQc50r6FMkpg5wymoNl3vl60lpBiRVMz4xSc5u3KLcyttHGfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWx+5vwgscQQ8BZXNoBdA/1+lzVRXjANzLa9oNAqb0k=;
 b=H3bge0hpkVrkcXzQL4XEepG6MY3kE0gvsxNW08wGL2rMYp9PFRpJhP4jsrAitmOuvUtd4u19qBaGKy7pgaKga6hjIZSV3/MkHSiGRA1PVx9m05829jL7Z0TwuzSx8GmmCjd/4bS51gaiVhhJCMX8AXwv9rjsigCYBUwBo661ok8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV1PR04MB11527.eurprd04.prod.outlook.com (2603:10a6:150:280::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Fri, 26 Jun
 2026 18:16:01 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 18:16:01 +0000
Message-ID: <fb320c8a-b24b-4b92-91d6-a4e68cbdbf8d@cherry.de>
Date: Fri, 26 Jun 2026 20:15:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: add tftpsrv command
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Tim Harvey <tharvey@gateworks.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Pranav Sanwal <pranav.sanwal@amd.com>
References: <20260622203157.73416-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260622203157.73416-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0118.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::47) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV1PR04MB11527:EE_
X-MS-Office365-Filtering-Correlation-Id: a907f056-49b7-46df-e277-08ded3aefa81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ZG6zjWgU9ZO+8JA+SpwgCpN1VXu8McmaBpeSHWvYHPmOCnFwBiclQ4Sc0d8VAviXOM2rKEzOYihV0VvOk2vnVwuPHDzZegz8Kqfi/zg2Rl50blO/FXhn5VEayzdCahHroK2aJtQc41/7s2MLDFiX1lhvvetiEbkavhvF2ill1Nmh2J4VJatWNJ2o5yZlePr67jjzYGtLLRhg/0yGB0C8Abbz+H26w2cJg8Sy04YPauHHnaPZjCA+r4I3jd1NflrXZu1WLGELxHwPvRqiLGGXqfdkVibaZNIGaBtsFtWc6t9VphzmVb6sjEjy6I18WFqfTEy+FH3F3alaSR+gGKxtYTNj4GmKZWLDRQkixY328nNgPwi+Lsr2FjayI/1ogIDqSoR/nsNEB8RSxTjJc0ayFnZI3eSDGIHF0xS5sfuFTVfrxIpCz3H3Pk9KqwXInZ2j1fAEwa3rvzMW9bf+cYmnIZKa905fzekSg2j3JBdgAud4VAWpuvIhqACqolaJVXNlXNCYg2i9BPi+YR2M5LeXlDVZUPKFFWP2MGH7tvK2eK2QNLx8znrY4S2k1/syjBGFU+eVbSAsBbLUm/c3CIh/dTQ9PVnb7lU0f+HFzo+biC3DbNMz7kMs6lendTc+Dk6Rx3z7ovgeJ4UxGCLhQszODWk0kr06yxhh9onQ9etbIl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS9FL3lBeUc1MFBJZUdCbG9ES3BHTnFhUzAxY1hQT0l3M3Zka1dmNFBKU0pw?=
 =?utf-8?B?RCtZOFluZGU3NUZadmR0T0F4WFdGNFRyVTYzMUhsWERGMnE3T0U5TFdPWTEr?=
 =?utf-8?B?a2Y2ZlhnLzd6YnVOTjFzUzNCbWU5VFZXcGJ5TEtTL0ZhUExVUVJBM3pXSFVN?=
 =?utf-8?B?MHcvU0FGVmsvLzFYNzBIdkFiWEZVbWErWXlKdXpnUHhhL3JGWkliR1F1Zmlk?=
 =?utf-8?B?Rm5iOHFVTjJncXJ6bHZ4VVFYb0wwMk1yU1B3ckNQN1lyZnlJOCtKV0F0MndW?=
 =?utf-8?B?aURwbDdOWGsxdHlBSnk0eWVYWlgwKy81R21kblBlVjR6clpZNkRCSWtXRE1R?=
 =?utf-8?B?TVJpdUVxY3dRelI0a3N3aXE1cDh6ZHY4RlpzUklwUjNUQnE3OXh5NU8ydUdy?=
 =?utf-8?B?MnVjbFFXUEk5ZFVEdEptVWhpQk05VlY1bXo3YTNSNyswc3kwQ2JrdkdpNWZQ?=
 =?utf-8?B?eTZaL3lOUFBNRzhOdGoxVHovL2VkdE5pbisxL0lKajVueUxkR3hlZCtWNTBr?=
 =?utf-8?B?Mk9CeWdIQkcyVFhOQ2RVdnhZZWxvUjVjR2VvUlI3VUtZa3JRMm9oUWNkdGs4?=
 =?utf-8?B?WHFBK2xWVzRQUXRpZzNHdEp5MEt5cDhrQS93L3BzWXhQUlhZUGE3WmhBb0dZ?=
 =?utf-8?B?UE01d1c1UHhjcTNhdVVDV3JWUWh3b09tZ2V5KzVlZStDcGY5UnQxcHdkRWxE?=
 =?utf-8?B?eWJTd0RkcThiTzliR0RQL3llYzNHZ1lzQ2RxbkphRUNkYzRHYy81Ujd3OUFo?=
 =?utf-8?B?RzRmVzhTSDZmSGp6MHlKT20rK0N6OGxseVJycEhzVzcvYXVBMjhyWkx3R3Ey?=
 =?utf-8?B?UjEvWVJyWE5peVkwQ3JCVS90TThYVWl2aGVpdzFoeU1jQWE1V2VJVGNENE5B?=
 =?utf-8?B?bW5Nb0hYNjExeEFVcGRtMS83cTAzRHp2K3dEdHowNENXcjJYUlM5YVhKOGtG?=
 =?utf-8?B?ZWxRRi95TWY4d0hWc3BCUGFMaE1zVWRTNjd1MFhnbHJIZ1FxRTV0c2Y1bHJv?=
 =?utf-8?B?dXdJbDBjdFlYSDFDWFRYWG9qcjFIcndVWHM2RlpVQjVLbW5ISEk0QUJZWnBK?=
 =?utf-8?B?VHhNZjAreGxYeVRhbXV0L1llakZrVDNxbGY3bDdXS0JOUUdsenAvYkFRTE1l?=
 =?utf-8?B?QjkvTWJyTmdXMGN6Um8xN2EwTFlaUWhxbUdRQi9WK045dkpUNmJCUDUrRHVD?=
 =?utf-8?B?dGs0TG9majVsTDBQNU5USWZaNXdGWmVDZ1hFNDdXWmxobURCeUdPSTZDZ2dx?=
 =?utf-8?B?dnFxbUVyRncrVEdkUnZyNk5xbTFQcXBBdGx5aFpxa3U2WjYxdnZGSXV2Uk5x?=
 =?utf-8?B?ampKeXBDZDBYM2VTUXhmMEV4eUxsN2pYVUhHS0V1UHJSbnNmUnBzNjJscXF4?=
 =?utf-8?B?Ui96MjZZdjdXVTNWcWlsUU41c3g2TVk4NTRsYkZjNkU1N0h6MGluUk1Hdkps?=
 =?utf-8?B?SUN1ZUZheVBqcHhqYUZtVWswdDRqSEI4d3E3MnFUTWp2dDFEVThwZmZGUmxK?=
 =?utf-8?B?dlkwRDhtRjI5RVhTUExiRS9hbDlkelQxY1RNdmRVQlBCdGRzRGJFOURnbWh2?=
 =?utf-8?B?MkRvcDNERmxmMFVLVkhQRjZFNlkvODBmOXlrdVF0b2E1alhyOGZtb0thc3ZP?=
 =?utf-8?B?WHVONkJIdWhDSXBQQ0hodWcyMGt6NjhTT1ozRC93akRjZCtEdzlzeEFWSUM1?=
 =?utf-8?B?SlQ4MkZNVGwzeTFtZ2crVk9jNkJHM2x1TTlOQ2cxWGVWZ3dpUFdlbWUxYzJ4?=
 =?utf-8?B?TDNheXRIbkdtWlB2emlEbDFuM2ZtaUltbkk1Zmo5SlBGbFZRaWFnZW5JOG9a?=
 =?utf-8?B?UzdzcGNkdDMwYmlWY3dlazlGcjN4dDIyK1ZrNlBZcnNCMU1EYkRBNTVkZldG?=
 =?utf-8?B?ZHUrNmluS05XYjIrNXNhL1czRUIzVHB5c3pxQThGRk9LZ1NSVUVpeFJNRW9n?=
 =?utf-8?B?YzRhMUlwUjlsWWlQR21pOWN4S21KYkxFb1gzMVd1VEVpWXVEWko5UXZZNlVK?=
 =?utf-8?B?anlRdU9IejRJajgxZEYzUGZkNlhZcnhKSXJ3TnRmbjZGajAzVmFWRk41TytY?=
 =?utf-8?B?TVQzVmV1SFVpdFJqSTUvbi8wQVRsY3oxSEl1Q1J6WG9aanVQRHRwNnJpYTV5?=
 =?utf-8?B?dGpNL1ZDNFJDZUFCeGNJUU80UHNRM2JpOXRKV0pkRWR3ZUhrRVhmQ284eFpV?=
 =?utf-8?B?YVdEQkNoK2VsTHVPQkJkVjRaTHQ1Q2o5eXoyWld3TThYbFkrRzNjaGFmTnlM?=
 =?utf-8?B?azFtYXI3dUlEcG5DbzhYMFdCYkN5cEY0aVZBRmJ5TW8xYjR0L0dIeXo3S0lG?=
 =?utf-8?B?MU10SVBhOUw0MnptMUFTcTZ2KzloOWQ1ODNFbXBOSlc4LzVQZlFoQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a907f056-49b7-46df-e277-08ded3aefa81
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 18:16:01.4699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3u+opN+aufuRGJD/umw1SjztaCKDWM53k48YDWQgNgK0QQEepZqxYAFoqBO9IEooqwFxQPRMWSw6v1tVXn3I4Y4d6z3Atg8wA1XmKvfaDVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11527
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

Hi James,

On 6/22/26 10:31 PM, James Hilliard wrote:
> The legacy network stack supports tftpsrv, which listens for an
> incoming TFTP write request and receives the first file into memory.
> The lwIP stack already builds the lwIP TFTP application, but only wires
> it up for client-side tftpboot.
> 
> Add a lwIP tftpsrv command and implement the server path with
> tftp_init_server(). Reuse the existing lwIP TFTP write callback and
> memory copy path so LMB checks, progress output, filesize/fileaddr
> updates and EFI bootdev handling stay consistent with tftpboot.
> 
> Track receive timeout and write-failure state around the lwIP callbacks
> so a stalled or rejected receive is not reported as a successful close.
> 
> Move CMD_TFTPSRV out of the legacy-only Kconfig block so it can be
> enabled with either network stack.
> 

Do you think we could get some tests for this? I see we have some for 
tftpboot already, so maybe there's something we can do about tftpsrv?

> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>   cmd/Kconfig        |  14 ++--
>   cmd/lwip/Makefile  |   1 +
>   cmd/lwip/tftpsrv.c |  11 +++
>   include/net-lwip.h |   1 +
>   net/lwip/tftp.c    | 181 +++++++++++++++++++++++++++++++++++++++++++--
>   5 files changed, 197 insertions(+), 11 deletions(-)
>   create mode 100644 cmd/lwip/tftpsrv.c
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 032e55e8127..8f3d66ddc77 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2127,12 +2127,6 @@ config CMD_TFTPPUT
>   	help
>   	  TFTP put command, for uploading files to a server
>   
> -config CMD_TFTPSRV
> -	bool "tftpsrv"
> -	depends on CMD_TFTPBOOT
> -	help
> -	  Act as a TFTP server and boot the first received file
> -
>   config NET_TFTP_VARS
>   	bool "Control TFTP timeout and count through environment"
>   	depends on CMD_TFTPBOOT
> @@ -2279,6 +2273,14 @@ config CMD_TFTPBOOT
>   	help
>   	  tftpboot - load file via network using TFTP protocol
>   
> +config CMD_TFTPSRV
> +	bool "tftpsrv"
> +	depends on CMD_TFTPBOOT
> +	help
> +	  Act as a TFTP server and receive the first incoming file into
> +	  memory. The command returns successfully after the transfer so
> +	  boot scripts can boot the received image from the load address.
> +

The help text has a very big difference, it seems this doesn't boot the 
first received file anymore. We need to know whether this was already 
the case with tftpsrv from NET_LEGACY or if this is specific to 
NET_LWIP. If it's the latter, I think this is an issue and we cannot 
really do it this way. If it's the former, then it's fine but you need 
to specify it in the commig log (I think I can read between the lines 
that NET_LEGACY indeed also doesn't automatically boot the uploaded file 
but I think it's better if made explicit).

>   config CMD_WGET
>   	bool "wget"
>   	default y if SANDBOX || ARCH_QEMU
> diff --git a/cmd/lwip/Makefile b/cmd/lwip/Makefile
> index 90df1f5511c..245683a9672 100644
> --- a/cmd/lwip/Makefile
> +++ b/cmd/lwip/Makefile
> @@ -4,4 +4,5 @@ obj-$(CONFIG_CMD_NFS) += nfs.o
>   obj-$(CONFIG_CMD_PING) += ping.o
>   obj-$(CONFIG_CMD_SNTP) += sntp.o
>   obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
> +obj-$(CONFIG_CMD_TFTPSRV) += tftpsrv.o
>   obj-$(CONFIG_CMD_WGET) += wget.o
> diff --git a/cmd/lwip/tftpsrv.c b/cmd/lwip/tftpsrv.c
> new file mode 100644
> index 00000000000..522a7ccacdf
> --- /dev/null
> +++ b/cmd/lwip/tftpsrv.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include <command.h>
> +#include <net.h>
> +
> +U_BOOT_CMD(tftpsrv, 2, 1, do_tftpsrv,
> +	   "act as a TFTP server and boot the first received file",
> +	   "[loadAddress]\n"
> +	   "Listen for an incoming TFTP transfer, receive a file and boot it.\n"
> +	   "The transfer is aborted if a transfer has not been started after\n"
> +	   "about 50 seconds or if Ctrl-C is pressed.");

I'm sorry this falls on you since we already have a tftpsrv 
implementation in NET_LEGACY, but please add documentation for this 
command in a new doc/usage/cmd/tftpsrv.rst file.

Cheers,
Quentin
