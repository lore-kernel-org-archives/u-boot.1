Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99A4CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 07:37:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D44F86564;
	Fri,  1 Sep 2023 09:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f4yTeqEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A6886564; Fri,  1 Sep 2023 09:37:07 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F3E86776
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 09:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekzoAhhdv9Z4ddKMWqioNqOXL2Bh9yPDBeMlCqk0I47cbI3TGeL6NDM6Pu1nr27F2S9HCk7zSRKi0ApPCIL2ydAe9mxngP5OKfJ5poNRu+y1ZeYub5P5QJo4Z4FKTktiK3XATer7hFeMJvmn2/14zxHe1mUDAlimJRVaxfh4tzs5AdzCN7+AtKznvNQqJFJDvKqqXmAxlKf/jduyNKV9PsQ7s5vj3c5e+7jRoi3ffzKNDDh2rSgqVhTGc8cU2c5qmmmMInpUyYDa7rRHYOr+gqPmEq9XGrTrjDG3ZCLxerw0uePGMjx+k7SYGk8WIeGjxu3HLg9FybsRpmb6RDJZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BuhtPHIw2+HTk3wxUC37fnV68MPfJe/aSRxrIFOneM=;
 b=bQbaDQD5otOARTmV1k/lXXO2XwSgyRWjAZL7aS3quxKblFVC8KUl6lIeoR57NoMz/6DA3nWFLZryCTgoNCxXqYePyGf8EhaJ2JdSJU/2TNfOKSe69fqbXYadhRTfMgl0k4rx68MGI5DJMKocapm89gN2zLyElbHsBM6vwY0qaD79MRiWiCcGlZ6P6D1pjxQ9rlBl+o8Z8c0vA7d8YOdDx1dKUKMZiVBCCs3RcwqoU7FW+uim23sSDEbhP33ZqKymkGTwBvqGasR1Ro7f9MGw1kNQ4KzfLVim011wGpMMcMwyFz3f7p8p+JE964nBgngMgmjiNUGbDzC5N4BCGKH85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=steffen.cc smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BuhtPHIw2+HTk3wxUC37fnV68MPfJe/aSRxrIFOneM=;
 b=f4yTeqEgnluCtTFl98ML6GmEGbsLcTLnK74ikZW4oLrLH50wLWId4FFAr6VJVW6sZEpSSS/DBJMwvXQuZm5HXRVEj1f+0OO2iJTGaESETQthGNyS3JOZmmKHfXpnwcNRG0nXgcUXaMYX5AO5lyd7stJYccPlBLQdkPNuFh4TQhY=
Received: from MW4PR03CA0061.namprd03.prod.outlook.com (2603:10b6:303:b6::6)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 07:36:58 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:b6:cafe::fc) by MW4PR03CA0061.outlook.office365.com
 (2603:10b6:303:b6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22 via Frontend
 Transport; Fri, 1 Sep 2023 07:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.2 via Frontend Transport; Fri, 1 Sep 2023 07:36:57 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 02:36:54 -0500
Message-ID: <ec8f243c-0084-b512-fe72-551e959e9103@amd.com>
Date: Fri, 1 Sep 2023 09:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Steffen Dirkwinkel <lists@steffen.cc>, <u-boot@lists.denx.de>
CC: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
References: <20230830140349.10801-1-lists@steffen.cc>
 <20230830140349.10801-5-lists@steffen.cc>
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 4/5] xilinx: zynqmp: add Beckhoff CX8200
In-Reply-To: <20230830140349.10801-5-lists@steffen.cc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: fda4cd06-d0d5-428d-0d0d-08dbaabe38ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QySTWIM+Fxky4GuPud05WHZ/hDoYYExmnHYReg7GxkFcMaoZAJJyFaRzC30SpyFfvXmmsmEua6AVtMVnbU0pI7JlLXQZV36gzv12jTYg/UxUhB59tRTCvqJ+ZsepE2hfOLBl0J4oURNZvx/hC//7TqGy5G8y+Dtpukeel2EqpDlh1rA+q5/Y84rM4/TcB6/14C7UtR4hTQBdy7VnT4w0VCEarg2hudu4n17c/1aW6JVeNhHrbmiqSYSULpsces6hQt2BOStczFfwEB+I5Kh2EBuX3Q3s0t9SdbhVFrZxt//VXkxlnD55yS9nGMFVxBkxoWcpTKT8KT9QHs/QffToIW9NA2OCwNOlIUkbtKx7KY+Ebdbyib+HPqnol2/vbu30SAt/qKIifdz8KofyidKmjnv+1EFdSGpIqql0uQ++RgFJKAyE0UuRidReDQXw5SS44vK7T/77nqIN5YhWebzKhTM6rPPavwuZyk7igMaswkgL6tYpZXGMqcIq6hL/jBtlBHIyUTnh1INTWvYhRGGvFU9XRGERP9WhaG4ZRSTL7hF5ykBxtI03em9YaN3cESeK5jdPG/oSNhmhCP5t0bhOZHB/ZOIsOKCld6/93Ycz3V3vsFNpV1bKiQfX8NYxu6EI7KaTcEwHWKmpMZ/Dbu01oMNAvxnGRZvo/kV18YWWZYBNcsNSKLKDXepLa3GNGG49JkEi0bIBiHH13dnWu0HcKjW55C0x9SgD2gIkU1BHfWqAcWeiMc6IZmI6rB+c3fWpyrLZx8O6Yq5J7yBJUQMiBHbPUT3vbXQfonOedrBTOC0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(31686004)(356005)(40460700003)(36756003)(86362001)(81166007)(36860700001)(40480700001)(47076005)(31696002)(2616005)(2906002)(426003)(336012)(26005)(16526019)(966005)(53546011)(83380400001)(478600001)(110136005)(8936002)(70586007)(70206006)(8676002)(4326008)(44832011)(5660300002)(41300700001)(16576012)(316002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 07:36:57.7127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda4cd06-d0d5-428d-0d0d-08dbaabe38ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364
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



On 8/30/23 16:03, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> This adds support for the Beckhoff CX8200 series of industrial embedded PCs.
> There is some information about the device and features here:
> https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm-cortex-a53/
> 
> Currently supported/tested:
> - Boot from microSD
> - Ethernet
> - USB
> - rtc / rtc eeprom
> - tpm access
> - uart
> 
> Open points:
> - adding the psgtr usb phy doesn't work in linux (failed to get pll
>    lock)
> - fpga loading currently only as u-boot script or pre launch cmd (type
>    may be stored in eeprom of rtc so this could be made generic)
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
> 
>   arch/arm/dts/Makefile                         |    1 +
>   arch/arm/dts/zynqmp-beckhoff-cx8200.dts       |  247 +++
>   .../zynqmp-beckhoff-cx8200/psu_init_gpl.c     | 1960 +++++++++++++++++
>   configs/xilinx_zynqmp_virt_defconfig          |    2 +-
>   4 files changed, 2209 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/zynqmp-beckhoff-cx8200.dts
>   create mode 100644 board/xilinx/zynqmp/zynqmp-beckhoff-cx8200/psu_init_gpl.c

First of all xilinx folder is not the right location because Xilinx/AMD is not 
manufacturer of this board.

Second I am normally pushing back on adding these custom boards because it just 
increase time for maintaining.
Your last commit was in 2019 but at least you have some commits that I can trust 
that you would maintain your board for some time.

My biggest question is in what category is your board unique that it should be 
added it to the tree?

Thanks,
Michal
