Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F6ACD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 09:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69DAD847C8;
	Fri,  8 May 2026 11:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hpMo3yDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEFC8470B; Fri,  8 May 2026 11:33:18 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B586184BD5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 11:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+sqExBPZ63RFCnGWPq4twegxbsV/YU3FvFUHFBxxvF0xI/uenG+58FEZfwSdokoCj0co4c8xsoafrb5TEETIPh6ulqyK+v13nYP+rjMWdtzJGZcd9GGkSpNIM3tPGCs4lildewVInOTzsgi1itwXcaz6Yl/CcGumjEXzf3JEyWndf0BDlK3bpmH1kudshdw0h0SkczvtB9hv2WYMAmTbgnJAoasb5MUIhM8vMOG5sQvDc0VVvB6a2oWe/5twS68oAZpJRYwlnDUfARuhoadtRQ8S3xySqUsdXb5IKig66V2FebiaqPHmPJGTpbAe4AhDisr3p+uDE5AlsX928+8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0qOGqKHiKtDniUfHyan+O2QHeXS0qJZkUvJyZdfkvc=;
 b=GoJrcj/sIola3RR1qtzFgz42x19nbPB83Sfq9bcOMYUr0nLam0eDvsudHjeLL7r2QTo2UWsN8ZHJFtPo2fScRr7fh4qMroWfHvZgHBw8Lj96xcfj8BdYC81qZuay1Jjfz6LBOJsKzPCrMmCOMXG98/7Xux7vFr8k67ZzRq8VkUdXG92bBy8E03yLMb/6emGjwoO/rvw67ong/sOCNZ6jf2BpYWXjvGjyz16sBdUAhXp7xykAxWDdYiwnc65kNqcl3hdRuO9bSQ4y4O5cZNWVrArGxegmPHWnReeqYmr7FjOj7B3gNbbBp6ENnFZw3UJwg50LFZGEr6+f56XLuOKqQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0qOGqKHiKtDniUfHyan+O2QHeXS0qJZkUvJyZdfkvc=;
 b=hpMo3yDRqpsL6Rnav9gvxWhQ/UfMzVE0D2CbLKmFgif1ZCQqW7gjTQX2frQy3CXGJ18MNfLRIoMslt77eldk+tGD6qyS93TvPehh/f8kTr6sMuB7jQsbmhziSN71fPwHInhQv6yCSJwihdrh2mAr6P3OTOIrQn/36c0dI4+65vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 09:33:13 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 09:33:13 +0000
Message-ID: <4ac27732-3697-43be-9585-35be67752938@cherry.de>
Date: Fri, 8 May 2026 11:33:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Couple of clang warnings for Rockchip boards
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <CAFLszThQ+kyCkojFm2=VNtLTtLDYT4iVmpqnto8awiMVqsct0Q@mail.gmail.com>
 <20260427144630.GG41863@bill-the-cat>
 <CAFLszTgga6eFp2aPF-MzJEqeqcEV-bMJhb4_ph_bE-1Dv4e_Cg@mail.gmail.com>
 <20260429142547.GT41863@bill-the-cat>
 <eab00828-0e87-4761-afc8-1a3295d18a26@cherry.de>
 <CAFLszTgKRS7xebQ0Y7+fOsTM7aUwnEH55L_H_NbaN_p=70THDg@mail.gmail.com>
 <20260504173544.GI1614990@bill-the-cat>
 <CAFLszTjESKRGDD3wi4ftxRdXR1X2JZcqybOMHdUYboZ7xjN3Qg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTjESKRGDD3wi4ftxRdXR1X2JZcqybOMHdUYboZ7xjN3Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c74204-c7ea-462e-3671-08deace4d313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|22082099003|18002099003|4133799003|3023799003;
X-Microsoft-Antispam-Message-Info: WNV3YMrmJdoBLQpeIFee1L4kyMzwLcXDVYH51V5Bz39kPIZp3GjOLTGEgriEg0TTTUMd2YsWwaAr3Rtval8TiLuy86+k/Kd8sNnQTeJzs3E8oPnQkEReRqu+7J5CF/QHQ3hO2SeOZRQVZ9sZc+9mZG3+maxvknXNBZ8D9s0oaZKYNlRYoGXHmZYUkJVDQMYAEIm+H1R2yLXuRbDfTy7ACXAobwmSJZ8ZJMk5YX+h2lbOtrMmQL4EWw7oKg+3DUxPDSAVzxGvUlUNhVzJacyrd1+LzjLc41zyixqCZ9ENgXIus7oQVvZemJyliHQI4j8Iqz45Ndk3z1Jhzosd81ReggIY82paJQ0mdw1SQEHr+A0YLE+nO5uokmbnnvRArjfBNeFbjKwhag3i4mda6FIsag3Y2f2Gi+oEGtDpuHNpoOD4HIk4MqR04TudO4VfTW5fyDWXIcSqXYSyRicgE2Lc/r4q86hJlcwqjnOaT6eYh3K/ApvgXjgewOhxFZ2CSAAmPJ+Lc/8JIvx6maX7eP0PQk3I2+wG7ixLWKFQrT/X1eEasscy95YFBYiqnBrHoneV/GagNxwgGq6qipVMo2FLZBmM6EHswtjTCR4mIncdgZHEUviUAOWJ/J0A18dKXKm3sJbc2wnpxEan+/5sEdpIWJIeKkmZq4/1wH54F2bR9KzkK1ZX3LZr3iHzYtXrxkoRtXopmSpCYzNGQViLsyaTFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(22082099003)(18002099003)(4133799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0JNVmo2WVF1VC83ZlBVYlV4bENjWnJOSmtMTnZFU2VCcUFaQnlzeFBXSjI0?=
 =?utf-8?B?YThUdGt6cW1BMkpHcEJUc1lMcmFqSk9CNWRCL0xic3ZYQ3FKZHlHZmRsRzF3?=
 =?utf-8?B?RzIxb1FBeUNTUmRNQm1BcGkrTGJYbGFSanJuaXdhcUtOYlJvYjViRlFIVC8x?=
 =?utf-8?B?NzZyeXZXcEd5VEZrSXM4bFJhZmhLTmNPTzVMR1NxVkUzemJZdWdscmd1eVJj?=
 =?utf-8?B?aFU1L1cvM3hwSGJUS2VGazZNNHlQTERyVnFFaFNpT0phRWxVa3RGejdaOUZN?=
 =?utf-8?B?S3JMbm1nbVowMlRGZkZTcjRHeXdXVXVGSnFVZzNFNW51STMrZ2x0cjhDWWVp?=
 =?utf-8?B?VGNRRDhQZ1RyYXJ0elZsRHVHTTJCb3BYV2p1NEV1dEo4QTRYcnNSU1d2T09j?=
 =?utf-8?B?eVBDZno2L2FNV2oyeXluWTBIeDBSRG10eU5paGx3RGc1NVJ0NWZFODNadHov?=
 =?utf-8?B?bFY3RFR2R0w3ejUrTFN5cS9KTG52Vk5QSnhNMjJSRnY3cS9DOGV4OVFzSExy?=
 =?utf-8?B?eGppK2NGOWRYakFUSmQvLzc2eVhPRDFVMGVDQXFMSk14ZmFLdFpDQjVYaDRJ?=
 =?utf-8?B?MW5CM3ZNWGtrNStpOGZhbzFpMklBa1FhRm80K2RNMm5RVzlRbFBuV2piNjBB?=
 =?utf-8?B?TGlPclE0SFUrUVArUEdza1B5eW9lQ1loMEtmSTQ5V2xja0oyZ3lqMTRteXR3?=
 =?utf-8?B?c2hkQjE5ODRyejE0NVFEanZZL3NTNGlqNVJvVXMrSXBWUHFnK3lQcHUzeE50?=
 =?utf-8?B?RkliSDNySUl0bFNCdjRETFVMbGcyVm1NdS9UY2FKRFhJUkJXbHdFSkVOcUhJ?=
 =?utf-8?B?SjB1U2dYeWEvd0taVzg1dHV0VVpvLy9CUnZwSTFjbEw1QWFaaE8xL0VSR01r?=
 =?utf-8?B?SFF2RWd0Vy9CZFNCQ3V3WGJ1c2ZqZmpxc2hiRE5rWGYwNjZjamxpWTFLMUhE?=
 =?utf-8?B?NWlQcEgyeURqQlUyOXR6OTBQd29vYjQ1akMrTHdUamNUQnZ6R0tmTmN6N3lJ?=
 =?utf-8?B?bElBYnBTd2J1cFFLN2h0MTZOTHZiQlZscUxZRW5wNGhRWXBGRkJ4VWZ1WExM?=
 =?utf-8?B?RHNFeFdaSmkwMXo3bWZCQnNNeTlEWC9hUnB0c05KVS9rLzA5OGRBY0o4RHpK?=
 =?utf-8?B?SWZOcy9QUm5DaDBoQ1hPTzdUeGpJZUxxbU5XdDJpRGZNWUd1cW5iZGJxYmR3?=
 =?utf-8?B?czlUVWpOcUV6YVBFL0xCaWRQc2dSd1h2VFlBZGJPcHdrTXBELzRSY09JWlhV?=
 =?utf-8?B?NHg1c3pJajFySjBOd3RlZXdwVE00MEkrdkcvcFVwWUlKSHZmcEk2UXgyZGtt?=
 =?utf-8?B?MGpRaW4yNzkwS1FURUthelNMc1Z5UFRjVG5oWGhZUitpTXNlbmFrMk1BM3JS?=
 =?utf-8?B?Uy8zTjBmYnhSMDNmcGR0ejVQV2N1WkViY252S2N5cmsvU1dBZnk2K2FUUGtN?=
 =?utf-8?B?MGMrVTh6Nlk1NEhITjVoejBTWGkvZ1NzeGppNjlVY1BwNWxYWVhjZ0xLU1JX?=
 =?utf-8?B?Q2QwZHk5NlZJZVVEMmZDWmNLbU1HSFkwZC91ZkJLNElnM1BsQkY0bHllUVg2?=
 =?utf-8?B?bzdLRFlkMFJvV3F1Rm5qWDZuZzlMY1dCeTBuUXFYeUZQdlJBZU1YN1ZSRVVt?=
 =?utf-8?B?QzJHNGhGWG5lYWF2dVB4aHM5b2VxNjV3UkhENW1NbjFHSCtZNkc5ekRRMTNn?=
 =?utf-8?B?YiszRGxTMThaNC9RVXhTcHdkK2FTUHFWUlVMZ2QxMTNqajhveGlxamZFR1pK?=
 =?utf-8?B?ckZwRm8xZldtS2c1NkJhMlc0cENYb3IyWnYxMDEzQURLNHU0Q3A4djE2WTFj?=
 =?utf-8?B?VFI1bjVudFcvaXlKZmlDVkJrTnp1bWcyQ2pGVzg0cmxrNG5HdlBZeERzU2pr?=
 =?utf-8?B?bWg2MDR3R2dxQXRRbkJ1Z3VqbzhybnprV2JwdDE1Uk1iYkJzWVEvbnNVMXRm?=
 =?utf-8?B?UGF4b1JLNlUyWGlxT1hSeWkySUEyMTVDMkhSMFJNN2tTK0NoUk4reXFrOTJ0?=
 =?utf-8?B?WnRRS25kZEFLSVVSWGkxUzAyOFZMa1NCb1B3R0QrR05rWjY2UytzRng1RmdT?=
 =?utf-8?B?NFplV0VUVE5qdUNGN1paaWhJS3ZYeVpqaEIybzNtaXJpeE1Cc3I3anprQ1o5?=
 =?utf-8?B?M2RVZ2NTN1RMak5JVnRYRHczUnJsQUhzT1dTaFdHYnVidmVEd01xQi9HaXdN?=
 =?utf-8?B?SUZsYUdjVVNPMmd3Ym1MekdndWVoeStSWjJ6M1V0MnpzazQvTmx0eXg3OEp2?=
 =?utf-8?B?TmE3eFhmUTg4K0ZaUDUvVHhxQkp0YlVCRmwzbWtUcEQ3RlNacGdQcVNCWEdW?=
 =?utf-8?B?Sndvd09aTGJKUjZGbG5lUGx0bWhwMlplU2RmRDBRYVFBakdFbHVVQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c74204-c7ea-462e-3671-08deace4d313
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:33:12.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtcl5+HwJZh5e8Wz9WdZsAlbZMJu+slNtOwxgyZMB+YFi+yicursmiUG+RiCvzPFA8wbz1iQaddX4hIJAMsOjubFWZ8LVEULakTNvFAVgJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
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

Hi Simon,

On 5/4/26 10:40 PM, Simon Glass wrote:
> On Mon, 4 May 2026 at 11:35, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Mon, May 04, 2026 at 05:14:13AM -0600, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Wed, 29 Apr 2026 at 10:32, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> On 4/29/26 4:25 PM, Tom Rini wrote:
>>>>> On Wed, Apr 29, 2026 at 08:18:14AM -0600, Simon Glass wrote:
>>>>>> Hi Tom,
>>>>>>
>>>>>> On Mon, 27 Apr 2026 at 08:46, Tom Rini <trini@konsulko.com> wrote:
>>>>>>>
>>>>>>> On Mon, Apr 27, 2026 at 11:54:09PM +1200, Simon Glass wrote:
>>>>>>>> Hi Quentin,
>>>>>>>>
>>>>>>>> On Thu, 23 Apr 2026 at 22:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>>>>
>>>>>>>>> Hi Simon,
>>>>>>>>>
>>>>>>>>> On 4/22/26 11:57 PM, Simon Glass wrote:
>>>>>>>>>> Hi Quentin,
>>>>>>>>>>
>>>>>>>>>> On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi all,
>>>>>>>>>>>
>>>>>>>>>>> I'm looking into force-enabling CONFIG_WERROR for all Rockchip SoCs.
>>>>>>>>>>> First, let me know if this is a bad idea :)
>>>>>>>>>>
>>>>>>>>>> I don't like it, as it makes development slower. I like to see all the
>>>>>>>>>> warnings created by a change and tend to fix them iteratively. We
>>>>>>>>>> already have a warning check in CI. A better approach is to
>>>>>>>>>>
>>>>>>>>>> Can you use: KCFLAGS=-Werror
>>>>>>>>>>
>>>>>>>>>> either in your environment or on the 'make' cmdline?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Well, if it's during development, you can always disable WERROR? The
>>>>>>>>> fact that I've never actually enabled -Werror locally in about a decade
>>>>>>>>> in U-Boot probably isn't a good sign. One of the things that make me
>>>>>>>>> wary though is compiler updates with new warnings. I've tested with
>>>>>>>>> clang 22, don't know when clang 23 is planned to be released. GCC 16 is
>>>>>>>>> about to be released as well.
>>>>>>>>>
>>>>>>>>> By having the check in CI, we have a longer-than-necessary feedback loop
>>>>>>>>> for contributors. Has this been an issue in the past? /me shrugs
>>>>>>>>
>>>>>>>> This is strange though, because people should see the warnings during
>>>>>>>> development. I wonder if it is scrolling off the screen.
>>>>>>>>
>>>>>>>> One my bugbears is non-actionable output. When the build succeeds
>>>>>>>> (with no warnings) I see no output, using 'buildman -I --board xxx -w
>>>>>>>> -o /tmp/b/xxx' or in fact these days 'um build xxx'. This uses 'make
>>>>>>>> -s' under the hood, so that it doesn't print a huge list of filenames,
>>>>>>>> etc. I also sometimes do a 'fresh' build with 'um build -F xxx' to
>>>>>>>> check everything is clean ('buildman -m' does something similar).
>>>>>>>>
>>>>>>>> Note that buildman returns exit code 101 if there are any warnings, so
>>>>>>>> the build basically fails.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> No defconfig seems to be setting this option, not sure exactly why that is.
>>>>>>>>
>>>>>>>> To me this is a difference between 'functionality' options and
>>>>>>>> development options. Putting development options in Kconfig makes it
>>>>>>>> harder to turn them on and off, since you must either edit the
>>>>>>>> defconfig or edit the .config file. It is easier to just pass an
>>>>>>>> environment variable.
>>>>>>>
>>>>>>> The point of a configuration is that it configures the build. Stuff in
>>>>>>> environment (directly or make FOO=bar) is a workaround and anti-pattern.
>>>>>>> Having to run one of the config front-end to change the config is a
>>>>>>> feature, and good thing.
>>>>>>
>>>>>> To give an example, we have boards which enable LTO, but it is
>>>>>> sometimes useful to disable it during development - it used to be a
>>>>>> huge time sync but something seems to have changed recently, as I
>>>>>> don't see much of a performance gap now. We don't want people
>>>>>> disabling LTO in the defconfig, though. The same applies for things
>>>>>> like V=1
>>>>>>
>>>>>> So I think there are build features which are of no use to end-users,
>>>>>> but are helpful for development. That is the distinction we have had
>>>>>> for a while and it would be a shame to lose it.
>>>>>
>>>>> Yes, the LTO thing is a good example of something we shouldn't have done
>>>>> really. Outside of sandbox you cannot just disable it.
>>>
>>> Are you sure about that?
>>
>> Yes. Outside of sandbox LTO is enabled because the platform binaries
>> will exceed their non-optional size constraints.
> 
> That is certainly true for some boards, but I'm not sure it is very many.
> 
>>
>>> I seldom build with LTO, except for CI. For
>>> an incremental build the non-LTO is often twice as fast. Most of the
>>> time when developing new features I am just trying to make things
>>> work, so it is big time-saver in the IDE. To some extent this is
>>> changing, though (LSPs and AI tools). The main impact for me is with
>>> sandbox incremental builds.
>>
>> We could maybe just drop LTO from sandbox, now that it's enabled more
>> widely on hardware.
> 
> The nice thing about LTO for sandbox is that it tests a different
> build path. We could perhaps disable it for just the 'sandbox' board?
> 
>>
>>>>>
>>>>
>>>> FYI, the Linux kernel defaults to CONFIG_WERROR=y. See commit
>>>> 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")
>>>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fe617ccafd6f5bb33c2391d6f4eeb41c1fd0151).
>>>
>>> Do we suffer from this same problem?
>>>
>>>>
>>>> I wouldn't necessarily recommend to switch it on right now, but I think
>>>> it could be a good idea in the mid-term. We're also very far behind in
>>>> terms of warn flags compared to the kernel. Syncing will take some time
>>>> though. For now I'm looking into enabling -Werror for host tools and
>>>> this resulted in (so far) 21 patches.
>>>
>>> I must be misunderstanding what you are referring to here. I don't see
>>> any warnings when building tools-only - certainly I would not put up
>>> with that. Do you mean that you are enabling additional warnings?
>>>
>>> We already have CI checking (which fails on the first warning) and we
>>> already show the warnings for normal builds. Importantly, without
>>> -Werror, we show *all* the warnings rather than just stopping at the
>>> first one depending on -j, etc.
>>>
>>> So forcing this option seems to be a tax on people who fix warnings,
>>> imposed by those who don't. It really should be the other way around
>>> :-)
>>>
>>> BTW we do have KCFLAGS which can be used to set Werror (and also
>>> perhaps other things).
>>
>> I'll note that I just had to request changes on another patch because
>> they didn't realize warnings had to be fixed. It's quite likely that
>> making CONFIG_WERROR=y will save more people more time (maybe document
>> make -k? I don't know what people don't know about these days, but I do
>> "make -kj" a lot when doing the randconfig stuff for example) than what
>> we do today.
> 
> Yes, could be, particular if people are not using -s with make. I
> really dislike warnings quite a lot. I'd be happy enough with
> CONFIG_WERROR if we have an env var to disable -Werror like we have
> for LTO.
> 

I'll let Tom speak his mind whether that's a good idea.

I really don't want to be touching scripts/Makefile.extrawarn once 
sync'ed with the one in Linux kernel's, so adding some logic in there is 
a no-no in my book. So it means we can only change the CONFIG_WERROR 
symbol. But we kinda don't want to rename it as it'll likely be used 
throughout the source code (hopefully spreading more and more over time) 
since we also want to sync as much as possible kbuild/makefiles from the 
Linux kernel. So what I thought could be a way to make this more 
palatable to you would be to introduce an invisible symbol which depends 
on an env variable.

Something like

config DISABLE_WERROR_FROM_ENV
   def_bool $(success, test "$(DISABLE_WERROR)" != "1" )
   help
     Allow to override CONFIG_WERROR from .config via the DISABLE_WERROR 
environment variable.

config WERROR
   depends on !DISABLE_WERROR_FROM_ENV

for example (untested).

Cheers,
Quentin
