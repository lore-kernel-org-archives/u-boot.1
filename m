Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD172C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47BE3406AE;
	Tue,  1 Sep 2026 09:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0QyuFL1ffeOs; Tue,  1 Sep 2026 09:02:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788253320;
	bh=dZXROtjS4UWJKlC7AytBP2qMDg7cXQPrCw0iFo1ycUk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QUVn+mLTY+0L0Mwp6Gp3EPJMMB8JXM/lG7POScS7p67h5gY0O8iqUQXpPacohJCDx
	 7xBgJmgM3shaYOV0GxoE0sduFqTsojlbr75Zcp9xXX4nqCxOyhVGe/qFsPjKFyvY/R
	 NammjkLlKatIZrPg+YeK9utE8d8UtkN6Iub5k3RdWkH4NeFLw2pOH9MkxEkULqzPqx
	 ZsGLYz8Sql20VGA1RzyuW2qf/bEziftfhjwz/Y6aLRW/wXwHh4kK/NrDDN50rhUWLe
	 +8/ZANMasgSKSvon+Undm/BlpBm+Zoft4FcbLukgmD9SLglCYFw+oyWlUw4OcgYl7d
	 fkN+dFAVEu8vw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4DCF4051D;
	Tue,  1 Sep 2026 09:02:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0C16363
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3A78606E5
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VvKyfAcjnXdW for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:01:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=ha25GRNv
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E720605E8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWNE4c6OJg++CuOYqOgnfWYTT0t/vpb9Zni5SKq8T4afN7zwWicJg4DXuQLM9fb/LUltntY38aESn9hO/gDJxQSzllzWzqKoVjFf1pCxRg+vcup/NP+BKaoNRQShnuLXY9+qFhPJi9qb/hBtfFE/d/FAF69kBPIPW+N4bB6tTlHOhgiaUt8JC8vuhxFKFFJPu9+083nhmhegTl/GxCc+uhBjdyk7Fah18rx6VwoX+zO+2p/b5N2zXSBR+9FCiWt51K3ny1WiNGVWGhrGpyqQyNX4uWolA2xf8TVQ+jqqu5Q2g1n/fv+T6J1INdc7R57Rcv2BgHwcdFhUW9MykUEWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZXROtjS4UWJKlC7AytBP2qMDg7cXQPrCw0iFo1ycUk=;
 b=upuTCi/d/kRVLCdTBhh4sCWW9CvKjondd7wppWPn2ZwlXzNdgWQE/zvdzm5eLMtoGJ7h4nihXMTA8tWITVVz385HsuSm2S1sqiMc4vjkFb08LsVdZA7tZiZDcsTNLI36FJnKJjmnNunFdYN2ucH1rkez60++l5mSRqa7bgb/mJ+01sYO96senshLwn9AlnoPMj85i4hyyjztzGrjX4+YTb5f7SkdjOXYWeyRtYOtFB6P1YoYkmnf1xBTcF0O488zJ8S+obBddfZVSnIjlbV3OpqeN9C1Is0JbDEjJ6lbzaJjdgrEtB20SrAyu1W9js7e033MdV5vLY+U4i/6CzBbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZXROtjS4UWJKlC7AytBP2qMDg7cXQPrCw0iFo1ycUk=;
 b=ha25GRNvk+AKP7zjnRc31/axGlMl15Y+3FTrUssijStJ6xgAyAlaT1xF89gUiS97koFYXFE/haZP6bULBCkd9NfNOaq91FKrM6KrMpCaaD9IRUu7twaIkKa82G+aUQ8g6L0lROVOeC03a2QjNItO09QzOq/rFgOT9UgMwuznciCU7CA705jk0ckXn4xDtORXncRAAFUObTGWQUwhfb2OudAmFy/9jakDYIOYiUEDcMDAjxLw6/clKeO+o5NH1ZFQ44OHmEayy7qXaJqv9jV6bYFKp7C13JnnUnINEXg03682WoKozyeuxe6cwriZVvcaYvBYm1hv06OUrdBiVCklpw==
Received: from AS4P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::14)
 by BESPR10MB992323.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:108::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:01:52 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::63) by AS4P195CA0023.outlook.office365.com
 (2603:10a6:20b:5d6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 09:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:01:51 +0000
Received: from ENXDAG1NODE4.st.com (10.75.129.197) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 10:59:10 +0200
Received: from [10.48.87.100] (10.48.87.100) by ENXDAG1NODE4.st.com
 (10.75.129.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 1 Sep
 2026 11:01:50 +0200
Message-ID: <5968db82-3945-4446-a03c-b02547605d79@foss.st.com>
Date: Tue, 1 Sep 2026 11:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: st: Fix compilation issue
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
References: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-0-611201a282ce@foss.st.com>
 <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-2-611201a282ce@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-2-611201a282ce@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.100]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To ENXDAG1NODE4.st.com
 (10.75.129.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|BESPR10MB992323:EE_
X-MS-Office365-Filtering-Correlation-Id: 9453237d-c83e-4245-663d-08df0807a9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: xdwEFUSsNGLUnBcSiCTrvvy3cHI36gPV08PWXMPFFOlcUj//nk4cNeYPQyrdlOuSFCAoqQbrXFwzwe6IYHPDfqcG4GV/4U0GAMf+qpn0JSMtoBcRgkJINQTS6dafn5lhdbnmf4KjZUK4ol17S9Tce2V5+Z9eA7vTVnEQgjSQTosdhN/BwK2R3aKIOca+liWanhyUspMmhCqaxAJBnzkn7qW79OY1pIyz2be7+KOc0Zko/7ifPMuJrmduQcipZIE3vfMPSH1yfvwsTjAVAuE6zoDX5MxWb1eevQ6UC8GKeSE6EDNrea2VdJBvPSLxwNmRkw+XAXJ25/Es/o0kh8mCP+5m5QXbI2DiwmC+0dih3pG0YWY5aU0loP8FtKV+rIPijz78YFFUO8IBkWBCgigsbcphwh9B8MgYlEMUEtpQWeb9s+giLE60b0XqX8kN1gqvkgjXNHApnyPiik2NWEy1ccjPKBXDdCfLcT36CXBsDhmwMTx9OksLEOJrnamEdmuDC78xrjdENbXbkGoD7bBqKVYY82Jcs5uFf6RmXphbYae7nsUOmzztY99CLSIeUVie+x8eU1szlqt/HdWSOpKUmDdH79RJcMjebbtqYRF7szDbKBjRAmuTttiecMLWNuPX6NzRM7fMAqUmUkOL+UaH8JbzADTGZoZwTMMKc2m4sScmCt5Kbhc4RWukbURvFCXiybar3QkbS3ovPYGFhd14wQ==
X-Forefront-Antispam-Report: CIP:164.130.1.88; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P/Ec28mvwM6Y4A8Sws4yPC6MynOp/dBfOMLZs/ACkYIPeH7heuC/e0mdMLXpcnp91bv0ywGxTm5YimhAydMUDojyztamuWCPfN7YdA5Fjlho6Ix/zpJIv5hyJxsILttxYMCqNkWvOpRzUxgRqEjL+mQOu8Sc/xTMg2VmGujI3dsauNHmLmSXmUz8sAthj6fPeH6819YUw90SKWgnFwMBHjJ77MvH4l9UdhBd7NBNxvUfKtWYHFQoUEZZYzCz6LolZ28LpckXGJ/6WDmyTOQ3sBASpSXBq8kEk+ZJorEo+1voKOfkJYlRgc1fQ72RfvNacQNMOmr1BGs6BBNGtcnGqn6Gxqch/FPIZOV/SerK4LhdabRPCaRQmp7TGUOMeOFOzDh0Ad7Bdl+1/QcCUJiOgOrr6uPKMzwQMZWHP5igg3jI+6kLM3mGZkoJckf9akSc
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:01:51.7111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9453237d-c83e-4245-663d-08df0807a9e3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.88];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB992323
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi,

On 8/18/26 17:11, Patrice Chotard wrote:
> This patch solves a STM32MP2 compilation issue in
> board/st/common/stm32mp_fwu.c when CONFIG_FWU_MULTI_BANK_UPDATE
> is activated :
>      - error: ‘TAMP_FWU_BOOT_INFO_REG’ undeclared
>      - error: ‘TAMP_FWU_BOOT_IDX_OFFSET’ undeclared
>      - error: ‘TAMP_FWU_BOOT_IDX_MASK’ undeclared
>      - error: implicit declaration of function ‘env_set’
>
> Fixes: 4369c6a05035 ("board: st: factorize STM32MP FWU multi-bank support")
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   board/st/common/stm32mp_fwu.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/board/st/common/stm32mp_fwu.c b/board/st/common/stm32mp_fwu.c
> index ac7ca6bdca2..cff020a99bb 100644
> --- a/board/st/common/stm32mp_fwu.c
> +++ b/board/st/common/stm32mp_fwu.c
> @@ -3,9 +3,11 @@
>    * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
>    */
>   
> +#include <env.h>
>   #include <fwu.h>
>   #include <part_efi.h>
>   #include <asm/io.h>
> +#include <asm/arch/stm32.h>
>   /**
>    * fwu_plat_get_bootidx() - Get the value of the boot index
>    * @boot_idx: Boot index value
>
Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


