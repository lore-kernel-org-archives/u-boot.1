Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF0FC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C9A877BC;
	Wed,  6 Dec 2023 13:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xoN3WYyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC16877C5; Wed,  6 Dec 2023 13:41:23 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 146A287775
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlt1uxufjtNATQkoa+0lX5I2p/U8RIhqsED+Hd67had+cWP99QNn2+/t/o6NUK56GftwAKUacV4zVhQOQ5dgpQPKBn6Z8JMMUH4DSbCkq5S5AZphCeSFMhZcP2W1AVcmALDqy7Mxo2RfGZs1vHaeeohmLwq8IMwkojaLkS7padFtqVRvz921+7h+30vneOX4sQIFSM2qAuxYcRKZ026OAludS7Jymxr68vb1nVzPijVZlXFzVZdUFcyC68oBuXVhzHjF1/EPLXhYgAZsBl2UGYvX9G1VkTobDyh20+VokQFlSlIZzDw3AReb7zakZhnxbXvrGiATE173+O0o/AlMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bv5m43QFB1qSjY60tL00rRUbYY7lYV9uY6ZvaVjiZok=;
 b=eT9uulygY/rVS4fcYdLQs78vLTV3eTeIO51JJF3f9No3qO2FJu7jQDXufOh6lCw8HtOGie1kqOpnQni+QZDicgcQTR3ZRRCn702iyiILD59L4YdcgtRyTB9jTm+PoYUJZ1ckfSgRZHvzaiokIwOYPBtKWmP2tT4CHsQZeo+tOuXevPlB/xiFd9cSjrW5E8HcnbXuOlpBbHFB6xgd2dieOnDJj5oDXOUTKOQunRHd6H4+wvPJcpSA1+wR+85zUaAVLnljxDTqJIt4svbFaG8b/84Kjsh/mZi0Elxt1qS9Ytx+5gt2qekc9uNvQYeq7LhPgEqNys1qLMAIkAJ14qTgbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bv5m43QFB1qSjY60tL00rRUbYY7lYV9uY6ZvaVjiZok=;
 b=xoN3WYyqWt0bGhK8haKTnEVIJ/cw7IW76jD3ihgYKSxJDtuQQTiwDLrHZXu7jJMy5WeLBKhrruCutCH+SVRzCr7uRXBu/oOSCWz/X8tdNL4RW/hzPWSxmyn5Pl5ojrTgS2D8SWojkBjNDYlvWTSujazDO12tb4Mvo3tx2oo6b9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 12:41:14 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 12:41:14 +0000
Message-ID: <4f7abda1-5069-44c3-9552-1ddd0c6cd263@amd.com>
Date: Wed, 6 Dec 2023 13:41:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] spi-nor: Add parallel and stacked memories support
Content-Language: en-US
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, sjg@chromium.org, git@amd.com
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
 <CAMty3ZDF4aGNmrQe1FBJQs3AZo+8kWVBPFwUMJFCrrbcXBot7Q@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAMty3ZDF4aGNmrQe1FBJQs3AZo+8kWVBPFwUMJFCrrbcXBot7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0041.eurprd03.prod.outlook.com
 (2603:10a6:803:118::30) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0218f6-f773-4b0a-3b9a-08dbf658a210
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/Y+7klO3SizpylCEPUzmztuy1hty2O5rlAmxbQ53ANu3wrtoDTQ5eKbluQS/ow5bjkzeDJMK86q/WINP5lrSnT8WnjsWbKbQ6Ext2457EzwHmYiOJLJbtBWnWTO5FkoFpNIvZq/fI3iopggbgbbCMTf7gT0IRN07Zj0cpqn/MyUdw+7YHuLc2MDwuEuggVx3hMEe5frJcwF9lN3qL0apoH5wHnqLkTLcXZAep9/aog9yyq5HRq21nDWqcTxPnCjn61RKMGSOZu/id4t0sfiphVSZecqnLBut/c2DvlBAA11rNC6g5iykD6RS9Wb8jksP5OT+N5E1A9U3iMYD/EXr8opbSSHCAxw0ZDLiqBppGvHRui70IrqU7tOf924ju768SJkIZ7n/FYn/AWpzktGnttMuyEPsjtsWZzbU+0snKBbpuRqzXydHY4D3f65wQ45x4uiIRLvFcb2VKwNm64Xk7LsA7RdQnJJpGbDXNS2ywyuCrYE9+Khm5FPcdI0o3PNVx2BJ7avBSSa0KRN6fnfAdNpf33fLFX40idNR+wJxGbinl2GnIN1UGa7MCmXVkG9gHQCcnKaiiKULtv93yDJFQWoBmkhuHywoYLeb7BozJu/0Dv8ut8CK9+5g9IJfJHYxk9Sw2Qb5FDA0pv7VZ06Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(41300700001)(86362001)(31696002)(31686004)(83380400001)(2616005)(6512007)(53546011)(36756003)(6506007)(2906002)(6666004)(8936002)(8676002)(6486002)(966005)(478600001)(316002)(44832011)(26005)(4326008)(5660300002)(66946007)(66556008)(6916009)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2UrWmlDR05RbHZRNmd6cmhKQXBOWlZZSkJTUHdUckhhY3c5enhkYjJ1c2Fl?=
 =?utf-8?B?Y1NwQ3NDa0s5S3Mwc0t4amVhQ2FGVXBMU3ZPaW13R0g5RTFjL2hTM0xuMjdK?=
 =?utf-8?B?MmJ1QzN6TkFQQWNDNXE2dWVndGVCbkpZV3NzVzE4VzRHZXpRUXFmcWl2dVBh?=
 =?utf-8?B?U0loYWt2NC9Ya1pnVmtDMWdpNkpPRUs1KzJ1cis0dFBUY2pjdEVkdVJiMTc3?=
 =?utf-8?B?SndhUjR1cWVNaDdWR0ZWcjY0eTFoQjNDMUhxbEhBY1pLSmo1Qk9mTDBGK3Bk?=
 =?utf-8?B?aXN6WHBDZi9GZ1VaYWljS0R2MUk4UytWbWlNQXFVT1ZoVklrd1QrRm5JVzlo?=
 =?utf-8?B?Q2NERkYwcm1xWDJEQUJOTHZKUWVkTmlaa2FhSVJOcWxPazV4anFKTlZ6ZU9R?=
 =?utf-8?B?UzUvSTJGVVRFQ0dlODgzMnFUaUcrMmNiUjdxdUczbVhEVXFZY3U4VjF0WEVa?=
 =?utf-8?B?bkZyZ1J3bDJZdTk4OHpENUV1L0xpTG9ITDZCTDZlRXFObC9kMUZndUM0bHBi?=
 =?utf-8?B?MnRsalJQdFZuTXpZZ0dZQjREYmNtMnRKWndIMUtwQW1NaHp3ZlhNRXd3YlFY?=
 =?utf-8?B?b3pZYlFUMVQxYUljWGdYeWh6OHNpYWtDL0pkRjhrTmJoUitnSTM4Zy9iaWgw?=
 =?utf-8?B?aTIvUDJYa1NoUncxVFZMYk1GcU1neXZNNVM4WDZLRTVUT0NiTXZ1QmdCRkts?=
 =?utf-8?B?M2Vld2YwK3gxZEZkZ2ZONGdyQTFlbUdsbUhJaXVaa0NrUnV5dUgwNEFydGdv?=
 =?utf-8?B?UHVScDlVL3ZPMkdhck16WTNqeGJRNzdoOHlOV2FXS3VBR0Jhb2s4ZTBzTGxo?=
 =?utf-8?B?ZGpRV0x4SXdHWmxIZGhOb0NoekVQeEtFV1Z6RGhwYlZIeW1SQlZ5RURLY1dR?=
 =?utf-8?B?TnNockN0S2s2NkYvMlJKZ3JHTk5Ua1NmNkM3Z2Q5alE3ODZqQWJlbTIyeXFX?=
 =?utf-8?B?bE9Lc0F4aTlVcHhFaEhPYlRBQTB2elZXMjZwaW5uVHZCQXdNNndzNjB4UnBx?=
 =?utf-8?B?MnJaam5aY25lc2pZbVBGWGplbnl3dTFrN3lML1R5cSsrR01RQkFWbWNBcTVP?=
 =?utf-8?B?eXhuNTBwckUyZ2F2ODBua1pXaFV6UXRIZ2Fnb1lEN3lNNktxcEFPcUZCSDJl?=
 =?utf-8?B?Qk5KaWdyTjZVRGJkb3hxU3RYLzRIQzBCSm9HV0pYbXdEMnlpaEo1NkdvRWFh?=
 =?utf-8?B?OFlkenZwcmxHdVRlZFVjM1pac0NRbS9tMzRkaTVGQjhEYm1WWklaMzlwRU5w?=
 =?utf-8?B?U2c3Zm5heVZOVWc4cnhJbTVEb3ZwR1VjN1g2Rmxvd3k4YUZjK1dZM3BsRlhS?=
 =?utf-8?B?Z044ZE4xSFNtUTlmemM0dTB1ZkpINSsvekN1WTNlcVRBMjRidm1zb091ZHZs?=
 =?utf-8?B?dlh6bVpGUW0vdWxMRUNhSUt2aGp5dlJhME9VVDdzTnJON0VRWG90ZGtKMGk5?=
 =?utf-8?B?UWVyWXBKOC9IOEl0bWs1dkJmUFdhRXlFeC8zVXVxTVRvS3RxNk1hYnV2OTBZ?=
 =?utf-8?B?eXdyajg4dmtWVHpWN1FnR1RPQWdKbWsyMGs5OVZ3bnA0aXJwMlNTY0dWUnpy?=
 =?utf-8?B?WkpiYzVkaGNoZHRodEVTR1R5RTdIN2FrdDFGa09lMmtQK1hOaFhtTWM3Zk90?=
 =?utf-8?B?OU5JWEJtTGNqWmxlZW9rblNOTVprU2JRRlphS2c3N3A2SUZlOTR0RzE4ZkRm?=
 =?utf-8?B?aVd4SVRMODdBcUNwb2VBYzRPaEgrT29JQVY2VGQ4VzJjdTVRMUFZR29pL0hp?=
 =?utf-8?B?RHFQSGVnY084VkYwSkRNZ1hUYzZnamxzMUp5YUFVZzdYdDExVkdlMFpzQWk4?=
 =?utf-8?B?ekgzdmdhc2RFeFpYN0d6TnByTmZlWGlvNzNzbWlKRVdsU1pYR0RWS0V3RGl1?=
 =?utf-8?B?dFNpRks0SkswejlaY2RLSFV6VjV5VkE0UDh6Y0xQRjg2aDRTNmEvSDBBTUhC?=
 =?utf-8?B?d1ZPU2w1VmxoUlFORlRNSU1NMlN0azV2WmFUUmNVQkkxRGVnWEVmUXU1M0l2?=
 =?utf-8?B?ZWtLc0ZEbVMxY3BURTJ2R3pmNExhdjBENnZFb2dPVWJuTTR1QTV3Q2pWblgz?=
 =?utf-8?B?aXQzUVRrRHJBNXpVUTJoQkxqOHZsZ1JTbEhsKzVWTjg3U0srOHVUQ0s5WGcy?=
 =?utf-8?Q?LWz4H9qninLfaLpFAi5B/mxzf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0218f6-f773-4b0a-3b9a-08dbf658a210
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 12:41:14.2387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbrQVTIdypfVtMO68cHlP80+gyPh8yPBfB67dsMGUrUtS807gM6Ojjk+/stH1xHT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
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



On 12/6/23 13:24, Jagan Teki wrote:
> On Fri, Aug 18, 2023 at 9:51 AM Ashok Reddy Soma
> <ashok.reddy.soma@amd.com> wrote:
>>
>> This series adds support for Xilinx qspi parallel and stacked memeories.
>>
>> In parallel mode, the current implementation assumes that a maximum of
>> two flashes are connected. The QSPI controller splits the data evenly
>> between both the flashes so, both the flashes that are connected in
>> parallel mode should be identical.
>> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
>> nor->flags.
>>
>> In stacked mode the current implementation assumes that a maximum of two
>> flashes are connected and both the flashes are of same make but can
>> differ in sizes. So, except the sizes all other flash parameters of both
>> the flashes are identical
>>
>> Spi-nor will pass on the appropriate flash select flag to low level
>> driver, and it will select pass all the data to that particular flash.
>>
>> Write operation in parallel mode are performed in page size * 2 chunks as
>> each write operation results in writing both the flashes. For doubling
>> the address space each operation is performed at addr/2 flash offset,
>> where addr is the address specified by the user.
>>
>> Similarly for read and erase operations it will read from both flashes,
>> so size and offset are divided by 2 and send to flash.
>>
>>
>>
>> Ashok Reddy Soma (7):
>>    dm: core: support reading a single indexed u64 value
>>    mtd: spi-nor: Add parallel and stacked memories support
>>    mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>>    mtd: spi-nor: Add parallel and stacked memories support in read_bar
>>      and write_bar
>>    spi: spi-uclass: Read chipselect and restrict capabilities
>>    spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>>    spi: zynq_qspi: Add parallel memories support in QSPI driver
> 
> This set is a bit hard to go. We need to Sync the Linux SPI-NOR tree
> and let Linux approve the parallel and stacked otherwise it is very
> difficult to maintain.

Linux thread is here and it is pretty close to be merged.
https://lore.kernel.org/all/20231125092137.2948-1-amit.kumar-mahapatra@amd.com/

DT binding is already approved but have no clue how big effort is to synchronize 
it. When was it synchronized last time?

Thanks,
Michal
