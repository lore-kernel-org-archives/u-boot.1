Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E189FD3775
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA51841D6;
	Wed, 25 Feb 2026 17:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Q7QuMx3x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D108841D6; Wed, 25 Feb 2026 17:30:07 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (unknown
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F40841DA
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYzGmzIODsqKLeX9UaXihlFsv0hHBgc4lYmVY3/aCkL7f0mAxBzj/JLgolH4ULAXAf59fWbqaSDKyzLCYcTjcR4Am7cQPMCKrYHVth1pz6PGflPL4BRsH2cu7yChgwn3xA7Xb81RbIrysxuE9WiWGmMJqak9s5QTes3+I/MDfAtSppaOr6oUyzaonoHuOtiCg9yoO5i9UjUdo4z16pF7JcEqNVRyoJY86qxOspAEPMfQ6ir2FmAsSwIfHCWdqw/JYoXrhT6nm2qNZf3he2rFDUJj4y4c38t69F7KcJHpTFi0srU9hpTKqYPvv14oqhjcimQucirA0mfBmCazpAzozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew5vfwggB/xOK4B5/qBjYuMu7Wtg354HGiNldB73Dkw=;
 b=s/NHFPg0wVOTbQxYY3pM6HrM8xxe9IwnDMi6qXzv3XNS5cNB28+usC6MQ9RahdWj8iBRUQasJ/ipEmPpvH7cRnx/Zrc+nBtw0Da3DdJGAiEcoOFHvIwRV6eGQLpQ1/UNYloztN4DGYba5koq17K4EpeS96U/yToimZgh8WsyuZayYhdAlZ7hfjAirUeFvvzfJrVRm8FWMmyVRKpFYRX0lsNQIFHsq2OMNuwIgXDteUAWLzeB8UOqueGMa2plEEWciapk/36Nkd1JeLj+t+YPZdx1UMGa76QCMTt5N2kdDvhYDKX6UbcKIhWtcOmT2sZlFpCTeEubYnTg5Pl801odPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew5vfwggB/xOK4B5/qBjYuMu7Wtg354HGiNldB73Dkw=;
 b=Q7QuMx3xWLgxNCurtBeruPunf6Tgd9AwNTxcZuDxoEhZSv3vy1Pg9Gd70fKNByf4WLsTvOiXobt3Y/EsMUFrxwo5mV0yAgzdnpMMu4t7AEFviul94WRWN7jE3AmmJU7iD/VWrIQgQDTG/wZhDyISSfkJ66LtvCrjT2d0mdjdoGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB11877.eurprd04.prod.outlook.com (2603:10a6:20b:6fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:28:03 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 16:28:03 +0000
Message-ID: <c1ae91ae-61f3-4a05-b975-2dc8feb41f70@cherry.de>
Date: Wed, 25 Feb 2026 17:27:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] cmd: part: add dupcheck command to detect
 duplicate PARTUUIDs
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, John Toomey <john.toomey@amd.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <ravi@prevas.dk>
References: <20260222070957.2756719-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260222070957.2756719-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB11877:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8bc35c-4f25-4e30-24d6-08de748ad914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: apClqcB42nJh1ZZ6siDvYy3ayWzmB/oJYfcR0Mt4xisMZsBSaZNxvFoQX58I0o4xf7BUXeU4/phauk+s6mJCxHE/J055sYtcnqGBjbSpEEYYlrHsV+Z6PW5dqin7wbWavitpjFQJN16STaKkqP80tsLEDWfCgiiJR+zDa6bCPQD5UkSR8wk8/Lyz4zUtuiIwkzPRipNJpL/HAn0VJ2BdYjRXAX+f52k5W4j6YNxmcnA13qFnGbWTmjl4Q5lpRb26Ev0+ZM19+mLU/Z8NtPUy+BsVUbOOZGdq9fq0LV4nfFWmBTl2YoXV+MFmtKHX/SpdjGAKNF1TOD0yTgFc4Zuor7PrxgM4ESuMdOBaUs+j2wO6y01Kqb0NnYZ646Dw9pIuVqfyKEs/rabzRBgS4NCT3CU1R5ppTYECGW2ZaLcZbX9lMJV5QUrUkDqE7RMTVUf5UBBfJSXIQ8kqHFdrS9inXdYoGbjR8MCxn1WLOXA5vAU24c1AgAei7CAqMzU0qLGStkhknlxc1PWz8TJgQSDEF7SoEhVnXW5iX1x2HJvD7c9DkcOG9TRTw/keKGbRRbtFx7C9ZH28sBdp0y+OPBBXB9vCTwB83rH3CIkSUY+I9EomKeNWDlckKapVpCjuwnoZYf9rJ+4le21VaYUhi+V0E7+RMMpYCLUmC7dcYw3FSuxDARyvkwHNueA3XMw2nq5b3Hpw6cgm6CiC+x9i5QKnGMbWramqm+GXFZDCm67P7eM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVBRR1ZZak04KzZtQ3NQdFlxdEhBQklDUHJnQndHYWJDY0oyekFuTDdJUURS?=
 =?utf-8?B?eXRyUTB1bVpvdjU3b3oyRkxXMnMwV2E5ZVdZNXUra2RUNjd4eUlybjUydDNh?=
 =?utf-8?B?Qm9aOGVJQ3ByQlZnQktmbUFwZzAwSHlERVRLT0dDNGpTSExaYnpORXJHM3dj?=
 =?utf-8?B?NTA1c0NFTnVQeXkvLytSQy9FMEtYdHlUNkhjWHRCWUFxNlh2cll5YzY0aVNj?=
 =?utf-8?B?ckErUm9uZk9pM01OVmk4RUJ2dTljbEJKZkIyNWMwbEFKU0RlTi9LNzVOVmlX?=
 =?utf-8?B?Wjkwb2xpMnVQb09RdVBQZmhTNnpJSW1MZTFDVDJhbGd2VVJwL2E0VlVQRzFQ?=
 =?utf-8?B?akdtZFRva0thZXgxVUNSN3ExLzVCRkdvV216dkh5cEJ3UjFOWTdjNVFZSExu?=
 =?utf-8?B?a2REc0ZXR2RCMHNjZ2lNTytIRWR0UFNvM0RqcHNYM3BJR1I2OHJ0bVlrMFJM?=
 =?utf-8?B?V2VCa2ZUNTR3T21LUHFLRlVjT1prZm90RzZ2bTBrdkVjK0RPT2hXdHcrSUhC?=
 =?utf-8?B?TlJVdzROM1FFazJ2c293SGp1R0xaYktBcmwxeDhNcXdqYUdGdGpMdU8vOXpy?=
 =?utf-8?B?Z0RsdUczQXVGZVFhRlRTTmhucjU2VEdMdVN3aC95QUZ2OXlBZDg4UWVRTHlK?=
 =?utf-8?B?cUFJWk94NmF2eU91bU90QnBmYkQ0VW9mdUh0WXZNT3MwZm1LMDR5S1Q0dTE3?=
 =?utf-8?B?cnlSdXE4UlZDcWQwRVg4OWdSZkRqSHE0cGFVRS9rL3ZnTFFGQnZHRnRJZXlP?=
 =?utf-8?B?TDRSYlUxQUNSenpsMlNmcE96SmVBQ2tESXhnMGwyUWpaZVV4NnFYbGFPTHc5?=
 =?utf-8?B?V1BqZmFpNUE0MlUzY3k1akNDTDFvMzFFaUJxTkVYYWtkRTU1eVNvTU82Z1VX?=
 =?utf-8?B?OTdjcHB5by9yQzdnR2FpTjQ3b0xQZnFoUklOd1ltNXJjYkw2WDZ4WnE1UXBF?=
 =?utf-8?B?eCsxc1ltQ0haVkMwUjlUZmtDdG5VM0NidWpTNThZUmw0eDJOdzdJQWFLeGps?=
 =?utf-8?B?N3RRbHpkT2p5M1hETzhDV3NhaWdhdTJjbUtvZmtZVG5OeVZiczduQXgzUXZi?=
 =?utf-8?B?Mm9Cd29hLytaVUhWQ1ZpOEVkTXZmOHkzUGFBVjI1MkQ3Wk5uSXREMm1LNmxy?=
 =?utf-8?B?bnZOcUZRc3IxNzJQMWtRbVgvRWQ2bnBpY3RYeTVvdHhPVXkwMStLY0ZUWDNx?=
 =?utf-8?B?eEtxd3pUL2gyN0lyaUNCTTgwVy9pL1hjZjBXMWRkQTJZTXB0b2tQdGNhcFkz?=
 =?utf-8?B?VzA2WXRIUUs0cnoydEFIV0d4VnliR2VBUFVGYmU1bWpOWjZ2U3YvR216UmtM?=
 =?utf-8?B?dkRZZjBCdFN6UWVWK1dadThHTmZDOXdLc1BRek05TkFXM2ZJTlpXZGZQMStW?=
 =?utf-8?B?Si8zYm00WDd5NFlTYlpOd0lkMnBsU1BSWlVva0RpblBQY2x5d05vejFLTFZI?=
 =?utf-8?B?d0VlaEptdXNkSDl2U3VuL05VK3J0eEhnenlYejZQR25OTTdYTGg2eWVzTUM3?=
 =?utf-8?B?b3VSRjlGMnBrdzlWblBCL1pzaG5Od3FPK2IvMG1NL1l6REtDdUI2K0thYnlr?=
 =?utf-8?B?TnlLMXRuMHhhbFVyYkx1cHMrU1Z3NnN0aHdtQk1GNm1DVkc5QmNic2RYZm5G?=
 =?utf-8?B?L0g4cnhXTE93cjN6M0xuVXFPRjVFclNsNnFxNTZENG1Yd21zbTBTVWh0SmRa?=
 =?utf-8?B?WFNzQmN2L3J5S1Mzbm55VC85ay9McHVieFR6S3BhRWVZMWFSNHBFamhaRGN3?=
 =?utf-8?B?RnZRdUFuUEFlYXdyVG83ZGR0dU13RklCaGkxSjhDMndiejd5dTBFTCtYYTY2?=
 =?utf-8?B?NWp5S1VEYkVtN3paNm84emJuTEd2d1F5bDRnNUdqNDFuNkxQZWtTQStiVGFM?=
 =?utf-8?B?Ymhoa0szUE4wK0QxeEhmMm14SjVocW9GcHZqOVlSb1U0TlhTcktuSlB3cWlZ?=
 =?utf-8?B?R2dtdll1RWpwN0pOejVoeEtNL25vWDJzbGxCUWdKaHMvYUg3RS9CNS81WlZF?=
 =?utf-8?B?R2hhODB0TkNQbzV5WE5LYWprVTVrQ2NPMGJjdGRCY3gzMGVmMkZWNnV5L0N5?=
 =?utf-8?B?SWNacmIzSVdzU2NUalBSblRRU3pNMU5sSFVaWmlMcVI5ckMvK25KRXRuV0lN?=
 =?utf-8?B?ZGNQOWVUMU5ZYVFFbHkwdmRFMUIvK1FFeUV4aUh4SEVkdnVlQjY4V0VLQnRu?=
 =?utf-8?B?anlUaFpFVmVXTURPZ1MrbGluR3ZPajJwdlROQjhmRkF0MWp1SWczNEJmM3lZ?=
 =?utf-8?B?aElyL3cyMnFiZUpKaXJ5RU96Z3pNU2xFbSs4KzUxbk5lakJZbU10c1VLTWlm?=
 =?utf-8?B?bTZraVF1UW4vVmtzWXRFa0x2aktKUldYckpSajgvZGoxYTE1bWVkUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8bc35c-4f25-4e30-24d6-08de748ad914
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:28:03.0562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af3/rQfr5Yp++pL6y3aFomZ4jsSluQpql4DGCSqDY2eD3gOZexwaDY+RMVHLinJHz0nLHiJ0PQrryASIw3KSM5AneJ0BLNjvfo6W/LZUfLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11877
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

Hi Padmarao,

On 2/22/26 8:07 AM, Padmarao Begari wrote:
> Add a 'part dupcheck' subcommand that scans all block devices for
> duplicate partition UUIDs. This helps detect situations where the
> same disk image has been flashed to multiple boot devices (e.g.,
> USB stick and UFS), which can lead to unpredictable boot behavior
> when using PARTUUID-based root filesystem specifications. It
> iterates all block devices using blk_foreach_probe() and checks
> partition UUIDs via part_get_info().
> 
> When duplicates are found, a warning is printed for each occurrence:
> 
> Warning: duplicate PARTUUID 20c5fba5-0171-457f-b9cd-f5129cd07228
>    first seen on usb_mass_storage.lun0:3
>    also on ufs_scsi.id0lun0:3
> 
> Add Kconfig option `CMD_PART_DUPCHECK` and update the `part` help
> text accordingly.
> 
> Signed-off-by: John Toomey <john.toomey@amd.com>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
> Changes in v2:
> -Add own kconfig symbol for dupcheck subcommand and guard it.
> ---
>   cmd/Kconfig |   7 ++++
>   cmd/part.c  | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 322ebe600c5..73d27fe2e28 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1663,6 +1663,13 @@ config CMD_PART
>   	  Read and display information about the partition table on
>   	  various media.
>   
> +config CMD_PART_DUPCHECK
> +	bool "part dupcheck"
> +	depends on CMD_PART
> +	help
> +	  Enable the 'part dupcheck' sub-command under 'part' to scan the
> +	  current partition table and report any duplicate partition UUIDs.
> +
>   config CMD_PCI
>   	bool "pci - Access PCI devices"
>   	help
> diff --git a/cmd/part.c b/cmd/part.c
> index 975a0a08a99..c4df5053936 100644
> --- a/cmd/part.c
> +++ b/cmd/part.c
> @@ -15,9 +15,12 @@
>    * Pavel Bartusek <pba@sysgo.com>
>    */
>   
> +#include <blk.h>
>   #include <config.h>
>   #include <command.h>
> +#include <dm.h>
>   #include <env.h>
> +#include <malloc.h>

Can you check the size impact of adding those three include files if we 
aren't enabling CMD_PART_DUPCHECK? I'm wondering if we shouldn't guard 
those includes with the Kconfig symbol as well?

>   #include <part.h>
>   #include <stdio.h>
>   #include <vsprintf.h>
> @@ -246,6 +249,97 @@ static int do_part_type(int argc, char *const argv[])
>   }
>   #endif
>   
> +#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
> +struct part_seen {
> +	char uuid[UUID_STR_LEN + 1];
> +	struct udevice *dev;
> +	int part;
> +};
> +
> +static int do_part_dupcheck(int argc, char *const argv[])
> +{
> +	struct part_seen *seen;
> +	int count = 0;
> +	int duplicates = 0;
> +	int max_entries;
> +	int dev_count;
> +	struct udevice *dev;
> +
> +	if (argc)
> +		return CMD_RET_USAGE;
> +
> +	dev_count = blk_count_devices(BLKF_BOTH);
> +	if (!dev_count) {
> +		printf("No block devices found\n");
> +		return CMD_RET_SUCCESS;
> +	}
> +
> +	max_entries = dev_count * MAX_SEARCH_PARTITIONS;
> +	seen = calloc(max_entries, sizeof(*seen));

This is 4+KiB (MAX_SEARCH_PARTITIONS is 128 and uuid length is 37 chars 
(1+B each)) **per block device**, can't help wonder if we cannot do 
better than this. It feels wrong but I couldn't come up with something 
much better than this (we could have two blk_foreach_probe loops and 
simply print duplicates when they are encountered instead of storing 
them in an array; you can start the nested blk_foreach_probe starting 
from the current device since we'll have checked any blkdev before the 
blkdev in the main loop). More CPU intensive, less memory usage I guess. 
Possibly easier to read?

We have alist also, maybe that's something that could be useful here.

> +	if (!seen) {
> +		printf("Unable to allocate dupcheck table (%d entries)\n",
> +		       max_entries);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	blk_foreach_probe(BLKF_BOTH, dev) {
> +		struct blk_desc *desc = dev_get_uclass_plat(dev);
> +
> +		for (int part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
> +			struct disk_partition info;
> +			int first_match = -1;
> +
> +			if (part_get_info(desc, part, &info))
> +				continue;
> +			if (!info.uuid[0])
> +				continue;
> +
> +			for (int i = 0; i < count; i++) {
> +				if (strcmp(seen[i].uuid, info.uuid))
> +					continue;
> +				if (first_match == -1) {
> +					printf("Warning: duplicate PARTUUID %s\n",
> +					       info.uuid);
> +					printf("  first seen on %s:%d\n",
> +					       seen[i].dev->name,
> +					       seen[i].part);
> +					printf("  also on %s:%d\n",
> +					       dev->name, part);
> +					duplicates++;
> +					first_match = i;
> +				} else {
> +					printf("  also on %s:%d\n",
> +					       seen[i].dev->name,
> +					       seen[i].part);
> +				}
> +			}
> +
> +			if (count >= max_entries) {
> +				printf("Error: dupcheck capacity %d entries\n",
> +				       max_entries);
> +				printf("       exceeded\n");
> +				free(seen);
> +				return CMD_RET_FAILURE;
> +			}
> +
> +			strlcpy(seen[count].uuid, info.uuid,
> +				sizeof(seen[0].uuid));
> +			seen[count].dev = dev;
> +			seen[count].part = part;
> +			count++;
> +		}
> +	}
> +
> +	if (duplicates)
> +		printf("Found %d duplicate(s) among %d partitions checked\n",
> +		       duplicates, count);
> +
> +	free(seen);
> +
> +	return duplicates ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
> +}
> +#endif
> +
>   static int do_part_types(int argc, char * const argv[])
>   {
>   	struct part_driver *drv = ll_entry_start(struct part_driver,
> @@ -291,6 +385,10 @@ static int do_part(struct cmd_tbl *cmdtp, int flag, int argc,
>   #ifdef CONFIG_PARTITION_TYPE_GUID
>   	else if (!strcmp(argv[1], "type"))
>   		return do_part_type(argc - 2, argv + 2);
> +#endif
> +#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
> +	else if (!strcmp(argv[1], "dupcheck"))
> +		return do_part_dupcheck(argc - 2, argv + 2);
>   #endif
>   	return CMD_RET_USAGE;
>   }
> @@ -328,5 +426,9 @@ U_BOOT_CMD(
>   	"part set <interface> <dev> type\n"
>   	"    - set partition type for a device\n"
>   	"part types\n"
> -	"    - list supported partition table types"
> +	"    - list supported partition table types\n"

Avoid using a newline when CMD_PART_DUPCHECK is not enabled by doing 
(not tested):

#if CONFIG_IS_ENABLED(CMD_PART_DUPCHECK)
     "\n"
     "part dupcheck\n"

Otherwise, I agree with Köry about supporting PARTLABEL too, FWIW we use 
PARTLABEL for our rootfs images and we've hit the issue of having the 
"same" rootfs flashed on both eMMC and SD card and not reliably booting 
the same image every time.

This is also definitely missing appropriate documentation in 
doc/usage/cmd/part.rst.

Cheers,
Quentin
