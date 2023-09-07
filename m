Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C03AEB8FB2
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 11:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79D42869A0;
	Thu,  7 Sep 2023 13:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o1esxRuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 145DC86997; Thu,  7 Sep 2023 13:23:57 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2488B868BC
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 13:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wueh/5hEjKM1Zg797Xq80htQbvEQZvdfWawF/Oaa5eYZAokOAVrlBZLg6v0JlDoyBpvuFD7Ooa84Z/jvRJ+oXRcK+zxCHoRIMFiM0uGg+RL34XZUjPyV6T/GhVu+l9KUvW7Vzcjc0DZvhStVUNi45KsdeSsuQ3Bof0+KaPW317q9LPX4NemLwDszw1rVooUi8d19c+rGe+f8QEYGycXJZafzBXrrpK7DAaGlSzpC8jglH0cRgPQZZStToZAP2HatyHgOwtz5I/ym1sMDJxWbu0r/F9jL68TCasP0NDudmtKLWWDwhb7EV66fRuZjZHTTtyJdysJVud77aSZAp+Autg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ai5Jia2tFV+CkHG/t8AHZK1jDgSqKmS0woLMdgAgIXg=;
 b=Ehtc8FDuxdUWifBjGiCQTfWMVk7QpB3eq5kE8NA4Ogqz9Ca2x36FrBw0ljQDS2bZal9Kib+A3kvcbbjsRcDrKEI5Ricnv9IpBvOuwEuDSlUGlMutgrt9b1oKYsJ7zcjR1yLWp3yl+6ODKcCvUn+uRxSM8uQaNd1Y3y1hHltwmEcdNeK9aPlVcHp5CujLPrRQX9YABktjmHhET8Ka7geowqVTvirNv7BiWHYUS7h0DoJ83LwBD2Wq40HPQ+Vj81ql8xGcL2sq9ON/y81xpW0zvm9eN1nLFEjz16nBeV17ETV+fpfCoxnv7WJv0WrIMfl3JMsCC2Rf5CO45pQ9f7P88g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai5Jia2tFV+CkHG/t8AHZK1jDgSqKmS0woLMdgAgIXg=;
 b=o1esxRuccojBuMo6mmFSzyy4HEP8GsF2jx/kTpzklSQglgcRl0Rogq/gbZhA/6aShmy7XcMEvv2EN5j5S02onmCaaYJYVWQQ77f2MTcNR/xSisym9muxfEammJMrO6o4nGalngA32pqybt+1XFMIGStVzugxrAHMTjB+N+FCSrw=
Received: from SA1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::20)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 11:23:50 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::6f) by SA1P222CA0019.outlook.office365.com
 (2603:10b6:806:22c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30 via Frontend
 Transport; Thu, 7 Sep 2023 11:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Thu, 7 Sep 2023 11:23:50 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 06:23:45 -0500
Message-ID: <9e52f99f-c678-d3c5-74b5-529a549bc425@amd.com>
Date: Thu, 7 Sep 2023 13:23:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] arm64: zynqmp: Add output-enable pins to SOMs
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Neal Frager <neal.frager@amd.com>
References: <7ecd98b2a302c5c6628e0234482f23c38e721fd6.1693492064.git.michal.simek@amd.com>
In-Reply-To: <7ecd98b2a302c5c6628e0234482f23c38e721fd6.1693492064.git.michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fc4f94-39b1-48f2-c516-08dbaf94e969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAxUdnq2rJ+7qHdMZypNeJzr4KFeaQ835Orp+d0RWZpA9bgsLwoEn8hg+RRku4/Ui5EyuR3WRO2Uj6vymy4lb4HYDylcwsUXYRAcYuUfIP3qKi8GXjpaonqM0sv9L4IPdqpJTcdjtnNTtgenYVAkn8w24qIn3bKJVSPjvdfXqCewOwa+BDxQNXUW996mxZJhWOm3IGAICGDCHXAzbUJdJ98s/nRImm0r9Y6ryV35otyCCRf1qGD8KCgs+XNhz19qcY7v63ZVGRoigRSpsFlnDLyGLc46LgpFNAqB6yDQ58dX/Iy0alCSg/r2QLrfGCYIP2te8NlB81K7AqoIHusQPWvSwVg+Pdl86I+s+FaT3tujZjmezKI5wK7EgP5P9Nvva5f8Qi62BDh8GuHfWoMdpiZqC1oQg4XyS2y3L/wXMNTcMLwyHhO3S3PpwBls+sZeltwo/syI/qkXr0a2Mdt6Jb0ohZHa+ZGSk0ANRgj003nhQdZ4+mHVEUVh5iqEevrmd+kZqOZuKOCdSEgx/SYju3t3m9xDtEJyPeuTNMAlcxTqn0N0C01o80Biy74QLlLzTtr+k1CphjHqR5iPfFQRejQ2Z3+IhqBBO9hLWDGifFezZb8YPvd3wPdGnrGA55pDXkOuAZpVsbOgVsuEGX8PDgXP0faaabLLQK12LktP4v0P61DqmL0yddjpjIfvgAcpe1kADlUeNjiQemP7OVlhrpVGIywiKsw4X5DcOiVu0GjClB81IbMSJPwolVhUiyUCmbBkuS8/h/DfpIJDhCJLoEnRsHOWBa3qCUMLV3q+o2HRAyn70/eIBDirOkrITufo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(346002)(136003)(39860400002)(1800799009)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(41300700001)(40460700003)(16526019)(86362001)(356005)(82740400003)(81166007)(31696002)(478600001)(2616005)(83380400001)(53546011)(26005)(426003)(40480700001)(47076005)(36860700001)(336012)(316002)(110136005)(36756003)(70206006)(16576012)(2906002)(70586007)(44832011)(8676002)(5660300002)(31686004)(4326008)(8936002)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 11:23:50.8475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fc4f94-39b1-48f2-c516-08dbaf94e969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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



On 8/31/23 16:27, Michal Simek wrote:
> From: Neal Frager <neal.frager@amd.com>
> 
> Now that the zynqmp pinctrl driver supports the tri-state registers, make
> sure that the pins requiring output-enable are configured appropriately for
> SOMs.
> 
> Without it, all tristate setting for MIOs, which are not related to SOM
> itself, are using default configuration which is not correct setting.
> It means SDs, USBs, ethernet, etc. are not working properly.
> 
> In past it was fixed through calling tristate configuration via bootcmd:
> usb_init=mw 0xFF180208 2020
> kv260_gem3=mw 0xFF18020C 0xFC0 && gpio toggle gpio@ff0a000038 && \
>    gpio toggle gpio@ff0a000038
> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - update commit message
> - add also fixes for kr260-revB and kv260-revA/B
> 
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dts | 6 ++++++
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dts | 6 ++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dts | 5 +++++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dts | 5 +++++
>   4 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dts b/arch/arm/dts/zynqmp-sck-kr-g-revA.dts
> index d318773bd9d6..30a0230d4767 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dts
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dts
> @@ -250,6 +250,7 @@
>   		conf-tx {
>   			pins = "MIO36";
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux {
> @@ -301,6 +302,7 @@
>   		conf-bootstrap {
>   			pins = "MIO45", "MIO47", "MIO49";
>   			bias-disable;
> +			output-enable;
>   			low-power-disable;
>   		};
>   
> @@ -308,6 +310,7 @@
>   			pins = "MIO38", "MIO39", "MIO40",
>   				"MIO41", "MIO42", "MIO43";
>   			bias-disable;
> +			output-enable;
>   			low-power-enable;
>   		};
>   
> @@ -316,6 +319,7 @@
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux-mdio {
> @@ -346,6 +350,7 @@
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			"MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			output-enable;
>   			drive-strength = <4>;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   		};
> @@ -373,6 +378,7 @@
>   			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
>   			"MIO72", "MIO73", "MIO74", "MIO75";
>   			bias-disable;
> +			output-enable;
>   			drive-strength = <4>;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   		};
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts b/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
> index 69dba0761b37..8f4c52d6d643 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dts
> @@ -250,6 +250,7 @@
>   		conf-tx {
>   			pins = "MIO36";
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux {
> @@ -301,6 +302,7 @@
>   		conf-bootstrap {
>   			pins = "MIO45", "MIO47", "MIO49";
>   			bias-disable;
> +			output-enable;
>   			low-power-disable;
>   		};
>   
> @@ -308,6 +310,7 @@
>   			pins = "MIO38", "MIO39", "MIO40",
>   				"MIO41", "MIO42", "MIO43";
>   			bias-disable;
> +			output-enable;
>   			low-power-enable;
>   		};
>   
> @@ -316,6 +319,7 @@
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux-mdio {
> @@ -346,6 +350,7 @@
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			"MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			output-enable;
>   			drive-strength = <4>;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   		};
> @@ -373,6 +378,7 @@
>   			pins = "MIO66", "MIO68", "MIO69", "MIO70", "MIO71",
>   			"MIO72", "MIO73", "MIO74", "MIO75";
>   			bias-disable;
> +			output-enable;
>   			drive-strength = <4>;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   		};
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dts b/arch/arm/dts/zynqmp-sck-kv-g-revA.dts
> index a81b3f6f51ad..55bef1df75d0 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dts
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dts
> @@ -205,6 +205,7 @@
>   		conf-tx {
>   			pins = "MIO36";
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux {
> @@ -256,6 +257,7 @@
>   		conf-bootstrap {
>   			pins = "MIO71", "MIO73", "MIO75";
>   			bias-disable;
> +			output-enable;
>   			low-power-disable;
>   		};
>   
> @@ -263,6 +265,7 @@
>   			pins = "MIO64", "MIO65", "MIO66",
>   				"MIO67", "MIO68", "MIO69";
>   			bias-disable;
> +			output-enable;
>   			low-power-enable;
>   		};
>   
> @@ -271,6 +274,7 @@
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux-mdio {
> @@ -301,6 +305,7 @@
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			"MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			output-enable;
>   			drive-strength = <4>;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   		};
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dts b/arch/arm/dts/zynqmp-sck-kv-g-revB.dts
> index f935f25c887f..1b1d9e772f55 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dts
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dts
> @@ -193,6 +193,7 @@
>   		conf-tx {
>   			pins = "MIO36";
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux {
> @@ -244,6 +245,7 @@
>   		conf-bootstrap {
>   			pins = "MIO71", "MIO73", "MIO75";
>   			bias-disable;
> +			output-enable;
>   			low-power-disable;
>   		};
>   
> @@ -251,6 +253,7 @@
>   			pins = "MIO64", "MIO65", "MIO66",
>   				"MIO67", "MIO68", "MIO69";
>   			bias-disable;
> +			output-enable;
>   			low-power-enable;
>   		};
>   
> @@ -259,6 +262,7 @@
>   			slew-rate = <SLEW_RATE_SLOW>;
>   			power-source = <IO_STANDARD_LVCMOS18>;
>   			bias-disable;
> +			output-enable;
>   		};
>   
>   		mux-mdio {
> @@ -289,6 +293,7 @@
>   			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
>   			"MIO60", "MIO61", "MIO62", "MIO63";
>   			bias-disable;
> +			output-enable;
>   			drive-strength = <4>;
>   			slew-rate = <SLEW_RATE_SLOW>;
>   		};

Applied.
M
