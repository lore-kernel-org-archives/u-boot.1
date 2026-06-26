Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A817CCDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 11:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B9168404D;
	Fri, 26 Jun 2026 13:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IPqXDwEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B76FA8460E; Fri, 26 Jun 2026 13:32:33 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7D88056B
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 13:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1mnmpNa4F+AFJigc8gm1QgRMhQdQPuDtFtCGIop1UEb1Jifrkt24SdsZ7LUW7NtNvvuoPiHfVvynX+2PsNK50bipHuReqviw/MDWRx36BeDkclfOspMVjKJDGTsU7rzC90isY/LFRUXfIFNuWd5nGNblPz+Eacx6NjSQ8jqnbRsl/4REJoCAGtTVKOHsT15eeKN9gvlVBjQsTrIG1M+PjAxDzlRLFFge5UWwFx425k7OjyiFgVGIKXRj7FYXxf9aQEY9VXnYoDt4bzzb5joudFRICxXsuCEUs1tGvltS/umHpuX67ioCKfcWEvnFpKMtOT1fu0Ir8m+2PCnlCkJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elpuW0S5IrYTLJ+c1RXgncL/W2ACgMVYvCfKh2Z9f/Y=;
 b=Jj7t9oLVHSFkdmJLN3gUfd7l9dH0rsQYLH/Xy8FegdFXmyCmfImULrQQ3JnIv6RnnrHkqvXOAS3gAPVmqbIMCxb0hJaS6iO+PVDr7p6qSiu21h5diH++P9bIEaF7rOg7ZLbotsJnYt6WY1aNRdewluG6uAECUNrnkK2cBS5rUSJpE3CM5jExBc6RN5LfK/mDis9gLyUEPmEG/1jJIk8JJY0+X0wvI+R9TILa07Wa6OWg3KqYZkJ6f1KOZgFFG01aE5JSr3cCfcm9/0WZYlKziHF8pdh+JxhVrwhcqd9XtheHce6BSNchKygwnVseqyAGOv88tBJYcKuTN2R9puJz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elpuW0S5IrYTLJ+c1RXgncL/W2ACgMVYvCfKh2Z9f/Y=;
 b=IPqXDwEp02oG4Vdg+0Um383tqo1tKeBsda/JXFuL7PLpHWd3guablV0YmsVTBVgiuMJWtGeQ7Uh6fryOHcbSkif3uee3U9ipn7oRzQXnOVa9g2DkxLmkYzdsdHucauKUWkUq4Spbo1qJh0zRajkbfrkHWvNUlgkd+nW4I/Y0sM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB10756.eurprd04.prod.outlook.com (2603:10a6:150:226::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 11:32:26 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 11:32:26 +0000
Message-ID: <20719d8c-75ed-4c03-a542-5537e8e9be84@cherry.de>
Date: Fri, 26 Jun 2026 13:32:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rockchip: binman: Add support for Falcon mode FIT
 images with ATF+Linux
To: Alexey Charkov <alchark@flipper.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260609-atf-falcon-v1-0-2b20c5e83615@flipper.net>
 <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260609-atf-falcon-v1-4-2b20c5e83615@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::12) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB10756:EE_
X-MS-Office365-Filtering-Correlation-Id: 5484e1d1-aa4a-46ef-13bd-08ded376996c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: s3a8NG33k53oI6Mj5GaTpODUdFEMcsl9wrgFNzIeSGnHUGAoI4xQNOrZTZiAqubhN9nU+DHBLSCS8PrcLo3xzjr4ca6LPNg14rapFn+DzAL+Rgk9nsguQa1w5OfBKlbwcRP0mFwjR7CwGltwSs0M3sxYyc0MtqCw9b/+xLLBYP2YeDzFcn563KoPJSzGNHFJRrLE5Z9AdMpv+n8CISnAbViAHdAfFnDMjS4lvTqMTNyLf+Qz+sMAIlo1SHVtuY5kBRwLTu9MOkSssWt+M/u3QfnCymecw86Z9znMh1g2iNC0ZMzLNJ69emv2JYNXPwDPyOLGS/j6dVWzqt03Sb8gFG32I3P5f5vBalAo6gTGaVXaHvHkvC1BdENGTKUAm5fpIUZf9HVEeJwI2Q5Ld4LH+Lgfopqh2z7tQCijOSjhD5cjI7KTY7TvU9nTijKt+pgyIf99BvQA+pcboKbSbXn5P95C0QjyXAHjX/5sMbgCUNy/hEM6r7dBZjZPaaU6pPtMw0Cf0L11r8gVRZoKE/+ygzflbU3riJKFN2pIEDqq2taNXnB3t5ARGYzzodjfsEI6xK/Vn4rq2UI2RcYQNYWAh1hSBmfGBMOfc2Z6gtvMNAW0ih66dEI04M1x8M7ALFD5EKplF4NKaBSLm424ad/gN1vVFlkVKmSslAcYu4DbVZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUovSlNoSTNOUWhla1dMWmFMZmlvU2N1bi8yRzlITDhBbGdLQXc1R1ZlQnAx?=
 =?utf-8?B?QnRCeE5GQVpBSHppT3huQ1dnYkRyT2dGT0k0Q3AxN0prMWM0SjlxSW5QWFhH?=
 =?utf-8?B?TzBleFprSHFvcnBMWG81eGN0NWhLWURLT0RmMHZ2NFM4K3NlTkoyaDZ6OTg3?=
 =?utf-8?B?cFRLSHp1MFNWWk4vWG44aUhVbjZxVFd2Vlc3TUliL3NjN3NyU1hPUEE4VXhS?=
 =?utf-8?B?dmxFSmY4bVEvaEpUZXh3emZSTTFrVEgrMGM5OEY4QXlwWi9sVWxWaFNCQ2Fy?=
 =?utf-8?B?SkF4anVYaUZkbmdIaVUrT0xYc3RoSjZrRzVLY044cUNOZlJUU3BtNVZBczQ4?=
 =?utf-8?B?TUVJVHRaQjZBSVBET2hhZ0lMMGtHOFZtcGkwYzRqdlF2T3hOdkJaN3N5Rk9C?=
 =?utf-8?B?TlRSeWFLWHpPdytqOXQ5MVAzWXRROUJRc0RGRzN2VWRLVlM3YXMrb1VCUGk5?=
 =?utf-8?B?WWVWWEt0eWt2R3phaFJoa05ELzRHcmJNOHhBMGZjMHM0RXBIRlAxT29MdGpI?=
 =?utf-8?B?YkgwQkx0MXVHSlc2ZXAvY3p4OXhKcHFySWlsZmo4Rk8zRWFlT00rQVhtZ1Ju?=
 =?utf-8?B?Z2ZsZ2FlR0JGQ2hIT3daWTBSOS8rdDh5ckJFRUtOazdoY3hOQ2RDYkM4Q3A0?=
 =?utf-8?B?amdCWUFpNGVUNmM2dkNIamlzbUp4b0phcW5IYjZ2Zml0MndKblZYSzlFenZW?=
 =?utf-8?B?K0UveG1NWjlnL0NlUExVSk1EYU9GVXpnUkNuZXErc0RoL0dyMjhyQjkrY0lz?=
 =?utf-8?B?UUtuZVl4R2djQnpDdXo3ODJFZEl1WDBGMzZOS2tIODh2VzF1cC9hY1FqeE9l?=
 =?utf-8?B?aHNTd1YxSVR5RUJSbVV6azU1MkxSTjFEeW12SEtmd2FCYlNqMGI1SjNIek9G?=
 =?utf-8?B?Ylp1dTZBNWpGTTB6ZktWdDczeGl6alF0Wi9ER3hIQUNZc0E5RitOWEdZVWhp?=
 =?utf-8?B?VmJkQlNaM2IweURiM1JoVlFselVFNHpiUjZlazFXdllNdUk4NVJaTittamhv?=
 =?utf-8?B?SWNTNlVtNjRiVEwyR1kzeXVPdG81NnZOTUJmZTFQTGNPcTV1NHhUOVhldnZN?=
 =?utf-8?B?SXdpU3V1UDFMbCtzdk9Zb1E3REs3QkJMSFJidHp4dGdYRVJ5Vk14YTdweFZr?=
 =?utf-8?B?K1NxMHNWSDhBaFNlZHRzSFdwNEg1bkRDSkt3ODMyejMwbStIV1JnY3VWR3dG?=
 =?utf-8?B?cFQ5THdhVm00UytCT1ZXelBmT0MyQVN5UFhCaUVRYVBzSVlieVZ0d2RKVldv?=
 =?utf-8?B?QlBvRDNmTmlhZFBxdUpObW1YTVJhM1NRdDJKWldjSGZOOWsrSU9CL3p2WUVZ?=
 =?utf-8?B?VG0vampBVWY5empST1pqTlRjQndJNWFTUVkyS0V4TEpVQmJHQjdDcndhd05V?=
 =?utf-8?B?N0dRdUZvNUMwRjFKZU50aG5sTWhXNURhSFhtcEh5MkpvT0VTMXdwcFUrcENs?=
 =?utf-8?B?NmR5MEhtR3ZMbkVZQVUrcXdyd2VNekNqZEh4cDVhT1EyNjYzdnhFTmZ2STlm?=
 =?utf-8?B?ZFlkMUJxb0FRSzc1U0lnWTZQLzFRd0xDTDNKWEFsNGJtUWpGeTh3RmtwVU1I?=
 =?utf-8?B?OE05U1I0U3hsVlU0RlduTVhid1BMczVaaktnUGprQXpBYU9wTExMbnkzR2gw?=
 =?utf-8?B?aEFGMmxlUE5veUk0OVNjU1YzWkFUaSs5UlRjdjQ2ekVMUGViOWxFQk8wU3dD?=
 =?utf-8?B?eUVoVGdhMmg2SGV5eWxOT1Y1VTVGZ29kalBoMnNzM2xDMnFDWVZYYzNTeGZa?=
 =?utf-8?B?dG41N2laekk4NWgyTkFZcjZaWVFJRWJaS3I1YUlLY1hWTWMwQThxR2pnZ2tk?=
 =?utf-8?B?MDJnZ1B6UzI0V2xhQTFBYVpvTm00cnZBR093emhYQVo1TmFoU24wVXRiMFNy?=
 =?utf-8?B?MTNDdUEvTzVQenQ1bmI4RnM2WWs5V04xVGdlTWhXTWNJNmZOVDhCTkwxYmpJ?=
 =?utf-8?B?R001b2EwN0MydzlMc1lZN05Uek5NNGc5c0xXcFZFQnRYRXZKVDBqaFR0MXRm?=
 =?utf-8?B?ei96UkpXZ3lKaVRVc3M2bml4S0Z4ZmNLcnArSnkwclVIdEdHZzBXTmtDZ1lL?=
 =?utf-8?B?NGx1YjBzMUkwVGJYZzFxUG10MEtXTXRSQ2RYWFY0WFNlUEhIZkc3aThiekho?=
 =?utf-8?B?VDBpTHd3K1B1MlljWks3MVc3SEtOTEVsQ0tENW1VSHlEOFErczVwOFNXN2VS?=
 =?utf-8?B?TldwS2RYU3B2aFlyTnRtUVc2alpQR1FzYncvUS9yajdNUVRMOThBMmk2LzJz?=
 =?utf-8?B?TzY0UVNuYjN2NzNSelFpeVNxUUp0b0xzaXVuMjg5cS9DZWFnbkd0c2h1L0xZ?=
 =?utf-8?B?ekRJK1EwZkQ1S1puZVp2ZUNjdEVubVNONldaQzUvOGdtMmk2TTF3dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5484e1d1-aa4a-46ef-13bd-08ded376996c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:32:26.8082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S837KRAosaaNfmu6mjvyvh2al67vTigO18wH6g7xoYT5K7jOncPgg9ra/C+OD9n4LHFZ/0qPfRX/sa1H94GawyZwthWyuq7eQdn+he0RxRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10756
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

Hi Alexey,

On 6/9/26 6:52 PM, Alexey Charkov wrote:
> Modern Rockchip SoCs such as RK3576 require ATF to be running to provide
> firmware services to the OS. To enable booting Linux in Falcon mode on
> such SoCs, add binman support for generation of FIT images containing
> appropriately split ATF raw binaries (as is currently done by binman for
> U-boot proper images), externally preprocessed DTB and a Linux kernel.
> 

This is a bit misleading I believe. This is generating an image for 
falcon booting via USB download mode. The earlier patches support falcon 
boot when booting from standard storage media. We do not need this to do 
falcon boot in general (or maybe I misunderstood).

I'm against this patch, specifically the part modifying 
rockchip-u-boot.dtsi. The only U-Boot part in the whole process is 
concatenating SPL with the new FIT image (which has the FDT optionally 
coming from it else externally), which you can do outside of U-Boot 
yourself. I don't see why U-Boot should accept this patch but maybe I'm 
missing something?

This implementation is also specific to Linux, will we have patches to 
support Zephyr, FreeBSD, etc... in the future? I see this as opening a 
door for things we don't want to have to deal with. How will you deal 
with multiple device trees? With device tree overlays? How will you deal 
with A/B update mechanism with falcon boot?

To be clear, I'm not saying what this allows is a bad idea, I'm saying 
U-Boot is not the right place for this.

Cheers,
Quentin
