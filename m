Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8187EE7FE3
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 12:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC27A86560;
	Fri,  8 Sep 2023 14:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jD8X+k69";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CD8866AA; Fri,  8 Sep 2023 14:14:55 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B3B86429
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 14:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFsj2TJFMIjgEPymtMUjyaAriFY07uKjy1FlV7J31ui9SJMLE6n1SxcinaXkW7ytSljIrldWgjQkjCo/8/Ii1iNCYP5UkbzmR0pg4OftpChpo8iigX1jttmREgn59Ij29tlBMPnnSZ/vY7nkN5OMiUnH+hSnwSSRSI8Y1hZnJewcf/R+vrJv6WZTpr9xQBc7skY/QmSvJa5aKXb+lgGBvMKLBpAFWm8FgCSY2k00zVTEAT66bhZk3N693MpVJ9B/LRyhSrFnbPQNAwqFNZv0I07sg17OtIncvkE7UcBW+Zt3orjrrAlFkmkDzS0WZnxUiWLn0Kc3YMpS5dd2hbTH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajI5EgaxJULNmiUhwaHg0cSI8PmQlpKhx/GGBmTS2Q8=;
 b=KAXkuqOeXllmcYo/sV3pPzHH11UqeT5B7/s7x4QOiWDU2j732RqSxy7mjYVdzYzMXmL472erCbkEWvtXhzh6Z4KvJjM5xOCgevBDk3mgQvbIbbcqpPJTgq6QfgiMPwMo88lDrZns4z/JeDrjdqtspQUL53x3+WsPZTzOQUGPUOwzshuXBcabR3zQZEzPo7sG2V3j4PNMcsw6Hc/7jQUR12nq29T/9HtPd1oOq6eUf2zB3luuTqlpbyTOgUNbto9SwRLhXDfZJndXrdkUaqxeYmrv0wLyBgWEDtQtt14a6fjntY0GMy1Oil3XpjBzL/yjvsMb92LCxQmkAm/HWzvRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajI5EgaxJULNmiUhwaHg0cSI8PmQlpKhx/GGBmTS2Q8=;
 b=jD8X+k69sxCHDKfvossT/MZcZx9GzjCcgyPT7d0zX2Be+gT6ZP2ViiUYjwEyilVoXBV4sc+gg7kGh8CcCCpeDowLBb/TwsfrpsRWvT6ZmelDPmlYw3wmjBP8kYTORJwE/hE8UD8JDQHXDRx29bWAw4HB6yWj/8yg6NIihlssXL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8328.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Fri, 8 Sep
 2023 12:14:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 12:14:49 +0000
Message-ID: <280f002d-5c8c-b679-508d-b3469d1fec95@oss.nxp.com>
Date: Fri, 8 Sep 2023 20:14:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC 0/6] firmware: scmi: add SCMI pinctrl protocol support
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de, etienne.carriere@st.com, michal.simek@amd.com,
 sjg@chromium.org, linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com
References: <20230906024011.17488-1-takahiro.akashi@linaro.org>
 <CAOMZO5BNpWM0a1UwJmYE+cvd5NDtxXSULb-Tr7qhucGC3i16QA@mail.gmail.com>
 <ZPmezjoqEwCtJ7qd@octopus>
From: Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <ZPmezjoqEwCtJ7qd@octopus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: 40abd1fa-88cd-431f-a7db-08dbb06532af
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AlPaDx/DsZR69gzZRbwO4iflqNqWepb0/ERHWFldlVWeKl5kLhFYilWgtGqWvuzr/ppNybuMqUCOeX+e3xGHml4zOzntSjYjLhzuPCKOHcpD102qIWwb7dePHBheOV92Z9mdot6yVGzx+euLzhWFJtCTsuEAyKN7qPhdzaKaYVg+YxFgqMCMOgiy/pMt5EOASih7cUrAKtnt6CaXkd5LmHVliE7aIUe4z/uUyqRRjWRgEaV73qeVNKwlrgPyL4GXGXULGpsFrSwVDq+MNWBhWn028qT7zMcOYQiyAXQpeu+Qct4cuj0/+xEd2vdWHVL/ZEeEzQ/NeOZsSP+bGIEmrtD/xFHX1aiPPdIIjr8QAMx5lZjJVQx+L+a4ZfkNtIPbW7vheNLglFP2uXPK1K8c1SgsFLmRdiFR8OkcEjT7PwjzxRQ3dzy9d5UjrdHSh3YZbDZyM5qUHyFySgYPh2PUJP6+3HguI3JTp+tI5XRvTGwZ6e2OJCMGmSFkycfaPVoPtnyYhz/ATERAHUUDuvMYkdnTJfx9S+lKsC1b4JUgkX6abX2dUm8+i0U5JQFCuMEmeUwRGo9erGwcxXDRVDbQsf4/mSuNHa12IJDUOp1VkqzveI8vqbfx7S/NcsRGGpE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(5660300002)(44832011)(6506007)(8936002)(8676002)(6486002)(31686004)(66476007)(316002)(41300700001)(66946007)(66556008)(966005)(2906002)(53546011)(110136005)(6666004)(6512007)(2616005)(83380400001)(478600001)(26005)(38100700002)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lGaVZ2MGd4Y1NndjkyU21UMU1LeGVoeUh5MlVjalY3STk5ei9IUmhTeGZZ?=
 =?utf-8?B?K3NHTFR6bUxOWnJsUzJuaDhnUE5NZ0JYeTlreFhwRVJob0xITVpVdlNLSkZG?=
 =?utf-8?B?emt4bnJyeTJtWEJMYWRXanVpamsyMnVtR29Nck4ya2JHc0c3T29tWjJWc25U?=
 =?utf-8?B?MmRFY09BNjRESFNEVHNZNHpBZ0wxZU4zSDhzbDVLby8wejJoWmVqbXo5TXVu?=
 =?utf-8?B?dWFyaHRka1hQUmpwcjZpamF6dXp0d29CQkVMOHNGM0srdUc3OGpqOUJtWlFN?=
 =?utf-8?B?S0NDdVVFZ3pJeHNyMUVrTUU5YXRTODJEWkorYkx3YVhBZml4cGZITUZ1Vk12?=
 =?utf-8?B?NEpKNE14aE44VFRiQjRtRGd0bUpSeVFMSVJqNzdmM1hkZVFtdGFwSXVKODg1?=
 =?utf-8?B?RHgwSU1sb2RQVzlQanV6SVdidmpod3o1NzhlZTVZdjRDT3o2YUFscGxNckRv?=
 =?utf-8?B?N01YclcvdTU2MVpPckpXdUp5SmEzY09DUU9Ha29Mc1pGWmtHVlJaOXVHVmFS?=
 =?utf-8?B?eWNhUWo3eEpGc3pvYVk5ams4bE9odEN1QTV6aEowUmFGVWZmRGpuaU0xRVBH?=
 =?utf-8?B?VXRiUFA3dFUwYlZKYkRZdlZqUXlBRlRDTDBpTllrL1NIZGNmQVNhak1GS3Jo?=
 =?utf-8?B?YmZaNW44MEdxeU4wZm8wckxwVjU1NzVSUzZYako3c29aZlVrb3ZlZVBobW1u?=
 =?utf-8?B?MmtuczRaVmNTa0xMQ3dsd2xhWHlIWnA0c1A1YnM4QUlFanRFZnRhV0pPRDlZ?=
 =?utf-8?B?cXZOZlVXRWVJU2gvbFNxR0QzSTY0cnY0VXZVeGNCUEIzbVk3d0FGcC9NcHNI?=
 =?utf-8?B?ckJ6bEZUQnZLZWR1eEplRVp3dlVqRldKdm4vRTh0WEtGQUFlR253dnlwWEtl?=
 =?utf-8?B?cFhMcUNtejFxbmdUbW5Nd3BFZ2RSalhUeDl6Q2pmV3hhVm8vWHRGU01TdW1E?=
 =?utf-8?B?UG8xUWZhN3JuaWd3ZFNROERjR1pJaGplN2Y3OTlWYlJjQjB2aFNsejFtSGlG?=
 =?utf-8?B?dkNQUW9EOVhnUEtSS3ZENkFyTlF4UitGRzA2bEZORkJwTVhrTzRIcjJDWWlI?=
 =?utf-8?B?ZURtZE1nOUVVM21ybHZGSnh6WHhJZ0o4MGdLYUVjOVpnTStSblp1eHNTTkhV?=
 =?utf-8?B?dk5PSHA2L3lzZXhjTkNaM0RHUFRrUWc3dWRtMldYTTlZOW5paVk5anBkN1A0?=
 =?utf-8?B?aVZ4WTJaSUE0dXRHdlpjbUVmODdTeU0yN1BCb0J0SjU1V25uUGhKZFhYSnBa?=
 =?utf-8?B?Y3FNWlB0MEZ6YzJXUkZtaHdpMjFXSVlXbWxVd3M1Ty91YWxWKzk2WElPelRm?=
 =?utf-8?B?cjdTWDcrbjIvdnNZM20vNk9aLzdYM1hKSlV3S2VXL0tRMEVXSW45QUJOTEhU?=
 =?utf-8?B?MThxclVXWWVKMWlMS0FNQ2loRlRRdmkwcWRPWmhOZ0p5VDJudUVIL3FodDUz?=
 =?utf-8?B?dU5LbjhISWM1d1RxZTRDWkVkNzJwMlhIRTlsVGJhZTZPVFFJQ2p1L3dzSnow?=
 =?utf-8?B?TElCZ0tkQkRpMGNzdVVIU1FZNWEwcVdYWEUwUXVKd0s3ckt0emppSGI3ZlVZ?=
 =?utf-8?B?dG1jeEFpaXZ2aUNhZ2tGS09icUVGQlFmMlYrRUtNY09UbTZoRDhVV1ZuNlB1?=
 =?utf-8?B?OHZYTUR2MFpjcXF3dE44Qmd2WWdoeVEzc0NodmxscnAxRTB6bjViZkNaMGJO?=
 =?utf-8?B?ZUpJRzN4b3JVU1VkOFVNaDUzUVY3dUp0WWFrTDlZMjJ4NG1SWkNWTjNsQ2d4?=
 =?utf-8?B?QVZ5RDh3Q2Z1d3FPZTF5K3dOelNDZ2xSTzhSbGxFUENpWWZqMFA1MG5pcUdQ?=
 =?utf-8?B?NUNpdE5QV1JxSzE1UzFyakxuZjFrTmpmVnNVOG5IVWp3K25HdWM1RFViK3lD?=
 =?utf-8?B?d0FNeG14aDlNbG0rT0tyNE5Kdmd1TmFFd0x3YzE1WFFGOFhpTWl6cnRialNr?=
 =?utf-8?B?WHhpVUN2Zy83YzNMVjdiNzVLVklkYTcwYklUOEVtcmxXeEljTTBHTk0rZU5T?=
 =?utf-8?B?VmV2WEZUSTIzdFROWkNHL3NVa3VWUUtCYkNURU5TVDZETzdubDhuRVI5SnFE?=
 =?utf-8?B?QVFua3R3bkZ5eWljZFpSVCsvM1RSNFd2VlEzYVRkOHBRSCtjNEJYZVduN0FC?=
 =?utf-8?Q?RPUzhQc5MRKgpmc5WkY4H7jCq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40abd1fa-88cd-431f-a7db-08dbb06532af
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 12:14:49.8738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ap0MImcOAb1dWkYXTKfyfhn8JnWe41ovNa5dO+NlGiLUqqy5weaUnZAznV9x+qFo5g2+Fl8kBB50lSYKptQccA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8328
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



On 9/7/2023 5:58 PM, AKASHI Takahiro wrote:
> Hi Peng,
> 
> On Wed, Sep 06, 2023 at 12:09:45AM -0300, Fabio Estevam wrote:
>> Adding Peng Fan, who is working on scmi/pinctrl support for i.MX9:

Thanks for looping me.

>>
>> https://lore.kernel.org/all/ZO9GLG5tQynYyAvR@pluto/T/
> 
> I made a comment there.

Thanks for help reviewing.

> 
> BTW, do you already have your own implementation of SCMI pin control
> protocol at SCMI firmware(server)?

We follow the SCMI 3.2 pinctrl protocol, but use OEM config type.

> Is it public available?

The firmware is not public for now, but I could share
the config set array, something like this:
MUX TYPE, MUX REG, CONF_TYPE, CONF REG,
DAISY TYPE, DAISY ID, DAISY VALUE.

Regards,
Peng.


> 
> -Takahiro Akashi
> 
> 
>> On Tue, Sep 5, 2023 at 11:41 PM AKASHI Takahiro
>> <takahiro.akashi@linaro.org> wrote:
>>>
>>> This is an RFC and meant to get feedback from other developers as
>>> - the specification (pinctrl part) is still in a draft
>>> - the upstream patch for linux, including dt bindings, is still WIP
>>> - I'm not confident the drivers are generic enough to cover most HWs
>>> - The tests ("ut") doesn't cover all the features yet
>>>
>>>
>>> This patch series allows users to access SCMI pin control protocol provided
>>> by SCMI server (platform). See SCMI specification document v3.2 beta 2[1]
>>> for more details about SCMI pin control protocol.
>>>
>>> The implementation consists of two layers:
>>> - basic helper functions for SCMI pin control protocol
>>>    in drivers/firmware/scmi/pinctrl.c (patch#2)
>>> - DM-compliant pinctrl/gpio drivers, which utilizes the helper functions,
>>>    in drivers/pinctrl/pinctrl-scmi.c (patch#3,#4)
>>>
>>> [1] https://developer.arm.com/documentation/den0056/e/?lang=en
>>>
>>> DT bindings
>>> ===========
>>> Upstream pinctrl patch for linux defines the bindings in [2] though
>>> it doesn't say much.
>>> I expect that my implementation basically complies with U-Boot's generic
>>> bindings described in [3], but not all the features are verified.
>>>
>>> As for gpio, unless you hard-code pin assignments directly in a device
>>> driver, my implementation allows the following alternatives in DT.
>>> Either way, we may need an additional binding description for gpio.
>>>
>>> (A)
>>>      scmi {
>>>          ... // other protocols
>>>          scmi_pinctrl: protocol@19 { // Pin control protocol
>>>              ...
>>>              {pinmux definitions}... // if any, including GPIO?
>>>          }
>>>      }
>>>      scmi_gpio: scmi_gpio {
>>>          compatible = "arm,scmi-gpio-generic";
>>>          gpio-controller;
>>>          #gpio-cells = <2>;
>>>          gpio-ranges = <&scmi_pinctrl 0 5 4>,
>>>                        <&scmi_pinctrl 4 0 0>;
>>>          gpio-ranges-group-names = "",
>>>                                    "ANOTHER_GPIO_GROUP";
>>>      }
>>>      some_device {
>>>          ...
>>>          reset-gpios = <&scmi_gpio 0 GPIO_ACTIVE_HIGH>;
>>>      }
>>> (B)
>>>      scmi {
>>>          ... // other protocols
>>>          scmi_pinctrl: protocol@19 { // Pin control protocol
>>>              ...
>>>              {pinmux definitions}... // if any, including GPIO?
>>>
>>>              scmi_gpio: scmi_gpio {
>>>                  // no need for "compatible"
>>>                  gpio-controller;
>>>                  #gpio-cells = <2>;
>>>                  gpio-ranges = <&scmi_pinctrl 0 5 4>,
>>>                                <&scmi_pinctrl 4 0 0>;
>>>                  gpio-ranges-group-names = "",
>>>                                            "ANOTHER_GPIO_GROUP";
>>>              }
>>>          }
>>>      }
>>>      some_device {
>>>          ...
>>>          reset-gpios = <&scmi_gpio 0 GPIO_ACTIVE_HIGH>;
>>>      }
>>> (C)
>>>      if "gpio-ranges" is missing in gpio definition, assume 1:1 mapping,
>>>      i.e. use a native pinctrl pin number (5).
>>>      some_device {
>>>          ...
>>>          reset-gpios = <&scmi_gpio 5 GPIO_ACTIVE_HIGH>;
>>>      }
>>>
>>>
>>> [2] https://lkml.iu.edu/hypermail/linux/kernel/2308.1/01084.html
>>> [3] <u-boot>/doc/device-tree-bindings/pinctrl/pinctrl-bindings.txt
>>>      <u-boot>/doc/device-tree-bindings/gpio/gpio.txt
>>>
>>> Test
>>> ====
>>> The patch series was tested on the following platforms:
>>> * sandbox ("ut dm pinmux" and manually using gpio command)
>>>
>>>
>>> Prerequisite:
>>> =============
>>> * This patch series is based on my WIP "Base protocol support" patches
>>>    on v2023.10-rc3. You can fetch the whole code from [4].
>>>
>>> [4] https://git.linaro.org/people/takahiro.akashi/u-boot.git
>>>      branch:scmi/pinctrl
>>>
>>>
>>> Patches:
>>> ========
>>> Patch#1: Add SCMI base protocol driver
>>> Patch#2-#4: Add drivers
>>> Patch#5-#6: Test related
>>>
>>>
>>> Change history:
>>> ===============
>>> RFC (Sep 6, 2023)
>>> * initial release as RFC
>>>
>>> AKASHI Takahiro (6):
>>>    firmware: scmi: fix protocol enumeration logic
>>>    firmware: scmi: add pinctrl protocol support
>>>    pinctrl: add scmi driver
>>>    gpio: add scmi driver based on pinctrl
>>>    firmware: scmi: add pseudo pinctrl protocol support on sandbox
>>>    test: dm: add SCMI pinctrl test
>>>
>>>   arch/sandbox/dts/test.dts                  |  115 +++
>>>   cmd/scmi.c                                 |    1 +
>>>   drivers/firmware/scmi/Kconfig              |    3 +
>>>   drivers/firmware/scmi/Makefile             |    1 +
>>>   drivers/firmware/scmi/pinctrl.c            |  412 ++++++++
>>>   drivers/firmware/scmi/sandbox-scmi_agent.c |  722 +++++++++++++
>>>   drivers/firmware/scmi/scmi_agent-uclass.c  |   18 +-
>>>   drivers/pinctrl/Kconfig                    |   11 +
>>>   drivers/pinctrl/Makefile                   |    1 +
>>>   drivers/pinctrl/pinctrl-scmi.c             | 1071 ++++++++++++++++++++
>>>   include/scmi_agent-uclass.h                |    2 +
>>>   include/scmi_protocols.h                   |  435 ++++++++
>>>   test/dm/scmi.c                             |   62 ++
>>>   13 files changed, 2852 insertions(+), 2 deletions(-)
>>>   create mode 100644 drivers/firmware/scmi/pinctrl.c
>>>   create mode 100644 drivers/pinctrl/pinctrl-scmi.c
>>>
>>> --
>>> 2.34.1
>>>
