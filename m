Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1314D59D99
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 05:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4513E80050;
	Mon, 15 Dec 2025 06:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mp6kFdff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EBB480077; Mon, 15 Dec 2025 06:15:05 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E8878003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 06:15:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHDsN+GOxBRdJUE6KDrwVDbyZBdWPnfuoeuo4oUsFk/KlFh12rwvGEB/DyDdJkdWlCPSdr9MFJR7D/DOPQwvG5IQEHJfKveW9Ppz3n3UbvuJg8mMqRa0CmZ8Ls2lVHnHuHSww6m7YxIive3e+C0tl9POFIW9g2vxOSTwOvgcZzjUUi0SUofkSY1dJY0tN+WViA6i8ym3BmigHT8Zw01hNMP9GFEsDUjqbuLUuSRic+eQkParynGRl0Cm7BCTzkkySr2uoZ6qc2ziYYqQIxJQ2S7ZyJR0nhS//7GQ+X6eDbJR5wiG/lOAT2KFwjT0ORnPZtC7YWfR3jbztPMgHWBlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obfRJctaZ5mvLw9Sw5AqPhD0U76fxDRTXo3k+Uz8cdo=;
 b=tQpEbWWG0d+boJ8YED+f1+Xtz5IWRg+taSxUc88QoywwD4aWqEm7QxtsezCD0quwQTfSaOLpejKFB79say16xfsC6qYXnUEp+hjl9NliW+Nu9M0Tpo8y/vsOqYCKmnn6XPSbIyTCNi7UQoT96+Ckbk7CXEMMAbZMFhAuRGzW1cGd8/kYvc6/6ipML7kjxf+L4nZmP9xE+GMusP6cW9YDNvz2b9UqreIimD1pq8kFGDHNEJG2YB/rXlhCrULHm4qNHmqRkZ5XvDqvmhG4GGzjjQWX0RLHZ1lXAeWEHKveBW9S51dhiAR5q4W33Rj/w3+k9BEzDTOuE4ifVmTSCuMphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=cherry.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obfRJctaZ5mvLw9Sw5AqPhD0U76fxDRTXo3k+Uz8cdo=;
 b=Mp6kFdffQSGa3wigMxkNl2Xr3iXNXJqHmJB9A6ob7hsqeNIRvic4zXpXwDPT0GsutxRtaqkUm//EUWY6x7RZRdCgbOFuoKtsxHUGOPi2WybYlUPJoJY9Z9S1a5JMFXaO52wb0COutoMzd0wKSN2WalZnGknEceARk4zTiGFQ6rg=
Received: from BN0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:e8::10)
 by BL3PR10MB6188.namprd10.prod.outlook.com (2603:10b6:208:3bf::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 05:14:58 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::6b) by BN0PR04CA0035.outlook.office365.com
 (2603:10b6:408:e8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 05:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 05:14:57 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Dec
 2025 23:14:57 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Dec
 2025 23:14:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 14 Dec 2025 23:14:57 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BF5Euxj1846655;
 Sun, 14 Dec 2025 23:14:56 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Dec 2025 10:44:55 +0530
Message-ID: <DEYJ8S11813Z.2FKBDIAXKLH8F@ti.com>
CC: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Udit Kumar
 <u-kumar1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Simon Glass" <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Martin Schwan <m.schwan@phytec.de>, Anshul Dalal
 <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Andre
 Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Justin
 Klaassen <justin@tidylabs.net>, Samuel Holland <samuel@sholland.org>, Rui
 Miguel Silva <rui.silva@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH 0/8] various Kconfig option changes
From: Anshul Dalal <anshuld@ti.com>
To: Quentin Schulz <foss+uboot@0leil.net>, <u-boot@lists.denx.de>, "Philipp
 Tomsich" <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
In-Reply-To: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|BL3PR10MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf14cab-1da2-4264-9fe5-08de3b98e3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|82310400026|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjhpc3VKdXg2bCtZS3IrS01ta0FqT0NyQTduSk5ZbytpZ3gySkVzMFFzRlp2?=
 =?utf-8?B?OUVMa3hOcHpYUFRROGVmV1JYT1ZHVlR4dTZJU3pBTDU4eXd2dTB6RGtqTUhW?=
 =?utf-8?B?SENPOXRhYWFyZzd2ZElPSjk4NXgxZyt0c3hoMEFBS2tuOU9mVUZCN1p5cEZV?=
 =?utf-8?B?ZXErbE93N0xnS25vbGJqd0p3aEVaNklTVFp6YS9KUFl1N3hqNHc5L1c0bGRG?=
 =?utf-8?B?MmNYUS9VL1NsZFBaM0VjTU05Ym9OVnVMaVgrWnBvUURkMG1VNEVwOHhwMklo?=
 =?utf-8?B?RGxDaXUrYzN4NUhxem5zUUpYQmFJdjNZcXNRbHZrRHFuTlUremdpR0pNMytq?=
 =?utf-8?B?bm9hY213MFEvNC80a3ordGlOTC9OOTVqVzR3SDI3dHN0WUl6REFOMzZ4dHhi?=
 =?utf-8?B?ZG1kVklDVFR4TXBKY2FGOHg4b3lyVHp6MHVRdFVCTjNTZXptMTdwTUQ4cmZT?=
 =?utf-8?B?ZFJDSE0zNWhlOWJwc0NYaEJPdnFlZWE3dEZuTUpEYjVnRkNoU2tRRnE2RnZJ?=
 =?utf-8?B?cUFVZFlMem1ibkdOenBTd2NXd3FBR2M5Z0xaUVdpejZuWE9USTBUQmZNZDRq?=
 =?utf-8?B?ZmZDTjdkODlueEhVRmpaUklFaGNFZ2ZuMG1RUGFXcEZUN0NFSGluMGZZYUI1?=
 =?utf-8?B?dGVTWmoySDJleEZRRWhTd0ZHZFR6RkViVGdvNHora041blBtQnd3UzB2MEJ1?=
 =?utf-8?B?eE4ycmwzeVZKemxVR3gzU0k4Q2dEYTRQeGhqSHhXb2w2bU00d21YaDRkSGx1?=
 =?utf-8?B?R1k3U0YzMHRPMjJJZlpieUptUkVpekcremxYVHB1bG1QVzJUYUFoNytDaGg2?=
 =?utf-8?B?eHpyKzNXb3hFbGwrSW43QkpWMHQ5SE53MDF2MHIyc2hPZjJvKzRIdUZrR3JS?=
 =?utf-8?B?U05KSW91RHE2a1haV3AyQVduTWRWeVVMQUJSTjNIZ3M4bkFjS3dkL3JjTUZE?=
 =?utf-8?B?Y1hCUnJuZFRYZ3V0MU01YldwdVRQdnBMTHRKdUFQSVNEc3pBU1NlY0tmUDFn?=
 =?utf-8?B?ZWJFd2dpSWlXbDkzVEZBVVdBaGZpUGYwSThPVGVrZjhxZFYwQVJLRW1BUk4y?=
 =?utf-8?B?aCtTNVU3d0xMaTJZYUF2Mzl1UUdseUdLRWIyMGxGUWJyVk9abDd6VzhEQXhQ?=
 =?utf-8?B?MUxiZDA4VDhld3VBaWQxZGpxU05SU2YxL21UaXl4NGkzVW0zQitzcm5mN1hn?=
 =?utf-8?B?QklxbW02YWk3cTNjY3NaUnVmSkREdERRSUN3V05IT3YxUFM0aFFrUXU1NFkz?=
 =?utf-8?B?ZFVxQUNSd2IzQVpodlRQUllWZDVWbEpzb1NIU2JWVmx3eFdydVhscFhwNVFS?=
 =?utf-8?B?NXJBSXlSZUk3TlpDZHYwWFd2YmJ3c2k3cjFlZFVCNndWb2llRlZNRmRKVkNJ?=
 =?utf-8?B?dHNPdUYvNU5McThqYUZwTGRaU2FRREtLOUZIYWdUVVByTWhERWwwWW1Gb1ov?=
 =?utf-8?B?c2YzZVFwYTJnUTJOeU1Ibm1LUXJHZkxoejJocitmMkpFNGN3NlNzOWlwektP?=
 =?utf-8?B?WnBvUnF2c2JGNWljd3FDVEdoNEdkS0dmSm9Ta3VISnBKa0VpV2hZTGtZRVhY?=
 =?utf-8?B?bmlDREwzZ3hreUZudjBWa3dWVy9MMUh0azEwZU9UZUh1ZnJ5SVJpRWE4RVYy?=
 =?utf-8?B?Y3BEVEt5cEVMTXB6OUJNejRxK0FIRmdKWjZsanVNZVI0bkRGYXloRks2NlJF?=
 =?utf-8?B?Q3Nwa01BOXZVNjUzT2RuMUxtYzNtdkwzbVhNbEJkMEZ6MTAxUENrYi81SElL?=
 =?utf-8?B?SnE2OUtuRFc3RTJhbFZqTWFtd0JCaXpOdTBMYlNwOHdZL25lY1Q1K2N0VWQ3?=
 =?utf-8?B?WTR3dW9BOFdmQThTREFBKzVZVU1GSVVmZ2EvdFhaYmw3S2hhcW9QNWYwL1ZH?=
 =?utf-8?B?NjBPakNyOUVkbGpjMC9mdzJTNjBzUm1YdUhGQzQ3ZzZBTWZvcGV2R1NIL0p5?=
 =?utf-8?B?T0czaDhLQ01vK0dpYmw4eDlReGZIeE1odHNmeTUxRXJ0b1JSbVpCMEpWZ3RI?=
 =?utf-8?B?SzBsWmV0enZ6L0hYTXBjZTk4NWhkakY1Y09pUDlPWFkvcmFJWlhpU3ZGMGFk?=
 =?utf-8?B?MnpMWGNLL3hyMWFMckxrSWR4L3ZFL045bzBPTllGbXM1c1dkWStOMTZBeXBO?=
 =?utf-8?Q?/N14=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 05:14:57.8809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf14cab-1da2-4264-9fe5-08de3b98e3fd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6188
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

On Fri Dec 12, 2025 at 11:43 PM IST, Quentin Schulz wrote:
> This fixes a few prompts for xPL options, puts xPL options together
> again, fixes a missed dependency and removes an option with an
> unmeetable dependency.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

For the entire series,

Reviewed-by: Anshul Dalal <anshuld@ti.com>

Thanks for the fixes!
Anshul,

> ---
> Quentin Schulz (8):
>       Kconfig: put TPL_OPTIMIZE_INLINING next to SPL_OPTIMIZE_INLINING
>       boot: fix prompt for SPL_LOAD_FIT_ADDRESS
>       boot: fix prompt for SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
>       boot: fix prompt for VPL_LOAD_FIT_FULL
>       boot: specify VPL_FIT_FULL_CHECK applies to VPL
>       spl: fix prompt for SPL_BOOTROM_SUPPORT
>       power: regulator: fix dependency for REGULATOR_PWM
>       power: regulator: remove SPL_REGULATOR_PWM due to unmeetable SPL_DM=
_PWM dependency
>
>  Kconfig                         | 18 +++++++++---------
>  boot/Kconfig                    | 16 ++++++++--------
>  common/spl/Kconfig              |  2 +-
>  drivers/power/regulator/Kconfig |  9 +--------
>  4 files changed, 19 insertions(+), 26 deletions(-)
> ---
> base-commit: ff80e95fed188ec3d4001129445e414c9c811beb
> change-id: 20251212-kconfig-reorg-dc64a5724ef5
>
> Best regards,

