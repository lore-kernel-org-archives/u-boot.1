Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F7FCD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 23:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7B7846E2;
	Thu, 28 May 2026 01:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S102WZVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E48D384837; Thu, 28 May 2026 01:22:27 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5497B846D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUZmNyNQnyjAlghWPyE9Qmz2vaUD4m7fuPPsv9cDf15sb2bYmljQZHsBeC1cQGygTlUSMJoJS3a+5qJMi7d46MZpSFC+49sg7iQmsLO1g1ZfJaOrAkL5no4yIlsmdSj+oVO/0oltC2qhehWxAsHtoxE8dX77njsa+csXXgKl0KpBHFSEHpVtJ6nZTzizWgi2as7EiFEWK5xAxFScy1K+ugth4AbK+aLGPTgLCBTAd8LDBNLraxELMuhVyWfCGmWZidfPVnhub163kysrUQO5c8xOwjtnukcswGhX/c2B1Oi8ZHTyohhVcE36z8Y9D1xf+Zq2YGVEfs8cczQ57rQxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQw6taZCk2lbGVzA+j5DWCFN0t/QRZrQmjgoPoubskU=;
 b=nRupA4cXit8jCuOnGUXN7d7La46XVSduNjh+IPKlPkEm749hI8UAUlIap60NxgRO27yUW45gXaUTU0TFJlwD7ziJWfGAT1nyJJ5aWI5WZHsinFcXHyby1a+RFG5K4vWju5upTj6KMsFKKbjdzwjSeU/sZcN1W544Wn57XbyazqUQ+Yo2bAjGUVX4eQ+j2oqkPv1/tGdC2JVUoIkkXZXB/HYJRw8LyNySkKVcX/a3bX9ljBbLWBsoG+gYeEzCyWDjqQmcCdhaciPXOEN9vUzkZJo9M2wwgUJY/bIHpepJBHtxzvhLEDu7VJ5VB8YFBmsVQynfjiD9r+elTeiZZtf9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=altera.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQw6taZCk2lbGVzA+j5DWCFN0t/QRZrQmjgoPoubskU=;
 b=S102WZVkvfsXIz10N+CdoqxDiO114RL4eOD+/t2AiNalGiMJkBrt/0PizXstMVFh5aWqWYHtNrFb8GJG124RyRYvpLNjKUP1MGsmDrx/TTYMb/9DO3NyvGho+PkcLCQTti/UInT0fp2Iaj/TqEiIxhPfqUbQ0e3XzfrDikT1lQM=
Received: from DS1PR03CA0007.namprd03.prod.outlook.com (2603:10b6:8:450::19)
 by LV0PR10MB997686.namprd10.prod.outlook.com (2603:10b6:408:340::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 23:22:21 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:450:cafe::5c) by DS1PR03CA0007.outlook.office365.com
 (2603:10b6:8:450::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 23:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 23:22:19 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 18:22:19 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 27 May
 2026 18:22:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 27 May 2026 18:22:19 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64RNMJgE845043;
 Wed, 27 May 2026 18:22:19 -0500
Message-ID: <96aa516d-9039-4b64-a779-3f16a9b9b816@ti.com>
Date: Wed, 27 May 2026 18:22:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, Peng Fan
 <peng.fan@oss.nxp.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <marex@denx.de>, <tien.fong.chee@altera.com>
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
 <f87d4c47-8675-4b43-b076-52325e2c00ca@altera.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <f87d4c47-8675-4b43-b076-52325e2c00ca@altera.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|LV0PR10MB997686:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f0da7c-2a04-4de5-78cd-08debc46cc96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|3023799007|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rWDCAPMBZbIV0tHlemMxWPvtdraQ+x2w74ttEivOTGOumC66sCl0T7pIHg/VYMrmPvBPRl3hurm/FOH7ajDOB3OrhPVa7aJDiUMKi0lisjNbWndWrVauo1zOEBqUai7tlDhe7qqwnxRBR5uBpV4e8XXWk/rsXFiwOdoodFpfGgZ8sqKGdsz7OjN0kQb85vCCom6aPSxgkVrkLzaZipaL44BBMfH/ze35oogVoPB0eq4Gc+vhMSGmNYJpOwFZh0VAbAKzed1xi6RvRzCzr/WQI8Vn9vyg5005if0SUpxMtth4PmAWOdLZZ1kb+I/ZeNvpS4Em3n5v3wDtHbLuAl0hdgpb83S9GxN1Ph7I9QRs4aNX9LZnbZzxn+3w70IPucjdrVbaaALHQK4cRjbwXJUgpY4emoE9oIbS6K2BqU0rIrudQo89nRNlwSkKiIZyeX33DOD5k/FOQaA7Hue9Ag1QowbDGa5YYyTT5DVf5kCxxV0dxd+FWEftoXjy+Q6E1IWAMc5bFGSk4IF1nDh0y5gkhvSw7AtyY6fRIy2TDR58PMYYb+xDBql6y0LaDma0/8b7XD8tf6knTKj65PkS0LTwgSjiCMyiSqNlffXLtWiDTO8SNGtN++aRMCLa5tWP/gHlKnUjhrIZnJ/zxEUPfvog6TnNn0DdLE7b+HZaiieL7Bcw+vtyzjpuFF9yKhTJck/F1q7H7y7yer0X9di19KwuynNHsuNahAqHNFNe10Msmro=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(3023799007)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7jezD3A67aWrjiC3zG9EGM7iP6+qfveoj1xMNCni0ci6ClZdpOFbYTGY+t7hf0YDGnstvAAMU16SGFOvEMc5Boi5RwCRGSP6vGH2ssENEAppcy5FJzTUjUQn2EydKTYHLjXyW99LUlDTgg0fYnTvkY3L/ML2+yLOs5NX36ASqmj+rbS+hZ67hCRIM1JH+9PybakXuxnWsjuCTtELn4WTFNStfRrnJdYPMpCITnM1mxEbeT81v71GCGKavGSUQfo/SsPob9Q0+n6zdkGLFSH8SBKmtpPU8Kv3J4SFRb0j71iIxVH0ji4ZxhuDdfCnBxRgqFmg/iEnoeQyRTpWQ6Ja+N6ufxrxwi9aisbf7Nejqw+/SXMiJZ0/6906GM1jcN0WqN3L8m27mH0H0w231RcsZyVsLiZdI1yk3d6/BOZoM0hIS4GzRddQeUAdEEX5QaBA
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:22:19.8275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f0da7c-2a04-4de5-78cd-08debc46cc96
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997686
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

Hi Kathpalia,

On 5/16/26 6:44 AM, Kathpalia, Tanmay wrote:
> Hi Peng,
> Thank you for reviewing and for the detailed feedback. Apologies for
> the resend — my previous reply had an incorrect timestamp due to a
> timezone misconfiguration, which caused it to appear out of order in
> the thread.
> 
> On 5/16/2026 3:14 PM, Peng Fan wrote:
>> Revisit this patch, since it break one board [1].
>>
>> [1] https://lore.kernel.org/all/52ec8007-ce50-4f12- 
>> b796-4b8c2aa1822e@ti.com/
>>
>> On Tue, Oct 21, 2025 at 01:45:26PM -0700, Tanmay Kathpalia wrote:
>>> Some boards have SD card connectors where the power rail cannot be 
>>> switched
>>> off by the driver. However there are various circumstances when a card
>>> might be re-initialized, such as after system resume, warm re-boot, or
>>> error handling. However, a UHS card will continue to use 1.8V signaling
>>> unless it is power cycled.
>>>
>>> If the card has not been power cycled, it may still be using 1.8V
>>> signaling. According to the SD spec., the Bus Speed Mode (function 
>>> group 1)
>>> bits 2 to 4 are zero if the card is initialized at 3.3V signal level. 
>>> Thus
>>> they can be used to determine if the card has already switched to 1.8V
>>> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>>> transfer mode.
>>>
>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>> ---
>>> drivers/mmc/mmc.c | 55 ++++++++++++++++++++++++++++++++++++++---------
>>> include/mmc.h     |  3 +++
>>> 2 files changed, 48 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>>> index ec61ed92e86..e1f62a5d0ad 100644
>>> --- a/drivers/mmc/mmc.c
>>> +++ b/drivers/mmc/mmc.c
>>> @@ -643,6 +643,19 @@ static int mmc_switch_voltage(struct mmc *mmc, 
>>> int signal_voltage)
>>>
>>>     return 0;
>>> }
>>> +
>>> +static bool mmc_sd_card_using_v18(struct mmc *mmc)
>>> +{
>>> +    /*
>>> +     * According to the SD spec., the Bus Speed Mode (function group 
>>> 1) bits
>>> +     * 2 to 4 are zero if the card is initialized at 3.3V signal 
>>> level. Thus
>>> +     * they can be used to determine if the card has already 
>>> switched to
>>> +     * 1.8V signaling.
>>> +     */
>>> +    bool volt = mmc->sd3_bus_mode &
>>> +           (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | 
>>> SD_MODE_UHS_DDR50);
>> This is wrong.
>> sd3_bus_mode is sd supported bits, not the current running bits.
>>
>> To detect the sd card running bits, need to use:
>> (__be32_to_cpu(switch_status[4]) >> 24) & 0xF
> 
> You are correct that sd3_bus_mode stores the supported bits - as can be
> seen in sd_get_capabilities() where it is filled from the CMD6 status
> response:
> 
>      mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
> 
> However, the intent here is not to read the currently active function
> code, but to use the supported bits as a proxy for the signaling voltage
> level.
> 
> According to the SD Physical Layer Simplified Specification v9.0,
> Section 4.3.10.4 (Switch Function Command, CMD6): the UHS-I speed modes
> SDR50, SDR104, and DDR50 (function group 1 bits 2–4) are only available
> when the card is operating at 1.8V signaling. When the card is
> initialized at 3.3V, those bits read as zero. Therefore, if any of bits
> 2-4 are set in the supported field, we can safely infer the card is a
> UHS-I card and, when not power cycled, retains 1.8V signaling.
> 
> Using switch_status[4] to read the currently active function would
> actually NOT work for this scenario. After a warm reboot, the card
> receives CMD0 (GO_IDLE_STATE), which resets the card's selected function
> back to 0 (SDR12/default) — even though the 1.8V signaling level is
> retained. So switch_status[4] would always return 0 in this path,
> making it unsuitable as a 1.8V indicator here.
> 
>>> +    return volt;
>>> +}
>>> #endif
>>>
>>> static int sd_send_op_cond(struct mmc *mmc, bool uhs_en)
>>> @@ -1369,9 +1382,6 @@ static int sd_get_capabilities(struct mmc *mmc)
>>>     ALLOC_CACHE_ALIGN_BUFFER(__be32, switch_status, 16);
>>>     struct mmc_data data;
>>>     int timeout;
>>> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>> -    u32 sd3_bus_mode;
>>> -#endif
>>>
>>>     mmc->card_caps = MMC_MODE_1BIT | MMC_CAP(MMC_LEGACY);
>>>
>>> @@ -1451,16 +1461,16 @@ static int sd_get_capabilities(struct mmc *mmc)
>>>     if (mmc->version < SD_VERSION_3)
>>>         return 0;
>>>
>>> -    sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR104)
>>> +    mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR104)
>>>         mmc->card_caps |= MMC_CAP(UHS_SDR104);
>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR50)
>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR50)
>>>         mmc->card_caps |= MMC_CAP(UHS_SDR50);
>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR25)
>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR25)
>>>         mmc->card_caps |= MMC_CAP(UHS_SDR25);
>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR12)
>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR12)
>>>         mmc->card_caps |= MMC_CAP(UHS_SDR12);
>>> -    if (sd3_bus_mode & SD_MODE_UHS_DDR50)
>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_DDR50)
>>>         mmc->card_caps |= MMC_CAP(UHS_DDR50);
>>> #endif
>>>
>>> @@ -1830,7 +1840,11 @@ static int sd_select_mode_and_width(struct mmc 
>>> *mmc, uint card_caps)
>>>     uint widths[] = {MMC_MODE_4BIT, MMC_MODE_1BIT};
>>>     const struct mode_width_tuning *mwt;
>>> #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>> -    bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false;
>>> +    /*
>>> +     * Enable UHS mode if the card advertises 1.8V support (S18R in 
>>> OCR)
>>> +     * or is already operating at 1.8V signaling.
>>> +     */
>>> +    bool uhs_en = (mmc->ocr & OCR_S18R) || mmc_sd_card_using_v18(mmc);
>> In theory,
>>
>> bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false; is correct.
>>
>> OCR (including S18R/S18A) only reflects voltage switch negotiation
>> capability and intent, not the current signaling voltage. So your sd card
>> should have OCR_S18R returned per my understanding.
> 
> I think there is a gap in understanding here. The scenario this patch
> targets is warm reboot or system resume - the card was never power cycled,
> so it is still operating at 1.8V signaling.
> 
> In that situation, when ACMD41 is re-issued, the card will NOT assert
> S18A (Switching to 1.8V Accepted) in the OCR response, because the
> voltage negotiation already happened in the previous session and the card
> has no need to re-negotiate. Per the SD Physical Layer Simplified
> Specification v9.0, S18A is set only during the initial 1.8V request
> handshake. A card already running at 1.8V will not set S18A again on a
> subsequent ACMD41 after warm reset.
> 
> This is exactly the corner case: OCR_S18R/S18A will be zero, yet the card
> is already at 1.8V. The existing code misses this entirely.
> 
>>> #else
>>>     bool uhs_en = false;
>>> #endif
>>> @@ -2701,6 +2715,27 @@ static int mmc_startup(struct mmc *mmc)
>>>         err = sd_get_capabilities(mmc);
>>>         if (err)
>>>             return err;
>>> +
>>> +#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>> +        /*
>>> +         * If the card has already switched to 1.8V signaling, then
>>> +         * set the signal voltage to 1.8V.
>>> +         */
>>> +        if (mmc_sd_card_using_v18(mmc)) {
>> To switch voltage, ACMD41 is required, see mmc_switch_voltage.
>> Forcing switch to 1.8 here has some risk.
> 
> Agreed - ACMD41 is required to initiate a voltage switch on a card that is
> currently at 3.3V. However, in this path the card has already completed
> the voltage switch in a prior session and is still running at 1.8V. There
> is no card-side voltage transition happening; only the host controller
> needs to be reconfigured to match the 1.8V signaling level the card
> retained. Sending ACMD41 again in this context would be incorrect, as the
> card is not in a state to re-negotiate voltage.
> 
>>> +            /*
>>> +             * During a signal voltage level switch, the clock must 
>>> be gated
>>> +             * for 5 ms according to the SD spec.
>>> +             */
>>> +            mmc_set_clock(mmc, mmc->clock, MMC_CLK_DISABLE);
>>> +            err = mmc_set_signal_voltage(mmc, MMC_SIGNAL_VOLTAGE_180);
>>> +            if (err)
>>> +                return err;
>>> +            /* Keep clock gated for at least 10 ms, though spec only 
>>> says 5 ms */
>>> +            mdelay(10);
>>> +            mmc_set_clock(mmc, mmc->clock, MMC_CLK_ENABLE);
>>> +        }
>>> +#endif
>> A proper redesign is required. So I am going to revert this patch.
>>
> 
> I would respectfully ask to reconsider before reverting. This patch is
> specifically targeted at the warm reboot / system resume / error recovery
> scenario where the card is not power cycled. The check in
> mmc_sd_card_using_v18() acts as a guard - it only triggers when the
> card is already at 1.8V and the normal OCR path did not catch it. On
> a cold boot with a fresh 3.3V card, the UHS supported bits will be zero
> and this path is never entered, so it cannot regress cold-boot behavior
> for any board.
> 
> Regarding the reported regression [1], Judith mentioned that he will
> debug once he is back. If possible, let us wait for him to conclude
> before deciding to revert.

So I started looking at this. So far, I have found that on AM65 u-boot,
we had been enumerating to SDR104 mode once during boot and finally
resolve to HS mode right before loading the kernel.

Also, sd3_bus_mode=0x1f at u-boot stage.

Something weird: from the schematics, its does not seem like the IOs are
switching to 1.8V with on board hardware PMIC.

It seems like the call stack has changed where previously
uhs_en=0 in u-boot and now with your commit uhs_en=1, right before
loading the kernel. After this, we call am654_sdhci_set_ios_post
multiple times at mode=0 & signal_voltage=0x2 until mmc_init failure.

I realize this is not the most stable platform and there could
be hardware issues for SD. Perhaps it is a good idea to create
a quirk to skip over this section for these kinds of platforms?

What are your thoughts? I will continue on this debug
and come back if I find more useful information.

~ Judith

> 
> This problem is not unique to U-Boot. Similar discussions and solutions
> have been proposed in the Linux community:
> 
> https://lore.kernel.org/linux-mmc/a367a679-28f7-898a- 
> c043-27df8c9c9aba@intel.com/
> https://lore.kernel.org/linux-mmc/1506328144-13666-1-git-send-email- 
> adrian.hunter@intel.com/
> 
> I am happy to rework this in v2 with a tighter guard condition (already
> addressed in [2]) once we have more information from the regression
> report.
> 
> Please let me know your thoughts.
> 
> Thanks,
> Tanmay

