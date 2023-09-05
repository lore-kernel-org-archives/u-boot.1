Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EB5C83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 11:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44ED88679F;
	Tue,  5 Sep 2023 13:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="togKJ8f6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A89EF8691E; Tue,  5 Sep 2023 13:36:27 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1E58655F
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 13:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPZoE58QLvguh73WdFKdLSJ8YUZlvtPaoDk1TlcFTKWOSdsKjvVohMAFmUNRm7xkHatYKYs4zyqMBT+vVM2xSfOWmihx1H2eyZ7JLtQFivJufUPkZ0DjwFX0TShNn4vzrEplecbz3NqYMt4AvQFkjrFvd0ZMfxK1r86gQ/OAe3TDx4dOUerqBCdlNzpz4+0uhb4L3T7vUqsAIqajpJh2+mu5osCTFd8UghI3o3Bt35AYs0Q40GggjVDfL8Pt/u6h4oEbFPgfIVw+SyJ4HkkU7/YwCmX9wVBlwdtp8hNDU5DyAcvSV/eYq08WYYB6YaS6noq82DJXNaJcGZ7VS4ds2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AgV5ErhHh6iTqLOXT84/iwbE5uJNikxDWQfUGokj4c=;
 b=e7zMGtFxrRRPZc/ILafvV+E1wgARPZngfRSH2xEWPPEN0FAm+riDKSo9xvRlm21A3HBFjlPH+fZUV3F6oGVKRSTHMT9bQ7Cl+ibKgHfP9wlBH5W1EJdTOThjA07JLOuGxHsmfrYPRgj6kXCnd4GzsrbDkpf+JGDOT8w4uK8gQT/KPL8DTXbT+9vxYc1LtcvQu3/77jPVq4l0Vt4Or1xBe6UkI9paEuIPoTnASIbKZMu7SQhBsfDqk1OAlzEscQcZaaa36d4MadlUnecnpgj2nTv2Ey3cD2lJnoPvOYDknB50gJ750h2q7nAZTv9T99Qtlh8UsE+qwOu7tuCxXH3Kug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AgV5ErhHh6iTqLOXT84/iwbE5uJNikxDWQfUGokj4c=;
 b=togKJ8f6aezSqqltkic3JAc64zQnxoAKAIeDTr97DRehtu+mf7pbdbQGzPRM0RGAivpCOt5KIMVhNOrsiBitohuNYfZYhkuTbxRuGe8BkK75ZRum3OvLpUPn7p/QlRhmygfv7xEwxgjqO0LGIa8jELfUfjXgfCJsRgNEhSYwzkE=
Received: from DM5PR07CA0103.namprd07.prod.outlook.com (2603:10b6:4:ae::32) by
 SN7PR12MB6983.namprd12.prod.outlook.com (2603:10b6:806:261::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:36:20 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::7d) by DM5PR07CA0103.outlook.office365.com
 (2603:10b6:4:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 11:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 11:36:20 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Sep
 2023 06:36:17 -0500
Message-ID: <329f3bf1-0725-ff68-c6df-d053eb02f8b3@amd.com>
Date: Tue, 5 Sep 2023 13:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] dm: core: support reading a single indexed u64 value
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nikhil M Jain
 <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
References: <08043c8d204d0068f04c27de86afe78c75c50b69.1692956263.git.michal.simek@amd.com>
In-Reply-To: <08043c8d204d0068f04c27de86afe78c75c50b69.1692956263.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SN7PR12MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ba7587-6bfc-4b13-14f3-08dbae045326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQKQuqawRPN9IcI+vIurHWFCmYp2fe9vm6SS5k1AKRIR4iJkTIGKKED0N103ydl41q+wJrlVOYjtDG7psuH3B4tdLzfcKc5tRGjPB+ood3D28UxT97Nx+Ta5+MxlzbWCNGvrlnUsx3NxqBXf7kX5SbkPNrLnXMOlzI7e5OL9qzjg4u+GCNORD+ajkQodl60a/UopWVUMq+iMlrNNUZ+rzakhHLsOVfe2xvxWLvvynhy0777yadtR+tfsaEatGjv/cTUxmRPSSoK43WufFdMa/0EaikIElF+tS8+G/i0p+O6bci6Pk7UZy9X2OmYsvdeeOHSWbqjvu4gRBHEdyORlxRK4TGMioEs024v6LCJDh8mWfAML03qj/GX0q1lBgV0JO4B7PVJLuk1nvJ1oQthIYxrnqjElW+1fU0rJ3pt7t7IIg7BseWefGmr2pAWu0rsis9CbiLH3rTYx22rUwcdkfRYKE+owql7CAaYGMnh1TaMQh6yd1TV97N6xxv9HH2GPdL6kmyXHBiX7A3ZSCXLfwLTS3f/bpj5cUfZkatVNi4bVfq4Hac1DF6aQcDynxw5Ntm1aywe/DCE80nMq7856bRz+PZRx4cBgRkpxZfVih9q7QWF0VnPMZtj4GVBehznkYxhd36OJSNSOU7BGc/yZCgss1A6RaYNo27ikwYxagLltimKXT/lT4QF47+kgUJyNwTHShTekGqQhoutUlEP7ZNxtf98ZAd7I7dRI8mjkfVsRXAk5UOLab/C8Pc0NrNMA3qIJlWdombeMYAppmxqtGiEmKPYhMY8YrqFqRyQq6kq0GwbSNLr/6RPsUr/xZpVX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(2616005)(8936002)(70586007)(16576012)(54906003)(110136005)(316002)(8676002)(4326008)(70206006)(40480700001)(82740400003)(356005)(81166007)(53546011)(41300700001)(336012)(426003)(16526019)(5660300002)(83380400001)(26005)(44832011)(31686004)(478600001)(2906002)(47076005)(36860700001)(40460700003)(31696002)(86362001)(36756003)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:36:20.0070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ba7587-6bfc-4b13-14f3-08dbae045326
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6983
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



On 8/25/23 11:37, Michal Simek wrote:
> Add helper function to allow reading a single indexed u64 value from a
> device-tree property containing multiple u64 values, that is an array of
> u64's.
> 
> Co-developed-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> ---
> 
> Changes in v2:
> - fix kernel-doc for of_read_u64_index()
> - add missing test reported by Simon
> - fix debug print to print 64bit value
> - convert of_read_u64 to use of_read_u64_index() as is done also for u32 version
> - fix overflow size calculation
> 
> Tested on sandbox:
> make defconfig && make -j8 && ./u-boot --fdt arch/sandbox/dts/test.dtb --command "ut dm ofnode_u64" -v
> 
> Test: dm_test_ofnode_u64: ofnode.c
> Test: dm_test_ofnode_u64: ofnode.c (flat tree)
> Failures: 0
> 
> Based on v2023.07 tag.
> 
> ---
>   arch/sandbox/dts/test.dts |  1 +
>   drivers/core/of_access.c  | 16 ++++++++++++----
>   drivers/core/ofnode.c     | 30 ++++++++++++++++++++++++++++++
>   include/dm/of_access.h    | 19 +++++++++++++++++++
>   include/dm/ofnode.h       | 12 ++++++++++++
>   test/dm/ofnode.c          |  8 ++++++++
>   6 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index ff9f9222e6f9..a3c12bb09874 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -288,6 +288,7 @@
>   		uint-value = <(-1234)>;
>   		int64-value = /bits/ 64 <0x1111222233334444>;
>   		int-array = <5678 9123 4567>;
> +		int64-array = /bits/ 64 <0x1111222233334444 0x4444333322221111>;
>   		str-value = "test string";
>   		interrupts-extended = <&irq 3 0>;
>   		acpi,name = "GHIJ";
> diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
> index 81a307992c01..1d5348bf2f50 100644
> --- a/drivers/core/of_access.c
> +++ b/drivers/core/of_access.c
> @@ -570,26 +570,34 @@ int of_read_u32_index(const struct device_node *np, const char *propname,
>   	return 0;
>   }
>   
> -int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
> +int of_read_u64_index(const struct device_node *np, const char *propname,
> +		      int index, u64 *outp)
>   {
>   	const __be64 *val;
>   
>   	debug("%s: %s: ", __func__, propname);
>   	if (!np)
>   		return -EINVAL;
> -	val = of_find_property_value_of_size(np, propname, sizeof(*outp));
> +
> +	val = of_find_property_value_of_size(np, propname,
> +					     sizeof(*outp) * (index + 1));
>   	if (IS_ERR(val)) {
>   		debug("(not found)\n");
>   		return PTR_ERR(val);
>   	}
>   
> -	*outp = be64_to_cpup(val);
> +	*outp = be64_to_cpup(val + index);
>   	debug("%#llx (%lld)\n", (unsigned long long)*outp,
> -              (unsigned long long)*outp);
> +	      (unsigned long long)*outp);
>   
>   	return 0;
>   }
>   
> +int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
> +{
> +	return of_read_u64_index(np, propname, 0, outp);
> +}
> +
>   int of_property_match_string(const struct device_node *np, const char *propname,
>   			     const char *string)
>   {
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index ec574c446079..e973c74af4cf 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -319,6 +319,36 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
>   	return 0;
>   }
>   
> +int ofnode_read_u64_index(ofnode node, const char *propname, int index,
> +			  u64 *outp)
> +{
> +	const fdt64_t *cell;
> +	int len;
> +
> +	assert(ofnode_valid(node));
> +
> +	if (ofnode_is_np(node))
> +		return of_read_u64_index(ofnode_to_np(node), propname, index,
> +					 outp);
> +
> +	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
> +			   propname, &len);
> +	if (!cell) {
> +		debug("(not found)\n");
> +		return -EINVAL;
> +	}
> +
> +	if (len < (sizeof(u64) * (index + 1))) {
> +		debug("(not large enough)\n");
> +		return -EOVERFLOW;
> +	}
> +
> +	*outp = fdt64_to_cpu(cell[index]);
> +	debug("%#llx (%lld)\n", *outp, *outp);
> +
> +	return 0;
> +}
> +
>   u32 ofnode_read_u32_index_default(ofnode node, const char *propname, int index,
>   				  u32 def)
>   {
> diff --git a/include/dm/of_access.h b/include/dm/of_access.h
> index c556a18f7d9c..9361d0a87bfb 100644
> --- a/include/dm/of_access.h
> +++ b/include/dm/of_access.h
> @@ -333,6 +333,25 @@ int of_read_u32(const struct device_node *np, const char *propname, u32 *outp);
>   int of_read_u32_index(const struct device_node *np, const char *propname,
>   		      int index, u32 *outp);
>   
> +/**
> + * of_read_u64_index() - Find and read a 64-bit value from a multi-value
> + *                       property
> + *
> + * @np:		device node from which the property value is to be read.
> + * @propname:	name of the property to be searched.
> + * @index:	index of the u32 in the list of values
> + * @outp:	pointer to return value, modified only if return value is 0.
> + *
> + * Search for a property in a device node and read a 64-bit value from
> + * it.
> + *
> + * Return:
> + *   0 on success, -EINVAL if the property does not exist, or -EOVERFLOW if the
> + *   property data isn't large enough.
> + */
> +int of_read_u64_index(const struct device_node *np, const char *propname,
> +		      int index, u64 *outp);
> +
>   /**
>    * of_read_u64() - Find and read a 64-bit integer from a property
>    *
> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> index 443db6252ddc..c5c244c6a476 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -424,6 +424,18 @@ int ofnode_read_u32(ofnode node, const char *propname, u32 *outp);
>   int ofnode_read_u32_index(ofnode node, const char *propname, int index,
>   			  u32 *outp);
>   
> +/**
> + * ofnode_read_u64_index() - Read a 64-bit integer from a multi-value property
> + *
> + * @node:	valid node reference to read property from
> + * @propname:	name of the property to read from
> + * @index:	index of the integer to return
> + * @outp:	place to put value (if found)
> + * Return: 0 if OK, -ve on error
> + */
> +int ofnode_read_u64_index(ofnode node, const char *propname, int index,
> +			  u64 *outp);
> +
>   /**
>    * ofnode_read_s32() - Read a 32-bit integer from a property
>    *
> diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
> index 473a8cef5780..08b6721e926b 100644
> --- a/test/dm/ofnode.c
> +++ b/test/dm/ofnode.c
> @@ -967,6 +967,14 @@ static int dm_test_ofnode_u64(struct unit_test_state *uts)
>   	ut_asserteq_64(0x1111222233334444, val);
>   	ut_asserteq(-EINVAL, ofnode_read_u64(node, "missing", &val));
>   
> +	ut_assertok(ofnode_read_u64_index(node, "int64-array", 0, &val));
> +	ut_asserteq_64(0x1111222233334444, val);
> +	ut_assertok(ofnode_read_u64_index(node, "int64-array", 1, &val));
> +	ut_asserteq_64(0x4444333322221111, val);
> +	ut_asserteq(-EOVERFLOW,
> +		    ofnode_read_u64_index(node, "int64-array", 2, &val));
> +	ut_asserteq(-EINVAL, ofnode_read_u64_index(node, "missing", 0, &val));
> +
>   	return 0;
>   }
>   DM_TEST(dm_test_ofnode_u64, UT_TESTF_SCAN_FDT);

Applied.
M
