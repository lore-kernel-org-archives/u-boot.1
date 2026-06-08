Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33A2CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 15:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1163583FEC;
	Mon,  8 Jun 2026 17:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IQb60VBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 977768466E; Mon,  8 Jun 2026 17:19:27 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC9A83FEC
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 17:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWVzMIPDzwITKZkorlQ7pGJyXuI6hOO4BRZmcQK2iRkC4MfyYx9EeeBBygOe93lAj31oDEI5hi/9PIf4BK6yStd3YYKJQwYybdMTznX5rCeFvFakmPW9XyN85vKgUOclhe8NYEwtWVuOc+JEwttB8F9rt5xdUFMZT2nq1WuZe6/4DGmnQs19J3rYw865LVlAOKjTiBeJCjPIYp6pe/eFX2OFYrAak+bEyw/IC9nmw9a127NX96WyJtGtJ/VOzN/sd924y7wQDqW7pbHSTX6YF4ANdm9EEOWAlb8Ttbp+UUGAMyAphrrBrx9MJbwZX5VRVE94XwxNynJt7DjfFJmEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2XcPkXTPjRnafrAP92ibBq8dYefx+JrODNQ1K57upI=;
 b=TJ/JSA6Ka4RGb9HstjvJZ/GSOBfFSRYn6vls8uhMH3u+tMIzDZB36y/kIpA6vUMyYJDIff2gRf/h2IXk7GlN59sKWhXCV22TPM6k3QjnpllFV4xutoHh22424+/Mwb0Ww9ZLOboF9F+Utjj0ryAxgyRFtxw7b50b5hzAZYIcGyQBjZ8bbzlH9tm5UiNLWgDCBobj8QLfziyjjDLLt1IHJ1Sc96dp6PK/Mc4E7HWXTRbAxTmNdyKvyhPSzfj4Wq58AjgEUgsqGgqePj+aF/4VJMKowYaCYPpVTEweOXJm0wXFkvsaRSJbQHuNFk4SBy21rkmeyMKYMvr1yko5F8e3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=altera.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2XcPkXTPjRnafrAP92ibBq8dYefx+JrODNQ1K57upI=;
 b=IQb60VBM1chqIqGYXfBlLK10dhf/FNpo1OEqklkOd7urHhBbtZNWgaCoGnnCINvN+FQhsLuPhFASF4Ql9WluUCiPAkxxK2IHW3ZhtphAuBzkCEQMgOPdcg/xAWqgAKmfrUQUM44465HMxOBtLMjF3kcDaq02Ble+gOjLsgyGN80=
Received: from BN9P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::26)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 15:19:15 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::11) by BN9P222CA0021.outlook.office365.com
 (2603:10b6:408:10c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 15:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 15:19:14 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 10:19:12 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 8 Jun
 2026 10:19:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 8 Jun 2026 10:19:11 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 658FJBB93333163;
 Mon, 8 Jun 2026 10:19:11 -0500
Message-ID: <2571b1a0-9395-40e7-a85e-4204c7543d39@ti.com>
Date: Mon, 8 Jun 2026 10:19:11 -0500
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
 <96aa516d-9039-4b64-a779-3f16a9b9b816@ti.com>
 <2e75ec28-a3b0-4890-8e10-ea0459d6ff7d@altera.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <2e75ec28-a3b0-4890-8e10-ea0459d6ff7d@altera.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|MW5PR10MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c71985-b1da-4cd6-f00e-08dec5714d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|4143699003|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: gK/iU16dblZmVh2qXQ77B/TkbSdi7Ll9BgjTrx/FapEIhLSwGSdQFSsMwL0h2clh29M5jHYg7E7Dj4R9ErZLbt1ORxU65DEnIfWbCyVqoippwGgIBKASLCXgkoqerDUEozaa0kka/f0mB26Rz0HjOABDOzEHtXezaxso9CKxXp+MOByYESFB6J55zaPJ2NXSpvjKIprL7k3DiSOG4BxncDr8InKYXAACJiVquaDFcyddBqTcBx3+izL3ps5rUzFPi/CeBAJxXUwWkf2ADWJOCAeiZ8xHfk7UsmIWKOOYEy4MPz6t6wrKuq7tA7lz+XLGW/+AOcrSGII/ZaUX4MKUOGgGoA7E2/7dlIEEtpTtOpCWE/gpRd3xRgYeRy6NQdgve4nHj4ZWiVzAkY92q3Oy/4eqzzdyxTKyElq9yNvtHAunGioIAGX6zV13xXy+K/aQLcPx60xoL7KhzKNKRMzwj/5KswifjVfI1RzTan6PSEwxFibSA+LFW8lW9syO2qJH3vuU2sl9PI9EvYv0LIJk1sg3GCKYOFl9kDRntNb9mITeT2O4oSKzQfDRhxs0RCETF7CZE0eAdyj4J+BKi3CzKy7ugM4GimIfENRpLk2/itLMeyPwHXqFLLYusfPkoNpLe4Mys4oP5oTqDysAWtnk/pMWnESIatOEhSJA0K3hNG/eb1al4Yp7UYM/H9pnqHS62AXbKA3j9Lp/4+Bcj/oegt5VL1Rn0lF3/R3i968mXhI=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LFgbEvyNMNoYGJaBAL3VcINb+Hyq+hjRnbMarRVMtXlVSrgQMhSZDzqF9zyZhF+jVPiytjBqSRybyz5c3I3OTBaCAHHCHaPPX3kQot83nopFt1aivMX9xoMZ7H81MUi/vKpSmAEXm1V6G6jRZhptnMlJSxpu+T0dP5OWna/MexA+8JRa3Fm+czG1IAwH0cFmET3OqUsj1ER5OYP0jLW/0MU66ylOSkIwhh7uKcfU9ys0CJjewPuxmU1aLPPTwEX6mPaXPKmkm3NW9785cPvxr8d0chIm0BTaeiu06vI8FWqMxG/w2vIE6HAMiNGaKWs0Vf1kYXr68+9XqhreW8+HAbiZV9o9Td7dn9QURZOZ1COxpKv5FsJV8MDiRKV2Y1t4eJ9GnLeuxE3p6/mZKjfPx2zsQtk65M52OYT1K83IzUtDg5fubX1Fgz3hg9WnWEHV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 15:19:14.8631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c71985-b1da-4cd6-f00e-08dec5714d2a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807
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

Hi Tanmay,

On 5/29/26 12:21 PM, Kathpalia, Tanmay wrote:
> Hi Judith,
> 
> Thank you for the information. Let me share my analysis based on
> what you have described.
> 
> On 5/28/2026 4:52 AM, Judith Mendez wrote:
>> Hi Kathpalia,
>>
>> On 5/16/26 6:44 AM, Kathpalia, Tanmay wrote:
>>> Hi Peng,
>>> Thank you for reviewing and for the detailed feedback. Apologies for
>>> the resend — my previous reply had an incorrect timestamp due to a
>>> timezone misconfiguration, which caused it to appear out of order in
>>> the thread.
>>>
>>> On 5/16/2026 3:14 PM, Peng Fan wrote:
>>>> Revisit this patch, since it break one board [1].
>>>>
>>>> [1] https://lore.kernel.org/all/52ec8007-ce50-4f12- 
>>>> b796-4b8c2aa1822e@ti.com/
>>>>
>>>> On Tue, Oct 21, 2025 at 01:45:26PM -0700, Tanmay Kathpalia wrote:
>>>>> Some boards have SD card connectors where the power rail cannot be 
>>>>> switched
>>>>> off by the driver. However there are various circumstances when a card
>>>>> might be re-initialized, such as after system resume, warm re-boot, or
>>>>> error handling. However, a UHS card will continue to use 1.8V 
>>>>> signaling
>>>>> unless it is power cycled.
>>>>>
>>>>> If the card has not been power cycled, it may still be using 1.8V
>>>>> signaling. According to the SD spec., the Bus Speed Mode (function 
>>>>> group 1)
>>>>> bits 2 to 4 are zero if the card is initialized at 3.3V signal 
>>>>> level. Thus
>>>>> they can be used to determine if the card has already switched to 1.8V
>>>>> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>>>>> transfer mode.
>>>>>
>>>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>>>> ---
>>>>> drivers/mmc/mmc.c | 55 ++++++++++++++++++++++++++++++++++++++---------
>>>>> include/mmc.h     |  3 +++
>>>>> 2 files changed, 48 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
>>>>> index ec61ed92e86..e1f62a5d0ad 100644
>>>>> --- a/drivers/mmc/mmc.c
>>>>> +++ b/drivers/mmc/mmc.c
>>>>> @@ -643,6 +643,19 @@ static int mmc_switch_voltage(struct mmc *mmc, 
>>>>> int signal_voltage)
>>>>>
>>>>>     return 0;
>>>>> }
>>>>> +
>>>>> +static bool mmc_sd_card_using_v18(struct mmc *mmc)
>>>>> +{
>>>>> +    /*
>>>>> +     * According to the SD spec., the Bus Speed Mode (function 
>>>>> group 1) bits
>>>>> +     * 2 to 4 are zero if the card is initialized at 3.3V signal 
>>>>> level. Thus
>>>>> +     * they can be used to determine if the card has already 
>>>>> switched to
>>>>> +     * 1.8V signaling.
>>>>> +     */
>>>>> +    bool volt = mmc->sd3_bus_mode &
>>>>> +           (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | 
>>>>> SD_MODE_UHS_DDR50);
>>>> This is wrong.
>>>> sd3_bus_mode is sd supported bits, not the current running bits.
>>>>
>>>> To detect the sd card running bits, need to use:
>>>> (__be32_to_cpu(switch_status[4]) >> 24) & 0xF
>>>
>>> You are correct that sd3_bus_mode stores the supported bits - as can be
>>> seen in sd_get_capabilities() where it is filled from the CMD6 status
>>> response:
>>>
>>>      mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>>
>>> However, the intent here is not to read the currently active function
>>> code, but to use the supported bits as a proxy for the signaling voltage
>>> level.
>>>
>>> According to the SD Physical Layer Simplified Specification v9.0,
>>> Section 4.3.10.4 (Switch Function Command, CMD6): the UHS-I speed modes
>>> SDR50, SDR104, and DDR50 (function group 1 bits 2–4) are only available
>>> when the card is operating at 1.8V signaling. When the card is
>>> initialized at 3.3V, those bits read as zero. Therefore, if any of bits
>>> 2-4 are set in the supported field, we can safely infer the card is a
>>> UHS-I card and, when not power cycled, retains 1.8V signaling.
>>>
>>> Using switch_status[4] to read the currently active function would
>>> actually NOT work for this scenario. After a warm reboot, the card
>>> receives CMD0 (GO_IDLE_STATE), which resets the card's selected function
>>> back to 0 (SDR12/default) — even though the 1.8V signaling level is
>>> retained. So switch_status[4] would always return 0 in this path,
>>> making it unsuitable as a 1.8V indicator here.
>>>
>>>>> +    return volt;
>>>>> +}
>>>>> #endif
>>>>>
>>>>> static int sd_send_op_cond(struct mmc *mmc, bool uhs_en)
>>>>> @@ -1369,9 +1382,6 @@ static int sd_get_capabilities(struct mmc *mmc)
>>>>>     ALLOC_CACHE_ALIGN_BUFFER(__be32, switch_status, 16);
>>>>>     struct mmc_data data;
>>>>>     int timeout;
>>>>> -#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>>>> -    u32 sd3_bus_mode;
>>>>> -#endif
>>>>>
>>>>>     mmc->card_caps = MMC_MODE_1BIT | MMC_CAP(MMC_LEGACY);
>>>>>
>>>>> @@ -1451,16 +1461,16 @@ static int sd_get_capabilities(struct mmc 
>>>>> *mmc)
>>>>>     if (mmc->version < SD_VERSION_3)
>>>>>         return 0;
>>>>>
>>>>> -    sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR104)
>>>>> +    mmc->sd3_bus_mode = __be32_to_cpu(switch_status[3]) >> 16 & 0x1f;
>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR104)
>>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR104);
>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR50)
>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR50)
>>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR50);
>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR25)
>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR25)
>>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR25);
>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_SDR12)
>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_SDR12)
>>>>>         mmc->card_caps |= MMC_CAP(UHS_SDR12);
>>>>> -    if (sd3_bus_mode & SD_MODE_UHS_DDR50)
>>>>> +    if (mmc->sd3_bus_mode & SD_MODE_UHS_DDR50)
>>>>>         mmc->card_caps |= MMC_CAP(UHS_DDR50);
>>>>> #endif
>>>>>
>>>>> @@ -1830,7 +1840,11 @@ static int sd_select_mode_and_width(struct 
>>>>> mmc *mmc, uint card_caps)
>>>>>     uint widths[] = {MMC_MODE_4BIT, MMC_MODE_1BIT};
>>>>>     const struct mode_width_tuning *mwt;
>>>>> #if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>>>> -    bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false;
>>>>> +    /*
>>>>> +     * Enable UHS mode if the card advertises 1.8V support (S18R 
>>>>> in OCR)
>>>>> +     * or is already operating at 1.8V signaling.
>>>>> +     */
>>>>> +    bool uhs_en = (mmc->ocr & OCR_S18R) || 
>>>>> mmc_sd_card_using_v18(mmc);
>>>> In theory,
>>>>
>>>> bool uhs_en = (mmc->ocr & OCR_S18R) ? true : false; is correct.
>>>>
>>>> OCR (including S18R/S18A) only reflects voltage switch negotiation
>>>> capability and intent, not the current signaling voltage. So your sd 
>>>> card
>>>> should have OCR_S18R returned per my understanding.
>>>
>>> I think there is a gap in understanding here. The scenario this patch
>>> targets is warm reboot or system resume - the card was never power 
>>> cycled,
>>> so it is still operating at 1.8V signaling.
>>>
>>> In that situation, when ACMD41 is re-issued, the card will NOT assert
>>> S18A (Switching to 1.8V Accepted) in the OCR response, because the
>>> voltage negotiation already happened in the previous session and the 
>>> card
>>> has no need to re-negotiate. Per the SD Physical Layer Simplified
>>> Specification v9.0, S18A is set only during the initial 1.8V request
>>> handshake. A card already running at 1.8V will not set S18A again on a
>>> subsequent ACMD41 after warm reset.
>>>
>>> This is exactly the corner case: OCR_S18R/S18A will be zero, yet the 
>>> card
>>> is already at 1.8V. The existing code misses this entirely.
>>>
>>>>> #else
>>>>>     bool uhs_en = false;
>>>>> #endif
>>>>> @@ -2701,6 +2715,27 @@ static int mmc_startup(struct mmc *mmc)
>>>>>         err = sd_get_capabilities(mmc);
>>>>>         if (err)
>>>>>             return err;
>>>>> +
>>>>> +#if CONFIG_IS_ENABLED(MMC_UHS_SUPPORT)
>>>>> +        /*
>>>>> +         * If the card has already switched to 1.8V signaling, then
>>>>> +         * set the signal voltage to 1.8V.
>>>>> +         */
>>>>> +        if (mmc_sd_card_using_v18(mmc)) {
>>>> To switch voltage, ACMD41 is required, see mmc_switch_voltage.
>>>> Forcing switch to 1.8 here has some risk.
>>>
>>> Agreed - ACMD41 is required to initiate a voltage switch on a card 
>>> that is
>>> currently at 3.3V. However, in this path the card has already completed
>>> the voltage switch in a prior session and is still running at 1.8V. 
>>> There
>>> is no card-side voltage transition happening; only the host controller
>>> needs to be reconfigured to match the 1.8V signaling level the card
>>> retained. Sending ACMD41 again in this context would be incorrect, as 
>>> the
>>> card is not in a state to re-negotiate voltage.
>>>
>>>>> +            /*
>>>>> +             * During a signal voltage level switch, the clock 
>>>>> must be gated
>>>>> +             * for 5 ms according to the SD spec.
>>>>> +             */
>>>>> +            mmc_set_clock(mmc, mmc->clock, MMC_CLK_DISABLE);
>>>>> +            err = mmc_set_signal_voltage(mmc, 
>>>>> MMC_SIGNAL_VOLTAGE_180);
>>>>> +            if (err)
>>>>> +                return err;
>>>>> +            /* Keep clock gated for at least 10 ms, though spec 
>>>>> only says 5 ms */
>>>>> +            mdelay(10);
>>>>> +            mmc_set_clock(mmc, mmc->clock, MMC_CLK_ENABLE);
>>>>> +        }
>>>>> +#endif
>>>> A proper redesign is required. So I am going to revert this patch.
>>>>
>>>
>>> I would respectfully ask to reconsider before reverting. This patch is
>>> specifically targeted at the warm reboot / system resume / error 
>>> recovery
>>> scenario where the card is not power cycled. The check in
>>> mmc_sd_card_using_v18() acts as a guard - it only triggers when the
>>> card is already at 1.8V and the normal OCR path did not catch it. On
>>> a cold boot with a fresh 3.3V card, the UHS supported bits will be zero
>>> and this path is never entered, so it cannot regress cold-boot behavior
>>> for any board.
>>>
>>> Regarding the reported regression [1], Judith mentioned that he will
>>> debug once he is back. If possible, let us wait for him to conclude
>>> before deciding to revert.
>>
>> So I started looking at this. So far, I have found that on AM65 u-boot,
>> we had been enumerating to SDR104 mode once during boot and finally
>> resolve to HS mode right before loading the kernel.
> 
> This seems to be the root of the issue. Entering SDR104 mode transitions
> the SD card, the IO signal lines, and the host controller all to 1.8V 
> signaling.
> Once that transition happens, attempting to switch back to HS mode (which
> requires 3.3V) is not possible without a full power cycle of the card.
> 
> This is explicitly stated in the SD Physical Layer Simplified 
> Specification,
> Section "UHS-I Bus Speed Modes Selection Sequence":
> 
>    "Once the card enters 1.8V signaling mode, the card cannot be switched
>     to SPI mode or 3.3V signaling without power cycle. If the card receives
>     CMD0, card returns to Idle state but still works with SDR12 timing."
> 
> So the failure you are seeing is not introduced by my patch — the card
> was already non-recoverable to 3.3V from the moment it entered SDR104
> earlier in the boot.

I agree there is an issue with this board, but still this implementation
breaks am65 further and causes mmc_init failure now.

> 
>>
>> Also, sd3_bus_mode=0x1f at u-boot stage.
> 
> This confirms the card was already operating in 1.8V signaling when your
> debug point was reached. For reference, on a fresh cold boot at 3.3V, the
> CMD6 available functions table shows sd3_bus_mode should read 0x07
> (only SDR12/SDR25/HS bits set). The value 0x1f means bits for SDR50,
> SDR104, and DDR50 are also set, which per the spec only happens when the
> card is initialized at 1.8V signaling. This is exactly what
> mmc_sd_card_using_v18() is designed to detect.
> 
>>
>> Something weird: from the schematics, its does not seem like the IOs are
>> switching to 1.8V with on board hardware PMIC.
> 
> This is worth investigating further. If the IO lines are confirmed to be
> stuck at 3.3V while the card is operating at 1.8V signaling, that would
> itself be a pre-existing hardware or driver issue — the IO voltage and the
> card signaling voltage must always be in sync. I would suggest:
> 
> 1. Verify the voltage regulator driving the IO lines (Vccq) and confirm
> whether am654_sdhci_set_ios_post correctly switches it to 1.8V when
> UHS modes are selected. If Vccq is not switching, that is a separate
> bug in the am654 driver or the regulator configuration.
> 
> 2. Try using UHS_SDR12 or UHS_SDR25 as the operating mode instead
> of HS. Since the card has already transitioned to 1.8V, the UHS-I modes
> are the correct and spec-compliant modes to use. Running HS mode at
> 1.8V is not a valid combination.

Ok So, I dug further and found that AM65 also has an internal LDO, so
Host side voltage switch happens with V1p8 bit. It switches voltage
as expected.

> 
>>
>> It seems like the call stack has changed where previously
>> uhs_en=0 in u-boot and now with your commit uhs_en=1, right before
>> loading the kernel. 
> 
> Correct. Previously, even though the card was operating at 1.8V (as
> evidenced by sd3_bus_mode=0x1f), the code was not checking the card's
> function group 1 to detect this. So the host stayed at 3.3V while the
> card was at 1.8V — an incorrect but silently failing combination on
> platforms where the mismatch happens to be tolerated.
> 
> With the patch, we correctly detect the 1.8V state and instruct the host
> to match. The subsequent failure you observe is because the host-side
> IO voltage switch (Vccq) appears to not be working.

Wrong info here from my part, voltage switch does happen.

> 
>> After this, we call am654_sdhci_set_ios_post
>> multiple times at mode=0 & signal_voltage=0x2 until mmc_init failure.
> 
> mode=0 corresponds to MMC_LEGACY, which is a 3.3V mode. Having
> signal_voltage=0x2 (1.8V) alongside MMC_LEGACY is not a valid
> combination. This suggests the mode selection logic is landing on
> MMC_LEGACY while the voltage has already been switched to 1.8V, which
> will always fail. The fix should be to ensure the card operates in a
> UHS-I mode when at 1.8V, not fall back to MMC_LEGACY.
> 
>>
>> I realize this is not the most stable platform and there could
>> be hardware issues for SD. Perhaps it is a good idea to create
>> a quirk to skip over this section for these kinds of platforms?
> 
> I would prefer to avoid a quirk at this stage, as the underlying behavior
> — the card being at 1.8V after a prior boot — is spec-compliant and
> real. A quirk would just mask the issue on AM65 rather than fix the actual
> IO voltage switching problem.
> 
>>
>> What are your thoughts? I will continue on this debug
>> and come back if I find more useful information.
>>
>> ~ Judith
>>
> 
> Hope this helps, looking forward to your further findings.
> 

Sorry for my late response, I had to drop this debug for a while and
actually will not be able to return to this debug in a week or two.

I found something interesting while debugging on SD card reset line,
but I am tracking down different am65 board versions to further
investigate this. Ill let you know if I find anything. Meanwhile,
if you would like to sync offline on anything, feel free to ping my
email address.


~ judith
