Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EE2CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 10:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD70847B0;
	Mon, 11 May 2026 12:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Pkn0ya2V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A7CA84868; Mon, 11 May 2026 12:48:50 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F25846AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubIt1fvU6pRwHI8J3AzGGT/oVk3VwmN398VDkF2/eUYtgsWqtoAzqshN/7oRvqyPjU0J5oMwtpNwBRYh33F7ksXWxLQ66iSWDMeZt7Q77FoMpEm7bmQ6wcLix0aP1irTHK4kEgVhS4C4JRQIbKBH/cO+mJ7xlTIR3hCsdWbkNZasZjP1ouD7GNaAtqP01TstWkVaEvE8vOIHFvfrZ9eHg4noso8VoZCrE8fgt9jGDTZnAMwuVSalFnT9UsXDheJRErrLfW2tjeOpvch+8iEJDwSZyZ2oEGmOkudISBcngIAFl9296dPdNc9NK9LlP75fMlP7XZWVlW0Ngbb9/jtuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43JZL6yNTKaA7okyRHzBk5zl15/d4+AGCaOcsqA0oh4=;
 b=tIsD4FSfZoAbIIY7U1PKplZ6KKiA5dtx5AJdJCKvoYlJHrgPr5e9RTKtgxLtmGzycxxr1wXhNShSNzaT0qmZnJjC4v8G0YHrkf3Aum9YJF0siGgjdmeGKkrGlDRVOw3XDW02hp95hkH5j2Q6dCAoh864HlOIbVdT9+q+TJtH3mKCs1y1L3VLbj/CRB/aLDI5Bd0qOYZ3Lmldz3Gs0ZVfH1hGHftj3ljLZ7iZHSnGwSlgg0o5YFGlE5waGpOTVURVjgOJJsmTSYJQSOsF/5Kjc/xlqJwdLJF/JjPcyFczMmK+LdyydunXEgPq3sA19n/CC4SZgde5+6anNey0NwbdKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43JZL6yNTKaA7okyRHzBk5zl15/d4+AGCaOcsqA0oh4=;
 b=Pkn0ya2VQXO/e8pazke5TRv4614KB1zDCDZtTKqJBLzWM0qlNv6Daw9Ax8xgtZplNv2C4cKCv1jeC+cNerEEHLrprZnMLzxwl/rSzcW65Gyx5LG3n38S8WrGz1e2HeGCl0ZR/5CLItMvl35VUvJrgg6hBt3kRNm/dBbejLkUKwA=
Received: from BLAPR03CA0176.namprd03.prod.outlook.com (2603:10b6:208:32f::26)
 by SJ2PR10MB6990.namprd10.prod.outlook.com (2603:10b6:a03:4d2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:48:44 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::81) by BLAPR03CA0176.outlook.office365.com
 (2603:10b6:208:32f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 10:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:48:42 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:48:40 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:48:37 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 05:48:37 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BAmWtG3542011;
 Mon, 11 May 2026 05:48:32 -0500
Message-ID: <18d03aa5-0c4b-461d-a408-74fb3eeafe0f@ti.com>
Date: Mon, 11 May 2026 16:18:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] board: ti: j721s2: Add resume detection
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
 <20260430084414.1354490-7-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260430084414.1354490-7-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ2PR10MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 5408ae0a-1cc6-4388-c562-08deaf4ade77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|921020|3023799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sRDGuJPRWqjKMIZEbgRBW/w8vvWTCvX1trbxqXp8DcGhPmWx29whNDGyAqBFMdSGpqShN+12SXV827au2NpE2/jYgk0Fjs61pfEHQTBZtpOvPbHvRWWfKoPga9oBBVmgShiLmz/ZbOYT5T2H3kPVGnCF9t+/Ks57x8shdLzZ7eCgTcYA++Uj8pPWr58Jm+k9sUPcTUfXDCT3T4JijQ62W6x2GTE7P+L0+Qg6sJdYEYHsPDPCBjtFTQjKIfPr80l9wvMEYLfrSemidf1mguvKXC/RrWj8iYXqRUGQZSR2Jod6GL515rCHMBVwrNH/URu4+SLvNoTKU3jXhgZh3+V5LO01N9bQ86ro3MMiITVRfefXLJUmG/aqDVKfDqo0CluEW+ZNHMR7tiD25duKpuej0wZqIlQUipmdw/OulDFXvKOTn5S1kZ5mP7f+9banAGaFZP/bY+94/n+1KnH5EV7HpWeIqbyNtykjcZpHPbiU/PdxNInI3hYS+Je82fBR2PwgYknkLUY1N9bYSpxJ7kToSCNZOHfXvJlpigzpTlWTNwJNk/UY2dATOcrFRzVI0awJY+utU8UMJSl7IF3e6q9hcMaC8aYxNLW/AURQ+FbK/q/XkQmj6x4b1EUrGkBnK2yjfzs1WI1lOssQFIdDAhLjvC+V6vgxv2FwYMc3Poef8giOosCspflsjASNRCWvFnVVeyZCWLUPBkWvtJDpQPBkQMATsSFFayXs/LSh85dbFYCzRuGNwyc/wa8CyluNTJ9UemkwZwFKlxxcDWBcpJthiQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(3023799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F0HmJLMYc67Uwwdi5RZOLD4RML0vehUqRTWd5w8GY7X32xhM+Kkng+9J+BkdufnlFz8SJvhrZ/JqM1AMEBvI0CHGEfyJfuMmjo85cg3Bfr8+JeXhoX8zxJl5xSQVnGJKYE1rlCTrIBycFwm8dFRl+KgS8+Q/YqvfiOyv1QzAqRlzfwRaIiCt/2jV02SiSpLDeaYYjxjl+5DHt4m84FU+g9lX34muT4tWsOJ9apd+GNI3w9JtN85ZyOFX6jDC9qFE8rkXN2tMxMkiV4O7gmw2aNv7Z+bcz403MM9eo09WGI3/wUVzHzwNK+SbuycLSphzohfbiGTlmaw0RKw9cR3sV+i621i/acHGY4Ntp1S9PvzO+Nm6tLk60i/3aaYTy6YNWRK2Jj7J/zd5e/QZn9wu/U8Oh/FbfVtLx6jgIJJX7gN3/tbDiJMqhnjkUo0BXom5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:48:42.6808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5408ae0a-1cc6-4388-c562-08deaf4ade77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6990
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
> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
> 
> Add the capability to detect a resume. This overrides the weak function
> j7xx_board_is_resuming(void).
> To detect the resume, SPL searches a magic value (0xBA) in a register of
> PMICA.
> This value is set by DM-Firmware during the suspend sequence.
> 
> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
> ---
>  board/ti/j721s2/evm.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
> index 92d5c8498643..e18ba1a540c9 100644
> --- a/board/ti/j721s2/evm.c
> +++ b/board/ti/j721s2/evm.c
> @@ -22,9 +22,11 @@
>  #include <dm/uclass-internal.h>
>  #include <dm/root.h>
>  #include <asm/arch/k3-ddr.h>
> +#include <power/pmic.h>
>  
>  #include "../common/board_detect.h"
>  #include "../common/fdt_ops.h"
> +#include "../common/k3-lpm.h"
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> @@ -304,6 +306,41 @@ int board_late_init(void)
>  	return 0;
>  }
>  
> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J721S2_R5_EVM) && IS_ENABLED(CONFIG_PMIC_TPS65941))
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
> +		/* clean magic suspend */
> +		if (pmic_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG, 0))
> +			printf("Failed to clean magic value for suspend detection in PMIC\n");
> +	} else {
> +		debug("%s: board is booting (no resume detected)\n", __func__);
> +		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
> +	}

Could all function be combined into common_j7xx_lpm.c for all supporting
SOCs.

> +end:
> +	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
> +}
> +#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J721S2_R5_EVM && CONFIG_PMIC_TPS65941 */
> +
>  void spl_board_init(void)
>  {
>  	struct udevice *dev;

