Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AABC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 10:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F51887EBE;
	Mon, 12 Feb 2024 11:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="ZGavtShH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E1B87EBF; Mon, 12 Feb 2024 11:37:30 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A5487EB6
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 11:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnpteLKYDS/CdSCZyeV81ZQMaWg7XBCP5vtr8FMQpmUulHMA4mUV+I+TabzrT31SdhWs1CHFu4YPSld4Oj0AmaQ3opuPRF82q7d9PmeGl0c+/IxHns8N+BGb1aeh9YiNgfYCAJJ9MmgpA/Qst7+KdlyMT9OQYQs1xBaRKSvzoypVQy6hRJpinY5vmOER+ANn6aLeCdTGxU99YdjWiCvCRojs7UVwBkpkpjpdvWF1+6N04y7eHy5f4r8wkrAd56N7yc6KEQSimVrx3wC2HvNoZ3hpCwM3SmmpsHXiBvFS7zuZ+z3oDjS57P3ZS3uX7yqIQVB8apZJBOYnAVR7uNxyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXHeVKEg6BrDev15IVVI6W4SjJqASIz6Y2Ea6rH+1sA=;
 b=jAYzSv6o+Ywkfx/u4MlWixFTHc1tVvctqcuaDb/ZuseiIJInNxbQLGbJbtN/3Ikz2IVZwtUApa/a2bY2IF6AElnsG9JlobjEIJGvLkThmbhRWS7m/+C1RBNojxnKaeXdHfRgkYCYuBZXrQD5NUZLWjTX7jXJXlAhS6TZ2lPVmfT9OvvoTBgihawONZxY1S4gdMUXqZc/0oqaJ53Rj+zUSmJuUV2Zzo4zS+B9OrkJy4f2mBmei1aVeH3ISw+Vos4oL9U6Eq4eK7nztdMsub9QiNkyDsIKGCpbb1OYAwLMDf6ZrWYV+ZIAQGzamOqewglgc9cvAuO3kQM5MmWV421h8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXHeVKEg6BrDev15IVVI6W4SjJqASIz6Y2Ea6rH+1sA=;
 b=ZGavtShHLdCIN5xvYCm6FdEhzrw2Rgjgm8v+rpa4pX3yYv+Ow/eYOVHPtxzSYnY0KpjuXO5iXrpKdETxi8ZGMPXc1rbKxbBV7jTC045vNAmo4bvTHK3tQnrFrDGcIwe9C9R/ypQQhPtR9SJGkuBfZi6ETcQmRP3GXKk3QaTKHyFi1UJctxeQPPGav2re777E2SZxyDDkjhIYAgzlSSwu4QoRZDZAR/64Z7KkjWfDk1Hk+QmKO2EVErZiXAzq8cAKY3v57PJupjANYOezLN+KpC3RtVX8RiAWXo7uV9ILF7g5+TH2Kav2EBmRwRQB9m+aZRjGejm/M3Lp965SwnwbNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PA4PR04MB9640.eurprd04.prod.outlook.com (2603:10a6:102:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 10:37:25 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.039; Mon, 12 Feb 2024
 10:37:25 +0000
Message-ID: <d8e10b17-0571-4ebc-9783-2301c429c6b3@theobroma-systems.com>
Date: Mon, 12 Feb 2024 11:37:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3399: Update stack and bss addresses
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Nick Xie <nick@khadas.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>, Levin Du
 <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de
References: <20240212005914.3512640-1-jonas@kwiboo.se>
 <20240212005914.3512640-3-jonas@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240212005914.3512640-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::12) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PA4PR04MB9640:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c9f80f-de7f-432e-8869-08dc2bb69a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 961ljoVjpTutyRBk8uP6eJmyUcOlnVXGjTa6njZ0A4XxjLwQZuZBvCxTWOprOeHT7LBnarXrZiMJSmrPstfWq0kM9JEe2d6r9qEIL2MV8mHLAV68lDyu7sWHGpxdgF4CSWmovAjP2Tg2E0ZO29y2LtQMGiidjhQ3fEyXUDdZibBOegba6cDvvG0ctypNTU5ovh9mA1RfK1yD9O4ODYDZafX4IC5wpDLSBr9DiRm6JiJztTvQMcLNwfHT1x1Zt0eZ+6xPcp9/n0P/kUKYhqw+faBiYmxAi8koK5VsktAqA1bqXk6dMk3ujhp8S29m015kSlvSK7BxWiNLZN7snTsuhdrQBnb54jZIvZ/7liFO9GFzJdK+ivKAzkLKHLSeN/+bmzwezJK2o1iJstqoY1ci0OMwyi/PIdEdGr7XT0z/t7o58/uiN/pgyPuFAYVkOZjV0W/RaJBJlCgIy1u9ilR9/Wm31rCAzNXEwRY7D1x230JF7qlH1RU4bGKEombb07jOTxaYrqCioCo9GxNV4wnSv7iNoXATbIOlhXeh9PPq/ykpEoXaxZ6lycHZTNW9OaPO6gSP83Bxb7XLNkygmLqQyuixHZUS9z/PScaKZ1rvdrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(376002)(136003)(366004)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(6512007)(478600001)(41300700001)(6486002)(8676002)(4326008)(5660300002)(15650500001)(8936002)(44832011)(7416002)(2906002)(66946007)(110136005)(316002)(6666004)(6506007)(66476007)(53546011)(86362001)(2616005)(66556008)(83380400001)(921011)(31696002)(38100700002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVhwYWhXNTVRZ1RJUWxVZStvQXlmZDRqV2RyVU9ZMEdvWFQ5emJRYlR5NGll?=
 =?utf-8?B?NnVxOXZCOWk4Q25QWHBRaTJlajZqRUVvbVg4Zm16dWNNQVJIV0ZnbHNiZENG?=
 =?utf-8?B?T2R3UlV6dzJjcThxQ2d2eWxLMmRoMlJSaWhNd2kydWlJekVONWs1L1ZLYjlx?=
 =?utf-8?B?REo2RmNueUZhMzV5RkNwbVIvckFGVDNVZGR6d2J6QmtzdTN1TTJ6U0lnWVhk?=
 =?utf-8?B?NS9vQkhTcWg1b01McVphcHJHOExVSks4T1FsUUVDVmYyNWhHSmFmc1FOV3Av?=
 =?utf-8?B?UEFLcWVQMzgyQWNNUFh4dWkwUHAvOFZISmtic0k0L2lidXZmenZMNEtqY3RJ?=
 =?utf-8?B?dXQrdmJ4Yy9EVGFsd1hvOW9uc2EzRnhhR1VMMHE1M3FrVFZuM2ZHRmhrUmNS?=
 =?utf-8?B?eXcycE82akhHdnh0SlBlcHNKOFdlRktXY2xIKzRBT1Y1OVRtSUpjdmZUblBx?=
 =?utf-8?B?Qmd1YnRpUDJjQzVYWTBpdzA5b2MyYlNneWFqVGltWTdGQURCQy95OVNrYVlj?=
 =?utf-8?B?ODFoakI3d0Z4Q3U2akR0NjZ2bG8xK1dTd0FITXVEdDlBV1lDNWpHOVFOWHJM?=
 =?utf-8?B?QW8vcytLVFVpOGN5bkRMeEpGeGZlY3ZKdS9kbWJRMmpOa0JsdW5NZ25jdGhQ?=
 =?utf-8?B?c1oyWTZlR1ZITzlMNTBTQ25sT0xNN212T3JrZVhFY3N0OGgwb24zaUhYeGdu?=
 =?utf-8?B?NkRNeUxpN3NtSFJJRWg3anZHUFkrekZmT0Q4eWxQaS9HWWZhRTQzSXh6Qk5T?=
 =?utf-8?B?dXB3MmUzc0g5c0V6SWp4TVdnR2xVVXZaRU1YYkJmWVpweUZyNTByZ2FObXpz?=
 =?utf-8?B?MDhFY2FpVFB5ekNVTi9UUnFtelpxb1NMT3kyTnVNT3VJQjBtRUI5a21xZWIr?=
 =?utf-8?B?S1dOTVhtYVRJRmNrbytkekNnT3hRWWJBNGw1dWU5cVFhenF1bjB1bzNiaTdS?=
 =?utf-8?B?NHFuRXVxbHBZQURkaVppSWhGWng5NzFEUm9RRkdHbzBES011N3c2TXVnQnYx?=
 =?utf-8?B?d3kwSnZxbkIvNHFkL0x4VXc1Z0pOcEtsc0p3Mkx5QTNHMXY3aDhTOHlpNkYw?=
 =?utf-8?B?Wk16YlAvM3ZkeWZrd0xaU3hqTUFwMWlNdG1tRkgyeEtJdWFpYnNWUnBlSm40?=
 =?utf-8?B?TnA0dWlRS1haSVVVcGZRM3JxT2tVL3dObVI4ZXlsREprbGdMOHROZklDU01Y?=
 =?utf-8?B?NnJDckd0R3ZTS2JRanJ5cS94OUovbElFZ1RIMFhuZnBqNlBWL3RzcGM0ZWZa?=
 =?utf-8?B?a0Y2WTB4OEZ6TkxOOVZGWWFraUJWbkl2RERlYUlSUTNOZi9jeU53a2hQZ0ha?=
 =?utf-8?B?Y3N3Mk1wSzFlclhtQ1VQbkhIMjhocjdZaytTR1p6aGxCQ0VYVFhyY0o1QTd3?=
 =?utf-8?B?WStvQjZRRnBpSzd6YXNraHJJL1V3am0wdHZRc21QOUV5ZEVKMzNEZmxhTVF5?=
 =?utf-8?B?anVQMzBxYWtldkN5a2ttRHJhZjY2NWcxLzF5ZUdLTXA0OUhrbHpDbzl4ZStI?=
 =?utf-8?B?OW5kVGtWWUU2N0ovUzE5ZnVwaXo0N21RS2lUclk2NFRuck52L1J4VkIyeHRO?=
 =?utf-8?B?MU5oZmxWSmxRZWFzTTRNdElkWGlVbEVKNzdreGpSNDlWZG9hYll5c3Q5UVlS?=
 =?utf-8?B?MFdEamI4YnVwekVwN3NJZ1pSSlJjR0ZRQ29HWXpkTm4vRHpWbGNXM1hJcEJh?=
 =?utf-8?B?SEt6eW1YQ3BON3Zmay9IV01HMFRGcHluWkd2Sk5HbkllbFpBQ3Q0WlJmQnhN?=
 =?utf-8?B?SDhqVnVkaWtjZHRjSVlZWDZSU3BNdWJKQWNyWjViVVZxVkQzcmtYaXB4VVJO?=
 =?utf-8?B?VXErby93T0QzS1lPYmo1Z3hjNEJPdkVTUzFFcy9yeXpQQU9LdG1RMStRYXlJ?=
 =?utf-8?B?WWNUVTJmNUpYSXc2c0l4ZWx0THRpbjBtYTlDenB1VUcwc3ZSajRZbjB5Y0Qv?=
 =?utf-8?B?M3QvaFk2cUNpOVI4cjVjVDI5VXJCWWZvek51WTNFYWVVenhFbG9XNmdyWE1H?=
 =?utf-8?B?UENGUVhqU3M2a3l6MU1VQlZGY29uWnVhRmhTclRPNmdHVnZJbzFEaFU1dVNI?=
 =?utf-8?B?Qzhzb1NDMkh6ZGFZekNnRTRlUUhUeVpNNzdJTDVuS1MwMWhEL0VNZ1ZaMVho?=
 =?utf-8?B?RVMxSUJuK0pHNTlOYUJHNUhYSkhtTHRMSTJ0b1AwS0VqeERpQm0xYWsvbW9C?=
 =?utf-8?B?NlJ3aUVlckt3TCtYa3ZIQzJJU1dwOEdXbmV1Q3BpSUhhQnlmd3Y1blNES0lB?=
 =?utf-8?B?UW1OeUxUVjh2TlAza0JmYTc2cU1BPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c9f80f-de7f-432e-8869-08dc2bb69a37
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 10:37:25.2606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcPVoH/QX1PpgHcIMPIctPkDyVF8awWIoTpJa1Tr/pfTjTETCCKNOvAC0i0w0ThUeSop81YnKmRvwtpAzmFPGMFIqQUQecQpwIROcUd291CR45/zx03RF14f6SpslYXd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9640
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

On 2/12/24 01:59, Jonas Karlman wrote:
> With the stack and text base used by U-Boot SPL and proper on RK3399
> there is a high likelihood of overlapping when U-Boot proper + FDT nears
> 1 MiB in size.
> 
> Currently the following memory layout is used:
> - 0x00000000 (@0 MiB): U-Boot SPL text base
> - 0x00040000 (@256 KiB): TF-A
> - 0x00200000 (@2 MiB): U-Boot proper text base
> - 0x00300000 (@3 MiB): U-Boot proper init stack
> - 0x00400000 (@4 MiB): U-Boot SPL init stack
> - 0x00400000 (@4 MiB): U-Boot SPL bss
> - 0x02000000 (@64 MiB): U-Boot SPL reloc stack
> - 0x08400000 (@132 MiB): optional OPTEE
> 
> SPL load TF-A, U-Boot proper and optional OPTEE after SPL stack has
> relocated, meaning that there is room for close to 2 MiB (@2-4 MiB).
> However, the initial stack used by U-Boot proper is limiting the size
> of U-Boot proper + FDT to below 1 MiB (@2-3 MiB).
> 
> Instead change to use the following memory layout:
> - 0x00000000 (@0 MiB): U-Boot SPL text base
> - 0x00040000 (@256 KiB): TF-A
> - 0x00200000 (@2 MiB): U-Boot proper text base
> - 0x00400000 (@4 MiB): U-Boot SPL init stack
> - 0x00800000 (@8 MiB): U-Boot proper init stack (changed)
> - 0x02000000 (@32 MiB): U-Boot SPL bss (changed)
> - 0x04000000 (@64 MiB): U-Boot SPL reloc stack
> - 0x08400000 (@132 MiB): optional OPTEE
> 
> This should leave room for loading and running a U-Boot proper close
> to 6 MiB (@2-8 MiB) in size. When U-Boot proper has relocated is should
> be possible to use @2-132 MiB and @164 MiB+ for scripts, kernel etc.
> 
> With the moved SPL reloc stack it is also possible to use a much larger
> malloc area in SPL, e.g. using default SPL_STACK_R_MALLOC_SIMPLE_LEN.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Do we not need to update memory addresses in the environment as well?

scriptaddr=0x00500000

This is at 5MiB if I'm not mistaken?

Basically everything in include/configs/rk3399_common.h in 
ENV_MEM_LAYOUT_SETTINGS needs to be updated to be located after 164MiB?

Did I misunderstand something? I find it weird the current values seems 
to be located after U-Boot SPL bss and that e.g.

kernel_addr_r=0x02080000

is at 32.5MiB, and with U-Boot SPL reloc stack currently at 64MiB... a 
31.5+MiB kernel Image would mess up the data there? (what do we need it 
for BTW once in U-boot proper after relocation?).

Side question, what about making those values the default for RK3399 
instead of having it in each defconfig? This could grow quickly out of 
hands to move this to the Kconfig symbol itself, so not sure it's that 
interesting to the project, but raising this anyway.

Cheers,
Quentin
