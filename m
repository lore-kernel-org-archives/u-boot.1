Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF01CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 14:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3476086B36;
	Mon, 25 Sep 2023 16:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aoHsegU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC63386B36; Mon, 25 Sep 2023 16:43:19 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1114286C71
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKaTjXJKE7G9NhtFQEMlldFu+uy9NV3DhUDut085juj4KS72/3srl/b2EEucnI49DI4/UbxZmKd9DDn/kxl3Nn6kks/U2CoQMaXp+OjkDppq8ROEujDlxjOfIvfwNj2XotJ4WwNC9MEFvqhLwv6m7OVjPb1bDuWeyCZTBA+r8AR6hRTBuMGamp/P1OgRksd4rxxby5hTV1BUitmFi1yvz+sPNv9gMZIe2Yj+SY5HOsJdaQPF4zcpT/iUWoQjRNCGrk0HZY/jaSwJ2efvkdRuh4pqarLjVF+QSgsv6y3K4hBOco2U3aCc2h5a36XKVNd3V8aL7TTj/zkVgAxkQ+GaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/TG6ppWcgZ/4Wmkx6GDrNJeDkUMh/a4b89T1VVon5A=;
 b=DKQ4NXFbbvj6RcAs6BbkkJo7CQdiCSivDr4p1TwP+d+62vSkb4X24cGjDRb4X+TAuzlZbZw+27L3wEcc7qX6mcFlfeBrxn4NYcgBvkPb4Vg+8xkX4VDxrY4XB7fIgB9iWeaotPeD+J7r7DQFhkXdPunPg9frPf4QX6Cm4SoRH3XDv24JS5gOt7DxIAmDJIkiC55mVIYaiRaCkifa+1Icdvk+aZiJEDESnpS8IviYCwFAbY3N0zvypsZ/roNeJtPmTZQyjtknhyw3aslrFg11oX4D8iOr8WyaWHkc+gBLfzQU/GpfHFWYjwModmxFIpgI2XOWCTWWyDNKLUcLRzEWSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/TG6ppWcgZ/4Wmkx6GDrNJeDkUMh/a4b89T1VVon5A=;
 b=aoHsegU5AvglOB35OUDYiQUEYjM/6h+tPSM4AD1bRGqG4mngIZRKtMLBw7NKvyiNSLEXer21VQPCOlp/z+8kn8NSkXppjYYxNsi/kmW5cAZqaY8Z7esxdLRXe3NOBavj4/qGVwMVZS8Ad2Mjk8APAxi7qY4VuvdY8yVbvcs1PXQ=
Received: from PA7P264CA0150.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::9)
 by MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 14:43:13 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10a6:102:377:cafe::81) by PA7P264CA0150.outlook.office365.com
 (2603:10a6:102:377::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Mon, 25 Sep 2023 14:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 25 Sep 2023 14:43:11 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 09:43:10 -0500
Message-ID: <a16f180f-10fe-475b-abbd-fcd4f8be874c@amd.com>
Date: Mon, 25 Sep 2023 16:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] trace: Fix alignment logic in flyrecord header
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>
References: <691dad64df80993ca4cfb6d0e33964ed26f50bee.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
 <CAPnjgZ1hf68F3YKTp1p3ruTG2vhgg+F=rn3=2DTZCTTTWnQeUg@mail.gmail.com>
 <463b713f-97f2-492e-a87b-e71b6d2020ea@amd.com>
 <CAPnjgZ0OeLASkZM81NqcgpafBrt5Edv1y-MezPCx1utA0L_NZw@mail.gmail.com>
 <6360851b-aa4f-4ba3-b00b-2a69eeddd349@amd.com>
 <CAPnjgZ2fVYJ61HcAh_tv1VcWjiVvkqmnmda4-g13q6Sp+gQA4A@mail.gmail.com>
 <20230925142824.GY305624@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230925142824.GY305624@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebbb819-b114-421f-05a0-08dbbdd5be23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6mA9hMRCsiDjqIXp2pJErM0paTMsKURtN+LeoOCENfBxDOt8HqF4bb7v/BQk3G8zY9QiA9pACkOFU2NlnB15IF63SAbZ88sYx/Drm14g7IVKA0Vd0F/cCi0pm/vZoTF43Vlo5D6wHfAer3bYaLGXqEoJ7jT4HoKbUSZR3rnxyAb6E8n3mIWaitA3A5t/VaEMGjB2md88kv29ya9OQcHUiP+FZho1vV4gUvMJXAhRVBfpwHmQn/bfPIkcT4SnuXbnV/BRS0KtIR3vsekD6qtghnjVUyhdvjCQxOxO2vKKmySxp3Xj6ngPr0zAaW+cjuIJ9Su4/3SZWeVUqgL1ev2M5N2nBv11aLz1ppI/nnhnyayLSMbSN/0gK6YcYxKrssgWxOwNu2bvFD5QBJnC1PZ3KehTiBZT+DonBgodXn5/4wd2v/FwmG/W10+dLiyL+WwkQYNkCXYoUDDkJamwhiaHTOnYdUj1OXPQCu7Vo1hRQewzAtN0l6tryDwfylttq4dfthTlucuNooEPahKDM2rOtcfXVnnvBXrA98fZHcp6q6oTbCm7EZ2V6de0QlE+shjc8c8qK7qq+V6283JC6fIlLnQQUYIkyht1FKYElgCL7i16vzCtFvxkQECI2uDGjTcSEXxT3x/8dwohkcIx7a3X+p2cv5oEMLQsIxI7n8Mzc+6wk32W0supRd99fm+P+vXSRToka9sP9urGcA6LU8t3KsMJG74POlx52SsAXRBsqD5QWqfTBOTVfLZmcF6G8Jy+Xc63ItU3J44ouiAOzfiY4P3eGQurIYXay2aKtg81Fs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(36756003)(31686004)(83380400001)(40480700001)(40460700003)(86362001)(4326008)(8676002)(5660300002)(16526019)(31696002)(336012)(41300700001)(8936002)(44832011)(2616005)(53546011)(82740400003)(966005)(26005)(426003)(107886003)(356005)(47076005)(36860700001)(81166007)(70586007)(16576012)(2906002)(316002)(70206006)(54906003)(478600001)(110136005)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:43:11.8082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebbb819-b114-421f-05a0-08dbbdd5be23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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



On 9/25/23 16:28, Tom Rini wrote:
> On Mon, Sep 25, 2023 at 08:01:41AM -0600, Simon Glass wrote:
>> Hi Michal,
>>
>> On Mon, 25 Sept 2023 at 07:38, Michal Simek <michal.simek@amd.com> wrote:
>>>
>>>
>>>
>>> On 9/25/23 15:10, Simon Glass wrote:
>>>> Hi Michal,
>>>>
>>>> On Mon, 25 Sept 2023 at 00:06, Michal Simek <michal.simek@amd.com> wrote:
>>>>>
>>>>> Hi Simon,
>>>>>
>>>>>
>>>>> On 9/23/23 20:13, Simon Glass wrote:
>>>>>> Current alignment which is using 16 bytes is not correct in connection to
>>>>>> trace_clocks description and it's length.
>>>>>> That's why use start_addr variable and record proper size based on used
>>>>>> entries.
>>>>>>
>>>>>> Fixes: be16fc81b2ed ("trace: Update proftool to use new binary format").
>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - s/start_addr/start_ofs/g'
>>>>>>
>>>>>>     tools/proftool.c | 31 +++++++++++++++++++++++++++++--
>>>>>>     1 file changed, 29 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> Applied to u-boot-dm, thanks!
>>>>>
>>>>> FYI: I have merged it to my tree and already sent pull request to Tom.
>>>>> Without it I couldn't pass CI loop to get all reviewed features in.
>>>>>
>>>>> https://lore.kernel.org/all/ab72c480-e9f8-416e-adf5-726f7d40c4f5@amd.com/
>>>>
>>>> Ah OK, well that's fine. It was in my patchwork queue still, which
>>>> suggests that the patches were not set to 'applied'?
>>>
>>> I am not using patchwork. But I expect my reply to cover letter was recorded there.
>>
>> Probably. If you reply to each patch, it shows up in the patch, but
>> the cover letter is hidden somewhere else.
> 
> Patchwork doesn't, but b4 does, handle tags sent to the cover letter
> rather than individually.

For tags yes it works nicely with b4. Pretty much just reply to cover letter and 
b4 copy it to all patches.
But this was more about that you can't see my Applied reply there.
I don't think that b4 will be able to catch it but I would love to be wrong.

M
