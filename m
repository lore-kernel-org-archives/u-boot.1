Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4128CC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365BC86A3E;
	Fri, 25 Aug 2023 09:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VqNpyhQs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0729B86A53; Fri, 25 Aug 2023 09:16:25 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C65686A45
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYCSrrMkO5MtvQYz5g3j3wewZZExuvvlUlRJMVpBYM4fhYDMInlAPUIYRHvHXY9OFDKJG6vsOlfbXbhxQ0lN8qVkuRrViUFHEhE8K6aIK1Q5/bEgGFrsUFsaNNmv+yiFVr5EgukQbWfCd6uU/+w2oDPbBrkBSilflv4fln805AGn9Ai+VpDO8HBr9vweF0GgUufPAiAYIDLeZEA0LqbsK5q6PqnKgOqadtRP+FLtfIbU6HtrNEJ9JRPGpIYxszuV/XmpFg/tkNQk9olhICxitxPghATFnzvLE+isQpwjyMgM+yYhAW6ag70pxD/90xaO3dZwgvgIami5/NqwrO1Msw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsXcQLKPbrA0hrMm21/OG/clez4/JEqBy5XEEUXEoS0=;
 b=MZE2FaPQMODc1FOL0ZWJSD2zlFD9Y2tKbgua5R72HUOzw2CrkATJ8cPrMpjRVgWNY9JUuvjmePp27+43ss3q/zzGVSn81t3nNK/APhSyNJc/WzZixs2GHn7GeA5RXAER+GobbENdEUx96pBVKJSAKP1cPNAovsb/oKQOX934ssZMBDpuj/+TqZweL7V8f6356kkYAIPDCJGj5/CcVNaf4gTlr4nbiF0zRhzW0HYRd7FbhrzvjyLRitl8SHrvo0AHWfpYdkWNOk73n4MTttMApB7UZLXas8bywyg+Ca4qksagxTSe0wSzY1xt/OMF9SaFdeCq7FkjebMfSeuMyFBfuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsXcQLKPbrA0hrMm21/OG/clez4/JEqBy5XEEUXEoS0=;
 b=VqNpyhQs85hDaOKSlDmbVfZFlnhNqKHewtj/rTkaCQTPLPTiv6hbOOIqdRTGRAwJrvZvWzNDSLT/uLR2KO52capdoITAWinz2Gfq5Wi6ayzGE5DLGcibwZCYvTiTwvtq5wLgWEE5HNp/Hd44CSICnlppBD9j4Opa2wFTu5YjRxY=
Received: from CY5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:930:12::27)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 07:16:18 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::f4) by CY5PR17CA0060.outlook.office365.com
 (2603:10b6:930:12::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Fri, 25 Aug 2023 07:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 07:16:17 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:16:15 -0500
Message-ID: <d69dcfa2-9294-24f2-a882-b6502b384f02@amd.com>
Date: Fri, 25 Aug 2023 09:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] arm64: versal: Increase the number of DRAM banks to 36
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <ed9eaf5c20501ee691d7d28a173511cd9a87f161.1690958095.git.michal.simek@amd.com>
In-Reply-To: <ed9eaf5c20501ee691d7d28a173511cd9a87f161.1690958095.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: f372f665-c27d-4f4c-f011-08dba53b2ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Qp5xLVYpfmxgskBfS+qRfGFKGo4z1B/qQQOON/AG1kD2BLbJUzwqQdeElr4Tw7tnNy1vdrmAyrLA7TycUacR8puB+5YwAk9AnJ0jjECHYtalDEjlOnzJfe18nx+BTbQlBSFdKG321/C7bftte/ErZA3+6nTKvy+vsqlSe0pkaoazWKV15ojQ8ZHre6+NXEMZHs+mug1fvnya0FU1khPCZGd6lEz6wx4Za7zmrALIVLSQpTl6/WwPEhniCToR7bKmQRHAa3XoDKcRjqiotqsmPdmtWOEXox4H9mcZgNE0euj2lUNubLRRxiTMk5h6FePclE1CnIUmKsrJIT4bw2cgd0uLzVprGKXDt1QdUtc94ldz4PrVM5J9iA6Q+4cdCO1visguL3jLQ1it/8z0v+RXDtzjR2id5d8CIm5nn2gS9PXlJE3cnT7jpzNgaAo9dqUMdWYv5qGBk4utTO9rqZ3HM23lErKStMzuOWP5W/vYpbVd9nxa/X6OvDMM5/4aOXkyQ5eyojUo4tzL1JOlczTcDFzMR3Bv3a/FmLT2lkRgW7pL5STec3OCNsZ/7zeo9GcI+EnjWx1u/xazc0Li6ClUek+5Jn7znqmmrUvPxbCSGZMgynsBpVftakkw43nNOrbGCW332htBUseL7406ZhszYG9l920rt9eC5ZiiEwvJNOmLrKdJxz+B9Xlb3b+1s+xIzJAcxgXkgMwwZlB6GEuytvZHSdKOUufN+YBvQtXOkqqGMqNcqP9mFh2VWVg47EmZu//5m92XmurUsbZibZVkeCkjADCBdcme131Kw2QyAABO3IsUgUSzoVf5ZTPR8G9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(40460700003)(8676002)(4326008)(8936002)(31696002)(41300700001)(53546011)(316002)(36756003)(110136005)(70586007)(70206006)(86362001)(16576012)(40480700001)(47076005)(26005)(478600001)(16526019)(336012)(36860700001)(44832011)(83380400001)(15650500001)(31686004)(2906002)(2616005)(426003)(5660300002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:16:17.7170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f372f665-c27d-4f4c-f011-08dba53b2ce7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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



On 8/2/23 08:35, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> HBM stands for high bandwidth memory and is a type of memory interface used
> in 3D-stacked DRAM (dynamic random access memory) in some AMD GPUs (aka
> graphics cards), as well as the server, high-performance computing (HPC)
> and networking and client space. High Bandwidth Memory(HBM) has total 16
> channels, one channel is divided into two pseudo channels which makes its
> 32 banks each with some amount of memory.
> And then we have DDR_LOW PS low, DDR_HIGH0 PS high, DDR_HIGH1 PS very high
> and pretty much there should be also place for PL DDR. So maximum number of
> memory banks will be 36, updating the CONFIG_NR_DRAM_BANKS to 36.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_versal_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index a1feafc49b9f..0339130e8b85 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -5,6 +5,7 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
>   CONFIG_ARCH_VERSAL=y
>   CONFIG_TEXT_BASE=0x8000000
>   CONFIG_SYS_MALLOC_F_LEN=0x100000
> +CONFIG_NR_DRAM_BANKS=36
>   CONFIG_DEFAULT_DEVICE_TREE="xilinx-versal-virt"
>   CONFIG_SYS_PROMPT="Versal> "
>   CONFIG_OF_LIBFDT_OVERLAY=y

Applied.
M
