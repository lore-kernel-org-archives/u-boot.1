Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E21105A594
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FEBB8418C;
	Thu, 12 Mar 2026 13:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vqA8ZyWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E5D8419A; Thu, 12 Mar 2026 13:34:55 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF8C83F14
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY1CbQT1iXbr9kNfoAXuT/QFVFpFAf9WIGjUKKokkxFgp/Bgak7vXZL1gBK3OzJ9X7aFkUVLHIvgn3W57kZCUxsFm61tulRoEF6xZfKfRU7fTnorQIugA2eJweecuc1l9g0C/5wCk9CkS3O5jeb7VY0zpkqmT6rKPJ15n+1JKVFvy3KOMAoNPz48qfUEl6gMSlJC9V9EN8m5DDUlCF2Gf/v+16i5SB7o0spumHdeak4z1/WOL7CXY7cAjCNdTOT6YuDY5odQ2vN6DL3zgKz/spgw2BBamTJb+Rw14rmQtxqIZ9A2zATJd43Lnf8F8E8D7/wjR9CrISsu1HHRPFs/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNpv0CKew+kD5t4eFGhrIbKPwa1JrhxuAwb2xORoNQQ=;
 b=L4UHg1u+gjfT0AtED1vT1WXjpliEVcprgAPBJP+fVn4mo2ZWcEvVKI0Q3EkP2NdBFMFLf2WSAL9q+4tAi+mBUfhXEwCqc5jBRj2rI3R1+WQkIs9VfSLTs6xEaL1moGSVRnILSTe0jxb+3EsFpaxjguvUI45m7M0mPrnEe3H0Nr/eSvxOSlhd8O/sjGBTqTk8o74mG2dhRaJA6/znTqXY1BNfs/tYQ1K4mg1tte+gHy1brL1WK54PEhokZ7NggHbb70VH1ae7SLed7umziRZWPnLT7Ax2A9zHnPw4b9Jzqj+RNBo+HqNORS08zUIe059nafh8eQsW2y4MbkxSwiE9WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNpv0CKew+kD5t4eFGhrIbKPwa1JrhxuAwb2xORoNQQ=;
 b=vqA8ZyWWnDgIlxZ4PFiNur9xl8vXpkNZ5khd4rD3dP6l4DRp4Sm6R9SSbDvskCaHAFu41zCaULFA4PaugFXSY+5TYmmk9bxDOtLsk4rMPj7M/jy6aBt1JjSeKjSlLjBRV+SS2UgCCv57tV9FU3CfgGHFdTbOcBdHdK4D5icXN7g=
Received: from MW4P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::27)
 by DM4PR10MB5917.namprd10.prod.outlook.com (2603:10b6:8:b1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.15; Thu, 12 Mar 2026 12:34:49 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::c7) by MW4P221CA0022.outlook.office365.com
 (2603:10b6:303:8b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Thu,
 12 Mar 2026 12:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 12:34:48 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 07:34:16 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 07:34:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 07:34:15 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62CCYFD02819121;
 Thu, 12 Mar 2026 07:34:15 -0500
Date: Thu, 12 Mar 2026 07:34:15 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Suhaas Joshi
 <s-joshi@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH next] arm: mach-k3: use Kconfig options for ATF/OPTEE size
Message-ID: <20260312123415.6ygihkwg6je53iar@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260310-tfa_tee_addr_kconfig_refactor-v1-1-d24abbca82ee@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|DM4PR10MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: a24778a2-8730-41a7-b80e-08de8033bffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: M+Ox8WCNlXEWfNVRHzUkP65oneN2t/Iwcr/OT2O0MCIUdGR5HuqiSGTCBWtJjxyAvOxb1HuVNZO4sjXwN/CnVd14pm9P0HTrk44SULEdNOdrymmejMxGbU7r+NkE/fn/UHJn/qJj13wq/SfxG9EKEdfV2+gD2xP09t7fnPMs9L+/8B/wCuu24px++7dmj2d4frUH5bksrZo47qbB2Zf9iiThaJ5kagnHdu7fjiUPPQHmKmKyUO217NGJiOU8q1p75k4HkmbIlvOumGkGFRH0BlWT3fc+Sh58HFzrNrmCnUKwLAs7JyJtmslMGmeMewcy/JGDzP7/f1JHp8D6xzFisZzC5V6m2zQZIbQF4zuk+rPCLOgNr9lC/Haop0dDV8t2MlsZt7L30jELwFhxpkoOpxxNjozlj4lbRg+5sXkhGwgujKcMTisjHhrOQr/5dW/g6euD4CzdXyyIsVgrXaEhw7uRun+vew+1wlCQkMtF1BOEeKnmDJkEhsKCdc/yG0RG6Wdt1n6fd5Gef+a5gStlThTQKjv9PTawtO/zUgD0B8Wq019GF+Br1SXdUsfETSueZwqaa5nuC7+mIsVx+Yruw1T8xFJsLlHr5zKDFkV5GgC/JqzjCJpAdy9Bh/gOL4RBrzBFD9I2JWJy4P5cJWnRFTVkxyAxfpTmcFHNFAtLjEUzdP3mL+yxmKEbAjq8yxuVlD+1hv6DUJTwNux2krd2N67x+dqDro2JeVHQaliLAa2cxiq8ht5+8asrfnPk+O0T4t4WjNQNedft0jaEENidVQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qczse4q2s6CvBiilBrd+QSXvsH70wMKgsrvfzquQPk7qAw3zTvxwtGO0g8d/uBDuANRTHUKgEG7u0ytGpK4M87u+4Mer44lAnYJbx8pyjyigfC8FXl67unRiW0FgIwBe7YFXqiQRvNGuzGpn2gLZDgwUyp0QEuQqQW6Gdf0pc6LkmejaV5rmuaOMkXonjavwZxdXo8hREFaul4FPfHi7jH45flynp4uyoevblj9ZtJlb0rwzBmnWpWRuIlPrxM5tS81LwELzi1Qi/d7Zce1XrXuWyMqFKk/46JftGvZ6abduuPbz946ePNIB5fgatA9caXPs3wMlfQaL/yCRWf9cVMpkVbRA4e3OuFjhFAVVcJf6P0IuC1iaH0ldzKn2NArw7yZMaE9iehTnasuxFCG43r7CyC3lQL2wPFcCAKORhQuy3mcjMpz4QxXczdyoi/wC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 12:34:48.4561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a24778a2-8730-41a7-b80e-08de8033bffd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5917
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

On March 10, 2026 thus sayeth Anshul Dalal:
> The reserved memory sizes for ATF and OPTEE were hard-coded for K3
> devices, this patch replaces them with a Kconfig option allowing for
> easier modifications.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/dts/k3-binman.dtsi   |  4 ++--
>  arch/arm/mach-k3/Kconfig      | 15 +++++++++++++++
>  arch/arm/mach-k3/common_fdt.c |  5 +++--
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 0fd93f9536a..ad127663d03 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -477,7 +477,7 @@
>  						FWPERM_SECURE_PRIV_RWCD |
>  						FWPERM_SECURE_USER_RWCD)>;
>  		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
> -		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
> +		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERVED_SIZE - 1)>;
>  	};
>  	firewall_armv8_optee_fg: template-8 {
>  		control = <(FWCTRL_EN | FWCTRL_LOCK |
> @@ -486,7 +486,7 @@
>  						FWPERM_SECURE_PRIV_RWCD |
>  						FWPERM_SECURE_USER_RWCD)>;
>  		start_address = <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
> -		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
> +		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + CONFIG_K3_OPTEE_RESERVED_SIZE - 1)>;
>  	};
>  
>  	ti_falcon_template: template-9 {
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 1b8c0b1eb96..ba1130a7996 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -130,6 +130,14 @@ config K3_ATF_LOAD_ADDR
>  	  The load address for the ATF image. This value is used to build the
>  	  FIT image header that places ATF in memory where it will run.
>  
> +config K3_ATF_RESERVED_SIZE
> +	hex "Reserved DDR size for ATF"
> +	default 0x80000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || SOC_K3_AM62P5 || SOC_K3_J722S)
> +	default 0x20000
> +	help
> +	  The runtime DDR size reserved for ATF. This value is used to fixup the
> +	  kernel device-tree's reserved-memory node for ATF.
> +
>  config K3_OPTEE_LOAD_ADDR
>  	hex "Load address of OPTEE image"
>  	default 0x9e800000
> @@ -137,6 +145,13 @@ config K3_OPTEE_LOAD_ADDR
>  	  The load address for the OPTEE image. This value defaults to 0x9e800000
>  	  if not provided in the board defconfig file.
>  
> +config K3_OPTEE_RESERVED_SIZE
> +	hex "Reserved DDR size for OPTEE"
> +	default 0x1800000
> +	help
> +	  The runtime DDR size reserved for OPTEE. This value is used to fixup the

Only the devices which do not have enough on chip RAM (AM62*) will put 
TFA and OP-TEE in DDR.

~Bryan
