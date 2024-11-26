Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4641FD3B7CA
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 09:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE2C18969C;
	Tue, 26 Nov 2024 10:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UuOXaObA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BF38961E; Tue, 26 Nov 2024 10:34:13 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AAF08966F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 10:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgt5Lgfg3lbUcsPokAljWzc9kmHqIrSMeXZ1ymB6/R/hPIvXaa25gYLVCl1ad7v9Wx9MMCSQOCVjb6DBgXsmGiGVEdci7jGesZfAwVxZykTytzKo1ZegUNd1rMuQFgQEY8sgwQzwu8GS5A1CBI98CvZGTO1uKph5i+4crfBT1cmhmsvcXjJPR87EKFLJ9+EQ/RQTojULUaAMxrnkeJVejBe82x5sOU+6FngNCFd8hwh23eYw62CZG/78iGYrt0rIM5URfFYllZhoBghvbdC1136+RKvM/NnDG2cy6CpPCUOC98ictDV+dbWaQgJOUWPtf68mfag/TDrtIL9aD+4lGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/XBhZsrrdGl0aTS6O2vOh03SoixZJuTKE8SMq68Whk=;
 b=FaTzhdlK9kNbuk2HCyuL/l3tBEPO3sZ72tkBlt60FIQIdybHEPGMY1w4yl2HbGdsGQfytM13B/ZhN/4MA//X7cG+FzdLruPks9h21RJWTQLbtSNVnXA+4q4c8Vw/mPG2XXVOOoukIywv/wYwExjurOuW/PVM1icZEIwZ6/Tzk7EfYG8epzmheM3UNxUi06Gp26C7vTbRd+gV1EvboJxML0+hZtSOXy75gIGArBX1LtDvmFRi9A6zjJkDgEvr/90d3KcrMpCdSpYnFaMj6jrB/Q0399DFgs7nRWGUGtHF70VvBMC/Fq2nm5elo0xHsLJhHkvIZ0BKCfhj9Nwl8MTMRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/XBhZsrrdGl0aTS6O2vOh03SoixZJuTKE8SMq68Whk=;
 b=UuOXaObAiFDGa9B41raO8iN0VgTBQfoM9KfVe7J2IYlJ/1ItdSe3IZlvdoznY6vBmIybeXJC8tXNm9fCv7IZAn0XRg3ZNAdp5yT2aa8ejkTBPqiCSYaya4KuSUIRDJxOvRolhBjDW4H3YgPzpW4KBmxJqU5JfE5Ws7rvIIf06Zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8884.eurprd04.prod.outlook.com (2603:10a6:20b:42f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 09:34:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 09:34:07 +0000
Message-ID: <71d9a5bf-c2f3-429c-a2e6-8dc103f07f44@cherry.de>
Date: Tue, 26 Nov 2024 10:34:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: theobroma-systems: Update TF-A setup steps for
 RK3588 boards
To: Daniel Semkowicz <dse@thaumatec.com>, Klaus Goger
 <klaus.goger@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241126082738.14854-1-dse@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241126082738.14854-1-dse@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b83fd80-91cf-41f4-bed6-08dd0dfd79c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEtiZ1c0K3N3MDVGTHdzRzF3amo0ZlE4b1ZrTTRMeHFrOG03Yy8wenFEazZU?=
 =?utf-8?B?T3hMTmxETnM3UEZCRm9nZmdiOXBkWk9Sb1Vrb3Q3RVQ0b0k0ZWs4Ukt1SFJh?=
 =?utf-8?B?SGpLV0lOanA4OFBrcjhxR2t4RVA5cnV4enRoRlNwSGpoemdZSExidWRjMUdz?=
 =?utf-8?B?L3lSdlMyMmhPRzJidUdvckFOeW1NVi9DWTJISzVBTUEvc210MUVobURMblR5?=
 =?utf-8?B?cVVpU2FidVRHeXhyL0krbjBvcEoyOFpiZ0J2ZC8wNVBKdW44NDEwSGowVm8x?=
 =?utf-8?B?VzZtTnNVUVNYNjMvRDVGamRiZkswOFp4cnUxR1hwd1ZFVGdwbFppdGY0akpy?=
 =?utf-8?B?dE0wNnh3bHU0WUE3Y0xyMFFBYVluNEFHNXJvMzRpQ0p6N2huelJpOFV5RHhY?=
 =?utf-8?B?YVBhbWM0QWloOVJwcVcrY1N1Mm1aVHUyU3dzckRDTi9OUFdveWNPL3lwNi9S?=
 =?utf-8?B?ZjIweUFDMURMeEx3Si9GTy9jU3JVZXdUQnM0c05STm9TUi9ZU1Z2OHF4bGt3?=
 =?utf-8?B?UlB4YmdyOFA2aEhNT2QzbEZreStLYmUxcG1PcmpyZnN5SFd0QnpuL3pMcUsx?=
 =?utf-8?B?OWlWcEllMDZ0M1RhdzB2dWIxODBDOWY5RHBYMUpXVzAwOHZINWl0a1dXZmFT?=
 =?utf-8?B?NU1MUzN5L0VrcTY1NHZWMHVTV0NLcTVrTjNXcGg5dHBHRkJCVjB4R2l6enps?=
 =?utf-8?B?MGNLUDRLb0d5TEM3Rm5LNGEya3pXNUdVUHRyakdsU3BXWDQ5eEo0TnZKRURO?=
 =?utf-8?B?THZ2SEx2TUMzbzZSeisvdldDK2VBd3lRckFCcUhkNmJ0TGxqeklnNTAwQldi?=
 =?utf-8?B?U2tIY2h5cXcraEdDVHl3MC9iWmt1ZW8reUNOaTc1dlZrM3RNclR5Um1JYXJs?=
 =?utf-8?B?Yk5ZUzQzdkZCR1hVeWJZOFhLSE8rVkRBL094TytyemFlMXdmdjlOcGhLM3ZN?=
 =?utf-8?B?MVlYUzJlcTBidXNxVHBCandFTEFOMlpCUUJvSGtoSkJaWm1BV3VGb0lkTnY3?=
 =?utf-8?B?dG1OU1kwa3U0NXQ1L01TSmV2ajB2QWJOcnVaOU1jK3VTM0NaUnA3N05tc04w?=
 =?utf-8?B?RkNPMmI2L2F2ZmREU3l3M3dPQmtBd2xqYnhuQzF1WTByT1A2cUxzV2JSb3NM?=
 =?utf-8?B?MEluNVZSc1BoSmRrNThNMnZ3NVNQVUFOdTFtRjZVRGROUG5yWnZsM2w5TFpK?=
 =?utf-8?B?VTNPWFRobU9TM2hJSFFXeHh0ckVuYy9ZRVBxeXRTNEZOUWUxako1U1JPc3hW?=
 =?utf-8?B?dlprbnZzM21YaE16WEwrUjd0UC8zUjRYU051NzN4Zm90SnBlbUh0SE53bGhk?=
 =?utf-8?B?bzU1eWNlWFpkUmZWZlk3RUNyenN2NEc1MFlNVDhJVUxOZzhzU0VxSElqd2hv?=
 =?utf-8?B?YWh5MlhyL2VGaDlTOHFNTTI2UXFlekhoVW5BZ1ZCMU9zSXltaHB0ODBTYXZi?=
 =?utf-8?B?WFpEWC96a29JUy82WCtGZ1lJTS9CU3ZNRUM2YmRiS2hkRVBlSHZDd1hWUkJR?=
 =?utf-8?B?VitUdWh6bjVKRjEyWWhSRG5xaFlPYXFUVlFKcXVtQzB2QmFCUjZpZnQzRFo1?=
 =?utf-8?B?MXlrOEFvbFMzQVFRc3FaUW9hNzd0bEdKMzN0NEVQVWZXZCtRMGVBMUd4bytW?=
 =?utf-8?B?SmJvbkczR0EwTXc1bktxb1JMdzk3dWlIYnhRWVQvdEgyUm9nWWhjUjZ2bllQ?=
 =?utf-8?B?NlV0ZC95TlY5Wi9pZ2lyVkdETExHdmZXT3h0bHJORmxuaUFVdVprVDBiSDRa?=
 =?utf-8?B?MmpLcTVUa2syOVJ0TklPUjdxMS80bE1aS2NNMWVuRU90VVJjSkFrdnlGWVFo?=
 =?utf-8?B?RTRDaU16UTQyR3lTeWY1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRLc2ZSYUg4aWNGNFoyVkQxWjcvNTRORFFmSUZwK05TV3Q5RTUrV21YMGpL?=
 =?utf-8?B?ZGdiMlFsR1Qvbit0cnVFeFUwU1ZWWTZXTUpJUFI3eFh2RnNCaTFFTUc4V3F6?=
 =?utf-8?B?VEFFakxUQlhzcm9YcFBkN2J2WmZBZVo0bjBNYy91OXBER1YrV0J5YVJCY0xL?=
 =?utf-8?B?S2lRQkREWDczM1ZmSDBNZVhweFpZNTNncEd5SGZWejdnL0dINHNXUjNxeE9O?=
 =?utf-8?B?Vlkyc01CSU1wd2VCclg4OWNXQVZ4N21qVU5NQUc2cCtwcERqaURwQUNGNXpr?=
 =?utf-8?B?VGh4UEZKWVVHcFc2eTlDZzNwYnpmbUJHWG5HejlnaTRVUWZucENJc3BIUnF5?=
 =?utf-8?B?WGhpcjRTRytZUG5pMTBweUkxaHYveXQ5eFBxQVByQUxWdURlK001R01pMGZX?=
 =?utf-8?B?NUZRclFUc2R2OGYwZGZIdFUrRnhzL2xaZGx4SzVYdG41NmlSc0FYVWE3dGxP?=
 =?utf-8?B?WjNzbUlUL0RrQi9uZ2VnaEJFSXFqblMzSmc4NUtoc09SdWRBWXpmaE5rQmhX?=
 =?utf-8?B?MXZYalVDSlJDM1ltcWFFUTUvemdCMUl3RUkwTXhDREJldjZuRjRiKzBaZWR0?=
 =?utf-8?B?TXo4cEVma0pjK3FicFNsUVZPMURxU3FDY3p1ekdXZks5UnRZMDNVVXcvTFJ4?=
 =?utf-8?B?NWlwWThsdVBzRWVOU2EzaUJsWHQwYUtreEc5TDBFSHJjWmNHT2pJUkx3S0lu?=
 =?utf-8?B?RWUxL0JZM2cwUVZDQjlFdktjU0prV3ptRExJOHhIbDlXeUNyYjBYSXJQdzVO?=
 =?utf-8?B?aHFJSTVFdUdWbzZvYjhtNXUwdFMreVpPRmNTdndnaks4cVlCWVl6Nm1VR21Q?=
 =?utf-8?B?M3pLb0g2L0x1NWw1WmpoT0RtaUppcm9FVXRSTitidUN6ZTFXWndDdG9uWHo3?=
 =?utf-8?B?SitJcjlPZFhmRjA0ZnBZWjVtSkRsYVMwMDU0WGQ5TDhkYXRqM0s2S2Z6SVBi?=
 =?utf-8?B?UXRFS1FLa0NVbXh4OXM3RXNkRG5FK0IxaHlVNU5DOVkydmlGWjZXUXdUbE9a?=
 =?utf-8?B?SkNtSm5YK2R4cGFZUndGbS9HTlpGSXBxSkoyU1hnYlIxaFlrYUV0MUkyMjBR?=
 =?utf-8?B?QmlKdmxvcEVMTFZpdXFLOCtic05uTmFwbmlNMkRVc0cwb20xWlNhSFd4L1ds?=
 =?utf-8?B?MG5GbHN1WEdQSnZlcGJ0NXBjUjllajljUit1MzhFQUoyL2ZKcUdFdXQxbFly?=
 =?utf-8?B?WHdmZkJLc0xydUJIUURNODdtUjVPVXZJbUdUWWttakdsNzRUY28zWnk4YkFG?=
 =?utf-8?B?Ym03eUdBRHh0UXE5STl4MGdqYld0cUxUMExkbEtwOUdkYVQ5aVZXTG9sQW5u?=
 =?utf-8?B?cjFDL1B2L1NOU2wyYVBZWUpETXcvZVlFWjRic2hUeHBuaDNMWEwwWHM4VVZD?=
 =?utf-8?B?MW1vUE44VWhsMnJHeFZDNDFMNDBQd1F1a1B5S1Z6MXJhKzk1d0FhY09STjM2?=
 =?utf-8?B?aTRhZ0NBcWExUVUvanB2MERmWWpyaUZsS29ESkN0YXEyMDNsOFN1S3loZGM2?=
 =?utf-8?B?M0N5NmJqOGVSZnBuYlZ5QjBqQ0Zjdjl3bW4ramlEd2FYVURUci82SzFXMHgz?=
 =?utf-8?B?a2JERGxhczQ5ODI4VHlWcEN4RDEvZ1JWQlhDVXdJcjFtbU1hWnBWRDBMU0Zo?=
 =?utf-8?B?dGtHWjRLZExBczZjNFhzNCsydERnQWg5N1p4QmJEb1U0MXVRK3JBaW1kYm1h?=
 =?utf-8?B?OXZTVUlSWlp1Y05XNURrYzJqVDFlSENGblVlQ3VkY09LL0JVZnhEd1RCRjZP?=
 =?utf-8?B?cXY2QVNEbXNSZ20rdGtJU3J6L2tvd2d2QmpOU3ZwNkIwZ2doYVU0M1M5UnY1?=
 =?utf-8?B?V3dDUjcxTkk1clNqdVRhWExia2liQUd5Rjl2MzhlNXlBQ20yVVNFOVhCUGtL?=
 =?utf-8?B?LzA4eCt6aXdLUUJENm9kVTdVMFBSOGZkYmtHS3hpTmZORnNZSjhTMXpPUlZ2?=
 =?utf-8?B?K2M2ZkpjTEMzQzZZNGpPdkhhb0NBMTI5T1REZTI0QWI2WkpHcC9tWHl0b0Zr?=
 =?utf-8?B?c29YWERDM3NPTVp2dkRreWlsS3NHWmdUNkNMK0dxTmwxdVpZNTh0UE5acmRT?=
 =?utf-8?B?OEwzMWNIYzJDL0JHeTN1MDVhZVF2ZE40cy9UbEk4OEZMdVdkei9FR0huM3hs?=
 =?utf-8?B?Tmx3VEpjcTk3SnNpZTJSWEFFS0twOTZ1emtuTFFua0JtL0srSXRSR2hnSUdP?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b83fd80-91cf-41f4-bed6-08dd0dfd79c1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 09:34:07.8497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yB7muQALBhn9f1JR5pI3AE4gZw1cSlKpc6IB8UwZw1YAq6vXCVOIV7PskXzlfVXApVYGLPtmWLPNelfULy/d6OdxXelgddj3her9MGmUg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8884
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

Hi Daniel,

On 11/26/24 9:27 AM, Daniel Semkowicz wrote:
> ddrbin_tool interface has been changed. Additional chip_name argument
> is now required to modify ddr binary file. Update documentation
> to be consistent with the new interface.
> 
> Update BL31 and ROCKCHIP_TPL file paths to match current version
> of binaries available in the rkbin repository.
> 
> Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
