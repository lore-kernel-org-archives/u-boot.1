Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14FBC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 10:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4F187776;
	Thu, 11 Jan 2024 11:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A0kbZ2Y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79AB087776; Thu, 11 Jan 2024 11:20:16 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8153387613
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 11:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqbih6iyK3bwvA2dgkMU7ad0RIrU+z+oBSZohEJ3bMY2WBz8Sw0ct5+FDxAroVau7BF3WVkWVhXSojEti5GOLK519q6Js5PYnWFfxjgN55zdrMOQsCSmmPRjGFLe4ok6QLBDfd4k4gRnTdtAX5cKt/Qv3MXdLK1MPJlBxEljZbF8W35hYI/kBpYmWnllGPACPalG75EbHSH/bJzvIzpXOUf0EziULV4islHaKW1bz61KPH/K0UJ8PlHbq2hmYTVFqSKGQx+NGeLt1RqPmqOXGaUMjnSpBQamdGMed2AvRtD0eFIz1M0jBSWXWo6HK4R8rS2X8boLAAkS97V5fJmeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZqA/XErzorj63OG8qHBMjqjSXBY4pVDkqsej/r/IIc=;
 b=Y4fPFDuc4p0Q0wY/J1bqURJCW/Ff5OaKYZJ+d/HqT0WMCVNahpbKXzqm3B8yeaK8ZrXOTrzT6/zIgn94cP9R3nQUxnAkQoNVT+rzPMU6e/Xes4bF0Y4DH2ySNeeby6m6Uijemdqa7t/uNWBPRYp1qksD8GSFgLMKJZv0GaFxXE0Q0N0wazvw7Wx1f62b2mVBUOY3e64ZkHmIHDXDMeqUZDw0W4A64mDpZNR4msjEHn9iZQ3RLdYYn8BSzbcLQ93fW1PRFjQlUoUyPTzfsEhUQqrQVK42n+iVZeJhbAxeajjO6aci/KsDNmik5+9i4qZfp3z+nErgEflCzxTHUyj3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZqA/XErzorj63OG8qHBMjqjSXBY4pVDkqsej/r/IIc=;
 b=A0kbZ2Y6Unde07EYT5MiillHvZ0fng9888hcsWtbH5foryY6ztmZleJFI5T1mr+qWUEPvZbDzzlNUblmINL+lpEYI7mImdwzkKur46pnt2JqUpIrg0/Hc9nW0ctzYwXKUyQzIhwhSPhO4iMQWmrQJMb99cgppkF1F3QEuQyfl+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 10:20:08 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 10:20:08 +0000
Message-ID: <eee42894-6ff0-43f3-9e30-1ea1253386a3@amd.com>
Date: Thu, 11 Jan 2024 11:19:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Move address/size-cells to proper locations
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 u-boot@lists.denx.de, git@xilinx.com
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Saeed Nowshadi <saeed.nowshadi@amd.com>,
 Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>
References: <f2c1cae3b845d4609f8181f2dcb09a55f705667c.1704893723.git.michal.simek@amd.com>
 <2ea988de-43cf-4f06-b8a5-67bac1718d31@linaro.org>
 <d07c9f9d-8106-4bc4-8630-cb36176cdb70@amd.com>
 <ceb80f6a-dd09-49e5-8b4a-e4f6c1e2d0c4@linaro.org>
 <606065db-7fb4-4e82-9c08-1829ee81900b@amd.com>
 <b61ab697-299e-4088-8d5e-bb9b09e807bf@linaro.org>
 <27f66f6c-8158-4ead-99c8-f25567d23955@amd.com>
 <63c0f18e-6249-43fc-9376-ad805fff7c2a@linaro.org>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <63c0f18e-6249-43fc-9376-ad805fff7c2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0294.eurprd07.prod.outlook.com
 (2603:10a6:800:130::22) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 0837afb9-bd75-4079-a2ec-08dc128ee2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JIggoBEYsSxdcc3pzez6XewdZZPVN7sajwa73AJE6z7Z1/ug5E48tQaWC2BV1ObkBSzkkvbR/khYpDtUl7T4OATMWN9Tf7yJOAWRg7I4HYgvrT8c/DPNSk+pDf0YS9DKDnwgGL846DXnfobGq7NNz9nbo03u99SYODL9tll9o/yM802HmIDCIu4Ence4fSqEscK75sa4FeUWMwIgLb1K9HLZQggm2djEuO2FeWAezfXq3sh6IWfVWEW90oiX9TXuneQusrd+gGaKVRrNWqyz7LEAO5mB76JukSYDL3ql6sr0Mh7B44DN4f3Nm9Imlun7aheRCZyUC6jpznRcr7gHXEtGaOlmlMyu2rbBQesukBa90GsAXnlVDmc1vXZD9VGaVIttTYolYlcLMDpPEyp6bHoI6uoXJA89gfWesW/JotUr0M72Fbz1dvGlB5uOhu063MQSWR3jgi7itjEoTN0ixc/ASanH9tuiRywMdeMWtZIusFcpYeT2mfOga51yExIdAbfCT8gNVinTqlr1Tmf+KC8rx643AegaTC+UYO7K+5Bsa3lRrduFwBoDh5b+cEXtQZopKvE/KAhE1Orow0vOB6zOMEByRqNyXEHbxwDLF0ilTJvGsle+/Lf3hMOq/F/v/5UC4eJJauihE2Z9MqE1/HGYbBCPdSAO9XDqPdqsDKac/OXy1LmEmsYufwR3Icu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(6506007)(6512007)(53546011)(26005)(66476007)(478600001)(66946007)(2616005)(6486002)(6666004)(31696002)(83380400001)(86362001)(66556008)(54906003)(316002)(5660300002)(8676002)(44832011)(36756003)(41300700001)(2906002)(4326008)(38100700002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9vdVZWUVpwaEFrSlpxNVF6UFUzS3JBbEUzaTgzMTNzRmY5TnRMVlNSdzFG?=
 =?utf-8?B?Yys5TmtieXM3ZTdiblozNExyNU0raUp1NnkwRnlTeFQwNGx6a2lyclg4THNW?=
 =?utf-8?B?MERORFBDTEl0TUdhQ0NSbis1ZmZ5aXZRYjVoQTJFMnphVzFQWW1lcXh2K3FL?=
 =?utf-8?B?RUUwcW5RK1RCRUZtbUVKTXB5NGdVNzhxUGZzSDI0cVZMNHlSR3RGOTdtYjE5?=
 =?utf-8?B?dVBYblFReHhRUEs3cmtHNUZxMS9ISExOM2VkYjFvUkRWcytRSDY1YVduNkty?=
 =?utf-8?B?djRYVHNkUTVhRHdQNTA4M05EcGlqT25jSHgybmdyTCs4aFBMaTk1R3g3a3Vi?=
 =?utf-8?B?KzZuTlowM3YwaHRvR2dsVjhmS29tR0s0dVhqRWx1UUZXdWpuMHJueEl0NTRU?=
 =?utf-8?B?VGhmL3BiTzNZc0tCV3ZHTFZWUHA1WllxRUdTYVl2VWwwckpYRW5pamUvRk1T?=
 =?utf-8?B?VDRqU3J1NXZoRHNWZjBHNnN3RDJtMzhsQTd6VFpQS3BLK0JhSm56anltUm1F?=
 =?utf-8?B?S2lYUWtVd3VWNWdsb2Q4dFUvUHJaY3BVQ3EyRGJ6emJrVlJ6RXowTnNjM000?=
 =?utf-8?B?SjBQSGc0bitIYnVXKzc4TFBuY2lJeW5TMFFjTnlrTk52QUtxc1p1ZHFUdEoy?=
 =?utf-8?B?SHhpN0lhbEhwQ1FxNXloYjFJRTdhUFRMOXJGUDk1OUY2ZWNZR1c4THVGNXZS?=
 =?utf-8?B?QXR3TVF4NlVKR2pwTGV6eDNOaVRoWDBGa0V5dkl3TGswS01FM0p5cTlKNFFp?=
 =?utf-8?B?aXlXb1NwVFBzS1diMnhGUC9nbkZjOVNyNmpkM2k4dXNPNnJLNkN2ZE4xZjVN?=
 =?utf-8?B?WXRFWE5VS2c4aE1ZeVM2UFp6UllHa0Z1NkZCSXF3emhwZnJSMDJIQ3RSbUxl?=
 =?utf-8?B?ejNXWm5ZUVhIK3RUS0V6N2IyTnJZUUVrekl0M3JmVWtmL3NGSGV4TEE3QWo2?=
 =?utf-8?B?N3hhMmcwcEFjTW9pL0Y0N1FSZGFQT1JCby9Fdjdpb2lRcktoNGcxRzlXVjhG?=
 =?utf-8?B?QTdPUDBYWTRDUWk0T3l2c0hCU3pqTUlLRGhqK2VkUkNvMlAyUTRGMFVZSWtF?=
 =?utf-8?B?SkUzVGpwZXJYeTJIN29GbGhXWGxKL0ZJT2E3MTR1OXBMQTQ1ZUJUSUwxaWJQ?=
 =?utf-8?B?U0hoMktuSEJ5ekRqdlZFZ3owZHlTWGl4dzlTcXVJS0Ria3RuNU50MC9zU0tL?=
 =?utf-8?B?OHJBRnp4WnZwTWsrZ2xCNUtpcS9WZE5TTVg2aGdKREpDbng0NUw5TnRpQ21z?=
 =?utf-8?B?aXpGME9oMkJsZCtyQWdxTDNnZ0JHcGsvL3VabnNBZWVOVjh2WG5lV3ZBaUl4?=
 =?utf-8?B?cXYyWG56aHEzOUl1aEdBWEQ1a1hrRTZVMzQ3SlV1WEVtL2FkQndjMmo2Ti9n?=
 =?utf-8?B?bnE4MEk1MmxWSzFmelVibFNzdnY2WDBZR096RldmRENmVlZSZ051K2JaUTFh?=
 =?utf-8?B?N04wMElGeEgxWW1TVVdrcHFMTlptK2NIZ3l0enEwL24wMEErQXFKZkY0VFEr?=
 =?utf-8?B?ZW1GSEFzZjZvMHdYMzE3M1ZGNHBibEp1eGhzTC9OSmRFWjBWdFk5NWxtZnpV?=
 =?utf-8?B?cWhLeUhNRFl0bUtTRHgrb0l3QVcwNVJscW5jWTU1U3V6VmdrVzVQRDdZcGNL?=
 =?utf-8?B?ejk3Z3VVcnJoc1RwY0VNaVFiV3p6aVhoVjNxbE81R0N0Y1hoQllSdU4rZjg4?=
 =?utf-8?B?NVh2bDVYSTh6Tmphci9sSm9FdmFET3MrSkxBM3dCQitjc2w3WXJTMDdKY0w3?=
 =?utf-8?B?R29NbmUzbE0xZ1BraGQ5VEpUd1RJaXJjaHIzeTBVWXhBUkVwZWk3QlhlV2Rl?=
 =?utf-8?B?U29vS01GLzJTdWErL0NOSVlxMXBMMm5sa1EwZklseTFrZFdFUjhVbGxnbmx6?=
 =?utf-8?B?THBCck11L3JpeCsrZmI1elZabjQ0TWU0eFJrUWFFSFY4Z3FlSlZ1dlI0Z3kr?=
 =?utf-8?B?SHdpK05BalJLUzI4RS9HK0hkZzdPcituNDhGRS9QOEhJQlplSjd5SkhFNXNJ?=
 =?utf-8?B?YUJoWFNVYVlCTmZpWFNSMXQxUmNOSVB1Yk5yb2Z5NHl6OTdpUlUvd2FyTW55?=
 =?utf-8?B?RTZyckN0RVh6RXNqOVFrdnBpSUo2VkNpRDMrR0pxNnlyb3dhWXpaa1V2Wlo0?=
 =?utf-8?Q?0wvQsm0XLrFe0dLhZZ0aXY2z6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0837afb9-bd75-4079-a2ec-08dc128ee2a9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 10:20:08.0098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vPv1ehY6WZKVBOeKGXnBn2n3dD3Kzex1vm3X6vQuaVGvhrFW4nwBWQP+LYrWWWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082
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



On 1/11/24 09:52, Krzysztof Kozlowski wrote:
> On 11/01/2024 09:48, Michal Simek wrote:
>>
>>
>> On 1/11/24 09:18, Krzysztof Kozlowski wrote:
>>> On 11/01/2024 09:10, Michal Simek wrote:
>>>>
>>>>
>>>> On 1/11/24 08:56, Krzysztof Kozlowski wrote:
>>>>> On 11/01/2024 08:09, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 1/10/24 22:27, Krzysztof Kozlowski wrote:
>>>>>>> On 10/01/2024 14:35, Michal Simek wrote:
>>>>>>>> Move cells to board dtsi files from generic zynqmp.dtsi. Changes are
>>>>>>>> related to qspi, spi, nand, i2c and ethernet nodes.
>>>>>>>>
>>>>>>>> All errors are generated when dtbs are compiled with W=1.
>>>>>>>>
>>>>>>>
>>>>>>> I don't see any errors on some other platforms, like Samsung. Isn't the
>>>>>>> actual problem that you do not disable the nodes (I2C, SPI etc) in DTSI?
>>>>>>
>>>>>> On i2c node. Bus is present on the board but it can end in a connector or device
>>>>>> which we don't have OS/bootloader drivers for. But we have drivers using i2c
>>>>>> tools or u-boot i2c probe. It means that transition should happen.
>>>>>> On i2c interesting is that W=1 is not able to report issues when you have i2c
>>>>>> mux described like this
>>>>>>
>>>>>>                     i2c@0 {
>>>>>>                             #address-cells = <1>;
>>>>>>                             #size-cells = <0>;
>>>>>>                             reg = <0>;
>>>>>>                             /* HPC0_IIC */
>>>>>
>>>>> I understand and it is quite common, but it does not explain the case.
>>>>> Your bus should still be disabled in DTSI and enabled in DTS for these
>>>>> cases.
>>>>>
>>>>> And how exactly do you solve the warning for above case?
>>>>
>>>> I had address/size-cells in dtsi (entire SoC) and then just enabled the whole
>>>> i2c bus(for above reason) in board dts file without any childs there.
>>>> Then W=1 reported that there are address/size-cells without child.
>>>>
>>>> Another way how to solve it would be to simply delete address/size cells in
>>>> these cases.
>>>
>>> But your device without children sill have address/size cells, doesn't
>>> it? Or does it mean you did not add it to such cases?
>>>
>>> Anyway, I have exactly the same case exynos5800-peach-pi.dts with i2c_2
>>> and no W=1 warnings. I really do not think your solution is correct.
>>>
>>> Also, address/size cells are properties of the SoC, so rather DTSI.
>>
>> Let me take a look at i2c case again. For gems it should be clear that I need to
>> remove it because when there is mdio node I am getting errors like this.
>>
>> arch/arm64/boot/dts/xilinx/zynqmp.dtsi:627.27-641.5: Warning
>> (avoid_unnecessary_addr_size): /axi/ethernet@ff0e0000: unnecessary
>> #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Yes, which also synchronizes your DTS with kernel:
> See: eb2f7ff7de56 ("arm64: xilinx: Remove address/size-cells from gem
> nodes")
 >> BTW, Instead of working on U-Boot clone of DTS, I would suggest spending
> effort on re-using in kernel DTS (see Sumit's work using rebased-DTS tree).

I am aware about it and that's in my plan too.

I actually used Linux to report these issue but waiting for 6.8-rc1 to happen to 
send it.

Thanks,
Michal
