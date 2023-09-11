Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B81EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 13:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3225286E1F;
	Mon, 11 Sep 2023 15:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nx0K9Eua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B5986E1D; Mon, 11 Sep 2023 15:27:39 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A5A586E28
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 15:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuBhoc3lZJamFWVuXQjFZXa0ZJVosCT64Oh+0z0KV9ek3NnX+Eb8A13Xfnt8CLJ6M1NS6vmYS3bNla/l25iU+7mZ9v25fdavWP5uLHu3Oo9D38YBMwcWrvAflRwoQ70VuiehNeBMDj+8bCaa3RDPLfhOVGGIq9R3cEj13tBRitCsJdXLza2aR3tcw0z1MjHK8ucLlE6Ve/p4NXr7fEZD+p0VhHBhLidHkBPlRcghev6YjtQ3lZU9Y+ItPhA2F7iX7j65KD6xRLum94TMENVt1lxxz9sfuXMg2dxraWTV0/rUwCPcAtlxmAOBZW8t3qUVgIO+lqjjlcyOb6hEy/DdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqwUnNdSWUYrTPdD8wSxORtEG63d7ai8pc4O1+GUHWY=;
 b=SD8oehvF26AxVGsGi4PuRgjdpA3UOoggJ7MhCwU+Rx54JSGIKn0kebCDo9JPSM/QTd98p6zvy6TD0ueXlRaiYBW1dBTh4sC75vhFWZrauo5ON+ND8Bv7u6bgUDP74Ry930CvUFS0YfgyaT2qPpvm4io3qqsrqMApM8EM87oYfc/O4bNbPOoF+bjlgUaXYL51U9nMhZfT1vflxcRraFdlKmw+p68UZtU0zYSNfS/jGQ2NZBymXR3XuzFSKLTPK0xzVS9jeEEVQJZA5cSwPxzC0L9+10cy2IF1uyyNxweg0NKZU/OaUBeqd7w7YXdjvgQDilMQQtWYy7UmYwQGgwdkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqwUnNdSWUYrTPdD8wSxORtEG63d7ai8pc4O1+GUHWY=;
 b=nx0K9EuatAESjfesR/wId7G76Zo6WY5EOZN9kxYJH1SQ4GnNO/GsoE/I5vEh7XsGY8e1C4JXAXBPc7as1W8D9eft61Ne5s4QUYAIk+PHdAAvIn+8P77Y+B3Q7nZWEPvYuOfGj+dPUK4Kz3mV938M+BTC66IsQgfYRRQ7rW+iJzk=
Received: from CY8PR12CA0005.namprd12.prod.outlook.com (2603:10b6:930:4e::13)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 13:27:31 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::9c) by CY8PR12CA0005.outlook.office365.com
 (2603:10b6:930:4e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 13:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 13:27:31 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 08:27:29 -0500
Message-ID: <3728314e-6ef0-4986-9b68-c0a6f3407271@amd.com>
Date: Mon, 11 Sep 2023 15:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Guard distro boot variable generation
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
References: <570c51435da59831ec245cddceda078afa58a550.1693913398.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <570c51435da59831ec245cddceda078afa58a550.1693913398.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|SA0PR12MB4381:EE_
X-MS-Office365-Filtering-Correlation-Id: 30954756-f9ac-4ceb-bfdb-08dbb2cad9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ioBz57UbztZAGvl8n5VuDdmodgebRh00TJ/f9C2jFoiDFSmR3MvoyhwVF24tYVScMzqu8jFvYUg33Cj8syfmHFbbjvSS6ihs6pSJsP7s82miuJNDs2eeoCyWDM4dDquJzrx5mnPe/feDlPXh7D3LEXbN29G2p0mzCAqJq4TaA2IVbWgjyB6d5ibPeERHH/l9+2KKQdrNLR7xTdJtjYsZaN7gVofiNKsLo7D/V1K9VPoLT+gmbEYAnVXN8vd1Zl2jN+QaA5a2DnN4jSQWU4gIkI4si6Flv7cHGRQWKUFJlf5XcCjSEHI21igGoJQHockWVay3pqj+2xK1+sXiY41zTG5uzYCcBIkzMUuho4Un7P7jCSpCINE9kmgWbwNXqm0dM44JLNgUxacUbVqvaQVUMt/rQjPCklLF096uIeeJ4sdtBsDIjfttaGKk/VZ239TaZ1puE+xm5baaFSM5AMJ+XZN+NhHVn+9LKzNs+J0w7xHsXE1/xxjKfATW+NVvdNFMa+cazcCA0q9HCosRlGiKPldIeqAaSP3PMhsWaUkLXJ4fPM6kukAvXi5qVsqtC7SYTl/AH2jkudJeOislX6xBwqAw5rV1pDEb+f2GMw4KoPE73IPFRQJO4PlnIXvUYTNRM2Om+Y+5r98xsHxXhpobV2pCYH/GuTe+vp2aMCerIJdpBULXrt7USuOoN/lrfqteRaSE4oma4mCUsTuqzz/aUTQPsZLvDw7q2N40kghEY7czUVbhx7JDxpoQP7o1AGYaneTNF9/n9ZtOiHRKcWt50mSmny/TfEHK4Y8XkWmx+cvOk/zMHhSfXe2ovKWossOI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199024)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(31686004)(81166007)(53546011)(110136005)(356005)(36860700001)(40460700003)(31696002)(36756003)(40480700001)(82740400003)(86362001)(47076005)(2616005)(26005)(336012)(16526019)(426003)(83380400001)(478600001)(2906002)(41300700001)(70586007)(70206006)(316002)(8936002)(8676002)(5660300002)(44832011)(16576012)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 13:27:31.2255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30954756-f9ac-4ceb-bfdb-08dbb2cad9fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
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



On 9/5/23 13:30, Michal Simek wrote:
> When distro boot is disabled there is no reason to generate variables for
> it. Also do not update boot_targets variable because it would be unused.
> 
> It is useful for example when standard boot is enabled and distro boot
> is disabled.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/versal-net/board.c     | 32 ++++++++++++-----
>   board/xilinx/versal/board.c         | 31 +++++++++++-----
>   board/xilinx/zynqmp/zynqmp.c        | 56 +++++++++++++++++------------
>   include/configs/xilinx_versal.h     |  6 ++++
>   include/configs/xilinx_versal_net.h |  6 ++++
>   include/configs/xilinx_zynqmp.h     |  6 ++++
>   6 files changed, 97 insertions(+), 40 deletions(-)
> 
> diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
> index 7ad299f3a231..c18be0c26c99 100644
> --- a/board/xilinx/versal-net/board.c
> +++ b/board/xilinx/versal-net/board.c
> @@ -194,7 +194,7 @@ static u8 versal_net_get_bootmode(void)
>   	return bootmode;
>   }
>   
> -int board_late_init(void)
> +static int boot_targets_setup(void)
>   {
>   	u8 bootmode;
>   	struct udevice *dev;
> @@ -205,14 +205,6 @@ int board_late_init(void)
>   	char *new_targets;
>   	char *env_targets;
>   
> -	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
> -		debug("Saved variables - Skipping\n");
> -		return 0;
> -	}
> -
> -	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
> -		return 0;
> -
>   	bootmode = versal_net_get_bootmode();
>   
>   	puts("Bootmode: ");
> @@ -320,6 +312,28 @@ int board_late_init(void)
>   
>   		env_set("boot_targets", new_targets);
>   	}
> +
> +	return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +	int ret;
> +
> +	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
> +		debug("Saved variables - Skipping\n");
> +		return 0;
> +	}
> +
> +	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
> +		ret = boot_targets_setup();
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return board_late_init_xilinx();
>   }
>   
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 982a8b3779f1..e4bdd5d7a38b 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -126,7 +126,7 @@ static u8 versal_get_bootmode(void)
>   	return bootmode;
>   }
>   
> -int board_late_init(void)
> +static int boot_targets_setup(void)
>   {
>   	u8 bootmode;
>   	struct udevice *dev;
> @@ -137,14 +137,6 @@ int board_late_init(void)
>   	char *new_targets;
>   	char *env_targets;
>   
> -	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
> -		debug("Saved variables - Skipping\n");
> -		return 0;
> -	}
> -
> -	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
> -		return 0;
> -
>   	bootmode = versal_get_bootmode();
>   
>   	puts("Bootmode: ");
> @@ -247,6 +239,27 @@ int board_late_init(void)
>   		env_set("boot_targets", new_targets);
>   	}
>   
> +	return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +	int ret;
> +
> +	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
> +		debug("Saved variables - Skipping\n");
> +		return 0;
> +	}
> +
> +	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
> +		ret = boot_targets_setup();
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return board_late_init_xilinx();
>   }
>   
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 0b6d4e57078b..f16280308483 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -384,7 +384,7 @@ static int set_fdtfile(void)
>   	return 0;
>   }
>   
> -int board_late_init(void)
> +static int boot_targets_setup(void)
>   {
>   	u8 bootmode;
>   	struct udevice *dev;
> @@ -394,27 +394,6 @@ int board_late_init(void)
>   	const char *mode = NULL;
>   	char *new_targets;
>   	char *env_targets;
> -	int ret, multiboot;
> -
> -#if defined(CONFIG_USB_ETHER) && !defined(CONFIG_USB_GADGET_DOWNLOAD)
> -	usb_ether_init();
> -#endif
> -
> -	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
> -		debug("Saved variables - Skipping\n");
> -		return 0;
> -	}
> -
> -	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
> -		return 0;
> -
> -	ret = set_fdtfile();
> -	if (ret)
> -		return ret;
> -
> -	multiboot = multi_boot();
> -	if (multiboot >= 0)
> -		env_set_hex("multiboot", multiboot);
>   
>   	bootmode = zynqmp_get_bootmode();
>   
> @@ -525,6 +504,39 @@ int board_late_init(void)
>   		free(new_targets);
>   	}
>   
> +	return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +	int ret, multiboot;
> +
> +#if defined(CONFIG_USB_ETHER) && !defined(CONFIG_USB_GADGET_DOWNLOAD)
> +	usb_ether_init();
> +#endif
> +
> +	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
> +		debug("Saved variables - Skipping\n");
> +		return 0;
> +	}
> +
> +	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
> +		return 0;
> +
> +	ret = set_fdtfile();
> +	if (ret)
> +		return ret;
> +
> +	multiboot = multi_boot();
> +	if (multiboot >= 0)
> +		env_set_hex("multiboot", multiboot);
> +
> +	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
> +		ret = boot_targets_setup();
> +		if (ret)
> +			return ret;
> +	}
> +
>   	reset_reason();
>   
>   	return board_late_init_xilinx();
> diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
> index 98792aba7cce..b634bb1ab705 100644
> --- a/include/configs/xilinx_versal.h
> +++ b/include/configs/xilinx_versal.h
> @@ -43,6 +43,8 @@
>   	"ramdisk_addr_r=0x02100000\0" \
>   	"script_size_f=0x80000\0"
>   
> +#if defined(CONFIG_DISTRO_DEFAULTS)
> +
>   #if defined(CONFIG_MMC_SDHCI_ZYNQ)
>   # define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0) func(MMC, mmc, 1)
>   #else
> @@ -124,6 +126,10 @@
>   
>   #include <config_distro_bootcmd.h>
>   
> +#else /* CONFIG_DISTRO_DEFAULTS */
> +# define BOOTENV
> +#endif /* CONFIG_DISTRO_DEFAULTS */
> +
>   /* Initial environment variables */
>   #ifndef CFG_EXTRA_ENV_SETTINGS
>   #define CFG_EXTRA_ENV_SETTINGS \
> diff --git a/include/configs/xilinx_versal_net.h b/include/configs/xilinx_versal_net.h
> index e17b44093548..2b441da91a10 100644
> --- a/include/configs/xilinx_versal_net.h
> +++ b/include/configs/xilinx_versal_net.h
> @@ -57,6 +57,8 @@
>   	"ramdisk_addr_r=0x02100000\0" \
>   	"script_size_f=0x80000\0"
>   
> +#if defined(CONFIG_DISTRO_DEFAULTS)
> +
>   #if defined(CONFIG_MMC_SDHCI_ZYNQ)
>   # define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0) func(MMC, mmc, 1)
>   #else
> @@ -125,6 +127,10 @@
>   
>   #include <config_distro_bootcmd.h>
>   
> +#else /* CONFIG_DISTRO_DEFAULTS */
> +# define BOOTENV
> +#endif /* CONFIG_DISTRO_DEFAULTS */
> +
>   /* Initial environment variables */
>   #ifndef CFG_EXTRA_ENV_SETTINGS
>   #define CFG_EXTRA_ENV_SETTINGS \
> diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
> index 51f0a4253406..c57ab14d1b97 100644
> --- a/include/configs/xilinx_zynqmp.h
> +++ b/include/configs/xilinx_zynqmp.h
> @@ -63,6 +63,8 @@
>   	"stdout=serial,vidconsole\0" \
>   	"stderr=serial,vidconsole\0" \
>   
> +#if defined(CONFIG_DISTRO_DEFAULTS)
> +
>   #if defined(CONFIG_MMC_SDHCI_ZYNQ)
>   # define BOOT_TARGET_DEVICES_MMC(func)	func(MMC, mmc, 0) func(MMC, mmc, 1)
>   #else
> @@ -174,6 +176,10 @@
>   
>   #include <config_distro_bootcmd.h>
>   
> +#else /* CONFIG_DISTRO_DEFAULTS */
> +# define BOOTENV
> +#endif /* CONFIG_DISTRO_DEFAULTS */
> +
>   /* Initial environment variables */
>   #ifndef CFG_EXTRA_ENV_SETTINGS
>   #define CFG_EXTRA_ENV_SETTINGS \

Applied.
M
