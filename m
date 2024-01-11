Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21ABBC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 08:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E498765B;
	Thu, 11 Jan 2024 09:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wYigQif2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF604876C4; Thu, 11 Jan 2024 09:49:14 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D5128745E
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 09:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6f3LZ+KED+zQj4Y23e/0Qwdb+zIazVmux2cxC0ZMY9SquU09+94wCIFgPpf1icIsD5B1OdSAMJlZ9XYiaqWpKfljyVZghcwgM2hutGM1mLzaINDl4RPFKob1DQ0SKNLkdz550L3hRYcHnZ4PJAhU3IfGHgeVFYTiXCRfvGjpmho/KkapJMpHzjdcr7sG6iehocVMdj/Oua5/7RLXZSq4/HmhOHfzWuWcl/RBnbcOXq2lbPJ8adYLreRzsH+70Zf3/vwKcQOlw0gUQAs9eDAOfp96ynw1BxywlbFhQJtDENdle3Ly94oj173N5uSbXezOrDKYNWVpEPUH8hKglnf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjaj3Ca0m1i9XD9f2/+q8z7HTGxRUUvrjdsBOFvAE+o=;
 b=FedIz767sTsI5v+UPOwLFQqZIaZaCg3fO36lX3p+tNnea3wPKKV2u1fUrI6qTpEMAHWR4AihAITRwk7fBglDVZVaQwLnzuQ/Hbqi3LXPZRnJ2suSSgzQa2YlxAFy3RF3G4BwD7S+aQbrUL7WmqLM8ze7GeGyi8lXN1+k48t9n/iOBrM+k3BpKiWN1knrLixtVsL6cOeCaGRSN+HhTUciJXIs21GmYtXvW8IMDNDPpNTzrvTim/RlYw3raUmO+bS7TktIb0EvYcOI2ArYdY82ayUzecFawFYNibuEWwJH9a9LG38456KXx3q0JWctxeIkWIXoCu9rev+GFez6lqR7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjaj3Ca0m1i9XD9f2/+q8z7HTGxRUUvrjdsBOFvAE+o=;
 b=wYigQif2+Hpi4ecX0SgKi08RSMN+rU1VxQJ2tLn8yRv4EUnMqnPBK6fBJ2dju9uBbhAXJoW2MaL514vY/x5JAwqsqb8BEBfjDiGoa8yi1/6hvjB7cCh0MQTcFbJVFaU0id+TyXQUp6SZZNyeGB9Q7t4tL0haKyk93Eic8xFp2XI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH2PR12MB4873.namprd12.prod.outlook.com (2603:10b6:610:63::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 08:49:08 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 08:49:08 +0000
Message-ID: <27f66f6c-8158-4ead-99c8-f25567d23955@amd.com>
Date: Thu, 11 Jan 2024 09:48:54 +0100
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
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b61ab697-299e-4088-8d5e-bb9b09e807bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0309.eurprd07.prod.outlook.com
 (2603:10a6:800:130::37) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH2PR12MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: b716233c-2478-4d68-e152-08dc12822c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jz+1iATaI2XPWgTO2YyUqh7A7WXx59BmGIhWLgtAC48rGP2QfQo3Q+KzroXU/bcoxxBdquvJ8rWe0baFvTFkjCwnrnp7pdQ8a29p6ZikfHpPXD22hT4IbhlMXqj3qbGvL9uDUOtBJBUKADAVDPFfMXkLPrMbTXHt2nwy2Dc/TJoPlxVTVOgbgUgjKUC+97xtLutFVccKrH7O+7B7x58cFfHt0oVA1iaW/QgajCtf2rLCLqbc+HL4NAtyCTTVxcLGbASJ/5vlPJOAXVmLORNnwKrdd1TWvOMQN+2L7Loyep2UudQGKHFf6wM1EjUJf/yCfdm6oCwvS4amgkcBJqqIpnDUJdUVrsVNyJAlKPGiaqvh8llkqGt3SO9aPyi8PnDNr1SkQAp7LGzFcAhr5fO2SR3b2/SMHzLwywbtStuk9RfkJe8oFAKAXhcUzzomHhIluqME90dkk56nu5NrzdMqV9Z0uQ7WNp7AeMrDkWicw3nsZYUg/ek6UUBhhMBEYEESltYFXG/3NKL8gIBPMXnlAyJklmK12EBYXxnAZZfN291D8cYCAgQn5bWnomfXwSxCBnGiMbJqE4dF4CafCbyrTmdQ4e1W3lBmdVeLvWB6xjCcgw/b+/Edj4qrz0OTch4Hr9qurYgWW4x6vmGVGvoDuieHn9SBWtR+RuIxxPdM+uqLWqe/HAp7aN3onLVscZJj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(4326008)(5660300002)(44832011)(8936002)(36756003)(8676002)(2906002)(41300700001)(478600001)(38100700002)(6506007)(83380400001)(2616005)(26005)(53546011)(6666004)(6512007)(66946007)(66556008)(66476007)(54906003)(316002)(6486002)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGpIRWlyMStNeitaZ0diOUxTUzhBbnJHaDFwcGIyeUZ1dElJeXZqbGdIMXBC?=
 =?utf-8?B?US9WNldSRHVuWUFhdTFuQ2p2VmU5YklIQXY2OGNiV2hYaG5FWkFjWmR6dEsv?=
 =?utf-8?B?MjhXUUR5WnZkMFlhRVRUUmZEbWJNdTBRWCtPMWlwTGJXYlpEUDFaVjRWU0tl?=
 =?utf-8?B?dFM1VWJBVFBGSDQvczc3NXdrcnlKTGZZdzlQSHJtSmJQRGZ1d2RLK1pHRzVG?=
 =?utf-8?B?dlZySURWbGNvR1FZQmtzemF2RlNPcHo0WkJ2b2lBei9xczlGeUg4aWJDWXFp?=
 =?utf-8?B?Y1NtZ0hWMHNYU1BLZmRFK0Q3cVJ2ZlBSRHZZM0FxcmJJNDE1a1FiUEkxRW1w?=
 =?utf-8?B?cGVuRVl5MmJ5Q2dRZUFDRXdIcjQ3OHJFSW1LUHJoKzFhT3h3WTZSbnVVcjRz?=
 =?utf-8?B?Z25aQUdKc2ViWTVxYnlTNzdmbTBBT0UyQlJhempvK2tUYlQ2WFloemM1WkF5?=
 =?utf-8?B?cndzYjF3OUpzWHlyTy9WU3ZkM2IrQlJadUxBekNhT3NPemJkU0lLSVVaL3pl?=
 =?utf-8?B?aTRjaUVDc3ZmbndXZkYwblcvRmM5OGRUZXlxWkJVdHhiWlBzbWViQmtNOUlP?=
 =?utf-8?B?c3FpdmY2MERhcjNheVFvS1hodmg4dTdwWGJNb0dBQlUvaTc0VFZVWUE5eVNp?=
 =?utf-8?B?QjI4c2Q2aittUjNydW5wU0VjMHdwVGoyMERVUGJheXI1TmNjSVB6SlhyM05v?=
 =?utf-8?B?MGxZdERDaTlYQlkvQWxHK2tvY2dlODdPbUt0YzNMSjI1NExKUnE3NGhWazBN?=
 =?utf-8?B?eDM4M3J5L09XZldia1JDYVZWQlFSaGN0QXlUdlA0QmgvRjBmeFRDQ0Noby9a?=
 =?utf-8?B?ZHlpY2wvalVqcVFiVUVmdmFKdDZKV2ZITVFKSTY2cm5RTERkd0RzQURhNlpt?=
 =?utf-8?B?K3YvUS9MbnJoTy96bEZ5aHo0ditDbjJmZXZPd2F0UUQ4UUREREt0VGlranVC?=
 =?utf-8?B?dnhNYk5oY2hyTEdsYjljdE5IbkE1WHBEbjVUWVRFRk5vck4zbzZsWXRiYlRV?=
 =?utf-8?B?SWRBUVZxeGlXVjdWMk1kZ2VnaTBYY3NMTVJxR1U5NFhjalpWM21qeFR6NUxB?=
 =?utf-8?B?cnd2TXc2OGdTYWY1RVY1YmNmVVBuS3gzRVhmMHNkSHp0bDFmczJ6RHFkMkRl?=
 =?utf-8?B?SmhGbDY2eVpNR0M2bmFqTmp4NWRLTW1VMUJzblJXa2JTbUQ4OG1NVG9LV2lH?=
 =?utf-8?B?WU5HT3lPVDkvWUhBNjMrR0NWMVk3SkRGNkNwaWZlNTN4QVNIandmbEZUTXRh?=
 =?utf-8?B?dklBNHlBRXpEemh4RHFhY0FjTitzMHhGZE1HRHNid1IzTURoQzMzNUdjSkNR?=
 =?utf-8?B?Qjc0aTlacnF1UForb1RWU1MyN0xjMUR2SnYzbTJKM2lZaFJUWHEvd2x2UHJa?=
 =?utf-8?B?UnEzbnR2blpwaDNrQ3pkZVRCRmxCMW12YVNSS0xZdTNyQlIrM29ZSXBFaGNk?=
 =?utf-8?B?TjNoYU4rUDY1Q20vdGVxUEEyUHh5N0NUV0huVmI2NlM0cjZOWFp3S0M5aFhT?=
 =?utf-8?B?UW4yd21QcXJyM3FxdlM0NE1CaHQ3TG04NWZBaStXcVJHK210Njc4NG9VcVIr?=
 =?utf-8?B?N05jejNvOG15QnlnZm53MTJFUWkwbHBoMnhKdlB3cm9tcVpoZzlPbWhsazdx?=
 =?utf-8?B?Tkg0NHNYZFJaTUk4bG5OMERhckFZTXh0cVBacThFMldQMkV0dnE2MWRsRWRW?=
 =?utf-8?B?eWlRVUJQS3V0eU82SzE1QWc2YXo0SFhSQzViNkFhbHBTUk1KY25PUzc4cmhX?=
 =?utf-8?B?Z0gvNEVoMXZETkF6cVJTMFFRVmNMeXk3RW5ldzNVTnBqRDFBMEcxQzZzUFJ0?=
 =?utf-8?B?Q2pzMkUvSVpPbTQrekhrMi9ycmxnOUZBRnlBR0VxenIrNGYxb3FTTVNhWUtn?=
 =?utf-8?B?d3BWdjBrMEVSeGR0a3BBb2lPU2pIK2NwVXU4QlBtYlRxdCs2S2ZMSzFNQTBL?=
 =?utf-8?B?QzVmSUFndGQvdnlmc3Z1bU1QdFBxRVZKeWw2STJ0c1Y5Z29HNmVKbEk0MUls?=
 =?utf-8?B?dC9kWHhPek0ydEJWYTBKNk9qWUVMZlcyUklPaUtweVBYcUd6aU40RFVvenNV?=
 =?utf-8?B?WXNzN01Dazdpd1VDT01jUXZSY1h1TklzZ1ExRlVRYTVoTlRZQS9LZFMzUzJl?=
 =?utf-8?Q?kNJjcaZODMNkmzisZW3qkIngZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b716233c-2478-4d68-e152-08dc12822c55
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:49:08.1005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vwf7H4oioVVtkSiesoOPW/Hp2hmt9MEPn28UDDhDNNfGVeUKJZJjFMHCYTNiur19
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4873
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



On 1/11/24 09:18, Krzysztof Kozlowski wrote:
> On 11/01/2024 09:10, Michal Simek wrote:
>>
>>
>> On 1/11/24 08:56, Krzysztof Kozlowski wrote:
>>> On 11/01/2024 08:09, Michal Simek wrote:
>>>>
>>>>
>>>> On 1/10/24 22:27, Krzysztof Kozlowski wrote:
>>>>> On 10/01/2024 14:35, Michal Simek wrote:
>>>>>> Move cells to board dtsi files from generic zynqmp.dtsi. Changes are
>>>>>> related to qspi, spi, nand, i2c and ethernet nodes.
>>>>>>
>>>>>> All errors are generated when dtbs are compiled with W=1.
>>>>>>
>>>>>
>>>>> I don't see any errors on some other platforms, like Samsung. Isn't the
>>>>> actual problem that you do not disable the nodes (I2C, SPI etc) in DTSI?
>>>>
>>>> On i2c node. Bus is present on the board but it can end in a connector or device
>>>> which we don't have OS/bootloader drivers for. But we have drivers using i2c
>>>> tools or u-boot i2c probe. It means that transition should happen.
>>>> On i2c interesting is that W=1 is not able to report issues when you have i2c
>>>> mux described like this
>>>>
>>>>                    i2c@0 {
>>>>                            #address-cells = <1>;
>>>>                            #size-cells = <0>;
>>>>                            reg = <0>;
>>>>                            /* HPC0_IIC */
>>>
>>> I understand and it is quite common, but it does not explain the case.
>>> Your bus should still be disabled in DTSI and enabled in DTS for these
>>> cases.
>>>
>>> And how exactly do you solve the warning for above case?
>>
>> I had address/size-cells in dtsi (entire SoC) and then just enabled the whole
>> i2c bus(for above reason) in board dts file without any childs there.
>> Then W=1 reported that there are address/size-cells without child.
>>
>> Another way how to solve it would be to simply delete address/size cells in
>> these cases.
> 
> But your device without children sill have address/size cells, doesn't
> it? Or does it mean you did not add it to such cases?
> 
> Anyway, I have exactly the same case exynos5800-peach-pi.dts with i2c_2
> and no W=1 warnings. I really do not think your solution is correct.
> 
> Also, address/size cells are properties of the SoC, so rather DTSI.

Let me take a look at i2c case again. For gems it should be clear that I need to 
remove it because when there is mdio node I am getting errors like this.

arch/arm64/boot/dts/xilinx/zynqmp.dtsi:627.27-641.5: Warning 
(avoid_unnecessary_addr_size): /axi/ethernet@ff0e0000: unnecessary 
#address-cells/#size-cells without "ranges" or child "reg" property

Thanks,
Michal

