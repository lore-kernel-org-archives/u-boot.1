Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46993D5AE75
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A28FF8904D;
	Thu,  7 Nov 2024 10:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="dMemRox4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED1F88F4A; Thu,  7 Nov 2024 10:07:50 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::71f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B410A891FE
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mESGavWuAldlXSWgI9tQrlFZikkuGAuooMWjQZvqni31FjiuF+lUFo2ZD02Vams3PNE8kmfXjcybwKCDbQuWEt+ZIjIU23G+ImglwYGHWP2O4o0DjNOh5GPW2wU4OUdhD7ks4wnjS/vKVzh/1bY/VlpD7G1i8Xb6efMYK7qCaXBHA3jBto+qM+evgty4cLW05wlbVYH9Y3qwM3ZWXkto1rDEpq4pTFyMUjfu3VqaC8sAlWAeLwBhMZW1gs5umDZLeWBAadrbl4qxxIaBHc2iEJIH1Z/Z3uH0ZE+KTs6rDEotysBXFxeA23YuXWP2/zIrwIKFsXymwYo8nvR9SB6QAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxSvLAgzN5jIMtxi+K69h+5kcwiU+4eqBfFCCHsW8Fk=;
 b=WPhqQPgDG48CzM8OWmotI/4YRmDZmqKdU80I3vpXZM6VVlXwOpApiXETIMUniBZrepeSpKBXOQd7C/LLX6MIAYR2JRdylP8cxaYgxaiy6LM86kI2OLTmxG17E1N5GC3feD84Sp7oEZpfvzR9y2GGCgn5EcBqH2Gu7VOY4YDDgl3lwEanzD/cmutR0k8ggDTL1/SY8e+VwZroqZDyYtNGvDKh2+kv3lwY8yl9d+B9vrUZBTKYLURmzJPu6fLHOTjiXbHWMMaSgXA4UXhZTNqShKUk+qcue1SITV5GoMUiZt5UsNX4fOghP4iwxsv/LKuDS0+Q0RxPYsDoxlk3OCzrRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxSvLAgzN5jIMtxi+K69h+5kcwiU+4eqBfFCCHsW8Fk=;
 b=dMemRox44yJZAM4Pv/30cUcb/u4Nzy/ByRV9FIP9hVeTfHG3ms4z7qnowiVoRrkrpsPTHlrFEhnLP7OeFAb6xM3gH8sQlCGNydNOZmbPZ/u7X6C+dS2gHKTqY7Fp7sQv5cAVEJUtTibs0S4hVLZH2yfBZjBV0v3cHh994OWLbRY=
Received: from DU2PR04CA0064.eurprd04.prod.outlook.com (2603:10a6:10:232::9)
 by PAXP195MB1310.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:198::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 09:07:44 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::d6) by DU2PR04CA0064.outlook.office365.com
 (2603:10a6:10:232::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Thu, 7 Nov 2024 09:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 09:07:44 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 10:07:44 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 7 Nov 2024
 10:07:43 +0100
Message-ID: <1f2af2cd-47bf-4267-b7f7-13c08c3ab4e8@phytec.de>
Date: Thu, 7 Nov 2024 10:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH v2 5/6] doc: phytec: imx8mp: add OP-TEE
 documentation
To: Yannic Moog <y.moog@phytec.de>, Stefano Babic <sbabic@denx.de>, "Fabio
 Estevam" <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, "Tom
 Rini" <trini@konsulko.com>
CC: Manuel Traut <manut@mecka.net>, Tim Harvey <tharvey@gateworks.com>,
 <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yashwanth Varakala
 <y.varakala@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-5-bbc3747a60e8@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241107-phytec_imx8m_optee-v2-5-bbc3747a60e8@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|PAXP195MB1310:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a717cd-96fa-4ee6-d9bd-08dcff0ba44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmpZdmhwc1VqdlFQOEVOVE9pUFBEWlI1bTRGNUNIRGxCZVU2aFJ4cWZsOUl0?=
 =?utf-8?B?WnF6bEZ1SVlncXZGWDRwYkU0QjJVN0dNNVM5ZlJsUjg0Z25PSnpPN0FZTXN2?=
 =?utf-8?B?bVNrM1ZIY1g0cEtsZy9hS2lnaGZQaXN1d0JGTGpZa1RmTE9INmhTcmVLUU9X?=
 =?utf-8?B?ZmtzQm8wTExmcWtBWEJGZVdaSU1xQU1ybE45ekN0eFljaHFjS3d3N3k3c3Jy?=
 =?utf-8?B?QUN6Y2NoRnJ0Nms2WFllSGsvNHJCLzYwNEdIR3ZsalZDTUdBR1lWQ3JHd09x?=
 =?utf-8?B?UnExVjVMb0wvQUovNjZLTkhoc1RzdWd3NThVbk1HSmsyMTlIYlBhWTQ0YVhw?=
 =?utf-8?B?YjZzdFJQVU11OExuZG02M0Q5ZEtLanJhQTdiUTZkcmwwZXRPQmlNSEpLZENR?=
 =?utf-8?B?b0dZeGNFY2kvZy9yMkNyMkJ5YklMdXhNUlNRbXNuSW1iRlBFVWNqeGp3SEhC?=
 =?utf-8?B?MXVleVpGbzBlaTNJVXVqWmxkUXpQVG5ZVTFwemdqTW50d0krb0lmSDVIajdj?=
 =?utf-8?B?dnRONGJIbi9EN3Nxd1llZGF0ZDRxR0N0UW14TkREMU9yL3ZCNjlsMGkrRjFG?=
 =?utf-8?B?T2NHTWNtWExxSDB0SS9MNFpYblRtdURHTGZhTlVjc29kYkJrUGkrQnI1TUlE?=
 =?utf-8?B?VENOK3YwdTlxUjBkSU8xbXlTT29CcFF4eThJOUpXbU9vNHpWdjc4bkt6REwx?=
 =?utf-8?B?QzQ0RHRJYmZkeFhpZ1ZvY3JabWwrNS9QbWhXQkFuNUtjVE9ZSHE4SzkyZDZu?=
 =?utf-8?B?dm1mc0VzSTFNd1VkM0dRY1ZyTUdTbTllYkVXeEJlS1B5UWNNMEIrMlJ4cmFn?=
 =?utf-8?B?dGovOERKRW5DK1lVcjVrRlFsNEt0TDJ5c1dGVkJOY2pNSUVkd1k5TFU5bVVi?=
 =?utf-8?B?RnhyU2YweVlWaHNrS245ek5NMTdIUERuNVhPYmNqZUViOG8rMXVud243Slo5?=
 =?utf-8?B?RmkzMDV5RGpialluVTlESEVwMmlHd0h4T0lGY01iRm9ubkJONXdWMGxxQ1lx?=
 =?utf-8?B?YmJ0RzZwaStvS2lVTlZOQUNTWFRWVERrK0JlNCtqUnNxNzI5eWw0aXhpQVpT?=
 =?utf-8?B?SmVCaFRzK28yOWJDNmRwM1NxL0dHVGJ3WE1BdVNQVXZOZFNtTG9oN2l2VklU?=
 =?utf-8?B?ZlhtalRiQjNORktoUGxSUk1ZeXhRN3JybFB5UlRXd1RCY1QycmlSMUwwWk9y?=
 =?utf-8?B?ZHE3K1h2YzdwV0xZdkVzNXA5NGl4MEVHWXg3dFZUS3MvbXIvMnhteU1sR29r?=
 =?utf-8?B?cm1YZ1lvNG1aMlYwVXB6UU5tcVNSbVhYR0tQWThCa25WakZxTW0xWjdDYThP?=
 =?utf-8?B?djlXOFRJU0R0VXR1YitEQWRkQm9lRnhxa05URmRhOVV3SGxkSmdvRWJIQUlF?=
 =?utf-8?B?NkRZM3BXNzZXbXpRQU1NZGcyK0s0K2VEbW9FTUs3NFp5VGFXTUdWdG90V0Fk?=
 =?utf-8?B?L3ZDVFdqOVl4N0NnOXlSRnRuOGFjYTJBaU4raHhvQzZmdTZBQzR3bytqM3o1?=
 =?utf-8?B?T2s4VEQxTEVqWTlGNlZlM1BhWXpoMENrNkhnRGVDTUVSZHVxMUtnQkNlSDUr?=
 =?utf-8?B?UDdidDFUU3d3TGZyMVVrVTY3RmgveHNBam9xME1ONzBKcVJNMGVnblJucGdK?=
 =?utf-8?B?SWk5ak1BMzBPN3VzSnoxblh2a3BZVVlTWUZoUW9EMG9kM3piWHY0T2RNU3Ar?=
 =?utf-8?B?YWw2VEVOaDdLenZrWjNJVjlsNFBPOWZMTGtUbzJVckZlb1BWZWFpcTdKc25B?=
 =?utf-8?B?WmptczJTOWlBd2FCWHZkeThxOEhRL1NibGVYaFBpQ1RWWjhKQ3MyQXREQVZt?=
 =?utf-8?Q?ziPujaMKkx8IOg+Ta1ng7XJifKICkQJDK0r7c=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 09:07:44.5078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a717cd-96fa-4ee6-d9bd-08dcff0ba44a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1310
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



Am 07.11.24 um 09:23 schrieb Yannic Moog:
> Add documentation for the phyBOARD-Pollux i.MX 8M Plus on OP-TEE
> integration.
> Also add missing '-' to TF-A build instruction while at it.


Would it make sense to move these instructions into a more general 
section, so they could be reused by other imx based boards as well?

Seems you missed to update imx8mm-phygate-tauri-l.rst

> 
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>   doc/board/phytec/phycore-imx8mp.rst | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
> index fda751aeffb..4bcfa9f39ca 100644
> --- a/doc/board/phytec/phycore-imx8mp.rst
> +++ b/doc/board/phytec/phycore-imx8mp.rst
> @@ -9,6 +9,7 @@ Quick Start
>   -----------
>   
>   - Build the ARM Trusted firmware binary
> +- Build the OP-TEE binary (optional)
>   - Get ddr firmware
>   - Build U-Boot
>   - Boot
> @@ -20,10 +21,32 @@ Build the ARM Trusted firmware binary
>   
>      $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
>      $ cd trusted-firmware-a
> -   $ export CROSS_COMPILE=aarch64-linux-gnu
> +   $ export CROSS_COMPILE=aarch64-linux-gnu-
>      $ export IMX_BOOT_UART_BASE=0x30860000
> +   $ # with optee
> +   $ make PLAT=imx8mp SPD=opteed bl31
> +   $ # without optee
>      $ make PLAT=imx8mp bl31
>   
> +Build the OP-TEE binary (optional)
> +----------------------------------
> +
> +.. code-block:: bash
> +
> +   $ git clone https://github.com/OP-TEE/optee_os.git
> +   $ cd optee_os
> +   $ make CFG_ARM64_core=y \
> +     CFG_TEE_BENCHMARK=n \
> +     CROSS_COMPILE=aarch64-linux-gnu- \
> +     CROSS_COMPILE_core=aarch64-linux-gnu- \
> +     CROSS_COMPILE_ta_arm32=arm-linux-gnueabihf- \
> +     CROSS_COMPILE_ta_arm64=aarch64-linux-gnu- \
> +     O=out/arm \
> +     PLATFORM=imx-mx8mpevk \
> +     CFG_TZDRAM_START=0x56000000 \
> +     CFG_DDR_SIZE=0x80000000 \
> +     CFG_UART_BASE=UART1_BASE
> +
>   Get the ddr firmware
>   --------------------
>   
> @@ -42,6 +65,7 @@ Copy binaries
>   .. code-block:: bash
>   
>      $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
> +   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
>      $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
>   
>   Build U-Boot
> 

