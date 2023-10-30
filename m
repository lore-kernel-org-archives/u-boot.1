Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8983DC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 07:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3438C879ED;
	Mon, 30 Oct 2023 08:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vb+y2tLG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 669A2879ED; Mon, 30 Oct 2023 08:53:40 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33682879E5
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 08:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN0adiJrHvDJfms52405Qx4oLhW2cGYhx0jhpZG+tSA5fGpo50PD26TkrxJ4L+E3NEnXVCw5wLzCOVkg4wMm3ZFP/XOtK19pZx2lC/XSO7hwhoJiL7ZQfSkfObU0lpccVOXAwXCKXMKA/d0ELpm6LQFjXpEc4cXulYxh2hY8CTPb6tTBXsDbu9NolbJFSvkbJQ9Xe5Zj5P4o9GFnOH/qa3NOnU4IWzAWv9rZ6P1db4E1qPM1zwYtDFI4cBVsNo4AJATBQIcUcyke0CvoVEcRQjlsyqg4pMpWMy5RHiYZPKlxMR1xydXyPBv6VpK6DFzKIQgBFlo1V2eT6gfhFgIfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hm0mqyLKUUEVA1vvuSxVeSNYbapFel8PqM2uOwEXg4=;
 b=DSvQ17SjjQRXt9wnhDY5hHauh7TJlhwVdeZ6JzhP7eSJa2+mzTj3wNBBY3jVErDHSxn6XKU5phg7ngS+aNaqO8tBYq8ICs8Lv2L7hVjxz9Aa7CNgbDw+5tQ1D5uXd/j50WjohFyBegl40fWAbpM0XsX/x4qZ3OUxyPN2VVLX+p2e/xIfw8BCNvLKNt+63w7DKWHZkHHhErL90yBnJAn4opO0EzmOAd/7ejJMbmvkGfEDgdpxlm8Jdz4TWUin/nRYBibzm9KiLI4fLteLuh5sP3eh0WRW+xoA9zzb7eZ/ECBdHZbiRDtHmS0+NppK7SjsCvH0aozpQPqD4DLPnJc+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hm0mqyLKUUEVA1vvuSxVeSNYbapFel8PqM2uOwEXg4=;
 b=Vb+y2tLGkxNdflVsJyBOet4zx/DeEnm0tLwzh3tzVOdgn/9zjlsCf4mgD1qEfrAYjgLJNhyuu1pBQiIsLUKKsZpnbBaCNbWJwaHb24Q9DJ8hQVoHY3Gm0aBvuwDb3wTy9F0z5NERCR3JBEf8oG6v5Wg6jDQOM7yOuwAd6S0ofMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 07:53:33 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4993:59af:a31a:abff]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4993:59af:a31a:abff%6]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 07:53:32 +0000
Message-ID: <c75a188b-0bfc-44de-b4a2-0efd2dcb7f0e@amd.com>
Date: Mon, 30 Oct 2023 08:53:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] bloblist: Align to firmware handoff
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Michal Simek <monstr@monstr.eu>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Julius Werner <jwerner@chromium.org>,
 Dan Handley <dan.handley@arm.com>, Jose Marinho <jose.marinho@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
References: <20230725213634.255345-1-sjg@chromium.org>
 <CAHTX3dJ+es41yLzPA32kLWt70d0rGATCROJBW8aXMZjZA5w=Hg@mail.gmail.com>
 <CAPnjgZ0hYHxc6HKd2wMu4jdTtDyNDxRmcSDMCs6azNwr=tstjA@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAPnjgZ0hYHxc6HKd2wMu4jdTtDyNDxRmcSDMCs6azNwr=tstjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0254.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::27) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 76424b0d-a890-4846-c173-08dbd91d503e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Svn8tA0/h1g6pF48X2if5IcobdUrcR9l/5g4O2ejjvAzwGGlkOmZE3UDUBxH9A62jYFcCsOmMR6YGG4gp4N8eMqujda6xXHycMK1ptlQw9SP+UpbUFgaXPtUHkJeZsvemdHySNz6Ukd64OkBARD8PuuO1ruAknVCVIG++VKJBibynokLR0BK/Vcn0RnuVs3RD9Rs899Y5btTQcLgFzUh2vYiPZQkmewV0HjF1OpFOrKry+ODB3DFJFVhFrOU9PQ8UmSzpX3dh9RldcJ+PK94J1tW3LqAD64PzOsJmrj0rutrsruYwjp8wHX3Hx+ngTE5CZ56X1AmPNVwa5jVGUHrBXC6kwqJnFVfxrtHwK34jh30WPCF7Xo95VaYFVRZDu12Fl7i7TYBQgW0qenCf4dta7E+cTSZi6y4MroTVg1KPpzM2nPw1+AYr5GUzouPzgv8Z0+q89QWKAlbbnL+Bi10ve6+3hc1KG97SEArn9kTe5m1wYgmcvyYgrrt23CyTFIIPHNuYKbVHnP+FUQYte3y4XuvFGk5ny0hj0UIW+WhSE6y6gTQCX/OXd5EUdeuj1F8iZvYSGOattb4wWjx9WW9Eq6EwwUiXIynOOyBJLKLaD+o9QZc24E5XOCmneCL1aj0B+E9mrQtuFySVsHY7OaZInZlAUjdQJMR4eyWEW6mlOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6666004)(478600001)(6506007)(6486002)(66946007)(110136005)(26005)(66574015)(53546011)(6512007)(2616005)(66476007)(66556008)(41300700001)(2906002)(316002)(8676002)(4326008)(8936002)(54906003)(5660300002)(7416002)(44832011)(31696002)(86362001)(36756003)(83380400001)(38100700002)(31686004)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW9JRzg2SjVPWnExcktsNHJzNUpPVE4rNWhxTGtTMnhLNk4rUVM4bHdqQVNU?=
 =?utf-8?B?VDF1VVNwZGs1N2tZT3prN29ROG44dTNhNjRxaG5qdDE2WlpLRGR3dXBaV0Fr?=
 =?utf-8?B?c0lNdVVobDdUOUlIeHRVUmtWY25XcDA1TExUWXBLdEw5S1kyTXpVb3VrNllQ?=
 =?utf-8?B?MXU1Z1hLc1hZMklFWldmNDg0SDdxazhod3N1RjNyMkdZdWdXUjZzLzNxVm5I?=
 =?utf-8?B?M3NUempod3FSSE42bFRsQlBHQ2pGY2xPWEFzalNKRzROc3MyOUtkelFGS2dC?=
 =?utf-8?B?SVY2cDdoU21Ma3prOWx3Z2dZdUFMd3BRUDBqWnNDelRvUlZoUnlObmcvc0xl?=
 =?utf-8?B?QjBCSGpLUUlPYkc0UnJwUHQ3dFZEeDZ1Yi9uR1FFVVY0eFkwcGtrTzJLTTB4?=
 =?utf-8?B?UEpwR2hSWWZ5ei9lNEp2NmZtY1RXdlM5NHVrU0dDalJmaUwxSUgzUkRqUTlz?=
 =?utf-8?B?TzBRak5od0xEVFJUNHVhRnNTZW1XKzlGZ1cvV1RETERhenJTZXRDVGpVT090?=
 =?utf-8?B?bFNDMkwxNmFUMUp5eGlqRW1XN09xZDBJaG9lWXhsTXJVWW1BN090MDJ0Qkc1?=
 =?utf-8?B?YUhHbi8wT20wZmNwTzF1YWM4TkZxblNBNHVvcW1mSTdwYllDK2FiT1ZRcUxt?=
 =?utf-8?B?ZHRIaGxWRVpwRWx4ZXUwRWtuVVRvVmxlaFNxTFNLZk52cC9yRmN1QUxZQTIx?=
 =?utf-8?B?ZVVEQ210MzJERklBS1paOHVDeXZSbHF0RXBjRENqU05IRkEvRFpOYTBjVmJC?=
 =?utf-8?B?dkxZcDdZWWJmOEdQSGNFcDE4TUJZRzRhVU50Y1NIdTZSZ0NjY2JJVmZzODdM?=
 =?utf-8?B?TmphQTJPWVdyVGdVeFhJYzJ1S3BScEpQdXpNOTZlSVJnczdiMU12c2d5L2Zt?=
 =?utf-8?B?SFptR2FrNGJIMEo2WVdNQ1pNMlRYdmhRb1BjY25DUzRBZitFTmNxUGdnNDIx?=
 =?utf-8?B?bVV5N3N4T2IweVlVWUZSVHI4Q0V2azlTbisvNmNMRDNhcGNJaHRmZ0Z4WFhP?=
 =?utf-8?B?bFJOK0JiTWJjUGg1UFQwVENtV3ZqOXQ4MUhvSGxTQVZBZ3B5NVQ0N0RRYXRh?=
 =?utf-8?B?MFFFdEFEb1JEODJpWGFTM0t0UUtLY0c1cm1CVm1LTzhDUlpMajczaEd6aEtF?=
 =?utf-8?B?SUNoYjVRTDV4RHMxT0J6OU5JM291ZkI0NllEYVZZZy9DYm93Tk84TkJHV2xN?=
 =?utf-8?B?QXlnVG5wek5IQjV0Vjc1VDZseTBnd1FrcWc1M3c5eXowL2YxY0pOM3BLTXJT?=
 =?utf-8?B?NURuQ29nSWlPdk9OODlKUFJXS1FUUjRLczhDaGJGRmJXbktGdXAxbDdpWWti?=
 =?utf-8?B?ZkhHcEloNHB6QVNMRVpudnoxUVB0UGpkYXJibSsyNVQyVEp2a2d0MzJNdHhs?=
 =?utf-8?B?Z3hIRi9FZDBHdGdJb3F4Rmk4b21yaUdQRUlWMS9lWmZtZjgreDEzSE04WTJs?=
 =?utf-8?B?dTdOWmZZUDFZV2ZmVjUzRHV6K0wvUVNFUHB6VW5EMzhsQlN6aUdXMG1kV2hG?=
 =?utf-8?B?QkdHOVdXTm9yRGgwNXhCM0dRdmdVSlNwQlFVNERETjBqSDFvVGJVOUQ1aC85?=
 =?utf-8?B?akQ5K25VNDdaZ2V4WHJDditucUtEYzczN2RoMnA3OGNBcDQzT3N1Z3lEcFY1?=
 =?utf-8?B?Z2RkV3RXajZQcktaQlpwTkhwOUdWWG53TnZVeWc2ZWRYNG42dzVqeW1Ga0M4?=
 =?utf-8?B?eHVhbG15bWhxc3RPd1NJWGVaQ2UyOTgycWF0b2FOaHc0QlI0SzI2bHRPMml0?=
 =?utf-8?B?eG55VGxoQTRsdUIyUXdkakM3V1BxUE1lektSM2R4eHB5aHFqYUFOTEJWdThp?=
 =?utf-8?B?T21iRTM0UzB3RWx5Nm94S0FUT1U5UUVtMWhWVE1BbXNTYXdWWHlDWmNYaVcz?=
 =?utf-8?B?c0hBT3kzaGcwL1UwVTBxcmk0eHVFbStyWHFISk1JeXVuMG8waWxjSDFkbncv?=
 =?utf-8?B?NUFPSit3aTlva0NZaHZpYzVsYisvbkcxa2M5TzdIT0phUEd2OVZQR2JGalB1?=
 =?utf-8?B?VmthaEdJLzhoczRacEZvS2lYczFPSUQ1UmsyMXRSQ0g5TXBXdHVsRlR0SGp0?=
 =?utf-8?B?N1ZwbHYrdCtxcS9jSmo5cHlUa08rZHlHRTlNU0p2UVZILzBCcC9HNVlqTWhJ?=
 =?utf-8?Q?5h4mYIahfGXV8fZOsk4ZshnhD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76424b0d-a890-4846-c173-08dbd91d503e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 07:53:32.9125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q36gf6xHzUt3RsHfAmsITTYlnm3KpbxnojKylQlb8bbzRf9WGGI7vKOhQC8yQqZX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
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



On 10/28/23 07:35, Simon Glass wrote:
> Hi Michal,
> 
> On Wed, 6 Sept 2023 at 12:22, Michal Simek <monstr@monstr.eu> wrote:
>>
>> Hi Simon,
>>
>> út 25. 7. 2023 v 23:36 odesílatel Simon Glass <sjg@chromium.org> napsal:
>>>
>>> In moving from v0.8 to v0.9 the Firmware Handoff specification made some
>>> changes, including:
>>>
>>>     - Use a packed format for headers to reduce space
>>>     - Add an explicit alignment field in the header
>>>     - Renumber all the tags and reduce their size to 24 bits
>>>     - Drop use of the blob header to specify alignment, in favour of a
>>>       'void' blob type
>>>
>>> This series attempts to align to that specification, including updating
>>> the API and tests. It is likely that refinements will be made as other
>>> projects implement the spec too.
>>>
>>> As before the code is dual-licensed, to permit use in projects with a
>>> permissive license.
>>>
>>>
>>> Simon Glass (14):
>>>    bloblist: Update the tag numbering
>>>    bloblist: Adjust API to align in powers of 2
>>>    bloblist: Change the magic value
>>>    bloblist: Set version to 1
>>>    bloblist: Access record hdr_size and tag via a function
>>>    bloblist: Drop the flags value
>>>    bloblist: Drop the spare values
>>>    bloblist: Change the checksum algorithm
>>>    bloblist: Checksum the entire bloblist
>>>    bloblist: Handle alignment with a void entry
>>>    bloblist: Reduce blob-header size
>>>    bloblist: Reduce bloblist header size
>>>    bloblist: Add alignment to bloblist_new()
>>>    bloblist: Update documentation and header comment
>>>
>>>   arch/x86/lib/tables.c    |   3 +-
>>>   common/bloblist.c        | 102 ++++++++++++++++++++-------------
>>>   doc/develop/bloblist.rst |   4 +-
>>>   include/bloblist.h       | 121 +++++++++++++++++++--------------------
>>>   test/bloblist.c          |  53 +++++++++--------
>>>   5 files changed, 152 insertions(+), 131 deletions(-)
>>>
>>> --
>>> 2.41.0.487.g6d72f3e995-goog
>>>
>>
>> Would it be also possible to align names in the bloblist_hdr structure?
>> magic->signature
>> align_log2->alignment
>> alloced->size
>> size->max_size
>>
>> The same is for bloblist_rec.
> 
> OK. I am not sure I like the size/max_size thing so I filed an issue for that.

Fine for me. At the end they should match with spec. Update in spec is fine.

>>
>> I don't know the history but spec is about transfer list and transfer entry.
>> Do you plan to rename it to avoid confusion?
> 
> I don't really like transfer_list_xxx as an API. It is too
> long-winded. We used that name since it is unique and descriptive as
> to its purpose. But I think that 'bloblist' is a better name in the
> code base. Perhaps we could use xferlist instead of bloblist?

xferlist sounds good to me.

M
