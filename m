Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54706CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 06:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4778692B;
	Mon, 16 Oct 2023 08:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEI6tXGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCB9A8692B; Mon, 16 Oct 2023 08:25:20 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E38786B49
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 08:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yq9PS4VjA/Gk0csKsNSGJd7j5UQR1gW2SW+IS01GI2AULidHtAn2V4MU2Nv7cqOGcJd4hZnH5xrYFIpJ0QJDs/vr0w8h1BH4/IikHYbafYhBD/k4VOVODdMcXc4bSpLJ7EJpEI5HvE59SyyBLntwpgelGA5oUYxJOEstQ/+Wh/I12qoTI1leiQI9FffzmQ/r52k0EfSLTDhODfSrtXygrZxKAB+N35tsSsDyZzrZkGUu6SnNsaq3GeBcOvREgeQoE3wKiBL04dRLaUzg5IKf4lL0u7Ibp9Ac2y4zPdBHYiXK8+51C8zNyLDO7EAskDcXUg6vWerhWF2tyhhCiI0e0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CppqI0woyKVFyawXXWiVKZdgcinPxJVz44eIHyaDtE=;
 b=PhahVu97+DZI0xCEJlkzXqOQ36vw8q8+Wry3poGXDI9ydNPTssAtQ848Z/v3fnIu2JRZmjwBzPsv/K4Z8vkKt39OHHyHtippt3NU95trBvOQrFBF7br/xsEuBPcvc6V4DK1lvMlMqkNcsO3XNFeE/hhdW4ngF8RvpPRVmyop7H7S1dmx9nc0asYC3ICu+XN+0C1iej1hlPhaFT/uAUxY8KfjtIk5W3CX0YyrZXlPONmIst6PpDJqgBH3o1bhAfg73rX2sqlfHsTis/LIxc+6ihpIC1QCh+QYfiZgmFaGMuW+hTQFo7XQqx75Lqb2YhwM56fP1MphPVOzYtIFYBQUrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CppqI0woyKVFyawXXWiVKZdgcinPxJVz44eIHyaDtE=;
 b=BEI6tXGo1wc9vzZaYaHvMZJaaH7jMd5xlTVSsdSrEKe8VWhuSGXGrlDSa3p4gXOGwpTxSwMUo25Tfvs0NIw0XUiqmO62K3GK6PmRnGQYCGMXHS8D91HaE3InZzmzM73ji/UTI3QWXut4Nurh+jaO/VxQIcazv6gVMxp09LTU6Io=
Received: from MN2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:208:134::38)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 06:25:12 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:134:cafe::7a) by MN2PR16CA0025.outlook.office365.com
 (2603:10b6:208:134::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 16 Oct 2023 06:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 06:25:12 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 01:25:07 -0500
Message-ID: <c3dfae22-94a0-4d64-9175-dde259c421ef@amd.com>
Date: Mon, 16 Oct 2023 08:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] Add EFI HTTP boot support
To: Masahisa Kojima <masahisa.kojima@linaro.org>, <u-boot@lists.denx.de>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Takahiro
 Akashi <takahiro.akashi@linaro.org>
References: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
 <CADQ0-X-=4q7dCeny2F_J6DqY9bVxQ01p-zLyu4rnwVXmE=iiEA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADQ0-X-=4q7dCeny2F_J6DqY9bVxQ01p-zLyu4rnwVXmE=iiEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ded4867-02d3-4454-2516-08dbce10a71c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WVcYil/A900TdkUjoy/J2h2JcgMLkYFTp9lJH2Yps5MDB/rgYs2ztNd31K/ZkMoQa3OKzZuWDcqUL46Zy6pZtcBtxCR+AS/UZT1dGHhiuBcvR+FtaVuSvOHjBqeWr/JHe0FOHBgB1Iv1mDkMusjN5KNcOcQWRlqws4XkKi/8hYeqSCwytm1sJ+C/qdvhvKv2QuraEKRaEoWcQ8JPQ1H/a6SWIxfJ/4a0VP8AKPCvmElWZJrtdVDAgwjp63E0G6RGdy0JuOJ/XBbEEgzck/AJA6ZffVrVXtVjONzOjVj4r19mU6u3jlimxpaFuZ7zxINYjS8YpftTT1i5Iqof8t9llmRFpbrF+6HJClQ51yrXKI3Ah/vojXYLakNoeq5gTUjB2ftzbplZHnkZNl48dTOQAF/jlIL/xY+AiZ+fnUfG19KDW+5RM9sRszk0Q9NAfiD0y5bVFqBLMbx3H9it1qCVutu9oXLHMFUqP/2DE9H+ewSSfAlk3s5/q+WdcbLHIeVzDqGwctC8hOxLWSV0R5BN7Jq+uNXQkahWAH2dC2pXqit8zJpvNmG4HdIoZBvUWJhFvLAuFjl5X5NCxeJVcE0PyHsN+Op6IU9Q9HXTxMJvPoojBA7WTm8Tl9OmHgzaskv2T13oUU5+mYtj3FLPsFq10mK3bRWO54p7f2YHrSqeFyZQELIZljGYK78eGyaNm9HhSNwdWrM2AM7FZVPdSuuEH0v0dpyw/EaC8bMhsXWehGN18hLUxIb/5Q5py7qF0RMEp3z5Gmlf50yFRMHdURF1PTzOXgbX9kQEgfMO0UzjagVeX5DePVE5uWK2g7JJ031b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(6019001)(4636009)(346002)(39860400002)(136003)(396003)(376002)(269900001)(230922051799003)(1800799009)(82310400011)(64100799003)(451199024)(186009)(36840700001)(46966006)(40480700001)(82740400003)(26005)(16526019)(336012)(426003)(81166007)(2616005)(356005)(478600001)(966005)(44832011)(5660300002)(8676002)(8936002)(4326008)(86362001)(31696002)(2906002)(316002)(16576012)(54906003)(36756003)(41300700001)(70586007)(70206006)(110136005)(6666004)(53546011)(47076005)(31686004)(36860700001)(83380400001)(43740500002)(36900700001)(10721665004)(344275003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 06:25:12.1026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ded4867-02d3-4454-2516-08dbce10a71c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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



On 10/16/23 04:39, Masahisa Kojima wrote:
> On Mon, 16 Oct 2023 at 08:50, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
>>
>> This series adds the EFI HTTP boot support.
>> User can add the URI device path with "efidebug boot add" command.
>> efibootmgr handles the URI device path, download the
>> specified file using wget, mount the downloaded image with
>> blkmap, then boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI)
>> by selecting automatically created boot option when the new disk is
>> detected.
>>
>> This version still does not include the test.
>>
>> To enable EFI HTTP boot, we need to enable the following Kconfig options.
>>   CONFIG_CMD_DNS
>>   CONFIG_CMD_WGET
>>   CONFIG_BLKMAP
>>   CONFIG_EFI_HTTP_BOOT
>>
>> On the Socionext Developerbox, enter the following commands then
>> debian installer is downloaded into "loadaddr" and installer
>> automatically starts.
>>   => dhcp
>>   => setenv serverip 192.168.1.1
>>   => efidebug boot add -u 3 debian-netinst http://ftp.riken.jp/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
>>   => efidebug boot order 3
>>   => bootefi bootmgr
>>
>> Note that this debian installer can not proceed the installation
>> bacause RAM disk of installer image is not recogniged by the kernel.
>> I'm still investigating this issue, but drivers/nvdimm/of_pmem.c in linux
>> will be one of the solution to recognize RAM disk from kernel.
>> (In EDK2, the equivalent solution is called ACPI NFIT.)
>>
>> On QEMU, I can not make DNS work from the QEMU guest.
>> The following commands work on qemu_arm64(manually set the http server ip in URI).
>>    => dhcp
>>    => setenv gatewayip 10.0.2.2
>>    => setenv httpserverip 134.160.38.1
>>    => efidebug boot add -u 3 debian-netinst http://134.160.38.1/Linux/debian/debian-cd/12.1.0/arm64/iso-cd/debian-12.1.0-arm64-netinst.iso
>>    => efidebug boot order 3
>>    => bootefi bootmgr
>>
>> [TODO]
>> - add test
>> - stricter wget uri check
>> - omit the dns process if the given uri has ip address
>>     -> this will be supported when the lwip migration completes
>> - uri device path support in eficonfig
>>
>> [change log]
>> v5 -> v6
>> - add patch #4 "Boot var automatic management for removable medias"
>> - boot from automatically created boot option
>>    rather than searching default file on the fly
>> - introduce new CONFIG_EFI_HTTP_BOOT Kconfig option
>> - comment in one place
>> - use log_err() rather than printf()
>> - use env_get_hex("filesize", 0) instead of return value of net_loop()
>> - use more suitable error code
>> - blkmap can be build for SPL/TPL
>> - add CDROM short-form device path support
> 
> Sorry but I forgot to include the necessary changes.
> I will resend this series soon.

Which pretty much means that that next series is v7. If not you will confuse 
tools like b4.

Thanks,
Michal

