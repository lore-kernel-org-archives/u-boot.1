Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCD8CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA4D847C8;
	Thu, 25 Jun 2026 16:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="haEGjLLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5B884894; Thu, 25 Jun 2026 16:34:57 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C6884704
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhfxPkA60W3PYkRUuLwCfThR7JoO8IT5i79QbzDvDtkvrcua0OfGG67jB2CKj9rIm/a5cJDi2cFfJGYjErLtTI3mllpaWymgap/uAWd9p85WjrF4fasbpfWas3+dLAnZlqcdPPDtW1bWB81CII/t6r3QyjGfdwnr99ZCHJLIF0JEX8N2OxLSlw8GqvEB24/2GVQACatR84b45YPCxEYp87mu3erVV7qN8GPw6T0OdQj70pz9HtYnH04Jvqeod4yTSEhrul2pAaT2vEE2DMHBHqLGmLxPzgJkMdZJZ9hix65F2CayZP5QnSSsEWmEVbLS6XQqLJelSVFwKH8ove8Rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bq+TPt7qRJGgLx1//x14apmiWVrTC+25HRf+kqBcZE=;
 b=N8zrExCjEu1zhE/jP/lbi0p43tl2Bg9d8Bb9f26XSRDF+/bVX0DiUC81qlYdjJ6XmzqJqS2aGllMLwq2Ig7fD8hqEbZkyqHbwyFfzuj6SPGGwuG8MdPEMc/SSBNDdXJzWeb59BLDRzkDnSpIB99CjMMLfc7lzddu07gKVfvK7EK3HluO0N4LDYst4ZvbTwDqDT2D3mxHKAf2B9Y+TQibUzUQVMhORfnT2Kc1ChavbMUqdtOVCAW/vPlETyqNQay0Sm3Bhff+yjhth0ajsgIoN9jTYURAqNunhp6pNeDSyAImbNl7VNy/P9MAGNm+DZnCgR4xvF9OkInUBoxLmamB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bq+TPt7qRJGgLx1//x14apmiWVrTC+25HRf+kqBcZE=;
 b=haEGjLLOgp3aMp0UPD7e5RxArIROPiQTipArE+HVBOTV7+vQtAj2862xSQf/uR+E8lfW4k75Ok52TjpzTk8/MmtAIbSQX+pP8KDsmPDVEK5T6dJnpb11i9zVT+PifKct6zmNInOEfDhdKMagAJk7eJmgFJwhsMWHEwEuVxT6YN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 14:34:51 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:34:51 +0000
Message-ID: <cff24101-e314-489e-abdb-782994fb401f@cherry.de>
Date: Thu, 25 Jun 2026 16:34:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cmd: mmc: fix help and parameter verification with
 MMC_SPEED_MODE_SET not set
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Aswath Govindraju <a-govindraju@ti.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de
References: <20260601101319.475824-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260601101319.475824-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1PEPF00005B9E.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::629) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c239193-7683-4e1a-90f7-08ded2c6ea41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|18092099006|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: jykbUNboUAWeFHtgy2gRNLReUqOWF7g8D5qA8OynP2O8irvPnd0HnNHMEWlrg1baudfcsMf2UFX1QxBkE4dxcwm9ppi1dKHX8hqnvpb3NAkMNFNDAxVYXRE01P9qOynGzcx+FcyNRbxHylUATPXpxklxb/dsGjfz1PrSQAvXTcm1f/rjkwPJPwfelePUHrcSMfroqH91cyMZh38BNSrqAi5w494qaXM7DMspsIiza4GuV1Uowc2PIPiTrdmTaLL9etOPkwICHYYkHiZnbwLF6BF4b/JFt2bcjqQCRmZ/XVgTQXKXsALJrGXbrBsZqnD5QWESpba213SdN3prMzIfusRW7VcIHaet4l/027N+aLxHTtDsWZgs20BAX7nLk19SwHgjAbMmyXFc5f7dhBelSYJPlpb0r14imLzn0BMiAiCITVr4hE0RrK/psvsXVD07E3G9+juE2QnKjkkPO0/pPjZLwrXgyjzpSFCcA/1jyeKSRPEdEC4Uq45ZU8AWTPque3AfgFnUNTlXUo/dERXcp/Lh2Rea4OY4v8VSNps3OxDd14vXOhLJRmXTjAsecIL0//BHGsAYsqaaJOH2k5JrZWu8oVRifHGw/DAAG/rTHFduBjBkuB/DqwC/Xc0fDrJX/mTx/qAFo80sytGILgh6K4kXxlJ7zi6gPaqDuk413qk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(18092099006)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEFmMnBQaXg4WWFaVEcvMGZIY3poNEZtN1kyUWs4bGlCeGttcTV3VEFZbkc0?=
 =?utf-8?B?QUozZ1hmQ0J0cnlPS0Q3TUZzNlRCT0VtVVUwZmwyM0ErRzFCVUlJQnEyb3Qx?=
 =?utf-8?B?QmpmS2U2Mk9ValE4bnF0bk0xcnZMbFg5YW41TFdtaGJ5aFlYdGMzREc1ekdD?=
 =?utf-8?B?QnVXeUEyYWxkOXRvOFNUQTFvVnE1TWdQZlZsYnhpQ1lUbkE5OWo1VThyeG5u?=
 =?utf-8?B?emdUZlY3RFJGZGpNYUdvUTdZd3JKTC9Hd2hFL3l6KytZNWhmdkRvNVN2Y2Vp?=
 =?utf-8?B?MjFHWlZlWG1hUnVhSFJLeDl2anhBOVFOVlRDY3NwOVROaG5iSExDTGRrQzNK?=
 =?utf-8?B?alJEdmNDOU9naWpLZDJiRjNjWVlhcGdHQjVCN2hnd3NNNVc2aFlSWmFCOXR0?=
 =?utf-8?B?ME5LSkdxUmdUNlpHU056am41ZkRZQUNHUzVaUVpBTFQyUjlYeGpoTllWNHJ6?=
 =?utf-8?B?bklueDFua1ZpUldJWjVFelppR09YVnhIRnBmaFcyd3Zpc0s4a2VlZ3pOdVRx?=
 =?utf-8?B?aTdKMnc2ZHVJWEkxbW5zKzluRklFL1FzcE9RTEdVaEJPQlppa3lEWTNJTncy?=
 =?utf-8?B?T25KRm5tdlYvRzc3UXRtVFRjSWU5VTVBemJpVnFjSGNqTmJnUWd4RHlJSVFR?=
 =?utf-8?B?eE9xcFJqNFhPenhaME9PUWVBRFhBUDBvTDk1VzdQMHZMcTBSa0IzNk8yVFNs?=
 =?utf-8?B?MS9JeGNJVmhUVCs0MFI5N0d0QmhpMWJVWDAxV3YxdlBzNDRvak1aNkZxbkxy?=
 =?utf-8?B?QjE3TXBIcko4U2czQkYvWDhvdy80Mm90bHMvcERmYk02UmN6MEwrejZHd2F0?=
 =?utf-8?B?Y3drak56ekdFZktoOStEMjJySGdTcWlLV0NHTTZVMDVzUlpFTXU5aDFBUkMy?=
 =?utf-8?B?aWhqZXBHajdhYjZTRFlNb1ZMNmE5S2lKQ0svSFpYN3k0emRzS2ZOTldyWW9n?=
 =?utf-8?B?VzNBWW5SRjlmbHljRDhKRGxGNExuUENpTHlyVlNURlJyaXp3aFgySFAyUTB6?=
 =?utf-8?B?cXR6ZFBvMXQ4OG9MVm5LTy9ET0EwaXg1NUVGd2Q5emJNVnN0RkJXd1huVGpt?=
 =?utf-8?B?SUttWTMwQWZpRDMwWCtFK0NEWlNuNVFWY2JDNHFOZnZSZFlqTExaN3poeXgz?=
 =?utf-8?B?NXFmWGRaN092MzJqeXF2eGVpdFZlajU4Y2J5aGR6VHk1TTM2c0Y3Q0ZWZzI3?=
 =?utf-8?B?NGxRTWxOWERXN1h1dlNBZGpaOEhXTTdYVjVYQkhMNEdRNEVkVHR3cW95dTlJ?=
 =?utf-8?B?UTBiN2s0WDNXNDJTbFN5V3l4cXZNTXRwampZZEgyOEQ2MncwQVAzbEhxV1Rq?=
 =?utf-8?B?bmpBczI5TVJxN09Gd012RGpFUkk2OG9rOHZUMXNoREVUNFVnc21lUGRZRDVm?=
 =?utf-8?B?Nk9FUjNrSkxzWVdwZFFIcXdGV2syWWNXRlI3VnJYOFJYdkg0aG8xbW5Qd0Jk?=
 =?utf-8?B?ekRyKzJSM2crQitUNlNqeU5GYzUrNnYwQ0xzQThIY3dWYzR4TTlpTmFpZEZG?=
 =?utf-8?B?czgrTEpvZmtuWGxnT3B5RWJXZVBUNlQ5bU1YU2U0bmNSV1p6TGpOT1UzMm5Q?=
 =?utf-8?B?NW5qeTV4VTBaOVlGWnduUktxT0RWZkhBQlF0UDhNRUxLZktLT1pRenBhbG9U?=
 =?utf-8?B?bUhBajRZQlJYb05UOFNzUkM2clNxSVZrTGpHRHJFMjBHdEJOZWtwaGJERTY3?=
 =?utf-8?B?NVZoc2U2bThLUXlnTEVYZnVLVjh3ZW9lVjlVenFXYkFsS29xR2o1Yzk2UXhK?=
 =?utf-8?B?OU9YU2d0WUx5L1Zlb0R0OUtoT0YzVGhNZW5wV0U0UHp5NzdCRyt4MmFOajRU?=
 =?utf-8?B?WnNCS2pRMXhqaE5RM0Z0QWIvejQ3a2w2RFNOTEJOKzdPYllLN3lERnA3ZVla?=
 =?utf-8?B?RkRhaFpLeUtmM0NaVWh2Wlg3Q2JKdlRUM1JoakRGRzVJUTA2N0pVdXJyRitH?=
 =?utf-8?B?a21EYnppbjRseFZOd1JZQzFEVkdXbFl5aTU0YnlRTWFnSXNuMkVwZ0VScm9C?=
 =?utf-8?B?eENEVGpPUUtCZTVyMXJORENTUEFLWkwrN1JPMHgwVGY2MHA5TEJjWU9pREFD?=
 =?utf-8?B?c1p2bzdBWkowT1ZTUHN4bFVLVlFwL1N0em5YS1M4MWRWZ2pQUTk4c1Q1Yllo?=
 =?utf-8?B?SGlMb1ZTcTF1M1VKNFh0ejZMMUdxYXk4c25FRm9rbjloc2dQb1A3MjZHWUg2?=
 =?utf-8?B?V3g5MXUzTitUWnJyMDI2U1Q5QjJsZk1jQUt3T0RhNlFVL3UxQWVOa24yaVNw?=
 =?utf-8?B?R2xER0lnUXpxMjNQaEFhR2F0enZhVWFyNlQzOTlJOUQ0Mm5OMGE2cm92WnQy?=
 =?utf-8?B?bU1XTVhVVUtWUmNnbkhYcldhazk1UkVnRFFuWWlkZGhRQU8ydVVEZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c239193-7683-4e1a-90f7-08ded2c6ea41
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:34:51.0030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EnNXi5wvktMwlUuPIPDdLr+h5B3cjNbs24FAWOamOtbbI3fISE9yNMp7woP445lOPCvYRrUOBmIgAIRgI7zl744Ilv2JTTa5nKhWPSeY7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583
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

Hi Alexander,

On 6/1/26 12:13 PM, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> Currently help and parameter scanning does not check whether the feature
> is enabled or not. This leads to wrong expectations based on help output
> and no clear sign why the mmc dev and mmc rescan do not enforce the
> supplied mode.
> 
> Fixes: 19f7a34a4642 ("mmc: Add support for enumerating MMC card in a given mode using mmc command")
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>   cmd/mmc.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 81b1ca4ad84..54c799891e1 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -519,7 +519,7 @@ static int do_mmc_rescan(struct cmd_tbl *cmdtp, int flag,
>   
>   	if (argc == 1) {
>   		mmc = init_mmc_device(curr_device, true);
> -	} else if (argc == 2) {
> +	} else if ((argc == 2) && (CONFIG_IS_ENABLED(MMC_SPEED_MODE_SET))) {
>   		enum bus_mode speed_mode;
>   
>   		speed_mode = (int)dectoul(argv[1], NULL);
> @@ -564,11 +564,13 @@ static int do_mmc_dev(struct cmd_tbl *cmdtp, int flag,
>   
>   	switch (argc) {
>   	case 4:
> -		speed_mode = (int)dectoul(argv[3], &endp);
> -		if (*endp) {
> -			printf("Invalid speed mode index '%s', did you specify a mode name?\n",
> -			       argv[3]);
> -			return CMD_RET_USAGE;
> +		if (CONFIG_IS_ENABLED(MMC_SPEED_MODE_SET)) {
> +			speed_mode = (int)dectoul(argv[3], &endp);
> +			if (*endp) {
> +				printf("Invalid speed mode index '%s', did you specify a mode name?\n",
> +				       argv[3]);
> +				return CMD_RET_USAGE;
> +			}

This results in a different behavior for
mmc rescan mode
and
mmc dev dev part mode mode
when MMC_SPEED_MODE_SET is disabled as the former will fail and return 
usage, while the latter will silently ignore it. We need consistency I 
believe. Which one to pick, I don't know.

>   		}
>   
>   		fallthrough;
> @@ -1312,12 +1314,17 @@ U_BOOT_CMD(
>   #endif
>   	"mmc erase blk# cnt\n"
>   	"mmc erase partname\n"
> +#if CONFIG_IS_ENABLED(MMC_SPEED_MODE_SET)
>   	"mmc rescan [mode]\n"
> -	"mmc part - lists available partition on current mmc device\n"
>   	"mmc dev [dev] [part] [mode] - show or set current mmc device [partition] and set mode\n"
>   	"  - the required speed mode is passed as the index from the following list\n"
>   	"    [MMC_LEGACY, MMC_HS, SD_HS, MMC_HS_52, MMC_DDR_52, UHS_SDR12, UHS_SDR25,\n"
>   	"    UHS_SDR50, UHS_DDR50, UHS_SDR104, MMC_HS_200, MMC_HS_400, MMC_HS_400_ES]\n"
> +#else
> +	"mmc rescan\n"
> +	"mmc dev [dev] [part] - show or set current mmc device [partition]\n"
> +#endif
> +	"mmc part - lists available partition on current mmc device\n"
>   	"mmc list - lists available devices\n"
>   	"mmc wp [PART] - power on write protect boot partitions\n"
>   	"  arguments:\n"

Just so no one else has to check: the docs already mention this 
limitation so they don't need an update.

Cheers,
Quentin
