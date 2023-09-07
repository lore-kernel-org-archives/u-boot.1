Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E80EB8FB1
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 11:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB2388692F;
	Thu,  7 Sep 2023 13:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wrvbwjK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D0AA86940; Thu,  7 Sep 2023 13:24:32 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16A8868BC
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 13:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEb4+v+rtvS28VOKzV6hDQWNp7KnLvIZhqBxFFCo+Zz2/kkewGdE6DyIfGZklCxHVBgX9DSINJccZOe3zHo/VJ9WPSjNXVfGhaIBg0n2qSoImLQZ2EnXDiaT4mjOJi6fxBT6IjP0gYI/SAMGGn9U0amJXITpRKPWD5L60ECA0Ur93JR4MhvysHDSCFomi4KZ5zZwpO+4KyMFWa4CAsS8w4wD81DaY8hzTrz2apewABODCLqTdVn2IR137dDsjJndpqVky5u49BqcuOURIkn+3vmuv0mmksqNIByYLYxiptq6cCoCv1NkRLb55miS319p8I/if2/UVugJZF74CnxK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiajUHsxY/Z3ffed1vX9YY8emijyHosToapPHi3Dp6E=;
 b=CUNHWioyTmXJAZnT01irw+ZADwQktYtNfjwZHMv2KiMBGUL7KNO5k6mSHf97xmzZMyTszmlRIS2V1B8sBStVN9EkEA9X23dhFbsuMX4xHwm2qhrZ2p1lOxJaK9jrw8pj+SkuZ8J5P3omrb/TWqh8tU0ehPAeSu3gaGIEBes+7lhcAHI2OpfXG+iQiYLgAKkLN6BS8wL31OD1P2xzl7a52Vuf53a76l6JjslSUhkJ9vpUceS/O9CqToUMd8bmVQQT2JuYBixRHeJnGqU2a+lyhcl8BqGhlLPvs+xN/fhBGJrP9zMWpMZKRMxIebQ+XOxuZnwlTI5inc4cQY5YqGjeeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiajUHsxY/Z3ffed1vX9YY8emijyHosToapPHi3Dp6E=;
 b=wrvbwjK6mVV+Xb/fbaMGxoRpVBndJSMnPz5JwvxCsyHNMeo6/S4bNGmM2gl8tKleUuxSWTcwv83m25pn3g+Th53kJgI17dv/tYoUd0aum+3u+au1xAoaOry1fyMobjjUrTFFE0pZPgB2WpaQyz28zTnteaHGlBn0kH31CXRlark=
Received: from SA1PR05CA0023.namprd05.prod.outlook.com (2603:10b6:806:2d2::17)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 11:24:26 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::ca) by SA1PR05CA0023.outlook.office365.com
 (2603:10b6:806:2d2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Thu, 7 Sep 2023 11:24:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 11:24:25 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 06:24:22 -0500
Message-ID: <7f678098-36bb-1543-b0d1-f04322ee702b@amd.com>
Date: Thu, 7 Sep 2023 13:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dm: core: ofnode: Add
 ofnode_read_bootscript_flash()
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Nikhil M Jain
 <n-jain1@ti.com>
References: <08a3e6c09cce13287c69ad370e409e7f1766b406.1693465465.git.michal.simek@amd.com>
In-Reply-To: <08a3e6c09cce13287c69ad370e409e7f1766b406.1693465465.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3f0779-863f-4e46-0bf3-08dbaf94fe3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQ+AXZWiQkkqPN4GkU9kuwcBpJyG0q7vXbqbYfV2jFW6vd56+9S3Y8SVqJt/lFQkQecW4yt4HEQOn9DNrAdk/zB+Lcq7RBXv0g82oQ8pCr4FUVPek1WDrpaDX3tZ02QHYHK5dqC5MQzVyXLeunDJZ3T81TcHi8IoNhhfP9Kv/ElQ3l2xh7vHKz5TdO+5egdrWBmpCarV1qO1kZlQMwwliyNj8ZRhmpG2TyY1n5QGz8nsi7yaO85lM2bD3kdQvjnu9cMOPgI4UPMFZKn6LGP4ikbRXnNsRjnKJhQhE0AQrpm/4Ekw34l2+fPKAS53YmZ/h1ucPc5CVOHSA6DXNm3fhVlAnBiUZpszuYIMdvyxN6oYTz+7YkQ7fq7sRMUnHA1MFE9hcHhVMCTN19T19CSBllL23y2sp0XBxOYHoibNWZI66KRzeNCGgGvxp74DwQxPLQhrsoL4mHu5lUK9jC/C2Tk9N4CHfnphsiVOWoUIxEIpjdhglxMcJfOS4ST3ch4lPoGXgdhyQoaHto4lHDhAq+CS8To5LCRgxrxu/WK293rCEyjl4rjAMWKOKVWdHZsntBSMZMjaTAYHQTi625qGrogH46ZmsE225E3N0XW7D3KMSRnd6OOEJce7X8yG806nCU9LYMSLS/IybnL+qfVoFX6jiQ55wo1A8oQpu2NHpZsuNn52vq5sGtko8hQKacBZCkoJofOG2ZBASTNuDlNH3ZvG+0m5f+SW65g64fUdqUGJbvCUmI1/kEOUvWn02ZNv+27n28e7OrIOKArQx+7fi2DnnO3W/nNhpjyDxQYZBzbNRjskf8Qne85ndPAtOoou
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(8676002)(8936002)(83380400001)(47076005)(426003)(36860700001)(4326008)(16576012)(478600001)(70206006)(70586007)(54906003)(110136005)(336012)(26005)(2616005)(53546011)(6666004)(16526019)(41300700001)(2906002)(40460700003)(31696002)(356005)(316002)(5660300002)(44832011)(81166007)(82740400003)(40480700001)(86362001)(31686004)(36756003)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 11:24:25.7735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3f0779-863f-4e46-0bf3-08dbaf94fe3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
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



On 8/31/23 09:04, Michal Simek wrote:
> ofnode_read_bootscript_flash() reads bootscript address from
> /options/u-boot DT node. bootscr-flash-offset and bootscr-flash-size
> properties are read and values are filled. When bootscr-flash-size is not
> defined, bootscr-flash-offset property is unusable that's why cleaned.
> Both of these properties should be defined to function properly.
> 
> Also add test to cover this new function.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Add missing static inline for !DM case (found by CI loop)
> 
>   arch/sandbox/dts/test.dts |  2 ++
>   drivers/core/ofnode.c     | 34 ++++++++++++++++++++++++++++++++++
>   include/dm/ofnode.h       | 27 +++++++++++++++++++++++++++
>   test/dm/ofnode.c          |  9 +++++++--
>   4 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 84879cc31ac0..cedb66af09e7 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -83,6 +83,8 @@
>   		u-boot {
>   			compatible = "u-boot,config";
>   			bootscr-ram-offset = /bits/ 64 <0x12345678>;
> +			bootscr-flash-offset = /bits/ 64 <0>;
> +			bootscr-flash-size = /bits/ 64 <0x2000>;
>   		};
>   	};
>   
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index d94f0300c30a..023aad06ddc3 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -1588,6 +1588,40 @@ int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
>   	return 0;
>   }
>   
> +int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
> +				 u64 *bootscr_flash_size)
> +{
> +	int ret;
> +	ofnode uboot;
> +
> +	*bootscr_flash_offset = 0;
> +	*bootscr_flash_size = 0;
> +
> +	uboot = ofnode_path("/options/u-boot");
> +	if (!ofnode_valid(uboot)) {
> +		printf("%s: Missing /u-boot node\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ret = ofnode_read_u64(uboot, "bootscr-flash-offset",
> +			      bootscr_flash_offset);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = ofnode_read_u64(uboot, "bootscr-flash-size",
> +			      bootscr_flash_size);
> +	if (ret)
> +		return -EINVAL;
> +
> +	if (!bootscr_flash_size) {
> +		debug("bootscr-flash-size is zero. Ignoring properties!\n");
> +		*bootscr_flash_offset = 0;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   ofnode ofnode_get_phy_node(ofnode node)
>   {
>   	/* DT node properties that reference a PHY node */
> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> index c1afa69e1c56..6f8dc4fb4551 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -1521,6 +1521,27 @@ const char *ofnode_conf_read_str(const char *prop_name);
>    */
>   int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset);
>   
> +/**
> + * ofnode_read_bootscript_flash() - Read bootscr-flash-offset/size
> + *
> + * @bootscr_flash_offset: pointer to 64bit offset where bootscr-flash-offset
> + * property value is stored
> + * @bootscr_flash_size: pointer to 64bit size where bootscr-flash-size property
> + * value is stored
> + *
> + * This reads a bootscr-flash-offset and bootscr-flash-size properties from
> + * the /options/u-boot/ node of the devicetree. bootscr-flash-offset holds
> + * the offset of the boot script file from start of flash. bootscr-flash-size
> + * holds the boot script size in flash. When bootscr-flash-size is not defined,
> + * bootscr-flash-offset property is cleaned.
> + *
> + * This only works with the control FDT.
> + *
> + * Return: 0 if OK, -EINVAL if property is not found or incorrect.
> + */
> +int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
> +				 u64 *bootscr_flash_size);
> +
>   #else /* CONFIG_DM */
>   static inline bool ofnode_conf_read_bool(const char *prop_name)
>   {
> @@ -1542,6 +1563,12 @@ static inline int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *boot
>   	return -EINVAL;
>   }
>   
> +static inline int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
> +					       u64 *bootscr_flash_size)
> +{
> +	return -EINVAL;
> +}
> +
>   #endif /* CONFIG_DM */
>   
>   /**
> diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
> index a4e04f23784f..d84b738ed7c4 100644
> --- a/test/dm/ofnode.c
> +++ b/test/dm/ofnode.c
> @@ -585,14 +585,19 @@ DM_TEST(dm_test_ofnode_conf, 0);
>   
>   static int dm_test_ofnode_options(struct unit_test_state *uts)
>   {
> -	u64 bootscr_address;
> -	u64 bootscr_offset;
> +	u64 bootscr_address, bootscr_offset;
> +	u64 bootscr_flash_offset, bootscr_flash_size;
>   
>   	ut_assertok(ofnode_read_bootscript_address(&bootscr_address,
>   						   &bootscr_offset));
>   	ut_asserteq_64(0, bootscr_address);
>   	ut_asserteq_64(0x12345678, bootscr_offset);
>   
> +	ut_assertok(ofnode_read_bootscript_flash(&bootscr_flash_offset,
> +						 &bootscr_flash_size));
> +	ut_asserteq_64(0, bootscr_flash_offset);
> +	ut_asserteq_64(0x2000, bootscr_flash_size);
> +
>   	return 0;
>   }
>   DM_TEST(dm_test_ofnode_options, 0);

Applied both.

M
