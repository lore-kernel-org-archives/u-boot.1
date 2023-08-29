Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDE8C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 07:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A6583F7F;
	Tue, 29 Aug 2023 09:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KOMa3mG4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1EC8056D; Tue, 29 Aug 2023 09:19:08 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA36864E1
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 09:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXdHOnL55r02dRJlgoPaDW7OZqTk6LzmEk+MgT72W/+7VjYRaRuOJSYjGdvEcvYyqAYvb0vNwcp/Cem7Z23Dt1MsRWAVPMV8yYILqNT7OlxnwMkJIF3gdubWLdAhkjI6YCOVEa3V76jPo8FymUCfJXUEs6KST6hiRMfhkNj0CUSjxEjErAyFLdl8atFXuHNWNvnnrq3Io6Z4wd86YTK7Xn/+VSM/e26dRAWgdgq5dSV6ER1oie3yaUP69HgCKZkwsTudlAYKStS6WSzxoUaQE5AuX1LjBeTiAQUDi9ZuZ4FgFf4jEfjrHhTH5asFqeR5d1WJziYZqcpRkE+FRutl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXzlovcYg9A06sS5/3MG+CHjBtpnpheO9CkmceLG5ZE=;
 b=fFfNA6Z9YosxpeMpMaRuYku8aUoLrD3XaV6AQCZTnDSCNEQuxNbxQjVJ6xzG1BtSBSyA9Nk7xJ/Co7LmwyxfieNflLswbche5Lre7n7Id/3pAEKic2FhoIrFEggy2z7XCoT3xbAtYRjWCOcU56u51SU1qq3PMn2Zl6BIT6nKrfTgNKaFcYD3C7i8z4/7//KR6zwbNSQcEpcPTLH66mKZbEDyTGoGEJQsiguWBd8DsIVuEw6KPssLP16r9oRKrCxVElXnSlW6W8pERfkn/0mJ4MyIgSKZAbX0Q7GRkdyVI2xtfeTv62M2VPYBWlAvz25k8/6fGeSGd+uoWBeR8GmOTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXzlovcYg9A06sS5/3MG+CHjBtpnpheO9CkmceLG5ZE=;
 b=KOMa3mG4IobWE52falUbhM3NXmPHZTuzft/eW61dCI9NevADWWYvWWFzHCU211T9mP8Vpiz2dejMA1SNc8vRVMZWtOdVlkRmaD1uBpGXLpx1n2xKHnzvzPcCBdKPLXJza1izqhFYWaqKOVmU5tvLoeA+HPYm6zv84K6+u8gxcQA=
Received: from PR0P264CA0085.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::25)
 by DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 07:19:00 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10a6:100:18:cafe::16) by PR0P264CA0085.outlook.office365.com
 (2603:10a6:100:18::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Tue, 29 Aug 2023 07:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 07:18:58 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 02:18:54 -0500
Message-ID: <572b8fb7-32c2-3364-a3dd-baee48b9330a@amd.com>
Date: Tue, 29 Aug 2023 09:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Tom Rini <trini@konsulko.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, <u-boot@lists.denx.de>,
 <lukma@denx.de>, <seanga2@gmail.com>, <git@amd.com>
References: <20230711095128.19086-1-ashok.reddy.soma@amd.com>
 <32e261a0-f4eb-04f4-f31a-33414a292146@amd.com>
 <20230825143959.GH3953269@bill-the-cat>
 <3d815d7d-a091-6f58-9d3d-c65e9eac8f41@amd.com>
 <20230828155009.GG3953269@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] clk: Dont return error when assigned-clocks is empty or
 missing
In-Reply-To: <20230828155009.GG3953269@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DM4PR12MB5312:EE_
X-MS-Office365-Filtering-Correlation-Id: d0fbecff-0193-4684-4c5a-08dba8603688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnwvMatovUmIcCbSp9EEFcPaisPzADz0KhT6STSpocKEGDLJmh0INjZ5ZfeNXxTKNb/A3mQX2M8eHBtTCGKcSdz2gRWWvtGfI/I153LMNTe0PbeQ5zFQOX5/KH06VAMaLmjhGqDsXo926ZW6PLi6tDMzEw1JtTtseF/ZfigoZYu16zxX41p21xH6acCLEESOw4QPtVFmokT3XmKN1Mjeek2V/ZkHeciiaDL+GfkC23vGLx1qTp97NTRAA59gjZPPJAJ5aG23TEPiaNzdk5T4AugidEDvzfkLrWkXop4W9vJV86/gH1dhB2lwDBsfPQMYo+YJml4fmiKF1cFp55SUWFrnFOFlx0CDdkNoYpWpe4pGbLgLtxcENhJ/jY+fxqdbamFD9hve0EYy6tp92UzoaqSWMEIblUDRA+BNNy4Y2JMlYwF8wsR7154GM1hkgWTno1fNwNOHDosqoAOvvw6CXCMTZ4m05E2FoAfop1KgXMeiItYaUN7DL4vXEMc/XdRq5YNGqDCWbpS6q6JxaKvg+tez3abkhhmtU33HzFl5hLRSNSxhATs3vaCQoqGOZYXeGRopoK+5v4jnjPxS1RUWSwMSUxvBB6xkwAShxWezwge0kA+c3OQr4dnFaRE1OaqN+1ZEPyoBZkqj8NVMSGUuR42DS4BTX/en5Rirw1EXRT2EtXVXJGP3vMV291cDOpxaYrYWjQBz6XUAbwUbt87Kkk9/A3w+jSY2P37v7cVDJii8ZwzJ5+A1y8tg8K1AxDPmvyyugVODK2jLWrih2a8mv2haBbEaB8udrcpf5KTWs4lvS37EDrEM5lhwfPuywH/D
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(356005)(81166007)(82740400003)(8936002)(53546011)(70206006)(70586007)(31686004)(478600001)(54906003)(966005)(6916009)(16576012)(316002)(41300700001)(40460700003)(36756003)(26005)(16526019)(44832011)(8676002)(5660300002)(83380400001)(31696002)(2906002)(2616005)(86362001)(47076005)(36860700001)(40480700001)(426003)(336012)(4326008)(192303002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 07:18:58.7661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fbecff-0193-4684-4c5a-08dba8603688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
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



On 8/28/23 17:50, Tom Rini wrote:
> On Mon, Aug 28, 2023 at 12:25:30PM +0200, Michal Simek wrote:
>>
>>
>> On 8/25/23 16:39, Tom Rini wrote:
>>> On Fri, Aug 25, 2023 at 09:15:09AM +0200, Michal Simek wrote:
>>>> Hi Tom,
>>>>
>>>> On 7/11/23 11:51, Ashok Reddy Soma wrote:
>>>>> There is a chance that assigned-clock-rates is given and assigned-clocks
>>>>> could be empty. Dont return error in that case, because the probe of the
>>>>> corresponding driver will not be called at all if this fails.
>>>>> Better to continue to look for it and return 0.
>>>>>
>>>>> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
>>>>> ---
>>>>>
>>>>>     drivers/clk/clk-uclass.c | 8 +++++++-
>>>>>     1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
>>>>> index dc3e9d6a26..f186fcbcdb 100644
>>>>> --- a/drivers/clk/clk-uclass.c
>>>>> +++ b/drivers/clk/clk-uclass.c
>>>>> @@ -329,7 +329,13 @@ static int clk_set_default_rates(struct udevice *dev,
>>>>>     			dev_dbg(dev,
>>>>>     				"could not get assigned clock %d (err = %d)\n",
>>>>>     				index, ret);
>>>>> -			continue;
>>>>> +			/* Skip if it is empty */
>>>>> +			if (ret == -ENOENT) {
>>>>> +				ret = 0;
>>>>> +				continue;
>>>>> +			}
>>>>> +
>>>>> +			return ret;
>>>>>     		}
>>>>>     		/* This is clk provider device trying to program itself
>>>>
>>>> What's your take on this one?  I didn't get reply from Sean.
>>>
>>> I guess, what's the validated upstream dts where this is the case?
>>>
>>
>> It was found by incorrect DT. It means I don't think there is any DT which
>> contains this issue.
>> But that being said we can extend current clock tests to cover this case.
>> Please look below.
> 
> Well, if the DT is invalid (and yes, we can't easily run the validation
> suite in U-Boot today), I'd rather go with a debug we can optimize out
> so that the next person with an invalid DT can more quickly find their
> problem and we don't work-around it instead.  Or am I missing something?

There is already dev_dbg print above. It means when user enable DEBUG it gets 
information about it.

The thing is that it just sync behavior with the linux kernel.
You can look at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-conf.c?h=v6.5#n90

There is also one more example like this.
	clk-test4 {
		compatible = "sandbox,clk-test";
		assigned-clock-rates = <654>, <321>;
		assigned-clocks = <&clk_sandbox 1>;
	};

But if you prefer to fail in all these cases I am also fine with it.

Thanks,
Michal
