Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A581EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 10:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5CC86CC0;
	Mon, 11 Sep 2023 12:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FA0LoFWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3547586C8C; Mon, 11 Sep 2023 12:58:36 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D2A086DFF
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 12:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGUlhEIwzcUdLzVaIp10qEuNvvdAZCYGMYNmrT0H5GQvOQtiujNV+Pzxrk/znTVoPLWsJNvCvUa4GjcMlAB8hSdlORjrLh/93x/d+Cnf4fHC8BS32L9d9gQlRqFcZgZgGQ5nI+XZUlFEizdXKsplJfuPl/xn1q1swkRC03HTKdsPdev39WFJc2Owc0WgB2baNhKr6nZqka65qzOLiGtfPOzltwOnbm+mVwdtxJqypRPJNhmSvABt2do+siUfbN5EEHzhzuy6CaxWzF7JwrsezWtRb4kzg/d2liIdcDuZvOgCMdjKtMd5oTnMzLK1rAzgNnHiJag6hddQbP0KHGMJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wXByfXSC0r4vYTF2gROz2SME94cYBLH1V7NMnDSveQ=;
 b=T0HM07WiLKhIRMprsiBG5ru5slHHuFcspYjv4wkzSPjkfHa4BB8xZ8I4S/sh7+0RdPZ+LR2pEIlsxoQCQAujVB39sisSUYA0VQByrPp9UIOr6BOHWwGQMxD5PKkiNBxHGaSqR/xEZsVYMfnqRiodIcAOkYfl8AxpZVaboqPHrNWwyPEpcJ//SRcEqNUcp5H5tHO1tvKWWU0UWl9q4wOByYdhXkhAbSmG14/sMaymcwPtXydY5VnxPgxFe+ieRwTKnd1eTK/hAo4TMlpMP++VXVOOgDiUylPKhnelHKNzkZDlJG9d9cLhjJer6inguwjFlw4e0q/I8KtyvFaVYlyOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wXByfXSC0r4vYTF2gROz2SME94cYBLH1V7NMnDSveQ=;
 b=FA0LoFWcOgGR4J7WH7TvT2H+oRmUsZ6AK5Fu4ZLUNVfXp5dMDDZ7K1+i6s/LbKdNG4xH5fQhinlx2NLgJ8tSP2vTz7bc79zj5JYXkhpkZpEx3eYBFS4xXWF5u3tq6YCnHwC5panbLViAcWaNV81uQKcGrc3ynPbH/IimWpYlqc8=
Received: from MW2PR2101CA0009.namprd21.prod.outlook.com (2603:10b6:302:1::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 10:58:28 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::1d) by MW2PR2101CA0009.outlook.office365.com
 (2603:10b6:302:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.4 via Frontend
 Transport; Mon, 11 Sep 2023 10:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.1 via Frontend Transport; Mon, 11 Sep 2023 10:58:28 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 05:58:25 -0500
Message-ID: <8528ca89-16a7-48ba-95d3-72e7f3b107eb@amd.com>
Date: Mon, 11 Sep 2023 12:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>, Bin Meng
 <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain
 <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>, Stefan Roese <sr@denx.de>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-31-sjg@chromium.org> <ZPA8AtGOel8pko6y@hades>
 <CAPnjgZ1gat+g=dRUO4Akk2YMp_=wy7agQM2CuwaRB7J-C6u=kw@mail.gmail.com>
 <CAC_iWj+HQSGfntZV_5ccUXfi8w6AGp3ETxUUORtm+bhXBuX3gQ@mail.gmail.com>
 <CAPnjgZ0JkXkr+0ZPt5Om1-XzjY3rWjjDd8B5grqmUqGUxf7u_Q@mail.gmail.com>
 <CAC_iWjL-F7Vo+oL0aJG=A4a3es__8S-krt7dBs77Snh1pFkPHQ@mail.gmail.com>
 <CAPnjgZ2QV3t9FnY_7VBJ4NAYW8zPL9p1bktfcEP86AnXrFoA1w@mail.gmail.com>
 <CAC_iWjKd60b2pPdQf195ef+a8_3jEHtXh085Sd7uPAik1mCu+Q@mail.gmail.com>
 <700c3677-6fc1-40b0-9ca2-9f9e2cc824b0@amd.com>
 <CAC_iWjJUbads2Trqxm_chnhypyZ+tTT2mXUw56z0Py9bgyBhZg@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAC_iWjJUbads2Trqxm_chnhypyZ+tTT2mXUw56z0Py9bgyBhZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4bf4c9-0f75-4269-4734-08dbb2b60777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlV6h74VzDDJGbmCUoeEmXprgFW+pQ4vdC6sCrtEQ4G/rxaUXJrM3rsOuuw4vAvaw131Xcu8+Jd6Kgxg7U97cX3Shp0x+jm3hWhuIiitDSTboE0p9AkSET+SEbqjYDFf0kRdbQw0RhKtmajfLVBrSQ11t783RuFAvcBOdGO4ZTrq8WyYNA0hi1GDBxZCOb6E6Qpt0O1es7TYgpZlc5666o93IIZQdyCB9MQ/nnHlYTvfaixB9OFeqrP1bX28mJd1Ti7X4jHqPYkit9maZXwM+VVOyHw22paP1NR7QTyUuxTUp0n04u/JOA4fdMnLgwjuX73XStwQLojO/3f3FNFCESd4Up5lA5KeQBK93bIykdIQ6lHHtqX9AaqKFleRBhLE+2jaiH+cQ3dP+bfdWfv9e36K13mDhaV7bV5bQA7rtOqMVZ7086pryXqOstmajolPJroix8AUQDWpHNJqG89o0Bqs+pbWvQ6Z5ivLFAj5prfJtKxIhRkgAGAzBUfJkkf4nkuo/qDLFZb4UpglSOsbDp1q5J5sm0U6uVclF+fxgLvfaeBjYV5tANbyh0+Fb29R38AzxHXxpf/SKZYdhCu1xATR9FjaQuIHMkPZKsrKp65cMQkxHgODUp7EbPdn+4u7FyIDtlex1nP97X5TIOb3jPusHN1U07dPhGbnNYnc/U3q4Ru/hGT7nZ27HUSHbKbQ2TCEhpnRmFQ/J1KyaUfOc9Q+nl6tV+KPRfWAkzJZRmbKQlFqKKrCs1jgITrtsWdST+1TPaVKP63qnMt8U9wOHAEVaELwSKy9Jt5Rg2BYM5aouf9pVaG5mvHpiubhGHJ2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(31686004)(81166007)(53546011)(6666004)(41300700001)(356005)(36756003)(40460700003)(86362001)(31696002)(40480700001)(82740400003)(36860700001)(47076005)(2616005)(2906002)(336012)(16526019)(426003)(83380400001)(478600001)(70586007)(316002)(70206006)(8676002)(8936002)(4326008)(5660300002)(7416002)(26005)(44832011)(16576012)(6916009)(54906003)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 10:58:28.0700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4bf4c9-0f75-4269-4734-08dbb2b60777
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
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

Hi Ilias,

On 9/11/23 09:56, Ilias Apalodimas wrote:
> Hi Michal,
> 
> On Mon, 11 Sept 2023 at 09:38, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 9/11/23 08:17, Ilias Apalodimas wrote:
>>> Hi Simon,
>>>
>>> On Sun, 10 Sept 2023 at 22:14, Simon Glass <sjg@chromium.org> wrote:
>>>>
>>>> Hi Ilias,
>>>>
>>>> On Mon, 4 Sept 2023 at 03:31, Ilias Apalodimas
>>>> <ilias.apalodimas@linaro.org> wrote:
>>>>>
>>>>> Hi Simon,
>>>>>
>>>>> On Fri, 1 Sept 2023 at 18:51, Simon Glass <sjg@chromium.org> wrote:
>>>>>>
>>>>>> Hi Ilias,
>>>>>>
>>>>>> On Fri, 1 Sept 2023 at 01:50, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>>>
>>>>>>>>>> +config OF_BLOBLIST
>>>>>>>>>> +     bool "DTB is provided by a bloblist"
>>>>>>>>>> +     help
>>>>>>>>>> +       Select this to read the devicetree from the bloblist. This allows
>>>>>>>>>> +       using a bloblist to transfer the devicetree between  U-Boot phases.
>>>>>>>>>> +       The devicetree is stored in the bloblist by an early phase so that
>>>>>>>>>> +       U-Boot can read it.
>>>>>>>>>> +
>>>>>>>>>
>>>>>>>>> I dont think this is a good idea.  We used to have 4-5 different options
>>>>>>>>> here, which we tried to clean up and ended up with two very discrete
>>>>>>>>> options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
>>>>>>>>> have a header of some sort?  The bloblist literally comes from a previous
>>>>>>>>> stage bootloader which is what OF_BOARD is here for. So why can't we just
>>>>>>>>> read the header and figure out if the magic of the bloblist matches?
>>>>>>>>
>>>>>>>> No, OF_BOARD is a hack to allow boards to do what they like with the FDT.
>>>>>>>>
>>>>>>>> This patch is a standard mechanism to pass the DT from one firmware
>>>>>>>> phase to the next. We have spent quite a bit of time creating a spec
>>>>>>>> for it, and we should use it.
>>>>>>>
>>>>>>> Where exactly am I objecting using the spec?   Can you please re-read my email?
>>>>>>> I am actually pointing out we should use the spec *properly*.  So
>>>>>>> instead of having a Kconfig option for the DT, which is pretty
>>>>>>> pointless,  we should parse the bloblist.  If the header defined by
>>>>>>> the *spec* is found, we should just search for the DT in there.
>>>>>>> What you are doing here, is take the spec, pick a very specific item
>>>>>>> that the list contains, and create a Kconfig option out of it.  Which
>>>>>>> basically ignores the discoverable options of the bloblist.  For
>>>>>>> example, that bloblist can also contain an entry to a TPM eventlog.
>>>>>>> Should we start creating Kconfig options for all the firmware handoff
>>>>>>> entries that are defined on that spec?
>>>>>>
>>>>>> OK so that is a different thing. What should it do if it expects to find a bloblist but cannot? I want it to throw an error, because I am trying to make the boot deterministic. What do you think?
>>>>>
>>>>> That's fine by me.  You can even put that under IS_ENABLED for the
>>>>> bloblist inside the existing OF_BOARD check.  So I was thinking
>>>>> - If no bloblist is required in Kconfig options we do the hacks we used to
>>>>> - if bloblist is selected and the config option is OF_BOARD, throw an
>>>>> error and mention that the previous stage loader should hand over a DT
>>>>>
>>>>> Is that what you had in mind?
>>>>
>>>> Yes, that sounds good to me.
>>>>
>>>> But I still think we need an OF_BLOBLIST option to control whether the
>>>> devicetree comes from there.
>>>>    Otherwise we will end up with people
>>>> using OF_BOARD to work around it. We also have the SPL case which does
>>>> not pass the DT in a bloblist...in fact SPL typically doesn't even
>>>> have the full DT.
>>>
>>> Wouldn't IS_ENABLED(BLOBLIST) || IS_ENABLED(SPL_BLOBLIST) be enough?
>>> Inside the OF_BOARD portion of the function, search for a bloblist if
>>> the option is enabled.  If you can't find a bloblist and the DT within
>>> that bloblist, then error out
>>
>> Just my 2c here.
>> I think all options should be possible to disable. It means I can imagine to
>> disable u-boot not to take care about DT provided from previous stage. The same
>> is for TPM event log. IMHO every stage should have an option to simply ignore
>> data pass from previous stage. I don't really mind how it is done but there
>> should be an option to by purpose say to ignore the part of pass data.
> 
> That would be done by disabling BLOBLIST.  I don't think having a Kconfig to say
> "I want a bloblist, but I only want the DT from there" is reasonable
> (or for any other item the bloblist can carry).   OF_BOARD means the
> DT will come from a previous stage loader. If bloblist is enabled then
> the DT must come from there.

I don't agree on this. If bloblist is enabled and DT is passed SW should have a 
freedom to ignore it.

At start everything is likely in sync but later stages before U-Boot can stay at 
certain version but there could be a need to update u-boot where DT from 
previous stage could be broken.


>>
>> Regarding DT part. We are experimenting with TF-A injecting for example DDR
>> memory reservation to DT.
>> Injection is working properly if you are using single DT but in SOM case we are
>> using FIT image with a lot of DTBs inside (issue with checksums calculation).
>> I see couple of platforms (IIRC renesas/imx) which are using DT overlays and
>> passing it via specific registers. For these using bloblist might be right way
>> to go.
> 
> Yes that's in fact the purpose of that spec.

Good that I read it properly.

Thanks,
Michal

