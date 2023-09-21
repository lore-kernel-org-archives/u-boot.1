Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF5AE70707
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 10:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F21D286A69;
	Thu, 21 Sep 2023 12:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LHiFRTPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6405F86AA8; Thu, 21 Sep 2023 12:09:39 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD3C286A45
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 12:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDKzJhn3I5JhlT7E9yVZy4tikRkKq4WUqJAZfF6PYe0cFZYR6fk8HOes9wB/kUR45p28yfy6IYBStrGfTBCH/aXvA5RNSfoMvJPr1fOMR3q5Qbdsl74ba7zd6hhDp0/Y5zbKAMArlmNgvtq7Y2z0aGL67BLsjOsF6Xe8722w1HRk63SwJQRlC/A+lMzlHlvITGxY7CKTg612IjFmIpkES/Ne3uQpjgDTldlngh7PKTMyrNmoWxZfkpG1u8W2P7Lxpfi8KjjLsk9csr8j+j4lFccXbBPxPKfMdgcq0NG55UaDUaP82seffb7YqFR1/MdUM1jwHhnGHMTi0bd6wVxZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Mq4VYbE0aCatWMR+P3OR6HPYhBZTfPcMkaLIo6UmlI=;
 b=S1/PGHlN3nUjdqB43uGs50J+VUusR/8Nmh+qRoz48GAfvnfwCAwlrVLObawoUYYhgVIS/atvRy8hBOXhdsgsdse6QsEIJLLgU0uwGFDv4jnkpnFOtw+TbQAfwlQy02XCW1abABYFxqNiio+rIn+CkylYRaCP8P2ahMTJPjqMeMg+EpBMabr8b45fgZaa1fTFuMuVpKtA4Mcui4GkKXZshcRiZzuhxm2zAl+ovzolCXsfsx8Avz2GJQYlLPVk6vyvELlY4YxVwuUygxMlaC9dVAUr22RaiyXhsLKVp0HxjnuUTtU/4Uie/IutpybOXCemVjdesY2LpBN+c0Jg3Wy5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mq4VYbE0aCatWMR+P3OR6HPYhBZTfPcMkaLIo6UmlI=;
 b=LHiFRTPRW+s8nnWd2foM9rj2vUp64tmqlPCBvcqvbSWl2b9U3r2sK2LikAIqmc5wQ+MAT1ZPzEkFMATEOvmQArN1y4NTWkLxDZhf+hGwFgdqoGjpNPwWb5Z0oZ2R5GkV16LuKTmS6N+plXlw9VadT76Ck9N4GyiJfL9/xZmfW1s=
Received: from SN4PR0501CA0059.namprd05.prod.outlook.com
 (2603:10b6:803:41::36) by PH0PR12MB7908.namprd12.prod.outlook.com
 (2603:10b6:510:28e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 10:09:32 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:803:41:cafe::52) by SN4PR0501CA0059.outlook.office365.com
 (2603:10b6:803:41::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11 via Frontend
 Transport; Thu, 21 Sep 2023 10:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 10:09:31 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 05:09:29 -0500
Message-ID: <458df3cd-7fdb-4e26-9ab3-76ab3f26cf40@amd.com>
Date: Thu, 21 Sep 2023 12:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] serial: zynqmp: Fetch baudrate from dtb and update
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <git@xilinx.com>, Algapally Santosh Sagar
 <santoshsagar.algapally@amd.com>
References: <20230921042130.21139-1-venkatesh.abbarapu@amd.com>
 <20230921042130.21139-3-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230921042130.21139-3-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|PH0PR12MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b83f32d-a4e0-4742-c23b-08dbba8ad8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5YFoKbAPrjYi3evlAxahyosIdCSPtmwBIGe5UHAk3XzudLQd3h+0UtW9GjU/KaAg0Q6e/lBHnsvYmaeQjkl1bXmi4uRFKnDrvYy02FBe0wPUrcELzigLgpOSn8gJQCU9fnYD8DCHTIFaIEdUxp/CNdWJwv+JUr+94SjjdpBu/9BJ7Lv7dR/5ZSNUSpq6Xrx0KLmQC7FoDMkX7VRsR/XPlaK+oNxWpAOFnv+0monXH/yXjl9TgqJi2bxEqMy6l5JXqmAZPGRJNDIH79gdraBlt0Qe2UIMXyvmhlKWiJTN9vn6PPcGT4ALtmUIk8IJ4zFaFzlyKyhJKrGWkoFs0K0j3467jMVraVhYuhcR5WLrnSCjC9w4a76IzkAjv+FG9CXuD/vJX+yeXLd3mzoyBg1r4KVemt8lF760r5rxycafH5e5AmIc+hTgjFs1befi6vV8/RbWt2rMv4WwjgPHdEpx1f2ysyuHLQeUDOTwDmPs79J7Xi6Y1jLKSM+rC3M7CMPZQQNgDLzwfDOCF8e5Kula8KL4E43uuj5+0ts/KYyusQuS16PwqZxKCqt9nI2fPKGtUdvJSdyDGDo/vQzRUKGAm2cq3dey+xXsRWsVfs3rHGitjkwXRYhJRnFABzML0D4U3HCmThQIr36ZgG+OIbrzzyJU9+EJQJ5dziS+u/j2WevJ5yCSwuYE8rj6eAJuTuLIGLjeqjSvh8S63uLvvTkyYz6Bx20z9MS8VoAF0dpVKgLS6wAqVz3Mzi0Ig4G5LPye/nFPFqLeO61hvgHTg32x8qfoRHwbsCSCiygXCxTGNdticF66+05BiOypuwtjBp/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(31686004)(53546011)(83380400001)(82740400003)(36756003)(356005)(81166007)(40480700001)(31696002)(36860700001)(2906002)(15650500001)(44832011)(47076005)(26005)(40460700003)(8676002)(336012)(426003)(54906003)(4326008)(5660300002)(8936002)(41300700001)(2616005)(110136005)(86362001)(70586007)(16576012)(70206006)(316002)(16526019)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 10:09:31.0538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b83f32d-a4e0-4742-c23b-08dbba8ad8f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7908
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



On 9/21/23 06:21, Venkatesh Yadav Abbarapu wrote:
> From: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
> 
> The baudrate configured in .config is taken by default by serial. If
> change of baudrate is required then the .config needs to changed and
> u-boot recompilation is required or the u-boot environment needs to be
> updated.
> 
> To avoid this, support is added to fetch the baudrate directly from the
> device tree file and update.
> The serial, prints the log with the configured baudrate in the dtb.
> The commit c4df0f6f315c ("arm: mvebu: Espressobin: Set default value for
> $fdtfile env variable") is taken as reference for changing the default
> environment variable.
> 
> The default environment stores the default baudrate value, When default
> baudrate and dtb baudrate are not same glitches are seen on the serial.
> So, the environment also needs to be updated with the dtb baudrate to
> avoid the glitches on the serial.
> 
> Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   doc/README.serial_dt_baud      | 41 ++++++++++++++++++++++++++++++++
>   drivers/core/ofnode.c          | 18 ++++++++++++++
>   drivers/serial/Kconfig         |  9 +++++++
>   drivers/serial/serial-uclass.c | 43 ++++++++++++++++++++++++++++++++++
>   include/dm/ofnode.h            | 14 +++++++++--
>   include/env_default.h          |  6 ++++-
>   include/serial.h               | 15 ++++++++++++
>   7 files changed, 143 insertions(+), 3 deletions(-)
>   create mode 100644 doc/README.serial_dt_baud
> 
> diff --git a/doc/README.serial_dt_baud b/doc/README.serial_dt_baud
> new file mode 100644
> index 0000000000..f8768d0e1b
> --- /dev/null
> +++ b/doc/README.serial_dt_baud
> @@ -0,0 +1,41 @@
> +Fetch serial baudrate from DT
> +-----------------------------
> +
> +To support fetching of baudrate from DT, the following is done:-
> +
> +The baudrate configured in Kconfig symbol CONFIG_BAUDRATE is taken by default by serial.
> +If change of baudrate is required then the Kconfig symbol CONFIG_BAUDRATE needs to
> +changed and U-Boot recompilation is required or the U-Boot environment needs to be updated.
> +
> +To avoid this, add support to fetch the baudrate directly from the device tree file and
> +update the environment.
> +
> +The default environment stores the default baudrate value. When default baudrate and dtb
> +baudrate are not same glitches are seen on the serial.
> +So, the environment also needs to be updated with the dtb baudrate to avoid the glitches on
> +the serial which is enabled by OF_SERIAL_BAUD.
> +
> +The Kconfig SPL_ENV_SUPPORT needs to be enabled to allow patching in SPL.
> +
> +The Kconfig DEFAULT_ENV_IS_RW which is enabled by OF_SERIAL_BAUD with making the environment
> +writable.
> +
> +The ofnode_read_baud() function parses and fetches the baudrate value from the DT. This value
> +is validated and updated to baudrate during serial init. Padding is added at the end of the
> +default environment and the dt baudrate is updated with the latest value.
> +
> +Example:-
> +
> +The serial port options are of the form "bbbbpnf", where "bbbb" is the baud rate, "p" is parity ("n", "o", or "e"),
> +"n" is number of bits, and "f" is flow control ("r" for RTS or omit it). Default is "115200n8".
> +
> +chosen {
> +		bootargs = "earlycon console=ttyPS0,115200 clk_ignore_unused root=/dev/ram0 rw init_fatal_sh=1";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +From the chosen node, stdout-path property is obtained as string.
> +
> +	stdout-path = "serial0:115200n8";
> +
> +The string is parsed to get the baudrate 115200. This string is converted to integer and updated to the environment.
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 8df16e56af..42f51ca93c 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -895,6 +895,24 @@ ofnode ofnode_get_chosen_node(const char *name)
>   	return ofnode_path(prop);
>   }
>   
> +int ofnode_read_baud(void)

I expect Simon will want to have test to cover this too.

> +{
> +	const char *str, *p;
> +	u32 baud;
> +
> +	str = ofnode_read_chosen_string("stdout-path");
> +	if (!str)
> +		return -EINVAL;
> +
> +	/* Parse string serial0:115200n8 */
> +	p = strchr(str, ':');
> +	if (!p)
> +		return -EINVAL;
> +
> +	baud = dectoul(p + 1, NULL);
> +	return baud;
> +}
> +
>   const void *ofnode_read_aliases_prop(const char *propname, int *sizep)
>   {
>   	ofnode node;
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 4d27034c3f..7fdf600dc5 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -24,6 +24,15 @@ config BAUDRATE
>   	  in the SPL stage (most drivers) or for choosing a default baudrate
>   	  in the absence of an environment setting (serial_mxc.c).
>   
> +config OF_SERIAL_BAUD
> +	bool "Fetch serial baudrate from device tree"
> +	depends on DM_SERIAL && SPL_ENV_SUPPORT
> +	select DEFAULT_ENV_IS_RW
> +	help
> +	  Select this to enable fetching and setting of the baudrate
> +	  configured in the DT. Replace the default baudrate with the DT
> +	  baudrate and also set it to the environment.
> +
>   config DEFAULT_ENV_IS_RW
>   	bool "Make default environment as writable"
>   	help
> diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
> index 067fae2614..e5304b397d 100644
> --- a/drivers/serial/serial-uclass.c
> +++ b/drivers/serial/serial-uclass.c
> @@ -154,12 +154,55 @@ static void serial_find_console_or_panic(void)
>   }
>   #endif /* CONFIG_SERIAL_PRESENT */
>   
> +int check_valid_baudrate(int baud)

make this static is called only once in this file.

> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(baudrate_table); ++i) {
> +		if (baud == baudrate_table[i])
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +int fetch_baud_from_dtb(void)

Maybe enough to test this function which also cover ofnode_read_baud too.

> +{
> +	int baud_value, ret;
> +
> +	baud_value = ofnode_read_baud();
> +	ret = check_valid_baudrate(baud_value);
> +	if (ret)
> +		return ret;
> +
> +	return baud_value;
> +}
> +
>   /* Called prior to relocation */
>   int serial_init(void)
>   {
>   #if CONFIG_IS_ENABLED(SERIAL_PRESENT)
>   	serial_find_console_or_panic();
>   	gd->flags |= GD_FLG_SERIAL_READY;
> +
> +	if (IS_ENABLED(CONFIG_OF_SERIAL_BAUD)) {
> +		int ret = 0;
> +		char *ptr = &default_environment[0];

to avoid compilation warning

char *ptr = (char *)&default_environment[0];


> +
> +		/*
> +		 * Fetch the baudrate from the dtb and update the value in the
> +		 * default environment.
> +		 */
> +		ret = fetch_baud_from_dtb();
> +		if (ret != -EINVAL && ret != -EFAULT) {
> +			gd->baudrate = ret;
> +
> +			while (*ptr != '\0' && *(ptr + 1) != '\0')
> +				ptr++;
> +			ptr += 2;
> +			sprintf(ptr, "baudrate=%d", gd->baudrate);
> +		}
> +	}
>   	serial_setbrg();
>   #endif
>   
> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> index 0f38b3e736..f0854cc28d 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -942,12 +942,22 @@ const char *ofnode_read_chosen_string(const char *propname);
>   ofnode ofnode_get_chosen_node(const char *propname);
>   
>   /**
> - * ofnode_read_aliases_prop() - get the value of a aliases property
> + * ofnode_read_baud() - get the baudrate from string value of chosen property
>    *
> - * This looks for a property within the /aliases node and returns its value
> + * This looks for stdout-path property within the /chosen node and parses its
> + * value to return baudrate.
>    *
>    * This only works with the control FDT.
>    *
> + * Return: baudrate value if found, else -ve error code
> + */
> +int ofnode_read_baud(void);
> +
> +/**
> + * ofnode_read_aliases_prop() - get the value of a aliases property
> + *
> + * This looks for a property within the /aliases node and returns its value
> + *
>    * @propname: Property name to look for
>    * @sizep: Returns size of property, or `FDT_ERR_...` error code if function
>    *	returns NULL
> diff --git a/include/env_default.h b/include/env_default.h
> index 227cad7c34..2ca4a087d3 100644
> --- a/include/env_default.h
> +++ b/include/env_default.h
> @@ -42,7 +42,7 @@ const char default_environment[] = {
>   #if defined(CONFIG_BOOTDELAY)
>   	"bootdelay="	__stringify(CONFIG_BOOTDELAY)	"\0"
>   #endif
> -#if defined(CONFIG_BAUDRATE) && (CONFIG_BAUDRATE >= 0)
> +#if !defined(CONFIG_OF_SERIAL_BAUD) && defined(CONFIG_BAUDRATE) && (CONFIG_BAUDRATE >= 0)
>   	"baudrate="	__stringify(CONFIG_BAUDRATE)	"\0"
>   #endif
>   #ifdef	CONFIG_LOADS_ECHO
> @@ -118,6 +118,10 @@ const char default_environment[] = {
>   #endif
>   #ifdef	CFG_EXTRA_ENV_SETTINGS
>   	CFG_EXTRA_ENV_SETTINGS
> +#endif
> +#ifdef CONFIG_OF_SERIAL_BAUD
> +	/* Padding for baudrate at the end when environment is writable */
> +	"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
>   #endif
>   	"\0"
>   #else /* CONFIG_USE_DEFAULT_ENV_FILE */
> diff --git a/include/serial.h b/include/serial.h
> index 42bdf3759c..31a97ca9cf 100644
> --- a/include/serial.h
> +++ b/include/serial.h
> @@ -337,6 +337,21 @@ int serial_setconfig(struct udevice *dev, uint config);
>    */
>   int serial_getinfo(struct udevice *dev, struct serial_device_info *info);
>   
> +/**
> + * check_valid_baudrate() - Check whether baudrate is valid or not
> + *
> + * @baud: baud rate to check
> + * Return: 0 if OK, -ve on error
> + */

Move this kernel-doc to drivers/serial/serial-uclass.c

> +int check_valid_baudrate(int baud);

and remove this line.

> +
> +/**
> + * fetch_baud_from_dtb() - Fetch the baudrate value from DT
> + *
> + * Return: baudrate if OK, -ve on error
> + */
> +int fetch_baud_from_dtb(void);
> +
>   void atmel_serial_initialize(void);
>   void mcf_serial_initialize(void);
>   void mpc85xx_serial_initialize(void);

M
