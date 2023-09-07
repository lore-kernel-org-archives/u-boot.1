Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4669EB8FB0
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 11:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C36686863;
	Thu,  7 Sep 2023 13:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c497/M/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8BE8691E; Thu,  7 Sep 2023 13:23:19 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 791F286410
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 13:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMA0VSkeXYpIJtH84f3WQ9meMadyWyf5eDqm4AKgtmk/P6pggKWHoUwZzGVc6KCCm8gNlpq0QMiiJvDyziSM1hyYWnHAQMXQQNVSFtJSiRPyiPPgICh5sOd9UHLACjSvulJzvI9NkOZERMvmTL9i5iXHbCLp6y2BsLFLe8/z+By/tK9yHqEhxZemQG30ImKGJB/qkukF3sdgm90Ws8s/10NFdN4tZaDLacEITPOUGyEYpBZhMUb4QCeUDP9AC7bdMi5+DfSMMp8PSYOcqqImOnx0ovlT9G4kgW3J8sotKd5XxTO9YCGS5q3qC2XbXGG7bKhnB1qo4NbBsZxHDGesww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdKfhMDP28yl/1/DV0AgTABA4pddxLlwQoggxcLQTGo=;
 b=I1+5KczvAayeIekAuzEorUxBjZRPthf3Sh0xr+5/i09UMJQOCsKz506vUCV+nvuL+evsVMx8ZuKeVk206nH+TYMh7oQb8JUarULYYng7gWJk/ZhQSTsatokBTInyvHgg4wW5L/Q3m2n5RGiX9MGqGfe/a46IIrOepSJ9Wa1l1bNh1hqvmdxDlkiTqLxg7hLr6Jum68Log26mLN3QXXkVN+JQDsEWdlsUCB+fys66kG+Y6w/Voh9k1EyUPkhuni3hBcwj5MwiQNrWet0IuyI1we9UhxVMA80nZccysWl3jHFjv7ESLQlO3NQckR8Cmz5ivoNhbs/zQuXAWuHMEe4Uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdKfhMDP28yl/1/DV0AgTABA4pddxLlwQoggxcLQTGo=;
 b=c497/M/AJpGrxWSodRuR0LiY7j2SmlbaR6Qnj2sKJexPLWu18+7sGSr0qxsOUW2XmnQyZA0QQdceYU0Cb9BrVWXPz19opBngh1YpPfAAt1TPcTtXZBSPTKI5mb33qfyVry6IlEtLtZpLCsvfeLr8k/50iR/AFIpv8sgiSWHPZuA=
Received: from SA9PR13CA0170.namprd13.prod.outlook.com (2603:10b6:806:28::25)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 11:23:12 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::55) by SA9PR13CA0170.outlook.office365.com
 (2603:10b6:806:28::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Thu, 7 Sep 2023 11:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 11:23:11 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 06:23:09 -0500
Message-ID: <8fe824c3-88d7-92a4-3b5d-31013b130ed6@amd.com>
Date: Thu, 7 Sep 2023 13:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 1/2] dm: core: ofnode: Add
 ofnode_read_bootscript_address()
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nikhil M Jain
 <n-jain1@ti.com>
References: <23be3838502efef61803c90ef6e8b32bbd6ede41.1693465140.git.michal.simek@amd.com>
In-Reply-To: <23be3838502efef61803c90ef6e8b32bbd6ede41.1693465140.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: b570780e-d867-41de-fcbc-08dbaf94d228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrUijX61qtxW5wFm+VKN7kv2LXVp6rb2cvK7ZD9/sVEbqsQ0Ctxy161ftmckBMW9LDfrmmu6wcyWvy8RFEvfgjd5u/wDLmTNuU14LT4TmRVsR9ytoLH+QeMua/9BsH+ZPeJQUsAcPYOXOUAMZf40NQoS3/oRjdPJ05RiWJMFuSvxCN7hoIbM80D+kSUa9N9p1EbtmUie+zq7NBDhMhc8k/VqAqsjg5ZL+qFzNU4e3narQzS+0OC9Emj7GrOkLx0viw3Rb8VM43q3GWPpX5i8n7EGtttnafMgJ1TlolOafJBqcmYHPNFABSrzPYiY0d39KgDCQ88opDo87ZeK+TldqK37ZwJWtsBc+1X4d6QvDsxyrYI+UdjH/JN+S4cowd/0r/9+CvGrxpi3pE7Jbn9MvTpRhYh9w245ziT5EwE4p/a5Hdh0wof9vYOksfNpLJ0mUIpzUl0wr2rI4alLuJilIKaRw/lcub+GSmiiet2p+Q1QyGBtq5GoKMP008P34HfJE5rcU/QTqVC2vWvhr+u0A6aMB5OGnoD9C5J4PLD7tXutYAvcFK/vUG0tNOy7n5UmhHuM8VvPyBIKsm6DWnNTGdHhLSrXg3Pxe3MWUN9q85GAJ5uLP55qAc+AY1tFhxHD+ziJW7cS12L4lo7DdSgSx7QEnxrVlMOk79UytkbUE5VaDYN4BSbX3BC7Npg2ZPBrthrikVG4ze0I8P0MPiZyogQi09AXD2cGY+6WBQaa/SIRanPTBjuD60qatn7pPYkU9/Nlznzm5hjZ4G+j7dwB73tiy3VA2xUcGjvX60EINmEWE3R/UXb0dvE8ncyyiaFF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(82310400011)(186009)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(41300700001)(110136005)(70586007)(336012)(54906003)(86362001)(31696002)(16526019)(40480700001)(26005)(70206006)(83380400001)(426003)(16576012)(40460700003)(316002)(44832011)(5660300002)(81166007)(356005)(478600001)(36756003)(36860700001)(82740400003)(53546011)(31686004)(2616005)(4326008)(2906002)(8676002)(8936002)(47076005)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 11:23:11.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b570780e-d867-41de-fcbc-08dbaf94d228
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
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



On 8/31/23 08:59, Michal Simek wrote:
> ofnode_read_bootscript_address() reads bootscript address from
> /options/u-boot DT node. bootscr-address or bootscr-ram-offset properties
> are read and values are filled. bootscr-address has higher priority than
> bootscr-ram-offset and the only one should be described in DT.
> 
> Also add test to cover this new function.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v5:
> - CI loop found some issues. Missing errno.h, multiple
>    ofnode_read_bootscript_address() because of missing static inline for !DM
>    cases
> 
> Changes in v4:
> - Update ofnode test based on review from Simon
> 
> Changes in v3:
> - new patch in this series
> 
>   arch/sandbox/dts/test.dts |  7 +++++++
>   drivers/core/ofnode.c     | 25 +++++++++++++++++++++++++
>   include/dm/ofnode.h       | 26 ++++++++++++++++++++++++++
>   test/dm/ofnode.c          | 14 ++++++++++++++
>   4 files changed, 72 insertions(+)
> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index f351d5cb84b0..84879cc31ac0 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -79,6 +79,13 @@
>   		};
>   	};
>   
> +	options {
> +		u-boot {
> +			compatible = "u-boot,config";
> +			bootscr-ram-offset = /bits/ 64 <0x12345678>;
> +		};
> +	};
> +
>   	bootstd {
>   		bootph-verify;
>   		compatible = "u-boot,boot-std";
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 8df16e56af5c..d94f0300c30a 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -1563,6 +1563,31 @@ const char *ofnode_conf_read_str(const char *prop_name)
>   	return ofnode_read_string(node, prop_name);
>   }
>   
> +int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
> +{
> +	int ret;
> +	ofnode uboot;
> +
> +	*bootscr_address = 0;
> +	*bootscr_offset = 0;
> +
> +	uboot = ofnode_path("/options/u-boot");
> +	if (!ofnode_valid(uboot)) {
> +		printf("%s: Missing /u-boot node\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ret = ofnode_read_u64(uboot, "bootscr-address", bootscr_address);
> +	if (ret) {
> +		ret = ofnode_read_u64(uboot, "bootscr-ram-offset",
> +				      bootscr_offset);
> +		if (ret)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   ofnode ofnode_get_phy_node(ofnode node)
>   {
>   	/* DT node properties that reference a PHY node */
> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> index 0f38b3e736de..c1afa69e1c56 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -20,6 +20,7 @@
>   struct resource;
>   
>   #include <dm/ofnode_decl.h>
> +#include <linux/errno.h>
>   
>   struct ofnode_phandle_args {
>   	ofnode node;
> @@ -1500,6 +1501,26 @@ int ofnode_conf_read_int(const char *prop_name, int default_val);
>    */
>   const char *ofnode_conf_read_str(const char *prop_name);
>   
> +/**
> + * ofnode_read_bootscript_address() - Read bootscr-address or bootscr-ram-offset
> + *
> + * @bootscr_address: pointer to 64bit address where bootscr-address property value
> + * is stored
> + * @bootscr_offset:  pointer to 64bit offset address where bootscr-ram-offset
> + * property value is stored
> + *
> + * This reads a bootscr-address or bootscr-ram-offset property from
> + * the /options/u-boot/ node of the devicetree. bootscr-address holds the full
> + * address of the boot script file. bootscr-ram-offset holds the boot script
> + * file offset from the start of the ram base address. When bootscr-address is
> + * defined, bootscr-ram-offset property is ignored.
> + *
> + * This only works with the control FDT.
> + *
> + * Return: 0 if OK, -EINVAL if property is not found.
> + */
> +int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset);
> +
>   #else /* CONFIG_DM */
>   static inline bool ofnode_conf_read_bool(const char *prop_name)
>   {
> @@ -1516,6 +1537,11 @@ static inline const char *ofnode_conf_read_str(const char *prop_name)
>   	return NULL;
>   }
>   
> +static inline int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
> +{
> +	return -EINVAL;
> +}
> +
>   #endif /* CONFIG_DM */
>   
>   /**
> diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
> index 6fbebc7da085..a4e04f23784f 100644
> --- a/test/dm/ofnode.c
> +++ b/test/dm/ofnode.c
> @@ -583,6 +583,20 @@ static int dm_test_ofnode_conf(struct unit_test_state *uts)
>   }
>   DM_TEST(dm_test_ofnode_conf, 0);
>   
> +static int dm_test_ofnode_options(struct unit_test_state *uts)
> +{
> +	u64 bootscr_address;
> +	u64 bootscr_offset;
> +
> +	ut_assertok(ofnode_read_bootscript_address(&bootscr_address,
> +						   &bootscr_offset));
> +	ut_asserteq_64(0, bootscr_address);
> +	ut_asserteq_64(0x12345678, bootscr_offset);
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_ofnode_options, 0);
> +
>   static int dm_test_ofnode_for_each_compatible_node(struct unit_test_state *uts)
>   {
>   	const char compatible[] = "denx,u-boot-fdt-test";

Applied.
M
