Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4807BC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 11:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F57087996;
	Fri, 26 Jan 2024 12:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="adTjNwNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4348716D; Fri, 26 Jan 2024 12:29:44 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13D6A87996
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 12:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm4KnHJVtlL2mkxavcHY7YDP6AqtRlx78P4cs5eimu+ZEMaTjT8784K0+eaebbv+W14iYLMQOyfQW12ZS8/JTqrdC+wYZUzhC1zEYpiAspyP/Z14X1+fzILmEuF3DLVrQpouRaZIyrW3+0sAVOu9a5cou3SnFM0avMivv38W0ehVAVr9SCO+RS5CG/NBBuPvhhKoXYeZ0m2V/R0UVwQnrK7s8ooc8M/Xc6H9FmvN/21ehWgAQUOkS9bhDe+acvjkd/KS9UAPoW9kaG1H2FW+BIMYuTGJ6IysBgBacOWJ8kh7cWvAv10E5tEQH7C6MPMSppRL+n4cuKf8IoElCaIR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO55ZPifzX2uMCW8AZj0ncOKKqQALW+6CeDLXVwBrjo=;
 b=ho3juGTvIE5g5XKun1/PExp0HQlahY4EjN73dibm6BC20AO3IPffZAiIigUpUbUepPMF/MW9nOjtEOroWjzZSSXBwrX4a6qTqO2i4FixGh7U7PH8DrVFkLa6nm4Qn1L2C6AjD0y3hbqQgHO/YgC2hZV6uFpu0jWWs09dawkTF2vPA45ztDdwp/JiPSWdgZxc7J0OawDBKIxHyojXJ34CNc7DXlhyvMmFsPmdoVfr6TOQsLNbSxpEeLEHfa/QBJzPTsFOueJYmxcGTWdpq6mxPhuCgI+bZcc/pQEkZ3keEg9EhRdbxM5Hc4uxV965nAybbePvUm7da/g9YBuhhCuLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO55ZPifzX2uMCW8AZj0ncOKKqQALW+6CeDLXVwBrjo=;
 b=adTjNwNn7kaw2EEhqMJQ8FUlwKZBZSwggNz2Kk0Cdt7LfOvcKKsmLR0H1gKpKEma9lAtB5pbcSoNq+ENLHN3/x29ajbwZTsgPEJERqPnrm1m0Q5WdaxZsO01/Xlatmfy1llbzkpKbTetLY8hn1VEMth5Bh0E5EKqcvOuyI/xvvoJFqiv+mR3RtLWBjvdvG7tz2Absg2P6Ba9nPBk675cIT4RQnI6AWijVpkgcww5qh6yF/LGspAZwPSMYMAEZxLXSUYxI/+DUKUrI+1+e3gZZtL8S6JwYIFX8uuRp1caIjkJdnB8NppRmrF13Nm/9yhcHW9SkKKX6NATf+q63Sh5ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB9517.eurprd04.prod.outlook.com (2603:10a6:102:229::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 11:29:39 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%4]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 11:29:39 +0000
Message-ID: <31404375-a811-459c-b9d6-87333550954a@theobroma-systems.com>
Date: Fri, 26 Jan 2024 12:29:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] rockchip: rk3588: fix non-working SD controller if
 booting from other media
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, =?UTF-8?B?5rSq5oWn5paM?=
 <hhb@rock-chips.com>, heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-13-1eec1c34953c@theobroma-systems.com>
 <10ebfefd-1619-4b08-b15d-ec8ca8e798f3@rock-chips.com>
 <c33d0c58-cd95-490f-9514-8d61e1e70925@theobroma-systems.com>
 <31e7cb6e-7ef1-4069-a38e-b61677a8d76e@rock-chips.com>
 <2f6e9491-9ae1-498c-b269-c0a8fbe27552@theobroma-systems.com>
 <609c74a8-80b0-48a2-ae0a-78264014accd@rock-chips.com>
 <82b8fd76-8a84-4253-93b0-bf1bde85121b@theobroma-systems.com>
 <0a9a81f47864fd566206f5e62c3df192@manjaro.org>
 <daf26efb-888c-4903-b8b1-c6d72556fe9c@theobroma-systems.com>
 <4000d538ec88400f0ceaa9f13b6cd489@manjaro.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <4000d538ec88400f0ceaa9f13b6cd489@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::7) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a3cae68-e0d6-4dc6-dfc9-08dc1e621509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCNJmu5JyqCTBujMAwc5N6qhDirrZDWqZR4d0eeVyYKEHyJQsyMPp34/ekpWS09T25F/Nl1n98WJgdbuAOw59HS0yvpQ2FgwnqrL0OIQtxxUzOHji/J0TxRYXXP528mlK53GnDsBT5JuihunhPufmqt2Lw53s+dcJ6fGSsPYBtQIAL5frypf5s+RsLGfGYOIZQ1tpNZRKuSmaQqNTFNXFS6X+/F7InoTNdyhynnb4kJ4WeDqeXANM0+44xOmn+mr5V6dlA9VRgoHb5O1X4fPqnky0EDGU6r/Lj92Sj6U4f4o1qHwFtlh5cH/ID+K3hDnI/3zdVn4W6wMJL1oeX+uomqmviy5sqbdWny2DUFwiawz1rJTn+zOIADa05aGeSFgDQfvcBfrKC2QUNY5mubqg5GckCS2ulNCtAmaYfmScbVJDakrQkPuVHUG5BquU4Zp4cndrwXx0pLW5aUGyrQQv6vYojKsAS4GaT2e+w77mWbB0Z/4QXxPTu0/MfIrD7TisB6Ce3rOn15i2pwNZ+K7D3xGa53TvXbJ8QyQ38Fs0ZrDJlg7iGjhCAv0AOfGnA71i/GOokL974t3HFUyt8CpMneghVEMk0Je5hw5WBNy1InTYlvA0rgbxPe9RlCaltc4qJpqgP1dc7PZgDF51L/1FfC+o14IFeeI7ACd/UcRDRUWc2Ac1Wo43jH6sMKzeS47
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(366004)(39850400004)(136003)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(45080400002)(53546011)(6512007)(6666004)(6506007)(86362001)(2616005)(6486002)(966005)(83380400001)(478600001)(31686004)(36756003)(8936002)(8676002)(316002)(6916009)(66556008)(31696002)(54906003)(66946007)(5660300002)(7416002)(2906002)(66476007)(38100700002)(4326008)(41300700001)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZGTTg5R2pQd0xuREYrVS9KUUxvOGpVMEtFNitjaXBNcUYrUjJVSUpZVkQv?=
 =?utf-8?B?cVFvaTV3Qmk0Zk4xa2tVSGVlYmlWeTNGb29lN1hIc1k2bUZWcVVSMU96ZE5p?=
 =?utf-8?B?OW5uN3dBL0pISnMySzdpMk45R3NQRWhYVHczNloxUnFiZGhDZDN4SkFXdms2?=
 =?utf-8?B?YlljOWszdWwwMHA4elV2b3hBSmRjSm9YS2pzVllwbDd0dWxPMXh3R3pEd1Zt?=
 =?utf-8?B?UHZNOUZTYXdkNnF1Zm9WOXpNalNYM0lZQzE2a3B3SVBjR0JMenpMbmhVTzlx?=
 =?utf-8?B?NGx1NEZXT2kzYThEcWk5NEZiK3AzQStjRXpwQkxnd0tYb0RWUFBwdEhTeEFY?=
 =?utf-8?B?Yi9xQ1lCaXRCeHdOdkZGbEJrTVBaNURWM0U2M25XMVprYTVsdWtUL2lBL0Zo?=
 =?utf-8?B?Y1pnck9TeVY1ODhqSkhEa2hzYlJyVkNoSGJjakU5aHlxM1krS1dPNjdodWVH?=
 =?utf-8?B?MVVwRGZXQUQzMUJjUE9LS3lUQjhhZG5GVGhudEwybW5sYTQ0bmZlMkdDdndK?=
 =?utf-8?B?TWw2aTdITHdkVGFLKytaclV4Z2NVZjZKdFNuN09LK3NraVB3N1NyVDZCQmxO?=
 =?utf-8?B?bitzRGNQYVZvTThlN25BT2tER2VSRHJGNDNZTzlINEo3VzFQdlBKT0hKL1Js?=
 =?utf-8?B?SUNRZW50NHpTZGRBNjlEd2Q0eUpTb2dHU3RLM1JzZ2NxSVZrajVwM08xelNw?=
 =?utf-8?B?UHZSMngvNjZqcnFCeUZKZnZ0eWovRWx0emZNZlI2eVUrdjh6aE5iWTI1MWl0?=
 =?utf-8?B?bHlZOTZ2UGFGODg0cjBMMTFzOFY2SnA0ZXU4Tk9BcCtuVzZMRTJpT2hXSnh1?=
 =?utf-8?B?dTdqUXRpTFRrblZ5QnVmT2J4YUFnR1NRTktxL3ZnTlB1VzYwRW9PdVNuWUU4?=
 =?utf-8?B?Wit4SmZidFQwb2hqdjFVN3locWY3OUNubWpNQ09HdmNhVmdlSkV5Z3dxMUVK?=
 =?utf-8?B?WUhlN3B5UVVpY01Pb1U4K05RVG16VUMzSXZ1THZXVWNJZnlXaUtDMmtZNGlI?=
 =?utf-8?B?UG9VYm56V2txaVpsMDlFR3pVRWhhdmpGNmJuUWswQTBkR0RnVkt2eVpma1ZN?=
 =?utf-8?B?ZEhFTmF2YWczYzVPaTExWEJ5UFllb1FYcGVoSDBqK2s4dkpEa25EYnV6N2pj?=
 =?utf-8?B?TlV1NWVMVU16NkIzL0V0clZTdVBFUmVCT3BVTHpVVkc5bGVkT1FIdUVaMXZa?=
 =?utf-8?B?VDI5eDAyTDVMc1NJUnhocHBoeWNYbkZVVVpkMC90ZlNHbHF4TUUxd1p4enFz?=
 =?utf-8?B?a3B6RXN4azluRmx0L3FrRlFyS2tidjIrUEdjZnhIcFR4bjR4VHpBMUZjQjR0?=
 =?utf-8?B?M3pwcjF6L0Y4THl1RnRqTGZscVd2VXZNaUEzNjRibVpUMDhlUW1QY3dtMmRr?=
 =?utf-8?B?dUJhY1pNU2NqSUdlQkIvdVlHN0VFSCs2alJucjRVRXpWSFdFM0dLbC85dmRt?=
 =?utf-8?B?KzVNUTJ1UHNGa2ZsSnBpV016azdmZVBNaTZpaC9zWjZkR2tkblpOMGxxeWx1?=
 =?utf-8?B?MjVndldoRzZZbC9WQytneU5iWmtCU1ArUkptRm4rcXVIblJISHpwamg0YkU2?=
 =?utf-8?B?Y3VPY20rQnk5QmJ4eXpPcXJNS2huNmVFT2dQczgxRUxNeXJvTUJWWGZ5ZmtM?=
 =?utf-8?B?aTllMmRVbVcxQ3RNWElUOGpLUWlmMzVVK241TVVRWHdFdDVhSWlXaS9mbVNQ?=
 =?utf-8?B?NDlhSXJDTjkzUUpSSGp2ci9IUGhEVEFIeER1TXhvMGI3RWlMSmdPQnp6OURU?=
 =?utf-8?B?V1VOVnJDeVgzNlV0RFd3ems4M3ZrSnE1OTYvNjE1TTZrVGdWcVN1MG5TUjIr?=
 =?utf-8?B?MldRVUJpUC81NzdpdVRwemc2Z3F0a0wyQkR4OEVIM1hsRzFmb1lEd3FkUVFK?=
 =?utf-8?B?Q3JaRHU5aHZhM1N4MmJ0L3c5dDBia3lnbk1QUGN0dFgyYXVNenJ5RmxBRFNO?=
 =?utf-8?B?OHA3QVBrZ2NHbUJlaHFMNEtJbWtXRVNEUGVZZzJubzlZdkhUcG8rVmhXRXdS?=
 =?utf-8?B?QW5jaGFENHNMYmJoZXhmM2dVQUMramJyMFhWYkVrcjN6eHpGQ0VDRjc2SVdP?=
 =?utf-8?B?NGRlQTh5cGgyMnFyMk5MTEZJQ0s4eUZSMXNNSGpPN3dxRjZ1SkZTc0Mwak5O?=
 =?utf-8?B?UCsxYmxSMG5QRHQxdDI4QVJpakVpQzZibUJEN1ZmOVJ3Zy94OHhYek1sN3V5?=
 =?utf-8?B?RnF1TTl6R3pKWE5PTjBOMy9yanJCTnZmZVh4YXhtdU9lQ1VqNk1kTEFtV3da?=
 =?utf-8?B?bXBUbnRKQll2dGpnc052anphY0d3PT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3cae68-e0d6-4dc6-dfc9-08dc1e621509
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 11:29:39.3542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2o2gyoUv9wLOyjQFfmsG/oDGQv8WZpgAESSQeYa4uGJ57wTNGeAJkuYJCsQMy1gjAK5DJyyA5ToIQXdwfIU5UWuweZ6B+8UllEU3d8A8kTbzMBBHAj7Y4uqMPy1we/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9517
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

On 1/26/24 12:24, Dragan Simic wrote:
> [Some people who received this message don't often get email from 
> dsimic@manjaro.org. Learn why this is important at 
> https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 2024-01-26 12:09, Quentin Schulz wrote:
>> On 1/26/24 12:04, Dragan Simic wrote:
>>> On 2024-01-26 11:37, Quentin Schulz wrote:
>>>> On 1/26/24 03:57, Kever Yang wrote:
>>>>> On 2024/1/25 19:02, Quentin Schulz wrote:
>>>>>> We don't have a dedicated CD pin for the SD card connector.
>>>>>> https://www.digikey.com/en/products/detail/molex/0472192001/3044807
>>>>>> is the SD card connector we use.
>>>>>
>>>>> Thanks for your information, but I think you are using the wrong
>>>>> microSD connector for rk3588 and maybe also for other rockchip SoCs.
>>>>> Here are four microSD card connector from the web you provide, all
>>>>> of
>>>>> them have card detect signal available for pcb:
>>>>> https://www.digikey.com/en/product-highlight/m/molex-connector/sd-memory-card-connectors
>>>>
>>>> None of those fit our requirements. We need a safe system that
>>>> doesn't
>>>> break because of vibrations or shocks. Push-pull connectors are out
>>>> of
>>>> question for our design. We have had issues with our Q7 devkit with
>>>> push-pull connector with SD cards slightly smaller or inserted
>>>> somewhat the wrong way. I can recall also countless of discussions in
>>>> the early days of the Raspberry Pis where there were a lot of issues
>>>> related to SD cards.
>>>>
>>>> This is basically the mechanism we are using
>>>> https://media.distrelec.com/Web/WebShopImages/landscape_large/4-/01/Molex-500901-0801-30161714-01.jpg
>>>
>>> Please, allow me to interject...  I'm really curious why don't you
>>> use eMMC chips instead of microSD cards?  I mean, if the reliability
>>> is of utmost importance, I wouldn't even consider microSD cards, not
>>> even the high-endurance variants.
>>
>> We have both :)
> 
> Ah, I see. :)  Perhaps my question wasn't precise enough;  actually,
> now I'd like to know what do you use as the primary storage for the
> operating system installation -- eMMC chip or microSD cards?  Is the
> eMMC chip soldered?  I'm just curious. :)
> 

Soldered eMMC is the primary (expected) storage. If both eMMC and SD 
card are inserted and properly flashed, it'll boot from eMMC except if 
the BIOS button is pressed, in which case SD card will be selected 
instead. If SD card is missing/improperly flashed, it'll boot into USB 
flashing mode (rkdeveloptool/rockusb) if the BIOS button is pressed 
(similar to when no storage media is properly flashed).
