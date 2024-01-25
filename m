Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78AAC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 11:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D38875FC;
	Thu, 25 Jan 2024 12:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="S9QMhKrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7507D8753E; Thu, 25 Jan 2024 12:03:01 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E9FB807EC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 12:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag2VhDrDmXsk40uPglE/w4YOL3tFWZujEFGnXtTZ/YEyJGUfIF+t3poGyWCUDKz+/c+4uaVromNiEw7QPIT9+6Wi/FbsEKhSp4kcgluFRErAbEvDNYGYBUGH645iJjPd6SmxuyvGZ9MmTDqbi58rBmn8fhxUX+q39FOWdS2voSYfV+6M0YbFPSc5bZ5VXeH/VMGM0v9+AzheV0zwxVyz4O3RUgFOQzqVWW4fbtjdFz6Hz9QusyJXCiLNL0KgjzduOVquzzhCp83bEAdVWg5j5KF5cimnAAhzeh3mVC8iFrWVtI7jPK8y4slDlzxJgLOhOQc0n6bG1KfquT3uRSulnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijlPoCFTpB6tCq7A4pxLDh1rOt5EOq1sZybrI1yqaUg=;
 b=WOu0TKB0DgqsP/IrutK+BssAS+hbsQqAzqstKIjBlHqaoGZDMTbJa+LsAjcC8MNqVSJsYH8NBmakwyhLhAFjtmDqBGOVNUK9NW02AGS+kmGyohnNaPBqnyZXKUwsLEKpOFMHJYTX0sWAsryV5qGkf0yFYs9uvqRLZ7Fefh8cr+ft4PUCRLESi40I9cC/dYGjClZwoTFjq6+TUWyYO9iMIsZbu9uUHkKyDx4hRFzi9f85Eh/YJURPLyct3vIncf29LOxrs6XGOSRxNhHDf8eYuGNLA7W1Otd3ohKsZLjCGcJZRnH74jkX2u3yC7+sp1evPnL5zBwxjUVEyhBpnRX+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijlPoCFTpB6tCq7A4pxLDh1rOt5EOq1sZybrI1yqaUg=;
 b=S9QMhKrS9rmn1vX4gBXl0iVE8ITu94VC7+qwznCgP/rIiVKjtpKnYPAGz5i3Z7NlaQ+tP0KIZbNyM0NnMm12vIvWBamzT4W5sJUObO6j9mweNaHYwljxCI8gRRRnYTNrWYM/sUHHoUpGgZq8hmqJObdKJVwhYUlDiNfIL2BkHCRzwu64jiokzIhuSxKIRVvwr2+wBcq2r1yTx+B2xCyAbKuGaoXIncyzTAqUXnSNC/nQhoal7Eq6yGzuaSCOXLFWPYRPtbKPEeCLzRPvMMWZf4KPg1GL1/G71O4rTsAePacN0GfeWRp1pcFfCciJcAvzrtptNh5UxsqoxtBpNY1hog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 11:02:55 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%4]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 11:02:51 +0000
Message-ID: <2f6e9491-9ae1-498c-b269-c0a8fbe27552@theobroma-systems.com>
Date: Thu, 25 Jan 2024 12:02:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] rockchip: rk3588: fix non-working SD controller if
 booting from other media
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, =?UTF-8?B?5rSq5oWn5paM?=
 <hhb@rock-chips.com>
Cc: heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-13-1eec1c34953c@theobroma-systems.com>
 <10ebfefd-1619-4b08-b15d-ec8ca8e798f3@rock-chips.com>
 <c33d0c58-cd95-490f-9514-8d61e1e70925@theobroma-systems.com>
 <31e7cb6e-7ef1-4069-a38e-b61677a8d76e@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <31e7cb6e-7ef1-4069-a38e-b61677a8d76e@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 00734997-39cc-4478-2910-08dc1d952ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2eRx2VSxGAMf414WOvnIUInYacSgR9XJKEvS07HwFYJcEcEOaue/IWbbhsHaMOjN8ZDFiGUGQKQkojfI37j2vrYIf3PJB9mPZf9X5g/PEpMhr/i5lWefnFaLqE4GaEDFRSBRy489tTU8HSGWQikkvQpbtXwna5Pt7x59/uyq0JSlSWHn3XQKQs+F6eD5cnxYVyu8eqDphb5TLWSBrvzHFfguj2N7f1Uog2lOXhiJMIWmHu4iJwgae7T8ifyJR5qZacseEdOmi68XfcYdQQPWtlPeOq9bbW0xCUacQi7uXseR0bdonzRNIJNINvZ8XyoUWEWcEqP4s6/vca55G9i4cEGPpkIYQyKZ16Ld3fG8Bcul8tbuRzPTVi/SmoBK4gT8G1+Y1xZPODYXK1OtQ4UaIR/acTGODnADhGmGkWEdQKcVEmU1BJ3ZRcGChK1VwoTQ2QdaJSOsEmbzOn24nFYaR1U6Duuw/Patqx30Xh8h58eraNWa16tzgFTaTNnN2gqYAnswM6eONgtFsGHVvQlKAbl4wYUd4+0n9Ut3ZXftLHYUbT6pJMuVDf2xGLdCtg7texW+ZVJxuuR70SY0x4F/Mr22TDdXB0VB5LyuPZDEzoh5owvL5FjMzp5dbp/+ogJw8hZyqEnnB8i6K0hMa0hCKgN2BJ8LNu51mnuaa1BD7p47fArFL9fxiEkM0yDN3Qc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39850400004)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2616005)(8676002)(38100700002)(2906002)(86362001)(31696002)(41300700001)(36756003)(478600001)(316002)(66946007)(66556008)(66476007)(966005)(5660300002)(6486002)(4326008)(8936002)(6512007)(110136005)(83380400001)(44832011)(53546011)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdtL3Rmd01oT0NLMXJ1WkZTaURqd3hsQ3RkUFlKTmJJU2F4Z1VRNEFFRlA2?=
 =?utf-8?B?USsxSldOdEVHMllpRm1kOXN4NlZDM2tyNk83TDlXZjZ1WFM2K1hhTjFsak5W?=
 =?utf-8?B?UGlYY3RHcThPdmVpQ2N1U2tvbWl5aTE0YnM2OVZRajQrQ2diR3lCR0t1RExF?=
 =?utf-8?B?TkhvOTdSdUUwdi9XU2ZrNWdsMXF3cmQ1ZmRVR1FpSjdlNzh0SytuRUVUWVdw?=
 =?utf-8?B?ME1xcm5iRmU3N044eWxseTErT3p0SzFKaWdrZWsrR2lrbVNaWlc4a0FVZ29x?=
 =?utf-8?B?WVdkb3ZNSjQ4K1BLVFk3V1daeDd2MytOblFXblY4THJGYWZlT2xrU0pNNmd1?=
 =?utf-8?B?eGQ3MWdSVzRFVFZiR0c0aU5hY1ArK204NlhkTGtjc3dGMit2MktpSnFPNEcx?=
 =?utf-8?B?Uy9EYUxESWdzV2JvdzRHTkpRUmVPaUdwdXBvVWtnWkZ1Qy80VWlKb2JVQWc5?=
 =?utf-8?B?c3hUOUNjbkY5UDlGL2NLOUxZL29lNGJsR1ZKY2tBcGp0dU1UT3FNc1BqYVUx?=
 =?utf-8?B?WW1Wakxod3JDY1FUcUpKdzdqbzQ5bWc5YmFTRjlPL3NZcUtmZFJrUXgrU1Zs?=
 =?utf-8?B?KzU3NU9DYmJtNXV1c1ExTHpPbE1MMDcrTUpZZUZMUVZkSHA3dUdCQTV3R25v?=
 =?utf-8?B?bkhnSnZzZU5rTHFqMnpOdWhpVW0vK1pzeFBwOEpHd2ZHajAySklzNEduWWRQ?=
 =?utf-8?B?RGdhNjBBeTdMT1ArRHBZU2t1NitZZEhHSGREVW9BMkZESTduRStLV3IxM2gz?=
 =?utf-8?B?Sy8yUmduMEJpRzJkV3NMcDNqcDgxUktsQVNzNitpRmhZZFVYZGJub25kWTI1?=
 =?utf-8?B?aGsyaFNyYWZwaXM1VnpJU0xnU21TcGlsZG1lZm9ObEhmVXFHOXB2cTYyUW8y?=
 =?utf-8?B?aEMrS0pwMlBCS0czOGdLdzUyWnZlMStlekVPdy9CdjlHVEh4QTJySHNwSTlF?=
 =?utf-8?B?dnQwUWJEeHhtQ0tnaEZ1TVF3ZEFObWtqczRjalh1MjZ2WDZMblRQai9EZlRt?=
 =?utf-8?B?VWVvUzkzZVM1cFI2aEo4TVpjVG9odFVkLzAwT284WTBUUEZvZDVzRnhkUVFQ?=
 =?utf-8?B?elpESDIxS2d6ZUJWUGVJaUxITVRPZDdtb0JjUE5xZHhjV0FFM2t6ZWRvWGp6?=
 =?utf-8?B?RU12SEtoRzQ5M3VrM0F4ays1K3JnVW1xVkNXSlZFUDgzMk5CSktEM2NXb0FS?=
 =?utf-8?B?a2RHTWh5VEVPMm1ieDd4MFoyQkxJTGVqVGczMlRsMTIxMzY2TlE5OWw2V0Ri?=
 =?utf-8?B?SWRVMTFDZ0JoY2FwaTUyOWZNYzd1Yk50QkFydVA5TG9BVDdyRXlWUkdmTjlY?=
 =?utf-8?B?ajE2R05EUmdyU0dGMzF4ZHNadUF3M2lFSTV6cGpPeDJJaEI3UjcrT2c3dHB6?=
 =?utf-8?B?WDZjOVA4VVJtcjk2VDFkVkF3OEpzMHpEa2V1NkYrOU0wb3VuQUhScit6eHJk?=
 =?utf-8?B?cnpIamNheE15ZDBzcDVIOUlSdTdFbGNuU3hwUEthYlh2MllpWlNVUE9CQmVo?=
 =?utf-8?B?VUpmcUhqUmhmMWpVRElvN056dE5qdllhUHlDSU5Rc2JUMFc0N3FyZDlscFpC?=
 =?utf-8?B?aTBKUGllVUNFdjBlMUQ5MEdueWNpYVFvRTdXTHh4K080eUpmNjFJc0R0WENZ?=
 =?utf-8?B?SkxjTzhSNS9XUE1id25PVUc5MjR1THpqL3NRM0QzZXhyUGlpZTllL1d5MkRW?=
 =?utf-8?B?V0RJMFVRYXVWS1BmN2c2WHFQY0E2VnpwaWN5Y3hPbkJDSGVVaXl4REYzbEx4?=
 =?utf-8?B?QkZLY2ZwTzZ4ZnExUDU3dk5oWmV4U2w5cVlPSExQUWI2ZCtSVTFhdC9ueUxT?=
 =?utf-8?B?b0d0RTB6R0Y2TFFFdFZLYWgzaWl3SGZDN3lHUitPeHlvZUZSd2I2Z2V2dis5?=
 =?utf-8?B?M1F5ajlHV1pYT293NHZXU2FzQkVmUGtFMjJJMUNkeWlVNmJTZFFjNml0a25n?=
 =?utf-8?B?WHhqZ3ZOMG53ZUlnNyttUS93azJCNDRUcTE2Wm9BdGxDNks0bFRvbWt6ZHhR?=
 =?utf-8?B?TkZPWXdKUVdONkE5dGQ0LzlHRHNzdVZCVzFVWCtzYnNOaSt6aHN4bXRpSXpC?=
 =?utf-8?B?Sklac2gzQVJ0ZnIzQ04vcUNXV3drbDFHV2RQZDJIeWxxL1JQQmE5TjJrSzhC?=
 =?utf-8?B?QlVpcXZmeGdQenpHWXo0OVYwUVBaUTExamdYM2dkSTV6c3F0NEtmVDlWc2do?=
 =?utf-8?B?aEYvY1hjSlJGdVhnU1lSc01hUjVVMEZIZVMrZ0g3TG04VjFrd1hRKytMRVVm?=
 =?utf-8?B?bG44SnpqbFlyeXVBcnZaY2Z5dFJnPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00734997-39cc-4478-2910-08dc1d952ca8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 11:02:51.7891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+uYYQkEKDRhfgGwQHzR4XGzSIsib0ViGhI2Cz1zUdBLJmQrI1Nlko/YeVZmd9ceDa25Guu4rLEnQnfs4iRLbl/jkJsqtpTXqrHbAUAbCPyTEMA3InTMU7m38T1M22Yn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435
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

Hi Kever,

On 1/25/24 11:29, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/1/24 18:50, Quentin Schulz wrote:
>> Hi Kever,
>>
>> On 1/24/24 11:19, Kever Yang wrote:
>>> Hi Quentin,
>>>
>>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>
>>>> Rockchip SoCs have some jtag/sdmmc autoswitching that simply doesn't
>>>> work really well.[00] The Linux kernel disables it for all SoCs[01], so
>>>> U-Boot needs to do the same in order to fix issues related to SD 
>>>> card on
>>>> RK3588. This autoswitching is enabled (by default) via the force_jtag
>>>> bitfield in SYS_GRF_SOC_CON6 in the TRM part1.
>>>>
>>>> For some reason, when booting from SD card, the BootROM does mux the
>>>> SDMMC controller in the proper configuration for the RK3588-Jaguar. But
>>>> when we don't boot from SD card, U-Boot needs to set it up correctly to
>>>> allow accessing SD cards in that configuration.
>>>
>>> Could you share what's the really issue you met in your board?
>>>
>>
>> I revert the patch and then I have the following when booting from eMMC:
>>
>> """
>> DDR V1.11 f1474cf52f cym 23/05/09-11:02:36
>> LPDDR4X, 2112MHz
>> channel[0] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
>> channel[1] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
>> channel[2] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
>> channel[3] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
>> Manufacturer ID:0x1
>> CH0 RX Vref:27.1%, TX Vref:21.8%,0.0%
>> CH1 RX Vref:30.1%, TX Vref:20.8%,0.0%
>> CH2 RX Vref:27.9%, TX Vref:21.8%,0.0%
>> CH3 RX Vref:31.4%, TX Vref:19.8%,0.0%
>> change to F1: 528MHz
>> change to F2: 1068MHz
>> change to F3: 1560MHz
>> change to F0: 2112MHz
>> out
>>
>> U-Boot SPL 2024.01-00344-gf1fab3b9557 (Jan 24 2024 - 11:33:43 +0100)
>> Trying to boot from MMC1
>> ## Checking hash(es) for config config-1 ... OK
>> ## Checking hash(es) for Image atf-1 ... sha256+ OK
>> ## Checking hash(es) for Image u-boot ... sha256+ OK
>> ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>> ## Checking hash(es) for Image atf-2 ... sha256+ OK
>> ## Checking hash(es) for Image atf-3 ... sha256+ OK
>> INFO:    Preloader serial: 2
>> NOTICE:  BL31: v2.3():v2.3-589-g3389cfdda:derrick.huang
>> NOTICE:  BL31: Built : 10:14:29, May  9 2023
>> INFO:    spec: 0x1
>> INFO:    ext 32k is not valid
>> INFO:    ddr: stride-en 4CH
>> INFO:    GICv3 without legacy support detected.
>> INFO:    ARM GICv3 driver initialized in EL3
>> INFO:    valid_cpu_msk=0xff bcore0_rst = 0x0, bcore1_rst = 0x0
>> INFO:    system boots from cpu-hwid-0
>> INFO:    idle_st=0x21fff, pd_st=0x11fff9, repair_st=0xfff70001
>> INFO:    dfs DDR fsp_params[0].freq_mhz= 2112MHz
>> INFO:    dfs DDR fsp_params[1].freq_mhz= 528MHz
>> INFO:    dfs DDR fsp_params[2].freq_mhz= 1068MHz
>> INFO:    dfs DDR fsp_params[3].freq_mhz= 1560MHz
>> INFO:    BL31: Initialising Exception Handling Framework
>> INFO:    BL31: Initializing runtime services
>> WARNING: No OPTEE provided by BL2 boot loader, Booting device without 
>> OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
>> ERROR:   Error initializing runtime service opteed_fast
>> INFO:    BL31: Preparing for EL3 exit to normal world
>> INFO:    Entry point address = 0xa00000
>> INFO:    SPSR = 0x3c9
>>
>>
>> U-Boot 2024.01-00344-gf1fab3b9557 (Jan 24 2024 - 11:33:43 +0100)
>>
>> Model: Theobroma Systems RK3588-SBC Jaguar
>> DRAM:  4 GiB (effective 3.7 GiB)
>> Core:  327 devices, 26 uclasses, devicetree: separate
>> MMC:   mmc@fe2c0000: 1, mmc@fe2e0000: 0
>> Loading Environment from MMC... *** Warning - bad CRC, using default 
>> environment
>>
>> In:    serial@feb50000
>> Out:   serial@feb50000
>> Err:   serial@feb50000
>> Model: Theobroma Systems RK3588-SBC Jaguar
>> Net:   eth0: ethernet@fe1b0000
>> Hit any key to stop autoboot:  0
>> => mmc dev 1
>> unable to select a mode
>> =>
>> """
>>
>>> The SD card will need to enable SD-DET for SD card function int he 
>>> hardware design,
>>>
>>
>> We do not have an SD-DET on that board, this is not possible (the 
>> connector doesn't support it).
>>
>> SDMMC_DET/GPIO0_A4_u signal is pulled low in HW if left floating (the 
>> state by default since we expose it on an external connector) but we 
>> plan to let customer use it as a GPIO.
> 
> 
> I didn't follow this issue closely in kernel side before, but I would 
> like to know why this happen.
> Is it possible to share the schematic of your board? I want to 
> understand why you didn't use SDMMC_DET for the card slot in hardware 
> design, which always need an IO for driver to detect the card.

We don't have a dedicated CD pin for the SD card connector.

https://www.digikey.com/en/products/detail/molex/0472192001/3044807 is 
the SD card connector we use.

This is allowed by the SD spec, c.f. Table 3-1 : SD Memory Card Pad 
Assignment[1]

"""
1 CD/DAT3(2) I/O/PP(3) Card Detect/Data Line [Bit 3]

2) The extended DAT lines (DAT1-DAT3) are input on power up. They start 
to operate as DAT lines after SET_BUS_WIDTH command. The Host shall keep 
its own DAT1-DAT3 lines in input mode, as well, while they are not used.
3) At power up this line has a 50KOhm pull up enabled in the card. This 
resistor serves two functions Card detection and Mode Selection. For 
Mode Selection, the host can drive the line high or let it be pulled 
high to select SD mode. If the host wants to select SPI mode it should 
drive the line low. For Card detection, the host detects that the line 
is pulled high. This pull-up should be disconnected by the user, during 
regular data transfer, with SET_CLR_CARD_DETECT (ACMD42) command
"""

[1] https://academy.cba.mit.edu/classes/networking_communications/SD/SD.pdf

> What I know is if the SD card using all the IO including SDMMC_DET with 
> its iomux set to sdmmc function, then the force_jtag should work correctly.
> If you only use IO signal other than SDMMC_DET as sdmmc function, and 
> set SDMMC_DET iomux work as GPIO, then yes, you need to disable the 
> force_jtag.
> Since SDMMC_DET in rk3588 is an IO only have one function(not like other 
> GPIOs may have more than 2 functions for choice), this IO can always be 
> used as SDMMC_DET without conflict when the board has SDcard support.
> 

We don't use SDMMC_DET for card detection, but in GPIO mode **and** we 
cannot use SDMMC_DET for card detection because the connector doesn't 
expose a card detect pin.

We just use broken-cd; property (c.f. 
https://elixir.bootlin.com/linux/v6.8-rc1/source/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts#L402) 
to do polling for card detect in the kernel, but we wouldn't mind too 
much if there's no detection for the SD card anyway as it is cumbersome 
to replace the SD card (which is the purpose of this connector, it needs 
be extra secure since the board is supposed to be used in moving robots) 
so not much of a use-case to detect an insertion/removal at runtime.

Cheers,
Quentin
