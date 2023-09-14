Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1703EEAA44
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 14:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5F7886EEB;
	Thu, 14 Sep 2023 16:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u0UvepV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BD486F58; Thu, 14 Sep 2023 16:04:30 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DF3B86E26
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 16:04:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTFqzS1Ntxue1oAR25FwZF4AJ2vp9/EpmffrbxVIgZvSI1UjwrQev/Xk/jEZpR9s/WCqsgWGBQg/vKgxpy7EUwnMizlEKS6YzcYLcJPNxH27zweNROOc/y1kpGY4X3VPEyq+e1V8PVSr2swv17hkmwgDT38RJaHyA0STuzC2rMzUUCCdv1fSu5K1IyeRfxk+smtP/Jk+qCAhIc07uMs+WxT9Nrk2ZC4OZe5SG3FYUflzjS8TbA0lty3Qws/box4KmzLY1ewaoPFeLjT8OPKi71bz6VAv8k9wOlDncK1QOKVu9iidvbVR/2YA8G7IHcaTnUH3iDdWn2uyNPAEWqoWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lGKYM/jkGFKCKIuVRz6+C3fZwlcViNu0zBroVENjhA=;
 b=A6EVP0572zyhDqJZePfSRQRGgUhwO3E+L8PEg/FpnnrPaSfgajC8KOJlTLH5Miw20JSGw8+K0FBw+wcjQmGBfGr5PInIZvEp00GfO1Cv5qzJH2Y/ffXPEk7a4sBPW5PgqOp1lejl1LGOzAdXOb809gBNa33YZUin8ccXPxq7LPPPxJj467WdgT2gE9jrrw2EphmayttKXUIhfBCKNeBeaNJZFcJ3aTNfsARjuslOLJ1zodgjxbWs8gSEruNomM22TxotDGmPRcwp3d16vIX79cNVjmVWeXf/PMTecvruvheR4eazox4HD1TjHtJyYgYs2qp25P+/GCqqJ+p2pKsPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lGKYM/jkGFKCKIuVRz6+C3fZwlcViNu0zBroVENjhA=;
 b=u0UvepV0nTfZR8KCms9QikOiClMHOA4/0eap3a5NRkcPoV1M3pczP1pX3GFJRf34JRpTlmSIZRwetMPb+ulOcOwG7B1rOfX+4MMswUK60Rl8MGDojcNFIGywNNMgNAmrcQ6BUSjG3WNxWRPP4bPbHtLEf1J+F8mjZvTRKnZlB1U=
Received: from MW2PR2101CA0014.namprd21.prod.outlook.com (2603:10b6:302:1::27)
 by SJ0PR12MB5424.namprd12.prod.outlook.com (2603:10b6:a03:300::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 14:04:23 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::ae) by MW2PR2101CA0014.outlook.office365.com
 (2603:10b6:302:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.6 via Frontend
 Transport; Thu, 14 Sep 2023 14:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 14:04:22 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 09:04:20 -0500
Message-ID: <372b339a-1a55-4a7a-8891-2b3f8798420c@amd.com>
Date: Thu, 14 Sep 2023 16:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: zynqmp_qspi: Workaround for small data cache issue
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <git@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
References: <20230914104826.30153-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230914104826.30153-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|SJ0PR12MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e566de-3f17-4cdb-5539-08dbb52b7f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pArBWaDC2eEjABZZh2IQwfK3DAvfMGNFq1nOBrJ3Ot7Dt1N8WarZ1Um+Z9XE/nIj5KiSSt0+8A5xLE/r4EJE092k5bhd94zBIzxFeyR0da9BllwIXz371+AxCoI79D6JGXE5Kl6BSta/alfnj2wvylpDTTaygG+DuQLDScWbdCOirY1HJMua06zQ66XFqQ+bTkeiHMQb5hsBJixcbj9w4/plFtpFQbpa4h5SItcMEhOQYIF3FE8TwJc8cC3LYOvw2m00IagN0WYXJyHPQxBNkbEn0wJNSy8l0HPUNhCzim0DK091pu0JVeUM7ETxyTmaT1SXdmUUDQ5ZX0yZ87tPwuZhK4sYs27zNKOr4upbFNvmuzvQYVvSi9+gOh9AHl/mvnFV8PR/AgN+afXWg2ZYgJySroxE9MLwaI789R/H/ewRbjmpp4fZjheahee/Nv75fyJizgCW3y9V/hLrCOL+nxpo8d6+ZpF21kLE3MctpSnkdR/exUv2cJ2hO67w4VOvtunaMuLLd5OHUWAQnkdmAe7/0KNFcmCny6pAEjb/QkSSUQ3REGFhVromD2qV2mJLr7+oT25pa8ITvdvkwuN0HpJ6N3NqmsbQyyFGyYaLwF1Dak7AXJp15X4NECTwfkTBOaALFQkC4A5qBWYMC1IR0jhO8wCkUThz3B2DjFdfy6QF9k1/uydz3tO4duNQo1uwOnRvFazAXsM6B5msNZIxyO6bYLQ0h3U4JfyeNHXXxr8WBQAKI4zSL/NYOfK9dpfiDJI4RFD8818wO/0lSQo5AMcqWqSGxTVhxORy6C8qtYnUCvvLo/s7hajM/kQJ08PF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(36840700001)(46966006)(47076005)(16526019)(31686004)(2616005)(44832011)(5660300002)(82740400003)(8936002)(8676002)(4326008)(83380400001)(336012)(426003)(36860700001)(26005)(81166007)(53546011)(16576012)(110136005)(316002)(70206006)(70586007)(40480700001)(54906003)(41300700001)(36756003)(86362001)(31696002)(356005)(478600001)(2906002)(40460700003)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:04:22.4441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e566de-3f17-4cdb-5539-08dbb52b7f3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5424
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



On 9/14/23 12:48, Venkatesh Yadav Abbarapu wrote:
> Cache related issues are seen with small sized data reads.
> Due to this, proper data is not read. Also some times sf probe
> fails randomly. To workaround this issue, invalidate dcache after read DMA
> is triggered.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/zynqmp_gqspi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
> index a506d15227..ec59ef5804 100644
> --- a/drivers/spi/zynqmp_gqspi.c
> +++ b/drivers/spi/zynqmp_gqspi.c
> @@ -707,6 +707,8 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
>   			return -ETIMEDOUT;
>   		}
>   
> +		invalidate_dcache_range(addr, addr + size);
> +
>   		writel(GQSPI_DMA_DST_I_STS_DONE, &dma_regs->dmaisr);
>   
>   		debug("buf:0x%lx, rxbuf:0x%lx, *buf:0x%x len: 0x%x\n",

I got two patches. Which one is correct?
Can you please send v2?

M
