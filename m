Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB95CE7A94
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A572D86C28;
	Mon, 25 Sep 2023 16:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oGmLHwcl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453F786C37; Mon, 25 Sep 2023 16:21:33 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C7586B2E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMHKqhHdHiS8jrVkHm32uODyeMMD9hsEU36/C605zrC4xKFs8Vrm61E9VLMg788bH6as3q1BzrlFDz3bcpED0p//v2+5DXME9JfM9rHfhamjKP7cyftXmqAyAEWkJ4DEt2qVFkuIkF+/6U012Dpms1AJ1uM6z8CbZVVT4WJ2gdZ9LeZZEPf56eGQTeU778Jrds3hI4g1hr9iOlsX846miDpZ/mIdi1fF7cVDrotxZuxy/gw2vQbHhe5aX9TrwNtMJmfDLVk1fnGSE+56iMB+Sr59Vg8L6bPtv4EaBYSem1FMd5gYmE2Um6WRBvO4sFnJQMzRFAFObhUwMP7lPay59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3wsgOt6gMqVLz0TvDc8yrH9eBHyHrkJTjuEsIxDGyE=;
 b=Prz4Ww5R8L6D/eQbUMRokIr3Zh2sLGLgv8q1sMrejubbmnfFfT7Dtof8C7II6z21ml1lsuKzwLZmrm0J81+wLMfFe4Hzo70tfpm3jthumFC2MBiWLK3Ni4nykMfO1e4xrhcGHRhXmtgSNZ2Mz7QyR6Pwy1sHAPTmOe2ZzYlWgSnfT55kyBAGcioJP6nIxhKfcsY6XRh1KTiBNZgOaswj69cJX7XdFIZAso3vldtjO6j5i+WsVAo/gmqjLgh54ErEeXeJkSyIv+IWsCemXuqRmkG5whOUEuk/N8hnGzksEcLftvwo6DaDwpNS5/qMGl9vCT80O4tJ3WTjG0WKTbE3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3wsgOt6gMqVLz0TvDc8yrH9eBHyHrkJTjuEsIxDGyE=;
 b=oGmLHwclFEM2ByhsHRTd8dxxRVu8YrHHLaA2HjjNvOvwAKMeAmdBYUmg4sFkJzJG+/3a72ZYFKl94UJLAQHoPbiq6oVSUU1q9ru62PYKByXvQvTJLo7cbJ4rL9h1q7Ud/Oslr0P1xhBvlBPuUqPKWJtwwzqNtYQh5jXNqhWr5Jw=
Received: from MN2PR10CA0035.namprd10.prod.outlook.com (2603:10b6:208:120::48)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Mon, 25 Sep
 2023 14:21:26 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::a3) by MN2PR10CA0035.outlook.office365.com
 (2603:10b6:208:120::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 14:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 14:21:25 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 09:21:22 -0500
Message-ID: <914d3ebf-12d8-4651-a598-ca8edf6d5171@amd.com>
Date: Mon, 25 Sep 2023 16:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>, <git@xilinx.com>
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
 <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
 <386b048d-1880-4b39-8323-5d0206fc5f71@amd.com>
 <20230925141906.GW305624@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230925141906.GW305624@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MW4PR12MB5644:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d7f9bf-35cf-409a-2636-08dbbdd2b36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4r9TtkfpP2C4pu5Gs5O0sGxdNlbBZf0MceFfK3WZJDdVhfnVWIKWPyd/BiJBWDdmSwvyJFJAG9tstNkd7xuZsOlDE8om/iz7fT+ix7VBjhan+SAGB8xt14c7UOuAW6okzAhUlIC04GYeQvpS5UrbjbaGcXzbnod7IddNz5xz9IDGvV05u7vu1ZtfR0s6FOVJvmGCRQD+u1Kvp2COMzw9adnnpnDA1CAGY3RPpBO4ZNKfM5IGqFBZoGg58Ed+h1yBkaSmOra1eev5xnB+XLCtIXx9GfZ6cDU2GJ6t4P7gFiEo8jrl6ZqlulszuxfNgy+ILFJt0x3kUYszDaJ889BThLigCk/U9dkFTA9uWUfArEwBGL1rAvenlnQr2vozebpy5cQgrEpws/D5BPr17k10qSmClrPsccatP1AatiqeYvuVh90/az45JgPhcomSrE5w2hsWQOwqgeIyvyABdDEKAQMtR00+ORigl+Bzja4/XwvjlqLa5Q8rRPCpjAXi6RMjg9nCjcMs2f/wn4CEA5VLpxxOm4T7l0LWzQAHps42MZY7y/IBw9/KOajMJ3XUjAy6b9A7uVOFBKuEusx6oSVB9VVJ22Wp5BGymqQ9PLA4bJb7MaCGT9mC60M8sBuFS6L5JryXEhHfxTRZkjXjJv6RMiO+ao+W7nWdHTro5sH18UYQ4G9IwfkoHVrUKYEGLzF3JwlKJxuHvsfmTBslJ7R8ceOaLekxZKl8az3jtOKm/ept3nBqHYk1FWQWq8FS3ZgAc2RPefonFlhDggqDubfMhY3DB3t0NM7hnDjep4qf0bU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(966005)(5660300002)(53546011)(6666004)(83380400001)(47076005)(336012)(478600001)(2616005)(26005)(426003)(40460700003)(107886003)(44832011)(6916009)(70206006)(8676002)(70586007)(16576012)(54906003)(41300700001)(16526019)(316002)(4326008)(81166007)(36756003)(86362001)(356005)(2906002)(8936002)(82740400003)(31696002)(36860700001)(40480700001)(31686004)(66899024)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:21:25.3645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d7f9bf-35cf-409a-2636-08dbbdd2b36d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
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



On 9/25/23 16:19, Tom Rini wrote:
> On Mon, Sep 25, 2023 at 04:10:38PM +0200, Michal Simek wrote:
>> Hi Simon,
>>
>> On 9/25/23 16:01, Simon Glass wrote:
>>> Hi Michal,
>>>
>>> On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/25/23 15:10, Simon Glass wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>> Hi Simon,
>>>>>>
>>>>>>
>>>>>> On 9/23/23 20:13, Simon Glass wrote:
>>>>>>> Current alignment which is using 16 bytes is not correct in connection to
>>>>>>> trace_clocks description and it's length.
>>>>>>> That's why use start_addr variable and record proper size based on used
>>>>>>> entries.
>>>>>>>
>>>>>>> Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>>> ---
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>> - s/start_addr/start_ofs/g'
>>>>>>>
>>>>>>>      tools/proftool.c | 31 +++++++++++++++++++++++++++++--
>>>>>>>      1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> Applied to u-boot-dm, thanks!
>>>>>>
>>>>>> FYI: I have merged it to my tree and already sent pull request to Tom.
>>>>>> Without it I couldn't pass CI loop to get all reviewed features in.
>>>>>>
>>>>>> https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c4f5@amd.com/
>>>>>
>>>>> Ah OK, well that's fine. It was in my patchwork queue still, which
>>>>> suggests that the patches were not set to 'applied'?
>>>>
>>>> I am not using patchwork. But I expect my reply to cover letter was recorded there.
>>>
>>> Probably. If you reply to each patch, it shows up in the patch, but
>>> the cover letter is hidden somewhere else.
>>
>> I have never started to like patchwork. I installed that client long time
>> ago, I also have account for quite a long time.
>>
>>> If you are not using patchwork, how come you are a custodian? Is
>>> someone else dealing with patchwork for you?
>>
>> Not really. I am just keep track on it via emails.
>>
>> DT folks did wire CI loop on every patch which they get. I am not aware
>> about any feature like this which would bring me something. That's why I am
>> considering patchwork as unneeded layer. And I also don't think that I have
>> read anywhere that all custodians should be using patchwork.
> 
> Right, patchwork isn't required, but can be helpful.  Part of how
> patchwork is maintained for everyone (in U-Boot) is that I have a script
> that will update the status of patches to accepted and add the githash,
> based on the "patchwork hash" of a given commit.  There's a number of
> automated tooling things that other projects use which could be helpful
> here, but due to lack of time/resources, we haven't tried them here.

Can you share that script? I am happy to run it and pretty much close my list.
I am using b4 for applying patches that's why all message-ids are listed in the 
history which will uniquely identify that patches.

Thanks,
Michal

