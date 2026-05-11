Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C204CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 10:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A08C847B0;
	Mon, 11 May 2026 12:47:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kqSMrkzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6128485D; Mon, 11 May 2026 12:47:22 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B03F800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRvur09S4V7zhfFvggViQFoziWGGRRvPwVE8ci8qzxCpP3qSBM04EjYO3vxJTyFxwPNM7Lj6skqvs1X9InV/9cuXm62b0ov8iTPcAuhxiti7MM3eLEiigWY/YU2o4cYVb+OG/eA8+HcqC6zsHZNN60pkLAAuEMLtsfx7RzZ1MFTQoGSduUEgAGg++x7OZK6jIsn999BWwjQvKn6S1m0DDrYSOUWWwTvkpzIdtwxHb1xLxIC5xWTnhmaqzz9aCulGR/qqlSbu9c7opdI4L0ETO6zXpCetficekA1Xk49KyTRDjELtN+qNyFsrGo+elP8+Qh+tL18mlGSmGrU3E3eFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h+lgmVQpCozNr/+ifp0BS9qTqNPYILovUF2EEtFPOI=;
 b=Cyzd0To9QRjS1BdLSxMOEyCGXOxKV5PW4vD2JHXIgWBO/xqTMUDrekJhPDoRQHEeLwOOzSeCoHL5JrW8Q6HHH5hlraT5M1Xu8sAJ90mqe+fcpD+honBj89a38GqpnEv71M4IR41neZMBmtVUHRJgKH/ynrGzYvsmhaEASxB3jQ18Eqn5mw4ftRBOeRua/I7bGKl7oXckVOUmyUoHrzqdeCGJbt0HWthJc/izN2bZV/xQeytr5e/vE8lWZLk9tPcWTo5Aq1vccMfXs5Trp94M0M2Z7w8oggNbTAdMg9GV8Ji1mGarentBwj4yhV34oBeYOoPQBZLrWbUsnUXmJvtLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h+lgmVQpCozNr/+ifp0BS9qTqNPYILovUF2EEtFPOI=;
 b=kqSMrkzzacXm76aqEQUxyO9MGRfEWiNozHj+x1k7WcDRcJ/H27aw/qo1LNrWlJeAjLNpsHf3iAsLrwDcAydYC3W3oV5ra2cXCja9f53PavyFFgU9H+a2ynt0mNpykZWGmV4OnatEUvmXWVeGwQv635W2skkAOrKIgqyEr5561IE=
Received: from SJ0PR03CA0175.namprd03.prod.outlook.com (2603:10b6:a03:338::30)
 by BY5PR10MB4290.namprd10.prod.outlook.com (2603:10b6:a03:203::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:47:17 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::d3) by SJ0PR03CA0175.outlook.office365.com
 (2603:10b6:a03:338::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.22 via Frontend Transport; Mon,
 11 May 2026 10:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:47:15 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:47:15 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:47:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 05:47:12 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BAl7dl3206018;
 Mon, 11 May 2026 05:47:07 -0500
Message-ID: <9f8659f1-73c8-400a-9729-cf19afd0a2af@ti.com>
Date: Mon, 11 May 2026 16:17:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] board: ti: j784s4: Add resume detection
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
 <20260430084414.1354490-5-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260430084414.1354490-5-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|BY5PR10MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f95b522-0580-45ed-d1a6-08deaf4aaac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|921020|56012099003|3023799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cLokjanSTwDswHZ+IOPuCNVWrnM04xIOVdIpGo5Zds13IYZKUTcUp3sF/lOPBeCwxdjAGVC8u14HJp0YOq1Hv52S3RR851aY4ZGzCSteE81Cz27CdSPtWJ9uVav7Tfvl5pk70RtdEJbrTfCd9IQQj4DEvgDSeOq43qmfLfIWSjInUVDB3ipkYxRNgqTlBGJhaqSbx2eMj3WW6wSJgc9SLcn9XFxXRCVHNqKD9x7x1J782csRhFxYluDwz9f+4H+WfW2/zu0++3kooSAsGFfQGP2NwShWSmlEa5blxOXoZMJvMefy/l54b8NnnuAlmweJV8PufpOeQkuVrdjmxr7uFoVSFtv90qKGfyte/MzP5WItr2erMnPq8oCi2Lrj5glg9jgPS6B9DIUHxNeiB38MtBQjXdxoezeCVrFmeVXthLEc/5FL/lETBFEF/M5T7UyNkOOhTToh/cyDPEEp3RAPmBOZX3XbRcPStgUU811nYojxoU2Fo4JZu3Vl2auxAddWk3yXKlYBkkFtUA0HmwbisWpNT5S1E3AI8NxZYK//kQhJbcV7UcwUQ5C3RdOj9BwpMT1e5azlIM1T+noyIeL26qQ5QbNHDG216Uz6HHpIOLRXdywWU3X/j//O7GfEXfknCc1mzCIyt2mx6bp0u8K7VIdepxYzedf7ne/2zqCDaA8lb4t47G/CUqoKXfeTJk+rUmoBVqogbTOGxEXk2zHIAvJByrS2vblbdSojZcUEHwj4ZFa/GRK3dEy87BdXaxrDWwj8FLJHmThUnxR+r7DmJw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(921020)(56012099003)(3023799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P+BBMVEN5xrEpcSznGxvRFbRsGU+pfZGF3oAkbv0kWYwigV+kljHPbJA2Q7/kZhpY5gsaVq4HVSAuAdeItp7OPZb3Uv8RPy04tTAupdwfDmIfDK7pq1Qcv2pj0obnGiNoRGOFni4xVECm3hFsSl662U0lx+VLHmwSVPxztp/VQQO3bRFsB2DMW7aquv5e0ks9OFn6y7fgFl0boixcBcW0uoahymJ4v9XerUYS7vQAF/dyl9ttbPgIbFwv7a+7JpgzyIBmUIT3Krn6vfoqAjpvm13IH8GZpnxMm74c44SGkLLa4Ag62y7fzLal85CNb3SOwp7vUmS+13kIn4LHEkI1eWdbNqu26vME4Tvl+6I10nHnVMVLAmXyu6qkb8u6FfR8B8JowUudkW3XnIlNCkTr74LiYk/SjBQL+Eye6wu9pGsYs6v76Bsu8H04J2h5C4Q
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:47:15.9693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f95b522-0580-45ed-d1a6-08deaf4aaac9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4290
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



On 4/30/2026 2:13 PM, Richard Genoud (TI) wrote:
> Add the capability to detect a resume. This overrides the weak
> function j7xx_board_is_resuming().
> To detect the resume, SPL searches a magic value (0xBA) in a register
> of PMIC.
> This value is set by DM-Firmware during the suspend sequence.
> 
> NB: As this is called in board_init_f(), there's no BSS, so we can't
> use global/static variables.
> 
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  board/ti/j784s4/evm.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> index cabb3017ee14..4a74024fe4fe 100644
> --- a/board/ti/j784s4/evm.c
> +++ b/board/ti/j784s4/evm.c
> @@ -12,7 +12,9 @@
>  #include <init.h>
>  #include <spl.h>
>  #include <asm/arch/k3-ddr.h>
> +#include <power/pmic.h>
>  #include "../common/fdt_ops.h"
> +#include "../common/k3-lpm.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -61,6 +63,42 @@ int board_late_init(void)
>  }
>  #endif
>  
> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM))
> +
> +/* in board_init_f(), there's no BSS, so we can't use global/static variables */
> +bool j7xx_board_is_resuming(void)
> +{
> +	struct udevice *pmic;
> +	int err;
> +
> +	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
> +		goto end;
> +
> +	err = uclass_get_device_by_name(UCLASS_PMIC,
> +					"pmic@48", &pmic);
> +	if (err) {
> +		printf("Getting PMIC init failed: %d\n", err);
> +		goto end;
> +	}
> +	debug("%s: PMIC is detected (%s)\n", __func__, pmic->name);
> +
> +	if (pmic_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG) == K3_LPM_MAGIC_SUSPEND) {
> +		debug("%s: board is resuming\n", __func__);
> +		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
> +

Same comment  as patch 3/20

> +		/* clean magic suspend */
> +		if (pmic_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG, 0))
> +			printf("Failed to clean magic value for suspend detection in PMIC\n");
> +	} else {
> +		debug("%s: board is booting (no resume detected)\n", __func__);
> +		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
> +	}
> +end:
> +	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
> +}
> +
> +#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J784s4_R5_EVM */
> +
>  void spl_board_init(void)
>  {
>  	struct udevice *dev;

