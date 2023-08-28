Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1C1C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 11:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C4986422;
	Mon, 28 Aug 2023 13:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ldpNPamr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C352486423; Mon, 28 Aug 2023 13:30:55 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B987286421
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 13:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cotuyb/YlfPgGx+EbjM06Efq5vplyY4wBY/NmjCXvIjWMkVGJbK5BNXo8ag8emqxYIWEsAc3HnxEPqjy4+rdyCH6I/NwfsJvnc7/e/mM/D1+4s8MD0ITVs3oNt9RVm2xNGjbLgyMK/JSW+uAF6KOv+MQmDKTMv8Lldph8q3g/B6gr2kEJAESxIfG7aA5TMQ9SE8yt2pp9epmy7SQCOh16TVjVybMGSNR/lEKb/bfoWqB41V38cI+Jc9h8x8G6eL/GvdL+J2E4lqlCCBd9SFPd00wGSx1hwhuxM4ywYz34MR82Iyfuc8BZQVIXA/dRKNxUOm97ug3DiHmsPKEHylfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whNfuHZUU6fKOMJr/TAbWSQZd+s2tDwC/l6HiiUnTTs=;
 b=E/n4DZFQSQOj8Nw6TBZVpjwlK6Smg7DVbGOtRwErtNTOLF1shO8HJtO1DIA4Lyh7FCTm4kqpPfH+yYllFF09Pj5iCf5Y+wqJ40yHFpKmjD3ucDP2kn5prCGcooF6zuksfEL1vwnaz7ExYnO3KJTbQJtQF5gdADpT8SmGJ/9+BSM6ZivXicmZXPm1AQQuYZmFVOrlQ27oGUcFCFmO0v8CwY7bhIF+NBD9KnbXm02OqsrDZJCkCxKXPsTM4YZ7ceX/D/h8wG5dBPI1BgrZTtBYGMY7zlvW7VIZYlcMaC2nmu0hGLKION6mDVe6Ex03VM68HzTNC26dzJIW+7kfYUAxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whNfuHZUU6fKOMJr/TAbWSQZd+s2tDwC/l6HiiUnTTs=;
 b=ldpNPamrevqL0g9NrLzItZQ2yqBLNpI6s3853E2txezRtZ3hniN6Ay6HeHFvOgyLVSOrB/RQsMr9OsWDOWVHwjX6TWCbnGgq/kI1vcIubOPsw+fuxIXCERqzKYV0LBnPeijAS3SsZ129AXMdN+GpPzKj9WhU1vdtYS4qn6OhoTw=
Received: from MW4PR04CA0268.namprd04.prod.outlook.com (2603:10b6:303:88::33)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 11:30:48 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::7d) by MW4PR04CA0268.outlook.office365.com
 (2603:10b6:303:88::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34 via Frontend
 Transport; Mon, 28 Aug 2023 11:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Mon, 28 Aug 2023 11:30:46 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 06:30:44 -0500
Message-ID: <41558631-37bb-f6c7-c9ac-5ee8ad3a3dd2@amd.com>
Date: Mon, 28 Aug 2023 13:30:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/7] spi-nor: Add parallel and stacked memories support
Content-Language: en-US
To: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <sjg@chromium.org>,
 <git@amd.com>
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|BL1PR12MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 2acfa0ea-a590-4515-aab4-08dba7ba3925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/2nCbaaEPI0VY0IjwfeycLkP/3zv4VPtrWvQXLX/L6HCWvG5TNECeVt8pFy6GJ4zREskYnN6YavBks92MMOyxYWzZh9hgR8AAkG4kWM4y+gKh2D7JYiTI644B32HDCqPhWqF0WO/wunZSstIoo0SeuY6dVZZb7VdH5G30soq+wWofBQoXh5BCLeN8DRQZovvtT2FnDvezfECPGSAWkCg2a/j4tVOB0IXE6vMidSFPt7tAe4JY9V9K1JyZqtYQZKFtebowU+nkMpK8APKeCnpLA5QzLFdu7StnuxPf4hJB/7vsL8mf39Lv1Wd8N4knvmJRhOTVKEZ75soS0RSikOamnmj8vCngeDHiPoUVvqJdRS3zUysNDE09XvBi4fNUexVsSqYGM5d2wwyJM1HL6f6LH6u6YBP2geWYIUzwyAyIJCflZTv63mgIbwn6Z68cueurAzFEi6SeiOhUNhUgcOL25d8RDhmJteezb+jLf6WYGLeyfaXvhwIYdgs8PfGBwX4+BfJSuxOg867Tjx3SKVnw4lENQYTmngXKo4bFxGSjKTvIPI4ipaLElS/lqCX5v9VKl8pfGjty2Hc+z75FLsgHCfxzE2F5VenZpIRWKKY8AWwVRSOCIE0F2m1MU/TXUpG3PTrRzwSXDxJiDVh+9i0NkEAKlVFicMM/loBuTqNntUGHvFEmEOoXEVDvGX/Bkj8IsqhUu9Y1IGYZt7OPHCVE3tZ69jBxjA3p5Ags20aeC5abeJ04P7JthHjaF3Cx6ojBll41JZvvit1hdE0wRhqitRbAaXpiHc+sksGJDZPL4QkNkzT/Aamk7cwyNwwyjj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(31686004)(36756003)(40460700003)(86362001)(31696002)(81166007)(356005)(40480700001)(36860700001)(47076005)(2616005)(336012)(2906002)(426003)(26005)(16526019)(53546011)(83380400001)(478600001)(110136005)(70586007)(70206006)(4326008)(8676002)(8936002)(5660300002)(44832011)(41300700001)(54906003)(16576012)(316002)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 11:30:46.6020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acfa0ea-a590-4515-aab4-08dba7ba3925
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
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



On 8/18/23 06:21, Ashok Reddy Soma wrote:
> This series adds support for Xilinx qspi parallel and stacked memeories.
> 
> In parallel mode, the current implementation assumes that a maximum of
> two flashes are connected. The QSPI controller splits the data evenly
> between both the flashes so, both the flashes that are connected in
> parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
> 
> In stacked mode the current implementation assumes that a maximum of two
> flashes are connected and both the flashes are of same make but can
> differ in sizes. So, except the sizes all other flash parameters of both
> the flashes are identical
> 
> Spi-nor will pass on the appropriate flash select flag to low level
> driver, and it will select pass all the data to that particular flash.
> 
> Write operation in parallel mode are performed in page size * 2 chunks as
> each write operation results in writing both the flashes. For doubling
> the address space each operation is performed at addr/2 flash offset,
> where addr is the address specified by the user.
> 
> Similarly for read and erase operations it will read from both flashes,
> so size and offset are divided by 2 and send to flash.
> 
> 
> 
> Ashok Reddy Soma (7):
>    dm: core: support reading a single indexed u64 value
>    mtd: spi-nor: Add parallel and stacked memories support
>    mtd: spi-nor: Add parallel memories support for read_sr and read_fsr
>    mtd: spi-nor: Add parallel and stacked memories support in read_bar
>      and write_bar
>    spi: spi-uclass: Read chipselect and restrict capabilities
>    spi: zynqmp_gqspi: Add parallel memories support in GQSPI driver
>    spi: zynq_qspi: Add parallel memories support in QSPI driver
> 
>   drivers/core/of_access.c       |  22 ++
>   drivers/core/ofnode.c          |  30 +++
>   drivers/mtd/spi/spi-nor-core.c | 385 ++++++++++++++++++++++++++++-----
>   drivers/spi/spi-uclass.c       |  21 +-
>   drivers/spi/xilinx_spi.c       |   4 +-
>   drivers/spi/zynq_qspi.c        | 145 +++++++++++--
>   drivers/spi/zynq_spi.c         |   6 +-
>   drivers/spi/zynqmp_gqspi.c     | 146 +++++++++++--
>   include/dm/of_access.h         |  19 ++
>   include/dm/ofnode.h            |  12 +
>   include/linux/mtd/spi-nor.h    |  13 ++
>   include/spi.h                  |  29 ++-
>   12 files changed, 737 insertions(+), 95 deletions(-)
> 

I put this to CI and I see a lot of issue that's why v2 is definitely required 
but would be good if someone can review it from high level point of view.

Thanks,
Michal
