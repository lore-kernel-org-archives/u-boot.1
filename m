Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22873109317A
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 04:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6349383F00;
	Fri, 20 Mar 2026 05:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LYAJr+2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24DA083FA4; Fri, 20 Mar 2026 05:30:20 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6850683D71
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 05:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzTg/F2TrWAaxxUmUfRqg9v4TARRfI3smiDca3NXjEbdtX8ozsP2gfpqQ6cIS18t6EoJ+4XqCpmKuXU0JHcCghEGz546ctLjkQM1NOe+oE4LvBUrQS8EkBTYJmhbl/FgH+RSW0niayBNOljm+v5e6FoFcDyvsjoe4zLTZ9uC1zwmRz18U1alSOZXo6BcAZaHBW1w/YYIIOgy+ZtebgicP9u1uiESFJi12yiXS/KQvklOTNXAkH60+Rp/ed9HAHgQqBWIzHXSnojOjtXD1T50c3fwMDmj4FO0FNOkdGxD4m0NJuuRpeqJSxosDzaTrBBGPK3ESoURUPECDn0feLX5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAe3kSQEw6adPYcEq8n02n9xnmi4DVlxQTT4Mf7LvNI=;
 b=zRpill1HUjiCIZUjYUF6lYRQsHYORInGDUJDBskcuQmmjT5RWGjgCEYy+uJwU57p6VP4j1NOgra6TNdx63wmWhrUR32dPnlH+54VFAlmPV1svu7EJxOqJmwQvThiGGASyWvqInmcXk+jRpHYzvn329F/FTKxyevG4TMLa4JukrIsFdgevnFvkqRdLakZr5DaOmw17fEb7VpDiJiCzzYUgJNbNB7iQ8z1N1cq6Jz/ynqYC2o3AOFJXewCvMJ/iVx7fmLf8BXbzUJzWuDExUzN1d0KhB7ModJyKdxtLzmmrcKDpvKG1OlBCrF6JUhwBs3g7c1pni4cy6r0+UysmnKeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAe3kSQEw6adPYcEq8n02n9xnmi4DVlxQTT4Mf7LvNI=;
 b=LYAJr+2U4YXlQAXbdcYYq2+L5AK3IPq2hFQMCOg2vCZ6Bj5I53BCXPQ5SavdkrpCKhXH8EnD2zNevbnGbgpumxRRyZz2bj1Bwxsxter/Eqzvr79RQyWA2j8v1rYwuJVYmwWmEIZMyWyTcjgIZ5Nu2K0gPOq6M6P9BYxDyvpb4bI=
Received: from CH3P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::34)
 by IA1PR10MB7469.namprd10.prod.outlook.com (2603:10b6:208:446::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 04:30:10 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::69) by CH3P221CA0014.outlook.office365.com
 (2603:10b6:610:1e7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 04:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 04:30:09 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 23:30:09 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 23:30:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 23:30:09 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62K4U8IG3698881;
 Thu, 19 Mar 2026 23:30:08 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Mar 2026 10:00:07 +0530
Message-ID: <DH7BS8C2L3NF.PWXS36TL07GT@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <afd@ti.com>,
 <nm@ti.com>, <v-singh1@ti.com>, <sparsh-kumar@ti.com>
Subject: Re: [PATCH] board: ti: am62dx: Separate resource management config
 from am62ax
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318073010.786006-1-p-bhagat@ti.com>
In-Reply-To: <20260318073010.786006-1-p-bhagat@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|IA1PR10MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b6a9fc-bc50-4015-f1c7-08de86395f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: jJ2UEkv5v8MxiL3yTkUtLrXtRwjikKwPRLrvclj9/NIe3FDVf/C3DO8Emy94H8uZrBFQImuB4ycTTl0JqcxMTTAjFscaggMk5S3/z5bhv/cRL5Mb3td79rIXfNoa/sYtwM+QF11lz/NzVji6/x5WMB2KPXU88mBbykCRUSDUMizRZVMgNxAC6tWh3rITlbsDaYhGXqVidW4I2mgoQPprz0XLysmvu5jmoaLYDfk5Uca2V+PXSXqsdGBqoUaDX8yx7F0H5A1+Pe/Wxf5LwulKNvpsuvvFpiblgoFl3+8PmxT0uJXuVZkZjI7JqI4v46sp8MHAaBKggaBQeD3IJTsaLxDFI/D5CimK/0SzF/Nz0TPN8dePpUKtvy2yFR/ZAs2douovxYBbda1ULNGPu+b3Iq+HGZGqRnVOQ/d7ydmW+MQpK6qhDFPMeR1W1YbRqF8mcL6/u29Iu6Tbe+fkZix/SJCdaQnGZZjU7oOJClM+BFbC+ASJVj203lbfLWZ5mxQ4Qbf/0JwUVCkkcaWXwgRQGaTpZWkNmOZGqeaDZjFG1oq8imc4OrImT/fKfLJKisYX5Xi5Gya6dgeL1RJEtEnFgu4DHDL5DjXR43A4pHaPB7tTjD3i+lNrwYYTGmn4kb658tmKJwH3s3qZ5Mi1wzhAsmoZEi8+dPFkdwquw8kLq1XJRJ4mQbXV09cGUvJUVNnnuRAxdrw0fiTAEvwP5SPXiC+hglzyq3Bo63KWI4EfeeI=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(13003099007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JUcoeA6FUR1wWhqwWn+J16it1b7Mx5Wa/2HMg9neC1db1xZfCDd3U+wwvFsmn/tzFWL2gDATMJtiQ02iPBkreMT2/Co8cJkvx+4jCpFgn8/eDti0ugaY1UVYkBmgU6s9oHbrTGKZFOQYCdbChgzeJTsf72951Aqv2H45NjBqEh9hKQI+r5+yu5B/PGKUzhEAV0I9irhZjJknrW4rpf+mN0jHCpdWz+9BIdbQnP4Qk1fF3Qyq0oUubJc8shZQh0zfEAllFexrF9PkraOJSVoxNgRhOEPfz3P2bu8KIT+mfmmwMBU4PDiJ3HUpzO5z9BZ8/yvN+XnCNTpYNwA5djcVMPWx6oumpgyEnMRf9Ku3BFSWXtr5SH87F4dy6NiO/W+IRQ+k3XGe1RG4n4+RwQ17poP4CAbJsIhtwLwCTOtndD20SpFO4m8xtFLTmsytOCh1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 04:30:09.9980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b6a9fc-bc50-4015-f1c7-08de86395f27
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7469
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

On Wed Mar 18, 2026 at 1:00 PM IST, Paresh Bhagat wrote:
> AM62d currently shares resource management configuration files with
> AM62a. However, AM62a resource management needs to be modified for DMA
> resource sharing scheme for CPSW3G Ethernet functionality to support
> multi-core traffic handling.
>
> Add separate AM62d-specific resource management configuration files to
> decouple from the AM62a changes and maintain proper resource allocation
> for AM62d.
>
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
> Patch link for AM62a changes
> https://lore.kernel.org/all/20260224120557.1476390-2-s-vadapalli@ti.com/

The rm-cfg and tifs-rm-cfg for AM62d after your patch differ to the one
for AM62a even without the above patch as follows:

	% diff board/ti/am62dx/rm-cfg.yaml board/ti/am62ax/rm-cfg.yaml
	2c2
	< # Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.t=
i.com/
	---
	> # Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.t=
i.com/
	4c4
	< # Resource management configuration for AM62D
	---
	> # Resource management configuration for AM62A
	19c19
	<                 -  # 1
	---
	>                 -   #  1
	26c26
	<                 -  # 2
	---
	>                 -   #  2
	570c570
	<             num_resource: 496
	---
	>             num_resource: 497

	% diff board/ti/am62dx/tifs-rm-cfg.yaml board/ti/am62ax/tifs-rm-cfg.yaml
	2c2
	< # Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.t=
i.com/
	---
	> # Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.t=
i.com/
	4c4
	< # Resource management configuration for AM62D
	---
	> # Resource management configuration for AM62AX
	27,33d26
	<                     host_id: 20
	<                     allowed_atype: 0x2A
	<                     allowed_qos: 0xAAAA
	<                     allowed_orderid: 0xAAAAAAAA
	<                     allowed_priority: 0xAAAA
	<                     allowed_sched_priority: 0xAA
	<                 -  # 3
	40c33
	<                 -  # 4
	---
	>                 -  # 3
	46a40,46
	>                 -  # 4
	>                     host_id: 0
	>                     allowed_atype: 0
	>                     allowed_qos: 0
	>                     allowed_orderid: 0
	>                     allowed_priority: 0
	>                     allowed_sched_priority: 0
	247c247
	<             resasg_entries_size: 880
	---
	>             resasg_entries_size: 872
	260c260
	<             host_id: 20
	---
	>             host_id: 35
	290c290
	<             host_id: 20
	---
	>             host_id: 35
	320c320
	<             host_id: 20
	---
	>             host_id: 35
	350c350
	<             host_id: 20
	---
	>             host_id: 35
	380c380
	<             host_id: 20
	---
	>             host_id: 35
	410c410
	<             host_id: 20
	---
	>             host_id: 35
	432c432
	<             num_resource: 26
	---
	>             num_resource: 34
	437,442d436
	<             start_resource: 32
	<             num_resource: 8
	<             type: 1802
	<             host_id: 20
	<             reserved: 0
	<         -
	444c438
	<             num_resource: 35
	---
	>             num_resource: 36
	450c444
	<             num_resource: 35
	---
	>             num_resource: 36

Looks like this delta is due to the commits 7f9c2a6f7be7 ("board: ti:
rm-cfg: Update rm-cfg to reflect new resource reservation") and
587b1a56752f ("board: ti: am62ax: tifs-rm-cfg.yaml: Add C7x resource
allocation entries") that are only part of the next branch as of now.

Is this intentional? If not, please resend a v2 based on the updated
configs from next.

CC+: Sparsh (Author of the above commits)

>
> Boot logs
> https://gist.github.com/paresh-bhagat12/f111073108536dfdc9a2c6bc3c401a26
>
>  arch/arm/dts/k3-am62d-evm-binman.dtsi |   16 -
>  board/ti/am62dx/rm-cfg.yaml           | 1047 +++++++++++++++++++++++++
>  board/ti/am62dx/tifs-rm-cfg.yaml      |  909 +++++++++++++++++++++
>  3 files changed, 1956 insertions(+), 16 deletions(-)
>  create mode 100644 board/ti/am62dx/rm-cfg.yaml
>  create mode 100644 board/ti/am62dx/tifs-rm-cfg.yaml
>
> diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62=
d-evm-binman.dtsi
> index 41c8746cf08..423b599dee7 100644
> --- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
> +++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
> @@ -11,10 +11,6 @@
>  	config =3D "board/ti/am62ax/board-cfg.yaml";
>  };
> =20
> -&rcfg_yaml {
> -	config =3D "board/ti/am62ax/rm-cfg.yaml";
> -};
> -
>  &scfg_yaml {
>  	config =3D "board/ti/am62ax/sec-cfg.yaml";
>  };
> @@ -35,18 +31,10 @@
>  	config =3D "board/ti/am62ax/pm-cfg.yaml";
>  };
> =20
> -&rcfg_yaml_tifs {
> -	config =3D "board/ti/am62ax/tifs-rm-cfg.yaml";
> -};
> -
>  &pcfg_yaml_dm {
>  	config =3D "board/ti/am62ax/pm-cfg.yaml";
>  };
> =20
> -&rcfg_yaml_dm {
> -	config =3D "board/ti/am62ax/rm-cfg.yaml";
> -};
> -
>  &bcfg_yaml_sysfw {
>  	config =3D "board/ti/am62ax/board-cfg.yaml";
>  };
> @@ -59,10 +47,6 @@
>  	config =3D "board/ti/am62ax/pm-cfg.yaml";
>  };
> =20
> -&rcfg_yaml_sysfw {
> -	config =3D "board/ti/am62ax/rm-cfg.yaml";
> -};
> -
>  #endif
> =20
>  #ifdef CONFIG_TARGET_AM62D2_A53_EVM
> diff --git a/board/ti/am62dx/rm-cfg.yaml b/board/ti/am62dx/rm-cfg.yaml
> new file mode 100644
> index 00000000000..b9148e0d710
> --- /dev/null
> +++ b/board/ti/am62dx/rm-cfg.yaml
> @@ -0,0 +1,1047 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.t=
i.com/
> +#
> +# Resource management configuration for AM62D
> +#
> +
> +---
> +
> +rm-cfg:
> +    rm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> +        host_cfg:
> +            subhdr:
> +                magic: 0x4C41
> +                size: 356
> +            host_cfg_entries:
> +                -  # 1
> +                    host_id: 12
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 2
> +                    host_id: 20
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 3
> +                    host_id: 30
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 4
> +                    host_id: 36
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 5
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 6
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 7
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 8
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 9
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 10
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 11
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 12
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 13
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 14
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 15
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 16
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 17
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 18
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 19
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 20
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 21
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 22
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 23
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 24
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 25
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 26
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 27
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 28
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 29
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 30
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 31
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 32
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +        resasg:
> +            subhdr:
> +                magic: 0x7B25
> +                size: 8
> +            resasg_entries_size: 1064
> +            reserved: 0
> +    resasg_entries:
> +        -
> +            start_resource: 0
> +            num_resource: 16
> +            type: 64
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 4
> +            type: 64
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 4
> +            type: 64
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 22
> +            type: 64
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 16
> +            type: 192
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 34
> +            num_resource: 2
> +            type: 192
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 2
> +            type: 320
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 2
> +            type: 320
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 2
> +            type: 320
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 4
> +            num_resource: 4
> +            type: 320
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 26
> +            type: 384
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 50176
> +            num_resource: 164
> +            type: 1666
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 1667
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 18
> +            type: 1677
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1677
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1677
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 24
> +            num_resource: 2
> +            type: 1677
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 26
> +            num_resource: 6
> +            type: 1677
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 54
> +            num_resource: 18
> +            type: 1678
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 72
> +            num_resource: 6
> +            type: 1678
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 72
> +            num_resource: 6
> +            type: 1678
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 78
> +            num_resource: 2
> +            type: 1678
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 80
> +            num_resource: 2
> +            type: 1678
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 32
> +            num_resource: 12
> +            type: 1679
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 6
> +            type: 1679
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 6
> +            type: 1679
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 50
> +            num_resource: 2
> +            type: 1679
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 52
> +            num_resource: 2
> +            type: 1679
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 18
> +            type: 1696
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1696
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1696
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 24
> +            num_resource: 2
> +            type: 1696
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 26
> +            num_resource: 6
> +            type: 1696
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 18
> +            type: 1697
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1697
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1697
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 24
> +            num_resource: 2
> +            type: 1697
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 26
> +            num_resource: 2
> +            type: 1697
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 12
> +            type: 1698
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 6
> +            type: 1698
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 6
> +            type: 1698
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 2
> +            type: 1698
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 2
> +            type: 1698
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 6
> +            num_resource: 26
> +            type: 1802
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 32
> +            num_resource: 8
> +            type: 1802
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 35
> +            type: 1802
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 35
> +            type: 1802
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 168
> +            num_resource: 8
> +            type: 1802
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 14
> +            num_resource: 512
> +            type: 1805
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 526
> +            num_resource: 256
> +            type: 1805
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 526
> +            num_resource: 256
> +            type: 1805
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 782
> +            num_resource: 128
> +            type: 1805
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 910
> +            num_resource: 128
> +            type: 1805
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 1038
> +            num_resource: 496
> +            type: 1805
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1024
> +            type: 1807
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 4096
> +            num_resource: 29
> +            type: 1808
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 4608
> +            num_resource: 99
> +            type: 1809
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 5120
> +            num_resource: 24
> +            type: 1810
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 5632
> +            num_resource: 51
> +            type: 1811
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 6144
> +            num_resource: 51
> +            type: 1812
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 6656
> +            num_resource: 51
> +            type: 1813
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 8192
> +            num_resource: 32
> +            type: 1814
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 8704
> +            num_resource: 32
> +            type: 1815
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 9216
> +            num_resource: 32
> +            type: 1816
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 9728
> +            num_resource: 22
> +            type: 1817
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 10240
> +            num_resource: 22
> +            type: 1818
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 10752
> +            num_resource: 22
> +            type: 1819
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 11264
> +            num_resource: 28
> +            type: 1820
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 11776
> +            num_resource: 28
> +            type: 1821
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 12288
> +            num_resource: 28
> +            type: 1822
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 1923
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 10
> +            type: 1936
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1936
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1936
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 13
> +            num_resource: 3
> +            type: 1936
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 3
> +            type: 1936
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 64
> +            type: 1937
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 64
> +            type: 1937
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 83
> +            num_resource: 8
> +            type: 1938
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 91
> +            num_resource: 8
> +            type: 1939
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 99
> +            num_resource: 10
> +            type: 1942
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 109
> +            num_resource: 3
> +            type: 1942
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 109
> +            num_resource: 3
> +            type: 1942
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 112
> +            num_resource: 3
> +            type: 1942
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 115
> +            num_resource: 3
> +            type: 1942
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 118
> +            num_resource: 16
> +            type: 1943
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 118
> +            num_resource: 16
> +            type: 1943
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 134
> +            num_resource: 8
> +            type: 1944
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 134
> +            num_resource: 8
> +            type: 1945
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 142
> +            num_resource: 8
> +            type: 1946
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 142
> +            num_resource: 8
> +            type: 1947
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 10
> +            type: 1955
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1955
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1955
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 13
> +            num_resource: 3
> +            type: 1955
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 3
> +            type: 1955
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 8
> +            type: 1956
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 8
> +            type: 1956
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 27
> +            num_resource: 1
> +            type: 1957
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 28
> +            num_resource: 1
> +            type: 1958
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 10
> +            type: 1961
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1961
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1961
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 13
> +            num_resource: 3
> +            type: 1961
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 3
> +            type: 1961
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 10
> +            type: 1962
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1962
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1962
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 13
> +            num_resource: 3
> +            type: 1962
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 3
> +            type: 1962
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 1
> +            type: 1963
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 1
> +            type: 1963
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 16
> +            type: 1964
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 16
> +            type: 1964
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 1
> +            type: 1965
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 35
> +            num_resource: 8
> +            type: 1966
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 21
> +            num_resource: 1
> +            type: 1967
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 35
> +            num_resource: 8
> +            type: 1968
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 22
> +            num_resource: 1
> +            type: 1969
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 43
> +            num_resource: 8
> +            type: 1970
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 1
> +            type: 1971
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 43
> +            num_resource: 8
> +            type: 1972
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 2112
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 2
> +            type: 2122
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 51200
> +            num_resource: 12
> +            type: 12738
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 12739
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 6
> +            type: 12750
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 6
> +            type: 12769
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 8
> +            type: 12810
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 12288
> +            num_resource: 128
> +            type: 12813
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 3072
> +            num_resource: 6
> +            type: 12828
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 3584
> +            num_resource: 6
> +            type: 12829
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 4096
> +            num_resource: 6
> +            type: 12830
> +            host_id: 128
> +            reserved: 0
> diff --git a/board/ti/am62dx/tifs-rm-cfg.yaml b/board/ti/am62dx/tifs-rm-c=
fg.yaml
> new file mode 100644
> index 00000000000..254e8115314
> --- /dev/null
> +++ b/board/ti/am62dx/tifs-rm-cfg.yaml
> @@ -0,0 +1,909 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.t=
i.com/
> +#
> +# Resource management configuration for AM62D
> +#
> +
> +---
> +
> +tifs-rm-cfg:
> +    rm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> +        host_cfg:
> +            subhdr:
> +                magic: 0x4C41
> +                size: 356
> +            host_cfg_entries:
> +                -  # 1
> +                    host_id: 12
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 2
> +                    host_id: 20
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 3
> +                    host_id: 30
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 4
> +                    host_id: 36
> +                    allowed_atype: 0x2A
> +                    allowed_qos: 0xAAAA
> +                    allowed_orderid: 0xAAAAAAAA
> +                    allowed_priority: 0xAAAA
> +                    allowed_sched_priority: 0xAA
> +                -  # 5
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 6
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 7
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 8
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 9
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 10
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 11
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 12
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 13
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 14
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 15
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 16
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 17
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 18
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 19
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 20
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 21
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 22
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 23
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 24
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 25
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 26
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 27
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 28
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 29
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 30
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 31
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +                -  # 32
> +                    host_id: 0
> +                    allowed_atype: 0
> +                    allowed_qos: 0
> +                    allowed_orderid: 0
> +                    allowed_priority: 0
> +                    allowed_sched_priority: 0
> +        resasg:
> +            subhdr:
> +                magic: 0x7B25
> +                size: 8
> +            resasg_entries_size: 880
> +            reserved: 0
> +    resasg_entries:
> +        -
> +            start_resource: 0
> +            num_resource: 18
> +            type: 1677
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1677
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1677
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 24
> +            num_resource: 2
> +            type: 1677
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 26
> +            num_resource: 6
> +            type: 1677
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 54
> +            num_resource: 18
> +            type: 1678
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 72
> +            num_resource: 6
> +            type: 1678
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 72
> +            num_resource: 6
> +            type: 1678
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 78
> +            num_resource: 2
> +            type: 1678
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 80
> +            num_resource: 2
> +            type: 1678
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 32
> +            num_resource: 12
> +            type: 1679
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 6
> +            type: 1679
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 6
> +            type: 1679
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 50
> +            num_resource: 2
> +            type: 1679
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 52
> +            num_resource: 2
> +            type: 1679
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 18
> +            type: 1696
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1696
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1696
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 24
> +            num_resource: 2
> +            type: 1696
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 26
> +            num_resource: 6
> +            type: 1696
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 18
> +            type: 1697
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1697
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 6
> +            type: 1697
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 24
> +            num_resource: 2
> +            type: 1697
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 26
> +            num_resource: 2
> +            type: 1697
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 12
> +            type: 1698
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 6
> +            type: 1698
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 12
> +            num_resource: 6
> +            type: 1698
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 18
> +            num_resource: 2
> +            type: 1698
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 2
> +            type: 1698
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 6
> +            num_resource: 26
> +            type: 1802
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 32
> +            num_resource: 8
> +            type: 1802
> +            host_id: 20
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 35
> +            type: 1802
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 44
> +            num_resource: 35
> +            type: 1802
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 168
> +            num_resource: 8
> +            type: 1802
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1024
> +            type: 1807
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 4096
> +            num_resource: 29
> +            type: 1808
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 4608
> +            num_resource: 99
> +            type: 1809
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 5120
> +            num_resource: 24
> +            type: 1810
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 5632
> +            num_resource: 51
> +            type: 1811
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 6144
> +            num_resource: 51
> +            type: 1812
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 6656
> +            num_resource: 51
> +            type: 1813
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 8192
> +            num_resource: 32
> +            type: 1814
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 8704
> +            num_resource: 32
> +            type: 1815
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 9216
> +            num_resource: 32
> +            type: 1816
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 9728
> +            num_resource: 22
> +            type: 1817
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 10240
> +            num_resource: 22
> +            type: 1818
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 10752
> +            num_resource: 22
> +            type: 1819
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 11264
> +            num_resource: 28
> +            type: 1820
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 11776
> +            num_resource: 28
> +            type: 1821
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 12288
> +            num_resource: 28
> +            type: 1822
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 10
> +            type: 1936
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1936
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1936
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 13
> +            num_resource: 3
> +            type: 1936
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 3
> +            type: 1936
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 64
> +            type: 1937
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 64
> +            type: 1937
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 83
> +            num_resource: 8
> +            type: 1938
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 91
> +            num_resource: 8
> +            type: 1939
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 99
> +            num_resource: 10
> +            type: 1942
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 109
> +            num_resource: 3
> +            type: 1942
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 109
> +            num_resource: 3
> +            type: 1942
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 112
> +            num_resource: 3
> +            type: 1942
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 115
> +            num_resource: 3
> +            type: 1942
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 118
> +            num_resource: 16
> +            type: 1943
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 118
> +            num_resource: 16
> +            type: 1943
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 134
> +            num_resource: 8
> +            type: 1944
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 134
> +            num_resource: 8
> +            type: 1945
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 142
> +            num_resource: 8
> +            type: 1946
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 142
> +            num_resource: 8
> +            type: 1947
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 10
> +            type: 1955
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1955
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1955
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 13
> +            num_resource: 3
> +            type: 1955
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 3
> +            type: 1955
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 8
> +            type: 1956
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 8
> +            type: 1956
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 27
> +            num_resource: 1
> +            type: 1957
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 28
> +            num_resource: 1
> +            type: 1958
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 10
> +            type: 1961
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1961
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1961
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 13
> +            num_resource: 3
> +            type: 1961
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 3
> +            type: 1961
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 10
> +            type: 1962
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1962
> +            host_id: 35
> +            reserved: 0
> +        -
> +            start_resource: 10
> +            num_resource: 3
> +            type: 1962
> +            host_id: 36
> +            reserved: 0
> +        -
> +            start_resource: 13
> +            num_resource: 3
> +            type: 1962
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 16
> +            num_resource: 3
> +            type: 1962
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 1
> +            type: 1963
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 1
> +            type: 1963
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 16
> +            type: 1964
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 19
> +            num_resource: 16
> +            type: 1964
> +            host_id: 30
> +            reserved: 0
> +        -
> +            start_resource: 20
> +            num_resource: 1
> +            type: 1965
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 35
> +            num_resource: 8
> +            type: 1966
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 21
> +            num_resource: 1
> +            type: 1967
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 35
> +            num_resource: 8
> +            type: 1968
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 22
> +            num_resource: 1
> +            type: 1969
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 43
> +            num_resource: 8
> +            type: 1970
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 23
> +            num_resource: 1
> +            type: 1971
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 43
> +            num_resource: 8
> +            type: 1972
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 1
> +            type: 2112
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 2
> +            num_resource: 2
> +            type: 2122
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 6
> +            type: 12750
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 6
> +            type: 12769
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 0
> +            num_resource: 8
> +            type: 12810
> +            host_id: 12
> +            reserved: 0
> +        -
> +            start_resource: 3072
> +            num_resource: 6
> +            type: 12828
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 3584
> +            num_resource: 6
> +            type: 12829
> +            host_id: 128
> +            reserved: 0
> +        -
> +            start_resource: 4096
> +            num_resource: 6
> +            type: 12830
> +            host_id: 128
> +            reserved: 0

