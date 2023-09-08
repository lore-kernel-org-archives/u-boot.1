Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6379EE57D8
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 07:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 422B6862B6;
	Fri,  8 Sep 2023 09:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NNNn1pDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 402228648D; Fri,  8 Sep 2023 09:11:57 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E45786470
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 09:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhTqhJaf2n2TyYoHCwhpm/y/m1JnV8+j1E3+8tdeL5EMoJ5rM5kBAEsSnfEO1fB55IqLDMmfZN+wvxQh5bAZH+IHf8aV9BwnumZ1RUlQWQR5Gcxgo10dQ7XycJ/whI9OXnbBL/ylHbyWoOwm+aK2bm6Nc78bghjJ+JoOiXyTARM6YRf3M/zT8CPwQZJ70QQgSoYNGixUiP3sG8nPkJjUf9idg1EagIbE3/AqmRG3cXmBqn9vqfUUASmaQGFz+JVO+Lv5OjWLgOi7yLVpfoLFCyK/utNMgmIWSPO3rp5Cnl+ClDyU20nQs+77jRqOkZo+GgTLKvIliPSBXnNqrFjTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gh/faTS1/ZLCR0s/o5d4B+Cqo5ODsv0H4HSb80cVc7s=;
 b=DlPet6mTYaHxxvefjMI/LOuIda4mlM8ksE53L0wo6R0DQ82GDu+Ret7Istu6qpvx3GEywllmvWyr4Cc6mf7O7j/jEJK/RGDFmgNFec7LhD0QWA4KyGshtfaAXqRS9iYkqlKNwM6pGfGOxiJfx31PTyHT0zjLiCRIIFY3n8BkoQtp/vVEOD8omG3yrqgn19Ppy29hE2xH+k5d1rzHiRk0v9h4rEDiOKV7BeJiWdpNTFTG081pHGFDXnBOHwGp2RsCUH8tII1SxKJfj1tOQ+V9wRzWd5X9yvkf6tVqRjJjCKDoAFmtw/yfo+AWxNA0dlZH8g32JzyquGMJluYXrPyNbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gh/faTS1/ZLCR0s/o5d4B+Cqo5ODsv0H4HSb80cVc7s=;
 b=NNNn1pDYmsjjOSaDmi7Gts8T6EpP1IvYCClt/PZFfMKsm+ZpNdClv5vlgG3bkelfqanJ2YjfwnB4ibUgvtwWP5segzFzPAYIqOFGC/oMCC2bLdn5SaVKs1Wo7FkCWVu5o5cAxGdR0XCIXR8vnibnzIrxyeNGSX1NXPS0K5Hixjc=
Received: from DM5PR08CA0043.namprd08.prod.outlook.com (2603:10b6:4:60::32) by
 CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 07:11:51 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::ee) by DM5PR08CA0043.outlook.office365.com
 (2603:10b6:4:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Fri, 8 Sep 2023 07:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 07:11:50 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Sep
 2023 02:11:48 -0500
Message-ID: <4dac50e5-cceb-944c-1138-3f20f7076234@amd.com>
Date: Fri, 8 Sep 2023 09:11:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] global: Use proper project name U-Boot (next2)
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <git@xilinx.com>, Alexander Graf
 <agraf@csgraf.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Angelo
 Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>, Sean
 Anderson <sean.anderson@seco.com>
References: <044d9cffc3d8ed891b40d24c63ff74445cb3014b.1694091612.git.michal.simek@amd.com>
 <CAPnjgZ2ZKcpY5Z9SjgZyLNCXAs52T7OrQej6EyrA06oR=Vfbzw@mail.gmail.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <CAPnjgZ2ZKcpY5Z9SjgZyLNCXAs52T7OrQej6EyrA06oR=Vfbzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 51608a50-db49-400a-9c5f-08dbb03adf96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BqpvZhW+jR1EoJUqsfUPKPLnGGTMoqSAgSwPN/NKP/zhkm0sMbeVxNHi4+im4/aY7tDb5x4KOEIJK89G1EBLLecSmkzdRHgEO7TThEFMrgyOmA6RXjjas8+SeH9tU3g5tfLUr0Z4qrxhk+TIA8p2JCNXQ17SHq4IZ3Zf4fAWqB63f+DwGz/0nB/Z0dj+0X4jy4+0M0s4aRX+ZaxA7yGWMu4JsphP+gc5ZTl0JntD2V46uE/gO/je7rKBgrQbqocLx+2jkKsRKdsc0PJG3b0tmuLLw1jws1MLecxTqrqaGHO5XpqzEoKLTVfZsWTZ67coZtML0gD0cBdjuHDML2JcE0dQPV+JjIIwhy6qO5px9lunR1WWQUL8WG8yTJ3xyKZCZ7dyh1sSBD/ut+8eC/uAhRh07/LGOmOQv53oPsFF9+wXLogHvKg8zs7BKe93jYpzW6jRCBJE6P8ca8lXMEYgd1KxRBv9Ta/W4+m98EvBQFoqdVcpqM6WJ/mHNaqz7gtrxF0xX8CtM/ZiBccSGxWORpzQIZ/tL/86xse/zrGxhrslsKX6QzE9sX2CB/fUlYPnREh4aeMqgFefhWw84TVEuRt5/igMp90q4+MIUUYxZLcvypt2OM8zzlCXlcNu/0yxcznN+d+tvgGT2JnJpON1ztDsmQmX9LOvSyg2g7Ok+OGxKX15zOyo52qMIZxDsw7GMQGS8XI9+vDJvThPefeygx0CLD4KJCYcibvYTcfrdI3QPb+ZVVUxKUdKgQ5grE4RKAMdFn2+k3c5k3PqX4arbCR7O8oJYw8CZOgEtfYybO5uax7oeQioU1JrYdfWwqo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(53546011)(83380400001)(478600001)(2616005)(26005)(16526019)(426003)(336012)(2906002)(16576012)(44832011)(54906003)(41300700001)(316002)(6916009)(70586007)(8936002)(70206006)(5660300002)(4326008)(8676002)(31696002)(82740400003)(47076005)(40460700003)(36860700001)(36756003)(86362001)(40480700001)(356005)(81166007)(31686004)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 07:11:50.8213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51608a50-db49-400a-9c5f-08dbb03adf96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028
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



On 9/7/23 17:57, Simon Glass wrote:
> On Thu, 7 Sept 2023 at 07:00, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Use proper project name in README, rst and comment.
>> Done in connection to commit bb922ca3eb4b ("global: Use proper project name
>> U-Boot (next)").
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   board/cobra5272/README                      | 18 +++++++++---------
>>   board/emulation/qemu-ppce500/qemu-ppce500.c |  2 +-
>>   doc/board/xilinx/zynq.rst                   |  2 +-
>>   doc/board/xilinx/zynqmp-r5.rst              |  4 ++--
>>   doc/imx/mkimage/imximage.txt                |  2 +-
>>   doc/usage/environment.rst                   |  2 +-
>>   doc/usage/semihosting.rst                   |  2 +-
>>   tools/binman/entries.rst                    |  2 +-
>>   8 files changed, 17 insertions(+), 17 deletions(-)
> 
> [..]
> 
>> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
>> index e7dfe6b2a363..a8c7423c4005 100644
>> --- a/tools/binman/entries.rst
>> +++ b/tools/binman/entries.rst
>> @@ -2505,7 +2505,7 @@ Properties / Entry arguments:
>>   See Entry_u_boot_ucode for full details of the three entries involved in
>>   this process. This entry updates U-Boot with the offset and size of the
>>   microcode, to allow early x86 boot code to find it without doing anything
>> -complicated. Otherwise it is the same as the u-boot entry.
>> +complicated. Otherwise it is the same as the U-Boot entry.
> 
> This is actually correct already, since it is the name of an entry type.

Ok. Removed this in v2.

M
