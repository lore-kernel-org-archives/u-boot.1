Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9A9E83054
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 05:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C98F83FA4;
	Tue,  3 Feb 2026 06:21:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EyxnOF13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5661783FA5; Tue,  3 Feb 2026 06:21:57 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F4483F54
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 06:21:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+OFSIB3fpomGH9Y7pnJ2Rj9od940gKGjA1qwOEGt1mbrk7HZIsfD+x61fFu6Optzn+vYxKAWg5XqLUgkY1F7k8/ZKFUBzd2pxf7mljKpDFGXZ+yKbaNGHgGrTaB4Y3NET0fq7GG4lhmwZLq1ChzttF1UsMpFH0C/CjLHwm/FJDCX236vCuT+xRh3vaEt1mmaisKaWrK70tEBce6sEMFNX1iasoStS75aNvUa+oIvSAx9dr2y8wXFg2gsf3W8OUwz5SKkg7Eixxbnse/bj+Ho2vvHNw+f+E/DqOS/9XR/ha6ZyoyLkbgvooAqjGtgPPFIDohmZKowmIr1HU+/tSxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QatTfHfUMLAZv54fcvODGcnaL+f8MGSB9ecoVvVNdqs=;
 b=I0KUYTAjr2lpveAmUo29dZt/qC7Ic+BBUOiopka64qE5UKcY1oMuGYKC18Rd6vEqJRFCJ0u+QIgeHPxcVEgKR2Xtf4FJiyLAWmjN5xONChCA4XJGpfvJEGqA7pxGXAT2j03MrsgwCyZfZpisWvFKSj0A+RVaGxCgj+YHHo/aiMG53sBFGxfcgK8ju2MHjJFFB9OvplccVqC3df2xqhfapkBs7rr5D2byEPBNuoquxPcbdcmbBSywSxfOfpZqNcmVOLyLG76cCclIkfZEiQNOIjqv+TSrcugZW0CZ30jPoU/zNia+OifAaGp792nVlXMjfIZFM0Bz1Bv0un01mMy7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QatTfHfUMLAZv54fcvODGcnaL+f8MGSB9ecoVvVNdqs=;
 b=EyxnOF13csdUA540depHR/mguREhPwov1kXOEl6mPwMjnaYtXDwZvilVYUnXXgMGeXZMTcFnKbTz45ebB+43KO4VjBbyilaaeSC0b3x1BtjoZ/dORr+8HjslLFZSGQLgP4YpXFDIowb9hRLzK/1l68MXts1R6gKsSsM9y+1kuiE=
Received: from SA9PR13CA0064.namprd13.prod.outlook.com (2603:10b6:806:23::9)
 by CH3PR10MB7187.namprd10.prod.outlook.com (2603:10b6:610:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Tue, 3 Feb
 2026 05:21:50 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::77) by SA9PR13CA0064.outlook.office365.com
 (2603:10b6:806:23::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue, 3
 Feb 2026 05:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 05:21:49 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:21:47 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:21:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 23:21:47 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6135LkAN2953286;
 Mon, 2 Feb 2026 23:21:46 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 3 Feb 2026 10:51:45 +0530
Message-ID: <DG52P91F2IJ0.13IQHK33CRF1E@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] board: ti: j721e,j7200: fix do_main_cpsw0_qsgmii_phyinit
From: Anshul Dalal <anshuld@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <afd@ti.com>, <n-francis@ti.com>, <b-padhi@ti.com>, 
 <ilias.apalodimas@linaro.org>, <peng.fan@nxp.com>, <jerome@forissier.org>,
 <neil.armstrong@linaro.org>, <d-gole@ti.com>, <anshuld@ti.com>,
 <j-humphreys@ti.com>, <semen.protsenko@linaro.org>, <bb@ti.com>,
 <m-chawdhry@ti.com>, <mkorpershoek@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260202141058.648965-1-s-vadapalli@ti.com>
In-Reply-To: <20260202141058.648965-1-s-vadapalli@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH3PR10MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 6594a10d-7458-43d0-bfb3-08de62e421e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TS9Xb2xCKzVKTlJzeVRRb0F4QkRCNjRyaWtoWE55OHVRRHNVZ0NMZzdVZGsw?=
 =?utf-8?B?UXFESXlWSVQ3YUJRUEhJSXIwUUp2R3NodStIUzJzcmxQeStTZDhPUTA2VGVL?=
 =?utf-8?B?V1ZjRXFBMHJqbHZUMW9jUFUxOVppQ0RhK0VNd0kxWkFybHN3SnovSmQxOU5W?=
 =?utf-8?B?S1BXbVUwRDZUOENuRkZaRE05SkRpalo5aGlwbFFTQ3F2RWlTU3UwdThVZTBZ?=
 =?utf-8?B?VUdkS0xmZ3J0c3dHTTZsQktZdHkvNlNkeHMwaFl0bXZJbWhzaUFidU5lenB0?=
 =?utf-8?B?bVVzWGdMQ3prcUdFc0prTThBMTFyaFV3QXlJQzRwWVBJRWg1OWNITHpXcWFQ?=
 =?utf-8?B?Q096bllGdHBPYytxWFlTbGhQT0UvSVFzc2djNjQ0SlQyVy9wb2kwNXFiNVMr?=
 =?utf-8?B?Tnd6cXRqeXEyZWZxRm9OMXk1RXE4UUVNcjRERHYxM2xFams4ZU9CcXF1THpZ?=
 =?utf-8?B?d0w5cFFBSkc3a1ZvcjJBSitaaVpSYW1mdXNqUnp2K3RpK2VnMUI4SVhCRjBB?=
 =?utf-8?B?R3JjZmdhc3l5SjFTWTJvSzFjOUJXZURVcklNNkhPbVU5RW81YUJ4QUxGU3dB?=
 =?utf-8?B?aEhwcU9aMlIva1kvK1doRXpyc0FBb1RIckd2Z0hQb3JKN2g3WUVRTUJ6UGRy?=
 =?utf-8?B?bllodlZrZWdOQnFUa2FFWkhsUk50UTBjOEZud25sK2cyOGh3RGozU2toM040?=
 =?utf-8?B?NXdGMVlYYnlwMGpWa3M2d2ZaUmhaT0ZHWThhREhUSzNOWHBubURPRjNqaFBY?=
 =?utf-8?B?alhvMnZBMTErUWtuSGVtajc2Q0NrMDlUQXpTdnh5MDIrU0lmYUpBRDdQQlJH?=
 =?utf-8?B?RDZwVUxKSW4wdC9MMkpqT1Z6djJmNmhaUUs3ZTV5RVNVdjdiUGQ5ejk4Ukt4?=
 =?utf-8?B?eWxidjhrSllsT1Ivc3AwOG5pWC9tbnZwaG1YYUNDZ0tuUmRwdERlYzdhSDZR?=
 =?utf-8?B?SlFwU21JTkRVUWNNOHFPOW0yQmx6bzJGS1I4L1NaeExlSmdvQ2pSM084SXZn?=
 =?utf-8?B?SjhHSWJlMUxzVmozKzdtWDNTSFJES2lkVzNaakNZZmc1Nk9DRThGdWFFS2ty?=
 =?utf-8?B?eE1PYUJOWkVSRTkxcXN0UzZucEpiMXZaeVRTZk55ZkJZclduMi9aRlpzcVBE?=
 =?utf-8?B?OUswSDM5RCsvNTlRdGdtaE5EdlNKYjRHQTZLcU15Ny93N0FYeUF2c00xeHpw?=
 =?utf-8?B?T1FpN3V1VFRaS3kzc1RGTkJvMjFKWUdsQnZadHhIZ0JtUjRHR3MzNzI0RHg0?=
 =?utf-8?B?SkdUN3ZvREtqVmdQZ29jczgzYld5U1BUQkd2UDRuMXk2WVFQMmJKeGVDeTVL?=
 =?utf-8?B?RVBVbFJCREtUZmQ3alQ2eGlEVWNFY3JERm54RzVad1V5cnl6RWZuZ3VzVzB1?=
 =?utf-8?B?Nkl0T2xCclgvcTBTeTc3UWRXOTlheUQ3WlpJZzM3TDZvdlc4MFFMMVJ3Y1U4?=
 =?utf-8?B?Tkttd2lvYnhCcEFUampqdU5tU1RjMCt0N3crSUtoL0VFUWpWRmhoNjJ0cWdZ?=
 =?utf-8?B?cGhUNDVCQlVHZG5OMW9kUVluK0ZCZnFzVzIrb3RtZ0hWWHgyZS9TWFNlMkFi?=
 =?utf-8?B?QVg4RU14MUhic3duMFYwZ2tQd2tUQ3dFcGMra3ZzdytiSDM5WEZSc1BKMEJR?=
 =?utf-8?B?dDFONUpPVVoreEtFd0VEb0ZjWHVzVjdjb0hKTmlYbE1sT0NqSlhXNHUrMzIv?=
 =?utf-8?B?Yzl2V2sxUlRGNWtScGU2K01jSTFYbW5aYUd6S05vMHQ2VERsczJ2RGIxTk5V?=
 =?utf-8?B?d0lpM0ZWcFVOenV2M3dPWEhmRldvcDdZZ1NoeUUrK2N3dWhDb0laWldMaEdk?=
 =?utf-8?B?OFJ4N0swUE5FMUc4T3prVnl5dlhtUDYySEttbG45RFdobTlrSGxUWnlyR0Fj?=
 =?utf-8?B?YVZKMFh4YXU4ZnlzR2xzdnNlRHZnOFJIZUFDVXdTdHZmQVhmV2hLRDYzVXZI?=
 =?utf-8?B?L0JWTk1oRUZ5clgvVGNXdWdFZHdMSjU5cUxyWEwrYUpHekxha2tVRjF0RW85?=
 =?utf-8?B?M0gyV3pzeFB5aGtvYTFhODdMcXZ6MkVXQkl0MjVuTDNrUEpFTTlCWlpsb1I4?=
 =?utf-8?B?V2tHR0swSWdRQ09yWGZXMUs4Sk5PRHBJLzFodlNEamg3b1NWbmVIVFhQU0Jm?=
 =?utf-8?B?ZjFFWG5lcFk5ZUVwaWo4Wk9GeXV1NDVwbC9WMGpJVU1odDlYM0dkUWxPM2w2?=
 =?utf-8?Q?ajun+aEzez259rZiNEqfkvXsPCp2fUHuxk9bK6lJkgj6?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yaHe6NKIw7aWiawIVBnrvDc8IQEY2p0BqUhEMYMy8apmrW3kHBRVO08RZgEwXCTCtIZioeadSb/SS5UUsjDUgvr35Ah1+f12zj+WhTBVeFr2MGnUU8ZIDuX5kRmYQR81V1cMXV3Q171xNy7bZygLT3t9D2cxeKs9Jf0QOUJhUcBMqqt5i5v9jfsw9T1p88uDzN28uk2vDpqFuAQqb87e7B/HhckDxyJO/7noql7Gmrosuz8PaHIvn9I63UUopr+RaJdTDaSwRVS5e8mt6zjo49mLlT3g9pU/y/M0voFbbQDdonkhyggU6XMbw/26FKc7Fi/0NN6GT7EONZ1Li3T44mCoxm21v7feD/Bw0lHUmK8vQz4Jc2b6sPQUa4kRvcbzbaI6L3oNqlYeknrdgOFC+g+swtmw+1j8pW/vWnLcGzk86xerSIr1rtqpeZA9qO44
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:21:49.3253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6594a10d-7458-43d0-bfb3-08de62e421e6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7187
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

On Mon Feb 2, 2026 at 7:40 PM IST, Siddharth Vadapalli wrote:
> Since commit 27cc5951c862 ("include: env: ti: add default for
> do_main_cpsw0_qsgmii_phyinit"), the value of the environment variable
> do_main_cpsw0_qsgmii_phyinit happened to remain '0' and couldn't be
> changed without user intervention. This behavior is due to the following
> cyclic dependency:
> A) ti_common.env sets do_main_cpsw0_qsgmii_phyinit to '0' and its value
>    can only be updated automatically by main_cpsw0_qsgmii_phyinit.
> B) main_cpsw0_qsgmii_phyinit is defined in j721e.env and it can run only
>    if 'do_main_cpsw0_qsgmii_phyinit' is already '1' which isn't possible
>    unless the user manually assigns the value.
>
> Fix the aforementioned cyclic dependency by using board_late_init() to
> detect the QSGMII Daughtercard and set do_main_cpsw0_qsgmii_phyinit.
>
> Additionally, to address the issue of do_main_cpsw0_qsgmii_phyinit being
> 'undefined' for other platforms, replace:
> 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
> with:
> 	if env exists do_main_cpsw0_qsgmii_phyinit;
> in ti_common.env.
>
> Fixes: 27cc5951c862 ("include: env: ti: add default for do_main_cpsw0_qsg=
mii_phyinit")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>
> Hello,
>
> This patch is based on commit
> eed514b11d0 video: correct label for cyclic video_idle
> of the master branch of U-Boot.
>
> Patch has been tested on:
> 1. J721E-EVM (Has a QSGMII Daughtercard)
> https://gist.github.com/Siddharth-Vadapalli-at-TI/0b453ca7d9e133263ebe10f=
79b3f685f
> 2. J7200-EVM (Has a QSGMII Daughtercard)
> https://gist.github.com/Siddharth-Vadapalli-at-TI/3f408ec145e71404ef46194=
b8c1d4f5b
> 3. AM625-SK (Does not have a QSGMII Daughtercard and the 'undefined
> variable' error isn't seen):
> https://gist.github.com/Siddharth-Vadapalli-at-TI/a16d4a02701b7ef594fd1b9=
8ee015144
>
> Regards,
> Siddharth.
>
>  board/ti/j7200/j7200.env     |  1 -
>  board/ti/j721e/evm.c         | 16 ++++++++++++++++
>  board/ti/j721e/j721e.env     |  3 ---
>  include/env/ti/ti_common.env |  3 +--
>  4 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/board/ti/j7200/j7200.env b/board/ti/j7200/j7200.env
> index 292fc72fd58..e22a954d8db 100644
> --- a/board/ti/j7200/j7200.env
> +++ b/board/ti/j7200/j7200.env
> @@ -26,7 +26,6 @@ bootdir=3D/boot
>  rd_spec=3D-
> =20
>  #if CONFIG_TARGET_J7200_A72_EVM
> -do_main_cpsw0_qsgmii_phyinit=3D1
>  init_main_cpsw0_qsgmii_phy=3Dgpio set gpio@22_17;
>  	gpio clear gpio@22_16
>  main_cpsw0_qsgmii_phyinit=3D
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index e030fe7dc87..d82bf4af7e8 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -403,6 +403,19 @@ static void setup_serial(void)
>  	env_set("serial#", serial_string);
>  }
> =20
> +static void qsgmii_daughtercard_env_update(void)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ext_cards); i++) {
> +		if (!strcmp(ext_cards[i].card_name, "J7X-VSC8514-ETH") &&
> +		    daughter_card_detect_flags[i]) {
> +			env_set("do_main_cpsw0_qsgmii_phyinit", "1");
> +			return;
> +		}
> +	}
> +}
> +
>  int board_late_init(void)
>  {
>  	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
> @@ -412,6 +425,9 @@ int board_late_init(void)
>  		/* Check for and probe any plugged-in daughtercards */
>  		if (board_is_j721e_som() || board_is_j7200_som())
>  			probe_daughtercards();
> +
> +		/* Update env for power-on-reset of the QSGMII Daughtercard */
> +		qsgmii_daughtercard_env_update();
>  	}
> =20
>  	return 0;
> diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
> index ead7fbdb212..34f5f63d60a 100644
> --- a/board/ti/j721e/j721e.env
> +++ b/board/ti/j721e/j721e.env
> @@ -29,9 +29,6 @@ rd_spec=3D-
>  init_main_cpsw0_qsgmii_phy=3Dgpio set gpio@22_17;
>  	gpio clear gpio@22_16
>  main_cpsw0_qsgmii_phyinit=3D
> -	if test $board_name =3D J721EX-PM1-SOM || test $board_name =3D J721EX-P=
M2-SOM || test $board_name =3D j721e; then
> -		do_main_cpsw0_qsgmii_phyinit=3D1; else
> -		do_main_cpsw0_qsgmii_phyinit=3D0; fi;
>  	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1 && test ${dorprocboot} -e=
q 1 && test ${boot} =3D mmc; then
>  		run init_main_cpsw0_qsgmii_phy;			\
>  	fi;
> diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> index 03e3267ef8a..a0ed83f52ac 100644
> --- a/include/env/ti/ti_common.env
> +++ b/include/env/ti/ti_common.env
> @@ -22,11 +22,10 @@ get_fit_overlaystring=3D
>  	done;
>  get_fit_config=3Dsetexpr name_fit_config gsub / _ conf-${fdtfile}
>  run_fit=3Drun get_fit_config; bootm ${addr_fit}#${name_fit_config}${over=
laystring}
> -do_main_cpsw0_qsgmii_phyinit=3D0
>  bootcmd_ti_mmc=3D
>  	run init_${boot};
>  #if CONFIG_CMD_REMOTEPROC
> -	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
> +	if env exists do_main_cpsw0_qsgmii_phyinit;

The patch looks good to me however I wonder if we should factor out
cpsw0_qsgmii related envs out of ti_common.env since as far as I can
tell we only seem to be using it for the j721e/j7200 devices.

>  		then run main_cpsw0_qsgmii_phyinit;
>  	fi;
>  	run boot_rprocs;

