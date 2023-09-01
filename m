Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF75CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 06:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3DED865A2;
	Fri,  1 Sep 2023 08:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Den3az+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 522E88669D; Fri,  1 Sep 2023 08:31:27 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B38786564
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 08:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWys28ncnSAvqlB3+zhwvzLtorO6waQeKRg/baQ/Rq40FgKBV/J+RwIJ46PZCyWoc+rxi05I02B2c3Ckw0Cuo4D32+QxGrDAYQkaV0spZmUX5xU7V65Q7prwhas6b0/oh21tEsQxaRCThTDoy98opImmdfkrRcA2/yozgJwkP6/U7NZSyPFEpujrNEdxL1JwSS5wlXqlcM9+aZd3Lk48iBIPJLTXQq5dU9oDnGhxNEyxnfZK/F/2kLSJOoODXGqVwRN78P47CIFWiLcQrB9J+DAfGmglZ5s5VvNU5c2SprpSTfCyzBADv+A7PbQIHgq9vWnbuVIeA4CLkKP6+CM21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2Pju2fKF8590MMcGWmEE5cO2nfvibDGTS8GNNrhC5w=;
 b=XoAVAal4+mEBfkkqL4NzRDW0nAiCVUKVN2gzNak2cIo+5eHYk7wW7w7JZ93n1fr1s5EmbrH/yuug4M/HCo+TzzhQogVZW1n/3+z6O2L/hLyarMgFtIuBcvsJb3Ss9GCnEwV7uWtHeoUqIa6EIQDDBonnV9JA2Fsm64TNAlVqdGGdKfGz3PJe27oOYlY1nJlxjAOt73OuBw+CQ5o21T+QPuYByyuHROd0P+11mjLhfDHuUuznm/+aWggXfcHJowRPJFU5lWzWQHVOP2S85eL1ix+Lagy81ZeSM73ep+Gp6CMuXTGBPEnpirm3PKoxKnpQaXAyHZMnEBHXuSD99a6M+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=samsung.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2Pju2fKF8590MMcGWmEE5cO2nfvibDGTS8GNNrhC5w=;
 b=Den3az+rXjauZ6XQlNk8HT/d2lEhtFDYt7AzGZr98E4orXQ4OzjZFFsl6puHlIVyFhI5Y3ZuCA2FLrfszUQa5jQEo1uZB0htwC7IyUbHHP8vm30vSSzZx+hmkUSA9FsjM2aCgoQoBPAIUdrHDz8ou0npmLFYVekhoQHYL+SEUxU=
Received: from BYAPR03CA0026.namprd03.prod.outlook.com (2603:10b6:a02:a8::39)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Fri, 1 Sep
 2023 06:31:16 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::b6) by BYAPR03CA0026.outlook.office365.com
 (2603:10b6:a02:a8::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.25 via Frontend
 Transport; Fri, 1 Sep 2023 06:31:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Fri, 1 Sep 2023 06:31:15 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Sep
 2023 01:31:13 -0500
Message-ID: <9a3442dc-049d-5c06-5803-d0f5381a1fed@amd.com>
Date: Fri, 1 Sep 2023 08:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] fpga: define dummy fpga_load function for debug build
Content-Language: en-US
To: Chanho Park <chanho61.park@samsung.com>, <u-boot@lists.denx.de>
CC: Eugen Hristev <eugen.hristev@collabora.com>, Simon Glass <sjg@chromium.org>
References: <CGME20230831075300epcas2p4dabae61e98d5f49fc1fffc5c62df9050@epcas2p4.samsung.com>
 <20230831075247.137501-1-chanho61.park@samsung.com>
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230831075247.137501-1-chanho61.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: b09e8474-c057-42b0-41b9-08dbaab50af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaOpMnlaMUOiumZVq2c5WkFAMj8S3PLT8+ibKYZHN1a8im0tt6tRWER0ff9nf4X0ZXFWAWZwY4DITfVGz9km5u89nRuXd1bD/BUS9mizo71DLVG8juMsoigqJo5/7PBU4LvYPTU4gC235tAIGFc87Km44N0WyJu8yCqHyJFc2o1RO59gmE3zzvnJGMlRM/ZYgJQsg3tXHqtu5S/YjlfgiRfUNpOMNa0QBqs++1viveDmyfOqtqPz3erjZGwUIMcTJE2BIdFlSOT/ZDSDapreKZd420VjPmGEjaLtitTTN0OJBA8Kh0NFhnZ2OgU1M4TcGa6uGkev7n4JLkmZpCBuXnfoitQUWSbBPqAZ8NgPVoYQvgLMVomAZcl/nEATy8ep805HE2Pxd0BWBTa4XjzpXLBdNJ23L/7n0hwwPjLOTSVhrgD6ZaxEu6GbQ17lbRAoXdwpDc+33DAoyvIzK4oT2Lql1mxkQpW6CtOUYnLqFZE+WAUwu8ze/phyMknLcvads0fw+RaoSL7LX+yH1Poo4c84arWMMm7JzPAri6mdSiA/03Wfgr9I5P8Mubl76vt/U06p9RU58sJjwBV0Wdv8mM7C8YNTmdohm+ZNmWV0mJ9/E7eKzIPXjUOXyWdkUUL17Q5rstDJcheo/tbfthZEFnznDCsUM6i/V5oIYDUJl8QOTpuyIKi6qei/sQde4VsC3jlmwkdkhwVI/vMEVNHGuKZ6tiEBUr1nR3NgJ5BT8M54qO/Xfdxc3uaE4LxmBz1bcQ0b8b5p3sbw8eKUmzBJ4uWtDnuCNOVp2dbL6hV6MJDU1928T727Q5PNez5s7lEO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(86362001)(53546011)(316002)(16576012)(478600001)(2616005)(4326008)(47076005)(36860700001)(8676002)(31686004)(31696002)(44832011)(8936002)(26005)(40460700003)(82740400003)(40480700001)(41300700001)(336012)(426003)(36756003)(356005)(81166007)(70206006)(70586007)(110136005)(83380400001)(54906003)(16526019)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 06:31:15.0971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09e8474-c057-42b0-41b9-08dbaab50af0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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



On 8/31/23 09:52, Chanho Park wrote:
> This fixes below build error when CC_OPTIMIZE_FOR_DEBUG is enabled and
> CONFIG_FPGA or CONFIG_SPL_FPGA are not enabled.
> When CC_OPTIMIZE_FOR_DEBUG is enabled, unused code will not be optimized
> out. Hence, fpga_load function must have a dummy implementation to avoid
> the build error.
> 
> ../common/spl/spl_fit.c:591: undefined reference to `fpga_load'
> collect2: error: ld returned 1 exit status
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
> Change from v1:
> - Rewrite the commit message to include a CONFIG_FPGA
> 
>   include/fpga.h | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/include/fpga.h b/include/fpga.h
> index ed688cc0fa3b..44f2755a3f10 100644
> --- a/include/fpga.h
> +++ b/include/fpga.h
> @@ -60,8 +60,16 @@ int fpga_add(fpga_type devtype, void *desc);
>   int fpga_count(void);
>   const fpga_desc *const fpga_get_desc(int devnum);
>   int fpga_is_partial_data(int devnum, size_t img_len);
> +#if CONFIG_IS_ENABLED(FPGA)
>   int fpga_load(int devnum, const void *buf, size_t bsize,
>   	      bitstream_type bstype, int flags);
> +#else
> +static inline int fpga_load(int devnum, const void *buf, size_t bsize,
> +	      bitstream_type bstype, int flags)
> +{
> +	return FPGA_FAIL;
> +}
> +#endif
>   int fpga_fsload(int devnum, const void *buf, size_t size,
>   		fpga_fs_info *fpga_fsinfo);
>   int fpga_loads(int devnum, const void *buf, size_t size,

Applied.
M
