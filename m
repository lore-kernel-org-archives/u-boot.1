Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A2CCCFA1E
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 05:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D6883AB4;
	Tue, 11 Nov 2025 06:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RCadsXI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8503483AD1; Tue, 11 Nov 2025 06:26:03 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44E5383A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:25:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCdlA2L/HbYekUTT7obX6JMBMdtWjHQkjH7Tt62MWPs9mjGS7cEoLpzDrj+zHU8bYi7Wldn3jjBF6etmO59iLc4WLbUrwNf62gBuYh9tqBnTZCLK7fQhdJdCGe5jNTbMRUlslsicLKDvo353XC42B604gwRkna5q0VuhxcZh+D2e9r8mBcQOu0MS4qliAW8vDNsItxdFTQB5kE7OqAFMcXL2A2q0xFZJWl9CCZH+EPHmFrYqO4YFfw43Lpj65Pj23vtJP1p4qATlsHpvokH3U10pnPIFj/WG8Uyg9sRIcEcDFBRaW6C+CYPl1/VkAMrEHsCt2Qwj3MbDCb3x77zL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLxw4izpOMhoEtEWumsJLQm4D3LAljIh6f0K7YrUisw=;
 b=q97vI1ztEBkVtwAc4Jl1S7j36S0ivvhPXeV7PtUIVEcT+c+QVSNvjlnzxT8VMdsYzMo4Ko2IdZ6Vz5Zs1w4tPu6EvddFRGhkTvxLvMDTGlOY2e8eW78Ye/2CD4szvTJo9HMruFVq52+eYmWP7symxzUQsfxpLGHW/T3kK3zzMhDFRf42CZnh1aSswmOeyZvDFrx+XiMdHtayzLBq1/9tVsqMm2dg9vfynakOaMKqm/hVkrSayFTBXUeGFNYx0Su0jc+KtxNABAbUvapS3H/VX3opLZYUPupKeOd10LNqOcPwIBqeC3b0kmf/VVKY6NqEddaAqY1bGjkCYFotCj6K1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLxw4izpOMhoEtEWumsJLQm4D3LAljIh6f0K7YrUisw=;
 b=RCadsXI5V6tNaJZ2XitsoiKjB43tNHo1QWTiq4PtTddUU5coJFRBdtKNJrPrZBPs1P5hNfm65O7QYBHTsRcL25kkw4Kexp0vKkmiyh4j6e28s3MleBrre7SjJISNXCt+yM33unDGKA7zLAXaD7QQIwMHL8uK0YvxF3zE1M3xV94=
Received: from BL1PR13CA0427.namprd13.prod.outlook.com (2603:10b6:208:2c3::12)
 by SJ5PPF2BB505D96.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::796) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:25:55 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::2) by BL1PR13CA0427.outlook.office365.com
 (2603:10b6:208:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 05:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 05:25:53 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 23:25:51 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 23:25:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 23:25:51 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB5Pn6F421625;
 Mon, 10 Nov 2025 23:25:50 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 11 Nov 2025 10:55:49 +0530
Message-ID: <DE5M6LMZV9EI.NS7NVSZR63W9@ti.com>
CC: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/2] cmd/part.c: implement "part name" subcommand
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251110205411.4075351-1-ravi@prevas.dk>
 <20251110205411.4075351-3-ravi@prevas.dk>
In-Reply-To: <20251110205411.4075351-3-ravi@prevas.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SJ5PPF2BB505D96:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a9ed18-8027-4c08-ac64-08de20e2c8cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjR4YTByRnZLMWhIa2V0RTBZRzdEZzVYVkk5OVZsL2tWVUNHQW15V05IcXIy?=
 =?utf-8?B?ZHlJcklGVkJmcDhmME5FOTlpbGpRU0MxZFVXVmJBNnZjbkQ3eE1FbDBIdkRp?=
 =?utf-8?B?ZFo2a2tVZk9tRFJMQlRTL1JncWNKbFF6U3dBTHZoR1FYM1FSRHdERHFsd3BQ?=
 =?utf-8?B?RDNrUkM3cWwwOGl6Z21ldnVvd3ZvSXVGQ3Fad0JwTktFVlpaaVA1dWJLYVBx?=
 =?utf-8?B?cFN4ZzdnTWpiWEtleGhaSnMxUmJGNGx3RnhONytaZGIrN2lpamZHaXh2RHB3?=
 =?utf-8?B?L0NxcU42MG1BNCtuSHkzVnhMbVpOR2U0NnFrMHFpL1VzVFJKUktXblAzbkhG?=
 =?utf-8?B?WGRINktFdmVCTS8ySWNzTjFhWVpyczQxY2NkS04vWVkwd29qVzc3NzNBbVpM?=
 =?utf-8?B?VGpPMno5djRKSG40Zzc2UHdaeFRwT3NDTzJpR2h6Y042SHVZQ1p3dlNlR1FK?=
 =?utf-8?B?V0o0N1hSMnpZZ1hsaVQrRWlWbzByUHQxUiszN1dreTdMSm1US0ZsSTBvNjNM?=
 =?utf-8?B?czJNZFJQUWxiTGdERFI0Z3hLcEV1RGdlaEQ5YXhzOGk3UFhVS0k4ZUdIK2Ny?=
 =?utf-8?B?RzAxREpjY3lHaUZOaUsycFNEVXNMWVg2R2h3VFpSTnhod0ZSQmpqMUxtOW56?=
 =?utf-8?B?RitSTFN2WS92SXVlb2E2eDdrSW5aS0VWRXdXdmdXUHRMbTkvay9xNnZwQkJy?=
 =?utf-8?B?Z092UnlHSDVOQ2Z0cHpsQytaVHBoTjRnck9oOEhWWUhPWUJOZDU4ZUE5VUJY?=
 =?utf-8?B?RzRkU0YxcWIyaE1vcnRlSWVkSHpvVFE4UnNSdjBZbmxMQzFVenBwNFdPOHV0?=
 =?utf-8?B?TExodG1TN3cxU0JKbkt0WDMzNEQ2VDFlaUJCc05FMGNQT3lPaVlkUVVXK1lH?=
 =?utf-8?B?UysvZktXMk5ta0xKS2tNQUtzZHZBUHMydCtPbE44N3pFcWtVM1Y2Z2w1RjZX?=
 =?utf-8?B?NTJOWlN6QVB3Tzh3UEY5MXBVbDU4Z084MXJFOG5kVjRFSW0yZEFiWndoOGZM?=
 =?utf-8?B?TnJXVGJsMjVmK2hOcTdNZXpNZnVRNWdSdXZuYWZEOEEwalVwcytvTDZtWU5q?=
 =?utf-8?B?L0J5UXN4QldKYVFDUnU4emliSW8xSzB5K1NwanVjQWF1TFVIdDE5RnpnQnA2?=
 =?utf-8?B?MHBMdzNSK0MrQmVveFJLeGQrL203SStLQzliaklDbG9ZUXpBOS9iRitjOVkz?=
 =?utf-8?B?RE1KU3RDS2RKc2VwcDc3dUw2MnFqNUdRY0dXZHF6OVRWdTVpczZqc0FLMStM?=
 =?utf-8?B?SW1uSkQwOVVPeitUcjBRYnFkM1FCYStqK21TbGc2dHJLL2NtdEZOd3dXakNm?=
 =?utf-8?B?MzdDS0hrcUJxcmo0eDYxc3NCNzZiTVFRMDBZMFFsV1luRk02Q1QraW5tMkR0?=
 =?utf-8?B?cGZtamM2allCdGtnV3owMFdQcC9IVGVLU0J5aGtLQ05OSDk4d2c5Ump4bnlQ?=
 =?utf-8?B?M1BZaWZRNFhpQkxqdUZrbC9BZUh2UmR5NFlaUWxlUXNaYllrWktDMTI2MjZp?=
 =?utf-8?B?NXJOQ2oyYmYvM2xMM3FBQmZBVjZIRGoybnZoM3oxVFd2RVhaNVEzS1E2T0lS?=
 =?utf-8?B?M1o2M0tQNTAvMWIwbkYvbWZyTVIyUDc4ZGRYdmcvaE1NTlM5Z1JoSVpsL1kr?=
 =?utf-8?B?Uk05THZDUWVOODRlVUZsZ0U5aWkrNFhhT0tYS2NXL3VmRXVENEUwVVRhMzBU?=
 =?utf-8?B?U0haSXpqR2V5ZjNqZUpRVWJ3UXdzL0E0ZmhDSzdnTlg2MUJoM082alZsK1hY?=
 =?utf-8?B?WHZhZmtoN2JoOVBLY3BlRjd2YzVyOTBZaUVHYlpWYmd5blpxb1ZoS1kxNFR4?=
 =?utf-8?B?Um1oZ3puTnBhSERzbXVYdFFTSjBnay9OeEFTekYyeVMwaG5wNG9pRGpkOGhU?=
 =?utf-8?B?dm16NFZFYUE0YktWMGU1eEFGbGpWUkZHSDhGT3VkVDlFRitJRHpERXNmQ1U2?=
 =?utf-8?B?a00rUU9zODZGaXNHNFFyUlY3bEk2VVQ1NkJmdmdMaEgwd0hjRUU5RW8zbXdZ?=
 =?utf-8?B?M2hyMy93Z0NGcUx2V3QxcUd0ZWg4NGczdEZHTUNpQ0lpMVFpOUZxZmFFOTEv?=
 =?utf-8?B?T01YZ1lXZVZyRkNQZ0JzbmlKSldxZWRDSEdCeDNIdHcrR2lwTkU0K1FSWFJ0?=
 =?utf-8?Q?EHYQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:25:53.5461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a9ed18-8027-4c08-ac64-08de20e2c8cb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BB505D96
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

On Tue Nov 11, 2025 at 2:24 AM IST, Rasmus Villemoes wrote:
> This is a natural buddy to the existing "part number", allowing one to
> get the partition name for a given partition number.
>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  cmd/part.c             | 16 +++++++++++++++-
>  doc/usage/cmd/part.rst | 13 +++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/cmd/part.c b/cmd/part.c
> index db7bc5819c0..975a0a08a99 100644
> --- a/cmd/part.c
> +++ b/cmd/part.c
> @@ -25,7 +25,8 @@
>  enum cmd_part_info {
>  	CMD_PART_INFO_START =3D 0,
>  	CMD_PART_INFO_SIZE,
> -	CMD_PART_INFO_NUMBER
> +	CMD_PART_INFO_NUMBER,
> +	CMD_PART_INFO_NAME,
>  };
> =20
>  static int do_part_uuid(int argc, char *const argv[])
> @@ -154,6 +155,9 @@ static int do_part_info(int argc, char *const argv[],=
 enum cmd_part_info param)
>  	case CMD_PART_INFO_NUMBER:
>  		snprintf(buf, sizeof(buf), "0x%x", part);
>  		break;
> +	case CMD_PART_INFO_NAME:
> +		snprintf(buf, sizeof(buf), "%s", info.name);
> +		break;
>  	default:
>  		printf("** Unknown cmd_part_info value: %d\n", param);
>  		return 1;
> @@ -182,6 +186,11 @@ static int do_part_number(int argc, char *const argv=
[])
>  	return do_part_info(argc, argv, CMD_PART_INFO_NUMBER);
>  }
> =20
> +static int do_part_name(int argc, char *const argv[])
> +{
> +	return do_part_info(argc, argv, CMD_PART_INFO_NAME);
> +}
> +
>  static int do_part_set(int argc, char *const argv[])
>  {
>  	const char *devname, *partstr, *typestr;
> @@ -273,6 +282,8 @@ static int do_part(struct cmd_tbl *cmdtp, int flag, i=
nt argc,
>  		return do_part_size(argc - 2, argv + 2);
>  	else if (!strcmp(argv[1], "number"))
>  		return do_part_number(argc - 2, argv + 2);
> +	else if (!strcmp(argv[1], "name"))
> +		return do_part_name(argc - 2, argv + 2);
>  	else if (!strcmp(argv[1], "types"))
>  		return do_part_types(argc - 2, argv + 2);
>  	else if (!strcmp(argv[1], "set"))
> @@ -305,6 +316,9 @@ U_BOOT_CMD(
>  	"part number <interface> <dev> <part> <varname>\n"
>  	"    - set environment variable to the partition number using the parti=
tion name\n"
>  	"      part must be specified as partition name\n"
> +	"part name <interface> <dev> <part> <varname>\n"

Nit: Shouldn't this be part name <interface> <dev> <part> [varname]
instead?

> +	"    - set environment variable to the partition name using the partiti=
on number\n"
> +	"      part must be specified as partition number\n"
>  #ifdef CONFIG_PARTITION_TYPE_GUID
>  	"part type <interface> <dev>:<part>\n"
>  	"    - print partition type\n"
> diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
> index 72f5d8b8de7..299f2ac15c5 100644
> --- a/doc/usage/cmd/part.rst
> +++ b/doc/usage/cmd/part.rst
> @@ -16,6 +16,7 @@ Synopsis
>      part start <interface> <dev> <part> <varname>
>      part size <interface> <dev> <part> <varname>
>      part number <interface> <dev> <part> <varname>
> +    part name <interface> <dev> <part> <varname>

Same here.

Regards,
Anshul

>      part set <interface> <dev> <part> <type>
>      part type <interface> <dev>:<part> [varname]
>      part types
> @@ -86,6 +87,18 @@ part must be specified as partition name.
>      varname
>          a variable to store the current partition number value into
> =20
> +The 'part name' command sets an environment variable to the partition na=
me using the partition number,
> +part must be specified as partition number.
> +
> +    interface
> +        interface for accessing the block device (mmc, sata, scsi, usb, =
....)
> +    dev
> +        device number
> +    part
> +        partition number
> +    varname
> +        a variable to store the current partition name into
> +
>  The 'part set' command sets the type of a partition. This is useful when
>  autodetection fails or does not do the correct thing:
> =20

