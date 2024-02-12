Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEC4C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 09:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6519E87C71;
	Mon, 12 Feb 2024 10:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="HSEQ9yRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E3587C93; Mon, 12 Feb 2024 10:26:29 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230DF87BED
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 10:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeVN8ajwPDGO8clomruYZNcZYhZBEWj9mtppTVaC4ssXL3TlYjCFFyCEmdcbruNwRto00G8bSVk49awCiYStxe09B5AOt2A6CjAJ5H1FxHk1orsfhy38E/cIgPh7UMb/DdjjJ9M9gV2+6MjtdYOra7xRwUbgHZq+ZFdlabI5ORrn8jB+CCm2FXel28I3501I8biSQ3PLLv5RxG1uo9RtDWVzKNUCn89HECEubyDQqh8Bp2Jar0/icoKZyv5VF6NPY4OSglS8A+YrRBrDSp/AtZQTovUXIrtV6zUFYlOdINP92uxtEGMP4x+EeVdiJBbhbTfC5tZH+aAsEbz6KY7E/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTMAS5lgR4c/JBWsF0zn7cOpn+wSXrfSXsEBh83gy4E=;
 b=Sgr4rFO+g0GqoTlvu73gR/aLuDvje38Oq8rwFSYN2lxiTD5luh8QnLKXabkwRG+dFX11jLIP+U3pMVPQOk+YCs3sIVatNkSSruEH4XEZf+/jgk1pQQw9PKr3lxSlXD5rSQH0FuXyfBDRjCTkJRB/ojHlUbg/pml/b9L8V87dQkLfGzriUbynauLUKwDpuMCMxreuJKhAyLFQzfmEhfCot8+sImORHI8xVpd0Bfdj0nTjPJB1txEYV+Z7ftFIbp1pBz6hkyQysF9PUPkoCd+h7iQZoLNzl8+gA7UXtuGPSqQmKaiEnkvr5Nyi0usuV+KikwlfTMydJNiW0zhpeh3vwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTMAS5lgR4c/JBWsF0zn7cOpn+wSXrfSXsEBh83gy4E=;
 b=HSEQ9yRv4ktKHspb2Tt++sd17bN8ex1eAfMt1SyitOR/HMMrNwLyQK1Pgpx/Vw5ASB/RD3+lvzxScW08vfsP2BxXEUvCT3fU+oSEIRwCuGo5AvoO3vBmqTx426A2QzQm5eBi4f/m68rfAeXhQrNRFxiAP3Hh7ssxWi9wh5SdFGf29moA3ij5+CigB04fDp+LuQT0SxQFgQsqv2ES/rDlIKEmiAe1x4/wnBkLBT13qQJQYT5fFzcrZUjVFPATl+ksG2yp9RcKtHLL0e+a+d/mN3hycGcOzfzpyet11NH5NSYWDySfOQA6OMIBiJpjscUVAL98qZ+/oHyDPtaJjUcsJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB9061.eurprd04.prod.outlook.com (2603:10a6:20b:444::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Mon, 12 Feb
 2024 09:26:24 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 09:26:24 +0000
Message-ID: <d09b7525-36a6-4a9e-afe4-074ae2ee363d@theobroma-systems.com>
Date: Mon, 12 Feb 2024 10:26:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] board: rockchip: add Theobroma-Systems RK3588
 Jaguar SBC
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-16-6c9ffe09b924@theobroma-systems.com>
 <0d9cc966-7606-47d8-97eb-8981a8f7558e@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <0d9cc966-7606-47d8-97eb-8981a8f7558e@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB9061:EE_
X-MS-Office365-Filtering-Correlation-Id: 379593ce-8d46-41b0-cf5c-08dc2bacaebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g9MpmHCMZ11/1Sbq38O38MP7uOgG4K3KO5O35PEJ90h73DqMVc/IOnm1qLdIVqXA/YRGK0T64o1AdgAuKWwKxcbx93DNq+TNhS/9KGdhf4nh7JggHYEPIGbIE8TtG01tHrUeTJ+AmSxjSj0Wmp8DOvEZE7P51c62ClA7i2uPwdn4+DiVH0BFQn+F153HptthMq066p31VSfPRmRLANvpt3SB5LHKygJuuDEtbHbBL40EIYQGmHjZnCEWIOPGWzefg93QKoi6TyMVBhx177+Uh8nKA8o+a4n2mn87aWKDswq88lcCddwYVyjx1jxnM0/poDbATqJsk8t3yKT9oBewI74Uv3D7GyH7u5AkE85bv99/DQPZ+YAuT4c2XBTRoZcyZJXGM0wIDci0HNO6mzQj8Q4vhgltTXchLKHw1URXEGdAgv5K6VMl4dKP/hVqxD7qH6d5VoiuOMoX7IoeMg/inXtHOFb8iu81zjpC2gglk0Vv7g6YZPpQ+91sgf0Edbk4ROM8opXpYaa6XJ1Zavmwb5ZczZaCFkvEZhGm+ouVXqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39850400004)(230922051799003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(5660300002)(8936002)(44832011)(4326008)(8676002)(7416002)(83380400001)(2616005)(38100700002)(36756003)(31696002)(86362001)(6666004)(110136005)(316002)(66946007)(66556008)(66476007)(53546011)(6506007)(54906003)(966005)(478600001)(6486002)(6512007)(2906002)(31686004)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdPdjdlUUtZT0g0S1JQWnc4aFZrQkszeVZPNDcvcC9lcWJyTjZSQ0huWU0w?=
 =?utf-8?B?aVluNXYvZGxnSHptNDUvQ2N6bHgzL3lHdDk4WjhYT3E1OHpvbWZWaStjOXJU?=
 =?utf-8?B?UVk1RVJuTVhxUERUUUFEZFl4UEthWm1MRmRya1JYYThIYmM5TDJGRXgrdjFt?=
 =?utf-8?B?VGN4Qm5ldC9LWXBtMFNlak1FVTVwVWQ1ZE9YSlZIanNZc3JRR245dTd6bkZw?=
 =?utf-8?B?R3FSTWlkdVNTMzEwMXkxWGRxbURVSCsrK0lrQXU5cCtBc0o3UGlHT2xkYlNC?=
 =?utf-8?B?ZmlWa0NzVlA5aEloblRwYUxlZDFjMDduNXJldVdUQis2OEljM1gxUEw2a1hZ?=
 =?utf-8?B?d1VCVHV1N3MrcS9LemhBVlI0MkorQlh1YzhOZEQ0Z3BkY05oSzZqNTZ3eVJo?=
 =?utf-8?B?czIzVlREK2FQcTg0MTNvMVhHMVNSeHU1Mjl3M0pCeWZ3QWF4b1FXSGlsVWcv?=
 =?utf-8?B?aDlJSGZJN3V2V01kQkUreHNUT1ZVV2p3S2xESm02NUxYVDZuWGc0TWxtMFY2?=
 =?utf-8?B?Z3JMWGRRWWJxb3hKTktjN1U0V3F5K1lLL1JnNlErdzM4RkxVMmNEd2o2OXVa?=
 =?utf-8?B?TzZTSzcxcUZwSGc2S3ZoOTA4cndabW5iQ2lxYnVwZ2RBK002R0pnK0VHZTRt?=
 =?utf-8?B?UEh0NFcwRGw2ZU5yZXh2ZkJEV0JpSTZod3V1ejBNNHRwNjg2Zkx0K0N0ZGsw?=
 =?utf-8?B?dGR1Yml6U1ZRcndpMy9jdStzb0dVQ2UxRTlsNFN3RjlRWEN0bzIzbE1nUkpZ?=
 =?utf-8?B?SGZ2WmQ4SHVGdExMYi8yYmFzMW9pSGRBbmhmMkZPRjBhWGNacTcyRmdPdVlz?=
 =?utf-8?B?R0ZrVWNDeFZlelRXS1pqbU5ISWNzRVVreDJMVGJZNkRjQXR3d2FlRDAwUHdC?=
 =?utf-8?B?L2JHZThwWnNlTkxYSk4zai84YStYZWJQNllBZnRPOVZkaU02bUEzQlUxSFg4?=
 =?utf-8?B?THpCYnoyOCtWOTl1NU84b2VVcDBwckczOFZ3NEsvRXAxbGJzTHM4NzFFeXQ5?=
 =?utf-8?B?UlQwRkhMRGVUb3FLOHdQa1VBS0NINlBHZVZweEpyd0craElmQkFTSTJhUUUy?=
 =?utf-8?B?R1NDUHZwOFhLcWtCZkttNEdqOE5HY2d3UVJCeGFWOWNmQXBlVkxBd2xQRnda?=
 =?utf-8?B?RTFsc2xyTVBJbncyRWhvMWZldzUyY2g5dWU2Y3dWL29KZUhiR24zWGtxNEdX?=
 =?utf-8?B?cS9wU01MUTh1M0ZHL2toampzWDBwUjB3UmtYL0pRWU40cmdra0VTMUN6bGI2?=
 =?utf-8?B?cUh3eG5yWTR3VW9scmJabTVTQ3ZBUDdJTGYrY0R1TzM5VDdmM3lwN29zbmZn?=
 =?utf-8?B?MzAvSHJQaUVVdEpSMU9TbTBIc3RqMUxRSUdidHJJL1Ivc0dlbHA2akk2a1BK?=
 =?utf-8?B?Z0NwSVpaSUZtMndnUTh3bGE1WFJhaGZzakt5U0Z2R3g4YzVMWndjWkVRN2oz?=
 =?utf-8?B?Z3p1eGJXMXhHOHBSWWZxc01UdDZSVGxkWERTR2h3Y2MwUis3M1p6bXU0WlZa?=
 =?utf-8?B?Q2JONXZ0ZTArZVNaVnIrOGl2eTRoVnRWa2t5dDVDTWphd0VUd3NVTitEdzRo?=
 =?utf-8?B?YXN5M2IzQ05YcmM0OG9kZmdCTjFFd2c2K3o3UFd6ajFhZzYyYXZLNWZBaWRD?=
 =?utf-8?B?eWd2SEdJZWJwTmo3Ti83aFRGRmxsUkkrQ1NkRnhQRUtaVXVLK1cwUFo3dWxR?=
 =?utf-8?B?ZCt2TmtJeW1pWVZIa1JtTFlUcGFTY3JTN0hVS2I2blJ2MzZkemM1OUNjQkFV?=
 =?utf-8?B?R0RFcUJ6SHJrVjhnSkFEWm54Z3RsQXdXK1RXaXB3K2tFNmk4SlAyUU1jU2Ev?=
 =?utf-8?B?ZUVNNjlwZ1R2RjNmcjlXUFA3RzNxV2ZOOGp1eklXT0JvMVEvZlhYRlF4MGM3?=
 =?utf-8?B?SE5MVExONUtROVlERGF2RUd2YWFuUU5XVHExQ1FROGVla3ZEK3hsalROaHBV?=
 =?utf-8?B?QngwWFdvUStHTDBuR0hsSERWZytsWHZTVjhCSUVLbjdsSng2MFZrMkxFdVhl?=
 =?utf-8?B?ek1VSGpkOWVhZ2xwakxCU1gyNG51MXU3cXZPS2VvZEN6Zm1EOUtkc28yR2Ns?=
 =?utf-8?B?NjAvUnB6ZkQ1MEpCSzdGM2l3RWcxSjhrYTBrczJjQUZUSEZOWHJlTkc4NHRY?=
 =?utf-8?B?OVFzL2svdTJmSjBmUHZYTGdmWlNhbUxqdmZlcUJMdlBCazdSYlY0Vm40Nm56?=
 =?utf-8?B?YlNMUUlDZldGeXlCMjBteWlGZmZGZ09BM2tYY0Y3V3pJWlg0bTlLc1VkcG1N?=
 =?utf-8?B?eXZYUEh5aG93cGJGOXIyTm82cDVBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379593ce-8d46-41b0-cf5c-08dc2bacaebe
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 09:26:24.6662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1wkm/EYHF1c/1XDYLw3N8u4KH8ekh3FglZT8LLzGZDDbRYnU9rs7SZpTADl238zxG9mmg2MmFmYSkXBeDDG9l85AsPviRt/L7E0XXL94ECRbUgvnWbKYMzVpGge9FXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9061
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

Hi Jonas,

On 2/11/24 22:34, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-02-09 10:50, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> JAGUAR is a Single-Board Computer (SBC) based around the rk3588 SoC and
>> is targeting Autonomous Mobile Robots (AMR).
>>
>> It features:
>>   * LPDDR4X (up to 16GB)
>>   * 1Gbps Ethernet on RJ45 connector (KSZ9031 or KSZ9131)
>>   * PCIe 3.0 4-lane on M.2 M-key connector
>>   * PCIe 2.1 1-lane on M.2 E-key
>>   * USB 2.0 on M.2 E-key
>>   * 2x USB3 OTG type-c ports with DP Alt-Mode
>>   * USB2 host port
>>   * HDMI output
>>   * 2x camera connectors, each exposing:
>>     * 2-lane MIPI-CSI
>>     * 1v2, 1v8, 2v8 power rails
>>     * I2C bus
>>     * GPIOs
>>   * PPS input
>>   * CAN
>>   * RS485 UART
>>   * FAN connector
>>   * SD card slot
>>   * eMMC (up to 256GB)
>>   * RTC backup battery
>>   * Companion microcontroller
>>     * ISL1208 RTC emulation
>>     * AMC6821 PWM emulation
>>     * On/off buzzer control
>>   * Secure Element
>>   * 80-pin Mezzanine connector for daughterboards:
>>     * GPIOs
>>     * 1Gbps Ethernet
>>     * PCIe 2.1 1-lane
>>     * 2x 2-lane MIPI-CSI
>>     * ADC channel
>>     * I2C bus
>>     * PWM
>>     * UART
>>     * SPI
>>     * SDIO
>>     * CAN
>>     * I2S
>>     * 1v8, 3v3, 5v0, dc-in (12-24V) power rails
>>
>> The Device Tree comes from next-20240110 Linux kernel.
>>
>> Cc: Quentin Schulz <foss+uboot@0leil.net>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>   arch/arm/dts/Makefile                              |   1 +
>>   arch/arm/dts/rk3588-jaguar-u-boot.dtsi             |  38 +
>>   arch/arm/dts/rk3588-jaguar.dts                     | 803 +++++++++++++++++++++
>>   arch/arm/mach-rockchip/rk3588/Kconfig              |  28 +
>>   board/theobroma-systems/jaguar_rk3588/Kconfig      |  16 +
>>   board/theobroma-systems/jaguar_rk3588/MAINTAINERS  |  13 +
>>   board/theobroma-systems/jaguar_rk3588/Makefile     |  10 +
>>   .../jaguar_rk3588/jaguar_rk3588.c                  |  52 ++
>>   configs/jaguar-rk3588_defconfig                    | 115 +++
>>   doc/board/index.rst                                |   1 +
>>   doc/board/rockchip/rockchip.rst                    |   1 +
>>   doc/board/theobroma-systems/index.rst              |   9 +
>>   doc/board/theobroma-systems/jaguar_rk3588.rst      | 100 +++
>>   include/configs/jaguar_rk3588.h                    |  15 +
>>   14 files changed, 1202 insertions(+)
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index 3beb8f1b9d4..7c103655e1d 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -193,6 +193,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>>   	rk3588-edgeble-neu6a-io.dtb \
>>   	rk3588-edgeble-neu6b-io.dtb \
>>   	rk3588-evb1-v10.dtb \
>> +	rk3588-jaguar.dtb \
>>   	rk3588-nanopc-t6.dtb \
>>   	rk3588s-orangepi-5.dtb \
>>   	rk3588-orangepi-5-plus.dtb \
>> diff --git a/arch/arm/dts/rk3588-jaguar-u-boot.dtsi b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
>> new file mode 100644
>> index 00000000000..a0207c265c9
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
>> @@ -0,0 +1,38 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
>> + */
>> +
>> +#include "rk3588-u-boot.dtsi"
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/usb/pd.h>
> 
> These dt-bindings includes should not be needed in this file.
> 
>> +
>> +/ {
>> +	chosen {
>> +		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> 
> Is there specific reasoning behind why eMMC is listed before SD-card?
> 

Consistency with our other products (Ringneck PX30 and Puma RK3399).

> rk3588-u-boot.dtsi should now contain a default with a same-as-spl >
> SD-card > eMMC order.
> 
> Also guess in practice it should not matter mutch, if TPL/SPL is running
> from eMMC it will read FIT from eMMC > eMMC > SD-card. And if TPL/SPL is
> running from SD-card it will read FIT from SD-card > eMMC > SD-card.
> 

I was pondering whether we should do something about this, to avoid 
reading twice from the same boot medium, this unnecessarily increase the 
boot time in case we're entering the fallback mechanism.

> Main difference would be if TPL/SPL is running from SPI, then it will
> read FIT from SPI > eMMC > SD-card instead of SPI > SD-card > eMMC.
> 

Yes, we do have an SPI-NOR on Puma, and we want SPI -> eMMC -> SD card 
there (mainly because that's what we've always done, thus now for 
"backward" compatibility).

For SPI-less systems, I guess it doesn't matter much indeed.

> In my mind anything after same-as-spl would mostly be used for recovery.
> And preferring SD-card may ease in such situation?
> 

No, this we don't want. But this is just a different policy from 
Rockchip's default.

c.f. 
https://lore.kernel.org/u-boot/7b5cb03f-c2b2-4cf2-b06a-751d7cc978b9@theobroma-systems.com/

>> +	};
>> +};
>> +
>> +&emmc_pwrseq {
>> +	bootph-all;
>> +};
>> +
>> +&emmc_reset {
>> +	bootph-all;
>> +};
>> +
>> +&gpio0 {
>> +	bootph-all;
>> +};
>> +
>> +&gpio2 {
>> +	bootph-all;
> 
> I am guessing that emmc_pwrseq, gpio0 and gpio2 would not be needed in
> TPL so bootph-all could be too inclusive, for now I guess this does not
> really matter because an external TPL blob is used anyway.
> 

Don't have much of a choice sadly, c.f. 
https://source.denx.de/u-boot/u-boot/-/commit/9e644284ab812f2db23f6185af77c0e771b0be73 
Considering that we need the eMMC in U-Boot proper before relocation, I 
assume I need the emmc_pwrseq as well in bootph-all.

As for gpio0, I think we use one of the pins in that bank for the NVMe 
but we indeed wouldn't need it before relocation. Especially since I 
somehow didn't manage to get it to work in U-Boot yet.

Cheers,
Quentin
