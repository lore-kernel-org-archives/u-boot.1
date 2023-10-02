Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DB6E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 10:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 905B386DE3;
	Mon,  2 Oct 2023 12:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A+qPhToi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A98F86DE3; Mon,  2 Oct 2023 12:16:22 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 893B486DD8
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 12:16:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0Yj6SeAiUF4kTK4iAspIEfzNjd72TblsVuh30ajXxS99CwAt4LwwNjSo6Zc237ZdDf9DBSLgwi9zt38Q0lk4YnXSYr4TIpMUbmqcEt2eSPUxI0Z5B0iq99erlccJp8AjgapRmmrqZRhTBgkc57nd8cZDeFmi5bLYvz/GlzAs3BQfKql5ZB7tH+YODDfqFQTlFULSa6ZGEu9ZJzaipDkyD3KfJ1habGaeIpNJG8r6apJWWdgfQXgz1V1GNxjm8TfnMOZroHGbIVOScCtJuF7VwkaacZ3KTrHqUZ+AbqkdYYMRTf2fYk/buZIzAG+WgsnwcBppb5PA+xWWaIZs4DVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfAdOItDnowNDf4PMq9qBaZRUg7V9wyTJpJLCtYoaOE=;
 b=cAY9xc+kIySkWrFD9KAoo6BMiczr+vrZV4n3jDR8oBRArLxoQwctCPYLhJGPwOo//e2eRQ6I5BHdz/gmnA1lG65RkfLycOp4y9Tixp2EbdUCl4Kq8eCB0oSxLUCJmddjh1xN2SuFZ/W1U12E0fS2+PFaQaucuxUimPl698dVid40bPYTQpM+GHji3IISABCMzatbmLw3vg0frDAVOfJ7heb4sAVXtP7/R15Mm8dqQ3oi853JL+tede4XDmR9zGVXJVuZPdyk3QBygooin2CAHKFREvIOXu/jFG2FtdnNaTqkdlMixha+4E1a4ivd/g5kiBtyjlpY3Gyuvf48nefLUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfAdOItDnowNDf4PMq9qBaZRUg7V9wyTJpJLCtYoaOE=;
 b=A+qPhToiT/aN60Y0DEOC/4/9dPeeqqXC1zudsV56e8iI8bzXEgSmYsQUH7m5fQkoaL/y7FihN3LlOGirWdEaseZUXldZWpUxmM4kSt8duvqR1Gmm44pZdqo99BDmv80TqLDD1fNeCT3S7u8QMVcG2LlZT06a7U50kdYABvKZArI=
Received: from CY8PR10CA0047.namprd10.prod.outlook.com (2603:10b6:930:4b::25)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:312::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 10:16:15 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::cc) by CY8PR10CA0047.outlook.office365.com
 (2603:10b6:930:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Mon, 2 Oct 2023 10:16:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 10:16:14 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 05:16:11 -0500
Message-ID: <e6e4b875-0d01-4c99-84f6-d489a6f12eb0@amd.com>
Date: Mon, 2 Oct 2023 12:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] serial: zynqmp: Fetch baudrate from dtb and update
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
CC: <git@xilinx.com>, Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
References: <20230921112043.3144726-1-venkatesh.abbarapu@amd.com>
 <20230921112043.3144726-3-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230921112043.3144726-3-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: b56685cd-02d7-4c4d-84a7-08dbc3309bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8YCjID7kQMF75Vud+GhY0DAQAQStTh0aoQkezm1K82rvPip3iOta6VYIZih8Ro7zrqtL2p7/S5+ng5fIIuedzmEg8EnB/IW2DV6jS9qw04kZhJEMTziMJHE0yz81bGTLO1m8k18xXsJZSK28uESJyDjmjKU+iddxrzo2oX0UopcSNXJ5wbBvtTKXXJ+IF2N+pQfRRqrEwMas3WcoDaJQ1iEgaN3tMvekpB1i2wGyzmgtNrxtSojJ5syNdLBsk9QPMdPtbj+ONxl01OPzobV8Sh3Wj2gx0IPGupRBQqDwUf6L1cWXLdE5yGjRR/wJ369WBheZV2L6ClF0s+K8eCaHE30JGVQQxYrBUt2txVyedvcQNe1rl7YDRL4Zs+9NAufJQEQcO2R0OeKNk/A+zMlIgB7qFRWoGYxJUyZIDmXSGTwVtHKhK75K1yD5cPorOI6jACmTlzdFQn+dI+jfaB10Xp4u5nlowSTFR6RcMqvreG8NElJo/xOYcM/2SbVEnsmCUPjJBiISfdqQ2R09w9y/YCeIa85EINJHaPdGEJGoPmgZMHzK62qmww3cqGeKAfsDlQtFJXfIXn62rfZMrI6o0uJPVon+d3auqD0AsI6Xs89KS7HhlD3J52echpuOKo/mPEwQxEdDVcByjv2ne74lt380od9he9Ww5jXjTfylT/8z8NjxEc+e5UekT2exfWRq8ANiN/F61ekwP9bhJpuqX1HkHJO8ENtYPgOq2HcVm7Yp96V5L6bRvFU3OLkLIDL4KFui0uU7DCYCOul1JW+JgXBpZhhg+tGVJnuorpUT3H2/Z3JuBY1Tz+w4plx2Sg/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(53546011)(478600001)(83380400001)(336012)(426003)(16526019)(2616005)(26005)(41300700001)(15650500001)(30864003)(2906002)(36756003)(70586007)(16576012)(110136005)(316002)(54906003)(70206006)(5660300002)(4326008)(8936002)(44832011)(8676002)(36860700001)(47076005)(81166007)(31696002)(82740400003)(86362001)(356005)(40480700001)(40460700003)(31686004)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 10:16:14.2231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b56685cd-02d7-4c4d-84a7-08dbc3309bd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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

Hi Simon,

On 9/21/23 13:20, Venkatesh Yadav Abbarapu wrote:
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
> Also add test to cover this new function.
> 
> Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   arch/sandbox/dts/test.dts      |  1 +
>   doc/README.serial_dt_baud      | 41 ++++++++++++++++++++++++++++
>   drivers/core/ofnode.c          | 18 +++++++++++++
>   drivers/serial/Kconfig         |  9 +++++++
>   drivers/serial/serial-uclass.c | 49 ++++++++++++++++++++++++++++++++++
>   include/dm/ofnode.h            | 14 ++++++++--
>   include/env_default.h          |  6 ++++-
>   include/serial.h               |  7 +++++
>   test/dm/serial.c               |  1 +
>   9 files changed, 143 insertions(+), 3 deletions(-)
>   create mode 100644 doc/README.serial_dt_baud
> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index f351d5cb84..deb57f146a 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -1499,6 +1499,7 @@
>   		other-node = "/some-bus/c-test@5";
>   		int-values = <0x1937 72993>;
>   		u-boot,acpi-ssdt-order = <&acpi_test2 &acpi_test1>;
> +		stdout-path = "serial0:115200n8";
>   		chosen-test {
>   			compatible = "denx,u-boot-fdt-test";
>   			reg = <9 1>;
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
> index 067fae2614..a6291d21d2 100644
> --- a/drivers/serial/serial-uclass.c
> +++ b/drivers/serial/serial-uclass.c
> @@ -154,12 +154,61 @@ static void serial_find_console_or_panic(void)
>   }
>   #endif /* CONFIG_SERIAL_PRESENT */
>   
> +/**
> + * check_valid_baudrate() - Check whether baudrate is valid or not
> + *
> + * @baud: baud rate to check
> + * Return: 0 if OK, -ve on error
> + */
> +static int check_valid_baudrate(int baud)
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
> +		char *ptr = (char*)&default_environment[0];
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
> index 42bdf3759c..b21a452a3a 100644
> --- a/include/serial.h
> +++ b/include/serial.h
> @@ -337,6 +337,13 @@ int serial_setconfig(struct udevice *dev, uint config);
>    */
>   int serial_getinfo(struct udevice *dev, struct serial_device_info *info);
>   
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
> diff --git a/test/dm/serial.c b/test/dm/serial.c
> index 37d17a65f1..34b783e062 100644
> --- a/test/dm/serial.c
> +++ b/test/dm/serial.c
> @@ -29,6 +29,7 @@ static int dm_test_serial(struct unit_test_state *uts)
>   					      &dev_serial));
>   
>   	ut_assertok(serial_tstc());
> +	ut_asserteq(115200, fetch_baud_from_dtb());
>   	/*
>   	 * test with default config which is the only one supported by
>   	 * sandbox_serial driver

Can you please review this patch?

Thanks,
Michal
