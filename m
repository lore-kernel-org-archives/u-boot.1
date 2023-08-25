Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357D3C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 07:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84ADA86961;
	Fri, 25 Aug 2023 09:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nrm/M2iF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B6F86A3D; Fri, 25 Aug 2023 09:16:59 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB968655E
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 09:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBmYA4Ozc39dIRX0H1YGj618r0Q2TMMlPzsgA5lX+p1DGAL8cYkixl4f84wlQHKAeeQcuVhKjo30VyRnEH+Cm8Gwf/mhf7kepP46hOKlmI2iNYXMfOMnXw+spVDoRPS1tcUj7cKPsX4TXEY1NBP87qenea+JzuPUALHsnvaP2gRNy+8Chh4jJVtUpxhztNN28QyG9oM8ADAabZWKHjeM9Tg1bOd0qqW8k4RvRp9SZcu8hB3nBPmfdH5WIoOW1j2uiSxXUkgCz8ZyTE42TgYqrYv13k2SwvEMoHo0K12aovST8p5mhn85mDAOrQxZ5fEa1/bK95+69VNrcRrGlmu6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Afb1StWXai8pIUaSZGHhywD0tyGbIkvIIW1SftUFjTM=;
 b=blCva/ZmzPjF09cp5QRju08MMXIucty9wxk71Ax/SupnNSOp2wCRkC5M1vSxxN8rJWq4fviwSZODXrBNhXEo1bKN6LafiF0F+JSZ4IkCOm5gfrcbhmR99XvBErRZ3wwZXMpN9Msl4E7oqafZbQq2U+Z/pk/drBMtXcKMf42xufZIEBnJAi8D4Rogubg/hm5YpAXqntPvJReWA8BRKR8c3+5NKKRlst5P2blom1SEtkZPFP8rr7MsTL3v0KlE6pe+w4wCwSjLpL4zODapgyMPYvYU2OZTySe/MmGzFnYhepoAV52Q+EPu+RvR/UJ6d99K9Vb8+x0GxHx/KdEc7yuHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Afb1StWXai8pIUaSZGHhywD0tyGbIkvIIW1SftUFjTM=;
 b=Nrm/M2iFWvD7wafDPePgnOtDz6hZ75CE3diICvM0ZAGc7U/ZB+545ZUfzjV9SqrSnzMBqkaWMq2FL10mlriVF6V9GnV7W84HJUf/tHjV1pi0gRlBmcuvI2FlehIeKNNynchEtT8ier9UTwEaPW2GcVotuR3rA1yDH3+IBAw94yQ=
Received: from CY5PR19CA0105.namprd19.prod.outlook.com (2603:10b6:930:83::18)
 by BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 07:16:53 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::6) by CY5PR19CA0105.outlook.office365.com
 (2603:10b6:930:83::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 07:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023 07:16:52 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 25 Aug
 2023 02:16:46 -0500
Message-ID: <a808475c-fd1e-275f-5726-2f6335368065@amd.com>
Date: Fri, 25 Aug 2023 09:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] xilinx: Remove scriptaddr from config files and move it
 to DT
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>
CC: Harini Katakam <harini.katakam@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Piyush Mehta <piyush.mehta@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Robert Hancock
 <robert.hancock@calian.com>
References: <d36ffeb00ed8f0ca4bb67d4983d1852d01ade637.1691067102.git.michal.simek@amd.com>
In-Reply-To: <d36ffeb00ed8f0ca4bb67d4983d1852d01ade637.1691067102.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BL0PR12MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f28d8de-0d14-43c5-5def-08dba53b41d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjg7H2Jc08/P+nHzei/KQwG+BkDNZ9NB5KhloIw60VXENpL9BWZ+bRciQcLA/os7mneE8BsyPgmSNTHcllN5FP/W5W3GrckKHTgEQIeDXxw3vC91b9q/emkoQA86Fs8NLZdLHGC0aS8XbuubNcG4H8krH42dzNOuP2+fJ3v7kHiG5PRNekSjvDxzV0wLGaX4s348cqq3atQNydkW+iopKYg3HP3EjLbY0tPUW9yg8Aw9bKPA4WSV8HHTf5MVIVOt7Modc1QCzKhLOJ6sigjwMGeWbx5bQWxiCC7VVXFFLcGUkZjhk/lu7NXI0AmU63C/fiiz6CsIZ7d/6GPiE5s6KC+vxO8XhULGY8ZKoGwIOjkV0hu4Z0s+WwI5fwOkDiYIDy+9+zg8ACrVPcEN0pCjtabj9/lJLWWK12pyOFFdhYeN4hQavHBpXfJ31L+6m3jHDmfo0PKaxaECqrsJ4eYvK2q6YXSAHUfrxMlPoe6pUTOif3g7sfHlMb+zcsJpkVw1O/nTQLdm6wFPD8tEgA5AhSI0LNNdh4JTjAov8JvBvQFUvcMr8stgz36yHRqEdPgR2n46LqnfE/hUCxHXNr+W1ixQOZj6e01uk2WH3488hwgbsMc2JuJjvY2bBdNVO/l5NsqA1ziUBikBhxQKHeTtAMN9HqeM+jB+UIgbEVcpzwH9kxvB0XETpu7kijoEk3GwZHfmzq6cRAgGpl1u1GI7WsoW1Mq6Wl/D6TRgTt/0gU602tuo3cSL1wP6RBRsGgxfujd1nEatpUTAia+PnAfQIp/KP8cJWrcaoSOtrQL6sQSEbpbX+Ip1Sgjgn3yuxapnJ7v7T2H0mosIa9wPVrQEDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(40460700003)(8676002)(4326008)(8936002)(54906003)(31696002)(41300700001)(53546011)(316002)(36756003)(110136005)(70586007)(70206006)(86362001)(16576012)(40480700001)(47076005)(26005)(478600001)(16526019)(336012)(36860700001)(44832011)(83380400001)(31686004)(966005)(2906002)(2616005)(426003)(5660300002)(36900700001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 07:16:52.7988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f28d8de-0d14-43c5-5def-08dba53b41d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4882
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



On 8/3/23 14:51, Michal Simek wrote:
> Define bootscript address in RAM via DT property and remove it from config
> file. Adding default value to common DTSI. Platform DT description can
> remove this property or rewrite it.
> 
> In Zynq case scriptaddr property was defined twice for no reason.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> The patch is based on
> https://lore.kernel.org/r/b37aec1460d93727a9065766aa5f50fa356ae5aa.1690873880.git.michal.simek@amd.com
> and
> https://lore.kernel.org/r/b77352af92102dfad2e12a49a7680f5f64f8ee31.1690873880.git.michal.simek@amd.com
> ---
>   arch/arm/dts/xilinx-versal-net-virt.dts | 6 ++++++
>   arch/arm/dts/xilinx-versal-virt.dts     | 6 ++++++
>   arch/arm/dts/zynq-7000.dtsi             | 7 +++++++
>   arch/arm/dts/zynqmp.dtsi                | 7 +++++++
>   include/configs/xilinx_versal.h         | 1 -
>   include/configs/xilinx_versal_net.h     | 1 -
>   include/configs/xilinx_zynqmp.h         | 1 -
>   include/configs/zynq-common.h           | 2 --
>   8 files changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/xilinx-versal-net-virt.dts b/arch/arm/dts/xilinx-versal-net-virt.dts
> index c99257cb0834..f5eca843b646 100644
> --- a/arch/arm/dts/xilinx-versal-net-virt.dts
> +++ b/arch/arm/dts/xilinx-versal-net-virt.dts
> @@ -8,4 +8,10 @@
>   /dts-v1/;
>   
>   / {
> +	options {
> +		u-boot {
> +			compatible = "u-boot,config";
> +			bootscr-address = /bits/ 64 <0x20000000>;
> +		};
> +	};
>   };
> diff --git a/arch/arm/dts/xilinx-versal-virt.dts b/arch/arm/dts/xilinx-versal-virt.dts
> index 733e532f9874..3ea3cb1bdd3c 100644
> --- a/arch/arm/dts/xilinx-versal-virt.dts
> +++ b/arch/arm/dts/xilinx-versal-virt.dts
> @@ -8,4 +8,10 @@
>   /dts-v1/;
>   
>   / {
> +	options {
> +		u-boot {
> +			compatible = "u-boot,config";
> +			bootscr-address = /bits/ 64 <0x20000000>;
> +		};
> +	};
>   };
> diff --git a/arch/arm/dts/zynq-7000.dtsi b/arch/arm/dts/zynq-7000.dtsi
> index 8c6eafec1d4e..fb61fe98e3de 100644
> --- a/arch/arm/dts/zynq-7000.dtsi
> +++ b/arch/arm/dts/zynq-7000.dtsi
> @@ -11,6 +11,13 @@
>   	#size-cells = <1>;
>   	compatible = "xlnx,zynq-7000";
>   
> +	options {
> +		u-boot {
> +			compatible = "u-boot,config";
> +			bootscr-address = /bits/ 64 <0x3000000>;
> +		};
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 1632be843b15..355f360281b5 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -22,6 +22,13 @@
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>   
> +	options {
> +		u-boot {
> +			compatible = "u-boot,config";
> +			bootscr-address = /bits/ 64 <0x20000000>;
> +		};
> +	};
> +
>   	cpus {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
> index a403999977e4..98792aba7cce 100644
> --- a/include/configs/xilinx_versal.h
> +++ b/include/configs/xilinx_versal.h
> @@ -40,7 +40,6 @@
>   	"kernel_size_r=0x10000000\0" \
>   	"kernel_comp_addr_r=0x30000000\0" \
>   	"kernel_comp_size=0x3C00000\0" \
> -	"scriptaddr=0x20000000\0" \
>   	"ramdisk_addr_r=0x02100000\0" \
>   	"script_size_f=0x80000\0"
>   
> diff --git a/include/configs/xilinx_versal_net.h b/include/configs/xilinx_versal_net.h
> index 613cce46f904..e17b44093548 100644
> --- a/include/configs/xilinx_versal_net.h
> +++ b/include/configs/xilinx_versal_net.h
> @@ -54,7 +54,6 @@
>   	"kernel_size_r=0x10000000\0" \
>   	"kernel_comp_addr_r=0x30000000\0" \
>   	"kernel_comp_size=0x3C00000\0" \
> -	"scriptaddr=0x20000000\0" \
>   	"ramdisk_addr_r=0x02100000\0" \
>   	"script_size_f=0x80000\0"
>   
> diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
> index 74264b7bee8b..51f0a4253406 100644
> --- a/include/configs/xilinx_zynqmp.h
> +++ b/include/configs/xilinx_zynqmp.h
> @@ -57,7 +57,6 @@
>   	"kernel_size_r=0x10000000\0" \
>   	"kernel_comp_addr_r=0x30000000\0" \
>   	"kernel_comp_size=0x3C00000\0" \
> -	"scriptaddr=0x20000000\0" \
>   	"ramdisk_addr_r=0x02100000\0" \
>   	"script_size_f=0x80000\0" \
>   	"stdin=serial\0" \
> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
> index e372e903170a..553bb1b45b69 100644
> --- a/include/configs/zynq-common.h
> +++ b/include/configs/zynq-common.h
> @@ -172,12 +172,10 @@
>   /* Default environment */
>   #ifndef CFG_EXTRA_ENV_SETTINGS
>   #define CFG_EXTRA_ENV_SETTINGS	\
> -	"scriptaddr=0x20000\0"	\
>   	"script_size_f=0x40000\0"	\
>   	"fdt_addr_r=0x1f00000\0"        \
>   	"pxefile_addr_r=0x2000000\0"    \
>   	"kernel_addr_r=0x2000000\0"     \
> -	"scriptaddr=0x3000000\0"        \
>   	"ramdisk_addr_r=0x3100000\0"    \
>   	BOOTENV
>   #endif

Applied.
M
