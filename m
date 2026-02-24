Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20441F357AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8325383EE8;
	Tue, 24 Feb 2026 15:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c6wJ0SSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE9783981; Tue, 24 Feb 2026 15:31:22 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060C883981
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHzRMnUlWpGzPTyVjrA6PMT03C5gyyvbFJdAJIDA+7dBIjkk8wyU6enWk9OFs9KK3Jvz3NNig4JQb3EmbPo6UQSFPi+XRdGuQ8DK8jKSGl3MZ+FKfvm1/XJElK8a/BfgWXoN8QxjT8A9XjfLsgUkp1XZpdGARuTIWB4RkM64pyiumoYCEwlKfPhdbOIxoXZDLaFqQTFqHinjwnQbiI6W5RnSYe7KY/lMvE4O21vQdqTkncCAfOtaBbu4R1n5Sa7ct0ft29DQs3FxM88D89OY7fJoMaR/k+e2Me5ozJEas33TGAMU95GOz/6062QEjiAOsXo5yYP3SpZwwuFou2s92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjJdkJ9VtiZ2ajJng9tbWEkZ7FsEqOlRrIiBcJTVqZM=;
 b=CDFan+Xnfkyh1DjjrGG/bbLYtTA9OILZR06EEWLTfg1pLrzXNQwcnFhCy/DX3+DPZbFvyn1pUFAZgu085/JRbHUjFPvdIHnXlwIWtlYCfV0FrGT/e12JsjQxxRJ9BkApL2Qz6L9crdt8lrpqlNUU8qAHRmCMawHFUDl5xqw+g4FkSw2DlUy1t1P97DTyZODSz5H4uMOfFUBkrn3PdqKpYDXSHKDP2BWuLXV7pDaToBwMf1JpN5pTgoF+pBHHpEmRh3vDfteA6sIxU+nbn305qPBdFia3DVx6Z4zefjjEcZqbRjp0TEFVASNolq6QGEtUpv8p4TvSseYHT3jlDFMUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjJdkJ9VtiZ2ajJng9tbWEkZ7FsEqOlRrIiBcJTVqZM=;
 b=c6wJ0SSHDhTLLGePGPIVnonAYTM6ukfup7ftW6q6+A1R9eKbujeQ4hX/M5uP4b4I+KQHO0wgCYPew2D3vzkJPlbouH60tW6eV5eHh63dcJYUon0Hqri58CHayjgnroD2yV5lMdLOkm+X8zR2FFGlsRjt9Kjb9WcSgsYdZy6NFQo=
Received: from CH2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:610:4f::18)
 by SA3PR10MB7096.namprd10.prod.outlook.com (2603:10b6:806:306::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 14:31:13 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::bf) by CH2PR18CA0008.outlook.office365.com
 (2603:10b6:610:4f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend
 Transport; Tue, 24 Feb 2026 14:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 14:31:09 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 08:30:53 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 08:30:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 08:30:40 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OEUeSe2878570;
 Tue, 24 Feb 2026 08:30:40 -0600
Date: Tue, 24 Feb 2026 08:30:40 -0600
From: Bryan Brattlof <bb@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Udit Kumar <u-kumar1@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <nm@ti.com>, <heiko.thiery@gmail.com>,
 <m-shah@ti.com>, <j-keerthy@ti.com>, <n-francis@ti.com>, Diwakar Dhyani
 <d-dhyani@ti.com>
Subject: Re: [PATCH] mach-k3: j722s: unlock mmr after spl_early_init
Message-ID: <20260224143040.b2gvfhcschzznyvt@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260223144558.395289-1-u-kumar1@ti.com>
 <23f03e64-71e3-4fcd-a216-fef7de5a37aa@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <23f03e64-71e3-4fcd-a216-fef7de5a37aa@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|SA3PR10MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ab3235-ad69-466c-305f-08de73b15a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlppZHBTYUk4allsMHZuRHJYL2JadG5teFg3U2srVHZTcno2RlFEdkdVVlYr?=
 =?utf-8?B?RWdnYkVsS1NCYVA0Mm0rWjhEMlNPektyb0JiQkZnbEEyVHNCa1YrTmxaWkV3?=
 =?utf-8?B?ODhkYW5PSjJKRG1KS2kzellmZmhEditKV3BWdDhBWGN2bHU3UEpuMHhpYWM2?=
 =?utf-8?B?ak1ETWV0WGRIWUNiU3gwazdxbGJ4OFFTSlRZVGgzT242WldaS3JIUnA0K0Vq?=
 =?utf-8?B?V2JsN25vQlJQOTZia3B6RlBhdkNqLyszM2ZuaVlMZE9OeXd1Z0tBQitINklh?=
 =?utf-8?B?L3FjNnpXOGdqanFYa0xBVmlVUS8wRy9TTERwVC9SenlBRFZKMHA0Ry9IcmUw?=
 =?utf-8?B?b3kxcWZsdWdmdk1LOVYwNGwxYVRNYW4yN1I5UmltcnU2Uk9vQnFWYlJRRUNo?=
 =?utf-8?B?V1FFUGpCSU1nREtLVU5FVWN0eUNTTUdURlJJMzliSFRKcEJFWThFQXgxZ0hL?=
 =?utf-8?B?aXZsVm1DOGxNazZ5d3h3S1JWcWFPTTJOQWFMdXE4K3dNNSs1RDB4VFJWaGFs?=
 =?utf-8?B?eVFlTEkzYldIVnZldFk2NEVWb3AzbW83WFJrRGVHT2lGVVhDY2o1YUs0QWhK?=
 =?utf-8?B?ZXNFakVFUEsrNDM3YVVWQTJUR2VQMGZ3YjhRYjBZM0RNZzBsbW15WTRob0FD?=
 =?utf-8?B?MVpJZ2ZDdm1vRmFCZ2laU1NWSXEwR3NWVm9uR0c0WW84VUVyTWVVOGdaTVcv?=
 =?utf-8?B?clF2bmdVV3dnWmhXV2Zpc2M1cTZhZUV0Y2dvbDBCOHdtVEVXbFNwTi9xbFlk?=
 =?utf-8?B?aUhBNktUeHI1QmVKVjhLTDdEc1pxQkxoaEUvQmUyVEcxbFY0d29mUzU0ZkFh?=
 =?utf-8?B?TnB6SEVFZkplN2Nzck9lc0FEVnRJWlRzUStOazN6TFFJZHRNdVA3QlpGNXJ3?=
 =?utf-8?B?MUpXbmpKMU9SU0ZiMXBjS3pIbE5JeTJVV3NHSHZiUi9tSEdIME9iOHpHazFh?=
 =?utf-8?B?Z2VOM05uQUhKaC9ybm9JOTduWk9Lakw1WVNBcGpRSHdQd1dCcXJtSW50Sm5p?=
 =?utf-8?B?QXpCc0RIdXBCVkl0NERSNmNPMUtyZ3Y3MWtlTjZaSGtOaW1ObHNFK3oyRUZY?=
 =?utf-8?B?WFBZdlBPOVkxSCs0SC9wZ2d5a1NMQU5vMG9kV2NuL2pweVl5RWp5RUNkc01C?=
 =?utf-8?B?ektFaUJEbXBQaUN0dFhTWFdQVDJaNTNJb25NamR0WFVRbnVqVUd2cldRU0Jr?=
 =?utf-8?B?Y1dwNmoxSTJ5Z3MvVmFpSDNTU0lpUzlGeEtDd1M0a1RPTHhKWWtIU0NvK3Bk?=
 =?utf-8?B?UkJhMWxnNURDYzM4Z0dNcEt0WDd3MTdPeWpJM3NHejJFbkdWTFhvWlg4eGdm?=
 =?utf-8?B?SURhVFNzZnNvaWJKaG9XclRtOWhVWmxXb1ZTeDFtWGNEZDZBOWh5OUFkRTAy?=
 =?utf-8?B?TktwTGtTMjRWL3ZVN2t3SjI3T1VnelF3Z2dLRkVhZ3l6cjYxaEFKRUxpNVVJ?=
 =?utf-8?B?ZHJFZ1JxeFRiWDAzckhwVlBaWUR0WCsrMG1RYXJsV2trbDQrZUJtcXNUNEcx?=
 =?utf-8?B?QlA4OHdsQ09qMFNZWmZDeHBJNFEzTkF2Q1pIWkVXY1hDY0kvVWRxNUNhSVIy?=
 =?utf-8?B?VWVkK3NhdGpNQzd1UXl6WlVZS29QbDJmbmt0WEZnOXRWS1RoM3pQeWpHRHNO?=
 =?utf-8?B?Q2pSTG5yUWlsL2lFMlduR3djeXQwak9lRkprcVMzMklULy96M3VCVHA5bnpi?=
 =?utf-8?B?WXhKV3htZVlYUnh0czdKUDVRVFpWZFBvTG5OSitteHdkbGw4UEd2anloWU5H?=
 =?utf-8?B?NVV2UzExekhjaGpxQjJocWgrSjNkRWhsMml4aEFWeWxvN1hHVmdnYVpLdHdS?=
 =?utf-8?B?ZC9DeUZYRmNlakIwSVJ2KzJUTHhza0E4T3BYTy9EWHdDYnN0dGRZL290a2FU?=
 =?utf-8?B?d3l4REVjVGhycEtlTDlxYlVNaVA4cCtnY0d2SXpOVTJqTDZUTG0xSHU1VUNa?=
 =?utf-8?B?ck1HVXpLQXpRcW9DdnN6VWpEblUyakFFNzlGaWN3ckJaM3VZQkJNUW8ybEFY?=
 =?utf-8?B?VmQveE1xT0piZkFKeEVzVVFGVjZkWTBGbWExZkp3UkFia1Q5MndhM0duSHZX?=
 =?utf-8?B?V1JVa1J5SElKczRvVzV5TTJPaGxHbXZVc1lQTGk4SGJHUU1telNvMHRPK3Yz?=
 =?utf-8?B?ekNxSVN1RC80WldpSDRWSzVoYnZUNWwwc2YzRG8wWjk0Tjg1a25qWE5mTEpH?=
 =?utf-8?Q?HdAfLCiaqRUMoVD4G3NXzNs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sxLdzaN961GbU+1CnNQBdULlPYNnYC8jV/sNzUWZdGgyif+g9I3f3a3dSYIVHM5u6l3yk0qzgynunRF8mUJBkuGizyn60OR1WIUPRRHhIttYx5wMUhaxjzs6C6wY1l438aSoOBmQO07bY3b2ze3r79PMQLT/6a9WHXWwvdNwO7a0sPW5bjA3NMfXD3t6gQ1dPWsI2hSmnI+V0HBQZgyoNA/RCF24l5CBE3n9G/TTM0Yrt2XL4NLnQV/duCZ4iJ+N1P9PXgVcP4J/vfyz15d/3nR+VcVs0id1rsrD9KEvMo7agSgDITetxmvdI8hAa5STaCRYijWWc2fC/5EhiZodJmqfhcPldJps4iGPVUlHVm06SZxJFdoImJiE8Nxz30Wyi0gmdbn45PN2nCUJMQ88TnDxVY49IF/Y7wteEp/UkQyh12gSHAgmwRf6h0jsBxu1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 14:31:09.3111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ab3235-ad69-466c-305f-08de73b15a46
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7096
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

On February 24, 2026 thus sayeth Vignesh Raghavendra:
> 
> 
> On 23/02/26 20:15, Udit Kumar wrote:
> > unlocking control mmr before spl_early_init leads to
> 
> Nit: capitalize the first letter
> 
> > unpredicable behaviour.
> 
> and run through codespell.
> 
> Commit msg is vague. What unpredictable behavior? How do we know moving
> the ctrl_mmr_unlock() to after spl_early_init() really resolves this
> unpredictable behavior?

This is an issue has been reported by many people using any of our SE 
configured reference SoCs which we haven't been able to give an answer 
for.[0]

The current theory is the CTRL_MMR ranges are firewalled by ROM and TIFS 
is unlocking them for us. If that's true then we need to move this until 
after the version message is returned to guarantee the range is unlocked 
by the time we get to this point.

Moving it to after the spl_early_init() adds more time but isn't 
guaranteed with many boots.

[0]  https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/

~Bryan

> 
> > So unlock it after spl_early_init.
> > 
> 
> Wrap commit msg at 80 char uniformly please.
> 
> > Fixes: 5e291ee34fd4 ("arch: mach-k3: Introduce basic files to support J722S SoC family")
> > Reported-by: Diwakar Dhyani <d-dhyani@ti.com>
> > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > ---
> 
> > On HS-SE of J722S in particular, enable_mcu_esm_reset function is not able to reset bit-17 of ctrl mmr CTRLMMR_MCU_RST_CTRL.
> > Which leads to wdt is not functional. With this change
> > bit-17 was getting reset properly on HS-SE and HS-FS devices.
> > 
> 
> This too needs to go into commit msg if not in $subject as this is what
> user actually sees as the issue.
> 
> > HS-FS
> > https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-fs
> > 
> > HS-SE
> > https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-se
> > 
> >  arch/arm/mach-k3/j722s/j722s_init.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
> > index 1180c75f551..a0dab5d7032 100644
> > --- a/arch/arm/mach-k3/j722s/j722s_init.c
> > +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> > @@ -84,13 +84,13 @@ static void k3_spl_init(void)
> >  	 */
> >  	store_boot_info_from_rom();
> >  
> > -	ctrl_mmr_unlock();
> > -
> >  	/* Init DM early */
> >  	ret = spl_early_init();
> >  	if (ret)
> >  		panic("spl_early_init() failed: %d\n", ret);
> >  
> > +	ctrl_mmr_unlock();
> > +
> >  	/*
> >  	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
> >  	 * regardless of the result of pinctrl. Do this without probing the
> 
> -- 
> Regards
> Vignesh
> https://ti.com/opensource
> 
