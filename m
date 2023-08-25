Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F69C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD817869E1;
	Fri, 25 Aug 2023 09:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Npvu7vAe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5A88643A; Fri, 25 Aug 2023 09:33:31 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE1D8643A
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBj/l01w5AL0OjsaUb1P2xQL0Cv5s7VzuXJ/4qyeyqjC2MhBoJzaLEGW1DMZnoe5rS/q924HhS+v1C/J11jmw65M+RjWF5xR5YASElW8F0p+E9NRj9AA/nXqUiKVddKMzLOSGzfEOhxhf/Jv7wkFWM4mpRnac0whDrkOvo4eNKxxlfmYGY/KnWRrfDt6eRB+JyP5UGnOATHRsBkkYpWQ2uYH1AeZs6HVmUnu9uGsbD3DVw2N+QZiEVC8UsP5ajpxLG0v6t/ly0BiO2xTOb4vlWBGidI7VW24hqmsRA3Mej2KClMiOGnS6R2pR6zbkTi6LP1XscxDuTAUWnK0EZyTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GZ+BpMsq3M1AQB1AvJZc7LFX6D0g80F5CvYb9gwXv0=;
 b=GPSIKmTZXu0n0P4XV72+mPL+5rsIkvJv7zOBo54JbyOzwi9x6YF0UDBUUZ1mJBI39WdtW65rGDNVyzYwbUI8lY9Na5iFFyPRAhA7yS0PXvcdW01pvr9loxBWdlwPT9af5NU8WuPslHwDZpc3OubalWXVh2bGieH2ggKnBJfCoLjRQcPFaiMI1qDgRz7OqEyDwR4AhyNWoSe3FP0a1rjjoSaQGKGpg99L6CPLdFj1gxKnvJxUxYUqZKAos1PPlse2h8veuk5wviC1lAa5TWLvmj0+gdyqQtMqy907cqAnwbR02FPWRkMYnBdS2MvgK6zEBAvWdeoKse86PlXfWVcBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GZ+BpMsq3M1AQB1AvJZc7LFX6D0g80F5CvYb9gwXv0=;
 b=Npvu7vAej+yugZW9HxcuvSumMSSD+RtWnNpvGshEj6JOGG0j54YWL3iNTJ4LsCf0ZxKTt7VEkZq6+WFied5vjHFNSbWzcRLc/qK3cFXbrHklNIvquESJCN+qcgBbe5eSbM9RCKyuc6NOrAuNcazhv/EnODyk8Xdi/dqJEWnOimc=
Received: from MW4PR04CA0136.namprd04.prod.outlook.com (2603:10b6:303:84::21)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 07:33:24 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:84:cafe::da) by MW4PR04CA0136.outlook.office365.com
 (2603:10b6:303:84::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 07:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 07:33:23 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:33:21 -0500
Message-ID: <29fc2307-00f4-fa6a-f1af-b626d07a5172@amd.com>
Date: Fri, 25 Aug 2023 09:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [UBOOT PATCH] arm64: zynqmp: Enable the config CMD_KASLRSEED
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <git@xilinx.com>
References: <20230824032712.13399-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230824032712.13399-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccd5945-01ef-4f3c-f47c-08dba53d90a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5xUmd+kgyWtC5kv3ErkEWO4W9h+gYp9ngRg+gA6ng+Ycaw8K7LKSXNbnNhP4W//1DwuD3VHF5OQ3d8vXCasHB4DOWybSjcyArQCWDabVasbULwRfIP0E4ztocAmm+U+8LIYGqiQGpbhAmL7cVDGRNRXpXt+BjmMn6D+p7G7FhW2+jAZXZEwJHaoI6MMIwbBiJ4xBDLP5xTAtB4GH66bSM66rpiGx16rMwN8ztbMFmgXa+nc1Qj+1ydWZphxDyyHWXUo51FfpFF4pan+WxH0AAQqX1mfymhISCVx/c1ed4M2AE8xfSibqLQWo153jaEjmdSfGleuRc/nU9hyO/KBBN7umRSZ7Bt8wgjPTZhSr4VKBGdpYMKXBLzjjeTJqOgted4UKeDT381zEnHXvQI6+f+rh7YBFLW+WOC+mvg11J9N9BMRm2bH+AIJOFLZA5+t9SivNBp6G+ELylXxZV1t8CtBHgzjWC0jDDEGKZ4e7J+10yb2l2NHMQ/9zvcPRvtjnZ6B0JgGNw2YQFvLYfTP2jVFoM1I+ezm8bJJkze/JVA6vzFZSbuLyEuSGIKzrn/0YFUCLZ8BbfSe5Rym4wRj3duI059RZJ6nzDPw6G+6x+9XVEc8nPUmNDzdd40A5YPFxUCNdvfWJnwe8eU/mTa/qYFos1tl2+o2zIuR+4/LLqnpGFZXl/w1RuPeClnzgYGQafSIAfqBGgeTGbT4eMK+0swzasrVe7ddWN/Mk16OUtM8h8RkIuZsX0QO5XOQInVwq4x+p0yes7PhE7YETIDxF/c+g5DcEXFII47WjPkj3uIlbTgO8x3TO7x94JgboqCH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(336012)(36860700001)(44832011)(83380400001)(26005)(16526019)(478600001)(47076005)(40480700001)(2616005)(5660300002)(426003)(107886003)(31686004)(2906002)(8936002)(4326008)(8676002)(356005)(82740400003)(81166007)(40460700003)(110136005)(70206006)(70586007)(86362001)(16576012)(41300700001)(31696002)(53546011)(36756003)(316002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:33:23.9943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccd5945-01ef-4f3c-f47c-08dba53d90a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
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



On 8/24/23 05:27, Venkatesh Yadav Abbarapu wrote:
> Kernel Address Space Layout Randomization (KASLR) is a hardening
> feature that aims to make it more difficult to take advantage
> of known exploits in the kernel, by placing kernel data structures
> at a random address at each boot.The bootloader supports randomizing
> the virtual address at which the kernel image is loaded.
> The bootloader must provide entropy by passing a random u64 value
> in the /chosen/kaslr-seed device tree node.
> When we run "kaslrseed" command from U-Boot, the bootloader will
> genarate the kaslr-seed and update the /chosen/kaslr-seed DT property.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/xilinx_zynqmp_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index acab38fefe..b67b637e52 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -91,6 +91,7 @@ CONFIG_CMD_RTC=y
>   CONFIG_CMD_TIME=y
>   CONFIG_CMD_GETTIME=y
>   CONFIG_CMD_RNG=y
> +CONFIG_CMD_KASLRSEED=y
>   CONFIG_CMD_TIMER=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_SMC=y

Applied.
M
