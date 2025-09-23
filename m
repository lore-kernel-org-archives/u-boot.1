Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC51CAC5AA
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 01:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EC5832F9;
	Tue, 23 Sep 2025 03:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="I7aLnE3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57B8483390; Tue, 23 Sep 2025 03:32:07 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F6AD83211
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 03:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4r9NMcTUnHPXj4O3qnTzBEDqwKAaQo/BR8nAeDdOl2ESdSp3W1Nqklx7ffhRXnn1k/3UaNFs1rtxgX22/MobcYQMbzZiPeTk0WbzHATD3or9ooOfBWLxFE+HMC7urdogScu+Io12y7k9tBvdapywsdfxnNzUgYYgMgflirIcM+QhJbQey6ZPiX3Dvv4PJqfzQhs3GYVH14ybT+j/EkXpQhEhPrJD/Y2KrErsE356QMQjuDqEhG/Y+Ru91/4c85OPV82LoI3Ga451P5TI6k74NcnBItUxP1U9328qEiGT9Fc8/4mcT9SOKHPxpa8bgvvtzq7ms86PuojDFLtk0ZrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erf4mJKK1UnrrHRv8+GRC/Bp191NHzj8nm08eMLb/2Y=;
 b=LN+fQuONDjLbbxgUg9b2wLCGbHf13078zUe9pPyPh1wkYfqEEZYMVRt7dr+2YMSXPuHu+OnTCwtKuSQNYG6Zmtgar6HQazSRByzmDPMVRQY5LGWaHSz/ghaP+QfuY4kxgmeYp9ACKMZeaR5ZREoRB8eoT222xR8+jJObdIwysW6katKTzqGesG2IdGJ9vKYo3YfkkN36DEVzlf8+SoFZ18m4Hjb6UGkY3SNGAIp4vDkCV/a1REhAHEvWlFFq0XzqOmCA+ibrLVlk37ZlFSJoYc4YFEdI9vcjD0julTBgMOQav9s517sEtLRBsD1Bxhh4ofW4Gv2y+/Zs7QVqlSphUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erf4mJKK1UnrrHRv8+GRC/Bp191NHzj8nm08eMLb/2Y=;
 b=I7aLnE3fbgcXjonYCGRZnT99NiXF0+8T/f4bIwNHA3SCVI1t+p6bL8YbRarEhEs2wLzy3Tob9NLVFodvx8NToSm+iDbaiu/1G6HbCShEqUmh4y4qJCg+hou6tOR2vaFhCbFJcwwlPT1lJgRhjE+DxL2x0KgIX7N47WWRZ+iJ8GM+gdVYnCUgnzsUcirHcogvK62+SuEWpeqUuoriZD6qKPNO3bkfxxkBRMwXDXct5pgFq1TJ5z/qkUPi+fKfKTXp/Z0+6kT3IiH6tS/O71/LdijvStYEPbpwiScykF99mXq5aGSAS3kTKm8OA+xX4ss4IXFDSWz6jeA+GzyMvwvKBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 01:32:01 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 01:32:01 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] arm: socfpga: mailbox: Remove CONFIG_CADENCE_QSPI guard
 from QSPI mailbox API declarations
Date: Mon, 22 Sep 2025 18:31:47 -0700
Message-Id: <20250923013147.17996-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|PH0PR03MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 66550b1d-ff2c-481f-071d-08ddfa40fe74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Exf1/Hs+fBEPoA+tung+2m5639ndpifDTWEk8uWXBcCd4BzaZhdq83R42VR?=
 =?us-ascii?Q?vVaJHAJk849QMZd9hMPgjqQRsQavkQC8ZbnE7EeeezOt782GPgBvooxqQmd2?=
 =?us-ascii?Q?KRHn2Z3tlo8R4eoTN93dy48BJX9UIUJ+I89pby6m7QydoQpUIXP4FKKOOF1w?=
 =?us-ascii?Q?tem//O65/uOvhMbLDUNNAddpRn6Lyu/yCbOhQR1EIn7EPoYqjzVO5DS7c9OE?=
 =?us-ascii?Q?fpQ9QHSG7jtWsshoWF0+5vPX7JIQUOk4Z/89GHBk7qfvDA6NGrv7izn0HZHk?=
 =?us-ascii?Q?UMNYroPdsYyrAi0Vd+lvqYQfQEZFnUB7BmiO09G0TdSiiRzVaKTQAEiYcjzX?=
 =?us-ascii?Q?0YFcd4+16U3xp09dSb0Z1gb+sJ0NzWqEAAV4qdW5n25YxiHbuOPBvfNgJS1d?=
 =?us-ascii?Q?sDf4XKbifC6eCp3ZcxusMPYBCbxSVk91OHV/eLnG1k9A9psZK73MtZIpmRdI?=
 =?us-ascii?Q?KX0duCqcYZOdiqSgfWIrrE87wgq6zjMYdJxK7rpDP+pMGPTDgcEsieE1xIhf?=
 =?us-ascii?Q?CW8wEFPaX4ug1EIH8GY3XSzMJESnqJTV4nioiPZVjTJ3gjaXlxD0y3QIirW2?=
 =?us-ascii?Q?ViIH5P/HP7QR9pn78/qs7TDYEAr/ExcYLiHEr9uv7YArG+1n4t6USIAAuW1M?=
 =?us-ascii?Q?UOT/p0vTtk51l80381u4CiwuU2sww6bmQ5dW4pa4YQhefH/l3HCiCtxRZWfj?=
 =?us-ascii?Q?/L6hWu1ZhaF/NVDWCD+2ddKGwz7xO49r0JPWoWNCULXBXiIXUzra+fNlS5X0?=
 =?us-ascii?Q?02f64vVfYJZLaUMHsyiljPbg9JaZqLEK/QzT3MauopmdkgYgnRLoYJz8xLfE?=
 =?us-ascii?Q?nVpJ+9ckiwIlqavf4SZo//zeJ6ysUrXoAoYNE5lRxkMQJpPTOUnBxyWir0wx?=
 =?us-ascii?Q?Riswz0UMq9hmnx77aP5Jl7owyadedn1iEZQF3Ls+OY96hSOrNfZ/d57FzHW+?=
 =?us-ascii?Q?o3yfG8dp5jc4qd4j7rUBN0SgkTjrXcgTjW+y3FqIBDoYZYbf9R9UtPl14NVV?=
 =?us-ascii?Q?fq2iZOTtMe8js36souOXGXwQSkku7ZrxKsD1XlIDr33YVi0zx5TNyXKaOjvn?=
 =?us-ascii?Q?hjf2obFp5YfbbYqrs7g8TlGeZhYc5unEjrkW6gF4OWOayXdN4dNGyq8H5h2w?=
 =?us-ascii?Q?pqOK2sh2FdpV3onBftyTevY1mlt8djyqCWgeUJFFs56nuvLS3453eLc7e9xH?=
 =?us-ascii?Q?BZ+AwI4zhiW8YUuZ+1bi59OCZol3AfcOPH9iBMBCxrQkLSop5+jlP5kMRi/r?=
 =?us-ascii?Q?8HiMZDmc8fQEdH+wdoEaHgov2SxTfzoT4pMFgjUA8ij/wbfiKfBMaFVDGa5h?=
 =?us-ascii?Q?ZiXvU1wu32y0REUQets2sit78FogNUj52ZvXg4hAb4k/3KMyoGleq9MpoDzu?=
 =?us-ascii?Q?1IJ3IayDg5uZ6g4P4JdGztLa7UEIp6j0kMUWwxmRCG0P1zZ5ScoEFhaKLAsx?=
 =?us-ascii?Q?IzzRB8HtPUg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1YwhEL150geA1kTVUR50P/4b1Awms2awvMliZfoBvUL7z8MWh8B1QoYpdex8?=
 =?us-ascii?Q?CgZbi4wOs6+rm7TlN1uuso8brac+kD0zFJRHgeXaSMYMzYD/v08mQWzSwqdm?=
 =?us-ascii?Q?ddG/QQYExd7hPuDQc60cxN1dZDYFinBpcKoXSAsqbDtoVHVpabasYEXmq+6V?=
 =?us-ascii?Q?xL4HPZTwuiKc9ifov5pTt+Wdv2WDPBYZKwK3ZRV9MJqsyhPpnQMkspQ83lt2?=
 =?us-ascii?Q?GYBWWHQUJXTbd8VxLGU6SHJI8KBeUbIqCi0zPnIiHNS2JvUuyeDp7odoh+5O?=
 =?us-ascii?Q?wi/uNHfNVzwrei14emCDwkx4wTSP6h+AtIyT6a3ljES7FlaEPhd+ZCRm8CSF?=
 =?us-ascii?Q?Aoo3GV0qfXrTbeKiqfV7+t3Bl6T699bwMJLr6Qr63eLWX/nW4wP1A89h9Nv9?=
 =?us-ascii?Q?guBeVsW0Uao1BS43b0z41vxq4cJs5+IA7ioNcosVlzI7b3Kcj7GsNjg+A7EQ?=
 =?us-ascii?Q?5gVaDzqzx0U3K0rxqiRzcGlQc5cY+EjNhdxIU/K4vGc46+S6UYOvVJl1kw3I?=
 =?us-ascii?Q?ZQs5o78OJD6lkdBUke2poACFymCq5qFfvUOe+Kohu3VN58fdhYQ8L2toqq9u?=
 =?us-ascii?Q?tKujull1oPOwt/QSXEGIfkNZkcnn6J4JETg5hvj1N6+0mLOhCC2bnp7e/Q5N?=
 =?us-ascii?Q?q7gamwjXaNiI7P9wi+pgNmARnFc9+cgwmDDQ/KXTY5HBgCXcCTyeqIsQqkPr?=
 =?us-ascii?Q?Ner4yupx2xOYGZvPiEw55jLC+cqM9treJanpT4Xh0j7bpkI1kE97sRjNxCBz?=
 =?us-ascii?Q?m2HVlzk4A2Zyt965qjnPXUs9MHom33GgG596aQZ0qsI2RIyNzsDWLrT0aOaH?=
 =?us-ascii?Q?G389GIE00pDMpfYDmKkcdSyN5KiTm9qahN9hNDCGXCtPJcvvLV2YH0QesIv1?=
 =?us-ascii?Q?tHDz5jJbxJFRJr7fFFsGSC3X9ebiAm9XYg60Yy4dud8hv25Jhw35D5EvFXHG?=
 =?us-ascii?Q?R9qb0THB6NrEf5+9cGeVCdKELXVr10vIDeS5mq1EYLsnflLV8qXMMqT7rxxY?=
 =?us-ascii?Q?xti9qCgI0h4Ux4RNApsvf0VzxUQ0xl8FKsfMuQ9HKFqFQwiSp8vGx3/7befD?=
 =?us-ascii?Q?LGiyk5IkQXxAunNpJumPk6lSMNsl1q380K4ti5hMdZ0iRj2h1D/OKZlrdZMU?=
 =?us-ascii?Q?TkP+Pi9VasPEUtWNBapXnpjtt+2JDvyqfxGGFiQRpV5nONDJpvn+SwWldtg6?=
 =?us-ascii?Q?YmP//TJhznKUrjTjSm24TygTpB3uK0Q2kBa2MbBKjg/dmhN1TBF1LmjbZ30F?=
 =?us-ascii?Q?L6uzaaj1UFgQUuowpuSW02CE/S1yvonIsugBkm+tgyVjQX2DBmCDwDCrNy4a?=
 =?us-ascii?Q?rji39djLjTn5Kewc57SlUXGMjf4lU4IL6KSiKyhRelX8lgQQSwPylKh9lRi8?=
 =?us-ascii?Q?fZy5TRCAROZEOcqzxSos6Yxj4qv8NN9ciPfSStKPmGqYTPGTz6hDf0NZzSw3?=
 =?us-ascii?Q?B3Ys8Ebap0CTVd1BJxeRcjke3lOAndkum2E9ustA/2TNLCcjv4POizOIyubT?=
 =?us-ascii?Q?ueXeKIBOYOxNEeOswDRPiyM3aGtxPjK+hdyWoQz/lZZ2JNXHgTiEiGBuMSWf?=
 =?us-ascii?Q?tX9s2uSjle9q6GraydukqJ56qllJauD5bBmANAVsq0zUb5u99LLqiAGrXAUa?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66550b1d-ff2c-481f-071d-08ddfa40fe74
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 01:32:01.2301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNVD7Adtp43zaQ0TFuIvuveiXO9Ko3RbA1HOR08ZtupWRTwR7y2VoPYQrMp5x9crtkQ3GoJki88uVXHCLtVN/9yWYDKm0ymR/Agd9jNdkmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6366
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

The QSPI mailbox API function declarations (mbox_qspi_close and
mbox_qspi_open) in mailbox_s10.h were guarded by CONFIG_CADENCE_QSPI
preprocessor conditional. This prevented their prototypes from being
visible to code that may use the stub implementations when
CONFIG_CADENCE_QSPI is disabled.

Remove the CONFIG_CADENCE_QSPI preprocessor conditional so these functions
are always declared, regardless of the configuration. This avoids potential
build or linkage errors when stubs are used.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/mailbox_s10.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
index 2099c51b682..1a461de4819 100644
--- a/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
+++ b/arch/arm/mach-socfpga/include/mach/mailbox_s10.h
@@ -398,10 +398,8 @@ int mbox_rcv_resp(u32 *resp_buf, u32 resp_buf_max_len);
 int mbox_rcv_resp_psci(u32 *resp_buf, u32 resp_buf_max_len);
 int mbox_init(void);
 
-#ifdef CONFIG_CADENCE_QSPI
 int mbox_qspi_close(void);
 int mbox_qspi_open(void);
-#endif
 
 int mbox_reset_cold(void);
 int mbox_hps_stage_notify(u32 execution_stage);
-- 
2.35.3

