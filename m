Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C921CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 12:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BE483B81;
	Thu,  6 Nov 2025 13:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B1nWqT5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACFC583B82; Thu,  6 Nov 2025 13:26:51 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42DFE83B5F
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 13:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4Tvn9gI/wURTr8E+7tYaew1bs36pFTrgG7AGY84s6/UcJlg0K7irYx0yvBW5XAvz/XoDnLJcO3pjMJO9S0z9+8sJNnBBetOscq47dFBoFppX0eg2heMTLO+cXZfuVgchEFqxoi75oAgejp9F2Q4GwNwSg3ZhzlrSguFhkV9aQjuaShXnro5UyD413bjd42ncUBVVuborh91JIPouCKbbtEyA53Pk3CMVWIyuJq/6drk9/dK+1aPIZzmENSgIVN0/IFpAi8tiXtceZDcqem0KIGduqPtdvd9+GOzct2nkvubxUNtQbl/Ot32B/lFe/Y4YY1zn76XXs9FMziPmgpB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vu+bLp+i/tjTZ5XEQL+Z4+YLQyCfrk6c1JUVX4QJ+kQ=;
 b=UAMkghVkbntxKrnrjQZt8FhvwPVIfbAmaFKSMXOhBpf7uwEbYGiXZ/xYKIJXcll1abx1xGv8NfoS8yDXNEZVN8TsNplkjvUyaaSyLNb7vVemwtvfXhL6CW9YVktFP3vwkKU0bVKWKaHCehAT2w0kUEtK9Pbw6s5byq+DlRrXNu5cn9mlNisIG/XiYtgUkxn8X86HBZW/HuFanAuLlYGyCB6BPxmlWX7TAWgnB7/pZ/jDzWJB8RH/UcKiQ6TomF2c7cqgubjvPfy+9a1e+qvLzeuQaZOqCQbM79trAFQOoUrafKRVEcAclIEhp0b1u2v4xkq/vGFKpaV5Ia5N9Eym2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vu+bLp+i/tjTZ5XEQL+Z4+YLQyCfrk6c1JUVX4QJ+kQ=;
 b=B1nWqT5DUFUWq6IaYoxtrMeQSEgCpMtNPu53XBeCYMWXZZ7hrX1jXDHVMfcg2ESDpn8CdpHoRCCmj0c3OLVPRtSN8HAvhTjTqsbMjk+W6EYp7bYWHSAQS7rkvTRlzlElY4FjqSfUq8mpgfdkHxhk3LqcKfy9zpdg1wKCTEJoF+0=
Received: from SA9PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:20::15)
 by CO6PR10MB5569.namprd10.prod.outlook.com (2603:10b6:303:144::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 12:26:45 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::14) by SA9PR03CA0010.outlook.office365.com
 (2603:10b6:806:20::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Thu, 6
 Nov 2025 12:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 12:26:43 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 06:26:40 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 06:26:39 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 06:26:39 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A6CQcag1255819;
 Thu, 6 Nov 2025 06:26:39 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 6 Nov 2025 17:56:38 +0530
Message-ID: <DE1M02OMYGCG.UGUVC26WQW5I@ti.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 0/2] Refactor tidss_drv and enable early splash on AM625
From: Anshul Dalal <anshuld@ti.com>
To: Swamil Jain <s-jain1@ti.com>, <devarsht@ti.com>,
 <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251106085842.629521-1-s-jain1@ti.com>
In-Reply-To: <20251106085842.629521-1-s-jain1@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CO6PR10MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dd5881-b818-46b9-6c62-08de1d2fbe96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|34020700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXIrcTRDamRuQk15MzIyNGRyV0FFSzRpd0lMeXZPS0xRYTlraEpKczUrYmh1?=
 =?utf-8?B?U1oxekN6dzB6WUZIR3NDZCs2eUhVQmtJbGFnTTNySHZKbWxybUphYU5lTnJq?=
 =?utf-8?B?WHFVRk1DQ1YrbUErak8vbE4yaXEwT1RGWmlRd1YrL2ZXYmsvTFhIUm9tT3hk?=
 =?utf-8?B?enJVVjI2TFVMTGdMTFRGRS9LeTFXM00wZHJGbUt5cll5QnRHVGdVSjhkaUZO?=
 =?utf-8?B?YTRrWjc1N0wrWm9vOHpEWndCakZ5dmx1eUtjbDFzNFBlaUQrT0RVMi80WUYw?=
 =?utf-8?B?MGtvbEFmMTZOUlg5cXg1amNJU2hNaVFHYUtzbFlxNWpWdnl1NFpWdXNZV1Nv?=
 =?utf-8?B?OEVQTVNzbEpScEpBSU9qQVBaRFVKM1grMU1QamRsQUNLTUFqcW1KeU52cDY5?=
 =?utf-8?B?ZXpDSFppVkpLL0I0MmUvQUhtR1ZlZ2lPSFlLSjQ0dlR5em5yRzhEM25KWjJE?=
 =?utf-8?B?THo4VmVRYUFDdjRHb3lwcVFHcTdEdUFuTTJqTko2TTlQQTVUSXJmMmxTTnFx?=
 =?utf-8?B?d0xwdk9zbVFEemcyaW1CVFl1eGErSHNmOXF6RVJDdC8wSmcvbzRQT1hmb3VD?=
 =?utf-8?B?QnR2Z3ZzSTltQmRubTdoY2R1b291M0Z4U1pYOTVLd1FsdVBob2dkLzNuRk5k?=
 =?utf-8?B?ZUpOYmVMd3QvZTRGK1FLNHFJenVBU2ZzdHBvQjlPa1NpK2tySlJQeDFyMzNs?=
 =?utf-8?B?M2R6NXU4Ym5QSHptakZReW9Fa1VOYktMSE95Mm9DZFQwZVFqKzQwRm1NdFgx?=
 =?utf-8?B?RjlSbFlvTDlyYlc5S3NJTktXR05MSUlhNHozZFVBSUFCYlFselN6eUdkU2Vl?=
 =?utf-8?B?OHYwUkdNRVlObjd3aFJMdU43Y2dxYmR5ZzljbXlmSXNjS3BuejNGNVY3WURE?=
 =?utf-8?B?eDllc1VwR3crbUZnYkNpRExmSjRWckozcUUyOE1EU2JZRmVpQ0Vza1NabUd1?=
 =?utf-8?B?eFBQR0xpOWNyQ1Q2MXdmL3FqS0JBRGllTm9ZcmVYOFBOQ05VQUJaY09tZXlZ?=
 =?utf-8?B?THpNV3Y0bWVyMjdwbnNVeXZqNXlvbkZydjlVckJTbThVV0RVUjQwN3VmdVYr?=
 =?utf-8?B?M2JlUlRrejNqajVsU2QxemdialJtMlJKbjd3YmpNQWhBckt0MExVSFQxRlh5?=
 =?utf-8?B?SUdaTDR0S1REZ1VXa0FibHl0MmJLNW9LUEM5eDJLaURBa1ZSVFd1RXZaUTBC?=
 =?utf-8?B?WDJsZmxZcXZsQmtWYko5NzZFdVBkNExWUWtubTNXZTZIY1hDd0NaQW9ueUQ5?=
 =?utf-8?B?V3BkbGNhV3R2aGt0RzVPaEVCVHV6Z0FWMlM4a0pjTzJCUEhqZEc1VmRsNDc0?=
 =?utf-8?B?WUVQSmMrSlg4Z0taZFF3SmhNR3E4V0xjYUwyWDVSMGV3dzhFTFBXRzJyMkFG?=
 =?utf-8?B?amtUK0lLMkJOSXdyVG81UkN4NlpRNUlRSlMxbmhHNTRZaHNiZm5NOXVCNXBU?=
 =?utf-8?B?Ylo5ZTNaTGxNN0JZTndDbWE4cnJOR0ZBVGVBaCtYTHZWTXNyd1VRTmcxbEdZ?=
 =?utf-8?B?KzVNQTJBL01RSThIcndQOEtJd000L0pKRnZTSWUxODNhK09Qb3pFR1dtTndP?=
 =?utf-8?B?UEJ1WWtvd1h6UTRmNWpYMXlWTjZOcUdaSCtmZUVFRndZQ3RpWUhLTDU4M0c3?=
 =?utf-8?B?Vyt6Q0QvMmxiY2UvSEUwQ0hPSCtHb0JFcFA5MkdZVmR6VHJYLzZ6aDVtbDEx?=
 =?utf-8?B?a2JjNlRwazJiY3lERGJzbEdXQk5LZWs1L3pyNHhGZUFOUmg3aWNDcHk1bFpl?=
 =?utf-8?B?ZDF4bk4vSHcranVHUnlUd3oxSEt2L05JUHowTUVJWmZTaGpFKzhJOTB3aklo?=
 =?utf-8?B?RXZldWtscmlCREZrRnNqWTE2SjViemcvSTQycDFPdW1VOHhNa2M1U3ZVSEpk?=
 =?utf-8?B?U3ZHUTlEcVdCVy92WFpkNldWUU5Na0JxUGhsRTVrTWdyZGVMaUYrNnJYSThr?=
 =?utf-8?B?cjFxVFFMNSttNmt6TW9vVTY5ejJnWGNOc3o2L2llYzJNekhDOXpUS092MlJH?=
 =?utf-8?B?SXJTMjJCV2NqWHhkRlU1VmNBMk5pZklJVjRPbFk3VXU5VnBvVzlrR3FjT0pl?=
 =?utf-8?Q?rGy8pS?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(34020700016)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:26:43.1153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dd5881-b818-46b9-6c62-08de1d2fbe96
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
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

On Thu Nov 6, 2025 at 2:28 PM IST, Swamil Jain wrote:
> This series:
> - Refactors tidss_drv                                                   =
=20
> - Adds am62x_a53_splashscreen.config to enable splashscreen at u-boot   =
=20
>   SPL
>
> Signed-off-by: Swamil Jain <s-jain1@ti.com>
> ---

Tested-by: Anshul Dalal <anshuld@ti.com>

I also went ahead and did a sandbox build and the driver seems to build
fine contrary to what Tom saw[1].

Below are the steps I followed, am I missing something here?
 1. make sandbox_defconfig
 2. Select CONFIG_VIDEO_TIDSS via menuconfig
 3. make -j`nproc`

[1]: https://lore.kernel.org/u-boot/20251105164114.GQ6688@bill-the-cat/

Regards,
Anshul

> Note:
> - As OLDI specific changes are in progress to be synced to upstream DT,
> use this[1] branch to enable SD-MMC splash on AM62X. Upstream DT changes
> can be found here[2][3].
> - Use TI logo file(ti_logo_414x97_32bpp.bmp.gz) from this link[4].
>
> [1]: https://github.com/swamiljain/u-boot/tree/v3_splash_final
> [2]: https://lore.kernel.org/all/20250913064205.4152249-1-s-jain1@ti.com/
> [3]: https://lore.kernel.org/all/20251017115325.1942591-2-s-jain1@ti.com/
> [4]: https://github.com/swamiljain/ti-splash-logo/blob/main/ti_logo_414x9=
7_32bpp.bmp.gz                                                        =20
> ---
> Changelog v3->v4:
> PATCH 1/2 : Don't include "asm/utils.h" in tidss_drv.c
> PATCH 2/2 : - Move CONFIG_FS_LOADER from am62x_a53_defconfig to
>               splashscreen.config fragment
>             - Minor change in commit message
> Link to v3:
> https://lore.kernel.org/all/20251105163040.4086273-1-s-jain1@ti.com/
>                                                                     =20
> Changelog v2->v3:                                                      =
=20
> - Add splashscreen.config fragment to enable splashscreen              =
=20
> - Align OLDI mode detection logic with kernel side upstreamed OLDI     =
=20
>   series[1]                                                            =
=20
> - Address styling issue mentioned by Devarsh                           =
=20
> - Pick up R-by tag for PATCH 1/2                                       =
=20
>                                                                        =
=20
> Link to v2:                                                            =
=20
> https://lore.kernel.org/all/20250725043012.1186886-1-s-jain1@ti.com/   =
=20
>                                                                        =
=20
> Changelog v1->v2                                                       =
=20
> - Iterate through all available OLDIs                                  =
=20
> - Move dss_oldi_tx_power from tidss_drv.c to tidss_oldi.c              =
=20
> - Rename tidss_attach_active_panel to a more generic name              =
=20
> - To handle all active hw video ports, add an array for active hw vps  =
=20
> - Iterate through all active hw vps to enable respective clks          =
=20
>                                                                        =
=20
> Link to v1: https://lore.kernel.org/u-boot/20250603105735.4038240-1-s-jai=
n1@ti.com/
> ---
>
> Devarsh Thakkar (1):
>   configs: am62x_evm_a53_defconfig: Enable A53 splashscreen at u-boot
>     SPL
>
> Swamil Jain (1):
>   drivers: video: tidss: Refactor tidss_drv
>
>  configs/am62x_a53_splashscreen.config |  17 ++
>  configs/am62x_evm_a53_defconfig       |   3 +-
>  drivers/video/tidss/Makefile          |   2 +-
>  drivers/video/tidss/tidss_drv.c       | 236 +++++++++++------
>  drivers/video/tidss/tidss_drv.h       |  40 ++-
>  drivers/video/tidss/tidss_oldi.c      | 364 ++++++++++++++++++++++++++
>  drivers/video/tidss/tidss_oldi.h      |  72 +++++
>  drivers/video/tidss/tidss_regs.h      |  21 --
>  8 files changed, 631 insertions(+), 124 deletions(-)
>  create mode 100644 configs/am62x_a53_splashscreen.config
>  create mode 100644 drivers/video/tidss/tidss_oldi.c
>  create mode 100644 drivers/video/tidss/tidss_oldi.h

