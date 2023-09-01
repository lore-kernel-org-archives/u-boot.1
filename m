Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72024CA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 11:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D74686453;
	Fri,  1 Sep 2023 13:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4LCWJv8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737AF8687F; Fri,  1 Sep 2023 13:17:25 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F9E8074B
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 13:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8VAxsCdgocARg9TEzgRTxsHgWVnbX3tqvunEcU0PaU313xH6MmtFBtEb46+QC10FEr0vTbfHI4yvc+rzrkk9fIcUlrji7x+cMjDoA2WdnxeyVtspMDhCCrt4z8lg0TXmRBaeI4b078clkNYbT9haCJ9L97PFYySlZijey3MAV/HYwvLy/IK20TT9WAoV8BOPbAOpuIX/gJiDjNOvYzXc6+S5S8GXThCSVgh+Py7L2IxHe9wYRrAvvRSfeIMYmYK6J9fzLhD3BeL7IMi19wJq2GtVi87OGlfCpbUGqhp7PxxLxMdoqK/DilT57xalEFZGcMo0V/I0W8SfMcIjvjPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ubepg9qbVYo/WbK6pD8YzlgSoDP68JX3b7HC0JBynD4=;
 b=l9Ftz+uUqsdAgStp6MFjSsreQsCl53+eu9+XoNOjeYU3B8ABC82EnUKp2ImF1dqbCPtH/xdTZ75GSm5lmnqZeB61VItBv6HOtETE6bEa6k9WRhxqkJOwIZfW24m1MOlY/Tf2Atn1WvzSJ/uCwXuTV1LkfIwjTiA5VWs0B3PcaAKz+M5VAvoygXrhWrCB6/V4VenZeZzd57wOSjiFuvJ2sCj9+QhkU37A4qWFpNItFNl0I57zmwPN5TfCR7c/dZa1yNDfk6MhHQLpTyNMyASNOG2jwc5qMGRNxJloHKmhQUL/YIdzd4A+HXe/deYzFlxGWBRlHvGI8vcKO3ZacqfDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=steffen.cc smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ubepg9qbVYo/WbK6pD8YzlgSoDP68JX3b7HC0JBynD4=;
 b=4LCWJv8NZWSGAeNu0pHu+54clkK//R53OPi3gqO+1Cp+q6Q3Rm+4RPITYUQOX5JR8edofC7M4a5pK2xeErudEE6vHiqHL9B5n1XqTB7EcCxjREvDxZFlYpX8MT/NAPROmQzWDUWjVeQZUDeu81xq11I2iuBdhisW/GhIV1joGpA=
Received: from MW4PR03CA0014.namprd03.prod.outlook.com (2603:10b6:303:8f::19)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Fri, 1 Sep
 2023 11:17:16 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::d9) by MW4PR03CA0014.outlook.office365.com
 (2603:10b6:303:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.25 via Frontend
 Transport; Fri, 1 Sep 2023 11:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.2 via Frontend Transport; Fri, 1 Sep 2023 11:17:15 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 06:17:07 -0500
Message-ID: <b7172191-ed03-e585-a2c0-bbebe3b7c6af@amd.com>
Date: Fri, 1 Sep 2023 13:16:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Steffen Dirkwinkel <lists@steffen.cc>, <u-boot@lists.denx.de>
CC: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
References: <20230830140349.10801-1-lists@steffen.cc>
 <20230830140349.10801-5-lists@steffen.cc>
 <ec8f243c-0084-b512-fe72-551e959e9103@amd.com>
 <4c458e6a-05e7-489c-ba3d-8d139024ddb1@steffen.cc>
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 4/5] xilinx: zynqmp: add Beckhoff CX8200
In-Reply-To: <4c458e6a-05e7-489c-ba3d-8d139024ddb1@steffen.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: f77164e0-6476-44df-74d0-08dbaadcff81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7p4+6wjbhP1ClyTKMpA20CySP2TddH/q8Lcw78ea4V6jRCf5Bh6Bct5RygCVbxG9yJkHTOoFaBGgwyJl5E5XeMlXEaZui7GZkaHQPRQ2+N9NdihSGt+qG4AFZIXOJWxgb+iGPwO+D+ARQUXF+TflWXhwg2k7bDlmTA40bP2X9TEi8Myns77M0mbP/4ximhyfH1hmdMTLWDEm/UT1IFuBKHqxeA58DYqAadde6SeaLrEXSMuIhZgkcPfMwpwGKrEnCQU0a5ZW9sdMLF7hWuH6WI565FbPczpXfoW5oUBZS3wZt83w1y16eaLkRvg5XhjtDEyUiPsvZmzmGNnrgCXOSW4l2oS/+cE7ZpoGKqeM1KxhnmDCDrgblu9J3paBy5E+h/K8j6u3+xbsAxukO+mQ8EUqt9t4/HnGYND759MoYKmqWoJN3Zs5X7YMEUmw3bG7J4HbbSuw7tfW63WJTGH45lRZQhdiikWkZ7VTjE2TdV2dLer+tuzVAotaEiCLz8DUMsbAMGIA20gipu7aBdYaGpiryHxpmrSTpiNXnsmSXPAnNzp4TGFbAyi8oboe4LyQCs0bvqHxG5uPCQf9s1afAQVHTKM6kT6wQbWxrSvKFc7qE+bohsoualIg/CpA3RqnUrJxQSqOnUNZu1X6m1DF2w0s0YUTV0DxnDjxE1c5ivMyBDxtYgwuPDYOlqk5yMrRN0szyOdjJXd452rliY/SnIG5HB3Ylkks+BtuFpqnj/CKSGKy3MUn9+vl2h48sVy1CpdnWDpb4OgcYpTpZ4cuHmxsKOnrAdMvk9KeAxCSuuQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(82740400003)(356005)(316002)(16576012)(70586007)(70206006)(110136005)(966005)(81166007)(2906002)(41300700001)(8936002)(86362001)(44832011)(31696002)(5660300002)(4326008)(8676002)(83380400001)(47076005)(36860700001)(2616005)(6666004)(53546011)(426003)(26005)(16526019)(336012)(36756003)(478600001)(31686004)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 11:17:15.7852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77164e0-6476-44df-74d0-08dbaadcff81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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



On 9/1/23 11:00, Steffen Dirkwinkel wrote:
> 
> 
> Am 01.09.23 um 09:36 schrieb Michal Simek:
>>
>>
>> On 8/30/23 16:03, Steffen Dirkwinkel wrote:
>>> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>>
>>> This adds support for the Beckhoff CX8200 series of industrial embedded PCs.
>>> There is some information about the device and features here:
>>> https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm-cortex-a53/
>>>
>>> Currently supported/tested:
>>> - Boot from microSD
>>> - Ethernet
>>> - USB
>>> - rtc / rtc eeprom
>>> - tpm access
>>> - uart
>>>
>>> Open points:
>>> - adding the psgtr usb phy doesn't work in linux (failed to get pll
>>>    lock)
>>> - fpga loading currently only as u-boot script or pre launch cmd (type
>>>    may be stored in eeprom of rtc so this could be made generic)
>>>
>>> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
>>> ---
>>>
>>>   arch/arm/dts/Makefile                         |    1 +
>>>   arch/arm/dts/zynqmp-beckhoff-cx8200.dts       |  247 +++
>>>   .../zynqmp-beckhoff-cx8200/psu_init_gpl.c     | 1960 +++++++++++++++++
>>>   configs/xilinx_zynqmp_virt_defconfig          |    2 +-
>>>   4 files changed, 2209 insertions(+), 1 deletion(-)
>>>   create mode 100644 arch/arm/dts/zynqmp-beckhoff-cx8200.dts
>>>   create mode 100644 board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/psu_init_gpl.c
>>
>> First of all xilinx folder is not the right location because Xilinx/AMD is not 
>> manufacturer of this board.
> 
> Yeah, sorry. I saw the avnet board and copied that.
> 
>>
>> Second I am normally pushing back on adding these custom boards because it 
>> just increase time for maintaining.
>> Your last commit was in 2019 but at least you have some commits that I can 
>> trust that you would maintain your board for some time.
> 
> Our last board [1] only had linux/u-boot support as an afterthought. Customers 
> had to buy a special option to set the right boot fuses, so most devices don’t 
> boot u-boot.
> With this board and a second similar zynqmp board (CX9240 [2]) we’ll have u-boot 
> as default (and probably only) bootloader, so we’ll be
> more active. We can also set two of us as maintainers and it would be fine to 
> drop the boards if nobody responds.
> We generally support these industrial boards for long time frames and would like 
> to stay close to mainline instead of maintaining forks.
> 
> The alternative would be to have a downstream u-boot repository on github or 
> somewhere. We’ll still likely have something there for build scripts / firmware 
> builds / integration, but don’t plan to really diverge from upstream u-boot.
> 
> The main advantage of being in upstream u-boot would be that we can trigger 
> internal CI on upstream changes. We can still do that and apply patches, but 
> even simple patches like adding files to a makefile may fail to apply and will 
> need fixing.
> 
> 
>>
>> My biggest question is in what category is your board unique that it should be 
>> added it to the tree?
> 
> Currently the board isn’t really unique. I guess we’d be the only users of the 
> rtc with eeprom and there might be something needed for loading the correct fpga 
> file based on eeprom (this might be done in linux / userspace or even u-boot 
> script though)
> 
> [1] 
> https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9020-arm-cortex-a8/cx9020.html#tab_productdetails_1
> [2] 
> https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9240-arm-cortex-a53/cx9240.html

Regarding board itself.
It is DTB - we use OF_SEPARATE/OF_BOARD it means building is easy. I expect you 
have pretty much something in PL that's why your DT is bigger if you don't use 
DT overlays but for fixed design there is actually no reason to use it.

psu_init_gpl. You are adding it to specific folder which match DEVICE_TREE 
variable when you use it. You can actually just copy it to board/xilinx/zynqmp/ 
folder and it will be pick up for your build.

xilinx_zynqmp_virt_defconfig - you likely don't want to use this in your product 
because there are things enabled which you don't use on your board. That's why 
you should tune it for your usage.

regs.init - that's for boot.bin generation with SPL - BOOT_INIT_FILE should be 
used and it can't be wired via generic defconfig anyway.

That pretty much leads to the state that make no sense for you to use 
xilinx_zynqmp_virt_defconfig.

I think we are still supporting defconfig fragments which is the way how to 
maintain your board to be close to mainline as possible.

And fdt_addr change. I think this is for me the most problematic part which 
should be solved. Pretty much all these variables should be moved out and that's 
what we started to work on. But it will take some time to get there.

Definitely there shouldn't be a problem to merge that rtc driver and I would 
prefer if you can stay with your board out of upstream and try to maintain it 
via your build scripts only. And let me know if we can improve/fix something to 
be able to do it in long term. But pretty much all things should be in place 
already to do it without pain. At least I would like you to try it and see if 
there is any major blocker which we can try to fix.

Thanks,
Michal

