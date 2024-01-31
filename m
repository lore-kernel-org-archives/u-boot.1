Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42040C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 17:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA3187BA1;
	Wed, 31 Jan 2024 18:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="LHiA/jYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839E087078; Wed, 31 Jan 2024 18:55:17 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A5B187BA1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 18:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOxGeJWgNGcNit3sCSwM+VRKv8BncKDXucqT4dKk31D5MwvPfQWzOIfQpCRRHsPUtnGGEhPJBFL1123Z0D5pMAjK5+/deo5eGlBCIb4ymQzuwAiipclMx9BUWojqtzgibga6QHnh7YjQpLbkYHtPx6Fz6eaikB+3f9P0WEGjq6C511UfSGEPojcRV0ylhpKgdtcW3vrGocfY7137nfFYfHFqeSdhM1GK2+ehGP6TfmiPowaQsPRSZ5u+vQ68wrORx0JykkFXnCwFrxdxvGQ87bGCVKQbzBEL5J/nr0cCW3/NX937seDVgHW+nlsycO7cAfv3QhWwO2uVhWkg1rGcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBarzVCreyxxLYMRoeTQxuXvo0my8oDLBuelTL1nj5Y=;
 b=cQ74l83WX13Y/CxKWCfFgOg/Lhk7ktnmRsxSw73oiAWemmPVHXbX5xTFEoDeGZpI1VGqm5g8NW5dF0HPGYuLW2fucwXH+kV1E5vzVzUW2C59gEx7+XnfAvbsCrUYSZpGwXbepJzLPdZplbDbEH6x8GPZ1i8QqxXpPkLdPR4ncUAPciZsQo1cCw+XNv9kFJmjOom70CMSzBlxyenKslFt2XYxIa0MAZ2M/MwNdfFppTqhSp3B+wRGs1ad5dOrAUJUjhNAzCh15PyzWtwnWIZhCLAs6LVi3RyTXSFLLvDWa8YNCXfpuNedDwz+eBw+kt4gCQZZvToJs7cYvW5cFk9FlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBarzVCreyxxLYMRoeTQxuXvo0my8oDLBuelTL1nj5Y=;
 b=LHiA/jYklpQW3HsQBzTmzBnCIrR+z5l0IT6KyHnOvfNXqyHmUJRXc7k/81B7nJNmcIir7FC17x57jYgpxzYIMDUQz/bPe/+ENWyT+NqXsuMiwJK0UkzP8mY5aJGfdn+JV+5jwKnjLGxaf8LKkg8bToiL8WvduDTlhSVn2qkYaLaGyPXMj3TjKBj/YvWPQxTOEuF+jWNqj2TbxOfsoNzRa+YNFKmD7IwWb23+RTroxf2PC8WWVmCmWD3Ai5EMVPSs+lZhHN31yw6L3P7XBbOuSf3USeRLjwdssn7hgDNfAEKztw8li3ItIi3zM4y1RSCbpbNJm63+b9G/9BsiwgvDfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 17:55:10 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 17:55:09 +0000
Message-ID: <61d32ae7-689f-4f58-93a8-7e4f05967833@theobroma-systems.com>
Date: Wed, 31 Jan 2024 18:55:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] rockchip: rk3588: bind MMC controllers in U-Boot
 proper pre-reloc
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
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
Cc: heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-17-1eec1c34953c@theobroma-systems.com>
 <062d9519-f129-422c-89ed-3b009e222150@rock-chips.com>
 <5f4c826e-9ecf-4620-9430-b317e472cfd2@theobroma-systems.com>
 <928cfe56-1a7d-4024-aa9b-c14654b150e1@rock-chips.com>
 <f2ed9f73-97bb-446e-9396-9de3ab01b8d5@theobroma-systems.com>
 <8a101c97-cbd5-4e99-b89f-49fbe8fdd59b@rock-chips.com>
 <7b5cb03f-c2b2-4cf2-b06a-751d7cc978b9@theobroma-systems.com>
 <329e95d8-bedc-4a97-a651-13daab2c1cf8@rock-chips.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <329e95d8-bedc-4a97-a651-13daab2c1cf8@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::14) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB8PR04MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 4337af00-a29f-484d-f97e-08dc2285c411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2b9M/PTFwsiDAp0WqDg/kOMWnBOO7jgmLhRfKNjHp6ovG1SRMwPoEUR5B1/T8VGvrBWR6fRTXevHbqjw3AQUi2R/l29ow1ijcweheLI5nm6qUGHHgfP66qotIhubl366ahvYNBnwvUilw1kTXBuX8b5bDfRALAQ8Gg2brdSVFuWptIrdYw3T3Bg3IAWdKTtFFWHDiMZ2ksoiihCuytLLRQPBHALxkdI0vw7nbF+16JakPM633cD24P2YxYAJGZvF9sxgpnkVUNwq1Ryff4mh6NqSBqhrlawtbrSpWpE1caSxXXQbwweaFJiw+3ELCv4t4T+WUzKq7lpFHgcmc3BNGVZ6HAp8AhV01hqJMBYIG1/0EJodY9YEMuZpwWSUtcwuNJpd9tHBVwaL91KGUa5pDRNjJQgrn6FJ4lU7qyLPnvuvcfpua2QoJm7YnQfK7AeJqqLo7PIzqtpGFEafOaiRbodW89u/j0N4lUf4req9rwMJOm8mSs407wd3//RNMpFTtGZg+bT9Q1KN/tSxVuIggrYC75puV5ThDG2tZqbVs7jSft3S7++eMo9JHqp2uIOxEWTTzldeyrWzpihQ1N9hCDVXdYqfUmCmuKzkBGtTM3Z0PWPyROY7DzUvdXmC+ZbegHVsfeEPocubm6pRRDwO67441sGak5K/dzUy4WTIlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39850400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(921011)(2616005)(31686004)(36756003)(6666004)(478600001)(53546011)(6506007)(6512007)(83380400001)(6486002)(38100700002)(316002)(86362001)(5660300002)(8936002)(7416002)(31696002)(2906002)(66946007)(66476007)(66556008)(110136005)(4326008)(8676002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czk3SWx3dDZIOWJYMGtjd3dHMW50cTVScU9OZmFEY1I0VFFMWmFSdVEzMHhQ?=
 =?utf-8?B?V0RKUEJ4eEY0VitldnRDMHNSWGFVMXNiUW9xVm50ekd2WVNFVmorekR5N0k3?=
 =?utf-8?B?VnZqMVAzZVdDd0VxWEFKTGU3amwwdGsvUmMwNlo3eUVCMm5VTVBWbEpPQkNn?=
 =?utf-8?B?TlhmRWRtNDJ0TThTQUJ6bm5JaDFoV3JpMHBCRmR3MldVb0YxTDR1QXdKbFNq?=
 =?utf-8?B?OXZJSmdOUVlZVHMwQXU3bW9MdzNLZ1dwcnlDTCtvY1NBRmR6cFhoN0xvZXVR?=
 =?utf-8?B?NlFhYTVFVnh0cFUySTE1UGZKREdkNFlyM3BwL2NJblFpMzgxT2ZwdUhlemhq?=
 =?utf-8?B?VmNFYnphcW9qS2VmU3pySzlwNTZmZ0RGWnZ4ejM1UkRqL2IvalhOaDdMbE1Q?=
 =?utf-8?B?VHJwRkZxVEM2d2JOaDVBYXEzenZkSHpYb1BXZTRJWFBRQWZFSW9zcG9yMmU2?=
 =?utf-8?B?TXB1cm4zYnRob3NCVEVtcWlMaW1wUVJWK2MyOGQzMXJwditKWVh4TURsbjNh?=
 =?utf-8?B?OERBM1FuM0xMdml0eis2OUJ3T3RhNEF2SjR2N3FhZHlkWUw5RG9SUnpXQWgy?=
 =?utf-8?B?N3h6ZCs4ZStydEQ5MDlHL3cxOStlYnFaaDE3TWJDbWJmV29hWkpBZ0F0NFFQ?=
 =?utf-8?B?NFVJZWxxTVM5U3AzTkQxUEcxTS8wcklNVWdtU2RhdEJzL1VvbmQ3UFkyV1Jm?=
 =?utf-8?B?TXZYOS9ZRmVTQTFxYkhiYVlCV29qT09xQ2pyUmdRQjhiZ3M0SWkwaDk4eWJK?=
 =?utf-8?B?YWZWNFFFL1AwaFF1NlFkei9yWERBdHB1U25ocHhNKzVmd3krNExyMm9EamZE?=
 =?utf-8?B?R28xUVEyb29uWTU0V1NNT3kzNTZPMDNiWHBZdk5SeXEzeEZKaXJmTjJDcEl5?=
 =?utf-8?B?RUhDM09weXRjM2lzS1JKT29FOHh6N2dsejhSNFNiYUlISGZ3RWpYcFBDRzZY?=
 =?utf-8?B?amxPOWhNdzkwNFlYSmdhYnM5V0xGblNVTVVERnJLZ0pIYS9FWVBzQlhHQkl4?=
 =?utf-8?B?OVI1SFJ6b2d6OWVEMEZPcE9QdGdGTW9sSi94VDZ0N3Awd2xZV3Q0RGZRemgr?=
 =?utf-8?B?czhEc1VaWE5Ea3U3a3lldmlibytYVk5ya09vaktmM2c0QWdsUE1xZTdWZ1N3?=
 =?utf-8?B?YkVuUWUrODYyRU9aT01zUjJ0bUQ3enpRUjVLZ09SeGRLV091VHBSOVk0ZFd0?=
 =?utf-8?B?SjZxdjFIdWtndVNINHh3LzJFb093d0M4NHdzY0JVRmVzeVNjbVRsQXM5SWZm?=
 =?utf-8?B?NFhUYnpLODh3SGh6MXFBWjhGK2tNMXJQLzN3NHZZZi9rd282Z3FjeDN5NWVI?=
 =?utf-8?B?b2x6cFRFUmRjRCtSRk9RVERpcnc3WDVscmNmWFdlVDh1eEMrRUhDa3U3MzZF?=
 =?utf-8?B?NHNreDVaNENSSVZjY2RadGNXbVNjRzZFWGJJeldCa3h0MUFGQlNIWk9FU0dS?=
 =?utf-8?B?em1JVlBlN2dyNnlxcUtVNTVoc1lmMEplcFI2NDd3YUtMa0FuVExpNWRIZ0tY?=
 =?utf-8?B?Ym4wN3dIV1R4dWxCS1F1WHFlb2pKZlRpaUkyTVJBL2xkYm5RVHNPcnQ5Y3ow?=
 =?utf-8?B?ZkpOWTVibkZ1M0FTUXBONkdSTnVCdU9oMmwyZDFod3BTLzFnU1cyNnZDRVo4?=
 =?utf-8?B?T2ZVSjV1cUZJazBHMW8xS1cyRmpkazVab3VrOUtTNzROaEt1SFY4MVlSQVFp?=
 =?utf-8?B?MElTS1ppODd0d1R2TGdKV3NvMkx0dFovcEk4dGRnS1BqcmtFZjY1WmRWeko0?=
 =?utf-8?B?cHVYMDM3OUlYeVkxZE9TRkRyeXhVOFVuRkMyQTA1OTdJSHNYNDBjb3VzdTZL?=
 =?utf-8?B?aDhyd0tpdVgrTWtVN2hRM1Z6OTVUOFJMcDBBVjZjQS9ualVjVzRoNndIU3NX?=
 =?utf-8?B?ZXBQNy9Sa1FUU25md1NpdnVnZlZpWGQrMEExaStWeEg4S3N1amtpSm5sTEN1?=
 =?utf-8?B?NVMyQUZMeE1sVFJiNmZwUEdXUUJMMzNpaytvRXhTYXZHQjZ1SEgyTENpejk3?=
 =?utf-8?B?dmpTLzczQWo4eU5COE82VHpnUFJFQWxiQ1BBK3JtYTkyTDEvUFY3UDNDdU1U?=
 =?utf-8?B?TFNkQ2tkTjRYbFR0ZnVCS0l1YW5taTZ0eFFLRHhyVVh5ZHhia1JsQXBiR080?=
 =?utf-8?B?U3I2UCtISGdLT2lKMGlsbUZKTFYvN1lqTWRnTEh6Q3FmMjdXaU55MlJ5UDdX?=
 =?utf-8?B?QW1YQlJCME9zR1l1NzArVEF0OVZSZDVET013QkhIZXRkL2h1cGlyZGIrR3RQ?=
 =?utf-8?B?N1NZMklud1pKY0FKSzdrR0ZwK0JRPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4337af00-a29f-484d-f97e-08dc2285c411
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:55:09.6380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apRtkJZUSOqj+WPhEYdZ7mYfdZGacEWrQLCx7Fx9myIxZQtstWOeJnTegHMrDISd4Z54GOC1NabFxh1EQkjeFgOrUUXDxAFAm27e+3GSY40p2HimFB95m6v450OWZ1lz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827
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

On 1/29/24 11:35, Kever Yang wrote:
> Hi Quentin,
> 
> On 2024/1/27 00:18, Quentin Schulz wrote:
>> Hi Kever,
>>
>> On 1/26/24 11:56, Kever Yang wrote:
>>> Hi Quentin,
>>>
>>> On 2024/1/26 17:32, Quentin Schulz wrote:
>>>> Hi Kever,
>>>>
>>>> On 1/26/24 09:58, Kever Yang wrote:
>>>>> Hi Quentin,
>>>>>
>>>>> On 2024/1/24 19:04, Quentin Schulz wrote:
>>>>>> Hi Kever,
>>>>>>
>>>>>> On 1/24/24 11:35, Kever Yang wrote:
>>>>>>> Hi Quentin,
>>>>>>>
>>>>>>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>>>>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>>>>>
>>>>>>>> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram 
>>>>>>>> node as
>>>>>>>> pre-reloc after relocation"), bootph-pre-ram doesn't make U-Boot 
>>>>>>>> proper
>>>>>>>> bind the device before relocation.
>>>>>>>>
>>>>>>>> While this is usually not much of an issue, it is when there's a 
>>>>>>>> lookup
>>>>>>>> for devices by code running before the relocation. Such is the 
>>>>>>>> case of
>>>>>>>> env_init() which calls env_driver_lookup() which calls
>>>>>>>> env_get_location() which is a weak symbol and may call
>>>>>>>> arch_env_get_location() also a weak symbol. Those are two 
>>>>>>>> functions that
>>>>>>>> may traverse UCLASS to find some devices (e.g.
>>>>>>>> board/theobroma-systems/common/common.c:arch_env_get_location()).
>>>>>>>
>>>>>>> This sounds like we need to update arch_env_get_location() 
>>>>>>> instead of enable mmc driver
>>>>>>>
>>>>>>> before relocate, because you we don't really need the mmc driver 
>>>>>>> works here, there is no
>>>>>>>
>>>>>>> access requirement to mmc at this point, right?
>>>>>>>
>>>>>>
>>>>>> All Rockchip SoCs except RK3588(S) and RK356x have it done this 
>>>>>> way, a little bit of consistency wouldn't hurt :)
>>>>>
>>>>> My point is not about you can not enabe the emmc before relocate, 
>>>>> maybe I'm not clear enough for the reason.
>>>>>
>>>>> All the driver bind/probed before the relocation will have to do 
>>>>> the init sequence again later after relocation.
>>>>>
>>>>> The emmc driver cost pretty much time at init, we should avoid to 
>>>>> duplicate the init process if possible.
>>>>>
>>>>> For this patch, you want to make it pre-relocate because you want 
>>>>> to make sure the emmc is available for ENVL_MMC,
>>>>>
>>>>> but there is no read or write requirement to the emmc at this 
>>>>> point, which means we don't have to init the emmc at this point,
>>>>>
>>>>> maybe we can check if the driver is enable if enough.
>>>>>
>>>>
>>>> Now I need to know which SoC we are booting at build time so I can 
>>>> check which drivers are supposed to be built, check those symbols 
>>>> are enabled, then traverse the Device Tree with hardcoded DT node to 
>>>> locations of MMC, SPI flash controllers, check if those are enabled 
>>>> and finger-cross that those drivers will actually bind/probe 
>>>> properly later on. That's A LOT of checks to be made.
>>>
>>> This is not what I want to say.
>>>
>>> What I mean is something  like this for arch_env_get_location() is 
>>> enough, you don't have to bind/probe the emmc for env.
>>>
>>> 1623                 if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) && 
>>> IS_ENABLED(CONFIG_MMC))
>>> 1624                         return ENVL_MMC;
>>>
>>
>> I do need to know if the device we loaded U-Boot proper from is an MMC 
>> device or a SPI flash, so this is not enough for arch_env_get_location().
>>
>> I could do it in a hack-ish way though and check if the U-Boot proper 
>> load medium DT node name starts with /mmc, or /spi and if neither, 
>> then return NOWHERE, but then we lose the ability of returning NOWHERE 
>> if the driver wasn't compiled in or the device didn't bind in 
>> pre-reloc, we're missing some failsafe mechanism I could have with 
>> this patch :)
>>
>> [...]
>>
>>>>> For the feature record "spl-boot-device" in SPL and read in out in 
>>>>> U-Boot proper, and then Swap mmc0 and mmc1 in boot_targets if 
>>>>> booted from SD-Card.
>>>>>
>>>>> It's OK for Theobroma-Systems's board to enable it, but seems not 
>>>>> also required by other boards.
>>>>>
>>>>> Usually we consider the system in two stage: bootloader/BIOS 
>>>>> stage(including all firmware before kernel) and OS stage(including 
>>>>> kernel and Linux/Android OS),
>>>>>
>>>>> and for those boards(eg. PC like) do have two different storage 
>>>>> medium, they put bootloader in SPI flash and put OS firmware in 
>>>>> other storage like emmc/SSD/SDcard.
>>>>>
>>>>> In this case the U-Boot boot target does not need to know where 
>>>>> it's from;
>>>>>
>>>>> in another case which supports firmware update from SD card, the 
>>>>> U-Boot boot target needs to set SDCard as highest priority, also no 
>>>>> need to know where the U-Boot from.
>>>>>
>>>>
>>>> So... this means we need a different U-Boot if we're booting from SD 
>>>> card so it can know which boot target to use by default? Or a 
>>>> different environment for SD card? or requiring the user to stop the 
>>>> boot process and manually change the priority? Or what are you 
>>>> suggesting?
>>>
>>> No, we don't need a different U-Boot, we can always set SD card boot 
>>> first in boot target in all case, if SD card don't have an available 
>>> firmware it will fall back to use eMMC, this works for the board I have.
>>>
>>> Maybe I didn't understand correctly why you have to do "Swap mmc0 and 
>>> mmc1 in boot_targets if booted from SD-Card"?
>>>
>>
>> I think I got things mixed up and this was not a necessary discussion. 
>> But since we're here, I will try to explain what we want to do with 
>> the whole process on Theobroma's boards.
>>
>> arch_env_get_location() is the only one impacted by this patch (as far 
>> as I could tell). setup_boottargets() from 
>> board/theobroma-systems/common/common.c is a vendor-specific 
>> implementation I do not see worthy of being merged to a code section 
>> used by all Rockchip boards, it's basically just a design/policy 
>> choice we made, but there's nothing interesting to make it the default 
>> (though it should be generic enough that one could simply call those 
>> functions from their board file and it should just work (tm)).
>>
>> So the whole thing is basically about wanting a fallback mechanism.
> 
> I can understand this purpose, but it seems you make it a little bit 
> complicate, does your customers understand this? Or maybe you don't need 
> customer to understand all these rules?
> 

I haven't received any complaint so far.

If our customers want to do something differently, they can always 
change the code so that it works for them the way they want it to work, 
or even simply just change boot_targets in their environment if only the 
kernel+dtb image storage medium is what they care about. For our three 
SoMs, I see U-Boot as supported for our SoMs with our devkit, with other 
carrierboards a different U-Boot is likely required anyway.

> This rule is simple for rk3588 vendor SDK:
> 
> Bootrom default order is: SPI -> eMMC-> SDcard ->USB(can chose only one 
> of it now for rk3588)
> 
> SPL default order is: SDcard ->SPI-> eMMC (SDcard is set to higher 
> priority, only if there is a uboot partition and available firmware)
> 
> U-Boot default order is: SDcard -> eMMC (usually not using SPI for system)
> 
> If SDcard has no firmware, then it don't affect the boot flow; if the 
> SDcard has available firmware, it means a firmware update need for 
> eMMC/SPI. Since the SDcard is removal, we can make and replace it again 
> which always fallback available if SPI/eMMC has something wring in 
> U-Boot/System.
> 

I know, and I've received multiple complaints from colleagues about this 
already. There's a LOT of benefits from knowing that in the scenario in 
which everything is properly flashed, everything is loaded from the same 
medium. I myself have been surprised a few times as to why when I 
flashed the eMMC and have an old SD card connected it boots the U-Boot 
proper from the SD card and not from the eMMC.

I appreciate what we're doing is not everyone's cup of tea, but it works 
for us for now, so I don't see a need to revisit this logic.

[...]

>> > No, we don't need a different U-Boot, we can always set SD card boot
>> > first in boot target in all case, if SD card don't have an available
>> > firmware it will fall back to use eMMC, this works for the board I 
>> have.
>>
>> If we do this, simply having an SD card with a partition with an 
>> Image/dtb/fit/extlinux.conf will be taken by default instead of the 
>> ones on the eMMC, even if we booted from the eMMC. I want to make sure 
>> that if I'm booting from the eMMC, I'm booting everything from the 
>> eMMC and not "if you have an SD card, maybe from the SD card". 
> 
> In this case if U-Boot/kernel get panic in eMMC image, the system not 
> able to recovery?
> 

What happens if the SD card image is the one that panics? You also won't 
be able to recover... except if you remove the SD card entirely.

For us, if the eMMC U-Boot proper/kernel image is found but panics, you 
insert an SD card and you hold the BIOS button when booting, then 
everything will be booted from the SD card, otherwise it's booting from 
the eMMC.

In both cases a human is required to intervene, either to insert and 
remove the SD card to start a recovery, or to press the BIOS button. For 
Jaguar specifically, inserting and removing the SD card is not fun (it 
may also be hidden below an adapter (commonly called "hat" I think?) 
making its access even more difficult).

And again, this is the **default**, if a user changes it in the 
environment (to e.g. match the Rockchip SDK behavior), we will not 
change it automatically.

> Anyway, you have your choice, since all these are stay in your board and 
> not affect other boards, it's OK to be accept(the little addition 
> -u-boot-dtsi  is fine).
> 

I am a bit confused.

Where do you want the sdmmc/sdhci controllers bootph-all property be put:
1) rk3588s-u-boot.dtsi
2) rk3588-jaguar-u-boot.dtsi

?

Cheers,
Quentin
