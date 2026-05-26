Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82C1CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 21:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5C4846BD;
	Tue, 26 May 2026 23:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ay1e1R3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11B184843; Tue, 26 May 2026 23:50:04 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFAAD846B4
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 23:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxBp4NhStEFrAyJIkM/Gw9mLMiaTLXjHV+N+cba1vsyN/71aWMN5CUZFMMz5CzaXljB8S9U0oPGYE5j71gczu/cMhrNlgzoDh9JDr4FEn2pZk8pguhlSDnZ7QX6XMpIV7evH2Taj2LeTQpFQJ6sc4o4+ECzx1P2Q+9fqsjMMliLDMI9O3RQ/7vP+HqG3PT4Lwur3zN9koaM0YG+2SgD0rOVRm4IVH3+7yPFuv2n1HfTR0WQq24UuWa1j+XoZtQu2i6t6dAC2aimu/3rCfkzwuxS0C6Ro/UhlC0u0wNkQv0VvYhTgu8usmFUbF0c0axQaxlzQUH2aIMBCIFzOZcGkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIHnpG/csJ72UyLY5CzrcuodKnxviYINERj8ZNDDTzY=;
 b=Olj8tZ8ZH4jhCOvLrOEzNcRbEzc22op8hPIrabQEUaFTT9rUZoCZc2p79qDzcEFuz0CSOqxTMI5pHbiEEwdefrowpwqVnxaDLjb3HofVdQNW8t/VzoRap0lbgi6MB9cNAOfHfYMFZdDsqmLy70UFMzm2x2UuhZ87wS8+FYVb6Z9iVFzRuV2xcYw0MkHUlK/ZvwZKc/a2XSICIiYbUdWLw0X+cY14H7D+kBkikJDS+Ql6BvdSa5sK3aQTojutVadPGZrBPM3/nqico8Tghg+EkmNBdHlC3XELWVX2wJBgtS2oQ6crx3VT/H1ySLUSzyGC8VhSiTu5srWg++KNAun6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIHnpG/csJ72UyLY5CzrcuodKnxviYINERj8ZNDDTzY=;
 b=ay1e1R3c3OdcMG+XWLPwaHweCrhW5fLpsDV5i32d8J+AP5z/9+Of3smdJ+9MST5fToBy1tTiU68B+Imw/YKjOOw5gbj8G9o+DyVEQMe40LteBPsFosZVv6G4yYoSDly1WdbD+9oxgYzvUMTsOX1CStKecW//mQvPgFd2GYH5Qss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by MI3PR10MB9897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:77::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 21:49:56 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 21:49:56 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>
Subject: Re: [RFC PATCH 6/9] linker_lists.rst: update documentation
In-Reply-To: <CAFLszTg2+hNfoBzMYiaSqad3G=JU40Qy+7oXXyUJxgH0Gk=Esg@mail.gmail.com>
 (Simon Glass's message of "Mon, 25 May 2026 09:03:11 -0600")
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-7-ravi@prevas.dk>
 <CAFLszTg2+hNfoBzMYiaSqad3G=JU40Qy+7oXXyUJxgH0Gk=Esg@mail.gmail.com>
Date: Tue, 26 May 2026 23:49:54 +0200
Message-ID: <87zf1let8d.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023977.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::378) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|MI3PR10MB9897:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8f8a72-a5f9-4b2a-539e-08debb70ba05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|22082099003|18002099003|38350700014|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 0qyd2en5rM9ANu8tLAocd1bOMvWwdlAeDkFxqzJ1/BhpfEQD6fgPIcUchxmU3lOl3D+FgITHYeStcvwESQZsuslnfmUuZ8YuzkhZTKb+nFUVcVE3OqT/nMVtMDktgywvmp+NKPNzge9sC5E38+l1U7srIrpaRz3ZWPrFj8CR2Cl8pJKm0etXPptA+hhKv+nOGGudGPzvNrL97lSgeDAkS8MxbQA4ItCzZJNVgPpGGSDRWyuC29s4LX3kLTLXvBOjH8yKCB1IQdjLSMrjghAsQTA6Jp0APgc2pTjKg6t+x/+5Un6Q2lkKgQFr8GFGLn3wLUmFzfNMx/qyJd6np/mZRGOKllds8PmN4rbbIwJSF3y13ebbEzlEf47Ex8IVQtsf6i8j///G5TCauoKPaTeJlnPoY9BiTQTuYPBcDuRUwc5h7N0j0CAKd3qh3q5odfgeVpHmfZDrdFM5P10t01KExmi3oxtt8/zQz13ILXai9/DL4ujZg+Xz4D3dWzMmt+EwlyAIxGvtclZx+jgoIa+XQ8+mXn05wgnzav1hGc4K2pbtyxonPbw+GD+HGbhfnCWbB6OhQu5AoohqOJKiTnrnHl7uXKMDHbA5NU4Q/UP5s97dpDJAnd5CUIOhD5b9FYj0tIiyPjZFXIt1w/qwlDTLfn3pPtrf09RcOFsq/2z1uheJ3s6i0cKWIXcXBHjP3mEtrQS6iU+RKaY0gra8PHJdk/AF+ru+pVIe19b/p4EmczQfiAS5KxzxRLQ8uafN3JNq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(22082099003)(18002099003)(38350700014)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+cclIoMPWguWEwozXy2JW1WIQ1uvhh7u8G7XHdRtzapBIttcPTaFK8Impux?=
 =?us-ascii?Q?LSou4mQ++BmH+frSm49hjqk/wQlRP0cRz4LNdEwEn0Tef3GuZBCn3w2CAdCD?=
 =?us-ascii?Q?Hs7HYaTr4SOcEfVueqKVeN3C7rlv/uZBTFiC337QZXv9DKjGdB00gNUGcmbD?=
 =?us-ascii?Q?lfIxamDE5cvn1vEdD7d8ABqHJmLyuxpaI7g13C2fBFUbu1UzPjTw+2ow4YVi?=
 =?us-ascii?Q?VeOlbO9e7zYofkxxwitrX3SrFztk27gP8ZS9pKfUMcf7HnHppR9b34y/YbTz?=
 =?us-ascii?Q?dAtzIbvhm4BY8vbhkPeJsSvrwwFWTaAWZ/RyRPaMa0KEnQBDserd98E4t386?=
 =?us-ascii?Q?LvQiNQs2TTiUyscbiYF5WL3LUfV/b/KbDeClOW5Ddlqsu1j3WMf3wjZgMNWR?=
 =?us-ascii?Q?DuPqxECEiiFYsawnuxxjD5n1Eb+DApXrqJOuKSPtKTeVSZrhOthL1YQiVyWp?=
 =?us-ascii?Q?6bpbep6LPBmqg6jW+1YftBjr+l5QcshLK+qIQ8SVo8DkLXa8teSBYXT07c2l?=
 =?us-ascii?Q?ER/5j6Iv/DeuiTDAqnlTgi7z4Agm/jGhHIdKier6iv5g0El/rEHAROga55Wh?=
 =?us-ascii?Q?oHYVM8Nc1d9CrBhcsIZxG2OJJlitq4eidlA4jOr4IYWikrslrBaIZys/Mq1V?=
 =?us-ascii?Q?ubTG4poveB3vmw6DVNk7Nb1v5qRHNU8mxclf74mZCiPEwS6VX6l2SYS4buD1?=
 =?us-ascii?Q?lWn87K4mTgVnh6rnWlj9jha6onCNXJKKisHq4CwrSN1J8SZb6G9uFQynbwcZ?=
 =?us-ascii?Q?UjklIxX1BDATzDMTwvqzRTAxUtg85tRm0xo1kjIsTTW+6kbJ5A+a0br8Eeua?=
 =?us-ascii?Q?ZBaZvFg3F/th7avREzauOUSBSvlE2O7IKVd4cepUHbHFTp2c3y3xxLnpC4sK?=
 =?us-ascii?Q?ochB7jwNgEDfi10f6txhMQQvODZ/qLODq/GW4xevV4sZi2PnYMtdUvVbit6+?=
 =?us-ascii?Q?AK6US4YPpPQVYgxg2PwQBXF3GhyiiUWFm+5E/0f7XFX2pm0SiZ0uAvYolSHQ?=
 =?us-ascii?Q?axV2LDw+wYU9zjeQTYpuBfqjrKPp9NRWe0E6uHPy7g2yFWW0/uLJh/JeIwQg?=
 =?us-ascii?Q?P9bIwIVF/X1TjMpKdyqFU8PsTnEdfuE1qVSeJh0SvVclvbY2NxqMw9iW494+?=
 =?us-ascii?Q?EQRlgZkmvvEpRdHNaWbNSDprHtHyHq2tLZIJsfyEssAfuI3c2Sv23LqELjm2?=
 =?us-ascii?Q?9q+EYWbjovE+4JXPaxkg6KI7K79+AJrYOETHiANh741lnx9//nYbX4cUaJbq?=
 =?us-ascii?Q?94HLgiErilpPwZDxam2BQ7GfoyXS1fNFk9hGMwzhsg97xqVZou1dxmKjMM84?=
 =?us-ascii?Q?vxwhKEtcFMYhKfnK5GCTPCLrvR29I8fsCQPUuRg1WhgzOvZbExDk7uZliawW?=
 =?us-ascii?Q?5/uFYiQ4Bp6lqovnF9zt9saC9bVNwnSoRzbthigHT7DGdeqZbZzucxQnoVn5?=
 =?us-ascii?Q?6jbh9A4XMKqA3jL3DFMCaN5nJQ0qhmCyI+7uTayMUpUJr3VJXB0TRrKhncA1?=
 =?us-ascii?Q?zxmMwWK+JIthYzyDVa1WiTvHuvqsCmvh/+Lze0lpKFohK7m+Fs3zkrduHd6y?=
 =?us-ascii?Q?MLBkC6z/2ID/m5e3U9ucG2zRQcfAo140vUdPwy7W3X4vyDppyX8A1RrgktjZ?=
 =?us-ascii?Q?rvOb+Z+knM+sN4oCgOrojdANYqQDcCv/vYtKyX7Bw7HeDKG7vKys4MsL8Qbf?=
 =?us-ascii?Q?q6u5CzzMjAW+YqKu0DFYFDEl2zBhD/RhdJCyGOsupg0NvmtKPSLMZme0d8ei?=
 =?us-ascii?Q?g6nUnfPl6o/acsagUBxXanQbwpSy/kM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8f8a72-a5f9-4b2a-539e-08debb70ba05
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:49:56.5645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mu6fGMLXVWm2TgUHRmgl+ZjrfeXZPcF3IsrYygoLDCrzxD8mN7m7Ie4sNV2RO5G95hHPTKdXgRqXXeAi04Fiv67AOMT5/R/HYCIlIBdLV4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB9897
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

On Mon, May 25 2026, Simon Glass <sjg@chromium.org> wrote:

>>
>> -  __u_boot_list_ + 2_ + @_list + _2_ + @_entry
>> +  __u_boot_list_ + @_list + _2_ + @_entry
>>
>>  and the C variable name is
>>
>>  ::
>>
>> -  _u_boot_list + _2_ + @_list + _2_ + @_entry
>> +  _u_boot_list + @_list + _2_ + @_entry
>
> Not quite - the actual symbol is _u_boot_list_##_list##_2_##_name
> (note the trailing underscore on the prefix), so for list 'drivers'
> and entry 'first' the name expands to _u_boot_list_drivers_2_first
>
> As written here, the components concatenate to
> _u_boot_listdrivers_2_first - please change to:
>
>     _u_boot_list_ + @_list + _2_ + @_entry
>
> to match the section line above and the unified '%u_boot_list_ + ...'
> form a few lines later.

Good catch, I hadn't noticed the inconsistency in how the existing
section versus symbol names were documented.

>> diff --git a/doc/api/linker_lists.rst b/doc/api/linker_lists.rst
>> @@ -46,16 +46,8 @@ Start and end symbols for a list can generally be defined as
>>
>>  ::
>>
>> -  %u_boot_list_2_ + @_list + _1_...
>> -  %u_boot_list_2_ + @_list + _3_...
>> -
>> -Start and end symbols for the whole of the linker lists area can be
>> -defined as
>> -
>> -::
>> -
>> -  %u_boot_list_1_...
>> -  %u_boot_list_3_...
>> +  %u_boot_list_ + @_list + _1_...
>> +  %u_boot_list_ + @_list + _3_...
>
> The commit message says the surrounding 'Note the two _2_ constant
> components' paragraph is now easier to grok because only one such
> component remains, but the paragraph itself still says 'two' in the
> patched file. Please update it to say 'one' and adjust the rest of the
> sentence, since the start/end mapping is now relative to the single
> _2_ separator between list and entry.

Ah, yes, that does require rewording to make sense.

>> diff --git a/doc/api/linker_lists.rst b/doc/api/linker_lists.rst
>> @@ -82,19 +74,19 @@ defined for the whole list and each sub-list:
>> -  %u_boot_list_2_drivers_2_i2c_2_first
>> -  %u_boot_list_2_drivers_2_i2c_2_first
>> -  %u_boot_list_2_drivers_2_i2c_2_second
>> +  %u_boot_list_drivers_2_i2c_1
>> +  %u_boot_list_drivers_2_i2c_2_first
>> +  %u_boot_list_drivers_2_i2c_2_first
>> +  %u_boot_list_drivers_2_i2c_2_second
>
> BTW '...i2c_2_first' is listed twice - please drop the duplicate at
> the same time.
>

Will do.

Thanks,
Rasmus
