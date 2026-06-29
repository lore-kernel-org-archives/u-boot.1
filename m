Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE902C43327
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 10:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A190849A3;
	Mon, 29 Jun 2026 12:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lDdqrhd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C67849EF; Mon, 29 Jun 2026 12:53:45 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA4B84994
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 12:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDNd+RziztyuV6RTw5DhDB4kkpMdHu1+Yj7gnORNrWXFYUp46Wk71+85UelGasfd6ijrW62J8xe6hgrtdzVe1y2am33BSepdsgFryxN5fCnZcdKAnsg32aKKZeBEIx0rRlO792tv1Unq6VAUTV8i7C5P3JeIZEgnlrhHUKdi9j/FyxfeoZXKYgDjNRK2Sfawihc0RlsaiEOitZncY2V8QQFWH8S9sU4DQkmnmzMN0quIg5l064AJWtWeB+PalqsEAJAcXsfKJ5iFiIv7D0TjL7CY6fzFx2u4nWqfZy/1DOskRg/pxH3CSSRbJsYPfQ/ZhkY/CYQIa2cUDa0t+D2AUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry3mth5HK1ySYzJmvMqVG1p/REO316h98JecdMVjYuA=;
 b=onWqaj0Alwx7m0oNBE2bEAf6/wTskk6Bzj4PIjLItJJAx9OuriInyS/bENeUBiS5XViEGMpnRTuAnlObKSBLzHdKcCslRJhqJzdUO0dJwUWKyiSneXlnR9EerGKegUaPJv3Za2cwKl3A0NLOR8ysGm5I4Ti4122n9TiCc583yjoXs2REf6fyGmIncvvwrWykewVvoR7PVB0HcjgM7xVrqwL1xQHsEndAeDkqIM/v+eDWoICWn69kGD8EHnK/uxO56SGu8q/rjkQUWzAOfsn7w4dQV1CQ9clfjEpafY5jwmHYAztcc+0XIESz6LkmzagxXpubCq9g6sXO8etz1XREqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry3mth5HK1ySYzJmvMqVG1p/REO316h98JecdMVjYuA=;
 b=lDdqrhd5RW4RLEHkZAix2TarLLE5ZK4FMuEdnkg8fUixp4aixYn1Fut2tGdG05JVc3pcqogv0WhoUwGI6nm9vXnnX2raVxklBIILfPS798lTtnUDq/6FhEfDSD1B2vAOY1VHR53t+7wLSTvcKwz98TyS9+vYxE7cAOU+aOlF0ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Mon, 29 Jun
 2026 10:53:38 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 10:53:38 +0000
Message-ID: <88b37a74-6d98-4a6f-8f77-4ff5c47459c2@amd.com>
Date: Mon, 29 Jun 2026 12:53:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/64] drivers: usb: dwc3: sync code with Linux v6.16
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260629084507.3254232-1-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 6053e9d6-5d87-4a67-d766-08ded5ccac9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|23010399003|366016|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Hxu6r1CM5GEx7y12/jiDcT6SiZBtdugGftm6CAhUL99fq8WCZ2H0zgVNj5pbSGTPE6uxbDOcC3OJBEixaNRBqNkT27zHkeCSz9ZiT/2tPwR2hAyAKr3URalkZKDibH2d3LZg5Y/y7iCrvgo/076UTouq0BfzcCZaFybixXq63K0R9gL/AXv9sBgUo3mGcFm19OAHDxtVaRTdWiYM5jcU43NcjAx7CAwSahKdFrAXKjqAeObYCSZqbbhKylB9xzZZ7TTBxd753WChJi050v30sfq0Jclh/cBY3Ys8WdIapIz6iYxhoxEPaVLZs1r/zQ/Xef2PN7W1Q74Lq8FiEj++peWdgF91Z8DWjUXSFUuzE8Q4SKXoQl254bqcIlfrXsPn4igpmDpRFCZ/ehwuionAOm1/Sj0DEeABD6kiw2tva5s8mjjhlupIjMeoeQ1+uOh8OfCW/wh9U2xBzVADGz8ZXmp4OiLn/6IQl2udnMp/1mABWjIHNYOGJVKuVG/W+j3RaH2nV1mO58QcC1iWn/cbrkY8aefAn+xp9XODoeEI5x4nLoi02J5wnwhykVN+LQ/UM0i/715kig7DkiPrJA3nP5AlKZ77rXGFtZkve/zZC4NE72z1bWAzTUHWMK9WL658
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1MyZVdkMHNSbm92SlZYWHFIcU14OUE3R2pmWmZBaGlPbmN5eCttaDhDWFdE?=
 =?utf-8?B?aHp4aVVXUEJWM1JKSjFxVlZhdDZySmQwV3BvREJ1Y2JOR1VLb1VtU1dic2Fp?=
 =?utf-8?B?SVRiL0YyY3dQSS9odzMyYlVnUnRQbUJhOUNWSE1YVkRHUUVJTGJseW9DekEx?=
 =?utf-8?B?QWJDYng4QmVGZVBadU5Hbk1RVzdubjFPWXZUcnZxS2JMOFNUOWRGTUpxVk5Y?=
 =?utf-8?B?aGcra1FEcFdvQ0EwYTJCSkpkTEVIejlPc3BiSFEvcEdheUtJSjIvNjRGODRD?=
 =?utf-8?B?R0cxYnFFTWIvb0U5SlZuUkFwcGxoYnUwM09BdkJ1UXNHODZLblJ0dzZmdUZj?=
 =?utf-8?B?UmtIQUlRT3piMklodXdrUHpsTFJvZVJVRjVIT0NVc1N1MWgxeEx3d2xnQkt6?=
 =?utf-8?B?RWtHM0dRMVZpNlhkaWZaMCtCU2ZwbVVZY1NYS1MrYnlIY21qVEVaVG1yUjJ2?=
 =?utf-8?B?QU5SUE56blBITmJwZlQ5dXhVVUFwSHY4dldOb053UkEzS3RmQ0FVblY2YjhV?=
 =?utf-8?B?WUlFVkh6WTRLWitYdWpMT2hHeERrcUd1MnA2VHJKM2RrT3hkUkZvaVByT2R2?=
 =?utf-8?B?RHVYekRhNnVlWjIweGkzWE5sQTNmU0kxYXFXZW9JNWxOQzdDSDBqVStTT1M4?=
 =?utf-8?B?REdxaUZGUkJxbTJ3dWVQNFd3RXkzQmNocXZLeS9Ra3RWZ2lYVmxEZ0w4b3Zj?=
 =?utf-8?B?R2ZXQ3Erc2dLSFI3c3h3WjdaWjJORlBneHByQWxWN0hkZXczTlhFWWRXVTdx?=
 =?utf-8?B?WXpzSjJaQ0xCdGYyWmpmalZnbDZXYThkZ0RpZ2ZhSTNJY0IrRStNRWhMSFk5?=
 =?utf-8?B?QnFQV05sQXUyWmJrREloSGFLbEpmK2poWHQwVGN4eHhqYURsWTUvTHhMM2RE?=
 =?utf-8?B?S0RTQ3NneXBHcFZveDFUelVvZ21ZUUtDL3JlZkZrQXZxaTNDY3JMZlNwOXFO?=
 =?utf-8?B?cGdBSHBIRTV1eTk0K2JERysxY3UxdHExVVArZHlQajIwaVU2NjhkdkJRMUE0?=
 =?utf-8?B?WC9RcHhaVEVzZjcwV2JNTm9HL0t6NDJOditnRXpKdFoxUXdrdkU4V3A5SDdC?=
 =?utf-8?B?b244UDJVTEt1R2NkRGpuVUtHUU54Nzlqd2ZqOTQzcHhSakFyVFdHdmpHblZM?=
 =?utf-8?B?dTA2S29mb1dadEY5NkMrblpqSGkxYmpaNy9MYk5rZER2WUlIeTlsNFUrQXBT?=
 =?utf-8?B?ZnBPN1lISXdBSC9IelplVmdYc1MxQjNrSVQxc3RYM3NOTXdBeERxWmVBWjY4?=
 =?utf-8?B?enNDVTNKYnJIMWJRYkpPQ3VuWGhhR1I5QjN2dFB3QjFlZ2tVUzRwN2IvNXNU?=
 =?utf-8?B?aG5uOG04VXBIM0Y2eXljWXJmV3FveWpkd2hPMFdsbDgxeTZad3k3VEh4Nk5v?=
 =?utf-8?B?Y3NaSjRRcG1pR0dRaVJOUTVGZzYrZnpSTENqMmRsVythQU5kbVhZbUF2SDk3?=
 =?utf-8?B?ekJSM09ESjRoU0t4MHZsOUt5eXlPbEx1RnlTT3c4M2xxbHlLRmVrMzhyNnRH?=
 =?utf-8?B?UEU5bWg0U09TeFJYMExlY2NsaklDbXlOVzJKWVJ6V1V6YzFzWHp2UE1KMVhn?=
 =?utf-8?B?Sy9nM1pZbis4RHA4REN0eDd2Qy82M2N4Wk9qTXFZQVk0VHpmeFdKTzAwMjRW?=
 =?utf-8?B?UGs2enhKOWlFTlVQMUpmaFZHMHNzdTVjNmNGS3F1dHkwcGM0WU9oTWxmdThs?=
 =?utf-8?B?enJ2S0QxQTdPVkZxQ2Z3UlZoS2ZLcXdrUUhZdERvQTVzdmtKbVR2dVBhaVk0?=
 =?utf-8?B?RWg5RGRkSEcvSFF4S0hkOGtSeFR6amJOOEoxNUdaaC80RisvN20rTTRjVDE5?=
 =?utf-8?B?M2NMb3F3aEtWUjNJcXd3UUd4ekhrd3R1Vk0yUVNNN2pWWG1GTE8vY0dJdzlF?=
 =?utf-8?B?a3VhbUE3VTVTUzJ0RzVwRUltdnlwM3JTM1A5OEpZTWxHazd0Vk05ejdCMXpn?=
 =?utf-8?B?NE9aOC9iWGF3Vllqa2MzeDhnSE9Zd2N5RzljLyt4Z242TEt4OUVkQXJpMWlu?=
 =?utf-8?B?bGdKTmtpYy83ZEZGSC93NWVqQzNKcEZJNFRnM1Bjc1o2SENDQkFFZlk3c2h5?=
 =?utf-8?B?cEpSRWFJRmFtYTZnOU5EMGl1NU5PbkJlR3IyeEFCNHhxaEtISWdXa0ZQTEs4?=
 =?utf-8?B?djNBRFIrdGJyYW1BUkhTdVoyMURzc3p6UVAzblRVTy9oSHd0dVZNOERHcU1z?=
 =?utf-8?B?ZWZ0UDFNVzNEMmsrazU5dk9LS0lmaDd3alZLeDQ0V3V1SlR4aktMS21EVUdz?=
 =?utf-8?B?elFobEE4SkpmWHQwWllrd2szbjN5RE9jVVZTVlBIRkI2RmNOS2Z6T09nb2ZD?=
 =?utf-8?B?UjkrZlJFcFA3SnFSL2J1V2Z5WWQ3em9zcU1tZEZMSnBVU3gyTEdlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6053e9d6-5d87-4a67-d766-08ded5ccac9c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 10:53:38.0546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Whhn/Chv1xFxICO+HaUgXgRaOd/HCDdHEmXIOSwYfNZMrSNLnqCviAYuglx5jEEu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

Hi Jens,

On 6/29/26 10:43, Jens Wiklander wrote:
> Hi,
> 
> This is a follow up on my last two patchsets [1] [2], where the latter only
> with a small change in addition to posting all the patches.
> 
> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> to u-boot"). Since then, not many kernel changes have been ported back into
> U-Boot.
> 
> This series synchronizes the DWC3 core with Linux v6.16. To provide
> a clear audit trail and maintain bisectability, I have structured the
> series as follows:
> 
> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
>     to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
> 2. Milestone Imports: A sequence of 50+ commits follows, each performing
>     a "snapshot" import of the drivers/usb/dwc3 directory for every major
>     kernel version (v3.19 through v6.16).
> 3. U-Boot Adaptation: The final commits (based on Jerome's original work [3])
>     re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
>     required for U-Boot integration.
> 
> Note that this is compile-tested only. The CI pipeline on source.denx.de
> was used as an OK/NOK indicator [4].
> 
> These patches are also available at [5].
> 
> Thanks,
> Jens
> 
> [1] https://lore.kernel.org/u-boot/20260507092843.358908-1-jens.wiklander@linaro.org/
> [2] https://lore.kernel.org/u-boot/20260624123025.GA3245275@rayden/
> [3] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [4] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30524
> [5] https://github.com/jenswikl/u-boot-1/tree/poc/usb_dwc3_sync_v4
> 
> v3 -> v4:
> - Restored obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62) for dwc3-am62.o
> 
> RFC v2 -> v3:
> - Rebased on v2026.07-rc3
> - Configured out a few prints in drivers/usb/gadget/udc/udc-core.c
>    to make it build for am335x_evm_defconfig
> - Applied provided tags in [1]
> - Published as a branch
> 
> RFC v1 -> RFC v2:
> - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
>    dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
>    from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
> 
> Jens Wiklander (60):
>    usb: dwc3: restore to original v3.19-rc1 kernel import
>    usb: dwc3: import from kernel v3.19
>    usb: dwc3: import from kernel v4.0
>    usb: dwc3: import from kernel v4.1
>    usb: dwc3: import from kernel v4.2
>    usb: dwc3: import from kernel v4.3
>    usb: dwc3: import from kernel v4.4
>    usb: dwc3: import from kernel v4.5
>    usb: dwc3: import from kernel v4.6
>    usb: dwc3: import from kernel v4.7
>    usb: dwc3: import from kernel v4.8
>    usb: dwc3: import from kernel v4.9
>    usb: dwc3: import from kernel v4.10
>    usb: dwc3: import from kernel v4.11
>    usb: dwc3: import from kernel v4.12
>    usb: dwc3: import from kernel v4.13
>    usb: dwc3: import from kernel v4.14
>    usb: dwc3: import from kernel v4.15
>    usb: dwc3: import from kernel v4.16
>    usb: dwc3: import from kernel v4.17
>    usb: dwc3: import from kernel v4.18
>    usb: dwc3: import from kernel v4.19
>    usb: dwc3: import from kernel v4.20
>    usb: dwc3: import from kernel v5.0
>    usb: dwc3: import from kernel v5.1
>    usb: dwc3: import from kernel v5.2
>    usb: dwc3: import from kernel v5.3
>    usb: dwc3: import from kernel v5.4
>    usb: dwc3: import from kernel v5.5
>    usb: dwc3: import from kernel v5.6
>    usb: dwc3: import from kernel v5.7
>    usb: dwc3: import from kernel v5.8
>    usb: dwc3: import from kernel v5.9
>    usb: dwc3: import from kernel v5.10
>    usb: dwc3: import from kernel v5.11
>    usb: dwc3: import from kernel v5.12
>    usb: dwc3: import from kernel v5.13
>    usb: dwc3: import from kernel v5.14
>    usb: dwc3: import from kernel v5.15
>    usb: dwc3: import from kernel v5.16
>    usb: dwc3: import from kernel v5.17
>    usb: dwc3: import from kernel v5.18
>    usb: dwc3: import from kernel v5.19
>    usb: dwc3: import from kernel v6.0
>    usb: dwc3: import from kernel v6.1
>    usb: dwc3: import from kernel v6.2
>    usb: dwc3: import from kernel v6.3
>    usb: dwc3: import from kernel v6.4
>    usb: dwc3: import from kernel v6.5
>    usb: dwc3: import from kernel v6.6
>    usb: dwc3: import from kernel v6.7
>    usb: dwc3: import from kernel v6.8
>    usb: dwc3: import from kernel v6.9
>    usb: dwc3: import from kernel v6.10
>    usb: dwc3: import from kernel v6.11
>    usb: dwc3: import from kernel v6.12
>    usb: dwc3: import from kernel v6.13
>    usb: dwc3: import from kernel v6.14
>    usb: dwc3: import from kernel v6.15
>    usb: dwc3: import from kernel v6.16
> 
> Jerome Forissier (4):
>    usb: host: re-import xhci-ext-caps.h from kernel v6.16
>    usb: gadget: re-import epautoconf.c from kernel v6.16
>    usb: udc: re-import udc-core.c from kernel v6.16
>    usb: fix build after resync of DWC3 with kernel v6.16


4 patches are missing.

b4 am -l 20260629084507.3254232-2-jens.wiklander@linaro.org
...
   ERROR: missing [61/64]!
   ERROR: missing [62/64]!
   ERROR: missing [63/64]!
   ERROR: missing [64/64]!

Thanks,
Michal


