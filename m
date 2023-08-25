Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE65FC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23A986961;
	Fri, 25 Aug 2023 09:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VNRqB5vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EC6D86A30; Fri, 25 Aug 2023 09:16:19 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F8C78655E
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPzjJqFU4iA6w1ZSsanjFXDfeCcdN4JTtpvZ8m9fZtuCu5arN5fm3kz0yybfp+jv+zmCNmwUB7yiidEBswOso0b+lmHhe9WUnYi6GbRQfQfOZLzWUiTSuso520Zfm+GtoYIHENSS7CIz8iaTUCTWPNyGqea4sR0XNOh1wupERoTJbQgfKJ6SAuCgDPFPBDdfwFmNawdBuUTNw7WE41DzRnKaqFYM56Ut1Qt+xHo9sjw3mcRvuCMNE6AG4rJXo8ymewpd0Wyjet0FuFdTKTqMTv9LcEuyillAY33ws/JZ3EyDSniswJEl/AQZrYqfiSbt3QOHsWLE9zqr1/0EprXK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbdeNPGzR52lbpBkrLBsGkBnGwNOSpKI1cd4JTSg83s=;
 b=QW9u+wGHbPqTZ5RHgVlWZWUp9Hgr/D6/tAxoxlC+aN5nU0p9UBc1ciYrlyr+CRrvtxwuBpxB4A1cbLRvLbAwnS6IwRmBPmv59ED+Ab2SwDWziqlopFG8MKs9LYEUGjhKD8XFH7iVMU22p06pU9aA5WCj8bizE+h9TPp0TYD2TPjYHv9a2Id/TU4+RaFaprgUPzH3GvLHMYQ1z7vZWX64GgIvdnIbcgSwa7vuK7O0lIBEzMkflX44y7g08AUFOIGjiwHWdPLuDiByhQuzX1XvMxlaQohFGCTwiTxpOoaRhGm82d6YIiTL7sg+87yepb33NzcNh3ha8aqfZLsj6U9M7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbdeNPGzR52lbpBkrLBsGkBnGwNOSpKI1cd4JTSg83s=;
 b=VNRqB5vqxq+MdKdW9yWDYr37BQqbjRZHTlXjnSJ7rDkZZ++1fDW8tDl14pfwcD15NYq4Y/FsFz8+QC64R82DmcUZA8j4WB7B2h35X2yFxYemL2Bc/flCt/gt/BY0aGsK1j6gqdFaq6iqnpBXJVAXaK9ZXJV6RMYdNgam7qso4Bs=
Received: from CY5PR15CA0211.namprd15.prod.outlook.com (2603:10b6:930:88::13)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 07:16:12 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:88:cafe::e) by CY5PR15CA0211.outlook.office365.com
 (2603:10b6:930:88::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 07:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 07:16:12 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:16:09 -0500
Message-ID: <d51c75cc-da84-ead8-133d-7dd2ab6a806f@amd.com>
Date: Fri, 25 Aug 2023 09:15:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/2] dm: core: ofnode: Add
 ofnode_read_bootscript_address()
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nikhil M Jain
 <n-jain1@ti.com>
References: <b37aec1460d93727a9065766aa5f50fa356ae5aa.1690873880.git.michal.simek@amd.com>
In-Reply-To: <b37aec1460d93727a9065766aa5f50fa356ae5aa.1690873880.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edd3ae0-7257-4b33-1b94-08dba53b2999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpZ/wi99QbrXLrHe6hdwx8L3u3o0XXo6R5OdfgG6qQJuJmHeG0aEO+L27voV1Y7hHPHv1Hg2EHnIV6ghAZDCl64S3VgMZbkWm6qsKPNs7k4CFRUYW50kUMGZER+f4rB/QEK0iWdFHKgszREbQ3wHZ4HZKTEmTrGDCobRdlByagso/6152b/MKV13vByPmIVof8kqVTBTK8OkV417uTysTGwm58QPAnzTfRAxKwT7F2cr3PIPH0IzccN6bOVzkN5IInGHEJ592r+xvswNepGFjXC1kUt5wkRUz08ILtqvFkGi2jCmZVZufa5f8yWeZ4QwxCtTU8VDrAGYoYxPkyCMnXBRktnpR2p3/zlcBQYsStoQSyD1YMfPf/RwB8YD27vcDoaFvu4JXGJBOIf6tRBce3eT0o3wsZik2OfoF9u6idDHECMmSraIq3AN1FIszPhNFKBZ1+W+bUEwUDlE23Rh6fd+zMAszxnpBRMk/Lha4/0wlHLStox4LzAhZaxjnjYJklFK0mPBaI2YDqLj0tryvnblIihA5bK3mvMQXGWbw2M/dpI5zlAGGCmq6j4gmmR4biyLs9iu9Tb4cFiQk5ipN8HMDjpjaqbMWlw8N0yWQCtu+SyPHzUTIwzZuAyhACtzvQaxLspdoZ/8AZtsS1NNwQncWltBCSSezj7FosjDkxSNSTx3oxUOyUmMOE3dgT8GWaMokbyE+aqnrAHJUiQ1tn7BoAOWw47EhlMl3akZzdRZq4dkK2OidHJrhvWxqKFPrfFmX2i0HHc0lMf1R+Fr7xtDoDb8PVyJkOYjJUIByg3qsbeAS/ml4LP9+ok5RXQ6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(186009)(1800799009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(426003)(36756003)(83380400001)(44832011)(36860700001)(26005)(16526019)(82740400003)(40480700001)(356005)(6666004)(81166007)(16576012)(70586007)(70206006)(54906003)(316002)(110136005)(478600001)(31686004)(53546011)(41300700001)(2906002)(86362001)(31696002)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:16:12.1673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edd3ae0-7257-4b33-1b94-08dba53b2999
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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



On 8/1/23 09:11, Michal Simek wrote:
> ofnode_read_bootscript_address() reads bootscript address from
> /options/u-boot DT node. bootscr-address or bootscr-ram-offset properties
> are read and values are filled. bootscr-address has higher priority than
> bootscr-ram-offset and the only one should be described in DT.
> 
> Also add test to cover this new function.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> ---
> 
> Changes in v4:
> - Update ofnode test based on review from Simon
> 
> Changes in v3:
> - new patch in this series
> 
>   arch/sandbox/dts/test.dts |  7 +++++++
>   drivers/core/ofnode.c     | 25 +++++++++++++++++++++++++
>   include/dm/ofnode.h       | 25 +++++++++++++++++++++++++
>   test/dm/ofnode.c          | 14 ++++++++++++++
>   4 files changed, 71 insertions(+)
> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index b5509eee8cfe..94b00b80429b 100644
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
> index 0f38b3e736de..a297236112ed 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -1500,6 +1500,26 @@ int ofnode_conf_read_int(const char *prop_name, int default_val);
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
> @@ -1516,6 +1536,11 @@ static inline const char *ofnode_conf_read_str(const char *prop_name)
>   	return NULL;
>   }
>   
> +int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
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
