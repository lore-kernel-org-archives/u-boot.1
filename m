Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3EACCF9FE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 14:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE9B838EC;
	Fri, 31 Oct 2025 15:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vZigg6qJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BD76838EE; Fri, 31 Oct 2025 15:31:34 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23339836F0
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 15:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHiMcxZiCm0XzpmeZC/jXb85T2HWZr9twwk/jqjRCQWEGNmSLM6y+qU8YTym3+IIGEmK8GqwixqH2Lf3i33ztCtTTG5oMvRLjc2Ipz7+oHkVlbAloiX1jGgpenIP7gp0cygkF7+4ZtnIPeah++XpHxF2bJYtvul1Kk/7YV9QzMfpEK+Y67nzfJqMGyqp+PdlHoOsqAfq/+Qb74H7NUgs0mVo7qYu5X+xk7JaVkD/Kgc5LXOxQpooLXkUTG7ZSivhH+ExvDnqXv1/E78e2KZAoDDmdMgeimp/ddbS0SP+KW6ND+75PDLcRUDqjLpSgcMKWqniEWKDeynLke74ialG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djuYhMw1liJ18cy6NkImQYe/A40GPuMVQbsmekJ9ERQ=;
 b=wa2M7xwDKmItlmt+QNeUThtVg5xH8jMd3vRj3KcBeKs9179vxt7o+s0bZTvjp79F4zWy9rR/8VOjXf/AHamPp45D6uvafWfMp4mSujiqM2Mbami5Tpovv7ru78WgNJGdkDs9Kgo80cS1LO0V1iVfHy6P3m4rSth/zMaS6LjKyFdJOemeCr2ynZBOfQdJarF26PEEPxwI/QYtX+JL5C0nY2V418djNBhg7kdCm/t6oB0SbMLG/FIsdmQJqrvhoMzK9sPE4Y3Rc/DEr70kLR03axgU7ilxz9JFQz9sxKHRAy5Tn4/VpvehO73pkr4U3ed5wJUV0CRgrkt8TPvPflye0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djuYhMw1liJ18cy6NkImQYe/A40GPuMVQbsmekJ9ERQ=;
 b=vZigg6qJEoxODXZ7VfGKz8ZDYiR5IvSQRV/hk6uFLPs9o7mFlqJdB9q6fYOdIZfZStJlG7QRNh/5mp3Dwp77JkoCKuXA3Jpc4e63VPU1gfJg9izobgrq7q1OfPsntNCjPNGw4naf2m+h0jXZHNQWMD8Ea7GkXFvbSC1HVUFOGPU=
Received: from PH7P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::16)
 by DS0PR10MB7477.namprd10.prod.outlook.com (2603:10b6:8:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:31:25 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::44) by PH7P221CA0028.outlook.office365.com
 (2603:10b6:510:32a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 14:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 14:31:23 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:31:11 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:31:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 09:31:11 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VEVBa84052044;
 Fri, 31 Oct 2025 09:31:11 -0500
Date: Fri, 31 Oct 2025 09:31:11 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Neha Malcom Francis <n-francis@ti.com>, <s-k6@ti.com>,
 <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <gehariprasath@ti.com>
Subject: Re: [PATCH 1/6] arm: dts: k3-j7200: ddr: Update to v0.12.0 of DDR
 config tool
Message-ID: <20251031143111.ifk5yqrt5akjakgi@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251031053425.3960963-1-n-francis@ti.com>
 <20251031053425.3960963-2-n-francis@ti.com>
 <20251031113240.b3kdiupm2v6n6tob@bryanbrattlof.com>
 <20251031140810.GA6688@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20251031140810.GA6688@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS0PR10MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 52094817-0083-4e6b-da4e-08de188a2a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|34020700016|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUN4MDBNcThXU0ZQSFdRK0pxQnpmczFUTjFVcWpERzNoaURuL1l0WVAvRkRL?=
 =?utf-8?B?dDZvZkJGaE9yUlh4ZkZFYXlIVHZ1RXNEbkIvUTVlcnRwRE5SSjRqZFN5SENm?=
 =?utf-8?B?UUh3WXRCQ0JYbFAwdDJUMktnWWl6RXVLYnd4WjBZWnRRUEt1TmJGS2x3VFcw?=
 =?utf-8?B?b0NWSjRnaGNLa1JrQktjcEZGOEE3NTNqVEV5YVNHeXdCREZVNEJQWHpEZ3BR?=
 =?utf-8?B?WFFyaVJJSERsbG01Y3JHSEpTdjkxbVdLZ1Zrb2JFRVhpZVNoL09mVlMwalIx?=
 =?utf-8?B?RitjS2ZpeXlPbU1aSVVWdnFQN2h1U1lreEpYREF5RWZoNy9GRjVlTVpLdnFm?=
 =?utf-8?B?VWlVWlZDa2tZSG1pNnA0SlJQOEx5TS9sYitBWTVZOGV1NHZSb3pZVW1XVDhB?=
 =?utf-8?B?RlhzQmFEM21zVG1DamFsUUs2ZkVaSUh5eElHN2poMjJ3TGxYSlhsRTBnL1Vx?=
 =?utf-8?B?ZlVDdGI2NlZpUGlReDlIT0FvVnc4TjZ2amU3b0R0a21FNFJLcFROMjZybWVs?=
 =?utf-8?B?L05mTEkrNVhtZEp2Q2F1OFpMWS9hcWxlMU5TNHRpNWVSbFdKL1RyczVxS25m?=
 =?utf-8?B?cTBnN3BldWFaNzQ1VDdidU5FcDk5R0xRaHk0aERqdVBnNWNhQjIxbWxGTitS?=
 =?utf-8?B?NitZL1BpaEhQdnYxT2J1M1Q0VFdwdkRsZjJ2S3ljYkF2N2w0ZzJnWWkwVkdF?=
 =?utf-8?B?N1h6N0srVkNpRk5tdnF4ZkdCalh0STdOVHNlaTdRSG4vTUN5elJ6cFNSeDE4?=
 =?utf-8?B?MTdXWno3OXFONUZJc21IQ3ZSSnRsOEl5OGtYNCtzNEJKeHY1amhCZjduZ09Q?=
 =?utf-8?B?TUwwVFRTZUV1RWpjMVlNOWJ2eS9kUkRGSy9Pb3B0MkNONDJJZ3FWZUhzcXVh?=
 =?utf-8?B?UEV0Q2E2QXVqYm4ydHpVNUk4cjRXM015QkJOek02amdMQ210QlYwZXpoOUVM?=
 =?utf-8?B?VTBJZWdWOEZ3REh0b0hYS0JYQU1FT1dPckFoSjh4c25KaTRkYkVPQmhxK2k3?=
 =?utf-8?B?aFpjZGgrbkpOZ1NoWFc1SllzQXFNaFZxQ3B3a1lkNk1DRm5hUW54R3o0YTZM?=
 =?utf-8?B?Qm0rU2xYRGFJWXFmSmFlb1p6cnJPSmg3cmpqZlh2dFB5K2N4V0xGd1ZzaURY?=
 =?utf-8?B?OHlWWEs0Sm5mN0dqQlphdUh4QjZUUHNnQzdLRnBrazhDeThHQnJMTDhYVm41?=
 =?utf-8?B?dytuMEJ3WmtOdUkySlN3ZUoxd3VVTWwweHpZZWl4Q0JJejFsU28vcFdieDVQ?=
 =?utf-8?B?c201eFNmdWJ0L1hPeWdlOVowUUVuNkdJeXdnMEZ1TzNpMFl4Z2p0eFIvWUFt?=
 =?utf-8?B?UFJWVUdiUTluU2plNVlwWkhHdXR4UGZqOWs1TnlNTmwxRHNaS2FFeHpPZHFX?=
 =?utf-8?B?bnhaTWV4Ukc4djF2enNzc0twZUx6bXRTa1NKUGhNQmNURjJXQlljQmhiOVlO?=
 =?utf-8?B?RlUvMHpYYTZPWU12TnQxNHRtdDhmSGowd1cwczlsSnE1TTR1dHBmaUFLNjdF?=
 =?utf-8?B?UXY1SlZuYjZlL1Z4RDV0U1lLNy9Kb3RsNzZFc25MYWI0Q29wb2FUVWdwN0dt?=
 =?utf-8?B?L3FqZDEvSDlPZTc0aVFsZjRJM0dvWHZ6dzAyUGFGeTJXNzBYdHdKeDUrOW1s?=
 =?utf-8?B?bGpqTkZnMWc0WHdXZjZxNzQ3NzVkL1V4S1dSMTNncEZtbDV5V1VhdkcyNVdW?=
 =?utf-8?B?dGQ2YTl3S0JmeXZkcDY4REl3NnRXYU16djFSVzJzRHArSHJLR3JVUDhYdzNq?=
 =?utf-8?B?bFRoNXJjV3h5MGNFb2RTdHFtMFdwZ01xM1Y1VzhpYi9MV2doVnFNWnN0N2JW?=
 =?utf-8?B?QjczcmZnQVQ4aWVGSzZEWVJjVkZoRk44R0NkMDUyKzFkUXl0MnpVc2lZZXY3?=
 =?utf-8?B?RHRITG1icGJndG1NZ1ZGSldTVTdZV3VJRDE5NjJMQUFOVTgxcmRKd1NEODdG?=
 =?utf-8?B?UnVDWnRCdjRSNFpYb2tsb0JXOGV6TEN4S2tqcHFMWDBidUl0QjVMZDl6ZlVm?=
 =?utf-8?B?bmZrWUtnTXpDWkVnbEVyZ1pBczdOVmYrQlJycDZST2M2cTFKYzEyZUorMmdj?=
 =?utf-8?Q?DfWJ3W?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(34020700016)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:31:23.0801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52094817-0083-4e6b-da4e-08de188a2a8c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7477
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

On October 31, 2025 thus sayeth Tom Rini:
> On Fri, Oct 31, 2025 at 06:32:40AM -0500, Bryan Brattlof wrote:
> > On October 31, 2025 thus sayeth Neha Malcom Francis:
> > > Update the DDR configuration for J7200 according to the SysConfig
> > > DDR Configuration tool v0.12.0. Log of changes between 0.9.1 to 0.12.0
> > > is [0].
> > > 
> > > [0] https://dev.ti.com/tirex/content/TDA4x_DRA8x_AM67x-AM69x_DDR_Config_0.12.00.0000/docs/RevisionHistory.html
> > > 
> > > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > > ---
> > >  arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi   | 2207 +++++++++++++++++
> > >  .../arm/dts/k3-j7200-r5-common-proc-board.dts |    2 +-
> > >  2 files changed, 2208 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> > > 
> > > diff --git a/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> > > new file mode 100644
> > > index 00000000000..810415494ce
> > > --- /dev/null
> > > +++ b/arch/arm/dts/k3-j7200-ddr-evm-lp4-3200.dtsi
> > > @@ -0,0 +1,2207 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
> > > + * This file was generated with the following tool revisions:
> > > + *     - SysConfig: Revision 1.25.0+4268
> > > + *     - Jacinto7_DDRSS_RegConfigTool: Revision 0.12.0
> > > + * This file was generated on Thu Oct 30 2025 13:11:41 GMT+0530 (India Standard Time)
> > > +*/
> > > +
> > 
> > ...
> > 
> > > diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts 
> > > b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > index e35b767a7e3..3127ac83d7f 100644
> > > --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> > > @@ -6,7 +6,7 @@
> > >  /dts-v1/;
> > >  
> > >  #include "k3-j7200-common-proc-board.dts"
> > > -#include "k3-j7200-ddr-evm-lp4-2666.dtsi"
> > 
> > These are automatically generated files. Why are we keeping the older 
> > configuration around? 
> 
> Is this tool publicly available? If so, using it should be mentioned in
> our docs too, so custom designs can update these more easily.

Yeah, a porting guide would be a good idea. It's part of TI's sysconfig 
tools[0]. Maybe we can add at least a reference to it in the docs.

[0] https://dev.ti.com/sysconfig

~Bryan
