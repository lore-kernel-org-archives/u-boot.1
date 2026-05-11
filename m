Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA158CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 10:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D938394E;
	Mon, 11 May 2026 12:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HAfWpYNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B060683A41; Mon, 11 May 2026 12:54:21 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D5F7838BB
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQCiMZnosLAI0VoQVpqMNFu8opsOTcv9Hk65ipxijb4SC+7LYTJqOaGngSjLdK+55GVKJNerSEBEmx4Vor/qA2ZjQ8/OIat/6qzHdAQbQ2M1MsO7hpDo1D8gR0LK/BBWjJeSGBl+FA/fzgCCqSpDcSVfulJ8HrxnKW9ru3lDAZjfEXZqeUZnY2B/8/J+A0OkhKZCROeiiaC0DxEQtOAnBkvy5TSDeu3BMh4TpF1f+ReVEUs79UiIC406wgEeDOr5b65/TwXlcIqs0SaY8M1hiOEJTPFnH0+Vai68xjDprmvwvBUo/8yGrIPfBUyheRyxLMd4yc0EM1wtng0xU9Qj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYYCqjDKDEifFxJP1rUzcAWUxB4knb514aO+Mo0d1Ro=;
 b=cJRcqweF3fhHc1SDSrcDag+vQfRl0CcZ4gOthsiYX8J3QOJVnVu9QUOoOXyz2l95ubDg72lnPjhF0d64KHG1KxgiOVyxPkQTVplf7cIpkTLAH+EhSVChDxo0wI/Ihg0itUzU7UdnJdIMpCbau90Anvk8Oc2CcfJk8o4QKBFBPJi/ESGtFf0maA3lHAhULsHFAkj7QnOm0RB6Ol92h3Ol+e02VSd8Ve15VmWCfbIfhdekPaKGpfnG8DEuVmsxVQai42q2unWMrLDGG7xbqClWhCqeusB7VrHQe85FIcEFGK6th2W4Zd7wDlelswfvapwRlDXX7155vDFmesTPbnJOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYYCqjDKDEifFxJP1rUzcAWUxB4knb514aO+Mo0d1Ro=;
 b=HAfWpYNUtMhV7SJHjEEl8b0kw26Pbf14qMku8gVmytA8FpkUMmxaPGhJm51Yyjch+2YMnp2Is467nXCYDPnCgTmBsLGQKkTvOb2C2nUH8SomWRN5kYslf1iupLK5vvgN/DSsxplmSIiZ1gBaNZLVhaB5+309yXzlttXtYUzhmY4=
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by MN6PR10MB7543.namprd10.prod.outlook.com (2603:10b6:208:473::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 10:54:16 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::6a) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 10:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:54:16 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:54:15 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:54:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 05:54:11 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BAs65D3549348;
 Mon, 11 May 2026 05:54:07 -0500
Message-ID: <6dad8477-a34f-4c50-9ce1-7ec1d0f343f3@ti.com>
Date: Mon, 11 May 2026 16:24:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] arm: mach-k3: Update pm-boardcfg for all k3
 platforms
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Abhash Kumar
 <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-17-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260430084414.1354490-17-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MN6PR10MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: ca171123-d4b3-41a8-3fc4-08deaf4ba54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|921020|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info: ix0JAdHBZ1E9tclPuf1jfzDiFTadFIaARcJNuK5F9cWctU/egt9sdbUXUUFhie07eSlmBC5XgJA0IUdexSPtBGo/LgFY+6Kcku0R4tsQjwwIq06pwy7HtnUoVSKPH4DITBSiXRUJU1V0uzgeHnmp2UMh2iU2pc/aTMvU+lS5nIlmfTAYQTRMQzCdcLYqtESxCELNknJrTK1lsR9YLFPr6pGwVFjALA0QvUx9/FrsqCeJEh/mdZtms/1SOkhHK8ShV+nj+6UJZ6sB5gLEEyB7bRHSYyhEVi2XE9XAF12zp5yiYtl3N01wzOw4nH8ZhO0x4Li3aRzmCpa7nvdcD/gozOyBFi0O66HYW9PVH7o66qg3MdZH2UrQ3v1bZsOh5qbjFDqKnzBWBmC0JSpt/euopxjJUWW8IurGVHn0rMhnufyTMq0xRcUrQHvpSdAQ1qCvQ5FUO1Gi1EWTnlcwsmo/B+dSVMZrWLjiWLacebEQd22tJZkMSWW2je9a6iltZpmYdk6pZEozR9rZXVvxPC1eitIkOJfHIs1hejJ9VGb87ZDQLodFCiHvbo05Fo/NAFRcoZnaRuaRvp1qyEteGzenIU+l/zamjIq9O/BQhYSn6E8fsYeHTqYVIqspP1u2Hz8AnmLPzfuOiagfecXPJ/Xcd9Nc699ZISf1lYqcyoR4xOAibzE+DLg98yudAiywmyszrICDqLYU0WS2lNw2ayLGqyX97HQ2OuKvReLK2qRHWa1II3HYoJqQYJIspRKadWsfHVJEZ1VY2HAjFBDyVeLlMw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(921020)(3023799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ske1q71crp75alDc4SDb9wra0LllKMJ0D6F+/opPNb9Bfrkz9iG+ZYXBHo6un/PGRYocclYfaxMkEBehu/fScYMPz+5g0rVWv3dFR7tFpSalEKPm44ttX68d2a/iGP+yaaVxhvedaXYe3J6P34y7kYcxW344A5YPADRRcA+w78Oso9SB0lD8+NVePnTQIhT8zt6EE/LKDZRZe0P6x3qt18zc2afpojKHlie0zCwDwC2zkixNtOtVfLZqS1VlYUqAbNCd5V349q6BRixs8lAwbqTzprEuYpANGBAkp8yXOADsxBrxpM/VP/MnnIWOedbFi7dbSvxq/8dnzL3J7zOUfJpDwHYPVzjabtGcDAqpvgBBsv4xc5avu8esYKPWEvws03+R3fjf55kGr+qB1SWf5+6k7sP2QTrYUM55evubPFaYNVx357luSSdavMehjKIM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:54:16.2705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca171123-d4b3-41a8-3fc4-08deaf4ba54c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7543
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



On 4/30/2026 2:14 PM, Richard Genoud (TI) wrote:
> From: Abhash Kumar Jha <a-kumar2@ti.com>
> 
> Update the pm-cfg and schema to a new version. The new pm-boardcfg has the
> following substructures
> 
> - lpm_cfg : Low Power Mode configuration
> - pll_cfg : PLL configuration
> - dev_cfg : Device Power configuration
> - rsvd_pmic_cfg : Reserved PMIC configuration
> - rsvd_cfg : Reserved cofiguration containing the size for the flexible
>     array appended at the end of pm-boardcfg
> 
> The ABI revision for pm-cfg is also changed from 0:1 to 1:1
> 
> Modify the pm-cfg for am62ax, am62dx, am62px, am62x, am64x, am65x,
> j721s2, j722s to change the hierarchy from "pm-cfg -> rev" to
> "pm-cfg -> pm-boardcfg -> rev".
> 
> This change only adds a new 'pm-boardcfg' property as a parent of the
> 'rev' property, this does not affect the generated pm-cfg binary.
> 
> Add u64 type in schema and update the boardcfg script to deal with u64
> types.
> 
> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> ---
>  arch/arm/mach-k3/schema.yaml            | 195 +++++++++++++++++++-----
>  board/phytec/phycore_am62ax/pm-cfg.yaml |   7 +-
>  board/ti/am62ax/pm-cfg.yaml             |   7 +-
>  board/ti/am62px/pm-cfg.yaml             |   7 +-
>  board/ti/am62x/pm-cfg.yaml              |   7 +-
>  board/ti/am64x/pm-cfg.yaml              |   5 +-
>  board/ti/am65x/pm-cfg.yaml              |   7 +-
>  board/ti/j7200/pm-cfg.yaml              |  92 ++++++++++-
>  board/ti/j721e/pm-cfg.yaml              |  92 ++++++++++-
>  board/ti/j721s2/pm-cfg.yaml             |  94 +++++++++++-
>  board/ti/j722s/pm-cfg.yaml              |   7 +-
>  board/ti/j784s4/pm-cfg.yaml             |  94 +++++++++++-
>  tools/binman/etype/ti_board_config.py   |   4 +-
>  13 files changed, 552 insertions(+), 66 deletions(-)

Please include all K3 platform, otherwise build will fail like beagleboard

> 
> diff --git a/arch/arm/mach-k3/schema.yaml b/arch/arm/mach-k3/schema.yaml
> index 8c4691f24ed6..dbd11b6c864d 100644
> --- a/arch/arm/mach-k3/schema.yaml
> +++ b/arch/arm/mach-k3/schema.yaml
> @@ -19,21 +19,15 @@ definitions:
>          type: integer
>          minimum: 0
>          maximum: 0xffffffff
> +    u64:
> +        type: integer
> +        minimum: 0
> +        maximum: 0xffffffffffffffff
>  
>  
>  
>  type: object
>  properties:
> -    pm-cfg:
> -        type: object
> -        properties:
> -            rev:
> -                type: object
> -                properties:
> -                    boardcfg_abi_maj:
> -                        $ref: "#/definitions/u8"
> -                    boardcfg_abi_min:
> -                        $ref: "#/definitions/u8"
>      board-cfg:
>          type: object
>          properties:
> @@ -283,6 +277,138 @@ properties:
>                          items:
>                              $ref: "#/definitions/u8"
>  
> +    pm-cfg:
> +        type: object
> +        properties:
> +            pm_boardcfg:
> +                type: object
> +                properties:
> +                    rev:
> +                        type: object
> +                        properties:
> +                            boardcfg_abi_maj:
> +                                $ref: "#/definitions/u8"
> +                            boardcfg_abi_min:
> +                                $ref: "#/definitions/u8"
> +
> +                    lpm_cfg:
> +                        type: object
> +                        properties:
> +                            subhdr:
> +                                type: object
> +                                properties:
> +                                    magic:
> +                                        $ref: "#/definitions/u16"
> +                                    size:
> +                                        $ref: "#/definitions/u16"
> +                            suspend_initiator:
> +                                $ref: "#/definitions/u8"
> +                            lpm_mode:
> +                                $ref: "#/definitions/u8"
> +                            lpm_rsvd1:
> +                                $ref: "#/definitions/u16"
> +                            lpm_rsvd2:
> +                                $ref: "#/definitions/u32"
> +
> +                    pll_cfg:
> +                        type: object
> +                        properties:
> +                            subhdr:
> +                                type: object
> +                                properties:
> +                                    magic:
> +                                        $ref: "#/definitions/u16"
> +                                    size:
> +                                        $ref: "#/definitions/u16"
> +                            pll_cfg_entries:
> +                                        type: array
> +                                        minItems: 0
> +                                        maxItems: 5
> +                                        items:
> +                                            type: object
> +                                            properties:
> +                                                dev_id:
> +                                                    $ref: "#/definitions/u32"
> +                                                clk_id:
> +                                                    $ref: "#/definitions/u32"
> +                                                pll_freq:
> +                                                    $ref: "#/definitions/u64"
> +                    dev_cfg:
> +                        type: object
> +                        properties:
> +                            subhdr:
> +                                type: object
> +                                properties:
> +                                    magic:
> +                                        $ref: "#/definitions/u16"
> +                                    size:
> +                                        $ref: "#/definitions/u16"
> +                            dev_cfg_entries:
> +                                        type: array
> +                                        minItems: 0
> +                                        maxItems: 5
> +                                        items:
> +                                            type: object
> +                                            properties:
> +                                                dev_id:
> +                                                    $ref: "#/definitions/u32"
> +                                                state:
> +                                                    $ref: "#/definitions/u32"
> +                                                flag:
> +                                                    $ref: "#/definitions/u32"
> +                    rsvd_pmic_cfg:
> +                        type: object
> +                        properties:
> +                            subhdr:
> +                                type: object
> +                                properties:
> +                                    magic:
> +                                        $ref: "#/definitions/u16"
> +                                    size:
> +                                        $ref: "#/definitions/u16"
> +                            pmic_rsvd1:
> +                                $ref: "#/definitions/u32"
> +                            pmic_rsvd2:
> +                                $ref: "#/definitions/u32"
> +                            pmic_rsvd3:
> +                                $ref: "#/definitions/u32"
> +                    rsvd_cfg:
> +                        type: object
> +                        properties:
> +                            subhdr:
> +                                type: object
> +                                properties:
> +                                    magic:
> +                                        $ref: "#/definitions/u16"
> +                                    size:
> +                                        $ref: "#/definitions/u16"
> +                            rsvd1:
> +                                $ref: "#/definitions/u32"
> +                            rsvd2:
> +                                $ref: "#/definitions/u32"
> +                            rsvd3:
> +                                $ref: "#/definitions/u32"
> +                            reserved_entry_size:
> +                                $ref: "#/definitions/u16"
> +
> +            reserved_entries:
> +                type: array
> +                minItems: 0
> +                maxItems: 2
> +                items:
> +                    type: object
> +                    properties:
> +                        reserved1:
> +                            $ref: "#/definitions/u16"
> +                        reserved2:
> +                            $ref: "#/definitions/u16"
> +                        reserved3:
> +                            $ref: "#/definitions/u16"
> +                        reserved4:
> +                            $ref: "#/definitions/u8"
> +                        reserved5:
> +                            $ref: "#/definitions/u8"
> +
>      rm-cfg:
>          type: object
>          properties:
> @@ -296,36 +422,35 @@ properties:
>                                  $ref: "#/definitions/u8"
>                              boardcfg_abi_min:
>                                  $ref: "#/definitions/u8"
> -
>                      host_cfg:
> -                        type: object
> -                        properties:
> -                            subhdr:
> -                                type: object
> -                                properties:
> -                                    magic:
> -                                        $ref: "#/definitions/u16"
> -                                    size:
> -                                        $ref: "#/definitions/u16"
> -                            host_cfg_entries:
> -                                type: array
> -                                minItems: 0
> -                                maxItems: 32
> -                                items:
> +                            type: object
> +                            properties:
> +                                subhdr:
>                                      type: object
>                                      properties:
> -                                        host_id:
> -                                            $ref: "#/definitions/u8"
> -                                        allowed_atype:
> -                                            $ref: "#/definitions/u8"
> -                                        allowed_qos:
> +                                        magic:
>                                              $ref: "#/definitions/u16"
> -                                        allowed_orderid:
> -                                            $ref: "#/definitions/u32"
> -                                        allowed_priority:
> +                                        size:
>                                              $ref: "#/definitions/u16"
> -                                        allowed_sched_priority:
> -                                            $ref: "#/definitions/u8"
> +                                host_cfg_entries:
> +                                    type: array
> +                                    minItems: 0
> +                                    maxItems: 32
> +                                    items:
> +                                        type: object
> +                                        properties:
> +                                            host_id:
> +                                                $ref: "#/definitions/u8"
> +                                            allowed_atype:
> +                                                $ref: "#/definitions/u8"
> +                                            allowed_qos:
> +                                                $ref: "#/definitions/u16"
> +                                            allowed_orderid:
> +                                                $ref: "#/definitions/u32"
> +                                            allowed_priority:
> +                                                $ref: "#/definitions/u16"
> +                                            allowed_sched_priority:
> +                                                $ref: "#/definitions/u8"
>                      resasg:
>                          type: object
>                          properties:
> diff --git a/board/phytec/phycore_am62ax/pm-cfg.yaml b/board/phytec/phycore_am62ax/pm-cfg.yaml
> index 4031af2f4d3a..2eebba0d986f 100644
> --- a/board/phytec/phycore_am62ax/pm-cfg.yaml
> +++ b/board/phytec/phycore_am62ax/pm-cfg.yaml
> @@ -7,6 +7,7 @@
>  ---
>  
>  pm-cfg:
> -    rev:
> -        boardcfg_abi_maj: 0x0
> -        boardcfg_abi_min: 0x1
> +    pm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> diff --git a/board/ti/am62ax/pm-cfg.yaml b/board/ti/am62ax/pm-cfg.yaml
> index 4031af2f4d3a..2eebba0d986f 100644
> --- a/board/ti/am62ax/pm-cfg.yaml
> +++ b/board/ti/am62ax/pm-cfg.yaml
> @@ -7,6 +7,7 @@
>  ---
>  
>  pm-cfg:
> -    rev:
> -        boardcfg_abi_maj: 0x0
> -        boardcfg_abi_min: 0x1
> +    pm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> diff --git a/board/ti/am62px/pm-cfg.yaml b/board/ti/am62px/pm-cfg.yaml
> index 3ff27ce702c2..15a0cc6e8588 100644
> --- a/board/ti/am62px/pm-cfg.yaml
> +++ b/board/ti/am62px/pm-cfg.yaml
> @@ -7,6 +7,7 @@
>  #
>  ---
>  pm-cfg:
> -    rev:
> -        boardcfg_abi_maj: 0x0
> -        boardcfg_abi_min: 0x1
> +    pm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> diff --git a/board/ti/am62x/pm-cfg.yaml b/board/ti/am62x/pm-cfg.yaml
> index 9853a25eb85c..75cdeb8098fc 100644
> --- a/board/ti/am62x/pm-cfg.yaml
> +++ b/board/ti/am62x/pm-cfg.yaml
> @@ -7,6 +7,7 @@
>  ---
>  
>  pm-cfg:
> -    rev:
> -        boardcfg_abi_maj: 0x0
> -        boardcfg_abi_min: 0x1
> +    pm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> diff --git a/board/ti/am64x/pm-cfg.yaml b/board/ti/am64x/pm-cfg.yaml
> index 7afb29621088..e9866d0ea24d 100644
> --- a/board/ti/am64x/pm-cfg.yaml
> +++ b/board/ti/am64x/pm-cfg.yaml
> @@ -7,6 +7,7 @@
>  ---
>  
>  pm-cfg:
> +    pm_boardcfg:
>          rev:
> -                boardcfg_abi_maj: 0x0
> -                boardcfg_abi_min: 0x1
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> diff --git a/board/ti/am65x/pm-cfg.yaml b/board/ti/am65x/pm-cfg.yaml
> index ee0d1c67a718..50df1310a38d 100644
> --- a/board/ti/am65x/pm-cfg.yaml
> +++ b/board/ti/am65x/pm-cfg.yaml
> @@ -7,6 +7,7 @@
>  ---
>  
>  pm-cfg:
> -    rev:
> -        boardcfg_abi_maj: 0x0
> -        boardcfg_abi_min: 0x1
> +    pm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> diff --git a/board/ti/j7200/pm-cfg.yaml b/board/ti/j7200/pm-cfg.yaml
> index 85cd2c9dbcaf..b38958bea888 100644
> --- a/board/ti/j7200/pm-cfg.yaml
> +++ b/board/ti/j7200/pm-cfg.yaml
> @@ -7,6 +7,94 @@
>  ---
>  
>  pm-cfg:
> +    pm_boardcfg:
>          rev:
> -                boardcfg_abi_maj: 0x0
> -                boardcfg_abi_min: 0x1
> +            boardcfg_abi_maj: 0x1
> +            boardcfg_abi_min: 0x1
> +        lpm_cfg:
> +            subhdr:
> +                magic: 0x4C41
> +                size: 0x0C
> +            suspend_initiator: 0xA
> +            lpm_mode: 0x5
> +            lpm_rsvd1: 0x0
> +            lpm_rsvd2: 0x0
> +        pll_cfg:
> +            subhdr:
> +                magic: 0xC31E
> +                size: 0x54
> +            pll_cfg_entries:
> +                -  # 1
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 2
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 3
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 4
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 5
> +                    dev_id: 0x6
> +                    clk_id: 0x7
> +                    pll_freq: 0x8
> +        dev_cfg:
> +            subhdr:
> +                magic: 0x74B1
> +                size: 0x40
> +            dev_cfg_entries:
> +                -  # 1
> +                    dev_id: 0xB
> +                    state: 0xD
> +                    flag: 0xE
> +                -  # 2
> +                    dev_id: 0xCC
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 3
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 4
> +                    dev_id: 0xCC
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 5
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xCC
> +        rsvd_pmic_cfg:
> +            subhdr:
> +                magic: 0x8A1D
> +                size: 0x10
> +            pmic_rsvd1: 0xA
> +            pmic_rsvd2: 0xA
> +            pmic_rsvd3: 0xDD
> +        rsvd_cfg:
> +            subhdr:
> +                magic: 0x3CFA
> +                size: 0x12
> +            rsvd1: 0x0
> +            rsvd2: 0x0
> +            rsvd3: 0x0
> +            reserved_entry_size: 0x10
> +
> +    reserved_entries:
> +        -
> +            reserved1: 4
> +            reserved2: 93
> +            reserved3: 77
> +            reserved4: 26
> +            reserved5: 0
> +        -
> +            reserved1: 4
> +            reserved2: 93
> +            reserved3: 77
> +            reserved4: 26
> +            reserved5: 0
> diff --git a/board/ti/j721e/pm-cfg.yaml b/board/ti/j721e/pm-cfg.yaml
> index 7ae52b3358e2..0d6b14de817a 100644
> --- a/board/ti/j721e/pm-cfg.yaml
> +++ b/board/ti/j721e/pm-cfg.yaml
> @@ -7,6 +7,94 @@
>  ---
>  
>  pm-cfg:
> +    pm_boardcfg:
>          rev:
> -                boardcfg_abi_maj: 0x0
> -                boardcfg_abi_min: 0x1
> +            boardcfg_abi_maj: 0x1
> +            boardcfg_abi_min: 0x1
> +        lpm_cfg:
> +            subhdr:
> +                magic: 0x4C41
> +                size: 0x0C
> +            suspend_initiator: 0xA
> +            lpm_mode: 0x5
> +            lpm_rsvd1: 0x0
> +            lpm_rsvd2: 0x0
> +        pll_cfg:
> +            subhdr:
> +                magic: 0xC31E
> +                size: 0x54
> +            pll_cfg_entries:
> +                -  # 1
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 2
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 3
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 4
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 5
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +        dev_cfg:
> +            subhdr:
> +                magic: 0x74B1
> +                size: 0x40
> +            dev_cfg_entries:
> +                -  # 1
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 2
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 3
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 4
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 5
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xA
> +        rsvd_pmic_cfg:
> +            subhdr:
> +                magic: 0x8A1D
> +                size: 0x10
> +            pmic_rsvd1: 0xA
> +            pmic_rsvd2: 0xA
> +            pmic_rsvd3: 0xA
> +        rsvd_cfg:
> +            subhdr:
> +                magic: 0x3CFA
> +                size: 0x12
> +            rsvd1: 0x0
> +            rsvd2: 0x0
> +            rsvd3: 0x0
> +            reserved_entry_size: 0x10
> +
> +    reserved_entries:
> +        -
> +            reserved1: 4
> +            reserved2: 93
> +            reserved3: 7744
> +            reserved4: 26
> +            reserved5: 0
> +        -
> +            reserved1: 4
> +            reserved2: 93
> +            reserved3: 7744
> +            reserved4: 26
> +            reserved5: 0
> diff --git a/board/ti/j721s2/pm-cfg.yaml b/board/ti/j721s2/pm-cfg.yaml
> index e6496512b6b7..ce0435165c9e 100644
> --- a/board/ti/j721s2/pm-cfg.yaml
> +++ b/board/ti/j721s2/pm-cfg.yaml
> @@ -7,6 +7,94 @@
>  ---
>  
>  pm-cfg:
> -    rev:
> -        boardcfg_abi_maj: 0x0
> -        boardcfg_abi_min: 0x1
> +    pm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x1
> +            boardcfg_abi_min: 0x1
> +        lpm_cfg:
> +            subhdr:
> +                magic: 0x4C41
> +                size: 0x0C
> +            suspend_initiator: 0xA
> +            lpm_mode: 0x5
> +            lpm_rsvd1: 0x0
> +            lpm_rsvd2: 0x0
> +        pll_cfg:
> +            subhdr:
> +                magic: 0xC31E
> +                size: 0x54
> +            pll_cfg_entries:
> +                -  # 1
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 2
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 3
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 4
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 5
> +                    dev_id: 0x6
> +                    clk_id: 0x7
> +                    pll_freq: 0x8
> +        dev_cfg:
> +            subhdr:
> +                magic: 0x74B1
> +                size: 0x40
> +            dev_cfg_entries:
> +                -  # 1
> +                    dev_id: 0xB
> +                    state: 0xD
> +                    flag: 0xE
> +                -  # 2
> +                    dev_id: 0xCC
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 3
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 4
> +                    dev_id: 0xCC
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 5
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xCC
> +        rsvd_pmic_cfg:
> +            subhdr:
> +                magic: 0x8A1D
> +                size: 0x10
> +            pmic_rsvd1: 0xA
> +            pmic_rsvd2: 0xA
> +            pmic_rsvd3: 0xDD
> +        rsvd_cfg:
> +            subhdr:
> +                magic: 0x3CFA
> +                size: 0x12
> +            rsvd1: 0x0
> +            rsvd2: 0x0
> +            rsvd3: 0x0
> +            reserved_entry_size: 0x10
> +
> +    reserved_entries:
> +        -
> +            reserved1: 4
> +            reserved2: 93
> +            reserved3: 77
> +            reserved4: 26
> +            reserved5: 0
> +        -
> +            reserved1: 4
> +            reserved2: 93
> +            reserved3: 77
> +            reserved4: 26
> +            reserved5: 0
> diff --git a/board/ti/j722s/pm-cfg.yaml b/board/ti/j722s/pm-cfg.yaml
> index 46b3ad201091..ab1c8e06f10e 100644
> --- a/board/ti/j722s/pm-cfg.yaml
> +++ b/board/ti/j722s/pm-cfg.yaml
> @@ -7,6 +7,7 @@
>  ---
>  
>  pm-cfg:
> -    rev:
> -        boardcfg_abi_maj: 0x0
> -        boardcfg_abi_min: 0x1
> +    pm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x0
> +            boardcfg_abi_min: 0x1
> diff --git a/board/ti/j784s4/pm-cfg.yaml b/board/ti/j784s4/pm-cfg.yaml
> index a36b86098998..cbe166808df9 100644
> --- a/board/ti/j784s4/pm-cfg.yaml
> +++ b/board/ti/j784s4/pm-cfg.yaml
> @@ -8,6 +8,94 @@
>  ---
>  
>  pm-cfg:
> -    rev:
> -        boardcfg_abi_maj: 0x0
> -        boardcfg_abi_min: 0x1
> +    pm_boardcfg:
> +        rev:
> +            boardcfg_abi_maj: 0x1
> +            boardcfg_abi_min: 0x1
> +        lpm_cfg:
> +            subhdr:
> +                magic: 0x4C41
> +                size: 0x0C
> +            suspend_initiator: 0xA
> +            lpm_mode: 0x5
> +            lpm_rsvd1: 0x0
> +            lpm_rsvd2: 0x0
> +        pll_cfg:
> +            subhdr:
> +                magic: 0xC31E
> +                size: 0x54
> +            pll_cfg_entries:
> +                -  # 1
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 2
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 3
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 4
> +                    dev_id: 0xA
> +                    clk_id: 0xA
> +                    pll_freq: 0xA
> +                -  # 5
> +                    dev_id: 0x6
> +                    clk_id: 0x7
> +                    pll_freq: 0x8
> +        dev_cfg:
> +            subhdr:
> +                magic: 0x74B1
> +                size: 0x40
> +            dev_cfg_entries:
> +                -  # 1
> +                    dev_id: 0xB
> +                    state: 0xD
> +                    flag: 0xE
> +                -  # 2
> +                    dev_id: 0xCC
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 3
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 4
> +                    dev_id: 0xCC
> +                    state: 0xA
> +                    flag: 0xA
> +                -  # 5
> +                    dev_id: 0xA
> +                    state: 0xA
> +                    flag: 0xCC
> +        rsvd_pmic_cfg:
> +            subhdr:
> +                magic: 0x8A1D
> +                size: 0x10
> +            pmic_rsvd1: 0xA
> +            pmic_rsvd2: 0xA
> +            pmic_rsvd3: 0xDD
> +        rsvd_cfg:
> +            subhdr:
> +                magic: 0x3CFA
> +                size: 0x12
> +            rsvd1: 0x0
> +            rsvd2: 0x0
> +            rsvd3: 0x0
> +            reserved_entry_size: 0x10
> +
> +    reserved_entries:
> +        -
> +            reserved1: 4
> +            reserved2: 93
> +            reserved3: 77
> +            reserved4: 26
> +            reserved5: 0
> +        -
> +            reserved1: 4
> +            reserved2: 93
> +            reserved3: 77
> +            reserved4: 26
> +            reserved5: 0
> diff --git a/tools/binman/etype/ti_board_config.py b/tools/binman/etype/ti_board_config.py
> index 7c6773ac7bcd..b0cd055bf53e 100644
> --- a/tools/binman/etype/ti_board_config.py
> +++ b/tools/binman/etype/ti_board_config.py
> @@ -124,8 +124,10 @@ class Entry_ti_board_config(Entry_section):
>              size = 1
>          elif (data_type == '#/definitions/u16'):
>              size = 2
> -        else:
> +        elif (data_type == '#/definitions/u32'):
>              size = 4
> +        else:
> +            size = 8
>          br = None
>          if type(val) == int:
>              br = val.to_bytes(size, byteorder='little')

