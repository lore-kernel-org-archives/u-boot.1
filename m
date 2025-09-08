Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBFECA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 06:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2298A8307F;
	Mon,  8 Sep 2025 08:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RYt5JPy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0FB383071; Mon,  8 Sep 2025 08:34:25 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E61882AE9
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 08:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN9oZGfxDmnzCGigS7lDjMAKHXJf04Hf24i3Nn/v6Vw8EdEIPlOEEXm+LrbEN9hcVelwCd5PXhDWsV5qE8tyzZlnycfpTBRnz4v5HGVOidSW+EBNWBtPgw6k1OGkePsG7dVoexF8YM/HzHubQhqJw4dOv6d6ueSETWDLKO2lULKKfokVlqf4trJ6BO/2rtUflT4Bw1Wf7ZUprxYuLzhy/TEHsiqj3WMoXI8juTrlhclL2itX/3F7V41nVMd/EIJn8lDH2pgXkCGcHH8/Y71wjV3NAuYF0dndg3RhssBL6N5JLu48ahdFtmc+s6vy1BBSbj8gTGpwO+qqblDV3J0YKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC9s+rVOZSq1DGyylxJ3Ebo0JMXfaDEDTndOMxNCPAM=;
 b=PLOZHwAQHMyRlKf/d1S9ATy5sAlL/4/5PhXl1DCnOy7jkG+4BocYiwzRmN4sbXo1Rz3TK8RwzTnXlQw63s/dBoYbhPfgdbOvNe4KMjHoSr1nzJQ1RLqXuj9wUjIKOK8Y74SdgIgY2m6if3o5tac/gPzdmbqk6J3BJFQrx3DFA8253EFoILzFjmgTDT0RJZAVMF+wQoHViAHAsthRycryg5p5rBncVdBizEI7LSlI+ATruCqt8GdO7gCLGGdrOZSr7MdnnWcF+huTuU5NKH76/fq59sEgpfbeSfdnlpnm7Y/7K+GEQ6ypRbL/B+/FyNB0kxmi5hcGk1q1uMiiPaMypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC9s+rVOZSq1DGyylxJ3Ebo0JMXfaDEDTndOMxNCPAM=;
 b=RYt5JPy7AsTAbPVeDKPIAFMLI6a/BOIKh9h/akRNpj9H+nk/zTFaxPqP0lBuhoXGdAdvneFYRxm9evKq8e/KCtiJv2UrpQYaLqWfgKSXG15ntMxbGBzRzE04HM6Mw6/gd5mEeRnSJ91oJmS/cKXn1r1eejvyw9DlWsOug82iZ8X41aIvKweU9hGX6uoS0ZUgk4VsA/PPvskIV1DJjH5eKrbVCNthmH3zRvLsyTWSyynHmdwelzhnKwLeFYF5cOwWmcM7Jo+ec21FAmOAbx5GnvBpd88QidFbDVTHXkhhSQju67QAy4cu3sNtY4cvSQC57E6S6o6oA/oVNPmojMkibA==
Received: from DU2PR04CA0199.eurprd04.prod.outlook.com (2603:10a6:10:28d::24)
 by AS8P195MB1223.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Mon, 8 Sep
 2025 06:34:18 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:28d:cafe::d2) by DU2PR04CA0199.outlook.office365.com
 (2603:10a6:10:28d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 06:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 06:34:18 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 8 Sep
 2025 08:34:16 +0200
Received: from llp-moog.phytec.de (172.25.32.60) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58; Mon, 8 Sep
 2025 08:34:16 +0200
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 8 Sep 2025 08:34:00 +0200
Subject: [PATCH v3 3/3] doc: phytec: imx8m: Style and firmware update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-imx8m-optee-enable-v3-3-14bfe249b3c6@phytec.de>
References: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
In-Reply-To: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, "Teresa
 Remmet" <t.remmet@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>, Jan Remmet
 <j.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757313256; l=7533;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=siFp7FHngKJVwgNcPSO8tJbRY7npKP4BBuix0kEZFBg=;
 b=fZcLCh+HA5cVCu8bXh2vYGxnC/8SFx0ilIYAeYk7UQPZe76zZuDGdByOOza2ppWhjM1ktpmoR
 mrMfUYZn0jRBHkVceaawxPporBEvToVn1+L2VsleKr1mf5pqujen98/
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|AS8P195MB1223:EE_
X-MS-Office365-Filtering-Correlation-Id: a6daf3b2-d3e7-46e8-32c8-08ddeea1bd22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0JtaHY3dSs2czB0aFBOSzZ1Y1VEZUxkR2ROTjRtL3BHdXdRR3JDdlc1OGx3?=
 =?utf-8?B?OElPVFBWUUNYd1VJNEdvNmdrYVNYNy85cU10ZElUOCtmWjFEcXdwZnhrREtR?=
 =?utf-8?B?Ync2MTZkUzBDNzBrZlJDZ0ovL3dzTEw4clhiYk1FV0JtR2gvazY4OFM5VDJk?=
 =?utf-8?B?ckVFNjIzcGI3MDZFS0hyeGdqYWVkcnhhUlZscjE3SktWMjRTMjJ5SWFJTUs5?=
 =?utf-8?B?TUxhcStZdTlhdWs0ZGh6OHQ2eUpXSjNWOFlYQmNyZThqUjdQMlVtMTl5RGxB?=
 =?utf-8?B?amVmd0lUYzNSSzFVd216VTVwUVdWV1BXWjZBYWJEcEJYNkRxOGw4RGUraVVN?=
 =?utf-8?B?dCs0N2xvMkxSYkJLQm5TR3RVRzBZWTFKN0RETDErRTFxb3phRlViWkpQSjgv?=
 =?utf-8?B?QldKNW0xN1pLRDFOd0hzU2ttVkVoTU9RdWQ4WTJWVGtSdXlYS0FyRzh4TkJr?=
 =?utf-8?B?cHVjV29VcVEyS0tMenZIL1QvT0haWGE0STNuWWNSNmhkYnFicnVCdGJwZ09Q?=
 =?utf-8?B?YXJIYkJkYlQzRDhtQlZyK3VoSjkzMlhwNFcrUTZVQzZxZzloeXp4NkdPbklx?=
 =?utf-8?B?MEljR0V1R2x4dE5OUjd4UlBEY0YvVjNzN0Y5NnlMK3g4R0s4R0dZTndEaU1B?=
 =?utf-8?B?K3JpaVp6aDNaNjVOMU9ENTE0LzQwTW1lMXVMb253VUQ4dTdjNE5PNDIzMkZU?=
 =?utf-8?B?cGorNG93YzhoMCsrYUQ3OGxOSVFwTVBMeVg4TmIyc1RjSG1yL1ZhY29FeUEw?=
 =?utf-8?B?R0g4a3hBQ0xkQmZoSEF0NVJNaTJ4Mk5lRjBzQU9zM0szNnRORXRTd2tXUDN3?=
 =?utf-8?B?WklSWGtValE0cmpEbkpSZU1JVE91ZXIyYzNnaHpLYTVXUlNtSTVkSHVyTlpU?=
 =?utf-8?B?V1l4b25ZMEZScGV2TE1FYXJ0WEZlT1V1NEtGcWFOSG91aUVYNHFudzVVZkRI?=
 =?utf-8?B?S1FLY1l0UVJtUWVDQnRTMVB0Wnk1WHcraTI0RkUzdXJzZkNRMXQ4UjRiRnlj?=
 =?utf-8?B?Wk5BZDBpSEtiMlpReXkrdzZwS2Q5WGhaNkk0emEvWndGUWpjWEllN2xRa1M4?=
 =?utf-8?B?YUNyWjh3VzlncUlnb1JKanR6MDFsRHd5M09UUFNRWGw5WWd6R3IzaWppWVdE?=
 =?utf-8?B?bmZ4MGJMQlk5L0ZZL3JGbXdvK3Y5enhtRjRDenI1WGdIdHMxblBwTU8vSjZP?=
 =?utf-8?B?bmh4TVNhS2E2VENXL21HZkF1bFYrVHpUdzQ4OFVUNkFNcytpV3gyOG5DdkxZ?=
 =?utf-8?B?aG5uOGF4Q1BzY1VSejk0ejVMTzdNUzBUZmdvWm9Sd2RaSWhlZDhTNlhDaDd5?=
 =?utf-8?B?ckpYR0dIOTdXSkN4M25GeVFlYWFTUXQwRm5NZGUzeU5ZVTZxdng5REk2TUpl?=
 =?utf-8?B?V044RVBFREovelN2SGs0aXlSdndyMllwTVdRUjVTMFdqajlnUXZqNnhuU0hX?=
 =?utf-8?B?a3lobGpoOVVMRjY0YTkxM04ydDlsUzhZTlMxbU1KZDlKWnAxaERLQ3VtVmFi?=
 =?utf-8?B?Z2lYYnpSOUdvY2pwZ0wwUFBUdWp6bVB5bHNBdWlZeWw5aVVOQ2dUOXd6YlVJ?=
 =?utf-8?B?V1k3aVRpMWQrNnYxR3JZdDJjT3BiUjVhNm14dWcyYkVKSElXNkt2a2E1dUs5?=
 =?utf-8?B?dGI2QkNiVUNLYy9MTzQxT2o2R1pQSVBONG51TTBJRTlUZjlLSy9TNFFpdURR?=
 =?utf-8?B?Q0NoZGZJaG14UjNiS0ZraVVBVWpHR045cFNUVVR3UGNJdW9jOFc3QUNRVlVy?=
 =?utf-8?B?MHFOTnBicWd6TmRwQkNzMU9oVHJqbzRSYWlwa2RNMU9VMm1nRkdVcldXdFJF?=
 =?utf-8?B?R0lhU0Z2S0RyeU5uS2srcWZDdi9WMDFrNXBIa3Z1ekVEclJKVVF5TkN3MUt0?=
 =?utf-8?B?UklmakNJS1VseFRXcWdOQWJMY1BUYzluNUljUG81dWNYbDROMCs3U2tZZ1Av?=
 =?utf-8?B?ZU1EOTM0RUhjdUwyUWYyS0ZpdXM4eFZocG5IMm9xblJvWU01d3RvY2prbnM5?=
 =?utf-8?B?NmlhTWhkWit3PT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:34:18.6056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6daf3b2-d3e7-46e8-32c8-08ddeea1bd22
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1223
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

Use single make command for compiling blobs and U-Boot.
Update the imx firmware version.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 doc/board/phytec/imx8mm-phygate-tauri-l.rst | 27 ++++++++++++++--------
 doc/board/phytec/phycore-imx8mm.rst         | 28 ++++++++++++++--------
 doc/board/phytec/phycore-imx8mp.rst         | 36 +++++++++++++++++------------
 3 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
index 7efc9392361b4a867ce2bc18db11aacf31208800..4dd82cd9785fa585ed216664a25f593d4e723dbb 100644
--- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
+++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
@@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30880000
-   $ make PLAT=imx8mm BL32_BASE=0xbe000000 SPD=opteed bl31
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mm \
+          IMX_BOOT_UART_BASE=0x30880000 \
+          BL32_BASE=0xbe000000 \
+          SPD=opteed \
+          bl31
 
 Build the OP-TEE binary
 -----------------------
@@ -32,8 +36,9 @@ Build the OP-TEE binary
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
+   $ make -j $(nproc) \
           CROSS_COMPILE=aarch64-linux-gnu- \
+          CFG_TEE_BENCHMARK=n \
           O=out/arm \
           PLATFORM=imx-mx8mm_phygate_tauri_l
 
@@ -42,9 +47,9 @@ Get the ddr firmware
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.23.bin
-   $ chmod +x firmware-imx-8.23.bin
-   $ ./firmware-imx-8.23.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -56,15 +61,17 @@ Copy binaries
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
    $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
-   $ cp firmware-imx-8.23/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make imx8mm-phygate-tauri-l_defconfig
-   $ make flash.bin
+   $ make -j $(nproc)
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          imx8mm-phygate-tauri-l_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^
diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
index ba6299a968ae9980d583b87b46dcccba5aa4a186..d5edbc91474e95f677dd12e5fcc6c16092dea1cd 100644
--- a/doc/board/phytec/phycore-imx8mm.rst
+++ b/doc/board/phytec/phycore-imx8mm.rst
@@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30880000
-   $ make PLAT=imx8mm BL32_BASE=0x7e000000 SPD=opteed bl31
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mm \
+          IMX_BOOT_UART_BASE=0x30880000 \
+          BL32_BASE=0x7e000000 \
+          SPD=opteed \
+          bl31
 
 Build the OP-TEE binary
 -----------------------
@@ -32,8 +36,9 @@ Build the OP-TEE binary
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
+   $ make -j $(nproc) \
           CROSS_COMPILE=aarch64-linux-gnu- \
+          CFG_TEE_BENCHMARK=n \
           O=out/arm \
           PLATFORM=imx-mx8mm_phyboard_polis
 
@@ -42,9 +47,9 @@ Get the ddr firmware
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
-   $ chmod +x firmware-imx-8.19.bin
-   $ ./firmware-imx-8.19.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -55,15 +60,18 @@ Copy binaries
 .. code-block:: bash
 
    $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
-   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make phycore-imx8mm_defconfig
-   $ make flash.bin
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          phycore-imx8mm_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^
diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
index e1385be25e1a862db7021e29cd5d0d3ba68cc01b..8995a2965328dc645fd29ad979e399bf7652106c 100644
--- a/doc/board/phytec/phycore-imx8mp.rst
+++ b/doc/board/phytec/phycore-imx8mp.rst
@@ -3,7 +3,7 @@
 phyCORE-i.MX 8M Plus
 ====================
 
-The phyCORE-i.MX 8M Plus with 2GB of main memory is supported.
+The phyCORE-i.MX 8M Plus with 1,2,4GB of main memory is supported.
 
 Quick Start
 -----------
@@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
 
    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
    $ cd trusted-firmware-a
-   $ export CROSS_COMPILE=aarch64-linux-gnu-
-   $ export IMX_BOOT_UART_BASE=0x30860000
-   $ make PLAT=imx8mp BL32_BASE=0x7e000000 SPD=opteed bl31
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mp \
+          IMX_BOOT_UART_BASE=0x30860000 \
+          BL32_BASE=0x7e000000 \
+          SPD=opteed \
+          bl31
 
 Build the OP-TEE binary
 -----------------------
@@ -32,20 +36,20 @@ Build the OP-TEE binary
 
    $ git clone https://github.com/OP-TEE/optee_os.git
    $ cd optee_os
-   $ make CFG_TEE_BENCHMARK=n \
-     CROSS_COMPILE=aarch64-linux-gnu- \
-     O=out/arm \
-     PLATFORM=imx-mx8mp_phyboard_pollux \
-     CFG_TZDRAM_START=0x7e000000
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          CFG_TEE_BENCHMARK=n \
+          O=out/arm \
+          PLATFORM=imx-mx8mp_phyboard_pollux
 
 Get the ddr firmware
 --------------------
 
 .. code-block:: bash
 
-   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
-   $ chmod +x firmware-imx-8.19.bin
-   $ ./firmware-imx-8.19.bin
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
 
 Build U-Boot for SD card
 ------------------------
@@ -57,15 +61,17 @@ Copy binaries
 
    $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
    $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
-   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
 
 Build U-Boot
 ^^^^^^^^^^^^
 
 .. code-block:: bash
 
-   $ make phycore-imx8mp_defconfig
-   $ make flash.bin
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          phycore-imx8mp_defconfig \
+          flash.bin
 
 Flash SD card
 ^^^^^^^^^^^^^

-- 
2.43.0

