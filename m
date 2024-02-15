Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49306C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C465F87E20;
	Thu, 15 Feb 2024 14:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="iBb2kfR+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D42E87DFD; Thu, 15 Feb 2024 14:36:45 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2532B87E22
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 14:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGKOmbHYoZJbEbdQz+9XMp/DPGhlktN81XAXNz/TDfehQFnFz8XUQGQDsE0X6GCMpdaSnJhJKHr1MmKf5LHuHLquz8KbMnVYICU1Zr36N8WxIEnQhTHDHbMC+k7T2/tpdFghSfg1I+FYpfZm79F3pMk7GaGLkIOig8BWC2fCy7p4suw8CGO1i10Ih+uDKNubujuKThKGk3dN6yS+edBhMsFyDdqX/MutwfJU1KJn6+ECEudLjUaJM4eDvhy2fYtrovdYRwInHNOAZzDQ691ltuqPIDKueB1Mrjaqf8yOBXEX3a1B8oStBq5XdaJ9sSYfS84ryeW0U+w4EdO4upF+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjRwDf+Y+2/Nj17HTYNHwPtBpPZHs0nB4UU3NEb1Vv4=;
 b=BeqiofB1UuKZfChPk71HlBfl4DJkwjafbgHechMyKWXv+goBoia2G5Loiblm0F55fQlpAVa4wKYzfzOYV/H/8JPbjMGb/BRCBISxHgQLGMAfPvF84JgdrqgYdr4qkrEOuCgWBbOSoDRXBU5AAgNj+L25Fk00AJ3WQx+PrreScuEenAzVeMICEsUJcTgynJz+HmTI//5oyKR7P4bCLJexE8w2rh+D1IfRDc5U0h6MiwuFQ3WBhsnpGHEQvs6FR65TA8yZTlovyHvjdhC0qR/iVGcsIr5H+fUKaeMFG28pFhCFn0wNgi2KF0GYCHAXqRVOpcrC6DD9fEvma4STTMUv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjRwDf+Y+2/Nj17HTYNHwPtBpPZHs0nB4UU3NEb1Vv4=;
 b=iBb2kfR+EHIV+cMNGXzdDsZsJfmx8HtfEMnaTVUupZBuDAvqd5P36twwwZ3b0yctpRO8d8zSMqur+zTT0PPF3ozyKZW9MqAp0vMjb1AccfdL5HbYPzwnzkQF8fP5m+6m//Tgc75aSkkKKbgSqIUYg7MkvQn84hd1fqNCgq3l8Os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM0PR10MB3586.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:157::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 13:36:38 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7059:adf6:18fa:1ddf%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 13:36:37 +0000
Message-ID: <f9153c2d-a844-4df6-9983-77e2476793be@kontron.de>
Date: Thu, 15 Feb 2024 14:36:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] board: Add support for Sielaff i.MX6 Solo board
Content-Language: en-US, de-DE
To: Fabio Estevam <festevam@gmail.com>, Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Christian Hewitt <christianshewitt@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>
References: <20240213172226.151181-1-frieder@fris.de>
 <20240213172226.151181-2-frieder@fris.de>
 <CAOMZO5AtTf_2pg2Fs93pPvVGcO20tcGsd3mJPfj+bhFBaKd_vA@mail.gmail.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAOMZO5AtTf_2pg2Fs93pPvVGcO20tcGsd3mJPfj+bhFBaKd_vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM0PR10MB3586:EE_
X-MS-Office365-Filtering-Correlation-Id: 02371fb9-6140-4d0a-d486-08dc2e2b2201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUYTC7BRns0q9Yv+sVtGELKcay2cm1o8qifxxR4QISIYgPKxI2Isg+BczWE9xP3qynIdCnUCOE7Ndqw6j+swje5ncoEuB3plAQTtD3QI0txOMJyhMuJ51v6cHE0ng9EneLjPICerPTr13vzNnnh3gebgMro6Z6XBwDdFDU2eILlQQtJoD5BH1jYjqlKtlWJnZIT1dxAYDitucBc3hc/XksrbARnCd1Pa17Tbdfv49eD4sXNcdBH8/xzbylVQJhrDg6bdTx8CQWza3oxH26Whu7X+yHOoXm7IRmQTwefcrJr4dxXDyqoHOZL2Y8jRhouFunbLdZ+TNbrao7Rx1Vy4oOKd+3tGReLi57m/dgibdKCrwpQa0gq7J3Epi7/QNnPN1wxNOc2aowac2Bf+xItQen4aA81aKXFmAcO8AES/KQKqbFUBOfk6ZXiRONbNRHKuqE0T+u7A+U74qw892IhhVIe5tSm8KqdrAx/bysv9fx8RlC7eYwCGJ8YtVCsG7I/+YHqpOEX1rp0H57EAo9tyEs8kWmM0hrQB6BmyQhoteu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(45080400002)(6512007)(6486002)(478600001)(41300700001)(6666004)(966005)(54906003)(7416002)(2906002)(8676002)(44832011)(8936002)(5660300002)(4326008)(53546011)(66946007)(6506007)(316002)(66556008)(66476007)(110136005)(2616005)(31696002)(86362001)(26005)(38100700002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amRBRnBVVGVjUklZTWgxMmJSNFkxQ1d2OXhZbllwd0dndGZpY1pobjUxSFlX?=
 =?utf-8?B?MEJxSDlFRnc5aGRBSEVJeUJRNUs0ZlVDVVBIR0dkNE8vOE02YXZtRmNCMEdj?=
 =?utf-8?B?TmgxcVN0RXdNMy96V3cwNXo5N05aazBRUEJEYWV2LzlnRlVPa1ZJQlpqd1Jz?=
 =?utf-8?B?RE9RbzVaTjI1UWVLbHREclZwVGJQcW5TaHJiVktkSkMrS3FPTzFnSnJEVFdk?=
 =?utf-8?B?VUZNM21zUVVIaDJmY21zWlN2alltaGtGRUhvUFUvMEltU2FyZHJlbi9MbU5w?=
 =?utf-8?B?U3k1TzZjd0ZBZmdhM3BzQXpPRndrbkZqZy83RklwQ1VUV2pkeGZ2d0MxWkpJ?=
 =?utf-8?B?enVPRkF0T1lBS2orR1I2MmpLak0ya0Nyc3czU0Y0VVN5YW9td0NXQmp2Y2lL?=
 =?utf-8?B?TCsxVHhDb01oajlka0t0b2M1aXVXQ1AzSDdEcHNVa3VXaVNiSVpQTnJ1QUZq?=
 =?utf-8?B?VGU0MVh5UFJzNVhuV2F6WGowYXZrcVRJa0t5emtYTWpJMTJBVGtZT3F6MjlG?=
 =?utf-8?B?T1NJSXlZaFVDK09YVjlWQkI3SWhRaitpOHpDYzRJMG9sT256Z1hLbVkzZXEx?=
 =?utf-8?B?TDFSNUZSZG4xVzFFeWROdjhta0hnZEo4RzF6Z25tazBuWVRnMEFxdkEzY2NQ?=
 =?utf-8?B?cHhWMC9XZC9BMTd1N0oyNzhtbkViUTlyQkl5NXFFVFE5OWhVUkZ4Q2gyS1FD?=
 =?utf-8?B?QXN6RkZBTUYyK1RscVdsUkpVUEpCQkZ5UlBSOHVYNEcrZFloaHVldXNQNHJw?=
 =?utf-8?B?WktsRklGMGp4M3ZjT0wwazdqdUhoeUZESTNJQ2M1dkJZMEpyZk1JcG9COXpJ?=
 =?utf-8?B?TUVvNEMrWmdIQjEwOE0zUTRTUXVQKzNXcVE3NWY5UHVERnI3NnhGMXNlbkZv?=
 =?utf-8?B?QVlId3VoaEFSTU0ySW5QeWRHQTY2cHVVSGFUa21ZNm84VGJ1cmx4Q1BlbEFC?=
 =?utf-8?B?VmdMcFd3ZUpxV01jNEFScWJkQkpJVGQ4dlVhZm1YTVpZdmY5QVBQb3NEYlJa?=
 =?utf-8?B?eXNsRzBXZG51b25sbk4zdXFpYkR6TE9sS2N2WGVaUCtuaSs3YVJQbFVhN2Vw?=
 =?utf-8?B?V3VuaHZSYjl2UkhyS2tXdVFZaU9yVHdua0hQcU0vazQrZ1dIZGlsSm1mbGRB?=
 =?utf-8?B?aUVvb2VPWDRjcXdtQ3FVWTcwM29yY0ZPNHVZZnU5THRRSFduY0drUWkzblRV?=
 =?utf-8?B?TWg1cXpld1hVSEh2RUZnaGw2RFB1bjRKZEM2c1M2V2FNQm4wbHloV2IzRGJW?=
 =?utf-8?B?aFVQb3NTSmR6dXRrVGgzMGdPbytPMnU4c3VKZVdUaUQxVjJMeUJjK1dyUlpT?=
 =?utf-8?B?Kzh2STcrbFdtOUpSOG15UDRCeE1LUmhDT3BJUE9VK1owbGpwcjRlMisyYzZy?=
 =?utf-8?B?OUFqbFAybnVRUlhFK1N3NngzVlFmbnIwZlkxNWR3aXMwMGFwUUs3YmJkUDlW?=
 =?utf-8?B?TTVIa1RvWldxMmd0SzFKdjhVNFM5VFhDTGw4Um5nL0JyUTdBeWhEOE9ZT1RQ?=
 =?utf-8?B?RDBKRUJlUFY4MXlKbk9LYS9hbHhVclB1WHhQYXNXOTBydXdoWGVTa1lTQS9Y?=
 =?utf-8?B?c1lyb2pRaEEzbkEzVG5IMmtBTFF3S3EydGNlV1gxQUNJaEhIcWlyeWJkai9y?=
 =?utf-8?B?VitwMDAyRVJ2YU9USHFsQTFkalc4OGNHVUpqQ1phMm9ZeVY4d05Pa2dCV05X?=
 =?utf-8?B?dktlY243cWkvSzVXRWVlSjBpcUgrdGlUYXJBS3dGTmVoenBHYVR6RWlqRlRI?=
 =?utf-8?B?Y3lHREovRGR0bnI2SjRlc2VGbHpFUjBJZFR1MEwwR0N5bU93MjNtMjc1NXJG?=
 =?utf-8?B?MWRJQ01BenY4QlJieUM4UnFzVFNad094UDRmNFYrNTJ5eWsvSkh2SHlGMVNr?=
 =?utf-8?B?K2xTYjhlWitrRmIwOTdINmNxbDFsQ083N1JNeXlneGIzLzV6TGtyRGxITGc5?=
 =?utf-8?B?WHVaSEltVXA2R2pKdkN2L1NhRWlJZHlySE5iWi9SS2VTaHd2RzVrMElBRDJn?=
 =?utf-8?B?UTh2QW0wYzhNZ1NOdkNTRnNISDdYNUZJTmFHbnZDTWk3eW9MNFJzWWdRd2pL?=
 =?utf-8?B?MGduTGcvY3RJRVNFaTVEZjJDOE0vK2R6K2FTU05Vd1lUNStTQmx1YXRoejNC?=
 =?utf-8?B?TUFlM09tZDhUQUJKaVp3S3JZZms1Y29uOUh2azBxSmpUaUFnU1NUbGUvKzF5?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 02371fb9-6140-4d0a-d486-08dc2e2b2201
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:36:36.9766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShRaoqDD8E6lp+q8aJ44f+s80IZ5qvg+fP2W8uPG4qKLr7OaDYtVf+s6q7UyWMZ0OijJXSiRguT3Xg6l4CNl+f916I8io4inOEN9So2pVNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3586
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

On 15.02.24 13:27, Fabio Estevam wrote:
> Hi Frieder,
> 
> On Tue, Feb 13, 2024 at 2:22 PM Frieder Schrempf <frieder@fris.de> wrote:
>>
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The Sielaff i.MX6 Solo board is a control and HMI board for vending
>> machines. Add support for this board.
>>
>> The devicetree files are taken from pending changes in the Linux
>> kernel that are available from linux-next and will likely be
>> part of Linux v6.9.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Changes in v2:
>> * Implement changes suggested by Fabio (Thanks!)
>>   * Fix system reset and remove unneeded cpu_reset()
>>   * Add 'static const' to nfc_pads[]
>>   * Remove hostname from env
>>   * Remove options to disable caches
>> * Enable watchdog and wdt command
>> * Enable LTO
> 
> I put this series in CI and it complained that there is no MAINTAINERS
> entry for this board:
> 
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/784464
> 
> and there was also an issue with the documentation:
> 
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/784463
> 
> Please fix these two issues and submit v3.

Oops, right. Totally forgot about these two things. I just sent out a
v3. Thanks!
