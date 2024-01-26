Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8608CC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 10:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A5087BFD;
	Fri, 26 Jan 2024 11:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Cp+Yj7ih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF1987BF2; Fri, 26 Jan 2024 11:37:14 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B221E87BAD
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 11:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGu5F7hbIlWOvgfzqI5ZYBRJVfZhkoAHdV6XtpwNbAdOrZ0rOvlb242k4rV7w+RWwfK42CyPmX7KmWIgzrEDpoJ17ulIZDAkmJRTNoStAtvjaOD+t7pfuRHuDIkYCpG4c33EH/R/qdqLvs8o3qNcLpoAWGTDRHMJ4nc+WIsur4L0a37toEOljRxJe5SDoGMBvk9O3UaVP8DSZ6S8fUGZLJqjqbIIq/UGmDUUnNMtgjMVrcOaNYQj4JzXlIuUtrzE4ejuDyebu2jfOyWQW4P7YVW5C3M00ZqLiz7GLIxCVydeXPm18LH8qU4t2pnHGO/hwD3YN8HE+dmYx4ItXbhgeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdin0WOMPIV7MZYic4S2wgZDI/edTSWfMmPDQ9nSGXM=;
 b=cVbKtNIixPR9bmtjx6Ero1dttbvCu7X/49Uv0I7gbfJB0INzO//T/BJCyI+IURZLwbZery2eUb1O6ulQhKTHKtK3GkCKRrzjnFwJw7gmmkqwvj5pHrdkNXrxvf9Jz1Pi4U0QHb6KpdwXALxM8qsWQMRKqt4Pak/oF/uwXTV3BzUQoIMriWohTDaIRgVF02/5rqNOg8AM0lDzi2k3L5jg+HqpLIOXeLYsnheGESlexbq9ol5ZLBdykYEynrrCrHg2fOsHmCSgEFsABzKx027Jy/ks28DFusz3xg31MV9GQlav/2E6eWudgs/mnuy48gHRRNLAbzz2Rv4aY4LsPVuiYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdin0WOMPIV7MZYic4S2wgZDI/edTSWfMmPDQ9nSGXM=;
 b=Cp+Yj7ihAUrUfIiebArmg8Q8dPRwxZtqMV4o24l3B5DawVuxftrX7SV1EcDRb50RNLv0mpl4fgc7t1LUmhS4kn4XtRIBtccU75M9cxdpri/4nHXjp6MENGH1ZDn2WpYNsPS/HdQylB5jvWSb+DQI7knIn1OvuWOv3P5PeyU4w2+v2cQyEXI/7DyG1sNzDuKusYqWY7Jg9tZim00PFT4Wej/jR40ahMvp9UkZgnjKtZ5aBEIySwHxzjj3VWL1Zv6JGnNDG4qPig7VfFAL0c+ZSwp9MNcs27/g846aofSe0FPTgncCKbebnQ7gGnKHdtkjCVbyC5ryKxqzCwsWrYhKBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS4PR04MB9482.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 10:37:09 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 10:37:08 +0000
Message-ID: <82b8fd76-8a84-4253-93b0-bf1bde85121b@theobroma-systems.com>
Date: Fri, 26 Jan 2024 11:37:06 +0100
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
 <2f6e9491-9ae1-498c-b269-c0a8fbe27552@theobroma-systems.com>
 <609c74a8-80b0-48a2-ae0a-78264014accd@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <609c74a8-80b0-48a2-ae0a-78264014accd@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS4PR04MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: fe50249a-8c24-480f-5ca6-08dc1e5abf67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAoYeVdu2qeuOywo5lq4HxSYtxYV4ssSlJAwza0Ea0183OFFhqDv5rKhv9+sXDqPVOl9v27owLb5IQR+tn3cPwg8FhbzJzPtqBPv1Dbe6j9ZhK7UAMplAG/8SncsBz9dKrlELR4JE2BGNR0Pc8Fs7ibO7j5482QPm0u80VdATCMHrMTS1u12utHVENOrbwHlNaPyW2/o+xOX9HcYdV10uD1z0z9HX2OtyuYxcAZq32fXPIqL/g7dt6FfDGyvbVURu4vUaCVtgsTztsUMjx/GRTSmK2mZOlpLSUtxdvS3vFjJNwNp9gN0j7TrykQSJzqUlCaoZ4Uu1JhMZmJ3CJm5msFvsdgaqGx2sdxrnWl+SNRyDZbzjJzx8TbK9U9kusIPhlnnA+i6aBUxUclWXq6q7j97x8P40wmYqTVd2VTpoxE7zL+PdsspzrNgUXrInVu0OZ2Yg5TtEYWNwwBPW3YKWj+jKwiezecb6hnnbbaXL7/IMT16N8fEVgg3IiFv/TItQjS8s+g5OdQObZFEOsH4VmPy/UYBgplgy824RbNAPyY4QDoYP2Zrg1JjBef0GGZoIOktC+qgnpwkvWeTynH7ZDRgvUrYn91oqXYGXFxXumc8z9Jgt8MQiEXjkHncjY+UtMkAKz0Hf+i4zA0GOWmqo2q68tS4tGiHsQkWgurTnIDFtYgEL6MUxYy7vEAWANWB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39850400004)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(31696002)(36756003)(44832011)(2906002)(66476007)(30864003)(66946007)(66556008)(86362001)(31686004)(8936002)(316002)(38100700002)(4326008)(110136005)(8676002)(41300700001)(83380400001)(45080400002)(966005)(478600001)(6486002)(2616005)(6512007)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2w1OUQxSEFUK2FwNnpUSFZhQmFZRmQySm0xVDBiUEZFUUdodktnVCs0cWJw?=
 =?utf-8?B?YnE4b2FNWUhHQmJiVHp0dTZWTUsxYlBFSHUxSThLWnFGQlZ3d0cyRldnblBN?=
 =?utf-8?B?SDdqSVpiZjhkRFpydElmSFlQRGsrNGd3TUU5MWZqNmdyd003UXpTYVZTM3VY?=
 =?utf-8?B?c09HSWl4bnJodGMyYTJJc20vNXhDMk1qL2c4cUZ2NThGbUs2QUFBekFPeVo5?=
 =?utf-8?B?MXk5OXdacHRrK1ZWVUc0SjFPbEdZRXNWZXdONmF4L21WWFBxSFV4MzQzdXVW?=
 =?utf-8?B?UjRHY2hETDBnSzlwR3V5Ujk0ekljc25BeHowRjc1WTUxRDhGTjl4MTd0ZFZ6?=
 =?utf-8?B?ZlhmSFl1ZHVOZlFuRmlyRldBemZEOVZ3Y24wY0RLbkx3WHVMTEhnd3JXUGFQ?=
 =?utf-8?B?OWo1b0JFcXkvbVBITFk4b2VGYVIzbTF4MzNyRzR2M25FTGYreEZzSUZEME9L?=
 =?utf-8?B?T1IvMnBQTENtMDBZT3lRNG1tN3c5WFpJTUplaVR0VzBPRVpIcmoyU1FHRUFP?=
 =?utf-8?B?aGxPbmtuNkxCNXMrV0hNeXlmeGQxZFlwK2p2dHowSEZoREthTFZTNHRXYnlp?=
 =?utf-8?B?RXRicXBRSkQ2V1kwb1ZBREpOQ3R3YXhZVWJjT3hLRVB3OFFGUE9tSzNjbnZ4?=
 =?utf-8?B?bEM3Y0JQSmdzM0NzaHJ6bkJOT1IrbVV4ZjBreG55a0ZJZlcrcVIzaUxlYmNx?=
 =?utf-8?B?ZFZWdG16clRJczVUS3AwakVTZFRiT1BZNUgyRnF0T1hGRzRseGtFK216Y2Ez?=
 =?utf-8?B?SmRQTjR5TEJyZlFuMXFGUTZIYk51bEV5Rk1Na0k2ZjhXSC9VQ3U5cnhvWU45?=
 =?utf-8?B?N245bGlGcEp1VkZFVVh2NWNYelpJcGNjVVV3RUtPU3Jnb0MwWE9NeHZpSGt3?=
 =?utf-8?B?NzVUaE9NMUkzNlE2akk4WFpoMUlucTJxeXVldlZQNlNLbFlPYzBtc2NxOEpR?=
 =?utf-8?B?RUwrNkpDZEpPbTlpMU5SYXZsSkVuRk5GeUxGcm5VN2tyMnNYTVZzcFFhL1FZ?=
 =?utf-8?B?T0tMWHFDN3VaQ0RCSFZ3L1NuRjVhMTI3YjhYelFTUVREM0t0djRBODJJQ2hK?=
 =?utf-8?B?UjRFQ3Fod1M3SmtlOVhxUVdlejZaWndHT3c5bDNLVm03ZTU1RHNTOUhiR1oy?=
 =?utf-8?B?SGhDTzYzenJtQjErT09pWkhiTmhaRFVVYm5SYlZ6WDJ2SGFNbGdNWHc2Mnow?=
 =?utf-8?B?RnJpMUJRVjRTSzNvTzh5ak01QzZaODBvcVVHcDRqb1BGcGJkRnF5NlRCbVZ4?=
 =?utf-8?B?TGUxZ0VYU0Z1RmpMUTc0K1ZBc0tUSWd1S1RRcVNXazRURUlzNFNKU2taWEEr?=
 =?utf-8?B?WnVkdXBuVzRMY01jMTI2NDRiZTIvRlZZdDdValZRVGJsVzh2aXBRMUVVVCtX?=
 =?utf-8?B?OGZKeXM3aG1uYzZBZkVad1JBUy9scE1PMWltbitURzB2b2pPZENGNlBTQ1h1?=
 =?utf-8?B?R0FnOUlJY0ltWGtPTUxSWHdrdXgzWXlEc1lHNDJYalA2Y2I0K3BIa0NGeThp?=
 =?utf-8?B?V1RYMGV5S01xWk1wVU9raGR0cTloWkFNbTN3VmMyMExLdExWM3ZqMFZCSFZQ?=
 =?utf-8?B?L1ZIV0JMZEhxVkdsTlVRWkNZeUFKajlPZ24xK1Z3V09PTVRpN2JLRk9HbDUv?=
 =?utf-8?B?NnNTVmhUVjNwd2lJRW9IZTZqS0xUUzl0bVAzQ25wT2tYanlnZVdtZmErb3Nk?=
 =?utf-8?B?RE9QNjVFNkFyN1kwdWlWM3lJSFV0ejk5NjJ3WjVHQ2g1czVvUktPTjVENHRo?=
 =?utf-8?B?a3paTmwrZHZOcFpORzNod0lFbXhPYldmc011U1c3N0o2YXNHWWhlSThqR2Rl?=
 =?utf-8?B?cXY0azhQTGpMaXdqSWlJYVVsc1ZFdHR5YTYzWVZ6WFRqOHNNVlBwc0dXbFZ4?=
 =?utf-8?B?bmNzQm5zNUZaREJpSUFZQmkvNnRaRHhSOWxWaVN0UGc4VGN0K1hkaHYvclNX?=
 =?utf-8?B?Ylc1YjFxa1Y5d0xGUjB1NzNiN2M1ODRVVWluZi9ZRUV4REhOWmZUaWFaZUt5?=
 =?utf-8?B?M2FlTlo3TlphV241NDQ0aHlwSjRGWlRubU0xMzc2TU53bjZjTHRxMkN1VXdz?=
 =?utf-8?B?WWRrck9KZG9kWGZJZVMyd29ORE1CNjR0MUVCRkplUmlsaDJBdTZVUVFHUEJo?=
 =?utf-8?B?bjVNdGlRV2NBNVNkdlBBVFJsY1VtaklpREs1bk1rcVRXZ0pFcitoYkdxK1g0?=
 =?utf-8?B?TUhVeVMwUVdldzJtNWR3MDNkVyszU1h3eHRpamhMVFJRalp3RFYybmNzTXpM?=
 =?utf-8?B?OVc3SGtrdHRKUERtYjlDaytVRlJRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe50249a-8c24-480f-5ca6-08dc1e5abf67
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 10:37:08.8603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljTF0JMO4hYOoYv/YwaqbY5/4dgFNd/PW2ALSXHPW4k9yWESnIK6tiPZN3FOm9jLdnh18SQ2etWCABMeCE6o1+psi8uhUqx3b+WBYhiJlYx7CkdD5DmIXeO8D02O++6b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9482
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

On 1/26/24 03:57, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/1/25 19:02, Quentin Schulz wrote:
>> Hi Kever,
>>
>> On 1/25/24 11:29, Kever Yang wrote:
>>> Hi Quentin,
>>>
>>> On 2024/1/24 18:50, Quentin Schulz wrote:
>>>> Hi Kever,
>>>>
>>>> On 1/24/24 11:19, Kever Yang wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>>>
>>>>>> Rockchip SoCs have some jtag/sdmmc autoswitching that simply doesn't
>>>>>> work really well.[00] The Linux kernel disables it for all 
>>>>>> SoCs[01], so
>>>>>> U-Boot needs to do the same in order to fix issues related to SD 
>>>>>> card on
>>>>>> RK3588. This autoswitching is enabled (by default) via the force_jtag
>>>>>> bitfield in SYS_GRF_SOC_CON6 in the TRM part1.
>>>>>>
>>>>>> For some reason, when booting from SD card, the BootROM does mux the
>>>>>> SDMMC controller in the proper configuration for the 
>>>>>> RK3588-Jaguar. But
>>>>>> when we don't boot from SD card, U-Boot needs to set it up 
>>>>>> correctly to
>>>>>> allow accessing SD cards in that configuration.
>>>>>
>>>>> Could you share what's the really issue you met in your board?
>>>>>
>>>>
>>>> I revert the patch and then I have the following when booting from 
>>>> eMMC:
>>>>
>>>> """
>>>> DDR V1.11 f1474cf52f cym 23/05/09-11:02:36
>>>> LPDDR4X, 2112MHz
>>>> channel[0] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
>>>> channel[1] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
>>>> channel[2] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
>>>> channel[3] BW=16 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=1024MB
>>>> Manufacturer ID:0x1
>>>> CH0 RX Vref:27.1%, TX Vref:21.8%,0.0%
>>>> CH1 RX Vref:30.1%, TX Vref:20.8%,0.0%
>>>> CH2 RX Vref:27.9%, TX Vref:21.8%,0.0%
>>>> CH3 RX Vref:31.4%, TX Vref:19.8%,0.0%
>>>> change to F1: 528MHz
>>>> change to F2: 1068MHz
>>>> change to F3: 1560MHz
>>>> change to F0: 2112MHz
>>>> out
>>>>
>>>> U-Boot SPL 2024.01-00344-gf1fab3b9557 (Jan 24 2024 - 11:33:43 +0100)
>>>> Trying to boot from MMC1
>>>> ## Checking hash(es) for config config-1 ... OK
>>>> ## Checking hash(es) for Image atf-1 ... sha256+ OK
>>>> ## Checking hash(es) for Image u-boot ... sha256+ OK
>>>> ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>>>> ## Checking hash(es) for Image atf-2 ... sha256+ OK
>>>> ## Checking hash(es) for Image atf-3 ... sha256+ OK
>>>> INFO:    Preloader serial: 2
>>>> NOTICE:  BL31: v2.3():v2.3-589-g3389cfdda:derrick.huang
>>>> NOTICE:  BL31: Built : 10:14:29, May  9 2023
>>>> INFO:    spec: 0x1
>>>> INFO:    ext 32k is not valid
>>>> INFO:    ddr: stride-en 4CH
>>>> INFO:    GICv3 without legacy support detected.
>>>> INFO:    ARM GICv3 driver initialized in EL3
>>>> INFO:    valid_cpu_msk=0xff bcore0_rst = 0x0, bcore1_rst = 0x0
>>>> INFO:    system boots from cpu-hwid-0
>>>> INFO:    idle_st=0x21fff, pd_st=0x11fff9, repair_st=0xfff70001
>>>> INFO:    dfs DDR fsp_params[0].freq_mhz= 2112MHz
>>>> INFO:    dfs DDR fsp_params[1].freq_mhz= 528MHz
>>>> INFO:    dfs DDR fsp_params[2].freq_mhz= 1068MHz
>>>> INFO:    dfs DDR fsp_params[3].freq_mhz= 1560MHz
>>>> INFO:    BL31: Initialising Exception Handling Framework
>>>> INFO:    BL31: Initializing runtime services
>>>> WARNING: No OPTEE provided by BL2 boot loader, Booting device 
>>>> without OPTEE initialization. SMC`s destined for OPTEE will return 
>>>> SMC_UNK
>>>> ERROR:   Error initializing runtime service opteed_fast
>>>> INFO:    BL31: Preparing for EL3 exit to normal world
>>>> INFO:    Entry point address = 0xa00000
>>>> INFO:    SPSR = 0x3c9
>>>>
>>>>
>>>> U-Boot 2024.01-00344-gf1fab3b9557 (Jan 24 2024 - 11:33:43 +0100)
>>>>
>>>> Model: Theobroma Systems RK3588-SBC Jaguar
>>>> DRAM:  4 GiB (effective 3.7 GiB)
>>>> Core:  327 devices, 26 uclasses, devicetree: separate
>>>> MMC:   mmc@fe2c0000: 1, mmc@fe2e0000: 0
>>>> Loading Environment from MMC... *** Warning - bad CRC, using default 
>>>> environment
>>>>
>>>> In:    serial@feb50000
>>>> Out:   serial@feb50000
>>>> Err:   serial@feb50000
>>>> Model: Theobroma Systems RK3588-SBC Jaguar
>>>> Net:   eth0: ethernet@fe1b0000
>>>> Hit any key to stop autoboot:  0
>>>> => mmc dev 1
>>>> unable to select a mode
>>>> =>
>>>> """
>>>>
>>>>> The SD card will need to enable SD-DET for SD card function int he 
>>>>> hardware design,
>>>>>
>>>>
>>>> We do not have an SD-DET on that board, this is not possible (the 
>>>> connector doesn't support it).
>>>>
>>>> SDMMC_DET/GPIO0_A4_u signal is pulled low in HW if left floating 
>>>> (the state by default since we expose it on an external connector) 
>>>> but we plan to let customer use it as a GPIO.
>>>
>>>
>>> I didn't follow this issue closely in kernel side before, but I would 
>>> like to know why this happen.
>>> Is it possible to share the schematic of your board? I want to 
>>> understand why you didn't use SDMMC_DET for the card slot in hardware 
>>> design, which always need an IO for driver to detect the card.
>>
>> We don't have a dedicated CD pin for the SD card connector.
>>
>> https://www.digikey.com/en/products/detail/molex/0472192001/3044807 is the SD card connector we use.
> 
> Thanks for your information, but I think you are using the wrong microSD 
> connector for rk3588 and maybe also for other rockchip SoCs.
> Here are four microSD card connector from the web you provide, all of 
> them have card detect signal available for pcb:
> https://www.digikey.com/en/product-highlight/m/molex-connector/sd-memory-card-connectors

None of those fit our requirements. We need a safe system that doesn't 
break because of vibrations or shocks. Push-pull connectors are out of 
question for our design. We have had issues with our Q7 devkit with 
push-pull connector with SD cards slightly smaller or inserted somewhat 
the wrong way. I can recall also countless of discussions in the early 
days of the Raspberry Pis where there were a lot of issues related to SD 
cards.

This is basically the mechanism we are using 
https://media.distrelec.com/Web/WebShopImages/landscape_large/4-/01/Molex-500901-0801-30161714-01.jpg

I can admit on our pictures of Jaguar and on the Digikey link I provided 
earlier that it is not clear it is THAT kind of connector and not a 
push-pull one.

Also.... It works just fine in Linux kernel with broken-cd and in U-Boot 
with this patch, sooooooo I don't think it is "the wrong microSD 
connector for rk3588 and maybe also for other rockchip SoCs." :)

>>
>> This is allowed by the SD spec, c.f. Table 3-1 : SD Memory Card Pad 
>> Assignment[1]
>>
>> """
>> 1 CD/DAT3(2) I/O/PP(3) Card Detect/Data Line [Bit 3]
>>
>> 2) The extended DAT lines (DAT1-DAT3) are input on power up. They 
>> start to operate as DAT lines after SET_BUS_WIDTH command. The Host 
>> shall keep its own DAT1-DAT3 lines in input mode, as well, while they 
>> are not used.
>> 3) At power up this line has a 50KOhm pull up enabled in the card. 
>> This resistor serves two functions Card detection and Mode Selection. 
>> For Mode Selection, the host can drive the line high or let it be 
>> pulled high to select SD mode. If the host wants to select SPI mode it 
>> should drive the line low. For Card detection, the host detects that 
>> the line is pulled high. This pull-up should be disconnected by the 
>> user, during regular data transfer, with SET_CLR_CARD_DETECT (ACMD42) 
>> command
>> """
> 
> Yes, you are right for the SD spec, there is another design for Card 
> detection, which need the controller
> supports SET_CLR_CARD_DETECT command, and like many other SoCs, rk3588 
> does not support it.

Thanks for the confirmation, I indeed hadn't found anything in the TRM 
for it... which is fine, we are not expecting it anyway, we use 
broken-cd; for it now.

My understanding is that only if none of broken-cd, cd-gpios or 
non-removable are passed that this kind of card detect mechanism is 
used. I don't think I should have given this information, as this is not 
what we're using, so I may have introduced confusing information into 
the discussion, sorry.

In U-Boot, broken-cd means that we assume the card is always present.

In the Linux kernel, as far as I could tell, the check is done with 
mmc_sd_detect() which calls _mmc_detect_card_removed() which calls 
host->bus_ops->alive() which is mmc_sd_alive() which sends CMD_13 to the 
SD card. It'll wait for the command to return, which it won't if the 
card isn't present, thus detecting card presence. The implementation of 
the CMD13 command is required by the spec.

According to the SD spec:
"""
The host may poll the status of the card with a SEND_STATUS command 
(CMD13) at any time, and the card will respond with
its status.
"""

So this is perfectly fine for using SD cards on a system without a CD 
pin and without relying on the DAT3 pin to be used as CD pin (which 
Rockchip SoCs - at least RK3588 - doesn't support).

> Only RTS5208(a Realtek PCI-E Card Reader) supports this command when I 
> search this cmd in kernel code.
> 
> Back to this patch, I think it would be better to turn off the 
> force_jtag in board level instead of soc level for now.
> 

I strongly disagree with this. This is making the bring-up of boards 
unnecessarily complex. I'm lucky I'm working with Heiko who encountered 
this issue years ago and remembered some funny things happening with the 
force_jtag feature, otherwise it'd have taken me much longer to figure 
all this out.

What is the benefit for keeping force_jtag enabled? Especially since the 
kernel has disabled it for almost a decade already? In my opinion this 
is a debugging feature, if you need it you can enable it again by 
removing this line or writing to the register manually. And this would 
make it even more explicit that such a feature exist because there is 
now some comment for it.

Cheers,
Quentin
