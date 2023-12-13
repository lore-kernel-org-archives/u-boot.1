Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2114BC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62EE886EEB;
	Wed, 13 Dec 2023 17:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MSHA2Iwj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659BA869CA; Wed, 13 Dec 2023 17:08:05 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 304FE86F89
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0U5lwkJ54NcTuYSyz/a14F9jF9w+BZrhMK80S3+S8DL6H3JjJewLpQMV9rEmPhRRRBoexsvInIsTHGdcbhyzjyor0u3an2Wnz/3crXt6JzOEmGOeQu8xy1ap5iQXcbVJdGHRO6vUEb+jFjVGsqJbJ7c6L29lSSRQXakjy3W1UsYkodF1Avb9IdwTu0L73FzSOgbPQVivnaUn1ZXssgZEY7/iJPSEo13r4tJkhOo8xFPRFX5CyWaTBfHfM48mGva9RnEgVkiq80oBLyFksjOodNNSZLAKEiueJyHx5y9QjgAVs+omwitFXIeUZGmH3ay0aAttwilY5XLe/qgBQDXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOxqZjlqM2LXI9g6i3H9vdrd7lqdyUgbBEiL/XZrIPg=;
 b=iNIo3l3hbr+DdIR6wHemWb/ro0rT7LUn41pypGdm3AZVU36kqeMJK1oQGLRcN5RqXI3l5N/EAHoS5WuJWLyQFrjkC5WfyduMMB1YBAzKkPPwHbfp21pLseXrQpNrVXHBLJbHn7QqRlHMwDFmBAYBJDFTILkJ35jjWMJF/H7te9qwAfcFoxaxCsIIUJ07zvucOzpFIx0pW3CZBg1CEnrmZn+JUa4fWd2ARCc+6XRlKki8yD8x784ghBSKGeT6PQkeOowFj5Oh1Dgbaw9GlBWHwSAcSX9PUuVc3OFOZgcLiVkhlFBxpC5/9aNDnXr/O1ChRLk4lN2qYEx31Qnasur1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOxqZjlqM2LXI9g6i3H9vdrd7lqdyUgbBEiL/XZrIPg=;
 b=MSHA2Iwj3RpkEDgzvaWwdUhpEZWfethNWFRNNyyLB43zhU1RsJyI4QFcdCxWuCRn6R1grw1hTjqGezt602HmRlSqZVoO4QxxmvjpPrWLZUkQnc5UiJoBukCprhEFcFEwS2f/++msfVfvlntpvKsCBNUv5bt7nX0vbruqWeWKFa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 16:08:00 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:08:00 +0000
Message-ID: <c2e4c147-9dab-4f11-8721-8f6aa52e3af4@amd.com>
Date: Wed, 13 Dec 2023 17:07:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: zynqmp: Fix k24 psu_init_gpl.c clocking
Content-Language: en-US
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: luca.ceresoli@bootlin.com
References: <20231213134007.2818069-1-neal.frager@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231213134007.2818069-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0103.eurprd09.prod.outlook.com
 (2603:10a6:803:78::26) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 62974c52-bd8d-4731-933d-08dbfbf5adab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOvW/4v5KGBVxfChM2i8uioLwzk38eVVk8Pf9Z5E7YUhghvBgDYwtaB1SvNLLpFNT4lGJL7dfrdx8prZzV2eaU0vX70Z/hrYSgtKIMyOPpEGiJ2Ygsb1d017G8vW2GiNmI+GrXUwmXQtG8E7ZnXVVMdShiVpqClnCuD4rLbSCkhCc5Cu0xYvhk8/oAYuhSgtwFZYMvNaQcRhl3w81qW9luwKvC8rg7dm335CP0LmY4dmAMbB8+Ozmqpr6E+cMAgXtH7f+kmyXCEJs6UJy8pacdmVx5TbQw+HofZqR1B4VVo4tEpVZSi0+KMk+bYyeILe1Qv8FNcoaNjGYjVFEwxXHaoU55QfTGz47ef9VXAmpHPnOD6z5h7BhS1N4SGwvtF4zJLdqz9cEQ3NHbHS1Xu9RxvXl6lY1uhDALvfRxTeO2j3H0t73+ZI2rC53hA8QKg1iOs9ykqkALKozZYv/Bu499ircCx9B9OnJc71PKERuBR8sQW1laAJyALzcp20AReisAFwji25BrlWDhx1k9dTi057/BcvBABbjnpjXeX0XYGgOjbDYth343JD7lZ9jQ4HzeV16m2vrswH0UtZzhvTyJ+W4fwA1AFon+6YRnLnc7gu9ftXYuhNx73kPhO1lbKdE1TFZj3pd4kdv7mX4kKExg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(66476007)(66556008)(86362001)(36756003)(66946007)(83380400001)(6506007)(31696002)(53546011)(2616005)(6512007)(8676002)(2906002)(6666004)(316002)(38100700002)(6486002)(478600001)(26005)(44832011)(5660300002)(41300700001)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUF5NDBML0NKanZ6ay9YTHdwVVlTeXpWQ3M0eis5bmkvTE9DVlp2ak1uL3Jn?=
 =?utf-8?B?QVdzSzZJNmJ6S21tenJkVWNhS094S0ZBb3p5TDFMa04xd0UrcStoMmNnTE9H?=
 =?utf-8?B?WkRrZ01LeGprTm9XQkZabnJZL1NuaVpGRG9xRzhKRDNGSldZNVhYT2hMcFlI?=
 =?utf-8?B?ZURmNmpUT3ArWVVTcHNFUnZZZHN6Mmlvcm9vaTJQcExuMUU0ZkdsMzJDUTVC?=
 =?utf-8?B?OHhnQUk0Vk5XSkpjS2VuNHVUTElEamhpeE9hTG5mOTZZUXJzckhObk9WS3Fa?=
 =?utf-8?B?KzNFbkZYM1M5STVKQ1l2YUFDay9sQm05R01NQ2hKdDdaNVVCZ2VscUNwVXpz?=
 =?utf-8?B?bjJUREtFSnFtc09IWTNPRUtDbldYUEU0R2o1THFISVhvWUhDbnY3NmNOdWFI?=
 =?utf-8?B?ak11U1F4RGFTbk96dGFESkMwdXNweVdrYmRhc2JJY1loTmFCSzl3NWNBTUFL?=
 =?utf-8?B?bllzSm8xdWFqdVk3aGczSFVQODVzeFBvd3ViMU9WblBiUWNOaCtWYkVleWlZ?=
 =?utf-8?B?OWpoSnREMGQyckVoMFJrdHYza29WMStVb2dnZngvQUlJU2dvOExlSkRJK3hB?=
 =?utf-8?B?UFdwN1BIVUxyNVIwRHFsaVJubDNtaUtJWkFPS09vZEdRSzEyenZUcC9PeTR0?=
 =?utf-8?B?OWtkMmtNWTJmWHRIa2JOV1dSMExuT0paN1IzRytCNWlUQ1BTamNmWWpTNVIy?=
 =?utf-8?B?ZWxpSkd3TTNUOTFKWnp6VjFjcnlhdmFreUkxL2JmTHNnczNKeXZyRUdycG82?=
 =?utf-8?B?WHZHZzBsdVJMNENjWE9xQ3IxOEdBMld1S1BXT1ZKQ3JqMkNic3FMN3V6QzR6?=
 =?utf-8?B?LzBrQ0M3VkF0a09DdTB3YjdjVkp6Y0RkbjZ6QUxtNEkraXIwWHVvTzJSRjZ2?=
 =?utf-8?B?aXMwaFcybmZyc3lpNUxOTERINGJTbW5CZE9mczJ3aHlzd3Bud2Y5UUdrVzVH?=
 =?utf-8?B?TDhQK3Q2RmVWbUIvTUhHc3N0U1JYM1FQQVBwaWV5TEluNGtIcFdGNVRGemJx?=
 =?utf-8?B?UGxycXF5cjB5MC9aNnhBY2ZLMXJzSG5pZkx6N1dKSGVQUnYxaWRHSmliSllt?=
 =?utf-8?B?Y3JBeStUNm5Xb29lV0pQa2I2aU84anBnSlBEWENoMTNmUUcxUElEd0E3bjZp?=
 =?utf-8?B?QVFvaXFtUi9VUmRMWENESkJ0ZVRtV0hCY3ZxUGowTGhXbUlOVXZaT1IyY2lU?=
 =?utf-8?B?ZHNWSi9kN0pnVG1xNC9wVlhCMzVhUldYRC9Sd3JkWnBIUkdUaEhlNGgzd1lM?=
 =?utf-8?B?SE4yWlhGUEl2WnBUSTBxS2QwM05GbkNtdUg5Qjg4RDNVdiswUmV0Y2x1RkFn?=
 =?utf-8?B?S0djOVlHUGVtVzdSTE1XVmNtbnNiY1RrcjBTRzJBQjNQMVFhelJ6bHR1MFVk?=
 =?utf-8?B?cDgvZlduZ1MyVWdQRHdRRHR4TVF0bm8yaTVvbUpVWCtLWHB0OEtFZm9HSHlS?=
 =?utf-8?B?RjZBeWpiOVhGZ0J0ekFtNDFwL002SitVbHVwRkU0Y1hTbXFQKzNiODlydElG?=
 =?utf-8?B?Z2hjOFcxa1lYa3lVemhZbVgrL2RVZm9YcVZVb0lmaklKZFJ2L3RpZThYbHV6?=
 =?utf-8?B?eWJiQStjMGRFVVNEQXJuclVHTE1keS9vY1FjR3ZFOFRucmlFM1RKazZoUlZz?=
 =?utf-8?B?WGJyK2d4U3M3Q0NBVWZZV1UvV1FEZWx1TmpWRXRrV1NoblBIYTQyQ2pMcVFp?=
 =?utf-8?B?cUM4UnZtVENpaW9wdXBKdnJSeU8yUHd3NXlGaVFZWDZiK25hOGRuSHJsNlZx?=
 =?utf-8?B?NzlsY2lBWC9OUkQ4eU9BTzdqSmNZQk00Sm10a2RoM2FIMk1IMGxCOTYxVHFJ?=
 =?utf-8?B?bHlpNFQ1UkpnZjZYbTZCNDEwazBJeWIzVDNIOVc1OXVQLzQvYXpJN0RPY09n?=
 =?utf-8?B?a00vdkFCQTZGSVBnczdXbmQ4Y1J5QjBrd00vWU8rK0s0L1pLSHNkWm41TjJz?=
 =?utf-8?B?UEZqNUNMS3cwSDBBVi9JU2FpVzZNREFKZUVCMmsyMW0zMHQrYnN2YmRLWXB6?=
 =?utf-8?B?b3dTYk5Yd2ZXNC95a3h5UCs3NWtUaEZzWkU0dmxjZFdXWHFBeCt2a3MxU3dr?=
 =?utf-8?B?MDRIcTFmVnptQzMrLzQ5bHdsVS9MZWF4NkRhdkEwRHI0bUtZdVB0ODJBdER0?=
 =?utf-8?Q?pX44jD93w8q7aAunaKl4XSBkR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62974c52-bd8d-4731-933d-08dbfbf5adab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:08:00.4945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwOegz+IQs9uZ/pI4K8zcyAaQD/3vKVDzfwleQKgdPkCLRZoakMA+4LzQ5J+yjLb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028
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



On 12/13/23 14:40, Neal Frager wrote:
> This patch corrects the k24 som clocking configuration such that the serdes

Corrects the ...

> clocks are correctly enabled and the usb0 is configured to use the psgtr
> refclk2 for usb3 mode.

I sort of have no problem with this patch but it should be better described.
Pretty much serdes configuration should be called from u-boot because we already 
have psgtr driver and usb3.0 can be configured out of it.
But we can't touch dwc3 driver now that's why the only way to do it is to 
configure via psu_init.
But it should be clear from commit message that it is workaround not really 
something what should be here.


> This patch also corrects the configuration of mio pins mio76 and mio77
> which should be configured as gpio pins.

This is definitely fine.

> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>

You mentioned that SPL didn't work before. Is it because of incorrect serdes 
configuration? Because that's sounds weird because you don't need serdes 
initialization for booting out of qspi. That's why looking for which is that bit 
which make SPL work on KD240.

> ---
>   .../zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c  | 266 +++++++++++++-----
>   1 file changed, 200 insertions(+), 66 deletions(-)

This patch is not based on the latest tree.
There is 0a965b10e2413989e351b5a5b49737babdf5b751 in the middle that's why 
please rebase.

Thanks,
Michal

