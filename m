Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727E6C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EF6C8796E;
	Thu,  4 Jan 2024 13:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PWeBurwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C008796E; Thu,  4 Jan 2024 13:21:17 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::619])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF028793B
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aF4dXNjI1ZIrHvhNwOTvuYTa5vJWNVsQ7Rxe+G8x4TW+vG4QHMxDlnVrsLcOsL73i9rHrporHXKSsFlwbmNMXxBhSilOLT3pwrZW7reo1hLArsXVhqnjBMv6BB0Fd6fGcMZy4sgeRVMf6OkD5UERp8RiBmrWfwuz0xEeTW0Y9a2ugy9sOYUyhNrhNE2KJToDIJWV4CHbiZknWAiqWnciLQG74CM397R8e9iATx41ehK7pvgHV2T0uAdIPVPkQisi8NeqieCj0nCKO6zaidIwAzu0Tp/TYizmwrj/51icyQebVY+TjKuRnI1GYUX6gCgJAdbR26YJVtPZHtw/Joi7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsCEOskBPt7gXvBuryUPpZtPJGTp1V/kvdrSgA+VhlA=;
 b=Rkm6JhH5coQ5Pv6hMo623C6Tq6xP72GgRRvWrTe2K9KJD4GEuIS7BTGz3HkRtWb3nuPUgSwG6ttoFL5yf+Fm43XiyuWBOSqCWMPsHMvl0oN44W6E7o318cE3FlsrnyyuMjq4lccH+W3Njhz5TGtFU75e8ezYHFXiIqeOYtlDfxqQNmX5Igce8jMUZRLxUpIpQLPoXrjNPW4eMZtg0GpIMkejYlz2bP87K5SmxA5ahBNlsHfqhc8jzaW2h8scLyKiAP/NIs6H73zwi+UIsOfr7pLM9WWFrDVY84p4kS1SgxSgrO1oLF0EYJqvRnG42aOr5oVXkneOgk4+lYW07jJTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsCEOskBPt7gXvBuryUPpZtPJGTp1V/kvdrSgA+VhlA=;
 b=PWeBurwDZpGSXkIVIYIq6ydmxUsdc0yNKyEO7gINWKOzQCrT7Bgs4V8T7LFOAqEbpgK8RojwGCzIqGgvoIU+eT3vmVND2LQeggzP0FTG1LViMuWvSmpGo0Ad5fKcQHm/fQmxlkwk6F970RL6yEqZWMIMhBEC65ZBjRK+gnE6mNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 12:21:12 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:21:12 +0000
Message-ID: <7bb9480d-ccd1-4717-8083-b007efd7567e@amd.com>
Date: Thu, 4 Jan 2024 13:21:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
Content-Language: en-US
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
References: <20240104114619.280513-1-o451686892@gmail.com>
 <45cc3cf3-4120-460d-b275-fc019156ce20@amd.com>
 <CAHk0HosXQ8iU0G3tZcQUf44FPdSzGOh7X9mH85Ja6nCEe46drA@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAHk0HosXQ8iU0G3tZcQUf44FPdSzGOh7X9mH85Ja6nCEe46drA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0199.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::20) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c59b398-ccaa-49f0-e3fb-08dc0d1fa3e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBpb7oDqwTEKmFvJpRgJu+sXx/Nng2n5inNL9y4OnjB2N5RaA0OFQXzfEjQNWFwqkFirbvXHrdJ8uQIxHdJqOl6ODr7R9BpvirqIsZczBDzVlGXmH8qm9BhiwqgQCrHp1cNmVCLg7ChACJhJ36Hwh7xmbOgB0m0+SVPONLwZCPsr9I5GopDbkl7k6ybEQ3/AOpqUOnrO4mFKfIqwgDuxHkpuWSecjIdYFvYGzOkv5N7QYjY8Ze7CFpBX6fVINXUqVcaVkQ+PDe0nSGQH96HxnfAvXXRKdPcR5MF02cN0UPAtopxU7/TZj9/js+LqKwT8HQD8OxNkGyX4fsyhKlDH1UN5/tfu/zDnAECI0n7mjqzqTlfJueTJ9HopEroBPESZPIV5Sst+am55VWY55gSWvYgcv2TIP4S/iUd+su9XddYY0AOXi9vBA/YB/+SyPbB9ObgkMPuLHWaCZkT8f/KiMHI44U7JKHwPHHAxTHxdr4lOgcKF8Db0aYNw6Fy523IwmL/MWUfXU4918iuKrKHX0PFOc5/97vLrusQL7gjGJYOw0qlb+cGObmsabOhjcA2KeHAZyR8v/msHXJnO9k3cZE/aI0aysjalimMV1KRv6U4cpA8dXk71I9FXZQ0yz75ZohBcXbtm2nAne6uzI7FTSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(31696002)(6486002)(36756003)(26005)(86362001)(83380400001)(41300700001)(44832011)(2906002)(38100700002)(8936002)(54906003)(5660300002)(66556008)(6916009)(66476007)(66946007)(8676002)(316002)(4326008)(2616005)(31686004)(53546011)(6666004)(6512007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T081M29Ba3Q4djl1K0FZMWZKNHRiY2RZZ3g4Y2JOamhaT1Q3am5oSU1waEc4?=
 =?utf-8?B?ckRXVytQVi9BbkR0OHZDTWlxYjgvbVZHbWxhNlJIRTJsMmtGVWtSSkVrNnNj?=
 =?utf-8?B?RVRhK1p2ZnA3ZXVFU3ZKWlNvUlRFaTM3bFBMdEJlQjRXVUFyd1V6eUR0U0Nt?=
 =?utf-8?B?Qm52T0hyVklQd1RNMGEzRGZvcVZ2eC85NmxBbmhoOTZTN0NWeUFlMThFNjh0?=
 =?utf-8?B?T2N0dVFvVDVQbnJLaElLcEtsLzZMWjRyTTkzKzF4OC9IR21pOTZVVkdlT2hN?=
 =?utf-8?B?RWNYZnlnYklsSEh5OFM5dXQzMHJXUGJBcVRJUTNVSjVYamxPbmNaUXRMd2Ni?=
 =?utf-8?B?SVZhYi9yMTJaWUl3R2RLRThJOTNacjRRemxzMVRsOFFPS1hjVUhGOS90SExh?=
 =?utf-8?B?YUwrYXR6RXp3Zmp4ZXdkcHRCa2lWTFZueVpGMGlheXBUbDJmNmRuM2h5c3Fa?=
 =?utf-8?B?dnFTYnh3THFxcHhSMFJGQ2VQVE9NUURUalVSSmVXWkNoaFo3YmJTNUZUdmxq?=
 =?utf-8?B?NFVEcmx3cmU3NzBtckNQNXdFYVJsUFl2S1M3a2xwOTAycjBuYkltQ2ZELzdk?=
 =?utf-8?B?RFFZeXhhaW1KTXJ6Rzk4RnhxQ2Z5cFo3cTdkYTdYK0x3NWljMXhmWW1EdGxC?=
 =?utf-8?B?VU1kNHZmTlVPaC9KZ3p1Z1pIOXhsalB4S29pd3hGa2hQc1FtQ3c3ZmhnWDJ3?=
 =?utf-8?B?em9iRjFkelhHNGFlYkszaHoyRXpjU3I0MmQxTzJ4UGQwZXoyYU01OW82WWtm?=
 =?utf-8?B?Y21QM1psUGprOGQrNHVZZDVtbWszdTlMaU15cmhGY1I5N1Qzck5vSEsxRk1R?=
 =?utf-8?B?SUQ1WjMxUDU4cDE1bk1NaWowejVuSWxIZnBhempwRkQyaGtpYVp4U3JtZkJL?=
 =?utf-8?B?RjZkU0RCOFEvTGJaYWdSRS80YzAxY1BSb2NidmJRQVFJRTQ1UGQ4REN6UDZh?=
 =?utf-8?B?M3EyZXdjR0NHZWNKcUZwb2tUU1E4aXF5Y3V4OUpwdlpoNEhtT2E5cVgrRzJY?=
 =?utf-8?B?R0JTUDR5TDFVVDE2ZXdpd2hXc3diK3RZU056dGtKTWo3UmpWeGkzVFh1R1g4?=
 =?utf-8?B?ekdsZ1JVakEydG9xRTlRVlBMSGtyekNITnIyM1BwY2YvVThzc1E2dXYyOEVv?=
 =?utf-8?B?Mk1QeHoyVkN3SUJIaHE4TW5SL3lpa0dqcGt2aXU0RVB4dTljTGtrWVQzRW1l?=
 =?utf-8?B?MEsrODgzcFhadVBLSzQyMTJsdXgyZ2E1cElDVjhUSTRteXhtR2VJTUFhYzlp?=
 =?utf-8?B?OFM3WFh0SmhxbHRJdGlMU1p2MmhDTW1TM2dYYis1cWttSEpIUUtabHdiRGZQ?=
 =?utf-8?B?Q1JFUHdNbnRuRkZjbFVudVNLQ292aVVjQTdGeTFqbWpaOW42ZUhTcUJiaEoy?=
 =?utf-8?B?YldINTZ4bEx2dHZxREUvTlE0MDM1Mm9JcXVFb1g2OGU3Q21BUFRWaXFLeUV2?=
 =?utf-8?B?aGJ2YUxyd0t4K2l5bzJxMVpHZURxbDFKUDdkVGpPZVhPSFM3b3pDekZndVhq?=
 =?utf-8?B?UTZ3Y0dWQ0czenRUMDNiSHY3MDAvWVQyOE9RUVowZEVYdVBYNlFXazdDMWt6?=
 =?utf-8?B?T1hWSkluSlFoNjR0cE9nN2kxa3AxWWljQVU0aWFhek5LTDBwS1c1cWdlcko2?=
 =?utf-8?B?Zi9Eanphc3l5S2R1ODVGbTlsLzZ3aWZ0a3RnSGVRVE5tdzMwNzdYZS9CamY1?=
 =?utf-8?B?RkZ0Z2E3Y21ZeW5LcWowMnduWXAvZ3ZUaGlwOXRUaU9nTG16MDVOU0JrUDJx?=
 =?utf-8?B?emlVZHBFam04ZkxtUXdUaEpIRzlLZytqTmh5MzY5Tm10TENpMnJ1ZTNNOHNW?=
 =?utf-8?B?RlNneGtab2U4VlVvY0xBVS9VaHdMQTRUaCtycWsrdXloZkZQVnIyS0pwMllU?=
 =?utf-8?B?QXRNYmljUnEraVZRRkxHOVhITjZsOEQzZFFKSTZVSityVTBtcjJqenNTellV?=
 =?utf-8?B?QXh1U2RvOHppWldpNFJRY3FSNS9zelJKR09YdlhtYUEzVlpWWVBMdXVLVWhR?=
 =?utf-8?B?MGpheFJQTEFkb1VNV25BYnZNS2ZBMDErN3k3QzV1Ynpib0Zpb1hCWE5CeXI0?=
 =?utf-8?B?NVBSNHpRa21GV1p0OHdocHVKRkFZZ1NzZUxHc2QrNTdtUVV1WlhvUlgwQkpN?=
 =?utf-8?Q?uZoeMzgsoa7z9Pn6WNxW0I3BD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c59b398-ccaa-49f0-e3fb-08dc0d1fa3e1
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:21:12.6690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zb7Vjt6XNFGJT9KDo/D8QmQMEpp5P3banoYrmCcxDPhqPLE7AmY7pZRBXr3t/Djg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552
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



On 1/4/24 13:15, Weizhao Ouyang wrote:
> On Thu, Jan 4, 2024 at 8:00 PM Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 1/4/24 12:46, Weizhao Ouyang wrote:
>>> Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
>>> crashes.
>>>
>>> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>>> ---
>>>    cmd/sf.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/cmd/sf.c b/cmd/sf.c
>>> index 730996c02b..e3866899f6 100644
>>> --- a/cmd/sf.c
>>> +++ b/cmd/sf.c
>>> @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *const argv[])
>>>        }
>>>        flash = NULL;
>>>        if (use_dt) {
>>> -             spi_flash_probe_bus_cs(bus, cs, &new);
>>> -             flash = dev_get_uclass_priv(new);
>>> +             ret = spi_flash_probe_bus_cs(bus, cs, &new);
>>
>> if (ret)
>>          return ret;
>>
>> don't you want to rather propagate that error?
>>
> 
> Well, since the spi_flash is empty, the following code will
> print the error message and return.

And you return 0 which means everything is fine. But is everything fine in this 
case? Or do you want to see the error?

This is command it means you can simply use && and if previous command succeed 
you can call something else.

Thanks,
Michal


